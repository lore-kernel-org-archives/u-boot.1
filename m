Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F4ECAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 16:07:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AA3083914;
	Fri, 26 Sep 2025 18:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="F/3xsgRb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FD69836D2; Fri, 26 Sep 2025 16:54:44 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25A0083623
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 16:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wefP/F785aggIxtKqYiW5Q6KeuZEPF6IiSACK/FnB/LpTyNMX1BX/xK0JWQ9nMbWh/+eY9Osd2b1v8qXiaaDPpyBtXazjAoBShv3uz+qWJ3B+bsgbK8j8OFZtTcVKE7dRLvFI+e0AbvBqHtnVuhMpLDghz5m6CDO086rMvwnelO3CcbIv8ZUNFAR/gRRXpUoWvDpAm31xe4Ht2Isa77MO/LVBo/+r0NWO1NbZ1wsQ4xMoBpIBDBIqDRB0jqol3tIr3V1jurmO4D2rqypVfjU/dHFcvOpwUtF+FkF5MQvrjDRVIGCgjziw7yMtr9s6ckvl7wIvb6CL0MPr8Cue2ZJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YabknWBC56wXL1d5G31hLcDCAqtaHji2/uBxsI7F7RM=;
 b=u0RcXI+kQiOSjQqu9HUvEt75dl+TQErcIuGrig+VXgDFNw3MMj7Yf73Wp1VuFPzvfKiUxlAn9wRz/iZkty/p2/Z4QaAXRRqFA7bSHuKGE0HcKMy/qbsZC50+RQq1E4OAT+F/0gbKEN0Sc01AkitLulHo/tKQ/KT0kNQOQSUuoIppVT+Xy1kiheNNDwB4Gsn4e5CiTbdY3lr6hgMkQ9r7QC6OC2tAvJu2fXu6vsgtG7tEslkZjS2LfLDHKE/uPoHyXeihIeHr6mMlqauGyC4r3z+ybw9wp1wiufO+BMKl7S7gdHXn0IYmurJkmBCqkMr1QX3CdISA7dlmBkqtsR7DdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YabknWBC56wXL1d5G31hLcDCAqtaHji2/uBxsI7F7RM=;
 b=F/3xsgRbWzqPCYuTNEMgIP/69A15z40nHnY8nS7IFf1XSUH/09YWi2o0/NNTqolM70wBcuYao1bneNnL+r/K3AUcYLBezCmnMUog++4ojX3nBQbac+FbA3318OfzrcgRkrxPvy8bLH6syz4UhEIeDeWquW4YPmLqa695G/lzodK6oENb4n28EMg/8YDKj4B+dEr4ppyw+P5bRPKyyW+49Bxwq8zbfOsPftuW5GOGJkzxJ3LQ1Xo//ZjLj3/kv4TI/Ej2xmOPoOQ2t3F9o4xvhh0NJ4u/eYy1t90D4PK2+hXA54Dr8osXKpGV2pU1QopU7Yr50F+9Qdf+DgFq18WRqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV2PR04MB11141.eurprd04.prod.outlook.com (2603:10a6:150:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 14:54:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 14:54:36 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 27 Sep 2025 00:06:18 +0800
Subject: [PATCH 05/10] firmware: scmi: use PAGE_SIZE alignment for ARM64
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-scmi-v1-5-5e9354fb3bff@nxp.com>
References: <20250927-scmi-v1-0-5e9354fb3bff@nxp.com>
In-Reply-To: <20250927-scmi-v1-0-5e9354fb3bff@nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV2PR04MB11141:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d98028b-2669-43dc-e118-08ddfd0c9c73
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGtSVzFlbHN3VEtFWjBIRnFTTjB3MGlZbmFiZVdTdW5jZytocStQVCs5Umsr?=
 =?utf-8?B?YUR5NlJyOXB5VER6eEduM2F1SHA2L2duVGlCaHFHS1JNRHVYWmJLMnZacG54?=
 =?utf-8?B?MksybEZ4dWxOTWZpMTQ4d1dKSUVkSi9oRm9yZmppSUIzRTJ3RnNEa0VZWjU1?=
 =?utf-8?B?MzVPNitSM2MwaExZblNKNHEvM094bGtWU1dUb01YTnY1bUdGQ3k2TVBHSkc0?=
 =?utf-8?B?dzAvZnlzRTJLMUZkL2tLWk9iUDJZTmZhcDd2RVArcFdhRmwyU2VZbkFXVWpv?=
 =?utf-8?B?TDhWczNQejN3eUhMaU5KWTVRbHhES3hoS2ZuUVNIUFd1Q0NQcXllWnlTcVFJ?=
 =?utf-8?B?RDNPaXg3MVk4SHROaGtxVDlPYWROZURaLzVmV2dPeDNHSkRUSEVlNGRkTXlW?=
 =?utf-8?B?Ui9TMEJFcldodi9xSDUrQjhLODBaek1LeFNLVmQ5VUlrZnhUbWw1NlYxTGZh?=
 =?utf-8?B?OUNCWURKY3BOQWlWQXM4SHU4NTNaOTJNT0hLMHVreU9TaTQvVk9iNnpoaEdp?=
 =?utf-8?B?SGdJQ1d6TWtXWXRFZ1lwNTFGb0o1RkJxaXN2T0FEaFFGOVJ1eHFxb252QUI2?=
 =?utf-8?B?TmthSGRzVU4xaDBPMDVkcmVGS3Z2dUZSdFJCVkU0eDVTaTFIN2ZNbkttaUxq?=
 =?utf-8?B?dURWejI4YU5YYXRnemlmQmdIU1dYbkRQVWV1MUN5K1NrR3dxZEZXdDJHcE1i?=
 =?utf-8?B?aG10azk2YlVmUVgrYmhNSU9JeUI3VlhnT21NRGdyYmU0WHNSeWs5SENEK0Ix?=
 =?utf-8?B?bXluVkZBUjJTcXFHWG5Mc1FLRWc1dEJMOXZtd1F4VktJVFh3RlBOaWlhRENN?=
 =?utf-8?B?TzhkWStyN1MvR0xhU3NHamFIWGxPY3Q3U1ZZbHpiNFY0QW5uRXhrMUttcE9j?=
 =?utf-8?B?ZnFXTkFaSENGMlhCYThhQ3FNVTNvZjJYY3k4TWhYV2Fxc3M3bDgrMFZqNWNq?=
 =?utf-8?B?YktFUS9iVCtmZ0J2R0JxcXlYOURhNUUzUEY4RUgzVXVyeTJYTDF4UmRLWjJp?=
 =?utf-8?B?b3QwQVpPdnNNRVBKTFpvQmJvWVByS21VS1plYUpMalNwb3liRlFiT2VhSXBO?=
 =?utf-8?B?NjBWTzFpd3phdU1WenNCcWYzTVdELy9YOFFyYm1aR0x6UEtNQ2dnNjZQazEr?=
 =?utf-8?B?WGI4aDNQeUhRTDZib0JQVHRzY2ZDYXVEVVJWR1N5L0hHOXRjdU9QWXMvR2sy?=
 =?utf-8?B?ZXYxWXVTSFowaFdzMnBUOUtqSjBhakM3QjdFTHBZVkRDKzVLWVhwU2V5VkhZ?=
 =?utf-8?B?MFVFOEppRmtuZktuRHExUFhEY2hhS3JPYkFqeFk5cDFJWWdzV0U5WGZ1SEtq?=
 =?utf-8?B?OHpKV0x0c3hwbmRHZFdRcC9IZEkzTDBTUzlvUHJONDRGTXVuKzJRNFI3VXdL?=
 =?utf-8?B?M2hkVjlVM2RWVXVFUHZLakdoMzh4Y1VQNlVac2NCb1QvdUN0Rm5FdGNxakkw?=
 =?utf-8?B?Ti9Bd01vTDlBMWRiQXNHUHZ3NCsvTDRVQmRzeitKYno2Y28vK290bWszOHc0?=
 =?utf-8?B?THR4YzhhZmpjQU9jWmMzdjZJbWpEc0dVLzlWRmJyODNuMkVHZldQcEI0Yklt?=
 =?utf-8?B?VnR0Y0I5eUdBcUlHRXR4WHl6R1V5TUZhdVEyRUlHVEVBZkNsdmtqQ3B2K0Ex?=
 =?utf-8?B?a2plYjV2K2tmdExWRTZ4SDIrbUNHVEJRMVNwaUJxNnBiRm5oMlJURWpCVENE?=
 =?utf-8?B?cGt5dTVYZzhYK3IyTkE2azVVeE1NL0Z3c0ZHNG5icUJkSS9ZdTl1dWxoNm81?=
 =?utf-8?B?ek5DWXNueVZVRDVMUjEyRE0wenlqOUtLRVZLQ0thVDNRSEh4M0hBclpaTVlH?=
 =?utf-8?B?N1hQZXBLYTZId1BKbGRSaXpqWm9TUnpKMFdLL2F6M01ZdzR0L3lQMEgvdXFi?=
 =?utf-8?B?cGhpMXZ2aFA5V0Y1cTdQQ0NMWStqZWhJaXRTbG1qbzhwSnRXbzNBeUJDSnVB?=
 =?utf-8?B?V0I0UkdDaW1WcHI5Z3Q1UzVnV2pNSFp5NnZlOEk1VE1iM0JqRnB6cTRlcFpi?=
 =?utf-8?B?NThZbnpOSy9BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHdPbWZrUDVXc3ZPNzFsdG84Smc2SWhkam5NTTNwb0prRk1qNE5XcUV3bnNi?=
 =?utf-8?B?L1QrUFpOZHUvN3duRjFhbktqdFhWVHlieEtkMEQ0VmUrTzcyamRMak96cFFF?=
 =?utf-8?B?bVAxa2xCRzN5WEl6cnZ1YXJvNi8wUkRFTVlJdXhoZDI4eXRsVGdEUG5CblQ5?=
 =?utf-8?B?NTk0N3U1L3RzS0tzVnh3MjlvdHM5d3VnTXQ0dktTWW9CMk9LenFiOWozbEJN?=
 =?utf-8?B?dXJyYnIxQk10UjQ4SlpQQlRqbTV3aWN2M1BhWnZ4RjJXRjVkWHFvWWVlUnFs?=
 =?utf-8?B?YVJpTlQyZnYzOXBDTDVOSDRFeTFvUEg0am1lemVVaStYK0ZCTzR5QXFCelZj?=
 =?utf-8?B?dG10SXhwbnYvazRCejZPUy82ZTNTZ2pBbnFiZ1dnQnZOYlFkbkJrcTR1OWxo?=
 =?utf-8?B?YlBEeS9oem51LzREd2s2RlNqRzZTQ2hsZ0pnaGQyTVUxV1Z5YmR4N0FjOThO?=
 =?utf-8?B?NWZHUVFaMlNvSGVBKytGbGJGRGsrYXZic2k2OGZHWHkyY0VPa2hseVZ4ZzBF?=
 =?utf-8?B?blp4ZGIxRUgrZUE2bzByZmZuSy9JSlpvaW4wZldObzNkYUxPL1Vmb1Q3cGZT?=
 =?utf-8?B?ZmNuQVczV2hTU2JzK1ltZVJGdG5qYjJOL1BKYm9IQ05uY2NVb0lQL1Q4aDdD?=
 =?utf-8?B?aVJUaS85TlpkRUdXTVNqcFYzb3UwUzVta1VZWkJsc1l4UUl3NTJueGQwdHZB?=
 =?utf-8?B?R3p2cGxVcVhjTGRQT1BYK2hJUTR6S1BNM1hsbTZFZ2dNMzBITVM2S3ZEdXla?=
 =?utf-8?B?NE5FdWR1dDZmNE1LeEV2Rno2ZnBIZllURWlTdHA1aFV2OXpraGdFTG1NNGhu?=
 =?utf-8?B?QkZqZDdGZktkL3U4Wm5UZEQ0YnJpMXpCZGRBUS8veUNlUkdzNHhyMy9YRXk2?=
 =?utf-8?B?K2hXcFhqQnVkWU44eFdvdVJBS3ZUR0ZVQ2g1ZkhVeGJzSlZqUXFLNEtSS3px?=
 =?utf-8?B?dHptTHZnOWlTakdPSW81YUcwY1pxNVlmaWpacS9abXk5Rm5wWDFyemhSMWFH?=
 =?utf-8?B?cHBVVVRsWk8weWppZS9EcEJmZDd2VzgvSWdQaVlRUlYrc3EvZnZYTmpVK0Qw?=
 =?utf-8?B?STNOOXBTem5CektrdWYvRjFGUHJaTUVzeTBGbkN6OTdIejVVY2RuK2J3a3RF?=
 =?utf-8?B?UTM1bmZIM2pkMGJXSDFBWk1ydG5reWluV2tFdEtKWmxjbWxqMVpSbHo2WDlt?=
 =?utf-8?B?SS83cytoL3BVZ3B0MFhOUDZMeFQvNVNCdTFWMDEwYlRiTUs0dGVMMENYWDVq?=
 =?utf-8?B?UWJGb3Z5Wng3R3FqQ2dVOW9KZURzektMVEtvREpGL0VJSEJ4T3RvektueEt4?=
 =?utf-8?B?Y3BJVC9zNUl2S2E5c3c0UzhHYXUyeTVkaDFodzNhYmVFMVE1bFIrVnpMZVhG?=
 =?utf-8?B?TnAzWDQ3YW5tSG4xb01SQS93V0tOVmpuZmFKbUg4eVV6anp0bUgwY2Rjd1Q4?=
 =?utf-8?B?RitvbzdrVkM4OVcySmQwVlBFR3dDSFNvVUZlMy9OeXFsZVBsZS9kQnNUbTh4?=
 =?utf-8?B?WTJIZHJTeHJvN0dkR2RGc3p5bys2MEhoRjMzZ09YYlZucDd4U0M5RDdkMm9y?=
 =?utf-8?B?TjJZcHpWM3p4OGswYUhudnRaYkI3eDdWOGhpMi9IU0tPOEtoZm51aHlMLzFF?=
 =?utf-8?B?eFdiYWhPNitNejFGTVFrZmM0ZnF6MFFuUnBXV0E0RzNOR1FnUHVWa0c3YkNE?=
 =?utf-8?B?K0hQTWVuWTZEY0JNZnVMUC8vRWlnN21kQlg5MGhRK0FLdHlzZUViSUFyQW1V?=
 =?utf-8?B?SkRVeDFBeVN0TGIrT0MvSmFFZGVVVUZyMjJRWkNiOHJDUkdzTVdLdDhQSHFD?=
 =?utf-8?B?L1VmTHNIb3c1VGdOOUJzVi8zWUhaN0dCR2ZSMGtQVzBpcmY2Tng1T2dpNFdY?=
 =?utf-8?B?dnRxT1hhSEpEeDNBWEUwNGxudFJHeDB0MnJIWlR3c0lrT3JvakpXcG5oZHhJ?=
 =?utf-8?B?N1ROWnpyNzBDMXdGbEhaZUlKb1ZRSXN1cEQ3WTNHSDdzWHRSejhKa3hiVEhG?=
 =?utf-8?B?Z3V5cW04aUVpcDZLd3FwQkpsOFdZaEFUT2wxZDJnQ3o1U1piRWpuUzVNeXNF?=
 =?utf-8?B?My9BM0ZaQ1h2SG5pQkM0Mk1qU0g4aDNKRWtOVThMOGQ2L09vcTRSOHc3ZHdM?=
 =?utf-8?Q?YFYPm/Rpo16ZzMgJr3mstN8Dq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d98028b-2669-43dc-e118-08ddfd0c9c73
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 14:54:36.3993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JW34tE9VAHjG7GUTd03Q4c8xKYbJmozxFiOOgCb1QRfonlVcW1g6L/ysaUvE/iLZDk324WZ2QyUb9ii8V76vtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11141
X-Mailman-Approved-At: Fri, 26 Sep 2025 18:06:25 +0200
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

For ARMv7, the alignment could be SECTION size. But for ARM64, use
PAGE_SIZE.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/scmi/smt.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
index 5eb78387344dd874fe3cc3fea38a0586ae149ef4..237871559f01b4ecf8079f943b666000d5059535 100644
--- a/drivers/firmware/scmi/smt.c
+++ b/drivers/firmware/scmi/smt.c
@@ -62,11 +62,17 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt)
 		scmi_smt_enable_intr(smt, true);
 
 #ifdef CONFIG_ARM
-	if (dcache_status())
-		mmu_set_region_dcache_behaviour(ALIGN_DOWN((uintptr_t)smt->buf, MMU_SECTION_SIZE),
-						ALIGN(smt->size, MMU_SECTION_SIZE),
-						DCACHE_OFF);
+	if (dcache_status()) {
+		u32 align_size;
 
+		if (IS_ENABLED(CONFIG_ARM64))
+			align_size = PAGE_SIZE;
+		else
+			align_size = MMU_SECTION_SIZE;
+
+		mmu_set_region_dcache_behaviour(ALIGN_DOWN((uintptr_t)smt->buf, align_size),
+						ALIGN(smt->size, align_size), DCACHE_OFF);
+	}
 #endif
 
 	return 0;

-- 
2.35.3

