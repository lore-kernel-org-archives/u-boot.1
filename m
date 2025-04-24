Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD40C369D5
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:09:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC45982075;
	Thu, 24 Apr 2025 08:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="xBTG/7Dq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABADC8082A; Thu, 24 Apr 2025 08:08:47 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED2ED809D4
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:08:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6209a59483=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O5Fi5E002503;
 Thu, 24 Apr 2025 08:08:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 Ph6hPePwP62v8SVxGlpt+eYbrIjPycaAmerzhQo1ACo=; b=xBTG/7Dq9GngWoMF
 QlzM1FZqwEoPh0/yRXMbQE0bGgVtObnvGUHLkt4/18kdHxx0A9e1urIzYWZeuQTe
 7mMAn8Yw1i0X2OQXg0IpfZ3R0NW/GVXWWQINmKVnQ/Anbkx70ojRfYpcig+FINpL
 r+JRW9ehG4h2o+2khNE7ihgJ8P8txN9ibJpSdkUzUVkL/wYG65bMnHn+rtR0d6NF
 uJkNm8P8xHznxn9UcUF71ss96HH1PE7OQzyZa35tYQPtDe9kMfKbGxiuZU4aePHd
 vhFR89mIIDi3S/cppDd5PEjSD1bZawzktct7JDoWT0CzF0M0pHvf+r3giCI1Jzz6
 hzaNrQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 466jk2e2w0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 08:08:40 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AAC5F40054;
 Thu, 24 Apr 2025 08:08:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 07C53A4C093;
 Thu, 24 Apr 2025 08:07:51 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 08:07:50 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/21] ARM: dts: stm32: add sdmmc1 fixed clock for
 stm32mp257f-ev1-u-boot
Date: Thu, 24 Apr 2025 08:07:15 +0200
Message-ID: <20250424060723.2695014-14-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250424060723.2695014-1-patrice.chotard@foss.st.com>
References: <20250424060723.2695014-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_02,2025-04-22_01,2025-02-21_01
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

Add sdmmc1 temporary fixed clock for stm32mp257f-ev1-u-boot

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi b/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
index a9bd5e042fa..d778b8d8d05 100644
--- a/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi
@@ -18,6 +18,12 @@
 			clock-frequency = <64000000>;
 		};
 
+		ck_flexgen_51: ck-flexgen-51 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <200000000>;
+		};
+
 		ck_icn_ls_mcu: ck-icn-ls-mcu {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
@@ -74,6 +80,11 @@
 	clocks = <&ck_icn_ls_mcu>;
 };
 
+&sdmmc1 {
+	clocks = <&ck_flexgen_51>;
+	/delete-property/resets;
+};
+
 &usart2 {
 	bootph-all;
 	clocks = <&ck_flexgen_08>;
-- 
2.25.1

