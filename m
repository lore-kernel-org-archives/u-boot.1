Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83160CAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 09:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07BAA834E4;
	Tue, 16 Sep 2025 11:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="A15mvl7e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9507A8350A; Tue, 16 Sep 2025 11:45:41 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C36B834E1
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeHGyzW8RUfLRPF7oRRfL3IsgpZythOMOyHqObeBHc81zLQlxV+ljTH7QclahFrAT+a0+TdmuoGEsZudSN9VyghEIxSu0NrzlNQEJML0KT94kJorj62jNduufhfptf8aRCi6GEAYRP2CyUKLOigPqE2D3PFXGF7lE6QL2VCe4+45qVcw5/CSfSrZvxO+yAeC1XhcV68W47eYM/ZyUw+kNKyyMw35YS9wjGHuHv74JbtmZWVZm9TudV+DFJx25SJV32T4MlzYozY1RHfpOMRgYXIlztSK1ab4YG/SNJ4AxzkqY9ECUOgC+FE4TuYg3MJISaIKNxRlVSUJ3PJRM0VhGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+96AqGFQhC/fMQNGMCcUzBNhsiAIB595a9b3m5tjADU=;
 b=rnnFQC/t7FaGPruFgsLcHvGq5NkM5g/qG3s1DDOiAOAJbYcN9ak8BKZtBp8G/okbxkrLd1qnVehDVGA89K7xfmrzg/fYuJ1IgluwsmPc2r6/ZtL8CGjc3tRPcYdgka37J4ZIL18tI/UdBoKdScR4WyTZU32EauT61RcuLENhqgJggiAwzUCj578zZ3KvTm/h/POX5HSHOn+WmrAZlOYSWzZTMSuHJ7p6Go9AcTWAyQQXtnhPadGhL4HBHxi6mN1GSCYWqSHORI/nO6/biMqIlsR3J0KkiaYyq5GK8AysmjGgFwPsCAn4+QNI3j6XwSd6TjGqZf4kpwr46dDXv9GmhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+96AqGFQhC/fMQNGMCcUzBNhsiAIB595a9b3m5tjADU=;
 b=A15mvl7enzKOHAS5paaes0/ZcbyLKloriBdbe8lp+qTAfOWyv+sxoOMrHUICB2bM+LFYyi8bY3XfEp4hppOYPKf2VUShQSb40rwH9/b42WWNVX8rUI9kHpYramdkL0vppoKKzAxangGYVFu+ewzH1iINGHqPh9yM/VHDe1NzFXRDQLjb+glYu0HCSFwSeBKWAfe3v2BHyLWPgUn2/VpHxwey2e+Pi5dCPMTX0nFeTidSetueROA+DNX1CQdeGvVL6FID/l+S/RCIAp62kwMawJbN/D42oQfEfD9quDicGzcXDchTLgc9qFGGeQdOLeJA219kZUGhEUJVIPewOh8MWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 09:45:34 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 09:45:34 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: sbabic@nabladev.com, festevam@gmail.com, uboot-imx@nxp.com,
 trini@konsulko.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, ye.li@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com
Subject: [v2 05/12] imx9: scmi: Update the files under
 arch/arm/mach-imx/imx9/scmi/ to support i.MX94
Date: Sun,  7 Sep 2025 04:37:35 +0800
Message-ID: <20250906203743.3352805-6-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906203743.3352805-1-alice.guo@oss.nxp.com>
References: <20250906203743.3352805-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0162.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::18) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: a21ae671-1341-41a0-e667-08ddf505c86f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MLEpjhVHQdES/9tSGjl58mKnTuHIc2jO4UfZ/zNIqaY05kiQadUjWpa1CEbg?=
 =?us-ascii?Q?ZeJ+x20bw+K1hGfPQe88vn5+gSJCoh9iRaZX1cerTBPkKK3biwuHNKOB20vd?=
 =?us-ascii?Q?5RxmBRUf1sOG2Y5g+SnFdEaDqJXQpTwuyP22uJwJ5bU/CRKZZRL/MwTkulTu?=
 =?us-ascii?Q?B+K5aNmAQ/YfdV0XEntSyZAa8MV9eHSHeLJKJwDib4mCupagILnm9v+4yE1i?=
 =?us-ascii?Q?DFPNf97g5bZCy11dwbrDW3ukSifjfUrF22b6FXi7sbG5J/oBq8IF4S3lAeAY?=
 =?us-ascii?Q?esWcfjIYf5UD/tYeKi4ZCSfM9LzIL5dG7vArtS9dSwvQbsCqWm6xn8K/5BKY?=
 =?us-ascii?Q?KFVqUbKyli5TDVZ9bupQeom/dBO7Qg9uQX7MdKFyqqdoyzn4G+CVhHiTSG5S?=
 =?us-ascii?Q?S9oRtWlUNc4lG5IGBcWhWcVFownUYrAyjPrzMNrBDbnCa4v3dUJc51koJOf4?=
 =?us-ascii?Q?iG8klfFG+p8prbmC/DQx0Or+1iUCtQmfYxQMsfASDG1i84i6+yIdPN3cRv/s?=
 =?us-ascii?Q?E7XlAos7/oX58c+kIUe6vVa0J5KJYzl1kmQgOw4LbGRw8KvhagCGcvZrhfhM?=
 =?us-ascii?Q?hhUxsHE9OkcQYcQsC+aCJ3B/TmukP2zlJhucWTRCbYJYdgfQHM1zVTtzc+dk?=
 =?us-ascii?Q?d1hja+CPrdiCB9/a263a+lhHpJ5jwdVirL8V5mlw+19WBW4UIcq5jFBVdEGX?=
 =?us-ascii?Q?rac5s2Nl7XWdaxxhYjFEhCet5KRrGKMuR3GbesvhnaGGlYACfgbkgbjWWXAD?=
 =?us-ascii?Q?2cfS3Ocsbo1sqC/3SdE7mW9jyAbXsBJosFe3JBMTrG3bmQLrJUF8hHJc+58X?=
 =?us-ascii?Q?i2xVIpDGzpuFhdLpeRDWaAUo4FEDc4vK3WeWAnhDXt+g5pVgIRcsrc8M9dFX?=
 =?us-ascii?Q?9Cc2ekhzkwqjYk+9Jq06ghMT1HiZw1VNcZrdQ+fHGMjWOog5yKYLvfqeUrxE?=
 =?us-ascii?Q?YCMFMEjzALbq03hWYlsShwiUxHpRmINO7wfD+/bw8jYwrxJ8hq7nz8xRGiAl?=
 =?us-ascii?Q?QVLuSJeqs99lFjNaoQO8wGN/tgeZPmkI+O9j9sjn9VQt6yGfGjkdAMl4sgEC?=
 =?us-ascii?Q?hSFrk1kFob7fTq0/+8RCAT1tcg4gHeX8scbOI3VbuLCpH8wLyqoqc+8UG24J?=
 =?us-ascii?Q?t9H4i5/jepWyvPkpeGmgV65LUW0lb3QYEav8XRNgGk6AKWk/Wx2H6hM4Re4r?=
 =?us-ascii?Q?96PIO+EUEg/SBQVr0nItwM5aoV1ds0U9y1hMNqFFAOGwUAyJ4BunR3682POa?=
 =?us-ascii?Q?IRsioDPZ5HAkgKV1/NAlq0tpmBHYrg7CGv+V3i9pNjCqFtBXVhVJOm1F8p9u?=
 =?us-ascii?Q?HB6UbhECZajZbLWOFvMBZGikVikNFvH/CJu922Le2jbTgu0/48MkUQPeK2GD?=
 =?us-ascii?Q?o/249sHsbWy7pwhBP+ulc2sNiiIFETsD9IMBxSEs2Pb0ZD+8MYmLh+x10UTJ?=
 =?us-ascii?Q?r80/02CfgFWwjRLR8ZjKGhXpB4oyIwluLh26KByMc+3TxgjzWvG+vQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r+PT+2frf+PRnDZI+QWbAlrOHS3bG1+qGlkFHGNITsY5g7REE+wCgE6RF4cM?=
 =?us-ascii?Q?kyO11D7vW0h46yuM9WeJvkciOHOMJIfM2/lNHU4exup2QT+V5Y653edKxoE+?=
 =?us-ascii?Q?VaKS7PwDZnXtCgramI1I12nBgrLpLaAMmbBQ7kNtSsOqGBe6a5jdz6dArtQy?=
 =?us-ascii?Q?po3NXr0hjB50su3zukEOk0OFA4RXLNxnvh4UFv6SW8aLP+0Tc6Mfi+juHj6B?=
 =?us-ascii?Q?vpCC1dFok+sxMN1Fz7yOINReCp51U0gPo+AmAccKWmwAOca1WVGOlDP3zHt6?=
 =?us-ascii?Q?00VhZSWpKirgr6zIquzx6fTMGRobXidn7+ZZqdH1VzaUwjooAa+sy0JhUubl?=
 =?us-ascii?Q?XpVe+zjgCN7Xsf9nEwLehElhqbCGyCG/vcbq5nZqSoyqZz7dUF9IDYPrhnOL?=
 =?us-ascii?Q?5AT5Oi47MbFFJnzf2cctJctPrWvdDT8ou0AT9s4VsSYFiSldk+jXXutfv1g8?=
 =?us-ascii?Q?oYn3LZJIGFVBBZa2C9Hhpp1pUNa1ArJ1BZKvEAAmkYHuBic0KX4bnrNooxKi?=
 =?us-ascii?Q?2jzfTzqDCh2EC38weoDxncJodqZfaK0RSISIcVqPUcj6HhnLswzKcPuF1KNp?=
 =?us-ascii?Q?tgj7q54/2SlKipmlGO+RLvx1l7AQ27kG/KYlZ74cmqEMWlgi8IqN9kw9nsJ2?=
 =?us-ascii?Q?u6FA5+VA8ojMGLjg58/VPwBkDRQUwc6GgUZHJcqiSYGMtebhbQZ4y0zeGMRZ?=
 =?us-ascii?Q?PNe+urGlqF5twe1sQnxB08JKrIYK7fovljA4BmIdea3TPJNxnH1Yi3uW9Ogw?=
 =?us-ascii?Q?XB7fmoqvGu/bpoOlU2X0AfyElfuAZlUYcGYhRx9Pitg8ObLi0CxXyaCRr/sv?=
 =?us-ascii?Q?x6YF9Ao7ffSM5hs+wbcsByOTOChHFdZoVPTicl69LR05bl3ovaIwToCBXNV1?=
 =?us-ascii?Q?YgriSGaGh69jU8qwzR/ry79QJhEd7eURZouukA/jmGP0ppwSjef+ZPMavwn5?=
 =?us-ascii?Q?UfXFSM40a37iQSGA/3kGvuTG822rxz8n5mVz6VxyrWlNnaw1sqvEkJdXW3Lz?=
 =?us-ascii?Q?0Z5YzrTLSKHHJ93jx2iw9xKOzcfHDWfTW4LtOu8UQCjkM7WhmTY5RRMrs9zO?=
 =?us-ascii?Q?a4NxVHDu2/HmnJYxvyVPKsHX04rHGR9kpjZBX8IlWh+oDATZZ2es7zmp5xGO?=
 =?us-ascii?Q?z0D6yprOBYddhIT52RC83w6FQdgFVYL6pbOIKFMUqNH8JMYBjNn1IF6YiHWj?=
 =?us-ascii?Q?QICd8WXJZArFEsdmFIdWVuVWDMcsc49n1TedmtmTX9i6P3j9KI8wcHloEl1i?=
 =?us-ascii?Q?omP9xmC7cMd/TpJqO0nbaYDa6667efIMmX9ZL2NM3BD/Eb7Fg8tnDyIQDjbz?=
 =?us-ascii?Q?3HIWSNRsaJLa5KCNlwg+spauxotO+xvcwQo4Zr3N9DNUrAr3pn0QItT0T6ea?=
 =?us-ascii?Q?q0svCkKQswLwFWeDMAwlmEEHJcwog78HfxFl0SOn7zQkth0/DV0GnPtM4iQT?=
 =?us-ascii?Q?3KbovvBACniuwTRrqilDvmjW4nNmLZ7o6V3Y6kEAqAcjDbutqrV85syIa7gT?=
 =?us-ascii?Q?dBFOTxzbv99FU4Jg6QuAdNcAOUv3kreaai7lRE8c2Zh7nTL4oeiduTlci+CS?=
 =?us-ascii?Q?9tC79iWesYJ+EzobruhqjgWJsEAivSp3wvBeZqiR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21ae671-1341-41a0-e667-08ddf505c86f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:45:34.6609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ru/nztOt4IiW8X9edcQoPTYRqFS4w5h2QpHnTihjiInIDKjLcoXIBKnxQ+GUU36rM3DY4Ebj45bb5ECREe6QAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957
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

- Add base addresses for WDG3, WDG4, GPIO6, and GPIO7 for i.MX94.
- Introduce common.h with macros of clock IDs, power domains, and CPU
  types for platform-specific replacement (e.g., i.MX94, i.MX95).
- Extend imx_get_mac_from_fuse() to support i.MX94.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h |  9 ++++
 arch/arm/mach-imx/imx9/scmi/clock.c       | 29 ++++++-------
 arch/arm/mach-imx/imx9/scmi/common.h      | 41 +++++++++++++++++++
 arch/arm/mach-imx/imx9/scmi/soc.c         | 50 ++++++++++++++++++-----
 4 files changed, 105 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/mach-imx/imx9/scmi/common.h

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index 5127fe8f286..a44fa6663c3 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -17,14 +17,23 @@
 
 #define ANATOP_BASE_ADDR    0x44480000UL
 
+#ifdef CONFIG_IMX94
+#define WDG3_BASE_ADDR      0x49220000UL
+#define WDG4_BASE_ADDR      0x49230000UL
+#else
 #define WDG3_BASE_ADDR      0x42490000UL
 #define WDG4_BASE_ADDR      0x424a0000UL
+#endif
 #define WDG5_BASE_ADDR      0x424b0000UL
 
 #define GPIO2_BASE_ADDR	    0x43810000UL
 #define GPIO3_BASE_ADDR	    0x43820000UL
 #define GPIO4_BASE_ADDR	    0x43840000UL
 #define GPIO5_BASE_ADDR	    0x43850000UL
+#ifdef CONFIG_IMX94
+#define GPIO6_BASE_ADDR	    0x43860000UL
+#define GPIO7_BASE_ADDR	    0x43870000UL
+#endif
 
 #define FSB_BASE_ADDR       0x47510000UL
 
diff --git a/arch/arm/mach-imx/imx9/scmi/clock.c b/arch/arm/mach-imx/imx9/scmi/clock.c
index 6e6541eaa31..951d47bd9d7 100644
--- a/arch/arm/mach-imx/imx9/scmi/clock.c
+++ b/arch/arm/mach-imx/imx9/scmi/clock.c
@@ -6,16 +6,17 @@
 #include <asm/arch/clock.h>
 #include <dm/uclass.h>
 #include <scmi_agent.h>
-#include "../../../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
+#include <scmi_nxp_protocols.h>
+#include "common.h"
 
 u32 get_arm_core_clk(void)
 {
 	u32 val;
 
-	val = imx_clk_scmi_get_rate(IMX95_CLK_SEL_A55C0);
+	val = imx_clk_scmi_get_rate(SCMI_CLK(SEL_A55C0));
 	if (val)
 		return val;
-	return imx_clk_scmi_get_rate(IMX95_CLK_A55);
+	return imx_clk_scmi_get_rate(SCMI_CLK(A55));
 }
 
 void init_uart_clk(u32 index)
@@ -24,13 +25,13 @@ void init_uart_clk(u32 index)
 
 	switch (index) {
 	case 0:
-		clock_id = IMX95_CLK_LPUART1;
+		clock_id = SCMI_CLK(LPUART1);
 		break;
 	case 1:
-		clock_id = IMX95_CLK_LPUART2;
+		clock_id = SCMI_CLK(LPUART2);
 		break;
 	case 2:
-		clock_id = IMX95_CLK_LPUART3;
+		clock_id = SCMI_CLK(LPUART3);
 		break;
 	default:
 		return;
@@ -38,7 +39,7 @@ void init_uart_clk(u32 index)
 
 	/* 24MHz */
 	imx_clk_scmi_enable(clock_id, false);
-	imx_clk_scmi_set_parent(clock_id, IMX95_CLK_24M);
+	imx_clk_scmi_set_parent(clock_id, SCMI_CLK(24M));
 	imx_clk_scmi_set_rate(clock_id, 24000000);
 	imx_clk_scmi_enable(clock_id, true);
 }
@@ -49,19 +50,19 @@ unsigned int mxc_get_clock(enum mxc_clock clk)
 	case MXC_ARM_CLK:
 		return get_arm_core_clk();
 	case MXC_IPG_CLK:
-		return imx_clk_scmi_get_rate(IMX95_CLK_BUSWAKEUP);
+		return imx_clk_scmi_get_rate(SCMI_CLK(BUSWAKEUP));
 	case MXC_CSPI_CLK:
-		return imx_clk_scmi_get_rate(IMX95_CLK_LPSPI1);
+		return imx_clk_scmi_get_rate(SCMI_CLK(LPSPI1));
 	case MXC_ESDHC_CLK:
-		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC1);
+		return imx_clk_scmi_get_rate(SCMI_CLK(USDHC1));
 	case MXC_ESDHC2_CLK:
-		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC2);
+		return imx_clk_scmi_get_rate(SCMI_CLK(USDHC2));
 	case MXC_ESDHC3_CLK:
-		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC3);
+		return imx_clk_scmi_get_rate(SCMI_CLK(USDHC3));
 	case MXC_UART_CLK:
-		return imx_clk_scmi_get_rate(IMX95_CLK_LPUART1);
+		return imx_clk_scmi_get_rate(SCMI_CLK(LPUART1));
 	case MXC_FLEXSPI_CLK:
-		return imx_clk_scmi_get_rate(IMX95_CLK_FLEXSPI1);
+		return imx_clk_scmi_get_rate(SCMI_CLK(FLEXSPI1));
 	default:
 		return -1;
 	};
diff --git a/arch/arm/mach-imx/imx9/scmi/common.h b/arch/arm/mach-imx/imx9/scmi/common.h
new file mode 100644
index 00000000000..df26ecff3e4
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/common.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef _SCMI_CLOCK_COMMON_H_
+#define _SCMI_CLOCK_COMMON_H_
+
+#ifdef CONFIG_IMX94
+#define IMX_PLAT 94
+#include <../dts/upstream/src/arm64/freescale/imx94-clock.h>
+#include <../dts/upstream/src/arm64/freescale/imx94-power.h>
+
+#define IMX94_CLK_FLEXSPI1 IMX94_CLK_XSPI1
+#endif
+
+#ifdef CONFIG_IMX95
+#define IMX_PLAT 95
+#include <../dts/upstream/src/arm64/freescale/imx95-clock.h>
+#include <../dts/upstream/src/arm64/freescale/imx95-power.h>
+
+#define IMX95_PD_M70 IMX95_PD_M7
+#endif
+
+#define IMX_PLAT_STR__(plat) # plat
+#define IMX_PLAT_STR_(IMX_PLAT) IMX_PLAT_STR__(IMX_PLAT)
+#define IMX_PLAT_STR IMX_PLAT_STR_(IMX_PLAT)
+
+#define SCMI_CLK__(plat, clk) IMX ## plat ## _CLK_ ## clk
+#define SCMI_CLK_(plat, clk) SCMI_CLK__(plat, clk)
+#define SCMI_CLK(clk) SCMI_CLK_(IMX_PLAT, clk)
+
+#define SCMI_PD__(plat, pd) IMX ## plat ## _PD_ ## pd
+#define SCMI_PD_(plat, pd) SCMI_PD__(plat, pd)
+#define SCMI_PD(pd) SCMI_PD_(IMX_PLAT, pd)
+
+#define SCMI_CPU__(plat) MXC_CPU_IMX ## plat
+#define SCMI_CPU_(plat) SCMI_CPU__(plat)
+#define SCMI_CPU SCMI_CPU_(IMX_PLAT)
+
+#endif
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 07022c65b88..5c1e13c9842 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -21,6 +21,7 @@
 #include <linux/iopoll.h>
 #include <scmi_agent.h>
 #include <scmi_nxp_protocols.h>
+#include "common.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -176,7 +177,7 @@ u32 get_cpu_rev(void)
 {
 	u32 rev = (gd->arch.soc_rev >> 24) - 0xa0;
 
-	return (MXC_CPU_IMX95 << 12) | (CHIP_REV_1_0 + rev);
+	return (SCMI_CPU << 12) | (CHIP_REV_1_0 + rev);
 }
 
 #define UNLOCK_WORD 0xD928C520
@@ -437,12 +438,16 @@ void imx_get_mac_from_fuse(int dev_id, unsigned char *mac)
 {
 	u32 val[2] = {};
 	int ret, num_of_macs;
+	u32 bank = 40;
 
-	ret = fuse_read(40, 5, &val[0]);
+	if (is_imx94())
+		bank = 66;
+
+	ret = fuse_read(bank, 5, &val[0]);
 	if (ret)
 		goto err;
 
-	ret = fuse_read(40, 6, &val[1]);
+	ret = fuse_read(bank, 6, &val[1]);
 	if (ret)
 		goto err;
 
@@ -458,10 +463,32 @@ void imx_get_mac_from_fuse(int dev_id, unsigned char *mac)
 	mac[3] = (val[0] >> 24) & 0xff;
 	mac[4] = val[1] & 0xff;
 	mac[5] = (val[1] >> 8) & 0xff;
-	if (dev_id == 1)
-		mac[5] = mac[5] + 3;
-	if (dev_id == 2)
-		mac[5] = mac[5] + 6;
+
+	if (is_imx94()) {
+		/*
+		 * i.MX94 uses the following mac address offset list:
+		 * | No.    | Module      | Mac address user          |
+		 * |--------|-------------|---------------------------|
+		 * | 0 ~ 1  | ethercat    | port0/port1               |
+		 * | 2      | netc switch | internal enetc3 mac/swp0  |
+		 * | 3 ~ 6  |             | enetc3 vf1~3/swp1         |
+		 * | 7      | enetc mac   | enetc0 pf                 |
+		 * | 8      |             | enetc1 pf                 |
+		 * | 9      |             | enetc2 pf                 |
+		 * | 10     | netc switch | swp2                      |
+		 */
+		if (dev_id == 0)
+			mac[5] = mac[5] + 2; /* enetc3 mac/swp0 */
+		if (dev_id == 1)
+			mac[5] = mac[5] + 8; /* enetc1 */
+		if (dev_id == 2)
+			mac[5] = mac[5] + 9; /* enetc2 */
+	} else {
+		if (dev_id == 1)
+			mac[5] = mac[5] + 3;
+		if (dev_id == 2)
+			mac[5] = mac[5] + 6;
+	}
 
 	debug("%s: MAC%d: %pM\n", __func__, dev_id, mac);
 	return;
@@ -518,7 +545,6 @@ static char *rst_string_imx94[32] = {
 	"por"
 };
 
-
 int get_reset_reason(bool sys, bool lm)
 {
 	struct scmi_imx_misc_reset_reason_in in = {
@@ -612,8 +638,8 @@ int get_reset_reason(bool sys, bool lm)
 const char *get_imx_type(u32 imxtype)
 {
 	switch (imxtype) {
-	case MXC_CPU_IMX95:
-		return "95";/* iMX95 FULL */
+	case SCMI_CPU:
+		return IMX_PLAT_STR;
 	default:
 		return "??";
 	}
@@ -694,6 +720,10 @@ int arch_cpu_init(void)
 		gpio_reset(GPIO3_BASE_ADDR);
 		gpio_reset(GPIO4_BASE_ADDR);
 		gpio_reset(GPIO5_BASE_ADDR);
+#ifdef CONFIG_IMX94
+		gpio_reset(GPIO6_BASE_ADDR);
+		gpio_reset(GPIO7_BASE_ADDR);
+#endif
 	}
 
 	return 0;
-- 
2.43.0

