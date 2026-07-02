Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23B2C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91A3F847C8;
	Thu,  2 Jul 2026 12:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qD04yl6Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AF578484C; Thu,  2 Jul 2026 12:11:06 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D615843B6
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yz/Zy3SHldwzWVTEsMecV/bOlcREylTJxa4RejSuT0Yq+Zr5InJIS6GFMCO1GmEXIP2l+u71JgPqXnZC6Qjseti2qYRUUdbnvLz2PSZdIIE45EbnVQACRnvnV9Q0WrW5N6zhzMpVMUY8Ju6QDBtKCsC3q7+H1ZczpmaXTDD6RkS/BFc4aN/LVvROEYxMRxHGX3f7+akuWZ3eMEe+mFxnLnzgVbuXfpqxCbpwi7sAPwc0SFx1V1krlYLpeHig87DHAqspHgG0R+XEuA1lMq7UlYXK5RqZrXm1vrGtx6HuPW4tkZi8guYo3hTA2r5hMAIKiUAgx75G96Cz+aiuFEw0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXyAodKQy6Xp2xFuxPOaVbmio6DkWOcN/I0kgdiNhGE=;
 b=XtJPZ2K2+UT9bQg2NJfr1TM4j9s/kgxtRclaNPXuuFX3tPcNZsUeSPdBA+6C0zF1SaayozXwVNNPsDHrzYS4793ZDHSEnW+1ziDE5B7sGEXBL+ZKYOa9Og9MpE1JjmFTw5FsWs+PanQ2iyidUKEBp6tJgtX4E78Qc+WSaU+I4ervIgxF0FNJ1cDg8uTwUOTF8NaxQnckTjWhOm0WSLP/vCwGcl4Rnvhenmsr3kC2ltqfk2yVIk28dxyr8iUAlG1afEu1erWieKZy3AJiLklx1HTnC6lwBK7jMWT5pIkHD9eNDTpQk81+Aw664PXLu3YVVZBK3//QcP/Ywe/SclcwOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXyAodKQy6Xp2xFuxPOaVbmio6DkWOcN/I0kgdiNhGE=;
 b=qD04yl6QwCO8cQO6J5mhaNoUgNJdORNK3Y+O3AUVx7rSUxp5nZ6dVvHhDrIBMQWUH/uknki/MS1UcQZOetrnGndwF2Q9Jf9H9QGSIrXuI4AOO9lwjFU8tn7UOCdcpuEjYc38uEYLEuAc6EBGDOn/nTNGx5oO3pbpZl62K4IvTAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by MW4PR12MB6850.namprd12.prod.outlook.com (2603:10b6:303:1ed::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 10:10:55 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 10:10:55 +0000
Message-ID: <1362f93f-b740-4b9a-9b9f-0ffe7a4c40c4@amd.com>
Date: Thu, 2 Jul 2026 12:10:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: xilinx: Fold FWU dfu_alt_info into
 configure_capsule_updates()
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Francois Berder <fberder@outlook.fr>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Pranav Sanwal <pranav.sanwal@amd.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>,
 Suraj Kakade <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <ea62096437b39ff9038f7169e461bfe7863ee85a.1782824566.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <ea62096437b39ff9038f7169e461bfe7863ee85a.1782824566.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0088.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35c::12) To IA4PR12MB9788.namprd12.prod.outlook.com
 (2603:10b6:208:5d5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|MW4PR12MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 601ed2d4-14b2-473d-951b-08ded82233ee
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 0sw+qS0JnI/IcEesNtTcLT7cMBYtX0wzdueCLhR/Le9dz+8epQJke8IEGVc7Peib0RaxV5wgijJAW+3p8zvwaNIub+XOvzvsVj256zdretwHLCB23yEAntu2jt1Do8+SqdcLjBWtOm9eWMOdWTVIao3zTadfJkpyNOlTfYN2rIXkwi55IaDkQ/gyqTfXBELGdZI+v4DHiu2nZd/XtgeuuWtXWpfBNGQpgCKIXYgxQ6sLppzGeB51QPGcxLgXi/wrIZqzlBgqxuysVAvo1X7x4WehoJAmo2A1r/G+5YYG6J7J/meSq/QGTGCfyxusREYWy/y+d/EoVE2BFuRtD194KDJEAo4cBuy1CszYHxgHokEgDnPC9Ki39nfBSUbYu4/+4d/T6O+PIGCpXfBKbNLTVrG9a8HpG5UhXY/Q1U6qlhLzEuds8maLXzn6fir7xTPuub6Ur9N+u5Cl+WioRpffMGGzDGQitw0ZdRvmGg8zq0P8huHiTFcAOUgNSNzBbQhumZV6TZCIvGPiEUVcQVmwf16P55xUR8AyVLhyJExtS8URed6H0R/71I0OE2AZCKpY6/MEd6cueIfVdyO3xfyU1GAicwoSw8/uVgudSCyJOWOnR8YM0VDw/ULTqo0dFKTL7JCyfdSmQfnHCwmq2p6CjndVWaaLiuNQup35dF1YtcE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU8rR1I3QXRUOFBDY0JPekl5NUx3QWdLM0FCTE1iSzhPSzRkUytnUTczcnE4?=
 =?utf-8?B?dTJ0a2dZMTNmRWRsKzhUMFFVWTNaVFUvYkpEZzMrYkx6ZmJ4Z0tKQURhdHpB?=
 =?utf-8?B?VHVhZ1hCNlBjRmpKbTBCenVuRDF6WVpTNTlBWmJ4MGx5WjZ1T1d0QUUxMEFS?=
 =?utf-8?B?Y0Z5Zi83bXgvY0tHR0lCMzZZbnNNQStjT3BCVWhaOFhTUWcvQXdlRzBRazEr?=
 =?utf-8?B?MWdjRTltUnNlVjY5azl2UmttdFlLSHhUWkVRSVBYenVnVVFyc0dTaDB6Y2J3?=
 =?utf-8?B?aFZBNVVndlNHa3o1eTc3cjdFaWJDTWErU0paWjhIOHI0bVhST0ZnN0ZMbVU3?=
 =?utf-8?B?cy96RmVsbkFwR3N6dzhKaHQyZHlxcE1yU3hOQ3VtRDdnbDYxUFdQTEVMSjNJ?=
 =?utf-8?B?VlJ3V3NpeEpkM3dja3ZvTEhTeG1kYVZROE0wK3hLSUJnd2hrSUJkVjVuQ2VV?=
 =?utf-8?B?UnY3QTZQenlWVEo1SmxwcHoySENWWFdyZU1QWmVVd2hVekhCMUp0VmNEeGx3?=
 =?utf-8?B?UnJ2ZWl0YndpNHhKdXc3bXptbUcxSTFkOUVhV2FoWUFNc3VlQnpzYVZnbjBL?=
 =?utf-8?B?clN2VVNKWE1zMWJEdG1wanlJMSt3ZUtiZnUzZ1N5TTRNSHdlYmQ4TnlvcFlo?=
 =?utf-8?B?V0wwK3IwcU1BREhFR3oxYmU5NEl4allqTExrQ0lVUXhWeEQraTJIK3RqUXVi?=
 =?utf-8?B?aGpJdTZuamhveUhoanhSbEluUWpON1lhMU5GQU9ZMmY0UHdjd01aakdvbElz?=
 =?utf-8?B?d1l4M3Y5cU9jRVFuYlNwbnRnZzBHSmdIR2x5bXAzSVNxV0ZwNGwrQ3E4QVZG?=
 =?utf-8?B?WDhENGI4bGttQWZtYWF1MHordjRIaHRJdVI0Qlhta252dENCZ0pUOWhGbGh5?=
 =?utf-8?B?ZXc3TFRMRngxVEZFaXErdGRBdkpJRTd5Yzh6SzdrcjZmSVI5c0pPbkF3aElq?=
 =?utf-8?B?R3ZrSlhLRnovOUZKRGJ1VW4yaEVtbFJUUEM2b25Ca2Vpc3JQSTl1NjJBblpw?=
 =?utf-8?B?UkUxRlFaVFdnVWZ6am5TbWJHVWdjMnIrSVN4cTVlT2hzcnVwd2RSc0hJSHkv?=
 =?utf-8?B?SFBjSHBPY2xPeEp5LzZMb1ZaZ1NSV2RGTnJ1THBEU2JET2ZwQVpZWGVibXVH?=
 =?utf-8?B?U0tZVUNickE2REZrMVc0dHZYbEJsSFZOcWZvUDdKMWQ1clgxM0pCMGk0NHhx?=
 =?utf-8?B?b2o4dUpkdld5WGhTTWVHMFloK2JoWVl4WWUrZlFwc09hVlBDRXMvUktuSzRN?=
 =?utf-8?B?TXFQaGRGaDFrbWhOY003VTh5SHpMYjNzRWwxQ2ZuaFFjYW5WWFVSZ2kwRlRq?=
 =?utf-8?B?NjhZYXlRY0R3cExEaTJMSHZxbU5iaW5ndVYwZ0NDNExIVWdWZFlVc09MTi9U?=
 =?utf-8?B?c0owUXJzRm16Y3NQMjFLM3JGWjJNUkhBNkhrNDVDdzZOZU8rS09MbWFGQ2xP?=
 =?utf-8?B?cGs3K0hjVlBydVlwNEdJODMwNG9BZkJEWTB2NzlzYTdqcUl5VW5Qbm4wVkxY?=
 =?utf-8?B?VjZ2RzRrRmMzT0RhY2xGeHI5TFN2Tm9iUDNJMVdra05lNUg2WEdnSjFxUGtF?=
 =?utf-8?B?UHZ6V21XNDd0SlpQL242WW1UVWxoUjhsOUw2OW1pVWJ2R0FKeEcrVjd1bUR3?=
 =?utf-8?B?dWp2aG14SEhZQWxJVU1mUlFqaG9wa09CQ3ZLN3hEamFrSnNxZWxqaTFpQVJZ?=
 =?utf-8?B?L0Q3UkM2WEFRdUhZYmlnUUw0cDBYVk12QmZPcXd3Y3B0QzNMTWpSZUJHcEth?=
 =?utf-8?B?M1VvQVRDOUlzdm01UElHQU1VUGRxZ1NuMWd4bDdMQUVOUGJPbzJ2MW5XTmxs?=
 =?utf-8?B?ZCs1aHYwbWkzT0pQOHZmYTJ6b1pxWjV0aFZ3THQ2ZTh4M01TNkk0bVRRZFpa?=
 =?utf-8?B?SjM0em12T1ZwM2lTYWJ1aGNwVmd0alpvNTNlWkRIbElNS3VXTHBBWExCQVYv?=
 =?utf-8?B?Vi9pSlFjVTJKSVlxSE5JK01YenpiMGdKb3NoSjVUWHpDOXBMSERJRWl3VGYw?=
 =?utf-8?B?cXU4L0Z2M2E4eGk1Ky85a0J5NXZzT0NYa2V6eFFvK1hSN3dvOEJOUDRUandu?=
 =?utf-8?B?Y1U3RzdIOWV2dFRJREh2U2VEVzd6SEMweHQrYVMvRlc5VWlMS1NwQlB5MDIy?=
 =?utf-8?B?Z0lOS2hJU2F5bjRxdCtoVXMwb2RlRU5jWlIyRVhwb1pldWswQjNWc2VLUXR4?=
 =?utf-8?B?SG9RcVVVRHFnRlM5ZU1laFBMQ2VYcjdCR21JU0lMVGZJWURmM214UFJRczlY?=
 =?utf-8?B?cVJFUUljb3JPdFlBaVVzQnhXSlZwVlBhdHF3U2dOQ1JibTNkUUFrQ3lCK045?=
 =?utf-8?B?NDFIZEtMb2doMnN0RFVXNENBZTBQSW50YXNkSjNaWGpKdFliWTc3Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601ed2d4-14b2-473d-951b-08ded82233ee
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9788.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:10:55.0603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vH8TfNu4ZU0HS9+YYo0OQW1063NaYX75sWLXWHW67mtL8ujFoj7sitvJWaFmygX4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6850
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



On 6/30/26 15:02, Michal Simek wrote:
> Commit 371a6c1744f3 ("board: xilinx: Add capsule and FWU support") and
> commit 818c06faa119 ("board: amd: Add capsule and FWU support")
> introduced a separate set_dfu_alt_info() for the FWU multi-bank case
> (Versal and Versal Gen 2 respectively) which set the dfu_alt_info
> environment variable directly, while configure_capsule_updates() handled
> the non-FWU case by filling update_info.dfu_string. Having two functions
> generating the DFU description is redundant now that capsule update sets
> the dfu_alt_info variable on its own from update_info.dfu_string.
> 
> Fold the FWU multi-bank generation (fwu_gen_alt_info_from_mtd() over the
> nor0 MTD partitions) into configure_capsule_updates() and drop the
> standalone set_dfu_alt_info(). The function now selects the source of the
> DFU string at run time via IS_ENABLED(): the MTD partitions when FWU
> multi-bank update is enabled, otherwise the boot-mode based layout. Both
> paths end up filling update_info.dfu_string.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/amd/versal2/board.c   | 63 ++++++++++++++----------------------
>   board/xilinx/versal/board.c | 64 ++++++++++++++-----------------------
>   2 files changed, 48 insertions(+), 79 deletions(-)
> 
> diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
> index 2afd283b8ddd..6e09e408875d 100644
> --- a/board/amd/versal2/board.c
> +++ b/board/amd/versal2/board.c
> @@ -227,8 +227,7 @@ int board_late_init(void)
>   	int ret;
>   	u32 multiboot;
>   
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) &&
> -	    !IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE))
> +	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
>   		configure_capsule_updates();
>   
>   	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
> @@ -362,8 +361,6 @@ enum env_location env_get_location(enum env_operation op, int prio)
>   
>   #define DFU_ALT_BUF_LEN		SZ_1K
>   
> -#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && \
> -	!defined(CONFIG_FWU_MULTI_BANK_UPDATE)
>   static void mtd_found_part(u32 *base, u32 *size)
>   {
>   	struct mtd_info *part, *mtd;
> @@ -399,6 +396,29 @@ void configure_capsule_updates(void)
>   
>   	memset(buf, 0, DFU_ALT_BUF_LEN);
>   
> +	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
> +		struct mtd_info *mtd;
> +		int ret;
> +
> +		mtd_probe_devices();
> +
> +		mtd = get_mtd_device_nm("nor0");
> +		if (IS_ERR_OR_NULL(mtd))
> +			return;
> +
> +		ret = fwu_gen_alt_info_from_mtd(buf, DFU_ALT_BUF_LEN, mtd);
> +		if (ret < 0) {
> +			log_err("Error: Failed to generate dfu_alt_info. (%d)\n", ret);
> +			return;
> +		}
> +		log_debug("Make dfu_alt_info: '%s'\n", buf);
> +
> +		update_info.dfu_string = strdup(buf);
> +		debug("Capsule DFU: %s\n", update_info.dfu_string);
> +
> +		return;
> +	}
> +
>   	multiboot = env_get_hex("multiboot", multiboot);
>   
>   	switch (bootmode) {
> @@ -442,41 +462,6 @@ void configure_capsule_updates(void)
>   }
>   #endif
>   
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
> -
>   int spi_get_env_dev(void)
>   {
>   	struct udevice *dev;
> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> index 0537517b1b2e..f06d3c59d055 100644
> --- a/board/xilinx/versal/board.c
> +++ b/board/xilinx/versal/board.c
> @@ -232,8 +232,7 @@ int board_late_init(void)
>   {
>   	int ret;
>   
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) &&
> -	    !IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE))
> +	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
>   		configure_capsule_updates();
>   
>   	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
> @@ -314,8 +313,6 @@ enum env_location env_get_location(enum env_operation op, int prio)
>   
>   #define DFU_ALT_BUF_LEN		SZ_1K
>   
> -#if defined(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && \
> -	!defined(CONFIG_FWU_MULTI_BANK_UPDATE)
>   static void mtd_found_part(u32 *base, u32 *size)
>   {
>   	struct mtd_info *part, *mtd;
> @@ -351,6 +348,29 @@ void configure_capsule_updates(void)
>   
>   	memset(buf, 0, DFU_ALT_BUF_LEN);
>   
> +	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
> +		struct mtd_info *mtd;
> +		int ret;
> +
> +		mtd_probe_devices();
> +
> +		mtd = get_mtd_device_nm("nor0");
> +		if (IS_ERR_OR_NULL(mtd))
> +			return;
> +
> +		ret = fwu_gen_alt_info_from_mtd(buf, DFU_ALT_BUF_LEN, mtd);
> +		if (ret < 0) {
> +			log_err("Error: Failed to generate dfu_alt_info. (%d)\n", ret);
> +			return;
> +		}
> +		log_debug("Make dfu_alt_info: '%s'\n", buf);
> +
> +		update_info.dfu_string = strdup(buf);
> +		debug("Capsule DFU: %s\n", update_info.dfu_string);
> +
> +		return;
> +	}
> +
>   	multiboot = env_get_hex("multiboot", multiboot);
>   
>   	switch (bootmode) {
> @@ -392,39 +412,3 @@ void configure_capsule_updates(void)
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
> ---
> base-commit: 8f4ec2a116ee7ff6d19e6baa60833586df985de7
> 

v2 is required because fwu needs to be initialized first and if pass dfu_string 
can be created.

Thanks,
Michal
