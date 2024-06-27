Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC6EC3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAAA788590;
	Thu, 27 Jun 2024 13:27:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ppp/4JHz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E55238852C; Thu, 27 Jun 2024 13:27:06 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2B7E87AD2
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5eYBvZqpQNOhXTlNSTM3kt42Lm/QS/R0tPYeS8SebrkNs20dWYxBCZwRpn2p3GLvNyz2P5GxvPLtN5Fuw5VNtLuPf/Lx4aqNL1UMfNziAMYQ5HDDbnwMS04+9W12Pz5RAhFyPQuOVbIFPCrcxFdcmmYO9XckAyX3rkXl3fh7ZOHvYHhj52r3Hqkt6cpm3nXqONUZSzxNO+w+EpT3PbdZmXGwD2L400EwM3Z+YeiHErTVkMX4jqKVvEO9f92To1ez0fqeK7t8f3j7Ht1XIJW4wwOsHoVKaQc3QuAYed8PjVtSuTsJnG7VvQwh5+q6LgfNCM+6yIwiasWyO/iDJqe7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCB8eV2EiujCZAfXfqBdcO7j/C2oUz3aLWj5yvDAHbM=;
 b=Up1ShUXA0z0WGltBX6r/MGbkd6UJQvzMFkowuGhzIu0URJj3vSnEY10RGBM2uD8P0siFQzw2ZFRhIsxylWVt4kQRypWI7Ek0zCPkJP6UbxGTJ/fOsUeeVnNhIt1A/ecGjSzMOKSKRwoQ7FBQUpJv1QJvjH/I6g/EAA3W6pAxlMobkUgRwXHzCo1GbVGTptsnUNYiuB7fkANYKSP8SCmrU4rb9uCzyx6Ueye1iv+2uZLr7mNORf4T2GnvRpOBxeFTFw4nW41A52rzfNMI80uOd/is/LBE7QIO3Xg09k0RkTOYntXWhs2JwUQD1by7t4QAk62pRBtbBH0MKQXLtH8S5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCB8eV2EiujCZAfXfqBdcO7j/C2oUz3aLWj5yvDAHbM=;
 b=ppp/4JHzAO1d9yK9/8HOGCG8PBUCpZxeaCmGBqDLosWsP302DtQLiVAp5YPBikX5CzIlhy6TLPr5fVK6/3AcYnfmW8mxFwKs/0Bsm92mjeOUCxTILDIHMdmCqigxRJtQPwikzO7vBRKgqD3cEAYzb4b+WdiICE403HDqFKoo/N7Uvyp0h9NZGb9H5dEvh5F9J4K2y6R6HpBu4OCGDNThJrSJG1wCMi9Qfn3saz2JcoTHnskIBSHmdYf5EuwCCF5wkJtEe3/jqxrFGa/EO3RziGrRUul+I0P0p1GaWrG3qqG+NTtNU3qRd++6zkNE4ebYNAnUCAx2OEDFZbBN38MkSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6686.eurprd08.prod.outlook.com (2603:10a6:102:13e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:27:02 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:27:02 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
Subject: [PATCH 3/3] cmd: mtd: add nandtest command support
Date: Thu, 27 Jun 2024 14:26:52 +0300
Message-ID: <20240627112652.99818-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627112652.99818-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240627112652.99818-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c51aea-e9fa-40c0-88a0-08dc969c10f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|1800799024|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BdN1ird/K2/mGg4FVa2oxfKLDcLLiR0G4mb7yBODeIXjJuOqbWFF+bcgnodW?=
 =?us-ascii?Q?meDjgDzzbtL3znwRrZA/3P1t8NIjemZmaECXTa0UhWpIppK08jLClyhXMbAA?=
 =?us-ascii?Q?02w4ly8XwQ0CiK8tIwBbqftPeAEysO9DH6+ENuUhT1HLEArn05BWcRnrTmvc?=
 =?us-ascii?Q?nYnunBmCYxKnZSy8B3xdUQBKnU83idZgQwvB3wHIyk+71WHuvc7WfWrMBpV2?=
 =?us-ascii?Q?gJFDba0rT5DQ1uPyWphj+sx3eWJnIv8PNhmbJvFhpPTi5sh1ZKrQNSglUKQ7?=
 =?us-ascii?Q?H2cRYU0gatkZkuN2NWhxQkNd4d6nn69LB+wz8Twyrsy5OzDofAFxNvWMttJs?=
 =?us-ascii?Q?LVrlVzyFVORp2YB9gscPfHw5xfReDO7vU65OwZkECV7ysUBwbqJQUMkDmZ3e?=
 =?us-ascii?Q?Em5Kl7nQP9m41LTttboL2R6kf7o5HqujjYzX5LrQim28RmckBEGCIUaJqjEn?=
 =?us-ascii?Q?uL1UC1mnWXxGyAZPw5V61rZrJtRW7Nf0BZeIm7doRnFwTilePPMAoQb+nRc3?=
 =?us-ascii?Q?BM3YDGdtOn7L7ZY9XoPmH4HRgYmKtT2qEV6LQ+ecktPOCI9OLAqBDicFdW++?=
 =?us-ascii?Q?HKr1iRdEsdET+LA6gLVZhE54/0QctMyJbGBD6sjXFaNer/qNyUfdHb2y/kXm?=
 =?us-ascii?Q?6a6Mt88NLEOX1RJmpvnWpsNpFmdVqRjwvewbBqSLyv/dMXOX78rYFdwFGXrc?=
 =?us-ascii?Q?hh0W6sV4+lZ0vPdppmBisJcRBuixS+xYH3ZOw1fX5pBPPsDkH6hl/+mn10Mb?=
 =?us-ascii?Q?i5T1EPb/zJ/4y9k+ao1UhANAMa+t4idfYO13K9E2PoNtghdHkDjwOEw5d6UT?=
 =?us-ascii?Q?SIISQSEU3o42ENOwuQ98MZ8CV/pabgdA/zyo0Sw6L/DHVykVdIl0X31HaUq9?=
 =?us-ascii?Q?nhmyDfMAygtsNN6cYJhYt11fUNo0Lbpu0P9MJeHlSh8qob7mZRxNg6+hJ9vn?=
 =?us-ascii?Q?U9UMSeo9DmC+cW79kZb2+o2er66z1CoumAV9BDh60dra5wVVHMFona2+LvSp?=
 =?us-ascii?Q?3MHMg2PWBVbf01ECFwYndaM0lFQZdJBtJ5p/gZTL29knqPd621VSjKoyFKFB?=
 =?us-ascii?Q?vQlDd5mHHFusczqcuP2ELKbXCzMQxaizM6Vx/6uuovyKJd+ZvBlG54i0kerh?=
 =?us-ascii?Q?jvFE0gjRgz0+qW9cgqG4ZKE+T2mKNfXERpiIWe0ZW62P5RYlQmDmuE1MEo/U?=
 =?us-ascii?Q?6w2qwW0cN1P3a28aDuPofVMULTGvktFykfcNB+I3pO1vK0ZUeqAJrS/AxkbY?=
 =?us-ascii?Q?qKVFEglhzV6gS9r1u79Je2Rh7RIIUhHx9i1JcGvDW+l9BVP/GTNfAzPTXiVF?=
 =?us-ascii?Q?AuS6ipLyprO288GzqQizH/bEkC+TRwsHw3uiX/iTrKXSbkg1sdZrWcT+Qo+a?=
 =?us-ascii?Q?Zp4Imy6DQoxnY4085EyLZNv7eQlXDPLvFSzPtYnF9cc/ZSxSpHp7bfPrUy0i?=
 =?us-ascii?Q?Qx8mys9e0oI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(1800799024)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P437nvuVazHDe4dfN9vbTqw9yH4znM33/6qqZvJoGiGzMOfVXvl+Om/hCO3/?=
 =?us-ascii?Q?QeWh2c5P+AKpYeJv7dcdAVfztY9VktIp811R3Plr3BDgoNVS5fIDDQXH+3Fp?=
 =?us-ascii?Q?8q0Q62rXQlFtBgKWnZwsGLnP93R6HujACiMX02SUTn9cP/iFB3EzkCZjlswB?=
 =?us-ascii?Q?L1NGB9StxNjJskBSDAKbPqYH4xL+0F4DL0ewb4VpUCvgQM1Nce+0xFMQuSoh?=
 =?us-ascii?Q?u5qqUeGqhGG6WAV4wLXpqvUwIGY1BAsliruO3sX8JYUpBdvKpRbwR+7fyUox?=
 =?us-ascii?Q?PdnxfOmZb8zB2Q5PwFjcvQmGpOwP5Ky6Cyhs309dZDXgvDM4QJm3mEZ72dlt?=
 =?us-ascii?Q?z5vk5QclGoRxRC16TYd8lkGwjt/HTj9y/pPg4dM7+fC4Wd+6vwRv9WNvTvs8?=
 =?us-ascii?Q?WKjR8srrtuvVjGDthjYGoigiyZCm8XbyMnogKcNoqL8jT39Eb/HjRo/945YH?=
 =?us-ascii?Q?Dmp+w9SFWEJI4jG2DjG6yGEXn7NNU0+XNhJ4pXVDeiCaFFCMq45FKMzGszxP?=
 =?us-ascii?Q?pWtrXpjAE0eDt7EftZ+QSkfRB7EpfjzCKNRlQ6ei1+oyK5hfBsuNl+FxrakM?=
 =?us-ascii?Q?h97Rg0mVyUI+T3BUz6Ty6/rh49yKr0w0TnTFSQfbMTFOhe4IR0dvBA6L0mSY?=
 =?us-ascii?Q?EwKun9Y/dSU4M7oJjpT+WvUwKyQkacabpbndCiiAvE+KcS4vTraozzzSqRzT?=
 =?us-ascii?Q?fpnQu6h9fWe/xX5V7G+AcpjkqsdsNUOSuxMm4E2EsbnMCerGPNd2N3kogaXa?=
 =?us-ascii?Q?nbLT+vrg9rVKDf6ojG+EeAIAj/ca5K6T1MVd2zkORIlzkz89l0F8T2BYVKB5?=
 =?us-ascii?Q?eJZ8kM5PAPdtNoCbVt9Jzg6UKxMwgrBKftRtTm3s8qULOGgPm+KE0cYkj2mZ?=
 =?us-ascii?Q?CKUw136T0XuDY4bTxk0PevmVMinjzxGBHReLzDcxiD6FxaC+U+hTjke0wlih?=
 =?us-ascii?Q?buzxXepwnDGz+vAP7Go/r3ak2vY8fSiFzEDY+Y6gbJ6V1dWSwHNA6QZyHmn6?=
 =?us-ascii?Q?xI7dq6QDCYWI8QyXS8Vs0MB+eY4mUph6gUhlZoayobjBPlzfkLfLMqO9IoGx?=
 =?us-ascii?Q?MDeJRqZZeRN7b9X4tD+CpjWMrDVgCgCD1IJ8eXm70GRxPIf22cxJKqrW2Vxs?=
 =?us-ascii?Q?sO+SNUvwl1lV6hc6E3luhe8li+YW1UxbtoEMXE42Q/uj0xx37JvXFTPxhc4x?=
 =?us-ascii?Q?+g94LiPrQwQIOI9T8akM/FP0hFtAgHAKL2GSCtUpbjDzF5xixr56+znvUrv1?=
 =?us-ascii?Q?DvO9PNubXh0PtoFT3NhOriRJQ+A/gijh1Lpe1V4rthGealn8V0pIGHrdIZ3D?=
 =?us-ascii?Q?stIJg0psTanEvTTOH4v1+P64k0dlr2HzRmjqXul9pQtAMztcrl0bX5MvnVmf?=
 =?us-ascii?Q?yBExtt5DxejXGzdbfah1CS3AW39l8Hab5XBzstf97/8WOCQXVcPIfPHoBjov?=
 =?us-ascii?Q?YhOhqGvY3GZeCW334PUkpa5qx+N9D/wopW22SdFkPCGkwGbAenQGJBBvdhCv?=
 =?us-ascii?Q?1XTkxvidigcUaDCj+lVJtTns3XkQgM0h47Y62r6iPEVmmWO485QRuXkb+3ru?=
 =?us-ascii?Q?k/8wT7p7FCKOjS9zKfIGdmT66BQElWP0cBFtOn4lGnOCS4r8RlWPWl0eO0oJ?=
 =?us-ascii?Q?Vb/d9dPwX5rsIMPe7+9z1go=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c51aea-e9fa-40c0-88a0-08dc969c10f3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:27:02.4615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+7Q/Ij3p3uA8rQH0Sc9Dijk8n2IBy7LlUJqrhlvrrA8oFAaNTht4soIWGRpmeukmrENZJtzdfnSLsYh/LTr3LtaS12FQrKCScVn7AUj7co=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6686
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
index 0685b598679..d5cc6de93cd 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1430,6 +1430,12 @@ config CMD_MTD_TORTURE
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
index df4130b90d1..bb89e783d54 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -932,6 +932,202 @@ out_put_mtd:
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
@@ -1020,6 +1216,9 @@ U_BOOT_LONGHELP(mtd,
 #endif
 #ifdef CONFIG_CMD_MTD_TORTURE
 	"mtd torture                           <name>        [<off> [<size>]]\n"
+#endif
+#ifdef CONFIG_CMD_MTD_NANDTEST
+	"mtd nandtest                          <name>\n"
 #endif
 	"\n"
 	"With:\n"
@@ -1061,6 +1260,10 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
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
2.43.0

