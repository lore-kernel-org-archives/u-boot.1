Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A890AC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 12:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE973876F7;
	Wed,  6 Dec 2023 13:39:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lX2bJuyf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9F4E876F7; Wed,  6 Dec 2023 13:39:38 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1F05878B3
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 13:39:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B6CdRZa025468;
 Wed, 6 Dec 2023 06:39:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701866367;
 bh=kUfoIdA0pTNarxa3nSlrF9ustW0myghZvqYKm7G3ngk=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=lX2bJuyfa2PvNyU/i9OK0VkrAK7CbvzIfbFi/HXZLgbpZevQ8lEdxMiTGfcKfBz5q
 CxAHjB7AcPv6s/Gkru7LOs12XGKvz5DopH3YcqwJamKtIw91UURk5wh/itLIXcLe0N
 rDsBoufLM6wP5fyUUTBUxT/SUgPLGvlOzystNhFE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B6CdRUG045902
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Dec 2023 06:39:27 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Dec 2023 06:39:26 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Dec 2023 06:39:27 -0600
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B6Cbrqo096939;
 Wed, 6 Dec 2023 06:39:20 -0600
From: Apurva Nandan <a-nandan@ti.com>
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jayesh
 Choudhary <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v6 13/17] arm: dts: Add bootph-all for memory node
Date: Wed, 6 Dec 2023 18:07:49 +0530
Message-ID: <20231206123753.1486031-14-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206123753.1486031-1-a-nandan@ti.com>
References: <20231206123753.1486031-1-a-nandan@ti.com>
MIME-Version: 1.0
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

memory node is used by fdtdec_setup_mem_size_base() and
fdtdec_setup_memory_banksize() during dram_init(), so use
bootph-all to enable for all stages.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm/dts/k3-am69-sk-u-boot.dtsi    | 6 ++++++
 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/dts/k3-am69-sk-u-boot.dtsi b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
index d1623b6bbe..6d848ba6bc 100644
--- a/arch/arm/dts/k3-am69-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
@@ -5,6 +5,12 @@
 
 #include "k3-j784s4-binman.dtsi"
 
+/ {
+	memory@80000000 {
+		bootph-all;
+	};
+};
+
 &mcu_udmap {
 	reg =   <0x0 0x285c0000 0x0 0x100>,
 		<0x0 0x284c0000 0x0 0x4000>,
diff --git a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
index 74de8a4db8..ac749782bf 100644
--- a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
@@ -5,6 +5,12 @@
 
 #include "k3-j784s4-binman.dtsi"
 
+/ {
+	memory@80000000 {
+		bootph-all;
+	};
+};
+
 &mcu_udmap {
 	reg =   <0x0 0x285c0000 0x0 0x100>,
 		<0x0 0x284c0000 0x0 0x4000>,
-- 
2.34.1

