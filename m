Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CF4D116F3
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 08:52:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C44FC83F66;
	Wed,  3 Dec 2025 09:52:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Rz9toEnm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C921283F5B; Wed,  3 Dec 2025 09:52:49 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4B7283F66
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 09:52:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnFUsbxNb2bEKkIhh8G5YyWArwZKqN4aFgJxus9e47H30A/AW4QGRps5kGbfPFY+H6X+erxTIdJxByqqzcUtiVjUaPTZZ3BFzCTTjuo/eZ06j3ZvmS1/CRpis/wjvVJquSLrL1p5SANiEgnR/SBKV65X16zF0hkbZZmaDzq3+A8ZEuxM7BBx+PB/9BPy6VZOFGNSpDwB5DWPVIxRBf2yL/BriqlJuTUrKdwOCUGE+6SKP0/I9lvftfj0QaOlEUCqu0s0bvlVerRP6JSwdP1m9iUX/Xf4S2TS0CSsGcleOZNgdZTUzJZJMxWxF08GdHxQoI+s814O/ON2JdOj67QSJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/m520TuS0jo6HIMI/N9U2XtFxGrsK4ql+stZTcb2v+I=;
 b=tS9tcsk6YP4Phs/wZd2d/Sas8OIMDlxC6ttnOwFqDiS2qH9ideyA1wH6B1HzUptccD50e+feNtobRVB0tsmNUVE2a5zp62xpyDqsjt5bL7RZBdq0HjDkePm9imgMr/1a+GeF3EoOgxmjwBpO4W/wS5vPToSpvUA5QIGVxSCeCAYmgmoNuyEoUOtnGdfHHlhw2/q2XQm2U/4pGVVBLd2FXruNU5W1NDtgxmwlWvXM3o7uRBhbKdc4NVz2L6C/EQKvHaf57QyWvefJoF4K8bnki57FIkT8B52ah6JIGsiavGIMNaK24AthyZGdRpXKVuIAefmZ+KgEMxvWOPd3JJ/6Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/m520TuS0jo6HIMI/N9U2XtFxGrsK4ql+stZTcb2v+I=;
 b=Rz9toEnmxgzmOXlSE+Z6cp4hUzoobAk/vRKdOuNceVCHu/hYZGa5PDy5ueOLh0AQ1Pmg3b1Mr0zzM46xtEjcIjlFbe2CPBwbb0chKb3CRaMd06J+c9TfcaNT7P/u/+iTikGc3V+tGwl7TZi5k8H4BfnuvmTLdH8OWY104ZQcgCNYJwZJeNsbVqMf07dhEaOut9jIqyLPxs6Y3ObfqwPyd/ujpCLekaqS4ndqz0yDlWQZOf8+BCj7e43dJ4d+m+GHByIt+oFZXli6C7ZhbPIm/j0h1/o3WogAGploFE2KxP2/K+AWXeRy0ssG6/jMsI3TEYqd0iJeA4TrXM6pXE7PnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA1PR04MB11407.eurprd04.prod.outlook.com (2603:10a6:102:4f7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 08:52:46 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 08:52:46 +0000
From: alice.guo@oss.nxp.com
Date: Wed, 03 Dec 2025 16:51:40 +0800
Subject: [PATCH v2 1/2] imx8ulp_evk: Move environment variables to .env
 file
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-imx8ulp-v1-1-c05ced433033@nxp.com>
References: <20251203-imx8ulp-v1-0-c05ced433033@nxp.com>
In-Reply-To: <20251203-imx8ulp-v1-0-c05ced433033@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>, 
 Garrett Giordano <ggiordano@phytec.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Johan Jonker <jbx6244@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA1PR04MB11407:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e6d3f2-083f-4a06-3d9c-08de32495421
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|366016|376014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1B1TXYvejg3MmM0eFc2WE5SYmIzSVAxR09saTNBcHJTcVlmYjIvNjd4R1VS?=
 =?utf-8?B?YlRhZ1djME95akdSUWFHZUp1UTB2S3ZhZWFRd1RqZGFZb1dJbHVXRUxpaEgx?=
 =?utf-8?B?R1pPSGRuYlpmbGhZUzFETENxL0txamIxTE9EdHZJbytBVTUxV0NveTZiUzQr?=
 =?utf-8?B?cGpqbWtmMkw4S0d4YThJMm9UcEV4aVowb1NrTmR1RDk3YXNhSjlFcnJxZm1u?=
 =?utf-8?B?ZWNpMzRRUmhaU3lxdFVXajZWUkNmQzZwVGJYaUNJMWk5SFhsdUNGbi96c2p2?=
 =?utf-8?B?Ty9vNUdhYXIvQUhja2ZPUklldkRWWnVTN2UrRlVsQmV3MGxydkxleVZubjFh?=
 =?utf-8?B?YzBOdlBpd2d6b29iNVhwY3pObTNpUXNyT1hiQmZDVHR3Uk8yS1ZnMnNnMHQv?=
 =?utf-8?B?MnNVdjZncENTY1g2bFBkNGR5Skx4WHU2TEhWTDBJQWVqRHFPT1liZFRuMW9P?=
 =?utf-8?B?aEVqSXRGN0pUV3MrRE5QS1U0RVpvZ3Y0Z1dsRDNXMFp0MGVaVTdodFlKcWhn?=
 =?utf-8?B?dVg5OG5hbkVOM3hjazZndHJGNUc0bHhhbDBuY2M0QmFEUS94bmtWb1JPRXcv?=
 =?utf-8?B?dm5mN3RiN01VUzV3NTlQblBmcFdJeXhwRkFjekVyMHl0RmMxbktCKzRTSlhX?=
 =?utf-8?B?RENBaEtSM0FQMG9oNnZIZURTWTV2MUd1N29VWEFZSC9yTEJUa21PUUxMelFV?=
 =?utf-8?B?bmpEN1FxWjVyWnpXcTlUS2I4NUJaZi81NUpBdUd0NEV3dDhzSm1TazF3dWxj?=
 =?utf-8?B?R3d6Yk1jaFRNUXBHZXJlejhKTkJUTW10SjBpMGJVSEZOajlGRWdQSDV3RHJz?=
 =?utf-8?B?MGYrOEZGMThGZFNnWUtqdEFlUFlQOVhBVUhRdndFN1QrMHhNS3VuSGVkRUxU?=
 =?utf-8?B?TldaUzNaUllkajZBWUZ1WkV0Zm9wZnJuRitmMDNYNTVQbmhUUThQUm1vMWNF?=
 =?utf-8?B?TmhMNitFdjBId3NOZVRBZmN6WDkyTEdMUWtCNTZoS2duM0dpZ2NOT0Fzc0x0?=
 =?utf-8?B?RXVweXpaRnRZa3pPMndsNlNZdzlFUHh2K3J0RThUcnE4M3prVnFFa0R5Wk4r?=
 =?utf-8?B?NjRzWlprRTgvaUlDakNPMEVtU2tiYnZyVWx6U1JadTdMMzFnMVViTXQvclV2?=
 =?utf-8?B?MFhCSklvcThuYVVCOXpjR3hvQW42UWRxWUYreE9jV1h0dGZVdUxHbEZLcURG?=
 =?utf-8?B?QnI4VzBod2JMblE2bUJDbEdnY21kTjNQWGNiYWFKbXNPVUVrQWVndFZ6bXhO?=
 =?utf-8?B?TjFHcExFMU5kem42NTRSeFhESXdwSXNndlkzNGlvSS9YOXZocFB5cm94VlNh?=
 =?utf-8?B?bzRkYjdrdVdBNDUySWVNcWw4dk5BeGJtcldTd3RzLzdRUS81K2ZCTlZETjli?=
 =?utf-8?B?YmlVOU5ybnE5WjVUM3pNSmZLeTVCZGliMjB1amFBNk01cVd5ZmpvSVNGMFRi?=
 =?utf-8?B?ZURDZk1HTVR0VUNZV3prVHB3UCtjMGVEK1BsVUwwd1o2dmxHRzVCYWtiMnVU?=
 =?utf-8?B?ME9XVzhUenVWSXNvNW50ekNLRk8rbzFKL01xMjdvNUJJMjJwSm1rOWNIT3hu?=
 =?utf-8?B?T2Y3VnVmNlBUQ3ZERnFENW5tay95TWlKdWE4WnZ0cmFVTXhpZDJZUk5sc0Jv?=
 =?utf-8?B?S1NDZEJJR290OGxXSFNUSmFUOG4zOGtOTThjM2JEQ3ZDeGRSY1JJZFQ1NGVO?=
 =?utf-8?B?MGVZUmtFcXNJTFB6M3dUM3pDY3RiSXZiUmptMHNybUlpb0YxTUdsbVJtU25I?=
 =?utf-8?B?OGdDOFVyY1VPMEFFRk1mWXRScDcwd0NkNVFUeEVDM29WRTlmanErN0VtNzh3?=
 =?utf-8?B?NjZ3RVphMUJqSm1hNUp3bWxFOWxzdG44SmdxVjQrUWdNRDUyODdDWnlJczd3?=
 =?utf-8?B?TW1YTkxTcll5b2ExU3B5aW5iTWl6dStMS1JlOHAydjZqV28rT0JJSEFmREV4?=
 =?utf-8?B?TEZnVTRIaFVtbmhrTzd2K1lkMklKd2x2VDhONTVKSzFjMmI0M0l1R0FUN3cz?=
 =?utf-8?B?cHQ4WXowaGxEbDNpM2pFZ2VUMmhqOE1TdXBKempiYUc0d2hVY01VVDYrcWZJ?=
 =?utf-8?Q?fvX513?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VC9MOERtNVY1aVZidU9HK1MzSy9ieDFMLytVSVFTZ3BYSzFGN05nUzY4UXhS?=
 =?utf-8?B?elV5bk40NzlBMGx4TGVrVFB5TE5uNlpSK3J0SEdsZVB3MkQ5eGs2dmp2S1Zs?=
 =?utf-8?B?Qlk5Y293UVFwWWdsZGtBd2VmUzRUb3NZVnpUY1ZVVnF6azBwZWlMVTVEMDhY?=
 =?utf-8?B?WXoxSGE2Ym9OOVprR29oSUxDeHJEOThQQnJIVWQ5WWlhdThaUVNKMUNqNTJU?=
 =?utf-8?B?bWx1aEVYdUJBblNvbXJwVCt0WWpGZUN0eEFTdDQvQTFmMkFBWnBZb2htc1Qr?=
 =?utf-8?B?VlJQTktyNExqNXFxOXFTb3MweGxManFEQ3d0d0RkUzJDcGNTUUdzV2hBaDdn?=
 =?utf-8?B?Q2N2dlNEVitRL1Bud3FoenIvTExFKzE5eWVyZUMybGFsTVJwZVR0TG5HUG8z?=
 =?utf-8?B?VWhPaHo0VXkwVTh5N3EzVXRRSE05MzlrdlcraGF5ZnFoSFFPM203bjNRcm56?=
 =?utf-8?B?bUlvK2Y1OXBtNjZvVVU5VHdGVEhheEhNR1BXb3hmM3AzWlFBZGRwVWMyQU5D?=
 =?utf-8?B?VXVTN2w4WGtQK0tXazYvNnJ6SkJvUEprVEZsOHAxS1RRaktSKzZUSTRzemhv?=
 =?utf-8?B?YzdzUzZSeTlEYjZ0TzE0TlR5Q2J6SVB0aU1idUdBM0JWTnR5NjFkTEwxSitF?=
 =?utf-8?B?bGhYemZwZlRQaWJTTXY4ZWdhQTFUQy91RVk3a3YvVFhTamJmVmp3VHN3ZjIw?=
 =?utf-8?B?cmRnSVArbWRVZVZ4ZGRBNlFmUmNkUXd0V0lBNlVKek80dXlTN28xcVpubndR?=
 =?utf-8?B?MUdTRjlwdi9KWFdMSDlTQytWUGxrK1hNZlNmMnBzQThzMkNobGZLNFhocWJX?=
 =?utf-8?B?LzZPeVRwOVBlU1hoZjZFWit5VFVOM3Z0QzR5UnBsSlZoaHp2UExGd2xqT1JO?=
 =?utf-8?B?dWtHRUtxMlo4bVVSUVM3OS90bEtnbHJ6dmV0citKSzRpdE9YaTQzUmU1SVdk?=
 =?utf-8?B?RlFUKzJRbjdmQkY4Y05xYTNnZmwzYXVTR2V6UjE1eWY1ZityU3IrNTZpNUdQ?=
 =?utf-8?B?SjN6UzJqQ3ZGaTh0RU1DajB4K3RlK3NLUjl2cTFVRXZaemxPMmMrelZxUHdt?=
 =?utf-8?B?MVlZcVovcmcrbitkeElOYUhkSHZzY0JWVUJvaWx4NjgwUnhELzFTM1VFWWhz?=
 =?utf-8?B?Y1JRRHI1RmhwNy81bys2NUF2UE4yRnh1a1Q3STlsblZuS1BvaXZqNmtlbS8y?=
 =?utf-8?B?TlptUjZlV29yNjBqaFR1T1c1bDNLSFVDZVBLZzBza3dUTEJycnV3MXErMHA3?=
 =?utf-8?B?OU9ML01NdnBuZ2RjYmlwUWxDK0p3WU84NVl2WnBaaEprTGRJTFl6aXIxZW5j?=
 =?utf-8?B?a2JsdHAyaTcvOGRkd3V3SmJHeVZzRGlmWnNXNFlSYzVSY1NEUkgxMGdUWjFD?=
 =?utf-8?B?ZXB6R1N3ZnV6M1h6SGlSQlVDRnQvZ2xrWnN6TjQ1VXF3aVpBZS9pU3VFRTVS?=
 =?utf-8?B?T1pySGNabXlNWUlITC9yVnJaOVFGYVByMzlQN2I0ckdVMmdrbW5zdTJyL1ls?=
 =?utf-8?B?a1BvRVNoVlIrMnp5cFJsWjYxekF5b0xsTVd1elBOQ2xxWXI2VzVGQWVLMzZ3?=
 =?utf-8?B?NS82Nlpta1I1MklsK2xRLzluWE52blArMWhoQTNEbXIrSHc2UEw0T2N3eXR4?=
 =?utf-8?B?QkJVcVhqWFRSeU5vamI0UVRCYmRQM25BWkt4RVlQQXhJaUdxWlVPMW9GREl2?=
 =?utf-8?B?eWl3MDhXLzZXNW9FeGd2dTVwYk1VQkFUNmxKbzFwcHZyc3ozdTViZXAyeXhC?=
 =?utf-8?B?a0JLMXFXcW5yR1Z4WThCaGxLVEE0c2JWQ1BCenJSS0JJa0RlUW1DRXhQWE8r?=
 =?utf-8?B?NTYvazlkVnZnWUNGTW56VW5CQUZFTDFVN1Z4aVBXUlIwY2w5eUhnVFpURkpx?=
 =?utf-8?B?WHdYYkxmOTF6cUE3dW1lR01QV1ZUTWJjR0xrUUZMVTZ5QlFFSTBhdHA4eDZR?=
 =?utf-8?B?VkxacXA3MU0zZFJiMWtYdU9FQVJOZEZVN0d6K1UxV1YwbVQ2V1lFQnpWMS9l?=
 =?utf-8?B?UWVCMjB6V2dLMlFFUUdxZFBVQnlYM1VJdEcvNWR1SGJXdTNjYnNLWTFjYUw4?=
 =?utf-8?B?Q0lOaDJzNmtmeEFYTUFLZllLTllsaytJSHg4TytqTm5hUlh0c01lZWZTVHpz?=
 =?utf-8?Q?yuwKcnOnrKAyiXvCnLz/DdpQp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e6d3f2-083f-4a06-3d9c-08de32495421
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 08:52:46.0441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DxhExZqlykdidduK1jh//V51QWubYjt5xqyrABL2RvN4a5g2x42DKklP/+OcmnmkNv4cgdtd65Asc/2+DeZ1YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11407
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

Add board-specific environment variables to imx8ulp_evk.env for better
maintainability.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/imx8ulp/Kconfig           |  1 +
 board/freescale/imx8ulp_evk/imx8ulp_evk.env | 97 +++++++++++++++++++++++++++++
 configs/imx8ulp_evk_defconfig               |  5 +-
 include/configs/imx8ulp_evk.h               | 24 -------
 4 files changed, 100 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-imx/imx8ulp/Kconfig b/arch/arm/mach-imx/imx8ulp/Kconfig
index fbca241e106..e96e34651ce 100644
--- a/arch/arm/mach-imx/imx8ulp/Kconfig
+++ b/arch/arm/mach-imx/imx8ulp/Kconfig
@@ -27,6 +27,7 @@ config TARGET_IMX8ULP_EVK
 	select IMX8ULP
 	select SUPPORT_SPL
 	select IMX8ULP_DRAM
+	imply BOOTSTD_FULL
 
 endchoice
 
diff --git a/board/freescale/imx8ulp_evk/imx8ulp_evk.env b/board/freescale/imx8ulp_evk/imx8ulp_evk.env
new file mode 100644
index 00000000000..52d7f447029
--- /dev/null
+++ b/board/freescale/imx8ulp_evk/imx8ulp_evk.env
@@ -0,0 +1,97 @@
+#ifdef CONFIG_AHAB_BOOT
+sec_boot=yes
+#else
+sec_boot=no
+#endif
+
+jh_clk=
+jh_mmcboot=setenv jh_clk kvm.enable_virt_at_load=false clk_ignore_unused mem=896MB; run loadimage; \
+	   run mmcboot
+jh_netboot=setenv jh_clk kvm.enable_virt_at_load=false clk_ignore_unused mem=896MB; run netboot
+
+initrd_addr=0x83800000
+scriptaddr=0x83500000
+splashimage=0x90000000
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+fdtoverlay_addr_r=0x83040000
+fdt_addr_r=0x83000000
+fdt_addr=0x83000000
+cntr_addr=0x98000000
+emmc_dev=0
+sd_dev=2
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcpart=1
+image=Image
+cntr_file=os_cntr_signed.bin
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+console=ttyLP1,115200 earlycon
+bootm_size=0x10000000
+boot_fit=no
+mmcroot=/dev/mmcblk0p2 rootwait rw
+mmcautodetect=yes
+mmcargs=setenv bootargs ${jh_clk} console=${console} root=${mmcroot}
+netargs=setenv bootargs ${jh_clk} console=${console}
+        root=/dev/nfs
+        ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
+bootscript=echo Running bootscript from mmc ...; source
+auth_os=booti ${cntr_addr}
+boot_os=booti ${loadaddr} - ${fdt_addr_r}
+mmcboot=echo Booting from mmc ...;
+        run mmcargs;
+        if test ${sec_boot} = yes; then
+                run auth_os;
+        else
+            if test ${boot_fit} = yes || test ${boot_fit} = try; then
+                bootm ${loadaddr};
+            else
+                if run loadfdt loadimage; then
+                    run boot_os;
+                else
+                    echo WARN: Cannot load the fdt and image;
+                fi;
+            fi;
+        fi;
+netboot=echo Booting from net ...;
+        run netargs;
+        if test ${ip_dyn} = yes; then
+            setenv get_cmd dhcp;
+        else
+            setenv get_cmd tftp;
+        fi;
+        if test ${sec_boot} = yes; then
+            ${get_cmd} ${cntr_addr} ${cntr_file};
+            run auth_os;
+        else
+            ${get_cmd} ${loadaddr} ${image};
+            if test ${boot_fit} = yes || test ${boot_fit} = try; then
+                bootm ${loadaddr};
+            else
+                if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+                    run boot_os;
+                else
+                    echo WARN: Cannot load the DT;
+                fi;
+            fi;
+        fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+            mmc dev ${mmcdev}; if mmc rescan; then
+            if run loadbootscript; then
+                run bootscript;
+            else
+                if test ${sec_boot} = yes; then
+                    if run loadcntr; then
+                        run mmcboot;
+                    else run netboot;
+                    fi;
+                else
+                    if run loadimage; then
+                        run mmcboot;
+                    else run netboot;
+                    fi;
+                fi;
+            fi;
+        fi;
diff --git a/configs/imx8ulp_evk_defconfig b/configs/imx8ulp_evk_defconfig
index e750b3d9ae0..f8a87dde5cf 100644
--- a/configs/imx8ulp_evk_defconfig
+++ b/configs/imx8ulp_evk_defconfig
@@ -27,9 +27,8 @@ CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
-CONFIG_BOOTDELAY=0
-CONFIG_BOOTCOMMAND="run distro_bootcmd;run bsp_bootcmd"
-CONFIG_DEFAULT_FDT_FILE="imx8ulp-evk"
+CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx8ulp-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2068
 CONFIG_BOARD_EARLY_INIT_F=y
diff --git a/include/configs/imx8ulp_evk.h b/include/configs/imx8ulp_evk.h
index 9308f5234f4..edfd6f70815 100644
--- a/include/configs/imx8ulp_evk.h
+++ b/include/configs/imx8ulp_evk.h
@@ -21,30 +21,6 @@
 #define CFG_FEC_MXC_PHYADDR		1
 #endif
 
-#ifdef CONFIG_DISTRO_DEFAULTS
-#define BOOT_TARGET_DEVICES(func) \
-	func(MMC, mmc, 0)
-
-#include <config_distro_bootcmd.h>
-#else
-#define BOOTENV
-#endif
-
-/* Initial environment variables */
-#define CFG_EXTRA_ENV_SETTINGS		\
-	BOOTENV \
-	"scriptaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"image=Image\0" \
-	"console=ttyLP1,115200 earlycon\0" \
-	"fdt_addr_r=0x83000000\0"			\
-	"boot_fit=no\0" \
-	"fdtfile=imx8ulp-evk.dtb\0" \
-	"initrd_addr=0x83800000\0"		\
-	"bootm_size=0x10000000\0" \
-	"mmcpart=1\0" \
-	"mmcroot=/dev/mmcblk2p2 rootwait rw\0" \
-
 /* Link Definitions */
 
 #define CFG_SYS_INIT_RAM_ADDR	0x80000000

-- 
2.43.0

