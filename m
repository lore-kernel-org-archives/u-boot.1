Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA6BC4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 14:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AE6987A80;
	Thu, 15 Feb 2024 15:31:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aBBQekVs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B47587D6D; Thu, 15 Feb 2024 15:31:32 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9896186D38
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 15:31:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjpQFhYC2uUVuapGFTa74/UyILQLH0M4Hp5pal6PuIvfEgNwSCKVyfqkWayZAc8SPXmojJJVsN4BNO5FNaQLSDZP3AMhaAVsgyRjJnSxQY8lWWR+mIsN2xsX+eFbY4OCslJ2dOdOs3ipdHVmmJIWwSDvuJtlj5nkABE4OKF7psNJfeg6sieBcW/AwAh8AHGNWK733cOI5jkC7Ap7j4ul1jZk+WvIN/HAbvebIVufE5h7PIRi4C5R0Z57lWxahAu78G3Ln+4EK0BFMQaNiqkqUnNTMgMQwRLcREqNLEtzQj00wCR68Ts5y/yrzXud9ccSSAJWCY6KjdOTf6qCP70bbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPo4y+VckW8LdypQMgHLBER2oUb6wM48RnoEcOqJRxk=;
 b=FfRjCJkI5eoU+k6dyRWl4YDRVsd7H6GSKKZs3Y7VeIo5L9K2GYWh5/vrzjwGLN3m4EXVuJ5IMtPBc/cnzkvriazTE4dQOXtKr6s7A2MllVFX8+XM/wSgyw1jR9e51k/h/qeJOKpPwPSIplTEWjGUd4cWnIKLgQRbQzyY8YN90Hvyt0seyuSHg7JI+U/NfmaHYEawbsfWO5qaKyrxM6zG+lU5srMJU06pUkne2cO9hedqoWQMCE2O0LR0QHG6yGCliGW4ujwJK6+dPvoXUoMwsL28H6lFGxjMv3qAC6Uu0FKfGA+VBpezAX7vsiZJLYFPbArEy+im/IQY9XqYrm2G3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPo4y+VckW8LdypQMgHLBER2oUb6wM48RnoEcOqJRxk=;
 b=aBBQekVsl1GTU31A0B7iJHJh/3d7TpQwvmKUO2EVTnnwn5D9vqGwFas61IhRannCkYkykmYMcYd5/ARO2R+glQVxCYPhcVWqx+8of+jvFaoxD9iVP/9NmgA7RgHFFd2e6EB4p6hYKkKbj0SdQlvh2VEY4E/E5yCPWcWuEYpzaWc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Thu, 15 Feb
 2024 14:31:24 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7292.022; Thu, 15 Feb 2024
 14:31:24 +0000
Message-ID: <7cc3cab2-19e3-4f6b-b6c3-c48d549a3f3c@amd.com>
Date: Thu, 15 Feb 2024 15:31:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/21] tools: mkfwumdata: migrate to metadata version 2
Content-Language: en-US
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Jassi Brar <jaswinder.singh@linaro.org>
References: <20240212074712.3657076-1-sughosh.ganu@linaro.org>
 <20240212074712.3657076-18-sughosh.ganu@linaro.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240212074712.3657076-18-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::17) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SA0PR12MB4493:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d8c32c-35e7-4e46-311b-08dc2e32c948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4WjJtkuf0aVxQ1HQKXA60PPT18VoCbROaK/dYQuE6C9WQX126aRKbjQLB9zD7UlvNnRxVrBi0xh9lAwuXdNWtaFPL028yxxssbR1nno1lUDm1XvQms0Q5Os/LmTYAX2U8cEOFhHK6UwlofQGsZ70EgXriOIlziCjnrzNW7eLDUHTTfBVmcPKuv/KjJm6sOu7vyfeG2uq/AGCMzePD3kMOtMQVyDCstE0zC8KuziPAKuoVbtokNzGpv/gVYetX1n4QSnQ6WkuMrN7EXuaZ8JZ9sI+z3crfWKcdZgQn5nHED3gHWP1j5FpH91coM5SGREdPGuzeeHrd3bwmnweQc5I/cVThuBVURVushLjxkxQVQGLgszr/FNAakMok2rfGft1UEMOPWolBG2eoAZpP9iYsw6DP6YYmpMHC6SNomP+ofTlj1nHsfXRiXxIGGcK6B0I6gia+p+ExVs/DQdwZNWNOyifrAsKi3JJCjFPoUoKJF4xpWuGx3sIM1HylENrs6XeHu/m2Uzvz7nR7qQZCXlll64hMBeM5xcGV/o/ke36Ad21PX0VIMaX0Is7O+9asrvU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6486002)(31686004)(6512007)(6666004)(478600001)(41300700001)(8936002)(44832011)(2906002)(8676002)(7416002)(4326008)(5660300002)(6506007)(53546011)(54906003)(66946007)(66556008)(66476007)(316002)(2616005)(83380400001)(31696002)(38100700002)(86362001)(26005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzZpUkRkeFFNNEtZL0lyWmt5TWYyVC81OWtuM0ZiNGk2L3NaU0RrZkk2S3JR?=
 =?utf-8?B?YTlSK2kzYlI5QlZuSzg1anFMVk9FM2FCRE9QV0I1T3RvdHBycmcrWnVHLzl4?=
 =?utf-8?B?RG95MnFaYi94Unp6Z1prZTJPNitwNlE1bk5uUVpnb0MwZytabTdWOTdaVmVo?=
 =?utf-8?B?bGh6UWx2Wm84dmEycUxGUWhDRnJ1MUp3QWlacTJWVjA4NnJXOEViWGFQNkhZ?=
 =?utf-8?B?Z0dOQjBMaHgyUEw4cWlQa1R6YUxnNTd3Rkx0dVQxalJ2UU5zeWxYTXZNZ3Iv?=
 =?utf-8?B?RDFWVGkzOUVCTys4UFBGSWx5Z3NvanlBdW9XcnRKQmRDMkR1MkF2OWVWMzN3?=
 =?utf-8?B?VEJua1RPSUdiZlpJS2pKazVhNjZvTzk0aUdrSlZ4bE04VzhORm9hbTk4eU91?=
 =?utf-8?B?NG0wcTdpaU02Y3k0QTZCT29Ed2paYU1FL3RlZHNJZWkyWEZiR1NWU3RZdTdw?=
 =?utf-8?B?VFVQZWlURVRWa2x0WjJ1RHRseTliTy9sd2hVOTdHUitOdkhpcWdnOXk3Q2R4?=
 =?utf-8?B?V3A5U1U0Z2VuQUF3UzV0enZ6NVVhLzhNWC9hWTY1QWVLZlptQXRLSzAwb2ZY?=
 =?utf-8?B?QUZOamFscXFhZ2U1c0ZIQ1l6ekwwT04xREUwWExwY2kzcU00L2svM1UybTk1?=
 =?utf-8?B?S3RySlYyQ01RODk3Z212V1o3M2xTMjRYVVFzQUZCdlRwNkxnM2RXU2FDREF3?=
 =?utf-8?B?ajZ6L2dIaVptblA0SEZLclVCMGxGc200bVVWQUxuUlR6Sm9DSHZLUjVnWVVV?=
 =?utf-8?B?RTBpU01YeVJTKzdjcGtUTjN4b3ltRkpGOWxNaUVJeHJ4QTNSb0liRExjZldR?=
 =?utf-8?B?OU9XU3JEald6eDcxUHFxWTh4RmloNUZpYnFkb2hRcHNOd083RklZSURDbFVV?=
 =?utf-8?B?bGNaZTJ4WXVxdTVOT2NCM3d2amlUbzRjOEwrSXdkMDl1REtLN2FmL3d1VEpG?=
 =?utf-8?B?Q1lWSWMyb3ZNWGEyNzFxUnZPa1c3UlJZejJZM3hGUDlrNldORmR3L2JPakhW?=
 =?utf-8?B?NUZ6ZEhvSWRmanp1V2FZN1FKZExYVjBwaGhYTHo4c0hMdTVKQmhhcG9nR2lq?=
 =?utf-8?B?L2V4N3RHd0FreFRzOHFqVzFmd3A5M2wrMHJFQTRBMkQ2QzU2Q09saHMycDlw?=
 =?utf-8?B?bVZlZjBwQnRzaGE3UHpKWGQ4aDhPYTBaR015SHpRcjdGSnlqZlhVNXN4K3Ux?=
 =?utf-8?B?TXg4YitoOHUvNkYxQktlWHQ0c2EweDBwdHc4SGo0d3FSRGEzRkZCYVhtNEYx?=
 =?utf-8?B?MlhBdVlPZUE4QmNUMUlEd085RTFSdS9QT1ZMSU1kL0lvbXZuS0ZyTnJkK2hR?=
 =?utf-8?B?eGhoUXRKVUdOWCtNV3F1WE51aGdYQUdHVlFQZnJNa3RKUUJHNjN0eTFDbXZD?=
 =?utf-8?B?bjZEbDJlUTEvbFd3V20weE5VN1pMejV1NCtwYXJ5T2k2MDRIK1dOekM0VC9Z?=
 =?utf-8?B?K2xEcElaQnRJLzN2NVVLSWpzSFRyRUVKc0Y3S21zcVFFTlZpcy9ybGE2Umtw?=
 =?utf-8?B?eTJRczhrU3RBZnBaUEFDS3J6Ym5LLzJrdlhSRTRVemdLTHhDd2g2RHJjK1By?=
 =?utf-8?B?eG83d0lKN0JPZ0V3aXRFQmE3VlZBQmZpK0xYRXJVVFhaOHFQa3ZEY0ltbFVT?=
 =?utf-8?B?V3VBSWRGUDZ1WFdVZXc2OFhXZS8rUDBFb1JZdGdnVE82UnNFZzc0dldmV1Mr?=
 =?utf-8?B?U2tXb2IzeTZhU3N1WVFhaUV4Q1BnNzhFbUpKQTcveUxBVkJlbGkzQ1JvYVlG?=
 =?utf-8?B?TldDMHVvQytIanZxME0yQmwzQk8ybGlPREphZlMvaGxiK1hTWElEMHh0UzRk?=
 =?utf-8?B?amxHZWc3UmpEUU0vSi9mOUluY2JnSnd5K2dqQkFOVnZvMlFGLy9zZEFIakNT?=
 =?utf-8?B?RHN0YVFXMHRKc2pBMkM2QVB5SXkwVUcweTQ4L1pqRGZWV0FJWWRxWXR0Tjhl?=
 =?utf-8?B?Rm9vcjBmL1oxR1dJT3VnN3ozSlpLQjNMY3hCaURzclErWTZrU3N1dy9KZDRy?=
 =?utf-8?B?ZnhDWjh3TmpMa0FhZElXbUpaaGlvSWk2RVdPNEZXejBta1R4c3I2VXhSeDJI?=
 =?utf-8?B?QzdWZ1FJV2pYR3BXL2xmUlVNQ3pHOStKUW9raVZhNExQSlRsSlJqRCtDdFdk?=
 =?utf-8?Q?BPecN5sd4KyTMtZ2HQwxp2zzU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d8c32c-35e7-4e46-311b-08dc2e32c948
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 14:31:24.2495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYf5SnqcLwMkBVPx9Gq/c9VhIPmHfw6r96V9PF6d4xc1ZClpCUOeS6y9jvDquYBw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
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

Hi,

On 2/12/24 08:47, Sughosh Ganu wrote:
> Migrate the metadata generation tool to generate the version 2
> metadata.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> 
> Changes since V1:
> * Compute location of struct fwu_fw_store_desc using pointer
>    arithmetic.
> 
>   tools/mkfwumdata.c | 45 ++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/mkfwumdata.c b/tools/mkfwumdata.c
> index 9732a8ddc5..fb847e3a78 100644
> --- a/tools/mkfwumdata.c
> +++ b/tools/mkfwumdata.c
> @@ -14,12 +14,13 @@
>   #include <unistd.h>
>   #include <uuid/uuid.h>
>   
> -/* This will dynamically allocate the fwu_mdata */
> -#define CONFIG_FWU_NUM_BANKS		0
> -#define CONFIG_FWU_NUM_IMAGES_PER_BANK	0
> -
>   /* Since we can not include fwu.h, redefine version here. */
> -#define FWU_MDATA_VERSION		1
> +#define FWU_MDATA_VERSION		2
> +
> +#define MAX_BANKS			4
> +
> +#define BANK_INVALID			0xFF
> +#define BANK_ACCEPTED			0xFC

I think in previous version only active bank was accepted not others.
I don't think it is wrong behavior but please consider to select it too.
I was just surprised to see both banks in that state.

Thanks,
Michal
