Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1960E7E644
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 15:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4316186D81;
	Tue, 26 Sep 2023 17:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Q8EqdS1o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09A5186DD8; Tue, 26 Sep 2023 17:10:47 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38A5C86D75
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 17:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7633ac7092=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 38QB1GfG002898; Tue, 26 Sep 2023 17:10:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 selector1; bh=bka0uVOfQhcCKjt1zJmiL+2y+Uk0MdtRxe682NGh4iU=; b=Q8
 EqdS1oqkLvZgNaSp1271kAbulpGLRdJNLCAv380tebK8HwwSnEz/wjIz2qmONIl4
 EFd0erZtchXnjPYo300M9uWLDcf9gfLxbNTPvTegNEWomZlAa5VE9+D3W6WdOtZA
 9yJwSJ44NjZcxryxwCFbUNrqRPBeIDNz/0+y2zAHjKfQNh26+Zn44/WYEDkipB/1
 wjf7P3dOUzt681MEuj01WD7g8pGIewrpbJO9XlmDq9AfoAeWSogCq+ttz7dYZBIR
 6w+NFlQKqi84hCwktXlI+3JPWzGzYHdzdIZRCyQn/V8WFKgwBUeyuZBBGoywcaQW
 +Al7VfyL6fUrGDoNkVow==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t9pwd5p5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Sep 2023 17:10:44 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2562B10005A;
 Tue, 26 Sep 2023 17:10:32 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1F1C92405B0;
 Tue, 26 Sep 2023 17:10:32 +0200 (CEST)
Received: from localhost (10.201.20.38) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 17:10:31 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v1 5/6] configs: stm32mp13: add support of usb boot
Date: Tue, 26 Sep 2023 17:09:22 +0200
Message-ID: <20230926150924.1150082-6-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926150924.1150082-1-patrice.chotard@foss.st.com>
References: <20230926150924.1150082-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_12,2023-09-26_01,2023-05-22_02
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

From: Patrick Delaunay <patrick.delaunay@foss.st.com>

Add support of USB key boot in distro boot command.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 include/configs/stm32mp13_common.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/configs/stm32mp13_common.h b/include/configs/stm32mp13_common.h
index d36fbf00548..5b0658ced92 100644
--- a/include/configs/stm32mp13_common.h
+++ b/include/configs/stm32mp13_common.h
@@ -35,9 +35,16 @@
 #define BOOT_TARGET_MMC1(func)
 #endif
 
+#ifdef CONFIG_CMD_USB
+#define BOOT_TARGET_USB(func)	func(USB, usb, 0)
+#else
+#define BOOT_TARGET_USB(func)
+#endif
+
 #define BOOT_TARGET_DEVICES(func)	\
 	BOOT_TARGET_MMC1(func)		\
-	BOOT_TARGET_MMC0(func)
+	BOOT_TARGET_MMC0(func)		\
+	BOOT_TARGET_USB(func)
 
 /*
  * default bootcmd for stm32mp13:
-- 
2.25.1

