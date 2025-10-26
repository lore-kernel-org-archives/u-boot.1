Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78990CCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 01:07:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85174837E4;
	Sun, 26 Oct 2025 02:07:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PMUF0xx6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B3F283623; Sun, 26 Oct 2025 02:07:06 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB248836B4
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 02:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-44db1c1056cso118919b6e.0
 for <u-boot@lists.denx.de>; Sat, 25 Oct 2025 18:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761440822; x=1762045622; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ztW3EY69qYXS24WCkvLNDH4CYmAZ497Emxh6i5o/224=;
 b=PMUF0xx6TOjITXqdN75MGYgdJEpJ37Ir/1h7k+XU8kJIN5rZMdLcecKqhyt40MXwZ5
 p+XvXbjQOWZtPsww09+MBjBOlDYJ40dry7+Zk67h4re7Gk3bFj3gnBFVRoCaqqVUV++s
 PpkhNMreBtJpeb2/sY/3CT0K1X974ac/MnGcJrrTkEDh8Dc6/aEC/FcAZ4nosh7oCdIz
 vjRN1Zs2knxlq/g1wg5SodsKb2yOfk6N8MTPbRbVkJPn0oCTR2cJYU1L6WDWWVvqf66y
 hqmcYpdqg3G+ezZ4EqwMIT37nXKI+cAbsPvAmwQuIHBT4lkT0Ae4AmYYrm7nNZbh0GXN
 Iocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761440822; x=1762045622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ztW3EY69qYXS24WCkvLNDH4CYmAZ497Emxh6i5o/224=;
 b=K6WdB5kxEckkEVWNUtV0a5ncGPqDSBL7hDHUFZRzbIMQLFReD29r9QSQuJumUnHCov
 KLGTtC8v3UTbgyfNsCxbU7fQ5lH9Gq3xrZ1fpQGpFpTBKmMdXLdQ5zYvHLI78zE22R+7
 f0XyJjtV8HtHjbGLWSVrbvDX+p3RzLk5vdbRDnngtw0goPMgZfYqsbsXMSYt4M/8Pkm8
 mboyKxPuGK7R9hyUSy2OOqyGrtTnFTEzI0WslH/eUlK2ZeZHQojZSrbfCimYyFXccQ15
 QxBFtIkXJJ2KDBgv2jHACGQpqEYpFoZdRQs3Ns3rOvIveiCIpcpzrQfXMhIk0gwzrd8P
 xOhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiPOmvvZjkj3vENX5CLpau8WdjnsjG9hVATJmBtRvS17IJ4scTKdtGD24UEjC6rnSoq1yPVCk=@lists.denx.de
X-Gm-Message-State: AOJu0YxChQArte/XNkbIvW7LJ2BKs/AdCrs2K1jdf+9HcYy59R6nP4xQ
 Kty/3VANXrVNefmyj6rFQw2iMwYFP81iwxhLTfT6a2VLEuZyxluElwg7XLKGMMWkZPQ=
X-Gm-Gg: ASbGncvioTpC/MqIeHXACSic95E+iRGpeDBG5LSdyV7wrCiNxpiCAWEPOY0TC1wIhIg
 V0KyqfKmODOiYkXx3UKabSIGD9g+pdxv+/OEbIO9k+MELrCwaf3zyItFpY/YkRoxG23AAj8KHuv
 fLGqIsSSrTXhtr8eMd3sbMCXHSfbYR1LEGXUhSTk6+G3TMvg5X3pPz6CGRSJnHvPhfXD8asn+dq
 eVXVjuYnoM9HpWAg4lfsoIlbk/ZO/B9sD8g7wjVZ2wKOOLwWQBpS+qOtVNGKDK+yOKYnnxmRzZt
 dAcjGWsdJBcUiG3TeQwx3lL8O3nMttVEcNWD1n9eusr1fWFSHiSfdRrdF5izjsfy+1mtlh9etEa
 3+UY3ecjV6B1Qk1d9lnD1a+ogJkJ4rBu3aqck7+dpOM7iw41XG+0oVhN/jZOaf3kT25IEYGxFH0
 PS636MyV4ku7hQkO26L8AmjEi/CRR96Pw=
X-Google-Smtp-Source: AGHT+IEiunuctx1cJ5BBrQ1pJZR+N/N07U5enyu84aH8KjOUf6HsM2Y61gZADnkpKMs80tuDNVDRyQ==
X-Received: by 2002:a05:6808:152c:b0:43b:8b5e:d127 with SMTP id
 5614622812f47-44d93d96507mr3558544b6e.13.1761440822405; 
 Sat, 25 Oct 2025 18:07:02 -0700 (PDT)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-44da3e8cf1csm846695b6e.16.2025.10.25.18.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Oct 2025 18:07:02 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
 Simon Glass <sjg@chromium.org>, Anand Moon <linux.amoon@gmail.com>,
 Lukas Timmermann <uboot@timmermann.space>, u-boot@lists.denx.de
Subject: [PATCH 3/6] mmc: exynos_dw_mmc: Improve coding style
Date: Sat, 25 Oct 2025 20:06:55 -0500
Message-Id: <20251026010658.19271-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251026010658.19271-1-semen.protsenko@linaro.org>
References: <20251026010658.19271-1-semen.protsenko@linaro.org>
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

Exynos DW MMC glue layer driver have seen a lot of changes recently.
Stabilize the coding style.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 190c6349380d..51867a552495 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -26,11 +26,16 @@
 #define EXYNOS4412_FIXED_CIU_CLK_DIV	4
 
 /* CLKSEL register defines */
-#define CLKSEL_CCLK_SAMPLE(x)	(((x) & 7) << 0)
-#define CLKSEL_UP_SAMPLE(x, y)	(((x) & ~CLKSEL_CCLK_SAMPLE(7)) |\
+#define CLKSEL_CCLK_SAMPLE(x)		(((x) & 7) << 0)
+#define CLKSEL_UP_SAMPLE(x, y)		(((x) & ~CLKSEL_CCLK_SAMPLE(7)) | \
 					 CLKSEL_CCLK_SAMPLE(y))
 
-/* Quirks */
+/**
+ * DOC: Quirk flags for different Exynos DW MMC blocks
+ *
+ * %DWMCI_QUIRK_DISABLE_SMU: DW MMC block has Security Management Unit (SMU)
+ * which has to be configured in non-encryption mode during driver's init.
+ */
 #define DWMCI_QUIRK_DISABLE_SMU		BIT(0)
 
 #ifdef CONFIG_DM_MMC
@@ -183,9 +188,11 @@ static unsigned int exynos_dwmci_get_clk(struct dwmci_host *host, uint freq)
 	int err;
 
 	/* Should be double rate for DDR or HS mode */
-	if ((host->mmc->selected_mode == MMC_DDR_52 && host->mmc->bus_width == 8) ||
-	    host->mmc->selected_mode == MMC_HS_400)
+	if ((host->mmc->selected_mode == MMC_DDR_52 &&
+	     host->mmc->bus_width == 8) ||
+	    host->mmc->selected_mode == MMC_HS_400) {
 		freq *= 2;
+	}
 
 	clk_div = exynos_dwmmc_get_ciu_div(host);
 	err = exynos_dwmmc_set_sclk(host, freq * clk_div);
@@ -302,7 +309,7 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 #if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 static int exynos_dwmmc_get_best_clksmpl(u8 candidates)
 {
-	u8 i;
+	int i;
 
 	for (i = 0; i < 8; i++) {
 		candidates = (candidates >> 1) | (candidates << 7); /* ror */
@@ -317,8 +324,8 @@ static int exynos_dwmmc_get_best_clksmpl(u8 candidates)
 	}
 
 	/*
-	 * If no valid clock sample values are found, use the first
-	 * canditate bit for clock sample value.
+	 * If no valid clock sample values are found, use the first candidate
+	 * bit for clock sample value.
 	 */
 	for (i = 0; i < 8; i++) {
 		candidates = (candidates >> 1) | (candidates << 7); /* ror */
@@ -344,7 +351,7 @@ static int exynos_dwmmc_execute_tuning(struct udevice *dev, u32 opcode)
 	do {
 		dwmci_writel(host, DWMCI_TMOUT, ~0);
 
-		/* move to the next clksmpl */
+		/* Move to the next clksmpl */
 		smpl = (clksel + 1) & 0x7;
 		clksel = CLKSEL_UP_SAMPLE(clksel, smpl);
 		dwmci_writel(host, priv->chip->clksel, clksel);
@@ -360,12 +367,11 @@ static int exynos_dwmmc_execute_tuning(struct udevice *dev, u32 opcode)
 		return ret;
 	}
 
-	dwmci_writel(host, priv->chip->clksel,
-		     CLKSEL_UP_SAMPLE(clksel, ret));
+	dwmci_writel(host, priv->chip->clksel, CLKSEL_UP_SAMPLE(clksel, ret));
 
 	return 0;
 }
-#endif
+#endif /* CONFIG_MMC_SUPPORTS_TUNING */
 
 struct dm_mmc_ops exynos_dwmmc_ops;
 
@@ -396,7 +402,7 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 	flag = host->buswidth == 8 ? PINMUX_FLAG_8BIT_MODE : PINMUX_FLAG_NONE;
 	err = exynos_pinmux_config(host->dev_id, flag);
 	if (err) {
-		printf("DWMMC%d not configure\n", host->dev_index);
+		printf("DWMMC%d not configured\n", host->dev_index);
 		return err;
 	}
 #endif
@@ -499,4 +505,4 @@ U_BOOT_DRIVER(exynos_dwmmc_drv) = {
 	.priv_auto	= sizeof(struct dwmci_exynos_priv_data),
 	.plat_auto	= sizeof(struct exynos_mmc_plat),
 };
-#endif
+#endif /* CONFIG_DM_MMC */
-- 
2.39.5

