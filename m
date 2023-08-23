Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E389C3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 21:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 612FC864E6;
	Wed, 23 Aug 2023 23:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KtzjBciE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CE93864E1; Wed, 23 Aug 2023 23:11:12 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BF1D8644F
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 23:11:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-79231a521bbso114635839f.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692825068; x=1693429868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f27k70q48JPemCQbaVKTW3DBQEYuDkQ7erBg3ab4x2A=;
 b=KtzjBciE3gHCo+OrNkoD4Q0jipIOKm3pzDaY+3kg0hgin4qh9II00YjLUgLqhXbKen
 0hJ3+B324u8b7XOyuvIGnlDYWLIUJ+V8elCzSbSNg8aVF96oUmnlDubnuVc0THNzh1uY
 1Ol3OzQfns6BfCTWVM5YUemXVufNBj6OqOOo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692825068; x=1693429868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f27k70q48JPemCQbaVKTW3DBQEYuDkQ7erBg3ab4x2A=;
 b=HzajHitqOGpGOW61dztwMH4t86jnXo4h+I35CM39jt7cNgspJSByyhsyU4rd3iCcW4
 gFGN6KOWsQmUizKQP8rjIoHZtmmBpP03Cn6cQ8nv6fLDTMzIMPEPV5vHhshFdptzaMj/
 KxCDXGv/NaycpF2qrgWfWxdVQNjMZlx6fdS73z6NpeclXvWrPdYfss1mlTtmdMFE9Ki5
 539zrEttIAplTa2ecb/C5+mrPmsVhpgzhuls7XYS0MfL9oFDW3dPME03WgfBTdL595xQ
 JImy4qA/ytz+cF/0ky2kxo8iXIU0hTcxrNDUPbYz9fMOvBBjYrH0PPtVff5tfhLU1qrc
 EYiw==
X-Gm-Message-State: AOJu0YyXGXYc0i4p+lq5AtmEDXLdbZOV9ZyhSN+u2Vk8PiDjUJq3O/K/
 yLdyLnSekll5vGwzF8Xb+NgRJdWjsQ1R9o5/LEk=
X-Google-Smtp-Source: AGHT+IGepgdXPxXf0CU9DEnzkq4vpcujxlbGPmPWGoSLvj7EHME+A9YUwpd48ZriREvULTBJKsbgTg==
X-Received: by 2002:a05:6e02:1d8f:b0:349:191:af05 with SMTP id
 h15-20020a056e021d8f00b003490191af05mr4458995ila.16.1692825068537; 
 Wed, 23 Aug 2023 14:11:08 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a02c9cf000000b0041627abe120sm3921075jap.160.2023.08.23.14.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 14:11:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 01/20] x86: coreboot: Add IDE and SATA
Date: Wed, 23 Aug 2023 15:10:18 -0600
Message-ID: <20230823211059.1235147-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823211059.1235147-1-sjg@chromium.org>
References: <20230823211059.1235147-1-sjg@chromium.org>
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
index 2793e2c0b9d..a456547a25d 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -25,6 +25,7 @@ CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_IDE=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
+CONFIG_CMD_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index f196ed776d0..aedad4c93c3 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -21,8 +21,10 @@ CONFIG_LOGF_LINE=y
 CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_PCI_INIT_R=y
+CONFIG_CMD_IDE=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
+CONFIG_CMD_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
@@ -47,6 +49,13 @@ CONFIG_USE_ROOTPATH=y
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
index d660a223d9c..be5b0de5495 100644
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

