Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32554CA0EEA
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 09:43:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68002802C1;
	Thu, 14 Aug 2025 11:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Wh6O4vuu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E49B5802C1; Thu, 14 Aug 2025 11:43:23 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4C5E80194
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 11:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0321314444=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E8jgtO022068;
 Thu, 14 Aug 2025 11:43:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=selector1; bh=wbVKAvjPmm/+hM3TIxi+zo
 XPyXtvFh2bnyuvfbMyHXk=; b=Wh6O4vuu9cOMJDJRielHX16D4uYLl9lEbYkLKo
 KGPfmetcQ4rbiNQwg1jxqwq+zRCXbvPw+T/70vzQs21GAz03rlP4BAd2AC74XQif
 SDchIKhAj1ZBoNgXGRGxBBqd2+PEFCGEc/l4E0hdsut8Pb5EURI+rNHdsOJoENUV
 O/t9PWcHc51FmR+FgXHTIjK8ZMTxuWp9swkMPpkf6mduZpXysVEljLEsv4GAzjbP
 xhnxnbWCZRJd0kLejuxVTPKNEI8MXvesS4Nx8q7S2yLKKVYBJYq7a+/oH9dX9dpf
 QZE52iyRUYQvKjFpcEETi35rPb2aksIsiiQN5qZCiHMpHaHg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48dwp236wh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Aug 2025 11:43:17 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5D29E4002D;
 Thu, 14 Aug 2025 11:42:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2293D6C9737;
 Thu, 14 Aug 2025 11:41:19 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 11:41:18 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Cheick Traore
 <cheick.traore@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] configs: stm32mp25: Enable OF_UPSTREAM_BUILD_VENDOR
Date: Thu, 14 Aug 2025 11:41:15 +0200
Message-ID: <20250814094116.1351454-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
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

Enable OF_UPSTREAM_BUILD_VENDOR and set OF_UPSTREAM_VENDOR.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 configs/stm32mp25_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
index 14619ffd96c..2b02cd86d61 100644
--- a/configs/stm32mp25_defconfig
+++ b/configs/stm32mp25_defconfig
@@ -41,6 +41,8 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
 CONFIG_CMD_UBI=y
 CONFIG_OF_LIVE=y
+CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
+CONFIG_OF_UPSTREAM_VENDOR="st"
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-- 
2.25.1

base-commit: cd97f431b8062dcbc669d1ae7dd87736d9fca995
branch: upstream_OF_UPSTREAM_BUILD_VENDOR_for_mp25
