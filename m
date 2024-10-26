Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77587D10BE3
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 06:41:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CDD189011;
	Sat, 26 Oct 2024 08:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="vzHdTk8Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45C2389011; Sat, 26 Oct 2024 08:41:03 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FD9E88D94
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 08:41:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.c.hoisthospitality.com (unknown [87.215.50.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C2AFB3F391; 
 Sat, 26 Oct 2024 06:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729924860;
 bh=On3OPkhIguMBHEz6y9JxTHgVn6DsHAgDcg1h8qbeSE4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=vzHdTk8YAcdZRXZ6Ky4KMHqDtg52f8z0mixreleyD2xisWeZ6oCm2x6RKg7jpp4d5
 cfBsE6WBEgFEJqPvqVSID6xwd95O4ap+kXI41QZS2LjdYW3wdXojYQp/QlBgrI0Jij
 oic9dbbO/Ij16lgOdQgdAX8HCSLOPZKHXZb/G2QfHlCoTo56mXr3p2YdC1XtB9q/wK
 nJ3KCdkBYHQuykLPuxg2Ysh2uLej0c2Ko0K04eCyCZNSgo5O0PSrwCdMDyyBlIYC7X
 VtMHvusdp/pfpMZlu+9HGE9nZyaS1Bwhi5fumE1CeiQ6FdIFYwpOy8eSKKetUYmZ4I
 3Uf/hBbsCqh8w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/5] fs: ext4: implement opendir, readdir, closedir
Date: Sat, 26 Oct 2024 08:40:43 +0200
Message-ID: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

With this series opendir, readdir, closedir are implemented for ext4.
These functions are needed for the UEFI sub-system to interact with
the ext4 file system.

To reduce code growth the functions are reused to implement the ls
command for ext4.

A memory leak in ext4fs_exists is resolved.

ext4fs_iterate_dir is simplified by removing a redundant pointer copy.

Heinrich Schuchardt (5):
  fs: ext4: simplify ext4fs_iterate_dir()
  fs: ext4: free directory node in ext4fs_exists()
  fs: ext4: implement opendir, readdir, closedir
  efi_loader: fix GetInfo and SetInfo
  fs: ext4: use fs_ls_generic

 fs/ext4/ext4_common.c               |  48 ++------
 fs/ext4/ext4fs.c                    | 177 +++++++++++++++++++++++++---
 fs/fs.c                             |   6 +-
 include/ext4fs.h                    |   4 +
 lib/efi_loader/efi_file.c           |  30 +++--
 test/py/tests/test_env.py           |   2 +-
 test/py/tests/test_fs/test_basic.py |   5 +-
 7 files changed, 197 insertions(+), 75 deletions(-)

-- 
2.45.2

