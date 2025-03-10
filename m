Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C43C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 07:49:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1336680107;
	Mon, 10 Mar 2025 08:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CtLZjtUY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 281B480017; Mon, 10 Mar 2025 08:49:47 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10D9280107
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 08:49:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a47P8GQyrEvmCUi14rVkmsXg54IO1D6agLrZQYxrEFveFDj5WKDqUO+oZ5WHHKqxFOefWYTzAkCjI0ukq+BoQ01NMP702Bg2vWQhj2wHzKfY1bSFfn55CUkqJ5XsxuSHLTPQFzfMQ0TQhFuOJO3Zv+8lCd8UhxarANakSJcVFZL3eZuZEEOiUE3/VknXu1mMlhSkqzMWT5B9QIc7iL8PRDovRrhrnZwYQbhSvelT1PIfXqYf0o5SA5nnKCzmhDoZSphCcFqGDjFxNipgnSotUuk2mW0jpp4PguBThx2zfxVyU7GRd9lffgVc29RJF2eJtUtRpwEKsc6TQFM7mcE+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYsBnyCuqr0rQmLDT3m0XQeCHG+2pbEAbScnBvUlm5Q=;
 b=hC1hAeMAjTIY+U2SPOgVIu6fw9FaUojdZ3HJcRUGzuaIQai1rHuKCp3+7qY8qZYyqOgJT9VvZ+HX4PdCeui9HNMbSAJAOa5STxHD6dwIyPmaNTMkpEivUKAqewToj9bjCD+INZ/XJTUhgSLx+bW5mMQsScx3w2BYALKqn+7N0QZkInKdDNlLLwWt1lOIGnRrbXQu6ylHOzNSqBloBDAZDnI3g3BzQB4oKUKEnd00uYRoJtflZQxrvqwLIFsXvSm6gU/37uxlflG8k/PAAgzq3clpsU+2wCP4LAMvm5W9Phd/bcznfEdfKxFj2diq+SReXOJBJa9PDiwB+NpXMDcAqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYsBnyCuqr0rQmLDT3m0XQeCHG+2pbEAbScnBvUlm5Q=;
 b=CtLZjtUYePITYuGQtgU+I9eAhwsS1fpTuQpzqZ4Db1D/zncK4euRzA93mL/Zekfh169ZuxcCyU1K938EVPrbaOoduh4fNw4o3dQgNTbqZSBDxmiKv/AwZTSB0z51khEbdW79EdTQbUIgXaj7Qla5hrGm+5gMlEhRrWJ2UowKAow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 07:49:41 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 07:49:41 +0000
Message-ID: <fb24a61e-0fb5-4430-b5e1-1c2b25ca8159@amd.com>
Date: Mon, 10 Mar 2025 08:49:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: version: Get information about GCC and LD back
From: Michal Simek <michal.simek@amd.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, git@xilinx.com
References: <59827eccb8a90957e3d4f09059e43cc7fe6c92dc.1741255948.git.michal.simek@amd.com>
 <20250306140250.GX2640854@bill-the-cat>
 <41f1ec1b-2c36-4ab1-9e99-77459deff366@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <41f1ec1b-2c36-4ab1-9e99-77459deff366@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CP5P284CA0118.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:228::19) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|SJ0PR12MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f92c4be-fde6-4c09-fe40-08dd5fa81d6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUtERVpvUGdMNXVhMTViY1ZlTGV4eHM5TkZ0d3g4VVppN3Z1eTdSVnNTd2hw?=
 =?utf-8?B?eFU4VTR2cW90U0d1cXgyVXFOamthb01ueXNPUFdjRXRKYnR3S0hRdWpPR2hL?=
 =?utf-8?B?UjJMVklMRzhETmtJSkk4cWhzZ3FWSzRhN3R1U3JlSlhqRldnWGliYnBuM0Rq?=
 =?utf-8?B?ak5OVFZjaWlDN2kzQWdpUlRncGl1Mi91b1FNdHZKcmMyUWdFZThnRTg3NVZJ?=
 =?utf-8?B?QzRJQWFPU1lYL3dGUyt3UExOZEU0WEtIUlNNUFBkMW93WjJqSTRFU2tzdzhS?=
 =?utf-8?B?WG5ueXV3TGpZM1dOWVNFS2N2ek5hRkdwMEFacDNLUHZvZFZtZFVkZEVLTnZO?=
 =?utf-8?B?N25HNWtwd1Z4d2VFOGxqZ28zR2hhNUhrM1VFemE3dGxaNDUyR3MyTmxLdWZu?=
 =?utf-8?B?ZGtVTjJ6ZU9UY2swL0E1Qk5VeUcvUTRPeXRYQWdjTTdrWTNML1B0Y0Z6RWh2?=
 =?utf-8?B?cFpuT01nSldMRWhYcXNDL1pIR2FzcEczSHdObnFBTm1jMVpXNEhENnJKQnlv?=
 =?utf-8?B?aVMwLzc1UFd0SWFWTFl5VjNPVWJwRlZKYWZpUU41UlJndHJPaHhjbUNMek1R?=
 =?utf-8?B?ZHRLUUZLTkxCTzFmcktUNHdFbWV5bXNaeVVpcnRDUjVDSTVVT0x5VFlSME1I?=
 =?utf-8?B?dklveGlRNVN0bWxabkpNSmxxOURybk5UOGczTmJqV29sRHg0QlFvb0xvRzJo?=
 =?utf-8?B?OFRSTWE0NElHTmJwaHV4Q2dqeHN0MjVWY25YQ0JUVTV5VnFWTENDa0JZUEor?=
 =?utf-8?B?a0NETWhueVE0NjdtbXhiZjhBWUVSbDlBdzh3N3FVQXBiNlVUTDYrbkQxSktC?=
 =?utf-8?B?cHlMT3l0YkxzSzNEUzdDenp0N0FBWGdERWF2UWRYV2p1NUR2elp1R0xIVFUx?=
 =?utf-8?B?Y3VqK1ZRK1NZRVJ6U1dvT0Q3Tlp4Q0N1T2xBMzllaUZvQkQ2bXAwMG14bEY2?=
 =?utf-8?B?OEpxVTBvK1VXOVpsWGhmYVpMQjhwT1p0NXErQ0hnblA0T2dDbVpqSnVYUVZr?=
 =?utf-8?B?dTVmMFRKR1N2TXVuVkVTUjl0OWt6ZHFjbWNEeHlZNzB1YWdmMXFqSTZwbFYy?=
 =?utf-8?B?NVFUMTFQL1psd3RIcXhrZGVIODhpSC9mRjBRRkwyeWpUS0s2TWJOYUpPbmp5?=
 =?utf-8?B?OTlrMWVHakoySFE1OHRYYjZLbTZBZjIwcmpIcThQTUdLRTNmOFN0ZEZ0OXJ0?=
 =?utf-8?B?aE1GblNkMDVMbFZ5czhpRCtGeW5oSzJBS1VZSWJrOTJoSkl2TEt3SlE0dWR1?=
 =?utf-8?B?a2FzKzJFNVZERjZScDhJa3RwNHA4QW1pSmFDOUhISjgyejY1TG1VeUwza20y?=
 =?utf-8?B?b0RySlZZWnpTclVIY0U5MjdKaFRJN3B2SGdlYWdXeUJORUFlTS9KZUMwd2dD?=
 =?utf-8?B?Slcyc1lUZXd6QlFVd0NyOFRJL2h0ZnpCWVhtT1NVbW80OHg3SU1obThISy96?=
 =?utf-8?B?N0c3d2RaVVFPTmRvcTVFbjR5UzNuSWhucndvS2t0NTk2QTN5Mi9UZytxMGVX?=
 =?utf-8?B?bmNzUyt5L0d2ODV1QjRxc2hucHZjZFBETm1tRGR5M2Y0V09JZzgvdGZiNDhR?=
 =?utf-8?B?dkNFbzFlQzY0SnA1Qy9IK2I2Vlp5Q0JUUnU2S2pGNnNkemxxRXp5ektlOVdk?=
 =?utf-8?B?QjFlY1lKYXdDcW5LbVJoWjJrK2I1VDdhSmxvekRuUThud25NRkZJMEJwU1p0?=
 =?utf-8?B?UmFhWUd0WlE2ODdhZUhDelByTWY1TVk3UVBCdU93RDNLYVpRaUxwcHNVemt6?=
 =?utf-8?B?S2xlUTBGSFh4cFJEVEZpdG13Z0ZwS2l6U1BRakd3c2RlMklpRTVISVM4MHgz?=
 =?utf-8?B?eHJsWHpnSFRHL2h6NmxUUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2VqSU51OHd6eUkyVkRsUEplamNsQThUenlIQUhkWkcxMzFkalplRTlvbndT?=
 =?utf-8?B?QjNYOG9oZXNpMVphTklGM20vS25PNVFtVTNpbTBJc0Y5aG9MSDlraTNoWXNS?=
 =?utf-8?B?Z0xlZVpuUTFlU2hlK0VPeHpac0tkZURsbVU4amhRbzJsayt4cThWc1pOUEg1?=
 =?utf-8?B?MXNQVVJmUmtqMVBsUUdNYkpaQmhKUzNmamxZZk1mblY5dEE5TVVTSkdCZEVr?=
 =?utf-8?B?REtqUWxKU1h6UitGQzJGVDFWVzE4N0c4ckxpV0JTQk02elZ2bThvcmNXeW9u?=
 =?utf-8?B?ZEJLeXpqU1p6VFZ4NkdMQldkcGdENU4vWTRmYk9ZUXNPaVk3NHFZVFdVVVEv?=
 =?utf-8?B?Mnowdkw0WEU4VGpUbTVJd2toVTI4OEFkbHFaRlM3eS9yN3BMS3ROQ2tRNmpO?=
 =?utf-8?B?Y01jalpHVUlRbTdYVXVreldCSVBSUXJiK1ZQY3Nyc0FOckluRm5ZT05yblJh?=
 =?utf-8?B?c0ZhOHJzU2ZacW1rM25jMHY1L0xUcklJak42VXhLMEh2Wm5mV3RCbWpIRmZW?=
 =?utf-8?B?TXo4NHVJcDZDZjR1dk1LaXo4NkJqbFVvbU5Scnp6Z2Z0b1pvekdUdGhLRFhr?=
 =?utf-8?B?eHlHSk1UbDRZRXRGNU10M0ptbmUzN2F6TGpTdUpBNUlPcmdFZFZUdnV0WjBW?=
 =?utf-8?B?T3MyOEdxMlB4Mm9HVXVTbTREQ0QyRHhYSEhoSkRrTG9JVjU1SnJxUjdNYlho?=
 =?utf-8?B?aDFzRzcyY21uQ0UzWm93V25CUGpTUjhUYmNYTi9JckxwK2N0VHZXK0psczk2?=
 =?utf-8?B?TTN0eEJsc0dDNCtBUDMxYUZTc0VRR0w2ei9QN0VtNmRTMWNjd05TUHBici9L?=
 =?utf-8?B?dXNLSXF4ZUZZenFDajNyNWMxSy81eTFzUlA3eEt4dXB3RTh4b1VxTllsWmE4?=
 =?utf-8?B?Zk1ta1NWK0orN2d5dDVxbjRLYSs5U2d1dkQybytGbjdNOWgxeTh5VktlVDl1?=
 =?utf-8?B?S294bG55T1JXa04zdGtmZUlpOVc3ZHdPRUs4WnMrZ0l3VHBkQU1JTFF2Tmp6?=
 =?utf-8?B?aFdGV0VYTkhLdk13TzB2QzlabHNhZDVlMmhiZkRYWXBFQ0FhYzQwbGJzcW1l?=
 =?utf-8?B?M1Q1Y2RlNzU0OFVIVXZyNVZQYk5OVXM0ZTN6VC9WRzN2SjQ4bmhxVkRIV3Zq?=
 =?utf-8?B?SVBXNHBmeXVMcjh3bHo4VG80S2U4ZXRjZDZjalplS2x4bi9pdVRSRy82QytI?=
 =?utf-8?B?aHBVWUFIdjJ3Tlk2ZU5yejc3VzdtUkNuQk1haHBXWnNZTmV3N0J2T0NwYU5B?=
 =?utf-8?B?c0tNenpnVmdOWFVRRnBOSFE0MldyYlpVL0Vqb2JlTlFENmtkMHY2VHQzV2RW?=
 =?utf-8?B?bTBJUkhXOE5rcmM0ampVNVJTeWJCV1dkcGl2TitaQmt3RFBKVHdDZm9BMjB6?=
 =?utf-8?B?RTFQdGlIYnk2YzFIZ0pyS1JpSG9lUkczQjhtdG5DVDJxNnAxclZjY1dsQXcz?=
 =?utf-8?B?dkpINnltZVdGbzcwdFIwRUM4Vk9nNlFSZGl0ZDBMS3NiV1B0b0YzUWRyU2F3?=
 =?utf-8?B?MVNJVzBoUHVQZkVPVnNxdUxaQTVST0xZZ1N2WUVQb2ZUMU1qQ3YrM2VCVS94?=
 =?utf-8?B?bk5QaG93SlVqdzBtUGpFL3ZhazBQa082UGZCV0dDUjFJNWZSS1IxNlduTlZF?=
 =?utf-8?B?aE4vVVE0TWtSYlJKc3V0cHA2Mm8wMUwzVGtqSDRPeHEyV1Y0Y2w4L28zSXJY?=
 =?utf-8?B?YUhjR29qbEJndkFKUkkvbDB5eTFWczQ5OU1LcDRRRHpFaUVsNFJuT1RHZ2FO?=
 =?utf-8?B?MGFPSkV1VklINXkwTS85ZzJiVU91aWJOU0xQYTJWbDgvbHpwaVBEamdMeHFV?=
 =?utf-8?B?ZkozUzdzUnplTU1iVWdnN2pYMHNqSjQ0NXN5WXZVYVRxL0Q4amVnNTd2bElW?=
 =?utf-8?B?VmtzQXA0eWRGL3dUc2x6ZUdKbzdzbjZLcWN2Z1daR2VuZ3NsTmpqbXZiRTdX?=
 =?utf-8?B?Z1dOK3d1bXJhU3dPUnhLK1pleEF5OXkrSkhZMHVoTnpSQm0vamdhaWNLbW83?=
 =?utf-8?B?dTBXTis3cHFPc0dqdTJBSjM0eFVkR0lzdWh3ZEZ2WkpOM2VuR0VZMitpOFU0?=
 =?utf-8?B?Qnp0MkN2ZDRmbVBSRmNMOWg4bDhRc0ZWa3FTZUZHUjgrSHlrbC9RMW4xOFRQ?=
 =?utf-8?Q?54RYBp/NNRi17hiS+iIqdvWWB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f92c4be-fde6-4c09-fe40-08dd5fa81d6c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 07:49:41.1641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kW5F8bBiBz65vCqeSwW8V0W6Gd8I5/wzuCw5iTAMWhaetmT8JcngyGvL7DnorHAe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610
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



On 3/6/25 15:12, Michal Simek wrote:
> 
> 
> On 3/6/25 15:02, Tom Rini wrote:
>> On Thu, Mar 06, 2025 at 11:12:30AM +0100, Michal Simek wrote:
>>> U-Boot version command is no longer showing information about GCC and LD.
>>> The reason is that version.h has been removed that's why CC_VERSION_STRING
>>> and LD_VERSION_STRING are not pass.
>>> Values are generated to generated/version_autogenerated.h which is sourced
>>> in version.h.
>>>
>>> Fixes: 54ecce2cbf90 ("version: Separate our version string from the version 
>>> command")
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> ---
>>>
>>> Tom: Not sure if this has been done on purpose or not but this issue has
>>> been reported by our regression team.
>>
>> It wasn't on purpose, no. Did you put this through CI / confirm
>> sandbox_nocmdline still builds?
> 
> Nope I did not.

CI is not reporting any issue.

https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pipelines/25029

Thanks,
Michal
