Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D64CD4F54
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CF74846D1;
	Mon, 25 May 2026 04:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="VgW+JRZU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 694CB841D7; Mon, 25 May 2026 04:44:08 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C5878465D
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 04:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNdYIXxsprfl/S6ChcI301rIMNV42E4WXsi6eqSITJvpfn1aacr7wNvbES7tOe/OZpxGlJRgjnPVBxLD9deimFwUn6Um8UbVhPWEtecLBt1ZHHB5gNGcF28cr9PxA8KJwjzPxQmzNCo+GS1nhvsMxqT/sOK0llGspFIqBqP/V0BvvE0xXA6+860IA8Hn0JTUsnAOUzsm4+9N38HjDwaYsyavUat04ctCu/HnEAl4MIrbnGhpZDG6GeuHwo/9tjrXjcPaEIigm3qRMK323Zqua5nkRfrKzGvjuEFMY9z1m7VN1/Fwhq6E9rSLOWDzjqDLne+X/hxro6NMEiKN8ZWD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEzIzg4HqV8Yuim64iZGcNsqJbk4dpBn5V2t1MBvAVI=;
 b=USL8xlpmy17a46Qgg4gbi3ro21lUn6m/EWjIPg2sdvJUSA7WGQG7RGJNlSbj9Y13lhGBbzpHo04Cr/YcKsuxzNBAgBFWNUxZwPjiRfQynOpHC0Tc/2GkypuosFqvAcuyTmFMR2meaTTiOyG4S7LHGTF1N0NK3jtJDjTaxb8MQzEFpBncKO8LZgIaAQOsrQw22YwcnPTMUJirapnge4aytzj5s5uUoQ1a4CkFnck7+LthZpljcTmAaR8fmNAPjQ8zvDEC9TPUSV4GYK9df+qF0n1JyebYMzRkR0ySCvTpFaw9EpDXQE2OBllA2Pu/shntij3SwyzKvGkWOMQEnvOCRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEzIzg4HqV8Yuim64iZGcNsqJbk4dpBn5V2t1MBvAVI=;
 b=VgW+JRZUWnAwGaiUUkrNnbWuDFGoCU4lkgcRxhBBvjVaPUSp7PiC4jUOFs1W1p2M9IgN9ug7FIMWsr061p3Z05SIBCREW+kI64TmU946u8GkqzJ2HoGadOCCR5+VuNjO7lNjRO2VH8zmEt/9JntWPc/Y+iFAMpeRnu4M03Gu13FPh0Ew1f8+J+S66CDwMA4Ouy0V/O6xZUEU5+VvXQ2fQlKjuvLDddkSxHwHPXMdMC2kOWTygH38Oh/mJGAywQhL6BsuRGxucfif6PF/NZ4EzxqUROgH9nrWb7kKlXQBkfcFILkaRbCXmQSIzTTsGn0dwRXP4ZevMMmmwrtnIvIqOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AS8PR04MB9191.eurprd04.prod.outlook.com (2603:10a6:20b:44e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 02:44:04 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 02:44:04 +0000
From: peng.fan@nxp.com
To: stefan_b@posteo.net,
	trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] pinctrl: nexell: Use dev_read_addr()
Date: Mon, 25 May 2026 12:00:33 +0800
Message-ID: <20260525040033.2367042-2-peng.fan@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525040033.2367042-1-peng.fan@nxp.com>
References: <20260525040033.2367042-1-peng.fan@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::11) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AS8PR04MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a95d46-c348-4dd0-5ba1-08deba077bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|19092799006|1800799024|38350700014|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: FL7B5VlLnoMenUSsWpUZEioMPWM/u0WJ3rmZC5wlDW+RUUESFcexUuZmygItr8PVRNtD5RTrH+AX0Aw1M94rz4P66SjCMlNh2sVVdHDptfmv076mPF6Ea/jSXfhIfYcYx3x7HM5MQgmfDhFsT09LI2c0VD0kIMhRFJPLwDLrlhLxdLA44Ovh0ql/enwgxAsZ2b9WdUMDjIxLqi1uBvrS+t4o9I4g4SXhjaIx/PYSIHYcXIJ2ohQmbAxawLlwo5ce11/OsN+qAu9SOgr/N5gud79AcI5wHmHRFbrXVOMjgpOeYjRavLAQoiDrgnpedb9wB/yBBgPKDgMRzuJmjbZSjcg+hO6lfhWmFmJdGrFuDf2UNCxsSd417eWO5wqo9mT6qOLArWSX6lSO3HTef6PZuFN6u0qKKMlAEVEt4vNZQPw6XAwsHMFAiMoxZDYvapKtwg8VBJN1tnPBJ+51GrB70yWUn9yTXg33SZCjXebhJ+3tHtbSG4UE1xZ6YdfhvYmV9O/9C7S/7bQLMEMTZxLXxD8bIi+VmTGVPESvC1F00o5NO/WgjGspXJB6F/R7a0cpEYvy3lBOmbmdohPwiB2X5LbXedgSw3hV9CUX0MDNHwr8l2Kpz39KSiouN7R0XRX3ppTzM/pAKnyoytZ1Vat3x7WSl1DYOTKKRlfq1qWL/Xh6kAEJH+gVChWM1dyPV1fjxRCED9MdeEQbFsEcRsr4kFgwIJFhmEg6IiT1SLpX3Ox0VcBgrFQYk+nwP6qAN+eF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(38350700014)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lWpUduCUXKInlhyk/lNb6wrdd0ygsi3EcPC13UKODKqR4QFQxpgc+MailD79?=
 =?us-ascii?Q?Fo/IAbETfsC4Yamib0Gkykek2zAM0+lIHbjQUzNEn02JQy5TV7ZYs+n3PygZ?=
 =?us-ascii?Q?cq88FhRKS0ZMg1GGVL3pgFMo5AoB5oI1MmU3HwAYpmuFL4CZTNIrU6ZM8rDW?=
 =?us-ascii?Q?oT/49qHr0V+gHq2qoqdGXUeOf78TFbTv+PVoEYsKheZXXempMhowtway6OG3?=
 =?us-ascii?Q?+pAvryKdMW9vNVt2jWPql8dZyMGyyFkh/K9jlk/7XA1ZQCp9XEhBpp4PQ+b6?=
 =?us-ascii?Q?8QGWj+EuEnRuKl+HvOjpjnQDiiFp5yz5c9MNQrL3YUqnOZD4uo/HJUlKQV50?=
 =?us-ascii?Q?7/IUvKJJuTuYFt/7xTba73+JUzSBOopQOjzfx3n4LwHYEXg6Tn3XJh26Mts5?=
 =?us-ascii?Q?KELulPr2YzIh10408q14m3wINo6O1h6CEgX6j5WCKu9GQOUo/qV4mvWtE05T?=
 =?us-ascii?Q?jjBcgSLWQRX8mjSoYZpWH91tAUT83TIalnAfi2MtLd03p+UHxnPr0Zc8JRwZ?=
 =?us-ascii?Q?z0Al7V4ekBsjP1dQ8XiYlyiMQm01UlCxQRkhX5Xq5sjlX94dSNt/V8NDOlCr?=
 =?us-ascii?Q?muFeJd5OX4dGIdYFGUGCjUm9sLd4z/F6hXOEPgbJCdnW0BO7dzOWPEfa0kNK?=
 =?us-ascii?Q?78gvuogd/hPFkkJxGZ77rJpjnm6vYq60L5at1V4vZyZplrMZ43JWIeOIZcIz?=
 =?us-ascii?Q?7vi9jiLz4OPFplMlQidjBpn0cpZm96nkE3GgQEXbF4Q3cuuPrh2jWfGgkS1j?=
 =?us-ascii?Q?Bmba21Z2hjyNqGL7aKTyiSmw6Af0/xfSy/e+GDuYGHmXj1f8mJgQLvorZTx9?=
 =?us-ascii?Q?rIq8Lerv0K6zWkztD547Oa5XVN1eB+sqN2Z+6hqCFj27QHfuzga75TMjfHtq?=
 =?us-ascii?Q?Mi8NyVaYGp5PSjwP0ACUMMGXs21wJrt4ynxzfF4HDlF6KegSnpv38n9O2bYs?=
 =?us-ascii?Q?J0o8A7XnFbwEOgizCBCe2zxUBvAgHsnoPjjxf7YxURd/vnQ/OToOjZHl0xTs?=
 =?us-ascii?Q?WI1nJFDRTb7OAwlMFDxi3s4wfO7VbURhZbXVQ9bqXJLSuhGnWeYBwItQ3Bfj?=
 =?us-ascii?Q?r+C9WXhYDMfzmYH4Eg6RHK0/0zQuaWQLWzMcZDAt29jxflclRivV6DCx4iZ2?=
 =?us-ascii?Q?0ugpcE2Twxl3ieQytVJfV5dGx/BVf7LN7ZzGt80KnykTfLjPoLhhgJkrsLJk?=
 =?us-ascii?Q?uI4LxWNq9qKxciAax7MQAHesb1ja3Li9ZtBWjWMAVvNEQCdJc0psA9Yrn1bb?=
 =?us-ascii?Q?fhVyyeTFdeLjT9XEjJj3Py7uP0VoAFI/GlCufwwy+UQE/n+GEue1ewEe7unO?=
 =?us-ascii?Q?/R41Z8DAlXqT0wtUqJIR3K/wvrogKuZefYusAOTXNpzincqKo14bkxNNDBLd?=
 =?us-ascii?Q?2KwararRQOMYU/Dzcn9dIM5y42LY7jHGSDrRuxjcgMazDswXmB3ajtosLW+u?=
 =?us-ascii?Q?BoWq1RS6TbKszIvYVy8lsEoTHxcz3HN60aGdODa9BYbuYBshxJA4FFuCMxNu?=
 =?us-ascii?Q?brmSLWVAN4wn2D8QBqpAC22ukUsfhLRi+jndKbCF0bXlD+B0O/IC1tpowAhl?=
 =?us-ascii?Q?yL0zlKnTLsNrKaTpKYDmx8mp5wEHdPcfk2hVM49msyVSb5FKFAIUwZMGl+rn?=
 =?us-ascii?Q?NuEnN8uWOX0B7T4y0LqQN+CaPcCSXJI2uBEc+BKf2Co3rPAYy2PK2zSt2I8Z?=
 =?us-ascii?Q?BX4KlZ9/R9QcamuODGFwKmlGWSIHaJ7nRvg5zJSqrvCVYhfpbYKwrG3E69Ln?=
 =?us-ascii?Q?8cxcfwrzrQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a95d46-c348-4dd0-5ba1-08deba077bd9
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 02:44:04.0902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vt3I6wFT2PNLCPrjnRwLyoR7+Z5FCMy14LyQ0OMZKJHxVYbkiFs+eKzotDbnXgAtjknDJGigEuh2HwB8efdCUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9191
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

From: Peng Fan <peng.fan@nxp.com>

Use dev_read_addr() which supports both live device tree and flat DT
backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/nexell/pinctrl-nexell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nexell/pinctrl-nexell.c b/drivers/pinctrl/nexell/pinctrl-nexell.c
index af1acd91649..bd89e779864 100644
--- a/drivers/pinctrl/nexell/pinctrl-nexell.c
+++ b/drivers/pinctrl/nexell/pinctrl-nexell.c
@@ -49,7 +49,7 @@ int nexell_pinctrl_probe(struct udevice *dev)
 	if (!priv)
 		return -EINVAL;
 
-	base = devfdt_get_addr(dev);
+	base = dev_read_addr(dev);
 	if (base == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
-- 
2.51.0

