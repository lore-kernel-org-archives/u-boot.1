Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1888D0D7BC
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 15:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61F9689085;
	Fri, 11 Oct 2024 17:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="qELgqY5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D4F488B64; Fri, 11 Oct 2024 17:37:18 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64DA7889EF
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 17:37:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0014bb5f26=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BCt8Qb031159;
 Fri, 11 Oct 2024 17:37:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=QOWW2njjRQrA0UyVMHaJ9X
 UMQVfBxS+nd4Dl+S5nKlM=; b=qELgqY5X3jdmr7pv8lXHLM29gHzmUU63dfAOLK
 TT7QMiTRHf0Kb+/0ki+NaFDZSPYrDyFxKF0LsfcnOdat+Pn0qm8Qltx+yv2QJgzQ
 reZb1fGFIN+fNrJm+RIykFoLYNX/2lW3I3W/PWDPQR+7M1Z2b02+oZI8W9GLZ6KZ
 UWJK90FWgj2bwXaNO2diYhOTP3fKptvsV8MbGBmMc2vdt763kj2Dt0D+9Sgqbm8Y
 ZD2+/lFk20IA8JMX8gL0qClb1pkEuztHekvrw5FmBr+aHivKgRs9y/y2jHwGKP28
 m+5toQVD4PAC0if3Mi65+ljI6vRoV9aJ7mn8bLZF/BaOKSNg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 425q5wd23x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Oct 2024 17:37:13 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id BFF3A4004D;
 Fri, 11 Oct 2024 17:35:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 144A2289F15;
 Fri, 11 Oct 2024 17:32:16 +0200 (CEST)
Received: from localhost (10.48.86.243) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 11 Oct
 2024 17:32:15 +0200
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Etienne CARRIERE <etienne.carriere@foss.st.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Dillon Min <dillon.minfei@gmail.com>, Igor Opaniuk
 <igor.opaniuk@foundries.io>,
 Kamil Lulko <kamil.lulko@gmail.com>, Marek Vasut <marex@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Vikas Manocha
 <vikas.manocha@st.com>
Subject: [PATCH 0/4] stm32mp: fix boot issue with OP-TEE
Date: Fri, 11 Oct 2024 17:31:47 +0200
Message-ID: <20241011153152.1637303-1-patrick.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.86.243]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
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


The series fix several issues for STM32MP15 boot with OP-TEE
(data abort and ETZPC firewall exception) and regressions for
STM32MP25 support.



Patrick Delaunay (4):
  stm32mp: compute ram_top based on the optee base address only for
    STM32MP1
  ARM: stm32mp: enable data cache after LMB configuration for STM32MP1
  doc: clarify scmi device tree for stm32mp15 boards
  stm32mp: fix name of optee reserved memory node

 arch/arm/mach-stm32mp/Kconfig        |  2 ++
 arch/arm/mach-stm32mp/dram_init.c    | 19 ++++++++++++++-----
 arch/arm/mach-stm32mp/stm32mp1/cpu.c |  7 +++++++
 doc/board/st/stm32mp1.rst            | 25 ++++++++++++++++++++++---
 4 files changed, 45 insertions(+), 8 deletions(-)

-- 
2.25.1

