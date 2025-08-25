Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B573FCA0EED
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 07:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 197FE82E37;
	Mon, 25 Aug 2025 09:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="YqUAAWdW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21BC582FC7; Mon, 25 Aug 2025 09:50:41 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9491E809A5
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 09:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTBAgamnxAxr4UOhGUFesa0yFyws9caCENEfDH9Rugr5GEaU//7iRQcofFndzAIJqvPhFy0RV+ylHlGtRgQY9eFlAb0Zx3lSrmratb29EtEEkjH6kPL59hBf+WkWCVgTLHQK6enSvNrsNQ6JndJaSEN4hMqguynvaqx9mV6kMqtVU4N8nplOMMDl3dyq4nqLP6IdZTpvLllEqIRzQBfoKcf3dlWEQsliM+Ei13USh9E//5nv/0664iOQ65Qzmda1YkFzN3UcTknN6jtihngoA7Rw/PaezHjqO8lqpM8AS67WkJz3so8j90SI0yotUs8jRMoggfCNvOHm9xGd9i2a0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geH56dzQDKRg8M8vj4lRsCeVhdYjmBwo99DDnNejE2o=;
 b=qwyagdIBTuGFRlDRln+RKdwgJ1qIAyKJW7ErrMwQ6A0s6I/LPGASnTTzU7G93ATbaiJlW6qZ6gVVV0FeGSR5ih2uQ3AFP3Wia2zoqXZ+v+aJXoq6qClCig4Bem3Dod4AJPkYo1VWAE4UQWlmvzJ/UVyoaaHXgd2IL6TLBj8ZSOGZqy12Ke84KrVKvTkCM8jDjSiHRTqq+5st4mLVqs6mK9f5h0jNcxVvStEWrf0LCWQmjj96yeozPiY99hl8jqUD+LZTotkxr23lrctmM3JE86RYT8ZSVda9Tex3bAUTrzZChsdRfd5L2aKnvLyOTFubtl94ZtO1tRjtT3hMTkLjvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geH56dzQDKRg8M8vj4lRsCeVhdYjmBwo99DDnNejE2o=;
 b=YqUAAWdWK0mrDzZ4Kxck8p9vpnNZ4efFt4I3NnYbGBV3GR5konQpy5yEK8abDygGIdr08kZ3TanmN75aN2b2IKPRz8TLuXqmfM+uw07+XPE0RBY1SpaxSkcAVp+Q2+28CsOuSjTw9dnKLPgfcsLTGbmZIycCYaeNSqm6aOS9dDTx+lpcd2jW7tpCtDkENhjKSL3jzctyxr79Own3FhZtBWWHIZ7BTzG8+dKnOcyiNASsCJquvV0W2KBinVk0bwz6dyijuUyKJIMjwrhVtoSU+CKcUwT2IaE86wO3jap/BL3F+QKySoqcOU6MyQd7rWTEm9i7ZS6A1oRZNirakaZWlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB9300.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:5a3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 07:50:36 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Mon, 25 Aug 2025
 07:50:36 +0000
Message-ID: <2d34d634-8fa5-43e2-ba03-788b5865b751@kontron.de>
Date: Mon, 25 Aug 2025 09:50:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: imx: imx9: scmi: Fix booting from USB
To: Tim Harvey <tharvey@gateworks.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Francesco Dolcini <francesco@dolcini.it>, Peng Fan <peng.fan@oss.nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
References: <pqr4l75nuc57vmrp4r3hjwjxi4p5dgwxlz7h5nrn77rfxwpfmr@dto7364jv2ei>
 <beef5a40-acb8-4f47-944d-d876f5634cdc@kontron.de>
 <CAJ+vNU0pWaYCG86_XNwb9dMOLhTUzw_9hdFE7xpbMh4G73X0nA@mail.gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAJ+vNU0pWaYCG86_XNwb9dMOLhTUzw_9hdFE7xpbMh4G73X0nA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::13) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB9300:EE_
X-MS-Office365-Filtering-Correlation-Id: 743cdbe3-4859-47ab-c5dd-08dde3ac13b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0Y2YUZZS01pdmtsKzBLNXBiUncrSm9pajFBejBUOWZFQ2MvbnZ0OWpzZTlW?=
 =?utf-8?B?a0t4NFVlMkkrV0pTTmw2V3h6a1hXQnp5MjdSZ2w0OGs2NzFZUHRrazR6eGpo?=
 =?utf-8?B?R1RRNlhFK2F2bUhiZ2szZkZkRmZEckVsRXE5K3h4Q0krRCsvOXRnLzVXK090?=
 =?utf-8?B?VEhoZ0VBSlIvZng2SXUraG9KcFR5SlZBUGlCNlBlc2FTZ2FBeUpIQjBqQmY1?=
 =?utf-8?B?YThaNCs3S0FyY05uV3NKa1RJdXlKWHlnenh0RjltcUIyV3djR3F6UmszbGpy?=
 =?utf-8?B?L3FRTjAwTHliQkpnb2xWSFZGemVZQlpYbVZpckRqaGRJN1AxcWtUcDhZWVMw?=
 =?utf-8?B?YkVTWG1QQTlCUlNjRjZvRjVOS3RzTEUwNmJtUGtxSjB5d2liSkNsWVkvdkJ4?=
 =?utf-8?B?YVRMejFCU2hIUHpudy9aMkxEZW12MmhIVGZsTkZhMERLdnV0bXlWTklyMTBC?=
 =?utf-8?B?ZHhLbHBucXVHVmxTVGZoTTFWMHpLUFpYRjhtNEZmR3RJV1VIY3hER1lybkRN?=
 =?utf-8?B?UVVaK2tVMzEvOGdDVW9MaEpBZUo3VTR5NFJiNm82R1BqYWtlNTNvU09ycCtY?=
 =?utf-8?B?UWU2ZjZZKytyWGZaQkF1dkhaMytOLzlhKzR3UlVkMWNXUjQwdzBPcnAwNCtL?=
 =?utf-8?B?SHhZODAyWWxnZ0g0RmFac0paZ2V5dW5SUnk1Z0doVXNNVjR1RExrckV5NmNW?=
 =?utf-8?B?ZnRaTkVJM01OK1FFQ21RYlNLc2p6T3QyQSswVTZibWFrTlhyWjBiTnAxYVFS?=
 =?utf-8?B?UnVOanhKTThUc0lNckIxWU1YdEMxaldCeXRydUNxUkZDbVQvRU9VV09UUkVY?=
 =?utf-8?B?RUlVUEZaVUhRbTJHNkFmcDJVQkRRc01iREk2ZzQzZnpnT29Wb0F1bDV3RTNa?=
 =?utf-8?B?QnlDaGptdXNPWWo4ellVTzc2eE42YlJFaFhHTnF3Rm5na1RITExZMzlBem5s?=
 =?utf-8?B?cGVjQTNmdG5vZ0pTcEpNOVdxU09YOGFnSUMrU3AwOG55bEk3bnFlL0J5WTBX?=
 =?utf-8?B?QmRGVURTWk5TR1UweGtOWFlzcnMwaHNqQUlncUh5RWFHa2gxeE41czVlOGJn?=
 =?utf-8?B?QVRLZXBTdWNrV003V1hYdTJRb2g0bmdzOUNSbDJtMENBT0dqWk1NdVhSdTha?=
 =?utf-8?B?TFFNSG9icUpHWm15U3V4dGx3MUlSVGoybGVvQTRyUFhOenZhb1ZGNWFWY1ZC?=
 =?utf-8?B?Vk5MYjU2Y0E4YXRWRjNjTHMzU1pwamRqMUtkUHJkdGJETHBBNENWaWJpZkJX?=
 =?utf-8?B?dXRxeDl1UWw1bEJVOGlYTHo5b1pyZFk0c2djR0tjd21keGR6R1N4S2o0Wjls?=
 =?utf-8?B?U0xwclVGZlBzTmg5VXBERXRIemd5SENVR0k1UERKYVlhV2pPeW1DZWE5S1JB?=
 =?utf-8?B?QmZOcVcrM2RYMHRUQlhScnR1ZU9sRFd3S2ZQem9mUTlwVzYzNUNBb0xBNTBU?=
 =?utf-8?B?TjArS1VIbTEzUUhpQldEaTNTK0g0anpsTk12ODlPQ1k3SzBnOEk4QnIrM1d5?=
 =?utf-8?B?M1dnQ3l3eG96NFdVcWlXVVVqYnJFSFI1dzNwS2d0bGdJUmlHQmd2R1N5NFVa?=
 =?utf-8?B?WTFDWjRCUWk4VDdEZjBnNHdyVjN6TklXRGJ5Z3RSRkxVS2RxNVZyNit4OEZ2?=
 =?utf-8?B?UTNPc2M3YjlyRHhhUERweitFRGhzYllnYnQxTE9QTjZOTU5JODVXVDlpcGgr?=
 =?utf-8?B?a1p2cFpOTGhOa1BINU9QemM1RGxRY1pEZ0Q4VWM2NlVsa3h3ZTRScGpEb0tB?=
 =?utf-8?B?OENwMlFDYTc0UFY0M0RKamcxVE1aQ0w5RHM2ZzJRVkI2T3F5UktwTjlQZC8w?=
 =?utf-8?B?VUZ5MzhyK1pIekZnOVdWV1B1c2lVSlV4QTlOWXJSVndTMWxDbFRVWGtTWU1W?=
 =?utf-8?B?ck1ISVRWdGVYc0w0VGI1SExMajlrNDVtUGlZc21GNGpEd3dTcC9oc01xWm54?=
 =?utf-8?Q?W8kCGqGnUxA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHpUcG5lTnJ4ckdJNzZWL0hXazI5T0FDc1d4WEg4aUVsMlYzY3UwajcyU1Y3?=
 =?utf-8?B?RmcwdzhxN3NtMStSN0libnB1bjQzUXJRUEtPNjV6Z2htTzBxdTZMYTBLcmtI?=
 =?utf-8?B?aitJRTVEcWZCTUU5c2FMdDQ2UktWZ0FiTG12ZXhzM21PVjF1endSa0JKOXB1?=
 =?utf-8?B?SWwwQUFZYUJsOWR3MzYwb2NpZHduVHR6TW1rU3Q2Ny9tdXpXZyszRDg2OE9u?=
 =?utf-8?B?elFCLzFQdWwzWG55c3ZtTEdWUFFGcGZud2RsTkdxUGo0Sk8rMEM1eERLOGRv?=
 =?utf-8?B?d3l1UGxiNklHTG9ISmp0eFlXZ3dwaGs5KzZhZEQzRDhzZTdZUlE4ZGtqRUhz?=
 =?utf-8?B?VTJtSTR3YjMzL3FNMHdnRGQxbWdLdHNxa0x5MjcvNlQ3K2FyRWZhL2hQRUls?=
 =?utf-8?B?QXpENlhPcms0TEhINTR0NlhLdnFSSU41QkxoSThJWUtxa2tRS0VvVkVKQi84?=
 =?utf-8?B?UU5qZ21NYU0yNU5LcS9uRVlkODVzZjBIM0kyVENLZVlMdksycTNNYldVbzc1?=
 =?utf-8?B?Q01qNDltVHhRcVNOSnhBYm81RllhNGN1RENkbzlSSWNuRjBCQytwcENpMHlH?=
 =?utf-8?B?SWsvTUVOeG1LY1JmdDc4Mk44M1laK1FGNUZJalA4c3Nna0g5eGlpZ1RaL0Rz?=
 =?utf-8?B?ZUJiRXRwYUZ2cmtHZThiM0c0c3VyNkpJSXN3VUFybkN2Mks5dEI3d2ZJNUZx?=
 =?utf-8?B?c1owNmNOUTdQQ1dqcmZrYkE2Qys1VmZXMU5QdFJjcUliYU5mZ0pYOGV1ZEgz?=
 =?utf-8?B?Qm5iUkY0T2xIdDBiRWlnNGhYTk4vampXREN2UU1EZ1BKSHJvL0x2ZUlYM0lj?=
 =?utf-8?B?NWprMTgycmk0MWZ2T21DOUhVdnpvdHN2My92WEpXSmpyYnc0WHZvWDJiSkhQ?=
 =?utf-8?B?Q3llMWhqUkd6alRyVkU2cWt2anY1VHdaT0JvVStzWmJqNTdubEVyY2tzTDFX?=
 =?utf-8?B?cFVxVm9qSmd0Qk03UUhud25zUTRNUG5oVGVMUUhSdHBtbmowUjM2QzlUc2U4?=
 =?utf-8?B?RzAyUTB0ZjViSnpuMVF3bTNRWU9JZzVoc29rT1VtMWJ5WlZGNlpPVUpHWldV?=
 =?utf-8?B?OGVkTTJ0ZVRML0JSSmFuUlNudys0dHN2NjFINGo4ZWRTSG12WkZFS3BGMTJq?=
 =?utf-8?B?NTRKakVNdFFSdUw1TUxtbDFkM1k2V1hleVQxbTl4c3U0WGhSZTFYTXNKVE1y?=
 =?utf-8?B?K084d0pUd2svM3YybStYdWFZV3QvNVBYcWk0WktqaE5xOFcxbzk5emFzNjJU?=
 =?utf-8?B?SGNQY1NoWnlRZVBoVzM1c2JDVXk0OW1jRm9jNVdLeEVFMEVPMTJOZXRBSFFv?=
 =?utf-8?B?OXgrTCtHU0dzTVBIMXV2ZW82aGpzQ1NWOVU5QVFwSmEvQmEyYUlBbVUyZFc3?=
 =?utf-8?B?L3dMcnd1Q2E3QllyclJCTTgvbE9EZzd4U29kMXZrbW8xM28xb2FSZHgvakxG?=
 =?utf-8?B?WE0wZjZLYmJ0cndROHlmMlVrZnE4Um1PWk1UR05Tb0ZpRDN5Vnl2cXpReDlh?=
 =?utf-8?B?dFdoclV6MGNFczVaNEI5MjVwS2FreldLajc2SVJSZmorNjNDS0pDU05PZC9x?=
 =?utf-8?B?WGJ6OTlUcnA2Y053TjhYZFNhbytRczBFMG9TRTlYSUlwMVJJMHY2K3NVR1d2?=
 =?utf-8?B?OWFYZVY1anhzWlFFMEh0OTc2RHhsSlZDVVJGYW1aWWdRZFdMbUptRXRBcWVy?=
 =?utf-8?B?Vlg5cDAwUVBUeXc3L0tNRWNiS0tJNzFJYnNGc2gzWGp1WDJDdWM5R3FRT1ZJ?=
 =?utf-8?B?dE1JQ0RQWVNiZGFaNHo5ODhCOEtyOVYyYkl1UXVXV0FPZ294N0dNRE5GMjh6?=
 =?utf-8?B?SS9jcXdpVkhYWWtRRUJ1REZ1VVRTci9TZ1IrN25TdW5NVUh2VmxHbjhkaFpK?=
 =?utf-8?B?NHhUV3hTdi9zTGovSS85cGxSVUtJZTZaVjk0ZTdwN3VuMGY1MTRKaWYzK0gw?=
 =?utf-8?B?ckliTXliNSsxV29NSFFBZlVsWXZwRTVnMzROQXRPc0loNEhlZnExWWI1MVFy?=
 =?utf-8?B?M1dRamIrWUptQzFhODBuaEpXNS84ekhBVmhlRlppbDA4bzI1T2FEN2JFcSsw?=
 =?utf-8?B?YnRXN2pyS0lBNWt5Qk1nZmNXRHlEeGxFUm5TcUZZVTJZYmJnRTNQdXkybTYz?=
 =?utf-8?B?b3dNTWZSZG9tMzl4WUZOUWdWcmZxZ1pqak44QlhRSW43U3NPVU1pY1N2NStN?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 743cdbe3-4859-47ab-c5dd-08dde3ac13b7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 07:50:36.3242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KG3nQQ30189XY6//iipFJoxNlF+GHBymgJmdhIRxwJf3BbO71z68riNuD6csQUrG+hkcdhtugCgNlOKpySzz9jAsaaw4d/hGcLwrIjG5VIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB9300
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

Am 22.08.25 um 19:05 schrieb Tim Harvey:
> On Tue, Aug 5, 2025 at 11:53 PM Frieder Schrempf
> <frieder.schrempf@kontron.de> wrote:
>>
>> Am 31.07.25 um 20:47 schrieb João Paulo Gonçalves:
>>> Hello,
>>>
>>> On Mon, Jul 28, 2025 at 11:25:04AM -0300, Fabio Estevam wrote:
>>>> What confuses me about João's patch is that it was not tested against
>>>> the mainline U-Boot.
>>>
>>> In the end, the code is nearly identical between the downstream and
>>> mainline U-Boot.
>>>
>>> On Wed, Jul 30, 2025 at 08:35:40AM +0200, Frieder Schrempf wrote:
>>>> I have the below patch in our downstream fork to fix the issue mentioned
>>>> here for i.MX93. It is derived from Fabio's patch [1]. I'm not sure if
>>>> it's correct, though.
>>>
>>> We are also doing something similar on our branch.
>>>
>>> I have two proposals. My goal is to prevent the board from hanging when
>>> booting from USB if CONFIG_ENV_IS_NOWHERE=n (since the current code
>>> assumes it is always enabled) and/or if the environment is defined
>>> elsewhere:
>>>
>>> 1) Imply CONFIG_ENV_IS_NOWHERE for i.MX9 (as mentioned earlier), to make
>>> it clear that it is required by ARCH.
>>>
>>> or
>>>
>>> 2) Doing something similar to what Frieder showed for USB boot (which is
>>> almost the same on i.MX8MM/i.MX8MP), but preserving the current
>>> behavior:
>>>
>>> diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
>>> index 13f13ca7d105..f973652d0cbe 100644
>>> --- a/arch/arm/mach-imx/imx9/scmi/soc.c
>>> +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
>>> @@ -635,7 +635,8 @@ enum env_location env_get_location(enum env_operation op, int prio)
>>>
>>>         switch (dev) {
>>>         case QSPI_BOOT:
>>> -               env_loc = ENVL_SPI_FLASH;
>>> +               if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
>>> +                       env_loc = ENVL_SPI_FLASH;
>>>                 break;
>>>         case SD1_BOOT:
>>>         case SD2_BOOT:
>>> @@ -643,10 +644,16 @@ enum env_location env_get_location(enum env_operation op, int prio)
>>>         case MMC1_BOOT:
>>>         case MMC2_BOOT:
>>>         case MMC3_BOOT:
>>> -               env_loc =  ENVL_MMC;
>>> +               if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
>>> +                       env_loc =  ENVL_MMC;
>>>                 break;
>>>         default:
>>> -               env_loc = ENVL_NOWHERE;
>>> +               if (IS_ENABLED(CONFIG_ENV_IS_NOWHERE))
>>> +                       env_loc = ENVL_NOWHERE;
>>> +               else if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
>>> +                       env_loc = ENVL_SPI_FLASH;
>>> +               else if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
>>> +                       env_loc = ENVL_MMC;
>>>                 break;
>>>         }
>>>
>>> With this patch, I believe Peng's concerns are addressed, and it also
>>> works for our use case.
>>>
>>> What do you think?
>>
>> On first glance, this looks good to me. If possible, can you please also
>> send a patch for i.MX93 (arch/arm/mach-imx/imx9/soc.c) to align the
>> behavior of both platforms?
>>
>> Thanks!
>>
> 
> Hi João,
> 
> This does resolve an issue I encountered as well on the imx95 while
> booting via USB2 SDP.
> 
> Can you submit a formal patch?

I think the patch you are looking for has already been sent:
https://patchwork.ozlabs.org/project/uboot/patch/20250811-v2-fix-imx9-usb-boot-v2-1-3d89974e2881@toradex.com/

