Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CCFC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 15:10:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 274E281DCC;
	Mon, 24 Mar 2025 16:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="hYpTkpo7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82040801CF; Mon, 24 Mar 2025 09:40:38 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170110000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c102::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 469AC81F28
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 09:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTgvVm7CsDh72w5AoIInx0/rQfVEXWmu1SY2+EDFM8WkADYDWnyGFwJQqqela/8RnC+NrV01NkuIX4zAvyn6gs53B71pyk7mrmMXGIAr6zuV13H2U1pXM3biAlJ9TvwPnyWg7XNslDTLH1uSTfpU6nI28im6TjyrheG8YalzSgD7gnUdtcECGQsK2nZI0L2IMmGutGQqSLiZS8GsoJaTY+z+EQnXmugixHwOdkJU+9nXQbidhdOe/3nJs0yskJV81gWp/5Kh20H+w1JRq7VUP7cz76P1fVj1cRPZF/w0V/WlQkcXKBgVJkV4EPI3w4h9LaE0P5x9VO3Um2KdMj1xLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5b4gtvb74OItO2hZ9PRr/BtSFPh9ah1sklZ8I8EWZc=;
 b=ln7qStxl2GsvL8LxCbk3LhS4unXymTnudh2wgSyl//+WTQOtRUG9vW22yI69NxlX+Dv0rd2ETf4ivxGosCih2wg13b1jxvcRkY+ZqyQgqlmLnssd4xZTb8Q6rha4j7OvZjjKWajAseHQ0gXc4beB1fExkl8LXdPpBPVImD+CdIV0lMEccOEfl2NIQWwGgfrLmgE4fhyoonrZmozPkApXcfZE/H2bCgL6yv4JVPPxcx3znq3pLy9/SA5nx3fQPcRRsP92/yJ1Qx8AU3U6Pgo0HL3RJSkP83JGp3rxVwxeueOusL7lXjgMjBFKL4nM4yDXrS/bgpjEGJ8AOvT3UyzKDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5b4gtvb74OItO2hZ9PRr/BtSFPh9ah1sklZ8I8EWZc=;
 b=hYpTkpo7PY5X/y9l9Q54pZNxQT/BZikOH3CR0tSWt43+2V+d6MVRddKlhWt9OyEOyVON1tO7lLlTLUnZHEaFZ14FgliHKPZ4oUDaQTtCPGoqOSsV1OEfo/gTQ4d76130VOms0/eudEudyMPxgQsxTKd9G8heIrgxwpE0vR2egqQ0RMWdbxX0QUkd1qFc+17iV0QlDAuMdxTM7fFZSvYBa8p9ioHHhvXD3iRznlNJbIpQGypj0OXgL0tGYd1G99RYlfVVcFOfyTSYt3DvLTfgn/hVGrHHJIoYQDHmNXYuq9Vzf/Xjyf5/2xoFSHm36fZD5bMo432CO/eNEj5N044uSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by MW5PR03MB6958.namprd03.prod.outlook.com (2603:10b6:303:1a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:40:34 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:40:34 +0000
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
Subject: [resend v3 06/12] drivers: i3c: Add i3c sandbox simple test.
Date: Mon, 24 Mar 2025 16:36:58 +0800
Message-Id: <20250324083704.26259-7-dinesh.maniyam@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: cca0c735-fd3b-4557-b151-08dd6aaf8aca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KmVy9h27BGE9+Ro7DFyCoMcHudFSiwPfDn27dDbKqhfczerIpWcEqlTeY5MI?=
 =?us-ascii?Q?gRKEtR52bIfOgRPVQVGYfFvZtI6JZujWWz16we5Qkikfvw0baWQqvkODwmya?=
 =?us-ascii?Q?apRDK68cxBGMHk21/iAy059Pc60VIQlTFljPgeAw/Wo9BNW33DlKvPtrEfmK?=
 =?us-ascii?Q?sxMmK9bExyUJSEKEeZghvNoYiN5AZGKK1aT8NEX879aw8Kkexyjeiz3RvHkN?=
 =?us-ascii?Q?bA9jyW5OeQdTRC/UNU6qjTNVwJHv9L5G70aQSjWRem5xbB2NbA0aerNd3M8X?=
 =?us-ascii?Q?Vhc0dIT6ScOILccuYSP9gblTZdoa+xSQX+OIurVstf0fJTmCCLt60z/11sBJ?=
 =?us-ascii?Q?IXYNJxm4f1434y6UUXs9dJxGJU0wD3QuCqCsYp+ykVIBZtdvhdk1Mx/ERtBF?=
 =?us-ascii?Q?SYVO52RFtF6slPDX1OoMgDlh0OX9/sHUzs/90ik/ypWOsGuFkOWIFkbRwDdT?=
 =?us-ascii?Q?AmagSi1dOmQcD7ec71Xzi82Vs/lrq9ro5Kagj/TK8znQLVbnDz7n5Vop9kPd?=
 =?us-ascii?Q?v9uvnaiHLO5Fpqdj85i6cDliCYoLXqgAKNb6JgGbZ/eaiM/ktlcqKeA9boPb?=
 =?us-ascii?Q?Nd/7rF1p2b3HVIrZBVUFOZp25B33Bqdm8QvD1fQPJFQ7FmEdzBSfBEa0Ox2E?=
 =?us-ascii?Q?/tPW0D7/2AUbyBvYp7XgeKBC+9+veUf6+WkLK5Y4/RMRzxDV7nSVixW7Q1dt?=
 =?us-ascii?Q?6hTibVLVoZzCEmAeWEOgZa4TPdWZDRNDXzc8zE7MUtK5HoCs4dzGDUXOAI68?=
 =?us-ascii?Q?ie0cbRVnD3aEE1ZY18eBOGK82Zfxxcwkeizp9uQi+1uPXuQoBdqgI8xHEV2s?=
 =?us-ascii?Q?itJgabc2wVrvPtfJIKrONZpxqtcedmHT3+2/IdG9jSio3+4/cnezVAyZU6r/?=
 =?us-ascii?Q?HANi+kK86CvN0fnh8KY0wvxcVqp3BXZ0hq+hwWSHhQ1uYlBDMyYgoztNX2Nq?=
 =?us-ascii?Q?Nyl7rG2JsKfbjWaXrNILCwhGXPATaca2IESZnD3TruIwl/Q1Ara7Wed9on2+?=
 =?us-ascii?Q?nnyYo7wui/BiRVPsGflvWntyOuraaN9Bu/UCaVLymiGpfyP0YxDm4ocE1sWT?=
 =?us-ascii?Q?AqjIQsZvsDw6hWhL+DgBPZKi11As+lMMfTaUZt72k7BDa8jP75cFzx6brKvi?=
 =?us-ascii?Q?RRBsde/BUp7zfCApiP8ZQJac6TI7KplwHPxVEyY5nD4av09U/KS9sShjNhZe?=
 =?us-ascii?Q?mWZy9HSIM/Wltj+n1kCJZ9yFXgjC0BmllAVjZv1IYnhEGoT+InwYXItVsZSh?=
 =?us-ascii?Q?McaUi89BZ8wrGAUm70DoBfLWy9ZmairOhIcH2FzWQviUHa3zsB9aXBLBQlm9?=
 =?us-ascii?Q?tFZAQVUbbN6DB13SNZLk4oTZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cqx9urJutMY3+bjCYanfN9rxMWsIvN4Bk+iZcLKTASX4aYCyTHZ/G/2/lgsZ?=
 =?us-ascii?Q?IfBFfsz5lhZMOLdv9K4mSaOu5jCj+bIgXcPa1zwwAr12Hv/CM4Y1qvciwEsr?=
 =?us-ascii?Q?xLUhIJuC9gVFZoZUcJ1CCHFj7lSfP2je0IvMIrlFbxnL3shmoiaC54mAa85w?=
 =?us-ascii?Q?WIWch4zhV13lcnO3L1zNdZmRzrQUI0snwkDbIFfPcq0pYVi6IB2Laa5XBuYE?=
 =?us-ascii?Q?QGC1FPJs/oZGEZ+mS2Su/qFys87FHUb4faRmyBIjfjBGW+xkjI3rNcG3UsvW?=
 =?us-ascii?Q?r2XrgeK/Lrp3X5tTrO1s5t2o+genqo+AXMNVSWuLjTC2ne998H1q6KqZneMd?=
 =?us-ascii?Q?zEJp9iZAoHjOMpP5BxF2ZGyZEdEc7P6sqSbg+22B2CX2uhsnSwmyE8q0dgVW?=
 =?us-ascii?Q?K5NNBKC2HicTNAXakVGrC1wMqe5kr/LXlIiG2XF7VReXm8Fu15m2yadjhprc?=
 =?us-ascii?Q?oWZ4vUZ8TD6u6pEqejbyR8ppLpURv9MLYjUxOgAwMGX0mVD4bARfcffiuubh?=
 =?us-ascii?Q?Rdp4PkjNXiRHJ111a4Du+9oBg9o937eyMDKuqKVNEv9Iw4Mh+ma7KV1v4rDd?=
 =?us-ascii?Q?ELaQnpYXMP+yU6C6ZZLUIyFEUnTgWd4sOou598j6nmh2SZ/zHVFauRlowvXp?=
 =?us-ascii?Q?cuA983Z8YQeT/tzuhsvNkovF1+IRVwJ+i/mZ4xRkRjRBRzSGzajESGWydZ0h?=
 =?us-ascii?Q?QOIUMRj+4TIU2LAwBGOYnfzC2Q+AjcOU8atlzz7cOZ7SCRzRGsTzYgg/x3hp?=
 =?us-ascii?Q?EnnMwBEor6KYRZ1OYhEx4+aHEdVQqRLOmCuAlk2dCxvmFIkwdha+3YC1jfJA?=
 =?us-ascii?Q?Bgnf+iqdPr721dBwehCWOhxynKrnQLwlkuCsanCWLKJNRCs6Ue1eTWP2EeIF?=
 =?us-ascii?Q?yfOQsn/0KVUaOg2bQbdi/PY/AjawXk0Lco9xtCJ0mLqyC4g+6W+PWdbEDZrp?=
 =?us-ascii?Q?h3wTwjzDiNQ2emXKFqXp4dVt6gP/tSwUUxzPZYI1NFBXdRHqcpSactSsCfwD?=
 =?us-ascii?Q?O4NssHyREJi6zXRYPHmKniYwq7kn+jdhjY7oPE8OlGRcCZXlGOTggar7DOrO?=
 =?us-ascii?Q?cwPzgamG79J1jCNY1p40Wsf39pfsdZTy3NO5+sbILlNJ8IEM9stYmZN3W2/G?=
 =?us-ascii?Q?w/32dlv5MuWmY8Twrmir85EDsAOd8/a4rW5ivk3wiYXZtETu2KjLZjzrfx7h?=
 =?us-ascii?Q?qzkEw6O0QLNxzM41zabjAZd0KsTUe8xaOYFPAkxpWwrljRYuTBiiI/JaJA+P?=
 =?us-ascii?Q?FEckMKPikuM4JsbDbvPAOFM+N6c4Z3PjpO4L0zINHzbN+8oex28UobpLnyAO?=
 =?us-ascii?Q?TwAi2e3gnu6CloYM+NiFQ2jNJhMof+9BeemmmkK6TBURSwbXmEOO+VTiN9cl?=
 =?us-ascii?Q?XdTTtHBfHIFyb3RPsNLfMJZuatm3GY+/i0E06qnvBzSh9A3gbRuUbk2k9tA+?=
 =?us-ascii?Q?JZgtcTmBFIXGrWYihjd/tRg/eLfJ07+WqgatOl0WqIoFwBD3XcVmaWkbEbfe?=
 =?us-ascii?Q?GeQ7JQLG4bFHwzaBDx/lG4hvhSn+1XIkxAahz9D1MTKTI6DaJOcYkvpCYlP5?=
 =?us-ascii?Q?4v2tSkcJH3q+MvxiYyN+kl3AWEB68xDcnG6FysMhdlOLmlngy+4Nxi5AWpbD?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca0c735-fd3b-4557-b151-08dd6aaf8aca
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:40:33.9599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lpsh6My0X3GEsPuk9pzeuAYoSEMilj2U2uvD+pYyubFE5rkO3JfLUaN5t/q14/SBO1jhlebP+ijKWG30tdzcmsrFPb9ZAP0TlTwaKJKREDc=
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

Add s simple test for the I3C uclass in sandbox.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/sandbox/dts/test.dts |  8 ++++++
 drivers/i3c/Kconfig       |  6 +++++
 drivers/i3c/Makefile      |  1 +
 drivers/i3c/sandbox_i3c.c | 56 +++++++++++++++++++++++++++++++++++++++
 test/dm/Makefile          |  1 +
 test/dm/i3c.c             | 34 ++++++++++++++++++++++++
 6 files changed, 106 insertions(+)
 create mode 100644 drivers/i3c/sandbox_i3c.c
 create mode 100644 test/dm/i3c.c

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index b8f3012873e..491c7dd56b1 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -935,6 +935,14 @@
 		};
 	};
 
+	i3c0 {
+		compatible = "sandbox,i3c";
+	};
+
+	i3c1 {
+		compatible = "sandbox,i3c";
+	};
+
 	bootcount@0 {
 		compatible = "u-boot,bootcount-rtc";
 		rtc = <&rtc_1>;
diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index d4451057de0..d877a744353 100644
--- a/drivers/i3c/Kconfig
+++ b/drivers/i3c/Kconfig
@@ -14,6 +14,12 @@ menuconfig I3C
 	  If you want I3C support, you should say Y here and also to the
 	  specific driver for your bus adapter(s) below.
 
+config I3C_SANDBOX
+	bool "Enable support for the sandbox I3C"
+	help
+	  This is a sandbox I3C used for testing. It provides 2 interfaces and
+	  records the settings passed into it.
+
 if I3C
 
 source "drivers/i3c/master/Kconfig"
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
index 5ddc4743c86..d38d2350c9a 100644
--- a/drivers/i3c/Makefile
+++ b/drivers/i3c/Makefile
@@ -2,3 +2,4 @@
 
 obj-y				:= i3c-uclass.o device.o master.o
 obj-y				+= master/
+obj-$(CONFIG_I3C_SANDBOX) 	+= sandbox_i3c.o
diff --git a/drivers/i3c/sandbox_i3c.c b/drivers/i3c/sandbox_i3c.c
new file mode 100644
index 00000000000..1b497a49041
--- /dev/null
+++ b/drivers/i3c/sandbox_i3c.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <i3c.h>
+#include <linux/i3c/master.h>
+
+struct sandbox_i3c_priv {
+	struct i3c_priv_xfer i3c_xfers;
+};
+
+static int sandbox_i3c_priv_read(struct udevice *dev, u8 dev_number,
+				 u8 *buf, int buf_size)
+{
+	struct sandbox_i3c_priv *priv = dev_get_priv(dev);
+	struct i3c_priv_xfer i3c_xfers;
+
+	i3c_xfers = priv->i3c_xfers;
+	i3c_xfers.data.in = buf;
+	i3c_xfers.len = buf_size;
+
+	return 0;
+}
+
+static int sandbox_i3c_priv_write(struct udevice *dev, u8 dev_number,
+				  u8 *buf, int buf_size)
+{
+	struct sandbox_i3c_priv *priv = dev_get_priv(dev);
+	struct i3c_priv_xfer i3c_xfers;
+
+	i3c_xfers = priv->i3c_xfers;
+	i3c_xfers.data.out = buf;
+	i3c_xfers.len = buf_size;
+
+	return 0;
+}
+
+static const struct dm_i3c_ops sandbox_i3c_ops = {
+	.read = sandbox_i3c_priv_read,
+	.write = sandbox_i3c_priv_write,
+};
+
+static const struct udevice_id sandbox_i3c_ids[] = {
+	{ .compatible = "sandbox,i3c" },
+	{ }
+};
+
+U_BOOT_DRIVER(i3c_sandbox) = {
+	.name = "i3c_sandbox",
+	.id = UCLASS_I3C,
+	.of_match = sandbox_i3c_ids,
+	.ops    = &sandbox_i3c_ops,
+};
diff --git a/test/dm/Makefile b/test/dm/Makefile
index e44f3d89e77..c6c12713d7f 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_FWU_MDATA_GPT_BLK) += fwu_mdata.o
 obj-$(CONFIG_SANDBOX) += host.o
 obj-$(CONFIG_DM_HWSPINLOCK) += hwspinlock.o
 obj-$(CONFIG_DM_I2C) += i2c.o
+obj-$(CONFIG_I3C) += i3c.o
 obj-$(CONFIG_SOUND) += i2s.o
 obj-$(CONFIG_CLK_K210_SET_RATE) += k210_pll.o
 obj-$(CONFIG_IOMMU) += iommu.o
diff --git a/test/dm/i3c.c b/test/dm/i3c.c
new file mode 100644
index 00000000000..81336e67555
--- /dev/null
+++ b/test/dm/i3c.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <dm.h>
+#include <i3c.h>
+#include <dm/test.h>
+#include <test/ut.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/* Basic test of the i3c uclass */
+static int dm_test_i3c_base(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+
+	ut_assertok(uclass_get_device(UCLASS_I3C, 0, &dev));
+	ut_assertok(dm_i3c_read(dev, 0, NULL, 1));
+	ut_assertok(dm_i3c_read(dev, 0, NULL, 4));
+	ut_assertok(dm_i3c_write(dev, 0, "AABB", 2));
+	ut_assertok(dm_i3c_write(dev, 0, "AABBCCDD", 4));
+
+	ut_assertok(uclass_get_device(UCLASS_I3C, 1, &dev));
+	ut_assertok(dm_i3c_read(dev, 1, NULL, 1));
+	ut_assertok(dm_i3c_read(dev, 1, NULL, 4));
+	ut_assertok(dm_i3c_write(dev, 1, "AABB", 2));
+	ut_assertok(dm_i3c_write(dev, 1, "AABBCCDD", 4));
+
+	ut_asserteq(-ENODEV, uclass_get_device(UCLASS_I3C, 2, &dev));
+
+	return 0;
+}
+DM_TEST(dm_test_i3c_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.26.2

