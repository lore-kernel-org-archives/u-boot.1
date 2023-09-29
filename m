Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A82E743FE
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 09:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB46C86E8D;
	Fri, 29 Sep 2023 11:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="mK/78uGs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 408FB86E6B; Fri, 29 Sep 2023 11:07:15 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::717])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB5386EAB
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 11:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Manuel.Traut@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNZy9YhkGK2+JkocMki/ID1viNxbP1/LJWXj2BB7mifshPam/TRmJ9GV5vGyGGv7vvtCb1BAskfyPqVOenDaSAlBo+vVdMQL1XQw2RLY4fT6GkrtVhz7D/HgikXibJbNu1J0LgnCTizIPsA03T0g0UNZzImseE5YfHXeMe4D7OtUYCkfwV7APt+TJkkAkW0egJZDhwbVrEtXAdhEZQaXsCRPTrrJwgIPOwodWhk5W5fQ1k0euXZBpKK8sIpr9B42c/BRyqlhS0/nPbiBatf0QxvNpF7q6qlJ1YgFQr3iw/aLPA4D1KbIdbO663Rsiaz6OcOYEe4i+wdCNUcI223iAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ma51+WmxgL7i98RNyjFRhHRvBILinlf9WHsHlQ981cI=;
 b=bKnysaCG4Db+geweRixcMwt35thFtg91RCxahmdj3Q4bPe6PK0PF8BT66h32govsvlpSJ18g4b9mWMXNAlb+MDZeAX4aSqXvghZlBFZXKadsnzjMebCQaiNKlbHwwfSrE+r47dd/sRj7ZUcS0zLWa1PFvtt5UWQYmz2YvoEz9Zu57KUjwgdkkgpTQl+83vCQHKdPJLG9DQepwgSvMuHfjNAZ6CjHE8AVmiqcPoqwGHwXDdiqMdNMzdxZEkBZeNuAFt8gOh2VYq0qjxUv7ANEd60Y512JkfpuKiZbOE8++qIODPttmEmv9NghXHR+1w54O/aXoNrDEeE6vmF/PrrCkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ma51+WmxgL7i98RNyjFRhHRvBILinlf9WHsHlQ981cI=;
 b=mK/78uGsH7m4CCmMdZpRcd39zh3bV5grA/Bh5H72i6PQP7mc4zyoMJZib3YJqEFrsKbWuUpnC/Oy43J24jbgJk7k3AhCe4Y02F5yOBQ/c1aXoXYlbiBfvHFVgvOD5tsff0YmzJJrkrAyZGvLmLLF0JzL0oM7zorYz30Iu6vVynQO1gUKCqN91dgTOWqeIy4svhLxvlsjEiIyZNy06r449PNxRBVbPIM1imW3ezEpHrTz64c7JSEbxVriuGmQRc6Dv/IcEGUkSmizmxvc41v//kLnp+jqr3xZHSB4GiTxMt9j6naong5I80ZT46a2qWuMZsdTbmMsXUDfMtuazsx6ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by DU0PR03MB8163.eurprd03.prod.outlook.com (2603:10a6:10:352::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Fri, 29 Sep
 2023 09:07:06 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::5663:2a6a:8708:b19e]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::5663:2a6a:8708:b19e%4]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 09:07:06 +0000
Date: Fri, 29 Sep 2023 11:07:03 +0200
From: Manuel Traut <manuel.traut@mt.com>
To: u-boot@lists.denx.de
Cc: Sebastian Andrzej Siewior <bigeasyat@linutronix.de>,
 Frieder Schrempf <frieder.schrempfatkontron.de@mt.com>, sbabic@denx.de
Subject: [PATCH v5] imx: imx8mm: Add support for Mettler-Toledo snowflake
 board.
Message-ID: <ZRaTt4NvbJ7F5yNe@mt.com>
References: <20230629105931.-r3v-pmW@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230629105931.-r3v-pmW@linutronix.de>
X-ClientProxiedBy: FR2P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::8) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|DU0PR03MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: 1667e501-f7dd-4d65-488c-08dbc0cb73f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uMUiasF9zpff8qjO0bDyXXs6y3um/t0RVLz/qTF5/Ln7Z1SiOdK8AJu2BNlOc7yYDLJrBzW2lbHz1zGgllULt7gRonbwHmlwyJfnxl1K5gU/Pm2Sw6ZeEMlQ4pcrWo5ZtcT2GZw9Mu8k/o+6BTA9bef22PLL5q91TWiHFtf3fTSoIboWevBsfQuGn+Hd/esQYBkX1YrjYBj+ifatkbz7f9yZK6wCArj99FGN9cBFLl4ZRhkfXdlaAyi1HJqOod63vqosXIJUk9Rt04PyC73bD5PMLF3M6a7VnxlWab6o32+dM9eWkV2WQoXyw8Zt3dstF6XTwG0ib+ukcpDVghHT5rcsCZmOCDnZGHWBQCjDyGCxxp16POG4XhoxUoIuTeody5HrZWy0hsKbxvwJuBCcD0IlCHcup6y2EMSt0tlsdh1m7xC36b/HKnU7HUgcCQ0UIDdiqec0MpJdQx47b6KiQNl2znkfJ04ekQ+/g4FRmL7dbYZCPzy14qK+W6IZ/gikoM96Ynngfrs5Dlx+UOspEqS8hvRHgUHrLFca3jZEk663iS6I+LDfCDo+m2zZFrxiUZ9hH3MFFhDWddVo46v1lfZ5KfDmf2UXnBPb8PKqhQGGxE1yHk8pgPXm/AkkJ//TbW2ZwlnoP/vR4U/nyPRjFdHveNb+SEBwtgpCwpuQrgVuOvFFzn2KtBIJfBgkz+40YWyBWORrDL8DO36yRkgx6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR03MB7621.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(136003)(376002)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(84970400001)(2906002)(8676002)(316002)(36756003)(8936002)(41300700001)(4326008)(6512007)(44832011)(5660300002)(54906003)(86362001)(66556008)(2616005)(478600001)(38100700002)(6666004)(6486002)(30864003)(6506007)(52116002)(38350700002)(66476007)(26005)(66946007)(6916009)(83380400001)(32563001)(579004)(559001)(473944003)(414714003)(139555002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlR5YS9ZZ1VOTG1hSE9ic0EzOUwzT2FpejAxWVNxeEMybXFFcC85WHZydGto?=
 =?utf-8?B?L1VmTDJBYWtjT3hnRkNSdXo0RXpJamJSMEVLMzFMelZjbXBYNEtZY2ZLL0Ez?=
 =?utf-8?B?Q0JFSHNLa2NNdU9WdWIzM2RUYThScWlRc05QVDdwOFBHMGRXdE1NM2JmYlhD?=
 =?utf-8?B?cVJZRTZFaGMzR2tGVmFhaEZ1Z295eUZEMWRhMEJpU2hkUm9OT3E0R2FxaURE?=
 =?utf-8?B?SzhSNmZobktteHB4cENuTDlTdTBqaVNtTWIxTGs2VW9vakxGdkgzcmNRc05u?=
 =?utf-8?B?MVVSbFp6QjBNY3EzZURobDR6bGlGSEtZSDFHUFNLQUpGcTk5bFl1eSt2Y0lC?=
 =?utf-8?B?TXZzTlpsTTg1SWxzbXFzeDFlQm5hUVBycVorZi9MZ0xHME9DWE5zb0NuTWFq?=
 =?utf-8?B?T3Z2bVJqT0dzMkQ0Q1FtK2dlTnQzMkFUWHl3VmtXdEMycVNZVGZ6QlZtZUFF?=
 =?utf-8?B?MTFzKzVaZGNyZmY0K2RoL1kyYTJzV3VlYXhEWUJQSXRaNzg4cHg3U01SdFJG?=
 =?utf-8?B?TXhUN2NIQ0RISGx3TmMyUnJDVnRuVERDOE1ZWWZkSkFJUk1zeFRDRm9nc3Ay?=
 =?utf-8?B?R0hQY01oQ2NhMExWakhtY2VaN3p1aXk1SVFWbUtTd2ZKcUI5b3lHWHJpMVZx?=
 =?utf-8?B?Mkh6WjBYS2FnUDUrcjZxUFBQSHZqVURGanB1YUJmakhudktzcWRBTE12MTNW?=
 =?utf-8?B?bU5qS0xIVUs2aS9vZEhzaW9FVlFIY3lYTjBKQ1RZOHd2V0dub1d3MzRrNzlN?=
 =?utf-8?B?UTkvSnVlVDFzdFVIQVJUSUY2cFFnaGlCN29wK2hNdS9TVjk0TkhXOHB5TjB0?=
 =?utf-8?B?MGVBOTdSL2F1dmRXSkhROVdJWHhYL2E3M2dwWWxjejE3cnZPNVRJU3ZwMysz?=
 =?utf-8?B?R1dpbVFsRVZ5QnlSZ1NqeE9xUmNTL0tKWXQvdlgweUtKZ2tkaGRPOWh6QitL?=
 =?utf-8?B?QmFXZ0JIMi9FdFpQSnFQdVl0NXZxdmU4N3p5TGNkc3ZuR0xPYldyc0I3SzE4?=
 =?utf-8?B?NktoWGRhNkJYS2F5OXUySFk5S1JBVHBDR0JCbDNENVFkOE1PR3RkOTRlSUNQ?=
 =?utf-8?B?Q2J5dUl1MHkzc2JtT204VUhLZUl2OHFhcC9acVlMUC9za0R5NGUxeC9OKzhR?=
 =?utf-8?B?TUFFUHA0N2cvVmx0WXpFbU1JK0MzT2dCZHdiMU8ydXU0UGdEYUprY3VIUGc5?=
 =?utf-8?B?VTBnZldGaFd0czZjRTdVTDlHZ2FyZW9NWjFtRmI0WitNdStHQjhjTXoyeTIy?=
 =?utf-8?B?WEhHUzNXM2tmcExobjEwR0RYWm1uZTdTOUJjWklEbFc2VnhGSFZ2UzRCeTVj?=
 =?utf-8?B?cU4zY1p1ZjhaRE5Ma1RYM3MzNHFwdmVXQ2dCWEl6eXJkUjVxR1drajgwcjFp?=
 =?utf-8?B?OWdPODlyTThzM1VUajAzOVVHUTZrUTJHSm5HV24zcmdQczg4YTk3UDk4VWpv?=
 =?utf-8?B?WTJyTlJmbVJLTHNIaHQ3d3ZzakdMS1haendZZXJjdStscFpZWDRCM2g1ZEhM?=
 =?utf-8?B?ZVNsSmRIVnhmYnJ4NEhWbEh6aHNGaEk2end0VnFxZjV4WXpKaXhxMUlwSVM5?=
 =?utf-8?B?czRrQUtBajZKamJCV1NLZWZ4QjU0ZWN1MGZ3Z2lHM0V0VWhiNFg5OHdyOWdP?=
 =?utf-8?B?Z3o5R2Q5eUFwQjR5QzBCRjh1MUMxMmdhQzFoQmcrVG1KWWhVWFRWVm9xdDVF?=
 =?utf-8?B?VG1LS2E1MmtTOS9xTzRtbnkybGVBOWRPSUs2MDVFU2tqM21RRFRZMTA3b05v?=
 =?utf-8?B?N2kvSXczQnNnSXlrU3VaSGhoZjk4cG1rc3lJZWtPNWZBa3RpN09JRkh1enFp?=
 =?utf-8?B?WmFFWFYvM0VoSzUyTDk4VG54c2R1dHJvaDBNdi9GcFVrMTRDbldxQWtydHJB?=
 =?utf-8?B?RFpSaUxOWG5pZFh4WlZUdE9IdlhVdUFtaEFmT1JnbGovOTRvZTlYSUNnaldt?=
 =?utf-8?B?OC9RRHU4UXhNSGcwRkg0UEJuN2J1YndnazdEK0ZnZnNVT0F4eVMyQU1UNlE3?=
 =?utf-8?B?eXVWV3orN1NLbndKdlNMVUwzQ0wvVUlPU2o0NTRwbnUxd2VYdGV4VVNqSG0r?=
 =?utf-8?B?eExPSGFtclBtU2d1UCtjSlhjcnFJbUhlRWdNZ3dVQytab2FTbUxZdklXVDZO?=
 =?utf-8?Q?qdpMozBxK0OuSBjRPyR3zZwCK?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1667e501-f7dd-4d65-488c-08dbc0cb73f5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 09:07:06.1523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnTvfQ0Q/TZWrkjC5b7NXOL+SDW1x5WHoF+7CBkXQc6jTC8Cra2PtS+s5JzTDa3YQDTKSK0r1O0h2VEBxEyR5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8163
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

This patch probably got somehow lost. Rebased against latest master.

It is originally based on:

From patchwork Fri Mar 31 14:18:41 2023
X-Patchwork-Submitter: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Patchwork-Id: 1763795
X-Patchwork-Delegate: sbabic@denx.de
Return-Path: <u-boot-bounces@lists.denx.de>
X-Original-To: incoming@patchwork.ozlabs.org
Delivered-To: patchwork-incoming@legolas.ozlabs.org
Authentication-Results: legolas.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=lists.denx.de
 (client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=u-boot-bounces@lists.denx.de; receiver=<UNKNOWN>)
Authentication-Results: legolas.ozlabs.org;

The board is similar to "Kontron SL i.MX 8M Mini" SoM. There are two variants.
Snowflake_v2 has an external SDCard Interface. LEIG is the same, but without
display and without external SDCard Interface. Both variants support
only 1GiB of main memory.

[ bigeasy: porting and a bit of cleanup ]

Signed-off-by: Manuel Traut <manuel.traut@mt.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

v4?v5:
 - Rebased on top of todays master
v3?v4:
 - Added Frieder's tag
 - Rebased on top of v2023.07-rc5.
v2?v3:
 Addressing Frieder's comments:
 - Add "kontron,imx8mm-sl" to the compatible string.
 - Remove pca9450 node and pinctrl_i2c1. The included
   imx8mm-kontron-sl.dtsi already provides this.
 - Merge the overwritten values in dram_timing.ddrc_cfg/fsp_msg directly
   into lpddr4_timing.c.
 - Simplify the init in spl_dram_init() and panic() if the init failed.
 - Replace a reference to SMARC with the current product name of the
   SoM.

v1?v2:
 - Clarify details about the board and whether or not there is an
   external SD-card interface.

---
 arch/arm/dts/Makefile                           |    1 +
 arch/arm/dts/imx8mm-mt-snowflake-v2-u-boot.dtsi |  139 ++
 arch/arm/dts/imx8mm-mt-snowflake-v2.dts         |  126 ++
 arch/arm/mach-imx/imx8m/Kconfig                 |    8 +
 board/mt/snowflake_v2/Kconfig                   |   18 +
 board/mt/snowflake_v2/MAINTAINERS               |    7 +
 board/mt/snowflake_v2/Makefile                  |    9 +
 board/mt/snowflake_v2/imximage.cfg              |    8 +
 board/mt/snowflake_v2/lpddr4_timing.c           | 1844 +++++++++++++++++++++++
 board/mt/snowflake_v2/snowflake_v2.c            |   32 +
 board/mt/snowflake_v2/spl.c                     |  146 ++
 configs/snowflake_leig_defconfig                |  141 ++
 configs/snowflake_sdcard_defconfig              |  140 ++
 include/configs/snowflake_v2.h                  |  113 ++
 14 files changed, 2732 insertions(+)
 create mode 100644 arch/arm/dts/imx8mm-mt-snowflake-v2-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx8mm-mt-snowflake-v2.dts
 create mode 100644 board/mt/snowflake_v2/Kconfig
 create mode 100644 board/mt/snowflake_v2/MAINTAINERS
 create mode 100644 board/mt/snowflake_v2/Makefile
 create mode 100644 board/mt/snowflake_v2/imximage.cfg
 create mode 100644 board/mt/snowflake_v2/lpddr4_timing.c
 create mode 100644 board/mt/snowflake_v2/snowflake_v2.c
 create mode 100644 board/mt/snowflake_v2/spl.c
 create mode 100644 configs/snowflake_leig_defconfig
 create mode 100644 configs/snowflake_sdcard_defconfig
 create mode 100644 include/configs/snowflake_v2.h

Index: u-boot-deb-manut/arch/arm/dts/Makefile
===================================================================
--- u-boot-deb-manut.orig/arch/arm/dts/Makefile
+++ u-boot-deb-manut/arch/arm/dts/Makefile
@@ -1015,6 +1015,7 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mm-icore-mx8mm-edimm2.2.dtb \
 	imx8mm-kontron-bl.dtb \
 	imx8mm-kontron-bl-osm-s.dtb \
+	imx8mm-mt-snowflake-v2.dtb \
 	imx8mm-mx8menlo.dtb \
 	imx8mm-phg.dtb \
 	imx8mm-venice.dtb \
Index: u-boot-deb-manut/arch/arm/dts/imx8mm-mt-snowflake-v2-u-boot.dtsi
===================================================================
--- /dev/null
+++ u-boot-deb-manut/arch/arm/dts/imx8mm-mt-snowflake-v2-u-boot.dtsi
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Mettler-Toledo GmbH
+ */
+
+#include "imx8mm-u-boot.dtsi"
+
+/ {
+    firmware {
+        optee {
+            compatible = "linaro,optee-tz";
+            method = "smc";
+        };
+    };
+
+    wdt-reboot {
+        compatible = "wdt-reboot";
+        u-boot,dm-spl;
+        wdt = <&wdog1>;
+    };
+
+    usbg1: usbg1 {
+        u-boot,dm-spl;
+        compatible = "fsl,imx27-usb-gadget";
+        dr_mode = "peripheral";
+        chipidea,usb = <&usbotg1>;
+        status = "okay";
+    };
+};
+
+&{/aliases} {
+    usbgadget0 = &usbg1;
+};
+
+&i2c1 {
+	status = "okay";
+	u-boot,dm-spl;
+	u-boot,dm-pre-reloc;
+};
+
+&i2c2 {
+	status = "okay";
+	u-boot,dm-spl;
+	u-boot,dm-pre-reloc;
+};
+
+&pinctrl_ecspi1 {
+	u-boot,dm-spl;
+};
+
+&pinctrl_i2c1 {
+	u-boot,dm-spl;
+};
+
+&pinctrl_pmic {
+	u-boot,dm-spl;
+};
+
+&pinctrl_uart3 {
+	u-boot,dm-spl;
+	u-boot,dm-pre-reloc;
+};
+
+&pinctrl_usdhc1 {
+	u-boot,dm-spl;
+};
+
+&pinctrl_usdhc1_100mhz {
+	u-boot,dm-spl;
+};
+
+&pinctrl_usdhc1_200mhz {
+	u-boot,dm-spl;
+};
+
+&pca9450 {
+	u-boot,dm-spl;
+};
+
+&{/soc@0/bus@30800000/i2c@30a20000/pmic@25/regulators} {
+	u-boot,dm-spl;
+};
+
+&ecspi1 {
+	u-boot,dm-spl;
+};
+
+&gpio1 {
+	u-boot,dm-spl;
+};
+
+&gpio2 {
+	u-boot,dm-spl;
+};
+
+&gpio3 {
+	u-boot,dm-spl;
+};
+
+&gpio4 {
+	u-boot,dm-spl;
+};
+
+&gpio5 {
+	u-boot,dm-spl;
+};
+
+&uart3 {
+	u-boot,dm-spl;
+	u-boot,dm-pre-reloc;
+};
+
+&usdhc1 {
+	u-boot,dm-spl;
+};
+
+&usdhc2 {
+        u-boot,dm-spl;
+        /*
+         * Delete the reference to the IO voltage regulator in order to prevent
+         * wrong information being passed to the MMC driver by reading the current
+         * voltage of the PCA9450 LDO5.
+         */
+        /delete-property/ vqmmc-supply;
+        pinctrl-names = "default";
+        no-1-8-v;
+};
+
+&wdog1 {
+	u-boot,dm-spl;
+};
+
+&pinctrl_wdog {
+	u-boot,dm-spl;
+};
+
+&pinctrl_usdhc2 {
+        u-boot,dm-spl;
+};
Index: u-boot-deb-manut/arch/arm/dts/imx8mm-mt-snowflake-v2.dts
===================================================================
--- /dev/null
+++ u-boot-deb-manut/arch/arm/dts/imx8mm-mt-snowflake-v2.dts
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Mettler-Toledo GmbH
+ */
+
+/dts-v1/;
+
+#include "imx8mm-kontron-sl.dtsi"
+#include "imx8mm-u-boot.dtsi"
+
+/ {
+	model = "Mettler-Toledo i.MX 8M Mini Snowflake/LEIG";
+	compatible = "mt,imx8mm-snowflake-v2", "mt,imx8mm-leig", "kontron,imx8mm-sl", "fsl,imx8mm";
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+};
+
+&usbotg1 {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	disable-over-current;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+};
+
+&usdhc2 {
+        pinctrl-names = "default", "state_100mhz", "state_200mhz";
+        pinctrl-0 = <&pinctrl_usdhc2>;
+        pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+        pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+        vmmc-supply = <&reg_vdd_3v3>;
+        vqmmc-supply = <&reg_nvcc_sd>;
+        cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+        status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x19 /* \SOM_RTC_INT */
+			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x19 /* \SOM_USBC_INT */
+			MX8MM_IOMUXC_GPIO1_IO09_GPIO1_IO9		0x184 /* SOM_DIS_ID0 */
+			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10		0x184 /* SOM_DIS_ID1 */
+			MX8MM_IOMUXC_GPIO1_IO11_GPIO1_IO11		0x184 /* SOM_DIS_ID2 */
+			MX8MM_IOMUXC_SAI2_TXC_GPIO4_IO25		0x19 /* SOM_PCB_ID0 */
+			MX8MM_IOMUXC_SAI2_TXD0_GPIO4_IO26		0x19 /* SOM_PCB_ID1 */
+			MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19 /* SOM_PCBA_ID0 */
+			MX8MM_IOMUXC_SAI3_RXFS_GPIO4_IO28		0x19 /* SOM_PCBA_ID1 */
+			MX8MM_IOMUXC_SAI5_RXFS_GPIO3_IO19		0x19 /* \SOM_STATLED_RES */
+			MX8MM_IOMUXC_SAI5_RXC_GPIO3_IO20		0x19 /* \SOM_HUB_RES */
+			MX8MM_IOMUXC_SAI5_RXD0_GPIO3_IO21		0x19 /* \SOM_SUPPLY_EN */
+			MX8MM_IOMUXC_SAI5_RXD1_GPIO3_IO22		0x1c4 /* \SOM_COM_RES / version C */
+			MX8MM_IOMUXC_SAI5_RXD2_GPIO3_IO23		0x184 /* SOM_DBG_GPIO0 */
+			MX8MM_IOMUXC_SAI5_RXD3_GPIO3_IO24		0x184 /* SOM_DBG_GPIO1 */
+			MX8MM_IOMUXC_SAI5_MCLK_GPIO3_IO25		0x184 /* SOM_DBG_GPIO2 */
+			MX8MM_IOMUXC_SAI3_TXD_GPIO5_IO1			0x184 /* SOM_DBG_GPIO3 version C */
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_TXFS_SAI1_TX_SYNC	0xd6
+			MX8MM_IOMUXC_SAI1_TXC_SAI1_TX_BCLK	0xd6
+			MX8MM_IOMUXC_SAI1_TXD0_SAI1_TX_DATA0	0xd6
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL			0x400001c3
+			MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA			0x400001c3
+		>;
+	};
+
+        pinctrl_usdhc2: usdhc2grp {
+                fsl,pins = <
+                        MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK                 0x190
+                        MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD                 0x1d0
+                        MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0             0x1d0
+                        MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1             0x1d0
+                        MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2             0x1d0
+                        MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3             0x1d0
+                        MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12                0x019
+                        MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT          0x1d0
+                >;
+        };
+
+        pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+                fsl,pins = <
+                        MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK                 0x194
+                        MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD                 0x1d4
+                        MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0             0x1d4
+                        MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1             0x1d4
+                        MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2             0x1d4
+                        MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3             0x1d4
+                        MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12                0x019
+                        MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT          0x1d0
+                >;
+        };
+
+        pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+                fsl,pins = <
+                        MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK                 0x196
+                        MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD                 0x1d6
+                        MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0             0x1d6
+                        MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1             0x1d6
+                        MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2             0x1d6
+                        MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3             0x1d6
+                        MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12                0x019
+                        MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT          0x1d0
+                >;
+        };
+};
Index: u-boot-deb-manut/arch/arm/mach-imx/imx8m/Kconfig
===================================================================
--- u-boot-deb-manut.orig/arch/arm/mach-imx/imx8m/Kconfig
+++ u-boot-deb-manut/arch/arm/mach-imx/imx8m/Kconfig
@@ -170,6 +170,13 @@ config TARGET_IMX8MN_DDR4_EVK
 	select FSL_CAAM
 	select SPL_CRYPTO if SPL
 
+config TARGET_MT_SNOWFLAKE_V2
+	bool "MT Snowflake v2"
+	select BINMAN
+	select IMX8MM
+	select SUPPORT_SPL
+	select IMX8M_LPDDR4
+
 config TARGET_IMX8MN_VENICE
 	bool "Support Gateworks Venice iMX8M Nano module"
 	select BINMAN
@@ -380,8 +387,9 @@ source "board/google/imx8mq_phanbell/Kco
 source "board/kontron/pitx_imx8m/Kconfig"
 source "board/kontron/sl-mx8mm/Kconfig"
 source "board/menlo/mx8menlo/Kconfig"
-source "board/msc/sm2s_imx8mp/Kconfig"
 source "board/mntre/imx8mq_reform2/Kconfig"
+source "board/msc/sm2s_imx8mp/Kconfig"
+source "board/mt/snowflake_v2/Kconfig"
 source "board/phytec/phycore_imx8mm/Kconfig"
 source "board/phytec/phycore_imx8mp/Kconfig"
 source "board/purism/librem5/Kconfig"
Index: u-boot-deb-manut/board/mt/snowflake_v2/Kconfig
===================================================================
--- /dev/null
+++ u-boot-deb-manut/board/mt/snowflake_v2/Kconfig
@@ -0,0 +1,18 @@
+if TARGET_MT_SNOWFLAKE_V2
+
+config SYS_BOARD
+	string
+	default "snowflake_v2"
+
+config SYS_VENDOR
+	string
+	default "mt"
+
+config SYS_CONFIG_NAME
+	string
+	default "snowflake_v2"
+
+config IMX_CONFIG
+	default "board/mt/snowflake_v2/imximage.cfg"
+
+endif
Index: u-boot-deb-manut/board/mt/snowflake_v2/MAINTAINERS
===================================================================
--- /dev/null
+++ u-boot-deb-manut/board/mt/snowflake_v2/MAINTAINERS
@@ -0,0 +1,7 @@
+Mettler-Toledo Snowflake boards
+M:	Manuel Traut <manuel.traut@mt.com>
+S:	Maintained
+F:	arch/arm/dts/imx8mm-mt-snowflake*
+F:	board/mt/snowflake_v2
+F:	configs/snowflake_v2_emmc_defconfig
+F:	include/configs/snowflake_v2.h
Index: u-boot-deb-manut/board/mt/snowflake_v2/Makefile
===================================================================
--- /dev/null
+++ u-boot-deb-manut/board/mt/snowflake_v2/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 Mettler-Toledo GmbH
+
+obj-y := snowflake_v2.o
+
+ifdef CONFIG_SPL_BUILD
+obj-y += spl.o
+obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
+endif
Index: u-boot-deb-manut/board/mt/snowflake_v2/imximage.cfg
===================================================================
--- /dev/null
+++ u-boot-deb-manut/board/mt/snowflake_v2/imximage.cfg
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2021 NXP
+ */
+
+
+BOOT_FROM	sd
+LOADER		u-boot-spl-ddr.bin	0x7E1000
Index: u-boot-deb-manut/board/mt/snowflake_v2/lpddr4_timing.c
===================================================================
--- /dev/null
+++ u-boot-deb-manut/board/mt/snowflake_v2/lpddr4_timing.c
@@ -0,0 +1,1844 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 Kontron Electronics GmbH
+ */
+
+#include <linux/kernel.h>
+#include <common.h>
+#include <asm/arch/ddr.h>
+#include <asm/arch/lpddr4_define.h>
+
+struct dram_cfg_param ddr_ddrc_cfg[] = {
+	/** Initialize DDRC registers **/
+	{ 0x3d400304, 0x1 },
+	{ 0x3d400030, 0x1 },
+	{ 0x3d400000, 0xa1080020 },
+	{ 0x3d400020, 0x223 },
+	{ 0x3d400024, 0x3a980 },
+	{ 0x3d400064, 0x5b0087 },
+	{ 0x3d4000d0, 0xc00305ba },
+	{ 0x3d4000d4, 0x940000 },
+	{ 0x3d4000dc, 0xd4002d },
+	{ 0x3d4000e0, 0x310000 },
+	{ 0x3d4000e8, 0x66004d },
+	{ 0x3d4000ec, 0x16004d },
+	{ 0x3d400100, 0x191e1920 },
+	{ 0x3d400104, 0x60630 },
+	{ 0x3d40010c, 0xb0b000 },
+	{ 0x3d400110, 0xe04080e },
+	{ 0x3d400114, 0x2040c0c },
+	{ 0x3d400118, 0x1010007 },
+	{ 0x3d40011c, 0x401 },
+	{ 0x3d400130, 0x20600 },
+	{ 0x3d400134, 0xc100002 },
+	{ 0x3d400138, 0xd8 },
+	{ 0x3d400144, 0x96004b },
+	{ 0x3d400180, 0x2ee0017 },
+	{ 0x3d400184, 0x2605b8e },
+	{ 0x3d400188, 0x0 },
+	{ 0x3d400190, 0x497820a },
+	{ 0x3d400194, 0x80303 },
+	{ 0x3d4001b4, 0x170a },
+	{ 0x3d4001a0, 0xe0400018 },
+	{ 0x3d4001a4, 0xdf00e4 },
+	{ 0x3d4001a8, 0x80000000 },
+	{ 0x3d4001b0, 0x11 },
+	{ 0x3d4001c0, 0x1 },
+	{ 0x3d4001c4, 0x1 },
+	{ 0x3d4000f4, 0xc99 },
+	{ 0x3d400108, 0x70e1617 },
+	{ 0x3d400200, 0x1f },
+	{ 0x3d40020c, 0x0 },
+	{ 0x3d400210, 0x1f1f },
+	{ 0x3d400204, 0x80808 },
+	{ 0x3d400214, 0x7070707 },
+	{ 0x3d400218, 0x7070707 },
+	{ 0x3d400250, 0x29001701 },
+	{ 0x3d400254, 0x2c },
+	{ 0x3d40025c, 0x4000030 },
+	{ 0x3d400264, 0x900093e7 },
+	{ 0x3d40026c, 0x2005574 },
+	{ 0x3d400400, 0x111 },
+	{ 0x3d400408, 0x72ff },
+	{ 0x3d400494, 0x2100e07 },
+	{ 0x3d400498, 0x620096 },
+	{ 0x3d40049c, 0x1100e07 },
+	{ 0x3d4004a0, 0xc8012c },
+	{ 0x3d402020, 0x21 },
+	{ 0x3d402024, 0x7d00 },
+	{ 0x3d402050, 0x20d040 },
+	{ 0x3d402064, 0xc001c },
+	{ 0x3d4020dc, 0x840000 },
+	{ 0x3d4020e0, 0x310000 },
+	{ 0x3d4020e8, 0x66004d },
+	{ 0x3d4020ec, 0x16004d },
+	{ 0x3d402100, 0xa040305 },
+	{ 0x3d402104, 0x30407 },
+	{ 0x3d402108, 0x203060b },
+	{ 0x3d40210c, 0x505000 },
+	{ 0x3d402110, 0x2040202 },
+	{ 0x3d402114, 0x2030202 },
+	{ 0x3d402118, 0x1010004 },
+	{ 0x3d40211c, 0x301 },
+	{ 0x3d402130, 0x20300 },
+	{ 0x3d402134, 0xa100002 },
+	{ 0x3d402138, 0x1d },
+	{ 0x3d402144, 0x14000a },
+	{ 0x3d402180, 0x640004 },
+	{ 0x3d402190, 0x3818200 },
+	{ 0x3d402194, 0x80303 },
+	{ 0x3d4021b4, 0x100 },
+	{ 0x3d403020, 0x21 },
+	{ 0x3d403024, 0x1f40 },
+	{ 0x3d403050, 0x20d040 },
+	{ 0x3d403064, 0x30007 },
+	{ 0x3d4030dc, 0x840000 },
+	{ 0x3d4030e0, 0x310000 },
+	{ 0x3d4030e8, 0x66004d },
+	{ 0x3d4030ec, 0x16004d },
+	{ 0x3d403100, 0xa010102 },
+	{ 0x3d403104, 0x30404 },
+	{ 0x3d403108, 0x203060b },
+	{ 0x3d40310c, 0x505000 },
+	{ 0x3d403110, 0x2040202 },
+	{ 0x3d403114, 0x2030202 },
+	{ 0x3d403118, 0x1010004 },
+	{ 0x3d40311c, 0x301 },
+	{ 0x3d403130, 0x20300 },
+	{ 0x3d403134, 0xa100002 },
+	{ 0x3d403138, 0x8 },
+	{ 0x3d403144, 0x50003 },
+	{ 0x3d403180, 0x190004 },
+	{ 0x3d403190, 0x3818200 },
+	{ 0x3d403194, 0x80303 },
+	{ 0x3d4031b4, 0x100 },
+	{ 0x3d400028, 0x0 },
+};
+
+/* PHY Initialize Configuration */
+struct dram_cfg_param ddr_ddrphy_cfg[] = {
+	{ 0x100a0, 0x0 },
+	{ 0x100a1, 0x1 },
+	{ 0x100a2, 0x2 },
+	{ 0x100a3, 0x3 },
+	{ 0x100a4, 0x4 },
+	{ 0x100a5, 0x5 },
+	{ 0x100a6, 0x6 },
+	{ 0x100a7, 0x7 },
+	{ 0x110a0, 0x0 },
+	{ 0x110a1, 0x1 },
+	{ 0x110a2, 0x3 },
+	{ 0x110a3, 0x4 },
+	{ 0x110a4, 0x5 },
+	{ 0x110a5, 0x2 },
+	{ 0x110a6, 0x7 },
+	{ 0x110a7, 0x6 },
+	{ 0x120a0, 0x0 },
+	{ 0x120a1, 0x1 },
+	{ 0x120a2, 0x3 },
+	{ 0x120a3, 0x2 },
+	{ 0x120a4, 0x5 },
+	{ 0x120a5, 0x4 },
+	{ 0x120a6, 0x7 },
+	{ 0x120a7, 0x6 },
+	{ 0x130a0, 0x0 },
+	{ 0x130a1, 0x1 },
+	{ 0x130a2, 0x2 },
+	{ 0x130a3, 0x3 },
+	{ 0x130a4, 0x4 },
+	{ 0x130a5, 0x5 },
+	{ 0x130a6, 0x6 },
+	{ 0x130a7, 0x7 },
+	{ 0x1005f, 0x1ff },
+	{ 0x1015f, 0x1ff },
+	{ 0x1105f, 0x1ff },
+	{ 0x1115f, 0x1ff },
+	{ 0x1205f, 0x1ff },
+	{ 0x1215f, 0x1ff },
+	{ 0x1305f, 0x1ff },
+	{ 0x1315f, 0x1ff },
+	{ 0x11005f, 0x1ff },
+	{ 0x11015f, 0x1ff },
+	{ 0x11105f, 0x1ff },
+	{ 0x11115f, 0x1ff },
+	{ 0x11205f, 0x1ff },
+	{ 0x11215f, 0x1ff },
+	{ 0x11305f, 0x1ff },
+	{ 0x11315f, 0x1ff },
+	{ 0x21005f, 0x1ff },
+	{ 0x21015f, 0x1ff },
+	{ 0x21105f, 0x1ff },
+	{ 0x21115f, 0x1ff },
+	{ 0x21205f, 0x1ff },
+	{ 0x21215f, 0x1ff },
+	{ 0x21305f, 0x1ff },
+	{ 0x21315f, 0x1ff },
+	{ 0x55, 0x1ff },
+	{ 0x1055, 0x1ff },
+	{ 0x2055, 0x1ff },
+	{ 0x3055, 0x1ff },
+	{ 0x4055, 0x1ff },
+	{ 0x5055, 0x1ff },
+	{ 0x6055, 0x1ff },
+	{ 0x7055, 0x1ff },
+	{ 0x8055, 0x1ff },
+	{ 0x9055, 0x1ff },
+	{ 0x200c5, 0x19 },
+	{ 0x1200c5, 0x7 },
+	{ 0x2200c5, 0x7 },
+	{ 0x2002e, 0x2 },
+	{ 0x12002e, 0x2 },
+	{ 0x22002e, 0x2 },
+	{ 0x90204, 0x0 },
+	{ 0x190204, 0x0 },
+	{ 0x290204, 0x0 },
+	{ 0x20024, 0x1ab },
+	{ 0x2003a, 0x0 },
+	{ 0x120024, 0x1ab },
+	{ 0x2003a, 0x0 },
+	{ 0x220024, 0x1ab },
+	{ 0x2003a, 0x0 },
+	{ 0x20056, 0x3 },
+	{ 0x120056, 0x3 },
+	{ 0x220056, 0x3 },
+	{ 0x1004d, 0xe00 },
+	{ 0x1014d, 0xe00 },
+	{ 0x1104d, 0xe00 },
+	{ 0x1114d, 0xe00 },
+	{ 0x1204d, 0xe00 },
+	{ 0x1214d, 0xe00 },
+	{ 0x1304d, 0xe00 },
+	{ 0x1314d, 0xe00 },
+	{ 0x11004d, 0xe00 },
+	{ 0x11014d, 0xe00 },
+	{ 0x11104d, 0xe00 },
+	{ 0x11114d, 0xe00 },
+	{ 0x11204d, 0xe00 },
+	{ 0x11214d, 0xe00 },
+	{ 0x11304d, 0xe00 },
+	{ 0x11314d, 0xe00 },
+	{ 0x21004d, 0xe00 },
+	{ 0x21014d, 0xe00 },
+	{ 0x21104d, 0xe00 },
+	{ 0x21114d, 0xe00 },
+	{ 0x21204d, 0xe00 },
+	{ 0x21214d, 0xe00 },
+	{ 0x21304d, 0xe00 },
+	{ 0x21314d, 0xe00 },
+	{ 0x10049, 0xeba },
+	{ 0x10149, 0xeba },
+	{ 0x11049, 0xeba },
+	{ 0x11149, 0xeba },
+	{ 0x12049, 0xeba },
+	{ 0x12149, 0xeba },
+	{ 0x13049, 0xeba },
+	{ 0x13149, 0xeba },
+	{ 0x110049, 0xeba },
+	{ 0x110149, 0xeba },
+	{ 0x111049, 0xeba },
+	{ 0x111149, 0xeba },
+	{ 0x112049, 0xeba },
+	{ 0x112149, 0xeba },
+	{ 0x113049, 0xeba },
+	{ 0x113149, 0xeba },
+	{ 0x210049, 0xeba },
+	{ 0x210149, 0xeba },
+	{ 0x211049, 0xeba },
+	{ 0x211149, 0xeba },
+	{ 0x212049, 0xeba },
+	{ 0x212149, 0xeba },
+	{ 0x213049, 0xeba },
+	{ 0x213149, 0xeba },
+	{ 0x43, 0x63 },
+	{ 0x1043, 0x63 },
+	{ 0x2043, 0x63 },
+	{ 0x3043, 0x63 },
+	{ 0x4043, 0x63 },
+	{ 0x5043, 0x63 },
+	{ 0x6043, 0x63 },
+	{ 0x7043, 0x63 },
+	{ 0x8043, 0x63 },
+	{ 0x9043, 0x63 },
+	{ 0x20018, 0x3 },
+	{ 0x20075, 0x4 },
+	{ 0x20050, 0x0 },
+	{ 0x20008, 0x2ee },
+	{ 0x120008, 0x64 },
+	{ 0x220008, 0x19 },
+	{ 0x20088, 0x9 },
+	{ 0x200b2, 0xdc },
+	{ 0x10043, 0x5a1 },
+	{ 0x10143, 0x5a1 },
+	{ 0x11043, 0x5a1 },
+	{ 0x11143, 0x5a1 },
+	{ 0x12043, 0x5a1 },
+	{ 0x12143, 0x5a1 },
+	{ 0x13043, 0x5a1 },
+	{ 0x13143, 0x5a1 },
+	{ 0x1200b2, 0xdc },
+	{ 0x110043, 0x5a1 },
+	{ 0x110143, 0x5a1 },
+	{ 0x111043, 0x5a1 },
+	{ 0x111143, 0x5a1 },
+	{ 0x112043, 0x5a1 },
+	{ 0x112143, 0x5a1 },
+	{ 0x113043, 0x5a1 },
+	{ 0x113143, 0x5a1 },
+	{ 0x2200b2, 0xdc },
+	{ 0x210043, 0x5a1 },
+	{ 0x210143, 0x5a1 },
+	{ 0x211043, 0x5a1 },
+	{ 0x211143, 0x5a1 },
+	{ 0x212043, 0x5a1 },
+	{ 0x212143, 0x5a1 },
+	{ 0x213043, 0x5a1 },
+	{ 0x213143, 0x5a1 },
+	{ 0x200fa, 0x1 },
+	{ 0x1200fa, 0x1 },
+	{ 0x2200fa, 0x1 },
+	{ 0x20019, 0x1 },
+	{ 0x120019, 0x1 },
+	{ 0x220019, 0x1 },
+	{ 0x200f0, 0x660 },
+	{ 0x200f1, 0x0 },
+	{ 0x200f2, 0x4444 },
+	{ 0x200f3, 0x8888 },
+	{ 0x200f4, 0x5665 },
+	{ 0x200f5, 0x0 },
+	{ 0x200f6, 0x0 },
+	{ 0x200f7, 0xf000 },
+	{ 0x20025, 0x0 },
+	{ 0x2002d, 0x0 },
+	{ 0x12002d, 0x0 },
+	{ 0x22002d, 0x0 },
+	{ 0x200c7, 0x21 },
+	{ 0x1200c7, 0x21 },
+	{ 0x2200c7, 0x21 },
+	{ 0x200ca, 0x24 },
+	{ 0x1200ca, 0x24 },
+	{ 0x2200ca, 0x24 },
+};
+
+/* ddr phy trained csr */
+struct dram_cfg_param ddr_ddrphy_trained_csr[] = {
+	{ 0x200b2, 0x0 },
+	{ 0x1200b2, 0x0 },
+	{ 0x2200b2, 0x0 },
+	{ 0x200cb, 0x0 },
+	{ 0x10043, 0x0 },
+	{ 0x110043, 0x0 },
+	{ 0x210043, 0x0 },
+	{ 0x10143, 0x0 },
+	{ 0x110143, 0x0 },
+	{ 0x210143, 0x0 },
+	{ 0x11043, 0x0 },
+	{ 0x111043, 0x0 },
+	{ 0x211043, 0x0 },
+	{ 0x11143, 0x0 },
+	{ 0x111143, 0x0 },
+	{ 0x211143, 0x0 },
+	{ 0x12043, 0x0 },
+	{ 0x112043, 0x0 },
+	{ 0x212043, 0x0 },
+	{ 0x12143, 0x0 },
+	{ 0x112143, 0x0 },
+	{ 0x212143, 0x0 },
+	{ 0x13043, 0x0 },
+	{ 0x113043, 0x0 },
+	{ 0x213043, 0x0 },
+	{ 0x13143, 0x0 },
+	{ 0x113143, 0x0 },
+	{ 0x213143, 0x0 },
+	{ 0x80, 0x0 },
+	{ 0x100080, 0x0 },
+	{ 0x200080, 0x0 },
+	{ 0x1080, 0x0 },
+	{ 0x101080, 0x0 },
+	{ 0x201080, 0x0 },
+	{ 0x2080, 0x0 },
+	{ 0x102080, 0x0 },
+	{ 0x202080, 0x0 },
+	{ 0x3080, 0x0 },
+	{ 0x103080, 0x0 },
+	{ 0x203080, 0x0 },
+	{ 0x4080, 0x0 },
+	{ 0x104080, 0x0 },
+	{ 0x204080, 0x0 },
+	{ 0x5080, 0x0 },
+	{ 0x105080, 0x0 },
+	{ 0x205080, 0x0 },
+	{ 0x6080, 0x0 },
+	{ 0x106080, 0x0 },
+	{ 0x206080, 0x0 },
+	{ 0x7080, 0x0 },
+	{ 0x107080, 0x0 },
+	{ 0x207080, 0x0 },
+	{ 0x8080, 0x0 },
+	{ 0x108080, 0x0 },
+	{ 0x208080, 0x0 },
+	{ 0x9080, 0x0 },
+	{ 0x109080, 0x0 },
+	{ 0x209080, 0x0 },
+	{ 0x10080, 0x0 },
+	{ 0x110080, 0x0 },
+	{ 0x210080, 0x0 },
+	{ 0x10180, 0x0 },
+	{ 0x110180, 0x0 },
+	{ 0x210180, 0x0 },
+	{ 0x11080, 0x0 },
+	{ 0x111080, 0x0 },
+	{ 0x211080, 0x0 },
+	{ 0x11180, 0x0 },
+	{ 0x111180, 0x0 },
+	{ 0x211180, 0x0 },
+	{ 0x12080, 0x0 },
+	{ 0x112080, 0x0 },
+	{ 0x212080, 0x0 },
+	{ 0x12180, 0x0 },
+	{ 0x112180, 0x0 },
+	{ 0x212180, 0x0 },
+	{ 0x13080, 0x0 },
+	{ 0x113080, 0x0 },
+	{ 0x213080, 0x0 },
+	{ 0x13180, 0x0 },
+	{ 0x113180, 0x0 },
+	{ 0x213180, 0x0 },
+	{ 0x10081, 0x0 },
+	{ 0x110081, 0x0 },
+	{ 0x210081, 0x0 },
+	{ 0x10181, 0x0 },
+	{ 0x110181, 0x0 },
+	{ 0x210181, 0x0 },
+	{ 0x11081, 0x0 },
+	{ 0x111081, 0x0 },
+	{ 0x211081, 0x0 },
+	{ 0x11181, 0x0 },
+	{ 0x111181, 0x0 },
+	{ 0x211181, 0x0 },
+	{ 0x12081, 0x0 },
+	{ 0x112081, 0x0 },
+	{ 0x212081, 0x0 },
+	{ 0x12181, 0x0 },
+	{ 0x112181, 0x0 },
+	{ 0x212181, 0x0 },
+	{ 0x13081, 0x0 },
+	{ 0x113081, 0x0 },
+	{ 0x213081, 0x0 },
+	{ 0x13181, 0x0 },
+	{ 0x113181, 0x0 },
+	{ 0x213181, 0x0 },
+	{ 0x100d0, 0x0 },
+	{ 0x1100d0, 0x0 },
+	{ 0x2100d0, 0x0 },
+	{ 0x101d0, 0x0 },
+	{ 0x1101d0, 0x0 },
+	{ 0x2101d0, 0x0 },
+	{ 0x110d0, 0x0 },
+	{ 0x1110d0, 0x0 },
+	{ 0x2110d0, 0x0 },
+	{ 0x111d0, 0x0 },
+	{ 0x1111d0, 0x0 },
+	{ 0x2111d0, 0x0 },
+	{ 0x120d0, 0x0 },
+	{ 0x1120d0, 0x0 },
+	{ 0x2120d0, 0x0 },
+	{ 0x121d0, 0x0 },
+	{ 0x1121d0, 0x0 },
+	{ 0x2121d0, 0x0 },
+	{ 0x130d0, 0x0 },
+	{ 0x1130d0, 0x0 },
+	{ 0x2130d0, 0x0 },
+	{ 0x131d0, 0x0 },
+	{ 0x1131d0, 0x0 },
+	{ 0x2131d0, 0x0 },
+	{ 0x100d1, 0x0 },
+	{ 0x1100d1, 0x0 },
+	{ 0x2100d1, 0x0 },
+	{ 0x101d1, 0x0 },
+	{ 0x1101d1, 0x0 },
+	{ 0x2101d1, 0x0 },
+	{ 0x110d1, 0x0 },
+	{ 0x1110d1, 0x0 },
+	{ 0x2110d1, 0x0 },
+	{ 0x111d1, 0x0 },
+	{ 0x1111d1, 0x0 },
+	{ 0x2111d1, 0x0 },
+	{ 0x120d1, 0x0 },
+	{ 0x1120d1, 0x0 },
+	{ 0x2120d1, 0x0 },
+	{ 0x121d1, 0x0 },
+	{ 0x1121d1, 0x0 },
+	{ 0x2121d1, 0x0 },
+	{ 0x130d1, 0x0 },
+	{ 0x1130d1, 0x0 },
+	{ 0x2130d1, 0x0 },
+	{ 0x131d1, 0x0 },
+	{ 0x1131d1, 0x0 },
+	{ 0x2131d1, 0x0 },
+	{ 0x10068, 0x0 },
+	{ 0x10168, 0x0 },
+	{ 0x10268, 0x0 },
+	{ 0x10368, 0x0 },
+	{ 0x10468, 0x0 },
+	{ 0x10568, 0x0 },
+	{ 0x10668, 0x0 },
+	{ 0x10768, 0x0 },
+	{ 0x10868, 0x0 },
+	{ 0x11068, 0x0 },
+	{ 0x11168, 0x0 },
+	{ 0x11268, 0x0 },
+	{ 0x11368, 0x0 },
+	{ 0x11468, 0x0 },
+	{ 0x11568, 0x0 },
+	{ 0x11668, 0x0 },
+	{ 0x11768, 0x0 },
+	{ 0x11868, 0x0 },
+	{ 0x12068, 0x0 },
+	{ 0x12168, 0x0 },
+	{ 0x12268, 0x0 },
+	{ 0x12368, 0x0 },
+	{ 0x12468, 0x0 },
+	{ 0x12568, 0x0 },
+	{ 0x12668, 0x0 },
+	{ 0x12768, 0x0 },
+	{ 0x12868, 0x0 },
+	{ 0x13068, 0x0 },
+	{ 0x13168, 0x0 },
+	{ 0x13268, 0x0 },
+	{ 0x13368, 0x0 },
+	{ 0x13468, 0x0 },
+	{ 0x13568, 0x0 },
+	{ 0x13668, 0x0 },
+	{ 0x13768, 0x0 },
+	{ 0x13868, 0x0 },
+	{ 0x10069, 0x0 },
+	{ 0x10169, 0x0 },
+	{ 0x10269, 0x0 },
+	{ 0x10369, 0x0 },
+	{ 0x10469, 0x0 },
+	{ 0x10569, 0x0 },
+	{ 0x10669, 0x0 },
+	{ 0x10769, 0x0 },
+	{ 0x10869, 0x0 },
+	{ 0x11069, 0x0 },
+	{ 0x11169, 0x0 },
+	{ 0x11269, 0x0 },
+	{ 0x11369, 0x0 },
+	{ 0x11469, 0x0 },
+	{ 0x11569, 0x0 },
+	{ 0x11669, 0x0 },
+	{ 0x11769, 0x0 },
+	{ 0x11869, 0x0 },
+	{ 0x12069, 0x0 },
+	{ 0x12169, 0x0 },
+	{ 0x12269, 0x0 },
+	{ 0x12369, 0x0 },
+	{ 0x12469, 0x0 },
+	{ 0x12569, 0x0 },
+	{ 0x12669, 0x0 },
+	{ 0x12769, 0x0 },
+	{ 0x12869, 0x0 },
+	{ 0x13069, 0x0 },
+	{ 0x13169, 0x0 },
+	{ 0x13269, 0x0 },
+	{ 0x13369, 0x0 },
+	{ 0x13469, 0x0 },
+	{ 0x13569, 0x0 },
+	{ 0x13669, 0x0 },
+	{ 0x13769, 0x0 },
+	{ 0x13869, 0x0 },
+	{ 0x1008c, 0x0 },
+	{ 0x11008c, 0x0 },
+	{ 0x21008c, 0x0 },
+	{ 0x1018c, 0x0 },
+	{ 0x11018c, 0x0 },
+	{ 0x21018c, 0x0 },
+	{ 0x1108c, 0x0 },
+	{ 0x11108c, 0x0 },
+	{ 0x21108c, 0x0 },
+	{ 0x1118c, 0x0 },
+	{ 0x11118c, 0x0 },
+	{ 0x21118c, 0x0 },
+	{ 0x1208c, 0x0 },
+	{ 0x11208c, 0x0 },
+	{ 0x21208c, 0x0 },
+	{ 0x1218c, 0x0 },
+	{ 0x11218c, 0x0 },
+	{ 0x21218c, 0x0 },
+	{ 0x1308c, 0x0 },
+	{ 0x11308c, 0x0 },
+	{ 0x21308c, 0x0 },
+	{ 0x1318c, 0x0 },
+	{ 0x11318c, 0x0 },
+	{ 0x21318c, 0x0 },
+	{ 0x1008d, 0x0 },
+	{ 0x11008d, 0x0 },
+	{ 0x21008d, 0x0 },
+	{ 0x1018d, 0x0 },
+	{ 0x11018d, 0x0 },
+	{ 0x21018d, 0x0 },
+	{ 0x1108d, 0x0 },
+	{ 0x11108d, 0x0 },
+	{ 0x21108d, 0x0 },
+	{ 0x1118d, 0x0 },
+	{ 0x11118d, 0x0 },
+	{ 0x21118d, 0x0 },
+	{ 0x1208d, 0x0 },
+	{ 0x11208d, 0x0 },
+	{ 0x21208d, 0x0 },
+	{ 0x1218d, 0x0 },
+	{ 0x11218d, 0x0 },
+	{ 0x21218d, 0x0 },
+	{ 0x1308d, 0x0 },
+	{ 0x11308d, 0x0 },
+	{ 0x21308d, 0x0 },
+	{ 0x1318d, 0x0 },
+	{ 0x11318d, 0x0 },
+	{ 0x21318d, 0x0 },
+	{ 0x100c0, 0x0 },
+	{ 0x1100c0, 0x0 },
+	{ 0x2100c0, 0x0 },
+	{ 0x101c0, 0x0 },
+	{ 0x1101c0, 0x0 },
+	{ 0x2101c0, 0x0 },
+	{ 0x102c0, 0x0 },
+	{ 0x1102c0, 0x0 },
+	{ 0x2102c0, 0x0 },
+	{ 0x103c0, 0x0 },
+	{ 0x1103c0, 0x0 },
+	{ 0x2103c0, 0x0 },
+	{ 0x104c0, 0x0 },
+	{ 0x1104c0, 0x0 },
+	{ 0x2104c0, 0x0 },
+	{ 0x105c0, 0x0 },
+	{ 0x1105c0, 0x0 },
+	{ 0x2105c0, 0x0 },
+	{ 0x106c0, 0x0 },
+	{ 0x1106c0, 0x0 },
+	{ 0x2106c0, 0x0 },
+	{ 0x107c0, 0x0 },
+	{ 0x1107c0, 0x0 },
+	{ 0x2107c0, 0x0 },
+	{ 0x108c0, 0x0 },
+	{ 0x1108c0, 0x0 },
+	{ 0x2108c0, 0x0 },
+	{ 0x110c0, 0x0 },
+	{ 0x1110c0, 0x0 },
+	{ 0x2110c0, 0x0 },
+	{ 0x111c0, 0x0 },
+	{ 0x1111c0, 0x0 },
+	{ 0x2111c0, 0x0 },
+	{ 0x112c0, 0x0 },
+	{ 0x1112c0, 0x0 },
+	{ 0x2112c0, 0x0 },
+	{ 0x113c0, 0x0 },
+	{ 0x1113c0, 0x0 },
+	{ 0x2113c0, 0x0 },
+	{ 0x114c0, 0x0 },
+	{ 0x1114c0, 0x0 },
+	{ 0x2114c0, 0x0 },
+	{ 0x115c0, 0x0 },
+	{ 0x1115c0, 0x0 },
+	{ 0x2115c0, 0x0 },
+	{ 0x116c0, 0x0 },
+	{ 0x1116c0, 0x0 },
+	{ 0x2116c0, 0x0 },
+	{ 0x117c0, 0x0 },
+	{ 0x1117c0, 0x0 },
+	{ 0x2117c0, 0x0 },
+	{ 0x118c0, 0x0 },
+	{ 0x1118c0, 0x0 },
+	{ 0x2118c0, 0x0 },
+	{ 0x120c0, 0x0 },
+	{ 0x1120c0, 0x0 },
+	{ 0x2120c0, 0x0 },
+	{ 0x121c0, 0x0 },
+	{ 0x1121c0, 0x0 },
+	{ 0x2121c0, 0x0 },
+	{ 0x122c0, 0x0 },
+	{ 0x1122c0, 0x0 },
+	{ 0x2122c0, 0x0 },
+	{ 0x123c0, 0x0 },
+	{ 0x1123c0, 0x0 },
+	{ 0x2123c0, 0x0 },
+	{ 0x124c0, 0x0 },
+	{ 0x1124c0, 0x0 },
+	{ 0x2124c0, 0x0 },
+	{ 0x125c0, 0x0 },
+	{ 0x1125c0, 0x0 },
+	{ 0x2125c0, 0x0 },
+	{ 0x126c0, 0x0 },
+	{ 0x1126c0, 0x0 },
+	{ 0x2126c0, 0x0 },
+	{ 0x127c0, 0x0 },
+	{ 0x1127c0, 0x0 },
+	{ 0x2127c0, 0x0 },
+	{ 0x128c0, 0x0 },
+	{ 0x1128c0, 0x0 },
+	{ 0x2128c0, 0x0 },
+	{ 0x130c0, 0x0 },
+	{ 0x1130c0, 0x0 },
+	{ 0x2130c0, 0x0 },
+	{ 0x131c0, 0x0 },
+	{ 0x1131c0, 0x0 },
+	{ 0x2131c0, 0x0 },
+	{ 0x132c0, 0x0 },
+	{ 0x1132c0, 0x0 },
+	{ 0x2132c0, 0x0 },
+	{ 0x133c0, 0x0 },
+	{ 0x1133c0, 0x0 },
+	{ 0x2133c0, 0x0 },
+	{ 0x134c0, 0x0 },
+	{ 0x1134c0, 0x0 },
+	{ 0x2134c0, 0x0 },
+	{ 0x135c0, 0x0 },
+	{ 0x1135c0, 0x0 },
+	{ 0x2135c0, 0x0 },
+	{ 0x136c0, 0x0 },
+	{ 0x1136c0, 0x0 },
+	{ 0x2136c0, 0x0 },
+	{ 0x137c0, 0x0 },
+	{ 0x1137c0, 0x0 },
+	{ 0x2137c0, 0x0 },
+	{ 0x138c0, 0x0 },
+	{ 0x1138c0, 0x0 },
+	{ 0x2138c0, 0x0 },
+	{ 0x100c1, 0x0 },
+	{ 0x1100c1, 0x0 },
+	{ 0x2100c1, 0x0 },
+	{ 0x101c1, 0x0 },
+	{ 0x1101c1, 0x0 },
+	{ 0x2101c1, 0x0 },
+	{ 0x102c1, 0x0 },
+	{ 0x1102c1, 0x0 },
+	{ 0x2102c1, 0x0 },
+	{ 0x103c1, 0x0 },
+	{ 0x1103c1, 0x0 },
+	{ 0x2103c1, 0x0 },
+	{ 0x104c1, 0x0 },
+	{ 0x1104c1, 0x0 },
+	{ 0x2104c1, 0x0 },
+	{ 0x105c1, 0x0 },
+	{ 0x1105c1, 0x0 },
+	{ 0x2105c1, 0x0 },
+	{ 0x106c1, 0x0 },
+	{ 0x1106c1, 0x0 },
+	{ 0x2106c1, 0x0 },
+	{ 0x107c1, 0x0 },
+	{ 0x1107c1, 0x0 },
+	{ 0x2107c1, 0x0 },
+	{ 0x108c1, 0x0 },
+	{ 0x1108c1, 0x0 },
+	{ 0x2108c1, 0x0 },
+	{ 0x110c1, 0x0 },
+	{ 0x1110c1, 0x0 },
+	{ 0x2110c1, 0x0 },
+	{ 0x111c1, 0x0 },
+	{ 0x1111c1, 0x0 },
+	{ 0x2111c1, 0x0 },
+	{ 0x112c1, 0x0 },
+	{ 0x1112c1, 0x0 },
+	{ 0x2112c1, 0x0 },
+	{ 0x113c1, 0x0 },
+	{ 0x1113c1, 0x0 },
+	{ 0x2113c1, 0x0 },
+	{ 0x114c1, 0x0 },
+	{ 0x1114c1, 0x0 },
+	{ 0x2114c1, 0x0 },
+	{ 0x115c1, 0x0 },
+	{ 0x1115c1, 0x0 },
+	{ 0x2115c1, 0x0 },
+	{ 0x116c1, 0x0 },
+	{ 0x1116c1, 0x0 },
+	{ 0x2116c1, 0x0 },
+	{ 0x117c1, 0x0 },
+	{ 0x1117c1, 0x0 },
+	{ 0x2117c1, 0x0 },
+	{ 0x118c1, 0x0 },
+	{ 0x1118c1, 0x0 },
+	{ 0x2118c1, 0x0 },
+	{ 0x120c1, 0x0 },
+	{ 0x1120c1, 0x0 },
+	{ 0x2120c1, 0x0 },
+	{ 0x121c1, 0x0 },
+	{ 0x1121c1, 0x0 },
+	{ 0x2121c1, 0x0 },
+	{ 0x122c1, 0x0 },
+	{ 0x1122c1, 0x0 },
+	{ 0x2122c1, 0x0 },
+	{ 0x123c1, 0x0 },
+	{ 0x1123c1, 0x0 },
+	{ 0x2123c1, 0x0 },
+	{ 0x124c1, 0x0 },
+	{ 0x1124c1, 0x0 },
+	{ 0x2124c1, 0x0 },
+	{ 0x125c1, 0x0 },
+	{ 0x1125c1, 0x0 },
+	{ 0x2125c1, 0x0 },
+	{ 0x126c1, 0x0 },
+	{ 0x1126c1, 0x0 },
+	{ 0x2126c1, 0x0 },
+	{ 0x127c1, 0x0 },
+	{ 0x1127c1, 0x0 },
+	{ 0x2127c1, 0x0 },
+	{ 0x128c1, 0x0 },
+	{ 0x1128c1, 0x0 },
+	{ 0x2128c1, 0x0 },
+	{ 0x130c1, 0x0 },
+	{ 0x1130c1, 0x0 },
+	{ 0x2130c1, 0x0 },
+	{ 0x131c1, 0x0 },
+	{ 0x1131c1, 0x0 },
+	{ 0x2131c1, 0x0 },
+	{ 0x132c1, 0x0 },
+	{ 0x1132c1, 0x0 },
+	{ 0x2132c1, 0x0 },
+	{ 0x133c1, 0x0 },
+	{ 0x1133c1, 0x0 },
+	{ 0x2133c1, 0x0 },
+	{ 0x134c1, 0x0 },
+	{ 0x1134c1, 0x0 },
+	{ 0x2134c1, 0x0 },
+	{ 0x135c1, 0x0 },
+	{ 0x1135c1, 0x0 },
+	{ 0x2135c1, 0x0 },
+	{ 0x136c1, 0x0 },
+	{ 0x1136c1, 0x0 },
+	{ 0x2136c1, 0x0 },
+	{ 0x137c1, 0x0 },
+	{ 0x1137c1, 0x0 },
+	{ 0x2137c1, 0x0 },
+	{ 0x138c1, 0x0 },
+	{ 0x1138c1, 0x0 },
+	{ 0x2138c1, 0x0 },
+	{ 0x10020, 0x0 },
+	{ 0x110020, 0x0 },
+	{ 0x210020, 0x0 },
+	{ 0x11020, 0x0 },
+	{ 0x111020, 0x0 },
+	{ 0x211020, 0x0 },
+	{ 0x12020, 0x0 },
+	{ 0x112020, 0x0 },
+	{ 0x212020, 0x0 },
+	{ 0x13020, 0x0 },
+	{ 0x113020, 0x0 },
+	{ 0x213020, 0x0 },
+	{ 0x20072, 0x0 },
+	{ 0x20073, 0x0 },
+	{ 0x20074, 0x0 },
+	{ 0x100aa, 0x0 },
+	{ 0x110aa, 0x0 },
+	{ 0x120aa, 0x0 },
+	{ 0x130aa, 0x0 },
+	{ 0x20010, 0x0 },
+	{ 0x120010, 0x0 },
+	{ 0x220010, 0x0 },
+	{ 0x20011, 0x0 },
+	{ 0x120011, 0x0 },
+	{ 0x220011, 0x0 },
+	{ 0x100ae, 0x0 },
+	{ 0x1100ae, 0x0 },
+	{ 0x2100ae, 0x0 },
+	{ 0x100af, 0x0 },
+	{ 0x1100af, 0x0 },
+	{ 0x2100af, 0x0 },
+	{ 0x110ae, 0x0 },
+	{ 0x1110ae, 0x0 },
+	{ 0x2110ae, 0x0 },
+	{ 0x110af, 0x0 },
+	{ 0x1110af, 0x0 },
+	{ 0x2110af, 0x0 },
+	{ 0x120ae, 0x0 },
+	{ 0x1120ae, 0x0 },
+	{ 0x2120ae, 0x0 },
+	{ 0x120af, 0x0 },
+	{ 0x1120af, 0x0 },
+	{ 0x2120af, 0x0 },
+	{ 0x130ae, 0x0 },
+	{ 0x1130ae, 0x0 },
+	{ 0x2130ae, 0x0 },
+	{ 0x130af, 0x0 },
+	{ 0x1130af, 0x0 },
+	{ 0x2130af, 0x0 },
+	{ 0x20020, 0x0 },
+	{ 0x120020, 0x0 },
+	{ 0x220020, 0x0 },
+	{ 0x100a0, 0x0 },
+	{ 0x100a1, 0x0 },
+	{ 0x100a2, 0x0 },
+	{ 0x100a3, 0x0 },
+	{ 0x100a4, 0x0 },
+	{ 0x100a5, 0x0 },
+	{ 0x100a6, 0x0 },
+	{ 0x100a7, 0x0 },
+	{ 0x110a0, 0x0 },
+	{ 0x110a1, 0x0 },
+	{ 0x110a2, 0x0 },
+	{ 0x110a3, 0x0 },
+	{ 0x110a4, 0x0 },
+	{ 0x110a5, 0x0 },
+	{ 0x110a6, 0x0 },
+	{ 0x110a7, 0x0 },
+	{ 0x120a0, 0x0 },
+	{ 0x120a1, 0x0 },
+	{ 0x120a2, 0x0 },
+	{ 0x120a3, 0x0 },
+	{ 0x120a4, 0x0 },
+	{ 0x120a5, 0x0 },
+	{ 0x120a6, 0x0 },
+	{ 0x120a7, 0x0 },
+	{ 0x130a0, 0x0 },
+	{ 0x130a1, 0x0 },
+	{ 0x130a2, 0x0 },
+	{ 0x130a3, 0x0 },
+	{ 0x130a4, 0x0 },
+	{ 0x130a5, 0x0 },
+	{ 0x130a6, 0x0 },
+	{ 0x130a7, 0x0 },
+	{ 0x2007c, 0x0 },
+	{ 0x12007c, 0x0 },
+	{ 0x22007c, 0x0 },
+	{ 0x2007d, 0x0 },
+	{ 0x12007d, 0x0 },
+	{ 0x22007d, 0x0 },
+	{ 0x400fd, 0x0 },
+	{ 0x400c0, 0x0 },
+	{ 0x90201, 0x0 },
+	{ 0x190201, 0x0 },
+	{ 0x290201, 0x0 },
+	{ 0x90202, 0x0 },
+	{ 0x190202, 0x0 },
+	{ 0x290202, 0x0 },
+	{ 0x90203, 0x0 },
+	{ 0x190203, 0x0 },
+	{ 0x290203, 0x0 },
+	{ 0x90204, 0x0 },
+	{ 0x190204, 0x0 },
+	{ 0x290204, 0x0 },
+	{ 0x90205, 0x0 },
+	{ 0x190205, 0x0 },
+	{ 0x290205, 0x0 },
+	{ 0x90206, 0x0 },
+	{ 0x190206, 0x0 },
+	{ 0x290206, 0x0 },
+	{ 0x90207, 0x0 },
+	{ 0x190207, 0x0 },
+	{ 0x290207, 0x0 },
+	{ 0x90208, 0x0 },
+	{ 0x190208, 0x0 },
+	{ 0x290208, 0x0 },
+	{ 0x10062, 0x0 },
+	{ 0x10162, 0x0 },
+	{ 0x10262, 0x0 },
+	{ 0x10362, 0x0 },
+	{ 0x10462, 0x0 },
+	{ 0x10562, 0x0 },
+	{ 0x10662, 0x0 },
+	{ 0x10762, 0x0 },
+	{ 0x10862, 0x0 },
+	{ 0x11062, 0x0 },
+	{ 0x11162, 0x0 },
+	{ 0x11262, 0x0 },
+	{ 0x11362, 0x0 },
+	{ 0x11462, 0x0 },
+	{ 0x11562, 0x0 },
+	{ 0x11662, 0x0 },
+	{ 0x11762, 0x0 },
+	{ 0x11862, 0x0 },
+	{ 0x12062, 0x0 },
+	{ 0x12162, 0x0 },
+	{ 0x12262, 0x0 },
+	{ 0x12362, 0x0 },
+	{ 0x12462, 0x0 },
+	{ 0x12562, 0x0 },
+	{ 0x12662, 0x0 },
+	{ 0x12762, 0x0 },
+	{ 0x12862, 0x0 },
+	{ 0x13062, 0x0 },
+	{ 0x13162, 0x0 },
+	{ 0x13262, 0x0 },
+	{ 0x13362, 0x0 },
+	{ 0x13462, 0x0 },
+	{ 0x13562, 0x0 },
+	{ 0x13662, 0x0 },
+	{ 0x13762, 0x0 },
+	{ 0x13862, 0x0 },
+	{ 0x20077, 0x0 },
+	{ 0x10001, 0x0 },
+	{ 0x11001, 0x0 },
+	{ 0x12001, 0x0 },
+	{ 0x13001, 0x0 },
+	{ 0x10040, 0x0 },
+	{ 0x10140, 0x0 },
+	{ 0x10240, 0x0 },
+	{ 0x10340, 0x0 },
+	{ 0x10440, 0x0 },
+	{ 0x10540, 0x0 },
+	{ 0x10640, 0x0 },
+	{ 0x10740, 0x0 },
+	{ 0x10840, 0x0 },
+	{ 0x10030, 0x0 },
+	{ 0x10130, 0x0 },
+	{ 0x10230, 0x0 },
+	{ 0x10330, 0x0 },
+	{ 0x10430, 0x0 },
+	{ 0x10530, 0x0 },
+	{ 0x10630, 0x0 },
+	{ 0x10730, 0x0 },
+	{ 0x10830, 0x0 },
+	{ 0x11040, 0x0 },
+	{ 0x11140, 0x0 },
+	{ 0x11240, 0x0 },
+	{ 0x11340, 0x0 },
+	{ 0x11440, 0x0 },
+	{ 0x11540, 0x0 },
+	{ 0x11640, 0x0 },
+	{ 0x11740, 0x0 },
+	{ 0x11840, 0x0 },
+	{ 0x11030, 0x0 },
+	{ 0x11130, 0x0 },
+	{ 0x11230, 0x0 },
+	{ 0x11330, 0x0 },
+	{ 0x11430, 0x0 },
+	{ 0x11530, 0x0 },
+	{ 0x11630, 0x0 },
+	{ 0x11730, 0x0 },
+	{ 0x11830, 0x0 },
+	{ 0x12040, 0x0 },
+	{ 0x12140, 0x0 },
+	{ 0x12240, 0x0 },
+	{ 0x12340, 0x0 },
+	{ 0x12440, 0x0 },
+	{ 0x12540, 0x0 },
+	{ 0x12640, 0x0 },
+	{ 0x12740, 0x0 },
+	{ 0x12840, 0x0 },
+	{ 0x12030, 0x0 },
+	{ 0x12130, 0x0 },
+	{ 0x12230, 0x0 },
+	{ 0x12330, 0x0 },
+	{ 0x12430, 0x0 },
+	{ 0x12530, 0x0 },
+	{ 0x12630, 0x0 },
+	{ 0x12730, 0x0 },
+	{ 0x12830, 0x0 },
+	{ 0x13040, 0x0 },
+	{ 0x13140, 0x0 },
+	{ 0x13240, 0x0 },
+	{ 0x13340, 0x0 },
+	{ 0x13440, 0x0 },
+	{ 0x13540, 0x0 },
+	{ 0x13640, 0x0 },
+	{ 0x13740, 0x0 },
+	{ 0x13840, 0x0 },
+	{ 0x13030, 0x0 },
+	{ 0x13130, 0x0 },
+	{ 0x13230, 0x0 },
+	{ 0x13330, 0x0 },
+	{ 0x13430, 0x0 },
+	{ 0x13530, 0x0 },
+	{ 0x13630, 0x0 },
+	{ 0x13730, 0x0 },
+	{ 0x13830, 0x0 },
+};
+
+/* P0 message block paremeter for training firmware */
+struct dram_cfg_param ddr_fsp0_cfg[] = {
+	{ 0xd0000, 0x0 },
+	{ 0x54003, 0xbb8 },
+	{ 0x54004, 0x2 },
+	{ 0x54005, 0x2228 },
+	{ 0x54006, 0x11 },
+	{ 0x54008, 0x131f },
+	{ 0x54009, 0xc8 },
+	{ 0x5400b, 0x2 },
+	{ 0x5400d, 0x100 },
+	{ 0x54012, 0x110 },
+	{ 0x54019, 0x2dd4 },
+	{ 0x5401a, 0x31 },
+	{ 0x5401b, 0x4d66 },
+	{ 0x5401c, 0x4d00 },
+	{ 0x5401e, 0x16 },
+	{ 0x5401f, 0x2dd4 },
+	{ 0x54020, 0x31 },
+	{ 0x54021, 0x4d66 },
+	{ 0x54022, 0x4d00 },
+	{ 0x54024, 0x16 },
+	{ 0x5402b, 0x1000 },
+	{ 0x5402c, 0x1 },
+	{ 0x54032, 0xd400 },
+	{ 0x54033, 0x312d },
+	{ 0x54034, 0x6600 },
+	{ 0x54035, 0x4d },
+	{ 0x54036, 0x4d },
+	{ 0x54037, 0x1600 },
+	{ 0x54038, 0xd400 },
+	{ 0x54039, 0x312d },
+	{ 0x5403a, 0x6600 },
+	{ 0x5403b, 0x4d },
+	{ 0x5403c, 0x4d },
+	{ 0x5403d, 0x1600 },
+	{ 0xd0000, 0x1 },
+};
+
+/* P1 message block paremeter for training firmware */
+struct dram_cfg_param ddr_fsp1_cfg[] = {
+	{ 0xd0000, 0x0 },
+	{ 0x54002, 0x101 },
+	{ 0x54003, 0x190 },
+	{ 0x54004, 0x2 },
+	{ 0x54005, 0x2228 },
+	{ 0x54006, 0x11 },
+	{ 0x54008, 0x121f },
+	{ 0x54009, 0xc8 },
+	{ 0x5400b, 0x2 },
+	{ 0x5400d, 0x100 },
+	{ 0x54012, 0x110 },
+	{ 0x54019, 0x84 },
+	{ 0x5401a, 0x31 },
+	{ 0x5401b, 0x4d66 },
+	{ 0x5401c, 0x4d00 },
+	{ 0x5401e, 0x16 },
+	{ 0x5401f, 0x84 },
+	{ 0x54020, 0x31 },
+	{ 0x54021, 0x4d66 },
+	{ 0x54022, 0x4d00 },
+	{ 0x54024, 0x16 },
+	{ 0x5402b, 0x1000 },
+	{ 0x5402c, 0x1 },
+	{ 0x54032, 0x8400 },
+	{ 0x54033, 0x3100 },
+	{ 0x54034, 0x6600 },
+	{ 0x54035, 0x4d },
+	{ 0x54036, 0x4d },
+	{ 0x54037, 0x1600 },
+	{ 0x54038, 0x8400 },
+	{ 0x54039, 0x3100 },
+	{ 0x5403a, 0x6600 },
+	{ 0x5403b, 0x4d },
+	{ 0x5403c, 0x4d },
+	{ 0x5403d, 0x1600 },
+	{ 0xd0000, 0x1 },
+};
+
+/* P2 message block paremeter for training firmware */
+struct dram_cfg_param ddr_fsp2_cfg[] = {
+	{ 0xd0000, 0x0 },
+	{ 0x54002, 0x102 },
+	{ 0x54003, 0x64 },
+	{ 0x54004, 0x2 },
+	{ 0x54005, 0x2228 },
+	{ 0x54006, 0x11 },
+	{ 0x54008, 0x121f },
+	{ 0x54009, 0xc8 },
+	{ 0x5400b, 0x2 },
+	{ 0x5400d, 0x100 },
+	{ 0x54012, 0x110 },
+	{ 0x54019, 0x84 },
+	{ 0x5401a, 0x31 },
+	{ 0x5401b, 0x4d66 },
+	{ 0x5401c, 0x4d00 },
+	{ 0x5401e, 0x16 },
+	{ 0x5401f, 0x84 },
+	{ 0x54020, 0x31 },
+	{ 0x54021, 0x4d66 },
+	{ 0x54022, 0x4d00 },
+	{ 0x54024, 0x16 },
+	{ 0x5402b, 0x1000 },
+	{ 0x5402c, 0x1 },
+	{ 0x54032, 0x8400 },
+	{ 0x54033, 0x3100 },
+	{ 0x54034, 0x6600 },
+	{ 0x54035, 0x4d },
+	{ 0x54036, 0x4d },
+	{ 0x54037, 0x1600 },
+	{ 0x54038, 0x8400 },
+	{ 0x54039, 0x3100 },
+	{ 0x5403a, 0x6600 },
+	{ 0x5403b, 0x4d },
+	{ 0x5403c, 0x4d },
+	{ 0x5403d, 0x1600 },
+	{ 0xd0000, 0x1 },
+};
+
+/* P0 2D message block paremeter for training firmware */
+struct dram_cfg_param ddr_fsp0_2d_cfg[] = {
+	{ 0xd0000, 0x0 },
+	{ 0x54003, 0xbb8 },
+	{ 0x54004, 0x2 },
+	{ 0x54005, 0x2228 },
+	{ 0x54006, 0x11 },
+	{ 0x54008, 0x61 },
+	{ 0x54009, 0xc8 },
+	{ 0x5400b, 0x2 },
+	{ 0x5400f, 0x100 },
+	{ 0x54010, 0x1f7f },
+	{ 0x54012, 0x110 },
+	{ 0x54019, 0x2dd4 },
+	{ 0x5401a, 0x31 },
+	{ 0x5401b, 0x4d66 },
+	{ 0x5401c, 0x4d00 },
+	{ 0x5401e, 0x16 },
+	{ 0x5401f, 0x2dd4 },
+	{ 0x54020, 0x31 },
+	{ 0x54021, 0x4d66 },
+	{ 0x54022, 0x4d00 },
+	{ 0x54024, 0x16 },
+	{ 0x5402b, 0x1000 },
+	{ 0x5402c, 0x1 },
+	{ 0x54032, 0xd400 },
+	{ 0x54033, 0x312d },
+	{ 0x54034, 0x6600 },
+	{ 0x54035, 0x4d },
+	{ 0x54036, 0x4d },
+	{ 0x54037, 0x1600 },
+	{ 0x54038, 0xd400 },
+	{ 0x54039, 0x312d },
+	{ 0x5403a, 0x6600 },
+	{ 0x5403b, 0x4d },
+	{ 0x5403c, 0x4d },
+	{ 0x5403d, 0x1600 },
+	{ 0xd0000, 0x1 },
+};
+
+/* DRAM PHY init engine image */
+struct dram_cfg_param ddr_phy_pie[] = {
+	{ 0xd0000, 0x0 },
+	{ 0x90000, 0x10 },
+	{ 0x90001, 0x400 },
+	{ 0x90002, 0x10e },
+	{ 0x90003, 0x0 },
+	{ 0x90004, 0x0 },
+	{ 0x90005, 0x8 },
+	{ 0x90029, 0xb },
+	{ 0x9002a, 0x480 },
+	{ 0x9002b, 0x109 },
+	{ 0x9002c, 0x8 },
+	{ 0x9002d, 0x448 },
+	{ 0x9002e, 0x139 },
+	{ 0x9002f, 0x8 },
+	{ 0x90030, 0x478 },
+	{ 0x90031, 0x109 },
+	{ 0x90032, 0x0 },
+	{ 0x90033, 0xe8 },
+	{ 0x90034, 0x109 },
+	{ 0x90035, 0x2 },
+	{ 0x90036, 0x10 },
+	{ 0x90037, 0x139 },
+	{ 0x90038, 0xf },
+	{ 0x90039, 0x7c0 },
+	{ 0x9003a, 0x139 },
+	{ 0x9003b, 0x44 },
+	{ 0x9003c, 0x630 },
+	{ 0x9003d, 0x159 },
+	{ 0x9003e, 0x14f },
+	{ 0x9003f, 0x630 },
+	{ 0x90040, 0x159 },
+	{ 0x90041, 0x47 },
+	{ 0x90042, 0x630 },
+	{ 0x90043, 0x149 },
+	{ 0x90044, 0x4f },
+	{ 0x90045, 0x630 },
+	{ 0x90046, 0x179 },
+	{ 0x90047, 0x8 },
+	{ 0x90048, 0xe0 },
+	{ 0x90049, 0x109 },
+	{ 0x9004a, 0x0 },
+	{ 0x9004b, 0x7c8 },
+	{ 0x9004c, 0x109 },
+	{ 0x9004d, 0x0 },
+	{ 0x9004e, 0x1 },
+	{ 0x9004f, 0x8 },
+	{ 0x90050, 0x0 },
+	{ 0x90051, 0x45a },
+	{ 0x90052, 0x9 },
+	{ 0x90053, 0x0 },
+	{ 0x90054, 0x448 },
+	{ 0x90055, 0x109 },
+	{ 0x90056, 0x40 },
+	{ 0x90057, 0x630 },
+	{ 0x90058, 0x179 },
+	{ 0x90059, 0x1 },
+	{ 0x9005a, 0x618 },
+	{ 0x9005b, 0x109 },
+	{ 0x9005c, 0x40c0 },
+	{ 0x9005d, 0x630 },
+	{ 0x9005e, 0x149 },
+	{ 0x9005f, 0x8 },
+	{ 0x90060, 0x4 },
+	{ 0x90061, 0x48 },
+	{ 0x90062, 0x4040 },
+	{ 0x90063, 0x630 },
+	{ 0x90064, 0x149 },
+	{ 0x90065, 0x0 },
+	{ 0x90066, 0x4 },
+	{ 0x90067, 0x48 },
+	{ 0x90068, 0x40 },
+	{ 0x90069, 0x630 },
+	{ 0x9006a, 0x149 },
+	{ 0x9006b, 0x10 },
+	{ 0x9006c, 0x4 },
+	{ 0x9006d, 0x18 },
+	{ 0x9006e, 0x0 },
+	{ 0x9006f, 0x4 },
+	{ 0x90070, 0x78 },
+	{ 0x90071, 0x549 },
+	{ 0x90072, 0x630 },
+	{ 0x90073, 0x159 },
+	{ 0x90074, 0xd49 },
+	{ 0x90075, 0x630 },
+	{ 0x90076, 0x159 },
+	{ 0x90077, 0x94a },
+	{ 0x90078, 0x630 },
+	{ 0x90079, 0x159 },
+	{ 0x9007a, 0x441 },
+	{ 0x9007b, 0x630 },
+	{ 0x9007c, 0x149 },
+	{ 0x9007d, 0x42 },
+	{ 0x9007e, 0x630 },
+	{ 0x9007f, 0x149 },
+	{ 0x90080, 0x1 },
+	{ 0x90081, 0x630 },
+	{ 0x90082, 0x149 },
+	{ 0x90083, 0x0 },
+	{ 0x90084, 0xe0 },
+	{ 0x90085, 0x109 },
+	{ 0x90086, 0xa },
+	{ 0x90087, 0x10 },
+	{ 0x90088, 0x109 },
+	{ 0x90089, 0x9 },
+	{ 0x9008a, 0x3c0 },
+	{ 0x9008b, 0x149 },
+	{ 0x9008c, 0x9 },
+	{ 0x9008d, 0x3c0 },
+	{ 0x9008e, 0x159 },
+	{ 0x9008f, 0x18 },
+	{ 0x90090, 0x10 },
+	{ 0x90091, 0x109 },
+	{ 0x90092, 0x0 },
+	{ 0x90093, 0x3c0 },
+	{ 0x90094, 0x109 },
+	{ 0x90095, 0x18 },
+	{ 0x90096, 0x4 },
+	{ 0x90097, 0x48 },
+	{ 0x90098, 0x18 },
+	{ 0x90099, 0x4 },
+	{ 0x9009a, 0x58 },
+	{ 0x9009b, 0xa },
+	{ 0x9009c, 0x10 },
+	{ 0x9009d, 0x109 },
+	{ 0x9009e, 0x2 },
+	{ 0x9009f, 0x10 },
+	{ 0x900a0, 0x109 },
+	{ 0x900a1, 0x5 },
+	{ 0x900a2, 0x7c0 },
+	{ 0x900a3, 0x109 },
+	{ 0x900a4, 0x10 },
+	{ 0x900a5, 0x10 },
+	{ 0x900a6, 0x109 },
+	{ 0x40000, 0x811 },
+	{ 0x40020, 0x880 },
+	{ 0x40040, 0x0 },
+	{ 0x40060, 0x0 },
+	{ 0x40001, 0x4008 },
+	{ 0x40021, 0x83 },
+	{ 0x40041, 0x4f },
+	{ 0x40061, 0x0 },
+	{ 0x40002, 0x4040 },
+	{ 0x40022, 0x83 },
+	{ 0x40042, 0x51 },
+	{ 0x40062, 0x0 },
+	{ 0x40003, 0x811 },
+	{ 0x40023, 0x880 },
+	{ 0x40043, 0x0 },
+	{ 0x40063, 0x0 },
+	{ 0x40004, 0x720 },
+	{ 0x40024, 0xf },
+	{ 0x40044, 0x1740 },
+	{ 0x40064, 0x0 },
+	{ 0x40005, 0x16 },
+	{ 0x40025, 0x83 },
+	{ 0x40045, 0x4b },
+	{ 0x40065, 0x0 },
+	{ 0x40006, 0x716 },
+	{ 0x40026, 0xf },
+	{ 0x40046, 0x2001 },
+	{ 0x40066, 0x0 },
+	{ 0x40007, 0x716 },
+	{ 0x40027, 0xf },
+	{ 0x40047, 0x2800 },
+	{ 0x40067, 0x0 },
+	{ 0x40008, 0x716 },
+	{ 0x40028, 0xf },
+	{ 0x40048, 0xf00 },
+	{ 0x40068, 0x0 },
+	{ 0x40009, 0x720 },
+	{ 0x40029, 0xf },
+	{ 0x40049, 0x1400 },
+	{ 0x40069, 0x0 },
+	{ 0x4000a, 0xe08 },
+	{ 0x4002a, 0xc15 },
+	{ 0x4004a, 0x0 },
+	{ 0x4006a, 0x0 },
+	{ 0x4000b, 0x623 },
+	{ 0x4002b, 0x15 },
+	{ 0x4004b, 0x0 },
+	{ 0x4006b, 0x0 },
+	{ 0x4000c, 0x4028 },
+	{ 0x4002c, 0x80 },
+	{ 0x4004c, 0x0 },
+	{ 0x4006c, 0x0 },
+	{ 0x4000d, 0xe08 },
+	{ 0x4002d, 0xc1a },
+	{ 0x4004d, 0x0 },
+	{ 0x4006d, 0x0 },
+	{ 0x4000e, 0x623 },
+	{ 0x4002e, 0x1a },
+	{ 0x4004e, 0x0 },
+	{ 0x4006e, 0x0 },
+	{ 0x4000f, 0x4040 },
+	{ 0x4002f, 0x80 },
+	{ 0x4004f, 0x0 },
+	{ 0x4006f, 0x0 },
+	{ 0x40010, 0x2604 },
+	{ 0x40030, 0x15 },
+	{ 0x40050, 0x0 },
+	{ 0x40070, 0x0 },
+	{ 0x40011, 0x708 },
+	{ 0x40031, 0x5 },
+	{ 0x40051, 0x0 },
+	{ 0x40071, 0x2002 },
+	{ 0x40012, 0x8 },
+	{ 0x40032, 0x80 },
+	{ 0x40052, 0x0 },
+	{ 0x40072, 0x0 },
+	{ 0x40013, 0x2604 },
+	{ 0x40033, 0x1a },
+	{ 0x40053, 0x0 },
+	{ 0x40073, 0x0 },
+	{ 0x40014, 0x708 },
+	{ 0x40034, 0xa },
+	{ 0x40054, 0x0 },
+	{ 0x40074, 0x2002 },
+	{ 0x40015, 0x4040 },
+	{ 0x40035, 0x80 },
+	{ 0x40055, 0x0 },
+	{ 0x40075, 0x0 },
+	{ 0x40016, 0x60a },
+	{ 0x40036, 0x15 },
+	{ 0x40056, 0x1200 },
+	{ 0x40076, 0x0 },
+	{ 0x40017, 0x61a },
+	{ 0x40037, 0x15 },
+	{ 0x40057, 0x1300 },
+	{ 0x40077, 0x0 },
+	{ 0x40018, 0x60a },
+	{ 0x40038, 0x1a },
+	{ 0x40058, 0x1200 },
+	{ 0x40078, 0x0 },
+	{ 0x40019, 0x642 },
+	{ 0x40039, 0x1a },
+	{ 0x40059, 0x1300 },
+	{ 0x40079, 0x0 },
+	{ 0x4001a, 0x4808 },
+	{ 0x4003a, 0x880 },
+	{ 0x4005a, 0x0 },
+	{ 0x4007a, 0x0 },
+	{ 0x900a7, 0x0 },
+	{ 0x900a8, 0x790 },
+	{ 0x900a9, 0x11a },
+	{ 0x900aa, 0x8 },
+	{ 0x900ab, 0x7aa },
+	{ 0x900ac, 0x2a },
+	{ 0x900ad, 0x10 },
+	{ 0x900ae, 0x7b2 },
+	{ 0x900af, 0x2a },
+	{ 0x900b0, 0x0 },
+	{ 0x900b1, 0x7c8 },
+	{ 0x900b2, 0x109 },
+	{ 0x900b3, 0x10 },
+	{ 0x900b4, 0x2a8 },
+	{ 0x900b5, 0x129 },
+	{ 0x900b6, 0x8 },
+	{ 0x900b7, 0x370 },
+	{ 0x900b8, 0x129 },
+	{ 0x900b9, 0xa },
+	{ 0x900ba, 0x3c8 },
+	{ 0x900bb, 0x1a9 },
+	{ 0x900bc, 0xc },
+	{ 0x900bd, 0x408 },
+	{ 0x900be, 0x199 },
+	{ 0x900bf, 0x14 },
+	{ 0x900c0, 0x790 },
+	{ 0x900c1, 0x11a },
+	{ 0x900c2, 0x8 },
+	{ 0x900c3, 0x4 },
+	{ 0x900c4, 0x18 },
+	{ 0x900c5, 0xe },
+	{ 0x900c6, 0x408 },
+	{ 0x900c7, 0x199 },
+	{ 0x900c8, 0x8 },
+	{ 0x900c9, 0x8568 },
+	{ 0x900ca, 0x108 },
+	{ 0x900cb, 0x18 },
+	{ 0x900cc, 0x790 },
+	{ 0x900cd, 0x16a },
+	{ 0x900ce, 0x8 },
+	{ 0x900cf, 0x1d8 },
+	{ 0x900d0, 0x169 },
+	{ 0x900d1, 0x10 },
+	{ 0x900d2, 0x8558 },
+	{ 0x900d3, 0x168 },
+	{ 0x900d4, 0x70 },
+	{ 0x900d5, 0x788 },
+	{ 0x900d6, 0x16a },
+	{ 0x900d7, 0x1ff8 },
+	{ 0x900d8, 0x85a8 },
+	{ 0x900d9, 0x1e8 },
+	{ 0x900da, 0x50 },
+	{ 0x900db, 0x798 },
+	{ 0x900dc, 0x16a },
+	{ 0x900dd, 0x60 },
+	{ 0x900de, 0x7a0 },
+	{ 0x900df, 0x16a },
+	{ 0x900e0, 0x8 },
+	{ 0x900e1, 0x8310 },
+	{ 0x900e2, 0x168 },
+	{ 0x900e3, 0x8 },
+	{ 0x900e4, 0xa310 },
+	{ 0x900e5, 0x168 },
+	{ 0x900e6, 0xa },
+	{ 0x900e7, 0x408 },
+	{ 0x900e8, 0x169 },
+	{ 0x900e9, 0x6e },
+	{ 0x900ea, 0x0 },
+	{ 0x900eb, 0x68 },
+	{ 0x900ec, 0x0 },
+	{ 0x900ed, 0x408 },
+	{ 0x900ee, 0x169 },
+	{ 0x900ef, 0x0 },
+	{ 0x900f0, 0x8310 },
+	{ 0x900f1, 0x168 },
+	{ 0x900f2, 0x0 },
+	{ 0x900f3, 0xa310 },
+	{ 0x900f4, 0x168 },
+	{ 0x900f5, 0x1ff8 },
+	{ 0x900f6, 0x85a8 },
+	{ 0x900f7, 0x1e8 },
+	{ 0x900f8, 0x68 },
+	{ 0x900f9, 0x798 },
+	{ 0x900fa, 0x16a },
+	{ 0x900fb, 0x78 },
+	{ 0x900fc, 0x7a0 },
+	{ 0x900fd, 0x16a },
+	{ 0x900fe, 0x68 },
+	{ 0x900ff, 0x790 },
+	{ 0x90100, 0x16a },
+	{ 0x90101, 0x8 },
+	{ 0x90102, 0x8b10 },
+	{ 0x90103, 0x168 },
+	{ 0x90104, 0x8 },
+	{ 0x90105, 0xab10 },
+	{ 0x90106, 0x168 },
+	{ 0x90107, 0xa },
+	{ 0x90108, 0x408 },
+	{ 0x90109, 0x169 },
+	{ 0x9010a, 0x58 },
+	{ 0x9010b, 0x0 },
+	{ 0x9010c, 0x68 },
+	{ 0x9010d, 0x0 },
+	{ 0x9010e, 0x408 },
+	{ 0x9010f, 0x169 },
+	{ 0x90110, 0x0 },
+	{ 0x90111, 0x8b10 },
+	{ 0x90112, 0x168 },
+	{ 0x90113, 0x0 },
+	{ 0x90114, 0xab10 },
+	{ 0x90115, 0x168 },
+	{ 0x90116, 0x0 },
+	{ 0x90117, 0x1d8 },
+	{ 0x90118, 0x169 },
+	{ 0x90119, 0x80 },
+	{ 0x9011a, 0x790 },
+	{ 0x9011b, 0x16a },
+	{ 0x9011c, 0x18 },
+	{ 0x9011d, 0x7aa },
+	{ 0x9011e, 0x6a },
+	{ 0x9011f, 0xa },
+	{ 0x90120, 0x0 },
+	{ 0x90121, 0x1e9 },
+	{ 0x90122, 0x8 },
+	{ 0x90123, 0x8080 },
+	{ 0x90124, 0x108 },
+	{ 0x90125, 0xf },
+	{ 0x90126, 0x408 },
+	{ 0x90127, 0x169 },
+	{ 0x90128, 0xc },
+	{ 0x90129, 0x0 },
+	{ 0x9012a, 0x68 },
+	{ 0x9012b, 0x9 },
+	{ 0x9012c, 0x0 },
+	{ 0x9012d, 0x1a9 },
+	{ 0x9012e, 0x0 },
+	{ 0x9012f, 0x408 },
+	{ 0x90130, 0x169 },
+	{ 0x90131, 0x0 },
+	{ 0x90132, 0x8080 },
+	{ 0x90133, 0x108 },
+	{ 0x90134, 0x8 },
+	{ 0x90135, 0x7aa },
+	{ 0x90136, 0x6a },
+	{ 0x90137, 0x0 },
+	{ 0x90138, 0x8568 },
+	{ 0x90139, 0x108 },
+	{ 0x9013a, 0xb7 },
+	{ 0x9013b, 0x790 },
+	{ 0x9013c, 0x16a },
+	{ 0x9013d, 0x1f },
+	{ 0x9013e, 0x0 },
+	{ 0x9013f, 0x68 },
+	{ 0x90140, 0x8 },
+	{ 0x90141, 0x8558 },
+	{ 0x90142, 0x168 },
+	{ 0x90143, 0xf },
+	{ 0x90144, 0x408 },
+	{ 0x90145, 0x169 },
+	{ 0x90146, 0xc },
+	{ 0x90147, 0x0 },
+	{ 0x90148, 0x68 },
+	{ 0x90149, 0x0 },
+	{ 0x9014a, 0x408 },
+	{ 0x9014b, 0x169 },
+	{ 0x9014c, 0x0 },
+	{ 0x9014d, 0x8558 },
+	{ 0x9014e, 0x168 },
+	{ 0x9014f, 0x8 },
+	{ 0x90150, 0x3c8 },
+	{ 0x90151, 0x1a9 },
+	{ 0x90152, 0x3 },
+	{ 0x90153, 0x370 },
+	{ 0x90154, 0x129 },
+	{ 0x90155, 0x20 },
+	{ 0x90156, 0x2aa },
+	{ 0x90157, 0x9 },
+	{ 0x90158, 0x0 },
+	{ 0x90159, 0x400 },
+	{ 0x9015a, 0x10e },
+	{ 0x9015b, 0x8 },
+	{ 0x9015c, 0xe8 },
+	{ 0x9015d, 0x109 },
+	{ 0x9015e, 0x0 },
+	{ 0x9015f, 0x8140 },
+	{ 0x90160, 0x10c },
+	{ 0x90161, 0x10 },
+	{ 0x90162, 0x8138 },
+	{ 0x90163, 0x10c },
+	{ 0x90164, 0x8 },
+	{ 0x90165, 0x7c8 },
+	{ 0x90166, 0x101 },
+	{ 0x90167, 0x8 },
+	{ 0x90168, 0x0 },
+	{ 0x90169, 0x8 },
+	{ 0x9016a, 0x8 },
+	{ 0x9016b, 0x448 },
+	{ 0x9016c, 0x109 },
+	{ 0x9016d, 0xf },
+	{ 0x9016e, 0x7c0 },
+	{ 0x9016f, 0x109 },
+	{ 0x90170, 0x0 },
+	{ 0x90171, 0xe8 },
+	{ 0x90172, 0x109 },
+	{ 0x90173, 0x47 },
+	{ 0x90174, 0x630 },
+	{ 0x90175, 0x109 },
+	{ 0x90176, 0x8 },
+	{ 0x90177, 0x618 },
+	{ 0x90178, 0x109 },
+	{ 0x90179, 0x8 },
+	{ 0x9017a, 0xe0 },
+	{ 0x9017b, 0x109 },
+	{ 0x9017c, 0x0 },
+	{ 0x9017d, 0x7c8 },
+	{ 0x9017e, 0x109 },
+	{ 0x9017f, 0x8 },
+	{ 0x90180, 0x8140 },
+	{ 0x90181, 0x10c },
+	{ 0x90182, 0x0 },
+	{ 0x90183, 0x1 },
+	{ 0x90184, 0x8 },
+	{ 0x90185, 0x8 },
+	{ 0x90186, 0x4 },
+	{ 0x90187, 0x8 },
+	{ 0x90188, 0x8 },
+	{ 0x90189, 0x7c8 },
+	{ 0x9018a, 0x101 },
+	{ 0x90006, 0x0 },
+	{ 0x90007, 0x0 },
+	{ 0x90008, 0x8 },
+	{ 0x90009, 0x0 },
+	{ 0x9000a, 0x0 },
+	{ 0x9000b, 0x0 },
+	{ 0xd00e7, 0x400 },
+	{ 0x90017, 0x0 },
+	{ 0x9001f, 0x2a },
+	{ 0x90026, 0x6a },
+	{ 0x400d0, 0x0 },
+	{ 0x400d1, 0x101 },
+	{ 0x400d2, 0x105 },
+	{ 0x400d3, 0x107 },
+	{ 0x400d4, 0x10f },
+	{ 0x400d5, 0x202 },
+	{ 0x400d6, 0x20a },
+	{ 0x400d7, 0x20b },
+	{ 0x2003a, 0x2 },
+	{ 0x2000b, 0x5d },
+	{ 0x2000c, 0xbb },
+	{ 0x2000d, 0x753 },
+	{ 0x2000e, 0x2c },
+	{ 0x12000b, 0xc },
+	{ 0x12000c, 0x19 },
+	{ 0x12000d, 0xfa },
+	{ 0x12000e, 0x10 },
+	{ 0x22000b, 0x3 },
+	{ 0x22000c, 0x6 },
+	{ 0x22000d, 0x3e },
+	{ 0x22000e, 0x10 },
+	{ 0x9000c, 0x0 },
+	{ 0x9000d, 0x173 },
+	{ 0x9000e, 0x60 },
+	{ 0x9000f, 0x6110 },
+	{ 0x90010, 0x2152 },
+	{ 0x90011, 0xdfbd },
+	{ 0x90012, 0x60 },
+	{ 0x90013, 0x6152 },
+	{ 0x20010, 0x5a },
+	{ 0x20011, 0x3 },
+	{ 0x120010, 0x5a },
+	{ 0x120011, 0x3 },
+	{ 0x220010, 0x5a },
+	{ 0x220011, 0x3 },
+	{ 0x40080, 0xe0 },
+	{ 0x40081, 0x12 },
+	{ 0x40082, 0xe0 },
+	{ 0x40083, 0x12 },
+	{ 0x40084, 0xe0 },
+	{ 0x40085, 0x12 },
+	{ 0x140080, 0xe0 },
+	{ 0x140081, 0x12 },
+	{ 0x140082, 0xe0 },
+	{ 0x140083, 0x12 },
+	{ 0x140084, 0xe0 },
+	{ 0x140085, 0x12 },
+	{ 0x240080, 0xe0 },
+	{ 0x240081, 0x12 },
+	{ 0x240082, 0xe0 },
+	{ 0x240083, 0x12 },
+	{ 0x240084, 0xe0 },
+	{ 0x240085, 0x12 },
+	{ 0x400fd, 0xf },
+	{ 0x10011, 0x1 },
+	{ 0x10012, 0x1 },
+	{ 0x10013, 0x180 },
+	{ 0x10018, 0x1 },
+	{ 0x10002, 0x6209 },
+	{ 0x100b2, 0x1 },
+	{ 0x101b4, 0x1 },
+	{ 0x102b4, 0x1 },
+	{ 0x103b4, 0x1 },
+	{ 0x104b4, 0x1 },
+	{ 0x105b4, 0x1 },
+	{ 0x106b4, 0x1 },
+	{ 0x107b4, 0x1 },
+	{ 0x108b4, 0x1 },
+	{ 0x11011, 0x1 },
+	{ 0x11012, 0x1 },
+	{ 0x11013, 0x180 },
+	{ 0x11018, 0x1 },
+	{ 0x11002, 0x6209 },
+	{ 0x110b2, 0x1 },
+	{ 0x111b4, 0x1 },
+	{ 0x112b4, 0x1 },
+	{ 0x113b4, 0x1 },
+	{ 0x114b4, 0x1 },
+	{ 0x115b4, 0x1 },
+	{ 0x116b4, 0x1 },
+	{ 0x117b4, 0x1 },
+	{ 0x118b4, 0x1 },
+	{ 0x12011, 0x1 },
+	{ 0x12012, 0x1 },
+	{ 0x12013, 0x180 },
+	{ 0x12018, 0x1 },
+	{ 0x12002, 0x6209 },
+	{ 0x120b2, 0x1 },
+	{ 0x121b4, 0x1 },
+	{ 0x122b4, 0x1 },
+	{ 0x123b4, 0x1 },
+	{ 0x124b4, 0x1 },
+	{ 0x125b4, 0x1 },
+	{ 0x126b4, 0x1 },
+	{ 0x127b4, 0x1 },
+	{ 0x128b4, 0x1 },
+	{ 0x13011, 0x1 },
+	{ 0x13012, 0x1 },
+	{ 0x13013, 0x180 },
+	{ 0x13018, 0x1 },
+	{ 0x13002, 0x6209 },
+	{ 0x130b2, 0x1 },
+	{ 0x131b4, 0x1 },
+	{ 0x132b4, 0x1 },
+	{ 0x133b4, 0x1 },
+	{ 0x134b4, 0x1 },
+	{ 0x135b4, 0x1 },
+	{ 0x136b4, 0x1 },
+	{ 0x137b4, 0x1 },
+	{ 0x138b4, 0x1 },
+	{ 0x2003a, 0x2 },
+	{ 0xc0080, 0x2 },
+	{ 0xd0000, 0x1 }
+};
+
+struct dram_fsp_msg ddr_dram_fsp_msg[] = {
+	{
+		/* P0 3000mts 1D */
+		.drate = 3000,
+		.fw_type = FW_1D_IMAGE,
+		.fsp_cfg = ddr_fsp0_cfg,
+		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp0_cfg),
+	},
+	{
+		/* P1 400mts 1D */
+		.drate = 400,
+		.fw_type = FW_1D_IMAGE,
+		.fsp_cfg = ddr_fsp1_cfg,
+		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp1_cfg),
+	},
+	{
+		/* P2 100mts 1D */
+		.drate = 100,
+		.fw_type = FW_1D_IMAGE,
+		.fsp_cfg = ddr_fsp2_cfg,
+		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp2_cfg),
+	},
+	{
+		/* P0 3000mts 2D */
+		.drate = 3000,
+		.fw_type = FW_2D_IMAGE,
+		.fsp_cfg = ddr_fsp0_2d_cfg,
+		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp0_2d_cfg),
+	},
+};
+
+/* ddr timing config params */
+struct dram_timing_info dram_timing = {
+	.ddrc_cfg = ddr_ddrc_cfg,
+	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg),
+	.ddrphy_cfg = ddr_ddrphy_cfg,
+	.ddrphy_cfg_num = ARRAY_SIZE(ddr_ddrphy_cfg),
+	.fsp_msg = ddr_dram_fsp_msg,
+	.fsp_msg_num = ARRAY_SIZE(ddr_dram_fsp_msg),
+	.ddrphy_trained_csr = ddr_ddrphy_trained_csr,
+	.ddrphy_trained_csr_num = ARRAY_SIZE(ddr_ddrphy_trained_csr),
+	.ddrphy_pie = ddr_phy_pie,
+	.ddrphy_pie_num = ARRAY_SIZE(ddr_phy_pie),
+	.fsp_table = { 3000, 400, 100, },
+};
Index: u-boot-deb-manut/board/mt/snowflake_v2/snowflake_v2.c
===================================================================
--- /dev/null
+++ u-boot-deb-manut/board/mt/snowflake_v2/snowflake_v2.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 Kontron Electronics GmbH
+ * Copyright (C) 2020 Mettler-Toledo GmbH
+ */
+
+#include <asm/arch/imx-regs.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <fdt_support.h>
+#include <linux/arm-smccc.h>
+#include <linux/errno.h>
+#include <net.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_phys_sdram_size(phys_size_t *size)
+{
+	/* always 1GB RAM */
+	*size = 0x40000000;
+	return 0;
+}
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	return fdt_fixup_memory(blob, PHYS_SDRAM, gd->ram_size);
+}
+
+int board_init(void)
+{
+	return 0;
+}
Index: u-boot-deb-manut/board/mt/snowflake_v2/spl.c
===================================================================
--- /dev/null
+++ u-boot-deb-manut/board/mt/snowflake_v2/spl.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019 Kontron Electronics GmbH
+ * Copyright (C) 2020 Mettler-Toledo GmbH
+ */
+
+#include <common.h>
+#include <spl.h>
+#include <asm/mach-imx/iomux-v3.h>
+#include <asm/arch/imx8mm_pins.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/arch/clock.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/arch/ddr.h>
+#include <asm/armv8/mmu.h>
+#include <asm/gpio.h>
+
+#include <dm/uclass.h>
+#include <dm/device.h>
+#include <dm/uclass-internal.h>
+#include <dm/device-internal.h>
+
+#include <i2c.h>
+#include <init.h>
+#include <linux/delay.h>
+
+#include <power/pmic.h>
+#include <power/pca9450.h>
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
+		return BOOT_DEVICE_BOARD;
+	default:
+		return BOOT_DEVICE_NONE;
+	}
+}
+
+bool check_ram_available(long size)
+{
+	long sz = get_ram_size((long *)PHYS_SDRAM, size);
+
+	if (sz == size)
+		return true;
+
+	return false;
+}
+
+void spl_dram_init(void)
+{
+	if (ddr_init(&dram_timing) || !check_ram_available(SZ_1G))
+		panic("Init DDR RAM failed\n");
+
+	puts("1GB DDR RAM\n");
+	writel(1, M4_BOOTROM_BASE_ADDR);
+}
+
+int board_fit_config_name_match(const char *name)
+{
+	if (is_imx8mm() &&
+	    !strcmp(name, "imx8mm-mt-snowflake-v2"))
+		return 0;
+
+	puts("FIT CONFIG CHECK failed\n");
+	return -1;
+}
+
+int power_init_board(void)
+{
+	struct udevice *dev;
+	int ret = pmic_get("pmic@25", &dev);
+
+	if (ret) {
+		puts("Snowflake/LEIG: no PMIC\n");
+		return ret;
+	}
+
+	/* BUCKxOUT_DVS0/1 control BUCK123 output, clear PRESET_EN */
+	pmic_reg_write(dev, PCA9450_BUCK123_DVS, 0x29);
+	/* BUCK1 SOC 850mV */
+	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x14);
+	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x14);
+	/* BUCK2 ARM 950mV/850mV */
+	pmic_reg_write(dev, PCA9450_BUCK2OUT_DVS0, 0x1C);
+	pmic_reg_write(dev, PCA9450_BUCK2OUT_DVS1, 0x14);
+	/* BUCK3 DRAM/GPU/VPU 950mV */
+	pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, 0x1C);
+	pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS1, 0x1C);
+	/* set VDD_SNVS_0V8 from default 0.85V to 0.8V */
+	pmic_reg_write(dev, PCA9450_LDO2CTRL, 0xC0);
+	return 0;
+}
+
+void spl_board_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	puts("Normal Boot\n");
+
+	ret = uclass_get_device_by_name(UCLASS_CLK,
+					"clock-controller@30380000",
+					&dev);
+	if (ret < 0)
+		printf("Failed to find clock node. Check device tree\n");
+}
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	arch_cpu_init();
+
+	init_uart_clk(2);
+
+	timer_init();
+
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+	ret = spl_init();
+	if (ret) {
+		debug("spl_init() failed: %d\n", ret);
+		hang();
+	}
+
+	preloader_console_init();
+
+	enable_tzc380();
+
+	power_init_board();
+
+	/* DDR initialization */
+	spl_dram_init();
+
+	board_init_r(NULL, 0);
+}
Index: u-boot-deb-manut/configs/snowflake_leig_defconfig
===================================================================
--- /dev/null
+++ u-boot-deb-manut/configs/snowflake_leig_defconfig
@@ -0,0 +1,141 @@
+CONFIG_ARM=y
+# CONFIG_ARM64_SUPPORT_AARCH32 is not set
+CONFIG_ARCH_IMX8M=y
+CONFIG_TEXT_BASE=0x40200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_OFFSET=0xFFFFDE00
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="imx8mm-mt-snowflake-v2"
+CONFIG_SPL_TEXT_BASE=0x7E1000
+CONFIG_TARGET_MT_SNOWFLAKE_V2=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL=y
+CONFIG_ENV_OFFSET_REDUND=0xFFFFBE00
+CONFIG_ARMV8_SPL_EXCEPTION_VECTORS=y
+CONFIG_SYS_LOAD_ADDR=0x40480000
+CONFIG_SPL_PAYLOAD="u-boot.img"
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_SYS_BOOT_GET_CMDLINE=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_FIT=y
+CONFIG_FIT_EXTERNAL_OFFSET=0x3000
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x500000
+# CONFIG_USE_SPL_FIT_GENERATOR is not set
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="fastboot usb 0"
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x910000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SPL_BOARD_INIT=y
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_STACK=0x920000
+CONFIG_SYS_SPL_MALLOC=y
+CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
+CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
+CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x2C0
+CONFIG_SPL_DMA=y
+CONFIG_SPL_I2C=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_USB_HOST=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_SPL_CI_UDC=y
+CONFIG_SPL_USB_SDP_SUPPORT=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=276
+# CONFIG_CMD_EXPORTENV is not set
+CONFIG_CMD_IMPORTENV=y
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_ENV_FLAGS=y
+CONFIG_CMD_NVEDIT_INFO=y
+# CONFIG_CMD_CRC32 is not set
+CONFIG_CMD_CLK=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB_SDP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_EXT4_WRITE=y
+# CONFIG_SPL_DOS_PARTITION is not set
+# CONFIG_ISO_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_CLK_COMPOSITE_CCF=y
+CONFIG_CLK_COMPOSITE_CCF=y
+CONFIG_SPL_CLK_IMX8MM=y
+CONFIG_CLK_IMX8MM=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_UDP_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x60480000
+CONFIG_FASTBOOT_BUF_SIZE=0x7300000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_MXC_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_SPL_MMC_HS400_SUPPORT=y
+# CONFIG_MMC_VERBOSE is not set
+CONFIG_MMC_SDHCI=y
+CONFIG_FSL_USDHC=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_ATHEROS=y
+CONFIG_PHY_GIGE=y
+CONFIG_FEC_MXC=y
+CONFIG_MII=y
+CONFIG_PHY=y
+CONFIG_NOP_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX8M=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PCA9450=y
+CONFIG_SPL_DM_PMIC_PCA9450=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_SERIAL=y
+CONFIG_MXC_UART=y
+CONFIG_SYSRESET=y
+CONFIG_SPL_SYSRESET=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_DM_THERMAL=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_MX7 is not set
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_CI_UDC=y
+CONFIG_SDP_LOADADDR=0x50000000
+CONFIG_IMX_WATCHDOG=y
+# CONFIG_SPL_SHA1 is not set
+# CONFIG_SPL_SHA256 is not set
Index: u-boot-deb-manut/configs/snowflake_sdcard_defconfig
===================================================================
--- /dev/null
+++ u-boot-deb-manut/configs/snowflake_sdcard_defconfig
@@ -0,0 +1,140 @@
+CONFIG_ARM=y
+# CONFIG_ARM64_SUPPORT_AARCH32 is not set
+CONFIG_ARCH_IMX8M=y
+CONFIG_TEXT_BASE=0x40200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_OFFSET=0x3F0000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="imx8mm-mt-snowflake-v2"
+CONFIG_SPL_TEXT_BASE=0x7E1000
+CONFIG_TARGET_MT_SNOWFLAKE_V2=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL=y
+CONFIG_ARMV8_SPL_EXCEPTION_VECTORS=y
+CONFIG_SYS_LOAD_ADDR=0x40480000
+CONFIG_SPL_PAYLOAD="u-boot.img"
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_SYS_BOOT_GET_CMDLINE=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_FIT=y
+CONFIG_FIT_EXTERNAL_OFFSET=0x3000
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x500000
+# CONFIG_USE_SPL_FIT_GENERATOR is not set
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="fastboot usb 0"
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x910000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SPL_BOARD_INIT=y
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_STACK=0x920000
+CONFIG_SYS_SPL_MALLOC=y
+CONFIG_HAS_CUSTOM_SPL_MALLOC_START=y
+CONFIG_CUSTOM_SYS_SPL_MALLOC_ADDR=0x42200000
+CONFIG_SYS_SPL_MALLOC_SIZE=0x80000
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
+CONFIG_SPL_DMA=y
+CONFIG_SPL_I2C=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_USB_HOST=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_SPL_CI_UDC=y
+CONFIG_SPL_USB_SDP_SUPPORT=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=276
+# CONFIG_CMD_EXPORTENV is not set
+CONFIG_CMD_IMPORTENV=y
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_ENV_FLAGS=y
+CONFIG_CMD_NVEDIT_INFO=y
+# CONFIG_CMD_CRC32 is not set
+CONFIG_CMD_CLK=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB_SDP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_EXT4_WRITE=y
+# CONFIG_SPL_DOS_PARTITION is not set
+# CONFIG_ISO_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_PART=0
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_CLK_COMPOSITE_CCF=y
+CONFIG_CLK_COMPOSITE_CCF=y
+CONFIG_SPL_CLK_IMX8MM=y
+CONFIG_CLK_IMX8MM=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_UDP_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x60480000
+CONFIG_FASTBOOT_BUF_SIZE=0x7300000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_MXC_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_SPL_MMC_HS400_SUPPORT=y
+# CONFIG_MMC_VERBOSE is not set
+CONFIG_MMC_SDHCI=y
+CONFIG_FSL_USDHC=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_ATHEROS=y
+CONFIG_PHY_GIGE=y
+CONFIG_FEC_MXC=y
+CONFIG_MII=y
+CONFIG_PHY=y
+CONFIG_NOP_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX8M=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PCA9450=y
+CONFIG_SPL_DM_PMIC_PCA9450=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_SERIAL=y
+CONFIG_MXC_UART=y
+CONFIG_SYSRESET=y
+CONFIG_SPL_SYSRESET=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_DM_THERMAL=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_MX7 is not set
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_CI_UDC=y
+CONFIG_SDP_LOADADDR=0x50000000
+CONFIG_IMX_WATCHDOG=y
+# CONFIG_SPL_SHA1 is not set
+# CONFIG_SPL_SHA256 is not set
Index: u-boot-deb-manut/include/configs/snowflake_v2.h
===================================================================
--- /dev/null
+++ u-boot-deb-manut/include/configs/snowflake_v2.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2019 Kontron Electronics GmbH
+ * Copyright (C) 2020 Mettler-Toledo GmbH
+ *
+ * Configuration settings for the MT Snowflake v2 Terminal, based on Kontron
+ * "Kontron SL i.MX 8M Mini" SoM.
+ */
+#ifndef __SNOWFLAKE_V2_IMX8M_MINI_H
+#define __SNOWFLAKE_V2_IMX8M_MINI_H
+
+#include <asm/arch/imx-regs.h>
+#include <linux/sizes.h>
+
+#ifdef CONFIG_SPL_BUILD
+#define CONFIG_MALLOC_F_ADDR        0x930000
+#endif
+
+/*
+ * #######################################
+ * ### RAM                             ###
+ * #######################################
+ */
+#define CONFIG_SYS_INIT_RAM_ADDR        0x40000000
+#define CONFIG_SYS_INIT_RAM_SIZE        SZ_2M
+
+#if defined(CONFIG_ENV_IS_IN_MMC)
+/* Environment in eMMC, before config block at the end of 1st "boot sector" */
+#endif
+
+#define CONFIG_SYS_SDRAM_BASE           0x40000000
+
+/* SDRAM configuration */
+#define PHYS_SDRAM                      0x40000000
+#define PHYS_SDRAM_SIZE			SZ_1G /* 1GB DDR */
+
+#ifndef CONFIG_SPL_BUILD
+
+#define MEM_LAYOUT_ENV_SETTINGS \
+	"fdt_addr_r=0x50200000\0" \
+	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
+	"kernel_comp_addr_r=0x40200000\0" \
+	"kernel_comp_size=0x08000000\0" \
+	"ramdisk_addr_r=0x50300000\0" \
+	"scriptaddr=0x50280000\0"
+
+#define BOOT_TARGET_DEVICES(func) \
+	func(MMC, mmc, 1) \
+	func(MMC, mmc, 0)
+
+/* Initial environment variables */
+#define CONFIG_EXTRA_ENV_SETTINGS \
+	BOOTENV \
+	MEM_LAYOUT_ENV_SETTINGS \
+	"boot_script_dhcp=boot.scr\0" \
+	"console=ttymxc2\0" \
+	"fdt_addr=0x43000000\0" \
+	"initrd_addr=0x43800000\0" \
+	"initrd_high=0xffffffffffffffff\0" \
+	"setup=setenv setupargs console=ttymxc2,115200 earlycon=ec_imx6q,0x30880000,115200\0"
+
+#include <config_distro_bootcmd.h>
+
+#endif
+
+#define CONFIG_ENV_FLAGS_LIST_STATIC \
+	"BOOT_A_LEFT:da," \
+	"BOOT_B_LEFT:da," \
+	"BOOT_ORDER:sa," \
+	"board:sa," \
+	"board_name:sa," \
+	"bootcmd:sa," \
+    "bootdelay:sa," \
+	"boot_syslinux_conf:sa," \
+	"rauc_slot:sa," \
+    "setup:sa," \
+	"soc:sa," \
+	"vendor:sa," \
+	"baudrate:so," \
+	"boot_a_script:so," \
+	"boot_extlinux:so," \
+	"boot_prefixes:so," \
+	"boot_scripts:so," \
+	"boot_targets:so," \
+	"bootcmd_mmc0:so, "\
+	"bootcmd_mmc1:so, "\
+	"console=ttymxc2:so," \
+	"distro_bootcmd:so," \
+	"efi_dtb_prefixes:so," \
+	"fdt_addr_h:so," \
+	"initrd_addr:xo," \
+	"initrd_high:xo," \
+	"kernel_addr_r:xo," \
+	"kernel_comp_addr_r r:xo," \
+	"load_efi_dtb s:xo," \
+	"mmc_boot:so," \
+	"ramdisk_addr_r:so," \
+	"scan_dev_for_boot:so," \
+	"scan_dev_for_boot_part:so," \
+	"scan_dev_for_efi:so," \
+	"scan_dev_for_extlinux:so," \
+	"scan_dev_for_scripts:so," \
+	"scriptaddr:so,"
+
+/* Do not try to probe USB net adapters for net boot */
+#undef BOOTENV_RUN_NET_USB_START
+#define BOOTENV_RUN_NET_USB_START ""
+
+#ifdef CONFIG_SPL_BUILD
+#define CFG_MALLOC_F_ADDR		0x930000
+#endif
+
+#endif /* __SNOWFLAKE_V2_IMX8M_MINI_H */
