Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A55CD6E56
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 21:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBCBF8039B;
	Sun, 31 May 2026 23:02:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sEEQJKYv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89AD1846E6; Sun, 31 May 2026 23:02:13 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC5FA80077
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 23:02:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bec44dcddedso12662666b.3
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 14:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780261331; x=1780866131; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bloh6b+E23azw1X8zx3DwAT0S4hC0RwEjtMTjSFOIk8=;
 b=sEEQJKYv/LQn2c26tmOCzhuBHrO4fi1gvMYCu7pjoeXkEOOjhVt23dUWJQ6hieCr/z
 h9DPFMdwOjuq1rNzWSQcT5xkUQGAGxoz6O/9hvSPBW4qydps5ZiFsb7Q7VNIoeelK/u2
 8hbUO3HHldCrjG2WKkXAc9F5PTToroxfwYD6TJIJprT8nkRYntvYNHGt79dUajwz98H8
 QtFAAxMjq8TwTxfXFUU76eu7YQt7I2mPkuCMkLxjGyGvySBWnJQisICKTSMl82uToXdg
 E5Vc+j3rUp1A5w42jWhFeihgDN9ckpYt0qG0y+JKXgzNliMUpYME9xu6Kv3ri61J2ZAq
 bBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780261331; x=1780866131;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bloh6b+E23azw1X8zx3DwAT0S4hC0RwEjtMTjSFOIk8=;
 b=V51o+dNSOOpJqotlgyELMliJnk7ijviTNCnpspB0qf/QOwHhis2MiK8Uuec4FDyISl
 TZlj3pWRs8yJTBxVnNdDPKPX+71D1Vz7cyIEwGl4d/Kg7cr3+jR7XRUgUv8u6aHOl5QH
 AvQ5/to0Y3bVb2XxzKw2gSXEaY8j+IvMZQAHwvXcmy9pN+DW4FXPqsIkOloy4XQQlTXc
 kpKBZFm8JkTzlLhCX2a1/2sHrKdIo02lBjT3BvdhZ3DVX/pWVH3InarMGniTjspU6Ig2
 tGLB58q/KrXNdYg+yUtIxVpi1+C1d0T1whGzaZTlU05Tbgb8ZaOJKWargndwU+QnOx23
 Uz4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ84u+RnF7V7UqdMdyjYMh6x3Y2IejEPEaabtJONGt5XNazXUTe107zeul6ae01oOdfGEsI7zVo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx52vg7AdnoAw7KrIhcXuwe8cASN3iZg49OhP43XZZePBljGywK
 sW5BTE+IBQMtCB2HwS4zRPzMCYSXjgXqH5tcOePeFWo/4ILdhVrQPCig
X-Gm-Gg: Acq92OF/RBxhHRGRFKYhILd0NiPfblTr6QdR9SNXXO1OFkW8UHl2rxBaS8ZZsHBCM3/
 KazaGCP0HEvMnXJV19h9eC/GJsgrglvLmAHZARnOZWOpiwze6LGw68sM14oIPMI9BfErEwMV0b1
 zofN+tnWkn5TEFqrYdPbAh5qLTtm7EBrXQUSffDsRmOzDdaWRohQh94W3/lZS75GCDzA0XZkgFo
 T0G4frXuUAbtooARy09GTqrk821tO125V/9F59ZfjlFnpzh0zl1thSD/ZFE9r8Np9YW1IH3nZym
 kXX8CjAkGMmVipRpdWxry2oe/vslUeBMDpsu5Rc+1rkwCG6u3DoV0Y8R1ujVJz1vz/+/5j8SF1X
 Kr0CIaXOS6Hl37qXfEBJ9LGFW+dqB+jj7XQ0+n0Bry+Hl4pE8nqK7v/zernpvqbXZ/6+g5Rs4rj
 XmPCdM94feCgrJFl42qC7vo32yrjVtQQ5rn5p7mcOYD++1tUrijjcZkRaz39gGP4QIT9OUCHfJ
X-Received: by 2002:a50:ec96:0:b0:689:ac19:3fb4 with SMTP id
 4fb4d7f45d1cf-68c8b2e7048mr1078331a12.1.1780261331044; 
 Sun, 31 May 2026 14:02:11 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bec86e19c57sm83064366b.63.2026.05.31.14.02.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:02:09 -0700 (PDT)
Message-ID: <2312a84d-09c8-4451-ad97-902b96c308fb@gmail.com>
Date: Sun, 31 May 2026 23:02:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 03/12] rockchip: clk: rk3188: add SCLK_OTGPHYx enable and
 disable
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, lukma@denx.de, marex@denx.de,
 u-boot@lists.denx.de, upstream@lists.phytec.de
References: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Add rk3188 SCLK_OTGPHYx enable and disable.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

	GATE(SCLK_OTGPHY0, "sclk_otgphy0", "xin24m", CLK_IGNORE_UNUSED,
			RK2928_CLKGATE_CON(1), 5, GFLAGS),
	GATE(SCLK_OTGPHY1, "sclk_otgphy1", "xin24m", CLK_IGNORE_UNUSED,
			RK2928_CLKGATE_CON(1), 6, GFLAGS),
---
 drivers/clk/rockchip/clk_rk3188.c | 34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/clk/rockchip/clk_rk3188.c b/drivers/clk/rockchip/clk_rk3188.c
index d8b03e1d7ab3..f350eac39fce 100644
--- a/drivers/clk/rockchip/clk_rk3188.c
+++ b/drivers/clk/rockchip/clk_rk3188.c
@@ -531,7 +531,41 @@ static ulong rk3188_clk_set_rate(struct clk *clk, ulong rate)
 	return new_rate;
 }

+static int rk3188_clk_enable(struct clk *clk)
+{
+	struct rk3188_clk_priv *priv = dev_get_priv(clk->dev);
+
+	switch (clk->id) {
+	case SCLK_OTGPHY0:
+		rk_clrreg(&priv->cru->cru_clkgate_con[1], BIT(5));
+		break;
+	case SCLK_OTGPHY1:
+		rk_clrreg(&priv->cru->cru_clkgate_con[1], BIT(6));
+		break;
+	}
+
+	return 0;
+}
+
+static int rk3188_clk_disable(struct clk *clk)
+{
+	struct rk3188_clk_priv *priv = dev_get_priv(clk->dev);
+
+	switch (clk->id) {
+	case SCLK_OTGPHY0:
+		rk_setreg(&priv->cru->cru_clkgate_con[1], BIT(5));
+		break;
+	case SCLK_OTGPHY1:
+		rk_setreg(&priv->cru->cru_clkgate_con[1], BIT(6));
+		break;
+	}
+
+	return 0;
+}
+
 static struct clk_ops rk3188_clk_ops = {
+	.disable	= rk3188_clk_disable,
+	.enable		= rk3188_clk_enable,
 	.get_rate	= rk3188_clk_get_rate,
 	.set_rate	= rk3188_clk_set_rate,
 };
--
2.39.5

