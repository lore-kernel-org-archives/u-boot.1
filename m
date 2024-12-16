Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D832FE7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 10:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C7848004E;
	Mon, 16 Dec 2024 11:24:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="1p8ajRyx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D1F8801EE; Mon, 16 Dec 2024 11:24:49 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 974D78003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 11:24:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=20806bd110=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG72oCI019831;
 Mon, 16 Dec 2024 11:24:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 mfIUHXbZmA1Sxwm/JjZUqTIrIVI4YIdmYfiFi14GqYw=; b=1p8ajRyx72w9zXhO
 vPH0Z2nm2Nzc+l25yxHA2+IZ2GJsJsON4aWuG3GOU6nvlcwhxjGhuJR7C3l5Ss6W
 8vuoXuug4tCnyQpmfrjKQvCakpToSJwAj7+UE5sCK7URCMa5EcwpQin+wWUrx4Kn
 lguYveWzomXcuAAaXZPE9WzZ3JHzu6+0vFEQLrrxSYNHdC2q48r9GDAfMpSPbzmn
 YV1sauN09dBpB0UN+BIuJktN+oy6jEGHOWqCZWmagRvkMs3pEfvquIbT4lTP/KqE
 MAFeY92MmiKFvLJQMsuRKhtQI0pHzV6txFuw667Hl8/jIDj/Dbc06ltiV1tCxEL/
 xu24uQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43jeeyh5xn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Dec 2024 11:24:44 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 09BFC40063;
 Mon, 16 Dec 2024 11:23:45 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 055D926CBEF;
 Mon, 16 Dec 2024 11:22:36 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 16 Dec
 2024 11:22:35 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Matteo Lisi <matteo.lisi@engicam.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/5] configs: stm32mp1: Restore boot SPL from sdcard for
 Engicam i.Core STM32MP1 EDIMM2.2
Date: Mon, 16 Dec 2024 11:22:17 +0100
Message-ID: <20241216102219.347725-3-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241216102219.347725-1-patrice.chotard@foss.st.com>
References: <20241216102219.347725-1-patrice.chotard@foss.st.com>
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

Restore boot SPL from sdcard for Engicam i.Core STM32MP1 EDIMM2.2.

Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig b/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
index 3f7eebd21d8..b733913be01 100644
--- a/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
+++ b/configs/stm32mp15-icore-stm32mp1-edimm2.2_defconfig
@@ -27,6 +27,9 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xc0300000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x1d00000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x3
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_POWER=y
-- 
2.25.1

