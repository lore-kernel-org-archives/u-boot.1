Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6030AC54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 12:23:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17BAC82116;
	Sun, 25 May 2025 14:23:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IXD3aRsC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC72E82C49; Sun, 25 May 2025 14:23:30 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC6D68144A
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 14:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ad545e74f60so170448366b.2
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 05:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748175808; x=1748780608;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ButQREKkXJ91sqOMDiUSEypObXWwffA9pRUU807plZw=;
 b=IXD3aRsCGza7ydtx/+PKM/MHgaxVA8l831F/x4yCCYiizJNCy18HTxXciPlDOEKhw5
 vZJbmyI5fcmSVzi226h4i5+5VidMdlJXPV2vuq++fyIGJHot4TEYfOI7GSZcVzu8W+Hi
 AdDP6/jBBUageLbU1QRcWXKpasiKS4hnkDc/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748175808; x=1748780608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ButQREKkXJ91sqOMDiUSEypObXWwffA9pRUU807plZw=;
 b=CuOCyXRaC/bK4b+r6AZQHJ8kr5ib1o785isRC+MmOUiEJwp0GSSuEEEYsthGW9gTqN
 4smVic3Ln5kkAdsGFtlG1aXgaPT9fsAhvnLoi9mkxWtUMBq7WqMvHe+/gE7aZ1s03hDd
 7j+pGldN3Up1t451cUSOhsJGxJWIx3imFJgg3HWI/q+bsFWcX1OGwDTKPckuNePJc+Cp
 wbjQ9sgXVmC7oOG/rpLcktzVXeii4+4Bp/6oFPwVHF+Tk4w3Z/O1Em6aNjkqhsaQV3z1
 sNbyp8vaaVrzlIOE1G/MVmhcXSdVzd6PIUjnygArgf5Iu7dHMXxlT0mY40RjsPmoaTe/
 ddWw==
X-Gm-Message-State: AOJu0Yx8etfCajyGhNzxYpdnnmEOaiML4KCf7QX3peyCsWhURaiZZ/2W
 qJG+ZTl928niF5xQjk/bs07oNB6KXqoBPloQRpWPWEBIqnDg1Vdng2ew0GXYQ4G/L5MFYNWnG3t
 yuxW8nBL2rg==
X-Gm-Gg: ASbGnct+q8PRy5TWyAq/5Jpum276Y0aUu9IK9IdAcIHQvbGDjdOaCMWQ2NhtclUYWhB
 NESMoE4xdhJ6ZtbDBSIIA2LGWcOA1k1c29KU+QsyKwxqqEYkQKrUuvr0KP5Mz4EBhJz2Wgp9xN7
 0kqdS5uYznEAUw2zuDz+28fK8xy6RGpw0qEsfuTB1olumtm85WQVfUAtA6N35m1tOjf5E1hCXhA
 mB7hZL8W/lOcc7tiwtZYsT39V+lU7e+E/4hbjjrvdjzsbXF0HIPmVlsU//X64IBiOEU7mp7oCDJ
 t6F/C0AT6B7s9/CvEWKBgh2ibrLPlVbeoHgx7jLcTbQ1lpyzndcXZahvZk1EjAxt1c6IIsWJJxe
 AK7ga9KKPZGCPJw==
X-Google-Smtp-Source: AGHT+IGjWH+TPhWFtfrfy4OKmD2pvE6ociJayxxjl7eGqrty5H+Q8UWnC1QPFVN8GwEWJabCZ9Q/8Q==
X-Received: by 2002:a17:907:60c8:b0:ad5:3504:a6b with SMTP id
 a640c23a62f3a-ad85b337ae3mr466823966b.52.1748175807649; 
 Sun, 25 May 2025 05:23:27 -0700 (PDT)
Received: from panicking.amarulasolutions.com
 ([2001:b07:6467:4426:33ec:9e56:eca:2394])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4383f8sm1517982366b.113.2025.05.25.05.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 05:23:26 -0700 (PDT)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/4] mtd: mxs_nand_dt: Move from clk_get/clk_enable to
 clk_bulk api
Date: Sun, 25 May 2025 14:23:10 +0200
Message-ID: <20250525122316.661999-2-michael@amarulasolutions.com>
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

Make simple the clock registration and enable and allow later
to add support for other platforms

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---

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
