Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D525C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 16:02:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B71D1831D6;
	Mon, 21 Jul 2025 18:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="hwNznn1i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCE50831D8; Mon, 21 Jul 2025 18:02:03 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01299831B5
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 18:02:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mg+8VDYenaUSsTRZNLb1QEvo7sb5zTgGWFJN7OJWSAn7HFy70gj50e+iyNl31yjXo40cdHMvKmq++SqlCxldXzKTCdLrQkO5U4uC0G3V72LZ2Z8CbJ14XmPixLaM15XWu/16l25nPahL+FZpYbGgF+P9IpVjJPaoeyLHt6XMt2bJRAQ4GF2HYzOykUu2bRfi4ElKLqD3yfAq2Qjprq1A7LDLJqJKXYzSwXMrZcwaLznP0AgEsriVq4YovYwssRHX1DIe1orGZdhP+MPoNbBvTOh/eExXWfXFmvvGvUw0cQwpPhZJ8KVlBIzkP300RgHzfeenF4FGaR2hdf6lkImtbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nCYERExW8HxiFHPLNH+zorOZ7o0Big7eC5YNq3iwrA=;
 b=fsSOlQd4hO1rz+IGmKlOBUJz1mJFNmKRVihlDSTlApm9qWPqsPx5c11eixlrJql9NHH6mDmr3yVti/exYgtKtvnT9VQjKexWsy3D1UTVYAMzRtjGJQ17fCKTYOUCBasLvN7+ugANXCEEGKr8p4lE68k/Ut5OmvsnkNHFGFqvLte3fx7WH4JIwuhzw5cKV+yrJ5M/JeDSRb10iZ4FY3OX1SZmZHDy1se9/m4+t/2qB16f22+U3Ht3IB/U/K5xtgOmPFeuJxnPhFaGPjBCpv9/JHG+AqHI5zCHJ73hQgzQ143X1VwkT/TPfQbgpUS25nm4qvIKYJAU1Zca5G9BaVskIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nCYERExW8HxiFHPLNH+zorOZ7o0Big7eC5YNq3iwrA=;
 b=hwNznn1iyhui7bZzH52VuFz0AooWnjjYmsp5P4SYQwnTPs5wFhfQp2AAMeMFjfPWsCneL2BicaGng91yD1X+2OmIXLMln99L6pb7u02Aumemuc559Mwd5g8HbJCPBToPEwvoLDkIYIl3+kyjSGCmr/tVL7jxaB2QOnwsmlFSNH/nL3mHumvrmDr5VStJwICD23dusl6avhuFOKtN4xKuCWavYdc+CC/2jOs6sW5UEDwklrfYNmOw8zyUnpBJRFSv76LpVoeb6DoruzUrGZm6xZEukBqJqx9qtnBPr91pNNeiqHsB8Ku7U2TtR2hFpgQpd+JslvOdtyy4IfENAcMEFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PA1PR10MB8766.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:440::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Mon, 21 Jul
 2025 16:01:59 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 16:01:59 +0000
Message-ID: <0a2c9ba5-a0fa-4cd7-9e29-0874cf085f2c@kontron.de>
Date: Mon, 21 Jul 2025 18:01:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] imx: power-domain: Enable refcounting on imx8mp
To: Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 Samuel Holland <samuel.holland@sifive.com>,
 Neha Malcom Francis <n-francis@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Heiko Schocher <hs@denx.de>, Fabio Estevam <festevam@denx.de>
References: <20250425-ge-ian-display-support-v1-0-8a7a0fe75023@bootlin.com>
 <20250425-ge-ian-display-support-v1-2-8a7a0fe75023@bootlin.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250425-ge-ian-display-support-v1-2-8a7a0fe75023@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0429.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::10) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PA1PR10MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a83ba28-dd29-4d25-2470-08ddc86fec9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3VtT3h5QlBFUEJVSWlUZEcxdHhFVmtqbXJlbnRqMlZNTWZUWDFndXpxL3h2?=
 =?utf-8?B?YW1sSGVxMitrR3Y5ODR3RzA1V0RpS0FseXhYSGozVFlrWU4zMEFsQmRqNTl2?=
 =?utf-8?B?c0NvbjhsalFaSzUvTWNzRkxiZFd1NFRDcGJ4TXFVQXN5SEluMDlKS0xGSTZ1?=
 =?utf-8?B?L0tKTGV4Tkt1WXphWHQ5azJXamZkRGNobXlzalRpUmlpdXJUeDZPdG5HS2FL?=
 =?utf-8?B?K2VmcmlRZDlhaUpXTlBDcDBxcDRoSFIyZ25IdEdtSUpsVm9sTndGdnJtZjU2?=
 =?utf-8?B?N3R6eWF5Y2x5R3pPYS9sZUNlOWJtYzhhNkw1bDRkc1d5UmFkTnhHb2hWaTFC?=
 =?utf-8?B?MGt5d29JRkVkY1pEQkF6Z2pmMTE5akpYOHhPMXkwd3ZJQjBQblB0WmM4eEFN?=
 =?utf-8?B?VUI2SkNwd21DTnAwVGZPejFLdFhEWUxQdkhwTWkvWm1rck5hS2U4dVlSY2l4?=
 =?utf-8?B?ZEQ2WWM1RVp4Sy9GYmlxSnRESEU1aHRhQkVqb3owVmRPRUI3bC85d0dXOUhl?=
 =?utf-8?B?eGxJWStNNXNpd2JGZTNZWmFuTjFZRjRzVzJ1cmFnQ0tCQ1RybUhJS3lzSjBF?=
 =?utf-8?B?bVRYa05jSkN6WWRyREhXaFVXSm13eUQrQUc3TVAxeUlSRU9DWEp6elRzcXpi?=
 =?utf-8?B?UnhQZElPOGdxTjE0Ukkvd1VLbERjRmtkT29oMTJ5VlFVQ2VVTW9JY1gza1di?=
 =?utf-8?B?MHcwZ1FnZ2NzVkpVb0EzQmlRV0cvMDdVRlNxWmUyazBvZjQxQUdZbkhVM0ht?=
 =?utf-8?B?TjZhQXBmeTJiM0RHY2VtUmQwQVNIdzZFYmg1QStBeE4xTEpWenhCNnlWQlc2?=
 =?utf-8?B?NzY3bENsOWsydzFGb3VlY3FYRE11TG93U0xEc29GTmM5Q1drR3VYTHdQWEIx?=
 =?utf-8?B?SzZscFlnRWFocFBScFZmbGNDblFid2c5RUFzZzlxUWZBaUZFMEllWFNwYnNM?=
 =?utf-8?B?WnZFTkFSVmVkOWErUzBxcVc5aHEyTFRnVjJvOWtFODBIR0FweWtNUGFCVXJq?=
 =?utf-8?B?cXVNbGtEcU5ibWxJK1dGazBrMkYzd2VrT3JmYlVKUG9nbWFxVWdwalJJa3hz?=
 =?utf-8?B?MVhqOHAwWHkzNFlNbVFXKytDMjhCdk85L0VjbkdIczk0Q1BvMzgyeG1lQk9z?=
 =?utf-8?B?RnZzREp0OExMRE9CeVh2RXhjaExZMDJtK3hJMnFJMjByL0JyL3N4eTRHeWZL?=
 =?utf-8?B?MktTbVQrSlIzRTVMRGwvSHlZUVFzNnlhcjBkb0U4ZGpoRXAySFR4NEdQOG96?=
 =?utf-8?B?REk5VlNHSWYyZDdlMU12Z2poWXVpamF5cHFINDZLdXlFdXFVY0xJTjVGY1hz?=
 =?utf-8?B?YkcvK0FHS3hhNWVZU210NXJIWnNRUUxSUVdGcERHZXZQRjUweUxJZVdGdGcy?=
 =?utf-8?B?OFpZMHBESEU4RVJYVkVOYTRZRG5wRHhkSVhtcExPYkhmcVJMQkRHaDg3Zlpi?=
 =?utf-8?B?blBjb3p6bDRhZlBvWDJXcEplOUR4THhmMWxsS2NZbm9jalZwWmptMDBTaWw0?=
 =?utf-8?B?UjZBS1JFNHV5UCtDNTVFQzVoTmZtQTBjM0FUaW5yWkdWOFZBQm1HT3UyNlNq?=
 =?utf-8?B?SkFkMVJJd3ZVeXlOdzFERTNwRWhyUkg4WGF5TmdPK21BelVLdWh6dzhqTUYw?=
 =?utf-8?B?V0JxcGp6bnVDZkxaRE12d2hmbmJUV2ttNWJuNE9KK2dmTDgzV3FuKyt6KzZu?=
 =?utf-8?B?RFZ0aXVKRnc4TjVkM2tLaXhqTzkwcGpjY3ptMXY5LzhhcWtnNzVkQzk4RHF1?=
 =?utf-8?B?RlAxa1ljTFBBc2ZFcDgreDQ4ZUhGZDA1K2o0V1dWMXAyV1dIMmZmdm52K3cx?=
 =?utf-8?B?UzR0Y2xReFBzaU82bmNDbW5yOW1qeWtsSmFJT2FLWVltbktWRTFxblNmRHp2?=
 =?utf-8?B?a0RNY3kzcmNVWlFhTEhudEZKQzgyaHRYTTVLcTNoNHRBaDZGY21WWC82TWlq?=
 =?utf-8?Q?eFyclSh1xGw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THBMa3Qvd05lK0RURkdBaVR6dXExSHM5Q3YyaHhTYkg5Rjdab3duN2M2T0Zu?=
 =?utf-8?B?RHgxK1MwVUdXcWo0Z29ERzY1QitVTFU5ZWpaemdkV0tXN3ZDd3E3UStBc09z?=
 =?utf-8?B?YUxkVlBiMi8vY2FWNFhobFhQbllRYmtXWHJnajhYRzZESzdZZXhqQUQ2Nzht?=
 =?utf-8?B?eGdoVUtqU3gvU0tRSTZTNjZ5VEkvejNWYWp3RTlCOGhxcFA1KzBuM3dWdnNL?=
 =?utf-8?B?WWN6a1BycUhzQndLZS9hU2RwUXlReG5yVzZDM0txUW5RbFFtWU5FU1lqN0tq?=
 =?utf-8?B?OW5QQXhqVHNxWHR4SWtpTFFLWFdkUi9hWU5GSFpVTW9WRGdvNERKcXJabEZn?=
 =?utf-8?B?Vm1ZVlVoWnhDcTd6Yk4yUjR5N1oxM2JiVmo1MXlZbUcyY0NJQVRibnFkZjVV?=
 =?utf-8?B?R2dWMkluR0YxVUJyczhodkYyTWp3YjgxSkRqUVQ1dUF4cm1LR2lCazZPSFFr?=
 =?utf-8?B?UHd3Wi9mMWN1a2xkUFhySUJEQStBS0dzbEpYVkdSQURSRmYxZkZqMVRWOFhK?=
 =?utf-8?B?OU1nTVl5VW1sS1dFSFloNWN2ek1GOGRqbTBDeTE1TSt3V1BQS3VuR2Q1NEZk?=
 =?utf-8?B?aTYxVG9FemVtdldzMTVKMG81aGhUNmhsWmVvUXZqQloyT3haT1pwcllkMnE1?=
 =?utf-8?B?czl5RkkyRmd6NEVOTy9yMGpKaDd6NndJeTA5Ri9HWXVGUWswYmk1Rk56eHJ6?=
 =?utf-8?B?cVoxSjdsNzdmMkdaNlhKekRMaVJFd1NEazVMTjAzZ2MvKzUrTEhFUG5JdlZv?=
 =?utf-8?B?YjluRVV0VDNNVHhHYTNtSUlCb0ZQMlFzbnJUaXdJZ0tId1NTajNOMU0vZ00r?=
 =?utf-8?B?RGxHL0VneURNeGwyQndaWENhdDJVa285VW1jNHV6RG9nc3puTnhzMnJPNnRa?=
 =?utf-8?B?SzNZTG41ZFZ5bVN6Nm9XVDdRYjI0MVE5c2w3bVJsTUpRS0w4bHpMV1d2UmFY?=
 =?utf-8?B?eUxIbG5icnB1WTY5VVFoQXNZNVZhdk9laFhTbjBvaTFJVVFjdGplbG5KM0Vq?=
 =?utf-8?B?ZTRlM1hWU21pRC9CalhtVVZVVE0yWENWRGpRNzJwUVNFNHBSWlA0cWUrNkVq?=
 =?utf-8?B?V2pncm1jNWpiMmprUFY0U3ovQ0hldTF3ZjVPYlYvd3dKaTVlME85QXFrMzJQ?=
 =?utf-8?B?WEFKcTFVeVJNcm9FbWZDTEIrSjdiK2RBSkx1K3FlM2dTMm9KMm1hS0NxQlBh?=
 =?utf-8?B?dlI0aFY1UDJ0YjBWeTdwbXlnMkZDaE51OUVZQXNRQktIZDJxNjhiTmQvS3Fa?=
 =?utf-8?B?em1YQWc0aXZ2QzVMRzJJbjFaeURsKy9UZkJVMm9LZWFBYkxLV2lWQ3hHVHhY?=
 =?utf-8?B?Ymwycmc1eEUzS0pMcVBadTh1SkswNzg1Z0JZdnVjRHpON3pId3ZHbmlWNDVZ?=
 =?utf-8?B?UDlvaWlXV2pYYnN0Qm04U05DT3c5ME41aXFEMXFJaUpjQ2xDaHlFeS9WeG40?=
 =?utf-8?B?ZE50MVA1OEkyTnpYT1ZaaHNsVVhuWStFWmp2c2h6Ti9yZWlqM25WRE1FOVZn?=
 =?utf-8?B?cjFCcVExdVBCK2xVU2tLMXFaR3VSZFFCdU1IOHExdkoweS94QnU3b2dGdC9y?=
 =?utf-8?B?Z3E0SWxkTXVoRVhZazBqUjVEM0oxV3l2T29lUGMxcGN2Tkl3dm5ZeGJUUXY1?=
 =?utf-8?B?MVV6OVprZUNxMkFCeG0xUjNpNUVUNzVkMjFGY0tlYmV4clVvWUJxWmZ2ejZE?=
 =?utf-8?B?THJxYndtRXF2UmxzdktJaS9TNFFISDhPRnZJS081VVBPNm1mNFNtL0lYa3pm?=
 =?utf-8?B?ZXdPaTVmUjkzeXNXRTZpclpCR0ZQZldxRzBBVEFxWURzOUNUT0w5MFMwNUFv?=
 =?utf-8?B?T2dGNGl1dHY4QmxNMnpSb2I5UFJOWVBQbEE1NCtnazdnTHJDMmVIN2x3R3NX?=
 =?utf-8?B?Y3VjVXZDRkRsMVVlUFJpVWpHaGV1SU1pbjUzaUNpRHdWOUx2WVE5Unl3TmU1?=
 =?utf-8?B?V2UxSzAyYm5pdkttVDdhSndvS1VYMkY0K0VyWXptclU3VmUvRGNzZytXOUpx?=
 =?utf-8?B?bTdHNUZRdEdtNDYycnVwaVdpOHlESkNmT0EvMGQyL0JpdjVqdmxMem90VkJP?=
 =?utf-8?B?MnkxQm1mayt1TWJub0FhYmY2YXpYYlJpSXNWZXJ1Tm05TVBPL29EaC84NWxY?=
 =?utf-8?B?R1VVL0d0Ym1uZzBscUVCUkw1TlVldXNrdjNEb05mS25ScmlpRmxySTJVTG92?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a83ba28-dd29-4d25-2470-08ddc86fec9a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 16:01:59.4541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPs0nhS6jNqCOurG4yTpT4F9gq3Gyyxwbr8GfvtULt0Jecqygaso53y1HxWdHUIKvsB3tvpvq4GOzoLcrcY8DDshnncXi0wjqogkZwctRIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8766
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

Hi Miquel,

Am 25.04.25 um 08:49 schrieb Miquel Raynal:
> Prevent enabling/disabling multiple times the same power domain to avoid
> breakages due to the same power domains being referenced several times
> by different device nodes.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

I've stumbled upon some issue that seems to be related to this patch. I
saw you already had to bother with other breakages of existing
boards/platforms in the previous implementation. Unfortunately it looks
like this still causes some kind of regression in my case.

I'm working with an i.MX8MM board (kontron-sl-mx8mm_defconfig) and I see
a crash as soon as I do "usb start" and then "usb stop" (log for the
latter see below).

As soon as I revert this patch everything starts to work fine again. Do
you have any suggestions? The power-domains involved here are pgc_otg1
and pgc_hsiomix defined in imx8mm.dtsi.

Thanks
Frieder


=> usb stop
stopping USB..
Sending event 6/(unknown) to spy 'efi_disk del'
Sending event 6/(unknown) to spy 'efi_disk del'
Looking for power-domain@0
Looking for power-domain@0
      - checking gpc@303a0000
      - checking power-domain@0
   - result for power-domain@0: power-domain@0 (ret=0)
   - result for power-domain@0: power-domain@0 (ret=0)
"Synchronous Abort" handler, esr 0x96000005, far 0x4ebacdc50
elr: 0000000040249c94 lr : 0000000040249c6c (reloc)
elr: 00000000fff4ec94 lr : 00000000fff4ec6c
x0 : 0000000000000001 x1 : 00000000fbf22750
x2 : 00000003efbab500 x3 : 00000000fffcdfb0
x4 : 0000000000000020 x5 : 0000000000000020
x6 : 00000000fbeea10f x7 : 00000000fbeea3d7
x8 : 00000000fffffffe x9 : 00000000fbeea1ec
x10: 00000000fbeea280 x11: 00000000ffffffd8
x12: 00000000fbeeb1b0 x13: 00000000fbeeb1b0
x14: 0000000000000002 x15: 0000000000000000
x16: 00000000fff4edc4 x17: 0000000000000000
x18: 00000000fbef4db0 x19: 00000004ebacdc50
x20: 00000000fbeeace8 x21: 00000000fbf21ad0
x22: 0000000000000000 x23: 0000000000000001
x24: 0000000000000000 x25: 00000000fbf28f10
x26: 0000000000000000 x27: 00000000fbf2ad40
x28: 00000000fbf2ada0 x29: 00000000fbeeac70

Code: f9400693 d37ef662 ab130833 54000140 (b8626820)
Resetting CPU ...


> ---
>  drivers/power/domain/imx8m-power-domain.c | 4 ++++
>  drivers/power/domain/imx8mp-hsiomix.c     | 4 ++++
>  drivers/power/domain/imx8mp-mediamix.c    | 4 ++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx8m-power-domain.c
> index e54ba5d9a5476f678fb48fb16e7217b031acd78a..b44aae78e6de9733e1e53bbec80f54562487a76b 100644
> --- a/drivers/power/domain/imx8m-power-domain.c
> +++ b/drivers/power/domain/imx8m-power-domain.c
> @@ -506,8 +506,12 @@ static int imx8m_power_domain_bind(struct udevice *dev)
>  static int imx8m_power_domain_probe(struct udevice *dev)
>  {
>  	struct imx8m_power_domain_plat *pdata = dev_get_plat(dev);
> +	struct power_domain_plat *plat = dev_get_uclass_plat(dev);
>  	int ret;
>  
> +	/* Every subdomain has its own device node */
> +	plat->subdomains = 1;
> +
>  	/* Nothing to do for non-"power-domain" driver instances. */
>  	if (!strstr(dev->name, "power-domain"))
>  		return 0;
> diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
> index 455ad53ef525e18ae45068fa5d8c2be8a1b79335..1ca43880ef56a03ae10e70f7e260022acc447dbb 100644
> --- a/drivers/power/domain/imx8mp-hsiomix.c
> +++ b/drivers/power/domain/imx8mp-hsiomix.c
> @@ -201,8 +201,12 @@ int imx8mp_hsiomix_bind(struct udevice *dev)
>  static int imx8mp_hsiomix_probe(struct udevice *dev)
>  {
>  	struct imx8mp_hsiomix_priv *priv = dev_get_priv(dev);
> +	struct power_domain_plat *plat = dev_get_uclass_plat(dev);
>  	int ret;
>  
> +	/* Definitions are in imx8mp-power.h */
> +	plat->subdomains = 5;
> +
>  	priv->base = dev_read_addr_ptr(dev);
>  
>  	ret = clk_get_by_name(dev, "usb", &priv->clk_usb);
> diff --git a/drivers/power/domain/imx8mp-mediamix.c b/drivers/power/domain/imx8mp-mediamix.c
> index 78c32ca3d3a87febdefd5d128d39d817674b8d32..504c22f7d3631363d76eb21e43afd854258d4ea5 100644
> --- a/drivers/power/domain/imx8mp-mediamix.c
> +++ b/drivers/power/domain/imx8mp-mediamix.c
> @@ -143,9 +143,13 @@ static int imx8mp_mediamix_bind(struct udevice *dev)
>  
>  static int imx8mp_mediamix_probe(struct udevice *dev)
>  {
> +	struct power_domain_plat *plat = dev_get_uclass_plat(dev);
>  	struct imx8mp_mediamix_priv *priv = dev_get_priv(dev);
>  	int ret;
>  
> +	/* Definitions are in imx8mp-power.h */
> +	plat->subdomains = 9;
> +
>  	priv->base = dev_read_addr_ptr(dev);
>  
>  	ret = clk_get_by_name(dev, "apb", &priv->clk_apb);
> 

