Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CF6C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 12:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7D6780586;
	Wed, 22 Jan 2025 13:02:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fuz/NB++";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C31680763; Wed, 22 Jan 2025 13:02:48 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2B5D803B5
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 13:02:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHsJRSyao+x2K4olwa1ccA2l74Ysq1ZICAABFWi34v8KB3pnep2Z1sgLYTbh6ZEOPafPL365xveTFQB/GzM0RjesKiLeN0mzs0+53rrQJqJ3GmA1uujE39oS1NvS3m9eLKLatEah7OypL2q0gncL5h9Kep5UxnYUrotAgfOY9lMwVSv0oZHvDg0QO276S6yvw29EpuiMlzlm4a14kOcw+a4ZbgqJXn5lykqZvkqf4OYiZqK1qjwhRA/7yxCC11N14Hap/boRQg+E8IVuEk5Ys/GLwmcUC8uIaHKt68I8WdyK2qUV9+87hTgBcOmXE2x9ZT+5IMs0a3iWNEUTsiJ37Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGfzJBsl7+d4IwHO6B/Li7HVpY2JjK59lyp02SuZZPY=;
 b=HuYAagcnciM21PBv/ulNY0yCOYGiSEiIBalVvoBgfpkqGdNOyzN5kpIb8xVT3XOttElDuEPR2vJUoW0GHN4j2jSVH/XlwXr37G6xU90uRvnkwseFxB6GYEZapMdZHfJUlppLp8BnPEYbDB8RBRETwBZk9pUE7uJ62WG5SbVAZsFANUBl5x4Ie1V1BrjObiP8auOT7Ds9of2DgZTos8PV+CqWRrDyvymS3gZTATf7JMIHiGmUktnguAj08/DNWNr41qaLcpbhMNPwdrz2j1uH5dHPIwBYezh2vd7qEBLGdmNkwu+9eCoEvRhmUQL6Euw/gLYVuDF/wK2m+6foIgkr5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGfzJBsl7+d4IwHO6B/Li7HVpY2JjK59lyp02SuZZPY=;
 b=fuz/NB++vBIVzF1G6+xSdor9CMfhxF9DWwrTqNSmESMI/aElpEmHZ3kNLkIDn4CysClelHa9F6pJcEWihfop4c42HrslJzmKVvVUNyd+wYGpQapqT3pnv7ojGB5Zno90y5mRJMawRbYPLtCpSR4eVEzAfOJpYQPrwDFG3Zdcrew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Wed, 22 Jan
 2025 12:02:42 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 12:02:41 +0000
Message-ID: <85830fd6-e28d-41fe-9061-42c60bf41b9c@amd.com>
Date: Wed, 22 Jan 2025 13:02:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Clarify DM_FLAG_PROBE_AFTER_BIND behaviour
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>
Cc: Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20250117-clarify-probe-after-bind-v1-0-273f046ce5dd@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250117-clarify-probe-after-bind-v1-0-273f046ce5dd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0114.eurprd09.prod.outlook.com
 (2603:10a6:803:78::37) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: 97886321-563f-444b-15aa-08dd3adcac54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFYramcrVEZmWDhrQjlodEFnTlQyZVlvSVNYSUlMYTJNK3gybmdLVDBJVndJ?=
 =?utf-8?B?dlhjbXczNHFnZUdjWXBDRFc3bGRubW11T2hMQkE2ZjJqVUg5b3VtZ1BrSTVu?=
 =?utf-8?B?VkNBL0ZyVXlFM1AraVNsZ1BWUVhCVzFGeTFhR0pVc1FkYURhNnM2dFBIR1pN?=
 =?utf-8?B?ODU4bGRqUXl0Z01oZDhzeFdqWUViM0h0a3YwMm9qVEtrdEN4NzR1R0ZMZkFQ?=
 =?utf-8?B?UDlrSVpEaFdNQ2QweU5Ubm1kKzVSbkRIRXlPSVBRajlRalJlelh0M2xkNEt1?=
 =?utf-8?B?dTVCdXJUS2gyNnZ0YWM0cXcramtNSURleFhPYkdkcVpQZDlmL3lnaHBGNzBz?=
 =?utf-8?B?TzFTSnk3aWYzYkZvTjBWVnFZeWYxbE1tNXFFczJMd1VkcDN4R3VRM2Ewd2Mv?=
 =?utf-8?B?QXFoTjA0VWFIcnMvaWN5ZGN1RVJFcnd5Qi9LZlExZXBJb1p6bGU1OUZUaHd6?=
 =?utf-8?B?Z2dYakg5M2hTQ3RQaHgyWGlXY1Z3bHdySTVsZGljNkthS0tua3dlRElxV2ZG?=
 =?utf-8?B?MWFBQk5Sam1Wb1VhempEZ2t4NFNYcEY3cEptc0hQN24zeGxNRW00MDd6VTJp?=
 =?utf-8?B?eHFMQTk4eDZFdGNIZlZpQU1BYlh6aXFUejVVeHlMajhPTnlLWU92aGdCU2Ri?=
 =?utf-8?B?Tngzd05ETE5odWw2MzNRNzYvK0xzd3VhVG9UUEFSZDBmSnUyU01BM2lFaG5V?=
 =?utf-8?B?ek1DQXRETHl2K25ScnlrMTQ5REI0czlPY2I1UG5kemJSRWlzZVhDMEVtQ3Vv?=
 =?utf-8?B?ZitEVU00M0ZEU00zVWlmZXJCdERVNkdhenZRa0t1cytXTDd5YVJtb1NMMzNo?=
 =?utf-8?B?VFplYWc1M2w2dEx2Z1ViclNQcHhvL2xKODlkSGlMd3gydzFRUWorbnVRcldS?=
 =?utf-8?B?OGdQVEgwN21UYWd5TnR0eHpPcVFVUXlza0xuMjMzRTRQYWZOSEtLRkhSSEVh?=
 =?utf-8?B?WDVWOTJOZXo0SVhDZFQ1Q0VjaFgrbDhreHBDa20wQWdMek5pdXFLMktJWUNs?=
 =?utf-8?B?Q1F2YlBmK0ZRenlKUXY1bnVjQUZyZEV1K2gxQUdGWGRJRk01dnRNWStIRXFm?=
 =?utf-8?B?ejh5aFZBU2FqN2FzNzB4QVBvazNwSzFUWE5yekRRaFVSUnRSczh0N1FtZDBP?=
 =?utf-8?B?UkFoWHh4bGQzZWg1THlYQUdrdHJiS3dtUDZXV01GVVFhZlo2K1hIaTNRK3pk?=
 =?utf-8?B?V09RYmpCN1ZzVFdyMVc4bmNiR1pGbmFHbGNROWlGYldtZUZrc2QxcWJnUWFV?=
 =?utf-8?B?UUtkWUhHQTR0WS95ZkhycHhidis1SUNhQkhxdy9VbkRFN2hkVEIwWHh3Z0pS?=
 =?utf-8?B?SDcwcVJoNlJwanFyZzhQd2ZnMjdPSnJPeittZWFwUktzMm5HQnJtbG9IYXZH?=
 =?utf-8?B?c0Z4bDY5OHUzdWwwUjJBK1NRYnAxSXVhN1NLeVFWcWsyRFhBYnZidmYvQzB2?=
 =?utf-8?B?bkJqMml0aXFWdHdPQVVUbEJiRHdNZFNlY1pNeStmTy9yNFJKNVlYVVRadEZM?=
 =?utf-8?B?azhLTk5aOVQ2RFF2Y2Y5ekhhN0RZRHA0RE9LczBXdnhZSlMzbFVDU0ltcVVr?=
 =?utf-8?B?TDBBWEFGTTRCSGdUOUZZZXRBenZIYU9GSHhreDQzVU1ESjUranZPNG5LeHNY?=
 =?utf-8?B?TzgwK2g5SjNtZ0J2dGVxbEdVd25kNEM5TE12cWNYcjFpNjVZTC9rVnhCd1Bt?=
 =?utf-8?B?QlJxVFdmczRhNmpuVHB3NGJXbUdTYWlXSlNmTGFJYU8xeW90eVJST25ZREY1?=
 =?utf-8?B?SldUZUY2bElpV3lrb2NOcmZQeFEydFRSL25NNkhLeUl5bkFoaURrVHU2bVBz?=
 =?utf-8?B?Qi84U2ZQbjRhSWtsUzNxUXI4aXhOWmFCZDd6djZGTi9vRCtkcjVEL1dqU0JY?=
 =?utf-8?Q?2RMcaWRqSDN86?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qlk4b1FTNjY5YXpVbExUZVp2cEVFcWMwQmZsMzF2MHNzQ1FnUnYwd0hiVWhZ?=
 =?utf-8?B?bS9CZUh5cThqdHhvc1paVDJPSE1pa1h6OWpLUUZlN0FMWVJjY1RIVWRTa0w1?=
 =?utf-8?B?T0RYTTdIQUtFNUt3SXdQV0I2eUF5eEk1MkFaKzdPK2k5Q0RTdzl3RU9nUk1j?=
 =?utf-8?B?ZWJEU0ZpT3NxSDhDSEV6OHZ4VE9QUVBBd1J6YjZnWURjbkpsbU5uVTh1R21X?=
 =?utf-8?B?WHdlbVFMT3F4YmkzcUwvL0VzUHlrZkZ0MjZIUmdxK0w1MmJSZk10ZzFSanl0?=
 =?utf-8?B?bjlFa09sZnRrK09ONE5VaDd1cjNoR25aSWJDR1libXB1L0Q2U1hKYndjS0NK?=
 =?utf-8?B?SlFqTmsvRmgrNUQrV3l5WndBL2U0U0hxZ28wYi96T2FsRVAzQWR0MG16T1RU?=
 =?utf-8?B?ZGdseTFZNjZZRnI4UmsrZE5wRUdtc3ZxZ2dGUC84SE5sN0tPTU9SdWtDdmpr?=
 =?utf-8?B?TmNmc1M5NGdRNkdkZ1h0WVBDUWh4ZjlJdjBQTDRESzRmTElhQUJXVWgrNmM3?=
 =?utf-8?B?eTJPL1dUL0xiSDBRb0cwOXNqcVQvdFpvc0FVQXJETS9zRVNxdEc3MzhSOEQ3?=
 =?utf-8?B?c1Mway9GWm9ETTdPbDdQcWVHNENSU3QzT00yaXZPTllwMlFTNGN5QkpyM2xw?=
 =?utf-8?B?SzZMSllxZmJSZ2hTYy93VnV0UktpdnI2dGdoRElJbnJYcndiS0lKb1ZUMXlC?=
 =?utf-8?B?UDJqeGtDeW8wb3ZWMVBCbWFIalFMSEtNay9qZmZPV3dHYitBWWlCdTBMSmNi?=
 =?utf-8?B?THE2K01FWTdKQnpLNHo0dHBWd04zVzdzOGhYWm9RcTNlK2NxamVwSFFFdUJh?=
 =?utf-8?B?Y1A3MU05WWRvSnMxU2RYZThwOHoxcFFFVVlPbzdvd0J1QURWbUIzNGNOTHF4?=
 =?utf-8?B?aVZHUUpSUlVTQWtUazU5bE5yRFlHRlcxeGhoU3pSNGdQYkZtbzZybTlwOS90?=
 =?utf-8?B?OWhKZ0FsWHNjK2xxM2VVU1E1RmtoODVrSFVmaUJ4aFRqV3VyNURlS2ZpQ1Vz?=
 =?utf-8?B?V0t2Y0lYVHY1YkVDd0hLakhQTHNmdGxMelNPaWp5R1UvdGNqZ1ZEZFdLTDdW?=
 =?utf-8?B?UDhsdXluV3pZTVM2UE1HNDV5TzRxNTV5YWg0UjdXcW8rdjc5M2R4VGFZYlpW?=
 =?utf-8?B?a2p3ZDEyMDZsVktNajM4cVl4ZDNFTHcvVlJvTlRySjJvam1QT05tOG45TWhT?=
 =?utf-8?B?dm1aZTZwR3E1ZkdHTVE3eGFZZlRWV3Q0STdGRkdsM3EyMDZpZEV4M2dSWVhX?=
 =?utf-8?B?bUVkeFVlUUkxMG16N2VQbGNLenplandGLzZYNjdia00yOGsrU2hHaTRmalRC?=
 =?utf-8?B?N2NhN3drZ00zNmZtMi9vTjZRMW1rVU15L1QrMGt4dC9PSnhlK1IrWk13ZDJh?=
 =?utf-8?B?ZHVOcHdnbnpnKzc3eDVBeFhlVEJnQTl6MHViV2JMRXRTZDBtR3VLbFB6QTNw?=
 =?utf-8?B?TWlOVUZsRGhkalRKbGEySElmMWYxdnVheCt2bVpmOGRMbnl4a1B1RXlDdVVL?=
 =?utf-8?B?c1lvazhnQVRRTU9ZMUZrdFpHa04vU0JKc0tjalRJT25EbXFDTCtUb0RuTE43?=
 =?utf-8?B?aFRENzVNUzVjWVpscGNsVmVYb2ZZQWc0R3lvQ21jZ0Mwb0F6Tm1abmpEc25a?=
 =?utf-8?B?K21PQW5FRnVNNlZJZSt1OFZqaW5rRnJreTUxTkorU2k2T1QreHJWRU8wWW1F?=
 =?utf-8?B?YlQ2M00ybXRjTTFsZ3RZRk5FT3FkV1lBeklnUEZrZlcxRVpwQld1eVVObTNM?=
 =?utf-8?B?T3I0anc5VytIYXNWTXBka01yOERwWDJRdytSUHBsSmdTY2R4a1FMYjlYU1VT?=
 =?utf-8?B?RTJocy9MYkEyZU43Mk80MDZDa3ZONm9Mc2wyM2RuVXRmNHRTbXJMTVk4MnJ2?=
 =?utf-8?B?cWtEaitZRDVaS0xvaW9SQ0ZyMHNTVkgvMUVaWGVDekJ5T0RFQ2lCK2RTSlBi?=
 =?utf-8?B?MXB4dCtVYWtyL0M2RVNpdkhsaUVjOWNJS1NhWWl1K0RzMXNTL1d2Z2JQOUE2?=
 =?utf-8?B?L0FiYjBscklITnJSdkk1OWJBZzJhajExb2o4eldUUWtJSUwzQUE4YXF3QkdZ?=
 =?utf-8?B?cjJCdW1hTncySENuS0twOUxjdFoxZWpBcGNEUTNSaFloUC94S1JreEEzVEoz?=
 =?utf-8?Q?14HKS/cArCL3Y8cl+kyQJUSCt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97886321-563f-444b-15aa-08dd3adcac54
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 12:02:41.7404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4vHIM3iNx6Ee5jAVRXfCqVx7JEB+bFHUms9WxI0+z/MVzmtM8PK1Q4jcYrcLc/G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725
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



On 1/17/25 08:28, Caleb Connolly wrote:
> In Simons series reworking autoprobe[1], a discussion came up about
> DM_FLAG_PROBE_AFTER_BIND, specifically that it wasn't very clear where
> this flag should be used.
> 
> This series implements my suggestions made there to clarify the use of
> this flag, and fixup the two driver which erroneously apply it to their
> driver struct (this does nothing).
> 
> [1]: https://lore.kernel.org/u-boot/20241120153642.861633-1-sjg@chromium.org/
> 
> ---
> Caleb Connolly (2):
>        dm: clarify DM_FLAG_PROBE_AFTER_BIND behaviour
>        drivers: remove bogus DM_FLAG_PROBE_AFTER_BIND flags
> 
>   doc/develop/driver-model/design.rst | 6 ++++--
>   drivers/mailbox/zynqmp-ipi.c        | 1 -
>   drivers/watchdog/da9063-wdt.c       | 1 -
>   include/dm/device.h                 | 5 ++++-
>   4 files changed, 8 insertions(+), 5 deletions(-)
> ---
> base-commit: e3f716fa2d58aadf53928475ee7e88eb41cb8031
> 
> // Caleb (they/them)
> 

We can't se any issue on our HW when this is applied.

That's why
Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
