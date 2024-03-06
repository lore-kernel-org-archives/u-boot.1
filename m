Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1381BC5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 16:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D012878E2;
	Wed,  6 Mar 2024 17:18:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="CIM0M06F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D57D878E2; Wed,  6 Mar 2024 17:18:40 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EF9987CF8
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 17:18:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1709741917; x=1712333917;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JgLUxN6bpRysy5jJwfOprGqqanEvDHcAR4xJ6lN3eUs=;
 b=CIM0M06F1ZNgMNtcVUDvSkliGGSDcnvn4OplqHNsh4BLmHM3dt/1WER7EBz4ncg9
 +hC3Mj38Ts4L8JLBNzAZ3JCDKtWxAPUJr0gJwbiQbDioSt89X/M2zqKEHYzP6Qvd
 JAUp7/iMqKxMh+wNfCTndCr+h3WRrQCrZ3UcflBDbvk=;
X-AuditID: ac14000a-fadff7000000290d-f4-65e8975d7f06
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 0E.E3.10509.D5798E56;
 Wed,  6 Mar 2024 17:18:37 +0100 (CET)
Received: from llp-hahn.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 6 Mar 2024
 17:18:37 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Wed, 6 Mar 2024 17:18:31 +0100
Subject: [PATCH v3 1/2] board: phytec: common: phytec_som_detection: Add
 phytec_get_som_type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240306-pcl-070-patches-v3-1-cb39c3487bc3@phytec.de>
References: <20240306-pcl-070-patches-v3-0-cb39c3487bc3@phytec.de>
In-Reply-To: <20240306-pcl-070-patches-v3-0-cb39c3487bc3@phytec.de>
To: Tom Rini <trini@konsulko.com>, Teresa Remmet <t.remmet@phytec.de>, Fabio
 Estevam <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709741916; l=1837;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=JgLUxN6bpRysy5jJwfOprGqqanEvDHcAR4xJ6lN3eUs=;
 b=LsHWzIOKQ3PKUyo1feJaYUU3kN9PSJM5MohcqaGClZ26Uiykk8R/g9k8Ajua+izrTDEwEHVCx
 Ou8SmREx6VIB6HVhNJ7/CPP5CNzxSQ9u39ww0qyKuVCaoYZaotbRGo2
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWyRpKBRzd2+otUg1+9fBYPr/pbTJ20md3i
 7d5Odovud+oOLB47Z91l93h1YBW7x9k7Oxg9+rtbWANYorhsUlJzMstSi/TtErgyFh7Yylqw
 nq/i+PUtTA2Mq3i6GDk5JARMJPZO7WfrYuTiEBJYzCRx/e98RgjnAaPEvak/2ECq2ATUJHa9
 ec0KYrMIqEhs3nKMBcQWFoiT+H2ngxHE5hUQlDg58wlQnIODWUBTYv0ufZAws4C8xPa3c5gh
 Spwkniw4AGYLAdnt22+CtXIKOEscurQSbKSIQLbEs84t7BBjoiTeTQwCMSUEhCU27dQCuUxC
 YDeTxNrOmywQ8USJna/lICbKStw8v4UN4i15iWnnXjND2KESRzatZprAKDILyZ2zEO6cheTO
 BYzMqxiFcjOTs1OLMrP1CjIqS1KT9VJSNzGC4kGEgWsHY98cj0OMTByMhxglOJiVRHhrfj1J
 FeJNSaysSi3Kjy8qzUktPsQozcGiJM67uiM4VUggPbEkNTs1tSC1CCbLxMEp1cAo7ZXUfTok
 Vcp5QvWhWAuR1R98a5/JPpN7cKb6bWTiBt4LUy4sDVj8QfFhVqvHlyavA/OO7FzT93FxSIzt
 LYOS8+ZeH3Pyli3V+/Fz3c1wVtb6pJM9wf6zLl1R9jw3WWBZ+vmk7xflpgRL/bxp0H/Afd8p
 HR/dxwf6pCZ78E6WWbrqmWC4mlCOEktxRqKhFnNRcSIALYVaiHUCAAA=
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
index 11009240875c..7edbfa3ca5c6 100644
--- a/board/phytec/common/phytec_som_detection.h
+++ b/board/phytec/common/phytec_som_detection.h
@@ -19,6 +19,13 @@ enum {
 	PHYTEC_API_REV2,
 };
 
+enum phytec_som_type_str {
+	SOM_TYPE_PCM = 0,
+	SOM_TYPE_PCL,
+	SOM_TYPE_KSM,
+	SOM_TYPE_KSP,
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

