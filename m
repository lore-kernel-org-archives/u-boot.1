Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0617FC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 17:46:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79FCF87886;
	Thu, 21 Dec 2023 18:44:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="augSl4Jy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ADDD878F7; Thu, 21 Dec 2023 18:44:28 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91F9187886
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 18:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiFGd118545;
 Thu, 21 Dec 2023 11:44:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703180655;
 bh=A4UrHL+LIbQrmRWlrTkQGBfGKQU9yD0LT7EMU6qoWXE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=augSl4JyHY6AHszvm7TwNjHJFRwKnrMuxFEt7PYgQCZ3h3J9kt3G3uiLpQ0eGJJ/s
 qKOU+BE2fE+2uId0VAHntS8WK6icZAwGZcDT6+iuvGl6R1PWLusNQWlZcKzB+WkJXv
 tO/WJvwZ990/FSnsraCzn2tMYbZyr2QZZh66vI/w=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLHiFSN032100
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Dec 2023 11:44:15 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 11:44:15 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 11:44:14 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLHiEn6080255;
 Thu, 21 Dec 2023 11:44:14 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 22/26] arm: dts: k3-am654: remove duplicate root properties
Date: Thu, 21 Dec 2023 11:44:08 -0600
Message-ID: <20231221174412.210807-23-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=724; i=bb@ti.com;
 h=from:subject; bh=2jEgyERJfWV7t/GHY4NmZlYJs+3QA7yh01JucPlxgRk=;
 b=owNCWmg5MUFZJlNZIFhz2gAAb3/////fY+d67fbv+/3Pf7//99euW/W57/+zzrsd91t8u96wA
 RsYHagDQAAA0AGhpoAaAABppoA0AA0aZA0AANDQAANA9IBhGQ08pk2pp4iHQ0ADQA9TQaAANHqH
 qaekBo0NA9QBoDTQaaDT1AAB6g0Gg09QA0BhAaDIAYIB0HqNGIZBoaZGmjTQaA0yGEGRoMjEAaG
 gGIZAaAAAGhoaMRkaGgDINBoBoAAA3CnggUHduj0GpRCkTGjgY8BJeuY8MuEhwTuET84JtmuWGh
 9qCFKSByaOdzgPTEVOoEUyJkA/RjtOWGdNT+j9KDfSEq4idUZPjXgzQZpyAOaWCABcg+U8yqx0r
 c8ItsiqETiu9t78l6lB9YRdhl2oB9ie97pT1ccskCsZ++7VeoiDtv6fsGadJtS59gZzqa1opPzQ
 CLEmhQ8PX7LUS+NfE+cmLoxbnMGdYxMQ2UhvSLI9/+yhMHmlN4EkSaOghXgolXxEwYb+4HFJ4nk
 yaERGne8cz+JEhVBu9RUJTGEeU2mUH50cBAOMnWli9YokQTQf8qSqzCZYRnFoT9ydYXsiWGwd/G
 9UJ3iRKFYojUKWP/dKLVAHRggEoivc9xxUa6IjQAx6E8Iw4zLiKvGjykIYYOZM5BDtpQ0vILr0u
 BHVa9MggWH+LuSKcKEgQLDntA==
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

With the Linux and U-Boot board dtb files unified, we have duplicate
properties in the root node. Remove them

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index b4aa904e9bb4d..4d543d430a4b0 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -11,9 +11,6 @@
 #include "k3-am654-ddr.dtsi"
 
 / {
-	compatible =  "ti,am654-evm", "ti,am654";
-	model = "Texas Instruments AM654 R5 Base Board";
-
 	aliases {
 		ethernet0 = &cpsw_port1;
 		remoteproc0 = &sysctrler;
-- 
2.43.0

