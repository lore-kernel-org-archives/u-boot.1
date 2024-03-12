Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D460CC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 09:39:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3249F87DE6;
	Tue, 12 Mar 2024 10:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="is9va09i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E52E387DFF; Tue, 12 Mar 2024 10:39:33 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CA6487D9B
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 10:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710236371; x=1712828371;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XNH8xOkzSo+fNEGBYARUS0M+r2ngHPV0MhDt+GM3/w8=;
 b=is9va09i/gN2DmhQ3zOSau8Yqnys2nxYpl9xjeLFXbBVddTVA0qxzvGhVPdDx8RX
 /SITxTyP4xl0/sqm7+3HvqErLeXsNKGXa8XGv50+dam8BarcFVR+twn05bqIUe5U
 Fyq7BXqB4S40j1+9jvHIn8Dm764ilzpqQcZqxPnG/VU=;
X-AuditID: ac14000a-fadff7000000290d-22-65f022d350cd
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id E5.08.10509.3D220F56;
 Tue, 12 Mar 2024 10:39:31 +0100 (CET)
Received: from llp-hahn.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 12 Mar
 2024 10:39:30 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Tue, 12 Mar 2024 10:39:11 +0100
Subject: [PATCH] board: phytec: define get_som_type also when SoM detection
 is disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240312-pcl-070-fix-v1-1-38b5b73e137d@phytec.de>
X-B4-Tracking: v=1; b=H4sIAL4i8GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0Mj3YLkHF0DcwPdtMwK3STzpBSLpBRzkxTTJCWgjoKiVKAw2LTo2Np
 aABoMnJFdAAAA
To: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710236370; l=1036;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=XNH8xOkzSo+fNEGBYARUS0M+r2ngHPV0MhDt+GM3/w8=;
 b=GvARpY551cxXejkyOG7DzHvtS2Xuza/4lsslhFMoUP6m9plL46giNDNfh+hwQYy+bFP5V8Wuf
 67lOtQeP0kjDc6N54bix+2pCgUBjQWVoAjmWOTFVyhk3zfm/fp5zhDW
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWyRpKBR/ey0odUg+59HBYPr/pbTJ20md3i
 7d5Odovud+oOLB47Z91l93h1YBW7x9k7Oxg9+rtbWANYorhsUlJzMstSi/TtErgyLn+8zFLQ
 x1Hx59wS1gbGLvYuRk4OCQETic4j3SxdjFwcQgKLmSQm/pjJBuE8ZJQ4ce4zK0gVm4CaxK43
 r8FsFgFViZ0LnzGC2MICkRIHLnaC2bwCghInZz4BmsTBwSygKbF+lz5ImFlAXmL72znMECV2
 Ekf7N4ItkxBYwSixd8YEsF4RAVeJzWfvQ/VGSbybGARiSggIS2zaqQVRvptJonf5EnaIeKLE
 ztdyIJ1CArISN89vYYP4RV5i2rnXzBB2qMTWL9uZJjAKz0Jy3CyE42YhOW4BI/MqRqHczOTs
 1KLMbL2CjMqS1GS9lNRNjKDAF2Hg2sHYN8fjECMTB+MhRgkOZiUR3tc6b1OFeFMSK6tSi/Lj
 i0pzUosPMUpzsCiJ867uCE4VEkhPLEnNTk0tSC2CyTJxcEo1MDauvb92otWq3ynPWRqNWP/O
 uvQnoOlJ+ORvAbvmG9gq1Mu75bw2v9J/KETy/vf1va8zYpSinj/ZLOWuFv9A7ta82FKepisp
 zz19Lq2xOVHw5dGq7PeWt2Xj7Rg4RRomPnueeN2b2eSuzu55mn8u268wuzpT8YpFc7HlkhuH
 vzLuWcTXuTbagUWJpTgj0VCLuag4EQBNNW/tagIAAA==
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

define the phytec_get_som_type function also when the SoM detection is
disabled.

Fixes:
commit 110d321a56c3 ("board: phytec: common: phytec_som_detection: Add phytec_get_som_type")

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 board/phytec/common/phytec_som_detection.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index f9607b018dea..a56e0f60d628 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -248,4 +248,9 @@ u8 __maybe_unused phytec_get_rev(struct phytec_eeprom_data *data)
 	return PHYTEC_EEPROM_INVAL;
 }
 
+u8 __maybe_unused phytec_get_som_type(struct phytec_eeprom_data *data)
+{
+	return PHYTEC_EEPROM_INVAL;
+}
+
 #endif /* IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION) */

---
base-commit: f3c979dd0053c082d2df170446923e7ce5edbc2d
change-id: 20240312-pcl-070-fix-b7bd8bd74d5b

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>

