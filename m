Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F21C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 21:36:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04D3980717;
	Wed, 15 Jan 2025 22:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="POyrwZBb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54E4B80657; Wed, 15 Jan 2025 16:32:03 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50CBF8033D
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 16:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=parkch98@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2f43d17b0e3so11819636a91.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 07:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736955116; x=1737559916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DLGShLw7FnA7jCeWRX2FmnAwQIHhzI0H311VyO1AQks=;
 b=POyrwZBbOyiBY5I4BEmu+hm03wf6w/+Hke+eDwm29GlgRFC2XlIjMKYYqsCfV3hy06
 mjzjn9HcJFxMC90dGIAOtK6Ez+hvEsJzKVLgM82U0DW6ER7UQYHFt6U9b1ds78eE0Hex
 Wja7D1P4daguKucUCilsJnaehbXj/jjKwMLj8yMVl9m7ISwdK8ZZ0is3e0vU6ekqKv97
 VlMG4HM5n4fabS7hMP/VZgNKN7kt+rh9F4rdeBXS5/HQ27xFU8kWh+1kSZoIMLFLjOSt
 CLqc80w5/+BmEKfHE0pU3sLJUlGa695Cazh+DYVcxrgOYLPk0IHb2ytikNaHOlcArZMn
 7O8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736955116; x=1737559916;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DLGShLw7FnA7jCeWRX2FmnAwQIHhzI0H311VyO1AQks=;
 b=mAGRifBWGsd8UuR3e8N29xt3CPK9VYWtqmQ8X+HOb4O1UqsUHAMvTvTk3Rgox8n4L7
 /ZdmkwQnJeGjtfRr+XOdTbHbG19S7Ks7KKkWvXwkPjTI+DcI9LdGVxc1xDycnuVj83It
 /VPIlaDs7CMq3a+pEtrmLB2dqJM/X5QkEt8JKd+rlCpU6Pv5PSNLf4Sn2mw36k1JEBwQ
 kNGxTxJb0vmDCu0369OeRow4zwiRt34lcEsRQW1Eg/DFcqLkMJvuW6NEDE9vJG2+/fZy
 6Dg66LjMcQ1d+65pjg65dZO7z+AUSFS8L+I9SLgNUZ9S9M1MgyojwVmazair3bqQ0r7c
 qpHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMLTigSPI6GH6NJJ85TkCz8a09UwgBiHQ/Ue5GVq2q6quPjM59odM2KxhW6Z1ScinbU4UcrVE=@lists.denx.de
X-Gm-Message-State: AOJu0YzQ/Nrwt6AXqyS8U9lCaccoJS9YyIvlofNg0ysbxmsFt7DAx3TG
 fSANzLPK1DdTwDNmCBvliLSUwpUKa19G8qwJY+qxDggLQ7X7wLzgkPeSrw==
X-Gm-Gg: ASbGncv3p/Zh2PT+X800etSxdpbB0OIx6ii5REENdeoYbCF8R5kjMErbpDXRnifBYXB
 Ald9/XUwnZj1D9DPS9HX53nz72YdizOivp9BcNuTK+6/oZcP2Aial80+dx6mD2ktYe+wP1nMGTo
 CN/BjXgPFjud4CcQqtaeN/5BH1EPHM7ClErY0MgPof5610fRIVt1V3PpxXtHcqLKgnT7uCVMNzH
 y4jW/3YuE+8FRdjeWWBT4JRzmEwsc8PiMqWp6T0XH3/sKQlNINvev3ZfN4lO1aCr8E=
X-Google-Smtp-Source: AGHT+IGFwnBOTavXOeGKI8bTrWk/K8O6Q1JN75pPvlInfA5pSSjnmJ5Cwj37wzYkG6mlMwPHQE31ew==
X-Received: by 2002:a17:90b:250b:b0:2f6:f107:fae4 with SMTP id
 98e67ed59e1d1-2f6f107fd61mr13439074a91.8.1736955115727; 
 Wed, 15 Jan 2025 07:31:55 -0800 (PST)
Received: from localhost.localdomain ([220.127.31.92])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-21a9f21bd3esm83948635ad.122.2025.01.15.07.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 07:31:55 -0800 (PST)
From: Chanho Park <parkch98@gmail.com>
To: David Feng <fenghua@phytium.com.cn>,
 Linus Walleij <linus.walleij@linaro.org>, Peter Hoyes <Peter.Hoyes@arm.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Chanho Park <parkch98@gmail.com>
Subject: [PATCH] vexpress64: Fix bootargs when building without NET
Date: Thu, 16 Jan 2025 00:31:48 +0900
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
Message-ID: <20250115153148.Fv82Qw252ue4N0CpUnyuRb5rsla-JPV8AhHLDH30Uxs@z>

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

