Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79D0CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 10:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37F9587217;
	Thu, 19 Oct 2023 12:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RYhIT45d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFD6387204; Thu, 19 Oct 2023 12:29:29 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B6FE87203
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 12:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMrKPL6f3ID+uf4QtF2YRatfBE93f3yqtkSkaBNzCcGTqSmNUBRKKYH5JZcl+M34YpTBzSeNZTEQrlacE8o9oDnhq4tE2X+GnJwrcPAHyFvA9Qs+S46TZcBNiz+pfpbKiU/8DiY1W4KKhM5YEG3+h8Xkl0aUlGFwip+L+rWbFMSTnXYMd4zNxGgjFwNJcGgRy0AWCZYkxivmO5K9B2dXlUG0o4v+/HNt2iVdSIxTeIifbV+5JOdwgDc2Qoi7Lgwmty1TLYssimHvgyYIJ3eveVCbPu28CvmKKh46VWwn8LbZEkM8yRpuCD56/uoWNSzhleQj4sC11wZG9bIn3EHTsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbnevqUg/1lNbu9n6kOy6LlRFax2a5eR4LGDdqE4mZM=;
 b=NAzF+Lx330Vb/ibKzmlFARWOzC6BbPkoWlsTJB6qfgkTpqXiFOOP1G4LZHQLRYKUuAltdhV+asCtPTPUB1Scdd8dzxln5pjhoiO4Qg8VBI7Lwd+dEspIaf7LqDQakiqSgueQYCAd+6k4bYYl8Sw+sSkzXcpKVwezEgMy91Rk9rz2jqg2D5PZllfB7ON+7qto+1BLICXZYV8eukMwRWxmNucDXnWh+GADFnziaidiAFMAKHdJFb4aQSQpuMKM5Pm0ZTtZa7raRK69U83n32yEUNpin8AWBLduKU/uqHsKNLXH0puz7gHAko13xDkhpERe5g6ea/eXrqef5n7tsuqVIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbnevqUg/1lNbu9n6kOy6LlRFax2a5eR4LGDdqE4mZM=;
 b=RYhIT45dojEix1McmQNxEKHE3+1n9y6p71hb1DqfoPOQSg/+eetECrinAOdZD3naDbL7s5QAXqoWbVJtO8S/1qw6XTyhvuHo3p7a7FtTzejuhxBcOBkZ+aXOtd1THVbA1XrgTwK3GOF0f76idr+VpEY8zEtRUrVoMA7dK/Sq22A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Thu, 19 Oct
 2023 10:29:14 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 10:29:14 +0000
Message-ID: <c4d76803-5fa4-4cf7-b000-27c31f256d59@amd.com>
Date: Thu, 19 Oct 2023 12:29:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cadence_ospi_versal: Add support for 64-bit address
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, git@xilinx.com
References: <20231011031515.4151-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231011031515.4151-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0066.eurprd03.prod.outlook.com
 (2603:10a6:803:50::37) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: f3bede90-7f3f-44ff-6820-08dbd08e3dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gcaf5ITVdQEyatI4usD2HoZEz+Sp5/YDZJZOIIV+EwKim4XviuXXBYtfBHnX2aeyc8QMKZq27dq37kVHdowlofvXdWty6La7TTwSg8zW3hYpIzDTTV/gwvVZ3r6CySJos/F8WizNyo7beDpJtze9okuOC6HvywOncoeeNDgT4OVcHMA1Y3uMLLIDHNtc4z0f3IodWXW+UMgxmSCfivbyOToWc5bFL1gKpBOIRMRSNFyX3GujdIb/bnuIaVRyDqOoTH0BtdsNN/3/b7Btlsc4MQkCcGtCVwptzKyW6tqjVHNo+rI+TEvvwnfdYI0bap6LPjz++N+KPD9/+Ron+393YQ6gjPcISgdJcLJz0F/0J9l4qFNXlXUo4AUJD5BXKjSIv+Khy7Ha3kKKapO3sBFyvAeOTbc3Fr0kjNVGEqzCjQIxP25YGRaXtu1FsdupfTZ04j2112QLkkmOdrlImReGZi0W5xbQrlugI/p/mn/w+WeFFNZhRRBcCjvvrUxJ4STg/GaevdeWRYnNbbfxPrzpWbGfvqQkhozMCSWZE/oq3txw+sZox+LiqwBJJOJ9pYfRd2Ov8C+iryPbhB5LoWfB25R++GxMe9JCpHstc7Mf9mev9bfuHNmjaVZ4uhZc0v0mltppWe8rysR8pQZFfvS7qA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(346002)(136003)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(36756003)(4326008)(44832011)(5660300002)(66476007)(66556008)(41300700001)(316002)(8936002)(2906002)(8676002)(31696002)(86362001)(66946007)(31686004)(83380400001)(38100700002)(478600001)(6666004)(6512007)(53546011)(6506007)(2616005)(26005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0kvc1hnVlpmZnM0Y3lVR1ppWThiUTk2a0FaUy9kQTYySXR5d011V1pBOXU1?=
 =?utf-8?B?ZStCc3A1WjFOSnhZNDljNTZnSFlvMXk3ckVMajdvMHdNQWxEZG0vMksvWGdD?=
 =?utf-8?B?REpvQjllaktVUTlIMmxFU2tKT1NwQnZ4VXYzRVlrbVdzZng4TmF2MnJFVjFo?=
 =?utf-8?B?ZkhPdjZYWmJyV044emJQMTdXMW9DdTNYS28zWkNsOUVDWDB4Rk91Q08xTkwv?=
 =?utf-8?B?UldwVlRGWUZFNUtQb2FEMWsyOUkxNEdncDVFWVJFR3FPOHRzRG5ocEdnOUlt?=
 =?utf-8?B?VmFMcFBBTFMzNlBpdUNuVEpRTDd2aXM0alJma1ZlZ1FDYkpMOTExSkhhRUZG?=
 =?utf-8?B?ZTJTWlZxVkpMSlBEYWNzaFJFYVVtbzZiSy9TR3BjVW9ZcUkzNkJxKzlQLzJa?=
 =?utf-8?B?ZFRkZjJEK3R6bXJ0UmdwdWk0Y1MvUUZ2UyswVEZVUWJvNzdtTHdKclVpbVBH?=
 =?utf-8?B?Zi9TTkczbG8yc1JaZUMvS0VqMC9CMzVDZy91WGdmN3IvcHk2Q0dQWlNON1R0?=
 =?utf-8?B?TEptVWYvQ3cyaUxENWs2eVFlemhSbzNoK1FPWjhzMXd0R0NRWVVmSm1ZVkVw?=
 =?utf-8?B?YklpU2Qyby9oTERpZVR2M0FZVUVISHg2WkdGSlUzMVZqMS8yVFl4Z2JmM2hi?=
 =?utf-8?B?NVZpV3ZTeHpRWTN2OG15c1BlVjBjdjBOcmtCUmJkcTIwMkRkOTJvRGI0UTZl?=
 =?utf-8?B?Y1BQUTNJL2FTRy9kQXhMSkhNbll6Z1ZEVFdSNFFTN1JtNVNJdGF4Smswc2p1?=
 =?utf-8?B?Z3dtNmg3TmFITjJiU1ExREZHdHE2VjdtWEZ3R29ZSm1GcjVXRmVGZ3R2N0xM?=
 =?utf-8?B?S3hySkh2cVY5NENkWnZQRENMTGYvS1orQXRFT0VPb0o3MDJvTGdJWkZiOFJM?=
 =?utf-8?B?SU9RSExnaWh0QndEeXpsak15eEdxcTBtWjY1WGJ3NENlNTBMdExzTUtZdmYr?=
 =?utf-8?B?SklBWGkzUkxRTk8rYkZMN0pjTzRiUXhBTmlwbVloK3NnV0ZjbGFZNHl6Skli?=
 =?utf-8?B?bm1LZ3BLdlQ4NG5zM0szL3B3TzVFSkNqZXNPeUtkOXdhZXljN05nVjNUWnhk?=
 =?utf-8?B?SElDc052SGROaXl3YWU3bVd5d3diNktUT0t1by8vcEdRSUNvc05LUy9xTDNY?=
 =?utf-8?B?cHpFM09uZi9qVHhBOVlBL0lRakFXS3QyeWJ3WFNDNkdvMWtObnU1cTY4WXk1?=
 =?utf-8?B?cHppMTRLeHNuRzdJNU5JbmJtUDdnYVJFQjBZUEJwVXJkb1k5Sk45QjBScU4r?=
 =?utf-8?B?RG1jcElheVVDSUVhSUxxamhCRFhjTHNoejcyUDRxM1BYVGpTbUdNY3RKV1J2?=
 =?utf-8?B?aUk2TVFYU005NUJYenpSK1FHeGdXUWRvMWh3VnhmNVdXM1daaTUrS2FFMGJl?=
 =?utf-8?B?S09pYUZTVmoyRUNIRFFmT3RtL2oxSWxKMXNtWGFWeG1IcnJOQWZrZVpkU09T?=
 =?utf-8?B?UGNialF5emJJVDF4MkNrK2F6Vk5zM3FXM01hMFY4N3VGRnRKdnBOTXF5MUpT?=
 =?utf-8?B?WnM3T09lZ1ZFdW9DOWEwMDdLZkg5UlBEdys0TERqOTZRR2tPZHpmZG1EdGJp?=
 =?utf-8?B?enphRG9Dd2hDL29vL21TRENvMjhwb2p1UmxtYWF2UjBxMUpxVUFkbGJhSkdX?=
 =?utf-8?B?TGZtSUhIZVVPTUVkUzZSRzV4M0FTRHBsWDZJWHBzMTgwZ3BJckJhVitXNGFN?=
 =?utf-8?B?TVZtOTFJRGpHenhIWDA2eTNRUkpyZGNib2RqOUZ2d0dpKzFmc3VtZzBhN0U2?=
 =?utf-8?B?aUNSN0ovVmtqMXBGR3VJbFBVRnVCM2t6K1M2Zk5FTWU4MGdVMEJLRE5qMnlH?=
 =?utf-8?B?TXRHTGliS0F0cnJHcG82M1BZUGxJYzhlVlFQbGFGR1N5Z1hkR3pWdUo0U1ZT?=
 =?utf-8?B?NHBuREZjY1JpdTQyLzBZd2d5dXRmTW11bmQ3S2UrSTRwdmhFVHl5Nkk3RFZL?=
 =?utf-8?B?d2FXWHBjMysvaHVycERmRk5KelFzOVBPS0R6M1MrZ1g3V2pqYzNDdWlVYis3?=
 =?utf-8?B?OEhXMCtabmZEWktVVllSQmdwbm1wS1dSb2pPc0V0TUhEY0JIZkFtSlJ4MUZZ?=
 =?utf-8?B?VlI2NEZ0SmhjVmdTcmVPVmFkL1lMcERBb2E1V1RndGZBM1lrS3U5ZllJR0pv?=
 =?utf-8?Q?nnq8CwDUuab4tclYKcgPcuAHw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3bede90-7f3f-44ff-6820-08dbd08e3dbd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:29:14.3738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gU/YWmKSsG3GMqciJ8MzMi5B7Kv//ucmncl7q+MwlDkmi8J2CnGN96pW5qy558+x
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



On 10/11/23 05:15, Venkatesh Yadav Abbarapu wrote:
> When 64-bit address is passed only lower 32-bit address
> is getting updated. Program the upper 32-bit address in the
> DMA destination memory address MSBs register.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/spi/cadence_ospi_versal.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
> index a7685a2f51..e02a3b3de3 100644
> --- a/drivers/spi/cadence_ospi_versal.c
> +++ b/drivers/spi/cadence_ospi_versal.c
> @@ -44,8 +44,10 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
>   		       priv->regbase + CQSPI_REG_INDIR_TRIG_ADDR_RANGE);
>   		writel(CQSPI_DFLT_DMA_PERIPH_CFG,
>   		       priv->regbase + CQSPI_REG_DMA_PERIPH_CFG);
> -		writel((unsigned long)rxbuf, priv->regbase +
> +		writel(lower_32_bits((unsigned long)rxbuf), priv->regbase +
>   		       CQSPI_DMA_DST_ADDR_REG);
> +		writel(upper_32_bits((unsigned long)rxbuf), priv->regbase +
> +		       CQSPI_DMA_DST_ADDR_MSB_REG);
>   		writel(priv->trigger_address, priv->regbase +
>   		       CQSPI_DMA_SRC_RD_ADDR_REG);
>   		writel(bytes_to_dma, priv->regbase +

Applied.
M
