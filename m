Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1172EE20A8
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 14:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5166683B9D;
	Fri,  6 Feb 2026 15:14:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RukIFnZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DED8483B5E; Fri,  6 Feb 2026 15:14:11 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B627383AA9
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 15:14:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uh9qKg5VykCxzuKDWlHSvT4BbNJ0e8Qp2Ai0OjQJo7+Q2A/4n3AZvvnLWNQ4hdlrxKlRvQjOxMtSx17SSLtfTUCEhFBCOUN2bTycC0gpnpMaaGpC8+juEnaSCY5H8V24d7QzA+hUY3ma2KQgvGlkPSjKHyQWxJ92h+giKCiYgHjpYTiyMiUtfhw1Ly+yu4z9YbQ7gqQs05negLL6Z6SAXGB3j7r99EQiuor8B4RxjX3DOVZ8Yg7UXyHH/2ID8qkSMIRtd/Yo0ly8L9HezFvu8cO1cfFV2KzaJRMjT3B2maxm8HitpoYQLRt4G/2hYgB1lDoJUnV8bVE6YWdmHWs+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5iFeWTV1BBQfepT637MWFqREzFOQd0BBTJi12fdSu0=;
 b=SmQGOBynl1z+QCC7YlwoAaykcQjeGxJzfi7Ye68Z3qq9mnXxlwv7uIfIiOwn4UTKGbvQ5HvUdIfxPI2dTaQfzECXSb8co4n8YEVrLknegmCFj91upKdPKWDE+2jCvj1fuWcHVox3KwiOa+dhLU1V+A0hNPU5+BUJqNeNvNrRxYX9fkyU5ULHXWNPS3IarC6c/RtENOLOLH4iarLRBF1YSS6a0D7lp3IrPGgr+TjrlgkEM/p67Y3MQ5Nze/SrTJIhBJWilDJ/6RmP+AbTRl/pa4G/C0/L2JvuEravkvPf3I6FyFDODKGNQ8XR3mk8Fkoie7Pey+dNzF/QImj0f6omnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5iFeWTV1BBQfepT637MWFqREzFOQd0BBTJi12fdSu0=;
 b=RukIFnZgiGYs8o5a7+oBowsCLqVIqxXo/cBcmezUIvPmLatVHiDNTYCb+W4i9AONcAxmX0W0UnRHLBEoOMDhxSmJhnkGWorDZ+qaETFpwTPZGsp/0L9qh3icuPjfLh15Q2zQUsymYZqHJ13rUpmPQrA/jJuVPLU/EMcJz28Mv3sBU4WcyGbcqlYMirMfOGuZVvtCrNdwaWWuceH7p7K48qqCbkWBlUP7+/8O8MsBf7x2J1z8/fqJ3MShSLAJRlIfHHOJ2WmieBSyUHuEtSVyIHZwRNIoSTdYltlBbsXg5TAjys/xFEhfM+tnup+yIqCj/9KmkD+DCJ9tMHWMMt9Emg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU0PR04MB9276.eurprd04.prod.outlook.com (2603:10a6:10:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 14:14:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 14:14:07 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 06 Feb 2026 23:28:43 +0800
Subject: [PATCH v2 1/3] nxp: imx95_evk: Drop init_uart_clk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-imx9-board-clean-uart-v2-1-ebee8158586c@nxp.com>
References: <20260206-imx9-board-clean-uart-v2-0-ebee8158586c@nxp.com>
In-Reply-To: <20260206-imx9-board-clean-uart-v2-0-ebee8158586c@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Ye Li <ye.li@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU0PR04MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: e4da3719-3b24-4b5d-22bd-08de6589fd59
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjR1V1lzNVJuczVtcFZlc3JGeTBvdG8xcEtsbHBET1RieFhUaXJIMXhjamhB?=
 =?utf-8?B?SzRDdG1NVThGWFV3dDlkTi9pUW5YaTUrL2ZZK21RYjBkSnRNck83eEJTNW4z?=
 =?utf-8?B?Tm5aVHMxSERCVVBjbG5TTGlyUlBBY3JMVDJieWdDaXZRUytNV0xMYWhhVHZB?=
 =?utf-8?B?ODdaWXBhOUg3VmRWajMzQkJaSkNrQWM5bWNlY2ZmOENFWEJoZ3RjanZmdG5n?=
 =?utf-8?B?Rk5WQStUc3NHRFQ4V1puRGNwdi9tYlFXWjV5b0NseUxTTTQ5N1A4aEpGc0Jr?=
 =?utf-8?B?NCtKVFI2NTQ2akh3S3BaTmR3YUtjNjgyby9PN0ZWc2NUUjRraXRrb09hWGta?=
 =?utf-8?B?QjFqWlJrVEFodlo1Sy9MaC9lcVdRcnI1TXFJMk9vOFE1MGR4N0FhOFBFOWE1?=
 =?utf-8?B?L1NZWW4ydm94UHZnSHhzSVFQeTlqZVc3cTRObElaT29pYkVPWTVaZ200M0VF?=
 =?utf-8?B?WVBNUTN3eW1YNk5UQnBaWTRyVVloM3VIT2FDd3R6dEpYMjZFVU1JbjZ2NnpU?=
 =?utf-8?B?STNVZEsydGpaNmo2YW9icmd0ZWVlcnR2V3ZrNHFlaldCS3RRUkVmK0NGbmdy?=
 =?utf-8?B?Ym0zVHpONTc5L21jODBabWY1aUE2QUYxVWhRRFR6dFZSVkpHWUs0OStsYjlh?=
 =?utf-8?B?eEluKy9PV042Y2d0OXJERXY4TXp3c3JTNzBBcHFxd21CWm1xbmZUSGJZOTU5?=
 =?utf-8?B?Q28vWlVWYjhmUG8wQ3E0SHJwejhjRkVhQlBLOUVUbkN4UWd3Uk9obFozR2Za?=
 =?utf-8?B?R3NER3JTZlcvTWhNS2FESyt4VWZsWVpaaGN0K2lIVFMrU0JPeGFSV2lneUtq?=
 =?utf-8?B?a1IzeTlxZlR3NDdoQlpkcUk2bWRCMlFIc0JYSGg0bkhUdkdFUmhlVFpKMnJ1?=
 =?utf-8?B?eDdTRGJhZVZPWjBpdzZDS2EwblJxNm10VHFUbVltekltTG1lWjVIZEZxMUF4?=
 =?utf-8?B?SXlpVUFzamxpR1pvcnJodDRDMTZDci9ObWpFbXF6WFVqZ0IzSzVwZm9Qc3U0?=
 =?utf-8?B?V1FrR0pGNzJKUmZCeW15SGpGTWQ3RUxyTkVUcXBtNEpmeEZLbGhXelRUMEMw?=
 =?utf-8?B?TWR2UE1iQkI0OEpLenJjd09telVwdkk1d1Q2RGhvL2dhTW4yMUpMME44MHFG?=
 =?utf-8?B?VmtnR25mVnB3L0tHSTlvcTZONFE2OHBxSndXeGhHV0tJQnk2aTZEclgzWDRQ?=
 =?utf-8?B?VW1RdWE2anBuclBETWFHMGVFRDAzdlQ3eG5UaG1lT3gxSHJLZEovMFdJdVJW?=
 =?utf-8?B?M011SkRZSzRVem9lYzBUaG5yaHN3Yk5wbi9ORWhUU2FFMnRaNjZkMHc4bXE5?=
 =?utf-8?B?OUo1cW5UT3JYVWV2SXR4enZGZ25RZFBxRG5KOHduTVNJbjE1eFVuaW81YmVw?=
 =?utf-8?B?eVNPOFByN0lwUFRUc05NcW1sNU1TSTdCZHFFZmZXMWlQMmRvRktPblFDZzEv?=
 =?utf-8?B?ZU5JYkZRa0hHSHZBV3VFcXl2TUdLTy83cGl0cmY1dVZOUmRYZ3VpWHovd0hj?=
 =?utf-8?B?TmU0aWdFTTVIeFFmUGZzejVLWktYNkg3eHJEQkVEUzNsUkVlSXhkUEduV3JJ?=
 =?utf-8?B?STk2K2U4RHB6WktuYmpESzlKSUxoUzVhZTF2SExBUWNrNWZRT3d1bGgxR2tM?=
 =?utf-8?B?TmV1dTFhOVptS1lvaHRMSmZjNjYyMkFCMjl3T3ZqUVJhMnZpS1BCM1JDWWU0?=
 =?utf-8?B?US9hZmlWWGdJeFJRSGg2Z0hNd2ZMU2JvdVl0WTc2Tk9Jd09NcUdkdEZxR2RP?=
 =?utf-8?B?RzFoak5wWWlDWlJ5QmV1M3pmK0RLdUIxcTdETVVOZmNiQXVPRWo5YUdmTjZJ?=
 =?utf-8?B?S2VMSVhBbmo4TGRid28xek1xYVY0N0VobGw4U0JkaUVmT05tV1JRWFFmOVFZ?=
 =?utf-8?B?ZnVpT0NEZG8rNXBmWGcrWnpyZDFVcWhZVzhLelFDSlgxZ2lGN3VCWFF0L1dJ?=
 =?utf-8?B?TGtiZkVGZG1Od3o2bndMN01lQjc0bHZzbmtoLzRsb1lrN2VRMDVzbFNvaFdG?=
 =?utf-8?B?SkZuMUVYYzB5UmphN1dnclF2YlRPS01tWnhpdHVNdUExR0MvaTErUlFXcHFk?=
 =?utf-8?B?dVo5N21pbnJ3UFJKaHgrRmhWYnpYcWxoaDdFaCswSHg0Tmg5WnVSc2VGWTdF?=
 =?utf-8?B?ZWVqYVBKMXJYbzZhWUVMdzlqc3N1R0hlU0tmODdlNytobDk3Qk5SYmIwMjNq?=
 =?utf-8?Q?h4WQa30J4CzmWTuxdXN5zb4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmZNZzAxSEh2czM5VGcrRDM5OUNEZlgrNytKYi9hMk5vdUZXS2hkUmVGTVZp?=
 =?utf-8?B?SUNYYXRlNlBrYlJwQ1hFT29KNFhPQjJ5UklTZVd4OHU1bUlIYksvWEE5Slpj?=
 =?utf-8?B?L3lUc3ZrNkhYaDl4RUtqSUxVak11UTVBcUQ2L3RuTDgvaTZzSmI1VTBaQkVY?=
 =?utf-8?B?U0lQRmdqb2dqTkhaMVdtYlR6d2xuWG5NaFZWS1JZWjBOL2l6VXpoSFUzRGpz?=
 =?utf-8?B?R1NJd1RpVXA0U01jVERNZEpiTVd0TjI4SWs4WEZDUkEybVVDU1pEKy9hRTNC?=
 =?utf-8?B?OVVnemh3VGpIWEFWMXBhS0puS1MvaDlBTzV4K0wwQ0RkU1h2VGxyRit1aU5q?=
 =?utf-8?B?bUNNK2JWTmp5WGpaaGc4QUNsU1c3RU1wN0l1MkNhM1dnNVJWaU50alNrRHRn?=
 =?utf-8?B?bWE3eDhaampHSGRPN2UyM0QxWlpvaldrNVExdm81QmY0MTYvdytyckRNcDFU?=
 =?utf-8?B?NlFGbTBMQ0hPa0dsTkIxV1A1MkpxOFRCMkQxRXhpRTAwenl0dkd1U1ZHYldX?=
 =?utf-8?B?YVZvSDBmZzdlUHlEYWFlenpCT2h0MndtQ1FIcFRVVXZQc1FTTEZ2NHcvUmtt?=
 =?utf-8?B?Skl3SkpkeVkrMXIxM2sxeGx2NU15VHRNL3AwYWRndzZaL1lqR3c5M1BzVnVO?=
 =?utf-8?B?Q0h4UXFreU5aanhBSU9UYVVuaXlSaHYwYW1WS3hydDZQQXlzK2dsb2ZJNzJI?=
 =?utf-8?B?QmZpMmdFcnoxY2lNdzJDc01kaWtqc0hNWkRXRlUvUFpOSVU5WUpTakR4L09q?=
 =?utf-8?B?TWprbHRCemRhUmRMb0dkTzdzQ3ptdzRPQlN1ZXBkeGhmL0lPeFF6TGtUUjFu?=
 =?utf-8?B?T3c4Q21vS2FlZi9tV3JGOXFkK0txN2FPc3EyUUdud3hiRDJOSUJHUW1WSjJr?=
 =?utf-8?B?Y3AzdVo1aG5MTW5kbnA4aDNuV2JzM29FbW9vL0RwUVpHNldLZDdTYXJWTk52?=
 =?utf-8?B?RXNzNm1mdW1JOXdCRGVMU2g4bjNzaGhsTC9zNlF2V0VaTjdrYmRXeVU4c2ps?=
 =?utf-8?B?UC9oRVB6R1VVSmlIRHVmNGNmZGttVzMwZHZ5QzArMmhuQ2lvSWtpNWdCZlQz?=
 =?utf-8?B?TUk0MGcxa2hYeWdUVlFnc1V1US9Tbk9Iejl0TFhmTmhZaGhKMWJESEsvRlRN?=
 =?utf-8?B?MWdDNzFkM2dSREVoNkticjRjclFRZWNmbGZyOWk1VHBpN3Axb0Y4SGVNT29j?=
 =?utf-8?B?MTI5azZmRjladjlqWU83U2I2cE8wajNuTjhMcEdhVWFJOTZCSXdCKzkvZ2c4?=
 =?utf-8?B?bGJOSVhPYUt1dXViS1pNMEJXdER5c1B2TDJIMU12V3ZwYmYvQmtUL3dpMEFJ?=
 =?utf-8?B?M0xiUmxwWEVTRjJXeHQzOXd1bTRIOUJoUk9pWDdWSEdqOElTS1AxU3BaUCtP?=
 =?utf-8?B?LzZXbjk2a0xpVjZIRVFFU0hNM1N3Vzl0aWFVT1QzV0dKRmt3cG1BQWFSVUFT?=
 =?utf-8?B?SUlMUW5aMlladmtIanJrTDl2Y0VmSjJaY285VnpFYmZQck1sckh6SU5mMDBq?=
 =?utf-8?B?RlU0ZTNma244TE9kOE52OFM1S1h2bVlPOGo4aFJ0VG1zUzhjQk5NRDEyR1Nt?=
 =?utf-8?B?TXFub3NqSGdUS2tFZ0YwOVZiT0dHZmZIbTBIT0RVeXdwWXU2QVNtY3VpRWts?=
 =?utf-8?B?ekI2UU1uRHZyelpLRjBvMzBkVUJHRFV1UG5lVytRUkJiZkphcmp4K2tnbGRP?=
 =?utf-8?B?Q3MzbGVzczNRNEVZN1B5VVFudW1pS3BXcTVKLytvWm1wUi80K25LVGtnZkVm?=
 =?utf-8?B?bHE0U05kemVtcDJOYmVvOG9uakZReHRYQ1M3N1JxUnRvOFVyaVVieHpraDlH?=
 =?utf-8?B?endoa3UrbGE1M202STF2dE5EL1l6cHFLNGVwcWg2UW1UZEVlZ2o4R2hVb1hG?=
 =?utf-8?B?aVk5ckFiNzVOUmFXRHhWUHpjcVdnQnB5Z1I2YVVyMjFERmgrNElOcWkrOHg5?=
 =?utf-8?B?QmRYTVlnT2ttVW4wN3d1S3lMVHFIWjRLeXU4Q2krcDBoYnBEaEE5NUswYW9z?=
 =?utf-8?B?RFlBdjk1SUpyTTFpdkw3RnJTdEhUOGJIWWp2Q0I1RUZXbmxialMvenBTTnpP?=
 =?utf-8?B?OU1jZkhDVlZaUlduNlgrb3pXSmd2OWkwQjZlaVZZYVVTSm92bnhaMEhia0JE?=
 =?utf-8?B?UXpNenRhbi9ON1BCSUR6cWpyTFlBanozRHJLeGNWOFQ0MTN0TGhXaFVMYjIw?=
 =?utf-8?B?QnFvTytjdnJhcnFLUUJxaXpORGE1V1RQSGZ1TFJvZzRMUHNVbmp6OXBhbzZB?=
 =?utf-8?B?UVJESXNGb24xVXhhQ0gvdERtd1NRUkJ6TkdGb2R1by91MmtkR2R1enlCVmpq?=
 =?utf-8?B?U3hQUVNzVVAzLzRzRXNFcXNiL3hWZVp4MW1KclZJOS84Z1RTK2prdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4da3719-3b24-4b5d-22bd-08de6589fd59
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:14:07.0185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L66zL0xRKeq8O1sTVG6SqqkpkF8rkR530VRNSEIB7RU0DVzqp2pYpEMeE/kuQxE2cg+1xL7Y7ccg/ZrvnKfMHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9276
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

Rely on serial driver calling clk_enable to enable the lpuart clk, no
need to do init_uart_clk in board_early_init_f().

Also remove board_early_init_f(), because it is empty now.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx95_evk/imx95_evk.c   | 8 --------
 board/nxp/imx95_evk/spl.c         | 2 --
 configs/imx95_15x15_evk_defconfig | 1 -
 configs/imx95_evk.config          | 1 -
 4 files changed, 12 deletions(-)

diff --git a/board/nxp/imx95_evk/imx95_evk.c b/board/nxp/imx95_evk/imx95_evk.c
index ca1d916deab..620a69b53e5 100644
--- a/board/nxp/imx95_evk/imx95_evk.c
+++ b/board/nxp/imx95_evk/imx95_evk.c
@@ -7,14 +7,6 @@
 #include <asm/arch/clock.h>
 #include <asm/mach-imx/sys_proto.h>
 
-int board_early_init_f(void)
-{
-	/* UART1: A55, UART2: M33, UART3: M7 */
-	init_uart_clk(0);
-
-	return 0;
-}
-
 int board_late_init(void)
 {
 	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
diff --git a/board/nxp/imx95_evk/spl.c b/board/nxp/imx95_evk/spl.c
index 752d7f916b6..761a1a4a0f6 100644
--- a/board/nxp/imx95_evk/spl.c
+++ b/board/nxp/imx95_evk/spl.c
@@ -67,8 +67,6 @@ void board_init_f(ulong dummy)
 
 	arch_cpu_init();
 
-	board_early_init_f();
-
 	preloader_console_init();
 
 	debug("SOC: 0x%x\n", gd->arch.soc_rev);
diff --git a/configs/imx95_15x15_evk_defconfig b/configs/imx95_15x15_evk_defconfig
index f3099f14401..5c7b3941550 100644
--- a/configs/imx95_15x15_evk_defconfig
+++ b/configs/imx95_15x15_evk_defconfig
@@ -38,7 +38,6 @@ CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx95-15x15-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
-CONFIG_BOARD_EARLY_INIT_F=y
 # CONFIG_BOARD_INIT is not set
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_PCI_INIT_R=y
diff --git a/configs/imx95_evk.config b/configs/imx95_evk.config
index 631ec23c335..58b8fc2a01a 100644
--- a/configs/imx95_evk.config
+++ b/configs/imx95_evk.config
@@ -37,7 +37,6 @@ CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx95-19x19-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
-CONFIG_BOARD_EARLY_INIT_F=y
 # CONFIG_BOARD_INIT is not set
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_PCI_INIT_R=y

-- 
2.51.0

