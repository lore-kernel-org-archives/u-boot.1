Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BD2D0C603
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 12:33:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EA898902E;
	Fri, 25 Oct 2024 14:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sE+RllZv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CF748901A; Fri, 25 Oct 2024 14:33:32 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3251989060
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 14:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ovfx/ToxSUJqprsHFKNLa2prP4EiOv8Wcj4lu+CUNTQaphfvq8AstAnxO5zSnUM1e2KMp3zrnOo8FdNw4A7Gm+FQXtumDwrla140NeoeqLEinW29xRqF1rbf57ISZv2WW2quaQ+4YwNwhC7OI/lGW6sopiyHQYXZqSOF+60lM17bFRb5bev1vp1YfXGkFGxDpL5WIdULTJOAoH0LKUS+WgQJhl+BqQgxb4B9TkAUpTptMUO/auv4qwHyKqZxhkUuXgy4CZqvmI8BW0p+c4VjfsoXHQHVgGAMR8oUn2wRsgqBFakSVcFWAQU++BAUKQEpuHk79Gr6UdZSwCM3YdCeWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwYFfUfWQtmSBNyZiELg4GMhzAOcSostyf1qG4Z0K80=;
 b=yHofDq24CWT08wN92UbEs3F++Y0aFG8SESVsejpZekGzxKK+Whfuq2452upXWwQOVgJjXMqxRhE8BK0NIygDrQnju8IG9L31SgmHPcOs97M2K+fqh8iZyKCJp8ney/TM6V5dZqs3aVsSC/ptAJp0UQPX+AB/TaRVLcha9Pso2cHqAptGvMTUHI1aNOxhL4tz/uu3Kl6/rEfMqNSkK4+H3bhwwRw5croVEbZXNLhaXvX1Hd5G0aM3KHJe93jRtOAFrv3OB4uDTlP4joHo+URrqa9hL/LkupB+VFID8iJSqN4ueg43gsKK/eqGV7PF878npOkL6hs+oB37vRZrhx7RIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwYFfUfWQtmSBNyZiELg4GMhzAOcSostyf1qG4Z0K80=;
 b=sE+RllZv9FyIbEJWKZM7E7ccr/8P8XkWC21GvClCSCr65GwyYonJn/A9JU91+kD2CZ2VCdlDvkHqU0tjiV02QELXO5G/OF+CnfDm4v7ZMl7X4gxNXXL4pE5qvECHUxvL4+TIsL+Cjwq7EoFJxw0vN37kZjrKSvlcgt4QYkPaUBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 12:33:12 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 12:33:12 +0000
Message-ID: <c17206d0-857a-44f6-8830-b12bb25ba60e@amd.com>
Date: Fri, 25 Oct 2024 14:33:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] common: memtop: add logic to detect ram_top
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: love.kumar@amd.com, Tom Rini <trini@konsulko.com>
References: <20241025121547.181633-1-sughosh.ganu@linaro.org>
 <20241025121547.181633-2-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241025121547.181633-2-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0058.eurprd03.prod.outlook.com
 (2603:10a6:803:118::47) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c44670-faa1-4d6c-adf1-08dcf4f13073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alZncG9vQTFMZWh5bVQvQTJMZlZSSXRhdnFaM1YrOUpnVHU0VWhibmJSV2pD?=
 =?utf-8?B?K08relhIVWE3SktWaDk1aGNqMVJIbVhkaWY5TzAwNlVvT0pGK0NOaTZXSmd4?=
 =?utf-8?B?Y2hURFFweGpObzZubW1ZWk9zWmhWaFYxWm5DZTJzWlFCYWxFWTEveHFKRGpI?=
 =?utf-8?B?blR2RU5nb0xQMFJNOGlKSlJpOTdnRExUMWE2ZDBmTU4rdlZtY1habHpBeG9j?=
 =?utf-8?B?TU95UHhIQUgxWS9yaXFtUndkOWJ0R0IvMldwdk5QVEt1TzZpTWpieEhFQnJX?=
 =?utf-8?B?SDd5Z2kxUkQwV1E1YmRTQVRhekVBbWtKbHZOTDR1MzRpNTB1NUZXVncvc1Jq?=
 =?utf-8?B?ZjlqdEZsVWJVbWhPK0xqdENYM3ZNNVVqK0RtU1RhZnpUSXkzK3R3azBCQ1hW?=
 =?utf-8?B?SndSbGYrbnJqN2FDaWV4NE5veU9kOThOWGxWTjEwU0V5WjlVYU1JVEtGTStX?=
 =?utf-8?B?YjdGVmhuTWl5WldlN0xlbkVYMmFvK0graE5RN004TnNmQlNYSnVyUTRYUEhT?=
 =?utf-8?B?RU5KZXVxL0xsdFFLc3FWNXJLSXR6ckZjSFNIQUMzWXV6aU0yM1NqOFJRbUpl?=
 =?utf-8?B?UVlZMXJWK0YyMmVWaDZBa21IcnBOY053c043cmZua3g5MWZaNSsvYk5zKzZt?=
 =?utf-8?B?S0FUNUZNZCtacHVxUmdDRk5BUktOTGc3OXBKNkNhbnlMRy9mSktEUUlwakZZ?=
 =?utf-8?B?Ums2R0Zzb3dWN1o2SkY2cDdpa2Y1WU9hT3EyS3VBWWF6TjVnenpsUU0rZXZH?=
 =?utf-8?B?MnY4amt4dmk5SFd3aDhQZmxDM0t0a2RnY1ZLSXZic3Erc3dPN0ZzcngvanFO?=
 =?utf-8?B?NU1vQklFdVA5T1p5U3dIUHRQTHJ5WmNocDRiaER6Wno0UkhkRHkzMGJMN1pS?=
 =?utf-8?B?NDlZa3lwcVRSR21sSXVyVzc0dmdKcjVnRHEyYXhwaDlJa0dxcFRORjRQaThN?=
 =?utf-8?B?NS9lYjllazZ3eGVacy9qTlYwZlBaVXp5RllNeE92VkxVNEwvY0hMd041eFRo?=
 =?utf-8?B?YmdTWjE3RFdmK2hDZXUzcVJQdDFQVWFTaENyK3hLdUZjMTMzRFhxL21IVHU2?=
 =?utf-8?B?anFBN2w5TklTRVZiM3dDS09Fa1grMkgwSlZTb2Rld2w4ZWdoUlpOWDJ2S09w?=
 =?utf-8?B?MFRONStjakxJRktDL1ZDZTlqdHdqSVZheVhGTUxDbzVuSHh1QVdscFBSSmtC?=
 =?utf-8?B?bWdnUnVEM0NNd2lQYW51TGNnTitBa3V1L2dGZEplS2JmYUx5TjB3bHhXTjN0?=
 =?utf-8?B?b2VUaWlnaXF3MVZFU1RhVkN3UWtOY2ZmMVJSNXFGekRuK2ZvemFWdUNzdEo3?=
 =?utf-8?B?VEVSam9zL0RmTGFQZmZrcUpETTkybnZ4OTg0TkpHZHBTZ3JkQkNvTXRTYkxl?=
 =?utf-8?B?TWFUVXc2bHRTWGRaazE4dm1kTk03WGNnQ1lHZ3N5WExMY29hejNaWUd4UlZn?=
 =?utf-8?B?QnRkUUsxdnlOd2hWK2puZ3UrV1kzSzUyNDd0WTI1U3JuUFFjbDlkNGNlL2pE?=
 =?utf-8?B?Z2hGYS9JT3JZVVhOeFY5UWNZSjlSTkc1UUp3MkEzbEdnL1BIeVN2cjdFTUMv?=
 =?utf-8?B?NW9OdG11b2haM0N0a2NvbStMODNsVk16RlBQSnFXaWtqcmprak9DdG9wMlRt?=
 =?utf-8?B?MHg0VDNWQ0NHTCtvZGJnUkNmcGtsbU8wdXlWZ3NnNmdYMk1UL0F5WEJDb3Rp?=
 =?utf-8?B?MTVLZHkrZElTNXc3QVJyOWQ2bTNIbWxzbHN0RXlxTEU3b1dsOUl6cjFMbXA2?=
 =?utf-8?Q?C4CTasB2xMYe/bnncLflAFIlaakKsehxR/+IS96?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFFZOERRUkVmeUFncGRJbi9CWmJzOHBkaDhONTZMN2V6cEt0SVNjUC9vSkxl?=
 =?utf-8?B?UExaNXVYVHlRb3dXYUJ6TXJVK2t1RWllZGYraTlxV0NxT0ljVG1GK3ZIc2tC?=
 =?utf-8?B?aXFIUG5YWFFGWVZVajJOSlhrUHQrRFdWWWZJSHpIdmxaOVJRaW16SnhzYTdu?=
 =?utf-8?B?bmJ4SGhYaDVER0pnT3JzalBOTE04eDd5dGszQktHbFZ2d21vSXdaMHpvUFc0?=
 =?utf-8?B?REVzWWpvYXBnLzRyUzJ2RXkvVHFPdzVsbU91Rm40Z2FPcWErWUl3cFFGdjdE?=
 =?utf-8?B?MjlXSlo1NnNSMDFLdEc1a0cyS1JyUjRFWTlmVWJzSUNHV3BTb3BSc1piWU4v?=
 =?utf-8?B?ZnVjT3FOb0ZKZ1FCOEdVR1hWMXJLUko1M1ZCcXVEMno1SllYUXZGbktXVWV4?=
 =?utf-8?B?d1k2bDZBZDV0czI4NHR3b3o0djlGSE8rdm5SbzV6dWVOdHZOZ0tzQUFvalUr?=
 =?utf-8?B?MUd0RTNabVQwSkZOdFJJZXNkRVN5cEVrbm0zSjdWTm1Ua3Mvb2xWMytXU3Nl?=
 =?utf-8?B?M0RTYStnbFRRaXhUZ1FDZE8zNEZMajVhMXRSS2IwSEdkR0RvQnZRNnNMYUU0?=
 =?utf-8?B?Ryt4cnJmZzBXMVp0aEM1MkdEVWQ2NHZNYk8ycTk2MmVRNGloekliVkluaUxw?=
 =?utf-8?B?aks4Y1AwMGxmZUo2OGU5N2tXcDJrcnAxVUozV29YM1h2eDJnS0hyeWFoc2pD?=
 =?utf-8?B?YWRleCtyWkhERk9hYW9xcWMxR21yNzlYeWIxcUkyOHlGNEFnNmlqTE9pckIr?=
 =?utf-8?B?ZTFqM01qRERYc2Vha1h4Z0VjY3JsTUNiRVRQdWVPODN0Zlp3TFRJbU1wSnJ5?=
 =?utf-8?B?N296Z2VHWG5GMkU2bUU5UU1aSStOQ2F2NSt5c0dRNk5PNkp1aldLak9MYnIz?=
 =?utf-8?B?TW5NMFkraHh6Smh6Y0o2SzNFdldOaXNZK3RNZlNKZnQzQURKOWVlT0ZJb3hs?=
 =?utf-8?B?NGZ0Um10SkJuQWpBMGFBYzkxU1U2YXRvMjczWkxJNXgyeDZHbitjTEJvNEJv?=
 =?utf-8?B?Z1ZKVTZGbnBNV2hzZ0YwU1lEUXpCVHpBK3IzS3VEczNTRzRoMU5iR0NrRUt4?=
 =?utf-8?B?cnhhaGJFUEpCVXEra0cyU1pCeUw5Mk56aDVzVzlnekx2cW1ERGc1alBIZ1dF?=
 =?utf-8?B?ODdnSDRveVYrOCs2ZVVJYkFTQ2ZNNzdsS1A1VnVWUE1ZR0dLak1BM0N1L0Nq?=
 =?utf-8?B?d1V6aHpwRWtWZWI1bzVPVy9sbzRrc2lQZ3pDZWRBckhQTHM4aVVpY3FXQ3BO?=
 =?utf-8?B?Mmk4eXJxcU4zaHhyeW5Wb1ZrTkN5WjRaeWdiaUg3YzdiRVN3MjU5STFsZHpF?=
 =?utf-8?B?MHFVVGJKWmE4Nk1UODRMZExqaVhpTE9xcnkvWG1na2pNbzJNeUpNendxczlK?=
 =?utf-8?B?aEttM0wxanZXMGdmTm1oQ1F6TCtWUlFLQzVxZ3hYSFZKK3p4QUwwNmpRZjRv?=
 =?utf-8?B?M0JEY2p6bUJzbUdGTkFBeGhkOGtmcjZQaW9ubXFtU005aEM0YWpJS2VkeU8v?=
 =?utf-8?B?L25ubDRMM1BpWVlDa1VxYzBuazdSNmYyUUxrZ1NGUXYwUE51dXZmeHJ5endC?=
 =?utf-8?B?MGhLY1RJUWU0OHc1N1paSUNkYUozRmViMW5JcGxNd1B3OXhiemNEU1dWSUha?=
 =?utf-8?B?SGQ0VmVRSWpnRVQyTk5hOVMrU3hvQnBVT2xLNURqNjgzSFI2cWVrMm9qdHRT?=
 =?utf-8?B?MGdUVnNKbWhaNEtDVWU0LzlPSEJEWHFzSmtEVTYzL1kxU0JtbEo0eVVRUTAy?=
 =?utf-8?B?S0J1TEtEaFczT0JIMUh6TS9HcXN2ZU80b3lWTHZoeGUydHY3NXI2dWRXUm5I?=
 =?utf-8?B?U1RCU3VIaWxWcG0ySFBSWmVnVk9FWk5oc1gxbExyY01aVGFLeDFaVERjRG45?=
 =?utf-8?B?bjMwZ1pTeDkyZUcreWp2R0dJSjJyc25YTWhoWUJ2T1dIdy9tUXNNOUcvOEt6?=
 =?utf-8?B?S3FKbUNYSERBdEtVQ3o1VVRTQ3RNQnYyQktIVVJ6ZTZHNTZBTmVJQWVEemQz?=
 =?utf-8?B?M2tTTFk4YUVOaXI2RXlzc1kxRzhXeW1kZ2x3eDgyUElmSTUvN3Q1Zi9uMGI5?=
 =?utf-8?B?UDhSaEdVaWd3enRyQVpCc091K0VCNWxueWdCSGYrdW1PdEoxSjhaUnV0b1pq?=
 =?utf-8?Q?zuYFknOHrvdgA+ooY4Da46XQi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c44670-faa1-4d6c-adf1-08dcf4f13073
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:33:11.9382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9xvmFOdVnadZzIoTUQLXN6AvOjnCPOor5/QDPIRi2ig5veHNKpnli0blsXH59KT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507
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



On 10/25/24 14:15, Sughosh Ganu wrote:
> Add generic logic to determine the ram_top value for boards. Earlier,
> this was achieved in an indirect manner through a set of LMB API's.
> That has since changed so that the LMB code is available only after
> relocation. Replace those LMB calls with a single call to
> get_mem_top() to determine the value of ram_top.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   common/Makefile  |   1 +
>   common/memtop.c  | 186 +++++++++++++++++++++++++++++++++++++++++++++++
>   include/memtop.h |  22 ++++++
>   3 files changed, 209 insertions(+)
>   create mode 100644 common/memtop.c
>   create mode 100644 include/memtop.h
> 
> diff --git a/common/Makefile b/common/Makefile
> index 2ee5ef9cc6e..35991562a12 100644
> --- a/common/Makefile
> +++ b/common/Makefile
> @@ -7,6 +7,7 @@
>   ifndef CONFIG_XPL_BUILD
>   obj-y += init/
>   obj-y += main.o
> +obj-y += memtop.o
>   obj-y += exports.o
>   obj-y += cli_getch.o cli_simple.o cli_readline.o
>   obj-$(CONFIG_HUSH_OLD_PARSER) += cli_hush.o
> diff --git a/common/memtop.c b/common/memtop.c
> new file mode 100644
> index 00000000000..579daa89136
> --- /dev/null
> +++ b/common/memtop.c
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2024, Linaro Limited
> + */
> +
> +#include <fdt_support.h>
> +#include <fdtdec.h>
> +#include <memtop.h>
> +
> +#include <asm/types.h>
> +
> +#define MEM_RGN_COUNT	16
> +
> +struct region {
> +	phys_addr_t base;
> +	phys_size_t size;
> +};
> +
> +struct mem_region {
> +	struct region rgn[MEM_RGN_COUNT];
> +	uint count;
> +};
> +
> +static void add_mem_region(struct mem_region *mem_rgn, phys_addr_t base,
> +			   phys_size_t size)
> +{
> +	long i;
> +
> +	for (i = mem_rgn->count; i >= 0; i--) {
> +		if (i && base < mem_rgn->rgn[i - 1].base) {
> +			mem_rgn->rgn[i] = mem_rgn->rgn[i - 1];
> +		} else {
> +			mem_rgn->rgn[i].base = base;
> +			mem_rgn->rgn[i].size = size;
> +			break;
> +		}
> +	}
> +
> +	mem_rgn->count++;
> +}
> +
> +static void mem_regions_init(struct mem_region *mem)
> +{
> +	uint i;
> +
> +	mem->count = 0;
> +	for (i = 0; i < MEM_RGN_COUNT; i++) {
> +		mem->rgn[i].base = 0;
> +		mem->rgn[i].size = 0;
> +	}
> +}
> +
> +static int fdt_add_reserved_regions(struct mem_region *free_mem,
> +				    struct mem_region *reserved_mem,
> +				    void *fdt_blob)
> +{
> +	u64 addr, size;
> +	int i, total, ret;
> +	int nodeoffset, subnode;
> +	struct fdt_resource res;
> +
> +	if (fdt_check_header(fdt_blob) != 0)
> +		return -1;
> +
> +	/* process memreserve sections */
> +	total = fdt_num_mem_rsv(fdt_blob);
> +	assert_noisy(total < MEM_RGN_COUNT);
> +	for (i = 0; i < total; i++) {
> +		if (fdt_get_mem_rsv(fdt_blob, i, &addr, &size) != 0)
> +			continue;
> +		add_mem_region(reserved_mem, addr, size);
> +	}
> +
> +	i = 0;
> +	/* process reserved-memory */
> +	nodeoffset = fdt_subnode_offset(fdt_blob, 0, "reserved-memory");
> +	if (nodeoffset >= 0) {
> +		subnode = fdt_first_subnode(fdt_blob, nodeoffset);
> +		while (subnode >= 0) {
> +			/* check if this subnode has a reg property */
> +			ret = fdt_get_resource(fdt_blob, subnode, "reg", 0,
> +					       &res);
> +			if (!ret && fdtdec_get_is_enabled(fdt_blob, subnode)) {
> +				addr = res.start;
> +				size = res.end - res.start + 1;
> +				assert_noisy(i < MEM_RGN_COUNT);
> +				add_mem_region(reserved_mem, addr, size);
> +			}
> +
> +			subnode = fdt_next_subnode(fdt_blob, subnode);
> +			++i;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static long addrs_overlap(phys_addr_t base1, phys_size_t size1,
> +			  phys_addr_t base2, phys_size_t size2)
> +{
> +	const phys_addr_t base1_end = base1 + size1 - 1;
> +	const phys_addr_t base2_end = base2 + size2 - 1;
> +
> +	return ((base1 <= base2_end) && (base2 <= base1_end));
> +}
> +
> +static long region_overlap_check(struct mem_region *mem_rgn, phys_addr_t base,
> +				 phys_size_t size)
> +{
> +	unsigned long i;
> +	struct region *rgn = mem_rgn->rgn;
> +
> +	for (i = 0; i < mem_rgn->count; i++) {
> +		phys_addr_t rgnbase = rgn[i].base;
> +		phys_size_t rgnsize = rgn[i].size;
> +
> +		if (addrs_overlap(base, size, rgnbase, rgnsize))
> +			break;
> +	}
> +
> +	return (i < mem_rgn->count) ? i : -1;
> +}
> +
> +static int find_ram_top(struct mem_region *free_mem,
> +			struct mem_region *reserved_mem, phys_size_t size)
> +{
> +	long i, rgn;
> +	phys_addr_t base = 0;
> +	phys_addr_t res_base;
> +
> +	for (i = free_mem->count - 1; i >= 0; i--) {
> +		phys_addr_t rgnbase = free_mem->rgn[i].base;
> +		phys_size_t rgnsize = free_mem->rgn[i].size;
> +
> +		if (rgnsize < size)
> +			continue;
> +
> +		base = rgnbase + rgnsize - size;
> +		while (base && rgnbase <= base) {
> +			rgn = region_overlap_check(reserved_mem, base, size);
> +			if (rgn < 0)
> +				return base;
> +
> +			res_base = reserved_mem->rgn[rgn].base;
> +			if (res_base < size)
> +				break;
> +			base = res_base - size;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * get_mem_top() - Compute the value of ram_top
> + * @ram_start:	Start of RAM
> + * @ram_size:	RAM size
> + * @size:	Minimum RAM size requested
> + * @fdt:	FDT blob
> + *
> + * The function computes the top address of RAM memory that can be
> + * used by U-Boot. This is being done by going through the list of
> + * reserved memory regions specified in the devicetree blob passed
> + * to the function. The logic used here is derived from the lmb
> + * allocation function.
> + *
> + * Return: address of ram top on success, 0 on failure
> + */

There is likely no reason to have documentation written twice.
Using in just header should be fine.
When this is fixed feel free to add

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
