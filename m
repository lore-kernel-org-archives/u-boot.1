Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164C3CE79A8
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8964586C15;
	Wed, 20 Sep 2023 05:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AkLGiV5R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6394586C0B; Wed, 20 Sep 2023 05:00:37 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75F9A86BF9
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-34fe6722847so1289655ab.1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178833; x=1695783633; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OI1TEM0re5BDUWmu4xS6f2fJmGGaSWiuo4clBCoaaJg=;
 b=AkLGiV5R/vm99S1H97h0psKrsU7QYyOUZktVbXrmvpEPulhSKv/xtJXpBHZi3XAgtD
 dFrAvvPzEcilvzibZu8WLZN7JUgJDFc9Lk7TM8KhyqWIuh11KzE/1TvKsDOmp7N7S6Wy
 XB9B0w47g8/izhL3pLmb/vb3HshAi4mRfvIvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178833; x=1695783633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OI1TEM0re5BDUWmu4xS6f2fJmGGaSWiuo4clBCoaaJg=;
 b=ikx7bcxY+dSeBYtePqsAQ7+SbqS+axCD2xIjtRMW66Zi1UhBmglFh5XATM/QdVHsEk
 d3V9CEoUnr8b0JBBTh6I1/6/hTQ2a6MPMtF7TQz3Dw+HHqgAnXS+uW51LXtqmo6sfAM+
 +awxETi7A8ojNVjiZpoOdmg03fdjiy4WGwHVqS0SG2Wjq88058o1Zl110fAvg7yo2lAb
 bw2FTPbhuJsOIwYeH4oLsjeJ5EcoAd3nM7m5JDsSrpvsm40d36J/wOClxRM9VCxQG8Zs
 ut+KGusxFKjfkSYVmPFohPq+5Pu5iEVzg6UTkpym08+2ly/dgi9Asv9WUGWVb4mDdvgn
 74EA==
X-Gm-Message-State: AOJu0YyKKj15eJejRHxSz4df+k+Ik8mUojbrUD+K4XqtaiM46IloABsb
 QmkNFSqY3xQtHdU1LwmF8D0pDm2cBRRnEoKKV0k=
X-Google-Smtp-Source: AGHT+IG+XIXXaUgBloAZ16XGpmalm1MBZ/0wWcmPfI4oVzgIWl31YZMsr7bc10Hk4RuKQhtYPi+mGg==
X-Received: by 2002:a05:6e02:1b8b:b0:349:8ea:9bd1 with SMTP id
 h11-20020a056e021b8b00b0034908ea9bd1mr1506495ili.7.1695178832982; 
 Tue, 19 Sep 2023 20:00:32 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s5-20020a92d905000000b0034feb68437fsm1835423iln.24.2023.09.19.20.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 20:00:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 01/20] x86: coreboot: Add IDE and SATA
Date: Tue, 19 Sep 2023 21:00:02 -0600
Message-ID: <20230920030027.1385833-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920030027.1385833-1-sjg@chromium.org>
References: <20230920030027.1385833-1-sjg@chromium.org>
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
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

(no changes since v1)

 configs/coreboot64_defconfig    |  1 +
 configs/coreboot_defconfig      |  9 +++++++++
 doc/board/coreboot/coreboot.rst | 20 ++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 2793e2c0b9d1..a456547a25d4 100644
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
index f196ed776d0b..aedad4c93c30 100644
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
2.42.0.459.ge4e396fd5e-goog

