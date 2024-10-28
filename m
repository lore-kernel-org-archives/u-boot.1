Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBA9D3398E
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 14:34:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D95D89148;
	Mon, 28 Oct 2024 15:32:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="CtTZ4Emp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F22589112; Mon, 28 Oct 2024 15:32:20 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2072b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::72b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0E50890FD
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 15:32:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrGiGaYg1idn8ixKLpzJCVqrZFd+o/M7sQVdfaiRh9R9VBmV+0PlpzsTqlfT81iP848PTg+MLafsK1kTCTtoUzgHwmkdePOL6D7pXluRjmgYmHu7lZxPWT/drpZ6e+t2DT+a5zj6NBxhNrdMROimHKbtaMEkgSPPwoKailMVUBI4bRM4G7p9bbMgha9krRXWMPr2cukLN5XF6sbJABuFxk9c6t7qLt1jKgliQXsgb6FEWSRKPWImYRAuqR6j5Po/D2KmfyIurqutwTsoPEnCj5BhH2RoxiYLCFDJJR0g/KHSq5KoNUIFt3HlNkFJvNlF36GRLxe/TGTOBOhQyPHaeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSwOdMWPtEZWVHbIOWVyivkDovW49loSxVEJzO1T7iM=;
 b=Pqi+reHGGmmuboGRNzflxzEi2NmaAnXdlpteDKcPoeWsvUpl87YuLdLY+DSyOcZGDMpYwsHkrppK0V3h+gKGoUqpiBgqcEvuDfAQmcexRlclljjKboi7Flq5x9yRF1mppT3bwFF6oUbgaxvWxBQi5OVZoUhzAeNMgiieDXJDBC3HVQc9t2nSRqriuHLOgV623Hqi/u2h0lWNDIhq+Zx/MYQmjwMJYSsMOrf2Jid4ZolHX8XdptfUoangtB76yJHwdq8z0ku0sQ3ZvjK79tqqPEN/ocHGCdlOyEQSEjg2mCP5QcHE0O7hxYbcaWZxKEWe/oVLygZGUbSVOTzQ4YZrJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSwOdMWPtEZWVHbIOWVyivkDovW49loSxVEJzO1T7iM=;
 b=CtTZ4EmpOelhmVRkLJsDb54MrUWLpKgMez0q29zK2qZQRcwPBB7v8Rnv6eviwPS0lOfxxAYRQnbQl/JV+pCy30mk31j7rjiYNbiabawEmgcBOcie0bf3nw+BmjRF+pR0Nka3CfTekE47gUWAbMNZaG5sMLSn3CxbkUNG8EVYfkQE1RhryXzfr8nPR6gPLWjb08XR1S84cmWMUuiva08ewYyrcGp2OnOGqNBof0PbS0/TZwdDRd+X+RpebR82E/ki/6agEmnYd2BnqDb/0z0Bc5XKvH6ZNkMNpE0qj/F8Z81sQd0BPPolLxDs3BR+nZmfaxJdv1YDZu+Lda05Bk/n1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB9879.eurprd08.prod.outlook.com (2603:10a6:150:d2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 14:32:14 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 14:32:14 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v12 11/13] net/netcat: add netcat over tcp support
Date: Mon, 28 Oct 2024 17:31:41 +0300
Message-ID: <20241028143143.1807305-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0101.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::27) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB9879:EE_
X-MS-Office365-Filtering-Correlation-Id: 48230e68-a606-4cb6-cfa3-08dcf75d5114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NzObhNSuVAsmLw7rGuicSzHBtPftM4oJv1I8aFedhfajxOW05JoLn4VZK8c1?=
 =?us-ascii?Q?O2Ow2rNIvCDwADhObY/Iuj4BbqdRL2fwC49nKR8wVHJtVenAj2z20nhMiefC?=
 =?us-ascii?Q?ucZRO+q/tJMHBZuS47klJks8WVNbww9DpD0xjSKncQ75eETinP6BQRsII2M+?=
 =?us-ascii?Q?4VD8ahuY91u7YvIUrEgV0xBr1OGLTV4QvBcJp2qT3yxwwglg/XX6QIrA7kTm?=
 =?us-ascii?Q?fIy/5NLNwIgQ5ScSLRV8XyLxFX/Kd8TtSMjc1lKna+imFmAFA4kN30ynetUg?=
 =?us-ascii?Q?QRBjjnzbDkW60mvDwUcWoyJ4ZHNwsdm4upSY5tbztk8kIL5eirdcc8aY66Lu?=
 =?us-ascii?Q?ZRzH2sinQRFbPH9mm6NJyOA+DukqC2i/N5RtjwJDzacSsUENnTjVw0QibPuY?=
 =?us-ascii?Q?T3xm7mEAArVJPC2g8/I0iBgeFsPI/2mrlml3TCZcJcza+L63k3SFM3Y6LUf1?=
 =?us-ascii?Q?OhVonqa5eZv93tbZiNd+zDIlBCl1m+e5I4X6ABX2soTjFExzfmWwtjKEdmjy?=
 =?us-ascii?Q?y6vimAtugoZy77MNYVbOB9YoJHnnMeMfMPUk3yYTp7OCul8sq0BnztkmjBaF?=
 =?us-ascii?Q?2N613w8l22FLC63/rHc09NRwPpAMBLWdXcVhnpvqlbOJT8LScrOhd/TDWzJs?=
 =?us-ascii?Q?qk+VIOj4WICzTw3Tim4aVYUgnfM7+gtG8oVC8dqnFZdZb19nZlm/CY+9DlF7?=
 =?us-ascii?Q?XjtCqbouqwrch5yQVo1LkQLvy3rNxNVA/bS14U7aurVRTwTNcYZRy7YYMsOh?=
 =?us-ascii?Q?26zSUblZS8BVcQy59mnMoLffoKbw+wZYZkkIEsuqqT+mWoHBSUA8v/NLMuMe?=
 =?us-ascii?Q?wfZ7nLRV4W9hccyq+pT0deHlzozelXkUCzDT43V1xFlruzLPfsTGolYBmJ6o?=
 =?us-ascii?Q?i6s8pynHVHfyg9jdsNVrCwpAooRkEsPys0F5O+rDtxaskyIHA5klBzSRq6xE?=
 =?us-ascii?Q?oJOjqneOq275jEgVAxgV5bucTX5v+//wEHk6IyuUS+NixJ085WnjdASor49d?=
 =?us-ascii?Q?cnknkWvGLHwDRWdoLpgmV5PWSeIC3p14vMiRyLdqbJsKKc2FWA79SITg8tok?=
 =?us-ascii?Q?fC+YYmohwxRiGZfqyUKaK0DxTtAAoxG+3wEABBGa6TlUhHj6ar9avs3BFyly?=
 =?us-ascii?Q?/O0KMKzCxaF+n4VIf2ImTtKRp7eUkejPboiIuptgdCh7xOSL7oiTOsiobN5M?=
 =?us-ascii?Q?vN50RIlggOwlMaYZEf3ab0vkJ1v3G5xmhIR17KTF/ju8LqfdrYaRPCBENi67?=
 =?us-ascii?Q?h6uGCE4dOcNn2STm0IbYj1s9Uiaq1NuOtsGeZXrZSaOcGGAV+5kFLXPopvKv?=
 =?us-ascii?Q?Iea22pLZEYrQaVDSbuTTUeSdY07uFnXNUrB6KYXqTAt0Gf9JYQY2zTceKMox?=
 =?us-ascii?Q?F3DX6yb12RKsAs8/wxs2y61Wi9nF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vj9Ant6M3QRGjnNfPw7OCAgsprXPBDZz9QkYqn8dIlwJXqmgtQc6jO4WxNMk?=
 =?us-ascii?Q?18XlzckJx5lmsYrxBn7wGttLl9jqPn0W0uVLZjvL82a8spdRI/DDeS6ad6XK?=
 =?us-ascii?Q?oxMoipVJ9/cWvKPRIcS5Alj2AgghfIUodfAFKa5DjmeaucUQ47Ks2J0vK6bu?=
 =?us-ascii?Q?HHRaOcQ+QGhXg/FIXd8xfQu9TmLyOtLkHM7RTCbnlT5pv865cyGPGTWIkWH+?=
 =?us-ascii?Q?ntrYChr2pyYaRqk1i1IJY1rPQlwdNuM1gl3nA35e9VTu82y7koMvV9xhS67H?=
 =?us-ascii?Q?D75bgeK+ef0Tet1DG/dioohe0f2KW4n7nZNvA6fXpeYeHXEQvumaF/AB6O0k?=
 =?us-ascii?Q?dabk7LuxgFc7dEcdQvBPhTcDQ14Ogg2FpIkdErY44i2+C9DVVEljTyDB3ZOA?=
 =?us-ascii?Q?hvh6nmjjdtMhk1j17jDDBXzt4qY0i9Q92+G5ed/e5nUEQWz2u2pXGi/PIQao?=
 =?us-ascii?Q?U5MRW6gd7b0oUoQ7zqeYf1k5zGQTaHjKdo1mttBl6V204c7omyGo1K1vF1EW?=
 =?us-ascii?Q?Utq2hPZytLkfHJT4dn7q+XVEGO5jfxd2mDl3lmljkNmVDNUrFxkN4CS4dHJt?=
 =?us-ascii?Q?qg/Q+t0INjI/VDajDPNJryn47X43ePPS+YZOCSPLpK7cIoQog+F2LPdhr/C4?=
 =?us-ascii?Q?CJNDOxumwJ0wTyeyuG37qxu24YtRrfD9l7/RXw6WjWJbmRSbSDA8pLjAw8sO?=
 =?us-ascii?Q?RJHIyZ6xEPnpAwCytW2d9vpRPBwveuU6xaVzjJ8g9mrJP/GL0ckKcTCd/EYk?=
 =?us-ascii?Q?OcGMJ2Kb1KJgsm4CxTXJuKyCOSDfo3hcSgRsORgaA/27CQBuCLWflspWsIrc?=
 =?us-ascii?Q?knUseN6xnZICBjRiGem+oav9J4fSohCluEOqhlmAinidUiQS9VMTKQQiJfLp?=
 =?us-ascii?Q?3hSR3NAsk0ijBjx1UaBeqvyuuUtDfra0f+NtHC+XzyV1rj7Y3wmJdioKxXyL?=
 =?us-ascii?Q?C99hgu4lXkwj+D+8YA0YxnBU/D25D2fqXoSFGOMV0dKvkhF0ZKCCrN2Atc/G?=
 =?us-ascii?Q?3csVBRl9YRcdAWFVzDwgSjOuHvAyq6Bp7VpCmAiz8YFu6uZdjf6WyamjgUyN?=
 =?us-ascii?Q?2G0V2XO0kYGu18AyEqyrAUjefn7T/U9lvN3JbUp22dsAbrg0PvNenrQpusGB?=
 =?us-ascii?Q?iCyR6Gc61lXKCDvXccAOuf14vO5QIiCIhqgUORmdkmWCwFrOrmNulf+8/nyo?=
 =?us-ascii?Q?uYBnkjKl+nVv9cRiJSYqfzpwR5g8Xb2sSPxDnZ4M1b5tLCEo1GUVhIJVLzjn?=
 =?us-ascii?Q?2lAtQeybo2wWTD5Eb9LSoCflixWAL2eQdLtkPINulgoD7gNxbmJmclq7V+hf?=
 =?us-ascii?Q?1awpVzIJhfetmsHq+mt9idzkKCWRzR+Ip5Kg3ZYHCbLnuf8HXVQ1k7HqrGJt?=
 =?us-ascii?Q?4tkLEAkCUK61O+C84So3IXUzcrgxzfHF6gb4rSJ0bYiugWbewJO+wf7qa8tC?=
 =?us-ascii?Q?Am8xL163MUtD+4gnNcf4YaR6HYGu8sFJWblJ37yE2Ev8A87bduF8rX/SDJ41?=
 =?us-ascii?Q?w9wbvHi3s3gSCCFNXfel5YJRzmq72MOeNqjpi1gX52ylIDH2hjaQfY0oh5h5?=
 =?us-ascii?Q?N9v8iysu67c7TnUJ/MZp8ECZuIiaFHUQgU6J7y0Fe+c7WBZlP/XexLPLUGeH?=
 =?us-ascii?Q?Ym2+EhTUO7vKXHcW0s9t4+A=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 48230e68-a606-4cb6-cfa3-08dcf75d5114
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:32:14.6303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NzLRy249TsxLxcYx7pzubYPjNntlI/NAi2Rc1bFf5wsUSUjDPBrBHLPZ12JScaJKLzsHTUhpJoB1IdKNh+z1Uux8D7OoSq/TMLLsMGN00rQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9879
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
 include/net-legacy.h |   2 +-
 include/net/netcat.h |  20 +++++
 net/Makefile         |   1 +
 net/net.c            |   9 ++
 net/netcat.c         | 194 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 265 insertions(+), 6 deletions(-)
 create mode 100644 include/net/netcat.h
 create mode 100644 net/netcat.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 4fba9fe6703..f1d85c1fc7b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2077,6 +2077,16 @@ config CMD_DNS
 	help
 	  Lookup the IP of a hostname
 
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
index c90578e1b9f..3dc9918207e 100644
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
+	U_BOOT_SUBCMD_MKENT(load, 3, 0, do_netcat_load),
+	U_BOOT_SUBCMD_MKENT(save, 4, 0, do_netcat_save));
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
diff --git a/include/net-legacy.h b/include/net-legacy.h
index d6902508ebd..fdb6d2abb85 100644
--- a/include/net-legacy.h
+++ b/include/net-legacy.h
@@ -305,7 +305,7 @@ extern int		net_restart_wrap;	/* Tried all network devices */
 enum proto_t {
 	BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
 	NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
-	WOL, UDP, NCSI, WGET, RS
+	WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_SAVE, RS
 };
 /* Indicates whether the file name was specified on the command line */
 extern bool	net_boot_file_name_explicit;
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
index 209377aeb26..4cf13efe17c 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_CMD_WOL)  += wol.o
 obj-$(CONFIG_PROT_UDP) += udp.o
 obj-$(CONFIG_PROT_TCP) += tcp.o
 obj-$(CONFIG_CMD_WGET) += wget.o
+obj-$(CONFIG_CMD_NETCAT) += netcat.o
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
diff --git a/net/net.c b/net/net.c
index 39bc3ce8903..50e8cfa9ff2 100644
--- a/net/net.c
+++ b/net/net.c
@@ -103,6 +103,7 @@
 #include <net/fastboot_udp.h>
 #include <net/fastboot_tcp.h>
 #include <net/ncsi.h>
+#include <net/netcat.h>
 #if defined(CONFIG_CMD_PCAP)
 #include <net/pcap.h>
 #endif
@@ -572,6 +573,14 @@ restart:
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
index 00000000000..47dbebe5ae2
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
+static int			marker, marks_in_line;
+static enum net_loop_state	netcat_loop_state;
+
+static void show_block_marker(int packets)
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
+	if (netcat_loop_state != NETLOOP_SUCCESS) {
+		net_boot_file_size = 0;
+		printf("\nnetcat: Transfer Fail, TCP status - %d\n", tcp->status);
+	} else {
+		env_set_hex("filesize", net_boot_file_size);
+		printf("\nPackets %s %d, Transfer Successful\n",
+		       reading ? "received" : "transmitted",
+		       reading ? tcp->rx_packets : tcp->tx_packets);
+	}
+	net_set_state(netcat_loop_state);
+}
+
+static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
+{
+	net_boot_file_size = rx_bytes;
+	show_block_marker(tcp->rx_packets);
+}
+
+static void tcp_stream_on_snd_una_update(struct tcp_stream *tcp, u32 tx_bytes)
+{
+	show_block_marker(tcp->tx_packets);
+	if (tx_bytes == image_save_size)
+		tcp_stream_close(tcp);
+}
+
+static void tcp_stream_on_established(struct tcp_stream *tcp)
+{
+	netcat_loop_state = NETLOOP_SUCCESS;
+}
+
+static int tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, int len)
+{
+	void *ptr;
+
+	ptr = map_sysmem(image_load_addr + rx_offs, len);
+	memcpy(ptr, buf, len);
+	unmap_sysmem(ptr);
+
+	return len;
+}
+
+static int tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf, int maxlen)
+{
+	void *ptr;
+
+	if (tx_offs + maxlen > image_save_size)
+		maxlen = image_save_size - tx_offs;
+	if (!maxlen)
+		return 0;
+
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

