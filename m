Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7163C7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 07:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DF4F82103;
	Wed,  2 Jul 2025 09:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="VBzRZ0uE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0495082EB8; Wed,  2 Jul 2025 09:44:21 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A69878206E
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 09:44:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKpgOFRPvC4NPlKjqo984LWLCKh8aRTDR9GOEvtfT0cHD9YqnZzOphIdscKsWprKHs2srGyjp6zntWY6Bdfl+YJ18t28EsAevj0uBbWkT/c8gBcTFSrdYGCGjq/CUQF2oUAQWE7MMv3kUBVv25Kxci54wEjm1uPpucPld2UsZV+9hZLZ1uHHQiX28SiNGE58eEGI+4KrQc1k/1kEyERl693w/Z8TUK78zq8vFXJR10fsFgiHfe+qEIqDe1YDU70IpHmGCfGEGknK9FT7GYo+wPiXSkKT2iovYIKx/VHizGMqH6WaADr15HNCSfRL0tjFSKbdc1p/AIjWDUwGB84/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEck8BfJK+/Zi5xirXuURvIZOOqk52NQL65FKjiyuS8=;
 b=TJSxh5pqACP/2Hc47ZlyD4Nv4xf5fWuIhwbX1+o1MoKV8z778H6RVUDUIMTCZuCMzGnr9mStgQCW6eLo2d7JAaG4SU+gxS3M6Sp6ONq8SwucdyXGMGlpcHWQUWGEzzEAkLEPGjXGYWxb7wEt1XbsPUlvrzMEZRT2gwWWMa9fqU6UwsBudji873Xt4x9mDlLyD124Z7Au+lWNGtyVhSM09UsCRYCpvSeBZ4I6hLwv9K+jK44cbwVm9bgsijqUAYrIhQrt0ibS9v0B26sfMp9hm7DzRdd2zTGy7QmXPHRsJDVpGlja/RBdtBY2Zf5KYc6s/Z2yUYTT2JaEPE+9UCJA4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEck8BfJK+/Zi5xirXuURvIZOOqk52NQL65FKjiyuS8=;
 b=VBzRZ0uEYY7ALXbfU0udeKjs8YnIhE/zhkHXOIZt4h/S+Q47ofUXeQGifnSOkh1lpxRkPnZ2ax2e5FBcRFq5+eam9YdIo9p9DSJ/dZ7xJ1AKNEexncU7p7gIzpgyZVOBbf75z2Oxd/1op1ZUzAdalSw2ymoR62DPeCEhj/NxdJ4Q1QoJAquZ6z5LgqK6FFuFKVY5jOaVlvCArHWs3qq06tKAW5hgrjh6yQYMp7VS1pG6RPL7fNiiMufb7kizuW4tndr+q09895quSLTmhbVAN1QMusfNrPMNI+xtNfLUKeTlOrYGwxgaQeTxzbm2OEGsamoChDDD0/QE2tYrewJ/QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8341.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Wed, 2 Jul
 2025 07:44:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 07:44:17 +0000
Date: Wed, 2 Jul 2025 16:54:57 +0800
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull mmc-next-2025-07-02
Message-ID: <20250702085456.GA27006@nxa18884-linux>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa10f0d-d1c1-4e77-14cf-08ddb93c3f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nxgLcZsaDiZv5L3xYaiJJr2PAg+JtPEqmuhvgrt3vsTkOVPvA0DEWcCe5uNk?=
 =?us-ascii?Q?c3VxCT6F+WX9T0pUlLYSaJj2utNPx1AcHxuLS77oIbYAHi9zVP9Lvg7L2n+x?=
 =?us-ascii?Q?93WLBshnWGK9GtE1Yki3OeOb34ZoLE2raL4vaplJKDCIpEORSdp9MnqcZeMA?=
 =?us-ascii?Q?2Ly7PXlwaecKEqaolLwMV3N7VThsph9Gq7/1jXswb2Fct1oidnxkO0kyecPF?=
 =?us-ascii?Q?4FgDC2odpjItVH6VPRFj4J/FTsF3L6Lz7dOfXK1GVgVQOI/WTptaclW056Qe?=
 =?us-ascii?Q?C4eiY5FzK3rJf3Lp9BKtbpdj93fk1QmeGtCt6RB381IdV49NdHv6xJXWWZwF?=
 =?us-ascii?Q?NeabIKCvJApwrZclnp4IZvjS4SJMlTomb2jCOuv1kSfi2yCG9lEegOHdT7m2?=
 =?us-ascii?Q?WKKh42xcOnfbwfIyyOtGx/oUhPb7SBgrJVIpG2JDCPKuWWqapJN+DXNQO0yU?=
 =?us-ascii?Q?gTsAGaLI2j400l0w+oGZOKCjCLS9zz7BDsOsqL9J1DJJBkzzu7sIiyvVdj4H?=
 =?us-ascii?Q?Dr96VaxGB5zQwMozKYT4IYn/ob0vDo+36zJ9HogaeDuxcW+Fh2c/sPze0K+L?=
 =?us-ascii?Q?cbWAUGdHIBNSSP5/eJgarzy+0e/DEItcHtKBAiBBdY2R4VKhMrIJoR9iIW0u?=
 =?us-ascii?Q?XkuR01m6rQP5+urEFKXoq1hrvIj0YdL72aBxt680DKpLhruUIciJKULlnTQf?=
 =?us-ascii?Q?jFwP6APkvQFcfS0FP7TblBc6KkluQZwoNYAs3k1/NALorGE2IkwZC3hYbrJF?=
 =?us-ascii?Q?ga1QWLK47qQLtCo5JVsoNMOAbvoot43+s27iJ7Nbwub7lK5UkSv+JMwOh7R0?=
 =?us-ascii?Q?sR893OK+XP/j4DgAujfuee+TM6eNDnJFHuU/mXLrdbqP9PrwnBXL+QmntLG+?=
 =?us-ascii?Q?omWLX2qUE3T4LP0TFBznRW9s3ljt4mKhL2ModnMusPx3nw68goXCNOCO5/ao?=
 =?us-ascii?Q?B8hf9FLmyyGhZj/Beb9mQKOXRjxcL2tm0cIWN84/WKq9R7M8aNCILzRhK48J?=
 =?us-ascii?Q?ks3tT67OV77na9AYhcqrhaZp32JMHLSkser+NuZMf6korfT19g1ihkUYBdf2?=
 =?us-ascii?Q?EkciRbzPMwjNzH2ky2ZpU4bPD1unABPtEjRJbbyO6SRXlZcXVkyUqhjdrgoM?=
 =?us-ascii?Q?mfo1OixvPuyGDNVhYeC7Wc+EXACpf4V8I7Vf1mFvfT71tusvik4ZuKs7RGd5?=
 =?us-ascii?Q?9w1oQAgi5lmu7SesfGx0UfeqhfFDTrzm6F55HSFLq5JApLR5Gif/fy8H31Rd?=
 =?us-ascii?Q?hlR7e8LX20ub3azyGdEt646wVRDgkoXltiqEyvRV8vV7zik3iv4Mxf6Ms3Gs?=
 =?us-ascii?Q?WP+YxiEzfllGmRslRvVhaXs2Rt6ow5/CBSGZ8/71aVC6jM0FNSfdXpe/TMne?=
 =?us-ascii?Q?MM+7k7PBXHCQlk+hYI5yWXy5xxUyHkh295upsKC4KqEQHj7QIFmh4MyVPWTK?=
 =?us-ascii?Q?ZuWfo7UMrfQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DSR9GUfnSQ3Gmg0gOQ+Gnej8hQ4SqC5U9RtuzlW5bpdUEHqh+/VgoRUm4wTH?=
 =?us-ascii?Q?WlBUQCrSFL+FlReQUmD7G0stj/owY5cQzlkqPZi6d17R8nl7xzdtE1H/g9xp?=
 =?us-ascii?Q?/AkmCVp32ibHEv9U7SJ7QpXC4pBbPK1f5XznSZkMcjIdV4VOeWf+nDEr1H1L?=
 =?us-ascii?Q?NePpHG0CzloVLAzRvj9BCCsw7esLv6ftbrkcETYBbq3+BxNL3WI1qLCScBL1?=
 =?us-ascii?Q?I8kMg46wdRYcnVrHv+T8Wlo6yG9S56xM2hwQU/pUAcsdwaGB3+diew273SKV?=
 =?us-ascii?Q?qPficmnk9XbYeE41LEkbMwL8vHeEAZxSi3vt5LyHKS3iBscdcbj+AipCqR63?=
 =?us-ascii?Q?ylvVe4SlJuA01TP6XwEXWPgBNZWQAVjIVJumUcNcsGfjtVaYxeiBdE3v2RfB?=
 =?us-ascii?Q?K41h+egVge4FVZhK3RQX5vmv9NK7ejCOYLd1AKQXPPiQzpj8GrEB1hAzhh/8?=
 =?us-ascii?Q?iDLVk0bEIyZuu1VttdUSeXn9PAety3ATYogsyJns8kg/y/NuOeKnvYPDAA3X?=
 =?us-ascii?Q?P/hqkV+wiWuVuPqKr89YlFvGJx+U4O7G3We2bD7q0JraTuBnjfWuVHBYXV8q?=
 =?us-ascii?Q?PGuPX/Tl8z3QkZgnxyUfh8IlBDVSsJxXlxDQ8Esmz11QOW6mHo3gEu7PrL9u?=
 =?us-ascii?Q?n4Jpx7uLc1r3trjEZlgQZ6A2zqQjKd83h9IgSe2uaYkG6jQmY2H+8uOVP6lT?=
 =?us-ascii?Q?7yg4yKYiYn9kIENxDAaYIcooFnU4ILgfFkckgm7n81SZ4B3KoxTLs0+aeob6?=
 =?us-ascii?Q?sL7lMET0oBhuO6btBnx52Vr6+EWoA8o5Lwn+JBfbznqGI5M3pBBTWD1ah/z2?=
 =?us-ascii?Q?8gqO/yi20Qqepbu0gNrxO2hErh0DoMCYKTe8fQL5EzLTchuD8GxA8oJ6Iijv?=
 =?us-ascii?Q?ROvFrmPDEWYuSCMJ/RgiMiEkZNvhI/xwCLYOe6BURwLq4BKl0KnzipTyLkhU?=
 =?us-ascii?Q?RBiawOC9a0MWpbanbqOvhz6aGWMRtqJJo3+KLghC2hCo+eVk22EVXwqDNcS9?=
 =?us-ascii?Q?+WdzMh8RY26bruDSJGbIC3+R/qnDbP/VtHehHuXrkFxnl9kq2kZalNpBswe0?=
 =?us-ascii?Q?ZCgyFZY4Z9cxj2rWVECvyhlgU6D5Q93Zi8zIuFkjZZIxzO+Nl6PbKpWbRbcs?=
 =?us-ascii?Q?ukX5BB3CbY6xHXAzuFY1G83ftnDR9Ke4V04R+aJA/ErpFxJpe6zddtHfHKEN?=
 =?us-ascii?Q?3ua98rJJIsKS83ya3JJkbz4Aq13neOUrbdno/zxhyEoWLiux/g6YPtpc73OM?=
 =?us-ascii?Q?aILH8+56qZ1yFMgs/mnY605R7v16zb19Bamwvyi403H1iUoKecqSwF1tLwOg?=
 =?us-ascii?Q?rCk7F/A7f5PN8EMgtqgCTnasP4xNXYsMU9DunwJb/QJaroF0b/C86gy1wEPQ?=
 =?us-ascii?Q?I95vW9KOUA3WHgW/VXLOwUSRQ/lKtMgUN4EYFpvn9KFOwjgiyG2oFmzhF3Sh?=
 =?us-ascii?Q?r2GUCKgLTjuoymOwa3s+3Tg9TieDU+f1J/OcM7xPVvbb6nILHMfNZ9z7qxgF?=
 =?us-ascii?Q?R6/FiYdSkFVlVn56OUsdVE4VC2PuqLn4aGnDlBX2ONTTenrvDFsKqYNhrTMF?=
 =?us-ascii?Q?qst1pZCkKGo+l/Cy8txVwkX6QmdomUCMQtdCqshz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa10f0d-d1c1-4e77-14cf-08ddb93c3f7c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 07:44:17.1665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JoHkbZ8bgeMEe0p78wY8KPER3RGUsryIP9LVpDoyYZOBCP++i0o3kmlMXYrA1ehWzfxLMZ6g8N09IDXuoMGItw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8341
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

Please pull mmc-next-2025-07-02

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/26911

-----------------------------------------------------------
Get clock manager address via DT for socfpga_dw_mmc
Revert "drivers: mmc: rpmb: Use R1 response"
Fix offsets relative to the end of the partition for mmc env
------------------------------------------------------------

Thanks,
Peng

The following changes since commit cbb5672790d400e9ec6e9fceaf89ece2660c0117:

  Merge patch series "binman: properly error out if path provided to key-name-hint in signature nodes" (2025-07-01 10:52:04 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-next-2025-07-02

for you to fetch changes up to be7fc8f331d5da68f54a241f08206e49236649d9:

  mmc: socfpga_dw_mmc: Retrieve clock manager address via DT (2025-07-02 12:47:18 +0800)

----------------------------------------------------------------
Alif Zakuan Yuslaimi (1):
      mmc: socfpga_dw_mmc: Retrieve clock manager address via DT

Jan Kiszka (1):
      Revert "drivers: mmc: rpmb: Use R1 response"

Michael Walle (1):
      env: mmc: fix offsets relative to the end of the partition

 drivers/mmc/rpmb.c           |  6 +-----
 drivers/mmc/socfpga_dw_mmc.c | 22 ++++++++++++++++++----
 env/Kconfig                  | 42 +++++++++++++++++++++++++-----------------
 env/mmc.c                    |  8 ++++++++
 4 files changed, 52 insertions(+), 26 deletions(-)
