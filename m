Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C892C3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E53C98862C;
	Thu, 27 Jun 2024 13:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="FQ44NDu/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F1A58861A; Thu, 27 Jun 2024 13:40:06 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8090885E7
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACFP4stcQ5teTtRM2Pa4Uw6ZYKzNWZRKYsaDyWE/5Do+KdL7qEtXTxCqILC8Sc59OmpKsmWS5XKGxHPSJeY10bwZ31chha3veG9BpNwrUgjhh4D8WPoby3fG2o6SonEGcEwSLL8LZf/nhOa8n2quauCecKreXiyNx44MMXArKUT1/9u08LhGuzCDXcPWNr76crig/xw5oa3dPO3XYDwVkn5ln5gU8pLKuEYRVqRG7sr7zXnhkDKd8r+chgfc7W3gPj9ZPzD16HkBf/yraoNXwTcq/u6ZwZsjw10qAIoMT+MUY/rQ2sT8zXT24gB61CSnBTDtd1dG4oelB8bn+EX9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eP6uG9qhaM0zqflh4V2LCmovCnLOEH3UDDHo12ZY08E=;
 b=burqGUbthW+o3Gn5mypxH7Y2f2QWuvd6qy89XGR8sc04ykz9n6x3FuxAfl+J0oo3WxK9mE9/Yb7/cM2FqsyllQacK9yQ6OlnOumfmkZu5NJFlk+AxeJeIX1clGdwH2V0weqaXYsZjbGomO4Cq1yS2L3qbYnSDmvX5FDblTShG2S+JeyHsqAzr+XaJXWokvJClKHArgZOCbbD44zaG0SjaezxZL6aQhbTJBhhgPjPIkUEIFwMNSTMDUZ4REKbNJo2hKwd+InMHpIEjw+c5hYmUJn8edHbueh1QXA40Nqq8Uv6TabW5WBqDCVakwzGvKunQWLm0dQ+6kqLcf1vo1Ab7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eP6uG9qhaM0zqflh4V2LCmovCnLOEH3UDDHo12ZY08E=;
 b=FQ44NDu/BXkUPs8amBmPR7wm7sdx8IUPMvNlvVFwaweSQq0Qy0sdQLw9boWbO5c2vuQzH1ZQ9f90JcZapOm99oz7J7+5oxLm7s2LltrUEbd03TyW9DscGfNjLvNlXcWVYACRR9v66qse0q05jaWK4lHNrCEG7nEHnc07SlgNSZun733CEC0e2uzZ25qB8ia8/3Y9UisS+oHxMAJNfZIBMDkyO31hZNBiLZlU2oNwb5UgrcexKFITcKbMCoN2hHxoLqj3srxwHCnE408rwUezJOKip3hsQs6V3KBJEtGgPe9zl/9RbYpMaKuZE0tv7S9ZPq75PPj0kpR4RXrmpcKFBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB10427.eurprd08.prod.outlook.com (2603:10a6:800:1b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:40:00 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:40:00 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Marek Vasut <marex@denx.de>,
 Baruch Siach <baruch@tkos.co.il>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
Subject: [PATCH 09/12] net/httpd-upload: add web-server for file uploading
Date: Thu, 27 Jun 2024 14:39:36 +0300
Message-ID: <20240627113939.100620-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627113939.100620-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240627113939.100620-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002BB3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:21) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB10427:EE_
X-MS-Office365-Filtering-Correlation-Id: 213774b4-b67d-4293-8dcd-08dc969de08a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6ZO8A7Oo71tT/ICmHVPIWOoFD9QQDgkBYWnp+j426YsgbHaFF2x2QZyf9hzr?=
 =?us-ascii?Q?4ILwjnj6GjecXqA9wL0HpGpvURmaDzu4egvFWoK8HXiNGXhlvKMcn9jUixuz?=
 =?us-ascii?Q?FtC98iQpHanLRQ6MZCDeJ7cLg/KgjlTY8g+moBJ7bnGXAwfHpaGki+rM6FsV?=
 =?us-ascii?Q?toqj5uxr45Acqo9VvAp4+zr7kiwdCuV9UPYvesZhwhb3uPoypgamTv0z/eOd?=
 =?us-ascii?Q?AVovtXUW4FCt3iWYd3xZBDzjlubahblCtj+fbVfigMYy2I6/EJwNTRRUl8K5?=
 =?us-ascii?Q?+qmccdUmJh3dwBkgn3eHFDbEQfjn4HcTxlwLpiqbLpWeipeUKsNtPOi02rcu?=
 =?us-ascii?Q?iyxVQCYi0122c9h5QjEeqXkpGBx6xnP2ChnzxwZPMdBS8Mo7C5mRH6RZMvog?=
 =?us-ascii?Q?v+ilOU30eadk5J3qXu+b8vJ2YGjZGnoVv0wLSv5HWE9UTQEhvz4ey833m3yH?=
 =?us-ascii?Q?XmCxE+J4NTZhs8ipJggEviHFgYVym53rzJ0fKp6t7eiRUkQnR+oCRneQZ1Fx?=
 =?us-ascii?Q?G6121zXA+BI7PMmBTxjd/jo7ugWLGkRZRpcD85T5b3OGJg3LRYOyNQtxbYr8?=
 =?us-ascii?Q?MhC+Yoh/cIItBrlHZk2EmPbkfOqF3TKkrMpJEx34IfWIBYB52ema0F0PUs73?=
 =?us-ascii?Q?nWKoDLASEvS42mkO3gTKNusmmptjPwMowWaHGEbgK/xrmun91EAyOcx5cmjy?=
 =?us-ascii?Q?00QDiG/O/oPI/wp3DOO4nzRxjqz1RekpHPFUETcVUNTT6DTl5wwhh/InzeZQ?=
 =?us-ascii?Q?zrF+ckpMxuyXTXoffIqRKGY5nG53wPVYV+3I3BQASEk/HZsFPqkp4AfMiRSg?=
 =?us-ascii?Q?DwxCwe/DImtmqC1/4Rcdqf4HT2mXulCalWSOc6kNfGn0hiCjftEl60x7IJJP?=
 =?us-ascii?Q?KzenAyDc8amn0kVHVkTrkl10fdkJI5AaRekJOPtkwPKu0djIFX5Ds2CxhkGy?=
 =?us-ascii?Q?KrFjuTsHdXYG6ExPmgc77RrTQ58UHBuIjZMVD8U7zxEmiyydnkDaZcmyc2n7?=
 =?us-ascii?Q?v819FcRKPopkwNuxyjE/Bewk0ZgRmtsk+FzX90AARZ3m5MiBbo7AerX23hNB?=
 =?us-ascii?Q?PV2yP9D3RYcSPPQZCaqkwRXsYDAIfawtFOemZaXk22D8EKWCA8ZdqVHsNKmU?=
 =?us-ascii?Q?gJeXXWCRqEer4rmuGdXyL9aghsUW1bHGK79FS9QjiMqUlwlAApdygsCjT4HF?=
 =?us-ascii?Q?V3I6HRtk2JdRVeTGUHt2besfBHo3m4tV5y7rXriuH3xAa0FTzMgSDztqro8u?=
 =?us-ascii?Q?ZFCJsJLXnuuZqlXfWXEaH1YKRxR5lx7bT/K+AKo/MLInJrAUw7dNDYyllVw6?=
 =?us-ascii?Q?vp96xUyeosDgsbEp0xznZy/ScQRcFHYa0c2AYWv4xmB7lvUDvkHrAzapWRsO?=
 =?us-ascii?Q?U30yd5QndzTcSg7JDyuOR5LWK/GAJexm9Wo8t/o74InQqGsmg9eo5/NBly8R?=
 =?us-ascii?Q?iS6t0yzMBes=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j2JVeH0QsLHnVXSKxRhQaXLxAoQND+RoHDIy90uVh+rxO42aTSNCwU3tQA/7?=
 =?us-ascii?Q?0OFQUOMygsu7igW1v1MJ+bF7PnBJREe0pCq2pwrRDRXYCiRkSEHqIfrNDw8z?=
 =?us-ascii?Q?LLB0bWq/ZRjG2CNBrSJAx4OrtoA/DmCY2ur/cCaiBAqfA9QvToACPFh6ExJc?=
 =?us-ascii?Q?AnP/yWArn6hbq40jhD4ymdPG8zY5dspmjVjS+jMm6xcDhmb9O0CDlVPIlXap?=
 =?us-ascii?Q?lkXWWfgPVax9y6ZWDYTXMkZKRYgNGmeY8gjOFz/ASL1WRnkzfwMW9If8YNbb?=
 =?us-ascii?Q?Kf1CIyEE6i5ywQW9QcCqDHL9MI9QK3Zzt/tCsUnxYQ4U9J0hfX65U8A3WH0v?=
 =?us-ascii?Q?UWI3Z2G/hU7ogVXwEgObBORYfV8biIsdbsAQwnjoacU+00nKF6uXsvExISm0?=
 =?us-ascii?Q?Oc+CEIsdK8lXpeZjjUAEDt660EgcXrsNh0AVrANrRa77QQcSLzAl6EJhrVt4?=
 =?us-ascii?Q?eicR+xvM6joFUWYZhRPs7BNdeLHiQ5mx8tvSEZ+fE8CKmKbmykyQQ/K6nGmu?=
 =?us-ascii?Q?F5IjE6loB3YFlizAUC/S6zZbuFPLYB5aVoSqrXoS4pLgt0tTsK+GGo85fevo?=
 =?us-ascii?Q?87ZMSgLxLmYHmk2lH3JGnUxeohd4VVFQwWwTVUkwHoPDnlkJQfgfgCPWUzcF?=
 =?us-ascii?Q?R2U6DosDU6ZZ8Tjw+HLEmrNiKrRLrFusL0ez0ByAvg/Pqde+S3kONCXSLZvj?=
 =?us-ascii?Q?DmWwttLIWc8gAQi4I1in5oYfy0H0rwkqSLuA8jIFDOx8xxI4ryWAlI+TKBtW?=
 =?us-ascii?Q?P6lL2ZZPYQhp5Ts8amXc24TK0WHWIfuuq5HH84WfAAPkkPOPGL/uVyYdVBEy?=
 =?us-ascii?Q?6dXN60oSF2TpLyFqKWMRxmiOi5ABw2yhpDblZnmtemrEXW/9TpFRDQluqJaV?=
 =?us-ascii?Q?ZtuqUOTPXnNJmP5BVWkqqw4pznicoPm+RpkANpx1RFaj0CjZV8sp2kqEs1BP?=
 =?us-ascii?Q?1D3ZK/s1gcNBLhb78uJmBGO6DVCKcjZGfM4d4hPd2p1bLCkS0b4fylYPaRhM?=
 =?us-ascii?Q?OfP1l+X6trLsp7IAKFplY8V8kWMauiQIrOLevwSke3bqvKVVxKwJ9l7i6g6H?=
 =?us-ascii?Q?ZnOrCzhiRbTKl+wOjjtF/9B4BbLhi3SHoYstfE2gn0mKvVVe/AofuwNLfR79?=
 =?us-ascii?Q?qASXpB3u/7UJipI3qc622xdpW83eQKxdGQJEAPuf5kDkjyYdsT3DguZ7CHhb?=
 =?us-ascii?Q?4I1oqkMfHxFgtTWxDDWtGzVRj/GPf3xbLXTnO2TQT8OVXBnx4vAK8xffy0KI?=
 =?us-ascii?Q?Ym8hdoHzbhTzvcqhpUyaQ5Dms5YE56iMajvcav7nUOm0ms0crxe0IYzbMVzG?=
 =?us-ascii?Q?lzbFev+Tsrur0LekATTJgiXNUwmzRM/jdekhVScs2V2ifgzFuNAs5Xa+Leso?=
 =?us-ascii?Q?4cTtVWaL/H4cOruAcBp5QdSk/4QoaJG035CFhULnQIV7sH90+VQ/hlFcNvXg?=
 =?us-ascii?Q?bzInPjBYgyICLsisWQcCLH7VZG+18lSUWasMop7m9Kwr6gznacTTWPM+P57c?=
 =?us-ascii?Q?aw/a5B5J6Fk2SYlThTPCVoq5HRVatAPHrRDGZpFais6a/8Dsz//qVhwFeuWt?=
 =?us-ascii?Q?TvWRfcoSGw49PoMU7rdVPvTLvDWMWtNbhVKy1uMuqQDYmQlFNcbyebRL6lft?=
 =?us-ascii?Q?XR2Dc8w5qDIEc4cOIbcEr2k=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 213774b4-b67d-4293-8dcd-08dc969de08a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:40:00.2522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0eZ+XvE6Naz81dQ6D+uMvwqNJH6lLxKVVkT/y8TaDSFAf7JBGPxQ8xi3OFQY2TUpOj8bLliNfUK7iVmxA3kqR8grgQqWjiJ7YsyGGqWivk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10427
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
index 00cc13e2006..e5d2852168b 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1997,6 +1997,20 @@ config CMD_NETCAT
 	  netcat is a simple command to load/store kernel, or other files,
 	  using netcat like manner over TCP.
 
+config CMD_HTTPD_UPLOAD
+	bool "HTTP server for file uploading"
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
index ecc1b49f52f..22e9d1910b6 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -22,6 +22,9 @@
 #include <net/udp.h>
 #include <net/sntp.h>
 #include <net/ncsi.h>
+#if defined(CONFIG_CMD_HTTPD_UPLOAD)
+#include <net/httpd-upload.h>
+#endif
 
 static int netboot_common(enum proto_t, struct cmd_tbl *, int, char * const []);
 
@@ -230,6 +233,23 @@ U_BOOT_CMD(
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
index 00000000000..f3015a37f2f
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
+	if (strcmp(url, "/file_upload") != 0)
+		return &error_404;
+
+	httpd_loop_state = NETLOOP_SUCCESS;
+	printf("HTTPD: upload OK\n");
+	return &upload_ok;
+}
+
+static struct http_reply *httpd_get(void *req_id, const char *url)
+{
+	if (strcmp(url, "/") == 0)
+		return &index;
+	if (strcmp(url, "/index.html") == 0)
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
2.43.0

