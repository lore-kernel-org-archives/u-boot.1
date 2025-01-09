Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076B1E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 10:19:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 172A8801F5;
	Thu,  9 Jan 2025 11:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Ojk0pA8c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CE9B8036B; Thu,  9 Jan 2025 11:19:40 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AEBB800D0
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 11:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3104a8932e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50984dbm027559;
 Thu, 9 Jan 2025 11:19:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 QIl8N2ZJtzF8keeF+5dxro/MsMsZi2DwztcQmrol9C4=; b=Ojk0pA8chjs7/fcU
 z/SgsRFigA3K9lR7rsdhttu7Cs+C1WVElLGWlG80Lmf/WsVHxPUSCcZ8//OQUBqe
 DbWs/tvwj7vVcfiDKd/iOTcnXKlVn6Ecf+9ivd12vnRLzcssBusnJhGsluXenxBA
 ixcbZztZH3zzu2fHSlwZNms+GmRBC6IEuyNsCR7dYcrinn9ZP2MrD+5O4H0HeAZY
 097YMlgk7TseA9Rn5ZPeba5s13RMg0waw9pP/wLAUnnkK4tPILNFmE3L5vbyaR06
 DuGmlyBuMjnfmCyeslHMRLNslPij1tB06TB+QAwOAKnEHymKvJ7Zit1TE+C5Z98U
 hvDvhA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 441txbv3nf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jan 2025 11:19:36 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1CD1140047;
 Thu,  9 Jan 2025 11:18:56 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AA267229BDB;
 Thu,  9 Jan 2025 11:18:42 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 9 Jan
 2025 11:18:42 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] ARM: dts: stm32: Update ck_flexgen_08 frequency.
Date: Thu, 9 Jan 2025 11:18:38 +0100
Message-ID: <20250109101838.1733468-3-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250109101838.1733468-1-patrice.chotard@foss.st.com>
References: <20250109101838.1733468-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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

Spurious characters are displayed on U-Boot console.
Usart2 clock is ck_flexgen_08 and its frequency is set
to an incorrect value.

Update ck_flexgen_08 frequency from 100MHz to 64MHz.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

 arch/arm/dts/stm32mp251.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/stm32mp251.dtsi b/arch/arm/dts/stm32mp251.dtsi
index 44eb664fb51..e2d1c88a57f 100644
--- a/arch/arm/dts/stm32mp251.dtsi
+++ b/arch/arm/dts/stm32mp251.dtsi
@@ -38,7 +38,7 @@
 		ck_flexgen_08: ck-flexgen-08 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
-			clock-frequency = <100000000>;
+			clock-frequency = <64000000>;
 		};
 
 		ck_flexgen_51: ck-flexgen-51 {
-- 
2.25.1

