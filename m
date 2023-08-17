Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A992C05052
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 01:53:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BFDA86A6A;
	Thu, 17 Aug 2023 03:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oXJtbpR0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBE1386A76; Thu, 17 Aug 2023 03:52:09 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A5B086A2D
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 03:52:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6bc886d1504so6178754a34.0
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 18:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692237125; x=1692841925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k40vPshfohjHab5McqiTm5zfVc75X4gNgQX+80C+rcQ=;
 b=oXJtbpR0KfNoKJW1cdbQYZrp9R/oI8h9KWrHsKiUdNJx+ZMLevmUijQXt5nyhcQoO6
 pqSKtu4RE0hc3hJ4gHiO/qWE4uOQX3miOJI4mmcFLxmfqYPXAnlJdeQqYObepTg4+a5S
 EwbQv5YGc0aSnxVm+g0beif2j0r2le1P96XI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692237125; x=1692841925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k40vPshfohjHab5McqiTm5zfVc75X4gNgQX+80C+rcQ=;
 b=enq1Dquo9aqFyboNwgID/fzk5OqOTKkrdCfjsKnSVwYhAGH2K3jOqneq1cnkhK2cpd
 wdH5ecK5Yg0ywN9Usb1FH/tscY+pnM6MLNETrW+zqKK5Fz+g6NVyiOL/XAZJu9dV/Ujj
 nQj9g0KJL8N3F6tDrZAKXypQdSOoeou3mNc7ZG9s8YsAnPRPpE3gm7/YIHVy4lXqeVUj
 LMFr+IxwEQFYuJ28BybRBrJaMBbgfEmb1k5eZhtNbe/OmnCZw2Aqz8AbwKHB+GIDxdGk
 AgLD2eFGnmz4Hxcl1mRqgjUTSxuwgYCK+4PuhGevSUQ5Mjf9sxm39OKbsNn1iH3oDKAl
 o0FA==
X-Gm-Message-State: AOJu0YzZde1KVtteL0jHlutUvrmaU7B9IduWJwGU2tg+AWJGCHCkFa6t
 YBDF7p04ezRY2DayVnYee2AhNUXaeOkKl78nFmE=
X-Google-Smtp-Source: AGHT+IFYt1zDwckOQK2bkYoluvdoSKmv7A/SVeHoxhp7VraMb4rGOCcKaFZRvViLf0ymdmwHc1G87A==
X-Received: by 2002:a05:6830:13c6:b0:6b9:b665:7f with SMTP id
 e6-20020a05683013c600b006b9b665007fmr3537884otq.17.1692237125724; 
 Wed, 16 Aug 2023 18:52:05 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a0568301d7200b006af9d8af435sm6606854oti.50.2023.08.16.18.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 18:52:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 7/9] x86: coreboot: Align options between coreboot and
 coreboot64
Date: Wed, 16 Aug 2023 19:51:42 -0600
Message-ID: <20230817015149.774847-8-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230817015149.774847-1-sjg@chromium.org>
References: <20230817015149.774847-1-sjg@chromium.org>
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

These two builds are similar but have some different options for no good
reason. Line them up to be as similar as possible.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/coreboot64_defconfig |  7 ++++++-
 configs/coreboot_defconfig   | 10 ----------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 2e80b5af92ef..e5cb3f3d4ebd 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -18,6 +18,9 @@ CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
+CONFIG_LOG=y
+CONFIG_LOGF_LINE=y
+CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_LAST_STAGE_INIT=y
 CONFIG_SPL_NO_BSS_LIMIT=y
@@ -51,11 +54,13 @@ CONFIG_SYS_ATA_ALT_OFFSET=0
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
-CONFIG_CMD_CBFS=y
+CONFIG_SMBIOS_PARSER=y
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index ae44705a1d51..790b84a87bc7 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -25,23 +25,14 @@ CONFIG_LAST_STAGE_INIT=y
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
@@ -67,4 +58,3 @@ CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
 CONFIG_SMBIOS_PARSER=y
-CONFIG_CMD_CBFS=y
-- 
2.41.0.694.ge786442a9b-goog

