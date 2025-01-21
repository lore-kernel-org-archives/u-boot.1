Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3293FC02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 13:11:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8C8B805C5;
	Tue, 21 Jan 2025 14:11:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X3ohjclf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C47D80763; Tue, 21 Jan 2025 14:11:16 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63CE580326
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 14:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTvxQVj2HrUS2pG8k2Qdtcl7uOPnjxDZDccEMXSZbjhafxbIHEis2ayQ/RTf0GURV7mR6h3lhPhnZ/PRhPdUpK+6N5kTASiLhIDX6Sp7ZI/RVSplv/mvVmLsBUUXWv3Ia43ECnvCwXIIXjKoqD9JsquyhRByL9MZIcLG8Fcf8PZucPNWWQUv1QSX4hqp4DQhuAgu/Rz92Z+86E+3+4YtSWYuIvbrMLhk7xwOse3jDDMHnjMYWtGrETaKmY88kZ6AU6IEoCw6GzFTNjenYedMRNKfURHJvvEUI6Kyw8vqWr5RSD+6T0jf5dT8J4Qx2YV7qDTM1jz9v9x/ZHL5A27iog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zd6aPlKjezxN0CJXL5DRIiUd77E2zvTgRwrvjNjPfyA=;
 b=iMY/EUkBzoAl+T0XH1Ez39ulp6p6A+LDWLS4aRfj74O3vGoz4dIRqsgFkynpVQWZ7KesqfvyIlmTstg0cOzKnhcATnWcKbMiD4BpJZe38stejZ8y8oNFkkX79sqZOAsUS6hclze8zF0oScat+gHvEc8vbov+tCRd8opY1WVq1h40kVJY/063w2Y09sCJHUHWNmiTnfqgDdNtQ2wLDfiJvvI8O2ZR3mQn0RGU2IXI3e8cfpi4aNYATmcX6Ff7cne1pqdDUaHdFreMeRvyP/j+N4W3ji2uM0X56ZBN8xjGxE/UaVAK0MQQfFv1h0YEzs8YnxfNi8PWW8rvZdTduwge+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zd6aPlKjezxN0CJXL5DRIiUd77E2zvTgRwrvjNjPfyA=;
 b=X3ohjclf4zZh8PeshGlm8Hgz6HLf/F8ml/3YECBvjNethhYv8fCCmJUXahpmGeJke93yZ7BjaqS1HpnQtnWQ0Wzr2SRnirIAe155wR3iEmfoQzk/ZTu4DXC6KOL/CGuHevPQPc8AKv+oe001OKZ4/FJnTuG1pAIT8GmpqAqJHAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 13:11:08 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 13:11:07 +0000
Message-ID: <3810ad10-194f-4e59-8abd-ad74b7aa9002@amd.com>
Date: Tue, 21 Jan 2025 14:11:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] net: phy: gmii2rgmii: Add support for phy ethernet
 id configuration
To: Tapio Reijonen <tapio.reijonen@vaisala.com>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250116054324.836712-1-tapio.reijonen@vaisala.com>
 <20250116054324.836712-3-tapio.reijonen@vaisala.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250116054324.836712-3-tapio.reijonen@vaisala.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0046.namprd11.prod.outlook.com
 (2603:10b6:a03:80::23) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: c94679a0-5723-4304-99dc-08dd3a1d116c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3U0dThqU3pLenFGcGxuSEIxU2JBZmFndXl0K1JYbzF3RkE1VTNzTmFZM1dp?=
 =?utf-8?B?WjYvajRhRWV3T2trTmo1ZHZtTmIxTlgyTmRQY0sveU1Wa1J5MnA5ZWNXeU9z?=
 =?utf-8?B?RndNVGlxK0p0MDlxYmt4azR0V0plYXBYTWNpckZPak16VG8zWmpRNUZreE0z?=
 =?utf-8?B?Yk1aMzJKdUxFVWlFalcrMkVhSVJXR2pQaVUrSGZ0a0ZBZzViQmJPQXREcVNB?=
 =?utf-8?B?RTVFTm83RUNYbkxRNHNhb0VnbXEwVFREWld1dzAxTlY5alZaVk95NFh1OXRH?=
 =?utf-8?B?dFhIVVVPWjhVdFppT0FQK2JzNGczV09pc1crTkdHVG5vc0FjTWsvRWxHUHNt?=
 =?utf-8?B?NHBPdFRESDByeElSWlJFeURSUHNacmxnMzJocjVwT1VvcUpsc0pNTmlWWk1s?=
 =?utf-8?B?ZlFRcWlIRmIzL1BMZlowaXg0cnlHM2w5RWUwY2JJSjFVczJEaDRQU08rclZE?=
 =?utf-8?B?Q2drZmkvZWVwZllMZlhrMnIzSzhDd3MxbUFvcHh3TFhZSHc0MllFV3lydTBm?=
 =?utf-8?B?YWJ5YXNqRDNPcSsvTUZPWXVWbW5kR0I0SjBVcERPQmtxLy9Tcm5kNmhTM3pN?=
 =?utf-8?B?UkJDOXFzSHN3NXFsOUY0M2NEc0dVZ0hlc2dwdnB1OEZYNmo3Smp5cnE0RmFv?=
 =?utf-8?B?NWhDT0VnQ000OXUvcWxTNU9zMmhkZHYzaDVFOVdxbm1WU0ZQK2NuYkNaY3U1?=
 =?utf-8?B?N0lwckU0RFR5UGExQmpOVzJ2SjJHVE1hbEtPd2xnRlJCSjZpSmNHeEN1NjhV?=
 =?utf-8?B?N2FjbFdUQTVHamFUQ2k3cCtMR3VKQ0lnbnpick5jWDk3MFVuUzUzam90Rmtl?=
 =?utf-8?B?MWNteG1xSkZqbGNpSEdmMFlIY0l5d2NpYVJsYkpIVjhqa3lhTmtYdjNQaVoz?=
 =?utf-8?B?VVdyYzVoT1ltU2JTN3RpejRCeVVGMWZNZVR5bVhXWDFBS0MrTE1sM1BIQTVQ?=
 =?utf-8?B?UEExc1d4VGpnVDNYU0JtTWNvU1ZYdU9zdVovYkNOMmtaaE9KNVZLSCtXaWR4?=
 =?utf-8?B?N3NqK0lpQTVqR2JtNlphcEJWdUVFbWo1ajlRZFFZZTVFU0pKK3NjRFBLbHV3?=
 =?utf-8?B?ODFlUXQvdDBtOG1tdE00WXJkRFlNN0VSeEhpYzdhekcxK2tiM1NmOWQxc3Jw?=
 =?utf-8?B?cVIzSjFuM1N5MEhmNXJNMUVuZ2hjRWQ5MHQreXpvQW1GV2E2MHdyUXRESm9j?=
 =?utf-8?B?TEJtN0VWZnBsZUc1TWpPMFo2emVxS0wwQWNRcndsRENxSDJsaVljQXpiQ0ZO?=
 =?utf-8?B?VDZaQ3JIN1lKamU0SmxRc05BbUxwcElTaWxkTjZhYTFZaEIwbFllcTNPRm1U?=
 =?utf-8?B?U1JMbWV6RWhudHN4aVdGSXlLSjEvTlN5ZGJOQ1N6Y3k0M1pDK1lBRU5lRFNQ?=
 =?utf-8?B?WVN2MG5IWlo4UWxuWkFKSEhjdDVNdVBHd3JmVFZwa29pT1M2MWtBQ2FaeFZy?=
 =?utf-8?B?M3VrWmtNU2ZiSGxGR2M1M3pXbnZVL1B4VWhWRStHeUhZTDBhMXVTUGtQR09i?=
 =?utf-8?B?TnN1OVQvK1RhVnVDVnJNejUyV0VXaEpoRFB1b0hYQXAvTXMyVmhyTkx2K0ps?=
 =?utf-8?B?d3RTNjZWZWtGMEtxODVGU0xLaGs5NU43SGJtanhlNTJ3WExLNWRPY2RoaWcz?=
 =?utf-8?B?dDU1MERTSkNnZ0NCeVM4ZWd6cEppZHY4VVJFYUs5OEt5VVduRlk2MnQrTVlM?=
 =?utf-8?B?OHQ4MC93bm1sa0x1QXo0dFlZSFk3bjdkV2hBRWVCcVJSTDhtVS9oZEs5YU10?=
 =?utf-8?B?MlprRk1lZFNsRE1uUkIzRGZYNlA2M0tRVU53TGZWL2hhMTVpaXJYVHVQUlNQ?=
 =?utf-8?B?MllCOG1VbnBNM3RvbW9kQjV4VW1iZFMyWStzRG1oTVBOTlBBSHhJdEpLOExR?=
 =?utf-8?Q?0qeIfrak00jx4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE9TZllFWGlsSnlsOUp6aExoSVNLSzkzaUZkMVNmdGdNaDdlQXpSVFlOVGhZ?=
 =?utf-8?B?VG9KMFQ2WXFnL3JSK1dDdmVPMEdzdHVFMXZWNFNZVHFCaW9CcHN0TWIrNFl4?=
 =?utf-8?B?OXN4bUNacFlNT0VOdGlKclZGdlh1RmVaSnZNTU1UUlgwdnc2Z0xuejdoNlFr?=
 =?utf-8?B?QjZwYkkyZ011ckZIY1gwdVRqVFVibGUyZGxDQUM5NTd3TllUU0VKVDYzQkF3?=
 =?utf-8?B?cklYQjQ0UWkrYkkvek1PMVNiS1VUdFpXcDhoWVRwZWxqeE03TWRETUE0Ujda?=
 =?utf-8?B?cFBwZVE0Z2MrQkpRS0dUU1RVRGszMllTWGdIc1Bpam5jbWZWM0tKdXZTeU43?=
 =?utf-8?B?MmtQQ2dOOTJOVWdYZk1mNmhNb3BDczJsb0hGdjF5c3dUMUJYUUMzZ3ozN01V?=
 =?utf-8?B?b08rSWYyMXRCaHZad3psbm9ZaDM4VHF1SEhFeEFLa05tbWpoWW1WeEl6NWht?=
 =?utf-8?B?aDIyalh2RGFRM2tsa25kRmYxdVE0czRxaWNVbmcwVjIvRlNYdnlsMi8zb3U4?=
 =?utf-8?B?K0kwbVlrWHA5UTZsaEM2b0R4Y2lwU2hKUHBWMXNQSHZFQ1pvSHRYNVFqNWJN?=
 =?utf-8?B?L28wcjJNTWUvNkJRZEsxZlduK1NCK1pNNVlXNkM1cHJhNUhIZS91di9yR21o?=
 =?utf-8?B?S0pLRHl5MzFkWVJjKzFKSXdJdHRuVnk0TFF6YnJGQ1YwRFVTQWhNYWRXODds?=
 =?utf-8?B?RVpMalV2cnBXdnZ1L1pLQ1JRQjlqdFpUYUZ3OENLdUY2N3lsR0k5VkdIdXR1?=
 =?utf-8?B?bTEwbGZBVXVpRm53SUNRZkFLRnY4d0RaQ2tVZVNyKzdxZVJqbUMvVmVxT0dp?=
 =?utf-8?B?UVBBc1Q3TUZvME9WSDMveVZNWnp1ZWlTUW1DaXYvZ3I4dEZXT21IckkyNm1h?=
 =?utf-8?B?V0VobHd0QU9lSkpHRGRxdGhyU1VQMDZ5cFBJUDBuQVUyWVI1cFlVbDhZM2xJ?=
 =?utf-8?B?bXQwYkxsaHIwZ3l4YUErTjBjVnM4bDVibHdpNURMSitTOWdDQlp5WGsvYXl2?=
 =?utf-8?B?UDgvZW4wSlNxQ3lwMno5N0JxZWp1TlFOdlN0NGtYOC9YM1I1UWlnU3NTNjZo?=
 =?utf-8?B?M2lJQkZUQ2NmblpoOGh0UDZyeXVyMGpGaGV5NVYvdGpZUHlGQ28zTzRSa3Iv?=
 =?utf-8?B?Umk1NGxKeVcrNC9VOU90UnVhTkF6cHhFZFJIRDFWRk5pZTdvekZQK1BkeWsx?=
 =?utf-8?B?LzloSkF1aDJ3b20zN1I3N28xazA4dm16U1A2aDJtN3JHTVdaOTdvNEpCcXEr?=
 =?utf-8?B?RkNSRTBjU20zSTdSQkJGUmhmS1pGWTVqRUhiNkIzQ1BhOXFhV0Y0NmVXaytq?=
 =?utf-8?B?clZ5MUxhbHRtYk1NUlFtVXkxN0QwMGpqZTdwNTA1SmMxYVRVUEd5aWk3U2lj?=
 =?utf-8?B?M1hxR0hXOWwva1R5NEhJRytoNXdmNnVYZU9vQXl4SzZvelFsWVdXelVuQ0dj?=
 =?utf-8?B?QlZCbzI0OTF4Y1ZKaWNsald2eVBmN1BVc3FqWlA0WEFMUHRvbThJNDNXclpx?=
 =?utf-8?B?cUxJT0FTdk1pZnRZZXkwRVd6eThkYnd4cEc0ZWlOREtieVRtaHFDSnUzNWpN?=
 =?utf-8?B?V0JMem9TK3ZKU3l4K3VoNGpVbEMyN3QzbmlRaE5teVptbmRFVDZ5TkNkZVdN?=
 =?utf-8?B?b3ZvL2tnNVhURGNyb0hRWjBib0g5a1NsY3pMQ2twUXhsM29DOXkybEFQcnEz?=
 =?utf-8?B?aUZvazVUeDZ1OWNBOE9CbWRFbm85eWYvSnJSRWgrdlVCSjh4RCs4ZExQenNF?=
 =?utf-8?B?NHJ6dFVZVzdGc09KbVFvYnlQM3QzRmtlTmpTd2RTWkIrblNMN1dYV2pSeXls?=
 =?utf-8?B?ck9aVUxlYUF4WkJOK3E4ZjUxWEpZYmo0MWlmQ0MwK1dqejlZUDU2d3FIbFB6?=
 =?utf-8?B?V215dVBwYkpXTmdGWXh1OENmNTA5dkZHU0w5UVZiTlBUK0FGV01ZUEhtaTUw?=
 =?utf-8?B?aFA4WlpBSllIQnZVL2tmYXF5NU9icVA2WHlRVGIxVEp0YmZmL1FkU05jVTNO?=
 =?utf-8?B?OW95NTB6YXg3WVloSDRpUlZEcXhuNk1ubi9vamtadFl0ejhQUG40T2huNnNK?=
 =?utf-8?B?S3Z4ZThtcVhhY2hsTGRuTnJCdDFncytnRkM5L2NKNlVUMnd0dy9RQ2RRSlNV?=
 =?utf-8?Q?bzGgWVANljkWiwA3pIoRPNIUp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94679a0-5723-4304-99dc-08dd3a1d116c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 13:11:07.7974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eM925iGxDjhLGHKnUJ/PEo44kWHb2+QBoAdqAkrGu8u04enmTcRwSB4sGP0Uda+2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166
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



On 1/16/25 06:43, Tapio Reijonen wrote:
> When Kconfig PHY_ETHERNET_ID is set, create external PHY using via
> ethernet-phy-id driver to support using starpping resistors

typo.

> of the external PHY.
> 
> Fixes: commit a744a284e354  ("net: phy: Add support for ethernet-phy-id with gpio reset")

Not correct format.

Please look at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n145



> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
> ---
> 
>   drivers/net/phy/xilinx_gmii2rgmii.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
> index e44b7b75bd5..1d6d204b228 100644
> --- a/drivers/net/phy/xilinx_gmii2rgmii.c
> +++ b/drivers/net/phy/xilinx_gmii2rgmii.c
> @@ -18,7 +18,7 @@ DECLARE_GLOBAL_DATA_PTR;
>   static int xilinxgmiitorgmii_config(struct phy_device *phydev)
>   {
>   	ofnode node = phy_get_ofnode(phydev);
> -	struct phy_device *ext_phydev;
> +	struct phy_device *ext_phydev = NULL;
>   	struct ofnode_phandle_args phandle;
>   	int ext_phyaddr = -1;
>   	int ret;
> @@ -40,8 +40,13 @@ static int xilinxgmiitorgmii_config(struct phy_device *phydev)
>   		return ret;
>   
>   	ext_phyaddr = ofnode_read_u32_default(phandle.node, "reg", -1);
> -	ext_phydev = phy_find_by_mask(phydev->bus,
> -				      1 << ext_phyaddr);
> +
> +	if (IS_ENABLED(CONFIG_PHY_ETHERNET_ID))
> +		ext_phydev = phy_connect_phy_id(phydev->bus, phydev->dev, ext_phyaddr);

Can you please stay inside 80 chars per line?

> +
> +	if (!ext_phydev)
> +		ext_phydev = phy_find_by_mask(phydev->bus,
> +					      1 << ext_phyaddr);
>   	if (!ext_phydev) {
>   		printf("%s, No external phy device found\n", __func__);
>   		return -EINVAL;

The rest looks good to me.

Thanks,
Michal
