Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CF2C46CCD
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 08:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BE24876E8;
	Wed, 20 Dec 2023 09:45:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="SLbTO98I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A99F486D4C; Wed, 20 Dec 2023 09:45:44 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03C278765E
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:45:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1703061940; x=1705653940;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+p9cSagMgdIthOEDQCevQKCsaJYplLP/nKN79+vfSgw=;
 b=SLbTO98Icf+hsLg2wHCARyISZReTVOydKAbmwzPTc8EfLIHFFvAF7dmgfyNjUUPa
 bE6t8zoHYi8Ys7kV5bDzQbNXHwc6aMaQ+dF44KVhZ+NgGc5bsZ9/0tAcqtN6qecS
 s69kcYlRE7cga4svD8mH4Qc+BWrBCLSC8H6JMiA1LFM=;
X-AuditID: ac14000a-fbefe7000000290d-eb-6582a9b429a8
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 67.E0.10509.4B9A2856;
 Wed, 20 Dec 2023 09:45:40 +0100 (CET)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Dec
 2023 09:45:40 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 20 Dec 2023 09:45:36 +0100
Subject: [PATCH v2 5/5] board: phytec: phytec_som_detection: fix
 uninitialized bug
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v2-5-516abadb4f49@phytec.de>
References: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v2-0-516abadb4f49@phytec.de>
In-Reply-To: <20231220-wip-y-moog-phytec-de-upstream_som_detection_fixes-v2-0-516abadb4f49@phytec.de>
To: Fabio Estevam <festevam@gmail.com>
CC: Teresa Remmet <t.remmet@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWyRpKBR3fLyqZUg7aduhYPr/pbvN3byW7R
 /U7dgdlj56y77B5n7+xg9OjvbmENYI7isklJzcksSy3St0vgyjjx7wVbwV72ioVXtRsY57B1
 MXJySAiYSGxZv4G9i5GLQ0hgMZPE7aMP2CCch4wSV1Z2M4NUsQmoSDx+cY8VxGYRUJU48wSi
 W1ggROLEtrvsIDavgKDEyZlPWLoYOTiYBTQl1u/SBwkzC8hLbH87hxmiJEVi0oYlYGOEgOwz
 ffcYQWxOgVSJJe9Os4O0igioSZyeB9VaIzH1/jx2iDuFJdoX3WKCaJWVeHG+FyouLzHt3Gtm
 CDtU4sim1UwTGIVmITloFsJBs5ActICReRWjUG5mcnZqUWa2XkFGZUlqsl5K6iZGUCiLMHDt
 YOyb43GIkYmD8RCjBAezkgjv3s6mVCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8qzuCU4UE0hNL
 UrNTUwtSi2CyTBycUg2M1Zsddhfv4jt4+5OlR2jI2T/9lafNhF9OXrZs6WmzZMYqvuaLnizz
 Fu5s9filUdVodfnW1pa6tf9i3hxlldmQzPoqW89QRWOve53O48Ur5va7nevoLM1c6h5darXD
 6Fv5HmOGjJPKBu/cGKdc9ExXOvXLOXve/o2L122QOK9gtCHr3jTn3Px4JZbijERDLeai4kQA
 es0BoFMCAAA=
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

When som_type does not match any case, it is uninitialized and the
function still tries to print the SoM info. Rather, this is an error
condition and the function should abort prematurely. Highlight this by
printing an error message and returning early.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 board/phytec/common/phytec_som_detection.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/phytec/common/phytec_som_detection.c b/board/phytec/common/phytec_som_detection.c
index f879702df45..1b10923b62f 100644
--- a/board/phytec/common/phytec_som_detection.c
+++ b/board/phytec/common/phytec_som_detection.c
@@ -161,7 +161,8 @@ void __maybe_unused phytec_print_som_info(struct phytec_eeprom_data *data)
 			sub_som_type2 = 2;
 			break;
 		default:
-			break;
+			pr_err("%s: Invalid SoM type: %i", __func__, api2->som_type);
+			return;
 		};
 
 		printf("SoM: %s-%03u-%s-%03u ",

-- 
2.34.1

