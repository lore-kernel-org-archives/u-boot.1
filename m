Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CFDE9B37D
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 13:24:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 126C083FB0;
	Mon,  2 Mar 2026 14:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="J0JVky+3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF6CA83F14; Mon,  2 Mar 2026 07:42:13 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43F7683D17
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 07:42:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFgE8RVs5G0euvbEgi2Xb0fyjgvKgc8ZiN0MtJFSyI8iqDJG85hpB0uahrB0+s9egi8cpZtUaVaJsGrMCOsIu3vReHk4wbTGPBLvs5d4Jm6V4ZUKKPYkF3W+9krwa4h8X0owxiDHFsawAIzqzItNbKB1d7piWP8E/296Zwh+W6SmVZPs5sZDU7puxmvO5Aur8wK+wwyYfT284jSyAzfYDqN6iCymIjMRJWu/xbQUa07u+Ib7MXIxTqrl8DF3Tboujudo04SgbSSzxFehNlphKaZ3GZUE3h9+bCSB2gcpYx7ly3ZMoCCNYu3ZKe1DkAfpziSP4NXf1aenZodUhomxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAk2qdEUSjBY6KBGROa8AzUbEi2T2pyK0LTATyYadVU=;
 b=x7c+eV48M7P9D4ZQPB5cyG/p3igGLAjvuo7qy5bJpmVRX6X09i+ItMSDF8HBsIZ08992dTUZuVwytS/eWWP+0DkKWetaC+iAV+yl/rozikmLnVb+tVt80vF9Ufs+z+BmFwrbWWkL4V0voG86FwGV1SuQPKAp1uqji8gsR1RQK5ZQmyOw73K1NsXAOjVVFq5oMkp37F6F33mRGrk7/7eVvHfpLOyADis5eAnovo1bG3omKGS28wKTomUWabXB/YPDH/vb2wIOdCzzUUpaphDR66tk0zspqPkGPlsuclqrMy1Z18ch3q3ZfuKvjbfEP8cYoRuL6GPcFTmqYLxjvETXdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAk2qdEUSjBY6KBGROa8AzUbEi2T2pyK0LTATyYadVU=;
 b=J0JVky+3PKVU10fpSiYF8WsW5gUZNEa8K22u4YFaP24HfYc5QfzfKqMsKS91/VmZ2J7CZSMzMJi3m3fgEyJ3c7H9zadV2VNUIeu6ycCBC/PeYkGubJdGxOp0/FkjILuOVB5/RiwrocHheLAH0VqHXzZtqvUXLOANXuVPYL6rT++bJWRCSIBayrtMq+0fFuHOH+cctwXHAIBt5BmkCEIbVVHd35gfHGVDAPoDtyYYtXUVShKpdbJRZKcHg4te/hsaD9LYjGn1Po+NPse+eXLbZJHjLxwAmyvs+Ip1DaN5A66ZgagR9zB6Re1pp6XsH6spGWubA0OlfRs63YyIBEwHBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB11728.eurprd04.prod.outlook.com (2603:10a6:10:624::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 06:42:07 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 06:42:07 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 02 Mar 2026 13:20:14 +0800
Subject: [PATCH v3 13/13] board: nxp: imx952_evk: Add i.MX952 15x15 lpddr4x
 board support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-imx952-v1-13-069d6167c0cb@nxp.com>
References: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
In-Reply-To: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Jacky Bai <ping.bai@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, Adam Ford <aford173@gmail.com>, 
 Joseph Guo <qijian.guo@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Fedor Ross <fedor.ross@ifm.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Simon Glass <sjg@chromium.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB11728:EE_
X-MS-Office365-Filtering-Correlation-Id: 508e5384-a417-4293-5df1-08de7826d29f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|7142099003|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info: brP4vYm9RlyKBm7V8FHAiToIg2Zz79ap50EYmyYqM4q1e/Dwi600yj4Bn559J35BrVKI5skeZQw6L6ALJhSHg/Dr7n4cof/8zwzxodzhSXqqwlMGz1aUXkwV6iKAUAxPO9fS+TOxZ1ClnEWKmcy6rVc4j2OEVnC4AgyHgo2eIBmwgRWpsEaVN0kjAEuZOoSQV10nYl8+FimjD7lZCuTcpiHvd7vkvly6EYb3XT9OKRIWCbCnIIQwHVjXR9R6gfWndJEG3x4YsKjhZCzKG3UNQG5U9vQtZ01NJD6IgqtaWFalxTLziu/3YdvpEAkz4sOzShEucNZZOUmOsoSCpNMDhqc045Cv9vB0bCkuIBimDbS7gj6D9wRtK4jCACjvclionnA1HI6OEnXlHtkPtdMZx1RApTxksvZIn/8dexXJQ0qLtLHlP1nvz9pZwoAw3tsDo4h2EEhIIVr167mrUAOs8DHOKz/qkyfkYS9zdv+WqCk45u+y8jffg1tLv4FEldM42qaLa1NfmGTbO4SnVZc6/IX0xys6HVcDt5D5tvjOHMN380FKeR0+SP03HP76CdsDe4Q55h38RV7dfNAwkcB7kYW5rou6prSG+n6eBBMeYto2+HSo774732ns2+CUTQ3pQhTwe1cZxMcCzrvIpy1oZX3gdW1dSJJsoVea0f0Yz96+J9UWBt8mBSXtlZJSbBun6N/T1UW4bWlat13UE4+rwQg7MYJPoUN9kasUk2lS9Yt3Gm0yj5sJ7v8QCi8VsOzlEbnHag4SHeJ/24I5jZi8D6qpnpDMWctVsjxaSXMhovyT+SQ9stKIAakFGGSEJOnx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(7142099003)(13003099007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekVycGJBMVZ1Z3hIMk5DZER0L2F2cGVmOEZnbWxReDFSNkhKVktiK2lGWE1w?=
 =?utf-8?B?bU9GNTR0RUIyQWhLYldYTVJMUGJPa0dDRW52aEt6OGxnTTkzTHRuRHF4ZXBs?=
 =?utf-8?B?NXh0M0wrdWRJRGZ1NDZWdkVoNW1USUZ3RzIxNWQ0M3BWdndTbjNqZ1VOZVpt?=
 =?utf-8?B?N0k2dExWMXdtcGZZTVJmbEFiUEtlenFKRGt4RVlaOEhqK1NqdDlhbXU4dkJJ?=
 =?utf-8?B?b2N5V2lTNFY4em16ZzRrRzNhU3RoaEloZVJyTHFUTnNyY0hLM0tiMkdQSU11?=
 =?utf-8?B?cjVaVUo5V3dtdHB0NjZxYkhscjVNaHo1cTkwaXNja1RUUlZXdjZLY1lqT3c1?=
 =?utf-8?B?cUZtamRMUFZhdmFWdi9rdDJjZXBKeDFGQlM4eUx1V2VLUHlMamF0MThscVJK?=
 =?utf-8?B?OWtaZm5BdGVkbUJsR3FNQ2dNY3BXQW9vaGtoSHlISmxwRlhRZFU2SVNNS1FU?=
 =?utf-8?B?aGJENW9ZWWhxYzc0TzZuODJ1YlhCbC95d2VmeE0yRDBuV29QYUl0b0pDNG02?=
 =?utf-8?B?UEg4eVI2VUNuZ1BnTDRjeEl1N2h3RnBwVElWQXdRaXRVeUxUTUtOYVdjcTJI?=
 =?utf-8?B?TGZ3UUxsclg5ZVhyYk1QYXV4MEhPRlJJY21EZk4raG9SMDNXQk1qeE5nTFFG?=
 =?utf-8?B?emcrS3lnc0pIaFRpTjYwOGE1V2FBQXREb1VwSVBObFlwNWNKdU4wbHNJYUVW?=
 =?utf-8?B?Q1VCQnhNQXoydWwwTkRzVUduU2RFRlVJZUlNS3JYeTBtUjM2cVRacDE3NDlR?=
 =?utf-8?B?d3NLYTE2TEJSN0ZjOGNzMzRQMmlJUG1lc1AycndtbzRMVklvTW93VE4wNTR1?=
 =?utf-8?B?TmljVlBzb2ZVbDFESGxETWpaVjY4Zi82VTZINmt5a1oyc2JyMGVoNzBDdk1x?=
 =?utf-8?B?UDJEMCs4OHVXNVpYanIwTXVzU0NabWFienc4aU50aGFDZzZGMEg1cy9sKytl?=
 =?utf-8?B?K1l4ZWNja2xyNzZ2aWpSYnpZb0hQM0l4U240UGRnMGp1SmhzZ3ZkWjlTTjMy?=
 =?utf-8?B?THF0Y3RxNnhVWHZ0SFZ2U0NTTmNpUDlSSm5vRXFqR0VpbW9lMHdNZ2d1eUsr?=
 =?utf-8?B?RC9KTkxrZ1RVL3ZHUis2NU9mdlVBQ1plNkR0MjZURVlyUnA5WTZkUGIyS053?=
 =?utf-8?B?WVlvaEhFQlM5c2NvRzhKWXV1aStHNkdBUGpOdnVTaXVjL2NHUjlzeUdGVldt?=
 =?utf-8?B?TStkK0tnY3Y5K3hKbWx3R1kvTFIrVFEzeGRQZ3RiYnJhMTJIemllKzhvUW04?=
 =?utf-8?B?WWUvVlJybWJHZ2ZSR1NuSC9sbk12cWFhcWdQNVNaT0xSUVJpaVFtbWk5VnN0?=
 =?utf-8?B?QmlVeHplWkhGTlp5bWU1cnh4aGk5bG5GRm5LemcwL251MUNwdTNVa040aTlY?=
 =?utf-8?B?MGxHS1JPdGpaU2NzbUozeHJWWG8xMEhudlFNOG5sdzF5bXo2WjlFZWU2V2VP?=
 =?utf-8?B?SFNES0JSdGRzci90RFdOSFk0VUE1NFNqVzVSK1VUZE5RdnhrQmZidmZJUFFw?=
 =?utf-8?B?ZVo1UnBnOWFKUUd1YVBzRlVIRzVDYlB1U2NaZGFabHdjZmsvREp1S0t6Z01i?=
 =?utf-8?B?bGJsRXBROEgzdEV1bi9BMXpvNUZlZGJwNmJrRDZjL2lXdjFxK0VJdjlUdlZF?=
 =?utf-8?B?MDZGV253RUN6djJjbFZiZlIvNFhVYlM0aE0ybW9ZMXlOTEpYUDkyMVIrQlo5?=
 =?utf-8?B?eUhobjA3TU9HaXJac2NhU2JpckFuY1lDN3pSUEsydW5aRW5BdzUwZGt2dkk5?=
 =?utf-8?B?ak1ndTFwTDVhQ0hiRFZ5NWFOeUJyMkhDRHp6bEQrUVNsS3E4bjd1MThYcjMv?=
 =?utf-8?B?QWJlRUJIZWNNSVlMWDhKL0RWNXNkWmgvTzByRUM2VWtod0FxenJCRWZ6QS9n?=
 =?utf-8?B?Z2o0cjJoRHl5b0lWR2JwT3ZMRDhhMW5LUlFYZGI1djRVZ3pjelQzcHZ6NmxV?=
 =?utf-8?B?Y3hldnpnZEhHT0pld2xIcTJST0ZyTEZwRHZ3MHdaZHlGUzNHZkFwT1BRUFpm?=
 =?utf-8?B?ZzJMZitudUNUMXZWWVQxWU94a3NiT3BPeXFYRUFvSHl6c2hjTnAycnUwazc3?=
 =?utf-8?B?SXdSNCs0NXRDZU5oalozYXRVM0U3ZDdqN2c3N3hCNDNsN0RXd2JWYnNFUzdi?=
 =?utf-8?B?bEk2RDIxUUtuKzZuVWNzZGV0bjNPc0FZbUhkRWhzTDBxREE2TjFicCtSZ1Zj?=
 =?utf-8?B?a1VsVE1TMmtPTUlzT3ErbFJTVVZGbG5WNEwzUWdOcEV4NFZkTk9JUnp1dzlv?=
 =?utf-8?B?U3BMUXBQVndvcmp1aXUrTWJrUTBuMmpHMDUwd3JGang1bHhxUjZFOGhPclBW?=
 =?utf-8?B?L2dmT1FkMGpPZFF3TlgwSkhmWlE2aTI3ZEJqZjQwMVRadUkxeTRsUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508e5384-a417-4293-5df1-08de7826d29f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 06:42:07.2787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCcdZpP25hz+wzH4/J0ZLOtK5dgZklDEurFrvJKil5tNpBsPwd68i6Xyv+YkNYqhm/qRKsaiB1KzneJJNIA97A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11728
X-Mailman-Approved-At: Mon, 02 Mar 2026 14:22:38 +0100
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

Add support for i.MX952 15x15 lpddr4x board support.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/Makefile          |   2 +-
 arch/arm/mach-imx/imx9/Kconfig      |  12 +++
 board/nxp/imx952_evk/Kconfig        |  12 +++
 board/nxp/imx952_evk/MAINTAINERS    |   6 ++
 board/nxp/imx952_evk/Makefile       |  14 +++
 board/nxp/imx952_evk/imx952_evk.c   |  26 ++++++
 board/nxp/imx952_evk/imx952_evk.env | 137 ++++++++++++++++++++++++++++
 board/nxp/imx952_evk/spl.c          | 113 +++++++++++++++++++++++
 configs/imx952_evk_defconfig        | 175 ++++++++++++++++++++++++++++++++++++
 doc/board/nxp/imx952_evk.rst        | 112 +++++++++++++++++++++++
 doc/board/nxp/index.rst             |   1 +
 include/configs/imx952_evk.h        |  25 ++++++
 12 files changed, 634 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 0f6e737c0b9..bf6820de655 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -223,7 +223,7 @@ endif
 
 ifeq ($(CONFIG_ARCH_IMX9)$(CONFIG_ARCH_IMX8ULP), y)
 
-ifneq ($(and $(CONFIG_BINMAN),$(or $(CONFIG_IMX95),$(CONFIG_IMX94))),)
+ifneq ($(and $(CONFIG_BINMAN),$(or $(CONFIG_IMX95),$(CONFIG_IMX94),$(CONFIG_IMX952))),)
 SPL: spl/u-boot-spl.bin FORCE
 	$(call if_changed,mkimage)
 
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 716940930a6..6e0958c0842 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -162,6 +162,17 @@ config TARGET_TORADEX_SMARC_IMX95
 	bool "Support Toradex SMARC iMX95"
 	select IMX95
 
+config TARGET_IMX952_EVK
+	bool "imx952_evk"
+	select IMX_SM_CPU
+	select IMX_SM_LMM
+	select IMX952
+	select REGMAP
+	select SYSCON
+	imply BOOTSTD_BOOTCOMMAND
+	imply BOOTSTD_FULL
+	imply OF_UPSTREAM
+
 endchoice
 
 source "board/nxp/imx91_evk/Kconfig"
@@ -175,5 +186,6 @@ source "board/variscite/imx93_var_som/Kconfig"
 source "board/nxp/imx94_evk/Kconfig"
 source "board/nxp/imx95_evk/Kconfig"
 source "board/toradex/smarc-imx95/Kconfig"
+source "board/nxp/imx952_evk/Kconfig"
 
 endif
diff --git a/board/nxp/imx952_evk/Kconfig b/board/nxp/imx952_evk/Kconfig
new file mode 100644
index 00000000000..96f01323aca
--- /dev/null
+++ b/board/nxp/imx952_evk/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_IMX952_EVK
+
+config SYS_BOARD
+	default "imx952_evk"
+
+config SYS_VENDOR
+	default "nxp"
+
+config SYS_CONFIG_NAME
+	default "imx952_evk"
+
+endif
diff --git a/board/nxp/imx952_evk/MAINTAINERS b/board/nxp/imx952_evk/MAINTAINERS
new file mode 100644
index 00000000000..cc004f9467e
--- /dev/null
+++ b/board/nxp/imx952_evk/MAINTAINERS
@@ -0,0 +1,6 @@
+i.MX952 EVK BOARD
+M:	Alice Guo <alice.guo@nxp.com>
+S:	Maintained
+F:	board/nxp/imx952_evk/
+F:	include/configs/imx952_evk.h
+F:	configs/imx952_evk_defconfig
diff --git a/board/nxp/imx952_evk/Makefile b/board/nxp/imx952_evk/Makefile
new file mode 100644
index 00000000000..1581721dc78
--- /dev/null
+++ b/board/nxp/imx952_evk/Makefile
@@ -0,0 +1,14 @@
+#
+# Copyright 2025-2026 NXP
+#
+# SPDX-License-Identifier:      GPL-2.0+
+#
+
+# Add include path for NXP device tree header files from Linux.
+ccflags-y += -I$(srctree)/dts/upstream/src/arm64/freescale/
+
+obj-y += imx952_evk.o
+
+ifdef CONFIG_SPL_BUILD
+obj-y += spl.o
+endif
diff --git a/board/nxp/imx952_evk/imx952_evk.c b/board/nxp/imx952_evk/imx952_evk.c
new file mode 100644
index 00000000000..2a61817939e
--- /dev/null
+++ b/board/nxp/imx952_evk/imx952_evk.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025-2026 NXP
+ */
+
+#include <env.h>
+#include <init.h>
+#include <asm/arch/sys_proto.h>
+
+int board_init(void)
+{
+	return 0;
+}
+
+int board_late_init(void)
+{
+	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
+		board_late_mmc_env_init();
+
+	env_set("sec_boot", "no");
+#ifdef CONFIG_AHAB_BOOT
+	env_set("sec_boot", "yes");
+#endif
+
+	return 0;
+}
diff --git a/board/nxp/imx952_evk/imx952_evk.env b/board/nxp/imx952_evk/imx952_evk.env
new file mode 100644
index 00000000000..6ecaf9724c1
--- /dev/null
+++ b/board/nxp/imx952_evk/imx952_evk.env
@@ -0,0 +1,137 @@
+#ifdef CONFIG_ANDROID_SUPPORT
+splashpos=m,m
+splashimage=0x9FFF0000
+emmc_dev=0
+sd_dev=1
+#else
+
+#ifdef CONFIG_AHAB_BOOT
+sec_boot=yes
+#else
+sec_boot=no
+#endif
+
+jh_root_dtb=imx952-evk-root.dtb
+jh_mmcboot=setenv fdtfile ${jh_root_dtb};
+	setenv jh_clk kvm.enable_virt_at_load=false cpuidle.off=1 clk_ignore_unused kvm-arm.mode=nvhe;
+	setenv jh_root_mem 0x58000000@0x90000000,0x300000000@0x180000000;
+	if run loadimage; then
+		run mmcboot;
+	else run jh_netboot; fi;
+jh_netboot=setenv fdtfile ${jh_root_dtb};
+	setenv jh_root_mem 0x58000000@0x90000000,0x300000000@0x180000000;
+	setenv jh_clk kvm.enable_virt_at_load=false cpuidle.off=1 clk_ignore_unused kvm-arm.mode=nvhe; run netboot;
+
+domu-android-auto=no
+xenhyper_bootargs=console=dtuart dom0_mem=4096M dom0_max_vcpus=2 pci-passthrough=on
+xenlinux_bootargs=
+xenlinux_console=hvc0 earlycon=xen
+xenlinux_addr=0x9c000000
+dom0fdt_file=CONFIG_DEFAULT_FDT_FILE
+xenboot_common=${get_cmd} ${loadaddr} xen;
+	${get_cmd} ${fdt_addr} ${dom0fdt_file};
+	${get_cmd} ${xenlinux_addr} ${image};
+	fdt addr ${fdt_addr};
+	fdt resize 256;
+	fdt mknode /chosen module@0;
+	fdt set /chosen/module@0 reg <0x00000000 ${xenlinux_addr} 0x00000000 0x${filesize}>;
+	fdt set /chosen/module@0 bootargs "${bootargs} ${xenlinux_bootargs}";
+	fdt set /soc/bus@49000000/iommu@490d0000 status disabled;
+	fdt set /chosen/module@0 compatible "xen,linux-zimage" "xen,multiboot-module";
+	setenv bootargs ${xenhyper_bootargs};
+	booti ${loadaddr} - ${fdt_addr};
+xennetboot=setenv get_cmd dhcp;setenv console ${xenlinux_console};setenv jh_clk kvm.enable_virt_at_load=false clk_ignore_unused;run netargs;run xenboot_common;
+xenmmcboot=setenv get_cmd "fatload mmc ${mmcdev}:${mmcpart}";setenv console ${xenlinux_console};setenv jh_clk kvm.enable_virt_at_load=false clk_ignore_unused;run mmcargs;run xenboot_common;
+
+sr_ir_v2_cmd=cp.b ${fdtcontroladdr} ${fdt_addr_r} 0x10000; fdt addr ${fdt_addr_r};
+	fdt set /soc/bus@44000000/mailbox@445b0000/sram@445b1000/scmi-sram-section@0 reg <0x00000000 0x00000080>;
+	fdt rm /soc/mailbox@47530000;
+	fdt rm /soc/usb@4c010010;
+
+initrd_addr=0x93800000
+emmc_dev=0
+sd_dev=1
+scriptaddr=0x93500000
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+image=Image
+splashimage=0xA0000000
+console=ttyLP0,115200 earlycon
+fdt_addr_r=0x93000000
+fdt_addr=0x93000000
+cntr_addr=0xA8000000
+cntr_file=os_cntr_signed.bin
+boot_fit=no
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+bootm_size=0x10000000
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcpart=1
+mmcroot=/dev/mmcblk1p2 rootwait rw
+mmcautodetect=yes
+mmcargs=setenv bootargs ${jh_clk} ${mcore_args} console=${console} root=${mmcroot}
+prepare_mcore=setenv mcore_args pd_ignore_unused;
+loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
+bootscript=echo Running bootscript from mmc ...; source
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
+auth_os=booti ${cntr_addr}
+boot_os=booti ${loadaddr} - ${fdt_addr_r};
+mmcboot=echo Booting from mmc ...;
+		run mmcargs;
+		if test ${sec_boot} = yes; then
+			run auth_os;
+		else
+			if test ${boot_fit} = yes || test ${boot_fit} = try; then
+				bootm ${loadaddr};
+			else
+				if run loadfdt; then
+					run boot_os;
+				else
+					echo WARN: Cannot load the DT;
+				fi;
+			fi;
+		fi;
+netargs=setenv bootargs ${jh_clk} ${mcore_args} console=${console} root=/dev/nfs
+		ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+		run netargs;
+		if test ${ip_dyn} = yes; then
+			setenv get_cmd dhcp;
+		else
+			setenv get_cmd tftp;
+		fi;
+		if test ${sec_boot} = yes; then
+			${get_cmd} ${cntr_addr} ${cntr_file};
+			run auth_os;
+		else
+			${get_cmd} ${loadaddr} ${image};
+			if test ${boot_fit} = yes || test ${boot_fit} = try; then
+				bootm ${loadaddr};
+			else
+				if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+					run boot_os;
+				else
+					echo WARN: Cannot load the DT;
+				fi;
+			fi;
+		fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+			mmc dev ${mmcdev}; if mmc rescan; then
+			if run loadbootscript; then
+				run bootscript;
+			else
+				if test ${sec_boot} = yes; then
+					if run loadcntr; then
+						run mmcboot;
+					else run netboot;
+					fi;
+				else
+					if run loadimage; then
+						run mmcboot;
+					else run netboot;
+					fi;
+				fi;
+			fi;
+		fi;
+
+#endif
diff --git a/board/nxp/imx952_evk/spl.c b/board/nxp/imx952_evk/spl.c
new file mode 100644
index 00000000000..de9256dc267
--- /dev/null
+++ b/board/nxp/imx952_evk/spl.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025-2026 NXP
+ */
+
+#include <asm/arch/mu.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/gpio.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/ele_api.h>
+#include <asm/sections.h>
+#include <hang.h>
+#include <init.h>
+#include <linux/delay.h>
+#include <spl.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int spl_board_boot_device(enum boot_device boot_dev_spl)
+{
+	switch (boot_dev_spl) {
+	case SD1_BOOT:
+	case MMC1_BOOT:
+		return BOOT_DEVICE_MMC1;
+	case SD2_BOOT:
+	case MMC2_BOOT:
+		return BOOT_DEVICE_MMC2;
+	case USB_BOOT:
+	case USB2_BOOT:
+		return BOOT_DEVICE_BOARD;
+	case QSPI_BOOT:
+		return BOOT_DEVICE_SPI;
+	default:
+		return BOOT_DEVICE_NONE;
+	}
+}
+
+void spl_board_init(void)
+{
+	int ret;
+
+	puts("Normal Boot\n");
+
+	ret = ele_start_rng();
+	if (ret)
+		printf("Fail to start RNG: %d\n", ret);
+}
+
+static void xspi_nor_reset(void)
+{
+	int ret;
+	struct gpio_desc desc;
+
+	ret = dm_gpio_lookup_name("GPIO5_11", &desc);
+	if (ret) {
+		printf("%s lookup GPIO5_11 failed ret = %d\n", __func__, ret);
+		return;
+	}
+
+	ret = dm_gpio_request(&desc, "XSPI_RST_B");
+	if (ret) {
+		printf("%s request XSPI_RST_B failed ret = %d\n", __func__, ret);
+		return;
+	}
+
+	/* assert the XSPI_RST_B */
+	dm_gpio_set_dir_flags(&desc, GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE | GPIOD_ACTIVE_LOW);
+	udelay(200); /* 50 ns at least, so use 200ns */
+	dm_gpio_set_value(&desc, 0); /* deassert the XSPI_RST_B */
+}
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+#ifdef CONFIG_SPL_RECOVER_DATA_SECTION
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		spl_save_restore_data();
+#endif
+
+	timer_init();
+
+	/* Need dm_init() to run before any SCMI calls can be made. */
+	spl_early_init();
+
+	/* Need enable SCMI drivers and ELE driver before enabling console */
+	ret = imx9_probe_mu();
+	if (ret)
+		hang(); /* if MU not probed, nothing can output, just hang here */
+
+	arch_cpu_init();
+
+	preloader_console_init();
+
+	debug("SOC: 0x%x\n", gd->arch.soc_rev);
+	debug("LC: 0x%x\n", gd->arch.lifecycle);
+
+	get_reset_reason(true, false);
+
+	xspi_nor_reset();
+
+	board_init_r(NULL, 0);
+}
+
+#ifdef CONFIG_ANDROID_SUPPORT
+int board_get_emmc_id(void)
+{
+	return 0;
+}
+#endif
diff --git a/configs/imx952_evk_defconfig b/configs/imx952_evk_defconfig
new file mode 100644
index 00000000000..a700aea67a1
--- /dev/null
+++ b/configs/imx952_evk_defconfig
@@ -0,0 +1,175 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_ENV_SOURCE_FILE="imx952_evk"
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_SF_DEFAULT_SPEED=200000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx952-evk"
+CONFIG_TARGET_IMX952_EVK=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x90400000
+CONFIG_SPL_OF_LIBFDT_ASSUME_MASK=0x0
+CONFIG_SPL=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_PCI=y
+CONFIG_OF_BOARD_FIXUP=y
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="freescale/imx952-evk.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x30000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_THERMAL=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_OPTEE_RPMB=y
+CONFIG_CMD_OPTEE=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+# CONFIG_BOOTDEV_ETH is not set
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_SCMI=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+# CONFIG_SCMI_AGENT_SMCCC is not set
+# CONFIG_SCMI_AGENT_OPTEE is not set
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_ADP5585_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_IMX_MU_MBOX=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_AQUANTIA=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_MII=y
+CONFIG_FSL_ENETC=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PCIE_DW_IMX=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_SPL_SYSRESET=y
+CONFIG_SYSRESET_CMD_POWEROFF=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
+CONFIG_DM_THERMAL=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_ETHER_RTL8152=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
+CONFIG_SDP_LOADADDR=0x90400000
+CONFIG_SPL_USB_SDP_SUPPORT=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
diff --git a/doc/board/nxp/imx952_evk.rst b/doc/board/nxp/imx952_evk.rst
new file mode 100644
index 00000000000..f5f4d8d4b0c
--- /dev/null
+++ b/doc/board/nxp/imx952_evk.rst
@@ -0,0 +1,112 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+imx952_evk
+==========
+
+U-Boot for the NXP i.MX952 15x15 LPDDR4X EVK board
+
+Quick Start
+-----------
+
+- Get ahab-container.img
+- Get DDR PHY Firmware Images
+- Get and Build OEI Images
+- Get and Build System Manager Image
+- Get and Build the ARM Trusted Firmware
+- Build the Bootloader Image
+- Boot
+
+Get ahab-container.img
+----------------------
+
+Note: srctree is U-Boot source directory
+
+.. code-block:: bash
+
+   $ wget https://nl2-nxrm.sw.nxp.com/repository/IMX_Yocto_Internal_Mirror_Recent/firmware-ele-imx-2.0.5-50c4793.bin
+   $ sh firmware-ele-imx-2.0.5-50c4793.bin --auto-accept
+   $ cp firmware-ele-imx-2.0.5-50c4793/mx952a0-ahab-container.img $(srctree)
+
+Get DDR PHY Firmware Images
+---------------------------
+
+Note: srctree is U-Boot source directory
+
+.. code-block:: bash
+
+   $ wget https://nl2-nxrm.sw.nxp.com/repository/IMX_Yocto_Internal_Mirror_Recent/firmware-imx-8.32-c0491e4.bin
+   $ sh firmware-imx-8.32-c0491e4.bin --auto-accept
+   $ cp firmware-imx-8.32-c0491e4/firmware/ddr/synopsys/lpddr4x*v202409.bin $(srctree)
+
+Get and Build OEI Images
+------------------------
+
+Note: srctree is U-Boot source directory
+Get OEI from: https://github.com/nxp-imx/imx-oei
+branch: lf-6.18.2-imx952-er1
+
+.. code-block:: bash
+
+   $ sudo apt -y install make gcc g++-multilib srecord
+   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
+   $ export TOOLS=$PWD
+   $ git clone https://github.com/nxp-imx/imx-oei/ -b lf-6.18.2-imx952-er1
+   $ cd imx-oei
+   $ make board=mx952lp4x-15 oei=ddr DEBUG=1 all
+   $ cp build/mx952lp4x-15/ddr/oei-m33-ddr.bin $(srctree)
+
+Get and Build System Manager Image
+----------------------------------
+
+Note: srctree is U-Boot source directory
+Get System Manager from: https://github.com/nxp-imx/imx-sm
+branch: lf-6.18.2-imx952-er1
+
+.. code-block:: bash
+
+   $ sudo apt -y install make gcc g++-multilib srecord
+   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
+   $ export TOOLS=$PWD
+   $ git clone https://github.com/nxp-imx/imx-sm/ -b lf-6.18.2-imx952-er1
+   $ cd imx-sm
+   $ make config=mx952evk all
+   $ cp build/mx952evk/m33_image.bin $(srctree)
+
+Get and Build the ARM Trusted Firmware
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get ATF from: https://github.com/nxp-imx/imx-atf/
+branch: lf-6.18.2-imx952-er1
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ unset LDFLAGS
+   $ unset AS
+   $ git clone https://github.com/nxp-imx/imx-atf/ -b lf-6.18.2-imx952-er1
+   $ cd imx-atf
+   $ make PLAT=imx952 bl31
+   $ cp build/imx952/release/bl31.bin $(srctree)
+
+Build the Bootloader Image
+--------------------------
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx952_evk_defconfig
+   $ make
+
+Copy flash.bin to the MicroSD card:
+
+.. code-block:: bash
+
+   $ sudo dd if=flash.bin of=/dev/sd[x] bs=1k seek=32 conv=fsync
+
+Boot
+----
+
+Set i.MX952 boot device to MicroSD card
diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index 01d3468a47d..8cd24aecf33 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -19,6 +19,7 @@ NXP Semiconductors
    imx93_frdm
    imx943_evk
    imx95_evk
+   imx952_evk
    imxrt1020-evk
    imxrt1050-evk
    imxrt1170-evk
diff --git a/include/configs/imx952_evk.h b/include/configs/imx952_evk.h
new file mode 100644
index 00000000000..4ff56eb8adf
--- /dev/null
+++ b/include/configs/imx952_evk.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025-2026 NXP
+ */
+
+#ifndef __IMX952_EVK_H
+#define __IMX952_EVK_H
+
+#include <linux/sizes.h>
+#include <linux/stringify.h>
+#include <asm/arch/imx-regs.h>
+
+#define CFG_SYS_INIT_RAM_ADDR		0x90000000
+#define CFG_SYS_INIT_RAM_SIZE		0x200000
+
+#define CFG_SYS_SDRAM_BASE		0x90000000
+#define PHYS_SDRAM			0x90000000
+
+#define PHYS_SDRAM_SIZE			0x70000000 /* 2GB - 256MB DDR */
+#define PHYS_SDRAM_2_SIZE		0x380000000 /* 14GB */
+
+#define CFG_SYS_SECURE_SDRAM_BASE	0x8A000000 /* Secure DDR region for A55, SPL could use first 2MB */
+#define CFG_SYS_SECURE_SDRAM_SIZE	0x06000000
+
+#endif

-- 
2.43.0

