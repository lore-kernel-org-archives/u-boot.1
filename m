Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32B0C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 10:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D31088A11;
	Wed, 14 Aug 2024 12:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="BNiu5hXU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3876D88A11; Wed, 14 Aug 2024 12:24:50 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20702.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::702])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3217087C69
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3Z9wD0OlIJcq2KHsLtok+VTjyo+n2q2BiCY5UlhJ+kZW2D1aunHFybMtAZkS+01KljHLjjSAzTBmQSTCWAckmpy/ZLJl50TOvRGaODVlf0IWOejQNle4nYi/Xw6RjepECKABqjXAxjlEe7znw+4Ry1TjO2ends5yyptEN+NgbA1gp2LfaAfTNVwloEwZfduoHDpQhi89WJE4OEIzg93Uq02vk64l0Y+1h8OyHjyi/bCO7KMVD6A8MRd7K8mAaK+fP3bSvOcFOaJ/sBovhjM1dVuTxCwD4dgbGX2qT4WuH0rxbg2CB6PSTBps3A/rLo8O1iyxJAiHDwBSKwRuBzPfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sq+hEIHrPPr+MS3jI3m5Xyu7rWAqaXE7gqna+fAulh8=;
 b=brNrrGvXHdA5zrX42YhXd7nOoGvxg4UICj+fN0fBJgcNKD1mNRyklDYM1HWwL4wZLb0yTA4MVA+JtEFhjoT95kuMpplmeskrJLj/0fHvlErzS6hHACcZOkafqrCm2LNL++5p+kr4DxKFI3Q71zdclO/zEo3Hz/gAd31z9ZEmM5BMFka67ZNYme7Exj3APm5Vi5Bng0Kpe+ufG4kwiEdjh/XQb97MSkqQ4ero1SRVEqac1MhLfBlgT4biOoadnvcSjlwn658VxxBWFIS6bXAizU5Ib7TgoPdBHOI1N13GhUkP43zU3dgSxSpDlGiJ2XzclZHZVhPBp5wVaUKsyiyw2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sq+hEIHrPPr+MS3jI3m5Xyu7rWAqaXE7gqna+fAulh8=;
 b=BNiu5hXUDCiGmz4zep2kd8t/xO6xYq+PsFge9ZdiDSBEJt3LBqQm0O8eVSYCvAT2f759OYOu8K1SGBfFVXQsScnaOTngB0CDd/GDr6Rzxj4YDGmic+3IKNCEvlwND3h6INFQ4ObPNtk7TOE7diWZ1VFAeYBt1eFm9/A7/bFida7gk0/jOy2puyAR6qZbjxWZ+ATKknsGwmy/ygTmeC/HydifNeDb0zdQeMOQ7UReWZ0LBR4hHyt0mdxJj2AWDx5TbgjFOiezkAX+8g7XnULrOwoxUAvyXPyjBJ7UrMXDq1AD/5NJV63c2RJ1i57Eho18yQt3OPWp2iZfP0Zfxn/iAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB8491.eurprd08.prod.outlook.com (2603:10a6:20b:566::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Wed, 14 Aug
 2024 10:24:46 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7875.012; Wed, 14 Aug 2024
 10:24:46 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [RESEND PATCH v2 3/3] cmd: mtd: add nandtest command support
Date: Wed, 14 Aug 2024 14:24:28 +0400
Message-Id: <20240814102428.1347425-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814102428.1347425-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240814102428.1347425-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0307.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: 475b0604-b669-4c09-4630-08dcbc4b51e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|366016|1800799024|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+/1GnAS9b5CUUA4UkDxHjtJ7vUis3f7Hd0TD+jsz7M/QbYedQXPbKKhtCzFr?=
 =?us-ascii?Q?7yyA/XEID7zIzLISIq3juUtZpYtywBsckCSmJ5s1L9jIeq46mPcfAGZ0jk9h?=
 =?us-ascii?Q?KyIwwnaC7MRsj+fNw47f12CnuQ9PJnbKDRTzVtIqAhRoFRB9HscI3WM3Ft1P?=
 =?us-ascii?Q?KyMd3uAqESgpiv5XWCffgbp8HYLIKUGdLG4e7FCtBvz9fqjJTiOoc7UPmUWl?=
 =?us-ascii?Q?jh/PlaKtrwBAteukMh8qamtsdu/ickKuQ29z5ymDzn3DZskSYFAHB2aPGHT1?=
 =?us-ascii?Q?zR08htkTzckZ2aThDKFtDTfeV5M5EFRRdOZqRFErvoYsRnGzBZftjvCB5A4k?=
 =?us-ascii?Q?hu6ZjOJQEpPqx7wOxObmbD8ofulXcJVaSWVUpY2WiePIuZwVjbi1y8F0jR67?=
 =?us-ascii?Q?NaShAp9z8JyjmjMDxrdq3BObOajzFQRbzvJKj9t/id2h2SvK60ibNpJgm6cF?=
 =?us-ascii?Q?31mItCKekD6dVVpwybeVM+FVJx+105iIF0ABo4xnpKj4NuHpPS5Ug8lBt8FS?=
 =?us-ascii?Q?biZJQu+7uJv8itFPzoDGMdxDFUUAPoC9plKbg/X40WB+M+0aHKVkrmkxqmFs?=
 =?us-ascii?Q?SpA9jwFmkI/LOaeU3W/pTC+OOGCMpvLLUcio0WDl1gs57OkPPp0nXIGS+i89?=
 =?us-ascii?Q?299wFIFv2rgb14hCkTasNFjKtUgnFyV49So3oVU7lTnYljPFMzv2KSKz7/Up?=
 =?us-ascii?Q?AEhgKxHuM0ZhRZl4z+oXQxGrsJ0UnKkgjDhf3xpPalpZbedNkdrX21jYt21T?=
 =?us-ascii?Q?ILIC4nPBwTQyaqwTdjRyldyoUvlcSld5NnmyyJcPETn9/yaQ8RCbQK12xYUN?=
 =?us-ascii?Q?D7ZYgOCuo7qmVPSal26Ci13AmuSPDSOM0eEI48ek7OLhVTJ1+aU9VSRPTrYO?=
 =?us-ascii?Q?HnUqQH5euHcYVxUxWeMzBLyED+JZCKULJC+nahgDsxxOzF5BtrVQ1hVVG03p?=
 =?us-ascii?Q?jgdWG9DPKSpjTc7h9P59m1cYPsvbJsQ0UZ/mP8iTRT3EyoYD2MaFeuCppk6O?=
 =?us-ascii?Q?fBETOOxzQW2db7I2a6HmiviJ0j4zpeuwVcVNptpJGotHjzecmtooSBbxFD27?=
 =?us-ascii?Q?O7L++HMmkcjnoO6ahxmtu2yUson5/aH+9Wli6hvp+KjF/Jl/VWATSlPicypX?=
 =?us-ascii?Q?9H4/i0N4JdX+Fz6gFFekQS+ROmylW1ToI68/AfHW0Qs/nHFotiGLx1OtbOBr?=
 =?us-ascii?Q?+wq16W8VSFsX1RbMRJkBarC9egUUoZrDC9qDipaSIsDL0KKMcd07KBrCvw6P?=
 =?us-ascii?Q?bfcin0On4+TvHTitwcMOA/ZCoAJlQoAAEjvYKbASTXN9itsjfSXpT9Pkt2mC?=
 =?us-ascii?Q?phyMyFCYbmoFa9XkCZuulxVyzwnYWJ0Kj1QhQN9837ts+p2gt5WxWymxDs+4?=
 =?us-ascii?Q?DuZkXQ1N0nFHd64BHMpXB3/713RfaxrDjKWxcw8+lUqEOHeWPbet1Q/PvjmS?=
 =?us-ascii?Q?mRWXLbNlwK8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(366016)(1800799024)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kF/k5JVUCvBErK9qA6kDhgxdH+tdXe0krF4KGmUjIM5xQFn+2hEptydc3MVH?=
 =?us-ascii?Q?4ON9JANXC/iWsxDvNHdpmPQlTrRef0pkuio6QLwiHfqbF3E0cn3POekwDavs?=
 =?us-ascii?Q?sRJLgvDTonpZIKH3oOSrNc/p4lV1rhfw+ri1XU/00yu3iOyvYirPDUcCZP/u?=
 =?us-ascii?Q?SO3+7zFA2ljENH/TjXnOq0Qn+OaP22qxcwJqSK+ANCiqUxO8744KeEQHCS/c?=
 =?us-ascii?Q?ziJo024g0WqWHovof9swre/9EIZxoKPm8gppU2K5MO+M6SHIyxMsETwaDBoU?=
 =?us-ascii?Q?TvIiD3ByltfRL+3dG16jziEWoGQDNvIbrxGel+xDSg35Y00bLSZe+2uyz5ep?=
 =?us-ascii?Q?RT21byXlmXq3d5F5ejaHU+BemCBhnPDTX6vNKrsWJE2DeL+K/RtJ4wns9dAR?=
 =?us-ascii?Q?9NI+xxtVKX24aH43SL9y8TfOiRNrn4ZuzABj2ZQhGZyCenFyIaRqtrOcgbom?=
 =?us-ascii?Q?Etue/byMH+VN8lv0BL96jzLjeHGTxW4MH3ydrp2wRvupkDhi1swc1yoJZuHR?=
 =?us-ascii?Q?M4S56cIfTZh5nJmVoXpxALX+VqXu9ITZGkkStOe17paeIiR26htvOhYTXdkb?=
 =?us-ascii?Q?vfb/dcHt+Vve/jExRKysvQq3+HmNWvYojgVCBuNkEEddMG2ncvkQFRPcemWH?=
 =?us-ascii?Q?IO/0r4rrJXqQGrd5e3EfRjOxUidw42hzCE+qK90zepBbpEVdNXl0FJ5E5JL/?=
 =?us-ascii?Q?FO0llFKowT6OsL5iF7VUewqlHmDcBFk11F+QRro5P9xBxKB31VWBC4ju4KO4?=
 =?us-ascii?Q?rLs8bZYVo5eP8F5WAqeTO/XEBQ2XN69uwjhY/I/eBkoqCO5TC1Jd5llarEkH?=
 =?us-ascii?Q?PWwDSzUrklPc+0MF5xF+eHmWD2MxYNz7UbGi4oqyIZbIil9dbXhVRUtYw6Om?=
 =?us-ascii?Q?S+WK+GSV22dJ+4AHirUCQbugAKe+fu35PZYo7+9lfC9eGGJ57Q5pDfw7bkW3?=
 =?us-ascii?Q?ZCaDgHU2XXAOUdUDPXj5OF/YPViP9FxEMzBHoWqibzr50sG0GxUHu2pAbalg?=
 =?us-ascii?Q?O58TilPu9Uc8xIuvcZ96RaX2ruxlQjsQNnMND/Kn3aUcb/7/XB38TzlL6bmb?=
 =?us-ascii?Q?+/C9zfUKufDXSYvkZHz7nQ2bUagGS4HdrZGZcpvhyInFiLW4ypHbOc9Arix/?=
 =?us-ascii?Q?jHonetN+5irpJFPXaNQu6M37QLnNc4FYiGe4qVwVO7GkGdE7xRpIhyRwPKuH?=
 =?us-ascii?Q?BZx79a2Jh5BRd1i4kg/vPH6Yr11+8Tt8btKG+BJxalBUvBRnVQmpceI9j5gT?=
 =?us-ascii?Q?1Kw48orCXusDPqiWSnHgNLv3GlThMnFe8J4PSSUTRUi4cL9VQesoT7s4TMFK?=
 =?us-ascii?Q?N20540qbECiod+kpbE6DoIZ276JrQHuBaS+8+WPYOFAvlV/HSnKTHlj+jttZ?=
 =?us-ascii?Q?L8waGFq6PgRBawTCU4Iv6ENjsFLYFS791q9kYib1yYAFFrVy7oqhPVBdtQzr?=
 =?us-ascii?Q?1T2UGvNjq8agcigFKNfQDcQyuoRztB6f0tWLp+TuY2gOEbq93q022h7a++sx?=
 =?us-ascii?Q?V6/u7A2/OnEsdSdi7nhrQwoyeUJuAvU+JuWZE/eYRirGhsmk+JEdXc3k0zUR?=
 =?us-ascii?Q?TOiHvwVbGmO6apQs0wxJeO3DRdTZwuS/+u9Gziy4Zcp2nPiO1JXwJNvrgd9U?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 475b0604-b669-4c09-4630-08dcbc4b51e0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:24:46.4271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGYfckrSXWY1rxdciSn/Um3Ls7b6J3VgsVYnRNCLy+2ub8Z06pS/3XZDrPljE4cAvuPK64CeoTpQIBcbAOgi17hOY7fvtR3e1q30EuAvsFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8491
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

This patch implements readonly test of nand flashes.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig |   6 ++
 cmd/mtd.c   | 203 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 209 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 698e0e697f2..db5113e016b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1445,6 +1445,12 @@ config CMD_MTD_TORTURE
 	help
 	  MTD torture command support.
 
+config CMD_MTD_NANDTEST
+	bool "mtd nandtest"
+	depends on CMD_MTD
+	help
+	  MTD nandtest command support.
+
 config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
diff --git a/cmd/mtd.c b/cmd/mtd.c
index 69ddfe1d9c6..4a380dcaf83 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -931,6 +931,202 @@ out_put_mtd:
 }
 #endif
 
+#ifdef CONFIG_CMD_MTD_NANDTEST
+enum nandtest_status {
+	NANDTEST_STATUS_UNKNOWN = 0,
+	NANDTEST_STATUS_NONECC_READ_FAIL,
+	NANDTEST_STATUS_ECC_READ_FAIL,
+	NANDTEST_STATUS_BAD_BLOCK,
+	NANDTEST_STATUS_BITFLIP_ABOVE_MAX,
+	NANDTEST_STATUS_BITFLIP_MISMATCH,
+	NANDTEST_STATUS_BITFLIP_MAX,
+	NANDTEST_STATUS_OK,
+};
+
+static enum nandtest_status nandtest_block_check(struct mtd_info *mtd,
+						 loff_t off, size_t blocksize)
+{
+	struct mtd_oob_ops	ops = {};
+	u_char			*buf;
+	int			i, d, ret, len, pos, cnt, max;
+
+	if (blocksize % mtd->writesize != 0) {
+		printf("\r  block at %llx: bad block size\n", off);
+		return NANDTEST_STATUS_UNKNOWN;
+	}
+
+	buf = malloc_cache_aligned(2 * blocksize);
+	if (buf == NULL) {
+		printf("\r  block at %llx: can't allocate memory\n", off);
+		return NANDTEST_STATUS_UNKNOWN;
+	}
+
+	ops.mode = MTD_OPS_RAW;
+	ops.len = blocksize;
+	ops.datbuf = buf;
+	ops.ooblen = 0;
+	ops.oobbuf = NULL;
+
+	if (mtd->_read_oob)
+		ret = mtd->_read_oob(mtd, off, &ops);
+	else
+		ret = mtd->_read(mtd, off, ops.len, &ops.retlen, ops.datbuf);
+
+	if (ret != 0) {
+		free(buf);
+		printf("\r  block at %llx: non-ecc reading error %d\n",
+		       off, ret);
+		return NANDTEST_STATUS_NONECC_READ_FAIL;
+	}
+
+	ops.mode = MTD_OPS_AUTO_OOB;
+	ops.datbuf = buf + blocksize;
+
+	if (mtd->_read_oob)
+		ret = mtd->_read_oob(mtd, off, &ops);
+	else
+		ret = mtd->_read(mtd, off, ops.len, &ops.retlen, ops.datbuf);
+
+	if (ret == -EBADMSG) {
+		free(buf);
+		printf("\r  block at %llx: bad block\n", off);
+		return NANDTEST_STATUS_BAD_BLOCK;
+	}
+
+	if (ret < 0) {
+		free(buf);
+		printf("\r  block at %llx: ecc reading error %d\n", off, ret);
+		return NANDTEST_STATUS_ECC_READ_FAIL;
+	}
+
+	if (mtd->ecc_strength == 0) {
+		free(buf);
+		return NANDTEST_STATUS_OK;
+	}
+
+	if (ret > mtd->ecc_strength) {
+		free(buf);
+		printf("\r  block at %llx: returned bit-flips value %d "
+		       "is above maximum value %d\n",
+		       off, ret, mtd->ecc_strength);
+		return NANDTEST_STATUS_BITFLIP_ABOVE_MAX;
+	}
+
+	max = 0;
+	pos = 0;
+	len = blocksize;
+	while (len > 0) {
+		cnt = 0;
+		for (i = 0; i < mtd->ecc_step_size; i++) {
+			d = buf[pos + i] ^ buf[blocksize + pos + i];
+			if (d == 0)
+				continue;
+
+			while (d > 0) {
+				d &= (d - 1);
+				cnt++;
+			}
+		}
+		if (cnt > max)
+			max = cnt;
+
+		len -= mtd->ecc_step_size;
+		pos += mtd->ecc_step_size;
+	}
+
+	free(buf);
+
+	if (max > ret) {
+		printf("\r  block at %llx: bitflip mismatch, "
+		       "read %d but actual %d\n", off, ret, max);
+		return NANDTEST_STATUS_BITFLIP_MISMATCH;
+	}
+
+	if (ret == mtd->ecc_strength) {
+		printf("\r  block at %llx: max bitflip reached, "
+		       "block is unreliable\n", off);
+		return NANDTEST_STATUS_BITFLIP_MAX;
+	}
+
+	return NANDTEST_STATUS_OK;
+}
+
+static int do_mtd_nandtest(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[])
+{
+	struct mtd_info		*mtd;
+	loff_t			off, len;
+	int			stat[NANDTEST_STATUS_OK + 1];
+	enum nandtest_status	ret;
+	size_t			block_size;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	mtd = get_mtd_by_name(argv[1]);
+	if (IS_ERR_OR_NULL(mtd))
+		return CMD_RET_FAILURE;
+
+	if (!mtd_can_have_bb(mtd)) {
+		printf("Only NAND-based devices can be checked\n");
+		goto out_put_mtd;
+	}
+
+	off = 0;
+	len = mtd->size;
+	block_size = mtd->erasesize;
+
+	printf("ECC strength:     %d\n",   mtd->ecc_strength);
+	printf("ECC step size:    %d\n",   mtd->ecc_step_size);
+	printf("Erase block size: 0x%x\n", mtd->erasesize);
+	printf("Total blocks:     %d\n",   (u32)len / mtd->erasesize);
+
+	memset(stat, 0, sizeof(stat));
+	while (len > 0) {
+		if (mtd_is_aligned_with_block_size(mtd, off))
+			printf("\r  block at %llx ", off);
+
+		ret = nandtest_block_check(mtd, off, block_size);
+		stat[ret]++;
+
+		switch (ret) {
+		case NANDTEST_STATUS_BAD_BLOCK:
+		case NANDTEST_STATUS_BITFLIP_MAX:
+			if (!mtd_block_isbad(mtd, off))
+				printf("\r  block at %llx: should be marked "
+				       "as BAD\n", off);
+			break;
+
+		case NANDTEST_STATUS_OK:
+			if (mtd_block_isbad(mtd, off))
+				printf("\r  block at %llx: marked as BAD, but "
+				       "probably is GOOD\n", off);
+			break;
+
+		default:
+			break;
+		}
+
+		off += block_size;
+		len -= block_size;
+	}
+
+out_put_mtd:
+	put_mtd_device(mtd);
+	printf("\n");
+	printf("results:\n");
+	printf("  Good blocks:            %d\n", stat[NANDTEST_STATUS_OK]);
+	printf("  Physically bad blocks:  %d\n", stat[NANDTEST_STATUS_BAD_BLOCK]);
+	printf("  Unreliable blocks:      %d\n", stat[NANDTEST_STATUS_BITFLIP_MAX]);
+	printf("  Non checked blocks:     %d\n", stat[NANDTEST_STATUS_UNKNOWN]);
+	printf("  Failed to check blocks: %d\n", stat[NANDTEST_STATUS_NONECC_READ_FAIL] +
+						 stat[NANDTEST_STATUS_ECC_READ_FAIL]);
+	printf("  Suspictious blocks:     %d\n", stat[NANDTEST_STATUS_BITFLIP_ABOVE_MAX] +
+						 stat[NANDTEST_STATUS_BITFLIP_MISMATCH]);
+	return CMD_RET_SUCCESS;
+}
+#endif
+
 static int do_mtd_bad(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
@@ -1019,6 +1215,9 @@ U_BOOT_LONGHELP(mtd,
 #endif
 #ifdef CONFIG_CMD_MTD_TORTURE
 	"mtd torture                           <name>        [<off> [<size>]]\n"
+#endif
+#ifdef CONFIG_CMD_MTD_NANDTEST
+	"mtd nandtest                          <name>\n"
 #endif
 	"\n"
 	"With:\n"
@@ -1060,6 +1259,10 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 #ifdef CONFIG_CMD_MTD_TORTURE
 		U_BOOT_SUBCMD_MKENT_COMPLETE(torture, 4, 0, do_mtd_torture,
 					     mtd_name_complete),
+#endif
+#ifdef CONFIG_CMD_MTD_NANDTEST
+		U_BOOT_SUBCMD_MKENT_COMPLETE(nandtest, 2, 0, do_mtd_nandtest,
+					     mtd_name_complete),
 #endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.39.2

