Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BE4C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 10:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27F0B8750C;
	Wed, 20 Dec 2023 11:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pwP6eYAv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1D5E87630; Wed, 20 Dec 2023 11:55:59 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDD3087509
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 11:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAV9KGXCJymBOInDaxy4qxg2MkgM10llmn2TJiuHQDPktRIdG0M8fUHiYTXGZK1kBwnx88dYDiCUJK6/k+CpskZYea4t0PbiFXYAN6DaRdHyAejks7cI2km67IHjkhmAAP4Bpft2t05Af7N5Pp55ugnP7oD14pT5EqK55STR67rohGrL5PbmTk8IA0cVwq8rUQB+vRYLbSiZnnwC0w+695FT+KEeozMG5QExz9tIPcJNS0g5IkXJfFtMi5meCCUe5qGKncB6DlqM21amVwoo1pRbxx5UTEh752b+y2gEoSSn6bLw4XHu09tbYuueXWdOIe+S8X8fzuN3OnSUk/RT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/nc3cIVIJfrnWSE54DU2gxYMY34ZgSQs8E5PgNpAW0=;
 b=KoMPLYfPWn1or8mLJOcnCOfDvYj3dg8QONlcyBHobSVzBf2VAfApDCeg6dU2eIYUnqdHSby+T1C/iaLrCLKu8+7r/wJpaQ6U7bbGQraDtx3acWyYG745wtHbbIxPqaY1frU8OtLrr2M5lLkUB+I44E3Cog2VR2z1ZPA7tcBqGgzJDkcNuZeb+K204syOIiFLYdiXQopj7m6MizKOSqC+arq1npySlw52UcdzzE2jvO9Qo5OLx7h84xRdpQA3Gzsh3HU/tGnQ/+yVkRt0pKkr7espYdICLlGBjkaNz0ue6UBxaRrl2EPAd2QaVsTBZlBDIGK+E+ZH2k7R700bZQJMjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/nc3cIVIJfrnWSE54DU2gxYMY34ZgSQs8E5PgNpAW0=;
 b=pwP6eYAvjTFxkwB02mUDnHDedB21QgLIkxie+T7su/rBYBq5qzfZWMQvLFuyWgkgbxTZG0YeGonx05pHw1/h0IMsTFwqhJ1hgVQ8GxAFjPLCdTo/urKXlDLqeVe48NaSQXx/H9ynbflkCEZxq+ZWppemuBdBSHYvfwixscdzwxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 10:55:52 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 10:55:51 +0000
Message-ID: <aeac47cf-99bd-4256-a622-86d9f6369e4d@amd.com>
Date: Wed, 20 Dec 2023 11:55:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] qemu-arm: get FDT from bloblist
Content-Language: en-US
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, sjg@chromium.org, jwerner@chromium.org
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain
 <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Sean Anderson <seanga2@gmail.com>, Qu Wenruo <wqu@suse.com>
References: <20231219211114.393193-1-raymond.mao@linaro.org>
 <20231219211114.393193-6-raymond.mao@linaro.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231219211114.393193-6-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0128.eurprd07.prod.outlook.com
 (2603:10a6:802:16::15) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd1fe49-d4fe-4923-6f7d-08dc014a3b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LBYlv7M561+Pb9BcOd7HzKLHgfgYVVmAXtw1jZQexiOBhJA8mxYfsbamj7flwQ1k8d4ytu9LibRT7rorh3fVMGF1XscRVsY0vt0kPCsDNFmHu3KLei+6OBe2Ou9XPKAUSCiIrTegnpVh56mSUS4jBDUajfpu/CfQ8ozNVq3VG7Do56Lze3/e+H40CYHkqJgs6TMyWn2a8fPZ1YLuCYBmz5g6xlDJ0EZOEjbm4VcHRd3WWTtinhdZ9FPjgfp6ju1eWf6jUfYUjwaB92JDNIcmUWSzwo4baMslM9uoJ1ujnrV+jOO24ZTvnNMtDOAFoSCg9DN7OtkupyipufwcvL6IiryPxT2dZHfsvjkqmH3qqDG486kaervrUULuQEXEVK0g5VUd8AnV2n85RJ0w83h6zMTGtORNS2Zp/R3B8hvOB61Q6cMFOTnwUPVbJEWnijhh8Td4zPfwobesXUQFy8r0L5OmeI1vCEx9dhpSvIxq/owfr+qbBR8+gqYJdJo419JZXa4YK5g8EUQ9+c2qx+nUvCQGv6ufd0siyC+S9g0NR0MOfNPwgZULPhaKeETmPtD8NjP5/EBCJ1fqH5Ib/gpy3J0GCVZ0rjqDPaJd0Vu1IPZwzMg29Cc1nq+Y7A6NMmjg8Sce0YWkT7YoFMtHUoI+cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(39860400002)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(86362001)(31696002)(36756003)(66476007)(6512007)(6506007)(53546011)(66946007)(6486002)(66556008)(6666004)(5660300002)(38100700002)(316002)(2616005)(8936002)(83380400001)(41300700001)(8676002)(478600001)(54906003)(2906002)(7416002)(44832011)(4326008)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVZ3bDhzZ2d5dlRvcGplWVRDbWU3MEtjcEFuM3hQT2RDcEpRNHRtUkk0U0pM?=
 =?utf-8?B?Z3oyRmszU0p3MkFZUjB2cisyS0pDYkxySGh0dmFwRzdtSTNyaHdGQnpmeFMy?=
 =?utf-8?B?TmY4eFNNTkRsY3cxbXo0K2RWVzBPcGxjK1ExbzV2YjNtYkU0WlBXNVdjVFpZ?=
 =?utf-8?B?YTJWSG5NbXIvaVdHcHZac2xobmtkMkZxREJxSEZOMEt0UUlEeXlXR0p3eDVi?=
 =?utf-8?B?L0Nsdjc4TVQwSC9iRWU4Wk1zNUZwYmJlTUd2dlV0QzZHMVV3TkVBd3hVUWQv?=
 =?utf-8?B?ZnZWZFR1TjZwU3FLdzF5SElDSnNGa0x2T3hmYS85UHo2c29xTGxPWmMyRlpB?=
 =?utf-8?B?SWVMQkpyNENWVElJZVJIalNGczBMRVZ0N1IwaldvVjFyNmpYOGk3Si94Y3NU?=
 =?utf-8?B?WlM3a2h1R21pQUxIZU1PbDBQRG5MRXhtayt2UWxENXJ6YlY1Uy8zYXlaTlhi?=
 =?utf-8?B?Y3ptdXhoU1dqUmo3WVJGdk9uenZuWVVxc1ZqNmw2cUpabklxYTNDYTFESndj?=
 =?utf-8?B?WG9STkEwU0V0VWlyeTd3d2s1V084U09rbTVURjdmVGt4cWhLMThVZ01TR2VM?=
 =?utf-8?B?OUlpM3o1akUvUWFsSWR3SE5nRnJxeFY2Q1RUUUhaQVd4eTJ2Nnc3RitqMTIw?=
 =?utf-8?B?bkNldVhCTGRLOXRRbUdTZVNNV2VITW1sdXRuRXNkNHRMVlJZOC9wUy9mZDZM?=
 =?utf-8?B?VHN5U3RlbWEvTnZwUnBXRnZxQUtvUTQvUE5qWk9FNURYRXNBeTIxK0piOFVK?=
 =?utf-8?B?cytCbDYzUkZreGwydmJjRklJbzdpMjRuN0VpNGFFbkU1dUFHNlkrS2dvWlRq?=
 =?utf-8?B?MzJaUnNzcjM2QWJ0OHhYbUc2VlFsd3JjWTVJaGR1d1NUeWUrMlpLUmxPMXFt?=
 =?utf-8?B?SEh1NWdhNDFXZTJ0NGtlTGVBN1NXYXRxWW42ZWVWbU5RWkNJWTgxQ1YySDdK?=
 =?utf-8?B?Sloxa1BQYnlUTit5NEZrdjlLS2RzYms1VWl4bjlXMXArRk1Id0k3TTJxaWlq?=
 =?utf-8?B?VHVzL3RQWWQycFlydFE0WldpUExZeGRQbU5UOXRuZm83UkwxVTI1dm5sYSs3?=
 =?utf-8?B?UnRnL2JFQ0JNTTdwMjgyWlRXdlRBZ1dsK2Q3ODVpR1cvbEdOU09Bcjc3Zk9O?=
 =?utf-8?B?U1FaNEwxQ2RtZjVCbUFDTmR5UnFDaXBMSE5EaldDLzk4MUUvdkZrTEtDWEJn?=
 =?utf-8?B?aHdRbnVVY2tZcGJzeUhYVlZhcWZBeFNEQ2ZDeEM0SE94b3ZTK3JRNlNOLzlW?=
 =?utf-8?B?dkNhaUVmU2VZRU1rSFVKN1FGNms1RGJodWV6R2VJQ3ZEY3Y0YS9TYUpjVlJR?=
 =?utf-8?B?dEQvTjdDK0dKeVRkeUk4VC93SFJ1RXFDQ0JQRE5ERzgxUERuYVhCWTN1dWdp?=
 =?utf-8?B?VkVJc1V6Y2JGb25ma0lXRUZ4ekVZcFBaN3ZpZ2w3NlA0QkVzcnlFdTd3bGFn?=
 =?utf-8?B?dXRCOVVuelM3b2x6aGJJdkU5emJwZUljME4vekRsaWQ0dkhMdGpYbEorR0xF?=
 =?utf-8?B?a25UMVZIWWMvTXFXam9hYzd3VkJOd1BtQ2lHNkxsdGN1ZXY4TG9uTytWbnpY?=
 =?utf-8?B?Wm1Zb3E2MkdoNUt6V1VORnlTMG9oc3ROa3ZKR1Y4bWtyamFUSk1IaTltbVRr?=
 =?utf-8?B?Q0VsMC9sOTdFdS91aWsvcitoQ0hxME0zZGRPWTlOUzlhOWlSdWQwRE5UTTJH?=
 =?utf-8?B?d2YzaWsxdUxHMmtaOWRvbS9rVGVtL0F6VmxMbFBtTjErTXh5bktWeEp4MStm?=
 =?utf-8?B?azVCRytQd01WUzhLeERSUlN2d1QvWmo2dUdKem5ZMGtFem5QaWZUNVpSUzd6?=
 =?utf-8?B?WnBycWxoS0pkcHdHTU5OajRBbm04QURrZG91RW01eHN6c25reUErNWwzYTda?=
 =?utf-8?B?bWJodUpldlVVRVRJUGJ1eGQxTGVNOG5BbVhjNC8xdTFqUW5Mbk5Nb0cwR3Za?=
 =?utf-8?B?MWt3cUtOSkVyL3VWV3hkVC9xS1Y2NDRva1VGKzRjR3loazdSSko1cXF6b3BV?=
 =?utf-8?B?VXFBcVZXckJQOWxkTUtxamJVakZaeFM0V2tCc242d1ZJc3ZseHkxUnFBKzM5?=
 =?utf-8?B?WGFFeHFJUVdNM1gvVy92bmNNemVRNWgwS1dkWFV6NUR3K0R1NE9XckZ4ajhp?=
 =?utf-8?Q?1lx6pet7j569WxAXTy8XoYTPv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd1fe49-d4fe-4923-6f7d-08dc014a3b5b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 10:55:51.7590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7WdJOM3kUfybgXt6vfdgFMUKg24I+YSt7cR5yr2L4aEZezbP5vfbIuXBXq7gOfm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768
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



On 12/19/23 22:11, Raymond Mao wrote:
> Get devicetree from a bloblist if it exists.
> If not, fallback to get FDT from the specified memory address.
> 
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>   board/emulation/qemu-arm/qemu-arm.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
> index 72e0a97567..455c042a9a 100644
> --- a/board/emulation/qemu-arm/qemu-arm.c
> +++ b/board/emulation/qemu-arm/qemu-arm.c
> @@ -148,9 +148,20 @@ int dram_init_banksize(void)
>   
>   void *board_fdt_blob_setup(int *err)
>   {
> +	void *fdt = NULL;
>   	*err = 0;
> -	/* QEMU loads a generated DTB for us at the start of RAM. */
> -	return (void *)CFG_SYS_SDRAM_BASE;
> +
> +	/* Check if a DTB exists in bloblist */
> +	if (IS_ENABLED(CONFIG_BLOBLIST)) {
> +		if (bloblist_maybe_init())
> +			return (void *)CFG_SYS_SDRAM_BASE;
> +		fdt = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);

why not just.

return bloblist_find(...);

> +	}
> +	if (!fdt)

And you can ignore this if here.


> +		/* QEMU loads a generated DTB for us at the start of RAM. */
> +		return (void *)CFG_SYS_SDRAM_BASE;
> +	else
> +		return fdt;
>   }
>   
>   int board_bloblist_from_boot_arg(unsigned long addr, unsigned long size)

M
