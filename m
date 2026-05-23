Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C661CD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 12:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C27F784884;
	Sat, 23 May 2026 14:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lyfbWCK4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED6CA84881; Sat, 23 May 2026 14:23:11 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A07F84874
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 14:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ts/Do7+6Aky9szTosuJZ/vVfYT+wXgHCuM/rRi+YRk3Ki9oYR0S/G/Oh0752woTsEe3k+UOIOWVgOPoM2glXqto2K5JVm/Grq+77i+Z9iSHEgNIigByVCwluiGnmM+ig/YwcNA5ZocQRiAwJC9S+JEgPwMTSwJMP2WWr99B0H2C8PjY2UDXUQKpdPUgQN/cXPRa2FY+j5ye+7TKYC408oGqn10g1bklf7v/OQfizc59unYaQM9ojDMD/veKnrzDPEEssMFsZ69I3NYevJwwVLgEPOXv0jGmNqel3VOCrRQKSKbSziUmGC7ZrizPCgI7g9drYd0vlNn9NbnMVYwhO9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pdVlV9UWfWoZFUoNpoidFDwTA2k1K7gy49xZDODRLg=;
 b=J5kvYDhBKBrDBaU7gV71ONc7hO1GgdOElPIiGfybw5/3KZq7nOmmTy6tVhKYEGml05d4GczwCpd1FfeztP3F8ouWfgfduaoJGNpZDYy9kNu86OBNZuoeLJza7a2c5NFi4nzhehFz0QNuGUwYtV/bTuonsczjQLt5fQ9PK8kUaeFy0erub1rvgw0Yui2Eew3ev0gHPLQz87aPH9jUuYE3Dnr+qz53BKQTlQ6z13uXqnmq+4GBRG872+1xppcaZ0dWLKcW8h+Pk19eLHLlAVpknjAlnYxzAOg75elwWFBcJEk1dn++TILdcGT8lCi+886a2Qndh/XTjSXyZOpjAtWgng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pdVlV9UWfWoZFUoNpoidFDwTA2k1K7gy49xZDODRLg=;
 b=lyfbWCK4ecuREA4UPBiqwLK77JY18ykGMw6nJq3wMvpdbTdNd+SVOETu7YZ9d8zx1KFrZ3o8ckszpr1aXCbJ3GI2LhyJmXAJpHnCVMrpNHT5R/PqUTbc8pFLEdM4bwMwa36ktrf/SUv8vxofccZwv8MRO0RhIId8CLzJRjb1NUCY0aifxTWwMcmxiQd7CHk99Wm0ItPGCy3FSCiOLU0KP6NVGjyEVWrapm4iZ++ybctbhC/SiAk1/KrUTEgckID/f4jeNUzXxRbjffi9+rtVGOi2QAGqpFKoYbVYVBxtvQEkwQ/XjsOjOp34OaLfx5k0qq0xtnism0usnjxwa3l9dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GV4PR04MB11976.eurprd04.prod.outlook.com (2603:10a6:150:2e9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 12:23:07 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 12:23:07 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 23 May 2026 21:39:45 +0800
Subject: [PATCH 02/13] imx952: Update gpio node regs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-imx-misc-v1-2-2898c9eca9f8@nxp.com>
References: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
In-Reply-To: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0255.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::6) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|GV4PR04MB11976:EE_
X-MS-Office365-Filtering-Correlation-Id: 63861e52-812a-45ca-57f7-08deb8c60bb2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|18002099003|22082099003|56012099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: R/5+uBgLTwleJ/Y7YwVq6hFm3RPF1E5L/qx3I7partfbCqVneWQIaMbQmcN/IkGMme33RI+VxpvgqvBHrn4a6lUr1xSCnsUYxLbtkOH2CubHpGSdPSdIgOotjrhxiygx/jQxOHb+Ygbd/h/gjCQ1P92t+TxecGh8NsByVTuIVIWF13D1NkQpQAuP2ZkKTu5+hOn+kd7Z9BIaEEriPAO4tUrmOJ9eENfe0uKavtbxKfxG/I+6FXLFqeccjg3KRR3wmd3Unaih9l7pledsQv9w8dkaJZd75VJ2qgGNtdCqnCM9+iLeRHsTTAbAgYybjSQI4Vbs5WAf+AdFxk0D8ayjfEyJv7gGAOyy+y7vzOQYvWOW7xUICPFk6gdXL9d8OFM+tSEakTxkkTJZ8ZQXWh4ljXXjeqjtbyCzdLEDmM+L+YAVybxDSCMsEzCWViB9AqitIbCOQc3xNlnb3sE1MqvW2BSQn80PmgH+VT2VTAwVieyaseTkbwo6FRSEjd77DYpmJh/0KO1Fq1YWj/150e/sE84OKoM1oPWvXFRiAmfQoiOo+DQZ91VHuL9ZOU1DGwegFeZP4szgSnJ5d09dndg20IV9NzyinV9EQfjH8fvK/RNdN5RpZLmztwhfUhpmrmmOYLBsM7BP6IaPLUscmGC/a1DgOtGYumtu5XYy2op65IO0R6WoqQrp7iu2QzNLhdHC/Q3J4o4UCh9Zdz0WO/Y44fO2ncVIvzeES8qseEvDHrZV4MEXjgXyNsJJ4qUSXI0j
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(18002099003)(22082099003)(56012099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXRVRko4TXE2OGR0UlBwVmZXbkdRWE9DNk1RUkNEVEVBZHRUdXljWFA0WDlo?=
 =?utf-8?B?TGRlT3dRdGxqcEhWK2tSZ29JbzZFVkpTa215VEk1ejVkVHZaWEhyRWlQZXVG?=
 =?utf-8?B?ek5XUGtzZS80RHkvL2xhYmxDS3MyVkNJOHFhckgzaXpZeERvSmhxS2JhVnJO?=
 =?utf-8?B?MklTcGdPcHE3R0tMWTVxVmJ2MnFvZis5N2o0T1FvZ2drYmk3bTdGMlZVVU1C?=
 =?utf-8?B?REpLM2xKa3poeGV6eWg5bkphL25mbjhqRnR1bGF0SlZHTFZKRFNUd1E1R0RW?=
 =?utf-8?B?MlRhWEl1WGxTcTVTQUNUVFZsQXQ0VFpmTzVET0U2WjVObGRJRGt1QThHNXlW?=
 =?utf-8?B?dSs5eGwzZWIrVG1rM3c1TUNLSGQ3RmF2SzllNW12VTMyaEFTcnZLdU80dm5D?=
 =?utf-8?B?dzNhOXl5c3o1emJWV1k0dVdJTG14QmpYTVlzQWJaOEo2a0g2U3kreExkbkY2?=
 =?utf-8?B?Y3VKMjcvM3VORktxekplMGpEQlovNlZsdG5HdWFFeCtHVGtPSnVKOHZRczUx?=
 =?utf-8?B?RmFXSzhURHVGNml6YjRUZ2ViUEFnWFZiUG90VzQ3dEc0L3NjWWNBdGtuMXZy?=
 =?utf-8?B?cDcvUkZ2QUVJT2NaUTl4cHl0OHdBVDJraldrZ2RzMTRQekZ5RXQzYzRxUHFi?=
 =?utf-8?B?NmNRT1BUVGd1cFl3RUU5WGE3TmJiWHlNbGZFTzBaUXJSeTZ6cDVEOUl1b0dt?=
 =?utf-8?B?MU5UTnE5djAzU2ppWkt1YVFjdWc3elNzMVhTU1dBVTN3MjBReHJTaDZSRGpu?=
 =?utf-8?B?MHc0bGxGdXEzVXFMaElkSnZ5SVJ3Q1VaN25mWEcwOVNuUFVITVdrTFN4aldu?=
 =?utf-8?B?MVpkTjE5Z3JPL2IwOTFPd1JmbTh3ajFUZ3hXeTAwaENQS0d6SHhveHZTT3hK?=
 =?utf-8?B?MXZoZkw4aGc0RTJWVTJnYW1wZVdDb1JQcVNnTHJTdFNaUHFKN0pJMktoTEJl?=
 =?utf-8?B?MVUzSHdHTXh2dW8xRkV0RnlaUHdQeHk4VzRCS2x0cEo3S2U3ZkYzRmEyRUZz?=
 =?utf-8?B?VHJralBnbDdoRVdOMm1HSDBsQUNtcXZRbW5EeU1LWDlYdzJIREVSbnJ2MTVC?=
 =?utf-8?B?ekI0eGw5K0ZoWW5MNkl4R1ZFMWk0eE1Cak5keHZlRE5IUUVsbDZXZm4rRjBj?=
 =?utf-8?B?dW8yUGZoMVhFN2VwMHZpRVJpcHlTdldHYkRhZ1M5a0pPUGdLWllUdWJxb3VK?=
 =?utf-8?B?ay9aUHNZQ09VeW91dnhoeFZLdkpjVS8xTG1HU2pwZy9Nd3J5WHBBS0owTDY4?=
 =?utf-8?B?RlJHQ2xCaUJDNnZqRi9SZjh5cGN3VWFQU2dkWjhMVEp1alBSdlNkaThRUEtZ?=
 =?utf-8?B?a1JhMjIxWktUNWdpOHZLa2Vqbit2bnJaNUl2QWlCZXJIblJMaFJTTGVZNEFp?=
 =?utf-8?B?SldBdVFKTGE1TlZIVGNyNWhYUlgwc3FtRlcxUGlaTXIvSmdPc2F2ZkJtaVZR?=
 =?utf-8?B?SEI0NDExRVZpajhIWnc0Nm0vZHFPT2lJNlYrWllkYzJUV3pNMHdBbnNZemdj?=
 =?utf-8?B?TjRFRE5ONGF5RjBSV2I4akRvOThHbGpLREZ5L3RJVGlxc0V2SWhMUzBJYVZh?=
 =?utf-8?B?MVNKN3VYNHZXTng3ZkQ4Z1VFUlBtZHRDR0ZCdllJZm5FQWk2TFpmaVJHWWtW?=
 =?utf-8?B?ZzF3b1kvamxLYUgwelNtQ010N1lSck9sNzlaVWI0Q1kyTVplU0pGKzdFbG1x?=
 =?utf-8?B?QnZIOE15aTVGcFQ3MG0wUXBPOVV3TWJPMkM1OG0zMDZaYU52eVFqR2pmUUR3?=
 =?utf-8?B?YXRqN0lLQWlsQnJ2blR4aTFaK2YzeVFFZk02dWRiSzdrVk1hSGVVbkZVcW9S?=
 =?utf-8?B?WG1ueloyL2pxSE5BNlQ3L3RCMkovODNVN2I1MnZCVVVKWUg4bkh6aFd2aWxw?=
 =?utf-8?B?cFRUcGFPNyszSXFNcDgyZ3dYZlpTOU1JQU1MU3VLKzBRS1U1WStnZktMTGdM?=
 =?utf-8?B?MnQycEV5T0ppUmlzZzVySEJzN3JIREFwMlJhNEhiNzhSV3BvNWFiNlcyblJN?=
 =?utf-8?B?Zy82ZUlVOWdiTUZnTy8xQ25PdGlqQ2FmalM5U1lzTzloazFjRE9MdmJ3aEkx?=
 =?utf-8?B?eFFTTG83WmI1d0wyS21RSTErRW41RzlOeis5dDJESHRudHF4SFdvem5lOWcv?=
 =?utf-8?B?MFJjL0VoSFBpdGM0QzZIZGFuUDJkRGhRTzBxU1UzaFlwblRwMGpCU2xQM1c0?=
 =?utf-8?B?bHB6UDlWWWtjZm1saXNhM3QzMERDcEtFcWgzUW0vTWFWUUo5ZE1iZTdOSGVB?=
 =?utf-8?B?b1RlblV5N1RoM2hnbVJiWW5sOXU1dlhKRXVJTWNZVmFUVUd3VEJxSEk1SXRh?=
 =?utf-8?B?UktZRVNENGVvazFUdXpzOUwvOHB6U2JIQ0dwcnlkMithWDJQWXN0dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63861e52-812a-45ca-57f7-08deb8c60bb2
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 12:23:07.3251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxzIxM2i5fAylPeUDD8wriLVaXLhSF5VqdfNiw9rP8cCctgySBj94jAwivGMJoEMtKWSQM5ROJRadZzaZcxEnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11976
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

From: Peng Fan <peng.fan@nxp.com>

Same to 85319b2e672 ("board: toradex: smarc-imx95: remove gpio1 reg"),
there is no need to use dual base for i.MX952 gpio, so drop the U-Boot
specific reg changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx952-u-boot.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/dts/imx952-u-boot.dtsi b/arch/arm/dts/imx952-u-boot.dtsi
index e977014992e..34bb912da4d 100644
--- a/arch/arm/dts/imx952-u-boot.dtsi
+++ b/arch/arm/dts/imx952-u-boot.dtsi
@@ -171,12 +171,7 @@
 	bootph-all;
 };
 
-&gpio1 {
-	reg = <0 0x47400000 0 0x1000>, <0 0x47400040 0 0x40>;
-};
-
 &gpio2 {
-	reg = <0 0x43810000 0 0x1000>, <0 0x43810040 0 0x40>;
 	bootph-pre-ram;
 	/*
 	 * Use one SPL/U-Boot for mx952evk and mx952evkrpmsg, since GPIO2
@@ -186,17 +181,14 @@
 };
 
 &gpio3 {
-	reg = <0 0x43820000 0 0x1000>, <0 0x43820040 0 0x40>;
 	bootph-pre-ram;
 };
 
 &gpio4 {
-	reg = <0 0x43840000 0 0x1000>, <0 0x43840040 0 0x40>;
 	bootph-pre-ram;
 };
 
 &gpio5 {
-	reg = <0 0x43850000 0 0x1000>, <0 0x43850040 0 0x40>;
 	bootph-pre-ram;
 };
 

-- 
2.51.0

