Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7981BCF044A
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 10:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D236891FF;
	Wed,  9 Oct 2024 12:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="mGE7ENoz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CB36891C8; Wed,  9 Oct 2024 12:51:26 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66B75891C8
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 12:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bR7JhOqlqBjW5eRRclcWY4rCGyl9wnkn496V97+l1hYFgg1S3/TGrph+OSUZ7t649VRsI85MdbbZyxB7O4uf1W67uYNm4i9jJwnBZorPeV66VajjERgmTah9vfxQ99RC/VLszXQ3bRSEWnSVnFMdDW01ekJ0+rRwxzlc1EhtG0WICohSA+qLOlRfBxbxcro6VMOWl52OkWr9rI+1zVFFPi3bAhpLSo0F1Z4Lv4MBKqUcNDtKDQwz6y5Fj3De3vcPiGO2+3TNQI2ybWmchtgRQfmKDdWsPx3JxBGy4wO4VFlF/9B5ZP+y3yq535l5ygtlbJdurAdsiPM/boPFpqeJog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y47ejzTkjm+SCg5iYP7UHe7kwu676bcmd6GeEhrQByA=;
 b=vlZ3FhCk7wKmJiqb3Tfzurj3nYOfk8y2vVvKtby4bsoaey7YNCScnFWbTKv13ihpHOMosMNA+5C6gmgPJIsCGWPD7fCJQ0G/lL7HDuTNcvLWNpKnmJcec5DkWFC+g3jSy/PWF1NG/6d8ho+NeXbwrefxmY2cWmdYzr/V5ORHdL+Cd+qxL3FTUSZY2Xwi6nM5VXGZAEWkXEtgpB/UAsqtzhW/VE6lcEnWe8Y/hA0Fh88WDIIu6gZ44VUytYPzQn7FyGEbxZ9auP+bgwZ0SOp1wtPDuU01GpR8DSmttYshJIAtyK4qi5bqwFUSaulGw+S1sPyfCIixYqVlMgWa+zvZTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y47ejzTkjm+SCg5iYP7UHe7kwu676bcmd6GeEhrQByA=;
 b=mGE7ENozX/MF9LH+S2RU2BXEKO6pU7v86eckX7fYG62QM5DuLii+sO373pcRxYVd4kSVU8hKFoyOF1720lkNGRvy3kwKBx3e8SwdXK10iAoY4zBEwunW2I8WZ7U3NmtwHjUg/+N2ICgvhIzCFGGjYPZ9dIWx+kVvEwKEJC9ZLOOuEDP5q0zYnWYxNVvn65Lpk236PxCYW+E+MGX5nOIaTI+x4je0j1Cmm5qtmX2949F7Hazgr86/cyuEMsuXYcR4HFd0CgOvA6XcGsymcEPaR4uxhZkc9HTWoUDaKCARP7Zd9h+6vepsy4LOE1rybC02WDVxuOYFSmIyemeVWW/pnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB10026.eurprd08.prod.outlook.com (2603:10a6:20b:632::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 10:51:20 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 10:51:20 +0000
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
Subject: [PATCH v11 12/13] net/httpd: add httpd common code
Date: Wed,  9 Oct 2024 13:50:53 +0300
Message-ID: <20241009105054.1879054-13-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: d12f2a29-ca58-49d2-d58d-08dce8504f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fUPzvoLGAhHbOPiECWt21zHIxrjnrT0cufgt5j6lk+A17Auvd1IwpBob9DW0?=
 =?us-ascii?Q?w0MEwfti1eswjaLTCL39MHWEQ91ddN0W8ArNFpkCvY3Ibu7r4QTckfVapSEC?=
 =?us-ascii?Q?v3umamFCtykc9EgmDE97eUzx4QfvycadPEaoJaTJ4f85AtQLV4GP/nbtKTNo?=
 =?us-ascii?Q?Ed0EEtrTnvJupY4Mg9FE/0mz3pzYMViSpCzrQQF+aXb8ku1Uowm6ZoHzHqqI?=
 =?us-ascii?Q?Z7h3xGIQyjDOuOLWdXT8prEfRTZk6XDtZnq/7o/5R+6YHOr2lnvrD+mvKXCk?=
 =?us-ascii?Q?Wl1oI2xk2eLs+HMm92jpeuMDpKmx4CY7RnL/blBBrBEYU/axqZhNXMZ5Xkhr?=
 =?us-ascii?Q?F7sr3sGxkIKBUVjukazVA0q8/NBpuSrEDT2tI7KYjaVtwixoVXVgjtRgtQQX?=
 =?us-ascii?Q?W7nlb8t3ua4hnlc0JbLxrVKQmExcufvtTtwgHgRkjwd97fabX40YIOy9/1ky?=
 =?us-ascii?Q?vCqLC4tDSTL4WZhQVL/UCcUDZxJPFgfwtHlt8LX8iT7HlUfqz1m8n2LGk6wg?=
 =?us-ascii?Q?4y8Bs53KGQI3xaANnJ2eglKFw/53OY0cJt8C9BbM7+EaS9+WQ/O/F5gaZ6Xc?=
 =?us-ascii?Q?uRPI4my+8hlBbdVjN5yRDwHJu1p8v6NDfkaQn5q7U0XATiJX9An7VaSFHdEz?=
 =?us-ascii?Q?xd7sdKJ3lNLHIrIJW3r06B0L+o7wkdG8Z2FxPmTki2O8hbwHLH+3afIrgBSm?=
 =?us-ascii?Q?Qu2RxEXFJOLWm4+Fgbq8UVrylqvU/E+bk5OP4/If2aXoVeCSKU6+n76Fthoq?=
 =?us-ascii?Q?8GgMd3uJz8J9wWsZZiQGmiUAHY5mh9UqFIPyhENpC0wXKD3WYPxUr9HZT9n9?=
 =?us-ascii?Q?uZGmOigSu0sd9n7NJY4iQplDDlayxZ2jCjuKj7Lpu6SDgGAJ2W07kAL2UKEN?=
 =?us-ascii?Q?SiuX4vsQNRUDpTJJ/EQkfhKJ79rZRYlA6yHwvItnLV2ijAE47EDrz9VS8xVS?=
 =?us-ascii?Q?pNavABYTNuSwXn/rX71kJh1m7MH/YMAh6iWyQPG+zg7WTJMEnJWpw7hZdAOc?=
 =?us-ascii?Q?KZvPO6BWtK8mdFgLiI25Qauv+inBH4Fu2u5/6UZx0whMC6+qIJqqs725Z9d2?=
 =?us-ascii?Q?e9mVzadPK5MEi7cFhpoGE3ix6mvfQ7mnnv5GfZ+wdn/2Bp+w2YfEiVMndvwF?=
 =?us-ascii?Q?CVyaGmYsLatxHMngKnj0ab4p6NNXNlHQUGJS6HlojfanZUXv7ITSuvB15uDL?=
 =?us-ascii?Q?hAnYyiGyIB+Ps5bVtHKE3G79iDIVMu+CBzMlFM1Iguy9WUfs6QN3em4q7cJ8?=
 =?us-ascii?Q?OXfdj2wigur6kKPmNPvgkPLlvamklTZVbUPWNfjfKwcD3a6AOoLH69Q5jI2k?=
 =?us-ascii?Q?JLTnJcSbCT6chq4PsAmhXIsTjiEUkezNZuslwkkdbtv9wMgbHO4MukjEQEI9?=
 =?us-ascii?Q?W6Ij7fA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aAdy+MPf1gPwb8UR4UDL8D9iwqyZxjgmFJt2TnCGIcVhPNOxKJZ4ztzIhdrn?=
 =?us-ascii?Q?DC9i2uq2mo2mmBzmqTuFj1bn+ZihL3vuy8rl5bsM0vwE/z9WoGqSN/BYM2/X?=
 =?us-ascii?Q?lDCcHk23eWI+PEEY4DhyRsYyhMft6w8FgrgYs7mXYnz9QViW/THnVDPViKBz?=
 =?us-ascii?Q?Jt/kONWEvkCAfMC/jAaoQIRDt26f8TauTC9BxN/KvbC/pzpiqdz2MIar8C4M?=
 =?us-ascii?Q?g4ZHFRTAWJ06fvDxyHORgeaX61C9+zsywiAYzHC65Q9jrjbKJwFLVad10Uvo?=
 =?us-ascii?Q?r6+eN/skZtDOALDDPuI3ua7WryPItz/9oHQUIxYRAT3CHzr4E42H8rmCJXcB?=
 =?us-ascii?Q?iXUSFpRYrP1vSFn7QcQE1mkCEuknEbOu7ABojimvZTi0vMEFURp+oD1t5cMe?=
 =?us-ascii?Q?kHS5rOpfowRGLYNFDuJpkOkuDn5gNNpWF32dDP/WkOwOZqW37VaDHu+FkQmW?=
 =?us-ascii?Q?sjmvw93GFdJXk33z8VSgWDY8MbKfkcJyjC3eXV2GloKMNE9TQOeG+ZIU7Noy?=
 =?us-ascii?Q?+OAN+RNbsl0JVwtGu5R9zCmUVz3Ws7w10nosyghxOID6sgCAYcLnFjjTio2J?=
 =?us-ascii?Q?kJIv6lpmJlwtp4yYoj9mErvfO64aIUXK3A+316wxj7LvemD3TX3jFXkKa30X?=
 =?us-ascii?Q?lrxcchx35UTyFqhR4IC33ZYjiDCqAaFJGA0AF70rHPbfgVGOuPHyLhSJlgrY?=
 =?us-ascii?Q?yOGLVzSyKb/uqK5BrSl9XQZN2alLvI9//Lsx6P7Yx3cGyXMLfrF0ErJnnDqT?=
 =?us-ascii?Q?rtWigol/XDE6O+GcDuOP7K5L5AY5aSo1NIvYs8+dkLGEoUicnSDO4bSRZac4?=
 =?us-ascii?Q?+8NIjUceaQnCTnE0H7Txj8KTm8A7HwpzplCH9poGzYy2b5nPj3piyzKOQjXZ?=
 =?us-ascii?Q?1Q7qtFlCwSVX41/0ytVytO+5NCzVeVaxz2/XBVLX7L6VNLaoIysog82QXyWw?=
 =?us-ascii?Q?i28Hhm5bWKCBaBhMJmK72c8FzaAPA8ygKMDX/+r8I+cDmes08SLjdNmKAg7L?=
 =?us-ascii?Q?GjEdc9zHae1Ej1UJAexWRwaN4gIbFj1ZU5hj+kYP9C4PJLNHqfcbbMdam0ac?=
 =?us-ascii?Q?ZUdNPuK9VcCqdcXY9Xse2zMyc+iP5k98rpFbk9qm9MSiqptaunNxF6pJU56L?=
 =?us-ascii?Q?evreC1NzXZ64PAcChngCmED9h/uBDfrZJVKa03EKoEXgfdBqkjXDy1szIikr?=
 =?us-ascii?Q?NpnHfOm6X+LTZ4uhOcxGWVaXZauaT4jSIPHxAOveNbd0Dd5tLzCrgfN8OQ3K?=
 =?us-ascii?Q?8RTaVYesf4dVrPbDN4qAR2YM0XXCH0xVkj65ulPLwR3wMJsIAgLZ9rTd9JRf?=
 =?us-ascii?Q?V1CukGcwTaPrz8Z0qDdlhFKmnErHpEBlvJUUg/ktK6+S3AxzOzvNohV/anDX?=
 =?us-ascii?Q?91V/ZHmV1NjfF/kH7l2Xc8BQbpmD4sE9MDdn6Ehk8zCO9UI7OCEx1GN/f9Xj?=
 =?us-ascii?Q?ebbh5IOQuAKNuk/RN7J2H4au0xKtkbstvMDqOzxQfgVp4gjHnhCpJUp3pw+q?=
 =?us-ascii?Q?mMhtccbcz2l8ijEsu++iG2b5Y2hMDWmNge5DckylKYBDNO7Lg/02Ry8qd68f?=
 =?us-ascii?Q?PDfr0xEteP/K+yXXrABAWkI0K8hELkX4Phw7eHvM3yQB8acNeeOIGzECcj+b?=
 =?us-ascii?Q?2qekZpEkEO35Nfeub3ikEBo=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d12f2a29-ca58-49d2-d58d-08dce8504f19
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:51:20.3486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1hQ4gb4LXw6YcBn1HuzVlTZ3sNApw+UNpynCkLovJkfGdqeElCBWoSfLy2v7ptOrF/8boPvBLWAOO9NDrt1w3CWA6bqu865MeK4yX6wf08=
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

This patch adds HTTP/1.1 compatible web-server that can be used
by other. Server supports GET, POST, and HEAD requests. On client
request it will call user specified GET/POST callback. Then results
will be transmitted to client.

The following restrictions exist on the POST request
at the moment:
  * only multipart/form-data with a single file object
  * object will be stored to a memory area specified in
    image_load_addr variable

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 include/net.h       |   2 +-
 include/net/httpd.h |  71 +++++
 net/Kconfig         |  14 +
 net/Makefile        |   1 +
 net/httpd.c         | 735 ++++++++++++++++++++++++++++++++++++++++++++
 net/net.c           |   6 +
 6 files changed, 828 insertions(+), 1 deletion(-)
 create mode 100644 include/net/httpd.h
 create mode 100644 net/httpd.c

diff --git a/include/net.h b/include/net.h
index 0af6493788a..154885a2b7e 100644
--- a/include/net.h
+++ b/include/net.h
@@ -515,7 +515,7 @@ extern int		net_restart_wrap;	/* Tried all network devices */
 enum proto_t {
 	BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
 	NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
-	WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_SAVE, RS
+	WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_SAVE, HTTPD, RS
 };
 
 extern char	net_boot_file_name[1024];/* Boot File name */
diff --git a/include/net/httpd.h b/include/net/httpd.h
new file mode 100644
index 00000000000..ef6c37ece7c
--- /dev/null
+++ b/include/net/httpd.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * httpd support header file
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ *
+ */
+#ifndef __NET_HTTPD_COMMON_H__
+#define __NET_HTTPD_COMMON_H__
+
+struct tcp_stream;
+
+struct http_reply {
+	int		code;
+	const char	*code_msg;
+	const char	*data_type;
+	void		*data;
+	u32		len;
+};
+
+struct httpd_post_data {
+	const char	*name;
+	const char	*filename;
+	void		*addr;
+	u32		size;
+};
+
+enum httpd_req_check {
+	HTTPD_REQ_OK,
+	HTTPD_BAD_URL,
+	HTTPD_BAD_REQ,
+	HTTPD_CLNT_RST
+};
+
+struct httpd_config {
+	enum net_loop_state	(*on_stop)(void);
+	void			(*on_req_end)(void *req_id);
+
+	enum httpd_req_check	(*pre_get)(void *req_id, const char *url);
+	enum httpd_req_check	(*pre_post)(void *req_id, const char *url,
+					    struct httpd_post_data *post);
+
+	struct http_reply *	(*get)(void *req_id, const char *url);
+	struct http_reply *	(*post)(void *req_id, const char *url,
+					struct httpd_post_data *post);
+
+	struct http_reply	*error_400;
+	struct http_reply	*error_404;
+};
+
+/**
+ * httpd_setup() - configure the webserver
+ */
+void httpd_setup(struct httpd_config *config);
+
+/**
+ * httpd_stop() - start stopping of the webserver
+ */
+void httpd_stop(void);
+
+/**
+ * httpd_start() - start the webserver
+ */
+void httpd_start(void);
+
+/**
+ * httpd_get_tcp_stream() - get underlying tcp stream
+ */
+struct tcp_stream *httpd_get_tcp_stream(void *req_id);
+
+#endif /* __NET_HTTPD_COMMON_H__ */
diff --git a/net/Kconfig b/net/Kconfig
index 7cb80b880a9..55739b9bc98 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -243,6 +243,20 @@ config PROT_TCP_SACK
 	  This option should be turn on if you want to achieve the fastest
 	  file transfer possible.
 
+config HTTPD_COMMON
+	bool "HTTP server common code"
+	depends on PROT_TCP
+	help
+	  HTTP/1.1 compatible web-server common code. It supports standard
+	  GET/POST requests. User MUST provide a configuration to the
+	  web-server. On client request web-server will call user specified
+	  GET/POST callback. Then results will be transmitted to the client.
+	  The following restricions on the POST request are present at the
+	  moment:
+	    * only mulipart/form-data with a single binary object
+	    * object will be stored to a memory area specified in
+	      image_load_addr variable
+
 config IPV6
 	bool "IPv6 support"
 	help
diff --git a/net/Makefile b/net/Makefile
index dac7b4859fb..c1f491fad02 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_PROT_UDP) += udp.o
 obj-$(CONFIG_PROT_TCP) += tcp.o
 obj-$(CONFIG_CMD_WGET) += wget.o
 obj-$(CONFIG_CMD_NETCAT) += netcat.o
+obj-$(CONFIG_HTTPD_COMMON) += httpd.o
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
diff --git a/net/httpd.c b/net/httpd.c
new file mode 100644
index 00000000000..82181e291c8
--- /dev/null
+++ b/net/httpd.c
@@ -0,0 +1,735 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * httpd support driver
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#include <command.h>
+#include <display_options.h>
+#include <env.h>
+#include <image.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <net.h>
+#include <version.h>
+#include <net/httpd.h>
+#include <net/tcp.h>
+
+#define HTTP_PORT		80
+
+#define MAX_URL_LEN		128
+#define MAX_BOUNDARY_LEN	80
+#define MAX_MPART_NAME_LEN	80
+#define MAX_FILENAME_LEN	256
+#define BUFFER_LEN		2048
+
+enum http_req_state {
+	ST_REQ_LINE = 0,
+	ST_REQ_HDR,
+	ST_REQ_MPBOUNDARY,
+	ST_REQ_MPART,
+	ST_REQ_MPFILE,
+	ST_REQ_MPEND,
+	ST_REQ_DONE,
+};
+
+enum http_method {
+	HTTP_UNKNOWN = -1,
+	HTTP_GET,
+	HTTP_POST,
+	HTTP_HEAD,
+	HTTP_OPTIONS,
+};
+
+/**
+ * struct httpd_priv - private data of HTTP request processing
+ * @req_state:		state of the HTTP request processing
+ * @tcp:		TCP connection of this HTTP request
+ *
+ * Data collected from the HTTP request and request header
+ * ---------------------------------------------------------------------------
+ * @method:		HTTP request method
+ * @url:		HTTP request URL
+ * @version_major:	Major version number of HTTP protocol
+ * @version_minor:	Minor version number of HTTP protocol
+ * @hdr_len:		Length of the HTTP request header
+ *
+ * Data for the multipart/form-data POST requests
+ * ---------------------------------------------------------------------------
+ * @post_fstart:	File data beginning offset (from start of tcp rx stream)
+ * @post_flen:		Length of the passed file
+ * @post_fname:		Name of the passed file (see 'filename' tag of the
+ *			  'Content-Disposition:' line of multipart/form-data
+ *			  body)
+ * @post_name:		(see 'name' tag of the 'Content-Disposition:' line
+ *			  of multipart/form-data body)
+ * @post_boundary:	The boundary of multipart/form-data body
+ *
+ * Data returned by the HTTP get/post callbacks or error handler
+ * ---------------------------------------------------------------------------
+ * @reply_code:		HTTP reply code
+ * @reply_fstart:	End of the HTTP reply header and start of the reply
+ *			  file data (offset from start of tcp tx stream).
+ * @reply_flen:		Length of reply file. Zero if no file needs to be sent
+ *			  in reply.
+ * @reply_fdata:	Pointer to reply file data. NULL if no file needs to
+ *			  sent in reply.
+ *
+ * @rx_processed:	Currect reading position in TCP stream
+ * @buf:		Buffer for HTTP request/reply headers. Incoming file
+ *			  data will be stored in the memory starting from
+ *			  ${loadaddr} address.
+ */
+struct httpd_priv {
+	enum http_req_state	req_state;
+	struct tcp_stream	*tcp;
+
+	enum http_method	method;
+	char			url[MAX_URL_LEN];
+	u32			version_major;
+	u32			version_minor;
+	u32			hdr_len;
+
+	u32			post_fstart;
+	u32			post_flen;
+	char			post_fname[MAX_FILENAME_LEN];
+	char			post_name[MAX_MPART_NAME_LEN];
+	char			post_boundary[MAX_BOUNDARY_LEN];
+
+	int			reply_code;
+	u32			reply_fstart;
+	u32			reply_flen;
+	void			*reply_fdata;
+
+	u32			rx_processed;
+	char			buf[BUFFER_LEN];
+};
+
+static struct http_reply options_reply = {
+	.code      = 200,
+	.code_msg  = "OK",
+	.data_type = "text/plain",
+	.data      = NULL,
+	.len       = 0
+};
+
+static int stop_server;
+static int tsize_num_hash;
+
+static struct httpd_config *cfg;
+
+static void show_block_marker(u32 offs, u32 size)
+{
+	int cnt;
+
+	if (offs > size)
+		offs = size;
+
+	cnt = offs * 50 / size;
+	while (tsize_num_hash < cnt) {
+		putc('#');
+		tsize_num_hash++;
+	}
+
+	if (cnt == 50)
+		putc('\n');
+}
+
+struct tcp_stream *httpd_get_tcp_stream(void *req_id)
+{
+	return ((struct httpd_priv *)req_id)->tcp;
+}
+
+static void tcp_stream_on_closed(struct tcp_stream *tcp)
+{
+	struct httpd_priv *priv = tcp->priv;
+
+	if (priv->req_state != ST_REQ_DONE &&
+	    priv->req_state >= ST_REQ_MPFILE) {
+		printf("\nHTTPD: transfer was terminated\n");
+	}
+
+	if (cfg->on_req_end)
+		cfg->on_req_end(tcp->priv);
+
+	free(tcp->priv);
+
+	if (stop_server)
+		net_set_state(cfg->on_stop ? cfg->on_stop() : NETLOOP_SUCCESS);
+}
+
+static void http_make_reply(struct httpd_priv *priv, struct http_reply *reply,
+			    int head_only)
+{
+	int offs = 0;
+
+	if (priv->version_major >= 1) {
+		offs = snprintf(priv->buf, sizeof(priv->buf),
+				"HTTP/%d.%d %d %s\r\n"
+				"Server: %s\r\n"
+				"Connection: close\r\n"
+				"Cache-Control: no-store\r\n"
+				"Content-Type: %s\r\n"
+				"Content-Length: %d\r\n",
+				priv->version_major, priv->version_minor,
+				reply->code, reply->code_msg, U_BOOT_VERSION,
+				reply->data_type,
+				head_only ? 0 : reply->len);
+		if (priv->method == HTTP_OPTIONS)
+			offs += snprintf(priv->buf + offs, sizeof(priv->buf) - offs,
+					"Access-Control-Allow-Methods: GET, HEAD, OPTIONS, POST\r\n");
+		offs += snprintf(priv->buf + offs, sizeof(priv->buf) - offs,
+				"\r\n");
+	}
+
+	priv->reply_code = reply->code;
+	priv->reply_fstart = offs;
+	if (!head_only) {
+		priv->reply_flen = reply->len;
+		priv->reply_fdata = reply->data;
+	}
+}
+
+static enum httpd_req_check http_parse_line(struct httpd_priv *priv, char *line)
+{
+	char			*url, *version, *data, *end;
+	u32			len, tmp;
+	enum httpd_req_check	ret;
+	struct httpd_post_data	post;
+
+	switch (priv->req_state) {
+	case ST_REQ_LINE:
+		if (!strncasecmp(line, "GET ", 4)) {
+			priv->method = HTTP_GET;
+			url = line + 4;
+		} else if (!strncasecmp(line, "POST ", 5)) {
+			priv->method = HTTP_POST;
+			url = line + 5;
+		} else if (!strncasecmp(line, "HEAD ", 5)) {
+			priv->method = HTTP_HEAD;
+			url = line + 5;
+		} else if (!strncasecmp(line, "OPTIONS ", 8)) {
+			priv->method = HTTP_OPTIONS;
+			url = line + 8;
+		} else {
+			/* unknown request */
+			return HTTPD_CLNT_RST;
+		}
+
+		version = strstr(url, " ");
+		if (!version) {
+			/* check for HTTP 0.9 */
+			if (*url != '/' || priv->method != HTTP_GET)
+				return HTTPD_CLNT_RST;
+
+			if (strlen(url) >= MAX_URL_LEN)
+				return HTTPD_CLNT_RST;
+
+			if (cfg->pre_get) {
+				ret = cfg->pre_get(priv, url);
+				if (ret != HTTPD_REQ_OK)
+					return ret;
+			}
+
+			priv->req_state = ST_REQ_DONE;
+			priv->hdr_len = strlen(line) + 2;
+			priv->version_major = 0;
+			priv->version_minor = 9;
+			strcpy(priv->url, url);
+			return HTTPD_REQ_OK;
+		}
+
+		if (strncasecmp(version + 1, "HTTP/", 5)) {
+			/* version is required for HTTP >= 1.0 */
+			return HTTPD_CLNT_RST;
+		}
+
+		*version++ = '\0';
+		version += strlen("HTTP/");
+
+		priv->version_major = dectoul(version, &end);
+		switch (*end) {
+		case '\0':
+			priv->version_minor = 0;
+			break;
+		case '.':
+			priv->version_minor = dectoul(end + 1, &end);
+			if (*end == '\0')
+				break;
+			fallthrough;
+		default:
+			/* bad version format */
+			return HTTPD_CLNT_RST;
+		}
+
+		if (priv->version_major < 1) {
+			/* bad version */
+			return HTTPD_CLNT_RST;
+		}
+
+		if (priv->version_major > 1 || priv->version_minor > 1) {
+			/* We support HTTP/1.1 or early standards only */
+			priv->version_major = 1;
+			priv->version_minor = 1;
+		}
+
+		if (*url != '/')
+			return HTTPD_CLNT_RST;
+
+		if (strlen(url) >= MAX_URL_LEN)
+			return HTTPD_CLNT_RST;
+
+		priv->req_state = ST_REQ_HDR;
+		strcpy(priv->url, url);
+		return HTTPD_REQ_OK;
+
+	case ST_REQ_HDR:
+		if (*line == '\0') {
+			priv->hdr_len = priv->rx_processed + 2;
+			switch (priv->method) {
+			case HTTP_GET:
+			case HTTP_HEAD:
+				if (cfg->pre_get) {
+					ret = cfg->pre_get(priv, priv->url);
+					if (ret != HTTPD_REQ_OK)
+						return ret;
+				}
+				fallthrough;
+
+			case HTTP_OPTIONS:
+				priv->req_state = ST_REQ_DONE;
+				return HTTPD_REQ_OK;
+
+			default:
+				break;
+			}
+
+			if (*priv->post_boundary != '\0') {
+				priv->req_state = ST_REQ_MPBOUNDARY;
+				return HTTPD_REQ_OK;
+			}
+			/* NOT multipart/form-data POST request */
+			return HTTPD_BAD_REQ;
+		}
+
+		if (priv->method != HTTP_POST)
+			return HTTPD_REQ_OK;
+
+		len = strlen("Content-Length: ");
+		if (!strncasecmp(line, "Content-Length: ", len)) {
+			data = line + len;
+			priv->post_flen = simple_strtol(data, &end, 10);
+			if (*end != '\0') {
+				/* bad Content-Length string */
+				return HTTPD_BAD_REQ;
+			}
+			return HTTPD_REQ_OK;
+		}
+
+		len = strlen("Content-Type: ");
+		if (!strncasecmp(line, "Content-Type: ", len)) {
+			data = strstr(line + len, " boundary=");
+			if (!data) {
+				/* expect multipart/form-data format */
+				return HTTPD_BAD_REQ;
+			}
+
+			data += strlen(" boundary=");
+			if (strlen(data) >= sizeof(priv->post_boundary)) {
+				/* no space to keep boundary */
+				return HTTPD_BAD_REQ;
+			}
+
+			strcpy(priv->post_boundary, data);
+			return HTTPD_REQ_OK;
+		}
+
+		return HTTPD_REQ_OK;
+
+	case ST_REQ_MPBOUNDARY:
+		if (*line == '\0')
+			return HTTPD_REQ_OK;
+		if (line[0] != '-' || line[1] != '-' ||
+		    strcmp(line + 2, priv->post_boundary)) {
+			/* expect boundary line */
+			return HTTPD_BAD_REQ;
+		}
+		priv->req_state = ST_REQ_MPART;
+		return HTTPD_REQ_OK;
+
+	case ST_REQ_MPART:
+		if (*line == '\0') {
+			if (*priv->post_name == '\0')
+				return HTTPD_BAD_REQ;
+
+			priv->post_fstart = priv->rx_processed + 2;
+			priv->post_flen -= priv->post_fstart - priv->hdr_len;
+			/* expect: "\r\n--${boundary}--\r\n", so strlen() + 8 */
+			priv->post_flen -= strlen(priv->post_boundary) + 8;
+
+			if (!priv->post_flen) {
+				/* do not allow zero sized uploads */
+				return HTTPD_BAD_REQ;
+			}
+
+			if (cfg->pre_post) {
+				post.addr     = NULL;
+				post.name     = priv->post_name;
+				post.filename = priv->post_fname;
+				post.size     = priv->post_flen;
+
+				ret = cfg->pre_post(priv, priv->url, &post);
+				if (ret != HTTPD_REQ_OK)
+					return ret;
+			}
+
+			tsize_num_hash = 0;
+			printf("File: %s, %u bytes\n", priv->post_fname, priv->post_flen);
+			printf("Loading: ");
+
+			priv->req_state = ST_REQ_MPFILE;
+			return HTTPD_REQ_OK;
+		}
+
+		len = strlen("Content-Disposition: ");
+		if (!strncasecmp(line, "Content-Disposition: ", len)) {
+			data = strstr(line + len, " name=\"");
+			if (!data) {
+				/* name attribute not found */
+				return HTTPD_BAD_REQ;
+			}
+
+			data += strlen(" name=\"");
+			end = strstr(data, "\"");
+			if (!end) {
+				/* bad name attribute format */
+				return HTTPD_BAD_REQ;
+			}
+
+			tmp = end - data;
+			if (tmp >= sizeof(priv->post_name)) {
+				/* multipart name is too long */
+				return HTTPD_BAD_REQ;
+			}
+			strncpy(priv->post_name, data, tmp);
+			priv->post_name[tmp] = '\0';
+
+			data = strstr(line + len, " filename=\"");
+			if (!data) {
+				/* filename attribute not found */
+				return HTTPD_BAD_REQ;
+			}
+
+			data += strlen(" filename=\"");
+			end = strstr(data, "\"");
+			if (!end) {
+				/* bad filename attribute format */
+				return HTTPD_BAD_REQ;
+			}
+
+			tmp = end - data;
+			if (tmp >= sizeof(priv->post_fname))
+				tmp = sizeof(priv->post_fname) - 1;
+			strncpy(priv->post_fname, data, tmp);
+			priv->post_fname[tmp] = '\0';
+			return HTTPD_REQ_OK;
+		}
+
+		return HTTPD_REQ_OK;
+
+	case ST_REQ_MPEND:
+		if (*line == '\0')
+			return HTTPD_REQ_OK;
+
+		len = strlen(priv->post_boundary);
+		if (line[0] != '-' || line[1] != '-' ||
+		    strncmp(line + 2, priv->post_boundary, len) ||
+		    line[len + 2] != '-' || line[len + 3] != '-' ||
+		    line[len + 4] != '\0') {
+			/* expect final boundary line */
+			return HTTPD_BAD_REQ;
+		}
+		priv->req_state = ST_REQ_DONE;
+		return HTTPD_REQ_OK;
+
+	default:
+		return HTTPD_BAD_REQ;
+	}
+}
+
+static enum httpd_req_check http_parse_buf(struct httpd_priv *priv,
+					   char *buf, u32 size)
+{
+	char			*eol_pos;
+	u32			len;
+	enum httpd_req_check	ret;
+
+	buf[size] = '\0';
+	while (size > 0) {
+		eol_pos = strstr(buf, "\r\n");
+		if (!eol_pos)
+			break;
+
+		*eol_pos = '\0';
+		len = eol_pos + 2 - buf;
+
+		ret = http_parse_line(priv, buf);
+		if (ret != HTTPD_REQ_OK) {
+			/* request processing error */
+			return ret;
+		}
+
+		priv->rx_processed += len;
+		buf += len;
+		size -= len;
+
+		if (priv->req_state == ST_REQ_MPFILE ||
+		    priv->req_state == ST_REQ_DONE)
+			return HTTPD_REQ_OK;
+	}
+
+	/* continue when more data becomes available */
+	return HTTPD_REQ_OK;
+}
+
+static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
+{
+	struct httpd_priv	*priv;
+	void			*ptr;
+	u32			shift, size;
+	enum httpd_req_check	ret;
+	struct http_reply	*reply;
+	struct httpd_post_data	post;
+
+	priv = tcp->priv;
+
+	switch (priv->req_state) {
+	case ST_REQ_DONE:
+		return;
+
+	case ST_REQ_MPFILE:
+		show_block_marker(rx_bytes - priv->post_fstart,
+				  priv->post_flen);
+		if (rx_bytes < priv->post_fstart + priv->post_flen) {
+			priv->rx_processed = rx_bytes;
+			return;
+		}
+		priv->req_state = ST_REQ_MPEND;
+		priv->rx_processed = priv->post_fstart + priv->post_flen;
+		fallthrough;
+
+	case ST_REQ_MPEND:
+		shift = priv->rx_processed - priv->post_fstart;
+		ptr = map_sysmem(image_load_addr + shift,
+				 rx_bytes - priv->rx_processed);
+		ret = http_parse_buf(priv, ptr,
+				     rx_bytes - priv->rx_processed);
+		unmap_sysmem(ptr);
+
+		if (ret != HTTPD_REQ_OK)
+			goto error;
+		if (priv->req_state != ST_REQ_DONE)
+			return;
+		break;
+
+	default:
+		ret = http_parse_buf(priv, priv->buf + priv->rx_processed,
+				     rx_bytes - priv->rx_processed);
+		if (ret != HTTPD_REQ_OK)
+			goto error;
+
+		if (priv->req_state == ST_REQ_MPFILE) {
+			/*
+			 * We just switched from parsing of HTTP request
+			 * headers to binary data reading. Our tcp->rx
+			 * handler may put some binary data to priv->buf.
+			 * It's time to copy these data to a proper place.
+			 * It's required to copy whole buffer data starting
+			 * from priv->rx_processed position. Otherwise we
+			 * may miss data placed after the first hole.
+			 */
+			size = sizeof(priv->buf) - priv->rx_processed;
+			if (size > 0) {
+				ptr = map_sysmem(image_load_addr, size);
+				memcpy(ptr, priv->buf + priv->rx_processed, size);
+				unmap_sysmem(ptr);
+			}
+
+			show_block_marker(rx_bytes - priv->post_fstart,
+					  priv->post_flen);
+		}
+
+		if (priv->req_state != ST_REQ_DONE)
+			return;
+		break;
+	}
+
+	switch (priv->method) {
+	case HTTP_OPTIONS:
+		reply = &options_reply;
+		break;
+
+	case HTTP_GET:
+	case HTTP_HEAD:
+		if (!cfg->get) {
+			ret = HTTPD_BAD_REQ;
+			goto error;
+		}
+		reply = cfg->get(priv, priv->url);
+		break;
+
+	case HTTP_POST:
+		if (!cfg->post) {
+			ret = HTTPD_BAD_REQ;
+			goto error;
+		}
+		post.name     = priv->post_name;
+		post.filename = priv->post_fname;
+		post.size     = priv->post_flen;
+		post.addr     = map_sysmem(image_load_addr, post.size);
+		reply = cfg->post(priv, priv->url, &post);
+		unmap_sysmem(post.addr);
+		break;
+
+	default:
+		ret = HTTPD_BAD_REQ;
+		goto error;
+	}
+
+	http_make_reply(priv, reply, priv->method == HTTP_HEAD);
+	return;
+
+error:
+	priv->req_state = ST_REQ_DONE;
+	switch (ret) {
+	case HTTPD_BAD_URL:
+		http_make_reply(priv, cfg->error_404, 0);
+		break;
+	case HTTPD_BAD_REQ:
+		http_make_reply(priv, cfg->error_400, 0);
+		break;
+	default:
+		tcp_stream_reset(tcp);
+		break;
+	}
+}
+
+static u32 tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, u32 len)
+{
+	void			*ptr;
+	struct httpd_priv	*priv;
+	u32			shift;
+
+	priv = tcp->priv;
+	switch (priv->req_state) {
+	case ST_REQ_DONE:
+		return len;
+	case ST_REQ_MPFILE:
+	case ST_REQ_MPEND:
+		shift = rx_offs - priv->post_fstart;
+		ptr = map_sysmem(image_load_addr + shift, len);
+		memcpy(ptr, buf, len);
+		unmap_sysmem(ptr);
+		return len;
+	default:
+		/*
+		 * accept data that fits to buffer,
+		 * reserve space for end of line symbol
+		 */
+		if (rx_offs + len > sizeof(priv->buf) - 1)
+			len = sizeof(priv->buf) - rx_offs - 1;
+		memcpy(priv->buf + rx_offs, buf, len);
+		return len;
+	}
+}
+
+static void tcp_stream_on_snd_una_update(struct tcp_stream *tcp, u32 tx_bytes)
+{
+	struct httpd_priv *priv;
+
+	priv = tcp->priv;
+	if ((priv->req_state == ST_REQ_DONE) &&
+	    (tx_bytes == priv->reply_fstart + priv->reply_flen))
+		tcp_stream_close(tcp);
+}
+
+static u32 tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf, u32 maxlen)
+{
+	struct httpd_priv	*priv;
+	u32			len, bytes = 0;
+	char			*ptr;
+
+	priv = tcp->priv;
+	if (priv->req_state != ST_REQ_DONE)
+		return 0;
+
+	if (tx_offs < priv->reply_fstart) {
+		len = maxlen;
+		if (len > priv->reply_fstart - tx_offs)
+			len = priv->reply_fstart - tx_offs;
+		memcpy(buf, priv->buf + tx_offs, len);
+		buf += len;
+		tx_offs += len;
+		bytes += len;
+		maxlen -= len;
+	}
+
+	if (tx_offs >= priv->reply_fstart) {
+		if (tx_offs + maxlen > priv->reply_fstart + priv->reply_flen)
+			maxlen = priv->reply_fstart + priv->reply_flen - tx_offs;
+		if (maxlen > 0) {
+			ptr = priv->reply_fdata + tx_offs - priv->reply_fstart;
+			memcpy(buf, ptr, maxlen);
+			bytes += maxlen;
+		}
+	}
+
+	return bytes;
+}
+
+static int tcp_stream_on_create(struct tcp_stream *tcp)
+{
+	struct httpd_priv	*priv;
+
+	if (!cfg || stop_server || tcp->lport != HTTP_PORT)
+		return 0;
+
+	priv = malloc(sizeof(struct httpd_priv));
+	if (!priv)
+		return 0;
+
+	memset(priv, 0, sizeof(struct httpd_priv));
+	priv->tcp = tcp;
+
+	tcp->priv = priv;
+	tcp->on_closed = tcp_stream_on_closed;
+	tcp->on_rcv_nxt_update = tcp_stream_on_rcv_nxt_update;
+	tcp->rx = tcp_stream_rx;
+	tcp->on_snd_una_update = tcp_stream_on_snd_una_update;
+	tcp->tx = tcp_stream_tx;
+
+	return 1;
+}
+
+void httpd_setup(struct httpd_config *config)
+{
+	cfg = config;
+}
+
+void httpd_stop(void)
+{
+	stop_server = 1;
+}
+
+void httpd_start(void)
+{
+	if (!cfg) {
+		net_set_state(NETLOOP_FAIL);
+		return;
+	}
+	stop_server = 0;
+	memset(net_server_ethaddr, 0, 6);
+	tcp_stream_set_on_create_handler(tcp_stream_on_create);
+	printf("HTTPD listening on port %d...\n", HTTP_PORT);
+}
diff --git a/net/net.c b/net/net.c
index 978fc1978b3..83c4c57b204 100644
--- a/net/net.c
+++ b/net/net.c
@@ -101,6 +101,7 @@
 #include <linux/compiler.h>
 #include <net/fastboot_udp.h>
 #include <net/fastboot_tcp.h>
+#include <net/httpd.h>
 #include <net/ncsi.h>
 #include <net/netcat.h>
 #if defined(CONFIG_CMD_PCAP)
@@ -580,6 +581,11 @@ restart:
 			netcat_save_start();
 			break;
 #endif
+#if defined(CONFIG_HTTPD_COMMON)
+		case HTTPD:
+			httpd_start();
+			break;
+#endif
 #if defined(CONFIG_CMD_CDP)
 		case CDP:
 			cdp_start();
-- 
2.45.2

