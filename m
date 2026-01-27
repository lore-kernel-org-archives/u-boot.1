Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8A0D25959
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 07:46:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3699F83F9D;
	Tue, 27 Jan 2026 08:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cz8l8lIb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D887C83FA5; Tue, 27 Jan 2026 08:46:43 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 702AF83F53
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 08:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ef/YD5di0DW3oJtpz3sTbultBEc1BUGBsdCcKuChTWxHKMzExddleQx1Fb7Cv6qTt0DnXUEPoFnPWw/aVWbC/BY3rYfqCp/sus3zz4R6JjQpAnysiMWE9YdX3tXEqS+dIO3N3u0NcpfjxytEQVQrKffvHmlwLOe2uNkL/MeA+MdUb3s1remJo8wzUrsGBKHciA2Q52dtKxdKSJxLHnizBdlrq+o2HpKCoCBTE3TS/dH524Ij/1MBKSnnv3fUnYfdvktIKpRRRkuoCzc6igD1C2P+fbRDsHGl2yloxLhFjl+6j6vUsFiMHiDkunOJhqLgSwogrdikBvKOBreoyD04Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBFFHjP5HXrolLXD0En4ChrKicszvnD/DcTETST+PCM=;
 b=SEeNmNt947ppT9WW4m+5D7ebSQALySqEmf3NW6uyvYZZxc7tDvhYJ12//Dy9hQsnTZWbyTGTPC+xdu5rf0xYMMJM0mhc3cvJ4gIA84TGsuZBI91bhl6054hII3x3NbSubdhMqqqHJ2MpT3Ka7MJzzCmhJAlNKCyK699yxb1ceoi92+SM3F5VGoiSh97j6OJHNCdLaSk31J2s0pSTo1TslktzfUBF1Hg5qe8r9PT5PfHuSBMKZ4evrQLjromcedJYvDQBm7u0WUyqJ0K/lSuS5SA8+9w/txPwa7vAl7GoulAL80ERkQERuBjTFemyTFaOD8OzKxo0zipOPe71QWIYOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBFFHjP5HXrolLXD0En4ChrKicszvnD/DcTETST+PCM=;
 b=cz8l8lIbaVYbLhdRBDi7Wo+GwQp+3euHmeG4Nl2hEtW8xG1TzI/u+LTGLbBMCZ9wVhMAPAmAud9ZQeMyibp4sbxlA/+zs7/bye5yo7kKd+3sx+2ilfPiMpbwrwFaRpYM5C0sqTugl7OZhzInv7kBGWSKOpybqzeP9FfGId1Dfdk=
Received: from PH8P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::33)
 by SA3PR10MB6971.namprd10.prod.outlook.com (2603:10b6:806:311::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 07:46:37 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::fc) by PH8P221CA0020.outlook.office365.com
 (2603:10b6:510:2d8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 07:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 07:46:35 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 01:46:35 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 01:46:35 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 01:46:35 -0600
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60R7kUM63986698;
 Tue, 27 Jan 2026 01:46:31 -0600
Message-ID: <89bde76b-b144-4323-bcdb-4ea04b55d695@ti.com>
Date: Tue, 27 Jan 2026 13:16:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mkimage: Default to 8-byte alignment for DTBs added
 via -b argument
To: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>
CC: <ilias.apalodimas@linaro.org>, <malysagreg@gmail.com>,
 <sughosh.ganu@linaro.org>, <philip.molloy@analog.com>,
 <marek.vasut+renesas@mailbox.org>, <james.hilliard1@gmail.com>,
 <anshuld@ti.com>, <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <bb@ti.com>, <praneeth@ti.com>,
 <u-boot@lists.denx.de>
References: <20260122172247.2995437-1-b-padhi@ti.com>
 <20260122174546.GB3416603@bill-the-cat>
 <c05217b3-f753-4fd1-9582-921e2cfd3a0b@mailbox.org>
 <b65ad902-2d07-4948-8a1a-64f4d5825a08@ti.com>
 <1e1f2e09-bfb7-4c7d-abd6-25a79271f256@mailbox.org>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <1e1f2e09-bfb7-4c7d-abd6-25a79271f256@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SA3PR10MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ec7e37b-c481-40f7-1ebc-08de5d783288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUo5MjhlUE0vaEptT1NMNzNFd0hsVTQ2ZXdWVlNTcTZEVlhiaHRNazRtL2Z2?=
 =?utf-8?B?SVRseWhQV2srQ3ozK0ZJQkE5TnMzWTNlRCtVMTk2T3pOanZkTEg3QU91dENz?=
 =?utf-8?B?Q0g3TFNaUDRsdS9tcmtZU1V5MFNHdHJ6dFlSSTU3d1hIM2xmM3IralMvcktC?=
 =?utf-8?B?cDhYQjFrNHFYbGhZRmZFV2t0c3NRSzAyaStLNXplZXB1M2t3YzU0U0JRN3p2?=
 =?utf-8?B?RE9DeVpEWWhRSWszQ3hrOXdmblFBNlZXTlozZlNBYTNnSWJvdlpsQ2Y3azAy?=
 =?utf-8?B?Z0xpU0M1ZXUrMzJ6TlhsR2ZLZjlxL21XS3FiVTBuZldQT3JoeE9JTE42UXkw?=
 =?utf-8?B?TVBIQ2pBREJTRDhTd05rZzZkd3FURFM5dTBpWmpxRUVWa3hCUW5NcmRDZmth?=
 =?utf-8?B?SU9qdWpwbW0zZ1ZaazNxN0RQalB2YnVwMWU0dlVqdStEYVFJa3lNd2xGSVRY?=
 =?utf-8?B?WkNiK2JudHgreksxWDZCZEs0SUoyUDcwZUZaWjlEQmNYd1IzbHlMb0h6ZXZR?=
 =?utf-8?B?TDhVa3dIUnRNZE5MSW5qaVI4OTlrZkxkWTlmeUF4NnQyRHlKR2Q2NC9rNXo0?=
 =?utf-8?B?VkV1djVDS2J0emRITmdkWjNmRlNtRnpZcnlHQ3dUaDBOUjU0Y1hsNklBaHJr?=
 =?utf-8?B?ZjQ1ME1XVVB4K1p1byt1T3lVM29GK2hUZTBSSW54WVZJcVoyQTRtbzlHTVlC?=
 =?utf-8?B?Rk4xOHdkYXdlaGR4NTgySGNhME1HbHFSaWViYnRMOEFPK2xjeEFZeXdkb3Nt?=
 =?utf-8?B?ZWU5c1MwWlBhc3JTUVVKajIzcVRBSkw2Zkh5MU9hWklPSmt0V3plVkxPN3hl?=
 =?utf-8?B?MjdzZnZ0YVlxaFNKS29sRXJNaEQxSEdJbTlyVVVwZUhCbllyRWNkWDdlR0ZH?=
 =?utf-8?B?WkxJOXc2N1Y2MURRdnozbnNnK0tTVEJNb2REQldBSXEyeEhLa0tQVUZiaml1?=
 =?utf-8?B?OHYxM0cxSTNXTTVNbUxHaXlNZXZlNzJpOEx3UzM2Zlk4Y21CVjRReFl5VGJ3?=
 =?utf-8?B?WklaZmE3b1I1MXhoYys5NlQ3NlBEL0VXZkYvNW1uSUN1bTNSc3RaRGdyL2xR?=
 =?utf-8?B?UXVPUWFYNEVPa0U5cWRIMElRYzFTSFNIczJoRTczYU5rRzRleXpacStOSldm?=
 =?utf-8?B?UHoyZUFVOWpCOTNiOWxPR0hUbkV1YUdrOGlvZGJ4T3pPR1ZCM1gvU1VmRnZP?=
 =?utf-8?B?MWQ5NU03bW95UWtkUlZFaTRpY2J5SW5rLzV1dkdmMDduaXJzdGs5UlZLRnJK?=
 =?utf-8?B?RzIrWDR1S2dOVHU0Tmo1R2FsVzJ6NFJDVCtwZ2lXQXMwMXAzclZvb0ljYlhs?=
 =?utf-8?B?UGZEeE5uSWk2NUlOOGJkK2hHc2U5UUI5aUdMQUltN2RIbVZTZjFlS3czRk51?=
 =?utf-8?B?MWZQSkVYYWtkbmI5NXRYTVdhRUh0Z0lrOEZ1ZGkrbnZlNllqWTVSUXBGRWJ2?=
 =?utf-8?B?eU81WHk3czh3WmZzU0ExdjRPb29QWTRYVFdweW9SdU1kazNVSVBtSmNzT1pv?=
 =?utf-8?B?M2Q5Mmd2dEhYUkhrUnE3eUhSVGU2VWtXVFFVWEpZOThDRmcyY00yYzVTNGlh?=
 =?utf-8?B?cmJwWTVTYm9ZYnMrcVVLSDY4bVBYVlQxMU5xR1M3ai9VOTVlZkhHK2R2K1JN?=
 =?utf-8?B?d2RWdVBqZ055YTU3eDVvaVEyTXcxNEdMT044M0NVbS9WczdUcVRWY3hjUWpM?=
 =?utf-8?B?MHJhUFhFcXVJeTYwMWp3SU5NTzRNOEg3VnZqZnJWMmE1SHJTTjMyUjRPNHNQ?=
 =?utf-8?B?eHpPbmJjTmNXUXlST01meDFZWGEwdDN5cGdYdW51VUhQZkVyUTlUZlVvVVl6?=
 =?utf-8?B?b1pjQzZtdWt1OUNwcEljenZPTmF3T1B1KzNtaERuRTJzeGNqajFxNEdpc2JD?=
 =?utf-8?B?MndRL1NwRmVGYmtvV2RuZ0w4MW5YSjhoTUhkQ2dJbjVRbzBTU1k4dXJDRlRy?=
 =?utf-8?B?VFdwaDF4ajIwSm43bzRZT3ppOENtNkdnZWMxamRERm5YcVVUaFVWN2k3WlRs?=
 =?utf-8?B?SHgzSFpMcmVISU1oaXVMRFpHZ1JIWjdFcWF3OXMxaDhnbk05b2RCSUpYMWNF?=
 =?utf-8?B?dWFWa1dxbkVpUktwc3JGdXlqNjhvRUZNSjgzUnB3S0cwaExsNENhSUxHM21O?=
 =?utf-8?B?cWFkVnlTQXdrLytEaElSUVpuYlFyelk1NER2ZVU3LzBjdkVkRzJscGJKWUFT?=
 =?utf-8?B?Sk1mTU9Rb00rUUFCalN6YlZiV0xjOVVKWTIvYzJvVTRVNXhSVDBLV1ZuSzlu?=
 =?utf-8?B?REwzZVhKbXhEQTlyZjdkY29LSjlRPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 07:46:35.7521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec7e37b-c481-40f7-1ebc-08de5d783288
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6971
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

Hi Marek,

On 23/01/26 15:57, Marek Vasut wrote:
> On 1/23/26 4:32 AM, Beleswar Prasad Padhi wrote:
>>
>> On 23/01/26 00:33, Marek Vasut wrote:
>>> On 1/22/26 6:45 PM, Tom Rini wrote:
>>>> On Thu, Jan 22, 2026 at 10:52:47PM +0530, Beleswar Padhi wrote:
>>>>
>>>>> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
>>>>> packed inside the multidtb.fit FIT image. While the individual DTBs
>>>>> and the FIT image start address are 8-byte aligned, the DTBs embedded
>>>>> within the FIT image are not guaranteed to maintain 8-byte alignment.
>>>>>
>>>>> This misalignment causes -FDT_ERR_ALIGNMENT failure in
>>>>> setup_multi_dtb_fit() when locating the next available DTB within the
>>>>> FIT blob and setting gd->fdt_blob, because of the recent libfdt
>>>>> hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upstream
>>>>> version v1.7.2-35-g52f07dcca47c")
>>>>>
>>>>> The mkimage tool already supports enforcing this alignment via the -B
>>>>> option, but users would have to specify it explicitly. This change
>>>>> makes 8-byte alignment the default when using -b.
>>>>>
>>>>> Reported-by: Anshul Dalal <anshuld@ti.com>
>>>>> Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16ZO19E@ti.com
>>>>> Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c")
>>>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>>>
>>>> Tested-by: Tom Rini <trini@konsulko.com>
>>> Doesn't this enable 8-byte alignment for everything in case a DT is specified on mkimage command line ? That doesn't seem right ?
>>>
>>> If I do mkimage -f auto -b ...dtb ... , then I only want the DTB to be 8-byte aligned, all the other blobs can be 4 byte aligned just fine .
>>
>>
>> All the mkimage flags are parsed at once and populated in the params
>> data structure in one shot in the code. There is no separation of code
>> specifically for generating a FIT for a DTB vs for anything else.
>
> That does not seem to be true ?
>
> $ git grep -p '\<bl_len\>' tools/
> tools/fit_image.c=static int fit_extract_data(struct image_tool_params *params, const char *fname)
> tools/fit_image.c:      align_size = params->bl_len ? params->bl_len : 4;
> ...
>
> So something like that may work ?


Yup, you're right. I was fixated to correct the alignment at the bl_len
layer, so didn't look further how it was getting propagated.

>
> "
> diff --git a/tools/fit_image.c b/tools/fit_image.c
> index 0306333141e..0c606ba4cc3 100644
> --- a/tools/fit_image.c
> +++ b/tools/fit_image.c
> @@ -642,9 +642,15 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
>         for (node = fdt_first_subnode(fdt, images);
>              node >= 0;
>              node = fdt_next_subnode(fdt, node)) {
> -               const char *data;
> +               const char *data, *type;
>                 int len;
>
> +               if (align_size < 8) {


Do we need this check?
Although unlikely, but should we account for mkimage invocations
with -B > 0x8 and not a multiple of 8?

> +                       type = fdt_getprop(fdt, node, FIT_TYPE_PROP, &len);
> +                       if (type && !strcmp(type, "flat_dt"))
> +                               align_size = 8;
> +               }
> +
>                 data = fdt_getprop(fdt, node, FIT_DATA_PROP, &len);
>                 if (!data)
>                         continue;
> "
>
>> We
>> would get the same result when using mkimage -f auto -b ...dtb... -B 0x8
>> I think we should be fine with this limitation for the usecases when
>> generating fitImage with mixed images. Unless you have some idea?
> What about the above ?


Thanks,
Beleswar

