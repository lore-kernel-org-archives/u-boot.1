Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28426D35157
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 07:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9668480517;
	Wed,  1 Apr 2026 09:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="YK5XziI5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E68684010; Wed,  1 Apr 2026 09:48:45 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F22680077
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 09:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+smaxfabW5RxoZx41kEsF7U+dQXam/Ct4HjmEhCtnUVs6//W14deSgojDNTD8nTjr/MtUXq7OlragelCQO+g0gin/Ds5bRzZ6txI8A6WNO0e14edaikAOSfOma21h4qty/3Ql7RZFL21PZvf2oRDAKW6np1A9ZksaLU8LCxKE/8Zb6+Vu09otYS1UjokISnD1RAbPl+97NrfX7DyTn2jefyYY9abBWh8DkdhcmzgaahthubNe99epF5/x8BBwytZlv1Bfc+fajtKWg3y2ffeR/gRXhXmOnROdXMxhcVxqQ/1g3bQBo6Ns4QQIyCgEGSciRDBBHU/yR29rhMEEDrKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83Hl5klw7LlJQkS9LFrC2E4FwwsKdZIaDZDQihD9E/8=;
 b=gopxNXVLyC7pKiGBx689IU7/kgQ5YRxNXcWZqPwe9FLLG9+CuooLNSCNlo6byh+jBGi6qmiDBeW6O5FmrizST6TT7MUEX/FFLA1KIYRO8VG4jJ+BYiGel03J2K2Uzi5ei3b24mVqmQAQIQ8lDLX6bPKCVcjTmdGGwCvwjNDjtG/hdmDmOtR5TsshUuE4kN8wb1kEwGX6eL0RGIfdLPg0TNv5og5OK4KZlDzRhbj2FTwu6OuomMjUwWpO+Ofyu4vSygpMbqIXUcZwVO/GLfnjzJIYZlzfsssYIJpMrVMOP1v+gHNHWszOhUFy2+TAOJ7SY1CZNCG/PphC0NngnOIJng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=amarulasolutions.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83Hl5klw7LlJQkS9LFrC2E4FwwsKdZIaDZDQihD9E/8=;
 b=YK5XziI5KMjLADmQwh8jW6PnK+/D3Jb/Ts/34XrHlt8jhGqCVi0is3/E8i3jo/B1v2Oh+u/2KY/KWieCmx9OHUfJ7iFKwYuODk19VsYaDJRf2LXIMvyZCMmuabFtp7Hzs6483cbVlO/ezR8HiCmYuvNa/MTL8WgfxSpYWbgtIc/ii0D6Xkl5BL98f7oHo54FGjGlDwSvXF2xgVu6DNUA7891CnCsZcWzO/L0HdcV3Ntf/qVXznfn4swcWSxiKg0JPWBNxPrqi6zvpwZjnCwoncm5EIrvfzvLLn90btIMxzV0Lh8Iha7PinSqqqLsnXyxUQgPJ+znu1Hevm53ZpBMYQ==
Received: from CWLP123CA0195.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19c::23)
 by VI0PR10MB8522.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:213::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Wed, 1 Apr
 2026 07:48:40 +0000
Received: from AMS0EPF0000019E.eurprd05.prod.outlook.com
 (2603:10a6:400:19c::4) by CWLP123CA0195.outlook.office365.com
 (2603:10a6:400:19c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 07:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF0000019E.mail.protection.outlook.com (10.167.16.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 07:48:39 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 1 Apr
 2026 09:51:20 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 1 Apr
 2026 09:48:38 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 1 Apr 2026 09:48:38 +0200
Subject: [PATCH] ARM: stm32mp2: Factorize TAMP_FWU_BOOT_IDX_MASK/OFFSET
 definition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260401-factorize_tamp_fwu_boot_defines-v1-1-ebecaf20ad6b@foss.st.com>
X-B4-Tracking: v=1; b=H4sIANXNzGkC/x2NQQrDIBQFrxL+usJXmgZ6lVLExmf7F9GgJikNu
 Xuky2FgZqeCLCh073bKWKVIig30paPx4+IbSnxjMmxufGWtghtryvKDrW6abdgW+0qpWo8gEUU
 Z7gHPg/Ma1CpzbuL7Pzyex3ECztVgWXEAAAA=
X-Change-ID: 20260401-factorize_tamp_fwu_boot_defines-205eed07ad1e
To: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Marek Vasut <marek.vasut@mailbox.org>, "Dario
 Binacchi" <dario.binacchi@amarulasolutions.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019E:EE_|VI0PR10MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: 86dac98e-b78d-4d60-602e-08de8fc316c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: GabE9lgb2n/rBaaXfZGgmVyWhkwnTW9EnAwYYn/EBwv4n290lRyyUtcyTUxWbrccOTN5o1/FRchxiQeTA5HXTN50is2PgMb5KmCvqe2wuCoRLEcebQySltfIHYoMfobhWmlF/rlp+FX11hh5V/yLAOmyGw1igL4CW85G36nFKK1ukWLOjhgW2dha9XN+49TZFvnrjurZPZQFrSIR4T08SxPUrtpHY3Ea3tCO5cdsehKchbDn7qRZ6Q8sq3+wA9XCYMowh4hAKCkvt7oq+fJbJNROvUzNrBbPBKMltGTvbsn0RsuVYFjBhcWqUqu7TVmSmcbbO4iNK4PwBQke22OAJ2NkcOkOixXuAZ2CwW+KNIR1cs/0iy2+AHeYrRkWoV1WSQ5v0TUzu5OJF9EC0jQaCK6rxggYspq0+UcPPMuVsirdGXW6KDxhiu9WFY2SosyFFqQbXGJIuiVpuH8LMriLvJEqRj+Jxa02J0PgbFN9JPxyzwVSnL2ZE5BOLNoT0zYsjqbk7ZllmD0nwn2nFZXLQuqL4tJ6um448gzH8erpWzzbATsG8bkZ70Mg45MFbtY4vFPqJs6RobEf7KiX2UHRlH+tHy5I0Bgvo3p249BYEywD0BfEplf2hUDzAt7ivB+RsklaJE7FIcRSOmzKBKtqZ47v/ZpSf7wsBh3xxleC2HIU7BdPOZc3ShIkUSgIRxBZxnWw3LOgcBZX3Na3BwJY5D9jHXd73Lfv1+hUGW6Rp9nb02sExNpw7kJzFhzom+9J9VilIMyeLCq0qJoo5m0jIA==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yW2bYb6O0ysFGsIyDs5i1RG5hbTI3m/q8PR1fJnGUYovVScmQduiQD9jctyxk5xs8HpskvmSxAvFbMNntCkU00AYLUz2JT3UUJLsEsJt7dwclJJxKWosmAds0MloTOJmuW2CotFN75b8Z+3PZNN//Tqub8QUv2anQ3dbNyHOopFPoPOxgNOeRWI9qE62jzOEKGdv1ol2ygKSnhoU8SMJndHxZjpp/frAMQPTkoGVMCurNw45/0EBFNJOUt9lsCl8FUNzWdowFzndv8/bgcPuBbRzV+004ySze7JTucG/26fvQDTdyUp5uIvlxr14dHxbpSnw0DnPrbjsIS5yiz3P8WzMZ9S9E4ALTMSCWTh2sCFfE/LRKEU0H/SniL/c7Qas9EMjN9rEuTRt49z3HFB85vKemI3nuaJgOk/NzlwpbvNPsxhJ02fI3pRK6eXPgRvZ
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 07:48:39.5762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86dac98e-b78d-4d60-602e-08de8fc316c5
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8522
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

Factorize TAMP_FWU_BOOT_IDX_MASK and TAMP_FWU_BOOT_IDX_OFFSET
definition which are common to STM32MP1 and STM32MP2 SoCs family.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/mach-stm32mp/include/mach/stm32.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
index 7f349f3b68d..42e3735847a 100644
--- a/arch/arm/mach-stm32mp/include/mach/stm32.h
+++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
@@ -135,6 +135,9 @@ enum forced_boot_mode {
 /* TAMP registers */
 #define TAMP_BACKUP_REGISTER(x)		(STM32_TAMP_BASE + 0x100 + 4 * x)
 
+#define TAMP_FWU_BOOT_IDX_MASK		GENMASK(3, 0)
+#define TAMP_FWU_BOOT_IDX_OFFSET	0
+
 #ifdef CONFIG_STM32MP15X
 #define TAMP_BACKUP_MAGIC_NUMBER	TAMP_BACKUP_REGISTER(4)
 #define TAMP_BACKUP_BRANCH_ADDRESS	TAMP_BACKUP_REGISTER(5)
@@ -144,9 +147,6 @@ enum forced_boot_mode {
 #define TAMP_BOOT_CONTEXT		TAMP_BACKUP_REGISTER(20)
 #define TAMP_BOOTCOUNT			TAMP_BACKUP_REGISTER(21)
 
-#define TAMP_FWU_BOOT_IDX_MASK		GENMASK(3, 0)
-
-#define TAMP_FWU_BOOT_IDX_OFFSET	0
 #define TAMP_COPRO_STATE_OFF		0
 #define TAMP_COPRO_STATE_INIT		1
 #define TAMP_COPRO_STATE_CRUN		2
@@ -196,8 +196,6 @@ enum forced_boot_mode {
 /* TAMP registers zone 3 RIF 1 (RW) at 96*/
 #define TAMP_BOOT_CONTEXT		TAMP_BACKUP_REGISTER(96)
 
-#define TAMP_FWU_BOOT_IDX_MASK		GENMASK(3, 0)
-#define TAMP_FWU_BOOT_IDX_OFFSET	0
 #endif /* defined(CONFIG_STM32MP21X) || defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X) */
 
 /* offset used for BSEC driver: misc_read and misc_write */

---
base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da
change-id: 20260401-factorize_tamp_fwu_boot_defines-205eed07ad1e

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>

