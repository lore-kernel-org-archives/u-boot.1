Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73ACC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:03:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED9D387A31;
	Thu, 14 Dec 2023 17:03:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RiXCeL+e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F07E687A7E; Thu, 14 Dec 2023 17:03:37 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4067187966
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:03:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2co6JmOXkEcSvvkbQMV9Gy7N9pbSA+qa/QYIDVUBUJSp8lx3ECElDw/hbNTjJ0NXssxiHdNxs12zki0gcDzmg3LV6vcjWKUKdiOMvEn6f53iOfbMMlgkvj2VxhwGlvjuUOvxOCYHWb5+YbIp7Lpnv58NNcvs++/eI2vT4ukMcKaX0a9kDkeG2Z94iwxwK40zkmwF0JP1M1va6JWQ4ZGlHlaJHFLHYBJsyADoPZhhfah61dElOrRxM0T5zXktK2elgXWo6gxJiyoQEnhgelvCmWFkJ5JJcHhNxUbhCsiFCVJDk6vBcurOBusKQS8UUBZXOhs0kXD8XBAejXvtDL3QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMPhBLWaFuElPAFQNiEbNXJdP3VO+QyhIVt2MsjAfvQ=;
 b=W28L7VQN7orZjBr36nwQqqDLzI0J80jIP8e8Fy4AneGjVRC4Scd2qG2LwANgypeqPI05VxRbb3sty3ywMK2/gaQfjnZEMRGMn/LlgvrB9xWT8+namO5Cn+nFQHmnTlDJSfCoNqAh3I+k4nazv75I8CdWY6Qruq1T/3e8U3Nm2cK/bnbJGSKxrbeUWDJizIdgs9dum/FRoZqsSDD0/n/E6Fya0OVNxSt16USAY3qvCpe9OVScYH1+Yq6BNRC+ce5+oXfj+2LhvEDaovpNGxWa21umHU/NiKDUgTxtCxL8+jIVyK8ihiT+5QahpakjZgUcoem4TzcNFJe4ektVL/LrlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMPhBLWaFuElPAFQNiEbNXJdP3VO+QyhIVt2MsjAfvQ=;
 b=RiXCeL+eUR+l6cBwZHPh50MjJ3xPqxCHYSiAObTx5EIRCqzkN/lHGNPqDqsWyD83RLrjDL4rnPbm3/qyK8JDj+t+DPzFG/nfZnYSXoEKGwRkBcGGSgoEdR+DhaFQ/c+9DgLjZdiVOAfA1hRgEaam85NGYVNgPBT+kHPILxk7dkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 16:03:29 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 16:03:29 +0000
Message-ID: <f7359261-e8d5-4006-b7e9-c216f9e3bc4e@amd.com>
Date: Thu, 14 Dec 2023 17:03:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] spi-nor: Add parallel and stacked memories support
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, git@xilinx.com
References: <20231214052339.82382-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231214052339.82382-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0101.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::42) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d182a72-ad4c-4d5a-1f00-08dbfcbe3681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OSZLdsMLiI8sj3B2PgxC2z3IoEXgHQtj2C9xmv2syDIGWiimxrczy+OFGEwFq6nGqm9/DMc17Ys+YvufM+8fZcRNkls3AGA059k6ofvFqcizHzjojsiFx/iJfeaR1MfMwX3AiGqqVoU/smCYdZQkqyhG40OWs0SgUzJM+99fW88Lujg7fwSZnp8MI95N5zhNQQdIowJhf7jP/3a0mOxel5aufu53X7IZj1JgLTF12UkIg6LYIYahSW7g1Bu5OV7RCz/xYzgCTrRyP6NAK6WE93aPdXL1vXOPZd1lMsZ5hV8HjG/YRhdQL32qk7BtAbtapztA5l7ZeUhzYd8hG8TSdpqUxS3Ozp5GNYAE9Ag33BCzaxKv3/od2fqGctoORwo2mkbOb9pq2rbcaXEEGHZGAf4XN5/oy7e6mvOXO13i4O6Fe/gxuvY1xwEiegCWsh8vp6yWLVxMOHABJg+KBSUQnPtyOldVJUbIjaS9KRvHqJDfGYKCndmpPytjzgoaCcU6XKTHrvHp24V4YzPHwCHSLrG1FfBA6dkTBJOK+qjB2sU53qW56UEOGQ9ZICycVHNKDQRtE3UlVUWm7gyM7T+T3FQTlzKVvIWNtxLVS1AVhjnBA7bik2BIgm9yEp8j7EgeVb8oJMMoOeaSGMBabZobQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(39860400002)(366004)(346002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31696002)(86362001)(36756003)(31686004)(41300700001)(6666004)(66556008)(478600001)(6506007)(53546011)(66946007)(66476007)(26005)(6512007)(38100700002)(83380400001)(2616005)(5660300002)(2906002)(316002)(6486002)(44832011)(8936002)(8676002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1llM1NzM3Jncm9NSE9IZVUxd0JOWHNDd0RGaVRRek5jeU5oZzB5cDREZmU3?=
 =?utf-8?B?N1htdncySVpnWC8wbXl2Z2hQTEdQUXVYZjM5MEFmbE1QZVVNQy9XNlNGV2lo?=
 =?utf-8?B?aGZrMTQ5dXFubWZYY3FWK1dyZkVkYnloVS9vbVFBaGRrVnlLWVl3VjVka0Rv?=
 =?utf-8?B?Q3M2UUt1Sit1UWp3RDBWV3lRWUlrRG9JbnBWTmlxbVZKT3h5dDhzVjBRQlRq?=
 =?utf-8?B?S2Y0QWVXY211aFk2TldYQ2xoNkkrYWduL1FCdnVtQ0VmR294N01VRFYwaVda?=
 =?utf-8?B?dzhKQkdDbGlZblFKR0JIUnFMbXlqa0JQSWk3VEF1VzFyK0xlVDFmLzE4WC9G?=
 =?utf-8?B?aXRoT0JBQlI5d0lFZlBYZ0J4ZHNsVWd6MzZZRVpkSHRUVXVWa2IveExyMDNl?=
 =?utf-8?B?L3duNEhrM1JNYXNsQTdQV3RxdzQ3M1hwanFmZzJndjgvUDFMbTR0eWNCdzNM?=
 =?utf-8?B?ck5qdVBrbTgrRWV5a2lNQUNRQVZVOG9tR3BwVE13ZURvaWd2R1JNR0ZRZXF5?=
 =?utf-8?B?NnpTV3VtT2huK3FEcEY4dnJIVE16VkFFdlhjSUNtMlRDNURLU1lmb2ttbmwr?=
 =?utf-8?B?UDY4bDFLZWpMSlJURTlwSVNNdFZHZC9FaHozMjNZZU04SzduN2VmeDB6KzBE?=
 =?utf-8?B?bGlqaWhkQTNGRlZ3RFFFR3Z5S3o2NzQwcXNBa3RvZ0RFMjBFM2ROOGR5cmpZ?=
 =?utf-8?B?cGNyTXJwdWJSQUlrS2FjTVEzc0hZZnlLVWVkYXlyQ1NTVlhpakk0MVZ4R2N0?=
 =?utf-8?B?Mk1mREYzWEFzQXQ4ZThmMzlDa0E4OWhtdHdqWUVMcjk2SzdwUG1ZM2IybDlh?=
 =?utf-8?B?WFBHUWZ2VWZ4c2ZHVXpqbm14OVd0MDZIMW84N3p4dWtkS0NtS1FuOVJMbU5j?=
 =?utf-8?B?MTJhcFRZazNoVjc4eHNSREJLQnlIcXNPNmdFb0VobkIvRTBVWHYwajY3amZo?=
 =?utf-8?B?Ym03cnVSRVVicUJrRklFMVhycnExL2ViMFhTVnNFMjBUVlgveThGQW5VYm1v?=
 =?utf-8?B?Y1R1U3R6cURXbFh1V0F6dDc3ZmM3b2lVeDNPeTBIakJ6UzdkdGZiNVRrSkFI?=
 =?utf-8?B?UkNReFQyaWt1Tm5FVkJKampyay9tM215SjQ2NU9xRlhUS21CRVJkN2wwTTkx?=
 =?utf-8?B?YmZwMEVEUFdPUzB6aSsyNlIyY0IwOVRzZjI5am9pUU1LU2c1bHFCczJhUVQy?=
 =?utf-8?B?elBjWFpTcmZiYTFhUTJBWHhzTXN2aHg0dlRUVUtLRTJoSExQbDB3eThENUp5?=
 =?utf-8?B?Q1dza05HcFJ6STdxdk9PMlF1OEFJL09wa1Q5aVRFT2dLSjFyYkFUVDcxVjJS?=
 =?utf-8?B?SmFoM2J2OXMwN3BMb3FZS2o1RjZsdEJtRGVqd3d1SHBMbHBSZjd1U0Jobnps?=
 =?utf-8?B?VmhCMDZiMXVZTERuSmMxeVoxU0RpeGFkZkpWNlYrUWRYSUtBU2cxSEE5M25r?=
 =?utf-8?B?cDNjZlIwemZxVjZrenhCaUFsdUdPQ3dXWTdGd2oyUEorR3pzbWx2VDB6ZHJN?=
 =?utf-8?B?akpvTjVqWFJuK2t5MUJDSzNnWjlkdkh1ZEN5bW56cTNMWEpmK1p6bkpPTEZX?=
 =?utf-8?B?TlRSMWlETHY1aSsxc3hFRjBseGRoeGE0dVBXZW9Jd01wZTh6RC91cnp3ZHh5?=
 =?utf-8?B?aFVqU2RqTXhmaG5QejRYdVZRT0xzcGlNdUxYaVNCcTVqYkYwMjVNUG5pak9J?=
 =?utf-8?B?c2pFUWs4REJSNXI1V3lWRTNHd3hqL1hhSnh1N3o3aHdzQTNvOXhmOE1zZ1lG?=
 =?utf-8?B?eThqdnhZRlNZejIxVXE5ZlhJcWJLNDFaVm1yWVZPWkl4cW82SVpmYkRydDQr?=
 =?utf-8?B?OEFNME90Umg1QWhlZVd2UTVmdXhNVG4xMDIvMFBoWW96M1FhME9Lc1Zqand3?=
 =?utf-8?B?SnZVRWxCa3g5b2xtNzEyUlBuNkVuYUM3VTFmd000Z25VcUdhM2x3a3FXWEZL?=
 =?utf-8?B?cEFlWWJXMmc2V3pUaTYvUUtpcHBlbEY2ZWcyTEp6dDY1RGtkeWtaZU53UnF3?=
 =?utf-8?B?VXVvS3NSL3dKYU84dWNKRG9wYVlWQ3ZmTjFhYUo2NXBJNGliQ3B1RVFtYlJS?=
 =?utf-8?B?N3FUb0srWXNERXk0eW5zSjMzL0xFQ2RHcFNtdlZvUXdLZ3YrZGxLcDY0WUVm?=
 =?utf-8?Q?8cg10UAsgkeE1phV0AW00OXbR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d182a72-ad4c-4d5a-1f00-08dbfcbe3681
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 16:03:29.4325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5R4eCqYxxUc1b/ncXjY6kP3Fb70fBRA4aBV7S5pY0ZxCaX1sQtbO9/yMDvvAbXDQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802
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



On 12/14/23 06:23, Venkatesh Yadav Abbarapu wrote:
> This series adds support for Xilinx qspi parallel and stacked memeories.
> 
> In parallel mode, the current implementation assumes that a maximum of
> two flashes are connected. The QSPI controller splits the data evenly
> between both the flashes so, both the flashes that are connected in
> parallel mode should be identical.
> During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
> nor->flags.
> 
> In stacked mode the current implementation assumes that a maximum of two
> flashes are connected and both the flashes are of same make but can differ
> in sizes. So, except the sizes all other flash parameters of both the flashes
> are identical.
> 
> Spi-nor will pass on the appropriate flash select flag to low level driver,
> and it will select pass all the data to that particular flash.
> 
> Write operation in parallel mode are performed in page size * 2 chunks as each
> write operation results in writing both the flashes. For doubling the address
> space each operation is performed at addr/2 flash offset, where addr is the
> address specified by the user.
> 
> Similarly for read and erase operations it will read from both flashes, so size
> and offset are divided by 2 and send to flash.
> 
> Changes in v2:
> - Fixed the compilation issues.
> Changes in v3:
> - Fixed the CI issues.
> Changes in v4:
> - Removed the dio,dummy_bytes variables from zynq_qspi driver.
> - Fix the compilation issue by including the DM_SPI config.
> Changes in v5:
> - Fixed the issue reported by buildman.
> Changes in v6:
> - Fixed the issues reported while running the sandbox test cases.
> 
> Ashok Reddy Soma (4):
>    mtd: spi-nor: Add parallel and stacked memories support
>    mtd: spi-nor: Add parallel memories support for read_sr and read_fsr
>    mtd: spi-nor: Add parallel and stacked memories support in read_bar
>      and write_bar
>    spi: spi-uclass: Read chipselect and restrict capabilities
> 
> Venkatesh Yadav Abbarapu (2):
>    spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
>    spi: zynq_qspi: Add parallel memories support in QSPI driver
> 
>   drivers/mtd/spi/sandbox.c      |   2 +-
>   drivers/mtd/spi/spi-nor-core.c | 401 +++++++++++++++++++++++++++++----
>   drivers/spi/altera_spi.c       |   4 +-
>   drivers/spi/atcspi200_spi.c    |   2 +-
>   drivers/spi/ath79_spi.c        |   2 +-
>   drivers/spi/atmel_spi.c        |   6 +-
>   drivers/spi/bcm63xx_hsspi.c    |  42 ++--
>   drivers/spi/bcm63xx_spi.c      |   6 +-
>   drivers/spi/bcmbca_hsspi.c     |  34 +--
>   drivers/spi/cf_spi.c           |   6 +-
>   drivers/spi/davinci_spi.c      |   6 +-
>   drivers/spi/fsl_dspi.c         |  18 +-
>   drivers/spi/fsl_espi.c         |   4 +-
>   drivers/spi/fsl_qspi.c         |   4 +-
>   drivers/spi/gxp_spi.c          |   2 +-
>   drivers/spi/mpc8xx_spi.c       |   4 +-
>   drivers/spi/mpc8xxx_spi.c      |  10 +-
>   drivers/spi/mscc_bb_spi.c      |   4 +-
>   drivers/spi/mxc_spi.c          |   6 +-
>   drivers/spi/npcm_fiu_spi.c     |  14 +-
>   drivers/spi/nxp_fspi.c         |   2 +-
>   drivers/spi/octeon_spi.c       |   2 +-
>   drivers/spi/omap3_spi.c        |   4 +-
>   drivers/spi/pic32_spi.c        |   2 +-
>   drivers/spi/rk_spi.c           |   4 +-
>   drivers/spi/rockchip_sfc.c     |   2 +-
>   drivers/spi/spi-aspeed-smc.c   |  28 +--
>   drivers/spi/spi-mxic.c         |   6 +-
>   drivers/spi/spi-qup.c          |   4 +-
>   drivers/spi/spi-sifive.c       |   6 +-
>   drivers/spi/spi-sn-f-ospi.c    |   2 +-
>   drivers/spi/spi-sunxi.c        |   6 +-
>   drivers/spi/spi-synquacer.c    |   4 +-
>   drivers/spi/spi-uclass.c       |  23 +-
>   drivers/spi/stm32_qspi.c       |   2 +-
>   drivers/spi/stm32_spi.c        |   4 +-
>   drivers/spi/ti_qspi.c          |  14 +-
>   drivers/spi/xilinx_spi.c       |   4 +-
>   drivers/spi/zynq_qspi.c        | 119 ++++++++--
>   drivers/spi/zynq_spi.c         |   6 +-
>   drivers/spi/zynqmp_gqspi.c     | 141 ++++++++++--
>   include/linux/mtd/spi-nor.h    |  12 +
>   include/spi.h                  |  23 +-
>   lib/acpi/acpi_device.c         |   2 +-
>   44 files changed, 773 insertions(+), 226 deletions(-)
> 

I queue it to CI loop but I still see some issues.
Also some other issues with compilation when DM_SPI is disabled.

Anyway that series should be reviewed to get opinion from others.

Thanks,
Michal

