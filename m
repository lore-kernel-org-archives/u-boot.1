Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6388C3600B
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 15:11:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22ACE81E1F;
	Mon, 24 Mar 2025 16:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="l9Bj5eyC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 629CB81F66; Mon, 24 Mar 2025 09:40:59 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9192581EA2
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 09:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6CCyOa8/O0wbD/S2n0/akDdyQnyemuH1nURJqjJTP/fS+n8EZezvVZGfAbYWXls8/2J73mO5BbxMPTT6ikC73Z9Dxu/LyO8RBq9RSBCzAL2eZf5emWVJ/FYEPQiuX2bb+hDs6iOZP5zUwEJRYBhh4gHDVyLejmF5H8qLRL/gdZO6g3bKezpEwedVXiARf0PPl5gqrUrMVH0ejtts0L0/WQ26jR/MwTdbiOXKlvtvrdM1U+WFCrN1XHQgeclXrsQo9HC2HxFmqeODq9rsaAkfbE5sPPHEJpBzJRRHa8UPHaiwROO2Hs0mdI7MaKeQ+lGWEsR+G2UL730jszZSXPalw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlotV4IXVpoaO0mK5zuqHQEhA1FM9jJBG/UpVy7uWjU=;
 b=hbkqHrg76OrLI19QaEYafVDk6Av/M2IuLq9B6cIyMzSnGeaMFWKSw69GWIva/CqTIQ4qX8b7H+MeMQZAvbB/jdH9UX/XNlZH6b3L4iQyLwqye4kWnUPhZR/JIzcgo9aqtHJx+YFQ6ozi+bfCUPfzkR+qF+JPb4rgH8MrBW3KT7pvEiIRwcoVuR0/ridECGOfsCVM4HPGWL2gSqdOis4a4IPkwsbLftWBTywptKTxlK8l96x3LxH3IMLsokUJP8X5v6QBQ6ruhothMHc7/TjJuwtFmPUbPDJsDorLyyYxCgjlr8fbJAG1sBVBxFFVOhZLGusUu8YKfoNiCjxPh8dNrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlotV4IXVpoaO0mK5zuqHQEhA1FM9jJBG/UpVy7uWjU=;
 b=l9Bj5eyCPN3BfBrgv4E0A1uiLmZAyQuqCyF2P+/NlakhHCqtvr5PG3aw1aTWZPc0WhPxaH9lqvN9sbebHO9KJH+so2RK43eGqTvRoocUsAz27Gb/fo1Kay42fMqmcIRiy+P7nNEdhtTl+6dxyLnl15jFsxt15gb+f2glHPvPRwxBgGLO634Ae2XwPcKTRlNrUon7Ox9esIn3/2N6Dk4/9yAFlBdX2Vk5p6REjY3yShtjPCHFZABVuloQEVdnAvoGlrsOCtJ2mPzJXthMwO+7oMHkPN2+LcVez0TWD1BAlQn3Z24dugR7VwVVqo8Nhh2I0KR7Vtcd3mFluhDDLjhyZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by MW5PR03MB6958.namprd03.prod.outlook.com (2603:10b6:303:1a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:40:54 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:40:54 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v3 09/12] cmd: Add i3c command support.
Date: Mon, 24 Mar 2025 16:37:01 +0800
Message-Id: <20250324083704.26259-10-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250324083704.26259-1-dinesh.maniyam@altera.com>
References: <20250324083704.26259-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::47) To SA1PR03MB6370.namprd03.prod.outlook.com
 (2603:10b6:806:1b5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6370:EE_|MW5PR03MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 95314ea4-adc2-4a76-a759-08dd6aaf96c7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lbk/onCANLW+iTq5Z22PiJXcaNRKn6mNbPkWvFjw7/sFfYAV1fHw1OxyXStg?=
 =?us-ascii?Q?ix1zukKE83LUM4FdbdG6e72CAdldpKfc3pjN/jiN5UJXJ8MV5XTp6XNYxIkX?=
 =?us-ascii?Q?djCgxi4T1tteLKvFkfDOwoKEG5/vRIGBgbaExemdyd5R1UOCVvbLhHFkrnS3?=
 =?us-ascii?Q?NWKnslDtWRd4cUzmTGA2cNXczQxrnAJUsRt1IgKlhw6plaUNtgb/htOIDaE0?=
 =?us-ascii?Q?ruPknkduaLzWPi31VIOm2T+GOZikhy2Wzy1nNHCgu5qoy87KpFNjdpxUKSdc?=
 =?us-ascii?Q?mSiYyL+TlC7sd2mhS9yz7XcwQdLQltHIp0/4bdlG8aSDZ+vr3McFml3P0hxQ?=
 =?us-ascii?Q?DKDG1BnreT6pFa8ltndYczdfcUyh7zEA8JrcmndxGuO1Ngb92IprttTFhAG1?=
 =?us-ascii?Q?5KQDuH2CfNKSfgDOfOIeb9T0NeaIbHf/a+MDhdJOGSNOj6LdtGfkrVImIyVp?=
 =?us-ascii?Q?75K+yFU/NDBjK+LkITIMJsqfkTl2JOex4LaxbCq+QrtDI1IXS9urCtXYrvEC?=
 =?us-ascii?Q?WHODI+0mDbjPxt102q421NPKUAryaUXseSJ2K4TM+ToxP41bJd0VVFXovids?=
 =?us-ascii?Q?luiRHmZ1jLuGn8ljoycQ+BTzBtBrVALbEIBv/zciZcMgddPmko3F/FDQ4pOO?=
 =?us-ascii?Q?dsqlqamafNlWHn9fcSvC++KWTtOB8py2bx0R3MKjhsgCMS9JwW3iXsbS7iA1?=
 =?us-ascii?Q?ZSnqjLn4VFULrHAalrUoYoaKC36J8ci4F4uIcjxZP5BCTq4NspXnetVGAeOG?=
 =?us-ascii?Q?V1SoFJ+9m9LkPPPf1q88ueOJQNB1lW9D060m2NH6NK4XAXXdbhL8FeOOjf1X?=
 =?us-ascii?Q?YCiUH2sgCrOTW8lSxu+fKSK8aiNuhSdPclFMa38JtJ8+sp8UR1SwQYxyo6cn?=
 =?us-ascii?Q?dWafpZiM9neWoq59q0vsQ3Ff1dUByo3s7S2FJ22lLzBETlGg9k1R6VZp9Z+v?=
 =?us-ascii?Q?oZhwpWYq226b4FblcHAg8lh4b3fistfNgIks5fMbpY+iYdYNoErJ6CqPQ7+e?=
 =?us-ascii?Q?CTSDWCnkSldfkTLnGxGr3Mk0efa2pRGe5w9hk++vvKEkXHb6lIXrtwhBPxZW?=
 =?us-ascii?Q?yNLyxLFFN42XlJA+/w9JqiHHH/nCz3pM5fRsfKqvULhAwqGp95zOZTrMaiCR?=
 =?us-ascii?Q?wUTZ96QIW3q+Oute0/EdMfXBCIIwYu40DHN9wLfiFp9XPY+cDdXCE4+G+vNF?=
 =?us-ascii?Q?K+WHuP5sU80KXUqU+oT4UqfesJ77fglPHf7GTnwghAjzA9qYvWw7t+VDnM/b?=
 =?us-ascii?Q?vwV9qe0+1wbeZSMAWjCKWMdd8DjfOVvNtDzURfFdbL0cSLouBBLdR4cnz8x0?=
 =?us-ascii?Q?Isa8P2EduIBSzliWIL4Rug731FRwa5x8mG0IBsWnhiBW4riPFuLdMAkQ4XIL?=
 =?us-ascii?Q?M640IdE0hCaTIpFXEkBLsM1mlwty?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aVgTPRWAfnYq0EfyaHzmImk2PPGeOSgu3LO4CjDa8zm4bTEvkrirvZuHnaaF?=
 =?us-ascii?Q?OQ48/NTa0Ue271RsJ3V7JiUmuxEdJxMGs3hG+QjHvRDyAjwWgrd1/uEmMsVi?=
 =?us-ascii?Q?5zkVzwB7CWnajXcEhnzqh3AnSq10QNv8SDbAqJo187gVSZ8UiblSTgiUeAvM?=
 =?us-ascii?Q?Lww+LZCWNOOTB1nX+vsmJpACmJHx88RZaxyt3cUUX1Cns3cqaA9YQNZ2jjJL?=
 =?us-ascii?Q?azjno5J6ISu2oc+YR5/Ph/sLuRylXMSs/ZZmx46Z2Y86URJDhlk0PnTagWmn?=
 =?us-ascii?Q?G8YQ62UasHm/l4O+O61xMAdHJziBLVPQvI7VG273mq8IQ1PB8KxgXmQi67Zq?=
 =?us-ascii?Q?BzNszYR2xlc4aQwpw4WgPDqFt89jQS+iP4mcihPbCqU9XasLHZ7zjlBscxhn?=
 =?us-ascii?Q?K3ncNfsWssoI/0CxldlyEzKMSnQWVuNkDFj15rBgOyrKBfdbuZq+h20u3HRj?=
 =?us-ascii?Q?uoFas37ThzjylGMt76ByT83Li+M2LOo1ZmCei4WfVzZVqSk70kFizHiMmzDE?=
 =?us-ascii?Q?QNUAxEhfKTCyiw42QHbAjoR48UJY+iFWVUFe3s+XapSiz0C5NDkYMIf7uLK2?=
 =?us-ascii?Q?JT6oZsrxk+PNaiHa+maPj6Wv6Bq33D92pD4r0FwrvDDHNsZ2aOlGXVQt60xH?=
 =?us-ascii?Q?YP5hWsCABfYcVov6L34nb1XVSTyidy7HYtJUXrbrlzY/InDfFvgbNxbyv0Li?=
 =?us-ascii?Q?GW04CawrnH8iEFAA53OEeKajmHLwZ/OeTTATrQhAisat3coPOzVOo1xS6VCQ?=
 =?us-ascii?Q?83Ap6t17JCu6tMhDLXPzJ6OJabFXMVvLN6COot5PqALAcc2DMdYGwC0Tj5XR?=
 =?us-ascii?Q?uKtkHLF7F+sCZTORxZpe6f7PawcTZKW7ppmhkyjmEitd8dqLlpB8T3D8K8Px?=
 =?us-ascii?Q?7gDQ/qrD7Xhoc/QsvWVfZSI4gQI+YDJGUgg9nN63h93ByxxXjyTfVCSqb6Ma?=
 =?us-ascii?Q?kGUKozfPa+F2T5nKgi2HyKZNH341q2QT3p31t22iHeVpWC/P6HGZzMpUBGwO?=
 =?us-ascii?Q?vt/m5em3dsK1Ip7MKjiMeLctoAMMY+PwH1wQlNFJU1iKvYITw6wLiy7gp8y9?=
 =?us-ascii?Q?s1GkIbFenJ7PA0EX0rHFcGZrc33eHoEr8d2YpY4i9KxxBUf9r2R3mCEV+98z?=
 =?us-ascii?Q?ngcyv1mODivaAkrYavh78IMwRb3hRbxjsrwZ38EFgtu8dBXXRPCzHIwI9Hc9?=
 =?us-ascii?Q?VE4oIsBlYdOo667v6EJSSNkWnM7N9OY+1rSthwUWlzQr9lxCyKd/FSy5RJnv?=
 =?us-ascii?Q?M5k0K3qZnwsJSYp/qiuZPj2PwhhjogJwQQlCsrplBpOtGfPpISWVj94brZlh?=
 =?us-ascii?Q?5jSF5dKY0xYLjyQbPktlUDsQxdFxMAlWTl63E4hTyNcDqLOwB9lt+XbTb7wH?=
 =?us-ascii?Q?QILpncVABrS4JQQcKFknaFFhGujPeT6EuX1IKPPI67tl8BILiCNUzM9f17Ph?=
 =?us-ascii?Q?NANs6M+MECkIyi4NqeZ3MfkTBz8ld9POLt7upSPpwNJ7RHeGMd4HL/iocwXL?=
 =?us-ascii?Q?vMT/OAohPp68lgaAZZtgWHQVVXraAF6vCVwtEJUJ1YyHzyes+aa8kWpi68xw?=
 =?us-ascii?Q?99v68djDk8oO1/maQb1WrXhJWZHeqhIiPuTWrJ2VUCg1bmf48Nr9YfqQkobT?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95314ea4-adc2-4a76-a759-08dd6aaf96c7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:40:54.0963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: de4UMnEq3mSfuy/V2/bbP2DaUdSxJOxmZSYlWXzzMljOcdYS0IDjsThHoHdnAI8nlCucM3/pZokB0avktgkewrzUkqlvNt980otWr0Tc2DM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6958
X-Mailman-Approved-At: Mon, 24 Mar 2025 16:09:48 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add i3c command file to support select, get i3c device
target list, read and write operation.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 cmd/Kconfig                        |   6 +
 cmd/Makefile                       |   1 +
 cmd/i3c.c                          | 193 +++++++++++++++++++++++++++++
 doc/usage/cmd/i3c.rst              |  98 +++++++++++++++
 drivers/i3c/master/dw-i3c-master.c |  35 +++++-
 include/dw-i3c.h                   |   2 +
 include/i3c.h                      |   4 +
 7 files changed, 338 insertions(+), 1 deletion(-)
 create mode 100644 cmd/i3c.c
 create mode 100644 doc/usage/cmd/i3c.rst

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 642cc1116e8..551959731f0 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1327,6 +1327,12 @@ config CMD_I2C
 	help
 	  I2C support.
 
+config CMD_I3C
+	bool "i3c"
+	help
+	  Enable command to list i3c devices connected to the i3c controller
+	  and perform read and write on the connected i3c devices.
+
 config CMD_W1
 	depends on W1
 	default y if W1
diff --git a/cmd/Makefile b/cmd/Makefile
index 8410be576bb..082470fa104 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_CMD_GPIO) += gpio.o
 obj-$(CONFIG_CMD_HISTORY) += history.o
 obj-$(CONFIG_CMD_HVC) += smccc.o
 obj-$(CONFIG_CMD_I2C) += i2c.o
+obj-$(CONFIG_CMD_I3C) += i3c.o
 obj-$(CONFIG_CMD_IOTRACE) += iotrace.o
 obj-$(CONFIG_CMD_HASH) += hash.o
 obj-$(CONFIG_CMD_IDE) += ide.o disk.o
diff --git a/cmd/i3c.c b/cmd/i3c.c
new file mode 100644
index 00000000000..5631f487cc2
--- /dev/null
+++ b/cmd/i3c.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Intel Coporation.
+ */
+
+#include <bootretry.h>
+#include <cli.h>
+#include <command.h>
+#include <console.h>
+#include <dm.h>
+#include <dw-i3c.h>
+#include <edid.h>
+#include <errno.h>
+#include <log.h>
+#include <malloc.h>
+#include <asm/byteorder.h>
+#include <linux/compiler.h>
+#include <linux/delay.h>
+#include <u-boot/crc.h>
+#include <linux/i3c/master.h>
+
+static struct udevice *currdev;
+static struct udevice *prevdev;
+static struct dw_i3c_master *master;
+
+void low_to_high_bytes(void *data, size_t size)
+{
+	unsigned char *byte_data = (unsigned char *)data;
+	size_t start = 0;
+	size_t end = size - 1;
+
+	while (start < end) {
+		unsigned char temp = byte_data[start];
+
+		byte_data[start] = byte_data[end];
+		byte_data[end] = temp;
+		start++;
+		end--;
+	}
+}
+
+/**
+ * do_i3c() - Handle the "i3c" command-line command
+ * @cmdtp:    Command data struct pointer
+ * @flag:    Command flag
+ * @argc:    Command-line argument count
+ * @argv:    Array of command-line arguments
+ *
+ * Returns zero on success, CMD_RET_USAGE in case of misuse and negative
+ * on error.
+ */
+static int do_i3c(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	struct uclass *uc;
+	int ret;
+	struct udevice *dev_list;
+	u32 length, bytes;
+	u8 *data;
+	u8 *rdata;
+	u8 device_num;
+
+	if (argc > 1) {
+		ret = uclass_get_device_by_name(UCLASS_I3C, argv[1], &currdev);
+		if (ret) {
+			if (!strcmp(argv[1], "help"))
+				return CMD_RET_USAGE;
+
+			currdev = prevdev;
+			if (!currdev) {
+				ret = uclass_get(UCLASS_I3C, &uc);
+				if (ret)
+					return CMD_RET_FAILURE;
+
+				uclass_foreach_dev(dev_list, uc)
+					printf("%s (%s)\n", dev_list->name, dev_list->driver->name);
+
+				printf("i3c master controller is not initialized: %s\n", argv[1]);
+				return CMD_RET_FAILURE;
+			}
+		} else {
+			master = dev_get_priv(currdev);
+			printf("current dev: %s\n", currdev->name);
+			prevdev = currdev;
+		}
+	} else {
+		if (!currdev) {
+			printf("No i3c device set!\n");
+			return CMD_RET_FAILURE;
+		}
+		printf("dev: %s\n", currdev->name);
+	}
+
+	if (!strcmp(argv[1], "list")) {
+		ret = uclass_get(UCLASS_I3C, &uc);
+		if (ret)
+			return CMD_RET_FAILURE;
+
+		uclass_foreach_dev(dev_list, uc)
+		printf("%s (%s)\n", dev_list->name, dev_list->driver->name);
+	}
+
+	if (!strcmp(argv[1], "current")) {
+		if (!currdev)
+			printf("no current dev!\n");
+		else
+			printf("current dev: %s\n", currdev->name);
+	}
+
+	if ((!strcmp(argv[1], "write")) && !(argv[2] == NULL) && !(argv[3] == NULL) &&
+	    !(argv[4] == NULL)) {
+		length = hextoul(argv[3], NULL);
+
+		data = (u8 *)malloc(sizeof(u8) * length);
+		if (!data) {
+			debug("Memory allocation for data failed\n");
+			return -ENOMEM;
+		}
+
+		device_num = hextoul(argv[4], NULL);
+		bytes = hextoul(argv[2], NULL);
+
+		for (int i = 0; i < length; i++)
+			data[i] = (u8)((bytes >> (8 * i)) & 0xFF);
+
+		low_to_high_bytes(data, length);
+		ret = dm_i3c_write(currdev, device_num, data, length);
+		if (ret) {
+			ret = CMD_RET_FAILURE;
+			goto write_out;
+		}
+	}
+
+	if (!strcmp(argv[1], "read") && !(argv[2] == NULL) && !(argv[3] == NULL)) {
+		length = hextoul(argv[2], NULL);
+
+		rdata = (u8 *) malloc(sizeof(u8) * length);
+		if (!rdata) {
+			debug("Memory allocation for rdata failed\n");
+			return -ENOMEM;
+		}
+
+		device_num = hextoul(argv[3], NULL);
+
+		ret = dm_i3c_read(currdev, device_num, rdata, length);
+		if (ret) {
+			ret =  CMD_RET_FAILURE;
+		} else {
+			printf("Read buff: ");
+			for (size_t i = 0; i < length; ++i)
+				printf("%02x", rdata[i]);
+
+			printf("\n");
+		}
+
+		goto read_out;
+	}
+
+	if (!strcmp(argv[1], "device_list")) {
+		if (master) {
+			for (int i = 0; i < master->num_i3cdevs; i++) {
+				printf("device:%d\n", i);
+				printf("dynamic address:0x%X\n", master->i3cdev[i]->info.dyn_addr);
+				printf("PID:%llx\n", master->i3cdev[i]->info.pid);
+				printf("BCR:%X\n", master->i3cdev[i]->info.bcr);
+				printf("DCR:%X\n", master->i3cdev[i]->info.dcr);
+				printf("Max Read DS:%X\n", master->i3cdev[i]->info.max_read_ds);
+				printf("Max Write DS:%X\n", master->i3cdev[i]->info.max_write_ds);
+				printf("\n");
+			}
+		}
+	}
+
+	return CMD_RET_SUCCESS;
+
+read_out:
+	free(rdata);
+	return ret;
+
+write_out:
+	free(data);
+	return ret;
+}
+
+U_BOOT_CMD(
+	i3c,    5,    1,     do_i3c,
+	"access the system i3c\n",
+	"i3c write<data><length><device_number> - write to device.\n"
+	"i3c read<length><device_number> - read from device.\n"
+	"i3c device_list   - List valid target devices\n"
+	"i3c <i3c name>   - Select i3c controller.\n"
+	"i3c list   - List all the available i3c controller.\n"
+	"i3c current   - print current i3c controller.\n"
+);
diff --git a/doc/usage/cmd/i3c.rst b/doc/usage/cmd/i3c.rst
new file mode 100644
index 00000000000..cd5ce3b5800
--- /dev/null
+++ b/doc/usage/cmd/i3c.rst
@@ -0,0 +1,98 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. index::
+   single: i3c (command)
+
+i3c command
+===========
+
+Synopsis
+--------
+
+::
+
+    i3c <i3c name>
+    i3c current
+    i3c list
+    i3c device_list
+    i3c write <data> <length> <device_number>
+    i3c read <length> <device_number>
+
+
+Description
+-----------
+
+The ``i3c`` command is used to probe i3c master controller and perform read
+and write on the i3c devices.
+
+i3c current
+----------
+
+* Display the current probed i3c controller.
+
+i3c list
+----------
+
+List all the i3c controllers defined in the DT.
+
+i3c device_list
+----------
+
+List all the i3c devices' device number, dynamic address, PID, BCR, DCR,
+Max Write Speed and Max Read Speed of the probed i3c controller.
+
+i3c write
+-----------
+
+Perform write to the i3c device.
+
+i3c read
+-----------
+
+Perform read from the i3c device.
+
+i3c name
+    i3c name defined in DT
+
+length
+    Size of the data.
+
+device_number
+    device number that connected to i3c controller.
+
+data
+    Bytes to be written to device.
+
+Examples
+--------
+
+Probe i3c0::
+
+    => i3c i3c0
+
+Check cuurent i3c controller::
+
+    => i3c current
+
+Check the device number and PID of the connected devices::
+
+    => i3c device_list
+
+Perform write AA byte to a device 0::
+
+    => i3c write AA 1 0
+
+Perform read from a device 0::
+
+    => i3c read 1 0
+
+Configuration
+-------------
+
+The ``i3c`` command is only available if CONFIG_CMD_I3C=y.
+
+Return value
+------------
+
+If the command succeeds, the return value ``$?`` is set to 0. If an error occurs, the
+return value ``$?`` is set to 1.
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index af6e472f232..98bf8947010 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -670,8 +670,11 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 	newdevs &= ~olddevs;
 
 	for (pos = 0; pos < master->maxdevs; pos++) {
-		if (newdevs & BIT(pos))
+		if (newdevs & BIT(pos)) {
 			i3c_master_add_i3c_dev_locked(m, master->addrs[pos]);
+			master->i3cdev[pos] = m->this;
+			master->num_i3cdevs++;
+		}
 	}
 
 	dw_i3c_master_free_xfer(xfer);
@@ -1006,8 +1009,38 @@ err_assert_rst:
 	return ret;
 }
 
+static int dw_i3c_master_priv_read(struct udevice *dev, u8 dev_number,
+				   u8 *buf, int buf_size)
+{
+	struct dw_i3c_master *master = dev_get_priv(dev);
+	struct i3c_dev_desc *i3cdev = master->i3cdev[dev_number];
+	struct i3c_priv_xfer i3c_xfers;
+
+	i3c_xfers.data.in = buf;
+	i3c_xfers.len = buf_size;
+	i3c_xfers.rnw = I3C_MSG_READ;
+
+	return dw_i3c_master_priv_xfers(i3cdev, &i3c_xfers, 1);
+}
+
+static int dw_i3c_master_priv_write(struct udevice *dev, u8 dev_number,
+				    u8 *buf, int buf_size)
+{
+	struct dw_i3c_master *master = dev_get_priv(dev);
+	struct i3c_dev_desc *i3cdev = master->i3cdev[dev_number];
+	struct i3c_priv_xfer i3c_xfers;
+
+	i3c_xfers.data.out = buf;
+	i3c_xfers.len = buf_size;
+	i3c_xfers.rnw = I3C_MSG_WRITE;
+
+	return dw_i3c_master_priv_xfers(i3cdev, &i3c_xfers, 1);
+}
+
 static const struct dm_i3c_ops dw_i3c_ops = {
 	.i3c_xfers = dw_i3c_master_priv_xfers,
+	.read = dw_i3c_master_priv_read,
+	.write = dw_i3c_master_priv_write,
 };
 
 static const struct udevice_id dw_i3c_ids[] = {
diff --git a/include/dw-i3c.h b/include/dw-i3c.h
index 42c37d6dfa2..c652de77404 100644
--- a/include/dw-i3c.h
+++ b/include/dw-i3c.h
@@ -241,6 +241,8 @@ struct dw_i3c_master {
 	char type[5];
 	u8 addrs[MAX_DEVS];
 	bool first_broadcast;
+	struct i3c_dev_desc *i3cdev[I3C_BUS_MAX_DEVS];
+	u16 num_i3cdevs;
 };
 
 struct dw_i3c_i2c_dev_data {
diff --git a/include/i3c.h b/include/i3c.h
index 6ef4982dcf6..969753ae49d 100644
--- a/include/i3c.h
+++ b/include/i3c.h
@@ -28,6 +28,10 @@ struct dm_i3c_ops {
 	int (*i3c_xfers)(struct i3c_dev_desc *dev,
 			 struct i3c_priv_xfer *i3c_xfers,
 			 int i3c_nxfers);
+	int (*read)(struct udevice *dev, u8 dev_number,
+		    u8 *buf, int num_bytes);
+	int (*write)(struct udevice *dev, u8 dev_number,
+		     u8 *buf, int num_bytes);
 };
 
 #define i3c_get_ops(dev)	((struct dm_i3c_ops *)(dev)->driver->ops)
-- 
2.26.2

