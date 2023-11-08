Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA52CC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 230AD8777C;
	Wed,  8 Nov 2023 17:49:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BJjEtu5g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FD7E876F4; Wed,  8 Nov 2023 17:49:47 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E141687765
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-778940531dbso456285485a.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462173; x=1700066973; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SR9gQ2NZLuht645C+/bQTxCHkjB4V+qVePs4jBrx+vg=;
 b=BJjEtu5g1rmUvMVV9CwC9+hPzmvoLKN/xyIKwtrNvAOEnoUmWQcGf29nh71NtDs7lv
 U8TnAsuVsSOgAC+lmdGoWoVlq8f3v+25ykEbf/xKSxeMny2f0MIrpI3q9ATkUyTX2jRX
 8s7Dm/1SqJ0k2DyE3gwroPboIVWVDHh3t/SI6/snXUMTX/gzVqyQ0IlApnB4UaTB5Zb7
 0gbAwuNS+0mXWObwhRwnX7HFx+7cgOYu1u5YSVFo/GkqQ77T//TpL8Amkfjla6BhKAgv
 Pk8Tt7twKFPW6157eKHROlJawiQy4UyPaNpmCBLC0RzBUXuQ/8+E1VI34JULtwr2GIT5
 0hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462173; x=1700066973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SR9gQ2NZLuht645C+/bQTxCHkjB4V+qVePs4jBrx+vg=;
 b=DCAxrH6W4byoB0UheaxP3tuTkZT/62LfQixPT5ajnuDq0Ks61XGUzy3qiwbHHy/EC/
 URs3eTN+Oidh6poqyXfHqvVz2EMDtJ3+/jmAZ/fa+OB2w73Kbt1uV1uKIFAC5gDqRIeI
 vocH0TjpPWFxWPCdmUDQBCdXrIVxlerKkDQB8EyCYnrjhWLUzZVNDEwTJq9iARDDdq1K
 BLJ1Vuw+rBTOEoD6JNR8PWGE6EtjVzfNWR/riB4ARRVY4DcwCihNgPxG1C36G13+ooQD
 QQDVeIbfwY6KnuROumdm0Nr/jETiSBCsKUp7gBVw+cCD4vtYWThCShGWknZJ1ne9V6sT
 XVKw==
X-Gm-Message-State: AOJu0Yx41QEMiUy+QoNmg//LbswWewlOlMGxKsS9fmbm/iQ8AUwuKxb2
 X5pCXOVaULRK4VweSktz/Ug=
X-Google-Smtp-Source: AGHT+IHtuVV2tqA8O1Pa23dGWPYSu3vaP+xMg6qmqWRWLaxp3fjHEG2JxArR5UlUXUSbTrt/O5NPAg==
X-Received: by 2002:a05:620a:430e:b0:775:da1a:67da with SMTP id
 u14-20020a05620a430e00b00775da1a67damr2270999qko.53.1699462173685; 
 Wed, 08 Nov 2023 08:49:33 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 bl1-20020a05620a1a8100b007776c520488sm1226164qkb.9.2023.11.08.08.49.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:33 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v7 26/26] spl: fat: Add option to disable DMA alignment
Date: Wed,  8 Nov 2023 11:48:58 -0500
Message-Id: <20231108164858.3497420-27-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231108164858.3497420-1-seanga2@gmail.com>
References: <20231108164858.3497420-1-seanga2@gmail.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v6)

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

