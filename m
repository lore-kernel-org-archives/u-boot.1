Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8407CD25959
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 07:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1B9A83F9D;
	Tue, 27 Jan 2026 08:45:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Vul44e1L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03D2783FA2; Tue, 27 Jan 2026 08:45:24 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 919FA83F53
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 08:45:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5k4guT1478TPhuH0pLQyzB0F1zdlnV75mTBzjFflt7zYIVHQTezegsudyyaTWFyFWuafWIMk38lA96Rp3RdHpAIXEi9FijbTI2g5qPlwwX90ozBS/QWzs0yAQn4ZySzOAx3iNzy5KgKCjr4aYRzEn7IJnjPnED1xe+heHNy3n8C2AVw6MYFRfMmPENvVQJ9vopM4/FprJTiqdQfaHz0FSkXu9V+/xvGK10ceCMJI5CUUQd++EllH8tiVu6hkblCWVki0kYs/RY2oK5SlK82GZrWuEBPW5r4uJBD0z2AhxwjGfyiFpI/l5khasGUQx94PH3CHMYjKF6VeNoUHK+ddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G06YQdt/aGf5UhxwRtQyDKwQDEfqwTKTurdsOzNA6iA=;
 b=Qfjz1aNoWqC186Lay8SpZfPDGR9P0eK+NrEqsr3tGu8ADInoImgiF9mtPbwLWNqakTfwTNyWz0jyzsQujs3nb4/4sbaoRfzBhfbXdVS6/8FaTsqOtZi1lo7MDWyDiB5zKmBbgIBAybfoYG+neUncu0xXOhgm+KQybq+Okth/eLzd146FL9Zym3fsvUOwyvV3wOddS/fiK/5aDk1LVdA2LNJ1NBh13//ZPRSU1wGOBohA5b+lkycBaDvGionX2vR1CR22TB7OltuQ+n7SsWu1tuKhaIn2RZu33EmAImJd2Qh4AWLGyqEs6XTb4e1N0AF4ZTBcS5ay+cuR8bgq85uyqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G06YQdt/aGf5UhxwRtQyDKwQDEfqwTKTurdsOzNA6iA=;
 b=Vul44e1LtKdO+X+cVC5odMqPaSo+ywevjSmpqoFuRaVnKdBC/HZLIQWymUPolwqNxMcbrhReACjheTa/3r5/sfOdMtO1ryOf5dm1yyASHXXgqBybFviuBBlrUKIBHvJ145ZpIprFXPhmSwZwAFmsw0qa2n4cRRaUSl8W6jaimQaqVuLBO+h5pTqnoSl068xCfOwo5iykPclBXBfK8AIQTRgcQwSHNJXdRxDS+ent5pULX1y8O2vjKO4KeFv1mdWOvomzN03M/S76QQZKxhktaQCtofLkjvCi3/q3O2SBB6YcHKgztVLMd1CbqqnC+jtdDoqshDUdvX0Qu6CjPXpvHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CH1PR03MB8168.namprd03.prod.outlook.com (2603:10b6:610:2b0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 07:45:18 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 07:45:18 +0000
Message-ID: <c25460b0-6223-40fd-a093-565fcd7453b7@altera.com>
Date: Tue, 27 Jan 2026 15:45:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] sync sdram ecc support to mainstream
To: Brian Sune <briansune@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20251215202712.175-1-briansune@gmail.com>
 <20251215202712.175-2-briansune@gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251215202712.175-2-briansune@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|CH1PR03MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cdeb732-f054-4b70-e20e-08de5d780434
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3lXRzI4WmMwN2IwV3dmSGF2cCsyMGtKMGUvSkZ2WjI2NmxOOWZpL3V1Szdr?=
 =?utf-8?B?UXpXWkVKTFRYYU9oNDMvNjdGQ3QyNWoraUJGRjZ2WW5QelZCK2xoU2p2KzlI?=
 =?utf-8?B?YjFxcWRtNC96UEIwVHo2UHI1aU54MGc0YzA4MHBTTER3Zlg5M3pGVmQ3UGZV?=
 =?utf-8?B?L1p4ZU1lTWJaSGZQbzdzR1ZpRVBPZmVZSzBQSGhjVzlaL0NzU1JzK1g3UFNT?=
 =?utf-8?B?a0pod3ZGN1VkUU1PVGhWWlMvRHhQdFdQb2EvWmFIakx5L2JXaS8zUHVvNUNI?=
 =?utf-8?B?aWM2VjB5RkFZTE5UZjB0RkR6RWMzVnNnNlZ6MHZ5aklhM0g4cm92MEVQM09J?=
 =?utf-8?B?T1BVRVlrU09DampkZ3JtMWp0bENDa2MyZkI1cnZHb0ppVFJQWFMvamhuQ0Mw?=
 =?utf-8?B?alV4SExHMFFRZXJNVmZHSXpIU2lxSFI1YXJTZEEyaUwxZFRPblZRNk8xOHZt?=
 =?utf-8?B?a3YwcFVrd2g1TU9kR2doTmJuSHlSZCtLNC8xeDVLNTdMeit5SC9ZRTJHY0VB?=
 =?utf-8?B?RmtQL2toU2VGMGNOdEJiQUl3anFlVWdsNGdmZE54eUlvbzdhbUNsQWtNZHZO?=
 =?utf-8?B?OFBvcWJ2cS9KSW5QYU1Kb3ErUTUyM1FpdndGUmZaa1htMGFhTzBkbVhYdWNO?=
 =?utf-8?B?dGxqVzRDR1crRmx4ZnlJbUJTZEx0RHRlNDNCMUZleVdCOU5kbmJ1bHR5Vmx1?=
 =?utf-8?B?bnprYkRGUVlKczlzUE4xS2VENlVldGJxTE1KbW5wV0Flb3RvbEtad2d1ZHJU?=
 =?utf-8?B?RC84VlZMZHM5cHZqZkZkM1NxNXFiODQ4UFJIYjFjL0d0MzVFc3Y4b0hCOHgy?=
 =?utf-8?B?ZHlhSm1qNG83RTVUa3ZST21qVmpLZk8vSGlmSEd6WXlJRHBKTjdoTGMydGhj?=
 =?utf-8?B?RjVKSnF2K3JGcUUyblZ3ZjFib1NZSzhWaDV1VDl6Vm5URnkzaTN0Y1dJWTVl?=
 =?utf-8?B?UHUyNktYQXo5a2Y2bUhyZ1RoN2JqNW5nc0ZxYmVMeFBkWElUV1RtSWdNU3RE?=
 =?utf-8?B?NEJKZWVKWHROQnZFckxYZllESGVoTEtZdmowd0dXQXY5cWtlNGtNM1NlRVJB?=
 =?utf-8?B?L0xTR051eE5zSWU2VUo3NkFMcnBxNGxCZFhQUktTcWNhYmNyaFVsRDg4TFo4?=
 =?utf-8?B?NTNWamcvSXZja3ZydmVWZ05ML0RML2dwVG1Db3ZUYVcvTFFFSWV6YXpVMlAv?=
 =?utf-8?B?aWE5dE5pWkN0cEowbTYwVUFWaHV4M1VITU8xZ3JiT1pyTU1nS2tnTGl5Q1N3?=
 =?utf-8?B?Z1FvN244aG1hcEorWmN4blJXYmlybnBYbGhCM2J6dGJkQ0EzaTc2ZFdFYkdv?=
 =?utf-8?B?SGFGa2g3L20zcFh1R0d5eXFqWWdVcmZBdEtwSldIbDAva0hxVGlMREdSa3JF?=
 =?utf-8?B?WkMwRFFNczdOTlVqd1ZYWWNhZ0pPc0xqb3k5dHlJUStlaEk2WGUvak05aHBk?=
 =?utf-8?B?RWt1S3A1eEJzNWRYK1RKVlc4MlEvcWpCYUI0eVNXNlZIM0s5SzZvT3ZMTkI0?=
 =?utf-8?B?bnpRcVBoSGFSVlNlc1NKWUdLWkVDWlNHYVBKSkZsK1BsdlBybXJYamI3M3FX?=
 =?utf-8?B?bmNDYjRYUTZIQjIwbVpMb1FyZ0dFaGs3Y3U2dDZpbmcydERCSnpNT2NITzly?=
 =?utf-8?B?WG11bnROVktmUiswSXJGWXZvd2c3SkxCY21Tbk9VZWZNRHlJL0k2ZWVJVDIz?=
 =?utf-8?B?TkJPaFQ0STk0eG4xenRRY3FtckZLWVBSY01IUDgwRzhEN2ZvUkxucnFmMWd2?=
 =?utf-8?B?M2JHY0xxMFFlc1NudzhTUDhDdXo5Q09HMXk2Q3pzQzNKekxCcmEzZTFHclUw?=
 =?utf-8?B?VHhLQk15K3Jwb2wya3hoek84b3pCaUhDSjVaOHhxUmVNelN0RlM1SmQwVnY2?=
 =?utf-8?B?V2ZtQ2dyUHV3YTd4SWJZazhSY2tIcEt3OUdGclBjWHRrMWFGQ05xTE96eVdi?=
 =?utf-8?B?bTV4TFV5NVhtaHhzaFU4a0tKcVd6ODlvdTIyVmZITEhIVFFFOC9zV255dXVQ?=
 =?utf-8?B?Ylh4VVZ1Z3NCT0hpRHE0ZXNzK3VKQktOOTd6Z3ZHWHM3KzkwU1l6SWpUOFJQ?=
 =?utf-8?B?L2tmY2hhTGFROEhBRFR0RUFFcGs1QzZCNzB5ME42dzBJOHExMFFpYm82d0JN?=
 =?utf-8?Q?5ZoA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGFSU21jbk5xd3UrZnNYRUdZK05NQ3doNzBPM09oMFZMMjBpMDlxbnlnSnVo?=
 =?utf-8?B?T1lVdzNSSEFMQjh4bzBHdFFhQUFIWVFvVmhaNWp4bkp5d1ZqVlNsM2JtUVdY?=
 =?utf-8?B?bFlkS1FLV2ZJSGtWTXdTZVhzaExac0oyUko4anppQmQ5bWN1OXkrMUJ2Q2RO?=
 =?utf-8?B?MGYvWDdRczZNMjc4bWJZY0FPRnJiR2NWenhoaU5JWGd2U3hmWmJUaDBqYXJN?=
 =?utf-8?B?VlFDTk5VdlAzaVNpL0dSWlJsdkMxVjBZMkNqL1JKTzEwRm9tOG1yNTdjRjhr?=
 =?utf-8?B?WjZMS2RFU3hIRHZJNElya3pZUDFUMDB5bUsyU3cvc2pwU0hWbEpNSW1TOEtF?=
 =?utf-8?B?cTZIR0d1QUcrTGxDT3ZPRHRWa2pqcEcrTWhnbE1NRDROUkZsQzhQRnVaTnZU?=
 =?utf-8?B?a2paSDFKbVB6T3p4WXQzTGVsM3VNWUJGY2xiZGFLS0xNbEp4ajdrZk54NzR6?=
 =?utf-8?B?Z1hSa2JBaTg1YVRremZ2ZmVjSWlmck5lQkpFSkZQZFRVNlRTdnNkaVpKSEhU?=
 =?utf-8?B?WnBmWlg1eUJhQmVGTkhldWt4VEZ3eGNTVnpVNEh3Tkhaa1U5SW9wbE9QdTg4?=
 =?utf-8?B?cjdMdjlEaHBwZHkvQ3pBUW92S0ZHZ3hMUTE1VS9rZGNzZThPeUdSbytYam1K?=
 =?utf-8?B?S0N2M0s0TFloQ2xpNnY2OUxPZ0Uvbm03cThGU3d1eUVsZXkwczhacjhhSHZp?=
 =?utf-8?B?UXNnek1VUTVHVG14TElTd2pNNzRFRmV2dzJyODRjcElyMHQ0UlBtV0k1VkUx?=
 =?utf-8?B?aEU0STVwR3FPcDdZeE1ZRS93TGdNNzVvUittRDFHWjA2bGxEQjJyWkprbjgy?=
 =?utf-8?B?bFROOHZSY1MwRFlNYmJ0STdLeGErTStGUmNwRDR3Q0NLZmlUc2NKazZ1bjNq?=
 =?utf-8?B?VGE0Zi9YS2pUMm9zZGRvcW5ydWRsRFBvNW9aTUVvNmVpM0gvemVqV0cxc0dh?=
 =?utf-8?B?cmU3Nlo5RTlwUysyUnk0a2xBdXZ0eWU1R2dYTDl5Y2MyOHh3TUJoQjZrTXBB?=
 =?utf-8?B?cWFjYmU4Z1gvOFhwNHFUSUdtWkFUTTdPS2VObmtXZXhkNENNU0NzM1BWYm5l?=
 =?utf-8?B?UEY5S29ieUxCNDdwYUR0Y1I0REdkNGxLSDIxUUozaUZybFQwYXlkK1hid3J4?=
 =?utf-8?B?cWNNZVY2ZW5lKytZMlFSYmdQKy95bnB0MXJSeGsydDQzckgzTmI2OVR1NHZX?=
 =?utf-8?B?Vmh4MzhkVHZyVWtUVXlqazRIUTV5THhRR1FLbGJwTE9oRDJKYmlheDFXWlFG?=
 =?utf-8?B?QW9RMlNRajVzbk5MMFRGanZXQ3JmMDVwKzZHR05FM2RqemFSQXdmOXk1VVM4?=
 =?utf-8?B?SG40UFJjRmtoaDUzaGUzTzZ1K1NJdnBrRkVnb2hma1NaZnY3ZDhxZHJ5SkIv?=
 =?utf-8?B?THlwQU9jOWdRZW0yVzRFRjRaK2hadnZrQytYRk42VHBuaFFsMGVtbGl6UUp6?=
 =?utf-8?B?NHY2MklLMzRyZWhmUWw4ZVpmVmVnbTdMUmVBOU5wWFhjZG5PN25BeERlZFhU?=
 =?utf-8?B?MTJ6ZGhQKzFRUU9uK2lwcEJYSElvRDBldCtNNzRjdlhGYnhpaXFGYjFtb1NG?=
 =?utf-8?B?aDRneWYyZnFYaUkvdzBFQmpBSFl2R1g0Y0FNMVlBS09XU0lva0MrT2VYRDZT?=
 =?utf-8?B?NC9PdUluN2VDVGNGQTdQd0p0dW9iNk03WlR5ekpxdXZQZFdTYkhFODFWQno2?=
 =?utf-8?B?U2RoSW1VZlZKd1p5Ynk0aGxtcTNyY1NpeGIydjlzaUhoZmh2dU9SUnVVZkpK?=
 =?utf-8?B?aWo3dzJHZ1N6MmxYUGlERFdjTGhpSXZVWWx3bkE5S0VVenZnTmkvbkhvSEpZ?=
 =?utf-8?B?aXJMMlVESGM1ZmFCMVZ5d3A5OEx3SytjWWZ4TzZ2YTZMeGtYRFdoRnZEQ0dw?=
 =?utf-8?B?UW53cTY5NlVQRVFCWitRZm13eEs5bitnU01hcVpZWjdXS3IzbCsrNTEwdlVQ?=
 =?utf-8?B?dUpjV0owaEQxdHpOcDh2UEp1ci8vcGdFNlJUanNZamxWK21FTmRzYWRUTlZM?=
 =?utf-8?B?WUxEdnVmUG5tRmowalp1Q0h1N2ZMclkwSGJLYkR6c0EyM243eGVYQTN1bk01?=
 =?utf-8?B?aC84MHRpQkpRK3YwYTRQbTZTVXdLMWxXVDFJdEFxTWJYRzVINVNHeFUxTERY?=
 =?utf-8?B?dC9KbTJDWHB3RW5mclo3dDdGTlN3VTQ0Tk0wcXJIVUVKU1E2NGlqTU10VHhQ?=
 =?utf-8?B?MmRvOERCaERPOWdxRDRVUi8wbGpHUUNIdDEvWEpxM2g1anNXcDVZaW9DYU9s?=
 =?utf-8?B?WlVGL0FnLzF4N1FDc2NuZ0lzQzNKK3hOdm5MZkhVcHV3NXFaNlZCcjVIY1Nj?=
 =?utf-8?B?TW1QM0l0VnVKMjIrcVMrVHN3WWViVW4vQ1grbnM3aUJHczdZaXNPbFFYUC9J?=
 =?utf-8?Q?PbnX67O/lyl9SL0k=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdeb732-f054-4b70-e20e-08de5d780434
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 07:45:18.7021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXZ/kJWUI5ldc3yjatL4H5xyJTTGk0tkyD3lJEsuI5IvpIUO0/0JlLlGWZyldKKUxLTnntYNkg1Q/uU5voAI9eOfilsESn/NejrQyrFBF0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR03MB8168
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

Hi Brian,

On 16/12/2025 4:27 am, Brian Sune wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> It is been a while that the DDR ECC is missing.
> Pull from Altera trunk and sync to mainstream.
> This sdram_soc32 introduce the ecc setup.
> Modifications are done to support dts memory@0
> while old memory will work properly on gd->bd
> Real ECC supported board test is required.
>
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>   drivers/ddr/altera/sdram_soc32.c | 71 ++++++++++++++++++++++++++++++++
>   drivers/ddr/altera/sdram_soc32.h | 11 +++++
>   2 files changed, 82 insertions(+)
>   create mode 100644 drivers/ddr/altera/sdram_soc32.c
>   create mode 100644 drivers/ddr/altera/sdram_soc32.h


Thanks for working on this series patches.

This is covered by Alif’s more complete submission, so I’ll mark yours 
as superseded:

https://patchwork.ozlabs.org/project/uboot/cover/20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com/
If you spot gaps in Alif’s version, please add review comments or a 
follow-up patch.

Best regards,

Tien Fong


