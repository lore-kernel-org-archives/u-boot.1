Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4DBE784BC
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E342871A1;
	Mon,  2 Oct 2023 17:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="k+Rw2kE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F3DF871A4; Mon,  2 Oct 2023 17:21:57 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3746287166
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 17:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=detlev.casanova@collabora.com
Received: from arisu.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: detlev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 06F5F66072FB;
 Mon,  2 Oct 2023 16:21:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1696260114;
 bh=EqIyP2UhJZzxjwwxeCw9Wl1XPDmwHlIB6At+XArRi98=;
 h=From:To:Cc:Subject:Date:From;
 b=k+Rw2kE5dL8e9tUF0H2ewcdf9oT/uVyor43KtBYs0OkaxoGUOurnhyVtMkIppXej5
 onJcK2Ypgoh4lZkJR6i3BNF9IhxxiDvQs7aEaL/IC+Oux+Obpw1O8CBDjc4PR3D8yW
 cedt3PYCyZHor00/HZTXLJs70CbBWooOwwHfl4KyR2++eJGLPrRxjN2KP2xr4y+NjS
 JNkj0ymsvlBFDfT+Y6QLiysdGDEV4Dg8RHN231jt9W2ah0Rd7CT6R1RoQacqS2h97l
 miuquKZN7wIge488K+522VLw7aBlt/83/0A7TnG7qiB3wC8IU8W8g/02dXZh9XR4MK
 3j5ZyoLPskgCA==
From: Detlev Casanova <detlev.casanova@collabora.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Tam Nguyen <tam.nguyen.xa@renesas.com>,
 Simon Glass <sjg@chromium.org>,
 Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v5 0/6] Introduce the sysinfo command
Date: Mon,  2 Oct 2023 11:20:04 -0400
Message-ID: <20231002152142.76516-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
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

The command can be used to show various information that can be used to
identify the running system.

Currently supported subcommands are:
* model: A string representing the model
* id: The id of the board
* revision: The revision of this board.

Changes since v4:
 - Use less snprintf calls in drivers/sysinfo/rcar3.c
 - Rebase on master
Changes since v3:
 - Fix documentation typo.
Changes since v2:
 - Fix code style.
 - Use printf() instead of debug().
 - Clarify sysinfo new ids types (int).
 - Add a test for sysinfo command.
 - Add documentation for sysinfo command.
Changes since v1:
 - Removed shell function to select linux device tree. This will be
   distributions job.
 - Break revision in rev_major and rev_minor in the sysinfo driver.

Detlev Casanova (6):
  sysinfo: Add IDs for board id and revision
  cmd: Add a sysinfo command
  sysinfo: Add a test
  sysinfo: Add documentation
  sysinfo: rcar3: Use int instead of char for revision
  sysinfo: rcar3: Implement BOARD_ID and BOARD_REV_*

 cmd/Kconfig               |   6 ++
 cmd/Makefile              |   1 +
 cmd/sysinfo.c             | 133 ++++++++++++++++++++++++++++++++++++++
 configs/sandbox_defconfig |   1 +
 doc/usage/cmd/sysinfo.rst |  56 ++++++++++++++++
 drivers/sysinfo/rcar3.c   | 110 +++++++++++++++++++++----------
 drivers/sysinfo/sandbox.c |  17 +++++
 include/sysinfo.h         |   5 ++
 test/cmd/Makefile         |   1 +
 test/cmd/test_sysinfo.c   |  51 +++++++++++++++
 10 files changed, 347 insertions(+), 34 deletions(-)
 create mode 100644 cmd/sysinfo.c
 create mode 100644 doc/usage/cmd/sysinfo.rst
 create mode 100644 test/cmd/test_sysinfo.c

-- 
2.41.0

