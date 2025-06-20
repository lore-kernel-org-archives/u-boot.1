Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5674C7115B
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 17:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DB9682E34;
	Fri, 20 Jun 2025 19:54:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="PFr59Bc2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED16A82D4E; Fri, 20 Jun 2025 17:55:13 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1618880E9A
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 17:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=82669a5191=cheick.traore@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KEIxbq032109;
 Fri, 20 Jun 2025 17:55:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=31SYFPA17URB6ekTWuOsxm
 49ROPCf+fIMa15yXPx+xE=; b=PFr59Bc2vbpe8uspOzXrWdOhD485zvJAM6khFi
 +zHVtSMoU3a7Au+2ALszdDk+RlxexYOfZDLCLdtXVnJUdfcBMiBS54VLXNk6ioni
 WvCGoKKv46Hd20YCGRjq9JbYFPlAM2xagAyD1AGH3+UWbumfkg16pRPrpk1mkSIU
 kltefN7uBHys6FyzAJ4PnjRdvQjay0xrwKSEHiVm9uIGhA/VX2m9PEQj8WTBh0V0
 uy8W0KPgkHPu8TsW6+UyjNm96cM3hjtZbji1jag4plhX/LOv4EDrmzzowH46EdGP
 plhlCRihgooT5Fw/XqFySlgppD53rueENp5VXqbmoryF/SMw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 478x7af659-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Jun 2025 17:55:07 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 84B844007B;
 Fri, 20 Jun 2025 17:54:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7E65FB29719;
 Fri, 20 Jun 2025 17:51:14 +0200 (CEST)
Received: from localhost (10.48.86.135) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Jun
 2025 17:51:14 +0200
From: Cheick Traore <cheick.traore@foss.st.com>
To: <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Cheick Traore
 <cheick.traore@foss.st.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/3] Add support for STM32 TIMERS and STM32 PWM on STM32MP25
Date: Fri, 20 Jun 2025 17:49:57 +0200
Message-ID: <20250620155000.1258718-1-cheick.traore@foss.st.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.86.135]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_06,2025-06-20_01,2025-03-28_01
X-Mailman-Approved-At: Fri, 20 Jun 2025 19:54:50 +0200
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


This serie adds:
* drivers support on stm32mp25 for MFD STM32 TIMERS and STM32 PWM
* enable these drivers on stm32mp25


Cheick Traore (3):
  arm: stm32mp2: add multifunction timer support for stm32mp25
  pwm: stm32: add support for stm32mp25
  configs: stm32mp25: Enable MFD timer and PWM for stm32mp25_defconfig

 arch/arm/mach-stm32mp/include/mach/timers.h |  9 ++++++
 arch/arm/mach-stm32mp/timers.c              | 34 ++++++++++++++++++++-
 configs/stm32mp25_defconfig                 |  4 +++
 drivers/pwm/pwm-stm32.c                     | 11 ++++++-
 4 files changed, 56 insertions(+), 2 deletions(-)

-- 
2.34.1

base-commit: 0c6c8065a27804705c324f06998fea219e62f028
branch: upstream
