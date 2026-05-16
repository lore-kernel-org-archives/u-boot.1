Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88064CD343F
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 01:00:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77FED84877;
	Sat, 16 May 2026 03:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="l3E/SRpQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE0EF8488A; Sat, 16 May 2026 03:00:51 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CA4E84713
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 03:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTWpgSH0xFcZcoIa+4VDNdsEURX1JKpWqWjTEuGQAXyV/fmCZfEu4MCQL3AIj84zbOaMT0hV21VsiHavJZZUICsMF1mwF4Fe6Bp1iSfLq3UyuRgYGSHsb2ji74AYPHi0l4ALggm5ziwKmFs7xzyc6bYayG4x5bpGwhRH8ZgNT7i8EnWq8aMZHaQGBlSKMa3DgbC1Ae4L0qigVWCDKkUT3HnNMRlxssYD4KUtJvknGcB+5GpugozWQbvUCgfBHWHSVEnabNAbF3u1bkOezkpWgZauPKiw90ZP+XG1HYWyiGbqUPC94M7cezWgaETLWuY/y5lwxSXqHeK3dCNFolmeJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PFDGK4SPFrRF8+EXdt4Y87gmL0VkZZaHoFLAsG2DpM=;
 b=BCmA0UxoOM7Dk+3bl1LNs571oLl/MvdEbXEegYdkb5SlgXpOaqx8mpZ4NU9UYRuXjaikNKAnW6wa4PwAeTsU59EG2y6FpLqGB+oeQg+xZVRpmMv2Rfb4vJjm8AE1eaaBvtiK1jedIAy5iQjLv53WmkkILEZux+gqNQLueng10tfdeoK8v6gqDL14IExTdqp3PtxU536kiRpeZbakGLh7BH2EKL4xuKOoCCmWgeAohf7az2d6l4gyOP5PesabpQJfF3ukmick1QiA/aHya6DHjkVgarQHhX+RUD5Ub6/JiwadRBxFwnRwlt2s04Mrrk55NEVBPGmvsuAib7jx0aBQpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PFDGK4SPFrRF8+EXdt4Y87gmL0VkZZaHoFLAsG2DpM=;
 b=l3E/SRpQzk6e1u4bnE6ExySokhZqw4JmwCO/pIJyiVlvshk3uHF3PMfHYxk4+THuPwHfQYI7dDbjRM84AYYEQQPLa5im2q5xaj67W0wRpcZVyz7uqUM29EU/Hh6udzqQ2AXp4Ty01znmvlocanlWDMQ1x44RkVmQRLq8p7ypdEn2E6VymLGORG82+fkJ7Y/eMf2MC2pqHZvcWhgB59qXVbmprGZghXrbLBABCbXBsWm0JmMeVjFvTlK3ryQZDjDyePFsbDVroC508lLQ40mr093rKRdlRddvH5Tx7aJ/KZJKbkwHkU908hFko35QTVctoYcW2tl4/KH+73khZv1Lbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS8PR08MB7917.eurprd08.prod.outlook.com (2603:10a6:20b:538::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Sat, 16 May
 2026 01:00:45 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0025.016; Sat, 16 May 2026
 01:00:45 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v7 00/12] pinctrl: add support of Airoha SoCs
Date: Sat, 16 May 2026 04:00:23 +0300
Message-ID: <20260516010036.1034352-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3PEPF0001DBD3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6a5) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS8PR08MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b8cafa4-2caf-4905-d95e-08deb2e68f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|56012099003|921020|11063799003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: AL45H3kVh6U7milxupo7DdodLo9rnv6WwCYv9Umj98M0qsR6/ksBdYKSTHG+t0THujnx5yIBr8oi0PNhFsxgx91Y1BiLklyRvgMdOBI1nUsR7YIgTkvCpVMjhwIZ0S2vYz9BF6gYnktgSV41GBEMNTobbwe1nDMDuqnznb7FmXEoAE+OPMz2GcydDyraolAKPkKsHDkYma6CXWuVWjgRHGxij4qvBCpEtVcCJoQfIg8CuLt4mvc+eSs9A/XjsieEYDg9WLj5XvKqW2PG4ZUZx+K3FK6j7vulbz1E2ShiqKZ0MnNDBirXBFMldqnW0gdoTfiT+bTyDbIjeHLyqXHHCRrSx+NgHPfca0oG9j5iOUBHxSids9MXUUz3aAqtEoRI4BmhdHtOpDUgfsAjAENLif6Y7nq5Fh0phg7HPH2JyqEekKqZvP20382nASDv1a9Je1tT0jJvzbUFRV54l6OWM9quli/5KAf0PUAT9PeDugZBMdeL5stiFdsjht0xZ5bZpFoY65qcSWII5AkNnAyDRPiahDlm/iepgfioU+g8zsUwX7mVd2HomjUG/rmjlHVpEBqQkgn2gTYj9SWIybUJIp51xtR5Qr+rDfzIGul2dbEY3D3kFAycU0gzO7n30ZpjF3vVCijhuYz0Mnk/Rrl9VGLiUqHqfENTRFchFA+3TUgiSo58re1LWyzV1FmBGQLTXuC/OAPQxs7xER8yMHNkOw280QS2qWyGHB6H5QtYCRDUpGodQOaSPb97GouifeTg+eiwPnJBMyx+Y+jGp2hLUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(56012099003)(921020)(11063799003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTd0TDMwRWR2ZFg3djB1WE90SFpZSUMwUlhzS2k0Sy9vMnN5V2RuL01nRVhP?=
 =?utf-8?B?NWVWdlFuN2lZanMwYmFMR1NERU8zTkRVZ0FRN2N3eEdhOEgzT0FpZzg1dDZy?=
 =?utf-8?B?V1NZYUdOLzZEWndMbkNOVjRXYlpPQVlGZnFXSlRQem5tbWxIL3hmNW5hK0Ir?=
 =?utf-8?B?UGIzd1FvQzVlYVl3MnZYdXhhbFdySUg1MXIwR3BRcEc5QlVlaTdHVlNrZnNF?=
 =?utf-8?B?b2tPeGY0ZHVuM1F6dWczNnJTQkZlNW1HR1MwMjlVZ0hNaTBDOUJvVU1IdVJo?=
 =?utf-8?B?TW9xeE11Y2gyN3I2Y1JqZkZJcHNTWWIxRkxqZnY0a3dGTVRYekJwSmJ0N1Bk?=
 =?utf-8?B?MGFyWThzQ0k3RUw3dnM0YVFMSE51UUkralY1cTh0Q0JsL01JNTBySzh4NTVF?=
 =?utf-8?B?bnVhVjR5azRJSWxydkhqN2N2b0VFMWpza2kvTjdvSkRSR3puSzI3bzJ6eFIy?=
 =?utf-8?B?TGxkWU12cDZTYUNLK0EyUmtIS0wzTGROcGRMdHBGcDU5U0twSnR3bUV5VkQy?=
 =?utf-8?B?bG8rOGc4ZU1ZWTd2YzhWS1pIRDdqQ2FvMHhRWTk4YlkzRnB1c1Z4dmtkeTl6?=
 =?utf-8?B?NFo4MVFWSU10bGhYSzJKa1Q1RmUzbGFxU01pWFpaZEE3SEdYS2QrL0ZIakRK?=
 =?utf-8?B?NTFOSTg1cEtIdkNZN0NiQ0JSa1NiRGsrQzZqOFNnbHVqSys3TmZWZ3FVSjZ0?=
 =?utf-8?B?WThJM25oVnJ4ZlN1dmFvNTVDaWFkRTRzUks1MndROWhVbGZSN3NJU3BHWjYr?=
 =?utf-8?B?dUFXWllBMUNCWnZOUGF2Vlkwci9oYWo1VEE3MDlXY3VOT1lTQ01QQ3VXRDNh?=
 =?utf-8?B?Zi9GUHYxcXp3OWhKcXBFQ0d4VTdGRmN4NjE3RE1pa04xSzV1cjNHNkRrcDJ4?=
 =?utf-8?B?WDdvZ1pVMzUrbG9Mek5JNENTMkpqMXBaSmVPWUpKamdETVhwc01PeTlwYWV5?=
 =?utf-8?B?Nk1qTGZNRGprcnNDTFJRRFFBZlZPM1l2dXpCWmJYd3BxSUh5V0lGWlZSVURu?=
 =?utf-8?B?bUpKZGQzVlVtZDhxd0JNajA4ZE1jMVFLRzZCQ2dYd056WVArYkxlVGhVSnIx?=
 =?utf-8?B?SlFNYmE5K0NZcGEvbjFWWEdhRENLNnloSEV3RjA5RjVRT3ZWb0k3Y3dpaEVh?=
 =?utf-8?B?VGFwNkR3MUpxZmVQSzQ0UkdQb2NrVStPS0JFRGNDOHRtYWppaUIzbkVtK2JI?=
 =?utf-8?B?WUkvcGE2dVJOcEpNemoyUVhxN05aWjV5RGdrT0Q1ZnBFeFJFbzNCZ0hiYlpx?=
 =?utf-8?B?RmUvK3RoWXN6d0VWVmxkbUFoQzg3RzFwTmNFdWJnSHNHQXc4cVpDWVdQbVdx?=
 =?utf-8?B?VDkvaUZFaE0zaStIalJVbzBieU5pQ2VGUnhsZDhDWkFRc0JTSGNRVzBFckhx?=
 =?utf-8?B?WnhIZHVESjRZVFl6cGg2a0xhSEhwZ3pGeDN3V3dhQW0xZmxlTHhYOXVFQ3Fk?=
 =?utf-8?B?c21vWFVqYndma2xmVHJVaC9GMTRBUG54MytnNXJTREJkVVE1dk9BTURjaVFF?=
 =?utf-8?B?bTBLclFSdTJIVEZhV0k1UndvYTBlRGl0QlJHZTJBbjA4STRNcDAzckxDZk9I?=
 =?utf-8?B?OHBmbUllMjVaNTU0aFZNbENiQ0Z1MTc0QnFwN2crSEFsQ3ZqcTVjY2hYUjFv?=
 =?utf-8?B?UWdFdm9seXoyYm5lcGVSMlFuVzlBMzY4dzlRU0VyUEhLQUtSN0JlcEZjQVdn?=
 =?utf-8?B?VUQ1bGVqOUJJcEUvL0Fra1pRWUtxdGxLQ256K0p6dGxWT2hMMU00QUdkUW0r?=
 =?utf-8?B?bzc1RUdTdU5XdHZ2NHY4aGM4Qy9JUU90aFd3b2h6cDlySk5PTTFwRDk1Tjcw?=
 =?utf-8?B?b1h6WXNQallRWFpwWm9lUlVxbmI2V01FNHowVCt1Smg1NStQMjZyaDdEeFRk?=
 =?utf-8?B?QlBEaytNTkFFOFBtbWJWWVl6aTB6OG0xRnRaTjdzL04zc2szK1VYR3FjZ0dJ?=
 =?utf-8?B?aFBCdjZ0ZHY5eWI4L3FBL2pzeG91WGNiaUh6ZVdRQkZGNjRBY0FnSnFWMDVR?=
 =?utf-8?B?QXpkelhxYUxYb0I1MGFxaTFxbzBkNmpOSzRFWUJZOGpKSVBvWTNmMVA0aTM4?=
 =?utf-8?B?d3p4b2RkYVhybDRNSnNpQXdDVXZHVWJEY1NXd0czbzgvRGlPYm9IdFJvZXd1?=
 =?utf-8?B?OTJwcWp6azhvdHV3VGtkRWxaTGk3Z1FSTGVMUy8xSGhRL0lHbHJpc09EcW9C?=
 =?utf-8?B?U2l4RlZKY29jaDE4eE9EZEdITDBzQ1JoSlNoRUFDa3pMOW05QmtjcEdKM0d3?=
 =?utf-8?B?N2hYaUNpeU1ZMHBSYlBLVmxIbjE4dlFzalFURW1iSnovN3pCc2hjMUIvak9J?=
 =?utf-8?B?RTQ3TzJZMnJLamFhWUJrK0UwbytyelpjelgrMm42aGdhb0gxclN3Vm5BbndR?=
 =?utf-8?Q?rpmcueiPxOtJfvP8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8cafa4-2caf-4905-d95e-08deb2e68f70
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 01:00:45.5080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiURa1Mz7XM0tx0Oe5HPguZoPbewsCYI3KxwHXWHfHcvBQoIxmqqgJpQaVp+e985BZu0eqdMzfwL7JUl71m8UN9G/1tvmAp+O3Blfao3bfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7917
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
  https://sirherobrine23.com.br/airoha_an7523/kernel/commits/branch/airoha_an7523_pinctrl

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
---
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

 arch/arm/dts/en7523-u-boot.dtsi         |   21 +
 configs/an7581_evb_defconfig            |    2 +-
 configs/en7523_evb_defconfig            |    2 +-
 drivers/pinctrl/Kconfig                 |    1 +
 drivers/pinctrl/Makefile                |   61 +-
 drivers/pinctrl/airoha/Kconfig          |   26 +
 drivers/pinctrl/airoha/Makefile         |    7 +
 drivers/pinctrl/airoha/airoha-common.h  |  476 ++++++++++
 drivers/pinctrl/airoha/pinctrl-airoha.c |  927 +++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7581.c | 1084 +++++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-an7583.c |  980 ++++++++++++++++++++
 drivers/pinctrl/airoha/pinctrl-en7523.c |  648 ++++++++++++++
 include/dm/pinctrl.h                    |   28 +
 include/linux/bitfield.h                |   95 +-
 include/linux/bitops.h                  |    1 +
 include/linux/pinctrl/pinctrl.h         |   74 ++
 16 files changed, 4394 insertions(+), 39 deletions(-)
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

