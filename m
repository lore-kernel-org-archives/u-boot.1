Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B80EDB7F3
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 11:10:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15BCF83A41;
	Tue,  7 Apr 2026 13:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NNMdGxcv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B32A8352B; Tue,  7 Apr 2026 13:10:26 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E60D784034
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 13:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFiuZJHtQlaqUTbp12Sb2idpbIuUhJgBXfuJklc1vRk2DAf3SEsoMYGyrdtka5UZWKBMUsCpp573AGro/Hu2g2KDuHgNJXTxOWnNiWQ0agsxP7ow44K+FlVr7o1glaFnWYn/OicVJE8uKYjtYRwDh0GXaeDo5fSCLOqmnOeeFjFO1m+gwNMyzJgVW9I4Foo92vJ55gqLFX/19+e8eQsQxUJGuV8lNtkSzoC8anVqV06a5FtAeiCnCsoVcqchEqrY6kPUpiVDRUXMyvjtG7B/l7PGvpUdunDmw3atKXWom8wu2pL87X+FNIUYy0nLOzrnsV8i22mhGcXsnGemDjWECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xd4mAzn7Buy64A5j2Tx8S199rR10Jpd3Fvqa+jF36ZY=;
 b=A7DvGEZ8j9Nz3l9mPuo8Di7MfjvZYfS2SfsaOx2iAUHlZ/Twr085u48advoFt1gdSvUaqUlgx4Jqo95GJHfsUcSxmz9jlIpmcK4wJtihAnMg95dGsPC2RfW5PIq4yBf09PIDczp8df1uD3OmsY4ZOIVe4BJDrpvjTJ/xH0TXPPDuCOoRS7+x+HPYJlcDdllFRW7i5nOJdfOpuv5LUa6JGiZY99MIP+KGaaW4ErRRax2T2iEsEUc0xJCVInTMK/DV7ZvJRClS1y18q0HFwcue4s4BRk2kFcLqmsbqJUFqVXkvkAwqC/zjuuiOF4bxnhcjZXglKKkOPM5OYQ/P1BeXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xd4mAzn7Buy64A5j2Tx8S199rR10Jpd3Fvqa+jF36ZY=;
 b=NNMdGxcvrWNvID5cYcT5YkLe//lyvsP1yK3yws4zNOaXZYl0EMIccgPhW8RIWM7mqO6x/SdLp8w9f+6vyUPjJPNuh4hr2E7PffLb5wtvijgzmbR+CGYbtw7I1T3s3SlJwjTqW0/BjLqLc+TyX4LuMjuNvmPRD0b0EA9iaZweGPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SA5PPFDC35F96D4.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 11:10:18 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 11:10:18 +0000
Message-ID: <2c495b7e-7816-4880-89bd-0fa237d779c9@amd.com>
Date: Tue, 7 Apr 2026 13:10:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: xilinx: Reject broadcast and multicast packets in
 AXI Ethernet MAC
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Sai Varun Venkatapuram <saivarun.venkatapuram@amd.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>
References: <07ad94eb8a3a9d80273a16a7ac8c7caaba607fe2.1774282153.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <07ad94eb8a3a9d80273a16a7ac8c7caaba607fe2.1774282153.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0094.eurprd09.prod.outlook.com
 (2603:10a6:803:78::17) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SA5PPFDC35F96D4:EE_
X-MS-Office365-Filtering-Correlation-Id: 55af2ac7-f0f4-4410-dd66-08de94964058
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: at/OD6tt2qXdYgJJ/IX6fOwl1jsVfIrZWsXoLSJIjvIfIYOJBo/mNhWYl3fiEfYvFTRh9+O+qoGXrDYv5nm8pFeVQJwr711+Rz0rmC53EYokB4hh3Si4Kg0gKuzgDMMXNNsrbFckT6WvIP+5DM8aQkGRgqhzLTcFa7aJEWuDcbrgbSyKOe8uqEVFWifUGkexbuyw7EgdW9xCpMx2tHsHPYiZhcP/wqtL2pVvsNu2k/AlYDJwRpeh/GjS7hxeXMEvmqQiJb++HNOpF0tL0b9/HUnoj7WCDznBjKr4YsG6ToPegqvu6xNE7bdltjmFd8ddlH0TCKDVcyoTsEwqykuy17x7V2w0Kt95B+PSjPjxvQtRCJ2dSgo0FX7mTSn70owFzJwR85/8JgJ7GyCT4UtINR3eINkLqPmJhkXeyxxCIbHw1QNENq0GAu0OyJv0WGIbZzo0nUVjeYPhenCahpTmijEG6355qvW0e6QpFR0en+MjE5hB5+V7CmaTM7HgJI6bdxxZJmFJ+8g7VnTOpImTp1gtYkU4MOwTiD+PWFy+pSmG0lqDD7Ie4B3nptQprv6/rqq9dIXkQHKfsDPMUUTXhLnajxisHa8ElB0VzS3kf/Sz8XxbNmY2emZyrpER/muCa0UoGqF7uIXd9L2Z3AhShzUo+SCeOP3OINYhHZsckwC2HJlgb3DVEP+A9yVEukx/ePoVNj8bVn9Z9MVbPPT0HOnZtS5gBhQUvDhyh5mBBjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T25DUDRSM0ZZK1NFMngrSWlpT3pONFkrZkF6TWhadDFLc1FFVWh5T0ZkSm9G?=
 =?utf-8?B?cnptaUVBUXVTK1dEb0ZmOUFpVXRNMHpUbndvblk3amZOOTU1bFQ4NjJXMDNH?=
 =?utf-8?B?cm84Y2VlYXRoY0tsN0RLdWFZbjIreVlMOWpPWHBFd1ErREw4bjhkditzbmlH?=
 =?utf-8?B?ZTE1c1lUeGN0aHMxQXZhZUQ2L0hQWlJkbjljMzBSc0g4SFZxaUZFVFFCNVBx?=
 =?utf-8?B?QVlYQzJ6eml1SlFaTEV5b3ZuRS9UUTVZb0NEUjRUNjlYa3lQOSs3aCtTeFQy?=
 =?utf-8?B?RjFma0RmcWlZREJDWVR3Qzk4aU9UZlF5R1d6TmJTNEV4aVNTVURLdjMzMnVJ?=
 =?utf-8?B?ekhLZTJrbmpqdW8wd0JIcWlsY1hxdFY2Q2VpVjNUOUVnNlpiYU9VaUhhajVT?=
 =?utf-8?B?NjZqVGFaSDJvR3BIN0F2dEFTS0Fhb2FPUTRoTE9PTGpVQUZYTHRxbUtMUzd1?=
 =?utf-8?B?UHJGU3paOXJudS9TNC9yTHJOeFpjU2Y3OGpIT00rUXpad1NaRXM0Q0U4blMy?=
 =?utf-8?B?aU9OQW5wdWlDa1F1Tm1CTktwMktzU2RXMUhqSmlzZnE1Wit1M2FPdFk4MUhJ?=
 =?utf-8?B?UklVZUtyWUg3NksveW5zQXRVUk5OaWVWVkF5V3c3OUlvNnlBUFRldWtlY0FS?=
 =?utf-8?B?ZnlQL2VodnV4MjY1UDJ3ak82MFVMYXVLWk1qS1gzUnFFM0hmVFZ6U2NoaXRY?=
 =?utf-8?B?T1VhUjArTmlzS1BYNGVBR0pvRC91R0RLT2FNVklTQWNoekdBQ01rNkkxL2Ni?=
 =?utf-8?B?aWpHV1doUzRPd2FBMGpzamxPcFhNU2phNlNBWlJRb1RNTUtZSUN1czNNNEJD?=
 =?utf-8?B?YmdGZXFITlgzRGJtbTBuRGpYb2FpYmM2TjNaWThseHpLZlBOZUplUHVhb01N?=
 =?utf-8?B?S3h4VTdscnRtMkl3MVdFc0RMUlBsYlozSjZOcWgxd2pETFl0eWhhUzh1ZHc5?=
 =?utf-8?B?UCtUMUVlZWNNRGdtU3ZDbi9tUDY3RU9McjVzUnE3d3J1TmJlM0p6UDlBSXhF?=
 =?utf-8?B?aDh0VHR1Vzd4NFZOaUd5OEFXTFJzVXk4K0VuZlJwSzNTU3c0TTlyRzNrc1RM?=
 =?utf-8?B?SjlGbEhhTVJOcWlxMVlSRnFTMVNNdkluanNFdkJxbUNwQll0S21KdEYyM1Vo?=
 =?utf-8?B?Y3pPZjMvMSsrY2phSzVlOSs1bEZMSVBOSDhHTVRSMHVOajVybTNNTWY3aWdJ?=
 =?utf-8?B?VnFqd1gweDlucERxSXI2NHgxVTJTU1E3RCthVmM0SEZ1L2ozWEpmL0wrTE4w?=
 =?utf-8?B?TFNYNHlFQ3NaOXV6WjM4Kzk5SEphbkFUSmU5NjYxVHVka0hsQWtXK1hiSWRw?=
 =?utf-8?B?Qzl5blBuK0ZmMUUvM2h1SDJLZ0I3VEdqUDdrQkEwandROHl6VlY5cWs3ei9a?=
 =?utf-8?B?TGw1ZW83ODFBZUpUVGY3Z2RUVzJhL092MDJmcVpreGRyT3ZoSER6NUFKYmxr?=
 =?utf-8?B?K1Q3d2pmN2NnNmZlZkpSQXhQWDV0VjN5OUlZUU5nU2lxVmVWdUQxSnBSaDk2?=
 =?utf-8?B?Yk0zb21ybmVRQnNpQXpma2dSOVEyWkpyUDRBcFFsVWltN1Ivc2h0V2tWOEtt?=
 =?utf-8?B?cTNmc1ZjTjNWTGlwczNQbjAyeEpxNUFvdnp6cFErKzZuYlgyVTd2ejI0Zy9a?=
 =?utf-8?B?QUtCbXpFbk1Pd1pWS0tQYStDY3QwT1VrMWpud1VBTm9YSWJnVE9zYm83WlZk?=
 =?utf-8?B?LzRLQmxHcVE0UDAvanVla3VyVHdsM251amxHQjZ1bXVGRitxS1pWdytNdTlv?=
 =?utf-8?B?QXcxZlppUjQ0ZDdZSmpDWnlZYmFhK2t1bkpmdHozZnh0UEtCSW5aaFVSMFF1?=
 =?utf-8?B?cFYrRVcvUG1qblhvN1cxcEovNlY1cFR2dDNZU3FpTTBmTE1pUWkwbHZnOWNW?=
 =?utf-8?B?Ni8vZlgzMmI5Yk0vSHcvZWtNWmxKVDdiUFBTU2NhUWVRb2ZLTVpSUHZqaFlI?=
 =?utf-8?B?QVNBY3V2SWs2SUUzS2dkeS9UUjArMXJrMEYvMDlzNjRab202VmJYcG1ONDJ3?=
 =?utf-8?B?WUhuR0I4NTVNaUxiQWtwcTBOSUF6WCswdHdQRXNIS3FVKzQ5RnBGWmZVdWhN?=
 =?utf-8?B?SWprWUY0RXgzZWFOL0xkYUt2QTB4dCtoenhsd0lCaHBVNG44SGJPQlJMVWpI?=
 =?utf-8?B?aVRVYXRWcG5waWYyN01ORVlkekpTOTVhUE9WUUthaENoTUtvY0lxTE5mTE04?=
 =?utf-8?B?WVRYOStFU1NCdXRpUzhGU2c5NlJMTUlCdHNqSTF0V2ZxVUh0YkV2NHliV055?=
 =?utf-8?B?Mm56QitEK3ZjVGZ0cyswK2RyZUtZTWtabkxmb3BHQUIwQUU1dVZXaSs1bFdU?=
 =?utf-8?B?UGxrVm1HSEUvcng3UXZRZVI0VjQ2TnZHWERMelJLNnhyZlFzOEVPdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55af2ac7-f0f4-4410-dd66-08de94964058
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 11:10:18.0814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyzSgONmpUk37oHRpUkepbJOlliK7bOyYrny8jr3P6O9InlAINEAx83kjhm71R1v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFDC35F96D4
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



On 3/23/26 17:09, Michal Simek wrote:
> Set the XAE_RAF_BCSTREJ_MASK bit in the Reset and Address Filter (RAF)
> register during hardware initialization to make the MAC drop incoming
> frames with broadcast destination address. This avoids unnecessary
> broadcast traffic processing by the CPU.
> 
> Additionally, when IPv6 is not enabled (CONFIG_IPV6), also set the
> XAE_RAF_MCSTREJ_MASK bit to reject multicast frames. Multicast
> rejection is skipped when IPv6 is configured because IPv6 Neighbor
> Discovery and DHCPv6 rely on multicast.
> 
> Expose the RAF register (offset 0x0) in struct axi_regs which was
> previously hidden in a reserved array.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/net/xilinx_axi_emac.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
> index e9cc5db52d25..1ea81fe1830a 100644
> --- a/drivers/net/xilinx_axi_emac.c
> +++ b/drivers/net/xilinx_axi_emac.c
> @@ -28,6 +28,10 @@
>   #define XAE_EMMC_LINKSPD_100	0x40000000 /* Link Speed mask for 100 Mbit */
>   #define XAE_EMMC_LINKSPD_1000	0x80000000 /* Link Speed mask for 1000 Mbit */
>   
> +/* Reset and Address Filter (RAF) Register bit definitions */
> +#define XAE_RAF_MCSTREJ_MASK	0x00000002 /* Reject rx multicast dst addr */
> +#define XAE_RAF_BCSTREJ_MASK	0x00000004 /* Reject rx broadcast dst addr */
> +
>   /* Interrupt Status/Enable/Mask Registers bit definitions */
>   #define XAE_INT_RXRJECT_MASK	0x00000008 /* Rx frame rejected */
>   #define XAE_INT_MGTRDY_MASK	0x00000080 /* MGT clock Lock */
> @@ -153,7 +157,8 @@ static struct axidma_bd tx_bd __attribute((aligned(DMAALIGN)));
>   static struct axidma_bd rx_bd __attribute((aligned(DMAALIGN)));
>   
>   struct axi_regs {
> -	u32 reserved[3];
> +	u32 raf; /* 0x0: Reset and Address Filter */
> +	u32 reserved[2];
>   	u32 is; /* 0xC: Interrupt status */
>   	u32 reserved2;
>   	u32 ie; /* 0x14: Interrupt enable */
> @@ -528,6 +533,19 @@ static int axi_ethernet_init(struct axidma_priv *priv)
>   	/* Set default MDIO divisor */
>   	writel(XAE_MDIO_DIV_DFT | XAE_MDIO_MC_MDIOEN_MASK, &regs->mdio_mc);
>   
> +	/*
> +	 * Reject broadcast and multicast frames at MAC level to reduce
> +	 * unnecessary traffic processing. Multicast rejection is only
> +	 * enabled when IPv6 is not configured because IPv6 Neighbor
> +	 * Discovery and DHCPv6 rely on multicast.
> +	 */
> +	if (!IS_ENABLED(CONFIG_IPV6))
> +		writel(readl(&regs->raf) | XAE_RAF_MCSTREJ_MASK |
> +		       XAE_RAF_BCSTREJ_MASK, &regs->raf);
> +	else
> +		writel(readl(&regs->raf) | XAE_RAF_BCSTREJ_MASK,
> +		       &regs->raf);
> +
>   	debug("axiemac: InitHw done\n");
>   	return 0;
>   }

Applied.
M
