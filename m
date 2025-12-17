Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77766D64087
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 07:31:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E294483AA0;
	Wed, 17 Dec 2025 08:31:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="RgtIURO3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A44D883AED; Wed, 17 Dec 2025 08:31:12 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B904383979
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 08:31:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAg/w8bkhnDQUs316/F61q3Z3C/V4W9nCbwkAB3mv7muFdq0W+P/vKtIGehN2u/AgWyTo1B3ce4mcVpBJQfub7tC8tl2E7LskcY40cmOz3TT2jHiSmLA/EHuGL7r7zzCK7aFsy0JEqzCYs30fBIJI64loRDw6SukHiGrf5MrfRtQMqGTJy+E2AHwHMh0/hzBz14eTdu6Uqgud8sQ/3FWEwB9qjxIeNi8jUkyJ8WU8Pwf30SMqTeTQShkRdUEe4HiTSJkod0F3kUYYAE5hDUS5IiLR6ILNT8Dt5w5P1WsPShiPLeXwNufvlpttN3XOFOq727GIENqZa6ZyfGGzzUnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QE1aV7uVL8WHtoZp/KnTv0tU87Os7a5OO5w5/mJFhQE=;
 b=K45RPGIjxwffKYByI2eNDNCXiqpIid6f84qHcGvIv5ef8pmRKCXo6iKVwxxJlUQX7l4uw1kFDrxH0FkaOlmfVXdgOtwBCZN7yj2pRLyEQRHjKICwhqmUWU4tuB3Ozz/IukWsUWfyZklbBh6eqsf7I+fKHw5z/DHiRetNrmvhodu/T7shqdHss7/A00QQk6+7lqfQ6VDmj753zf8FHAqiQw+hppU37AEDbAQoU350X6k6HCQsyQajx1A2HbzTcQHbGkwAj+Y/cVG8uBiGcEhCu6dcNYT3sQ1Uy9z5kTDV/c1pudDLvcQ/z/VJVqP3OzqsUfG94PS47e88TNz7JrKS/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QE1aV7uVL8WHtoZp/KnTv0tU87Os7a5OO5w5/mJFhQE=;
 b=RgtIURO3bd8kUAEP9hdkXv2zDbZ4iiU2SbYfhBzzdQFBbuhHeew1JkjhuKQEDRywgVkBIwz2ipzEBIIlaDdkuBsaR0rGLNerHIytlCFnvVn62ZTIaQiPUspsGd+VEHSwyburbTS3f0ChIq0YRpq1PB/hbtnAkEw8yc7kE9PeZ2KTBL2j2oWqOMa/Bd9w5i81F4qyNpd1zOrK3Rw32m3t2vkQXABHRjw0xuHDl9s0t/zJcgr95hUnlo06OVFh4+qWjcWOEB0uoQVNDRHhWaTcWlh6fv6Ye+YGOjtfhlpWGtxA3L1kerwFvP6vIWLSTYFAwgKT39um0smZokm3uYeuIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CO1PR03MB5796.namprd03.prod.outlook.com (2603:10b6:303:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 07:31:03 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 07:31:03 +0000
Message-ID: <e9040f21-d309-4710-b43f-77de515d04db@altera.com>
Date: Wed, 17 Dec 2025 15:30:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] arm: dts: socfpga: agilex5: Add dedicated eMMC
 device tree support
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com
References: <20251215110117.19371-1-tanmay.kathpalia@altera.com>
 <20251215110117.19371-5-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251215110117.19371-5-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|CO1PR03MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: ceddc4da-31f2-4478-5109-08de3d3e3b77
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amo4YjdFVVJTN2JrcTJabTh1bmRtV2pIendxK040Qi8rQ0cyT1FDTXRUeCtF?=
 =?utf-8?B?eG4ySUFobHNKK3NPekZHWTBSeHV4TWRyS2V2emZ1cEc0VGt0bE1GM0VZdFd0?=
 =?utf-8?B?MUZONnM3cUtYMlNHalV6c0J6QjI0UTdNMzk4QmVSQzkzcE9SUm01cUJOZllU?=
 =?utf-8?B?YUpyT1lvb2IzSDRmaFNSYjVrTWkwUTdHNE85V1c2OGhUOU9aVFRnc3FUR2VL?=
 =?utf-8?B?Wis4R2JJQUpyOWVlcHNVWFFEUlVST2ZVbDVqOEI0V3F2aGJIODJXR0lUdjFa?=
 =?utf-8?B?anNGRDdLL3VqN2c4b0d3Z0ZpZHJHQVNzRStidHdEUjZVdmhpb3Vic2VLWlVQ?=
 =?utf-8?B?cm1DV09vVHB4WG9ZVG5wS1ZxaXVxZ3dYM21sZU5EU0ZpVkNMVmJld211Mkds?=
 =?utf-8?B?ckx1M3YzaGtSMUlYa0hJL1JUOGNCTGRwOFFXZGw2QVliL1JWYVAwVlZMZ05z?=
 =?utf-8?B?OXo1TFc3QjhzbVE5dWxWWFpiaVM3d1RGT2tDUUZOTE9kbEpydzk5U3hzNytX?=
 =?utf-8?B?WUhVL3laalhNd0VlQWxIQy9KTnh5a0gyMDBMbEZaN01NT090Zm4yZXIwZW5P?=
 =?utf-8?B?clRqbVQ4TW9WWk5zNElMZEtJakxtcVViS2UreURPUXl4VEswcWlDVWkzWEk4?=
 =?utf-8?B?ZnBMSElYZDBkV29zTWtCdXJ2TXZxOFduR1EzbE5HWDdaeXBCK3VPRjhvQ1Rh?=
 =?utf-8?B?K01XV0tnS2pKc2srRjZOeTVvdmh0UWJ2Nkt1Yk1jekRZOVdkSEVzRzZrY3E0?=
 =?utf-8?B?MDhoMjBGcFJOVWJ4bllUVzhRMU5iaWx0NmpqemFBUHczT0VlQ25jVW1yRXNu?=
 =?utf-8?B?OUNzVWxmdWZJNU5CVXdHTStaRHRLcWlrL2t3SEIrZ3MyUFF4MGsySDNBOVhh?=
 =?utf-8?B?NkJFWUdJR25IR3NkcURaRjBWVjFIZVU4NlBZNnJtYnJVTTdnMXcxZ2ovRCtt?=
 =?utf-8?B?M3VlcnRWMTJ6cnBSWHUvZ2t4OEx2ZzdPM1NTMFl3V1IzMmYrZEVvUkxpeDlv?=
 =?utf-8?B?L29pMjN5RWI2TlJBZXdPc0k0WHRDYTZ3clJiLzdGZXZqQ1dwTDRVdjYxbksz?=
 =?utf-8?B?SzUvdDE2S2Jkc3l6enV5YUYrYWpXMngyVkNHTC9nbWJiZld4S2Q3QTJuY0xr?=
 =?utf-8?B?elBzb2llZHBiTktaem4yNHdIRDNWM1Z2MmlaZUVtMVVPc3JwcEVTWDVrL1Ir?=
 =?utf-8?B?Y05kSE5sc3hWczRldDNrWWh0aVNMZ1lLak5PS3BMbGM3dUNIQ1NobW1RWE51?=
 =?utf-8?B?SjJWT0g0RXJJR3Bkc2pGVGQxV2djM0VIanNwcE9sc2RmdVlPUC83T2s4d2lM?=
 =?utf-8?B?UjRkN3Zid2xIbHZiQTVVTmlmTnFaaUQxbmF5b1QreVQ4TGk1Y2xkdXV0eW9w?=
 =?utf-8?B?dUI4MFI5REZueUtzQzc5Mmo5ZDZKMi9pdmZpMW16YmQ1VHowalJSWWRkcEsx?=
 =?utf-8?B?VG9GWjZzbGZ5elVRTkVlVzlTWkpSUDd4NnFRODZLWmtCdnI2RFNmNEY3dkpr?=
 =?utf-8?B?Mkg5ZzRVQy8xREtDVG4zWUVqRTdJQUZteHhkRlVPL1B3YUZrdTJlUng0UFd5?=
 =?utf-8?B?RDc2dU90QURHTml4US9RNnEvaU9xY1YxZGdFN0J2K2w2NTBQR1NYUm1SaTlo?=
 =?utf-8?B?a1VXSDY0WEs0dUVqSFg2OVZWa1pGUnpHVExkMmY0Y0NCOFFFdVNJSGZMUjU5?=
 =?utf-8?B?VUJSamNrYUlIVUlvRHE3OU40ZTZvL2tJUFBRSHRKWTRPK2pLb1owaW5lYXUw?=
 =?utf-8?B?Mm81UU92dDFMdTlwNllBVXlJek4vRTNUM1BmNjh5WWozRnNVYnlyRnZoZjZG?=
 =?utf-8?B?LzRZNEkvVFluS216ZzRwTlFKOEJFQXA4VHNIYTJWWXhsRFVLa1BiUFdxcHBY?=
 =?utf-8?B?dlZYNGhlcXN1VmFHQ3pmR1FXaEIyZmNmOU1VeTg3Y0k0UFEyZmoyOGNwaVM3?=
 =?utf-8?Q?xKFri3lkwQW3TwHaiDnj9LIr0oo4VHZ0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Smd6RDZKSEtqa29leWh2dVFNZEYxcTA4VGNVZkNOKzFtRFhFTTFaUzhLYU9s?=
 =?utf-8?B?OWxTVjNEZFBuM2lmcGM0aXJBelo3QWU2L3VJRUdQQ0dqSEFOeW9jdXdvQ0tz?=
 =?utf-8?B?UUQxRzcycG5MUnNvWGUwaDNHTUhBdTNKNGF4M213SkFtSDkwYlNGS1VZZ0lv?=
 =?utf-8?B?dGlURkdnbUhUcERXNVMzTFV4TVZybkk2akJOd1Y0SUxaRWt0L0NQSGJkUHY5?=
 =?utf-8?B?K2RXcnJJL0VXOVRQZ1lHWVBPQjlSeUk0cUsxRTVwUTA5YWluNkJGVmlRdDg5?=
 =?utf-8?B?blVmT0h5T0N0b240UTVtVHFUQzlRWEFvaDZlaW05VGtCRXYxc2RvNHZDVEdl?=
 =?utf-8?B?UzIzVVdCNmRTK1hkL1pQQ2o5eURTU2FXdWhvd1NGWlMzaUpzS3VlMmd2bURj?=
 =?utf-8?B?RXAyRHllanZ6Tnkwdm1PdE1CeXB1dUdPSFhKTmRDVTA0RG1xY0Z0clR6cG5y?=
 =?utf-8?B?cHYwbXRzRzhlMExkWElpTjhmWXFpazMvME9xdnpBOUEwQ2FxR0VFU0xMa1FR?=
 =?utf-8?B?WWVvUW5wdlFSTVJQdVJRdWhtbU40WWJNQklVR0xaNFFPRlpEZzhKc29kSXNR?=
 =?utf-8?B?VWFLNkVJNE1VMUdBWldLRUthVThMTXBjbUxyVFpBZHVlZGRDaHdvRmplT0k3?=
 =?utf-8?B?cUZCemFFMjJUYW03TEVwK3dRWXc1bE1FK3FxMUVRbDd0Ukl4YzgyRldUaDlu?=
 =?utf-8?B?VGppUjh1NUhsM0wxWk92S2p3U3VqZGFaekdUamVVTUVWYWtGeFVxVGFXNDBL?=
 =?utf-8?B?RjNGS1hHSTRKOFk5SFpqbWQ3cUVxU0w2M1ROSWc1cktXaDQyczVYcWdyYXJ3?=
 =?utf-8?B?M3YxMy9yb2JiVThyTFRtV0I1b1dOS1JJOHpxZUtXemhjeFpUV3VRblczS1Bq?=
 =?utf-8?B?WmFYdW5HN0VQWGdkWDlxbTczc0E1MmZORUhCQjMzS3BGZjhrOWtUbCthSFJP?=
 =?utf-8?B?bUhqb3FsKytJeXNaYnpoZ0hxaVE3V0dnVXJTSFJCRXRhZUQ1YjJMSk1RR3Zr?=
 =?utf-8?B?N05TRm50TDNUd1VGTjZsVkZBWTJOY1RVelJiemZzeFVTWEhDaW8wamIrWVgx?=
 =?utf-8?B?MDRZVGNOSE1ZWWNGaUtWNUZ2cHJ4WVUzSXlrVGhrNFpiOFRicnpFVUkvMG5L?=
 =?utf-8?B?ZC9lK1hTQm9rMnAweGp2WmpLdTFuV3BYQmk3LzJBTGgxNVZPdVh4enhkUTdP?=
 =?utf-8?B?UDhnZVhtVldrY1VUNXBuYTBmM2FuSkpCOG9jcXZGSm9LZ25OazZsdk5aU2pj?=
 =?utf-8?B?a3RPZC9VTUdUWFNMSzBPcFF1Z3ZnZkx4RjZKamt6bHd2OXZma1BkdURFNzBi?=
 =?utf-8?B?ZVp4WjQyS21XdEM3cDI3NGIvWW93ckMwMzJsdloyZk91NEdVeVllYzBhTGVH?=
 =?utf-8?B?KzZmRU9UV05hMXNzZk0zRkE3alVjS3djYk1CTE52SVNsSm1UWkhKZzNNQnU2?=
 =?utf-8?B?QkdzT1A3K3JMZ0tJYlhBYkFYenNIMncwOTZsR0UvemcvR1orNit2cm9NcVVM?=
 =?utf-8?B?M2NOeVFYREMwWGUzQ2NGcE5pTFM5YUNnM2FYYkZUUzE2T3pzQmwydFg3Ylpj?=
 =?utf-8?B?OXM1UU5IaExuNk14UjJtRE0rYmRGU2tELzVJang3REVSMkd1anRIaGdRM0ZV?=
 =?utf-8?B?K1VQcEQwWXk3YUJaWWZIUXFWa3F5Smp2Zm5ibFNOdE1nMzRiOEJLTmZadkxZ?=
 =?utf-8?B?YzVVS3VFMjk0Z1dTOVBKRkRvRnZybkRHM2poVlZ2OGEvOHl6MWdpU0RCYXJ5?=
 =?utf-8?B?bTQrU1BoZTg0ZklsVW1xNER3S0dZaDkrQUN2UEo1TmIvL1pXdXZwdDBZWDMx?=
 =?utf-8?B?M3FFR3dQeVNhS3NMRXVLYmtZczBCcC9SeHlCSXlhdjh0VEkvaHhtcXdya0VU?=
 =?utf-8?B?OVNobnIwNTFFRU02NDgrcGNzWlAwcGJuaFlMaDhXMDB0ektmN2R1cERyM2Ri?=
 =?utf-8?B?VXdBUVlPK1Y5YjZmcmxKSEN0cnhWMkdrbEFDclhDUHA1SEJjZG0rK2lZYllP?=
 =?utf-8?B?ZUFTeVdscE53NVVEWkQxMUdZSC9oQ2Z6WC84V2s1cHVIYjZQZ2l5Wms2aVgv?=
 =?utf-8?B?Mk9uM1hBVmREMlJKbFR6RFBZM0NzR3VQNHMrOTlIV1VzaXBxMUR3VUw1V2pk?=
 =?utf-8?B?clltUDN6L0VpYktoejA2Smk2VVNaQ1A0Y0pvc0YrTXErQVlSUVlVNS9CRlls?=
 =?utf-8?B?NnRkVTN2NmgydituSzk4RnZZOHU1bXVwU2crbFZhb0JhQXpWTDdVaitIZ010?=
 =?utf-8?B?M0pRYktvTnRuc2g5OGpGMXZnK2dYYXJKSE9xUnp0NmZONWZ5RXhHVEhxZDZx?=
 =?utf-8?B?L2hNNGNSaHVKZE1PM2hkSVhza0k3M1pSWHhxVm9Gdk1sTGoxSmNMalNzK05U?=
 =?utf-8?Q?bWntDbhBZeEz5GCk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceddc4da-31f2-4478-5109-08de3d3e3b77
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 07:31:03.1483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLVIlLXXI1gopDPpvvASutpHpxkCydcfwMo4FN9wfJ8olNnV0chVUSPJILwb7rbhPRkLTg7K8Kmjig/6OnnhWdsu4Dl8iwBBfxb6QBZxqkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5796
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


On 15/12/2025 7:01 pm, Tanmay Kathpalia wrote:
> Add dedicated device tree support for eMMC configuration on the Agilex5
> SoCDK board, providing an alternative to the default SD card setup.
>
> Changes to socfpga_agilex5.dtsi:
> -
> - Configure always-on regulator for stable eMMC operation
>
> New device tree files:
> - socfpga_agilex5_socdk_emmc.dts: Main eMMC device tree configuration
>    * Configure for eMMC operation (no-sd, no-sdio, non-removable)
>    * Set 8-bit bus width and high speed capability
>    * Add timing parameters for legacy and SDR modes
>    * Configure voltage supplies for eMMC power and I/O
>    * Add fixed 1.8V regulator for eMMC I/O voltage supply
>
> - socfpga_agilex5_socdk_emmc-u-boot.dtsi: U-Boot specific additions
>    * Include common Agilex5 U-Boot configurations
>    * Set SPL boot order with eMMC support
>    * Enable necessary peripherals for boot-time operation
>
> Configuration files:
> - configs/socfpga_agilex5_emmc_defconfig: eMMC-specific configuration
>    * Inherit from base Agilex5 configuration
>    * Disable GPIO regulator support (not needed for fixed eMMC setup)
>    * Set eMMC-specific device tree
>
> Build system integration:
> - Add socfpga_agilex5_socdk_emmc.dtb target to Makefile
>
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
>   arch/arm/dts/Makefile                         |   1 +
>   .../socfpga_agilex5_socdk_emmc-u-boot.dtsi    | 178 ++++++++++++++++++
>   arch/arm/dts/socfpga_agilex5_socdk_emmc.dts   |  49 +++++
>   configs/socfpga_agilex5_emmc_defconfig        |   6 +
>   4 files changed, 234 insertions(+)
>   create mode 100644 arch/arm/dts/socfpga_agilex5_socdk_emmc-u-boot.dtsi
>   create mode 100644 arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
>   create mode 100644 configs/socfpga_agilex5_emmc_defconfig
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index fcad6fb2fc7..4e39c795e1e 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -451,6 +451,7 @@ dtb-$(CONFIG_TARGET_THUNDERX_88XX) += thunderx-88xx.dtb
>   
>   dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
>   	socfpga_agilex5_socdk.dtb			\
> +	socfpga_agilex5_socdk_emmc.dtb		\
>   	socfpga_arria5_secu1.dtb			\
>   	socfpga_arria5_socdk.dtb			\
>   	socfpga_arria10_chameleonv3_270_2.dtb		\
> diff --git a/arch/arm/dts/socfpga_agilex5_socdk_emmc-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk_emmc-u-boot.dtsi
> new file mode 100644
> index 00000000000..6aed59f7c19
> --- /dev/null
> +++ b/arch/arm/dts/socfpga_agilex5_socdk_emmc-u-boot.dtsi
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * U-Boot additions for Agilex5 SocDK eMMC
> + *
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
> + */
> +
> +#include "socfpga_agilex5-u-boot.dtsi"
> +
> +/{
> +	aliases {
> +		spi0 = &qspi;
> +		freeze_br0 = &freeze_controller;
> +	};
> +
> +	soc {
> +		freeze_controller: freeze_controller@0x20000450 {
> +			compatible = "altr,freeze-bridge-controller";
> +			reg = <0x20000450 0x00000010>;
> +			status = "disabled";
> +		};
> +	};
> +
> +	/*
> +	 * Both Memory base address and size default info is retrieved from HW setting.
> +	 * Reconfiguration / Overwrite these info can be done with examples below.
> +	 *
> +	 * When LPDDR ECC is enabled, the last 1/8 of the memory region must
> +	 * be reserved for the Inline ECC buffer.
> +	 *
> +	 * Example for memory size with 2GB:
> +	 * memory {
> +	 *	reg = <0x0 0x80000000 0x0 0x80000000>;
> +	 * };
> +	 *
> +	 * Example for memory size with 8GB:
> +	 * memory {
> +	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
> +	 *	      <0x8 0x80000000 0x1 0x80000000>;
> +	 * };
> +	 *
> +	 * Example for memory size with 32GB:
> +	 * memory {
> +	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
> +	 *	      <0x8 0x80000000 0x7 0x80000000>;
> +	 * };
> +	 *
> +	 * Example for memory size with 512GB:
> +	 * memory {
> +	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
> +	 *	      <0x8 0x80000000 0x7 0x80000000>,
> +	 *	      <0x88 0x00000000 0x78 0x00000000>;
> +	 * };
> +	 *
> +	 * Example for memory size with 2GB with LPDDR Inline ECC ON:
> +	 * memory {
> +	 *	reg = <0x0 0x80000000 0x0 0x70000000>;
> +	 * };
> +	 *
> +	 * Example for memory size with 8GB with LPDDR Inline ECC ON:
> +	 * memory {
> +	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
> +	 *	      <0x8 0x80000000 0x1 0x40000000>;
> +	 * };
> +	 */
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +		u-boot,spl-boot-order = &mmc,&flash0,&nand,"/memory";
> +	};
> +};
> +
> +&flash0 {
> +	compatible = "jedec,spi-nor";
> +	spi-tx-bus-width = <4>;
> +	spi-rx-bus-width = <4>;
> +	bootph-all;
> +	/delete-property/ cdns,read-delay;
> +};
> +
> +&flash1 {
> +	bootph-all;
> +};
> +
> +&i3c0 {
> +	bootph-all;
> +};
> +
> +&i3c1 {
> +	bootph-all;
> +};
> +
> +&gpio1 {
> +	portb: gpio-controller@0 {
> +		bootph-all;
> +	};
> +};
> +
> +&sd_emmc_power {
> +	bootph-all;
> +};
> +
> +&emmc_io_1v8_reg {
> +	bootph-all;
> +};
> +
> +&mmc {
> +	bootph-all;
> +};
> +
> +&qspi {
> +	status = "okay";
> +};
> +
> +&nand {
> +	status = "disabled";
> +	bootph-all;
> +};
> +
> +&timer0 {
> +	bootph-all;
> +};
> +
> +&timer1 {
> +	bootph-all;
> +};
> +
> +&timer2 {
> +	bootph-all;
> +};
> +
> +&timer3 {
> +	bootph-all;
> +};
> +
> +&watchdog0 {
> +	bootph-all;
> +};
> +
> +&gmac0 {
> +	status = "okay";
> +	phy-mode = "rgmii";
> +	phy-handle = <&emac0_phy0>;
> +
> +	max-frame-size = <9000>;
> +
> +	mdio0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwxgmac-mdio";
> +		emac0_phy0: ethernet-phy@0 {
> +			reg = <0>;
> +		};
> +	};
> +};
> +
> +&gmac2 {
> +	status = "okay";
> +	phy-mode = "rgmii";
> +	phy-handle = <&emac2_phy0>;
> +
> +	max-frame-size = <9000>;
> +
> +	mdio0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwxgmac-mdio";
> +		emac2_phy0: ethernet-phy@0 {
> +			reg = <0>;
> +		};
> +	};
> +};
> +
> +#if !defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
> +&binman {
> +	/delete-node/ kernel;
> +};
> +#endif
> diff --git a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
> new file mode 100644
> index 00000000000..f6848c373cd
> --- /dev/null
> +++ b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier:     GPL-2.0
> +/*
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
> + */
> +
> +#include "socfpga_agilex5_socdk.dts"
> +
> +/ {
> +	soc {
> +		emmc_io_1v8_reg: regulator-fixed-1p8v {
> +			compatible = "regulator-fixed";
> +			regulator-name = "emmc-io-power";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +		};
> +	};
> +};
> +
> +&mmc {
> +	status = "okay";
> +
> +	no-sd;
> +	no-sdio;
> +	disable-wp;
> +	non-removable;
> +	cap-mmc-highspeed;
> +
> +	bus-width = <8>;
> +	vmmc-supply = <&sd_emmc_power>;
> +	vqmmc-supply = <&emmc_io_1v8_reg>;
> +	max-frequency = <200000000>;
> +
> +	/* eMMC legacy mode timing configuration */
> +	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
> +	cdns,phy-gate-lpbk-ctrl-delay-sd-ds = <0x81a40040>;
> +	cdns,phy-dll-slave-ctrl-sd-ds = <0x00a000fe>;
> +	cdns,phy-dq-timing-delay-sd-ds = <0x28000001>;
> +
> +	/* eMMC SDR mode timing configuration */
> +	cdns,phy-dqs-timing-delay-emmc-sdr = <0x780001>;
> +	cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr = <0x81a40040>;
> +	cdns,phy-dll-slave-ctrl-emmc-sdr = <0x00000000>;
> +	cdns,phy-dq-timing-delay-emmc-sdr = <0x10000001>;
> +	cdns,ctrl-hrs09-timing-delay-emmc-sdr = <0x1800c>;
> +	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr = <0x30000>;
> +	cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
> +	cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0xA0001>;
> +};
> diff --git a/configs/socfpga_agilex5_emmc_defconfig b/configs/socfpga_agilex5_emmc_defconfig
> new file mode 100644
> index 00000000000..9254ab92e0c
> --- /dev/null
> +++ b/configs/socfpga_agilex5_emmc_defconfig
> @@ -0,0 +1,6 @@
> +#include <configs/socfpga_agilex5_defconfig>
> +
> +CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk_emmc"
> +# CONFIG_SPL_DM_REGULATOR_GPIO is not set
> +# CONFIG_DM_REGULATOR_GPIO is not set
> +# CONFIG_SPL_DWAPB_GPIO is not set


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

