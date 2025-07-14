Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0722FC83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 12:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6356582F49;
	Mon, 14 Jul 2025 14:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="RNuRVrsG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79D4782F8E; Mon, 14 Jul 2025 14:49:48 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B93B82B07
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 14:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXYWLxTlUVKQIAEDGhyRslmJaWoLM7xexoHhgDnnRIfNl0Gy6I+tw5gzEDmNxzWXJ4QimJHQSvtjEFdgMXq306Gfl8r8dfw21Cq7mECnxgAU0X6Hm12GGC/kHFFlP54TCTuJxdov3mHF3uG3tq6+tHm6g1+r3ORh/wc1Qmix3N5GxDf6rIEW59IoorPv1E631ULeBTfP3CRfydmRTe6dKRyexE8OeaCc5pKcmL/RQ1mbrAMogxhm13p95UG97W5sG9iNJpmVhudx8oOpqtdeLqpBngLKo9grgKMpnI2pWtVGVTisGJGLIiN8pVo5MzHJlMHOX+p0lkoEqd/tA7/+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saV8GjVEsjUdx9llJw4q0fuj76fGxlRAAr2xHXFG/Ts=;
 b=VLPHGGfrsc+iEg5wnB9L5Q4b17+l6/fJkqcaG7RcG4VwbNHDgUUOPGU3TtFMovakERq8Zzs57j94Z6MnRzeui3ASd+UXI/efnZTgTLFFSROxEoPWqV/7oyXnC41FVVY6S5QGNPNgY6rOMoli2AmaQ7OHugnoc5Gs2yIJNPFSW+d7qtOPHWXxOhKlEYGUkDusHMyQ0HCWvybOiasanl+NGkSg+ljjsh9vuLQeJv7h2ItBJBYGIHOH1nDawq1v9JIxaYOvd03oBYS45tleWTB+JlpCqlHpfxXC7jVfK/UAo9U68h67si4PvqAwPUbXErSCuO2phrdIuiVULApMeL0Bpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saV8GjVEsjUdx9llJw4q0fuj76fGxlRAAr2xHXFG/Ts=;
 b=RNuRVrsGdat9RRtftU1/3GKHVuAvLhK4kMlnlznIeJD7Dmjllq6FMOA4TirEBLAD0JYppa32ZBOkH3aFiqKfUPUL35uOXHobAOUGlmOZF/wJs7bYDu6o9jOt4x1UN+yIMlFcOvwqDfdk7QgEzhzsiPmgqau8SKWPVwgZbqLyfrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10099.eurprd04.prod.outlook.com (2603:10a6:102:45d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 12:49:44 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 12:49:44 +0000
Message-ID: <b966c4c1-0428-4a7c-a211-d5de820786d3@cherry.de>
Date: Mon, 14 Jul 2025 14:49:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common: memtop: Update the MEM_RGN_COUNT macro to 64
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, sughosh.ganu@linaro.org, git@amd.com
References: <20250704084224.675703-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250704084224.675703-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0122.eurprd09.prod.outlook.com
 (2603:10a6:803:78::45) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10099:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a77b78-50d8-4e0e-782e-08ddc2d4e873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzVtdVZVWkdaY3c2QkNOekkvUFZaazhhYTArd0Q0a0tLbjd4QzZrK0lrZ3FY?=
 =?utf-8?B?RkpEU1J3MUhBSXkzOS9BWHdmYVNXbzFIUCtraUZoZ3cySFVrTFQxWUZISGsz?=
 =?utf-8?B?ZDV3WllJdG0yemtORHVlaGs1L29aVElYZkNXOFNYWWxFRkI5b05lNzFBejBC?=
 =?utf-8?B?OTErcC9nWlhxOUgwZG9KdGFnbzA4RWxnRHR2a2hLMWtoQ3U4Qis4UWt5ekds?=
 =?utf-8?B?WkplZ3lEZk1vbGZ1Titpa1MxdlZpQnNLRHI3R0pnVU00MDViVURUbG1HbGIr?=
 =?utf-8?B?MkhmV0lRUitKTEFoWitJVW9OdGVva2hmNEl6KytGTlJWUW5Hc2pHSXJEVUh1?=
 =?utf-8?B?ZlRJbXpXckRUSnZvRlorZWNJWnEvSHNDMGFlbzlwcnJxMm9mZ0dMOVB5Qzd1?=
 =?utf-8?B?VFVmcFQ5TFFTSmFTTUp4OTR6YndTS0x6KzBORHFEaWJ2QzdEUHFRaldQMDFT?=
 =?utf-8?B?MFNwU0cydy9DVjRXa1hWTFNydFYrUGFCRTBGVkVjWmtMaTZ2KzBOWXF2OHpi?=
 =?utf-8?B?U0VjRThqQUdQLy9IQnUzZGdjdytRNUZNZUNaSWNJRnd0aDNSNU5tWnF2aXNr?=
 =?utf-8?B?TFRXMm1GYzVFeTdkamdjSVdNeUNQTitES2I1emhhWnFsKzkvTkthbjcvWFl5?=
 =?utf-8?B?YmdzdVVNTEMvTHE1cXNyWFV5b0tsNmF2QUZiWDhLSFZaU25xRDdHN0VGVG94?=
 =?utf-8?B?TXpRRlROL1Fwa0M1ZmhUVm9zUEdmVlVBZHVFaDl1a1o4dS9oTElJcmxYTDk3?=
 =?utf-8?B?MzNoQ0plSldEdUt2bllSL3NRMmdlcHYzQStSSXNLaDJuRDdoY2ZVaGxEQ0RW?=
 =?utf-8?B?VXVHZDdQR0Exazdacnh1NTRTU000YXBON0plYkQwUWJZTTYwa1MrUTl5TzBa?=
 =?utf-8?B?a0F1ZVFpM2ZGbmZxK3czM2FoNW5iWmk0dFdrRHFBOUVrNk9PK0FLdXphTnFR?=
 =?utf-8?B?MHM3allXY0ZmbHNHWWc2Uk5aeldQMm9oWUV6S2p4dGxnSThwTWE4RHRoWGNC?=
 =?utf-8?B?R1czTFg0dUJxY1BITXFuM3B6U3ZCaVJ6U1RVaWxJRjFZTExXUTRWN2lPVnJl?=
 =?utf-8?B?QVRDaldtTk9kS0pJYW93WC96MUw0TGljZW9Tci9MbEpYZCtmOTFFRC9ZQjcw?=
 =?utf-8?B?cHppaVBraXNidWplamt2MW5qdDZpdEdObU0xOVpCeCt5SkRnSTQxYVRpOG93?=
 =?utf-8?B?aVJKd1l6TlRZZmRmTURsUG9CVUV5MTJOQ3BPWjF1MzhvL1NKUWNXU2tpVTFX?=
 =?utf-8?B?SWNNYTV2L0F2YzJqMXV5RVcxakVBZVp0WXF4OGh4dG1jL3hjRmlFZ1N1S1FD?=
 =?utf-8?B?MGZMM01NVE9zR3Fvd0x0Z3hnWE5iZE1uYzVodWJJMmdvSFNvWkZJZDhOYmVj?=
 =?utf-8?B?MCtSLzZadjZYYUY5SUNWZlErcVdyb2UvRlFwMFVFRmdKQytrYlBFT1pKQmtF?=
 =?utf-8?B?SnFtbTlSMXJzSW14ODFDdFNidUI1bzFmVVBxa1hyYk1oTnRtdmQ5a0ZzcFlN?=
 =?utf-8?B?KzRxMWI3VFRDYWlPQjREaHhEMlplbGR6UVRlNTc3OFByaXVEU2ladFRBQUla?=
 =?utf-8?B?K1JhV3M2dTNmUDJvaytVbU5oQWxUTFJuTVg1Rkp4ZlJ4Sk9SNk1zSWh4ZmIv?=
 =?utf-8?B?VzN0KzR1N3RFMlU4Z1U4WFZoajdZcXErZm51UW0yR2FINHQ1R1VQdVlOU3dY?=
 =?utf-8?B?dnVieEtsMnVudVVEK1g3VlNSODk3NGVnY0NVR3UwOTBLaDFHVGF5a2JTYTM0?=
 =?utf-8?B?M1lKdXpTenpQRVdVQks3S0FYK1FIbno2dUZVcloxa0JNNmJPYTV5UmVyMHVl?=
 =?utf-8?B?T2Iwd2NENytUd2M2T0JIeDF0RnBYOG5EUUM0bnQxU3VaajJFWDZjZ1NMY1gv?=
 =?utf-8?B?eVUxb1cxTVJzTld5VXk1NERyWmZseWVmYXVGckJSby9wNkxxQ2QvWEpOR0xF?=
 =?utf-8?Q?tkCkvEi4eiw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXgxVTZxVWFWVGV6alpPNkw4M0NoaWdPZ0grajNPSkpCVTJseHdxNDkzTE9S?=
 =?utf-8?B?ZTBsK1VNdnUrVnR6bXhXRHBPZ1NBbHluSDF6WTlrOW9YZkJzeEhkdGlWcGxy?=
 =?utf-8?B?dGZTY0tjZnFNbHFOalB6d1dNUldqcFhyOEd2RVlUbE9IQ3JNaDBzQ3ZhTEU1?=
 =?utf-8?B?THRpL0cySnAvVnRoZ1NVcnNVZ0hJS3dXZTd4UTNneStUNmxaK0t1V2pOclJJ?=
 =?utf-8?B?NVcxdjBScEw0VUl3VzNPcTBKcGJKVmk5cEk3L1p6V0x1aFRYaERkZVFoaFVP?=
 =?utf-8?B?VnFOUUJXT3lqdlRwNkpvZGZpVFpwZTA4SDF0ZDhCcXJ3Q2FWZDVCRU84TnFx?=
 =?utf-8?B?NnVGeE1wUTFReFRaVFRlMVNxWGlBTnBSZDhiL0JxY0dQeFJMQUVOb3EzUVdj?=
 =?utf-8?B?MTNxeERCQjBWY2h4RUZCZ1NMa1Btc2Q0a2lQbjZwK2JoR1M3eDNJUEJVTE1j?=
 =?utf-8?B?VUEra3daZDRwTlhGQVdrMitQajhiTEN4dGVjYjFEVU9NQU1FUVlnZGVJSkhs?=
 =?utf-8?B?ekQwZzF6STgvYXBsSzVuaUx5ZGVMUTVXWm9SM0RHbUh0Um5wVDR2Z0owazV5?=
 =?utf-8?B?TEoyQVFPQThpcXdzYVVpazZuMFVGd1FQbEtVaTNhR0hNbFVLOG12TTFoV2Fw?=
 =?utf-8?B?ZWUvUGZ3d3J0UUEwd3NFYlg4VzVsSTNXeDFmYjlGQ0FDZ1Jmdm5zVzQvRUxZ?=
 =?utf-8?B?VUpQSmM1L0JkQ3NXS09SN0o3empJcmRNeXE0N2EzL0wxNW9GMmM1NldUNUo2?=
 =?utf-8?B?L0IvbUlkTy9ZNU5xQmFiRkNiSVl4Y3JhRS9xU0dKd2Zoem14a2JucFdObGVP?=
 =?utf-8?B?cmR5bU84b3BBTVFEVVNidndvTjZ1ME9kd2pyeTRpTklvWjBWNlNtUjBrUVVL?=
 =?utf-8?B?MFJTZnRpMkhXRFNIdktsVDRNRXZ5VW9TMld1NXFMQVR5ZjhieXpPU2Y3TDdH?=
 =?utf-8?B?eEprazFlT015aVZ2YktYZFpiQ1poSURrUlR2Y1drQzVCMHRLczRVSGdENVpp?=
 =?utf-8?B?YVZCT1ppMzlrZTMxeExOVkZIem5DRkRrRTU1eEV4RnNoNE90S2xyQTVQTUpz?=
 =?utf-8?B?MnlISE1NMUhsRUROd1ZkdFlrWTJjSnlXcDVLOEdNU1p3ZXUyaTVxRnE5VGYy?=
 =?utf-8?B?WDJXUE9PR3VDN2VIQmI2em03MDBQTndYRGVteWxVakxXV285Nkh4aGRHNHVi?=
 =?utf-8?B?SlFWbmhzUlJCU2NjamZlUk5NNGVPVWM0Zm9IY1hDcWo3MW1jVDBBN0oyNDRq?=
 =?utf-8?B?M3B0THVod2prWHkwb2lVaWRab0RMaXpDMklFeEpUZ0Z0YVh3K045d3N6cllj?=
 =?utf-8?B?ZHQ3M2QxRllHQ1lwSDIySGYwNmdVeVRKaHh3cEJlQXBERGlMTEFJR3owMVJK?=
 =?utf-8?B?c2pBQ1VCTXRDK09ubFpnRlFrRkNFRklFVHhKcW5iOGlvZHI4RXZBSk9kVmtq?=
 =?utf-8?B?aHVETThRZzBoZ3pFazZKdFY0ODQ3N2pRMkhPSVZ6VGZGOTFmZ2hTRmVEYUhq?=
 =?utf-8?B?Vk81aVBmbHJ2TjF6d1Z1VjVrWEdrL3lmeGZ6d0F1UVlWTWhlcUpJbkhBZlMw?=
 =?utf-8?B?ZUgwSU9LRWdqUUxVRGpNZXdZdFRvdUNhY2dHd2JKK3dJRktwRmdpNVpLYWhv?=
 =?utf-8?B?M2VRcmhVZXJvN1VnVW1zMmZUZEhPQ3NnU0JYMTVPdWE5eU5WVGFndjNWT1FN?=
 =?utf-8?B?U25KczhyM3pWV290eXBEYzBxZHo1QytZOFYyLzg4VEQwUDU3aVVJcG56QlVz?=
 =?utf-8?B?UXI2NFFEMWsyN21DaVpreUwvenJuT1UwSDR1OC9GM2VuRTFCQ0NpT1hiaTFm?=
 =?utf-8?B?SjZ6d2w4Ym1VR29PMnUwa1BWR0FkQkVoaHlCclNLd0dITVRlVEpoVThzTUR4?=
 =?utf-8?B?dWF5eE5TWTdZdG15QnN1R2ZlSzFLT0gxYjd1NUYrTGZCV3NiR3VGSnE5WXNu?=
 =?utf-8?B?eDA1SldkWVFFNG84WExPK3FoTXFXa3EwNzM1Qk5wZjNGU1NMdVhUeE9aUkpW?=
 =?utf-8?B?TmlPYlRQdjk2aFZxRjB5d1FqSlVDQnI5Q09WR1J0cjdqR2l3cmM2YWVZR0xo?=
 =?utf-8?B?WFViT1NsOEoxL00vM0twV2tJQkZWWmVabXJWYkdSZENBVGdNZk5QdXhJRDg4?=
 =?utf-8?B?T0EvNWkwemlZbDNSdWhyaW9mRFFEMkdkczQzWml3eWZXQ0g3MFFwbkhsMm1V?=
 =?utf-8?B?WGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a77b78-50d8-4e0e-782e-08ddc2d4e873
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 12:49:44.6838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oouDmCPEZwsJzeFQgJ4ObKO8qSJdSRUgkil3DcusXeGBr6dfEs7rwPsUjxTTNwOtvdzERQxQ5b56jNISTL2wLJy9ZFF7f3haBhkjtdKqjGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10099
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

Hi Venkatesh Yadav Abbarapu,

On 7/4/25 10:42 AM, Venkatesh Yadav Abbarapu wrote:
> Crashes are occurring due to the number of reserved memory regions

I assume these crashes are triggered by

assert_noisy(total < MEM_RGN_COUNT);

in fdt_add_reserved_regions?

Or maybe we're missing some checks in some other places? Or are those 
crashes in the Linux kernel (or whatever OS after U-Boot) because we're 
not adding all reserved memory nodes and the kernel tries to use some 
that should be reserved?

I'm also wondering if we couldn't dynamically allocate rgn array instead 
of hardcoding the size of it (considering we store its size in count 
member I believe?).

Looks ok to me otherwise, just that it unnecessarily increases the 
binary size for systems with fewer than 16 reserved memory areas (which 
I assume is most systems).

Cheers,
Quentin
