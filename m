Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1812CF044D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 10:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE89B891EC;
	Wed,  9 Oct 2024 12:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="g0RIgB5x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BCC2891EB; Wed,  9 Oct 2024 12:51:26 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95AEC891E9
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 12:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgMLtR3v1hvMBokj3VjcIlGsFpVdRGub3omaQVTHvvrZId5+OIKgPss8H6MM4uDHWp6WIN7B5NEwI8CAuiAYiffFLTBZcKghMQl69gy6p6eym8CliigfKC3K4vjoTM+xQoMJgZ4OVIhY4YY4W03W2Mg1E0e/U6lXBAHPxT8XX9GGr6uriKaQ36wcgKjHvgEHMOTQstQB3nV1HjIm5plxm3GaeDPQyfeyTNenYUydUQI6zM14ho4fUPynAyTQFMI500oNVbjwNJqJepyDnHHa/41NjG0WWaRwVxrO3YBMTi8V6uu7k8wQSS7rqNuCw1EdevMhI9ndMJPNBPpgOEILSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHUyR0NuwZtMAcSSDbye7eiJBVE6yT9iYQ0JtnFA46E=;
 b=a/2jL8dDbf/iffaoxn0yMHZlByKAgvqP9jiDLlawXsi1BjpQCg0ppTVNier0Gj9Di5O4xCdInBD9g+GS3pfg51cvpbaQtkVYN0g6GF+5Bm3jDEduLf1G2BziBrFDjiSbU5OtLrxBQ1Qczbf/3Hzdng8KyNLwiURcFCMfq/cgSar0jiAOeVLY3wao1SPZrDP26mLXVrbsN3iUhEKpyKy85pm/zpmVRwDOw1+2OI+skX+iGvx6DI8lEu6tS8LXOF+y9+F7NuvN6Cf68OZGzmjwvZKBol39Gzv1Jm7QfSeGueHMSDnOd4XadRouujHq8jh03fjBqiKJCxhFEJFK2uaiog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHUyR0NuwZtMAcSSDbye7eiJBVE6yT9iYQ0JtnFA46E=;
 b=g0RIgB5x1mpXpq6dN6GYMf9owMV5jXwTBHKAyQUDDmBtj8ZRUVCQ8AHoKTKNIBvKsaEuC1SzW/4x/wqaztXX6JnfPm4vO3bH/rwCr7yuVSnZgj4O/QoXvCFY/zbLmV2GMQd3vRWP0OAz4xHfOKdPCBr7aqa0eU3PMxorR4AmFOGFz6ZT67EbpMGu3qDfD6w2bPbNtxaUyD/rLiwcSZ9HASHSvbThqFWocvfHP0+wDB1TE5P6khAkpQlj5uNeU5Lk2M6vr80L4T4gme3dlsue/vOaoLwjRkbNkPnOtmxxPiVXJrbhCVBUbrKM/S7amtSqBp3ffUZ8B2sPfeCUHevWWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB10026.eurprd08.prod.outlook.com (2603:10a6:20b:632::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 10:51:21 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 10:51:21 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v11 13/13] net/httpd-upload: an example web-server
 implementation for file uploading
Date: Wed,  9 Oct 2024 13:50:54 +0300
Message-ID: <20241009105054.1879054-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241009105054.1879054-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241009105054.1879054-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0081.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB10026:EE_
X-MS-Office365-Filtering-Correlation-Id: dafe3660-c176-408a-79d3-08dce8504ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F+z7xd7pfY1Em7R1tuCsCClK5rHi1LKicoihuMfxWMWz/SX3Dy1xX0r4h9+3?=
 =?us-ascii?Q?xh/OrRLXILwDy2kV70qknLPEx18jKbU413XIrGtIOBUQIpy+H+u1fXgurygw?=
 =?us-ascii?Q?8vyho2aQ+CeEHZF5DK9mRscyVMxmUacolrXKoUQBIqxO3BBm5DopzyVH2jq5?=
 =?us-ascii?Q?ORECwrp+mhzUECbQDIy2P6OmgYQMiZWh4etPhdiEwYVRtr1ephr9nqrcDJmr?=
 =?us-ascii?Q?igFdObEEQBkbspNaMfXx66zu6rOdoDGxEgtfzHtf5K6OQ+0omqyD8HpBoZr2?=
 =?us-ascii?Q?Ly3LFTpjMblRYKc5+6BltRhMSiTMV1Zf80r2ESgl4AVCzuli9JE/UbfPXbpD?=
 =?us-ascii?Q?KhHNmnQLqv/xWlf5c6wzqTyS6+mIR7Xw6Mliz95sZggbt/uqKn6ht7DR9D08?=
 =?us-ascii?Q?5ZSy9ovaaDFjjYGfSvvfxTv+zHg3Kaj4pL0A412iycg6647D431NK7CG3spg?=
 =?us-ascii?Q?X97HF3LWJOzAH3+wy1uzGYWFW8iT64GfAVmsdk27r3fZjpSYDx09wtXtq/kJ?=
 =?us-ascii?Q?0bbYu081PlrruxpZ+xsqHL7TElVJ75gJOI3odLGpeMA2aWJ1Uobr1p2UQ7rw?=
 =?us-ascii?Q?+nm8a/cm4dS5YnFtj6tP9fw/OhoipOYGkiltAT7kdg1Y91okuThL9Xn8f8g9?=
 =?us-ascii?Q?9P/7WyvJjGb+ctIQsx/Hcp/eZ04gBjKEZkMhJpIApB3h+A8FK5KzZGuxHmuS?=
 =?us-ascii?Q?2vjvD6JKyYU4OXgHRJOxOziUbvGuBMAxwOL6o0jazlRJ1ESD/0ZoaMbctMKj?=
 =?us-ascii?Q?1wP5x4ld2TvPblJEvNgrsFC4P/nmsZnIZHHJJbludB9GUaJlAgVJFiKoPZWx?=
 =?us-ascii?Q?mIClO5gVlQCFSechXzNQ+ddqbKxV0HaCOO/KcTu+b7Ivcw020tjg4G+dAZBJ?=
 =?us-ascii?Q?Wq7hoik2s4L2bsI3UGhCEcEt1wztirPAcVbGdBnBgljVoNkFfuSjjhYM4AbZ?=
 =?us-ascii?Q?vkiRx8tUkD1c3ZpSkrveR4TKu9aNj1tvAtzqnJqXkuGEF/BqQlJw4UE//EML?=
 =?us-ascii?Q?NnE5dhV0i4xut/fr4NnIc0++3yQik6YnfXPoFGj+A4RvWQXaxAjbfZDjJqwb?=
 =?us-ascii?Q?DAtog89I40G7a85Mmu84OosQsn8XTfbiwodC1PK6dHjfbDiDePs0grKX7CBT?=
 =?us-ascii?Q?BDpUrJFEe/RG/AV4qsFPJBaHxV7i41KFER/1ZVD1zdxDeUJN1g+ZAV2Jp9Zp?=
 =?us-ascii?Q?CmjmI90x2x85jvnaf7XPf6O8+8jCIXneiEb+PFL6DqEYwcxbAFHoLzO2di/7?=
 =?us-ascii?Q?OJWb9MtBbGSpxrH41PcYC5qMFKs6L93loDT1xv79Qofwn+gmtQXIvqPdo2Da?=
 =?us-ascii?Q?GT2dwlK5jhjB1cnQGhYrb/YgNHcSc8YrjOxQ0fbPqfRAI8sRNOdmtzyvUR7s?=
 =?us-ascii?Q?I+OBZ00=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4LgFYbBJ+xWWwO2/3azHAERX6q8esdciYjGRBrUH074KGtAcwi83vtDGCQd3?=
 =?us-ascii?Q?UiRhD8Od6ArEkb32SbsIpDrHmI5qSlwhX2243siEN8EzrGXMy/PCjG/sl1wG?=
 =?us-ascii?Q?Z5U3FPcU4L9rHL4kpyWoz+x0d2Ghtoe2zqboQJDIpVCG8dFErT2PpqoGBLCp?=
 =?us-ascii?Q?ASzOUojYPxXj5uYd9nmu3DcRMGqsqZBO7BKoHer7qJE4UJs8+M3avODd8/ya?=
 =?us-ascii?Q?ZtfPRQRUxSpbCFMBWrTZbNMrZ/kkRNujCD8PPYiSC5cF6Px+sipUdxTVZoLN?=
 =?us-ascii?Q?OiWsHVO5/nZD7ho2igYHcKpM1ybIsvU0NA8gZtgZwvM4RSsvC6SmWOu5e/M1?=
 =?us-ascii?Q?Rl66z6jEOALuEYrgmWttoU4M7UOO6VHcBx5WGFYCL/f9Wz3WVr3tRVLwhK5F?=
 =?us-ascii?Q?76NcrB7wYhtuGd0Vy3NfWGBxXnYQvXdCWVhM45JYRltosiT5xzxSBpmuyMV/?=
 =?us-ascii?Q?wxsjvxJdyxCGUKm7Q+0yuSatEasiYZXNBIApg8F4tLSfF1rwYVsXWziYNKEj?=
 =?us-ascii?Q?MS1HMdLtff2OQ3Nyr3yg50p2yM1qxmp/0SgoXsgIguS0uBD2RH/6RyIUEPqv?=
 =?us-ascii?Q?ZY1+re7II4b6ffoUE55BVsPr6NW0WiDAKEiLNdUM69Gf+tBJku36Awi//byc?=
 =?us-ascii?Q?XljPzlkgPaI/1wsvh2R5TfXuwAxgx8m0a87gM5NOlA2/pXUrn7onZ6jyrYzX?=
 =?us-ascii?Q?tF9OszhMwT5H5hxV2YN2vuaVULMzvA9iHHrIqAx5PFZJJCBnjO1pCixEED/V?=
 =?us-ascii?Q?agMAbpC2oHaaz+G+imxcSNHyoOmU4qFB5v+N3hD1+z8t9O3MxAZDw9w1qgNW?=
 =?us-ascii?Q?GWzjuqMdERRDRBU0T7MRt92mqSNu4wunvefxAQtwVwC75i1HUb9NYtyfIpi6?=
 =?us-ascii?Q?NTi8LLGW520jIsFxc1kDBK1KvXqqW/TOtxTwdyHuyq+NNxuVsTnCCfjkrrN7?=
 =?us-ascii?Q?swuEiPDNXromHz4b6xM5PtbsQnH0p74lCZIOuE0vY3Q531xZahGv5b936o4d?=
 =?us-ascii?Q?EUalnm9Domy0DL7I1PwDX996NS3aLgt44M3Knw94OxnLEtZZCij1x2DtlzEg?=
 =?us-ascii?Q?UPlEPtMts6dmkB4PWT7s+rSvTiPvJd64tUu5wssggJWsb1+RUnOTcCDu8y4Y?=
 =?us-ascii?Q?fTvyZjWYvpEfq/pNuxiDfiQH5MFWdE1/7rpTs+s9jd0YXA7L4PFY5o5Q/i/b?=
 =?us-ascii?Q?Yatol+TUky6lZOAs/895464FvdHhownMQW3ZCjJCUH9356MyXrezaIPiL1Em?=
 =?us-ascii?Q?/E/W/vkGBoLESabS5Abve0W3gF2zkTPT3pcgARNhelQW/n6csn2jopLZKeck?=
 =?us-ascii?Q?XHyW8iOAtvCNxxKRDzFhqeyq6g8enX3sGrNoLjqPuNCw6MMWsEkgMEfcU001?=
 =?us-ascii?Q?1eWayYhG743mo58bJIcrGW3dObTGM4P2uab4+TKTiFXViNQIcObfbBzDyH1v?=
 =?us-ascii?Q?tLxbzFgjG6pZfsthhhc3yLDjeV86B1xOoJ+CTfQZX9525VME3y/4uYytqkEj?=
 =?us-ascii?Q?X8aY69n8sl5XdEk3vnuCkOxhNuURUUso2LO2sClexno2NpHRX74ymSTEV9aO?=
 =?us-ascii?Q?aHrUFy2gqeGk+7dVhMkH/538p9S1fWqutOuudXHMW/i6mYV9Q/UmPp7GILws?=
 =?us-ascii?Q?KA58IE5+SVAFb2gaQlcLD8c=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: dafe3660-c176-408a-79d3-08dce8504ff4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:51:21.7647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPQeOP8RsFXOc12GCvH7CCZlHsMbZS7hkcqr6f/3YsOgYj5SP45ci60hK1aHLV0Fspa0iJ+OENdjs8Y/cPdroq3SxUBXxHPWC7fKtjD0VkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10026
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 cmd/Kconfig                |  25 ++++++
 cmd/net.c                  |  20 +++++
 include/net/httpd-upload.h |  12 +++
 net/Makefile               |   1 +
 net/httpd-upload.c         | 170 +++++++++++++++++++++++++++++++++++++
 5 files changed, 228 insertions(+)
 create mode 100644 include/net/httpd-upload.h
 create mode 100644 net/httpd-upload.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index d142a376641..aec66244375 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2041,6 +2041,31 @@ config CMD_NETCAT
 	  will be lost or reordered. Any netcat implementation should work,
 	  but openbsd one was tested only.
 
+config CMD_HTTPD_UPLOAD
+	bool "an example HTTP server for file uploading"
+	depends on HTTPD_COMMON
+	help
+	  An example HTTP/1.1 compatible web-server implementation for file
+	  uploading. It acts much like tftpboot command: put user data to a
+	  specified memory location, but no special tools needs to be installed
+	  on the user side. The only required tool is browser.
+
+	  Start 'httpd_upload' command, open a browser, connect to the board IP,
+	  select file to upload and press 'Upload' button. This is enougth.
+
+	  There is no big profit from this code, but it can be used as a
+	  reference for other web-server implementations (ex: web-based
+	  firmware upgrade/recovery used by some router vendors)
+
+config CMD_HTTPD_UPLOAD_MAX_SIZE
+	int "Maximum uploading size"
+	depends on CMD_HTTPD_UPLOAD
+	default 209715200
+	help
+	  This option sets the resriction on the size of any uploaded file.
+	  Please reserve 2--4 Kb more space due to additional space required
+	  for storing of multipart/form-data header and footer. 
+
 config CMD_MII
 	bool "mii"
 	imply CMD_MDIO
diff --git a/cmd/net.c b/cmd/net.c
index 79bb126dbd4..f2df1eed2ef 100644
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
 
@@ -229,6 +232,23 @@ U_BOOT_CMD_WITH_SUBCMDS(netcat,
 	U_BOOT_SUBCMD_MKENT(save, 3, 0, do_netcat_save));
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
index c1f491fad02..c1b41240aab 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_PROT_TCP) += tcp.o
 obj-$(CONFIG_CMD_WGET) += wget.o
 obj-$(CONFIG_CMD_NETCAT) += netcat.o
 obj-$(CONFIG_HTTPD_COMMON) += httpd.o
+obj-$(CONFIG_CMD_HTTPD_UPLOAD) += httpd-upload.o
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
diff --git a/net/httpd-upload.c b/net/httpd-upload.c
new file mode 100644
index 00000000000..8e43860fa74
--- /dev/null
+++ b/net/httpd-upload.c
@@ -0,0 +1,170 @@
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
+static unsigned char error_400_html[] =
+	"<html>\n"
+	"  <head><title>Bad request</title></head>\n"
+	"  <body>\n"
+	"    <h1>400 - Bad Request</h1>\n"
+	"    <p>The request you are trying to do is wrong!</p>\n"
+	"  </body>\n"
+	"</html>\n";
+
+static unsigned char error_404_html[] =
+	"<html>\n"
+	"  <head><title>Page not found</title></head>\n"
+	"  <body>\n"
+	"    <h1>404 - Page not found</h1>\n"
+	"    <p>The page you were looking for doesn't exist!</p>\n"
+	"  </body>\n"
+	"</html>\n";
+
+static unsigned char index_html[] =
+	"<html>\n"
+	"  <head><title>Upload File</title></head>\n"
+	"  <body>\n"
+	"    <h1>Upload File.</h1>\n"
+	"    <p>\n"
+	"      This will write the uploaded file to the memory area pointed\n"
+	"      by ${loadaddr}.\n"
+	"      <form method=\"post\"\n"
+	"            enctype=\"multipart/form-data\"\n"
+	"            action=\"file_upload\">\n"
+	"        File to upload:\n"
+	"        <input type=\"file\" name=\"fileID\" size=\"500\" />\n"
+	"        <p>\n"
+	"          &nbsp;&nbsp;<input type=\"submit\" value=\"upload\" />\n"
+	"        </p>\n"
+	"        <p>\n"
+	"          It takes no more than a second after the file has been\n"
+	"          uploaded until status OK is shown.\n"
+	"        </p>\n"
+	"      </form>\n"
+	"    </p>\n"
+	"  </body>\n"
+	"</html>\n";
+
+static unsigned char upload_ok_html[] =
+	"<html>\n"
+	"  <head><title>OK</title></head>\n"
+	"  <body>\n"
+	"    <h1>Upload OK</h1>\n"
+	"    <p>The file was uploaded.</p>\n"
+	"  </body>\n"
+	"</html>\n";
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
-- 
2.45.2

