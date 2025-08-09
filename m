Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2074CA0EC0
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 01:07:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABFB4847E3;
	Sat,  9 Aug 2025 03:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="bvK8knH7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FBA4847E3; Sat,  9 Aug 2025 03:06:25 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E93C1847EF
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 03:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHeZBwGdEZ1rx85Sm/Qp4OI+UNyPUVz3IA+Q4XeBGhSwQU5aj7PREfygSjXeA9oQ7qq6OlwN3UF7tKDaWCOL82+PZmhw1ZDweT/h50EzkBJf4QSvkP2PM0zs60lUiIaqmBdRhyq3Q0WdoCGe1xtkJbdDtUkZGwIH2VgzdZZ9cuIqWx7EyYP+nMkEwTNZnD4ldNH/Lw61ObA0k4staG0p2uja1LprSPmxW1lVy/DMIf3yob+ZvrpxtZRKSKpqclQcxJWLqxFOiK+JMVkU6DjNCeGC7pv/2w+AOUQG7Oqqe4GfRGmwhTW+bZoLuhHsbiNgNy1qPn5ByhDFfssDV+UfGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QCjov8ihAo3FzH7L9ytPOvXj6H8JNJdiU4OuW395bI=;
 b=QXknCTSt1NPzRKAMZp5fQ/uy8gKGLoM9XkgSGTGq5GlyW28Elui9nh89UbThoQYPkd0oJY2vvEjrgvaopFuypyS7CHPlPth47rlN66pbHdrD37eIg1xQqlG5I03O+KKfOErC1BcJDwy2iecckgxQWXHsgkAko6aveoQ9RecHW7gcSmcGbEDCInbUBc5qi2gmkL5rj0NtxXqHKSyH/XWSjGWhRuMfATqPyxF+ZNj9f/TYLm4VqEklksArJSoIe/CbLhS2bqqNEWbbFAavpYWgbOd+kKislYqsuRxpE1FRSC135dcGn4mlK1rTqW83FcvD0fLYm3dlfYuWq/ZiY7pFmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QCjov8ihAo3FzH7L9ytPOvXj6H8JNJdiU4OuW395bI=;
 b=bvK8knH7PNvHFR2gLmq6lyLDEBNfp/2l4GOyH/OqQaSg7G/8N/oy320Y85vjJTup4LJmMFyuOwzCIJeOdR1QIlm9JLXjpGMji2K1eZYzEcPOo/AqH0USS8fqhZKREMQzuiNqQ8KXpPqxz1L+kR1cDbpfvdS1hvSFKiEW/kLHr+pMX2m6u/DHRYC3x7dqoIMtUos6k6EVVoqWoOzTotRHK6RvuUTFa6+ZUGEfz/8bW4+xK1yrLIj0IdeLG+2KvnrarUfG6EDY5zfWsFF7NBxra5+2pYZ/CynAmwGHONLpJr9mNhMHMVM6XqoxSm2q7vafjJJ/b8W6iDt2Kqt1S+yJ2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9582.eurprd08.prod.outlook.com (2603:10a6:10:44a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sat, 9 Aug
 2025 01:05:25 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:25 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 16/24] mtd: spinand: Add read retry support
Date: Sat,  9 Aug 2025 04:04:48 +0300
Message-ID: <20250809010457.3125925-17-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::29) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: 69044fb7-f3df-429c-f067-08ddd6e0d2a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qsuT6lSnGmqZkUM+brIURsePJDAbn5YXTQWCbJb7/auLyUDxuURp39/ldqr4?=
 =?us-ascii?Q?d+a0k21bPf9kDUxVog2JJ39ZufcXicOCv9FGPW6ZDkfGJZFau/iY1Pvs3T95?=
 =?us-ascii?Q?s7U+4IymfcBXLkQV8bNN3PQXW5jqmtJ+rXT/jCPHGpKcesQNmS3+rqMwsJ/g?=
 =?us-ascii?Q?17YnkPcjG9UHKhh2SMNGyrJVC4R7s933LvCgwRqGVIGfMyChK9wL0ZOKQFib?=
 =?us-ascii?Q?Z+jAVAu3ypZ9A62YjoALGgw4qtSjPv7ksR8SKzzEPyVuRAl9Bl17anUUpazu?=
 =?us-ascii?Q?P7ruzPLZvzWFPmkyXGl2f7ah+wSJUlt66uaS0Q9gQV7TjI92fFaiZFncU2Vo?=
 =?us-ascii?Q?qUcux4l76CkEWKOpg40F7ImwBipABaVf7lGNo8uZhiBAggVuNHsC8yV2Kg5f?=
 =?us-ascii?Q?+lIcd+3g5aY0zv1HF4IDM+zTfmZtTq04/FHpQp6KHn3iu9utIWsRX4KBxCHj?=
 =?us-ascii?Q?GnUO0WZjHRy/sgJDrTUqzX6tTVzlV8nf3gyzySpdxnMJ4E8Y0l+8kC1leUOK?=
 =?us-ascii?Q?2U9ObXYmu6n8GrbuaSIMSLavFz/4nbjWTZdh9IMcer8Kol+jjkxTFnNbbXeL?=
 =?us-ascii?Q?MPSdx2Ps7KEtRnK6wKDmWmNMxf0nScF2/8Mc0N+LQwQmXTKkHjS9qjW0CASl?=
 =?us-ascii?Q?iTNQ9o1oSJIUO1h9dwshH9fQ5Mt5RqXc6UM3/sFkA19ziyDm/KmTNC7rB2qW?=
 =?us-ascii?Q?30BmDApLlAWnbr3nso+YDHYmD4UhQD0FysabIuM/9BKB2VXDmP0itQqrMqdn?=
 =?us-ascii?Q?Dg/vhatdKMjTOfpoCqBVCNb2ACkzO2lVM1w/0W0LEuiWBt8VoOD4wCMpRLhF?=
 =?us-ascii?Q?P4mozJOO8M1LGviPCunz9gRdQL7JE+V+NnOMTxOmjZ7gNCehYzsC+vfTVXuE?=
 =?us-ascii?Q?nixMN6TtZut5ShulOm2SlGr0GVftGxIICpZyAvEsklNMiZGodZRH1ayzJ/aQ?=
 =?us-ascii?Q?yGGCA368K2bKfjMahNLTFZumzEIxD1yK+DwRd1yeNFudi8rS57mQjfIGRYFc?=
 =?us-ascii?Q?dWyloKEVp9xvt3IZSUEXFSQSHKAqUBbPKt7IynuELGJ++T26m45+bg88IlrN?=
 =?us-ascii?Q?jxadV4xSs7S1kzr0a4vtTRyzTFLQDO/gQyN7EZTTEHmEmO7FYh+zatFFWWLR?=
 =?us-ascii?Q?i6O/leXd3+eBetj67YeTqiVrb/KIvnl8zkkEyOtgDTTXEf+T3kaC50FjByAE?=
 =?us-ascii?Q?+zayLVHlqpo6DKsN/lmfE3eKejBs2LtW3T/SmaYItQqU5MWtLonLezBrEdXV?=
 =?us-ascii?Q?nw63OH18JiWi8dhGZ7hHbT9C0ZFEij3FhojfFdVRMLgS57En7nWalwwjnQq9?=
 =?us-ascii?Q?LuRj51T806QfSpZLvFrEqKtvF1+kVrpxx5ZgdjlgYg3bgAlyJam8nERFXaQK?=
 =?us-ascii?Q?qSBofoq3wQXt3O7uy8DcHplr4rkjDUmCM8F8YMzw62Y08guJWeb9F40uLv3B?=
 =?us-ascii?Q?7OT1dothoiORPUCYrAOyyZ6I8J/HoLM1XZvgp/rw97xNCvEzBVFSAxHZoEWv?=
 =?us-ascii?Q?3918NjYAWKqDSqc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YlXtUaLIYJ6t5DMm7KS9WX07KDrgYt+RLZdHmAH27BrhgbZfJWEOraMVFW7d?=
 =?us-ascii?Q?B02v9pdueNYm67jX9dyvQ/pK+ViQBTWZ2lAKX7GAqlm9I+OLhyhVXPtX9GB6?=
 =?us-ascii?Q?QqO6SRmDwgoqKHz3xrT+asdughpVJdmoHBgjDe+wTeqG7daOcgQq58Y+k56M?=
 =?us-ascii?Q?95vReLCfFoxDVWq58j2D2l0ru6MDBuJxesr5O+3cz1AnPF968Cl2Ij7VPBkk?=
 =?us-ascii?Q?vQ9OYJX1b+NYy/G+WNqigYmHsp1Y2P0gLQIY0Ce2BmTykC0emROz+b+Y5cWf?=
 =?us-ascii?Q?62YYKXjLFwahsWsVg2NvWiYVizLuANbkfJ2eUCmDgfiWkzkWhX/5ff3uqx/6?=
 =?us-ascii?Q?VpxjcGRvIg4i+FQ2nXcOLGr2gI7zKasnUA1r2XWnkkHYSrYRxZU5p9iUq0t2?=
 =?us-ascii?Q?PK/nYvmdTmuY1R+9q51WmwOF02TJ1uFF0qgy6a2BvahNnIXuH5gsZsymUYif?=
 =?us-ascii?Q?7WzGYLY09rmp68giCxTwUVb49PrqArruT48QZc6e3aKeVC/h+TMl4RxqVACw?=
 =?us-ascii?Q?ivR3+VnbKCQ56Iv1yUhKPOQ4rLLm+V/Ey/7FoSEnYPdnN8jh5O46GG9duH4w?=
 =?us-ascii?Q?s6bqUNEQZPIjvQSNHTW/XIZHAME8dpMScdW0cEO4vu5DCpTiYdkUDu+ZxeRo?=
 =?us-ascii?Q?f86552otp5lKZckwGtyaFlmIiVCYxb2vVBn54MLQEJUNtq2wu7y1nRmC7+BX?=
 =?us-ascii?Q?0lj4wdtdZ/qEutJEsIBmIJOEFYzDjswwAiY0itGUATnc0ouJxopYl9VaYzjX?=
 =?us-ascii?Q?WD3S1SFQu6X1X2UFLFh36rhaKDSPyLqb9WOpW+Pmg/3f0zluk+FG2KE4BxuB?=
 =?us-ascii?Q?Q8CyS4DlCTmfJC9ihU1W1l1niO/brKYiDLsArW7rl+8aH8XrYUYbXvxZgjm9?=
 =?us-ascii?Q?jVCYOuXIegtKh92+2K1ceByzEHGOGmpCW2G6tonDEeVBfTtwKHYA/uJt88UK?=
 =?us-ascii?Q?PEqDtoLiw6oMfF9l+AnsRDiRYcbwVicMwq1qYXcnFoLq0ptm+M/DLNsVVykc?=
 =?us-ascii?Q?nOwH0KKKHtZaPWGPqHsE1WemDfayyAUNC/hVPJbK3/g+n2Mtv1BCLdOAC9XG?=
 =?us-ascii?Q?/LWt7fhXK+pqDtB0OYSUk3zl4msIG3M4O2eeMVlDy9Dc5FlxYABOTpNc6g3/?=
 =?us-ascii?Q?XfJuZ5IJroeM5If6EqwaEqyiIGYrK1CqWyknMKSb7sluwNqzIhT3O+YkACTQ?=
 =?us-ascii?Q?xNBHdFD9utpWbShRamM8cBMRa8Wshs78D5Wmi7YPcBP0uki1ICya50t6aCtu?=
 =?us-ascii?Q?XkweJ6dSV0PxtdizfKIxS1qfSmgVfWeVSivRXQtjcy6uqpWG0f8AkEioiXE+?=
 =?us-ascii?Q?6G7L2Ip2j9vHwoyKD3ExUE/HDWHyqjbqTErmjljcCC4O5OeZxa/Y/fHjU6VA?=
 =?us-ascii?Q?3lVWJjSfOAEmr2Gzu3cYKeMVNR8nJcN71wm4aOg0cfggH1LmkgO0VA+q7do6?=
 =?us-ascii?Q?OMBHUYLxlZ5c8b1AfUmOFbHhgQB2TUDmgGASC2Y/+MbykSCISwWt9bVBB7jY?=
 =?us-ascii?Q?W7ea/GZantlmxekFPkGVSmkoRphYfbnurxe1ZQv5OfTFf+3n5dKIHJW0W5Xt?=
 =?us-ascii?Q?9Egob4sXDtaYUoOH6vm4++gQEyRUd3dwCfHlP7vBlWhJ6HQb/viBqGIk7c9j?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 69044fb7-f3df-429c-f067-08ddd6e0d2a0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:25.2800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yt4HZAhVWq6IIKpK9omnWQ++BalsB0BUN0KIqJccASHxi/aaAfCe+LziQpX3RzBH2SizLtixEevuqIaYNVSyHDfr1TYR3Cd5UGj45tM1H18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9582
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

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

When the host ECC fails to correct the data error of NAND device,
there's a special read for data recovery method which can be setup
by the host for the next read. There are several retry levels that
can be attempted until the lost data is recovered or definitely
assumed lost.

This is the port of linux commit f2cb43c98010181b532ff36643731dc2442b9b7d
(mtd: spinand: Add read retry support)

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 35 +++++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h | 15 +++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index a52cc91dd3c..b3418624e3e 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -675,11 +675,15 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct mtd_ecc_stats old_stats;
 	struct nand_io_iter iter;
 	bool disable_ecc = false;
 	bool ecc_failed = false;
+	unsigned int retry_mode = 0;
 	int ret;
 
+	old_stats = mtd->ecc_stats;
+
 	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
 		disable_ecc = true;
 
@@ -692,18 +696,43 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
 		if (ret)
 			break;
 
+read_retry:
 		ret = spinand_read_page(spinand, &iter.req);
 		if (ret < 0 && ret != -EBADMSG)
 			break;
 
-		if (ret == -EBADMSG)
+		if (ret == -EBADMSG && spinand->set_read_retry) {
+			if (spinand->read_retries && (++retry_mode <= spinand->read_retries)) {
+				ret = spinand->set_read_retry(spinand, retry_mode);
+				if (ret < 0) {
+					spinand->set_read_retry(spinand, 0);
+					return ret;
+				}
+
+				/* Reset ecc_stats; retry */
+				mtd->ecc_stats = old_stats;
+				goto read_retry;
+			} else {
+				/* No more retry modes; real failure */
+				ecc_failed = true;
+			}
+		} else if (ret == -EBADMSG) {
 			ecc_failed = true;
-		else
+		} else {
 			*max_bitflips = max_t(unsigned int, *max_bitflips, ret);
+		}
 
 		ret = 0;
 		ops->retlen += iter.req.datalen;
 		ops->oobretlen += iter.req.ooblen;
+
+		/* Reset to retry mode 0 */
+		if (retry_mode) {
+			retry_mode = 0;
+			ret = spinand->set_read_retry(spinand, retry_mode);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	if (ecc_failed && !ret)
@@ -1297,6 +1326,8 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
 		spinand->set_cont_read = table[i].set_cont_read;
+		spinand->read_retries = table[i].read_retries;
+		spinand->set_read_retry = table[i].set_read_retry;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.read_cache);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 2f8212e4037..44c616a4acf 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -337,6 +337,8 @@ struct spinand_ecc_info {
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
  * @set_cont_read: enable/disable continuous cached reads
+ * @read_retries: the number of read retry modes supported
+ * @set_read_retry: enable/disable read retry for data recovery
  *
  * Each SPI NAND manufacturer driver should have a spinand_info table
  * describing all the chips supported by the driver.
@@ -357,6 +359,9 @@ struct spinand_info {
 			     unsigned int target);
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
+	unsigned int read_retries;
+	int (*set_read_retry)(struct spinand_device *spinand,
+			     unsigned int read_retry);
 };
 
 #define SPINAND_ID(__method, ...)					\
@@ -385,6 +390,10 @@ struct spinand_info {
 #define SPINAND_CONT_READ(__set_cont_read)				\
 	.set_cont_read = __set_cont_read,
 
+#define SPINAND_READ_RETRY(__read_retries, __set_read_retry)		\
+	.read_retries = __read_retries,					\
+	.set_read_retry = __set_read_retry
+
 #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
 		     __flags, ...)					\
 	{								\
@@ -435,6 +444,8 @@ struct spinand_dirmap {
  *		actually relevant to enable this feature.
  * @set_cont_read: Enable/disable the continuous read feature
  * @priv: manufacturer private data
+ * @read_retries: the number of read retry modes supported
+ * @set_read_retry: Enable/disable the read retry feature
  * @last_wait_status: status of the last wait operation that will be used in case
  *		      ->get_status() is not populated by the spinand device.
  */
@@ -475,6 +486,10 @@ struct spinand_device {
 	bool cont_read_possible;
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
+
+	unsigned int read_retries;
+	int (*set_read_retry)(struct spinand_device *spinand,
+			     unsigned int retry_mode);
 };
 
 /**
-- 
2.47.2

