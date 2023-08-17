Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27662C2FC0E
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 08:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F0E586ABD;
	Thu, 17 Aug 2023 10:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Q042DwdM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15BB486AA8; Thu, 17 Aug 2023 10:57:32 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 319A986AAF
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 10:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1692262645; x=1694854645;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZV2Xl69Co0z53VIb1tQVF8a/9CkFNhnmfsEofu/ZyIs=;
 b=Q042DwdMiOwR9k7d0dzaPkYoIi8Qmm5aKC+csyNLsdVGqhpj7v/tL1n8v5gAWL3Y
 wnTJ3oWDU9ISbTZgasAnjvXO6kK852W+poMqc7+N/meY4F2URA5dJqooeg64vrzx
 nWpLGfukf/1JJvOM1Ykb2mwn+9ztUbpi6pG8vKVSReg=;
X-AuditID: ac14000a-923ff70000007ecb-b6-64dde0f54ea9
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 15.D2.32459.5F0EDD46;
 Thu, 17 Aug 2023 10:57:25 +0200 (CEST)
Received: from llp-tremmet2.fritz.box (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Aug
 2023 10:57:24 +0200
From: Teresa Remmet <t.remmet@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP i
 . MX U-Boot Team" <uboot-imx@nxp.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Yannic Moog
 <y.moog@phytec.de>, Daniel Schultz <d.schultz@phytec.de>, Wadim Egorov
 <w.egorov@phytec.de>
Subject: [PATCH v2 5/6] board: phytec: common: phytec_som_detection: Add
 helper for PCB revision
Date: Thu, 17 Aug 2023 10:57:10 +0200
Message-ID: <20230817085711.45339-6-t.remmet@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817085711.45339-1-t.remmet@phytec.de>
References: <20230817085711.45339-1-t.remmet@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWyRpKBR/frg7spBpfXslo8vOpv0X7Kx+Lt
 3k52iymP17NbdL9Td2D1mDfrBIvHzll32T3O3tnB6NHf3cLqsfHdDqYA1igum5TUnMyy1CJ9
 uwSujMNdbxkLTvBVHDvzkLmB8TBPFyMnh4SAiUTD7RvsXYxcHEICS5gkDjycxwzhPGOU6JvR
 wA5SxSagIfF0xWkmEFtEoEziYe8nZhCbWWAxo8Tq35YgtrBAgsS2o3eA6jk4WARUJR7+8gMJ
 8wqYS9zcDFEuISAvsf/gWTCbU8BCoqn7Bth4IaCaRT27GCHqBSVOznzCAjFeXqJ562yoVRIS
 B1+8YIaol5fYdekkI8zMaedeQ80PlTiyaTXTBEahWUhGzUIyahaSUQsYmVcxCuVmJmenFmVm
 6xVkVJakJuulpG5iBIW9CAPXDsa+OR6HGJk4GA8xSnAwK4nw9vDeShHiTUmsrEotyo8vKs1J
 LT7EKM3BoiTOe7+HKVFIID2xJDU7NbUgtQgmy8TBKdXAmJV1/Scrq130yVnvWhV/eL5qNw3O
 aCxtXhm4xmJby7zCtt2LWSV6clK+5VrP0eK7NEP/bYjcxNVG1989YZgy5+6ZQMe7e4LW1NtE
 tLMatXKcjvoj1mu2w2vnCR4jXueFyR55ryw+Hcn+eDQwoqKCJ9rlt0ozR8L61K49Z+YE7G/V
 bThwrmuNEktxRqKhFnNRcSIAmOTmC2kCAAA=
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

Add helper function to read out the PCB revision of a PHYTEC SoM.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
Changes in v2:
- none
---
 board/phytec/common/phytec_som_detection.c | 15 +++++++++++++++
 board/phytec/common/phytec_som_detection.h |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index 366bdd4ace4b..55562731270b 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -186,3 +186,18 @@ char * __maybe_unused phytec_get_opt(struct phytec_eeprom_data *data)
 
 	return opt;
 }
+
+u8 __maybe_unused phytec_get_rev(struct phytec_eeprom_data *data)
+{
+	struct phytec_api2_data *api2;
+
+	if (!data)
+		data = &eeprom_data;
+
+	if (data->api_rev < PHYTEC_API_REV2)
+		return PHYTEC_EEPROM_INVAL;
+
+	api2 = &data->data.data_api2;
+
+	return api2->pcb_rev;
+}
diff --git a/board/phytec/common/phytec_som_detection.h b/board/phytec/common/phytec_som_detection.h
index 01f7e4652ddb..c68e2302cc42 100644
--- a/board/phytec/common/phytec_som_detection.h
+++ b/board/phytec/common/phytec_som_detection.h
@@ -68,6 +68,7 @@ int phytec_eeprom_data_init(struct phytec_eeprom_data *data,
 void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data);
 
 char * __maybe_unused phytec_get_opt(struct phytec_eeprom_data *data);
+u8 __maybe_unused phytec_get_rev(struct phytec_eeprom_data *data);
 
 #else
 
@@ -99,6 +100,10 @@ inline char *__maybe_unused phytec_get_opt(struct phytec_eeprom_data *data)
 	return NULL;
 }
 
+u8 __maybe_unused phytec_get_rev(struct phytec_eeprom_data *data)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
 #endif /* IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION) */
 
 #endif /* _PHYTEC_SOM_DETECTION_H */
-- 
2.34.1

