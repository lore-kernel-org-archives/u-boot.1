Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C80BC3ABCC
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 12:29:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3CD782AE2;
	Tue, 13 May 2025 14:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="pPph0nxg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F5158129F; Tue, 13 May 2025 12:20:45 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23F408091A
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 12:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3NvjMuQmVIRTjgXwdALE1jGbGmxQJyorz2pGU+V2V+aj3IoM/ahH7B4FAEnf7SYP7MAVTEZrTYX3FmQxHoMHp8UxqRw6yOMmfAuqdu19h+i3Xc63o/wJGMDEapsp1NZwkBdOUhyt9rP/WedO+zGJAolv1n8whpKuLVADtVceBU4rCpzWEAyVnymt5vrqg3LjzxQztbpy19af3R3hVj7vhbKJKuKL+NAAPbl85CsfcccpMir3YKVlmY8PgQa1Qes9XPTAO4gD77FMDQEOGQFi1OvWzFWo/Y+YliHaIpniQBZs0G2rkCFNVhGxDfJ1Q9vOK1Mmuo39F0z+4wlb0cPpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HN0evIZK9Xmkb7QAZSpSZKpzg2yLIxxIEtKCrr/VScA=;
 b=M8r0ca2bXbi7xkIQ41BmMcd9Tl95WnYcOxVdkCpCQb/aM0uH05vUtvd6OOXxdiX1twmfIwUdA2fwMgRpItsKwSLpywy/V0d8cd/52j0qtiexVHm48yRdOOk7WGkWqSIGx3B2skCqYDICoQGgcOCFvR9DfNxdVt5Qx6CwHa7eZfHsVR3sez82SkN7zbtEE7l4v70D97awfY1/SEdNkrIsoeHEzG5EeydxJbtSGe6YowdrCgiteoh5bjmfO0jsSZgchUKtr8YAn8wpnb+23X/wXnN0e6To+6acL7IuT+kPUgF7susNDhW1c2NjvYofMX+FgOwiKPUJ7OzRlEOB/tDT8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN0evIZK9Xmkb7QAZSpSZKpzg2yLIxxIEtKCrr/VScA=;
 b=pPph0nxg5LIDrhz/z9HTpwoAEU2lyJ9CGJEAO7wrOZmfuJ9Lfw7kPoUVtuJvesbA9IKzreIIW6SEOeF2IUPUyw/V8WYXlWFH7KOIaLCNxtrZEH0a9E8oFz5HbJunFJOKASqENUaWtcMptGXG9u0qPeXOuJ9aaP5AUQxZcQS8NAClg2bg/zlbOji3D/7y1lGxtPql2vkOXWaVxOKZlO8mdXUQ1BngrIXaworGFbwBrVmTg+VQDhSuZA47rR++5IVRq95K74Aszphk0TJFEVyB+1P98UVVVvEO0WltT0grQfjLNN1o5PQeqmLva62L1zSPCvmOiKuLyhkPQBsG/tp20g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB3410.namprd03.prod.outlook.com (2603:10b6:406:bd::11)
 by BN8PR03MB4979.namprd03.prod.outlook.com (2603:10b6:408:db::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 10:20:39 +0000
Received: from BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c]) by BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c%5]) with mapi id 15.20.8722.020; Tue, 13 May 2025
 10:20:39 +0000
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
Subject: [PATCH v5 06/12] drivers: i3c: Add i3c sandbox simple test.
Date: Tue, 13 May 2025 18:19:07 +0800
Message-Id: <20250513101913.30880-7-dinesh.maniyam@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 813a99b7-654a-44b3-8197-08dd9207cf27
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y5YGIhdRPNXeR4y+zURtp4SW9+2uiBXn9tMNq2hPdRUA/TV5BKWzl9FxZKpR?=
 =?us-ascii?Q?hQnjX689qX5J9tZQCfwLt30yeW+xqOAyydDpkUUeQeKLutYNUkrUiBLLOXVl?=
 =?us-ascii?Q?Z4B6HYH4cStTAU70g+REiCncoJu3Ca/DpTcnmWNj8da4s3N2EZQONf1/49n4?=
 =?us-ascii?Q?ZKU8PRbftTh8IjB1J2w0FJZ8rU2R2rSxgsH9MICThIJbOrIhkSFyNdM9Y7vH?=
 =?us-ascii?Q?8QLiuW8ufpRydK9Is3yYu1ZAseknm22WHTTT93iRyLhMbhSyCo6px2BUwJgS?=
 =?us-ascii?Q?skkFa2FI30LqZvqE4hdXy7KUI/5rbTklgloP5czUj2V3H8kBKMEB4nUh2vm9?=
 =?us-ascii?Q?+1+jDaRGqyBftp0vuZzo35UzlYPJd8EyacwaLrSwruTEAs7uh58t3SfjZED1?=
 =?us-ascii?Q?V+DbEmlwXifpFNsPoDQ38xCPdGxOsz98Xp+GYDzVoZpbIuQgpbaCdSGtxK7z?=
 =?us-ascii?Q?P4MjP5fJauM9OsHAyOz3MNigZscCZ4oSuCmyCucPm+M6VS7wohVvGbxHWRdP?=
 =?us-ascii?Q?BPhJse6EwnVKA3K30Mes5ICn5+TxDe+NHEl4enmB7V7LSS8QMmvpwtGK4S6z?=
 =?us-ascii?Q?0HDdDmH3okPwoDWCqRfwRjWHQ8c3akcpmV3Piv1Ohd4Fjyo2r+7lF8oGzQaL?=
 =?us-ascii?Q?mTwRJjlMzp1Piy/Hme/FUd5q6rz4k6y6GAehp9rl+chC3boHDdlh9iYoFGT1?=
 =?us-ascii?Q?YLwj9yX69zNoAQ9IEEJNi3jGeaVk0fB6qUkh4JY99W9uBsRAnOFX5sb80ipA?=
 =?us-ascii?Q?uzKkvpwKOHmwKVxUfMePRKyFE1TnPti3eSewFosMX5IbzT9QCsB0/MG+DW3P?=
 =?us-ascii?Q?pEsv6ihkjDZh1bRFD46l/5Th+CaZvq4pQw6PuljPGdU53BZedXsVcZYHflZW?=
 =?us-ascii?Q?tVmVHnpWggpBIydl8nM6Zjli3Pp56/WfSENP4ug2pFHwRzzMpii4u8n6IYbR?=
 =?us-ascii?Q?y6htg83Q/scagwfDzG9XucByRyqaybvoPYgqYI18IPtw98YdswwiFKQ/H3Eg?=
 =?us-ascii?Q?KL0xK7TOGtnC6Oa4Tuwt2PNss3oAWxLbCn52Kji2upE3ZiA5vQ6U4F89LmpC?=
 =?us-ascii?Q?APTjF0ok/OYB6N1RcxgVA/bRGcD1N+2litoODUcQHGQlwm9RHRwGTqpokONn?=
 =?us-ascii?Q?5r6hw05GPuH1MGO91OLldKZ0ubP0iYUp4VLgz/g6OYo01V21vG70jgNbNcJB?=
 =?us-ascii?Q?mOdkB+7JLpmu0XXl+T5cGXz1q/8jST3qG/gHmElClaycqDc4f3Ag5c2aIm2a?=
 =?us-ascii?Q?7L5Y8avKaWxnYwK68MkNJLCAO5iMd7lIXK1MKbBI0ipYN0iH31nIHvgJ56eW?=
 =?us-ascii?Q?+w5J9Q1h559jhVH34c6ajP74KaQzr0+aKYcmDhv61WeF43+MAtdsaB1U6TVU?=
 =?us-ascii?Q?ZFTc7Qw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB3410.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AyDiNRW1DIYJ8zHZ0E/wPcynX31POaP4taPi+PINT1MCXa4O/4p7JCSJteTg?=
 =?us-ascii?Q?Bi0gYtrd6+cTzaRq3tXSQknuZpnkR63k+kZKZhyUf5HsUj1Zl1LWuNSXc2v+?=
 =?us-ascii?Q?eO9KZO3gf3PNe8omt/qO5a0EAX4N9qQESmipLQ+pv0ACQn5UFh7fFbBfdvnW?=
 =?us-ascii?Q?iImVLxkX/s6k06PK4VO3EjOuGs0ynafMJYi5c8PHe/HkXpg67MUR6u8X/rtB?=
 =?us-ascii?Q?3JCpsP4BHw8NFac5D1/RQHvvpJ4Pwux0DgiKR5UCjxTuIbfa2mepAfi/OllT?=
 =?us-ascii?Q?tIfDZNpr35Qkl9cz90uDxwPb6w6OhNZCOvo0D91Acs+BFjANV5/9OIpSNnpn?=
 =?us-ascii?Q?fnNR+23XGLztewiYxFCfcTThXrys9pmfkWmQ4SaI1djtiUQEt+NtNdPndqPI?=
 =?us-ascii?Q?gBSpk0bNO4q7NBufIzhB+69lviWOT1TDPGR+TWZWPev8EuWoZucY/9KXaOJE?=
 =?us-ascii?Q?EdfcuD3UA3qYuAUlHbIVzzESazy6fdcHalr7AIgTArHPag0ztIt8bMHhuxcu?=
 =?us-ascii?Q?WN7xEqvpBjJGWytRiR4ekftztOE70GTifxaMokNHcwH+oaH69f7lyy3cWjqj?=
 =?us-ascii?Q?y0o2Ekzah5dn5C5Hcc3QCLCt/5ZrzTJ1m/2ZSzJB/97LNEsH9B7Ol868kP1U?=
 =?us-ascii?Q?oIRvdQRYSJUBe8t1N9bkYlTY+ePHqpa6l0t7UBFzNCDyffzi74R77l0R4rjS?=
 =?us-ascii?Q?3EFSmsSCHLBjoVnwvR4IzvO3QHTLquxyntyf3KsSEcPgHFhLrN/Q0mvMH8WM?=
 =?us-ascii?Q?slH4Iofp5xqkNg6o0nAT8pdnj9W0OMOwHqXm5cKuJYfG5XUxekLQehwFB9c7?=
 =?us-ascii?Q?zgj6Q/J1jfknAqGD/bGovrWPK0i4UQxkELxR/JyiXCYewXpSOFCFS9Z86mv2?=
 =?us-ascii?Q?hv8wGHcWX8sKd92aAVB9QH/XTs0IPcLwKg6H+XlomUEadkRDa8CVoOnfmzK/?=
 =?us-ascii?Q?EQC0TlDep3Qo4Ec0RPEqotipDhO5hsb/zsIBKHd97842YBkF2RsFeYMevdAj?=
 =?us-ascii?Q?mSPOoerWvzHXCxLJUufT3W86CcdmxJ/smd81l7Nh9qqR1nJcowAM06A1OSfF?=
 =?us-ascii?Q?XMFOaxoyNrAojb0UWIwPcR7x0CGJQski9nOKwiBK5OMCYR26h7WLoVqvMKSN?=
 =?us-ascii?Q?dXDRqe0Fq2Aq/8V26/haNW0ReCjWxe+IopchG9rDSHHId7NdVhfUlr/hqSBU?=
 =?us-ascii?Q?DHJM3W+DnjychO4fVmpwpf6l8NkTDxupl5XTm2T+VotSJM6szKHrIoAWtLGn?=
 =?us-ascii?Q?Fgn4PcZ2C3C0RoBW5Cg16cBrSdxdFkYyrTjs9l33wyVfEPiQNC/ikC0pLNS7?=
 =?us-ascii?Q?mqhG6cnpTUmdBlBEEibgqoFvhYRx/9D5+NuvhOkB0ifpARihIbYuGb2b7DjM?=
 =?us-ascii?Q?B5LzpgsRiNSxROXjGQKCua082DB2KyBIkq9WZ/tXVod3XMzWLwkSxYh/hVqh?=
 =?us-ascii?Q?mGBDso8q0qTb/3bRA4k+6VlgV/68HVIfM6Vry64DHfbwU2n1u0kvZo/Ybkcj?=
 =?us-ascii?Q?6sw2kgfhKwv/KRCSJxhwLOTICoVzv1wbABynZSLU9L8FtKK33jXr1rMAGc29?=
 =?us-ascii?Q?uTUvr8eP2uOPUuBLsOn1HvIrETYFkqKmKvB9Zz7E0bOLitCXIsDBR+/wMjqZ?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813a99b7-654a-44b3-8197-08dd9207cf27
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB3410.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 10:20:39.7359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIxp0hxsuBhjcws9KOqFwfvqq5jnsAwd9HNXmF+kYCO0DXCvSWU8+NbciX2sugtcJfcn5XQVzNuUXMekqAn4RTUmzjQmiCVpweufLHIcZWg=
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
index 00000000000..e452e982566
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
+static int sandbox_i3c_priv_read(struct udevice *dev, u32 dev_number,
+				 u8 *buf, u32 buf_size)
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
+static int sandbox_i3c_priv_write(struct udevice *dev, u32 dev_number,
+				  u8 *buf, u32 buf_size)
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

