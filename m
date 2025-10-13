Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153BACCA476
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 07:18:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84B14838D7;
	Mon, 13 Oct 2025 09:18:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sgFJp0/V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0435C8384E; Mon, 13 Oct 2025 08:59:52 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 207948381D
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 08:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paFkiUfHPw4jDKBBzK2iqn3LtXPvAWEg7jQDd3/7NHVN/yPnjTk915a2eyvfiW6wQDbqC3WZxqWyIIOMCqhZPsPYLDSHJhNBbVAgmAguLJXZNLasPHa41gdsrkIGgDdZv47uPMzOcJei8A2QAyvLLaNym3FBoK7LbWDMPHqx/nlkNVS8b0Bbx/p/F/1CI1WR3h9qDS2ENXoPczrEhZHQVVpw0GT1z935xo3Zkep8OzNC+kT6jdB2Yo/9c+IBBQReTINdDFlZUgLtiitjWwMkLGGuFB5uZ3CuJYT4P1RXB2Tuwr2DBWoMiW1wDjfHscV7RrnPuwAA3q3hQaitq4n9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hu4WAvy0gqKoaqvhC2XUDT95EST6+JWMTMBobM66jE4=;
 b=oZd7JSpbbUdl0JHNZRQmIUgO3UohCtfKlRXhFr6c17UHYATryFJ0GsKiK2Yxa29wE0SJT1ivgJn98KSJMcfQciTlcCcr/upUG/DTDSxcOAY6OYbykoL9jyFCuwPoFdmi6KwaKgpXzvBhCrJ0h+z8U+5AszeTJx7KID1v4SURcS4HDIepETTnvBEB4m5WO92oGOBOCx9eY73LPweqsT/SuDPgyURv7zlwA8CYdEiNDn484DIB+Rrat9dy8cXLPZF0AVdhLGr5yEZQn3MJYugOa+DxAh5bv2HYFWSU76wzbBgEnzIsZVVhlRvvt7C5i04D4TNZXeiHZlQjfmMenW9h2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu4WAvy0gqKoaqvhC2XUDT95EST6+JWMTMBobM66jE4=;
 b=sgFJp0/VGQI1dGvps20laqn9mxNtEC1DWXjTh30aNyUO9+uUwQfAugCEkCgwJr8ErPaeVAWnwkWEMsEUMyzB1o70oiG2cFLgSwSHLvemchL4E4ReWTVJScOsV5TMzGSoohSxCnPPzeJsbEvvAbQvJfnDbDwJPLyRypQRDm1bNCDyZYYuhn6fRe9a5GQJhAK1/oHlEe62pw2MZ3UT4MVIkrOLHTe5e7c87cr/oQ0U4K55kxEkBmomedWfLx6ilJHThGD9H+f5LnkKriSHEsL8QLZq3j6pUimRoCvQfxXY1eVzvQg34+Sd//dc+Ujg8zKQ1+ad0Oovkx1kF9BBjo4dBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU0PR04MB9276.eurprd04.prod.outlook.com (2603:10a6:10:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 06:59:47 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 06:59:47 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 13 Oct 2025 14:58:44 +0800
Subject: [PATCH v3 03/10] imx943_evk: Enable USB 2.0 controller host mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-imx943usb-v1-3-293e79d4bc12@nxp.com>
References: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
In-Reply-To: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Alice Guo <alice.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Frank Li <Frank.Li@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU0PR04MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df37265-5ac9-4382-b2b6-08de0a2618da
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|19092799006|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjR1bFl4dkk0dFFhYWlDTXlQNE41LzM4SlhtTHc4Qyt0U0x2d2RUSU9YWDVX?=
 =?utf-8?B?TC9sQUgyMGhqcWNmUFo4MjI3VmNKL1hkRENucFluZ0ZydjBaa05KeXhsaUQy?=
 =?utf-8?B?YWxjZi8rMkg4TmE2eW5FTEVLYXFST05mTS91VGZVbEZoYm4wbzdoVlhLRU9M?=
 =?utf-8?B?c3V2bkFESGNxdHNRTjR2MEs4YVNCKzU0dnFLWjN3YXRiYTJVN2dYNlVnUWJ3?=
 =?utf-8?B?VTVHbGR2V3B3LzFYaHVsYU9QaGswWEZYdmMvbTNMUTA3SXhrRVZMWkE2TEtN?=
 =?utf-8?B?bHNQdC9FRjFuaitXRlppMkVYd1RncjJBOWw2RmNqTVpBdUFLMDhERTloSFFp?=
 =?utf-8?B?aW5hZmFHeFJiMU0xTm4rUlNJZWVpdmoxMTdkZ3E0OVVuSjlHVVZUNVBFVlJo?=
 =?utf-8?B?L0V3eEZYeml1R3B3V0llcXBlTm9mV3RxYmdvaWVKQ0lCa2ZsVCt3MzU4VE13?=
 =?utf-8?B?UWRod1JhOHNaUUkrSEk5VHhnSTF5aW5XaEJ4Nzk2YzExcENUU3orVmtUZS83?=
 =?utf-8?B?UitsMjFqWDN6Mm54ZmdXaWpmYmJxUHp3d0JvbWlQbjNPNTcvY3FyUUZ5VUpu?=
 =?utf-8?B?azBpLzJWWXRKUHptQ0UxWEp6dUdUa05CaFZIcWpVeDhldkprRkI2dk9ZaVFY?=
 =?utf-8?B?UE9tQU05dVAwWFh6ZG1kMHdHTnI4ajk2Y3B5MkdlVHFEMExUUHJrd2ExLzZl?=
 =?utf-8?B?a3RqVHhIRVFaS2JCUnZJVXg5UG0yQ2R3WHVDSVNvVE9LMkhnSzdKcUNvZlJS?=
 =?utf-8?B?bGpDa1psQ3ErcFJkVFAyWkh1UnE2TTBVV0p0VXZGZEI4MlBwNisrY1VBOVpZ?=
 =?utf-8?B?MWNteGZvdnkzV3RsNW81emZBMi8xRTNlT010ZnljQzByUDVvVEt1cUdhRkY3?=
 =?utf-8?B?SS9rWm9xWnQwRHhWMnNsVXRMUHZMQmNsU3lxdUEvTWcrU1lPM1pBcE9XOHR4?=
 =?utf-8?B?N2xIaDhMekMrOWxXK0dVaHRTWThFNi81QmZGUXA2YVZTOTJ1NTlwN1IwUGV2?=
 =?utf-8?B?M2NpZVVMVmkxUkFUNXExYkNDWStpVDExWFQyUnFHZ1cyTkFoMEVsbVBCZ09Y?=
 =?utf-8?B?WTE4bGdtZEVlL2hUTjliaVRiM1FReGFBdFJqbFRUbjZ4Yy83R2p1NnNjWHRz?=
 =?utf-8?B?OStQTkx3WENlamZ1bWlLTGpkRnB3QkdIUlFjUCtTS2JSVzRLNG5JZWt6TkZt?=
 =?utf-8?B?VjFjRE10Uk9lK0NFaVlEbVpZdUgrWHpjR1BQcjA2QXlCRXFPdWhXaWlYN2Zo?=
 =?utf-8?B?QnlYcjM0YjB6b3hNMnNkOUdyekMzSGVtalBKRVBhaDhDMlVSR3hXb24wc0tO?=
 =?utf-8?B?cjBWeFZRV0FZYUNzZlpMa2VLZEJ1WnlWUmg0bmpaUjE2Y1liZU92eG45QUsy?=
 =?utf-8?B?M1ZSalBlbzYzeEl0dVBramR2THVvSXpMRkZndklFR0lXQUZPSWFPTkFJV24z?=
 =?utf-8?B?YUNsUG0zTTZ1bGZ4ZFlDV2Q4ZUFGeVRTc1kwTStITEVDZmlVTjl2UTNjVzNV?=
 =?utf-8?B?UDVjQ3B6MFBWZThRZStUVURZZ05BSVd0L200OEZaZXZ0NzkxQ0R6RktCakdh?=
 =?utf-8?B?bTVZOG5ZSlN4bGhaV2NRNlA3VEFRbjVkeG1FZ1lkbHJpT3pZYUh0cDA2TTky?=
 =?utf-8?B?SDB6L0I3cURQeVlxVEpKdVZyUmtaQ05nV0RjQWIyVXg3WDUwNUVVZHBrQzV4?=
 =?utf-8?B?enVXNVFMc3RSd2dxOWhlNUc5L0QvWjVCZ1k3M0hZYlI5TWVRdHhhc3dxeUdo?=
 =?utf-8?B?dmphWVNiSG1Ha2pCOXBmRTdZTFZFeTJxZlFOVVI0ZHhqUkdLVm1uRVlnaGdv?=
 =?utf-8?B?dWExVjNDeEpZWmwxTkxGNm1IRGZWSTFHY0R6d2dDVFIyL1pXRlZjK0Q2UWR4?=
 =?utf-8?B?WExWRnBIMVMzejNMMXZ6TW5DcnRRTHdmeithN0dneU1mQ1VlTkdjeDhVcUgz?=
 =?utf-8?B?VHRkUndydFZTbHFRSnhlanpQMUQyYXU1eWdOekJuS2pXbjJyaXloK1gydERi?=
 =?utf-8?B?QlBpL1gvNXZ4dWcxQUtxREVUSGpDcUY2L0ZQTHJMek1KejhZTk1abENIT2M5?=
 =?utf-8?Q?hM+num?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(19092799006)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU1KK2I1N2p2b2RPdm9lVURpbWxCb1lVUWY1a044NnlKWjdGY001UThtWUhj?=
 =?utf-8?B?KzdWSmJacXFGOTdHa2N5YUJPekNBYi9rdWRSc3JOZ1ZhTjFpck1ackl3UlRL?=
 =?utf-8?B?eG0rR202ZEx3eCtlU1JvQkJQckIvRFhKZjFzbEtwU1RxVlE2ZXcwMEt5YnVy?=
 =?utf-8?B?Ri9ZRVU3bzM4OTM1N09DOU0rZU55SUd0S3VqK1VGUHV1VTcxbFpKQXptWDJD?=
 =?utf-8?B?TDBKR3dvS0FCTTlXRURpcnJZTTRpS0NUUndERkRIdkhidzAwYWd3SlFTOFVu?=
 =?utf-8?B?Y1AvVlJ0SFhtM0hqakx0c0Vaa0NmRFEwTE54VEhROHdrYXBlUWQ1VmRmRDRX?=
 =?utf-8?B?Zk51YUNZZjNpSzVKZmFMVWE0dlhpalBJNTlzdEIreXpFSzl5eWFSdDN3cW9w?=
 =?utf-8?B?WkFhcmVOaTJUK0lLclZ4aDhabmxkcHk5OThISEIwbkpDZnJTVnpieTNPTGoy?=
 =?utf-8?B?TjNaOE9FT1h3SXpDbTRNYzUxaGwxMHRZQ215OVo2OXIrWWhKNGRtZENQOEU2?=
 =?utf-8?B?TkdCRUZRamcvcHpsdjRoNFpDZ0h3S1pneTNEaVZvTUtldk5vQWhjUmFjbm10?=
 =?utf-8?B?WkQxUWRXZU1hY2p6OG9rdmNMTVA3VUJmK0ZkanhuNmVRSnlLZGRpZU5iRndV?=
 =?utf-8?B?NUZGd0Zqcnk3L3c2emhqa1ZVTGtRTWpCdlBZOThmZzQvakl0cVp5MzdFaFBo?=
 =?utf-8?B?aXpOb1BuUGFGU2ZXc0V2U3VoeGREQkNTTzR4cE9QZzVMSVpPRzVjbVlNa1dj?=
 =?utf-8?B?anB5Vk9TcmVxWTdOMGNNVUdBSkNzVmNvcU9Od2VmbDI5TU4zempIL3Z0TWoy?=
 =?utf-8?B?V1hMS0h2ZEJmVHJRbkFjTEx6VGV5MkVNVzVaLzhDSSttbnZzYjJTZjRka1VU?=
 =?utf-8?B?RUtsdllxL1FlclpORElZSStpMENOSmMxa3ZOWXpxcy9xcnA5eW1rcDhDejZJ?=
 =?utf-8?B?blNKYTNVRSt6TEd2NjkzcmJkWkJSZHhubHd3WmJCd01tYU9UWUthL2NrSUdF?=
 =?utf-8?B?cDNPOEdOZklvbCtESzNhMTRmaHpDN1V3S0NNZG1yYUVnK25rRkQ2RitTbGQ0?=
 =?utf-8?B?SlF2R3NyT2swVVBxOUhWUUcvN2ZSY1pDNHJ5dWlZV0ptUEJacmMrSGlubmhn?=
 =?utf-8?B?VStYay92V0JxVUZJVUxUZFR4MTBZVGtpT1VPVUIyMkVBM05VOU9CSi81R29Q?=
 =?utf-8?B?WXdFRlhlcHRVVDlOc0Ywcytrb0Y1SElObVNuWjNEYUl5MGZPUksyZVFydFdp?=
 =?utf-8?B?Z2lPVTArcTZCb2cyWm56aVArUWxZc3FSNXhjTDVhREwvcWtBYlZ0VHVlMzBN?=
 =?utf-8?B?d0xrSHk3azFRSk5DOG5sUGZXRzBOTktMZWJZWW9mU2pRc2JHZ0EvZ0p6QUwr?=
 =?utf-8?B?c0hFMnVrRDJNZkxOS0lIVlVwdy9MekNudkdxVlhzQXduUDN2OVFUaTZBdTgz?=
 =?utf-8?B?eVh3cFAvWGdZNW1kbWp4RTJpaVB1OWJINFhad1ZreFNXeUFDNUF1U0FBUHpU?=
 =?utf-8?B?R2JCeHpuZmZSS3FEY0hNYkFQbVNna3J0ZFVqd1lEcEhqdHNEeEp0cExEK1pY?=
 =?utf-8?B?S1hwRFBWNEk0V1MxaWlUY21QNzdOS2RTNGNLODBIWDB3Q29uU0dIWGtMRTYw?=
 =?utf-8?B?bjAwU2RrdXhJYWd1d2g1SUhuZHlQeU5ZM3pNZEFFUWwremZGSFFLZ3NEVnZ4?=
 =?utf-8?B?WjEyaW5Zc0FQQlZMeGFLZUx3Z3VpTXBMNlFlam9rMG53R1RmcHlpbXhWdTh2?=
 =?utf-8?B?eHViRHFLZzhLS3A4N25WcWNBaXN0QWpHNjZ5NDRaNVB4VGRaY3o2VnErejlI?=
 =?utf-8?B?NDJ5NEFZMnhVOCtJNFYwMkJ1Mm5nMVVEOEVGY2FUVG1UOXFBTVk0eTF0cVIx?=
 =?utf-8?B?ZUJEd2YyTE14cVNzZ3hlWlNaaFlMVUNCZEN0dkNUd2R2TExQU3JBS0tWNXhG?=
 =?utf-8?B?bUptQ0dlR3NkNUNyNXltdDJyKytKRGtIT1ZNcVdhMFhiUnNtdmFKa2twNUNY?=
 =?utf-8?B?dFdCdXR0TERycWRXb2UyaWRDT3RkQy83ZWFGejdwb3FhcTIwUE9QbkEyOE1E?=
 =?utf-8?B?OUFkRVg2TTF4UG9UaFZBa2p5VW4zajhXUnY2QzB3dXBMSWZIekxWc1hubEQy?=
 =?utf-8?Q?ltrgiNAizub9LgLTY6lWGci7Y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df37265-5ac9-4382-b2b6-08de0a2618da
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 06:59:47.8012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXdvM+6BiHxBAW//KXopm7J5YmTnI94SvHGN3nQP5jPYOCCMlMBEO74YFXE6+pmGsIQFM9u567eCtjdPvm8g2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9276
X-Mailman-Approved-At: Mon, 13 Oct 2025 09:18:15 +0200
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

This patch enables the USB 2.0 controller to operate in host mode on the
i.MX943 EVK board. It updates the device tree files to configure the USB
2.0 controller appropriately and modifies the defconfig to include
necessary support.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx943-evk-u-boot.dtsi |  9 +++++++++
 arch/arm/dts/imx943-u-boot.dtsi     | 28 ++++++++++++++++++++++++++++
 configs/imx943_evk_defconfig        |  3 +++
 3 files changed, 40 insertions(+)

diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
index 5496385dc4d..e6abe7ed2e0 100644
--- a/arch/arm/dts/imx943-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -13,6 +13,15 @@
 	bootph-pre-ram;
 };
 
+&usb2 {
+	dr_mode = "host";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	disable-over-current;
+	status = "okay";
+};
+
 &usdhc1 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
index 9c4882f7d79..9b2c1072366 100644
--- a/arch/arm/dts/imx943-u-boot.dtsi
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -83,6 +83,13 @@
 			};
 		};
 	};
+
+	usbphynop: usbphynop {
+		compatible = "usb-nop-xceiv";
+		clocks = <&scmi_clk IMX94_CLK_HSIO>;
+		clock-names = "main_clk";
+		#phy-cells = <0>;
+	};
 };
 
 &cpu0 {
@@ -192,6 +199,27 @@
 &{/soc} {
 	bootph-all;
 
+	usb2: usb@4c200000 {
+		compatible = "fsl,imx95-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
+		reg = <0x0 0x4c200000 0x0 0x200>;
+		interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&scmi_clk IMX94_CLK_HSIO>,
+			 <&scmi_clk IMX94_CLK_32K>;
+		clock-names = "usb_ctrl_root", "usb_wakeup";
+		power-domains = <&scmi_devpd IMX94_PD_HSIO_TOP>;
+		phys = <&usbphynop>;
+		fsl,usbmisc = <&usbmisc 0>;
+		status = "disabled";
+	};
+
+	usbmisc: usbmisc@4c200200 {
+		compatible = "fsl,imx95-usbmisc", "fsl,imx7d-usbmisc", "fsl,imx6q-usbmisc";
+		reg = <0x0 0x4c200200 0x0 0x200>,
+		      <0x0 0x4c010014 0x0 0x04>;
+		#index-cells = <1>;
+	};
+
 	elemu1: mailbox@47530000 {
 		compatible = "fsl,imx93-mu-s4";
 		reg = <0x0 0x47530000 0x0 0x10000>;
diff --git a/configs/imx943_evk_defconfig b/configs/imx943_evk_defconfig
index 27230ed3207..d308d29a1a5 100644
--- a/configs/imx943_evk_defconfig
+++ b/configs/imx943_evk_defconfig
@@ -66,6 +66,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_USB=y
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -112,4 +113,6 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
 CONFIG_ULP_WATCHDOG=y

-- 
2.43.0

