Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039E4C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 07:53:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB7C780FB8;
	Fri, 31 Jul 2026 07:53:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j4fWhTdVv8ws; Fri, 31 Jul 2026 07:53:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CCAF880F75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785484416;
	bh=zv/Fmjc+sdvbH7qh9q5yGPJ4L3UvMrRPx0lE3ee6ngg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FJnVamgQwt1kJc6Q2BXuhCW1rG7PSQSSIYYHZsgCQxkn5FA8PDCL8XLRLEUhlDROT
	 4/mkLPJI+jfcCqTeQsYt5NDLT5nA9dUy4Yg+2MbzYuH9YliBqYfF+RADgsv2V+UzNi
	 YiU6XIf9aufruW13qNrsWML0tAwjAg2URHg6k3M8b2OxItnvpsq4Mei+Hxfh88OlzC
	 Y/SPBBQlBgeoPQzfSyrth5P8Bwu58PxHfRKEygrm8d+f90if5S298PkuhBxEH9HhUV
	 qPVLvAMXjfTlSzGuQIUETmsCTIQzUIVZzSN6pX/LVlZy4N6wZq3GUIYWPS7x9XJ3DG
	 yBlCzz3i68XZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCAF880F75;
	Fri, 31 Jul 2026 07:53:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C53869
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 07:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7EF6E40F34
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 07:53:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u381EQLaysD0 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 07:53:33 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5A04540F2D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A04540F2D
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A04540F2D
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 07:53:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rh9B3vh83Gk49VbOYr9SomOwfPfFMCgmWtQj7jJt5a/GuoXWpQDQbtQWjYGLTM4/0NNKARll6rnmGw8UMrkKeOJBg42eCu/pG/3GbwFKxa5iMMnAb4f7Vlsj0ntLGJAwcwxFig9miz4vh4Y9VyIDNYrlpceptBHqKIXbgr0yRV97+3bmd/iaRncCOhT5nf1DGTr36PKu/vBTVPuhSQ1R/x547lR37JqBQ60pwiLY+wUuSzFqsPCW2/hICytJ/+9aPIL4stkLng4LbiNrzoyPV+HgJNmtLrErL7SR69alSxdyLzZP65rqHGyV+bOBmNJnVUc16b2Iu2/5jUE0+K9FEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zv/Fmjc+sdvbH7qh9q5yGPJ4L3UvMrRPx0lE3ee6ngg=;
 b=xa/7WCgoT20aWBHZ3cgxBst5uFt+re7RBefO9r7Y6uLS23I9RDAzJ+D5g3l1fkRWyAlyHjylgvgCdhq+CJorx5YYi0BUOIHAGJCuNGIg7a4exbWFn6ndQ+J5PDVV8FZYjpHw3n/cxFpopU/dBtkYoswPZTyMkzP3zFoPx+eL8T48bGtAmwmRP3M+Li/RCwCdp2y6F/FrTT7CtHNqO8gm/mypDaNhuhQk9i0Vjp9xmU6tIu6Br09wKcDHD0hgBfn9WksKkgmvX7Injuv+SBSiOmlxnCbUgYcR9inDKMQ51IRIL84XQhImOj27EQ/QrwT5n28VZ57AlsdOpVDKKhBztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by VI0PR04MB11954.eurprd04.prod.outlook.com (2603:10a6:800:31f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 07:53:30 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 07:53:30 +0000
From: alice.guo@oss.nxp.com
Date: Fri, 31 Jul 2026 15:56:50 +0800
Subject: [PATCH v1 2/4] imx93: clock: add 450MHz DDR PLL rate
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-93w1-v1-2-62d8459143e1@nxp.com>
References: <20260731-93w1-v1-0-62d8459143e1@nxp.com>
In-Reply-To: <20260731-93w1-v1-0-62d8459143e1@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Johan Jonker <jbx6244@gmail.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|VI0PR04MB11954:EE_
X-MS-Office365-Filtering-Correlation-Id: 524ca5cd-fb0c-448a-0256-08deeed8ce55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|19092799006|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: u6Ldruh2fhwCeG/eYtI+WolcCIEqiJHDIQFRIE4ChUV3JlJMP4QqCNEv34M++ch/iJAqPg7Q1daPlTrGGzoiFB5h0VD63hzrdXdysQe/IvwKwFFjQDNxCPQ3HEmqKqGlJMcQfq+skQgF7bB9pyeb5EY5eQoY+n0Kfb4Cm1Na7YCNYh0JcRKKKnzWy0+XQLHL0Htcur5Yl9tLtsgXjweE5GxH4g+xAyPSd/LwdWLSL1cG/0Gl6BjwVYJFXSoZHGngM/Tan8ViBgdjBQ7RdW5QTijSAjRhFgfQIbVR5vbEd9VTvkl2aj9a9JMmhV8pI6cUlvW6vL+HFRDsJ2pvdEg7ZNcCGiwuQN47kuq1e8uQ5XN7aVjaVifvp+G4rKQbS+aV5qDvuCTJGJHAPmk3Sqv0OeAvgLOK71HDzJRREh5HQup/DzrOAkffxwHMpn9erPnBE7aCtyOGOZyHsmd7GkqxdQ7hMQO+IBzeLkqNdxOjE13qTyYOPQyyRFaVUROgQ/dY1I43bJj6kqJgQL63Lym5ExCKdaqSpQ31gB6J+XaklsZXtP6JoV8pic1jVeCGEob36CVpxM/7fy5W6fF+5LVupcb4Va2vspp7jtLVMDN40Eo6bE0cGQlDh+amwesMlNTqr9Amv+FWVeMMFMXq25M1cCexflk37wXaO7FYoOFWf68=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(19092799006)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEN6NFAvRm1pZ2QzUkpKTFJLcy9ORFJBdGgzVnNVQkRYNmhNTWJ3ejdjSlZX?=
 =?utf-8?B?SlhXNmRsS093MTNGazFqTGFKT2VTekxtNnBqNUhrZ0xNc2tzNU9IU3Rib0xE?=
 =?utf-8?B?aEdLY3ZKaS9OTUxKWnNnL3psTmJZb1ZIR3JrZXBYd3BNK0xrdmYzUHFnNzVa?=
 =?utf-8?B?LzZyZ1IzL085eUUyeURTMnhpcm8yYlVoUld0cW55SWhCQlk2MlNtTGQ2MU1T?=
 =?utf-8?B?ZXVZMjlFY3FTZnhYYmVvcWYvMjZJdm9sdTgxYzUvZzJ1VFhKaFNxRW5XYmpB?=
 =?utf-8?B?VDBnbFhuaFY3ZEhHOVNwOGNPdmZEM2Y4Q1E2VWpvY3lZZllJR3BBVUpVWDZE?=
 =?utf-8?B?TnRBQlk5QUVHb0Zzc1krMXBqZWVubEZuQUc4NGtkNElGSHlwd2t2L2VuZmRI?=
 =?utf-8?B?RmUrNVpZMjRwVitUUzB4SGdqQkNZWlM0czRuN1BRK01aNDR1d1FpSldYTXVj?=
 =?utf-8?B?V3hXL1lhK2N0U1BIU3BjY1VCQm5XUjNXYWhZK2I1eVNRMityS2tKOCtCYnNF?=
 =?utf-8?B?cEFCenZESitzc2VralAxVWl0Mm5lWmdkZ253dGlnRFdPNUVKTERodTFraGIv?=
 =?utf-8?B?My90eWNtY2NhK0JZVVdOU1BTQUlLdSsyWXE0cTk0bnNhMmFhckJudTRGbW9x?=
 =?utf-8?B?UC9Payt4NHZoem9sWSt4Ty94TlBvQVc0MnA1ZllGc3dFS0RveUJweVJkZXlw?=
 =?utf-8?B?OHI5TVd0Qkh5SjdCdmxKSVJnajZvSU1HbER6U1lUVkYvWFBsT3lmdFdCaXdL?=
 =?utf-8?B?TjEzSzhkd0t5R01nbExJZ3EwaFEvVEIwZFdjWmp5TUZWaWpUVDAzdWRyeEF3?=
 =?utf-8?B?ZndEZTlUVklFOUVRNWtMSmQyZlBIZ1lEYXVlUVlDNEQwZVhoSnBJc2tUQXRp?=
 =?utf-8?B?OSthV3RpR2U2L0lxcWx5MzRhUEhYa1l2QVBQeFFicDdMQkUyYkMxeXdTZHBY?=
 =?utf-8?B?UTdzbnZlMXg1OHcvRmZZN05ldVkycitHdjFSL25RR1RxOG1ieDJjdWs0emk5?=
 =?utf-8?B?Zk1oOW8yZkpTMk0vMm1WZUoxb1puZFpOOVhuOU8vbm1wVEsxNDJ3VUdMcDYv?=
 =?utf-8?B?VHVsK2FaemlxRkpvM1NDM09CTFRvanlURmkzbWNlNytRSGxlbEM5RVJ0cWtL?=
 =?utf-8?B?azZDdjUxSUN3eHphNjZBdzVmWE10RjI1dzdwcGd4Q0hIRWRVRTY0NlQ4YzB2?=
 =?utf-8?B?UUZFNnkzM3hQL0lHSTlFVGc5VytQb05vRTU2VU9MUGZOdUNFN05PUi94elNh?=
 =?utf-8?B?bDVvbTFjMGc5eE1uZ0lKRlBjM0FjbEVzc3dCTkZXVFhTelFyZE5qYXNxWGdK?=
 =?utf-8?B?Q2xUNDhBSVZRci8wM2dHcUpwVitTZHN1R0lqdzYrajdzNVgvTnpDTStZTkZ3?=
 =?utf-8?B?L2ozUXExbVJhOUxaRUhQdXVhcndRdW84OVE0cVlvallHRFBGMkhGWEhWNVNM?=
 =?utf-8?B?WktLV3pwRXFiTWRGVTluSzJRd1pvOWo5NFFaOTFLMzlWc2RGU2cxODZKc1pW?=
 =?utf-8?B?UEc1azZIRGNHWEVLWEg1dzFhbkkrSE1QNm1waTlZcU52dSthcHdoTGNWSDlz?=
 =?utf-8?B?UE1kUVU5Qy95aUdONUdtc1o2V09uQTJEMGpLenRoUDRvcEhmV0JqZHdkeEYv?=
 =?utf-8?B?Nmhad2JpVVA5Q0RXMCtRWjJtbnBpYkVVRDNzYVZTZk11Y0E5RFZIQUtEWnRI?=
 =?utf-8?B?ZFcrdmgzWCtRdGk1YXY5dk5lVHBxWCtlQzZUZ3JvOVh4WG9yUmpnUStPckRK?=
 =?utf-8?B?L1h2cWxqZU1xTGFNMXpJenBjRjh6a2VZUElVQXdhUzZTeExiVElsSG4xZUpI?=
 =?utf-8?B?YllSU2FkbWN5UERDUW1QazZHdDIxNVZQWEswWmoySmpQRG9YeWtwRUYxeWpC?=
 =?utf-8?B?anhiZWJGWC9aYkVKak41Rlkwb1MwNWhKMXFQeC85dEJndjhMM3FQVm5peWJN?=
 =?utf-8?B?TTFBUXVSRVZvWTJIbDdKSm1OZmtFbVlpclVqYStqMmhpeEJYSTFQNkpqc21J?=
 =?utf-8?B?SDNyODA2UE5EWDU5S05lRHhvZm5pTCtZRk1NZ3hDVFlmTzAwdlpJRjRnNDN5?=
 =?utf-8?B?Wnp2eFAzTEJScStoMHI2UEM5ZUxBMjB5RlFGTGNFcUgydTlTMmVRMk51V0Nl?=
 =?utf-8?B?YjBoaGVobERzTUVCSzh4V0N2eFlGZm9LRENsWFFWMEpCVTJ2M2VSZnNMTVJS?=
 =?utf-8?B?azV3OVRKTmRnU3l5c2NvMWwwOVlWdkY1YU9HaE93M1pLNmd4dk5SZUt2R1A1?=
 =?utf-8?B?ZEFEcWoyNzV3UEE4MWhRb0s2eFgwYnBRVXhqa0ZlUzZhOU9SMHRpMUZrdklO?=
 =?utf-8?B?ellxdXpXZlRoa0tQYitWZnZHSXB1V3d5akFsVXB2T055WVlWdFR6eFJuK2dF?=
 =?utf-8?Q?y/YJckcZru+xNq6qHY9Nkzzmdglxt4LXDJVx1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524ca5cd-fb0c-448a-0256-08deeed8ce55
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:53:30.3296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhqJ1oxcbNl6plVkl6elME/j4BnIG82sJf2S/VnvTCLy9f0PZzOkx4vPitiEP8Hq6yA+Qpff0q2b0yrnWXXE37zpc2DoaSRdo/bTNmc4djrIEhszrpIiJJun9Xv8X9N7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11954
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zv/Fmjc+sdvbH7qh9q5yGPJ4L3UvMrRPx0lE3ee6ngg=;
 b=ZwpeJXJsAL9RhH39skAidRE98Kb7Q9HmHNBmUkwmD5F+hkihGytuYbpG5os1EdSGhnPfsoFweZ5NpDC0L4KxnYYrjYtYZvWn2zQRJsqXwLTO9zFZy/3edovzJruC5XrgzXiAe6mc2MTwJtOrs9CRwloT2NltbHNN7+oLXIgsMZBV5sLnlmxjFN8ON0dZIPWchCD2v/gqAqBkmNBYqUWG/+17K0jhopm3+0pMmWgTw6RBb8Bupai7AwVSvXxtS4bvkNGmRDeLtZv7xKeT/Z5QSUS1HJvMVR1d+nMW3l3MCtbaQo7PpAIfgHEJCOvxFlJrJjjZ9X2W1uPfrQGXiDKTDQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.nxp.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ZwpeJXJs
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Ye Li <ye.li@nxp.com>

During DDR PHY training, an intermediate 1800MTS data rate is also
exercised, which corresponds to a 450MHz DDR PLL frequency. Add this
rate to the DDR PLL table so the training sequence can program it.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/imx9/clock.c     | 1 +
 drivers/ddr/imx/phy/ddrphy_utils.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index 4b89ee3b2b4..cc0a7729d94 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -40,6 +40,7 @@ static struct imx_fracpll_rate_table imx9_fracpll_tbl[] = {
 	FRAC_PLL_RATE(484000000U, 1, 121, 6, 0, 1),
 	FRAC_PLL_RATE(445333333U, 1, 167, 9, 0, 1),
 	FRAC_PLL_RATE(466000000U, 1, 155, 8, 1, 3), /* 466Mhz */
+	FRAC_PLL_RATE(450000000U, 1, 150, 8, 0, 1), /* 450Mhz */
 	FRAC_PLL_RATE(400000000U, 1, 200, 12, 0, 1), /* 400Mhz */
 	FRAC_PLL_RATE(300000000U, 1, 150, 12, 0, 1),
 	FRAC_PLL_RATE(233000000U, 1, 174, 18, 3, 4), /* 233Mhz */
diff --git a/drivers/ddr/imx/phy/ddrphy_utils.c b/drivers/ddr/imx/phy/ddrphy_utils.c
index 8e350de8315..665d32284ec 100644
--- a/drivers/ddr/imx/phy/ddrphy_utils.c
+++ b/drivers/ddr/imx/phy/ddrphy_utils.c
@@ -140,6 +140,10 @@ void ddrphy_init_set_dfi_clk(unsigned int drate)
 		dram_pll_init(MHZ(466));
 		dram_disable_bypass();
 		break;
+	case 1800:
+		dram_pll_init(MHZ(450));
+		dram_disable_bypass();
+		break;
 	case 1600:
 		dram_pll_init(MHZ(400));
 		dram_disable_bypass();

-- 
2.34.1

