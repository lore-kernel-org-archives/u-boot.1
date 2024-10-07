Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138E8CED24B
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 23:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5F5988DB2;
	Tue,  8 Oct 2024 01:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="vJAnjABK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7353988966; Tue,  8 Oct 2024 01:20:34 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D99B88D8D
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 01:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBnsoy3xr5/KiOZieZTwTR07H1j0A0DGfBlubmv/p0fkBHbg4e5xxRSQKnvhIu01N+/RqQTwQu331a/TKDVsNeQfM24UBLMx5/iQ/yUEJTeYBrIyPoVwSMbHPkO6PVoZXYzBpJeorOEeXtQnNJfTGcwsdSmxW/TcX/fWW4aXer3w4n/a4xndKPvB0WSkL2ZN2eg6UHHRNtBYyzmM8SKVL4Bm+2QLKvl/WjX3u3joixeihLhSZKcGLOxyv/RDHvkKx3/qiHJwDISsT+6Y6v1p4hnCPD8UNaKM8otA8J8Wa3RqVEJowDxiZ5kf2p1yMi5IILq1Je0YvTWjyXxWOzcsmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfLQqNmP8bb+1I1v/M6S/NB8hSQRb208g9Z/SH8I3P8=;
 b=q78lQw6uytbCsDZc4CGvQVPhLxCl7hJu2CRXIT8lb7lVQX2WRRv3PXDnZthpg1y0HeOvcUbEvxmv+Rs862hz1vmkkXXcax0DObujt76MvNhOcekTUJwnZTK/yuGq7WUFtGa9rX+qgNNZfa//n7ISCFXOhrjdza2ApD3/nXLxje/pgAgfmR8Km6Nan31zjGYitQes7ebSJHndEuvdk/bfRB+tQtvjH1iEp9b38wSYbErHOvUxn7EoYkYQv4tbjP5xaUV4WC1lP7DRISLxchLFYCsZfhlcIALcJaEHpVlVtpBnezh/zsQxSzsp8OEzc2QyW9sBAZoY1bN3LJpyMJWdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfLQqNmP8bb+1I1v/M6S/NB8hSQRb208g9Z/SH8I3P8=;
 b=vJAnjABKwVEpFgO2bj5fOGuIydv5fPxfbvkwH1RjTqhO3onMa0lcw6xHbN3/Q4n9HDanDZFeztKtN1N5md7Nzsm7DLaL9iPHETHsfRHPvWuxZ0c3gLa9Pw/x45vdZ24ehSWS96XGQ/ZUhpmIHZRZ6W6q3H0yXuvpMRgGGGuL+W+FtXmFeSMlS1xqAhEl8JJbMzQiy9GMYPt5vBM5WNG4FsCPkfci6QdRZftlCqUC5nzIYBOmX5q0oGVuViQ+DKTY0GmqM/35lghB/79nZzbQEz+DlmNZ1C+ODOQkMvP8ba0h8zPBqkxW3/1i1BTZaAiYpgYgzftuwdn7NiW/XnEcXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9140.eurprd08.prod.outlook.com (2603:10a6:102:30b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 23:20:27 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 23:20:27 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
Subject: [PATCH v4 3/3] cmd: mtd: add nand_read_test command support
Date: Tue,  8 Oct 2024 02:20:16 +0300
Message-ID: <20241007232016.1666523-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241007232016.1666523-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241007232016.1666523-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0050.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: c1141ac7-4e46-4d9b-c894-08dce726a0d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?15bUZ1kOjjpwY3fShKLrQUK2b+eAvL3PmygrNlfWJjV6RA7jN48GqrkUvILC?=
 =?us-ascii?Q?fydPw8Odr+4qPjg5DF2zDirlBIp2cf7dMDTV7OeDQiBqFkwE30qNO9w022/p?=
 =?us-ascii?Q?hrMV5lfPJAgmd8aopczST6StrnYTzwMAw02/u455nWmv0kVhHHY6cyvVVKwB?=
 =?us-ascii?Q?ndAldq5mLmdEpL8ATW6w+SnYsZt8JnK3359IvyZWkoDWumw5gt+uV7mRO1mz?=
 =?us-ascii?Q?uGBnV6u58bsOTRMojkxFWuIuKSF9l4cdKTJS0p3RWVFf41iVYQc3RLGyiSfZ?=
 =?us-ascii?Q?8sIdpI+8oIDtiajeB5Gcw14ewZDqgx0nLMmIdf11maDw+2leuJ2Sd7FN6sWT?=
 =?us-ascii?Q?fWUQ3b1VvybPNE5fR2T/TyffWBNj7mBH71KuvgnWij5USDamUVy3Hr9eXBBP?=
 =?us-ascii?Q?i45TLi7HVJ2VU5hedJJQBsg7qvZcznek/wycnp/kKY1CZsiRMqnCKC+VxPEn?=
 =?us-ascii?Q?qZc5X6u25QMugHllHWDGmv1vWNw0eUnxLViIYFpkYOoQ99N6/NHxGcoqycJf?=
 =?us-ascii?Q?5cV1KK9FczfUOWIvRl/ko/IlfEQZXsgb+59EnYi8eBfxhdeyfXsBbwhxnsJj?=
 =?us-ascii?Q?H3xiM/OXb0x9/SnjKUkUPZPUlfnFcEohQG3OIUIcS1USQr1Hq3VcoEBO2zDc?=
 =?us-ascii?Q?tTZdpc6SUV5iTFFITfrWiCkkF27zCfLVHgpWMwdkbpuKmy6NkUyDvaDqdstk?=
 =?us-ascii?Q?tzQcd5ZgNNTvl7Sp+q8tgp/vzWJxIgJaOgCUV3eXvz/U5ONm/uRbnwKaSUiq?=
 =?us-ascii?Q?3J3f44nKtl20DjS02AN40eOUgYHtcV6aFZiWMczd0sqIokCk7roTMM6AlFC8?=
 =?us-ascii?Q?SHkukBQf0O/XncUVvLMO7A+T1H1XInnQf1udzsvY3UszNecI7K/ReSlW1lUr?=
 =?us-ascii?Q?Lh3U949laOfrfanM6Iy3AZMMFdmRZhTPhQOEDGwn2Ygxd+MRud91GPCia8qH?=
 =?us-ascii?Q?2ZuvasTeKscRnBz3NMjz+gpXjh9YrtcsK2optCQuXwJ754lv94Ry64fB2Cw1?=
 =?us-ascii?Q?Wo9gBtOxeUGzKj7CXKHBFuYXoYw4VJsjxzVKNUizK45ndV0/Y+uETRlrFM+9?=
 =?us-ascii?Q?e1uS766J3RStGmfaifFQ++7W3WTcFgeBfUaxvqhCozCDPLo7GQwcwioJRQyY?=
 =?us-ascii?Q?+IQWbiHeuuxz4GVGQwotCa9j2ED6Kabsi1Y5sGUSWlda8xd+/uDgaP3b7Voa?=
 =?us-ascii?Q?OfRYC3tGXCbTZ6rmWvA6wVUfgw9hreONDOn3SSWJR0lk4nmJk9dSfUo9WkEy?=
 =?us-ascii?Q?APf+LGocbBqPSQedsysqo6qVT6V1qt1Jg/ts4FTJ4CIwH7kPjKX5XOGqKCIj?=
 =?us-ascii?Q?N6z2XJKpNEMbp4NUtCLQd4HhIiEyv3YL+72co7vjkx++FYnpWMZ7j4zUmhd1?=
 =?us-ascii?Q?R8MQq8U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gp/uWDGUplvjArB1NQt+zJv6WoffQwjWaNMBuiSCGJCmBb5DakMxfrpjDTL5?=
 =?us-ascii?Q?UCrLRmTXRAsNx0GiAF83vcd9wupKq2oHntxQVNmbXuatfgEAg6QZOBPnrcTN?=
 =?us-ascii?Q?5O9HT0XaypNPaNENu4k2tDWsGE2DgPRSD7dVEs0yGbatbRcuhDTbJfwBwgr6?=
 =?us-ascii?Q?JSvMWnsNb4wXeJivDDiobN6wyUkRdIGV7rgUYHnU3J5sfIoyYdyMa4JdVY5x?=
 =?us-ascii?Q?19p8HZe/y2vo3QXHjy/+SipAWw4Ikz4AKGMg2grHcc5z2F8oNB8tIvemnH1+?=
 =?us-ascii?Q?U19pBkwR9Iej3PHbuYYNPFNGxqSMB1Qqpl2bWHXRxwrN9YF7qkkplWwFN1tb?=
 =?us-ascii?Q?v/zdiSRoEnv1wRvDd2pUuqvSL81Cemi7ZaV2BOvGhqGtGFZF1HV5AC44BRkx?=
 =?us-ascii?Q?/+RI+d8idp9KieXIXOss4kiErkmmdLq/Z812pkuqYKgbQAMM0qSzGXhjrtY8?=
 =?us-ascii?Q?um+PoLDE/nxeqPlfAdKfI83tM9fCPOCddToUophRPFcHu6Q9O5fX64gkPMr7?=
 =?us-ascii?Q?R/9lXd8XkDR0ZIC4ctbZQaiTA2MXMfhFiTgyowiy/2wU2QClEEP1eYxqZ/CA?=
 =?us-ascii?Q?PyDhXp/KmbnxKgeMKCWWh0KyO69NtsbPN5Zivi6YEChUNwhimPtVuH0HBa+Z?=
 =?us-ascii?Q?ZNS+zwE6YUUrT1WzsxTYhP8AvB0fMMvCjpOlqHx8F1QKxT4HW4WWww2xfci+?=
 =?us-ascii?Q?YW0EZSn7XorB2HBmxA6z4SObr94OtXMrbiBcS+Ju8ArlGblOicIYlcR6AVXj?=
 =?us-ascii?Q?mL0pAhT/FY8n2Zlp/lXdrKByEYTKk0Ha34TF04AewTqfnvFvgQSQSQlSovzk?=
 =?us-ascii?Q?gQjFehOdrisCNMi7Jn2+hyJ5bLLOdUDZ//NlQIqNX5oYHilqlQuFc5Gn9UsL?=
 =?us-ascii?Q?BOjnb0AgY0DCjshu0B3cfJXNy6xgW8qrAqbOMrHX0qoJROpGpqWdlbLi2C+w?=
 =?us-ascii?Q?OVrSqRHVDzVzIkmjXGGwBiT+v2MSoLKPnnlgcMvVQ9++aX/HE435HcHbnnPJ?=
 =?us-ascii?Q?hY64S9UkIhpgLeRG/ed7dEa6/fk9ojtvHBkGvqmHeCYJ9CobmT4x3AjVrSMk?=
 =?us-ascii?Q?Otm6d0oT+YDi4mQ59jJ5skwtZ8ANSiDAk/KEqYo+fmI05hvQcJEK6hA2CpDA?=
 =?us-ascii?Q?lCehl+NwQY9adQvoMJVPcbyCBJE5cF8sebhrMzdSlnaJA31HfAra88bZdIHd?=
 =?us-ascii?Q?3vVPZVLkn+GFruysAD6pK+ZwKa/ZjcXVcCJBTM7kCT2+SCVaP/GStnPN9FB4?=
 =?us-ascii?Q?m7Uo6p7w+dj0VYBrIeqvI2+L2jY4DCtZc2B8ExtS3BMpxaOitl7037S/X43f?=
 =?us-ascii?Q?VRBNNG5amy2fVki4fR2FuLzSNqmkG56L5bwnr4gRLkZyRWNuBccCtEwKlhx0?=
 =?us-ascii?Q?oGjrjiuocr3UprMvl+kVatvms7n7EIFfd9+jXW6Yj0OTlYYBG+5ieF4NM2AA?=
 =?us-ascii?Q?ekFR07fXJcWAv52Ca2DJRmvgOQRHj+cuxmtnpWre6SsAjIJoCKhbL9Loj3xl?=
 =?us-ascii?Q?Fcikl+Z7cgGSN7hZj34qZaJZu07W8QiZuPgx5VVotw23mQQhC9NiMl7w5JQ8?=
 =?us-ascii?Q?xNhUtDqUUyNp8A2MW+rzRX5Tid/rf5J62qYV8Pe+Dhqu3lhA0yVHjaGtGpCN?=
 =?us-ascii?Q?Y604BZ7hSBju+YFxNVRbkE4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c1141ac7-4e46-4d9b-c894-08dce726a0d1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 23:20:27.4215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWaoLDsJpx5dJwxP35svsLJZQjpzwxUmCQ3Z17KYCpB/R4cCYtYuHMgl8EXHDmdAjq7QQL6+7ON+jxsrJk8cVibyU8F9vBcMEjIyD2urDyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9140
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
index 9a5ba5ccb4e..2546679e7be 100644
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
index 1c819b35e9d..3cd6403bc13 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -931,6 +931,195 @@ out_put_mtd:
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
@@ -1019,6 +1208,9 @@ U_BOOT_LONGHELP(mtd,
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
 	"mtd nand_write_test                   <name>        [<off> [<size>]]\n"
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_READ_TEST)
+	"mtd nand_read_test                    <name>\n"
 #endif
 	"\n"
 	"With:\n"
@@ -1061,6 +1253,11 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
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

