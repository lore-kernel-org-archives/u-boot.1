Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B99C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 13:35:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0634F884C6;
	Tue, 28 May 2024 15:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="m5Lvvxjn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B6108850A; Tue, 28 May 2024 15:35:30 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF8C7884D5
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 15:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716903327; x=1719495327;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Nh73erwLEwZNnmzRjxO2fmTQwAhoN6IC1/cd0nyhjiA=;
 b=m5LvvxjnkImxe2MkgoBT0yY55LxcnEeavY4EHnoaUT5pctYNFjY0OWvcNgEPNuC4
 6Y/K74TF18TyILmMxSPp+pnT8k8vRfOBvhw8s/GTrkA7Mq0fM4Al4Io0Kf9jSZkl
 fxfORhs9oLPHNzl3C3dQoWDyTwpeqvcpeTeuJtlsIW0=;
X-AuditID: ac14000a-03251700000021bc-29-6655dd9ffadb
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id B3.E8.08636.F9DD5566;
 Tue, 28 May 2024 15:35:27 +0200 (CEST)
Received: from llp-tremmet2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 28 May
 2024 15:35:27 +0200
From: Teresa Remmet <t.remmet@phytec.de>
To: <u-boot@lists.denx.de>
CC: Yannic Moog <y.moog@phytec.de>, Fabio Estevam <festevam@gmail.com>, Tom
 Rini <trini@konsulko.com>, Benjamin Hahn <B.Hahn@phytec.de>, Yashwanth
 Varakala <y.varakala@phytec.de>, Wadim Egorov <w.egorov@phytec.de>,
 <upstream@lists.phytec.de>
Subject: [PATCH 4/4] board: phycore_imx8mp: enable setting 2GHz timings
 without RAM size
Date: Tue, 28 May 2024 15:35:15 +0200
Message-ID: <20240528133515.307315-5-t.remmet@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528133515.307315-1-t.remmet@phytec.de>
References: <20240528133515.307315-1-t.remmet@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWyRpKBR3f+3dA0g4c/tSweXvW3mDppM7vF
 272d7Bbd79QdWDx2zrrL7vHqwCp2j7N3djB69He3sAawRHHZpKTmZJalFunbJXBlPPipVPBf
 rOLZx3nsDYw/hLoYOTkkBEwkbs3bydrFyMUhJLCESWL2p/uMEM5TRokDc2exgFSxCWhIPF1x
 mgnEFhGQknjZuZEZpIhZ4DujxJyF/ewgCWGBCIkdz36B2SwCqhKzj91hA7F5BSwk+uatYYRY
 Jy+x/+BZZhCbU8BSYsWkPrChQkA1F/fvYYaoF5Q4OfMJ2GJmoPrmrbOZIWwJiYMvXjBD1MtL
 7Lp0Em7mtHOvmSHsUIkjm1YzTWAUmoVk1Cwko2YhGbWAkXkVo1BuZnJ2alFmtl5BRmVJarJe
 SuomRlCYizBw7WDsm+NxiJGJg/EQowQHs5II75lJoWlCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
 eVd3BKcKCaQnlqRmp6YWpBbBZJk4OKUaGH31VvFZVatP+lnKcaRnm5Zb26PLxrGtu/4Uzbjx
 1Ys1QJq3rLT9/ARn9Zt1gd/WL+U3Kb32oOE0xz1rkyd7OfsS04sSfun//c9XYpqUrN/8bHNo
 Fou6vmi0d6/mpy/PZgeIrOaN6fK5lFp2afux+F3Gvp+/eh+J0DG1nTPFs+m+VKxhvBunEktx
 RqKhFnNRcSIAxMv9D2ECAAA=
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

From: Benjamin Hahn <B.Hahn@phytec.de>

make it possible to set the RAM timing frequency statically independent
from the RAM size. Fixed RAM timing frequency can be used while the
RAM size is still determined by the EEPROM image.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 board/phytec/phycore_imx8mp/Kconfig | 23 +++++++++++++++++++++--
 board/phytec/phycore_imx8mp/spl.c   | 12 ++++++++++--
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/board/phytec/phycore_imx8mp/Kconfig b/board/phytec/phycore_imx8mp/Kconfig
index 5ede39abc52b..bdf9e97beaa6 100644
--- a/board/phytec/phycore_imx8mp/Kconfig
+++ b/board/phytec/phycore_imx8mp/Kconfig
@@ -52,13 +52,32 @@ config PHYCORE_IMX8MP_RAM_SIZE_8GB
 
 endchoice
 
+config PHYCORE_IMX8MP_RAM_FREQ_FIX
+	bool "Set phyCORE-i.MX8MP RAM frequency fix instead of detecting"
+	default false
+	help
+	  RAM frequency is automatic being detected with the help of
+	  the EEPROM introspection data. Set RAM frequency to a fix value
+	  instead.
+
+choice
+	prompt "phyCORE-i.MX8MP RAM frequency"
+	depends on PHYCORE_IMX8MP_RAM_FREQ_FIX
+	default PHYCORE_IMX8MP_USE_1_5GHZ_RAM_TIMINGS
+
 config PHYCORE_IMX8MP_USE_2GHZ_RAM_TIMINGS
 	bool "Use 2GHz RAM timings"
-	depends on PHYCORE_IMX8MP_RAM_SIZE_FIX
-	default false
 	help
 	  Use fix 2GHz RAM timings for phyCORE-i.MX8MP instead of
 	  1.5GHz timings.
 
+config PHYCORE_IMX8MP_USE_1_5GHZ_RAM_TIMINGS
+	depends on !PHYCORE_IMX8MP_RAM_SIZE_8GB
+	bool "Use 1.5GHz RAM timings"
+	help
+	  Use fix 1.5GHz RAM timings for phyCORE-i.MX8MP instead of
+	  2GHz timings.
+endchoice
+
 source "board/phytec/common/Kconfig"
 endif
diff --git a/board/phytec/phycore_imx8mp/spl.c b/board/phytec/phycore_imx8mp/spl.c
index 8a0c456859e2..30964bc5e547 100644
--- a/board/phytec/phycore_imx8mp/spl.c
+++ b/board/phytec/phycore_imx8mp/spl.c
@@ -66,11 +66,21 @@ void spl_dram_init(void)
 			size = PHYTEC_IMX8MP_DDR_4GB;
 		else if (IS_ENABLED(CONFIG_PHYCORE_IMX8MP_RAM_SIZE_8GB))
 			size = PHYTEC_IMX8MP_DDR_8GB;
+	} else {
+		size = phytec_get_imx8m_ddr_size(NULL);
+	}
+
+	if (IS_ENABLED(CONFIG_PHYCORE_IMX8MP_RAM_FREQ_FIX)) {
 		if (IS_ENABLED(CONFIG_PHYCORE_IMX8MP_USE_2GHZ_RAM_TIMINGS)) {
 			if (size == PHYTEC_IMX8MP_DDR_4GB)
 				size = PHYTEC_IMX8MP_DDR_4GB_2GHZ;
 			else
 				use_2ghz_timings = true;
+		} else if (IS_ENABLED(CONFIG_PHYCORE_IMX8MP_USE_1_5GHZ_RAM_TIMINGS)) {
+			if (size == PHYTEC_IMX8MP_DDR_4GB_2GHZ)
+				size = PHYTEC_IMX8MP_DDR_4GB;
+			else
+				use_2ghz_timings = false;
 		}
 	} else {
 		u8 rev = phytec_get_rev(NULL);
@@ -79,8 +89,6 @@ void spl_dram_init(void)
 		if (rev != PHYTEC_EEPROM_INVAL &&
 		    (rev >= 3 || (somtype == SOM_TYPE_PCL && rev >= 1)))
 			use_2ghz_timings = true;
-
-		size = phytec_get_imx8m_ddr_size(NULL);
 	}
 
 	switch (size) {
-- 
2.34.1

