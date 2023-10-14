Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E774CDB482
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1953786F65;
	Sun, 15 Oct 2023 08:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jTbg3bOt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11817869D1; Sun, 15 Oct 2023 08:43:17 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7CAE86529
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-77432add7caso201890885a.2
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697352133; x=1697956933; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ICIxmADV7g0zeBPfMPIY1gBtY9PPIAgjFJESME9v+WM=;
 b=jTbg3bOt42rffgzgs+D4AXaSI1IDxWN8kTJLP/yadba7NvxQpYicYlvY49oxu1Ufbk
 /A6jstKePcX9Ah8AZV8FbXvyhXeoj+0yhskXC1hmz5afDUF9gBeUHcyS1DNLw2W/kjvG
 jOsyVEY9UewlGwWJZEkGB5EicrKKNsoc3tNjyaCIWCdLfDqAMuOGHPC9f+SujkUyhZTc
 6Szbpag1jmcAYcEvUHxCbHcTx+3i6j6alvfcuv6+LC2bmbhhtyroiuU5bSGNLo0Rwv2a
 t+IePzaHwf6flY+MeG5qDES2xRYKeFNNuhgGhPcQ77SlLdGa6doSiqzWm0CVznSQmTP6
 9CJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697352133; x=1697956933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ICIxmADV7g0zeBPfMPIY1gBtY9PPIAgjFJESME9v+WM=;
 b=andu2ByWfES2NUzCGjFuKgp+LVuflGbORRjq+r2e4XFL2DBqpQ0fIbjKDMpr1hCHiy
 vG/tZMw4gOyBIr65RBNliPm2icvgccYTjCmmL9VvifvGHllQcQU5O/ElUP9eocuNhkAu
 Oh3teQkp3mF0wwQ7B3WY3GBRMmFJ+kPxnmWmhOIczKasbRrLMHtQbBwV/K/OE8MCxbN6
 peG17+y6RrE7CSXTu6pcs29oTLhr5cMzTtNGAvgRnrv0ZNvAZAs0kLfK9WHGV9w80NOY
 65/6nUsadiFPBPLohJZYsDHRfccI+r3kyTZJHjMVAK9cn336IHQhoTHzHqH7O9fbTjmR
 6mHQ==
X-Gm-Message-State: AOJu0Ywtnsg4OH7bOwTTY6mfU3wTt+RSnaq+ARUfjtI/luCZnY2wDgNR
 BtFY9o3//uvApbpy1C2ttSZajBuk/4xWmg==
X-Google-Smtp-Source: AGHT+IE75QclbZcymfOP216meYCSasq+YP07IImMFHJ1RbQYbOCf2f1rmZipglxOUeZBmxWsSwrlJw==
X-Received: by 2002:a05:6214:301b:b0:65b:1594:264e with SMTP id
 ke27-20020a056214301b00b0065b1594264emr33280210qvb.51.1697316508167; 
 Sat, 14 Oct 2023 13:48:28 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 v5-20020a0ccd85000000b00655e428604esm1947845qvm.137.2023.10.14.13.48.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:27 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 18/29] spl: Add callbacks to invalidate cached devices
Date: Sat, 14 Oct 2023 16:47:54 -0400
Message-Id: <20231014204805.439009-19-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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

Several SPL functions try to avoid performing initialization twice by
caching devices. This is fine for regular boot, but does not work with
UNIT_TEST, since all devices are torn down after each test. Add some
functions to invalidate the caches which can be called before testing these
load methods.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v2:
- Use callbacks to invalidate SPL caches instead of disabling them entirely

 common/spl/spl_fat.c |  5 +++++
 common/spl/spl_mmc.c |  8 +++++++-
 include/spl.h        | 22 ++++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index c6e2526ade1..b7b6a7794fd 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -20,6 +20,11 @@
 
 static int fat_registered;
 
+void spl_fat_force_reregister(void)
+{
+	fat_registered = 0;
+}
+
 static int spl_register_fat_device(struct blk_desc *block_dev, int partition)
 {
 	int err = 0;
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 67c7ae34a58..03a081fa47e 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -403,13 +403,19 @@ static int spl_mmc_get_mmc_devnum(struct mmc *mmc)
 	return block_dev->devnum;
 }
 
+static struct mmc *mmc;
+
+void spl_mmc_clear_cache(void)
+{
+	mmc = NULL;
+}
+
 int spl_mmc_load(struct spl_image_info *spl_image,
 		 struct spl_boot_device *bootdev,
 		 const char *filename,
 		 int raw_part,
 		 unsigned long raw_sect)
 {
-	static struct mmc *mmc;
 	u32 boot_mode;
 	int err = 0;
 	__maybe_unused int part = 0;
diff --git a/include/spl.h b/include/spl.h
index 7d30fb57dac..5b051ef2aae 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -674,6 +674,18 @@ static inline const char *spl_loader_name(const struct spl_image_loader *loader)
 #endif
 
 /* SPL FAT image functions */
+
+/**
+ * spl_fat_force_reregister() - Force reregistration of FAT block devices
+ *
+ * To avoid repeatedly looking up block devices, spl_load_image_fat keeps track
+ * of whether it has already registered a block device. This is fine for most
+ * cases, but when running unit tests all devices are removed and recreated
+ * in-between tests. This function will force re-registration of any block
+ * devices, ensuring that we don't try to use an invalid block device.
+ */
+void spl_fat_force_reregister(void);
+
 int spl_load_image_fat(struct spl_image_info *spl_image,
 		       struct spl_boot_device *bootdev,
 		       struct blk_desc *block_dev, int partition,
@@ -753,6 +765,16 @@ bool spl_was_boot_source(void);
  */
 int spl_dfu_cmd(int usbctrl, char *dfu_alt_info, char *interface, char *devstr);
 
+/**
+ * spl_mmc_clear_cache() - Clear cached MMC devices
+ *
+ * To avoid reinitializing MMCs, spl_mmc_load caches the most-recently-used MMC
+ * device. This is fine for most cases, but when running unit tests all devices
+ * are removed and recreated in-between tests. This function will clear any
+ * cached state, ensuring that we don't try to use an invalid MMC.
+ */
+void spl_mmc_clear_cache(void);
+
 int spl_mmc_load_image(struct spl_image_info *spl_image,
 		       struct spl_boot_device *bootdev);
 
-- 
2.37.1

