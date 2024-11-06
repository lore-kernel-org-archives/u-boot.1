Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041D7D29FB3
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 08:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8870688DB1;
	Wed,  6 Nov 2024 09:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wbfIq7sT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 469CB88DB6; Wed,  6 Nov 2024 09:03:09 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F1AF88C4A
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 09:03:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCLFGDEIRUoGH5MUU29reloHFbVP9+agnOhhwQRVRAhN1HuIfWrQnrJLgT3F2a7L+dSTguMkit5r3S8T9ggnDn4t+aXawKQo/dA9Ypy8wG3ZE6WnO6B4wYwBJ9lxEDmQChOKz9TosWe+LiJNDUgUIDPhNjJfW7i+WURx9Q4l1MumvSXQmisej50x7lydquA6vRlD/nIHdcnPPR7LCAn9yK5h+lRtlaCGMqbHWwWEpVXXG4VhRZRe2SxRmkbrT9MNR17QNRgMnYPlAHC0WflDVCgYBdmgLJrp9BDCLlTx70+vwCSb8y5y2vM0Xjg018348eWce0bj1yUTDAAw+A02Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjVd4MIDTg6sXW7b0zK9PSuMmza8c4lcwfSZhRuhqpc=;
 b=QoBlqjxPtfvsCXvW552dmTxl7ka7lc0xP072Ex6JwnuWSD2BgNM3ds8OUIyhax6iF6I+cnir3Q1WCVsKGUTNGIEGW8d8edEUPW4d3ZqNwQhO2Hq2nBn1RY7mDgwxUStjZXxeiAgOxY03rHvQ7KQSddudX8QMYBL3uu+NTJFCOC72VKIQqCrlJsrB3GJpsKsKcQcdUMfuiXkBCwGVV9spJD8nceok/LJ1bqSGTOkhe72FMfIaPe8RCFpQdyd6hP9Zvk8hcgZ5V1Que1K3KcxKL4v+HPdWUx8Yuw4hNNoFDLm9bVum/rBtRGq3OeXqWYwS+5Jsct69eiiC2vc8xH4HQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjVd4MIDTg6sXW7b0zK9PSuMmza8c4lcwfSZhRuhqpc=;
 b=wbfIq7sThXssSL1RrAC8u5HMiMZiKwJ84K/+SX7x59HcvourQeJRGf3HoxpsjH4OLcJ/5Ne5/9iBy09hmgzYuZKvIQOnxQqYdcwRRkT6sUCAejDza1/ONsNrdY50tAKczJkvWgfQfNFef1BKOq+BHTnNsjIeK4hchrokLeu9P6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 08:03:03 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8114.031; Wed, 6 Nov 2024
 08:03:03 +0000
Message-ID: <d9c69634-026c-42bb-9d52-115ea325d0ec@amd.com>
Date: Wed, 6 Nov 2024 09:02:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Add generic function for computing ram_top
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: love.kumar@amd.com, Tom Rini <trini@konsulko.com>
References: <20241025172724.195093-1-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241025172724.195093-1-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0166.eurprd09.prod.outlook.com
 (2603:10a6:800:120::20) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: cecf0a94-f55d-4b9b-fb20-08dcfe397077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWtuMjFCYlREN3MzdUFNOFZPalZzbWovaWs3OE5QZDhvOEt2Q0ZMbi9XdWt3?=
 =?utf-8?B?Z3RwY3pGWXpMOHFsS3poZUlSTTJhZElkbTc3UEt3TkJLZGFVeXNZa05EcHp0?=
 =?utf-8?B?Ti9SM3FoeW5VbFprS1htNzB3dzNGU3FCZjBzT3BRT3RXSmpWS2tYaHl0MUFG?=
 =?utf-8?B?czh2N1dBRG9BOHh3UGZTQnVOVE9WZFJETE1yWEdHZFNPV3VwTSttSXFsV1hS?=
 =?utf-8?B?dTh5NU5GeHBoc1RoK215M245SVAyQzZRLzgyZ2NXbXVJckpsQm9ZTHRPaXBS?=
 =?utf-8?B?bDA3T1R2ZERON0lBZUNFelMxQWMzc1N2TW5BSFpCS21rU3NhZGREUnVMcklO?=
 =?utf-8?B?UG4ybVpISlY1emJsVnNzRHg4UVhLLzVtQUpJNnBKTEROc05JWGI5L1YwZVA4?=
 =?utf-8?B?b1JzTHdvS2tQZTU1U243UGx1ajdrdkQ4MEtaejgzeUZKRVE0akNOdnQ0M3g1?=
 =?utf-8?B?Ty9JRGc2dWFONm1ac1JNYjlHQ2VpTkpZeUFNQzZmQXdTakM1WVJlSVhTckVl?=
 =?utf-8?B?OG53WnZOaE1xRld2R1pDV3p6YytpcnN1WG5zT3Rqb0V6YWxLdWpHMVFCRGtO?=
 =?utf-8?B?UnNKbWZnMVlhN082V0phYUpUTnhEeWRDTHV0NytEeS8xbDhtUEpLS0FIMktE?=
 =?utf-8?B?Z0ZzelpleDlDWVJqUnNCYzQyR2V2dzQ1TFNSeVVpR0hzUXdqd3AwVVI5RVhk?=
 =?utf-8?B?NXU2cmtrM0VhdkQrMHR2ZlB2TDdENUwyY3kxTEZmbENiOCtYUHVVZnYrNTI3?=
 =?utf-8?B?bUdOWG1wNSttSFVGcS83dlNIUzFtSHFRMDlieFd3MURaeC9LbEJyQkhjNFZq?=
 =?utf-8?B?aTBBWkNIYnlBbjlBSHltU1hRS2FpN2tMRDhybEh3REtVZFkrTWhOanl0bVpG?=
 =?utf-8?B?MDZtMkgzV1RycVpmczNxOUJ0YUtSM3JqZURWZ25Bc2YvWU9rbDAyekNMMnJJ?=
 =?utf-8?B?emJWUlBWaFZXbk5zZ3lLUUU0K09BNlFMSzlRYkRKRUh3R3BwNG1PUVNHQjhW?=
 =?utf-8?B?NmVqcFpsU3lyazIxd0k0cDNKS0l0dnhzNTB2R3FmRXo0b2pEZWlUN1JibFJB?=
 =?utf-8?B?dEJENkJ4V2s5TUhhc2pEUHdEaFdZZUs2M3VvQWE2Qkk4Q1ErWnVSbFl2ZUdL?=
 =?utf-8?B?em9sS01Fb3ZPcXNuVmFkMEN1TEZjZko3aUNlNGFaUnhJNmVpWEgydGYydmFr?=
 =?utf-8?B?TkNkWmoyMzlRbENuTy94VHcxTmxoME4rYnJKamFVd1ZwQkxqRkdaTjhFUk0v?=
 =?utf-8?B?L3l3ZXJxQU80ZFRSZUZKZEZEVXFOYWJKUEpycHVScm1pUWJ6akk3Y2VuR09S?=
 =?utf-8?B?eHcxU3VYWU9DOWxFbHN5WXJUS1FWWnBTaEtnM0ptRkg3UmJiUm41ZVp6b2lK?=
 =?utf-8?B?WjZEaFpIV0UrOTY1WjZIY1VYY3k2NzAvSXU1UkMxNFAxblhxNWtNMTNjSDRV?=
 =?utf-8?B?RVJVVkpMbkJIak1RVW8rZk9XK2NIT2hVZTBjTHlTNjltdVFRYWx2RHN2SG5H?=
 =?utf-8?B?dzNRL3k4RGwwUzkyWWcyMS9nZ3JVTkRKeldWU0VmempJQjhxYVR4UUFadGMx?=
 =?utf-8?B?NDd3T3hSSjRmZmZ5K1RrTDR3OTg1dlFja1ZlejBja1VCTUpnWGNOYXd0UE9S?=
 =?utf-8?B?dU9QQ0piT0FtN3pvMm9LNFE2dWhPcllGVnNYMS9TSGNiclFjOVh3eWp1UVhM?=
 =?utf-8?B?S3lCZTRCOUJSbTk2UCtPK3FDN2doaVg0VkQvUnU5Y25hdGZhMnF0OXBPZnNj?=
 =?utf-8?Q?0fDokMnY4zfHT/XTyMF2jg9bkAQx9St5I8YZs7F?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1M4VjMyajdMd1ZVb3FKd3ZaZzZORHFmZXJoNDBNK1JZMVUyRTMyNmpwR1FR?=
 =?utf-8?B?UC8xL0lsK2NxdERGRU9LQWRkeVZLckRrT2gycEd2UEhkbWZNSVNIYlRISHVm?=
 =?utf-8?B?aHlsaEZTT3VsczB0QS8vcXh4bnJ1SW9lUmFlOE9UTS9qTzdZOE45cnZXUGta?=
 =?utf-8?B?eXl4MUwrd25HM24vR29mZHN1eHNFS0N1QWpNdDlxajYrelRtM1pJYXlnc3lC?=
 =?utf-8?B?LzBLWVNsZ1g0QThTUUNpVHc0ZllSUGRHb3JGQTFORWlPdEt5b0FTaTNNOG1v?=
 =?utf-8?B?YllCTzR3Vk96L1BKWUxacC9IL1RDenJJbFF2L3BTV2pXN0N6L1V2OTVDa0FE?=
 =?utf-8?B?Z1B2M29wT0Zlelh5cTgzUVZDdmx0Z3dHS01tdHdoTjhndEJHL21zeFRuT2pR?=
 =?utf-8?B?MkN1SlFJMXNmTSs4SWVwKzNoOFRJb3hEYTFEU2FPUnAvOVJnek9vTGV0MXNw?=
 =?utf-8?B?T0xmWjVjRDNua1F5Y2Vob1FuUUFEdmpya0lRMjlWbjFNTnZWSDVOQWVpVFJk?=
 =?utf-8?B?Q0MrV1B3U2FoZW5tc0RRSXZiMlhyVzB1TzJuSnBtb0VwVkJpL08rOFhnTG45?=
 =?utf-8?B?ZlRSamozL3dGMVd0ZktHc1dlZk1YK3pNV2dMYnc2T3NBS1VIaVVwZnNBbE4v?=
 =?utf-8?B?bEJNdGdiL1lSMHBvTUVsMi8ySkJIY3FQa0YyYkxTYkF5VHRieWQwWXdqZ3Jp?=
 =?utf-8?B?UnY4OEpWYVRWdURoV0dIUU1xeUp4WGlXTFpYaWh6bk5aMFp4eEkyWFdUb0d4?=
 =?utf-8?B?RGpmMFNvNEpmT1ZQd1BEQmlCa2M4dytRQitncHZheGpGRUpsbDRRcXpjclp6?=
 =?utf-8?B?M0hyRFFIVVJiNE1ROTlHWi9lVGdNQjl3S1BNVlVKTytPZmN6K1R2MVdWZmpL?=
 =?utf-8?B?SUVNTFpjT3Z0MGZXdTVScyswWHdRWFFxbDdNVDFjMjZrSDg0SnZnUU5GNEpm?=
 =?utf-8?B?ME1YeldOSlZ2NkRHUWF3S2kyT0tYZTNyYUtxUTV3SzVmNTBpNTlZaGFpN3Y1?=
 =?utf-8?B?bEIzUkllL0syNE90RFhITWdxU2Q5NDE0Z2RRcDlaR0ExTHd4a2lSVGxOTlhW?=
 =?utf-8?B?WEVJNkd1aXFlMS85MjFONTNMcWhuTEVoaHp0a2x3eUIwdkY1TUZqcWVtSXYx?=
 =?utf-8?B?KzZ4NEhnYTU4WStLeEQ3TGFyMHB1TUY4SjBLdHpWbXZIWGo5OStJVHhua1FQ?=
 =?utf-8?B?ZmVVNmtSV3hZV2hoVHVnaW1nVS9SYlZsa1lzd0Rpb29JZ3RiajNyZTJLTU9z?=
 =?utf-8?B?VnZCWWg1VjM5bzVUZTlqSWQwUkgyTWJLeHFFTGJBVzF2cVdVeXVwZThzeWhN?=
 =?utf-8?B?Lzk1WnFNRW82UXVJeWY2ckh2Y1RydVZFZkY1bStqbHNGZFcvM1VWdHU1amFt?=
 =?utf-8?B?OTE0bnN5R0VJcUFXUjY3ZUo4NlpNdmFwQXBIZGdaQWZTRHVwQXpRdlh6UkRQ?=
 =?utf-8?B?T3NxN1l4MHpnSVlET3pQK05rRXR1dEdUb3NaellERjVnUDlVb21DTjJMa3ZO?=
 =?utf-8?B?RlRtT3pIb281Uml4NGZIWmpsaTNHd0pLV0RqYlgyclRGYlVkYjdtNHRGR3ZP?=
 =?utf-8?B?TE0rdUJiZUp6ZVN1WTZXRnFWcVZha1pzamRlNkpvMWFrZXJmVGRTQkE2OFMw?=
 =?utf-8?B?bnM5anB1dURSRmlSUUdGSUdTNUZNOXUwT1dkTGVaL2NGT3E4ZGFpN1h6bGNM?=
 =?utf-8?B?VzNDWXdHYW5OS1NMcStaaUx2cHh3QWNzR0pQUklMWk1XTU1jMU9PNzVJVzNl?=
 =?utf-8?B?TUdyRFpnTkUvei9aYU4zUlplZ3ZpeEcwbDhPSjh0a0hUNmo3RVFYMFg2alJh?=
 =?utf-8?B?WEZNUEtoRnpYQjRRV0t2eTNsQWRNNmVxREpZai9PQkRoL0V3eWEvZnk3WDV6?=
 =?utf-8?B?K25BL1RvRGdsYWdRQlB1ak9nL1duOHI0cmIwMnE2cHk4YjhCM2E2dmY4WEV4?=
 =?utf-8?B?MXloMFhpNWdCNmtmQXFXTGZJaENENFVtWE1Jdy9XMDJ3bFlhUzBEaUFYb1Js?=
 =?utf-8?B?K2FVSjgzYTZxQ3BLM08relBVaVJhYXVLV2tDYnlRWHdWeGhsOWpLWE1pbkZB?=
 =?utf-8?B?RjNodDV6OVNkV2VSbDNxdHN5dnE0bGJPK1puRXZrZFE5NjNRSkZHTlY2eG5X?=
 =?utf-8?Q?E3ySy1dkXQLSBqmeGLRiK/bKj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cecf0a94-f55d-4b9b-fb20-08dcfe397077
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 08:03:03.5730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkw93dtQTgUJiTX+3Gxk3Hai0OwMgFaAUiJp8fJN0CgPQIm9RzfiXDaWMYEwfb+i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740
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



On 10/25/24 19:27, Sughosh Ganu wrote:
> Changes since V1:
> Remove the comment above the function definition
> 
> 
> Sughosh Ganu (2):
>    common: memtop: add logic to detect ram_top
>    xilinx: use get_mem_top() to compute ram_top
> 
>   board/xilinx/common/board.c |  25 ++++++
>   common/Makefile             |   1 +
>   common/memtop.c             | 171 ++++++++++++++++++++++++++++++++++++
>   include/memtop.h            |  22 +++++
>   4 files changed, 219 insertions(+)
>   create mode 100644 common/memtop.c
>   create mode 100644 include/memtop.h
> 

Applied.
M
