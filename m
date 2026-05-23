Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA394CD5BB1
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 12:23:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CF8984825;
	Sat, 23 May 2026 14:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oMKx/yxP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 239FF84879; Sat, 23 May 2026 14:23:10 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1095983E81
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 14:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=koOpzqe15aFPUYe2hxZ2U3pxCGnIMWGSA8u/+Waldj5CtobiGSTjMNLUBw/JTBJFQNbj+KACVcaw80uLrW9EmWaVxa8NZNWIsYjWTW5m+hCFfPqve1WKOhxJxhO5xJCjxMaplYyrxKChyXAPSpKEp22TSs2FbkW09DLs3q4qgeDCXBpkSqSAZ/iWhqmchpO2OoEK2NLgw/MNA7kWabBvmtKTFqIGdB3wqd6WFHFitVpzc0Z42gmEP1gcacRvocWSFn/76Q9NjalZLmgLQUqMVBx0FMcFLWt0WvBCOxznpY3rZLTw/lVD1CHDMrgtZ4041JuFOrq5EhZvPoJIc4Oygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1uIebGwAW7cuwdMEDlyv5+JJ4/28JITa3e0RhZ6Rws=;
 b=hkLlER/E/OyWm9X4pdawsXTBPQ4YDdLZHedl4BeSNavQ70pOmJwPgEQCFVnqs+wOfhI9lW7+gWF9t3iQvoHGgAE5n3ZGl+Anrxj7+XmnVIQm+cs4caXKw78d52N3cHN/R5BpkJPD108nz2y/CVfm6CwCQC7hPHMVg73pltPyKlX4c9+HTvkXDw4cQ258L4MPLQn36jVuvgz3D6FcpZJWr9i8XBn/woErkBNyqhwkBtxy5PsCvYjyM25SoCrZd+MnjPnKNzILJn2TXfFjGEvG45yNxp7oTcyrsbVSNKbnOdbJFMLLP11qYAFRjE8U+zMUE3D424RemRc+CNvNR5VlDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1uIebGwAW7cuwdMEDlyv5+JJ4/28JITa3e0RhZ6Rws=;
 b=oMKx/yxPMAhov5ZzzpYzK3JTTIWhUIQyS4V+BlBTfYQhLiAGU3hcb+rzRxBw0JPKuDLbstE6FLVX0Ak5MNecdlbcW43BBfsIiKaWlxXu6Jd+MneXCyaqf5+Cfe/AFnJqThY6WZlrJGqgrek8Pwn7GCCtwohqy69xm4mow5zmZWW8EM1jk/kvl26sDeKu6QEitxKVfGDkE8kpUJMVoloitApXMQiZ+i9q14WMHS16wKzWf7H2pd266eWHq9ajyOq6+ey8tHuka/weAPrNL3klgsm8PNaqy8r3/cYZm7OaC5N/hmPVOUUDfcqroYtfp1IbqO56mq50nGKcQh2uahoUCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GV4PR04MB11976.eurprd04.prod.outlook.com (2603:10a6:150:2e9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 12:23:02 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 12:23:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 00/13] imx: Use livetree API and cleanup
Date: Sat, 23 May 2026 21:39:43 +0800
Message-Id: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB+uEWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyND3czcCt3czOJkXcMUC+NEy+S0VIPkVCWg8oKi1LTMCrBR0bG1tQB
 hk9MsWgAAAA==
X-Change-ID: 20260521-imx-misc-1d83a9cfe0ce
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
X-MS-Office365-Filtering-Correlation-Id: 1719dbc1-b121-4a72-a41b-08deb8c608d8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|18002099003|56012099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: a5ADL76fCT4U9d4j7kRsUbi1FO/FDx9kZMZu8nPdS0ZLsvPk0wMfHJHa2lcC3MM5O6001G4OZCsKzznqQvu6EYc+upqjKMCc+RexSOrvlR9nv5adX3uMOy4Gt2BtQk46bz5rfnOKf0jaVi7MRTlh2cgZbdf4zzSjBWxtfzY8LRw27Xcsjf89px9zMr1q0GSpP7rsuazgGswfuHgkHqtg1mx7ekyWh8h0ujPa/PPP/y/NzA0MlF8Wl2/3isEQkUWvWA5hUP6YpgS1xr2m0xn6Pj6bx+VBvJ2FXOb96Xk3TB7gLrjjRQ4jYjsVKveRNPFxOEEa5j1J3A/i85ZuEb3I2IfQ/djpTEGCRrXL5N6ZpN/hnJsJdZTxIAFImQKeYiOg7fwqVavq65ehQZBPUiSAlukjp6Lb+1FlxSoaEQ+MlbQLfGXtHVnkuaHg4tXETLjmYawwSuywRLXfYxWcWCvZo0Zec0RwTqNqPJHC/E53/ahzwoWuZztVdE4vBqMzyhyBAliPEOKRChRY8SWk3zhNZjMNnFwWjWz51Rbmplw/4NW/E9LYuOxHnMbWNcSKhsQkdlW8axQi6PWcX88LDE9YMlYUjFlFSUO8y0do5aAf9R75ExzYaHF/arfP5Lthb1vRftTKdqjgmBRSVcKIJu+Rpq1J39dMldKdTWD1wauDmcJmlSymJii6B1G2yJjc4ZKaNo1oquhZDrY1AEsBB6QSXoGo2KXg2VqxchbGcOxNGEkAmW5MbyqvViMkrK9ThEzu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(18002099003)(56012099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWdmTFNrNmZSVW9yeVRFRmZQbm5ocjVUL2lJb092ajg2OWRJVzU5c3J3N0JG?=
 =?utf-8?B?NUFwWm5FZ0tvTmlSeU5wVkF1eWNWalA4cHQ0ZnhnamloemlNWDBXRFVONTU3?=
 =?utf-8?B?bXdaclpiaHMrQmFEeG9LTWc3QjlmbHdqRThLZnNJVDVvNGhuTVZhZWdBZnJP?=
 =?utf-8?B?bzBiYUxiREFKZnRzKzFLVmxsME03dUZ5OUM5N3V6b3VPcjl4TlpMdlZhV1Ru?=
 =?utf-8?B?OE9YK21ReGI1TmpOQ3g5NldCMFBxRzRqY0lncThiQkxPWEthNHhPb0ZrRE9N?=
 =?utf-8?B?OFRGMTFEVW5kYSs0OEQ5MXpHaUplZEVtaTlHTDlndDNzSTlIUnN3Rk9zRGxD?=
 =?utf-8?B?a2VOZ2w1QkNsTHdVdTlHUWFPN2RSTGhnTkpWTnlzOWV3Q01Hb1FxYVdRa3Zq?=
 =?utf-8?B?azNzcjR2VDIxd2lGNDhXRUl3YkhQUWhsd1Z2bTUrR3RFOFlJSk1sTHNZSjR2?=
 =?utf-8?B?T3NWcVprNDNrQ21TSXorbkQxMTROU1VScUhnamh0R004OVFVc3NlVXZ3TGFT?=
 =?utf-8?B?VW5CbHZTdG5uQzh6OFdVQXRoL0NocUVUVStmSEZKbDgxV3ZvV1dwUk1neHlL?=
 =?utf-8?B?U3J5djNpZ2FTOXFqUzZLMm9POE9MN2xGbDdiVndJUXRDOFFkTW5EbSt6ckcy?=
 =?utf-8?B?QU05UnFmd1gzbjNqRHFWUms3a04xWVFYNFVWd1pCZ1J3WS9TV1luNldyREs4?=
 =?utf-8?B?NXhSbU1FeGk5RWVibjJDQzJRNXBoYzgxU2tJdGRFMFh1L3RzQWpYS0swM0to?=
 =?utf-8?B?NXNpakcxVkRZMmp3VWlQR0dXN3pZdndvM2hRUDA1cmNrZGdGZjJuMEE3ZjRt?=
 =?utf-8?B?QnFKRURkK2x1TmtITmdNdGZHM3dWUlk2L1FabE44Y21CandNcGE1RnhnSDdi?=
 =?utf-8?B?eWFHREtTbTJBZjJMV0U5OUlTYldIYkhjVlNCd0xyS0xESUVqNzErVnE0KzVi?=
 =?utf-8?B?UWROUmZDNm9FUGplQmVjRUoyUklYTks2cTJtMmpiSFBiWWJCRUloVkZzeE5B?=
 =?utf-8?B?VFBFbzh0VWE2blMyM1FPYlQxVjFZTGxFdUVWMVladFJqSlVlamhFb0k4em5w?=
 =?utf-8?B?TUFGZWt5N1Ficlo1WG1xYWVkR0xFakNFdVZYZVFTcTdsR1dVa0NlMWZ6dmxL?=
 =?utf-8?B?Nys1ZDBFempaRktJYnpidXczbHJ4Sk5xYW40Tm5vb2tDd1BEMHFDaWIyUW9u?=
 =?utf-8?B?a1VtMkZ2c3pEUGJacFF1YlQ5NyswR3FjQk5zWUxWNHJMOE9xalJ4eU9RVStG?=
 =?utf-8?B?QkR3aSszdS9OWDVnQ3dVQ1NQWVptSFRVK2hJWTI3bTFkLzdOelh5dGl4cFdk?=
 =?utf-8?B?bUprbUJUOEhUVmhzcXpQeVIrNDB2alBBTGpDM0tUR0hyb3pIbkJWVzVjQ2xY?=
 =?utf-8?B?MTRtRDdsVk9NZ1J4aGdpa3l6eTJiZWdaVkxsWGhlMjdWZXpZOWVuWDdYUlhY?=
 =?utf-8?B?QnlsckZwcU1CTjRxRnY3OFZ0R2RlcnNETHlEQmpaei9tL2Z1emFkeGpxeHox?=
 =?utf-8?B?K29zZzF1K1VIaFZHQTlLeit0aEUrNXhuNUhVNW91L2tzRG9QSmRLMTBiSWh3?=
 =?utf-8?B?eVlRYTZpNStUdlEvOER0YlRGLzF0MHhRdUtCZ2tYODBIc2NiMWhKS2pZYXMw?=
 =?utf-8?B?REJEU3lIRmpGbm16dThYVW12Rmw4eTd6N3FiZmtnTHJnaHo4MDY3VEw4T1pU?=
 =?utf-8?B?dEN6V2ZPS1g1d04yTVhVcVVIb2hTOW9XYXVWWjkwSFY5V2hnVWwvUWs4blBQ?=
 =?utf-8?B?UkRtRlVaZHBiV1JtTjJpbDlJclhOMjhzdU1qU0JWTVRVQWNSaE1iQ1ZNa1Yy?=
 =?utf-8?B?cHRIQm1aVExXa0krc2pqZC9uWHNSZWhRRnViTUkrZUJRSWNIYWZjVjBVbDFt?=
 =?utf-8?B?cXdLWTRicnRvRmw4bjNoVkRRc2NhSHpVU0c3MWJBdURnZnI5VzBiU29tR0xI?=
 =?utf-8?B?eWhFSzZnWGxDY0JYRXRwVDJUTThpSlQ2OFcyTjc1MnF1M05BWUJjUWh4UHZj?=
 =?utf-8?B?MDJFbjI2dFYyWWNFTnhkRXI2M0xqdmRYL3czcy8zZzI3bHlOYlJXSjR6ODlV?=
 =?utf-8?B?ZjFESW9pYXBCalA3QWJzNFBKT3NPRjVZb09KVnBjalNXR1l5c0J3cG5JMWtD?=
 =?utf-8?B?TE0xYmtsZXliWTl2ZWx2N0R2QXZlNkViMGd1Smc0dDNUWWZCRXRFUWJqM0po?=
 =?utf-8?B?SVgyU1pjSWFqdXpiamllckxLY1ZRV1Z3WG13Z1dUa3plcThYRk8xNkxlR1Zm?=
 =?utf-8?B?QmlGRFBuRU9ZSmswN21RaEYxbWY1aXpkYWZGSk1sUExiRGZnNC92TXN1SVV5?=
 =?utf-8?B?c3RNakpVdERkdFFXQ3dmajVaYk5RRVlZRlUzcHROU3c1aytiVW5XQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1719dbc1-b121-4a72-a41b-08deb8c608d8
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 12:23:02.6644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pq2l7vIXZ3juZgZKhFL/O/YY4plhPAuBIxCPjbXEg6BJxpByqzBn311CxabGAS0kkFISj9LoHs89iYVDQHT0CA==
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

This is a misc patchset mainly for supporting livetree API for i.MX9 and
cleanup get_imx_type. While working on this patchset, there are a few
minor other updates

Patch 1: IMX_TMU depends on DM_THERMAL, so imply DM_THERMAL to make sure
         IMX_TMU is selected.
Patch 2: Update imx952 gpio reg.
Patch 3-6: Cleanup get_imx_type
Patch 7: Update ddr firmware name
Patch 8-13: Enable OF_LIVE for i.MX9 and i.MX8M_EVK. With OF_LIVE, boot
time could be saved.

More information could be found in patch commit log.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (13):
      imx8m: Imply DM_THERMAL
      imx952: Update gpio node regs
      imx9: scmi: Drop get_imx_type
      imx8ulp: cleanup get_imx_type
      imx7ulp: cleanup get_imx_type
      imx: Guard print_cpuinfo with !CONFIG_IS_ENABLED(CPU)
      imx8m: dts: Update ddr firmware name
      serial: lpuart: Use livetree API for fdt access
      gpio: imx_rgpio2p: Use dev_read_addr_index
      misc: ele: Use dev_read_addr
      imx9: soc: Use livetree API for fdt access
      imx8m_evk: Select OF_LIVE
      imx9: Select OF_LIVE

 arch/arm/dts/imx8mm-u-boot.dtsi               |  8 ++--
 arch/arm/dts/imx8mn-u-boot.dtsi               |  8 ++--
 arch/arm/dts/imx8mq-u-boot.dtsi               |  8 ++--
 arch/arm/dts/imx952-u-boot.dtsi               |  8 ----
 arch/arm/mach-imx/cpu.c                       | 56 +--------------------------
 arch/arm/mach-imx/imx8m/Kconfig               |  1 +
 arch/arm/mach-imx/imx8ulp/soc.c               |  8 +---
 arch/arm/mach-imx/imx9/Kconfig                |  1 +
 arch/arm/mach-imx/imx9/scmi/common.h          |  4 --
 arch/arm/mach-imx/imx9/scmi/soc.c             | 10 -----
 arch/arm/mach-imx/imx9/soc.c                  | 10 +++--
 arch/arm/mach-imx/mx7ulp/soc.c                |  8 +---
 configs/imx8mm-cl-iot-gate-optee_defconfig    |  1 -
 configs/imx8mm-cl-iot-gate_defconfig          |  1 -
 configs/imx8mm-icore-mx8mm-ctouch2_defconfig  |  1 -
 configs/imx8mm-icore-mx8mm-edimm2.2_defconfig |  1 -
 configs/imx8mm-mx8menlo_defconfig             |  1 -
 configs/imx8mm-phygate-tauri-l_defconfig      |  1 -
 configs/imx8mm_beacon_defconfig               |  1 -
 configs/imx8mm_beacon_fspi_defconfig          |  1 -
 configs/imx8mm_evk_defconfig                  |  2 +-
 configs/imx8mm_evk_fspi_defconfig             |  2 +-
 configs/imx8mm_phg_defconfig                  |  1 -
 configs/imx8mm_venice_defconfig               |  1 -
 configs/imx8mn_beacon_2g_defconfig            |  1 -
 configs/imx8mn_beacon_defconfig               |  1 -
 configs/imx8mn_beacon_fspi_defconfig          |  1 -
 configs/imx8mn_ddr4_evk_defconfig             |  2 +-
 configs/imx8mn_evk_defconfig                  |  2 +-
 configs/imx8mn_venice_defconfig               |  1 -
 configs/imx8mp-libra-fpsc_defconfig           |  1 -
 configs/imx8mp_beacon_defconfig               |  1 -
 configs/imx8mp_evk_defconfig                  |  1 +
 configs/imx8mp_rsb3720a1_4G_defconfig         |  1 -
 configs/imx8mp_rsb3720a1_6G_defconfig         |  1 -
 configs/imx8mp_venice_defconfig               |  1 -
 configs/imx8mq_cm_defconfig                   |  1 -
 configs/imx8mq_evk_defconfig                  |  2 +-
 configs/imx8mq_phanbell_defconfig             |  1 -
 configs/imx8mq_reform2_defconfig              |  1 -
 configs/kontron-sl-mx8mm_defconfig            |  1 -
 configs/kontron_pitx_imx8m_defconfig          |  1 -
 configs/librem5_defconfig                     |  1 -
 configs/phycore-imx8mm_defconfig              |  1 -
 configs/phycore-imx8mp_defconfig              |  1 -
 configs/pico-imx8mq_defconfig                 |  1 -
 configs/toradex-smarc-imx8mp_defconfig        |  1 -
 configs/verdin-imx8mm_defconfig               |  1 -
 configs/verdin-imx8mp_defconfig               |  1 -
 drivers/gpio/imx_rgpio2p.c                    |  4 +-
 drivers/misc/imx_ele/ele_mu.c                 |  2 +-
 drivers/serial/serial_lpuart.c                | 15 ++++---
 52 files changed, 40 insertions(+), 153 deletions(-)
---
base-commit: 21a3b9f03b05467ec7422399a92a43f89dd2b526
change-id: 20260521-imx-misc-1d83a9cfe0ce

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

