Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E97DC3600B
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 02:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90C0081D3B;
	Fri, 28 Mar 2025 03:20:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="pVBvu9XQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5339805C8; Thu, 27 Mar 2025 15:39:40 +0100 (CET)
Received: from mx3.securetransport.de (mx3.securetransport.de
 [IPv6:2a01:4f8:c0c:92be::1])
 by phobos.denx.de (Postfix) with ESMTP id 7EF4D81879
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 15:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pzimmermann@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1743086361;
 bh=OfAgSDRGPdnYQ/1PueaPHoBuBbaA89pfaR2gcsvAwCA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=pVBvu9XQsSEClYaD3A3mXiy6JWSOr3BGQyO0doNK7TNl89/zsigGzxACyXigTx4gO
 xZ4iJd7gmOFtLFLtSrum34z2DWg7TtuBO774wsNsy++fHaJvZj007FWPCv1Ix9rWkf
 TBtx+NYQlEpbQDGgd81CAkHBxk9Mv5BX4Ejbn5hP59LHIisANT0NEQvkdnOiFmkhHs
 G2uZMgdX6Ka0LF6ZJ59SdSxD1CO0jgSniM4Cq5S26HPk5tzyO2PsNZxdpALoQof2W4
 2L6O9fUQwsr3HE576UsWk45t4MLTVnBPxbZ972HuV5S+rsm7GRo/IAYtHCkBRTqP8o
 pB94YoXLl2SVg==
From: Pascal Zimmermann <pzimmermann@dh-electronics.com>
To: <u-boot@lists.denx.de>
CC: Pascal Zimmermann <pzimmermann@dh-electronics.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Marek Vasut
 <marex@denx.de>, <u-boot@dh-electronics.com>
Subject: [RESEND PATCH 1/2] config_distro_bootcmd: make possible to substitute
 'part list' in distro_bootcmd
Date: Thu, 27 Mar 2025 15:38:42 +0100
Message-ID: <20250327143843.19358-2-pzimmermann@dh-electronics.com>
X-klartext: yes
In-Reply-To: <20250327143843.19358-1-pzimmermann@dh-electronics.com>
References: <20250327143843.19358-1-pzimmermann@dh-electronics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 28 Mar 2025 03:20:27 +0100
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

Make it possible to substitute the 'part list' command inside
'scan_dev_for_boot_part' with a custom board specific implementation.

For this the new define 'SCAN_DEV_FOR_BOOT_PARTS' is introduced.

Signed-off-by: Pascal Zimmermann <pzimmermann@dh-electronics.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>
Cc: u-boot@dh-electronics.com
---
 include/config_distro_bootcmd.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/config_distro_bootcmd.h b/include/config_distro_bootcmd.h
index 0a4e4b8ff85..df0dc8cfdee 100644
--- a/include/config_distro_bootcmd.h
+++ b/include/config_distro_bootcmd.h
@@ -194,6 +194,11 @@
 #define SCAN_DEV_FOR_EFI
 #endif
 
+#ifndef SCAN_DEV_FOR_BOOT_PARTS
+#define SCAN_DEV_FOR_BOOT_PARTS \
+	"part list ${devtype} ${devnum} -bootable devplist; "
+#endif
+
 #ifdef CONFIG_SATA
 #define BOOTENV_SHARED_SATA	BOOTENV_SHARED_BLKDEV(sata)
 #define BOOTENV_DEV_SATA	BOOTENV_DEV_BLKDEV
@@ -538,7 +543,7 @@
 		"\0"                                                      \
 	\
 	"scan_dev_for_boot_part="                                         \
-		"part list ${devtype} ${devnum} -bootable devplist; "     \
+		SCAN_DEV_FOR_BOOT_PARTS                                   \
 		"env exists devplist || setenv devplist 1; "              \
 		"for distro_bootpart in ${devplist}; do "                 \
 			"if fstype ${devtype} "                           \
-- 
2.30.2

