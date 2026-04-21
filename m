Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2ECF8FA90
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98B3884329;
	Tue, 21 Apr 2026 17:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wXQxXL8c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AFAD839D5; Tue, 21 Apr 2026 15:59:24 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36BFA83693
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/roeN9ERb8OXFII98lQ+CHvmdfsBTGY5jxqPbgQyiAd6VHU7xS+yWlABBxLXnSomaJXp1Tn+RAplm0Bd2vLqJ8+2YNqBHvvM/Ok5vRowDIMDdtYSSrXE/e9xdG1vnyPZ5t3hQkpjcpEtcQkL+fO3wbUImay4yzk0Z44MQUJR1Nn+zYZiEPdjtUc5obBNrjh9Q4mFPbQTZbpqI0uOQLXt3IvnvbHJbXWarbs91zwzs6l0szrrPOU7wsMBlfxZ0S6RREJvanKUIDqBmlK8DCOmZj4na8nF80u3pn5VhIgCSbK04MduE9vG4G3HyfHibkiZlZ70AYWvuSXbeyoZQHTkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfAX1eYdMkG2rbm5uhUz9W7NrWkRw+TfscS3wNw1pjk=;
 b=SPZRw+UEHXXA9XgJ4g4G3Wl6DEdEfmV9NKGpEOy2+iqLaHadqEpg5aSEksCEzlyV34YTaTr3uE6guOohq9J81ECd7BAu51bVNS9Eb6/1mGcZ6xlage1NOyvyTP5DVMjX9lRr8P2tO/Np1zidLov8xz9Y7cAg6wGCZFXu/Sxqa0hTnob60dWK6R5Qm+S+EZasWV4oHCjtdzIQ9PJOdW4lImsyST2QN7BY71ztK49NxjGPzN1JUx9csvR3fPSvuzW5ENbZ46emkmIfJECfmxqGDJib5Sdo3tLqKotpzRuC5Pkw9u2mCARjo/6TcZNVszyFI5b1ZQ0GgLrHZp2U+6bvnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfAX1eYdMkG2rbm5uhUz9W7NrWkRw+TfscS3wNw1pjk=;
 b=wXQxXL8cwAopYRBk9eBV+On0GG4p5Wmf0Ut/uTOXcZ9mDL1p0Tsx+jGw9dq8x5lltN2+KUdlqhCl89bQUda5wCUB/mlLG2chSESDuHsG9FkkqZ69E6pDJi4twJMcyTmDO0n0rACdyJS+L0ROS7lPuKPI2QJvl44i+pQBL4auiE5RXyWjup3VVgSeJqS3a02CcSTtLpu8LRes/AZcpEbSX4iVbg/gGy0VXHswB5+IsO37EzgN1zvok2LA+e5qPdZwMXRBa2UP8NuQ1COO4/fhQ7+3YycMMfhQjOsSeePgJAgnlpfVkepk1W0WOSMVXszCqCCgmBlgahKDakQ71E23AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10426.eurprd04.prod.outlook.com (2603:10a6:150:1cc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 13:59:18 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9818.031; Tue, 21 Apr 2026
 13:59:18 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 21 Apr 2026 22:01:27 +0800
Subject: [PATCH v2 1/5] imx: soc: Get watchdog base addresses from device tree
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-wdt-v1-1-0bd01ec6a7c4@nxp.com>
References: <20260421-wdt-v1-0-0bd01ec6a7c4@nxp.com>
In-Reply-To: <20260421-wdt-v1-0-0bd01ec6a7c4@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Simon Glass <sjg@chromium.org>, 
 Fedor Ross <fedor.ross@ifm.com>, 
 =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Jacky Bai <ping.bai@nxp.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Tim Harvey <tharvey@gateworks.com>, Anshul Dalal <anshuld@ti.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Joseph Guo <qijian.guo@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5P287CA0088.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::9) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV1PR04MB10426:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae7a7cf-bd89-4867-aaa2-08de9fae2e36
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|7416014|52116014|376014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Xse6rnek2uc9jFN1DqVZnoXG5K/x5jYGEPFpAyiKmG3Zvp8C8WeFr4EUfH2XqPXDZ+UdPE36TyuvvlitwJ0zSncwCFzOx+fMNOHh04b2OCwNMN2c8omQbT1o7IzG1ozIk4lMPfP5CHvNwDNgYXGK0UeGclMQOEGacqqsdWttoAiiLGSLYoIrPCW0J+qIROiuPWkmdT1f5ThFWjAWu+Mh8JMZY3Hnv/WaYce2TfVSALH3PjE5/tsNoiThdoj7lZn6i2vtVDS3z5ZeGge/cno1l2R3SOunQ9L4Ex7pXf4AZOBW7DrX4tqajaSEogJ73L1CHmQWqugl34Pv3z+/fcwAd3ihfIThXpDJ0hCTUa8KNxMQK0kb+ZDPOYfmfngfyTQZHs9mJx6hqd5FlXqkIurBAjPwrLhxVnOaEGrVTr+E8wGLe8DwfZX10iCBwHo9d2fclyQcbmnjpfEEQHfCmgqz5QNUm8D4aqZVs6W8m2JqX3po5lh3agz5UB232FuMgQBJdZ5/7xMa4kTVm/hnvfG4feWe6QDCattUzpSXksNoabkKpmV0C4Kfg2ChfYqWNaOD8yYtLpVjE4hxE+zvh62TOC+XpYINQbesCKcluj/ejs5/xpjIpnoaxwvYBtyBz3Jqkcp/JChwSq2bZv9Sqe1gp1xOES5yRnkx2XetUD33VkQJVbLPxCHYFo+hLppElod97pVFBvz4q39fm6tpA03UnoxnyNtuuKhUbpgak0IFJluleubFMyN3H4ynzKrJEdgpsDfiY/d10EAeQffjbGZnCju9UJry8Akrg/DTFVwgEEM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(52116014)(376014)(38350700014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGdGTlNsSFBNNGpRS25SQkJZK0EvSzE1NjF6aU5UY3ZQOWpNdzI4aDZpVDM4?=
 =?utf-8?B?aW5DWk42bUdvSFB4WXEvM2kwc3NYTHl4cmo1QkFPZG55SUFmU24wWGJ6bEly?=
 =?utf-8?B?THlaY2FzU2tuWUtRWGFPdWtzZ3hCS25LUjdTWktKem04bGdDdGM0emRpeXRo?=
 =?utf-8?B?NmVwM2dsK3RZTDhTd0paNGN5OGgwbjFUODdlSUljWUdvVDRPajcvNzRlYWl3?=
 =?utf-8?B?eGw1eEtHTHNJN2dMK0p5aGJPOUlZSllKbk9VQTZneDJwQWkzOVRteVFUWldC?=
 =?utf-8?B?MzJJWEJYL3Jib05jdzNqN294aUllek9aREFrVG9rTzVqYldkZlVLdnJScU1O?=
 =?utf-8?B?SHl2K3dKNEM2VDRaTG1ib1RFSUJDZVRONzJOSld0ZXJ3a1IwQk9NYjBjZEpK?=
 =?utf-8?B?VGVndXVsa0QvaGJpU0hoS250T20yN25RWXhQSzlqUEFySnNiMHlaWVNPTkZk?=
 =?utf-8?B?dEVTRjhsWlgrNTZ1d2VQUys1NS90Zm5JVWlWV1ozRWNGM1NQQW1qU3NudkQz?=
 =?utf-8?B?MmhnWldoSDc4LzV2VUtJTzF3WEhlQ2FZcVFrS2ZaV1RGT2wwV1c0K2hIWGNN?=
 =?utf-8?B?Qm9mblRRelFQK2JpbUFobW1mRFdXT3ZaZ0RWaGEzQmwwKzJXTk92Ulg2cC9q?=
 =?utf-8?B?dG1GTVJpcWNzemZCWXNKcUVVcUFhd2o1R1FvN1g5azJrdCtDa05xaW43NXhS?=
 =?utf-8?B?ZFg2enJRdmF3ZmgrS1BvYmZCUTM3NHpTeEkreHg3VnpoL1MxeHJSckVyTnVr?=
 =?utf-8?B?Q0ZrVmFDRm0rcm4yWDUvWGtVMmZVOVlYb0JxUndPTG1pczdjWDdPTkFQMHpl?=
 =?utf-8?B?OU1Td1dQTlF3aytNNUdMSEFZbXpyRzFIUWFEMzQveVV1QkszcUtXMDdhQWZQ?=
 =?utf-8?B?MjhVemVac2k4dFFmZ3NDZVU5bUtWaXpDZE5XV2R4Y0lzeWN5bkdkaFRNMHBT?=
 =?utf-8?B?WWt2am1vY3pRSTZUdXpaTzZJVy9DWmlqM1VOZHNhdy8zcHVFNzdVeUhlK0FO?=
 =?utf-8?B?VXJNNUVENkRWREovODVvOFBadW53RWR6bk92SUZxbk1UTkY5eWJGcmNCYVlC?=
 =?utf-8?B?MXZ6M0VOcVRsQlRmMzRJeUxCWmkyVXI4UEdlckErN2FVMHRkQndLUlhJbW9M?=
 =?utf-8?B?TGJrMnpsSUVHUmRzUnlNQWNSem1SeDlaNnp2eCtvZ3o0VG42ZUNIcVhIUFJz?=
 =?utf-8?B?VnFDN29hcWE1bVVRMXNTYURmTWNLWnZ1WXNqQXRCdjR6QzZQUFVzU0lGb0dR?=
 =?utf-8?B?bFF1QWR2QUE0YlZ6d0ZMa0w4TGw5dzhHUFNzenVySUxXNGJtb2pLWGhJL3cv?=
 =?utf-8?B?MHp1VTdZZVZVTTFDb0Jsd2lUbUlGckR4ZEI5ZERJMFhzVVFxd3kvNEkxaTJW?=
 =?utf-8?B?OGlkSFlTOEpWcGVNRkZ1bFB3a25tcW05K3YxSFhoTWdBSHRWR2dleGQ0V2VT?=
 =?utf-8?B?b0lhZFNRdzYxZFI1YVhYYXhaNVcxd0FUVWxORDIvUVkwaDdrR3JhQnZrQmoz?=
 =?utf-8?B?WkxQZzUrdEJzalUyb3oyMlVaOWhYL1pHUHpjT0svd3RsM3hMeFRlZmQzdGgw?=
 =?utf-8?B?TFVCY3dMeG5udnlDLzBVZkFVSXBFK3FOMlJGNFJ1UjYyY091NXU3YllMZFU2?=
 =?utf-8?B?N2txMXpENzRWV2JvYU0vTW9TWVFzWXliazQzcG5wWjBCYWlSQU96M2RlKy9P?=
 =?utf-8?B?aVJ4eW5oWkU2ZUU0dEdlYllscWlYN3VGOFVWOGR5VmllUTdCMWsrUWlYOC9S?=
 =?utf-8?B?dG4yWkhzYytNNHU4WXJBQ3htamhFNFdSSEtFM1dnVWl0a1NIajhsNFBod2U5?=
 =?utf-8?B?cmJWWTYwMzlRbE8zdm1MV0FuYy9DL2dzdE9nd0wySllKU2JST2FtSTdXTkJt?=
 =?utf-8?B?enVVbVY0WGtOZTR0M0txeEJXZUtIczM5clU5akhrSnpjUnZpWFVjSDRQS05X?=
 =?utf-8?B?S1VaYTdVNThSaEJ3UlJwc0VEMGNFOUxueFdNcWc0ZmNpbEg2cEhMbHFmT1RM?=
 =?utf-8?B?M2hYOHBpMEoxa0VRanhsUVhYQ012OU5XcVBiTDdvc2hyTSs0cVJHZ2t0ZHZo?=
 =?utf-8?B?cDA3cVplK09lOGhWV2ljS1UwRTVIek5XRCtpRHo4b3o0RWdQQko2RDJJQ0pI?=
 =?utf-8?B?SzNsUTc3eDBZSmd3dTcxdm1EVkhjT25RQmF5QmQrRWxoSVZBN0c1b281OEN6?=
 =?utf-8?B?SHNDZVM0QkJVS1ZMd3BUUWgwK1JsT25sWlFCWW00QXpJdnlPZFAzU1dXZ2wx?=
 =?utf-8?B?RGFDWlp1ODY5eFNOS011ZS9sSUFHODRuZ1BCU29RaU1NWEZaN0o3RDREa0Ja?=
 =?utf-8?B?RGxhUVdnMVQvaFpVcnhnM1R4OFMwWlBTMUU5RG85MWJhN3hqRnYwUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae7a7cf-bd89-4867-aaa2-08de9fae2e36
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 13:59:18.3232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86vgj+VIzycQ1muHFnCCqQfmqpe7ifVdHLdMCoELW+2LsuHhMx18Zq6hnNADF30zbFztUEH6/hqTVa4xQ1iZag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10426
X-Mailman-Approved-At: Tue, 21 Apr 2026 17:12:16 +0200
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

Replace hardcoded watchdog base addresses with dynamic address lookup
from device tree for i.MX7ULP, i.MX8ULP, i.MX91, i.MX93, i.MX943, i.MX95
and i.MX952.

Move i.MX7ULP watchdog initialization from s_init() to
arch_cpu_init() because ofnode_* APIs depend on FDT, which is not
available during s_init().

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/imx8ulp/soc.c   | 14 +++++++++++++-
 arch/arm/mach-imx/imx9/scmi/soc.c | 15 ++++++++++++---
 arch/arm/mach-imx/imx9/soc.c      | 16 +++++++++++++---
 arch/arm/mach-imx/mx7ulp/soc.c    | 24 ++++++++++++++++++------
 4 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-imx/imx8ulp/soc.c b/arch/arm/mach-imx/imx8ulp/soc.c
index 1ee483065e8..ec85625ea25 100644
--- a/arch/arm/mach-imx/imx8ulp/soc.c
+++ b/arch/arm/mach-imx/imx8ulp/soc.c
@@ -343,7 +343,19 @@ static void disable_wdog(void __iomem *wdog_base)
 
 void init_wdog(void)
 {
-	disable_wdog((void __iomem *)WDG3_RBASE);
+	ofnode node;
+
+	for (node = ofnode_by_compatible(ofnode_null(), "fsl,imx8ulp-wdt");
+	     ofnode_valid(node);
+	     node = ofnode_by_compatible(node, "fsl,imx8ulp-wdt")) {
+		phys_addr_t base;
+
+		base = ofnode_get_addr(node);
+		if (base == FDT_ADDR_T_NONE)
+			continue;
+
+		disable_wdog((void __iomem *)base);
+	}
 }
 
 static struct mm_region imx8ulp_arm64_mem_map[] = {
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index fbee435786c..365891d1d1a 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -786,9 +786,18 @@ static void gpio_reset(ulong gpio_base)
 int arch_cpu_init(void)
 {
 	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
-		if (!IS_ENABLED(CONFIG_IMX952)) {
-			disable_wdog((void __iomem *)WDG3_BASE_ADDR);
-			disable_wdog((void __iomem *)WDG4_BASE_ADDR);
+		ofnode node;
+
+		for (node = ofnode_by_compatible(ofnode_null(), "fsl,imx93-wdt");
+		     ofnode_valid(node);
+		     node = ofnode_by_compatible(node, "fsl,imx93-wdt")) {
+			phys_addr_t base;
+
+			base = ofnode_get_addr(node);
+			if (base == FDT_ADDR_T_NONE)
+				continue;
+
+			disable_wdog((void __iomem *)base);
 		}
 
 		gpio_reset(GPIO2_BASE_ADDR);
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 44b3e0f5310..edd4ce89911 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -281,9 +281,19 @@ static void disable_wdog(void __iomem *wdog_base)
 
 void init_wdog(void)
 {
-	disable_wdog((void __iomem *)WDG3_BASE_ADDR);
-	disable_wdog((void __iomem *)WDG4_BASE_ADDR);
-	disable_wdog((void __iomem *)WDG5_BASE_ADDR);
+	ofnode node;
+
+	for (node = ofnode_by_compatible(ofnode_null(), "fsl,imx93-wdt");
+	     ofnode_valid(node);
+	     node = ofnode_by_compatible(node, "fsl,imx93-wdt")) {
+		phys_addr_t base;
+
+		base = ofnode_get_addr(node);
+		if (base == FDT_ADDR_T_NONE)
+			continue;
+
+		disable_wdog((void __iomem *)base);
+	}
 }
 
 static struct mm_region imx93_mem_map[] = {
diff --git a/arch/arm/mach-imx/mx7ulp/soc.c b/arch/arm/mach-imx/mx7ulp/soc.c
index 5306e76223f..d262039ad82 100644
--- a/arch/arm/mach-imx/mx7ulp/soc.c
+++ b/arch/arm/mach-imx/mx7ulp/soc.c
@@ -83,8 +83,12 @@ enum bt_mode get_boot_mode(void)
 	return LOW_POWER_BOOT;
 }
 
+static void init_wdog(void);
 int arch_cpu_init(void)
 {
+	/* Disable wdog */
+	init_wdog();
+
 	enable_ca7_smp();
 	return 0;
 }
@@ -146,7 +150,7 @@ static void disable_wdog(u32 wdog_base)
 	while (!(readl(wdog_base + 0x00) & 0x400));
 }
 
-void init_wdog(void)
+static void init_wdog(void)
 {
 	/*
 	 * ROM will configure WDOG1, disable it or enable it
@@ -161,8 +165,19 @@ void init_wdog(void)
 	 * In this function, we will disable both WDOG1 and WDOG2,
 	 * and set update bit for both. So that kernel can reconfigure them.
 	 */
-	disable_wdog(WDG1_RBASE);
-	disable_wdog(WDG2_RBASE);
+	ofnode node;
+
+	for (node = ofnode_by_compatible(ofnode_null(), "fsl,imx7ulp-wdt");
+	     ofnode_valid(node);
+	     node = ofnode_by_compatible(node, "fsl,imx7ulp-wdt")) {
+		phys_addr_t base;
+
+		base = ofnode_get_addr(node);
+		if (base == FDT_ADDR_T_NONE)
+			continue;
+
+		disable_wdog((u32)base);
+	}
 }
 
 static bool ldo_mode_is_enabled(void)
@@ -221,9 +236,6 @@ static void init_ldo_mode(void)
 
 void s_init(void)
 {
-	/* Disable wdog */
-	init_wdog();
-
 	/* clock configuration. */
 	clock_init();
 

-- 
2.34.1

