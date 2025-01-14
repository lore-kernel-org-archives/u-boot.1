Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3D2E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 07:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C155F806CB;
	Tue, 14 Jan 2025 08:38:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c+u/y7sO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67AD4806E8; Tue, 14 Jan 2025 08:38:31 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AD5A80619
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 08:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYKDKNUXwdt6i313VY6eez2iaQjEXhBbhZuYThVDY1o7wvz2Fj4UTAZYbjFgjw+CaYjPUS/0IjE7x1qE61IOAXQ5LqshS2vQ3sQxzG+/4B2iTzbFFZrlXw0MpwLi2BS0eZcbQLVJqGqKNpk8NPVrs/PKk29ftvx+KTzMtQJBA/Db2aNS5kuEJXTtUG0NDKPS2R1uvzRbSzoHoLwOQtxJjpn+rYGbwGSMkT1wie3TLdrKJAvRSCEASqQdhMRULTB2JcLqir49M5Dzz6v9rMJ6ygLqnUqGoCqpDwNVGwg880OZ1qDWNM9cNhYMlhju1Por62IzY20s+HYVOzKxHeyqxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbydlabhkK1O4Nxwgp2zEmeXY9mUQXUThT0o52kpgmk=;
 b=a9IX3GTp6X044BqDwGcYNQqSz723KVcQKWHa1E2ZM05FTr9a7mJxgdyDBBhSO3HpshjHHnnXyhcMYGb2bP1f5/GyJVcGPhJOzTh6HoQ3C6HsytpYlITLSbGyVvI32LD0JmMeOf22+vOn9Yu1t6KXxuJqaM5azBJcB2awEPkNgFtmHfyK+k6zsQLEFp8B7IaaRtYk6nCwTAe9g4/wUJFgBFJ1flhjzLKssyTdTX7m5Flm8zoCe5vu2fXit9neGSusPTEVEwn47hjCEka42YQykMyXs+szWcF0Kah4CnZan9lxE5fl6OeHCiWWP0jQfmV9iN2OoNngcPXcPsiRLQhKnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbydlabhkK1O4Nxwgp2zEmeXY9mUQXUThT0o52kpgmk=;
 b=c+u/y7sO6b5Kw5qtD/zUWIfEjES+alPqoDS+6LHIQFpJ0lqGad60aP0nl/Wu955hzMOU6BgyCqCcPWN27BPL5AjxaeO3oD/OPGt8Ux/UpkSLOTUWPJbQajVGJRhYCPYO/BfGRBY92P/J4RQRLjp5x4D9LGxS/+qdSZANAsbP86g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Tue, 14 Jan
 2025 07:38:26 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 07:38:25 +0000
Message-ID: <d2ae2c87-8c0c-4496-8767-1ce5b28fbfac@amd.com>
Date: Tue, 14 Jan 2025 08:38:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtc: zynqmp: allow on Versal architectures
To: Vincent Fazio <vfazio@xes-inc.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Vincent Fazio <vfazio@gmail.com>
References: <20250107162044.195633-1-vfazio@xes-inc.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250107162044.195633-1-vfazio@xes-inc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0150.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::34) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA0PR12MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2a293e-76b7-43d2-7bcb-08dd346e6e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmRTU3B6dTVEK2tkbGNWYzhQSG41MUxXRnNaYndOUlVFanFRd29WRDhSRnlI?=
 =?utf-8?B?RWd5TEw4bXFnd1NwRkZ1WlpzMnloRHAvalhwR3plZFBFVW9sVHVIZXpSempm?=
 =?utf-8?B?c1l6MUpjTW5zbmtWM1o5dUp4WndGVVl4UlEwNHpqcDdad1FwZXM0RldEMDJu?=
 =?utf-8?B?VGoxd3Y1TDFJa1pvd3NONFlFVkhFbFVkTDFXSzgxUE1aYmN6SFJOODdhL3NQ?=
 =?utf-8?B?dEJ4M01TLyt6ZFloQUFZMWdKemN5SzhQLzJDcnBLb21XajMyVEZjcSs3TFM1?=
 =?utf-8?B?UWR0czZiWXk2SHBjTjhQWUQ4di9mNksrK0hRVkxycVFBbmFEcHlxaWtyWTdR?=
 =?utf-8?B?dDVNVTF1TVc5dzBUMERXRVU5Y0s5dDFRRTU5K0kvSUxTcGVRVFo2VmNwQ0ph?=
 =?utf-8?B?TDJZS3MzZGNralZuTytqR0UwUmc1OTNkaHlRZVFMODlNMkU5OWMwdWRRdUcx?=
 =?utf-8?B?bkFOUm9jaEppRmxPY25ndFRzK3Vwd1BhckRXc1FUWDA4NVVrbXVad240SjNU?=
 =?utf-8?B?bTJuK3ZiL1FSTXZZTHFVNjYwaHJHS0VoaHF6Tm43TTJvSUZlOGRwR3VCcHJL?=
 =?utf-8?B?eU91ZmhwSW5Ed29idWxYSEl0MVhyZGNCTVBNREprcncyOC9zZjhndXg3dWdQ?=
 =?utf-8?B?MHQyWGRIVU1RTmxTemdVMkwrd2l2a1pRWmJUaVBqQ0pxcHA0SEhNNDlBY0dp?=
 =?utf-8?B?WnBtaUQ5elpSOG5zWXJ6d0pmVzBQY2d4bXNHMUFPTHR2TFhNcFJhSWpBb1RF?=
 =?utf-8?B?YjN2NUxhcWR5NHIzUDB2d09jYnNzMldsQW9pOGdxcFpwaHBobWY2ODRmMThW?=
 =?utf-8?B?cFBkcTNLZnAwaytvbFc5aHZTZTNUTG1JV1k5ZnZGcHVSTGxJZ25OWlRNN0dR?=
 =?utf-8?B?U2NJb3FmSDdxQnl1aHpPMDFVcmZoYjBTdDNYTU40VXI4SzdTZkxtT0xwRHB5?=
 =?utf-8?B?RW5iOCtEUUFwVUFxLzZJS1kzdUNzcTYya1YyTy9DM0d1aFBkMUI5dWJmNlJS?=
 =?utf-8?B?UEpBZTZYVm1CU2tJNUFMV0NXSnIzZERsVFoxZmoyUnRPVDVOM2Q3QktiTjho?=
 =?utf-8?B?czBEeTFXMnRuaXZ6Y2ozZVl5SE1ybk4vQXdnZVdZc1BvWFJaMDJncGo3aXZ1?=
 =?utf-8?B?ZnB3YzBXMWlNdUI5Tmg2WXBrRERpbFN0QTI1dmVCZFhKM3o1YWxxRE9GR2ZB?=
 =?utf-8?B?KzlXTTVMM0gyQkplMTBrMGFnWTZUeFpzOTRmMUxkdUp2OCtzRWVRcXJjdGVC?=
 =?utf-8?B?ZFhFRHhyNlpIQkV5c04wL0ltNy9TeXFkcXU3SXZONVAzV3gwOEdBUXlZNDdX?=
 =?utf-8?B?ajJUYTB4WjlENDFRZGpDNVRSWXp2RHMvZ1NqTU0yV0hjZGlPMVlRMWF1L1h4?=
 =?utf-8?B?dFlIV0hnQmJGaU1QbE0vLzBGbzJhQWNsZ3dPU1JZZmFma3FqdVZwNXJWNmdT?=
 =?utf-8?B?eFl2WXJEQWpjMkZxemtSWG1lSWl1YXBDL2J1b0t4YjRkZkw0K3FaRVlwYW93?=
 =?utf-8?B?d05IQUdDL1dMdFd1K1N6WU9rV2txeGhzZGs2L1J5d05jTk4ramRnbzVsaEFo?=
 =?utf-8?B?eVVzN3IwVjNxTVU4cE0yYkNvZFFhN0k1a3NjYmVWZWxGNzhFT0VDT2E0T0NM?=
 =?utf-8?B?U0NjelcwVDNCSUVXSFFVd1VBYWwwYjE2ZHFsUVZHVlA0WjhJQ1FQMzMxVmRp?=
 =?utf-8?B?U1lGVUVxbjdKUGIxSWgwK3BYKzRrVDVKVFcwSXZNRUpFVWxXbGk1VGhrdzBy?=
 =?utf-8?B?N0ZmMGZna1g5SkJtL1VwdUY1c3RubEEwWjhweFYrU0VOOGMzVXFDS1BkeVo0?=
 =?utf-8?B?WkN2SldQUzdNdVcwa0x4WW1XSWxybGZXRThpdm5IdlM2QUs0eFhQeDJUckR6?=
 =?utf-8?Q?9/61BzsOFk2YS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFZkV0FoSzEwbDUzdUlrZGlxYStjRFdPaDhKVm8yUlozTlV0b2ZvNDRVMDJt?=
 =?utf-8?B?N0F6bkNtc1QxUGZaUU1qaUsxOFBURFc0UEN3WkRJZW9QWDRVSnA2eUhIdXBV?=
 =?utf-8?B?cWpUU1hpYjlTKzZzbkVCTmZDQmlMaTFNL0c3Uk5XS2FqVEloMU1HcGdqSml0?=
 =?utf-8?B?UytodzZtc0ZMeWFkZm5IekpPM28wTWQxVUl2U0gzaFBIOEFvVjBZL2c4MHcw?=
 =?utf-8?B?NFBaalp3a21OTUg0dzJzNno1ZHhTWVhscVBEZWt6UVNWSXh1WjhPWDV4N3pj?=
 =?utf-8?B?SWRudzNlNGRyWURQRXNvTVNjQ2ZhcjFSU3laZmFkaFh3TEx0bnppSTAxU0Js?=
 =?utf-8?B?a3plK2V6L1dSTjNzK25XZFkzQWVYL0NFNGVBTng5L0c3Z01kK25nbG1pTU1r?=
 =?utf-8?B?ZU42dStWZGZ3VGNZS3o5SlhwaUw5R3Z6c0FwemlBUjEyUXFUeHMvcWluTHN0?=
 =?utf-8?B?cEpVOUxDaUlVK2JobUFWTzhsMVRBUWVoRncwcE43dzdMUEIwQ0xBK1hnUmVs?=
 =?utf-8?B?d1VyN1dERkVBdDZJZ2hkVUJzNnRmRUFQZXJlb2R5dlluZ3ZLd0xJVFU4Vy9D?=
 =?utf-8?B?SHgxdEtLa29FK1h4Qmo1eVh6QnJYSEUxVnNCRzZ2ZTMyTXl3V1hHQmNWaHBv?=
 =?utf-8?B?Yk9xakIvcXRSZXJqaElRVTlYMlVPTXJLN0luSjdleGQxeGhhQWd3RWxTYnpD?=
 =?utf-8?B?c2VBMllvdUJoUlNFUkloUHBqTFFhWHduMDRtTDhiZ1ZEMjNTNVJQVFE5WDYv?=
 =?utf-8?B?elZPbGRhMWJveTZGb3lDMEp2QlQzZ0dNdllud2hnR2hiVFk5MDlPcXNTcmRS?=
 =?utf-8?B?QlNxdHVnMkt4SHY4enNWMGd5Q3dla0hKaUpaa1ZNaEVKVjNWcU9QZDljSXZH?=
 =?utf-8?B?b1NOTU1FT3JJMTB2ZHNnVzNTeXpKRkQwdnlWVm5OZ21rbkZaQjVsSmJvZ1ZU?=
 =?utf-8?B?cjg2QzBFd0RwZEhhMjlNL0oyazVWbXF2WTNBUnhBTmNUMkVlVzV5a3RnZVFa?=
 =?utf-8?B?dkYxRW9RaHB2Y29Gd3ZZYWpBV3EzaWpITklwVUVnRXc3aVhqQ1h0ZUh0RVVI?=
 =?utf-8?B?UEt4ZktETTRHbFN1YkY1SGFzb1pUTmNnSjdQay95ZlV2UXY3ampoY0JQSjhD?=
 =?utf-8?B?QlZ2Z1dqWm1wbVVYamY0bm9VSlBkWXFVWUpzVVhqWHo1LzU3c0RCcThnUkxF?=
 =?utf-8?B?VncxTUFWR1I1MzZ3enlhemI0UlE0L29ubDNzYmFNemtWNkZLb3pJMGFVSDQ0?=
 =?utf-8?B?YVp3bElmUzQ3SUp0TDNjZEI2bnhSS2JIdFpPOVJRMVJGRWwzRjByYmZNenlY?=
 =?utf-8?B?SStoUnBXSk9GNGhnYnNFZXlTYXdDUlo5SUlOTUVmc1RwMXozNXR3RjRPNkhX?=
 =?utf-8?B?L1QrMVBxMU16M040WkJJazRhOHBkby9HQ2s4akFJaDFhUmZBam1BYXNzOUNp?=
 =?utf-8?B?N2x3clpBZ3lWNGlrTUEzeUFsY1VDSXJhMUVtaCtmdzhuZFJQZFQ2MVVXdjE3?=
 =?utf-8?B?ekh4cTByNXlvOHQzdTRHOEhjSHYyclh1SjVmeHlNVHhNMm1JbkJwOUpaTDFj?=
 =?utf-8?B?eU1nL2U0Uk9IZmp6WnhKWWtjbE9oZ3dKT1VmVGZEZ3VTeVN6U2ExbFZBRU1H?=
 =?utf-8?B?TlR4RXJlVGR3Y05LcWZNb3hPM1lTSTk3TlFvNHFqWWNZVVFib3BxaFdvSkt5?=
 =?utf-8?B?NHBpVGRqMThQTktOUVVlSFZDaDc4VTNTN2M3RGJQblNQNVFkcWg0SlVGRnZU?=
 =?utf-8?B?T3VjOVVzRzZUKzh2WVBZT21JMUx1bWtqamlRYjBtUlFsNXhBb3hEQmJJaXIz?=
 =?utf-8?B?S0lrWVJiUjRiSlcxVVhvd1NuaGd0WEZQM0VEUDA1dVQ0VStRVDZUSC9GKzVW?=
 =?utf-8?B?LzU1TTZNNzRIWHdLVGgxV2N0QUVvZlBGejVhY1ZIckxBYzdkWG9qcWxxS1Za?=
 =?utf-8?B?MGJVNXlsVmRDTjVMODlqU3ozc3RNVGV6N0QxbU1wOU5uaDBYTGxXemdrNmoy?=
 =?utf-8?B?UmRyKzFlamI1UndiUHJkdk1uVGdGSTkzUUEzbWNWdDVrSzNnVnJnTTNtMVhS?=
 =?utf-8?B?OHVxK2R3YWIrL2xwbXM4ODBqTm5nNWJnMzBmMTZsUHJrQlJGSW4xeXFnR1lu?=
 =?utf-8?Q?LctHdxWtC7oz7LXs734KVsXzQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2a293e-76b7-43d2-7bcb-08dd346e6e4d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 07:38:25.9045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncqBdcKDUGCIFcdfpHm8gKpoNrKnf0t+PK780HDqGCccve+RK18qE18VGWBWOvua
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555
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



On 1/7/25 17:20, Vincent Fazio wrote:
> Allow the ZyncMP RTC driver to be enabled on Versal architectures.
> 
> Signed-off-by: Vincent Fazio <vfazio@xes-inc.com>
> ---
>   drivers/rtc/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 9c2d1398247..ecdcfe1f240 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -294,7 +294,7 @@ config RTC_DAVINCI
>   
>   config RTC_ZYNQMP
>   	bool "Enable ZynqMP RTC driver"
> -	depends on ARCH_ZYNQMP
> +	depends on ARCH_ZYNQMP || ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2
>   	help
>   	  Say "yes" here to support the on chip real time clock
>   	  present on Xilinx ZynqMP SoC.
> 
> base-commit: 6d41f0a39d6423c8e57e92ebbe9f8c0333a63f72

The patch looks good but there is missing also DM_RTC dependency.
Can you please send v2 with also adding it?

Thanks,
Michal
