Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBDBC46CA1
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 10:30:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27793871E4;
	Thu, 19 Oct 2023 12:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vv2NXFpr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5B7287213; Thu, 19 Oct 2023 12:30:42 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6775586F8B
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 12:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CH0A4t4xEs69aDID0hJz8SIqefj/ZH2RylO8F9nPQyw+k4rOJKEIPPZnxm9heMxJzlqXhCAmxNq6CCCFHr/V/Qinm1xjT8dQz6mCddJTXFWCsQk2jcwRufrjjTkfOuSE8iewlsfHokL2aX/wP7ok78nJKhIcWFRa6DJ8t0nrBYHz2Bo6jUwSjkfM3rGRe/0/cXtSPcZo8FWDK6yVIwe/watUQLBpQc/l1/+Vo4RyuMN95qk6lw2RGPUmXJ9kOAq7Q+raN/wCeAAUok9nyD9uQEWs3jmw7eldH0hX8XCKWoUmy5ghkMvSmmt/9uU6URQ859jV1/ISY8Y+ci0IiJkstw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXtcGhoCYwm26bNjS9izYpHK7cxGgFC6YeKKE950m/s=;
 b=CGGBCks6EtwDdVmF9qL/rbDuvDqrBV3YYCPy2C16Hh1w4W4V7fK5XqepI1dVT7iBdPpRUZYo1kKqFv/GYuDuH4xM19jCYZGBBlyUHqaeU32KgE+NneHiE82ZQ40W7eUz29vo7kwWqkACLhvPz4esvAnbpWhJQB9SUdrO6JHk/IrxSouGLPO/l29b/5UjQ4GKLx7a4v9HK+QbS9tkYSToRISl1eEVl3Q9Lmz6GlRd+Zo+mgGZ9QkbQgyHK72FwYXe5uYpthVqbvFhBJAKLvk+ra2hKgeF2DQVtKdGWDotwGZ4YAVyMrvvowFKxn9hdiiHLodvDiVGmQ6+yT9s3EYZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXtcGhoCYwm26bNjS9izYpHK7cxGgFC6YeKKE950m/s=;
 b=vv2NXFpr+dbClaDha2vECX1L1hzVTxPY9TCignJLnYswVEQCwyT7VD4EG8/yao/NEoFckJEE0saDpnsSCsYkOJ2whQ5UYFvmtLqcVRboOxao0uDRQCm7LxaJa6i3IeD2zhTikIVg2o18jOOGjLk91CXqnVJR+7z8snIAQ6/QZV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Thu, 19 Oct
 2023 10:30:37 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 10:30:37 +0000
Message-ID: <0153dc95-0ff3-49c2-9c70-b997e9b10076@amd.com>
Date: Thu, 19 Oct 2023 12:30:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] zynqmp: migrate gqspi debug to logging
Content-Language: en-US
To: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, u-boot@lists.denx.de,
 git@xilinx.com
References: <20231013123739.2757979-1-ibai.erkiaga-elorza@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231013123739.2757979-1-ibai.erkiaga-elorza@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0066.eurprd03.prod.outlook.com
 (2603:10a6:803:50::37) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 407b7cc5-5591-4110-0d9a-08dbd08e6f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bumShsj0n4LuibvwXSFsVkhzjZTHdMWCNU3bQOb61Z9mqjBL/8zlOjkeM+WyzhJlXptzbQQ1A8QQ8GhVfnhkioWIeGGkE7L1h/Q6lst45kxflof8ZcCJ9sqC9xdxXnl6erJAk2XkRlD6ztmfoZyaWcjtf+aB6FB3Ecpc4OR24o4rnfWUo6amhXjtwAdGP15q6pCnYifDVjHKGeiw07oSAqJRB99ylazfFihEa7oVEC2gXJYYWHgnW7sTzWc15oO8wGpWjbqHBkIchJk8146GhAG5ihJ0TwED5zPyNg6V0gSmer0YoZXNroOlRt9fq3crvg35R6EJdK7GSEw670nn6jLm0hB5Z66s0IH80txMdKwR5ErFSz5RtZ1cgPFGcGwXI0emQ9VohSg9jXDAzRL9tLFkuUe//g8n0TBFW2+gAyb568ybPQJJuWYbfw4Mq7vEilfPqBqCruarm+O8Z0guh1jGT8KU0Q8P+OrrVdGzm8CzVsTzGUq6arzWsZ6NRVdy0+qVftzL2eb4uOeKCt0MB8RmY8RoBONqpTiiMdjV/HVhi1m8V/ntE+wXu4S4FRMFeVL+jdicF1Qh/sf7uO+QCy+gH/naKHrUVeJkUCaI8jECRAlge4/O1IzvgeC2CStj5cb2xj2I0iDRZz1fdN3j1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(346002)(136003)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(36756003)(44832011)(5660300002)(66476007)(66556008)(41300700001)(316002)(8936002)(2906002)(8676002)(31696002)(86362001)(66946007)(31686004)(83380400001)(38100700002)(478600001)(6666004)(6512007)(53546011)(6506007)(2616005)(26005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmhybVhoWnRCWDVRV04zSUduQzIrV0UxeU1wNjdsQ0tSZG9GZE5uYThETUw5?=
 =?utf-8?B?cWlXc3lLUjVVUUlwZC9yN05ZZE9oaUEvb2dnNnUwMkZDWjNjdFhqeFdKcUNQ?=
 =?utf-8?B?TFFIeHNaTTlZR1RxeWdpNkl3dk0rRHowcktpV0d4TkhDSUlzZ2EyeWUxNUd1?=
 =?utf-8?B?K3NLOXdqUjA0R3QwdEFtRm9KWWl2NWQrcGpaalpwRzRqY0RXWndqa0FVN3VW?=
 =?utf-8?B?VGxhV2FPdjZPeHVPTGU5T0dtRGlYQjErYUQ4TGM2QkdJUjFjU20yTlcrSmtv?=
 =?utf-8?B?anpyc0dWS0VBcGZqdHRTY1ByTlBrRnIzMlplRVpEN3JHVWxreGd1Nmk0ZTIy?=
 =?utf-8?B?OU1pa3UwR05VVXVyQ0M1aHdHMm95cVBKaEk0Um4zWHRjRlBQTFJBUWd3OHJ1?=
 =?utf-8?B?MEc1UWRIUnFzanV3RzVRY0pQbFM2MndCbWV6REtJaXRyWHpsc3lWVmJJcVZ6?=
 =?utf-8?B?ckMwUXdJaHBQaUtWc0huVlpUNFNBZW01NW5QZUhieEhnaDFUUFZxL3cxeUJD?=
 =?utf-8?B?cDNSRlRBSkk0OTZtWWpsdnVhaExHdkVwYVJjL21PMjRuNzJsRTh1MFFFbWd4?=
 =?utf-8?B?MnVjTFlRcnlWWENMY2NiemNGb3YzR241cGYydEVYdHRMMFpqeTR4VDZhdTl1?=
 =?utf-8?B?bU1OUW5OYXdUUXJWM09ocFNDNTdCWWhDZmcrZjROK2k2S3ZiWk10dHB3WXpF?=
 =?utf-8?B?VlcrVG9VL0VGZXgxTHR5cW1EeDcrY28xdTZ2cmQxd3o3WU1CdklmZnlUM0dx?=
 =?utf-8?B?M01lZFBmYVczZ3FKR1dNaFBrSUpzUWoranBLRkRyQXJkbjV6c2x4aUQ3dDF2?=
 =?utf-8?B?VkJHeTgwdmpDRDI1V1Jib1ZVN1pNUjFxQjdnc1NzOWxmSEFZaHNaeExHLzhO?=
 =?utf-8?B?WHM4OHp6cnZiTHpUMW5yTVkrUGNsUXE3M0ZhZW5xdjE0d3M5cXN3dXcySlEz?=
 =?utf-8?B?KzJSK2tsN2cvK3R5VGRnUU5TQ096SjRES21RQ0VBTjJ6TGtoZmJISnlPdW5Z?=
 =?utf-8?B?VkFqQlE2MGw3RDY4b1lXK0huV3Y3OUxOc2VOQVl4Z04yVFRMTzRvYjEzbWFP?=
 =?utf-8?B?aVUvWTJnenpiNWxzbEVpNWRrcFZORzJFUnhxMHllUzlNSk9PbmM5ellSYlN1?=
 =?utf-8?B?MXZmSEpaNFZEYm1pRnZxazk0b25SRnk4WVNBbHNTcXdURlFYTS9SbkkxcTRO?=
 =?utf-8?B?bmxtU2YrVzdNaWF3a0E2OVR3MzVPbWRQbDJLZGdhd01qTlB2bGFTTmE5dFBq?=
 =?utf-8?B?Yk1hN2c3TS9XVmEzZm5XTnF4S2xKSkVqNFAvRkNpQmRYdzd2WlFaa2JiM3lV?=
 =?utf-8?B?Q1NLZk1QYzlvSDFvTmxkVHlpVjZLLzBGY09KaWI2MnpGeFUrenBYbGJ2d2pq?=
 =?utf-8?B?cHZweFZmWXFSaGxiUE9Ud2lhN0QyVmhtSGlvRkxaM2Zla3ZLOXZWb2UwSXR4?=
 =?utf-8?B?b2ZlMkRHMzljLzErUFN3Vzgwcm1NTFdGL0trM2xVVk9DQndMR0dsY3hObThk?=
 =?utf-8?B?eVRJeWdMRXhiajBMUC9GQTBDTGtzaWRvVHFpeGViaGxPSjg1eGdGSC9tdml4?=
 =?utf-8?B?K3NjV1BlZXVmbWJUOEt2aVBPSUJHQUx1VWpZRmRtS2NuSGNyVGJDb3RtVXFV?=
 =?utf-8?B?WDV0SERKUXlOZVNLMEFseUdVMHd2am93UlFLaTlVak1PLzZ5cmZnN3RPWDdn?=
 =?utf-8?B?QnRxN3FJL211NjdwcFlSMFhRK3FNN1VWUWg5aThIN0NjTFN2cjBaUjRyamFO?=
 =?utf-8?B?SXFUTkJDWHJWTGhJOWpKYWRUSGhuTGE2L09NREdXSVZtVnZkMXYvY2pKQWty?=
 =?utf-8?B?RUNCNFJmK2dNQ3dRb2hSUytVemdpR1BJUjVLSEhMNmVkTWxuUkpWSm85bnMy?=
 =?utf-8?B?VThLWXlzNWppSkN2K1I5ajFXZy9jdkFuQVV5a2ptbnAyUW55V2w5aHNydFRz?=
 =?utf-8?B?S09pRG1QcmpxVXNwYTJ0N1B6VUxkVlQrVlFxR2dNQVhLamN6TENaTzY4OHds?=
 =?utf-8?B?MzdqZTdRQjlpZGEwcTV5Q3ZaYWtVNkhZbjJsL3QrWEowd1JoSndheWJaV2wz?=
 =?utf-8?B?Y2h3d0pXL2p3REg1Q2srRmtGYi9zNWlwNXh3K3FQMDNqM1B2UUJMZ0x3L2h6?=
 =?utf-8?Q?fwSfRr7bcwfzy20KFk1fw70Sb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407b7cc5-5591-4110-0d9a-08dbd08e6f04
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:30:37.0754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEEhYBBzQBoHgeHimP6nFGJuF6cfU6Z2gabz0iZZP9JvaA8147jXGqZkY8ht5LYF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166
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



On 10/13/23 14:37, Ibai Erkiaga wrote:
> The following patch migrates the usage of debug and printf functions
> to the relevant logging function as per U-Boot DM guidelines.
> 
> Additionally some of the debugging statements have been rearanged for
> a more meaningfull debug experience.
> 
> aarch64-linux-gnu-size reports 229 bytes less when debug is enabled at
> file level, while is just 5bytes more when disabled.
> 
> Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
> ---
>   drivers/spi/zynqmp_gqspi.c | 82 +++++++++++++++-----------------------
>   1 file changed, 33 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
> index ec59ef5804..a323994fb2 100644
> --- a/drivers/spi/zynqmp_gqspi.c
> +++ b/drivers/spi/zynqmp_gqspi.c
> @@ -5,6 +5,8 @@
>    * Xilinx ZynqMP Generic Quad-SPI(QSPI) controller driver(master mode only)
>    */
>   
> +#define LOG_CATEGORY UCLASS_SPI
> +
>   #include <common.h>
>   #include <cpu_func.h>
>   #include <log.h>
> @@ -192,8 +194,6 @@ static int zynqmp_qspi_of_to_plat(struct udevice *bus)
>   {
>   	struct zynqmp_qspi_plat *plat = dev_get_plat(bus);
>   
> -	debug("%s\n", __func__);
> -
>   	plat->regs = (struct zynqmp_qspi_regs *)(dev_read_addr(bus) +
>   						 GQSPI_REG_OFFSET);
>   	plat->dma_regs = (struct zynqmp_qspi_dma_regs *)
> @@ -250,7 +250,7 @@ static u32 zynqmp_qspi_genfifo_mode(u8 buswidth)
>   	case 4:
>   		return GQSPI_SPI_MODE_QSPI;
>   	default:
> -		debug("Unsupported bus width %u\n", buswidth);
> +		log_warning("Unsupported bus width %u\n", buswidth);
>   		return GQSPI_SPI_MODE_SPI;
>   	}
>   }
> @@ -262,6 +262,8 @@ static void zynqmp_qspi_fill_gen_fifo(struct zynqmp_qspi_priv *priv,
>   	u32 config_reg, ier;
>   	int ret = 0;
>   
> +	log_content("%s, GFIFO_CMD: 0x%X\n", __func__, gqspi_fifo_reg);
> +
>   	writel(gqspi_fifo_reg, &regs->genfifo);
>   
>   	config_reg = readl(&regs->confr);
> @@ -278,7 +280,7 @@ static void zynqmp_qspi_fill_gen_fifo(struct zynqmp_qspi_priv *priv,
>   	ret = wait_for_bit_le32(&regs->isr, GQSPI_IXR_GFEMTY_MASK, 1,
>   				GQSPI_TIMEOUT, 1);
>   	if (ret)
> -		printf("%s Timeout\n", __func__);
> +		log_warning("%s, Timeout\n", __func__);
>   
>   }
>   
> @@ -286,6 +288,8 @@ static void zynqmp_qspi_chipselect(struct zynqmp_qspi_priv *priv, int is_on)
>   {
>   	u32 gqspi_fifo_reg = 0;
>   
> +	log_debug("%s, assert: %d\r\n", __func__, is_on);
> +
>   	if (is_on) {
>   		gqspi_fifo_reg = zynqmp_qspi_bus_select(priv);
>   		gqspi_fifo_reg |= GQSPI_SPI_MODE_SPI |
> @@ -295,8 +299,6 @@ static void zynqmp_qspi_chipselect(struct zynqmp_qspi_priv *priv, int is_on)
>   		gqspi_fifo_reg |= GQSPI_IMD_DATA_CS_DEASSERT;
>   	}
>   
> -	debug("GFIFO_CMD_CS: 0x%x\n", gqspi_fifo_reg);
> -
>   	zynqmp_qspi_fill_gen_fifo(priv, gqspi_fifo_reg);
>   }
>   
> @@ -311,8 +313,8 @@ static void zynqmp_qspi_set_tapdelay(struct udevice *bus, u32 baudrateval)
>   	clk_rate = plat->frequency;
>   	reqhz = (clk_rate / (GQSPI_BAUD_DIV_SHIFT << baudrateval));
>   
> -	debug("%s, req_hz:%d, clk_rate:%d, baudrateval:%d\n",
> -	      __func__, reqhz, clk_rate, baudrateval);
> +	log_debug("%s, clk_rate:%d, baudrateval:%d, bus_clk: %d\n",
> +		  __func__, clk_rate, baudrateval, reqhz);
>   
>   	if (!(IS_ENABLED(CONFIG_ARCH_VERSAL) ||
>   	      IS_ENABLED(CONFIG_ARCH_VERSAL_NET))) {
> @@ -362,7 +364,8 @@ static int zynqmp_qspi_set_speed(struct udevice *bus, uint speed)
>   	u32 confr;
>   	u8 baud_rate_val = 0;
>   
> -	debug("%s\n", __func__);
> +	log_debug("%s, Speed: %d, Max: %d\n", __func__, speed, plat->frequency);
> +
>   	if (speed > plat->frequency)
>   		speed = plat->frequency;
>   
> @@ -383,9 +386,8 @@ static int zynqmp_qspi_set_speed(struct udevice *bus, uint speed)
>   		confr &= ~GQSPI_BAUD_DIV_MASK;
>   		confr |= (baud_rate_val << 3);
>   		writel(confr, &regs->confr);
> -		zynqmp_qspi_set_tapdelay(bus, baud_rate_val);
>   
> -		debug("regs=%p, speed=%d\n", priv->regs, plat->speed_hz);
> +		zynqmp_qspi_set_tapdelay(bus, baud_rate_val);
>   	}
>   
>   	return 0;
> @@ -399,8 +401,6 @@ static int zynqmp_qspi_probe(struct udevice *bus)
>   	unsigned long clock;
>   	int ret;
>   
> -	debug("%s: bus:%p, priv:%p\n", __func__, bus, priv);
> -
>   	priv->regs = plat->regs;
>   	priv->dma_regs = plat->dma_regs;
>   	priv->io_mode = plat->io_mode;
> @@ -416,7 +416,6 @@ static int zynqmp_qspi_probe(struct udevice *bus)
>   		dev_err(bus, "failed to get rate\n");
>   		return clock;
>   	}
> -	debug("%s: CLK %ld\n", __func__, clock);
>   
>   	ret = clk_enable(&clk);
>   	if (ret) {
> @@ -429,6 +428,8 @@ static int zynqmp_qspi_probe(struct udevice *bus)
>   	/* init the zynq spi hw */
>   	zynqmp_qspi_init_hw(priv);
>   
> +	log_debug("%s, Rerence clock frequency: %ld\n", __func__, clock);
> +
>   	return 0;
>   }
>   
> @@ -438,7 +439,8 @@ static int zynqmp_qspi_set_mode(struct udevice *bus, uint mode)
>   	struct zynqmp_qspi_regs *regs = priv->regs;
>   	u32 confr;
>   
> -	debug("%s\n", __func__);
> +	log_debug("%s, 0x%X\n", __func__, mode);
> +
>   	/* Set the SPI Clock phase and polarities */
>   	confr = readl(&regs->confr);
>   	confr &= ~(GQSPI_CONFIG_CPHA_MASK | GQSPI_CONFIG_CPOL_MASK);
> @@ -461,16 +463,11 @@ static int zynqmp_qspi_fill_tx_fifo(struct zynqmp_qspi_priv *priv, u32 size)
>   	u32 *buf = (u32 *)priv->tx_buf;
>   	u32 len = size;
>   
> -	debug("TxFIFO: 0x%x, size: 0x%x\n", readl(&regs->isr),
> -	      size);
> -
>   	while (size) {
>   		ret = wait_for_bit_le32(&regs->isr, GQSPI_IXR_TXNFULL_MASK, 1,
>   					GQSPI_TIMEOUT, 1);
> -		if (ret) {
> -			printf("%s: Timeout\n", __func__);
> -			return ret;
> -		}
> +		if (ret)
> +			return log_msg_ret("Timeout\n", ret);
>   
>   		if (size >= 4) {
>   			writel(*buf, &regs->txd0r);
> @@ -501,10 +498,8 @@ static int zynqmp_qspi_fill_tx_fifo(struct zynqmp_qspi_priv *priv, u32 size)
>   
>   	ret = wait_for_bit_le32(&regs->isr, GQSPI_IXR_TXFIFOEMPTY_MASK, 1,
>   				GQSPI_TIMEOUT, 1);
> -	if (ret) {
> -		printf("%s: Timeout\n", __func__);
> -		return ret;
> -	}
> +	if (ret)
> +		return log_msg_ret("Timeout\n", ret);
>   
>   	priv->tx_buf += len;
>   	return 0;
> @@ -516,6 +511,9 @@ static void zynqmp_qspi_genfifo_cmd(struct zynqmp_qspi_priv *priv)
>   	u32 gen_fifo_cmd;
>   	u8 i, dummy_cycles, addr;
>   
> +	log_debug("%s, opcode: 0x%0X, addr.nbytes: %d, dummy.mbytes: %d\r\n",
> +		  __func__, op->cmd.opcode, op->addr.nbytes, op->dummy.nbytes);
> +
>   	/* Send opcode */
>   	gen_fifo_cmd = zynqmp_qspi_bus_select(priv);
>   	gen_fifo_cmd |= zynqmp_qspi_genfifo_mode(op->cmd.buswidth);
> @@ -532,8 +530,6 @@ static void zynqmp_qspi_genfifo_cmd(struct zynqmp_qspi_priv *priv)
>   		gen_fifo_cmd |= GQSPI_GFIFO_TX;
>   		gen_fifo_cmd |= addr;
>   
> -		debug("GFIFO_CMD_Cmd = 0x%x\n", gen_fifo_cmd);
> -
>   		zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
>   	}
>   
> @@ -583,6 +579,8 @@ static int zynqmp_qspi_genfifo_fill_tx(struct zynqmp_qspi_priv *priv)
>   	u32 len;
>   	int ret = 0;
>   
> +	log_debug("%s, length: %d\r\n", __func__, priv->len);
> +
>   	gen_fifo_cmd = zynqmp_qspi_bus_select(priv);
>   	gen_fifo_cmd |= zynqmp_qspi_genfifo_mode(priv->op->data.buswidth);
>   	gen_fifo_cmd |= GQSPI_GFIFO_TX | GQSPI_GFIFO_DATA_XFR_MASK;
> @@ -591,8 +589,6 @@ static int zynqmp_qspi_genfifo_fill_tx(struct zynqmp_qspi_priv *priv)
>   		len = zynqmp_qspi_calc_exp(priv, &gen_fifo_cmd);
>   		zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
>   
> -		debug("GFIFO_CMD_TX:0x%x\n", gen_fifo_cmd);
> -
>   		if (gen_fifo_cmd & GQSPI_GFIFO_EXP_MASK)
>   			ret = zynqmp_qspi_fill_tx_fifo(priv, 1 << len);
>   		else
> @@ -608,7 +604,6 @@ static int zynqmp_qspi_start_io(struct zynqmp_qspi_priv *priv,
>   				u32 gen_fifo_cmd, u32 *buf)
>   {
>   	u32 len;
> -	u32 actuallen = priv->len;
>   	u32 config_reg, ier, isr;
>   	u32 timeout = GQSPI_TIMEOUT;
>   	struct zynqmp_qspi_regs *regs = priv->regs;
> @@ -623,7 +618,7 @@ static int zynqmp_qspi_start_io(struct zynqmp_qspi_priv *priv,
>   		else
>   			priv->bytes_to_receive = len;
>   		zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
> -		debug("GFIFO_CMD_RX:0x%x\n", gen_fifo_cmd);
> +
>   		/* Manual start */
>   		config_reg = readl(&regs->confr);
>   		config_reg |= GQSPI_STRT_GEN_FIFO;
> @@ -652,13 +647,8 @@ static int zynqmp_qspi_start_io(struct zynqmp_qspi_priv *priv,
>   			}
>   		}
>   
> -		debug("buf:0x%lx, rxbuf:0x%lx, *buf:0x%x len: 0x%x\n",
> -		      (unsigned long)buf, (unsigned long)priv->rx_buf,
> -		      *buf, actuallen);
> -		if (!timeout) {
> -			printf("IO timeout: %d\n", readl(&regs->isr));
> -			return -1;
> -		}
> +		if (!timeout)
> +			return log_msg_retz("Timeout\n", timeout);
>   	}
>   
>   	return 0;
> @@ -695,26 +685,18 @@ static int zynqmp_qspi_start_dma(struct zynqmp_qspi_priv *priv,
>   		while (priv->len) {
>   			zynqmp_qspi_calc_exp(priv, &gen_fifo_cmd);
>   			zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
> -
> -			debug("GFIFO_CMD_RX:0x%x\n", gen_fifo_cmd);
>   		}
>   
>   		ret = wait_for_bit_le32(&dma_regs->dmaisr,
>   					GQSPI_DMA_DST_I_STS_DONE, 1,
>   					GQSPI_TIMEOUT, 1);
> -		if (ret) {
> -			printf("DMA Timeout:0x%x\n", readl(&dma_regs->dmaisr));
> -			return -ETIMEDOUT;
> -		}
> +		if (ret)
> +			return log_msg_ret("Timeout:\n", ret);
>   
>   		invalidate_dcache_range(addr, addr + size);
>   
>   		writel(GQSPI_DMA_DST_I_STS_DONE, &dma_regs->dmaisr);
>   
> -		debug("buf:0x%lx, rxbuf:0x%lx, *buf:0x%x len: 0x%x\n",
> -		      (unsigned long)buf, (unsigned long)priv->rx_buf, *buf,
> -		      actuallen);
> -
>   		if (buf != priv->rx_buf)
>   			memcpy(priv->rx_buf, buf, actuallen);
>   
> @@ -731,6 +713,8 @@ static int zynqmp_qspi_genfifo_fill_rx(struct zynqmp_qspi_priv *priv)
>   	u32 *buf;
>   	u32 actuallen = priv->len;
>   
> +	log_debug("%s, length: %d\r\n", __func__, priv->len);
> +
>   	gen_fifo_cmd = zynqmp_qspi_bus_select(priv);
>   	gen_fifo_cmd |= zynqmp_qspi_genfifo_mode(priv->op->data.buswidth);
>   	gen_fifo_cmd |= GQSPI_GFIFO_RX | GQSPI_GFIFO_DATA_XFR_MASK;


Applied.
M
