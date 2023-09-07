Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA30EC8743
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 17:10:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D51686ACC;
	Thu,  7 Sep 2023 19:09:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="O7WL3YlQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 260A386A3D; Thu,  7 Sep 2023 18:23:55 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8C8386A10
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 18:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=76143956a4=gatien.chevallier@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 387DjMIV016950; Thu, 7 Sep 2023 18:23:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 selector1; bh=5chGm3+SNBv0K2MVSn2uTblLakJ8YvE57OCnA+8Gutk=; b=O7
 WL3YlQLd6SGm3tT4xIYmroclkUTpmRZRxO4kBI2MSM2qkcibpAwe9SRpZ7k2EUuN
 7RT4tt52vJMGO9Nx5DnLc9yQQ+yy0QkP8SMCNlW/ooLZtbXLMXvBNXlUB1T0m+cQ
 vNEJFq7yMP2bVffwxj9+mERpYeZwVYa956kwF6zK6vBvPnGGKefQIVe8M/lMI/h/
 PqLgVIGm31oHQRyi/YZ1NVVYdSk4D4OuozY9mNJLF173xpmA3OOa8SlONjA6/MTB
 L6mGKVHcl5GB35xqAkqgL+KWaeogloZN0XfRYuWvk7wExIT4NJ5H0tWupXEwuFda
 r5ZMQ617X4DWmn5xzWAw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sutffq2bt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Sep 2023 18:23:48 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CD484100056;
 Thu,  7 Sep 2023 18:23:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BC66D21161E;
 Thu,  7 Sep 2023 18:23:47 +0200 (CEST)
Received: from localhost (10.201.20.32) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 7 Sep
 2023 18:23:47 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 7/7] ARM: dts: stm32: add RNG node for STM32MP13x platforms
Date: Thu, 7 Sep 2023 18:22:00 +0200
Message-ID: <20230907162200.205602-7-gatien.chevallier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230907162200.205602-1-gatien.chevallier@foss.st.com>
References: <20230907162200.205602-1-gatien.chevallier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.32]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_08,2023-09-05_01,2023-05-22_02
X-Mailman-Approved-At: Thu, 07 Sep 2023 19:09:23 +0200
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

Add RNG node for STM32MP13x platforms.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 arch/arm/dts/stm32mp131.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/stm32mp131.dtsi b/arch/arm/dts/stm32mp131.dtsi
index d23bbc3639..bd7285053d 100644
--- a/arch/arm/dts/stm32mp131.dtsi
+++ b/arch/arm/dts/stm32mp131.dtsi
@@ -1208,6 +1208,14 @@
 			};
 		};
 
+		rng: rng@54004000 {
+			compatible = "st,stm32mp13-rng";
+			reg = <0x54004000 0x400>;
+			clocks = <&rcc RNG1_K>;
+			resets = <&rcc RNG1_R>;
+			status = "disabled";
+		};
+
 		mdma: dma-controller@58000000 {
 			compatible = "st,stm32h7-mdma";
 			reg = <0x58000000 0x1000>;
-- 
2.25.1

