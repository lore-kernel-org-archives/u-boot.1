Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F60C02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 18:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C51F5805A1;
	Tue,  4 Feb 2025 19:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="R7uE6ErC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 912A9805E2; Tue,  4 Feb 2025 19:02:16 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4701D80562
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 19:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOHjW9IICTmxouP32lm2ac5RcWB2WnpanTtMxZIDnTviNZQ28gfv4JIWbuN8ld6VzyqW7Zu9sDvdxLevGKHYdcs+imLUqw4coN4MDb20k8Y7e1mdgqov74lJbyOrGSFoNr0LiKv7OZHhfD7zfDcQ7Pd59Ityes4VtHjr2b2RvxK1fB3b4UqCYBmlqD0ZlFRI428f0+WwCVrQXo88KzQ8BSHdM+eoQPzH7Z0gKQL9S3FEnPWmYMWi4blHXzmhBQ5uNpa1dzGy3KuBQP1EusVMQYPMo0irok/6XZ4RnthTK0OvhOaKLBJcIaDW1vQtN7i8YT23yOPb3iKMmuR6DVBwxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zWTaBJHOr8nsCwEqZ3915Mmh1+y5NVT2/9ACizgNec=;
 b=umKp+WVIAU7DMBmL36jHyC9rwdUI5G+bxWHUEqxVDd0JAVfmEYKKG4CRL8pVFtpij2j43pKfwl06iJ7Op2jsSYcThE9XZMs8Dqjo9aVtK6HANX3+KOpzOTRGN2b8/P9hBdlydUlpDhZX68uOQeRlYLHzwNWO06MJsb/ybord0iH542HwdkbMj/0jLWT4g+s6nVZPdHv76TqQtuCuvfesjgpT8Rg8RTIS94YSkoblx2Q2YEmEcH3xoqkYAHtTVhqppP0NmMGsY07TpLGM8pWTLVAFYqrsWgfZjwpez9pBhBOEpFTBuOYCNCRVqMnCZCNAx7jdw868jnbuFZ0R+MSyvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zWTaBJHOr8nsCwEqZ3915Mmh1+y5NVT2/9ACizgNec=;
 b=R7uE6ErC1TXybhjb3gartAQo8H4yTOzZl2wWWBxIbp3Ava1M8Wip7ZQZlaBRCmDXz75nBYZvbjCHjKWvz9rm9DBW1eZe+Bc8tI1+/mFKlqD/1VFaSZx4uwXoSeTop+wqmx5XPkoNkVEIVRT3+2SmPodnA0aBoD0D8h6Ed9qcFKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAWPR04MB9986.eurprd04.prod.outlook.com (2603:10a6:102:380::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Tue, 4 Feb
 2025 18:02:12 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 18:02:12 +0000
Message-ID: <1f90d52f-3c18-4475-b608-60fc06ea5dfc@cherry.de>
Date: Tue, 4 Feb 2025 19:02:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: Enable OF_LIBFDT_OVERLAY by default
To: wens@kernel.org
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20250204172151.3361714-1-wens@kernel.org>
 <87c853a6-2eed-4bcf-a32b-021966d10f71@cherry.de>
 <CAGb2v64EPgW8A4TK3GZ4_7UQ=YMU8kOPZyneMZBzkpdvb5cXkw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAGb2v64EPgW8A4TK3GZ4_7UQ=YMU8kOPZyneMZBzkpdvb5cXkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAWPR04MB9986:EE_
X-MS-Office365-Filtering-Correlation-Id: de76b9c1-dec4-4719-c084-08dd45460cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUZ3bi9QQWhqbGI0Q1ZDaFROcjhiR0lPK2huV3dhY2NoVzVsRUVuVVlxdk9r?=
 =?utf-8?B?c1ZnWVNDME0zMEZERkNCSW1sMysvc1ZGeElkTEdtMlo3WXovS1Y2TlZ6Tk1G?=
 =?utf-8?B?UmJ6Uk5sMFhiRmRjcEZXUHY4RDI0bUcybC81WFIyeGZUWWhjSzI3Z3gvMEdG?=
 =?utf-8?B?RDNkZ3V2dlV2T09wY1VhdER4QklrQy96N0g0bU9YZVl0OUFDUUYrby9PTVBu?=
 =?utf-8?B?dCt5VlNvZHo1Ti9xbEtxZitlVkxWS2V5alRWRGlVWTVDdnQxaFdEZkxtNlNH?=
 =?utf-8?B?Z3QyNUEyYllVRlI1Q1FyT1EwL1p1VVRWbDM1SHlqS051R3ZXUGloaDRrcHAr?=
 =?utf-8?B?U1kyQTBDbmM5bWpPMXQrNk5lTTVNbG9JODJIUG50VWtlVVFxblI4YVFxOU5w?=
 =?utf-8?B?L3lhQllhTHN2TENNaDJvSzRlNWNnSjQrT0d6d3ZaaVdlbXJEcXNtdnBIOE9t?=
 =?utf-8?B?M01ycytsTDRVRmZVblRPeUpmM2lMeStjTnFDVEc2TXRHS3VrcnlKK3R0ZzE0?=
 =?utf-8?B?ZVg4L3dieG1PMW5Xa0REc3p0WTRqQ2xGQTloUThkMk9ic2FibTRMVVB3dWZW?=
 =?utf-8?B?eGlBbVNQdVdXY3dXcHh3aTZodGNSWERvUDJLbnI0VFhlRHZOWGFSNVhSaGFy?=
 =?utf-8?B?N3VCMU9xaVRNTk5mb29GSEZvQVNSS09uWlpCelZEa2dNWXlBMlFtQVJSSkhh?=
 =?utf-8?B?N0s4aENVcTZMZ0Q2RmhmVkFaYzE2TjluUkZHNXFVdERUYVNOSXhkMk0vTmh2?=
 =?utf-8?B?a1B4MC9MeEdBU2FTZUxZR2M2aU9hUFdlalh6Z3JuNHhjc0JFb2h0MUgwdDhr?=
 =?utf-8?B?RXRjMzBtSEROM1kzeDJiZ1RQb1V2STFqQW9oMzV2dHMyT1FGMWc0SmNaSnJs?=
 =?utf-8?B?Y2l5aGx6Qm9pekM5MGtvNGNhZXBSUFR6dWo2TCs0a2ZGeU9hU2Y4SEpiMy9B?=
 =?utf-8?B?RFpqMW00Q1cyV1NFOHBENWFSM2dINEF4dmMydnRDem1zbk13ZWxPa2RYSTk1?=
 =?utf-8?B?REROckg5aXFmdmh2V2VZZkorbjFlTklVbGxqWFZhVEpFUCs4ZW1ueStHK2Y0?=
 =?utf-8?B?M0lZdm1ieGxWZGlieE5ia3hPSFdZUlBpa0ZZQ0JEZzB3WkJGTE1xclRKV0Vt?=
 =?utf-8?B?d0lnaXhWUHVnUW5peTZQU2ZkQ2U5T0tSTW4xSzI5UTVNWTk1MktKS1E4S0k3?=
 =?utf-8?B?SU5VTUV1dk55TFFKR3FEYlJJSXdkWlhINzVGdWMyWlNkd1FTRTI0R0hjQzJY?=
 =?utf-8?B?ZkY0WFBFUVJOWEJjYjY3ZWFoL2QzZzNNWHVvdE1Nc29CSGp3U1dmNXNkUU1u?=
 =?utf-8?B?eWV6MjgyWnF5dlB5d29OM1VxLzNObDdwT3NTN0xSSlV6QWFGaVUyeVJaaVlW?=
 =?utf-8?B?TEw4Q2lMS2NmMnBMTmM5UDFTY3B5bFVVNnhMU1RnK2JoOHAvVHBVSHhiWG1O?=
 =?utf-8?B?THdISVpkQllOcFFQaEVMR3dVcTduWkNrNWN0NVk5YkpEMDg5Z1lyQkxQcExW?=
 =?utf-8?B?M2RLZnlrRjZiaEZGeHBqbFQvRGlkS0xJNDhqam91R013eTR2S3FlRjg5dmZQ?=
 =?utf-8?B?aVNGQzhtVXVFdUt5TWF0V3M0OG10VFVKejFja2ZOSVc5TVNXcGdubmJyaVhU?=
 =?utf-8?B?ZWxKNHdORjVOdFJ5ZE5VN1lsdnVsbWttWkh1TmpBTUUxMk84OHFmdnp0bVpq?=
 =?utf-8?B?UHhQTHVueFUxNFIwN0MzeDV2VngrUHFNVjdUMjJwdUY1ODh3bDdDd3Q0bHIx?=
 =?utf-8?B?WVNUc3Y4amkvM2tYNzhFTmgvR3I4Z0VNMEJjRlN3SjNHZ202VkRzQjh0a01h?=
 =?utf-8?B?MXhHbjJMR0JqWUpMMG1Ddz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzNJWnhWazliemVKdDNDNXJrVG1KU1RQRUU0WmlRZkpEUk5ONVNHczlsZFpz?=
 =?utf-8?B?WDUyeVJjS05WVUpSNUdUeUR0TFMycXNZbHRST0dtOHMzUW8vTElNaHh2SEx1?=
 =?utf-8?B?QjZLdDRsbkNEb2NwdmpDWWJKaWE0ZkFyb0RqR1JJNFo1Yk9Hc21ReTUwTGJ6?=
 =?utf-8?B?SkdMaVNXR3hJSFNQaVVNbG1jR0RIMXpkdEIrYzVLNUd5UVQvVFBDVVYyOHdG?=
 =?utf-8?B?c1pxem1HTUdsTWcrencxb0dtbSt4TUJwNXMwM0JhUG43aC9UUTdWUm45T05L?=
 =?utf-8?B?bmt1NlpkODJuTi9EMXVjcFRIQVJNd1U2Q1JZejhoUXZFeG5GUitKQTE4cjlN?=
 =?utf-8?B?RE5oNVV3TXJJRkEzdnFjS1pwZytVc2FydW5udzRidEVQMlc1Q2duOXEzSTFN?=
 =?utf-8?B?RTBqWkhKWHFyN3hTR0l0TUxvc0JSN1ZaNGUwL2VpOTlYOFJyM1ovdzc0TkNi?=
 =?utf-8?B?enVTMG15M1ZXMm56czhNaUhNY0dUdXUyOXRySC83M0VXaGhHYmcyWEQ5U2Jy?=
 =?utf-8?B?Sk8rMHFOMFhGVnl4dlJGZi9RTUZWa1NiVHRvREk5WlNqTmNuTEZWVEVuU1Vl?=
 =?utf-8?B?bit1cTRkS0RoU3dNbElpK3FweXVleWlEUkljSjBobFpMQ0swa0hoelRuK0Fy?=
 =?utf-8?B?NjVBT2dXcFlQZjhOVFdOVUpaYlcya1JRcVpiYVpNa3lWeWFkUTROR1p2dXo2?=
 =?utf-8?B?SHd6NDZYTFRGcnhLM3JSRjFubkh6YXR0TkFkZUhLOENZSFpHV2Zhb3hRbGlO?=
 =?utf-8?B?bi90MHVLdTJ3NlBIWTgvUDIwaDBEOW1Va2ZOdVJkQVFIeGNlc3ZRNlg2d1dk?=
 =?utf-8?B?YWU1RGVENVNDUXR2TytoWnhCU0NMWDZnUFg2TmF4NmxUUFp4QXArWjRDMkVT?=
 =?utf-8?B?UnJrS3V3MWFRYkdxSmF3blJGTnV0ME9rUzN5dWx2TVBaMGdvME82akhuOEJU?=
 =?utf-8?B?alFoL2xPd1F2dWpVazk3MnZKV295Y3l5eUErNzJraGNlUTZmME52N3BZTDVG?=
 =?utf-8?B?eTQ3bVM1a04ySGR2dGNxUDlYZzBiWWh4aHB3Vy9vT0xDOStvR28vb3liVWVi?=
 =?utf-8?B?YnBZU244Q2hUQmZ4VEp5OTZLZURyRjIvcDREaWRhczhXTmVwVXBKTmY0Ymdx?=
 =?utf-8?B?NEczUFRRTFJncUhwcW1RNTBTSTNCVFdPMjNvTFJXRVNzNldXemh0c0hsd3Ft?=
 =?utf-8?B?Rm5MLzBRbG5US3g0bWlKaDlKK2tTQkttQklLVGpsaWJLRlo3dlB0THVMRE8v?=
 =?utf-8?B?KzZUTUQ5MjJsaFV0bjZva0dvQXo2bCs0cm91L09FYmFVSVRkQlZITGpWV3ow?=
 =?utf-8?B?YlRJc2FHU1g5VkdPV0ZZcnIyUzRFQktHdU0xK1RIUVR3WmswRkFoR3Bac05J?=
 =?utf-8?B?T1JZNjdEVlFkWTVCajhyQjdRWnhOWk0wbzhtS21ETWhQNGNRZEdEcDFHSm9H?=
 =?utf-8?B?RG9XWjBMM1kxVGNyNTBrM0llM0lLUlc0RC91c2xCN0IxZlNPY1VSLzlwZHhK?=
 =?utf-8?B?WDBYVFE0K3VzQjBHK3NmT2swZlRYM1AxamlhVSswYW85VnJiMjZwTmxVcUl3?=
 =?utf-8?B?eU9Qc2VkeXM0NmU5SXpWTWtWUHoyeStlbmdYNFFrRldySnFBdURoSU5FbFAx?=
 =?utf-8?B?c0ZFQ3J4VDVjT0MxODdmM1JwNi9DMnZQSkgrYmVsbjFBNkJ0dktMWUlVVnRa?=
 =?utf-8?B?WXlUUXl0Rk9ieEFPV3YyTEdxK0NJU2h1NGxLVnJrVndxcGRoWklqVHh5Y0Zs?=
 =?utf-8?B?dmw0cjRaMTcxREljdGExTHRSekIrUE5BN3dFem1oVW1mVXBZK3VkUitXaDFl?=
 =?utf-8?B?WXpCYXdGb0QxUlhSNG9MTDRaU2lXeHNLT1k1a0pHM2xVcHdVMFJiUnZ4QWVU?=
 =?utf-8?B?QXQrQXNRODVLcUFzNXk2NmFleFlTUEFCa28rTGtyYmhtMDlrZytROHFiWnZl?=
 =?utf-8?B?eDJRc0gzaDI5RHoyNkM3Sm01VEp5Z2RZOGJiQVZDeEtkTDB5dnFYbnpZWWxW?=
 =?utf-8?B?TndtUWIveFZZRFJzbnZJRHVLRXBjc3hsWHFJRU5zbncxMmF0UlJXV2ErU2cv?=
 =?utf-8?B?Zk42Y1NjcUEyUkkrY3pLbmhBNk4yVGdNTTZ2YUxRTlZlNGRYUVNrdXIxM3Yv?=
 =?utf-8?B?bDRGd3A4clNWc3crb0VxUFVJYS9jek5XK2Q0a2dtR2NVZ1UvTFM0VlRlRFhI?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: de76b9c1-dec4-4719-c084-08dd45460cd0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 18:02:12.3931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/yhEu8AAC/BWLuGT0yCC+TwCGesKUEqB4ivQ0T8VGkmFQW304LNUdrWk8l4lzB6QBQwAtkdf7GVwBluqwmJRjpue5YcJ0h8i+E/zjczbSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9986
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

Hi Chen-Yu,

On 2/4/25 6:53 PM, Chen-Yu Tsai wrote:
> On Wed, Feb 5, 2025 at 1:49 AM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Chen-Yu,
>>
>> On 2/4/25 6:21 PM, Chen-Yu Tsai wrote:
>>> From: Chen-Yu Tsai <wens@csie.org>
>>>
>>> Device tree overlays are immensely useful.
>>>
>>> Enable it by default by implying it from ARCH_ROCKCHIP.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>>
>>>    arch/arm/Kconfig | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>> index f504d7d07601..2797030d3501 100644
>>> --- a/arch/arm/Kconfig
>>> +++ b/arch/arm/Kconfig
>>> @@ -2061,6 +2061,7 @@ config ARCH_ROCKCHIP
>>>        imply DEBUG_UART_BOARD_INIT
>>>        imply BOOTSTD_DEFAULTS
>>>        imply FAT_WRITE
>>> +     imply OF_LIBFDT_OVERLAY
>>>        imply SARADC_ROCKCHIP
>>>        imply SPL_SYSRESET
>>>        imply SPL_SYS_MALLOC_SIMPLE
>>
>> Yes but not entirely enough right now.
>>
>> See:
>> https://lore.kernel.org/u-boot/20250129-px30-overlay-v1-0-4729b3fcb4c0@cherry.de/T/#t
>>
>> At least it still boots even if fdtoverlay_addr_r isn't set so that's
>> not too much of an issue.
> 
> Sure. Though having it compiled in allows the user to set fdtoverlay_addr_r
> manually on the command line or through a script to be able to use overlays.
> Not having to rebuild the bootloader is already a huge improvement.
> 

At the very least add in the commit log we still need to set 
fdtoverlay_addr_r for it to be useful.

>> Would be nice to check which SoCs do not have this fdtoverlay_addr_r set
>> and actually set it as well, otherwise enabling this doesn't help much
>> :) (at least with pxe/extlinux)
> 
> A quick grep shows:
> 
> include/configs/rk3308_common.h:        "fdtoverlay_addr_r=0x01f00000\0"
> include/configs/rk3328_common.h:        "fdtoverlay_addr_r=0x01f00000\0"
> include/configs/rk3399_common.h:        "fdtoverlay_addr_r=0x12100000\0"
> include/configs/rk3568_common.h:        "fdtoverlay_addr_r=0x12100000\0"
> include/configs/rk3588_common.h:        "fdtoverlay_addr_r=0x12100000\0"
> include/configs/rv1126_common.h:        "fdtoverlay_addr_r=0x02000000\0"
> 
> I don't have any devices with the SoCs that aren't on this list though...
> 

I believe, those would be:

include/configs/px30_common.h
include/configs/rk3036_common.h
include/configs/rk3066_common.h
include/configs/rk3128_common.h
include/configs/rk3188_common.h
include/configs/rk322x_common.h
include/configs/rk3288_common.h
include/configs/rk3368_common.h

I also have none of those (except PX30, but that's already being tackled).

We usually have the overlay 0x100000 after the FDT address. But that 
seems to be the gap between FDT and kernel load address on RK3036, 
RK3066, RK3128, RK3188, RK322x, RK3288. On PX30 and RK3368, it should be 
possible. On RK3036 and RK3066, there seems to be something odd with the 
FDT since relocation is disabled, so not sure how this would work with 
overlays.

Another issue is that there aren't many upstream overlays today, so a 
bit harder to test (though one could create a very simple overlay to 
enable/disable some node and check it's properly applied by U-Boot when 
booting.

Cheers,
Quentin
