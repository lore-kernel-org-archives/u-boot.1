Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB02F8FA66
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:25:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45EC184258;
	Tue, 21 Apr 2026 14:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NcZxQxHb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C0B6801A9; Tue, 21 Apr 2026 14:25:45 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D6BD842E1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KByV4yy6aKyxmnlu3ELtx7sZnXow/qY6oSNstbPHMql6HlEWocfEWj8qRsX7R0e2AzuB/idVCdSjkEnYPmmm0/U0SXrWUFSlCH2jy8S7wHOW1inECLbvufKRTwMAhIjhvw3IqMMnYTP0p1L9KFAM7SXJEZnHiwYKhuQn8Xw4jtYS+znq8R6mbnxavgSG6+ASdIPS1oNQoBxbETwFBpcnEl8oLe4y/nU3WzYL9paJdmEsNmpV3hzA+AFCeNQpvcVp9raraXwGZlSZwOYGIfSzE4ZkG0meqpr1o7vloTry60cLYuzTtKLrdPfjIjcPvzGEHg4cPBtmZyuf53UIQsVVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CXOninQ8tVLobekXFACSL93eiX5GN/OiA3utpezSyQ=;
 b=cpJ+92+wyK9ny8OgdpsHBRxvCO5/9dNs2S/g3UDtQpk+T/sNDfzD9MjKDEat6pUiia9AHPZBVAktrPfMbdS1jQP3aOO+5+MCJwtOM1cHa/Bj3P5hsoUfBow9dZoSEhqz1QcqU7M/MnEvQ5T0cRx+Ln+1h12Y5ADlVUUx4BPixI6p/S2eUAsbsUX7z4xdRpMj3pbDU5j10ea4pmVvv+LmZ1U8dNz0ADPZ3Qgu44RERFjGyRD0vgu+TO+2WjhjWzRCmDQmiF8fWDt9eKFxKNwWUyQCsQyazPXrB91rjCYVaN+2azYMD69OSAEga9QUML6PEhKnW3PWinY7Nd1N5DUNPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CXOninQ8tVLobekXFACSL93eiX5GN/OiA3utpezSyQ=;
 b=NcZxQxHbCWPktexy7Ym7w8/d2eV9UuKui69SBJZXp8NqaesJ+DECBbKlwFUlURLHG3SHMGvMldtYwATlwcDFknotPvQeiTAG6evvwtpxL6dcDiyDvqSXO8xHlXiK04Ulu7zernMAMSO0h8nWW3mwkl8QUpUjjN3YCnfJJ5WBDz7vdbf1QFzWU1aSMxH59HSp/xHm098iPLvd6D0X6rT3KK+U1KPLseaQWlQ+XN98i3ovYjWAXQs+UOiaNrU1hKNDxFTdXXdxGAmYbVw22loOLcA7cjTz1EHllKaKYO4617MmUrBKsAMgRpYG4eHxvvLR9+njJH5EfFGWqRiXkA+Dkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9349.eurprd04.prod.outlook.com (2603:10a6:102:2b8::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 12:25:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 12:25:38 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 21 Apr 2026 21:41:19 +0800
Subject: [PATCH 07/15] imx8mq: Correct signed_hdmi firmware position
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-imx8mq-dm-pmic-v1-7-0e2b490542b1@nxp.com>
References: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
In-Reply-To: <20260421-imx8mq-dm-pmic-v1-0-0e2b490542b1@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 kernel@puri.sm
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>, 
 Ye Li <ye.li@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marco Franchi <marcofrk@gmail.com>, Alifer Moraes <alifer.wsdm@gmail.com>, 
 "Lukas F. Hartmann" <lukas@mntre.com>, Patrick Wildt <patrick@blueri.se>, 
 Marek Vasut <marex@denx.de>, Heiko Thiery <heiko.thiery@gmail.com>, 
 Ilko Iliev <iliev@ronetix.at>, Angus Ainslie <angus@akkea.ca>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MAXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 48211a62-3690-4153-f3e6-08de9fa117e5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|7416014|376014|1800799024|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EZeeW1XlmM+uwZ2v1OTEmzNL6octBb6LsvgOlqU7APYGiXL9P9RShK/rp2j/p4A68kWBe4c/Uf+pVmIe1nnFMQjRJ047udnIAP9K/5DJhWYijEKSIatoDOZy78GWW6A6z2aLcwrz+svswhvmyu3Hf0ck3qmt8QiYGUM96f6V8YciHKdPfnsFQ37xiWVQLfqqbpYRqTf4exIjsaZNzE1MD9362IXTHWjdCmJn/9oW+Xe7EqDbIrHyXSRNHNYsFMZtTtGuifW822E+zIBgvcDYTVKNq9tp4HoU3tl66biu2HF6S5W1950rf3uq6aBR+PnVnvlf6um7TatnsRzEfx1hFPbWaYeJJOUqpM7FvDa2/ggMTTkY8a7bnCOXeEXpubLexXH6kH95+rzcA7IcVYSSsEKG0SvVcR7kdTBFBgGnwMJAaovNK1+SG4/3rw0xlXn5nrx85HlYH6BBqoBF8PCm0fiJxI6FRr6w/cwi23/d2nd0KpuMLr63rGXJPrigwsYJjRjvkyG2hygmyTF7EMNjUM+yrdM23eAUZnSyri+C1qeghenPF6xKwnk7N8sRXZxV0ZDB6e7ZMNtPTE3r0xXjoI0XvxUWOIrfHHO4uhxQfNCohKCwwhSERP0RcGgx089md8OjXdQBRIqr8VoZCzOm1Za6hTOkyvx4QjtAA5uI36P0sDQzrvcenzzu2j9z3J76V7PIWSh80Hu0y8juiBA75UXqYH4C/t0YYNBgDQCaY4pFGkCVcNJ9HwYJfx+WheNKEmOmcvzagK6vfrvKeN1yE9to9ILBaQFGp+D3AVydm1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUwzNnpHK2JTY2ZPUElhRlNxcExNc0pDa0xPT1BSdmpJWWRheUtkcDhzQmRl?=
 =?utf-8?B?dGIwQlBLV25SbnRaK3hPa1ZWcE5RakYxRiszVWp4cVdtUkdZM0FRdGNzYlJm?=
 =?utf-8?B?QU9uU1pXOWwvU24rcHlWckNxcGRxVXBmR3Fpb2JuTC93NlNkbEpoaVBlVEVh?=
 =?utf-8?B?bStwWUd2c2R0ajcxdy9YWEFESUREUm0wZlJsaWM3SlZXZXpzUVBwdVlxYXI2?=
 =?utf-8?B?eU9NOUoyVmNjSGliT3MxOThYRmVCYUxzam1KdzRnMW5KSFNPMEgvTmhtQTIx?=
 =?utf-8?B?N3hKSlc4MWM5enBGdmtUc1lPWlFMNDJlUkVneWc1TUhZenlmZ1RVcTk5aFkw?=
 =?utf-8?B?Ym05Tk5TSFpvM1cwUVNoMnBVK1VSNEhoM2ZuZG5SZis3MUpmRWdlWlJlVGlx?=
 =?utf-8?B?T29WVDJvWFoyT3RNLzRSSUFJWlFuYUtFakdVQzJ2RmFyMUZWTDZzR0d0OEwx?=
 =?utf-8?B?Vjc4WnhxWU4wMjJqQ3FqeG1UUDhSYWllVzNjOHZWNWVMNm5WVEpJVitHRTB1?=
 =?utf-8?B?V0p4b0hSWnBXUm5PSkZEMUc3S2ZyMVl2aGdNdFl5MENudWtjOFh1SGFVNVkr?=
 =?utf-8?B?U2Zxd1MvVTJzSFhFbC8rNWN1VGFFSVNaQW0xYmZtWkdUM1NjVGJnNzdaZzZI?=
 =?utf-8?B?VEJ3NmRTdEZwOSt5OEJRWXFzckl1U3BBbzFuaW9hU0tGVFRIaWQwb1U2eThP?=
 =?utf-8?B?MW9waFdpb2ZXVGQ5bkR0OThyK2V5aXppS2t5VVp0UzVDa0JiZ3dxbGVQNTQx?=
 =?utf-8?B?and5RzRyVU10OUlwcXgraFBvREZZemdtYUhmY3l5a3QxZlIrRGVIOTZpbllX?=
 =?utf-8?B?K0Zwa0p6ejFENlZjL3FoaVEzTThFNUo1SDdxQ09yWHFTSkJ5S09BWnFQY1FZ?=
 =?utf-8?B?cXh6NkI2N2dLTTlMdHgzdStieU5zcXF1WEs1M3dIR2VGYXJxMmY1akFNZ0Uv?=
 =?utf-8?B?anVua3pUSHpCWFF6bXQvMmJ2RUJqd0daM0x2ejhkUHRGQzV6M0Q1dHZiT0Vh?=
 =?utf-8?B?RjNXMXh5Um4wcTB3UGtURWhUM2Y1b1VSV0FGSW5oTXhTQjZUOWFhZFdxM2x1?=
 =?utf-8?B?UE9QcXVvY1dERVFQRXVvZmxIRjBKaGU4emhMWHl1Y2NXemNSNUFoVnlHR0ow?=
 =?utf-8?B?QXJEeXRxRXprTnJkYWxpV1JsbzBQdldDaWVZWktvODdPeUJxb0Uzb0pvVjNR?=
 =?utf-8?B?T0FjUHVGUU9CaUlJcFVUK3Y3RFUwNlVEaDBGTXhXRVFvZ1lYL1BzeFpMMTZv?=
 =?utf-8?B?a01vMmwxWFVMOTFFY1BZSmt1SllEc0xLRGpSOEpUZjBEaG8renlhOHl3c0tU?=
 =?utf-8?B?U3k5T2N0TW0zNFZOdFNZUUROZUxSa2ZYbi84bzFQQmZSNkJBSkxydERTV3FN?=
 =?utf-8?B?dzBzSUdCbk1CWjc1RUpSS1pmdUcyWlhwWWNEM0w5Wktpd1VPbGplYTVwOGdj?=
 =?utf-8?B?dTZVK2NjRklQNDMrU1NwcWN1WENWWmtNbHFUSFROblIzNHNiTHJTNWxCMEZQ?=
 =?utf-8?B?UnJxb0pEZDYzL3hnb3o0clcvSk8xenhuTXNTdnlKY0ltanZZVWN4MElna25h?=
 =?utf-8?B?TCtBWjVNMThva2tOLzJ4TzkrNEhjZExkVjR3aDZ0L3dhK3FkM2kzUW9rc3lG?=
 =?utf-8?B?Vk1aOTNObTVNNW5vK3EwTTBUek11T0ROSTlTdkVSTXd4enVNMDNPTGt0REFi?=
 =?utf-8?B?YUlYUkFJcG45QmQrT0pXVE9lV3BXT0ZxN1dMQSt4SG15RDQ2cnB6TzFqMEFW?=
 =?utf-8?B?SkI5RGlmUEpVeEZYdlNZKzB0Ujlya0wyMlJFZmxVT3lyS3I1VXMyM29JVmJz?=
 =?utf-8?B?SDc1bDB5VnlOSk85TVhXanZmakFjTnMwelVZYUVKeCtNV0Z4RHcwSkJPVHg2?=
 =?utf-8?B?MDlES2JoV1FReXRuNmtYeTNTQWxuNFFrL3pUYlRqcEpSZy92M01oeHdwcm1v?=
 =?utf-8?B?cFJqYlh2Yy9ycWZJamxBbFJQN0lSQjJzRysxaEtmbUhoN0t6cnpkWFVDbFZo?=
 =?utf-8?B?eTk4eGdjL3RWWWN4WmZNZmY3N2xqd2pkU3JKRlJMODhWTkNTajJid20rajE3?=
 =?utf-8?B?TDdSUDQ0N3k0ekRpTkNadXBKaHlDM0tYeVhIQ2pVUUU1cnllV0U1RmJwNXAy?=
 =?utf-8?B?emRxQzBOdjlZcVZYZWRoVDhsOWM5M1psd3hGaDA5aHVQbk5vVVNZUzlVLy9H?=
 =?utf-8?B?a0dJaGJjNjh5dkNPbFgybnJvNzBxa2Rzb2NNT2JMQy9HdTFRYzVsYmtCdndp?=
 =?utf-8?B?ZitqUjY0RHJ0VGU4YkJXcTFqU0thLzJ4NGxiUzJJUEo1RC8vOEtldEZyeS9K?=
 =?utf-8?B?TDZzZWRwTmxwcVpzYW9BdkNGcEVNT2Z0S1YyU0lIenkwSG1iUm1DZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48211a62-3690-4153-f3e6-08de9fa117e5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 12:25:38.1549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgyYJhZdaj0SEC4d0Of9h2MLFAm+OeOHlTifeZz7TAsR8pPWLfm+JEJ9Ld8jZ46C59360VagSzqqV6tgp+rpYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9349
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

signed_hdmi_imx8m.bin is already signed and has a IVT header. It should not
be put in u-boot-spl-mkimage.signed.bin. Move it to head of flash.bin
following NXP imx-mkimage. Keeping it in u-boot-spl-mkimage.signed.bin also
consumes a lot of TCM space which is not expected.

While moving it to head of flash.bin, other changes are required,
u-boot.itb is put at sector 768 per defconfig, so u-boot.itb binman
offset should be updated and it should be moved out from binman section.

Also binman symbol address are updated, so need to subtract u-boot-spl
image_pos + CONFIG_SPL_TEXT_BASE to find the correct location of ddr phy
firmware.

Because there is 1KB padding in HDMI firmware, use 32KB when burning
flash.bin to sd card.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi |   2 +-
 arch/arm/dts/imx8mq-u-boot.dtsi            | 240 ++++++++++++++++-------------
 doc/board/nxp/imx8mq_evk.rst               |   4 +-
 drivers/ddr/imx/phy/helper.c               |  13 ++
 4 files changed, 148 insertions(+), 111 deletions(-)

diff --git a/arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi b/arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi
index 98da015a444..4d326040c0a 100644
--- a/arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi
+++ b/arch/arm/dts/imx8mq-librem5-r4-u-boot.dtsi
@@ -10,7 +10,7 @@
 	bootph-pre-ram;
 };
 
-&binman_imx_spl {
+&binman {
 	section {
 		signed-hdmi-imx8m {
 			filename = "signed_dp_imx8m.bin";
diff --git a/arch/arm/dts/imx8mq-u-boot.dtsi b/arch/arm/dts/imx8mq-u-boot.dtsi
index 0687fcdbd68..ed2c704f2e5 100644
--- a/arch/arm/dts/imx8mq-u-boot.dtsi
+++ b/arch/arm/dts/imx8mq-u-boot.dtsi
@@ -41,6 +41,33 @@
 	filename = "flash.bin";
 	section {
 		pad-byte = <0x00>;
+		/*
+		 * signed_hdmi_imx8m.bin contains a 1KB zero-filled padding at
+		 * its beginning. This padding has no functional purpose, but
+		 * the firmware is provided and signed by NXP, so the head
+		 * must be preserved and should not be removed.
+		 *
+		 * When the signed HDMI firmware is placed at the beginning of
+		 * flash.bin, the IVT header of u-boot-spl must still reside at
+		 * a 4KB-aligned address. Since flash.bin starts with the HDMI
+		 * firmware (including its 1KB padding), there is already a 1KB
+		 * empty region at the head of flash.bin.
+		 *
+		 * The required 4KB alignment is therefore calculated relative
+		 * to the location after this 1KB padding. To achieve this, we
+		 * explicitly set align and align-size to 0x1000, and add an
+		 * additional 0x400 (1KB) fill to account for the padding.
+		 */
+		signed-hdmi-imx8m {
+			filename = "signed_hdmi_imx8m.bin";
+			type = "blob-ext";
+			align = <0x1000>;
+			align-size = <0x1000>;
+		};
+
+		fill {
+			size = <0x400>;
+		};
 
 #ifdef CONFIG_IMX_HAB
 		nxp-imx8mcst@0 {
@@ -51,145 +78,142 @@
 #endif
 
 			binman_imx_spl: nxp-imx8mimage {
-				filename = "u-boot-spl-mkimage.bin";
-				nxp,boot-from = "sd";
-				nxp,rom-version = <1>;
-				nxp,loader-address = <CONFIG_SPL_TEXT_BASE>;
-				args;	/* Needed by mkimage etype superclass */
-
-				section {
-					align = <4>;
-					align-size = <4>;
-					filename = "u-boot-spl-ddr.bin";
-					pad-byte = <0xff>;
-
-					u-boot-spl {
-						align-end = <4>;
-						filename = "u-boot-spl.bin";
-					};
+			filename = "u-boot-spl-mkimage.bin";
+			nxp,boot-from = "sd";
+			nxp,rom-version = <1>;
+			nxp,loader-address = <CONFIG_SPL_TEXT_BASE>;
+			args;	/* Needed by mkimage etype superclass */
 
-					ddr-1d-imem-fw {
-						filename = "lpddr4_pmu_train_1d_imem.bin";
-						align-end = <4>;
-						type = "blob-ext";
-					};
+			section {
+				align = <4>;
+				align-size = <4>;
+				filename = "u-boot-spl-ddr.bin";
+				pad-byte = <0xff>;
 
-					ddr-1d-dmem-fw {
-						filename = "lpddr4_pmu_train_1d_dmem.bin";
-						align-end = <4>;
-						type = "blob-ext";
-					};
+				u-boot-spl {
+					align-end = <4>;
+					filename = "u-boot-spl.bin";
+				};
 
-					ddr-2d-imem-fw {
-						filename = "lpddr4_pmu_train_2d_imem.bin";
-						align-end = <4>;
-						type = "blob-ext";
-					};
+				ddr-1d-imem-fw {
+					filename = "lpddr4_pmu_train_1d_imem.bin";
+					align-end = <4>;
+					type = "blob-ext";
+				};
 
-					ddr-2d-dmem-fw {
-						filename = "lpddr4_pmu_train_2d_dmem.bin";
-						align-end = <4>;
-						type = "blob-ext";
-					};
+				ddr-1d-dmem-fw {
+					filename = "lpddr4_pmu_train_1d_dmem.bin";
+					align-end = <4>;
+					type = "blob-ext";
+				};
 
-					signed-hdmi-imx8m {
-						filename = "signed_hdmi_imx8m.bin";
-						type = "blob-ext";
-					};
+				ddr-2d-imem-fw {
+					filename = "lpddr4_pmu_train_2d_imem.bin";
+					align-end = <4>;
+					type = "blob-ext";
+				};
+
+				ddr-2d-dmem-fw {
+					filename = "lpddr4_pmu_train_2d_dmem.bin";
+					align-end = <4>;
+					type = "blob-ext";
 				};
 			};
+		};
 #ifdef CONFIG_IMX_HAB
 		};
+#endif
+	};
 
-		nxp-imx8mcst@1 {
-			filename = "u-boot-fit.signed.bin";
-			nxp,loader-address = <CONFIG_SPL_LOAD_FIT_ADDRESS>;
-			offset = <0x58000>;
-			args;	/* Needed by mkimage etype superclass */
+#ifdef CONFIG_IMX_HAB
+	nxp-imx8mcst@1 {
+		filename = "u-boot-fit.signed.bin";
+		nxp,loader-address = <CONFIG_SPL_LOAD_FIT_ADDRESS>;
+		offset = <0x58400>;
+		args;	/* Needed by mkimage etype superclass */
 #endif
 
-			binman_imx_fit: fit {
-				description = "Configuration to load ATF before U-Boot";
-				filename = "u-boot.itb";
+		binman_imx_fit: fit {
+			description = "Configuration to load ATF before U-Boot";
+			filename = "u-boot.itb";
 #ifndef CONFIG_IMX_HAB
-				fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
+			fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
 #endif
-				#address-cells = <1>;
-
-				offset = <0x57c00>;
-
-				images {
-					uboot {
-						arch = "arm64";
-						compression = "none";
-						description = "U-Boot (64-bit)";
-						load = <CONFIG_TEXT_BASE>;
-						type = "standalone";
-
-						uboot-blob {
-							filename = "u-boot-nodtb.bin";
-							type = "blob-ext";
-						};
+			#address-cells = <1>;
+
+			offset = <0x58000>;
+
+			images {
+				uboot {
+					arch = "arm64";
+					compression = "none";
+					description = "U-Boot (64-bit)";
+					load = <CONFIG_TEXT_BASE>;
+					type = "standalone";
+
+					uboot-blob {
+						filename = "u-boot-nodtb.bin";
+						type = "blob-ext";
 					};
+				};
 
 #ifndef CONFIG_ARMV8_PSCI
-					atf {
-						arch = "arm64";
-						compression = "none";
-						description = "ARM Trusted Firmware";
-						entry = <0x910000>;
-						load = <0x910000>;
-						type = "firmware";
-
-						atf-blob {
-							filename = "bl31.bin";
-							type = "blob-ext";
-						};
+				atf {
+					arch = "arm64";
+					compression = "none";
+					description = "ARM Trusted Firmware";
+					entry = <0x910000>;
+					load = <0x910000>;
+					type = "firmware";
+
+					atf-blob {
+						filename = "bl31.bin";
+						type = "blob-ext";
 					};
+				};
 #endif
 
-					tee: tee {
-						description = "OP-TEE";
-						type = "tee";
-						arch = "arm64";
-						compression = "none";
-						os = "tee";
-						load = <CONFIG_IMX8M_OPTEE_LOAD_ADDR>;
-						entry = <CONFIG_IMX8M_OPTEE_LOAD_ADDR>;
-
-						tee-os {
-							filename = "tee.bin";
-							optional;
-						};
+				tee: tee {
+					description = "OP-TEE";
+					type = "tee";
+					arch = "arm64";
+					compression = "none";
+					os = "tee";
+					load = <CONFIG_IMX8M_OPTEE_LOAD_ADDR>;
+					entry = <CONFIG_IMX8M_OPTEE_LOAD_ADDR>;
+
+					tee-os {
+						filename = "tee.bin";
+						optional;
 					};
+				};
 
-					fdt {
-						compression = "none";
-						description = "NAME";
-						type = "flat_dt";
+				fdt {
+					compression = "none";
+					description = "NAME";
+					type = "flat_dt";
 
-						uboot-fdt-blob {
-							filename = "u-boot.dtb";
-							type = "blob-ext";
-						};
+					uboot-fdt-blob {
+						filename = "u-boot.dtb";
+						type = "blob-ext";
 					};
 				};
+			};
 
-				configurations {
-					default = "conf";
+			configurations {
+				default = "conf";
 
-					conf {
-						description = "NAME";
-						fdt = "fdt";
-						firmware = "uboot";
+				conf {
+					description = "NAME";
+					fdt = "fdt";
+					firmware = "uboot";
 #ifndef CONFIG_ARMV8_PSCI
-						loadables = "atf", "tee";
+					loadables = "atf", "tee";
 #endif
-					};
 				};
 			};
-#ifdef CONFIG_IMX_HAB
 		};
-#endif
+#ifdef CONFIG_IMX_HAB
 	};
+#endif
 };
diff --git a/doc/board/nxp/imx8mq_evk.rst b/doc/board/nxp/imx8mq_evk.rst
index 4b0624e7e86..4a9d9e404c5 100644
--- a/doc/board/nxp/imx8mq_evk.rst
+++ b/doc/board/nxp/imx8mq_evk.rst
@@ -45,11 +45,11 @@ Build U-Boot
    $ make imx8mq_evk_defconfig
    $ make
 
-Burn the flash.bin to MicroSD card offset 33KB:
+Burn the flash.bin to MicroSD card offset 32KB:
 
 .. code-block:: bash
 
-   $sudo dd if=flash.bin of=/dev/sd[x] bs=1024 seek=33 conv=notrunc
+   $sudo dd if=flash.bin of=/dev/sd[x] bs=1024 seek=32 conv=notrunc
 
 Boot
 ----
diff --git a/drivers/ddr/imx/phy/helper.c b/drivers/ddr/imx/phy/helper.c
index b0dfc3a0b4f..147ec9ab061 100644
--- a/drivers/ddr/imx/phy/helper.c
+++ b/drivers/ddr/imx/phy/helper.c
@@ -38,6 +38,8 @@ binman_sym_declare(ulong, ddr_2d_dmem_fw, image_pos);
 binman_sym_declare(ulong, ddr_2d_dmem_fw, size);
 #endif
 
+binman_sym_declare(ulong, u_boot_spl, image_pos);
+
 /* We need PHY iMEM PHY is 32KB padded */
 void ddr_load_train_firmware(enum fw_type type)
 {
@@ -49,6 +51,7 @@ void ddr_load_train_firmware(enum fw_type type)
 	unsigned long dmem_start;
 	unsigned long imem_len = IMEM_LEN, dmem_len = DMEM_LEN;
 	static enum fw_type last_type = -1;
+	unsigned long spl_start = 0;
 
 	/* If FW doesn't change, we can save the loading. */
 	if (last_type == type)
@@ -67,6 +70,9 @@ void ddr_load_train_firmware(enum fw_type type)
 	dmem_start = imem_start + imem_len;
 
 	if (BINMAN_SYMS_OK) {
+		if (IS_ENABLED(CONFIG_IMX8MQ))
+			spl_start = binman_sym(ulong, u_boot_spl, image_pos);
+
 		switch (type) {
 		case FW_1D_IMAGE:
 			imem_start = binman_sym(ulong, ddr_1d_imem_fw, image_pos);
@@ -83,6 +89,13 @@ void ddr_load_train_firmware(enum fw_type type)
 #endif
 			break;
 		}
+
+		if (IS_ENABLED(CONFIG_IMX8MQ)) {
+			imem_start -= spl_start;
+			imem_start += CONFIG_SPL_TEXT_BASE;
+			dmem_start -= spl_start;
+			dmem_start += CONFIG_SPL_TEXT_BASE;
+		}
 	}
 
 	pr_from32 = imem_start;

-- 
2.51.0

