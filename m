Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73449C4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 06:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83D0E82991;
	Mon, 20 Jul 2026 08:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pAMvIUA9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3166284105; Mon, 20 Jul 2026 08:23:43 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com (unknown
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD35780517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 08:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v86yM4ndvvcOip1UvzHBAbl+mVg8SrVonPHlG9lIU0fN/H3HWNVrNt40rK1qkW4d+xIYaOM6jr0UumaqnjqNnCKhiQmYylCNV5r+PB2DxY3CzgPNU8ER0NwmtKhOrVOuFUJ8hXLH50O/3+QLHmxOPWhIbNqZpA4DHG3UGpFKII8EBmlswzoP0JxY9uwSfs/HmhbKZ6/71yXh0/73v5qwM/fLjHb9ovDcadI0OB2aUZJQ6cIhb34QzmTb03jOdBY3yNGUFGJ+yfVrowIJu+hT/ytQqo8c+sAI0wW70BBgdyHDDSXSF2yez4fypRYZvSdKZA4u1Sn14vA4NNv+/F3+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZj5n7/IeXNkC95KlfsZtO4T3P55/QlAhmgM5gDPtPo=;
 b=Shmr0tTxiKyXfwwGkoU1IDwn+H2ybE2VdurI0QdJf8EpE3c9br9rX3usxHGJnqTU7Ym4oCTscIoQQjjZOUBB66yW2q5mUKMhs8FsCZGQk6LNQasNikXYYPeQJEVwq34HKkTAcl6SFchOCZYA8r05+XaAPTDHP6nc7G9y9PUppkL21OLqXdvteHnohcA/QE0W29mbXI7X2v6Z52Fpi/oZuzeLvO+GxVkHtAwTMFXtI2Pc5mDbusUnaNdVRl87bZCcl1fcl2ODho3TtzWTa8KC5mdm9LF3rxAUjsHEt25G3zl2trP97fF2HXsUXrxKFTTtJSsRZrVjjtnVl9uZnURJbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZj5n7/IeXNkC95KlfsZtO4T3P55/QlAhmgM5gDPtPo=;
 b=pAMvIUA9pCdw5UOharuD3kC6FnDLWjY3ecc3DHAeZBROqMjrE6uWWU0jMJ28WGYzYShYFPhB5sFyG3rZkmNOZVBcFg2mdIQHvivVAN5rg+Vh4fBeOL26olu2d2YI+dS8kROh0v0d6YCOqIU5ohTbAf0fHmppRPR2FdznloZUKJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 06:23:35 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 06:23:35 +0000
Message-ID: <e756f5b9-9d48-4d15-b120-d4246fecfd5a@amd.com>
Date: Mon, 20 Jul 2026 08:23:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: xilinx: Generate FWU capsule dfu_alt_info from
 fwu_platform_hook()
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Pranav Sanwal <pranav.sanwal@amd.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>,
 Suraj Kakade <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <33c118b8177f8d0dc182a6f4c5cffedca4e02448.1782986903.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <33c118b8177f8d0dc182a6f4c5cffedca4e02448.1782986903.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::22) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: d1987e1e-6d56-4383-3b96-08dee6276da9
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yV0WhSXZ93wyrqkOUheHAZ+cNKRt1+kybDrKBD1tzZ1y2P74gddACzzZS19cS82ZxVbV3UgfSw50rz6BHipTzwBS5x8BrERFrnxhp3n5tX0Vb0z1hkDjLFpNttWAY5HzhXrdysjkUWostO+iY1x0mIf6jz38rZWl5kU1o39s/YUXUbvJ8z8eUcattYijbX/SWTdvu5vgCTm5S37mFlm5aW2fz/q74AGR8DQ9YzzayLFnNjpbSuxwHc90CYjNB/HSjsnkmx19Tg0MhH4rRe5PK2h0HQ+FWweSWylwJgIZnouEb0CrLu98RX/buXS3gcEbXF84M946ZpHV01SqntV16hj5EB3jYz3GFmxxA2J/hVjR6lZCoUFOU/6Zh9sfToyLDa3ed6yKsxET0y+BkbjcD8aC+He1C+eP1DKgSUn8Tgax2hwaRvMKjGRq6uRrltTexxIHjdjRXCqcdkxwiakmJgZs/IPtIbmIbP7JU+rJNwBBYGwrm/zS6ApNnHTtXJSO1g5zOr5oTJBVCEDt8ZMs02F0456NQvEfVHt8ORL17fJEGDdv3b1HrBfpk+gwabxijKZJc+qwEj5n6zjpumQyD2420A1wa3sPhqDkJfQXr7L299EfmNiHOyFzdHFloJdCoDtOGQORBKnUy/S0LNVv+et3LWQ2jRxEmVhuTob2TF0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzlFY1BYQi8rUFVKVE5QZzRFZmpMMDc2dmJsd3dYRXFNRjB2RE1zWDR3T3Z3?=
 =?utf-8?B?RWJ2RVg1MFBFM1ZjMHlDY2dPNDM4ZyszVE5MVGtoeTQwbkZZVmNLeHdjeDAy?=
 =?utf-8?B?aFlaaFlaV0pSZVpHRDhCZ1FBQS9GRHBMUEJQTHNPWUIvN1lEd2RvN3JLYnV2?=
 =?utf-8?B?bFBtVmxGTW5DT05aY1d3SUlncnBDUHN5aEdiLzhZaGxPSjRGbDI4UXdBdmNp?=
 =?utf-8?B?NzFZNTk5QTVLc3VsNnd0VUg4SjVaczZiSnBXNWd3R2JIRUU0UE9mZUIycC9l?=
 =?utf-8?B?bm44VDNnWHVkNmEyeWdMZWNiVWRUTW92UzJMUDdaRWVqU1NSWTdCK3I0RXVr?=
 =?utf-8?B?anZ1V1M3RCtydkRTdm1kWE5ObHZ4dXltWkovd0pULytuc2xEcVJldTBERStG?=
 =?utf-8?B?TVYrMXJTamE4cHBGRkRNbjdzNGFISnJLYmpIZ1BON01JTjFlZWtLKzA4ZHNw?=
 =?utf-8?B?KzR5dTJIV29EUDBLTHhzNVBBU1oyemk0TkVZMXhGYlhVRkd1RStiKzVKU25Y?=
 =?utf-8?B?SVA5bVVCb1cxR1lOK2loN3lxcS9OM2dOaFBWbEdtOG5PVlpEN1AvNHJZMWxO?=
 =?utf-8?B?VWJwR0N1c2ZDQ2E4cTFKR1NtVVBVKzZDbWF6YVBiazRidUNOWWVOT0NNL3BL?=
 =?utf-8?B?THp5ak5yYzBZS3RtWUNLcnhLRE0za1R0S0FHLzVCdzVQZmVuazQ4ZmVBUUNs?=
 =?utf-8?B?NExDNjNpMkoycDdweHhsV25YMFFocDBoSFNIbklUU01uWTBIWitFdkQ2a1ZE?=
 =?utf-8?B?VWdhbzFOK1RGeHJLQmFtdkQ2L3RhN0R2dkpsZVo3SWE2ckx1T0laZFEvRzRN?=
 =?utf-8?B?eXFRbDhtK2xWZHIvSWtna0RpQk1hSGhZblA0eGw0cGxGNnFGOGwzNlVLK1Zk?=
 =?utf-8?B?QXhmVXVZVGJlc1pINlVXQklMMlZpVlE2bm1RSktLSTkvNnBFWU9XU2tsMWNK?=
 =?utf-8?B?VXVrK3MrTUdRTWNqQmNXTFV5a3JtTWxiMlY0YnlzaXhDOU9xMUxSZE9aczdK?=
 =?utf-8?B?d2QyV1Yrak5GOWlmNUdmcThTTTNNK0J1SU5wbkhHdkQwSWpMSGduVUJsUUZn?=
 =?utf-8?B?V3lCZVdKSTZ5UktJbnNRT3Y2V3orYUEzNXJsMVV1TFV5VTNOVitYeG9MWlBz?=
 =?utf-8?B?em9lM3dobG5RalhCUm4yWC96NlAzZkJqNDUvUGNUaFNReEtReXkwUC90Q1pR?=
 =?utf-8?B?NUZJQ1YxNkprZWMwZHU2WStpa0VJU2RpU2RnK3ZEWkNPTHl5TGVoOCszRW1r?=
 =?utf-8?B?b1RBQ05NWnEyUW9YWWhkS3NzWDZOU2ZQNnJ3K2RCc0dqVDBxRGtteTNKL0VH?=
 =?utf-8?B?MGJpVUJQbG91N3B0TUx3NGlIVXZwcHY3bVBnUEJyT3ExZW5WTFg1OFdwOEdT?=
 =?utf-8?B?U2dqdDNlOUNmeTl6bExWSG9WOUdPdGxFMDVxdC9Rb1ArendpM2hDdUFXc0pJ?=
 =?utf-8?B?dWNHUExBU3IxWnFCOGdyaEJpaWFOOHZHL3ZtbUJ4WGhkblpNSFQycnJOZGwv?=
 =?utf-8?B?ZnVvSXJubm5DN1NpWnUveUtqNEpjRkhvQ0dyb2QxblgwbXlGbzhjK04xaEly?=
 =?utf-8?B?c2I5cmpFUEV2YjR2d3RYQmlZOCtKaW1CSG96dDhodm9GOTNua1Izb1A5YVFX?=
 =?utf-8?B?MUVNSFhMbnR2YmVzbjJVMVRtdHNLaXZvYUFiRXFsY0dJRDJ5ZXRZN09PV0xT?=
 =?utf-8?B?YjBjRkpaWGVjZFNsMFNHeHpydFd4UVBmZGR5WEJzdWVqblhRN1RtV3RkMW5K?=
 =?utf-8?B?NmR5RDRtem9FdjJKWFFNOFJNVUdoZ0tJbytOVWUrSVF5NHp6elUzcTdGcklX?=
 =?utf-8?B?L25uMHJUME0rQjdvOVg2MHRGd0xpNzBYS0owa2RmcUtGSmtZbjFlT3M1bUR4?=
 =?utf-8?B?bUo1eWJvK2NEWG9qWFY2eGpwR3dxN3Vkc1U4SGM0REtQZTRaTmtlWTZReHoy?=
 =?utf-8?B?dFh0UGFENGkrRWsvN3RxUnl6WE5mQlc4NXZTRXJMUkRuSDZ3bm5WbjRGNHlu?=
 =?utf-8?B?RUVsOHk1Yno0UkRhcTFtSVN6OHpYL2VFOUh2TGpKUDI2azBiRUpqNy9nL3R3?=
 =?utf-8?B?dEJDbVlaQVI4YU92NU9xMnF6YTdmUnQ4SnZyVStnSVh0M2M2YWlJZjkxU2JI?=
 =?utf-8?B?aDZLMjNuTStDL3gwNU11N3ZxWThjeExzSzllZTBQZVdLbURDcDlvTWc2VVJ2?=
 =?utf-8?B?U3lYNzBGNUt2RC9vNFpjSWJIRzFrTUhZNFFJRk9FQkxudXlXYWtOTlhCRGYz?=
 =?utf-8?B?aVBranVIRm12NFdyU0VhZmVkSjdFemlTWERNczk5RnFGZHJsNXI4cTZmcXNy?=
 =?utf-8?B?MUNKUXhZcEJBd283eWc1R1Fzd1hKT1Y1aGFycDBOTlhqb3hjbmJ0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1987e1e-6d56-4383-3b96-08dee6276da9
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 06:23:35.3473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZ5asHDy1Od5ZmWaYwcsC6rwmqPq8/L7zKYEILGau9H+NST0wHJSEI//YwrcngWR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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



On 7/2/26 12:08, Michal Simek wrote:
> Commit 371a6c1744f3 ("board: xilinx: Add capsule and FWU support") and
> commit 818c06faa119 ("board: amd: Add capsule and FWU support")
> introduced a separate set_dfu_alt_info() for the FWU multi-bank case
> (Versal and Versal Gen 2 respectively) which set the dfu_alt_info
> environment variable directly, while configure_capsule_updates() handled
> the non-FWU case by filling update_info.dfu_string.
> 
> Fold the FWU multi-bank generation (fwu_gen_alt_info_from_mtd() over the
> nor0 MTD partitions) into fwu_platform_hook() and drop the
> standalone set_dfu_alt_info().
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Do not setup dfu_string in board_late_init() which is too early because
>    fwu is initialized after preboot.
> - Update commit message
> 
>   board/amd/versal2/board.c   | 39 -------------------------------------
>   board/xilinx/common/board.c | 37 ++++++++++++++++++++++++++++++++++-
>   board/xilinx/versal/board.c | 39 -------------------------------------
>   3 files changed, 36 insertions(+), 79 deletions(-)
> 
> diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
> index 489b1fa9dca2..1855226398a9 100644
> --- a/board/amd/versal2/board.c
> +++ b/board/amd/versal2/board.c
> @@ -11,7 +11,6 @@
>   #include <env.h>
>   #include <efi_loader.h>
>   #include <fdtdec.h>
> -#include <fwu.h>
>   #include <init.h>
>   #include <env_internal.h>
>   #include <log.h>
> @@ -506,8 +505,6 @@ enum env_location env_get_location(enum env_operation op, int prio)
>   
>   #define DFU_ALT_BUF_LEN		SZ_1K
>   
> -#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && \
> -	!defined(CONFIG_FWU_MULTI_BANK_UPDATE)
>   static void mtd_found_part(u32 *base, u32 *size)
>   {
>   	struct mtd_info *part, *mtd;
> @@ -584,42 +581,6 @@ void configure_capsule_updates(void)
>   	update_info.dfu_string = strdup(buf);
>   	debug("Capsule DFU: %s\n", update_info.dfu_string);
>   }
> -#endif
> -
> -#if defined(CONFIG_FWU_MULTI_BANK_UPDATE)
> -
> -/* Generate dfu_alt_info from partitions */
> -void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	int ret;
> -	struct mtd_info *mtd;
> -
> -	/*
> -	 * It is called multiple times for every image
> -	 * per bank that's why enough to set it up once.
> -	 */
> -	if (env_get("dfu_alt_info"))
> -		return;
> -
> -	ALLOC_CACHE_ALIGN_BUFFER(char, buf, DFU_ALT_BUF_LEN);
> -	memset(buf, 0, DFU_ALT_BUF_LEN);
> -
> -	mtd_probe_devices();
> -
> -	mtd = get_mtd_device_nm("nor0");
> -	if (IS_ERR_OR_NULL(mtd))
> -		return;
> -
> -	ret = fwu_gen_alt_info_from_mtd(buf, DFU_ALT_BUF_LEN, mtd);
> -	if (ret < 0) {
> -		log_err("Error: Failed to generate dfu_alt_info. (%d)\n", ret);
> -		return;
> -	}
> -	log_debug("Make dfu_alt_info: '%s'\n", buf);
> -
> -	env_set("dfu_alt_info", buf);
> -}
> -#endif
>   
>   int spi_get_env_dev(void)
>   {
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index aff28cdd9b64..6fd0369a675e 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -1,7 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /*
>    * (C) Copyright 2014 - 2022, Xilinx, Inc.
> - * (C) Copyright 2022 - 2025, Advanced Micro Devices, Inc.
> + * (C) Copyright 2022 - 2026, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
> @@ -14,6 +14,8 @@
>   #include <init.h>
>   #include <jffs2/load_kernel.h>
>   #include <log.h>
> +#include <memalign.h>
> +#include <mtd.h>
>   #include <asm/io.h>
>   #include <asm/global_data.h>
>   #include <asm/sections.h>
> @@ -22,6 +24,7 @@
>   #endif
>   #include <dm/uclass.h>
>   #include <i2c.h>
> +#include <linux/err.h>
>   #include <linux/sizes.h>
>   #include <malloc.h>
>   #include <memtop.h>
> @@ -65,6 +68,8 @@ struct efi_capsule_update_info update_info = {
>   	.images = fw_images,
>   };
>   
> +#define DFU_ALT_BUF_LEN		SZ_1K
> +
>   #endif /* EFI_HAVE_CAPSULE_SUPPORT */
>   
>   #define EEPROM_HEADER_MAGIC		0xdaaddeed
> @@ -847,6 +852,36 @@ int fwu_platform_hook(struct udevice *dev, struct fwu_data *data)
>   	/* Copy image type GUID */
>   	memcpy(&fw_images[0].image_type_id, &img_entry->image_type_guid, 16);
>   
> +	/*
> +	 * Generate the capsule DFU string from the FWU metadata. This has to
> +	 * happen here, and not in configure_capsule_updates() called from
> +	 * board_late_init(), because the FWU data is only populated by
> +	 * fwu_boottime_checks() at EVT_POST_PREBOOT.
> +	 */
> +	{
> +		ALLOC_CACHE_ALIGN_BUFFER(char, buf, DFU_ALT_BUF_LEN);
> +		struct mtd_info *mtd;
> +		int ret;
> +
> +		memset(buf, 0, DFU_ALT_BUF_LEN);
> +
> +		mtd_probe_devices();
> +
> +		mtd = get_mtd_device_nm("nor0");
> +		if (IS_ERR_OR_NULL(mtd))
> +			return -ENODEV;
> +
> +		ret = fwu_gen_alt_info_from_mtd(buf, DFU_ALT_BUF_LEN, mtd);
> +		if (ret < 0) {
> +			log_err("Error: Failed to generate dfu_alt_info. (%d)\n", ret);
> +			return ret;
> +		}
> +		log_debug("Make dfu_alt_info: '%s'\n", buf);
> +
> +		update_info.dfu_string = strdup(buf);
> +		debug("Capsule DFU: %s\n", update_info.dfu_string);
> +	}
> +
>   	if (IS_ENABLED(CONFIG_EFI_ESRT)) {
>   		efi_status_t ret;
>   
> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> index 1ba6f3feca45..2cd34544a329 100644
> --- a/board/xilinx/versal/board.c
> +++ b/board/xilinx/versal/board.c
> @@ -10,7 +10,6 @@
>   #include <env.h>
>   #include <efi_loader.h>
>   #include <fdtdec.h>
> -#include <fwu.h>
>   #include <init.h>
>   #include <env_internal.h>
>   #include <log.h>
> @@ -377,8 +376,6 @@ enum env_location env_get_location(enum env_operation op, int prio)
>   
>   #define DFU_ALT_BUF_LEN		SZ_1K
>   
> -#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && \
> -	!defined(CONFIG_FWU_MULTI_BANK_UPDATE)
>   static void mtd_found_part(u32 *base, u32 *size)
>   {
>   	struct mtd_info *part, *mtd;
> @@ -455,39 +452,3 @@ void configure_capsule_updates(void)
>   	update_info.dfu_string = strdup(buf);
>   	debug("Capsule DFU: %s\n", update_info.dfu_string);
>   }
> -#endif
> -
> -#if defined(CONFIG_FWU_MULTI_BANK_UPDATE)
> -
> -/* Generate dfu_alt_info from partitions */
> -void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	int ret;
> -	struct mtd_info *mtd;
> -
> -	/*
> -	 * It is called multiple times for every image
> -	 * per bank that's why enough to set it up once.
> -	 */
> -	if (env_get("dfu_alt_info"))
> -		return;
> -
> -	ALLOC_CACHE_ALIGN_BUFFER(char, buf, DFU_ALT_BUF_LEN);
> -	memset(buf, 0, sizeof(buf));
> -
> -	mtd_probe_devices();
> -
> -	mtd = get_mtd_device_nm("nor0");
> -	if (IS_ERR_OR_NULL(mtd))
> -		return;
> -
> -	ret = fwu_gen_alt_info_from_mtd(buf, DFU_ALT_BUF_LEN, mtd);
> -	if (ret < 0) {
> -		log_err("Error: Failed to generate dfu_alt_info. (%d)\n", ret);
> -		return;
> -	}
> -	log_debug("Make dfu_alt_info: '%s'\n", buf);
> -
> -	env_set("dfu_alt_info", buf);
> -}
> -#endif
> ---
> base-commit: 2c1b572ff2a1e54b22f6d9de77fc8bdcca7f3e7b
> branch: master-next-test
> 

Applied.
M
