Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6289C5AD49
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 15:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65A3483291;
	Fri, 30 May 2025 17:17:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lEGDASjS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 554F28331F; Fri, 30 May 2025 17:17:06 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61546832F0
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 17:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-602c3f113bbso4030957a12.0
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 08:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748618223; x=1749223023;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uw3q27WSD4rzObVHdjBKmyvGKhg7mwFD7PSI47LuDS0=;
 b=lEGDASjS3HgQAFtHnQ0mtlVpk3qzbqqkpaHjubFUA23qre4zNxBPjDjAAxZUJHIxM7
 TsAwPzREs3Tx9O6V+t0hMaqlIDDQ0IwghsN7gODjp7pkMlL+Md/xMuKKncC8U5cMJVM5
 23S0f1EgDRAariulJAwcbmRBDBaUvafrSvSVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748618223; x=1749223023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uw3q27WSD4rzObVHdjBKmyvGKhg7mwFD7PSI47LuDS0=;
 b=U+Fw1DpCNf1OwZEgVo4jyt0f7mR2TDJnmH94oMhiMIVF0bDjHMnQGogptVwl7m4/1k
 uSc2DLWo6LtdJdWeDRuAbtsUquK6JJS/vRDzaIcQmC2160tY3CI647e44XEW6YbeJmrw
 euh7ZSLOJw5pkwWTgZclxWCOKuXjVsqdSdzGgWz9n7AoRMPPQGDplKYY7V3rdCmu/dNG
 fwfG/GZLxYE6bu1RE0FPDpmCzUGQDOFvc5EZPUxIUgNUdPbkdKq22q/ETnGq90tw9MY9
 +/2hhiCY5xYxzCkmP9kA+ZOLFiGLUvzYJiEYfSM3oO/wp3CE0Ay3M5siNMpmHABSEZrC
 5KCQ==
X-Gm-Message-State: AOJu0YxTGtA/Nl2n7Y6v/vBX7Ah3Dbr6lwpULKg0jKUZYpW/nwRgDXJl
 LtJJhHc7B+6caph/4o3FiIa9xWD/pAUxC7E5hoDzx+8OkcmOZDjrFOjJ9ildwOoK2L0fURMDu68
 a19WKLT4=
X-Gm-Gg: ASbGncseJz9HEfVfEw4NSoPoIUxGsoRlIlwAZRYOrf6mseuc9T68xtaDySx5MX86lT8
 RX5t5e+S2HFB5L3nBYYvabB/mYBt2lgCxcwO0fbYjxGzRwK782+00U4i3HzQWWMdDz5VVrnVBgk
 2pbpkKNpSCtYzTg0pagashbNCmwjMeevvMCTq6nn+mg29LcZnwV/v5ZRMF37x1pwrsLqUYRr84I
 5rpgwWj9WnssxMhr/9brUjDTWXNky5d3sgULL9NLHwKV6U/XOxTjehkJBN47N6Ro9dhaXcltBZg
 1XgmCvsn58kHuVbvFS1ZV8j16P5BEzij7C5JLSpmM28Li/+MkYQMlIkxPriTzIRDKiSy8v41vaD
 dStYCBrFnZG5WnwEIKgV9WYNB
X-Google-Smtp-Source: AGHT+IGXRPaEF0nqqK8m0Wo0bHHnx47VbWGGBT1BTY2lGFgudv1zcEmQZVxu3XdjEPgY5pBzGD9ojQ==
X-Received: by 2002:a17:907:d92:b0:ad5:6b8a:a0a6 with SMTP id
 a640c23a62f3a-adb3259a228mr384768966b.58.1748618223329; 
 Fri, 30 May 2025 08:17:03 -0700 (PDT)
Received: from panicking.. (mob-176-245-161-96.net.vodafone.it.
 [176.245.161.96]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82dd12sm345507966b.58.2025.05.30.08.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 08:17:02 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com, cniedermaier@dh-electronics.com,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 3/4] mtd: nand: Add support for EDO mode 1-5 to IMX6ULL
 platform
Date: Fri, 30 May 2025 17:16:45 +0200
Message-ID: <20250530151653.3695020-3-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530151653.3695020-1-michael@amarulasolutions.com>
References: <20250530151653.3695020-1-michael@amarulasolutions.com>
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

Changes in v4:
- None

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
