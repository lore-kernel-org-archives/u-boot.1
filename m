Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D254C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 04:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EF998895A;
	Wed, 31 Jul 2024 06:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="lahv6pjV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E9C088027; Wed, 31 Jul 2024 06:26:09 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::70e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8982C882BE
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 06:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JY3SYIPlkqseL/Sx7ZSDjxMixfaSYUzMiTUCrJ7nWfvjrpHGIgZrRWT3K6EJz5xfNLopQU8FVX0rSamnlFgZsqX3RhWXywr+T8QXhA9wcqopcolAOJFp9gpg+FklZrkSSThL8M/uFPABdytxxKxyd2uCUA23Xdr23m6EG1Yg+ZM5XTcf14SDf3D2KCphJ0A4Bmk6UfFGXoRn380N/APBmD1qVEMdnehH7JkW2fLAO6eGoULoiN4Fp7df6bU7CBvmoVkxzBIOzUgRa38swhYnGwFuRj591ytGzq291BAsY8ekkWwIhCO3dV13wtxyQgQLryWj0ovLEQpIQJHMAlTXPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sq+hEIHrPPr+MS3jI3m5Xyu7rWAqaXE7gqna+fAulh8=;
 b=SYiQPUUfcVGkx6pA3wviPyqAPHiwlDO9sKbrZwZwfqOGhRe2bC4tI8SDxfnjOlrp1tFDmRjy31LpmwpHJn1tKnLQX5VOjzwYqgfSA8hx6wQ3wjcpBWbuQOMkWoT3bjsw2kqi/sOzlZd7YYGOKl3GWFlOc0aFdRALlcTzBArM/OtMgxoDo3kvLeGhzTTcc5t2r8h6CiTMthENBs0y7kfCUqWJXn8yis5YEG/t6CUmpvhRZtXmEheVtksaLqVDZdqBX9jsl2NUDYzEGu5YGzD/IPpA+oft+NLZrccwCgZxfP3hfuNkrBmRUYxLNYXlUehZGJUtIShKVfHvJsQ7orIkwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sq+hEIHrPPr+MS3jI3m5Xyu7rWAqaXE7gqna+fAulh8=;
 b=lahv6pjVc3lsYTDMqSMR6rzQo4eqg6rciwZS4kxoS+QjgXx68pVkSDPD1XN5bwR4SBUvBKjab3emlxu1fCOzBp+8uoqKhjIvISNSbrNMUSht4TM6VmOyKv3a2epO3PPMKtc0KcKVvFRSOJmQZ4hxSLIQwTDplaGn2Qp/8uAf41w/bFahQAIJIvUoQMmZAeho6sPJGIAbuf3G0XXcW/mG+QnjR8HRubqnO4ylQrHvcRP4oVOANf3SXzAUZDzquoyr2GW7+9WzE93+u20VouCBW/5Iz7S1Q+xMzXf9M2NYfSVLuIVD+0wG7vt99NFVKITBjiX7jbJm6RChW5xrIT2cLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DB4PR08MB8125.eurprd08.prod.outlook.com (2603:10a6:10:384::19)
 by AM9PR08MB6209.eurprd08.prod.outlook.com (2603:10a6:20b:283::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 04:26:06 +0000
Received: from DB4PR08MB8125.eurprd08.prod.outlook.com
 ([fe80::e9de:ca06:dae1:ef2f]) by DB4PR08MB8125.eurprd08.prod.outlook.com
 ([fe80::e9de:ca06:dae1:ef2f%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 04:26:06 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 3/3] cmd: mtd: add nandtest command support
Date: Wed, 31 Jul 2024 08:25:52 +0400
Message-Id: <20240731042552.3840459-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731042552.3840459-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731042552.3840459-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0194.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::9) To DB4PR08MB8125.eurprd08.prod.outlook.com
 (2603:10a6:10:384::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR08MB8125:EE_|AM9PR08MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: ee61034d-f7f3-47a6-25fd-08dcb118e4f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|52116014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KCiNngJFl9tLiVeDTVWLyRX5SGiQKAOei8JkiULbxdWUQ8yqyJBJklJBWoZX?=
 =?us-ascii?Q?N6LqSYqXarVxm6/sA7eyoQg6h3LkLWWWMPggWhxWk9l98nH0DJ4FX8k4apRh?=
 =?us-ascii?Q?yVEKzxNAbwiCrSFMVF4pdXEzfV5jojKJxAZHmAn74USxqbtSVslYH1Ej0QMD?=
 =?us-ascii?Q?Psfap22wzGc93WjPUMfWXqodsW/w3rHJle/xDLJV4JDMDZcqB8gR54HDO2iO?=
 =?us-ascii?Q?Ptv406QrKQ3D2Xpk9topP8naOKUFjs6HF1MFdu3Y6v7NtfnXkodta/ftUZvW?=
 =?us-ascii?Q?cakVIKQhOLu7s2SxFCkOe2wsB/ib0gOySne52Exzm1n3CNTfc+7zsBERY7Cp?=
 =?us-ascii?Q?kMvYY1CxFXJDLZ2QkT/MdS9Y4am3pkEeS96ZpbCipRCv1tcaLafaRdrAbz8e?=
 =?us-ascii?Q?6XaVkx5/Md33W8QCQMMj2pGjkJ2qbo9e1HqML/oOKTndLVJ06aJ8E/+UMJ/L?=
 =?us-ascii?Q?LCpqeBQ9RH8MGgZPRAUMF3oxDZwe02QkXS+KqNIhmq4KRQEXW21ecv9gGCne?=
 =?us-ascii?Q?46NWXVd4uyhbmynEfQga52/F/nPAjAV80UWSh5UOvJkfof8cXWFazJjLCWaR?=
 =?us-ascii?Q?OCcWhAqDhoUyrDqc/hED08BbRXZk7poFKTIOMclUiwcLmR9YOJkW6DVFg6Ac?=
 =?us-ascii?Q?Ui8ZkRBlVb/CLPyYK919Ot/5aB/EsR1jrUT/11zLjOdJxbPMc++Yc0lA36r6?=
 =?us-ascii?Q?XTTc52oYImDPGCyzAZ9bRjzAJ0gtbTFAgOnXt/84tZY65j3zkozw3l63kp/E?=
 =?us-ascii?Q?OOoIuB3BA7cbeGXR5NIU9wQ5TVcvuiuzcgUGwhsq066BJ6DwxNIiZ5owxw/9?=
 =?us-ascii?Q?Bci4LEdROjrkdj4tyTU/YRAEi2G439F6sL6q+OGUJtNaT7poYLTQf/JBzjK/?=
 =?us-ascii?Q?O053cZaUQxsNajMYpN3srJwit2ngUMe/ufWiw9d9beRbz4LGFahpmkdlwGtb?=
 =?us-ascii?Q?evVLZcLRLFb3QIexf6njZ84Rmdl6luppGlmOx4l03EZb3y29bZsJGYmuLAVV?=
 =?us-ascii?Q?8mIvd2Fq36L7QcNj07jndL4YldBK1fKXuA1LzGfhCuAHi8oMbLK+z1KqyV1R?=
 =?us-ascii?Q?J7XjTb4MxD7CvnnfXOToNX1ZbmcEb4d/D9ASdU5EJiM4qLDMKuhlCaszytq4?=
 =?us-ascii?Q?cWHq0EZGkJZoazC9k0miN1Kp2j+NVyVdI7S050jKiK4ujdUnsAzOKVrdWCz3?=
 =?us-ascii?Q?bhHh9a4c0zU4RlejKvwsMRqUTbK6OnowzX5AQoRoiNldUhnRVa5nb81O8+IF?=
 =?us-ascii?Q?QZa+9me/XGIKv+bGht03d/16K+vDnYJoNvgM+QhwsxJG+rpzv4CpnGx+c0BO?=
 =?us-ascii?Q?LIJCc+RCGvzEuZMuTZpzRuldMv5+GSnMc1lweIcBorCQr6uR9Ox507sxNiwZ?=
 =?us-ascii?Q?zfSGEZqjgfwuXyxyTu3fnWq/0lpGUgAmcbfrPqCOmXWZ00sm2UOYpNEFjAPs?=
 =?us-ascii?Q?Be/l/81vOvo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB4PR08MB8125.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HMWJjcIVbcYhDMM1xeiafyYKpAOUOTrSINennrpY8/5jHW2ByffnZKDttLc3?=
 =?us-ascii?Q?6YXhr1TbtcPdNPJA+hz3tASQeGcNW/qgHjGQ8dZpQzTXKMWxWLjSqZSnsDi3?=
 =?us-ascii?Q?6ElnA3e718tykMf2/a0xnungHV3iqxnJ1U2wjiABY211tF3qChnJEp+sF8Gn?=
 =?us-ascii?Q?3hf1JnbwtTZV8MXa71rmQKW8MOtWtPx7WIAeF+FZ/rDWRF3Vw9p8Dzx/O3Ar?=
 =?us-ascii?Q?0opgm8sKsucTeV6Y3ano1LpFMfOuJN/dQWWXOy7by+cLBtdWFr4ly7FCjuBS?=
 =?us-ascii?Q?NWvsGrwlkIbJlMx4dgXD90t6jgpWKx25VYPAHgKtBYoiS52l1b0KUr4SLzKf?=
 =?us-ascii?Q?F8kaPa0o+E7Rk9oH1WWveYszIHvNg4iHOgxrzK5o+5UqKTaiqHXS93xceOOd?=
 =?us-ascii?Q?HulOS9r2aPnq37L+AsM/n23F/gked+5nydA3O39HUoSc5lxK/oTQLqwy1VcK?=
 =?us-ascii?Q?xok/PepLNq+eas6nt1dxnbkJSjH2ZZ+uZ/ipr7T3c9wZ5jLQglZ/S+ejUyad?=
 =?us-ascii?Q?i4meoMMPUkrZwxTAufposXtUWiVE2SZ76e4+zz61ig7v5KYAv1eEUm255ubu?=
 =?us-ascii?Q?LwWO7KSwdvvPF84FuntpnKvMjYZug/W1La2gDNYwffAgDIr+n3L6g07KHZ2P?=
 =?us-ascii?Q?vppS0q5km01vJ0ql1y8EUyTbjFIhmhJ/VmR7L+OwajZVLq2R2RSi9JJQk0zT?=
 =?us-ascii?Q?d0X6NqhQ6K6HuECSMma9pRS+WsdXFyTJ8YWXCEJUAS+fbnzVemisNLg1Br9O?=
 =?us-ascii?Q?q7oIbm3HwJ8E/VgclXrwcayNJCWgwJJK7vU9IGQHsFF9uHAWZv/w1AGNu+B5?=
 =?us-ascii?Q?DCRqz3vr+ayQFhUl7gwOLbGVwdf8dvqnSJGdck0KLAvUS8yyh62Z/szgxn6l?=
 =?us-ascii?Q?Cb91Bn4ahc6QEbOKny+DWBIM0xKZlVHAdM6/lxyuYWeRT77bzlHNbKOleTbK?=
 =?us-ascii?Q?Hf13P2fcCDp6JHbDkJeoJvmrMKICYcl8IdVdFOjibgRT+LliMNdkvKYOfUWl?=
 =?us-ascii?Q?miAc7Ll7yUZRuNA0hdN9BcqfjZuT4EwzFGrlXLE2X0dTy5wF8PnwDek1XduT?=
 =?us-ascii?Q?eBUHlKELxrEmGjdVc6XLxCHKzmJxlFLyR5apdou5JYLxJz/9x9Dp928zoDP2?=
 =?us-ascii?Q?0dIr7pKH6QkMoiUK92TeyFxIeMF71u68Ee2GrvEX3Z+aiezxPM5Y9GT1cFs8?=
 =?us-ascii?Q?JoDy5o6byy4Qm3lqZ7+5yfm5UAmRexq4dXDESDjHs1YN1W4VyQ3icP+pVBjx?=
 =?us-ascii?Q?lCJE/y0EBl5KFJCmfs7+Hs8JyfFef4lmcwKFAGEBDdZU9Ji3YLGjHjqpjiaK?=
 =?us-ascii?Q?f2YzMy/3tEu2NIA8cZWicUxCm+RTJY/Uzax7e/3bqRIAzYL4o1o2ZStbubuG?=
 =?us-ascii?Q?zarBBOuV1i7hQrfhdegmDFlb0ye6gM53i4ZQ/qopbsGXnACwMl3f7PhOOs+x?=
 =?us-ascii?Q?L9EYnbU8WtwHruydh6jdrc1R5gWs4rygYXfZKTSkkrEKwLH2blyRxYyZ4Jh4?=
 =?us-ascii?Q?hH9NQxNXLTJ9ivl8CD9+wVR/VlSX4tRSokZxQjQNO3XqGmClPCdeAKSHxuJq?=
 =?us-ascii?Q?8CaF0faBEiNSD9/t+8nwtxOsQ1L4j/lgOdLMlphJ70I2BGjEBH7YYGCvvLbt?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ee61034d-f7f3-47a6-25fd-08dcb118e4f2
X-MS-Exchange-CrossTenant-AuthSource: DB4PR08MB8125.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 04:26:05.9671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: goZTVh9Q2w0TZa1mxXSiXVjYkdFgOzzcYszIMQhmZ8i8xXGwiLoq5H1iNndETtgmvhSAbFq1tuOFdn2iaFqBbFOtMiDKggsUxtKpSbXHgUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6209
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

