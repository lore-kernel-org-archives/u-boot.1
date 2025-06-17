Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED9BC7114A
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 05:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CAF682C8D;
	Tue, 17 Jun 2025 07:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="RxVD6Zaq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B848581E18; Tue, 17 Jun 2025 06:59:03 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E654180C83
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 06:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ebb1CR5NzgofMA57Bb9vqovK/kYyF4eL9M1quS0+4t6pHqfWrVI5P2XwwjK/T/+c7ukSZYn3YnTkuqU4k69+hixLN5mDpTxH41l8Ect+ifK5Ygu7XsS1uf/sCtSHh00yXfrqCNeZfgdQuPppv2ua5vQ8w4aRP42bGemKIUrx2CDzmR7lPRFMcU+LX5Q2Q6y+pblsewWMBo9xIbnj02hdZ4RCY1jdKLjHHVLd0XH+VlJ3PK50BUj+ESGu5m6zvEdwG+6STSN3UoIDabxDlkNBpCA4GD+LhqKzFGPCH2i3THA5cdCWOqMlstCx4UxMvAK4Nrpw7YZ92ZRuwvA3MWwZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXX2kjinH9USbKKOb8sWHwwQXrsssQOCpUU1RwM4kGo=;
 b=PNKVBCx1t87B8LDObynKISFVtxoqjPSYEzTHhJDhFXIYJhNlvrv1tVAIL4CK0WUbOTMy42wGSCaMWhBsQCdTNoeYdHYhIB2U0DMKBn7kVa6b59K+HKcyVwgAbp8XfLhTlOlaLBay/5XTBaIbuEPmXmtjqR18x4Jxw6WZZhoV2Ab+OxffHMkof7cItlmyCa5USyWYrf3cTfV478sq7U8FTWRnq+0ZjJsoGNiIl4hUYqpyIhElXhkWfW7GP6D/EduQRXTFdx4Ffe3dZW0c6NkbHyXIMWvia0Gjy+2cWcwPA613M+QwAkxcU6nqNL4gQpsMiE/J6/t/R9GH2ipgflFr8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXX2kjinH9USbKKOb8sWHwwQXrsssQOCpUU1RwM4kGo=;
 b=RxVD6ZaqOUz9BvbbX6mNo/f5LrivpVCsSrZr5o1J4JBGzZA43I/hj/KB7aH+7W/CJrD0uf5YzqhebjFnc/p+3rfFMf/1vIv6xt1sN09uRrP98RwvAS44FgLJtKJCv1AxQNqAYxA7PsDfqrm+yhkb1Nh869dk8V4pRtmubM4p8hpSH5+TL7t4jKVHxSfd9fQzElRELdyJVOgOTLt4SgLkdErjPwkA7Nnz53pNUlgnBR4y15auf+zfIun476t/ENniM+1rnsWkm0WXHjM36UDZriM2oWuITsdxJlaFYkp15+cZOvDX4oIfkP1IzDrCLzpSwHccTcAxUT1cVKp65zQFVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by MN6PR03MB8007.namprd03.prod.outlook.com (2603:10b6:208:501::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 04:58:58 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%4]) with mapi id 15.20.8835.023; Tue, 17 Jun 2025
 04:58:57 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH] drivers: mtd: nand: Use Cadence-specific onfi_set_feature
Date: Tue, 17 Jun 2025 12:58:42 +0800
Message-Id: <20250617045842.28813-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::34) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|MN6PR03MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f941303-bd78-4ba5-7992-08ddad5baabf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FwD7IyNODz2uruzOrrUSGVOp0q3ixHn0Ch4WLzublMpesJPu4mm5b6erBj8p?=
 =?us-ascii?Q?h85dQFAmCqIPrSK7dK6+da8z/6Pt92YdtXq58lFRIasJbGrpd+cL6n3PQsII?=
 =?us-ascii?Q?NxWZ+tDEFuthQv8qITkgvr4b67l6YxbFbZMvZcLER8TwFjz3R+FvUZEyzmp/?=
 =?us-ascii?Q?1z1p6ivH6Z+L495NdoYdFCZ9nF5qL2TPlqcmrvqI1Zw2H49JAJGrWx+jiGln?=
 =?us-ascii?Q?gwA5f6g5kiL4kO4LNwQzyoKWhNYfkj+ytWdqQnEPmmvj8ZyF1kPr0Ig5i4Fv?=
 =?us-ascii?Q?saDXs1+hAn7MaG2ILOn9tz6zgzQUE3hLW39hATPZbMGbSsr3L1KNXoTWeCXu?=
 =?us-ascii?Q?qgUrnA7LB2nwDY5aUPHgZjwHJ4gPRsE1mnQvxWWjFSzQZI8HXb0DZBjSIcL6?=
 =?us-ascii?Q?kka068VRdV1uUghog6bEfABt2NnH0AB0px9AylBttj+e+XZ8XmQaw10Rg/38?=
 =?us-ascii?Q?hf2aLuUJeoQX3kzyGjxzWEmTfX61wumD+RBu3UKL5B9A3Sk42O7ozArI87PU?=
 =?us-ascii?Q?v+JA9+brQbzS+TgY3mYwrKCGrEkgeG2RrmM5x+yBJTs5fhjOaS+4gwAPq9DN?=
 =?us-ascii?Q?kgWhNlIteQ5V6kAwBzPOMR/19DBYGe8q4gzvaxglVk88Wzo52tEH/NWH6gBO?=
 =?us-ascii?Q?k4v0JxL3dl5madmK+YmG3lVgxzTloliVxHxn9IFpRg8GiZWUFxoQSHtgYm8l?=
 =?us-ascii?Q?cSukaSycJmmpuIBva+WcdTAmCHeIMzlP77yomInLXZ3UelujMXGBoKNBJ3d/?=
 =?us-ascii?Q?Dahf3mCDJ1dG73RTKPGHBUhjQiipF3+jur8dSzi+KbwVIUcuFytc8qDnqpcW?=
 =?us-ascii?Q?PLJ9AMVHgX8oZ1Vzt5puHzBXK9I+JFInZ3qDfUyWGV96XFuvDjri1tfcqFlA?=
 =?us-ascii?Q?qyqfwjhXSje5OVYMM5tWmAXBtJzDsuzmqr3St2qiPonAODjsozF/TdUElWJK?=
 =?us-ascii?Q?s5uJs/RAitoESpxYsdQwK7AI1XiVvSqd8gvsUi+Cys4J0loHppemY4YOeO1Q?=
 =?us-ascii?Q?Vd9Y2hRkpHf7ZCU9ItYmki5T0EBANGNzkUvlaUHaM0J5MWtSHRqpdhiDTo2o?=
 =?us-ascii?Q?dDdgUyQvnUj5N1hafAwmJmcDNMg4v5YO2XhUM1Bf88WGzpJpiqUTmQUd9Uyq?=
 =?us-ascii?Q?0GGwxvDf96pb2U9LSa6tRpqFzku4SqocU12QaonUvqZM+Lat9qViqpgISt8B?=
 =?us-ascii?Q?uv9FyhbrmF7p2lbH8t0HQF23YlkldN83WjeeJVisDSsvKbK2tlbDzvDRKTKW?=
 =?us-ascii?Q?zxHfoUHdRedfNUuP792dD90DDdzO1AW8PxyJECUat5po91xbsMhsprpKgJdX?=
 =?us-ascii?Q?uoh2onHKlO/05ljMuAr1/oVCEvJc7o1OZ+MZcWN06IHTnkp5AlET+hE4pVxP?=
 =?us-ascii?Q?AarPuSmPX+1zjDaS1dtXQb0XTAc0gjY60RoFrNhA+Km6ZojJw3ISLdkTUDy6?=
 =?us-ascii?Q?ww8ncqBiiaQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bRgJY9rNpIglSwdoQgHBkGH7siN26SKziAWmzBzeE8Q6G+RVse6/7JC+ZOe6?=
 =?us-ascii?Q?pvV5TK//nwKTDN1jpmXXYRpOL7v6Zm2x/PhLNaHCkWp3VVV50AKV8YRfb2oD?=
 =?us-ascii?Q?6U+gBqqkQ05yCaom9h65OYT0sL+KNtYtmO4V2znK1hNe3KxmmConMwZrkA1Q?=
 =?us-ascii?Q?g+zLzOS+vuTGtXJvTePYgbD05Dc3qe8J4rlsnE3/HglOI6ik+ckqmpkfYnHw?=
 =?us-ascii?Q?o9mn5mPmBQfRQKyZTMcGkdUi24kfOGnN8ZTAOEdDq5nKon3MCnczhYglEvkn?=
 =?us-ascii?Q?TT5oOSSzUiREX/9MpxMg/0AhgazbBz2JZlDFgiAEbXHbSAwRXbAKRzNSpRqF?=
 =?us-ascii?Q?feePmf2i0tNLrAw4vRThTnK4ESXcgg/Aix6AYW9lqira1Nyko7Kofa0lJUKH?=
 =?us-ascii?Q?EkpfUipwSZ+JEVEgeXl0HvwHb5YaPEMNtsmseFvXhRVt8cuqxvvgqteXgSms?=
 =?us-ascii?Q?WHhnfp1sEYlGf0+DV/0MXsZtN+0ZZpKV89G5D7vmmmAPatZ7sZ82TFTPYBom?=
 =?us-ascii?Q?GBFpCqF7Y88Xriz76/jGuTQkluqXme0q+lOWVH0TG2i/Xp+mD6WnJDpNAmJg?=
 =?us-ascii?Q?F216Ioco3LJV0uXsDUQn3/mpZ+TPgHAqlJaaLEp0YOmnhVOZMno8/dwHR8kj?=
 =?us-ascii?Q?njWSQ5LxDHlJ+N0Umx8cs0sOS4t5KqDkZ3NAgl1kh8j31fueze7Z+N4OY28f?=
 =?us-ascii?Q?qKEiGDpgaeqa+338txC4Gjl+PdaAdLp4yMfC3SksakVfwWZywp0EbGPoeoSh?=
 =?us-ascii?Q?WAAu6Yln3P5k94Le+3vUqQdjT++4enae5cov1VlxOf+bYfpLj2anGEjLCpDZ?=
 =?us-ascii?Q?yPvhDmj4yPy0j8grWB0VtPPCRpYyvcTqdf0HU8/g7HT8WSDtAU6LCFL8Hqi2?=
 =?us-ascii?Q?/HVUCkt9Bxoc/qnRO72etUk5S9vyJomnjcHysWZoJMIKJjJT9aZ7Mpbfrc+L?=
 =?us-ascii?Q?fck7yEcYXGBWZ66GBm/mgn7+mlEcQ5kuff69fgGRogswcK7TGU4nK+RYMgc6?=
 =?us-ascii?Q?Ny5VudKjkuwjFdfllTgNlz8f6az3Ur5SPKnBLIxC7TKrNwWUHfMStGwZ8Hea?=
 =?us-ascii?Q?o2F1rZl2p1XRbdqOZhx1xriS/rvgalxrq7+gG5sVn8VRQ0gCYMQzvkpVWT/p?=
 =?us-ascii?Q?nixs/yxWXaOpYcyhAmXGZ2FbF+734GTdm30zaNLLt61GSROr/AY1qXLmVSHW?=
 =?us-ascii?Q?ZMX+/IOysc7rHfXzq34Khw9UPT5qj4XnQIDESRI7nqHzWXbUTWTw+YzfNPIC?=
 =?us-ascii?Q?ixfOG+xSwLvaNfoty5yRGyv3AhoEQIi9ShlrKRSyNeRVfPltoG0yoxhNgDh2?=
 =?us-ascii?Q?vZq5AKXsTQfTMYgvsMj8UNfZIvWnu/f/DiaJVRQbw7Y/nVJTkynsAw8lVlF1?=
 =?us-ascii?Q?6Myorny9sSiw5v/0PHaGoyTQ0mDVdGisVTUMMLJUFhBd2bGyq+lH8CavqYfR?=
 =?us-ascii?Q?d6Upbwml8qsrcNiVgsp3biQ5g1Dw1EqpVEafl5sHEnQ/3eQsDLZ4L4iy/mU7?=
 =?us-ascii?Q?kXKufaYl09I7QAXoZirtzB2Rhyr21sJse4LAt5nqwO7Z4kGdbA6uf6ziszCo?=
 =?us-ascii?Q?EZ+aB4Y0q6KB/FDNBzsdP6sNKEFukDda7c3jmHIBgXwoJzu6JI8ekXK6LKCt?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f941303-bd78-4ba5-7992-08ddad5baabf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 04:58:57.8035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfRoh1HIKKfkEJVB9sj94BLkskMjTMswCNxQzPTDeqdtQoz0lGmtr/T0yVwF4XjUR75gF7HLCwEVEbXNqwoQteABG7a0Et2eE9fvJ74ZgYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB8007
X-Mailman-Approved-At: Tue, 17 Jun 2025 07:41:19 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Implement Cadence-specific onfi_set_features and onfi_get_features ops
to support ONFI optional commands via standard NAND hooks. The Cadence
controller performs 32-bit writes per transaction, different from the
legacy single byte transaction for SET_FEATURES command.
Hence, using legacy byte-wise writes introduces redundant overhead
after a SET_FEATURES command. This specific implementation will use
the single-buffered write for SET_FEATURES cmd.
As  ONFI_SUBFEATURE_PARAM_LEN  also 4bytes, a single transaction
is enough to write the full timing parameter in SET_FEATURE cmd.
Matches Linux Cadence NAND implementation to ensure reliable and efficient
feature setting.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/mtd/nand/raw/cadence_nand.c | 55 +++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/mtd/nand/raw/cadence_nand.c b/drivers/mtd/nand/raw/cadence_nand.c
index 27aa7f97a45..7093343b7e3 100644
--- a/drivers/mtd/nand/raw/cadence_nand.c
+++ b/drivers/mtd/nand/raw/cadence_nand.c
@@ -2140,6 +2140,59 @@ static void cadence_nand_write_byte(struct mtd_info *mtd, u8 byte)
 	cadence_nand_write_buf(mtd, &byte, 1);
 }
 
+static int cadence_set_features_op(struct nand_chip *chip, u8 feature,
+				   const void *data)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	const u8 *params = data;
+	int status;
+
+	cadence_nand_cmdfunc(mtd, NAND_CMD_SET_FEATURES, feature, -1);
+	cadence_nand_write_buf(mtd, params, ONFI_SUBFEATURE_PARAM_LEN);
+
+	status = cadence_nand_waitfunc(mtd, chip);
+	if (status & NAND_STATUS_FAIL)
+		return -EIO;
+
+	return 0;
+}
+
+static int cadence_get_features_op(struct nand_chip *chip, u8 feature,
+				   void *data)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	u8 *params = data;
+
+	cadence_nand_cmdfunc(mtd, NAND_CMD_GET_FEATURES, feature, -1);
+	cadence_nand_read_buf(mtd, params, ONFI_SUBFEATURE_PARAM_LEN);
+
+	return 0;
+}
+
+static int cadence_onfi_set_features(struct mtd_info *mtd, struct nand_chip *chip,
+				     int addr, uint8_t *subfeature_param)
+{
+	if (IS_ENABLED(CONFIG_SYS_NAND_ONFI_DETECTION))
+		if (!chip->onfi_version ||
+		    !(le16_to_cpu(chip->onfi_params.opt_cmd)
+		    & ONFI_OPT_CMD_SET_GET_FEATURES))
+			return -EOPNOTSUPP;
+
+	return cadence_set_features_op(chip, addr, subfeature_param);
+}
+
+static int cadence_onfi_get_features(struct mtd_info *mtd, struct nand_chip *chip,
+				     int addr, uint8_t *subfeature_param)
+{
+	if (IS_ENABLED(CONFIG_SYS_NAND_ONFI_DETECTION))
+		if (!chip->onfi_version ||
+		    !(le16_to_cpu(chip->onfi_params.opt_cmd)
+		    & ONFI_OPT_CMD_SET_GET_FEATURES))
+			return -EOPNOTSUPP;
+
+	return cadence_get_features_op(chip, addr, subfeature_param);
+}
+
 static int cadence_nand_chip_init(struct cadence_nand_info *cadence, ofnode node)
 {
 	struct cdns_nand_chip *cdns_chip;
@@ -2208,6 +2261,8 @@ static int cadence_nand_chip_init(struct cadence_nand_info *cadence, ofnode node
 	chip->read_buf = cadence_nand_read_buf;
 	chip->write_buf = cadence_nand_write_buf;
 	chip->setup_data_interface = cadence_setup_data_interface;
+	chip->onfi_set_features = cadence_onfi_set_features;
+	chip->onfi_get_features = cadence_onfi_get_features;
 
 	ret = nand_scan_ident(mtd, 1, NULL);
 	if (ret) {
-- 
2.35.3

