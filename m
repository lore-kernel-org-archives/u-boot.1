Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147CDC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 15:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F47A87633;
	Wed, 13 Dec 2023 16:49:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yh25tKpJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71E98877D8; Wed, 13 Dec 2023 16:49:15 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E19287527
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 16:49:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYpCnpK338imzrwZ4wqnrToC0z9r+AZIgo22K2azdkSncSuj52LCFcPqns1XpwXB0SIJOQAPM6KyBmt2zrUaIoQhAGQwg6cqf45Z6aSoGoWDbQp6cO5FSBsnBSNnLumpcgmuMKNnsl4N/TAp8cbjNWSDcp1qGMol8Xwee/7iHCR5hnC5dGMNZFdTL8GpSgWIX9/SKPwM+Dz06gcE5H55WDm0ocQuYEUerCSmF8r/di+xSoNrHhRHWAKdMC5irAjbXq9KK3VuSNcP1XwUju2bqlVBeTdOqodbw3cxQoZRlKpSDfhDxSuAowv7O2O496LCfc0KdOmYq5ynwjIcUuz5QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNZciDaxpe+HOZ6BddKqu320hQmgOLzOsh8Bcj5+IpQ=;
 b=jmGCsLJib5Y7HgL17eveIucjaRvwr/B8xAMK75DEobusmagzb9rhD1CPaYlP0ffwWdgfOvN3QsjSbbcSIJXkqY2M5MN6Kj2wvbZX5RBHTrf6yAdKWtXakjRVzFzm0i/9zfcDtLTWsPHs437+tLBgC+L9TAuz7kzk5yv9bHzwP5WZTM1HlH9FWeSLqn8UOnLdcs8FPdUep1ZfeyE1SCy+ue1WRK/2oi6ChrPbIZv5sdZUFfU+uFXzJ/yv1847YpLxPGGtZ/Neps1sn+83gDt/NePY5lOSSY9U4lI2wgbIzDB4uu+bGRdu1n70md/psfTJM3j3TxYKP/lLFGC/Pspspg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNZciDaxpe+HOZ6BddKqu320hQmgOLzOsh8Bcj5+IpQ=;
 b=yh25tKpJz8Aii+ZgBjYaYvT0aKcAuk4dDrVLhdW9uIJ+dObLTUXYGdeCuSopuwplLxlRFoG9iLcp8QJoNmIUHO8Kil+IES8OncQd4iTBYrlckeIBqpUl29b9NQZaBkh0xRKGGXjdKf4VSQe10I8UTopKrC0wwMLlCq0uOgFG/Vs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 15:49:09 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 15:49:09 +0000
Message-ID: <b687ac77-96b2-4bb5-a353-e209818bba09@amd.com>
Date: Wed, 13 Dec 2023 16:49:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spi-nor: Add IS25LP02G flash support
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, git@xilinx.com,
 Sreekanth Sunnam <Sreekanth.Sunnam@amd.com>
References: <20231204085247.9772-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231204085247.9772-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0115.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::44) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DM6PR12MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a864569-8f4a-4cd8-ad9f-08dbfbf30b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GI4dABwVA5QvbGvI37sIgqWM+K/wictoWhKfGDroyM3UpBv/lVLvvPQE1+x0zrjnb6Gd+kCcQPLKIlJUnJxPBvHIRWEmYVnhP+heZCGBeArP2YVMpGzjA58cgRpinRdVca8R3QMiKnc2Ek7I3SKK2chet23UegXzI9HZLkWUeSOg8HjgT6cy6NG7D1sc//7JZ5HZgoOQk9F2kZfbSD1mm3XqMrO/AN29U45UARn8f5sFGsN/RZ8P6gCEWl7SR2pFu6zLeg4A5aXqol2ya1Nd0R25eN7sK0Cdftjps7rmAL12sK8BEephPKhy6QGpUNeG38gEr9tpJGJoykc+xTMgIkHQA/2PJcQ8CP3xUVzyisVz/oKXT/xmXfJfhyHV1446wP+rMLFnI6kNbV9pJNvYnHSbb7inM+D7mli0jx58aWyZjQ5tGRRFw2K2PJ5HKyOdnjTXDA8BV0x4HlSHyyfmfm6SAHZoul6HwvcBlMkCOxyzLIbfNprNoghRXyrOGRS5gfNCbBZtPCcaFb+aaZIxL3I8R+UA2ZsTNhu7LMISFtt6Yc8DqAfzHQ9bOuFhagrEXno5YhqVvL653Z4ortgdRakBuBVSWVrTapG750RosnHkRG2fxMAdnKwm2b19umPtpsJYP6SWRTT/q/AvX4l/Og==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(136003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(66556008)(66946007)(36756003)(31696002)(86362001)(66476007)(38100700002)(6512007)(53546011)(2616005)(44832011)(6506007)(6486002)(6666004)(2906002)(316002)(478600001)(5660300002)(26005)(4326008)(8936002)(41300700001)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUc4VzNYamdRNHVoZnk4RFVKOE9rOE5uLzh0ajYwckxtaSsyOTJyY2MzMjl0?=
 =?utf-8?B?MU5RcmVvaGtmKzlrenNVQnk2aFB5aVBFUU5yaFlLMnIwcFkzbDZud0oyTTRU?=
 =?utf-8?B?akMwUS9xM1I2TmU2TXFXRWxyV1c5NVRPZ25RbDVJVklqQkhGakZ4WUhwVXdq?=
 =?utf-8?B?SHAxQmJYSHZ4a3I4L1lud0pQYUpLb2FiUnc0dGtCZEpSbld2YTh6Slpad2pK?=
 =?utf-8?B?RG9NQnJVUHpoR0p2NXV3dDg3RVprQ0F1STIrR1hlZUwvbzY2U2FkY2ZHR3Fh?=
 =?utf-8?B?dndQYzQ4bEZDbXRTQk9zN1dvcDUvSXNhdWFqR3c4clFkMGpLck54L1JKUWZj?=
 =?utf-8?B?Q0phS3MxTnR6dXlFekVpZUNkSFFDZXltaUkvNis4QzhUQnNUeUQ2Unp2bXdq?=
 =?utf-8?B?TlU0MXhya1pHdDUwbktkRXEzdG52a0E4QlBoVCt2c1p0UDROSXBtZ3FOQy90?=
 =?utf-8?B?em5xRVdLR0F4WjF2NlVlUm9scHZ2Y0I1eER1akpyYTRxTFdBMytwelQ2M1FC?=
 =?utf-8?B?SktsNVJGNU5ISW1VTjBQQXFVSXNUWjlGZHVNVnJjTHRIMGt1ZVMyWStzYXV1?=
 =?utf-8?B?SmxnanZvdXRjUDFrT0t6bzVOd1YwV1FOd0ZOWkI1ZnZhMDJhT2hoNXRESXJi?=
 =?utf-8?B?WFd3ZFhZOEwvYTVhZE9KUGpLVXJqQUw4Z3VUTU9IZ2FrZjFnbUhzMjRoUFQ1?=
 =?utf-8?B?d3FlZkFkWlJOblBIQVZHQWdzZjhBZDV3Y0lHTEMzWDZreGdXeVNLS2tXMlpM?=
 =?utf-8?B?bHJXL2NQRTNrU0IvWmcwbk5sa085cG01ZlN4aytMbnFkY1hyRWREUW54RjU2?=
 =?utf-8?B?YXFIY2ZiemdYRUpwcGVRNE5zazA1OVNYQWRXM0cvOWZ1Q3F4S1QxYXVwY09o?=
 =?utf-8?B?bC93ckhoL0tad3FJMnJDU2xTK3pObEFXZjc2cERWOVNKMEMwR2JoL3AwbVdn?=
 =?utf-8?B?MGRGeDlGcUVEQlZ3N1o0ekZTUGNWWDl5VFlKWmFtNkR4SS8xOFBlSTBJSTRp?=
 =?utf-8?B?c2NuajhiTFhhajhWL3R0RHQ3R21MVUtIU3VIKzJBMTFFZW9iam1sV1lXRzQ4?=
 =?utf-8?B?S0JoR3hQR3ZBajZBaXRuQzlWeXVyRVVnU1AxSnozRUdNcmVTUUhiL3B1cXNv?=
 =?utf-8?B?M3hhZ0QrK1JuUlFPRHhQNEFqRzQ4L2QxaEJCMlpGYjhjY2RGNU0vY1ppcUp1?=
 =?utf-8?B?S3puWmEzZkhEZ0NYY2FwRGExeGlhMXJHNVRUQUwvcVJVakZMRFVleGN2VVBW?=
 =?utf-8?B?cmNybTZJTm9JeElNUGNLN0RBOVVKTXJUazlRTzFnaDRvVlFGWHkzNFNsMHdq?=
 =?utf-8?B?Lzk1bkcxNVdoeE9EaEZhQzJPN1B1SHRobzAzeGlTWjJHdjhSUlRXRktENkQ5?=
 =?utf-8?B?dGV6RFowRUFPemdoOWI4bWNXeENtOWdHWVJmVzRSK1prK2FjNkJiRWhtNHdD?=
 =?utf-8?B?WmNZeFFoWWZlU0FIeFNSWDA4WS8vZmY4bUVJeUJpTW5QSFpydHFSRGQxWEdE?=
 =?utf-8?B?ODZmMmhCWWtyZVp4ZlBzNHJsRC81SDFQeGZmemtZemd3cCtrY28wcW5LRDh3?=
 =?utf-8?B?TEpTLzJoZkh2bkdzcHhCc2VuS1dDR2thT1R1Vld3eGZpdllHZUdqb1VKRzhv?=
 =?utf-8?B?eWEzaFNROVRoSk9GQi9qcjRJcElCSHNjdGFrdlA1Q3g5RTZEb1hJRC9ka2Zz?=
 =?utf-8?B?WWZYRC82VTNEVzNyNVlicmtSbzZvNm84VUJnWUVGMm5DVlUySDdjMkRtalRQ?=
 =?utf-8?B?c2FtTElSWUU5YUNrQ3hrVGJSOXpUNk5lTTcvVDhiTDRHd3F0dGlmUCs4MWZW?=
 =?utf-8?B?YjNseWtnR2RHWXIraS9JaGJUY0RnQk1ST0ljaXZUSjNYTFZnenhRQWRvM2Ur?=
 =?utf-8?B?SjB6dmlQTHJxdTU3TFJYMUM0U3dDL1V3R1NsVmMvZTRLRXhtYUhkVm14V1Rv?=
 =?utf-8?B?dkhjdlh3TkF6NTR2ekt4bUlscmxYWE9RNUsra0lqM0I4aUtvNXY0L2d2RGNa?=
 =?utf-8?B?akNwblZqWkVPaVpNM2tLeTB4VWpWa253YmtCNndaMUk0QW4vNC9EVndjM2dn?=
 =?utf-8?B?OEtDRE9vT1didTZBbUZLZVhyVlpYQUZlQXo4c0NzY0taanV5RkpRMVoxK0lZ?=
 =?utf-8?Q?eFKvTL4prhHGtFAVVYm4A5e4s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a864569-8f4a-4cd8-ad9f-08dbfbf30b78
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 15:49:09.3745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8gzYo7be7Vw4EHTkV2bQ/hK7Zek6t376FP63msA3VZLnt0CDhjwNHT+yV8fOfqk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
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



On 12/4/23 09:52, Venkatesh Yadav Abbarapu wrote:
> Add support for ISSI 256MB flash IS25LP02G. This part supports 4byte
> opcodes. It also supports dual and quad read.
> 
> Signed-off-by: Sreekanth Sunnam <Sreekanth.Sunnam@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Fixed the name to Sreekanth Sunnam.
> ---
>   drivers/mtd/spi/spi-nor-ids.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index 3cb132dcff..9a73198227 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -217,6 +217,8 @@ const struct flash_info spi_nor_ids[] = {
>   			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>   	{ INFO("is25lp01g",  0x9d601b, 0, 64 * 1024, 2048,
>   			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ INFO("is25lp02g",  0x9d6022, 0, 64 * 1024, 4096,
> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>   	{ INFO("is25wp008", 0x9d7014, 0, 64 * 1024,  16, SPI_NOR_QUAD_READ) },
>   	{ INFO("is25wp016", 0x9d7015, 0, 64 * 1024,  32, SPI_NOR_QUAD_READ) },
>   	{ INFO("is25wp032",  0x9d7016, 0, 64 * 1024,  64,

Jagan/Tom: Do you want to take it? Or should I take it via my tree?

Thanks,
Michal
