Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDD9C3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 14:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 606C988908;
	Mon,  5 Aug 2024 16:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="olXh3oju";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAB0188908; Mon,  5 Aug 2024 16:13:50 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7CBF888E0
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 16:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lARj3Rmf5TDrXDyz44sNo/wZqx1BShwPMg+HncJjPvUUo+xMOXWb1my5PjGN/3uzWnJ/JCKZeFwG100yRY/xv80Tpk4tmz/gXsjBYNY9QYG1d5t2MldDI0DIPP39Nsjp6RwDpx8FD+Z1uqayjw2VfGbHJbwjLvccS2m9DJbriV5XYSHoFYdnUWc+OBO/jeTplemChwusWWi+GCUVhxtJq4MXGQCgRU+K9bO5TjuKrKAQnEQ9LnKHfr8zhe52znjE3GKUzw23vPhePc/ajgQIGIINWBFnwGDZf826kLuCFtimeOLe+QeItqzLEbiQYMevq8/I/fZrPfcz1MkibHBnvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVJViujBNbfXYcv4XKvuVBezeaL6aRS8VJckBhLabTw=;
 b=lpOqgYn8OvE8otM6E0Ch0HVGmUcErGHAmUivIxvt7dlnibTuuATAVemjELy+5jY5Z6GT3Ux8qKZ5NM1VMCN+CSJsBPZd3Riq79fRciphHJBicuihQSQ3VNprQu3dhRXrlf+1R5li6EUV5mepUlfzXf9BE2G3HqcINF4DH9XvpzGjgRXpF8d2CIyDwVgRmESeotR4PUsToheA8Xr1yaCTCa5pC/hmttgcpnhFIkc6ic8CIpGm0uapCbs+KzbZNQOu9sA/NRpMIbfD9iYd7f8RIuuYKbh53vSJdC9Ckp83sPRKrc4Ks4X2gvUVyUpzztG0ZlKCR4DxBhOmkpX3mEf0aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVJViujBNbfXYcv4XKvuVBezeaL6aRS8VJckBhLabTw=;
 b=olXh3ojuTnHJ7VdsaAtEhYHqE1TK96Yi4b2gKry6SaNsrPvnocxjbWepsyK79dW3fvy0jxq6Yoqvy/0VXE+JZ/SNcIF21PfzrsEWw2aI1Dx3zvVFxfNll+DY92mp1Dwy/qeLanASuzhCYCTFVl5xu636iSJV2z7GuoD/s0XBYes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Mon, 5 Aug
 2024 14:13:45 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7828.021; Mon, 5 Aug 2024
 14:13:45 +0000
Message-ID: <44222d04-4464-4909-80ce-426da5c663d9@amd.com>
Date: Mon, 5 Aug 2024 16:13:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: zynq: Add support for 7z010_lr and 7z020_lr
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>
References: <14d8905a89d1b31fbb2318512cf57eb0256c11be.1722347416.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <14d8905a89d1b31fbb2318512cf57eb0256c11be.1722347416.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0035.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::24) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 4614236c-0a26-437c-8512-08dcb558d144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1ZYdEIzR2pUQlZIS21ieWhadGl0dGRoL3NFVHRpdmZaMzhFNjlpOU81ZlY3?=
 =?utf-8?B?VnJBU1l0TzdXRmF4Wm00U3Z0dXE1Rk1aeHpyZ1o2RHM0ZzlEbzhPS0Q5TTZm?=
 =?utf-8?B?ZjdkTU1oM1l5U3gyaUxaNjlJSkNseGVCVlB3ZGJCVXZ0NzJNa2VoVHVWcUNT?=
 =?utf-8?B?Q2tkZDJxS3gyNFJoVXNxTHkvUDhoQVJGTlJqVlVyZUhSNGROcEsxWWl3N1l5?=
 =?utf-8?B?U3EySkJRSXkxTFZUcXdUQVN0dzBqMDFva3NEa0dOS0J3ZWRFVkZUMTVoREFY?=
 =?utf-8?B?THVBRnp2Y1VxSE0wMlNmTVQ4czZyenUxUnQ0SWpZYkJPcXU4aXR4SmtkOE9l?=
 =?utf-8?B?U0lkV1FXYkg1dGwvMVRyK3RBSE9kTVI0TVh0ZVVJQ3JWb04xZGo2Q2RSVnV1?=
 =?utf-8?B?bVNHZTNtNk1vTnp1Tnh4NVY4b3JPQk52SFFjT2tocXhBNlRhUmNtMW9NWEpY?=
 =?utf-8?B?WWJMNm1EdnZDa21FZmVLaDdHNFM5TE1ZcXBvcTBqc2FFcis2b0VDRXpSNFF6?=
 =?utf-8?B?elRBZTZBeTFBTE5wSDRqaDJ6Ni9qWnN1eHNhbXlYUlFLeXl3cEFlOHZFRzNY?=
 =?utf-8?B?LzhMWFIybVJDdnREL0FjQzNCYmQwcUV5eDZ6dEFxU20wQ1Jkd3JneFpoVmRz?=
 =?utf-8?B?ODlCSTdwY1FxdjRYbGdoWnhBSmhSUzFTalZpd3NRMkdCU0MrSktZT2d0UTBT?=
 =?utf-8?B?MzkyY2tqdDFxY2Q3RXA4L1pZU2JqaVZTVFlaVmhNVHl5bTVFOWVhSEVrTW1p?=
 =?utf-8?B?OTlJdlBqUVZ3cVBXVkV5ZlhVUmdranIySzUwSVFtOFNoYnMyRE9ERnVtdWpW?=
 =?utf-8?B?UktyMjIwZU93RVJzV2VoNERZZmZsQnFJdjVhR25wRmhkWTBFQVJPY2h3ZUhZ?=
 =?utf-8?B?OUhDc3RrZXl0Y2RSQWc5d0h0QjdBYlhqRnZlcGNwanI1M1ZCaHlCcW1ZOUxv?=
 =?utf-8?B?UnROc0FyaU5xaENvaVcxRStnU2ZFZkdkRGZNYWJieTdoR0ZHdkdlSGZaN3dT?=
 =?utf-8?B?NHVWMktUY2pmRGVPRE9HZk9Sb0J0LzdEWDhlRnRacllyb3RQVVBTdHBTaGJn?=
 =?utf-8?B?bFNZbm55Z3VBSFFLdlRjbjNuL1J0dnQ1THZRSi9Oek5jNXJJd2RzNlZxU1Mr?=
 =?utf-8?B?clR4ZERuZlFVWHMwbnI4eFR0TXk0dmRIalkwM2trY0hXalJ4bXhlYkpFNm1Y?=
 =?utf-8?B?a1hBQ0EwZ2laQlFFbktHL2VTcHRhS1NkRk1Dc1B3MmRycXdGK1p0Y0lmck1D?=
 =?utf-8?B?TUg0ZjY2UjZ2TTRrNFZjcmRWQ1BhdFV0b01XdnN3TmpMcmJPSEJXTW9TcmdF?=
 =?utf-8?B?V2FRNjFmbUFLT0Jsc20rRmpsN2NUWXFnN0tmNlpmKzJQM3RaZDhxUXlsVThB?=
 =?utf-8?B?QU92TUFLRTVXYmVxaFZlT3k2bi9tLzFYaDdpYkR4Rms4YVVCV2Vvb2FSL0Nw?=
 =?utf-8?B?dmJlN2ttZHhDZHhDZGxaUmVoUFNnS2owSDNuVDZGMUlRZVJMUEdVcnVjc2xh?=
 =?utf-8?B?UnIzVmYvb05Bbm1FdG1mb3N4U2ZJNjYxaEFMelFSdlJsWkR2RTdrQlNycm04?=
 =?utf-8?B?d2tFd3BwWnFKMGp6YlJubU9qZE9oTk9LRFByM04yeTd0U09obFdhZlowZkhG?=
 =?utf-8?B?cWJzUXRDbUZWR0swRE5kdmZmYXhrbzBEY3BGMWJUMVo3NzZFd1hvb2Jad1FP?=
 =?utf-8?B?ZnlXRHIwOGRFSDNQd2h2cjJiVnhuY0RVOG9DcGdZNHlyT3dRODdZdUlWUzdk?=
 =?utf-8?B?c1Q4bU16Q3JrbytxeGJyQ0JBTDZTaGYvczBuU3kvYkxnMGVaWFhMTDhtQzF3?=
 =?utf-8?B?OFMvRzhUM29jK2FhVHRJQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlBZdkJKSUVkN3k3ZkptMk1VdlZ0azNQOE1aWWluVEM1MHNsL0w1Z2MxVDFB?=
 =?utf-8?B?U2Jlc1IrYVZWS3JGMGZMVkxMZk9DZFRzMVdTZnJtUXZGNmFKenpkWkFnZ2pS?=
 =?utf-8?B?QUdWb1lxQ3k2SDBQYkU5V25uZ0kvSCsxTnJUdWdLb1o3b2ptU1RPc1pFN01p?=
 =?utf-8?B?S1BRakRXdHZTQ0xEbXQ3Z1ozYjBsKzFkR3NzNmFQZWFLN0diV2I3NGFYUTBJ?=
 =?utf-8?B?TkNyV3Jnazk0VHhxSDhhNUNYaGZENkZnb1g5SnB5dkgxS2dweWVQQjJYMk9H?=
 =?utf-8?B?NmZWNklkeTVtNGZic1Jrdy9mRlppd2E2ODJra3lXbktmMk4veS9haDgyNUxz?=
 =?utf-8?B?Vi9ldTVTU21BS25WKzhxRVhTTUd6YWNVa2JwVThXOHVucW5QSkNnZVpaM3RW?=
 =?utf-8?B?MENnZCtaTVhYTm1ETVk3V3B4OE5kM1FTbS9CSFFYVGl1MkpLMTdQaDNIUENx?=
 =?utf-8?B?Wm0rSE45Y0FDVzhWdEFMK1Rab3o0SUVOMVY4VFZ5NkZ5dXkvK25MbDF2eldp?=
 =?utf-8?B?NzRONEZ1QmxOU212VlRkM01MeVpGeklIMSt5M21GWkRBUWczUW1ET29OR3Nx?=
 =?utf-8?B?c00rM1FiNGpzYmVkSk04eWlMTEV2a051akNBR1EwUXdEM25CWTl4SHpYcGZJ?=
 =?utf-8?B?L3BpNFgwb3QrdXhCNHVDM1N5VUYzMERsQjU4NmpXNTNVM1lLYkdDNDQxNG1J?=
 =?utf-8?B?UTcxRHpWVWQ1cHg3RTZVR2l5YUVXN0pUU0MvMDRzdm5OVkhqMFdzWTcrYnAz?=
 =?utf-8?B?dUticG9mZzRLUjdYWTB0VjVvWHdBMDEzbVloVzZuMUM0bXZXZnlJeEFubDB4?=
 =?utf-8?B?a1ZTY2VLbnpiS0cwWmhhSzJFR0xGb1ljOG5ETEVIa0dZVjFhdDdFYjBRdTVp?=
 =?utf-8?B?RGcyN1dzd095MGFyN2tRbjYwUnp1dGxNY20yb2RveDlFQXRmZUVEck9EWkQ5?=
 =?utf-8?B?MUZKVFlvM0FpNGRpbFN0R1QrOFJHODFIUFptV2lwK244T3duazQwRjZEQUw5?=
 =?utf-8?B?dTU3TVE5T3lRRzhkU204K3VvZ3FDNlZkbE44SFVOb1RCTGZKZGNLSS82bVFQ?=
 =?utf-8?B?V25aQTF3MFlYVzdGNGZXWUpBZkpueVh2SnRSelhzWGtIU3Bic2VZOTZZMG54?=
 =?utf-8?B?ZmZjcGF0WWxFVGQyL3UyQzg0TzRpQ1lRazI4NFVMN1A2L3Y0cXBKNTI1eGZR?=
 =?utf-8?B?SXBsTjI0YllmZjA2QUJYb1R3ODBPT3lvRC9iSDFXak9jZkRrRitTMXdJN1Vp?=
 =?utf-8?B?MWZoeVpzbDdmRlMrd1lLTSs3N0sxUUNWM2M4Rzl2TjdGRVV4c2RhemhIKzh2?=
 =?utf-8?B?U1VNNDlVbXJmcGY3TDVJRU5Ha1kwQjNzSHN3cmZZTE01TUZhZk83VmZiUzdy?=
 =?utf-8?B?Q3ZnRmxCTkJuT3F5ZThpZW5DTEZjTXRFMU1FUzlqeG5EMWR2amVHbUN0bTRE?=
 =?utf-8?B?SzEyKzZ4OE5WYzlNU3YvWE1uTEMyUFpZalRPYmpQZEtZM0gxQVkrWlFKdXVL?=
 =?utf-8?B?cWNTT2ozNWZpMHVBMnhwbzlmeHM4WXp1U2poaFRVbGF4QXJEY2lyQW9ORzhm?=
 =?utf-8?B?SVYwVUVLL2tGM0tteWptTzBGcEhmanZVR2xseVVLMGF6WTZrMlJlU1ZLQWlO?=
 =?utf-8?B?dmhVcTN3WVJBQ2ZWcVRMLzF5NkVJWnltenM3TGxYNFRIdmhCakp6RnZUM2xM?=
 =?utf-8?B?OGYyRlpXblFFWEVYQlV6ZmkrVnY4NlJnSURDQm5FRlEyeDk4SCtLcW1oYW85?=
 =?utf-8?B?cUswWjNYbHVhM3k3NllPczNMdUprTytkY3htelFmZHA3cUFkYlkvYy9oSkll?=
 =?utf-8?B?bEl3bGNvdVlJMGRFMXNzaEZ4cUtnUy9ydEROMWE2RHQyb09xS21PaXhwYWhZ?=
 =?utf-8?B?Q1FuT3FVK2dvbWVpd0NseW45YzZqTFFyVXlSY211OUFEV2VjRklpeFJMcHBX?=
 =?utf-8?B?d1FmM1U0SUUzd0tKK2hoNWlnQW1KREJHT1ZyUVR0ZWI4U0g3NVAzM1dLUGFD?=
 =?utf-8?B?UzhzTk9DakFwTFhFTUxGN0dld2ppVHZMdUs1Q1dDS0trS2ozUHJWZllSYkYv?=
 =?utf-8?B?Si9tVUM2MWtqV2N6MEg4ZnBLbEJKWjRhZzJSU3RJMXVJTzJWR1dYTjZ2YWxE?=
 =?utf-8?Q?eLyOMCogb7gHYq0n0apuJ8f5K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4614236c-0a26-437c-8512-08dcb558d144
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 14:13:45.3032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0YqipIkDhEO9ZGOCg1XnDP6dAto9GM/VbiPlBCLA8PTIdHbBJJfcQKDTeEhugF7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768
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



On 7/30/24 15:50, Michal Simek wrote:
> Add support for *_lr SOCs. Without this change chips are not going to be
> properly identified and bitstream programming won't work.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/mach-zynq/cpu.c | 2 ++
>   include/zynqpl.h         | 6 ++++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm/mach-zynq/cpu.c b/arch/arm/mach-zynq/cpu.c
> index c75e453d5730..5b6d765099d4 100644
> --- a/arch/arm/mach-zynq/cpu.c
> +++ b/arch/arm/mach-zynq/cpu.c
> @@ -36,9 +36,11 @@ static const struct {
>   } zynq_fpga_descs[] = {
>   	ZYNQ_DESC(7Z007S),
>   	ZYNQ_DESC(7Z010),
> +	ZYNQ_DESC(7Z010_LR),
>   	ZYNQ_DESC(7Z012S),
>   	ZYNQ_DESC(7Z014S),
>   	ZYNQ_DESC(7Z015),
> +	ZYNQ_DESC(7Z020_LR),
>   	ZYNQ_DESC(7Z020),
>   	ZYNQ_DESC(7Z030),
>   	ZYNQ_DESC(7Z035),
> diff --git a/include/zynqpl.h b/include/zynqpl.h
> index d7dc064585ea..08d067d87572 100644
> --- a/include/zynqpl.h
> +++ b/include/zynqpl.h
> @@ -20,9 +20,11 @@ extern struct xilinx_fpga_op zynq_op;
>   
>   #define XILINX_ZYNQ_XC7Z007S	0x3
>   #define XILINX_ZYNQ_XC7Z010	0x2
> +#define XILINX_ZYNQ_XC7Z010_LR	0x4
>   #define XILINX_ZYNQ_XC7Z012S	0x1c
>   #define XILINX_ZYNQ_XC7Z014S	0x8
>   #define XILINX_ZYNQ_XC7Z015	0x1b
> +#define XILINX_ZYNQ_XC7Z020_LR	0x9
>   #define XILINX_ZYNQ_XC7Z020	0x7
>   #define XILINX_ZYNQ_XC7Z030	0xc
>   #define XILINX_ZYNQ_XC7Z035	0x12
> @@ -32,9 +34,11 @@ extern struct xilinx_fpga_op zynq_op;
>   /* Device Image Sizes */
>   #define XILINX_XC7Z007S_SIZE	16669920/8
>   #define XILINX_XC7Z010_SIZE	16669920/8
> +#define XILINX_XC7Z010_LR_SIZE	16669920/8
>   #define XILINX_XC7Z012S_SIZE	28085344/8
>   #define XILINX_XC7Z014S_SIZE	32364512/8
>   #define XILINX_XC7Z015_SIZE	28085344/8
> +#define XILINX_XC7Z020_LR_SIZE	32364512/8
>   #define XILINX_XC7Z020_SIZE	32364512/8
>   #define XILINX_XC7Z030_SIZE	47839328/8
>   #define XILINX_XC7Z035_SIZE	106571232/8
> @@ -44,9 +48,11 @@ extern struct xilinx_fpga_op zynq_op;
>   /* Device Names */
>   #define XILINX_XC7Z007S_NAME	"7z007s"
>   #define XILINX_XC7Z010_NAME	"7z010"
> +#define XILINX_XC7Z010_LR_NAME	"xc7z010_lr"
>   #define XILINX_XC7Z012S_NAME	"7z012s"
>   #define XILINX_XC7Z014S_NAME	"7z014s"
>   #define XILINX_XC7Z015_NAME	"7z015"
> +#define XILINX_XC7Z020_LR_NAME	"xa7z020_lr"
>   #define XILINX_XC7Z020_NAME	"7z020"
>   #define XILINX_XC7Z030_NAME	"7z030"
>   #define XILINX_XC7Z035_NAME	"7z035"

Applied.
M
