Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD5FC47074
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:47:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DB1087BC7;
	Fri, 29 Dec 2023 18:47:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="l7MImcjz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44C2587BC7; Fri, 29 Dec 2023 18:47:10 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3D4687B82
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1SC032427;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=pGmCo4JkyEWscJT1FAfiyW4Y7hQZM1mHl52rUOY1vvk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=l7MImcjz64R9yekePZXEUskhPCHIIyPN2Ow5q507K727CI/Cui/srBTzDMVufsySd
 GhRxo/hgh+UG+wQ5NNIRQDz/TzaEVT+b3kEIwQSQ/DioAyhtDjnz3Jepj1iWNgsqvx
 vqSw7i5JkFNd7n6Kxw+MCedpgA4BE1xBKUiS63EU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl1M1025007
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl0RA005058;
 Fri, 29 Dec 2023 11:47:00 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 07/26] arm: dts: k3-am654: remove duplicate vtt_supply
Date: Fri, 29 Dec 2023 11:47:04 -0600
Message-ID: <20231229174656.634065-35-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=886; i=bb@ti.com;
 h=from:subject; bh=izpyJhGpVe/MOlCREVe7A7vCvsBmLRACnmsrZ2jGQfg=;
 b=owNCWmg5MUFZJlNZDoXU5QAAX3///3dp5/3nm/fO36/zXvezM+yq6/+a2f49f/79/rN2/f+wA
 RsYkPUZAPSAAAGgB6g0BkGjQaAGgAAAANAaGgDTQAaANDJo9T0nqaND01Mnqep5Q5NA0BoGnqNA
 0AAaBoBoD0mhoAA0Bowg0GgMhoGjymgNANDT1HlNNGhoeoxAMOQDRppiaGgyGhoANGgyMhpiGmR
 o0AAZA0BkZDCBpoMQaAxDTQYRpoyNBkNCB+4JUDM8nYEhcfaEAokMI89egh8wBLApDdBuQ0a/AJ
 nuArPFEY0nOQtGjdyUhgMpjhfSx0ni4G+xgIJj3p/wyfJz9JA58ipXiqxh94JYAm9A2RXQl8DkO
 wym3hTidaDdEOZeAX6ftkdYY26FipGhUQlU1DzOJfPLP8BtF/agnWk+FyM4JJ3JkmoptxUetH5d
 ojJrFajiWmQY9hqIcU3w53ZfIg/LtS6UaO4FuggYVggqkM0aFYBlFXgGeMwXXYPSm3IPiHUQLwH
 rE6AAhz1VpTEr5G/oxVoU6NQKqgTxwX76eJFFrgWaAT9oKNAw/gn9eMZkvTUzDorgJCrFC7JFWs
 cpghcQNVlhgWxR9SaXlFBrPhil+SC+jEAvJEf8GHCVyA9S5Vl77sjb5djX0ySmCTYxZBGBXkgTp
 Ra0tA1Lc8HYKMI82F3JFOFCQDoXU5Q=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

With the Linux and U-Boot board dtb files unified we now have a
duplicate vtt_supply node. Remove it

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 79ca6387c22bb..50e6be6118294 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -46,15 +46,6 @@
 		ti,sci-host-id = <10>;
 		bootph-pre-ram;
 	};
-
-	vtt_supply: vtt_supply {
-		compatible = "regulator-gpio";
-		regulator-name = "vtt";
-		regulator-min-microvolt = <0>;
-		regulator-max-microvolt = <3300000>;
-		gpios = <&wkup_gpio0 28 GPIO_ACTIVE_HIGH>;
-		states = <0 0x0 3300000 0x1>;
-	};
 };
 
 &cbass_main {
-- 
2.43.0

