Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127F7C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 16:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FB6D8205A;
	Mon,  2 Jun 2025 18:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OPFMZRiC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9151E828A2; Mon,  2 Jun 2025 18:56:36 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 123D181F32
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 18:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 552GuTpr3264690;
 Mon, 2 Jun 2025 11:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748883389;
 bh=wnlL8QVM+tB7AKrqRQ4q31RkaX9um4oerhOtTWhBxD4=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=OPFMZRiCUd3ZHUuFloxKVjgnw2B8FwI0fAxmZh+aAb5rdO3O8H1iXtv20KCLLGQwZ
 GcP5RpmwdlysyzUQQ9LTOZops7z3nAle8wwMadp9AW8fr6kSRACZEn7QtNy87wzLSO
 ZD1kWXC6t9+Z4YwWKLmqb19mKZ4ORd4d+1eU2eDY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 552GuTXP2934178
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 2 Jun 2025 11:56:29 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Jun 2025 11:56:29 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Jun 2025 11:56:29 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 552GuTiE3335166;
 Mon, 2 Jun 2025 11:56:29 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 2 Jun 2025 11:56:26 -0500
Subject: [PATCH tiU2025.01 1/2] binman: openssl: remove unused encryption
 extension
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250602-am62xsip-v1-1-ae8aa62b4b6e@ti.com>
References: <20250602-am62xsip-v1-0-ae8aa62b4b6e@ti.com>
In-Reply-To: <20250602-am62xsip-v1-0-ae8aa62b4b6e@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>, Bryan Brattlof
 <bb@ti.com>
X-Mailer: b4 0.14.2
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

We currently do not have a way for binman to encrypt any component it
packages. Remove this to avoid any confusion.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 tools/binman/btool/openssl.py | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/binman/btool/openssl.py b/tools/binman/btool/openssl.py
index c6df64c5316d53735fb147858b24185096254ec2..2e128e477bce87568b6d9647bbf2666f9770d732 100644
--- a/tools/binman/btool/openssl.py
+++ b/tools/binman/btool/openssl.py
@@ -198,7 +198,6 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
  1.3.6.1.4.1.294.1.1 = ASN1:SEQUENCE:boot_seq
  1.3.6.1.4.1.294.1.2 = ASN1:SEQUENCE:image_integrity
  1.3.6.1.4.1.294.1.3 = ASN1:SEQUENCE:swrv
-# 1.3.6.1.4.1.294.1.4 = ASN1:SEQUENCE:encryption
  1.3.6.1.4.1.294.1.8 = ASN1:SEQUENCE:debug
 
  [ boot_seq ]
@@ -215,12 +214,6 @@ emailAddress           = {req_dist_name_dict['emailAddress']}
  [ swrv ]
  swrv = INTEGER:{sw_rev}
 
-# [ encryption ]
-# initalVector = FORMAT:HEX,OCT:TEST_IMAGE_ENC_IV
-# randomString = FORMAT:HEX,OCT:TEST_IMAGE_ENC_RS
-# iterationCnt = INTEGER:TEST_IMAGE_KEY_DERIVE_INDEX
-# salt = FORMAT:HEX,OCT:TEST_IMAGE_KEY_DERIVE_SALT
-
  [ debug ]
  debugUID = FORMAT:HEX,OCT:0000000000000000000000000000000000000000000000000000000000000000
  debugType = INTEGER:4

-- 
2.49.0

