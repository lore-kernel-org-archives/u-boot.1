Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0164C43602
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 05:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00FE284C71;
	Thu,  2 Jul 2026 07:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="MoUGfn1X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0424D84C6D; Thu,  2 Jul 2026 07:58:03 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6717484C5F
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 07:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vj/PTVstSVEEYKasj2U34VvqsjKsqgIdHP73pzdISmfTw5qcnZznfuAan1ajnMcEbS9I1Oo2ueuyC53FaaZmbz0ev+oohlRkIwzqPr4PnUuh3a0Mn4FRa9UXNTC0GQL3phlsofFY103Q5MJOYQ0H6KKFiJFsBpQl2U1Odev0pLoBVgadXH8AjVNixGPpH/Bf2Gi2cR/SCBYbgnARD3phCh+LJfmfmQtdyXOxEwkOYCTnbDKWmUBsH37srrX3Nm55lbrV5fepubywSpvRcYdmrUaEnGrWAiy9eS/FL4LHmekSaozsArIJDkTP57hfRqJTcT289hC+4/Pn9rvjAeo6mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KggnL5K3l4HIjcSlohuRlhHqn8tljQVVpQ0u4kMdX/o=;
 b=LYMlWMRp0Y9XGESvxNc0MvwsZ8SsbME6wu6p13Xe3Iqgm7GRjpFF2SFRQvRfzk02+6Ovg/VtSufOHEOQwCikVBUD57uws52Lffx3pTnVmM/heSFw6FiHkYd7a1WaPiGpyKm0OzqCmY4SHcKIwhirQ6vFdbiheaGiKMr2/SKY967ahrbBdDj0zA5TRZbxUnUFzUPu7cygHY7IDGJtS2WP4Zxy1VJ2BLSCXAJQxPcubuEOCSGWW6IhOrgHEUT03WALbv75k9DisA58YlZ2MzXZdE4U27IT7CvaBK0lb5J7+ykbzZ3Pte8uhqO5dDU1zs+GSNAjZSa4V6y3W02FD31SBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KggnL5K3l4HIjcSlohuRlhHqn8tljQVVpQ0u4kMdX/o=;
 b=MoUGfn1XDPJ4cyu4AHMzl10E19zyUnk/xvaO3dYPm0JNCYERWFvUNBPA1Wfuh4JnG1AkbDbDTKFDe4YP9Zr28ramaPjEfLSvfulu9uqXyEnNdVDNPYj//l/XADQXF7DFasV7T3NYYiZqGmIkcvUFLECT0hQ7rSeKjvwvEE5RW2OA4SHqD/xzi2kyDTDNjFfsiMjLatpmnIKggR5OTtGlNAdQW3JQxJx9W3JMIGOOB9L+MV3zdnhUSRl5YLJwhtBc/daTxPHG7vM2qTJwbTM/zfp4MS7gyV1tNjpZq5469iQdU1GaHGaCftKaIvjrk5/EiWpIeCmROUNMv7Fv0A+eJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBBPR08MB10435.eurprd08.prod.outlook.com (2603:10a6:10:52a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 05:57:54 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 05:57:54 +0000
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
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v14 00/18] pinctrl: add support of Airoha SoCs
Date: Thu,  2 Jul 2026 08:57:26 +0300
Message-ID: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBBPR08MB10435:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0d5315-1193-411b-6aed-08ded7fedb8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|52116014|23010399003|6133799003|11063799006|56012099006|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info: vypxg152e72g1mAWj1RiM5yDaquQfF8GIVpotE7S7HECcrJGz2TzTOmL/w9CAUpdXjwVyP4e74DltMJPTpiwLMeKk0LjALJRvhxMjbAcLHyZYjDbYTkNtCt4K+NyuH3xrgRPaPCCn728czZZcL0/9bxuFVmCMAwbhrMtGeP0mUj1eqQOFZxMMqeSDZGRp93Vj492gLM9tRa4d3UVH7sxCI0tE99DBx5hCQ9cF4HYhs9L2kIpBUoxz88wqItrLCUFOlyq1vKUfpIqw2RIjlxNCKaYTjKFC0OXaiSTqeZw1JRuraZBSWAkJOsifi8EpMJC+16ojnEgl9VsUZVeWhR06GzeQdHIN0twswDj8C/9B9Hg5sn/jRQ8tmo9nxhsd6AQsaejcaq0PM3mawvbaWoxLsA6N9PVPNWpjsDT3nWpY4ispHNCibnzAxKxQJ6F9WVEu9Exb2vHyllRbGfmgYokDYwcgqq44Rl5JkJCMwNXVB1Tjp2+bJQ6UyPKQSqHSmDIQ6VSTneJiArQ0xBoGXP15WqN9ELUbrlmDtsniIf1r4Fxdfash90tumjjK654CmdJKFFem6SS8kkyoCvQ0oyDuHmw8m88PaQq/BY/2ejKZVk+ZLA1zCVr4b9CvRXQLtTKJgWcOj8AKJ+QTw1L3MoYk6MJ1YHL9PMk3RReSMOLPQyjrycPDVobj40KuCWSXzp+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(23010399003)(6133799003)(11063799006)(56012099006)(18002099003)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3NucEo2Wkg2bFptZ2NPVm9QdnQ2b3ZPU1ZGbHRVWHFZekFEYm1TUW5KVzJ1?=
 =?utf-8?B?cEdQSkw4RGZMQnFXR2NyMVZyYzBGYjhNQzdBOXUxWE9lVGxKRmc4THpZVnZT?=
 =?utf-8?B?RUlaQVhCNi8xb0YzSXozUCtQTG9xVEVlZzFmK1dOTlVGSXNJVGxxazJ2dEFB?=
 =?utf-8?B?QnRVcEhPZ29oZVNlQWZ3RGdDV3hxckR1ZmI2TDFJNkxDcWdUaXhKR1lMRG1F?=
 =?utf-8?B?VGVaWStpREs1eW04bUVSa011Qk9samlTYUlKVmVVNFJBVzJkLzA0NDFBY0Ri?=
 =?utf-8?B?ajZneHNhVER6cDB3WkZSb2hKNEJqeFV2QkJZT3cwY1FITmlFdXJpZUVIclR3?=
 =?utf-8?B?U21abklScDdxU3VGVXY0dDFmWmUxa0lXK00yWWFLQVNtSkpIZ3BHYmhlbU4r?=
 =?utf-8?B?M0F4bGJaMnZCOVZUZ2JYKzFUQnFXRlBDZFdaNCtNemJiTFVTZFlDTzBzNld5?=
 =?utf-8?B?UTROdlh4bTJRYkRCSERyS21UTFp4VHNnbG5KRVNDOXJUbFJXelNXcGVkM3BR?=
 =?utf-8?B?Z0o4alo1SXZkeUJkbW00VU5JSVBaTlA3ZEtQZDBnemIyM0tYOVppM3pZQUUx?=
 =?utf-8?B?b25FTkc3aUx4d0ZDTkx5VFFPTjMyOVNWT0lpS2ZVTnhNaUI4ZFRKZ2FVMGVj?=
 =?utf-8?B?bExQdU5Ma3hKdllIMmk5SzBBQ2Z3K0Rsa3ZLcW1nL2VIaEI4eGd6ZjY1UVN3?=
 =?utf-8?B?Q3dNem9veEF4WWFvR1A4VEpFWWtlUmQwa3ltNmhrUVJ5YW5zYmRaVkhvaHIr?=
 =?utf-8?B?QVZxSEIxbE1vdk95V25KQ0tVNUk2KzE1SjQwKzI3eHQ0ODZyNmI4VUNlYUp3?=
 =?utf-8?B?S2xjR3czcGR4Z0VRcS9pbFpkYi9Wa2lOa3hNQ0xMUU1ON3gvMDNXb2RrZFQw?=
 =?utf-8?B?emx5VDNwQWZTSFFtM0cyNU04MHUyUUtBa21GWk9mYi9ZRDkyRHBDY2dyemEy?=
 =?utf-8?B?UVZtdjZEaEFkbkt1MVFWYzVOOVJPYmdRK0VXRzVrMWhjQ09waVBEeW9Xd3BC?=
 =?utf-8?B?Uml6WUVEUmYxVmZpdk1GMHg4dTRpb1NXWEVXZkszOGV2UFRYc3RucU1xR0dI?=
 =?utf-8?B?d2tFalRlai9Ccis4Ky91ZmNUR0VrdEZpZnlWVzZEUlJUeVZLaUdqWjBzREY3?=
 =?utf-8?B?NDhaSTAyOXl4cmpmV1UreEMvb1pwdVhhSlpBd3JzR0UrM0UzRytmc3pEV2hI?=
 =?utf-8?B?MWFiVThkbDl1L1pjOUhrME56S2VQTHZ4VjI4Yk9wZGpyaWI1cjAzR1Nhb3Jj?=
 =?utf-8?B?ZitmUUdKYVNxZ2NxaFdwb1RzN3RmOGFLUmdrK2VjRlFwRHk3MEtka3g2ZGVx?=
 =?utf-8?B?cUI5M1R2VGl1aFpzTWVoN0wxSXpjQkFYSWVFUnViMTNodmFaVUhTL2dHOUxz?=
 =?utf-8?B?L2lXYUZHNy8wSTFpWGJJSjFaVVdUR2M1eU5hN3ErYW4yUU1aWjJROFl3LzRO?=
 =?utf-8?B?NmJ5cVhHazlZNG9IdzBXUm9RcGxrQ2hhV0tHQVdmVk9ub3pFY2VDSFgwTERt?=
 =?utf-8?B?VUhkSkpDdHdpQkRhYk1hS1pSdGZJMWM4UUk0OHV5ajk3TG5ZUTZkbXZYbWdv?=
 =?utf-8?B?MXdTWEZwb0J1d2RJcEd5NEpKTjNOSU9WSy9NdzgvZnh1OVcrSHU4OStLUHlH?=
 =?utf-8?B?VlpVS3drR1owV0VBV3FsNmpDQTR1RjY4RVlJcGlIdGJweUhHUXdXempLZTdS?=
 =?utf-8?B?cWw1eWMxeHJBSXpta2MxSG40UWdhRWhPVEhEU2J1bGs1Vml3K1h2QTFQbUE4?=
 =?utf-8?B?SG03MjJXOVNRVlJBaEFoTGhqMzVYYWk4QmJGTmtRRnVydC9NdThEVzhnWFJR?=
 =?utf-8?B?UWJ4K0tOMk9qY2IvNG9QQm95SlZWd1JzY2d6V1AzSnMyYTJJTlMvZGc4QkdX?=
 =?utf-8?B?elRUVldqdUU5YXVHUkdNdk5saGpPMDk5bFYvM2tIQXJnSWduUGljQkdFZ1h6?=
 =?utf-8?B?d2lDcTZqN0VkRGVpOUFFMitCRXM1MHRhLzRoYVlvOEhSOTJXdmFBZWxHdVlw?=
 =?utf-8?B?M2R1ekEwK0VCbG8vRk8xOUIvL0U5eFEzdXBRWnhMeU9WOXc5cTJqRmxEUW5j?=
 =?utf-8?B?KzUxbldyVGdqRzBMWi9xVENoYTBWQVZBVzF4RERqTVhBVWU2WHEzeEhrRCtZ?=
 =?utf-8?B?KzJ4cktTZW5wTXRDMWxtd2FpVHNPL3hjcm9VZ24ydVZMM1VvdTlkOWQ2MDU0?=
 =?utf-8?B?Zm93UWhuZUIyakxWMCtpRVhZeGpDakYwZy9oTCtnMGhtemFOMmhoTklTcUlp?=
 =?utf-8?B?cXUwQW5NR2xqTFRicmd6dkJ4bE8reVBIR3ozN0laaWEzV0h0Qi9kbUQ4UEs0?=
 =?utf-8?B?RUxNU2QrREhGeCs2R0ViNFNuU0pTTVd0WENsSW5lK2FFSmp0UVFVYnM3cjNt?=
 =?utf-8?Q?34Y7yriueKZjJ2TA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0d5315-1193-411b-6aed-08ded7fedb8f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 05:57:54.4202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1KbrPrUoe1Pp1p5YD+SY3olZcin86EWm95ZhGjgitYIDPLnpSceaB5zzc/dQTP83w9Rarp4dMzL7g9j0OV1wt6T1lTuxAHSTkipg6K+4ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10435
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

Changes v14:
 * code was synced with corresponding linux patchset v6
   https://lore.kernel.org/lkml/20260628143733.273651-1-mikhail.kshevetskiy@iopsys.eu/
 * Convert drivers to common field_{get,prep}() helpers. This should fix
   build failures of many renesas boards.

Geert Uytterhoeven (2):
  bitfield: Add less-checking __FIELD_{GET,PREP}()
  bitfield: Add non-constant field_{prep,get}() helpers

Mikhail Kshevetskiy (16):
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

