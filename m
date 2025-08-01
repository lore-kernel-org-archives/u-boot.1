Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEAEC87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 10:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12B9A83A3D;
	Fri,  1 Aug 2025 12:39:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ludYlV4k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9798183A3D; Fri,  1 Aug 2025 12:39:28 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B347483A2A
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 12:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45892deb246so7044175e9.2
 for <u-boot@lists.denx.de>; Fri, 01 Aug 2025 03:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754044756; x=1754649556; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=93PE7q57Gy+rBExAALoJu4umqN1hy37MNozddY4X/ZA=;
 b=ludYlV4kpOpfjJI0bMSM/qE6jNqVUHspSgbbkvO9AJzm+5IYKuzMeL5r/VVRNSSYi2
 P6qlfCIkt1mxnYwedL7XiNdi7PfJJNhaGhVRZIXYKgY+yjeglKIF02RMIH0J3nxvx2yb
 MySLjG1KYsuZwffvIxp6/xn1MK84r3ssj/J/LWQcfiLQDc2re40ZzvuOMqLDRW+CcNxi
 QoRdfd+i+Nb/eBXpSWI3pdcCh1tmjcHi2OByA7hB484dsNys9VUM1EIsiDWexoU+IaKI
 tKM9tQTeJtnKXQkBCTZTrzdawUYZzvENFJpnfJRuRiFHgwaY5jyBbT9dGjla/tsXifGM
 /Rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754044756; x=1754649556;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=93PE7q57Gy+rBExAALoJu4umqN1hy37MNozddY4X/ZA=;
 b=R7jVLQfXomJwxBnn+Hnrn9DaegpiBSMfT6nmgb/VtjxNywZZ5J7XvWpcf9E+zSHt5C
 x0CnVz4McyH4FOKdbiy4FTLvKYT4kxc5WxgH+v39ep/CgxS8Inj+t3G+RZDzZTzp/VVR
 lybjfxedNuZpC2GKklCu2Yg4ha/KHGSL5d01mFBeLyE10n6LOTQkDp0Bw4YBdInka5Qw
 50/QhYV5Tbo2wltFqo+kIsXtGuA2XPuxDpFYsNGzdvJQ9w2CtxGQER0y45VEKjKfzknG
 pdSqB5BCwUQAJRj9IQO5xVbRoA3vyGJocr1snhrSy4BYVNz++AWv6PVkvkNH0vmipNhI
 pAyw==
X-Gm-Message-State: AOJu0YxYhQweJ+YcavGu8zrmI64R+FJfEqqViXOl/Y5r4mftXf2ClN0W
 LtcSpK7fR15WM47jYuo6pshdHmZoc0TswZJqVHM6LGengWdKjVdDeCri7eaJ7H1TrbbcrlHZOQ1
 q5trTfqg=
X-Gm-Gg: ASbGncvfOparfel9IklIehgs/3TPSK8j0CX6XhLeMf/kLY28/U2P4x3RSZ8SOjH/aqe
 kKSNDtvECH+2uewJgWMeolLioetHlcfelw6c4fKWBcveRaj6eBuMpFva7UuFTnjxDyGEosX1B2v
 AEzBk9ZmQRfzUhX1+cyQpuuThYl+j/qtWscbTeLR28Bdg2ZIKfpRmT8SRILBFJgTsOCvDFXQh18
 yRIteK6/x/PL4NOibysWxOsPpvDp9Z8dybU7EzOReZYWAwgZBeHx6og2wPaI7yPRhnEdCUs/rZx
 /GPw3ew5iatI0fYjH1hkeJRq7lAjLrDn/zk7E0t/sdLtURNJPDFmKN1e8MSB7qLN3lap6Lpb9N3
 Uc8uMPgUU6yG5B3pD8b+41GrLiMj+yIAmWObo075JNSZ4tNuCfeM=
X-Google-Smtp-Source: AGHT+IG4Ah4gy5wKMitK5iW2SSTbHpagruvAIT4wRNfwLga1PrLwjvwKFz5ieSlqrwRJdy30umq1GA==
X-Received: by 2002:a05:600c:1f82:b0:456:207e:fd83 with SMTP id
 5b1f17b1804b1-458aa31840emr17059865e9.4.1754044755941; 
 Fri, 01 Aug 2025 03:39:15 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:cc6e:5422:ab75:92e8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589edf5638sm59830275e9.4.2025.08.01.03.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 03:39:15 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 01 Aug 2025 11:39:15 +0100
Subject: [PATCH 3/3] mtd: nand: sunxi: Free allocated memory on errors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-mtd_nand_raw2-v1-3-bdabdeb35b46@linaro.org>
References: <20250801-mtd_nand_raw2-v1-0-bdabdeb35b46@linaro.org>
In-Reply-To: <20250801-mtd_nand_raw2-v1-0-bdabdeb35b46@linaro.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Add kfree calls on error paths for memory that was allocated. This will
prevent memory leaks.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mtd/nand/raw/sunxi_nand.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 34197bb09a1..1ce09b56b80 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1403,8 +1403,10 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 	if (!data)
 		return -ENOMEM;
 
-	if (ecc->size != 512 && ecc->size != 1024)
+	if (ecc->size != 512 && ecc->size != 1024) {
+		kfree(data);
 		return -EINVAL;
+	}
 
 	/* Prefer 1k ECC chunk over 512 ones */
 	if (ecc->size == 512 && mtd->writesize > 512) {
@@ -1641,17 +1643,20 @@ static int sunxi_nand_chip_init(struct udevice *dev, struct sunxi_nfc *nfc,
 		if (ret) {
 			dev_err(dev, "could not retrieve reg property: %d\n",
 				ret);
+			kfree(chip);
 			return ret;
 		}
 
 		if (tmp > NFC_MAX_CS) {
 			dev_err(dev,
 				"invalid reg value: %u (max CS = 7)\n", tmp);
+			kfree(chip);
 			return -EINVAL;
 		}
 
 		if (test_and_set_bit(tmp, &nfc->assigned_cs)) {
 			dev_err(dev, "CS %d already assigned\n", tmp);
+			kfree(chip);
 			return -EINVAL;
 		}
 
@@ -1678,12 +1683,14 @@ static int sunxi_nand_chip_init(struct udevice *dev, struct sunxi_nfc *nfc,
 		dev_err(dev,
 			"could not retrieve timings for ONFI mode 0: %d\n",
 			ret);
+		kfree(chip);
 		return ret;
 	}
 
 	ret = sunxi_nand_chip_set_timings(nfc, chip, timings);
 	if (ret) {
 		dev_err(dev, "could not configure chip timings: %d\n", ret);
+		kfree(chip);
 		return ret;
 	}
 
@@ -1705,8 +1712,10 @@ static int sunxi_nand_chip_init(struct udevice *dev, struct sunxi_nfc *nfc,
 
 	mtd = nand_to_mtd(nand);
 	ret = nand_scan_ident(mtd, nsels, NULL);
-	if (ret)
+	if (ret) {
+		kfree(chip);
 		return ret;
+	}
 
 	if (nand->bbt_options & NAND_BBT_USE_FLASH)
 		nand->bbt_options |= NAND_BBT_NO_OOB;
@@ -1719,24 +1728,28 @@ static int sunxi_nand_chip_init(struct udevice *dev, struct sunxi_nfc *nfc,
 	ret = sunxi_nand_chip_init_timings(nfc, chip);
 	if (ret) {
 		dev_err(dev, "could not configure chip timings: %d\n", ret);
+		kfree(chip);
 		return ret;
 	}
 
 	ret = sunxi_nand_ecc_init(mtd, &nand->ecc);
 	if (ret) {
 		dev_err(dev, "ECC init failed: %d\n", ret);
+		kfree(chip);
 		return ret;
 	}
 
 	ret = nand_scan_tail(mtd);
 	if (ret) {
 		dev_err(dev, "nand_scan_tail failed: %d\n", ret);
+		kfree(chip);
 		return ret;
 	}
 
 	ret = nand_register(devnum, mtd);
 	if (ret) {
 		dev_err(dev, "failed to register mtd device: %d\n", ret);
+		kfree(chip);
 		return ret;
 	}
 

-- 
2.39.5

