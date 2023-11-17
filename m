Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69B7C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 17:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF711871B4;
	Fri, 17 Nov 2023 18:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="vmQiN6cD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F284786EEE; Fri, 17 Nov 2023 18:01:16 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B203E86FF7
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 18:01:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=968596d76e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3AHBUQ4s003521; Fri, 17 Nov 2023 18:01:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 selector1; bh=8YNOvJcA3+H7HcOoLsQS+BL6qJ8QfXWrONNMR9j5dUw=; b=vm
 QiN6cDAFLTtZBVVmWZqmks8lMyEuGQfqoQvsTS5AJrvP6mHhA8F2vkVPnVZuE7Jj
 50PX8AHP66tLwwLDqyx+FTumOzMrzCVWJa/UZTC9Ko+OiOHYj8xKwxp63FfQ1BuH
 ItiU73xsUNLN7uRDrXGTt4c/Ucx4QU0k5rRz2nxQ3NEGqXFxFwgVT2uYIiCmtg4G
 YN0NeHvFKBMJFNM3kF38jLt5FJwAVDtuvuuk0g4cRpnZjHTRq1UAdU3dPeI6RB4a
 5W2Kls3eoRN25Hy6f3N/raoVuDOzpXVbyLzyRVAddXz8HSOgs+WuQCH0UCPEKY2j
 RlAagcCs1R1t1ojKwoAw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ua1chmedb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Nov 2023 18:01:11 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BADD0100034;
 Fri, 17 Nov 2023 18:01:10 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B44B0257AA2;
 Fri, 17 Nov 2023 18:01:10 +0100 (CET)
Received: from localhost (10.252.0.168) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 17 Nov
 2023 18:01:10 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 2/2] board: st: common: simplify MTD device parsing
Date: Fri, 17 Nov 2023 18:01:07 +0100
Message-ID: <20231117170107.1147598-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231117170107.1147598-1-patrice.chotard@foss.st.com>
References: <20231117170107.1147598-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.0.168]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_16,2023-11-17_01,2023-05-22_02
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

Simplify the way all MTD devices are parsed.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 board/st/common/stm32mp_dfu.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/board/st/common/stm32mp_dfu.c b/board/st/common/stm32mp_dfu.c
index ded3bf81961..77edb86e78c 100644
--- a/board/st/common/stm32mp_dfu.c
+++ b/board/st/common/stm32mp_dfu.c
@@ -123,24 +123,9 @@ void set_dfu_alt_info(char *interface, char *devstr)
 		/* probe all MTD devices */
 		mtd_probe_devices();
 
-		/* probe SPI flash device on a bus */
-		if (!uclass_get_device(UCLASS_SPI_FLASH, 0, &dev)) {
-			mtd = get_mtd_device_nm("nor0");
-			if (!IS_ERR_OR_NULL(mtd))
+		mtd_for_each_device(mtd)
+			if (!mtd_is_partition(mtd))
 				board_get_alt_info_mtd(mtd, buf);
-
-			mtd = get_mtd_device_nm("nor1");
-			if (!IS_ERR_OR_NULL(mtd))
-				board_get_alt_info_mtd(mtd, buf);
-		}
-
-		mtd = get_mtd_device_nm("nand0");
-		if (!IS_ERR_OR_NULL(mtd))
-			board_get_alt_info_mtd(mtd, buf);
-
-		mtd = get_mtd_device_nm("spi-nand0");
-		if (!IS_ERR_OR_NULL(mtd))
-			board_get_alt_info_mtd(mtd, buf);
 	}
 
 	if (IS_ENABLED(CONFIG_DFU_VIRT)) {
-- 
2.25.1

