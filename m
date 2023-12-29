Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F2EC47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4136C87B8F;
	Fri, 29 Dec 2023 18:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="suLboKvh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BA1B87BD5; Fri, 29 Dec 2023 18:47:14 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7C4187B93
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1A2088971;
 Fri, 29 Dec 2023 11:47:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872021;
 bh=79DJOtRXRrJQVHFOpY4ITghTvg+COwtK1P4GtO4ItAQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=suLboKvhwQvVzJu7Y+/KAKaMbf+1n4VdWT5Goe6Ttv30RtJipJ+shbKjCU2LQ3gif
 E8lAH2T0Qu1yYDZLTtKY0onhx41VgLECc4jAkWInpuWjv45Kz/Z8Tkkk0tb6akksBb
 TU69jvtQOxfQlD+YX6OF/sOSg/s1LmM0dugiQuHA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl1A9115356
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:01 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl1Rn005104;
 Fri, 29 Dec 2023 11:47:01 -0600
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
Subject: [PATCH v2 22/26] arm: dts: k3-am654: remove duplicate root properties
Date: Fri, 29 Dec 2023 11:47:19 -0600
Message-ID: <20231229174656.634065-50-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=766; i=bb@ti.com;
 h=from:subject; bh=+FF4nmfbDq5GWPtlDuiZE4WI3BDGHsBGktWkkSE8EdM=;
 b=owNCWmg5MUFZJlNZqG8v6AAAXv///r7v3q/2PdLe7nNe39j6Wu1m/+d9/Xez9z7//fZT5X6wA
 RsYGKA9QAAAAAA0epoBkPU9QAA9QaNBoGjIAbU0AAAADQZBkxPRMTT1Ho01DKGg0GQABo0GjQB6
 gGgAGgPUekNGIMgaGjJkGg0DymmhoemkNB6nqBo0D1NADQZTRoaaANA0GhoMgaNAYTI0GjQZAAY
 EyNMAIGmEDQNAaYCaGQDQAyAwGD44y5NBesJltouSgyMpSjNDOAowg6sl+SPTREmAMpnLzDqHoH
 wCUPaJv4+UNz9K+gUVMwERlUwutE76alAEQN1mz0NntLxOwY3KEGsaImgNV5EyT+ak07BgUcM30
 2Gu1xogDgNNZC8Um26HwObBVGR19ya0+NyONgqJ21waSvBZwktGq78U+IuwM0eaq34e7GXoUrMp
 kSIy3Zf0+YdikMpNsXhmURK3VHAumOO17yIbzThWcXT+R7GTRENy+gjbiQpBU6hEYT4pK4avQ0q
 nrL3zrvQC9igsFgpjWB8pYb/MAJEzVDfBDw19edabFV/I8wKqKDEaLu+iAVkps0NeAgIYvwzk/8
 AgjXQSmn0HmQABs0a6jBEYssoKmZGHLhaGeKOJ4mZalg/qww+VUNCUusEQWSjqZ0cdsDLvhm2YI
 aX6v+LuSKcKEhUN5f0A
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

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index fb238adaea5b2..c039300c3cbb3 100644
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

