Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66447C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 06:37:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF7BF88822;
	Wed, 22 May 2024 08:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Mc/aiQjo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56DB288473; Wed, 22 May 2024 08:37:06 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B71C8845C
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 08:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44M6awb8024959;
 Wed, 22 May 2024 01:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716359818;
 bh=g9z7nfIzqhPMx2pYPGSKk6c30G4wHGgCxy6LkC/Wzfs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Mc/aiQjoIkq93f4XpdD4o8MjbgwpMatwfsI32NNEAD2mck26fX7m0xK6AfIZ74jp5
 C8rsnWxI5wwSWqmzNssL3OtMkXJfchOqzZbzKVAu2PR9j7y0XJpX86BIF6MNkHGCyQ
 FN1UJZfxClBau6Aq51TcUcaYSPOgLlI93CLFg3J0=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44M6awh4055732
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 May 2024 01:36:58 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 May 2024 01:36:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 May 2024 01:36:57 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44M6avmj108040;
 Wed, 22 May 2024 01:36:57 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44M6av6n009968;
 Wed, 22 May 2024 01:36:57 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Judith Mendez <jm@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nikhil M
 Jain <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Simon Glass <sjg@chromium.org>, Neha
 Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>
Subject: [PATCH 1/3] arm: dts: k3-am642-evm-u-boot: Add remoteproc-name for
 PRU cores
Date: Wed, 22 May 2024 12:06:50 +0530
Message-ID: <20240522063652.3759497-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522063652.3759497-1-danishanwar@ti.com>
References: <20240522063652.3759497-1-danishanwar@ti.com>
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

Add remoteproc-name property for PRU cores.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm/dts/k3-am642-evm-u-boot.dtsi | 44 +++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
index 705b3baa81..25ddace74e 100644
--- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
@@ -11,6 +11,50 @@
 	};
 };
 
+&pru0_0 {
+	remoteproc-name = "pru0_0";
+};
+
+&rtu0_0 {
+	remoteproc-name = "rtu0_0";
+};
+
+&tx_pru0_0 {
+	remoteproc-name = "tx_pru0_0";
+};
+
+&pru0_1 {
+	remoteproc-name = "pru0_1";
+};
+
+&rtu0_1 {
+	remoteproc-name = "rtu0_1";
+};
+
+&tx_pru0_1 {
+	remoteproc-name = "tx_pru0_1";
+};
+
+&pru1_0 {
+	remoteproc-name = "pru1_0";
+};
+
+&rtu1_0 {
+	remoteproc-name = "rtu1_0";
+};
+
+&tx_pru1_0 {
+	remoteproc-name = "tx_pru1_0";
+};
+
+&pru1_1 {
+	remoteproc-name = "pru1_1";
+};
+
+&rtu1_1 {
+	remoteproc-name = "rtu1_1";
+};
+
 &main_timer0 {
 	clock-frequency = <200000000>;
 };
-- 
2.34.1

