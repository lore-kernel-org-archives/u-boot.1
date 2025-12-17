Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F9AD64084
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 07:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 949E183979;
	Wed, 17 Dec 2025 08:12:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="PjNRifZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE1C483AAC; Wed, 17 Dec 2025 08:12:07 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C8CC83623
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 08:12:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXaaAY89QzbwX2cjCKZuC0xHJ9+tKW6o4yH7xF2OCzWPPvDXnPVnqszZZQFgsMO8nKmRKfPUNiGni6BRNynVkpDv7XcF9agWXL6H6g+wHqEWtOkvXGdN0hbZlVvRtnwEPHj3FZ1yJbiRioadvzhncnFBVAFNNIKqPtZOmjI89FFSIHiShHwhd/SaQynh6x0IX+e/emtHfuBuZb8bxPRCrOWOVLz2xZfcV4P2d7+OPGVXYG+9HyQy2etIRJqZ94/uv3OAvhWOe14PX4Y0P8zXWPrkmJJ9+OW0YJUIkFtnMbA8jg0MdjfMp3av6CSBGslZj6PdlwkwAdbnfkJLzP5QeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGZ8syoagWXJU65xdt5fAsCISuFVuKKYEPRB/86GAuc=;
 b=EBihfZl74pOUmV1GlWyTH4hKpoVfVBDS0FeGj/8gVUOWhGUQmLbgR1HnjsVbX0fP8YDqMzvn/2pa/Avv+nsjwLMRdJ9DWeO3F+2fuYrdwl0Al4JBu6oYfB5oaZnx2/jsyv+ocK4jYPn4C+GAX6a/STX5bMmC/E9+Cfr5K4Nn8ZNu9wl64arFert4WWzZvMiVcNPcx4RjWRddYrB4FMhLDm9MIkODvchCfjhBmoLWRgL2spzDi4IvHs71i0UhAgcFTPZqBQstexq3MoI9iOr6ZvbEygl1+QgTOcNciMTtut8FjApkdZ7lOjH8oLSqIu2LrgGRnrFw1qHq61z75F725A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGZ8syoagWXJU65xdt5fAsCISuFVuKKYEPRB/86GAuc=;
 b=PjNRifZn2QNEFCtBA82Yxi8n328GPa8fIl9r/rJsifvEFiVjHa6mxoHwxoE/2xWFNA8Jsv2h/B27XB9CaLTGzMrujkJLX6Qcq59BnMh3Q9X56mLiUNoJgqPfdKL7rLul2+MR1aeD/yuW06WcmDhyyIqM1JrOre9mXcFyG7ladEw8Zkb5RUKqzinE2W+5CZ/JLT6hj4aZRffGeAurD3vhsDWk93Fvl57ScWv1BTNSO1LuenaRPXH/I51gnUJXF0ZcPkFVyMUrtPbWiWG09MpupxjsZJL7Ke+Zh5v5Sazgq0x7fvkBbJtzuT/FG5C9Vmj6SXi36nVg9yC5kDUZnFzMGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by PH0PR03MB6955.namprd03.prod.outlook.com (2603:10b6:510:172::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 07:12:02 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 07:12:02 +0000
Message-ID: <352b5771-bd8d-4c60-8c1a-554bd8b620ae@altera.com>
Date: Wed, 17 Dec 2025 15:11:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] configs: socfpga_agilex5: Enable MMC and Cadence
 SDHCI support
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com
References: <20251215110117.19371-1-tanmay.kathpalia@altera.com>
 <20251215110117.19371-4-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251215110117.19371-4-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|PH0PR03MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 4944e185-e646-4322-af6d-08de3d3b931a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVdrcWovS0k1WnFHcGtWeVVaWko4aXAvUVBtbWFoSjBwSFJkamJqaXBENDY1?=
 =?utf-8?B?bFlxa2s5alVzMzR3Zm9UYmxQMEk5NGVsa2NKUHl3S0NraWxybXZBeFpWS3JB?=
 =?utf-8?B?c0UzUDR1alNRZlZQR1VzdUlTcFZHaXNPRTJKbzhZV3pKTlRLeVhxWEl2Nzdx?=
 =?utf-8?B?TXdQcHhNUTlLUGtVamMyREdPbmxScUZaejNmaHAvL2kyb1BJd1VhTzlpV1dp?=
 =?utf-8?B?WFZtYUlhL2lkcW9NUThkbkI3dlVDR2piazliR0psak1XTW9NcHlOQ3lvUDMz?=
 =?utf-8?B?N1R3Q1I5ckY0ZFhwbE9PcHl5S1o5VXl6SndvdmR0NVBSODVvcUpidlFJVnRs?=
 =?utf-8?B?VDZhOHdLdW9KcGYzd2pOaHRDZnlVK0VFeGdTS2pRdkQyRE5qS2dsTFFtVERH?=
 =?utf-8?B?VmVZcUlIbzRySC9VR0xHQVBSS09ZY3BaZmhZWDNJSGZkYlhYbnJnb2g4ODFT?=
 =?utf-8?B?K3haU1NJTmEvUFlTSm9GeExvU1pVNkMyaUV2OE1zQjlqRW0vaVdBUjBDenhY?=
 =?utf-8?B?OCswYjhUNTFkdllOaCtBWjFDV3pycGlVaDRYN0czbjZnQXoxY1dmNENNS0FY?=
 =?utf-8?B?V2VZN2FWd20xengrSEVhemF1ODQwK0xMRUd1RnJjSjR4aklRY2tMbEt0emhr?=
 =?utf-8?B?TWVSQTlSMnZVa0wxcURFOWM2cTN2STIwZmVCaFFKV00wZ2VaZU43U0lIZ2hp?=
 =?utf-8?B?aG5qbnNSSDNFVVRHQnJVMUFCaWtrUjQ4ZHJ3bENxSEhJMEVnWFUrY1lCQ1J3?=
 =?utf-8?B?cWNkUUxUUzZTaEhBN3Q1dk1YUktWUVNmYytJU2IzWWlaZityN1ZJTmpxM3dG?=
 =?utf-8?B?SWtUMWtxazh2bnlKeVBLNkdVeDl0WFljNTBtWFA5S0ZFSHFqSHRlQVRTYnFr?=
 =?utf-8?B?bnVrU0l1dkxHKzlNMWphMm05aEZuVHBUZ3N6Z21hYS83TEY2bDRVbHQwMDU1?=
 =?utf-8?B?QXpXS3RkUE90b054VHVjeTBPbSt1dENvMFRKNFY4cWhxWWJsS043Yy9UTUNq?=
 =?utf-8?B?TjBQeFIrNkp0RFJoVXZOdVlweEQ5N3ViUE54Y1RmNVNKdis5U2lkUzUvY1NX?=
 =?utf-8?B?c2ptUWJxdHNzc3AyblJIb0RoaVVuVllNdkxuMkpDWEdPR2FaVE1OcExkZkNo?=
 =?utf-8?B?M0NhTlpYdDRuclBIWWlkTTVuQVpxRk93ZHdCUUl3SlFhS2N2OUQwNHVxOHFS?=
 =?utf-8?B?OXRWcFhYanU2VmQyRFNDWjQ2WERYU2ZNRUtSWVVWblh5c0E4NGdHL0Y0NjVN?=
 =?utf-8?B?VjRjQkIxMU1Rc085WFViVnh3SlZDNnAyMzBLbGZqYjdhblB3L2t2NlBRMTVU?=
 =?utf-8?B?NmQrN1ZpbjIvL0hBMTJQa3ZMMHZPMUl2cGo0bG1JUzhCb3ZBQmpic0w2Wk91?=
 =?utf-8?B?VnVIVjREUXl4QlJmVzZqZmVjcjZSTVlpUUMwSWlxRzZ5dFR1ZzdBM0hCb2Zt?=
 =?utf-8?B?TUEybCt5a0RkUUJjRkMwREJGMjhiZCtDNGpURHNqWDFOU0NHdlBhalNucXNs?=
 =?utf-8?B?RzVoSm9lUURoQlBuZTFnTTVvY29qSlFqR2U3a0ZiYjZoUnNKK1hsSzhDTjFC?=
 =?utf-8?B?MHY5TnY0MG93V1FXUGRaYXZ5cUduRllqWVZhZXk1ZklBRUZ3OTlVeldKT09W?=
 =?utf-8?B?VC94ZnREVk52Y2RYQUNBODVTdmp2MVlNa0tFSWdMcFJtR2NpMklUdDdaREg0?=
 =?utf-8?B?WWh4dkhvZEJsd2RWZzgzbVNZU3h5MzNKa1FHRGY1anNrN0lQZzQ0eWUwUTEv?=
 =?utf-8?B?RlErQlZYdzhuTlRidGtNeVpPVTZ4c0lPN1Jabk03eEpMNkZycmh2d1Y2a1k1?=
 =?utf-8?B?VDR2TUgrT0RCMGU4ZFFSakFTbkRTM1hzNUhlRTBFOXl5cXVQNVRBRjVjMjVq?=
 =?utf-8?B?MjdVRStJR2YybmJnbVNRVFZJbGJTNnFqelhoaEh2QzJPVUVqMGkyS1FoZjRx?=
 =?utf-8?Q?JZ+o4F1k0Ek1vNb4GpjxjYuAX0W72/Bq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmMzcVVCc3B3cWFIR3lMNHhzTDM4alhGVGl0SGVaQ2krekFlS2hsYzNxVTcy?=
 =?utf-8?B?RmtzUDBoaFU3N2ZQcXFEeENqdmRXY1lCMGRTaGdYbytHQUVBQnBFaGNYUkU3?=
 =?utf-8?B?MTZTSVF4YjA1Tng1UDNqUUpvTFFrSEJYRzQrdVJvK1NuQlpHd2tidGNtcEJF?=
 =?utf-8?B?UFRCRTR6QWNPL0lpcHFsZDJJUUJzSHo2UmNJQ3lJdmRuQzdXQnI2czRSZlUw?=
 =?utf-8?B?c01YM095ZHp5emFhL3NWcER0Z21zaWJkQW5lYzVhQm9iM0cxSUJ2KzFkU3NO?=
 =?utf-8?B?MXkrZ0M1ckhKbHhDb2FNR1hDYjZqbjhTQmRqRWltTnN1TDhPZUVzVTNKV3Zy?=
 =?utf-8?B?bmRNd2FtVTN2bUZ5d2VhaDFUWVNMbWdUNERDMGprbyt5MDY1UE1yd2dnQzF3?=
 =?utf-8?B?NkQvNE4vRG4vRnhrVm5aQmxycW0xdXFrTW5QOXBuVjVOODZNVFNSOUJJQlY5?=
 =?utf-8?B?SDVvRUVpdlhJSG9SSU9nTnBXVmZvU2QwejZkK29SdkpORCtFY1lPQlJkMTNt?=
 =?utf-8?B?czc1SGZOYnByRlozbHloeWhHZnpCUnhZRjZIc0hvQk9KSzVZVmFUTFdkaXBy?=
 =?utf-8?B?T2ZKMEtZM3NDYXNnZHFrdkpWYWt5UlFSVnkyK1M5ZXZFYUszOTEzVTNESTRu?=
 =?utf-8?B?aVM1UnRMQ3c1WEIyNWV1WG9mbUtVSlorN2U0WmpIbG11WGJieC9NclJ2VFpy?=
 =?utf-8?B?ZnlZeWtoRW9zMWdSMm5FOFUrTS9nd0lTUkppQmZxRVFMenJJelNaWVE1ZzVz?=
 =?utf-8?B?R0NURjQ0N0ZJOVVDM282cjBoOVRCd2ovbm1SNTgrZUJseW9rVDJ3OVNLQnR2?=
 =?utf-8?B?RDBSdHJDakNNVkM5QUJqbndsZTdSc3ZGYjJTT0NjMnJ0cUxpQWp6ZXBIc3Ja?=
 =?utf-8?B?aUZaTkZjQWkra3B0bms3R1NWTjJaNFpQaHErdE5RRTNxYWkzcXlrVGZjbVg2?=
 =?utf-8?B?clBvdmlHcXViVkd6clByOUZoaUNUU05EdTE1OEt1T2RjWmpkamN3SnlGN0lr?=
 =?utf-8?B?VDRqTjdCTVQrK2JDd0FHMlozZVJYYW52clVyMDFjaVcwRkhJVFg4M3dEV2RO?=
 =?utf-8?B?d3dFSGkrVUFqQ0tIT3BWMjNNMFFJNXFsY0d2Y2hPZllKaVFKcmFoaUZ2UmdK?=
 =?utf-8?B?K3dCdXhieFhma3Qzak9yQjVRYTFsbGMxdHJ2THdYRzdTWFVWWGpwWDVYYzNW?=
 =?utf-8?B?Q3BCV0E0VVRXTXlQTWFTZ1VMMlo0VHMvL3NwaU5vSkh4bVBDTGpWYTErMlpX?=
 =?utf-8?B?U1dSNGtyWWs4OWcvSW03N3RSTDVPVGd1b1FBdVJZdER0a1Q5czNCWHQzQVNm?=
 =?utf-8?B?SVhKOUlPY3EvQUJpcXk2b0tQdSthN1U1NEJZWkd4TlF3Zk83cUt1SXFyREJE?=
 =?utf-8?B?ZDUzenNnT2JQcjVYaW5VVnJiZHRwaVFCVGhJclJTbTNHdnppZUxKTWZxL2pM?=
 =?utf-8?B?U0c3am42ckNlTGdXMk1zWk9yVk1CbHozRHNQRERxa1lKeW5OdTBiUmxjeWlr?=
 =?utf-8?B?MGRlSXFDTlU0M3JvUE5BaU0xSy9RL2p5UE9lZERTVTNUQjRMUlNZeXpTYkdH?=
 =?utf-8?B?aWhJWEsrT1BseXNsQ0pwTHRNenp2N2wvL1hyU3h0UzhvcEcxWTlOQUYrOXlV?=
 =?utf-8?B?VUdOZGRETmZXcWRoQ3ZMajF6TEZUUFNoYWFKZEE1TU80UloyZXEwQlg0WE5Q?=
 =?utf-8?B?ZmNvcWQ4M3Flblh3dG4vVHpHN3JtbS9XYSt3OXAzbHFGclVDdFVvOVVyNUVT?=
 =?utf-8?B?a01NSUcwV0NIZzRmS3VZMVl5RkJTNnpXZjljd3hDYkdBUjloWDJnUWYrcE42?=
 =?utf-8?B?T0xPMkN2L3FkMDZZTlZaWCtsNUZzTzZ0UjJ3Q0RsOHAwMHdFcVF1TmlhQmhB?=
 =?utf-8?B?djI3MktmNjdZYk1qVm1ZRzUyc1JJK0JidEphMEluUkxsVVd6emI1RDJZVXlS?=
 =?utf-8?B?ZTZoQURsOUtrZURkTXJiaXQ0ZDFES1ZaczVqZWIvMHpoeDlqM3FJN20raG9x?=
 =?utf-8?B?TWdzZnJRREMvNDBFNUp5ZWgzOVJUQ0cxdnJndUp5YkxrelZlaXpjMUFGblI4?=
 =?utf-8?B?UjFHckFaYzhtSWVuSjJFb0owbHpsc01xU242Uk5xUXM5VmVyM3JCTU1TRWFI?=
 =?utf-8?B?K0dsNDV4OEpiYWNrdGlRZk5DSXZEV0EvYi9KTFJCREdaRDdlcjFLbHJpbFVV?=
 =?utf-8?B?MmFROVMyN1NrWjRya2NaZzR4QytvZU92RnQ2enA3cmluZGF4Mkszd25yZU51?=
 =?utf-8?B?Q3FDR0RuZlZMUFcrbmxSTkZlZWJXdktFNDJmQ0kzUytmR3gvU2syM1FJUzlC?=
 =?utf-8?B?OTQxNEg1ek1sNVplcEFKZXJtN3BiQjRiMVJvV1o0RS9Cc0ozeGpMZzM5LzA5?=
 =?utf-8?Q?sE0tg6hejaLeL4cc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4944e185-e646-4322-af6d-08de3d3b931a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 07:12:02.1798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQlXRp5EKkiUCY9z/+1UATfcKNbWz7t9MsOufAux9EvywhnSQp7SBeJFtfvxxXslWm9GG2HGO0+yDRg/6yVKdWvYPl8oYdKHI0C9HKCLiFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6955
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
> Enable MMC support with Cadence SDHCI controller for both SPL and
> U-Boot proper on Agilex5 platform to support SD card operations in
> legacy and high speed timing modes.
>
> MMC controller configuration:
> - Enable MMC subsystem (CONFIG_MMC=y, CONFIG_DM_MMC=y)
> - Add Cadence SDHCI controller support (CONFIG_MMC_SDHCI_CADENCE=y)
> - Enable SDHCI with ADMA support for better performance
> - Add MMC command support for user interaction
>
> SPL configuration:
> - Enable MMC support in SPL (CONFIG_SPL_DM_MMC=y)
> - Add SDHCI ADMA support in SPL (CONFIG_SPL_MMC_SDHCI_ADMA=y)
> - Enable GPIO support in SPL (CONFIG_SPL_DWAPB_GPIO=y)
>
> Voltage regulator support:
> - Add device model regulator framework (CONFIG_DM_REGULATOR=y)
> - Enable fixed voltage regulator support for card power
> - Add GPIO-controlled regulator for I/O voltage switching
> - Include regulator support in SPL for early initialization
>
> These changes enable SD card functionality with legacy and high speed
> timing modes, providing proper voltage regulation and GPIO control
> for the Agilex5 SoCDK platform.
>
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
>   configs/socfpga_agilex5_defconfig | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
> index 799ea910f03..3eabc372269 100644
> --- a/configs/socfpga_agilex5_defconfig
> +++ b/configs/socfpga_agilex5_defconfig
> @@ -2,6 +2,7 @@ CONFIG_ARM=y
>   CONFIG_SPL_SYS_DCACHE_OFF=y
>   CONFIG_ARCH_SOCFPGA=y
>   CONFIG_TEXT_BASE=0x80200000
> +CONFIG_SPL_GPIO=y
>   CONFIG_NR_DRAM_BANKS=3
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80300000
> @@ -66,6 +67,7 @@ CONFIG_CMD_WDT=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_TIMER=y
>   CONFIG_CMD_UBI=y
> +CONFIG_CMD_MMC=y
>   # CONFIG_ISO_PARTITION is not set
>   # CONFIG_EFI_PARTITION is not set
>   CONFIG_OF_LIST=""
> @@ -106,5 +108,22 @@ CONFIG_USB_DWC3=y
>   CONFIG_USB_HUB_DEBOUNCE_TIMEOUT=3000
>   CONFIG_DESIGNWARE_WATCHDOG=y
>   CONFIG_WDT=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_REGULATOR_GPIO=y
> +CONFIG_SPL_DWAPB_GPIO=y
> +CONFIG_SPL_DM_REGULATOR=y
> +CONFIG_SPL_DM_REGULATOR_FIXED=y
> +CONFIG_SPL_DM_REGULATOR_GPIO=y
> +CONFIG_SPL_MMC=y
> +CONFIG_SPL_DM_MMC=y
> +CONFIG_SPL_MMC_IO_VOLTAGE=y
> +CONFIG_SPL_MMC_SDHCI_ADMA=y
> +CONFIG_MMC=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_DM_MMC=y
> +CONFIG_MMC_IO_VOLTAGE=y
> +CONFIG_MMC_SDHCI_ADMA=y
> +CONFIG_MMC_SDHCI_CADENCE=y
>   # CONFIG_SPL_USE_TINY_PRINTF is not set
>   CONFIG_PANIC_HANG=y


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

