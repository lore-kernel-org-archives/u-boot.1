Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB3BC54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 12:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66E0682C13;
	Sun, 25 May 2025 14:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NptlNC5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79D6D82BD9; Sun, 25 May 2025 14:23:32 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86D0A82BD9
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 14:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ad1f6aa2f84so278476566b.0
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 05:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748175809; x=1748780609;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rcJwLoTiy3ZwUy9RhQemmY/cJMjUIwxbu35gBg2c7AA=;
 b=NptlNC5dTLjhEcmUq3NMIjaWogJ5GK8OP4FTPNVOvOKMiJI9VcCy8mUG7M6ORewJTZ
 Pz/SBgRR308pqhSj2YCUw9aS6k1YrtlcwJ9T2LBcB3N7JoiHAXOz2773D6nsmUZWwfAl
 aohgatF4LomKwjk8s40CQcxurkoZE+kxtwTI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748175809; x=1748780609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rcJwLoTiy3ZwUy9RhQemmY/cJMjUIwxbu35gBg2c7AA=;
 b=TGB7iD0b4SjyCMpv5Du/L5Ov3SfWU1/INrSHOLfWZvPm77PGpDy6djDPshLuvnYMyo
 CWo/elKsQvcfmMUUxfXL8Qv2vEPmO4TpJr6jYsZZv2lDoT1cjJ98XHWDiV0toTwjrG+W
 EYIfvhx2S3bLJDFgrJ7fjvqhQMLwtPrtWgHxNAwX0/ogpUe7+1cUlPLiivYLTHRef39n
 5L5wDuKMKXDul4aeYciyYrlJO7nnu7/LPpRBPb6fR7EfRTWq5iDwpSkmekz6Azjw9cra
 4KJLuez8XfI6M0xl78CBRJwTZX2C914kLOprReOmao+7EWMPpCq5cKI4lI0f1pz/v/fg
 ZdQg==
X-Gm-Message-State: AOJu0YznMnATdI0MUKcuUVhF/ADZNQV0/lspXm2hN7vHFhiROHsALCf7
 Ifa7PgtPjIIzllIqEjXbum112fQdY5J3sZu7MK+kZhsrABl+mb29oqoE8izCy5OKEIHxWGbIb73
 O0kTe2axN4A==
X-Gm-Gg: ASbGncsTamMlRSWoHvtE3GX99DMX4JsanXnMAtCMG+C8zXzGXsickAz5i+4DYmeKwTZ
 aRpXz7NELV0d17W6yygG/8C819qPnupVcff/3OmJBmMwr63XgPMO8GHQHl6Vp6P/cRGJ7U4xh8c
 o268ZZMB16/DdKoBH34x8qqLTcy1KhbS6fp/F8TsgRYCPTjleOwRaw2bP0gGOVYKRhFADZiiTMx
 Ns1F3H5PP4MIAGGI2C/4aFrTEaJ4+nBgTDjNIYAEDehhYNzXeNLeQ5KyOJzCk2Z4EiMDnzJi3qG
 nSSIST/yvOMMDFwZZR/3naSoaIMzktJvXm9A2y99rYfQ+xQu1cF8cAhfnWO9jnK2exlTwABRhLI
 r8eHgap0fE3/asQ==
X-Google-Smtp-Source: AGHT+IEtyBwvJlffJURKyzWfT6fumMjawY7Rk+HVvCedkST8SclMP6WRoaOjJIKjwog8v59AylaDDA==
X-Received: by 2002:a17:907:7f86:b0:ad5:4cde:fb97 with SMTP id
 a640c23a62f3a-ad64e8c5edemr746525566b.29.1748175809439; 
 Sun, 25 May 2025 05:23:29 -0700 (PDT)
Received: from panicking.amarulasolutions.com
 ([2001:b07:6467:4426:33ec:9e56:eca:2394])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4383f8sm1517982366b.113.2025.05.25.05.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 05:23:28 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/4] mtd: nand: Add support for EDO mode 1-5 to IMX6ULL
 platform
Date: Sun, 25 May 2025 14:23:11 +0200
Message-ID: <20250525122316.661999-3-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250525122316.661999-1-michael@amarulasolutions.com>
References: <20250525122316.661999-1-michael@amarulasolutions.com>
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

The clock driver allow to burst the performance of the nand
controller. Make changes to let it use the new clock driver

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---

 drivers/mtd/nand/raw/mxs_nand.c    | 12 ++++++++++++
 drivers/mtd/nand/raw/mxs_nand_dt.c |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/mxs_nand.c b/drivers/mtd/nand/raw/mxs_nand.c
index 80d9307cdd1..2679b6ab650 100644
--- a/drivers/mtd/nand/raw/mxs_nand.c
+++ b/drivers/mtd/nand/raw/mxs_nand.c
@@ -1507,8 +1507,20 @@ static void mxs_compute_timings(struct nand_chip *chip,
 	writel(GPMI_CTRL1_CLEAR_MASK, &nand_info->gpmi_regs->hw_gpmi_ctrl1_clr);
 	writel(ctrl1n, &nand_info->gpmi_regs->hw_gpmi_ctrl1_set);
 
+	/* Clock dividers do NOT guarantee a clean clock signal on its output
+	 * during the change of the divide factor on i.MX6Q/UL/SX. On i.MX7/8,
+	 * all clock dividers provide these guarantee.
+	 */
+	if (IS_ENABLED(CONFIG_MX6ULL)) {
+		clk_disable(nand_info->gpmi_clk);
+	}
+
 	clk_set_rate(nand_info->gpmi_clk, clk_rate);
 
+	if (IS_ENABLED(CONFIG_MX6ULL)) {
+		clk_enable(nand_info->gpmi_clk);
+	}
+
 	/* Wait 64 clock cycles before using the GPMI after enabling the DLL */
 	dll_wait_time_us = USEC_PER_SEC / clk_rate * 64;
 	if (!dll_wait_time_us)
diff --git a/drivers/mtd/nand/raw/mxs_nand_dt.c b/drivers/mtd/nand/raw/mxs_nand_dt.c
index b62474bc5ab..90eefa2558d 100644
--- a/drivers/mtd/nand/raw/mxs_nand_dt.c
+++ b/drivers/mtd/nand/raw/mxs_nand_dt.c
@@ -99,7 +99,7 @@ static int mxs_nand_dt_probe(struct udevice *dev)
 	info->use_minimum_ecc = dev_read_bool(dev, "fsl,use-minimum-ecc");
 
 	if (IS_ENABLED(CONFIG_CLK) &&
-	    (IS_ENABLED(CONFIG_IMX8) || IS_ENABLED(CONFIG_IMX8M))) {
+	    (IS_ENABLED(CONFIG_IMX8) || IS_ENABLED(CONFIG_IMX8M) || IS_ENABLED(CONFIG_MX6ULL))) {
 		struct clk_bulk clk_bulk;
 		info->gpmi_clk = devm_clk_get(dev, "gpmi_io");
 
-- 
2.43.0

base-commit: df2ed552f0b05591090369a7fe7ddc92439dea5c
