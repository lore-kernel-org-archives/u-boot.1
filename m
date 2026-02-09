Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84269E94623
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 23:44:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE44C83C65;
	Tue, 10 Feb 2026 00:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="G1EGjwrm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D5FA8341A; Tue, 10 Feb 2026 00:35:12 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 090DF8366F
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 00:35:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-45f053b7b90so141613b6e.0
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 15:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770680109; x=1771284909;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I1pAnFI7r3RWwmNFQWpfAgGrIEKVwU1rA/pSZOjiWd0=;
 b=G1EGjwrmyTJL+8CWWDKyeYMPEJLP1Eq8luDTZymOGYSsMPS+8sFIByFAEzKYlBQ8Kn
 QJy7mBBS1q+R4C3HOSsVal7RA3F/tjjiRLGkrWK1OkrOwrcv6jVIg2czRJ2uNvh4FFHb
 SVAk+IhS1RO9vRPh8qJu9oRHjPAzWK4f7Iskb2OAbhjBqKK1fPODAOwLkoWgOsSXKkJi
 VLPpxz1ATHYovoBRLX+uYKXwg4UkLLgoxnMs7hXcSCxEKFmM4v4+wTsWkle8ATaO6IgE
 83AHFZZxLCyhym0Rg2Q+jEYrPEPP9A3enewmvlygHMf0yqL4IkwiRmHTLvsvV93C+dgf
 ovJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770680109; x=1771284909;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I1pAnFI7r3RWwmNFQWpfAgGrIEKVwU1rA/pSZOjiWd0=;
 b=ACpPAFFId+evjbAEX6yyuIJrEuZ7RPZStE6khd3EOVXpNzK4471vUlSaYEdhKlSDqd
 a45YhOCBbUkr7iKcyFigHP44oJhDlGqL6ZfCf81dMZkRVyetNMnprPH2olWIbq3bVdEs
 w8HUjeYvR64eWTfdeAFk2ZRmYVT8DtWaSak+BLGFBVyfv087LJX8485rHDOw0KFeAxXf
 P4FQDtwiOKQhAyEMXU8HlbjSKwDO+ffIcMd4CEk05RpZnpT08+TPPRnZTWKynX53gkrI
 HdIqmPDYNtpZgWzSxxHZWYvAhqyhCKv9y3vQEd1TVjNkr1IWCJteOuSXKdbbpxJR02MJ
 +T4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/sWlx7tS3FgLLFEB+9iaFusB6n4jbV5xphjt9aK49oOXivR1PuZn543B0bWkkq5oYr0geruk=@lists.denx.de
X-Gm-Message-State: AOJu0YwHFUeTwSYUBYwhDuXhoks1TlEXAlJ1aB2WR0uJpGf9OFtQuyvC
 yae/ZnyIeG26Kf+MDk30fu6C1pccu0AdxPI6+eXTF1pG7NM/r0YFKcAfctEk4aFmM14=
X-Gm-Gg: AZuq6aLuAe0BuPYqzHYRIWiY9TT9I1vfJ0hPqCbgOl2RTaIX2CzztWiG580XjdAOPef
 Hpl2mR4aP5oeeGgQ/fIJTaZexoxu14ETmgzv5gEjAtDvceaM04FoLCq0rvV8QqIZa4zcONWjTWn
 T59pX2vt54YYlta63qvFAMYCeLED9h6ZiOw5wiUwAnHjUY4/+iuH3ooCHKOyy07C2zDTjqG3/ss
 pF+B0XT5m9CK4x7WSofOz+c+QSHtb0HuB1MOPVPmljARFQrg5AdCoRxZt48GkXcG7c2Kd7vPtas
 CSIYYjMCe/cFZ4DN8+AgcNzkt86OdTpKpNHqhxpxy+IKhDeUMLtNRU/EOBbPktLJFhbIY7Gy4+W
 h7W3+NUXljNf4Ua0/qIfOvPvq12GDbtVQZOU+x8Uyvs7MifP6sE6z13+8c2A4WLpGCWhJPR6uGr
 OHYin/6FseF5GuNa71drQFZdLxKU4=
X-Received: by 2002:a05:6808:c2a9:b0:45a:770c:d77b with SMTP id
 5614622812f47-462fcc4605emr6762217b6e.35.1770680108758; 
 Mon, 09 Feb 2026 15:35:08 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4631407de2dsm5304309b6e.16.2026.02.09.15.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 15:35:08 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Feb 2026 17:34:17 -0600
Subject: [PATCH 1/3] pinctl: mediatek: add bounds check on number of base
 addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-mtk-pinctl-mt8189-v1-1-a7a3069eda6c@baylibre.com>
References: <20260209-mtk-pinctl-mt8189-v1-0-a7a3069eda6c@baylibre.com>
In-Reply-To: <20260209-mtk-pinctl-mt8189-v1-0-a7a3069eda6c@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=825; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=TNluq0NMJ40QRyKTIBGvjAXnWzULuWJBKfyATVXU2vo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpim8EOsqN8hotr0B3zRCMI8EzHYnnWjdqGKPz8
 YIeUoIKSFmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYpvBBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AqCUH/3ePTMVuKb7sM7DJGLo5Lv2oi3eWtIHQlWvmPE7
 rCL4nhBQ+tWGbSg8EnmR5ZF2IAvB//awyk8C6MWwE3JKrvN8Y9ru8az6loj5J9xY8awxjO0QvbU
 GC4Evt6xw5Jit4ET/KrFXTAmrw5AwNuFDHiiqybxkyn/9LiLab77lRLbekEWB9gZIG2jjCUvGa2
 ckUL9L7//aJQxSPizOvwpqlF60Dq+wcAhrPjY0GbkiDIfWsOPVweSCsgtC/mLC9a5QvDjFV/Jiw
 vhnIZLvyz0CMwU2R/LnzdkQ73iMQ1P+wH8ZIdmP2EZHnm8czos6L2ZqWwaGKyGFiLLdO9k7lJ1+
 BejU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Tue, 10 Feb 2026 00:43:55 +0100
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

Add a bounds check on the number of base addresses to prevent
out-of-bounds access to the priv->base array.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index e991e03ea41..d152e216634 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -856,6 +856,9 @@ int mtk_pinctrl_common_probe(struct udevice *dev,
 	if (!base_calc)
 		nbase_names = 1;
 
+	if (nbase_names > MAX_BASE_CALC)
+		return -ENOSPC;
+
 	for (i = 0; i < nbase_names; i++) {
 		if (soc->base_names)
 			addr = dev_read_addr_name(dev, soc->base_names[i]);

-- 
2.43.0

