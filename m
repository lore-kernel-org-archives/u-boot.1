Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84D6ECE57E
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6357288EA1;
	Tue, 10 Sep 2024 00:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="iAFArfcO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A95DB88E56; Tue, 10 Sep 2024 00:27:55 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E97688E9D
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4QZKxVG0T5CH71bmq7A8uTM4LT7wEF0F/STWGfvUq8Zkfj8pivrxjftDRMc1+BSrFEtGuoqre5qilWDFPm5/QYytVxvu+/wSi5FI+z7+pF4vrWQcz8Th68l5q0kep1SDGCCyKqMcaIysVEIhQ5julh52kina5D5xZQKl/cOzy3Xk5ZuWUgUk82UNn/PA7o3CL036C1KIgNWFsbdKUckqwpiKzrivSPN1My8xk6qqJHAuvgglXtNeOeZN9BPslpe3LbFyZxh2dbrwyIBNuZbUptTFBFo7sIv4R4FsHufBQCmhcnvXKkXCrIpjE3E0SDz8mGkMS2hkvekNODXCBHJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QC8Avy1a6fSjSvAvcbQowE86DaT0USMTo4nnJjlkQww=;
 b=V7s6TVtHLK3HS3UpGb3vSKZETTmD5sCa5uhGWCV6xrQqe6XOorNgf8Hs64aqLnOoPCjfwb0Jq1F6w4b3gDPXja6AM8MPn8FJveV7oLmLvPWyzIYryr8PRA/aJvbWb+Pxg/aDfitBd1kn7PElOIcR1KNgHAQL+pSWt/C7IvPXKPAO/zfn2sFtawVuuDzCLDR/solixdYkT3pGcGC2Mvr7YUDk8R15NQ4qcHUZI4+ENHwCIRyAMzX8FmZh6/OzaRrzU7F/4mGXpseOvcv93AgjEUfymVfncuL5VHOJ2k75bRje3fjKLnAV5KjClhAlQQ5GtW2/6TTas6xBY+Pg71GuvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QC8Avy1a6fSjSvAvcbQowE86DaT0USMTo4nnJjlkQww=;
 b=iAFArfcO2eT6ek9KwyoSwvyk//E/TVQn/XoskLgpdc11tPukxOut7nBHXxC7y/3rbswOC7BsT/f3GkbKx/eQ7+lPxv/u4ucgV2eOAMp3hPWqDoI+wgPs9XM/AztYepljrZdwZxk5tbeNwAaUP3rw0x3aVthePv9+UjvwHPsZP0dr4oQxvNSVL8nffJEL/q3LfgYhOc4xkFq07h/nMKB8K8fh8TkzZt6hN3sNXT2LbnRTMtUqXkrhibDiCy+pbABtrCh7TzP3fhyVFcvOkMBpYXWZ0Qjo0XgGxhIXE/E52xLg+/FGVj3aj+tuwGV6pcsvY1mr0Zm9hMlDwUtv1bTyZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8722.eurprd08.prod.outlook.com (2603:10a6:10:3d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:27:46 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:27:46 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH v6 12/12] net/httpd-upload: an example web-server
 implementation for file uploading
Date: Tue, 10 Sep 2024 01:27:20 +0300
Message-ID: <20240909222720.2563118-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8722:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb2df79-53b5-49ca-e31f-08dcd11ea155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QDy/14UVqiS57kFTWrU6K91VFBn87rUb8AP8jP9GYfWSktMmBRG6aeYVo+FF?=
 =?us-ascii?Q?ZNAdrbRIghDSMGrTyV1IYmZqcQA5S5y07+cNVp9sCThhQZ73O/JDKuYHG5J5?=
 =?us-ascii?Q?IRXpywyamiLvkR/EYmJfhHkrMOC8x//Odv1We/yjcTn8hrc2IhOzZXS0JJES?=
 =?us-ascii?Q?pTH+jjEo0wD/NGbw5BMI2YwCB/xV9HJlL1v8ynhZ1VWNuQOMqXUorRP3eBSo?=
 =?us-ascii?Q?jBhlqOE0Qz0YATpxIjg1oM95S50S6qoXjJCHvhe/dwpv5/f4I/NIapzjGRt2?=
 =?us-ascii?Q?O7u0Z+U79K5bBZ7lJPngtt/xhNqrJa4jF4ie4BtmR2R2nNSlNVVDPZsH5upx?=
 =?us-ascii?Q?EkOX8I+Mw2SV/GNrNNdifkkrP5QeYA8DcJpTZsQn9lq+IM9HnhRVbcaLSZIS?=
 =?us-ascii?Q?iDDCU8okk42sOcxPsomjLDwiKDk9g06gM+Z5ED9u+JUP/zvw3WiMFET2n02k?=
 =?us-ascii?Q?ebcChl88EB9n+I7zrCsyWXz/ImSXdIVBjvTqUIG+g+jjYztmuaiqzAslIzmz?=
 =?us-ascii?Q?WG074spS6wgzsv3w5Vs3QxCsRIF27bZZzOd3ucjx+St+Pc9edXnsDDIVw8BJ?=
 =?us-ascii?Q?wSMv9hOS18Cu6t3KfyTOBQ368cqjp1mT1+Zh7uCE4gJB2DDh/HsCSajGsTCM?=
 =?us-ascii?Q?3vmMbakMppqIRu9/PCuJt+t4Rm/t7G6IDhGmtOw22G1uUTtO4h4pT8sfmA7u?=
 =?us-ascii?Q?91JUi5SltTfv8TDg0Ih0cxJ35ml/0EbWip1hRd2CPtfQseNHmaCvGW0Rhcdw?=
 =?us-ascii?Q?3vJfOmtYkfg9l2S/njXIujmlllJIKLfqkgjQ0LPt9mf3hqIanl8kLzYpVnoZ?=
 =?us-ascii?Q?wGxGI9Bd1klzseuAbSNpLIS2b5OImHmytPsc5UJ4i4USyhGLaWqpgQEHM51f?=
 =?us-ascii?Q?kR4EuRO0tt7ZvH8DTuLPxMJjydNRRTUUzL3ukqsZMK96n28U0pxlGGTCrdGa?=
 =?us-ascii?Q?lWCotmfQKfwzgaTlXY7x+UBmqNFlZfU6z2CBvI1OrMglTmNpqZAMdtf454R9?=
 =?us-ascii?Q?N9B4Sm3CctdYKLHigqAZniQnhaghu6BdESno4OXxk1XiLyTSA/Cshz2fqPJ4?=
 =?us-ascii?Q?/EAcyF98soiuYNCdX+WM4MPbjGpjmCFBTx5u9N8tLAy7pQzxTr0O0xFKFKc1?=
 =?us-ascii?Q?cB6u5//yP1uMljAPKYNyPrD/l1pgUjea3V6R5nfny4NhtOCgoUsdPIwMA8Se?=
 =?us-ascii?Q?6ko4CiLzxHC+lrxurLRMvHSeaZYKddJd5nL68hoGB/ygUZ64HUmJTotcMEVA?=
 =?us-ascii?Q?WZ6ZpwBw8wGTrtKbMUgiq5WINAfqWKkZiMPTwJicvPDgAKwXHUyUwGjifxBK?=
 =?us-ascii?Q?sYfLGy2nQihtvw8EKFmqFRUyAgV+w2zv+/eXNa5FYYsLGR/xnvHyPS6nbed6?=
 =?us-ascii?Q?CD8899xcvVwLVTXo+CNyOE0OjvfEYF/qpqZ1RBRsaiWEsNZmEepyXdC5FlZS?=
 =?us-ascii?Q?MV+3DGzx4zM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TnwWT8DCSrtYS4U6AufrsKqS8wMfEnUVMQtHPnbjkRJWEm4cOS3GEfYC5061?=
 =?us-ascii?Q?9lAaRAodlNpEdu4l7TuTT23oORJ1eh9yoBIIZIOGhQDtG8M7wJMYbXD7tpOE?=
 =?us-ascii?Q?lwC1aXfDa4fNleg0WZnhI34kYgmQiCLStKnGXEupY7A3rS1UXsNDQy1tbRW8?=
 =?us-ascii?Q?oFqeGvBDfvNqw80gI+ioyaNkwJjV8SZBkrYvJWcph8voWIRqgf68bgi//NQu?=
 =?us-ascii?Q?w7gzSxZ8l1QP6D6ROJaUPqASo59mnJV1jVXqKCx7vRg/eVzmQ6J5dBRFyiUF?=
 =?us-ascii?Q?CtxIagtOWF/teki+U34DMEOplwjn65i/xpdYHjwe4/TLOta2jsiz/m46o4mQ?=
 =?us-ascii?Q?LNY22lxNPER1U3TJpxRjx3KOAy9/fWKCeU6B/jYjG4wFAMUIeaWqFSmnm/9N?=
 =?us-ascii?Q?tAGxwsuyBaqzNuVDOYIxI3D9fq3oahGo/rng1jmOTDxIubErxdZtOplB0Xgk?=
 =?us-ascii?Q?oNJww6Gvvp61Pz1hifnHSJgEZgooq+z17pWqC/W2SAfc6T51dN+3T8P3Z3uf?=
 =?us-ascii?Q?qSi8dsBXceDxltHdxWbfqXLzC/rg3YGKpN7PdNY2lfAEdhAOCx/Wqo4VYUVy?=
 =?us-ascii?Q?RIuuCpoIQpLL6jFAowAygimhHCnLOZz8ODqbbAjqdbrhqvXuRWNzqh5HL06V?=
 =?us-ascii?Q?eu86iremwxTpLhg8bx1sNnRvEHqveYaykBFINDPoHj3TAt866wu2XBmFdg1x?=
 =?us-ascii?Q?PNuRY1UFDXTo+CaHyEMZSYvXv+pUG892BlMN811tYTRrEifYiGmWhqoP/YnO?=
 =?us-ascii?Q?2t6MHunZk+aWWBpI6PHB5ph+DKYzJ2mgy4kzaJ9BL5QsEf0IabBvP2+DR+aw?=
 =?us-ascii?Q?F6UbulXfNJ4kLew0X88vFrzj8JsmJpqQgft8Yo+Db4FI09/pBY/kGaWAk2hd?=
 =?us-ascii?Q?pTQvQKWXYblFkGGi18g6xGgm58/qTEllhUXJkaaDLwEGZwXem18h/QXgu1YX?=
 =?us-ascii?Q?BbiemJpAh5RZSZ/JBkjcKSdUptrQDWecGKg6jwzptDyHpzCNfBO4SkcrMd0t?=
 =?us-ascii?Q?KXynSPPUeU2zk0Md5vmJITrR6HYy3iL2h26lRqnB4Mouv/E1EQTo8Rdj5suK?=
 =?us-ascii?Q?S0P0l4QiO4AwvyBV1p7ziQfowW9cSQ3lNxdUKyi7ddd+IX2ATKE92RzkMa0j?=
 =?us-ascii?Q?p8Nzb00/+92CQLfsr/s3TOPHAHlD6F1yzrSzT3AQzHDk+96TvM3xLEk25M/4?=
 =?us-ascii?Q?feGdy8inyhzIJmhmzseoB9Mx2h2dI7txEhM3yXMAjhys+YhlOst0e1qL+mEr?=
 =?us-ascii?Q?ghUO3hIVhJkuM3dwti9zGhhE1rM1oZNa3IKs+WPrGUgIX3EjO+IFXX9dJLpv?=
 =?us-ascii?Q?SoKLt7YhCd198K3lu5yCMNIhqPA7SOGWgZhTbvqfik6sIxfd0ygam57IZiRw?=
 =?us-ascii?Q?lVMfndBnZVYTtOi4PTP1b9GwHWwvTtGs6nDqjpBS0PYVXi/m7wWtSYRA/BXV?=
 =?us-ascii?Q?wMJPh6hiOAPSPMn4lOi9YO2CqB51oiuSA6fV+s+MzIOzi0/9KbeIXWzkgIPI?=
 =?us-ascii?Q?2BScusjKOlxiWp2j1otUjZ3dg2M5UECc5mijoDPw/qi2euheAGedWDdx4nu2?=
 =?us-ascii?Q?qmbgv8QuV80bJjPBjKJkMqj2fCmUDx59Ujeh8b6O7DNg7yEZ9pVl4wOFC20j?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb2df79-53b5-49ca-e31f-08dcd11ea155
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:27:46.7055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lJkj89mG7b0djID/milbHsNZWUh0m1wDkL3cLgKzgLut/cT5ghn9g3i6cX1YKavK0ADxe9QfU0KZaAvwCuO+zU6uR5zNqqac5P3Z0RyEdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8722
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

This is an example web-server implementation. It can be used for files
uploading to u-boot using a web-browser. It acts much like tftpget, but no
special servers needs to be installed by the user.

This code can be used as a base for other implementations like firmware
upgrade web-server used by some vendors.

Usage:
  u-boot: start the we-server using the "httpd_upload" command
  PC:     open the "http://your_uboot_ip" link in the browser

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig                     |  14 ++++
 cmd/net.c                       |  20 ++++++
 include/net/httpd-upload.h      |  12 ++++
 net/Makefile                    |  19 +++++
 net/httpd-upload.c              | 123 ++++++++++++++++++++++++++++++++
 net/httpd_upload/error_400.html |   9 +++
 net/httpd_upload/error_404.html |  10 +++
 net/httpd_upload/index.html     |  14 ++++
 net/httpd_upload/upload_ok.html |   7 ++
 9 files changed, 228 insertions(+)
 create mode 100644 include/net/httpd-upload.h
 create mode 100644 net/httpd-upload.c
 create mode 100644 net/httpd_upload/error_400.html
 create mode 100644 net/httpd_upload/error_404.html
 create mode 100644 net/httpd_upload/index.html
 create mode 100644 net/httpd_upload/upload_ok.html

diff --git a/cmd/Kconfig b/cmd/Kconfig
index abcd003f7f1..55b9d04f2fa 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2014,6 +2014,20 @@ config CMD_NETCAT
 	  netcat is a simple command to load/store kernel, or other files,
 	  using netcat like manner over TCP.
 
+config CMD_HTTPD_UPLOAD
+	bool "an example HTTP server for file uploading"
+	depends on HTTPD_COMMON
+	help
+	  HTTP/1.1 compatible server for file uploading.
+
+config CMD_HTTPD_UPLOAD_MAX_SIZE
+	int "Maximum uploading size"
+	depends on CMD_HTTPD_UPLOAD
+	default 209715200
+	help
+	  This sets maximum size of uploaded file. Real transfer will be
+	  slightly more than this limit.
+
 config CMD_MII
 	bool "mii"
 	imply CMD_MDIO
diff --git a/cmd/net.c b/cmd/net.c
index 364139ec5b9..e5fddc8c7c5 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -21,6 +21,9 @@
 #include <net/udp.h>
 #include <net/sntp.h>
 #include <net/ncsi.h>
+#if defined(CONFIG_CMD_HTTPD_UPLOAD)
+#include <net/httpd-upload.h>
+#endif
 
 static int netboot_common(enum proto_t, struct cmd_tbl *, int, char * const []);
 
@@ -228,6 +231,23 @@ U_BOOT_CMD(
 );
 #endif
 
+#if defined(CONFIG_CMD_HTTPD_UPLOAD)
+static int do_httpd_upload(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	if (argc < 2)
+		return 1;
+
+	httpd_upload_prepare();
+	return netboot_common(HTTPD, cmdtp, argc, argv);
+}
+
+U_BOOT_CMD(
+	httpd_upload,   2,      1,      do_httpd_upload,
+	"starts httpd server for file uploading",
+	"[loadAddress]\n"
+);
+#endif
+
 static void netboot_update_env(void)
 {
 	char tmp[46];
diff --git a/include/net/httpd-upload.h b/include/net/httpd-upload.h
new file mode 100644
index 00000000000..a80df214668
--- /dev/null
+++ b/include/net/httpd-upload.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: BSD-2-Clause
+ *
+ * httpd-upload include file
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+#ifndef __NET_HTTPD_UPLOAD_TCP_H__
+#define __NET_HTTPD_UPLOAD_TCP_H__
+
+void httpd_upload_prepare(void);
+
+#endif /* __NET_HTTPD_UPLOAD_TCP_H__ */
diff --git a/net/Makefile b/net/Makefile
index c1f491fad02..e7cbbc2248e 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -35,8 +35,27 @@ obj-$(CONFIG_PROT_TCP) += tcp.o
 obj-$(CONFIG_CMD_WGET) += wget.o
 obj-$(CONFIG_CMD_NETCAT) += netcat.o
 obj-$(CONFIG_HTTPD_COMMON) += httpd.o
+obj-$(CONFIG_CMD_HTTPD_UPLOAD) += httpd-upload.o
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
 # and this is intentional usage.
 CFLAGS_eth_common.o += -Wno-format-extra-args
+
+STATIC_SUBST := 's/^\(unsigned char \)/static \1/'
+SIZE_REMOVE_SUBST := 's/^unsigned int .*//'
+
+httpd_upload_generated:
+	rm -rf $(src)/httpd_upload_generated
+	mkdir -p $(src)/httpd_upload_generated
+	cd $(src)/httpd_upload && find . -type f | while read fname; do \
+		name="$${fname##*/}" && \
+		name="$${name%%.*}"  && \
+		set -o pipefail && xxd -i "$${fname##./}" | \
+			sed $(STATIC_SUBST) | \
+			sed $(SIZE_REMOVE_SUBST) > ../httpd_upload_generated/$${name}.h; \
+	done
+
+.PHONY: httpd_upload_generated
+
+net/httpd-upload.o:	httpd_upload_generated
diff --git a/net/httpd-upload.c b/net/httpd-upload.c
new file mode 100644
index 00000000000..1e1e0b1cf75
--- /dev/null
+++ b/net/httpd-upload.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * httpd-upload support driver
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#include <command.h>
+#include <net.h>
+#include <net/httpd.h>
+#include <net/httpd-upload.h>
+
+#define MAX_FILE_SIZE	CONFIG_CMD_HTTPD_UPLOAD_MAX_SIZE
+
+static enum net_loop_state  httpd_on_stop(void);
+
+static enum httpd_req_check httpd_pre_post(void *req_id, const char *url,
+					   struct httpd_post_data *post);
+static struct http_reply    *httpd_get(void *req_id, const char *url);
+static struct http_reply    *httpd_post(void *req_id, const char *url,
+					struct httpd_post_data *post);
+static void		     httpd_on_req_end(void *req_id);
+
+#include "httpd_upload_generated/error_400.h"
+#include "httpd_upload_generated/error_404.h"
+#include "httpd_upload_generated/index.h"
+#include "httpd_upload_generated/upload_ok.h"
+
+static struct http_reply error_400 = {
+	.code      = 400,
+	.code_msg  = "Bad Request",
+	.data_type = "text/html; charset=utf-8",
+	.data      = error_400_html,
+	.len       = sizeof(error_400_html)
+};
+
+static struct http_reply error_404 = {
+	.code      = 404,
+	.code_msg  = "Not Found",
+	.data_type = "text/html; charset=utf-8",
+	.data      = error_404_html,
+	.len       = sizeof(error_404_html)
+};
+
+static struct http_reply index = {
+	.code      = 200,
+	.code_msg  = "OK",
+	.data_type = "text/html; charset=utf-8",
+	.data      = index_html,
+	.len       = sizeof(index_html)
+};
+
+static struct http_reply upload_ok = {
+	.code      = 200,
+	.code_msg  = "OK",
+	.data_type = "text/html; charset=utf-8",
+	.data      = upload_ok_html,
+	.len       = sizeof(upload_ok_html)
+};
+
+static struct httpd_config cfg = {
+	.on_stop    = httpd_on_stop,
+	.on_req_end = httpd_on_req_end,
+	.get        = httpd_get,
+	.post       = httpd_post,
+	.pre_post   = httpd_pre_post,
+	.error_400  = &error_400,
+	.error_404  = &error_404,
+};
+
+static enum net_loop_state	httpd_loop_state;
+static void			*post_req_id;
+
+void httpd_upload_prepare(void)
+{
+	httpd_setup(&cfg);
+	httpd_loop_state = NETLOOP_FAIL;
+}
+
+static enum httpd_req_check httpd_pre_post(void *req_id, const char *url,
+					   struct httpd_post_data *post)
+{
+	if (post->size > MAX_FILE_SIZE) {
+		printf("HTTPD: reset connection, upload file is too large\n");
+		return HTTPD_CLNT_RST;
+	}
+
+	post_req_id = req_id;
+	return HTTPD_REQ_OK;
+}
+
+static struct http_reply *httpd_post(void *req_id, const char *url,
+				     struct httpd_post_data *post)
+{
+	if (strcmp(url, "/file_upload"))
+		return &error_404;
+
+	httpd_loop_state = NETLOOP_SUCCESS;
+	printf("HTTPD: upload OK\n");
+	return &upload_ok;
+}
+
+static struct http_reply *httpd_get(void *req_id, const char *url)
+{
+	if (!strcmp(url, "/"))
+		return &index;
+	if (!strcmp(url, "/index.html"))
+		return &index;
+	return &error_404;
+}
+
+static void httpd_on_req_end(void *req_id)
+{
+	if (req_id == post_req_id) {
+		post_req_id = NULL;
+		httpd_stop();
+	}
+}
+
+static enum net_loop_state httpd_on_stop(void)
+{
+	return httpd_loop_state;
+}
diff --git a/net/httpd_upload/error_400.html b/net/httpd_upload/error_400.html
new file mode 100644
index 00000000000..de654364edf
--- /dev/null
+++ b/net/httpd_upload/error_400.html
@@ -0,0 +1,9 @@
+<html>
+  <head><title>400</title></head>
+  <body>
+    <h1>400 - Bad Request</h1>
+    <p>
+      Sorry, the request you are trying to do is wrong.
+    </p>
+  </body>
+</html>
diff --git a/net/httpd_upload/error_404.html b/net/httpd_upload/error_404.html
new file mode 100644
index 00000000000..9dac22d497d
--- /dev/null
+++ b/net/httpd_upload/error_404.html
@@ -0,0 +1,10 @@
+<html>
+  <head><title>404</title></head>
+  <body>
+    <h1>404 - Page not found</h1>
+    <p>
+      Sorry, the page you are requesting was not found on this
+      server.
+    </p>
+  </body>
+</html>
diff --git a/net/httpd_upload/index.html b/net/httpd_upload/index.html
new file mode 100644
index 00000000000..e7d5ac943b6
--- /dev/null
+++ b/net/httpd_upload/index.html
@@ -0,0 +1,14 @@
+<html>
+  <head><title>Upload File</title></head>
+  <body>
+    <h1>Upload File.</h1>
+    <p>This will write the uploaded file to the memory arear pointed by ${loadaddr}.
+      <form method="post" enctype="multipart/form-data" action="file_upload">
+        File to upload:
+        <input type="file" name="fileID" size="500" /><br />
+        <p>&nbsp;&nbsp;<input type="submit" value="upload" />
+        <p>It takes no more than a second after the file has been uploaded until status OK is shown.
+      </form>
+    </p>
+  </body>
+</html>
diff --git a/net/httpd_upload/upload_ok.html b/net/httpd_upload/upload_ok.html
new file mode 100644
index 00000000000..8d2e561982f
--- /dev/null
+++ b/net/httpd_upload/upload_ok.html
@@ -0,0 +1,7 @@
+<html>
+  <head><title>OK</title></head>
+  <body>
+    <h1>Upload OK</h1>
+    <p>The file was uploaded.</p>
+  </body>
+</html>
-- 
2.45.2

