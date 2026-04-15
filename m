Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F4BF419A5
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 13:09:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB19883B99;
	Wed, 15 Apr 2026 15:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KmmbJrBF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B239B83936; Wed, 15 Apr 2026 15:09:29 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CA778407E
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 15:09:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOeCWd3trHPRSbZq1+M1IWgdFz/04huhQN2xO8eXF5ZYduZ6TUeykHNlcJdezwnZvMOfyf9iODZahbo5GF7x0tLzA/ylIsmvdoJQSCVB/7nmaeRp8kbaEKL5UobTAIEZs8XeftDr+01QLgSdkuOXvQOOTHwo11jXjyyyEVEcy7UDrKKJrPu8ohl5xpX/2RfzZO4F6LJ9QyhWr2RwSgKKJdAYNeixkNN+gF3LnDBjxnOQEcvXL9r67FKwDamnfoAqDI15IQIMyp5YKA8KHRuAH2lyovd+KVkDb5eldmhGAYmvBBy9Sv7mZUivjd7Pnmbj6wZavvoavSBX/HSC7NP+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qxx8eE9G6H0Kl5TeKYToJtxAz87TF0zZkfEIxJ1Hv0=;
 b=Gp8xP6Z/nophm8U+pbYJtx6dQiN60Q14cSBNInXxVkdlwLk78hxWCGLWf8wRmWxhM09675/MsRke+LEuNeQxeJsvF1Kfs0+q6bjBXtjuPJtHdFbMGwT/xWLSVanbTA4wDVbLfPPfo/UM9EYiEFycIz9AZUORY2/eXBhHcZNRyeEYoyJGWjc301ckqLYlpp4TT0oXVthkFdoy9uNBXBV5K3S+eLJivMqazaHHkJvpVEXkXlr7aal75K3raWipLN++59ZZfbbdEJI0mLPSYcLLGeFX486FJcIJXgl3u512FMLEViGrHUnYFpf9qPzx0hT+lem9osYrOELktSGbppkiaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qxx8eE9G6H0Kl5TeKYToJtxAz87TF0zZkfEIxJ1Hv0=;
 b=KmmbJrBF19GOM1Oi0lFkzFzHO9wrX1VVam+gLbeZEkmZxMMzUeJUtG7tlHLqR4w4ZMyF7dPsxfNCItxy3OG1wtzUR5RbFlfkM1eMaBeEWv2xmpkgwWAnQFh0AO1jlBdU+BqPZlCOZeF+ocZTdYBjkjvgtXNQhBI3UWZWhSff39Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.34; Wed, 15 Apr
 2026 13:09:18 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 13:09:18 +0000
Message-ID: <4a1cba91-3435-43c5-8123-263484106ec5@amd.com>
Date: Wed, 15 Apr 2026 15:09:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: fpga: Fix wrong preprocessor guard for loadb help
 text
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Tom Rini <trini@konsulko.com>
References: <366dfe78e2028f53a6274da75547fb68844764cc.1775549229.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <366dfe78e2028f53a6274da75547fb68844764cc.1775549229.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::43) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SA1PR12MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 090e7bf0-2454-4a1d-8258-08de9af0339c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: +lT7IXdQlk8G206sWDCS7A9KQ88Smg5cip2zEw3zBxM88zGSMWcJ4eykwRLZ5ycouU3N1BvF/xu91C0EHo1FNg0dIAR2J0GRB2G/PuQ+90vOdzg5pe8OzyunJ/Uk6UrxBukcQySEF59UQgSMtOG8rnByW+droLbfF1XHlA/Sbn6x8RsP2X6Jaw1m452d4M2AcyZimELzU+a2aB4uo7blEqsVxxm/C82/zKqVBZ1LjRvwj3bt/Tgh8YVXy+BcLR6/uadO5wvXKLGrq7iqUEBMlyhfKmvzI4BU1OcTS12otoLOIDZYuA3n7eH6xwm3Bu0fJVq4nV0PUi8IA/GUODgtm58KfnxpqxWBoINNC56z7lFdbWvX2ZxUL/9oaEQmtc2xca24S/TJGi1tADtutL2o0SAF5CKIa9IRccAn4wVo58VQ4G+GXf6Sbc9Ca/ZgJ9qWTBI6laAZjAd0flJKcLQbgPkcZttg0HkmJSt5furZoI+zgNRpsWNAJYa6S49bgPLdsFRTok2Eo86Nj769BZMNiuxMRX6//r64osMBmFK41qa6hYCvlMxdyCBR92cb7avyOKYDG00ZQbhcp9ydulf7tKPy88zQFi2AhiANvBuMqM2//SnFtS4FZp2Nq71FnXemIDqZrCa8CI4ilq4MZUsVm8BqObj1mcijGnecykfOoxa9C3ErQxvW3ahsq4XslLZbBbt+ZBMVdf1kEB306fMjljZACUP9IS3pPvzuUDNOD/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZytlYm1yZ2U5UTVFRVBUellIYi9HRlludm56RnoxZW9kKzN0VVk1T0oxdUFB?=
 =?utf-8?B?eEpPQmswMlV1K2JjRFIwcnM2czBIMkgrd0Q5b3d5ck1tdkZsK3B6aXlyajNu?=
 =?utf-8?B?UldOSE9BUGs3SUU5TUgxdVFXQkpGOXU5UnhKM09WSHhTU3BRR0F5VEhTZzB0?=
 =?utf-8?B?RldnMjJpekZZWnlEeGVZSlNFdjlCTWYzN0RPbk5HaGM4ZTIyOHBGVkhNZ1dz?=
 =?utf-8?B?Q0QySWVYSXFRTkloUzZ2ZzBtNGh0eEU4c1lKa2ZjcHlUdFQ0VEJNTkdpS2tK?=
 =?utf-8?B?R3k2cjFIQ0FWeEpiWWpoWW0zWGVHQ0tPSFRyRndxMkNJN0dLK3ZWKzdVRGhI?=
 =?utf-8?B?eFZRRHdNOUhOc3hKb25ON2hiNk44QXBtSUp3TjY1RU9pQ0JubWJXQXpMMVBW?=
 =?utf-8?B?elg2SDRaVUhqWjZIc3dEcjRKUktaMERJSGpFaFVaQW9qUmNCeHB4dnRRTTFM?=
 =?utf-8?B?MC9tOHdSbC83ZDlVSVhjZDhSakI4QW0yRnBxa05ETGFkVlNRVktKRk5Xdk5u?=
 =?utf-8?B?R01JUW9vNFVucVFzRTZnVmQwaG9uMUI0NDEwbDBDOXlLQXlUQlc4U0ZxZEVZ?=
 =?utf-8?B?VU1KNmF0NkV2OStEMk5hU3Yxc1ErRWdrdFJFZTBjNVZFcEFLUk8rVGpXbTVu?=
 =?utf-8?B?eko0TXJXTkVWbHdsZVB6MVBQTDJtZ3ZoS3I5bnZoMlBONVZuM0pRdnhqano4?=
 =?utf-8?B?ZjFGcy8zTDNDVFhsNXV0dENBUTAyRTNVZTliQys0Q1ExWERqd3NFZVJBcVBk?=
 =?utf-8?B?aEJXazZDYmFCcUMreXFacjEvUGRIWXBJdURpK0Yrb2laVVJBM0JLbUNJeHRu?=
 =?utf-8?B?UHZESEFtWFlpZkNMMEJaaEJCWnpUTFNTRFhXa2lBU0VsSE96VjE5TE9ZYlpW?=
 =?utf-8?B?RUt0UDBmN0pUN2tkRkM5RzArNngwQzNmODNmc2RvQXJzSHRGSnRvbUVFUzcx?=
 =?utf-8?B?K2ZHNjcvNGY3V0hqNkxvd01mMDhYcHQ1QXdVT1lJUW9ZSEFxVkRMWitIcTRJ?=
 =?utf-8?B?S1JIS0RYbkxYQXdVVkltb3NYOWhwQzVOY25Fbmg1dFQwVmlvNFpNZzVyMmNi?=
 =?utf-8?B?NFVrcVowYlV0bm05bHZGclhBdmU0Q2tRTCtxUkExc1Q4YS9yN0hieEN1WHk3?=
 =?utf-8?B?NDNBUHNRWUsyTFY1TzVMOGsrWmJnSHhYc09ac2NlL3RPdTZJSitkdXpxbkc0?=
 =?utf-8?B?Tm5CcEhYa2RBcSs2dTV5TE1ic2l4aGcwM2ZIR2FUSUJYU3BpSklJMWxIYVJr?=
 =?utf-8?B?cUhPMGV0R2hNajQ3NTdHWFVRMklBY1F2cFpVRU9UckhmWkwrYnJqbEVzZGpH?=
 =?utf-8?B?cDhVb1AvTG11eGRFQW9EdTE3cEsweEt6U25NMldmc1IwaFpmYi96MFhtQjNj?=
 =?utf-8?B?ZkhOVkEwZVRpY09uY3E1cUxvcTF3Zmh0b0ZScjZVUjZFMndGZnlBMkxHOGNM?=
 =?utf-8?B?aVlsK2JCcGZBVDRtbmJVWTNyMHVtbDFIMFRTOVFRbVhkNVA0T2gyaFhXMTZ0?=
 =?utf-8?B?Z0xDcWlRZkRsR2hFN2hwQkZuVytvV0w2NjlsMmp3V3NCaEVIZVRMWmFHdzFa?=
 =?utf-8?B?WVNzZGZqcTBwcFBFTDRVN1NWeDljWnNMN2dCcTR1ZDdZQ2FmcUZSRytURk55?=
 =?utf-8?B?Q1NzZmFHb0pqVm9wYzNqUDZZTytxMzBnNzI1TG0vMWJlNDA0QWxETEZhM01K?=
 =?utf-8?B?VHdwdjNNWVRLbHZQUEhZOG0xdFlLRDFhb0F3WnRkUTQ0cDU2MDAwRnRHT285?=
 =?utf-8?B?c0ZuQmVTTUVrQXhZbnNRNDRnZzRZWVV0MmFiVDRxUmFHNy9ZZ1NPSnNxUkZ1?=
 =?utf-8?B?ZVdVMnlYOHdHZ2FWaTJUQW9pMUlwa0gzZDEyeHVjaFRJRW94K3lOeXNyZ3dx?=
 =?utf-8?B?QUNhWHBKcmFWTXNEUzRXNkllWllNak43enRhRWlQWlY4VVdTdHZOZUpTaFdj?=
 =?utf-8?B?STV5TXZLUW1ZS3h4dU1UVG9nUU8yMFhzd2M1LzVZczhnYXRyZzNtd2lVWmRu?=
 =?utf-8?B?TDlzZU1RY3BzMXNmTTFXN1FtS05MZ05kYUg2YU1FaUtYZSsyZlh3cTl0OXdN?=
 =?utf-8?B?SXNPQ0tQYSt4dnkxLzg1Nkd6N0h6YWZPa0NjWDVDR0xBaHFrNnhuWjNZN3ps?=
 =?utf-8?B?bHNjdjRjbFdPVG1Tc0lkVTJmL1dDZzVsRXZhUFRPU2VobUhNcjQwemR2dUc1?=
 =?utf-8?B?OUZkcUM0VzRSV2RJL3BhNHNSdG1HeGNoZWdyVElZN0FJbmRGQmdlZG9qT2dW?=
 =?utf-8?B?SzQyRXRMaUxDNks1S0QrU2FuNHkwNFZNRnEzaWp1U0ZoeVhwbVY2L0FoY01u?=
 =?utf-8?B?M0VqNytCZ3pXUEtqL3JYbnRsdnZhR1l0cDJoZHh4TFdxVmR3dzNmdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090e7bf0-2454-4a1d-8258-08de9af0339c
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 13:09:18.2707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXKZjUl4zjjT85wqCnlPOAW2DJX9llDShe7nc4uLJyfY5JocUXpEZTwDUoDI0PZr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270
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



On 4/7/26 10:07, Michal Simek wrote:
> The help text for the "fpga loadb" command was incorrectly guarded by
> CONFIG_CMD_FPGA_LOADP instead of CONFIG_CMD_FPGA_LOADB. This meant the
> loadb help text would only be shown when LOADP was enabled, rather than
> when LOADB was enabled.
> 
> Fix the preprocessor condition to use the correct config option.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   cmd/fpga.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/fpga.c b/cmd/fpga.c
> index d51c380d7b3e..d347a7002906 100644
> --- a/cmd/fpga.c
> +++ b/cmd/fpga.c
> @@ -417,7 +417,7 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
>   	 "info   [dev]                  List known device information\n"
>   	 "fpga dump   <dev> <address> <size> Load device to memory buffer\n"
>   	 "fpga load   <dev> <address> <size> Load device from memory buffer\n"
> -#if defined(CONFIG_CMD_FPGA_LOADP)
> +#if defined(CONFIG_CMD_FPGA_LOADB)
>   	 "fpga loadb  <dev> <address> <size> Load device from bitstream buffer\n"
>   #endif
>   #if defined(CONFIG_CMD_FPGA_LOADP)

Applied.
M
