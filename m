Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D13CC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 08:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 063E4875FC;
	Wed, 20 Dec 2023 09:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="f4UjA99I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2D4986FFE; Wed, 20 Dec 2023 09:45:42 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B674487480
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1703061940; x=1705653940;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oQCfmNk8sTvRDv4SvePOfeouy9zdrV80CBSUGxAslLc=;
 b=f4UjA99IZMXMSGH6sp2eHoeFqsoGj4rsa9ZcgJNSHKYdxDmtBPdlKTQO75vcz8M3
 IAf/Hc95B8cJa/8q/DVwxJJttLlhFfcvy94XkGtUzCT9Q+oWm1MlsHTsnDvOBYEE
 eTqxQZoV712UhnFYVNv5+ugt5Fz4C5CPBzbAbcUawb0=;
X-AuditID: ac14000a-fbefe7000000290d-e5-6582a9b489b9
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 55.E0.10509.4B9A2856;
 Wed, 20 Dec 2023 09:45:40 +0100 (CET)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Dec
 2023 09:45:39 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 20 Dec 2023 09:45:32 +0100
Subject: [PATCH v2 1/5] board: phytec: imx8m_som_detection: change
 phytec_imx8m_detect return type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v2-1-516abadb4f49@phytec.de>
References: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v2-0-516abadb4f49@phytec.de>
In-Reply-To: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v2-0-516abadb4f49@phytec.de>
To: Fabio Estevam <festevam@gmail.com>
CC: Teresa Remmet <t.remmet@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWyRpKBR3fLyqZUg6P/OSweXvW3eLu3k92i
 +526A7PHzll32T3O3tnB6NHf3cIawBzFZZOSmpNZllqkb5fAlbH10ArGgtn8Fc/eejUwzuTt
 YuTkkBAwkXi24TRbFyMXh5DAYiaJ91vmMUE4DxklLuxawgpSxSagIvH4xT0gm4ODRUBV4vgR
 E5CwsECKxLS7uxlBbF4BQYmTM5+wgJQwC2hKrN+lDxJmFpCX2P52DjNESYrEmf+3mUBsIRC7
 7x5YK6dAqsSSd6fZQVpFBNQkTs+Daq2RmHp/HjvEmcIS7YtuQbXKSrw43wsVl5eYdu41M4Qd
 KnFk02qmCYxCs5AcNAvhoFlIDlrAyLyKUSg3Mzk7tSgzW68go7IkNVkvJXUTIyiQRRi4djD2
 zfE4xMjEwXiIUYKDWUmEd29nU6oQb0piZVVqUX58UWlOavEhRmkOFiVx3tUdwalCAumJJanZ
 qakFqUUwWSYOTqkGxhmXTGPfFvXXJPoVvZC5+1t/w+6+ZudcwUN3Xis9ZOj2/tYdqHBa6pwK
 wyKfsBnT7be+P2vWsKjxyoSU+EVns/YdTg7XOfG5ueif3XyWa15tzseY2rj+6wqtlfPYYDtT
 K/3ojl4rvw0f3ELdpvIXPHIKOHJu98K5/TYsan/P7LRMfmEerdQpq8RSnJFoqMVcVJwIAIp0
 oKNSAgAA
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

phytec_imx8m_detect returns -1 on error, but the return type is u8
leading to 255 return values. Fix this by changing the return type to
int; there is no reason to keep it as u8 .

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 board/phytec/common/imx8m_som_detection.c | 2 +-
 board/phytec/common/imx8m_som_detection.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/board/phytec/common/imx8m_som_detection.c b/board/phytec/common/imx8m_som_detection.c
index c6c96ed19cb..45f5767c565 100644
--- a/board/phytec/common/imx8m_som_detection.c
+++ b/board/phytec/common/imx8m_som_detection.c
@@ -23,7 +23,7 @@ extern struct phytec_eeprom_data eeprom_data;
  *
  * Returns 0 in case it's a known SoM. Otherwise, returns -1.
  */
-u8 __maybe_unused phytec_imx8m_detect(struct phytec_eeprom_data *data)
+int __maybe_unused phytec_imx8m_detect(struct phytec_eeprom_data *data)
 {
 	char *opt;
 	u8 som;
diff --git a/board/phytec/common/imx8m_som_detection.h b/board/phytec/common/imx8m_som_detection.h
index 88d3037bf36..442085cfe97 100644
--- a/board/phytec/common/imx8m_som_detection.h
+++ b/board/phytec/common/imx8m_som_detection.h
@@ -15,7 +15,7 @@
 
 #if IS_ENABLED(CONFIG_PHYTEC_IMX8M_SOM_DETECTION)
 
-u8 __maybe_unused phytec_imx8m_detect(struct phytec_eeprom_data *data);
+int __maybe_unused phytec_imx8m_detect(struct phytec_eeprom_data *data);
 u8 __maybe_unused phytec_get_imx8m_ddr_size(struct phytec_eeprom_data *data);
 u8 __maybe_unused phytec_get_imx8mp_rtc(struct phytec_eeprom_data *data);
 u8 __maybe_unused phytec_get_imx8m_spi(struct phytec_eeprom_data *data);
@@ -23,7 +23,7 @@ u8 __maybe_unused phytec_get_imx8m_eth(struct phytec_eeprom_data *data);
 
 #else
 
-inline u8 __maybe_unused phytec_imx8m_detect(struct phytec_eeprom_data *data)
+inline int __maybe_unused phytec_imx8m_detect(struct phytec_eeprom_data *data)
 {
 	return -1;
 }

-- 
2.34.1

