Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B800CAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 16:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0318F8390D;
	Fri, 26 Sep 2025 18:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AW1scEDp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E00B483666; Fri, 26 Sep 2025 16:54:46 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E56D0835B9
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 16:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lt7ymp4PKPGjE5qrrgyG0GwgQJUWRWPErhNU9p55GPJ8JyWDGLPxfgXNttZYAxdoUuUcWg1/ARgOux8GgEM1O7E0ACQCKTDQmqM1GMUwvHbBPTFBMS4Y+7j5P8aZIZqLZP8GIUWrav6OqyrbEkkRR2vpCcvN49pHFc0+BYB8wUKkT7HqaMZ7M2nePcIEz1KKFoHwTJ4bICPzuAEJduh2aDdIj8Je216DQWNEj5Hy/sPqxtPrWp2A/JcHgpKb0Zjc9gGyziN3AxZzrSjoi5RgVEbWOE7rnInu44h9dKAHAKDFcj+fmWA92M8pZTnPr97ttn3/GSZFAy+vRF9r9ZxYOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvImmg4bIaKRcTcMDjskUkXLm5MSouB2G8w/uz44RUE=;
 b=yGkqj0Mq6STQXzefuo82QyqEorHMfHcDUf7pUFv7hos7I5UMHMHPLAoI1DN6iySYKoBDd+LEZW5DO02KfB7KdvTuYfTW44Icv0WYHaqXQs0DpSBdOldZtK2wKebHhQheMUG9tt2D4PsCaHMF40u2Q/eMK2l+a1IsKcAgUdy789wuyPwJ6AgvOLB8HlrfAlIxuBp7AMiaLtw2D66aa95lAuKpIQL5SrmVTOlC6KVRdQdNG5b804DpVkgKYxR/LFDAzWns8q1BCEx3JaNeBTr6ZYE4LGWrQDNm73b9+BJzebiWciv4CLWTq4xDcpsjBhdfoQoRA+nCj++FlaL4QqLRhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvImmg4bIaKRcTcMDjskUkXLm5MSouB2G8w/uz44RUE=;
 b=AW1scEDpFpIdMtPV8sfi6Qr72B7jchzgZhrNjlHK7dSyahX8DOaLVFxyLRy2OfYyOrk57WLcTEFxa70sB0yQ6efW3WeHncqv24oUlSh6r1hZ1LldUexxW0qHSuk8G5JuwGXJGW+TMcysuPxtFClKKr4tE6bs3OKQzbad5rmbe8GerSQzf5J68UB+7tsQJ/fp4H44O32UYHF/QCMMnortfETENoVpGFnuHq4uu3hb0FIl5E22cEOlLNYXgdExUwxbpO7w1/kDmQ60W/0segEdQzf6wuq3px6LzNaVIBDFJvDtZHsxyrUlldqQSzNGvnjnPX1+24+09C7sQK9dI3NGcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV2PR04MB11141.eurprd04.prod.outlook.com (2603:10a6:150:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 14:54:43 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 14:54:43 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 27 Sep 2025 00:06:21 +0800
Subject: [PATCH 08/10] clk: scmi: Replace log_debug with dev_dbg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-scmi-v1-8-5e9354fb3bff@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5325be1c-8641-479a-49bb-08ddfd0ca05c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXZ1NWxUdjJ5Yzd3bGU2ZUZvQmNMZ2dGMzZScmk0SksrY1lmbTJmUkovdTBD?=
 =?utf-8?B?TGpyeEtqOUloR2ZwdWlsSk9XUUMwczhmZHZLSFBobTVRUmRzR1RlSDhld0ZX?=
 =?utf-8?B?MlVFVDE4OTBFNXBxeVlKbE9GdGZsOW1RL2xYcXhSZHpiZ2NORG5FYWtVSmp2?=
 =?utf-8?B?aGk4bEQrN2lGbFR0a09tRlBsZkl0TEdoR1NWU1M5NmR2WU0wN2ZJOGRhek13?=
 =?utf-8?B?a3c2OERKVkRDN2Q2WFQzSWZCY05UbVBsb3JiNkJIK2RNcDFUcGJLalNKVTFV?=
 =?utf-8?B?SWwrZFNZc3JlYUV1TVMvMzZKcmI1RXdkMGROWWVOZ1hISFJXc1JhalZCWVdM?=
 =?utf-8?B?WnNFK1NGYjdkdi8xVXo1S3ZLQWUybEFKbFN6VElSRUtHY3hEQ1NKTEVteDNN?=
 =?utf-8?B?eERlcmZjbEg5NzJSTm1aTEVBNnhHaW0veGYzN1dVOFhvdUdzejNCcE1mbGVR?=
 =?utf-8?B?U1Y1MS9rYVNleUIyWlZFVVNuRDhrdndYWFVRbEJZNml6MGk5em5nTkJmTEdR?=
 =?utf-8?B?N25NQkJuNThiVUp2b3dQcHJFU1BxSkp1QmJpVGk1a04wVzFnYjl5U2c0WXJC?=
 =?utf-8?B?VDEybFlIWE9UTE9adDFnNHVJbWNmMXNIdWJ0SmQ5ZXljNm90bUlUUGpveUpN?=
 =?utf-8?B?a1dobXBaYVVjbnJGSDZlSE1PUEx2aTQ3VGxlTGI1ZFIwU1ZCRUhjeFZmTmlD?=
 =?utf-8?B?UzVYMnlIbUpPVmpYYk8wdVROdDg3aXlkTU56OFJtdyszdWo5VjNpM0NxQlAx?=
 =?utf-8?B?OUN1WTVsUHo4NTNRMEJ3SEFUc05hR09mU0JBT0IrZW1hVTJ6WFVmdC83Ulcx?=
 =?utf-8?B?MmxIRHljUXhTa3d5TE5HSDd2RUMrN3JIT080b20vM2Y1TEdhaFFHbXduQys2?=
 =?utf-8?B?WERhTVArNnRBcGRQYkdJTmFQUG1GRFhQcXVIR2lPdlkyVjFPUmxSVVlLT2lj?=
 =?utf-8?B?MWJnTnV4Mk5kdFg4QWZna3FEOEhTVDVJZGxIWHR0NHVweDZRTHo0S21YZ3dD?=
 =?utf-8?B?TW15TmEvV2cya0x3a3RsNUFmRlMxVUVFRHVlNWJwVTJkS1RmWEtHb2NpMXJ4?=
 =?utf-8?B?YmtJREhTTXc5RGtOeURVZlVaZlhQUm5FQWNhSjJ6Z3lISCtWNzVROFBkTkg2?=
 =?utf-8?B?c2VaMzEvR0ZaK1l4NmdZM3JXN1RaS2lPRzlmZnNMV0cxQS9KSmxsNWZIUzlm?=
 =?utf-8?B?RFNMaGRCZWhCem1PcGYwdjlqN1ppQUlPLzdKelduNlRqUUlobmFkamxzVlZH?=
 =?utf-8?B?Vnh5MUNDMXFJaFdPUHNZWXYwMEdOVUJjYkp0a3AyZnQrRGhwRitlMDg0N3Jo?=
 =?utf-8?B?V1VUVFQ4L3k5R2tvdHdaeCtwYlp6SlQ1dzE2eHdCREU2VFBYRUVEYksyd1kr?=
 =?utf-8?B?ZmIvQ1E2cW5PdzBNZllOVzB1enNTbzZlcjJicUVMNWJTVWZFeFFDazlIVUZp?=
 =?utf-8?B?QktGV1Y4a05VU0lYR0w0Q1U0NVpRayt5ZXlBeFdSY3dXUUZ0OExGdys1eDZE?=
 =?utf-8?B?cFZvUjFHRXArNVE1bEZRQjZCOENjcDJsYkplVk9PSmNXV3ptQ3pKcmJCdVJE?=
 =?utf-8?B?NXcxRGg2eUNuRlVYL2luMW5wb05HR2tXZFloN1lZa0tFaEMzYmhRS0FTVEIy?=
 =?utf-8?B?cWIxSjA0ci9VUEFkZW56azZIRmswZVI0ZVplZndIclhadDJIaFNhdjhqVzdO?=
 =?utf-8?B?bG51eVJJM3hxZ0Ntd1A1Y3Z5b3EzTkxUVFdWRVN1azAwSVc3R3I3QllQNGVZ?=
 =?utf-8?B?SmxwcnRlclNzN29MVzdpTUdseWhSYmp5ZHErQUNRRmJ0NWVldThsN3I2bnhu?=
 =?utf-8?B?OXRMTTV5SVdYUHlNWE42QVVaR2pSQ3R6Tm9OK0g2Qk84UW1LUlRaZmpGaTJY?=
 =?utf-8?B?d0ZCKzE0aHVsT1J2bjduZ3h5cnJsWmhyem4vb2VtR252TFh3NHpIcXpEeTdW?=
 =?utf-8?B?R0hXNlZLcU9LdHdiS3JCekw4dnZzWlJrdHN1UTZmVCttZVdQYnRyeXIxbGhE?=
 =?utf-8?B?ZGpwbXg4REp3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T04vSFN6T3VidkZldHVYcEZ2Y2gzRjgzaE9CK2pHTDRjaE92Q1pVRG81Q1dx?=
 =?utf-8?B?cVE3aEJVbW50UVFOQkpLUFIveFFldWc2dmp6Wk5XRVl2RU41Z095MEQrbUli?=
 =?utf-8?B?ck85WUJFOHhPV3lUV2FKakQzeE82TjRjSHpLdWJMSlpnL3lPQ3ZHR3E1VUxr?=
 =?utf-8?B?U3k3dG4xc3lGMlpoUjc1blR2TlFtYkwrWmJNZVBCUDNzR2FXbWNlR2pKNFp1?=
 =?utf-8?B?c2UzYjNSWllRaStRRUZ3SUhIbER3OUVBdWd3eXgyNHRWWVJndy8xYmlyOFd1?=
 =?utf-8?B?aXFLdU93b3VVTi8rZjRmWXRkT3BTUXB4MnhsQUE1MUErTDFBaXJ0dEI3aGZO?=
 =?utf-8?B?Z0czUDl5Nk13YnZZU0pBMmR4djB3RFVMZHVqeE5IU2ZuUGV6TklGZUpkejhI?=
 =?utf-8?B?S3hGZEgxbGhZbHFmMkRLN3Njbk5RVkU1bFp5VUZ3V3FpcW1xK3pPdDZ0a0U3?=
 =?utf-8?B?V3NuTVBmV0NBcVFQOEJHMmREbEVydzdpUmJIU0V1V0VWRzAxQjRMNnl2T0Uv?=
 =?utf-8?B?VmFHRVdGK0dCWmRXYWl5RlZOWE02UGFkK0FWWG5KaFVxOFdhUlN6cmFPT3Uy?=
 =?utf-8?B?L2xLeHdwREhTMkNEY1ZOWlN5dTVOVmZMbTJxV05CcEE2L3FoRmhJSWV5RDNL?=
 =?utf-8?B?ZVFkZlpsdHBIZS92Yy96Zmw1WGJuVWFQVHV2aDZyZzNJZ09uTkpUNUFXVVRK?=
 =?utf-8?B?WXFFR2l4bmRSczJBdnRIL3QxV09kUUVhNWE3OEJhamxtT3l0eEZvZlFJQnda?=
 =?utf-8?B?QzZYekZiUWJYNjhkRTVQbE9IWGRodkZVZHo5bTN0MFBKbXBKWFdINmpJRFlj?=
 =?utf-8?B?b2RNS2dkQ2cyTWlYdEVuaCtCK0Q5M3FTQTRURzh1Y1E0eVZBbzVUSWlPeXM1?=
 =?utf-8?B?MXVJRHhJRVR0YnBBSEJSNXdEZWdDOHY0aFhDbS9DWmJra2dFYjcyZm0yZ0FQ?=
 =?utf-8?B?bG84YmNpZ0M3RzRjUFowbFpFbXUwdi9hdU5tVkFIZytaL1ZDd3Y5VSt5ZEhy?=
 =?utf-8?B?RUxLbU9tMkVOTG41YkhWSC9mZWFuTTZERVovUlcvSXZrYm1OblFJeS9LbnZV?=
 =?utf-8?B?UGh1V3Zkdk1kbndSUEtTOE1oUkVmTktNK2tNNFF5UWJwaTQwMmV5cGswUmtU?=
 =?utf-8?B?ZllzWU1IL2krN3BZTVFQcHIxRHZDc21FaFVrR2JhZVpBWWpELzNWUVRMOHNT?=
 =?utf-8?B?c3k4RlpMUHliVm1ybmRlRmtiZUlOT3dOdll0ZHBSZkRablp0TlY2VlppYXI1?=
 =?utf-8?B?d2pSVmpxemRhTjBTb0JxWHkxdjRpaTlpSjJxWXpNUXJxZCtEL1J2UktZQ0Ni?=
 =?utf-8?B?RXNOWk9neHJZeUtHbG5ickNmSUJDRmR5c0QzT0NreEpBYTJGVU9xTXdTZE5E?=
 =?utf-8?B?TW9WWjRQOG9lY2hKWnp1b0hCOTNPRmZBODNxOE9Hck0rc0JCN20rVVBSbFl5?=
 =?utf-8?B?U0xtcit5aWhET0x5c0xkQU1TcjNYRDNqUlFvNDVRbFgvU1dpOGdVVHRaeFJN?=
 =?utf-8?B?ZXdaMHVEQVkrUEpVMS82b1VNeWVsQ2xZRHFicTU3OU03cU9JS3ZWWTdDM2ps?=
 =?utf-8?B?MkFRUStKdU42MHBySlNDUHFralBJYUpvMVM4Q2ZlYmVHeHN0VlZQMXFUWjBE?=
 =?utf-8?B?eEFmMG9iY1FCSUltN2dOQTJNRXVrODgxSEU2bjdZUTB3cGZGTHhCUXB5dDR5?=
 =?utf-8?B?aDhtSE1YbVVYSFVwSHZkVmkrMWJNZHRaLzZWRGxLcUxPOUlleGVoNU0rRzEv?=
 =?utf-8?B?b05WbWhCSW50SEJCeHNjdW5xZC9lbTlIK1VWYXdSaVFJenJLVDFiZjZFdlJW?=
 =?utf-8?B?Sm54eUY5ZDBqYjlFMktVSnMvS1lHRlVUOG9vdlhjMmVxZzNNdTQ3a0xsZlVD?=
 =?utf-8?B?V1B2TFQ4cGZRYTV4T0pkV0d3azgraDk1UU5JR0haYUZDbE9yeEphbGRQWFRn?=
 =?utf-8?B?SmJpS3Iva0t1dFRManc0L1VJU2VBTWJrZUtwRGdGZVYycm1lR3NGSUt2dmc5?=
 =?utf-8?B?bFk5VGZpS3ZuQUZxVFBzNzdHM1dNOU5IWG1STUV5bk9DVm1iYkdIcmNYUW5L?=
 =?utf-8?B?SW41MEVrWWxLTmYxVDRlZUxMNVZOa3RVN2orS05UUzZ1Z0RMcERGTzRtNnFi?=
 =?utf-8?Q?t+ZHpwA+aQIrqCUbVhnyd4CF+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5325be1c-8641-479a-49bb-08ddfd0ca05c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 14:54:42.9738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZbzSPce6VF2Ssig7fBmwSQjcMKK2cE5fr7a5CKMvu+5U+q0Pig5OMEhvwwOxJjd8JIR7sDIccOTg2HsZMXfGeg==
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

Use dev_dbg to dump device name, dev_dbg also a encapsulation call
to log() and print(). So it is ok to use dev_dbg.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk_scmi.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 0c9a81cabcc863ba91f1076b4e7f14f84af5ca2e..a7d89f32cd7c97a0ede1995612ce0b7302d06392 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -7,6 +7,7 @@
 
 #include <clk-uclass.h>
 #include <dm.h>
+#include <dm/device_compat.h>
 #include <scmi_agent.h>
 #include <scmi_agent-uclass.h>
 #include <scmi_protocols.h>
@@ -41,19 +42,21 @@ static int scmi_clk_get_permissions(struct udevice *dev, int clkid, u32 *perm)
 	};
 
 	if (priv->version < CLOCK_PROTOCOL_VERSION_3_0) {
-		log_debug("%s: SCMI clock management protocol version is less than 3.0.\n", __func__);
+		dev_dbg(dev,
+			"%s: SCMI clock management protocol version is less than 3.0.\n", __func__);
 		return -EINVAL;
 	}
 
 	ret = devm_scmi_process_msg(dev, &msg);
 	if (ret) {
-		log_debug("%s: get SCMI clock management protocol permissions failed\n", __func__);
+		dev_dbg(dev,
+			"%s: get SCMI clock management protocol permissions failed\n", __func__);
 		return ret;
 	}
 
 	ret = scmi_to_linux_errno(out.status);
 	if (ret < 0) {
-		log_debug("%s: the status code of getting permissions: %d\n", __func__, ret);
+		dev_dbg(dev, "%s: the status code of getting permissions: %d\n", __func__, ret);
 		return ret;
 	}
 
@@ -167,7 +170,7 @@ static int scmi_clk_enable(struct clk *clk)
 		return scmi_clk_gate(clk, 1);
 
 	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
-	log_debug("%s: SCMI CLOCK: the clock cannot be enabled by the agent.\n", __func__);
+	dev_dbg(clk->dev, "%s: SCMI CLOCK: the clock cannot be enabled by the agent.\n", __func__);
 	return 0;
 }
 
@@ -190,7 +193,8 @@ static int scmi_clk_disable(struct clk *clk)
 		return scmi_clk_gate(clk, 0);
 
 	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
-	log_debug("%s: SCMI CLOCK: the clock cannot be disabled by the agent.\n", __func__);
+	dev_dbg(clk->dev,
+		"%s: SCMI CLOCK: the clock cannot be disabled by the agent.\n", __func__);
 	return 0;
 }
 
@@ -260,7 +264,8 @@ static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
 		return __scmi_clk_set_rate(clk, rate);
 
 	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
-	log_debug("%s: SCMI CLOCK: the clock rate cannot be changed by the agent.\n", __func__);
+	dev_dbg(clk->dev,
+		"%s: SCMI CLOCK: the clock rate cannot be changed by the agent.\n", __func__);
 	return 0;
 }
 
@@ -291,7 +296,7 @@ static int scmi_clk_probe(struct udevice *dev)
 
 	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK, &priv->version);
 	if (ret) {
-		log_debug("%s: get SCMI clock management protocol version failed\n", __func__);
+		dev_dbg(dev, "%s: get SCMI clock management protocol version failed\n", __func__);
 		return ret;
 	}
 
@@ -371,7 +376,8 @@ static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 		return __scmi_clk_set_parent(clk, parent);
 
 	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
-	log_debug("%s: SCMI CLOCK: the clock's parent cannot be changed by the agent.\n", __func__);
+	dev_dbg(clk->dev,
+		"%s: SCMI CLOCK: the clock's parent cannot be changed by the agent.\n", __func__);
 	return 0;
 }
 

-- 
2.35.3

