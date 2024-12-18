Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1AEE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 13:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2949080283;
	Wed, 18 Dec 2024 14:14:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iMvPepti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4C6D8022B; Wed, 18 Dec 2024 14:14:10 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D45BB80312
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 14:14:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BIDE5As157865
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 18 Dec 2024 07:14:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734527645;
 bh=aHAVHB5l0jUknRbDeVdg05SGxhNA5POjuFIdVMHSW+M=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=iMvPeptiEtDdZFksByvhCar4pThDKSmPT/Oz+yzlajBeiaRMzJUSEoqcxoSCmpVMl
 bU3QC0g2+8mbqo0uhwDazpv3kH+zcq5WsSG9flMsIa9sJc6ER5TtsQNgTWg36n2Doi
 PA5G+lpx1FFbz+9UEXdFNaOwuy5dS8uabruGzW7g=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BIDE5rV059647;
 Wed, 18 Dec 2024 07:14:05 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Dec 2024 07:14:04 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Dec 2024 07:14:04 -0600
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [172.24.227.142])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BIDDjRc035276;
 Wed, 18 Dec 2024 07:14:02 -0600
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <vaishnav.a@ti.com>, <s-k6@ti.com>
Subject: [PATCH v2 4/4] arm: dts: k3-j722s*: Add overrides specific to OSPI
Date: Wed, 18 Dec 2024 18:43:41 +0530
Message-ID: <20241218131341.2073823-5-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218131341.2073823-1-p-mantena@ti.com>
References: <20241218131341.2073823-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

From: Vaishnav Achath <vaishnav.a@ti.com>

OSPI Boot requires overrides specific to R5 and also
to use DMA in R5 SPL stage the DM_TIFS needs to be used.
Add the corresponding overrides for R5 SPL stage.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/dts/k3-j722s-evm-u-boot.dtsi |  4 ++++
 arch/arm/dts/k3-j722s-r5-evm.dts      | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/dts/k3-j722s-evm-u-boot.dtsi b/arch/arm/dts/k3-j722s-evm-u-boot.dtsi
index 88c4a72db61..6ae76beea3e 100644
--- a/arch/arm/dts/k3-j722s-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-j722s-evm-u-boot.dtsi
@@ -16,3 +16,7 @@
 &dmsc {
 	bootph-pre-ram;
 };
+
+&main_bcdma {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/dts/k3-j722s-r5-evm.dts b/arch/arm/dts/k3-j722s-r5-evm.dts
index 1bec997c93c..d797e954f97 100644
--- a/arch/arm/dts/k3-j722s-r5-evm.dts
+++ b/arch/arm/dts/k3-j722s-r5-evm.dts
@@ -81,3 +81,16 @@
 &wkup_uart0 {
 	status = "okay";
 };
+
+&ospi0 {
+	reg = <0x00 0x0fc40000 0x00 0x100>,
+	      <0x00 0x60000000 0x00 0x08000000>;
+};
+
+&main_bcdma {
+	ti,sci = <&dm_tifs>;
+};
+
+&main_pktdma {
+	ti,sci = <&dm_tifs>;
+};
-- 
2.34.1

