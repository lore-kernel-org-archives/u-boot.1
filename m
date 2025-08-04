Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73DFC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 936CD83EBA;
	Mon,  4 Aug 2025 03:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="RJjt9WMD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CC6683E81; Mon,  4 Aug 2025 03:25:34 +0200 (CEST)
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28AD283E19
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8xp1LDqY3sji8HgROFAQZSr/y2YuBTMiSk5Y+zXcXQGptqJyqaJhUQtuHbXndOAztxuls4cPwq4H7ih1qtlE/62508xfrqtT78S84YChM+7pEdAtWbhr81g7NCwjzfzhGu2pJrglaIO8WyyZuX5u5TudZ6Or7EuZXDqbngjPo/ZRihBMp2PwD7gQdZzM8XP/BaWuC8HSMOnRcvDdWS1y0AAauJgT1oxwoudLkaUTWe4OuyEI3BkLSylM59Q+n1S1VuqWvxyC7x5TN6xvsoIzWTrWXqJewjg2tHtC+REF9F0U16B5LwLj/9BQaAaW2FOQzBFsfRIO8USTFQV4/MTWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HO58+V3JX/X+n29MUx2UkLmKq7h+tbgatdCEoPX4arU=;
 b=XAn2CRvmOcHKfC42vjY5EqMFTYO0SF9zSwY1RzVIumiZBnN3lnmumZeQi4LdxXG6CIpAclQR0xKomH6gj617qz/EqObNiCLGvb2TcNOBbgkIJC2BLtyb/7fpcvuhuFYkYoIv/+kHDwHGaNMZxStVCCfAcO1QMmAmwOwFM4SW2YTMuptKhT1ti05DNVjyHpvpLgKj8VQLJSVQhbalc1iouyHiQLu8xVtlxkmJRW8iTk8j3aywOulnQDi3d3tWd21XBUEbgd7U7ngLuUh+WQX18CwzKQaLhPcPOUHDDzJOQ14uPbbCxzZo9CwzzXBA4Qlrcodvqbnu5yOKY93S6+OB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO58+V3JX/X+n29MUx2UkLmKq7h+tbgatdCEoPX4arU=;
 b=RJjt9WMDsiL+bqTzUX6YrZCICx9LaUQtdLK+nsfEH//jyU33ZSZTKp+IL9aZnk3zer2F/xxcqvpR+iR2HDSYqJD/MvI+wwuBg6PrSAMCcloFgbifLH6U8080Qnimva9voR8d3jMncM5YlBNj7Xx5zgXdMdER5j0Rvdt5R3xWZBVzD3wr/ZsetwUjGABXKlIc/CF13V03Qtsg6lOHG+bZjdy41TdiafcyZdlDe6E4aqht6iMu6kRTKPXvYWoCv14J/MjffWhOpgCmwhJy1qZ5kQTwqAvdBlwtaqMZkajX2nhVzHHH6PaoGBVqH4Pjp3PTSOIM/oCLGimAv17jTOa7cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA6PR03MB7973.namprd03.prod.outlook.com (2603:10b6:806:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 01:25:31 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:31 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 24/34] arch: arm: mach-socfpga: Update handoff settings for
 Agilex7 M-series
Date: Sun,  3 Aug 2025 18:24:51 -0700
Message-Id: <20250804012501.21811-25-alif.zakuan.yuslaimi@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4c133b40-7f04-41dd-a9ca-08ddd2f5cd39
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dn8qLo+A1MGPbP4Udi7UpmNTW+yDafJy7QYt5dnEg2i2pnQWrI55hmeLbxBi?=
 =?us-ascii?Q?3DRx3SiNFbTGckfylmiMfVeHTuKhMkPEWVSFzLuKUGGDe4CoBV4pqZBoR2XE?=
 =?us-ascii?Q?1BBid5Fik7Me5ZPFMgHkEmspu+PXnB0Ha6HFU/qEkVzVBFJNmureJ/zRlq2V?=
 =?us-ascii?Q?u5i34sKH2W8Wu5sR7l3mweqeR/Rkys0A90xZZbB4VmwJJkD55ooP23oYx5Hs?=
 =?us-ascii?Q?BHLCpuwUKS9eZgYsjIyBUDg5BExfKUoWphb5aAMeltYhLfGtzsUPABEqeYXS?=
 =?us-ascii?Q?+d0C/B9Z+o8hvqPbcwKSayzxN18e19HgGtt7R/WrWtIWBNP3WxZLmTRxgR3d?=
 =?us-ascii?Q?LDhsvpeM14VNB7kS+teFYJ145HxbqxPARkGQ2iHwqwLeQn5SFafwMnTfWIAK?=
 =?us-ascii?Q?Jn6eSPPxIwNA5Yj9xtZYazmf3oh9fROGmDvd/NH5bFLtPPbkY1e5FMz6uVPB?=
 =?us-ascii?Q?Q1cVNXGKQkqubdnXo7AmsduKVKQeuI7SWOj4/q4NUKEB81nh9GlYorJrTfAm?=
 =?us-ascii?Q?3BSAO94ZCl2Q467RGBs9nI9c/p3xzuW5m6xsfxkl8FxTzsB88AHQTSS8HiOZ?=
 =?us-ascii?Q?Ee/rsnzvSvvbhPfq+zYrnVOd6S5jOjjQnSaZP8VsOze2vvcONi4srPlmAdRg?=
 =?us-ascii?Q?YbMRt3rs6hoAY+2oFxI9lDnB7Zz+F8+rEs/b/STf23tUc2XOvMtG4ktnWmj1?=
 =?us-ascii?Q?7RJCki5g0kbd2j7GF4j+Ycv9nG4t1jOpdhuliXRawmph2PQsWVMFZ+gbnqCL?=
 =?us-ascii?Q?sklTICfwTsUQEJT2ITC1vCfZtcNpFcafGZh9/5RMGd/iX0sdfBh/d1yfU2Hd?=
 =?us-ascii?Q?w+qKjTj681ETYeYOKwsgvO8E8V4yteiCH61WyDTgeyyZ3FWc8mXuGZqab8wq?=
 =?us-ascii?Q?lpVGRVKKFa3hCDG/5DElBz6PQhHfPVyallu7XoqxdTB1UL2kHSgJRQmAstsj?=
 =?us-ascii?Q?sphWvw4++Cfuxkv5JKm1saxx4Ao9uqLu1oW/AdNjk++cv0yn3bIlT1JpJB5R?=
 =?us-ascii?Q?/Ktr/f6M++1fTBjvwng54nGXhnWXtYLLXmstq2+9lTriKVxQXOlW8Y7jAOZa?=
 =?us-ascii?Q?9Cs41aQFn5bEzDqEh9/0ktLuihWLPP9uFVyNVHu8mbEtYCsZrrqzF2aLsBbZ?=
 =?us-ascii?Q?pVUeeNeyac5wlyZ3uPmVDBxV10qsG8963945ThhGFlNENiciO7otf5OWgJMt?=
 =?us-ascii?Q?y9OKifgB4SFbHuJW9BLp3Hv0HQPocoFg6JsCtNUgth1iyCxcxSf7g4pF/ddA?=
 =?us-ascii?Q?nvxRM2xGckux4mkaXKCZdSyRXLLJH/nkotGT+sc4rwvWeI75xLFDT0aPsqQP?=
 =?us-ascii?Q?0r6maSdPJyp5uJ2pbLxjuEiyjA6smQz6uWlnnUZwLeeGKo8nIcGDaqs3bpZ2?=
 =?us-ascii?Q?fX7T5Wn3tf+ISF3RF+7GVMi87wsKKK76sY/hJuF1m7m7izhkMiK76FyGG3hD?=
 =?us-ascii?Q?GxLijdv6T3o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vVB+YPxe3+Em7S3YVAvyzerbZhjYwrYGfpvk0bX4eirRzD0VotQZhnHkZJMl?=
 =?us-ascii?Q?mYfqMrxZfl7Z2aBKjVVUYVWQz3xyjdew6dxUvyinFQTPxirICKJvUxlJkdUC?=
 =?us-ascii?Q?zhd36n2kjPzsjyvL9DuVA9SETcZUupszhiji0tRbx/XAJNY8mrxpVRYA8xDZ?=
 =?us-ascii?Q?TCEjPAuwvSI0ZVavZuxhrsdfS4Yj76LAfUEp15lNYchA0MHH8bseLmKoDMxw?=
 =?us-ascii?Q?A3GXtnwx4yGWJEnkFApdPgzahDXxu9XwEBJoWQo5cRVGDMvw46k5el88HC4J?=
 =?us-ascii?Q?r1HsZNvSycXp5H3iIiwx6r93btr3pFFNpQHtsVbTmB6bxWvFn+MmZWKBeAcI?=
 =?us-ascii?Q?ip26PS2Gq57+oOUeNyLPqnnj3Irnu+pAzA0KtvPCZr0qPw1v9z/sGnjMcC7x?=
 =?us-ascii?Q?CzcSgD44WfFsRYPjCOz0kaG5q2L7TwzJ2QIhxqgktPWgDb0Xh45R5JkggyVR?=
 =?us-ascii?Q?c8T2zd77eGLWmG/1mxc3s8p+fDDCSnXfUsgVgmy4xSR33qiiMbFkgXei7Bhq?=
 =?us-ascii?Q?8Jg3mzQaOeXfqArHqVmRqAhJZYQbiNX/CLFmB6RWX5mWtH9y+Y80H/87cAM2?=
 =?us-ascii?Q?quydShaqBP/YUdwuszBZM/s9yxhRP99W9x98K45FY9FIjk8UV9JWYUYhPKvi?=
 =?us-ascii?Q?m8I4f3mixPKx6hFD/ul1vAfUgf1FmmGmIzUmzeqCHUrb6o3iENKmtfXjxlbj?=
 =?us-ascii?Q?4g2ZZRLcwGsb2fcw28HHsZypXka8Sfc2TVfTBMWDbM4wiaJER2tSW09sfa33?=
 =?us-ascii?Q?x75Tbid7PwFoJykyFBsoVfI3l5bmrNKYJJH+MJqLHpTSBXWP/uLphXu6CWFE?=
 =?us-ascii?Q?4yNiUZqE3iH8ccPl88WEKepvyKp9vsFUQJRNtvaNH/LxypZJYjSXGKY8qtIz?=
 =?us-ascii?Q?U4lXDFPucSe6H6kB/6vFkaWbBpMdgwdcV1+veokA6h8db7UAP1QnWTFK0AFI?=
 =?us-ascii?Q?u3quWhpxfxxiIy0JlS3+wN3nO2pUnAzalg9oZZY0OHcVvdcgBGcatnFZVc4n?=
 =?us-ascii?Q?Y819chj/anrWkW5nm7UE9mbNerIxsidzVnGUwfHHrl3aP0UCAk3C0YHZK3PJ?=
 =?us-ascii?Q?N81p8DIDTlpwYFC+TYqay4OqF4HNQzMtSXqnQnfWvGH+oI1MPU74ArMC+rXp?=
 =?us-ascii?Q?cB+1TqZ4lR3GhtS6k8wBblE1MnHYzbvdUFit2E/MJjGl2d0ZV8jXwoYC8OgJ?=
 =?us-ascii?Q?0JZ4yynzQKAGhKw/yXeeC8fuU3rRgSl3IQBwdWeBURkw0zOKg7qPDJRtKkag?=
 =?us-ascii?Q?FJb0BKdWmv5dvtFZLEfoY2b1+LfukA5Po5LPi1i2sf9JXRZ3s4pHolIPBoN7?=
 =?us-ascii?Q?VFIy3/UJciyKQYm6eI4qCtpuLnf+V2qJKsXouULue8nv3CwsA9Z/sufOkqUT?=
 =?us-ascii?Q?DeghV0PR/ZO2gcUkiU8dwQhAtw9kGUnc8SWNAcIKxSlSBTDNzDoRTy9c6KOv?=
 =?us-ascii?Q?CoKf7IAM/TWTQUkkDihK/ZiA/OfJGKRFbrKsx4xmCmOdmd3VOcsr30uB9DdP?=
 =?us-ascii?Q?6Q5uafsx2PnbyuSbUXPA/9y7moIlz8+7iT+8UuRuQAx0MW94rsEQwM7bKYBo?=
 =?us-ascii?Q?pNVoQbn94LX9rGh/Z3ofuEN7qnuI1raFzctmc68XGFtZW6EDkfmfhIFHk6Z1?=
 =?us-ascii?Q?PmIpIO8Uxvg23niKqbi/tTY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c133b40-7f04-41dd-a9ca-08ddd2f5cd39
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:30.9964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xurVvFtoCi1nljeM4fkkj6cGDxYgFdfPhWLnbAQNieajaTBm6SOdhKRiKuDtA+bwamuZD5j1KHe80PXNz4pIZ1+cUWr4is/RnZoUazfQoI8=
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

From: Tingting Meng <tingting.meng@altera.com>

Handoff settings updated for new platform Agilex7 M-series.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/include/mach/handoff_soc64.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
index 763b077d8c1..d0613074c3c 100644
--- a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
@@ -18,7 +18,7 @@
 #define SOC64_HANDOFF_MAGIC_FPGA	0x46504741
 #define SOC64_HANDOFF_MAGIC_DELAY	0x444C4159
 #define SOC64_HANDOFF_MAGIC_CLOCK	0x434C4B53
-#define SOC64_HANDOFF_MAGIC_SDRAM	0x5344524d
+#define SOC64_HANDOFF_MAGIC_SDRAM	0x5344524D
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
 #define SOC64_HANDOFF_MAGIC_PERI	0x50455249
 #else
@@ -30,9 +30,19 @@
 #define SOC64_HANDOFF_SIZE		4096
 
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10) || \
-	IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX)
+	IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || \
+	IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
 #define SOC64_HANDOFF_BASE		0xFFE3F000
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)
+#define SOC64_HANDOFF_MISC		(SOC64_HANDOFF_BASE + 0x634)
+/* DDR handoff */
+#define SOC64_HANDOFF_DDR_BASE	(SOC64_HANDOFF_BASE + 0x610)
+#define SOC64_HANDOFF_DDR_LEN	5
+#define SOC64_HANDOFF_DDR_INTERLEAVING_MODE_MASK	BIT(0)
+#define SOC64_HANDOFF_DDR_MEMORY_TYPE_MASK		BIT(0)
+#else
 #define SOC64_HANDOFF_MISC		(SOC64_HANDOFF_BASE + 0x610)
+#endif
 #elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
 #define SOC64_HANDOFF_BASE		0x0007F000
 #elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X)
-- 
2.35.3

