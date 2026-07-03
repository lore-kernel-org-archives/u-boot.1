Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E30BC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 11:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1477A84A1D;
	Fri,  3 Jul 2026 13:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="hIpvSd2b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E340484832; Fri,  3 Jul 2026 13:56:46 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B66BF84832
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8V7hP0TAi79RlkjkAA2SqDdDCYvlG+5ZWqr0fCrHzTrTLNqW7cpSe9rJj3RT45D1aE3IlfdlKUGYmJyncjBx4/fqUjWwMCXqV/3xDaIYwNKHwV3dstek9JZGW3HxBUEnTVunQMX8BXDCn5ApYJRB75rNXI1Pm9bN+5e9GhduJROVpJEejacoIpMG7XlOtHDTwv+XzD5v4g6PzIDwPS7TqvvP8HZJoNoBz7uMQ7S7/vtLRtDesoowz/J5Np7JI/NxeHUNaiq1WliUbAt5+vwlghfqjd8T+AuW3CfWT+/A8QdFrhAeCPtu2gwGWIkh0ypxWKwuvkwD1ekxAo7Rc8/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmImVdH/ATtavlNqKStfNM7nxyKZrVnpA6zuhgTp7Zo=;
 b=kepeSDz5oMg5Qme7sCh5DBT6hcBKXoI5W0fg6j29/Hk6IP1AjDhVjlhV6oU+EMhezSnkkeAlQOh4eWUKBa6WLxnoq6rTIP8I/fUPGAmAilbCPAuRHyl6M2z039hJyrES4vlVf1iFpc2jYX3DvlE1+DSiugIzArBUE7oGL2x/qTgj8RlpsekRpwlYDlSh5WiEoO4EaICXXCB9JwnhnLDCDLFk9S+31osTr1qp4b69c0SH8egXK/ALr75opv48pXbIwTm1+ci2V+WgU/kvI8xDt4WeU8XaUdGPO2rkv1UV8RR8KLqi0WmEh94r4YgxMOmYYA6V+nQg2jyjJpU+IujlqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmImVdH/ATtavlNqKStfNM7nxyKZrVnpA6zuhgTp7Zo=;
 b=hIpvSd2bSp3qBKuX10OjkPS9APmN2dIL9hEv5V7RNO8xsLjxa3k61wD0weTQLFlslrsYk8PcKbtm0rVg1fDZMQHdznqHYKfAiNAUhBtw0h5ZRMjGu1c79i/dv05rR0IZ34B21muogaPZmhSv6Oyn8cqUiVoL3klj4mGz3vfR/5O8X6eSQ9ToIQbx0jinWF8f9GlDigoPcnMVfDMbU4/Xek+GPCaZsH9mxY9BLSk3S/NanFiBpBw9Qm5NJiNmA/AI53gag+luGfnQK3nEdWv6s+mYoy6tUxUjLTReoMDny8Jak+6UfgBMSp3FSNabD94pPL83g2DUe9txssYB+zC1wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAWPR08MB9448.eurprd08.prod.outlook.com (2603:10a6:102:2f0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 11:56:38 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:56:37 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v15 00/24] pinctrl: add support of Airoha SoCs
Date: Fri,  3 Jul 2026 14:56:03 +0300
Message-ID: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAWPR08MB9448:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f59df30-d501-43bc-2762-08ded8fa2319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|52116014|366016|1800799024|921020|38350700014|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: OaVLykTvvASpgXbbMf8nhFaKffNCGiVEtn3d502d/x+ENJrNDqFUH94kofAqS/qy6qRDeoZk3zaMXCGNs12ORj4pzqlsm3Oo8mZ2i9E/DssB3qGpZ42n4NiUPM80AYBMl9TgwqVcoLAlZ3YgQW208Dlwatqum1DNoWcDJQOkDNqqXrSgtzIccK4T7aRoUNsbeH/pgjgHkUCzQYQGu4JD6OYEdp8zrZnantmLh8tBvbQf0Or20TJqKaMoWEzalhjAmIYZ+F5xAU9QLsmi+6jFaEKl+smZe7qGlrfKhD0s+//Xr3ombmSay8VKiBFnhHWqwV8pEBpab2+YgAOxZ+bydhl/yvNT0/o6Dw5LrlDdpit3c8QslCpkxpxnWys/NtdWlnpV67hIqw9cO2tXXFk7nJDJmgP65jpb+Qx6aLGcu6lXRFQj7Q1FjnNB3UZ4h9J5BzNNzwzMR6EVZy9YcEo9adw8TW+SEd0QqeU8PWER7Fp/qt9ZD6sL6tSix2jqmWFRhcqt7GnBYRaC03twtsuHYijb0GBvSCKVWX5P0Qdfi5MVu0zBZGS1T+WY1HdpOxKDKJ7UqjD41cluUP1zaAG/AYYlLfAsDTylDt9U63xyfL2C4N1FhMc6q+aumtDroe8npDdAjxoYPeBaqyceZz+ewbhBZvYhIObKXRs3nm6iij61cEEmkbvB7IIiZ+dtDUKOhsT77BzusGt9xUtBCsBpQR5xIwyTByDxsn7XPKr2vUklJg0QNEk81TYgaPSayWKw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014)(18002099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjNNY0QrUHZ4MlpWUUMxQWxmUlpvNDJyUHpaa1RIQkVEUTAveERybkU4Ymhn?=
 =?utf-8?B?aTRjWkQ1a1A5ek1VYk41QVc4K3pxZUJSOFpVYWRjdjNSRFJQMEd1UElFTERB?=
 =?utf-8?B?cWo2cFlNNGZTbjhnRmVZWU05cjF0QUFVOEYxdFMrelJmNEF4MGxEM3puSVlL?=
 =?utf-8?B?TmUzcUR0WEx4ZjhmclZmTks0ZEk5Z3NGVGFSaWIrY1FVWjVBU0dtWDEvUHVO?=
 =?utf-8?B?MmJ2TndvQ1VVTXNwSVJXa2VxL3hwOXpSSGlIUE5HM2RaUm11amQ0TUxWQll4?=
 =?utf-8?B?RWVJUGlGM1oxVXM4dHByMW95YTNPazRLVVJ4Nit5L1pKWFBZbzRPcUcwL3Bi?=
 =?utf-8?B?dFNxSG01QWpKYmZuUVZMc0FuOXd6cEk5VW9OWGZreERTakdKYU1mdWJ6Unk2?=
 =?utf-8?B?K3U1cVprODdxMEdCTmFMYTdISXIrVThVTi9oZzE1UVVFSlFibEJVSDZLVGN1?=
 =?utf-8?B?VHhFUXY0dHBlZ2RlMk45VGJjd2VNc0h6Q2V1c2Z1ZWY3Q2tPYmdpRGtWNmFJ?=
 =?utf-8?B?Ulg2TTNlTFovTGRaRTRhQnVhSzJkdVJUTDRHSU1VYzBPY0RFS0cyZ2ZsOURl?=
 =?utf-8?B?dUlnTjQwbkZPQWVLL0pDUjVJMUUwR09VQlNvMWdoRDJjRm5SM1FRa1dVYllG?=
 =?utf-8?B?bEdKV293Q2d6MWViRTduN2ExSEF2STJOTVJpK1YybXdqaHAyUE9QWFJoa0ln?=
 =?utf-8?B?czh2NmNyYkNic0VhWHg1N1ZhMWo1ZjZXVE8zelF5UkRUL2FWUzR5Vy81cnFF?=
 =?utf-8?B?Q1VVdnlJRkdqdkpWdi8zaTIrNjBHa0hBM1A4cnRsb0IrNkxia2I5eHRWN3Jp?=
 =?utf-8?B?bjFqdkR0M2hrbmh1RDBacmM1VkpyWGRIWDI2TVJGQ2tZeFNLaEJiTTNrdkND?=
 =?utf-8?B?ZkQ4UzRURlVSQlczK2VhWVl2dVVDck92M1c0bVl6QVhzZ2ZHZ3RrQS9OQzYw?=
 =?utf-8?B?UkJEaGsvSFJPSjVXOGlsNUkyZmRiU3JzR3NPa2ZOQlBubmg4VE05MitBenhP?=
 =?utf-8?B?TmxMQ3hwU3R0dzVzM3gwVEhZY0FiY0ZnSEZvK1RUMjRucGF2eTdVcndycVdw?=
 =?utf-8?B?WDZuOWVHTVZzOUQrRXhtd0piNjZBWUM2NzdSaXVSeGROMC8wOThUbmJwMkI2?=
 =?utf-8?B?OWVuczdrdWREYnRjbnFYQW0ycFgwcjZNN3M1ZUFsQ2VTUjBqNHBqanJDTlp0?=
 =?utf-8?B?TTRuU0hCRG5wdWVERzJJSG1PRVpPUlRZUnRnUEd1QlRmMEFQUi9JRURHZDF4?=
 =?utf-8?B?RFdEK3lYV2YrYmVsSktBUDRYM2t4dFRjaTEyWWNRcXFiOVJSNU1Cc1ZIaWpR?=
 =?utf-8?B?MG9WZWkwS0pxYWhlZjZOY1VFMzJ1cVgyS1dWbEpib0dPNFBuc1gvRXB4M3M4?=
 =?utf-8?B?NnJYRkVXWVh5RVRXVHRnRWt5U0VVTjBEUXZPWEhhS05hK2hDRmtybElzY3l3?=
 =?utf-8?B?Uk05Rk1DclBRMHJwTnV5S1UrZGMxSC9PcWhtdmZRazBONG1mWjJjNFF5cWY2?=
 =?utf-8?B?ZzBMOUFxY29iL28xUk5UR016cThWd2R0VW1OTVM4dmZHb0l4Vi9zVmk0WXNr?=
 =?utf-8?B?OFNCNk5GdkxGcVNRdWNOcW5rZ1hzOGNxa1lCTS9DdkJBeHU0WndQTEI2TFU0?=
 =?utf-8?B?cGNBaGtYUnVrNlhEc2xVWFkvMG9FZ01zOTFEUkwxZ3RuOEdBMUxlYkw0bUZj?=
 =?utf-8?B?bDUwcjAzUzY3R3Q3d2U5aXhMTDRTL3p0OFBDUGNEMENmMnQyZ3FIb1ZRZGdP?=
 =?utf-8?B?L3NSYjFHSFJ6NmlRZGRHcWh1VGFYaFdSODZKNVlrVUtXYlpiNVlPRFhFRTF5?=
 =?utf-8?B?dTFqQXlXNWo4TG0vN0t4c0wwL21hQjRuYVRQWjlMcGhWeVdvM0FYc2Z0U2RF?=
 =?utf-8?B?Y2tEdzF4d0NJcXFVbWFsQW5nY0ZjZVBDenZaeExSY00yUjdwcmRxOGhLZ2M4?=
 =?utf-8?B?cUE0UStmRG43R01CSCtqUFdFL1pQMkc1NXdCZ0E4SGJLS25iQ0Fid1lWZHRM?=
 =?utf-8?B?ZnFGTW1nVFh1d3g2cjF5TmRTYVpsK1dONnhCSkorTDhTSUx3K3pXdVdwN1FQ?=
 =?utf-8?B?V05ZQzJaa0hqYTlZM2c1dExQd3dUejhNTHNjTU1VRTFqRGpXS243Q1o3QUsy?=
 =?utf-8?B?dE1IMWdGdXIxTWo2dlV2NDhJWURiZlgzT0l6V3hFbjdObFpLbUNrYXZ2QWJX?=
 =?utf-8?B?cG1tOXVXazNtbEROejdJTHhrN1FxOGUxVzQvZkhMUyt3SFlZNFBrc1RiZ01Y?=
 =?utf-8?B?NXdGU1h5SGc3Zm9XVlBrV21aZW1rbXVpYVJnQzFOTmdTNzRFUUxGdWIwS2Ny?=
 =?utf-8?B?d3lHNm9ocXJGTE5EQkZ5K2Q4T3FEMHVBUGc5dS9lK29DQzJwd0U5dDdXZEo0?=
 =?utf-8?Q?7p5K5JQZspI/2KIg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f59df30-d501-43bc-2762-08ded8fa2319
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:56:37.8293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dktjLG8UZec0w9Rbef6vDAfa+Dtcs2eT8KpMqZLPy2mIZLARAo26or34TD9DYPKB7ziA/JI47MYwqGRcGplhiyO5A+rSJT+8Vb+nkF9yOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9448
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

This patch series add pin controller and gpio driver support for EN7523/
AN7581/AN7583 SoCs. The driver based on official linux airoha pinctrl and
gpio driver with Matheus Sampaio Queiroga changes.

The original Matheus Sampaio Queiroga driver can be taken from the repo:
  https://sirherobrine23.com.br/airoha_en7523/kernel/src/branch/airoha_en7523_pinctrl

Additionally in the EN7523 case the patches removes existing gpio dts nodes
and replaces them with pinctrl node. It should not be very dangerous, because:
 * No official EN7523 gpio support present in U-Boot
 * Legacy Linux EN7523 GPIO driver is mostly abandoned
 * The same driver is planned for upstream linux/openwrt

This patchset includes bitfield.h patches created for Linux kernel
by Geert Uytterhoeven. It suits U-Boot fine. I preserve original author
and original commit messages. Please note me, if there is a better way.

The patches were tested on EN7523/AN7581/AN7583 boards.

Changes v2:
 * pinctrl driver was split on common and per SoC parts
 * EN7523 SoC support was added
 * EN7523/AN7581 defconfigs were updated to activate
   pinctrl/gpio support
 * Board/SoC independent pinconf/pinctrl definitions
   were moved to global includes

Changes v3:
 * add non-constant field_{prep,get}() helpers
 * put airoha common code to a separate patch
 * put en7523 dts change to a separate patch
 * add support of "pinmux status" command
 * address a lot of comments from David Lechner

Changes v4:
 * minor refactoring
 * fix gpio initialization, so gpio driver becomes probed

Changes v5:
 * more bitfield changes
 * sort contents of pinctrl makefile
 * address more issues found by David Lechner

Changes v6:
 * pinctrl makefile sorting/formatting was moved to separate commit
 * replace 'tristate' by 'bool' in airoha Kconfig (thanks to Peng Fan)
 * a bit improve menu entry names
 * add an explanation why en7581 prefix used for an7581 chips.
 * add reviewed by David Lechner line to all patches

Changes v7:
 * an7583: add missed gpio22 pin group

Changes v8:
 * replace en7581 prefix by an7581 in the an7581 pinctrl driver
 * sync en7523 driver with latest Matheus Sampaio Queiroga work

Changes v9:
 * Remove an7581/an7583 prefixes from an7581/an7583 drivers. No point to keep
   it in the chip specific code.
 * Minor refactoring of an7583 drivers to make it more similar to an7581 one.
 * Fixed few bugs in an7581/an7583 drivers.
 * Sync code with latest Matheus Sampaio Queiroga work.
 * Remove en7523 driver by request of Matheus Sampaio Queiroga, because of
   linux en7523 driver is not ready (and currently broken)

Changes v10:
 * Add back en7523 pinctrl driver. The driver was tested/debugged together
   with Matheus Sampaio Queiroga. Pin numbers were changed according to
   the table provided by Benjamin Larsson.
 * Added myself to the list of en7523 pinctrl driver authors.
 * gpio-range property was added to pinctrl dts node.

Changes v11:
 * fix mdio pinctrl function for en7523

Changes v12:
 * code was synced with corresponding linux patchset
   https://lore.kernel.org/lkml/20260616041939.2587012-1-mikhail.kshevetskiy@iopsys.eu/

Changes v13:
 * code was synced with corresponding linux patchset v4
   https://lore.kernel.org/lkml/20260617043654.2790253-1-mikhail.kshevetskiy@iopsys.eu/

Changes v14:
 * code was synced with corresponding linux patchset v6
   https://lore.kernel.org/lkml/20260628143733.273651-1-mikhail.kshevetskiy@iopsys.eu/
 * Convert drivers to common field_{get,prep}() helpers. This should fix
   build failures of many renesas boards.

Changes v15:
 * Add patches to undef field_{get,prep}() before its definitions. This will
   prevent U-Boot building breakage just after bitfield modifications.
 * Improve a bit commit messages for patches cherry-picked from Linux
 * Add Reviewed-by Simon Glass where necessary.

Geert Uytterhoeven (2):
  bitfield: Add less-checking __FIELD_{GET,PREP}()
  bitfield: Add non-constant field_{prep,get}() helpers

Mikhail Kshevetskiy (22):
  watchdog: renesas_wwdt: #undef field_{get,prep}() before definition
  power: domain: renesas-r8a78000: #undef field_{get,prep}() before
    definition
  net: hifemac: #undef field_{get,prep}() before definition
  mtd: nand: raw: sunxi: #undef field_{get,prep}() before definition
  clk: renesas: #undef field_{get,prep}() before definition
  board: renesas: gen5-cm33: #undef field_{get,prep}() before definition
  bitops: import BITS_PER_TYPE() macro from linux
  watchdog: renesas_wwdt: Convert to common field_{get,prep}() helpers
  power: domain: renesas-r8a78000: Convert to common field_{get,prep}()
    helpers
  net: hifemac: Convert to common field_{get,prep}() helpers
  mtd: nand: raw: sunxi: Convert to common field_{get,prep}() helpers
  clk: renesas: rcar-cpg-lib: Convert to common field_{get,prep}()
    helpers
  board: renesas: gen5-cm33: Convert to common field_{get,prep}()
    helpers
  pinctrl: add more pinconf/pinctrl definitions
  pinctrl: sort and format the contents of the makefile
  pinctrl: airoha: add shared pinctrl code
  pinctrl: airoha: add pin controller and gpio driver for AN7581 SoC
  pinctrl: airoha: add pin controller and gpio driver for AN7583 SoC
  pinctrl: airoha: add pin controller and gpio driver for EN7523 SoC
  configs: airoha: an7581: enable pinctrl/gpio support
  configs: airoha: en7523: enable pinctrl/gpio support
  arm: dts: en7523: add pinctrl/gpio support, drop legacy gpio support

 arch/arm/dts/en7523-u-boot.dtsi               |   23 +
 board/renesas/common/gen5-cm33.c              |    3 -
 configs/an7581_evb_defconfig                  |    2 +-
 configs/en7523_evb_defconfig                  |    2 +-
 drivers/clk/renesas/rcar-cpg-lib.c            |    4 -
 drivers/mtd/nand/raw/sunxi_nand.h             |    5 +-
 drivers/net/hifemac.c                         |    3 -
 drivers/pinctrl/Kconfig                       |    1 +
 drivers/pinctrl/Makefile                      |   61 +-
 drivers/pinctrl/airoha/Kconfig                |   26 +
 drivers/pinctrl/airoha/Makefile               |    7 +
 drivers/pinctrl/airoha/airoha-common.h        |  144 ++
 drivers/pinctrl/airoha/pinctrl-airoha.c       |  958 +++++++++++
 drivers/pinctrl/airoha/pinctrl-an7581.c       | 1484 ++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7583.c       | 1492 +++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-en7523.c       | 1118 ++++++++++++
 .../domain/renesas-r8a78000-power-domain.c    |    4 +-
 drivers/watchdog/renesas_wwdt.c               |    2 -
 include/dm/pinctrl.h                          |   28 +
 include/linux/bitfield.h                      |   95 +-
 include/linux/bitops.h                        |    1 +
 include/linux/pinctrl/pinctrl.h               |   74 +
 22 files changed, 5479 insertions(+), 58 deletions(-)
 create mode 100644 drivers/pinctrl/airoha/Kconfig
 create mode 100644 drivers/pinctrl/airoha/Makefile
 create mode 100644 drivers/pinctrl/airoha/airoha-common.h
 create mode 100644 drivers/pinctrl/airoha/pinctrl-airoha.c
 create mode 100644 drivers/pinctrl/airoha/pinctrl-an7581.c
 create mode 100644 drivers/pinctrl/airoha/pinctrl-an7583.c
 create mode 100644 drivers/pinctrl/airoha/pinctrl-en7523.c
 create mode 100644 include/linux/pinctrl/pinctrl.h

-- 
2.53.0

