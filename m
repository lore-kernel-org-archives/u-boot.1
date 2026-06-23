Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9691ACD4F26
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 08:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0768C849BB;
	Tue, 23 Jun 2026 10:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="no+5Xm+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 336A2849D1; Tue, 23 Jun 2026 10:06:41 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4E12800AE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 10:06:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHkl5IwOLGxOaZ4EAq0CMExFLVRcvUk/FuQcBxKiuusLLFHGEfpU7/Tf2par64GwbCYbmMdqDrErqkxzQISF51EEfDRPbTDg33ku7/yloLBAqNqmmJaMhC5DD7P83V3UXiuNX5gLpD2oMdz2sgU3jlQtzSWW3rXGk3piL4LdOqx0z4SS/nsxHXbdyfhtpKtll1w1xxQANDPeWHyaAml/KDf1UuCMQa18MW/BdvHaF98HKJoxVoaAYxWBnbNkL/3m2mVXHGTUqHSClyFiCpIfn417i3K7bn1fNnmSEYkJFFM9q10lQbHJaQxskyX9IMZG0EdU9sg0LuyRdBU90HsRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/XuUm9T/dLQySmPN1AuQY7ydEaVzFLt6mimMcXAA8E=;
 b=DxFwqbBBIvRFdGc4jOi3eC017ugJ1Lbvpk6F4E0KBEH6rDoELmDGN52seYDa1saT7O72BWXpJF/NhkNwKSbuL+cslcA02ikfEkaZVejffbPu1NtYtsaqzRbw8Xs/zXLBkwawYrdZ6dP8vG3I169Kz/txzEXNoQS0eQ36knLC32NFRFxtYZ7IdNgNvE1/e0vkJHl0aLymcoV9fnqukartLYtC7X7aUfQkshMdtkTjV6lSIX9zetQRR4kAQW9pPbVfUethYs1kz3BjD6S5hrK5yL0tff7MQf6SYJLj1zsST2az3f3uo74O32MCdL5pPF7RTo7GiaacPaqsHj2WaW+8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/XuUm9T/dLQySmPN1AuQY7ydEaVzFLt6mimMcXAA8E=;
 b=no+5Xm+PYlEiVo2SWzM1HzrFMHgHSzBFdl864uZTOfsJ68XsdrRDS4u7N2iONct//8s/gfHSvO7M6XDk+BON2kIHLOyepULZIbvDFJqGDb1W6K13l7z49kenCTIgeocsVh/f26IneOmcnQl3pcco87xdzxdF1tJTEtkIsRpOOx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 08:06:31 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 08:06:31 +0000
Message-ID: <affeb190-6e28-40df-9673-51cfb9a9ffa8@amd.com>
Date: Tue, 23 Jun 2026 10:06:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mkimage: allow zynqmpbif to use a register
 initialization file
To: "Erich E. Hoover" <erich.e.hoover@gmail.com>, u-boot@lists.denx.de,
 Michal Simek <michal.simek@xilinx.com>
Cc: Sean Anderson <seanga2@gmail.com>, Mike Looijmans <mike.looijmans@topic.nl>
References: <20260612150454.2194375-1-erich.e.hoover@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260612150454.2194375-1-erich.e.hoover@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0007.eurprd05.prod.outlook.com
 (2603:10a6:803:1::20) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 9403f0c4-78ba-4f6c-bc37-08ded0fe55a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|11063799006|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: Km4KuOivd/cPsdmgQSGWCdQVBR0QDvWjbwcmdiB/GaZsGdR2kfORpDAT7ntsmfrRGBS5uhQMCTEYATSHhntM9OexxqQm47hE+gpRDzIsvfWCiwtK5SD16cXV9cok2dU18bmeWzboCqfCFyui8adIooWEEn+ur6NE5fQLeE9WBAe+0k6TqsZBdb6duJF7ck7IJ3VM6SxIdaK/FecoMRTSun5zpUmQzh0bie5Hsd+/J7FQkQTtwYlATL6pTa5kyBGU8xSRyXH4F1TDQX1Wg5XsRsD2VzKru1276Od4Lrg0lc5B726aQn7qxu/sBpJ8RLV6b3gFZIFlY7v6tCfOxgKxaZagl2D/ZRFWBttNZmsAhFseysN18mCuhYAFgrkl0wiRGI7ZslS0mS5GX6W1mYGpfDup6tx832Xn0PR+PTuoTYyl6Z+NyrKimrC34sP3KYUnNa2mk4oC5Ic5UiV3jfp2mj3iEOCQM9pClANukIclCnZWpFsh0s2mYtcOLjgdinf8+aVgcSB7Itu0RjXHh9jqNs7RgcdQgRsMqPBfxjRMXDQrDOmL1usA2cxb28JJj8nzFNoYeSIfNp5JP+Gl5kdRCH+eCRCBhz34rQAmBOr+Xkk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWI3ekJadjBhb1JKaWRLc3g1RjY3cVlQMGRxK2hydjBnUHc1c01QOXZiWkQ0?=
 =?utf-8?B?RG9ZelgrbCtRbEloNXFTMDR0elkvU0ZCV0pncWRKRW9XWEUrUTh3SEVseTJG?=
 =?utf-8?B?WURzTW1JQXpMRkZKM25ERi9rS2puQWJ3MHdFTWE0MTVmajk0ZzBkRlQrcHZ1?=
 =?utf-8?B?MU5CT09QVVd2aTVmUWIrZmxFNUlXM0NLRzU3TVZGTHZRbEw3WWh5cFowRjFK?=
 =?utf-8?B?akpYeStrWUYzY2N6RVNyMVVjSjFHeFpPNUZvRkZGOFc5a3B0QlRCY2xodEdG?=
 =?utf-8?B?L2hEOXlNU3dMODlhS0xaZWNnVmQ0T1Bwb1VESzQ2S1FNbklMbEJ2ZnVuNDdL?=
 =?utf-8?B?SzBvWThBS3JMeVV5MGVoYWxKL2dIRXBDVmdncm5yQ3hUSCtXYXVEQm12WkZs?=
 =?utf-8?B?bzRKY21rQ2UzVDIyZ1Q1VGtmSGVaMVQ0UUw4a3pxaU9zbjk5L3FJMmtML21N?=
 =?utf-8?B?UlJhd2R1VS9hMDgwVm9RdjFxY0tVelIzMWcrMEpWTkt0M0VQaW5RNEovSTR4?=
 =?utf-8?B?OWdKQ2tMNTFKdmJpbzBoMU4wQytDbENZYmdMTkJyWGZYRUNXNlFUVm5QMWc2?=
 =?utf-8?B?RGhDMmx6eXNsWkZsZHlGbmovQ21Qc1hjdmRTZEk3N2hzY0hsMGdLcXRrU08w?=
 =?utf-8?B?U2V3eVVFUkNIMnRJVlpLSWcrUkltZWVYOWxsTWRiSVRuNVhKQTAwNkZjRUdG?=
 =?utf-8?B?d3U4dTFlV2FyMWtCR0VRSEgyUUVJenZENGVKWm1EREN3WTNYVDBHeXVqVzk5?=
 =?utf-8?B?ckJjVnhPL1FkNXMwN2MzYTBxTzVrVWdiNHcyNmV6Q2I1VFJiY29qK3l1RlZx?=
 =?utf-8?B?N2luWWxNd1hZbUl3NmJsd3V0RTh5aTVyR1ZrVmZGQXdiS2hUNkFyWmVSNFZx?=
 =?utf-8?B?NFpWNDlYaVlwVUR2ZC90d0NCWGNTRG1tSEs1c3pVR2d4SmcwUm9DQ2J0RW1v?=
 =?utf-8?B?a0pFZzNIMWVNMGttTjEwcDd1NURBYnczaWVFdEd0bTJmOHA0bkVDOEdjK0tm?=
 =?utf-8?B?d1pTRk42VU5IT05TVlFISmREa1FrSzk4Q2k4REZ0elJtVThPSVB0NTQ4MFk0?=
 =?utf-8?B?SnM3QTJwTG1UNENSdVJ2VXFlaTBWcmc3TjJlRk02M0E5WmlnQlRTa3VBLzFR?=
 =?utf-8?B?OXZwTjIzek9KK1lsd010aGc5RitacDZWbFFLS3ltTVBHOFl3dW52WFRsb1ND?=
 =?utf-8?B?SEplSEt3YnduR0xBaUZKL1hYZDNuNlR1WHd6VVBpaE84NTlxdGZIUCtPdWRp?=
 =?utf-8?B?aXZUV044Mms0MVVDNHU1NVJLN0VTV1NNdWRJQi80RGppbHZpN2RBcUw2MTFn?=
 =?utf-8?B?MjJuTklUcG9pMjdKaEZ1bEdqN3hxMEVYNkNmL3lmNDBxYVhVQlU4bWlSQ0NO?=
 =?utf-8?B?cjJnL2JlcFBEcU5rbVhBL09jaHd2Z0cvdldWNE4ydWxMRjRybk9Zdm85Wk9h?=
 =?utf-8?B?Sk5WOElVRS9rS0IzRkZtRURmdVNuaUlUWnJQVGZaeDRUUWg4SnV5MDFzT1o4?=
 =?utf-8?B?Uy9RK1lRWTZ0Zk9tNXVMMVhyTWVJYjhFYVJHbHhEUnVxZmJ0MTZVNzNJUGJJ?=
 =?utf-8?B?UzdCR2hFNmZyemkwRWpCM2NkSUllR3diNjdVSUZIbjBJM3dSTU9Wd1d6WW5t?=
 =?utf-8?B?ZVJtdFU1V0VkQW1IN3QvSWdNdVVGcFJZaE1DK2VZL0hiTU1ocFR3V3Vqdi9r?=
 =?utf-8?B?aS9MczVlWk45bG1nR093STJOei9jc2VoQWQxOGU0VXRNdWQ3Y1JwMWJkeThU?=
 =?utf-8?B?c3Y3RGV2Y0lDbkdFbDc1enpWazRDMDF5bndxb2pPR2NSRXQyR3FqYVJlQ2VS?=
 =?utf-8?B?ZVpMajFaYXZ5ZEdnSG95NmVreXE2RGw1NHVSRm9JM05Ob1BWaDk2L1BHMVlt?=
 =?utf-8?B?eU85RzVKTkVuVm55aCtLUHRjTDZlQzFpY3ByOXJBRmt4MFRHdm5LN00xcENZ?=
 =?utf-8?B?OUFDTkhxU2NjSmFJUnV4K2N0Y3VCcjROSG9Gbm0vaGtiWXkwSVM1UVAzNm9w?=
 =?utf-8?B?Z2hDWGRlb05XV3Z2RmFyOXlpWk1XMWE5aWtudzB1WTNReTlwalNyUHpHLzdP?=
 =?utf-8?B?THdPQ2JLd29hZEY2RTNNZnFBZFh4NXVURDJyM05UL2xLbTQvSmNDUVNqdTY4?=
 =?utf-8?B?eDJHTXVUUEY4dFZUNkJpSEhZNFJ4UmlkekVjeTRFbTMwZEY0aEluc2R4Ykh5?=
 =?utf-8?B?UllLMytQN1FIQjQ1clB1UlZjUDU0VnRmYXRvWDNIK2pyczQyZFFrODIveUJG?=
 =?utf-8?B?a3E2WXUvN211UUVYRkRzclBlYXdDcDh3aTBHQ2JUUFZDS1c0VkNMd1hBUm40?=
 =?utf-8?B?WnVJY24zY3RtOTVOaUhXZEJDamhlRk9oTXF0U3lrcmdTRmc3aHVhdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9403f0c4-78ba-4f6c-bc37-08ded0fe55a1
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:06:31.0650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RcGQrBjBAawiKBgo1WmKpC3CDjIkdjYBHYFeUr2mwzM7PDhhzDxK2IvDeTkc0zI+
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



On 6/12/26 17:04, Erich E. Hoover wrote:
> The ZynqMP Boot Image Format allows specifying the register
> initialization file with the "[init]" attribute.  Since this
> feature is already supported by the "zynqmpimage" backend, this
> commit leverages that existing capability to add support for the
> "[init]" attribute in the zynqmpbif backend:
> https://docs.amd.com/r/en-US/ug1283-bootgen-user-guide/init
> 
> This currently uses the same register initialization file format as
> zynqmpimage (ASCII text hex values with each line composed of a pair
> of register address and value), for example:
> ===
> 0xff003248 0x12345678
> ===
> It is not, yet, compatible with the format used by bootgen:
> https://docs.amd.com/r/en-US/ug1283-bootgen-user-guide/Initialization-Pairs-and-INT-File-Attribute
> 
> Use this feature, with other zynqmpbif options, like so:
> ===
> image : {
>       [init] reginit.int
>       [bootloader] fsbl.elf
>       [pmufw_image] pmufw.elf
>       [destination_cpu=a53-0, exception_level=el-3] bl31.elf
>       [destination_cpu=a53-0, exception_level=el-2, load=0x08000000,
> startup=0x08000000] u-boot.bin
> }
> ===
> 
> Signed-off-by: Erich E. Hoover <erich.e.hoover@gmail.com>
> ---
>   tools/zynqmpbif.c   | 12 ++++++++++++
>   tools/zynqmpimage.c |  4 ++--
>   tools/zynqmpimage.h |  2 ++
>   3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/zynqmpbif.c b/tools/zynqmpbif.c
> index 82ce0ac1a52..50d76b03476 100644
> --- a/tools/zynqmpbif.c
> +++ b/tools/zynqmpbif.c
> @@ -191,6 +191,7 @@ static char *parse_partition_owner(char *line, struct bif_entry *bf)
>   }
>   
>   static const struct bif_flags bif_flags[] = {
> +	{ "init", BIF_FLAG_INIT },
>   	{ "fsbl_config", BIF_FLAG_FSBL_CONFIG },
>   	{ "trustzone", BIF_FLAG_TZ },
>   	{ "pmufw_image", BIF_FLAG_PMUFW_IMAGE },
> @@ -316,6 +317,15 @@ static int bif_add_pmufw(struct bif_entry *bf, const char *data, size_t len)
>   	return 0;
>   }
>   
> +static int bif_add_reginit(struct bif_entry *init)
> +{
> +	/* User can pass in text file with init list */
> +	if (strlen(init->filename))
> +		zynqmpimage_parse_initparams(bif_output.header, init->filename);
> +
> +	return 0;
> +}
> +
>   static int bif_add_part(struct bif_entry *bf, const char *data, size_t len)
>   {
>   	size_t parthdr_offset = 0;
> @@ -340,6 +350,8 @@ static int bif_add_part(struct bif_entry *bf, const char *data, size_t len)
>   
>   	if (bf->flags & (1ULL << BIF_FLAG_PMUFW_IMAGE))
>   		return bif_add_pmufw(bf, data, len);
> +	else if (bf->flags & (1ULL << BIF_FLAG_INIT))
> +		return bif_add_reginit(bf);
>   
>   	r = bif_add_blob(data, len, &bf->offset);
>   	if (r)
> diff --git a/tools/zynqmpimage.c b/tools/zynqmpimage.c
> index 4db9877127e..eb79c0696cc 100644
> --- a/tools/zynqmpimage.c
> +++ b/tools/zynqmpimage.c
> @@ -400,8 +400,8 @@ static void zynqmpimage_pmufw(struct zynqmp_header *zynqhdr,
>   	fclose(fpmu);
>   }
>   
> -static void zynqmpimage_parse_initparams(struct zynqmp_header *zynqhdr,
> -	const char *filename)
> +void zynqmpimage_parse_initparams(struct zynqmp_header *zynqhdr,
> +				  const char *filename)
>   {
>   	FILE *fp;
>   	struct zynqmp_reginit reginit;
> diff --git a/tools/zynqmpimage.h b/tools/zynqmpimage.h
> index 7c47dc0763b..867fc5294a3 100644
> --- a/tools/zynqmpimage.h
> +++ b/tools/zynqmpimage.h
> @@ -142,6 +142,8 @@ struct zynqmp_header {
>   
>   void zynqmpimage_default_header(struct zynqmp_header *ptr);
>   void zynqmpimage_print_header(const void *ptr, struct image_tool_params *params);
> +void zynqmpimage_parse_initparams(struct zynqmp_header *zynqhdr,
> +				  const char *filename);
>   
>   static inline struct image_header_table *
>   zynqmp_get_iht(const struct zynqmp_header *zynqhdr)

Applied.
M
