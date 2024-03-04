Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E43C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 12:31:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34F3E87F9B;
	Mon,  4 Mar 2024 13:31:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="tqCDvAip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03F0087F88; Mon,  4 Mar 2024 13:31:04 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C867587F92
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 13:31:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1709555460; x=1712147460;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sDfZGtyeXymJ2yH8LREQ3ya7q+tpXwAQRf7yqHpURxs=;
 b=tqCDvAip6Em27aU2R9TYJ2Z6aObCwGDr3eOEnoNWZri+ngkPYl32R1wJ7XWJCCUt
 UCTfGgtr/lchhMkR1EFp5dj0c/8umKmpy6cu2xbAwXbuqTBde/1zx+phJwZccrjO
 w8tKs21fhv2cyyxIBPXs82LLapbK1VWCTTVpUcbBn+c=;
X-AuditID: ac14000a-fbefe7000000290d-36-65e5bf047a51
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 45.36.10509.40FB5E56;
 Mon,  4 Mar 2024 13:31:00 +0100 (CET)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 4 Mar 2024
 13:31:00 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Mon, 4 Mar 2024 13:30:47 +0100
Subject: [PATCH 1/2] board: phytec: common: phytec_som_detection: Add
 phytec_get_som_type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240304-pcl-070-patches-v1-1-6aa6c89e3b81@phytec.de>
References: <20240304-pcl-070-patches-v1-0-6aa6c89e3b81@phytec.de>
In-Reply-To: <20240304-pcl-070-patches-v1-0-6aa6c89e3b81@phytec.de>
To: Tom Rini <trini@konsulko.com>, Teresa Remmet <t.remmet@phytec.de>, Fabio
 Estevam <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709555459; l=1827;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=sDfZGtyeXymJ2yH8LREQ3ya7q+tpXwAQRf7yqHpURxs=;
 b=GgU1HWLnEvqFDeR+TG1CLO/JOVHSVh6NS3nE51TTSiavjUZj0+a40UiieNOTSLO33pSS3qy0c
 JhaxaXk4ebQCVRJkBtVah9SAEFYhSwUPc1TPtXUSaEBT/r2tUV834n/
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWyRpKBR5dl/9NUg7ePpS0eXvW3mDppM7vF
 272d7Bbd79QdWDx2zrrL7vHqwCp2j7N3djB69He3sAawRHHZpKTmZJalFunbJXBlfD/xl7Fg
 KV/Fm8OFDYzzeLoYOTgkBEwkdjUGdDFycggJLGaSmPtcsYuRC8h+wCjx5vNxFpAEm4CaxK43
 r1lBbBYBFYnz7W8YQWxhgWiJW5v2gtm8AoISJ2c+YQGZySygKbF+lz5ImFlAXmL72znMECVO
 Elc/LGQDKRECsqe9EgUxOQWcJb7vCgKpEBHIlnjWuYUdYkiUxLuJQRA3Ckts2qkFcpeEwG4m
 ianTPzBDxBMldr6Wg7hdVuLm+S1sILYE0M5p514zQ9ihEkc2rWaawCgyC8mVsxCunIXkygWM
 zKsYhXIzk7NTizKz9QoyKktSk/VSUjcxgqJAhIFrB2PfHI9DjEwcjIcYJTiYlUR4a349SRXi
 TUmsrEotyo8vKs1JLT7EKM3BoiTOu7ojOFVIID2xJDU7NbUgtQgmy8TBKdXAOH1dculNb/6m
 w3Z2cx8/cn6dk3NsvdymS3nRhguv7JRa1m6gKN8brbIoRN696PAMo5kf34amtC1ucQvlfhjL
 tuFEgK686dGuo8wbGOMviG/b/cbX4sRMt/2ufyff0PJR/KMfXXYldt9duS2qL8NXtIWIn+q6
 pGW0+ZtGq8IkaydGvq8uTpVMSizFGYmGWsxFxYkA4SZpFnACAAA=
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
index c73bf9721b2f..eaf7659c051d 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -203,6 +203,16 @@ u8 __maybe_unused phytec_get_rev(struct phytec_eeprom_data *data)
 	return api2->pcb_rev;
 }
 
+u8 __maybe_unused phytec_get_som_type(struct phytec_eeprom_data *data)
+{
+	if (!data)
+		data = &eeprom_data;
+	if (!data->valid || data->data.api_rev < PHYTEC_API_REV2)
+		return PHYTEC_EEPROM_INVAL;
+
+	return data->data.data.data_api2.som_type;
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

