Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0D5E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 08:12:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9847A801FD;
	Wed, 11 Dec 2024 09:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="MrVgEoaL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EECC7801FE; Wed, 11 Dec 2024 09:12:44 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E09DD801F0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 09:12:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=207521b3fe=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB4BP11004232;
 Wed, 11 Dec 2024 09:12:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=MfYKBRuvVGu/GQvL1B0kH4
 9tXuikITyeoRGsG5D+1s0=; b=MrVgEoaL8qKnt6e8H1Niu9LCnceFuewwU0R/J5
 ogJmSKGnRHiRsN2HFkXcYwBf3M/5H9/YPtEsDzWK9hE/blZPjTriCQjReGQWzP9Q
 KWEBVyvkNwAUS9DCO82TrnHns8sO3l0H3ZQCd/j/lc84cvkQ54PzaWFvNOfEL1Am
 KeyKEsVTKuBGSzbi4tdvPmVR0fntKBf/j0L8TLPXpugQn2ZA/J0QW3Scy3bvAoQi
 jXg3g1/rmU7a/QG+DqpUwtt9tnYxMZf4JBn2fcsKFcmmK+KkP6qA8fKp8BMBhATe
 Pq4NkMFuz1RKgAZR7az1Rh5y9ULAPOfoXwgDRDamZEHhqeEg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43cek212b7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2024 09:12:41 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 590CB400D9;
 Wed, 11 Dec 2024 09:10:57 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BCDE627B6FF;
 Wed, 11 Dec 2024 09:09:41 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 11 Dec
 2024 09:09:41 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>,
 Tom Rini <trini@konsulko.com>, Vikas Manocha <vikas.manocha@st.com>
Subject: [PATCH 1/2] configs: stm32f769-disco: Set CYCLIC_MAX_CPU_TIME_US to
 8000 for stm32f769-disco
Date: Wed, 11 Dec 2024 09:09:35 +0100
Message-ID: <20241211080936.1133105-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
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

Updating the framebuffer takes quite a long time on this slow patform,
set CYCLIC_MAX_CPU_TIME_US to 8000 for stm32f769-disco to avoid
following cyclic warning:

"cyclic function video_init took too long: 7280us vs 5000us max"

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 configs/stm32f769-disco_defconfig     | 1 +
 configs/stm32f769-disco_spl_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/stm32f769-disco_defconfig b/configs/stm32f769-disco_defconfig
index 1e09c224fc0..5be221afd2f 100644
--- a/configs/stm32f769-disco_defconfig
+++ b/configs/stm32f769-disco_defconfig
@@ -21,6 +21,7 @@ CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 earlyprintk consoleblank=0 ignore_loglevel"
 CONFIG_SYS_PBSIZE=1050
 # CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_CYCLIC_MAX_CPU_TIME_US=8000
 CONFIG_SYS_PROMPT="U-Boot > "
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
diff --git a/configs/stm32f769-disco_spl_defconfig b/configs/stm32f769-disco_spl_defconfig
index 787571dba0c..7d4bda44068 100644
--- a/configs/stm32f769-disco_spl_defconfig
+++ b/configs/stm32f769-disco_spl_defconfig
@@ -30,6 +30,7 @@ CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 earlyprintk consoleblank=0 ignore_loglevel"
 CONFIG_SYS_PBSIZE=1050
 # CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_CYCLIC_MAX_CPU_TIME_US=8000
 CONFIG_SPL_PAD_TO=0x9000
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_SPL_BOARD_INIT=y
-- 
2.25.1

