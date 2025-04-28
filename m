Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E59C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 06:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E22F3820B7;
	Mon, 28 Apr 2025 08:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="WbUPS3wx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C9C6820F6; Mon, 28 Apr 2025 08:00:28 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B5DC80BAD
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 08:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThvHoBSOElF9YoS9b3i9xaWA8FSktpWXBFd3oE/HzKzb0xaHHQgnhvcY7LnGYm+GgH53c6387ouYPX9gWSplVAqGARJlsfcel2qoS0JBFEmtz7JLziuiiBFyeyZvdet7lNsJNKewX7+h6W5TwDUslC2STAssAuyzM19y8z3Tj75XiWQEc/L2Lr9gUu61AOY8C9vjydbVeF+WZ6CoDYpx7nfIx6zO/sEHGR2Wf/PEqGRLGlGYYazkcr1ltUFgFK58U7O3vKWvdQY9gTXArx7QvWd0D3XCJfs9Jo1gP6FjIxJ7N0043ORW3iTkkErVi6TvBEqgpMTOyOO35lPRdQMqjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A34Q2DlOc2ek9bFx/ssBCz8WEsCvU7ZYYurCeKSu1c8=;
 b=n86Bk1nQ+1lh5cdODjgX+rv09Naf7e2+X73yuxWpyTRC6aUPokJO4kr8TYHK1bNmwWyZ+i1f3w8szjC9FMpVEWx+z+kO8LHCTVHZtowDdQcFioVohGM6dWnQOvvxSlf5W1rPsLQ+L9myXEUlCL6l2SYd7zibm0FG5ddpHN6xxRuMrbDP4L+CL3rIgB7a2o4sF6L6ykdXrtTO80kYYL0zZkeqfdNnRTeHteNXYbc1F9e3m0Pp/DKF7tIsb9WVG+5Dt3VILfLa8RWhDZeBS8kWuPqCKnI4fXs/B+HTpw5hxk4zNWnthvXnBU1iiWZhHVC3I9+gDykIhcwMiYUBuykN3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=amarulasolutions.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=topic.nl; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A34Q2DlOc2ek9bFx/ssBCz8WEsCvU7ZYYurCeKSu1c8=;
 b=WbUPS3wx/hgQQuDBONKsY+lmUsMhsmCV0vFyMxvcetwFkFIbZYvl+KQZa7SE0BCS74GvlfIhIkf4yauCIBoWrrJ48pPY9n0scoxR9QqITZJe3bQme6wdBZOkJc72lBxj5uf7SMRzr1Pl2rGs7RQmlFA388qMwFQuo7rg4RyPSkZd1e0FEn80Kk6BjWJufFFraLcegKj/XkFozJFQyqxRUrXdvZI1LH+PNY6VNuzts2umZ6aitD9Pk77uD7Wf+QXz26wsO25Tng04HqRZq1YDh9FN9PsOoiTG8IeQITp1hADnmEkIQDMjA0Qwq/LVPiPC0+fL3FwRbmIs2udQaeSntA==
Received: from CWLP123CA0065.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:59::29)
 by DU0PR04MB9493.eurprd04.prod.outlook.com (2603:10a6:10:350::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Mon, 28 Apr
 2025 06:00:22 +0000
Received: from AMS1EPF00000042.eurprd04.prod.outlook.com
 (2603:10a6:401:59:cafe::7e) by CWLP123CA0065.outlook.office365.com
 (2603:10a6:401:59::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Mon,
 28 Apr 2025 06:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AMS1EPF00000042.mail.protection.outlook.com (10.167.16.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 06:00:21 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.105)
 by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server
 (TLS12) via SMTP; Mon, 28 Apr 2025 06:00:20 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AM9PR04MB7684.eurprd04.prod.outlook.com (2603:10a6:20b:287::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 06:00:17 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 06:00:17 +0000
Message-ID: <d9841017-26d4-4ed1-9c01-1424724c9b83@topic.nl>
Date: Mon, 28 Apr 2025 08:00:16 +0200
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v2] mtd: mtdpart: Support MTDPART_SIZ_FULL in
 fixed-partitions
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: u-boot@lists.denx.de, Alexey Romanov <avromanov@salutedevices.com>,
 Tom Rini <trini@konsulko.com>, William Zhang <william.zhang@broadcom.com>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.bc83124b-b53b-4cfa-9911-d8ca2185a06f@emailsignatures365.codetwo.com>
 <20250408054642.6843-1-mike.looijmans@topic.nl>
 <CAOf5uwmy2kRw=cF0v_K+nhR+rKVQE6C9dZFv71CcGZCXuhb85Q@mail.gmail.com>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <CAOf5uwmy2kRw=cF0v_K+nhR+rKVQE6C9dZFv71CcGZCXuhb85Q@mail.gmail.com>
X-ClientProxiedBy: AM0PR04CA0142.eurprd04.prod.outlook.com
 (2603:10a6:208:55::47) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|AM9PR04MB7684:EE_|AMS1EPF00000042:EE_|DU0PR04MB9493:EE_
X-MS-Office365-Filtering-Correlation-Id: ef36bb43-a0f4-45b6-6684-08dd8619f61b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|13003099007|8096899003|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?+hHftsl7evpGqlbrwH08w3Tkoe0Nkdz5Xj8ou620GAgr7zSstxSQ02jpqEPq?=
 =?us-ascii?Q?fjZiuKrBEzGLePP7CvlP50BeIAtsr1v2Thu3TxH8UccsJW2s/xJPqm3UC1Yw?=
 =?us-ascii?Q?Few6sxAlJDG1WT1fbgt3dHBVFTT57XZVnPrMRFu6uFGGOBU4eHZWNW46JHrS?=
 =?us-ascii?Q?YAHfhUp4OOQ6eRMq9s1OHKuyu0gwc5BtK0pwkKOkpgdwe3p9K3sAbLOSt7AP?=
 =?us-ascii?Q?vszfXC6b5HrNHGHgSyfTkf4R1xufJAxXsuvno1dmHMAks/kWLmMMteBI7q+R?=
 =?us-ascii?Q?TdMliMFP33NvEB7LXP89CmfpyfFc9zwBpeGhRLnkC87YgYfdyoluPBHjKMyl?=
 =?us-ascii?Q?uOOqn+O5JnlCUzXWpIFlo6M034zeLJW85sWFb1tLp4RUZIuvjpThMEZOsN6f?=
 =?us-ascii?Q?kb5g2U3KLBn1cds+0zLCPHL7gDDotnciAukaoC9qrA9pLrxUlrvwADUWQ2Tc?=
 =?us-ascii?Q?28m7vRtsoL839VPBUMzNF1KHDHP+DTDHObHbp9RO6TqWstgFya58sDEh8j9a?=
 =?us-ascii?Q?fxjS88QQ6HKbnUfJH86rY2zYN35/gcCXjM3maiiFKZyyeVYqydmWCtbNTcFt?=
 =?us-ascii?Q?zVlyog3NQJNJgFbPHTRhcc2eRyiIFXycg0lPgsVpSBszE6exCOimzEbTjgeB?=
 =?us-ascii?Q?eC2UuNk4cgoxIJ5m6roQ0B+P+daLhw4g0/+PIlQIDIPb44LTpLQqJtWD63R3?=
 =?us-ascii?Q?TD4/s77fO9wGAch4XBCWG3PFsytMF21HabLW9akzibEU2KkyzyMp9XX6zrXf?=
 =?us-ascii?Q?m55sxcu8+G+Q/+sZbrLoyymGvcIa43gRDxRa3ugaiORauZanMwV/UpV3ASBi?=
 =?us-ascii?Q?F2AZ6QrMhjG0kY3xWPnC0WtUn293h+ZBTlQ+vIWwcJL3iqTKomfGf1hsiPB1?=
 =?us-ascii?Q?VXQxy+72QxQaLg2vkKwKBuYD6wf3g1tPeHhflgJIUh/yVvenhbbtB1PsA2+J?=
 =?us-ascii?Q?7/CTw7qwi21J3l4KbusLZF3SGjvcRoGHrXArMRgGFGuR026D/xihUmqPv9om?=
 =?us-ascii?Q?4j0QJFnVf8v5n1hTrY25B/Cu/+FyBwr0IkT8gFbNCuH3n/vl96dHTDJL/MKE?=
 =?us-ascii?Q?GS1LfqkTT70tJd9SHdkpctdnTI6R9LjdnmupQoC1MRadeZVxGjVRrsifh7eE?=
 =?us-ascii?Q?sh0VmSszJRyWoP3OzTWkRK8Bt6wARcuvn/sYJdiBZ+fmYMdOqSPYYw/Ek3N2?=
 =?us-ascii?Q?n3TJao4oZvHKwZxfbKszv/7iNbpZ/9o75jSlkW0H1Ei51xyg6f7znzVbZCU/?=
 =?us-ascii?Q?/1dScc/gCXq5+2X37/LuxGBRPzTH9wdcX5rfnblesNEQBvhRvM5iqyF1t87Z?=
 =?us-ascii?Q?uvI/ufKKX27awu6lLG3HCz2XgYLLUzO+e4dS/woXVEBFyQqK65TTOeRf2jKv?=
 =?us-ascii?Q?HvT6o8eBsdc+yi04l/2SCzfonEd/V0mAdR8BUA79bV3wuAv/LDy4hqLVTmPE?=
 =?us-ascii?Q?NLhB7bpCzsw=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(13003099007)(8096899003)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7684
X-CodeTwo-MessageID: afbf8b57-4c01-49df-a1dc-e9f75ec4b69b.20250428060020@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 71111390-f908-4421-34ed-08dd8619f37a
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|1800799024|376014|14060799003|36860700013|82310400026|8096899003|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHhFanJtM2RTSjRhVkV0ajZMT28vQ05UbG5mY1V2dVp5clk4OVhITWRXbVN6?=
 =?utf-8?B?S0ZuaVdRSVBsUUZQMkVrSWdhbUM2bW9GbVU4MTdxckNSNDdSck5aSWlvOGda?=
 =?utf-8?B?emFacU5wbTdlOVc3NUxXbnJLNmg0cnZMa1BGU1g1QzdqdjdnaGtGU0JVa1JH?=
 =?utf-8?B?ZmFuSTYrV1ZzNlo5ZjE2T21WNy9vVGpaQnVNVE1HWEY1aWY5K3oyUzFSSWVz?=
 =?utf-8?B?SWY2RzUwb0hmWk1tRk84cmwwVDZFdnpSSEc3cWU0N3d2VmlLc2ZkeTUwUmdR?=
 =?utf-8?B?b21IVDdjczFKVWdkUjlKei84MUNBdEFRS2ZoV2NySGFobndpS3VXNXcxdDNa?=
 =?utf-8?B?T0xIMFlrR2E0U2RlOFhNcnRKZnA5TDc1TTVvMnM2M0RmSlAzVlh3ZkszK2hq?=
 =?utf-8?B?ckpxK0dDRXgxK3BQdnRCbEY5UDhsQVBsOGtWZzJPYU0zM29jVk9BZHdFanZi?=
 =?utf-8?B?WFJGWVBGWjhRYmZ4aEVDZzRNa1BMYjg5Q0sxYzdYMTIwOE1jU3ArWnJldDVW?=
 =?utf-8?B?K00yTGFYR0czWURnZVNJNHRMcXN0aDRyTVd0WnNkcDVHb1dETFQ4YXc4NkJT?=
 =?utf-8?B?K205TUZheWt1RlBwQ1M5cFpwS2YzeDhmVjg3L1dIZTdPaExFMjBjYW5TdENV?=
 =?utf-8?B?M2JhbFFPaHNUbWNPcWF6YzdpdEROWThpZjNURk9oTW9pV1JNQWh1RHVyczln?=
 =?utf-8?B?WnZMR1lTYXJ0dGNGK2c2bUdPcVdXVE8zVDAvTEQvNzVVUjBvT1ZpYlRPcUZk?=
 =?utf-8?B?ZzZXZHdYaWpXTkJ1TngwanY4QVBkUTBsSDM3bVNZSks1RnYzazFRU1p5aGpz?=
 =?utf-8?B?S2c2WEZZUm5zc0pvVUNONG9pdnduNzBBczRBaWE0OVJtR0VnZFBpTjhZYUZq?=
 =?utf-8?B?MnNEeVZ5aldwMlZxQXI2VXNUQ1l6UTBrSks3SHg2RkpOU2RLWEgxSVlmWEF1?=
 =?utf-8?B?ZlY5cElLTDh2dXhEa01IbnF5V1VCTEFNaXBpNUtWSjlvTWhoTWorb3JUanFq?=
 =?utf-8?B?VDNXYVNVTk9Oa1B1SWZuZnp2dTFRODRQeklVTnhBUjAzY1c1Tm4yd3YrWFlE?=
 =?utf-8?B?T25ST2dQeTlLTWl6NlVid0krV0FtSE0wb2JhU1o2KzMwbHlpcjk2eGFGZERv?=
 =?utf-8?B?Z0dVbzBZbTVkeFprYkt6VEdLa0swSFlIeXRIckY3V3k2aGRRcWVsNjNic20z?=
 =?utf-8?B?ckpwdHVtREt2WERKa0RBSkdyVmgySTMzTzAyeFJqdG5MUkpYYm16ZEpPckhk?=
 =?utf-8?B?SEwwMjNNL0kzcFVSM1JqVXVORDhKK1hId2ZlVTNPK09ia2ZOSGV1N05zRlVJ?=
 =?utf-8?B?Tml3NFZtV3I2Z3c3NFNPeHN5NUJuQWpqYWFUZlVUNGNyNzlaMTRJcEpHSURh?=
 =?utf-8?B?dGFzREw0WE1jVEJiRzg5OU5VMEg1Z2tPcmEveDF3S1hLNkNQNGxUdm5nL2w5?=
 =?utf-8?B?Q1pRbFgwaWtlY0dxZ0YrYlE0Z0NzM0VlSFlKaEZCWnJDUVE0NDVZR0Y2cTFn?=
 =?utf-8?B?Nk14VUlueVlLSUJLb1JqV3d0NUl6NUN4eEJTNllEa2ZZOUtDS2tqUTBnV0NU?=
 =?utf-8?B?M1V4SjFucTZwUW5nVzh0OG5qemFLcTdQUlIvSmZPL1ZlN241WDkvMHlMRzdw?=
 =?utf-8?B?NGZ6RDhHWndRNldWNzIyNHhtSUhScDFIWjh6eUk5azRTbmZlVjVSRFA2alZw?=
 =?utf-8?B?VUlOeFR0dlFwNWcxRHd2Wks3eWJvWThORm5jQm5qeFJUMkNQR3BTT2RIM3Rl?=
 =?utf-8?B?akQ3VldaSFJFWFR5WXFKa3FMajZZdk5SOE1kbWczN2l6dGcyYm5WM2prV2Fs?=
 =?utf-8?B?KzN1WXJyYkF2OFozc1V1Z3RhN3h6cEYzYmlqdUk3czhtV3NsUkhla2djZEdn?=
 =?utf-8?B?MFVVVXB5S1UzWm8ySm82NzJMOS9mL3dheW1uMjg4aGFPZVRKdk1ueTUzQnBY?=
 =?utf-8?B?ZTA4SzFlTXpmb2VucmROODYybTc4Y3ZXS1pORndDam5Hd2pMb1lHZy9VOHI2?=
 =?utf-8?B?Y3NZTDY2OFVnPT0=?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(35042699022)(1800799024)(376014)(14060799003)(36860700013)(82310400026)(8096899003)(13003099007)(7053199007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 06:00:21.7304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef36bb43-a0f4-45b6-6684-08dd8619f61b
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9493
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Gentle ping, anything blocking this?


On 08-04-2025 12:31, Michael Nazzareno Trimarchi wrote:
Hi

On Tue, Apr 8, 2025 at 7:46=E2=80=AFAM Mike Looijmans <mike.looijmans@topic=
.nl<mailto:mike.looijmans@topic.nl>> wrote:
Flash partitions may specify MTDPART_SIZ_FULL (=3D0) as the size of the
partition to indicate "the remainder of the flash". Make this work with
device-tree "fixed-partitions" as well.

This makes MTD partitioning compatible with the Linux kernel, see:
  https://github.com/torvalds/linux/blob/master/include/linux/mtd/partition=
s.h#L29
  https://github.com/torvalds/linux/blob/master/drivers/mtd/mtdpart.c#L123

Previously, this could only be done through MTDPARTS so this change allows
boards like topic_miami to migrate from `mtdparts`/`mtdids` to devicetree
partitions.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl<mailto:mike.looijman=
s@topic.nl>>
---

Changes in v2:
Amend commit text to add links to Linux code and explain the rationale

 drivers/mtd/mtdpart.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 88094b81e7a..5284890bd88 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -910,11 +910,13 @@ int add_mtd_partitions_of(struct mtd_info *master)
                        continue;

                offset =3D ofnode_get_addr_size_index_notrans(child, 0, &si=
ze);
-               if (offset =3D=3D FDT_ADDR_T_NONE || !size) {
-                       debug("Missing partition offset/size on \"%s\" part=
ition\n",
+               if (offset =3D=3D FDT_ADDR_T_NONE) {
+                       debug("Missing partition offset on \"%s\" partition=
\n",
                              master->name);
                        continue;
                }
+               if (size =3D=3D MTDPART_SIZ_FULL)
+                       size =3D master->size - offset;

                part.name<http://part.name> =3D ofnode_read_string(child, "=
label");
                if (!part.name<http://part.name>)
--
2.43.0



Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com<mailto:michael=
@amarulasolutions.com>>

Met vriendelijke groet / kind regards,

Mike Looijmans
System Expert


TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl<mailto:mike.looijmans@topic.nl>
W: www.topic.nl<http://www.topic.nl>

Please consider the environment before printing this e-mail


--
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com<mailto:michael@amarulasolutions.com>
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com<mailto:info@amarulasolutions.com>
www.amarulasolutions.com<http://www.amarulasolutions.com>


--
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl<mailto:mike.looijmans@topic.nl>
W: www.topic.nl<http://www.topic.nl>


