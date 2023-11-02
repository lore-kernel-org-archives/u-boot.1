Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63446C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 08:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CD0B87620;
	Thu,  2 Nov 2023 09:37:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1HJbFkqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A81A87646; Thu,  2 Nov 2023 09:37:36 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D58CA87622
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 09:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpaxK7/F0ExYGvMsKuKqmMIe9roCoGLBGLxk6tVk1TBLjVytvVCed/FYZaOKoGByfuj6gXX/f47mWyyFIVE0ZKKO6jOScYlwOKmPDHkhxRbwwVzQReqYb6Dc2Nj9RzNfjn0rrEE3cpMkZlCuDfyCx1I1F+CzTYxHwDDb6ZpwFYOsuGhhh5n9djY35aclVNn4hna7RaA16RvR2Tpf3r8meOSsY8CmVYN8Q+MoR1oLYvIDoMbsx3TYN2tqJ5kG7008nmNfofnZFrtFpCRwtuad8cEaC7Kj4kstNoBfnjXJEMpOfmn3j9+JGmS/+895Daos3BbXAnUUGkLFd2UGbBYhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1B6r7nBQ9elRHn+LvMVCcdSEb/hqzWCYTEWCh5FlWA=;
 b=ae6TOj7zDgRa2PqTbDfpLOFK65IikmO1K3EjlF+Kxx1wSfyiRJS/4X1BAFxEDb3c4qY2c7cCjqRbo289yOJ4Z5ygG/yXu4AYXhZBP8jjjva8Q/CFaH05rD6CNp7ZHQabfOEpaxLfdRN0OZa1noBfc75GFAQy5TSPtwa2/vZWUD5o65I8jUPq1RbDLgAbxfwySe5n3PmGBXoLGkZcDI8ntUoSHQKSXtLX08BIucRkguItDtno/2jCQ/xha/RyKsTMtdreKMsDtxtqmfGImxwahx9sGt0RShKFn6KzCFL+SiuHTbbLJHtpMOyHbKTwY7Cpuw7JRTMahPyCWxPOqjOJPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1B6r7nBQ9elRHn+LvMVCcdSEb/hqzWCYTEWCh5FlWA=;
 b=1HJbFkqo7ek21NtR3j+hcP5Z8q0+3C8ZEExXm9S6R7LPf/n+OuUO/+ZFf8Xu0broNCVwMWropgsKGjzUd5IOSJnChKoIvaY2BUuhNl/tjKhqc5Zqd9eikmjZ42UrcRNOeE8Hq+YC4uvLQOg8dzBWbYW4znU+yBRHwI7hdgHvi6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Thu, 2 Nov
 2023 08:37:28 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4993:59af:a31a:abff]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4993:59af:a31a:abff%6]) with mapi id 15.20.6933.029; Thu, 2 Nov 2023
 08:37:28 +0000
Message-ID: <4c31c367-8506-40d6-8060-0776807d461a@amd.com>
Date: Thu, 2 Nov 2023 09:37:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: xilinx_spi: Fixes for MMC_SPI
Content-Language: en-US
To: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20231102082303.354944-1-mchitale@ventanamicro.com>
 <20231102082303.354944-2-mchitale@ventanamicro.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231102082303.354944-2-mchitale@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0143.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::27) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|IA1PR12MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 454f56ee-69e9-4d29-fec7-08dbdb7ef247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lXDXbeMgxMmpi7Sppt3EYfJVwRPwyHF2gqi+6Re334D7knTD42Gcv+1o26sTYJ48YRowOZiwwnOE9c5yz0BnrkhLnGJ4C1vhyOwdaSm6sJQoOY2rrAuEBETuieyb5jdcP9KUPU1oqpwUZ4uactHa57MQopa7KoaEsqgYIN2kbSOnQJTOr+fs031dsv2IBSR2rQppievIp80mgLVHtgXKchQZbWaFSKdVuvUQEwrpGvMaX4OUzjpp9+YfM3+nOEtOUSC8ipkWveGwZESGEpyg5HOV1XBsEg53pBU+u8npra1J2TcJQnAS6937kINuEkMJG6+bIcV2ZbkCmpNljLdU/sbkBRDpI4bBO9sNSV+4OweZJfM4Y/AC7KI1FqZxyZ8QjLC7aNoGafyfSVCV6v4IgbBNhPGuB88D8pLO+1fpSCWs03CrTJjunZ45U9fMn7a9rlotywn1C75cym2P8jbx+UIJp53p3PemttCAwNPYNPz+ygeUOUVryfPt7zO3TA6vpYAKZL2ZdeDJ8wuEP57gZv/j3KI6LQGqi+Dm5g4zucH9ByOV0daJUDTEtFRRrrKU0CVdXxGXhZeGPN/jaKB2XXNKw5j7zWhcFYM+VRWD5K1ZxXWOx/hHLh1+njhRjJo+cuWno9mc2Fj9JtNsUgDIjszg8lJTuOYuYM0lUZDnnTzkY6CtG8GWAcfJzut2TKHu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(136003)(396003)(376002)(230173577357003)(230273577357003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(5660300002)(8936002)(66556008)(66476007)(2906002)(66946007)(316002)(54906003)(110136005)(8676002)(41300700001)(478600001)(6486002)(44832011)(4326008)(6666004)(31686004)(966005)(2616005)(53546011)(6512007)(26005)(6506007)(31696002)(86362001)(36756003)(38100700002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU50L05CaXJnMFlQbVlCdStyRk1VakVFeHRwOHdvaHFDVHByWEg2UzljK3dj?=
 =?utf-8?B?MXU4cEtOUW9yZjZBb2FYMGswdG8yREhzSnpZN2pVMVNSeHZCTThUVm1uWXZG?=
 =?utf-8?B?NGoxTERES3VBdEs3YzVERm9heTUvbHU5Rk9zL1hNRHUrWmV5cTFQaWNmd2NL?=
 =?utf-8?B?aGpsTFJIOXptYmdjUFc2YkVXLzRkenFCaXM4Q1hQSWpXRmk3VzFFRkhMbGtn?=
 =?utf-8?B?Nkk5SlRseFVmY0hqSjg0bFpIMUtKUjVsZURzQ2RPbzlmUTRiNDVkY3RUY1hN?=
 =?utf-8?B?Q09tbTVOZ01pSUk1TG92Uk5vNWRxdUVNTDFiaGg0blZkQ01YTWQzc2NicnRF?=
 =?utf-8?B?YmdiYmszaHgxODZNK3l2L3R4Y1ZVQXc4ZmY2M2J0cVZuV0g5cTh6ZnlydFNq?=
 =?utf-8?B?RFFLeEEzTGhBUUVFcTBRemJsZ2lWU29YRTdxMEVhWVducitmSGlLMkF4Mk10?=
 =?utf-8?B?cVcrdnJkSGV0RzBqdE16RHR3YmlHTmxjR25TbDlkMkdEa3Vwa2JhcE9sUlNi?=
 =?utf-8?B?d1BQYUtJNjdhd0p3bXhTUzBnaTRIdjFraTNFdFpzMDdGazVEU2psMVdZUzhk?=
 =?utf-8?B?SGtycnc2T1R0UmFHY3cvMHRPMkRNQlZqalE4UEJUa3JJbDVMRWViTU9pTGwy?=
 =?utf-8?B?QnJweDVKWjhZR3VxTEZsYTNvcHJzczdxdXFrK2ZueHV3YllBSk94dTV2N0pR?=
 =?utf-8?B?a2FmRnZWSWRQY0dyb2tvUUd6U0hCT20yb0ZhNDFYYzlZbU5yMTBxZDBIS0s1?=
 =?utf-8?B?WS9DNEZQMDNKNkpxU2E3RG9hWlRsZE9ydkgzL0lRTjVua2VvZVQ3MEdQaFh0?=
 =?utf-8?B?eHYrUDJVbFBIbXdHcXFiQm13d1E3U2RwenlqRSsyQWUzeDlaQ1ZRa3d4YWFD?=
 =?utf-8?B?WitKMFZaYWNVc3dyU3l3SnRpYjM5MHpBSjBpRFR6TzFTRVNvY0dQV1ZZRnYw?=
 =?utf-8?B?NE1sKzJreUw0NGZORzFXa3VIQmJyWHBNT1g3WEJneHZnWFlmSDUxUkdiaHpM?=
 =?utf-8?B?cTlSYzY5bWFpR3hkbVMwYUZCT1k4UUwydTlKYnRSYWEwZmJoTDdmTTR5Ri9t?=
 =?utf-8?B?N0F4cjI5Zkc4MTlnTW1XZnRJbHZpc3AycTlxMGRCcndCR1h0cGw4UDU5WmVH?=
 =?utf-8?B?VExrS0h5ZVhJbi9JMzZ0L0kvR0hJOUptbGgwT1BkZVRpSFdJTEFPdGJxUURX?=
 =?utf-8?B?WUtSZ1FhbThnVjFublYva01Gdy94ZGZpU0FBNU9MUy9MZmN1ZXk1V0dxa3U5?=
 =?utf-8?B?U3JlVDY2NjVmWGkycE0wa2FaK3FWZVByUzlMT2R6YjRDSmlLY0ZHZytRaVZy?=
 =?utf-8?B?aFYwUUt1cHp5UHV6SVc5cTdCRUFnTTN3cXdYb29sVkYwZzdkOW04RXR0Smlr?=
 =?utf-8?B?VmRTazVVQTMvS1FaNWVmZHhJQ1JGTTk4M1ltUDIvVkIzRC9KTmxRb0ppSFJw?=
 =?utf-8?B?NDZsS04rVnVpbUhHV2ZUQldlL0hZRW5ObUhwcVN0Rm9BVGFoa2hOaWFYZmtx?=
 =?utf-8?B?RlRFM2toR2wxcWd4NVNGMXZHM2FySEVwMUs5akVac2oveWx3b3RBd091dGpN?=
 =?utf-8?B?MkhRWitoY1VGYndLcWRKQlFnQzkzMjBVaTAzQksrS0xRN0F6enlYNVFYNmNn?=
 =?utf-8?B?LzdnQVF5bGxVVXB0QXU5KzZ3R3hldkw2Q2hTOFA3K2JPRHZSaXQ5SEltOEFC?=
 =?utf-8?B?T1VJcWgzVk44ZW5LK2gwWTVDdlIyZU43eW1JVWFqdDA0cGdzL0JtVUE3UUZW?=
 =?utf-8?B?RXZHMGpZdXllMEk1VmkxNjc5Q1U2YVBEbCtEemlrT1lTeGZtRmN4WGRxcDN1?=
 =?utf-8?B?eFRpUUQvSS9vQnhTVVNUb2gxY1gxM2xubVVqWW9LOE0vVVBrWEdPanZTZ1lq?=
 =?utf-8?B?Q2tmSURaaFllZm5KMXRpall1TjgzMWw4NGxIWnduNmw0N0VyN3I0c2Z6blR2?=
 =?utf-8?B?N3YxOXdwcS9FVHlYRlAzcEpwd2YyYXdFTlBqYnljbVpXVzZVVHBJWk53RFZX?=
 =?utf-8?B?VDlTNFZxWmNJM3ZwVFBVUk1IeEVpeWIxMThOSkl6YUtuT3hjNWYyV0Z6UG1E?=
 =?utf-8?B?L0srUUttN0YvdXU5NEVzZm5BdmordnNLaFh0dGNFZ09zZlVMQ0J1UWhpRHJO?=
 =?utf-8?Q?5JfeuJGAoBi/trK+3jORpH4Xo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454f56ee-69e9-4d29-fec7-08dbdb7ef247
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 08:37:28.1376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8K74yzo8aVbU7MFCW7kDSongrHk1qR6FjKv6UXqX+/AX7n3NzFId3Sxq9dfbE26
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734
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

On 11/2/23 09:23, Mayuresh Chitale wrote:
> Add the xfer callback which is used by the MMC_SPI driver and generally by
> the dm_spi_xfer callback. Also probe the fifo_depth during init as is
> done in the linux spi-xilinx driver and fix a compiler warning while at it.

They are independent things that's why please separate them by that topics.

Also update subject to describe issue there.

> 
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> ---
>   drivers/spi/xilinx_spi.c | 70 ++++++++++++++++++++++++++++++----------
>   1 file changed, 53 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
> index b58a3f632a..0d4ff25600 100644
> --- a/drivers/spi/xilinx_spi.c
> +++ b/drivers/spi/xilinx_spi.c
> @@ -67,7 +67,7 @@
>   /* SPI Slave Select Register (spissr), [1] p13, [2] p13 */
>   #define SPISSR_MASK(cs)		(1 << (cs))
>   #define SPISSR_ACT(cs)		~SPISSR_MASK(cs)
> -#define SPISSR_OFF		~0UL
> +#define SPISSR_OFF		(~0U)
>   
>   /* SPI Software Reset Register (ssr) */
>   #define SPISSR_RESET_VALUE	0x0a
> @@ -109,6 +109,27 @@ struct xilinx_spi_priv {
>   	u8 startup;
>   };
>   
> +/* Detect fifo depth. Ported from linux sha: 4c9a761402d78 */

don't add linux sha1 here.
Add it to commit message or I normally just provide a link to that patch.
https://lore.kernel.org/r/1422029330-10971-5-git-send-email-ricardo.ribalda@gmail.com



> +static int xilinx_spi_find_buffer_size(struct xilinx_spi_regs *regs)
> +{
> +	u8 sr;
> +	int n_words = 0;
> +
> +	/*
> +	 * Before the buffer_size detection we reset the core
> +	 * to make sure we start with a clean state.
> +	 */
> +	writel(SPISSR_RESET_VALUE, &regs->srr);
> +
> +	/* Fill the Tx FIFO with as many words as possible */
> +	do {
> +		writel(0, &regs->spidtr);
> +		sr = readl(&regs->spisr);
> +		n_words++;
> +	} while (!(sr & SPISR_TX_FULL));
> +
> +	return n_words;
> +}

newline here.

>   static int xilinx_spi_probe(struct udevice *bus)
>   {
>   	struct xilinx_spi_priv *priv = dev_get_priv(bus);
> @@ -116,6 +137,8 @@ static int xilinx_spi_probe(struct udevice *bus)
>   
>   	regs = priv->regs = dev_read_addr_ptr(bus);
>   	priv->fifo_depth = dev_read_u32_default(bus, "fifo-size", 0);
> +	if (!priv->fifo_depth)
> +		priv->fifo_depth = xilinx_spi_find_buffer_size(regs);
>   
>   	writel(SPISSR_RESET_VALUE, &regs->srr);
>   
> @@ -197,7 +220,7 @@ static u32 xilinx_spi_fill_txfifo(struct udevice *bus, const u8 *txp,
>   	return i;
>   }
>   
> -static u32 xilinx_spi_read_rxfifo(struct udevice *bus, u8 *rxp, u32 rxbytes)
> +static u32 xilinx_spi_read_rxfifo(struct udevice *bus, u8 *rxp, int rxbytes)

Unrelated. Or do we have a case where we ask for reading negative number of bytes?

>   {
>   	struct xilinx_spi_priv *priv = dev_get_priv(bus);
>   	struct xilinx_spi_regs *regs = priv->regs;
> @@ -217,9 +240,9 @@ static u32 xilinx_spi_read_rxfifo(struct udevice *bus, u8 *rxp, u32 rxbytes)
>   	return i;
>   }
>   
> -static int start_transfer(struct spi_slave *spi, const void *dout, void *din, u32 len)
> +static int start_transfer(struct udevice *dev, const void *dout, void *din, u32 len)

All these spi -> dev changes should be in separate patch. I expect they are 
preparation for xfer but still better to do it separately.

>   {
> -	struct udevice *bus = spi->dev->parent;
> +	struct udevice *bus = dev->parent;
>   	struct xilinx_spi_priv *priv = dev_get_priv(bus);
>   	struct xilinx_spi_regs *regs = priv->regs;
>   	u32 count, txbytes, rxbytes;
> @@ -259,10 +282,9 @@ static int start_transfer(struct spi_slave *spi, const void *dout, void *din, u3
>   	return 0;
>   }
>   
> -static void xilinx_spi_startup_block(struct spi_slave *spi)
> +static void xilinx_spi_startup_block(struct udevice *dev)
>   {
> -	struct dm_spi_slave_plat *slave_plat =
> -				dev_get_parent_plat(spi->dev);
> +	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
>   	unsigned char txp;
>   	unsigned char rxp[8];
>   
> @@ -270,13 +292,25 @@ static void xilinx_spi_startup_block(struct spi_slave *spi)
>   	 * Perform a dummy read as a work around for
>   	 * the startup block issue.
>   	 */
> -	spi_cs_activate(spi->dev, slave_plat->cs);
> +	spi_cs_activate(dev, slave_plat->cs);
>   	txp = 0x9f;
> -	start_transfer(spi, (void *)&txp, NULL, 1);
> +	start_transfer(dev, (void *)&txp, NULL, 1);
>   
> -	start_transfer(spi, NULL, (void *)rxp, 6);
> +	start_transfer(dev, NULL, (void *)rxp, 6);
>   
> -	spi_cs_deactivate(spi->dev);
> +	spi_cs_deactivate(dev);
> +}
> +
> +static int xilinx_spi_xfer(struct udevice *dev, unsigned int bitlen,
> +			   const void *dout, void *din, unsigned long flags)
> +{
> +	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
> +	int ret;
> +
> +	spi_cs_activate(dev, slave_plat->cs);
> +	ret = start_transfer(dev, dout, din, (bitlen / 8));

no need for () around

> +	spi_cs_deactivate(dev);
> +	return ret;
>   }
>   
>   static int xilinx_spi_mem_exec_op(struct spi_slave *spi,
> @@ -294,14 +328,15 @@ static int xilinx_spi_mem_exec_op(struct spi_slave *spi,
>   	 * as QSPI provides command. So first command fails.
>   	 */
>   	if (!startup) {
> -		xilinx_spi_startup_block(spi);
> +		xilinx_spi_startup_block(spi->dev);
>   		startup++;
>   	}
>   
>   	spi_cs_activate(spi->dev, slave_plat->cs);
>   
>   	if (op->cmd.opcode) {
> -		ret = start_transfer(spi, (void *)&op->cmd.opcode, NULL, 1);
> +		ret = start_transfer(spi->dev, (void *)&op->cmd.opcode,
> +				     NULL, 1);
>   		if (ret)
>   			goto done;
>   	}
> @@ -313,7 +348,7 @@ static int xilinx_spi_mem_exec_op(struct spi_slave *spi,
>   			addr_buf[i] = op->addr.val >>
>   			(8 * (op->addr.nbytes - i - 1));
>   
> -		ret = start_transfer(spi, (void *)addr_buf, NULL,
> +		ret = start_transfer(spi->dev, (void *)addr_buf, NULL,
>   				     op->addr.nbytes);
>   		if (ret)
>   			goto done;
> @@ -322,16 +357,16 @@ static int xilinx_spi_mem_exec_op(struct spi_slave *spi,
>   		dummy_len = (op->dummy.nbytes * op->data.buswidth) /
>   			     op->dummy.buswidth;
>   
> -		ret = start_transfer(spi, NULL, NULL, dummy_len);
> +		ret = start_transfer(spi->dev, NULL, NULL, dummy_len);
>   		if (ret)
>   			goto done;
>   	}
>   	if (op->data.nbytes) {
>   		if (op->data.dir == SPI_MEM_DATA_IN) {
> -			ret = start_transfer(spi, NULL,
> +			ret = start_transfer(spi->dev, NULL,
>   					     op->data.buf.in, op->data.nbytes);
>   		} else {
> -			ret = start_transfer(spi, op->data.buf.out,
> +			ret = start_transfer(spi->dev, op->data.buf.out,
>   					     NULL, op->data.nbytes);
>   		}
>   		if (ret)
> @@ -427,6 +462,7 @@ static const struct spi_controller_mem_ops xilinx_spi_mem_ops = {
>   static const struct dm_spi_ops xilinx_spi_ops = {
>   	.claim_bus	= xilinx_spi_claim_bus,
>   	.release_bus	= xilinx_spi_release_bus,
> +	.xfer           = xilinx_spi_xfer,
>   	.set_speed	= xilinx_spi_set_speed,
>   	.set_mode	= xilinx_spi_set_mode,
>   	.mem_ops	= &xilinx_spi_mem_ops,

M
