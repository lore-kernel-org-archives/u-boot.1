Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818FBC369D1
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 14:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2932E80BA8;
	Wed, 23 Apr 2025 16:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="yDdioj/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5E9380FA8; Wed, 23 Apr 2025 16:57:00 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B28BB81E72
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 16:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8dFMqstf/xVB/LNKEDUpooNeC7kZMyAwTl6f3b0MrwPXEJA8VJ8f8tJd/Q3u0LmoY3l3IQad4iHl+XdOfErmyVWNcu6sKbmtofPXXQt30GCGiI1TjD2g98GpqoDr0krH/Ithg28sM4noaNLKPfOIpHybp2KMqR0vJBEkHRYI+Z70bmNTPloIrdaUEDGCHLdCzciJk/KPtOBNA7OgUMewMntU/Nsc/tdTtL6w0CduEzHPNV5+UCyPmBy7WUxB1floCOIGYMuIE6U4ko+jzGksAaZEuQVb8NSDU4oeDXwXVWjgdmtiH/iaRaYe7JlKHcsQoVp96VNBM/WiUJxvZcS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09YxUCfuscZBn68Ydgu3s9wNkUqQcbY8ndtKIdKpNpc=;
 b=iLa33Cx673aJNz7eddU+iBT0Ur0mL/mJmXPQxu1ua3+uuMPeS60sWDx4Ff51AwXQI15tosE+L6ocPWGq3ZFfwnOAWdy9WjOxo+OIxaAjlt7bMd51jXvKB2o258p2se3PnFwcAqQEGbntNzhj2B8ho9jQrnDRSFACAtUTa0R3+4da3hn92z5aWOTpnvyYglbMZ1GKB8s2c+Z121K9+/LRJZseZJyUMq0QnlBcxTr5Jt59yCnqcIctk9uC0HCPnl5n0qMaBEI/SIBydr1t/k98iRhq48tXbk8+H+Cg+hA67mV3UZRJfk6JdThL1CadXcXP0RuOoLUsE7f4z/hYS3Ol3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09YxUCfuscZBn68Ydgu3s9wNkUqQcbY8ndtKIdKpNpc=;
 b=yDdioj/w6hMdkny5Uiw41y9Tp74Q26tEa6GmdsD5gK0OtqvtfiSV4kvQh6AmOwUBhJXkxfW/FSR0cDJDqG1qxVY7DcI5GKf9cyt4A4Bq98rCJXJDW5q9kyItOYXeI2tFDzzcYM+nnICZ8M2jYsa5rWQXQl7UUXwxxYKJ3tfltvT2sVFbdC8mn2y5BRRzA2+sSwi3iPS3tEWNN4USvsOwMaY6O72zI+b+UUem3wmmqbZUo1tLEQoZdpdl0OiW6T1s669c3mEtacy+Y0oHced80TMbkEEjmvW/xQhT3FOxR5IfxLR6WcqxvjLx1iE848g4i7+7lXVdinn47KDuW+qYlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB8013.eurprd04.prod.outlook.com (2603:10a6:102:c4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 14:56:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 14:56:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Mathieu Othacehe <othacehe@gnu.org>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
 regis.ray@landisgyr.com, pascal.dupuis@landisgyr.com
Subject: Re: [PATCH 0/2] mmc: omap_hsmmc: Restore the init_stream sequence
Date: Thu, 24 Apr 2025 00:05:36 +0800
Message-Id: <174542428425.32054.2192372473014999385.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250410090021.14446-1-othacehe@gnu.org>
References: <20250410090021.14446-1-othacehe@gnu.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c767e5d-4994-4b04-9fd6-08dd827717db
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkRGTnI2U2xQaGhqdlZHQU13dVB1T2NKN1NMRll2Mjh5Qm8vY3psQmhtZ3NC?=
 =?utf-8?B?ajVLemhqZDEvdFlpdi9vY1ZBcGNnMFpvTTM3Y283MFN0M2lTNEk2OWd5Szhx?=
 =?utf-8?B?TWdybHhxNHJ3TFR0QWZ2NHd0WXJHRDZJUXJleFkzWCtWVDZmdG1VTy8xbk42?=
 =?utf-8?B?V3EwZkNvTWFUU29kZURKU3lnWFowbCtUNWM4T3ZjS0w1Tys2UDVQYnNKd0V4?=
 =?utf-8?B?cURpT3VDelJ1VzVtWXJEdlhWbWkvVkhqQmpmdDFDcU4zaHdPa0ViUjRzRFhp?=
 =?utf-8?B?Y3dhWWJqU2xEd0tub2M2L3FBakh5LzRtcHBuWk1iL1F5Nk9tYXp0K0xTcTdl?=
 =?utf-8?B?Z0NZdmI3cVd5dEUwNWdTWUkwZm4yYmJtNDhCWUJKQ0JuVlVVdW9IUzkzL2M2?=
 =?utf-8?B?eVRCdS9UWlBUUUt2SWlONExacmtaYSsvd2hQYngzeWVtSTU3NDE1YTBoQUQ2?=
 =?utf-8?B?QzBBZ3AxbUdaMGwyTGQyOXFueXJhN1VMSWh5M0NZZzZ5VXJOU3FlR0tDK2tw?=
 =?utf-8?B?WWZDNWcvRmRMcTJ1VmF1Z1NKc1Y4clRYSVlmNjIyTDBEN3ExMkF2ZlUreFdS?=
 =?utf-8?B?UTFLYjlnRW9uUThGdXBmTjltRXFiMmxtSGNFS05LaGJFVk54anFxZzcvN1Zq?=
 =?utf-8?B?TzIrTDhQV0VHVlp5QUJvU2dVMThKQ0hrNklPQXEwdEw3aDR5T3dlNTkwZzZl?=
 =?utf-8?B?Z2RENWFaaUx0UG9rMENvL2RRcmgxRENMdzBrdm5qYlRKRHdXZk51MVk5R1dT?=
 =?utf-8?B?V3hqZDJlbytvbGNqQTVCMUUxdVMzS0J5NHFXYXZnL0ttclJjeVRFY1ZpeVo4?=
 =?utf-8?B?ekZQSDNJVUNMWVJoVjVZQW1NMXN5emlETzF0ZVQvejBCS3JaeWQzdjE5a2o2?=
 =?utf-8?B?dGt2emRKTk1DWlBEdElvVVc3OElIanJPakRnb040bEZWaUJvRVFnUTB1dHBE?=
 =?utf-8?B?TlhHQUhmYk5ZaUJCdkc4MkM5YWZiTjZqYk1hUVJVNkphbUNsT0k5WWZvMlht?=
 =?utf-8?B?c2JxKzlyVE9WdC9Ta2xUdUF5NXFkRUVuMHJlNDRmdVhibURFWFVhNGZGanBU?=
 =?utf-8?B?KzdxWXVoWWsyTmJpRFQ2THhtZHdZRStOQlNrREF6aFhIZEhyamNIL29CMFpU?=
 =?utf-8?B?bjdXcjBRREdFb3R2dFlYY0c2cXZqWmdrUEhMbGp4UEdvQ0RvRGdubSs2eWpZ?=
 =?utf-8?B?QUlMWTBtV2NNcnpqZC9NTGdTQWw0V0taa1BnVFpPYzV3cUNsT0VXTlUyc3BD?=
 =?utf-8?B?V1prOW1oTUwySTVnaVkveC9pTnpDSXl3MHFXWDlLNFBCZE5wYTNKaHhURXZa?=
 =?utf-8?B?d0p1UDZxbUcyN0F5ckdvbjFzcE9WMStRdjBqb3ZBZUFrazdzVzVtem43TmIy?=
 =?utf-8?B?dHhqdWdDd1FnSEZwOWQvLzlyTmVQUEY1U2Jyd0lyOEZQWU8xN1pDZWhkOUJt?=
 =?utf-8?B?RnF6ZlJyOWpvNU1kZTdFK003Qk1wdXF1SEp4YnEzeUhsYVgrT085N0Vwbmtk?=
 =?utf-8?B?SjNYb3VxQWtXVXVyRmdRMFByMS9FQVlyR3RhQzFqNEs5KzhYZGhVcE1YRlZx?=
 =?utf-8?B?aFB2dC9sdWFkMDJ6Rkd2N2FYdlp2alJKdjFoMnBXQkRDL0JTRGtvNGxkV1NC?=
 =?utf-8?B?M0x2L3dCOUQyLy9JbGNBMC9BbWo5dEhGNWpvWjlQOHFvQTJ6MzhPeDlQb0Nl?=
 =?utf-8?B?OXRKSUdZcmk5Wk1wM2FURmw2R3l6QTNVOVFDU3RPQys1V1FvTjV3QnhibFdL?=
 =?utf-8?B?VTd5enMxM1A4U1BhNmY3aDhBVzFZN1N5S1RhVXJHNXozTXlRTnp3WEpwZmZ5?=
 =?utf-8?B?MTBqTm9jbi9PRUJOVS9yOEVOTmJqSlNzZjc5M0FmbFBSWTZnblpkeG8wOWth?=
 =?utf-8?B?UW5qbVdkWSs2OFliR1ZIRmdmRDlTTXczODJKTTlJeE5KTzZhTHhxTzMzN3dJ?=
 =?utf-8?B?NjY5UzUwUGhacUhkc2NBNFV3WXduZ3I0WnMxSlc5RWVLN05ib2liS3Awa3hi?=
 =?utf-8?B?MW1HVXZ4eTFRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Slpob3ZCSjh2VExPRWs5VmpRSUc0b1k0TGNMSmp4aGxVL0s0QVJYZktIMm1P?=
 =?utf-8?B?cWFZR241MlhOUm1yRmRaSUVNTERnSHArckVZVlJkV0h6bnBmUXZKY3ZGR3RR?=
 =?utf-8?B?TWRac0ptV2lKQ1lGYlZyZFdUeGdMTmFCNTFwOWhuS3hMYjFTbnJ0M3Z5d1hX?=
 =?utf-8?B?Q3RzbC9XRDZDVDFDVy9lY1drdDhjWVZONTB3VGJqU0xkamlwQWVtYXlya21t?=
 =?utf-8?B?YVYvM3U0NmZqbm5sQnNlUjJRcGJoNGpyY1BDcnNvbkw1K0ZBb3RLeloxMitx?=
 =?utf-8?B?NHRWYkI5SmRyU3dUTUQ0KzJpeVcycEdWcHFzVkJlMXJ1YWZIMWxCbmcrV3A1?=
 =?utf-8?B?ZmVCZHQ1ZEh3QllSQXB6K1BWQTVnQVd5STAvYlUxQlZNWm1FbWN0REVmT0Ry?=
 =?utf-8?B?ZWZkVkZ6VjMvV3JxWTJJM2NWUDhUWGV3OStkUkNZM05kWHVHWW5nL3FMTWMz?=
 =?utf-8?B?OXd0ekMwcVJkdEpYZkJHYjZOUFZSOGlrbzk2ZXE4aWlPRGpvUVYvR0dxTHhu?=
 =?utf-8?B?Q3h2Sm90dzd1S3kyaEpmWlh6aWRiSlV1Yk5qZDNpKzRiZ2RoRWxtTWN4alRm?=
 =?utf-8?B?RnBzOUVZbkVyVWgvSUdpVXVZOXRRUXBNUjExYmhUMGZBVmQzazFEcHRFZFZ0?=
 =?utf-8?B?Q0drQjZiZXVqS2hzSjVOSWpqRkdDUisxb0JOdkVoVmZIWUNqTkp3U1UvTzQ1?=
 =?utf-8?B?S1IwWVJpYk5mOVhMUXVjUUpyUWJhcURRYWVOL0Foc1JZV0g0Y1d0VVgwRThQ?=
 =?utf-8?B?QXMvOG5kTEtpQmFOdVVoeWFmTUQzbG02SFE4Z1lBUERZNTZQSHdGWkd4NnJq?=
 =?utf-8?B?QkNpZHcrNG9IYVNzYzdKeXBVODFlWUkvT3VsekxneUR6SVo5L0p0Uk93VnZL?=
 =?utf-8?B?ODZFT1NWVUpJV1BpZnI4RXlIcWFsODRVTSsybU1peU8yQWt4UHZQSHlUdUs4?=
 =?utf-8?B?Szd2c3VSdytwa1ZKZWFhVWhaNElhWFJUdjlUSWN3blZZVFZrMWQ3b2cwVmdQ?=
 =?utf-8?B?aVpOV0pTQVlIZ2NzNm4wdk1NVGRwS05OV3MvdlZIK2NFY2dNeDhzSUxqQSs1?=
 =?utf-8?B?YUd0N09QZVovc3Rwd1hQWitKMW03NE52RHRpeUpUbkpPZ3NZZzFZMzExRUI1?=
 =?utf-8?B?RHNKNTNYano1WHo1SHlzVFF4WHJieTZxVTJNWExVU2xuV295K2lnZm41eW1H?=
 =?utf-8?B?U3FqSTFSeGR5c3hVaGt3YzEwNVlDeWdFS25pclFsUXhKKzVtMXZXLzhiRElm?=
 =?utf-8?B?YjdrRHRNbzFLMFdpS0V0UEU5U0MyVmZqSzZ3L0RucE9OcHhSNTg1NEIzaFdM?=
 =?utf-8?B?QXhpNzNOQk02SFZqM0o3RjdYd0lhRVZGZWpsNFRvNFVYQXdsbjJHdWRhUnUy?=
 =?utf-8?B?UVVuTHlBSkVXQXBZb09wT3NwR3VLNmVrZ2trOEZNbUtDZnVwK2NPREltNkVa?=
 =?utf-8?B?SllHREZhcUNhT0g3UEdTelA1OXdFbEM5Q3hQUjdmakkrQ2J5eG9wVG5ZMStM?=
 =?utf-8?B?RE95UTFNZmwxQS9JeXRIc0ZSeEtVbm1iUHJUc083MXdBZFVRdE1aWnR0RFIv?=
 =?utf-8?B?ME9Sc0Fqb0JVTE1CSkRjcUpwTFZzQTh5eW80UFhzK3NuVVpsMUtNVUpXelU3?=
 =?utf-8?B?UWh4d1JJQ0Y2U0ZyT29NcjN6VzVSUGt0b1pOdGhlN09LaUNMUStMUEVNYncy?=
 =?utf-8?B?N1ZzQm04eHZCSHI0NFk0SVp2MVVyM3ZiR21zeFR3dkZ4Q1dmTFFXUTl3aVBh?=
 =?utf-8?B?L0RIcWliUHd2YTd2WUJ6cGZVaTVRclJqaUNwR2lVWi93aGV4MVRjdXdiZk9a?=
 =?utf-8?B?N2FtTDJnYW5FMitrNy80SEpoZFVWOXErbW5idlVLZTBnWWtvN1Z1QmR3WUtQ?=
 =?utf-8?B?ODB1OE01OXJSZm5rdXNIMU5HNlpFYWNyYjJscGxHcXVnd2FKWEJOeVVCMWk3?=
 =?utf-8?B?L2pFbjhjQU1TcUFoN1gyNEg1Z2VtTjF4c3R3bWgyb1JDNlkyUU9mMjFMNGoz?=
 =?utf-8?B?aERuYU1JSWhVYTJqaVRDSHdOUmdmczZuMzB5eGg1TUwzZDc3Y0tVQkRVclJQ?=
 =?utf-8?B?T1NMMjZqNlRodk5kZU5uVXMvalpsMFRZY2tLS3gxd0F4Z2J5d1dQWGJkTkhH?=
 =?utf-8?Q?06cTEGTk/+BiBaatqDzcrSQM2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c767e5d-4994-4b04-9fd6-08dd827717db
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 14:56:57.2460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40TzXR1E38vfbP/6bfQP0MzTT7UoL5OvBTzaKrA7EXmCFY5OHodZlDMqoyAnu84iXLxM4wp8MaowEJqv3hHC8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8013
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


On Thu, 10 Apr 2025 11:00:19 +0200, Mathieu Othacehe wrote:
> Back in 2019, the init_stream sequence was disabled with db52e19ced because:
> 
>   This is not required. The MMC core sends CMD0 right after the
>   initialization and it serves the same purpose.
> 
> That is wrong. It does not serve the same purpose at all. The init_stream
> function role is to keep the CMD line high for 74 clock cycles which is
> required by the SD specification[1]:
> 
> [...]

Applied, thanks!

[1/2] mmc: Add a new callback function to perform the 74 clocks cycle sequence
      commit: d770e325e9d2fd3ba94481fc6ee41c25e799b325
[2/2] mmc: omap_hsmmc: implement send_init_stream callback
      commit: 991c9530fc0d52229e6196f6be2dd6e1ef17857c

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
