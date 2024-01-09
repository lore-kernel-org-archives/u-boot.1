Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9663C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 14:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFAB6878CF;
	Tue,  9 Jan 2024 15:00:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="KyojuvK8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAE1287867; Tue,  9 Jan 2024 15:00:27 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C5A7878E1
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 15:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1738c7e6a4=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4099FJP2014975; Tue, 9 Jan 2024 15:00:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=selector1; bh=ze7yZBG
 3+0mLL3viz6bj3xaP1nlBrlm56zMeKLIjgdc=; b=KyojuvK84hocKKWkK6e+P/l
 hur4+nNyy2JUNd0iRICNPexlb8mCDxShfGS6vA7CUFvCiOWsn1FSUWOUKgXD6ZvJ
 5Wz8JWbsX1E4Y/Sutqdjrn1Oxrr9DihHLMQf0k4bgYxszivEYL6c3e2mo6OxIo8y
 28ajOaxl9qNXIsaU8GMM8bfAcgzPT0nqH/cxTl7FpMDzf8VKbV+kNPo7UzwbgXu2
 lKqJO3/WjrtRKEqATjpfbt1Wkq1fKNSU2rrZpSYB37jQrWFsYr5VCOhRWZTGJKpK
 IU9A/zToKE/waDZWJp5Fh5IWZY0IUAetAmexRQS4yy4WaPuiomqBJBxFIkS2xng=
 =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vey30m39n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 15:00:22 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6925710002A;
 Tue,  9 Jan 2024 15:00:22 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 569D6210F7E;
 Tue,  9 Jan 2024 15:00:22 +0100 (CET)
Received: from localhost (10.201.20.205) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 9 Jan
 2024 15:00:22 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Igor Opaniuk
 <igor.opaniuk@foundries.io>, Marek Vasut <marex@denx.de>, Oleksandr Suvorov
 <oleksandr.suvorov@foundries.io>
Subject: [PATCH] stm32mp2: Fix CONFIG_STM32MP25X flag usage
Date: Tue, 9 Jan 2024 15:00:17 +0100
Message-ID: <20240109140018.2015396-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.205]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
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

"#if" was used instead of "#ifdef"

Fixes: 01a701994b05 ("stm32mp2: initial support")
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 arch/arm/mach-stm32mp/include/mach/stm32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
index 46d469881b3..175f2a88490 100644
--- a/arch/arm/mach-stm32mp/include/mach/stm32.h
+++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
@@ -157,7 +157,7 @@ enum forced_boot_mode {
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_STM32MP15X || CONFIG_STM32MP13X */
 
-#if CONFIG_STM32MP25X
+#ifdef CONFIG_STM32MP25X
 #define STM32_RCC_BASE			0x44200000
 #define STM32_TAMP_BASE			0x46010000
 
-- 
2.25.1

