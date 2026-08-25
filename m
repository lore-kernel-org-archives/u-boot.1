Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928A4C5DF94
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 05:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5186F405F1;
	Tue, 25 Aug 2026 05:53:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D5ptpu9SPiUN; Tue, 25 Aug 2026 05:53:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787637205;
	bh=Ko7lFTimB3hsCzXBB7X1XOR1MeHtZGuZd2sdYluIQ64=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=chLrX9VE328mf3uDA/jl2cZM3Lp+Q6SMU5lLP4JpxlHYGL2szpNAQK9W3BJau5Jnk
	 JR/I8BTJbteXBLc9IhRPWguIGx0FhVMDIcj443nForBjr92CdqLHiahRkm/ps5HS60
	 gSGWu2eBqDyJ7AvSS0j2wn6Ze5BluGGrmjuURmLUEdnIXFEJ29jXt/wK2pEq5re0GD
	 dkDDTdu8zBivdAaWBjPRtUjvVoqXPmAyoc+N/wkDsPqk1HmXEmipF5VhXZWUIKvoNf
	 kUTFD5KpJbcYyF/a09nnHlN+oChNSMwLTHuegVjzZ6SbzruzaMBnmHErjjFhL1gDWL
	 RTe34CqF3x3pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15EBE4059E;
	Tue, 25 Aug 2026 05:53:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C00C3AD
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 05:53:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6DBE680C48
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 05:53:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AVCgqeJ8OHu6 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 05:53:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::2;
 helo=sj2pr03cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=2vuTEqMa
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 674D780C1A
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 05:53:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oijWrNtOcZ9iKbq1+2aEVoD1pBFuOwfCu8yquI2r4lQM0pLdDk5YWY8lB/GYtaO7+jfJkvwPzLXa1pGb+aVR0+a0n/mjn+UTYAOTVHmovZQGJr9t2k7UdBFPdzvZOV7TGw2bKhdpMq/9Vrf/USLN2lu3/jw7NVL4Pc+wz/mt2SPSdJvjKl5jGJ+4tMwlRoG+X2eyJ7L9CL+1KO67CrrMPzcFGAaLPzo1l4Mx3ZJj3vDpSCNWPXlHAESekUNa/jpnBtlyKMKuaVQ2lnRBJy30ULIe+X/cCK2GY/4RI9wi9Go+JWrH2nqb2XeM5uqmyrqwaP/ExiKkp3PBThkQ6kWDLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ko7lFTimB3hsCzXBB7X1XOR1MeHtZGuZd2sdYluIQ64=;
 b=QavPg4AEm74xyRNTeMqkeySF9gUw4fzkK5dc/nzwZdshz/PtVZJs23jR2t9ZuSBTNtWje64uOVbU0q1uSp6PMUeXhEFGsVBs+plLa1OWKVMO2gYkS1vys/PRBRHdJRKe5Wk1ymoRdCkr54ZYMkIzt4F9hda/8UTt4uiEAv4GsxJiufqxmrP+8G3sSAHbnkFeo1cENaSe1CLJeHB2uv4GtBzHvzF/1qlCFtOHKnFXkW0iO/A2ZcAUVGpw4v79oPesM11gpX5+MZ692SGP7OiR15GJVdmJd/LQO917bD42ZfjK+ipD/KGYBizc6BnueaeG+cqk/enlcdNqog2vuTesag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ko7lFTimB3hsCzXBB7X1XOR1MeHtZGuZd2sdYluIQ64=;
 b=2vuTEqMaSTiShjs8DaJuu9GButzX6eq6Rs0tgK+gsDZFQHmbOdgtUC5CQADJaBDgfOw2jw5RoexSTjGCrvsJYcIq/a8HYIw8o7qGy6yNYwa6Yzu4SOtytk+G4m+UZUuMq14OVNVA92RvFQpagnIAJWL4sUcWMtxaNYj+G042nOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by LV2PR12MB999074.namprd12.prod.outlook.com (2603:10b6:408:351::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 05:53:16 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 05:53:16 +0000
Message-ID: <a3b4bb78-8a3b-4c88-8bca-a32518e5ec48@amd.com>
Date: Tue, 25 Aug 2026 07:53:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] scripts: pass dtc cpp flags via a GCC response file
To: Tom Rini <trini@konsulko.com>
Cc: Suraj Kakade <suraj.hanumantkakade@amd.com>,
 u-boot@lists.u-boot-project.org, git@amd.com, padmarao.begari@amd.com,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Simon Glass <sjg@chromium.org>,
 Jonathan Humphreys <j-humphreys@ti.com>
References: <20260824044729.708287-1-suraj.hanumantkakade@amd.com>
 <20260824150937.GD523975@bill-the-cat>
 <2c9ac202-68a7-4017-a8f9-91e9b3579166@amd.com>
 <20260824165125.GI523975@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260824165125.GI523975@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::31) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|LV2PR12MB999074:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b8f76b-7a0c-4082-b200-08df026d2894
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|56012099006|6133799003|3023799007|22082099003|18002099003|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: n/kWA5G2eksDvYewCZE5bQqL2uQt7+bdtqu4xmTpektp1HhPOIddnMSarSBx09ZvEpX/aQewxQ0I4IEsoAN5Wj1tEbS5XAEZpudACXdc9J9AGuk+FvwofOBicCWVQfIhtHI4lmjoXHLDgKsH/ihLjU3jgYCKdokfRSwEtUQ1PVp5CVciFWhu6kXRfZj5qT8ALfEHtJriA5p4X/63nLS42fyOjONCFG8i3qBhUmEZZBTcdEN/nVLhOMij9nDhmMr6J/5KrO5Ye89mndK3hRkxhdTdedExWETNKiPIg5HD+BnDAFAnokBALKNzACJCw5ZL6row0QBrF/pVRG5UHNmCglSdBmE2Im4z07fq3uBVTXmmTXdEGsFdAOxaZsvjN631S68hKkmaSayKUB6u7D+wt1qkrrPwYMtEpP5YnBmPtxcl5iHp0MzEqCVxSbfwV3mKMgabOdC1IK7xDAp7/sftzyC6JCc8W2x56JfJbs1AAJTKmCfnE2QvJHkK2gtiCPnKlFIkVc+tDDBYcQvIei8M4CM2FqxrJtifn/cnbAQlojSnEiylcSdEg4tUmWu+4iNCPOX2KjVkvd3zUSR0fRfr/SrH3anA46hhTguulvA4O6+iOtBSHasat4dSwYaueDdyIZY7QFHLdt5GOVE2GvP1fDSgVt2kBAiNBpijHkJC36s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlpHMlpwZEZ1NCsxYkVCQVAybWMvU2pRbEFoRHliZVljUFZwOEVETElhc0VK?=
 =?utf-8?B?RnlzME5obFJFdDNGZFhrQkZZQnFZUXZNUVphakRVWXhSVXM3alFnQzlDQSsx?=
 =?utf-8?B?WmY4bGxDdCtMNW1MWXgyVTFXTnZZNUo3RHQzMzBWdVFudUEzcXVORE9qeEVB?=
 =?utf-8?B?bmovREFqZEFzWmxrUmRYNVNPYkpmc2VwM3psVno1Undyb2pqcFk0UGVDYWpU?=
 =?utf-8?B?TGd2MHlwZ2E5SUdRNGtyOEg5RWxmc2RldmZnbXVMQi9yUGhCYTRqYWZxOVYv?=
 =?utf-8?B?OTJSVkVkTGdNdnh4aS95MG9LWEs4VW10YUYrQ1lJSEc4WHI0dnc1eHU5dHBQ?=
 =?utf-8?B?N1VrUDRkUk1qS3Nvblo0YllCTUxXQUJ6aHl4R3Bid0xmNUlBeFZyb0xvVCtO?=
 =?utf-8?B?elV5aUp5U3lHcSsvcmhEU2h6S0VzTHNxZk5KT0RVZnpYbUEzWDROdnlpUXM2?=
 =?utf-8?B?REwySGNNTFJBQUNVSFoxcURHd2hIL3ova2FSUThnc1BQMUtJTG9paFl4UWYx?=
 =?utf-8?B?NGJ1dmZ4WXMvaWl3NHpzOXlLSzlKMW5NVS8vZTJ4bjd5OExPR3lyWFlyY3A0?=
 =?utf-8?B?NFA1a2VPbjVYWXN5N0FKU1JsVVpwOUhibG9FdEVZSHo4ZGFRblBRdkxKZm9m?=
 =?utf-8?B?UnFjSFA5bnlqcTZVU0QwSXMxb29ORFF2ZXpnMG1SOFoweGlMV3RPNmhabzVY?=
 =?utf-8?B?a2dxclEzZHA1Z1FwS2hJa01HYlFENFZ5SnZrWU1LdlhTVXJvNlUvT3NRQk1l?=
 =?utf-8?B?cDlhb1k4NjhkWkdUV3hQdDdmZ0JkQnB5enVwUjNYNVdvb0k4UytuOE51dTVF?=
 =?utf-8?B?UE53NXhlVHJvWUJlYi9ZSW01WFJ4YjZyYVlGallZdld0THl2VlE1SElMREto?=
 =?utf-8?B?WGJvNGVia3Z0b2dZclgwNWs0MDdoQms3TmhqZzM3MmpoWHhIYW0vR0tSMjBy?=
 =?utf-8?B?QTc0MlVpKytGWHZRVVowMERXZ3hHREtPRFZPOXEwWjhKbUphS0pXUXhHd2x4?=
 =?utf-8?B?WmhJSDlhZ25nSVVwSGRCQ1FhK2N5Sk5MVG0wM2hkY2Y2V3JUSFEzSmswZEdU?=
 =?utf-8?B?ZkxNTWRESGh3RFRGa2VhK3RWQjY2UEthMG9VeEZER0lRRzNrd05JeFJjUXd1?=
 =?utf-8?B?czlscWNpWGNrM2x5OElXTy9GcCtWaGJCRkZxZHRLMVZaTnJRVUxhd2dWUWR6?=
 =?utf-8?B?QmdMNW9LaTJGUnBjTVdvSXl1MmFPK1pLUWtSY0hKNk5rRGJjSEFWYVhySGlt?=
 =?utf-8?B?TTUrWlB0SXFMeEdnaGYzRkNTeGZ6WWRSWFpmZGJudVNTbmVCZ2s5Z2NHUlBY?=
 =?utf-8?B?UGhYU3UwWkZUVmhnUmh4ZzY3dUpVbXpFM29tOHMydGttMHFYNHAzM2p3UVlN?=
 =?utf-8?B?Yk9Wa1pQbjF6L3NsRkt3N0N1cUl4MFoxT3ArcDVCeTZ0NytPN0RYampWTC92?=
 =?utf-8?B?ZzU4MHIyaW5jeVg2ZUdMLzhaWW9Yc1d0cnZhQnlWaWFpWjk3VysyMTV3M1RZ?=
 =?utf-8?B?N1hTOWorUnI0cDJaQ2xkTEZOejZDLzl1SFpKUEZnRWQvREZPQjFvK2IyTUcv?=
 =?utf-8?B?Y0dZWUJHM1oyTlF5bFdTbmdJc1VJTForOFQzR3FZK3ZCOEE5MVdDZ015cGhx?=
 =?utf-8?B?RDA5ZUNXTkx4U3BZN1h4c0dHWXQybTdEWG9PeWx6a0Zoa1JrbXJBOU9udDgr?=
 =?utf-8?B?d3FMd1JYQWVXTGN4STBPcUg0V3BBZUxtUkdnZUl2SXplQllIZC9YZFMvOTlF?=
 =?utf-8?B?SDRYL3BzeE9BaEFmRURSdDVCTExpeE9PdkoxRTluanVzdHh4anAwbVc5N2Zu?=
 =?utf-8?B?U2tZZlU1d2pESDcxMGN4elIyT21kVzZEZVBQYU1PdU1hby8vd2duQjVNalpV?=
 =?utf-8?B?Mmc4V05la2dCUXozaUUrOFJ1elVzZTRSc0lDYVA3THFIVGg5bzY0aVdPRnpG?=
 =?utf-8?B?MWQ5Y0RNTjNjQWRhNC9kWU8zOG5ZVmxzQTczSExNNEk0ZHpoMCtJaW51bHIy?=
 =?utf-8?B?WlV4ZEVob1dMUjkyN05VKy9mT2lBWWlNL05NUkVhMDhpVVptMEhNNk96TUkw?=
 =?utf-8?B?Yk5LWmVzbEpvMEEvejJPMTA1RlVwL2RIZmJoZXVoT0tDMys4T3pMdmtKU05Z?=
 =?utf-8?B?YzE2Q1V6dFd1M1dHRVlIWjhvY2VpalBYcmZDcHdicHdIaS93VlZnQndXWmIr?=
 =?utf-8?B?OUNQS3M4cHptd1lpVW4wOC94R0k0K0ZOc1NtWTZNc3AxaFVmWThjRGR0ZHA1?=
 =?utf-8?B?dzhLUk5uYjcwUjNRUVFIS0FyMlJ4dGRjaGRoNEFtUmZXRWlITGVxdGgvNE1G?=
 =?utf-8?B?OHI4WjRrUDFLSnNRV0h1L3hDVWpNVmxtNEhXbTluMmZnS2FyV1BZdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b8f76b-7a0c-4082-b200-08df026d2894
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 05:53:16.6702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBs+62zvbkrfCAIqNlJ1zOTsEKGLA19mdLnjNgUhS3Eg3vKhJWdo5zP4xpZvBMUG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999074
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 8/24/26 18:51, Tom Rini wrote:
> On Mon, Aug 24, 2026 at 05:29:37PM +0200, Michal Simek wrote:
>>
>>
>> On 8/24/26 17:09, Tom Rini wrote:
>>> On Mon, Aug 24, 2026 at 10:17:18AM +0530, Suraj Kakade wrote:
>>>
>>>> cmd_dtc inlines dtc_cpp_flags (including every upstream dtsi -I
>>>> path) in the HOSTCC command. With a long $(srctree) that command is
>>>> too large for /bin/sh -c and Make fails with "Argument list too
>>>> long" while building a .dtb.
>>>>
>>>> Write the flags to a per-target .dtc.flags.tmp file and pass @file to
>>>> HOSTCC/CPP so the shell command stays short.
>>>>
>>>> This change requires GNU Make >= 4.0, since $(file ...) is not
>>>> supported by Make 3.x.
>>>>
>>>> Fixes: d31ff219a833 ("Makefile.lib: find capsule ESL dtsi file with CONFIG_OF_UPSTREAM")
>>>> Fixes: 1e7883f6325a ("dtbo: Fix dtbo generation rules")
>>>> Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
>>>
>>> The linux kernel, and so Kbuild, says that 4.0 is the minimum version of
>>> GNU make required, so that is true for us as well, so this is fine.
>>>
>>> Reviewed-by: Tom Rini <trini@konsulko.com>
>>>
>>
>> We should likely fix this too.
>>
>>    94 # If the user is running make -s (silent mode), suppress echoing of
>>    95 # commands
>>    96 ifneq ($(filter 4.%,$(MAKE_VERSION)),)  # make-4
>>    97 ifneq ($(filter %s ,$(firstword x$(MAKEFLAGS))),)
>>    98   quiet=silent_
>>    99 endif
>>   100 else                                    # make-3.8x
>>   101 ifneq ($(filter s% -s%,$(MAKEFLAGS)),)
>>   102   quiet=silent_
>>   103 endif
>>   104 endif
> 
> I think this means we should pull commit
> 5f99665ee8f4335f334a5292b6d5b41a577fc2c0 from the kernel in, to fully
> switch to 4.0 as minimum.
> 

something like this?

M

diff --git a/Makefile b/Makefile
index 16e3e4dfe5e4..e0ab39200c1b 100644
--- a/Makefile
+++ b/Makefile
@@ -93,15 +93,9 @@ endif

  # If the user is running make -s (silent mode), suppress echoing of
  # commands
-ifneq ($(filter 4.%,$(MAKE_VERSION)),) # make-4
-ifneq ($(filter %s ,$(firstword x$(MAKEFLAGS))),)
+ifneq ($(findstring s,$(firstword -$(MAKEFLAGS))),)
    quiet=silent_
  endif
-else                                   # make-3.8x
-ifneq ($(filter s% -s%,$(MAKEFLAGS)),)
-  quiet=silent_
-endif
-endif

  export quiet Q KBUILD_VERBOSE

@@ -166,14 +160,6 @@ ifneq ($(abs_srctree),$(abs_objtree))
  MAKEFLAGS += --include-dir=$(abs_srctree)
  endif

-ifneq ($(filter 3.%,$(MAKE_VERSION)),)
-# 'MAKEFLAGS += -rR' does not immediately become effective for GNU Make 3.x
-# We need to invoke sub-make to avoid implicit rules in the top Makefile.
-need-sub-make := 1
-# Cancel implicit rules for this Makefile.
-$(this-makefile): ;
-endif
-
  export abs_srctree abs_objtree
  export sub_make_done := 1



