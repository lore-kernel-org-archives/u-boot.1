Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D47C4707B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 12:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ECF88753A;
	Mon, 15 Jan 2024 13:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="l/NhBnGT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D9A386EF1; Mon, 15 Jan 2024 13:47:17 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6229E86F02
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 13:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1744d57945=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40F8N7Ze008279; Mon, 15 Jan 2024 13:47:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 selector1; bh=ixth1qk6AeC84yb8XzTkHBJr6OI0Zl9xRCRm5UmDrWo=; b=l/
 NhBnGTQRz1a4wSMcYKtDx2QYumltiq7NQtrMZOpDl421ouO92CzJSm78Ukp7MTJW
 0cpiP4x62x6d5K98taIfUyD/dxW+2nabhymnjycx9hwmDA+7uHzIfTQuuzkD+/4+
 BPmeGUZwZGjpoKJKCt3P8Zq0RdbL7MKpsQxk0kE/Q5QK2VnpXmf54ss6Oxk0AxEf
 DVF+/PCmcjcaqxB6FLbPoXC10l+2hMZC8WUIG+kh0GaeKo02RVoaTW8K8bAY8iFE
 yM2YPUDvZC/RFwUB4Wu1OGvb0aEb9XAGuwE/4UhyH8CuU85g5ejCJAcSHlY04E4C
 d8E8uz6VXO+H6kUvnSdw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkmddrexv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 13:47:12 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8A50C10002A;
 Mon, 15 Jan 2024 13:47:11 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 80F6626DDD6;
 Mon, 15 Jan 2024 13:47:11 +0100 (CET)
Received: from localhost (10.201.22.165) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Jan
 2024 13:47:11 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Igor Opaniuk
 <igor.opaniuk@foundries.io>, Marek Vasut <marex@denx.de>, Oleksandr Suvorov
 <oleksandr.suvorov@foundries.io>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 04/12] stm32mp: bsec: add support of stm32mp25
Date: Mon, 15 Jan 2024 13:46:49 +0100
Message-ID: <20240115134642.4.I81fedd3d2ff9635b3738dd1ef349c936bc9b433d@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240115124657.39109-1-patrick.delaunay@foss.st.com>
References: <20240115124657.39109-1-patrick.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
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

Add support of BSEC for STM32MP25x family to access OTP.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 arch/arm/mach-stm32mp/bsec.c               | 7 +++++++
 arch/arm/mach-stm32mp/include/mach/stm32.h | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-stm32mp/bsec.c b/arch/arm/mach-stm32mp/bsec.c
index 705c994d9307..5b869017ec1a 100644
--- a/arch/arm/mach-stm32mp/bsec.c
+++ b/arch/arm/mach-stm32mp/bsec.c
@@ -784,9 +784,16 @@ static const struct stm32mp_bsec_drvdata stm32mp15_data = {
 	.size = 96,
 	.ta = false,
 };
+
+static const struct stm32mp_bsec_drvdata stm32mp25_data = {
+	.size = 368, /* 384 but no access to HWKEY and STM32PRVKEY */
+	.ta = true,
+};
+
 static const struct udevice_id stm32mp_bsec_ids[] = {
 	{ .compatible = "st,stm32mp13-bsec", .data = (ulong)&stm32mp13_data},
 	{ .compatible = "st,stm32mp15-bsec", .data = (ulong)&stm32mp15_data},
+	{ .compatible = "st,stm32mp25-bsec", .data = (ulong)&stm32mp25_data},
 	{}
 };
 
diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
index 46d469881b32..45c929aa605d 100644
--- a/arch/arm/mach-stm32mp/include/mach/stm32.h
+++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
@@ -197,7 +197,8 @@ enum forced_boot_mode {
 #ifdef CONFIG_STM32MP25X
 #define BSEC_OTP_SERIAL	5
 #define BSEC_OTP_RPN	9
-#define BSEC_OTP_PKG	246
+#define BSEC_OTP_PKG	122
+#define BSEC_OTP_MAC	247
 #endif
 
 #ifndef __ASSEMBLY__
-- 
2.25.1

