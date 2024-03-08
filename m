Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F882C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 13:51:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F138D88065;
	Fri,  8 Mar 2024 14:50:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="719uPiDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A328807B; Fri,  8 Mar 2024 14:50:51 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BAEC87EEC
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 14:50:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3797bb48b6=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 428COvl8021331; Fri, 8 Mar 2024 14:50:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 selector1; bh=Mb+eosC7d7LEkIbFvfVjKoyzyFsqZIYi9cVKTykCIc4=; b=71
 9uPiDMJQJqY8jZ9Kl2jITrIfJbuhepHjw2xwG5QcKmrMu4KPE9oywt7NGJSYF3TZ
 JU5saMVOKTYfSA+Ikwpg8tePP2qj6agT8tjq0fKW7MOYHCIN95Pg22tbX6EqeGLf
 gCF6p574hK1zejh1Ls8uqFau0nxS2ZqufrnNIIUhaFY4glXt5nXl1UCPbLlZWoCz
 NMoJWN1HWH2dySVd61Efu2ZMQ0NSSw4+yFnHN7ICqS6C+iOKPvHV2QvwRMuKMoEW
 mTdGdg1dw3HufuUWy256KEu5miLmfINMjbYi3pXU06Dvv9GdO0X4fuTTylx01Rve
 rLz/G28MQJwLJY4CYEHA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wqdxmne0g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 14:50:38 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6AC5A4002D;
 Fri,  8 Mar 2024 14:50:35 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C1499278F49;
 Fri,  8 Mar 2024 14:50:14 +0100 (CET)
Received: from localhost (10.252.7.115) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Mar
 2024 14:50:14 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 <u-boot@dh-electronics.com>
Subject: [PATCH 3/3] ARM: dts: stm32: Fix partition node name for
 stm32mp15xx-dhcom-u-boot
Date: Fri, 8 Mar 2024 14:50:09 +0100
Message-ID: <20240308135009.2621719-3-patrice.chotard@foss.st.com>
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

Fixes: 90f992e6a58c ("arm: dts: stm32: Add partitions in flash0 and nand
node for stm32mp15xx-dhcom/dhcor")

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi b/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi
index 2f70b0690d2..1b445619325 100644
--- a/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi
@@ -106,15 +106,15 @@
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

