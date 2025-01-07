Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373D7E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 07:00:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95BB38070B;
	Tue,  7 Jan 2025 07:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KgsGgtLK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7BAE80703; Tue,  7 Jan 2025 07:59:27 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC511806F9
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 07:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KH1DuuZxny8uNPjYYRIzf3WZy1Pe2vLAOwy7qG+GhF8HHXgvps1akDCEAAMkWXzWYg1pQFQl0UgZz3i8u5hL7FkB4Lbu2WKR4PEAeoXOgl7y8wEyXBMMBnnr7qPrugbxjhH6bgCqgaVg/yLT5qlVM1PZGYLTuRB9VAxX7kt7PqBWTw7cHkBqsAqm9QQ8lwfbiNSxZKXxjhB8lEcOIxVYqmF6S4RClb735IxHWTrFgs7cMp2lBF7bgyaRGMbHKYQq5xgxBAhfC/0gJhFmRT/0/zmRqJHO3AteN/cgScGHkD/Hb7k0cy5J+EyuOZ4BkYaCJv1UayLpNBwGi+zS1iNKaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YEB9ihrqm9PJDnbh3dm3neenJHjfYtnY2UOZrdQ6No=;
 b=WqxbcfDoMpDo09CPxgs1JmbOqGUU1FSBzpfsnU+VwS2jtxuxVZ5CpUrpMsykGYHD1Ckr9k56S9zyYZ0FOe+HzfNFYbfqMJhZ8SL1VSKhXc0Iyt1piON3gSpM4t2Um+SQGY+/7jdJ43+g952c0VqWHDxCK2Wmwv7WoD7HE1GLP1UmhC7FJo+xB4Llk3KjtvTzAJVXZNDLENn2rU4Yw7JAo31vJWi7Ru+A4WOS5j05QfIwuEPcbJdfdd4Vu35o4C9XIZoZ7+DvD+swDlXvx6KPEQDbeWl06hfIkbgTm0zSuW8UAiMw5QI+S3hc/R7tGy7Cwkyf8ufkTNTKmZ6biKn4sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YEB9ihrqm9PJDnbh3dm3neenJHjfYtnY2UOZrdQ6No=;
 b=KgsGgtLKJco3rNvLUVf0s3H4V3uLCQ7KZ+/1dFL80gyNTH8vNRveP5A0KusTaDBeDhXAQcN1LFE1y5857xlFguMzH3B+e2gGcFwsa/TuySBN6qLceghiJjShkfUdDC6u87G1rcEVspx1ddQ6pG1bzZCWMDUqDBZoXncdwKswaHVSX4+ZB5deWrvZAUlqTlyOfiZnJNaWMdFvXUoYnWNnp7iHvcPamGfqxZwXPv5jDzKb1kYusAmjJU/Tv/O1dVsMy0Uy6+dsWQDT8hbzkWmhVcWqHgUfHoIAXgq/cFJprGbSShRRWfKsAqFGct48MJGP9YXshHt/JEgQdTnaCxYVCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10523.eurprd04.prod.outlook.com (2603:10a6:150:1d4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:59:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 06:59:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 07 Jan 2025 16:05:08 +0800
Subject: [PATCH v2 08/16] imx: imx8mn_evk: Enable dynamic settings to
 mmcdev and mmcroot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-imx-bootstd-v2-8-97671b1694cd@nxp.com>
References: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
In-Reply-To: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10523:EE_
X-MS-Office365-Filtering-Correlation-Id: e44aa1ac-3abf-4a48-f6e7-08dd2ee8cf0b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzdBQXpFY3JTUlQ2K2VUTkZYOFNOZzcxSUNCWnFFY0VXTmQxZU5iRFNlRGtT?=
 =?utf-8?B?eGVvdmVRSVVQRmVLZzNGSGREZGJvNHBoNTVDcDI0Y0FjUzhLU2JlRmhuM013?=
 =?utf-8?B?ZmYvY1R6RmJuRWlscUo2QjlsNTlsdW9qNUdZRGRLQlVkVHJsYUl2RC9JMnVu?=
 =?utf-8?B?M0RxMDgzVWZ0RVk4K3AwV0krNDJ3V3JSdVcrTGJPblF1TnNoc082RFNtTXRa?=
 =?utf-8?B?UDRrUCtVclpIemFqS1FQYjIzUXN0cjFic3B2cC9YWE1KcWhqNEMzSW5mcXI4?=
 =?utf-8?B?eU9IdzFOQmVvbEZ3dWJvZi92anV5WjU3SWplRHpqZGg5OHBkWHNKUDRXK3lq?=
 =?utf-8?B?MDVMci9lK25sRlhQbzFkVUliSUlzOE1WNXliZFlXVnVDdEtFU0NRS2tDcW1W?=
 =?utf-8?B?ZEJ2dWR6MVlvT0wyV2VaNU9pUVNUbGZ4ZnlCOWNLdHV2dVM0WnQ4S2JaYlRT?=
 =?utf-8?B?Y0g2OHZvQTNRcWI4ck41VlUwZyttYnBGbFArRkx0ekhUTG1rMHVaYWYreXFE?=
 =?utf-8?B?Z3JVdFQvTGVYN0hndXVmN3FCRSs2Z3hkZzBDdDRnRWNmN0VmNmRrT2RrODFU?=
 =?utf-8?B?ZjE0YkJwdnlUdlJ3Q2ZZbjUzWE1oaEJzbzcwbW00RFg5SHNMSDJWSkRlb29J?=
 =?utf-8?B?SjBYTDRMMDg3eFpaanhROGh2azkvMmE0ZnpaSytLc0Z0RlRnRUZDcFl5a3F6?=
 =?utf-8?B?dU9VN2lvMWhjS2Q0NHBlVUlzRVpPZVc3eE9TaHhoSUZXdThzd0JQQkpvQWpq?=
 =?utf-8?B?OVhNUkxuYnlhSmNlTVQ0ZXh6aWxUODZGVjJxWnRTbXlMM0RydUJ3TTBZb1pm?=
 =?utf-8?B?dVp3bi9hN1BJOWVxdTl6dVJWVXY1WnhVMlBFSTNsUit2WHY1L3ZDdVpzbG41?=
 =?utf-8?B?cmI1TVFCWFM5dW1EU1YvMllPM1ByODBuNnZ4czJnK20yZFpHZCtXNWhkQnUv?=
 =?utf-8?B?U01ZakVXZStVNE82aE1ZRCtLVlp0eTQ0UFdKMjNpZW13Ym9tWTBiMjhaam5K?=
 =?utf-8?B?UmFOaGFESTE3TjNUU2Y4QURSNmdjZWhzT1JHa0JsdTNscDZtOFYyV1JvbURZ?=
 =?utf-8?B?RXBCWEQ5NmtZeldLUzRxR0g5cmdHbE5DalpJdXJXWjlYRnpEazVDSktJaEl1?=
 =?utf-8?B?L3JzcVRDS2N5MThRekplWHFBa09ZSm5OWXVnMUo1Wm45QjNiYnYzWUlJM3VR?=
 =?utf-8?B?dkZEWTBRd25qWXRINFZPNWpQZnhSeGRLTkpIc2hXZEg3STErcDJrTHJqdTdO?=
 =?utf-8?B?MHNaazFVVGt1c2wrcVBQL3NmbXNucnpaZ1ROY2M4VHllV0xyQndiZllNMjls?=
 =?utf-8?B?Yyt1eDlzTmpHbkp6eFppS241bzZPMjFMSUZWL1BRZ3MyUkg0ekl3YTA5bWk3?=
 =?utf-8?B?alNKU2lCdzZIOWNveGFzL3BWR0laYmtZaVU2d2graTNOeWYwQm1uNnlKUFRJ?=
 =?utf-8?B?VmpWaVREY0tWR21LV28wQ0M1cTFYNlBpaVlhRXR1M290Wll3cmI2TGNsKzEr?=
 =?utf-8?B?a240NkFMM1pVUGV1TGMzc2diMS9Ha2dBQlVweXpJMWsybUFXZDZxVFhnYk1Y?=
 =?utf-8?B?RkxJMGk2Um9oRXJjMXY2M3NvT2t2bjVkdGZvYjV6TWJra3FvNFpkQkdpNXBE?=
 =?utf-8?B?NnVTcXJIcE5vSkg1WVNIdTNzcDJnSytPOEF2Tm10ZkNxdUlCTkNtMk1FMk9q?=
 =?utf-8?B?a0cyTUlnTzMyQ0RoeFdFTWFaSGFoNUJuSmF2TEhtK0Y4ME5EZWpRV0NiRDgw?=
 =?utf-8?B?NWJuWHg5REZpdUlTV3RRUG90Ris1NDZnTXR2dWMyRWtVbldrcmFvNUY1UkJw?=
 =?utf-8?B?NjA2cHZsRWhzQ2lISHVlZ01uVkNHcklXaGdDWFBJNEVYZWF3aFo2ZzY2cElL?=
 =?utf-8?B?NUt5M2hORThWQjlKbGRiUFdMZ0xFQUVhM1FmaHlPckZlcmRiUzlwdHYzMS9q?=
 =?utf-8?Q?uxXtzxvdS2FYL+gQjhnS/K+0pyFrMmmj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3FxMkEvbG0yc0FWZGJ6RUdtUkh6WDBmaVRyZVRNMmd5cmMveCtWckkwZFJJ?=
 =?utf-8?B?SG9zbzluaDQ0UjduaUM0M1kzNEVMNm1JWlE0YmxOcjFhdjNhNGxtOEZnUjM4?=
 =?utf-8?B?L1JhcllwOHM0bVVWeVZBMWFGY0lLV3JqVXhxc29TYnh4OVdlQTM4M1luaUlD?=
 =?utf-8?B?N1hGNkNnNmxVYlRtTkkwWWxSdFcwR2c4L3plL0VzbjRLanhFZlBmcVhrSktM?=
 =?utf-8?B?bmkyaExGMG1yT3czek51dHdBUGFoTGRFcXdkYUdmVzlHb09WZkhCWDlHWGx1?=
 =?utf-8?B?Q3R1eWdrTlEyN0UvcTdaNmZiWG5BQU9jNnZlWWw4RlEybWYvWmt6d3RSaklC?=
 =?utf-8?B?Tlo2WTltZWFCbjhMSElEemhRSDZSSVdUQXpjbzB6K1VPOExzdktuQ0tnUkZX?=
 =?utf-8?B?M1BoMTJhcS85amVDRVByOTYzdVhQUHNKZkRTV3VTYTdTLy9jZnRRcmwvV1Zq?=
 =?utf-8?B?dXlBaGYvNGRTTXN3aFpYUFg0VEhDbm9xbFJxUGdRVko2bGsxb0lma0p4UTcy?=
 =?utf-8?B?bUZCWElnNEpiVWd3bnM5MUhBQ002cDhyWUR2NzJ3WTloZTgrTUd4ek5yMncv?=
 =?utf-8?B?K0hNZDA2dUg3QXg3UWUzcE5ScGd2cEdGL1h6WVE0dllTWGk4QUFTdlp6Q0Ir?=
 =?utf-8?B?dUp4eUFOQXd4ZmZpYUZMU0RnUi9lT0dOQlozSWtHVmttc2RCaVZsZTRMbzdD?=
 =?utf-8?B?NU02bXdFMEtmeDRaSFlPOU42ZnVJYlhHbWZrUUZsUEdMeWRpS1VXaHh5MFhM?=
 =?utf-8?B?aW03Qi96MDVMaGxvaWVLalY0SlhNdWRkNUhRSHd5NndlMmFBZ2hBVFJSZ0Fa?=
 =?utf-8?B?RUZhYjA2SlE3SU9rRXNVZkl6aDg3Y1pleUlxWFpTWHE1WXRUMkFESkdia3Rs?=
 =?utf-8?B?SUNaNDVzU1pxMWxmK1labHlUZFBJa2NkRXUvL1d6UUZEOStQWWk1V2l4eDVz?=
 =?utf-8?B?eXRPbW8yNElkd3cyODhvcm5PS2t0bG1KQWFPNmY1RXhrVCs1Q2xPOURnYUhK?=
 =?utf-8?B?Q0RIdndpQTVUQkJ2L0RQR1JxdlRZVUxEMzE1ZDI2MWRWd01NTFZpQ1Q2Sitx?=
 =?utf-8?B?eXdhN2dZbjRvZFpsUTJxWmE0ck9XbGtTVUJHbFFDWjBxNEpML1lEdWFlalA5?=
 =?utf-8?B?Q21nWWZkb3FHZFZmQmpkRUVqWk5UenJDdHppSVRFcUM2MEh5VE1rQzNmOWtR?=
 =?utf-8?B?MEJFMS9vdkJ4ZGJPVkJQdUxIYWR2OTJUb3M0MG9xK0xpRktYeVRESDFQZzVF?=
 =?utf-8?B?NnJqZVJvam1qckZjQkR5S25mYk9IQ0VjaS8wUm02c1hRQVgxaU1QV0ovaDZv?=
 =?utf-8?B?YUx3NXlKV3NPa2U3dTJ3RHZjRzM5ODdIM2FkTEMySWlLV3JEMjN0bEFwUGtC?=
 =?utf-8?B?UjBzcTd0NldIUGZKUDIrRVVLMTZ6QTFOeFhvWUhTV3J5T0hsYTFmQzBIU1BY?=
 =?utf-8?B?ZHR3SGxlWEJkVW5EWVRTRFVyNlp1UFp3dklIYTFhZjYvUUdUZ1NEaU1CYkwy?=
 =?utf-8?B?S2VjSHRvYkx6S3VnL3g1YlNjdUErREFXQ3ZzY0JYV0o3dHZKQkwrSEpFRUp2?=
 =?utf-8?B?QWVQa1ZZYTg4b0NKYXV6cUJCY3VTak5UNmlHWFc5ZUlyS0tPOVpUdFpPRE5V?=
 =?utf-8?B?UWRZR2p4NzVNK1Z0bDhxTnJnWmNZNUlEZWFEMjZ2SE5xWnk1M0UzOGk4Zkdh?=
 =?utf-8?B?cUZOQ0FRQ2dmV1pIdm5UYzA4OWgvRXBJaElwZ0xKcEk4WTZUN2xtbitmL3hq?=
 =?utf-8?B?R3cwam5JaWhYWXFNQWhpbXZ4VE1ZY1Z6cEhscTkxbWowOXJFLzJ5V2gyMFdz?=
 =?utf-8?B?ZzdrRVAwYjBrT0w3NzhrRDJtRXZYL1NhVnEzTjVRNFN6cGkzbGVjVmF4cm42?=
 =?utf-8?B?QmhiOFRSUzBET3duZnJ4NGNnd21nSW9jR2kvY211N2ZzSWQzd3JSR2hxUjdN?=
 =?utf-8?B?ZHFERlIwWmx0MXg4UmhsMXB3T3JUb2FqOTVsQ3lydTBSTmJmYmZRc0tlZHRU?=
 =?utf-8?B?RjZBQ2lRQWphZTVGR3VVNWlZMXFUa1JuOVZVdGh2SjM2a1RmZWFPamJJMUJn?=
 =?utf-8?B?ejBlM1VxZ0RUeDdSSDdDckI2RzZvZjJiNWpQZHRtUnNQbmo1UWYyQzVSNHZ0?=
 =?utf-8?Q?2bdvoLb0YkAR4b1xbXy+bv8+M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44aa1ac-3abf-4a48-f6e7-08dd2ee8cf0b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:59:19.8446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hu1C+sSGt66klRYzjL/758jU4tfaHNPJ4xnztZE7oHIRXiDnpf9vEP7mZ4/xnmfET4z77LQ6SKu+9C7fpeumNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10523
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

Enable dynamic settings to mmcdev and mmcroot for i.MX8MN-EVK

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mn_evk/imx8mn_evk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/freescale/imx8mn_evk/imx8mn_evk.c b/board/freescale/imx8mn_evk/imx8mn_evk.c
index 1b9dc51978b555256532f22e1cfd317bacee5b37..c62d7a47e21b77918af85e966ac2bf8f58a75df4 100644
--- a/board/freescale/imx8mn_evk/imx8mn_evk.c
+++ b/board/freescale/imx8mn_evk/imx8mn_evk.c
@@ -3,6 +3,7 @@
  * Copyright 2019 NXP
  */
 
+#include <asm/arch/sys_proto.h>
 #include <asm/io.h>
 #include <env.h>
 #include <init.h>
@@ -30,6 +31,10 @@ int board_init(void)
 
 int board_late_init(void)
 {
+#if CONFIG_IS_ENABLED(ENV_IS_IN_MMC)
+	board_late_mmc_env_init();
+#endif
+
 #ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
 	env_set("board_name", "DDR4 EVK");
 	env_set("board_rev", "iMX8MN");

-- 
2.35.3

