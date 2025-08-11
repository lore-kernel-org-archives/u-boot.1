Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54661C87FDB
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 13:57:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DED08328F;
	Mon, 11 Aug 2025 15:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="KMOQlJcr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5695083290; Mon, 11 Aug 2025 15:56:58 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B24AC83285
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWQJxHW8Fq+jXiISEMvtuaOplmG+Dg2tKaVm0X1HWGpixGSV9l0l3roYP1iR9wgEqDizIpc22gOjslMN+y6/gA1jqRYI/BZ6OhIepCddRALzlh6Gt1LaAuYae0Vv+jBHlSaJE87cugcg1kiAl2F9kSTvPbrrgto7rWBjTa154tPjD5528/Kf5DVGBwEEXgJXy8/h0ZjkVkHM49reBtJ+LbrhJF1vNmN19VQgzIbdGZ40Ywo6/PmEXQrMPcwXplSI8YIrMXXidjiEaIo2vbsEHR9K6ij+hNwPC+4dSnIBPUFJBVLLkZRL7tztLQ3ZcPJi0LGOoToGj7kBLC0b+HCljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJWifGkl33pd0sudfIuMZ5DNH0JTx3/9ysBKqIDbUkY=;
 b=ydZNRDkAZ675qV3WztDLVk8ZFAnt+GRbPqsNuuuWUuei4UohHAjjLJ/bdFsWE3Jeuuo1WuYNvAUKaVPEsFb2h3XhgCiDQX/E4xTclX9oIprTlDk6HtJWksM8lUhKOOCQpgcdbSAHyvyDCf94xdbd4A/+ZHPm+Dq0UqaBDWF0VsBtl71ysCIrYezCv23bDZty+C8tXDZKkUHvS1AIScN57EygRqpN7CGGGPowDUGCfqGajrMMWAdcarjYlXvTlvQmJ8fqIvPCwrGhnGwAdujTiitxB2wztjz7GOghxYisjKpo9KYhpYUOD85neYpQ4lhbmaNqwd05v0czO91gieg2zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJWifGkl33pd0sudfIuMZ5DNH0JTx3/9ysBKqIDbUkY=;
 b=KMOQlJcrPzu9Lu73WSgfvT1xKWcuGAVgeRYNpC/LfURJ2SPlTZ4RR73MAFyYdLcmYXb44nJyRRP+rHvgT1wqeqNHDaFlwfEROCodZ/sxB0W8DVnAcSKP114/TWgKG0TbyQBtcuqcxdjHKY7ltLBthdixx/qlwc7Aup9SENE1i1F3IWowqzNpCM1F86wc5wpV7TytMDiuwUkfXrlMr2bgyP4DSt/GVr96D3u6SbnmBARO9i3shc6ZONlxSDzODAxPgiu8bI2BbNW5SjD90R0G+8pEooKJD5kvrMlUlTYkGooANpAIfafnLlp3tCJnePcnUD5ZHM83ipIm+t41OKo3ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by VE1PR10MB3888.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:164::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Mon, 11 Aug
 2025 13:56:47 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9009.013; Mon, 11 Aug 2025
 13:56:47 +0000
Message-ID: <4982129d-c71f-4a63-9330-aca7efb8715e@kontron.de>
Date: Mon, 11 Aug 2025 15:56:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: imx: imx9: soc: Fix env location when booting
 from USB
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, Ye Li
 <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
References: <20250811-v2-fix-imx9-usb-boot-v2-1-3d89974e2881@toradex.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250811-v2-fix-imx9-usb-boot-v2-1-3d89974e2881@toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::15) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|VE1PR10MB3888:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b79d7dc-3ed5-4503-dcc1-08ddd8dee990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RllZUUNKZEI4OG5oeCt0SkpRc2wrSVY0OW9rdUFGckZidmY1T1ZVQklSU0dt?=
 =?utf-8?B?RnpqM3VUZ3BVRUdCeFhwRVZaeEF2dzBJY0xjWGlFSzhISnZKbG40dmJabEU0?=
 =?utf-8?B?ME84aGU4ZzkxeHlqVVpzNnJZdjJUaXY4cGZ4RHFXWGo2bkxMRnc2VzhyK25r?=
 =?utf-8?B?am0vbE0zY01vTWwvOXRmbWw3elA3WExBeVA3M2s3TW5kdGtnTHBmUzRiamtB?=
 =?utf-8?B?WUtFcm5OZFRITFpnZlZNWXd3Tm1OeUl3WTFhTENOY20vamczdnFhS3NqTjhi?=
 =?utf-8?B?L2lFMGpZT28vWUlVdEdTNWE2TVo5aDQ0VldLNFkvcHY2WXZkRDAvbVhGRXo2?=
 =?utf-8?B?Y1ZBQ2RjNmN5aWUyZ2JVODF0RWxia0I5NE56VHBnZzNhemUzTnVUWVBlaFNE?=
 =?utf-8?B?LzdzZVpMUWo2VldFcUk2R1Z0aHFIKytEVTJEaXh2cjVaSlM3dG1Oem1YLzBn?=
 =?utf-8?B?bU1kRG14amExKzlHY2p1ZDJ3RUx1TG1VVXZsQ2tPWisvNk5lVXJoMXJzQmlt?=
 =?utf-8?B?TDgzTU4wVVdTR0NtZC9LaWJ6cW8zbzJNU00vc1lEbG9FeTlUTGNrTTlrdy9u?=
 =?utf-8?B?bzlXUGtlbVh2cExldjlqSEhBOHhhYTRBVzd5U21yUnYra1Rxb1pYak9uR29q?=
 =?utf-8?B?OG1TelRaRy9pc1dBeEgydGRlUUxaemJEcktBVVJQRzFvanlVUHQyandwSG1X?=
 =?utf-8?B?Y0p0eCtUMDg3dDdTNEw5c1kyV0VnL1NDMlhEaUY2YWsxRzB0QUlzS2FCTG5E?=
 =?utf-8?B?Mm9IN2FkdWxyUG5RWVVoVk1wU2dmaGNpN0ZTTHlqdWpiMlRBNTdwSDdFYnBH?=
 =?utf-8?B?Nk1nMDN6d1g1SEhUQS81Y3lZeGJHYlVtNDJzNms1cWN2U1hoSmRBZFVBajBI?=
 =?utf-8?B?UmNKNWFaSG1va2J5VGhkMTQ5UTlmMXczdi9SUHJIOFpzd1ViQlZPcUJuVG5U?=
 =?utf-8?B?ZU5tT0h2SVk4M1VJR3BxQ1lwSzFPMENUVnVSNC84STBVWEdITy9FdjV3S2tJ?=
 =?utf-8?B?MmRKVjI3a0NZVUJ4dWRBMEVDMUlKMVM1aGRRRm1SM3dMSjlwS1VTUGdoblZs?=
 =?utf-8?B?MUpaUUNHdXhvcElrQ0pMSDhaQmZ6NkkrYm9zMndQeG51TnlaVnhQSi9oeVdL?=
 =?utf-8?B?bW11SEwrdEx6eStJMzhGNDRnZWVCMUxVMDNFOFkxZ2gwemcwS2VERTQ0QjdU?=
 =?utf-8?B?bll5MmpqNWN2dGpua211dVphVzF2YW12WHU4V29TUUJwNDFUdWpVV1Qzbitu?=
 =?utf-8?B?cmZmdS9EaDgzcGtEZ3cybldZWnlld3YzY1NsdFNiZjFDNTJrSWpISXR2d1Q2?=
 =?utf-8?B?K2I5c1UwcXpFR3pDMUdHSXJockZWK1VaODNPRHRSS3R2WTRtS2NKNlREbjc4?=
 =?utf-8?B?aEV3R3RoNHdWdFdiNG16TTRLdEwwcVh0Ykp1OVdFQmdBZUFNZ3p2QStZbWht?=
 =?utf-8?B?MGtMcFVYWDBDNksxL3Z3NEowbFJCaEFNOSt1Ky9aWUMyd2k3VjFWSGRMSWVt?=
 =?utf-8?B?SHdCbUNUU1A2QllTc21EWXNaVFBKcDI1SXV2enJqWGRkRE5XOG15SXRUOWpQ?=
 =?utf-8?B?STJ1YWJOZ2E5RGNnelI2YWIwTHBYRWVGS3lFanU0MnY1Yy9KWlI2cTRGVGlW?=
 =?utf-8?B?YWYvVm50SWFFM0N4dXdoQWFUa0cwcHJIYk82S0tzZ0FDVHdrbklCR29CKzlL?=
 =?utf-8?B?NzEvOWd6MXV1RlNmU0JTRGJmQlpkMDhBWm1pUXRZdWpPY1hMNmQ2ckpPeFI5?=
 =?utf-8?B?WHR0dWU4L3FJRnU0M1RaZFFmcDN0MU54OXNEVDJCRkt1Y1VrakZlY0Jhaldr?=
 =?utf-8?B?RWpwamE2VXBWdDV1RzZHR0pnK2FyVkpLZ3FwTUQxcThleW9XRGNUUVpIa2p1?=
 =?utf-8?B?YXZkMXhRK1pPQUNPUHdTLzBjWVhJQk0xVWNxUXBQR3pZSUFNbmpjSWNoZlJX?=
 =?utf-8?Q?yKcQt5SGMs8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEEzK1VoT2ordHRDK1Nzd21XeUhkSG54M2FJMWdwSys5TXl3Tm0zYlZyRy9t?=
 =?utf-8?B?VVhtYzhEU3BKVnVEbFk4cFBhWGJCOVZrcDBHUmVsTktxbnBMTklDQUFCRU83?=
 =?utf-8?B?czZJbFlheDlxdmZzRmdxV1E0VE95ckhBODVxZDVLUk9Hd0wzdzJNN0wxQ1lH?=
 =?utf-8?B?eDY3ckFrdC9lSlBlM0NBOGRoVjdqQmk1WmlhM00rKy9UWFBDUDZ6aERUcUlj?=
 =?utf-8?B?NkdZMDREWmdGK2pqdStIcTJzZnZlcmc3YzZSOTRYRnZCREc4MENMejR0Uysx?=
 =?utf-8?B?d05CakJWS3VFcnJFbmFZRXdxeklQejI5b01uMW5YaTVQOGJHM2xRRDNsUVVV?=
 =?utf-8?B?QnhiWWZRUDlrS2pVWEhkV1l1NVpRRm1Gbi9hV0VCVDhNOWNVdDFyTC9xOGVY?=
 =?utf-8?B?cTFhT0c0bEZMWGlIMXBmMk5FYjVCSlZJaGlibHYrMkxIelNzdHBJZzBJaWlT?=
 =?utf-8?B?dUNrSEVVUXhXRnhnSlI2Skg4cktONWx4S2cvRE1wbmd0Y2JrSHh2WEFFOExG?=
 =?utf-8?B?Y2xNWmVnSjA3Z2J4Y2E1ejc0RnpVOWFUeFFldmorRGlLdjBIaTVSN3FMTTM5?=
 =?utf-8?B?aU5uT0VvaytUVXJxSnM4Y2JvMkVLT0hjdWpMUk1Xd0U4MC9Gb0tkWVo4NmxF?=
 =?utf-8?B?U1AyaFBMVms0WU9IekhZa1F3QUp4bjcvTkxHUE9TazVQMlhJN01QTTZGV2NP?=
 =?utf-8?B?Mm5jUWg1bkxWOFlGUXVrNS82azZRWUJzV1dRbkEwVFllNGxaaWltYjZoUDJh?=
 =?utf-8?B?eXFDcC9tYWhuVWxDTTdPYzlEWE1xNllSSllRWUdkeEU5SEp4Zlk3RGx3U013?=
 =?utf-8?B?d05uSEdyS1NicWxUUFU4bXZ3RG1yb0lFT2FWSWwwcjZCTnZ5U3BwT2VScytB?=
 =?utf-8?B?cjlUWHZ3SzBvbGVzdGlueGxzUW82OVJGbGFXUHNjVm93QW1rTWpzU2JpRUM5?=
 =?utf-8?B?THBWbkxYd2pIMzRWV014YzFSbmo4VzNKSlVobWYwazFqekpLMnBIVHdVeHhP?=
 =?utf-8?B?bGp3azROdWFxWFJhRHo1Tnk2cE5yaUV6R1kzSVFyS29VeUlQa0FmVm9ubEpj?=
 =?utf-8?B?TWpleXRiTldvaVkrdDNESk1nU2Q5NkZ4TTZsVTZQUnIveDlJb2lRT2JDNThx?=
 =?utf-8?B?dVNVRnhXSnlRR1ZKdjhCVlFzeDFuaWdGMlQyeUQ3MmFSeGdMbk9nSzBxcExa?=
 =?utf-8?B?dU5XYkdjeHpyTUFwZEtXeVZEWmFlR2RhcDBDMVpPK1pXR3F3SjZydnhiODR0?=
 =?utf-8?B?YWhoZkdkYlVsUVJVLzJwcEFGbHprcmlxQWtPOUhhVWNndkV1YVk4WEdtVmJS?=
 =?utf-8?B?WTZtTytlUGFRWVAwdlVmYlhER2JVQU42Umh5Ly82ZUIwYW15cEVaaEIraVkw?=
 =?utf-8?B?VXVkbGtaeUx3MWZGajlNSzFLdXBOMkhJWHdPK3BIb3lFUGJaODFyVWg4ZXY0?=
 =?utf-8?B?QVdiUC9iOFRNOG5USFZpOEdJaXNTdE9ZcWZ6aTBZbVVDTkRabjRrYkhNUnpx?=
 =?utf-8?B?TVJHeU1DNkIyd1RwQkFaSnhQbEEwa2NVZEtFbEVJazlkenpkYktRQmU5WElU?=
 =?utf-8?B?SUpqaTlxelB1cE9Sb0NPQlFzWTE2bTRnYlZCalBrNWdWSlNNY0pWa3lSdE4x?=
 =?utf-8?B?SEwvVHkvcmhYcE16UThVb1JCYzQ3eFNRdW9CY3pPL1dveHNFY3lnMnV5MFVm?=
 =?utf-8?B?dDI1Rm56RHBCWlBiL01Ma3ZKSWdHdlVhaVRPejBCeGg1ZWtIaUkzZFkyQ1ZK?=
 =?utf-8?B?V0xocThpYTBBbDB1T2M3bFl1alFmcU82YURxVU5iTEhlQ0NQVm9XNFZPSDUz?=
 =?utf-8?B?bGpTYjBJZys0ajR3YUc3NzJiYU1pU1R5MFJCTVBBanpoNnB4YXREVUQxRTAr?=
 =?utf-8?B?cEU2Q1dyMm12MmFGZjdnVHpCV0xGS0FWb0JoRkcxZWxONkpSTjlYVUpqbVFB?=
 =?utf-8?B?WENUWXFITElxUC9XZmJIOFNVWThFbUlNcS9XenkvZ1JuNmdDVnNzcjV3TDgr?=
 =?utf-8?B?WkR3R1EwQ29Pa2wvY1dPTUxSalgyRm5Jc2RQTDVHM3Z3MTlUNlNBTHluOGN6?=
 =?utf-8?B?Mlh0b2JWSkNsRmR3YUpKUDhra01nK3YxOW5FTkgzZnduVVZmUFd5Wm1neXY1?=
 =?utf-8?B?eEJVVjJoT3VOcXBMMWJ2TUQyM0xrLzgrSWEzM1pZMTV4N1lxenIzZkNBSk0y?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b79d7dc-3ed5-4503-dcc1-08ddd8dee990
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 13:56:47.1656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNGZ9PaeLuLBCyLpX5urxLT5FYOO/tvSSPiuV3kTFD+A0UNnTOqleXEKvjZuxXzUAhebHIS8sc/BWbs15od5VZiD/LW4h2YgaWb5OHYhXN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3888
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

Am 11.08.25 um 14:57 schrieb João Paulo Gonçalves:
> From: João Paulo Gonçalves <joao.goncalves@toradex.com>
> 
> On i.MX9 platforms, when booting from USB, the U-Boot environment is
> always assumed to be in RAM. However, this causes the boot to hang when
> `CONFIG_ENV_IS_NOWHERE` is not enabled. The boot also hangs even if the
> environment is present in another storage media (for example, eMMC). Fix
> the issue by correctly handling the U-Boot environment's location when
> booting from USB. Also for i.MX95, set the environment location based on
> the ENV config and not solely based on the boot device type.
> 
> Suggested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>

Thanks! It works fine for the USB boot case for me on i.MX93 with both
CONFIG_ENV_IS_NOWHERE enabled and disabled.

One thing I noticed, though: For the SCMI case (i.MX95) we will leave
env_get_location() with ENVL_UNKNOWN in case of QSPI/SD/MMC boot if the
corresponding env device is not enabled. For i.MX93 instead we return
ENVL_NOWHERE (again without checking if ENVL_NOWHERE is enabled).

What would be the "correct" approach and can we align both platforms?

> ---
> v2:
> - Changed the env location order on USB boot to maintain current
> behavior on i.MX9
> - Applied the fix to other i.MX9 platforms, not only i.MX95
> - Added Suggested-by: Frieder Schrempf
> v1: https://lore.kernel.org/u-boot/20250722-v1-fix-imx95-usb-boot-v1-1-dec7f2384405@toradex.com/
> ---
>  arch/arm/mach-imx/imx9/scmi/soc.c | 13 ++++++++++---
>  arch/arm/mach-imx/imx9/soc.c      |  8 +++++++-
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
> index 13f13ca7d1056ac5a9f1b529b13e0d8dbe2462f1..f973652d0cbe8723b0cdc1a6235fbdd719146065 100644
> --- a/arch/arm/mach-imx/imx9/scmi/soc.c
> +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
> @@ -635,7 +635,8 @@ enum env_location env_get_location(enum env_operation op, int prio)
>  
>  	switch (dev) {
>  	case QSPI_BOOT:
> -		env_loc = ENVL_SPI_FLASH;
> +		if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
> +			env_loc = ENVL_SPI_FLASH;
>  		break;
>  	case SD1_BOOT:
>  	case SD2_BOOT:
> @@ -643,10 +644,16 @@ enum env_location env_get_location(enum env_operation op, int prio)
>  	case MMC1_BOOT:
>  	case MMC2_BOOT:
>  	case MMC3_BOOT:
> -		env_loc =  ENVL_MMC;
> +		if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
> +			env_loc =  ENVL_MMC;
>  		break;
>  	default:
> -		env_loc = ENVL_NOWHERE;
> +		if (IS_ENABLED(CONFIG_ENV_IS_NOWHERE))
> +			env_loc = ENVL_NOWHERE;
> +		else if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
> +			env_loc = ENVL_SPI_FLASH;
> +		else if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
> +			env_loc = ENVL_MMC;
>  		break;
>  	}
>  
> diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
> index 9fb82644f126b8717b2f2ba1c9e77fb75d2e7757..3f7dafdcce5d3c6df102fe0a2a5d0b61c394937b 100644
> --- a/arch/arm/mach-imx/imx9/soc.c
> +++ b/arch/arm/mach-imx/imx9/soc.c
> @@ -809,7 +809,13 @@ enum env_location env_get_location(enum env_operation op, int prio)
>  			return ENVL_FAT;
>  		return ENVL_NOWHERE;
>  	default:
> -		return ENVL_NOWHERE;
> +		if (IS_ENABLED(CONFIG_ENV_IS_NOWHERE))
> +			return ENVL_NOWHERE;
> +		else if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
> +			return ENVL_SPI_FLASH;
> +		else if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
> +			return ENVL_MMC;
> +		return ENVL_UNKNOWN;
>  	}
>  }
>  
> 
> ---
> base-commit: b6e2cfca1a6fd10c8f12016a40d690d2ec61796c
> change-id: 20250811-v2-fix-imx9-usb-boot-48679993463d
> 
> Best regards,

