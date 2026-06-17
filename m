Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFE0CD98E2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 14:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAF2B849B4;
	Wed, 17 Jun 2026 16:11:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="H6pWNrtQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 019ED849B8; Wed, 17 Jun 2026 16:11:49 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDA56849B4
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 16:11:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ea/fk4eTA42+b7rnvhgj2hcIf1ugSzVE84f+JMFeHvSHrQyyrtIamaEOTNFw2jFZ4dIKu5pNk2RmmhWCg6Ckd1KvTd6BSyRGGNQUcwTaKZM9KXtluoUKcUvzKVuNhiQrRwpuVIJIO1JoeJI4IfqJ3KRSql6gNQjKFEoSuSfaaA8o1fN0kcHEcF9niOtw78rv2raAWV3XvIQlVGpIBCU1bhye0KeHae6C7uLl8W0F1XYb6yE9t4rPPiVtJPhFiz66suv2onu0Jzn7bk2SFLnlQgQiSN3kHz5qd1qX0Mg0DWt1xOEmxO4vc1lD2FHU/kGRSH0QnuDL6uxhIUrs8gyUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axoQIuZ0iIftUg4L3ovlQN3lFVjrAAKss3IcVJww24I=;
 b=V+0RzDrpnvmY4+gH6YgQL6Mi5qtBtCZD3x4XdQXyQe2cXKGBimemdBvYZwd9GmPrpReWMX4NkwPBha3AhJt53io+t8V/9egxnyJ5uxTh1hqVsP3IkZQ5qhuNNc9zTLv/VijXAVB9gPZe8AzofLwCujNmJCcpI8hidrKpUp5an9sfwJsgbVifFXUkzfT9Dc3OqWGqDiunosnZoTv/+HzbVHtPbyjFCI/CB64KLkWDIKaqqGsOHagkdnq1FHNVRRaqNBOxSjea+7CyAQ6NoEVlj9djHZ5+CcRwokSpl6v1DFXymN6goJede7z4LwZj4ItyDZJZLMDlLTGCarBpgY1LFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axoQIuZ0iIftUg4L3ovlQN3lFVjrAAKss3IcVJww24I=;
 b=H6pWNrtQwLCRAQ1vey+7hZzpjD8Vqf29BQuAx0iyJsk2IJxdtgdvOAV0qNejG5FPEj02S99KFxdnGjrD8VPpa/i3eZRdrr4p5GRtHtqyj41xHHsmmJeVqU6b0pvNuMEPnlepWs/umjvsHbNxkCtSMxdJSg15OqytKSURXgxrVYaOsD1bUuAPSFYLiQeaUoiFtGnndT3wnQEO5nCDpZx1IoXpiYwCFnYUTYMiSsrs5QhLpolg47voIktpgFpTQnmNI1d7YzNgf42hTuKYJ9ZJgQX6qStXlKQAxt2XpKycGrHq2aeXpItvKnqUMD7hr0iGMliGHPn8aDZZvmZIFXJPdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by AS5PR04MB9969.eurprd04.prod.outlook.com (2603:10a6:20b:67c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 14:11:45 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592%7]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 14:11:45 +0000
From: ye.li@oss.nxp.com
To: festevam@gmail.com,
	u-boot@lists.denx.de
Cc: peng.fan@nxp.com,
	uboot-imx@nxp.com,
	alice.guo@nxp.com,
	ye.li@nxp.com
Subject: [PATCH 2/4] imx9: bootaux: Support booting CM70,
 CM71 and CM33 sync cores
Date: Wed, 17 Jun 2026 22:14:44 +0800
Message-Id: <20260617141446.2794896-2-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617141446.2794896-1-ye.li@oss.nxp.com>
References: <20260617141446.2794896-1-ye.li@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::6) To AM0PR04MB5121.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5121:EE_|AS5PR04MB9969:EE_
X-MS-Office365-Filtering-Correlation-Id: d7eeab87-8f9e-4fd3-9367-08decc7a5ccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|19092799006|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: cVsGvS+sVzhfPKI1SLE0WB1BocOB6mwUyUCMGA3mgJonEgKlIbRa1PE/jwBrvvbn87Dl4ZpXOBFWSVjiUlJcHSMrkwE+hgCOgVR0WVYzGsezI2ENWc8Swiq8PAtwfrGwKKyPWhRo0ZSFKQme1H8fAMQmAjyDAFuIxeZkJvIOFyJZYuvfbyGMSQaVE05h4zFR3pDd8iVMM/dwq5TDxaQ/yZ5u60tpECnITqZHA6msVQMVrjDvhBdaiJ+Asoqj4grioxTUFCwHrG572obOEJpx17qw5OEVRIbNhMEqmymKZ9463lS5VY0gpqWwzGy1XQaz+JhmiLZuFtPtGLtBXMskAxUwjnz56kLjmGmLZPn9EGpmL7MhL1Oooe8nKnp6387gyYAoCc8+GY4nH7Ru3Le5QrPc3Vwyj67+fJlVDZ+xzbfozuwJe3n/0Tw9PbglPGkEzvgOEcWrrlOUn7mgOyeEQaqEZk+P2F1S35mjfPL/2FZ5K5WGgna+0XBAzKlvuJ8TdXTgAHR7xjy7yGy1xChLFAahlevmf9HRJ7TGcYPo57t1975uN2axz+yYU2AvoqDtsMfvgYbMdORxPPGG9yQmQAO4g+h4uoBrJ2fC7FULMHHoVkN61kuiNDsnJb0cMnaq+7PrgmSu9IuHuJRuuPrmU3NXuBlTXI/52huOw/LVeqc4lDhhE2t2fS4fpW/GEU4L
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5121.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(19092799006)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DICM0i+xPSbbdKSwq7e2Sm7vjbfAvGnf8s0zvePR481reDx6xhPHB8xD1Phg?=
 =?us-ascii?Q?+XQlSgiH2IdDCI5TazZGljUB0FE+aP2tAk3J8y7Bo2u0PjXG7ijVmQxkKzy3?=
 =?us-ascii?Q?hLg1fPNWFMcKlB+oUbIj4g5AzIY17EXB+aMKzBgLrYOm0s6p5JBxb2SpJnz9?=
 =?us-ascii?Q?Vxhbk2FwNW09pnH0pg58gP6Ahfm1cJGuJR77cZ2ZiS9pRJzRIgIZHf/Np+IT?=
 =?us-ascii?Q?7WELDo7020t3Q1JGmlNRr0HVc+3W8QLF3LHfafcSALIRn3DwQr+nolCnoeOg?=
 =?us-ascii?Q?sdxcyD65/Sx/AgpjKhymgrlfwtpc8eFlIcb3zTHrFlcqPjGvntGPQcnJF4jz?=
 =?us-ascii?Q?IwEVco5BzGMawsvhJ+M8f4kEYjLVRx5XYd4TDOJmL+QInWTa82gEzsLqJIDq?=
 =?us-ascii?Q?H9uL8KuKnaE9M9UnTFF00x9aS3hfEhHKMFVUfYJG1dtPRds3foTpHEg9Sa6O?=
 =?us-ascii?Q?K8W5fXwbF+4epzeKis2cOhRP+whhnNI0Hng1g3MdS7xV+iIXtYPfJYKjI4+A?=
 =?us-ascii?Q?aYTVvLCa0QGqyJNdLeqmidl5RYWCrflDd6FVdiG0ERIfr8OqJdfNlDopU/SZ?=
 =?us-ascii?Q?pPlP+K3KFYaFeQ3Ihfl/5mEI4sIHUTn4yD/nLWdserJ+xoIOoUSdVXLldsct?=
 =?us-ascii?Q?LkoL1bkmXVnnq0s2Ze65hGDG8r02NyPmsJvk/dfclaCKdOZA90Yn4KMIhnCN?=
 =?us-ascii?Q?AONpbemnqAeHW/v61BrsOhzwSoeY6VNeI8wNA1sxanQA+U0IE6x7KMUySDog?=
 =?us-ascii?Q?UIKl8r8Npb02H1x/HUH6MVhx81yKJ//pmTTDQAGeqzpJzNxq46raz8q9k4+E?=
 =?us-ascii?Q?xZEHfRbbcCR1HMWKN5HJ6xDWAH7kdtfAutlRkP9aXSA6SHRPBs3xJOtXThWq?=
 =?us-ascii?Q?szy0OZkQ2Nugnlv+/vUVbBOTrfuuKsf0J9xEUGOfevf+Iprmpamp39S9Yw9J?=
 =?us-ascii?Q?bBqj9NmdjcnsES6BqTJGSE9wiEaPTTPPseI06Yg5r7xYd0vpWV9ev5FfXudT?=
 =?us-ascii?Q?EeX/+efTE+7slrF/ZUO9MetBZ8lHRW0sf6Rk7Ishwh3rIR8XBNbRk/rwUojd?=
 =?us-ascii?Q?J51vodMUWr9aeDjqfKiROmSQd9ZtKY4Ylobk32OIZ5kfdit6X9K/IXp0iWXT?=
 =?us-ascii?Q?HUp+bOHBrcfUDBU6vHE1dQ55lWIzvfHu40l/ZMZ8mcqQbdDDt0rilx2aaNOE?=
 =?us-ascii?Q?zUPDI9xOMTWYwQ8LwyfL6wERsrwXPzBxsudGbkoqyNBIrJT5MXm8ZZxFyIgY?=
 =?us-ascii?Q?HWoqDhg8Jy803FKhz5lTJqQHQED+FzjR/N+9Oed09mOQdzltq5zF7QJinoaM?=
 =?us-ascii?Q?DX5FuwxUZEBlqOLaXACvJjkx+o3qJN4cI9YZjcDDocPbjPFmXtrratXM72lq?=
 =?us-ascii?Q?4+Sju43jUbszKMNNWaYqBBkLGsgcYQjMiLL/W2lnuk36iqwWHbP7sVfJeLyp?=
 =?us-ascii?Q?kyWISjZQPj3JWm3l+zu2r0nUw93RFWhzlyMFA0HF6lJFbobIaVJ6CzjiGCFU?=
 =?us-ascii?Q?3XJCYP3r+r09KDfT+XlH6NYafJEGthkdE+zXzuvuiGI3NX1F4sN/5b8gbkr0?=
 =?us-ascii?Q?0Y89n6pr6jp2LwN2Oatmb8Tayt7Fcr8JrYQzjqc+/t0Rjxj+16rKBEv2idnC?=
 =?us-ascii?Q?MzmUramlTB7rmbKCquHX46v9KJb4TjwFG2ODeTgjj2z2iYRNzgAW5EBjka7Q?=
 =?us-ascii?Q?DgUBxnNifvLvPochzV0eE0ekFu67gvn4/S0Q3/JkaQ3QvJ9fZV1bTiHz3VOt?=
 =?us-ascii?Q?3xfFIfInh9vUtW+sEos20QjWW4WNwWo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7eeab87-8f9e-4fd3-9367-08decc7a5ccf
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 14:11:45.0327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPDqPhI39Y0xRjo8qTrD1lTtenOK7OsBiUW3tRMw4qlYFudevCtBUl6v0AfkKq9/HOEld95LQ8pVKZX6hcU8lEjIzuNtn8qEAXJ0pXaSqq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9969
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

From: Alice Guo <alice.guo@nxp.com>

Support booting CM70, CM71 and CM33 sync core image by bootaux command
on iMX95, iMX94 and iMX952. (iMX95 and iMX952 only supports CM70).

Each core uses different core id which is defined by SM and passed in
SIP call.
 - CM33:  0
 - CM70:  1
 - CM71:  7
 - CM33S: 8

Prior to run bootaux to start core, prepaux is needed before loading
image. Below is example for booting CM70 TCM image on iMX95.

    =>fatload mmc 1:1 0x90000000 rpmsg.bin
    =>prepaux 1
    =>cp.b 0x90000000 0x203c0000 ${filesize}
    =>bootaux 0 1

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h |  18 +++
 arch/arm/mach-imx/imx9/imx_bootaux.c      | 188 ++++++++++++++++++----
 arch/arm/mach-imx/imx9/scmi/soc.c         |  33 +++-
 include/imx_sip.h                         |   2 +
 4 files changed, 206 insertions(+), 35 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index 47d6ae9b559..55f4f34e1bc 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -47,6 +47,16 @@
 #define SRC_MEDIA_RBASE		(SRC_IPS_BASE_ADDR + 0x2400)
 #define SRC_M33P_RBASE		(SRC_IPS_BASE_ADDR + 0x2800)
 
+#ifdef CONFIG_IMX94
+#define TCML_BASE_ADDR              (0x209C0000UL)
+#define TCML_BASE_MCORE_SEC_ADDR    (0x1FFC0000UL)
+#define TCML_BASE_MCORE_NSEC_ADDR   (0x0FFC0000UL)
+#define TCML_SIZE                   (0x40000U)
+#define TCMU_BASE_ADDR              (0x20A00000UL)
+#define TCMU_BASE_MCORE_SEC_ADDR    (0x30000000UL)
+#define TCMU_BASE_MCORE_NSEC_ADDR   (0x20000000UL)
+#define TCMU_SIZE                   (0x40000U)
+#else
 #define TCML_BASE_ADDR              (0x201E0000UL)
 #define TCML_BASE_MCORE_SEC_ADDR    (0x1FFE0000UL)
 #define TCML_BASE_MCORE_NSEC_ADDR   (0x0FFE0000UL)
@@ -55,6 +65,14 @@
 #define TCMU_BASE_MCORE_SEC_ADDR    (0x30000000UL)
 #define TCMU_BASE_MCORE_NSEC_ADDR   (0x20000000UL)
 #define TCMU_SIZE                   (0x20000U)
+#endif
+
+#define M7_TCML_BASE_ADDR           (0x20380000UL)
+#define M7_TCML_BASE_MCORE_ADDR     (0x0UL)
+#define M7_TCML_MAX_SIZE            (0x80000U) /* Could configure to 512KB TCML */
+#define M71_TCML_BASE_ADDR          (0x20280000UL)
+#define M71_TCML_BASE_MCORE_ADDR    (0x0UL)
+#define M71_TCML_MAX_SIZE           (0x80000U) /* Could configure to 512KB TCML */
 
 #define FLEXSPI_AHB_ADDR            (0x28000000UL)
 #define FLEXSPI_AHB_SIZE            (0x8000000UL)
diff --git a/arch/arm/mach-imx/imx9/imx_bootaux.c b/arch/arm/mach-imx/imx9/imx_bootaux.c
index d3494a9baa9..ce43f6bc3a8 100644
--- a/arch/arm/mach-imx/imx9/imx_bootaux.c
+++ b/arch/arm/mach-imx/imx9/imx_bootaux.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2022 NXP
+ * Copyright 2022, 2026 NXP
  */
 
 #include <command.h>
@@ -16,11 +16,16 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define CORE_CM33	0
+#define CORE_CM7	1
+#define CORE_CM71	7
+#define CORE_CM33S	8
+
 int arch_auxiliary_core_check_up(u32 core_id)
 {
 	struct arm_smccc_res res;
 
-	arm_smccc_smc(IMX_SIP_SRC, IMX_SIP_SRC_MCU_STARTED, 0, 0,
+	arm_smccc_smc(IMX_SIP_SRC, IMX_SIP_SRC_MCU_STARTED, 0, core_id,
 		      0, 0, 0, 0, &res);
 
 	return res.a0;
@@ -32,7 +37,7 @@ int arch_auxiliary_core_down(u32 core_id)
 
 	printf("## Stopping auxiliary core\n");
 
-	arm_smccc_smc(IMX_SIP_SRC, IMX_SIP_SRC_MCU_STOP, 0, 0,
+	arm_smccc_smc(IMX_SIP_SRC, IMX_SIP_SRC_MCU_STOP, 0, core_id,
 		      0, 0, 0, 0, &res);
 
 	return 0;
@@ -42,17 +47,48 @@ int arch_auxiliary_core_up(u32 core_id, ulong addr)
 {
 	struct arm_smccc_res res;
 
-	if (!addr)
-		return -EINVAL;
-
 	printf("## Starting auxiliary core addr = 0x%08lX...\n", addr);
 
-	arm_smccc_smc(IMX_SIP_SRC, IMX_SIP_SRC_MCU_START, addr, 0,
+	arm_smccc_smc(IMX_SIP_SRC, IMX_SIP_SRC_MCU_START, addr, core_id,
+		      0, 0, 0, 0, &res);
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_SCMI_FIRMWARE)
+int arch_auxiliary_core_prepare(u32 core_id)
+{
+	struct arm_smccc_res res;
+
+	printf("## Preparing auxiliary core: %d\n", core_id);
+
+	arm_smccc_smc(IMX_SIP_SRC, IMX_SIP_SRC_MCU_PREP, 0, core_id,
+		      0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+int arch_auxiliary_core_prepared(u32 core_id)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(IMX_SIP_SRC, IMX_SIP_SRC_MCU_PREPED, 0, core_id,
 		      0, 0, 0, 0, &res);
 
+	return res.a0;
+}
+#else
+int arch_auxiliary_core_prepare(u32 core_id)
+{
 	return 0;
 }
 
+bool arch_auxiliary_core_prepared(u32 core_id)
+{
+	return true;
+}
+#endif
+
 static inline bool check_in_ddr(ulong addr)
 {
 	int i;
@@ -69,26 +105,42 @@ static inline bool check_in_ddr(ulong addr)
 	return false;
 }
 
-static inline bool check_in_tcm(ulong addr, bool mcore_view)
+static inline bool check_in_tcm(u32 core_id, ulong addr, bool mcore_view)
 {
 	if (mcore_view) {
-		if ((addr >= TCML_BASE_MCORE_SEC_ADDR &&
-		     addr < TCML_BASE_MCORE_SEC_ADDR + TCML_SIZE) ||
-		    (addr >= TCMU_BASE_MCORE_SEC_ADDR &&
-		     addr < TCMU_BASE_MCORE_SEC_ADDR + TCMU_SIZE))
-			return true;
-
-		if ((addr >= TCML_BASE_MCORE_NSEC_ADDR &&
-		     addr < TCML_BASE_MCORE_NSEC_ADDR + TCML_SIZE) ||
-		    (addr >= TCMU_BASE_MCORE_NSEC_ADDR &&
-		     addr < TCMU_BASE_MCORE_NSEC_ADDR + TCMU_SIZE))
-			return true;
+		if (core_id == CORE_CM33 || core_id == CORE_CM33S) {
+			if ((addr >= TCML_BASE_MCORE_SEC_ADDR &&
+			     addr < TCML_BASE_MCORE_SEC_ADDR + TCML_SIZE) ||
+			    (addr >= TCMU_BASE_MCORE_SEC_ADDR &&
+			     addr < TCMU_BASE_MCORE_SEC_ADDR + TCMU_SIZE))
+				return true;
+
+			if ((addr >= TCML_BASE_MCORE_NSEC_ADDR &&
+			     addr < TCML_BASE_MCORE_NSEC_ADDR + TCML_SIZE) ||
+			    (addr >= TCMU_BASE_MCORE_NSEC_ADDR &&
+			     addr < TCMU_BASE_MCORE_NSEC_ADDR + TCMU_SIZE))
+				return true;
+		} else if (core_id == CORE_CM7 || core_id == CORE_CM71) {
+			if (addr >= M7_TCML_BASE_MCORE_ADDR &&
+			    addr < M7_TCML_BASE_MCORE_ADDR + M7_TCML_MAX_SIZE)
+				return true;
+		}
 	} else {
-		if ((addr >= TCML_BASE_ADDR &&
-		     addr < TCML_BASE_ADDR + TCML_SIZE) ||
-		    (addr >= TCMU_BASE_ADDR &&
-		     addr < TCMU_BASE_ADDR + TCMU_SIZE))
-			return true;
+		if (core_id == CORE_CM33 || core_id == CORE_CM33S) {
+			if ((addr >= TCML_BASE_ADDR &&
+			     addr < TCML_BASE_ADDR + TCML_SIZE) ||
+			    (addr >= TCMU_BASE_ADDR &&
+			     addr < TCMU_BASE_ADDR + TCMU_SIZE))
+				return true;
+		} else if (core_id == CORE_CM7) {
+			if (addr >= M7_TCML_BASE_ADDR &&
+			    addr < M7_TCML_BASE_ADDR + M7_TCML_MAX_SIZE)
+				return true;
+		} else if (core_id == CORE_CM71) {
+			if (addr >= M71_TCML_BASE_ADDR &&
+			    addr < M71_TCML_BASE_ADDR + M7_TCML_MAX_SIZE)
+				return true;
+		}
 	}
 	return false;
 }
@@ -102,7 +154,7 @@ static inline bool check_in_flexspi(ulong addr)
 }
 
 #if IS_ENABLED(CONFIG_AHAB_BOOT)
-static int authenticate_auxcore_container(ulong addr, ulong *entry)
+static int authenticate_auxcore_container(u32 core_id, ulong addr, ulong *entry)
 {
 	struct container_hdr *phdr;
 	int i, ret = 0;
@@ -115,7 +167,8 @@ static int authenticate_auxcore_container(ulong addr, ulong *entry)
 		return -EINVAL;
 	}
 
-	if (!check_in_ddr(addr) && !check_in_tcm(addr, false) && !check_in_flexspi(addr)) {
+	if (!check_in_ddr(addr) && !check_in_tcm(core_id, addr, false) &&
+	    !check_in_flexspi(addr)) {
 		printf("Error: Container's address is invalid\n");
 		return -EINVAL;
 	}
@@ -148,7 +201,7 @@ static int authenticate_auxcore_container(ulong addr, ulong *entry)
 					    i * sizeof(struct boot_img_t));
 
 		/* Check Core ID of M core */
-		if ((img->meta & 0xff) != 0) {
+		if ((img->meta & 0xff) != core_id) {
 			printf("Error: Wrong Image core ID, meta = 0x%x\n", img->meta);
 			ret = -EFAULT;
 			break;
@@ -164,7 +217,8 @@ static int authenticate_auxcore_container(ulong addr, ulong *entry)
 				break;
 			}
 		} else {
-			if (!check_in_ddr(img->dst) && !check_in_tcm(img->dst, false)) {
+			if (!check_in_ddr(img->dst) &&
+			    !check_in_tcm(core_id, img->dst, false)) {
 				printf("Error: Invalid Image[%u] load address 0x%llx\n",
 				       i, img->dst);
 				ret = -EFAULT;
@@ -218,6 +272,12 @@ static int do_bootaux_cntr(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_SUCCESS;
 	}
 
+	up = arch_auxiliary_core_prepared(core);
+	if (!up) {
+		printf("## Not prepared, run 'prepaux [coreid]' first\n");
+		return CMD_RET_FAILURE;
+	}
+
 	addr = simple_strtoul(argv[1], NULL, 16);
 
 	if (!addr)
@@ -225,13 +285,13 @@ static int do_bootaux_cntr(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	printf("Authenticate auxcore container at 0x%lx\n", addr);
 
-	ret = authenticate_auxcore_container(addr, &entry);
+	ret = authenticate_auxcore_container(core, addr, &entry);
 	if (ret) {
 		printf("Authenticate container failed %d\n", ret);
 		return CMD_RET_FAILURE;
 	}
 
-	if (!check_in_ddr(entry) && !check_in_tcm(entry, true) &&
+	if (!check_in_ddr(entry) && !check_in_tcm(core, entry, true) &&
 	    !check_in_flexspi(entry)) {
 		printf("Error: Image's entry 0x%lx is invalid\n", entry);
 		return CMD_RET_FAILURE;
@@ -281,12 +341,20 @@ static int do_bootaux(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_SUCCESS;
 	}
 
+	up = arch_auxiliary_core_prepared(core);
+	if (!up) {
+		printf("## Not prepared, run 'prepaux [coreid]' first\n");
+		return CMD_RET_FAILURE;
+	}
+
 	addr = simple_strtoul(argv[1], NULL, 16);
 
-	if (!addr)
+	if ((core != CORE_CM7 && core != CORE_CM71) && !addr) {
+		printf("Invalid address 0x%lx for core: %d\n", addr, core);
 		return CMD_RET_FAILURE;
+	}
 
-	if (!check_in_ddr(addr) && !check_in_tcm(addr, true) && !check_in_flexspi(addr)) {
+	if (!check_in_ddr(addr) && !check_in_tcm(core, addr, true) && !check_in_flexspi(addr)) {
 		printf("Error: Image's address 0x%lx is invalid\n", addr);
 		printf("     Address should be memory from M core view,\n"
 			   "     For example: 0x1ffe0000 for TCML in secure\n");
@@ -305,14 +373,21 @@ static int do_stopaux(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
 	int ret, up;
+	u32 core = 0;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	if (argc > 2)
+		core = simple_strtoul(argv[2], NULL, 10);
 
-	up = arch_auxiliary_core_check_up(0);
+	up = arch_auxiliary_core_check_up(core);
 	if (!up) {
 		printf("## Auxiliary core is already down\n");
 		return CMD_RET_SUCCESS;
 	}
 
-	ret = arch_auxiliary_core_down(0);
+	ret = arch_auxiliary_core_down(core);
 	if (ret)
 		return CMD_RET_FAILURE;
 
@@ -325,6 +400,41 @@ U_BOOT_CMD(
 	"<address> [<core>]\n"
 	"   - start auxiliary core [<core>] (default 0),\n"
 	"     at address <address>\n"
+	"     <core>:\n"
+	"         0 - CM33\n"
+	"         1 - CM70\n"
+	"         7 - CM71\n"
+	"         8 - CM33 Sync\n"
+);
+
+static int do_prepaux(struct cmd_tbl *cmdtp, int flag, int argc,
+		      char *const argv[])
+{
+	int ret;
+	u32 core = 0;
+
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	core = simple_strtoul(argv[1], NULL, 10);
+
+	ret = arch_auxiliary_core_prepare(core);
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
+
+U_BOOT_CMD(
+	prepaux, CONFIG_SYS_MAXARGS, 1,	do_prepaux,
+	"prepare auxiliary core",
+	"[<core>]\n"
+	"   - prep auxiliary core [<core>] (default 0),\n"
+	"     <core>:\n"
+	"         0 - CM33\n"
+	"         1 - CM70\n"
+	"         7 - CM71\n"
+	"         8 - CM33 Sync\n"
 );
 
 #if IS_ENABLED(CONFIG_AHAB_BOOT)
@@ -334,6 +444,11 @@ U_BOOT_CMD(
 	"<container_address> [<core>]\n"
 	"   - start auxiliary core [<core>] (default 0),\n"
 	"     with signed container image at address <address> in A core view\n"
+	"     <core>:\n"
+	"         0 - CM33\n"
+	"         1 - CM70\n"
+	"         7 - CM71\n"
+	"         8 - CM33 Sync\n"
 );
 #else
 U_BOOT_CMD(
@@ -342,5 +457,10 @@ U_BOOT_CMD(
 	"<address> [<core>]\n"
 	"   - start auxiliary core [<core>] (default 0),\n"
 	"     at address <address> of auxiliary core view\n"
+	"     <core>:\n"
+	"         0 - CM33\n"
+	"         1 - CM70\n"
+	"         7 - CM71\n"
+	"         8 - CM33 Sync\n"
 );
 #endif
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 3f71f0ee6e9..372dfc5518e 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -247,7 +247,38 @@ static struct mm_region imx9_mem_map[] = {
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-	}, {
+	},
+#if IS_ENABLED(CONFIG_IMX94)
+	{
+		/* M71 TCM */
+		.virt = 0x202c0000UL,
+		.phys = 0x202c0000UL,
+		.size = 0x80000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	},
+	{
+		/* M33S TCM */
+		.virt = 0x209c0000UL,
+		.phys = 0x209c0000UL,
+		.size = 0x80000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	},
+	/* 644K netc ocram for rpmsg buffer */
+	{
+		/* M33S NETC OCRAM */
+		.virt = 0x20800000UL,
+		.phys = 0x20800000UL,
+		.size = 0xa1000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	},
+#endif
+	{
 		/* OCRAM */
 		.virt = 0x20480000UL,
 		.phys = 0x20480000UL,
diff --git a/include/imx_sip.h b/include/imx_sip.h
index 8a5ca34f393..478cbd3fdaf 100644
--- a/include/imx_sip.h
+++ b/include/imx_sip.h
@@ -16,5 +16,7 @@
 #define IMX_SIP_SRC_MCU_START	0x00
 #define IMX_SIP_SRC_MCU_STARTED	0x01
 #define	IMX_SIP_SRC_MCU_STOP	0x02
+#define	IMX_SIP_SRC_MCU_PREP		0x04
+#define	IMX_SIP_SRC_MCU_PREPED		0x05
 
 #endif
-- 
2.34.1

