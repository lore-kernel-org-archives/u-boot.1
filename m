Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976A8C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 05:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1EAA82E28;
	Thu, 22 May 2025 07:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NM48WE84";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E942582E31; Thu, 22 May 2025 07:57:05 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96EF282E26
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 07:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csCmoFAGWvgFLOCcXgUkLRJNKlpuiDhAYJgZf7SgO4i6hm6XmtIDF+CZw5+wJsG6W09NYQe8FPyoZCiEducijSrb7Qa+V0A3Eg1GNeRN2l2n1Ws/flBK2hyQdUrdaCQQ2EaeS8A9DS2HGNtfTp1Sgl8Lsll9nxif5cWTUQBdgjcgDQW1Ry7FzcztFNAibMwqvNqsZBMq1gp1HG1wZ14SCTEJTsxZ3WxSajDwAQ42ow64zWns3X5FsnYKY808JgvCeeFTkUKVSeOFWNohLxnfgV2KFtuV2iiSAxrtGS7vdmZUXGTrJOYmqw6CulO/w0uzYf4j8iX4IYNmWGrgWN+BvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFr4Ab3ojwf0BsuQLMklh7UxUVWekG2/F65lLWSdkHI=;
 b=Bs7Z9ENbxEbNziTao+nvRQG8BFFkj38FTmvxw1a21LM7LqIMSHN7JwLw20Lk4wkcY0jxzPDpS+aHJ8p3/V5afM61VUnQY791MzEMaOrJTqfdDwGt9meHjT4jBMiWLoTmc23/NkwB3osC05HABKiO8nYE0EKbzJF3iIOHdD1+3BoZoEILdTArSvUrqvhpkO9hE7xX0CHCQUFo6CIS2YtaKcyHqzO4XFCt/Z838bOlfSJGsCEMxmuveZ78PeBrxV6JPh6J9M6H1nWEvLoPHOu8NqbODKMAzKTO7pYB+LlK85iedfbAXVL3k45/sm54Sv0hAYiK9tN0yNE9XNvurVh3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFr4Ab3ojwf0BsuQLMklh7UxUVWekG2/F65lLWSdkHI=;
 b=NM48WE847NphHEVjsVJycUTqcCOmaXVvNHxAqzvTOFOgNFFQMGeqq9Sei7EamCnuZUU31S02AXStKIKi78/KbVNhpRYYIoqi6qTDRwWG0jHR1RzO6zddsAftuH5X4GMw8IZ2Lbf2v18ECGJuej7MIPAYxY1sG8nPO3d61+D0GEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 05:57:00 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 05:56:59 +0000
Message-ID: <7d8ba8c8-49f6-43a3-af45-8a17d106af55@amd.com>
Date: Thu, 22 May 2025 07:56:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] phy: zynqmp: Fix sgmii clk ctrl GTR lane bit shift
To: Rutherther <rutherther@ditigal.xyz>, u-boot@lists.denx.de
References: <20250521181620.8175-1-rutherther@ditigal.xyz>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250521181620.8175-1-rutherther@ditigal.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::27) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab0c977-5595-499c-adc3-08dd98f5776b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUM5cmFuemIzWm4yWGZIaWVXQjFOR3VoL1lvOGpOWGhUcHlBK0oyaFo4U0Vr?=
 =?utf-8?B?SXFsbUFhaUR3b2Z2L1AwdHRNekJoMHVxcDRuc1dETEFLL3cvVSszWFhkQlBu?=
 =?utf-8?B?YWc0SllDQXFhNVphT2thcGZtbEt6L1VJb2M4MDlqYktFUitsVm5lcStHaDVo?=
 =?utf-8?B?a0xJTnZKTjQwb3djMDRkckR1akxiZ0YrbnpGaVFESG9mdVltTW85OWJuU21H?=
 =?utf-8?B?S3pTaVl1MjdSM2VCWUd6ZmNDcFg5aWVYOElJSW1Mc0ZVTlIrRyszTU9IM296?=
 =?utf-8?B?emhtby9UNUtKUUVIT0ZNT290UEZFbEV6eCtaeDJvSXRyN1luaTZxbS9SaWdI?=
 =?utf-8?B?c2dYQWpKaC9IekRFMG9KTi9HMUU4K2NuNjdyY3VFTzFnRkZPZ21oMmIxaVRW?=
 =?utf-8?B?RUFPK0ZEQVRDcGgwV3h6K3RKRXozczFMNzFOcW5wZTczTlVjdmJNZEhCbjdX?=
 =?utf-8?B?d1V1TGJkc09CTUVyY1FuaEgvR3hFQXF3a1QwYTZWb2FMbE1MVkpIcm5jQjRZ?=
 =?utf-8?B?dVphTFlVcE9oWWFFQVBXYWRra0lLelgxOFUwcnpBT3NmL0E5c2dqbkxQYXVP?=
 =?utf-8?B?dVMrSmVXYm5oY0pmSjF1d1pWZjBhd204Q0RsNUV6Rnl1MzFJZ0wzM1JnNStK?=
 =?utf-8?B?T29kVzdWdkQzL1o4L0Fib09jQmt2WFpLNCtLdGxhaTJFbytWZWlhVHR2N0xW?=
 =?utf-8?B?VisrcTM2RWdwRVhOSkpPYWdMN05JOXJNUFBJUlNzK3NEdVJzYmFJaTJUSmZV?=
 =?utf-8?B?SkR2VlFIWGdqb1V2V083ZERVMVdNTW9OQ3Z1RzBnZzV6YXFHVmI4eTIray9v?=
 =?utf-8?B?SC91U1VKcFVXTXEwN0VVQklKZGJqZTlRMld0NldPVm9OTnZXMEIwTDF5N0tE?=
 =?utf-8?B?Qk0vb3owOStONGY5Ny9DOW1LTDltdW5KWTNpRXFlNGsyT0VKWVFHd0hIK2pY?=
 =?utf-8?B?MUFoZzJ5QS9UNVJCMStuQlVmS0poMmlvSy8xSUVqYWJQQzM1SkQwNnNpeGxv?=
 =?utf-8?B?K0hISzRWWFFIOEVYckJhbDJnbTV5Q3hBMzBpRTJ4U24xYWswQng0SnFHSDZt?=
 =?utf-8?B?bzdxN2FncE81OTJRL2lMQXAyd3BlOEFiM0xrMlc3NFI5VGZaK0pKSUxxNDEz?=
 =?utf-8?B?YmxsMHdyTWd3d3pLWFlTMURBam5yeGVBVmE0c2p3ZW1sRnJBZ3lUdFBUN1JF?=
 =?utf-8?B?UWl5QUo1bUo2NXVLOTBSL1AreTdwWXhJWEV5Nk9ONlZGMU1uMXVHb2Q2bFNY?=
 =?utf-8?B?WGIvZlJlREcycFFhVlNDd2I1eU5kSXFlL1NlWlBqbGJacjZxUDI4cTZLWFZu?=
 =?utf-8?B?cExtSkFBcHl4SUh1T3dTOWxRd3hCeGFwT0dDUlJKTG5lSDRYUHQzUWtQWUw3?=
 =?utf-8?B?N3JaNExUMitPdWdFK1pIOTAyTE5RdmFHbkw1djFMUXRONHFjMHFwaUZKbWwy?=
 =?utf-8?B?b0xTY3N2YnlKK0t3LzVoalJmd1ZNSHEvK05ORSs0OHZmcThFSU9qbVBxcUpD?=
 =?utf-8?B?cGx6NXgrT20vS3hPa2VHanh2K1p5SUo2Z0g3by9wcEVoTXgwaEZmeHE3dHZD?=
 =?utf-8?B?Y0N5dmQvUHNGcm5HeXFDcThqd0VvTDVZR3pDK0RaY053alMwSnJDcUNjaVFJ?=
 =?utf-8?B?S2tWZW55MTZYbDZMYlA3NFRqSHpOb3podU0zSTVlQm52WmFIYTlEVnQ4MENw?=
 =?utf-8?B?akhkME50b042UEh6Wmlta3VrVlp3dURPMFRjdWlZbFFlOWVpN3RzMlZJZENa?=
 =?utf-8?B?TGpSY21MR2dkMW04bTEzTFQ4NytyR3FpSGVlMnd0WnNpSDdIclB3OVhHQXlN?=
 =?utf-8?B?ZWhKV0hRQ3dWVHNWMG1pcE1VOWdUZGF6N3c2SU1ZNGMzODBReWl6SlYzL2pX?=
 =?utf-8?B?azBpbWMxNnJLdmtxNnA2ZER4aENaWXhKakJMQ1RLNEFXZk1nZVZmTjc3MHEz?=
 =?utf-8?Q?Lb3usL8TPV4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0kvYVdiZ0RLWm5MS1JLMDJDZndaYkRkU0pPVkRSOVdPUXpHcmF2Wlk0Y2dB?=
 =?utf-8?B?RlZwMUZFK1EvSE03dFh2Nnh5b09IRElPNDNvNGV5blpyMU5pTXFJNWUvNHNh?=
 =?utf-8?B?SDhLSjZtVmRiODl2NmNkL3dMMUNSRFM3d3NWME1sQ05ZWGgzcjY1dVdaZW92?=
 =?utf-8?B?RnoyOTNxdSthWFJ0S3JCUHU1YlpudzZuNUhpZ1FlekYwZWJnYXBubHVtNFpk?=
 =?utf-8?B?V2ZmY2FoQm53dUlXa0FubkFkenBMSU1ZaUtYSTJxRW5Qckd0OHdrVncvTFN0?=
 =?utf-8?B?MUo0eDIrakZyR1g1T0V0TU8xYzR3ZEhNOUk4eWMzZW9hRGVGRDFZb2dNVDNs?=
 =?utf-8?B?aVQrTE1tZit4SFd1d2R3Z0tDaVFEYTFZaGJBRUZYOElleXFwRzZoYkIzZ1Ex?=
 =?utf-8?B?WWlYVTNZRjNxVHZPajdOanpMOGJTK2twRlo0MnJpbXRzNUUrMGFrdzlvWWxk?=
 =?utf-8?B?bkZKdWNJVmZuY09TSm1Jampwcmo2V3BkaUdQVmV3emZhcnRFT1paWFZoY0NO?=
 =?utf-8?B?L0E1RDRNM1FiUlhiWEhyb1BYT0N2U052dEovT0VCSDQyVjd6djZmRUdQWi92?=
 =?utf-8?B?a0MzTjByK2RzeWQ3RzVGOXVvZ2NMSXplK0F4YUQzRTZPNVNUNTZXNXBMUUZV?=
 =?utf-8?B?enlCOThLc0tCdGREMTI2MUlMS3NkZjB6T01NZXMyOUlubnJqRGZZQlZZUmpq?=
 =?utf-8?B?ZDZ6ZXV2OWRsb0o2R0oyaWI3RzlBcVB0NXlINFdDUEdDbUdSbnVadjhrMTll?=
 =?utf-8?B?SEw1MXNKUy9DdnpnVDBQVXlCWW8rdC9vUDN3NFNWeWdZemlWdGJJNWhJU3hU?=
 =?utf-8?B?ODNJWFdHeFZFaHF3cG1tWG13aXBDQUN1RmRKWkdkclJtT0lWZUN2akNheVE1?=
 =?utf-8?B?K0JxVi9jSlpBNXNZdk9GZmoxdGsrQU5ZYjlZeWRIQ3JoenRWdEsrOUpXSTR3?=
 =?utf-8?B?K3BxRGd1MmtSOTU0a25uWDRxN2dMNnBLaDdwTU56NVhXbXljSjYxcHRmRUJW?=
 =?utf-8?B?YUdLN2NTejNSOEd2OGVTenlBanBueTEzdGNiSTd0ZXJKYUozeE92MWhFNGx0?=
 =?utf-8?B?MDErOW1SUWZuSTB4NkxXWEN5RUQxU0Y1bUcxZTFmTTB0dlNPWDJHM1JOY0ZI?=
 =?utf-8?B?SWFnYWVjM3RDTTk0cUpqMHFNdzBBV3dIVzNZN3pFMmx5WXpCR3J1dWQxR0dm?=
 =?utf-8?B?dVdQczZ4VzljRFJwc1dsclU1WTdqYnd0Y21sQXkwWkowUHRJL1hybGoyZWRL?=
 =?utf-8?B?M0FPT3dyN2MxY0lzMDFnQWNnNzl4YjZnTWhnMmhIQ2pwNkdSdUgxbGovMTFY?=
 =?utf-8?B?NkUvSm1KZUNaQkt0Ym9MVjFtQ2IzdXNER2V4Yncra3I5ZFFkVGJWclJiNFlZ?=
 =?utf-8?B?OE1tL3h2UTBMWXFHMVhpR1VhbzlQMUJpVzNnRVIydkVBaGRJREFGZnE3Qms2?=
 =?utf-8?B?cmgvbXVra0I2eWo2MjdFNmxqU2hVczdtSU01bHRNM3hXbVJWaHJ5UlRVckRK?=
 =?utf-8?B?R1F6a0FtVVB0LzdjRHNGZmxpa0FpL3N0NFZFZHpzWDQ2cVpiWHpXcjVBUi9r?=
 =?utf-8?B?OTE2SmZhSDcxclVuOVpwQTBvZHp2cWVlV3RuUDlmWUZLSVN5cndJMk1PNmhY?=
 =?utf-8?B?bkcvZWJpajZiQjVtZXNLT0wzUllGR004dFIzVkNrcFJWZ1E5MCtSYUg1SU1F?=
 =?utf-8?B?anZDM1RPVlZVQkVjQ2hXN1JVN3c2Y2NaUUZDUXczVWJPSGxyVm1xTEVSNCt0?=
 =?utf-8?B?UWE1TTV1eUFKKzV4em9pRWNGS0IyeGdoVElLcTU4N3J3c0xYMEJzWU5iZVJl?=
 =?utf-8?B?MC9EZVBPMFV3blZmazI1R1c2WGdyL2dBSWZEeDZ1ZU5Ua2tQb3RzaUQrbmJ6?=
 =?utf-8?B?ZnNzT091dXNDS2dNbGx3aFpwNTVzU01zOWRCdHNCcG1hdExLU2Yyc1YrTk5y?=
 =?utf-8?B?VFJOYU5pY1Z3SHBoc2VwRnlUR1puMVdzVVh5bHpoMTJQVUtpTlZ6WXdWSGhr?=
 =?utf-8?B?REJKMUl5WWNGNkFscW5JS09ha29uYklpM1ljSlkrcXV4c2R6ZGZzVHR2K3hi?=
 =?utf-8?B?RlB4U1VOQk54YUNHK1ByZ3RNcm9QVWRaTlc3ZVNpcUl0cm1NQXdkUHVXUU00?=
 =?utf-8?Q?yMMprEnyjiXzF6nVeFJ//LSTJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab0c977-5595-499c-adc3-08dd98f5776b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 05:56:59.8071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqpJtoeMCFyXcd7idXCO/DAsznvJhjZsYEs3RvlDKGWd5VMeKlaFEPaZi2viG5cb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616
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



On 5/21/25 20:16, Rutherther wrote:
> The bitshift in GEM_CLK_CTRL register is five bits, not two. There are
> four bits for each GEM, and one bit reserved in between.
> 
> This has caused that using more than one GEM is impossible,
> additionally corrupting the GEM0's configuration, leaving GEM0
> unusable as well (ie. if GEM0 and GEM1 are used, GEM1 configuration is
> going to write to GEM0's registers wrong value, leaving GEM0 unusable)
> 
> Signed-off-by: Frantisek Bohacek <rutherther@ditigal.xyz>

You still have the problem that address which you are using for sending is not 
matching your SOB line.
Author:     Rutherther <rutherther@ditigal.xyz>
Signed-off-by: Frantisek Bohacek <rutherther@ditigal.xyz>

You can try to apply your patch yourself and see it via git log.

Thanks,
Michal

