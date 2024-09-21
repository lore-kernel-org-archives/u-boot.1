Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB29BCF9C68
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 03:46:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B16E188BBC;
	Sat, 21 Sep 2024 05:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="PUuWNuCC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5577887D1; Sat, 21 Sep 2024 05:44:26 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43AB388641
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 05:44:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGcXgHHoPF1sOYFAEHJTtt7N5BCT75UFh5O4w7A/Kdpo7dYDCUZe0S0hMPmlSlCHlxzxWPFsY86ABnhk+REyyxow/84uMNwdCbpKEkc85qUrwjteUX2LKB2kJkdTtYSAz6mQUUDAF/FDoQ8ubdFivqCiNNQZaZzSfa3Y9Cn//cszpA1MH5VnqO8JSo8GB3qvJP/yOuvg1QfQwemyfE89iYlwSvuzD3rdbANInoIVPWPhuMYdWOvQdNBa0/S/GNAhVj+WpFcy+tr7vwnakJFyoxBKyGe6gpb9eG4WXaYm4U8nVb04DsPatZxdjkQJG4O5jxC+vwZOacYhqfNHGf6Yhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAai+B3NX7mh8fnORRGFZEmiBJfbH9GLQrs9gP+sQhs=;
 b=gO6o8XgiEKoLdQmE1FC8GgEjhkkLtUfrfLMsO4cZffmOf9v8+WzNEtzm7FbKrL1og9/Z32KEpA5jLnsAXAAoRMxFNUc+lk2gjElsen+CBgGmhnkZJWNKywP6RUqVCOeT7OqgtBF1u/sSzkgnHEjACeeqjcVfuWPr8VgTvZcFZTCd0F2wYkCikqH/+k6gpfhGJUDh+wU0/NrFyqjPMbhsIgLjnjdpVS0Fsh/xQ2O/Z8mg4Nvzq0P0QdckgHsgSZQmsle+H2HXky+Rwpmjb8WOWz5oU4by7/fEsw45gtqiKAOaawfikEk8dwG6M0e9M6N54HUVavZKKvjc8qEjv3u31w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAai+B3NX7mh8fnORRGFZEmiBJfbH9GLQrs9gP+sQhs=;
 b=PUuWNuCCMJ+zRdP3upuO3G0YygeFuqVeMScNE7GlHqb3Gg7ASzSsRdQGITFfnvq/xaoeTuHZtdeHMSb6r53CsA/QO+ZNdLjo6dm/qIJalrktPxGW2gaOig1YHz/bLweNSJ/+p15pNmq5opMgwWC5GQvYVoUSJPBIWv0uNhTMRQ1+ZPy1CN4c1NCJX/DWqZogpsUaKzSCNhDn5H+DMTkKaU3gvTZthfQKKZ+KefMZ79loUxE6L/wHqH5Tx+52HussjYsrJhM5efASs6savyUlkG5dsoyC7dwEf1JDcYQoNpjVSlq5k7AxUS1i3+xA+yGnC+Z7ctnDWUCqNyEVM3VnCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAWPR08MB8933.eurprd08.prod.outlook.com (2603:10a6:102:33d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Sat, 21 Sep
 2024 03:44:20 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8005.010; Sat, 21 Sep 2024
 03:44:20 +0000
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
Subject: [PATCH v7 13/13] net/httpd-upload: an example web-server
 implementation for file uploading
Date: Sat, 21 Sep 2024 06:43:53 +0300
Message-ID: <20240921034353.1298452-14-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAWPR08MB8933:EE_
X-MS-Office365-Filtering-Correlation-Id: 6905d065-c41a-4329-3d69-08dcd9efad07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|52116014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SNWEKUJ8/h/jDKO5oD2Yi9xjM8KuPELLn/p1CxCVdBSq24qmOa/mphcAvCm8?=
 =?us-ascii?Q?5WjHIP5faJqQLtIb7qLo6Z2Lld9D2KfN7zIu0mpdD4GFO3qZSssuzSYv9gac?=
 =?us-ascii?Q?CB2EAzJRjb1lhI7SRLubIBxCxFcl6yYPl28/luvl47eDTQruRMeH/7DBcRCN?=
 =?us-ascii?Q?Bb+Qx4NNVsZLos1rvb8mHv7Qch0adv8Z3/Rt7LoQz/WIxUAveLoKx4rG1ApH?=
 =?us-ascii?Q?2s3pcg/6aWteRPzcy76xi7lOaAZQTD/1CMzy0SK7Y63rM1CkuV5w5D2h8y6/?=
 =?us-ascii?Q?0Aqfo18rx7FLYUsaSp6lgrIcEBva0QfYtZ0ZHqtm5GPFIQwaUK1yjtQKCrhS?=
 =?us-ascii?Q?zWvDZsj0FMMCooabcq5/x7r6ALnIxQx3A0Y7wzaYhtWkQdJV8RA8Z/3mGxuJ?=
 =?us-ascii?Q?DN11cSfHAqNzlvnl8YqpPbkrp16TTzx5ayjMce9Tl/yRqzrXASklw+8CuLLi?=
 =?us-ascii?Q?MB02tv7uTmhTn8vYXi2QlwFAz/sLp5ng+qGElzoBE/8aPgzW1S9tM7Qpf8OG?=
 =?us-ascii?Q?dGpZHYGJ7axtpH7tWnAUZxqlAYjNDFvWy61tq2zwJuhhfYceEZ9XersFLsrx?=
 =?us-ascii?Q?Lrbzq8Ydf9h2sBC9cutQKWCmkmlGWhL7kafJxWVhiXOQrSXt8Lc8KiHDAJlW?=
 =?us-ascii?Q?dXJ0sBUsYDPw4MM/K0e+BTStXyM+/Y2M+LX0byWM8bQ7Isj1nkULwCg2oMmJ?=
 =?us-ascii?Q?r4e25/Eu86tRb+8d86YPKnPT2Z4nxhQCRUV2pnEI0EqiUF5ZoH2r3v/VNrvg?=
 =?us-ascii?Q?zkVykv2QSaz3LtLoJr9RkT2Xikzzc6nEjyUCdnYglOapdxm9NlGVKUPE5cD0?=
 =?us-ascii?Q?RQpj3ebR2vRfRdz8mdQNxhnixoDYdiGSZmyCfv0CPhQLKWS71b86ugcN+B5w?=
 =?us-ascii?Q?4YqJvjmK0l/kfcMABjM4tL0gxtbNcTsWw3tJ2o2lOUiQhYgkVJnt4QfMQ6ZA?=
 =?us-ascii?Q?g0XORkMFeKhKVNvNDwAM/KdWeEtejZjvPnXrPUmKtU4VCVvr58EVbKBsV1F0?=
 =?us-ascii?Q?k72d/PYoDX8m+QJxJ6iPRmgiBtTYrvJQOBVHiF9emEIoISNX3wKiqlw2zkih?=
 =?us-ascii?Q?k8w81b3ew1bp7y0L5am8+SOBlY/c9+LjiL8YqsYOMo9jdu+01zXLeNs4t8Q3?=
 =?us-ascii?Q?zrZJHa73wbmqUO/4iMGg+kaX56S8IBx3189viRMgdk+8ePAiCwpwq1OgvY8+?=
 =?us-ascii?Q?ekk+FKjnoOzdeNRDXy8XU7JsZA2NwIhZgL11nI/9zB0HsfesNMfzm21wZMdG?=
 =?us-ascii?Q?8DdPW1b7At34moXPvFtX20eemBW4d9y5+CFSOYgDH3TPC98FNrXxLC1rUlqL?=
 =?us-ascii?Q?ZuXm47ypjgiuN/speceJsaGyRs2PG5efVY4HVsn8nad/B9dMEBTSNFNL1G6R?=
 =?us-ascii?Q?1BmOEuTIffz7QxztBI5Zc/ndS+PzUh2A4oIk/9RqxEA+q3w47ikASx1w9Q9v?=
 =?us-ascii?Q?OI/RYhsWjHg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Tze4gOJwxe05zV87u+eaLxAcKrQrkSmx63RN82QZ1hmRTSpdIv4fevdMXmZ?=
 =?us-ascii?Q?3ZaYHbNlx14H1TZTe2VQGIDbu2nrKbso4GUdzXxI3t7qaoQTLgwvXNy66k1N?=
 =?us-ascii?Q?5DaeZngrDhih4/7lviB5Bz6UCyaPpy+DUpuV1miEUFlv4AxDd36DDm4pVLCN?=
 =?us-ascii?Q?Te9QzgNwHmQ3ttaBqV4oSMBGs7N5vSop59pIL0CbJ/xESL9TsSKv3k80sFKc?=
 =?us-ascii?Q?jdQswxwJ+RHKuRmqV0UilP8JIR2ncYA9zdE55/hvCx6o7jiBe5ulmgtAxdiV?=
 =?us-ascii?Q?h3WGySpEba2HsGoT1ymy2Q9chpfu7Z5SYl709UlIHYG50OWkYn9Bz2MRtXpM?=
 =?us-ascii?Q?fJKWYpkBisjzX/YqC5D5AH+6vvpMfVVxWZHnzIHKuiwPbSEcgsBJg8QL5gyP?=
 =?us-ascii?Q?0kX1AZdPg0p5ex+1TSqMWrKu0w7DPW3IJm1x8zQKlxqTZovnx8V50D/0rgac?=
 =?us-ascii?Q?93wMToR1WeSs0E9QbmaMA5+Jb1GdPsnMJV+Oh/vQIIEASG9xKQyFT49hiLQ4?=
 =?us-ascii?Q?Q9PriFNMrFxt5Edk/sN/iwYjUgg7NlgxSjt47ZjYGTuHwuMoyiY4WBDUxVXz?=
 =?us-ascii?Q?s8IQZX0eh1oJRdSHWlbVi74d+Hv3PDR6WqQfJjtWNFcop2mcwGeupfce5kRF?=
 =?us-ascii?Q?2C5VIhJl25BatoBkPIjGGFX4XyigyFh79lujXSGv56YLTOX7oD4+SinQhn4z?=
 =?us-ascii?Q?ZHrLAAF7O4wcXNoczIJUWxaBzW14i65+nXKIEWpSEUM98+w93PRLs8XPmsym?=
 =?us-ascii?Q?zEEHA8MeNp/WvsQW5f8kkZxZsa2QVXmWORL8y3tH/lAcs+Srq/OTUsxwdThV?=
 =?us-ascii?Q?Fh1QCBGS3ayFfBbnnWLMUYjPCgbAflMcw5BuD0b3+O2VXXiIvj1fWrJXRmhN?=
 =?us-ascii?Q?++1T7NFPTISfF3rzo4mcCZFo/4xN34yVwMqrgLgB6iDXyPEygskaAJ9J3i50?=
 =?us-ascii?Q?0XRLHQVew6Xox9orPnSnNFlJ5y9vnIx74CC0F0ne4oefnrJ+rnsF4ROBq5C0?=
 =?us-ascii?Q?yvVOui64I8RB8AF5pPQgQ43RVw2EJXlRcK+IdSCmi0neCNSE5kejwDryGwZl?=
 =?us-ascii?Q?5J7iIXuIlswBFyrWc8SFM4JidpBmIRa/AiWpt890n0ggYtJUznA9NCFUrvb7?=
 =?us-ascii?Q?vZskN/J9/A862ElvhjIMJY/LFB/aw+I1EVXdcjoibKhIqexavLx3rzkaHGWn?=
 =?us-ascii?Q?Je5RGEsAZTKHlfUnubDB9rjZ5SPA2GO2kUmpx+ew0/FQHA6tlJgF3kEKhNIf?=
 =?us-ascii?Q?fyD3aPNAVsFCYVatDrcMEb0AQp8+YxjI+UwlsODuN4QGDLymJSuvDMb3XxR2?=
 =?us-ascii?Q?jx984GY3U8nD7M4+2yD2TcfI7vsiU3nsARoSlXhWkgKM0PSGM/hihTIMoBXL?=
 =?us-ascii?Q?r6UesyDgGgpl2N3/0RcKFm2RHVPw1WRwpedadLQIuINvOLL2SQoZpSWzW+Tt?=
 =?us-ascii?Q?fLzUFAsU6WMk7G4qRt6E3xy6oE2xvLFxjc+/wFrAucUN6LtCCs0MYkHkbwgl?=
 =?us-ascii?Q?gMU/qOVO+LFPZRQfT3D9TF+v2yBckI7bLyViB3bG8HckqUGAjam8VAHfoSLJ?=
 =?us-ascii?Q?YK/ZCDG+4mnKM3BhBfDWEUZ//0A+wAzBYQ+QwgrQLrgfwpn+2R4OC/X48MsF?=
 =?us-ascii?Q?iBddk/S0PNDQHzJJDvX6PNQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6905d065-c41a-4329-3d69-08dcd9efad07
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 03:44:20.4515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FINV69XGKGUJYfyrtPz/EUqbcWMknVmJtcoDOawFDpey4ivGWlU0LIrEJEHp9u+A8+BAYWwPyGJ/att5JoR1fClJD1B7+hftIdPF1TaD/Pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8933
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
index cfdc53e494a..b7749525ae3 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2017,6 +2017,31 @@ config CMD_NETCAT
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

