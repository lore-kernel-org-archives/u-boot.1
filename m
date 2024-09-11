Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6D3EE0211
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 07:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 882D289203;
	Wed, 11 Sep 2024 09:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZdfFDHUu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13388891FB; Wed, 11 Sep 2024 09:11:40 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2302A88D17
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 09:11:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a8b155b5e9eso212522866b.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 00:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726038697; x=1726643497; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vqy6PVBHxWJx4+pP+WOa/qhGDCdQPicD1vpW1c3GTF4=;
 b=ZdfFDHUuQYs6B6dixgXWLXB7CtJRkRoOObZ37EtNd3vIhy8vuDfIhQ6iag22A+uMMU
 hW5f9a/WjafxAr6aamRAXjXPno+dLE0iyXQ72PmedN7gV+oh6jnblwY4kpHRa8u41Ibm
 AdooM1OA+uxmJ9gOjxqDGd5Ki2sHXD9dZc/0EUknMuH6HcXIB3nhTHLX/yPfFCJPbCeI
 pC+MWuIg71zEThl8H9p/3C00G7v9ItgymdYo8X+YHm8+WIb2ES1nlSt3zQ08idRg/wsC
 2uCi0vIm30PW519Xq9q1LTIWgy05HMN0sy4MmVN3DOIscj9yCKnr5sCsUlE/y/ZeJ1ij
 KUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726038697; x=1726643497;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vqy6PVBHxWJx4+pP+WOa/qhGDCdQPicD1vpW1c3GTF4=;
 b=D9VnLvxcV89wJ0czRq1YXsaLRjQP5hoOj1cduBfWg6RUyOlP9/tJaBHfsFi/JrwQeo
 zVIgG0QAQkn6D5pGuBW/ft+oRrOb+35hnDrMHFuddXKtn4XUU4OEnV+pjvwAIgsgsd65
 EAcJTisc8z8ifIVIFdvtZWDE+kflyNpkREsXYEX6AAdGDdq57+Q6otNbtOlzCcqZI0yE
 BVVTNSSfbJV9utBn1zjcgizSex+BVd9VXjMRBYYVu/g24yqf68Sw33HBJ19G8TTnPhEv
 WlVz5pcm7oaqejHpTi8H6Xh5KldZxyZm8vsjAtWef+gwIbzwULrb3VvPI+8WxNyHJ5gQ
 h0bA==
X-Gm-Message-State: AOJu0Yzs6fuPo2jkgXPp/TpHOpjFDlm4PxLB79SaPrX5F4owdWInNDW9
 r+dN/NLzkikziIJMNI4sOZ2rQ1RXzwgiSA+shLXuANifmkbANhDcUxxiLDnIxVo=
X-Google-Smtp-Source: AGHT+IEJ0Eyxztrb/R0+VDyNCAPtb/BLb3n2zXnSAKbJ6ASYYjJPt3uu8T/oMkrVtngebmQMee8RZw==
X-Received: by 2002:a17:907:3f1b:b0:a8d:fa3:bb24 with SMTP id
 a640c23a62f3a-a90048191damr166012766b.23.1726038697329; 
 Wed, 11 Sep 2024 00:11:37 -0700 (PDT)
Received: from lino.lan ([85.235.12.238]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25926ee8sm580523866b.50.2024.09.11.00.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 00:11:36 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Sep 2024 09:11:16 +0200
Subject: [PATCH 5/7] mtd: rawnand: brcmnand: Add read data bus interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-brcmnand-fixes-v1-5-be112a20aaf1@linaro.org>
References: <20240911-brcmnand-fixes-v1-0-be112a20aaf1@linaro.org>
In-Reply-To: <20240911-brcmnand-fixes-v1-0-be112a20aaf1@linaro.org>
To: u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0
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

This is a port of the read data bus interface from the Linux
brcmnand driver, commit 546e425991205f59281e160a0d0daed47b7ca9b3
"mtd: rawnand: brcmnand: Add BCMBCA read data bus interface"

This is needed for the BCMBCA RAW NAND driver.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 20 +++++++++++++++++---
 drivers/mtd/nand/raw/brcmnand/brcmnand.h |  2 ++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 552b239b95ae..2f786584a1ae 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -769,6 +769,20 @@ static inline void brcmnand_write_fc(struct brcmnand_controller *ctrl,
 	__raw_writel(val, ctrl->nand_fc + word * 4);
 }
 
+static inline void brcmnand_read_data_bus(struct brcmnand_controller *ctrl,
+					  void __iomem *flash_cache, u32 *buffer, int fc_words)
+{
+	struct brcmnand_soc *soc = ctrl->soc;
+	int i;
+
+	if (soc && soc->read_data_bus) {
+		soc->read_data_bus(soc, flash_cache, buffer, fc_words);
+	} else {
+		for (i = 0; i < fc_words; i++)
+			buffer[i] = brcmnand_read_fc(ctrl, i);
+	}
+}
+
 static void brcmnand_clear_ecc_addr(struct brcmnand_controller *ctrl)
 {
 
@@ -1812,7 +1826,7 @@ static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip *chip,
 {
 	struct brcmnand_host *host = nand_get_controller_data(chip);
 	struct brcmnand_controller *ctrl = host->ctrl;
-	int i, j, ret = 0;
+	int i, ret = 0;
 
 	brcmnand_clear_ecc_addr(ctrl);
 
@@ -1825,8 +1839,8 @@ static int brcmnand_read_by_pio(struct mtd_info *mtd, struct nand_chip *chip,
 		if (likely(buf)) {
 			brcmnand_soc_data_bus_prepare(ctrl->soc, false);
 
-			for (j = 0; j < FC_WORDS; j++, buf++)
-				*buf = brcmnand_read_fc(ctrl, j);
+			brcmnand_read_data_bus(ctrl, ctrl->nand_fc, buf, FC_WORDS);
+			buf += FC_WORDS;
 
 			brcmnand_soc_data_bus_unprepare(ctrl->soc, false);
 		}
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.h b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
index 6946a62b0679..3a1d60471361 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.h
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
@@ -11,6 +11,8 @@ struct brcmnand_soc {
 	void (*ctlrdy_set_enabled)(struct brcmnand_soc *soc, bool en);
 	void (*prepare_data_bus)(struct brcmnand_soc *soc, bool prepare,
 				 bool is_param);
+	void (*read_data_bus)(struct brcmnand_soc *soc, void __iomem *flash_cache,
+			      u32 *buffer, int fc_words);
 	void *ctrl;
 };
 

-- 
2.46.0

