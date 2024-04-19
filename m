Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84136C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FD87887BD;
	Fri, 19 Apr 2024 18:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Ckts0Igh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C4AB8873B; Fri, 19 Apr 2024 17:56:03 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2485886DA
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 17:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1713542156; x=1716134156;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H07XR7DP9u5BVjqft4yW+SJvcuQYDslGXarPfBAhoiU=;
 b=Ckts0IghUSVYE0W+SV/vKwW19UXep3ZU3eJ+nHQ5jsBPhk5xrc19ygUMh3tGav2Y
 6iC9FfW8rLBJVwSq/ztKci6SGxiGUyzPtJpSxbbdOU4WgoA9SAyK005InjNLo9If
 qyW6JYqYKod0wk8FPleFB4xre84mKW105iA9hXG8lQ8=;
X-AuditID: ac14000a-fadff7000000290d-71-6622940cd008
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 4C.38.10509.C0492266;
 Fri, 19 Apr 2024 17:55:56 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 19 Apr
 2024 17:55:55 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>
CC: Yannic Moog <y.moog@phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 3/5] board: phytec: check eeprom_data validity
Date: Fri, 19 Apr 2024 08:55:38 -0700
Message-ID: <20240419155540.2447006-4-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240419155540.2447006-1-d.schultz@phytec.de>
References: <20240419155540.2447006-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWyRpKBR5dnilKawcG7GhZv93ayOzB6nL2z
 gzGAMYrLJiU1J7MstUjfLoEr4+meJ0wF3+QrFnWsYmpgfCbVxcjJISFgIvH5whyWLkYuDiGB
 JUwSv1f8Z4Rw7jNKTFo4jRWkik1AS+LOlrnMILaIgJTEy86NYDazgIfE1DN9TCC2sICdRMeR
 7WD1LAKqEtcu/mMDsXkFrCQeH/nMCLFNXmLmpe/sIDangLXE9+1fwOYIAdWcX3weql5Q4uTM
 JywQ8+UlmrfOhtolIXHwxQuoegWJ2dsmw82cdu41M4QdKnFk02qmCYxCs5CMmoVk1CwkoxYw
 Mq9iFMrNTM5OLcrM1ivIqCxJTdZLSd3ECApXEQauHYx9czwOMTJxMB5ilOBgVhLhNeNQTBPi
 TUmsrEotyo8vKs1JLT7EKM3BoiTOu7ojOFVIID2xJDU7NbUgtQgmy8TBKdXA6Dh7XeCc1e3f
 hGpimU9tOZq863TZEkk1vZumOzjFjyve196Qe8zNwcO3oW07n97dmymdm7692tPcp+3DvXWf
 RlPulf0T7bX9r7G/VRCUYXXjWvdPi79t2k2+1zlsU5e/ski5VXvymcFh7tnJh39s0pILzRBQ
 eK0VEbPax/e8v6Z63WrHmcb5SizFGYmGWsxFxYkAXkdRy0UCAAA=
X-Mailman-Approved-At: Fri, 19 Apr 2024 18:22:18 +0200
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

From: Yannic Moog <y.moog@phytec.de>

For all of the functions that access the eeprom_data, make sure these
data are valid. Use the valid member of the phytec_eeprom_data struct.
This fixes a bug where only the API revision check guarded against
accessing rubbish. But if API revision was e.g. 6, eeprom setup failed
before, but phytec_get_imx8m_eth would still happily access the data.

Fixes: dc22188cdc8 ("board: phytec: Add common PHYTEC SoM detection")

Signed-off-by: Yannic Moog <y.moog@phytec.de>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/common/imx8m_som_detection.c  | 11 +++++++----
 board/phytec/common/phytec_som_detection.c | 10 +++++++---
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/board/phytec/common/imx8m_som_detection.c b/board/phytec/common/imx8m_som_detection.c
index 7571076a09e..ee34a5b9579 100644
--- a/board/phytec/common/imx8m_som_detection.c
+++ b/board/phytec/common/imx8m_som_detection.c
@@ -34,7 +34,7 @@ int __maybe_unused phytec_imx8m_detect(struct phytec_eeprom_data *data)
 		data = &eeprom_data;
 
 	/* We can not do the check for early API revisions */
-	if (data->payload.api_rev < PHYTEC_API_REV2)
+	if (!data->valid || data->payload.api_rev < PHYTEC_API_REV2)
 		return -1;
 
 	som = data->payload.data.data_api2.som_no;
@@ -75,6 +75,9 @@ u8 __maybe_unused phytec_get_imx8m_ddr_size(struct phytec_eeprom_data *data)
 	if (!data)
 		data = &eeprom_data;
 
+	if (!data->valid || data->payload.api_rev < PHYTEC_API_REV2)
+		return PHYTEC_EEPROM_INVAL;
+
 	opt = phytec_get_opt(data);
 	if (opt)
 		ddr_id = PHYTEC_GET_OPTION(opt[2]);
@@ -99,7 +102,7 @@ u8 __maybe_unused phytec_get_imx8m_spi(struct phytec_eeprom_data *data)
 	if (!data)
 		data = &eeprom_data;
 
-	if (data->payload.api_rev < PHYTEC_API_REV2)
+	if (!data->valid || data->payload.api_rev < PHYTEC_API_REV2)
 		return PHYTEC_EEPROM_INVAL;
 
 	opt = phytec_get_opt(data);
@@ -126,7 +129,7 @@ u8 __maybe_unused phytec_get_imx8m_eth(struct phytec_eeprom_data *data)
 	if (!data)
 		data = &eeprom_data;
 
-	if (data->payload.api_rev < PHYTEC_API_REV2)
+	if (!data->valid || data->payload.api_rev < PHYTEC_API_REV2)
 		return PHYTEC_EEPROM_INVAL;
 
 	opt = phytec_get_opt(data);
@@ -154,7 +157,7 @@ u8 __maybe_unused phytec_get_imx8mp_rtc(struct phytec_eeprom_data *data)
 	if (!data)
 		data = &eeprom_data;
 
-	if (data->payload.api_rev < PHYTEC_API_REV2)
+	if (!data->valid || data->payload.api_rev < PHYTEC_API_REV2)
 		return PHYTEC_EEPROM_INVAL;
 
 	opt = phytec_get_opt(data);
diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index 7913764be0a..5a4cc9e8b02 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -128,7 +128,7 @@ void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data)
 	if (!data)
 		data = &eeprom_data;
 
-	if (data->payload.api_rev < PHYTEC_API_REV2)
+	if (!data->valid || data->payload.api_rev < PHYTEC_API_REV2)
 		return;
 
 	api2 = &data->payload.data.data_api2;
@@ -190,6 +190,9 @@ char * __maybe_unused phytec_get_opt(struct phytec_eeprom_data *data)
 	if (!data)
 		data = &eeprom_data;
 
+	if (!data->valid)
+		return NULL;
+
 	if (data->payload.api_rev < PHYTEC_API_REV2)
 		opt = data->payload.data.data_api0.opt;
 	else
@@ -205,7 +208,7 @@ u8 __maybe_unused phytec_get_rev(struct phytec_eeprom_data *data)
 	if (!data)
 		data = &eeprom_data;
 
-	if (data->payload.api_rev < PHYTEC_API_REV2)
+	if (!data->valid || data->payload.api_rev < PHYTEC_API_REV2)
 		return PHYTEC_EEPROM_INVAL;
 
 	api2 = &data->payload.data.data_api2;
@@ -217,7 +220,8 @@ u8 __maybe_unused phytec_get_som_type(struct phytec_eeprom_data *data)
 {
 	if (!data)
 		data = &eeprom_data;
-	if (data->payload.api_rev < PHYTEC_API_REV2)
+
+	if (!data->valid || data->payload.api_rev < PHYTEC_API_REV2)
 		return PHYTEC_EEPROM_INVAL;
 
 	return data->payload.data.data_api2.som_type;
-- 
2.25.1

