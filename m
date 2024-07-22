Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75FFC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97CE588214;
	Mon, 22 Jul 2024 19:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fjfedCg0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A98D884AC; Mon, 22 Jul 2024 19:57:58 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E573884DC
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-260e5b2dfb5so2637409fac.3
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671075; x=1722275875; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H/9bLsSODM8QlNrXZwkKXMW66HF6+d8MEEjib5AaJSY=;
 b=fjfedCg0TReC3A018fXmy5Tu6uN91G9YJILAzPDYbD/Olnph3kp2PXy8FgEbGHHCW+
 wVDU+TRNraXQqB+KsK3YX5JIMfVE7k9KEpcj5xwkgQZwo3V4TfQ2l6wLH9E2eS6bBt20
 YjcZe2vejNXxFeFvMIuljqtN1cPg9Fn2mptWkpBzAj4L0pzRYbyrESy8Rc8RbQhCznOl
 z0easfrswg27r8W6rMoEENvh0lYfm3PBI3ofkGfUj+xn3tex958Rn6Gyq9i5XvOCVnEx
 NOktrm1QOVhI2xy4X9jFxBXETn1TKtR7Q8vpg9UQXJX+S6tPNgRqG8LVCFQ63vM3xb0C
 36BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671075; x=1722275875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H/9bLsSODM8QlNrXZwkKXMW66HF6+d8MEEjib5AaJSY=;
 b=m4MTk92dtpDk3nYnMH4itzN5odguaVC3niaKyyuumsIGEN85IpxTwwDbzeMIlmyzof
 VnzYZqUG5woWMlRtLBwpp3svL9f3wM/tb2HHHUwbSyp9xUaEjbzdiQU5JGEKmuXiI5B8
 Sapj6XsenURWT1JiMduCGTA3HAfVn/VhXhZGT4pZNVhFvZDeFNxEB4dGIdXmQIEDe9FC
 pL2uUzaYvlBk6w0q32Ptx7YoRfNQX3AtCsO/pWCTiCz8OIwu6QkljTtZM15gt5YYYIBV
 RUphyZzE9h2F/hqqC3ZJWxQNUP/yTi0JDbTJmU4DHUZhVo1D3X+/xtvb1pxawsXAZrbJ
 HiEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhs27BctvFOjq7pzAL7tkxEpcbbOPd1DwpT86TszxACg1Dui7vwn8D6Gnvwm7Lk5fIQJnRhU6n6LD/+4Ii+MsX2F0GJg==
X-Gm-Message-State: AOJu0YyBOlu/0IGoqkityzPobvgizNlnrKjSzH/wm7fD5uDYC6au1xqd
 xhUmgiLZQRwOQq39V3JpKzR1wwqgSxhl8Ce7qaGMQvwNZPs61YIr9bNpVyd0bZ0=
X-Google-Smtp-Source: AGHT+IF3Su/FEsZR2A2JJ12fVaapiYUjjldnwSSPJR7kpfscwOeZ5i2Lo+F1b8UOp8y+FExF/jV4Xg==
X-Received: by 2002:a05:6871:80e:b0:261:1267:fe95 with SMTP id
 586e51a60fabf-264690938d6mr395447fac.9.1721671075077; 
 Mon, 22 Jul 2024 10:57:55 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2610c76db96sm1787543fac.14.2024.07.22.10.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:57:54 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>,
	Minkyu Kang <promsoft@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 18/38] mmc: exynos_dw_mmc: Fix getting private data in
 exynos_dwmci_board_init()
Date: Mon, 22 Jul 2024 12:57:20 -0500
Message-Id: <20240722175740.6985-19-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722175740.6985-1-semen.protsenko@linaro.org>
References: <20240722175740.6985-1-semen.protsenko@linaro.org>
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

In case of CONFIG_DM_MMC, host->priv actually holds (struct udevice *),
and not (struct dwmci_exynos_priv_data *). This makes *priv pointer
invalid and may lead to Synchronous Abort during its dereference later
in exynos_dwmci_board_init(). Fix it by extracting
exynos_dwmmc_get_priv() helper from exynos_dwmci_clksel() and using it
for getting the private data in exynos_dwmci_board_init()

Fixes: 3537ee879e04 ("mmc: exynos_dw_mmc: support the Driver mode for Exynos")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - (none)

Changes in v2:
  - (none)

 drivers/mmc/exynos_dw_mmc.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index a86d58663c1b..aa542c13fea8 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -41,18 +41,24 @@ struct dwmci_exynos_priv_data {
 	u32 sdr_timing;
 };
 
+static struct dwmci_exynos_priv_data *exynos_dwmmc_get_priv(
+		struct dwmci_host *host)
+{
+#ifdef CONFIG_DM_MMC
+	return container_of(host, struct dwmci_exynos_priv_data, host);
+#else
+	return host->priv;
+#endif
+}
+
 /*
  * Function used as callback function to initialise the
  * CLKSEL register for every mmc channel.
  */
 static int exynos_dwmci_clksel(struct dwmci_host *host)
 {
-#ifdef CONFIG_DM_MMC
-	struct dwmci_exynos_priv_data *priv =
-		container_of(host, struct dwmci_exynos_priv_data, host);
-#else
-	struct dwmci_exynos_priv_data *priv = host->priv;
-#endif
+	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
+
 	dwmci_writel(host, DWMCI_CLKSEL, priv->sdr_timing);
 
 	return 0;
@@ -82,7 +88,7 @@ unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
 
 static void exynos_dwmci_board_init(struct dwmci_host *host)
 {
-	struct dwmci_exynos_priv_data *priv = host->priv;
+	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
 
 	if (host->quirks & DWMCI_QUIRK_DISABLE_SMU) {
 		dwmci_writel(host, EMMCP_MPSBEGIN0, 0);
-- 
2.39.2

