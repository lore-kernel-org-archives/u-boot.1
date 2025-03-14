Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF43FC28B30
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 05:37:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D97981CE7;
	Fri, 14 Mar 2025 06:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="D3fiW4Cy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBD9B80F9C; Fri, 14 Mar 2025 05:10:10 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92783808A2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 05:10:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSzt2ILaWlva3ViasxAPcA/is95y5NU9a95CafvT0cWnwe+UyN9lhMhlb6zEhUorUEqUhMjsQipvzbRiRFzh35r835sAPa9MfNuZeHKeTjWA0TzsDKVN8KNUYXO8RHCz5ksZJEBbrd4UB7rUqSMD2QlDo9kAvG6sc8Sy7Se5oaQD0ytln7masWBd4zvhZWZoLmYI7uGzSOPDVvWrk4L0N6HPwrOMa9KlMS72Qwb4JPqvWBxGmzlHj8ozDXdo3kBPZ55kBn3fKVZKpS+Twls2JAQvnCk2oBTVpjzqIDtonFsgk6P0ZA0yfAIDQke2vx35spjwKnfiqLTkwGYH882ktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYwpEE6EzmfE1Yj8GgHG8j/rK7dQTI20FUM3yxFGXqg=;
 b=Q/sKMK6FYDrjDXsMAoGhhCHjGzBV1njHqQ0JSxMrkukDay1ZeO3kblyZSHwuNRI4SyurhX+6w3QAckJ0Z3UAa4a/pWFzYLDehU1Q5quNQO9HuUOcPBCj9XkXBe7jDneFco6epEEv5/ySPVMVku9mSCFERqbHsyp3o/EAxoWg79XNvTW2eTW7L7MfB7x+zBJVECwxEe8C7oND2ojkBGhtqm2OwOaOyohWtXw8Mv6k5klvK3Nj1jwJ//D7mzniOxhOuJn8YhN6OaIDcklVm310TPQ9yag3KUtdrWLjtBpOZOl3xuu7/YtCxfmU0omYCWtjijBB29B3mkQukaa7w667rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYwpEE6EzmfE1Yj8GgHG8j/rK7dQTI20FUM3yxFGXqg=;
 b=D3fiW4Cy0i/w1HxyWFDXDC1lwU2pUtATvn4MgzgIrAEgw4fKzZT70z9X3fBwUUhXeAz4tNi4A0zZ2CpL/eT5F+4uIbuuivfZ7mC5/R8W0d0dkfQoTTMOQQT40DjxZl+qyjY0cclmJ85hq/G/cUwhtZSJNTRLrCFquO7pCxbMa9Ds3HTQf8zZjSUWEyxHRCp8wVxUhHJg62Vs0F3EgO5nHD/P8mFJASKos70j4UL3G25JLi9L8Y+CbHYTwBhxKJam4K+BM/a7e7hQtwWdApKoP0RlHkIS6DDF6JaDv1NetW+kGEp7SgTn1tHMEHwumsYLY2NM/9lVvZ35l7GhX41HBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB4387.namprd03.prod.outlook.com (2603:10b6:408:3b::30)
 by SJ0PR03MB5757.namprd03.prod.outlook.com (2603:10b6:a03:2d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 04:10:06 +0000
Received: from BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874]) by BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 04:10:06 +0000
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
Subject: [resend v2 06/13] drivers: i3c: Add i3c sandbox simple test.
Date: Fri, 14 Mar 2025 12:08:55 +0800
Message-Id: <20250314040902.43621-7-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250314040902.43621-1-dinesh.maniyam@altera.com>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::9) To BN7PR03MB4387.namprd03.prod.outlook.com
 (2603:10b6:408:3b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB4387:EE_|SJ0PR03MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 7625ef6c-041d-4a80-3679-08dd62ae1a2d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xIdmwFDbFZzoJk0eOJlgBTkISivQB7V+FjI7l2g50jfIUOKcDRIJqb4kiSdK?=
 =?us-ascii?Q?lWFfpTnivzbzCj0aZVKslJd6VqBnIIUh45zGWE1AtAkkIShA7IPHVgR16S2N?=
 =?us-ascii?Q?4XoWIil7Uue6qMfgoC9HiCxJjijicH2z7U1P0klXXJs2dLYNzp749+lUZ0yw?=
 =?us-ascii?Q?XN3TuxXR70/i8C4Es8EkTa50GwjkccLpyNdM9nWVjD8sGV0j2WwEdzNUZ1sI?=
 =?us-ascii?Q?s6VRqE3nvBBkf86Flgd+m6R6eINv/lhJnAg0NHpSyciict/udWKGrofhhVvl?=
 =?us-ascii?Q?ijn3nFy1Ga07UTXvWH5euy7WfCYvaEb/73qTUX8LU3rKXdVefKDp3204TZdt?=
 =?us-ascii?Q?71B/tqd8ZxFaOPMdiZoZQVOVg1v7AK9lFU++DiF885vKI7lrLOSuT9IT4J/S?=
 =?us-ascii?Q?kpqYdq9J3lPgX6/DrWkV3WRZKbVxSWx1UMGZQmTwwmwTsWbQTCobK/N9q24c?=
 =?us-ascii?Q?pOJCo1dm8Vdrzlq4xNm/UTNTjDClZulRNC1N//nnwNw4AFiDLGU4Rrrmt7NS?=
 =?us-ascii?Q?pa0tA/YT3T+m6eRUzmw/M2AkQKamxCOmOPjPhXD2SFfiKKlhuM3Ge1H2ayEa?=
 =?us-ascii?Q?xO7gdlaT9C/tQCFisSQavM/G7qq3oXTugqVO96oWEj/WwOzev5oMjKemv7O2?=
 =?us-ascii?Q?7mWAlXMxzknyI7nNXtZnhqfuyxzx8m9/9a+hWE0DjA+WLPZQgQPp/OTiaBHS?=
 =?us-ascii?Q?BkWpukQqgO3RoQ/6cCynkQGBVfHs2+RfkB4vTTgtnHWUTAlgLRk2woN3KP+0?=
 =?us-ascii?Q?dV5/JI1RQ5tYQUpXyUN7towRkasatlpOfOykr9L4Z2hoawZMo/foF1ZkdNc0?=
 =?us-ascii?Q?ZwmnD6S0ugTzlNcYSiHKYYE/SHy2OOzxkxOWzODahTI9DgscdLaeXDsUgUL3?=
 =?us-ascii?Q?SFjd4O5jwa82p3Yw8+Ok+KQHDN19ba6TvfhfJD7IeavIV7vlQR/pH62pzuzD?=
 =?us-ascii?Q?CWreaXNYywoAWVx27GOff79BKZ5oDR0XrZbBnDv9ba00b4ndLu8IUnN8il4k?=
 =?us-ascii?Q?qbd0cA/UrrOMtE3S94D9Gd2gJ6C0RJ/uEW5FInDapQwvM1M9kZuX9WjWZGlg?=
 =?us-ascii?Q?puNcoc20nOeVwqMDQXCkzP5wGMzg0X59ZJEg7/koaERK/qCnWXXPH+ZYPzva?=
 =?us-ascii?Q?U5W0WdbjqjZBtdb1+xH2MLz822sz21VAn1Mw9P31i6RfAk0pWwl3zaeSqpMX?=
 =?us-ascii?Q?9g/Ct/dzC67Tt5hk1MzjIBZYBG5tiNeE1xtBA023fMdZNFBg1VvtiHg903fw?=
 =?us-ascii?Q?oP2cyJGrB4QiqDzgtGdT/eiSooYvtqGFP9kD0pTxIKQJc1vCEgbK4T04SBy2?=
 =?us-ascii?Q?7Uoj9nXM2t+4LSY+KWWyUA/L12E1nROr3JPeldQ16B75fQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB4387.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Md3Zr4qN3U1cDLzryRh67MFgf1ZMrq8dh58YdU4beg/CuIab6HrT/HIcXMZQ?=
 =?us-ascii?Q?qFMxeEfCkTIEi8wymiACNKBCc0epSVI7UBhUC9Sxi/HIiium46CxWoc1GeCI?=
 =?us-ascii?Q?vV5ElVet4S66fo6OYI220sWCm1JSy66sAB0X4x5mDUEvsS7S70m2+EU581AQ?=
 =?us-ascii?Q?0Y3Z3SekiQXsStaYo0T0Gw2tDTW9xL1zDmxZzoHk0qzbHC1Hbst/fw6RCHyu?=
 =?us-ascii?Q?1UcoeH86s1vbqScV+ROLonNLnLshinh3f8OJzpgkkbkn8MWEruVAotW051Su?=
 =?us-ascii?Q?+16GmXhL+u2i19f5jKzC/xXdvW86Xly1mywnSNevo1PRGfBjO7O3m3TCbvIs?=
 =?us-ascii?Q?x0cyjVqc3oxdtXJfQbv5xHM1X8+od93v92BvfO4M+IPGPRLsgumjzOXvKdC4?=
 =?us-ascii?Q?5fMh1bgUOn6Y4zUFTI4W+hxxJPYkPDo61mjVZRn/zMBeuihvOOov8IpRR9ti?=
 =?us-ascii?Q?Vs8IzY6pQmX4m/WCfpITio/8+uQMMvnxKOqc4lZGVpRIQQdjlHYTOkIAkeQG?=
 =?us-ascii?Q?NH6vfzSmn2yD2R2MInxYvfnTAKPBmbS0gDpTNwochJNfH/dfTqISoarlh3mu?=
 =?us-ascii?Q?sp+t7pd5ivIjhur59dO7cMvWTv2M1P7Kh9c3sAqyUdO7jCJRQ0guBko5epEK?=
 =?us-ascii?Q?HbHCRivXkMx3179rVTfCwvCjeOEZ95aXSCNqvh4HvSp8LKSE8BZ9U9C7LkqN?=
 =?us-ascii?Q?EhF7KqrLa4QROxTvk7G0hZ3UV29cr3uYudVC8f4nBJ3yQfxq44YWdpL0ihC1?=
 =?us-ascii?Q?3jxs2lkERtOQvdhWq1t9yjdkzs3jSScBv0xdqKg2pJUeogTOXWvz/4HLWxgL?=
 =?us-ascii?Q?NBobWdHZZOZ7bCa50f0MZthyBwWkedc0pm7v0iRPQVh3xQciwC78/wFsX9Sq?=
 =?us-ascii?Q?uPtfhl3i5k2NB07S1F1nWOaR6a1CjWMzMASwhQkxyco+SKyBJ5HR825gBEqV?=
 =?us-ascii?Q?ud+DtvDje1KPKKrPb+ZGJngfQF19KxOMAbChTgyTokSMGqWr3+fJ8dbNdEvQ?=
 =?us-ascii?Q?TtO0k9J40LOPWrIMphrOPzNNBZU4v0jyegKbzyofT2hMzTBiO5PU+yrFGsx9?=
 =?us-ascii?Q?IlaW88hwoQe+e1biZ7iqG4iLPJiZZfJl9GeaH6j7S/hX8Q/2x0b5JP7XZ9//?=
 =?us-ascii?Q?NwKLBlOywixb1pghFoCzkbyWpdd2d3iipCQS0VVYGDCIEyNDJWdzDgRkqq0v?=
 =?us-ascii?Q?7LJOU7DZzMF+KqA5cTeR7Tw9U49c//udAXOn3Tz68yIs8TtMeLw2/C0NshHq?=
 =?us-ascii?Q?SETU7sUhZzdGqJ3xJMmhAC/j5OSn2wKlH7FnONh6CaNwqbG2bXsP5D2ECBjD?=
 =?us-ascii?Q?z9j0w3eq6eg//Ak9mBElcHCo/ls2ShQagcxzI38Im+JL44kyZ3xZJsxWKp8X?=
 =?us-ascii?Q?ZJc4Nghdb6Op3SKrjMqUVtaU0seGRfM3VvzpTzMLUWVNoqD/LRxR3WnyZhUs?=
 =?us-ascii?Q?UEfQAAyu3fCks0nOVvEME2IgBcFqFBxxIYav2F8kWRqHulWfsgbkZWRaPCqa?=
 =?us-ascii?Q?i9GWYErtI8UVcjKV3hw7E+fl6d0px6CBGGPpqY1csB/f0gbCy+uGyTBNBBXo?=
 =?us-ascii?Q?9YP3+Yq5jBzfbjqu9PIoRXz0jYMc2UP8PSMqD6X8218md9TIVL3HL4e7hhRq?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7625ef6c-041d-4a80-3679-08dd62ae1a2d
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4387.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 04:10:06.2280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGyulRGOfp6S7y2LFFCPz+YVBFfnorm89q7zvXzYTgF9VGBOEIi/iDkeE0frH0uQeu9pv8rLoMk+wqRH7Cmq1V6Zs7CpvOi1pgqMjdO14y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5757
X-Mailman-Approved-At: Fri, 14 Mar 2025 06:36:33 +0100
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
 drivers/i3c/Kconfig       |  6 ++++
 drivers/i3c/Makefile      |  1 +
 drivers/i3c/sandbox_i3c.c | 58 +++++++++++++++++++++++++++++++++++++++
 test/dm/Makefile          |  1 +
 test/dm/i3c.c             | 34 +++++++++++++++++++++++
 6 files changed, 108 insertions(+)
 create mode 100755 drivers/i3c/sandbox_i3c.c
 create mode 100755 test/dm/i3c.c

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
index 8140b530bb5..909d43e7cb0 100755
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
 endif # I3C
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
index 5ddc4743c86..d38d2350c9a 100755
--- a/drivers/i3c/Makefile
+++ b/drivers/i3c/Makefile
@@ -2,3 +2,4 @@
 
 obj-y				:= i3c-uclass.o device.o master.o
 obj-y				+= master/
+obj-$(CONFIG_I3C_SANDBOX) 	+= sandbox_i3c.o
diff --git a/drivers/i3c/sandbox_i3c.c b/drivers/i3c/sandbox_i3c.c
new file mode 100755
index 00000000000..99ce769988d
--- /dev/null
+++ b/drivers/i3c/sandbox_i3c.c
@@ -0,0 +1,58 @@
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
+DECLARE_GLOBAL_DATA_PTR;
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
new file mode 100755
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

