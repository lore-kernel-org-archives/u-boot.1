Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BFCC369A6
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 02:46:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CABC83A3D;
	Fri, 11 Apr 2025 04:46:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="C+6CCfU+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F61782EA3; Fri, 11 Apr 2025 04:46:15 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AF4382EA3
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 04:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcA/If3H8V4AEEn9aaWi/NWIh0Ou9Wd2dVyvvD0wDaOLr7jE49vwiGL5+ODjQHnmMOEp5Y2Gihfv1kn2Uya6EX8fHP4zh5E4nafSkp54eYdPcmtoabB/XoBECRnDvvbuGnpaw3Xc42fIc8mBcJzl8aVnXLTfwlvgNTOEmEq3G47+ZUUyucRsgDgrJn0asmL4eRFVnJCDd/+RULGIMscmTv3TUNW/7Z0ZPFff/pvWvh1wuMeEdDgB8UTgktbfYS3MlgPriMOVemrNnXYwOacD4Pfsdh5u7xstI8zD1J8pX0cKfYhusQ/yMHP+tjN/uqDJgEifP8uVaXTXppyB9Ox7AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpxEEbMabEXXZfuGePlzanWnxIJf2ADd11FlJouISbE=;
 b=V8GTuziZsuylVxMV0+CWCkDpa7W8mfv2WnqjJcxwI1Sh9upi5zXnmL1FFIS5a85JDJZ2zr419SuBlbJas7NFNG3Ql8JaYtV2/NVsUx/jpMBkaqQLoeLyFx81drAi3+nJa3fmNPPlIObiM1lLLWkFgRsDjGhio56CUy8tA0Rifgb0f6ufHQjGPn5syJviEuNO6iNI2vObGu1qJQcq8S4/kawTV5Lg3niNAPZfvp2UpFchpmg5fok/OicQDsWgSWido4oWq8ZmarQ7/lI3OK3vyiIK/iG3xAxT+lcXsBq3wffUf6Rl7AjnhmKiV5S5qa1zo+LMEI2zcfwF0L5AP1ZO0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpxEEbMabEXXZfuGePlzanWnxIJf2ADd11FlJouISbE=;
 b=C+6CCfU+31UDLo6yy9QfRZlznOaYi/EKBihUB5mXCv0NIPXD4oP/XnBOustKxcyfp85so7y9b/T3kkGZMd/7zqXpLRvVGOSybpXpG876EGjM+qpXi/T7rbTve00yElsO5S4ysvMG+CN0OVHEQAl1ZuV/Lthh3Tf0uA94w/m9akWGkG4v99c2H8p/VDx6KDpUW91IJdrMxe4JNeqKewC10u2q+cVJYwiac9HSHRhRQ8gke1FM8XRvpIQjHUBGG7xat/p1PaSLY7mcvcvdicMOYCsRi6J4ilsvwCQgMBTM+SwSZXTtpTk+m2vS6vCg6jBQYl8b9Jf0vlQUGWVdg5kugQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7798.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 02:46:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 02:46:11 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Peng Fan <peng.fan@nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH] mmc: Exit from mmc_init() if mmc_complete_init() fails
Date: Fri, 11 Apr 2025 11:54:17 +0800
Message-Id: <174434362342.24440.8371404286457398025.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250118032832.32865-1-marek.vasut+renesas@mailbox.org>
References: <20250118032832.32865-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b7a8a5-b08c-4b6f-b239-08dd78a304dd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHU2eEpmVFVrWER4ZHpTQ3poUmlyWVBNM0tZVmo3em1BQVZrTXZzNGdCV0lW?=
 =?utf-8?B?S3Z5NkMzTGtmS0JmTStLMlNaVi85YUtpSDFGcDB1ZERKOWtUTDFWNFlGcnhk?=
 =?utf-8?B?Z3Bod1M5SmJuNWpySnR3K0JSb0tCVFdmRlRyRXdITVRORUVPeS9QQ0l1MzRm?=
 =?utf-8?B?ditIMktvVDUrNzg5MUZuSXJ0S0xteDJiU3pSTnVSZG12ZFJ3RDJaWUhvNzkr?=
 =?utf-8?B?R1NMR2UxbUtsUFp6anVRYWt4Q1A4MER5VEtLVEZWTTlVbWZtK2xqSkxaNG5t?=
 =?utf-8?B?UnF0QWtocmRFTkpJM01PdXpCTy9jeHV4OC9Nd2NLeGJ3TlREZVJQcU9XaHNT?=
 =?utf-8?B?ZVdocDQyOGdpQlV1OS96VnV0OVU2OTk1emd5UzhxdndoN1JoUFBTOHM1RFFV?=
 =?utf-8?B?c2VwbzNUZ285L0NpQlBncjVkQ2k1c1JhcWsrYXQ1Y0lqc0U2SnFNK1ZSS01x?=
 =?utf-8?B?c2NPcmFhL2UwRC9TTTM2VmtOSGN3MVZXTkhodXRQVVBFUTVYVU9yeHR0eXpV?=
 =?utf-8?B?bUF2azNyeWNZZjRBeFpKMWUrYjRLbGJ1d2NFNUNUMXhubmVBWk1JTDZrSU9v?=
 =?utf-8?B?eFd5UWxOcmRjNGlrcGxralF1cHBwcEZOcHlsOU1UWWt0MStEUGl2MUVmRzRD?=
 =?utf-8?B?ODd3Y0c3TytYeUM4WHpBUmtmaGpKRXBzckNpNnFVWVkxb3Z0dng5dlpsTW9x?=
 =?utf-8?B?QkJBcTB3bytPQ0dUM0hPVDFXT2FmZHowREpLSTNKNzJnS1BIUFI4NXdldzNt?=
 =?utf-8?B?ZWorSXZVSGw1dEZieDdnVUJEeG02TkhaWEJZVEVZWHo2T2k1bnZuRUM1VDZZ?=
 =?utf-8?B?Z0twL015WWREY1dmbWFveWs5bTZTcHhGcDdpS1BpRExRQjN4ZmRjWWpkcjZj?=
 =?utf-8?B?a3YwSnhoMS85ZEk3Z2hCUmZ4elFYLzJTKzd2ZVpQWXlVbm9GSFpMdFp4aXdY?=
 =?utf-8?B?T0VrcDVVS0t5TUxJR0FlNWdJRldGSEs4ZHFuQXR0bjRoYTlGSGlyMG1yakVC?=
 =?utf-8?B?S21nd3VUKzZHMlhXZ2JJb3oxanlxOXlKeXJYUVVzeEJkUjFsYk5jVUxpVTJ0?=
 =?utf-8?B?aEVTVWhUMHBiYkVGeXEzeTdKOEM3YkJKRERoOFg0L0U1U0ZCaG05ck85ZmpE?=
 =?utf-8?B?M05ZdzNuWlpZVVM2ajBrNE1zY2FpKzVDNDd4eW11VGRmNVRWODVDSkdJeFd6?=
 =?utf-8?B?eU1iOVNqcVlZQVlibm8wTzczQXk2cTNpN25yeDhHV2xLc0VRN0k3cjl2RW9C?=
 =?utf-8?B?UFpiYXI1T2J3bHBFOHUxenNpVTk5dmYveGJNbFBOOVg2UkF2bE1TZEl6L1hv?=
 =?utf-8?B?TllGYk9rbHVwYWRKbnF3QktKN2xlOUd3d0VCL3JsQVdRODZ6bjBzNW1UeWlY?=
 =?utf-8?B?dkc3cjBtTjhyWEFZbEFrb3d3QUt2YzVQM1FxbEdNZDVnY0RwT3FIR2YzdVll?=
 =?utf-8?B?ekZlWWhzaXFaQ1h3OGJ1YlJsZ2J3SVpha1JzaFFqN0w2Q3JpaW1icVlYN3k5?=
 =?utf-8?B?MWpiRDRSWFFuVHNQYWx4cmhzZHBVVFlkTENjSzliTm9IUGF1K1FWTjdFOGVh?=
 =?utf-8?B?Q1d2OG5qYW1FaXFaK2JXbmFjVi9EVWZyN0hMYUJtM0lDVGIxdFlST2ZyVm9L?=
 =?utf-8?B?dC8rKzZXcllqZHVPVFJxblBGWUVhNEw4cEROWWIzbjBHa3pUN3ZLZEFGd0Zt?=
 =?utf-8?B?Q2xoYVU2aG1VR0NwZUVmcEY5QzRtbU0yQStWamU2UHdCRnVzVWtVZ3NGd1Vr?=
 =?utf-8?B?S3dQMVZobXFiUE1PSkJjc0RGa0FPTjR6Y1A1K21RQWVVN1E5WHJpZ3B0WWJs?=
 =?utf-8?B?VWJod1AwZjBzVjlZam45S2R0OWVTMGFSblJBcEdQZnlqUlVGM0pSbFJiTVg4?=
 =?utf-8?B?VU8zcmpZRERyTzVUUEd3Wk13eENLYThicTlQejVCcDVRWjB2enpOb0IzTkFm?=
 =?utf-8?B?OXNOU1pHY1BvcTVLRVp3Q1N1MU0wK2FOZWJTb2RJblAvVkNBK25uUFdWdFlY?=
 =?utf-8?B?SE9iSzdmL0FBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFpvNEpaWDVzckE5VnlBdjl2QzJqK0I5cEhlN2trMWg0Z3FmUTcrQ0gvNE5v?=
 =?utf-8?B?WTNFRktXeGRkTlZtK0o4UGd2NVV2aXZhYzNtdjV2N1ZLYnRPK2Q3QWEzd1Rr?=
 =?utf-8?B?Q09jWkVkeE9LVnc2cmx1aWVjSUpEVkdyRjJWcUNCa0tlRzZrWXBkTFZ3Qmpl?=
 =?utf-8?B?SExDTEVNdGI3WE8zTFVIeDhqVy9jNkNBYy92TEZJNWI2VHdaQnhaRS9xdEhT?=
 =?utf-8?B?NEtVUGoxMSs3TGpJVlRVejNSdU5QeTYzZ3pKNkJ3ZnVBS1R5RGtGeUd1ZzFL?=
 =?utf-8?B?UDdmRmZ6ajhYaTFITGNITG55K1JHcVhzVkNCN3c0cjRSeGlRYk9SeHlld2tE?=
 =?utf-8?B?OURZMGhhdkxQR1MwWUVsaElodXBYVDdIRDNZdGxzNExYY1FSOU9sVy9uMlNq?=
 =?utf-8?B?Sm5YNEdFaGxCRFRSVEJyTjI3MWFGNFh2NWJQYlhFeFZ1a05MaG40bXl0UFVn?=
 =?utf-8?B?VmRGdWJsOHh6VkJ0V0RySXVNbjRjWDFkOUdDVXlRRFVVSjQ1MlMzdFc4M0FW?=
 =?utf-8?B?VDlZSUFhZE1DZXRYNmg2ODJBUkFpODcwODJsQ2YxdSsyWVp0ZHhwQitTTEd6?=
 =?utf-8?B?RENST0lBbmpyM1NJeUswK0VhREN4RUZOTnJ0RlVmbVNTZWNNK2VkblErMFEz?=
 =?utf-8?B?VzB6YnVSaTVLU1ZIblNBZUMrNGJOMVZ4UGE3RDVPTmZtVytpNjlxOXc5djgw?=
 =?utf-8?B?cHZwY1lJUXMyZ1RjVGZDd2JtdXBIRVhaRXF4ME54WVNYUGR1RXhJS1FCVHBH?=
 =?utf-8?B?dkJRcXRHOEltaFVBNldYK3VEL2tJeWI1a3pHM2ZwZENrWmtoWDRsdXcxc1N3?=
 =?utf-8?B?QXJLVTBhTGRidUV3aHlmcUI0djJuVEhpanZMMGp5NWF3N3kzaGtBYWlMK3ls?=
 =?utf-8?B?RUFzQUhQRmpweFY1cEtvY0w0TFJGa3hLbkhnNzNkWExnOXZ3WnRIL2ZWQjVI?=
 =?utf-8?B?RWxwanFYUkJITXRkUytOK1g3Z0hIK2NudVhJTEowc05FTzJTOGhadmdtaDVX?=
 =?utf-8?B?UzA1dkd5TlZ2aXhGUThNa1VOcnREd3BWV1FNWk1FRElMaVgzT3JBQ0w1aFVR?=
 =?utf-8?B?ZnJDM2NjRzlFa3VlWndndnEyRDhWYllreHhxUzNwNHFmSnN5L0luT2szSFZl?=
 =?utf-8?B?S1NJeEkwK2tXUDlZM1dUSlQvb1A3ZzJzUlJWZFozY3k2QnplK2x2cE1oVWhi?=
 =?utf-8?B?aHdKeGxKdnZnbGRibWVKU2hGV1pwREM2UmdHVTRoVFRTOFltUG5xNHp3bUht?=
 =?utf-8?B?UllHc1M5aGZ6NjlqYjhFWmNxYkUyWUNnd1l3NVhlYVRJWk5ualBaMUt5aHY1?=
 =?utf-8?B?SmpXVEhnTEN5N0tXeTJ4TFViSDhDWGplRVAvZHp0STloWlJES2lVWnZwOGRL?=
 =?utf-8?B?YXU4MllkV29SbGhQNzdaV3NVTUNvUVYycGVQa1ZROUhzMjBZV0dzNC9OVzRF?=
 =?utf-8?B?Sy9CVUZCNHVjV1Jnam9tdnozMlI0YTF3SXNXS2FiQzA3Z1VoMzdCSWp3WDQx?=
 =?utf-8?B?Q3hjM0tEbjR0TFhoMmFNb1JiMkxRdlp1NGFGL3dWOXlJYUtpazBreTZJRUVr?=
 =?utf-8?B?Rkk4dk1kazg2enhLU3p3WXVmQTBzUFhWSDZrNVRTdkU2SGtqVG9PZG9NNUs2?=
 =?utf-8?B?c0o3b2VtTVpKaU5xMGVJK0ZQT1ppem50c3V3MnBLUzNqT200ZzRhUFhYTEMx?=
 =?utf-8?B?WHYyYU1NY0UrcGU2R3NlQ2RleVFwYmZrbEQ0bEozNEo0aW4rK29rQVBEaXNt?=
 =?utf-8?B?VklRVzBKUnlCZGF3TjdlbUJ6dE96UU5MOWJlejN5NUw4TGx0bmtUVHRscU9V?=
 =?utf-8?B?UGtHWGtnbVI1aGVBL3FuZ05xQUgxWmphcDE4THVkYW0yNUxGalN4R2FURXpo?=
 =?utf-8?B?ZjNQOXhzbDZUMUQxeENuL0tuVk9UdElqYW1uV2hmUUowd0RKM2drdlRLTGpY?=
 =?utf-8?B?czZ2TmlGRjMwL2Y5OCtuMlFDLytWVldPcVRmWGJGSWpxcWhVbmZId2xLMW9a?=
 =?utf-8?B?eDQ3Tmc5RTlJWVNJWStBa1Mzc2wwa3VrUzJhTnZUM1A4SHVNay9FcUdrbXY0?=
 =?utf-8?B?Mjg5b1FadVpjcU9IdDVRZFh4M1ZhdWF3dkxzK3lML2F2SWMrWldKcWpmRVlh?=
 =?utf-8?Q?9UepuMrlVt/f/clAgSk6Radmf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b7a8a5-b08c-4b6f-b239-08dd78a304dd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 02:46:11.6853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lL5JyD4hDJeGc+rjpenZj26YwpYUmK4OFb7MG8AKzMoi3yThS12VrPByWOfpMSZtmZ9BrPvO9Px+4zJbhMT75g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7798
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

From: Peng Fan <peng.fan@nxp.com>


On Sat, 18 Jan 2025 04:27:34 +0100, Marek Vasut wrote:
> In case mmc_complete_init() returns error, exit from mmc_init()
> without possibly calling cyclic_register(), which at that point
> would be undesired.
> 
> 

Applied, thanks!

[1/1] mmc: Exit from mmc_init() if mmc_complete_init() fails
      commit: fcef00c284f8b0884aa26dba6edc8495a1d49d75

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
