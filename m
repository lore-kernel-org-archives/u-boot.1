Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6B2D2505E
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 09:38:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6E1C83D52;
	Mon, 12 Jan 2026 10:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="30/ULqZ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D2B783CBD; Mon, 12 Jan 2026 10:38:39 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E172D83D52
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:38:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwxRGc/l2D0XgEf0L0jskrKNxzBUHpteE5JqwndzlIvwi/YpX6+gDoAzvu26JhzOUNkD3kj4kljYM5/W9LE+IQr3ZW4KyAzLL5EOsJPU45Pe74b1a+r7GT/PDW8D2UIMhuWfl1I4W4tRaqBaDWBqn63fQd82PbidCj459Enp7bWB2mTLU+H9oFpVRMoqh6AtKqQnhZBgnhqAQm+cceH2OHn9LcRtVdQ+p/zKk6WbEMQ2zAeA8+xEKshGwmfstjg36iUOKVBCFiwYmhZT32J554ycB3Xk9FTEnJI5gYt8C6Rozrhej1ptG0ph/gxFK7p70SO1N4ou0V3uYwrOkAJZTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGKFLd5Uapu2fTl5MW4KkRT08E9Aw40NYWvyAlB7Tew=;
 b=CHeasPjp3Vr2XADjnKUzn0edT2N6ndpTwA/dkW+KJ+0+DCYXjNGocQYNHns5FQHvNpx/FicEYbaUI7BDflwMc3KBywphiUt4JGPAKIqwuFNTKLgMAe8lF17pub4usKB4kubNHEywkOmEl3U61JYxx3li0WyZC506FZWEcbkVpNqEnXnlxIKojXF1IBM8YsV/EBK/Rz+fCE3en2TsF1JhIV35a4v1sCk62ZTF+FI4iftsAXaD5N+7BMWVdluPG1iZqyTfaQM0LkclxWc6kK3eB3KExku1fjLW6XsC/IkhXGsALSvFTu+f0DgVpdmVvQQ52B30k1ZetWdOnUyizL9slQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGKFLd5Uapu2fTl5MW4KkRT08E9Aw40NYWvyAlB7Tew=;
 b=30/ULqZ69+/M5yODzQXjW+f52VLtvpgllFf8mteIKWm7MOfWsPRRbh0wUv51Awi8wtsKUgfzJum+yoLnD9qzJfOxpCyd8sBBRSisQ/itf4Rwlhw8wd7iQ2TDLoPzjB3LgbPUHhNoXkeLlhx0FGwseSYjVDRc9dzZ/bxsbOHrWNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:38:33 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 09:38:33 +0000
Message-ID: <dbaaea6a-6737-4a05-959d-c800ce425e83@amd.com>
Date: Mon, 12 Jan 2026 10:38:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] board: zynqmp: add cmd for getting boot auth state
To: Neal Frager <neal.frager@amd.com>, u-boot@lists.denx.de
Cc: igor.opaniuk@foundries.io, tomas.melin@vaisala.com
References: <20260108100850.544009-1-neal.frager@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260108100850.544009-1-neal.frager@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P220CA0047.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::19) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: b94ba0e0-4409-48d5-6213-08de51be5a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7142099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkZjdE5rSm1ZUWRwSlNPUmxiR21DSlFYYUxWMkZoWnhvYktqWXRwbUpRVUJD?=
 =?utf-8?B?SmxKdlhmaTRCQkRkM2lnL1h4VXltbFJxS3ZBbisxSlcvSzFLbUZkd3cvc29E?=
 =?utf-8?B?OFZEYmxPNjQ5d0Noc0lMbitKbEd0aW9PSlRWMzU5WmUwZE9zT3QxM1J3V0hz?=
 =?utf-8?B?czBDYWhDcHNOeWZXSU91Mlkvd3MrUzFUV3ZuMFVnZFErNjRKT3dlQnNlYUg1?=
 =?utf-8?B?Vm0rQ3YxYUpobGZjd3o1UDU1SVJ0SHdqNVRNL2s5V0NOcXFiWUpQdzh3L0s1?=
 =?utf-8?B?d3FiZGxFR3NFTHBCemhVWTFHRjdaNGlJQ09qWTFwMjhFMEFEbzgvVlV2ZnRP?=
 =?utf-8?B?WnErU3IzMFJ6ZS9nUEpJaWFEc085a1hrdkp0TFdtMGdmZlpDWk1VM1lEaTFI?=
 =?utf-8?B?SnJxVTVLQXUzUlY2bFdSemxZNmxJQld1UmV6UzZmMVBGZ3lZVHB1Nm9hdU5S?=
 =?utf-8?B?N250VEhMUFQvb21aeEZtTWY1WWZVeGxySEdGelVKcG9RdWlLdFBMVWNML2N6?=
 =?utf-8?B?bVRjMlk1ZDNJMmVrWnBUNWJtT0lSaEx6MXJMV015b09RTXczdnQzbHZRc1hE?=
 =?utf-8?B?VWtRR3VMVUJaVlVyS2JOaGEvWGpYMEsxMjErbFBNRnlOWEJkV0l3R2pIckxi?=
 =?utf-8?B?VTBvZXFCTWw1eFIrNGplS2xRUEFLQldDYkVPa0F2Q3Y2bmNSRGxtMHhSSFFY?=
 =?utf-8?B?a0pncXNkTUhnNXBCaWVjb0k4QkZmdVcxQzZ3aEFlZ0s3ZkpEYmFFVEJwMHNK?=
 =?utf-8?B?Z3Eram1OalIzVU1KSHFaK1pERWxWVC9YSC9qTGJGNUtZc0djKzV2V0grTkJo?=
 =?utf-8?B?Q0E2ODVzek9FMGErTGdYaHVLa3A1c0Zpa0ZoaXVoak0wZjJaRWJ6ZXJ1elZS?=
 =?utf-8?B?VWNPVVlpT0FBcFV2SHJYYldUUzhsV25obk42TGRlV001UWhadENHbW8ybHVL?=
 =?utf-8?B?cG0vd0xkb3hQei9weVBLV2RWNUZpVVJ2OHhVdm1KRXdJRmhlOFlST0lCWldQ?=
 =?utf-8?B?WllOdDNId3I4ZUNlbDBQYWFGMzdiQlNpaVdsN1FFU2plYmgvclhnOXYwOUht?=
 =?utf-8?B?bjBuZ2w5NnoxZzBRK0FoRmxrQUtObm4reU55VVlYdE1lY2xyUVJaVVZEbGsr?=
 =?utf-8?B?RHRJR3JYN0tJUWRoeEE1U0M2V2lhQmpHZjM3UU15M0lVaU5PZ2J1eXovYjFW?=
 =?utf-8?B?akZrQXV4NzZ6MzRiMEVxOTJBSU4zMWJGN2kzR3JQNCtMdXk0ZzFZWGpGand2?=
 =?utf-8?B?NTg0UzhhTE1GQTF3U3dqejh0Y2FGbnk1Ny9GdWMvdnlEK2FYZElHa1UwRTlF?=
 =?utf-8?B?TjhZREpzMGhSNytQMTJCdmlvMUxOM1lpdlBXdTlzZ3ExbCtBdHJSbDQ4Z2Uz?=
 =?utf-8?B?cnRxb2lSTkMvQTlvNjlObm1sRXRqa28vYmlqWFZ2VXBRUEQ2U3d1V3BKM0Vu?=
 =?utf-8?B?WmFzZzJ5VHdSenpKczRnOU1vL1MwVlM2TnhmNWtNNUhvem8vMy9OSnZPU2k0?=
 =?utf-8?B?Q2d4MHZNRi91VDFJNHdaWkFFTFNXazJjOU5BT3QxaEg3SjJYL3pyeXo2aktM?=
 =?utf-8?B?LzE4MVo0KzdQWmpTcUhQSzJyVzF3M3A0R0xFSGRrN0xkNDExbEkwSjk2cXpr?=
 =?utf-8?B?eG9OdE90Ung2a1B1NzZKNG5QN0EwRDhLa2dQVU9ReDR6cWhDRjk1U2tkT251?=
 =?utf-8?B?cUhHM1hBRjlXVWUyRU5pRkNGL3dHNUIrRGoxOGs4cEFPbkJkKzgxMjg2RnZI?=
 =?utf-8?B?UHd1amZuV1d3WmlxT1YrUmdmSWwyZWwxRFl2b1RvUm1rL3hHVnBRRVBvTFd0?=
 =?utf-8?B?cGRERWNFYTFjNEJuV0pJK3pPWmRQdW0zSzNwRjN4TDVTUzdzNlovY3puUjRQ?=
 =?utf-8?B?Ny9ueDA1QVZMNmFCZnZDRmQ2UjY4aUFSek4rZk1XdlBhc3Z3alcyNDZzcU5Q?=
 =?utf-8?Q?nXJSs3LuB2kNNASpiohpWZQUB0x8QLEM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V01EK1QxNVc0RFdsSE54cFBNYnFqb2JIQWwzTWdYbDh1VHBpMzFwbm1vSUZ5?=
 =?utf-8?B?YldsZlpabG5oQTdmOTJ0S2c5VHd2cjlvL211THhOak9rYndWcW5wdmRRV01N?=
 =?utf-8?B?Z1lVYnNYM242UlA3ZGEyekJCdVY3czdVTUYwNTFBRUZWSmc3dmhvNHFVYmFC?=
 =?utf-8?B?SzJnVXdIdEtmZGhVcDM4dU9mZHM3eEt1OER3ZEVYRkRpRk9IUGFINlRpSGtu?=
 =?utf-8?B?dzFjelBFemhFdFpnT2J1ZWs5cVhiTCs4WEk0UzAzb2srRDRCVDN2TGVUTXBh?=
 =?utf-8?B?U1BzalVIVXNNcU56MFIranBMVnRDRVJiSVlnMUF5S096MllyM0h5ekpZaGFM?=
 =?utf-8?B?bVJXTHU0eXVGOCtGeGFHT05NaXRkMXlIM3ZiWWFnSDZUcnJCNWIzMVpHZGdS?=
 =?utf-8?B?b09QQlNOVFZ4VHpVbWEzTERkV3lWd0NCL2NPcU51aytjQXFORk0yQ0ZJVk9L?=
 =?utf-8?B?bDhJOEVuL0crcVZjQWN6eVRhY1g4Q2RHbklHUjYvZzZQeHNNSDBTbHVWUzh1?=
 =?utf-8?B?Z0dpK1M4MWpwSGdSSWpuWmxnVTB2cWR3U2tCOEN4QThFNml0OHZXYXJxSlVK?=
 =?utf-8?B?TmNNMGZLck50QWE2YjE2dW9qdHRyOEFwUmFJZ2ozWksybVRid0dEMmpFK3Zo?=
 =?utf-8?B?dnV1cnBwd1hwazJHeXg1aXBNK0FielZtU0xOVjB3SStPQ2JKdWxpaFpudmhM?=
 =?utf-8?B?K3Vobjl1T1BnS3pBMHVZdW1nUEJsM1VkVFVhRXJncEtrRkZjZU5GaHJHNEdy?=
 =?utf-8?B?cU50Zm5kRHdXVFNpcVlkWU1hM0JZRVNNUGY0RC9vMUJIVkxyNW5yVFNlaE9v?=
 =?utf-8?B?NGl4VVUzMkcxRi9vdDNIbHJOcTU3SHg0a09YSG1mb0NLNEtqOWYreitPZ2pl?=
 =?utf-8?B?TjRlSXdnS2RNK1Z3ODNDeEkzR3FHQWNOL1gxem1FZmszRmt0OHlqQXd0WW5q?=
 =?utf-8?B?N1B3WHhHZ3ZiUXJHNlVhcjFuYVh2MXNITjNmSlN2OU9oVjAzVHViamM2bUo0?=
 =?utf-8?B?SkE1a1UybTZXbFF2VmpvWXVmY1kxV0hKNGNLamhFdDBFZUhSc0tPQzhRdlFX?=
 =?utf-8?B?amFLK1R5WGVjNElmYTdaOFM5VzJTMVJiUEg4QS9VWUtZdktrMitxNjlCN2ZX?=
 =?utf-8?B?U1VyVXJnWUp2ZExRMGx2anNaK1BmV0VQMXM2MEx6bldaSlJSRHlDZFRvemdF?=
 =?utf-8?B?MWZyVjk5V3FTejhFRk4wVkJrMUhxTURuVzFOa1daSEZyMXZOdEo4TXhaVDZy?=
 =?utf-8?B?Q3V1QThvU3dOSGxtcUVDaDMwYVJVQjk0bVE3UDduQTBpKzNwWlVxNkNiQUsz?=
 =?utf-8?B?cjkzbFFuQktjWitUcDZVNWdINVlmOTJrTE9COWVzY29kalBKRDVIU1JTajU2?=
 =?utf-8?B?NUhveDFXMG1LdUN2YUo3dEtJTjdDS2pLMUd6aHN1SEZHRCt6dVF0OFhvRENH?=
 =?utf-8?B?bW12WGRUZ0hScmlUczVtaG4wY01neGpINmorbGlxWUl2RjljbDhLUHJYZEp3?=
 =?utf-8?B?VExpNnFNQXVtVWh0RDg4eFd1SUh5eFVYbGh1c216RFc0dEFEbkhKWHVUaHda?=
 =?utf-8?B?eE04NmFjNERvNEh3MEhHWG5TZkJYQVpmVVVpeUNRSXRtYWU0WFY3ZzRGUFNa?=
 =?utf-8?B?dDBXQW1KSWlOK1Q1VTlSVWE3R3lRMEJ0RUVUNTVJWHVTTmpaZm9rSnZWQlNa?=
 =?utf-8?B?TUxlTXJaMkVDUXRMcVdmUnVyWkh1Q0VITSt2ZzV0eU5LVGF0THAzNlcvNm9s?=
 =?utf-8?B?WmI3dVh5WE9LMWVvN1FRMkxJTHc1M3NzNG8xR1MxMWhGdVJ0RWdWKy9abmNC?=
 =?utf-8?B?QWFvc1JKNXV1K0daQWQxNzZpeFhqYkpkNjNFQ21kRWR6T2F4bVJ4VGZWWEFj?=
 =?utf-8?B?d1QxaStuQ0FYYzlZaVIxSVdSblJtTUhuSW1UYVRZOHE5M0pENE51eDlLbUdD?=
 =?utf-8?B?OXgxcldhUjIyMWh0OVpiSG5keU43YlJGNUt5L2YrSU9PMTRMWmpvRVBMUkFH?=
 =?utf-8?B?RXpZU3RsWW9yTm5aWGxSN2h6WnJUQVJ2c0tVa09IUWVpaklmMGFDS05XWmlm?=
 =?utf-8?B?VTE4Z2k3NUdvbTZSM2p2TlRYZXZCc0dvcWlJREMxMno0d2J5aTFIYWxvZE1Z?=
 =?utf-8?B?Sk5JSTlVelZNOXJpdk50dlUwRVcxYzl3NFZIUytzeFRkOTRkdE1OTzZCV2tH?=
 =?utf-8?B?TDBhNktYSDh5akE3OVJWVUtIVFhKSEI1aitPVmNBMzlMTTYzdVpyM0ZlS3d3?=
 =?utf-8?B?RU1vQmxwODR1NThYVE4xK1N0T0RhZHNiT3Jycjg2Z2Y2S0VXQmRRRnNnYm9k?=
 =?utf-8?B?VWIvUVBXYVdMNThyei85UEVVSGx5QkxQenZ5Q2tuTUpxcjJKNUdaQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94ba0e0-4409-48d5-6213-08de51be5a1d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:38:33.2527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44jOg1LKqOqIM7hLDrU30I/6OcuuO3179vWEyf9HJXHsUKyejT6piiYAU40kbH8l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129
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



On 1/8/26 11:08, Neal Frager wrote:
> Add command for checking if boot was authenticated.
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> Signed-off-by: Neal Frager <neal.frager@amd.com>
> Reviewed-by: Tomas Melin <tomas.melin@vaisala.com>
> ---
> V1->V2:
> - extended zynqmp command with verify_auth sub-command
> - changed return value, so it can be used with scripts
> V2->V3:
> - separated status and ret values
> - replaced BIT(0) with ZYNQMP_CSU_STATUS_AUTHENTICATED
> - changed env variable name to "boot_auth"
> V3->V4:
> - removed unnecessary zynqmp_verify_auth function
> V4->V5:
> - added newline to zynqmp_mmio_read error msg
> V5->V6:
> - changed printf statements to debug
> - simplied status check in if statement
> ---
>   arch/arm/mach-zynqmp/zynqmp.c | 34 +++++++++++++++++++++++++++++++++-
>   1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-zynqmp/zynqmp.c b/arch/arm/mach-zynqmp/zynqmp.c
> index c0398a466ff..42a72ea2de8 100644
> --- a/arch/arm/mach-zynqmp/zynqmp.c
> +++ b/arch/arm/mach-zynqmp/zynqmp.c
> @@ -362,6 +362,35 @@ static int do_zynqmp_reboot(struct cmd_tbl *cmdtp, int flag,
>   	return CMD_RET_SUCCESS;
>   }
>   
> +static int do_zynqmp_verify_auth(struct cmd_tbl *cmdtp, int flag,
> +				 int argc, char * const argv[])
> +{
> +	u32 status;
> +	int ret;
> +
> +	ret = zynqmp_mmio_read((ulong)&csu_base->status, &status);
> +	if (ret) {
> +		printf("Can't obtain boot auth state\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	if (status & ZYNQMP_CSU_STATUS_AUTHENTICATED) {
> +		debug("Boot is authenticated\n");
> +
> +		ret = env_set("boot_auth", "1");
> +		if (ret)
> +			return CMD_RET_FAILURE;
> +	} else {
> +		debug("Boot is not authenticated\n");
> +
> +		ret = env_set("boot_auth", "0");
> +		if (ret)
> +			return CMD_RET_FAILURE;
> +	}
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
>   static struct cmd_tbl cmd_zynqmp_sub[] = {
>   	U_BOOT_CMD_MKENT(secure, 5, 0, do_zynqmp_verify_secure, "", ""),
>   	U_BOOT_CMD_MKENT(pmufw, 4, 0, do_zynqmp_pmufw, "", ""),
> @@ -371,6 +400,7 @@ static struct cmd_tbl cmd_zynqmp_sub[] = {
>   	U_BOOT_CMD_MKENT(rsa, 7, 0, do_zynqmp_rsa, "", ""),
>   	U_BOOT_CMD_MKENT(sha3, 5, 0, do_zynqmp_sha3, "", ""),
>   	U_BOOT_CMD_MKENT(reboot, 3, 0, do_zynqmp_reboot, "", ""),
> +	U_BOOT_CMD_MKENT(verify_auth, 2, 0, do_zynqmp_verify_auth, "", ""),
>   #ifdef CONFIG_DEFINE_TCM_OCM_MMAP
>   	U_BOOT_CMD_MKENT(tcminit, 3, 0, do_zynqmp_tcm_init, "", ""),
>   #endif
> @@ -446,10 +476,12 @@ U_BOOT_LONGHELP(zynqmp,
>   	"	48 bytes hash value into srcaddr\n"
>   	"	Optional key_addr can be specified for saving sha3 hash value\n"
>   	"	Note: srcaddr/srclen should not be 0\n"
> +	"zynqmp verify_auth - verifies if boot.bin was authenticated\n"
> +	"	Returns boot_auth : 0 not authenticated, 1 authenticated\n"

This is not aligned with implementation above.

>   	);
>   
>   U_BOOT_CMD(
> -	zynqmp, 9, 1, do_zynqmp,
> +	zynqmp, 10, 1, do_zynqmp,

This is maximum amount of arguments not number of commands

>   	"ZynqMP sub-system",
>   	zynqmp_help_text
>   );

Thanks,
Michal
