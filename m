Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B82DE87839
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 14:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04CB7842ED;
	Tue,  3 Feb 2026 15:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="v4YZYFA2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25EB1844F1; Tue,  3 Feb 2026 15:53:29 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4F51842E1
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 15:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dpoi9ELZv+mfqY5IRnkRT4By1xPX1zmbaLbnMwBDkGui0env2TxLKcrgXQq3rUKaw+QYJ1MLxXUpfHSHul/R/TvHDzT/GdwNakPwpNLJtWGZ2tfNssbvR1epm+iJNe0Rop7rW51JrWeLLQAtDV6PwjaHSjzZfiBw1JBT1dQ+RFBFFXuCWuzq2jJcwtaNa6b1PUwON4xY/Bm0wn0DV2U/iQ+47/o8O1A4pwsSBapy1V/CJq2xLaYk5epOOS8bM3YXZ2gJ32wdtRdXlOo5uhhNiG4YcaBvnTWLN02PuNP7sk5VvdlC3MQIt8xiUMsznv/IEwlqxTxLqMq7EZXX4t3gmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1whpIVLwkVynM0os3MLUqsqsTbZUnZNewlNi5o/yXno=;
 b=tu0JhfOPgd/oX7GIBnnz+zox4BT2JKq0Y8aLQjIyWAQY3Vog2AJ8sqWelC/UYcCsrb0dn5I0OLr6fsJNaA9CPWq3qZw07o7MVLxu3okFQbZ5isuFNYZye5DspJqXeCOzj/sX0rgGbq2O7m9+lejvRH5iyWnz/9JzApFI//68B1BACRUk0QIKfkTWSgnU4DDKNI/Qby9aOH977QHeO6Am4BXWSCkIkZPkoVariRenZ5DbmHyWh1u0Y72ZiTFSSzEcI2EqYa22CFXtWlGCfgM8XOnE3Q5J5TtskTYlmpgZxO6vOucAs8s+YtJ0hTEccViNgOfV8vEHZEyVrsmxN9f+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1whpIVLwkVynM0os3MLUqsqsTbZUnZNewlNi5o/yXno=;
 b=v4YZYFA2HZ8LOT4EpsfYTZAEtoPpM/+BB+FlrqGnJQUDSy7/5/V/W0jbTzFFzm2xQMkFKRqDVwyKhUpL9A4BXo1uVwBeSutp39uK3c7ffcaJGbS673nxErFXSDLw1gXFl9NlSiWYS9TV/tKpytyF+B6mjsXd7SNiMAAt+VCIVmHWeenPbtQaIWiOqgqXwCZz2I7Z6WXwokpSaZzA8OHQm1LAwEWPhVZ0B+HtlJmOWs7AhDL/e9RIvlUc5ars0k/56Z3VUIQhlLw0xRCYrGYX/uyxT3YiPjBZnZJkY2N8u0xEit7rXANfD9ri53asTZksjHori0P76RThd7Jc0UaPKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA6PR04MB11805.eurprd04.prod.outlook.com (2603:10a6:102:525::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 14:53:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 14:53:20 +0000
Date: Wed, 4 Feb 2026 00:08:10 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, tanmay.kathpalia@altera.com,
 dlechner@baylibre.com, me@ziyao.cc
Subject: [GIT PULL] please pull mmc-for-2026.04-rc2
Message-ID: <aYIdaqjGss6ZueXm@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA6PR04MB11805:EE_
X-MS-Office365-Filtering-Correlation-Id: 70af9ff5-d070-4403-5d71-08de6333f8df
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pi8gBPW7rw4u1h5t4mA4mVIbnlNJak4CgsY0jQmPm7qPQDnRkg1yoKGjnKWE?=
 =?us-ascii?Q?M2MqoNJROZrHQVsunbibHahrpbahPEIchFDeajxyYpBEWbqmeVW9t4AnAIey?=
 =?us-ascii?Q?OxbRpoLyD7sjOu4tRuIIje+yfB81Bn29VIoPGXzYIeOu7mXfgvlUXiiVw2rp?=
 =?us-ascii?Q?c9M9bsi0JJhtAOVGU5Sa2jxbpEK2e95YgZqKFyZ3gmZJd3awdtkInYwC1oCW?=
 =?us-ascii?Q?EowS2/fWJmKHH5dWR8sRxpazChDW5Qeatbb/cPPb8R+DLBzFYkg6kGxREaTD?=
 =?us-ascii?Q?TGgrE6xK3Gww9RkxAmxje/sMGlOzejiNlV3yHA8wAV9KmQqH2K1PXOS55+rC?=
 =?us-ascii?Q?Bu92Am3qipHgfkXALuOEUkNbDCgxDVPjGl1V5iOsP9gw2yWYnbDPmeVJsfyj?=
 =?us-ascii?Q?MRez4zDYXrhz7mGAr1tUgT/RQ4wmA/BVHfraXSDzP/g+rq8mWe2Kv8IOHbaq?=
 =?us-ascii?Q?0J35TqTDBunutO+VyGMGhW7E1E1Zg3jIfo6i4XkJSESSX+9C3qY3DlwNrN6G?=
 =?us-ascii?Q?9JfaIa0Zri2pLL0u+bB67FZ2gLhCiP0c9o26yj95MWA9nSDRyNMgXKtxoKSW?=
 =?us-ascii?Q?Wdttn/l1BE2uJnZoYYvhj1/Zt2ml7wJEJrx3j5PcHghF+GZX3KDve/Vv2P54?=
 =?us-ascii?Q?ZdZmNdpFOKHGH6Spz482FKSKsVILR/3YJf/hfcxzqjJnxWPRMwiJhNmWEafd?=
 =?us-ascii?Q?JAwWnLSHvzojkv+Yj4pkHJJM1D3ggxvNs2p0xWwY555o2JoDfmWQpHMvoYJX?=
 =?us-ascii?Q?f3hmDXBivZckqkpQS59taIN/q0ibN7gWmf8tDB3LJ+6QQSJLjp4NtIW1WCcX?=
 =?us-ascii?Q?obSyiLzDOQRcoVCCwJeoNmDoFwtRg8gcQ51w5hy5Wh746gq8YoxpQc369kY0?=
 =?us-ascii?Q?ma0df8VoVRDDCe0l5BZh5Ox9IIR9aCb3bRQ9xg3lAh48KSn/FGnlk8v4HJNx?=
 =?us-ascii?Q?DDe816iBTo9zczJTFYeo6HC833x/fNa9L5OUFFIA5JYshk3Hsf+B2fhDz0Ed?=
 =?us-ascii?Q?NgwcHnAyHquXzYTIpPkPpMuOXCHOWsFv6UDmkpQNVOicIz4NSEwUcOlXG9Go?=
 =?us-ascii?Q?/XNFifvbKJPrbbd0orXNsIJsGMZAy2mVtg29kXdiUycugrkZECQjcLfwVYEv?=
 =?us-ascii?Q?ZA3k5gR1taw1o0I/wmvmO3wKBxkTglHtd6+DCFxZVWfalXC8pF7NQ7jyzE3S?=
 =?us-ascii?Q?9pPcB088fhpzeDe6mYkAsDAOg2cRkiUIB/STHiy8lF237DvRTfyYPywpKeXE?=
 =?us-ascii?Q?mp7xxMMsgfBug/3E5BbGfFDAC5l6br0xJhPjB8P04xketd9bFrlTTN4n4Iy4?=
 =?us-ascii?Q?9Yjz/6427ksFHfQkkGFomfDVu5nr1P/bs/uBbIr7tGu9n/UpKpUpI1YrLy7y?=
 =?us-ascii?Q?KsJ1FzVzzVAREcO5/kjiQCpkYFY3JZH5giXGUYeCbe5tXJoHo1yogsgzcriZ?=
 =?us-ascii?Q?gJrZoDvc5csULyw9qu1VsaJ1h7sm0LcWawrB0wARybuqoL/nXHFtkTaO4Ixl?=
 =?us-ascii?Q?x4Ux/Q6gmYmH19MzVBkb6at8t+NxbQLBrwIKjYsE7WbV2Zskztzie5HnXq9D?=
 =?us-ascii?Q?0FZV4y5ZrRAkb5h0ra1AmasI/rFv873UAVDbgvu3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mi63zR4CFcpNTdN2t/uZO3JSK6byVLZ+dkOK0qP7v0Ohgi9aqv5x4u2iCG75?=
 =?us-ascii?Q?VUKrwpCRPS+Vk48XJHq+z9KdGOGSaVo2DcSRn6/H47bF+TYQbisTOrYr37yq?=
 =?us-ascii?Q?Fu2PgjCUxMsJG5OIqlA6sjkvllr2hAzBRond8j3dOexrDiENfqQ8qSpYo90K?=
 =?us-ascii?Q?a0XCXdfh7f7ov5Mc4T4f3/8DWcGylN+L2kOG6yfLZ6+xENAXbKXx/E1N9tBH?=
 =?us-ascii?Q?d9GWVtiTrhdDayIvOj2kqUkz1JMRpQ4JGci/8rJywZVDp2QTCrxI0Dp42gxv?=
 =?us-ascii?Q?Tcxl45gvfkRjKzM7dOmfqmpwzY+Sr7/1npJ5oK+i7OK0DbDemzxB003KvMnM?=
 =?us-ascii?Q?ZkJQmQAjPE9y72SSCjHVGBU0Dswe5zE4Y65613mt06IZ+6PO4jTS5Hvt/aVC?=
 =?us-ascii?Q?iexpU9ulxlGVRPgF3malD1thwwb6kjVL8LZornZNK1CtgcqcZqMhULMaz+rQ?=
 =?us-ascii?Q?e+qgOLAJrVEaZz8Gk1PBgeRJV31gGk1OIeagYCh1FQ4MxXW8QIB8KbRwaWnO?=
 =?us-ascii?Q?anKvlgXD7YbFRvtBUwueHgngenCEguKobqxAZnAjzN/pK3+cj772YYylFFp/?=
 =?us-ascii?Q?utVrarWNrLdf9unpijI2l66nipdnQChF419TcVzV/uO3bY1j9djiNgwtNphl?=
 =?us-ascii?Q?S+SY1v+29492QJUfoTAYGrPJeFPGXryGwElWFKgQigDUKZYU6pPCxggfHfYF?=
 =?us-ascii?Q?xVMtzuLv99wEaLv62YoLWXl0febrvIVUwzenir9QY3n7KrpYle9Pg0etZjY2?=
 =?us-ascii?Q?DTFt9fdoRFPU5zqyw0LCfi8o6dY+hU7szFGsHEVVEXrVMg2pZXG7eBKDqjez?=
 =?us-ascii?Q?k9ajxW5B4huc2i/gYhhOul8OnpQmfo+r/RVIiKN2A0SP4FBQYlzFhg4EWSgA?=
 =?us-ascii?Q?EcuxdPHFvkpvjpk2OzgL3/V4Cq8MpUkJLVZPWgxLz6ijIbqzUZqEcRQNyhXw?=
 =?us-ascii?Q?NkHT7jGq/bp/cJBFNXe5Fm2tol+LjzHI5n0sAmPhqeo6FOxfTfTH/V9wH4+H?=
 =?us-ascii?Q?Ni26bbidUeLncFHDfKXmEwUrlQUvWQfWHq42MJqNu9Mlp7neJkfuQZuGzOn+?=
 =?us-ascii?Q?jPRra4lQNL73pwiw3JzQeZ/UHri3RskjsPzTpNV73W7w60ILYQ0AIcXTo/Un?=
 =?us-ascii?Q?8eNYIg16KST+nhkfnUZiLaYbVG8MxenOK/anKWhVS0WR5pbP+60N6BwnOwrp?=
 =?us-ascii?Q?WrHDWKkVakl2W7UNNBhcA8Zoy8/A6S8VpiHoRPfsD1ML8FGv5TApvAbqUV8T?=
 =?us-ascii?Q?3Mmr9gxAD3u6309S6xXoytkVTopQcA7XqAGR4aFR8KQT0Ve4hf8RsMmnB1vw?=
 =?us-ascii?Q?T+YMajwntrkY3bjicQjcH6YsV+btmXLzec/spqkUE9ZPyqdbl6YopTdTGBdd?=
 =?us-ascii?Q?01zXZrxF8Jp5R19bhF4aASw48ocIu4nR2yZhkGVaRsLA0W2wEvmTMmtNAk7J?=
 =?us-ascii?Q?XUIPsw7ElBygJ6yiZlotdFRC2ogeCtp7TTBLQHkVxGLo9c0ez+09pciCdOUB?=
 =?us-ascii?Q?hWUA69ZYojwo5qRC5dBbNPA7Jm8H1djL2pRmbwmYHl9axq8R5Kd9pENIGSla?=
 =?us-ascii?Q?EfHjKGZakZEUP8HEkW8Me4VRyHWQz6j8h8nSSDWLf7x7d+MRPLGAjw846uXj?=
 =?us-ascii?Q?dxQ+gRHq4T2Cn8Mmi+T7Cs2DJvD8oB2RE9guFip17nyKW6bUMNA3ZD1beA8V?=
 =?us-ascii?Q?9OD9vk6YVLj9zaUfwzeUF+/+5CuYtIfstqaegk5g4EP0ktMeO6+y1eE3fOoK?=
 =?us-ascii?Q?UIoA2Xxo7w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70af9ff5-d070-4403-5d71-08de6333f8df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 14:53:20.4824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uk2Ug6AT2k6R/VSJ70PmlRoJEpfawNRoTBN2Tisj4agjErR567PFFjJInWMSlTYnGCg7XfdXgSuTBz0hebNRVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11805
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

Hi Tom,

Please pull mmc-for-2026.04-rc2

--------------------------------
Add DMA support for mediatek mmc
Cleanup mmc cmd
Fix typos in mmc
--------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/29179

Thanks,
Peng

The following changes since commit 1de103fc29761fa729dffaa15d0cfb2766be05e4:

  Merge patch series "m68k: Add support for QEMU virt machine" (2026-02-02 14:25:48 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-for-2026.04-rc2

for you to fetch changes up to b4f0479e076014f403319fdce53c5c1ac278f8ae:

  cmd: mmc: Return symbolic value when part switching fails in mmc dev (2026-02-03 22:11:46 +0800)

----------------------------------------------------------------
David Lechner (2):
      mmc: mtk-sd: use GENMASK and FIELD macros
      mmc: mtk-sd: fix misaligned brace

Tanmay Kathpalia (1):
      mmc: Fix typos in comments and debug messages

Yao Zi (3):
      cmd: mmc: Simplify dev subcommand handling
      cmd: mmc: Check whether arguments are valid numbers in dev subcommand
      cmd: mmc: Return symbolic value when part switching fails in mmc dev

ht.lin (1):
      mmc: mediatek: add DMA mode support

 cmd/mmc.c            |  55 +++---
 drivers/mmc/mmc.c    |   6 +-
 drivers/mmc/mtk-sd.c | 519 +++++++++++++++++++++++++++++----------------------
 3 files changed, 336 insertions(+), 244 deletions(-)
