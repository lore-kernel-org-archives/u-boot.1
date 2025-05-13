Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B2BC3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 12:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEE0B82B26;
	Tue, 13 May 2025 14:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="nD1MpHB/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B8808129F; Tue, 13 May 2025 12:21:08 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55A278091A
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 12:21:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNg74HKJHtuZG+QOA/6mfNzcWpv6RDcIVZu4VhyMwmm4s7hir3wMZiKpHoen4Thwz/sYjxpbAkpMSDqPCHQiDLlrjVkQf+iDm7Hd6y2HvCdjVboOSS57OeQkeyUwssLRbWxpATpzw5a48Wit60GgMPpNKI7gSj1tzFrDyJJbbHTV7827VpsIytyhUY8dZPFjVa7hJiD/QCPx4QeTC546eNdtU4gMBJrjKSzhRupSPCALRjhK2HF73HuJvmr0yDOqEAaesipXoZltpUijeQTmpYSxb1lK0ji2BBJjKfg++oyeB1RK9OU8ReI8eU53XPx+Myu9hU2dij0dBFG4lIO7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phMn3CVeZIMuikqZ8k27fCXvnvIZccopCrsY6RBATwI=;
 b=DQTUWYxZ1cRQ05W9vLF3PGZ8RMT/qDORJuoa6KiKjmBIFrWH49TfKSiCZRe/9ILeq+chZECctRpzpVabSRW0+SBNDP2dawFiMZNLwgQbPrNUjEkprohv0BMTfZJNCt1rc5LjnaArPobRVvMc4tjPyAExsymuucIe7u+MVBCDoUee+SVXLHEG0eNNs2kzXhiNv7DutBpl7gUd2sxiHqKZ5zUgQsK7ksV+QTgLF2ZwY5+7NydQrn+XfiMQZ6MH4w8pU3Z5nnOg/pf0t0xtD6CIlFcVX5D2XMxpPZDe6Q8yXXV7dXbRN1+zCtikEPAir4pdtD5DVX7I3R6BAQX7ISsYMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phMn3CVeZIMuikqZ8k27fCXvnvIZccopCrsY6RBATwI=;
 b=nD1MpHB/9UHsQXx57NoaTcpKcmEDF8c3hNEupQyeSclO9Lb/WL0HhsMj2AQEvVPBUoky8D7MGC8TU2fyBQEE24sKn1ItsxABJL2sw32IO4InzbhgD3ZR7gm3t1s8o0MwpveKZh4391hOBGcnRqhDoBFtF3GPrPfZKYltKc259FGbYb/TIsQp4ilch6G8LXL9dl+ugqctTIV+Op+UW0p+uM9Z1zHZrJo8rOIPVZIouRrg0ttPzQHSfkIcyEuq0aLODupgiEEKmig+3jmE0O4tGwSmV02uudsgTJyHkmZavdObRcZRYgUW9YfbzcWWyhOGTgih7bVJx+v+IJ2y6HHYHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB3410.namprd03.prod.outlook.com (2603:10b6:406:bd::11)
 by BN8PR03MB4979.namprd03.prod.outlook.com (2603:10b6:408:db::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 10:21:01 +0000
Received: from BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c]) by BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c%5]) with mapi id 15.20.8722.020; Tue, 13 May 2025
 10:21:01 +0000
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
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v5 09/12] cmd: Add i3c command support.
Date: Tue, 13 May 2025 18:19:10 +0800
Message-Id: <20250513101913.30880-10-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250513101913.30880-1-dinesh.maniyam@altera.com>
References: <20250513101913.30880-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To BN7PR03MB3410.namprd03.prod.outlook.com
 (2603:10b6:406:bd::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB3410:EE_|BN8PR03MB4979:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da19201-bfa3-4c9e-6cab-08dd9207dc1e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?apsAJjU1HwQ3/JHYgzSTMEZL8fV5HNjkvXeukvSSjkupGI5L0oLSNKT3Ykkd?=
 =?us-ascii?Q?qTLFGsGHCyFU+6/sAmhF7YD4EFN92f/TBVlTEIy4taCAMOC2pbYVZsxF3VmO?=
 =?us-ascii?Q?vn0E08gkAnNNotk32QLbFb8lYbwl88gy/Gpzjvef0jxHY6+ABrqfkaZIDJcW?=
 =?us-ascii?Q?5rKU0z1Uk3M2I8HnIT4ykhP0U8GAGvEoRYqIgT3BsxX+fVaDoIaL6Ni+Ja4B?=
 =?us-ascii?Q?120iZeYJCRJLoDy0FRdonW00vKXUH2Dfoa7w24mJ1jPj5lOkIPf+yG54np/c?=
 =?us-ascii?Q?hK3ld056mDjvuuMjtPO1DUNoro3rYzj8/YaqmPNc1ZbOGPFKZVUKE8DoHGnT?=
 =?us-ascii?Q?ttsL0vx1bFwDl79OiQkRa6LT0RVBqjojGuJC/zy/f4E1EKWMaJUgTEBb8Lv7?=
 =?us-ascii?Q?F46Oq4LGHeFidjTCg2O3Jm3uLJsVjgWhVQFmfIssAduiN5Vf63CNfRxZVmdh?=
 =?us-ascii?Q?JXOQYroSUUFWjoWmTVgf+4eSCa6cJs+76irPwrfL6KNQOfptJ7WdIqMRRddz?=
 =?us-ascii?Q?7/WRQO6t2JjG845Q0J6X8fdvySZ6XioOic13NX8h2aAzwROBToebA0Jv6RCt?=
 =?us-ascii?Q?2bDsScU1MyiGo31nSh/idgWzAoD5tixyEJ1njSbpQaCIZwib/XNTm2FFY6d5?=
 =?us-ascii?Q?To/T4/t3BKSfblaibFylJUTAWs7BUFKhJjWNz7E1iWJ2PYCf+F9Dyhqihxfg?=
 =?us-ascii?Q?yF7umKcEF1HDuC3tRzPOpocTtHg82cKXkzbkOvJACT5UyOWZrYoqGiB560sm?=
 =?us-ascii?Q?PrSz3PfKvr8sOBcsqdnB1xOPAca4eo2yT6f6/2y4RL+vpA6hhsDC/VBq7GvH?=
 =?us-ascii?Q?jZ5x7COuPxosHNjRlSp5gHr50tFUH3hdrzHTQBlpnkbmwd2TLVhccuBgYTuN?=
 =?us-ascii?Q?fxGyOhgqDad/nt9voW77iPy7lmlI4s3mVxFEApnqieO8JluaHXZW5x1Q9dvs?=
 =?us-ascii?Q?TLsUVZSLhWarfPR44mzQm7hpPRwDqm2xMFtmZkd+xYO1WdpYT3oWAXCFToMM?=
 =?us-ascii?Q?y4haUjEyv0LliIcQU3UWC5F8U0riQMIvZC2bQSKYEG6/vt6i2PWYdisJAQBO?=
 =?us-ascii?Q?Jx7o6wzs5o/9PRIc97+dAxISvbVOfkV0QkA1rHgOtV0BZibnU4d5d1rftdMi?=
 =?us-ascii?Q?ca/Wd+R9gV43bQbboEcEBs43OkRDvevTQ8/f4TA20en94VL8CLgcZGEpFr+h?=
 =?us-ascii?Q?6hj39jfTwBjGFLZif8Dp0WSPnAcN+LSt+G/1YDCt/ffDpX4w5a6Ue0oFURs2?=
 =?us-ascii?Q?e+CxorWFWnVkLfWfKLKLFm5wUR336NQv9EsabGy3LREPaZQ3oZC6jyrCQj+K?=
 =?us-ascii?Q?i8S48T7Y6megtwIrOryEj2GhpvQ+Bm2gJzdgU7PLdxv7nfSiHhU6arA5kySL?=
 =?us-ascii?Q?6c6UCPM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB3410.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5iR/qJPhUlfRRMxKfuWBOeIYuvcqLG+JMhTGrJqSWtM8mjXJBTJ9lWlgYlD8?=
 =?us-ascii?Q?/3BJyfng0ew5w9ol2LfaCq+GCmlgoPBe0LhFRsJ/OKBRfHle1hw9R1s1skul?=
 =?us-ascii?Q?7AAYdvQV1kCtNgdqaXStVbh3La0DqF568X2BL8M89IS4GJ1wVswMm3D9ygUD?=
 =?us-ascii?Q?whtgX0lorbD4EaIXGAc6o3QgM94vPPVvu37EO6KLApSMvz7va+V/qbZZsLqb?=
 =?us-ascii?Q?R/wpEDD6SAw5A1Xhvbh8jtqUyVPqYfTKXmGHuD7xNCYf3A1RUSQehAEIqr3S?=
 =?us-ascii?Q?ppkVPbAHQX6xSLn4PPQNJjKFcpZsIZn6JYyYDSJUT1QQELXQKKJs8CeQeyxy?=
 =?us-ascii?Q?6xMnhrudRmVQk6t5DuJwAOiZD8kKU6kTNqhbnLxVl0H7Jkq6feDUvLtESIqt?=
 =?us-ascii?Q?1Y5ky0Hukx2uTlgw6e3dGTQbXUHLet8t0y6EGjbb4w55W1Z4BRZMIinMBtva?=
 =?us-ascii?Q?mCx7fuYGnmCgMOHv5tEuBlhP7abpkQSw5NzETYcz4BNsGmSZy6XsQo4bhle0?=
 =?us-ascii?Q?68xL2CfduPu2AWERER5qTVq88boXdZZCsVAmBIKYZS8ucoxv1SKHGEZDbgJg?=
 =?us-ascii?Q?zdfsRA01xZrnqiIcXfUrVgK+gXXtF5zdw6AxVEWP/M312w5TfmSrPZaDW6RX?=
 =?us-ascii?Q?dbFM+CJouk6joEe/xQ1H2xUBtc5xgZziHNZKFH/Fxs5c5rQJn0t8zo8rCIcb?=
 =?us-ascii?Q?D0jPJkLFwErxbM1+x9T4uqnt7smc24exPJDf6S8EU0l0w7UODC1Wf5lP3bEK?=
 =?us-ascii?Q?SGA3tdRBEFRP1iH73RkVjIeL0ndSB2N8+MZsgaWMSaiz0DT3YGK27hxWc0Wt?=
 =?us-ascii?Q?JTX5r5Dpw/KUh54aF3/Z7xQXsXd6XAr5txbU/ZFNb6Sf3A7PqqZlzaWG6vuK?=
 =?us-ascii?Q?OsTXbqL8HzhxPvyniSNHzwsVKUV3lOiXitLdGiKrOCbjegYlq8q4mVOGk4r6?=
 =?us-ascii?Q?4+SsLcauy3xuNbOSp0/c8zAK2ubbGrWpt5g2W21shyghSZF3xgv/D9kkhSKP?=
 =?us-ascii?Q?XY4RHHQCb94AwVDo7Mn7cY7j+99t0ofgQ02jTeCT6+a6US629VoMOj3iY6Fq?=
 =?us-ascii?Q?2RpVHAcccsAK08l3CrC9tOnDD7izblFWk8wfFfhP2/6qUmBsL4WwMCgDoGnG?=
 =?us-ascii?Q?OiDthdB4ZL/DX9APiy7p9YKaIgkAPQaN3ewhAhsbrOGw3u12dPsaE6lnE0lT?=
 =?us-ascii?Q?zG48Lz+KYjhSmGdtAGirHpIdH/mYnkPLniWkGxN5shlscC5et9VI+LrT8dV4?=
 =?us-ascii?Q?YVB1gkXbNMISZnJNfz0GJhdPVUgF7E+3Sg8WvoLDKucWZm7BkYwZT0vCInI1?=
 =?us-ascii?Q?zxAzxwGnwOCUd5ogGecB+UJ8zd1j4yJGR5d2jy+KGB3LV8ZhqAqcOaASnQTn?=
 =?us-ascii?Q?LgbenAfNfnMqeLsZ3aKqcseLf7hi+V6QNgo+1HC7PZzN5coK5msLS00WQjYJ?=
 =?us-ascii?Q?2z986U4wYo2oKbJFCAK9M8s2IIYYV5nEFhMUldNvVErFTWBBicePIbD+EUVZ?=
 =?us-ascii?Q?6Q+Kp5sczV7glYgF42TTYpfEBBvVEgBmYyKbqpO8F7Zjkbc8QwB+TaClcCZp?=
 =?us-ascii?Q?jmDEJSxt0TLJ6znRdmlVKMak6jPId6XkSa6QsbZeVjYNDkIVw/f3PrCLy4lc?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da19201-bfa3-4c9e-6cab-08dd9207dc1e
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB3410.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 10:21:01.5115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2fQExuGFVkgvdBRzkwS0dxMl2gwW1Z9+eeHtkRCucSrQ2//vNTNApt0/KAEejCojYbRWrzNLZrQETM8ZIYvt9svJ1HD8ARDGzAKLvtIBwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4979
X-Mailman-Approved-At: Tue, 13 May 2025 14:28:49 +0200
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
 cmd/i3c.c                          | 261 +++++++++++++++++++++++++++++
 doc/usage/cmd/i3c.rst              | 146 ++++++++++++++++
 doc/usage/index.rst                |   1 +
 drivers/i3c/master/dw-i3c-master.c |  35 +++-
 include/dw-i3c.h                   |   2 +
 include/i3c.h                      |  28 +++-
 8 files changed, 478 insertions(+), 2 deletions(-)
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
index 00000000000..7d2bde714cd
--- /dev/null
+++ b/cmd/i3c.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
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
+#include <hexdump.h>
+#include <log.h>
+#include <malloc.h>
+#include <asm/byteorder.h>
+#include <linux/compiler.h>
+#include <linux/delay.h>
+#include <u-boot/crc.h>
+#include <linux/i3c/master.h>
+#include <linux/printk.h>
+#include <linux/types.h>
+
+static struct udevice *currdev;
+static struct udevice *prevdev;
+static struct dw_i3c_master *master;
+
+static void low_to_high_bytes(void *data, size_t size)
+{
+	u8 *byte_data = data;
+	size_t start = 0;
+	size_t end = size - 1;
+
+	while (start < end) {
+		u8 temp = byte_data[start];
+
+		byte_data[start] = byte_data[end];
+		byte_data[end] = temp;
+		start++;
+		end--;
+	}
+}
+
+static int handle_i3c_select(const char *name)
+{
+	struct uclass *uc;
+	struct udevice *dev_list;
+	int ret = uclass_get_device_by_name(UCLASS_I3C, name, &currdev);
+
+	if (ret) {
+		currdev = prevdev;
+		if (!currdev) {
+			ret = uclass_get(UCLASS_I3C, &uc);
+			if (ret)
+				return CMD_RET_FAILURE;
+
+			uclass_foreach_dev(dev_list, uc)
+				printf("%s (%s)\n", dev_list->name, dev_list->driver->name);
+
+			printf("i3c: Host controller not initialized: %s\n", name);
+			return CMD_RET_FAILURE;
+		}
+	} else {
+		master = dev_get_priv(currdev);
+		printf("i3c: Current controller: %s\n", currdev->name);
+		prevdev = currdev;
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+static int handle_i3c_list(void)
+{
+	struct uclass *uc;
+	struct udevice *dev_list;
+	int ret = uclass_get(UCLASS_I3C, &uc);
+
+	if (ret)
+		return CMD_RET_FAILURE;
+
+	uclass_foreach_dev(dev_list, uc)
+		printf("%s (%s)\n", dev_list->name, dev_list->driver->name);
+
+	return CMD_RET_SUCCESS;
+}
+
+static int handle_i3c_current(void)
+{
+	if (!currdev)
+		printf("i3c: No current controller selected\n");
+	else
+		printf("i3c: Current controller: %s\n", currdev->name);
+
+	return CMD_RET_SUCCESS;
+}
+
+static int handle_i3c_device_list(void)
+{
+	if (!master) {
+		printf("i3c: No controller active\n");
+		return CMD_RET_FAILURE;
+	}
+
+	for (int i = 0; i < master->num_i3cdevs; i++) {
+		struct i3c_device_info *info = &master->i3cdev[i]->info;
+
+		printf("Device %d:\n", i);
+		printf("  Static Address  : 0x%02X\n", info->static_addr);
+		printf("  Dynamic Address : 0x%X\n", info->dyn_addr);
+		printf("  PID             : %016llx\n", info->pid);
+		printf("  BCR             : 0x%X\n", info->bcr);
+		printf("  DCR             : 0x%X\n", info->dcr);
+		printf("  Max Read DS     : 0x%X\n", info->max_read_ds);
+		printf("  Max Write DS    : 0x%X\n", info->max_write_ds);
+		printf("\n");
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+static int handle_i3c_write(int argc, char *const argv[])
+{
+	if (argc < 5)
+		return CMD_RET_USAGE;
+
+	if (!currdev) {
+		printf("i3c: No I3C controller selected\n");
+		return CMD_RET_FAILURE;
+	}
+
+	u32 mem_addr = hextoul(argv[2], NULL);
+	u32 num_bytes = hextoul(argv[3], NULL);
+	u32 dev_num_val = hextoul(argv[4], NULL);
+
+	if (num_bytes == 0 || num_bytes > 4) {
+		printf("i3c: Length must be between 1 and 4\n");
+		return CMD_RET_USAGE;
+	}
+
+	if (dev_num_val > 0xFF) {
+		printf("i3c: Device number 0x%x exceeds valid u8 range\n", dev_num_val);
+		return CMD_RET_USAGE;
+	}
+
+	u8 device_num = dev_num_val;
+	u8 *data = malloc(num_bytes);
+
+	if (!data) {
+		printf("i3c: Memory allocation failed\n");
+		return -ENOMEM;
+	}
+
+	memcpy(data, (void *)(uintptr_t)mem_addr, num_bytes);
+	low_to_high_bytes(data, num_bytes);
+
+	int ret = dm_i3c_write(currdev, device_num, data, num_bytes);
+
+	if (ret)
+		printf("i3c: Write failed: %d\n", ret);
+
+	free(data);
+	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
+}
+
+static int handle_i3c_read(int argc, char *const argv[])
+{
+	if (argc < 5)
+		return CMD_RET_USAGE;
+
+	if (!currdev) {
+		printf("i3c: No I3C controller selected\n");
+		return CMD_RET_FAILURE;
+	}
+
+	u32 mem_addr = hextoul(argv[2], NULL);
+	u32 read_len = hextoul(argv[3], NULL);
+	u32 dev_num_val = hextoul(argv[4], NULL);
+
+	if (read_len == 0) {
+		printf("i3c: Read length must be greater than 0\n");
+		return CMD_RET_USAGE;
+	}
+
+	if (dev_num_val > 0xFF) {
+		printf("i3c: Device number 0x%x exceeds valid u8 range\n", dev_num_val);
+		return CMD_RET_USAGE;
+	}
+
+	u8 device_num = dev_num_val;
+	u8 *rdata = malloc(read_len);
+
+	if (!rdata) {
+		printf("i3c: Memory allocation failed\n");
+		return -ENOMEM;
+	}
+
+	int ret = dm_i3c_read(currdev, device_num, rdata, read_len);
+
+	if (ret) {
+		printf("i3c: Read failed: %d\n", ret);
+		free(rdata);
+		return CMD_RET_FAILURE;
+	}
+
+	memcpy((void *)(uintptr_t)mem_addr, rdata, read_len);
+	print_hex_dump("i3c read: ", DUMP_PREFIX_OFFSET, 16, 1,
+		       (void *)(uintptr_t)mem_addr, read_len, false);
+
+	free(rdata);
+	return CMD_RET_SUCCESS;
+}
+
+static bool is_i3c_subcommand(const char *cmd)
+{
+	return !strcmp(cmd, "write") ||
+	       !strcmp(cmd, "read") ||
+	       !strcmp(cmd, "device_list") ||
+	       !strcmp(cmd, "list") ||
+	       !strcmp(cmd, "current");
+}
+
+static int do_i3c(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	const char *subcmd = argv[1];
+
+	if (!is_i3c_subcommand(subcmd))
+		return handle_i3c_select(subcmd);
+
+	if (!currdev) {
+		printf("i3c: No I3C controller selected\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (!strcmp(subcmd, "list"))
+		return handle_i3c_list();
+	else if (!strcmp(subcmd, "current"))
+		return handle_i3c_current();
+	else if (!strcmp(subcmd, "device_list"))
+		return handle_i3c_device_list();
+	else if (!strcmp(subcmd, "write"))
+		return handle_i3c_write(argc, argv);
+	else if (!strcmp(subcmd, "read"))
+		return handle_i3c_read(argc, argv);
+
+	return CMD_RET_USAGE;
+}
+
+U_BOOT_CMD(
+	i3c, 5, 1, do_i3c,
+	"access the system i3c",
+	"i3c write <mem_addr> <length> <device_number> - write from memory to device\n"
+	"i3c read <mem_addr> <length> <device_number> - read from device to memory\n"
+	"i3c device_list - List valid target devices\n"
+	"i3c <host_controller> - Select i3c controller\n"
+	"i3c list - List all available i3c controllers\n"
+	"i3c current - Show current i3c controller"
+);
diff --git a/doc/usage/cmd/i3c.rst b/doc/usage/cmd/i3c.rst
new file mode 100644
index 00000000000..922fa3ea37c
--- /dev/null
+++ b/doc/usage/cmd/i3c.rst
@@ -0,0 +1,146 @@
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
+    i3c <host_controller>
+    i3c current
+    i3c list
+    i3c device_list
+    i3c write <mem_addr> <length> <device_number>
+    i3c read <mem_addr> <length> <device_number>
+
+Description
+-----------
+
+The ``i3c`` command is used to probe the i3c host controller and perform
+read and write operations on the connected i3c devices.
+
+i3c current
+------------
+
+Display the currently selected i3c host controller.
+
+i3c list
+---------
+
+List all the i3c hosts defined in the device-tree.
+
+i3c device_list
+----------------
+
+List all the i3c devices' device number, static address, dynamic address,
+PID, BCR, DCR, Max Write Speed, and Max Read Speed of the probed i3c host
+controller.
+
+i3c write
+----------
+
+Perform a write operation from memory to the connected i3c device. The data
+is read from a specified memory address and written to the selected i3c
+device, which is identified by its device number.
+
+You need to provide the memory address (``mem_addr``), the length of data
+to be written (``length``), and the device number (``device_number``). The
+data in memory will be transferred to the device in the specified order.
+
+i3c read
+---------
+
+Perform a read operation from the connected i3c device to memory. The data
+is read from the selected i3c device and stored at the specified memory
+address. You need to provide the memory address (``mem_addr``), the length
+of data to be read (``length``), and the device number (``device_number``).
+
+The device will send the requested data, which is then written to the memory
+location you specified. This operation allows you to retrieve information
+from the device and use it in your application. The data is read in the
+order specified and can be multiple bytes.
+
+host_controller
+    The name of the i3c host controller defined in the device-tree.
+
+length
+    The size of the data to be read or written.
+
+device_number
+    The device number in the driver model of the device connected to the i3c
+    host controller.
+
+mem_addr
+    The start address in memory from which to read or write the data.
+
+Examples
+--------
+
+Probe the ``i3c0`` controller::
+
+    => i3c i3c0
+
+Display the current i3c host controller::
+
+    => i3c current
+
+Check the device number and PID of the connected devices::
+
+    => i3c device_list
+
+Perform write operations on the connected i3c device (device 0) from memory::
+
+    => i3c write 0x1000 4 0
+
+    This command reads 4 bytes of data from memory starting at address
+    ``0x1000`` and writes them to device 0, which is identified by its device
+    number in the driver model. Example data from memory could look like this:
+
+    ```
+    Data at 0x1000: 0xAA 0xBB 0xCC 0xDD
+    ```
+
+    The bytes `0xAA`, `0xBB`, `0xCC`, and `0xDD` will be written to device 0.
+
+Perform a read operation from device 0 to memory (multiple bytes)::
+
+    => i3c read 0x1000 4 0
+
+    This command reads 4 bytes of data from device 0 and writes them to
+    memory starting at address ``0x1000``.
+
+    Example output after reading 4 bytes from device 0:
+
+    ```
+    i3c Read:
+    00000000  AA BB CC DD
+    ```
+
+    The bytes `0xAA`, `0xBB`, `0xCC`, and `0xDD` are read from device 0
+    and written to memory at address `0x1000`.
+
+Configuration
+-------------
+
+The ``i3c`` command is only available if CONFIG_CMD_I3C=y.
+
+Return value
+------------
+
+If the command succeeds, the return value ``$?`` is set to 0. If an error
+occurs, the return value ``$?`` is set to 1.
+
+Note
+----
+
+When specifying the data to be written to the i3c device (for example, with
+the ``i3c write`` command), the data can be provided in either uppercase
+or lowercase hexadecimal format. Both are valid and will be processed
+correctly. Similarly, when reading data with ``i3c read``, the data will be
+retrieved in the specified length and can include multiple bytes, all
+formatted in the same way.
\ No newline at end of file
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index bf2335dc8f0..718b606b162 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -80,6 +80,7 @@ Shell commands
    cmd/if
    cmd/itest
    cmd/imxtract
+   cmd/i3c
    cmd/load
    cmd/loadb
    cmd/loadm
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 6d3d2ab5e71..d96eb9b134e 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -674,8 +674,11 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
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
@@ -1010,8 +1013,38 @@ err_assert_rst:
 	return ret;
 }
 
+static int dw_i3c_master_priv_read(struct udevice *dev, u32 dev_number,
+				   u8 *buf, u32 buf_size)
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
+static int dw_i3c_master_priv_write(struct udevice *dev, u32 dev_number,
+				    u8 *buf, u32 buf_size)
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
index 59c787c21db..62d049232a7 100644
--- a/include/i3c.h
+++ b/include/i3c.h
@@ -25,6 +25,32 @@ struct dm_i3c_ops {
 	int (*i3c_xfers)(struct i3c_dev_desc *dev,
 			 struct i3c_priv_xfer *xfers,
 			 u32 nxfers);
+
+/**
+ * @i3c_xfers: Perform I3C read transaction.
+ *
+ * @dev: Chip to read from
+ * @dev_number: The target device number from the driver model.
+ * @buf: Place to put data
+ * @num_bytes: Number of bytes to read.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+	int (*read)(struct udevice *dev, u32 dev_number,
+		    u8 *buf, u32 num_bytes);
+
+/**
+ * @i3c_xfers: Perform I3C write transaction.
+ *
+ * @dev: Chip to write to
+ * @dev_number: The target device number from the driver model.
+ * @buf: Buffer containing data to write
+ * @num_bytes: Number of bytes to write.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+	int (*write)(struct udevice *dev, u32 dev_number,
+		     u8 *buf, u32 num_bytes);
 };
 
 /**
@@ -64,4 +90,4 @@ int dm_i3c_write(struct udevice *dev, u32 dev_number,
  * Return: 0 on success, negative error code on failure.
  */
 int dm_i3c_read(struct udevice *dev, u32 dev_number,
-		u8 *buf, u32 num_bytes);
\ No newline at end of file
+		u8 *buf, u32 num_bytes);
-- 
2.26.2

