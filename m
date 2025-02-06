Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9338C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 14:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5829080AE6;
	Thu,  6 Feb 2025 15:36:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="YjOUmL9c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA2A680B98; Thu,  6 Feb 2025 15:36:20 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D26980944
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 15:36:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpXXC28MKDuv3tn9e7Icd0leSkr8S6RUcv+2e74cSQsjYgdZwgYVW6eNKiBhxzyzYSic+qaOi9ToM9yFeRk2UjbWzHpPsMylONwVCcNlznuUI5TFxmfgvaGbpA8bn7PyGK1XLdxVR0+eteBPmPE1UpTHXMlqlCURyh4zvuLjxbLnkcOeO2j8cWpmwWu4d/ba05B2VDo/Z9y4cWSKSI1dmtvyotAeDOHrExXNS24lnOGq3WngaPjz7j8MkmMDeuOVK6SkQEKKneFRFykLsUWSPaifjmldBvxZgtN+D0aNVn8UbCXv4Th22O4u8VAKnXvNa3YcN7itYSSBVx+IyGY/+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZNdr89KLnUKBv0i2lY2YmHsXIijGhdZEv6CzKNKLZc=;
 b=rJ80PyxJZDmu2UUPiVK8w/mVEf/5rDj3bLlbUhOy7H/3oa3M2LGOEUTnE8YSfcM5sH3utfp69OrhOCpE3oTBq512dCWXeD7RcEcjF1YqZz+AHhvX8wWbskuYiYYSNClKFdpR2tfg3N7Yw7LvdyAKdPWY8VY/WTZGDs6wYGPAgV8Vh7N2OzxkODny30urTyYLYWlXCP1iHwEZLd1CTrgVgbzd6/pNKu596OmJDTRz9T0xJbvZXZiWhtwTdBC35UYe80ZBUNALq6cd1+d3bb0qFtLVnGPFt69umpKy0QydFWFzY+YPp+FRmAk+n128+Df/7vTRdz0Ch1Ywmy0NEb6dJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZNdr89KLnUKBv0i2lY2YmHsXIijGhdZEv6CzKNKLZc=;
 b=YjOUmL9c2farc1xYcuUkBCi40gnRStz1AB87x0J2+RpL4eNa3muSaUp5HKxtk/ka0zJtDeezm3p/YUlfR1bwKd8zG/Rh2ee6wPs0H8idL9LZJjlLT9e+qGf5/0/ZajWP1RiWzsoQW5kb6e/xSQB6WAmVUZ4r6CbbpT5ORZEpMAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB6976.eurprd04.prod.outlook.com (2603:10a6:803:130::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 14:36:15 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 14:36:15 +0000
Message-ID: <7ac6395f-75c7-4dcd-95be-d7d68c04d704@cherry.de>
Date: Thu, 6 Feb 2025 15:36:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] rockchip: mkimage: Add support for up to 4 input files
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250129223641.1888833-1-jonas@kwiboo.se>
 <20250129223641.1888833-6-jonas@kwiboo.se>
 <4dec97d2-0ee8-46a5-bf3e-91776ddb1833@cherry.de>
 <d220c0af-2a28-4592-ab37-a9abf997d254@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <d220c0af-2a28-4592-ab37-a9abf997d254@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0045.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: 72113db5-ff3f-4efb-83a5-08dd46bb9c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OC9reFlOVUxQcGNoMm5HRVFTT2liSVdxRG9BMitiSFVSTjFLWHNPVEhSOTZF?=
 =?utf-8?B?WExsK1hxdlV5c3BDTk80Mk5vMCtjdUJFemlqZ2VzdWVkZHAyUXNCbDY3L1VN?=
 =?utf-8?B?dWFqaHkxWUVQWGh5TTlrNHFSRWo0R21nc3FPajZxMzVRbjVjSGtsbFhLNmlv?=
 =?utf-8?B?SjlKRGdXY3B0Ty9yd29LdHFoditheFZ5NXVzMHZxMEVVU3picHNMM2MwdElh?=
 =?utf-8?B?SmtRcHJ5N2Z1RkRkSWxCVHl0VmwvMjVjREoxSy9taDdQbXAxTVFIdDJQQXJP?=
 =?utf-8?B?MEJPN3Z0YmpxbUJtQ3llYjYxdHFxNkdmc3NkUmI5WVBJY2g4emFlUHJsTjJW?=
 =?utf-8?B?WGI5dFNrL1NUR2pWTGhjOXBCSjZXM09GMGxjaWdqV0FEUWpGMlRtQ0VHT3M0?=
 =?utf-8?B?MzArbnJRWnZHZUE4L3g3aENDMWI0VWtnYlhBaktpcWR6S3hpaDUxZEFEMzEv?=
 =?utf-8?B?cjhYeko0K1NwWnlqQ3dxSVZVMWpUbVBNNmF6bmpnU0NmZnVmaFJ2VzhxOEZF?=
 =?utf-8?B?SWVoaXVmRm1veHpDdU5EZ3ZYdnRMaWh0NXBrRmFJdE1ldEpIL0MvbnQwcFpt?=
 =?utf-8?B?SnROWXRSRlVXTWFUZUxSSTdZU0VMUklKUlhzRE16NGJrYXc0bmVvVUQ2UmRQ?=
 =?utf-8?B?S1NvZzVZV1NmY0kySm9PRnNFVjg0b1k5b0Ywb29tajhaUmFhM2JUU2phb1k2?=
 =?utf-8?B?MkZPM2hvT1NMMEFudkVMSDF5SFNvWngxb1M2dGlORCthYUl4OFhuNXFvelA1?=
 =?utf-8?B?M3VOU1JPZUg1UjV1dXJqQXM4OGlmYXBpMlhBRG9lVEZoT0Y5emJicC9YZHBj?=
 =?utf-8?B?UjJuenFDZU50cnZ3MHd6ZFBPKzVRNlJRU2hoaW8zc29sVFdvcmxxTWt4VXJ6?=
 =?utf-8?B?bEdPT3crSUl2bE5YbjBnMmVxRndkTkdSVW5kWlFmUmJzY2xGMEhGQUkrVG41?=
 =?utf-8?B?azZmclBEWjIzQWJGWWoyQXcrbE4zR1pCdmcwYUJZNHNtTWRqWkJTMDFRd2tQ?=
 =?utf-8?B?QVhlbjhvUi9ydUJFUDZIRXYxNktXWHNTQ1FmYmVtWDEwMllZMEJaQVBvdjA1?=
 =?utf-8?B?aDJQWUFBang2ZTkvd2VldWdQUUpDUkdRUU5oZHhNcEVLZjBnQTFIMXNiRHZU?=
 =?utf-8?B?RklqZ2Fkb0F0OEc1YlllbitJTkMzdmJUUFU4azBpRHBabVEzR3BaYWd4eld1?=
 =?utf-8?B?SWhxVTBCZmszSW52NjhtbXdGUkl0cVcreWZMbU1CREhQWERwQiszZXd6UFZP?=
 =?utf-8?B?eWVsbGsxTCtTMmd2V0ZMeURyUzgxbXY3OU5NdE5VTzZnTWsyQkdrUU1kd0FI?=
 =?utf-8?B?YU9hWHJPU3lOUU1qLy9iREZQOVlNWEQ4bldkdjgvQkNoemU0dEhRRThJRXE0?=
 =?utf-8?B?bk5iOWpPZUhCaEIyVUhjV0I0djh5QVNVWFlxTVJzaENlVG5PSm9DSmVoWG13?=
 =?utf-8?B?YXR3Wlpod01TK0tFQkN4UUVKVUJFT3FnWWJuK25EbFFGKzliTHl0YWhERnZu?=
 =?utf-8?B?YWw0Mi9qeHZuNjRrYjFBc1lMSVVPcy9wb0xuUnNRVDVFTkI1c0pQSDB6N3Zy?=
 =?utf-8?B?ekc5cTlmeG5UeEhFV1UxVldvMU1laTBhZHlsNG1ISTV2a3Erd2RtSzhJTGNq?=
 =?utf-8?B?ajVLczFXdkpBazM2ZE15SE5DcUhnd2xsMXM4NWJQM2FtNUdOMmxySE1hRHpi?=
 =?utf-8?B?QVdNU29nZlZnTWlocmV0NnQ2UmNoekIzbFBma1FBRTFsNnZwWE9jaEU4dUZU?=
 =?utf-8?B?bU1IbldwWDhqa0VuVlZiYUFJdVk0Y2wwOXFLeDViYlBvSzdHd0NtR3p1b0xj?=
 =?utf-8?B?TklZZ2tmK2p3dGxhblRWTGdlTExXKzJCVGhsNk9ydG42U0k5dkVLTWtDT0o2?=
 =?utf-8?Q?x3nOslwO+0UE2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFkrenBoNWlsZFJQOHRTUUEvOWdhUVNSYWhoQ0tNRXZMaWJyc0RzVk5yS29D?=
 =?utf-8?B?WjZidDRralJZQ211K3RxWXJFOXFvYXZyb05sN1hVT2VyVTdCaFRQWmtwRDFQ?=
 =?utf-8?B?eVpZeGhTeWRUU1pCL1A3eFloWWpXRmw4dGt2ZmFLUXNnMmVWNzdCZmFUWnFs?=
 =?utf-8?B?LzdlM3lDRk5FRDZ5U3BBOS9oOFMrNTJxMENDSXNDV1hUK3pNcE5Xczlmelhm?=
 =?utf-8?B?RHB0RWQ0MVVBaVUrZjZIRHRPNXY0bUxLaDdQZkJqTjlGZU13MSt4VkN2bnpZ?=
 =?utf-8?B?YW5iMlcyVEhWSjcrTVM2Y0QrbEJVanMwdnczYXFONXlQaHBkT3IxcGt5Q050?=
 =?utf-8?B?Rm5acEtCVFRKOCtZb05DclpPYUh1RkpJd1BHakxIQ3ppZnRuUGkycEVGbWRV?=
 =?utf-8?B?Mk0yQ1VMN0lIMk9IYmJZdVBWSkl6cUdIa2RsaWlCK3R0cFQxQlpxbjE3MG9B?=
 =?utf-8?B?SC96UEpTT1Q3a1VJbEUydld1ek5rWld4aFAveDJWN0lOZzVQa3VFUFIveGpi?=
 =?utf-8?B?N2ZTRk13SjBVQTdMMWEzSFRCc2tuWHpnSzJ2UWJYWWppRHU4d1JCVTlkUTdm?=
 =?utf-8?B?YStwYkNIVkNLSUU0VzBtTlBtVmNFVkhUV0lHUUUwa1VOKzFRL3pTUW5XekxV?=
 =?utf-8?B?MCtPOXNGblc4TGRIMTZkaE0vVGRkaUJrSVE1L05hd1dJMHN0MExBOXdid2NF?=
 =?utf-8?B?OW5rWXBkMnFHdlZvSkUxcnF0ZkY4L2xVY0xFZHBHNFNKb3VNOWxCUTc4RmFi?=
 =?utf-8?B?dUlMc2pCMCtnc3JxYWdRekJXWWNhRG05cVVmeW9ZRHdheG5rMGJBR1pYTFIy?=
 =?utf-8?B?M0cvUzN1UnIzb0FBbXcwTis1N0tuQzN2am1rcTFvMXZxdUJ4cW5yNnI5Z3ky?=
 =?utf-8?B?MmU5M1dXOExTc2lYcVN3WkFxRkF2OFdOM0tLQnNKQUUvdWdxSk9ZU0szSVIv?=
 =?utf-8?B?TVorbzNOdjU4SkpGSGJMdGZhNU9ZZElacW9sdCtHeTBvaXFjWXpCdUdWdlpr?=
 =?utf-8?B?blpmdHJxK0V5ZGxnTG1ISHJWK0w2dzBwU00vVHgvWUZHczlhQWh5amlxRDQ0?=
 =?utf-8?B?RE9iTlFScXhvbmdUQ1FPTXROSDFmcmpvYTZNL1ovS2JNYVVUbnVxWjRZOUZC?=
 =?utf-8?B?SDV6SEtDWDQvcnpGNTlwVENuOExFdDNjVkM0bldjbDBLM3c3M2VVejV2Q3Qz?=
 =?utf-8?B?ZFhHYmlTeGhZT2FKaHBXS2lNT2xNZG96UFhUOFN6a29qQmZBck5mNnhoOTNW?=
 =?utf-8?B?WDBTK1NuRXdXeW4vbVVmdWhQcE56aUJqcHRNS2ZvSFd2VjZRT2EvYU1hRGUx?=
 =?utf-8?B?OWRKM1FiV3lzNUhaVklGMnJGWHNDdFVLbnFXS0hQZWxiTlFCajNLbXpDTk1z?=
 =?utf-8?B?ZjZZdHVha1pnNmtoYU9MSkRmS3k4Y0F0WEM0M3NkQnNkamZpUnhzQXBqT0JF?=
 =?utf-8?B?QWh2NlU3Zkg1ME0vNmNUZE9md2JlcWNCd1ZDU21XcjdFZ2lQVXFrdG0xaTRY?=
 =?utf-8?B?am5wWDNtbU5hcU5aTnY5a2o3QW13aGpJeGRUR0ozbkZnczdIcjY1ZCttclNx?=
 =?utf-8?B?dW9zZkJTaU1CRUE4cEljRDV0ditia1RMemZBRnNyR3hSOUtuNzBpdGZybkJF?=
 =?utf-8?B?ZDFHU2loSWprVE1KUzIzRmQyaUF3RE1oNXE2TmwwUlNRTXdZVEVBTUhwclZG?=
 =?utf-8?B?VmhkTEg4Y2xuN2VlMTI4ZjFOVklJYXovZElvSVVza0NqUDgwMExEMm1rZCs2?=
 =?utf-8?B?Qng5NE5Hb21iR1RsRm5NRmg0WEhVeGpBdDQ5S1F3Mmp5cFhaSDhsb2NSOXFP?=
 =?utf-8?B?ckNDNjRQMGtMQytMalE1UWx3b1hjdnVNNEhjcWgydmVNV3JnMERITG1Na0V5?=
 =?utf-8?B?bXNUYlRPUXFyWVV0MVFQMkM3ck8rQW01bUtEMGRLVU9STXFRb2Q1V1BsUEVM?=
 =?utf-8?B?N2Z0azRjZXMzOHN4WnZVSmFRWGFjUjZaeTlYczBOOEI4WUhSMUJyUGJ3V29Z?=
 =?utf-8?B?QnlzZitCRnB4Q3NWNkROMm9OK1crNm1sa0tSMXNQeHRvS05PMzhjaHB1eXVa?=
 =?utf-8?B?Q2o0U1lZeFRNN2cza2NNcS9BVTdXUkVHdWhuN05ocmo3bGo0QmlDeWdDOWMx?=
 =?utf-8?B?dWtVSHJ3UWFPSThYN0Zhb2FCYTJRaHNUMldpV3FwOEpxaVEzQzREQW9zUkdt?=
 =?utf-8?Q?4VNgCfxFOjDzxRlQmzwfHn8=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 72113db5-ff3f-4efb-83a5-08dd46bb9c15
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 14:36:14.9295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHDmykdryActAY/pv2ruVGr7xhRbhm1CBueFxr05m+m5GrLu16sjtPPAs0WG8RXQqdKDJ8LYyU5FYAzV5iVcUNF9VRwjGLA3M598P2FnVuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6976
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

On 2/5/25 8:00 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2025-02-05 17:43, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 1/29/25 11:36 PM, Jonas Karlman wrote:
>>> The v2 image format can support up to 4 embedded images that can be
>>> loaded by the BootROM using the back-to-bootrom method.
>>>
>>> Currently two input files can be passed in using the datafile parameter,
>>> separated by a colon (":").
>>>
>>> Extend the datafile parameter parsing to support up to 4 input files
>>> separated by a colon (":") for use with the v2 image format.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>    tools/rkcommon.c | 93 +++++++++++++++++++++++-------------------------
>>>    1 file changed, 44 insertions(+), 49 deletions(-)
>>>
>>> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
>>> index 542aca931693..4ff48e81a636 100644
>>> --- a/tools/rkcommon.c
>>> +++ b/tools/rkcommon.c
>>> @@ -148,17 +148,15 @@ static struct spl_info spl_infos[] = {
>>>    /**
>>>     * struct spl_params - spl params parsed in check_params()
>>>     *
>>> - * @init_file:		Init data file path
>>> - * @init_size:		Aligned size of init data in bytes
>>> - * @boot_file:		Boot data file path
>>> - * @boot_size:		Aligned size of boot data in bytes
>>> + * @file:	image file path
>>> + * @size:	aligned size of image in bytes
>>
>> Not really matching reality though. Could make it easier maybe to have
>> an intermediary
>>
>> struct spl_params_image {
>>       char *file;
>>       uint32_t size;
>> };
>>
>> and then have
>>
>> struct spl_params {
>>       struct spl_params_image images[4];
>> };
>>
>> ?
> 
> Sound good, will use in v2.
> 
>>
>>>     */
>>>    
>>>    struct spl_params {
>>> -	char *init_file;
>>> -	uint32_t init_size;
>>> -	char *boot_file;
>>> -	uint32_t boot_size;
>>> +	struct {
>>> +		char *file;
>>> +		uint32_t size;
>>> +	} images[4];
>>>    };
>>>    
>>>    static struct spl_params spl_params = { 0 };
>>> @@ -238,31 +236,32 @@ int rkcommon_check_params(struct image_tool_params *params)
>>>    	if (!rkcommon_get_spl_info(params->imagename))
>>>    		goto err_spl_info;
>>>    
>>> -	spl_params.init_file = params->datafile;
>>> +	spl_params.images[0].file = params->datafile;
>>> +	for (i = 1; i < ARRAY_SIZE(spl_params.images); i++) {
>>> +		spl_params.images[i].file =
>>> +				strchr(spl_params.images[i - 1].file, ':');
>>> +		if (!spl_params.images[i].file)
>>> +			break;
>>>    
>>> -	spl_params.boot_file = strchr(spl_params.init_file, ':');
>>> -	if (spl_params.boot_file) {
>>> -		*spl_params.boot_file = '\0';
>>> -		spl_params.boot_file += 1;
>>> +		*spl_params.images[i].file = '\0';
>>> +		spl_params.images[i].file += 1;
>>>    	}
>>>    
>>> -	size = rkcommon_get_aligned_filesize(params, spl_params.init_file);
>>> -	if (size < 0)
>>> -		return EXIT_FAILURE;
>>> -	spl_params.init_size = size;
>>> +	for (i = 0; i < ARRAY_SIZE(spl_params.images); i++) {
>>> +		if (!spl_params.images[i].file)
>>> +			break;
>>>    
>>> -	/* Boot file is optional, and only for back-to-bootrom functionality. */
>>> -	if (spl_params.boot_file) {
>>> -		size = rkcommon_get_aligned_filesize(params, spl_params.boot_file);
>>> +		size = rkcommon_get_aligned_filesize(params,
>>> +						     spl_params.images[i].file);
>>>    		if (size < 0)
>>>    			return EXIT_FAILURE;
>>> -		spl_params.boot_size = size;
>>> +		spl_params.images[i].size = size;
>>>    	}
>>>    
>>
>> Can't we merge the two for-loops?
> 
> Possible, suspect I kept it as two loops to avoid having to work on [i]
> and [i - 1] too much in same loop. Do you have any suggestion on how to
> merge the two for-loops to simplify this?
> 

Something like:

"""
	for (i = 0; i < ARRAY_SIZE(spl_params.images); i++) {
		int size;

		if (i == 0)
			spl_params.images[i].file = params->datafile;
		else
			spl_params.images[i].file =
					strchr(spl_params.images[i - 1].file, ':');

		if (!spl_params.images[i].file)
			break;

		*spl_params.images[i].file = '\0';
		spl_params.images[i].file += 1;

		size = rkcommon_get_aligned_filesize(params,
						     spl_params.images[i].file);
		if (size < 0)
			return EXIT_FAILURE;

		spl_params.images[i].size = size;
	}
"""

maybe?

**NOT TESTED**

Cheers,
Quentin
