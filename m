Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82562C369D3
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 13:14:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C2EE80FA8;
	Tue, 22 Apr 2025 15:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="vCm+ZsJA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6787781F0D; Tue, 22 Apr 2025 15:14:05 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D19D805D7
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 15:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6207ada5ad=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MACb2a003021;
 Tue, 22 Apr 2025 15:13:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 Uo9WI4HGAHEpsAfPjiBQIoMbTT6sfJODQZW9x6Ap9ps=; b=vCm+ZsJALVE6Gq9f
 c9EN1jgXwvW7G1U5RkngAj43mUOWFom30LNHBhpxRJPBGQcuDV78ysh+BI8BZ49Y
 YE51GJTo8zPiD7yRcBY4cF3haAnGR9wa00Vjt6QIMHGTeDDv0A6OId2Kv5PghGCj
 8fNULD2dTPXctZ607MXUaFosvFPiup1xpWJHN48PNKVc6ELqmQ5WWR43H/edVyeR
 Hsz3m1wfNJouBkoVEYqwOcGzHvFYtio7yMe8lqdm7OEG8wauvPZ/5m+QS7dAGK28
 8vo38TNulpAsz7O7NQoI8RJXcI/8WiCRuGz77RpyCKD3cnf4oZdDKnbwFGeTDPBe
 4jImRA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4642qga82c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 15:13:55 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7DCDE4004F;
 Tue, 22 Apr 2025 15:13:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 288E66F4702;
 Tue, 22 Apr 2025 15:12:43 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 15:12:42 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v2 10/13] ARM: dts: stm32: add ETZPC as a system bus for
 STM32MP1x boards
Date: Tue, 22 Apr 2025 15:12:26 +0200
Message-ID: <20250422131229.415020-11-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250422131229.415020-1-patrice.chotard@foss.st.com>
References: <20250422131229.415020-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_06,2025-04-21_02,2024-11-22_01
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

From: Lionel Debieve <lionel.debieve@foss.st.com>

The STM32 System Bus is an internal bus on which devices are connected.
ETZPC is a peripheral overseeing the firewall bus that configures
and control access to the peripherals connected on it.

For more information on which peripheral is securable, please read
the STM32MP13 or STM32MP15 reference manual.

Signed-off-by: Lionel Debieve <lionel.debieve@foss.st.com>
Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

(no changes since v1)

 arch/arm/dts/stm32mp13-u-boot.dtsi | 4 ++++
 arch/arm/dts/stm32mp15-u-boot.dtsi | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/dts/stm32mp13-u-boot.dtsi b/arch/arm/dts/stm32mp13-u-boot.dtsi
index af7edc7e2b2..1fe6966781c 100644
--- a/arch/arm/dts/stm32mp13-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp13-u-boot.dtsi
@@ -48,6 +48,10 @@
 	bootph-all;
 };
 
+&etzpc {
+	bootph-all;
+};
+
 &gpioa {
 	bootph-all;
 };
diff --git a/arch/arm/dts/stm32mp15-u-boot.dtsi b/arch/arm/dts/stm32mp15-u-boot.dtsi
index 3f57bd5fe0f..327d7760436 100644
--- a/arch/arm/dts/stm32mp15-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp15-u-boot.dtsi
@@ -106,6 +106,10 @@
 	operating-points-v2 = <&cpu0_opp_table>;
 };
 
+&etzpc {
+	bootph-all;
+};
+
 &gpioa {
 	bootph-all;
 };
-- 
2.25.1

