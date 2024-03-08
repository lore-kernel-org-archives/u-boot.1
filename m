Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593DFC54E4A
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 13:50:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D125688076;
	Fri,  8 Mar 2024 14:50:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="mnjdc5+m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDE7188076; Fri,  8 Mar 2024 14:50:36 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14B6B8800D
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 14:50:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3797bb48b6=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 428ANYj6013915; Fri, 8 Mar 2024 14:50:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 selector1; bh=LXlrR5O4BRIR+zeX+/jQjmtPRRnh9U9LQ/vHKn2jk/Q=; b=mn
 jdc5+mdC1e+v4gFzzOPSz8a3JhVg9SyjWSpxPjh1LAyFVfxTLDWmAm3GMydhodF7
 wvpjDDFPV608pwY3Nt2MsQtsk3RRbadt4BZuomrcL/z7KEFO5kjquZb/nedBiadI
 +iJ3jFghqt7bvidw1F1Ls71mQTBHsNLmpf3zxcR2RWIpFWmyrqVExw6kHp0OPOsg
 nHnXIBXNFJlthXhjl3i3JSVH+5f4FvH9hrI9iuytSu7A/vtDeye4poKhocOh9NeD
 B0nvIf6gHsoGeyYlLDCNy2v+jTSpbVQnid/Xd3YWXGZu10gye9iDDFYJclrfArg1
 egzhO+6K5aeEepvlqMlQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wmej5k75r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 14:50:33 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9997F4002D;
 Fri,  8 Mar 2024 14:50:30 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 29956278F48;
 Fri,  8 Mar 2024 14:50:14 +0100 (CET)
Received: from localhost (10.252.7.115) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Mar
 2024 14:50:13 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] ARM: dts: stm32: Fix partition node name for
 stm32mp15xx-dhcor-u-boot
Date: Fri, 8 Mar 2024 14:50:08 +0100
Message-ID: <20240308135009.2621719-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240308135009.2621719-1-patrice.chotard@foss.st.com>
References: <20240308135009.2621719-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.7.115]
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
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

Fix flash@0 partition node name with correct offset.

Fixes: 90f992e6a58c ("arm: dts: stm32: Add partitions in flash0 and nand node for
stm32mp15xx-dhcom/dhcor")

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi b/arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi
index 552b35db3c7..ba84db679e1 100644
--- a/arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp15xx-dhcor-u-boot.dtsi
@@ -42,15 +42,15 @@
 			label = "fsbl2";
 			reg = <0x00040000 0x00040000>;
 		};
-		partition@500000 {
+		partition@80000 {
 			label = "uboot";
 			reg = <0x00080000 0x00160000>;
 		};
-		partition@900000 {
+		partition@1e0000 {
 			label = "env1";
 			reg = <0x001E0000 0x00010000>;
 		};
-		partition@980000 {
+		partition@1f0000 {
 			label = "env2";
 			reg = <0x001F0000 0x00010000>;
 		};
-- 
2.25.1

