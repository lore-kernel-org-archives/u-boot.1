Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B8FC36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 13:53:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A317820E8;
	Tue,  1 Apr 2025 15:53:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ho3MPfia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1C91820E8; Tue,  1 Apr 2025 15:53:10 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAFDD8171B
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 15:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6186c34923=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531C3DGf021916;
 Tue, 1 Apr 2025 15:53:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=Zc67h+/XXaapQI1/3NrHvB
 39YMcsZJASptLfaA2zJPQ=; b=ho3MPfia5DLFqQiQF66r0KUO8IIfGDOVHRu3Vf
 qwIXaAbjDIFJ6g62ta4EBcdZrHKeCK+bNviLnlGr4qIYf1ArlUJ/7w8m6kWq6Xpv
 4ldjKro2uIFWtzGkR3gHf8qG18brNRq9RjyaAKwiWXofNpWsmZiBCqVFFpkaz+SW
 Q/DV9GOpdDrfLAujmmpPB66h7rVZGNu2cJOFjsXhgR/OvKedY4qpLNKOJ4fwq9JU
 TyjKAq8fsPHJbdGFO5+mVpUhmI6sAFfphu/UDU9QuMXi5GOarfNfRWe3yiKmssjq
 pItxcIWOzD8XRFd4qnVOKKWxeGSL9g0FCJkdzU7Px8ediylA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45p8mmna64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 15:53:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AA91D400A6;
 Tue,  1 Apr 2025 15:51:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 652028A53F7;
 Tue,  1 Apr 2025 15:51:40 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 15:51:40 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>,
 Kamil Lulko <kamil.lulko@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/6] configs: stm32: Fix console cmdline for stm32 MCU's board
Date: Tue, 1 Apr 2025 15:51:26 +0200
Message-ID: <20250401135132.395518-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_05,2025-03-27_02,2024-11-22_01
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

This series fixes console command line for some STM32 MCU's board.

Patrice Chotard (6):
  configs: stm32f769-disco_spl: Fix console cmdline
  configs: stm32f746-disco_spl: Fix console cmdline
  configs: stm32f769-disco: Fix console cmdline
  configs: stm32f729-discovery: Fix console cmdline
  configs: stm32746-eval_spl: Fix console cmdline
  configs: stm32746-eval: Fix console cmdline

 configs/stm32746g-eval_defconfig      | 2 +-
 configs/stm32746g-eval_spl_defconfig  | 2 +-
 configs/stm32f429-discovery_defconfig | 2 +-
 configs/stm32f746-disco_defconfig     | 2 +-
 configs/stm32f746-disco_spl_defconfig | 2 +-
 configs/stm32f769-disco_spl_defconfig | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.25.1

