Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871E0CF318A
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 23:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7649B88EEE;
	Wed,  2 Oct 2024 01:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="KHHDGHYq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8993788EB7; Wed,  2 Oct 2024 01:00:26 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D254C88ECB
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 01:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1XAMFfNLuCACA5sem26udAdA5+lSMdugiJP3znSoqHAIn2HkZvB54gcrtvoYjXDgsLzZancn7TTi0r/xv1GiFowgrelGpT13Txm++VoO2hVYgcXbiTnyvvDbdJa723bMOChtlOEpoSKnolu6Ec+pYv3G7NFGtJxStaVk49Yzk8yGrvWD4mf1/dSUAovE5RGR5FkNyXmPoDvOtJejNrNzP01OGdspVynZfJpy9AkwMTurB3qn7qx5tJhjRCzceE05PCCZE6gGffrKCaGdlQVu28IxH+jh4qSF28RPin+rbxAEgjKvC4afkT2bck6zPoBtcsF1F4QRiIp5XawWVWRsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQsQOrsN2p0YRHuZ0Hv/EnOUjxgc9j4BINd0bQIEWHI=;
 b=J+KhZy9aEyaS5dkvft9Fe1ROerdDdueiV/sV2WHaug7qfZkBGkvn85L9SsBmKEr7qMRCqTDbHFymesZIHqeLieJAmdXf8foY5/ZA2cqCMqeSxRIfNqkvxu/m8RHYdPavMiNfxTkUPGm2lScTrMkv+54C8jCqXfORWHPforK+p1AOj1hClKPswDxFPyVMISMwmZ4yqBzKlw0uya9K2SCaYl9JO2j3pWcszmwSCKd3rUPoFnT7WAayyThT+oy1xWJTx76e8N4k42oZ/Wgftx0N/BLIjOsLi206mQgxdHWlTWkAIgTp3ljcmki+vej3n4pz1uJFMSIyZBFPJXQLAB14UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQsQOrsN2p0YRHuZ0Hv/EnOUjxgc9j4BINd0bQIEWHI=;
 b=KHHDGHYqeqNSXzvhLARuUaSjiQbDec1bYOM7pfaNqXbBLls+UWR9DB2jZfw4+0nWZQYj3rcBqgPUZCSnmOkkliMaLCSUSqPiCXVySytxKqB1ehCNHq4psux7CmzrQCi6Aqms/ym2o9Pu3qiMEZ20idG/CxTqTIkF26ZkqmZIFRYxrzZSYyGPK7NzTmpw1adxvRT4Evm/eRBZe1ROmgdunFLbUc2LJJYJW0VMFb7m9R0auM3ztpwHFC+vJiSK5V8+DL42u3xRRhXHtHcq4Z/891z2Mlyefo1crkQl+3uWyp9qCR7ZbC1VTDEUa0oKxzG9cXhAKb5P/30xT1S88B9s3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6271.eurprd08.prod.outlook.com (2603:10a6:102:eb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 23:00:21 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 23:00:21 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de
Subject: [PATCH v3 3/3] cmd: mtd: add nand_read_test command support
Date: Wed,  2 Oct 2024 02:00:11 +0300
Message-ID: <20241001230011.954429-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001230011.954429-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241001230011.954429-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002BBE.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e288c3-e4af-4851-652c-08dce26cd391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f+FDtVWqPcOvkz0T+p7umqKyPoJSzx8vCqy4e+znF8R4Im2Jsuk3Wvql5YWT?=
 =?us-ascii?Q?XGz+Fs/jHFiaLeEheT9h5gWyfnCs85wIymqgZjqEYbT9gU0DDb06HUbw9Moo?=
 =?us-ascii?Q?mt53KmmHFQqkVjsiE8qhqvPamm362SrgnxyHwLfySXtE/Uvs/t/WgMsAB99a?=
 =?us-ascii?Q?7RUn+pMiYwIdFeJTGdIhmVkKAVZFEREaaDF0lguW1rAmLHlcM5oFxLJuRMGB?=
 =?us-ascii?Q?SVKfElh5z+T/xuFRY1Cx3NK8xzJcwtxImiLUoXj8RDbX/Z+KCKKG/m6VxOGQ?=
 =?us-ascii?Q?qJ4DJ5zHStynApOpoc8ljIV4Xm5776gThAgqRJhcNAKYAtrnIepudj87B8qi?=
 =?us-ascii?Q?jHqDDfk/raKcP47wSJjA9Jxr2gTSQ5U+wsZ7HZeW52U0h2qntzi9s4jtZkCf?=
 =?us-ascii?Q?Yr9/VYcGkPNti1NabevQ6ZYybibxcUHjvMYdEVlChP+vjj1tMWS2Oe/lSzo6?=
 =?us-ascii?Q?7lXlvnluxhoM2sSny0NA2T9pUiGbsVUp0xJt0QHPSrTiRIm/AsUN7hlQbT7t?=
 =?us-ascii?Q?VBqkLcpqkCe0M41LfZQOnnwQTx+fbTndLo+/wm8BZj61et9+2lphOfPVwRCM?=
 =?us-ascii?Q?9s91zVtsao6eUywIHsqFvSP3L3FfBXOfUlE+2FNHtSYFDVPkl/aQ36RrZlIc?=
 =?us-ascii?Q?7F7EX1q3xzLNmr2aCEmPWlHxCZY2SEk78U7ToCJUwsz6mxbodKu5+hY/ifyK?=
 =?us-ascii?Q?Ot04XN/QGMwzqdJJltQttWMGU/VjzJTuApxyLJ6GonLUsLsJEgD1lDo3mE2t?=
 =?us-ascii?Q?UE4NJHtyKozFnxdHt4MHPdFH3NdIPSrw8ZBNmgrBYaau6IBgNeojwYdSb8r3?=
 =?us-ascii?Q?+0IPMdYzovj2RUvVkTeU5/APTqVbzmBeBttsS/xlM685u+ON/ifCsMA27Jx6?=
 =?us-ascii?Q?23hoC38AtL6lLUZStF6738VFrtlmXoTZ1p4hiBB18Z2q+2XWFX2CuntFK1a0?=
 =?us-ascii?Q?YE3O710X3Le0oWUdvsyP7N753th9YOrlPmzWtd+OTUTGfLnnMJ4dXmCPd/oq?=
 =?us-ascii?Q?5RsZ13PC/SN+GbTrjZNz8h3Uu7cNsVepwbYM5ojNYk2hVG6Ch1PV9flEzshu?=
 =?us-ascii?Q?5BcGRNx26xO1KkELHSwhrkGENNv8D9HFzIFPXhnpcNnzLGqCYKUeCJLG3XqW?=
 =?us-ascii?Q?d9duqE18DA3qXv6vfcC0m3PiR1sLz/mPs5iobyfZekNki6IoCNwoeWN4T7+1?=
 =?us-ascii?Q?AwIhO9lNXksU3ovT5Wh0GhNoQuc4atJQEs3Ody1UKnBv+0AGLLPuil1Wrrh5?=
 =?us-ascii?Q?2/JEskzuU6QL2pJDHb1qGcQ49phwVc1Ry+yuI1M/cfH3CiZJ+GUl/pPLvcTz?=
 =?us-ascii?Q?xCxb4UHu49oarAsxBFVBFp4DtI9jq1/TWBMdvkuWZuJjcKQeJ8Hq+L2d471j?=
 =?us-ascii?Q?QZ1ivV0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ejT4rGBVEk9p4KT5dCaX6Jw7xhfRjm2vvwuZLZNBcOvns9mNXikxP3lBEFbB?=
 =?us-ascii?Q?QqBm94/vRw3NsWukHSbAoR+wqa5yFHFg3XM+y+SCC6waUI1J5Zxa8ndFwJ58?=
 =?us-ascii?Q?ka+6GeQVFGgtvzCBdFkBXe+s2keKakNmkvqM8COrFeq4AKYynW5tWw1KhjRc?=
 =?us-ascii?Q?1w5U9HgheEiteXhx2HCs+uEcFrcdNs7+mg9fBoaj8aNfHnu4exZSMXt5pLsD?=
 =?us-ascii?Q?Fh99Fdlqk35i/YoZmKa7wLM4VoYQLZ/tdJYmSe1jNF6mintpTOd3XGVItEAX?=
 =?us-ascii?Q?b8Q0LsPJRDsRMQKGExhSND3Dl8RDDdhqibr8cTDJfgoFk8aS20kXosqsBKB1?=
 =?us-ascii?Q?dGpeS0P750zcIVG/vu/t6UvmOUjuYeFhjUlcYBKVcoW1FMbEZ04mjQRbdh4K?=
 =?us-ascii?Q?d2jLlLBJlrlZSfTA/Vx8k/nWWtJD5/KXlfWxMduU88cGZu4hzx7j7L8p4zjz?=
 =?us-ascii?Q?DwMz80slS8nTfNjvMypqMzuDS49jlEwkXeOGRfMJTunGuH/zihC4I3SOl/ey?=
 =?us-ascii?Q?6/JiWIFWAPB2XS+H0gX7Xjz6clbBtxoOOMs8oCd780AFmy0e/nndrpB5/a+M?=
 =?us-ascii?Q?fbAbXLy10A7WyISKgbIE8JaIVNdJCIVFJorUvZgz4WssF3Rj5pNMYVbC6cs0?=
 =?us-ascii?Q?IFfecIpmTmvP3MUPWBQk9HM8OrTWgreWj+/PQdfOtmCwIdv413VsiuPPBTar?=
 =?us-ascii?Q?b/r+hHDIzjFabJt3qDAMfuyEB+tcttJVV0UcSxz5h7FOw3rltoUXnPstfErh?=
 =?us-ascii?Q?yecWyauMhEzdAsa1pecbZ8cWvuic54sj/S8pUO7oSLAbqRmzMANaVROvr8po?=
 =?us-ascii?Q?BOhN3pNybhR7ojo+wQ3/h6EoAmr1grc2XWGllqUIYUiGZ34b+GU04PckrQOQ?=
 =?us-ascii?Q?yMrzkt4a1WoV3r0UUXSQp9H943D7DpU76jBEKUbyS2p28iUjjju1uW5DoBR1?=
 =?us-ascii?Q?T5E0qQn2PzTxd+6FsyFwHxIEa/L+/IwuShwaN4zDrnjsDG4DbtUaseDHlzD9?=
 =?us-ascii?Q?Y3JYhO9GzAzS7X8oNwegYw11h6Y0D67HyEmSyZyoQKtrbQ6ePailiwnhFQ9L?=
 =?us-ascii?Q?RR3Z09y7ymlhYvt70Is7qYsrn9T7g8AyunZSqSO8jg4a2oZ2sf+/Qd3tiKcm?=
 =?us-ascii?Q?CW3Cjt+VvJJvW4d51jBwW/j5jYSn11DEOfRCdhp1Mbxm+3Lor3h+Cqir99K5?=
 =?us-ascii?Q?GkOBLiwOPO1sIcqTRAKFlqGoUvTSbkinTOFiJ/dqE328CkBNo6oDaf2SwDqa?=
 =?us-ascii?Q?TiUtcz13kqnDAeD5OOOTkXW5jxOZwH02KrUFd+kI672AEOHOKQBGG2EE37LP?=
 =?us-ascii?Q?mYo+oKZGcddrEkazJkaW/Y61Mi2C1HTyFdKucuRVFt+9xoYqRivBPxDh20Uk?=
 =?us-ascii?Q?wkfHE8NafNTyNMl0NhxsuWU/2YA1Ek7Y8MQTGGTZGFLye+lp1dq/jguk/xRS?=
 =?us-ascii?Q?Z6RN2axRumCvLqRRoRZ6WldLBExNV742hN71n2d0B+DqRf83BpoHsilymGmn?=
 =?us-ascii?Q?ngzlgK+jjKf+GvntO1CXgXxJZ6tuAG/3w6FlmvY+yMq1RRS3Pj+NstPEqzSw?=
 =?us-ascii?Q?AL+9azb4hr98mPDhsDfLFFZBj5F4D3g8Tj3xnIvx4U1h6ceveedMJq2Cs89f?=
 =?us-ascii?Q?VrIH7X7rUXomJkf1vHr/Kd4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e288c3-e4af-4851-652c-08dce26cd391
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 23:00:21.5096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RI7WhRwPP/+wg0pYQPAk8kxXXhXrqGwq4e+RoKUbrw2eMM4r1eDwq7EN0T4UvpKCD4fpIrbc2iHmAoIA0OuGLFFgMJFoXVIP8D2aJD68T/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6271
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
 cmd/mtd.c   | 193 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 209 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index ea0491d3155..5a0efb7b173 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1471,6 +1471,22 @@ config CMD_MTD_NAND_WRITE_TEST
 
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
index 739a8a52cbd..1bfe9fc97da 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -931,6 +931,191 @@ out_put_mtd:
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
+		printf("\r  block at %llx: bad block size\n", off);
+		return NAND_READ_STATUS_UNKNOWN;
+	}
+
+	buf = malloc_cache_aligned(2 * blocksize);
+	if (buf == NULL) {
+		printf("\r  block at %llx: can't allocate memory\n", off);
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
+		printf("\r  block at %llx: non-ecc reading error %d\n",
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
+		printf("\r  block at %llx: bad block\n", off);
+		return NAND_READ_STATUS_BAD_BLOCK;
+	}
+
+	if (ret < 0) {
+		free(buf);
+		printf("\r  block at %llx: ecc reading error %d\n", off, ret);
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
+		printf("\r  block at %llx: returned bit-flips value %d "
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
+		printf("\r  block at %llx: bitflip mismatch, "
+		       "read %d but actual %d\n", off, ret, max);
+		return NAND_READ_STATUS_BITFLIP_MISMATCH;
+	}
+
+	if (ret == mtd->ecc_strength) {
+		printf("\r  block at %llx: max bitflip reached, "
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
+	u64			off;
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
+	printf("ECC strength:     %d\n",   mtd->ecc_strength);
+	printf("ECC step size:    %d\n",   mtd->ecc_step_size);
+	printf("Erase block size: 0x%x\n", mtd->erasesize);
+	printf("Total blocks:     %d\n",   do_div(mtd->size, mtd->erasesize));
+
+	memset(stat, 0, sizeof(stat));
+	for (off = 0; off < mtd->size; off += mtd->erasesize) {
+		ret = nand_read_block_check(mtd, off, mtd->erasesize);
+		stat[ret]++;
+
+		switch (ret) {
+		case NAND_READ_STATUS_BAD_BLOCK:
+		case NAND_READ_STATUS_BITFLIP_MAX:
+			if (!mtd_block_isbad(mtd, off))
+				printf("\r  block at %llx: should be marked "
+				       "as BAD\n", off);
+			break;
+
+		case NAND_READ_STATUS_OK:
+			if (mtd_block_isbad(mtd, off))
+				printf("\r  block at %llx: marked as BAD, but "
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
@@ -1019,6 +1204,9 @@ U_BOOT_LONGHELP(mtd,
 #endif
 #ifdef CONFIG_CMD_MTD_TORTURE
 	"mtd torture                           <name>        [<off> [<size>]]\n"
+#endif
+#ifdef CONFIG_CMD_MTD_NANDTEST
+	"mtd nandtest                          <name>\n"
 #endif
 	"\n"
 	"With:\n"
@@ -1061,6 +1249,11 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 		U_BOOT_SUBCMD_MKENT_COMPLETE(nand_write_test, 4, 0,
 					     do_nand_write_test,
 					     mtd_name_complete),
+#endif
+#ifdef CONFIG_CMD_MTD_NAND_READ_TEST
+		U_BOOT_SUBCMD_MKENT_COMPLETE(nand_read_test, 2, 0,
+					     do_mtd_nand_read_test,
+					     mtd_name_complete),
 #endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.45.2

