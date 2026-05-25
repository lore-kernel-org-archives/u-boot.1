Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9E0CD5BBF
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 08:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A06D48460E;
	Mon, 25 May 2026 10:41:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ARDZ+Qg9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDBDF84659; Mon, 25 May 2026 10:41:52 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B1AC83FF5
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 10:41:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoxnZ5palwvMEATQ3sLPPZxW0GCpkhF7ZYGeQMLvoNjqFe5k9628q5OG7Y/AB81X06M8K5nPfZlW0vn4xxThXM1BmzpRsC6UgC74poALGq/5Fch2eUqtWvXYquM1Y1Xo6ANglQPpz0VMtUoQtfVJJz5uks0Fwiz5VZsXI9YfFhsy0xQFEVBw1tdS0TTblA3vi9nDlOb6PesCJVvnPeblppH06qmjLYYyZzbj89ubs7FeSTD/JVPqo/z/HuuauyZmlGza21Z1C1PmaRcmkfPIXMn4KZaV3KDneOq7IvpWaTn8wphfhzbOq1qyoswn9wJx0SJ5RYA7534gLvILTmKB4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pgk1n9vno4taazhqiN8sRkUa3Ay6AyzAs/6emj3vM5U=;
 b=iFg/tSaliSHc/ev6gimC8ddQVDsQcPMyco96XHSNbpm8FOnw1PfoPZvtETTkmvkBaxxNpi4YM7RDlcdt+RB/+ydOmd266SGV3E9LBomLsOPj1O2k5elAcBudifhS1E+Gyzxqu6Cvr8zf3VLfNRLXHm9aPrjIoHKeunW4d/ZvlGzsywXJJXfCZ8oDibXA7zEXTzS4vvsHnSVlcvBRxImi51XYeGRWdGGvPjh+Uy/EwIbTIfrPbTf7Z539fpp3Fv8oYfjiiDxZPIO43RIyBd0N9If0Q8pyMSgeHDN+QtskrWcmjjOH+LoXKksjY//vZWDhIlGJ5IIJYYrKxdV56dRSzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pgk1n9vno4taazhqiN8sRkUa3Ay6AyzAs/6emj3vM5U=;
 b=ARDZ+Qg9FapzteUUgcipMnN8d9shxWMjQHxaOXmRYs68Ic5ou3yjDLJbuPHp8NYzeQLVtnqmWYp9Z50C7zJSKyiAf7YN9zciD6ujHKcgZeRIdgwrHv/0k8Jv6o2Y4gEKdI35zwdKhxDUtH6zZKmd+DSCWVEY0CadQ2MWv7SfZ3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CY5PR12MB6432.namprd12.prod.outlook.com (2603:10b6:930:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 08:41:46 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 08:41:46 +0000
Message-ID: <776da054-754d-43aa-a01d-febedc72cd9d@amd.com>
Date: Mon, 25 May 2026 10:41:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal2: Fix buffer overflow in soc_name_decode
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <BESP194MB280513B376D54A815F3FD507DA0E2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <BESP194MB280513B376D54A815F3FD507DA0E2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0238.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::33) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CY5PR12MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 2466f8fa-cf5c-4455-f1d4-08deba397447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: mslhIV7NNnjrclq7cp9ZS4ToVeTVRd4IMcT17vSK6AwcUZkJZ272+HLsK+DUJrvCtjbmIk783QsMHcozIsvtKBXxPzgLfVCye+gs8VTuW738/klUYBLmPD2VarnLjEbH3N4+1GqyRRvCLl6icughQaA1CaDImJHtsFMo3qVaB3p7zz3XKsQr7gTiGOI2gLiqqXicVHwg44qRuQiIlOL1y1/uXFG95X+ecZ1oEUzZrQmPWNG7/IKp+OmCO0yOvmlrOc24/PPtLrE0uOv5xMDRgq9k1WQJXvbu790VPXTBznorvEJq1xYI75lwRBGSgA24bNCFgssikqfakjISt6t98qokl9/2n9ER1TD3kgKU4Q88wtppOc+RY3m8O3IlQbOl10hCfWelOcMigDBlRmrZYUE+8TmQaLJAtVr0Rxr9zGPEHFzdNnnhEnOdEUF34Oh6CVvKcHIlICcN3nmAzFr8f5Ws8mwz5GbTB3bSOpwQNM1vmDiVgqCS587sdPhpYd4ecoO3AJs89+lMUmP6B0pTVf+wNRKt2kHZGFYudw5eSB9r5tfDmraL/F7yFBgWiFasvF1NxL2CIm8ilQvnb5gHwfKghD/4HgVonfnSvqwQjnORGk15v8M5kETPb7pn2RA+bNCC0YVIPNRW+4JbNVuJGSn/ZsPh71g2J4o3sCf7An5BlIxew3ywq+hIykmBOftG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDVCYlBpRTZqS3hjT3ZrL2p2Qk5YZTV2bVNJZllwNm53NjVId1ovc3daQlpX?=
 =?utf-8?B?R0xIb0xDdzl5Wm5MVGNwREwyUlp6WEU1eDdqQTRPNzgvUmdSQUZaRTFLSVBS?=
 =?utf-8?B?WFhCK2FSSzExYXczOVpCRUdmVFQwVjJ1MjFocVVzcGxHZEdxcVcxVWtiYWps?=
 =?utf-8?B?Zk02Rmx4YXZiblA4b0ZwU1IyTG10MWFjUVJ2TW1vZFZtdkpjdlNXV3J4bmdM?=
 =?utf-8?B?SFVTcHBGc3J0QkpHWVhjc2psQ0xPK0c4V2R5NEdnMzJMYlhFRlhLdGsrTk9q?=
 =?utf-8?B?WE5oY3M4UlNKby85d3ZxMGY1TEx4dUd4dm5RU1o1Z2hnNTFSSjR5ZW16d2xo?=
 =?utf-8?B?RnhJdmk4TVFYMklUQmJtV2tTS2Fzc2RPRjNiV3FpMmFmdlpVTExVME1mYkgv?=
 =?utf-8?B?UHh0RFdHdWNaTHVRazRtd2lxcWtJVWtUSlhHekhvb2x5bG9PbnZOdk4vQnMy?=
 =?utf-8?B?Q2ZQekU2WGgzdDdhK0U0d1gxbFdBYWRqVGdWTWZNUzlIdmJ0TzZFY2VnRjNi?=
 =?utf-8?B?MGp4UVRPNG45cURDUFB0NmwrT2FTU1ZTUnZmd0I5SW5EK3M0eTdVUm8wQ0gx?=
 =?utf-8?B?UkVCblM3ZitCNk02MnprSVF0U3JOdURjNVFLTUZlYmk5bWFDUDVwRCtyUy93?=
 =?utf-8?B?bUxnemdXNmgycnZET21pVmFBb2tXYzF5NFc1RUNmeUZ6Zk5BRWNvNzNhb2l5?=
 =?utf-8?B?Y2tTZ0N5YXRlbVhEOUtCSW5MKzkwcmhEQnY3UHh3ZHBHZngzZU4rMzNtQ0Nn?=
 =?utf-8?B?NzdBTGE0Qnc1d1hlRThSdGdQZFR5YW1BRFVBc0liNWtjVnlGZ2NQeERQUGZu?=
 =?utf-8?B?Zmx3dytoTFovWDhMK3Y3N1hnaDJObzY4YTRGWGpYMWUxblNXWjl0c1ZMZDBw?=
 =?utf-8?B?OGFPdTR4akQ1ZGxtWk1zNjlLc3hpSGxGZ3EzWHdLL2RRdEVWdll3a3gzZ0F1?=
 =?utf-8?B?SHVUYm9qTm9kMFZZaEg2bXdwazUvNTZWR1pTODRaSDZSWkI5N1k4cWVVUU1h?=
 =?utf-8?B?ckQ0N1hKT1NPN09jMVBRSCtnSjhJQi8xS3lyYVNnQ2grYXQyc0JIK1lWbkpW?=
 =?utf-8?B?ODZ6S2pOOVVONjhDZlNnYWFxMkV0Uy9sZkF1cW1vR3lkdC82RXdmaHlqbGRa?=
 =?utf-8?B?UEN4b2lJTnFZeENVaUY5QUZTNW05SElRVUY2RFplQmx5NzQwYjdyRHBBU21w?=
 =?utf-8?B?ODl1RVA2aVNvUkJPRlBzeEsxRlZCQlR3VmpQOG9aVlRuQnZBclRsRUV4ajlD?=
 =?utf-8?B?cjRwSHhFYkY2T0RKRW16S3g4OFF6OGRLaE9SUUx2MjZBUThnQkFWRXFFYmNW?=
 =?utf-8?B?SWxYVm5uMGIvZlJrRjZkSm9QUUZFSjZaQVgyTHZIYnhTRVFKZEdlUkpwMk15?=
 =?utf-8?B?a0FrREJuOEY0TEpncUlOU2FndjFFV2RJb0xvOUNWNEpNNDMyNXhQS3dRU3FW?=
 =?utf-8?B?blpkVmhSOU9GSW1WN0g2S3FBd3JqamYvcms1VWtaaENRU2FGZlEwQVNJNE1H?=
 =?utf-8?B?NjdIeUVNcmthanM1L0xVeDFob2tYKzBTaWRWaW4vZ0hzaXd4Q2JvQWdmY1Vn?=
 =?utf-8?B?OWhpaEdJOC9xKy9zTFNrS3V3THQzeWJEK01Qd2Z0QXJoOFBlWmhycnl2TVQ0?=
 =?utf-8?B?QmgvUTVqN2VUd3NYUTQ2eUcvTERwbmRQVUE1bHhKWUlDNnU0SzlHTmR1ZUtl?=
 =?utf-8?B?cHk1d0QreCtMeFIvdkxBNHQyUFFRKzN6RUMrMlM1VHdsSGkvS0RidVhNVjNk?=
 =?utf-8?B?WFh3Vi9VM0JBcTlxL0JOYWJVMkE1ai9scDZ3Wjk4ejk1ZS9tSDlVa3RxUWJS?=
 =?utf-8?B?dGlVVkZUS01oUnVWdGl1SUpiYkkvVHB2TnZTVU1BT0R0azg5NmRpaU5nS25Z?=
 =?utf-8?B?NisxdUs3WmJNeVBiVHpjQ0xSdmk5WUh5SGlXWXVScG82Z2cyQ0pwa2gzWkl2?=
 =?utf-8?B?dW1rVytqRlBpaEk0N1NHMkdiaFp1bitHVWFhVEhVeE5JbHo1QmpuN1dyQjI5?=
 =?utf-8?B?N0pmNDdIQ3gyZ0puWVNhRllCRjZobnJ4dlRDTWN5a2E2SlNJTGVNa0dnVk1a?=
 =?utf-8?B?bmhuUFNzUmhYZTBQeGVBUTlyNElFS0lpS2NiUk5uT1R3TUVyL0svNlVVMEpy?=
 =?utf-8?B?UjhiNHFleVdCZTFEWGQ0eWpEMGR2dzdJWWNYWjFBQWxFUXNPRVBGRytxQURU?=
 =?utf-8?B?TzcydHdPS21hako4VENFYnI3d0RaM21ta3BFQ0Zud1lZdVdRNGIyalV5MFUz?=
 =?utf-8?B?U0xxOHkxY0xENHBEMytpelhKemR2MjhzVkE0OTVHcXh4NUgyaEhJMDJvOUI0?=
 =?utf-8?B?bHZKOHBYNmlTd1JxelVJOFJSaGdEUVdSOVV2bW5CcFJoMlk2bjFmdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2466f8fa-cf5c-4455-f1d4-08deba397447
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 08:41:46.1207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LB1CjQOy8WNrd0XL6GYmv6QTCjt9l/+6OsL0GWPqRTvDgy1noB68V60B6fRZwJLd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6432
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



On 5/21/26 15:05, Francois Berder wrote:
> The size of name buffer was not computed correctly.
> The suffix format is "--rel.-el" (9 chars instead of 6),
> and the longest platform name is "emu-mmd" (7 chars instead of 4).
> Fix comment and name size.
> 
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>   board/amd/versal2/board.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
> index d94c1494d53..81daba1c5ef 100644
> --- a/board/amd/versal2/board.c
> +++ b/board/amd/versal2/board.c
> @@ -81,12 +81,13 @@ char *soc_name_decode(void)
>   	}
>   
>   	/*
> -	 * --rev. are 6 chars
> -	 * max platform name is qemu which is 4 chars
> +	 * --rev.-el are 9 chars
> +	 * max platform name is emu-mmd which is 7 chars
>   	 * platform version number are 1+1
> -	 * Plus 1 char for \n
> +	 * el is 1 char
> +	 * Plus 1 char for NULL byte
>   	 */
> -	name = calloc(1, strlen(CONFIG_SYS_BOARD) + 13);
> +	name = calloc(1, strlen(CONFIG_SYS_BOARD) + 20);
>   	if (!name)
>   		return NULL;
>   


Applied with

Fixes: 40f5046c221a ("arm64: versal2: Add support for AMD Versal Gen 2")

Thanks,
Michal

