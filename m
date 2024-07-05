Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF5FC30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 15:06:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8098C889B8;
	Fri,  5 Jul 2024 17:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="LwtWTz+L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24F5A889CA; Fri,  5 Jul 2024 17:05:13 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2071d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::71d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDB7F889B8
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 17:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eszstEdFS+kO6mpBRu43B2/5ha33EUFA+S1trP/t3yeY5oLn+wohq448lkBDouAGy5SzVDyMZye03xTcnIZ6ioB1FcCcLXl7cYQuFPvIkpMzkQWPAV6q4NbmEMxfClCRakPAsVpZWIvcfnZ0OdodE93j0vTsI+oHI1vlVKnyKqtRw4S1hVSZ/HDN5ss3S+6aCPGKBwkqMLt+bsZTeVfBmEse4vcRJtlOzfmvMxqlocd47TGF2cthXnnECX61+sCVu+zGk+vLtuZNWPi1svFh4Z/+pUn2E3qqu/ptFjhxBCMlIiXn70QgbqMUwSVENiULson4qViT/RWHUqrPq0tIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHzMVTkbxIapvkp7XawE78EgOsEa3Etn1av4ZGDBK/c=;
 b=J4fDo0iY+grlbNCAiLs5/14LB4FKqL0xPS4ZKqInErERuLxQDY0kYmvpcH8LjdnZPmReWKwn83Ff6nFbm27cOokeFPcyANr66n3q3KBZ0R+BgBIRStzX/xQuKAtw5douYln0W5p+s7234KEJP0QYcnFEqyGvDxnePY/FU+Lj5U3i5c1nVw0oZOcoPvLtQxH+m6iw3FktXlZGPIlYu4ytF4rPDebcPVwt9cdI8qOQlPpmGsnOwiLG1dLF7WtJLQ4UHVXuunVUtbgWqTuQ8DoA+pU/mcYWdfpAp8Oq0eZV85XZhoLSF6IqR8rf0IwfUjUCUZHk6iCDMYPsHd7AT+6lyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHzMVTkbxIapvkp7XawE78EgOsEa3Etn1av4ZGDBK/c=;
 b=LwtWTz+LLIV8U+E4qKZtoCZWjPFFQ76ehMsKObVoz7JEQrCpHugjJWntDKhWMmL76CqfVOH+7cB6SFoG+lQO9cEe4m9dOt46ecHZ1slHswCSwo2IbMg5E3Gq/aegmDeDSfTvyMFJ9S018tXMsB6IO/Ym8CUg51zwPk98lGMGB6yLaSuVDxGl4nmfSAW4yYobsGVWPEfIVxoSSuYe9GvRw9uSaKU6UDDnSVUspnpfpwDzXOw2y3xWbd8O6AiiqGVHg/fR2gZ014oqE4sipzbcJW0svU5sRx8bXf9PXEkXUVLON3XDCyKVgfdPFcGtwN2QPZ/5Mwbtl1/BH8q/dAcs/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9834.eurprd08.prod.outlook.com (2603:10a6:20b:605::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.28; Fri, 5 Jul
 2024 15:05:07 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 15:05:07 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Marek Vasut <marex@denx.de>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 9/9] net/netcat: add netcat over tcp support
Date: Fri,  5 Jul 2024 19:04:31 +0400
Message-Id: <20240705150431.2274662-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705150431.2274662-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240705150431.2274662-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0058.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::22) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB9834:EE_
X-MS-Office365-Filtering-Correlation-Id: 65bcb6d6-c726-46c9-a168-08dc9d03db80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EPmvHVTX3FPY/WSN83bOdtTMTEBuPqfh96jZJjcWf+6nVKD7EiHNDdTWbC1h?=
 =?us-ascii?Q?hlcMzCDbOC3j2+Q3YoLvWG0Ke5m85PRCRNFEMkesGGBbYxqgdrbpR14M7ig4?=
 =?us-ascii?Q?OEcw5T0hXC5fd9e1mJjrHLO0mfgXmRW2Y3FwuP0UUsTQa3xtBlDlfpKsRfVZ?=
 =?us-ascii?Q?b7/KqOkgaM0/r3OvIQyZ2oFouHQ0vrHOC54GVQNS65vr6n5QDBD/wlxTu0F+?=
 =?us-ascii?Q?lFZffXVj4RFl7CgLiwRYIBMODzAPdvLExVaN4PFYDLQ15QQuCwazOGe6qkYG?=
 =?us-ascii?Q?h/GNc1SXTjJNYMYjp7N/BE4dbFc4wMisGEabQoHXQ4jGkXTCnh1lewDn79QO?=
 =?us-ascii?Q?tzMstGVLQ7INQ/lI5OylzLWWC/ASfqNlJq6QWR3E36SPSbi/I88EOntgbzSF?=
 =?us-ascii?Q?5cdZ7V1Dm9XjIm8q4c+HoNYqSRZISCRjmWRhqXYqvDr7pCLM138RdJDGX5Wn?=
 =?us-ascii?Q?xOfOXF8GNLbQkPqCG1vSRse56obJeFRZcr5qfnj410t+7syuSGt1bKTCD7Lu?=
 =?us-ascii?Q?/hA1Ys+9zWXN7+UOXshZqpNrtNuIeExH5Bcr6IWjwajP/VV7b3gYEhbo0VJd?=
 =?us-ascii?Q?uGhWlY3L7LrtoWqe+LAuH60R/q5W63dDboQgI7+5uaMW4j1qvZ3SkY78TrkS?=
 =?us-ascii?Q?GfsE/DqWm59+lG0sycT49EJQgR89UlsZrvmXSY8mmtZmtRCGqpfbEQsh5xyg?=
 =?us-ascii?Q?YQra5zsbdvV1vewitQNL/pt3650Cz0LVjxxyS9ykPo+HqVknaYLNzi2l8SF0?=
 =?us-ascii?Q?K26kPo/DHehjWzJL944V3CMbgxX2jTX+W9+N1+io5+RW3ZduWEyqLoSKLWXg?=
 =?us-ascii?Q?PLpl8LzSS4FLVsYowzgaWSag9g+hr+SZ+jnEZDaXoxcJM+ra2zCW2rX04q9e?=
 =?us-ascii?Q?xAA4VwmBejMnLDxxhujVVRP3MdMs1qH8PkyljPx8KS+051uHGjkoVasqOa20?=
 =?us-ascii?Q?bejW/aRBDxScQ+n2fFlk1ppE+vKAI4PpTnChcqJ3ZiklDslB/J/2UEC5owJS?=
 =?us-ascii?Q?AdQo095wiptT0e2uDwMXTMl4NglhXyq9fraPDQq0OoAua7gJohnaxfannaua?=
 =?us-ascii?Q?wux7CWbN8AHTfP9pbQUAKEw7pzSibqjwu5LMKNQIqiuesu+bbZqvmyzOp1fD?=
 =?us-ascii?Q?CyIhOjnMH87lFNc2aqQ5lNNhvo2RiffeLkntFwCFCx6tUd+81WE7HMb3/pl8?=
 =?us-ascii?Q?xVu4icl0dp/I7mk20R1Em3hH8c72hLvkuaGQu8eKAdSr1kfngMk/48ihMxaI?=
 =?us-ascii?Q?CKhhvHtMucxELilMWgFR/En/K6CPonViC+Sb5/By4gH9zxGVLjcWs7M2qzi4?=
 =?us-ascii?Q?mkP/JTU3cF9CkcZ3W/aK7VWrIxj3GEv8Zi2E0VffJDb7bpPx7xa5uagWkWga?=
 =?us-ascii?Q?zdfv9ZLJcA4Q25JnJAJ4ERBxnvmJWhOn5MUwq8EzHTz067k/aArE6GD1UWsz?=
 =?us-ascii?Q?46i4yn7gUhQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nb/fZ/xSFg2Qziey8NGNte5aAuZnAE+oUlAwSH75b7BUChVwMUIweebHhojE?=
 =?us-ascii?Q?lTDkeYwdz2c7MR4xJTLjNX1zR5oTepWDHujsl4iAEn9W7ekVsDBhNl5adL5l?=
 =?us-ascii?Q?S3J6Kzjl7lFpHYpBsIIYvwL0k6jL90N7x7/hhMPm+/rKd/ombKH9IHykN9qp?=
 =?us-ascii?Q?xX1CBoFE/J1IPY4pme+7DL+m3iBloc/7w/78UCCNB9lgiTB8urfuXaGACJqG?=
 =?us-ascii?Q?VAdtYOGQn9AEWHgOQmWRJlaUhZqh5vmH9i4g+CsIJ8Ub3WSlJ8U7zPlgBCeE?=
 =?us-ascii?Q?SAf87EK9pIh0ATog8RXcb7p3ZlRaHuxiJfIHPamwQeb+ESDxmFUT8dbSNDAP?=
 =?us-ascii?Q?OH1VpzLGvKv0+5zcMoEvcmCs8AwIyd+EtWi3J4XaWPSEYfEuVxoxxM+UMCY0?=
 =?us-ascii?Q?KCxcbEyb8rvkipbLTjRUT96ioqnfdyrkf4dC8hdigsFMx7/l5wIWcC8Q0o4B?=
 =?us-ascii?Q?S/AjrcDp9RfCmUQCxJdv8PRogf6q+UhlpWCzpZuW0s4a0iaPyundfWd79t2j?=
 =?us-ascii?Q?b/CKon5mmQj9PhRvccoWgoTO4RW/8FNpZdfqfpkmNgvm7hGRY9bt+p8hKnCu?=
 =?us-ascii?Q?1+UT0TIKbV9HqVNWpvZq4Aro/e21bYwwDD4hzj0kP7jcQ0/4dKILRZNalfu7?=
 =?us-ascii?Q?EMCCISnmcUh+2cBOXG91KbbM7l9pUGkVyjjqBPn12AQZltrfQGzM6wQtRI4e?=
 =?us-ascii?Q?SnhTNKXjynQT2I5QH9J2vRFb5TqwerdP8PBS8tppFkDB09vnGS/W6K8uDCt8?=
 =?us-ascii?Q?6WLFIDuHiLAs7UjYyyTTTxrOGYGVG7mjxDF0oAFHp/W6cylnlZdErP11vFyJ?=
 =?us-ascii?Q?mvY7P2sPXL94mndSJTx+gulfoDEsftWkfNMsCGHciw5+iLv+ZETiXOcjZGhP?=
 =?us-ascii?Q?4u8ETU9/G5E/lMYnuXqLz4071Yp182IgBHCbgcJgZmOKOU15ekQ/fDWN5bdt?=
 =?us-ascii?Q?eiVYpaR33C5b98KIV+helND1ptM30cmWMwdTAE3cKt3m8uvaT4YkbzECPjq9?=
 =?us-ascii?Q?2Y2Y70KpqeScmS+uDZrcWgnbStREPLKgofnh6elP+CbNxnW/0CC+yfbW6KBZ?=
 =?us-ascii?Q?Swd3el+23Hb+5q75if9Unu46w6l+v9tB1SDoIPR7aoAUG5GqJ7TgGcRLC+2q?=
 =?us-ascii?Q?e74jvthHAca2vNkXfdflY6IVi47z9mS2QlJ3Cl3BlJ1LADSgBg+pNebORWpQ?=
 =?us-ascii?Q?ZSc3h0ydaFIagPX5sTajFmkhq34t4pfBjrcTzowRxaoHQOQq5yUJ+sW7zQtK?=
 =?us-ascii?Q?75t61uk5l5g10HJm/iBr9z/YKa8kpmT53QVbsLZkK5NZaGJg5yf+qxv7Jws2?=
 =?us-ascii?Q?P95KNFp5XXEoSJDODKIAnxDBgwS5yll49f0pmvXdKgPnjA+ADqpRRZ76El++?=
 =?us-ascii?Q?Higd4LQuCXKuSdOlgQGEiGKaxErUVOlXGg0VzNCTghTu3yeLWPYQc5XRFW8J?=
 =?us-ascii?Q?CG0g6Z2ACspY2xpGRLZngP1WNekX0N8en2ZuGxKWinudyuAQ44xNm5OZ770n?=
 =?us-ascii?Q?XsRpmJKBD0j4wJu45rTnnbrbmqgb8Ki2LPj3iiWBdTIDJyz/Pf6I/zm4Etzn?=
 =?us-ascii?Q?ymSCjDiBTm1dQIAq2Trr+StL8K3DevwKINYH5OTttHQBAJXx3NqDkwZs/p8K?=
 =?us-ascii?Q?Wk5DoYIkGBUZ4AgBMLYA7/A=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bcb6d6-c726-46c9-a168-08dc9d03db80
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 15:05:07.4386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVYeGKGX0tB+D6VIGEDP1iHyUzA7mWo9jN7lpysfv0VyieXUG0YTSWhcU7NQzI9tiLtSI55qYX1Es2Wj7245Tx3kLfQVEkOxagL4igmwtNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9834
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

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/Kconfig          |   7 ++
 cmd/net.c            |  34 +++++++--
 include/net.h        |   2 +-
 include/net/netcat.h |  20 ++++++
 net/Makefile         |   1 +
 net/net.c            |   9 +++
 net/netcat.c         | 159 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 226 insertions(+), 6 deletions(-)
 create mode 100644 include/net/netcat.h
 create mode 100644 net/netcat.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 6834bbd82f3..00cc13e2006 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1990,6 +1990,13 @@ config CMD_WGET
 	  wget is a simple command to download kernel, or other files,
 	  from a http server over TCP.
 
+config CMD_NETCAT
+	bool "netcat"
+	select PROT_TCP
+	help
+	  netcat is a simple command to load/store kernel, or other files,
+	  using netcat like manner over TCP.
+
 config CMD_MII
 	bool "mii"
 	imply CMD_MDIO
diff --git a/cmd/net.c b/cmd/net.c
index d407d8320a3..ecc1b49f52f 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -208,6 +208,28 @@ U_BOOT_CMD(
 );
 #endif
 
+#if defined(CONFIG_CMD_NETCAT)
+static int do_netcat(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	if (argc < 2)
+		return 1;
+
+	if (strcmp(argv[1], "load") == 0)
+		return netboot_common(NETCAT_LOAD, cmdtp, argc - 1, argv + 1);
+	else if (strcmp(argv[1], "store") == 0)
+		return netboot_common(NETCAT_STORE, cmdtp, argc - 1, argv + 1);
+	else
+		return 1;
+}
+
+U_BOOT_CMD(
+	netcat,   5,      1,      do_netcat,
+	"load/store data via tcp netcat utility",
+	"load [loadAddress] [[hostIPaddr:]port]\n"
+	"store Address Size [[hostIPaddr:]port]\n"
+);
+#endif
+
 static void netboot_update_env(void)
 {
 	char tmp[46];
@@ -325,16 +347,17 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 
 	switch (argc) {
 	case 1:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_STORE))
 			return 1;
-
 		/* refresh bootfile name from env */
 		copy_filename(net_boot_file_name, env_get("bootfile"),
 			      sizeof(net_boot_file_name));
 		break;
 
 	case 2:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_STORE))
 			return 1;
 		/*
 		 * Only one arg - accept two forms:
@@ -356,7 +379,8 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		break;
 
 	case 3:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_STORE)) {
 			if (parse_addr_size(argv))
 				return 1;
 		} else {
@@ -367,7 +391,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		}
 		break;
 
-#ifdef CONFIG_CMD_TFTPPUT
+#if defined(CONFIG_CMD_TFTPPUT) || defined(CONFIG_CMD_NETCAT)
 	case 4:
 		if (parse_addr_size(argv))
 			return 1;
diff --git a/include/net.h b/include/net.h
index fe645245f0f..235396a171b 100644
--- a/include/net.h
+++ b/include/net.h
@@ -516,7 +516,7 @@ extern int		net_restart_wrap;	/* Tried all network devices */
 enum proto_t {
 	BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
 	NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
-	WOL, UDP, NCSI, WGET, RS
+	WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_STORE, RS
 };
 
 extern char	net_boot_file_name[1024];/* Boot File name */
diff --git a/include/net/netcat.h b/include/net/netcat.h
new file mode 100644
index 00000000000..09470e7f0ce
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
+ * netcat_store_start() - begin netcat in data storing mode
+ */
+void netcat_store_start(void);
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
index 0fca11d3e8c..809fe5c4792 100644
--- a/net/net.c
+++ b/net/net.c
@@ -110,6 +110,7 @@
 #include <test/test.h>
 #include <net/tcp.h>
 #include <net/wget.h>
+#include <net/netcat.h>
 #include "arp.h"
 #include "bootp.h"
 #include "cdp.h"
@@ -566,6 +567,14 @@ restart:
 			wget_start();
 			break;
 #endif
+#if defined(CONFIG_CMD_NETCAT)
+		case NETCAT_LOAD:
+			netcat_load_start();
+			break;
+		case NETCAT_STORE:
+			netcat_store_start();
+			break;
+#endif
 #if defined(CONFIG_CMD_CDP)
 		case CDP:
 			cdp_start();
diff --git a/net/netcat.c b/net/netcat.c
new file mode 100644
index 00000000000..ea225c68c87
--- /dev/null
+++ b/net/netcat.c
@@ -0,0 +1,159 @@
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
+
+static struct in_addr		server_ip;
+static u16			server_port;
+static u16			local_port;
+static int			listen;
+static int			reading;
+static unsigned int		packets;
+static enum net_loop_state	netcat_loop_state;
+
+static void show_block_marker(void)
+{
+	if ((packets % 10) == 0)
+		putc('#');
+	else if (((packets + 1) % (10 * HASHES_PER_LINE)) == 0)
+		puts("\n");
+}
+
+static void tcp_stream_on_closed(struct tcp_stream *tcp)
+{
+	if (tcp->status != TCP_ERR_OK)
+		netcat_loop_state = NETLOOP_FAIL;
+
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
+	return len;
+}
+
+static u32 tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf, u32 maxlen)
+{
+	void *ptr;
+
+	if (tx_offs + maxlen > image_save_size)
+		maxlen = image_save_size - tx_offs;
+	if (maxlen == 0)
+		return 0;
+
+	packets++;
+	ptr = map_sysmem(image_save_addr + tx_offs, maxlen);
+	memcpy(buf, ptr, maxlen);
+	unmap_sysmem(ptr);
+	return maxlen;
+}
+
+static int tcp_stream_on_create(struct tcp_stream *tcp)
+{
+	if (listen) {
+		if (tcp->lport != local_port)
+			return 0;
+	} else {
+		if ((tcp->rhost.s_addr != server_ip.s_addr) ||
+		    (tcp->rport != server_port))
+			return 0;
+	}
+
+	netcat_loop_state = NETLOOP_FAIL;
+	net_boot_file_size = 0;
+	packets = 0;
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
+	if (strchr(net_boot_file_name, ':') == NULL) {
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
+		if (tcp == NULL) {
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
+	return netcat_start();
+}
+
+void netcat_store_start(void)
+{
+	reading = 0;
+	return netcat_start();
+}
-- 
2.39.2

