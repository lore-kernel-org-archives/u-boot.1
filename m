Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA56C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 16:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2D5087E92;
	Mon,  4 Mar 2024 17:04:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="qV65w0Yp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ED7487FD6; Mon,  4 Mar 2024 17:04:29 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB24C87F9F
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 17:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1709568266; x=1712160266;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7tEESjFYAC5ycSxDkMcKq6L20ivhlizyLMZyIjGjSbI=;
 b=qV65w0YpCsyK+4IxE1sgheuH9/t7agxM07FeWUEpZSbyPnk0rZyROtL/SaeW2jU7
 o58bXxk6G28qZt7AFqu47aRpJR0HRx5AtgKjcS0TPlPCF8dn8UIRfNBThEkStZWI
 jiZgx9YMvnBj5j9nFk/f6x86hyNIYRCq2XN19eVdXoA=;
X-AuditID: ac14000a-fadff7000000290d-c5-65e5f10a0aca
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id B1.08.10509.A01F5E56;
 Mon,  4 Mar 2024 17:04:26 +0100 (CET)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 4 Mar 2024
 17:04:26 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Mon, 4 Mar 2024 17:04:19 +0100
Subject: [PATCH v2 1/2] board: phytec: common: phytec_som_detection: Add
 phytec_get_som_type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240304-pcl-070-patches-v2-1-c534960c4b8b@phytec.de>
References: <20240304-pcl-070-patches-v2-0-c534960c4b8b@phytec.de>
In-Reply-To: <20240304-pcl-070-patches-v2-0-c534960c4b8b@phytec.de>
To: Tom Rini <trini@konsulko.com>, Teresa Remmet <t.remmet@phytec.de>, Fabio
 Estevam <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709568265; l=1801;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=7tEESjFYAC5ycSxDkMcKq6L20ivhlizyLMZyIjGjSbI=;
 b=YGoKyA7mHKAZeeviDEHr9jeyqnitittxkKG5OQzs1TgtXYTp0lEBm2Qdm7Trh9pUBdd2mvKj+
 9IgmvA0CfDVCveVitsyqNXkeos4KMT66ZV7YfL4x204/MLjkHcjUMFS
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWyRpKBR5fr49NUg/aNChYPr/pbTJ20md3i
 7d5Odovud+oOLB47Z91l93h1YBW7x9k7Oxg9+rtbWANYorhsUlJzMstSi/TtErgy2j4eYivo
 5qtYcbaHqYGxjaeLkZNDQsBE4vmEd0xdjFwcQgKLmST23mxihnAeMEp8//SRFaSKTUBNYteb
 12A2i4CKxJRpO9lBbGGBOIl/O7cygdi8AoISJ2c+Yeli5OBgFtCUWL9LHyTMLCAvsf3tHGaI
 EieJ9zd3s4HYQkD2nW8dYDangLPEzUs/wGwRgWyJZ51b2CHGREm8mxgEYkoICEts2qkFcpmE
 wG4miX8fp7BDxBMldr6Wg5goK3Hz/BY2iLfkJaade80MYYdKHNm0mmkCo8gsJHfOQrhzFpI7
 FzAyr2IUys1Mzk4tyszWK8ioLElN1ktJ3cQIigcRBq4djH1zPA4xMnEwHmKU4GBWEuGt+fUk
 VYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv6o7gVCGB9MSS1OzU1ILUIpgsEwenVANjTefZcxkG
 S4xMorQeJei5Km9tT+ntXpUW0pEmp2b185j32r6FR6XMbhvXH4rOexV8xCLnwdEnC4W6zU+/
 XNxwnu/kIbVNE4S9uh/fi5W/cfbmpSd36tJX2DX85Pxn2z/rpf0dx6oSTemGgN9/j579umId
 94ItKTIJ+Z39f+dcby+qu31rn36iEktxRqKhFnNRcSIAidhZd3UCAAA=
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

Add a function that gets the som_type from the EEPROM.
Add an enum for the som_type.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 board/phytec/common/phytec_som_detection.c | 10 ++++++++++
 board/phytec/common/phytec_som_detection.h |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index c73bf9721b2f..f9607b018dea 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -203,6 +203,16 @@ u8 __maybe_unused phytec_get_rev(struct phytec_eeprom_data *data)
 	return api2->pcb_rev;
 }
 
+u8 __maybe_unused phytec_get_som_type(struct phytec_eeprom_data *data)
+{
+	if (!data)
+		data = &eeprom_data;
+	if (data->api_rev < PHYTEC_API_REV2)
+		return PHYTEC_EEPROM_INVAL;
+
+	return data->data.data_api2.som_type;
+}
+
 #else
 
 inline int phytec_eeprom_data_setup(struct phytec_eeprom_data *data,
diff --git a/board/phytec/common/phytec_som_detection.h b/board/phytec/common/phytec_som_detection.h
index 11009240875c..c0f0c57a6123 100644
--- a/board/phytec/common/phytec_som_detection.h
+++ b/board/phytec/common/phytec_som_detection.h
@@ -19,6 +19,13 @@ enum {
 	PHYTEC_API_REV2,
 };
 
+enum phytec_som_type_str {
+	PCM = 0,
+	PCL,
+	KSM,
+	KSP,
+};
+
 static const char * const phytec_som_type_str[] = {
 	"PCM",
 	"PCL",
@@ -67,5 +74,6 @@ void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data);
 
 char * __maybe_unused phytec_get_opt(struct phytec_eeprom_data *data);
 u8 __maybe_unused phytec_get_rev(struct phytec_eeprom_data *data);
+u8 __maybe_unused phytec_get_som_type(struct phytec_eeprom_data *data);
 
 #endif /* _PHYTEC_SOM_DETECTION_H */

-- 
2.34.1

