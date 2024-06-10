Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A165C27C53
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56FAA8851E;
	Mon, 10 Jun 2024 03:12:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AlGoqp7t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1256884FE; Mon, 10 Jun 2024 03:12:44 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D9ED884AA
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3d2280a3d1fso331727b6e.3
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981961; x=1718586761; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0FlBtORU2YphyJoC9ALjRrQBtrihTvdGD8zX7T+j5s=;
 b=AlGoqp7tVOuswOv4+LFM0mEpcDMepOn1j0ZvqHV53Bv8EWxzaPdW0ZpecP9E0zlCEb
 +WnP/mWWXNMiujru1oykd/bsBOD3aGrR2NMtsW1nfd8pT+Nf2yxp2hh85rPxysQkEZcP
 /ej5GvZ1o5d6Im0UrHYfn9NflQZd2ySOATDbZ0BiNDBwz/+Dk3Uj03LYKnhR+Ln4uozO
 OIjcRnmIC2jOR9k8/Vr9dU2ASbayaomVKYDjnokA9Tk5sxFTakn1y6T9o5//1j7MyrEq
 HH5nBshoMCR5j70G5Ex77petHsJ5Di6RHG3xFcLv/5KI7/vkbX3yKkin2TKrsxeuX88q
 oQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981961; x=1718586761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0FlBtORU2YphyJoC9ALjRrQBtrihTvdGD8zX7T+j5s=;
 b=LluoBVQFYMudbuFebPbWzY/Xf5A444wAox+mBDoFrWr3jSrYU3dBroEaB1fJQZNeEs
 dN83Kd+5JLEQcwY1/eoYFJ6V9aCSK3VbiGzAhdCAqHvaDh7ifh11FPCkOTvelD07OyKU
 VB1PYtd8QwZdSn9drq62DIzsIRLpPPL53R84xTs+M40paW73shyWnBdya6//042dohIq
 wAPMziHxCSILCSftRT6vJLQTE0R5TULUhDJhhvMBe/yQSvGdYHoAZ9cjYvhE12MiGMfl
 o/NWEftc3xmd3uCp3GNOggOFT0t5oS50TsUJd8eT1skUNpk/ywNEjcgmJpuuCxW/jfJo
 5K9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwqFFvkrNpzreYaXNFIdSongb423jIGZOaG9sQeJdS8B3w1dJI47o1l3ZlDKfneO2ERhBqqs2qYJibDrcH246I1TTt4w==
X-Gm-Message-State: AOJu0YzhPhtYxwRNBv60bxpy1Bj3O0uT39wAid06BJjjV5yE5CTGiIOT
 fcGhq0ULeKLj9OnXrCuysY7fC7dtUkHPAg6CbNXoaUDW45VXcO+wJ0QCZ+csQ2Y=
X-Google-Smtp-Source: AGHT+IFxxqERDTF8xh6wfzVIo92ygEBIBQ/s9RXnOA3qDsaXi1rJuDNzdzXkWh2DtI6xpEUYnD8JPw==
X-Received: by 2002:a05:6808:2f06:b0:3d2:29d6:fe7e with SMTP id
 5614622812f47-3d229d70078mr1650777b6e.21.1717981960762; 
 Sun, 09 Jun 2024 18:12:40 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d22a9c72ddsm132117b6e.34.2024.06.09.18.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:40 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v2 19/40] mmc: exynos_dw_mmc: Fix getting private data in
 exynos_dwmci_board_init()
Date: Sun,  9 Jun 2024 20:12:05 -0500
Message-Id: <20240610011226.4050-20-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610011226.4050-1-semen.protsenko@linaro.org>
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
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
 drivers/mmc/exynos_dw_mmc.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 1f69e193f601..8e80bd6a059f 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -42,18 +42,24 @@ struct dwmci_exynos_priv_data {
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
@@ -83,7 +89,7 @@ unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
 
 static void exynos_dwmci_board_init(struct dwmci_host *host)
 {
-	struct dwmci_exynos_priv_data *priv = host->priv;
+	struct dwmci_exynos_priv_data *priv = exynos_dwmmc_get_priv(host);
 
 	if (host->quirks & DWMCI_QUIRK_DISABLE_SMU) {
 		dwmci_writel(host, EMMCP_MPSBEGIN0, 0);
-- 
2.39.2

