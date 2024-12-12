Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70627E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 22:08:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5B26801A9;
	Thu, 12 Dec 2024 23:08:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gerz.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gerz.io header.i=@gerz.io header.b="gb4hu9oK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6138801A9; Thu, 12 Dec 2024 23:06:46 +0100 (CET)
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.63.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3588E80196
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 23:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gerz.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=burak@gerz.io
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
 by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4Y8RQC5pGqz62tV;
 Thu, 12 Dec 2024 23:06:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gerz.io; s=key2;
 t=1734041203; bh=PEGp6tOoIOFnd3ihVg/BUNRZMgEM4qC/UVFkTlFQHaw=;
 h=From:To:Cc:Subject:Date:From;
 b=gb4hu9oKOg4kXlquO/4zbhmWaeipRcfrldiRsD3qfRejaMa4fqFGF7fJuwh9qZ5gF
 P8nGAmID5ofPsC85NK9xl/YIJMSR4jUotsHLA2A0MHEU84XUkqkl0wlY849WnOXZA4
 1m13m5AZ6y1WqtzfJezK1V7sCoThXBN9tTceJ9w9x7BbKPU/Je/UZNjj7hwNrf2uJY
 Eph2nJzbTDPEayJOx+Zd0LMlu6W9kV4VhiJQRfLTopLCD5UcGZzCS2ek454YWJmD+y
 egIyB9311Hof/tdSZgfsNU/KDfeR1k9SZVDu9wmXJJuw+8Vg4B0PR1mn1WOzRC6nRd
 XccATNU33nDIA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4Y8RQC53Gcz4xJB;
 Thu, 12 Dec 2024 23:06:43 +0100 (CET)
Received: from mx2e3f.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy02-mors.netcup.net (Postfix) with ESMTPS id 4Y8RQC13Q0z8sb0;
 Thu, 12 Dec 2024 23:06:43 +0100 (CET)
Received: from localhost.localdomain (adsl-84-227-222-208.adslplus.ch
 [84.227.222.208])
 by mx2e3f.netcup.net (Postfix) with ESMTPSA id 1CADA60134;
 Thu, 12 Dec 2024 23:06:37 +0100 (CET)
Authentication-Results: mx2e3f;
 spf=pass (sender IP is 84.227.222.208) smtp.mailfrom=burak@gerz.io
 smtp.helo=localhost.localdomain
Received-SPF: pass (mx2e3f: connection is authenticated)
From: Burak Gerz <burak@gerz.io>
To: u-boot@lists.denx.de
Cc: Daniel.Venzin@mt.com, eballetb@redhat.com, manut@mecka.net, burak@gerz.io,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/2] fs: fat: Implement FAT file rename
Date: Thu, 12 Dec 2024 23:06:27 +0100
Message-ID: <20241212220635.25971-1-burak@gerz.io>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <173404119885.20837.17037298748186851351@mx2e3f.netcup.net>
X-Rspamd-Queue-Id: 1CADA60134
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: uMSxvuDIgQu0Cm3k9rVsS/haOVwHegp+TBRdjs0=
X-Mailman-Approved-At: Thu, 12 Dec 2024 23:08:35 +0100
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

Hello
This patch series is a first implementation for file renaming on a FAT
filesystems. This implementation does a file rename only (no moving
between directories) as needed by bootloaders like systemd-boot [1].

The renaming process is tried to be made as fail-safe as possible, by
  1. Writing the new, empty file
  2. Copying the address of the start cluster into new directory entry
  3. Deleting old file
This can decay in the worst case to a hard link

Additionally, make use of the FAT file rename in /lib/efi_loader

[1] https://www.freedesktop.org/software/systemd/man/latest/systemd-boot.html#Boot%20Counting


Burak Gerz (2):
  efi_loader: enable support for file renaming
  fs: fat: Implement FAT file rename

 fs/fat/fat_write.c        | 99 +++++++++++++++++++++++++++++++++++++++
 fs/fs.c                   | 30 ++++++++++++
 include/fat.h             |  1 +
 include/fs.h              |  2 +
 lib/efi_loader/efi_file.c |  9 ++--
 5 files changed, 137 insertions(+), 4 deletions(-)

-- 
2.45.2

