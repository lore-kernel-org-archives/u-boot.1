Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569C41061B0A
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 16:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DECD184035;
	Mon, 30 Mar 2026 18:01:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lVgVgRB2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0407983FD9; Mon, 30 Mar 2026 18:01:34 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA75183EB3
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 18:01:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-41cd9267bbfso2677786fac.1
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774886490; x=1775491290;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vUx4lAEU/bC593XVMkJqkxHGo7vuj+idl2YNDr9pRQM=;
 b=lVgVgRB2/TJjU4M02Ev22SP9j04TYB185mwv6e5xIrDTizr1awaaw1QkMrZDAkJRJl
 N1nXDamHnzwGV3VLycFLVXJQ5rWjurJL5lWfbS2v1bMhVvdvxzlOpFCiGjyXuI8EBi9j
 Yt3Mf0syLAe2VnJDcK6Emy/KazX75GdY6YiZify/IYaiVEP4gUS0A9Q1MQD0Vrg9uyXq
 FKYT1yTJj1lnOfT9qAtCsALN2BeOMNZrZAFirqpXcTAtUCSQyOn+wUUUzk+mEHTZi1Bc
 Q1ZNMyESM/XI/RzR6UI1Skn+zkg93/dg+uKnXfZ0gF1yxrG+/elIeCHyWesL4qz9wcMk
 1IsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774886490; x=1775491290;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vUx4lAEU/bC593XVMkJqkxHGo7vuj+idl2YNDr9pRQM=;
 b=RJDgd9eTXrZa5V9/XPAr87tzUjponolxJwdsySvDHxTHCLd7Xzhq2R4M18WnjadcVW
 K0hXadPQqW0an+xdg3ks9b9ftAr1SFGaix3B8wi7Lc82vzxlD5cFTcH/GU5/atvv0lfr
 tUaA6GOLXnG7lDtvOKKjJk0DBYplqsohBDA9DnbYksZJtaeGh8eP9Xsut3UyEKhccc0g
 /rHauGp7x1/3GaCBFvWPOP4VJfkoeLQwzu/QWoGPMJNGiu1iz6+UEi8zAvZm2s61YFWc
 R8rDiEI6jElwd20WSMMgF0F2kEpqJ26vC8Dkjsw7zG87g4GJFf6iPqPATVIBrLxlA2yZ
 fhKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtTJpLg/DX/gc3YB0p9mlNHDd6oi7Xux5uXYOZtfNOGZa/UOLD0E85E6KOp1HvThSz92sBy8k=@lists.denx.de
X-Gm-Message-State: AOJu0YyQwM6J3tZLkpJ7JkZA4/2IbimNyPaZCZtz34ZltQJnoffhjwVI
 h5ftDBAWZtzDRK8/Atqycwizp43DSrNubTdTVXuFyikUoYWpDyNLTcuD1hXDLNlvE9Y=
X-Gm-Gg: ATEYQzznBcdAY+GA4VTASt8GpshRtyqXzPCN1MkYRdh+CciSjld9gyZMYvzti372kCy
 0WKy4cQixa039hpgjOm6P1gIB9v/tc4Akdp5B0d2vw2mMPZuxG/SfNNfW5bdMZqNAbFDgFF7ojb
 vQiVI1jRPNWYSL189Y0MtZLTIwtUWkWRFpe/twmjsSfbw908kVpNg/7bPIW9oCQVDrLP1E/CqpB
 ZM56jw9MjeIF4z72TNzWwmNXoD0Cedh9O06Lkk4dYFFzSjQhnvay5blQlnyt/GRtF0tkPGhUItp
 dlVOtIepg4aoCa5GT1/2MmNQXqd3rD/mdqhkG4K1L3jkuhIpNQcJztQkhD6wwQ5i81HgqBtACtC
 bq1jDBBYzntRyhc2co/CVdRaxCcXue5kTfqGX9QyUWKErcBkTBCcgar7g2zUxQiWgNJfOoyAZ9U
 BfwXj/tBUtfSPkxV+XX5eA3Rj/4Uao
X-Received: by 2002:a05:6870:9126:b0:417:3833:fbdb with SMTP id
 586e51a60fabf-422a4ce758cmr56621fac.17.1774886490171; 
 Mon, 30 Mar 2026 09:01:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a67f:a092:38d7:379e])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41d048e1984sm5432952fac.4.2026.03.30.09.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 09:01:29 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 30 Mar 2026 11:00:33 -0500
Subject: [PATCH v2 1/4] pinctrl: mediatek: add handling for RSEL register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-pinctrl-mtk-fix-mt8189-v2-1-05a737ec623d@baylibre.com>
References: <20260330-pinctrl-mtk-fix-mt8189-v2-0-05a737ec623d@baylibre.com>
In-Reply-To: <20260330-pinctrl-mtk-fix-mt8189-v2-0-05a737ec623d@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2279; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=G7CrhQNKHaL1p222dcpfMKTtqBX5v//XobMJ6uN0pLQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpyp48u423tQsdvyKMkshsSy8OSjFCSoQI/7Y8Z
 TAUq4h/TtaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacqePBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AbqkIAI5JID/ElhO3OOuMcsx+QljGLyLb0KMLy0cmx4F
 8sciLLv93xFz1sGkrejtIkZmCWEwf9PpOpc+Gyjp6uqwDDps+mF1r9sIGzuHQ45IchU7f3+DvaV
 dP435RPFNDibcNLzl6e6BJykEMB88/GdxnXsgIEVSGNgUT+c4ElplxhEYTS0Bhap+V88IJAYz73
 lvhPchqyy9l0INWqW8rttoyB3POLUVQIIPlrq/HCTb5yE+0mFz1hcJKDBBawqzDd9SD0UxngYXt
 X0U890GeV/x8TnnMwotwsDVm29Vy6Im5HJ90w5AJHAjJ2h9O6C3Y16fPfYuhqqG+036Ipz+4sJf
 aPOk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add a new PINCTRL_PIN_REG_RSEL register type and a new function
mtk_pinconf_bias_set_pu_pd_rsel() to handle setting it.

Some MediaTek SoCs have a pin configuration register called RSEL that
sets the resistance value for bias pullup/pulldown.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 14 ++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index d152e216634..1028b8a93f5 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -450,6 +450,20 @@ int mtk_pinconf_bias_set_pupd_r1_r0(struct udevice *dev, u32 pin, bool disable,
 	return 0;
 }
 
+int mtk_pinconf_bias_set_pu_pd_rsel(struct udevice *dev, u32 pin, bool disable,
+				    bool pullup, u32 val)
+{
+	int err;
+
+	/* val is expected to be one of MTK_PULL_SET_RSEL_XXX */
+
+	err = mtk_pinconf_bias_set_pu_pd(dev, pin, disable, pullup, val);
+	if (err)
+		return err;
+
+	return mtk_hw_set_value(dev, pin, PINCTRL_PIN_REG_RSEL, val & 0x7);
+}
+
 int mtk_pinconf_bias_set(struct udevice *dev, u32 pin, u32 arg, u32 val)
 {
 	int err;
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
index 58f13613633..1215fb7094b 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -67,6 +67,7 @@ enum {
 	PINCTRL_PIN_REG_PUPD,
 	PINCTRL_PIN_REG_R0,
 	PINCTRL_PIN_REG_R1,
+	PINCTRL_PIN_REG_RSEL,
 	PINCTRL_PIN_REG_MAX,
 };
 
@@ -253,6 +254,8 @@ int mtk_pinconf_bias_set_pullen_pullsel(struct udevice *dev, u32 pin,
 					bool disable, bool pullup, u32 val);
 int mtk_pinconf_bias_set_pupd_r1_r0(struct udevice *dev, u32 pin, bool disable,
 				    bool pullup, u32 val);
+int mtk_pinconf_bias_set_pu_pd_rsel(struct udevice *dev, u32 pin, bool disable,
+				    bool pullup, u32 val);
 int mtk_pinconf_bias_set_v0(struct udevice *dev, u32 pin, bool disable,
 			    bool pullup, u32 val);
 int mtk_pinconf_bias_set_v1(struct udevice *dev, u32 pin, bool disable,

-- 
2.43.0

