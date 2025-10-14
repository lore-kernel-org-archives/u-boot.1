Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5077CCD187
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 11:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58AB380422;
	Tue, 14 Oct 2025 13:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GIWXp2Vw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DC87807C0; Tue, 14 Oct 2025 13:18:51 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C01B802C1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 13:18:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vyu5fPJjDflvtFp3E+le4AmzcH+E+SIFeiT4sNCEp2HnV7rmWhsXfRDxjQFao3jt0zxO6rbyQ5jzyBfp7As9A75RNd2Q5jnsfn4rB3eAUGR1b1TWIl8yJGP482GrsuK3tHC185jdhBK40iR5lhAYuX3A5Twhx0fXxbtBHnJrGcgmB1ajTBo+H7wSOJgY94+Msh/j5DHv44x5FDa/2zko/pj6J0C0msDi3Jw/FYRmt2lp3bLqkvbWs7lbk/D8VV4TlM4Tf3qb2vF3TES/eiY1Q2aDxB1lT8SysRuDQk4BgidzfPodD003y5KY0iNn+1qdwFB8vZ5LEURvlzepMvvvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/b+5lhzzGE5+ekIca+URHFc8+OD+SfdPB3eYH+J3Zc=;
 b=kKqH0PkXiKeC6jwuG54nyRsN1EQ0zGM8pZM/68/f5wxMeiVqBkcwlVYVAiKgfbCn/QbX7lgt267Znk6Zsbr8Pe4CoxJyiEoVnvRwIt8rLiK+BY0Yffl2/nZ3MO0K2MlgaqJUg5H90LYwVrPancSfPVS26peo7LwQtLVYd1HhWIv7f0tnQq6NOWNqeTsL7PB+oRoVaPMFKX40jm7gVN7tQngcc+ouJPmQsy/aGlHpw0RGL4BJzfgtmXqgTubgQknNnRqpTpLPKEmthXCSeamOhnN9UXIT44Y9N301oVU6YyJrkQc8SPGqzc21WKqlE8MkywdPTnroWgF84FWhSFcOsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/b+5lhzzGE5+ekIca+URHFc8+OD+SfdPB3eYH+J3Zc=;
 b=GIWXp2VwF3BiZv1gD6ClaX89Jl+kMOy7CjfnetVGuM63ahEyMfLBYhdR/g7PweTw3OmV9bXRTjSG6/hTlZY6IduT//C2hlr2XC/fyvLl4XqzjFWp5zxjycz8jNdH9HDL4WDfPpURtRi2t1nhidtE56wH+ud2pEXzdQQUVT7y1A9bKRKW874GWXy+N8jtHKaZD3cPOyhqH7WyC5XwzZGnp+ao4MipThgwI5uKIfu88h1kilRia8AF9vg77OIcqLQkpx8iG5DlffMyqbV2ur0DfA1Gb4CS8df4ycuu5vbhCC4rze+hzLQDVbhiEsWauPdSuAtZLZ+0zY1y3dbzrLDyeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAXPR04MB8128.eurprd04.prod.outlook.com (2603:10a6:102:1c8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 11:18:47 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 11:18:47 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de, uboot-imx@nxp.com, trini@konsulko.com,
 sbabic@nabladev.com, festevam@gmail.com, jagan@amarulasolutions.com
Cc: ye.li@nxp.com, alice.guo@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com,
 sjg@chromium.org, mkorpershoek@kernel.org, marek.vasut@mailbox.org
Subject: [PATCH v1 0/4] Enable XSPI1 on i.MX943 EVK board
Date: Tue, 14 Oct 2025 19:17:52 +0800
Message-ID: <20251014111756.446456-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PAXPR04MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: f82bcfce-94a3-411c-3ce8-08de0b13712c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TIx+Zl43iZxkpt6qSVQv+6hwrRmmksfYqmH8VlXiEn5gJp41OLrgmFZd7ygo?=
 =?us-ascii?Q?EjY7Bo1JetcQQtJGqpSjGi1JvKfzLE9lk5HGPstViORUInyKFKrhO5O+drgU?=
 =?us-ascii?Q?bI2wns6sEmtfaCzIPUl0TiRJ7LJGrWkogTQUXmHtCEQ8aulomZkkM2y2lal0?=
 =?us-ascii?Q?KAkFfyvNGJFnnCRgePdj+2lgSNNlbJnjyKUhjUsAHQAOuOoZlSt5VY4Scb5c?=
 =?us-ascii?Q?P1u1XVunuE0JJ3SjlrxP0/UwHiiHRPQp7i0Hfr8llnqVw5d5/+Rbtnqw3dgp?=
 =?us-ascii?Q?xJ5ZKdhKLguluAbpFXiS+bau6EZMPgUP35ZNUz0SIDaWylI3oWwdb5VrLGYg?=
 =?us-ascii?Q?O0eXJoINRCAdT0HH6ZKsLWY0ieC1f3PwsFlLgQt31JELAB4apP9xisW7CjN2?=
 =?us-ascii?Q?uEeHcV6/xPi3asNepWaleUP+UJGPuS1XmfYuWdFUeT9mr4ZkBBOhgTzn6D8v?=
 =?us-ascii?Q?gGo+0edPEqQoby2q2zx2+zRuKgPUqVqNsLscuXTiT2pZC6y6/qtj35yIv/9v?=
 =?us-ascii?Q?0e4bfjRDRl9OkPHD80BZIun0CU25prb1gi3eAz+BMlozpdURZ/80Fnr51W4s?=
 =?us-ascii?Q?5+gP1ZMwZjfiA05l7mu+Dk7cWylXyJW7uU1Vr/nOFgraXghOKpwq5AzLzjo2?=
 =?us-ascii?Q?VB9RvjbBaMRK8pE6b01Me0owlEvDosnueUE7ETrdxVmqmzH+gIGKfCDTZI7g?=
 =?us-ascii?Q?bITBwH5YFq/eL4CyWX4VGUdVVu3TUwurIv2SjHG0f374vUbZHgf3g+sdpnrN?=
 =?us-ascii?Q?Rt3Vh14Aoy6ymR3remrQDmuWavmJXsaG2JZF5nL8I8ahqTHzOf6SPpPFuMXd?=
 =?us-ascii?Q?2tIPRwhMxpQIuXvRBzh2nfm0p0zf0pzmr3WBHJT/RzxRwjIaoCjorKhJtC3w?=
 =?us-ascii?Q?I+RdErZjHn0HS9fCNEw42KCdR9AS1pk4fYcuIb0iwphlQ99hgRybVC7T93VD?=
 =?us-ascii?Q?WtyxWyGOymm4D6dzNA4AAJhdoXKM+A6kIefk69xuz1C/SCbRcUIaXB+B387Y?=
 =?us-ascii?Q?2kgKDToBhwf2w9l8fDEx+bYFXW/8zalfos1W3BUFWpsmYd+B3WyzT5536Ldx?=
 =?us-ascii?Q?9XFmlOmn3noF01JX4sFocIE2sT5UeSFJ/eYRYmPe/vqfk2URpylLL+Fb4jSU?=
 =?us-ascii?Q?FbLidRJHvjdxvL/N0E6sm/HscOHSThSeBlMAdwF3zHFtlegQojL42UBEnF2T?=
 =?us-ascii?Q?wATH9/XbvYCG4hBqYmVp5VsBoblnMsB6lpaBQz8WM6GXcGIVnddeHDPIeyD5?=
 =?us-ascii?Q?3HEbVlG+P2/aTKTVRfCNPPV9rZfnUSmBxDgEfxfFt+65migStda5+dzf+SMu?=
 =?us-ascii?Q?puyn46vppFCnq4aR4/0FOOC2bFR5m6avUIgjLhOSWGddu0vkKk+fm5LqTsEg?=
 =?us-ascii?Q?/Wf4q3Ha/6iFFw2mWZpoCeKpMeIBARseHbKisv1ksHzfoBB3IIuZpUpAyqWR?=
 =?us-ascii?Q?2mdFA6KD0YDSPVL7ToRvovGt4gRz/HfscHBWgUNpvpJ/dHixPekb+4GONoUO?=
 =?us-ascii?Q?tnR7mhA2SImgedXRIxYow7EsyDBrY0rsV5Jz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?koLZkljz7Y4Ur6rrFikF2pqhhjLC6F3a9pfSZ07e5nyDIgxnHNOlf8MysEpt?=
 =?us-ascii?Q?4aFyX03gfvBNqxwnqQQAzYSncXBgDzgY70hW+Wu3iu75uF4mIU71tYZx+U/b?=
 =?us-ascii?Q?NEJx+bYYUsS7p9B1evN8kD4xHxESIZm8AwrlEOaloQIpei9olp/5s6ktN3+F?=
 =?us-ascii?Q?/MqIS7RxuHVPg+iS89QfqOgKCdZ0sYKrDuwR7VV3zCX2raFgDKlE0wOg8lGN?=
 =?us-ascii?Q?kt5PDi2UkAbEhmqYL3G6pnD7HuiGJrPPMzR6nCf2S8mtMlEDMJir+Dax2THy?=
 =?us-ascii?Q?y0OjTNekni17UrTPWWJYK775+GFDoES1CIORoZQKySHw+7TnXGomK7YfwQXg?=
 =?us-ascii?Q?mm5nMNbRGlCyFtUcdyLE3hpGxrtYX1soorCoZmMoq0nAQyw9g6aTfUmLHWWh?=
 =?us-ascii?Q?H4X5WjWLQpjbkn9KvF4ELAnPVWRUZqgzLcB54LNEZ5OtNfWE2gsA+ZRkRylH?=
 =?us-ascii?Q?dywLNd6s4VwEEe/ZKTJQTVDtYnVFhTiNsnzKWvD8hEZD4azV7R4XCUeDme9t?=
 =?us-ascii?Q?K3T5HEjSGnmUc5U0ESBieVigNmsgb2Kezuf3dmxLA23iEZj9azqi6TiS7YX+?=
 =?us-ascii?Q?Hxre3s4k9s/f8HKGCJq1rSHkqwKz04WmzfhzYJyIo2iAToHcW2Z3ywuLT/QO?=
 =?us-ascii?Q?pstV2if8NVFHpNC1nKrT5fbkOATBMD3V1rnPRwJ/KlFK0Z1EVfoZpvGfxut7?=
 =?us-ascii?Q?shDR2rWAd9W2bhNJ5aba1HDGZa+ImjBlP9vel2rlZzt5DdWsAXT5T54RfbDp?=
 =?us-ascii?Q?cewfnIuZkJ0n9Wnou/iHP0XFwoT8q2AoLIom+sB4/yA4D4L++Peejm6Q0v9b?=
 =?us-ascii?Q?UFLwAtlE1snfLULMsLRmLAcmKVgMrV4h4ZEZ1ZrPzA8YGK9NztrmTT2H/ZBW?=
 =?us-ascii?Q?UoV1afz5R6qa699K5vOe3MLCnXXIIP7Yb+LecWgpuRyn1uLwUCCtgtDRdw/p?=
 =?us-ascii?Q?ntXjAhnlc3MOftW/2ZNt979p51oHCUKdkHsube3mvXzavsgBM9C3PVI3EssB?=
 =?us-ascii?Q?5oN8f9zoUxkxqVz57eGtd8dhqNrCBnJ1inshRkgrbeX96un8ORDp8IOXS/r/?=
 =?us-ascii?Q?e5Rv4CKbnELyU8NrCzw2mcG/I1SY6WzaZHNQTEU2SGxHD2ttHHG0yx92oudY?=
 =?us-ascii?Q?9kg0YUunSfE8rPubgZurSvYwG99F6kFW+eizCzkUpn5OZbvNbgmKlUKzPfIm?=
 =?us-ascii?Q?C/iLiWEeFEquvoAU617XW6ombvy8MJZAooUZyy9K50odyZtPfsWE5OSZn/kb?=
 =?us-ascii?Q?BtECOL9kXUi1JrHIIynqCyUNYAV+sfykgYkzsG+x4lB4Bn6WOmnN8zViAOCz?=
 =?us-ascii?Q?LSzFLF1xped6swdY3nqbKcz/gK4L6D/N0stBmV4PKuHHSvVEx045McLzU+Sw?=
 =?us-ascii?Q?KlLaJX6gWs9+KQLGEJnh+0q8DzXqnM2SNmcARMJu2rwpmh0hh64PBASCNI6E?=
 =?us-ascii?Q?g0tZKTsDBouj9l4OPRpIy765b9lsn/61p6zQatF2n8rWVFZvtR3plkmQ05te?=
 =?us-ascii?Q?BheKM5O3SFcuIoyIssiB6kMGsCKC6w8qGB7NvzOG/TxNJcbXv3+IsDM5gN8n?=
 =?us-ascii?Q?AJ1mJkPZNz/Wt87UJgi/13sPFVhWKRhghrFhPMyH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f82bcfce-94a3-411c-3ce8-08de0b13712c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 11:18:46.9915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0tKoJUETIGjzeNGA3iHhcjRdHrXini7maOwfiI0BK1Ic66PBvI04ciFBvYiU8fKVQIOkhoIBPTOXv5KqEqfJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8128
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

Changes for v1:
 - Add support for XSPI1 on i.MX943 EVK board

Note: This patch set is based on the code after the application of the "Enable
USB and ENETC on i.MX943 EVK" patch set.

Alice Guo (2):
  spi: nxp_xspi: Add new driver for NXP XSPI controller
  imx943_evk: Enable XSPI1

Ye Li (2):
  misc: ele_api: Add support for XSPI SET GMID command
  imx94_evk: Get ownership of XSPI control registers protected by GMID
    in SPL

 MAINTAINERS                             |   1 +
 arch/arm/dts/imx943-evk-u-boot.dtsi     |  34 +
 arch/arm/dts/imx943-u-boot.dtsi         |  16 +
 arch/arm/include/asm/mach-imx/ele_api.h |   2 +
 board/freescale/imx94_evk/spl.c         |  12 +
 configs/imx943_evk_defconfig            |   9 +
 drivers/misc/imx_ele/ele_api.c          |  28 +
 drivers/spi/Kconfig                     |   7 +
 drivers/spi/Makefile                    |   1 +
 drivers/spi/nxp_xspi.c                  | 889 ++++++++++++++++++++++++
 drivers/spi/nxp_xspi.h                  | 713 +++++++++++++++++++
 11 files changed, 1712 insertions(+)
 create mode 100644 drivers/spi/nxp_xspi.c
 create mode 100644 drivers/spi/nxp_xspi.h

-- 
2.43.0

