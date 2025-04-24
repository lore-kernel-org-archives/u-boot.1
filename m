Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E43AC369D7
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1BD88212B;
	Thu, 24 Apr 2025 08:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="yEqze7YI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62CA98214B; Thu, 24 Apr 2025 08:35:03 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 499858212B
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:35:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAPnRVEDnq+ZEgs1VgZwY3yi5UwSNxhctPkrhN2LA/XSZZHYphY+Tg9uvud37QLCzmsokQZv90u8CIRXXu/SHQIQwmvdheZ7YmIuR7eCittXLYzW3fH3b+GZ1oXksYenbRjEUqTW/a988LqzwQPXQ1GF4r3IB6bV7sHDY+OODIXouVS1EugB/hQxpqlqdRG1V7aQ6ajsq8iFPRhYmabJX8Mdmz37EgMaCTjx+cP3tNqQqL7QLxgm1GEvN42+z1lYNtcOBoy0YrUZG5Vsly0TJGGB4JNAymP55jn2YRsW3UK1nKT3uGgaEdTGuwOpRfg3A9W5PSRSq/hY/IbXSzhG0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKl8J0d5zTpvtomJ//rF2TLAfp0nZ4qBCJG0OxCcboA=;
 b=ZU/PlM7ULiJEUHs2qmLsMGIvCd2HcdXxmdDsUEINrPgKxdXzBaJPQx0fI9Fe9Qs1AsVnyanugMEh8/1p/F85hVLFDZH6ln9c4hH0HRE/1sT66NC6KUEQq5P2uHcoBWOqcSU3Ug6Mw9IGJyw1wr5PL+b1MjTtBOQu0GGzqe2HiTds7WYuIKLU5U1yz67gsCuTzqR7vos0ASwBoxneCs+8Ov63p/sH21g4Xtm6uT2wPOMc3+xHsVkHUsCJyrBdJZpcPrQ56M2wn1WYsLZyhJAhPcNicSjY3lsjw0Fm+gcYOUQ57KcsfzEsuNiFlBf64kS55Ugv4St9WN378i7RzthZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKl8J0d5zTpvtomJ//rF2TLAfp0nZ4qBCJG0OxCcboA=;
 b=yEqze7YIzCTIGyV+8RAaah1jWl8oTco3ZGHibwdqjQdZjx/6WogzMFklVFwNYOkBFUUDDWXRkjHNSJ5nwa5Cfy3sDVfAhKiGHrs2eW9JwMBbTahmXXhHc52VO32TdGjOWNdSx8RFH8lC99N1Cb6BrA6tx/2xzmKpSh+k6/X+be98DklsIq/u6QgvtjRB7s43Qdjyq4yyYmYKEGH9E3kqcbDUiCLH5Z9jIUy/x8QQUrq8JnE+UgLJFPX/VaIbYmhkei00iB8mlEpTjKQhpaa/5+yai6vfs4wXpwBki8QhPOcYlMPfffI/JtsHHK2ZqpxOEMHVqQXp67Eg4o8d8Me3gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10661.eurprd04.prod.outlook.com (2603:10a6:800:265::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 06:34:58 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:34:58 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Thu, 24 Apr 2025 14:33:13 +0800
Subject: [PATCH v10 17/21] tools: imx8image: add i.MX95 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-imx95-v1-17-10a8449b1e5e@oss.nxp.com>
References: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
In-Reply-To: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10661:EE_
X-MS-Office365-Filtering-Correlation-Id: 018ef0bc-6f09-4ec7-e74a-08dd82fa2244
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3ZrdTdrWE0zTmhPRVljUjFoMm1NRXltbzlQN0hURld5MHk0Z1dWdk1uaHFs?=
 =?utf-8?B?c01HL3FpK1h6U3JxVUV4L3M2Zk1vc2ZsaXI4TG1kRmVETmxWOHo5bW52aU5x?=
 =?utf-8?B?eTFMRzFTdG5ZVDgzcllQa3VkdmRTNEdhVnRkSHF3bUxUek1pODVCbTZiM1Yw?=
 =?utf-8?B?SjFTellFcERud0ltYWZaL1BqTzIwbU92Yi9Ic0Z0Y0ZRTnRmNzRyWmNyb3cw?=
 =?utf-8?B?SmFmQ3pPTTNkL2xDd1V0eVFaL09xRVZYLzhDTit2Q2w4SmlRREE0cmRLeWV3?=
 =?utf-8?B?dk9wNFNCWGZvdXN5VVB6VUFSZ0hRTGNScW1hTml6MVpPM2t2enlmcU9IdDNS?=
 =?utf-8?B?SjVvY2tSTXRJRWdDNS9NbFllUm44TEtlN2QxSVVIMFFwS0VybzZKazZNYjJG?=
 =?utf-8?B?YmtTZzc0K2JPQjdtdDJmekFjalorQVlKbGF5UVAwL0JreTk3b25VTEdRODhj?=
 =?utf-8?B?dldZWGlNUWFWamhNUzdvYldYKzQ1QUw3OEhQMGc2UFA5cEZnUldrVS9oUVZF?=
 =?utf-8?B?Nk56YWE2VGJZZmlwbGFDRGMyNTV5YXVGdzAyNXo3c25ITkhDS3lNMkMxdk8r?=
 =?utf-8?B?WXpuRHJBZG1Eeld5VmY0c1pRV1BpQnZObnh0Wk85UFo3RDFhQmY1K0hKSmVM?=
 =?utf-8?B?dXI0akVHSENuZERlQnk0aFJMODBsMGhrazFSMFZieDVBUm1zRU9FZzZ1dHla?=
 =?utf-8?B?Rmd6di9Rb1Zsd3hzSDlNZnNhT28yOHhTdHU0eHB0RHR5VDRoMUpaMCtyQmlE?=
 =?utf-8?B?Wjd5S0V4cFdicjZERVFZV01nZU82dUdxZXR1bDlybTFPalU1N25yMmFSbXU4?=
 =?utf-8?B?ODFVbnptWndodlVIcTl1L1lEcDVOeE1CbEVTcDgvWUNHUXZRRVZmOUZKUW9p?=
 =?utf-8?B?dGU5Qm1sNEJDRisrQ2FRRTFoKzJCL3psQ3MzQTBWVUpraVpLelJsUHI5RTV3?=
 =?utf-8?B?ZkNpUGlyc2NVWnlaSTkvaHFGdktVZnRBNnRTYkJRWFJBdHBIK0J3MjlKMkVl?=
 =?utf-8?B?MEhvUXNuekdWQ1BmN3EyY21aMVZEcFhBMXh1b2RualdXb2RQSS9jalFUMzda?=
 =?utf-8?B?aVdJZ2hUcW1LaFhLQ3Q0eTRsNXkva1V3bVhyeEpNVFF6ZGVTdENLT2xOeDJa?=
 =?utf-8?B?RS9IanFnb1lvamJLNG0wMHRwYWdhWDhTTFYwQ3V6clNnMm9DZGNPVktnYUZx?=
 =?utf-8?B?T3J5bmNFNktqOGZwQkJlZnN5QjNxb0htTUwwUFBFWmNVVVdZMmhxbDhMUmdx?=
 =?utf-8?B?YmVsNVpZMmh5ODNxK1FkMVFGSER6YmxQdmxIb3EwOFN0SkNoZVZTaXFlQlVn?=
 =?utf-8?B?Vkt2ZXVEc05mZ3FER2tQMTVhN0RTZlFkYURNdGs1bGo3REhraC9kZ3d6Y1Jm?=
 =?utf-8?B?LzZmbi9IMjJCM1BITDROaFhna09PMk5ZZkpBcDlVREU2TVY4NXdmMWpnTjZD?=
 =?utf-8?B?ZTNWdVdCTkp5OXROalFYeHZRMFFzL1lwWXRaR1YrRkwxb3U0Slo1TTJrcDBx?=
 =?utf-8?B?VVZjSGZyMisybmVUR1JnWHNveTJwNWs3MUtIaG5DeXlPSWVpZm4rYWVheUFu?=
 =?utf-8?B?aHMwdWloR0VOZWxLdWpnTGhnd0hJT2RTWkxsUjc1cDJlWlNOcEpwb1JzbDNq?=
 =?utf-8?B?c25OQlBRTWZsL1U3OTlkYVlFNlVEdjhNWm1va1A5dW1IeFJHcFdESjdGV1Ur?=
 =?utf-8?B?dGJINlpLdk0ySDdHN3dFL0c4Z1RYa3JkUlFja29RUGhObTk4WWM4WTRkMDZp?=
 =?utf-8?B?eE9YVUdLTU9LK3VHNVN3UDVGaVJ5UVlORVhveE9LalZKbGVQUWdRaklNc1gx?=
 =?utf-8?B?TVNpZ3VaWnlOVGxwWE5RWHo2RDRZd1dobU01MWNtTndkcVNIdHVyTVE3VlBI?=
 =?utf-8?B?V1hnM2tTZHNxdE95QUVMNWlVR3hQemVEeHhic1FIbmZQVjlSa2ZXM3J4Z2sz?=
 =?utf-8?B?d3VGUmkwVTJtUlZyblZjOFQzdk5uaWdweU5mVVRWVW5KeW5oNmh3WnNXZjVY?=
 =?utf-8?B?L081TXNrS1FBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R25EeDdHb2htM29reXgxQzYxdS9oU1VNU0lsbjRkWFhRMDhzMVFacyt1LzJC?=
 =?utf-8?B?a1VWbVRvdVdZWXpUQ1lIMDVxRmQxYk9UYTM0ODU3aTNTSUxNa3VJSjhmVHpV?=
 =?utf-8?B?S3JNS1Z5bHo3VjdBNnRhVlBqR3l6bldHRkhvU2cvRmVLWUVjdlhnaGRqUmpr?=
 =?utf-8?B?TGQ5OWxMZ0lGRWs1d2VvVm5aTXEvd05MSTQ4V2M4SkkxaWZwcnJ6cW1zY0Zp?=
 =?utf-8?B?MnJzcm1lZTR1aWlFS0lCU3RMSFY3RUZiQnhWYjhnSDVSSUw4VFpVUHBHSTQ5?=
 =?utf-8?B?M2l1b0RjK3dkQTcxVDhQcW5nRWZORzhkcU4yR01XZkdWMzdoN0ZrUm4ydXkr?=
 =?utf-8?B?T3kySGtYL2ppL3BMWDhkTEE4ODlwV0NwVEVxT09USFRzMnhPbDhTNGIwei9x?=
 =?utf-8?B?aDFzMndXVnJsQjY4NGlMMFZsdWVCY1NNbHFkZm5QZFYzTVk4VDdLSTNkdnRI?=
 =?utf-8?B?K3dldnJLUnA3cFo5TDkraXJpMVlSOC9zaDkvb0F6T2E0eFBMY0RCZ2lVMnlU?=
 =?utf-8?B?L21ZbVEzWFhMdHZzR2QzRUk3eXlsV3l1UTBoaHljcVErRURyMkxIZVlKY0dx?=
 =?utf-8?B?c1AvYTVPMDY4cEFyS3RUR0IwQ2k3RHZmZjJ2Z2ZINGtyOU1HUDM0aGRTRlk0?=
 =?utf-8?B?aUdrSjJGa1ZHd3pnQ0EwaHFROUtPNjUwaHJMRkd4N3pmKzNBR0FFOE9Vd3Jl?=
 =?utf-8?B?Nm9JUXNzdmZNa1NySlpOWG5OTzRwaWU1aXVKZDkzdDF6SFZRNW43bHlhSVV6?=
 =?utf-8?B?eXdoczZhWkpRWjF4bG1jUlBKeStSMkthV1AzM01ZTDdyWXRtUmNyREFLY1o0?=
 =?utf-8?B?dUNOT01paGpSNjg2Z3AwT0FyN3pTampRRnNYdGRlU0xlZFlwVnNDQkMyTzlN?=
 =?utf-8?B?YW9qb1REdUR1TGE1bWowTWFRYnlBSjczOFlrNmxMNEdoU0t6NGNLM3N2ODJP?=
 =?utf-8?B?Z1hkbEU4Mmh3dFhoL2IvT2pFK3gvNDgwalVESmZlVy9vakhyZi9FZS9HQjVE?=
 =?utf-8?B?OFhxYU9UN3UvK0ZGaktSWDlXcFpJVlNBbStxVHhuTmUvdGw1OTVROC95U3E2?=
 =?utf-8?B?bU5XM1ZheHR3RVRqV0VORjlTYmZrWTAxN2ZKM0ZzcC9LUThSVXVtc1QvNDN0?=
 =?utf-8?B?K3l5MGozS0x2ODJsTU1WSTIzcWluMWNiTEVPNFdlMlVLS2daQ1JuMkRzZlZ4?=
 =?utf-8?B?NlA2RFZwY2NGVHJPSXBOTzg4SjF0elJUS01QRmx1WkxrOTFwNlBraWxYV1E5?=
 =?utf-8?B?RS9na2x1T0NvMGhIc2F3dHA5cWxGS25ab1hFSXlFbUNPb0dyN2dZNC9tSFZI?=
 =?utf-8?B?RlN2dGtOWGdSMkREdXBwcTNIQXpxdjU2R1E3M3FNSzgvSzZBanh5dnNUSExS?=
 =?utf-8?B?M05naGphTEdySzFGNzZTZmNYekZzTU5iVGlTazQ3NG5iQUlZNXdPQm0xS3dy?=
 =?utf-8?B?VFdOdGxKOVpQbmVuelhPVi9tNDNFTXl1RERIUHg5SVJPTVYxSXEwR2owR25S?=
 =?utf-8?B?RTVFcGQ5VWhSQkV3ZmRIVjNlMXhOcXRLeFRWaDAvOGZqTzloaXlWOS9WYTE2?=
 =?utf-8?B?YXVsTTE0SXZPaEt5U1JabjhMSDk1UFI0a2pxYkJRZXpLY0g2c3BGMlI5c3V4?=
 =?utf-8?B?TDcyQzc3bnhVY25GVlpWVXJ1bDZ4WWp0cnZFOURQaTRobldRa1N6WFNGeHl0?=
 =?utf-8?B?WWZuM3ZEN0gzQ0VKa1pSZDNxeG9FdGJzeDFQRmhLMzlCMlNEcWNrdWhVNStJ?=
 =?utf-8?B?bWZCWW80WlN2VFVoSElhbEtsdk5SMkUwQmNCRFkrZFNnTVBPek8wTm5reW9s?=
 =?utf-8?B?ZUFDcUQ3ZU9vYjNQYU9UeUx1QTFSR0JtUnVCRnE1TjRQaGI4b1BYcnpFc2J6?=
 =?utf-8?B?b3ByR1U1Nm92UTI2dUhPOHJpSlZ4a1NSVmV5d0EvVjk0eGJCUWl0S01yMjk3?=
 =?utf-8?B?SkVKczdmMFV4RUJkdCtDc2U2eEhHV3U2QWVNeVJwTnZuUHRWV0E2Z2lKSmJz?=
 =?utf-8?B?WFp1S0hSMkpFaWRUYWlCZEZDS1JlT05sR3F1dURZTU5ueHlGdHQyYTY0U0gr?=
 =?utf-8?B?OERkTGdQTXQyQkNaQWtEWE91bjcvTDBKSkQ5Snp5LzVUcHhGT0QvZk5CSlRa?=
 =?utf-8?Q?tDav0MSz/h/7d7GIUCRjhsG8R?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018ef0bc-6f09-4ec7-e74a-08dd82fa2244
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:34:58.6582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ksBklH/FOWljEvz+zMIerqnwJAHkYBVR31928mtt2K8lpGXiaS/aw5RSgXn7I00r8Kd8WyL+rMHwhs4RoXidUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10661
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

From: Alice Guo <alice.guo@nxp.com>

i.MX95 uses binman to invoke mkimage to create image container. 2 image
containers are needed currently. The first one is composed of
ahab-container.img, LPDDR firmware images, OEI images, System Manager
image and u-boot-spl.bin. The second one is consisted of ARM Trusted
firmware and u-boot.bin.

Because DDR OEI image and LPDDR firmware images have to be packaged
together and named as m33-oei-ddrfw.bin by binman, so imx9_image.sh does
not check if m33-oei-ddrfw.bin exists.

When using "make imx95_19x19_evk_defconfig; make", imx9_image.sh will
delete the line for u-boot.bin in container.cfg. In fact, binman is
always called after the u-boot.bin is built, so imx9_image.sh does not
check if u-boot.bin exists.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 include/imx8image.h |  19 +++++--
 tools/imx8image.c   | 147 ++++++++++++++++++++++++++++++++++++++++++++++------
 tools/imx9_image.sh |   8 +++
 3 files changed, 155 insertions(+), 19 deletions(-)

diff --git a/include/imx8image.h b/include/imx8image.h
index 6b95e93fb50..e0d25c5b6c9 100644
--- a/include/imx8image.h
+++ b/include/imx8image.h
@@ -157,7 +157,9 @@ enum imx8image_cmd {
 	CMD_SOC_TYPE,
 	CMD_CONTAINER,
 	CMD_IMAGE,
-	CMD_DATA
+	CMD_DATA,
+	CMD_DUMMY_V2X,
+	CMD_HOLD,
 };
 
 enum imx8image_core_type {
@@ -169,7 +171,9 @@ enum imx8image_core_type {
 	CFG_A35,
 	CFG_A55,
 	CFG_A53,
-	CFG_A72
+	CFG_A72,
+	CFG_M33,
+	CFG_OEI,
 };
 
 enum imx8image_fld_types {
@@ -208,7 +212,10 @@ typedef enum option_type {
 	FILEOFF,
 	MSG_BLOCK,
 	SENTINEL,
-	UPOWER
+	UPOWER,
+	OEI,
+	DUMMY_V2X,
+	HOLD,
 } option_type_t;
 
 typedef struct {
@@ -227,12 +234,16 @@ typedef struct {
 #define CORE_CA35       4
 #define CORE_CA72       5
 #define CORE_SECO       6
+#define CORE_M33        7
 
 #define CORE_ULP_CM33		0x1
 #define CORE_ULP_CA35		0x2
 #define CORE_ULP_UPOWER 	0x4
 #define CORE_ULP_SENTINEL 	0x6
 
+#define CORE_IMX95_M33P		0
+#define CORE_IMX95_A55C0	2
+
 #define SC_R_OTP	357U
 #define SC_R_DEBUG	354U
 #define SC_R_ROM_0	236U
@@ -246,10 +257,12 @@ typedef struct {
 #define IMG_TYPE_EXEC    0x03   /* Executable image type */
 #define IMG_TYPE_DATA    0x04   /* Data image type */
 #define IMG_TYPE_DCD_DDR 0x05   /* DCD/DDR image type */
+#define IMG_TYPE_OEI     0x05   /* Optional Executable image type */
 #define IMG_TYPE_SECO    0x06   /* SECO image type */
 #define IMG_TYPE_SENTINEL 0x06	/* SENTINEL image type */
 #define IMG_TYPE_PROV    0x07   /* Provisioning image type */
 #define IMG_TYPE_DEK     0x08   /* DEK validation type */
+#define IMG_TYPE_V2X_DUMMY 0x0E /* V2X Dummy image */
 
 #define IMG_TYPE_SHIFT   0
 #define IMG_TYPE_MASK    0x1f
diff --git a/tools/imx8image.c b/tools/imx8image.c
index 0135b190951..a333ded46e2 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -7,6 +7,7 @@
 
 #include "imx8image.h"
 #include <image.h>
+#include <linux/sizes.h>
 
 static int p_idx;
 static int sector_size;
@@ -54,7 +55,9 @@ static table_entry_t imx8image_cmds[] = {
 	{CMD_CONTAINER,         "CONTAINER",            "new container",      },
 	{CMD_IMAGE,             "IMAGE",                "new image",          },
 	{CMD_DATA,              "DATA",                 "new data",           },
-	{-1,                    "",                     "",	              },
+	{CMD_DUMMY_V2X,         "DUMMY_V2X",            "v2x",                },
+	{CMD_HOLD,              "HOLD",                 "hold",               },
+	{-1,                    "",                     "",	              }
 };
 
 static table_entry_t imx8image_core_entries[] = {
@@ -66,7 +69,9 @@ static table_entry_t imx8image_core_entries[] = {
 	{CFG_A55,	"A55",			"A55 core",	},
 	{CFG_A53,	"A53",			"A53 core",	},
 	{CFG_A72,	"A72",			"A72 core",	},
-	{-1,		"",			"",		},
+	{CFG_OEI,	"OEI",			"OEI", },
+	{CFG_M33,	"M33",			"M33 core", },
+	{-1,		"",			"",		}
 };
 
 static table_entry_t imx8image_sector_size[] = {
@@ -144,6 +149,14 @@ static void parse_cfg_cmd(image_t *param_stack, int32_t cmd, char *token,
 			exit(EXIT_FAILURE);
 		}
 		break;
+	case CMD_DUMMY_V2X:
+		param_stack[p_idx].option = DUMMY_V2X;
+		param_stack[p_idx++].entry = (uint32_t)strtoll(token, NULL, 0);
+		break;
+	case CMD_HOLD:
+		param_stack[p_idx].option = HOLD;
+		param_stack[p_idx].entry = (uint32_t)strtoll(token, NULL, 0);
+		param_stack[p_idx++].filename = NULL;
 	default:
 		break;
 	}
@@ -221,6 +234,16 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 				(*cmd == CMD_DATA) ? DATA : AP;
 			param_stack[p_idx].filename = token;
 			break;
+		case CFG_OEI:
+			param_stack[p_idx].option = OEI;
+			param_stack[p_idx].filename = token;
+			param_stack[p_idx].ext = CORE_CM4_0;
+			break;
+		case CFG_M33:
+			param_stack[p_idx].option = M40;
+			param_stack[p_idx].ext = 0;
+			param_stack[p_idx].filename = token;
+			break;
 		}
 		break;
 	case CFG_LOAD_ADDR:
@@ -238,9 +261,15 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 		case CFG_A53:
 		case CFG_A55:
 		case CFG_A72:
+		case CFG_M33:
 			param_stack[p_idx++].entry =
 				(uint32_t)strtoll(token, NULL, 0);
 			break;
+		case CFG_OEI:
+			param_stack[p_idx].dst = (uint32_t)strtoll(token, NULL, 0);
+			param_stack[p_idx].entry = param_stack[p_idx].dst + 1;
+			p_idx++;
+			break;
 		}
 	default:
 		break;
@@ -549,6 +578,7 @@ static void set_image_array_entry(flash_header_v3_t *container,
 				  char *tmp_filename, bool dcd_skip)
 {
 	uint64_t entry = image_stack->entry;
+	uint64_t dst = image_stack->dst;
 	uint64_t core = image_stack->ext;
 	uint32_t meta;
 	char *tmp_name = "";
@@ -558,7 +588,9 @@ static void set_image_array_entry(flash_header_v3_t *container,
 	img->offset = offset;  /* Is re-adjusted later */
 	img->size = size;
 
-	set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
+	if (type != DUMMY_V2X) {
+		set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
+	}
 
 	switch (type) {
 	case SECO:
@@ -580,6 +612,27 @@ static void set_image_array_entry(flash_header_v3_t *container,
 		img->dst = 0xe4000000; /* S400 IRAM base */
 		img->entry = 0xe4000000;
 		break;
+	case OEI:
+		if (soc != IMX9) {
+			fprintf(stderr, "Error: invalid core id: %" PRIi64 "\n", core);
+			exit(EXIT_FAILURE);
+		}
+
+		img->hab_flags |= IMG_TYPE_OEI;
+		if (core == CORE_CM4_0) {
+			img->hab_flags |= CORE_ULP_CM33 << BOOT_IMG_FLAGS_CORE_SHIFT;
+			meta = CORE_IMX95_M33P;
+
+		} else {
+			img->hab_flags |= CORE_ULP_CA35 << BOOT_IMG_FLAGS_CORE_SHIFT;
+			meta = CORE_IMX95_A55C0;
+		}
+		tmp_name = "OEI";
+		img->dst = (dst ? dst : entry);
+		img->entry = entry;
+		img->meta = meta;
+		custom_partition = 0;
+		break;
 	case AP:
 		if (soc == QX && core == CORE_CA35) {
 			meta = IMAGE_A35_DEFAULT_META(custom_partition);
@@ -587,8 +640,10 @@ static void set_image_array_entry(flash_header_v3_t *container,
 			meta = IMAGE_A53_DEFAULT_META(custom_partition);
 		} else if (soc == QM && core == CORE_CA72) {
 			meta = IMAGE_A72_DEFAULT_META(custom_partition);
-		} else if (((soc == ULP) || (soc == IMX9)) && core == CORE_CA35) {
+		} else if ((soc == ULP) && core == CORE_CA35) {
 			meta = 0;
+		} else if ((soc == IMX9) && core == CORE_CA35) {
+			meta = CORE_IMX95_A55C0;
 		} else {
 			fprintf(stderr,
 				"Error: invalid AP core id: %" PRIu64 "\n",
@@ -687,6 +742,15 @@ static void set_image_array_entry(flash_header_v3_t *container,
 			img->entry = 0x28300200;
 		}
 		break;
+	case DUMMY_V2X:
+		img->hab_flags |= IMG_TYPE_V2X_DUMMY;
+		img->hab_flags |= CORE_SC << BOOT_IMG_FLAGS_CORE_SHIFT;
+		tmp_name = "V2X Dummy";
+		set_image_hash(img, "/dev/null", IMAGE_HASH_ALGO_DEFAULT);
+		img->dst = entry;
+		img->entry = entry;
+		img->size = 0; /* dummy image has no size */
+		break;
 	default:
 		fprintf(stderr, "unrecognized image type (%d)\n", type);
 		exit(EXIT_FAILURE);
@@ -709,15 +773,26 @@ void set_container(flash_header_v3_t *container,  uint16_t sw_version,
 	fprintf(stdout, "container flags: 0x%x\n", container->flags);
 }
 
-static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
+static int get_container_image_start_pos(image_t *image_stack, uint32_t align, uint32_t *v2x)
 {
 	image_t *img_sp = image_stack;
 	/*8K total container header*/
 	int file_off = CONTAINER_IMAGE_ARRAY_START_OFFSET;
 	FILE *fd = NULL;
-	flash_header_v3_t header;
+	flash_header_v3_t *header;
+	flash_header_v3_t *header2;
+	void *p;
 	int ret;
 
+	p = calloc(1, SZ_4K);
+	if (!p) {
+		fprintf(stderr, "Fail to alloc 4K memory\n");
+		exit(EXIT_FAILURE);
+	}
+
+	header = p;
+	header2 = p + FIRST_CONTAINER_HEADER_LENGTH;
+
 	while (img_sp->option != NO_IMG) {
 		if (img_sp->option == APPEND) {
 			fd = fopen(img_sp->filename, "r");
@@ -726,7 +801,7 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 				exit(EXIT_FAILURE);
 			}
 
-			ret = fread(&header, sizeof(header), 1, fd);
+			ret = fread(header, SZ_4K, 1, fd);
 			if (ret != 1) {
 				printf("Failure Read header %d\n", ret);
 				exit(EXIT_FAILURE);
@@ -734,19 +809,27 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 
 			fclose(fd);
 
-			if (header.tag != IVT_HEADER_TAG_B0) {
-				fprintf(stderr, "header tag mismatched file %s\n", img_sp->filename);
+			if (header->tag != IVT_HEADER_TAG_B0) {
+				fprintf(stderr, "header tag mismatched \n");
 				exit(EXIT_FAILURE);
 			} else {
-				file_off +=
-					header.img[header.num_images - 1].size;
-				file_off = ALIGN(file_off, align);
+				if (header2->tag != IVT_HEADER_TAG_B0) {
+					file_off += header->img[header->num_images - 1].size;
+					file_off = ALIGN(file_off, align);
+				} else {
+					file_off = header2->img[header2->num_images - 1].offset + FIRST_CONTAINER_HEADER_LENGTH;
+					file_off += header2->img[header2->num_images - 1].size;
+					file_off = ALIGN(file_off, align);
+					fprintf(stderr, "Has 2nd container %x\n", file_off);
+					*v2x = true;
+				}
 			}
 		}
 
 		img_sp++;
 	}
 
+	free(p);
 	return file_off;
 }
 
@@ -838,6 +921,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	char *tmp_filename = NULL;
 	uint32_t size = 0;
 	uint32_t file_padding = 0;
+	uint32_t v2x = false;
 	int ret;
 
 	int container = -1;
@@ -861,7 +945,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	set_imx_hdr_v3(&imx_header, 0);
 	set_imx_hdr_v3(&imx_header, 1);
 
-	file_off = get_container_image_start_pos(image_stack, sector_size);
+	file_off = get_container_image_start_pos(image_stack, sector_size, &v2x);
 	fprintf(stdout, "container image offset (aligned):%x\n", file_off);
 
 	/* step through image stack and generate the header */
@@ -870,6 +954,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	/* stop once we reach null terminator */
 	while (img_sp->option != NO_IMG) {
 		switch (img_sp->option) {
+		case OEI:
 		case AP:
 		case M40:
 		case M41:
@@ -892,6 +977,30 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 			file_off += ALIGN(sbuf.st_size, sector_size);
 			break;
 
+		case DUMMY_V2X:
+			if (container < 0) {
+				fprintf(stderr, "No container found\n");
+				exit(EXIT_FAILURE);
+			}
+			tmp_filename = "dummy";
+			set_image_array_entry(&imx_header.fhdr[container],
+						soc,
+						img_sp,
+						file_off,
+						0,
+						tmp_filename,
+						dcd_skip);
+			img_sp->src = file_off;
+			break;
+
+		case HOLD:
+			if (container < 0) {
+				fprintf(stderr, "No container found\n");
+				exit(EXIT_FAILURE);
+			}
+			file_off += ALIGN(img_sp->entry, sector_size);
+			break;
+
 		case SECO:
 		case SENTINEL:
 			if (container < 0) {
@@ -963,11 +1072,15 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	do {
 		if (img_sp->option == APPEND) {
 			copy_file(ofd, img_sp->filename, 0, 0);
-			file_padding += FIRST_CONTAINER_HEADER_LENGTH;
+			if (v2x)
+				file_padding += FIRST_CONTAINER_HEADER_LENGTH * 2;
+			else
+				file_padding += FIRST_CONTAINER_HEADER_LENGTH;
 		}
 		img_sp++;
 	} while (img_sp->option != NO_IMG);
 
+	fprintf(stderr, "%s: %x %d\n", __func__, file_padding, v2x);
 	/* Add padding or skip appended container */
 	ret = lseek(ofd, file_padding, SEEK_SET);
 	if (ret < 0) {
@@ -980,6 +1093,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		/* Note: Image offset are not contained in the image */
 		tmp = flatten_container_header(&imx_header, container + 1,
 					       &size, file_padding);
+		fprintf(stderr, "error writing image hdr %x\n", size);
 		/* Write image header */
 		if (write(ofd, tmp, size) != size) {
 			fprintf(stderr, "error writing image hdr\n");
@@ -1000,7 +1114,8 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		    img_sp->option == AP || img_sp->option == DATA ||
 		    img_sp->option == SCD || img_sp->option == SCFW ||
 		    img_sp->option == SECO || img_sp->option == MSG_BLOCK ||
-		    img_sp->option == UPOWER || img_sp->option == SENTINEL) {
+		    img_sp->option == UPOWER || img_sp->option == SENTINEL ||
+		    img_sp->option == OEI) {
 			copy_file_aligned(ofd, img_sp->filename, img_sp->src,
 					  sector_size);
 		}
@@ -1031,7 +1146,7 @@ int imx8image_copy_image(int outfd, struct image_tool_params *mparams)
 	fprintf(stdout, "CONTAINER SW VERSION:\t0x%04x\n", sw_version);
 
 	build_container(soc, sector_size, emmc_fastboot,
-			img_sp, dcd_skip, fuse_version, sw_version, outfd);
+			img_sp, false, fuse_version, sw_version, outfd);
 
 	return 0;
 }
diff --git a/tools/imx9_image.sh b/tools/imx9_image.sh
index ca78a57a19a..6523d1a0ad1 100755
--- a/tools/imx9_image.sh
+++ b/tools/imx9_image.sh
@@ -18,6 +18,14 @@ for f in $blobs; do
 		continue
 	fi
 
+	if [ $f = "m33-oei-ddrfw.bin" ]; then
+		continue
+	fi
+
+	if [ $f = "u-boot.bin" ]; then
+		continue
+	fi
+
 	if [ ! -f $tmp ]; then
 		echo "WARNING '$tmp' not found, resulting binary may be not-functional" >&2
 

-- 
2.43.0

