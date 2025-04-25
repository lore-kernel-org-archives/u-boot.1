Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E4EC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 13:17:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71ED482155;
	Fri, 25 Apr 2025 15:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="6hOO4lEp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E10481F4D; Fri, 25 Apr 2025 15:16:42 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30FE28210D
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 15:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6210cfe02c=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P7lA2G018475;
 Fri, 25 Apr 2025 15:16:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 VBLPBK+UL5x0GFR+cbxBZXGlekEFYfiPbf76vg6YEIU=; b=6hOO4lEpvIB2dycW
 wkb6dcTFOCKF4PqXrHbzslxBbs5LdQsC5+fBXHKgqdoLqwXYYKDd8cBMLA30RH1I
 yB+TE2B7dqp8uum0AXXZZSMJZNRZ7DsdTR6mwOlcP7EArbkZ5gzHRU0MdcNLzeBA
 jcNTiTskqe3gI0fSz+WfxxoZN3jQHQ/u92LvPj2u4WlTDKeHv+HBmvmgGhoGTqjG
 kGkthC9m1ZcS5bdLP1jCkd4G8BWNSKgSLkXE292NjFxRGhSjCgFORIH5zpLgY1nZ
 1/4K//FdqvKu0seIicRZO6cHnBikRbdr9ftl2dBQxQyNBVUu1YA+9lvwuBjTJSvu
 oA+jbg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 466jjvc8y2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 15:16:38 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 08C9540045;
 Fri, 25 Apr 2025 15:16:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A4A3F90BF67;
 Fri, 25 Apr 2025 15:15:48 +0200 (CEST)
Received: from localhost (10.252.18.92) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 15:15:48 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 12/22] configs: stm32mp25: add PXE boot support
Date: Fri, 25 Apr 2025 15:15:23 +0200
Message-ID: <20250425131533.392747-13-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250425131533.392747-1-patrice.chotard@foss.st.com>
References: <20250425131533.392747-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.18.92]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
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

Configure the required configuration to allow PXE boot,
without autoload support by default.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

(no changes since v1)

 include/configs/stm32mp25_common.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/configs/stm32mp25_common.h b/include/configs/stm32mp25_common.h
index 481b25a1f02..b42316fd8ac 100644
--- a/include/configs/stm32mp25_common.h
+++ b/include/configs/stm32mp25_common.h
@@ -25,6 +25,12 @@
 #ifdef CONFIG_DISTRO_DEFAULTS
 /*****************************************************************************/
 
+#ifdef CONFIG_NET
+#define BOOT_TARGET_PXE(func)	func(PXE, pxe, na)
+#else
+#define BOOT_TARGET_PXE(func)
+#endif
+
 #ifdef CONFIG_CMD_MMC
 #define BOOT_TARGET_MMC0(func)	func(MMC, mmc, 0)
 #define BOOT_TARGET_MMC1(func)	func(MMC, mmc, 1)
@@ -52,7 +58,8 @@
 	BOOT_TARGET_UBIFS(func)		\
 	BOOT_TARGET_MMC0(func)		\
 	BOOT_TARGET_MMC2(func)		\
-	BOOT_TARGET_USB(func)
+	BOOT_TARGET_USB(func)		\
+	BOOT_TARGET_PXE(func)
 
 /*
  * default bootcmd for stm32mp25:
-- 
2.25.1

