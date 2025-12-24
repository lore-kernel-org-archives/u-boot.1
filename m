Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375B8E7848C
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 19:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 935B184309;
	Wed, 24 Dec 2025 20:37:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oi8w3QD1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC5A684301; Wed, 24 Dec 2025 20:32:31 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46F08842B6
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 20:32:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=george.mccollister@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c75b829eb6so3860253a34.1
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 11:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766604747; x=1767209547; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ekdzlk+1M+luARDDjS7gL+SCVU7UY02PUWpj4MJnHA=;
 b=oi8w3QD13d7LQwPwrdkV7Myzso5FQDEM75KoMSVNlvk4qU5J9lIdiSlUTdjTt5A9No
 JdVL++dgCy8MluZuhW0sAu4DDxi6VimNse3HTiqaW5pSDcrhb70YScBJ1lYL8nZwkZC/
 iOgTyp0omf+Llh8vF6ELMKBFp0htJM6tZNfWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766604747; x=1767209547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7ekdzlk+1M+luARDDjS7gL+SCVU7UY02PUWpj4MJnHA=;
 b=nenwAfCovXyX7PzMCW3OIAGmvdl0kT+wRvnLHMgFb1KWvAkiPD9XAYw4JngwYHciXo
 tbObHeCAzuAZRK3nzL3dMsrKCHro0ERS/M0BzXV63zxsSrLis0ShxwV6JJFuerDP7Sf0
 GuDn6yzGZ5DsNysGgVieyt434lVwxAeIptOjLGC+YiT8rdt0/eyuyMo9uItFEdz0Q05d
 zQ6XG1gAZjL17qY40ynXLyiAhwuAJ3wnBKkEYXixAAN7pt6zkISvpFUy29pAYcSBP9eq
 kCl0MTPZpFTj8LLogEIbu7VD1QJSNKsqpZ0Tugp++zOyjDZ8R7pRRqiKKMVXvkbHQtZS
 XfEA==
X-Gm-Message-State: AOJu0YwTlvax8B38HNf7HiZN+QxCRKFqniWGOQ/8hbvbe0D+YX0CyVVJ
 1iQAfAmtCOeauEfeHf9hwCI/irdT4EjG8shytIWe4AoBDxZ9mEpC3pwwoUFYH+baCpTh/VM5Tth
 Fie1s7VQ=
X-Gm-Gg: AY/fxX6pIdY0jbIMxIPWO2hVN0ZzXDmSN/xrb0PLMdVxOjfhAGsv5mVyaOUGStdJ395
 cwdM5CXgxK72UQ+M2qvgRK+X4Jl7iJPwVifq0dazmwo9LsGg/tzs91fqNC12U27vXTfGcHodfaQ
 Hu95fkz+5ivVEqv0cscyIuEdb9uczZirzUJGgqQ3bOzxOiqr+G9BRUYboPcVJRDGouSuCPNICCV
 JieNkzt00nFVkyopa+hQFUHHBgDNI4sQiZWuIyTAacAmFuAzO/B7/d05DGgwlifPgki7lVgmRfL
 ar6UKiVIrVhV135COlxJkj47C+wUf7n7KRcbWEXk/l934tSU7aUSTOKOmkTqkYFeLthNqKWWLhd
 u9gmiyzC8X+Mqpi4wJClIIkeQ4cc/tFLSg46J5kJC0scpqjPLyEP9Yv9r4bq84ZwWy3zKfrgr2P
 lnBwQK/zNgRvIqM2cxxTDOlgI00PaSOZGMKR8=
X-Google-Smtp-Source: AGHT+IG5Ab//06TscXUnf5mX/6ti6Jj70/G3avsbg78JrUYM3KxGpDiTR8pfHEZ3sopJVGxSd7a5wQ==
X-Received: by 2002:a05:6830:3808:b0:7c7:655c:7353 with SMTP id
 46e09a7af769-7cc668bb891mr11736514a34.12.1766604747619; 
 Wed, 24 Dec 2025 11:32:27 -0800 (PST)
Received: from ryzen.localdomain ([136.33.243.183])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc6673bc05sm12049723a34.8.2025.12.24.11.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 11:32:27 -0800 (PST)
From: George McCollister <george.mccollister@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bryan Brattlof <bb@ti.com>,
 George McCollister <george.mccollister@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/6] phy: ti: j721e-wiz: Enable reference clock output in
 cmn_refclk_<p/m>
Date: Wed, 24 Dec 2025 13:32:00 -0600
Message-ID: <20251224193213.802246-3-george.mccollister@konsulko.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251224193213.802246-1-george.mccollister@konsulko.com>
References: <20251224193213.802246-1-george.mccollister@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Dec 2025 20:37:54 +0100
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

cmn_refclk_<p/m> lines in Torrent SERDES are used for an connecting
external reference clock. cmn_refclk_<p/m> can also be configured to
output the reference clock. In order to drive the refclk out from the
SERDES (Cadence Torrent), PHY_EN_REFCLK should be set in SERDES_RST of
WIZ. Model PHY_EN_REFCLK as a clock, so that platforms like AM642 EVM
can enable it.

Based on: https://lore.kernel.org/r/20210310120840.16447-6-kishon@ti.com

Signed-off-by: George McCollister <george.mccollister@konsulko.com>
---

 drivers/phy/ti/phy-j721e-wiz.c | 46 ++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index eaf68d18f3a1..466e2a5d0b50 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -75,6 +75,7 @@ enum wiz_typec_master_lane {
 
 static const struct reg_field por_en = REG_FIELD(WIZ_SERDES_CTRL, 31, 31);
 static const struct reg_field phy_reset_n = REG_FIELD(WIZ_SERDES_RST, 31, 31);
+static const struct reg_field phy_en_refclk = REG_FIELD(WIZ_SERDES_RST, 30, 30);
 static const struct reg_field pll1_refclk_mux_sel =
 					REG_FIELD(WIZ_SERDES_RST, 29, 29);
 static const struct reg_field pll1_refclk_mux_sel_2 =
@@ -534,9 +535,43 @@ static int wiz_clk_of_xlate(struct clk *clk, struct ofnode_phandle_args *args)
 	return 0;
 }
 
+static int wiz_phy_en_refclk_enable(struct clk *clk)
+{
+	struct udevice *dev = clk->dev;
+	struct wiz_clk *priv = dev_get_priv(dev);
+	struct wiz *wiz = priv->wiz;
+	int id;
+
+	id = clk->id >> 10;
+	if (id != TI_WIZ_PHY_EN_REFCLK)
+		return 0;
+
+	regmap_field_write(wiz->phy_en_refclk, 1);
+
+	return 0;
+}
+
+static int wiz_phy_en_refclk_disable(struct clk *clk)
+{
+	struct udevice *dev = clk->dev;
+	struct wiz_clk *priv = dev_get_priv(dev);
+	struct wiz *wiz = priv->wiz;
+	int id;
+
+	id = clk->id >> 10;
+	if (id != TI_WIZ_PHY_EN_REFCLK)
+		return 0;
+
+	regmap_field_write(wiz->phy_en_refclk, 0);
+
+	return 0;
+}
+
 static const struct clk_ops wiz_clk_ops = {
 	.set_parent = wiz_clk_set_parent,
 	.of_xlate = wiz_clk_of_xlate,
+	.enable = wiz_phy_en_refclk_enable,
+	.disable = wiz_phy_en_refclk_disable,
 };
 
 int wiz_clk_probe(struct udevice *dev)
@@ -818,6 +853,12 @@ static int wiz_regfield_init(struct wiz *wiz)
 		return PTR_ERR(wiz->phy_reset_n);
 	}
 
+	wiz->phy_en_refclk = devm_regmap_field_alloc(dev, regmap, phy_en_refclk);
+	if (IS_ERR(wiz->phy_en_refclk)) {
+		dev_err(dev, "PHY_EN_REFCLK reg field init failed\n");
+		return PTR_ERR(wiz->phy_en_refclk);
+	}
+
 	wiz->pma_cmn_refclk_int_mode =
 		devm_regmap_field_alloc(dev, regmap, pma_cmn_refclk_int_mode);
 	if (IS_ERR(wiz->pma_cmn_refclk_int_mode)) {
@@ -1042,6 +1083,11 @@ static int j721e_wiz_bind_clocks(struct wiz *wiz)
 		}
 	}
 
+	rc = device_bind(dev, wiz_clk_drv, "phy-en-refclk",
+			 NULL, dev_ofnode(dev), NULL);
+	if (rc)
+		dev_err(dev, "cannot bind driver for clock phy-en-refclk\n");
+
 	return 0;
 }
 
-- 
2.51.2

