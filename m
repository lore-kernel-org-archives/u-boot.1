Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A92D33996
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 15:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C42D8910E;
	Mon, 28 Oct 2024 16:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="QZ2/8wTH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BE7389102; Mon, 28 Oct 2024 16:23:49 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20711.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B1E489098
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 16:23:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yX60ouAd+SgstvChlCggblxlTHsfPQFqnaFbJsy59Qa6N76aA+ET4xFZqio7LXF2MhmX7qcFlDFA4r0NNzac6Kmabw7tQaLvv+GniejMk9qF6k2LmBqPwLHdlJOnXrI/1f/Gg4aykkLONQ1WbAhkhPIJbHXE12ZPv88CvDjiS2b5/0L3LkxXbw0jS23tyLqqeEmSOt7OTDco5Dju2N94GNHhkmz4z29n5B8DsrBuBhs2CaJptEzm5C8JgBCzugEJDMQVsSourZO3Plm8gfqSjJBI7gu25kMIStyhBcY6WcrL16qFF/Ra8+CcfGnJd7ypFTmhFwWC1X6VfIgygJyDLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hcqCRXNRos72Wxqf4jUAUE1j3chLlqsCwvdV2DOtuA=;
 b=ZYAuqPctQiKVqD0Gjh0BE8Wo8bvL5AcdwKyqY5F9rJwCz0ZUI806FKLr+TFfIZ/ZTEw7XSKFQc9aKd3dCAHefq+O3HDlc1Mjl4Fkfvs700ED6GiJZSPBZZ/yg8RjbM924A/M9wzUa7qXlcWF3SNd84Xau/kzwE2l6O/78krhM4THlnjQD7axDXC77I8PEjXiHfNwCKox05nN2jS7PZCddtDnJfgtj7pTTWzazf0wT8pH7/CPbvq/3GIXAnl9OGoZKOn9PLyCVV/T2c1YWeQFIiPGaHwOGK749Jovdp5sxdbYp7C5OXlnzIl8GZMmRfU/q0afQI2W1eqVHJmrI/3zdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hcqCRXNRos72Wxqf4jUAUE1j3chLlqsCwvdV2DOtuA=;
 b=QZ2/8wTH1hnyxvOXpnaYkZIy/YoDMVAMLeEcqnm799dDePC7SwbBYZQzD/nK+EWNoXsWbV6zcSA7Vw/NtGfwd55EgUDOFk5sxvqe5SNeGsI8jZaxFfIqL/t6gx/iAag14z0bL21tx/cLKJ7GgFEwGxqJ9O+sNEBleZAa52z2ehFjd04sRj4HNtEUK8VOO41eiM9Hih02mUaGA22BZVFwu/RL5YzLj4++cysakICodJxoN/ENnocPtCBFomxGIRWcMa2zqu5CdX7Wgj6z1VcwXJPpJYfQDkKdH4e9HqetdktuKvsjRRlIeULl35R5lp8cAlF8rAYRhaoNnxF5CgT9lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5697.eurprd08.prod.outlook.com (2603:10a6:20b:1d7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 15:23:45 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 15:23:45 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v4 3/3] cmd: mtd: add nand_read_test command support
Date: Mon, 28 Oct 2024 18:23:34 +0300
Message-ID: <20241028152334.1814929-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028152334.1814929-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241028152334.1814929-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF000045C5.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::43c) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5697:EE_
X-MS-Office365-Filtering-Correlation-Id: b6bed530-0f60-4780-6c7d-08dcf7648384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a/IFsxQ1hjigt0RB2/86MdQ+1L/dmGMjbp74JF4e2I+Fl2fwrJI/cT5zP+XC?=
 =?us-ascii?Q?05+oXn5DQ9KvqbakptakxgO8fnEyTxL+H37HQ/0pgyq3ljI1W1q7m0cG9xfX?=
 =?us-ascii?Q?dAk/auLYpvHt90s4rTlkJHGCAd2i7Dna8SXw7jb3bXtCZCS5rXflpL5awNU3?=
 =?us-ascii?Q?RqBKXLtgdv623Y/BQq9c2iL2UW3K2FUcBnKHszu8RNLp9HwRe1eV8OB68W53?=
 =?us-ascii?Q?2Z3iyfaZooS2PSGl1mgPecW2Ebxcim7tIQ1QlL8oepojn6aVNc6dFuGzKyBj?=
 =?us-ascii?Q?5P/32+ArOV+jemzojytDTTm8b9hW2kt+zAqtDGKXx7OVQoQNuCQfmGkQdGFa?=
 =?us-ascii?Q?hT+/cSlS2g7hARHGnk2FGDSn++hcg5/BaKIAN7QY2VQX+EGUimdH0J/xcRaS?=
 =?us-ascii?Q?DcZEcpQC1bG+GYBBkaArAY2sjQ865egdlMaGK/sSTGhvf4xqSi+RJz24tHm2?=
 =?us-ascii?Q?9rFUpVeWnxb9ToBmbPszoqZ7xUBpi5paJynJWpZKdfULqTLFUAo3KtJ80ykh?=
 =?us-ascii?Q?InEirOuosS8gjYo5nif3To6EHfRJfqH+IrJ/bcioOCfVURZo1Rw388w0VLv5?=
 =?us-ascii?Q?DBRX+wjtMb9oHz3084QQBPlsqSsMxD/+mu3uk/8U26VnazqatWAJ2BxqSuMY?=
 =?us-ascii?Q?HNr0N9ZlRNK/HSQmautRtT4ObBMeCQLbRLpTZ1L7irWIuyULpoL8w7NQU91g?=
 =?us-ascii?Q?Z/Kj1zEWuohprr2DAUrdzDXX9PY2A/sosZtPH46f2sont2X6wxo8LDif98kk?=
 =?us-ascii?Q?ZlCrzKIv1ywZ4PYApvrWDBXS8iAewgorJA+1weX/GkuvDH32oRf3ZONK0zTa?=
 =?us-ascii?Q?DfqANj1+JhlHjRjjT6YvbKWxcObrGPwYbxiaTidcK6azoEZvi58barcVQXcp?=
 =?us-ascii?Q?PJURXOni9gwmiN/HxIwhXMtQxqFUV/DaowTYNmO2uWrSyYf5NGykPUFtyf2G?=
 =?us-ascii?Q?90tpknip/2bMfi8d1HIIbcu1M8hEVwEulFEgnHssLwvZlR1wOb1RXK7EQDhx?=
 =?us-ascii?Q?Jyt4r0zxQy2YksVIznMQLCjUzGxslA/LiYnBIGBSCgC3NE11otcBDnZB0AwM?=
 =?us-ascii?Q?/LNPv+IRRMX8W3fN0lRv/3I45vSQ9DL2rDUXNJ+pWQB43HrebJ7TcSXCtDlp?=
 =?us-ascii?Q?tLzNRrU/G/p1EMnb8JOasowRZ9zrCApiqnQYC3PV0d3Wqh1j2vcV1MukSdpt?=
 =?us-ascii?Q?vYIgqkYPgjI3YbsbA3xkk2AAFW8UTIbPd78RzBxb1yIRVIw9Np+4pQNtSFz8?=
 =?us-ascii?Q?UD7VKJDVsYCPTeLnugWkWFSJmQSAlN/mlBc+xSe8rhn31CvUx6gxz1LEDWge?=
 =?us-ascii?Q?kaVyGJ+Bh/otrjAjYHbFjRKhNmbAIC9gB27RYhLpijfSdFYSMvqeRrEl0TaG?=
 =?us-ascii?Q?jJe3Yt5/bVale83oIaQop3by7SXO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pGn2oa+k9heUpZkH4ayeO3kv8fiACIJhBna7GFlYRwKJjIdrBnnPVbFk4EiE?=
 =?us-ascii?Q?tsnpm0Z6pWZVDArPh/0CXva7oZYyb73zQ1CUtDOxHe0r62IuRvV/UOLcIYBa?=
 =?us-ascii?Q?Lj37Vbr1LmcaN8PSqZSrnOWm4yg7zARyEj3Xj2tNFV1V1h+gCFDEnIctY9Am?=
 =?us-ascii?Q?uJFphFUHurgac44CKCxetWlOJx1M+f4Efu/5iJfRKqnPdrVK01J+jeLos0lK?=
 =?us-ascii?Q?gh6kBtOzjFAayklVlgUDIw+jKGixBGlGQz+vdQWkXTrwv/CFGhNoU4X4ArSu?=
 =?us-ascii?Q?ZWQ4c+ni27Zgig4BSPL/pdfIwnIhAiJ5+fN9A6oZdP22No//OxGJJonFUuVM?=
 =?us-ascii?Q?Xs6wLDHMgvIzMv2LEZq/W3Ya0CyLloHHkz7YYGoDhHORgLhePU701qxu07bO?=
 =?us-ascii?Q?gw/P2l1UXBzcg//tbRJGUj7DcJf728AzUhkJ/kvKs4KyIuE4ereCtziV2C/q?=
 =?us-ascii?Q?sBv+ar+hn6hCWI2JNiG2MnUzjE97YwrPGZ2lxxZpU1Fujq8qqb7t0cULoYMH?=
 =?us-ascii?Q?VftwzvdUF96tUzY9gWS1MCNzWoegHdLeqNacdMV/w5OaHgR8WIQmXqo5i13k?=
 =?us-ascii?Q?k+U6ACuZFTcM0A/wddNJZocsQpyJTI6rKPcO9/Ym9XlyXEC+SMKHtotkzdAV?=
 =?us-ascii?Q?NPmO0TUbqDgvJAyTGocGjF7xUwiw8pXftihXNCTiIqIzNM+JSf+zHZpwKY1R?=
 =?us-ascii?Q?m2h40LLMYjmoNtPhoeSbxNIUm/hqRVi1DRtIbbqaUmgM2BCw7GdQLi83QsHN?=
 =?us-ascii?Q?dm63iNA33hCje4Y4I8AhTUaZSqnQlvdvNNORriXUZBcJ8hIojtoIJ4Podb1S?=
 =?us-ascii?Q?Yi5c5JLY5EqRMOaPZzBnFmBvmvq4bMVNNRLqInHwP9gMz7yt5s9Loa8DsncQ?=
 =?us-ascii?Q?UaSGfTi8yyh+T2LGVrmnkSOnWCH5Q2fTDSNQ9Y3nPbAkUd+W2AktctutchgX?=
 =?us-ascii?Q?xq4Z7BsLTT2orJTdqYhPbDfbDnzug+ApL6Qg+H6fYbT12m2UvYwYIIbXPwc+?=
 =?us-ascii?Q?VJ8L0gbvUHWCbkqpa5ezCZBk+eO3TghL5/Zu+4M3Hh5DuKDiOchZVZKIKxgX?=
 =?us-ascii?Q?dmR2kPKFtQo3oFt4PQr2HCn+kvHmuRxWhR3Y/KAm7TS/C0grKO5vElAHqThA?=
 =?us-ascii?Q?YnJWidt6Yr5DrN6QlzW4fQCorFnsbTzPL/uamDpAlV1YBZm7Ta9a4Ykfk11Z?=
 =?us-ascii?Q?n37MO/N0YuKK6JdRHICyAYFlB2CXo+r7+NimG4y6bcC3ViZjHVSZjvV5gott?=
 =?us-ascii?Q?tfe84Xph7/39OXQOzuwvRt7Zgulzh2uaNpKBKvK/gx9cjw5yQaGbzifITKc0?=
 =?us-ascii?Q?IbpxF8X96mWA+G7r+ashUhxWhh+MmPA4vpo7ehB6a5KP2SjrTJfzmSqPaZQy?=
 =?us-ascii?Q?XWfLwrfe274WPcxQ9WVb0jI7cBlPNHdEIglYQMm85Uglyd0NuqH486VEe410?=
 =?us-ascii?Q?QMSTXRM3ZpJpkEhC6QUjEDewjPvU72belqvhIlfLXlQC1jtXsB8z1BfdTy+e?=
 =?us-ascii?Q?8P78880gb4zG2JddDUOOHmOqnF8eEFfIw7O3sHr9wRimv72wT7F6UeRtfPz+?=
 =?us-ascii?Q?KAvjeedqVhGoeVbG6rDAvydvdLbfnf2jk+vsoT56qFIH7NISJ16tsuu5cxYF?=
 =?us-ascii?Q?EecfwEy+DKyEhpSP/D9M0XE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bed530-0f60-4780-6c7d-08dcf7648384
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 15:23:45.7017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VcEQHYkYatSCfNy1xZUEMTimyreWvnRZTGKhBciUiI8PPtKvXNLAj87uOGvmFa29wwpoOnQ9u6e35bw3HtDnzSd/4Xi6wxmFqB0v7NZMHfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5697
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

This patch implements read-only test of nand flash devices.

Test reads blocks of NAND flash in normal and raw modes and compares
results. The following statuses can be returned for a block:
 * non-ecc reading failed,
 * ecc reading failed,
 * block is bad,
 * bitflips is above maximum,
 * actual number of biflips above reported one,
 * bitflips reached it maximum value,
 * block is ok.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig |  16 +++++
 cmd/mtd.c   | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 213 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 43eb13e44b8..a8e0f9e4c05 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1482,6 +1482,22 @@ config CMD_MTD_NAND_WRITE_TEST
 
 	  WARNING: This test will destroy any data on blocks being tested.
 
+config CMD_MTD_NAND_READ_TEST
+	bool "mtd nand_read_test"
+	depends on CMD_MTD
+	help
+	  MTD nand_read_test command support.
+
+	  Reads blocks of NAND flash in normal and raw modes and compares results.
+	  The following statuses can be returned for a block:
+	    * non-ecc reading failed,
+	    * ecc reading failed,
+	    * block is bad,
+	    * bitflips is above maximum,
+	    * actual number of biflips above reported one,
+	    * bitflips reached it maximum value,
+	    * block is ok.
+
 config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
diff --git a/cmd/mtd.c b/cmd/mtd.c
index bcff020bfd3..857da088843 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -940,6 +940,195 @@ out_put_mtd:
 }
 #endif
 
+#ifdef CONFIG_CMD_MTD_NAND_READ_TEST
+enum nand_read_status {
+	NAND_READ_STATUS_UNKNOWN = 0,
+	NAND_READ_STATUS_NONECC_READ_FAIL,
+	NAND_READ_STATUS_ECC_READ_FAIL,
+	NAND_READ_STATUS_BAD_BLOCK,
+	NAND_READ_STATUS_BITFLIP_ABOVE_MAX,
+	NAND_READ_STATUS_BITFLIP_MISMATCH,
+	NAND_READ_STATUS_BITFLIP_MAX,
+	NAND_READ_STATUS_OK,
+};
+
+static enum nand_read_status nand_read_block_check(struct mtd_info *mtd,
+						   loff_t off, size_t blocksize)
+{
+	struct mtd_oob_ops	ops = {};
+	u_char			*buf;
+	int			i, d, ret, len, pos, cnt, max;
+
+	if (blocksize % mtd->writesize != 0) {
+		printf("\r  block at 0x%llx: bad block size\n", off);
+		return NAND_READ_STATUS_UNKNOWN;
+	}
+
+	buf = malloc_cache_aligned(2 * blocksize);
+	if (buf == NULL) {
+		printf("\r  block at 0x%llx: can't allocate memory\n", off);
+		return NAND_READ_STATUS_UNKNOWN;
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
+		printf("\r  block at 0x%llx: non-ecc reading error %d\n",
+		       off, ret);
+		return NAND_READ_STATUS_NONECC_READ_FAIL;
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
+		printf("\r  block at 0x%llx: bad block\n", off);
+		return NAND_READ_STATUS_BAD_BLOCK;
+	}
+
+	if (ret < 0) {
+		free(buf);
+		printf("\r  block at 0x%llx: ecc reading error %d\n", off, ret);
+		return NAND_READ_STATUS_ECC_READ_FAIL;
+	}
+
+	if (mtd->ecc_strength == 0) {
+		free(buf);
+		return NAND_READ_STATUS_OK;
+	}
+
+	if (ret > mtd->ecc_strength) {
+		free(buf);
+		printf("\r  block at 0x%llx: returned bit-flips value %d "
+		       "is above maximum value %d\n",
+		       off, ret, mtd->ecc_strength);
+		return NAND_READ_STATUS_BITFLIP_ABOVE_MAX;
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
+		printf("\r  block at 0x%llx: bitflip mismatch, "
+		       "read %d but actual %d\n", off, ret, max);
+		return NAND_READ_STATUS_BITFLIP_MISMATCH;
+	}
+
+	if (ret == mtd->ecc_strength) {
+		printf("\r  block at 0x%llx: max bitflip reached, "
+		       "block is unreliable\n", off);
+		return NAND_READ_STATUS_BITFLIP_MAX;
+	}
+
+	return NAND_READ_STATUS_OK;
+}
+
+static int do_mtd_nand_read_test(struct cmd_tbl *cmdtp, int flag, int argc,
+				 char *const argv[])
+{
+	struct mtd_info		*mtd;
+	u64			off, blocks;
+	int			stat[NAND_READ_STATUS_OK + 1];
+	enum nand_read_status	ret;
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
+	blocks = mtd->size;
+	do_div(blocks, mtd->erasesize);
+
+	printf("ECC strength:     %d\n",   mtd->ecc_strength);
+	printf("ECC step size:    %d\n",   mtd->ecc_step_size);
+	printf("Erase block size: 0x%x\n", mtd->erasesize);
+	printf("Total blocks:     %lld\n", blocks);
+
+	printf("\nworking...\n");
+	memset(stat, 0, sizeof(stat));
+	for (off = 0; off < mtd->size; off += mtd->erasesize) {
+		ret = nand_read_block_check(mtd, off, mtd->erasesize);
+		stat[ret]++;
+
+		switch (ret) {
+		case NAND_READ_STATUS_BAD_BLOCK:
+		case NAND_READ_STATUS_BITFLIP_MAX:
+			if (!mtd_block_isbad(mtd, off))
+				printf("\r  block at 0x%llx: should be marked "
+				       "as BAD\n", off);
+			break;
+
+		case NAND_READ_STATUS_OK:
+			if (mtd_block_isbad(mtd, off))
+				printf("\r  block at 0x%llx: marked as BAD, but "
+				       "probably is GOOD\n", off);
+			break;
+
+		default:
+			break;
+		}
+	}
+
+out_put_mtd:
+	put_mtd_device(mtd);
+	printf("\n");
+	printf("results:\n");
+	printf("  Good blocks:            %d\n", stat[NAND_READ_STATUS_OK]);
+	printf("  Physically bad blocks:  %d\n", stat[NAND_READ_STATUS_BAD_BLOCK]);
+	printf("  Unreliable blocks:      %d\n", stat[NAND_READ_STATUS_BITFLIP_MAX]);
+	printf("  Non checked blocks:     %d\n", stat[NAND_READ_STATUS_UNKNOWN]);
+	printf("  Failed to check blocks: %d\n", stat[NAND_READ_STATUS_NONECC_READ_FAIL] +
+						 stat[NAND_READ_STATUS_ECC_READ_FAIL]);
+	printf("  Suspictious blocks:     %d\n", stat[NAND_READ_STATUS_BITFLIP_ABOVE_MAX] +
+						 stat[NAND_READ_STATUS_BITFLIP_MISMATCH]);
+	return CMD_RET_SUCCESS;
+}
+#endif
+
 static int do_mtd_bad(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
@@ -1028,6 +1217,9 @@ U_BOOT_LONGHELP(mtd,
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
 	"mtd nand_write_test                   <name>        [<off> [<size>]]\n"
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_READ_TEST)
+	"mtd nand_read_test                    <name>\n"
 #endif
 	"\n"
 	"With:\n"
@@ -1070,6 +1262,11 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 		U_BOOT_SUBCMD_MKENT_COMPLETE(nand_write_test, 4, 0,
 					     do_nand_write_test,
 					     mtd_name_complete),
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_READ_TEST)
+		U_BOOT_SUBCMD_MKENT_COMPLETE(nand_read_test, 2, 0,
+					     do_mtd_nand_read_test,
+					     mtd_name_complete),
 #endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.45.2

