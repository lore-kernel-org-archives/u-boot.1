Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9550BCDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 08:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 290BA849D2;
	Tue, 23 Jun 2026 10:01:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qupNxkqa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF0AD849EB; Tue, 23 Jun 2026 10:01:34 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B46D2800AE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 10:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOWEMaIE7j1amWEawaLuxIxPoG6/NTxVThlNE0puwMIrwWWU9rRyOhqCvT9o5RNN5MwH6UVhCrHDtNZAnmF4PbkrZoWZqGr8VOVaAvVNMlYI0R5uWUdSsAd2uYTLruNNb823AL7+abDoXyn/dGdGM8BFP5Ns5ngjIvxtHANVqR6kMwdGDz5JlPtzLDf0k+s4ouB2+k06f+IlxExL4rbAbdHrcMcms3crRhkLKLaAHYCzfqUD5d5N4skqUwsc7UME2MV20RVZ4MkifOs84N526xPcz4oN76F/AR2qmz/CH4OMOwHCvT37ivCZhUYNwsjXkdDs2DL4A1ajMPlGbI2vHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGMIvrrnl5vYezY4qIF/fdNNv8nxK+RDe2qXUYEZtHw=;
 b=j35rSg780jAt1g5m9ea6IqgURmg78PccRKkLmMQ/zTkzLCbntPuxWT7f9/D7aYM80TxMd99Cms6SPeIJpIOUoHRaSumJrNyv+sH6XriJZ4/s+piXcmrh6vqmvVZAtCN1txnYHiU7WtESF2oe/wqKC+pGNpEgVIQEGHJyZZFG3nPFUU3AfuS+Uf6hI5/XI5G8FUBZ0+9Pm9+Kaddu+AeaBZGam2QqIOC/ybVykavfcEOlg2FFZ37NmAR5wlG+q5MB0+VAkOWCSE1UYVJ/gzkBdA/1UQSRaN8XRgL4ugcMa53bSVx76A3TS09DWVc2yFcYe1nPH3bRp5aX/1jSLiN28w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGMIvrrnl5vYezY4qIF/fdNNv8nxK+RDe2qXUYEZtHw=;
 b=qupNxkqasi9S9izgDKDEVai24vZxug5hwkGN6OestKY+4HDVfothCNiReqa5/cp6v4cKMwUeqsxZ2FNIQzkmJ17CakO85z1/hqMMyB8whyyErNXkCvWifToh20gbpV+fd+4ksoWI9WY37WEktReoa+1lCrcve4Jpr5XfZNN0nOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 08:01:26 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 08:01:26 +0000
Message-ID: <bca5452a-5dad-436e-9759-ae8d7fc6ce60@amd.com>
Date: Tue, 23 Jun 2026 10:01:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd: versal2: detect spi env bus from boot mode
To: Suraj Kakade <suraj.hanumantkakade@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, padmarao.begari@amd.com, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>,
 Francois Berder <fberder@outlook.fr>, Pranav Sanwal <pranav.sanwal@amd.com>
References: <20260610110557.2183203-1-suraj.hanumantkakade@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260610110557.2183203-1-suraj.hanumantkakade@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0083.eurprd04.prod.outlook.com
 (2603:10a6:803:64::18) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: b1dae099-9290-4256-40ec-08ded0fd9fe3
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: vWd0rc1ZVz83m3vX43xTffdPYyNUAdxOqewDHkiYnvKwtfTMfM6pWjwr2n4TbW77XMUK2k73gZ8+p36JMrKMwwTwghog3Ga74hBDMlDcuc91hJxynnX2YYfUhhd+mPf4wcjKf2tnJoTNHYgoauEmjHiBwlRGyNQB3U1tSqLMAPmq/q2xNQmZ95U1sOn+aA9mzpA9sP2sV3zZzWnIpezJVFShTFbP30Hi3NksHpoFRNVJeFyF7HaX7giiw5iI632jekJ55szXGwpq6XnmzLdah63WRigaJV3VmTCCUO03jFeWaMmDgNK+F/4nCxo9GEgxWkttKdTnV5DHUcU+oSCN/NY9mQ8aKD8imMOR3832uXLXJEo7qFAawoZGz+lTFictARXtlNhfXWU/ZTy9SIxRUzVlQYrCoyliRkY06hOjk1diH3gOghSf/6jzlvEzMw8kBCV9Lk+Ag4OOB+LVhzSmBkafWgxH8tPYFsREEmGYihsTpfF9UwVwdCk01Zdi7VTd0BtpKQ016RgT+gj7iYGDkOUto0GVpoPqpDpRsY1MZseJG8KlqAq4gK9fBeNoIjzvYm1kgQy/jMh0/1puqBhj+MTLlMKHrmhJjKpf6KfhgXyMk7NuMLlDYondg9cclkNGRlDFaeQInUoM1fCSawWIKmmqETcZZUCNGE2ubJ9xBLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmk3VkNrWHI2M1BadVkxNVJGYjgxbWFVZEVmbDYvTmk1cThqSE5jYUtjcDlz?=
 =?utf-8?B?V2xnRDlkK1U2TWR5WXN5N2pnUDRrOXVQSFNzcmpJTWVFenMyYmdGZTJyQmN5?=
 =?utf-8?B?YnJjaGJwdU5mUEIzeUhsbEMxSHhqcmpnQ1ZhTGdqODYyYkcwMzZQTE1pZE5o?=
 =?utf-8?B?bEx5K2ZjRWRYbTBsTXdKYkNGL21qbitISkxRWmJpc2tQSDdoQVI1U1ZVVUFt?=
 =?utf-8?B?QnludTRTUUJQUnJrUUpQQlE3OXBmcUR6Ym9oNnJmK28zdFVpRHFyYnRzUHRU?=
 =?utf-8?B?Qjdkd1ZEYlJQTDUxeDBJU1VHVUJLQ0RBT3hBYzJTMnAzb29RNmVTWmFiVFpC?=
 =?utf-8?B?cndMcGJZcmduZHZiUlB0U3hwbnN0NlJhcFI5VGswY2NXY2lSeGFESTZyUXI5?=
 =?utf-8?B?U3oyVWxJTDBiQ29KSjZqYXhId3B2S3JZM1BhQ0FMdktqVEQrV0RrVFNHMlNy?=
 =?utf-8?B?WTdCdHVYM21CeW9HUmtkYUtYbGNZSjVUNlpPR1RWNEV6RGVPdlJ3cXY4eHdH?=
 =?utf-8?B?NlpYc0s2OVNpQXM0YVE2Ni9ZV3MyZGZKRnRsU3dET1pSMlBNeXJDSFlTMS9r?=
 =?utf-8?B?OTlYZTBlblZGMi9iV1g0YXlkamlROUlpak00dnBRV3EwcmxLOGk3elVxNzJY?=
 =?utf-8?B?cXdDT1Zzb1FnOVI3YWlSYUFDV2MyU0VOamlkUjRibkpTMUl1N2Nod2RGb1Mz?=
 =?utf-8?B?QTlXNllTKzZCNENMMDk4SUFmb0ZyUElKYTcxSnlnMWg1LytiTHN1ZVVXK1p5?=
 =?utf-8?B?OXM0VnMzc093QitBd05VRmk1TXg5NHhITHNSNkhaNlQ3bER2SndJNk95bWYw?=
 =?utf-8?B?OTcyRkkzUDc4MW9jbFcrZjd3MENXSXNqc0QxYi9iMmdOV0pQZWp5VHNBKzZy?=
 =?utf-8?B?WE5Cd2FTYi9mVTNRMzNaN3RqN09mRUxWemxJSkxabHBYblk5MVR0TzZ5V2xI?=
 =?utf-8?B?c0ZzUEE4djlLVm5zNmt0WlBJQTAxZEhGOVYzWGk5MjAvb1l1dXFNUkRoZEhR?=
 =?utf-8?B?WnVWbnp6bHUwSTBLREV1QlhSbWVmVCtIK01RM3JMU1Z4WllUcmUveE9TM0pP?=
 =?utf-8?B?TXVPcHFTUHUvQmdwRXlkcXh4WUNpU3RWYTNXUXo5UU1NU0ZCUlBaazNwcHlw?=
 =?utf-8?B?dDBxZys1NFQxUWR6U3RpZStIZDhmT1ZCSG1tdVhaNnV0c1Nvdkc3VWdSdU95?=
 =?utf-8?B?RDdaZDIyUGtkQVFKVEx0N0Vka1pjc0VSeTVuVUhSdGk4bStXV3hOZnZPVzR4?=
 =?utf-8?B?SVNLdm5GY2FNWkhzd2FjanY4ajRFbHBuSjlIak9SOFhSSk1EV3ZpT2ZLQmF3?=
 =?utf-8?B?cDZ6dFBOQzJMKzdxWURkaFBlVWs0Z0VSYmE4SzlnVzRrZVR0dEY0eFByc05m?=
 =?utf-8?B?WHFMSjVHVUxZd1RvNGZHNklRamFxZlIwQ1g0dEJzZkFNcUIrbnd2MmU3RG5v?=
 =?utf-8?B?b25RU0lUTUFLRGE0QXNTajBEaU82OHQ0VEpSYi9IVnJsSEI3TVh3OWtWTENF?=
 =?utf-8?B?Z3U1WVV0QWdzUXVjWHh0UHoxRzZGK2UrZmJ1Mkx2VXpob2MyQ29BZWlCOFBJ?=
 =?utf-8?B?NE50MFhOVFlwMXR0U3dUdUc0VHN5d0w5RUtNRmZwRHpOaDdDUkgybHVSWG50?=
 =?utf-8?B?dmNLMEhzSnh2Umxzd1FSSDZnZDk1aGFsbm5ZTmJDQ1ZiRnRhb2REeUVhenJu?=
 =?utf-8?B?am5sYkVkRnJLL1RkNnFwR0Uya0pLaWhSaWltKy84YzA3dkRtMTNSdVRwT3hL?=
 =?utf-8?B?RTdscjFaOVVxR1ZCQThMK1p0QjRZcEliM0gzSVhHdk1uZXdsNTR5RzhXUWpQ?=
 =?utf-8?B?UndMQURxaitqTHl5T2Y0Y0ZXaTgvOXJGNUZHVHVyRWhJWTd2YWdpaHErZVk1?=
 =?utf-8?B?a09OWnQ0SUFpaXA2MHpIdm5mbkJyRkRDelpFOEpQQjF1dTYyZjFMTzZESEJI?=
 =?utf-8?B?bjJJSDlUT2t3TkRib1dEMkRQOUVzVUlyWVJ3U1gwdEhoZDhOa1B5RXpoTUYw?=
 =?utf-8?B?RGNKVHI3ZFBadGQzb01qTWhNTUl1OFozeklvUktybmpiRUQ5OE1FbVMxcEw5?=
 =?utf-8?B?SFIwZE1jZ2RZWFF5YnJveE1Lek0yZTlDelNUQk1SNVZXS2R4RlJSWU9ZNmxI?=
 =?utf-8?B?c1Q5T0V6dzNmaG1VQklnWWc2WmJaKzVQaHNJT0NadnVnQ3c3TFNYTFlSYWlv?=
 =?utf-8?B?WGF6b1ZVRVdaWUVoODhvZHFFY3ZnTEF3NkF1TVpZVGdHejdLUkQvblJYSmpM?=
 =?utf-8?B?VGVjMjR6VE5wTW9LOFFVdE9SQ1U0UXhVWXpHd3NCS1kxUFlGbkhCbnMrNWhC?=
 =?utf-8?B?a0NzZVhzREZMWFhIVHdleTVxTXk1Yyt0cUJkQ0lTTUh4S3hEaHhWQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1dae099-9290-4256-40ec-08ded0fd9fe3
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:01:26.2590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUeKDnfys26VqnrdW3bxZEA+6wv7JyTO+J3uDxBV0ClPu3jLLpTc1u8HvnF/hpuE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009
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



On 6/10/26 13:05, Suraj Kakade wrote:
> Add spi_get_env_dev() to dynamically detect the correct SPI
> bus based on the actual boot mode at runtime. This ensures
> environment variables are always loaded from the correct SPI
> flash controller regardless of the bus numbering.
> 
> For example, on some Versal Gen 2 boards, SPI is disabled in DTS
> leaving bus 0 empty in DM. Only QSPI is enabled at bus 1. The
> default CONFIG_ENV_SPI_BUS=0 causes U-Boot to search for environment
> at bus 0 which does not exist, triggering the warning
> "spi_flash_probe_bus_cs() failed, using default environment".
> 
> Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
> ---
>   board/amd/versal2/board.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
> index 81daba1c5ef..46918436364 100644
> --- a/board/amd/versal2/board.c
> +++ b/board/amd/versal2/board.c
> @@ -476,3 +476,31 @@ enum env_location env_get_location(enum env_operation op, int prio)
>   	}
>   }
>   #endif
> +
> +int spi_get_env_dev(void)
> +{
> +	struct udevice *dev;
> +	const char *name;
> +	int bootseq;
> +
> +	switch (versal2_get_bootmode()) {
> +	case QSPI_MODE_24BIT:
> +	case QSPI_MODE_32BIT:
> +		name = "spi@f1030000";
> +		break;
> +	case OSPI_MODE:
> +		name = "spi@f1010000";
> +		break;
> +	default:
> +		return -1;
> +	}
> +
> +	if (uclass_get_device_by_name(UCLASS_SPI, name, &dev)) {
> +		debug("SPI driver for %s is not present\n", name);
> +		return -1;
> +	}
> +
> +	bootseq = dev_seq(dev);
> +	debug("bootseq %d\n", bootseq);
> +	return bootseq;
> +}

Applied.
M
