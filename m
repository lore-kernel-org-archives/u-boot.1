Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E523EE49A5
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 21:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9436186C9F;
	Sat, 19 Aug 2023 23:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jDDQE2Ij";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7177E86EF7; Sat, 19 Aug 2023 23:23:24 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90D7586C58
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 23:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-790a590237aso75259039f.3
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 14:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692480199; x=1693084999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KMgLVwW+yCQMIjyVBsdgTLS/l1b6gl6ACRyyjBjz88w=;
 b=jDDQE2IjNvB6MlQsF2fK3thTgQxnP+tFv+PVn6nYvgJWnM9g+CZ16iuUoKtbjgKVlh
 LqU4khOwwEU9HLs6zQVGi7UDjfJDOG1P2FtF0VjqAK343WRgZ4R0vscYkTXUx9Z+9tgP
 ODK9M7aak1Vh6mEfdn8UA9ofYMrTb7dxR+K60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692480199; x=1693084999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KMgLVwW+yCQMIjyVBsdgTLS/l1b6gl6ACRyyjBjz88w=;
 b=SGjxacw65eKU24MP9ntd4V+YKi9Ma5zXCA9Q0N2csdSNEE/Kh2MRGGvKv2t5QUYeqc
 4n1qMfbD0NYVdTWHG39kffDgEBNA4TLFzM84Teh0OSJBkFDpKTQ9diQO2ZJvDbzoHsgH
 k6Jw/TmBejqY+3HLOvy4LXD37QgY/mkI73hwwTQIkEtSGQwwbKZCrloUV1UTfeIQY6GX
 w3osc3hWTQVREwy/TkHdE6CpnuGWraS2w2y6wcTzLgbRYY5sV4cT67CniBgsBCRJkS6F
 VArpZ+I9PdaYf+xt5IeNWCQ1kfw/+S8YKexXgfwUckW7HjI/1Nl+uWbsOB48FdBP79qj
 i8DA==
X-Gm-Message-State: AOJu0YyTnX1Iqpdk15PHJR9huu1JRwQk4qF7ueG09kgr6KGyjSXNMkfk
 vRlsQGsuE3d2Q4sog2WncHL9gu5gOdAz0VPeb8k=
X-Google-Smtp-Source: AGHT+IHwEgBHSSgPHMvbtgQpa/b3voQw0xNGAXDCBGIMZPHY9HSLfkgaFdJlKhw1hrf+GxvCnbeQ3Q==
X-Received: by 2002:a5e:8811:0:b0:790:a23b:1dfc with SMTP id
 l17-20020a5e8811000000b00790a23b1dfcmr4217864ioj.9.1692480199212; 
 Sat, 19 Aug 2023 14:23:19 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a6bec16000000b00786f5990435sm1507256ioh.7.2023.08.19.14.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 14:23:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 01/19] x86: coreboot: Add IDE and SATA
Date: Sat, 19 Aug 2023 15:22:39 -0600
Message-ID: <20230819212309.1094440-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230819212309.1094440-1-sjg@chromium.org>
References: <20230819212309.1094440-1-sjg@chromium.org>
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

Add these options to permit access to more disk types.

Add some documentation as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/coreboot64_defconfig    |  1 +
 configs/coreboot_defconfig      |  9 +++++++++
 doc/board/coreboot/coreboot.rst | 20 ++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 8aadaa68c279..ded0e6f2422d 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -26,6 +26,7 @@ CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_IDE=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
+CONFIG_CMD_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index 8e11de663819..56cc542df6c6 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -22,8 +22,10 @@ CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_LAST_STAGE_INIT=y
 CONFIG_PCI_INIT_R=y
+CONFIG_CMD_IDE=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
+CONFIG_CMD_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
@@ -48,6 +50,13 @@ CONFIG_USE_ROOTPATH=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 # CONFIG_ACPIGEN is not set
+CONFIG_SYS_IDE_MAXDEVICE=4
+CONFIG_SYS_ATA_DATA_OFFSET=0
+CONFIG_SYS_ATA_REG_OFFSET=0
+CONFIG_SYS_ATA_ALT_OFFSET=0
+CONFIG_ATAPI=y
+CONFIG_LBA48=y
+CONFIG_SYS_64BIT_LBA=y
 CONFIG_NVME_PCI=y
 # CONFIG_PCI_PNP is not set
 CONFIG_SOUND=y
diff --git a/doc/board/coreboot/coreboot.rst b/doc/board/coreboot/coreboot.rst
index d660a223d9c8..be5b0de5495e 100644
--- a/doc/board/coreboot/coreboot.rst
+++ b/doc/board/coreboot/coreboot.rst
@@ -41,6 +41,26 @@ At present it seems that for Minnowboard Max, coreboot does not pass through
 the video information correctly (it always says the resolution is 0x0). This
 works correctly for link though.
 
+You can run via QEMU using::
+
+  qemu-system-x86_64 -bios build/coreboot.rom -serial mon:stdio
+
+The `-serial mon:stdio` part shows both output in the display and on the
+console. It is optional. You can add `nographic` as well to *only* get console
+output.
+
+To run with a SATA drive called `$DISK`::
+
+  qemu-system-x86_64 -bios build/coreboot.rom -serial mon:stdio \
+	-drive id=disk,file=$DISK,if=none \
+	-device ahci,id=ahci \
+	-device ide-hd,drive=disk,bus=ahci.0
+
+Then you can scan it with `scsi scan` and access it normally.
+
+To use 4GB of memory, typically necessary for booting Linux distros, add
+`-m 4GB`.
+
 64-bit U-Boot
 -------------
 
-- 
2.42.0.rc1.204.g551eb34607-goog

