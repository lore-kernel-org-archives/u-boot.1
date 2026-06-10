Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542A8CD8CA8
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 01:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA9A1849AA;
	Wed, 10 Jun 2026 03:54:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eBn8Wkbk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9662849AC; Wed, 10 Jun 2026 03:54:55 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E630848D7
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 03:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u46GSLjwgFFfEVeCKoy4IiYl/N6TX9gAf12nv4r9GT/cIaIOS2yVo0JsTlcjJ9qHOshqMugXMGEtHZ4aV5YOf6WNRkdyjq8YlE7JOmWBWK+hifU5lRo5KUT8lQU1gE3X27CZ7deFIOJ73BaKUp4lbwXZYsMQpXEck7nvADxn/2qxNdliPuhqoDz9qpLKF/QOVbk2IUbQfIzv3gBFWvUHaHvU4OjCR/a4kcy3Urp3uNYvEX5V6K8tvHozXvh8ppLPiCC5Vv6ZVhP+ZQThcojEgVEdeqpZMfFppTaDUntao+OFJYhVnVkisEi+h8VFmO1C1ZZdhbeLh+DgzTARM9I8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoNfthVO8c4ekutnau88j5gH4uGyiQfZSue0AdPoxIQ=;
 b=KGhoifvwb+xlS6BKEeIle5KhLw+2u4XIPXPVD4VtPKwlS6zLr+QMWbcOvEr9uYvPwv38alF7NgaJmZbad0uOtoQTfwJxVFv0UEuO1VV6jeNAYf75JfXZoCYeJwpK4pkCjfZKW7wEVA8ry6Ge4+3I99cN3i0h+g3Qe2MHF1oBbE7l0BybwepnIozwM8tZ4FurugYdXhhOEiLUp8ICk1c2y9Nx8HirNTTbNGoSLTusNB2KdqOs+pABV5PLNMDn5xiLTgw8kOD05yvhLWS07xvTDRIB926vQ0sSjkZkq4gTA5VWIeoIrluYW4OZMWe1jTA1W06FtRTWttbMVgGgLFj0Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoNfthVO8c4ekutnau88j5gH4uGyiQfZSue0AdPoxIQ=;
 b=eBn8WkbkxilHUYITEWvOdOmEmD945biXoFafgJHIbbHliII+WEIdZZoENgf9DGxqzEWOFIqN2nGiBr038MCa+43diU/dpXdafoQiVQR7fCGibCkixrVD33gs4FhcwwpwXLDSQgcPRUUg3iZ25LPcxebeHMNhHaDJjApMDU8JQ+Q4K45rKU+zKombZ5xX+ziEm5iCBCilgPA1a6bVXTQ0XkRY8ZfTFVDEcDxElc3PtEqWGOJ2A9JRgaGGGGXQCl/HHuLgaG2AMfon3qZmpkLJ+KjS6YvoU+JQ3FwCXZOkKqmFhDA6Xfr284NVQz++wZz7gvpfd/wuFBvNtJvAFCmu3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VE1PR04MB7485.eurprd04.prod.outlook.com (2603:10a6:800:1a6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 01:54:51 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 01:54:51 +0000
Date: Wed, 10 Jun 2026 11:11:58 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, ye.li@nxp.com, vjardin@free.fr
Subject: [GIT PULL] Please pull fsl-qoriq-next-2026-06-09
Message-ID: <aijV_m5m39Bsbwrv@nxa18884-linux>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MA5PR01CA0280.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::13) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VE1PR04MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: c950d818-c32a-489c-a173-08dec693427f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|52116014|1800799024|376014|366016|19092799006|18002099003|38350700014|56012099006|11063799006|41080700001;
X-Microsoft-Antispam-Message-Info: 0PU57RA60w+CZ7IPJtUslGgGwYJufsnC7JvilJxnsRktxBc9DcnrIUAtsKS4ROul/a5tSW3PxR/h+e+foP49mNN/WMVoJEIWOniNEz51FVhiejDFjdTC3YGJW96mjdABxqEbBjHzzydObGh5EXOo6CYhwxktqbqKcctOKm+kZts62oNfdrIc8x6UMRBQLiC0UCVvWphNcJEIw2DxEceqeh+Mrcg05SyNeBRWALkawAV6voUV/zrykq+Fus68R15eCYE1blYiOvVbuIH1EFuUVu+khO9t4hzjqRMJmNNkQ6izPkGwDCQ4ZylJBNXd9BlVCms8DkNstBL+rNCUrascmQlAFI0lENwNR92IGV1Rd5F72T4ItfoybDNMgBb/8VgGDoT17TysC7dxoC4j20mjaIcHyapbWugoB/DMJHPgH2mMK0ACrCkRjLlkWUP61PlOksiJT7fzTs4dqDILfHy4VShYGf8aSywWZjQQidjq3Z1VStYkc2ah0ITuJ7i1g24KDhFl5MivNn5p7uQm5VpxbFNEL6Hb2GSBsmstuLm7UD2S0mbcAAkUzSjpVFd/QhBG0pFNklXp+RzhwV9zp8tXjkrTU1L313FQpYinut2t+uRNd8xeU6jyxRA4iHpzs9v6QxtuERzkCQrkrqmlnv1X1mguY9CwTI48sXEQzV/nZKZuQtfXoNBZ9tVdrh2vqrpXruzmLItAxHpZlvyq333ByT//Z0xzQK3m2SNVYyO67ps=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(52116014)(1800799024)(376014)(366016)(19092799006)(18002099003)(38350700014)(56012099006)(11063799006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LNQH1SPH/W160sbq3UU7wvUTsA5d+JyGdxPiQ6OORku5k1u4ZvhCShiOh026?=
 =?us-ascii?Q?Xkvbhc+5XpXRdxZ82LZnVhuB89wxwPL58huGuJiqvihqhZhLjHqxahYweS2p?=
 =?us-ascii?Q?7T+rodPeXyIAmHl8QfhfdGaCnSkmOjf4coZnRFV972RjZPRFzA2u1YeIZkAa?=
 =?us-ascii?Q?MtQhvhDxsD4+Op/QI4/ICW9S72doIqyxqMhiq/RIY5mQiKNh3JL/wb7vfqVH?=
 =?us-ascii?Q?KS79jBewJcN0akuHfXc0Lsg8TdhEDlmRHdV78IE+TZBqn4IBQeMTT4ZEbJSv?=
 =?us-ascii?Q?P8Tv9mUiFMweUa3gSQUc1ZnPtdF3A/7PGMjhsePmRJLlpSQLF9qegR1w0UQV?=
 =?us-ascii?Q?rL3I34Ua2gOlubDSlAN1QwQjLG74gAOohZ2c+0RsVilfUh6WVc5Y8NwXQLYd?=
 =?us-ascii?Q?AJXDnm7GS0I6fhsqF3Z486WSgNuyVLSCoBJ/b8MkmcEBNzRLrPX04z7pCQff?=
 =?us-ascii?Q?3JPUc63nQUwnria5GlxGFZmf67i6IGX/35ktjpBd3wJvVylw7L+UShUdoDq/?=
 =?us-ascii?Q?s9unnHuq4AEYvMSyBsFST/ePV+K1TSwRVInWIf8SMCQfXiFyEPzm2/ZEozZK?=
 =?us-ascii?Q?WKqchYEC3DAHdUuxY/OPD9C9H5xzyzuKRvksf/nyXTq+/amslwff2Nw9sjBp?=
 =?us-ascii?Q?JE6vAYA8c8DT7OuzaNPb5ABqLO0hxcUkt7yzaIHNCF5X14Ptx1Oo9KMIhXFx?=
 =?us-ascii?Q?kVNqIl3C3eHkcPxPvYOFmWq7cpQzpeAeuhabWGhMcSeQqCjqyRkyQFhp5iS3?=
 =?us-ascii?Q?GMT5R+NteXp5ox8ZrDzM3OxYNjdGjGjXMNd5bb3F2KRmx7wnY0Z39b75trVy?=
 =?us-ascii?Q?HoOoSIhvSGhM/8qZfb5Hz5H1BvN5xxR2AP8yIwFBd9rZo2zKnaKBo5W0hetJ?=
 =?us-ascii?Q?lZZQSFBjRBcd+4IRG0hu8r6CsviwTMPImBIndWjvUZFkFtECaQ9ceNcGE55/?=
 =?us-ascii?Q?WOu6xiLCvRTc+m0Eh/ver7f3ELALTHuIcSbsqgOAvvReIa5oXXoySoQtb6Oo?=
 =?us-ascii?Q?jy0THBYO8ARwuzRIxPxJSi957uvTGoxErjvlVlDbmAd0axqCLa3ppDJWREpS?=
 =?us-ascii?Q?OoaJ2MAmPou/Hpb9yCXOVdOZFELtldEqBR0u7imabCgWDbPd/z2k1LqoDSyv?=
 =?us-ascii?Q?MVzjuyxFc/liPpoH2JbvaWJhgijuU3XkLl2fsEsJkU5/acHlyKLyEfEyPVfG?=
 =?us-ascii?Q?EZYpBuq/CjMzUv0y0/4k8ZOq3mWtb/Y9wvxdzRfK+Q0/SQSWU+jaBY9UmdTt?=
 =?us-ascii?Q?lov75MaVjCUhZNzIOXvPO62B0ckYKQHT0KN7KOguwCAnR/xR1kKH5UaVAGC3?=
 =?us-ascii?Q?971bGh33tRzI8v8MPWjekh/5M0hm2/TaJT9t1O5HaEE+WOZ6BabPmD1FwSjf?=
 =?us-ascii?Q?VtLGI+P5Gu6HXsj4hPuPfQXUX48XTDKvNVIPdkwkQ3039HrejbvScrhlTEwP?=
 =?us-ascii?Q?FX8iX9wIcNVfHnd7D+J4CRAxlGPFdtgOXDkYt5g4FPE5pX0ruTqEv9ocMn3o?=
 =?us-ascii?Q?VcMQOvM/7kOCRumDbcrMw5EQNF+lpn1JueitBMhQwI95KK99ziTYZZQHMCZL?=
 =?us-ascii?Q?KX/0zF7M8B77dYB8RnTnOkBeo09ScegGSfXVDURqQCFYccKDOftuZcoqnuqC?=
 =?us-ascii?Q?JPIOY6lMe6kilVrAJazzLyDy19Jm9js7WhKeQqv8wtypLArLnDXR6puLcbvB?=
 =?us-ascii?Q?7O/jHwFC/fbv1KuFw8DU+akIr73QOwJF9P2jdYq8ntUoFux0aqcj6NLDa+w4?=
 =?us-ascii?Q?Ln2HaZAlDA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c950d818-c32a-489c-a173-08dec693427f
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 01:54:51.2209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ItqqzcKtCGLgQ8USC4T7jgvKniLPjPuCPtkbZ6aJPYXAs2apO/l20Sfgyn8ilpbNZe5uQOB03D2eOP4N1fGpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7485
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

Hi Tom,

Please pull tags/fsl-qoriq-next-2026-06-09

---------------------------------
Add JEDEC JC_42.4 thermal driver
Add QorIQ/Layerscape TMU support
Misc dts fix for fsl-lx2160a
Misc i.MX9 SCMI updates
---------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/30397

Thanks,
Peng

The following changes since commit e91911169bc737ee4a79963a1cba8db2aab7c1c0:

  Merge tag 'v2026.07-rc4' into next (2026-06-08 15:28:18 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qoriq-next-2026-06-09

for you to fetch changes up to ec217322301b306012e01796090c98af9d1f3812:

  nxp: imx[95,94,952]_evk: Implement board_fix_fdt (2026-06-10 00:09:41 +0800)

----------------------------------------------------------------
Vincent Jardin (4):
      arm: dts: fsl-lx2160a: wdt0 for watchdog node
      arm: dts: fsl-lx2162a-qds: drop &dspi{0,1,2} block
      thermal: jc42: add JEDEC JC-42.4/TSE2004av SPD
      thermal: imx_tmu: extend with QorIQ/Layerscape TMU

Ye Li (4):
      imx9: scmi: Fix temperature range for Extended industrial parts
      imx9: scmi: Print CPU part number name
      iMX9: scmi: Disable fused modules for iMX95/94/952
      nxp: imx[95,94,952]_evk: Implement board_fix_fdt

 MAINTAINERS                                        |   5 +
 arch/arm/cpu/armv8/fsl-layerscape/cpu.c            |  21 +
 arch/arm/dts/fsl-lx2160a.dtsi                      |  60 +-
 arch/arm/dts/fsl-lx2162a-qds.dts                   |  99 ----
 .../include/asm/arch-fsl-layerscape/sys_proto.h    |  30 +
 arch/arm/include/asm/arch-imx9/sys_proto.h         |   1 +
 arch/arm/mach-imx/imx9/Kconfig                     |   4 +
 arch/arm/mach-imx/imx9/scmi/Makefile               |   2 +-
 arch/arm/mach-imx/imx9/scmi/fdt.c                  | 644 +++++++++++++++++++++
 arch/arm/mach-imx/imx9/scmi/soc.c                  | 105 +++-
 board/nxp/imx94_evk/imx94_evk.c                    |  10 +-
 board/nxp/imx952_evk/imx952_evk.c                  |   8 +
 board/nxp/imx95_evk/imx95_evk.c                    |  10 +-
 configs/imx943_evk_defconfig                       |   1 -
 configs/imx952_evk_defconfig                       |   1 -
 drivers/cpu/imx8_cpu.c                             |  12 +-
 drivers/thermal/Kconfig                            |  16 +-
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/imx_tmu.c                          | 125 +++-
 drivers/thermal/jc42.c                             |  93 +++
 20 files changed, 1116 insertions(+), 132 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-fsl-layerscape/sys_proto.h
 create mode 100644 arch/arm/mach-imx/imx9/scmi/fdt.c
 create mode 100644 drivers/thermal/jc42.c
