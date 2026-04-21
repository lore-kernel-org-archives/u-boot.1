Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25ADEF8FA94
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7E4B8433B;
	Tue, 21 Apr 2026 17:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hS0NTvwS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12DE383A91; Tue, 21 Apr 2026 15:59:36 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B683E83693
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZ403Gm8V+jcEZXF0dx9mpuQsexqw7u2UbiKuaDqmPv8tEY5rpKmnWK5xIBj06WFH41aguQ127Yjob630LHg6UvjbWku1aEBBeOdPMSO/6gCs1tGFQBvF0Bak/YMWfFHmRlXGa8prrV90nWcx0FROBuLDB7ppO7nqLEdMoSjcrQK/RFHE5QfrgOpdQkgTKYqAKM1wkZcRr1csMpAN9UwXHHyXvmoN9PKAlA77JCura1NKWQoqmtdGMpBX91/OI3yvIRgv3VZcgd6H4hMFnl46KloGQWvtFNc7274qbZAL77Q9HZRxc//BuNs+Rn/DCuVma8KDLPbPNsOaNmPvdddqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apbMoBHBSgDegwIhKezwhWjZfa/gJdtg5+yNt4bVgpo=;
 b=ysSFoAWyswYozDFS4MgIqq+ILd8bjAUlx+omn/jYn9cXB0jvKIF5v7kNvEDl1FggY4jUr0XQJgIOxNJkzf1zqesIowt1r6raugvlgl0I+Xu+5361uUrSGlzAkEf+lg/udw7sTwlkped5/4ku+H7f4uikmgldnJJV2LGW7eTM9ifL67jT11USQKdfBSe4pxkRA6Qqs6unJoPZx+YMCrLfRFhTkeeov/DWvp8jnz+SNCpLlApCziq3HbTclCAUQJyhISRD7opXNfjb5yEjgtzBr9D/YNq4SV2GF5rnqKW/TywSB19Nn7AaPpVyc1OFOEPHVLP1HVNB0mq6mJnk5vnU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apbMoBHBSgDegwIhKezwhWjZfa/gJdtg5+yNt4bVgpo=;
 b=hS0NTvwSCW7x74c3S3h5/Md261qyO82C4nugX8n5Pq49vZ8Fm4bhfS5g4OYY4vUIXZNGjYtyDBcU9PYlIjvHWGQFmq54eyZkQN03d06nBSJ8AVYDXS5denZiBCy6mxH/TABwe3wOst6jzzV6EhpQMuv3HimW3NCstsCSxO8oezi3h3vYiSK74qOm5OxI4P5K17uVcuzdxiXA723Vn3y6rmvIOTmyFRh0pfgqbjnvi8ph7SziSZ4UWyEAMOBmOs8ZYEe5gATFUkTkYDpawyzEpWFZIWpdpBJBmgDJ5qHtKBwitWcCPrj9fF1T0W/v0NAQJ0HeyCMolqEKJGdSg1Gznw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10426.eurprd04.prod.outlook.com (2603:10a6:150:1cc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 13:59:27 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9818.031; Tue, 21 Apr 2026
 13:59:27 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 21 Apr 2026 22:01:28 +0800
Subject: [PATCH v2 2/5] arm: dts: imx: Update watchdog nodes for dynamic
 base address lookup
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-wdt-v1-2-0bd01ec6a7c4@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e0025c02-ce3f-4cc6-c58d-08de9fae33aa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|7416014|52116014|376014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: vExTYC/GSft8T4AsmrMJIne9vMItCntS5vU4no+AH548XLHR6lFc5+FZMSmHdnoOOrhLcDOP2+4dwQnIdOPOkZyHT4IuIvr4veOWuWyFknM7aLeL3XgqbBb16yNIhbemmfUMHFZyflgz5QXkfQJGAFjQKctHcXsLv9FThfD/hplLgC7I7PEzcvSRqIr/50NwoLrbAZ8KPC4Z4ykQuPAuqJZhNoAIwFUnaWUyLZ5CYRnOZyUImo/3a2zvawbF93oV6VOyVvgZatSqJe2eDPR7WntOI8iTy0h8io2X4DA7pihSBK3mQdKumbryViTQDPkqE50L8zaMmfXkiEsUMrKLNohFVt2dkOum2nPDwG0/LCLAyMd7Mf3wjAk4LcMC0o9LytU+q1/sh0miMyk1bK4H4BDyc6DZIkUVdSD4MXxrHPiL47ybQGeWtR92CRdzw6/SFwlafYZbg4P9veHLEbTZSwH6zHnRiI+pMTHZ5l6WXUlCe120yrHJXgD7+uI6aTofHkIMMNlKSX/xP50sfocbWkOwjLUCyFw8kiuQTkD3g40lFZg84VFbSJsPryiRfP8sbbrsGHmUehsCQtJjsimZtuncKKBbWiCOKY6SPbvI5nTe4uouids98H6+D3/dn41nPMj3apP5a0EG9FtvCbXPJN8hwtWhOB7hhMx2AP5Tq6z5FFPUZMRFr5F7mzDaCCMNfeeTBr5k2KgQAAAXaqa5LxWSK6CJQ+I6Tfbv9/EImhjU6ZjSewJrlJ7/1cFOrwRpVZiqlUgr+0NfVWPTG++EooZnQrMbUGGEgtiZAniylRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(52116014)(376014)(38350700014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UldQc0JSQUNmTzd2U1VURExhTitqdmN5aHlyN054bnZNS29GU3ZzUm5mSGQr?=
 =?utf-8?B?OVVCYmh2dmxWVStpSW9wNURsaSs1emFIWU9rYUdhZGpsUVdDSVpWcGhVcHlG?=
 =?utf-8?B?REdsZC9hMDB0OXh0WUtoYmpUZW05OW94ZW5XVHZsckFJR2pnamhsQzFwd3Ju?=
 =?utf-8?B?a3dDQlVlaGVsU2syWDNSV1JkdmtveSsvZFpmR21VZG05OWdwOFNxSk42d0JC?=
 =?utf-8?B?UWNoN2xtaVpsYlVHbzZsVytleGJpRVdhdU9pRlduVnIyZHVlSG5xT1JlZUx4?=
 =?utf-8?B?OWFydmFBb01MUCtRcXJqTE8xdk41d296czJFKzNGYzRjWnZvMElETUtQZkh5?=
 =?utf-8?B?cldzT3hsSVRGUmJLMVIwWWZJbFh5WnorNGhBU0lkTnltcUdhbUVDR0poR1Yv?=
 =?utf-8?B?UG1MUFIvbzdNVWNUTVZFR0dRVDJ1bGx2c3pTUnoyeFBURlEvTlQySXpKQU9K?=
 =?utf-8?B?VmNSdHo0UzUwMzJ3LzJJUmNPWFFWS0xwZTZtSW9WTUpaeSs0TDZuUkd3VHhI?=
 =?utf-8?B?dU5scE9lWGdVdHluODJyOGRzTVczU0plSmZJMmlvWU5sK0RraHkwVSszYXVm?=
 =?utf-8?B?d3BWQXh6QmI4dU1yM2RNME1QUFZ0b2E3Ukg2Q3hKbDBINlFveUg2UGtWZnkr?=
 =?utf-8?B?VTBqelhCbklEWU9MbmdSRFlGYXJTR2pKM0VEVXU3enU1bFdIZFEzY1RQR1E2?=
 =?utf-8?B?RHJQRjJaa0k0ZUZlajhGQ0QxMEZTSUkwUW9YZlNVMit2WHBaQ0NoQjZtUCtv?=
 =?utf-8?B?VEpNQmwrdHdGQ09EaU54d2VqdDhhVFRvMk5XMXJzam9zb0l6bDE4R0RwTmlB?=
 =?utf-8?B?Tmo0QmxxNFRDRUhuMTZvRTVXNUEzRTIreW41c3BKRTZ3L3grU2czS3NtN2Zu?=
 =?utf-8?B?U2lSR1BobGVaWUVXMStrYkUyOUw0bk5LdXhuaWU1Y2VFQUlSc2VKSi9BL2hs?=
 =?utf-8?B?RTJqN09XaXUyWWZYejlSV2ZRdUhrOHhvbFR2Q292N2lLMmVxaTY4NGtlUWEx?=
 =?utf-8?B?Q1VhdTlyNkw1bytZYlUvVWEzSUIvLzhYYzZyeVlpcFZJaExPbXlTQzhKckRX?=
 =?utf-8?B?WkY4alVxV0h5WFg4LzB6bmZYTzRPTUFmK1psTktsc0E3NmhpdVJzTG1sTWhz?=
 =?utf-8?B?aEtQZGFhYnJoMU1zNmxuTjlDVjhZZURndTJFZFQ0MnAwbTUyeSsyekQ5bnlT?=
 =?utf-8?B?RlJnRnZuQk5kYjE3RDhVZFc1dzBoR29heFlHK2tUcksvSU5NdE1FbFVsc1BG?=
 =?utf-8?B?MXF4OXZ1eXpzSm9ZaHVubnVrRUZqNUJRRDI5UHZUQWsyQ0JDaE9ienlpbktF?=
 =?utf-8?B?VkV5WWxEOTZxcjNtdVhoenlKWThtcDI0aUhqWUtrWno5ZHZEaUYxSTFleno5?=
 =?utf-8?B?K3lhblFrTlkzUXJNTmNFSjVqcmpucndhK3lxNHk1WXo3QWhJOE9rVlRDMG1Q?=
 =?utf-8?B?Q0RpOWhLTStzWklOWFN3WFN6enBRb3VubFV6SVZZMFRjUTdUOTgyNENrc0Ju?=
 =?utf-8?B?bVJSOW41WGtrNE1RRWc5bGRLeTZja0lHMFRZcXNINUlzSzNnWDF3YkVDcG45?=
 =?utf-8?B?WXZMNEFXVHMrSlpDMlI3MFM3UlhzMkFpcUwrTml4UzZJYWhXZXBhblBvOFFj?=
 =?utf-8?B?ODNTMkw0NnJ5SE5BdjFSMVdRY3Y0ODV5NjBiZ2FyUTVZL1FBSEMvaTkvM3I5?=
 =?utf-8?B?d2NxM3VsenVmTjUyZGpLQ1B6dDhobTZ4TTZJMDUzUFlqYUl2UGdMbzZPWHUv?=
 =?utf-8?B?VUZPNytkdHEyWGlCQXZjTjIzUkVkc0cweWMrMld4NThIbjBBK1EySkNFMFBR?=
 =?utf-8?B?cFNqWXozVmpCWk5ScC9LTlU1eFcycnNmTm1WRVZpV0ZOdUU3dlBYcGtZR1pC?=
 =?utf-8?B?VmhyeWcyQm53aXliNjNKMURuSTl6R3RkWkJLaWd6aVNSa2ZxY0gwZ25xUEEy?=
 =?utf-8?B?aExpTDFkanRTZzJxZU5kUnpvMWFqcThmcjdqdGUxc2JtY1Y0S3EwcW00ZDU2?=
 =?utf-8?B?U1ZTNjZCMVByZ3FtcHM5V05WUkZVMEpUV09UY1ZGQ3dpa3d0WXhPL0FhbHdI?=
 =?utf-8?B?SStRYTUvN3NLZHdZSHRZSEJNdjVaMHhrSDVMallPdzczOW5Zd0pqNU5QRGRn?=
 =?utf-8?B?eXZFVmxZeDF4WVcxZFgwb1JZR2FzbFhibGFHL1VDQ290emZBamZPTlh2YUJh?=
 =?utf-8?B?bC9lRW5wdW0yc29SWFFOMlQwMXVLQU5uaFVHNEY0YVZGMmNUcjlMNjhmS2N0?=
 =?utf-8?B?V3ZqS3F1Y0VzaUl6Slo5cXV3ajNEaEgzQ3BLSmIvUmlCWlZwQ0JoZERsNktx?=
 =?utf-8?B?RE5ZZmpsT1lYUXN2T3VkWVk2V24vMnJ4NjBwTFhOVEZLU0F0RWlzUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0025c02-ce3f-4cc6-c58d-08de9fae33aa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 13:59:27.4588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THjtRBTFZpC6U5Ui6x7r73z9owEtpUvtWfe8z8bQQ+wvruDcA95ZP+fbWi/5VHYfRyHAvSjC6ueNKMUXCc4ImA==
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
 arch/arm/dts/imx7ulp.dtsi        |  6 ++++++
 arch/arm/dts/imx8ulp-u-boot.dtsi |  4 ++++
 arch/arm/dts/imx91-u-boot.dtsi   | 12 ++++++++++++
 arch/arm/dts/imx93-u-boot.dtsi   | 12 ++++++++++++
 arch/arm/dts/imx93.dtsi          | 18 ++++++++++++++++++
 arch/arm/dts/imx943-u-boot.dtsi  | 16 ++++++++++++++++
 arch/arm/dts/imx95-u-boot.dtsi   | 14 ++++++++++++++
 arch/arm/dts/imx952-u-boot.dtsi  | 14 ++++++++++++++
 8 files changed, 96 insertions(+)

diff --git a/arch/arm/dts/imx7ulp.dtsi b/arch/arm/dts/imx7ulp.dtsi
index bcec98b9641..45a69f06e20 100644
--- a/arch/arm/dts/imx7ulp.dtsi
+++ b/arch/arm/dts/imx7ulp.dtsi
@@ -295,6 +295,12 @@
 			clock-names = "divcore", "hsrun_divcore";
 		};
 
+		wdog2: watchdog@40430000 {
+			compatible = "fsl,imx7ulp-wdt";
+			reg = <0x40430000 0x10000>;
+			timeout-sec = <40>;
+		};
+
 		pcc3: clock-controller@40b30000 {
 			compatible = "fsl,imx7ulp-pcc3";
 			reg = <0x40b30000 0x10000>;
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
diff --git a/arch/arm/dts/imx93.dtsi b/arch/arm/dts/imx93.dtsi
index d6964714ea0..511e9594e37 100644
--- a/arch/arm/dts/imx93.dtsi
+++ b/arch/arm/dts/imx93.dtsi
@@ -414,6 +414,24 @@
 				timeout-sec = <40>;
 			};
 
+			wdog4: watchdog@424a0000 {
+				compatible = "fsl,imx93-wdt";
+				reg = <0x424a0000 0x10000>;
+				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_WDOG4_GATE>;
+				timeout-sec = <40>;
+				status = "disabled";
+			};
+
+			wdog5: watchdog@424b0000 {
+				compatible = "fsl,imx93-wdt";
+				reg = <0x424b0000 0x10000>;
+				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_WDOG5_GATE>;
+				timeout-sec = <40>;
+				status = "disabled";
+			};
+
 			tpm3: pwm@424e0000 {
 				compatible = "fsl,imx7ulp-pwm";
 				reg = <0x424e0000 0x1000>;
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
index 3457442a3b0..fca0f10c865 100644
--- a/arch/arm/dts/imx943-u-boot.dtsi
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -159,6 +159,18 @@
 	};
 };
 
+&aips4 {
+	bootph-all;
+
+	wdog4: watchdog@49230000 {
+		bootph-all;
+
+		compatible = "fsl,imx94-wdt", "fsl,imx93-wdt";
+		reg = <0x49230000 0x10000>;
+		status = "disabled";
+	};
+};
+
 &clk_ext1 {
 	bootph-all;
 };
@@ -460,3 +472,7 @@
 &sram0 {
 	bootph-all;
 };
+
+&wdog3 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.dtsi
index 6dec159752b..2fdb7e331b6 100644
--- a/arch/arm/dts/imx95-u-boot.dtsi
+++ b/arch/arm/dts/imx95-u-boot.dtsi
@@ -138,6 +138,16 @@
 
 &aips2 {
 	bootph-all;
+
+	wdog4: watchdog@424a0000 {
+		bootph-all;
+
+		compatible = "fsl,imx93-wdt";
+		reg = <0x424a0000 0x10000>;
+		clocks = <&scmi_clk IMX95_CLK_BUSWAKEUP>;
+		timeout-sec = <40>;
+		status = "disabled";
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
index e977014992e..082dab75a18 100644
--- a/arch/arm/dts/imx952-u-boot.dtsi
+++ b/arch/arm/dts/imx952-u-boot.dtsi
@@ -115,6 +115,16 @@
 
 &aips2 {
 	bootph-all;
+
+	wdog4: watchdog@420c0000 {
+		bootph-all;
+
+		compatible = "fsl,imx93-wdt";
+		reg = <0x420c0000 0x10000>;
+		clocks = <&scmi_clk IMX952_CLK_BUSWAKEUP>;
+		timeout-sec = <40>;
+		status = "disabled";
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

