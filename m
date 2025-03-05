Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2B6C28B22
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 826E18141E;
	Wed,  5 Mar 2025 14:29:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TVNoUpxF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74E35812C8; Wed,  5 Mar 2025 14:29:34 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 756E8812BC
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsiqp9RHBYQlqBm9snjvNbDg1Rd/QdvQR9h+Xj739FseYR/72O0iuBjgoMvIrK99riNU2Jj++dOOzVv0OAo+iEtaUp8LSl5yE9XbU0e2a9ii3LVTa7VRRhTJfFRpUj20TxTGuWTOvNCxJkg0ySnn07/JKp7W6qztd5wR2SQVbO52tfZUCyh3WapH8VIxkuBm6WxyKYhkJKwnBSKWfJ4oRUZ/9GAuWDezoRkEQVrTgIxxPEi4eTXQ2314fWFWBiBKbf4tGGaA6T8HTDjb7yybV2/ynV+gUXZi37syIUAdMhBV58Y/fNc7P1udKnsGA3ySyULidPuqdR/nuDgk+DvSzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAE5NEFSjecd+JCsefq0EEcodYPOvIrKXZ3euQl0bXg=;
 b=tTtY7a9RmWO/hrrCs054NFtxko02N5ofqI22dZ/ublgzk5Ctm1blV7hIITeXgwW1ulPrXFce5xgE5ED+CKjdtbHsQ9p4srNxNLzDFdYjtHgZRQ/1+LSSBs1Q6uMsBaPiJDLh+iLTVeF8RP5+IZsn0X56tDvIgSeDkI+8xbGqvUxnWZc9FZdebHttCCeRNfJEIaweEmhwKrfRxfCxHOolkiaVsKBrjQJkc6wmIg2A32DQdbpax6QtGomYsfWGA5WlkCmz3Q97sAT3Jm9Sx3x7HrXK2YttliZ+ne1bsebT4v/YgUp/Ic23IOlMHhKKkRtL2+xRJHlAYzTq38ZAfljCTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAE5NEFSjecd+JCsefq0EEcodYPOvIrKXZ3euQl0bXg=;
 b=TVNoUpxFPvgxlezIUq0hBahg1rLyaUndRW48sUb0hTkysLnKNF4B6Hq17LUcYnx/wFMVMRCYfT5XepBrK8v7/FXMxoU5ewO4X/c+ONdmMlP4DjVZmjgiz9nMKVRTiGgkNgGB4DRUGwjsvioq+7yb6EOzQMPHCa4DJiHcbOqCVpxN39jccWwETRKq5FqnPEI1QF7FU0RfgVOescDig1qwMda/H0T2O0bLk5+PFY8d+rYkJi64QkmWI9ne0nrsiOsjOLbPUerAAOvQBsp3ZpN0CWF392ZKT1Z5PXsWJ0KLWqREmZyuxixT3q2R1hz+AOZzyMpMkdSAM+7LTHt6tq2d3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS5PR04MB10000.eurprd04.prod.outlook.com (2603:10a6:20b:682::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 13:29:31 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:29:31 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 05 Mar 2025 21:28:21 +0800
Subject: [PATCH v7 09/19] scmi_protocols: update struct
 scmi_base_discover_list_protocols_out
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-imx95-v1-9-286d15acbb8a@oss.nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
In-Reply-To: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS5PR04MB10000:EE_
X-MS-Office365-Filtering-Correlation-Id: 774a2309-dd2e-45d1-f911-08dd5be9c274
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1Q3V0hWSWhndVpDRndyOWJWM3N0RlZYdTFHRHBWTjdvZnBENWdvb0lwN09Q?=
 =?utf-8?B?NFdKVjBKYTZPTXhubCtBbkpNbVcrZ0dkRnZpRDM3bi9OYndyeUFlYnMxRGxV?=
 =?utf-8?B?dXA1Q1AxTHlLUWtIaDROY0lHTHBSM2RsOEdmV0xEOTR4TW9sbk1BcHo5M1ov?=
 =?utf-8?B?VFBDTFRVdFdjQzFxY292a05Xd2M5bFMwWktHOGp4aDIvMm9BdVBocW1vckFl?=
 =?utf-8?B?Y3QrQVhMTVo5bnV3c29ReXQ5VkNYa1BLVGc4VktBWGFVVnJjc2FCSzV0eWx3?=
 =?utf-8?B?c1NrUWNTbGNuVmRlWHMxSnBydzNSZk5Mc2k5NXVKOUpwVWprMUxkZ3FEeXBD?=
 =?utf-8?B?UWxYeEtMU1REZFFhaUlxTjVlcHk1RnVMdzFJMU5oTndqbU9TOGNxemQ4L1NC?=
 =?utf-8?B?MXJVSzZKNVhWUG1qRmo5cGFlTi85WVZTeWZBY2RHaDhMK3cvMGVSeHZNQmlY?=
 =?utf-8?B?YUl0Z00rSlVGdGFPTWxNN0NFVFAvWXBTUjJTRy8xL3J6Z05XZ2dneCt0M0gw?=
 =?utf-8?B?TlFkTTlxenNxQmxVMlhSWFNzOFgyZjhuWjhRTUIyK3QyY3RSU3RtWm9XV3Va?=
 =?utf-8?B?UXB5SkVld0ExQ1p4am02dUc4WkxvekU0Z1JlV3J4a2F2aVZSODRYWXovVlNl?=
 =?utf-8?B?TEdtR0toaFcyR0o4V2tMakRnVHZoRVRTZ05YZlNKQTBDL2F0NmZRVjVFTG9I?=
 =?utf-8?B?K1V5UjZvRjZSakU3OGh0dis3QTJ4RExYZWVkSEpSRC92Z0pxSGsyMnF1Tk5s?=
 =?utf-8?B?d1YxYmVJOEg3M3ZVKzBkY2VuNll0RDFMZVZHeW5GRlNGRlhhY2dZa20xZy9R?=
 =?utf-8?B?NElvcHp4eDVINXpIR0Q2bUpjeFFrSmZVeGxZUml2RUUvb2FUd2p6Mi95VzN4?=
 =?utf-8?B?TWpUamtHeFBFY2hMMEFFLy82bDFjS0tXb2RNMEVCYURuOWgzOEJmeWVyZUlS?=
 =?utf-8?B?bTRQTlhKb1hsb29kNVZoS1l4YmJTbGkwcHZFRGJSd1RxSmNRdkhqemVGNkpQ?=
 =?utf-8?B?aW9MWlRnU2ZLTGEwZE56U0ZTTVVYMmVSL2xHd3ZBS0dtMXNHNmhhblNZZ1hL?=
 =?utf-8?B?K0psNkNTUjZnem5BeDBwTmUxelNTanhlQ25ZYkhLWDlSVTIvYTBuUGpDZUdu?=
 =?utf-8?B?b3pGcjh0MzlpaEJEcWRiZWZ2WGp6WnRmYVo4R0hxVzJ4WW40b0JqVzE3NUJN?=
 =?utf-8?B?SGJSVFY4WUZlV05veXViZ0JTQzNKRzF1b24rU28wOUNEbUphQkhuVjRJWE9Z?=
 =?utf-8?B?L0VJMjFYWlhaREo0MEhkWS8rR1k3M1BXNGpIR2N5VTdRRzRZWUl3alVLYXlz?=
 =?utf-8?B?bmMvbkVCWXgwZkN1eFlEemZqN0JsUEhXTkREM3M0NTQ0Rm1qd3g0M09yVFN5?=
 =?utf-8?B?VHQ0RmRRdGthWElGNDRRNFRrM2Q3c2g0emtUNExPVFNENlljL21ZVXU2NWNz?=
 =?utf-8?B?cDJsL3c0WmV0VGZwN2pYREhDNHFwWm5ucHI5czVJV2ZRZTN0cjlXZCtodXM2?=
 =?utf-8?B?bE96WlZvQlVnN1VDcFFsOGVjWElyRzVzb3FkdFN5cDZXbG1ZTzYvREt1ajhz?=
 =?utf-8?B?MmpHYXorUjBlL2dQbGJlcmxTMjBlRUQ3OUtzSmoxL0orUWNyQkZnSzB2NWtT?=
 =?utf-8?B?YXkwU3RXZ2FiR3NVMHh4aVgxcytwaVYwNi9LOEkvZE5kMlc5K3dZS3FEYVN5?=
 =?utf-8?B?RFVTdjg5WFQvOFZZQmlRMS92SVhnVEYvQ2dTNm5SWXJ6UGhiMm9MZ0FTL3h1?=
 =?utf-8?B?RXo3dEgxTUZsNGY3QkVkLzFQNkpCb2l3a2VoMWl6MVNSVG9UT1BOYTFhcEgr?=
 =?utf-8?B?bHFrRGhDaTN1K3hnVjlrZlFHUFc5akRmRGZCeXpSUTlwaUxsNnJxRjQ5Y2I4?=
 =?utf-8?B?K1NkbWZKajZkSDFPekZPSi9mc2g1Zi8ybEdRUVBDRFFxL0FjSnJiSVFQdzRJ?=
 =?utf-8?B?Y3ZvLzl4YjFPcnRHYVhoVmpVSzZwSk9mM0piSTYxUlZISE9NaFc4Zy9jTE80?=
 =?utf-8?B?MGNLaVBqa0FBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWVGWkF1eUZ2bVlMWUR4a2JMNG1uWE9QOFlqeENESjNtMDI2d3NmbEhNWTZV?=
 =?utf-8?B?bmxCRzdBZ0ZtdU9RTHBjbjdoMm5VZ2QrQmk4c0dOVUVvSG1hc3BacEhMTTQw?=
 =?utf-8?B?cGUxaUd0TER5QjBqUDhkbXlCWGJTa0djQVZNTDZncGxNQ01qVllxc2R0MER4?=
 =?utf-8?B?TUNXMm8yY1c3cmNaTVV6UjdtZ2JUWjNkVU1OaXpUd25NVXEzaW1HSTdIQW1N?=
 =?utf-8?B?Z1g5bWFxRjh2L2NyTjhtTXpuOWRQTWd3SWZ4YUdpQ1lnMlprdE9LcGpGbWdH?=
 =?utf-8?B?RnA4Q1VPSzBEdU1pOHk5KzdacmM4ekFPQUM2NDU2Rk11WnM0d3IvWFhWQWhy?=
 =?utf-8?B?YlJXNDFIKzZyZFFySUFBTXNQYzhpWlBrQnFza2FrY01ZWkZFK1JYMTdJS1U2?=
 =?utf-8?B?bmswOEMyQlpRc3l6QjJrYUJHUnFUNnF0T21hLzlwWkxncXpDZEd5RWRPTmVL?=
 =?utf-8?B?M01YU1R1M0xGTU5XN3Y3NUpGZUxlRldic2FrbWxXajNZRDRNR0pTMnN5Uko2?=
 =?utf-8?B?a2I4TmU2ZzdmQVFzMXBlcnREYW9VUDdic1BrQkVITGpXSDUyZ1hSUVpqY09F?=
 =?utf-8?B?cGdmT2dHaTRINzlDckJCRm5lSjR0UkZYUnA4cFl5K1ZsRllKVmM2cTVCY2JO?=
 =?utf-8?B?TVc3NTIzT1E1WWpHamUwQ292N240WUVLY3FQZ1drQTFyeDM3SkQvZ0xjeUhs?=
 =?utf-8?B?bWtrNUVCc0xSRGNXUDIxWnp6OW9CNU4rWWN5RjdLRFg2SjlkTXpkWmx1MGds?=
 =?utf-8?B?UEdqOWpUNzlUUlpFaXR6d0JxclpraHFRK21zUnJ3U1hSUFpMc1VZQWxUaDMz?=
 =?utf-8?B?b1dhQTdFTUJvd0pxTmVienJ3RHc5dXc3MGtYbVdtMTZGUjBFandDZ0o5MTFz?=
 =?utf-8?B?b1l1TVJNbjVFZ1RtZ3pQdEtjMW54enViZ2N2b0RmcU5hbm9Pa21tNFZyRzlH?=
 =?utf-8?B?VHlPbzdvVmxCNkZZZ2s2WFVCSHlVNHFGYVJOb1MrU2NYdHgxQTc5SGRQWFdU?=
 =?utf-8?B?KzJkeHBTSW9kbGFlVlBndzdsdFZIS1U2MzhzYjU2WWV0ZFQyWWFuS1NTL2Q3?=
 =?utf-8?B?N1VlSlZVZEdBVkY0dWl1d2czWUovbkZjMENQTWpPbTRiNG5jUjJXNXBnWFZZ?=
 =?utf-8?B?S3ZyemtERVI3RzRncHJneDRFK21Iek54R3hyc0hLTDFaRWxZRWQ5cmdERVV5?=
 =?utf-8?B?c0s3bnowYW5DcmZJTktBYW05OGNVWkN5YWp4NnlKUkdhWUNNTXBYN1QzMVd1?=
 =?utf-8?B?bG85OWQvL0Z0SDYzcFpBTGZqYlhQUWdoWXptODhNeGN2Wnpoc3lXNk9uRGdN?=
 =?utf-8?B?NWpWNng2d1FweXh1N1FzK1lGNHRXd0orRjRtckt6bXhqSjBDNjdkUlRaWFFp?=
 =?utf-8?B?eFZhSmIxR0cveXM2ZlhIVmVtK1ljZ1hVc0NsR2c1UEx0eTFubG1GKzY1Y2ky?=
 =?utf-8?B?NkdSakRGMkZIVEpZS3h4dXdmOUJsdEh1NEQ2M0pFWUFIYTJHYXpaWUVkRE1t?=
 =?utf-8?B?SVQ0STRqcS9JTkN5ZVVoamtodlBmNzMrMllva3MzRDhmK0t2N2lNQ0tqR0l5?=
 =?utf-8?B?bmd6bVBtRk1vSXlZaEd1Wmc0SmhLcVYvZ1ozUmdyMC9YLzBkVVNzaTRoWmhk?=
 =?utf-8?B?R2pONGIzL0YxOWNLRjFqU3A4NXh5Tk9SbVRRb3VXbVNvZFZLSC9rak9ZV0Y2?=
 =?utf-8?B?VkxQUHo0N2lBTTRyYlFEVDRvSXkrbmkwc0xlcTgvUzhBeUJNVURrMEUwK09p?=
 =?utf-8?B?SkVUd0RTbnNHMDloWk9heUc0TWV1d3FyZ1JXOVFvMVZ4SitJU05TWC9ySnFX?=
 =?utf-8?B?Qjc0MXdTRTAzR1A3MVFkNCt1c083cjNUaWNNVXNFcEhZZUhxQXJ4NmxLYVJw?=
 =?utf-8?B?YlRObDhmUk1FYTFFQjJrV0RMS0JDSUlhZ2I0akd3aldxemxoVXFLOHFXYzdn?=
 =?utf-8?B?enUyU1hBQzd5cm8yelc2MUdzUXlsdG9XMUZqVVhPbGs1SSsyQmRCYWJpT1Av?=
 =?utf-8?B?VmdNR2dvb2VJZkVLVlJ6d0FRY3B6dFlVejZYUmEzZDFVYzgwbXd4MWx3aS9U?=
 =?utf-8?B?UlBNZVI2Q3A3K05ZQmhPSk00TWY3b2JMSzZkR21JdDFOUFJwREJ6SHZ0NzFO?=
 =?utf-8?Q?9JxGzM8Un4ao0Gkv/XNJoHGsh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 774a2309-dd2e-45d1-f911-08dd5be9c274
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:29:31.0148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5qp2/3Fy/IFQs0ZnjCJlDHPVmw0//HFI/zcptgZglzGc+PWSyeSMsy7q4JJ6QCeecnsV7Iubeg0MliQ4LaqmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10000
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

From: Ye Li <ye.li@nxp.com>

@protocols is an array of protocol identifiers that are implemented,
excluding the Base protocol. The number of elements of @protocols is
specified by callee-side.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/firmware/scmi/base.c | 24 +++++++++++++++++-------
 include/scmi_protocols.h     |  2 +-
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/scmi/base.c b/drivers/firmware/scmi/base.c
index f4e3974ff5..3943d90fd4 100644
--- a/drivers/firmware/scmi/base.c
+++ b/drivers/firmware/scmi/base.c
@@ -258,7 +258,7 @@ static int scmi_base_discover_impl_version_int(struct udevice *dev,
 static int scmi_base_discover_list_protocols_int(struct udevice *dev,
 						 u8 **protocols)
 {
-	struct scmi_base_discover_list_protocols_out out;
+	struct scmi_base_discover_list_protocols_out *out;
 	int cur;
 	struct scmi_msg msg = {
 		.protocol_id = SCMI_PROTOCOL_ID_BASE,
@@ -268,7 +268,7 @@ static int scmi_base_discover_list_protocols_int(struct udevice *dev,
 		.out_msg = (u8 *)&out,
 		.out_msg_sz = sizeof(out),
 	};
-	u32 num_agents, num_protocols;
+	u32 num_agents, num_protocols, out_size;
 	u8 *buf;
 	int i, ret;
 
@@ -276,22 +276,31 @@ static int scmi_base_discover_list_protocols_int(struct udevice *dev,
 	if (ret)
 		return ret;
 
+	out_size = sizeof(*out) + sizeof(u32) * (1 + (num_protocols - 1) / 4);
+	out = calloc(1, out_size);
+	if (!out)
+		return -ENOMEM;
+	msg.out_msg = (u8 *)out;
+	msg.out_msg_sz = out_size;
+
 	buf = calloc(sizeof(u8), num_protocols);
-	if (!buf)
+	if (!buf) {
+		free(out);
 		return -ENOMEM;
+	}
 
 	cur = 0;
 	do {
 		ret = devm_scmi_process_msg(dev, &msg);
 		if (ret)
 			goto err;
-		if (out.status) {
-			ret = scmi_to_linux_errno(out.status);
+		if (out->status) {
+			ret = scmi_to_linux_errno(out->status);
 			goto err;
 		}
 
-		for (i = 0; i < out.num_protocols; i++, cur++)
-			buf[cur] = out.protocols[i / 4] >> ((i % 4) * 8);
+		for (i = 0; i < out->num_protocols; i++, cur++)
+			buf[cur] = out->protocols[i / 4] >> ((i % 4) * 8);
 	} while (cur < num_protocols);
 
 	*protocols = buf;
@@ -299,6 +308,7 @@ static int scmi_base_discover_list_protocols_int(struct udevice *dev,
 	return num_protocols;
 err:
 	free(buf);
+	free(out);
 
 	return ret;
 }
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 2684f4177d..3afc297812 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -145,7 +145,7 @@ struct scmi_base_discover_impl_version_out {
 struct scmi_base_discover_list_protocols_out {
 	s32 status;
 	u32 num_protocols;
-	u32 protocols[3];
+	u32 protocols[];
 };
 
 /**

-- 
2.43.0

