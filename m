Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B086C10ED65C
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 11:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E628583E7A;
	Fri, 27 Mar 2026 12:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zqn7Q+fA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D76483DBF; Fri, 27 Mar 2026 12:45:13 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C05BD83C14
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 12:45:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awT9I6s0dc0X7rkqZtCXFBa7g4osQIkAmbKbrudlDJa2bOpYtUXNiRiXnxZ4LhQWk0ZkmppsMDBJ7Xs8euwNkOPItPikUO+/DDjX5k+SdUTsvL5beOJeZ+2uz9pN4RZYUFAa2YCk/YlAM2QkZw0/Y/NqODmL7C2oZEDdLF6F0axRaskRI4l+i6oHhnPLSYFh4xVVjd8G9hQpppabH9ZcnBGlq6kffrCxZD5RVCTFmplPpqNdbZM0ZGa0aezP1b1qG8mog82/pKuojJjHBOhg5ZOnBaMjbJkmqrDrbIrffBV2TglsHpRkpTco73MR87iLhpWYzIZNJPCMdPghGUkoYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e84kq9tQASnC2Gn84rQjhd4K7RMzwA1JqZ12BNTvj1w=;
 b=CQQNvxUwzSiVpVl1lH0Q5UPa915uZ2KNu5bALKbIQzC6lZojZw6rwn+eWygw9v+sUS9p0xlk8csyq9YmYCAqLa9gJQOf76INXZS/C0VfsCKXjoy78R149CeyRdRyvTHez1XJqh8C7XtBJacYGrZAk4jCSRbw64TPz/hHlvG32n8T5aZMvR4jjLB90YK04fUFWT7xnjUuV+aB7zX4nd2L2jkCs5HXWIveK/wMh0gZcnyUzuxD6Qd9Wh/NWrONzfyVK9I2m83nkJYQsRVQCItFz09jk0zCNUeZVBEElq/Iv2rqqw1NesKE0FJNBMbHU/AmmpBgscz9GoB05aiMBJuJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e84kq9tQASnC2Gn84rQjhd4K7RMzwA1JqZ12BNTvj1w=;
 b=Zqn7Q+fAaeAGi8SlO5XEa5I5JbGr0GxXgwqfHNWu1bSrhZ52ugdr2dECXwnM0Kar9gESooLLvp+Ok0zDzXO0r+v5/gz7AG0IH3OeM2s8odnu6MxHjopdSonPOgPRvFHJWGam/LzoaOFac/izxwi2O3i9SfRd5kW1Dzh8bdyQ3WI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 11:45:05 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 11:45:05 +0000
Message-ID: <93019930-f082-445c-a3c4-90024aadbf60@amd.com>
Date: Fri, 27 Mar 2026 12:45:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] firmware: scmi: Fix setting the function
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Vincent Guittot <vincent.guittot@linaro.org>,
 arm-scmi@vger.kernel.org, Linus Walleij <linusw@kernel.org>
References: <cover.1774526652.git.dan.carpenter@linaro.org>
 <401560217b674c299cb0f344e6f24c271fa7583a.1774526652.git.dan.carpenter@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <401560217b674c299cb0f344e6f24c271fa7583a.1774526652.git.dan.carpenter@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::26) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|LV8PR12MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: b6fab17a-2279-498f-df1a-08de8bf649eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: FH/hEjEQn1MMigHZ8WdbLzrIOiZMf6hE/pldTjlhHX8IhbmfsZf7pr5VTebZDMM8MxFTqowkqoqQE8jXFICbEGT0RU88wAGVQhc55APVvY1r0wVAIDr4D+KmwAXwu18hVOVN/VugHYlWlf12mWCSkAT0fF+VK3KDYi814erti3vCrVJr7l49toG13GFYcQiebSDPQtJUkIC0iTFnWhTsgNXFMQoqSqtyrXs+W3vk5fee2SRpHK777SnJtJLe5w0RWR9KxClRO8wlR917UHssqTGAeohTPdCFFOunCV5k2sWcRSKNbq0muto3Xi4r1KVpuff0eG4VV6O34JeudBSUCY0DHYmQPoBObc7yIjXWpR527IyaT+YI48Kut0U/vhZfm/KpaGdnwTGiqmntBGvQtqthmVHbsUdUUqpJugXhxMms4Fo3174SN7ptjbdfnqlTjj++1e557f3YDLB1Gt7VYVuS03O/Z8jpcEzZ88xNcH71WELDmKLFj8Mxdd1+akcXUVZAbilg8BRl6Xtfkcx5O6ckefl2pDtL5UO7dscLvYcrJNcrGVYiflGqJU56ZY/bCqRMYH4HcP0EujtCNz8OqnPjBnbG+mivKomWjSA7mtWWciPgT59ImYH1WvuUoc/SplfzYeKSipmYHFBZwn5w6fz94TVBCshO2v7eJot1NqtAvA/hB1341vdZA2bP3Yper+fy+K0wdcxdek8Dg7X25wrTrX86SteqAzJG0wSItJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y25zT0taK0kxeWliL3VadGdVYjFhdmZrQ2J0bXpMZjhQU0hmdGdCY0RZV2g0?=
 =?utf-8?B?TzJBQWNuR3VrdXFkZUNVTDdHcENiSWFBZFFUaDU2b3VZQ2JrUTl4Tms0YzBo?=
 =?utf-8?B?L2s4eU8xNUJDRThvOGtpSko5Vjg5VXdicmtJbjBLVFQzOFhBdWRMRkFHenVP?=
 =?utf-8?B?dkFHZTd5Tjk2bGd2Z1BhSmdhZFRRZjRNNkRiaEZma0NkTzA3RGJCV29MaGNM?=
 =?utf-8?B?U1FWUFBIZktsb0xQbStUY1hRa0FNM2lsWFFlaldaZGJqL3BTZzl3S3o1VzEv?=
 =?utf-8?B?NDY0ZDVFY2hLT2FyWmh4bmFJRlREREo4aWx3Q2tBSzVIZHQ0SUFoVUpFYXph?=
 =?utf-8?B?Y1RTMERvSit0TjRtbFlMdmRUdGg5TldMYWtNRnk2b1V2eDcxWXg4WFhKODBh?=
 =?utf-8?B?aTAxM1ZCSzF6SjgxN1ovNmN6RkRrdXNzcEhrQmN6RW51SFVDV1ppdkJyRXdY?=
 =?utf-8?B?d09FVkwvTlEwRVU4SDhZc1prM3h4N0JSM1o3U3RuNk10ZUgrTDh6eHNQbzZM?=
 =?utf-8?B?ZEhoV3hZbjF4VnRLUXVjNzNuaTBqUnhISmNLWWMwM0VsaktZV0pXV3N2YzR1?=
 =?utf-8?B?VjZac3NuVzhER1dlSUtTN1hYa3RjRm4vZmxwVnRnNENIZzM4WkVpVXArWDVO?=
 =?utf-8?B?L2h4bFhRNHpVdzJqRVBuOFRwSE1IQ0kvWk1RMVVSNUlTUW5ZNW05b1lhbXVY?=
 =?utf-8?B?R1RRejVKZzhlTmZHV0JCRFNYNWFvSDJEaGltUys5VTJtZjVlVkkxVjFHVEVo?=
 =?utf-8?B?clZZaVdpKzRjeDNGRWZ1YTF4a20wcTNvdmIzV3g0eG5sVTFVT1d2MHJmRm1L?=
 =?utf-8?B?eCtWdExFaGhVZUtzanE2TnBGQTBqaFdZY1hCUGM5eWgxWmhQS0RmY0ptVXZF?=
 =?utf-8?B?a2V6NW0zNUJhaUU3d0ZtdUk0d25heHlxTnIvYTRobVdreWwxSkJnek1ucFVk?=
 =?utf-8?B?c2dEZGptVXVCc2lPV1Bvalh2K3psbzFBbkFyckYzZVMxTmFndlVSekhpZVR6?=
 =?utf-8?B?cmdiNmJpT0xCWnJ5RTJQK0tBNVNtOUMraFlHQWluYXNlcE9iVCtoMWowQnJq?=
 =?utf-8?B?UmZsWmRQOHlSNkRKdkNyWWgzMVpoUVdxMXZNanRDbTdVa0I4VWxLUzlPZyt1?=
 =?utf-8?B?WHhEaTYzeVpDR20yNFBFaEdVdndUMS84b0Q3cmdMdUxtOGtFWW1oMFJqMWpq?=
 =?utf-8?B?NWRBNVdBYlo2d3RrdFJReWZqMU1EcytMRGlLUnRWNmxBM0tEZG9NQ2xuYS9W?=
 =?utf-8?B?TzIxaFdyOWltMGRkUjFFSEMrWnFZd0U5N3NQSDI5WVI4ZnptSktOL1RJcTZF?=
 =?utf-8?B?L0dzTDROK3lodkFiaVZoTndtQmRGS2ErT2RBNWdZbkVJQVdIeFJ0VnVnY3FW?=
 =?utf-8?B?YnRJWk0wUE1yRWx4OFdCTG9zWldoOHo5d3diVkUrK0NMbDNnTUdia1loTzB1?=
 =?utf-8?B?UGttZTl5eWlMZkgvNEt3KzFLRTZ1dHkrK2VKbjl1di96dUhiSHl1VzhmVzl1?=
 =?utf-8?B?aWl6Z0V4OUhNQWdQTE9lVElDQmhONjVnbEd0MVU2UVhHazlXRm9Ya1dLcnJI?=
 =?utf-8?B?OW9iNTdmQ3VxbzBlK09XZElHMnFzallOamJjY25nQmVsMW14MHZOamwwQ2Zx?=
 =?utf-8?B?cWd2dlh1eTRDUzhHWjdnQkRaTFF2cEN1MHNhQkhJakhjbHNKS0FNSW4zQjRM?=
 =?utf-8?B?T3ZjVG9ETHd0L3gweW5oZ0ZITVd0U0xFRDJwellpYUdTNVhlL1RraTExeThm?=
 =?utf-8?B?NzAxcFpHOVgzbXFSVFJwdC9OQWZMM3pGaERROUhCUVdLT2dUck5mRTVhNFZk?=
 =?utf-8?B?aGpxamFyc3dxYm5Kc2pmenJ3ZmhBS0tJcnlLWmJLeU8wSHI1ckJMWUxrYXpX?=
 =?utf-8?B?aFo0T2hQSEYyajZPQ1gzSHRnNUpkQmd5b3lFcW55MUNDWndDVk5kY3VWU2RN?=
 =?utf-8?B?MHJ3d21CWVptKzg1UzBZNENLenpJRkJSWWxnaDJoMXpXSWtFZi94OUpzNVBh?=
 =?utf-8?B?djl0SXlUSTJ1ZkxOSWdzVTFRRlpsbXFuZnhXaitjcTFobDFNQzhtTjRwemhW?=
 =?utf-8?B?OVl4dk1NWjJhSFp2VDZiM1IxcWpkYWhIL3dUZWZzNW4wa2V3eVlpRFo1Y3Vn?=
 =?utf-8?B?cktmWVRkQUdsdnFKVHBVWlZmUzZMQjZoOTlvTUlmd053b3RML0NmQ0hhMFRu?=
 =?utf-8?B?aGVGcXZ3bjQ2ODZvRVArZmNVdGVtRnRzMVZRZEZvdDAzVXFyeno3RzNkWmh3?=
 =?utf-8?B?RURzaGV4UGdFdkI1cis4T0kvUGp5ZVJpR0EvL3hCRmNGUVV2VVJaZW41bWVR?=
 =?utf-8?B?V0hVZ0p6RlBhYVJTSlVROW1vb2FKdUdybW1LNkpEYkNUNHN5cHhVdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fab17a-2279-498f-df1a-08de8bf649eb
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 11:45:05.3615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/Wl3bjfy+woFhuvYSYfCT3fgRyIQfW2EIEHMtf36OokWtkCBh5UkizCAdAtPN0W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205
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



On 3/26/26 13:08, Dan Carpenter wrote:
> Set BIT(10) when the function needs to be set, otherwise the setting is
> ignored.
> 
> Fixes: 1048331f5d3c ("scmi: pinctrl: add pinctrl driver for SCMI")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/firmware/scmi/pinctrl.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/firmware/scmi/pinctrl.c b/drivers/firmware/scmi/pinctrl.c
> index 47f7a8ad9b81..e670538c87f9 100644
> --- a/drivers/firmware/scmi/pinctrl.c
> +++ b/drivers/firmware/scmi/pinctrl.c
> @@ -259,6 +259,8 @@ static int scmi_pinctrl_settings_configure_helper(struct udevice *dev,
>   	in->attr = 0;
>   	in->attr |= FIELD_PREP(GENMASK(9, 2), num_configs);
>   	in->attr |= FIELD_PREP(GENMASK(1, 0), select_type);
> +	if (function_id != SCMI_PINCTRL_FUNCTION_NONE)
> +		in->attr |= BIT(10);

hm shouldn't be macros to use for holding that value instead?

As I see GENMASK above is the same case.

>   	memcpy(in->configs, configs, num_configs * sizeof(u32) * 2);

Another magic here.

M
