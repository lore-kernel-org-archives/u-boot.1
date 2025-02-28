Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEBCC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60F4A811E1;
	Fri, 28 Feb 2025 11:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JtBg0m9t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D5EC81298; Fri, 28 Feb 2025 11:55:37 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59119812BE
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIj0XR58KZeRd0Fs2fvBRaDqwcmzEHu4I1hB1O9mCjGlrAmrW9WBMPRiL5dWw3STYSfBcpexBXWWsKRAo7hZX+W6TnrRZC7Pnc5KttZCdmyw5XZ+xn3JegJb91L9ncUJBDfRleQMxPgm3h2G0Rk6+c+jhDmC5LIiUafOZL6YpcC2dRTpz99bnOMW1wnCHuXTmcAEh/HAhTYDR09K+MpZtLVk+fPbUKw+vcAA4+6tbudtWAcM59sFnof8ciu0fEMQw4LX4sJpZulZBAXuTipdz0a57+MKpbmH+LqHEqKHN6l2ZUPKh2AIDpECurvpjGMnTHL/3YbjQY/P237yMftsug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHp/3lIY7rqSxyKKeTKIopiUmAylsN5nv5Zp+ILxs14=;
 b=mMsr81SHUqMRHpbnA3IG9mFW7e9XBApjwz7/LRrUtJGW6kJakLpGNBAroSjt5Bbe+KNck0dndD7cdDqIQfXE1itA8dBjHbTpezCReHuiNghnzHE0eJIfBQre487+xQV7rFIgcmv3I+xIemDv8B2ugKhEeIvL/ZEBHPip5HHT077rexUa19e5XGbkDsRkeWSx0/X88rPqHgnnCb1QxOvALKThxZyJOf8unzGqmoSVqCxmwK2NAmhOstSbglPEyOZdOB7m/moPv8lhT+fqX41nQf8dsQpjD2PWKqKnbMzZs10IAK5BfJK7Y7Xl5UlpCMV+Ct81BLWlnF+Joxr9oH/bLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHp/3lIY7rqSxyKKeTKIopiUmAylsN5nv5Zp+ILxs14=;
 b=JtBg0m9tvIKBh7/7GzLW4kEnozeK9/tpHEDAIGz+iOzLftr50Q9AMS8WGmoNOMNo88hK3Y9xOzg5EIgYV5je8vk6ccHNbkZ6L+nIxM6nS4cIiXmdSlYVvvzrzFc8or1Y3cTTVnuX6zufK02AAuE1N7VoHJ2WeVLcSH0SDpGiriSlvFPLsC6xKlaAnWlF6pl/gtqoiOC5djBGda8s5UTN2lYH/TwIumm+GrBNl46pvLH1Et3ppHpiEK2wVXJSDaMRMzOPB1h2jrgvMc3IBs55Gu8MeAA2fYMTPyhv/9IX7k5gGcBBkxXPI/edw0bvv+B4hmtFv42PuJtSTfPYWkkwsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7845.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 10:55:32 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Fri, 28 Feb 2025
 10:55:32 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 28 Feb 2025 18:54:05 +0800
Subject: [PATCH v6 14/20] imx: Kconfig: IMX8_ROMAPI is not configured for
 i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-imx95-v1-14-09594e93cc9b@oss.nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
In-Reply-To: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: be591fe4-cb0f-492c-614e-08dd57e66c36
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1RwdTVhM2g2UzhlWHp1K2JpaWR5cDNyYVlremZvL2U1NHNvZWZOZjRaazBR?=
 =?utf-8?B?U00zZjMwYXhxTXJFSW0rV09IV2FXeEt6WE1lc3NCbGt1TE83ZkxlbnJTZm9Q?=
 =?utf-8?B?RnNBaXFjb0xtbFR6QWMxTkN4TVkrOTdpZ1dmNEZDcDZHL1Z0dEp0UlZ4a1dT?=
 =?utf-8?B?ek96dWdUQVpzOTVLZ2x1a294YnFGN004ckV6SWhNajRBNW9LQUhCeDQydjJO?=
 =?utf-8?B?YmUrVXpXeHM3bytRTjBNd1VWNCtWMmRFNDlLQ3NvMTRKZVhYd3ptQWduMHZO?=
 =?utf-8?B?QWltbENnNFh6T251bTk1WEUrM0xwaTJ5TnlVTVlEREdnZWV3YmlRK01GM0dy?=
 =?utf-8?B?TDVadXBZNERDdHZxMUZOb0FLVWIrcG5rWHRvSUVmcFBRRlBycmpCeVdOa0VW?=
 =?utf-8?B?cW1OdEpNb0dpdFVjdFF1bkJVQ1ZDOUJ1V1NNbHM3U21lTVJIREtCSXB2YXho?=
 =?utf-8?B?THRVMVc0b0tKaS9SMEplY1hSYVdOamRabVdySi9Rdkg0Y3VmOHpnM2h1cEhQ?=
 =?utf-8?B?RU9OTklzaVgrOThNNmVvajM5LzB1Rm9CYUl1ejhCVHVTbUxNMGJKYjI3cDFa?=
 =?utf-8?B?VjhncElmUkRodFE2Nk0xOUpqekNDKzQ1enEwVGtSMnRiMDc4M3NwZGlNTHVS?=
 =?utf-8?B?SmllWjRsVFJzTmxPY2VSZzRpVUtETUQ0ODI4MUI2bkIzblMrM2lQd01xSkQr?=
 =?utf-8?B?Q1lrT0l5ZkxmZS96cllxUEwzOFFIcTJiOFh0NWN1ODJDTHZ1MFNzRDFsRUdy?=
 =?utf-8?B?bWlSbDNHZE1XNWcwZ2VKMnBVeWZPdzhUVmNoRkJCaU92RE5GUUJzZXcxRTQ2?=
 =?utf-8?B?Q2FEVmpXYnp4cTZ1eHhhL2wvZTFybE9SZWhYYnNsOThyVUdIUmpoNHpiZ3lX?=
 =?utf-8?B?eEpKY202MytWdWdTbTAwZXdkajhOYlRUSzU5TTFQUjlYWmNOY2tNc3E1VzI1?=
 =?utf-8?B?UVh4MjY2NkVHUURXYTNCaTJNMldpeW9OSjY2VFJBY1V0Y1pYMkhoTGFoRHNJ?=
 =?utf-8?B?ZVJtSnJZaE15cDh1REN3dXBCaTNGK0ZOcVlVQ2grZFBMQU5kWlYzNHRIaGwx?=
 =?utf-8?B?YW12TU9UYmkvSWszT095QURmVmt1dHBSNUFHRnUxLytrUVpEUTJTOWZtc2hr?=
 =?utf-8?B?YkdxakZ1UUErTHJWbU1jdlY3a3U1RHJ0cGtVcEozL0JQQkF4SmY1QURCYnpE?=
 =?utf-8?B?ckJJTm9JNVlmNkxlZUdEOGQySmZJdTUxNUkveWxDT0NBaTk3ZTJYYWFjVTRs?=
 =?utf-8?B?aTdCODhQRjMxQmpoVHB6VzA4YW51cUpxbWFvTzNLcFlsdC8vRUtBdkwxbUUz?=
 =?utf-8?B?b01oM1FCdWlkRlB0cXNlcHVFdGNHNnBzUlBadVNtSXlobzdnaG5qOGk4eStL?=
 =?utf-8?B?VTJlMFBFb1hHQlhXc0RaVEh6ZmxjNlhXQzlEVFRweVIzcVpvVUJhVENoMU8v?=
 =?utf-8?B?YUZ3ckluS3dibjJ1UnEwVjA2MWVjdDFRTWJuY1RmQXA4SzAvMGRYQ0xKK2h4?=
 =?utf-8?B?akYyRjI3eWtJa1ozaG0rWThQVmlpcllOK2VTQzdYcGVkeXBsZ3pLdmxRSVFI?=
 =?utf-8?B?UXcrOTl0NHZoSEYyMFlvVlpyZ2FtdVBGRm95ODY4Vzg5ZUhJd25uZnhES2dx?=
 =?utf-8?B?MHR1bi9tOFBhY2pYMkhTNHNQU3JySTVSb3pwWHRDcDMrY1lOTGNHdDdCelo1?=
 =?utf-8?B?bkJyZ2NiRjBrVzJkTFJVZmhxMnhQUFo5VHM2SjdJMmRna3Z0YVRCS2hVQ1B2?=
 =?utf-8?B?czBMcS9hOGo1N1lhVnVmUm0yTCs0L21XZGwxN1kwWCtyM3AvMWh5dEtSbGFv?=
 =?utf-8?B?Q2hsVVBDRytSc0dWd1lkbXhtL3BRK0RGT0M4V0JHanFHYThyQXhxTGgxRnlr?=
 =?utf-8?B?ZUFIMG9IR0x0Y29EK3F5eVJRS2U2allsZEFpWmZXVFh0cnkzVG5Pa2NTWnVL?=
 =?utf-8?B?TWFVMVZKUisvUGhCMGhUY2tPakFYS2paa3hzM0JuMGNXWVpLeWZTSWtmbjBQ?=
 =?utf-8?B?RDZnSGZ1UGpBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnNkci9GQTFoeCtpNDBYT0lmOHkvcTNkUjVvVGVrS2dVeVZtSjJEMFVRbjNp?=
 =?utf-8?B?blJWWW1CWVFrdVkxU084TS9ENitEUkxXQTRiWkZXaVY0bDhnK285MnE2Vko2?=
 =?utf-8?B?VkVERExCU1JJL1dZZnNwaFFSVXE4M2hJa3E0VllQNVNLa1FjNGRDU09yMWtQ?=
 =?utf-8?B?cmUwS2U3NFpTTFFxNStpUVhycGhtTzRWVUpVelBFNkpVLzczRHNNUC8vVnor?=
 =?utf-8?B?aHRMVEFJVDFmZlBGckJIRVBoVXRWTkgxd2I5bTFFZU14THVYZDFtNXZrT2dC?=
 =?utf-8?B?V1oxQ1dwK2tBRG5mY2x6UHEvQzRDQ3llcEtYRUdhUDhaU0dUMkhxSEhFNnJ2?=
 =?utf-8?B?b2F5b1ZSSndCTU5BbzIvekgweWZkK0crclZWZUlIcWZXUUhuaTJzWG1SeUo1?=
 =?utf-8?B?YUtURWh4U2Y3Z1phVUQyUm5QLy9OaVJaV2dBYUsxM2xxcEd5cEhSWDJnYy9r?=
 =?utf-8?B?TVhwVVhLUlFVMkRTNEduZDNzTENmcVpoaThrT3dYRkVoQU9jSkhBalh3RCtu?=
 =?utf-8?B?UlFLSVhiZ0tBejJLNlhrdFRveTk3UklwTiszelp1Q2hIeXppbTJWaHcwYi96?=
 =?utf-8?B?NlZIb0d0QXhETkU0SnkzaGZyanpVamdxNzBTdXFhYTJwc3QyZTRuV2RIR3dC?=
 =?utf-8?B?bTludzh6ZTNGa0p0RThHVEJSbGMwV3ZVM3ZlUzRpRnZTQVBNcFZ3TDhWdXkr?=
 =?utf-8?B?RmRGbzVhem04NnAyd0hpU1JsQlEzRlhLcmpQVXpWTkFJWExuUDdWQ3BNeG1I?=
 =?utf-8?B?M0c3eTZZRkZKRHY3SE1CSFZxemdOcjZJZjBoMjlKRExxQzRscHozNGdUclMz?=
 =?utf-8?B?eXdpRVNPT0FIZXYwQkZ6aWZUSkJPTTBjQ3lYZjNPMGFzOFU3RXhGVE1KazJv?=
 =?utf-8?B?a0M1NzdNckYvV01aRnI4Lzc0NEtDWFpQam5YaFR3S1A1SzYzampzVVQwMnMy?=
 =?utf-8?B?ZnM4N1k5ZzFzdUpBZVF3cWcyZjdvOVdISGQrNHdaMW9zTkdreEJJQjhtbnhK?=
 =?utf-8?B?QURud0lReW9GWit4QU5wMzNwODAvM3JqUHlTdjRxa3EycGQ4dWlQcjNKVTVz?=
 =?utf-8?B?UG5JbnhaSHpWcVJjTXljMjBJYkp4OU1PdzV2NGRadWpIb1kxaDhoM0JDajFD?=
 =?utf-8?B?UnczWXFFdE82TC8wUkZLYTNCTWtXbUpTakIwUDREMjZqckhqTVdDK1E2elh2?=
 =?utf-8?B?bjIwczNpWlIxS0FIeTNUbGtNZVdpT0VRWGU0REFGSVNPK2xvWjNCRldMVy9V?=
 =?utf-8?B?ZmRzL0FKTjZHNjJRT2ZEZElNZi8rSGszZk1nV25kMFBKY1NFdWVjNlpDVUxD?=
 =?utf-8?B?bVByVVQwWkhKVUVacS9qMWpFUERTSVlSclFvT05wMzBmSDd1M0QrTUYxNjhY?=
 =?utf-8?B?VXhRYnpoT0dXWEd5cUZlSC9mM0hTYmZZMHR4RzlKS1orMjd6NFNyeThCcm1v?=
 =?utf-8?B?cStCbkZYVVBrQVNXZWNZemFRQ1BTdDFxcFJUWDFGWE1ZVjdUenhQOExqS2dk?=
 =?utf-8?B?T0YrK3FPNkFSZHJuWUtoVGVPVTRWeGQ4ZFE0dDJKWWhwM1JCMjlPeXloWWJm?=
 =?utf-8?B?a2RFMXBNZVRYcVNzL2lVKzdNME10TnhqVzBBZFhjb3REaGtsU2dWOElrREtO?=
 =?utf-8?B?dlVKWmpHUlUwUnN6cWNqL1NrZkNNSHJpTnlBK2hpUThwZU00VUxmb0JPdVlv?=
 =?utf-8?B?RHAzdy9OOFkzQXU1NFVmL0pWRHdZdEQxai8rVXlSbzd1c1NPa1A0YVJUR2RH?=
 =?utf-8?B?anVYTlNnc2RGdElsUE84T1dDTHNVVFBwODdlMThVRDFTM3ZkWWI5dmNnSDJL?=
 =?utf-8?B?amlVNUhNR042bGhNNmlhWmNlTk85dXR5dVB0N3JMVDBna01qWWc1eVk4dTU3?=
 =?utf-8?B?V1o3S0VINmUzek8xdXZsUm5VRS9lZlFoQ3EzTVpGdzJmVkxRVmdYR1RTeW4w?=
 =?utf-8?B?cFJyMithUEczaVV6dFMzRWtOSjBOS2UzeVdnWERZbGNCZzYwNk1HbnA1emtU?=
 =?utf-8?B?OWFnZEJvc0xkV09wU0VXMi9kVys0MmNFMExvYmNxK0ZoZUZodS9LMldLOUJR?=
 =?utf-8?B?eWYxYmJSMTRzNTQ5SDVUSDErNTI2QzAwcDllb0xWVG15UkFzZFhKQ3pmeHRx?=
 =?utf-8?Q?pZTHrkMmOxA/yeA15OhvpqAVE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be591fe4-cb0f-492c-614e-08dd57e66c36
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:55:32.7497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjQfMuo4cOBCX5Yexz2whBgVHcRedMEYhiVNdU3M8VqVgqGSjtNW2VIQ7l4dFC0Df/ld8DEKws8ZaJyFdQmUKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7845
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

From: Alice Guo <alice.guo@nxp.com>

i.MX95 only supports low power boot, which means A55 is kicked by M33.
There is no ROM runs on A55 in such case so that deselect IMX8_ROMAPI
for i.MX95.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 134e42028c..f38f3b2d33 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -180,7 +180,7 @@ config DDRMC_VF610_CALIBRATION
 
 config IMX8_ROMAPI
 	def_bool y
-	depends on IMX8MN || IMX8MP || IMX8ULP || IMX9
+	depends on IMX8MN || IMX8MP || IMX8ULP || IMX93 || IMX91
 
 config SPL_IMX_ROMAPI_LOADADDR
 	hex "Default load address to load image through ROM API"

-- 
2.43.0

