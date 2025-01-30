Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015C7C0218D
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 11:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE10F81F69;
	Thu, 30 Jan 2025 12:58:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5uP2ttvY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98DCB82012; Thu, 30 Jan 2025 12:58:22 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09C4A81219
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 12:58:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFQDXRARA/Hw6y6x0phZdlF+y9epZRaDhjTBneykWuzTYS6xR+4FfWtN+UkvbjUzNqrRVYWMiuASxyVPbSmQuV/bBdHSTv5hnDeMyWkhtTGixkt6M9i3fr7XpxeenY9tqK0jBglBHp/cEnQz+ZX1cBqHhW5na0D5ybmIHrd51p+mLjq5NZqWAHvhr/IJ6Gx1wPLUxZ9ZLO8eMS7TG8CieisyS5Mxw2Zf/AfskUGqjF5Y1n/fMd+vpdCcfoa8yO7D0XCMiEt61j1wc58PIwcKEG6TyKzMHTLSOkENAiZ+I6MECy+IAe0UxzejHOk4RctMK1xow/CRmpQDXEob2Zy8Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xa1o4SF5VnIyvDqQYOlXv7Jza2EyE1ie6v9H4mHR8CY=;
 b=jvv/A8jLJszKghCbw/6WoEXDS6//aJHtrn3HOi2mz8+5R2NrDDUp/+lSOzT6A85xKZYcpbWW34eCrcMvWm96duw6OO9vQLkzVEbA4VBKZFaVUNlHFaJN7PnFl8Cx0hgew+IAE8cPDsfzJKDbXmiQpvH+63ZMFSZ8MX4FQw4h7s9Z4ESF3947gl94RIrOfD/xEG5465BQDPMTq3Do0opicvSO4VdVgPLoWjLTQLUdEARNKV/cxN0TbolhrRCE9uOQsXZrwGUIP+dO0glZhOxAQoMnwVktTVtBXBtLS4oCyh4sK+thFJ4zvZdSjtIjWezFMHykC3CDZnn4kl6nlxwksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xa1o4SF5VnIyvDqQYOlXv7Jza2EyE1ie6v9H4mHR8CY=;
 b=5uP2ttvYJo52eWoe6/797pDJFAo0WBgZzvqGmjGEelaOFMgldSZqh+neXU5+w8mPwNDRuAWQe9HWfop3YSoj50XjlUkvTl1hdaDZJGC++v7B0hTfLQGiy6hLmjnl2LB6hyMpYeNyYvSHlFL+6z89HIwXqHMTzBZWGYXLBIsy3WI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB6697.namprd12.prod.outlook.com (2603:10b6:510:1cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 11:58:17 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8398.017; Thu, 30 Jan 2025
 11:58:17 +0000
Message-ID: <4e7a6da4-0090-49b4-acf3-66d64c943c8d@amd.com>
Date: Thu, 30 Jan 2025 12:58:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bootcount: zynqmp: Extend ZynqMP specific bootcount
 support
To: Marek Vasut <marex@denx.de>, hs@denx.de, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
References: <20250130013726.337914-1-marex@denx.de>
 <4f7e2e18-57bb-f7e2-1202-663240668ef1@denx.de>
 <0cd7e315-b15a-4e0f-848e-75da3f80887a@denx.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <0cd7e315-b15a-4e0f-848e-75da3f80887a@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0358.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::17) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: d233a9b2-fab8-4131-5e8e-08dd412561e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0NpQW5YKzFFOEQxejZJaHA3NXd1c01HUEUveS9EY2s0ZENNYlJrT1B1ZnVv?=
 =?utf-8?B?b0p1akR4alBadTNvWFZnbnJBNC95Mmo5NHpJV002Z2ZOWExOWkxLWXl2aTNo?=
 =?utf-8?B?dFF4WGVrdWJnNzRaS043endLbHB1anVBbnUrc0grT3hrd1QxUUhJOC9RL0Rr?=
 =?utf-8?B?akUzUDFKSVk1bTRjSmYyY1hVMHFIbXlCczNFbnVyeUo0MlVRWGFNSlM1Nmt1?=
 =?utf-8?B?OFlGZHlndUYyeVEvMGZtckRmUUNTdDY2SXNmV0pDb0ZabjN2akwvTTk5dHd1?=
 =?utf-8?B?QU9BVE1SYkl5M3NhamhqQk85b2xXSE5lem5tZ0swd3orM3ZDT3JmeCs2THpM?=
 =?utf-8?B?VzJrWnBTekNkcitjajZGZmdMbEx1WGJnL2M3M1JZWE82VC9LZ2pkdVVKdFRT?=
 =?utf-8?B?bzJtNjRBU2dhUENGMXpKa2xsZUNCaUJKYllnUDFGa1hFWEMrdVh5cVUycE54?=
 =?utf-8?B?VlhQdVl0OUFheCsvNDh4TkVUY09pUEs2cFF0ZituV0xURG5GWGpGaCtDZTVK?=
 =?utf-8?B?bG5hSmFKdnJPU1VoWUF3Y1ZjTlJhOE82RDRvTEttSDl6S05lQTFRUzhvUTFZ?=
 =?utf-8?B?T20yWDlFdU9YWFhHNjg5ZXNWenlJem11RFQ1azlzNWZuMFhUekdvWUZwVHNE?=
 =?utf-8?B?V1lkTWpOaUYxc21SV0ZrRkhYWFYramZuMTBCWUc5NWM0K3Y3Ym5ycjRvZlJw?=
 =?utf-8?B?UUR4SFBxb2w4UU1ESnF4cXBUYU8zZWxtWE5kTW9GdjJ4RzA3TE9Xd2JmMXA3?=
 =?utf-8?B?emM3eEhnck5MbDdDQWFZUVpYN1BvOHFocVhIUk84dDdDOWVWZjFrMjA0R2hj?=
 =?utf-8?B?UWVQUWRMYnJQTkEzZHdYR1p5ZzBtMG9mNFJ5alJGWlhNQ01xY2pMKzYyZ0lx?=
 =?utf-8?B?eURXdnc5ZThEWldKYVQ1b3VmV0IzUlV6ZTR1aUVOQU9ocEl0U2FIa3FOTUxC?=
 =?utf-8?B?RWdtN0dFL2xlQUZpL3BVNklrbHh4dWxOMTlHMGs3VXd5MS95YWxXRGRBaUFl?=
 =?utf-8?B?a1dFOW0wcncwbHl0Zmh5TlczNnE1b1I3OWIvOTdSOWFuZVZ2d0dDbmptVlcz?=
 =?utf-8?B?eHdOYzY1TU1XOHJNemdTd0hSYWlZWXcweElKQlN3WGRod0NXUHc2ckg1NG5n?=
 =?utf-8?B?dEFIajdQeFlFSXRDd0xkNE5PMFl2OUQxVlF4Q2M4SjNFVjdFVW1DRWpuV3Q3?=
 =?utf-8?B?aFZjeENCMFU0MVJHQVR0VTgvc0NnTEJOTnY1QUx0VVV6SE5VUDl4NnNPaDFr?=
 =?utf-8?B?c2NCT2ZqNmVTd0Q0MitGS1p4QXBJUEZVNUhySnBrbzY4MHlBYVNLdFBTTHNq?=
 =?utf-8?B?Q0FyaEZyT0FNNFhLMGpOMUFQTDR1aHRhUER5TjVmZXRpVFNGNFhYN0cvQ0dj?=
 =?utf-8?B?QmhGMUpOa1FBdHlyT2N0MDdTbGhBYlVoL01nRFQ0MDkwWitBUjFGS084Zlho?=
 =?utf-8?B?ZEFMaHpMQXR6ZlZtV2RFbFAzSzlCS0UyQUJpNmQwd1g3YU9NOU1TTkprSzJr?=
 =?utf-8?B?U0M5bEhLaUkySitRMXhRVmtEMVAyZGtTcUNFN0tCMmN0cjd0bWRkdEZEcHhE?=
 =?utf-8?B?TmFyZlp2dE5PUE1zWVFiRHRPNzBYUENjdEszSWZMMDN3M1h3V1c1NjN2VDRX?=
 =?utf-8?B?UVBnd0hMeWx0OWpmZXpTb2tUTTkwb2dNOVMrcUd3aDc0aGN4ZXhsbVhTZ3dp?=
 =?utf-8?B?QlZtYzNKT1kzc0xuUUFzRGgwc1dNTU90OGtMbDRtdTU1S1hYcDNxUnNpZEVW?=
 =?utf-8?B?NGdFY1BwUm96WmVBQnRQbzZpcDFXR0tjWTdUMk5tQ3o2V3NPUmt0ekpiS1RG?=
 =?utf-8?B?eE9QTUQ5YmFqNjJ2OHhpUmlUTDJCNi9ERjc1T0dPd3Y1OTBhS2UwQjN0dmFr?=
 =?utf-8?Q?KYjSod1xAI5Sv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVo3TGR5bVZXMWNSenFLUzdyTkthOHVLUkFKWWp2ZDJjWWZnS2NiMzdrVk1V?=
 =?utf-8?B?bFRneHhFa1JpdTlvUDRqbEhNb1hzM1BqWCt3SEVBN2x2WVlLSGh1ekFrWmN1?=
 =?utf-8?B?RjhobUFYOEpPKzB4V0x3VUFiMklRQVhGc0ZCa3VGSnFodjN2cTlOd0xKbm9M?=
 =?utf-8?B?cm5KNDVGNklTNzZVR3NJbGYyUWV2U3dhVHlLZS85ZWtlYW1RUC9scnNXVmdH?=
 =?utf-8?B?TFRFVlk4MDE5elkydnJ1NFJ0cmxqKythejArSEQxRzZOQXlsVW9pVDlvL0I3?=
 =?utf-8?B?VlFPRXdjeVV5WWhCNDJhVTcwaDliUm1vYlFLQWc2aDBvRExTRHVBcUxGcXU4?=
 =?utf-8?B?Ky9PZzhtWmxtZXl6THRWQ2V2c1VibzFPSHF4aVRNSk9NbXNFdmlveU5WVXZY?=
 =?utf-8?B?dzU3NStUVjhIYWFaVlUxOVhGSFRSbHZ3dkpFUENrV2VnSy8zRWpIRnpZcUdJ?=
 =?utf-8?B?Q1BTWDkybHcxanUydlBlclAxSCswM2RpM1lnWGU2bHZDanNrK25qWitaVjB4?=
 =?utf-8?B?M0wzQm1IRHIra24xeC9HYlZ0L1daRExuWWRGSjFFQ0hTQzBBd29YU2FwSlds?=
 =?utf-8?B?OTlaQk5Kd1JLSzlIY1dnMmFVbUU2OGtLQWhHWVZ0R1RpYzJVYzdXY0ZUWU5r?=
 =?utf-8?B?clIwR3l0eXRYOGJYQWFtSWthZmdYWklpcGtKL2NDbDFsOStYUlppRXZic05M?=
 =?utf-8?B?RGdDTGhZeGpxakRQaHU4TEY3TXFCVGZRZ0w3SGpueWJkVGtrbEJRWXdXZnZ1?=
 =?utf-8?B?UXBFMFlrcEFEUHZUcHZHSFhQZ2R1aW00S3dpWmVOR0lGUzM0WlNUR3ZlTmdZ?=
 =?utf-8?B?WXYrN1lhQkV5SU54N1NHQWhCdTh0WEZsdG8vV2MwS2JRZS9RaEh5dFhvNmpE?=
 =?utf-8?B?SXVqKy81N0xYYmZZVFBZUmY4ZlBadEFjZFBCR2hlWGY0OTZ5bXkzSXo3QkFO?=
 =?utf-8?B?SXR0NjNwdjRyTWdPUGlaL0VtY3hVOG5hK3pzVm1VeTA2WXdUWHhNTVVVYStY?=
 =?utf-8?B?UndvTXBBSHc2UU44bzhRZ3NJWWx3bk1tYzJYNWN2aVV4UjdVWHNhM2JjclR5?=
 =?utf-8?B?Y1VaaHZTS2d2TEs3SVQ5bjFxV1JyVU43K2llQWNYMERENDFLcDJLYkdjc25B?=
 =?utf-8?B?WkYwbUh4STZFc2RBczN2RFlaaTd5MXc2SXlvZGx1SHMxZnJQc1hQRGtJMThy?=
 =?utf-8?B?Qnd5TmdCVnFpd25hVGN0dEhrVitid3htaU1WMTlpTmxQektyTTlSYlVQRjVP?=
 =?utf-8?B?ZGhueitFajFyd2FSeEp4TmdJZmVCWkc4WHBUaGFTc1lSeFRtLyt5UVpIMkhU?=
 =?utf-8?B?cFlVVzZtcVBpK1pRRDg1VFNyQVZ4dGwzcTdqb3haWFlOOEJzMFFWdnRNM2Qr?=
 =?utf-8?B?RmNlL1hUc0Jka1pPTXZOL085d2doa05wU1VNWUxLekpkcWdneFRBQ2F0Q0JT?=
 =?utf-8?B?SDR3Tk9INzYxSEFLNHMvTTV4Y2FOQ0FqSWVLYjRrVWpWQU5ySUYyWUo1dDRY?=
 =?utf-8?B?K2tvVDB3TTdUbjRzTXpQcHdCZzd0bXZ4M1ZTTnZwU2hmeDNtQXBLckRISEox?=
 =?utf-8?B?dFpJN0JOSEIyL28xcEE1c2VibjRwM0hBanBFLzB3WlVWSHZpdGdRSFNBZVg0?=
 =?utf-8?B?TzZlOThqdU41L3l3ZXZSV2g3YXJFK29VcXRsaHFvSi9GbUp4RjdPTkJ0QStO?=
 =?utf-8?B?RGxwTEo3NnNkZE03cmtxc3lMWjR4emM4RTY1SHdQd3Q2ZVRrQWJMZGhsK0tV?=
 =?utf-8?B?cjNBUlZBQy9kOEw5K0J0dEwxYVZvK3lJc2tEbDFSSi9Gc1o1a3lwcFhRQjlE?=
 =?utf-8?B?Tjh2cCtDQ3pObnNOUXJlRW5YeE4rT2NSK3JEcm9DNW5lSk5xY2l5MHJYSk5Y?=
 =?utf-8?B?c0pveCs5V3IwbkpBWW5ham9MS3VIQ1VpQXI5VXVrcVdOeVQ4VUhWOHkwSE9N?=
 =?utf-8?B?Z2hXMmhrMTNUeE1uMTBWN3hoT1pTYitvZ1hDQVhTNktaNVhxWFBlQ21kMXV6?=
 =?utf-8?B?aWl6eG5NelB2cWt1eFgvelQ4M3pOajhtV0hmY0s5M1FxUjVjTEwyWGpIUVZv?=
 =?utf-8?B?L3VCLzYzZkg4Qng5UXdyOE9vMzNMZWNDSW01clAxVElUSXJ6NzB3VXV2T1ZW?=
 =?utf-8?Q?JDKPI2eNaN9QRQ18SY9sMgsc/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d233a9b2-fab8-4131-5e8e-08dd412561e8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 11:58:17.0941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YOFjslq92LrzAsrMgsDzUPjdWK2JRDTqy/ebnMWjdRHBeYQQxoChdchgTZjD1Ao
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6697
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



On 1/30/25 11:36, Marek Vasut wrote:
> On 1/30/25 6:24 AM, Heiko Schocher wrote:
>> Hello Marek,
>>
>> On 30.01.25 02:37, Marek Vasut wrote:
>>> The PGGS area contains four registers, each of which can hold up to
>>> 32bit of data. Extend the boot counter to support storing boot count
>>> in either of the four registers with arbitrary mask to avoid limiting
>>> the boot counter only to the PGGS register 2 LSByte.
>>>
>>> Drop U_BOOT_DRVINFO() as that would instantiate the boot counter even
>>> if there is no DT node associated with it, that is undesired behavior.
>>>
>>> The boot counter configuration is implemented using three new DT properties:
>>> reg - PGGS register address, fallback to PGGS 2 at 0xffd80058
>>> u-boot,bootcount-reg-mask - Register mask, applied on PGGS register
>>> u-boot,bootcount-mask - Boot counter mask, applied on boot counter
>>> u-boot,bootcount-magic - Boot counter magic, applied on boot counter
>>>
>>> Example configuration of 16bit boot counter with 0xb0010000 magic in PGGS0:
>>>
>>> &amba {
>>>     bootcount@0xffd80050 {
>>>         compatible = "u-boot,bootcount-zynqmp";
>>>         reg = <0 0xffd80050 0 0x4>;
>>>         u-boot,bootcount-magic = <0xb0010000>;
>>>         u-boot,bootcount-mask = <0xffff>;
>>>         u-boot,bootcount-reg-mask = <0xffffffff>;
>>>     };
>>> };
>>>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> ---
>>> Cc: Heiko Schocher <hs@denx.de>
>>> Cc: Michal Simek <michal.simek@amd.com>
>>> Cc: Tom Rini <trini@konsulko.com>
>>> Cc: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
>>> Cc: u-boot@lists.denx.de
>>> ---
>>>   drivers/bootcount/bootcount_zynqmp.c | 79 +++++++++++++++++++++++++---
>>>   1 file changed, 71 insertions(+), 8 deletions(-)
>>
>> Nitpick: Should there not be a change in a file where the new properties
>> and the compatible entry is documented?
> 
> Do we have one ? I don't see one with git grep, but I can write one.

DT binding is something what should be solved first because it is not in linux 
kernel or dt-schema. And I don't think it is going to be straight forward path.
Definitely I don't want to introduce u-boot specific binding which won't pass 
checks.

It means one thing is description for bootcount itself which is pretty much SoC 
independent and likely can just go to dt-schema to u-boot node itself.

The second is how to pass information about location. In this particular ZynqMP 
case I think ggs/pggs should be described via existing xlnx,zynqmp-nvmem-fw node 
and generic bootcount nvmem driver should just get pointer to that location 
which holds this value. That would solve description and pointer can be stored 
in /options/u-boot/ node ("u-boot,config" compatible string).

And get this to u-boot means to create new UCLASS_NVMEM which doesn't exist 
today and write nvmem driver at least for these new offsets.

Or ignore DT binding part and just extend driver and use 
SYS_BOOTCOUNT_ADDR/SYS_BOOTCOUNT_MAGIC/SYS_BOOTCOUNT_SINGLEWORD and only 
introduce MASK config option that can be changed to support your case.

Thanks,
Michal

