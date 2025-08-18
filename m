Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A3ECA0EC6
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:09:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57265830C0;
	Mon, 18 Aug 2025 12:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="MCFHQ2wR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 868EF82998; Mon, 18 Aug 2025 12:06:52 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D27182BA7
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzfdpwLrqNnbbfPXnczAotKHuEVek4IoJ0CmcTuljPgXIIuk5Cp9dzkF8SEpMAqCe0vWxEvo3PiPmp537IlCBe5kC/eb8ivpJNQ7q30FR+B9estGCbQyK2NznEIxcUHN83zAk93filttOnPJz3k3L7dFNU3N2V2UsImgbvCtj0kFNbD7mPiPc78oxzzbs8sId5zDB5e2KRCO59Ff/0w/mGxw1jZpqroRGTvTAGvIJOv0f0RXECWZngUwdj8IIL8eHv/4uRBzSz0LK9Ei2IfhbZC+xAIaG3wjymUiE22R/vOdjor+17/2O7eGie2sBll+VOygR+GKzY4Vj96huVDR2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEz35CzUIarl2Hgyi/VN7YYHGjdDc5XuyAjgqR5LFAc=;
 b=LshoGSeuYIOIG2R/IGoB5ltdV9X6b6jFvdvk81Cu/nSBp1rweuPin0pDqqbotDqk6cUin0i9JN6G3lIUcoSFRlaaQv3M0OljtCjCxlNPu+/7gyFkXyj9fGjVMmApVVqqEliJ0cCyfh76QkN03oO52p54JtWChmUFZSznX2NsLngyEu+kHJi1SHiGEfYi45ZSGg34nJ5jCpeBaRsgOz/2IstNDgdg1qDPwlBVGPuloz8j5Iqc12lPqGbYJtmORevtjWJnuTPS1z6BuIRQxbTU9OrNRqbYwzgAbgsUOfUU9g5jKUZ1qYSGfROCihjdcHrzpMkmxgMEjlJkvEmeLx+Z7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEz35CzUIarl2Hgyi/VN7YYHGjdDc5XuyAjgqR5LFAc=;
 b=MCFHQ2wRjoEZ5Cxm0W5k7c3kgm78UymWbk//Kup8OBfPem5kzKr1AVI67PV52AvcT6bH7sKcUqcFmk4twnSoZkm4MM/eK76S8gVFSgoGgSifkhu94UfnIoS4J4WpT9vcnihLiwKtwGkLo+T4bCYGlOm7aAMQAMCFD+CTVXcSTtGIdA5pny8epwi8NzyNxK+AqddUnLJ58h3XbgX8buKM96IvB1fShjDrXACT9afBmuSQGG4/Mo41Q6ntmKvH9sNhcwt6fFj5EiIt4IIIyuOUztexKfRSk8YGMbVERU6+NKURtxJCmCfraKVFBDkO3Y/8HzNzUV7fUAnWpB/L7cyNrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9719.eurprd08.prod.outlook.com (2603:10a6:20b:615::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:06:46 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:06:46 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v6 15/21] mtd: spinand: add support of continuous reading mode
Date: Mon, 18 Aug 2025 13:06:07 +0300
Message-ID: <20250818100614.432931-16-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E2E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd20f7a-960c-46fc-da18-08ddde3ef0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nr27ET3Nf91CuDNFgU0EVANFh1FZk133pkigtXZoOYGrknzzexm/KjtxJiNY?=
 =?us-ascii?Q?IQpYb5MB8RHl2xxP6G+j2wmiVUr2c5ut0YAgasD6FxjP1ZLq9Ik6cOIpf/YU?=
 =?us-ascii?Q?CMXayMX/hyqoT96j7GqyKosiOl0IcfmfBIWI0hWLC6SdN69kPkxqALhdokk5?=
 =?us-ascii?Q?NBB0815lH8P+kNYOmii6rgoffwBC5BXpgbQry6+PK94lWKfnqRsb1AglO390?=
 =?us-ascii?Q?uVHf4Q+BWqDwREVeq09BSv1w81KzyS8MB3COZ1zMdvcOisSWaTWSAgxsVGEb?=
 =?us-ascii?Q?t2uLOzihg08OH3juYpsyWFHbRUhmKzq67L1vmVg6sHnc+jYm/5GfY3pWAZ2m?=
 =?us-ascii?Q?Hn/YKZvcXTAevzORadTweEGa3knye3XMeFuLLVNgcg5j/2eWcjCmg3bMsgqq?=
 =?us-ascii?Q?vzwTafk1I/T0bNvFJe6RPjCccil2ZjCfQEZkqcJkIGuaqwpF0r/Lt7/86ApX?=
 =?us-ascii?Q?rofGh2KKGKOH8OdOeMYsalsJo7OC+wzOzwCYN/L8NsHbyzeH3qZupvL6jiBs?=
 =?us-ascii?Q?SDjuAiiPmAXC9Pn42bJ6pRJ6vESH43R+QZoQPem8AhqSfl9o8Tvjq0U+B+yC?=
 =?us-ascii?Q?oI61y7X4530rOGgiqlTBQu2lnRQdh7fHFKhjDo0K/R2ikjd7rcTXSDvXeRAF?=
 =?us-ascii?Q?3CzlBY3NvYzMEbru84JAaoXszIO+za4/wZbB6W9OkkcC+ewVtCMCRnDyoh0Z?=
 =?us-ascii?Q?NOFT6jghYSI3Grz5xbPss8oLb0iZdjvmqfSaFyJVtrLJWeM+T3sywvDK8MAa?=
 =?us-ascii?Q?WYE5Q3cxRAupKjPi+E0qs2QFWFf9QvuoucBhOWshQrLnaYFLaZLNgh1xI+/u?=
 =?us-ascii?Q?G+OTtsXORECcKo8agchuNoOqEhSJvDP3T0SKVV9aBvRy3Zo5L0qhVp97vcNg?=
 =?us-ascii?Q?PAb30pEb4ck1dcocnxa+Z4d9VS0boXEnZyxfHFgxxyBWZZkoZCRiJKkShi5q?=
 =?us-ascii?Q?T3YU6VK9HRDh23DbeenyMa8rbeByKDZJxJK5zRU+4RDcQkDd5Xvg6Nn3kqGA?=
 =?us-ascii?Q?Xeaxk7u/eeCm4xIunVyZE7IVmc12xaDwyLvNVKBk8GsfefGhOnPpLySUYrHZ?=
 =?us-ascii?Q?c8m/6+l4pew62bpiI+Lx2Y68YQHQf8wmT1I1nR7cU+tl2N+nKN4mn93a6H8g?=
 =?us-ascii?Q?nRyG2uvF3tHLch0h+dDIlYVSk4t1rtDTqqGU80BUm4sWEPPqJXiP2m79JmZO?=
 =?us-ascii?Q?4O9Ysr6Em5qhAYuln466ELNxL48xQCs5oGfxaZuiT1B2b5QBijYnyWOSTcsx?=
 =?us-ascii?Q?ldGwEaqrVzuicNg1Fy+//0uAHEbc95CoSOlHo6UaHQg4zkVJG0wECRyVG/rF?=
 =?us-ascii?Q?JoZXD2fb/QX+vLPoMrBMrnQ+Vn0Mdp9pZsDFKTF/H5ZqHyU5wsO92g8ZH7Su?=
 =?us-ascii?Q?2ETDAoFgwOmRBP3aRefKweejDJurvbBQ/pEVjiRn7YazIgnajfgvBvvIlT1h?=
 =?us-ascii?Q?bGaiAkbItB7gfH7udv1dSaMo9Bl6UDWECSICYVzEBv3a12ocBCjYkR8FS2t1?=
 =?us-ascii?Q?+LsHHdLN4EV2um0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lUQyTrKwNyeiD1lUKPAB3ufa7xv2viBCJJjd1bR3Ug8O0MIHM+f5hh8K18Lo?=
 =?us-ascii?Q?kBCdRMl1iMhCercOyzBDMDHCel0/f7zP6o9JXuW1mO5aeo8Yg011k+M0LQ2o?=
 =?us-ascii?Q?wIfRNv0JgNkOXaiLXYU69HpYCsnCMnaQzMgURC2E6fE3/fnbgNi4eTNopjlX?=
 =?us-ascii?Q?lcMXC+TEqJ4gC6OcWH+vf0WJNLDtgcBfVgyCfhcgmbVhXTDLbxu+7JYg1TH8?=
 =?us-ascii?Q?CUF1Bv0uYsYA9obS+sd6uHKDEHyhi9W8mCE3fzOYo9qZe1Yzd7MVhakBwCFV?=
 =?us-ascii?Q?H1sfSPVoUCM+ji4TEAqAcP/hFiUSbnJCOU2l0RFsmgNu6FvgeIxFYcXS1YxA?=
 =?us-ascii?Q?ewhtK6WiMBf8DC6xi9irPpQFfwPIr/Hokli8zfLxkmmkbDq++kz20K3vO0gO?=
 =?us-ascii?Q?koR0EHpUE6YlO1agyzizre7474WQIiw50H2NEdOpuxPOVTT1EtG/L3rBD3e9?=
 =?us-ascii?Q?Kf8VvbOmZHGtdqp5LfTn3O5eEvC0C9IrmnbFeDNKOVTZEREzJUa6/GEoPp5+?=
 =?us-ascii?Q?h5hdauTtPfq1KFPplv7TKJD4XQPcHX6XUS39q+EQRXZJ/QI9EqdSyc12bbVh?=
 =?us-ascii?Q?pXrPKefY6aKJG+VylqR3dOlHdciHXIt8UcY90RKua+30lDzGBhAau804nAo3?=
 =?us-ascii?Q?7KxzjfIelGjY3JLNVSZT+oIGoM/sPN+yNESXtphE86vS4nicWk2C7/8p/Gjy?=
 =?us-ascii?Q?EVGm1KX/ka/6ePGx84d6MXAUp7FIryQdhxyYaKUqq4FrBsJkM34BTxEocRhe?=
 =?us-ascii?Q?3fmDn15PmBnwdiFpRLI3DFXtw/bywpfsEb9c6GxTwX9A4Kl7KQ/nW3j6U1/s?=
 =?us-ascii?Q?nhB5D7lYXUjO0zYlNfDY61wBCqF1M6cMsa2ORexp0TQOq1s8ZYu0vAOAacI2?=
 =?us-ascii?Q?5SkHifTSLHudofno6+Fxtf71xk9Jaku9HD9/3ryB1Desy8P6IT2E384/1kpK?=
 =?us-ascii?Q?9ZM/44BnTQNgQZZV3oaXbKJvSeU4us4ZT3SZivlX4LdqX+9LNnxWWFaD0/7R?=
 =?us-ascii?Q?brNMnTvA+LuDpMvxbDaj2BdTv3/kP17vQUf3LDhdsY5vnjH6qo8ABrmwlyR5?=
 =?us-ascii?Q?G9fYEtFpXmSV9DRkn3KFCi3YhvO/BqMLghdmjx91o2NgLDHhE8Byi65z4FLs?=
 =?us-ascii?Q?bYpRLDhGfVIdzDii0SrFtUyZgVBG+73RTZI7LIg+TxL48fwkJ9BUdvYCFoWU?=
 =?us-ascii?Q?Fng0E2Fbya3YNuqxPmJgKs5CL/eQkrdcS3p32grLzvd0YHcq1lTx66CuZj+J?=
 =?us-ascii?Q?EzoYh/kXDZV1OiNMYidzCpqsnTpBftBSQsFWr9p996zV5wxpJukrUBvuRodn?=
 =?us-ascii?Q?8Ech2qk0sglSL2msh2sQgF8uMP1PzqRzKY+trOjlS+TFcx0rhTAjsr7j7L4W?=
 =?us-ascii?Q?s5oXJ/63fzigL9p4z/9MspG3b652Qi3Vybmcj405oxIERKHu/CDua/BxpU+8?=
 =?us-ascii?Q?ZLAmKiawOBH2+iyh0E+LYtVm/Gr14wmWAaSt6cEWm3GQD3AkP2XXI2Gog49v?=
 =?us-ascii?Q?eYHWVK7UNajOREohmvGDFEwnAPNbdMjeAbVrgGHYXo9ZLbpxxyKzatMKwWfw?=
 =?us-ascii?Q?t39npY1TEod01HnnjUGb8t47NJdtKB6EklZMI5FLL5tq9zcA02n1CC4ku/y+?=
 =?us-ascii?Q?XZF5cpNmVP45GodhsEwQ3iY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd20f7a-960c-46fc-da18-08ddde3ef0bd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:06:46.7095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45MDrJlzlriS251oRvd5ofndkDVFU6LbnW4abh+Yff5Ls3nZrX654PbtV27O0rzhJw8oATpL08bmRAg8ux4Fje5mjexX5jxa9daApaN+DgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9719
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

The code was ported from linux-6.12. The original continuous reading
support was implemented by Miquel Raynal <miquel.raynal@bootlin.com>
in linux commit 631cfdd0520d (mtd: spi-nand: Add continuous read support).

Here is an original patch description:
--------------------------------------
A regular page read consist in:
- Asking one page of content from the NAND array to be loaded in the
  chip's SRAM,
- Waiting for the operation to be done,
- Retrieving the data (I/O phase) from the chip's SRAM.

When reading several sequential pages, the above operation is repeated
over and over. There is however a way to optimize these accesses, by
enabling continuous reads. The feature requires the NAND chip to have a
second internal SRAM area plus a bit of additional internal logic to
trigger another internal transfer between the NAND array and the second
SRAM area while the I/O phase is ongoing. Once the first I/O phase is
done, the host can continue reading more data, continuously, as the chip
will automatically switch to the second SRAM content (which has already
been loaded) and in turns trigger the next load into the first SRAM area
again.

From an instruction perspective, the command op-codes are different, but
the same cycles are required. The only difference is that after a
continuous read (which is stopped by a CS deassert), the host must
observe a delay of tRST. However, because there is no guarantee in Linux
regarding the actual state of the CS pin after a transfer (in order to
speed-up the next transfer if targeting the same device), it was
necessary to manually end the continuous read with a configuration
register write operation.

Continuous reads have two main drawbacks:
* They only work on full pages (column address ignored)
* Only the main data area is pulled, out-of-band bytes are not
  accessible. Said otherwise, the feature can only be useful with on-die
  ECC engines.

Performance wise, measures have been performed on a Zynq platform using
Macronix SPI-NAND controller with a Macronix chip (based on the
flash_speed tool modified for testing sequential reads):
- 1-1-1 mode: performances improved from +3% (2-pages) up to +10% after
              a dozen pages.
- 1-1-4 mode: performances improved from +15% (2-pages) up to +40% after
              a dozen pages.

This series is based on a previous work from Macronix engineer Jaime
Liao.
--------------------------------------

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 210 ++++++++++++++++++++++++++++++++----
 include/linux/mtd/nand.h    |  90 ++++++++++++++--
 include/linux/mtd/spinand.h |  19 +++-
 3 files changed, 291 insertions(+), 28 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index c04e82651fa..d4777ec7c8f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -222,6 +222,13 @@ static int spinand_ecc_enable(struct spinand_device *spinand,
 			       enable ? CFG_ECC_ENABLE : 0);
 }
 
+
+static int spinand_cont_read_enable(struct spinand_device *spinand,
+				    bool enable)
+{
+	return spinand->set_cont_read(spinand, enable);
+}
+
 static int spinand_check_ecc_status(struct spinand_device *spinand, u8 status)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
@@ -323,10 +330,22 @@ static int spinand_ondie_ecc_finish_io_req(struct nand_device *nand,
 
 	/* Finish a page read: check the status, report errors/bitflips */
 	ret = spinand_check_ecc_status(spinand, spinand->last_wait_status);
-	if (ret == -EBADMSG)
+	if (ret == -EBADMSG) {
 		mtd->ecc_stats.failed++;
-	else if (ret > 0)
-		mtd->ecc_stats.corrected += ret;
+	} else if (ret > 0) {
+		unsigned int pages;
+
+		/*
+		 * Continuous reads don't allow us to get the detail,
+		 * so we may exagerate the actual number of corrected bitflips.
+		 */
+		if (!req->continuous)
+			pages = 1;
+		else
+			pages = req->datalen / nanddev_page_size(nand);
+
+		mtd->ecc_stats.corrected += ret * pages;
+	}
 
 	return ret;
 }
@@ -368,7 +387,11 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 
 	if (req->datalen) {
 		buf = spinand->databuf;
-		nbytes = nanddev_page_size(nand);
+		if (!req->continuous)
+			nbytes = nanddev_page_size(nand);
+		else
+			nbytes = round_up(req->dataoffs + req->datalen,
+					  nanddev_page_size(nand));
 		column = 0;
 	}
 
@@ -399,6 +422,13 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		nbytes -= ret;
 		column += ret;
 		buf += ret;
+
+		/*
+		 * Dirmap accesses are allowed to toggle the CS.
+		 * Toggling the CS during a continuous read is forbidden.
+		 */
+		if (nbytes && req->continuous)
+			return -EIO;
 	}
 
 	if (req->datalen)
@@ -651,24 +681,20 @@ static int spinand_write_page(struct spinand_device *spinand,
 	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
 }
 
-static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
-			    struct mtd_oob_ops *ops)
+static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
+					 struct mtd_oob_ops *ops,
+					 unsigned int *max_bitflips)
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
-	unsigned int max_bitflips = 0;
 	struct nand_io_iter iter;
 	bool disable_ecc = false;
 	bool ecc_failed = false;
-	int ret = 0;
+	int ret;
 
-	if (ops->mode == MTD_OPS_RAW || !spinand->eccinfo.ooblayout)
+	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
 		disable_ecc = true;
 
-#ifndef __UBOOT__
-	mutex_lock(&spinand->lock);
-#endif
-
 	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
 		if (disable_ecc)
@@ -685,18 +711,152 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 		if (ret == -EBADMSG)
 			ecc_failed = true;
 		else
-			max_bitflips = max_t(unsigned int, max_bitflips, ret);
+			*max_bitflips = max_t(unsigned int, *max_bitflips, ret);
 
 		ret = 0;
 		ops->retlen += iter.req.datalen;
 		ops->oobretlen += iter.req.ooblen;
 	}
 
+	if (ecc_failed && !ret)
+		ret = -EBADMSG;
+
+	return ret;
+}
+
+static int spinand_mtd_continuous_page_read(struct mtd_info *mtd, loff_t from,
+					    struct mtd_oob_ops *ops,
+					    unsigned int *max_bitflips)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct nand_io_iter iter;
+	u8 status;
+	int ret;
+
+	ret = spinand_cont_read_enable(spinand, true);
+	if (ret)
+		return ret;
+
+	/*
+	 * The cache is divided into two halves. While one half of the cache has
+	 * the requested data, the other half is loaded with the next chunk of data.
+	 * Therefore, the host can read out the data continuously from page to page.
+	 * Each data read must be a multiple of 4-bytes and full pages should be read;
+	 * otherwise, the data output might get out of sequence from one read command
+	 * to another.
+	 */
+	nanddev_io_for_each_block(nand, NAND_PAGE_READ, from, ops, &iter) {
+		schedule();
+		ret = spinand_select_target(spinand, iter.req.pos.target);
+		if (ret)
+			goto end_cont_read;
+
+		ret = spinand_ondie_ecc_prepare_io_req(nand, &iter.req);
+		if (ret)
+			goto end_cont_read;
+
+		ret = spinand_load_page_op(spinand, &iter.req);
+		if (ret)
+			goto end_cont_read;
+
+		ret = spinand_wait(spinand, SPINAND_READ_INITIAL_DELAY_US,
+				   SPINAND_READ_POLL_DELAY_US, NULL);
+		if (ret < 0)
+			goto end_cont_read;
+
+		ret = spinand_read_from_cache_op(spinand, &iter.req);
+		if (ret)
+			goto end_cont_read;
+
+		ops->retlen += iter.req.datalen;
+
+		ret = spinand_read_status(spinand, &status);
+		if (ret)
+			goto end_cont_read;
+
+		spinand_ondie_ecc_save_status(nand, status);
+
+		ret = spinand_ondie_ecc_finish_io_req(nand, &iter.req);
+		if (ret < 0)
+			goto end_cont_read;
+
+		*max_bitflips = max_t(unsigned int, *max_bitflips, ret);
+		ret = 0;
+	}
+
+end_cont_read:
+	/*
+	 * Once all the data has been read out, the host can either pull CS#
+	 * high and wait for tRST or manually clear the bit in the configuration
+	 * register to terminate the continuous read operation. We have no
+	 * guarantee the SPI controller drivers will effectively deassert the CS
+	 * when we expect them to, so take the register based approach.
+	 */
+	spinand_cont_read_enable(spinand, false);
+
+	return ret;
+}
+
+static void spinand_cont_read_init(struct spinand_device *spinand)
+{
+	/* OOBs cannot be retrieved so external/on-host ECC engine won't work */
+	if (spinand->set_cont_read) {
+		spinand->cont_read_possible = true;
+	}
+}
+
+static bool spinand_use_cont_read(struct mtd_info *mtd, loff_t from,
+				  struct mtd_oob_ops *ops)
+{
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct spinand_device *spinand = nand_to_spinand(nand);
+	struct nand_pos start_pos, end_pos;
+
+	if (!spinand->cont_read_possible)
+		return false;
+
+	/* OOBs won't be retrieved */
+	if (ops->ooblen || ops->oobbuf)
+		return false;
+
+	nanddev_offs_to_pos(nand, from, &start_pos);
+	nanddev_offs_to_pos(nand, from + ops->len - 1, &end_pos);
+
+	/*
+	 * Continuous reads never cross LUN boundaries. Some devices don't
+	 * support crossing planes boundaries. Some devices don't even support
+	 * crossing blocks boundaries. The common case being to read through UBI,
+	 * we will very rarely read two consequent blocks or more, so it is safer
+	 * and easier (can be improved) to only enable continuous reads when
+	 * reading within the same erase block.
+	 */
+	if (start_pos.target != end_pos.target ||
+	    start_pos.plane != end_pos.plane ||
+	    start_pos.eraseblock != end_pos.eraseblock)
+		return false;
+
+	return start_pos.page < end_pos.page;
+}
+
+static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
+			    struct mtd_oob_ops *ops)
+{
+	unsigned int max_bitflips = 0;
+	int ret;
+
+#ifndef __UBOOT__
+	mutex_lock(&spinand->lock);
+#endif
+
+	if (spinand_use_cont_read(mtd, from, ops))
+		ret = spinand_mtd_continuous_page_read(mtd, from, ops, &max_bitflips);
+	else
+		ret = spinand_mtd_regular_page_read(mtd, from, ops, &max_bitflips);
+
 #ifndef __UBOOT__
 	mutex_unlock(&spinand->lock);
 #endif
-	if (ecc_failed && !ret)
-		ret = -EBADMSG;
 
 	return ret ? ret : max_bitflips;
 }
@@ -833,6 +993,7 @@ static int spinand_mtd_block_markbad(struct mtd_info *mtd, loff_t offs)
 #ifndef __UBOOT__
 	mutex_unlock(&spinand->lock);
 #endif
+
 	return ret;
 }
 
@@ -858,6 +1019,7 @@ static int spinand_erase(struct nand_device *nand, const struct nand_pos *pos)
 			   SPINAND_ERASE_INITIAL_DELAY_US,
 			   SPINAND_ERASE_POLL_DELAY_US,
 			   &status);
+
 	if (!ret && (status & STATUS_ERASE_FAILED))
 		ret = -EIO;
 
@@ -914,6 +1076,9 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	};
 	struct spi_mem_dirmap_desc *desc;
 
+	if (spinand->cont_read_possible)
+		info.length = nanddev_eraseblock_size(nand);
+
 	/* The plane number is passed in MSB just above the column address */
 	info.offset = plane << fls(nand->memorg.pagesize);
 
@@ -1143,6 +1308,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->flags = table[i].flags;
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
+		spinand->set_cont_read = table[i].set_cont_read;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.read_cache);
@@ -1268,9 +1434,8 @@ static int spinand_init(struct spinand_device *spinand)
 	 * may use this buffer for DMA access.
 	 * Memory allocated by devm_ does not guarantee DMA-safe alignment.
 	 */
-	spinand->databuf = kzalloc(nanddev_page_size(nand) +
-			       nanddev_per_page_oobsize(nand),
-			       GFP_KERNEL);
+	spinand->databuf = kzalloc(nanddev_eraseblock_size(nand),
+				   GFP_KERNEL);
 	if (!spinand->databuf) {
 		ret = -ENOMEM;
 		goto err_free_bufs;
@@ -1295,6 +1460,12 @@ static int spinand_init(struct spinand_device *spinand)
 	if (ret)
 		goto err_cleanup_nanddev;
 
+	/*
+	 * Continuous read can only be enabled with an on-die ECC engine, so the
+	 * ECC initialization must have happened previously.
+	 */
+	spinand_cont_read_init(spinand);
+
 	mtd->_read_oob = spinand_mtd_read;
 	mtd->_write_oob = spinand_mtd_write;
 	mtd->_block_isbad = spinand_mtd_block_isbad;
@@ -1342,6 +1513,7 @@ static void spinand_cleanup(struct spinand_device *spinand)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 
+	spinand_ondie_ecc_cleanup_ctx(nand);
 	nanddev_cleanup(nand);
 	spinand_manufacturer_cleanup(spinand);
 	kfree(spinand->databuf);
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 910ef56ed0c..9285edd5c4b 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -101,6 +101,8 @@ enum nand_page_io_req_type {
  * @ooblen: the number of OOB bytes to read from/write to this page
  * @oobbuf: buffer to store OOB data in or get OOB data from
  * @mode: one of the %MTD_OPS_XXX mode
+ * @continuous: no need to start over the operation at the end of each page, the
+ * NAND device will automatically prepare the next one
  *
  * This object is used to pass per-page I/O requests to NAND sub-layers. This
  * way all useful information are already formatted in a useful way and
@@ -123,6 +125,7 @@ struct nand_page_io_req {
 		void *in;
 	} oobbuf;
 	int mode;
+	bool continuous;
 };
 
 /**
@@ -638,19 +641,19 @@ static inline void nanddev_pos_next_page(struct nand_device *nand,
 }
 
 /**
- * nand_io_iter_init - Initialize a NAND I/O iterator
+ * nand_io_page_iter_init - Initialize a NAND I/O iterator
  * @nand: NAND device
  * @offs: absolute offset
  * @req: MTD request
  * @iter: NAND I/O iterator
  *
  * Initializes a NAND iterator based on the information passed by the MTD
- * layer.
+ * layer for page jumps.
  */
-static inline void nanddev_io_iter_init(struct nand_device *nand,
-					enum nand_page_io_req_type reqtype,
-					loff_t offs, struct mtd_oob_ops *req,
-					struct nand_io_iter *iter)
+static inline void nanddev_io_page_iter_init(struct nand_device *nand,
+					     enum nand_page_io_req_type reqtype,
+					     loff_t offs, struct mtd_oob_ops *req,
+					     struct nand_io_iter *iter)
 {
 	struct mtd_info *mtd = nanddev_to_mtd(nand);
 
@@ -669,6 +672,43 @@ static inline void nanddev_io_iter_init(struct nand_device *nand,
 	iter->req.ooblen = min_t(unsigned int,
 				 iter->oobbytes_per_page - iter->req.ooboffs,
 				 iter->oobleft);
+	iter->req.continuous = false;
+}
+
+/**
+ * nand_io_block_iter_init - Initialize a NAND I/O iterator
+ * @nand: NAND device
+ * @offs: absolute offset
+ * @req: MTD request
+ * @iter: NAND I/O iterator
+ *
+ * Initializes a NAND iterator based on the information passed by the MTD
+ * layer for block jumps (no OOB)
+ *
+ * In practice only reads may leverage this iterator.
+ */
+static inline void nanddev_io_block_iter_init(struct nand_device *nand,
+					      enum nand_page_io_req_type reqtype,
+					      loff_t offs, struct mtd_oob_ops *req,
+					      struct nand_io_iter *iter)
+{
+	unsigned int offs_in_eb;
+
+	iter->req.type = reqtype;
+	iter->req.mode = req->mode;
+	iter->req.dataoffs = nanddev_offs_to_pos(nand, offs, &iter->req.pos);
+	iter->req.ooboffs = 0;
+	iter->oobbytes_per_page = 0;
+	iter->dataleft = req->len;
+	iter->oobleft = 0;
+	iter->req.databuf.in = req->datbuf;
+	offs_in_eb = (nand->memorg.pagesize * iter->req.pos.page) + iter->req.dataoffs;
+	iter->req.datalen = min_t(unsigned int,
+				  nanddev_eraseblock_size(nand) - offs_in_eb,
+				  iter->dataleft);
+	iter->req.oobbuf.in = NULL;
+	iter->req.ooblen = 0;
+	iter->req.continuous = true;
 }
 
 /**
@@ -694,6 +734,25 @@ static inline void nanddev_io_iter_next_page(struct nand_device *nand,
 				 iter->oobleft);
 }
 
+/**
+ * nand_io_iter_next_block - Move to the next block
+ * @nand: NAND device
+ * @iter: NAND I/O iterator
+ *
+ * Updates the @iter to point to the next block.
+ * No OOB handling available.
+ */
+static inline void nanddev_io_iter_next_block(struct nand_device *nand,
+					      struct nand_io_iter *iter)
+{
+	nanddev_pos_next_eraseblock(nand, &iter->req.pos);
+	iter->dataleft -= iter->req.datalen;
+	iter->req.databuf.in += iter->req.datalen;
+	iter->req.dataoffs = 0;
+	iter->req.datalen = min_t(unsigned int, nanddev_eraseblock_size(nand),
+				  iter->dataleft);
+}
+
 /**
  * nand_io_iter_end - Should end iteration or not
  * @nand: NAND device
@@ -722,13 +781,28 @@ static inline bool nanddev_io_iter_end(struct nand_device *nand,
  * @req: MTD I/O request
  * @iter: NAND I/O iterator
  *
- * Should be used for iterate over pages that are contained in an MTD request.
+ * Should be used for iterating over pages that are contained in an MTD request.
  */
 #define nanddev_io_for_each_page(nand, type, start, req, iter)		\
-	for (nanddev_io_iter_init(nand, type, start, req, iter);	\
+	for (nanddev_io_page_iter_init(nand, type, start, req, iter);	\
 	     !nanddev_io_iter_end(nand, iter);				\
 	     nanddev_io_iter_next_page(nand, iter))
 
+/**
+ * nand_io_for_each_block - Iterate over all NAND pages contained in an MTD I/O
+ *			    request, one block at a time
+ * @nand: NAND device
+ * @start: start address to read/write from
+ * @req: MTD I/O request
+ * @iter: NAND I/O iterator
+ *
+ * Should be used for iterating over blocks that are contained in an MTD request.
+ */
+#define nanddev_io_for_each_block(nand, type, start, req, iter)		\
+	for (nanddev_io_block_iter_init(nand, type, start, req, iter);	\
+	     !nanddev_io_iter_end(nand, iter);				\
+	     nanddev_io_iter_next_block(nand, iter))
+
 bool nanddev_isbad(struct nand_device *nand, const struct nand_pos *pos);
 bool nanddev_isreserved(struct nand_device *nand, const struct nand_pos *pos);
 int nanddev_markbad(struct nand_device *nand, const struct nand_pos *pos);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 63626c9c27c..2f8212e4037 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -175,7 +175,7 @@
 struct spinand_op;
 struct spinand_device;
 
-#define SPINAND_MAX_ID_LEN	4
+#define SPINAND_MAX_ID_LEN	5
 /*
  * For erase, write and read operation, we got the following timings :
  * tBERS (erase) 1ms to 4ms
@@ -336,6 +336,7 @@ struct spinand_ecc_info {
  * @op_variants.update_cache: variants of the update-cache operation
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
+ * @set_cont_read: enable/disable continuous cached reads
  *
  * Each SPI NAND manufacturer driver should have a spinand_info table
  * describing all the chips supported by the driver.
@@ -354,6 +355,8 @@ struct spinand_info {
 	} op_variants;
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
+	int (*set_cont_read)(struct spinand_device *spinand,
+			     bool enable);
 };
 
 #define SPINAND_ID(__method, ...)					\
@@ -379,6 +382,9 @@ struct spinand_info {
 #define SPINAND_SELECT_TARGET(__func)					\
 	.select_target = __func,
 
+#define SPINAND_CONT_READ(__set_cont_read)				\
+	.set_cont_read = __set_cont_read,
+
 #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
 		     __flags, ...)					\
 	{								\
@@ -422,6 +428,12 @@ struct spinand_dirmap {
  *		passed in spi_mem_op be DMA-able, so we can't based the bufs on
  *		the stack
  * @manufacturer: SPI NAND manufacturer information
+ * @cont_read_possible: Field filled by the core once the whole system
+ *		configuration is known to tell whether continuous reads are
+ *		suitable to use or not in general with this chip/configuration.
+ *		A per-transfer check must of course be done to ensure it is
+ *		actually relevant to enable this feature.
+ * @set_cont_read: Enable/disable the continuous read feature
  * @priv: manufacturer private data
  * @last_wait_status: status of the last wait operation that will be used in case
  *		      ->get_status() is not populated by the spinand device.
@@ -457,7 +469,12 @@ struct spinand_device {
 	u8 *scratchbuf;
 	const struct spinand_manufacturer *manufacturer;
 	void *priv;
+
 	u8 last_wait_status;
+
+	bool cont_read_possible;
+	int (*set_cont_read)(struct spinand_device *spinand,
+			     bool enable);
 };
 
 /**
-- 
2.50.1

