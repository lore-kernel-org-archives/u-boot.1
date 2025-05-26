Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5195AC54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 19:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC10282E67;
	Mon, 26 May 2025 21:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="S7968weV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08EC082F8F; Mon, 26 May 2025 21:48:26 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0792482F50
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 21:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6046ecc3e43so2602716a12.3
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748288903; x=1748893703;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LeYUTV5Ko+ksKJ7q3fDvbj3xP8rbbV9nfGiKLy/K2EY=;
 b=S7968weVPdb5JLcBoPrROD/ZRlkF8swxVnchYs2mU9KCnB4wIRta2MiZ1hY1DAQlZX
 SsNzdsW9RaI6O/mwvEE/y5ME7UYTLYqncp8HSx/YRnbAz6+okql4CVpjnXH0Kk5RDdy9
 xdsVUppa4i+GY8gpl2roO7WBRlttjn0rlqFco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748288903; x=1748893703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LeYUTV5Ko+ksKJ7q3fDvbj3xP8rbbV9nfGiKLy/K2EY=;
 b=iHG6WxzEWu6nGYciGyCGvH4crHuMR3VdzWpyLYB0ZqfEUF8lAuVdpSJo/Cq8yO8uoY
 LLuePjFgvsXmrgdZsklL2SKMvHIbDcuN0l9VFXddn0cXp+CDKiNh8CBBhA6P69bNkkqT
 F1o4NKZkZtFkKlqQ37A68WoN5bcSKtTn2uncbvaqsA1s2C/lkxkxXeFjMDLLunvxoysS
 WzhHvB26A85ylxsfYgICsZ8fmTCbPdCgMCtdYhdoPTLbQnOv0H0Y3onvUvKbIg2hy1y9
 gPeTUST9naCGwnPv+mn0NX02h/MVdEYZREbPjHOIkPd4d00DU1DIseJ4GeMEOO5Rrnk8
 wPNA==
X-Gm-Message-State: AOJu0YzAKFee8M1htuszHiF68DGM3/EZc/9HV8L1PQpaX28S4djySCHz
 HhkQJ1bczKYodMISNlJELE/vD+plW92Pb4ZCPA3ibWkWJ7bsQQmx7IeRtnMkdtmy0Sd5U1Dp0LO
 mAqzFqM+3Xw==
X-Gm-Gg: ASbGnct84Szkvig9IQzBH9ySjuq7kHi1AB2W3yklGtAfRn493WkFPpkqQNWQf5WUUf4
 T9y3tpjPmRXcY3IiqfoDCzm/u2a06LEUSa0r+ZyYylxiwP+s7+uUbKgPSZsEpVUl9o3pS5jmKwS
 /92hdozBKimSYbf5j/xzL1Tkx9TWLNB1xytGHs9wqFxNBmWXKNdTFgWGcnM6vyqX5BGUHDiLeuu
 teFcOHAyO+QjoClq7Sxu+pDXTdRZ1KMi/Wj3T46sSJuB/X+hKOZ92czilW6GENTzWMI9BOCyxTy
 8xGwdETtlHz/9UsxyZB/ns5GvYQj9i4fylG5WfwE3f0R4z/93xJ0p+RUFbFwE5F5K3/DiXVQ1XM
 =
X-Google-Smtp-Source: AGHT+IHVJ2Sp7EEQslXYEID9IzTERwVUCDvRuDpA41APBhkfPLsZMusqEOaBBTH0xwRdXHQGb4LrRg==
X-Received: by 2002:a05:6402:50d1:b0:602:262f:1de7 with SMTP id
 4fb4d7f45d1cf-602d9bf926fmr7256977a12.2.1748288902823; 
 Mon, 26 May 2025 12:48:22 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6467:4426:e776:7e5f:5044:b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-604c0084c2dsm1416109a12.3.2025.05.26.12.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 12:48:22 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/4] mtd: nand: Add support for EDO mode 1-5 to IMX6ULL
 platform
Date: Mon, 26 May 2025 21:48:01 +0200
Message-ID: <20250526194811.1179530-3-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526194811.1179530-1-michael@amarulasolutions.com>
References: <20250526194811.1179530-1-michael@amarulasolutions.com>
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
