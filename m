Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FD8CCD185
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 07:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F172583990;
	Mon, 13 Oct 2025 09:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="h5a44845";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 392A58384E; Mon, 13 Oct 2025 09:00:36 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF7078381D
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 09:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KC8uiyW8H693W8BLGaBe5Z1ugCwm0h04VrSNbps8E7otW4CpwOgMGqUkNyjpSldUgtFo5qaJEqDvnfHi8IDQ6PvNU5UGbwVv43Crz/DxgE4pxN9J2Igm8sx9j4rmxoeXzYuknQW1AbrbK69CtTEYYSSQZMVQyRgiumbXxOzL8zFMAxGn5HJYchBAL/tzC/rXgToiY7gMElxAgEp51lgvnl+2lwpE2/OEA9CpM0sN/oLt0YKA0c6Ai/0Xt3O/Elo9rjjljE9fYWkD42UbcoZ0dckPRMOKPPH50XvNcxUTvz6iILX/c2TU/YBWBzByFN5sLjzEbeeJPmyAJWffAtIIuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1n79sgq5W5tlYeKJA2dr4XQXysk3Aa69Z6QHmibGqmQ=;
 b=rLEIKJ99c0KyoR9abAw8cV6v/COmbewF/+TZ6zPPyMLjOuSSuMnN5YSU2+GQ6fYNc7QzNKur+8HapbllR3633eQtm7PkuTP/c35nFTjQVY+5t9rxqsfzfHGvV2EnNEtqvHwamAe5TLNP4F98sjqX5pzx7YqQi6xFMuN47Ma5bEcQlniQr53EIsj9+qLtWUMYHaarq+HC4N5mTD7AgA7vU6uq4w0ZdmmvuiqhHEno7BVu1QpOpvlTgp/1dmcgPSzeAUktW5vf+72KbaRdT0INKtamN2oCGtFmwRf785V366HF1bOBxZS8KgoGzmgXOSyR8RkKIxhKUzDN/s2myNXcwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1n79sgq5W5tlYeKJA2dr4XQXysk3Aa69Z6QHmibGqmQ=;
 b=h5a44845AJ66j/dkrtPe9dMXXvYRmD8iUbDN0Bw0CkEUQuCD6nx25mEObv1cM7SCPKxjdOpe0lzFnSQ2+aKERM+cvIALeCHXForDsEI/GMVT7JEgqgnje5kmzbTHkjHlxKy+gddyI2FvIyZXJfbKG//dGVyBvL+dBHumZnfqwKpDDfustK3zCO352A2iiZwj7P/mHOSlmkH+ooPmYcbQCKcYeagEdbm98ob0mT1MTxU3+Al4wH7SRp9ZFYpyMRg74TGnlcuHmqY5Vmiq2dNeZfuATSYjPpxN/aiLtHgV13NepptoXkPx2IHVc/6x54ms67C/SjwYJUP01eD3oxT7rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA1PR04MB10098.eurprd04.prod.outlook.com (2603:10a6:102:45b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 07:00:31 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 07:00:31 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 13 Oct 2025 14:58:49 +0800
Subject: [PATCH v3 08/10] net: fsl_enetc: Add i.MX94 support to NETC block
 control driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-imx943usb-v1-8-293e79d4bc12@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA1PR04MB10098:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e991aed-90df-4c88-21d4-08de0a2632fd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2VPVnhDeVpZUkgwTnN0ZEQrQmRFZGtCNTRmL2VQTkdTWDBTZ0RWRWNBaG9N?=
 =?utf-8?B?YzNVcXk5aXRnYW5pajYwTGJnYS9WWVRKZ2dxa05sZFlHNzJRRWFCeGxrd1ll?=
 =?utf-8?B?SGx0ZmlRNW5zeFQzRFRkVGxVdUUweG1Id1U3NEFJemhpdDVCaWNxbXEyNFAy?=
 =?utf-8?B?eHVwNzVna3ArMTRhS2paOGduQ1JaKzJKVUdMRXRwNCtDRVQxVTZrMmxnanVQ?=
 =?utf-8?B?WEJiaDlzejNZVnN3b1ZCUmp2YnpvNHFvQnNqd2lqOS9jVGtYN3Jtb2x1bUVP?=
 =?utf-8?B?V05wY2g5Ykd2TXB5MGlNekxBekdtVDR1TXpzV2xiTVhzUU5oRC9iNUY4UWhY?=
 =?utf-8?B?N2VZeXY1bml1WUlmTWROVDh6SGxHbksvdnNXSWZWSDFHR2ljb2ZrUUFWYXJ4?=
 =?utf-8?B?TWRJanlxbWxzZFQ0cGNqNVoySUVOdEFFOHBGbUNBcXEzZ2YwbURMYmJwSTQ5?=
 =?utf-8?B?elNYeXVHTkU3UldiY1kzUm9kekFWZkE1dmtFOEY2RDc2ZWR1VUJSU09sOVd0?=
 =?utf-8?B?ZFFhS0RTMzB5K0ZMU3NmVnFJaUFwOHR6cFBDSGtvV1FVeUlzUXYyU25RR01E?=
 =?utf-8?B?T3NRVWM5d29DKzNER2RQaFJNZmtvWm82YTV0b2lKRmtqN0dLdGF6LzNCZ3Jw?=
 =?utf-8?B?UlB1OUV4ZERxdFVjNDI5ZGZQYllneHkyN3BCSHdubzdrMjFJNzVWa0xEL25y?=
 =?utf-8?B?aGR4RXdINlpsajl5aHA3WitTZkxaQVV1SjhEZmhBbndUbTdxNytXLzd5Sk9R?=
 =?utf-8?B?aVhDZ005WjkrT284N1RzUWZIS1prQ29JdjUwd1ZXOGRyKzFtSUtsRUY5cDhF?=
 =?utf-8?B?bGY2bm8vMFhnM2g3ekVPUGdSU0tYcFhTSThTN3NVQWhZYW8wcEFRNk1TaGJv?=
 =?utf-8?B?UXVDaCtod0R6QTl6WDdZcTF2YU11UjFvTEkzd3Zid290MDdMTHM3azRFVFNk?=
 =?utf-8?B?bnRQM2p6KzVPdStKMU9MOGJiRC9yNm9CdktpbzZScmZkcHVJMXk4ODJUMXpr?=
 =?utf-8?B?VlhzdUtMR2xIbVdhOTgrRU93bWtJa1pqc0IzMkFvbFVrVk8rYWJWYVJMQVoy?=
 =?utf-8?B?WFRoY25iSTJZYldiamduZUttV2c3N1pna2padWJrNGRBdUJMWmJwSStSVEJu?=
 =?utf-8?B?QWVnbE5vZEhGNXJybjh4Vm1Pd0xIbjByYWRIc3Y2dEZRa1BvcVJZUWFaQSsy?=
 =?utf-8?B?KzRFWUM3VWVqZ1ZKbmNRdE1UbHNvblA4WDBnRkFJdlpEY3lQRzJyMHYzczhZ?=
 =?utf-8?B?enVSMEM0RVA3MFNvb3N3YndCVFM0UjFHcDJIU3B5ZVU3OHNWRnRkNm81ZEFV?=
 =?utf-8?B?NnlvSW05eUxDY1VKOVpsRjQxcDJlM29ENkxyWmR5TTZuNThNalo5c3ZBRWoy?=
 =?utf-8?B?Umdaa09heDNrMWFBdUt4bitocGxqQ2RrY3RLZ2cySVF1ODB0enEyemdRMnVr?=
 =?utf-8?B?RXNkWmV4M0pSZlJkM2ZVYU9vQXpsTlVwR2xtbXRXbWl4T2dXYXJlYmhRdmZM?=
 =?utf-8?B?UnBHejBwK0I4bmp6eWpDeUNUNERkTDIwU1JMTnZFVy9HeDV2ODc4TnNDVGpY?=
 =?utf-8?B?WVNFT0FvaDRlKzVJT3NxTlJ6NVlGM3dXRWNzMXpTcU5QK0hNR2gySW1rOS9R?=
 =?utf-8?B?V2Nhb3dVaUR1bjZxWS9pNVZkdFNSejlXaGVBM3ZnbjBxNU01WUhlQ3p2OXdh?=
 =?utf-8?B?dmFsa1lLMis2aWQzRHVQVXpXY3ZndzdKVEtIKzRhRjVlMjdHcXJESk9RbklC?=
 =?utf-8?B?WWJzWVMzcm5HampKUmlWVjNsTktBR1p2Nm9KQlZjNzlxZmwwU2Y4LzRFRVVU?=
 =?utf-8?B?N2RCckpCRzArQWhhR1huZE9jZzVXaVQ2amlSNGRuZkJhbk9MWCs0TmVWdDli?=
 =?utf-8?B?TnlidzBlbGdhR2FVaGpXRWdsOEQxMzdsMGpCYzNFMHplcGV1VVZLaEE5UU5W?=
 =?utf-8?B?TGdQUGNyN2kyTTVrdG1SeVcrbGVNekRxcFh0RWVGTTUzYWRUajlWNk9tRnBH?=
 =?utf-8?B?a1pWekNLQmc2VXlMZVpKWjgwZC9xbng3Nlk5enl1akVwSUR6M2xSTXp0aWhw?=
 =?utf-8?Q?A71jp9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlZlSGRFZGdrcVJVUm0yY0dKM0cvTmk4b2dqN2UwRS9nZm1TazN4a0RXK044?=
 =?utf-8?B?dVljNEdoa2FKSmhlVHl4aG1zOEF6b0I0M25mZ1F5bkxtNDRZUnFDVnZlMVJi?=
 =?utf-8?B?S0pqUTlhc2dtaHNBL09ZVTR6b2ErbVNoYi9MMjczZVYwNVJqVFJNMFA2UE5k?=
 =?utf-8?B?ZUU5dFVyNzVyY1JRNW95OVoreG40REVsd3RoK0p6bGc2RDk1MllCb052YWo0?=
 =?utf-8?B?SGltaVlLY2NHbkFlN0UyZitJNmNJQWNDUU81TWpIN2h3SGJ1NmhkR3A0eW5u?=
 =?utf-8?B?ZmVVdERBempTaHBqTENaZUF3RHBFMTVOVSthVDlkc1lBL1duMTYyTDE4eklV?=
 =?utf-8?B?NHlWRUsxb2loWDJ4bjVKWjU4ZGJDb3Z6M1dkQmJFT3BMZmlEWDNPdzduUGVw?=
 =?utf-8?B?d0o5bEdrMlJLdEg5OFNXUnN3dFRLU0o4TEZtMk5oaWp3M2pWditjbkFsRGJa?=
 =?utf-8?B?S013NmpRU3U3TDIrcUorWmdvd3pVcTVXc28rc084aEFIWVJlZUNaeHl5Zytr?=
 =?utf-8?B?VGh5ckt5SGsrYkFEMkJQdE9mOXFYMCt6TkRXU0QxOUZBd1VnbnR1VWp3a0dH?=
 =?utf-8?B?a2hCNjAwN0QrYU5HdWdvWkxhTzR3YWw0NmxHcVdNai9BQlBWTmdWM2k4RHJW?=
 =?utf-8?B?TWlwdkhkRDZlL09JV01nWCtqVlB6bTdZRWhqMFhKUUN2Q1JsVmlVOFlqRm5E?=
 =?utf-8?B?VkkybGhKSm03UE5zeUVCa2VQajRCeGY5bkM0SzRBUHJHOE1HWGJPYU5MOGFm?=
 =?utf-8?B?Rm5zL3ViaXFXK01IWWdoWVpmK0FXTlg4N1RXWUo4RzlxRTVabm5RYVFNOS94?=
 =?utf-8?B?TGRVWWpDZnFxU2JxR2xJbEVFZURZUnkyRy9CcXEvQmw1VndyRndaTjc1RG5O?=
 =?utf-8?B?K2NHcXp4dWJacHZvam02YjVtczg2VVdqMkVxd2tKdjJnKyt1UjhrS2piUXJ6?=
 =?utf-8?B?cmtNbDZXci9jT0hFc092M2UyWXdXYXlmZENZWFFRc0ltVW9aNW0rTi9QYTY0?=
 =?utf-8?B?anRSK29OL3JQRHljRnBlWVhrdXBTNGxic0ZKS0YxTE9rVk4yM0U0Y1BnT0l4?=
 =?utf-8?B?WHd0cUlteTdSRFRhcXJkM2Vad3F5cjFZYWFWenNaRS9wNGVDL0swNW4vMWI5?=
 =?utf-8?B?NkR4alptNFFpcitYa01vNGJsTnE0ZEJpMzNBUU1OOHlJMnVLc0NzZXhWU0FQ?=
 =?utf-8?B?UCtBZ3ViS0h3aGFmMXpvUkhCSXN6NjMrSnBUeHZTdDQwUjJCcFJXMlg1aDVr?=
 =?utf-8?B?VmhIYjJyTy83MUxWYWlTVjF0SHRYVGYwUE1nbDlqbWRBRUN0NFVoTTlYSDVi?=
 =?utf-8?B?NHVZSUFEMDN0T3gwZStyTkZDZjlUSmF4TWdkN0pSWFZBSjd2QUIyUjF1c1FO?=
 =?utf-8?B?Nko5QzRuQkJOU2xtZFJDbUtNeGtNV2xQVUF2WG5BVS9LUHFicXJKbkZUNkJn?=
 =?utf-8?B?Q3hTWGRVSytKSkphQUlHeEVzbFhBV3poMFpCOFBHOExhZlc2eXdwZ3MzMy9P?=
 =?utf-8?B?ekw3aVR3b1hONkFLUUpsZ2JEcXdTaWJtNFR2dWRWNHJnWXBIS0NlR21kenBN?=
 =?utf-8?B?UEk2eTdpemZFd0JaSFlBemlRNFlUVGloR0diNVJndlNMTitwejUwaVdpV1Zq?=
 =?utf-8?B?eTRXVHhSakVqWHFRMWtlQ2VCdDUrT0cxQW5WWlc1SnJtSkdreDVDRVpSekFI?=
 =?utf-8?B?VFhpcVBoUmlvY0tobVVaQkZqMytJWEs4VnNKWFdoUGJnTVdlMi94bkRpSGY4?=
 =?utf-8?B?dGV4QmlGVmxxZ3FTTkNqSW1uUXpYWk5ZNEpxaHNKekErQlNZWnZsdWJ5enhq?=
 =?utf-8?B?VDlscjg2SnQzWE41KzA5YmpObmRSZnVXMGZKL1BCVUpRS1hrc3RYNEJvamNX?=
 =?utf-8?B?bEIyM3dtWG1EbTRJM0NMSkMrcGZFS3M2SnVLOFpCTUVjTjArMk10Rm5CeHVX?=
 =?utf-8?B?N0pmamNoZlRBeTBQUzRTVmN3TjkxV1pPMDBkRXFTOERUQ3VlUUZySzBUTHFB?=
 =?utf-8?B?R2ZwS2lTVEZ6T2lETVdDVEJqYlltVmRWdVZPWHpOMWU5NVZjRUdMMU5xcmth?=
 =?utf-8?B?MkhhV2sxUkhyNWRNNzNhRmhnYWhyRXprbWJ0WGVNRzEybFk2eGZUbUs2aTJm?=
 =?utf-8?Q?UQvjg+V5mwUJN1l8uIu22+rA3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e991aed-90df-4c88-21d4-08de0a2632fd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 07:00:31.5934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OI655oiMU7i/7SYlySF03qm2ijq46Q/tp+5AWmOLclSDME32JIcoPBZjP49iaC67L9BqCLeQEqu/k+WjSHJRqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10098
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

From: Ye Li <ye.li@nxp.com>

Extend the NETC block control driver to support the i.MX94 SoC.

Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/Kconfig                   |   5 +-
 drivers/net/fsl_enetc_netc_blk_ctrl.c | 329 +++++++++++++++++++++++++++++++++-
 2 files changed, 324 insertions(+), 10 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 7ae28c4e0d5..b292f7a6c42 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1002,8 +1002,9 @@ config FSL_ENETC
 
 config FSL_ENETC_NETC_BLK_CTRL
 	bool "NXP ENETC NETC blocks control driver"
-	depends on FSL_ENETC && IMX95
-	default y if IMX95
+	depends on FSL_ENETC
+	depends on IMX95 || IMX94
+	default y if IMX95 || IMX94
 	help
 	  This driver configures Integrated Endpoint Register Block (IERB) and
 	  Privileged Register Block (PRB) of NETC. For i.MX platforms, it also
diff --git a/drivers/net/fsl_enetc_netc_blk_ctrl.c b/drivers/net/fsl_enetc_netc_blk_ctrl.c
index fecd66eb15a..8577bb75632 100644
--- a/drivers/net/fsl_enetc_netc_blk_ctrl.c
+++ b/drivers/net/fsl_enetc_netc_blk_ctrl.c
@@ -43,6 +43,18 @@
 #define PCS_PROT_SFI			BIT(4)
 #define PCS_PROT_10G_SXGMII		BIT(6)
 
+#define IMX94_MISC_SOC_CONTROL		0x0
+#define SEL_XPCS_1			BIT(1)
+#define IMX94_XPCS_PORT_0		0x0
+#define IMX94_XPCS_PORT_1		0x1
+
+#define IMX94_EXT_PIN_CONTROL		0x10
+#define MAC2_MAC3_SEL			BIT(1)
+
+#define IMX94_NETC_LINK_CFG(a)		(0x4c + (a) * 4)
+#define NETC_LINK_CFG_MII_PROT		GENMASK(3, 0)
+#define NETC_LINK_CFG_IO_VAR		GENMASK(19, 16)
+
 /* NETC privileged register block register */
 #define PRB_NETCRR			0x100
 #define  NETCRR_SR			BIT(0)
@@ -55,6 +67,7 @@
 /* NETC integrated endpoint register block register */
 #define IERB_EMDIOFAUXR			0x344
 #define IERB_T0FAUXR			0x444
+#define IERB_ETBCR(a)			(0x300c + 0x100 * (a))
 #define IERB_EFAUXR(a)			(0x3044 + 0x100 * (a))
 #define IERB_VFAUXR(a)			(0x4004 + 0x40 * (a))
 #define FAUXR_LDID			GENMASK(3, 0)
@@ -64,6 +77,26 @@
 #define IMX95_ENETC1_BUS_DEVFN		0x40
 #define IMX95_ENETC2_BUS_DEVFN		0x80
 
+#define IMX94_ENETC3_BUS_DEVFN		0x0
+#define IMX94_TIMER0_BUS_DEVFN		0x1
+#define IMX94_SWITCH_BUS_DEVFN		0x2
+#define IMX94_ENETC0_BUS_DEVFN		0x100
+#define IMX94_TIMER1_BUS_DEVFN		0x101
+#define IMX94_ENETC1_BUS_DEVFN		0x140
+#define IMX94_ENETC2_BUS_DEVFN		0x180
+#define IMX94_TIMER2_BUS_DEVFN		0x181
+#define IMX94_ENETC0_LINK		3
+#define IMX94_ENETC1_LINK		4
+#define IMX94_ENETC2_LINK		5
+#define IMX94_ENETC0_OFFSET		0
+#define IMX94_ENETC1_OFFSET		1
+#define IMX94_ENETC2_OFFSET		2
+#define IMX94_SWITCH_PORT2		2
+#define IMX94_SWITCH_CPU_PORT		3
+#define IMX94_TIMER0_ID			0
+#define IMX94_TIMER1_ID			1
+#define IMX94_TIMER2_ID			2
+
 /* Flags for different platforms */
 #define NETC_HAS_NETCMIX		BIT(0)
 
@@ -73,6 +106,15 @@ struct netc_blk_ctrl {
 	void __iomem *netcmix;
 };
 
+struct netc_devinfo {
+	int (*netcmix_init)(struct udevice *dev);
+	int (*ierb_init)(struct udevice *dev);
+	void (*xpcs_port_init)(struct netc_blk_ctrl *priv, int port);
+};
+
+static struct netc_blk_ctrl *netc_bc;
+static struct netc_devinfo *netc_di;
+
 static void netc_reg_write(void __iomem *base, u32 offset, u32 val)
 {
 	writel(val, base + offset);
@@ -183,6 +225,142 @@ static int imx95_netcmix_init(struct udevice *dev)
 	return 0;
 }
 
+static int imx94_enetc_get_link_num(ofnode np)
+{
+	int bus_devfn;
+
+	bus_devfn = netc_of_pci_get_bus_devfn(np);
+	if (bus_devfn < 0)
+		return -EINVAL;
+
+	/* Parse ENETC link number */
+	switch (bus_devfn) {
+	case IMX94_ENETC0_BUS_DEVFN:
+		return IMX94_ENETC0_LINK;
+	case IMX94_ENETC1_BUS_DEVFN:
+		return IMX94_ENETC1_LINK;
+	case IMX94_ENETC2_BUS_DEVFN:
+		return IMX94_ENETC2_LINK;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_link_config(struct netc_blk_ctrl *priv,
+			     ofnode np, int link_id)
+{
+	phy_interface_t interface;
+	int mii_proto;
+	u32 val;
+
+	interface = ofnode_read_phy_mode(np);
+	if (interface == -1)
+		return -EINVAL;
+
+	mii_proto = netc_get_link_mii_protocol(interface);
+	if (mii_proto < 0)
+		return -EINVAL;
+
+	val = mii_proto & NETC_LINK_CFG_MII_PROT;
+	if (mii_proto == MII_PROT_SERIAL)
+		val = u32_replace_bits(val, IO_VAR_16FF_16G_SERDES,
+				       NETC_LINK_CFG_IO_VAR);
+
+	netc_reg_write(priv->netcmix, IMX94_NETC_LINK_CFG(link_id), val);
+
+	if (link_id == IMX94_ENETC0_LINK) {
+		val = netc_reg_read(priv->netcmix, IMX94_EXT_PIN_CONTROL);
+		val |= MAC2_MAC3_SEL;
+		netc_reg_write(priv->netcmix, IMX94_EXT_PIN_CONTROL, val);
+	}
+
+	return 0;
+}
+
+static int imx94_enetc_link_config(struct netc_blk_ctrl *priv,
+				   ofnode np, bool *enetc0_en)
+{
+	int link_id;
+
+	link_id = imx94_enetc_get_link_num(np);
+	if (link_id < 0)
+		return -EINVAL;
+
+	if (link_id == IMX94_ENETC0_LINK)
+		*enetc0_en = true;
+
+	return imx94_link_config(priv, np, link_id);
+}
+
+static int imx94_switch_link_config(struct netc_blk_ctrl *priv,
+				    ofnode np, bool *swp2_en)
+{
+	ofnode ports, child;
+	int port_id, err = 0;
+
+	ports = ofnode_find_subnode(np, "ports");
+	if (!ofnode_valid(ports))
+		ports = ofnode_find_subnode(np, "ethernet-ports");
+	if (!ofnode_valid(ports))
+		return -ENODEV;
+
+	ofnode_for_each_subnode(child, ports) {
+		if (ofnode_read_u32(child, "reg", &port_id) < 0) {
+			err = -ENODEV;
+			goto end;
+		}
+
+		if (port_id == IMX94_SWITCH_CPU_PORT)
+			continue;
+
+		if (port_id == IMX94_SWITCH_PORT2)
+			*swp2_en = true;
+
+		err = imx94_link_config(priv, child, port_id);
+		if (err)
+			goto end;
+	}
+
+end:
+	return err;
+}
+
+static int imx94_netcmix_init(struct udevice *dev)
+{
+	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+	ofnode child, gchild;
+	bool enetc0_en = false, swp2_en = false;
+	int err;
+
+	dev_for_each_subnode(child, dev) {
+		if (!ofnode_is_enabled(child))
+			continue;
+
+		ofnode_for_each_subnode(gchild, child) {
+			if (!ofnode_is_enabled(gchild))
+				continue;
+
+			if (ofnode_device_is_compatible(gchild, "pci1131,e101")) {
+				err = imx94_enetc_link_config(priv, gchild, &enetc0_en);
+				if (err)
+					return err;
+			} else if (ofnode_device_is_compatible(gchild, "pci1131,eef2")) {
+				err = imx94_switch_link_config(priv, gchild, &swp2_en);
+				if (err)
+					return err;
+			}
+		}
+	}
+
+	if (enetc0_en && swp2_en) {
+		dev_err(dev, "Cannot enable swp2 and enetc0 at the same time\n");
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static bool netc_ierb_is_locked(struct netc_blk_ctrl *priv)
 {
 	return !!(netc_reg_read(priv->prb, PRB_NETCRR) & NETCRR_LOCK);
@@ -238,9 +416,99 @@ static int imx95_ierb_init(struct udevice *dev)
 	return 0;
 }
 
+static int imx94_enetc_get_enetc_offset(ofnode np)
+{
+	int bus_devfn;
+
+	bus_devfn = netc_of_pci_get_bus_devfn(np);
+	if (bus_devfn < 0)
+		return -EINVAL;
+
+	/* Parse ENETC offset */
+	switch (bus_devfn) {
+	case IMX94_ENETC0_BUS_DEVFN:
+		return IMX94_ENETC0_OFFSET;
+	case IMX94_ENETC1_BUS_DEVFN:
+		return IMX94_ENETC1_OFFSET;
+	case IMX94_ENETC2_BUS_DEVFN:
+		return IMX94_ENETC2_OFFSET;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_enetc_get_timer_id(ofnode np)
+{
+	int bus_devfn;
+
+	bus_devfn = netc_of_pci_get_bus_devfn(np);
+	if (bus_devfn < 0)
+		return -EINVAL;
+
+	/* Parse ENETC PTP timer ID */
+	switch (bus_devfn) {
+	case IMX94_TIMER0_BUS_DEVFN:
+		return IMX94_TIMER0_ID;
+	case IMX94_TIMER1_BUS_DEVFN:
+		return IMX94_TIMER1_ID;
+	case IMX94_TIMER2_BUS_DEVFN:
+		return IMX94_TIMER2_ID;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_enetc_update_tid(struct netc_blk_ctrl *priv, ofnode pf_np)
+{
+	ofnode timer_np;
+	int offset, tid;
+
+	offset = imx94_enetc_get_enetc_offset(pf_np);
+	if (offset < 0) {
+		printf("Find unknown PF node.\n");
+		return offset;
+	}
+
+	timer_np = ofnode_parse_phandle(pf_np, "nxp,ptp-timer", 0);
+	if (!ofnode_valid(timer_np)) {
+		/*
+		 * If nxp,ptp-timer is not set, the first timer of the bus
+		 * where enetc is located will be used as the default timer.
+		 */
+		tid = IMX94_TIMER1_ID;
+		goto update_reg;
+	}
+
+	tid = imx94_enetc_get_timer_id(timer_np);
+	if (tid < 0) {
+		printf("Incorrect bus/devfn of ptp-timer.\n");
+		return tid;
+	}
+
+update_reg:
+	netc_reg_write(priv->ierb, IERB_ETBCR(offset), tid);
+
+	return 0;
+}
+
+static int imx94_ierb_init(struct udevice *dev)
+{
+	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+	ofnode bus_np, pf_np;
+	int ret = 0;
+
+	dev_for_each_subnode(bus_np, dev)
+		ofnode_for_each_subnode(pf_np, bus_np)
+			if (ofnode_device_is_compatible(pf_np, "pci1131,e101"))
+				ret = imx94_enetc_update_tid(priv, pf_np);
+
+	return ret;
+}
+
 static int netc_ierb_init(struct udevice *dev)
 {
 	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+	struct netc_devinfo *devinfo = (struct netc_devinfo *)dev_get_driver_data(dev);
 	int err;
 
 	if (netc_ierb_is_locked(priv)) {
@@ -251,9 +519,11 @@ static int netc_ierb_init(struct udevice *dev)
 		}
 	}
 
-	err = imx95_ierb_init(dev);
-	if (err)
-		return err;
+	if (devinfo->ierb_init) {
+		err = devinfo->ierb_init(dev);
+		if (err)
+			return err;
+	}
 
 	err = netc_lock_ierb(priv);
 	if (err) {
@@ -264,6 +534,31 @@ static int netc_ierb_init(struct udevice *dev)
 	return 0;
 }
 
+static void imx94_netc_xpcs_port_init(struct netc_blk_ctrl *priv, int port)
+{
+	u32 val;
+
+	val = netc_reg_read(priv->netcmix, IMX94_MISC_SOC_CONTROL);
+	if (port == IMX94_XPCS_PORT_1)
+		val |= SEL_XPCS_1;
+	else
+		val &= ~SEL_XPCS_1;
+	netc_reg_write(priv->netcmix, IMX94_MISC_SOC_CONTROL, val);
+}
+
+void netc_xpcs_port_init(int port)
+{
+	struct netc_blk_ctrl *priv = netc_bc;
+	struct netc_devinfo *devinfo;
+
+	if (!priv)
+		return;
+
+	devinfo = netc_di;
+	if (devinfo->xpcs_port_init)
+		devinfo->xpcs_port_init(priv, port);
+}
+
 static int netc_prb_check_error(struct netc_blk_ctrl *priv)
 {
 	if (netc_reg_read(priv->prb, PRB_NETCSR) & NETCSR_ERROR)
@@ -272,14 +567,27 @@ static int netc_prb_check_error(struct netc_blk_ctrl *priv)
 	return 0;
 }
 
+static const struct netc_devinfo imx95_devinfo = {
+	.netcmix_init = imx95_netcmix_init,
+	.ierb_init = imx95_ierb_init,
+};
+
+static const struct netc_devinfo imx94_devinfo = {
+	.netcmix_init = imx94_netcmix_init,
+	.ierb_init = imx94_ierb_init,
+	.xpcs_port_init = imx94_netc_xpcs_port_init,
+};
+
 static const struct udevice_id netc_blk_ctrl_match[] = {
-	{ .compatible = "nxp,imx95-netc-blk-ctrl" },
+	{ .compatible = "nxp,imx95-netc-blk-ctrl", .data = (ulong)&imx95_devinfo },
+	{ .compatible = "nxp,imx94-netc-blk-ctrl", .data = (ulong)&imx94_devinfo },
 	{},
 };
 
 static int netc_blk_ctrl_probe(struct udevice *dev)
 {
 	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+	struct netc_devinfo *devinfo = (struct netc_devinfo *)dev_get_driver_data(dev);
 	struct clk *ipg_clk;
 	fdt_addr_t regs;
 	int err;
@@ -318,10 +626,12 @@ static int netc_blk_ctrl_probe(struct udevice *dev)
 
 	priv->netcmix = (void __iomem *)regs;
 
-	err = imx95_netcmix_init(dev);
-	if (err) {
-		dev_err(dev, "Initializing NETCMIX failed\n");
-		return err;
+	if (devinfo->netcmix_init) {
+		err = devinfo->netcmix_init(dev);
+		if (err) {
+			dev_err(dev, "Initializing NETCMIX failed\n");
+			return err;
+		}
 	}
 
 	err = netc_ierb_init(dev);
@@ -333,6 +643,9 @@ static int netc_blk_ctrl_probe(struct udevice *dev)
 	if (netc_prb_check_error(priv) < 0)
 		dev_warn(dev, "The current IERB configuration is invalid\n");
 
+	netc_bc = priv;
+	netc_di = devinfo;
+
 	return 0;
 }
 

-- 
2.43.0

