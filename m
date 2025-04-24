Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A44EC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:09:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FC3280FF7;
	Thu, 24 Apr 2025 08:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="vg8DT4wz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62CF18056A; Thu, 24 Apr 2025 08:08:44 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3909080FF7
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:08:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6209a59483=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NGPa0W005683;
 Thu, 24 Apr 2025 08:08:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 E18OQUALrBJ8J64z130lC2TBzy2JC2SOn4RBM9N4v1g=; b=vg8DT4wzv0XAvYCh
 SXKHTcats9eV+wHCJi8jEKjbxYvjbq2X47silkqgawp8vsYURIzTuDeANX5ileFH
 1+DnpryX1ybTwbRJYrUYevL7x0as/iieLLezkdPeWTXminxXOAJS99N4eX3Mz6vA
 hjvGz0avfrdSRgj1kSRIP0+bjbwYzzZV/37dPrTP3YWycHUKnJd4J4wrrCawaYdI
 7HH0pViItjVm35BoFRObKcMN7UdT+gt3IPX9NXHLECUBm33Xs2bpzJkylLDfDycv
 ANMmd4TpIYSFh3qfZyc7pL06kdCvnTXefYEISiWFRV6A3f6P58MjAF7yUyNEAa03
 xOlyTA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 466jk3e1y3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 08:08:39 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D79A84004D;
 Thu, 24 Apr 2025 08:08:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 23E98A4C07D;
 Thu, 24 Apr 2025 08:07:49 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 08:07:48 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/21] configs: stm32mp25: add USB host boot support
Date: Thu, 24 Apr 2025 08:07:13 +0200
Message-ID: <20250424060723.2695014-12-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250424060723.2695014-1-patrice.chotard@foss.st.com>
References: <20250424060723.2695014-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_02,2025-04-22_01,2025-02-21_01
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

Add support for booting from USB pen drive, since USB host
port is available on the STM32MP2.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 include/configs/stm32mp25_common.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/configs/stm32mp25_common.h b/include/configs/stm32mp25_common.h
index 1c28ce1c1e9..481b25a1f02 100644
--- a/include/configs/stm32mp25_common.h
+++ b/include/configs/stm32mp25_common.h
@@ -41,11 +41,18 @@
 #define BOOT_TARGET_UBIFS(func)
 #endif
 
+#ifdef CONFIG_CMD_USB
+#define BOOT_TARGET_USB(func)	func(USB, usb, 0)
+#else
+#define BOOT_TARGET_USB(func)
+#endif
+
 #define BOOT_TARGET_DEVICES(func)	\
 	BOOT_TARGET_MMC1(func)		\
 	BOOT_TARGET_UBIFS(func)		\
 	BOOT_TARGET_MMC0(func)		\
-	BOOT_TARGET_MMC2(func)
+	BOOT_TARGET_MMC2(func)		\
+	BOOT_TARGET_USB(func)
 
 /*
  * default bootcmd for stm32mp25:
-- 
2.25.1

