Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63615C3600C
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 07:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60EF28070C;
	Thu, 27 Mar 2025 08:38:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FJN+VmzH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E1B081273; Thu, 27 Mar 2025 08:38:05 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AE82806FC
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 08:38:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdJRbXkBN8n9qyNuGZ0rKiq/2FGTTYuvpsCpZWA48f5J9EDTAjKOMWIFXqZa1iPyk7Q1dH1ThmhOFvMgFoS4jfF0b8CUQKR80BRDuoRxk8H6szdrdt3La+bqd5PdsxojuUCNtV3CYKN1RloxuqO5VyBBCrlXaR403WACnW4w1GcQAnqEWjnh1emoQyBmoMs8KV3VcQYyNKodwo3WG2/OkUwUODdbdcO8rN/XEmLvb16p3p6SfWVfANWyzvxfbWlNB1B8MVudqelBiPR0FQjlE5c+h2sTPqlh+0dWsjXX6zm9kTgvBGkJiLSSqlvsQ1xK4XnJz6zFiFMZztDklhfung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXtRuHCUGSCAvfZv/0m0ev1JgX21aclbkRFflGvWjrw=;
 b=HJRSAujyk/Ogw1GACC46zGIzSNkjEOnqbZgNoZtbsFIfTpRBQToJo5Gv1KkxINZJU5nJnCfwjPZwTGb2kcmtiRKetIxMz/wlxB/PfXTzUM0RMNA4cM6Hi+O43iEUNfxXUjM61UJXXKda8kquPAnHcGsf9jqlnzIN6ZVLS86m6GK36t03672SkhP9p3EGNiiV9BWfuatdLyUBas3guCfbWG1GnrwCz0HonAJRenNCzc7EVVvbjZ2ye9tNx5MqEUbMggqGy/Zcvnb5ygCVhpL3n2jpV1T3HJ8vDlQBQri/DnWHLsUnThk/AXDawI4Bzo2votYbB5iwEKmzJEA8+YHS4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXtRuHCUGSCAvfZv/0m0ev1JgX21aclbkRFflGvWjrw=;
 b=FJN+VmzHOQqd7G6VEX8bqaCJ5LWxjPjVwCWZHbudvcW+yiMmNEr9MHIzqqFw0CQshKo95b9s7PnZuZ8NQtBfyQzmQLjDN66pGjh6+pDjj4Dv3Ijph6uCX1Ie6E/sdl02ksTe0XujLMGZiKRXYNi6mlMtwGS/rDzXV1IrO2xEVn7/3mvWWP7M2RBWZ/Sr8hdMYwTNSZqsGcO7/XjL0MVLhZ+HzwIBCJ8LHddkszqjh7xYmU+tAsEnMLsa0DV83BPaLt51NwaVbwWtnHYRo2oLwEC8O5K/9NHFhAlwoulVM3RBC9WZTyIbofqtlo7WT/X/YWNnCE2AFyJj0c+nqa6jlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8847.eurprd04.prod.outlook.com (2603:10a6:102:20e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 07:38:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8534.040; Thu, 27 Mar 2025
 07:38:01 +0000
Date: Thu, 27 Mar 2025 16:46:04 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PATCH 4/4] qcom_defconfig: enable capsule update support
Message-ID: <20250327084603.GA5432@nxa18884-linux>
References: <20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org>
 <20250326-b4-qcom-capsule-update-improvements-v1-4-afe2e3696675@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326-b4-qcom-capsule-update-improvements-v1-4-afe2e3696675@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e658e8-aae3-4083-0698-08dd6d024d0b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xiswcnj7Tlmpg6El2ijLpxqLw4wQ8o5HAQDib/EpXJKoj9kMhtJ5azFjBCZp?=
 =?us-ascii?Q?v4RC/+yzPnLfQIuw/amVs+SI7CT7/ltE2/aijMNQ+7ScchKJepf1282VPThO?=
 =?us-ascii?Q?5kNlPSYBuWrQBaC6oLDoPGsFLrYh+9DWyiJm6ySpEwC6SnKTLEqL9KmUOSTF?=
 =?us-ascii?Q?+RGj9hBFGCobv84G2PE1PQg1Gy8QDXPWubQoi1Vlav+us3zHmZf4pyZGU83G?=
 =?us-ascii?Q?UVurijvyZwI14co6Fd5859PXXyDSQAXbsP7wPOiX2JKbKBbQ6qL/H38r720w?=
 =?us-ascii?Q?fchJe9hJy4XrHxhWgjJZAwnMA80+fpnbDhKfEWBeKzrwIHtYxmdNLugGwaWa?=
 =?us-ascii?Q?hXhCO1/V5bOrQuj52oTAIAoGyn93GILpI1ak9cDLs8baMwqQJ34nFcwL/7oW?=
 =?us-ascii?Q?FdySQj85rYoysQKHGR6BSCwCxS4kASZ0g60qZdFIIqRQE3uphTZ6TTp39jTW?=
 =?us-ascii?Q?6hgN0CW1b52xuCONkfQmwt8ixTvx5iFVUjkaAeeQ4j11/XSVfw0BCv7XwEql?=
 =?us-ascii?Q?BMGgEPu0Aw69R/wBmg1+76K/DSuqcQnib5FcO5aRzz/43DY8mFNJgJnUxtZC?=
 =?us-ascii?Q?HLm95hp5m4X5UdhtglYNIIUctbNAIcAvgisIvcdLsoMt1Ego5TjbGoCMCLOO?=
 =?us-ascii?Q?e1HQqMvyHsCTtZX6HgkiW9U3Ryn9aaaso4410ZuYpXzgiRZKyw26ENXXuqYq?=
 =?us-ascii?Q?JaErjN8OON4Po8/pyet3QuIpJGLLDGXC4xFkS80JR3gpNulWZAOFI2wIg0hf?=
 =?us-ascii?Q?dZXrLZEw0dMfX4mU6KaOa/+QUOhooDY53EvRBWpgwL6vX1aZVbgJQjx/NmGt?=
 =?us-ascii?Q?6P8CoEJ/G04pDqPUt4j/9Kg0oceGKe5+cbwFxcw7M90MN6ZsVYM1tXn3R93W?=
 =?us-ascii?Q?QUm8oII7kJNgOOYEs2TTm0TXfnH+xFQDE+ar2uLhTCMualWxDAEgzA0JXJsc?=
 =?us-ascii?Q?WRvCrUM9k0oMcez6x3S2Q+9ivUtHU19dMBIT/BmfYqkXywLINvECeykEMyvi?=
 =?us-ascii?Q?KXAIWQqo/Dbh6AX1qhr6YvG6KPdSTNSBhr5Mf8PkpU0jKGaAEbw4L8fkecWG?=
 =?us-ascii?Q?y+jl1LS0Ppw60YTMaJGbIFjhoa6iGUKDdrkLpIhLvEWy0Op5N8tEox/BuYOt?=
 =?us-ascii?Q?p5/nRsTk4WeHaoA7bksZ1NmpUywKVWDejtofoYEZ8+dUG4QtLECV0VlL8rD6?=
 =?us-ascii?Q?2oaytMZoo4VAQe3GOmhm1Y9GA7kcMw/45LOVVriO9ZBdClRwsc3qPWnYRGO1?=
 =?us-ascii?Q?CW0gtrXMDfMcCbUWLLBgcE0/Pr8mJHbNFJyOsQF9hAqivzApUusry5+/juZ7?=
 =?us-ascii?Q?aBn6Y71F70WepahqBWBifAb+osv4rBKd1YigohSm908K2AXcsFygGUupoFQi?=
 =?us-ascii?Q?oGvRVqH8o6vLS9KDzBGWtQrS5+MhW4cl+/qXF+je0OI6Z8JbaPVf4tAjCmHT?=
 =?us-ascii?Q?9CKGHPpqGWGTWAUqpDydRAzV5lRAc6jO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EtZ7oJduxIv4alBuUEqXj24ig+qTC16PSl/bINexh2DoAFiaw6/3muVWIJzl?=
 =?us-ascii?Q?hcA9EBULyHI1DIWaiNJmMiRmQuzeIPKeX1ev0Ymz0Lsy3Kwv/7GNEqwwb20J?=
 =?us-ascii?Q?8ku/YOcaQB7quEL7BzBD+S7EP8/M34k+8YNJwfZVRpMtSfg4zK8ZgRWd9EXP?=
 =?us-ascii?Q?PiNn4sXG1Kz9YBuvgH7HfqBQr2ctaeCgZCylI9solfurk+YLFoFlFTMzXrSH?=
 =?us-ascii?Q?l9PWZ7Cuah/6LH/WSff7DLjAAwfvloGR4G3lNBnIolSTdkacDqRKjeLm6Ixz?=
 =?us-ascii?Q?/GR+oD1W7702TSBbL3eo1gF7DdtoOsjCmN4+YL+YbNV5Mhkfh2PHIz+kxBnP?=
 =?us-ascii?Q?QAAX4tEkGdwH6yt0S9UTI4bYuyXIOFaLAs1g/JVcuEXggG0wo0YkeBqxbiP7?=
 =?us-ascii?Q?wjdomaZBbAs3okT3JAnbjh4N84vpSdXfuMwSpmDFhQtyRZTzwLKT0mxh8Wqj?=
 =?us-ascii?Q?DY6Q5zuh4w2tucgMET9LNLD0DwlLBzIdTPYHZeAvpEE8f/eqdaNRvNn6S0JF?=
 =?us-ascii?Q?irNPZI7qITNDBzmSgNQv3QnsQvb04GLZYMuEeMXjskP6fTQv3xmV94PuR26t?=
 =?us-ascii?Q?BXp+mZqo07PqC97e6z+Texs8wDab/UGNLCCFwb+kvd8MYexfr6Xco7xYCrlA?=
 =?us-ascii?Q?u+0nCJ/YGD1lK6gt2oFY6agvEm8ggRtam2JoRtxIEKKqmM1DO8fI7xmaKGTP?=
 =?us-ascii?Q?IaKURrzAxVKlsRK29sY5uQ8Gs+gFke+G95JJ/n287MIMLDTjVmyF2wOqjeHf?=
 =?us-ascii?Q?TNO+O6V22Uhh2PHo1FhzBBMRoJZmcQY+d00CZpmQbSXOVDdv9clPBW98trtm?=
 =?us-ascii?Q?cVJl1yzLUkprwI74f8C0giq5A8ZPmF2oSeuZdNSEkXmR4Y5cTXbQOKLr4Td1?=
 =?us-ascii?Q?Y9Dbp1Tm2Ns+jOYq8LCzGDscGK5sA905Iq+T6LqVckf6cft1+dlEACoazIO+?=
 =?us-ascii?Q?dX0DTqrMdu/SW5T3cpWtp9UKhVKwsyuu55qP8eOgy2YZY4NjFm5xLd3pu7Xs?=
 =?us-ascii?Q?x7+QWqfwM11Y4TaQB4+BqL3Dzsa2xA9bu5lZ1MI+vj2l7RcCvTKBqBOBu6to?=
 =?us-ascii?Q?JHmQLDlQyOKmTkg0hHpcWTOEDS2hJdaiADGFJym7bB85HmJbsD3OB8QAt4br?=
 =?us-ascii?Q?VkUaiz2R+eCk/4jq27dzPCTsOmnPgGDuh73q8frstM6pnS8TMDHtyKWhZoiy?=
 =?us-ascii?Q?Y+EIXlQc/Uq0nrFGoP8NareVAXZgVO0DUR4DbrodZlpnKWdjOyY85Y/1tIIc?=
 =?us-ascii?Q?4odmMpRMWiSDhix5C82tQhza7+ccgVxEGvpAfTl34kxnWL96Ir8owiVC6cs+?=
 =?us-ascii?Q?kxitFRDKYlnmIPB/SPT86FybhWLl2JECXIIRh9wzFlPFgvVOaZb3hmMH/Vzz?=
 =?us-ascii?Q?uklX0OE3W4Nig1aVbZmV4YVevwCM23YJ54qCAmMCuuNXyrNAxJlhc+i0MLd6?=
 =?us-ascii?Q?GRitoj6LjCmBwSHPFDtR8yy1ZSMCJUZMEeFr5WYemf+W7dR82Jy0ap+92ERb?=
 =?us-ascii?Q?bhSy5w0f26fV3SBtTxxSMWiBdyZPEEloEBsojbasv+wRpga04XpCaXEAXNuR?=
 =?us-ascii?Q?Cx+y2ow/iiOu8v5IMAENRW4EWwFsNXWy4ysYPwUn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e658e8-aae3-4083-0698-08dd6d024d0b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 07:38:01.0927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzBLxbr/7qx/w8uiVSXfHJbZoipr7KBbkyls7hYfqJBx/w7I5G8qF668XRR7LkQp8DaZ0tSSh30dp3PjUnOuFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8847
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

On Wed, Mar 26, 2025 at 06:40:37PM +0100, Caleb Connolly wrote:
>We can now correctly identify which partition U-Boot is flashed to
>between uefi, xbl, and boot (including A/B support) so enable capsule
>update support for all boards.
>
>Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>---
> configs/qcm6490_defconfig | 6 ------
> configs/qcom_defconfig    | 3 +++
> 2 files changed, 3 insertions(+), 6 deletions(-)
>
>diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
>index ba26924da161b1c4b5378955185f314b05cb1006..5ddc5ab3ef8cfe8f9cc09eb573c1a8130b394b43 100644
>--- a/configs/qcm6490_defconfig
>+++ b/configs/qcm6490_defconfig
>@@ -18,10 +18,4 @@ CONFIG_DEBUG_UART_CLOCK=14745600
> CONFIG_TEXT_BASE=0x9fc00000
> CONFIG_REMAKE_ELF=y
> 
> CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
>-
>-# Enable capsule updates
>-CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
>-CONFIG_EFI_CAPSULE_ON_DISK=y
>-CONFIG_EFI_IGNORE_OSINDICATIONS=y
>-CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
>diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
>index ba4d38d100e053e3708ee2623bf3530787b6b94f..d69185f3c2f0452e6757b785a023cf612bfa3839 100644
>--- a/configs/qcom_defconfig
>+++ b/configs/qcom_defconfig
>@@ -5,8 +5,11 @@ CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
> CONFIG_ARCH_SNAPDRAGON=y
> CONFIG_NR_DRAM_BANKS=24
> CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
> CONFIG_SYS_LOAD_ADDR=0xA0000000
>+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
>+CONFIG_EFI_CAPSULE_ON_DISK=y
>+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> CONFIG_BUTTON_CMD=y
> CONFIG_FIT=y
> CONFIG_FIT_VERBOSE=y
> CONFIG_BOOTSTD_FULL=y

For capsule update, CONFIG_EFI_MM_COMM_TEE is not needed?

Regards,
Peng
>
>-- 
>2.49.0
>
