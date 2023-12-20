Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0949C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 08:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E239875E9;
	Wed, 20 Dec 2023 09:20:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="afWa1hUu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3FE18760D; Wed, 20 Dec 2023 09:20:05 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 750A5875A0
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:20:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1703060402; x=1705652402;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oQCfmNk8sTvRDv4SvePOfeouy9zdrV80CBSUGxAslLc=;
 b=afWa1hUulbLr6oN2bQo8FX5BCMmV1GicWI/F0W6j3t3Y2HEJNJLiBbP4Xb7WA4sW
 O0VH8awZuDlrOVrop2AjxLtelKm5Ec3bQle+itdOVQCAP4Xlxp+W6M/s0J9nJWV/
 dILsJkuoIhI+mzSKzjo5hWOkRRw4Ix+X0PTlF9K+AQE=;
X-AuditID: ac14000a-fadff7000000290d-46-6582a3b2fd77
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 7E.A0.10509.2B3A2856;
 Wed, 20 Dec 2023 09:20:02 +0100 (CET)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Dec
 2023 09:20:02 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 20 Dec 2023 09:19:33 +0100
Subject: [PATCH 1/4] board: phytec: imx8m_som_detection: change
 phytec_imx8m_detect return type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v1-1-c24f3239b4c3@phytec.de>
References: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v1-0-c24f3239b4c3@phytec.de>
In-Reply-To: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v1-0-c24f3239b4c3@phytec.de>
To: Fabio Estevam <festevam@gmail.com>
CC: Teresa Remmet <t.remmet@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWyRpKBR3fT4qZUg7NXRC0eXvW3eLu3k92i
 +526A7PHzll32T3O3tnB6NHf3cIawBzFZZOSmpNZllqkb5fAlbH10ArGgtn8Fc/eejUwzuTt
 YuTkkBAwkdh2so+ti5GLQ0hgMZPEwddn2SGch4wSH899ZwOpYhNQkXj84h4riM0ioCrxr/ka
 mC0skCgx7cZmdhCbV0BQ4uTMJyxdjBwczAKaEut36YOEmQXkJba/ncMMUZIisetuBxOILQRk
 /zs2CSzOKZAqcW71KnaQVhEBNYnT86BaaySm3p/HDnGnsET7oltQrbISL873QsXlJaade80M
 YYdKbP2ynWkCo9AsJAfNQjhoFpKDFjAyr2IUys1Mzk4tyszWK8ioLElN1ktJ3cQICmURBq4d
 jH1zPA4xMnEwHmKU4GBWEuHd29mUKsSbklhZlVqUH19UmpNafIhRmoNFSZx3dUdwqpBAemJJ
 anZqakFqEUyWiYNTqoFx3o2iLjn9xFTDn+2LP1k6xRQt2jdvl+v2y3Yr1dfWCJQoyvWW95u3
 9mg22MzfauT6P2jlPHOdvOh9C/5+yy3Qtb65ICxCYJXFnuy6C59V9537XWX0N3/Fd00lk4gk
 19Umuyc7P7wvyqm1rfHos5NnmHNe/2gWu70rwLVM79LzKR0lmxxl6gKUWIozEg21mIuKEwEs
 C1CNUwIAAA==
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

