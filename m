Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735D0D116F1
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 13:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DA1F84543;
	Fri, 28 Nov 2025 14:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OBthfi7O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 273F384543; Fri, 28 Nov 2025 14:18:05 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED0E783B27
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 14:18:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bExlPpEhbhu4l7+rkiHzRKHeD+22PiL9QjsFW6yCfpEOtfGaA/H1PSQLOpJ61csyaBdr6pI98URMW5O0DlfqNW/a1hZoKD+vJbDn0WD4VJMBb7L0sBn5Fn0Ux8qNiZTq7rqNdReb7onCtOcL8vzCqp2rXitpeltxEAi3CqEPF7BE052brSdtRETfteCBGmIiu6rUhwpOE1QNKM+FmGYzWjLxoumRrfEKl3OMUmqUfJF54PHA/hpZ1B7J7HvEp4K/HYAfT3j5h8f27N5EOfqYCgal8GrH5UUx+NFI6tPQPMYxsTZAjrGNExXYPChH8MDkUBUXzBrLmaBaRhwXeYuStQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUt7Pfe8PZ9ce2EGANsx4Td+iXP/q5VK3Ha7rQPzgho=;
 b=qCll2io95aoGhFNHDt7hZaB1A2y2I9JU7434BYNef/1+tnAIGkLAfMb5hxubMwF8yFpicVcVtK+TpdHmXtpeDQL8Sff+NJehg8HpZ+gfXa2u2rzgEfhj4EwkFrYeiO85yZSL5VTveJOmzwDyXns8I85EDRGWYSYn/kSfmE25Fv9LYqqXLqxU8ccUexlGn1iexJFyfCAaeM3KpVhvvMEp4T/GpTdUD4YiYvLzaCgMTzEKUEUHsXJDrsBIRS3tmlpQ3VDz324q3e24NroTtRrMZ6fEsKAwU7WMktjhtLsSQtiyIZW0KP+gPsy9orOEL47gD0RNgkcMP2IPZXdl7SzjRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUt7Pfe8PZ9ce2EGANsx4Td+iXP/q5VK3Ha7rQPzgho=;
 b=OBthfi7OG6C9t7NuCAYpH7hFeUELoOETTpM5j+FtluST5weFPvEQ0rq5W/GHbJ36jQLkyA2JywKurVyDGSZ7P21j8qulOsr6RxSdkRlYjYuTjptXG1F9OTyRgijEBbdOfLknqQ1Jy0X2srsfuds/G8YyXwx6Bc9HjxSL1mgvMO3YHkV5G4foUm4blOdfurUK0GnY3x5Emntx1DEUqOYQvaY5z/MKta3v1I1w9preboRipWyGxLdUM9+f7GJbAm5DwF69B6qjFd6pmzCXpBG7L9Yk0MSIOdxaIzpuPgla3WdHxapFys8+8bnahjdgEYG6tyEgC4tZWnaM7QUsBie8qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by PA1PR04MB11505.eurprd04.prod.outlook.com (2603:10a6:102:4e3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 13:17:57 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3%6]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 13:17:57 +0000
From: alice.guo@oss.nxp.com
Date: Fri, 28 Nov 2025 21:16:34 +0800
Subject: [PATCH v1 2/4] ehci-mx6: Update USB host driver for iMX8ULP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-usb2-v1-2-25ec5ac127ff@nxp.com>
References: <20251128-usb2-v1-0-25ec5ac127ff@nxp.com>
In-Reply-To: <20251128-usb2-v1-0-25ec5ac127ff@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marex@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Stefano Babic <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>, 
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 David Zang <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To DU0PR04MB9636.eurprd04.prod.outlook.com
 (2603:10a6:10:320::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9636:EE_|PA1PR04MB11505:EE_
X-MS-Office365-Filtering-Correlation-Id: 2290e7ae-76d7-4942-1f46-08de2e808baf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGFTK2U5TE4xTkJXVHFSMDArdzhpa25vN2RnYzZFWDcxTFZ0a1N6TXo5K1RY?=
 =?utf-8?B?TUxBQk1CYktXa0c4K3YyV2l0NDhBS29IN2M2cDJYNWV1QXFJVnFkTms4YjZv?=
 =?utf-8?B?MWhJbmtHZHhyRFRFTHpyUzRoajBlSVFzN2xWTVdzMFhrekFqcTBMMnUzZnZK?=
 =?utf-8?B?NmRwVGdKY0RiajNwbDBNdC8xVlhRM1VMWjlONVVodzRVcVdKZGZxZHJtT3ox?=
 =?utf-8?B?WGV4VmZBTG9RUHJjVUtZVlVWOTMyT21NNWRVQStkWitqb2MvQ2crY1ByNG9L?=
 =?utf-8?B?bE9tY242NmlGbzFSYWFyMEpEK0dORWgwZy8vT0tkR09KYXBIamlCYUp1OStP?=
 =?utf-8?B?ak43YU5GLzZ1YW5hSFdQUVdHWEkyVFJudWdiUGRqTWE5QkNyOHp3am83NnF1?=
 =?utf-8?B?b3c4Wnppak5uU0g4QUg2Rmc1NVAreUk3UG01SElPRFcrTkZiam55Q1hMNDhW?=
 =?utf-8?B?OEJGNVhPMXhCTmdvT2xwdVBnNi96dzFydnh3bWlyUzBzVWVCb09xczNsTGxi?=
 =?utf-8?B?R1ExUkk2dFFQeHByRmVmWjcvenplVkFlZ0NIbjFHV1NhTnFvSVpMUzExSWhv?=
 =?utf-8?B?aFY1aG9RY2xOckROUGRBL2VSMU5FU3FLS2FrSzAvbTg1TmlTV1l1YWFOd2dW?=
 =?utf-8?B?Q2V6SHhhVjMzNDBKV3dJSVZVWUFxYW5iVGI5NUZ3RnpXTHVwTTBMVzJQNDhh?=
 =?utf-8?B?WlNUTmlqRVhUeGpUeWVJZ3oreldBUHB3TXo2QTlBa3FrSDNIZ1dGYnlqSzdO?=
 =?utf-8?B?YWpVTWpXaFNIYThkZzBtaVVubDlvRGJ2UnhweU5LUlhuQzZuQlVJWFpMdzlw?=
 =?utf-8?B?WlFpSEY1TitFQk85YUIrN21rTWI4Q1k3VWZIdGhZUmVxUTdwV0lnSS9SY1cy?=
 =?utf-8?B?b080dnJCeFpCUUxiS2lQMERwU3EvbXdXQzQrZy9NdmdxNGhVTjFLWkJWSTUw?=
 =?utf-8?B?UjBmZnNqbHdzMnlhU0c1U0FJZThGSm5JbnRISG0yTGJIUW1jNFVTUTd1TG95?=
 =?utf-8?B?TWQwUmdGWFM1cUU3SDRlR2ErQnZwUlM2MXBkaldmRm50d2xOQ1VrTkNBV09T?=
 =?utf-8?B?RWlrZFJhRHlDcENmV1JJN25OYm9MRVZLenBTUzBIbzJZMXliVWljMjNEcU43?=
 =?utf-8?B?bW9neC8xbWczUndvN242bXFqS2h6aVR4V09EbE00dlh6UGtXL0l6WEdwOUMw?=
 =?utf-8?B?TjJPdkVWWjdvaHYxZTcxVm8vQ1d2RUc3RzVmNkpuUHZBdUJVWWkvWSt6OU9H?=
 =?utf-8?B?OUJ0SHZSR0JpQzRFM29jckNDbUcwUVloaTJOWFBJdTdoMDlvSUlJU1lSdTdk?=
 =?utf-8?B?bGMwK2cwM0ZkT29KUUxqTE9LZEdFSWFoQzFQYTViY3RNbjd4UmEwU3VIS2NR?=
 =?utf-8?B?OFNKS291YnE5czdzTHNNYXVURG5VamszRGVGRjZMdUxJSDhmbURNNjVHSVBK?=
 =?utf-8?B?WDB6akROOVFNbWFuY0Ywd1pPQmhjM1hRZ2FtaWRGUWptYzVlSDk0QlVEaUFt?=
 =?utf-8?B?MWgvVVNjdmxOTEptRkgwaVlaNGdlNEdHcFlMTnVpVmJEb3AxSEVVaHp1M3VT?=
 =?utf-8?B?dHN6a1JmYlVsZnNNdGRiUUswcUJaYlVRZGxlbm8raDVNbnVUZ0JvUjl6WGtN?=
 =?utf-8?B?VkxsUTdUZFhTUCsraUI2dW0zeDBVR2xMa21TMnZFOXp2RzNyVzFBSUdVZzF6?=
 =?utf-8?B?MmxUKzhkcVBNWWk1RzgxdmRvYXdUaFB6TC9oUG94SDh6bHlMbTRVd21CSXJv?=
 =?utf-8?B?UnR1TmNUeEExM2ZVTlJnZXZoSEtlMWlHZ01yQVhjazNYeC85M2JUOENOYm93?=
 =?utf-8?B?djg1cHMra1RRSEpLYVJGVEF3bmNpK05CZVYzci9iUysyS1BnTjFKeDh3Zkt1?=
 =?utf-8?B?d1owbnhrL1pSTmFPOFczNTFsUWIvOXNJbk9VNnhRSk9TSEZtOVllTDlOQkdo?=
 =?utf-8?B?YWdOV0FXM1UyUjdEVGhwaE1FdlE3SFdUd1dNdXRvRmlidlc4Z0Y3ZE94cGRL?=
 =?utf-8?B?NTh1R3QvZzVqdVJUTm9ua0c3UnFqMksxdTNhcEY3TVNSbVlZbEpoWmxraWhW?=
 =?utf-8?Q?529ohA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9636.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW85QzJTUVJYZXFtZlJjOUVHK0wxMjBVN2xyU2p6N3NoQm5ldUhJQkRIRm5h?=
 =?utf-8?B?dmlwdEh2NHhNei8yREZpNEMzak1VZHJWVGZTaFNVdmhSSmNHMWNMVVAyMXcz?=
 =?utf-8?B?YjRGTkFYK21wbmRsTXA3MHNrbitDZFF1N1BkdHFreVdVSVJiaG9YcmQ0aExY?=
 =?utf-8?B?MVQzVStpTitlUUJ2ZW14UEVrL0lLc1lLczY3OEx5dExSeERvQzZHcTkzUFlO?=
 =?utf-8?B?dUdiQ2dzYmRYQ2doaURuNXBZaFBhWW83a2ttYWNqUWNRTDdNY0RPQTJZeEdh?=
 =?utf-8?B?enpOVlpuK3NzUFE4KzFIWXA0MTdNVG9IaWhhb29HZTJ0Y042Q254Q1c3UCtU?=
 =?utf-8?B?OXVpemMwTC9iWFdvcmRqelBPN01DQ1lZUjB5MnlrdWVMWkNwYnEvK2FERTZE?=
 =?utf-8?B?S1J6ZGh1RFlnRm1qRjlrb1hoeXp3bVhQNzU3akVFUHpEbUZabzdJaWovR1BS?=
 =?utf-8?B?ek1GVHpJWnVld3RmQUpGNGU4M2IxaDNjNEszNFVONktFb0psaGZsQnIyZld0?=
 =?utf-8?B?VmpDc0JOZ3NsVXdNV1BlbkQ3b3ZjeFArUlhVYU4vaHVFSVF5MmxKUkRZcnZj?=
 =?utf-8?B?SkhKNzFXdmxmKzE2YS9WY2c5cUhzV1JWbmxmc3pEK3BDLzJIc0laMS9WY1Vz?=
 =?utf-8?B?RGpCcHJ2aklFOFNMNXhlOC9QU05BaU5GZVIrQTNHQUFqeFlKWjJNWFZFSVpL?=
 =?utf-8?B?Ui9wWTNMSXFqQ3QwT2s2YkVOSW5vZUFBM1QycnlWN204UFpIcmNaWWpZd0pR?=
 =?utf-8?B?MTlWOHhRUjZRT2ZKaHhFdGJJczhFakp3ak9EQXlZRjU2SEVONk1sa3BaOEpp?=
 =?utf-8?B?RkcrZTVubDVmMHQxeENPMHpiYzRmL2xqd2x0N0hwQnZEQ1dMSHJXRnk5Nmk0?=
 =?utf-8?B?ZitrNVUwaUNUOTVkS3J5dmNvZVhnUlRvemVmRVkxWElQTk9WYVhEVUpKNWJ4?=
 =?utf-8?B?cFhuMURCQzkvVm01cFRrTklWNFlWZjU4TWZ6RWR1em1zY3ZCRGErYlpjaEpw?=
 =?utf-8?B?SlV5bU43Y21QRTV3TmZHRkhkY081Y2NlSDRXTXhQTnlkd1lWQTdSWVZEZkFm?=
 =?utf-8?B?YTdTY2J1d2Vvc3dwVEZCNysrYWRtODFEMURyYkZFVmxQTFRGK1Uzb256dkU0?=
 =?utf-8?B?K05hVzRGSVNSclkzT2lMYjV1bDJWeHVpQVB5eFd5MXZyTmNxR1gwK2orZmVw?=
 =?utf-8?B?QXJGZldqd0l2eEd6c0hpNlcxSFZrb0hySGNjVVh0MjFtQmZ4ZnVpWFFJZU53?=
 =?utf-8?B?WTdXQ3VCSnBTcWFlbFRleHMrQ2I0dFBwcGtkWkVkWWZ2WkFCa3diaXdHSGU2?=
 =?utf-8?B?K3NlR2czWUVoQVhDQ3NkNkNJUjFxVktnR295aHRwOUhaTTVxS3dKdmdJZnZy?=
 =?utf-8?B?WWU1bitYaHowY1ltdlZOajU5cEpUN0ZpaXAvZEVyN1MyVzQzSFJxRFRabUZq?=
 =?utf-8?B?bCtIdFhhOVRCY3cwVEhrSUpWcm1nNWxMS1FpVlVhdG9ZRDNZU3hIT2REaXdI?=
 =?utf-8?B?UUlFTUs1SlEwekM4M0VOZlcyNXYzTFQzMFdKWjhLSGVJZTZoa0ZGM1QwMDZ3?=
 =?utf-8?B?YWpzNHQ3dWF1bzgzNUowTC9vWHg5cWVKY0VYdDRPM3FjM3pkcW5JZkx6TkVj?=
 =?utf-8?B?eWJzcEgzdGNQNmhuMmtKRVVMOTFkWlRRTGFrSElrRlV1UjVIOENLNGQvM282?=
 =?utf-8?B?WTgxc2tFUDNTcEhVbkMxLzcyOCt3SHM0dmtiaGM4MENxd1UyMC9zRjBPSmRm?=
 =?utf-8?B?d1B4NVpsMnBtTEFxeUNSUWpwMnRRa0F2ak9SNDFBWStCeUR3dlBLNWEwanhF?=
 =?utf-8?B?em5sT2p3Q3ZTSlovUktWRmtLb1BxWTdWT0hRSjJDeHhPSGI4T252SUNmRzdj?=
 =?utf-8?B?RWl0d2NzeVB3ZVE3ZlRNSXBzMEVMQ0JhRXV3UW5uV3JEUENua2pjMEJkSElZ?=
 =?utf-8?B?ajlmZHlmenFWN0p5VUp0eEgzUktSdk9pNEU4TVNuQ0NuOGFoQlB0VTJGLzRH?=
 =?utf-8?B?Nm9jalY2UHpuc1U5RGlLMmhpN0tFQnFHWk9EMkUyZU9UOFgvZnI2VFE4Z09t?=
 =?utf-8?B?Zmp5SVNIc1VXQnVoTGlwM0NvZFB2U2s0K1BtNmNhRHBXWXlDWkJEaHkycmd6?=
 =?utf-8?Q?WRM7ZW6vZVGpu4gWCDhC7zvii?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2290e7ae-76d7-4942-1f46-08de2e808baf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 13:17:56.9281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4raF9sUWYmwMjHSRqZSjt4cBd7Hl9zze5q3jOdzKjERnV4FB4U4vsOmEeTmYiX0DczKGBGhtZO+VgB2Rqiyfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11505
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

iMX8ULP uses same controller and PHY as iMX7ULP, but with two instances
respectively. Update the driver to adapt for iMX8ULP.

When getting the phy register base from DTS node, change to use
fdtdec_get_addr_size_auto_noparent(). Because the cell size in soc node
is defined to 1 in dts, while fdtdec_get_addr() supposes to cell size is
2 on 64 bits platform.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/usb/host/Kconfig    |  2 +-
 drivers/usb/host/ehci-mx6.c | 43 +++++++++++++++++++++++++++++--------------
 2 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 427b62e934b..3d93d434aca 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -202,7 +202,7 @@ config USB_EHCI_MX5
 
 config USB_EHCI_MX6
 	bool "Support for i.MX6/i.MX7ULP on-chip EHCI USB controller"
-	depends on ARCH_MX6 || ARCH_MX7ULP || ARCH_IMXRT
+	depends on ARCH_MX6 || ARCH_MX7ULP || ARCH_IMXRT || ARCH_IMX8ULP
 	select EHCI_HCD_INIT_AFTER_RESET
 	default y
 	---help---
diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index 0b3f1b69657..5c5aaa4e93c 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -160,25 +160,29 @@ static void __maybe_unused
 usb_power_config_mx7(void *usbnc) { }
 #endif
 
-#if defined(CONFIG_MX7ULP) && !defined(CONFIG_PHY)
+#if (defined(CONFIG_MX7ULP) || defined(CONFIG_IMX8ULP)) && !defined(CONFIG_PHY)
 static void usb_power_config_mx7ulp(struct usbphy_regs __iomem *usbphy)
 {
-	if (!is_mx7ulp())
+	if (!(is_mx7ulp() || is_imx8ulp()))
 		return;
 
 	writel(ANADIG_USB2_CHRG_DETECT_EN_B |
 	       ANADIG_USB2_CHRG_DETECT_CHK_CHRG_B,
 	       &usbphy->usb1_chrg_detect);
 
+#if IS_ENABLED(CONFIG_IMX8ULP)
+	enable_usb_pll((ulong)usbphy);
+#else
 	scg_enable_usb_pll(true);
+#endif
 }
 #else
 static void __maybe_unused
 usb_power_config_mx7ulp(void *usbphy) { }
 #endif
 
-#if defined(CONFIG_MX6) || defined(CONFIG_MX7ULP) || defined(CONFIG_IMXRT)
-static const unsigned phy_bases[] = {
+#if defined(CONFIG_MX6) || defined(CONFIG_MX7ULP) || defined(CONFIG_IMXRT) || defined(CONFIG_IMX8ULP)
+static const ulong phy_bases[] = {
 	USB_PHY0_BASE_ADDR,
 #if defined(USB_PHY1_BASE_ADDR)
 	USB_PHY1_BASE_ADDR,
@@ -374,6 +378,11 @@ int ehci_hcd_init(int index, enum usb_init_type init,
 		(struct usbphy_regs __iomem *)USB_PHY0_BASE_ADDR;
 	struct usbnc_regs *usbnc = (struct usbnc_regs *)(USB_BASE_ADDR +
 			(0x10000 * index) + USBNC_OFFSET);
+#elif defined(CONFIG_IMX8ULP)
+	u32 controller_spacing = 0x20000;
+	struct usbphy_regs __iomem *usbphy = (struct usbphy_regs __iomem *)(ulong)phy_bases[index];
+	struct usbnc_regs *usbnc = (struct usbnc_regs *)(USB_BASE_ADDR +
+				    (controller_spacing * index) + USBNC_OFFSET);
 #endif
 	struct usb_ehci *ehci = (struct usb_ehci *)(USB_BASE_ADDR +
 		(controller_spacing * index));
@@ -404,7 +413,7 @@ int ehci_hcd_init(int index, enum usb_init_type init,
 	usb_power_config_mx6(anatop, index);
 #elif defined (CONFIG_MX7)
 	usb_power_config_mx7(usbnc);
-#elif defined (CONFIG_MX7ULP)
+#elif defined(CONFIG_MX7ULP) || defined(CONFIG_IMX8ULP)
 	usb_power_config_mx7ulp(usbphy);
 #endif
 
@@ -544,15 +553,18 @@ static int ehci_usb_phy_mode(struct udevice *dev)
 	 * About fsl,usbphy, Refer to
 	 * Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt.
 	 */
-	if (is_mx6() || is_mx7ulp() || is_imxrt()) {
+	if (is_mx6() || is_mx7ulp() || is_imxrt() || is_imx8ulp()) {
 		phy_off = fdtdec_lookup_phandle(blob,
 						offset,
 						"fsl,usbphy");
-		if (phy_off < 0)
-			return -EINVAL;
+		if (phy_off < 0) {
+			phy_off = fdtdec_lookup_phandle(blob, offset, "phys");
+			if (phy_off < 0)
+				return -EINVAL;
+		}
 
-		addr = (void __iomem *)fdtdec_get_addr(blob, phy_off,
-						       "reg");
+		addr = (void __iomem *)fdtdec_get_addr_size_auto_noparent(blob, phy_off,
+									  "reg", 0, NULL, false);
 		if ((fdt_addr_t)addr == FDT_ADDR_T_NONE)
 			return -EINVAL;
 
@@ -620,13 +632,15 @@ static int mx6_parse_dt_addrs(struct udevice *dev)
 	if (misc_off < 0)
 		return -EINVAL;
 
-	addr = (void __iomem *)fdtdec_get_addr(blob, phy_off, "reg");
+	addr = (void __iomem *)fdtdec_get_addr_size_auto_noparent(blob, phy_off,
+								  "reg", 0, NULL, false);
 	if ((fdt_addr_t)addr == FDT_ADDR_T_NONE)
 		addr = NULL;
 
 	priv->phy_addr = addr;
 
-	addr = (void __iomem *)fdtdec_get_addr(blob, misc_off, "reg");
+	addr = (void __iomem *)fdtdec_get_addr_size_auto_noparent(blob, misc_off,
+								  "reg", 0, NULL, false);
 	if ((fdt_addr_t)addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
@@ -646,7 +660,8 @@ static int mx6_parse_dt_addrs(struct udevice *dev)
 	if (anatop_off < 0)
 		return -EINVAL;
 
-	addr = (void __iomem *)fdtdec_get_addr(blob, anatop_off, "reg");
+	addr = (void __iomem *)fdtdec_get_addr_size_auto_noparent(blob, anatop_off,
+								  "reg", 0, NULL, false);
 	if ((fdt_addr_t)addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
@@ -724,7 +739,7 @@ static int ehci_usb_probe(struct udevice *dev)
 
 	usb_oc_config(priv->misc_addr, priv->portnr);
 
-#if defined(CONFIG_MX6) || defined(CONFIG_MX7ULP) || defined(CONFIG_IMXRT)
+#if defined(CONFIG_MX6) || defined(CONFIG_MX7ULP) || defined(CONFIG_IMXRT) || defined(CONFIG_IMX8ULP)
 	usb_internal_phy_clock_gate(priv->phy_addr, 1);
 	usb_phy_enable(ehci, priv->phy_addr);
 #endif

-- 
2.43.0

