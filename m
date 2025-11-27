Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBBECFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 04:21:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C2EB842C4;
	Thu, 27 Nov 2025 05:21:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="aPTsO66L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 162AC842C7; Thu, 27 Nov 2025 05:21:52 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 348ED842BF
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 05:21:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYcNHptWhkdWGFxNjnGU08VVNGzZZle5oF9mMXawFsv1hfUOP/uuf4FjvVoNHShBMj2dd/5bMzbtDrPvFy7/n3wJH71Ss/77dPZzDmWFKrIqksnwf2ytZhs9/NlqcBLZ50zs3AlawJlVnuPltf7+dl+HD/BrxAU5nTPe6SZ6Ym0HEk/TC+s+HEESDBTiG1ymAl0bR09SThyQiU1MkltoRp05V8cFOg0pONvCKsg3jBfPfuIWjVz9yIxnfZfppihCuo09IcjQ1uzpJSFo0yn3oAuOj7HATJqpuwgsuMmq9G6edk0AgWMOFcfJHObCUtXTPEDmW6V6FiMChrKrsBDwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRLxlCjnPBbVacRxFLjzv5hR7yC4WE7X12t8OOfSQsc=;
 b=gSo1vPUhm/SrvX8/hpj572wUFYwE5vJbsqMFMlRWUfok1B97MZCa2mDEx2KJBFSC7y/rZITmBPTc558qhFTEYADNJSAbsX2/Z6Wz7QYbFY3Oeok/T7ok9JPT5GIgNAhjWBVIlUE8Z3KbTfwNjM2joK43kvIHLKD8fZlSzVG8k2bjJoA2pOhB1HfqKQbMBBXCTNIXkexlTKCdewmskXQflGYi4TQX7wUrbl8Fh+jB/4Xqd+rDU63Dh/+VbePRow2I5QBIpLm6kKTq/eYePxcpVGKC/bxZHVZmWrqYE7d4ZMPzvWbQ/a6dvuulcLH+hLjIpIYNlcqYwIlBPQPFsfl8oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRLxlCjnPBbVacRxFLjzv5hR7yC4WE7X12t8OOfSQsc=;
 b=aPTsO66LIb6ysII/5rP9EXXOD1Ix0ogyNW6uS0tQmKj0hhj0iVjgsNpVqQ2B4VmsBGB56eQHq4a+srl3nuy4vRAs2fq3cGpw9aRZyRY+ZjML4gnEwxrgUO5GERQfDKXNm+31ynwOzEegH23888YiLLqpHygu9uFKJZ6xa3SXpbcxB4110UTn0blzFmGiVnIFgji00xh3uRAsul5r0KmSQ50pkwn+4HO/Yw4w3MIs2Kj8D7T8s9Gy2OOMU4uqNFzzfS4M+GcNeaBqep1kLl8I7IMPJMbzYJSsBGK9sbhEtvSDH06t1FJIHFg/iVBm7sD+FN4rV5HBQtQ0dSuoMoZU9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by LV8PR03MB7373.namprd03.prod.outlook.com (2603:10b6:408:189::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Thu, 27 Nov
 2025 04:21:45 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 04:21:45 +0000
Message-ID: <0720e9a5-536a-490f-bb28-87efe50289a4@altera.com>
Date: Thu, 27 Nov 2025 12:21:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arch: arm: mach-socfpga: Adjust a raw sectors for MMC
 loading of U-Boot from SPL
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Brian Sune <briansune@gmail.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <c1dc5e70f6bbde1f2b7dfd027a90f09bb4c1e939.1763140421.git.jan.kiszka@siemens.com>
 <e39163e2-cf21-4a73-8170-8066d93db049@altera.com>
 <c536c33d-8330-49b1-821d-3d218c49ae23@siemens.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <c536c33d-8330-49b1-821d-3d218c49ae23@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|LV8PR03MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 169259eb-b40d-4145-9084-08de2d6c7925
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajRmaU5zYmF4L0t2cXB1MkxrQU5JYTkvb3BQdWlleUdVS0lURGE5ZXVlMXE5?=
 =?utf-8?B?RSs4R1hHRHJ4dXZGNHR6anVKVElGcE1Nd3QyOUJqajBoQWhSUk1Jd1dOYm1U?=
 =?utf-8?B?aW5SYUVuME04VVVBN05XcnVpQWRwSkVRREg5YmJpOFZBWGpzMnU0allzcjJR?=
 =?utf-8?B?amdSa21IM3lxSXFyTFhnK3dBY1RCVFY0dUZCOThXK2pHb1FjYkVEWStucmZI?=
 =?utf-8?B?T2RKMWFhdFZJTmJLRENSSkp4VG90RHhJUzY1OTNVdDZQQTQza1BFVk9LckdE?=
 =?utf-8?B?Q2JpY2grM3pTQ1dYTjhjNENMNUdDdU5TZ2hVZFR2Zkl4SGNFUXdTQjNRTnhX?=
 =?utf-8?B?dUtsVnREajV1WE5LQXV5SGtGUjdHd2MwTy9LZmVvaCtzaE44a0NDeHBnT3ps?=
 =?utf-8?B?V3kyWHcxNjk0Z2oxNXpHOFQrWlBoZDRCSWlCQnB3akFjS1ppTHFMczUvZjFk?=
 =?utf-8?B?ZGV5MVFuSG5BbnY2NEx1NjBOWmJpdUVNS2dpOC9tUmJrMmRXV1FpY1lBMEpP?=
 =?utf-8?B?TCs0YkgzUzh1eHpmdDdKbXVHNFRuSVJldGQvejlHejRlLzB3aThEVXEvTTNt?=
 =?utf-8?B?Zkh3V1NTcjJBOHRjMDczNkpoQmpGNWkxanpSSjVkaE1KdktDZXRKc1RpNytq?=
 =?utf-8?B?U3FVYW92U3g3Z0pTTHRSOWExcG85aURDOU1YbTg1bVJYdlkyTk9XWDdGRGgw?=
 =?utf-8?B?Z2R3SmllMW53aHBxL3RCbUQxeVpGNm41YzdZMXcreE54eGVubmVkQ08rdVp4?=
 =?utf-8?B?ZlRIbWN1cGthZDVYdFVhZWo4QXJLc0xXRjBFRmRWVWxvU2FwODR0U3dlblJu?=
 =?utf-8?B?dlVTZGxzVnZ5Z1plbjVjWmN3ZEtNUWZmbnRvN2VwQ3ZYVTd6aHFMUFVPdXJh?=
 =?utf-8?B?L3plaFJwMTErd1JWNU0xeU5aMFNIQ244WG1DTElDd1JBYlArWGVkbFpPcTBv?=
 =?utf-8?B?NkRUOTkvRkVKOFdsN01uSHoxUHB4ZU1nMjQ5UHhySGhmejBpSkVpbmNTbXFN?=
 =?utf-8?B?alhFem00NWZpeE1HcTZwaFJzN0JEWUQzREoxK0E2SVA0MUV3b2tVV0tKcjky?=
 =?utf-8?B?ejRRL1BwYVdNaU1NeTlCVFV4TDBOaFNFcG5tOWh1Z0xMODBSdlVxNFpiT3hw?=
 =?utf-8?B?TUVoZm1WdGJoSVgvTnprcFdpZTBTT0F2bENkcnBHSXJ2Q0hqdC9qVUl0QlhI?=
 =?utf-8?B?SHBPcXk2bVNRNVVzaFlGUS9PVlZUTXBrM2d6T1g1TFdvVitxLzdHblJkNDRH?=
 =?utf-8?B?Wm5uUlhuR0Rvb1ZyeFFkU3hhSXc0M0JDUk02bmtGaFJYMlN5NjNQOFpsaERr?=
 =?utf-8?B?RnNEa2FhMmkvZ1RCYmFZeE9FUmpadXBZdGZ2VmI2Yk9DUmZtbWwxVkxzMEV3?=
 =?utf-8?B?Z1ArMm9FcWU0MEtuWWFCWVFsdXFkeXpNQjlPTW5CajdpTWV6YzdrSjh1UDJJ?=
 =?utf-8?B?NE83eWJrOFRUUjB1WTVid3JQSTBZTWVNN01yLy9mSmJuV2RGdGhBdnV5MkNQ?=
 =?utf-8?B?OHZLeDlaN0VIZTFkVlFTS0ZOTVdIZHA0aS9Yd3Y4STV4SUwrb1VsdzFhMjBW?=
 =?utf-8?B?ZlRFbVBQVy9MbXlGUHdvbDhCTHVEbWNUdWdCQ1dmaVR4bGc5VTZXQWNPRVBn?=
 =?utf-8?B?SzBmQkxJaE5sRTBobXFZSmszdU4xY3FicUVHeXl4ZXVDN0FIZ3pCdWdPNjRs?=
 =?utf-8?B?SHR0QVZ0OFQwcmsxSkd5SFZGVDVVSEo1VUUySTgvNmpQWTIwQ3o5RnpOTm1U?=
 =?utf-8?B?TGtpc2x6WVdwK0RCNDIvOFdNRnNnakJ0VTRwR243WGsydGRyZG8vSWpZdFgw?=
 =?utf-8?B?ekJPMUJMTDJqdjRnV2lRWWh5SmtMelpmcm43djhoZXNYQVJ5dUozRm1Nb0xC?=
 =?utf-8?B?TytaVHdPMlRNMHlKTTZQd0trL0Q2bVNsSWNjTFlObU9KZTlvR1NlcU1Jb1lp?=
 =?utf-8?B?VmlhbTl3TnFaQkNhZHU0WEZOcUdXdTJCQ01CcDYrMDhVS3U3WDZGUTczVS9p?=
 =?utf-8?B?bEZZeUtiSTNnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2RsdW4wL0FaT0tLSDd6VEFTWmJkZXNjVnZrcG1tMXgyd1krWHNRSXA1TFNq?=
 =?utf-8?B?U1owU0dmQTFFbXVlZG9UTklTUzY4SW5iLzFwTXpKYUVMVVlVTEE1RTZPYVpu?=
 =?utf-8?B?N1lKUVlHdDgySlhRRWtXbDVsRGJDQzJucVRrZzkvMitGdWNtZU9jOU1oV3dT?=
 =?utf-8?B?Y0tqZ3dNZWtMUUpnUUdaTjNkWEZHMHR3VE9tNWN5emp0SlN3ODJhb2Ric1pH?=
 =?utf-8?B?UkZmd3lVV0ptdXFRVDJsSEpvNHpFQm9IUXFoTFNKeXVxNkcxVExXM2FEb2Nu?=
 =?utf-8?B?SGNvNnBQdjRaWkJDekJmQUVJYURlbU16bWNyL21IK2llT1JOcklWMHk1d3Bw?=
 =?utf-8?B?ekJiR2xpS0lEZzV0UFQvQXRzVWlhTHBRQ01EWjZ2L3d5T01lRTVQRE52clRn?=
 =?utf-8?B?RHlWc2RGU1hKcFBqanBkTXpGdGJwTVVzNEZxU0U4NjFUelY0bnpsbjVUQ1ZC?=
 =?utf-8?B?ek90WUF0ak9ucWk4dUZDTTFYZ1A0R0NnN1VUaHFkQk5FM0pBWEVQeFdDUGhO?=
 =?utf-8?B?NE1kemxUdlNLWGZXOVJTWjdRTlF6SFVkQ20xNW5LWjdQS2Y3Lzk0L1JnNjhB?=
 =?utf-8?B?UXJxTUo4aVRnTy9xNFBsMnJEbkZJMm5SMk9oQ0pFTU0yYnVJSHJGbDUrRXJm?=
 =?utf-8?B?UEJQTDUwYUpjcnVmYjhPVGtpUW53c2ZJa201VEY2VXZvUUs4LzlNRm9hWVNo?=
 =?utf-8?B?QURWNUE3YlpVNTRKNzVWVW1pOFpvWnBZamt6MVdET1RYemRZQTJqQ1gxcDBV?=
 =?utf-8?B?eVdSR0h3eWV4T21uQTBJRnk4eWd6V0hQMEhtZmhVQ1dtTnNzYnFPcXc0Szht?=
 =?utf-8?B?c3pjVTBaSEVjTXZNUEZLZlZPcmVVTW1ubTlub2NROC9RRStySzNTZzB1cUdk?=
 =?utf-8?B?QkZ4M1VBcTNMWkpnUXJyTUN5anBYeEJoYW93NDVIVDlXSXFHb3NteUZsZjFP?=
 =?utf-8?B?RmNBekIzSys1cFhiVEtnUFZWN0NoVFdGYWs4eEdxaTF6ZVppbUdRR280bi9W?=
 =?utf-8?B?VnB6VkI5eVN0eUVXYkQrWEh4TnpQd09OeFZrNFlBTmc2N1FzMkpWa1g0c0R2?=
 =?utf-8?B?aWtLdnBBQU16eGNNbWtCUks3cW9jZFpXU3Z0ejQ4STdpTXVkZW1FWmNKeUFE?=
 =?utf-8?B?MFFDeVNPeTRSOEhhVGozUDFIa1dNemFvZ2VsREorMGJVbENWOGdxbWNBZmJn?=
 =?utf-8?B?b1p4Zm8xTmlMejdJV21Td215Yk1leGdFN0VuTHF3YzFDaGNiYWN6SlMxeGVi?=
 =?utf-8?B?bHJZdHF1VXhJQ2xOVDdCZ3c4SDdUWWdBeXl6MVZzV0JiM3lKVk1uQlhIQlY2?=
 =?utf-8?B?UmE2RHFGaHVCZFJoZ20yNjJhZ2YwbWhPUG8xR0t4Um4rTjhCMDFFNXRhMzMx?=
 =?utf-8?B?d3dJSVZQMmNIOHpVOFF5UWYxUUVOd0ZWYTZiY3pvK0UwQ3RwN2Z4cDkvOHVx?=
 =?utf-8?B?TkFDQnQ0ekxWVW80VHM0d3gvaWZJTTRtV3hHajJteldKdFpKQjBjVStPcUFa?=
 =?utf-8?B?Q2FURmlUQzNMaTcvSFJDdW5UbDFNMm56bExyWDM1WGhxRDMzK2dDTldkVVg5?=
 =?utf-8?B?Y3RhTE10Z3oreHBhazdveGxhOEVRNk42ZzBqd3lvYUk2TkRhV3lsNTRReEpN?=
 =?utf-8?B?cTJ3aUFSYjVPT0hYWWFDL0Vzb1RjbVF3QnJ0R1JRTkowT0M4NjJnYVpWbFla?=
 =?utf-8?B?ZGt6R3ZHTkMvcE1YbjlkNmZnK1FVNzBJT3J1dUk4ZlljcVlDVWI2amJ6M25B?=
 =?utf-8?B?VldvVkxzeVlvQW96a2xySTFjY3FoZDY5MUY1VU1TRUZwSng1T0FwYUFObjlX?=
 =?utf-8?B?K1Z3b1o2VTI5UTEvYzkyVG9CNERWcXR0Y1JlV3dBa05JbE5ZUTdOdVB0K2Zz?=
 =?utf-8?B?bXROeDZkdkE0d0lJWWNmNnAweVhHUXBmSVVWQzR1ZGw4UmNFOC8vengwWXB5?=
 =?utf-8?B?NUVjUkxWa0J1MFJVTXl3N24vMXlkWHJBK21iK2ZjS1FPZk9qaC9CZkQvdmt0?=
 =?utf-8?B?R25WeWFxM3FRM1Z2Wk1BdnQwblJZWkVVZTZobkk5anZwUEg3TFBvOUJlc3Na?=
 =?utf-8?B?U0daQjdCb214TUtRTUE3aVIzcGFhYXExRlFNUWMvUTd6bjZCTG8vTHd4Smd1?=
 =?utf-8?B?NHdYOVk2L0c0d0pjRzd6Y2FtclRQNkN0U1pYa0IzMzJ0ZTNZczhTL0crWW90?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169259eb-b40d-4145-9084-08de2d6c7925
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 04:21:44.9402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FumlwJ56PJ+dtHMfI0gVEjSaX4CZd8WbSB1Bfy1xxHKkI+QYG7g6yML3dpMgGk8nkAaBTLFNoE296Piz4zdAgpgYObxEjwvgSo7eimdk0/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7373
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

Hi Jan,

On 25/11/2025 2:42 pm, Jan Kiszka wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> On 25.11.25 06:02, Chee, Tien Fong wrote:
>> Hi Jan,
>>
>> On 15/11/2025 1:13 am, Jan Kiszka wrote:
>>> [CAUTION: This email is from outside your organization. Unless you
>>> trust the sender, do not click on links or open attachments as it may
>>> be a fraudulent email attempting to steal your information and/or
>>> compromise your computer.]
>>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> If U-Boot is located on MMC, SPL and U-Boot proper are glued together.
>>> More precisely, SPL is stored 4 times. Take this and its padding into
>>> account and adjust sector number via board_spl_mmc_get_uboot_raw_sector.
>>> This allows loading from a partition, without the need to hard-code the
>>> offset via SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>    arch/arm/mach-socfpga/board.c | 9 +++++++++
>>>    1 file changed, 9 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/
>>> board.c
>>> index 28554b7a109..d756f7381fb 100644
>>> --- a/arch/arm/mach-socfpga/board.c
>>> +++ b/arch/arm/mach-socfpga/board.c
>>> @@ -14,6 +14,7 @@
>>>    #include <hang.h>
>>>    #include <handoff.h>
>>>    #include <image.h>
>>> +#include <spl.h>
>>>    #include <usb.h>
>>>    #include <usb/dwc2_udc.h>
>>>    #include <asm/global_data.h>
>>> @@ -209,3 +210,11 @@ void lmb_arch_add_memory(void)
>>>           }
>>>    }
>>>    #endif
>>> +
>>> +#ifdef CONFIG_SPL
>>
>> The guard should be CONFIG_XPL_BUILD instead of CONFIG_SPL to correctly
>> control SPL-specific behavior
>>
>>
>>> +unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
>>> +                                                unsigned long raw_sect)
>>> +{
>>> +       return (CONFIG_SPL_PAD_TO * 4) / 512 + raw_sect;
>>> +}
>>> +#endif
>>
>> Global impact:
>> Applying board_spl_mmc_get_uboot_raw_sector() to all SoCFPGA boards
>> could be risky. Older platforms such as Arria 10 and SoC63 devices use
>> different layouts, and soon U-Boot proper will be moved into FAT32
>> partitions for cyclone V.
>>
>> Offset calculation:
>> (CONFIG_SPL_PAD_TO * 4) / 512 + raw_sect assumes a specific SPL layout.
>> It may conflict with the default 0x200 sector (https://github.com/u-
>> boot/u-boot/blob/c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9/common/spl/
>> Kconfig#L592 which eventually assigned to raw_sect above) used for
>> SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR on some boards, so this calculation is
>> not universal.
>>
>> Suggestion: Consider gating this behind a board-specific Kconfig option,
>> or limit the change to boards that actually require this offset. This
>> will avoid potential regressions while supporting existing platforms.
>>
> I dislike more magics here. This is surely not board specific, it's
> rather partition specific (raw vs. fat part) as you pointed out above.
> Probably the romloader version plays a role as well in supporting one or
> both, thus the chip generation. Let's encode that into Kconfig, rather
> than magics.
>
> Are there more modes to tell apart?

Thanks for your feedback. I’d like to clarify the current status and our 
recent POC regarding SPL and U-Boot proper loading on Cyclone V.


Cyclone V (Gen5 – ROM-based boot) - ROM supports SPL loading in two modes:
   1. Raw mode – from LBA 0
   2. Partition mode (0xA2) – from a dedicated A2 partition

Our POC confirms that this restriction applies to SPL only. Once SPL is 
running from OCRAM, it can load U-Boot proper from FAT32 without issue. 
This reduces OCRAM usage, simplifies the MMC layout, and preserves FAT32 
benefits.

Arria 10
  1. ROM loads SPL from its fixed boot source. SPL already loads U-Boot 
proper from FAT32 today.

SoC64 (Agilex / Agilex 5)
   1. SPL is embedded in the FPGA bitstream and loaded by SDM. SPL is 
never on MMC; only U-Boot proper can be on MMC, and all boards use FAT32.

Conclusion on required modes
   1. ROM loads SPL from raw (Gen5, A10)
   2. ROM loads SPL from A2 partition (Gen5, A10)
   3. SDM loads SPL from bitstream (SoC64 Agilex, Agilex7m, S10 and etc.. )

U-Boot proper loaded from FAT32 — this reflects the standard Altera 
devkit MMC layout. Other boards, partners, or vendors may still use raw 
partitions, so this is not universal.

Implication
   There is no single offset calculation that is portable across all 
generations. Our POC shows that moving U-Boot proper to FAT32 is safe 
for devkits, reduces OCRAM usage, and aligns with long-term MMC layout 
consistency, while older raw modes remain supported where needed.


Please let me know your thoughts on this approach and whether you see 
any corner cases we might have missed.


Thanks,
Tien Fong

