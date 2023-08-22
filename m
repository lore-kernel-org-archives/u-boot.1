Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AA6EE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 08:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A134E86403;
	Tue, 22 Aug 2023 10:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="AwrZmKHo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AC5A86405; Tue, 22 Aug 2023 10:57:01 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 529A786402
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 10:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6598ad4e9d=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37M7v9LE002583; Tue, 22 Aug 2023 10:56:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=selector1; bh=8IcwPz/
 CLdqRkLdRNUkAkU4cpP/77kloTrdGq4FEvVI=; b=AwrZmKHofrEQdRUYvZjajRM
 6fTmWB0p6OJHuK05v5vpA8v+8wcM9tum05gR4jUgL2lsotiux6x2iy5eeA/eO7lG
 /0YgLRO9J3d8IuCSh3g04GMxAkYDMsdlUOEvWqDImYK8xjLyYWfLdaUN/qedTPX5
 01y7CAHqANf2oX0aLCxxUq2BAIownZR6ykKatfisLpEeiNTqlX3V2dXP33SrvNgl
 To54zsmj4M2+pCfEZKYekwdlkVoMQ13vPocqh7H+RYxoTdCvSeunx59ma//k97u/
 CCMR8vZz8zJ1bKnfWywqHEB74qjrIX8Z97jvmSsQhyeCUGEm2NmEIpZ8T9JpTsw=
 =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3smbmktjsd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Aug 2023 10:56:56 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A710E100057;
 Tue, 22 Aug 2023 10:56:55 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 972CE231536;
 Tue, 22 Aug 2023 10:56:55 +0200 (CEST)
Received: from localhost (10.201.20.38) by EQNDAG1NODE4.st.com (10.75.129.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 22 Aug
 2023 10:56:55 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Etienne Carriere
 <etienne.carriere@foss.st.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: dts: stm32: disable SYSRAM SCMI shared memory in
 stm32mp15-scmi
Date: Tue, 22 Aug 2023 10:56:52 +0200
Message-ID: <20230822085653.237076-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_08,2023-08-18_01,2023-05-22_02
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

Changes scmi node to not use a statically defined sram shared memory
buffer. This change makes SCMI OP-TEE transport to use shared memory
allocated used OP-TEE generic shared memory resources.

Removes the sram definition in the DTSI files since no more used.

Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 arch/arm/dts/stm32mp15-scmi.dtsi | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm/dts/stm32mp15-scmi.dtsi b/arch/arm/dts/stm32mp15-scmi.dtsi
index 543f24c2f4f..ad2584213d9 100644
--- a/arch/arm/dts/stm32mp15-scmi.dtsi
+++ b/arch/arm/dts/stm32mp15-scmi.dtsi
@@ -16,7 +16,6 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			linaro,optee-channel-id = <0>;
-			shmem = <&scmi_shm>;
 
 			scmi_clk: protocol@14 {
 				reg = <0x14>;
@@ -60,21 +59,6 @@
 			};
 		};
 	};
-
-	soc {
-		scmi_sram: sram@2ffff000 {
-			compatible = "mmio-sram";
-			reg = <0x2ffff000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0x2ffff000 0x1000>;
-
-			scmi_shm: scmi-sram@0 {
-				compatible = "arm,scmi-shmem";
-				reg = <0 0x80>;
-			};
-		};
-	};
 };
 
 &reg11 {
-- 
2.25.1

