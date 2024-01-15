Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7FEC4707B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 14:08:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75D9987061;
	Mon, 15 Jan 2024 15:08:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="enZyXh3Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06F3887812; Mon, 15 Jan 2024 15:08:39 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A522876D0
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 15:08:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1744d57945=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40FB5LpR002614; Mon, 15 Jan 2024 15:08:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 selector1; bh=7I4GTD+JorHEaYY2olvWo5vcB0nUbpjpXys8OAH/Kpw=; b=en
 ZyXh3YfHklUwFmGdEyf0hOUqtBWA+jl9AETsqKZPakPUXjzLdv2/EKl1SOuOYodd
 wZSk5CAyxemg6JPgxXG8xMpMvwSMFWa8+gcp2phcWSprC5dBM54QWJpApFLJMRPM
 34ZDp2HFvoQ7DgyGFd54/sirnz2vMrn0wl2kv6qHOgbrBR1TZKmnfgJ3k2g1dnS4
 ugHeSN8Zah1PiyKtOmx4yE5sVrt1K1xnIvocujFrwlfb4YAqKQNaPuO70wA+0Pfx
 n20Ta7O1kFPy7aPuzQXuneVruavLhoeQle9w8oStuLRdR6T2sXMuw7F8OpfWHhhZ
 IquZdYyBBx86eqdK5a1Q==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkmfy912a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jan 2024 15:08:34 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C2EDF10002A;
 Mon, 15 Jan 2024 15:08:33 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B7DB0298665;
 Mon, 15 Jan 2024 15:08:33 +0100 (CET)
Received: from localhost (10.201.22.165) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Jan
 2024 15:08:33 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Igor Opaniuk
 <igor.opaniuk@foundries.io>, Marek Vasut <marex@denx.de>, Oleksandr Suvorov
 <oleksandr.suvorov@foundries.io>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 10/14] stm32mp: activate the command stboard for stm32mp25
 boards
Date: Mon, 15 Jan 2024 15:05:53 +0100
Message-ID: <20240115150451.v2.10.I7e8d4ae242605f7c9d276a858f336d13681528d9@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240115140557.57448-1-patrick.delaunay@foss.st.com>
References: <20240115140557.57448-1-patrick.delaunay@foss.st.com>
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

Activate the command stboard for stm32mp25 STMicroelectronics boards,
add the default used OTP identifier and the associated board identifier:
- stm32mp25xx-ev1 = MB1936
- stm32mp25xx-dk = MB1605

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

Changes in v2:
- fix CONFIG name with 'x': TARGET_ST_STM32MP15x TARGET_ST_STM32MP13x

 arch/arm/mach-stm32mp/include/mach/stm32.h | 1 +
 board/st/common/Kconfig                    | 2 +-
 board/st/common/cmd_stboard.c              | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
index 45c929aa605d..726c390977e3 100644
--- a/arch/arm/mach-stm32mp/include/mach/stm32.h
+++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
@@ -198,6 +198,7 @@ enum forced_boot_mode {
 #define BSEC_OTP_SERIAL	5
 #define BSEC_OTP_RPN	9
 #define BSEC_OTP_PKG	122
+#define BSEC_OTP_BOARD	246
 #define BSEC_OTP_MAC	247
 #endif
 
diff --git a/board/st/common/Kconfig b/board/st/common/Kconfig
index c1c254d07354..f40d1a78ca36 100644
--- a/board/st/common/Kconfig
+++ b/board/st/common/Kconfig
@@ -1,7 +1,7 @@
 config CMD_STBOARD
 	bool "stboard - command for OTP board information"
 	depends on ARCH_STM32MP
-	default y if TARGET_ST_STM32MP15x || TARGET_ST_STM32MP13x
+	default y if TARGET_ST_STM32MP25X || TARGET_ST_STM32MP15x || TARGET_ST_STM32MP13x
 	help
 	  This compile the stboard command to
 	  read and write the board in the OTP.
diff --git a/board/st/common/cmd_stboard.c b/board/st/common/cmd_stboard.c
index 853ab78bbf16..cb103e69b369 100644
--- a/board/st/common/cmd_stboard.c
+++ b/board/st/common/cmd_stboard.c
@@ -49,7 +49,9 @@ static bool check_stboard(u16 board)
 		0x1298,
 		0x1341,
 		0x1497,
+		0x1605, /* stm32mp25xx-dk */
 		0x1635,
+		0x1936, /* stm32mp25xx-ev1 */
 	};
 
 	for (i = 0; i < ARRAY_SIZE(st_board_id); i++)
-- 
2.25.1

