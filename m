Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D96F8FA90
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B64884310;
	Tue, 21 Apr 2026 17:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="D0qRaAEb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A13B83A91; Tue, 21 Apr 2026 15:59:15 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F15D83693
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtOpnV+AHUgHnJ2MANQVhki3cQUz8Am8PDSeVFbfZSNDt5kk+itzGit6Usm2P4Ul/i+P1pDep025Cqx90k3pi/CMLc0ZLdr+QVCu/bdDkZTD2xvU1XX97eYJEIsjrNrA0JKqT79v3404Y/DRC3wqM0YirYp1IlKjGbTI4ciDjTuoTYY582r8lweXE6brH/kqmiRnDzQyYNuNK++pSiE3VB7R2nmEIasJnVtaCzhGpZjZKO7uzDiEqg/mfJzqZBFvbu3I2rcfKWsrlvENEBzT1Zs8ylzDlpIn5zklo0QX1Dc+wjxPeCLBp1vdfjscTEKV3NYHnmD7VBur4ejcml8Kog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wScT5vfe5yovcJBlm8JEaMBS98bgTebJGY653iWOCuM=;
 b=WCW5oLv2y9gd7Z+EXlK0eJcAK31ddaO59S/n5f4EPuSiWiIhQSbCZmrM3KxM4IC+4D6v8IswZFZQLp4wvejZwYypo/HI36kUhhtlKSulUsQxXKxpDPOmA6VEHxnsBG0k4e/KO1AR9YZM4ZRWBk0AeOxCkN3s4fQyY7rWQUxM+xHAkk3KD5UEwt4KEvgJBbg2A8DnWubN8/fg/laBO9ndN9oAcpdVSttmUSKIX04l2qckjHnzw/oE4Vy2hadmcqIDBX/3JxlDUT21ZxlTO6tsBhkbrnD4R68YYn9S/ybXf83oymmwO5PcXhuoKfh+LXXu+0Afn8o+esXkd/J8pqEEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wScT5vfe5yovcJBlm8JEaMBS98bgTebJGY653iWOCuM=;
 b=D0qRaAEbATOTVDEv0lHp/yqkVB/ASX1ejN4IJYF+PYLezrVDHvy7qWENZA1oMtXnQj2AaOvD1C3ETiN+5V3bTkwSIMSQb6pEBPf03+oJ+e2Y9Veh25Fl/Hx4ROgxPJdry9g4HkvEc/LQGaFeDCNpxwQws9EjR8CT6bLiUFQq+FmmVlR2Iw/OlfVDtiWIwJ1PL26cMeH7jZ+zqyCU62I/XBvBYgu+7p63dVysF8JI3xGK/LgKzrlSzFM5eFM3gebltEkTg0OVvI1ZUyjNBPREHZ2bBrMJDLLJ+MzNjUAMxd0XYG0L0WE74ohqVGLAvF/Dt4NCVy1SQmOGUj+3fILnFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10426.eurprd04.prod.outlook.com (2603:10a6:150:1cc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 13:59:09 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9818.031; Tue, 21 Apr 2026
 13:59:08 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v2 0/5] imx: Switch watchdog addressing from macros to
 devicetree
Date: Tue, 21 Apr 2026 22:01:26 +0800
Message-Id: <20260421-wdt-v1-0-0bd01ec6a7c4@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADaD52kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyND3fKUEl2DVEtTAwuDpFSTFBMloMqCotS0zAqwKdFKZUZKsRCx4tK
 krNTkEpB2pdpaAA9AZXJrAAAA
X-Change-ID: 20260421-wdt-0e95080be4d4
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
X-MS-Office365-Filtering-Correlation-Id: 0adfefd2-2168-4161-7ec8-08de9fae2848
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|7416014|52116014|376014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: IqfIZEU87eY6tK73E/zZ1GTjCro5qjSSDbXcDlxTYYN51A+zvkjpkv4c+E9gky1PdbxRwnDY0olCcy4XIoHraTQxfiZN+XR87/JKW/Hd0rIbp3pEKe5HQfupdioa6nCHiuDM19hwR+kuKc+5++jA3gorZu+TYkArWrss0OKDZVdBg81Mqt2MuB6twAJG0PALu2zg5wDQMO5U8cfEoXUdziw5WWNLonvg8FvHwyouFpB5BsnZc8xtYS+qCpq/84C1jRs8chNQbHieUz5vL3tg63JmybLmr6N/iRXz0yPtC+HxEg2G+v4ZVCjxwBIuPcH0AZ3uz4c2QtgQ4KZfCNtCFZnmPdihGHX20rUA2jwaFyW8yOJ6rerqR1HKbD+l2X4IzDdQfxwbFOIRA9KiqxDBZn8DDZ05sC+ILEY9WwvU0Rlg6Oj/JXEyKYn+SepcxWTReczcHBmESRqo/W2YdayuK5YnC40gMss9cTnKl+fGOoCaRLmv5sbo1Qj6IrCPOtcm8FmafylWKFBjeVhTyXOxk+fiz2ks6Z3jLt/q4Ti4fzDDNLtpi6RZDKB00pz4F2Ath/OIku/gucSCDZhqLNM/v5SrKC/LRGQU4mc1VzbYD4KgV5kjCn+Fi9SSCEvB8FQ55dNN0XcyOMtXXE8JPb7hyK1dISo1sfW+2phegCawaR7mymyDIa36jysoUpAqXjw02VnpLXJBDxwVQCaZVhdAe48YvaZTkWIo2CaII1ycDjE3sBuW215rSklOlnhyN1M3rlK4N42Q7syKgN6sVIOHtL2937/uJGDy71++ovCXZek=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(52116014)(376014)(38350700014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3lYN292TUhHNzdpVm5vak5TMysraHJPa3FON2FnUTVMU2tNY3VHMTdubVJK?=
 =?utf-8?B?NUt6UlhCcEV5YW9WZENLbU51Y28xU3J0OEk5alMyYldXTFIyN2NVdnlYQ2VI?=
 =?utf-8?B?NmFDU3l6ZVRneTFQUDE1U1dTczdEV2pWWnBqQ3E4OS9PZ0xkZDZTdDJoYmh3?=
 =?utf-8?B?TW5tZHdPTU5vY0dUaGlxWDRrYXRSbm5PSFRIaldnMjQybU1MRlRuWVBpUzhJ?=
 =?utf-8?B?QXIrU3h2MC93VGlCWUhoYWhiMjJLbGNOckJhWENWN25MQVRIYWhVcWhXL3Ri?=
 =?utf-8?B?MWNFS2pidUt4eElTMXFqQW9HNEE0WVpKUmo1MncrbkRKQ1lQck8vQXJLME9p?=
 =?utf-8?B?VVZkMmpQSHpqS2o4TTZlaUUzRjZ2Ujlmc3ZOT1doa2NFdDE2NERJVDlYclZG?=
 =?utf-8?B?bmNaT3VxQUFLYmpydnRmL0xPbDZTNXVLdEcvTnFJODlxenkzRW1IZzZOWFV1?=
 =?utf-8?B?RUtudHM3RGlUKzZ2alBnMHJNV1dHTTNPZy9YdXFjYjRudFJpZzF5eHpOKzI3?=
 =?utf-8?B?T1liSHpoMVFYVkRKQ1NGVHljdDRUeFhzNVJSNHlzc3d1Q3o3REhBMlRHZEtW?=
 =?utf-8?B?dE9ZMm12WTYrRHF5TUVOZm1JekNZOGxlZElpK3dEZkM5TDgxYVJOSFpnRnZG?=
 =?utf-8?B?NEhxRVpJb05oekpIb0dsa1RibWJ3UkN6cDhSUnhBbExJNGlGRjBaRit3VXBp?=
 =?utf-8?B?NisyZ25hRllSQ3EzbTVLdkJnTHZEUmdqZkdDemxVSlVmN0ZEOGJDOXBVOFVF?=
 =?utf-8?B?UTZCS0RIdUlRTEdLR09FWHc4UTVnbkxnQnYzZWl4Q0lhSHJOUXhXNTVISFVp?=
 =?utf-8?B?NTAxNWowNVJJb3AzR25SeklaVWtMOHQySkFsUG1OUEMyKzNxOUUwSVIwU3Zo?=
 =?utf-8?B?YU5yVGxsY3dRMnpUOUx0SEg5ZXhJc0ZHaUdhcXUyTWRPZERydW5OeXVVeDlL?=
 =?utf-8?B?ZHNYNjdQaVg1VGJMQXgvZlViTHAwQ2ZudU1GdldtYmttQlAyVVlGL1hKakdN?=
 =?utf-8?B?N3FWM2FOWlFranR6UU5WRXZ0TXVyOXdBYjJJTE1vNGpjaG9aRXdqZS94WEEw?=
 =?utf-8?B?V1NscTlzdHA0L3Z1NmdZVWtuVWtuVlU5TzF3bWk3NEFQbE5CWHJjTlVOcGlk?=
 =?utf-8?B?NTdpTzN5amd2eVJ1emMzYnlBbGFXVHNnajVrdklSR20rSXAwZTBPVGR4c2d5?=
 =?utf-8?B?VldnS0tQeWIvTW8yT1RIMXJSa2x0WFVyV1RJRG5uditTdXRnL0xzdnBBRk1N?=
 =?utf-8?B?YUFJM1dhQmdPNmRkTGRqdGdPeWFXVkN6SCsxaXpwOW93Q1BtUTZ2VlgwTFc4?=
 =?utf-8?B?RTUxdkhRanBNUEVsaXZGUmNXanJxN0VhQ28ybGtaWkdIZkp4dEFkclVvZGhr?=
 =?utf-8?B?UXRmbHVnTXhwWWI0L1BCZjVXSHNoR0NuUUZkWnFzZWU1VVpmbnU0VlNvOEF5?=
 =?utf-8?B?OCtwTk1IdW5IT3pvSEx6enpORVVvUTBEN2t0Z3JVQ3JNUXpJMHMzcXhyTGV2?=
 =?utf-8?B?STZ6ZkRsMjJMSmtJaGhwUHJMWWc1NDhLZDhVTDN6NTNQbEpLRzJObTJKV1NX?=
 =?utf-8?B?QnFKLzE4bHQvVnFwWEhvckZ5VzRMcWhwZDhpa09sdm9pS09oRG94L3JZUEhH?=
 =?utf-8?B?dGpwZFhNZHFxWjBldWo0bDdiU1I0TnJJYjBOcW5LVWF1Q1JLWVB1ZDJiWThl?=
 =?utf-8?B?dFVCaG5tanJJNnlsVzNlZjY0RVpud0FxVlZBQ01qcEdrZnJNWjJzNUVLMXB6?=
 =?utf-8?B?V0lSWlpSanpTQjFRVHF2MkV4QWRyY05iMnFDUStjWHFLWVVEYnhURVl6VFdM?=
 =?utf-8?B?Nmd4L3hOKzJYZGhWOGFwYUkxVWNUSWd5TXMrWElJdUNzeWpMSGZTbWlrOFlT?=
 =?utf-8?B?SGxlQWowMGttWUd4NzIraWIvdGtlMWZSeTdqcDdnSUN4dWEzNXpCSE95UFVt?=
 =?utf-8?B?dUNZSDlNc0xHTzJjc0JwRG84K1hBb1NPT1dhaG5iZTd6aTR2OFBiZDRHOFh6?=
 =?utf-8?B?Z1lJQStUb1Y5RUx4QXNWVlQ0WktVcDc1MGM3L1hJUzB6RUZEbGZGSVE3MWRR?=
 =?utf-8?B?cWpqeXI5OTVLTnFQRTRHTVA0eCs2bm5GaFhmRjR6U3kyRkxXajVYMzYzUVA3?=
 =?utf-8?B?VzZLTWhsRFhoQVRERFd3bWd5WnkraWdHcjlLSHhyQXRJTnhxK2F1ME55VFk1?=
 =?utf-8?B?bzJ2Vm1YTFVGRjFCREFrc0VHcklTSUMwNllSWTllQ2VUellRQnpFbExEVC9s?=
 =?utf-8?B?aWZFSGNaTDhUcno2ODhja0tNOGsrUlh0YXhkUVZRQU5MSHJaMEUra2Fic0x2?=
 =?utf-8?B?TDRKRURNcUhTMkFPYTM2UkhudkhTc1dlV3N1V1VmYXAxdC9pdElUUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0adfefd2-2168-4161-7ec8-08de9fae2848
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 13:59:08.5760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNZvvWSUq4/5skZWqNRM9MghKpFG8m1fR04QhgaaCkeE9R3KqRhC1EqUd42EPQB4VF64G5kBw72QG9uL6tDIOA==
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

CI: https://github.com/u-boot/u-boot/pull/935/checks

Changes for v2:
- Iterate all watchdog nodes in device tree instead of wdog alias
- Delete non-DM implementation of the ULP watchdog driver

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (5):
      imx: soc: Get watchdog base addresses from device tree
      arm: dts: imx: Update watchdog nodes for dynamic base address lookup
      watchdog: ulp_wdog: Use driver model for reset_cpu()
      arm: dts: imx: Enable watchdog driver model support
      imx: Remove hardcoded watchdog base address macros

 arch/arm/dts/imx7ulp.dtsi                        |  6 ++
 arch/arm/dts/imx8ulp-evk-u-boot.dtsi             |  4 --
 arch/arm/dts/imx8ulp-u-boot.dtsi                 |  4 ++
 arch/arm/dts/imx91-u-boot.dtsi                   | 12 ++++
 arch/arm/dts/imx93-u-boot.dtsi                   | 12 ++++
 arch/arm/dts/imx93.dtsi                          | 18 ++++++
 arch/arm/dts/imx943-evk-u-boot.dtsi              |  4 --
 arch/arm/dts/imx943-u-boot.dtsi                  | 16 +++++
 arch/arm/dts/imx95-15x15-evk-u-boot.dtsi         |  4 --
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi         |  4 --
 arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi |  4 --
 arch/arm/dts/imx95-u-boot.dtsi                   | 14 +++++
 arch/arm/dts/imx952-u-boot.dtsi                  | 14 +++++
 arch/arm/include/asm/arch-imx8ulp/imx-regs.h     |  2 -
 arch/arm/include/asm/arch-imx9/imx-regs.h        |  9 ---
 arch/arm/mach-imx/imx8ulp/soc.c                  | 14 ++++-
 arch/arm/mach-imx/imx9/scmi/soc.c                | 15 ++++-
 arch/arm/mach-imx/imx9/soc.c                     | 16 ++++-
 arch/arm/mach-imx/mx7ulp/soc.c                   | 24 +++++--
 configs/imx8ulp_evk_defconfig                    |  1 +
 configs/imx93-phycore_defconfig                  |  1 +
 configs/imx943_evk_defconfig                     |  1 +
 configs/imx95_15x15_evk_defconfig                |  1 +
 configs/imx95_evk.config                         |  1 +
 configs/mx7ulp_com_defconfig                     |  1 +
 configs/toradex-smarc-imx95_defconfig            |  1 +
 drivers/watchdog/ulp_wdog.c                      | 79 +++++++++---------------
 include/configs/imx8ulp_evk.h                    |  2 -
 include/configs/imx91_evk.h                      |  2 -
 include/configs/imx91_frdm.h                     |  2 -
 include/configs/imx93_evk.h                      |  3 -
 include/configs/imx93_frdm.h                     |  3 -
 include/configs/imx93_qsb.h                      |  2 -
 include/configs/imx93_var_som.h                  |  3 -
 include/configs/imx94_evk.h                      |  3 -
 include/configs/imx95_evk.h                      |  2 -
 include/configs/kontron-osm-s-mx93.h             |  2 -
 include/configs/mx7ulp_com.h                     |  3 -
 include/configs/mx7ulp_evk.h                     |  3 -
 include/configs/phycore_imx91_93.h               |  3 -
 include/configs/toradex-smarc-imx95.h            |  2 -
 41 files changed, 187 insertions(+), 130 deletions(-)
---
base-commit: e3405917a1806971d9e72a94186b299f05581e1a
change-id: 20260421-wdt-0e95080be4d4

Best regards,
--  
Alice Guo <alice.guo@nxp.com>

