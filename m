Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70363C3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 21:12:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1EE386519;
	Wed, 23 Aug 2023 23:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KREcHuvO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4102B864EB; Wed, 23 Aug 2023 23:11:19 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A662864FA
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 23:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-790970a8706so216016139f.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692825075; x=1693429875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aIAM9ylIf7fGJD+CbJT4AVyryVF9lYYm/xS5A3Qj+ss=;
 b=KREcHuvOHJdEaKWSiGfzKjGTw1pOA/zALmByp/9jCBccjh/vTTojS9gkmrisUuXg5+
 L8icHL4BA9BycJoyDSR3rLMCCGp/dzrqR89I33VrybzeYu39n4pg//lcY10Tp3ChxUGg
 MGqO0V8/cf9PJ+6tRFVYlYOWo89aeFours/5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692825075; x=1693429875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aIAM9ylIf7fGJD+CbJT4AVyryVF9lYYm/xS5A3Qj+ss=;
 b=iyx60O0uwIM09+Io+HhIbCA/SfmeYF8LEvRCz/a9WHaD61CQMXlsHXXYiA7D01SjI4
 P6WE2FfMokZY7HJKKlmbNgmQAVOFCm0JhpLxzvF/NG8SzSN8kJayp18CZULYm9N9uCMb
 TIem6wuG68xX9dTTNaromZWlaV6UYzu1tcZY2WRkeUplip2oO1IcspvyH0TaasK1a2t4
 ovgIsLvtl2Mo2Av+D+yzK5kcwMTBBQdjWsorra0Sj2VQ1/XqNv+pQvr+u3EvBdEs5WRL
 xkhE7Web4gLu/gd6u+lvFilDCBrT9rlgB3mYC3ltT819v+y+OG424iD8BHi1+MxNQRDQ
 dFLw==
X-Gm-Message-State: AOJu0YxYwL1Y8ZELd53xjZVq/IS2P2M9j8EeWAalTZNCER55cyegb7xd
 4HjYKrzuUt9XmJ2X7amL0qROBGecjANYoCz0bMU=
X-Google-Smtp-Source: AGHT+IE5YPvQ5RRtoK5XlmlktR/rRAnAVkTLZE1th10qY2j7XhL8V3YQphhXc8cB10mSx6iCVrwTZw==
X-Received: by 2002:a05:6e02:160b:b0:345:d583:5c64 with SMTP id
 t11-20020a056e02160b00b00345d5835c64mr4603518ilu.24.1692825075104; 
 Wed, 23 Aug 2023 14:11:15 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a02c9cf000000b0041627abe120sm3921075jap.160.2023.08.23.14.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 14:11:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 09/20] x86: coreboot: Align options between coreboot and
 coreboot64
Date: Wed, 23 Aug 2023 15:10:26 -0600
Message-ID: <20230823211059.1235147-10-sjg@chromium.org>
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

These two builds are similar but have some different options for not good
reason. Line them up to be as similar as possible.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Update the malloc size too

 configs/coreboot64_defconfig | 7 +++++++
 configs/coreboot_defconfig   | 9 ---------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index c0405633946..dc3548aa736 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -1,5 +1,6 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0x1120000
+CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="coreboot"
@@ -18,6 +19,9 @@ CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
+CONFIG_LOG=y
+CONFIG_LOGF_LINE=y
+CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_SYS_PBSIZE=532
@@ -50,10 +54,13 @@ CONFIG_SYS_ATA_ALT_OFFSET=0
 CONFIG_ATAPI=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
+CONFIG_NVME_PCI=y
 # CONFIG_PCI_PNP is not set
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SOUND=y
 CONFIG_SOUND_I8254=y
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_SPL_ACPI=y
+CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
+CONFIG_SMBIOS_PARSER=y
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index e7e45c2b0a9..630eb9aa384 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -24,23 +24,14 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_PCI_INIT_R=y
 CONFIG_CMD_IDE=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_PART=y
 CONFIG_CMD_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_DHCP=y
 CONFIG_BOOTP_BOOTFILESIZE=y
-CONFIG_CMD_PING=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_SOUND=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
 CONFIG_MAC_PARTITION=y
-CONFIG_ISO_PARTITION=y
-CONFIG_EFI_PARTITION=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
-- 
2.42.0.rc1.204.g551eb34607-goog

