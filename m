Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC383C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 15:11:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1631B87F72;
	Tue, 12 Mar 2024 16:11:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uwAcyerO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54EEB87F50; Tue, 12 Mar 2024 16:11:25 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5160087F16
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 16:11:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2kgwEZtl1F+164ir4K9jmz5BwShVVxDTHE/Ve5XcWNtQMwTA+hzIrauZ04gY4j/bZ45UVMW56weonuWHcmLA2io2QtB+Nk2ED8Lw7/eQTggHq3OxKYPexul8WHuLW0aS/u0MjSAuUjSjfBm/kST9+cmM+jW0xllJtrF2BtmX7sjbbUiTYeKq7WWrINzKkTiE5GKGP0c1gL4bbfU8FIvWoImfgCcTs+cFtewI214sgtUoaUON49+WmGlbZgn1QCQl8rsSiiY2rzGCUd4LEcVXL2vOJwYzwZ3dWQCSfpbcalWpIbHJCpuuaqmHrDg+RRZHXI7QtxYQWPh6SoI/IqMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6yA/UTM0mhooWeqh0Q7PdutrCZJCZT9/W/96qZCRzo=;
 b=C6Z60I6Jf7lKboJfEtTAOU8qMv1vsCsrHV4943jQy7Qz2QPyuihIo7rwRzcRU7UNf6lZfnPM9bkmeb+iLMdt4tAvKcVnAw0VROd/EvoreK8uo7GSEGO/aA7FVxyaF83QGIo+TJCT61KgCKxD50gsL3GwGlwOIM7ERv8F4kle/gA8xqATzVI1t4n4WJnbD8oFqMF6WTntVp+VqC6O4H99nNhLX7rkRVNpwFPkmFU5hlBSAcOPkAG11FuWfkgJ//74uF4R0xo70raq16mUbYtSWqGBWHxb8fbOX84rKq/G7Fxf4PFCzHVfQy2Iy9PxHhaGA+rVA2h9P8VJ0TKjAmApWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6yA/UTM0mhooWeqh0Q7PdutrCZJCZT9/W/96qZCRzo=;
 b=uwAcyerO5dlWGpaemPlIHJnZNcrgG3m12XidDxR2rcHgmE9mSDscdQWLlk3J8HWuj220YXdCARNBAJu2LYnbf9VH2YA3L5T+0nY3IUpawnUBg2uycY75noupuweFhueD53xCRIUQYCPa8Cp4wMkE5tBumSF3BWZSRaq2sgNidI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 15:11:20 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 15:11:19 +0000
Message-ID: <c2bbf2c9-7f05-4a07-b795-922cfdefefec@amd.com>
Date: Tue, 12 Mar 2024 16:11:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: zynqmp: Add label to pmu fwnode
Content-Language: en-US
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>
References: <20240307152956.431104-1-lukas.funke-oss@weidmueller.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240307152956.431104-1-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0046.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f246a06-ba7c-4c1a-f84a-08dc42a6abcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cvdejGQYjU11r89Qhh5Fb2ELF59QRUgiSTl1Teyq6p+PQW96B2ykdU0YvhcnMjr0DqW2W+LbcmtM1WCsMGIQnbycWeWH1Q9I8KHjy0HU03dlQysGSM+PGHGhLULj6ItHNWnC7tudvGds7FUxYeL4NIcL53rdICLe8NmuUuP84R1BGQJmGa8tx0TjJhE1GbOJg5vgNxWDdaPt6Hw8T9/NmlaMH605zkdt1LqSle7aw76jGkFcmfy4McOiVweL6TLKpH2m3IZ4HTrg13HrxWFD9mOvrIZiz5mPVP/gKGmdxLnIHzfJRIBEjibgGRO18p7AUIS9KrfDLSvnWoXDsQPc1eWtIGlPXWP21dzkFOAJmHuqZ0gjoJZV6R2XPburaowARP9zfMd9YSN8uIbYbN1iesFssjX77YE6AcqdAetD+WVCXrIMOzjfyei0xy7aTUhQjGSXcJ73xqs8lKpyTsORBwZgFFU1//2zVwszs5MmzsT8NlUbGdlYhcqzf3TSVsSAZktqzjZ4yW1pKaRxuUKoSot+PNRIlVuT+nS4hAIRcRssvTYghHTuuKGHjPWEbZhoFBKHRtxCU5Zk9VYMoLusZ9/Q7qb9n5uvaSNTGR74sVF/KK5yMcAiluxrpplfuwetlSCfvlDpDq1sCvc5ZYlAcyFiIkwkanBaZ0kFTplYdHA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmdPZFlTUGxuWTNOQUZnUjA4ZTl1L0ZHM3M1dmNaaHZlUGtxRUhmUk12MnBU?=
 =?utf-8?B?QUpLNVBvVFhDRm1KQWgvVlBadXVkdCsyQW5CV0V3Z1ZQdXJIcXBlWnlmSG1F?=
 =?utf-8?B?RmVnMlBQN0lmT1ZuRWtraVQrWHFwb2x4b0Y4NkdTNGQ0UVg4SWlaYmpRL3cz?=
 =?utf-8?B?dEtTZVg0a0VwS25rdHV1eWhWNkQ4THpsVDRRL2JVcnh1TjFIczloSGdqWVNX?=
 =?utf-8?B?SXNTSHRscVEyVFF3OE9aR2MwZXRtdGw0bzB3YnE1YXNab216S2toaVU3eVZo?=
 =?utf-8?B?TGlyTnhqYjNBZmVwVnlMWlpmeGlvUHRlVm5iQ3JBU3FaMXNSQ2dlaEduQnBk?=
 =?utf-8?B?WDQ3c0QrSDlxc2hYVDZXV0c1Y0plMEFvcXdEbzcvd1VXRGp6THFJME1rbkRI?=
 =?utf-8?B?WXFjbGhtNXA5Zk9Uem5tK2ljblc0UFgrQjRNNE0wYWgyemRYR1NHS3pUeVRP?=
 =?utf-8?B?N0pYM1VYR0FlUmFONlk5OVlJdDNSeWJmQXFnRjRzUVdWcnVQZTYvWkV1QVhl?=
 =?utf-8?B?V0IvemFyNGxoMFFoaS9zd0NubFlXaGd6aVdyTVFRYm1mMGVlYnNZUTJ4ZG1j?=
 =?utf-8?B?eTREeDkrdGRvdHVWVGhSOXdJL1gvdUxWSmZwUFF0RlNkUUtDMFZGWWQ0SXo2?=
 =?utf-8?B?SjF3WTI0VloxY28xUG9lbWJ1T1E0VmEwbUJLS053Mjg4U29oRm5iemJZOHJN?=
 =?utf-8?B?bVQ5OHdHaUtLdDlsZzZuQm16YXhveEpNeHMxZGJRdFlsZUNZaW5RZXYvdERa?=
 =?utf-8?B?Z2l2cE5hWDhONzZXVWplckZzVEFxeEk4U2tXbHQzc3pFejgwNTJGRDZmcWhh?=
 =?utf-8?B?ZExEbEdFZUZ2T0MraC8xaG5VcFBOdDQ4cnphOWFhSk5LNGJkZ2drc1JGbXFp?=
 =?utf-8?B?YXRUc1UzZU5MeElZYkFqVC9xWGNrSmJrU0p4bkMzTGM5VU5GWDdsWjdycW92?=
 =?utf-8?B?ZkpQV3dFMTdWTElWdnFzZzB2ODlGUng4dHg2dlFndnVjU0V1K29xaDNISmRx?=
 =?utf-8?B?cUIxZ0tZK0VqNHNvY2VIYjhFOVFSNHBVVXBxSk5lam9DdEJtQit5N2J1V3BT?=
 =?utf-8?B?SVpZY1NmMTdrSFBjUVN4c3JKS244Z1BrVHdRNEhkRTJiRkNWRWc2Ymx6dTJP?=
 =?utf-8?B?VHJRY0ZNV3U3UENXOXlUSGhwTGU2NWw4MURuWEF6M3hxVmxWcDYzRHp6cTNT?=
 =?utf-8?B?VzIxY2gza25KVTFUbDhibmRoQUUrbHpSTGZlZmZVc0ZOU250RXpIeFZNOWNZ?=
 =?utf-8?B?QTZLMHh6bWN5RS9pUmpPNUNVRUpEYnRaSkR1dkxjRm1mN1hlRnZFV1RWbE1M?=
 =?utf-8?B?VWEzV1MybXlvUHpGcDc4VlhqbStnTDBMbmMreU1teDE5ZVFsTFZ4STVsR3Rp?=
 =?utf-8?B?SytmZk9iZnZCU0VpY2VTNUtkUEQ3bFBGMGl4RVRsZVBORFkycGNwZ3p3eml5?=
 =?utf-8?B?akh4MDB6ejBJRm8wYjF3QVI0NzhLOE56TkF5MFd1ckJvZzRuYzBtMXNiaTVD?=
 =?utf-8?B?SWkyOHF4c0JRdTJ3aVMrM3dRQ0t6Tkh5ZTFDT2VRVTVZcEp2a1BQb0pnNFU0?=
 =?utf-8?B?UFdkZlFTMmhhNnhvQWlSWHFETVJ4ZlIvOTYyTFJhZDcyQlhXTE9VNFVaOWRz?=
 =?utf-8?B?YWVERGJiOHZXMkZLUnpRU3BYMGNGLzNRSHFGWkJsUnhRUGduMHptQVZ6dGhO?=
 =?utf-8?B?aU1qR1IwcVJmUTRYeE5TanhtWkRQL1RYNlJnczBoSEJlUzErK0lMR0QxbE1E?=
 =?utf-8?B?Y2N6RU95UDJWY0lFYmI4d2V2dUkwd05xZHF2am5rU0FMQkJFc09qYWxrQzBL?=
 =?utf-8?B?UTUzcGppckV5UVF0WmR6S2hXME9ISnRSRUhvZ2pWaHFHQTlJaEhBY1dQWEpR?=
 =?utf-8?B?UVFGNFpjSG1LbFJaMWJDYVVUeElMRU1YbDIvSk1Dc1FWQ0lMMUpqSTQ0NE1r?=
 =?utf-8?B?THVXS09BWE52ZXcxQUYzQ3krcHdRdVpUL1BZRS9yYkFqa1Jlb2lHNWJVNXJF?=
 =?utf-8?B?OE4wWDRyY0xpOWFWOFRaN3ZOYXRhWU9TV3BvTFoxcDdJVGNXOEdiR3N4MDdp?=
 =?utf-8?B?dndNVEEzQ0htcStGdzUvVTFOd29BVjBuWE1LNHhYRXl6UnNmZkdkVVZZN1JD?=
 =?utf-8?Q?/HwuMsVBgvNtCkg2ziZjlx+6j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f246a06-ba7c-4c1a-f84a-08dc42a6abcf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:11:19.6757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TiniJkabgsgS+NB31hF0rA06sbxFWU3TXf84GQnrhotKsfBJ6SegpMyDTmOe+4Ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
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



On 3/7/24 16:29, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> ZynqMP CG series devices only have two cpus. In this
> case the interrupt-affinity property has to adapted, because
> cpu3 and cpu4 are missing. By adding a label to the pmu fwnode the
> interrupt-affinity can be adapted in a device specific DT.
> 
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
>   arch/arm/dts/zynqmp.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
> index b50b83b772..457f8e394f 100644
> --- a/arch/arm/dts/zynqmp.dtsi
> +++ b/arch/arm/dts/zynqmp.dtsi
> @@ -168,7 +168,7 @@
>   		bootph-all;
>   	};
>   
> -	pmu {
> +	pmu: pmu {
>   		compatible = "arm,armv8-pmuv3";
>   		interrupt-parent = <&gic>;
>   		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,

Applied.
M
