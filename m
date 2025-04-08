Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36012C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 07:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCC9E83211;
	Tue,  8 Apr 2025 09:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="Eh+/O9VV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33C8783339; Tue,  8 Apr 2025 09:17:13 +0200 (CEST)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1BA6831FE
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 09:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=I2Qf38D8gkTI4IOrOwvWpALByNmzSt6KBXVPrBIhBrs=; b=Eh+/O9VVa5Ghd4srF8ziYo9v9/
 +VLye3taTv2dpD8eBYkMxe+WqRsZ4DMvUruySxg1ePlQWYWxqG6dd2grCMniLu3qpe3b60NqMPbVH
 ossq2CCHj9vxa30OMnZQk674yiwCuD79JHlJz0Feo5KGI4+upRTaBg0EkjChE2ZgDxU9VyOC5fLAP
 fWcjd2p+68P+W6PcmrYG/2nPbE/SO0XE/cvJgsmevOjWtMYL9mWPmvQkWFwBLzt2fMnYCiDiNtp/E
 yrf/P9SFXe8Xk4ohyKO0twZ3WhFwpFkw2992r2CuEFyHKi7gjqXLYXUFSoaPi7QoYmZ8h616EmT30
 ic6YLcrg==;
Received: from [89.212.21.243] (port=39300 helo=localhost.localdomain)
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1u23Cp-00AN1v-1I;
 Tue, 08 Apr 2025 09:17:10 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Tom Rini <trini@konsulko.com>, Daniel Schultz <d.schultz@phytec.de>,
 Teresa Remmet <t.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>,
 Wadim Egorov <w.egorov@phytec.de>, Primoz Fiser <primoz.fiser@norik.com>,
 u-boot@lists.denx.de, upstream@lists.phytec.de
Subject: [PATCH] board: phytec: common: Fix phytec_get_product_name()
Date: Tue,  8 Apr 2025 09:17:10 +0200
Message-Id: <20250408071710.3618157-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Currently, phytec_get_product_name() function only takes care of PCM
SoM type, however in case of PCL, KSM or KSP SoM type it will return
error:

  phytec_get_product_name: Invalid SOM type

Add support for other SoM types as defined in phytec_som_type_str enum
(see phytec_som_detection.h) to get rid of the error.

While at it, also simplify switch case statements by grouping them
together. This makes it more concise and readable.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
Reviewed-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/common/phytec_som_detection.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index 1f2213902edb..4d7c9b9f80f6 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -295,17 +295,16 @@ static int phytec_get_product_name(struct phytec_eeprom_data *data,
 
 	switch (api2->som_type) {
 	case 0:
+	case 1:
+	case 2:
+	case 3:
 		som_type = api2->som_type;
 		break;
 	case 4:
-		som_type = 0;
-		break;
 	case 5:
 		som_type = 0;
 		break;
 	case 6:
-		som_type = 1;
-		break;
 	case 7:
 		som_type = 1;
 		break;
-- 
2.34.1

