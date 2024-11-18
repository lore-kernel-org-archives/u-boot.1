Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950A4D591AE
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 19:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D65489248;
	Mon, 18 Nov 2024 20:36:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YKXj9HBh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6D3F88E6B; Mon, 18 Nov 2024 20:36:02 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B9D388E6B
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 20:36:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20cbca51687so20855325ad.1
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 11:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731958559; x=1732563359; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bB8ezXzUzHfezRhImY+pYMv5CIadMoHPdEjUwEQ4RHI=;
 b=YKXj9HBhLAR7SJn4DyKj5YGANc5i1d6hC9Ea+u81Wn+kR1k/7d9hn4KzqMh8XInLHA
 vGYBueKfWFxCp3nKExenQ0BtC7HhnxEr9kCpbJr3RmH1JDe5CuohobxO3rcObGCMIw/h
 +g2V6BRJAGT/Tde5/0ubSq9/b1yR1kbMumr/512aZKwQSeC9YetNqyXvIF3JEMTwwrLm
 b/jNGSQpqVJTbYXKzpLpXGfTomUCv6mub58of+7Q/fV2ebhHr2FlDu7uv5MMt4KDENvi
 4JgMiVwFFMhOnO3w/XHplA3dwHUR+VN9bQo71U+IGHdli/LDLHV7WL/rsDNbpNg1N0bj
 0xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731958559; x=1732563359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bB8ezXzUzHfezRhImY+pYMv5CIadMoHPdEjUwEQ4RHI=;
 b=ViNczr9T3IzQjtKawuECTN+5Ii4UL/ivAsulL0Q+J7yGewfus5j6vkQ/HxcO9IoDRP
 wY0Ai38VVK5kkXUHK2AawAH0FbUR/HnHIL3b85sUKhhy0JCwV87hU5exk6bwsaXjJeLC
 kz0tcd8gjJohXkbgB7ASUvIO9hSjbiE6OM1vyuusEX38yrU5WEk660ceHHMTVMDoHt8b
 gZXWAptvLgBP3R13zPtoqAqcFl7bzy2edg1DztkrGjp1NfjfSaCm7BYc/P3yhH3xwgYa
 cU+eI90zcFj7DPOhXwlUdIPSmrWETmbOCIoEl1tDKGdAaXN3JetgIpmSO9+MV2SwuhQM
 9Khw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUrSKnnvWln9JRBt1YfU0BxEr7m0zQQuA27m8+Xm6VsxfXXxVXqoVYp3dnlwB39h2w3WmkLuE=@lists.denx.de
X-Gm-Message-State: AOJu0YwHO33lEadBRztL2nIurG3Wm6il0zRHIPjpLNSr5q6WSKqQ3H/m
 K9s0F+J+/I/AYVtKd7EzD7KT+EQ6XqGfcmev0eVh19T2OkdgAH5M
X-Google-Smtp-Source: AGHT+IHx00NFpQYM0w7fPTq2idxSkZStvHVOyMD2Uq2Enc7VOFufD8zQun3cN7TXLDJuKOxikrxPSA==
X-Received: by 2002:a17:903:440f:b0:212:4d01:d43a with SMTP id
 d9443c01a7336-2124d01d6cfmr4383515ad.48.1731958558648; 
 Mon, 18 Nov 2024 11:35:58 -0800 (PST)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0f8c2c0sm60706805ad.182.2024.11.18.11.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 11:35:57 -0800 (PST)
From: Tony Dinh <mibodhi@gmail.com>
To: Stefan Roese <sr@denx.de>
Cc: Tony Dinh <mibodhi@gmail.com>, Dave Purdy <david.c.purdy@gmail.com>,
 Evgeni Dobrev <evgeni@studio-punkt.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Phil Sutter <phil@nwl.cc>,
 Siddarth Gore <gores@marvell.com>,
 Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH] arm: mvebu: Disable JFFS2 support for Kirkwood and Armada XP
 boards
Date: Mon, 18 Nov 2024 11:34:59 -0800
Message-Id: <20241118193459.10687-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.5
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

These boards don't use JFFS2 file system for booting so remove it.

Ref: https://lore.kernel.org/u-boot/20241114233005.GN3600562@bill-the-cat/T/#t
Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 configs/dns325_defconfig     | 1 -
 configs/dockstar_defconfig   | 1 -
 configs/ds414_defconfig      | 1 -
 configs/goflexhome_defconfig | 1 -
 configs/guruplug_defconfig   | 1 -
 configs/iconnect_defconfig   | 1 -
 configs/nas220_defconfig     | 3 ---
 configs/nsa310s_defconfig    | 1 -
 configs/nsa325_defconfig     | 3 ---
 configs/pogo_e02_defconfig   | 1 -
 configs/pogo_v4_defconfig    | 3 ---
 11 files changed, 17 deletions(-)

diff --git a/configs/dns325_defconfig b/configs/dns325_defconfig
index 323e2f5d4c..1ba02e0595 100644
--- a/configs/dns325_defconfig
+++ b/configs/dns325_defconfig
@@ -33,7 +33,6 @@ CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
-CONFIG_CMD_JFFS2=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:896k(u-boot),128k(u-boot-env),5m(kernel),-(rootfs)"
diff --git a/configs/dockstar_defconfig b/configs/dockstar_defconfig
index e35ca165d0..941156750a 100644
--- a/configs/dockstar_defconfig
+++ b/configs/dockstar_defconfig
@@ -33,7 +33,6 @@ CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
-CONFIG_CMD_JFFS2=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:1m(uboot),-(root)"
diff --git a/configs/ds414_defconfig b/configs/ds414_defconfig
index 25e5be3ba7..44e9b17682 100644
--- a/configs/ds414_defconfig
+++ b/configs/ds414_defconfig
@@ -49,7 +49,6 @@ CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_TIME=y
-CONFIG_CMD_JFFS2=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
 CONFIG_ENV_OVERWRITE=y
diff --git a/configs/goflexhome_defconfig b/configs/goflexhome_defconfig
index af758fcc43..add4a24a31 100644
--- a/configs/goflexhome_defconfig
+++ b/configs/goflexhome_defconfig
@@ -35,7 +35,6 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
-CONFIG_CMD_JFFS2=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:1m(uboot),6M(uImage),-(root)"
diff --git a/configs/guruplug_defconfig b/configs/guruplug_defconfig
index 0fab4c38e0..540b9184b3 100644
--- a/configs/guruplug_defconfig
+++ b/configs/guruplug_defconfig
@@ -35,7 +35,6 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
-CONFIG_CMD_JFFS2=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:896K(uboot),128K(uboot_env),-@1M(root)"
diff --git a/configs/iconnect_defconfig b/configs/iconnect_defconfig
index 9d195e1cf2..6ee40e380b 100644
--- a/configs/iconnect_defconfig
+++ b/configs/iconnect_defconfig
@@ -35,7 +35,6 @@ CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
-CONFIG_CMD_JFFS2=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:0x80000@0x0(uboot),0x20000@0x80000(uboot_env),-@0xa0000(rootfs)"
diff --git a/configs/nas220_defconfig b/configs/nas220_defconfig
index 783879d4ee..ca70ee9637 100644
--- a/configs/nas220_defconfig
+++ b/configs/nas220_defconfig
@@ -34,7 +34,6 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
-CONFIG_CMD_JFFS2=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:0xa0000@0x0(uboot),0x010000@0xa0000(env),0x500000@0xc0000(uimage),0x1a40000@0x5c0000(rootfs)"
@@ -66,5 +65,3 @@ CONFIG_SYS_NS16550_REG_SIZE=-4
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_STORAGE=y
-CONFIG_JFFS2_LZO=y
-CONFIG_JFFS2_NAND=y
diff --git a/configs/nsa310s_defconfig b/configs/nsa310s_defconfig
index f6718350d5..9a42c39155 100644
--- a/configs/nsa310s_defconfig
+++ b/configs/nsa310s_defconfig
@@ -30,7 +30,6 @@ CONFIG_CMD_NAND=y
 CONFIG_CMD_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_JFFS2=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:0xe0000@0x0(uboot),0x20000@0xe0000(uboot_env),0x100000@0x100000(second_stage_uboot),-@0x200000(root)"
diff --git a/configs/nsa325_defconfig b/configs/nsa325_defconfig
index c4235eecfb..ab9316340d 100644
--- a/configs/nsa325_defconfig
+++ b/configs/nsa325_defconfig
@@ -42,7 +42,6 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_DNS=y
 # CONFIG_CMD_BLOCK_CACHE is not set
-CONFIG_CMD_JFFS2=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:0x100000(uboot),0x80000(stock_uboot_env),0x80000(key_store),0x80000(info),0xA00000(etc),0xA00000(kernel_1),0x2FC0000(rootfs1),0xA00000(kernel_2),0x2FC0000(rootfs2)"
@@ -73,6 +72,4 @@ CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_PCI=y
 CONFIG_USB_EHCI_HCD=y
-CONFIG_JFFS2_LZO=y
-CONFIG_JFFS2_NAND=y
 CONFIG_UBIFS_SILENCE_MSG=y
diff --git a/configs/pogo_e02_defconfig b/configs/pogo_e02_defconfig
index 50103f375a..50c9292550 100644
--- a/configs/pogo_e02_defconfig
+++ b/configs/pogo_e02_defconfig
@@ -32,7 +32,6 @@ CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
-CONFIG_CMD_JFFS2=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:1M(u-boot),4M(uImage),32M(rootfs),-(data)"
diff --git a/configs/pogo_v4_defconfig b/configs/pogo_v4_defconfig
index fb8036a75e..03b4fd9b2f 100644
--- a/configs/pogo_v4_defconfig
+++ b/configs/pogo_v4_defconfig
@@ -41,7 +41,6 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_DNS=y
 # CONFIG_CMD_BLOCK_CACHE is not set
-CONFIG_CMD_JFFS2=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:2M(u-boot),3M(uImage),3M(uImage2),8M(failsafe),112M(root)"
@@ -73,6 +72,4 @@ CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_PCI=y
 CONFIG_USB_EHCI_HCD=y
-CONFIG_JFFS2_LZO=y
-CONFIG_JFFS2_NAND=y
 CONFIG_UBIFS_SILENCE_MSG=y
-- 
2.39.5

