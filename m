Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C2CC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:27:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF19083E42;
	Mon,  4 Aug 2025 03:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="syJPyExI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3422883D77; Mon,  4 Aug 2025 03:25:26 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C353C83DB7
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zB/rprBbUmwIJQ8rG/bBL/w/JDpoY/vgIPPR5k9PfB8Iwmjqrbl8gdwXZuCSxBbZinbOX6fdCwSv4NlzZGWejumYefb5MbxxsN+zWcwyVdhB0RliUPNeQKbu+oNntKVQWOA5kMFKQpeZiMW4RGH8G01t05tIz8tnUlMUBAHiNsjtmTtp3PuQXH6HDZNC9hnL0dpxuIJBGGSbJLTnFno3gkuXVv+wde9pjzc0KUMs306bKWsU1iNTnbi9ICHMbZaMislQLuzf7lnz6dU4AaT5DXEz8SQIg//RDMx/1ALrVioKv4thhAM/kXy8Jw6xHkgTw3oDXQXIlpuCqdw0yetw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfpBGLjWTxzfuQyABIwsw0bVgiLjIZdk2PACWMy5kK0=;
 b=qON+2UFFVDLos5CxvdA0sXhdDrJiaVxnyVk6MgJVyu7ngduHeJj1bbucGaJgnmnEygd/gxJW0ljqei/oXAt9nR+N8b3v/Pg0hTZSpSJC8OEyQY0fyFfhU9EmabnVTwRY20c3+vKVLr3N8fEYbMd3zLfmMWrp7Oytva45dTB1rcPQ6qOr8mIU0nNDxBSkEE8ji+TvuGs1eCirZuWzEdGiCdNcH+K79N4fIktzRAIcwjHKBUoVTmDHCSxM4oyD88pnCvyaPAQqMg4om+qZY7acbq65UgnSLh6QviIF1Q9CnPiRuKbI+ZRX27S6EhwRBR4T/VIMB9810bfc8err0TTqXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfpBGLjWTxzfuQyABIwsw0bVgiLjIZdk2PACWMy5kK0=;
 b=syJPyExIcucUy1aj2F01pLvyvd+iMICL6GQbdMMQLDRtxqUjLHiXQ+gRlr7+1xmpqlcu8vRZ8F8iEfOED1XToYlnjJl0Khcao7CcruUHn/VkK1jYC+S66EwzDHT4Xsvwl0ldnQlia9/C7gE7NNKt96Z6DYCWzY5h1BcrPX7H8Yt0xGuQLAYLY+ugjVWSDii18MxOv7GJI0ePYuYendeT+0n6HoeWfcUFHsf7Bkxj/Wa8rmdXk6fGBfndRMmPo434QnHTRc7TT4+67KHPo87OZahZy116bZby6X0B0xKLO+WzeQkL5dspewIljjtzwadiXA/FeD8m/A3sTR7yiHm+Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA6PR03MB7973.namprd03.prod.outlook.com (2603:10b6:806:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 01:25:21 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:21 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 10/34] arm: socfpga: agilex: Enable system manager driver
 for Agilex
Date: Sun,  3 Aug 2025 18:24:37 -0700
Message-Id: <20250804012501.21811-11-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA6PR03MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: d474cf42-7b80-4150-5f0d-08ddd2f5c79c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?saYrZy7DHDyBTc8/wuCYf5c61NQIdPygx65I8F1c89dCvlE/yq9YObxcIf7R?=
 =?us-ascii?Q?sw/mTNDNRo2tw3sLohmbzLY/KMukIumUEceKDq5Z/qqZHlJqYefqoSHrRFv6?=
 =?us-ascii?Q?hWtLJrCOFxLH3sZOB9dbuH/+RoQyZOc40b40yQAQh9A9pSZTMgctR15IM7VJ?=
 =?us-ascii?Q?V1VQi3wa/Tzw1xGd/npSwVcx79YmI3x7jVdQ9qzpRkh5Iv1RqioRNsMfFRPa?=
 =?us-ascii?Q?x5yZJlvLWzcIFyLJppyf6jxxgD7hjMSETy9t1uzEqYzJYBXdFZh2uhkVIZIi?=
 =?us-ascii?Q?Ck/HlljA2zgHwN+U/eiBwFeq5iOKKgySS0LC7lXzhsNNIY2CKwr/odwqMLMo?=
 =?us-ascii?Q?4keiKsVQ4OeOK2iZBRcBYSytbucw6XwmbV/zBh+f8qfGNCl6yrgHYAsuTTuy?=
 =?us-ascii?Q?PtsAmxDHQPh0jYq4uOctNFakDEbR1x31PMTHIU1YUbX3K4ZK4HEgj1QDjDuo?=
 =?us-ascii?Q?0u7nBMbYjlYqdgmwbt+JyODC2WE3PcUBeAYF4PSlmAo71Z01gvhAarKgtdwA?=
 =?us-ascii?Q?QPYuXdgXvkkEeEcmDNEaqfkbyq4wj4PcUO0415T7LA3E1F7SywcubyKJIzNj?=
 =?us-ascii?Q?FLVZRfFnjIzAkBGarxNXl/4wIHGQi3H081xaATul9IRsTekZCRF4v2vYynQs?=
 =?us-ascii?Q?T/PNmVhkg1a9Yd6FKFRvnMLXSc/65M4MYClcGHNvmh/G6JYto7NIP65utVnP?=
 =?us-ascii?Q?HKba2mmtH/f38YNvA4rECWKWOtjAYedeZRJ/JwFn558MHCVdG+iytSTmWczD?=
 =?us-ascii?Q?TfwGx7IV9KCayi6TTEIin6MaCVAB+g390a7VN+29VeDyWm2aU7tqsCFqqRJH?=
 =?us-ascii?Q?jm03CYznbTvRgNhQ9KEAs/KR0miNDJZ98L6qzvZdzc1qdISDaCM43V9GNbAn?=
 =?us-ascii?Q?MPakpjM2KbI3AlZfAcx6t/KRqdBc4tCM/7QLhdWEtE95FmoFaZdGaIa0rjPi?=
 =?us-ascii?Q?pXYHVObcAM/ce0/lWSQ5G2fmHRvcLFs9fjp5z5R1rPGaR8Oj1M8V6uWs/uRb?=
 =?us-ascii?Q?7JmBC0C83kC0PBzkImXpab1sM3Fb6nIPRkk1B9L7tmsIN2yvE8FagbuMuhvI?=
 =?us-ascii?Q?w0+TRJb2wCw0p1MS/1obLQ+6xEeaUO3UJ218FBo14BsZqlDx9jc69w7athGK?=
 =?us-ascii?Q?WLoGDHyrjmA7ym+L8Zo3klsedNlwV5jzzAtPHSkuctczYmX6Zw7cTb6oKaXV?=
 =?us-ascii?Q?Lv0odXhIlRFOuoldF0mJt6SU3K5SVygmJiiYGP1qSTu2yckqn5fjIRQpqyzu?=
 =?us-ascii?Q?4x37pEJEL3BO7bIFUoT+5fEzEkrSLRt+LeDBGQ7LTVT6kU8RQe5DdQaHN5Ps?=
 =?us-ascii?Q?S5PNHlvVf5LUrdivQVMy63lM3rs8tPk9x7jP242BKbqIXFwqWdialP4gdWVj?=
 =?us-ascii?Q?todvk/4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gQnv0t5VwU0imGb3Zcrv4gBez626atbnU2wVjhzoyUXMgpale8Jga7IPmRgI?=
 =?us-ascii?Q?/D0xq24ixAYs9uOGSiPQdmsBtynAjY4u/n09TF+m3vK45GC6O3/wtMlhfVRE?=
 =?us-ascii?Q?JH2wWvmj6koTjyR+tRHw79yUXvKEWE9xgqLRcoTujCpr8Hk+dlBe2Bys/lZN?=
 =?us-ascii?Q?WxWdk1+PmVc/bXasbRhevFBC9RsLp1zkDi2cSj675Rw7yjQJ4n/EOssOkE8/?=
 =?us-ascii?Q?tQlDxVT55kqYVkO0vPT2Byu2xILzVX4Vd+ccejrZC3c7g3sb4LKYvTPcnFmC?=
 =?us-ascii?Q?04HsY48ya/anMlgZeGSYhx97fwe/xR+MMCtM8T642KIorI8lxI7QAZlPxNn+?=
 =?us-ascii?Q?wx/C2m+XUVSMxgddnNmrFSJubN6/uxhoBqf3X0E3iqRRev9Yg3CFF9nTtY/B?=
 =?us-ascii?Q?SNBPJCqkDd5be2gkvyGAVmKL8SHrIzzbuOEDOroM2TaRDRJcQKJXFF2n5BK1?=
 =?us-ascii?Q?vql11C98AZbqaHrUiXkHExusBT5d2N9sFfk373/XJ4KrdvmPnViAFGgTffdN?=
 =?us-ascii?Q?M/MZaIMwwblNTglsAfxpo5P7Hr31J2GMbc4ucg69AKUuX8bFNpn8MBc9WUhc?=
 =?us-ascii?Q?rgyOWwIf+8pqHcLWYdLI4XADImokFGlAEczMtLWX+njPTvmbfaZqvjhela+j?=
 =?us-ascii?Q?se3x0asAKHL6KXvAwykVTCfg1gq5jTzGfTTOUMFXDHZo7TrEN8DAYgBrxtDH?=
 =?us-ascii?Q?H24dwUond7pDK/ftN1bYyHG4ZAp5IGo4Wok4m+ANNkqJBn+XKpN8IG3fGBTW?=
 =?us-ascii?Q?AT0GoQQf8a2HmEfsCr0V9YirI6jfsC9ITvn1rXSvuwk+KNh9y+vhIz7/sALb?=
 =?us-ascii?Q?/Jf8j9p4+M6uRXoalb+/b2r/GC0n1/UsYQg9f5o3YuMH7gfc2vA42BMRJH09?=
 =?us-ascii?Q?Cu/A6d9Dzx46OQLN2yf2XlXyVZspoOprMk191eF0YoTw1cD/fHefsZOZgTQG?=
 =?us-ascii?Q?fqTw53gmQsd0CabT+sgst+MjpV1qWWgd2iCB8Uimc6kzm1QTqyGKPKGsS4Gk?=
 =?us-ascii?Q?32j03ypjgoXFGcTAinhEQ59jRRLSVmt4EX2srQCEOB6GkBWGUzLmslnCUZ5Y?=
 =?us-ascii?Q?39MOWMq3q7ixTS2+8D2V7PfX1q5eux8fbIhNqOyTsEStm21qy3236W1kBAQM?=
 =?us-ascii?Q?Hvae3k+mTL8wgWWTExvBHfX2kpKRVtjAXM4wS1iHeicuOCUN25hY0ITGVKRA?=
 =?us-ascii?Q?3tYrUT8GDLzDG5RiHCTu6D7b900e1Hj+42Cvz0CnDNBILE5xW0AIclFXNl32?=
 =?us-ascii?Q?FzWRPZOACpkt7LqjmO6Ld27PYn6nfiSdcPBijnCV4SV1QIu/DgkDPjtmhrwm?=
 =?us-ascii?Q?3tjpvKiD3XmZ1NnQnmBDMO7SRZ/9SbDu0Yl7nhgVSGbCo326rJ1MSxyXgORQ?=
 =?us-ascii?Q?JOor6DDKCnzBRtanmHuN1XX3HY3oLQ3SVLtqfaBBd9q0dOVxk82VtJMojCLv?=
 =?us-ascii?Q?4efxMtFGW7kD4bjN1Soo6iOue1wPkT08JZJT+UVTiws/Dp8wB9DRvVSg43E4?=
 =?us-ascii?Q?3gsIjfSunQJVyaQy6oxyOItXwelvo1oB1FrYidA2TQQij7+COlAV4XhHmVGN?=
 =?us-ascii?Q?cBHuHTyfiuk1LxrzeN8b4Sw02m5L4OHta9m2SijO56tGToplpns4JC6QhmHX?=
 =?us-ascii?Q?g/yJa1uipVX2VadmF5OQHhQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d474cf42-7b80-4150-5f0d-08ddd2f5c79c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:21.5654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLXE/iUQT+T0f0/lr2yE2vPO6a3M9IkNvZY6xo8wlO4XvPKGHKuM6Ed+UwRUxZjgxiCir3tAjQ2J76OBACMA2zDO4lHqWYe4kTmUjXiUQlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7973
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

The base address of system manager can be retrieved
using DT framework through the system manager driver.

Enable system manager support for Agilex by probing the
system manager driver to initialize during SPL boot up.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 MAINTAINERS                        |  1 +
 arch/arm/dts/socfpga_agilex.dtsi   |  4 ++++
 arch/arm/mach-socfpga/Makefile     |  1 +
 arch/arm/mach-socfpga/spl_agilex.c |  1 +
 board/intel/agilex-socdk/Makefile  |  7 +++++++
 board/intel/agilex-socdk/socfpga.c | 12 ++++++++++++
 6 files changed, 26 insertions(+)
 create mode 100644 board/intel/agilex-socdk/Makefile
 create mode 100644 board/intel/agilex-socdk/socfpga.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d03a3a2199..91c8fbd16a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -157,6 +157,7 @@ S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-socfpga.git
 F:	arch/arm/dts/socfpga_*
 F:	arch/arm/mach-socfpga/
+F:	board/intel/agilex-socdk/
 F:	configs/socfpga_*
 F:	drivers/ddr/altera/
 F:	drivers/sysreset/sysreset_socfpga*
diff --git a/arch/arm/dts/socfpga_agilex.dtsi b/arch/arm/dts/socfpga_agilex.dtsi
index be5100aea98..84bc40dbcc3 100644
--- a/arch/arm/dts/socfpga_agilex.dtsi
+++ b/arch/arm/dts/socfpga_agilex.dtsi
@@ -625,4 +625,8 @@
 			};
 		};
 	};
+
+	aliases {
+		sysmgr = &sysmgr;
+	};
 };
diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index c43fdee4a48..7f53c249805 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -54,6 +54,7 @@ obj-y	+= timer_s10.o
 obj-$(CONFIG_SOCFPGA_SECURE_VAB_AUTH)	+= vab.o
 obj-y	+= wrap_handoff_soc64.o
 obj-y	+= wrap_pll_config_soc64.o
+obj-y	+= altera-sysmgr.o
 endif
 
 ifdef CONFIG_TARGET_SOCFPGA_AGILEX5
diff --git a/arch/arm/mach-socfpga/spl_agilex.c b/arch/arm/mach-socfpga/spl_agilex.c
index 208085d4049..ffa0bd9b09a 100644
--- a/arch/arm/mach-socfpga/spl_agilex.c
+++ b/arch/arm/mach-socfpga/spl_agilex.c
@@ -53,6 +53,7 @@ void board_init_f(ulong dummy)
 	if (ret)
 		hang();
 
+	socfpga_get_sys_mgr_addr();
 	socfpga_get_managers_addr();
 
 	/* Ensure watchdog is paused when debugging is happening */
diff --git a/board/intel/agilex-socdk/Makefile b/board/intel/agilex-socdk/Makefile
new file mode 100644
index 00000000000..306a8cf5f0b
--- /dev/null
+++ b/board/intel/agilex-socdk/Makefile
@@ -0,0 +1,7 @@
+#
+# Copyright (C) 2025 Altera Corporation <www.altera.com>
+#
+# SPDX-License-Identifier:	GPL-2.0
+#
+
+obj-y	:= socfpga.o
diff --git a/board/intel/agilex-socdk/socfpga.c b/board/intel/agilex-socdk/socfpga.c
new file mode 100644
index 00000000000..60c8704b391
--- /dev/null
+++ b/board/intel/agilex-socdk/socfpga.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <asm/arch/misc.h>
+
+int board_early_init_f(void)
+{
+	socfpga_get_sys_mgr_addr();
+	return 0;
+}
-- 
2.35.3

