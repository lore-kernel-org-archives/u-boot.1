Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF67C87FD3
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 15:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9E2A8475B;
	Fri,  8 Aug 2025 17:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="LnGN8lqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AADFE84757; Fri,  8 Aug 2025 17:13:07 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D975884750
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 17:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=03156c240e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578FAQ55018527;
 Fri, 8 Aug 2025 17:13:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 rqcLcN19C71Ogpk2F3ugm1a/cVuztYcYbEBtEZgc8mk=; b=LnGN8lqozG60fNHD
 cmxB0/dyGOFk5MV6Wka1BxdwgY4uagOFduX+7Cua4GGzD3Rk4DxfMrem0mpQcP0y
 CFmC47YbLhk3qotFOtqgrmpzdR9Qce3Wj91SGOz04ympxd3mB0NbHnRtpKFqJXfP
 N6V3LydFyt/fMzO2C5Cl+2T/6sVezCgvJwCsDFdeUGtx5HWwj9iMK/2dnigoPsSW
 vVM3X5IKKInnqX2TaTXVlVZ7bQcubxSSi5tbrfUHXSadP0u/A9GZVBTdcFWCAyMy
 77XzYmk8n0Co/Kvr5thRAqY43V42dEk3ur/q8nOeeeFE1kE1ZxY+5hhPYibL4GoK
 w+KOVw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48c7md0wf9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 17:13:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6A0B640056;
 Fri,  8 Aug 2025 17:12:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AC21C727B1C;
 Fri,  8 Aug 2025 17:12:09 +0200 (CEST)
Received: from localhost (10.252.12.105) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 17:12:09 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/5] ARM: dts: Add flash0 partitions for stm32mp257f-ev1-u-boot
Date: Fri, 8 Aug 2025 17:11:54 +0200
Message-ID: <20250808151154.472860-6-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250808151154.472860-1-patrice.chotard@foss.st.com>
References: <20250808151154.472860-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.12.105]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
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

Add flash0 partitions for stm32mp257f-ev1-u-boot.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

 arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi | 41 ++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi b/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
index 9a566e18d3f..7bbb3e00351 100644
--- a/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
@@ -12,6 +12,47 @@
 	};
 };
 
+&flash0 {
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "fsbla1";
+			reg = <0x00000000 0x00040000>;
+		};
+		partition@40000 {
+			label = "fsbla2";
+			reg = <0x00040000 0x00040000>;
+		};
+		partition@80000 {
+			label = "metadata1";
+			reg = <0x00080000 0x00040000>;
+		};
+		partition@C0000 {
+			label = "metadata2";
+			reg = <0x000C0000 0x00040000>;
+		};
+		partition@100000 {
+			label = "fip-a";
+			reg = <0x00100000 0x00400000>;
+		};
+		partition@500000 {
+			label = "fip-b";
+			reg = <0x00500000 0x00400000>;
+		};
+		partition@900000 {
+			label = "u-boot-env";
+			reg = <0x00900000 0x00080000>;
+		};
+		partition@980000 {
+			label = "nor-user";
+			reg = <0x00980000 0x03680000>;
+		};
+	};
+};
+
 &usart2 {
 	bootph-all;
 };
-- 
2.25.1

