Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CC4C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 07:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 173768070C;
	Tue, 10 Jun 2025 09:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="qkNdpJPt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E01DF80C83; Tue, 10 Jun 2025 09:02:11 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98D8B805D7
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BByl0tjc3/TCIBgivl732sF3IVQ5A2ulusvUpsuIdKdYN1h91LQsEq9Qway9FlD8bewU1tNPXO0elDvYkZhsvFJMDX4zDxiAN08J8K4D80Yefp70jcLb0Y1zvmq4X+665XW5ggVAK9QMeMjuZFbAjYwgTqf1wTX+cYAeKeovzy9nOtX3e22e2GDF0w2OX7S1tVzdVesCtImAZ9lrBKo3wmpgnUVrYO5mY3RUv5H2EqfUgH9tCCO7X2KmYkFgpvfRRdXGbAdjSAnyrx1F9ehCGDDHaKYV4x2p1/j//YhT78YfCZuB/hapzelZRgUd3o4fXuRSzDtCpG3tbDYMwrMgmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBNwQkMrVw72nbu62pkmroCKJdgtOD2FsWuQC7o0u2o=;
 b=Gy10HQcn//ipYlECzBBGiCA3MeHdol4LsCEipg5LwQ80WHZohcKx2DLbhfsKiX4j/eG6rwS75WnnmDgUwTJr3GNCuUARVK8GZDyfk3Mr8hTUuH1yj9vMrW/g0a5uipN2hAMonK+EQa6jAOt0tJa29IEWN1+4SZOtiJTUyjv1HOiMr2OAWVbg2ilrJRe6pzWXcOj9Tiu9KIoqtQoQpeYQqCMUKZXk+vy2HzElcKgDzB/P1ShOogIHEwieBQ7dIWVvH4jNnTvLyeNaPJsSwXE4wUXDg06Y64Wa68bJuQNC1SjaJOYuzaVbYc0E5TfmAmahzxQl/1Eq1UNE3E78zalljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBNwQkMrVw72nbu62pkmroCKJdgtOD2FsWuQC7o0u2o=;
 b=qkNdpJPtn684FTPT6bk3oPA3Bt/h62ziZhpBSBz5QB1vE4ysWAppk16lOKd6LiDeV/sHoPFnUfHWZswRmtSufuDB6Aqu1lfDc0xiTJlR75F1P1OosC6W7BqsED9vE2i6sJMpTnnMQP3hlw9+bG/NlNPfsAdlxJJDEdZw4yrCfHee6KuKcPDGH10xgDDsU0Cow+SB4cK2vaDC2eJlni2sKqLlY6EX+hJ2v6QU+yfYHYeI7GuAHyeBAjCG2Bt0lHxRL8xPny2aJ3f4cs1UAO6X4h4MiTyLVmfyfu0XzupcPV2FAU5HqDGiKhZaf+cSq5+Bu2ZQTO1l4CyFoaQkhfB3pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SN6PR03MB4288.namprd03.prod.outlook.com (2603:10b6:805:c6::21)
 by CH4PR03MB8018.namprd03.prod.outlook.com (2603:10b6:610:236::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.40; Tue, 10 Jun
 2025 07:02:06 +0000
Received: from SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55]) by SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55%5]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 07:02:06 +0000
Message-ID: <d8f29af1-6c94-46ce-9fae-57ce5a696ffd@altera.com>
Date: Tue, 10 Jun 2025 12:31:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] drivers: ddr: altera: Fix Cylcone5 SPL boot loop
 issue
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
References: <20250603115442.19971-1-nareshkumar.ravulapalli@altera.com>
 <20250603115442.19971-8-nareshkumar.ravulapalli@altera.com>
 <LV8PR03MB8137FCCEAD1F63670203F560A76AA@LV8PR03MB8137.namprd03.prod.outlook.com>
Content-Language: en-US
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
In-Reply-To: <LV8PR03MB8137FCCEAD1F63670203F560A76AA@LV8PR03MB8137.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::10) To SN6PR03MB4288.namprd03.prod.outlook.com
 (2603:10b6:805:c6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR03MB4288:EE_|CH4PR03MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: d5005fd6-6f23-4be2-df42-08dda7ecb599
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVNpTC85Nm9xeWVyRGJwaTIrWXREWEVpUlQvSElvM0tVVUJaNFRSMjlJcVFt?=
 =?utf-8?B?R0NuanBBb1B1b0x2REVaRXd2bitsQS9IMHlKdVVqRVFhWThTcnlmekdwVmww?=
 =?utf-8?B?UkQ1N2dnOVNpNkFNaENlalRuWVVsb09oUnp2K0FQdTlER3VSUk90a3R6Qmdz?=
 =?utf-8?B?U1QyZzhnQ1FLY013OVRaSUt6R2gyc1pHcTJkdTVTb0dxVkVwNHhFckRWVlFq?=
 =?utf-8?B?Wlk5M2lMcGhqN0ZJNXBvMnZZdE1DR2xSQmpQa2o3UHJPUCtkTS84c2VLVnlH?=
 =?utf-8?B?NWo1bm4xaEhaVGltaWVSSk5icnVqajFCd1RQejVBTGxYWG55WGw3elc1Tmdk?=
 =?utf-8?B?MzgzeDArR2M5RjQ1TFRwWUdjeUcyVmo4NHNZNU9UZjI3SkhDUDgza2k0eXZm?=
 =?utf-8?B?MVFJbDdJQjZpY1prQkN2cE5QQmxJR1lMUndnSjYwYWN5RlF4bmJPWGkyTWY2?=
 =?utf-8?B?dEROZHkrZi9MVXRDMVdLcmFnbzFKK0RGc1owRE00MmxuR2dlbmp5VzNzUm10?=
 =?utf-8?B?WjQvK0VqVzZLU2NkTHV0WHRjenl1YVkvQzdybzRxN254K3ZERURRSTUwa3pU?=
 =?utf-8?B?Z2M0ZFRuR2owQXA2Rmg0MWRIcktVTDhMR2pPc3Q1c0VSckQ5L3IwbWRCVlM3?=
 =?utf-8?B?eDRMWjJmT3dQL2s4QWwvSWJUeElWbG9ETlcxVGh4bmVSMGppVmlxekswNWgv?=
 =?utf-8?B?eWNoQXNGamJyMTJWOVV5WDJ3aEIxN0pDeSt2YWZiRE54a0dRWnBKbSt6RnhX?=
 =?utf-8?B?NmZoQWpqbDlLTWExRjdmU3BWR2EwU1pPQ3hTRmZvZ0RJMDZKQ2ZLamptTzFL?=
 =?utf-8?B?d05xdUl0ZVhxM0M1bUNUVjFuVzBRMktPQ0pYQjU5Zi96NUozTU0wb3EyUVgz?=
 =?utf-8?B?ZDhtZ1VzdjRYeVhHU0t6UnVxUHprd2QwNVpGcHRuZG96MXVuQ3NoYW9rei9s?=
 =?utf-8?B?S01UaWg1cXZ6Q1JlQ0d4eUdhd1NJSDd3dElCcWV1c2Q1Uk1ZQWREdWZ3Sm5z?=
 =?utf-8?B?eHpPamw3M0kwOE56WHBIOVhxVnI3ZkZtMnZ3L01DUFNKbWhBcG12RmxaQW1G?=
 =?utf-8?B?eVpoQTRxY1NsN00yd0dEbks0aDBiNzNrRGcxaVpFMXdOQVM2bjBQTUFTVzlT?=
 =?utf-8?B?TVdQWi92TEE0ZU5xU1F1K0xlS3c4ZzFIRUNselVrM3ZKMHBhMmxKSkxhaU8w?=
 =?utf-8?B?Yk5VTkZqaUdIQnkreVZGSHZKYzFGeGQ1M1B2d2Z1RUN4MHB5WkEvcVFuZmRG?=
 =?utf-8?B?emVyaXVhQ21jdDYwYU1VenZ3OVA4OWtuV2pJSkZvYXhaOUpRSWJ0NGJycHVr?=
 =?utf-8?B?MHFadTJRdkpXcmk4ejYzRmtkUHhVNkVNRVBEbkRyV3lXeVRVaVBRbWhJUUhu?=
 =?utf-8?B?bnFQZFFYNHpYVVJkZUVCSHRYSkhSRlhvcFFrbXY2VnNIRVFPdFY4TytBaWNm?=
 =?utf-8?B?bnBtKzMwSC9RZ0lhQ2Zvc0VyM05LM0dwQllsbnJHSWF6LzVhb0JUMGtTSVpo?=
 =?utf-8?B?c1dVNHNrYkppVVVzQzhqZnZaVjR2NVViMTZWajJPenEwYVFKT3ZSVm1uM1Ji?=
 =?utf-8?B?WVlCZDJ6U21HYjhXa0tOUnBOeXpnb2xjTW9HT0ZENGMrRCt5K1BSak95azFk?=
 =?utf-8?B?RUNqc01XZCs0WXRkNWJGQ0hVZnZLN0xkK3l4SkRvWkQ0V2FFM2Q5T3R2Y3lC?=
 =?utf-8?B?d2g2VGoxeGtCTmlmNHZWeUF4b0habU5RQmdLZVRiM25BdmVUMUN5NTQrbmg2?=
 =?utf-8?B?SWlQSi8wb1I3T3pzZDl0b2t0aDFwYjRPU285UlJadko1WnN2ejJ1c05TMWpI?=
 =?utf-8?B?dWhIRFhSMXFhdksyNXNCbXBab1J3c0dCSVllYyt6MndBaGkxT2QzY3pvQkhU?=
 =?utf-8?B?bDVvRjZlMWw4L1hWZ2FwSTN2OEM1NWV5aXZ2R1NxbHBld0FNVklvMVRJL3h5?=
 =?utf-8?Q?ccxenc8Sb4M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB4288.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VENnQU4rRHlibzNTQ2hGTndhTEJGeFUzM3VKbER1WWprM3JKdFpPMXFoWnBK?=
 =?utf-8?B?V2dDK25kZ0xqNUFCeVNwRmtYV2ZDWE9yeFhJV1hpOUpLbDlIYXhvV2J1UDZJ?=
 =?utf-8?B?cmM3bGxjL1hCcVRrY2ZWR3kvMmFwdWhWcnJGdExwQUxEeXVvd0hSLy9veC9t?=
 =?utf-8?B?dURLRk9ocHFySW9QVVIrTVJMOS9lNEJ2S0pMTnpvdi85QjhiNlNTZHFTV1pO?=
 =?utf-8?B?eS9SMFZsREo3dUc4YVBwQUxIM2U4QS9sQ3U3U2lxUWxZY2RIMVpucmdURVV6?=
 =?utf-8?B?VDYxYndYd085WVphcHJvYlhDRkxSZTZybU1BaGpvQTdMU0xiQ1ZIb29xdys5?=
 =?utf-8?B?cDRKeHU1cGVmZno2eGtaa0xyY1k0YVdEMU1wZlFTakJsdWNScTB5ZURLeDdI?=
 =?utf-8?B?amRqZnZzOTlxRVJzQ0ZjTnBDTFdkOFpzSUlNcCtKdWxDWXFjbkpiM1MwUUg3?=
 =?utf-8?B?YjN0VEZhTlFJNlJXMjJrT085ak84bVcrSzlkaGpvVTNuNENrREs5aVpFc05u?=
 =?utf-8?B?NC95NENnOGVOb0JGZlAvR2ZtVU5LbFFVbzhFTlVPWEt2Y1MxSGpZTTY2V3F5?=
 =?utf-8?B?Y0VGaTExeTc2dG1aeDRyUTBxZzF4OWFMRXJldVFsWHQ3OEFmdFRCTEl0ek5r?=
 =?utf-8?B?OEpsdzU2SDQzMEVxbmlqTVJ1dTFhaEY4MjZkdFN3WEVtd2kxK1VYa2lBWWV4?=
 =?utf-8?B?blcvbHlESkYzYm5zRWtHNGw0L0lGeGU4dGp5ZUF1N0V4Z2ZKVFBrQStJNGpO?=
 =?utf-8?B?SFBmMjJtMkRMQmVma1dqc2FCNkpMS1dDSzYwVEZBd0l0TlN3elVPZG5jTHJp?=
 =?utf-8?B?OVVwbytBMjBsU21vRVRGd2M1Qm9KWHY4UndGVWJud3UyM2Z3c1FOVCtxSGRo?=
 =?utf-8?B?d3VkS1VtV3VWWVZsakkya1R4eGRFWmtYWGFyT05hTmtCRWNyRjNmVWF5Sysx?=
 =?utf-8?B?R2NRaG0rL3hUNmZ4WU1GU2pYai9PR0VCaUFlWndmbjU2WmIvS2lvckJ0Z1dt?=
 =?utf-8?B?ajVQWTM2aVdPK3V3NVdBQTZWNVJBcFhaZ0ZuZWhxWm9qOElkN1JqZEpuV1cr?=
 =?utf-8?B?ODBPdng1dnljUzlTTjRaWkFSRTY5QjFpbUhXcmNlN0hOOExDL3JQckJJNWhS?=
 =?utf-8?B?Z0VWUTJaOHV2bm5aV0U5STZ1aGx5WFlDZXhhckMrMDUyblVkSmg3My92eXFT?=
 =?utf-8?B?RkVCL0NTWGVzSTV6U3VaTjJaZitSSDNLakpVcVdaSFhlcWVBWE0yalR4QUx2?=
 =?utf-8?B?MVNsSWtxUHlaMVFLem1KY04zemtPMENhNURybmxIM0FYVFlIQzNUNThlN20v?=
 =?utf-8?B?VVk5dXR3ZWhRVCtUaWZTMVlEMGVLQ2k2ZDk2U25BS2llQk5JQ0o4aWo0anBR?=
 =?utf-8?B?bzBOelZVVmFYMmlidE9xSFI1WVJYRmVyTThna0VEV1NDa0JjNmYxY1ludHBO?=
 =?utf-8?B?ZWdWenFBK1NPZ1kwWVozb3VsOWlYQVE4WGFZU2tNcEVPSWVOZFdIT0ljUXBz?=
 =?utf-8?B?Mlh5eWNHRFc3RStocmtlQmJ0VGJqNEgrN0JRczQyL1ZFRkY0L1VjQmJtZEFp?=
 =?utf-8?B?aFJ6cjdHcFJoZEwyU3l1R3EvUHlUSGRKY0N2UC81NkZhazRhU2Y2RE8zd29G?=
 =?utf-8?B?R1hVTTl6TDlyMHZkWkYrcWozckx4cUxqbGVSbSs2OFptdDBrcjc1MjZMQ3pX?=
 =?utf-8?B?Y0RZUFJWOGxsQlkvSVlMemxydjBwRmtNdVlkOHlWY25pMklFM2J3TElhSVdr?=
 =?utf-8?B?MVF2cU9lbVBhRk9wQmRqWWxOY2ZaUTFQdFRFWjc2RnNOeUtzTWV5OUpESnVM?=
 =?utf-8?B?VXRQR042KzlyK0NtcGJEVGVKdHFoc3pWZ3ZjR2VyVW5OSWFaVjl0VkI0V3dI?=
 =?utf-8?B?MSt6ZEdQcElkb3hvSVVPdkhsSU51NFlIM2ZxWWdrZ2ZtekUyOG1SWnVaZkxB?=
 =?utf-8?B?U1ZnNEljQWRvODZwcVVielVwelVlZXlIVktwd3plTVZmTVFnVDIvcG9GQTFT?=
 =?utf-8?B?V0dYRm9Ld2ZWVUJVWERGUklhTm14SmthOHRlK09BSDIzS2pwa21scmc4aDFI?=
 =?utf-8?B?TUgwaFI3VlQrQWQ5ZFgrN2plTUZyMnRtY3FVdW5paTNwdisyemYrOVNIWGRM?=
 =?utf-8?B?L3dHaTQ4eEs0UGJyaFN0T0l3cUF4eW5hazRucmhFd1huVGxWY2xyQmF5cG4x?=
 =?utf-8?Q?NQbBmrlDvgx9PaKSVw+nOb8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5005fd6-6f23-4be2-df42-08dda7ecb599
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4288.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 07:02:06.1123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0WSudquELA9qAdigafU5PutXw2N9adRQ5weAussP70+By9YCgHNsKQe2GZicc2PBosIAnFZqZuiEiRj0mtxqn9dzaif7ru7JALWeQ+CFZpExZD+rUSlE9WWa5Dl1e/L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB8018
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

Hi Tien Fong

On 10-Jun-25 8:13 AM, Chee, Tien Fong wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
>> Sent: Tuesday, June 3, 2025 7:55 PM
>> To: u-boot@lists.denx.de
>> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
>> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
>> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
>> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>; Romli, Khairul Anuar
>> <khairul.anuar.romli@altera.com>
>> Subject: [PATCH v3 7/7] drivers: ddr: altera: Fix Cylcone5 SPL boot loop issue
>>
>> Hardware watchdog configuration is handled correctly to resolve the SPL
>> boot loop issue on Cyclone5. When hardware watchdog is enabled, it is
>> reconfigured to make the defined timeout valid, else, making sure it is not
>> running even if it is enabled in the preloader.
>>
>> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
>> Signed-off-by: Naresh Kumar Ravulapalli
>> <nareshkumar.ravulapalli@altera.com>
>> ---
>>   drivers/ddr/altera/sdram_soc32.c | 25 ++++++++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ddr/altera/sdram_soc32.c
>> b/drivers/ddr/altera/sdram_soc32.c
>> index 5cdf48d2d01..f63360f17d8 100644
>> --- a/drivers/ddr/altera/sdram_soc32.c
>> +++ b/drivers/ddr/altera/sdram_soc32.c
>> @@ -8,6 +8,10 @@
>>   #include <linux/sizes.h>
>>   #include "sdram_soc32.h"
>>   #include <watchdog.h>
>> +#include <wait_bit.h>
>> +#if !defined(CONFIG_HW_WATCHDOG)
>> +#include <asm/arch/reset_manager.h>
>> +#endif
>>
>>   DECLARE_GLOBAL_DATA_PTR;
>>
>> @@ -51,7 +55,26 @@ void sdram_init_ecc_bits(void)
>>   		memset((void *)start_addr, 0, size_init);
>>   		size -= size_init;
>>   		start_addr += size_init;
>> -		schedule();
>> +
>> +		if (IS_ENABLED(CONFIG_HW_WATCHDOG)) {
>> +			/*
>> +			 * In case the watchdog is enabled,
>> +			 * make sure to (re-)configure watchdog
>> +			 * so that the defined timeout is valid.
>> +			 */
>> +			debug("%s: %d\n", __func__, __LINE__);
>> +			hw_watchdog_init();
>> +		} else {
>> +			/*
>> +			 * If the HW watchdog is NOT enabled,
>> +			 * make sure it is not running, because
>> +			 * it is enabled in the preloader and
>> +			 * causing boot loop if is not handled.
>> +			 */
>> +			debug("%s: %d\n", __func__, __LINE__);
>> +			socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
>> +			socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
>> +		}
> 
> The legacy hw_watchdog_init() function is being removed, and the watchdog is either not used or has been migrated to the driver model framework.
> There is a risk of watchdog timeout during boot, especially in SPL when clearing large memory region.
> 
> DM for watchdog is preferred instead of legacy API, you can check how this was implemented in Agilex.
> 

Sure, will check the SoC64 code and make necessary changes.

>>   	}
>>
>>   	dcache_disable();
>> --
>> 2.35.3
> 

Kind Regards
Naresh
