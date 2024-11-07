Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA94D43360
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 13:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E35E88F14;
	Thu,  7 Nov 2024 14:58:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=aibrahem.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=aibrahem.com header.i=@aibrahem.com header.b="ZCgHRPua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 487C788FBB; Thu,  7 Nov 2024 13:52:16 +0100 (CET)
Received: from qs51p00im-qukt01080102.me.com (qs51p00im-qukt01080102.me.com
 [17.57.155.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3082589259
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 13:52:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=aibrahem.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mail@aibrahem.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aibrahem.com;
 s=sig1; t=1730983933;
 bh=D63eiP0ZQYxInVRUNdGNQZIBKZs1t5nmegIaS2R+2S8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ZCgHRPuaVPN6wtEupSM70zi7HGBuFW2TuZsDN/gw02N8rY8dy17Mn9ZiXge7At7A+
 /+yVALvXX2wc2TpNtXnBkZRPNaC71EUULpW0xSEyAa2TNMKZfaMvH6bq57yM6Q18Vv
 hAbAcZZcEGqd4tnJwFFmRx/tNO9kXEhqOJ6maaaKa4O4LUpBgemK2T09cKG9Uk6bzN
 rLleTzip8O53NBQDjGNVvKsODHg/6qXh3PnQcxtYDHIWLDt8ndHbiQ8UA5pCGgeJKp
 w4DwR6rTpjtEjWWq75HzEC+JusecRwx03C3x57kmmg+CYT7M/89DKJ7t4+dQch269n
 CMC7SBe/QZvZQ==
Received: from localhost.localdomain (qs51p00im-dlb-asmtp-mailmevip.me.com
 [17.57.155.28])
 by qs51p00im-qukt01080102.me.com (Postfix) with ESMTPSA id 8AD8C1CC00EB;
 Thu,  7 Nov 2024 12:52:10 +0000 (UTC)
From: Abdelrahman Ibrahem <mail@aibrahem.com>
To: u-boot@lists.denx.de
Cc: Abdelrahman Ibrahem <mail@aibrahem.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: imx: Remove arch_env_get_location to fix env lockdown
Date: Thu,  7 Nov 2024 13:50:44 +0100
Message-ID: <20241107125122.48361-1-mail@aibrahem.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VrVfYe1YjDeNADwdoBTQM0NUtYLyLPz5
X-Proofpoint-ORIG-GUID: VrVfYe1YjDeNADwdoBTQM0NUtYLyLPz5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_04,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0
 clxscore=1030 mlxlogscore=833 suspectscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411070100
X-Mailman-Approved-At: Thu, 07 Nov 2024 14:58:46 +0100
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

This patch resolves an issue encountered with Layerscape SoCs, where
attempts to restrict write access to environment variables to enforce
secureboot are ineffective when using the CONFIG_ENV_IS_NOWHERE
configuration in combination with CONFIG_ENV_IS_IN_xxx.

Signed-off-by: Abdelrahman Ibrahem <mail@aibrahem.com>
---

 arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 41 -------------------------
 1 file changed, 41 deletions(-)

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
index d2d3e346a3..7dd5f429bf 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
@@ -819,47 +819,6 @@ int mmc_get_env_dev(void)
 }
 #endif
 
-enum env_location arch_env_get_location(enum env_operation op, int prio)
-{
-	enum boot_src src = get_boot_src();
-	enum env_location env_loc = ENVL_NOWHERE;
-
-	if (prio)
-		return ENVL_UNKNOWN;
-
-#ifdef	CONFIG_ENV_IS_NOWHERE
-	return env_loc;
-#endif
-
-	switch (src) {
-	case BOOT_SOURCE_IFC_NOR:
-		env_loc = ENVL_FLASH;
-		break;
-	case BOOT_SOURCE_QSPI_NOR:
-		/* FALLTHROUGH */
-	case BOOT_SOURCE_XSPI_NOR:
-		env_loc = ENVL_SPI_FLASH;
-		break;
-	case BOOT_SOURCE_IFC_NAND:
-		/* FALLTHROUGH */
-	case BOOT_SOURCE_QSPI_NAND:
-		/* FALLTHROUGH */
-	case BOOT_SOURCE_XSPI_NAND:
-		env_loc = ENVL_NAND;
-		break;
-	case BOOT_SOURCE_SD_MMC:
-		/* FALLTHROUGH */
-	case BOOT_SOURCE_SD_MMC2:
-		env_loc =  ENVL_MMC;
-		break;
-	case BOOT_SOURCE_I2C1_EXTENDED:
-		/* FALLTHROUGH */
-	default:
-		break;
-	}
-
-	return env_loc;
-}
 #endif	/* CONFIG_TFABOOT */
 
 u32 initiator_type(u32 cluster, int init_id)
-- 
2.43.0

