Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82560C369DC
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 04:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F0ED8210D;
	Wed,  7 May 2025 06:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="I/kX8DdU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07AB982114; Wed,  7 May 2025 06:17:30 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94FF18007D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 06:17:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (unknown [213.157.19.135])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 00D183F2BA; 
 Wed,  7 May 2025 04:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746591445;
 bh=nsAwkgKfrSTqReANT5om2m6cz1EXAvqXwP1ju0cNyZE=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=I/kX8DdUluAMcPRf2qPtbBSFcY2l9yOZ6gZqWexTPynv0oRmyISeJAuI8Ugzu01NI
 DMYWGfUtx4+gvTpXGZX4BeKuhPl868/cl6x191laAStidZd7/JfqaHCPUK5okcDso/
 e1CJHdk1u/NlIj0eqrIz/ePR7WXbn6+TI+ADFdZcmViSpKb1ed3b0JrsPqyVy2mPkO
 nN5oPiQY0gsr2abeflbCPzVjc2+EDUq9gSKIGPpKtv46KqUTmIbV6lrqSDpOCuon0F
 +Iqt1BsEXDdV4ag8oJhLagbLUD5FFxycVQQv4yvxf+VSoefvTo4MEMcRio9UbqqcUz
 S3qbsNf8EUqaA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Sean Anderson <sean.anderson@seco.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: RISC-V supports semihosting
Date: Wed,  7 May 2025 06:17:16 +0200
Message-ID: <20250507041716.27564-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Mention that RISC-V supports semihosting.

Update SPDX identifier to current format.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/usage/semihosting.rst | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/doc/usage/semihosting.rst b/doc/usage/semihosting.rst
index 9303a6364d5..dfd6c58222a 100644
--- a/doc/usage/semihosting.rst
+++ b/doc/usage/semihosting.rst
@@ -1,14 +1,17 @@
-.. SPDX-License-Identifier: GPL-2.0+
+.. SPDX-License-Identifier: GPL-2.0-or-later
 .. Copyright 2014 Broadcom Corporation.
 
 Semihosting
 ===========
 
-Semihosting is ARM's way of having a real or virtual target communicate
-with a host or host debugger for basic operations such as file I/O,
-console I/O, etc. Please see `Arm's semihosting documentation
-<https://developer.arm.com/documentation/100863/latest/>`_ for more
-information.
+Semihosting is a technique to let a real or virtual target communicate with a
+host or host debugger for basic operations such as file I/O, console I/O, etc.
+Originally introduced by ARM it has also been adopted for RISC-V. Please, see
+`Arm's semihosting documentation
+<https://developer.arm.com/documentation/100863/latest/>`_ and
+`RISC-V Semihosting
+<https://drive.google.com/file/d/1qu74D4_EmjGmc03qzfQ7Pf4g6m0fOtcD/view>`_
+for more information.
 
 Platform Support
 ----------------
@@ -40,7 +43,7 @@ Foundation and Base fastmodel simulators.
 QEMU
 ^^^^
 
-Another ARM emulator which supports semihosting is `QEMU
+Another emulator which supports semihosting is `QEMU
 <https://www.qemu.org/>`_. To enable semihosting, enable
 ``CONFIG_SERIAL_PROBE_ALL`` when configuring U-Boot, and use
 ``-semihosting`` when invoking QEMU. Adding ``-nographic`` can also be
@@ -53,8 +56,8 @@ running QEMU, refer to the :doc:`board documentation
 OpenOCD
 ^^^^^^^
 
-Any ARM platform can use semihosting with an attached debugger. One such
-debugger with good support for a variety of boards and JTAG adapters is
+Any ARM or RISC-V platform can use semihosting with an attached debugger. One
+such debugger with good support for a variety of boards and JTAG adapters is
 `OpenOCD <https://openocd.org/>`_. Semihosting is not enabled by default,
 so you will need to enable it::
 
-- 
2.48.1

