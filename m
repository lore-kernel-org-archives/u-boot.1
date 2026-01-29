Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530B6D358E7
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 09:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DB4883C61;
	Thu, 29 Jan 2026 10:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BE5DblPf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75C0083CBD; Thu, 29 Jan 2026 10:10:31 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90CA683C61
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rR2Jd5d2t5bEBMkdYF5jAd+68UKfDg/cM0sMrBwqBM8heGKYZrSWM5Bq2XBbgobQzBkQlk76ESOJMO2bcNOqGEj4gMKy1Dc9jRL0P6ImROTw+iOQYOjxeL1xfFpq8Dwh3Dg3ZuQXvU3y4BKRXFKE6jdRNUDehdORJRfa5hrsqgC/VCzhPb53xm2VhhiaJOJzT/9c9mim+84Syo7twkf3kUG1gs+0GyypOUcWUtVOvPj8JwCatHF/+XbqU7Q5rHMS098NPqf1m4+cl0FtXGIEM6qHIHiX8mDK2kWv90Kh5aSbwnf0h/3pfMZ1UpEcKJX86hFfxMSTaoNLWFoTpIcEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O00JWSbiWRtDIPYXkjWD/fuWPvHjifPxit5E/p4XTGE=;
 b=gUS41eE+i1K8aMHERkMgqOsIQUOroh645zd9dbkDPWHrRAJY5ZC+s+xawPXS3HebINmP5l9mREp1c8QK7sk4vGcgoXgQ/Yd6E73LuW68GsOSR8+ujBN/6Lsanff/TVIWXg8lYrctomuqYWQII6FzLEE1fcpeuRM2NWln/MoLcbaOn452lloN9r8zY/i7kXvFtiT4IZ4CQaIrMBy/WTyzI3nNBbqTTAlKZ+Ay1GI+bQgqyzEX2006PrbI+BuuAGYtjgXeJA+VUFfR3+1uh6ygAsh9ZpmV1nntMOOaA4Ny7IaDUHCI09x7sMNcOy2wQd6UpUYlIelz8AQ8F3IAbE4a2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O00JWSbiWRtDIPYXkjWD/fuWPvHjifPxit5E/p4XTGE=;
 b=BE5DblPfDihb4a/HzBLLzgyx2VFdtRfYOYDKM3EY4pnbq9C/u/Lv0cllGJ6zht3GGifnVbIlXgaYkh3Gu6xfw4vQ2XUyjGjFOJMO+IxIk86GjzLsI70wFCr1xXTOEQOETCiqhZoL1TtN2BtalmHnGy2b/P6D1yvWdSQS/2EeMtaqZH7CvD8GVfncfqOLjpjMnoHWr325ezmThIIp8/X2hX/P+OX5NFBeCTGWze3QF9WDVZhHp+EL1vIvlB/gWDRS8UlSKRSV2kEgigul/ASVKC54oy/hol6NBVEsC4A0rSUflhbIEiYxZVG27P8u/VFHrkW4DXmnHcL7xIc6jb2WVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7484.eurprd04.prod.outlook.com (2603:10a6:102:8d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 29 Jan
 2026 09:10:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:10:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 29 Jan 2026 18:24:57 +0800
Subject: [PATCH 1/4] remoteproc: imx: Support ECC initialization
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-imx95-rproc-v1-1-035b2dbf3e57@nxp.com>
References: <20260129-imx95-rproc-v1-0-035b2dbf3e57@nxp.com>
In-Reply-To: <20260129-imx95-rproc-v1-0-035b2dbf3e57@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 735b6930-0c58-48bf-4fae-08de5f163de7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckFTaFVzRGtjTVFuQXFicVFRY3JhSk84ZW1tcktkK09GK2x2K2MrNHUzZ0Rs?=
 =?utf-8?B?MDlHdzJjeWNBb3ZPSnZ3c1hPRXJyNjJQdmk3SFFUOXJiSTMzcWQyakpsK0RY?=
 =?utf-8?B?MWtDSmovOWVUUHpydlNnbjhWeElSSjkzYjgwbElqVTV2eFBZTUZuK3ZYdlp0?=
 =?utf-8?B?MnpFNXYvaGRLc2FBOEgxRGlDUFlJMzBFbytBZXpySWd4QjY2V1FxaHhNL2Fa?=
 =?utf-8?B?ejVZN2JGcklyZkVqUmNwa24zTVZHbmc1YzJiZ3JsTkc0dXJ3cDFtNmNvTXpG?=
 =?utf-8?B?Q3IvNG5lMW5Wa0dRR2FxQ1o5dFBzeEsrbDZ0OExBbkZsS2pGZDlrRlNNSXk0?=
 =?utf-8?B?ZXJ4ZDdmRy9qZ01tTWhRcmVzNXR2c3doRWtHSWpkblJoTlMybFNRZjZXQ1BP?=
 =?utf-8?B?MmhqcmtrM0ZBSlBCT1Q0dWZoY2ViK29YWUtkVnArQ1BaYll4YnJMUGRUMFpG?=
 =?utf-8?B?Q1JBaVJiT2x3Y09RNFJ6RmEwUEFoT1FYT3B3OVFHdWE4V3pmMCs2dDFENlYz?=
 =?utf-8?B?ejk2UU8vOVVtdnFMTy8rTm50bWVWU0w1OGdSOWlBRnRjTHRMbVhXVHNJR244?=
 =?utf-8?B?VHlTa09UU0RFZzlIZTlEVEkrcENvQmRlQmJDdExjenNJbHRVMUU1aElpU0tj?=
 =?utf-8?B?VC9sT3hYMi9udXhmN1lpSXpucjFVTTZoTUtzSVBaaFJON2wzbjJWTGVtbmM2?=
 =?utf-8?B?Nm9aRVJJT0ZiVG0wQ1lrQ1EwQTFXaDZjQWdlejBJbWF6ZWpqM1phUTEwRXU0?=
 =?utf-8?B?TDJyYzdNTWN0aFN0c1Q3WUtZTUo3S1ZWNjc0MmcyTzkybEpHMDRrQ3VoeUZM?=
 =?utf-8?B?ZG1ZWGdwR0JxbXF1VHRYWEk2Rms4SWZWd1JJcEFCR0E1cXU1cFZOWEtRa3Er?=
 =?utf-8?B?UnExUE5XOEhmbGhieTVXVStDZklXVzZnVUlqa2pUZkRQM2tMaEZ5MFVibENN?=
 =?utf-8?B?aEhodG5YaytPSFZNQU4rTUZIbDZlMVh1VEdEanBQRmJ2MWhxeHJuTEpTOEhK?=
 =?utf-8?B?cFhNWUs1d0ZJc1hQRUF6TVl3bFRjZGxxVyt1aWJSb0ZqMFRIdGxSdTNsSjJB?=
 =?utf-8?B?a1R6RW5zVW41UStLdnpCcjVLbWZ6T0RYMzFETldWMnVUQWlBdEdKRTl0ZkdI?=
 =?utf-8?B?d2g3ZHo1dTlSdElPSmhIRkUyQkhybGhMYk5taFpNVTZvNDBjTjNkWlBhUXg1?=
 =?utf-8?B?UjVSSHMwUm9qamUyQlg4UEhqRUV2NENlandHSjNXVnhDcFlZY0tvdGh3dGNa?=
 =?utf-8?B?c0lWcDNndTZpOHd2NktJYVNvMHViM0crQ2xJUS9QQ2gzODdxOUJnTVVSQU1Z?=
 =?utf-8?B?R2VYSXJaTXdCTmhmL0RqcjBMbUM4ZjBMWFZ1NWlyK1JveVJmZGI1RUl3MG1l?=
 =?utf-8?B?TEU1RUJ4WitBMTFWNk1xOC9Hak1JRGJjMUxrUjFmdjVUeVJaekliMnVOM3FD?=
 =?utf-8?B?aTdWa3N2U3cvS3JwSlhzbHRIUHAwQS9CL2NzbU10OFoxOHdXbG5SWHYwRVNu?=
 =?utf-8?B?WmlhL3ZtRDVZNWVrUXZ6eTBTUHJpQjVuNFJXclJreTA2VkY5SHZaeEFZKzly?=
 =?utf-8?B?bmdBbGljR3J3UmZwOEtydmFpWTNzVjFVMWQ1NlBLUmhkOVpGNVNGMVBLY0g5?=
 =?utf-8?B?K0g5Q0IxaHVsV0pKTlhHbU8xaittNkxCdm1HREo0a1VkZXNmUFZ2ODFnRUcy?=
 =?utf-8?B?THVYR25xZzB5R1l5SVJmdnkyVlZ5TjdGcjg0MkdVT3d6UWdybTBiK1cwMEwr?=
 =?utf-8?B?eGd2VVhwUWdVMUNiYzBucXJ6MGVBRkZjQTRMOHJlMGtWbkhCbk96akJuNVBz?=
 =?utf-8?B?TWZZT1pMeC9YTUVDS0RpQ2kwVnhoVVBtcFVacEJPSWZ4M2xLSXR0MGdaSno2?=
 =?utf-8?B?N1J0elZUUmpjcE9aa2lzNjNYMDc5OXJIM1ZBNHIybWFJU1M3UXhKeEZwY0Vy?=
 =?utf-8?B?ZTZNWElWWS96eE0zVk1rNkxwWEk1L0lCUm9QQ2xXWjN4UTR3NEtRY0txcHZP?=
 =?utf-8?B?YUZ3d0RXMVQyNCtDRGpTS3hmWlRGSUMzbzhaaFVobksvYkFFYTRWU2pTRkdi?=
 =?utf-8?B?VFdvT1dxdW81YnNweE5HS1FYMWdkSXFBdno3Znc2T0s0ZWhHK0NBdDF5cGEy?=
 =?utf-8?B?RFRqeTBOQjlkK2RPTVBaTk90NExxSDlNdFpsS0poMnR6Y2RNYmVmc0VNYmNG?=
 =?utf-8?Q?gpi/W7IlynS2wRybr3XDg9Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1pjQXpKZDFTa004NGpNVFRMTkxtenhvY1BURzVHbFprRGRrMG8wS1p4bDJB?=
 =?utf-8?B?Q3JnN2pjWkljQXE4RUdnUzhQb2xwaHdGQ05TUXBaMmMvSmttSGR1TCs0ZGJL?=
 =?utf-8?B?WnIzTEU0VkRIS1R4eFlBczNJOUFvcWFiS2FPK3gxUzZUSUV4Qlh5OXJDK2ZT?=
 =?utf-8?B?L3Q3ZjFBVmdSdUlaUTZlaGtaa28zRy93YmE1RHhpZ205Rnh6Q2NxbjZwZldn?=
 =?utf-8?B?REpkcXZSQkUzZEVQUGJHbTRwclJRNFdFVmx1NEx4Rkg0QThFSlBLN28rbjAx?=
 =?utf-8?B?N2J1NmtuTjFPYzN6RXZZY0VLRVVUQ0RsWUthN2FzRmYwQk9rV0JPZzdpMVNI?=
 =?utf-8?B?QWFqNEJDbU85cFRhVDRrd1BvaWtXdVdPSDNhR2FoUmwwRTBpNm5IajViNFl5?=
 =?utf-8?B?V2wxYVpXTDdBdmc3bWhaQktpNVNTVlJ5ZVNTV0JUeXZEUUVqQUNySFcxdWtQ?=
 =?utf-8?B?T2lnY3BiTHpDVE94Vk5LV2J0RkFRU0lzZjhna3YxOUF6eHprU2NXU1dNTXFo?=
 =?utf-8?B?c0kvUkJsZzE1bHRETmFFTG9pY0Y1ZXFaMEd3YzUzblBIRURJZ1hzWFRLdzcw?=
 =?utf-8?B?RzlISlh4cjUwclp4M3hPMTV0VWJwc05UdTdjTUpMaHBNbmtTNU15VGkrbjEz?=
 =?utf-8?B?VlQ5amhRdmhHZ08zUENNNFQ0RHB6Vjh0dXVZb1ZZQ0xLTHFSam9HQWFWZVl4?=
 =?utf-8?B?N1cxdC9YWUlBYWZNajJMU2J1TDJsTkJncjNCdnhqZjJuWEsxVU0zNThNeHV1?=
 =?utf-8?B?MnBaRmR6VlcyaTdldThaY0h1SmtqZ0RlOTlnR0w2L3V1eTVBNGFGSmRDTk5D?=
 =?utf-8?B?b3dESk1IS1NaQ0dHMjB2U2FTT1hacldDcnVHa1BXc2t3VzZDdEwyb0liNFRp?=
 =?utf-8?B?Wm1ZRkRFMWdJQjNKS0c2VTdrcVV3ZHZLU3Z5a3VPVmlTVjZjTVNTNHhkRnha?=
 =?utf-8?B?UXA5ODN3Q29Eb0NJNWhSb0RadHU4Y3haWU9LeDdKNysyc3RzUjhPT3lmTWg4?=
 =?utf-8?B?bEpka1JPOVROUXpCbjFqMERhRm13U25Ialo3YnQzMlVLUXlEMmtpdVg2TnVu?=
 =?utf-8?B?S0VyZ1RnYlhNRWE2VEhsZlN2Mk44SVk0UWFnYkxMNXkySm1QT2ZYejUvNEhn?=
 =?utf-8?B?Q2h0aU5FWlBIZHJ3ZEkrTUk2SCtqWGFQVUNxQVRRbytETjhWM1cwcDdlenRV?=
 =?utf-8?B?dzlrMGJ1OW0zL05uT1N0V3U0d1ZtQXNqT2hQR3dzSlYrWGE3ZndpTDVPMTZ4?=
 =?utf-8?B?ZXc5VFpmU21aLzZvOE5TMnozZHRyVDJ0aFY4UFh1TlhBaHVwcUl6Z2srYzVQ?=
 =?utf-8?B?djJWTUFYaFRLZnNjODdzc2p5UjlJbjd4YnAvblJDWEEvNzdxb2U3TFd6QW0x?=
 =?utf-8?B?dURBVk1wK1JrUkJwd2JWanQ1M3ZNbENJQzR1N1BzUDJSQng2dENYYzRJcWt3?=
 =?utf-8?B?anE1M3hvaWJmQi9hc2V2aURDVXB5OUZFcnpqUnFpS3dnV3BvQXNGdkJ4MXps?=
 =?utf-8?B?T3BBbHMrNUV2aG5jeVgvS2dVVTFRY0FveUd2c1RsR0JscC9kV1BzYml0cGsr?=
 =?utf-8?B?WEN3S0FkbmE3T0J0S0tYNHFrTTI0S0tpbm1Ha29xem5kMGlMYi9HVVRlb1ow?=
 =?utf-8?B?UkwzbXpDOWIreVhpdXJMK0ZHaEFWMUVyQmxxZFM5Vk1DWXljTm42VzZMOGNn?=
 =?utf-8?B?dmZKTXBvUlNGRzRSTW8yNlVRUkRHTG1zWVFjeFFCNVMrRmV6NXY0RmY5KzR6?=
 =?utf-8?B?b0Vyd1c2akhxK051Z3ptbEJmdDlTNzJUdllGV2VSakFXdW9qV3JsamFQTEQr?=
 =?utf-8?B?TitDcEFCUjJwa1h5VHBQRUlCc0RPNWlQbHVMQU5YWUZIU2w0VzVsSGFVb0xr?=
 =?utf-8?B?Z2FXeWlQYUllMFB6M3k0RmVBVlQxMVo0NTNHTTc3bW1zUWNhVUVES29USnBT?=
 =?utf-8?B?ejN6VWNGTitCRkpvTFV2b2NTT0F6WEIwaC9WbnJ3bVdrUTZZSFFNWjZGNkJv?=
 =?utf-8?B?YkU1aEJtZGd0ZVFoeC9DVWRQeFRPM2pVazZPaWMzYXZicjlJZ1VHUUx5ZmFs?=
 =?utf-8?B?ek5kckdPSHhEWHJUankwWFdjNFpvQ3ZQc1dPZGluUjRIQnE1Z3d0RkdrRG9p?=
 =?utf-8?B?TWplQVYzMTg5bnhuUW1zWFJoOWZwajNuRkxRN09YcXNRaEs4d1VVQ1Azdnc2?=
 =?utf-8?B?bUdoWk0rTElKcXcvUENVVkJQbDhRNmR2S3NId2tzSjhLNU41dXlacHdBYUZQ?=
 =?utf-8?B?dk4rN1dEVHNJc3NudWR3SGpxbFJaZ2JFL2poNW4vSzljdzVhQktRZ213R3BV?=
 =?utf-8?B?MDZPZFNvTUw4UTVXS2JHdThGRUJFc1M2MnlNZHUrdmlnRmFiU0ZxQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735b6930-0c58-48bf-4fae-08de5f163de7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:10:26.7037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ozo7ieIlOsi7QCgc/GDBizaXzwSchIOacD4Jpw5gvPrmCjGgusu0zxa8LrJ49W5O8E/aP6dMxRONvBNnPr2u2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7484
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

Add a new flag ATT_ECC which indicates the memory region needs ECC
initialization. If the flag is set, clearing the whole memory region to
initialize ECC. If ECC is not initialized, remote core will crash if
directly access the area.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 9bb55327998..9eecbe70f0b 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -46,6 +46,7 @@ struct imx_rproc {
 /* M4 own area. Can be mapped at probe */
 #define ATT_OWN         BIT(31)
 #define ATT_IOMEM       BIT(30)
+#define ATT_ECC         BIT(29)
 
 static int imx_rproc_arm_smc_start(struct udevice *dev)
 {
@@ -202,6 +203,26 @@ static void *imx_rproc_device_to_virt(struct udevice *dev, ulong da, ulong size,
 
 static int imx_rproc_load(struct udevice *dev, ulong addr, ulong size)
 {
+	struct imx_rproc *priv = dev_get_priv(dev);
+	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
+	int i;
+
+	/*
+	 * Before loading elf, need do ECC initialization by clearing the memory
+	 * region, if ATT_ECC is set.
+	 */
+	for (i = 0; i < dcfg->att_size; i++) {
+		const struct imx_rproc_att *att = &dcfg->att[i];
+
+		if (!(att->flags & ATT_ECC))
+			continue;
+
+		if (att->flags & ATT_IOMEM)
+			memset_io((void __iomem *)(long)att->sa, 0, att->size);
+		else
+			memset((void *)(long)att->sa, 0, att->size);
+	}
+
 	return rproc_elf_load_image(dev, addr, size);
 }
 

-- 
2.51.0

