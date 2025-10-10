Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E39CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:04:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9C9E8425A;
	Fri, 10 Oct 2025 14:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="znPFWrJW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D865B83E92; Fri, 10 Oct 2025 14:04:41 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF25884051
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 14:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/8Ato7bvNCB7hDC5nNHe4/nLchR3tU7Hz0+nXIKvAwV//KionSg5hiB+Q8t4XdTXRQjrrRJzNYxj+IDxlBSyJ67T6Eg2vDNbPeNIF6iBxfd1YkPRuBFpoSNwxI4cZQ5kvBFiG/9OWhSOvlSDdCKYtmjDx9F5M3PNmat7n28wRp3MPr33k4rcoHFt9zd03HS1lcQdLb0fugIrDoNNP5JTJme8sx4qi0eGH32hIJi9039RN6Yr3jWdZ/mdrxl0q2FWYjjPRd275Ahvncc8HpqNSOzzHnVeh6Vh2EYcIJRr9NcaOheJfOuEfA+fm4OYrrD+fatEx+jmjXb+tA6mG2oqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tnYUB+9ayRIpdL5n5OiA9plZeLWnu386VGqyUuq24k=;
 b=RtXn+DEsvLgSw9cRMWk/AWB6+tmXj0rZWMlKeQTZ+ZPRx2NRsX2yQRsizfEKdnLSbjtpsUuVSZRNGaL0cPXSGJl6gJ0xrTZQ/B9MbrCxmhmHkDAIVPyLgSKlZirCnl4Cq38lY7anhkGfW9B/QEPnMojETo9k5w8qIyLFkdqXqu71ls4GzKMa9uoWiYL9pzY0AjgWVeHbpApHH+/HsMcOAghNapSFMMzjqsd4U4d4mpzLxrQKv95N7Y+2NoHy2F3HPUKdepwA30MZOK+IgpqP5feSdWogN1wbijVWdBvJpdfe7kTw2dyVaLhrHYiyFD0jzlxMCXLGhQPhcuPoEgyiKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tnYUB+9ayRIpdL5n5OiA9plZeLWnu386VGqyUuq24k=;
 b=znPFWrJW+/rDA67V5An07GDu6NjGcNpbjtAjHyFQPi8pLDgYCWomztK3AOAX3j3Wyms7aWEq2LhUdaTMR4QkApCAMDtFaty7IHafO67cMmI23Md/TQf5RKrY036kKjSRs4TROj++pKD/btBM3Jp+6Mmu5biykF1qQGirsqq6slY/c5rlW0GJAtRsLNiTnUA/lTV4Acl1Ge1JZLwjXwLN2maAEz7Hn5g0Zq6KyFGh/8XHPtqCY51UHbWcDigVcE6kuPzdd5OsFvZhxSmQFGiZDsWlbVOcIVjc9Qn98zgTwEoe72Mo+Ojg2JtFc8hmpcKFDsGzQ5GrOYsBx9hB7htx5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6650.eurprd08.prod.outlook.com (2603:10a6:10:26d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 12:04:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 12:04:37 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v3 1/5] cmd: mtd: add markbad command support
Date: Fri, 10 Oct 2025 15:04:24 +0300
Message-ID: <20251010120429.1532370-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010120429.1532370-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010120429.1532370-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13)
 To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 40676d2e-5d99-407f-7a7c-08de07f52f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?en5wjbnOhXG13r8vjL2wB17Zm52Luh5ITfs5jkaZKTfxCyO1MGsGbf6Jjlka?=
 =?us-ascii?Q?El3oJ5UG51YfRvXJczaTJsdaQQV5ZBxFeWCNs035xDAAEg0spAwOcbEBpP/f?=
 =?us-ascii?Q?RAfxpAoKH/UE7pOfVpqkjAZIXD/f8xjhUAIWa0ULBNOMbdAQxO2X2ej3KWgE?=
 =?us-ascii?Q?hBT3oN/+RCQsN3J0y6WcFfwdDTHtZNOOIKJ/cQA3hJUdIlmzLoeNTpLcCa7G?=
 =?us-ascii?Q?0mzQnhhaLSWkglgUzBnF5gtxB2T4h0B6mpeNed5eXtYo/Vb/YDJ5vIBqaiDW?=
 =?us-ascii?Q?U4faIvK7lQ9Qf6UIpT+sMlWpCNn1rN3VL3ETcyna9KAtQHUnDV3Z5f1sKbxC?=
 =?us-ascii?Q?JLO/A1R9ZZSnKImemdnLXLXyKPKN+SMP/kXipbpmJsO6UrNQZ+EBt7V/Ozux?=
 =?us-ascii?Q?LgymSVeQVuxZZfxe1Z2QPevUd+QusTNiIPI6ZtMDGjfP27Qe0KqjT5PWf4Pm?=
 =?us-ascii?Q?ZTgQdBSfYJ18POlHKV+y9WfLOYnbsEwjuWwuegAdXSRiyR9BQCqhTZS1GfU9?=
 =?us-ascii?Q?bfYCGVUNjVkjM4kp8QQoHINx/aZyok0hxVRo510UyQ0k/hpFwz6yhKC+wKkN?=
 =?us-ascii?Q?t3VbuEQtSbCxk7/V9gkpekkzpRY/JUYvRlPP4CJ6CSPjunH2MahnxKYwPqM6?=
 =?us-ascii?Q?FFUVTIv9DQipewSVRCECC7wFy68orkADWdMj1S7ohveCmCsmWVPCD+Kuar95?=
 =?us-ascii?Q?Km2+cAsNwWDdDRtuuLaYu/GV/vnKVgiaIl3FOa+iZgya3WkkBzzxeMzSDtfv?=
 =?us-ascii?Q?T83sd079QkrPRFVpaJnLUvU8iv/XUAAuQ3eLQF8zIukcPJa3dtd3WcwMas+l?=
 =?us-ascii?Q?1zp1s72cmlpQT82OkVrHPNnm8Ox/uDbMpgYDaLZbLSp47LVulslJEMqXrPXi?=
 =?us-ascii?Q?YZM8xGqupLPeX0pRiCEHt9jBeJCwW07hyOySrRwU6kvTxb2RH3TZHbMBFgtp?=
 =?us-ascii?Q?HqWqPeJi5xDuDrKQUVQNnipTOz+YX6CuMFhggQxYhbg+aDxKd5iZlD2ai5cg?=
 =?us-ascii?Q?7cKr5CbikbobbETT37f/FtCOyBBGTBMZLerbVNsjedhFacXT+/iVio3yWyqV?=
 =?us-ascii?Q?GTEWQD/BFSScvzvd042F6fYPOnt9odb4Icp9DsbtE4FRVSrSi1x4Kq8PPxMf?=
 =?us-ascii?Q?z8ltOS9Kjf+eGkdm7gudk+a4G8AhKzEwPYnAAr+x5Tztk0sllIVloowpJj1z?=
 =?us-ascii?Q?qSGRxV3crKX7U/Lf9TWRJXhMGx9qJlwCz8spt1KUr7ZTNBhFMG4Xt11rAaK9?=
 =?us-ascii?Q?zs6pcZHpl0rOSGe9wD7+5ySSC+vmFsOiyqkfDNLFZXB1IcMHFQmz2p/AspBr?=
 =?us-ascii?Q?THOrHN7T3gjn0wE8576HJaSUerhNYck3HWImi+1Fnxm7fzYbvDlWUNZciQJK?=
 =?us-ascii?Q?ptQabQPbLKOELAlOD/NL6EoYqFXppj8lBW1yl79yK7LVd1O/J6S8sxmoNC4H?=
 =?us-ascii?Q?CqtOJmNwYJlil0q8aUos7vt8+Mv0LltsdXaZT8J6ypb86s2pg0titTMzvYSF?=
 =?us-ascii?Q?YScAKs2QTMxD4SkhQxUOHqJFbPAHInUfHQev6dp+HtEklSlpiUMnBHN9Zw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?upJb3Trg3IQUv4Mdh9LvDpL2rHANR6UFaft1IyvfJ9v9cIuiLLV+PKXyIblQ?=
 =?us-ascii?Q?aoXki5wk8EaOK55IltJBr0+9r70/QKOpqBdaU2CDNVJN4qcYRh884KLCN23q?=
 =?us-ascii?Q?/ofmq8ah0Yf60zUAZsu2KPl7yKXdlsJSlf5LNeFc6ZIOMnfRoHtfOEzZAT8x?=
 =?us-ascii?Q?tc89RN6kll50QbEqXZ6KEYVkscDuHlqJOe+72bVmW/XXp3k+0YV1SGdrFySK?=
 =?us-ascii?Q?J9yY52nCQpahqfmVoEqZzjUY+n+vtNulbiSxFEAS0Jp28dmA6P05c/+3bMyT?=
 =?us-ascii?Q?nlIswoTg5g27cRT/1ukkm6XhF+lauKduD4x5172B5cKpRUIjsoe2LsC9Zi0R?=
 =?us-ascii?Q?0qYntGW4+pWll9MTq6ALg0iHvXTLpaybJizW1YmMWr48mqlTXoz1jU1UOR0d?=
 =?us-ascii?Q?XxBbQdr6RaKSfc/8qexlkdlpxiXAL1NZBCV88WQwbR3UIjn+NoSg0vyLp6Os?=
 =?us-ascii?Q?ncgmFBhKADierTyN0gUGTr9wFGFZw1OD1d01NEENMcE+aokDSufHgcbc1oZ2?=
 =?us-ascii?Q?got9Sbuw7iJcrBU9kUZdEaRiKkg+iY7mDhlQ46Xyikqx9XWgq/m1wbOvIh0T?=
 =?us-ascii?Q?1vWCFsu6iwo7q5VH4j7er4GTNHXD96scpBsssyPNuBRKIdI0FMupcPia5r5B?=
 =?us-ascii?Q?uw1fS5vYbEKPe9r7dgYpOognfDuoGWmrpozfAZxX9aOqq9XzdkKE5eaTRtD2?=
 =?us-ascii?Q?Ro9dVbsjGsAWBJIiasW3IyEnqPH7J1yOfwHWk3YUO+iQGbXxb6GYnxiwD/c3?=
 =?us-ascii?Q?43Ij+n4odbol4y4Tfbc8XHihgccGy9p3mSm0j+AwXkLr3Ndm/0uhLLKIlWoi?=
 =?us-ascii?Q?5lI4fvNxq/1GeOIqrATeekJeXmgtATQpM5CoU2zCPotHS5d5iVa6OMlEvNiu?=
 =?us-ascii?Q?sr8XXgHfwrvREN//CSTq0+Ee10pu8fZgSAQdyGjju24NjdlMmjVRvtrZzfKV?=
 =?us-ascii?Q?u3Qcfl2U5NxuWMIQ99W+D67H6Kdz/YqhlnHuy7nLeAYGb0TRD9VYa/+PkJnC?=
 =?us-ascii?Q?J8samPvWDzr7oYVRbjluonZOt0BzjSqFkpOos66tBdte5+WLlloAqmUx7iad?=
 =?us-ascii?Q?RBxxuULSGwu2LNhto3z7WaAQrxAXLNczVw54vJ++qGoyc64TYPuJ0cyk/y4K?=
 =?us-ascii?Q?EeHQZiFs2AKYJb+2GKwB7pLg7qSoiU6elVwKXGUKViX4Et+AAPcEaW8jBM3R?=
 =?us-ascii?Q?icSpZCgJraU90YxyhRe89MVlZN3h60G1CuorLtqovBUVxrVnDl/MB+0+uYG2?=
 =?us-ascii?Q?N4bcGnWJ7GiRbIThFRHUz88v02vOT8d1qoAD3w26EC8CIp/mcoAFP5EvnyuZ?=
 =?us-ascii?Q?Qvcdw4LP4P1Qf7NeinI9zhLErfiRUTZWTveI53zI9KZA3rf2r7BcEjbPsjXN?=
 =?us-ascii?Q?M4vR7E3srcLS3iwI2sZhfw6ORbIAPljMYBh+x9PsgUQriumaPQcWArgP95Xq?=
 =?us-ascii?Q?FIIz3MAkbOpfYlg0ZG8dXryfe1UtIDPyQfhDzRJGlxBuyul7nUQhEUzP+nEO?=
 =?us-ascii?Q?2FGjPaKaSJnnRZr/MPlT6UaMkggLCLwHbSo0sS3G2eQ6y9/w0wwwEeV3Fk81?=
 =?us-ascii?Q?HiuT2L00IGumPH35JWWIRP6PxmUTJ8P5w6DlDhG+gaakhgHkFr6rQO8/YaEC?=
 =?us-ascii?Q?t4KqyZSZFWewgszVi7UpXTk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 40676d2e-5d99-407f-7a7c-08de07f52f38
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 12:04:37.5531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkXKugKrGnahtTZkyUfWp7gFlmzgc9ALEeuzfyZWq5qwp9f2JJHy8ZHQVAxS9/SDk5AmQSzRkLDiTyr1qI3MqDFOTqYNnqLYTHYkj5vmq+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6650
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
index eb615552a00..3ba3af82fed 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1513,6 +1513,14 @@ config CMD_MTD_OTP
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

