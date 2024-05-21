Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3858C25B75
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 06:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 314F7886FF;
	Tue, 21 May 2024 08:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BGg+MS/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5465D87E1D; Tue, 21 May 2024 08:58:06 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C009886FF
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 08:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMZYzF53slbdczsay6Mk0dt+zgkQOpYUFU/enu4L+NTcESM+KoUOcVYhgOTRZ73tKnluWeYgWIDe1PaihBBS+7IONkyEz8Y0g5XfKmA+rEgRwG7b5YsC6t5GY84PvnpKKX6ucwEf0ppDjEBPGzpdAxx3MmtqcStECXH8SXtWMP75y8zFKDYHPooKo/mdmt6+jSUAZa7f0OxpCL+rOlrn7DZ/loDUsTOwn7HdxrXKNlpt/Ywno1BoA+wMEJwILogYOwCmA+uXA5SC4d2Tjh1Cua4HJY+fwl5GSr4PvwCaIdJ8eLc58fbLsP3wBee4sAV55xqapaup053ZebYLP8WRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjfJbjmREr0D6yqA8dsy7FswsBD8qwz8AMpx4X+eNWU=;
 b=CWmQEVG1hZsp0II8DVDwAokRMkAQ7Sa5fYuNQy+Ds8yI4NGtzvV62QrbSbIQ5cIKQrubZ5A3f7Bx6McQFfynn9+s4zkMDS7K/r+BtYeZ+shLO65Yj7ga9WuAVkhW2IdXyBZj97FYUSr7jdfFIweSTNDUs0brRo1qrfaPajqEc6V3HiRYP6oPDguXEmUrE1lBBrvAuPQBbhzobu3g5oFFUp8LRhLev7fD8XkUlFu1xDCosiscqHDLTHJDgF02K4rccHnxvpX5/ro7pjHdF7c+8vmavd/C8N0+V2WHgn1+nFgr7NyInqeRW0CwHWJotVNmrSFbSOubGwQP1lvnitcttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjfJbjmREr0D6yqA8dsy7FswsBD8qwz8AMpx4X+eNWU=;
 b=BGg+MS/Md/ut+NsBbZlKnoNab3ET0gqF2VJOEgnv3S/CZ2FmW2A/EO4F5SaauYagQeZepxs24rra4qodA6Ro34eEVpvxPTD6Ad6Pt7xGQQNtsr0SWCM9oQaSFSfUXhap27bDR8Fh2pfTOmlt7XBQAaOPPJvC/7Z8gkoCtylfOXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.36; Tue, 21 May 2024 06:58:00 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 06:58:00 +0000
Message-ID: <d61e17f0-231d-4e26-8908-091535038e79@amd.com>
Date: Tue, 21 May 2024 08:57:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fdt: automatically add /chosen/kaslr-seed if DM_RNG is
 enabled
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Andy Yan <andy.yan@rock-chips.com>,
 Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240515205049.3005256-1-tharvey@gateworks.com>
 <CAJ+vNU16cn31h_W4g6of8wDTNZNfuzm42K0B-_BMX6zeJSJTmg@mail.gmail.com>
 <07c0000c-c60a-42ad-8c49-608b7b15e7f8@amd.com>
 <CAJ+vNU3HZT=5An0hXCxoyTSJhpsTtOg=gUHf+ks_JKq38jEjRw@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAJ+vNU3HZT=5An0hXCxoyTSJhpsTtOg=gUHf+ks_JKq38jEjRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR03CA0076.eurprd03.prod.outlook.com
 (2603:10a6:803:50::47) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|DM4PR12MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aaac59b-611d-47e5-955d-08dc79635a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3VKOGlZd05nVHdrREpsV0NxMWUwb1NYWWNpNk52QStqTUQwbHI1TEFNbHRn?=
 =?utf-8?B?WUZxUkdFbHJIUFhSR0lxUGpSNlNDWnFraEE4eTA0Y0FjNDViMlBIVmRFWXI1?=
 =?utf-8?B?bllNVnZsczRHYjZTcDFLZzJianB0T3BtS3RlWVlWempkS09SMnc5dUNvNXhK?=
 =?utf-8?B?cWxwSEdoMC8vRU9hem5QLzJZUUE4d2c4YXlKUmIxc3l2T0xRTFc4aWdwdGhi?=
 =?utf-8?B?Y1ZyN3VCNnYvdi9uSDZrVGFyaFFDTmhXNXdQWUh6eXJQUXlvcGxadHJKVVZ6?=
 =?utf-8?B?TlkyakxvbHhWenBENklSUFBxTmRocUNOWU1TbWlmMzJiWEV1T3h6ZWhVcmY3?=
 =?utf-8?B?NExzYnNtMXB5R0d1aFV4Qmd6aFB0U3N2YnVOeUp1UDlsL3RJblJYeFlYeUJu?=
 =?utf-8?B?ajFhcE85V3U3NmVJNkRnNm84eGdDZ2MwK01wajkwdTJURFdxOWRUY3lpY21t?=
 =?utf-8?B?U29pNTFWQmF1Z1NFRHk4cFNsMlFZdHJURTR6VmpSM0NjNTIwNkI2QVpKa3k4?=
 =?utf-8?B?UHNydUJzUWR3bGFEdTVMSU5uV2pQQUNmc1hReFBuamtMVnN2NXlCR2VKWis4?=
 =?utf-8?B?dURBZzZpemRPdXBhdmx6UGNlNWtEODh4MlJQME9yeDNLVHE2bC9nS0FDOUhj?=
 =?utf-8?B?bkhDRnQ0eUIxWEZMSlhTZTF3V1dzVXowYldPS21RRUJqL0psV3RBVnlmblky?=
 =?utf-8?B?NnBSNCtqWUtlWlJQRE0vQjh6RWhmUjhGUnY3cnQxTnFGR25NWlYyZ1hRNXMw?=
 =?utf-8?B?ZXJVOXdPQVYyMGV0WFViRGxLbkdYV0ovL1ZnajdHekRXbExIM3NSaHdEWENF?=
 =?utf-8?B?NVJBWnY0M2NNaVBpNDVRSFdyamVqK0JHbU1mZlN5WlBySHREdVBOY054ZTNz?=
 =?utf-8?B?MWtJUFd0MTJyb3Q4TkcwaFhNbk02djBTU2hRK0o4NFFtb3d6dDArZEhjSk1I?=
 =?utf-8?B?Q05Oekwvb3dldWhibnA1dUE0cVh2WVlnWmtuNWN5UlNMclluNXdDdUJ1OXZX?=
 =?utf-8?B?SFdwNm5uaE1oSDlyTkxRY2Y0bVhzZGtOQlZDZTJpYUVNRTh3c0hBMmUzbGtw?=
 =?utf-8?B?cHpMdUZwWlBLT1c5MHJGUytQZ1o5aythMFZXSERKaWZublh2VnYxbjV4VDEw?=
 =?utf-8?B?ZXcvTXBVclArRDg0aUVmeVdsa1pxVzMwdFRvbXhlVi9GQjIvKy9EZk90UFhJ?=
 =?utf-8?B?cHRHY1JEbkRHME9ZaDQybXZuNytqYkVJUEZ0djlIeHRxMThka0ZYNjBMNGZ1?=
 =?utf-8?B?bCt6bFlVd0hPMFZybVNtbmFoSzlzUWFNcjhEK2VGMmZ1T2EvTWFKYUdLNWZh?=
 =?utf-8?B?MWxobkMyTktCaDUrVVl2MkVMV2VSZWRpUlMzeGFZQ1ZxeGJkSzYwMXFmN2FM?=
 =?utf-8?B?aDMyRUJTdlZ1UWlqTHR4VENiZWcxMXBvSTVRS0dvYkwzUjQ5eHdLSDdYK05V?=
 =?utf-8?B?Mnl1SmRXa1pmVm9hdWZDc015RklEUnVDdkh2UWRXMzF4M0M3Um1jYjdhYUtE?=
 =?utf-8?B?MUlpaFltM0dCQ1VJbzR2b1NBaXRvK2lwS3ZxaXNLNmI2dUpVY3R1Q1R4cjJ4?=
 =?utf-8?B?VEFrK3FQMFdoYlVuMm5pMlJHOXNOTUxVTSttK2JSdjljaHdMV0Z4M3JLRWo3?=
 =?utf-8?B?QmlNNUdwUXNjSU9TdmNaTVRVdWlLTlRuUnhpUFNNcmxhUXA3cVdiNmJGb3N4?=
 =?utf-8?B?Q0Y2a3lDZ0I0ak1MOFpBbnlweSs2NXFDZllXTmpsbm1KU0JWeVh0cnFBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzBmTU14cnlVL3BLQnZrZEVoVkhtNG52bGRod2QvOU5QL2kweHN2WTI0L3Mw?=
 =?utf-8?B?Nkc0d1g5UjZQSEFlZGZWU2NHaVhXYmdXWXpjVmZOWmdPN0FQNUtQSWYwWjBP?=
 =?utf-8?B?YXdnVXUwbWh0Q1RvSjZGNmh4UzJtT1pDVGJsZ1lJT1FoRmNHbXRXckpiYlh5?=
 =?utf-8?B?N1VZd3Vxa29VUFg4OVhKZ25tZ01tcjRoL1FoMjV3dE1hZ2VOb0ZvR3p4YTIy?=
 =?utf-8?B?UzBvSkV5UUhBTFdwaStkeGRCZXRRWVlBSEhnMi9veUJLTExCQXZUNnB0b1d1?=
 =?utf-8?B?ZVorUnFWbk1KeWRIaEVyajhzeGpFL3lSb0VsQ0ZuSE5pb3FQUXVPbktrZW1j?=
 =?utf-8?B?R244UDVXK2JlS2pzSUduVW82VW1iNC9KWmRRWkNVVGRaOTN0MGZHRFV2cFNW?=
 =?utf-8?B?KytjenVqYWdBamZKUW1TVmE1dnJpOTZtRHJZR2FYMk1lci9rUDZLVFcvUHpK?=
 =?utf-8?B?blVUVFJlSEd1VGI1d0EyQnBBdk9mZWJXR3ZqRCtQVjNORlBaT1NOK1k3dFdo?=
 =?utf-8?B?OVdhazR5Yy9xQ3U4QWJxYWVBbHFRR2JpYTBCZTh6VW1RYmJpWlorU3RQMDhi?=
 =?utf-8?B?MlAxei9jRGNCMVZTdmhkcXpVWDkvWTIzVEZGYTMzQ0FIS01KNG0wNm5sR1Bm?=
 =?utf-8?B?MTVUK29ISnZLbUtXLzVkdXRJZXA5WlNvTndSNVdDNXpBcWhrc0hkMmFwbk1I?=
 =?utf-8?B?bmZYNE1XQjU4ZXpRN1gzYUhkY0VaRy9wNDMxajh2VGpXSDdpWDJ0ZlQzMVIz?=
 =?utf-8?B?L3UxNGZrRGxFVW1kckgwQ21OMXJCcVFRSng2Z0VtYUlPYWlsRW5RdlViVWJQ?=
 =?utf-8?B?M1NXRmxRcldkcjltT1R3RDVZUHk3clJPdnNGc3M2L3BGNEppeWpqeFRkYldy?=
 =?utf-8?B?bTEzL09oVlh3dEFqS1NidDBrWStJbmJiRCthYkYwSjhqQU9acGZ2Sy9zVDFw?=
 =?utf-8?B?ZTZ5alE4RlE0Sm9GM1NQU1JndEIwUVFRWml3Qlk3NWd4c0Rwb1pyWkx5bkd0?=
 =?utf-8?B?Y0I3Y09zWUw5a1gzOGdMVFhIZ2ZhNXBCWXNnRWJURG5BNnY1emFBSmx4UVBP?=
 =?utf-8?B?ejVPbXkwL3JrY0lLUnJUVVd5b2JubWtPYXJjU3JrT0JYMTQyOURnZ3J1Qzh1?=
 =?utf-8?B?SFl0SEFwRUx1bWdxdkQ4SERzbzF0MGdWcmJxSkgxdVpOT1RZWkxKYzZBUTlx?=
 =?utf-8?B?WW5pMlJGV0F0Qm0yNkZaWEJsOUEyYkFYRzd5WWNJb2YzSG1lVmVlcHdNOEFJ?=
 =?utf-8?B?cGcwSStBZDZSanM2VHJWNmR2Q0E2NHI5TmdBdnBYbWpoa29VNGozN1BPK0I2?=
 =?utf-8?B?Ynp0ZVh3bERwODB3RlNEWDQzWkNqUU5jMC9ZTWlHbm9Semtpa2ppWUduYWZn?=
 =?utf-8?B?NThRNWlkUW1pQ3NPZU9tNkkxM29wb3JKb2VOUjFCMDY0S3JWWHArYVN3ajEw?=
 =?utf-8?B?ZXZ0VEZWYzcwdU5lb2s1VmoxRHlJTE1teHJRZUJRcEJaNEhlWDZEaXVkOW9v?=
 =?utf-8?B?d3dkYnU1NGlnbEpxWVV5SnRvdFR4VThZcG9ocnJReVJDYjdKVnl6eW9Yb2FT?=
 =?utf-8?B?b0NXMlgvNGxjb2VSQ01Gd1VYNGRmZU9QWmh0Vis0bCtoei9nNlgyUER3aEVE?=
 =?utf-8?B?TFkwbUVSZEFBQmhaWXE1M1JWdVJ5VjNPTG02dU9TeFhvSFNsYjQ5RTY0ZHU0?=
 =?utf-8?B?ekJJZHNPUytOSU1rQW4wdEVXdDlaWkszaXh3MlZTNEE1d3NKSXdETkpTT1Fp?=
 =?utf-8?B?SWM5ZzBEYkF4dGhGTS9icFQzK2l2RjBFS0Jab2ZIa3FYUDhveDBMQkJNc1ha?=
 =?utf-8?B?aGlSZ0I0Y0hLc2hoK3NzWUU4VllCSVlYUmYxTVZwWTVzTHgvWGpWOUlmTlVS?=
 =?utf-8?B?QnJIdjZLR3NMNnhHZk9jZm56R2UrUlR6Njc1Wml0RFl4Z00zMGRTSHREWEN4?=
 =?utf-8?B?WTlxYlcwYlRIUVd6blkvUTJpY3pTak1qVzBML25SVG9YMTNNTThjUTAwQjdP?=
 =?utf-8?B?ZDQ1TGVRbmhOcFFSMUpZbGs1TUMzSmRwVktKVTJFTjVCSnN0VjBNS0RKd1hW?=
 =?utf-8?B?MTcrSTNjeXVEdnphdU42RmhXbGdoVWdKNVV5UWh4LzNmWEJGek1LaVlGenVj?=
 =?utf-8?Q?XTWDCp2FVeVlS6BzjTg/LY9Sz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aaac59b-611d-47e5-955d-08dc79635a17
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 06:58:00.1088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VwvS5hNrfZOqpSpVesFVOeZhaMD8tIpHXKLCAC57lr9EX98lG6kGA+ttqCuOyIi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112
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



On 5/20/24 18:37, Tim Harvey wrote:
> On Mon, May 20, 2024 at 1:29 AM Michal Simek <michal.simek@amd.com> wrote:
>>
>> Hi Tim,
>>
>> On 5/16/24 17:58, Tim Harvey wrote:
>>> On Wed, May 15, 2024 at 1:50 PM Tim Harvey <tharvey@gateworks.com> wrote:
>>>>
>>>> If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
>>>> randomize the virtual address at which the kernel image is loaded, it
>>>> expects entropy to be provided by the bootloader by populating
>>>> /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
>>>>
>>>> If we have DM_RNG enabled populate this value automatically when
>>>> fdt_chosen is called unless ARMV8_SEC_FIRMWARE_SUPPORT is enabled as
>>>> it's implementation uses a different source of entropy.
>>>>
>>>> As this fdt node is added elsewhere create a library function and
>>>> use it to deduplicate code.
>>>>
>>>> Note that the kalsrseed command (CMD_KASLRSEED) is likely pointless now
>>>> but left in place in case boot scripts exist that rely on this command
>>>> existing and returning success. An informational message is printed to
>>>> alert users of this command that it is likely no longer needed.
>>>>
>>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>>>> ---
>>>> v2:
>>>>    - fix typo in commit msg
>>>>    - use stack for seed to avoid unecessary malloc/free
>>>>    - move to a library function and deduplicate code by using it elsewhere
>>>> ---
>>>>    board/xilinx/common/board.c | 35 -----------------------------
>>>>    boot/fdt_support.c          | 10 +++++++++
>>>>    boot/pxe_utils.c            | 35 +++--------------------------
>>>>    cmd/kaslrseed.c             | 45 ++++++-------------------------------
>>>>    include/kaslrseed.h         | 17 ++++++++++++++
>>>>    lib/Makefile                |  1 +
>>>>    lib/kaslrseed.c             | 34 ++++++++++++++++++++++++++++
>>>>    7 files changed, 72 insertions(+), 105 deletions(-)
>>>>    create mode 100644 include/kaslrseed.h
>>>>    create mode 100644 lib/kaslrseed.c
>>>>
>>>> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
>>>> index 30a81376ac41..f741e8957818 100644
>>>> --- a/board/xilinx/common/board.c
>>>> +++ b/board/xilinx/common/board.c
>>>> @@ -713,41 +713,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>>>>           if (IS_ENABLED(CONFIG_FDT_FIXUP_PARTITIONS) && IS_ENABLED(CONFIG_NAND_ZYNQ))
>>>>                   fdt_fixup_mtdparts(blob, nodes, ARRAY_SIZE(nodes));
>>>>
>>>> -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
>>>> -               debug("No RNG device\n");
>>>> -               return 0;
>>>> -       }
>>>> -
>>>> -       if (dm_rng_read(dev, buf, n)) {
>>>> -               debug("Reading RNG failed\n");
>>>> -               return 0;
>>>> -       }
>>>> -
>>>> -       if (!blob) {
>>>> -               debug("No FDT memory address configured. Please configure\n"
>>>> -                     "the FDT address via \"fdt addr <address>\" command.\n"
>>>> -                     "Aborting!\n");
>>>> -               return 0;
>>>> -       }
>>>> -
>>>> -       ret = fdt_check_header(blob);
>>>> -       if (ret < 0) {
>>>> -               debug("fdt_chosen: %s\n", fdt_strerror(ret));
>>>> -               return ret;
>>>> -       }
>>>> -
>>>> -       nodeoffset = fdt_find_or_add_subnode(blob, 0, "chosen");
>>>> -       if (nodeoffset < 0) {
>>>> -               debug("Reading chosen node failed\n");
>>>> -               return nodeoffset;
>>>> -       }
>>>> -
>>>> -       ret = fdt_setprop(blob, nodeoffset, "kaslr-seed", buf, sizeof(buf));
>>>> -       if (ret < 0) {
>>>> -               debug("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
>>>> -               return ret;
>>>> -       }
>>>> -
>>>>           return 0;
>>>>    }
>>>>    #endif
>>>> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
>>>> index 874ca4d6f5af..3455d60d69dc 100644
>>>> --- a/boot/fdt_support.c
>>>> +++ b/boot/fdt_support.c
>>>> @@ -8,6 +8,7 @@
>>>>
>>>>    #include <abuf.h>
>>>>    #include <env.h>
>>>> +#include <kaslrseed.h>
>>>>    #include <log.h>
>>>>    #include <mapmem.h>
>>>>    #include <net.h>
>>>> @@ -300,6 +301,15 @@ int fdt_chosen(void *fdt)
>>>>           if (nodeoffset < 0)
>>>>                   return nodeoffset;
>>>>
>>>> +       if (IS_ENABLED(CONFIG_DM_RNG) && !IS_ENABLED(ARMV8_SEC_FIRMWARE_SUPPORT)) {
>>>> +               err = fdt_kaslrseed(fdt);
>>>> +               if (err) {
>>>> +                       printf("WARNING: could not set kaslr-seed %s.\n",
>>>> +                              fdt_strerror(err));
>>>> +                       return err;
>>>> +               }
>>>> +       }
>>>> +
>>>>           if (IS_ENABLED(CONFIG_BOARD_RNG_SEED) && !board_rng_seed(&buf)) {
>>>>                   err = fdt_setprop(fdt, nodeoffset, "rng-seed",
>>>>                                     abuf_data(&buf), abuf_size(&buf));
>>>> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
>>>> index 4b22bb6f525a..8d70233fc08d 100644
>>>> --- a/boot/pxe_utils.c
>>>> +++ b/boot/pxe_utils.c
>>>> @@ -8,6 +8,7 @@
>>>>    #include <dm.h>
>>>>    #include <env.h>
>>>>    #include <image.h>
>>>> +#include <kaslrseed.h>
>>>>    #include <log.h>
>>>>    #include <malloc.h>
>>>>    #include <mapmem.h>
>>>> @@ -323,10 +324,6 @@ static void label_boot_kaslrseed(void)
>>>>    #if CONFIG_IS_ENABLED(DM_RNG)
>>>>           ulong fdt_addr;
>>>>           struct fdt_header *working_fdt;
>>>> -       size_t n = 0x8;
>>>> -       struct udevice *dev;
>>>> -       u64 *buf;
>>>> -       int nodeoffset;
>>>>           int err;
>>>>
>>>>           /* Get the main fdt and map it */
>>>> @@ -342,35 +339,9 @@ static void label_boot_kaslrseed(void)
>>>>           if (err <= 0)
>>>>                   return;
>>>>
>>>> -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
>>>> -               printf("No RNG device\n");
>>>> -               return;
>>>> -       }
>>>> -
>>>> -       nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
>>>> -       if (nodeoffset < 0) {
>>>> -               printf("Reading chosen node failed\n");
>>>> -               return;
>>>> -       }
>>>> -
>>>> -       buf = malloc(n);
>>>> -       if (!buf) {
>>>> -               printf("Out of memory\n");
>>>> -               return;
>>>> -       }
>>>> -
>>>> -       if (dm_rng_read(dev, buf, n)) {
>>>> -               printf("Reading RNG failed\n");
>>>> -               goto err;
>>>> -       }
>>>> -
>>>> -       err = fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, sizeof(buf));
>>>> -       if (err < 0) {
>>>> +       err = fdt_kaslrseed(working_fdt);
>>>> +       if (err < 0)
>>>>                   printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(err));
>>>> -               goto err;
>>>> -       }
>>>> -err:
>>>> -       free(buf);
>>>>    #endif
>>>>           return;
>>>>    }
>>>> diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
>>>> index e0d3c7fe7489..ea5c07d729cf 100644
>>>> --- a/cmd/kaslrseed.c
>>>> +++ b/cmd/kaslrseed.c
>>>> @@ -9,33 +9,16 @@
>>>>    #include <command.h>
>>>>    #include <dm.h>
>>>>    #include <hexdump.h>
>>>> +#include <kaslrseed.h>
>>>>    #include <malloc.h>
>>>>    #include <rng.h>
>>>>    #include <fdt_support.h>
>>>>
>>>>    static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>>>    {
>>>> -       size_t n = 0x8;
>>>> -       struct udevice *dev;
>>>> -       u64 *buf;
>>>> -       int nodeoffset;
>>>> -       int ret = CMD_RET_SUCCESS;
>>>> +       int err;
>>>>
>>>> -       if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
>>>> -               printf("No RNG device\n");
>>>> -               return CMD_RET_FAILURE;
>>>> -       }
>>>> -
>>>> -       buf = malloc(n);
>>>> -       if (!buf) {
>>>> -               printf("Out of memory\n");
>>>> -               return CMD_RET_FAILURE;
>>>> -       }
>>>> -
>>>> -       if (dm_rng_read(dev, buf, n)) {
>>>> -               printf("Reading RNG failed\n");
>>>> -               return CMD_RET_FAILURE;
>>>> -       }
>>>> +       printf("Notice: a /chosen/kaslr-seed is automatically added to the device-tree when booted via booti/bootm/bootz therefore using this command is likely no longer needed");
>>>>
>>>>           if (!working_fdt) {
>>>>                   printf("No FDT memory address configured. Please configure\n"
>>>> @@ -44,27 +27,13 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const
>>>>                   return CMD_RET_FAILURE;
>>>>           }
>>>>
>>>> -       ret = fdt_check_header(working_fdt);
>>>> -       if (ret < 0) {
>>>> -               printf("fdt_chosen: %s\n", fdt_strerror(ret));
>>>> +       err = fdt_kaslrseed(working_fdt);
>>>> +       if (err < 0) {
>>>> +               printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(err));
>>>>                   return CMD_RET_FAILURE;
>>>>           }
>>>>
>>>> -       nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
>>>> -       if (nodeoffset < 0) {
>>>> -               printf("Reading chosen node failed\n");
>>>> -               return CMD_RET_FAILURE;
>>>> -       }
>>>> -
>>>> -       ret = fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, sizeof(buf));
>>>> -       if (ret < 0) {
>>>> -               printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
>>>> -               return CMD_RET_FAILURE;
>>>> -       }
>>>> -
>>>> -       free(buf);
>>>> -
>>>> -       return ret;
>>>> +       return CMD_RET_SUCCESS;
>>>>    }
>>>>
>>>>    U_BOOT_LONGHELP(kaslrseed,
>>>> diff --git a/include/kaslrseed.h b/include/kaslrseed.h
>>>> new file mode 100644
>>>> index 000000000000..3fe82f418acf
>>>> --- /dev/null
>>>> +++ b/include/kaslrseed.h
>>>> @@ -0,0 +1,17 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>>> +/*
>>>> + * Copyright 2024 Tim Harvey <tharvey@gateworks.com>
>>>> + */
>>>> +
>>>> +#if !defined _KASLRSEED_H_
>>>> +#define _KASLRSEED_H_
>>>> +
>>>> +/**
>>>> + * fdt_kaslrseed() - create a 'kaslr-seed' node in chosen
>>>> + *
>>>> + * @blob:      fdt blob
>>>> + * Return:     0 if OK, -ve on error
>>>> + */
>>>> +int fdt_kaslrseed(void *blob);
>>>> +
>>>> +#endif /* _KASLRSEED_H_ */
>>>> diff --git a/lib/Makefile b/lib/Makefile
>>>> index 2a76acf100d0..20a0242055fa 100644
>>>> --- a/lib/Makefile
>>>> +++ b/lib/Makefile
>>>> @@ -149,6 +149,7 @@ obj-y += date.o
>>>>    obj-y += rtc-lib.o
>>>>    obj-$(CONFIG_LIB_ELF) += elf.o
>>>>
>>>> +obj-$(CONFIG_DM_RNG) += kaslrseed.o
>>>>    obj-$(CONFIG_$(SPL_TPL_)SEMIHOSTING) += semihosting.o
>>>>
>>>>    #
>>>> diff --git a/lib/kaslrseed.c b/lib/kaslrseed.c
>>>> new file mode 100644
>>>> index 000000000000..ad06bee2b88d
>>>> --- /dev/null
>>>> +++ b/lib/kaslrseed.c
>>>> @@ -0,0 +1,34 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/*
>>>> + * Copyright 2024 Tim Harvey <tharvey@gateworks.com>
>>>> + */
>>>> +#include <dm.h>
>>>> +#include <rng.h>
>>>> +#include <fdt_support.h>
>>>> +
>>>> +int fdt_kaslrseed(void *fdt)
>>>> +{
>>>> +       struct udevice *dev;
>>>> +       int nodeoffset;
>>>> +       u64 data;
>>>> +       int err;
>>>> +
>>>> +       err = fdt_check_header(fdt);
>>>> +       if (err < 0)
>>>> +               return err;
>>>> +
>>>> +       /* find or create "/chosen" node. */
>>>> +       nodeoffset = fdt_find_or_add_subnode(fdt, 0, "chosen");
>>>> +       if (nodeoffset < 0)
>>>> +               return nodeoffset;
>>>> +
>>>> +       err = uclass_get_device(UCLASS_RNG, 0, &dev);
>>>> +       if (!err)
>>>> +               err = dm_rng_read(dev, &data, sizeof(data));
>>>> +       if (!err)
>>>> +               err = fdt_setprop(fdt, nodeoffset, "kaslr-seed", &data, sizeof(data));
>>>> +       if (err < 0)
>>>> +               printf("WARNING: could not set kaslr-seed %s.\n", fdt_strerror(err));
>>
>> I have used debug messages to better track if error happens. I think it would be
>> good if you can extend your code with it.
>> Because if this fails people have to start tracking if issue is that there is
>> RNG device or reading fails or issue with setting up property.
> 
> Hi Michal,
> 
> I'm assuming there is no valid case to have DM_RNG enabled and no
> UCLASS_RNG driver which is why I'm printing an error if it ultimately
> fails (vs a silent debug statement). If that is true then I should
> probably printf errors for all the cases above vs debugs wouldn't you
> think?

You can have RNG in SOC or you can have RNG inside TPM for example.
It means DM_RNG can be enabled with two drivers but spi/i2c don't need to work 
and access to internal RNG doesn't need to be permitted.
debug() messages are not going to production systems but having them rightly 
written can help with debugging issues without writing own debug messsages.


> 
>>
>> In v1 it was said that you won't update it if the kaslr-seed property exists.
>> I can't see this in the code. Or do I read it incorrectly?
>>
> 
> That was a question posed in the discussion but I didn't get an answer
> if that was what I should do. None of the three places I'm
> deduplicating the functionality from check to see if it already
> exists... they would overwrite an existing one. Is there a valid case
> where you would not want to overwrite it?

In production system very likely not but I can imagine that developers can play 
with it.

>>>> +
>>>> +       return err;
>>>> +}
>>>> --
>>>> 2.25.1
>>>>
>>>
>>> I realized I forgot a few CC's here. Adding:
>>>
>>> Michal Simek <michal.simek@amd.com> (board/xilinx/common/board.c and
>>> configs/xilinx* which have CMD_KASLRSEED)
>>> Andy Yan <andy.yan@rock-chips.com> (configs/evb-rk3308_defconfig and
>>> configs/roc-cc-rk3308_defconfig which have CMD_KASLRSEED)
>>> Akash Gajjar <gajjar04akash@gmail.com>
>>> (configs/rock-pi-s-rk3308_defconfig which has CMD_KASLRSEED)
>>> Ilias Apalodimas <ilias.apalodimas@linaro.org> (MEASURE_DEVICETREE,
>>> MEASURED_BOOT)
>>>
>>> Michal, I see that board/xilinx/common/board.c is adding
>>> chosen/kaslr-seed in ft_board_setup as well as some of the
>>> configs/xilinx boards enabling CMD_KASLRSEED - can we remove
>>> CMD_ASLRSEED from those boards? (ie no bootscripts require it?)
>>
>>
>> Based on my note above that you shouldn't change kaslr-seed if exists.
> 
> I can add that if you think it's the correct behavior, but that is not
> what is done in the current code.

yes I know

> 
>>
>> What would also make sense is to extend kaslrseed command to pass one more
>> parameter to pass which RNG instance should generate data on system with more
>> RNGs. Then pretty much with command you can choose different RNG because current
>> code hardcoded it to instance 0.
> 
> Do you mean extend the command or the fdt_kaslrseed function? I'm
> trying to obsolete the command.

I am fully aware about this.

> 
> I can add an index to fdt_kaslrseed but would it be more useful to add
> a udevice* that is used unless null? I can't see where someone wanting
> to call this function would know the index of a specific UCLASS_RNG
> device and not have the device * handy instead.

Think about system as I described above with two RNGs in the system.
How do you provide a way to select which one is going to be used?
Index 0 means the first device which is bind. What user should do if they want 
to use the second device? Resort DT?
Use RNG DT aliases or so?


> It sounds like with the question of not overwriting an existing value
> you are anticipating board specific ft_board_setup functions that may
> want to behave differently and choose a different rng source? If so,
> ft_board_setup is called 'after' fdt_chosen so maybe fdt_kaslrseed
> also needs a boolean to tell it to overwrite existing?

This sounds good to me.

It means pretty much if you can change it to

int fdt_kaslrseed(void *fdt, int index, bool overwrite)

where generic call will call index as 0 and if users want to overwrite it they 
can. Default value for overwrite is tricky because I can understand setting it 
to both values.


> 
> Are you open to removing CMD_KASLRSEED from the configs/xilinx* which
> have it? If I can get everyone's approval for the few boards that
> include CMD_KASLRSEED I would like to remove the command if we are
> doing it automatically.

I think command itself can provide an easy way how to inject kaslr-seed to DT 
from other RNGs but also your current implementation takes care about DT used 
for booting one OS. I am not playing with Dom0-less systems but I can imagine 
that there could be a need to inject more then just one seed for other CPUs on 
heterogenios systems that's why I wouldn't really force to remove the command.
If people don't like they can simply disable it.

> 
> (adding Chris Morgan <macromorgan@hotmail.com> to cc who authored that cmd)
> 
>>
>> Do you have correct dependency in generic code when MEASURED_BOOT is enabled as
>> was mentioned in v1? If yes it should be mentioned in commit message.
>>
> 
> Likely something is needed but I'm not sure if it's MEASURED_BOOT or
> MEASURE_DEVICETREE - That's a question I posed to Ilias.

Ilias was at Linaro connect. When he gets back he will likely answer it.

Thanks,
Michal
