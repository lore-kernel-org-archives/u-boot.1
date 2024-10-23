Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0BCD2E00A
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 03:00:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EA19892EF;
	Wed, 23 Oct 2024 05:00:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qBr8ZByI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B45892EA; Wed, 23 Oct 2024 05:00:21 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B600088AB2
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 04:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/i79qeI9GJanEAnoe2kypuVwYs568lsAdw+4NszgbWvcwvRt9L/q4q2YZISwHYr8nlpXyF8TU6mG4J5QKCAelOp730MhfRdmvSoI6HQGgBqv4d+h5riM1J+dzGDIcHoHcZ0QjwmLSVUdiogsxZogOMUojs/di1EkzGMc//0Uu1sYlcnrG5OIjCh1/8ClQe7zYCRMEoSd3dRkKzbfEH17QasG2BIfwrePgJHO/s5MNe/81YEV3Hu6rWARXpIsMtdYn5eeuVHwthoLVqgzmBevaLEtd5XYx36VvQWvEhPjBMX2sWdxVAWNSMyWr1lvhGqOIS33bhOTo42cFAEO1grnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5PJFvdc6WeXfIsqhE9JYb/m3AbyyZplWcKzPeBX2jI=;
 b=uUJT1VSLu9jxOPmDJWUBDqPWtGQj+TNuYcNw0GvXntWS5/N8aW8o1Btv/Nvbjs/Y/Qgd5QT16+L1RdTJNBamI+7PJM+Yss/pi0ecf/KEeeMiPq9F1by72e5FFtI0pG0ow+7V0IXvO6V6MxRDVC2bmLNbDMYvUL2CDETagLbY+gfoHrUWTEjck+Qq2rrbZnsTjGf/9E8hBr4sTNLYZM9iDKB5E+1y9XSqllpIiapdWD91CI3CQt30fF8vdgEiOOl47tDVqHgTDok8UylOqAk+1yrb8iesrpXZmekbESiLRWKJRmSW7e2ZSFKLaKrjvi2kzxZ3o8FEDL17Q01I/4yOkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5PJFvdc6WeXfIsqhE9JYb/m3AbyyZplWcKzPeBX2jI=;
 b=qBr8ZByIidGvY+3SKAOhzDUcI3pXIDeBzaRGIkdtfdEhQzCXdHaDQ+wS1CfuEprUiiYtw/sZFLCefD8QYl4qNGb8qsGcWLFuE1bu9M2HYS/6rgfLuazJX5bM7zRFKMpLpthN6rAWL1SK9uF5Nhu3wxq2EfQD1J54WKuHkR648yOp4411uxqlRrGFmLZwYLul9aaniTTogWT0SUsGVASnxm7Sp/41BFc3Y4rLQ9TKXBOqvNLqikhsmP7iIQKQ0XoWJsx/qsgESBt0kOAihjcI4njVm7TOyfr1qiES45XT8/SOWWJftzF/vYKXcH7zQ6EbwiLORrFZm4jrqpMz50u6dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8956.eurprd04.prod.outlook.com (2603:10a6:20b:40b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Wed, 23 Oct
 2024 02:59:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Wed, 23 Oct 2024
 02:59:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 23 Oct 2024 12:03:16 +0800
Subject: [PATCH v2 1/2] imx9: clock: Add 800MHz fracpll entry
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-imx93qsb-v2-1-1843ab1a4d5a@nxp.com>
References: <20241023-imx93qsb-v2-0-1843ab1a4d5a@nxp.com>
In-Reply-To: <20241023-imx93qsb-v2-0-1843ab1a4d5a@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8956:EE_
X-MS-Office365-Filtering-Correlation-Id: 7318e0f1-0f27-40fc-405c-08dcf30ec6ea
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWhOcjY1aGhJSU9qb0hTdmkvUmJRckZJNUlqUzQ4dkxLZmI4YTdONEwzRmVR?=
 =?utf-8?B?ekJxTUMzcTFrUCtuSnQrb3F6aUhtVlNldkx4aW9GcmhmU1J3V3pwQVMzc0Mv?=
 =?utf-8?B?VFNvZExIOEhUbFcyQ01XRFpESy9TYmtWZ2J1UkJPSmZwVHFwZ0U2RnNxRnJX?=
 =?utf-8?B?UzJFYlQ4a1p5eVhEQWlQZGpzWVNXd1RQdlcyRExWOGc5TVNsYWNhN1A3Mml3?=
 =?utf-8?B?dXJhK05RYWxaVzBVdFZIZllxS3JiS3VXb3ZaeVJLRjdNV21reHhzMmhBU09W?=
 =?utf-8?B?UFVlNDhxZTlTV2RQT2pDTlRINXo0d2Y1Tkdnc0pHRzhoN3p3dTZaY1FzSjQ0?=
 =?utf-8?B?UWt1T3RIbWJ5WER5WlJ4ZEI3NHJrMlVpT1FjQkkzVC96RDJyMG5VZ214SW11?=
 =?utf-8?B?YlVPaDY3Tk9FTDYrUkhtRFMzU0N5bSs3WXZBVEhvY0MyVlF3Z3lwRm5wS2RL?=
 =?utf-8?B?RlZsKzVYOWRnZVVVNFFNajdwa0M3KzVnOXFLUnJTdzBxTG9aTzRiQWFjMEV4?=
 =?utf-8?B?WlhaZ3VNQmR2SWdTYTRFSjhXRHlCcGFQZnBGNnI2UXNodTErc2xEdExCcDg1?=
 =?utf-8?B?OEJqcHpqOTFGOXFjMmRmMzFMbWg1c3VDQUVoNXdrYUNWU2U4OXVDN1YrbWJT?=
 =?utf-8?B?ZlZ1cnZUUkxJME1VS3RhQmxNTzI1OWkrbURNZVEva0t4bGJwbE9OYXFoc1ps?=
 =?utf-8?B?UEpqMDZHQ2t2K0hXNG9jR3Y0N3R6MzJ4VWhxMFBsZnRPakFaUDlqTmZ3ZlV6?=
 =?utf-8?B?bVpFU2FOcncvSXpuUTl0TWdTSEVVRlkzbUhqbzJCQ05mK3BPU09yMUd5NzZO?=
 =?utf-8?B?VmUvejFFWlFOTk9od0pWVDBka3NuQkF1b1F2ZDV1S0F4eCs0a0Q1NVc4akdJ?=
 =?utf-8?B?WDBFenAzMUIvelFsSGVObUY2NEhBMmI4VEQ4RjRMMW1UOHB2cm5EKzQrM3JE?=
 =?utf-8?B?ZklZUHJaZkFxVVRxbXVhR3dyYUQ0eUorNUtXNzFPRjFXWEhxUnh6NVk1cjdk?=
 =?utf-8?B?bmROV1c0WHhSZ0I1blFpRWNiUjNjaU43bWlXamwwWlhKelM3MVFmck5lVDl5?=
 =?utf-8?B?d2VYalFDOWhxSzY5OUZPM1V3MlVTTk0xVU5OU05HclB2MWVzMDdFWXZZYVJ5?=
 =?utf-8?B?SExYYkFoTmJFdS92WGlBZDFvbk5vMkczbkoxYWtUdE94V1ZXMnBqazE2U2M4?=
 =?utf-8?B?dGE5c0VvRWVORGRiWjYxRzZ3Y0plUXZoOHcyU0pWY0Z3WWs3SVZMcDdIMlpB?=
 =?utf-8?B?eGphNXJWalVYVk95QTI5RXVWYnNZY2kzYUNzWlRHU3dBZUIzT041TDVRYkhw?=
 =?utf-8?B?QnZzS2E5VWdqMGtuMVV5cmNHSXJ4dDZ6WmxXSUVPeHBxVXhHT1VHYlFxSzVk?=
 =?utf-8?B?eFpFRHFVVEM3OFA4bWh4aG51cG1HWDdRdHUwVkJwT3JYWnRGOURVRXIyQ2g2?=
 =?utf-8?B?ejBTSVJ0eEpCVE8rNTJMYzFLMXltNHQ3KzN3WXpZQVI5NUR4ZWx2ME4weG9O?=
 =?utf-8?B?emdENTZYNmdza2RDdXhEVEorTkdNU291Z1Z3OW1LWWxRODRsZFNYYldMc1VV?=
 =?utf-8?B?Q0F5aTdURjNwalVKaEVudEgzT3RLSVZxMFhxTFJkeW9ZQ29VYkh6MmxvbnVi?=
 =?utf-8?B?akJpYmlGcENCSlR6R255aEE0NlRtMnZsRXcxTXNNQ1B6RGJHME1ycEEyd0E5?=
 =?utf-8?B?ZFVFdFQwZ2ZlUnY3SGhLL3J6eUxsSjVvWUxvUUJCWHh3Z1RBQzBCUVg2b1Qy?=
 =?utf-8?B?QitUdi9JbU5WTFRVQW9ibGZuVmhtVWV1YW9kV09tN1JZN0JndU44aVVlRWNo?=
 =?utf-8?Q?MCSi4cjej1zJjHRm0EmeNvEMVCRDEbdHZimfE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2pmSXZZUVRUMlBFeFN6N1dFMDhwcWdwUjY2THJhV1NRZ1hWbVNaUVNTbVBT?=
 =?utf-8?B?NmdMSTB6R2NSSzRSc2FKcXNHZTRJTmNUN0ZTZHB4QWZKVHpHbkVKWktrUGgw?=
 =?utf-8?B?OGtacnZRcVdZMXZ3cnVmcCsvT1VZY0l0VXFHcE42c09JSVhPSEtJbzVqQTJ2?=
 =?utf-8?B?MHZ3cEU2T3kyT0VMbmFEcFBQSXd2MGVhNkQ4U2Q3TVBJWVcxQjViUVp3aDNz?=
 =?utf-8?B?VFNURGYxMmZVNjJvTDVXZzlkU1lWWGl6a29zdWJuTUxwQmVMOHBHcFlwQWk3?=
 =?utf-8?B?RXNMNWhON25sWGdFNlpiTkRkZzQyRjF2Y1NINmo3T2NjMHpTUDl1allQc2hO?=
 =?utf-8?B?UC9uK05BL0R3MUxZaDN4QVZOa0plaXlyVEJNUjBnM3JReTEyUjZZQkJVbGU1?=
 =?utf-8?B?YlRrc2MrL1Q5dDBza0wzM29GSDNoRXRSOXdkQnZveXZqVGV6QXZiQXNOS0RJ?=
 =?utf-8?B?S0QweHF0dkVEY21mMTdsMDFEdkEvMy83ZVM0UU9xb2cxSksrNDlpaU9KRFkx?=
 =?utf-8?B?L1JaMHFPa0xxWWZXei94THhQVzBlZXY2L0djbytLS1Jhd3V5ek1ESkEvUFJK?=
 =?utf-8?B?U2VwUzRXd3VTck9QbmNsbzMxdHIyRVU3b3VYQ0ZoaXhvOVhyelA4RUw0OUt6?=
 =?utf-8?B?ZlVCekpjM2xuQWxJSHJlQm91ajJSSk1kM2FzMlVoTFJqTFpRdlMwQmVERkRu?=
 =?utf-8?B?QmFYQWg3S3ZoalZ1dzZOcGRmTHIvNm1OTkp1RHgxWmpDOGU5VmlZVXdZSVRU?=
 =?utf-8?B?S1I5enlMSXc1amhsTFBoTHczZ2hpZGZ5eCt4WFhjYWhOallFNW9meFo5cE44?=
 =?utf-8?B?ZFV3MXAvcEdSaWRjb0dsT0JxTEFWcVozWXM2VmtLeUpEdUk3T29IQ3M5RHVw?=
 =?utf-8?B?L1VwNnpFdkhScGc1RXZldUlQOVJJSmNHVmVPMzAvTlhEZDdlNzFCME5YVTNG?=
 =?utf-8?B?anVCSDAwV3VEUENIZ0d6cGlFSXZ2K0EwVG5iU2pOTVV2c1UxQkpJN1lFU2JN?=
 =?utf-8?B?YWlPZG5FTWErTnh0RHArb2ltU3lGU0t6M2JwY214UUdJTldPTWlBaEtiT1pN?=
 =?utf-8?B?a3hvTEFWckhsN2JpdmtFWmp1ZW1uT2dvREtOZ0x0UjJaMWJYdUhtOTRBRjhG?=
 =?utf-8?B?U2M3bUJ3MEJMVS9FcU9SZjI3VU1KNzFCT081RTZLbENvOG12NjZVSVV6VEhs?=
 =?utf-8?B?UmlzNm4xK1RSeVpTVkpUb1l0R3p5NUc5eW5VQXNyQndYN3N2NjJPaFFsa0Rl?=
 =?utf-8?B?NjhkSUdGSU1lZFEyZERpTDVkQkNtTlNCNDdOWmdKTjBSUEY2bDBsNzNmVmZP?=
 =?utf-8?B?MWZpSnc0OXp4Uk1aYzRxSWFpS0tzbmJpenBvVFdSbzRQZTFKTHFqaUt4S0ZQ?=
 =?utf-8?B?OHpWdytLbjVrMEk0U0Z4Y21UdzhRTVp3Wlc3VXVJUmh3VnMwckR0Y1BKVmRF?=
 =?utf-8?B?eGFuRTYrRlZoWmRLdG91anN2UTl5ZmRyTnB2b3NoRHg5aUhUbVdpSksxZmEy?=
 =?utf-8?B?RGh2T2VVV2ZiSGxMR2ZoQVBYRmw1WlBucjZEY2FwQ0tUeVBQcHFHN2pNdVJ4?=
 =?utf-8?B?d2ExdStTbGFCM09oQndBdGhyWmM4K2Jzb01vaHhiWlZ3aWdncUdFMTVOQmlj?=
 =?utf-8?B?SXp2cXZLa295ZWk0Nm5NUFZQUFUzdXJnZHphUStacHJjaXg3eVI4bHNqUGNL?=
 =?utf-8?B?clN3T2RydllGYzczQkdJeGhwVjJoZDZFa2RnbmZwQjJNTUFodFBybS9YdklH?=
 =?utf-8?B?aXQxT3R1SkxrdzNSc2pGR1dBOW4rZjd1K1JoNFMvVHdEeEVQUXQrcEs3UFlH?=
 =?utf-8?B?SGhYaDVlSGZqdkYyT3pva1dRY3FNb0JEVndRYlBPamFLWmFQYXorWjM2RHRJ?=
 =?utf-8?B?SzhibEVpTTZqR2hBQ3FFOUNXckUwQ1JZQmdTU3FxYTZvT1FiVExMWENtdllp?=
 =?utf-8?B?RXBRRm1obzlsU1k5QjhCeGI2OFBGTWg5NUE0OGtmRTRuNVR4L0JhTWtNWTRz?=
 =?utf-8?B?cGlmT2xXbzNvT1BUb2N6U2RhTHNJMittbEV2ak1qNXFFbHd4a3pkTXYvTmJj?=
 =?utf-8?B?ZzdXRkZ6OFoxRVdhbDQ0eDlQNUx6RGFNQzVaclI3L0Z1MWpGall0RFB2VHAr?=
 =?utf-8?Q?80cdUK+41uoJDS/ohXHZa1muY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7318e0f1-0f27-40fc-405c-08dcf30ec6ea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 02:59:57.3079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9/xUAfs5nQkCbX6ZJTI+x5NOEk4uz3hhjeVOu9ZKSMTaD9mR+ZRNAJSt1WJieMhiBEuZdR8Z1yVpGnvpp0jRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8956
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

Add 800MHz fracpll entry to support DDR 3200MTS.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/clock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index dda57ed7f55170e34cad73d93aa3be654f5f071e..c00be19c4fa9c60f480ddff1da0a2df9261ace46 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -35,6 +35,7 @@ static struct imx_intpll_rate_table imx9_intpll_tbl[] = {
 static struct imx_fracpll_rate_table imx9_fracpll_tbl[] = {
 	FRAC_PLL_RATE(1000000000U, 1, 166, 4, 2, 3), /* 1000Mhz */
 	FRAC_PLL_RATE(933000000U, 1, 155, 4, 1, 2), /* 933Mhz */
+	FRAC_PLL_RATE(800000000U, 1, 200, 6, 0, 1), /* 800Mhz */
 	FRAC_PLL_RATE(700000000U, 1, 145, 5, 5, 6), /* 700Mhz */
 	FRAC_PLL_RATE(484000000U, 1, 121, 6, 0, 1),
 	FRAC_PLL_RATE(445333333U, 1, 167, 9, 0, 1),

-- 
2.35.3

