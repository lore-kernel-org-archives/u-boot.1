Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C42FCAC58E
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 01:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1536483429;
	Fri, 12 Sep 2025 03:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="2QJWdvRU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9503C833EB; Fri, 12 Sep 2025 03:37:04 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E12E9833EB
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 03:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUQLpaptU8iAuBG44UcjkXK5yQM7Vcrzcbo1ZG0xE8Lr/Zh9d8x+EJ6whF9gUADg4MshnX5c4jR+Zq4r4LUoSm7vmtVVlLftFQmm05j1aH6fRM1KaIlYrnn0Ufomjmey4LJTyvp3ZNQ+VU6iTOGDkuJbikVKznvOQYA2JjqxeuQ0gSCT0r4KGa7muajCqEeirhTFGCqcItCyXDDxv4LyKeDD7LPyMYw79vmjHbdO9ZguA/3NZq3wDUQKRIzQvVhw86Nwi+kWGVLAb1YqKhLiPzxscYW7R2bQTSGIv+rcHhInw5n5ZLuOMlj3vACabJD/JfVeD/30SUVhTmOKLzfFhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fb2XFzElTh0vSY2HbfVbtF+RAIRXOUNUruC7C+hKeHo=;
 b=nt4ynIB2HMSyfOmjRguHqG0yc2iO0IH6cWWyqgKdhs9qLHkTs9rgLetfbT95r9XVHHnpxKzPPlpT1PjGFSmbgJxwWb56v5E1QcpTp+Fw20DYAMtTZfzWhA3SB/MavvVNTFoo+lOyFiyWISn2A9epsd3ziNBlD0eOFYXNQxck2p6/oS1Nj+pbUhSRfQODyikw1EKrjizHYHAP5N8ZUP2ZClJGCu/Bhj5wO3ONmeNhTn3eCRJ9cQZ87pyBKn1blLgtAm0JwHxVp0qGNJZ2rjjMV37GoRwHIq7hRVEGcmEBgEZaTbBoaFqlr4CBltnwfeO4IGWocAmQECiJJK3C2MeulQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb2XFzElTh0vSY2HbfVbtF+RAIRXOUNUruC7C+hKeHo=;
 b=2QJWdvRUWhXbIdF0iHmfw+oGmPC0qBIGYw1D7EO4FXNS6he0TyEPn24EgcDSugynC8ndnLfixs3pn3bX7WIc2TC9X+lhfd7Gq9NLRSsoYw3BhERkxSGZViJWZuQ9WidJJw/Q64YtiwECv5dX6TzS8pf6DVpEZKllzGg3ImCYFRRldXxgSd3KwszK88I88wxrhFRK1z2YkUUhYccbT5kWqE934TlfpMgkM6sDgCIqwvptcSeYoev0M2ZGbvAkTPdZFL95Utddv/WOrbSCGOcCuGsIz1xpeHgDeKaAZt5Ton4uytgiZdq9VEVEdNDDnAqFjhdIPuio1631f4bhq2vk0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB11627.eurprd08.prod.outlook.com (2603:10a6:800:30c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 01:36:58 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 01:36:58 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 2/3] cmd: mtd: add nand_write_test command support
Date: Fri, 12 Sep 2025 04:36:45 +0300
Message-ID: <20250912013646.11522-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912013646.11522-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250912013646.11522-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00004525.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::346) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB11627:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d2b022-f160-4672-6a44-08ddf19cdd24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YsT5XAFMVsLPsM6CIR4TOo+jK8AkamKuw+7bDWvhaM/a//qu4VIfC2sDzRzf?=
 =?us-ascii?Q?bsF7QRMZpiU/tUnVRs5BKDYM0XsAJQZ4HiBS0gGZZAQgLB8bhQ2yPw9lp8G7?=
 =?us-ascii?Q?kn90gUltYvSbvu2D3wy2OF3ClOSdQhslwfsmuuR/YhOL0W6oGRtL96rP9aHg?=
 =?us-ascii?Q?9gS2B1LjiXGKFVVSQShWhqTkk15NvJJC8Eha3+I/MQJVqM7BiAT6e3iRTVUg?=
 =?us-ascii?Q?h2IWdDpSPh1vMJ3DXW0QPXOI2BMlf6h/hz1vUPTcaygzifpH/ALzhPQBLBPi?=
 =?us-ascii?Q?FcvsU9OVKkdiDYU5JNyYW8mRPS9UFu4Yzxd+WhEH1THWECGT7Ndb/+iVKoiS?=
 =?us-ascii?Q?8J3iacycORBsvyoO7Jrawci4Sl7uF+QMrpV+cV6TKqoCk7wGZgfzJ7toNVqk?=
 =?us-ascii?Q?mVTqEJ+BmIr4yO4Uvt2d1IQlWzH2vIqH9xAvAwrSpgqfgTmt8vm4BdsUopJs?=
 =?us-ascii?Q?P75bTjx6y3pFWYbxvQsBAAOHqzEYcUhRU/L9WgDnrr6kqDJ/2nZllE/y49ov?=
 =?us-ascii?Q?eIPb8sNA7TdW5eLuLbTY60RAqkVh3WayDYrxx5t6dzWZWKeDtPdF6IdiFSjT?=
 =?us-ascii?Q?617cJyc7i5IPrjIGkQO/KzN/0l1GpsqPVTqt08e9HubnZrqKuCrtYlmLFJBH?=
 =?us-ascii?Q?uhymOP3NDC4osJImGeIyUgqd4/myfkvydGOld0iiJvZ01ytyD6ceYDyyCilG?=
 =?us-ascii?Q?GYj2lROLGSC00koy4T4BUg0qdB9mEeRGf3u+kkUXHBRgVVdxGtnTgaxQMqmW?=
 =?us-ascii?Q?8sPL/f3Gcs2E/zGvmuxh3VikEvzQ3Bcdco3bz9xzBz19kfnNXbfcEqnHC9Lz?=
 =?us-ascii?Q?BrwdminTM4hVOrr2KzFfrTjU8gYwX9cebMqEaAAfCfYyZch81wUo2s+pa0KV?=
 =?us-ascii?Q?awie1j9+cUgLGL6UobiVyaGwKJF8vlJBYvbgsyKElfCEk1xSqDSDNcNf2Wjw?=
 =?us-ascii?Q?urrAoxxwzaS1yKijYA3RoPPx1joqV+OcvedmboJglKKLAs8CLGpfZE/FH6gd?=
 =?us-ascii?Q?53JQ/tc5HWyJONKppEWglpZkRwM+A26cUk1LTFwf1ADp6CJn7XYkEvsuzRrD?=
 =?us-ascii?Q?MgJDSSYEO5y+QL9bZVhWDi9Cisw7zQbOYo8nUbIsa3/dzPosihkXmoMWkQIR?=
 =?us-ascii?Q?7fA5Oo44ng+Ph8HYJuebUvmxygyuRpVmn0GUbCa6POzLGgohXQBoTXG6QhPP?=
 =?us-ascii?Q?Rac6sYi5TTFjuVPLcRpF3MLJcUi3te6PRz+OrZxJrbisYF/cYUs2fG2hnE+K?=
 =?us-ascii?Q?wFABvpcu5ypEk1ib4BAIs/sQPTEtsXqpuS2K3hOq9n3kEJ6JZyMxGpn9aSEj?=
 =?us-ascii?Q?l3qjxT2XELa9Et/4iJv56wqOFLzzCO1o+OLgEqBcqkWgE291t6Ql/ZMnBWIk?=
 =?us-ascii?Q?zM8H8wwWHbS7KVQub9RiFD+4sG+kPLqVKgDFeEH+wo2S4tJ/s2zySHpnTqQa?=
 =?us-ascii?Q?7257eeTnEX5+drQUKyxYXKPYBpv6C7OtNvOrn2LKs3/PEfiLcJ9lsBIBKSc6?=
 =?us-ascii?Q?XE0xESeVcOWqIUw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vkzdo9rYPwjh/7pCEq2I2QPcY0FGtWeEVOnZ4Gxgr6V921eR3lCgkBRQvvKa?=
 =?us-ascii?Q?bQFSCrfGe97slq/os8FJslsqRhOWqt0NyMRecODDLV4hEuNSr6Bk2rUgqkAu?=
 =?us-ascii?Q?MpoVseFR5T3HaYTIEZWfbC9ocvPcPZ4uEnYhndDl2BsKQw0ZVOrDO/90BYSu?=
 =?us-ascii?Q?v39TL34TT3+WPiugLF+TOLGUaC0O2dKAszlGIaqMvutwhVx0J5SHXSD4SF3U?=
 =?us-ascii?Q?GSVawsLLafbvLYmAMeTskZ6j3bs2ug9akdfTEo/AIgcSK8GD1KaCPVnYwQS2?=
 =?us-ascii?Q?9ScaBh/WUrk3HXUiA1TOTkvxBzr887AC96rECejpCshYgp+LoQhMrVo9FBnd?=
 =?us-ascii?Q?pfq1SUWFv8E6XUPnvHiuU5dQx4XcF2mrJCkvSvwN0j+fihw+T0SeIHjw6deb?=
 =?us-ascii?Q?bA/P6yDP7UOCbXSIEUfC0a5m91HPw//sZEoPWYABPzHIkTBsopOd/OhQL0rB?=
 =?us-ascii?Q?hM6TY0LOMR6b5ElrT3Ku+frzuE9pryAfUk0co7oN0qUJ6gJ5Q++sxuCzs1EH?=
 =?us-ascii?Q?PYFv+OTRCRkLrZJ4Tj2Vh8I+oBUFpmis50z7ycU8tOHzRsUb9FPCKaTlFJkS?=
 =?us-ascii?Q?2AXqG2+Eq5xXAaEnxlZPTpjyBgQGVoHKaFKkcAeDaPuBjQN+038q1a7smWlU?=
 =?us-ascii?Q?RAk2aR1SuM9OAy60fNvWzWmW/EzSgSmvn5D8oQ0Rz+04kutXRQLcMDl0G4lm?=
 =?us-ascii?Q?//Bj6By8q7yCThyHtxhkwFGT8jZxfz9mywtYk/tMRMgY+wyAPlu+WARUu84r?=
 =?us-ascii?Q?ziXKJ7srAgSGcG9ZCYQIvmf8zunb78TqReArTbPttUfGMrL9PNMjhs7hSPp6?=
 =?us-ascii?Q?a+folx4d4GekG+AwYcsfTbC7YtQLLjvfho4vbfl8Rbbie3HWB8WBlSSnFa9G?=
 =?us-ascii?Q?g/Z0mvEb2PvnjIx0l/q8fSErqBaWk9Ev67KPLztirXGLceHVL+MTz2cOgFCW?=
 =?us-ascii?Q?38t/FUbvMoC26ysygHOcvQ37xkZ1mLo06Bpdm+X/a/DXr3jJtFvnqBbLXtgg?=
 =?us-ascii?Q?hBoz37CTi5RWDKokPh660Id8NJRvXL0D5gO0KNqq9fzuF+IR0LtPDfLB+pw+?=
 =?us-ascii?Q?0M/X+dk/1TC3djD/2IBhjT+tNKFI6OwsAEkxwRUn7X0cILSRx417JR2r6lvQ?=
 =?us-ascii?Q?/R44xMzhTcs+//jhL2xPFu5Th5ecQm4E8XGqUgATbrjxW+9zeg5qWideC30G?=
 =?us-ascii?Q?I/kc4SbCbW/adC+q3mMwrPlq8eR2YATBVO/CaPVSqDsWb45e+c4pEDc2jpoY?=
 =?us-ascii?Q?AfgGswg/YCqwUtIRZe5H2krd6vC4gQNtvZv4RewS1gAxukxpINPKRQzkGoVT?=
 =?us-ascii?Q?wRy6D8hycd9dy7mLx6aTyL5GA52xkG1EmzpCUXntxiDnSj+MbzN8YVGnB+DR?=
 =?us-ascii?Q?sogv/zhScR43/qBZGTaLL4Jcg1Cfi9339HG657Z0bO3nnQlFwGK/hEkRafoS?=
 =?us-ascii?Q?TqMJYDeH/H3Ma4bHds8KFDriO6iP8zuUlZzQIWcbsXSz9QKkfoZpg5zkEZEu?=
 =?us-ascii?Q?cthdqfrEAHIyzkGrR7o/V39XG7YbqPNt5kME9tMOPJ1s4f/bbnBdNoyT39DZ?=
 =?us-ascii?Q?MTT3Scmxsd3HZfZP9lQpyKiaKC2vPmKG9K5jBwubDs6/JZy7NRH3/KSUheyP?=
 =?us-ascii?Q?n1cLZteDkU4tidyhLlgBarQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d2b022-f160-4672-6a44-08ddf19cdd24
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 01:36:58.5893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnpOxlspBvLQsVnV1kxgfwoGFf1srXr26BhcBNqiynJ13E/4XD9ISiaFzW6ZrtRAenMV5vGpDKW4e8Ab23IC9NrOj32862cNUsLYtkguPIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11627
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

Some nand flashes (like spi-nand one) are registered with mtd
subsystem only, thus nand command can't be used to work with
such flashes. As result some functionality is missing.

This patch implements 'nand torture' functionality for mtd command.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 cmd/Kconfig |  14 ++++
 cmd/mtd.c   | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 211 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 8f2a35d780b..cd1a664f34f 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1519,6 +1519,20 @@ config CMD_MTD_MARKBAD
 
 	  This is a clone of "nand markbad" command, but for 'mtd' subsystem.
 
+config CMD_MTD_NAND_WRITE_TEST
+	bool "mtd nand_write_test (destructive)"
+	depends on CMD_MTD
+	help
+	  MTD nand_write_test command support.
+
+	  Writes blocks of NAND flash with different patterns.
+	  This is useful to determine if a block that caused a write error
+	  is still good or should be marked as bad.
+
+	  This is a clone of "nand torture" command, but for 'mtd' subsystem.
+
+	  WARNING: This test will destroy any data on blocks being tested.
+
 config CMD_MUX
 	bool "mux"
 	depends on MULTIPLEXER
diff --git a/cmd/mtd.c b/cmd/mtd.c
index 95e4be9863d..4d69c7b4915 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -20,6 +20,7 @@
 #include <time.h>
 #include <dm/devres.h>
 #include <linux/err.h>
+#include <memalign.h>
 
 #include <linux/ctype.h>
 
@@ -762,6 +763,194 @@ out_put_mtd:
 }
 #endif
 
+#ifdef CONFIG_CMD_MTD_NAND_WRITE_TEST
+/**
+ * nand_check_pattern:
+ *
+ * Check if buffer contains only a certain byte pattern.
+ *
+ * @param buf buffer to check
+ * @param patt the pattern to check
+ * @param size buffer size in bytes
+ * Return: 1 if there are only patt bytes in buf
+ *         0 if something else was found
+ */
+static int nand_check_pattern(const u_char *buf, u_char patt, int size)
+{
+	int i;
+
+	for (i = 0; i < size; i++)
+		if (buf[i] != patt)
+			return 0;
+	return 1;
+}
+
+/**
+ * nand_write_test:
+ *
+ * Writes a block of NAND flash with different patterns.
+ * This is useful to determine if a block that caused a write error is still
+ * good or should be marked as bad.
+ *
+ * @param mtd nand mtd instance
+ * @param offset offset in flash
+ * Return: 0 if the block is still good
+ */
+static int nand_write_test(struct mtd_info *mtd, loff_t offset)
+{
+	u_char patterns[] = {0xa5, 0x5a, 0x00};
+	struct erase_info instr = {
+		.mtd = mtd,
+		.addr = offset,
+		.len = mtd->erasesize,
+	};
+	size_t retlen;
+	int err, ret = -1, i, patt_count;
+	u_char *buf;
+
+	if ((offset & (mtd->erasesize - 1)) != 0) {
+		puts("Attempt to torture a block at a non block-aligned offset\n");
+		return -EINVAL;
+	}
+
+	if (offset + mtd->erasesize > mtd->size) {
+		puts("Attempt to torture a block outside the flash area\n");
+		return -EINVAL;
+	}
+
+	patt_count = ARRAY_SIZE(patterns);
+
+	buf = malloc_cache_aligned(mtd->erasesize);
+	if (buf == NULL) {
+		puts("Out of memory for erase block buffer\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < patt_count; i++) {
+		err = mtd_erase(mtd, &instr);
+		if (err) {
+			printf("%s: erase() failed for block at 0x%llx: %d\n",
+			       mtd->name, instr.addr, err);
+			goto out;
+		}
+
+		/* Make sure the block contains only 0xff bytes */
+		err = mtd_read(mtd, offset, mtd->erasesize, &retlen, buf);
+		if ((err && err != -EUCLEAN) || retlen != mtd->erasesize) {
+			printf("%s: read() failed for block at 0x%llx: %d\n",
+			       mtd->name, instr.addr, err);
+			goto out;
+		}
+
+		err = nand_check_pattern(buf, 0xff, mtd->erasesize);
+		if (!err) {
+			printf("Erased block at 0x%llx, but a non-0xff byte was found\n",
+			       offset);
+			ret = -EIO;
+			goto out;
+		}
+
+		/* Write a pattern and check it */
+		memset(buf, patterns[i], mtd->erasesize);
+		err = mtd_write(mtd, offset, mtd->erasesize, &retlen, buf);
+		if (err || retlen != mtd->erasesize) {
+			printf("%s: write() failed for block at 0x%llx: %d\n",
+			       mtd->name, instr.addr, err);
+			goto out;
+		}
+
+		err = mtd_read(mtd, offset, mtd->erasesize, &retlen, buf);
+		if ((err && err != -EUCLEAN) || retlen != mtd->erasesize) {
+			printf("%s: read() failed for block at 0x%llx: %d\n",
+			       mtd->name, instr.addr, err);
+			goto out;
+		}
+
+		err = nand_check_pattern(buf, patterns[i], mtd->erasesize);
+		if (!err) {
+			printf("Pattern 0x%.2x checking failed for block at "
+			       "0x%llx\n", patterns[i], offset);
+			ret = -EIO;
+			goto out;
+		}
+	}
+
+	ret = 0;
+
+out:
+	free(buf);
+	return ret;
+}
+
+static int do_nand_write_test(struct cmd_tbl *cmdtp, int flag, int argc,
+			      char *const argv[])
+{
+	struct mtd_info *mtd;
+	loff_t off, len;
+	int ret = 0;
+	unsigned int failed = 0, passed = 0;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	mtd = get_mtd_by_name(argv[1]);
+	if (IS_ERR_OR_NULL(mtd))
+		return CMD_RET_FAILURE;
+
+	if (!mtd_can_have_bb(mtd)) {
+		printf("Only NAND-based devices can be tortured\n");
+		goto out_put_mtd;
+	}
+
+	argc -= 2;
+	argv += 2;
+
+	off = argc > 0 ? hextoul(argv[0], NULL) : 0;
+	len = argc > 1 ? hextoul(argv[1], NULL) : mtd->size;
+
+	if (!mtd_is_aligned_with_block_size(mtd, off)) {
+		printf("Offset not aligned with a block (0x%x)\n",
+		       mtd->erasesize);
+		ret = CMD_RET_FAILURE;
+		goto out_put_mtd;
+	}
+
+	if (!mtd_is_aligned_with_block_size(mtd, len)) {
+		printf("Size not a multiple of a block (0x%x)\n",
+		       mtd->erasesize);
+		ret = CMD_RET_FAILURE;
+		goto out_put_mtd;
+	}
+
+	printf("\nNAND write test: device '%s' offset 0x%llx size 0x%llx (block size 0x%x)\n",
+	       mtd->name, off, len, mtd->erasesize);
+	while (len > 0) {
+		printf("\r  block at %llx ", off);
+		if (mtd_block_isbad(mtd, off)) {
+			printf("marked bad, skipping\n");
+		} else {
+			ret = nand_write_test(mtd, off);
+			if (ret) {
+				failed++;
+				printf("failed\n");
+			} else {
+				passed++;
+			}
+		}
+		off += mtd->erasesize;
+		len -= mtd->erasesize;
+	}
+	printf("\n Passed: %u, failed: %u\n", passed, failed);
+	if (failed != 0)
+		ret = CMD_RET_FAILURE;
+
+out_put_mtd:
+	put_mtd_device(mtd);
+
+	return ret;
+}
+#endif
+
 static int do_mtd_bad(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
@@ -847,6 +1036,9 @@ U_BOOT_LONGHELP(mtd,
 #endif
 #if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
 	"mtd markbad                           <name>         <off> [<off> ...]\n"
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
+	"mtd nand_write_test                   <name>        [<off> [<size>]]\n"
 #endif
 	"\n"
 	"With:\n"
@@ -884,6 +1076,11 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_text,
 #if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
 		U_BOOT_SUBCMD_MKENT_COMPLETE(markbad, 20, 0, do_mtd_markbad,
 					     mtd_name_complete),
+#endif
+#if CONFIG_IS_ENABLED(CMD_MTD_NAND_WRITE_TEST)
+		U_BOOT_SUBCMD_MKENT_COMPLETE(nand_write_test, 4, 0,
+					     do_nand_write_test,
+					     mtd_name_complete),
 #endif
 		U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
 					     mtd_name_complete));
-- 
2.51.0

