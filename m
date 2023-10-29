Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF42C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 03:50:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF4C687C5D;
	Sun, 29 Oct 2023 04:49:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YM++hAwv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5CCC87C62; Sun, 29 Oct 2023 04:49:00 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6333587C64
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 04:48:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-66cfd35f595so21244536d6.2
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 20:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698551336; x=1699156136; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6nfxABBdKVqrSMSQNuogU4jJodCh5T6Ovtq3arNqhc=;
 b=YM++hAwvZAR2VhCD2+5BR64Gk5Xvx7Ci+tmX+Mc85d02TvSZZjveg3WAJnBG1C9lih
 QOUirfFxrAsBYNtwtMYiwdFcgRpFwFWFxJEpyf3hvNvr2Z3Ln/gEJh3P2mA3L4BGsOpV
 Djm8rleydIKN7DwIzz9QTNm72SSmyek4V8BXQ/KXqy7hQ65PWHoypRtxMhURroEMKKd0
 WD173A7UYHIWVvRlWj0m2DCH5F+wZwetnfQypycEJZshXRfFaavgNgssp14xjrpXFucp
 8y7M+qx9+dzNMvWbzZmDA9Z60j2T/cL7DuRluCLrNzUCvs93pNJlN1DcDfMJJwmDyj30
 SxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698551336; x=1699156136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A6nfxABBdKVqrSMSQNuogU4jJodCh5T6Ovtq3arNqhc=;
 b=vyzQBGv6UVSjFuhwc5wrkRPL+f0ZNEN4d+bo89Qk5KpJ1AT5tzA0+Zgar7qFXP8bFE
 v7zf9YMVhIT0ucROTxPQUxszJkPpn9bZ+ygcq/znnB++FDzpfbjt8dSnNi9gP0EJBI2+
 o2l7AkT6vUJcMAOXgrn4WvX29eBF89h9kfq2L6UH9urbj/47i6EVfeKOLbsczfAIlsRr
 C1/eMmQn/33cHgApoGe4mMk+QkcLpV+pnoHaUnwn/+lVTGA0NWCaSMXVRxkPjwh9OE12
 KRrLcXAeqPA1cP8sCW/mtMYybJ4EIT6B7QNH62qaqdT6JCCkBtqIfTBII/O6ADTHCM0q
 J4bQ==
X-Gm-Message-State: AOJu0YwokqoDj42oDLrAmAXm93MupuS3PbXzTy/3Sog7Eb1KjE+mtSOC
 ur1WCgFwL/a3x9VtI8RCEWySxYpdRyzJdg==
X-Google-Smtp-Source: AGHT+IHaCAiHuoJL7qpWAbN4jBou89rgEYt0VU06Ph/YhkJB5h6lA+YsSxSKgMD2CoiX8qEzLRzIGA==
X-Received: by 2002:a05:6214:20ad:b0:66c:fc76:7936 with SMTP id
 13-20020a05621420ad00b0066cfc767936mr6883974qvd.48.1698551336364; 
 Sat, 28 Oct 2023 20:48:56 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 ee9-20020a0562140a4900b006562b70805bsm2186543qvb.84.2023.10.28.20.48.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 20:48:56 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 06/15] spl: nand: Set bl_len to page size
Date: Sat, 28 Oct 2023 23:48:36 -0400
Message-Id: <20231029034845.1169614-7-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231029034845.1169614-1-seanga2@gmail.com>
References: <20231029034845.1169614-1-seanga2@gmail.com>
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

Since commit 34793598c83 ("mtd: nand: mxs_nand_spl: Remove the page aligned
access") there are no longer any users of nand_get_mtd. However, it is
still important to know what the page size is so we can allocate a
large-enough buffer. If the image size is not page-aligned, we will go off
the end of the buffer and clobber some memory.

Introduce a new function nand_page_size which returns the page size. For
most drivers it is easy to determine the page size. However, a few need to
be modified since they only keep the page size around temporarily.

It's possible that this patch could cause a regression on some platforms if
the offset is non-aligned and there is invalid address space immediately
before the load address. spl_load_legacy_img does not (except when
compressing) respect bl_len, so only boards with SPL_LOAD_FIT (8 boards) or
SPL_LOAD_IMX_CONTAINER (none in tree) would be affected.

defconfig               CONFIG_TEXT_BASE
======================= ================
am335x_evm              0x80800000
am43xx_evm              0x80800000
am43xx_evm_rtconly      0x80800000
am43xx_evm_usbhost_boot 0x80800000
am43xx_hs_evm           0x80800000
dra7xx_evm              0x80800000
gwventana_nand          0x17800000
imx8mn_bsh_smm_s2       0x40200000

All the sitara boards have DDR mapped at 0x80000000. gwventana is an i.MX6Q
which has DDR at 0x10000000. I don't have the IMX8MNRM handy, but on the
i.MX8M DDR starts at 0x40000000. Therefore all of these boards can handle a
little underflow.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 common/spl/spl_nand.c                   | 11 +++--------
 drivers/mtd/nand/raw/am335x_spl_bch.c   |  5 +++++
 drivers/mtd/nand/raw/atmel_nand.c       |  5 +++++
 drivers/mtd/nand/raw/denali_spl.c       |  5 +++++
 drivers/mtd/nand/raw/fsl_ifc_spl.c      |  8 ++++++++
 drivers/mtd/nand/raw/lpc32xx_nand_mlc.c |  5 +++++
 drivers/mtd/nand/raw/mt7621_nand_spl.c  |  5 +++++
 drivers/mtd/nand/raw/mxc_nand_spl.c     |  5 +++++
 drivers/mtd/nand/raw/mxs_nand_spl.c     |  5 +++++
 drivers/mtd/nand/raw/nand.c             |  7 +++++++
 drivers/mtd/nand/raw/nand_spl_simple.c  |  5 +++++
 drivers/mtd/nand/raw/sunxi_nand_spl.c   |  8 +++++++-
 include/nand.h                          |  1 +
 13 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index a19236d9e6d..509e6047999 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -72,23 +72,18 @@ static ulong spl_nand_legacy_read(struct spl_load_info *load, ulong offs,
 	return size;
 }
 
-struct mtd_info * __weak nand_get_mtd(void)
-{
-	return NULL;
-}
-
 static int spl_nand_load_element(struct spl_image_info *spl_image,
 				 struct spl_boot_device *bootdev,
 				 int offset, struct legacy_img_hdr *header)
 {
-	struct mtd_info *mtd = nand_get_mtd();
-	int bl_len = mtd ? mtd->writesize : 1;
+	int bl_len;
 	int err;
 
 	err = nand_spl_load_image(offset, sizeof(*header), (void *)header);
 	if (err)
 		return err;
 
+	bl_len = nand_page_size();
 	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
 	    image_get_magic(header) == FDT_MAGIC) {
 		struct spl_load_info load;
@@ -118,7 +113,7 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 		load.dev = NULL;
 		load.priv = &offset;
 		load.filename = NULL;
-		load.bl_len = 1;
+		load.bl_len = IS_ENABLED(CONFIG_SPL_LZMA) ? bl_len : 1;
 		load.read = spl_nand_legacy_read;
 
 		return spl_load_legacy_img(spl_image, bootdev, &load, offset, header);
diff --git a/drivers/mtd/nand/raw/am335x_spl_bch.c b/drivers/mtd/nand/raw/am335x_spl_bch.c
index 3843ffc9a24..df84fb3955a 100644
--- a/drivers/mtd/nand/raw/am335x_spl_bch.c
+++ b/drivers/mtd/nand/raw/am335x_spl_bch.c
@@ -218,6 +218,11 @@ void nand_init(void)
 	nand_command(0, 0, 0, NAND_CMD_RESET);
 }
 
+unsigned int nand_page_size(void)
+{
+	return nand_to_mtd(&nand_chip)->writesize;
+}
+
 /* Unselect after operation */
 void nand_deselect(void)
 {
diff --git a/drivers/mtd/nand/raw/atmel_nand.c b/drivers/mtd/nand/raw/atmel_nand.c
index cfc6578ae83..f43ef00cb98 100644
--- a/drivers/mtd/nand/raw/atmel_nand.c
+++ b/drivers/mtd/nand/raw/atmel_nand.c
@@ -1452,6 +1452,11 @@ void nand_init(void)
 		nand_chip.select_chip(mtd, 0);
 }
 
+unsigned int nand_page_size(void)
+{
+	return nand_to_mtd(&nand_chip)->writesize;
+}
+
 void nand_deselect(void)
 {
 	if (nand_chip.select_chip)
diff --git a/drivers/mtd/nand/raw/denali_spl.c b/drivers/mtd/nand/raw/denali_spl.c
index 690279c9976..165a23312cb 100644
--- a/drivers/mtd/nand/raw/denali_spl.c
+++ b/drivers/mtd/nand/raw/denali_spl.c
@@ -234,4 +234,9 @@ int nand_spl_load_image(uint32_t offs, unsigned int size, void *dst)
 	return 0;
 }
 
+unsigned int nand_page_size(void)
+{
+	return page_size;
+}
+
 void nand_deselect(void) {}
diff --git a/drivers/mtd/nand/raw/fsl_ifc_spl.c b/drivers/mtd/nand/raw/fsl_ifc_spl.c
index c67065eaf8c..69d26f1f79a 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_spl.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_spl.c
@@ -106,6 +106,8 @@ static inline int bad_block(uchar *marker, int port_size)
 		return __raw_readw((u16 *)marker) != 0xffff;
 }
 
+static int saved_page_size;
+
 int nand_spl_load_image(uint32_t offs, unsigned int uboot_size, void *vdst)
 {
 	struct fsl_ifc_fcm *gregs = (void *)CFG_SYS_IFC_ADDR;
@@ -150,6 +152,7 @@ int nand_spl_load_image(uint32_t offs, unsigned int uboot_size, void *vdst)
 		if (port_size == 8)
 			bad_marker = 5;
 	}
+	saved_page_size = page_size;
 
 	ver = ifc_in32(&gregs->ifc_rev);
 	if (ver >= FSL_IFC_V2_0_0)
@@ -302,6 +305,11 @@ void nand_init(void)
 {
 }
 
+unsigned int nand_page_size(void)
+{
+	return saved_page_size;
+}
+
 void nand_deselect(void)
 {
 }
diff --git a/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c b/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
index ac2e669d46b..f8ae216d56c 100644
--- a/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
@@ -765,4 +765,9 @@ int nand_spl_load_image(uint32_t offs, unsigned int size, void *dst)
 	return 0;
 }
 
+unsigned int nand_page_size(void)
+{
+	return BYTES_PER_PAGE;
+}
+
 #endif /* CONFIG_SPL_BUILD */
diff --git a/drivers/mtd/nand/raw/mt7621_nand_spl.c b/drivers/mtd/nand/raw/mt7621_nand_spl.c
index 114fc8b7cea..a2be9ba80e0 100644
--- a/drivers/mtd/nand/raw/mt7621_nand_spl.c
+++ b/drivers/mtd/nand/raw/mt7621_nand_spl.c
@@ -203,6 +203,11 @@ unsigned long nand_size(void)
 	return SZ_2G;
 }
 
+unsigned int nand_page_size(void)
+{
+	return nfc_dev.nand.mtd.writesize;
+}
+
 void nand_deselect(void)
 {
 }
diff --git a/drivers/mtd/nand/raw/mxc_nand_spl.c b/drivers/mtd/nand/raw/mxc_nand_spl.c
index 059bf38f50e..2d89d4dbfc7 100644
--- a/drivers/mtd/nand/raw/mxc_nand_spl.c
+++ b/drivers/mtd/nand/raw/mxc_nand_spl.c
@@ -351,3 +351,8 @@ __used void nand_boot(void)
 
 void nand_init(void) {}
 void nand_deselect(void) {}
+
+unsigned int nand_page_size(void)
+{
+	return CONFIG_SYS_NAND_PAGE_SIZE;
+}
diff --git a/drivers/mtd/nand/raw/mxs_nand_spl.c b/drivers/mtd/nand/raw/mxs_nand_spl.c
index 300662994cf..f7d3f02f85a 100644
--- a/drivers/mtd/nand/raw/mxs_nand_spl.c
+++ b/drivers/mtd/nand/raw/mxs_nand_spl.c
@@ -295,6 +295,11 @@ int nand_default_bbt(struct mtd_info *mtd)
 	return 0;
 }
 
+unsigned int nand_page_size(void)
+{
+	return nand_to_mtd(&nand_chip)->writesize;
+}
+
 void nand_deselect(void)
 {
 }
diff --git a/drivers/mtd/nand/raw/nand.c b/drivers/mtd/nand/raw/nand.c
index eacd99c4e27..4da41438790 100644
--- a/drivers/mtd/nand/raw/nand.c
+++ b/drivers/mtd/nand/raw/nand.c
@@ -174,3 +174,10 @@ void nand_init(void)
 
 	create_mtd_concat();
 }
+
+unsigned int nand_page_size(void)
+{
+	struct mtd_info *mtd = get_nand_dev_by_index(nand_curr_device);
+
+	return mtd ? mtd->writesize : 1;
+}
diff --git a/drivers/mtd/nand/raw/nand_spl_simple.c b/drivers/mtd/nand/raw/nand_spl_simple.c
index 2ebcac56900..3d3d1d39cd5 100644
--- a/drivers/mtd/nand/raw/nand_spl_simple.c
+++ b/drivers/mtd/nand/raw/nand_spl_simple.c
@@ -227,6 +227,11 @@ void nand_init(void)
 		nand_chip.select_chip(mtd, 0);
 }
 
+unsigned int nand_page_size(void)
+{
+	return nand_to_mtd(&nand_chip)->writesize;
+}
+
 /* Unselect after operation */
 void nand_deselect(void)
 {
diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index 6de0b0a3554..c9b8c78ed75 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -524,9 +524,10 @@ static int nand_read_buffer(struct nfc_config *conf, uint32_t offs,
 	return 0;
 }
 
+static struct nfc_config conf;
+
 int nand_spl_load_image(uint32_t offs, unsigned int size, void *dest)
 {
-	static struct nfc_config conf = { };
 	int ret;
 
 	ret = nand_detect_config(&conf, offs, dest);
@@ -536,6 +537,11 @@ int nand_spl_load_image(uint32_t offs, unsigned int size, void *dest)
 	return nand_read_buffer(&conf, offs, size, dest);
 }
 
+unsigned int nand_page_size(void)
+{
+	return conf.page_size;
+}
+
 void nand_deselect(void)
 {
 	struct sunxi_ccm_reg *const ccm =
diff --git a/include/nand.h b/include/nand.h
index 70c1286ccb4..c1d7533aaac 100644
--- a/include/nand.h
+++ b/include/nand.h
@@ -12,6 +12,7 @@
 
 extern void nand_init(void);
 unsigned long nand_size(void);
+unsigned int nand_page_size(void);
 
 #include <linux/compat.h>
 #include <linux/mtd/mtd.h>
-- 
2.37.1

