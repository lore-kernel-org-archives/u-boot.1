Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEE5C5DF67
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 06:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2A6D407A9;
	Tue, 18 Aug 2026 06:16:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XS5n0qDPYQbT; Tue, 18 Aug 2026 06:16:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF4A640591
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787033786;
	bh=CBzcejzTlt5Ds3CMclc94kHRZ3z5C5rI8tIti5xHwRI=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fu1U3Hr8TK5Ht55LLq5RZ7gCQ19NCUa75RmCZna2aBWghXUQE3Mb64OWeooL7KQDw
	 OXx7tRud5kcUNKfVAros+gIfQanLr5Bd5GUUUcAgcp7GNx1SEnumyCbzBG+iMHZsSO
	 hNgkNFbeAF0UYpwLQmrNFjSjXc2qJ+U5EEnio+eX17/hOCXjxCjHL3EiVG4KhoSdhh
	 68nUx2Oz6QVhIPEncPw3npioPewH8+yI2j/v9QpzSRykpT/0QclnYeQaCuLATRGZvE
	 BTRSd7+kH5ux3HXhDxMa6GL/mbFzmaR9L6PmT3Y6Qa7pkn1irPXJwTjMFLVe0hst9D
	 e5qIwwZvdqN7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF4A640591;
	Tue, 18 Aug 2026 06:16:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 28517282
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:16:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1A12D400D1
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:16:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q8LZqJmA6dQP for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 06:16:24 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0C25640059
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C25640059
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tKORTAxm
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0C25640059
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:16:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPHGw9mzLvDCEbjufaxq9lBXi3KhI0F1qv5XGA5gDl9Skk0wQIufE23U2DF1mWkJhmD/nDIHL79hO/kWEsDHA0cU5qubBnuLS8/eqU6vIBbss/jQuHq1ympIb9AaN6t/aRkJ6ed7GYthBL6U9CXoJ2SKaaSIOEF93RqrHgG2vu3ogs54VycI5lh635iqxkf8kQcYZAIVmcEtYpUG7gSPRq31R87UHPjMdFyKajnVK7bzH7nKOKQhrWBr97I9LlciRF4lYUXx3FV2TriTpPnYXVP4S3cpQprMv/Y0JcWJ1Cnhv7g1kPtv+mVLAoFUMCMj6oHNcQSwZILOYGDlhVqXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBzcejzTlt5Ds3CMclc94kHRZ3z5C5rI8tIti5xHwRI=;
 b=aWvd6VS8xskqW+Ae5zy1+LrIS43O9Oixf7jVMFvMFOV1b4bvoQPcDXqwHhyh7AcNW3REAxGnXlakmHExY9vgFHAATa81GOFbSKov2uNH1N8cMOSwpQmAG8T4yra1ylymAqhDvoRdGEAvejICvXimmltPSDhzltTX8M+QcS+IKh11GSRD0VbjRqH118Tn6UNHbNN3uSlgcmE3n+Q0cZtFXiOaaTmnUkKqiEdBpAN1zvY/VyDrrNUGUebOZMjjEhAsH/C3ftDj+OcFtQonwvvECAtid8OeX+L3jEAwVP7atfTCCY/BRFN2WrksLv5o0GJQvGAcym3PuP5/EqzjGNrxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBzcejzTlt5Ds3CMclc94kHRZ3z5C5rI8tIti5xHwRI=;
 b=tKORTAxmYUKcEOwdAYtI27BSADI1eF+dzbMWLEZ/YOh65jLWr6X8QfUT+eURYSxf/xJLg6pRdjP3Xzgxsezm91P780LxFAS/ZG6OW/Ei+GpPZAzxyFUqRC9O+k7l6GYWPlwoIFmwbIYzYWo9EmhxJsmH+GEbzpSsCQFq1wMICqnNY7Ct0hBdEwP9z4AeZsblMhxL/LvEgAktVN+RL14jxF72dq22YVzyteGVX9iez694ag7/SR3C/H3B9rtREgqqRQAF01FuSvhxFYgLzqSnk2u0r/ckZ8uv2G21SafK5L3ulKUuhnZFIe9IqjXt2zLIDgXKIEBOCf6nwOMoHi6bCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by VI0PR04MB11574.eurprd04.prod.outlook.com (2603:10a6:800:302::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 06:16:17 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 06:16:17 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v2 0/4] board: imx93_evk: add i.MX93W EVK support
Date: Tue, 18 Aug 2026 14:20:09 +0800
Message-Id: <20260818-imx93w-v1-0-2b1784c35822@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJn5g2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0ML3czcCkvjcl0LEwuT5GQLI+OkZAMloOKCotS0zAqwQdFKZUZKsRC
 x4tKkrNTkEpAJSrW1AIdSF2BuAAAA
X-Change-ID: 20260818-imx93w-8484cc823bc0
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Johan Jonker <jbx6244@gmail.com>, Primoz Fiser <primoz.fiser@norik.com>, 
 Lei Xu <lei.xu@nxp.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2PR04CA0215.apcprd04.prod.outlook.com
 (2603:1096:4:187::14) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|VI0PR04MB11574:EE_
X-MS-Office365-Filtering-Correlation-Id: c135d131-24ae-4f70-110b-08defcf0364b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|23010399003|376014|366016|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: rAYQCdgje8RIrryu8ID+j3caXGmLFvsaIaajWYhmSH4gPHqgLzdGviDmr+ta4kn7fabs8y4JeFixR72wyTKnsPAKGJgdnSGkSOss/X9uCpgZI6pzzvYeTacPPqvVu0GfMwlcAHUVooErDenu4A1NDlzHRHQDqvprPlgHakOtRHmr7FQu/UkZbyKMxaA3dGxMF+6IN8wSuxLoaY4DDkvD6pMXS7pvB0BJNpzFhei70Ha1aXKLiiUy71vs/9lojZbynFTdaGMG7LSw1LUdrE8KMM0HqKwCDrYk9RkYQXU36k/YVr2+OjFcvtbSz1ePHEpu5EzZ0MVeNpFMlFx348xTH28b7JP4CRiTgDa7tRy70QlTDqQIAB+EJMLuhaZGuY4XE5C60jfqxw5qM0vYjJYIHWj/zPl8EnHHPxzRWy2yAkI2GpzgQb1JOCSxSHa3UcWcv4hzvSXorUIkw+qb4d9KiplWW404sc3DbKjIj5lbHUgLNIOjPwXeprNyaSexehRm1CejhCPgDOH745ntAhss2ACk9QpG97HjtTFa/IETgwCMu1JhAnJ5dxHjX6XQrPr5EnfyfI5TD0RLk7ELrQOckazWh0PP1f/eUNQExogv5g8Y3upJVOlr/h5oeAxmwWV1lxvTGP7FXP+DhARVHmGk06uL/1QID62ny8KXZpe2eqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(366016)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzlkSmsxZ2dlMDA2UExzTWNoQng4M2ErQWxTSy83dDlzODkvOXBrUGFVMGNm?=
 =?utf-8?B?b2czakdBVkVWU3c0NWMwUXcyZkc3V1RLTzllSjE5aG9UbkpWdTNyUWdrRUdv?=
 =?utf-8?B?V0dPb29QZnJTR1FISnNyb3Zjc1BuNGlHM05OSUxPZ00xZDQ2VHo1RGtwWnNz?=
 =?utf-8?B?NC9SVzVxclhBVzQ5aGhhYVJ2REl5Zy9tN0w0b2xPR0dvQlQvdzNsaktMRGRL?=
 =?utf-8?B?Z05MaFA2ckIyUi9PR3FYZ1JoWlFJTjhtS0htQUJWVy9NeGRRZE1Mc05vVzRo?=
 =?utf-8?B?V25hVHEwb2IrU2Z6MXQ0dXNUY0J3b1pURkNyR1cvUHdpVEM3K1dVM0NESWtk?=
 =?utf-8?B?TFNndFlDUUEzNVVqVW1RNnNLN0lYeklYa2RhSzlXMTltdCtpWlZ6YytZSmR4?=
 =?utf-8?B?SEdpTms2RUNQelNqbkoxN3I4S2xrWS9qK2svY1hEa0tKTkVXeW9qakZiSXBo?=
 =?utf-8?B?R0pmR2svcGhVcU5rUmF0NFhZQ2lOOThmV1pNaHdYRW4rZHhwRHJKMDFlbVk2?=
 =?utf-8?B?R2twMmJya2F3SXVnZ1kvSTBidmV5OC8xczBmbzhlVkZNblhUMDVGYkRUb1Jk?=
 =?utf-8?B?Zm5hVE5zbG9Hem9od29PSkNRZUFXOVo4WFpIdXRuYXFZNFQvQ0RGQTdKUHd6?=
 =?utf-8?B?aVJENHprL29qT1FzbjJ1VS8wVDRYTlJUVDFaU1l3N1pqUHh5WEorUE50WEV6?=
 =?utf-8?B?VllocExCblJPRzh1ZHlyTHZNRC90N0RPdVFaanp6eElzN1NPUVM4MGhYdVJq?=
 =?utf-8?B?UDZrdFZ0bUxDNTVBVU8xcE9LcDhTSG1SdkxEQWhtZHB0bGorejRwbjZIMEVT?=
 =?utf-8?B?VjJkeHR1YVRrUktUN3lMb1hqSFZZMWcwb0pLMXl2MjVWRGVxMHgrNnEvNE1y?=
 =?utf-8?B?dTlod083amdYbWlsMmZSUjZKZFNzYkVxWjZKQXM4dHphRlJnTWQ4WGNkbkpj?=
 =?utf-8?B?WFhjZUk1V2pqdXpKZ3pKYjlabnNNZUl2VUxWL1U4c3RaSlh6OHg0YTdZQ1hp?=
 =?utf-8?B?ZnJjWHNBbXA3Rk5MZWdmWWtoUXk4b2tJN1RHd0d0dUhFRGE0K1pRUXQ2aXJK?=
 =?utf-8?B?eWF5eGduREtyd2tOR3RYcVBWSkZSRisxS254d0FodGZNUmVBMUJVUndnR1Jm?=
 =?utf-8?B?SjQrcmhwTXBGcVI4b051U0NOWndrM3ltbWl5NzdjNERqMzVDR2xSSS9BY05H?=
 =?utf-8?B?V3RielhXNE8zOHFqV0Z2a2g5S3FDeklyM1dtMXIvUHdVZVQ4NUJPUU43RnRv?=
 =?utf-8?B?cDVsOHBZY1piNFJXNWVQUTRIU1NDN0JkNGhSTjlxSk92V0NZTHVpYTkwNDNX?=
 =?utf-8?B?QXQzOU92RXFpMjJOdVZDLy9sS2RxVjlLUk53d3cwVUkzeFlWTm14VVBEMi96?=
 =?utf-8?B?ajczc3NoWnRqQjZFK0xxaWc3RlBFTjhKL1Bzak96anR4Nm9EOTNycStYeWh0?=
 =?utf-8?B?QmtDaWZ1aWhQWEN2UHRhOFQ2NENMem5qYTRlMjhUWW1MQ2UrdlpLNDE4ekwv?=
 =?utf-8?B?YlEyWHY3TVFmSytHclcxcHpqbHd2REpnbFpLM0hZNHVhODZndkdOcERZZHNV?=
 =?utf-8?B?UnZGaG9qblBSclN2Ly9zMnJGd1VmZ2dYYlB2MzlpY052OUFpbmpUMHIvVDhW?=
 =?utf-8?B?NjZFeWZuQnpwS0wybnJocWxibGViaXBCeUx1SU9vN3Bubzh6OW5WN1VPQ2NT?=
 =?utf-8?B?RE1YNEVJYnBURGUzNElrQVI1NjhrUVA4OEVQNnNLUU04ei9jOTJuWHh4Vjht?=
 =?utf-8?B?ekFGNThhYTJGb05sYmVMK3hGU3MwbENUdXBxM1VTNjdaNnhQQVZ5MG9uUjdK?=
 =?utf-8?B?ZmsvMjMraWNqUFRQaUlJcHFXUkpIbXd2NWZ3STYvNW42TlJYQ1F6TDhzRTJ2?=
 =?utf-8?B?dkJrUGFycXpKN1c5UWlkb3BrRnRodEo2SG1vS1IvYk5ISjBsOHBWdnZ6bElu?=
 =?utf-8?B?azh0V3crdHE1SFZ2N3B6SCt5SldPdjVTalRXeTdKRTgzVGw5V1hBQ2p3Z1cx?=
 =?utf-8?B?RW45UjZQcWhnWDZkdG8zalJDTDVoc0FZek43NEg3cHQ3Y3FrWXJPN0xMZU5K?=
 =?utf-8?B?Mk9aRzhRSGlVM214Q3d2QzkzMlhzVUdWY0k3SFJqOHAxMVdvL1JMdm52Y0Y3?=
 =?utf-8?B?N3JxOUpmRnpxRW1DTHdGZGN6bEhRcUdNU1lvWW9HUmwxZFNDYlF2U0ZOYnR0?=
 =?utf-8?B?LzY1MmhBaDBINGxuTENFc09ZcXZYTGVTZGRoMWx4UVJ3K0dla09YU2IwSWts?=
 =?utf-8?B?R0ttYWtPa2diL1NhQk5jU1ZEaGEvTGlyWWdmZnlkTUZtaWpCcTdXc0gzcjAz?=
 =?utf-8?B?MXRqcC9uSzJGRGFBdFNpdmpDQXJaU1ZQaWtnZU4vcnlXbFFYKzJYb2dnN0E3?=
 =?utf-8?Q?yhIcop4TDOqkNt8HaN0YGDDquh0Soy6Ej84f7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c135d131-24ae-4f70-110b-08defcf0364b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 06:16:16.9671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBsZTS1dxFBJwaT51OixebvOvvy1t5xqkeA3YaZbZ+EdogmzYc5DIYKQZpyP3QSFlyLlWAvZG57NHCWiZVibkElxN8ULH5GoyLHGNZ52T6t2mPHBngPnBNPf/QKHVUdh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11574
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series adds U-Boot support for the NXP i.MX93W EVK board, a variant
of the i.MX93 EVK that uses LPDDR4X memory running at 3600 MT/s.

Changes in v2:
- Remove defconfig duplication

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (2):
      imx93: clock: add 900MHz entry to fractional PLL rate table
      board: imx93w_evk: add board support for i.MX93W EVK

Ye Li (2):
      imx93: clock: add 450MHz DDR PLL rate
      board: imx93_evk: add LPDDR4X 3600MTS timing tables

 arch/arm/dts/imx93w-evk-u-boot.dtsi              |  171 ++
 arch/arm/mach-imx/imx9/Kconfig                   |   12 +
 arch/arm/mach-imx/imx9/clock.c                   |    2 +
 board/nxp/imx93_evk/Kconfig                      |    2 +-
 board/nxp/imx93_evk/MAINTAINERS                  |    2 +
 board/nxp/imx93_evk/Makefile                     |   12 +
 board/nxp/imx93_evk/lpddr4x_timing_3600mts.c     | 1998 +++++++++++++++++++++
 board/nxp/imx93_evk/lpddr4x_timing_3600mts_ecc.c | 1999 ++++++++++++++++++++++
 configs/imx93w_evk_defconfig                     |  172 ++
 configs/imx93w_evk_inline_ecc_defconfig          |    3 +
 doc/board/nxp/imx93w_evk.rst                     |   72 +
 doc/board/nxp/index.rst                          |    1 +
 drivers/ddr/imx/phy/ddrphy_utils.c               |    4 +
 13 files changed, 4449 insertions(+), 1 deletion(-)
---
base-commit: 527115ef6783cec49e5610c523c124b399011361
change-id: 20260818-imx93w-8484cc823bc0

Best regards,
--  
Alice Guo <alice.guo@nxp.com>

