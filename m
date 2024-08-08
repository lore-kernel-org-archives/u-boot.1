Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87360C52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F73A88B9E;
	Thu,  8 Aug 2024 05:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="InPJ+CcP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 788E988AE5; Thu,  8 Aug 2024 05:15:04 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9280C88B03
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3db1657c0fdso417298b6e.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086898; x=1723691698; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kz94lu9Gp6TTEliC2UjCP43PfkTbwokeD+M420iZUXQ=;
 b=InPJ+CcPHRbNG/idGC8Jm8NpDaQdXuIbOzlARdtUYsyCy5BBKsWfIoBolMz/6Tg8a/
 9k9rogqgs5RxWyYVRWlRDVzpWPUuQN0ZhArhFXeLdU3bgGwUrWbxvr2a2iiYldva/CUx
 rOFIlRsUTdHAtbbNCI+zB54IBAQKvCjPlTnarrxVOYXMcsIDMr6/PW76/Bfc0BRhoieg
 voorpgyB70bxUDpgHvKO2d8Gxs+YeRfZ/jTCEPXV9wSQXdtx9c8wmbD2yDOPy+NTmmv5
 D/O5uhJr8h+i6+EPDHc4JkgvaSS+1aSlqUGh3WRSoRWLSeqXIGZVI1TotzVF/mPyEf2B
 WabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086898; x=1723691698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kz94lu9Gp6TTEliC2UjCP43PfkTbwokeD+M420iZUXQ=;
 b=FOHgod+AXNUhl6obrztFRVqGOgPElf/huFlvEQSKp/r5ULAv3aPlp/E+P2AtB7FEqi
 1c8GzZt16P/Tw+AjRKUeAUIZO0UwYD+YtGMo6zK38mk99s9MYErMLiwJdeLfUQCn0K6/
 1qA+PMKEY9UnLpFCQ6+ChQySocR7JoB1+urDqREYXFEGxwxWtSkdtPIC8IlXF3X+hjGV
 LaWgfPsHaGP+SpUYe2P/oKmzzkMnv+NN8MrY0jn9vzJqPNG7levxClMUjN8o1ZSe8Gon
 Wj1KZitOA4Wvk8vmKyFMmmS5wBnoHtMoU9LD6EMaOSOs13SSde/zUOS/xnlVly8YLw+4
 h/Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVEzDjiiClc1YYH2Yp9EcgowK0xeta3yLTNOhXeKlGIZqvfUoPh+QfNLH9oTezrVcXfECh7CbWzZjEnMire+fbh6M1UQ==
X-Gm-Message-State: AOJu0YyAqWY1cTrkYVLpkTmsGTgKToA32hv2Z9gpkbSpBWXN43NOMQbD
 HdwsXnKenNI7kz+kku/Ncw1GChzXMRR9Rigw0MWaZZVNTe8jEp2mjQz5rcHN0+g=
X-Google-Smtp-Source: AGHT+IEyTJ7F4EXEBghdVbtScj9osWu1rkJWzo700qXj5NwHJLrOYlq54v+8J3jUDfc7De0H17r81g==
X-Received: by 2002:a05:6871:b21:b0:261:1fdc:494a with SMTP id
 586e51a60fabf-2692b6a54c5mr778607fac.21.1723086898130; 
 Wed, 07 Aug 2024 20:14:58 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2689a2f2b2asm4339525fac.16.2024.08.07.20.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:14:57 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v5 18/38] mmc: exynos_dw_mmc: Fix getting private data in
 exynos_dwmci_board_init()
Date: Wed,  7 Aug 2024 22:14:24 -0500
Message-Id: <20240808031444.9619-19-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240808031444.9619-1-semen.protsenko@linaro.org>
References: <20240808031444.9619-1-semen.protsenko@linaro.org>
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
Changes in v5:
  - (none)

Changes in v4:
  - (none)

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

