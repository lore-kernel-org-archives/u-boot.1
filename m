Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC45BCAC587
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 01:37:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68092833F9;
	Fri, 12 Sep 2025 03:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="j2AiEFzy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEEAD8334F; Fri, 12 Sep 2025 03:37:01 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C15C3833D1
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 03:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2SqbNUmtdNZp56JRiSh258du/dDl27/iVsruse4TW+B389TKx2yifKy6ioFcYr3RaQIb2S8rB2pUzefc7nlSMeVpp+8PKD+e0fMBOCJS0V8LkjP+7hyxdW9hlgR8y00fHZVDGziKHJBXwp08HEknZQ/J1dUFSHibuDXZQkWwxs/fYtVKzoAXeEOsDXGlPI82ghp2qjGA+OY5f68C4I1/iGO8qvmQ1hAIsIQv+Tk73zpkrwok8LprvNx1jGyR0+Qk4USnHNvdy7tYKPG1/0HLCVaynRNsVMMj3pU2cVDTaEMQ3iCMyb6olRoQZMqLha7VoWsVTylEZwdK1oXCg5kfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIAot7O4PMObXjI3f9lKGxyvIH24A3n6XZ7M6K4b6ZE=;
 b=OljdokXJO5Ezn0vNx5LNN0NbxUhFRDf+eimZiCjwVKjB11IxPrQ5OCxl8rD1j/oo09rZ0Mzljynnmw1juHPGvcP6jkf33Z1OguDYnQt9rGr3Im34UrDABCwI0iMDZ0FWi96sX71+b2K8+23KTT5WnJP/vlg0Kq6druvKbA+WRXj58n+j9TLc0GOMRrVGPSILUGUwo0eDO62ZbjKLBR4fhUI3t7QUmMzuEFYUOboCmi1z1kk6Pq1fwIGBRmPOiN7PEdv0t76Oid0HW5JF8niTKhC5qagxoL9H7/AfqV5pCEN5IfB7Z3/lWa1nwzkVMvqe8xWMz8dv0XR6ObBKWx1mpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIAot7O4PMObXjI3f9lKGxyvIH24A3n6XZ7M6K4b6ZE=;
 b=j2AiEFzyJESdsCkqPP3xpMIAYO0gCPTjGyNYcoaOxLfR2odLXsbITPUp+EUYsHewFzPkALlSRGlph3ytSl/H6Os5E+cQQBb1lokJcqM9TUBXPkii7GXj0g4AUltUpopPOXcFwLeDLEcnzxgTI11vxlHzgD4tM2CL9HERs5t3oByCcRvtkQHdKP/A6WBy7MUMov3w9dWnilk6cCVtMw9lGmMpSN5ZSTHzN0TqrU0aRIA+oK+1/xI8J0ZAk7HkEkXeFZt9hX7xEYQvV5lYDpvHHKc3+AIyfsT+OZquoN3leZCs1qFp4Q6edORw+gVlhvzEVd6P6XNhqL5ee/xKDsMMdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB11627.eurprd08.prod.outlook.com (2603:10a6:800:30c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 01:36:57 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 01:36:57 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 1/3] cmd: mtd: add markbad command support
Date: Fri, 12 Sep 2025 04:36:44 +0300
Message-ID: <20250912013646.11522-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912013646.11522-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250912013646.11522-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00004525.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::346) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB11627:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c097678-b5b1-408e-c9c4-08ddf19cdc65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3mFbljNprhYGeyWngEnyqRoUsS3rt28BQByh5qjaVGrR9JsMRPIU6XYeopPc?=
 =?us-ascii?Q?wwUweHNmxCb64ELulaPsaKk69ir9mgX1oHumDgPlKVYhXzZt8jzyzx2NDSI+?=
 =?us-ascii?Q?+0XfUb9xyiyrIRFEXCvhrszI4+nPiLyA+E1XCjvabe+S25zsx7DlXDyM/zNP?=
 =?us-ascii?Q?lLa7ONfWJ4DHggSFOLv2HW724lIzd1ZpeNfjDgigRYCM5kPSrvXDSEEnVKtu?=
 =?us-ascii?Q?wiReT8g3X3SykkCfkhSHcyOX97r3fDaAynES1VCfR/CHsKZm7vG3t2nSIvTh?=
 =?us-ascii?Q?L/AI7+Rv5pHK0i2T9VkHQqEVFljJjR4+orR/CxnvwUz5hZgDYa+XXIuuIVNG?=
 =?us-ascii?Q?8NAE3nWa6CiN9A7zN5h6Lr7D/eKHYSOlr+pT7UsnT21JU/2dMIwOGvQMm7UP?=
 =?us-ascii?Q?xX9wpu3zrRO2TDkADGG17HKs2HhSJd26unALvzCSiXeB8xQxm0wPu4SZeBDl?=
 =?us-ascii?Q?RO/ym/T1BA5RGfiMGM2mAmGvnNSuMabqau/fCk54Mr/vAzyGW1Ltxeqn1qTg?=
 =?us-ascii?Q?bNTuF8DGIX80buDvpqkOXQ+ZmBSEBXTiAk90m8qwBzdCJGATQAp9dPiMeduQ?=
 =?us-ascii?Q?KtfmUiL6b/RZGhR7C2i/ONPfZjtNWZxMIjIq3rHVwyQwY4l4kWs9MAWe4H15?=
 =?us-ascii?Q?u2v+Mz97T+z4ZVKjOSoxWxCknHkBrlPjjkxFu8LQxvXU0vmeAfR2cUA8Q+zw?=
 =?us-ascii?Q?7Mb9cdeuFhTtZ/aSw26dQJNJ43y7WAxAYRi8MrM801RSjYWlfGZpEF6cErSz?=
 =?us-ascii?Q?r+QOiVi9KkRM84vyV2ggxL6E2/vwCPdx1U+pGLEPeu3+bpFBC+MNTiyHRX5j?=
 =?us-ascii?Q?vQkCT5Wb6dNkPY4pwjgwewOXyQBO7nYtfaMEkAp5i9bWnkHd215c3fYm400P?=
 =?us-ascii?Q?c4UnNrrrFmoaOnY7npWS0+nESwgYGUopUNdX2hovQhdCvty9yTfwVp211QBz?=
 =?us-ascii?Q?d8OpH17WYMuF7w2wyeANpyxVzx9murhjUrXzXNmuNfP1ubzfSjc2HUhw5Nv6?=
 =?us-ascii?Q?PpyvQ1wCiMGql+ZWIoaDUz0uxyGPIF6m8xTVZ+cqMArxbrtBoaiSUn1z5CkV?=
 =?us-ascii?Q?yxApgWn9BCnqm4X74u5XemNXUBI+QQeTZPiNQD6FK7C6FjGTEma1S8YrP+SQ?=
 =?us-ascii?Q?FkKwTji7ydnHT8RpIMuU4r3nWZpfHvReNt7hKhGczG+QnajebULc7Q8M02vO?=
 =?us-ascii?Q?2UDcQc+dG+vyGv90kwUw1b7VqXKQXtkMn0C8BbdPL35bQ2rboJehf3b+2HgR?=
 =?us-ascii?Q?+RGaWJr1XlWY/QtskRwy53uuvzru9vfG9sqU5e3KlwM6aHPXlvt4Y2uzG0vV?=
 =?us-ascii?Q?YY4Z6twKu7B/zdRw2O/8eZyY/3oGiWi6SXMuZ7hfCFULz7MN9dbrnUNzOlKh?=
 =?us-ascii?Q?7Ps6DM6scEmUFwsIHA20tRDfwdhlxbY7kiUjA51CbHrtBeA4Zye+NDlBn9KX?=
 =?us-ascii?Q?EeekjmmDFhiDzrRcYQrhtFiPt8Tv6dcmZ+DWCMU81izk2KiJVYyAOQqHjDJ4?=
 =?us-ascii?Q?xkOqcQDumhmXhZE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jtxUCcwrriWWbMeOdFvG7KdMfzbpOyxL4bv6xsFQ3F+Bds7uQDi5SGILW0+8?=
 =?us-ascii?Q?2LPMQDoFoloBi6ccf0Hohe9GuANrniV8NmNDh5xZb3b4I/cPxSK8KxbS9sTc?=
 =?us-ascii?Q?OTKoUwVBMp8kSP/APdFf+rNa8Vye5OfntWLgNK7YViloqIb0+xJLm8f3nd76?=
 =?us-ascii?Q?QcLrxqCINipHgoFo1pOvkZ//3ffXmM8UlR0yHn1h248PSwh/RbkVtPoL8ZGE?=
 =?us-ascii?Q?rsWuS1IYIITIPEb2WvP9tEPDutfm6KZ279hdmec1mm3CEgjzxWw2uJisQYiY?=
 =?us-ascii?Q?ERhqPuzs3SlIErNWVyIhEIYsHI1LfxUbotr5dMhCMwYXuLy2guD9wFja7uQy?=
 =?us-ascii?Q?il9fWkaO3fHQQvmcIP95JPZ9cwdf3cDW5M8ZbMfPGxfDzRdx3Zfy8yerH23C?=
 =?us-ascii?Q?y7KDyK4EDheJDeGP2JUFkx1kc7lSUiDHvLXwkvU4SDj9MEyRAOgfUby+1rfA?=
 =?us-ascii?Q?rakagoKG8VSz0YjUv/c9OBKEGFGFO235Mvj8yGuMiVmgv6wWSCJH6QVhcPmo?=
 =?us-ascii?Q?Hr29cafBjvCQ0wlFFtEuqIwWgrbIxM4Bx07fM/8kbgK9M8X7clMUzFfqXEd7?=
 =?us-ascii?Q?0q9auw6vnV7/RGVdCwB73T2aqJv9yGTZmcsFv7ZSsliOUXEDlJDR4xdLSvHo?=
 =?us-ascii?Q?gb0tPU9URYq/NlNsZyDM685Wp9leLDISujEfLOe1B34aHivpRixPY2NoFhmG?=
 =?us-ascii?Q?y42cnZlHu99xXhHq1otvvDC+pGdEO+38Klu30pB2dgttqi0hY2HZUGaguHnM?=
 =?us-ascii?Q?fbS6INNf1exiHpjqNqnSisY0yqtbPnWZ5zEeG7QVFW0wGyfBtubFffsm5oQG?=
 =?us-ascii?Q?HIjTjtluLEtYJyTfnvSco8V1DXt6qyzIxiPf8tFiZAopxKAvKsWUCicA3hkP?=
 =?us-ascii?Q?qEIuQ+ZZq3RWJQdC2Wefgw5iQcYmqUulFGlKIoGoWQvTb3hY0W7fCF9aPSp/?=
 =?us-ascii?Q?TFHWk7ahcn/sxK6M+yRI/rGmaZ9871iZdDW4ViM1+L80uKCjgBf0+WxesBlD?=
 =?us-ascii?Q?Xel38IE9yzQTxRIVQX08HNWYzENgr7KkNFSP8Bm03auuKmcrCiQ/yvmXmnlR?=
 =?us-ascii?Q?AocyGJ5x8uANEGZ2f36fk04nEx1Cv0KJwSzqIVOXtAtpGP6n5fPuCzCw9Jtq?=
 =?us-ascii?Q?/nKiAWCo/ZyDspB8UO3rRSZjBqoUrJ4nYFHNuZfWbydJS7fCmDhPwzzSDGgU?=
 =?us-ascii?Q?qmhHb9q4d4L+3UOPoPjSN3i24PW1937kKo3shWAYVsQkCGdL8jzi+XI8XLr4?=
 =?us-ascii?Q?zGyzmTPZaFv5XpGT+WTMgNox4NJkHu+opChQLP3AJqSGFktgcDt6qHWv/7Rw?=
 =?us-ascii?Q?ajFQKjwRfxTnBpLn50uf3IEAFkCIink5Ll5KMGVnN7klB4xDSsarn1Ocz3aP?=
 =?us-ascii?Q?pKbv+zhPh2jOXg5eKfswuTnihEflYKOe2Ldt1zMG/MZg58+lfoqI34bjcMpl?=
 =?us-ascii?Q?vdqoPi3AlHaWGNg7KQk6Z7AKQ9iIdgeA5Egazl73vUKA5qZ2R9D4D0zWyUmY?=
 =?us-ascii?Q?jkbx9xdlQPi5BbfbnltrnWnn9M4bF6pSXc3TtwS7nX/p/iZRKfJLz7Wa8moN?=
 =?us-ascii?Q?eRu7mzzX3tXqYdz5OFHtOQ0FB9AFQTe1XkekMcpgE4YVjMu7FtVUdMDgDg3D?=
 =?us-ascii?Q?aHv/NjbJfLTVyWQD/hkz590=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c097678-b5b1-408e-c9c4-08ddf19cdc65
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 01:36:57.3103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hC4YE5Xrjdm2Cs+Bsgr9QoYFhPV6tHs2J3IQpjItiHDp6XOxeysBOckVtuj1QK7ac9wUnYbTlKKaPYGvP6JXE4qPvyI07wWtH8MVWYs5OBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11627
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

Some nand flashes (like spi-nand one) are registered with mtd
subsystem only, thus nand command can't be used to work with
such flashes. As result some functionality is missing.

This patch implements 'nand markbad' functionality for mtd command.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 cmd/Kconfig |  8 ++++++++
 cmd/mtd.c   | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 29de857ba7c..8f2a35d780b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1511,6 +1511,14 @@ config CMD_MTD_OTP
 	help
 	  MTD commands for OTP access.
 
+config CMD_MTD_MARKBAD
+	bool "mtd markbad"
+	depends on CMD_MTD
+	help
+	  MTD markbad command support.
+
+	  This is a clone of "nand markbad" command, but for 'mtd' subsystem.
+
 config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
diff --git a/cmd/mtd.c b/cmd/mtd.c
index 2520b89eed2..95e4be9863d 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -711,6 +711,57 @@ out_put_mtd:
 	return ret;
 }
 
+#ifdef CONFIG_CMD_MTD_MARKBAD
+static int do_mtd_markbad(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	struct mtd_info *mtd;
+	loff_t off;
+	int ret = 0;
+
+	if (argc < 3)
+		return CMD_RET_USAGE;
+
+	mtd = get_mtd_by_name(argv[1]);
+	if (IS_ERR_OR_NULL(mtd))
+		return CMD_RET_FAILURE;
+
+	if (!mtd_can_have_bb(mtd)) {
+		printf("Only NAND-based devices can have bad blocks\n");
+		goto out_put_mtd;
+	}
+
+	argc -= 2;
+	argv += 2;
+	while (argc > 0) {
+		off = hextoul(argv[0], NULL);
+		if (!mtd_is_aligned_with_block_size(mtd, off)) {
+			printf("Offset not aligned with a block (0x%x)\n",
+			       mtd->erasesize);
+			ret = CMD_RET_FAILURE;
+			goto out_put_mtd;
+		}
+
+		ret = mtd_block_markbad(mtd, off);
+		if (ret) {
+			printf("block 0x%08llx NOT marked as bad! ERROR %d\n",
+			       off, ret);
+			ret = CMD_RET_FAILURE;
+		} else {
+			printf("block 0x%08llx successfully marked as bad\n",
+			       off);
+		}
+		--argc;
+		++argv;
+	}
+
+out_put_mtd:
+	put_mtd_device(mtd);
+
+	return ret;
+}
+#endif
+
 static int do_mtd_bad(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
@@ -793,6 +844,9 @@ U_BOOT_LONGHELP(mtd,
 	"mtd otpwrite                          <name> <off> <hex string>\n"
 	"mtd otplock                           <name> <off> <size>\n"
 	"mtd otpinfo                           <name> [u|f]\n"
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
+	"mtd markbad                           <name>         <off> [<off> ...]\n"
 #endif
 	"\n"
 	"With:\n"
@@ -827,5 +881,9 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 					     mtd_name_complete),
 		U_BOOT_SUBCMD_MKENT_COMPLETE(erase, 4, 0, do_mtd_erase,
 					     mtd_name_complete),
+#if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
+		U_BOOT_SUBCMD_MKENT_COMPLETE(markbad, 20, 0, do_mtd_markbad,
+					     mtd_name_complete),
+#endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.51.0

