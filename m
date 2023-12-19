Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A76FC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 19:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AD9986D82;
	Tue, 19 Dec 2023 20:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="U9qMiA2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA2638783A; Tue, 19 Dec 2023 20:17:46 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBCD587603
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BJJHYPr060715;
 Tue, 19 Dec 2023 13:17:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703013455;
 bh=0CdT4ibMRFiz57zF5aWEebuY12VT05YheaRxIP627e4=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=U9qMiA2tYHb//fl+6qmfpC5I0TOFY8zclVSwJnDIEJzabD7FBALMlhxOad2Njdii0
 c20m8HnVzR5AH8EdhaF3HmK2f7IypDYPIibbr20EwWM95XQxxo5Lvfswe+1yZmaBxZ
 ogHWRlcKpStU/wYyjasiBOmbUXNt/ABh9jVeeQYw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BJJHY5p035618
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Dec 2023 13:17:34 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Dec 2023 13:17:34 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Dec 2023 13:17:34 -0600
Received: from TI.dhcp.ti.com (ti.dhcp.ti.com [10.24.69.34] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BJJFcAQ065909;
 Tue, 19 Dec 2023 13:17:28 -0600
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
Subject: [PATCH v7 17/17] board: ti: j784s4: Add MAINTAINERS file
Date: Wed, 20 Dec 2023 00:45:37 +0530
Message-ID: <20231219191537.4039361-18-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191537.4039361-1-a-nandan@ti.com>
References: <20231219191537.4039361-1-a-nandan@ti.com>
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

Add maintainership for new J784S4 files added.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 board/ti/j784s4/MAINTAINERS | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 board/ti/j784s4/MAINTAINERS

diff --git a/board/ti/j784s4/MAINTAINERS b/board/ti/j784s4/MAINTAINERS
new file mode 100644
index 0000000000..d3f0e50391
--- /dev/null
+++ b/board/ti/j784s4/MAINTAINERS
@@ -0,0 +1,25 @@
+J784S4 BOARD
+M:	Apurva Nandan <a-nandan@ti.com>
+S:	Maintained
+F:	board/ti/j784s4
+F:	arch/arm/mach-k3/j784s4
+F:	include/configs/j784s4_evm.h
+F:	configs/j784s4_evm_r5_defconfig
+F:	configs/j784s4_evm_a72_defconfig
+F:	arch/arm/dts/k3-j784s4.dtsi
+F:	arch/arm/dts/k3-j784s4-main.dtsi
+F:	arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi
+F:	arch/arm/dts/k3-j784s4-thermal.dtsi
+F:	arch/arm/dts/k3-j784s4-evm.dts
+F:	arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
+F:	arch/arm/dts/k3-j784s4-r5-evm.dts
+F:	arch/arm/dts/k3-j784s4-ddr.dtsi
+F:	arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi
+F:	doc/board/ti/j784s4_evm.rst
+
+AM69 BOARD
+F:	arch/arm/dts/k3-am69-sk.dts
+F:	arch/arm/dts/k3-am69-sk-u-boot.dtsi
+F:	arch/arm/dts/k3-am69-r5-sk.dts
+F:	configs/am69_sk_r5.config
+F:	configs/am69_sk_a72.config
-- 
2.34.1

