Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1021FC5AE59
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 05:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CA0E832AF;
	Thu, 29 May 2025 07:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FLYIrnCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CADA383321; Thu, 29 May 2025 07:10:36 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB1148331D
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 07:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ad93ff9f714so81365866b.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 22:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748495434; x=1749100234;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ddRfdws/1ZICMkV8HKkJsnoMhfx5HcXIctmfu9mzWRc=;
 b=FLYIrnCAzPrXFiqEP80C4cIG5ivGzoE94izH2/u00SKjKHgPcLudvmxCXx7/4U2o2B
 A7xwpKP3ll0NfIBZpc/n+DcTObHpl3lkvHcTss+cXoefIEzusWsT81RN3juGfutNOHSf
 NWyYECgyGFSm027dlPYx4Ty5i/Ldrg60SMnj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748495434; x=1749100234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ddRfdws/1ZICMkV8HKkJsnoMhfx5HcXIctmfu9mzWRc=;
 b=b6eJE0FtLdgbUM75ThAgFkVvCxvXlcnWh+56yf1iOLa33NDnp66tmNwIXO1n+LTr4H
 24TgA5RAMbjOQP7X5zp8r96ohNAYLYPDe4qXpWcWR5ES+TKUNJYsE38vyaOmi256mKG8
 Dr6NSEKBcfkBDiXfgFhUhQnOtIp5SsYkxC9IaHrB+tiVkKh3T3gN0HcmyfKu86o7sWFF
 79iTiCodHMc+NKgglYlFD9M9R33Rzt93PVg7sHdkbzo99Y1oPRJbytmGhtsdqZet85Wk
 tidNiLUKe2EpYTCXdusZj2IT+zPoNYaoqmA728dzfzeFABPOUS7MCLgcmrgr0Ucltxia
 oXyg==
X-Gm-Message-State: AOJu0YxbkMYFMxUdpkDqsLebEuZEw40/iup8F2EEVhAfrPtxBJ8srzvQ
 t5q44zyescsp298ANkjx2s3ssUKi1JNFw6gXNfOEQzF36YI9eV81N6ORSWOGEX+lOUxTH2hUqcv
 jyAHNjEW+Pg==
X-Gm-Gg: ASbGncv5OPR76/9TYzCxmQVQq0hIJhiykKThjQoHtoXDmGEIFLAhbWlBwsa/FqLECfL
 Zz3DHxQRNj/t1x3EAMRvzLgmLRLWtI5N7A56lxlbnXguBv4gjFE+HntcumSnsoPq768J/+CSDRI
 xIIoOCCB+hLkrpYVkdXEa3EFTzORlve+02+QOV1RHZ2hNFBbENHk4LOKG6wGW9ad4W9B+WKLPEU
 mA5OWbeUAfwvc2KScd4swFrNKQJ10AC2/8LKD7m/Uc/HxNNZfI7FWsyMVJF9ENxb5n8Iag1qfsE
 XhUsSLvZ+nJdZsu4vaPHc3JriW/mlHvHEppmYfAXv9qkwoP0LxHaATLrDKVkdg7H+dInHKb024K
 1k0KklVcmSLQdb8Q=
X-Google-Smtp-Source: AGHT+IGBSa80A5Ewtkztd0gFGPQiFu0opfNPpnAzylq7x1jzDGlLz1hzcDrsrmuOGkuYmH9B2sVmzw==
X-Received: by 2002:a17:907:25c7:b0:ad2:1f65:8562 with SMTP id
 a640c23a62f3a-ad85b083bccmr2009809666b.14.1748495433638; 
 Wed, 28 May 2025 22:10:33 -0700 (PDT)
Received: from panicking.amarulasolutions.com
 ([2001:b07:6467:4426:71fa:236b:ca2b:119e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82becbsm70776566b.39.2025.05.28.22.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 22:10:32 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com, cniedermaier@dh-electronics.com,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/4] mtd: mxs_nand_dt: Move from clk_get/clk_enable to
 clk_bulk api
Date: Thu, 29 May 2025 07:10:16 +0200
Message-ID: <20250529051024.42340-2-michael@amarulasolutions.com>
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

Make simple the clock registration and enable and allow later
to add support for other platforms

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

---

Changes in v3:
- None

Changes in v2:
- no changes

 drivers/mtd/nand/raw/mxs_nand_dt.c | 48 ++++--------------------------
 1 file changed, 5 insertions(+), 43 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxs_nand_dt.c b/drivers/mtd/nand/raw/mxs_nand_dt.c
index 11dbcbbf442..b62474bc5ab 100644
--- a/drivers/mtd/nand/raw/mxs_nand_dt.c
+++ b/drivers/mtd/nand/raw/mxs_nand_dt.c
@@ -100,9 +100,7 @@ static int mxs_nand_dt_probe(struct udevice *dev)
 
 	if (IS_ENABLED(CONFIG_CLK) &&
 	    (IS_ENABLED(CONFIG_IMX8) || IS_ENABLED(CONFIG_IMX8M))) {
-		/* Assigned clock already set clock */
-		struct clk gpmi_clk;
-
+		struct clk_bulk clk_bulk;
 		info->gpmi_clk = devm_clk_get(dev, "gpmi_io");
 
 		if (IS_ERR(info->gpmi_clk)) {
@@ -111,47 +109,11 @@ static int mxs_nand_dt_probe(struct udevice *dev)
 			return ret;
 		}
 
-		ret = clk_enable(info->gpmi_clk);
-		if (ret < 0) {
-			debug("Can't enable gpmi io clk: %d\n", ret);
-			return ret;
-		}
-
-		if (IS_ENABLED(CONFIG_IMX8)) {
-			ret = clk_get_by_name(dev, "gpmi_apb", &gpmi_clk);
-			if (ret < 0) {
-				debug("Can't get gpmi_apb clk: %d\n", ret);
-				return ret;
-			}
-
-			ret = clk_enable(&gpmi_clk);
-			if (ret < 0) {
-				debug("Can't enable gpmi_apb clk: %d\n", ret);
-				return ret;
-			}
-
-			ret = clk_get_by_name(dev, "gpmi_bch", &gpmi_clk);
-			if (ret < 0) {
-				debug("Can't get gpmi_bch clk: %d\n", ret);
-				return ret;
-			}
-
-			ret = clk_enable(&gpmi_clk);
-			if (ret < 0) {
-				debug("Can't enable gpmi_bch clk: %d\n", ret);
-				return ret;
-			}
-		}
-
-		ret = clk_get_by_name(dev, "gpmi_bch_apb", &gpmi_clk);
-		if (ret < 0) {
-			debug("Can't get gpmi_bch_apb clk: %d\n", ret);
-			return ret;
-		}
-
-		ret = clk_enable(&gpmi_clk);
+		ret = clk_get_bulk(dev, &clk_bulk);
+		if (!ret)
+			ret = clk_enable_bulk(&clk_bulk);
 		if (ret < 0) {
-			debug("Can't enable gpmi_bch_apb clk: %d\n", ret);
+			debug("Can't enable gpmi clks: %d\n", ret);
 			return ret;
 		}
 	}
-- 
2.43.0

base-commit: df2ed552f0b05591090369a7fe7ddc92439dea5c
