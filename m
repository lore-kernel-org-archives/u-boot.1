Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A48ACD98E1
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 05:30:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B841F848D1;
	Wed, 17 Jun 2026 07:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="pMbiGAnj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C390484894; Wed, 17 Jun 2026 07:30:02 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E597846B0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 07:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0fNK+AYwuyOndHOBldCWlk9USIrcb7BG9MyVNlwL7cgblxq78ai6ebylKAlwiw+utUxbfuvEZbv4/YERNVMwdwnUJTn7SIxpFpehOaeNdcHuyS6aSGFGDmBtrrqmatd/8FWtrKd41c5+h9g4SH5kUmL9mk9VorO4b4MuNxs8ovJdWd0JXcUm83Sj+Ezypq2oBw4abSweg9zUCQvDWM/7rJaipcxW3Zg0mjwUXID2gjSllLScFcG3M8GyXFCU7guSC8H/BTgXRsKYjrkb0Lobe+8iktLNSFkRnBVLtcFj6MTiaTQtpMmM61XDMD+RcnHDV/+QvCKwNxYMhkAp0jycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GkugIngK+6Waf1zSKd/2XZ7dbP2igJ5gYcgoBFb1uQ=;
 b=qnrV/8DeuXFVkBPW1EoJjn4SFeBJZOTKnmEKSaKW0SH9wswwAh5B77cWmB3Mg9prOz4ZNgsemyBaTtSERx4+WI2YwA5ccuHokggwAwXWqDzwJYaDJ5fZMh/S24TW1dISovXhxvb9Tnl/iVegMZC/+Uvihi8bY48BI/J8jBwRoE4hsXPI03+oXEhog6H/tKAIPCE6GIfZWfHrfdh6SqM61TCHRXanpGnnmCcCI/W02Qnz0qSSyQaDFoDcsKiGnaW2Uxq4yVWhyQkmXqImCOHCd2K9EOIYLMQpLtFJSTzeNdIKYTTxaqXFDlNUBRmNporzGcXtwD/4YxWT8C13Hdx9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GkugIngK+6Waf1zSKd/2XZ7dbP2igJ5gYcgoBFb1uQ=;
 b=pMbiGAnjCRWTddklYg923Gnw/jzsRVERuCm8roOiWAZgBpk9DalmC5qzBHIkv17Iv6LJr5s/3Sk2oJ6tL30es36Fal+5PqoAQpy2RscH8UofEYoZiuAzudhni/NCyQ5iNFwDGntE+TCjmOOYLDf4S+mMktXjX+47vvRPGdZUw2NiHHMsJiJZC9VjMOIGqkM6dKmyxdXxCa+3EEyYa/uvAmTKYo7Kpxm1GO+EAtbWlxgJ/LQG+ZxajvPYMHjXPUrZ7zcQ1sDxSq7xkEDKpw6vxXCZb6cBOlXviJ2n6qWAdELqg4SdCKknze5lIDzbvbjTFzYLNwSTbvHXikmn2sjyVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DU0PR08MB9653.eurprd08.prod.outlook.com (2603:10a6:10:449::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 05:29:56 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0113.013; Wed, 17 Jun 2026
 05:29:56 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v13 00/12] pinctrl: add support of Airoha SoCs
Date: Wed, 17 Jun 2026 08:29:36 +0300
Message-ID: <20260617052948.2815870-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DU0PR08MB9653:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b84789-1d7b-4d45-5690-08decc31777f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|7416014|23010399003|921020|38350700014|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: FPjYl+E9BVm/k2WM6JARTfSd3klJuznhWhA+RMqDT2t4cs9uEFCOoQqMgaUPNhBKk6/zkfoAIEj336Vj6Ha0fjenITJaNplPW4wj38NvIl8qhiT29vkAChfSNbhHjyODsbrdlK3FkLlnuGwh8N5Btvm1nqJhbPvYxW5YxoCFmgamttjEZEILqdrFShBm27e9aoys96q1zJqmgjtKSfeQkxURibjePQfHQdiRWj9/YPDpXboJajWMiLlwnkoeaRP+2r4o3km11p7TdwnrHh+5CRZ6Yps/Z0FuFhimDzEuOFanauH3aAppkSb4hwVLjTHy8w3HnzZ4w+iIiPjWG2RNVoD0ek+7EyWFEmhbtf2xFbbp5XoeJe+fu2xUBocCt9o2zujcWjMHlh4GuYLbWgJ/NGV1/7E3rL9wYzvZ+/sd3ZRdCF030zFblK7lPvRuHkEmt5BvfQfxHoVtJxTbu3l5GksDKgb+G6tS8Dnr1RDhpDdYMDiuG+DZ7CrnvvCYOZJatn/wPYQQIJBupGr3rknlvpiEVajS7g9BiaxhyD6ymf8fZHgUK3g5jQeTvXpu8e1N0WabDoB4rejYYVOybYGUEDj/81c2LVW9N9pa7fX/pryyTlPaQBO6P2BrjYUhy7EpgakArEPz/w7EuFl/aBYvZk1MQPSekkWMDq2I6b3JU50+s7RIC23L2/hMCoiDZALUJRd3XELZ5snZXCxfCxwV42hI1JLC665DUVu36+UkosIM8V0+0Ls3np+/Uu1mYmTJFLg5992lMJ4DMEkq+aLHVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(7416014)(23010399003)(921020)(38350700014)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHRlVzlzUVN6ZDVrRGEyeVcxTzNWbkpNTmtmR0NRbXJ5OHNud1lhVFhIbmJz?=
 =?utf-8?B?Z28rM1R2eXd4UGRkdnc2VlNGeG5WOUdpZ2tCbEZESWpJd2I2UE44YTNSbzI5?=
 =?utf-8?B?bHlPOFBudzZoNElNMVplaExHYUQ1SVpiNk0zaXFWUnVBVTRxUloyYkVFS0Zz?=
 =?utf-8?B?d1YxMitHbUxrVkpDUTV1ZDhXZVlNOWV2OWRFUy9ROHJJZDdXNlBBclhjQWpl?=
 =?utf-8?B?L29OL3lwQTNJTlN2dEhxRzBnTm9WYUk5R3RnOGh3a1pZY1NQeTE4VUN4QTdt?=
 =?utf-8?B?L2xJRjEwOFRXRGxWS2Z4OU40NDZIbkNzbk9wZ3RhdGdRRlE4MUZTUjlCUlhH?=
 =?utf-8?B?NEhIcXVpYWVDcHhjWlM4ais3QWJlYnhIUHZmRkE0Vk14MkQ4dEV1bkF1M3Bm?=
 =?utf-8?B?eXJvSFU2dWN1dE4xWUxRanR1VmJMMGM4eUd6K0hJSlhyT01ZNmZkM3Z1b1hU?=
 =?utf-8?B?S2d6L3FJZi92RHNROUlvOHFxSWRTb0g4UlZrOE9mdTBXbHJraWt0Wk1OTDU2?=
 =?utf-8?B?b3pDeHJ6V2k2amR6SFBUYVVsN2cvZjdBNEpCNU54Umxmem1yQlFvVnRJdTc5?=
 =?utf-8?B?VHg2c3cybHBFYUpOTUVSdkZPUjA0T3hIRlRjcGlnTjdzT0taQU1PVE5IT3h6?=
 =?utf-8?B?MlBkUDJ0ZDVqMmtXcGFiK2haRnpzS0c0cmNFNytFN09DdkVYOEdPR3hVbm9Z?=
 =?utf-8?B?cmRoVXFuU3hzYlNuWlh5VTh5RG1Ca1BVenY0SHBLZDk5cGM1L2dCYXQ2eUlG?=
 =?utf-8?B?RzFiQy9sRGR0WnloMXVQaVJxOHhoTkVKdWl1alppK0pGeFRaZVM5LzNsTjY2?=
 =?utf-8?B?T1JOTi8xVE9tWmtUbEg5eW9wbVlLM2xYanpPMkVudTU1SWtDZFRoOU1nSW9m?=
 =?utf-8?B?UVJoNDhVK3lzM1g4VVNIcW52eGlaRlVhZjZ5K0c5U2pyMkRnWWovZHExcGlK?=
 =?utf-8?B?Uks5bldzajVVWEo5bEZnK3BnT0ZKYU5TUUJkRUxvUWszRDhQREpTaU5tcUFj?=
 =?utf-8?B?TTN6T0tZVjArOEdsektsNjZrUHJMWlN5MjBEVzhqT2FTcnYwd2I5UzF5NEQ2?=
 =?utf-8?B?K2xpbWUwT2NIMVhaZDdQd1lwK2dYcHN0bG5GS05DNkxhNzJPak1DNkFPSEZv?=
 =?utf-8?B?U0ZEMmZwNU93MzdUdWJmelJLeHlpRFBhWW5tcU1WNzM3ZmdaQ3dMdm5MYnlH?=
 =?utf-8?B?ZGdhOWxLbVNVcjVER2xUaWkxZngwMnFwcG5zTGR3dXJ0OU5EQXU2c1lReUVS?=
 =?utf-8?B?VmxacUtOb1JhTVpoWlVqSUc1d0JGY2RUbkljTlpkZ1ZjbnFqU3BQaFN6aG1C?=
 =?utf-8?B?N0F3UXhjZVYya2tQU3FPNC9WRk1GcStrRExIODBJN0NqeE9KSzlEVnZyWG9N?=
 =?utf-8?B?VWIyaExibFFBRXpMZG9IK0ZpZ2JGKzh6Tm9PRjZRdnN2a2NkVHJIRk1UVnFh?=
 =?utf-8?B?WGI2R1JCWUdkYkg3UzdPTFBveTNnbWRFMTAxOHIzWlpwQkJQc1BSbm5IWE1k?=
 =?utf-8?B?TWl3VHdPaVFGTWg0Q1NtVkxrbldOdXJJbEdlZUNtSjN2dnJ3NmtSUHJoSzM5?=
 =?utf-8?B?ekNWUk4xOXovU2R1d2RXMzA0Y2tUKzI2d0s4aEs5dE4yYkc3NlpaMHJ2M0Jq?=
 =?utf-8?B?Y2pFdXZIdWh5OERKNGZ4Z2Q5cStlUmtvZTIzb1R2SWFIV0JaN1B3a0szRTZG?=
 =?utf-8?B?OUR1TGF2djAwcXBZNVVkWEtibWJhYUlNUXMxZEhrcW8zVTliOEdnbUg3SGg5?=
 =?utf-8?B?TWJRSWNzMUZNRzRLMFZWY1JSamhnQmtoVmRVL0VuYitua3h4S0tIOTdwa1Ur?=
 =?utf-8?B?RGtkY2NwVGRCYVg2aHJRSTZVVGJZaSs1eXFiTUI1R1E2RC9sWXVXRktmaDFJ?=
 =?utf-8?B?K015SmRNWVY1QlV1N280dlZLQk1YaWhBVEJkaXZJZGxqSGhNc2tHVjljQy9W?=
 =?utf-8?B?Vy9VYUtqK2tNVktwU2EvU3lFellIYnlRTmZrSjArcEFBQzJ5K01sZEphbGNv?=
 =?utf-8?B?emFoZ3p2bEZ2UllGRXZ3V1RmbHFSMXR5R2kzOTBSZTRRMHFjODVLWEF4RnNS?=
 =?utf-8?B?RWt2cFZJYURIR1pzeWk1M1BxSG1mL3pSZ1JJOGlGWDNSTy9IaVdyZXJjbnRq?=
 =?utf-8?B?d3B1cXNTZDd1eXB5ZFR4NHZWcWJHemUrTzE3a1BaNHZBdVpFamJsMWg5Zm1w?=
 =?utf-8?B?R0Jab1RBRXQ3dUZrYUJVRkk5Rk1KR1VvcGdXYkFmNzVoamFwbklyYVJabjFW?=
 =?utf-8?B?alBDYVRaZm41Y0FDaTBtcURFWGcxTkRRcDc4OGdEVXVWNUU1ZzdMY3hmeEdL?=
 =?utf-8?B?aEppeERpZitNelpkdEk4YmwyWEpTeGJ0K0ZPRWRoTlVETGJ0UFpnQ0d0Nmoz?=
 =?utf-8?Q?1Vir4miSuT0e4Kvo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b84789-1d7b-4d45-5690-08decc31777f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 05:29:56.5666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcyfN8xh/2288zR+sUMKV6chuGNvL0FCVgMboHB0M6Vcw0SD1uWG2u9htMlLUEZvxLaTV/pbyydbm0JvQfKAnjVA1HfnziUYFBkypuK5CCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9653
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
and original commit messages. It might be not a best strategy, because
these patches refers to other linux kernel commits not added to U-Boot.
Please note me, if there is a better way.

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

Geert Uytterhoeven (2):
  bitfield: Add less-checking __FIELD_{GET,PREP}()
  bitfield: Add non-constant field_{prep,get}() helpers

Mikhail Kshevetskiy (10):
  bitops: import BITS_PER_TYPE() macro from linux
  pinctrl: add more pinconf/pinctrl definitions
  pinctrl: sort and format the contents of the makefile
  pinctrl: airoha: add shared pinctrl code
  pinctrl: airoha: add pin controller and gpio driver for AN7581 SoC
  pinctrl: airoha: add pin controller and gpio driver for AN7583 SoC
  pinctrl: airoha: add pin controller and gpio driver for EN7523 SoC
  configs: airoha: an7581: enable pinctrl/gpio support
  configs: airoha: en7523: enable pinctrl/gpio support
  arm: dts: en7523: add pinctrl/gpio support, drop legacy gpio support

 arch/arm/dts/en7523-u-boot.dtsi         |   23 +
 configs/an7581_evb_defconfig            |    2 +-
 configs/en7523_evb_defconfig            |    2 +-
 drivers/pinctrl/Kconfig                 |    1 +
 drivers/pinctrl/Makefile                |   61 +-
 drivers/pinctrl/airoha/Kconfig          |   26 +
 drivers/pinctrl/airoha/Makefile         |    7 +
 drivers/pinctrl/airoha/airoha-common.h  |  175 +++
 drivers/pinctrl/airoha/pinctrl-airoha.c |  927 ++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7581.c | 1484 ++++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7583.c | 1492 +++++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-en7523.c | 1118 +++++++++++++++++
 include/dm/pinctrl.h                    |   28 +
 include/linux/bitfield.h                |   95 +-
 include/linux/bitops.h                  |    1 +
 include/linux/pinctrl/pinctrl.h         |   74 ++
 16 files changed, 5477 insertions(+), 39 deletions(-)
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

