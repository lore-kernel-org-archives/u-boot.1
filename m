Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0ACCC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 13:36:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90DEE8851D;
	Tue, 28 May 2024 15:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="HpWpo98k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C4DE883A0; Tue, 28 May 2024 15:35:31 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63A7A884C6
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
 bh=cpyhAiYBsgsxL1B7B5H5zf/0vrFEzax1JxUJgmEjWeU=;
 b=HpWpo98kRMMDP9ucW0+L1Qk1W8uA8bZp8cdxHmRsaHwlYXafzBfjlNIaBXrn70Lv
 AbOjENNNGrrHReaqKcs7CTUSoVnji6ykxglQSSCYGQTaVf6x5aYY6vK0F0LaOTHc
 2P8eRXKYVMlCCOp/Xcx1uGE2vHRgXBpfj4XOJakPzDM=;
X-AuditID: ac14000a-03e52700000021bc-28-6655dd9f8d21
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 63.E8.08636.F9DD5566;
 Tue, 28 May 2024 15:35:27 +0200 (CEST)
Received: from llp-tremmet2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 28 May
 2024 15:35:26 +0200
From: Teresa Remmet <t.remmet@phytec.de>
To: <u-boot@lists.denx.de>
CC: Yannic Moog <y.moog@phytec.de>, Fabio Estevam <festevam@gmail.com>, Tom
 Rini <trini@konsulko.com>, Benjamin Hahn <B.Hahn@phytec.de>, Yashwanth
 Varakala <y.varakala@phytec.de>, Wadim Egorov <w.egorov@phytec.de>,
 <upstream@lists.phytec.de>
Subject: [PATCH 3/4] board: phytec: phycore_imx8mp: Make RAM size
 configuration fix
Date: Tue, 28 May 2024 15:35:14 +0200
Message-ID: <20240528133515.307315-4-t.remmet@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528133515.307315-1-t.remmet@phytec.de>
References: <20240528133515.307315-1-t.remmet@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWyRpKBR3f+3dA0g5vvRC0eXvW3mDppM7vF
 272d7Bbd79QdWDx2zrrL7vHqwCp2j7N3djB69He3sAawRHHZpKTmZJalFunbJXBlHNu8iq2g
 V75i5e437A2MFyW7GDk5JARMJHrbd7KA2EICS5gkvj8ShbCfMkqcXGEFYrMJaEg8XXGaCcQW
 EZCSeNm5kbmLkYuDWeA7o8Schf3sIAlhgWCJSztXs4HYLAKqEs+enWUEsXkFLCTuHz3EArFM
 XmL/wbPMIDangKXEikl9TBDLLCQu7t/DDFEvKHFy5hOwemag+uats5khbAmJgy9eMEPUy0vs
 unSSEWbmtHOvmSHsUIkjm1YzTWAUmoVk1Cwko2YhGbWAkXkVo1BuZnJ2alFmtl5BRmVJarJe
 SuomRlCQizBw7WDsm+NxiJGJg/EQowQHs5II75lJoWlCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
 eVd3BKcKCaQnlqRmp6YWpBbBZJk4OKUaGP02m98+WLhLM2Nr2tEtCS/+3p1iGD3Fl+v8woRN
 a30ijR8eEbM9fWDmrE3uM9hv/NnOvJNVVt9fK8jvzIw0O5nqt0cZrKJ/nfy0IODFbtsKeemr
 nz5M6PD918vub3CbddsctlvT3zjq8t+0sPM9uU+nd912ofdv9jZzCT/ROXqAYXl/xPTYLT+V
 WIozEg21mIuKEwGQIKB4YAIAAA==
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

We might not be able to always rely on the EEPROM introspection data.
So add a config option alternative which configures the RAM size
to a fix value.

We still try to read the EEPROM introspection data at this point.
So we can print the SoM information if available.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 board/phytec/phycore_imx8mp/Kconfig | 48 +++++++++++++++++++++++++++++
 board/phytec/phycore_imx8mp/spl.c   | 34 +++++++++++++++-----
 2 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/board/phytec/phycore_imx8mp/Kconfig b/board/phytec/phycore_imx8mp/Kconfig
index f846d10bad9e..5ede39abc52b 100644
--- a/board/phytec/phycore_imx8mp/Kconfig
+++ b/board/phytec/phycore_imx8mp/Kconfig
@@ -12,5 +12,53 @@ config SYS_CONFIG_NAME
 config IMX_CONFIG
 	default "board/phytec/phycore_imx8mp/imximage-8mp-sd.cfg"
 
+config PHYCORE_IMX8MP_RAM_SIZE_FIX
+	bool "Set phyCORE-i.MX8MP RAM size fix instead of detecting"
+	default false
+	help
+	  RAM size is automatic being detected with the help of
+	  the EEPROM introspection data. Set RAM size to a fix value
+	  instead.
+
+choice
+	prompt "phyCORE-i.MX8MP RAM size"
+	depends on PHYCORE_IMX8MP_RAM_SIZE_FIX
+	default PHYCORE_IMX8MP_RAM_SIZE_2GB
+
+config PHYCORE_IMX8MP_RAM_SIZE_1GB
+	bool "1GB RAM"
+	help
+	  Set RAM size fix to 1GB for phyCORE-i.MX8MP.
+	  RAM frequency is configured independent.
+
+config PHYCORE_IMX8MP_RAM_SIZE_2GB
+	bool "2GB RAM"
+	help
+	  Set RAM size fix to 2GB for phyCORE-i.MX8MP.
+	  RAM frequency is configured independent.
+
+config PHYCORE_IMX8MP_RAM_SIZE_4GB
+	bool "4GB RAM"
+	help
+	  Set RAM size fix to 4GB for phyCORE-i.MX8MP.
+	  RAM frequency is configured independent.
+
+config PHYCORE_IMX8MP_RAM_SIZE_8GB
+	bool "8GB RAM"
+	select PHYCORE_IMX8MP_USE_2GHZ_RAM_TIMINGS
+	help
+	  Set RAM size fix to 8GB for phyCORE-i.MX8MP.
+	  Only 2GHz RAMs are supported.
+
+endchoice
+
+config PHYCORE_IMX8MP_USE_2GHZ_RAM_TIMINGS
+	bool "Use 2GHz RAM timings"
+	depends on PHYCORE_IMX8MP_RAM_SIZE_FIX
+	default false
+	help
+	  Use fix 2GHz RAM timings for phyCORE-i.MX8MP instead of
+	  1.5GHz timings.
+
 source "board/phytec/common/Kconfig"
 endif
diff --git a/board/phytec/phycore_imx8mp/spl.c b/board/phytec/phycore_imx8mp/spl.c
index f24f09301f1e..8a0c456859e2 100644
--- a/board/phytec/phycore_imx8mp/spl.c
+++ b/board/phytec/phycore_imx8mp/spl.c
@@ -50,20 +50,38 @@ void spl_dram_init(void)
 
 	ret = phytec_eeprom_data_setup_fallback(NULL, 0, EEPROM_ADDR,
 						EEPROM_ADDR_FALLBACK);
-	if (ret)
+	if (ret && !IS_ENABLED(CONFIG_PHYCORE_IMX8MP_RAM_SIZE_FIX))
 		goto out;
 
 	ret = phytec_imx8m_detect(NULL);
 	if (!ret)
 		phytec_print_som_info(NULL);
 
-	u8 rev = phytec_get_rev(NULL);
-	u8 somtype = phytec_get_som_type(NULL);
-
-	if (rev != PHYTEC_EEPROM_INVAL && (rev >= 3 || (somtype == SOM_TYPE_PCL && rev >= 1)))
-		use_2ghz_timings = true;
-
-	size = phytec_get_imx8m_ddr_size(NULL);
+	if (IS_ENABLED(CONFIG_PHYCORE_IMX8MP_RAM_SIZE_FIX)) {
+		if (IS_ENABLED(CONFIG_PHYCORE_IMX8MP_RAM_SIZE_1GB))
+			size = PHYTEC_IMX8MP_DDR_1GB;
+		else if (IS_ENABLED(CONFIG_PHYCORE_IMX8MP_RAM_SIZE_2GB))
+			size = PHYTEC_IMX8MP_DDR_2GB;
+		else if (IS_ENABLED(CONFIG_PHYCORE_IMX8MP_RAM_SIZE_4GB))
+			size = PHYTEC_IMX8MP_DDR_4GB;
+		else if (IS_ENABLED(CONFIG_PHYCORE_IMX8MP_RAM_SIZE_8GB))
+			size = PHYTEC_IMX8MP_DDR_8GB;
+		if (IS_ENABLED(CONFIG_PHYCORE_IMX8MP_USE_2GHZ_RAM_TIMINGS)) {
+			if (size == PHYTEC_IMX8MP_DDR_4GB)
+				size = PHYTEC_IMX8MP_DDR_4GB_2GHZ;
+			else
+				use_2ghz_timings = true;
+		}
+	} else {
+		u8 rev = phytec_get_rev(NULL);
+		u8 somtype = phytec_get_som_type(NULL);
+
+		if (rev != PHYTEC_EEPROM_INVAL &&
+		    (rev >= 3 || (somtype == SOM_TYPE_PCL && rev >= 1)))
+			use_2ghz_timings = true;
+
+		size = phytec_get_imx8m_ddr_size(NULL);
+	}
 
 	switch (size) {
 	case PHYTEC_IMX8MP_DDR_1GB:
-- 
2.34.1

