Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBC0EB64DD
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 08:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 422B686A79;
	Thu, 17 Aug 2023 10:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="eoVk1i9Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E61386AB7; Thu, 17 Aug 2023 10:57:31 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FD0386AA6
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 10:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1692262644; x=1694854644;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MwLfj/fwDW1Otf0It6jOHdgS18kErlrRj+2NxmX2Iog=;
 b=eoVk1i9YPyrELFrqpHoB0oiktr2/KZTZZTw75CS5jH5y+kcJzXqC4+E2ibE8aWkB
 QddbKrG6vAxvpeZcbzQl37X3gP0uCXOkHIIdepKZ1ROBCfK/KaIS4XwnK0/rf37A
 k1dr8V2/TqqIE8crHINbrqISLhkCOzNxfOTcAhbLIJg=;
X-AuditID: ac14000a-923ff70000007ecb-ae-64dde0f451a2
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id D3.D2.32459.4F0EDD46;
 Thu, 17 Aug 2023 10:57:24 +0200 (CEST)
Received: from llp-tremmet2.fritz.box (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Aug
 2023 10:57:23 +0200
From: Teresa Remmet <t.remmet@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP i
 . MX U-Boot Team" <uboot-imx@nxp.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Yannic Moog
 <y.moog@phytec.de>, Daniel Schultz <d.schultz@phytec.de>, Wadim Egorov
 <w.egorov@phytec.de>
Subject: [PATCH v2 3/6] board: phytec: phycore-imx8mp: Add EEPROM detection
 initialisation
Date: Thu, 17 Aug 2023 10:57:08 +0200
Message-ID: <20230817085711.45339-4-t.remmet@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817085711.45339-1-t.remmet@phytec.de>
References: <20230817085711.45339-1-t.remmet@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsWyRpKBR/fLg7spBkvXiVs8vOpv0X7Kx+Lt
 3k52iymP17NbdL9Td2D1mDfrBIvHzll32T3O3tnB6NHf3cLqsfHdDqYA1igum5TUnMyy1CJ9
 uwSujN6Gp6wFUwUrrj/yamC8ztfFyMEhIWAicelFXRcjF4eQwBImiY+t/xkhnGeMEm9nnGPr
 YuTkYBPQkHi64jQTiC0iUCbxsPcTM4jNLLCYUWL1b0sQW1ggSuLu9C8sIDaLgKrEutubGEFs
 XgFzibndB9lBbAkBeYn9B8+C9XIKWEg0dd8AiwsB1Szq2QVVLyhxcuYTFoj58hLNW2dD7ZKQ
 OPjiBTNEvbzErksnGWFmTjv3mhnCDpU4smk10wRGoVlIRs1CMmoWklELGJlXMQrlZiZnpxZl
 ZusVZFSWpCbrpaRuYgQFvQgD1w7GvjkehxiZOBgPMUpwMCuJ8Pbw3koR4k1JrKxKLcqPLyrN
 SS0+xCjNwaIkznu/hylRSCA9sSQ1OzW1ILUIJsvEwSnVwMiSslhkudFyo9YrIlan1RbuD97O
 LSIW/Hm540VrRv+e/Oa5VjOnPw28+MqYMaCq0TdDVfbzo95/Z855bp76UU0+qo7xlkfFruVX
 mxXrYurtdrbFLpp75kGEErd7xgLvF04rSpsn1e2/+Pxl4Lft6xad1/zimL8s7zvv0463J5un
 zDLlydquulmJpTgj0VCLuag4EQAhqfc8aAIAAA==
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

Add EEPROM detection initialisation for phyCORE-i.MX8MM and
print SoM information during boot when successful.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
Changes in v2:
- removed superfluous goto
---
 board/phytec/phycore_imx8mp/Kconfig |  1 +
 board/phytec/phycore_imx8mp/spl.c   | 17 +++++++++++++++++
 configs/phycore-imx8mp_defconfig    |  1 +
 3 files changed, 19 insertions(+)

diff --git a/board/phytec/phycore_imx8mp/Kconfig b/board/phytec/phycore_imx8mp/Kconfig
index c053a46fc9d1..f846d10bad9e 100644
--- a/board/phytec/phycore_imx8mp/Kconfig
+++ b/board/phytec/phycore_imx8mp/Kconfig
@@ -12,4 +12,5 @@ config SYS_CONFIG_NAME
 config IMX_CONFIG
 	default "board/phytec/phycore_imx8mp/imximage-8mp-sd.cfg"
 
+source "board/phytec/common/Kconfig"
 endif
diff --git a/board/phytec/phycore_imx8mp/spl.c b/board/phytec/phycore_imx8mp/spl.c
index faed6fc3b76d..49406f2eafad 100644
--- a/board/phytec/phycore_imx8mp/spl.c
+++ b/board/phytec/phycore_imx8mp/spl.c
@@ -21,8 +21,13 @@
 #include <power/pca9450.h>
 #include <spl.h>
 
+#include "../common/imx8m_som_detection.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
+#define EEPROM_ADDR             0x51
+#define EEPROM_ADDR_FALLBACK    0x59
+
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;
@@ -30,6 +35,18 @@ int spl_board_boot_device(enum boot_device boot_dev_spl)
 
 void spl_dram_init(void)
 {
+	int ret;
+
+	ret = phytec_eeprom_data_setup_fallback(NULL, 0, EEPROM_ADDR,
+						EEPROM_ADDR_FALLBACK);
+	if (ret)
+		goto out;
+
+	ret = phytec_imx8m_detect(NULL);
+	if (!ret)
+		phytec_print_som_info(NULL);
+
+out:
 	ddr_init(&dram_timing);
 }
 
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 7bf404be860b..7937e15e6422 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -12,6 +12,7 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx8mp-phyboard-pollux-rdk"
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_TARGET_PHYCORE_IMX8MP=y
+CONFIG_PHYTEC_SOM_DETECTION=y
 CONFIG_SYS_PROMPT="u-boot=> "
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
-- 
2.34.1

