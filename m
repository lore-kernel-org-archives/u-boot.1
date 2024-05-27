Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44256C25B78
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 07:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AAE18820B;
	Mon, 27 May 2024 09:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wzAxQvHD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D54A8820B; Mon, 27 May 2024 09:35:07 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7EF988229
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 09:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiXdpiwPLK/nzB3YAZblidtXaUJkRqFHSHVT+6E1F6QsR2b32GjsqEe5sXBengxONThfWMDNGKHKo272gDC3ICaS/xuoijGmHWxHvXF0qjMyXeAy45ZLvm/xloh8LQNMziACrHcGAgeUitCn0wIaQzeHyuT9k7hBY7wGHd8/M0crmfyQx/PU7Zsf7eq+AksRsoVAbKrIPItkt21NWEaZMfKSvN494kHcVgzqe+/FT4ERCarU1xJoStDMcU19ekBPDWQ1gK5OEDkLW2Zg5VOCxZTSdWlAC92YEQ5+hlv59R00F2Jq/LYOs7wDy8YaLpAkPEz9ZbpR39YlzK3sU1JySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zb5jZ0ZkGgNz11Oi6TFJ9XITevZeziqd+F2U3LmZen0=;
 b=TWDkyDp9fZ9wXi36fncYd9flhg/Dp+9u9gVJTlvfrFpkozhkxVpXoNKeyfraMHKai/fGT/dCaSsiYwdL22OGMQQYJnVUekNXYB1rZbzwGdjFp0BMooY5h87BU9PBbzYLImEwXuQq363XnxCIrXyinckP85h9LSmAQ6ezJyhHs4Y5yX8ic5tGsfjCr/n5OdbZonYccpu8z2R61hXoFqq4+mKmQh4jmcgUzNmAZ5nQzGujWW+g5bx5NYk/F+/e6tITNN4MiZdJQ3KWvlHxkSY33bALEBCsQzYthSYIUh6DhHwJv5oCWzV7xQdUiK8Z8yJKGauP3wL+Vk0uknNgdMcm8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zb5jZ0ZkGgNz11Oi6TFJ9XITevZeziqd+F2U3LmZen0=;
 b=wzAxQvHDPUNBMVEVD2muXnv4GYczHQuAOapaF4gjxUgWTIxNvGHjlWJLgtAwRkLfeiT28QY5T+htM8Vt8qUcisK+8Z/ijvRCzTbqQlbupyzwtDxNwsXk3vJV3lMfVJFrxpI/F+3B0mUXd1FoCbcQ+Xg767PGL4o4mYVkLnBHkk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Mon, 27 May
 2024 07:35:01 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Mon, 27 May 2024
 07:35:00 +0000
Message-ID: <bf2c5b91-a76b-420b-9653-0cc9ae47a9c4@amd.com>
Date: Mon, 27 May 2024 09:34:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Add option to load environment from outside of
 boot media
To: Vasileios Amoiridis <vassilisamir@gmail.com>, trini@kosnulko.com
Cc: ashok.reddy.soma@amd.com, venkatesh.abbarapu@amd.com, sr@denx.de,
 LPolak@arri.de, vasileios.amoiridis@cern.ch, santoshsagar.algapally@amd.com,
 u-boot@lists.denx.de
References: <20240522174738.73522-1-vassilisamir@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240522174738.73522-1-vassilisamir@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0008.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::20) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f6b1be-1a69-4978-f479-08dc7e1f83e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODF3aVl1REFhSk5hc0JwbjNFYXoraEdJcldyM0R2WVVDbjg0aHRBNEhLMVpw?=
 =?utf-8?B?YWRpejUwaE9jdFJPbUtTRzRQRVFhMWZXVUE3eTMwS3I1eklYY05tU2hhQnZT?=
 =?utf-8?B?eW9YUm1FM0dqcmZYOFNNbVRHRmVQclU5M1NHUVZJZjVzV0ZmUi9ySVF0cmph?=
 =?utf-8?B?US91cGpSTnN5Z292cUY5T2Q3akhqMlA5V25QcTJocThPRk5DL0FxYUhtQ21u?=
 =?utf-8?B?dTIvVkVaNDdkYWk2NzkvWGcwV0hVODhOdndDQWI4OEgrZlBpMXMrNXNab1ph?=
 =?utf-8?B?emFwRVVXSGtQcG9ndjEvbHlsaC9qTnlwODg5WXQ5V2xZZXl4blBtNUNRRmJx?=
 =?utf-8?B?Zld1R3hWV3B5alE0dXk3WEl5dTQwQ3VUbDdEQnVET1lpWlFDZlJaeUNHQW95?=
 =?utf-8?B?eUZJU0J1elI2KzFwdzQ1RUx0RkdFT2lsR25PSldMR0MwV1g5OTBndTdwalJX?=
 =?utf-8?B?Z0hYMDNyalU5MTFhYysxUWV3WFc3U1dHVlRSaEt2SmY0T1RQcHBDYS9wd1M0?=
 =?utf-8?B?UmlBK00rbjlXRm4zODcrSFdPUGNQdHlOdDMxWjBlRWp4YWdTQVl4NVJzYXNU?=
 =?utf-8?B?eU5FZnRwcGZrWW5kaUxVdHhkSHNGR3Izd1gwRjZwWVN5KzJrUng5K0lpK3dJ?=
 =?utf-8?B?bGM4cm94UkNIRVlEbC90VkRWSUExcHlrUHpuKy9EdXYyNXJTb1ZpN2N4OXp3?=
 =?utf-8?B?Y0RsT01Nc1kvcHhwYkhhTHVZeFB0OGpZVS9Gd25WUFF2Y0NyYnc0OUJTcTNC?=
 =?utf-8?B?SnJncXlXMkFyVVo4N1lrcUwzZEhtbm9yWm8vYUtKcWcxN2JvVnAzRXljOU1R?=
 =?utf-8?B?TG5EZDc2S1p0K2gvSG8yTTd6KzFJeFBEU0FDaG43dWJnSjdTWVFXdHVIQ2xE?=
 =?utf-8?B?V3Z1UjJtZlZ5UFF3QTVUNCtKOHM2Y2ZEMzNaWU0rL0NwSnJLYmJDWFNBU2s1?=
 =?utf-8?B?R3ZUcEQwRS9wSnZsVzVsamtHbml4N2FmMnltb0lvZzNvUGRRU0FDT21wMUFv?=
 =?utf-8?B?VERlTmUrcFQyMldWYXI3TmM2TGxuUjB2Qml0VnMwMDFjb3E0YWRiMDBpUWRu?=
 =?utf-8?B?OVA1QzVRakxwbjlMRWc0VnpuVHdqSHNnUDI3ZzF1dG1mZERlbHBTNTFnQlEw?=
 =?utf-8?B?UGJheExNS0pNYTBibXhES0haRGJkQ3JkSnJjSHpTSXE2THZhR1NQMStwNEV6?=
 =?utf-8?B?TXhJblA0UFVlek8xL0lRSG9Gb0NpSm1ra3hCSUpSOXRaUkJHb3ltTk5DejYr?=
 =?utf-8?B?cVdoSXNwSW5DNEtIWVp1ckcyVVV3TllUTEJJb21ybElyOXhTdkRkM2FlaVRw?=
 =?utf-8?B?NStSVnFtUWtWUmh1N0JtTkxPOEVIWnBsb1NlNmh6Y1A2bzY5QnU2c2x6M0xz?=
 =?utf-8?B?Ni9SeDZIQ2JTWmpYcThIUXRJamM5K1JPU3IwWkFkalN2ak11WWZYQjUrMTV0?=
 =?utf-8?B?dVU3c3ZlZ3hPV1F1UzRFTDQzdmJIZW9XOTIwMk8rZDg1bnFtN0xjT0JYRWNw?=
 =?utf-8?B?U1hsb2d2NWdVak1CcFpkSDRadlBtUlYzQUVKeVpBaFNxeFg4S094UW1IMEJZ?=
 =?utf-8?B?VjBlUW9TR1BiZ2w2cmxKVkt5OWtuWUFzQjdQZXJiUnZXaWhjVnV2T2VITkxW?=
 =?utf-8?B?bjVnRENPaGJIUk5zY1JmaXpTOTUyQ2NQZDZEQnhwdnZCS2pSdkZvWFhjWG9a?=
 =?utf-8?B?eDdKSUhjc0FBT29pRDl4N2cyUWRRQ2Z5K0R6U1g5VUJ0YWFWODRmTVd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RytrOTc2eU9nWVNQZ3NMdHFWZHl2SWpYM2N6NlI1Q1BPM2I2NWtobFhHR01N?=
 =?utf-8?B?NGtjZVR1S3NaUXR3WXorQjJHd2R0eGZIdWJKMEhoVGdkZnYwMEd3QTdLb1Mv?=
 =?utf-8?B?OXpKRVlTVW9TSEtUZ3dpaSthQUNka3Rmdm4zc2RUeUxQTHU0VHRyZmF2VFVJ?=
 =?utf-8?B?SlRsSTZyalBtYnpsbDNvOElPam5MUDMxbkNsN0c0UVZheTYreWtCeTR4eXB4?=
 =?utf-8?B?czVxeWJyK1dTbUhLTk9YWjB0bWVZYWN5N3IwbTZnZHJxU3ZrMmVQQ3JDOGJB?=
 =?utf-8?B?UGNZUFV5a2JncTY4VmVGMWdraXhOcGxtUnlOZGcxeUU3WjZLYlBlZ0QrTHpx?=
 =?utf-8?B?SmxHYTRzYmRsaEJ4WWtCb3hkV1psU3c0bjRZVVBIUng4d0dJR1hadjI2K20r?=
 =?utf-8?B?QS9qQk9maXM3TEhpa01jQlpTMmwxb1AwVWF1VG96amFwTTY4QTV1NGJDa0Jt?=
 =?utf-8?B?eDJ1VmNOYi96M3ZMM0dsNytZMXhQUHR4SlZodUpMWXpqZU1RYk5kaENWMGVI?=
 =?utf-8?B?ODB6V0dFb2orSjNPZEdqaHJJWEt2UDk3M1BkbzVKck4vVDFJQmVqWFZoVlRM?=
 =?utf-8?B?ZjhzYStjdWp0U1dHRW1ycEhJd0hSOXZoUUFOQkF3TVJHY0EwMTJrd1dON1dv?=
 =?utf-8?B?YmxDTVJUMEY5WlA5UXVhbGZoNXlDejR2QVdZZEpzbXErcGxvTDliY05XOUFv?=
 =?utf-8?B?QjJQRENrRy95YkFSTU91aVpXYnB4dS9OME5qUVM3bFM3QS9kTk5IQ2VPRXJ2?=
 =?utf-8?B?S2plTytrU01tc3JObWhiSEozTDE0bW9CdTVKOHhiUXhhR256dDgxZlFWcXFl?=
 =?utf-8?B?bTdnTGlBQkp3WllnU2ovaHl6ZWJhUmk4WU1rQ0VUMTZGNmhxc2NTY2IvRnlr?=
 =?utf-8?B?TGVqY1JKV1VhWFFzbm11aDRSQVBRaE50NU1TR2tsaUdNMHlOOGtOc3g1Mk1H?=
 =?utf-8?B?SitXdTdEdCtZVFRCS0NmVXVxTkt6bEJtb0l0VmF4QlpGYjg0TEd0c24rREJi?=
 =?utf-8?B?SnQwdUY2VnVuVUxUU214MVlUQTVEdGJCZXF4em84VkUvOFlhbFY3STRCU3Na?=
 =?utf-8?B?V1Y5T0NZbTZGYUJUWXVQdE11MmhJaXJyTngvRDRIVUowOVJ4NDFUTlNTUUlL?=
 =?utf-8?B?c054L0RjWXZwak9rWlVjSGpwT25CdDdNSTBuNnEzSFk4bVdXMitBYmdoK3cz?=
 =?utf-8?B?b3RDY3RvN0RTVXhKZm5JczQ2QSs1TVViRXNJOHJ6M2JyZ2xJRjRqNkZSZFg0?=
 =?utf-8?B?VmdScWJYZUJGVkhLL0Rmb2YyakwzT2VZUnZhS0JGb1BVMGh1N0tRaUF1MWJw?=
 =?utf-8?B?aVBiQjVZTGRDWEtsNzdpRkQ4dm1jcHRTZDV2cDZpaGZFSm1ZcXY1b3dnTmJo?=
 =?utf-8?B?bFFpVGhUZ0pEY1c3VmpLRHZmRW03WkRzUjZQSm1ENFFiZEF5SXR4b21uT1Uw?=
 =?utf-8?B?L3JHRmJSMUZJT3FEemVGYUU3OXk4MGN0SzdCTXdCNG5leVFVWGJiQ1dJL1Fp?=
 =?utf-8?B?bGhyN1UzWkJkMk5HTTAycWNncW9BcUVPbzBtYnZnblNYT3d6WnVBdTVqOFFN?=
 =?utf-8?B?clNSMHBER1k3ZnhIdXgwMTNXMVh1anBDTXZiOGhPTzY4VEZuSXIwY1JWd1dw?=
 =?utf-8?B?cnV6T1hPb3o2bDk5eng1SWpWRHVSYk1GdUQ5SlhYK0trY2JSRGg1S0VQUU1r?=
 =?utf-8?B?ZFpvenBFTGc3L2p6cUxFYXh1eUZLYXU0ZVgxelFCUEh1eXNuRWpiOGQ4ZVpT?=
 =?utf-8?B?TEFJNVBUVXJFMXZtVE9oTHZjQ0E0WTc0VitJdk9EU24zcmU0OGRvNjZtK2w1?=
 =?utf-8?B?TjhJdFZZb1VoSHVmSEdHN3YrWnFXeEZrdytnNkxTcHBpWmhSSVdjKzVkVTFG?=
 =?utf-8?B?dDN5YWs3TElCL05qUFl3ZFY1dnN1a0R4dkdwTG1RU1BLdHRFMVA5K3pVQmE2?=
 =?utf-8?B?dmoyK09WZXh3Sk5hNk1rcFprR2l2VjljRlVEQ0VpVjJHejFWOEhKQ3hOUUVI?=
 =?utf-8?B?VFlLUDJ4M014M0ZpSXVBa25MSXhYVTRTQ21FaUFmd3RrVXh0TjloWGthT21V?=
 =?utf-8?B?bnNJTUIxZWdFUUZuVkV2Z0FwN1I0S0F5V3ozVE14RzVBWEZGSHU4c2RKQXRp?=
 =?utf-8?Q?1YJbN6ZO55i5Slvul3kFangvP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f6b1be-1a69-4978-f479-08dc7e1f83e6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 07:35:00.5379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0DZ3IAuci+7U1NFykZLCigztocVkKMTyv72LWWplsBZPvS9kIFzFNSYR+EW4DnM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277
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



On 5/22/24 19:47, Vasileios Amoiridis wrote:
> From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> 
> Currently, if the environment is not in the current boot media, the
> env_get_location() is returning ENVL_UNKNOWN or ENVL_NOWHERE which
> is not true (i.e booting from FLASH with environment in eMMC). This
> commit adds an extra check to find the environment in the other
> supported boot media, keeping the same priority as of now.
> 
> Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> ---
>   board/xilinx/versal-net/board.c | 21 +++++++++++++++++++--
>   board/xilinx/versal/board.c     | 23 ++++++++++++++++++++---
>   board/xilinx/zynq/board.c       | 31 +++++++++++++++++++++++++++----
>   board/xilinx/zynqmp/zynqmp.c    | 31 +++++++++++++++++++++++++++----
>   4 files changed, 93 insertions(+), 13 deletions(-)
> 
> diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
> index da03024e16..5648d6685e 100644
> --- a/board/xilinx/versal-net/board.c
> +++ b/board/xilinx/versal-net/board.c
> @@ -372,6 +372,21 @@ void reset_cpu(void)
>   {
>   }
>   
> +static enum env_location env_locations[] = {
> +#ifdef CONFIG_ENV_IS_IN_FAT
> +	ENVL_FAT,
> +#endif
> +#ifdef CONFIG_ENV_IS_IN_EXT4
> +	ENVL_EXT4,
> +#endif
> +#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
> +	ENVL_SPI_FLASH,
> +#endif
> +#ifdef CONFIG_ENV_IS_NOWHERE
> +	ENVL_NOWHERE,
> +#endif
> +};
> +
>   #if defined(CONFIG_ENV_IS_NOWHERE)
>   enum env_location env_get_location(enum env_operation op, int prio)
>   {
> @@ -389,17 +404,19 @@ enum env_location env_get_location(enum env_operation op, int prio)
>   			return ENVL_FAT;
>   		if (IS_ENABLED(CONFIG_ENV_IS_IN_EXT4))
>   			return ENVL_EXT4;
> -		return ENVL_NOWHERE;
> +		break;
>   	case OSPI_MODE:
>   	case QSPI_MODE_24BIT:
>   	case QSPI_MODE_32BIT:
>   		if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
>   			return ENVL_SPI_FLASH;
> -		return ENVL_NOWHERE;
> +		break;
>   	case JTAG_MODE:
>   	case SELECTMAP_MODE:
>   	default:
>   		return ENVL_NOWHERE;
>   	}
> +
> +	return env_locations[prio];
>   }
>   #endif
> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> index 4f6d56119d..8aed2e97df 100644
> --- a/board/xilinx/versal/board.c
> +++ b/board/xilinx/versal/board.c
> @@ -291,12 +291,27 @@ void reset_cpu(void)
>   {
>   }
>   
> +static enum env_location env_locations[] = {
> +#ifdef CONFIG_ENV_IS_IN_FAT
> +	ENVL_FAT,
> +#endif
> +#ifdef CONFIG_ENV_IS_IN_EXT4
> +	ENVL_EXT4,
> +#endif
> +#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
> +	ENVL_SPI_FLASH,
> +#endif
> +#ifdef CONFIG_ENV_IS_NOWHERE
> +	ENVL_NOWHERE,
> +#endif
> +};
> +
>   #if defined(CONFIG_ENV_IS_NOWHERE)
>   enum env_location env_get_location(enum env_operation op, int prio)
>   {
>   	u32 bootmode = versal_get_bootmode();
>   
> -	if (prio)
> +	if (prio >= ARRAY_SIZE(env_locations))
>   		return ENVL_UNKNOWN;
>   
>   	switch (bootmode) {
> @@ -308,17 +323,19 @@ enum env_location env_get_location(enum env_operation op, int prio)
>   			return ENVL_FAT;
>   		if (IS_ENABLED(CONFIG_ENV_IS_IN_EXT4))
>   			return ENVL_EXT4;
> -		return ENVL_NOWHERE;
> +		break;
>   	case OSPI_MODE:
>   	case QSPI_MODE_24BIT:
>   	case QSPI_MODE_32BIT:
>   		if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
>   			return ENVL_SPI_FLASH;
> -		return ENVL_NOWHERE;
> +		break;
>   	case JTAG_MODE:
>   	case SELECTMAP_MODE:
>   	default:
>   		return ENVL_NOWHERE;
>   	}
> +
> +	return env_locations[prio];
>   }
>   #endif
> diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
> index 6c36591001..6fa5016cdd 100644
> --- a/board/xilinx/zynq/board.c
> +++ b/board/xilinx/zynq/board.c
> @@ -134,11 +134,32 @@ int dram_init(void)
>   }
>   #endif
>   
> +static enum env_location env_locations[] = {
> +#ifdef CONFIG_ENV_IS_IN_FAT
> +	ENVL_FAT,
> +#endif
> +#ifdef CONFIG_ENV_IS_IN_EXT4
> +	ENVL_EXT4,
> +#endif
> +#ifdef CONFIG_ENV_IS_IN_NAND
> +	ENVL_NAND,
> +#endif
> +#ifdef CONFIG_ENV_IS_IN_UBI
> +	ENVL_UBI,
> +#endif
> +#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
> +	ENVL_SPI_FLASH,
> +#endif
> +#ifdef CONFIG_ENV_IS_NOWHERE
> +	ENVL_NOWHERE,
> +#endif
> +};
> +
>   enum env_location env_get_location(enum env_operation op, int prio)
>   {
>   	u32 bootmode = zynq_slcr_get_boot_mode() & ZYNQ_BM_MASK;
>   
> -	if (prio)
> +	if (prio >= ARRAY_SIZE(env_locations))
>   		return ENVL_UNKNOWN;
>   
>   	switch (bootmode) {
> @@ -147,22 +168,24 @@ enum env_location env_get_location(enum env_operation op, int prio)
>   			return ENVL_FAT;
>   		if (IS_ENABLED(CONFIG_ENV_IS_IN_EXT4))
>   			return ENVL_EXT4;
> -		return ENVL_NOWHERE;
> +		break;
>   	case ZYNQ_BM_NAND:
>   		if (IS_ENABLED(CONFIG_ENV_IS_IN_NAND))
>   			return ENVL_NAND;
>   		if (IS_ENABLED(CONFIG_ENV_IS_IN_UBI))
>   			return ENVL_UBI;
> -		return ENVL_NOWHERE;
> +		break;
>   	case ZYNQ_BM_NOR:
>   	case ZYNQ_BM_QSPI:
>   		if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
>   			return ENVL_SPI_FLASH;
> -		return ENVL_NOWHERE;
> +		break;
>   	case ZYNQ_BM_JTAG:
>   	default:
>   		return ENVL_NOWHERE;
>   	}
> +
> +	return env_locations[prio];
>   }
>   
>   #if defined(CONFIG_SET_DFU_ALT_INFO)
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index f370fb7347..7e646d342b 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -588,12 +588,33 @@ int mmc_get_env_dev(void)
>   	return bootseq;
>   }
>   
> +static enum env_location env_locations[] = {
> +#ifdef CONFIG_ENV_IS_IN_FAT
> +	ENVL_FAT,
> +#endif
> +#ifdef CONFIG_ENV_IS_IN_EXT4
> +	ENVL_EXT4,
> +#endif
> +#ifdef CONFIG_ENV_IS_IN_NAND
> +	ENVL_NAND,
> +#endif
> +#ifdef CONFIG_ENV_IS_IN_UBI
> +	ENVL_UBI,
> +#endif
> +#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
> +	ENVL_SPI_FLASH,
> +#endif
> +#ifdef CONFIG_ENV_IS_NOWHERE
> +	ENVL_NOWHERE,
> +#endif
> +};
> +
>   #if defined(CONFIG_ENV_IS_NOWHERE)
>   enum env_location env_get_location(enum env_operation op, int prio)
>   {
>   	u32 bootmode = zynqmp_get_bootmode();
>   
> -	if (prio)
> +	if (prio >= ARRAY_SIZE(env_locations))
>   		return ENVL_UNKNOWN;
>   

if (!prio) {
	switch ...
}

please look below.
(NOTE: Above you are not fixing all handling around prio > 0)


>   	switch (bootmode) {
> @@ -605,22 +626,24 @@ enum env_location env_get_location(enum env_operation op, int prio)
>   			return ENVL_FAT;
>   		if (IS_ENABLED(CONFIG_ENV_IS_IN_EXT4))
>   			return ENVL_EXT4;
> -		return ENVL_NOWHERE;
> +		break;
>   	case NAND_MODE:
>   		if (IS_ENABLED(CONFIG_ENV_IS_IN_NAND))
>   			return ENVL_NAND;
>   		if (IS_ENABLED(CONFIG_ENV_IS_IN_UBI))
>   			return ENVL_UBI;
> -		return ENVL_NOWHERE;
> +		break;
>   	case QSPI_MODE_24BIT:
>   	case QSPI_MODE_32BIT:
>   		if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
>   			return ENVL_SPI_FLASH;
> -		return ENVL_NOWHERE;
> +		break;
>   	case JTAG_MODE:
>   	default:
>   		return ENVL_NOWHERE;
>   	}
> +
> +	return env_locations[prio];

And here call

return arch_env_get_location(op, prio);

This can avoid duplication of these env_locations[] across all our SOCs.
And pretty much fallback to standard implementation which is IMHO good solution.

What do you think?

Thanks,
Michal
