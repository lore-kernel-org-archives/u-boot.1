Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0764AE7718B
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 22:27:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5D1C80463;
	Fri, 20 Dec 2024 23:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PS1//dzr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED1EC80423; Fri, 20 Dec 2024 23:26:26 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 675FD80435
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 23:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6d91653e9d7so20612156d6.1
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 14:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734733583; x=1735338383; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gU2l65IQTCgxyzfoHhSclAMqqUdMH56oxswudDdh37M=;
 b=PS1//dzrARYkkV9AI+WoVcboqKDf1QSDvWV6WS9w9kHrrP6xRB9k3UhkJIbW9jIDCJ
 17GrcALLQ2JY/pk3AX9/sKI+SL3+cIdNfGhUfNIauJfQiL54MXzVeDxcQkpc5E9H0Hp9
 qB+DYLim4sRXNkeNf1QxM2Lal39996dZF+e+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734733583; x=1735338383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gU2l65IQTCgxyzfoHhSclAMqqUdMH56oxswudDdh37M=;
 b=QLAX257ulUwS7SJ8Kn+ZTCDgRwAssF0N5gco7jgZnQpZOjH0doA+6znEN+n8ntVvBX
 8vdPmN2ujDo7qXTFP12yetgzM10XDA6b5bJPERfGuDapYMpnaTlgLXBKvoQu/Z4sRLJ2
 ybpv2DuePuBVXAiKVWQUTLlPW6q8mu4mWiyebtAHPcmJAY+ZW52oPimGH1SP4nXESheU
 my1il16tNmUMFSMQXYWAdoODjspFBiTTYRXSQgt6NNP2hjbAZNi6htjJK1ZSakkZBjcc
 ZG7zugaqsjsiZGMOvvf/HLPhlmczAEmbKWvQQ4JZL6HWEqgqhZs70QJ7Z3xppJTW9miR
 YITA==
X-Gm-Message-State: AOJu0YwrHqINddMAW6ApoWsx+t03RdMAKXdcII3hji3aInUPttkBJqId
 YwnZTDRAa5RJ26EbMg9pcfQ1pjgYGZ9A2neYUnNg3ez0IMRS69cjU4CNkRo55bcHoHX4BZWs3q1
 OOCE=
X-Gm-Gg: ASbGncuIh3wEXh9iB+cXlB72v5Bo0ApIUU6Bd8jNvY3Bcsaq/FUt6WIWGJbtcygDoj2
 pTaDuQ2FM6rN2pYgOhQ0YJKR5bIl9aN7OKst9n9rjFRK+mADLI3V2kTFu4c94Yh+2PnAUM/y9uC
 /iB0HVgZLQcSixTGPiuwkX3OXVnIV/h2ajOQID9Q/WQp4AmKv+sIsBWSLDQPJakbRpW12LjkAWk
 GL8O8pF8QsuW7GJC9i2lqeUxxRKAY3yQ9o5B08pltspPGxQUlanU0XHNzxv1K6secCIBn8G2NGw
 O+Y=
X-Google-Smtp-Source: AGHT+IF8y8u91YvbmHhGNpxzQTCNQBobCFJtkXXD89d+GXlgPGbrcfzF2iDFApsdYgECrhXf6RnHJQ==
X-Received: by 2002:a05:6214:c4f:b0:6cb:20b6:f398 with SMTP id
 6a1803df08f44-6dd2334c4c4mr72317026d6.21.1734733583271; 
 Fri, 20 Dec 2024 14:26:23 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb4desm21055606d6.87.2024.12.20.14.26.21
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 14:26:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 4/6] blk: Make block subsystems select BLK
Date: Fri, 20 Dec 2024 16:22:20 -0600
Message-ID: <20241220222612.1757884-5-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220222612.1757884-1-trini@konsulko.com>
References: <20241220222612.1757884-1-trini@konsulko.com>
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

The BLK symbol has a few meanings, one of which is that it controls the
driver model portion of a "block device". Rather than having this hidden
symbol be "default y if ..." it should be select'd by the various block
subsystems.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/ata/Kconfig    | 2 ++
 drivers/block/Kconfig  | 7 +++----
 drivers/mmc/Kconfig    | 1 +
 drivers/nvme/Kconfig   | 1 +
 drivers/scsi/Kconfig   | 1 +
 drivers/usb/Kconfig    | 1 +
 drivers/virtio/Kconfig | 1 +
 7 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 4fbb63a148ac..29ceab849c02 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1,6 +1,7 @@
 config AHCI
 	bool "Support SATA controllers with driver model"
 	depends on DM
+	select BLK
 	help
 	  This enables a uclass for disk controllers in U-Boot. Various driver
 	  types can use this, such as AHCI/SATA. It does not provide any standard
@@ -9,6 +10,7 @@ config AHCI
 
 config SATA
 	bool "Support SATA controllers"
+	select BLK
 	help
 	  This enables support for SATA (Serial Advanced Technology
 	  Attachment), a serial bus standard for connecting to hard drives and
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 5283d8981e09..cc75bad02b8c 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -1,8 +1,5 @@
 config BLK
-	bool # "Support block devices"
-	depends on DM
-	def_bool y if MMC || USB || SCSI || NVME || IDE || AHCI || SATA
-	def_bool y if EFI_MEDIA || VIRTIO_BLK || PVBLOCK
+	bool
 	help
 	  Enable support for block devices, such as SCSI, MMC and USB
 	  flash sticks. These provide a block-level interface which permits
@@ -100,6 +97,7 @@ config TPL_BLOCK_CACHE
 config EFI_MEDIA
 	bool "Support EFI media drivers"
 	default y if EFI || SANDBOX
+	select BLK
 	help
 	  Enable this to support media devices on top of UEFI. This enables
 	  just the uclass so you also need a specific driver to make this do
@@ -139,6 +137,7 @@ endif  # EFI_MEDIA
 
 config IDE
 	bool "Support IDE controllers"
+	select BLK
 	help
 	  Enables support for IDE (Integrated Drive Electronics) hard drives.
 	  This allows access to raw blocks and filesystems on an IDE drive
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 46513db0d6e3..4827834b4aab 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -3,6 +3,7 @@ menu "MMC Host controller Support"
 config MMC
 	bool "MMC/SD/SDIO card support"
 	default ARM || PPC || SANDBOX
+	select BLK
 	select DM_MMC
 	help
 	  This selects MultiMediaCard, Secure Digital and Secure
diff --git a/drivers/nvme/Kconfig b/drivers/nvme/Kconfig
index 73edb3551606..d138867666bd 100644
--- a/drivers/nvme/Kconfig
+++ b/drivers/nvme/Kconfig
@@ -4,6 +4,7 @@
 
 config NVME
 	bool "NVM Express device support"
+	select BLK
 	help
 	  This option enables support for NVM Express devices.
 	  It supports basic functions of NVMe (read/write).
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 7e21c4ae2bb8..fc87d34cca39 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1,5 +1,6 @@
 config SCSI
 	bool "Support SCSI controllers with driver model"
+	select BLK
 	help
 	  This enables support for SCSI (Small Computer System Interface),
 	  a parallel interface widely used with storage peripherals such as
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 960b6a906ac4..99c6649e4178 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -1,5 +1,6 @@
 menuconfig USB
 	bool "USB support"
+	select BLK
 	---help---
 	  Universal Serial Bus (USB) is a specification for a serial bus
 	  subsystem which offers higher speeds and more features than the
diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 1de68867d52e..512ac376f185 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -64,6 +64,7 @@ config VIRTIO_NET
 config VIRTIO_BLK
 	bool "virtio block driver"
 	depends on VIRTIO
+	select BLK
 	help
 	  This is the virtual block driver for virtio. It can be used with
 	  QEMU based targets.
-- 
2.43.0

