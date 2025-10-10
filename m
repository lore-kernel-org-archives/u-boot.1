Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFDCCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:41:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A234684286;
	Fri, 10 Oct 2025 14:41:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="dh26FPLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E46698410C; Fri, 10 Oct 2025 14:41:27 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 056A98422F
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 14:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5a5/lcmL6olLCSnwets87JILL/QKRZd7XoSh+2++VuGNoWV5dkPZqUvWD9jqt/46UfIAA8/jNr5lLndGhoRw1rR7hHbLtJW3p/hFNNT0qdoNpylu9mKH56A9EEQIGhAB+HrW/hlS6IG7N4wbG2YcdAPvt/nuj3qhmRed75xdKvYh6XXJvpB+9z+n5aW7KsRZeCx6gmujFklIjVEeDbE6Vpxm2QdMKZxMJsYQ6txHwu9sAZs76f2NlDHu+Wp3kbRiNzmbjD5KUoSA6/BNYsCkBkHA1JVA74SklX24Gcadpbyx8pgY0s2+dnGOOHkiohwQkX6onLBh66DXZWExR/hVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tnYUB+9ayRIpdL5n5OiA9plZeLWnu386VGqyUuq24k=;
 b=n2uJH0JTt8RzN5LHVumDcEqIg+mE4cK/BD6Wq/aDvFScikZsAjgz414IdFTTNHMYQzOi40gjFEFSdXZ5fzNgcHFtt0U9x6i5Qpdw6mKrt7JStek0ielzO7e4DiCwBdFgAgii5px+47VNW+vyWK75ACBy3H7JJ9foS92i7wbqLVzweywZleMGTl/WGynSsW4w9OrS8+ZF3x4vd1Znirtqr1c3WjkzJhtRDt+lEph11YDwfrrfLOfL5hCIUgjQ2JxjTdh4lxRcjI3w9mW9TLTZvdSOaJbjve7fGbghFrr1Ob7lcWw99Z0DlxeIn7LblMdWxetiO47pluUauWdsOE0owA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tnYUB+9ayRIpdL5n5OiA9plZeLWnu386VGqyUuq24k=;
 b=dh26FPLXLRb0Kv2hgqUCyjWxYvEjnmBGOiuFgNZcr/2Ea2c7rCJoNjx+nJyoeQxBzLoExet33ambjxlHYuICLlNN+wCYcd9cN6+/uDXR5fE3dYBiscWykBsRnZO3qGbRWxl7zs/5fgat0tZ8rYTlTajUR9NlCUuEdVBxV/RHy64WuyKqlVgqPDXbtubHxJQJBO3gaxCDsFiHVAiPNEQyopMTsOXzImJxAdcJGoHmMlOnlVzoaWzj/NzuSwDurxF0glbj1OAVtJH7jD6KGLM8KoZjA3jJcEh+aOq/QH193g2jpDTggBJtM0R4jCBS44mYJGJpnT64G3M9/e9cFKodUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6259.eurprd08.prod.outlook.com (2603:10a6:20b:2d8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 12:41:24 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 12:41:24 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v4 1/5] cmd: mtd: add markbad command support
Date: Fri, 10 Oct 2025 15:41:11 +0300
Message-ID: <20251010124115.1545865-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010124115.1545865-1-mikhail.kshevetskiy@iopsys.eu>
References: <ef29354f-7d9d-4d28-b3f4-b31291e11dcb@gmx.de>
 <20251010124115.1545865-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00007577.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3f8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 9049079f-a3de-4160-4ce3-08de07fa52dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x90uRXaKMOFb1aMUmunSyFRlF69iXXR2KWSTOmGZEKZeRtLZ3j/xEFK31XXJ?=
 =?us-ascii?Q?kMAFEiUrnmYkNkqfiZ7A+fCKQ4AvTp5v47LghKXpAkg4ODG1uPvqqwy3KtSS?=
 =?us-ascii?Q?PalXW7KCYutupcyaHSAOdHED2wjpDycLXgGvQjiPLtEpOnZCJ6g4YAnOOehh?=
 =?us-ascii?Q?5Q9687+S2vmYQLFNztVhO6D1jfCHNQ5bgAKur1ZlBBq0XoLa1a2ayeF4RIcs?=
 =?us-ascii?Q?z+Nu5fR6ay44aDB5uii1ZP6ouczsC9MK5b+eG1XKP8j6V0B5kJ0L/8iuxmza?=
 =?us-ascii?Q?loy0M5SfEr7RHS3YG0hwlCYq1GBrbt5RBGe3DDSLTU0fFi2jC3IqRKTtktVZ?=
 =?us-ascii?Q?dOYPCp33bNkU7LXHj0yJUpi6jswrpTuJEtpx6agi48ieOV+zMpiEbTjD2R4o?=
 =?us-ascii?Q?fpNvkSuE6cRbgB3S6mx+t4IXbDX1rjpmvVyfFXMAYh6ttGzLCTFm5lZZd0lH?=
 =?us-ascii?Q?JIiDawjIfA+yyFngJ/XJFDRFNaj6w8nwMKALhaKk9KPN36XdO84IRLSkC7Gw?=
 =?us-ascii?Q?XgHpTtSn3Hw8ydoN9c0zPf8y+HYPoyK7y8FiiCy4aB9JrYPesp6assR/D5yW?=
 =?us-ascii?Q?IPfbkB4jTefmI9YeeKj1NsRzWXchCzEfrx/qtfoJzRfhGeqOtLvyYBcGHwdT?=
 =?us-ascii?Q?wJ1eWAFQBvbJ44J/U0Ht7PenEF4G7cQfdm/4Fz9gjFV/v9uBroucnwDAwsu/?=
 =?us-ascii?Q?16GXayv6YNM6rEviq3PQfILGf8OwkHMKmpx7dy9VOLisS4StcNzqjtYHXdYk?=
 =?us-ascii?Q?kGWKupvXP/WRQIMygyxDG2nenWTLRZYJOxgzuD/8egQtB3tMMCtDU88FYy/b?=
 =?us-ascii?Q?kY4+t2KG7Dv1Ls+0eW5d4YViJzvJuGw6MbC5HSIwICxizQzcIAjHJotZRJFh?=
 =?us-ascii?Q?/1vi5JIY/0+0udkxgS2DXE7GuGAOgM/3zbCwoyGtqZknpqAeCoTfOAqlVIxf?=
 =?us-ascii?Q?fpBPuCbdSJEgyT/w7PvdioEo0HUbkox8gBF3SQN8JhZx9PqSY1gzgkvzcHUF?=
 =?us-ascii?Q?xqIy39tItf0t7gRftKEgPQrvpi1AKNSkQb5aY6gzyQyc0sD9Cu6taZ6dw0gV?=
 =?us-ascii?Q?kdcCMJ13/eV0IxGZCYN0ttRVgM9Za4TI8TdQUU/q1qlKbGBb57Hne2nJ9xZq?=
 =?us-ascii?Q?GKse/5+i9wrbOWgSHbSin80/TqAUBrTz23i0ixkrglT79UdYdV7HGYiR9c3h?=
 =?us-ascii?Q?6LuQQeUSiRCGZrqeBECmOP5dyH+KkFW27thAmAASNFmZEpa6yVdi9gMAFp2Q?=
 =?us-ascii?Q?+s+aGbWiabBax6HbCL31mgU2p6uqsoIqoQZr7rWT3gcUHqYWjGO7o5VyPuFv?=
 =?us-ascii?Q?UABgmnzhjjrHHFU0M64xYfmUdvqxuPyhDzjhyaJv8VJEEik6lwr74b6gI1AZ?=
 =?us-ascii?Q?MUC3i1xVy6y6GDbrbV63f/g7RtBps7JcUnYm16pOqtGhHhtAGamEdBIdREo4?=
 =?us-ascii?Q?MSbU/tCBMcNC9mxpKSdzXDluy4bJSAL1d/ndQ3kk4B0o6+aB2K3C7jWM/Cns?=
 =?us-ascii?Q?qv7jrT29cHjjfJtai0UtnCVLVfPggg02p6jwBscST7/k1CsK+vSN1zjsQw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LV58/bBr6XFAkZo7F0OMbRGW/c8grr7ZcbJ1jXdjNMCltKTkZdWjoXhpU+9I?=
 =?us-ascii?Q?nwJIzIxgv8gWJMP/oCju/lDi36GYie/5kN0i7OHpdi30YKOV3G14GdFt29bq?=
 =?us-ascii?Q?ifWI8fu68AM1TfW7K9UTmisAaa2D1yE9TBlsvEU+n/l+BIxbgYq2B0zQavDq?=
 =?us-ascii?Q?gDmX6HtSXQDZ6HDXlsm3NMZcPasTyKpH0iRAvz3fO2A9GAvmAGKNeh9tSSfz?=
 =?us-ascii?Q?LaKq2fG0JuJod4A1psbNARw/mSGTx4wa9ewh9Up/wggDQu5kFfDlmkF6gw6Y?=
 =?us-ascii?Q?W3ZEUpb2cdg1D0w/enLCQsJpZyJ2sOUnaddV0rccDpAtZWB6Nbf4QS39wMV2?=
 =?us-ascii?Q?FS1w4N0wYMzKERvsVxxVTFLqEYHNsXBZHkNXj0gDuOnqajkvcFuo3Mq0X4sG?=
 =?us-ascii?Q?3TaOo/vBImSYWrF/gg+GQ7zEljj7JYKyfK8t3Bkm5Drp8OqfF+SUr/h5K+GS?=
 =?us-ascii?Q?sb3OL9ck3kKLblhMGclKhD8Nq9i/fXUJG6iT298mOWeoGHifQdPt7JXlTL27?=
 =?us-ascii?Q?SASM3XfDSh8pc8zAqPcc9kD4MWDaqTzqldfoxQcsHEuaWftxon7N9Hb91IiA?=
 =?us-ascii?Q?ohynAsP5+OhjAT3NOfKvsoQ12AZ40ZHQRx8TTAt73slkfnrYT+g8lMJhN+oX?=
 =?us-ascii?Q?HnnsJ6LbG+6hTo+iJ1QLfsVy4dAlsIq6Xl1HxMlNlCpdxaOlTB27d1A2+50E?=
 =?us-ascii?Q?dTiziYKToYzgYQfCM/z76jQhlVZuLoFTb56vF12o7WzKvHR37lqBZklAUDNm?=
 =?us-ascii?Q?QePTx2bDID/67IiyoAYsUOu/jzk0IoOCvRBhvZx6rpSm6uzHFt+enr+3snfz?=
 =?us-ascii?Q?0nrFOWPF3BboIkeGgoQ8odxGKPL0ly086aUq9B1otj08awMiW06lAsQoWf2G?=
 =?us-ascii?Q?bXmL7wRFI+wiBDrGDHGKdRbXMCYcRORZgtzqTqUIvuKQIjmH+jdprPBf2YC0?=
 =?us-ascii?Q?SjGTnnotCSe5H6OW5pzj0pOQvKiaSsP+4nTdeJ4BdAihM0bjul5metD11qat?=
 =?us-ascii?Q?IvKFfgEx7iEb2qQ0xQt60+WE8bKbPwrKnPNFaVg+luzKCylgL+15uKatqEbr?=
 =?us-ascii?Q?EjM8xUr8MDoggHN4vkKZZuXLJIepBn6sAExjL2Cjs1h84LLsZUj/eDzgDem8?=
 =?us-ascii?Q?Ei3SAcLpnVQca2RMmDw8g2y+hbiRGcChF2euyUlr5kG20JDWGCvRx/A32qXh?=
 =?us-ascii?Q?juDpu3dHrj/MfyYAdOuimjQe8aCw6zoni5CGmg3ESFuiE8BjKlT284RlwPJj?=
 =?us-ascii?Q?tVzxN93fBkCuvp8w6Jb6c33S9aGaUHeUi8W1gl5VxBZ/seG9yv0B7AqmEfub?=
 =?us-ascii?Q?IOZpn7In7SKrQHzD/b9/N8QnrpaAaw27srbolVmRi79ED28sQ1CAJcr8+2an?=
 =?us-ascii?Q?bk9EhSKN9AiK0UUmad3Tpz8VEs3pKSNmUW6hsLd41+TGDZw8eH2PsyMIQZ5W?=
 =?us-ascii?Q?wB5L9WLgZGXqw3K34261KonZnAXofgzF7cn2LkTr6yNa6FiZMGNpqhLNgePR?=
 =?us-ascii?Q?Na50BXD9CdAKx7bqe4iZtnluHRMWe5vwvjoU0EACh0iqsGW078IDgcRUIJJ9?=
 =?us-ascii?Q?vljUFoXfulTly66uferdwI4ywwMb4V5iMc9xs19H+NjwpeFrbhhnw8iILk2r?=
 =?us-ascii?Q?p54mwgc0sPOycBa0Y3YyEUw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9049079f-a3de-4160-4ce3-08de07fa52dc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 12:41:24.8418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3LG+YvIhZN2D1OxhhbPeSrCtuXNbjb7LqBy4rvQqfBIcLX7K9jAmdCbRRQEegN9F0e1Qwsz0qFVTKqqYtoSj1jIhjMNbLXenqQok/oaYak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6259
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

