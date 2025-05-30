Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59666C5AD49
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 15:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19F4483287;
	Fri, 30 May 2025 17:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FMxr/fq6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AE3F83303; Fri, 30 May 2025 17:17:05 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E8F38323A
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 17:17:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ad51ba0af48so543945466b.0
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 08:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748618222; x=1749223022;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Opm/q3YOUF7Jfhz54Asxs6/IED44xuL1BhLtypsX5pc=;
 b=FMxr/fq62S+3QS0H2ODkJKp4pjhniDviRakQd3c5L4ufpDVd1bKw63LO2dM4y5sCQJ
 VCdsGkCn82/e5hi2lYAw3Ytagy6yKw6s7yiF/BRasguNeVR0tXNEclIRcCFD4r7x2iS1
 /8xEkYpSD4LChX43XUNelIR1boiBK6OHx/8K0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748618222; x=1749223022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Opm/q3YOUF7Jfhz54Asxs6/IED44xuL1BhLtypsX5pc=;
 b=TVBp0bZPxVqaRlA2GgYeZHblVsPAshkAMw7Uweas9f2Fz1bEfxFm00bN1eCqIbDYH0
 wKFrnrJZER6wyovjVO4amVanilWBFMDaBOLD+TV+duU/FAxETe0fwe8tGBXZ7KaJgMyg
 anOjV0nYhSBZqwimzONkQekUx+3CVlacr4tAL2N+FLHxXZMfWKuWc05WlxpKKSQaMw1c
 edC/0iZciOOv49175Ms7XYDBjn3iH1CELWBE3kujKF9TgCJFFKQK1hra7N8ydKSZYHFu
 tumzNkxggtcfdDIMKK3v1N87xrno5MPshdwroIjXODzyr/9WDmYDtBO6iKG8JHT95pBM
 L5bA==
X-Gm-Message-State: AOJu0Ywxyi4ws8F4HxwcXXbf7uU6riEu2nyQLilzaf7WI4khvvdvkCUh
 +wsCcN1aFRbHxCfwIm1v9m6k5AJdlNS2SvSn60mqEZ5YSZA36tj3IW2N3Ff23aoE/jI7LqbFjmA
 bjC+mvmc=
X-Gm-Gg: ASbGncvcvMePoaQLWpKBPOSvXPC3b0h7jd7Y2B4tIfhriVp+PtiEosXsAn/qk+eox2g
 EFJvgSiaoTpd2V5sDrRnSYAch1IAdDOx4ixqkiRnNs+Om4RptG+W05qBzWWJGTXgIrJMQiLeRxl
 iCqOKAnV5j3SonhmjGs6GMAo38f9IvWLm8xyZq84RB1lhNjkjj86VK65tEcCzwSZhhBtXszxH7V
 ss6LdH0sQO0fbOvxzM9cUbubrJmCSVku7AV8lz2K9QOc+J1GaqOFdI45CBqDyJSj2k0XmfU+ofd
 uwOtrK6sgeFL4M5aIP3OIZqGK2Ydjjs83t7mYoNqL7wXI9QVAOms9f3r5O9REbxC2ZM5FiuExSB
 JjBz8Map3/g8mJV5FhDHN7ua2dx1AmbSclQ3NyglKX/Q9EA==
X-Google-Smtp-Source: AGHT+IEouLDS+Q2UVqyGi+B7rHd6D3Kc2n1+3m/yd11AM7qQ8qztde2V54FvT5ZI0BpircgyXH4zDA==
X-Received: by 2002:a17:907:f1d4:b0:adb:3fb8:27f9 with SMTP id
 a640c23a62f3a-adb3fb828b5mr84853266b.25.1748618221607; 
 Fri, 30 May 2025 08:17:01 -0700 (PDT)
Received: from panicking.. (mob-176-245-161-96.net.vodafone.it.
 [176.245.161.96]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82dd12sm345507966b.58.2025.05.30.08.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 08:17:01 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com, cniedermaier@dh-electronics.com,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 2/4] mtd: mxs_nand_dt: Move from clk_get/clk_enable to
 clk_bulk api
Date: Fri, 30 May 2025 17:16:44 +0200
Message-ID: <20250530151653.3695020-2-michael@amarulasolutions.com>
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

Make simple the clock registration and enable and allow later
to add support for other platforms

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

---

Changes in v4:
- None

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
