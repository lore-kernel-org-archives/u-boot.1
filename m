Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9019EB597E
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 08:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F20288367F;
	Wed, 11 Feb 2026 09:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qnic1eEA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAC6383E60; Wed, 11 Feb 2026 09:40:17 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7FBC831AC
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 09:40:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuyXkE+Unlft6sKiJspzqP17jOgnI5Z7M47z+uemIYQfSItsCvEzRJLC6DvbkASdLEnhdM15x591GaR20reeF1K6+eaCyllrRuDWh7OSPyoi/RDiGn9uNSsTvCBtyRnR6hGWVXdLUsTpC2k8bGzTbTBifQEcbGQ782oGra+xLMPUxranA3z8OwUtv2+qw0zjt+akd4UZzx4h0bLPv4LPdPEhtjzXtlqisbj0FJZby3v901te8gDwIQ4iq8QiIfwbU34e8k+G2u8TPczvwB6Rgey0e4qupa/+LfyZbV/dPQ+/VXqppx9cX83lDgUnyE/V5sgiw8ooVyEgPu/O87WwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeatA3d5L6WRp01/AjkDG5Qs1a2A0C2VmXPEEolPZhc=;
 b=pKKuFppv6hoR5dbT4foiQTDpIzCok/438CyDn7KDodyfFn9Cz8AglYRaQ7uyZcJqmwApPlqn64vWOtRuNhvVJUdVONw3QoWrBwZND97itubiXgqotN8gdtuGf8sqXW936W30P5PXTkrn/8RI/3v9/snsi5Y9sxhvVHHQV/Z2JsNMrXZNBOxN6iHfhTkow/UFWsoVcCRcLgzj/rLEsVzjPVFHwFPCp0brp5Tc8nkdvnQsoMiqzrOWFizDbnsVRO3En4iPawXqBdYchhwsOyI6x++TIaCPqSH2CrotWqTotXCFH+hnPZe+9POwVsMr0WFh8H8Fly7O+FYySXwTq7W6dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeatA3d5L6WRp01/AjkDG5Qs1a2A0C2VmXPEEolPZhc=;
 b=Qnic1eEAVYILLzdSQQcHJHa2g5f1BlKZWB10uQyo7n7RTJYRxqeRApAY2WS2PNNupXSOM3UbF7uMpXVXMzo+5BR7SlOye2PFJmlyGzMPfZScvgbpkW721tohGxhKEWQhQIk9r3oK1f4hKxEdVjvQDpirqHcoTInFLPhrDCEn8bw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 08:40:11 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9587.016; Wed, 11 Feb 2026
 08:40:10 +0000
Message-ID: <9fc12fc4-d8bb-42b4-8ea8-1f9a0f0ccd3b@amd.com>
Date: Wed, 11 Feb 2026 09:40:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: mscc: Enable RMII clock output for VSC8541 PHY
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, Padmarao.Begari@amd.com
References: <20260129081054.1703479-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260129081054.1703479-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0016.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::8) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: e5aea394-93da-450e-98fd-08de69492a63
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHYwMVpvak95dUtKanU2bTBERmkwNnBBZWFncTVvSUp0WHFneXFydUNVaTVP?=
 =?utf-8?B?LzZXMHM3ZENOaFFTTkhoYjkxaTYvZVNsSFRZem1xdExHUHAzVUVmQkt3bmcv?=
 =?utf-8?B?TlBXT1ZLbjFPUjc1TUcrQkFPM1hwSDl5blFuQ3V1WGJ0aENpSkFRcERLNWQ1?=
 =?utf-8?B?bTVVSEdHOHViWUlXVGxpTGQwc1oyS2F4K3o4eGZTMERpbk1sdXY4bnUvZk0r?=
 =?utf-8?B?VDJidHQyUG1uQkhrN3plTVRtUGR0MEtOTCtla2lXVU9GbE56Rlk2RjM5QXRH?=
 =?utf-8?B?UEM2SUV2c0lJRVBZT2tJVWpNeXRXMVV4MWxKN2hTWThOa0wrQlNuQlYva3No?=
 =?utf-8?B?WHg1dElBeXJJbEYyN01PeGUrYjRrdlAzRzdpNXUzWDV2OFRETTV3YzJIemwx?=
 =?utf-8?B?NW9LS3RyQmh1WW02ZVhFbWZsMDdxaTU5RVJQNWVXMXRFbnBnYjF3cFF3NkZT?=
 =?utf-8?B?dFRZNkZibXN2YkFJNkFnSUtUTmJSQTJ2bW81dHB0VkVmc1lJTTg0b2ZoQXl1?=
 =?utf-8?B?bU5jdy9tK2ZjeGFmTkNhcERnbDZhb25WUk5lVGpuNTNFWG9uR1kwVjJzdlpu?=
 =?utf-8?B?YkZaelZxUkhhSlB6N0l2aHVyMk54VktkaDFvdjNxSkl3My9CcTliaEJkcllJ?=
 =?utf-8?B?TndRZFZTMTVWY0NtVjVDYjkzdzlIV05yZFhWbE9xNTJRcHJISm5pYXF1U3Yx?=
 =?utf-8?B?YWowY3JaTmVVNGtvZWFRbnlMUWhCeTFFall6M09IVGE5MzBzTDh2RVEvK3lN?=
 =?utf-8?B?NWl0bVFaU2x0eS9WUmZxMHd1M1ZxK3piaFFHT2ZsSi9YSWtVSXlCQ0hIYjFv?=
 =?utf-8?B?THIvM1RBQXREakJlcHdmZXdSYnFDRksxV0M1V25Ga3lpbkV5M2NPV1I4bXZY?=
 =?utf-8?B?K2xSTVEvSDNZSmVPOE9TVlhTTmgvbGliRk1qaElIVVFqc2doVEwwRnpyeEpY?=
 =?utf-8?B?ZzZTRktSakJqWDhpSmltZWt6QzVPS05CbEE1SmZwaURVYkJ1UjF2ejh1UnpS?=
 =?utf-8?B?UDU1eEx4UzhlNmh4T1JWR3grUXFjY1JCOWpZTGJIWWtidDl5QUpncHRBRjJj?=
 =?utf-8?B?eUMwNjFwTm5uYmVTamlpRGRDK1ZBamQzUkFFMjV6S3o3Z0ZiRUFXQTlRNWsr?=
 =?utf-8?B?Z3J4Unp0Tk5jSE1XT3NJekRIY25PZDVsaFlWNzZiUEErUnBZd2owTmRVTlNE?=
 =?utf-8?B?d2JQNjVMNG1RaWJ6K3psSVoyeW4wcXRxbHF5WVJMc3pieUJSWjk2Ny9QcUJx?=
 =?utf-8?B?MFdiRlZBUjNadmVNZEZPb0tJUzZUdmNUcmVETTEyam51Sm1acXBzdmdOdzNG?=
 =?utf-8?B?aVY5WWpzODdGYTVmdWE4UDlRTTVLcDVZWXhmSjBvMTJKMjZkenNTQXdURnRX?=
 =?utf-8?B?R2NxM3cvSUo1VHRDQ1NNMEs2UFFQMUtnWGFPa1I2UnM0UjNnR0s4Y09JVHVU?=
 =?utf-8?B?akJHblJDdVJuL1VZSHRPcVd2S01vU3Q1RHJnR3VCV3F6Rk1hODExd3VDb2lq?=
 =?utf-8?B?V3luK1ZaZlZEZnBqNmtiSngzMDdqbklrNStTanBDQnJCWkJXVW1vSHRxa0pG?=
 =?utf-8?B?WDRkTmNFeGNJT01mcEdIbUk3bWkwdVVYb1RuYkdydGhqTFQydmtHYk13UVRD?=
 =?utf-8?B?Q2k4QnVXUGhTbWxLK3NqeEtLazlsTnpOdkhReTBtRjdhOGNXZmNnbVhzbi9n?=
 =?utf-8?B?NldMQXQ5ZVJKL3N3L3pDdndNNko1aENIU1YreWt2SytlV1p1eE9ucmZlWUxF?=
 =?utf-8?B?dlppaUFoQ1JmREk1QmFHcVJEeVdMdG1xVWU2dWNUQVJPeHYrV1NJWnlBWDNt?=
 =?utf-8?B?SHRheVFjVmZTY2tXWTg0bzgzT2tlWkNqTUl3S0Z6aGlSdzFKUENIL25POWJk?=
 =?utf-8?B?dmZRTTVFN2dnR1ljY3lUVG85V2Y0WlFzSFl6RzZjMURwVi9vekFOTGsycW5O?=
 =?utf-8?B?YndEczAvbi83bTNNdzBEMnJObS9iVmEzZGE3WHR4NU8zb08rRW5kSW1qaTFn?=
 =?utf-8?B?T2UxQi9WSlJnMC9PUUs5R29TSEdDZ0R3WUlMZ1lwTHpUZUxyYnIxdnpLdnFO?=
 =?utf-8?B?UXJNc2U3b2Z4Ykp2dmlaTUhYd3JNY2l4ZHZCMHROZDMvUVdCWHhlYzdMNlJm?=
 =?utf-8?Q?2Nes=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGhwWlVhS1ZlS2E2YWxXMUd3NjRRMHA3cUR3azZBMytOZHBpa0FHNGwwTC9H?=
 =?utf-8?B?WWVrb3lzNUxRWXcyVUYvajN5Q1J3a2h4ajlqTXN0NWd3b1lkOEd2c25rY1hT?=
 =?utf-8?B?RDRwckFKMDZvblFXNWk4UElwNnV0eWZNTlpackRsNTRWNjc2Y1RDaHNDczF6?=
 =?utf-8?B?SVJqWW1vdXByY3NTZHN2UFZsY1pGMUEvTzNRaDRWNVYxb1ZnVzJEK3BYZzVN?=
 =?utf-8?B?RWptY0JqSWhxWkdBVjkxekxhWDBYeEw1cTY4ZkNaTVg0czNmaWFKb2hmWHIw?=
 =?utf-8?B?NkU1YzE3bGhrMWlTZVhid3RMWTZmOHhIL3BnKzBha0s2MnpGemNKNzdoYnZF?=
 =?utf-8?B?cW9XZ2toRjBwUHZ4VkVOQU1zSS92a3h6N3pWNi9Td3dxdUI3QVYwcUd3dGs5?=
 =?utf-8?B?M210U2g4M3dKYzlBbk1zUGxYeGxTeUx6V1lld1NYRENaRDNzQ1pNTDZJL2RM?=
 =?utf-8?B?NVd1Mjk5dWlibTlRZzliaE5aYWdkNGtjNVVSa3dBWnRXeG9IU00ycGo4VFJC?=
 =?utf-8?B?UHFKbERUN3A5TzZCM1ZrbkdybnlFdDFjdksvMkJCT3MrQUd3bTl2OEYwUERT?=
 =?utf-8?B?V2xPSkdHQjNSLzV3V2JTT3hGUDB5anpnajdDWGVsaTlCSVlJSmRBTFhYV2pI?=
 =?utf-8?B?VmZOc0ZYbDhhUnFWR09PVW42b3J3OTN2RFpiQkpRSmZ5T3NsUUJqNEtPNWdu?=
 =?utf-8?B?WFRsbHhlUlpiZFpoRGRMUXBaWFRmUlIwNU5FKzB5QzVyc0dPNmdtZ0xXSlJV?=
 =?utf-8?B?RXJUc2VORmllcWw5TFgvTU5xTFBINnZKTkZqL1dUZG0zbi95bFlaMFhxQW9X?=
 =?utf-8?B?SU9IOGFzclNkR0JwVURySzNCaHBwMUlnRVdMWUlaK1hBVHo3ZG9XOHZBdmY5?=
 =?utf-8?B?Y1YyUm83SEFnbnRYV3RFVGhHczd6S29nZEYxdEVMN01ydk9nelJXQTN2bS9L?=
 =?utf-8?B?VDY3N25KOTE4eDNFZDlpcmtpaTZucTFUQTdmdEtXSThtbTk1ZGRBN2pmb05x?=
 =?utf-8?B?THZ5Mlp4bm5OUkZ0b2dURmNwcW5DVXowUkZEVFZOQ3dNeHduTFpxVkFjdENL?=
 =?utf-8?B?bFJ2Tkl3cDJKY0tiaFNXT0N0TzNZSjd6VklURE5uakwvN29SNzVRNWFjcEpO?=
 =?utf-8?B?M29Wa3E2ak5lV0IrYWpWaG9Gdmh1cDIrOHY5a1E5K2VvTWVmT3VPZHMvaGJT?=
 =?utf-8?B?V2kzU0RITFZtZEsvU3crbjF4OGNMNTlOK2F0ZTNQdTh5RlU5OUVVbVNCQzVD?=
 =?utf-8?B?VGY5QVdNQzcrUzltZVI3SjEzdlozTjErUHRpZ0o2ckVhL0pJQUExeVUzT3o2?=
 =?utf-8?B?QTdXbmRtYVVFcXBrZFliclhXZGtPYVRGZ1lrNXdtbWc0azdOZElFRzlsbWpE?=
 =?utf-8?B?c1ZST21sWWdFNzY1VEpuelNldk5WYU1VbjBBTE44VGZBMU5sSUZxdktrVnZr?=
 =?utf-8?B?UTBCbVVuMVorM2t0YjFwcU4zS0p5bUpzdHZzVDNYT3lvcUpnL0hLWENvd0tR?=
 =?utf-8?B?RGwrSmtja29XTDc1QVFtRWIweHV5Z05xdTA3S1ZMd0xaRkdyMkFKRmlIYkZH?=
 =?utf-8?B?OGJsTC91c051VTRxZlErV0pidU9QMlE0d2tSUnhBQ05kNkFwSWZyRkZLdng4?=
 =?utf-8?B?eWRMM3B0VnEzY2hMcThKczd2bXU1bDlESWhIREYwL1pKMXdEVFAvbkdOMEd1?=
 =?utf-8?B?NDZUT0w4U25XdlFrVVNpMmF1ekxUTGlTQ3dVeWFzU2ZDT2pGTlY5MXhlbTda?=
 =?utf-8?B?S3E5L210N09uVmp0SjVLa0JHVnpoaWNEZzM0c2VOSzhKSHpNS3JnaUJDTVZW?=
 =?utf-8?B?ZWRINEFxOTB5WmJxbXZQK0FYT2VXUWE1cGxMUHR4dDVoc1oxd3UxNDR1MG8w?=
 =?utf-8?B?emhjK2pES1cxZlpYeHl0NHlEUkFkWjVKZnYxQitoSzR5ZEc1aXRMV0Excy9i?=
 =?utf-8?B?ZVZvbm5LNzhmZnczUFB1MWtoekpLMDcvV0FWT0twR3N0cmFGWFBGTjgzby80?=
 =?utf-8?B?aThmWE4rME8rUkFMMml6RmtZZkRjazZCZzRDUkxZbGxxeVNSdHRRMHpkaWQ1?=
 =?utf-8?B?WklNTHRjTno2RmpWSm9xY0ZIM21JYWxlck5uU1RQNlpVU1dTSUVQOXZ1UHRE?=
 =?utf-8?B?c2hnMUdIcHFIOWFxMmEzTmc1eWpCVUdmUThqeXR3T003SmtXRFFwL0RVU2dt?=
 =?utf-8?B?Z2VxRmoxRHhOUXVjRHlUSHhIWWNhZ28raEorNmljNUdhRFoxUDNVV3hESDBo?=
 =?utf-8?B?eWZaYnZUand4YlBRd29Ka0FzbHNxWklKUC8vL2RpMnFGOUR0QzM5L2puSHR3?=
 =?utf-8?B?eENGcFRWUUJFMzNVclZZTFNGN29IR0lDamhvcG0vNG9kZEpCV3N3QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5aea394-93da-450e-98fd-08de69492a63
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 08:40:10.7814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZI6nVhEY804JoF1IPKL3dzxK0JflsOjQssLKoWFebIL6S4AB/pIbjqffsTxCE5x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
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



On 1/29/26 09:10, Pranav Tilak wrote:
> Set RMII reference clock output to enabled (1) by default for VSC8541
> PHY in RMII mode. The RMII specification requires a 50MHz reference
> clock, and many board designs expect the PHY to provide this clock to
> the MAC controller.
> 
> Previously, the driver defaulted rmii_clk_out to 0 (disabled) for all
> interface modes, which caused the PHY to not output the required 50MHz
> clock. This resulted in MAC-PHY communication failures and prevented
> network operations like DHCP from working on RMII-configured boards.
> 
> This change alligns with the hardware power-up default behavior and
> aligns with both the generic PHY driver and Linux MSCC PHY driver
> implementations.
> 
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---
>   drivers/net/phy/mscc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
> index bd9cd952975..e93996e277c 100644
> --- a/drivers/net/phy/mscc.c
> +++ b/drivers/net/phy/mscc.c
> @@ -1385,7 +1385,7 @@ static int vsc8541_config(struct phy_device *phydev)
>   		return -EINVAL;
>   	}
>   	/* Default RMII Clk Output to 0=OFF/1=ON  */
> -	rmii_clk_out = 0;
> +	rmii_clk_out = 1;
>   
>   	retval = vsc8531_vsc8541_clk_skew_config(phydev);
>   	if (retval != 0)

Applied.
M
