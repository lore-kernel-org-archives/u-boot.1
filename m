Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD3ED5B16E
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 12:50:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 419E1801CF;
	Mon, 15 Dec 2025 13:50:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f33HL0Bt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EA5E80325; Mon, 15 Dec 2025 13:50:55 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D51480050
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 13:50:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbYpMjofF1+HcjrSBk/EfePXQdlfX2mrXoGqlKpfaygC+mBvmM6xIF2XLHRtv2dIYCehkH6iPGRZbrQ5KSjfH1tcx+DHSXJpiUrv/opNu2+Z580cYCUzSzd0/2heI9XQr6I7MnViDE5ZrTiCmrEbONeUPeTcb1lZgNvymZb7GfJDQuJgaTAsH9h0fu/9s4rK8zFDVddsdfTMZuaRrOiAmqvflhn2Ec0RwTuRn5TeULuMyMQJj72MgM8YvuYF/FV/BPjWH9mtw3dVxPZq7iTk+BWtVzdkhqfjjKHv4gWUBrCUHl2LmBJoa2ObwEybnCAEXzDP66d2W7O96/NgVWCnVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSrsPc0g94pzoTbb36eKaUuMhB3cwkz3Zz9shNQ+UpQ=;
 b=ByfS/q+P3WCbkJ5EtFIZzhZ1T5Z2UYKAjBY0QFiexCQtx6zH8qF25b9iKD60fjjpMq3BXxEFUkfzUAK5f5fy2e/icO18XoE1cY+QR1VQsTie2yf+5SP8CZRmgewMtWfcqgGyuLppyM2ZciB231L08oKf8LtM7G0z0KhUbhP3wrNPWZ5bawcoZvGrIFDnOJXq6NaGvD04XLbrKUazDfGIfvQHYVLSWDZpHbaiHy986ykf7gnYloifY8aWscEp1f4Ulzf+imrrxTPVYlrA3C25cLEPZpgnNvMD7WXu0QiJkecUQ+HOp6/KHimGGqQ/dQXRdyXMwgPlN+s0ndjLzNxKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSrsPc0g94pzoTbb36eKaUuMhB3cwkz3Zz9shNQ+UpQ=;
 b=f33HL0BthxT1hxw2T+FGAzHNDb0MHKoyXPAJd9lpXhT3JFB9Jtl8PIWM00xnEfC7MQI7CjFoEZOnqH9FqmoCebnInDPqoOB2brrAE9av9kV9sOz+dtrynPONPi0WUPweFrKzn6SbRtjrYu07HeKGntDtpDi9gYbVmCeqzZ5bOiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BN5PR12MB9538.namprd12.prod.outlook.com (2603:10b6:408:2ac::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 12:50:47 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9412.005; Mon, 15 Dec 2025
 12:50:47 +0000
Message-ID: <feead0a1-a6a3-4289-a247-4aeebbf7f837@amd.com>
Date: Mon, 15 Dec 2025 13:50:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: mbv: Update defconfigs as per memory map
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Padmarao Begari <padmarao.begari@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Herren <sputnik@on-the-web.ch>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <ed4a3618875869287b87b6b57fd55f4c6a36f046.1765206211.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <ed4a3618875869287b87b6b57fd55f4c6a36f046.1765206211.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:510:33d::34) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BN5PR12MB9538:EE_
X-MS-Office365-Filtering-Correlation-Id: a5840739-a8f0-4eb1-fc6e-08de3bd89154
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R014NmNvRjhCQzZtekRHWmJMb2x2VS9CUElGUlQ4R3JvWDN6ZncrQm5JY05F?=
 =?utf-8?B?OGdFYXo4VlVhc1NaRXlha2loU0d0U2hKaEJuZVNHcTJOU2YveStNTGt5em5a?=
 =?utf-8?B?bWMxYjgwZ0I5ZStGMWpxTGlsd0N2M3c2RWc1eG5haHVMcDFpNHBUWU92elZu?=
 =?utf-8?B?eEdQNWpWVVpQUzc1VmtyTE1HM2VBYmpsVWQzdE9lQkM0dHY4clEwaUhUNml1?=
 =?utf-8?B?RzZqMFB1eisyWTlSVy9vWWtkNXZGd01nNE1wQkMxMUxOU2taM0lsSkhuQ1lE?=
 =?utf-8?B?ejJNNU5pMjFDcXJjKzlhejVZRGhpZUdLdUNEbVpxN1k2V29PMmZOMHo3VHJC?=
 =?utf-8?B?SmtBb1RwQWJHV0xsclEvZzFHQmdjSHE2RmZydWhMOExUTGNHWVhqZWd4cFdq?=
 =?utf-8?B?aDhFKy9Gc1FCbmZrOHJXT0pGdThrQ3diRmNUTVY4cm9jYjV3UnhFV3hrVGZH?=
 =?utf-8?B?QWF3MEM0bGpac0d5VTloKzRCbmxOeTFxcFdnR1lmY1hxcXZMcTNTTzh1V2Q4?=
 =?utf-8?B?eitFL0s0Y1huRDEzT0o1UkZRRHg4MzQ2dzk3anJ0Y29acE03RmZsWGpIM3ov?=
 =?utf-8?B?OGYzWEwwcDNRUHk4SUIvem5vV0hKL2RNSW1xRjFYdGtBRU0rbHF5R29nOUp0?=
 =?utf-8?B?S1dSVVl0TzUxYVNzL0ZpQ01wWGNyR3ZLWU5Ic1liUE5EN1lUK3hRK2tub3Bh?=
 =?utf-8?B?dUJMaVV5T2pmL3BCZmREY1hQTk5xR3NvSjZ5QzhoL2MrbXVhTGtDN2tjaEdt?=
 =?utf-8?B?QVFhNzRPOGdxNVdqMTlDSmhPNTNjVDd6OTAyVzlKYitXbzlEK3ZKSTVzeFVy?=
 =?utf-8?B?NFF2cUNXY0lJNTRHK2VpT1VRaGQvVzVMK3Q2MXRnay9ROWN3TVQxS2xvOE5Y?=
 =?utf-8?B?VUhmTWV1V1R0KzRXMmtTR3hsamdpazVFRnpwdEx1YXhDUDc4NlpFR3VMeGhP?=
 =?utf-8?B?MkNDeUtmRWN5MzgvR1U0djFuVE5pQzF4Tkl3NXNtVXlQUEo5ZHpwbXl4eVl2?=
 =?utf-8?B?aExDRWpWVjdKNmhsdDQ1VEZSbkdmTmIxdGdCVmFYbzNTQmZ2dFBXL2VQZ2xX?=
 =?utf-8?B?MTd6YXA0TVdDVDZkOFFWNVhvTHZPaXVMbEt4T2I4UERxbzFoaHR3YUV2cE1a?=
 =?utf-8?B?eDhJQ2dnc25YaXZkSjIxbG12anRnaVFSalQ0UVhnQXp6OUs3cE9lT2FkYkNa?=
 =?utf-8?B?Zng2a0wrdFFtRXpDM3NBTG5wNnVReGwzSml2RHNicFpDTVlWRGxrWWh6Z2pM?=
 =?utf-8?B?YzNDOUtnb1JHSnRwWFhHa2xoQ3dlRkZuak1TWWJZRXBEWi9PdTV5R2EvNitx?=
 =?utf-8?B?S0N4Z055bUxxRmIwTmxjTGdyZGErbGE1Z3hIdzZObnovVUJ3bkt3dUNudkFs?=
 =?utf-8?B?ZVBkZXQxUGFRbmc5dERPN08wMk1DTm11VFRteC9MZE15bFJSK2I3cHNxSS80?=
 =?utf-8?B?L1ZuMmZpS3FoYmJsa0NpcFR6Y09hSFhMV0JUbFdoTi9FZGk4ZUwxd1B0bjlB?=
 =?utf-8?B?TnUyaEJQTXkvdGVpT3FNQkZBdDF5Y3BVNlJ5UkVkQlpKUlVXMXcxcC9oKzFD?=
 =?utf-8?B?SEE4QkFjbXp2OUZsZlpjaEtsN2F1bC8wZXZyUlRvQ1BkdmMyakNZRFVjNWJ4?=
 =?utf-8?B?cE9EeVFkUEZqaUFhQ3lKNmdHRm5mbVlsSnc0VlhwM2NuNEgwd1FvTHRQZEV2?=
 =?utf-8?B?WG5qVVZrdStGMXVLRDl6dXJFeWpiNDhTelZLUUhxZFF6UFVhU2xRN1B2ZWR6?=
 =?utf-8?B?QW5JaDYxc3hISGxjSGphMndaRVhFVWtxdzA0QUl3YXE1UGZndER2dWRFRS9v?=
 =?utf-8?B?RG5mZmovdzEzMXBMYXVLMGNkU0VHTEhac0dNZjA1VXVWVW5XUFBtbzRsSDJ4?=
 =?utf-8?B?WkxsSFAyV1ljOWZmM2dsRnpMU0l1NG0xSkZUd2VBNUFPRmVmVXp6QXVaUWxV?=
 =?utf-8?Q?cbmgrrGCQIxOlkCeNcjkAikPNp4EORLu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3MxS0MxR3JXcTlQN29nK0ZvaXdQNXVSK3E0VDA3REdvS0diVjQ1eDY3T2Ft?=
 =?utf-8?B?WHRFdEI1NTRoTDdjaWYyMGhiekZleWhXYzlBZ054a2VmYXU3a1puR0NhQnh1?=
 =?utf-8?B?bkhCMkNvU1hGM0NWYlFySHR5WW9STXFqbVNTNHY0cVN3bjRTdjRwUE9CdDhx?=
 =?utf-8?B?UEpVT1pJSndDYUoyVll5RDBRSVJKR29kVzd4RTdOTXFKQk1UUVFndk5aeGpp?=
 =?utf-8?B?L0VqSUlCQmVCaGFGREhzR3pKSWJKWW5pVko1QXBzS3o2QjBYZExXL2ZNak9n?=
 =?utf-8?B?OTdSemRBeU8vQnFIdWxKRFZxdWJXeUFSREYrc2ZOR3kxRURLSDNmdFJrYXZS?=
 =?utf-8?B?QW5BRXA4elhMa0hxNElabkwrU2ZTUzc5RnYxQVpYa3EvU2IrNGFEMTZ5eWl0?=
 =?utf-8?B?NnpnYkoxN2xTSDRONXVRa0ZmZUlLSGZmWHpMMCtyeFdNaHV0OVI0d3JzMG9G?=
 =?utf-8?B?OGVydTRNK3o4N0NEMWxZbTV2cStvM2cvZkJhcTI2N0lSTzNMV3Y2cm9ubEF2?=
 =?utf-8?B?ZFRuRXVkWjVKc3BNR0VtL2VCNDRvc3lJR2hhQVFoR3RDT1FsdWl6TmVXcFZE?=
 =?utf-8?B?RndSbmQ4K3hxcVVxRlc2eWc2S3J4cUFMMDRwRnBzbndiOG1hazR4eU1aV0VY?=
 =?utf-8?B?ZFB3YzNGcXp1bGVSa0RYUkZZdXJJVlU4QnhNM1h2ZnVZMHd3aGoyaHNKRWZ0?=
 =?utf-8?B?cnkrYUxzdjEvK3hqWmdIQzAxWDUzWmhwZDdtb1NhOGFtcE1xam81K0c5T21N?=
 =?utf-8?B?Z2RmRVJHaExzMmwvVEpIMFNJMVdqcXhoOVIrN04rRmZxSThxR1MyNC9sQ2Na?=
 =?utf-8?B?RWVZaTQ5NW5vSE1hQkEvdUt4WGhSRnhFTTI0T0dsd2ZHQkJQUXphbC8xbjdV?=
 =?utf-8?B?UkJwT20yL1FZN0JLWHJvVDBvaFlzYSt4cVR1RW1Rdk9KL3R0akkxWlpyWFVl?=
 =?utf-8?B?eGVOQ21nNzFqWVMySk1FTzU2SkNUckRSb3c5cmRCQ1BkMEVFbHA3TkpLb3Qx?=
 =?utf-8?B?NnplSjduSFU1M2Y1SXoxKzJtbkZSSGkvTzRDUndJbUxzL3czMUliSGFMM1A1?=
 =?utf-8?B?RU1uVnlZWFkrUFRyZFE5OGJMeUZrdXhHNVBsbXJSMk5kWjh1Y0lPUGw0RzJr?=
 =?utf-8?B?c1MzQmR2UDRGaVRRV0ltYktwQk8veVBTYUY2em0zazdYUGUyU0N6L3J2UTV2?=
 =?utf-8?B?aWFkOUpNZHNsUjVVVTl4UjVVWEw5ZnRDdzZSbVovL29CdU5HSVlBV0RadXAv?=
 =?utf-8?B?RkxzR0lBdllySTk5WFcrSVdNZWlyM0Q5YkRHcTV3aE9MdmE0RUFTbzR0bmFu?=
 =?utf-8?B?cFNXcWp1VXdyaXBsNzBYVERvelFPK3JoMzFQZytRNU5JcHp1YWgvZ2YyZGRB?=
 =?utf-8?B?VVE2M1FtQ1hCUUJLd2xnS0xTWlBYSUhZQWlIS1gyVDRhV2pBckhzbjRkRk8y?=
 =?utf-8?B?L0FlOXFPMHhtaHB5bVVROUNEOEZucmplRXB4ZC94Wnk5R094dFlPM2lqVFJr?=
 =?utf-8?B?OG5XWEZuTklGc04yUE1Wb256ZVMzVjB3NTZwOTJ3b1pFWFVSU3BpRUtjcWpl?=
 =?utf-8?B?L1JPVXIwOU84UFlFcnhGV1lRYnBHS2xOWWpxVnNySkpLUWZ2U0owYzlVL3FB?=
 =?utf-8?B?NHZ3SEQ2a3lWZFl4L0trb2UwWFl0aGlLTEsvV0NzNzhLY2VaQk8wSkdnRHdp?=
 =?utf-8?B?enphU3RxenZqR050bElYL3dTemoxTTAyeldqWWxzTWlyY1VnS3Y4VUM1S1E0?=
 =?utf-8?B?WEV5WWYyeVJJYWNrWExnZlhtSG5kMGg2b3JUcDAzL3d1L3BEQVNTZ1hUODAr?=
 =?utf-8?B?VlJ5a1p1bmFYRkx2ZDh1QVVGUDNRTEdwcTUxZnoxSUNrYzJaUi9MbXZoZWxv?=
 =?utf-8?B?Smc3WkYyVHhOMjhLV3c1OXhLR0tvM05wTm1LclN6RzVXRzYxS0ZNeU9pTVBJ?=
 =?utf-8?B?NGZuSHJwUUdKSnZWcDBXTFdxRzFHRE0zTGFpSFdvL2luenE1cUREejVwcVpW?=
 =?utf-8?B?NkZ5Y3hROFIrdGd4WUpOZVB2aFl4V3EyOHkzcEVtVWRzZXR4ZS9FLyt6QU1a?=
 =?utf-8?B?cjMrcnU0WVVuc0hWOU94cW5YVUx2TUhiRWptM256eDRKL2YrT1BYaHJaM1FL?=
 =?utf-8?Q?jn6fn5qBMU4pKrJzXGlX/oKlY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5840739-a8f0-4eb1-fc6e-08de3bd89154
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 12:50:47.1554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDgk8fKNj8v+PmOMjZ6pzBVS36qt7jYe/fYzB4PoFyiYwRE9nYEG479g6wxBwik8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9538
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



On 12/8/25 16:03, Michal Simek wrote:
> From: Padmarao Begari <padmarao.begari@amd.com>
> 
> U-Boot SPL should be executed from LMB BRAM, where its text
> and data sections are located, while the heap and stack are
> allocated in DDR memory.
> 
> Because on the MB-V platform, after power-up, reset, or FPGA
> load, execution begins from LMB BRAM at address 0x0. Therefore,
> the SPL binary must be placed in BRAM to support this boot flow.
> Without it, the system can only be booted via JTAG.
> 
> A 64KB LMB BRAM region is allocated for U-Boot SPL, starting at
> address 0x0. This region contains the SPL's text, data, and device
> tree blob (DTB) sections. The .bss section is placed separately at
> address 0xF000.
> 
> 	_________________0xFFFF
> 	|BSS            |
> 	|_______________|0xF000
> 	|DTB            |
> 	|_______________|
> 	|Data           |
> 	|_______________|
> 	|Text           |
> 	|_______________|0x0000
> 
> A 2MB region of DDR memory is allocated for U-Boot SPL, with the
> heap starting at address 0x80000000 and the stack at 0x80200000.
> 
> 	_________________0xBFFFFFFF
> 	|Full U-Boot    |
> 	|_______________|0x80400000
> 	|Load FIT Image |
> 	|_______________|0x80200000
> 	|Stack          |
> 	|_______________|
> 	|Heap           |
> 	|_______________|0x80000000
> 
> Since LMB BRAM is a limited resource with a practical size
> constraint of 64KB - it cannot accommodate all runtime data.
> Therefore, the heap and stack are placed at the beginning of
> DDR memory to ensure sufficient space for SPL execution.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/xilinx_mbv32_defconfig | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
> index 9e3c44352a15..42dc5fb282ad 100644
> --- a/configs/xilinx_mbv32_defconfig
> +++ b/configs/xilinx_mbv32_defconfig
> @@ -6,11 +6,12 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x81200000
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv32"
>   CONFIG_SPL_STACK=0x80200000
> -CONFIG_SPL_BSS_START_ADDR=0x84000000
> -CONFIG_SPL_BSS_MAX_SIZE=0x80000
> +CONFIG_SPL_TEXT_BASE=0x0
> +CONFIG_SPL_BSS_START_ADDR=0xf000
> +CONFIG_SPL_BSS_MAX_SIZE=0x1000
>   CONFIG_SYS_BOOTM_LEN=0x800000
>   CONFIG_SYS_LOAD_ADDR=0x80200000
> -CONFIG_SPL_SIZE_LIMIT=0x40000
> +CONFIG_SPL_SIZE_LIMIT=0x10000
>   CONFIG_SPL=y
>   CONFIG_SYS_CLK_FREQ=100000000
>   CONFIG_BOOT_SCRIPT_OFFSET=0x0
> @@ -25,10 +26,13 @@ CONFIG_DISPLAY_CPUINFO=y
>   CONFIG_DISPLAY_BOARDINFO=y
>   # CONFIG_BOARD_INIT is not set
>   # CONFIG_BOARD_LATE_INIT is not set
> -CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_MAX_SIZE=0xf000
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_SPL_HAVE_INIT_STACK=y
>   CONFIG_SPL_SYS_MALLOC=y
> +CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
> +CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80000000
> +CONFIG_SPL_SYS_MALLOC_SIZE=0x200000
>   # CONFIG_CMD_MII is not set
>   CONFIG_CMD_SNTP=y
>   CONFIG_CMD_TIMER=y

Applied.
M
