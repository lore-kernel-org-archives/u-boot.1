Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48C4CF9C68
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 03:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D053288B49;
	Sat, 21 Sep 2024 05:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="jP68gOE9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA7F7889C5; Sat, 21 Sep 2024 05:44:24 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20723.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::723])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FC8588A58
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 05:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoBNENfPlZXoyUmQuNDRfp/g6dxBV8HO01NWgqqy4R3T/Earxvh3CAomWPLkm3jVgRG/1IausA0mC+Yv+cGQgzChXvIh81o+kEaBKhIsoxf2TZaxczuDEppMa7TaBuF4cmwiDvz6ww2TRGtVXAllDUQyYp1c+L0L1GNBH3qfK8Bo+XS7Cx0h082IOovapHc4Y45nj79GwB0y0MWjzXkZ9MKJm59qD3T/dWzrK5MyEkOxVWmQ59aRyyAIt1LQNoifoZjeeJbCWco+wMCc/1iGrIOlFx1V/cPJqNk90xXJtYzFYns4VfIqH+0F9uhQtlvFreHOuJskEBtyfyhniaJvxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWxga44Exx31SK/nLCWA1BNlOy7Q4PLjJS17taa2qvk=;
 b=yPjBli7XEyDlHcigVKF+x+nexasmjpw/nBW1wNRSk98A0O8V3YoukK3RFzyEn/L0O8Bn8XO8xXRma6QcJuHi7WoY+eVkaltRfGAa7bkSxeKWg1EIV1ylRum7K16RgW+b5nn8UO71IAq5nUrmS6j9T9IJlvQ9oI651i9smcnn02eF14GotwD7rjo6rNAjZtgkVZqzOKhyrBo+888lKfvhegJTrjpQx5j4kK+XAhFo4FPnWKTqyttk1AuYYf4Dsp7i2oHUfTf2pceOiDjryFiB9SEueYkyt3bwt4c1JInAYb7A+55BJHfoUsFMsmO0CEHaJVRksYU6XLrO1AnV3m8L0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWxga44Exx31SK/nLCWA1BNlOy7Q4PLjJS17taa2qvk=;
 b=jP68gOE9VW2U3jlObQxeRwQzA0UpGiYDnDBPNOX0DrPgT8Vzienb/D1tfOmaDftJ2MuZQvSCFH/Y7mfwHms8S/MAU025BkVRpKDWODb2Rj4aPWIfF/E576gSTI/nk6RBFJw0bN3wES/pJHc5JmNTDVoMFUwRL0UtMpLFIVxuf8K8D3igBt27Vdk7uUsYDUNgPpTRbl2POwHNSX1x7sx94acZ4qMAh9YTyJ4U6sQNt/8gAq504Kp9CDlFSRNz2OHKTeZBf0vt9sY8tQYiY8vK5rMEzPzLlG5Ys+5O0mFpHNX6CNdCnicu1EYcfVlZiih9WrX/A9FqdZYuTa59GiEaew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9418.eurprd08.prod.outlook.com (2603:10a6:10:421::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7; Sat, 21 Sep
 2024 03:44:17 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8005.010; Sat, 21 Sep 2024
 03:44:17 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Anand Moon <linux.amoon@gmail.com>,
 Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
Subject: [PATCH v7 11/13] net/netcat: add netcat over tcp support
Date: Sat, 21 Sep 2024 06:43:51 +0300
Message-ID: <20240921034353.1298452-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240921034353.1298452-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240921034353.1298452-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00004595.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::440) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: a97984f3-cd11-40f5-04af-08dcd9efab58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TFottE5B+XJqPJHUh3gscM1zVt+QA5xke0teQYNIXRurOPxABSrJXUpK+Nup?=
 =?us-ascii?Q?Owiy0srI9axJfsmVS3eS7COZfF9ajDfO7hekQRfXvrMNaA+e6/zWPJyhb8GK?=
 =?us-ascii?Q?OostojYMLCMs2i/QwdG4kkd5CVcZ1zOSLV2YxAZhHXTVq9zlCoxaQOtq8Ryq?=
 =?us-ascii?Q?sjLTlHz/3S+Fug9T1ANKEDb7P3iUOflxME077nDaQbAb6NNvh/VcGOf9LiDI?=
 =?us-ascii?Q?ddNjz2ixGPoeX6zxZUoY85pYdtL+AMJDxDc8+fu+7w74QXd93qUZZt1xx3qi?=
 =?us-ascii?Q?JN40tnmHb4SwaTKfMdDlEZdi+xaKsPjtryQ+rKdpzje9uYCobVvr0u0f9HIA?=
 =?us-ascii?Q?lKSci+43kL8twZTlZX6XtjeEYlkAabECP+XjP9i2tQDDRXRhEU7M40ow+IBN?=
 =?us-ascii?Q?s9E9w6QbV88nokWQ2IHNm1hnOTknh4EVrdaTZtIZSsVZUOo0LQYlo9zKLNdR?=
 =?us-ascii?Q?HUIImbij+dyaiBshMMY19d25xM4R9EoxFTHrTcoBGVelsE9jO4FlhDAYYxvn?=
 =?us-ascii?Q?cnDjnHICsXOYU8Kjd7Q4aqvtxBQU62HL+ADzS0omeXRVdnaBfsGq88/FZJtT?=
 =?us-ascii?Q?/OaLnORIZolW7Qvx7lnWq0uykr/wQP3YDO3qg8ZCPQYHok3AC1IU6LibIEh5?=
 =?us-ascii?Q?aAJv9+4DFTpRO0LTpTibktjZEhaRQ3oMJUB64VeUdpyLsrLM1U/rv6i1rkM6?=
 =?us-ascii?Q?QROWLrQ8kfkH80fX5gGlCnO5WzPh2e4W1TUagVVpK1bZGDZc267oTvQbVjOC?=
 =?us-ascii?Q?xAnsP0smt0UhwsqazUrdoLGrnhYi8YAHsNf6a6+zComfTsrYxXUpLFbJjnLn?=
 =?us-ascii?Q?iASJRkWjxdApGCmM1ummla3gMsxtlDF5Zn285o7RUSsH8nhEq4nf1qFl5A1g?=
 =?us-ascii?Q?mRZX8x7e4Kgv0RC09Pm02ho+0smTzfhd3mOBHOjBjAZVm5RSuRgLKLiSEaAW?=
 =?us-ascii?Q?/QZMHhVizFt2kdG0HUT499dfGSp+6be3yUOwFfRhHQ1ICeAkkAsBd0pKFdPA?=
 =?us-ascii?Q?gPcusMVSp0g5bF8FpPWuQ8Z2Yn0aMV5Ongn8HyV5xBMAgbEpRVVYQqwkLoKc?=
 =?us-ascii?Q?lnoN6uVHO1DPAKCU+SPM5suXY1S7Uwm7evG6rME8YdRHpgVosYskBCpr9VO/?=
 =?us-ascii?Q?PO0Mg8svhW1J4JY2ZYLpb2UL9yszSJ9dBfTA1h01Xr6OaczkFy++f6mGumNi?=
 =?us-ascii?Q?ELEedl3TPFuqLMZAMCt0pXDJi6RnRgb2dOdbfy2WKvXBvtKdbhirenISV9T8?=
 =?us-ascii?Q?wX4wCBbVZm/7SlOBucmMJFovOEzCIbZWjnhoQ4mpuLvhLQcukh0dGfohnn09?=
 =?us-ascii?Q?1nnqlbXD85gPOwPDr8wHcjR+cCLTKDWq9X33z/myHyFXMJG2m+s740fX/VhO?=
 =?us-ascii?Q?6mvzSh0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oAX3E/HDsJHY0gsd51nUAYSkEof+wBXN+/V5MNNFPrV6MBKY/nDQy6hQ6DxW?=
 =?us-ascii?Q?4e/D2b3ZT62sy/yfkAYMumXSHRqB1Lfn9tfAU5dG5j7B4+ceLKGgZs6C5tkP?=
 =?us-ascii?Q?Ml9Tlc3OH0HR7VKuscnCYgsXRV3brR4mCoMsKRupy3qzTnFYaCZWr4UHAHHR?=
 =?us-ascii?Q?CsHTiL5HJuJrPu/YzBMw2BoQi150M/I8UyS6FpaqF/qUHxbuqjn8QcIzoNz2?=
 =?us-ascii?Q?8QkSKJ/VyWDBUKy84oduP/AuXdR/VXGyLfuHdEfpD6dBNEQjOYEfLe36xChB?=
 =?us-ascii?Q?n3ZseXDu/VL3Fvm0/FguyryNnM09oEvKMiptSt1yizCK72sxXW6Np0fjp1Uf?=
 =?us-ascii?Q?YAtLvq8NNLyLoAg7nkDgdZtSfSheyg4hIpzc+m6sA5bVGbgGXabm0UAtIZQI?=
 =?us-ascii?Q?AORvPolAvTQM+6JaPLRGGejlC4YyfmAdu3m8b3BfXzVM8rGG2mmbFMHFAuEe?=
 =?us-ascii?Q?qpY4TXLUr1p+obrDHC0y42xXTbEvsLTNNVVJC27+b5z+31kotQqHgfPTkzJd?=
 =?us-ascii?Q?MPJ2t+abuYMNPsW8U8cJUZpYYLJe2YNhN1x5BJE1x74nrP+AwlkkmCw5TMVl?=
 =?us-ascii?Q?sjIae8GVxzJ88fH/EYmhT1Qqe6jKEzdRD69Bt1gboLulMdQD/8bag2zBhGch?=
 =?us-ascii?Q?WO+oxg1ffV4dWstv7V4sTYDOaBiFrIgVWR3T9zgq13L9tonRNjtBxRaFEUKs?=
 =?us-ascii?Q?B50KLJrfcZm5OrtOOrourJRR1aJ40ZSyxyREyETIampSgG4Hu8Ve8UU7k08P?=
 =?us-ascii?Q?6nmpywqETs/SPYo4F4bTxp58NBqkFhN95EErJyOWNewTjHU7oDTPdTKqed+3?=
 =?us-ascii?Q?fZjWzdhPjHlMpg9GmjoTSC8TZoTnKLirgG48g4HuN7F7a4Xfajwt8JGpZukO?=
 =?us-ascii?Q?FD7+KkNk7o8aYTojakr/g8XeAj5q+yMPXb9HcjpaEgeLnHWiDRWbgrD0d8EE?=
 =?us-ascii?Q?x9Jwa3o4M4gWaJcjFXotrbGDcntXBguKEWu1NZQwHt3mAD4k+jdv9krMv2In?=
 =?us-ascii?Q?ct8PFAcKO/nuR7+elN8xbGSlnCPjbEV8Hdnmn+wb1PGpWmcTNztSS/wXmSKf?=
 =?us-ascii?Q?dQQXzI3OqHJcS0RNVIFUV+WDKyH5OZzjHTkwDMiDtrM3uEOkznfkVHTDm0Q1?=
 =?us-ascii?Q?0h1g4SV/QhnvRws6Dtrl4hSChkAZfE/4r/1rz1W7AwqsMI57sYGh9MgQ0OWo?=
 =?us-ascii?Q?gEJ79M6Gsn32JO5oUQeE1Rfb8Wgov1AudipDfRmXNhX31B5OQ3wPm9ld/7P1?=
 =?us-ascii?Q?RCdlQ7Ly98xNLPkX7Ju/FeSbgi3fU72Cjco+VR1g0RmHghjn58gYdVDAHDkf?=
 =?us-ascii?Q?wiZ36l9FfKsH4U6Xc8U8Za1nq07KkGVVqBtSkHD7Zy3kienGVNCcnXKWiwgY?=
 =?us-ascii?Q?BB1HPCH1qtX38kdDeNX1q8rV+TW6shhU0XSoMDTvRjrWJfbufjB1W25DL79P?=
 =?us-ascii?Q?MphbB9JZA1IW0L5KpAG6LCEjkjADpvIR4WEWYumq71nYKKHz7fCIPI6iy5b0?=
 =?us-ascii?Q?zhI/sV+yDWBrSoQS6CT8xI0uw2CDoA7ULdh1OBxItl7R2tdbvlbZic2XIksQ?=
 =?us-ascii?Q?/E6cNPxGUfSYNUrD85dz6M4M9yA5q9iIMnr1UM9D1Ri3Btr4KCjbGPij4z/e?=
 =?us-ascii?Q?mqmNkqjz3pWqXZG461G/fJ4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a97984f3-cd11-40f5-04af-08dcd9efab58
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 03:44:17.6245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n841/lcgCdJy+eFH4uDBD4O9RNqzAb1SAKUv+JKjMmR8wSOSYh+KW5m6z9HLQ59OIuKuN7E/1BJiADl0IHUamI2plePqe7y2NEjXtsVaXl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9418
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

This patch adds downloading/uploading of data with netcat.
Client/server mode both supported.

How to test:
============
  netcat-openbsd=1.219-1 from debian were used for a tests

  a) Load data from remote host.
       * U-Boot listen on tcp port 3456
       * PC connects

     u-boot: netcat load ${loadaddr} 3456
     PC:     netcat -q1 ${UBOOT_IP} 3456 < image.itb

  b) Load data from remote host.
       * PC listen on tcp port 3456
       * U-Boot connects

     PC:     netcat -q1 -l -p 3456 < image.itb
     u-boot: netcat load ${loadaddr} ${PC_IP}:3456

  c) Save data to remote host
       * U-Boot listen on tcp port 3456
       * PC connects

     u-boot: netcat save ${loadaddr} ${data_size_in_hex} 3456
     PC:     netcat -w1 ${UBOOT_IP} 3456 >image.itb

  d) Save data to remote host
       * PC listen on tcp port 3456
       * U-Boot connects

     PC:     netcat -w1 -l -p 3456 >image.itb
     u-boot: netcat save ${loadaddr} ${data_size_in_hex} ${PC_IP}:3456

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 cmd/Kconfig          |  10 +++
 cmd/net.c            |  35 ++++++--
 include/net.h        |   2 +-
 include/net/netcat.h |  20 +++++
 net/Makefile         |   1 +
 net/net.c            |   9 ++
 net/netcat.c         | 194 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 265 insertions(+), 6 deletions(-)
 create mode 100644 include/net/netcat.h
 create mode 100644 net/netcat.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 978f44eda42..cfdc53e494a 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2007,6 +2007,16 @@ config CMD_WGET
 	  wget is a simple command to download kernel, or other files,
 	  from a http server over TCP.
 
+config CMD_NETCAT
+	bool "netcat"
+	select PROT_TCP
+	help
+	  netcat is a simple command to load/store kernel, or other files,
+	  using well-known netcat (nc) utility. Unlike classic netcat utility
+	  this command supports TCP-based data transfer only, thus no data
+	  will be lost or reordered. Any netcat implementation should work,
+	  but openbsd one was tested only.
+
 config CMD_MII
 	bool "mii"
 	imply CMD_MDIO
diff --git a/cmd/net.c b/cmd/net.c
index 53ce2bc5d0c..79bb126dbd4 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -206,6 +206,29 @@ U_BOOT_CMD(
 );
 #endif
 
+#if defined(CONFIG_CMD_NETCAT)
+static int do_netcat_load(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	return netboot_common(NETCAT_LOAD, cmdtp, argc, argv);
+}
+
+static int do_netcat_save(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	return netboot_common(NETCAT_SAVE, cmdtp, argc, argv);
+}
+
+U_BOOT_LONGHELP(netcat,
+	"load [loadAddress] [[hostIPaddr:]port]\n"
+	"save Address Size [[hostIPaddr:]port]");
+
+U_BOOT_CMD_WITH_SUBCMDS(netcat,
+	"load/store data over plain TCP via netcat utility", netcat_help_text,
+	U_BOOT_SUBCMD_MKENT(load, 1, 0, do_netcat_load),
+	U_BOOT_SUBCMD_MKENT(save, 3, 0, do_netcat_save));
+#endif
+
 static void netboot_update_env(void)
 {
 	char tmp[46];
@@ -323,16 +346,17 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 
 	switch (argc) {
 	case 1:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE))
 			return 1;
-
 		/* refresh bootfile name from env */
 		copy_filename(net_boot_file_name, env_get("bootfile"),
 			      sizeof(net_boot_file_name));
 		break;
 
 	case 2:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE))
 			return 1;
 		/*
 		 * Only one arg - accept two forms:
@@ -354,7 +378,8 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		break;
 
 	case 3:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE)) {
 			if (parse_addr_size(argv))
 				return 1;
 		} else {
@@ -365,7 +390,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		}
 		break;
 
-#ifdef CONFIG_CMD_TFTPPUT
+#if defined(CONFIG_CMD_TFTPPUT) || defined(CONFIG_CMD_NETCAT)
 	case 4:
 		if (parse_addr_size(argv))
 			return 1;
diff --git a/include/net.h b/include/net.h
index b0ce13e0a9d..0af6493788a 100644
--- a/include/net.h
+++ b/include/net.h
@@ -515,7 +515,7 @@ extern int		net_restart_wrap;	/* Tried all network devices */
 enum proto_t {
 	BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
 	NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
-	WOL, UDP, NCSI, WGET, RS
+	WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_SAVE, RS
 };
 
 extern char	net_boot_file_name[1024];/* Boot File name */
diff --git a/include/net/netcat.h b/include/net/netcat.h
new file mode 100644
index 00000000000..d8e09aaaa55
--- /dev/null
+++ b/include/net/netcat.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: BSD-2-Clause
+ *
+ * netcat include file
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+#ifndef __NET_NETCAT_TCP_H__
+#define __NET_NETCAT_TCP_H__
+
+/**
+ * netcat_load_start() - begin netcat in loading mode
+ */
+void netcat_load_start(void);
+
+/**
+ * netcat_save_start() - begin netcat in data saving mode
+ */
+void netcat_save_start(void);
+
+#endif /* __NET_NETCAT_TCP_H__ */
diff --git a/net/Makefile b/net/Makefile
index 64ab7ec740a..dac7b4859fb 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_CMD_WOL)  += wol.o
 obj-$(CONFIG_PROT_UDP) += udp.o
 obj-$(CONFIG_PROT_TCP) += tcp.o
 obj-$(CONFIG_CMD_WGET) += wget.o
+obj-$(CONFIG_CMD_NETCAT) += netcat.o
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
diff --git a/net/net.c b/net/net.c
index 92156b5058b..acc9a6edb36 100644
--- a/net/net.c
+++ b/net/net.c
@@ -102,6 +102,7 @@
 #include <net/fastboot_udp.h>
 #include <net/fastboot_tcp.h>
 #include <net/ncsi.h>
+#include <net/netcat.h>
 #if defined(CONFIG_CMD_PCAP)
 #include <net/pcap.h>
 #endif
@@ -566,6 +567,14 @@ restart:
 			wget_start();
 			break;
 #endif
+#if defined(CONFIG_CMD_NETCAT)
+		case NETCAT_LOAD:
+			netcat_load_start();
+			break;
+		case NETCAT_SAVE:
+			netcat_save_start();
+			break;
+#endif
 #if defined(CONFIG_CMD_CDP)
 		case CDP:
 			cdp_start();
diff --git a/net/netcat.c b/net/netcat.c
new file mode 100644
index 00000000000..f0c387e58e1
--- /dev/null
+++ b/net/netcat.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * netcat support driver
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#include <command.h>
+#include <display_options.h>
+#include <env.h>
+#include <image.h>
+#include <mapmem.h>
+#include <net.h>
+#include <net/tcp.h>
+#include <net/netcat.h>
+
+#define HASHES_PER_LINE		65
+#define MARKER_STEP		10
+
+static struct in_addr		server_ip;
+static u16			server_port;
+static u16			local_port;
+static int			listen;
+static int			reading;
+static unsigned int		packets;
+static int			marker, marks_in_line;
+static enum net_loop_state	netcat_loop_state;
+
+static void show_block_marker(void)
+{
+	for (; marker + MARKER_STEP <= packets; marker += MARKER_STEP) {
+		marks_in_line++;
+		putc('#');
+		if (marks_in_line == HASHES_PER_LINE) {
+			marks_in_line = 0;
+			puts("\n");
+		}
+	}
+}
+
+static void tcp_stream_on_closed(struct tcp_stream *tcp)
+{
+	if (tcp->status != TCP_ERR_OK)
+		netcat_loop_state = NETLOOP_FAIL;
+
+	/*
+	 * The status line will be shown after the download/upload
+	 * progress (see show_block_marker() function). This progress
+	 * generally have no final "\n", so jump to new line before
+	 * output the status
+	 */
+	if (netcat_loop_state != NETLOOP_SUCCESS)
+		printf("\nnetcat: Transfer Fail, TCP status - %d\n", tcp->status);
+	else
+		printf("\nPackets %s %d, Transfer Successful\n",
+		       reading ? "received" : "transmitted", packets);
+	net_set_state(netcat_loop_state);
+}
+
+static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
+{
+	net_boot_file_size = rx_bytes;
+	show_block_marker();
+}
+
+static void tcp_stream_on_snd_una_update(struct tcp_stream *tcp, u32 tx_bytes)
+{
+	show_block_marker();
+	if (tx_bytes == image_save_size)
+		tcp_stream_close(tcp);
+}
+
+static void tcp_stream_on_established(struct tcp_stream *tcp)
+{
+	netcat_loop_state = NETLOOP_SUCCESS;
+}
+
+static u32 tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, u32 len)
+{
+	void *ptr;
+
+	packets++;
+	ptr = map_sysmem(image_load_addr + rx_offs, len);
+	memcpy(ptr, buf, len);
+	unmap_sysmem(ptr);
+
+	return len;
+}
+
+static u32 tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf, u32 maxlen)
+{
+	void *ptr;
+
+	if (tx_offs + maxlen > image_save_size)
+		maxlen = image_save_size - tx_offs;
+	if (!maxlen)
+		return 0;
+
+	packets++;
+	ptr = map_sysmem(image_save_addr + tx_offs, maxlen);
+	memcpy(buf, ptr, maxlen);
+	unmap_sysmem(ptr);
+
+	return maxlen;
+}
+
+/*
+ * This function will be called on new connections (incoming or outgoing)
+ * It MUST:
+ *   -- setup required tcp_stream callbacks (if connection will be accepted)
+ *   -- return a connection verdict:
+ *        0: discard connection
+ *        1: accept connection
+ */
+static int tcp_stream_on_create(struct tcp_stream *tcp)
+{
+	if (listen) {
+		/*
+		 * We are listening for incoming connections.
+		 * Accept connections to netcat listen port only.
+		 */
+		if (tcp->lport != local_port)
+			return 0;
+	} else {
+		/*
+		 * We are connecting to remote host.
+		 * Check remote IP:port to make sure that this is our connection
+		 */
+		if (tcp->rhost.s_addr != server_ip.s_addr ||
+		    tcp->rport != server_port)
+			return 0;
+	}
+
+	netcat_loop_state = NETLOOP_FAIL;
+	net_boot_file_size = 0;
+	packets = 0;
+	marker = 0;
+	marks_in_line = 0;
+
+	tcp->on_closed = tcp_stream_on_closed;
+	tcp->on_established = tcp_stream_on_established;
+	if (reading) {
+		tcp->on_rcv_nxt_update = tcp_stream_on_rcv_nxt_update;
+		tcp->rx = tcp_stream_rx;
+	} else {
+		tcp->on_snd_una_update = tcp_stream_on_snd_una_update;
+		tcp->tx = tcp_stream_tx;
+	}
+
+	return 1;
+}
+
+static void netcat_start(void)
+{
+	struct tcp_stream *tcp;
+
+	memset(net_server_ethaddr, 0, 6);
+	tcp_stream_set_on_create_handler(tcp_stream_on_create);
+
+	if (!strchr(net_boot_file_name, ':')) {
+		listen = 1;
+		printf("Listening on port %s...\n", net_boot_file_name);
+
+		local_port = dectoul(net_boot_file_name, NULL);
+	} else {
+		listen = 0;
+		printf("Connecting to %s...\n", net_boot_file_name);
+
+		server_ip = string_to_ip(net_boot_file_name);
+		server_port = dectoul(strchr(net_boot_file_name, ':') + 1, NULL);
+
+		tcp = tcp_stream_connect(server_ip, server_port);
+		if (!tcp) {
+			printf("No free tcp streams\n");
+			net_set_state(NETLOOP_FAIL);
+			return;
+		}
+		tcp_stream_put(tcp);
+	}
+}
+
+void netcat_load_start(void)
+{
+	reading = 1;
+
+	return netcat_start();
+}
+
+void netcat_save_start(void)
+{
+	reading = 0;
+
+	return netcat_start();
+}
-- 
2.45.2

