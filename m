Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371A9C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 03:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0C7A87176;
	Mon,  6 Nov 2023 03:37:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c/C1eAIB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70C1A86F8A; Mon,  6 Nov 2023 03:30:09 +0100 (CET)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3687086FB4
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-49d6bd360f8so1690562e0c.2
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237595; x=1699842395; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/kqMJgxdAkfNZo8EFg5exC2r8jZ6UcD2pAx4Qy5FMA=;
 b=c/C1eAIBLz/mR22jGInu7g/RUr4IkkTS4wv0j2RkZ+QXoUZblwu6Gd1KWPBNJkRIB/
 Y75+Q7hKM8FONTrBtps6XN/nulPGeEdq5YKXYFyzQYmwaDGpT0vLp9MsaiVVO7qW7GV+
 HQecQaCvOd1ijyZLqwiW01QkWe3I9RFm8G0+hH/Gppp8ZUCyv0zTWHwhM+SBE3Sj+w26
 X38TJBfX2b6GqiCumP59i8exTofgb0fy/7GxWlHzCReavWXK1NIByuNJW76nMANn92Sn
 91jtxkeY1RAT01pbLKYIScq0zxDe+V7sW/Lwfe7oOVVklaOKKr8/VMFmyjBzn73Rhwg1
 /PEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237595; x=1699842395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/kqMJgxdAkfNZo8EFg5exC2r8jZ6UcD2pAx4Qy5FMA=;
 b=neaMn2Fmyrj5j2iMOiNc7/lZCNujXjxtotqPqGBB5wq7fvQwgtXZtJNcfjieIiraX7
 CXu6NicU/6ow/vS5yjABf7bZocD0ICCMmSPdlUXxrGiVoApuMbw/1sA2b2X/pJhgxywu
 98zNJw0nLTdDYvy5V/JXJ0LimkMuFnXdhbCbHlp7L3Kl+rx6hPkjXlcr7vUmgQKPStEK
 CdVxTi8EUYsWLLntOCPH4UFV2f3DpW1bQb6HltCOIHiTWSPbj7QKXkqIUYgG5RUUP/bR
 lCcVWnc+Ngc0juEJfaH6/S7oZ12O9SO6qR/j5VWAX8yArHgsd8u1gTt3SSK1Dyis18FI
 otkg==
X-Gm-Message-State: AOJu0YxNLZG7zie5Ya8CrgFCsJY/U/R6TzxWKs4CrDDgSER48vq6fxJq
 Eq2tGG2FXtmsljI8J/krZnA=
X-Google-Smtp-Source: AGHT+IGorDJoJrpS9bQos9fFe2kLL5DBhSfgzwTJJ6dIQMrkZcLKrKPmbqij0wllW7QVVbWvEND/Bw==
X-Received: by 2002:a67:cc16:0:b0:45e:3e66:56ee with SMTP id
 q22-20020a67cc16000000b0045e3e6656eemr2338109vsl.17.1699237595565; 
 Sun, 05 Nov 2023 18:26:35 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 qb18-20020ad44712000000b006577e289d37sm3059006qvb.2.2023.11.05.18.26.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:35 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v6 25/25] spl: fat: Add option to disable DMA alignment
Date: Sun,  5 Nov 2023 21:26:03 -0500
Message-Id: <20231106022603.3405551-26-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106022603.3405551-1-seanga2@gmail.com>
References: <20231106022603.3405551-1-seanga2@gmail.com>
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

If we don't DMA-align buffers we pass to FAT, it will align them itself.
This behaviour likely should be deprecated in favor of
CONFIG_BOUNCE_BUFFER, but that's a task for another series. For the
meantime, don't bother aligning the buffer unless we had been doing so in
the past.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v6:
- New

 common/spl/Kconfig      | 18 ++++++++++++++++--
 common/spl/spl_blk_fs.c |  5 ++++-
 common/spl/spl_fat.c    |  5 ++++-
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index b93526904eb..fc284a5bffc 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -694,13 +694,28 @@ config SPL_FS_SQUASHFS
 config SPL_FS_FAT
 	bool "Support FAT filesystems"
 	select FS_FAT
-	select SPL_LOAD_BLOCK
 	help
 	  Enable support for FAT and VFAT filesystems with SPL. This
 	  permits U-Boot (or Linux in Falcon mode) to be loaded from a FAT
 	  filesystem from within SPL. Support for the underlying block
 	  device (e.g. MMC or USB) must be enabled separately.
 
+config SPL_FS_FAT_DMA_ALIGN
+	bool "Use DMA-aligned buffers with FAT"
+	depends on SPL_FS_FAT
+	select SPL_LOAD_BLOCK
+	default y if SPL_LOAD_FIT
+	help
+	  The FAT filesystem driver tries to ensure that the reads it issues to
+	  the block subsystem use DMA-aligned buffers. If the supplied buffer is
+	  not DMA-aligned, the FAT driver will use a bounce-buffer and read
+	  block-by-block. This is separate from the bounce-buffer used by the
+	  block subsystem (CONFIG_BOUNCE_BUFFER).
+
+	  Enable this config to align buffers passed to the FAT filesystem
+	  driver. This will speed up reads, but will increase the size of U-Boot
+	  by around 60 bytes.
+
 config SPL_FS_LOAD_PAYLOAD_NAME
 	string "File to load for U-Boot from the filesystem"
 	depends on SPL_FS_EXT4 || SPL_FS_FAT || SPL_FS_SQUASHFS || SPL_SEMIHOSTING
@@ -1282,7 +1297,6 @@ config SPL_NVME
 	depends on BLK
 	select FS_LOADER
 	select SPL_BLK_FS
-	select SPL_LOAD_BLOCK
 	help
 	  This option enables support for NVM Express devices.
 	  It supports basic functions of NVMe (read/write).
diff --git a/common/spl/spl_blk_fs.c b/common/spl/spl_blk_fs.c
index ac267ab979b..04eac6f306b 100644
--- a/common/spl/spl_blk_fs.c
+++ b/common/spl/spl_blk_fs.c
@@ -82,7 +82,10 @@ int spl_blk_load_image(struct spl_image_info *spl_image,
 	}
 
 	load.read = spl_fit_read;
-	spl_set_bl_len(&load, ARCH_DMA_MINALIGN);
+	if (IS_ENABLED(CONFIG_SPL_FS_FAT_DMA_ALIGN))
+		spl_set_bl_len(&load, ARCH_DMA_MINALIGN);
+	else
+		spl_set_bl_len(&load, 1);
 	load.priv = &dev;
 	return spl_load(spl_image, bootdev, &load, filesize, 0);
 }
diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index 569f2b32928..a52f9e178e6 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -86,7 +86,10 @@ int spl_load_image_fat(struct spl_image_info *spl_image,
 	}
 
 	load.read = spl_fit_read;
-	spl_set_bl_len(&load, ARCH_DMA_MINALIGN);
+	if (IS_ENABLED(CONFIG_SPL_FS_FAT_DMA_ALIGN))
+		spl_set_bl_len(&load, ARCH_DMA_MINALIGN);
+	else
+		spl_set_bl_len(&load, 1);
 	load.priv = (void *)filename;
 	err = spl_load(spl_image, bootdev, &load, size, 0);
 
-- 
2.37.1

