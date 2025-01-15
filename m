Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE852C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 21:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A426E8070C;
	Wed, 15 Jan 2025 22:36:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QxDvsNJI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86B8680657; Wed, 15 Jan 2025 16:23:10 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3607C8033D
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 16:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=parkch98@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21636268e43so163071325ad.2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 07:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736954587; x=1737559387; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DLGShLw7FnA7jCeWRX2FmnAwQIHhzI0H311VyO1AQks=;
 b=QxDvsNJIoGFqm0pqW8+yiIWzuIHsrQBM81BKGv62sknSr7xMRwsnMCzP/spFXFJjaz
 iJFKozzbqg8vTsbNOKoUaiHA5ZoKQ52Kqw5e/++mVUbrZ3Toh0Q89ncrcrP3XCQZV41C
 1O+7fxO41wGGOqyYYaMESno04c5kTrnPplg3wOc5MNk1hZdpnohPXvBkpdbJ74cwjmuV
 +ykFTGUywDakPTXs3+0ulyGubg8sGiCwJl98Wiyb48BWErMeGmXXHvdzei4v0zRpPi+e
 BsViNO82X9QtQic4buBIjnlHAiYBcplQncir4WhDPqsnnkinIH4T402jg99KGlJ8jhec
 WhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736954587; x=1737559387;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DLGShLw7FnA7jCeWRX2FmnAwQIHhzI0H311VyO1AQks=;
 b=LK+69AlF3/3Fa6tPVH5O6xm6CIRXD/loT2JLelJO4k945InCNSxGR9hDJvk6ls0/5w
 PjzxXq1rZKMymUCFbcJ8rfdNfELWLTeWsZ+qXscqmNX3F5HSbBAt7kQIPE5/x7/M6L/2
 5hCJ+XdW526Ki4raBYMu1ya9GU5hIMDaS3o0lvLzHZUU6aS2zgQ+80wHIYtpVavv5Afm
 nbgvIRNJ+p5m3iWz4zYis3GB21LbN0iy+vNVRTnJt+uTi5BX56YFfGm44BnuB0WiisiY
 6umzEsWsok9kYUIAYMn8oYbUp8pAYRuEbWhjsaXqeTgWvbSFdWtunGJEHVcokSVLo0ns
 hEMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3Fak9Dmzf60+AEc2ps2G1/rrPiK34vw8/MCIEGxIRYaqCqj9BrWMmX1ti2/9M9igHaUggZmY=@lists.denx.de
X-Gm-Message-State: AOJu0YzwDdwp2dIjF8YTgV4kCUV9ShsGu6xIHPWQFwYtHKGwsdhYNJhJ
 oEdavZM81wTMS4+3yuZyI6FtZKXjv8oB2MNT3TwoXvQBqo0aQm0g
X-Gm-Gg: ASbGncux97eGbVgJUHylJ09oQJildQIg4dKpDN/rJAaagpLXcLShVlD5H9/QrSCKUBF
 ZgC1rfiMrRk2j27e3f0o8sOQwhv16SgkUEdY/nMLhmW3Q4HhEU2KMJTGZ2127lN0yy/OX+SBYA6
 Mh0zZZ535WoDgRjQ1b7CDquvtbO42dtxcBDP9ne77bYiQgqbee+q34EN6idv5pyUlGSqriZM+L+
 YnCzIAb8ymHTlqlNS0KOQL4AZEBBw6Ls32Lt17zjey67zm2mMRLjB6gW3FrWCjOtp8=
X-Google-Smtp-Source: AGHT+IH5IveuBU4ktcojbZKHZQC2ZSo9ODiWiazNCiS833GudQ7v+6Ki6WJMm0p2S+tbFGJO+rGwnA==
X-Received: by 2002:a17:902:d50e:b0:215:8695:ef91 with SMTP id
 d9443c01a7336-21a83f469ebmr375662195ad.6.1736954586561; 
 Wed, 15 Jan 2025 07:23:06 -0800 (PST)
Received: from localhost.localdomain ([220.127.31.92])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-21a9f234977sm83919855ad.204.2025.01.15.07.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 07:23:06 -0800 (PST)
From: Chanho Park <parkch98@gmail.com>
To: David Feng <fenghua@phytium.com.cn>,
 Linus Walleij <linus.walleij@linaro.org>, Peter Hoyes <Peter.Hoyes@arm.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Chanho Park <parkch98@gmail.com>
Subject: [PATCH] vexpress64: Fix bootargs when building without NET
Date: Thu, 16 Jan 2025 00:22:44 +0900
Message-ID: <3d64bf095ad00a79e185ad034c0a8accdb9f2a15.1736954361.git.parkch98@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 15 Jan 2025 22:36:25 +0100
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

When building without DHCP/PXE configurations (NET disabled),
compilation errors may occur due to mismatched bootargs.
Ensure bootargs related to DHCP/PXE are not enabled if the
corresponding commands are disabled.

include/config_distro_bootcmd.h:443:9: error: expected ‘}’ before
‘BOOT_TARGET_DEVICES_references_PXE_without_CONFIG_CMD_DHCP_or_PXE’
  443 |         BOOT_TARGET_DEVICES_references_PXE_without_CONFIG_CMD_DHCP_or_PXE
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Chanho Park <parkch98@gmail.com>
---
 include/configs/vexpress_aemv8.h | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/configs/vexpress_aemv8.h b/include/configs/vexpress_aemv8.h
index 8020689e39ee..b5a17f93efca 100644
--- a/include/configs/vexpress_aemv8.h
+++ b/include/configs/vexpress_aemv8.h
@@ -154,6 +154,18 @@
 #define FUNC_MMC(func)
 #endif
 
+#if CONFIG_IS_ENABLED(CMD_PXE)
+#define BOOT_TARGET_PXE(func) func(PXE, pxe, na)
+#else
+#define BOOT_TARGET_PXE(func)
+#endif
+
+#if CONFIG_IS_ENABLED(CMD_DHCP)
+#define BOOT_TARGET_DHCP(func) func(DHCP, dhcp, na)
+#else
+#define BOOT_TARGET_DHCP(func)
+#endif
+
 /*
  * Boot by loading an Android image, or kernel, initrd and FDT through
  * semihosting into DRAM.
@@ -188,8 +200,8 @@
 	func(SATA, sata, 0)		\
 	func(SATA, sata, 1)		\
 	FUNC_VIRTIO(func)		\
-	func(PXE, pxe, na)		\
-	func(DHCP, dhcp, na)		\
+	BOOT_TARGET_PXE(func)		\
+	BOOT_TARGET_DHCP(func)		\
 	func(AFS, afs, na)
 
 #define VEXPRESS_KERNEL_ADDR		0x80080000
@@ -212,8 +224,8 @@
 	func(MEM, mem, na)		\
 	FUNC_VIRTIO(func)		\
 	FUNC_MMC(func)			\
-	func(PXE, pxe, na)		\
-	func(DHCP, dhcp, na)
+	BOOT_TARGET_PXE(func)		\
+	BOOT_TARGET_DHCP(func)
 
 #define VEXPRESS_KERNEL_ADDR		0x80080000
 #define VEXPRESS_PXEFILE_ADDR		0x8fa00000
@@ -234,8 +246,8 @@
 #define BOOT_TARGET_DEVICES(func)	\
 	func(MEM, mem, na)		\
 	FUNC_VIRTIO(func)		\
-	func(PXE, pxe, na)		\
-	func(DHCP, dhcp, na)
+	BOOT_TARGET_PXE(func)		\
+	BOOT_TARGET_DHCP(func)
 
 #define VEXPRESS_KERNEL_ADDR		0x00200000
 #define VEXPRESS_PXEFILE_ADDR		0x0fb00000
-- 
2.43.0

