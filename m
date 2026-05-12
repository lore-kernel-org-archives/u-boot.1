Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9F6CD37BE
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 04:41:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E71778467E;
	Tue, 12 May 2026 06:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="b8pFBjJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B62F8464D; Tue, 12 May 2026 05:09:08 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5382E83CD3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 05:09:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFbV1xZ1KXnp/eKTkvAjv6MtEHm0x8brHSEHjVe0RvpPz1j8WpOlTsr6XCHJddw0bc44psuXz8fFVJ4c/uvEjcX1D1i83/dggba8xEhkLQGoiwp1xuCfpOxurH5OImoeY1J5RRyjBIzuLcb+jc4Ssko2eZyelcI4Prs+ScpRB9pziksypbXcuu8iI7R8HUq6OtKYOENUMkxb6Gp/lkWhbK8kikL4qjbxdMnduZ7ebT3oQAqChVa7wT0he9DZwpbKZ4L9bKG4l3RsuSc4yVGyQS6R73yPKlEYeXjqC6XVCJsU7jeSldh0EZ6/CnkRvXiIwDYWtWpugac1mIQX+uwc4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXeOhcoxrwiKE/9Abjg6E5dC0trntIMA3IwgsYQmDQo=;
 b=vQNFB//Ze3ar9vlHhClHZraS7yt9/pHZX88FjLvZVMkGJXOaOrXo5yYLxPHBcAoz37P1YBF+V9eVLEJsxxBcZV7to59526Z3AyZwcn1Kavp6tmCrjSEB4zhMBsvP/r55HHaG7GsWsCAXnait+skIxWKh2MlR/Mdn7nMnOkruEqfEzR4Bg5w2p6akqL9u9blWBpHMBAy2A9TZKmGLfgSVPfHfpt1oJkf5BDkUX/yxgzlt8bkhw+CU0iu0rFnQNjFFoeFvtZQ5JB6XqRO5DdVFiZ3Xu/kJ4iNpqNd5QvpA5w9+W2njOK4Q2C2hvytGFlx0cJ6rG+kv8OfKV69UwBjdeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXeOhcoxrwiKE/9Abjg6E5dC0trntIMA3IwgsYQmDQo=;
 b=b8pFBjJr9XcTcbGetdA1evXYJ68fMXTmXH6C/WNSWD1a0H6O/h2RYNzkuj7G+Q4JQ3JTXYpUsiZuI2Fy0UUUyHva1l16HI5SSeUyRRLjJQPuguIFKaRPQ+rA6OFlK0RzrP8ZmpiX4B6B0XTmftmVVVYRG4CAb7sxhB+vh2d5GTWHzLvPa/dzF2Fdm+jxZWP68XeO3Jylu1wm54gTp3eCjeZ9AUqzehCrj4aWtNIWYQDgWBSj6viosneMXF/eUDM/ZKCibi8Xt0cczg5Vf456uQ2UBQz0Fi4nYJV7snX+kjFuk0bDsBrekks6mUKn1CH24OpV0y4pmQxyYhTwPCUyHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by FRWPR04MB11271.eurprd04.prod.outlook.com (2603:10a6:d10:19c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 03:09:03 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 03:09:03 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 12 May 2026 11:10:13 +0800
Subject: [PATCH v3 6/9] arm: dts: imx: Update watchdog nodes for dynamic
 base address lookup
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-wdt-v1-6-0b9e1993557b@nxp.com>
References: <20260512-wdt-v1-0-0b9e1993557b@nxp.com>
In-Reply-To: <20260512-wdt-v1-0-0b9e1993557b@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Joseph Guo <qijian.guo@nxp.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Francesco Valla <francesco@valla.it>, Ye Li <ye.li@nxp.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Jacky Bai <ping.bai@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, Brian Sune <briansune@gmail.com>, 
 Johan Jonker <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, Ion Agorria <ion@agorria.com>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, David Zang <davidzangcs@gmail.com>, 
 Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Martin Schwan <m.schwan@phytec.de>, 
 Tim Harvey <tharvey@gateworks.com>, Simona Toaca <simona.toaca@nxp.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|FRWPR04MB11271:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf97a76-bb9f-41e5-bb4d-08deafd3d20e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|7416014|366016|19092799006|22082099003|18002099003|56012099003|3023799003|11063799003|38350700014;
X-Microsoft-Antispam-Message-Info: Cf04F0JVsek1gy9IvtGAZGCZ7PkvaVZeWOc+sghmV73GgZQxdy95L7ffx044DjFpGy2+5RvhNxuj+aRiw1dipA4heTSRuU0G7ydiF/4/VkwBq3ouyYlwxVkUMAFf9h40byG6I9kEbgaZdOkzTxZqAlZrzasuJjrtud7jlWVa3PEU1gYBW8coxWY9rJ/3Ex8XGq6CVtUiMHuU3+ZiQFFjObeQp3cOs5UzpxxzodhH8oBY8ZJyBC5vGR+4SjrKbrla3i0XmIqbwyRAZ2DYtneS2R0IkfDZxNCOU7p1OAV2m1m9SdrbViIoGOeSnM7XjMNQB4cuyjxJipkG/B1xwKPdj5mmm+mp3iiSvS7CCNNDPoZW+g21gsM5OcTptzef+CAUMLSdrsRXn29kCAW1C9aAkR6k9LMgFKzfIQlLlR1k/qLBecFQehXCRly3DGmWPcbWNXdf6Qbxf4LG5woxn3P1snMrdHZlasQ3Z6PSv5Nq+6MJxK+bY1MB4Hmk8GvE9xSPumSXNZcW3n/VlGdZWA6B31afFi/20Hz6ZPk2J4yj03T5YH9BFtHHfw4Vtae5zunEiMIfvXT3Y/qjmDK+hx8AxtLjKCyeFHqPcyVYbRcX7+2BfNmOLhylXxaNsWEWXl/d1JcsDWEXXEoGLEZKAUOF1My7oHujVq44hKGYdpbcDbVgG3H60/f6KTQ5/acy07TXErKNTrvx0CiqI8Phz4Io1fIuK99ZsKCSc/ICjIuFcFR6oG45vwiDn+/AnKqTJoJM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(19092799006)(22082099003)(18002099003)(56012099003)(3023799003)(11063799003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkZ5QlJIV3RnVFZ3QWtjT2RsdTg5ak9nNWU3TWM3dmpsQnlicktSczhncitS?=
 =?utf-8?B?YitiRkFCVzVmZjBUNWJCTzZjUThXbVNBTjNlVjZlaWRpNTB2NkNHRnZiTHVO?=
 =?utf-8?B?S3Z2VFVpYjZBaHNLWllPZjg4SHFYRHhvQlZNbHNidEJwd0RrbnI0TG1keitC?=
 =?utf-8?B?WkovVGt1SUJ1QUJkckRmYVVob1p0MHluVXF2Z0o4R2ZsRVV5Vml2Ymo4eWo2?=
 =?utf-8?B?bG5zVzJSWExyM3VRY1I2WW9Ec0Y3S00ya2p0NXFpNk4xeDNoSzY0aGJ6b1lp?=
 =?utf-8?B?VUJ4Z1dFY2VHVWovKzI4Qnc4RFFRRFdUYW16R2FkYmh2OVhBN2pVQTRnZFVy?=
 =?utf-8?B?T29LVUJUSUt5UUI0YVZZVnk2UC9ZQ20zajc0bHNYamZmT0hUSFV0SU0vODVS?=
 =?utf-8?B?QzhGWEhubSt2UXNwZy8vMkw2NmxabFNDWUxoOGxsL2IvTkczWEp1QjE2Z0VD?=
 =?utf-8?B?Wmc1U1owK3B2NnpSQWVvakNOSlBNN1BnazBKa05KeHl0STJ3UTk1dXBvTnhG?=
 =?utf-8?B?TmtYZ1hyelhhMmVHNDR0b2VZMExYYUpUR2VRNndUWWltTFdVbEViRmxvd0Yy?=
 =?utf-8?B?WmtvdDgwSnljdGRkMmFGTHhwQ3YwdVVXSHVPN3VIb3BZM3RlMHZ4VXB5a3ZD?=
 =?utf-8?B?VEUySmNVYjNVSmRWRHFHTmFWa2lCOEJmU2VKYVVoOHoxcEZnb2FoclUwL0RF?=
 =?utf-8?B?c0RCVjFHN3hTVnE3d1F4c3JBZ2x0K2x0Y2RWM0xZblRtRFpsUWxoM3FrZUxs?=
 =?utf-8?B?emdiS0VWZlcxQW5mNktrS3VSdWlkcHRKbEtuMGZXdjV3QU13a2VlUSsrNXNG?=
 =?utf-8?B?RGJPdUpSZU9VaDhLU3psUHVoMzZYRkt6VlZBa1JmYXFrRExkODFsQzAxRkgz?=
 =?utf-8?B?empocjh3bVdVd0kxNHE4SzhlaWx2TnhVNXA1ckRlUVEzRkhKd1pTeldxY3Bj?=
 =?utf-8?B?OXE5VzBURnY2V3dGVGJYY2kxVkxwTDlzQU92Q3BQU1pFMlVSZ2RBNUFDWkEw?=
 =?utf-8?B?cHord0YyREp6S1dYaGNnSnlaTTlrMStRU0FUVnJ6VGNib1BNZ3V1NHZhRVJL?=
 =?utf-8?B?MzgwR3lzRHZjazdtdG5KWUF5VGNxNDA3ZWR4ZFQ5MDZqZ2ZtdzB4N0tUV2Nk?=
 =?utf-8?B?YTlQcDRPOUVzM096UUxUVjRKbGt6aGV3Tkh3M21yN2VsTmY2SUFUcjBFS25M?=
 =?utf-8?B?WWN4WUxOeCtkSHY1cjcyT3UwclBqTTFmWjJjTHV4dnQydEVZdmQ2b0dtbTlh?=
 =?utf-8?B?dEhsbUtXRlBHbmdGZHRWS2FlYTNMbHFZZ0xnS2daenlVLzZ5S3pVZ2JNUVZI?=
 =?utf-8?B?VytER21TQjU5UWYxN0NiNENhWXdkZGJ3S0oyTWRzVmVCbzRodWhhNHduRHVQ?=
 =?utf-8?B?S2NwRytldllIRVJ3N2VOeTRmS3FMcUZ0ZElVanllSlJzNFhuaEtoTnlXc1Bj?=
 =?utf-8?B?VWYzOHpRc2VMSklIZWlkbHFDSzBNWWFoUGljcnBMKzZMUk9yaGRxZ1NrSldZ?=
 =?utf-8?B?dUlydWIzc09NSE45TVZCNURTNWRRcFNqcEZWOGEyOFNOY1FiNng1VitWZjZW?=
 =?utf-8?B?QjVMYWVrNU8yVVM5ODRWZVJzU0hBTzFsc2tCMkdLcmJPTjVjeDBvSXNGRjU3?=
 =?utf-8?B?aW1oa3JHOGMwaWxYc3dWRTRBeFFiWnQ2ZXFSbW5ONk1zU3EzYTJoSFBVMm1T?=
 =?utf-8?B?dDdKc3djVUR4cmxVMDRLRFpQSW5hWFI2ZTZhQklOcllZMkJ2a0Rab0dldXpm?=
 =?utf-8?B?bWNTUjNFMGFYSkNUeFJ6cERGb2FrMWdzanhuQ0lHYUJoTmRHYTRnQSt6c2wx?=
 =?utf-8?B?U3A0aEV4UzQzYWk3Vk9YZDZ1VjhjUGJpNnZKbnI5cVFmUUxuSTA1amxnQXVK?=
 =?utf-8?B?SlhmMWR1dXhoQlhZWHVwYmlHM3IxNE5XcE9oL3ZQa2tZZDhqd2RNRXFuRnZX?=
 =?utf-8?B?cGFCUWtmeEptSkJPUlJkT1NyZFhhdWtWL1VIb0lVN041ak93MWxZU01vYjRt?=
 =?utf-8?B?QVJiSE5KL0UyTE5SUERtZ3NYNmhjTVprSG1Jc1UyUk5OUXBteFBlU0ZMYTdl?=
 =?utf-8?B?eEt0SmVzeXEzOSs1SE0yUjRGRUxUTGN2M2dVZ1l4TjJnMU5EaDFVZEhWN0dx?=
 =?utf-8?B?c2hjVGJRZHA4c1dVRWk4UWg5TERXZGp3aVZrcDViZWZjYlMyL056N3gzZERH?=
 =?utf-8?B?MXU2WTFYSmw3ZjBEbCtySUtQT01INUlMSXpFN3ZDTm9hR3hHekF3cEZsOVNn?=
 =?utf-8?B?L3Q4dFZIVEVCaVV5Yk1JT1NySUZCYjNPMnRnRm44V3hFWThHTEQzVkRtV2Iy?=
 =?utf-8?B?MjZmbUNxWGM1TmlCQnhYMGFqemNNaEF2RVl4M0lSc1duNTZ4ODlZQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf97a76-bb9f-41e5-bb4d-08deafd3d20e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 03:09:03.1909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmPTreu9oCzSP/FDvvq3mIy+fAb4O2BsKqkgLHqnj0Ph+8yrsJde172Lf2XvrkRAdIUBpEsupAHiLIKj9kizxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11271
X-Mailman-Approved-At: Tue, 12 May 2026 06:40:14 +0200
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

Update watchdog device tree nodes to enable dynamic base address
retrieval for i.MX7ULP, i.MX8ULP, i.MX91, i.MX93, i.MX943, i.MX95 and
i.MX952. This allows the bootloader to obtain watchdog base addresses
from the device tree instead of using hardcoded values.

- imx7ulp: Add wdog2 node
- imx8ulp: Mark wdog3 available
- imx91/imx93: Add wdog4 and wdog5 nodes
	       Mark wdog3/wdog4/wdog5 available
- imx943: Add wdog4 node and mark wdog3/wdog4 available
- imx95/imx952: Add wdog4 node and mark wdog3/wdog4 available

Watchdog nodes are marked with "bootph-all" to ensure availability
during early boot stages when init_wdog() occurs.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx7ulp-com-u-boot.dtsi |  2 ++
 arch/arm/dts/imx7ulp-evk-u-boot.dtsi |  6 ++++++
 arch/arm/dts/imx7ulp-u-boot.dtsi     | 17 +++++++++++++++++
 arch/arm/dts/imx8ulp-u-boot.dtsi     |  4 ++++
 arch/arm/dts/imx91-u-boot.dtsi       | 12 ++++++++++++
 arch/arm/dts/imx93-u-boot.dtsi       | 12 ++++++++++++
 arch/arm/dts/imx943-u-boot.dtsi      | 19 +++++++++++++++++++
 arch/arm/dts/imx95-u-boot.dtsi       | 14 ++++++++++++++
 arch/arm/dts/imx952-u-boot.dtsi      | 14 ++++++++++++++
 9 files changed, 100 insertions(+)

diff --git a/arch/arm/dts/imx7ulp-com-u-boot.dtsi b/arch/arm/dts/imx7ulp-com-u-boot.dtsi
index f6d34e1b635..e13bcfe45f4 100644
--- a/arch/arm/dts/imx7ulp-com-u-boot.dtsi
+++ b/arch/arm/dts/imx7ulp-com-u-boot.dtsi
@@ -3,6 +3,8 @@
  * Copyright 2019 Foundries.io
  */
 
+#include "imx7ulp-u-boot.dtsi"
+
 &iomuxc1 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx7ulp-evk-u-boot.dtsi b/arch/arm/dts/imx7ulp-evk-u-boot.dtsi
new file mode 100644
index 00000000000..1944a024ecc
--- /dev/null
+++ b/arch/arm/dts/imx7ulp-evk-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+#include "imx7ulp-u-boot.dtsi"
diff --git a/arch/arm/dts/imx7ulp-u-boot.dtsi b/arch/arm/dts/imx7ulp-u-boot.dtsi
new file mode 100644
index 00000000000..88cb5716a29
--- /dev/null
+++ b/arch/arm/dts/imx7ulp-u-boot.dtsi
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+&ahbbridge0 {
+	wdog2: watchdog@40430000 {
+		compatible = "fsl,imx7ulp-wdt";
+		reg = <0x40430000 0x10000>;
+		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&pcc2 IMX7ULP_CLK_WDG2>;
+		assigned-clocks = <&pcc2 IMX7ULP_CLK_WDG2>;
+		assigned-clock-parents = <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>;
+		timeout-sec = <40>;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm/dts/imx8ulp-u-boot.dtsi b/arch/arm/dts/imx8ulp-u-boot.dtsi
index 30baaeff8ef..54ecbcf1795 100644
--- a/arch/arm/dts/imx8ulp-u-boot.dtsi
+++ b/arch/arm/dts/imx8ulp-u-boot.dtsi
@@ -61,3 +61,7 @@
 	};
 };
 #endif
+
+&wdog3 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/imx91-u-boot.dtsi b/arch/arm/dts/imx91-u-boot.dtsi
index 5b639c965d6..149f7bc685a 100644
--- a/arch/arm/dts/imx91-u-boot.dtsi
+++ b/arch/arm/dts/imx91-u-boot.dtsi
@@ -90,3 +90,15 @@
 		};
 	};
 };
+
+&wdog3 {
+	bootph-all;
+};
+
+&wdog4 {
+	bootph-all;
+};
+
+&wdog5 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/imx93-u-boot.dtsi b/arch/arm/dts/imx93-u-boot.dtsi
index dc86746ac90..a84cdf2bc45 100644
--- a/arch/arm/dts/imx93-u-boot.dtsi
+++ b/arch/arm/dts/imx93-u-boot.dtsi
@@ -96,3 +96,15 @@
 			       0x000001b2 0x800001b6>;
 	#thermal-sensor-cells = <1>;
 };
+
+&wdog3 {
+	bootph-all;
+};
+
+&wdog4 {
+	bootph-all;
+};
+
+&wdog5 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
index 8a7a6f11158..74481aeefb5 100644
--- a/arch/arm/dts/imx943-u-boot.dtsi
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -159,6 +159,21 @@
 	};
 };
 
+&aips4 {
+	bootph-all;
+
+	wdog4: watchdog@49230000 {
+		compatible = "fsl,imx94-wdt", "fsl,imx93-wdt";
+		reg = <0x49230000 0x10000>;
+		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&scmi_clk IMX94_CLK_BUSWAKEUP>;
+		timeout-sec = <40>;
+		fsl,ext-reset-output;
+		status = "disabled";
+		bootph-all;
+	};
+};
+
 &clk_ext1 {
 	bootph-all;
 };
@@ -442,3 +457,7 @@
 &sram0 {
 	bootph-all;
 };
+
+&wdog3 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.dtsi
index 6dec159752b..cc67f09ed97 100644
--- a/arch/arm/dts/imx95-u-boot.dtsi
+++ b/arch/arm/dts/imx95-u-boot.dtsi
@@ -138,6 +138,16 @@
 
 &aips2 {
 	bootph-all;
+
+	wdog4: watchdog@424a0000 {
+		compatible = "fsl,imx93-wdt";
+		reg = <0x424a0000 0x10000>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+		timeout-sec = <40>;
+		status = "disabled";
+		bootph-all;
+	};
 };
 
 &aips3 {
@@ -238,3 +248,7 @@
 &scmi_buf1 {
 	bootph-all;
 };
+
+&wdog3 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/imx952-u-boot.dtsi b/arch/arm/dts/imx952-u-boot.dtsi
index e977014992e..28f47244356 100644
--- a/arch/arm/dts/imx952-u-boot.dtsi
+++ b/arch/arm/dts/imx952-u-boot.dtsi
@@ -115,6 +115,16 @@
 
 &aips2 {
 	bootph-all;
+
+	wdog4: watchdog@420c0000 {
+		compatible = "fsl,imx93-wdt";
+		reg = <0x420c0000 0x10000>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+		timeout-sec = <40>;
+		status = "disabled";
+		bootph-all;
+	};
 };
 
 &aips3 {
@@ -237,6 +247,10 @@
 	bootph-pre-ram;
 };
 
+&wdog3 {
+	bootph-all;
+};
+
 &scmi_iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;

-- 
2.34.1

