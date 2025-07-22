Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26F9C83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C53983855;
	Tue, 22 Jul 2025 13:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="rnre7Xhk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0409983242; Tue, 22 Jul 2025 13:41:58 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 867AD82E26
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oW8PIFV+UeukBBijhjp9vrgp8uj+vEG8IDGukCUq1ldjBYm1xtJysWfPUeAyzVpyQ6PO3xvBCslfcb8Ca2cjktcH4uYkMLmisB17KusABLTDXVFbrAhd+76H224NQuxpnTypLRF+JHsA7zbwauCz1nCAb5FzSbv8xB+QiHOalRqDQTQu7SeX02F1YawCOOU5HBz1nU7H/B/B5K0mXQaorS04ckgo1Mnxk6Yf4jX/Mp6CCrPIXt5JVK7IbURlNLXiigQfl01hCmplR0oY8tgXIwye/KxZQ4ZguivwCmm2eF3cuzKhNsmKeiqP87qlw8AQ81nOArltNot/JSlfq2jBxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCVnnqecEyf0tV+hyWHeobdIFe1VF1Wq/nrZLk23tgc=;
 b=WF8H3TZAPWzT4oa8OPG87YflI6GuHrySNLnxYOt1aAyXNmBULr9yZYkug1UpjuuR2lDKEO7t4mJf3V5BaXrqPIX+iuZugu2RkREUBlyL3ZoAQ5Mrwti8d6bcl90PDCnuS4iSIaHkcdluzZ/AHrbgcN2mKyU5RnQvXQk96B1Jb7iFNhi1hEcQHsi9zqra5bUPL0RL6P5yBnJ+B/IbwNRTgh9raXr1OV8TWOKr8DJ/S6XxY2K8F/FDfEGliQvie+9KMwYJVLMV4bSb/Kl5JJxbwe/tcr9kGHPwXfqdQk09AEjV61Y/qFSdDVH1rdNlgZihCbT0gF7HggMb5A90RkVH1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCVnnqecEyf0tV+hyWHeobdIFe1VF1Wq/nrZLk23tgc=;
 b=rnre7XhkaOIU0R2BNfMEpw11f17s8+cKfgVk+HOHAR824hdLddZVygDgvIep7oRHWoPgquT4NI9zFTblACctNrvGAGQEAznWsUV6GN42EuvvmW4eDv5oIyeOqe8aKVSbMuBHnqf51pjbCX73q6W4gUzrlagbYOQ50PGZDSpey+ibgg+yWEMTY+Jo8IzZpSJRIYS/czmnl/JXEyndJerhl7nOghzav9HMO3L8VzZG9t6kIcweq4RRH6pDiVMqOxFC7iWyglDp5QsTPNynEFCK4iVkhtb4y1wYUvIXYYHHI0wFdH3cA52vMHDGtDIkSviLkKsIrt6FacPozUDrzLWHNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB10351.eurprd08.prod.outlook.com (2603:10a6:20b:579::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Tue, 22 Jul
 2025 11:41:54 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:41:53 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 01/19] drivers: spi-mem: sync a bit with linux-6.16-rc6
Date: Tue, 22 Jul 2025 14:41:17 +0300
Message-ID: <20250722114135.768998-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB10351:EE_
X-MS-Office365-Filtering-Correlation-Id: da5a4386-ba67-4483-7386-08ddc914c10f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y1l1um4yjrOd9zfhzmLBw1SECvwJqFniJEGIJ8y4O28fxOy+EWVrerCEAWJf?=
 =?us-ascii?Q?xJohh9APBmH+XSN1hsvz9ll2vWq+V0l+3ty5YfNCG7FwHoIyd4Mfdb2QlTlf?=
 =?us-ascii?Q?vUixm2JV7Uj8Y0odiqTdnyQ8ddGp041lOEKQ0Jo7UrFvEZfqUCyyMsx1O4cF?=
 =?us-ascii?Q?XBitQRZRjp5/tSqqwsfUlBhy2SdNtFQ7oxtVyshjW6koLKqJoYBIA5LSLr21?=
 =?us-ascii?Q?YSRlqjdaAoEtDcnzSMpd6PL3Tlxoeq0pedMI+EXczte5LcrIyG8yjhKOGMx6?=
 =?us-ascii?Q?Ub7uSKhP3i2atWaJkuZxnpmebn19dBxIVDR1k+odL5QASss1Bg5QhIgS0AIz?=
 =?us-ascii?Q?9X0ORb2XSYFNBbzhAVDJJ5z50tQ/kOBaL7ZZH6ziFDFRucfxeDsF5qeO4sNo?=
 =?us-ascii?Q?k5gkef9zJFhrn1maOeqJN0sgM+ATagYCzNzx5GIUYSqSgnCfRWWAlCfwTAdm?=
 =?us-ascii?Q?nepR8ivLsHCHaZe1CuK0CwrdY9udE7uEAzjaHpahAmWSPYZZ+eWqhRLiL3ei?=
 =?us-ascii?Q?VC9tsk0uZB0TiA0x27p0vYJ3/QG9sJKV0gFFcSz4n4BKksOFPBDxPxHBk9EG?=
 =?us-ascii?Q?gBl4bFKwBRdk/bBHSiTIXNe3c52YVme1p6/1nGMl6EQ6nJbAvn0hbmy9v+eY?=
 =?us-ascii?Q?Ojes69iWhrTkMwdALmDxnjdkhz1oHI4+Kun+eHULecjVZSz5XchS7GWNGxEL?=
 =?us-ascii?Q?Z9JPN8J3u6tD1fVWg7Gc/Ds0aXGuPxudOkWIOJhUOwiuz2Y/mgyQoTisBWvZ?=
 =?us-ascii?Q?idiSrE0yd0Rq7i7bUEjwZwUAXGfnrycMKvyK1/dX30aBvVqtDuAhd70lrzNi?=
 =?us-ascii?Q?VoVNWAVZtrIgUdWCGSzIg/t/uU7a0b7YzGmQ4z9xRvpg8D9pU+ZBd4gIzR93?=
 =?us-ascii?Q?hbvr2xap8IbFpEh8t8Enc0bYL6gOEa/mb0J2fPZJIm52tDFuOLW6NR8Mjb0V?=
 =?us-ascii?Q?f9ndEXT7HFzU+Kdk2e8eh3Uaf7QtHY/eWkrrUgosim5wpK5sBHCsGlVp9tKp?=
 =?us-ascii?Q?6gScdJPA6rK+nED1PgO/Jvsd7unlYA9D9sUP4DhQeMnXh8DgflNhs6O1/jjy?=
 =?us-ascii?Q?oFaqeClDw8ePobZXqoMJAlk4z9Ryuues+DCJWfpVw7JxiKax9OW6og6EwU0J?=
 =?us-ascii?Q?fFsXS1HaOQ85yq8nWDz/AVz9tybY2olyy5hjfccGeM0xsVv8itnkoObN14OZ?=
 =?us-ascii?Q?/fTpSogymdxJif41BBXjFVSNAZLOxDeGOHd4UndHj2QjMf1giJ+weNe0Tzy/?=
 =?us-ascii?Q?cupy0MbAxK2LboGasX3DX+0SgUtVBE+MTQqEUAskw4GiZ4IAqsuhDm3Ru+CE?=
 =?us-ascii?Q?FEMHpjV1BHP2JTNA6Lfgj8r/FNky5lrc3VciF78eghyDj65btahtvT6q7rlT?=
 =?us-ascii?Q?H1M0SjjubWay+nxeMi5+3OE8sKbJ3fDbN0FdtdQDNKu7GVcRAcrFSD0MqRsU?=
 =?us-ascii?Q?jGw/fUPqmM6GLuArmTg6M6wwg9x8PsEQBJjEAuXP383ZlteTzYaFlkZlf2qR?=
 =?us-ascii?Q?TzLYs1YmH9j3rrc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i9g0b0U+8y79SgyL2M9jypzd02g1QS1N4EGF9dQoBNycPTClfGGL9cYjFhC3?=
 =?us-ascii?Q?53DjpRewlRjAHGC5eKZkRLPxk+m6hwauj7AfHbgxUeZGufMmAyDaIQP+rMUQ?=
 =?us-ascii?Q?c/6J08gp7dGKC+ItswZjOzDq4c6S2hxn9QnBlqj32fRbsslEbUD9yv7d4mFi?=
 =?us-ascii?Q?bmV5lNl5RWSQjBI58w1X+9IZ23y6CwajRVSGPDpqDFM+22gBjYNFK+vj8MEZ?=
 =?us-ascii?Q?TNlKpXEFBV7TOWf7Un4DUpqZgXBoKGGci5BMG19TKY/ryWvFl+g/faKtlCul?=
 =?us-ascii?Q?78rRLExq1tENOlMEyxYPspGEL9cI7i22tSmNVhfzl6E12sbN6xF3K6qTcW/K?=
 =?us-ascii?Q?SeQLA3llfy+VoSmStTQv40gGGqwPSzZVjMh1sW/cuqhhOF1H7W1/SoehOkhG?=
 =?us-ascii?Q?gkgKzQ5mq71myMok8o73l2lQiPd9TVYJPt7WHtA1H9r2KNBjOEvZmuilowA0?=
 =?us-ascii?Q?m3aHv91HU0oKAMGvzlFJNctmzySGGa+3z7ZNSYuK3pExVJemWbZifJfUUepC?=
 =?us-ascii?Q?bt4vX/9MHGXRSMyebvt9qzUOpxHBzsl5rfKUnB7qs5GhzssV2KjfmxdwC0+q?=
 =?us-ascii?Q?UsPlSgM2uk5d+ih6kT+s3V/p0dfpvPN8wYuHlhh5xTv+tDN2i3HLr91I60v8?=
 =?us-ascii?Q?ito2zKN72bHRd0uIsh9KbiFS80IOMe7YWrFOrRpQXLwDPlTsa34yIkmOHd4j?=
 =?us-ascii?Q?vJI6hwd3ALaZYl8wgkC/n7AvQ7qxlWfUL3zwNUJYPnKrPHefeZlMIUrROWUb?=
 =?us-ascii?Q?+2uA/EVANvccopFqFSUWHLBsikTI/5LGsr3tOyimCnF4oF02DJ7A1R6VxeXg?=
 =?us-ascii?Q?4NBVd75Q2ntmDM+03zVzhBQ6l3LZYDf8mPyCcoBDPVI0nAzO1k/v7zEef4AZ?=
 =?us-ascii?Q?ORddmj2faeBV5XPrBgEhvAqZTbMZ9cLrHxMuRQkPBTOwCoVbk0F68iKACPiu?=
 =?us-ascii?Q?bntodNoqBFw4x64ojtuWxM1+yisr0Das4tmKXsqVtXeQdSPrEOiYXuOCpd8E?=
 =?us-ascii?Q?CmuwE6muz9j0NV2PL9VSBGj6VYSFBCwhACtnGTrH6hrje0Ns7KCL7US9Vuhh?=
 =?us-ascii?Q?63uY23xO56WHBJq1U/mC6RteGiIg4uOjjell0Pk70ojztbieliLsVuJcuPFy?=
 =?us-ascii?Q?TY7Vd1EHrVDRdCC+QYUkDrnycLdBPzBUS9tEJKBTE+DxIVM9PnN20F4wUUJ3?=
 =?us-ascii?Q?ap2uH2A4waeK+9BWSP2MM+DrsA+W2d+BnrU75jJMlNqePmoMb2gTZKY1hPax?=
 =?us-ascii?Q?xKA32QcsRgSnWlA1NDuH/aDO0+cGaL8TC5OCNi6aAmGk71f6Q7TJqW5Aydci?=
 =?us-ascii?Q?vMYDD2Gp+JelosJYAzEaTvBFUZCpIY9K0YE5etTyRjAnqkaCOvjXfot/l5bq?=
 =?us-ascii?Q?5nPI0zR8FuGXxzNl2/aSPeiiO5FTZo3Hpo4Rc32taasZ8KmJnH43FntTFmK2?=
 =?us-ascii?Q?5YnuD83In50TK/eo+b2oP1wXRtGCb4sg6cbGlJdUoTxpGLJ6WUJNJaLKW8LW?=
 =?us-ascii?Q?l7OHIbf3vpyJpCiTDm4xBRjcpztDl39Rb1y+V1cIYB59LC8ufUmiU6iWcA2W?=
 =?us-ascii?Q?JYkoeUl03SWcSegjJ1PAgoraWHB9P1JEvVYpZjqMvJRgvgki2xEKKsj288xF?=
 =?us-ascii?Q?bAFrKkTYtZ5D1+D1mrmsUb0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: da5a4386-ba67-4483-7386-08ddc914c10f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:41:53.4928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: soogLePlu+7vnTv4lNeqwM+YoxL4GT9ADmM3WfQ5tc60NQy8GkQ3usga+D+ChDiIuAzeA/86Qzj9aoCfQVwSw35O5HfeytwkG09edmZXbhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10351
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

This also fix 8-wire support a bit.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-mem.c | 13 +++---
 include/spi-mem.h     | 92 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 90 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 3579b7d7db5..6f06650384c 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -120,18 +120,21 @@ static int spi_check_buswidth_req(struct spi_slave *slave, u8 buswidth, bool tx)
 		return 0;
 
 	case 2:
-		if ((tx && (mode & (SPI_TX_DUAL | SPI_TX_QUAD))) ||
-		    (!tx && (mode & (SPI_RX_DUAL | SPI_RX_QUAD))))
+		if ((tx &&
+		     (mode & (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL))) ||
+		    (!tx &&
+		     (mode & (SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL))))
 			return 0;
 
 		break;
 
 	case 4:
-		if ((tx && (mode & SPI_TX_QUAD)) ||
-		    (!tx && (mode & SPI_RX_QUAD)))
+		if ((tx && (mode & (SPI_TX_QUAD | SPI_TX_OCTAL))) ||
+		    (!tx && (mode & (SPI_RX_QUAD | SPI_RX_OCTAL))))
 			return 0;
 
 		break;
+
 	case 8:
 		if ((tx && (mode & SPI_TX_OCTAL)) ||
 		    (!tx && (mode & SPI_RX_OCTAL)))
@@ -300,7 +303,7 @@ int spi_mem_exec_op(struct spi_slave *slave, const struct spi_mem_op *op)
 		 * read path) and expect the core to use the regular SPI
 		 * interface in other cases.
 		 */
-		if (!ret || ret != -ENOTSUPP) {
+		if (!ret || (ret != -ENOTSUPP && ret != -EOPNOTSUPP)) {
 			spi_release_bus(slave);
 			return ret;
 		}
diff --git a/include/spi-mem.h b/include/spi-mem.h
index 2eb05a2e5bc..e68e2b50e85 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -17,16 +17,32 @@ struct udevice;
 
 #define SPI_MEM_OP_CMD(__opcode, __buswidth)			\
 	{							\
+		.nbytes = 1,					\
 		.buswidth = __buswidth,				\
 		.opcode = __opcode,				\
+	}
+
+#define SPI_MEM_DTR_OP_CMD(__opcode, __buswidth)		\
+	{							\
 		.nbytes = 1,					\
+		.opcode = __opcode,				\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
 	}
 
 #define SPI_MEM_OP_ADDR(__nbytes, __val, __buswidth)		\
+	{							\
+		.nbytes = __nbytes,				\
+		.buswidth = __buswidth,				\
+		.val = __val,					\
+	}
+
+#define SPI_MEM_DTR_OP_ADDR(__nbytes, __val, __buswidth)	\
 	{							\
 		.nbytes = __nbytes,				\
 		.val = __val,					\
 		.buswidth = __buswidth,				\
+		.dtr = true,					\
 	}
 
 #define SPI_MEM_OP_NO_ADDR	{ }
@@ -37,22 +53,47 @@ struct udevice;
 		.buswidth = __buswidth,				\
 	}
 
+#define SPI_MEM_DTR_OP_DUMMY(__nbytes, __buswidth)		\
+	{							\
+		.nbytes = __nbytes,				\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
 #define SPI_MEM_OP_NO_DUMMY	{ }
 
 #define SPI_MEM_OP_DATA_IN(__nbytes, __buf, __buswidth)		\
+	{							\
+		.buswidth = __buswidth,				\
+		.dir = SPI_MEM_DATA_IN,				\
+		.nbytes = __nbytes,				\
+		.buf.in = __buf,				\
+	}
+
+#define SPI_MEM_DTR_OP_DATA_IN(__nbytes, __buf, __buswidth)	\
 	{							\
 		.dir = SPI_MEM_DATA_IN,				\
 		.nbytes = __nbytes,				\
 		.buf.in = __buf,				\
 		.buswidth = __buswidth,				\
+		.dtr = true,					\
 	}
 
 #define SPI_MEM_OP_DATA_OUT(__nbytes, __buf, __buswidth)	\
+	{							\
+		.buswidth = __buswidth,				\
+		.dir = SPI_MEM_DATA_OUT,			\
+		.nbytes = __nbytes,				\
+		.buf.out = __buf,				\
+	}
+
+#define SPI_MEM_DTR_OP_DATA_OUT(__nbytes, __buf, __buswidth)	\
 	{							\
 		.dir = SPI_MEM_DATA_OUT,			\
 		.nbytes = __nbytes,				\
 		.buf.out = __buf,				\
 		.buswidth = __buswidth,				\
+		.dtr = true,					\
 	}
 
 #define SPI_MEM_OP_NO_DATA	{ }
@@ -62,7 +103,7 @@ struct udevice;
  *			   transfer from the controller perspective
  * @SPI_MEM_NO_DATA: no data transferred
  * @SPI_MEM_DATA_IN: data coming from the SPI memory
- * @SPI_MEM_DATA_OUT: data sent the SPI memory
+ * @SPI_MEM_DATA_OUT: data sent to the SPI memory
  */
 enum spi_mem_data_dir {
 	SPI_MEM_NO_DATA,
@@ -70,6 +111,9 @@ enum spi_mem_data_dir {
 	SPI_MEM_DATA_OUT,
 };
 
+#define SPI_MEM_OP_MAX_FREQ(__freq)				\
+	.max_freq = __freq
+
 /**
  * struct spi_mem_op - describes a SPI memory operation
  * @cmd.nbytes: number of opcode bytes (only 1 or 2 are valid). The opcode is
@@ -80,26 +124,35 @@ enum spi_mem_data_dir {
  * @addr.nbytes: number of address bytes to send. Can be zero if the operation
  *		 does not need to send an address
  * @addr.buswidth: number of IO lines used to transmit the address cycles
+ * @addr.dtr: whether the address should be sent in DTR mode or not
  * @addr.val: address value. This value is always sent MSB first on the bus.
  *	      Note that only @addr.nbytes are taken into account in this
  *	      address value, so users should make sure the value fits in the
  *	      assigned number of bytes.
- * @addr.dtr: whether the address should be sent in DTR mode or not
  * @dummy.nbytes: number of dummy bytes to send after an opcode or address. Can
  *		  be zero if the operation does not require dummy bytes
  * @dummy.buswidth: number of IO lanes used to transmit the dummy bytes
  * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or not
  * @data.buswidth: number of IO lanes used to send/receive the data
  * @data.dtr: whether the data should be sent in DTR mode or not
+ * @data.ecc: whether error correction is required or not
+ * @data.swap16: whether the byte order of 16-bit words is swapped when read
+ *		 or written in Octal DTR mode compared to STR mode.
  * @data.dir: direction of the transfer
- * @data.buf.in: input buffer
- * @data.buf.out: output buffer
+ * @data.nbytes: number of data bytes to send/receive. Can be zero if the
+ *		 operation does not involve transferring data
+ * @data.buf.in: input buffer (must be DMA-able)
+ * @data.buf.out: output buffer (must be DMA-able)
+ * @max_freq: frequency limitation wrt this operation. 0 means there is no
+ *	      specific constraint and the highest achievable frequency can be
+ *	      attempted.
  */
 struct spi_mem_op {
 	struct {
 		u8 nbytes;
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 __pad : 7;
 		u16 opcode;
 	} cmd;
 
@@ -107,6 +160,7 @@ struct spi_mem_op {
 		u8 nbytes;
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 __pad : 7;
 		u64 val;
 	} addr;
 
@@ -114,28 +168,35 @@ struct spi_mem_op {
 		u8 nbytes;
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 __pad : 7;
 	} dummy;
 
 	struct {
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 ecc : 1;
+		u8 swap16 : 1;
+		u8 __pad : 5;
 		enum spi_mem_data_dir dir;
 		unsigned int nbytes;
-		/* buf.{in,out} must be DMA-able. */
 		union {
 			void *in;
 			const void *out;
 		} buf;
 	} data;
+
+	unsigned int max_freq;
 };
 
-#define SPI_MEM_OP(__cmd, __addr, __dummy, __data)		\
+#define SPI_MEM_OP(__cmd, __addr, __dummy, __data, ...)		\
 	{							\
 		.cmd = __cmd,					\
 		.addr = __addr,					\
 		.dummy = __dummy,				\
 		.data = __data,					\
+		__VA_ARGS__					\
 	}
+
 /**
  * struct spi_mem_dirmap_info - Direct mapping information
  * @op_tmpl: operation template that should be used by the direct mapping when
@@ -143,7 +204,7 @@ struct spi_mem_op {
  * @offset: absolute offset this direct mapping is pointing to
  * @length: length in byte of this direct mapping
  *
- * This information is used by the controller specific implementation to know
+ * These information are used by the controller specific implementation to know
  * the portion of memory that is directly mapped and the spi_mem_op that should
  * be used to access the device.
  * A direct mapping is only valid for one direction (read or write) and this
@@ -223,10 +284,12 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
 /**
  * struct spi_controller_mem_ops - SPI memory operations
  * @adjust_op_size: shrink the data xfer of an operation to match controller's
- *		    limitations (can be alignment of max RX/TX size
+ *		    limitations (can be alignment or max RX/TX size
  *		    limitations)
  * @supports_op: check if an operation is supported by the controller
  * @exec_op: execute a SPI memory operation
+ *           not all driver provides supports_op(), so it can return -EOPNOTSUPP
+ *           if the op is not supported by the driver/controller
  * @dirmap_create: create a direct mapping descriptor that can later be used to
  *		   access the memory device. This method is optional
  * @dirmap_destroy: destroy a memory descriptor previous created by
@@ -300,13 +363,16 @@ int spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
 void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 					  const struct spi_mem_op *op,
 					  struct sg_table *sg);
+
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op);
 #else
 static inline int
 spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
 				   const struct spi_mem_op *op,
 				   struct sg_table *sg)
 {
-	return -ENOSYS;
+	return -ENOTSUPP;
 }
 
 static inline void
@@ -315,6 +381,13 @@ spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 				     struct sg_table *sg)
 {
 }
+
+static inline
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
+{
+	return false;
+}
 #endif /* CONFIG_SPI_MEM */
 #endif /* __UBOOT__ */
 
@@ -337,7 +410,6 @@ ssize_t spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
 			    u64 offs, size_t len, void *buf);
 ssize_t spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
 			     u64 offs, size_t len, const void *buf);
-
 #ifndef __UBOOT__
 int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
 				       struct module *owner);
-- 
2.47.2

