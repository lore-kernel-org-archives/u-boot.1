Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F270FC54FB3
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 05:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B196E8334D;
	Thu, 29 May 2025 07:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="asr/dOoo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E2A083440; Thu, 29 May 2025 07:10:38 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F27D831D7
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 07:10:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ad93ff9f714so81367866b.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 22:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748495435; x=1749100235;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUnV+hfNFXkFeSGZ3gSZFM5IJaxRAjRgA8p1kH0pIy8=;
 b=asr/dOoo1z4TAz4gW3/bOfYd3GilRlukMa89lZkLfPH8h0KzTKtDE7Y/i6xm7LMOqU
 IZIvP7oYZYPeYBP9NTzz01TowA3nsQLQBn9ZApYvj8tQxHfOfHjZmzRqCWzhkSOrJEMk
 Lgda1MAYfqGI/QX56GJl6Douf/bfn8G9Likgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748495435; x=1749100235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uUnV+hfNFXkFeSGZ3gSZFM5IJaxRAjRgA8p1kH0pIy8=;
 b=g7a6A97UipiBuMWDaZGtaTiMXehItOqHgL+LzwFnokLWQ8etnhb9/sfEgunKAnaAAQ
 C9OWhwe3s2bL6WC/KCb5sW9mXFxbM75G+18fdH4dcqmtdT4H1F2dqmRpu9VS5UOhBo6s
 8QCZHB7WEqoucquO0PnKH7RpLGtPox5fNdAM0o0/wNLV6eZ9vQ7yCzUUz63ZMpe0Nav2
 kbJLJxbCGgytrPj7tFpWxypapGaQctyXFNGJ2Bpnw2F0gX4kBaV5j4JCaUN0E2AcFZJz
 XAGsrA74sUvF6WxM4bvxwiaxO5/ro5J/N+T4LP2tzBYqZg9RIHSoLUJrachV0WthwMed
 yFKA==
X-Gm-Message-State: AOJu0YyoZD0V4/PhpauJyzlOBldjaId6oaGODb2CyqTM7XPJ4uhQl4dm
 UWqP3/jiFvrEUdsDl9ifoNRmmWz83ZmY2WOUPoNPKert+zzFjQ402TfhZGM9i26N90g6LkiR7wh
 0Eu5kmalUKw==
X-Gm-Gg: ASbGnctenea0lpabdX/OGqbMQ1Svme07ebYt61dyc7pPMNqWSsgTdST5EG2WBSrrj58
 ROpMecjxkyaAWwC6AGz5h7o8ru7KDrsI3AkYZNAMQ9IX9WvvcZ0AUOWCX0PP4lOYOK0WBhB9Hjg
 GqJxq0wFrgpNwJ3JPFrEIjoMzA+QBe9PEwGRPUa7fM5lhHTTSABZNYn00EJZJLTAxpLKbBLaAaP
 Za2PgywChitkfPDCbY4tXtRcBy3TY3SziFXO+3O2e0UZTCzRLig2MpVLgHwf2ILCUWz2UwmJQh1
 qegF96thYt1/bH0CmsNg8MroWokQL1RWiKzT+hjzItg7XsRCWQwZ325SU0N0U0L+8ZsBPVstNih
 FCw1/Bjd8G2zr9lQ=
X-Google-Smtp-Source: AGHT+IGXTSQWuILOQv4xeJ0V1Kwifj2bF6oAk9mGpfAAwVedgaulV/NbYQ/xmJTYL9fvit4477y8Ug==
X-Received: by 2002:a17:907:724e:b0:ad8:9c97:c2dc with SMTP id
 a640c23a62f3a-ad89c97c636mr645663966b.15.1748495435624; 
 Wed, 28 May 2025 22:10:35 -0700 (PDT)
Received: from panicking.amarulasolutions.com
 ([2001:b07:6467:4426:71fa:236b:ca2b:119e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82becbsm70776566b.39.2025.05.28.22.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 22:10:34 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com, cniedermaier@dh-electronics.com,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 3/4] mtd: nand: Add support for EDO mode 1-5 to IMX6ULL
 platform
Date: Thu, 29 May 2025 07:10:17 +0200
Message-ID: <20250529051024.42340-3-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250529051024.42340-1-michael@amarulasolutions.com>
References: <20250529051024.42340-1-michael@amarulasolutions.com>
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

The clock driver allows to boost the NAND performance
controller. Make changes to let it use the new clock driver

=> time nand read ${loadaddr} kernel

NAND read: device 0 offset 0x500000, size 0x800000
 8388608 bytes read: OK

time: 0.488 seconds

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

---

Changes in v3:
- None

Changes in v2:
- Adjust commit message and include speed test result
- remove not needed { }

 drivers/mtd/nand/raw/mxs_nand.c    | 10 ++++++++++
 drivers/mtd/nand/raw/mxs_nand_dt.c |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/mxs_nand.c b/drivers/mtd/nand/raw/mxs_nand.c
index 80d9307cdd1..ba67466069b 100644
--- a/drivers/mtd/nand/raw/mxs_nand.c
+++ b/drivers/mtd/nand/raw/mxs_nand.c
@@ -1507,8 +1507,18 @@ static void mxs_compute_timings(struct nand_chip *chip,
 	writel(GPMI_CTRL1_CLEAR_MASK, &nand_info->gpmi_regs->hw_gpmi_ctrl1_clr);
 	writel(ctrl1n, &nand_info->gpmi_regs->hw_gpmi_ctrl1_set);
 
+	/* Clock dividers do NOT guarantee a clean clock signal on its output
+	 * during the change of the divide factor on i.MX6Q/UL/SX. On i.MX7/8,
+	 * all clock dividers provide these guarantee.
+	 */
+	if (IS_ENABLED(CONFIG_MX6ULL))
+		clk_disable(nand_info->gpmi_clk);
+
 	clk_set_rate(nand_info->gpmi_clk, clk_rate);
 
+	if (IS_ENABLED(CONFIG_MX6ULL))
+		clk_enable(nand_info->gpmi_clk);
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
