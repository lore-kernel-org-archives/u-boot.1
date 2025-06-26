Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC266C7115B
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 08:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54B6082AA4;
	Thu, 26 Jun 2025 10:18:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="3pl5xMop";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1793082C4C; Thu, 26 Jun 2025 10:18:25 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D28C8006D
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 10:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=8272a98f38=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q7hxWR025231;
 Thu, 26 Jun 2025 10:18:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=7NAlMoKCm2gHemic1XZt31
 9da8NkVaNqENxQRk0FXe8=; b=3pl5xMoptB/D549iGg8XksZkdTpoG2itiSC5ND
 YNEBG6tNKmWmMiRb8O/SW0mGPUE74NGXuCX49oc3h/XEzCrE/+lQPUtAuioqOHzI
 tym+oMyBUE7ZhTVbC78yMOOfhbzRcS5UtTChnIZoVbX75125adtpVi5aSkwNKkXg
 EMcR8TC9EAVmCPokmbgk3SZLg94a90LiXrWikK5ZP7dNjTm3Kg4zUcDb0Au3q92G
 vBB1bHp+tf9ckNA3CgHMBKT4vYV2CLtItyaoewjH/e93fPTgo6MFU9+E+pSKh8Kj
 K85mP18Mga9G1dnZhQbiCU6doTOVq2ihMonQZ3UpgQfzjlYg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47dkmjw40c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Jun 2025 10:18:19 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8824B40053;
 Thu, 26 Jun 2025 10:17:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 231FEB1C00D;
 Thu, 26 Jun 2025 10:17:24 +0200 (CEST)
Received: from localhost (10.252.13.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 10:17:23 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: stm32mp: replace space by tab in sys_proto.h
Date: Thu, 26 Jun 2025 10:17:21 +0200
Message-ID: <20250626081721.49349-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.13.141]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_04,2025-06-25_01,2025-03-28_01
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

Cosmetic update to replace space by tab in sys_proto.h

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 .../arm/mach-stm32mp/include/mach/sys_proto.h | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-stm32mp/include/mach/sys_proto.h b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
index 19073668497..5d67589bc79 100644
--- a/arch/arm/mach-stm32mp/include/mach/sys_proto.h
+++ b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
@@ -31,22 +31,22 @@
 #define CPU_STM32MP131Dxx	0x05010EC9
 
 /* ID for STM32MP25x = Device Part Number (RPN) (bit31:0) */
-#define CPU_STM32MP257Cxx       0x00002000
-#define CPU_STM32MP255Cxx       0x00082000
-#define CPU_STM32MP253Cxx       0x000B2004
-#define CPU_STM32MP251Cxx       0x000B3065
-#define CPU_STM32MP257Axx       0x40002E00
-#define CPU_STM32MP255Axx       0x40082E00
-#define CPU_STM32MP253Axx       0x400B2E04
-#define CPU_STM32MP251Axx       0x400B3E65
-#define CPU_STM32MP257Fxx       0x80002000
-#define CPU_STM32MP255Fxx       0x80082000
-#define CPU_STM32MP253Fxx       0x800B2004
-#define CPU_STM32MP251Fxx       0x800B3065
-#define CPU_STM32MP257Dxx       0xC0002E00
-#define CPU_STM32MP255Dxx       0xC0082E00
-#define CPU_STM32MP253Dxx       0xC00B2E04
-#define CPU_STM32MP251Dxx       0xC00B3E65
+#define CPU_STM32MP257Cxx	0x00002000
+#define CPU_STM32MP255Cxx	0x00082000
+#define CPU_STM32MP253Cxx	0x000B2004
+#define CPU_STM32MP251Cxx	0x000B3065
+#define CPU_STM32MP257Axx	0x40002E00
+#define CPU_STM32MP255Axx	0x40082E00
+#define CPU_STM32MP253Axx	0x400B2E04
+#define CPU_STM32MP251Axx	0x400B3E65
+#define CPU_STM32MP257Fxx	0x80002000
+#define CPU_STM32MP255Fxx	0x80082000
+#define CPU_STM32MP253Fxx	0x800B2004
+#define CPU_STM32MP251Fxx	0x800B3065
+#define CPU_STM32MP257Dxx	0xC0002E00
+#define CPU_STM32MP255Dxx	0xC0082E00
+#define CPU_STM32MP253Dxx	0xC00B2E04
+#define CPU_STM32MP251Dxx	0xC00B3E65
 
 /* return CPU_STMP32MP...Xxx constants */
 u32 get_cpu_type(void);
-- 
2.25.1

base-commit: 3b164fd951a9e93a13e793588cbcd3182089ec48
branch: upstream_cosmetic
