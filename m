Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F541C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F216F84A04;
	Wed,  8 Jul 2026 14:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="EVKiyNWr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A567849F0; Wed,  8 Jul 2026 03:13:07 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 104A4838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKqZzTz05+OIT0935ETSHxquMjNC5oO1gCnZsZ8wJFfmzIhOVaEBeBBwseinFMurSZAlZ1JaSlGc17FbTrE0ldGFXDUBm99n1ERIEkNV51JPkQX6lQVe760zJc3DJNm8p7KTRs2DLf1KIGCr7KuDvHbbwpHlCG2HNrVQdw99evT1flUW9L7E0RnLSAFCGa3QYru1Tks0n7pPWtgG/ZGwZlK9bJ86FqjtYBFQu6m0eTONsv+2dULrp98NGFXUETUicM9VzE1woXqhp8kl+wjZXMk/3pMOn7JprAg7w4BQ/t7rkf7XoZD0DyzQU0OSjt1x6EsN7VEYizz6dberp/Kf+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDKwntztk2qhJBkX+VX4EQCe7yYX88AgI+vfsvAQXlQ=;
 b=JNCkcQA1AQ8ZY09YMxjmtFHm7SIy6dUDJqU25HaZFDjdSI2UYwPV/3tbR2jJwdsIbRFA5IT6lmQXVB88hmbDinTgadVnB6pbcJJEq8N9SM6Q75eGwei5IZ7GnqRH1+EgZXu0zHtj+cW5/IA39eov89Sx1d71uwh0XKxU12V9AToK3/0POtPBXPdSIYe/+mBVxeLaLGMpBY4OJmdxEiP6nhdimDWAssXJxVTStjKjOQjpz9WZDbUM2wpcFnd0s4oqQUuy8EyY6ae+yX52paRjCc82QhmVFiNDjAhJ9SehruM1qqH98C36wjTIgIzlRg02nLVDs4+kvxZVsVkFMHPhRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDKwntztk2qhJBkX+VX4EQCe7yYX88AgI+vfsvAQXlQ=;
 b=EVKiyNWrpgC4ViT171qYk70fv6YW3GHuOsoL/JWPBmJ4jT/R9+ElhaDVK/LRThraZgz6pHAVhE6fBozTUhWL+ZyDy/BTxxmWHS1vro+CzQo+yn2YOCmuUMYB6VIhn9kjxEMuxLJBqS7c4P/Ut+jHmJrqkn0UX11Fns2ThcRD1MzDL5mQVkcGRidhCbDWbPIzwZ2Ip3fkYK+d8qgKnuTs4uzTgcleebBzPH/RAKJYAVCtNk2J67Dh4KAS86s4+ER3xrTfmdcUgLiupJvR1vfDDGb1/0WzGMds73Rq8aatf9dITOHWunt9D9iKeR0TFyprRR7AVd+bPBekEFqShB3JYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW4PR03MB6473.namprd03.prod.outlook.com (2603:10b6:303:120::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 01:12:59 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 01:12:59 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH 02/15] arm: dts: socfpga: n5x: add DDR retention calibration
 backup nodes
Date: Wed,  8 Jul 2026 09:12:15 +0800
Message-ID: <20260708011228.15613-3-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260708011228.15613-1-chen.huei.lok@altera.com>
References: <20260708011228.15613-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|MW4PR03MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: ea164003-348e-4ddc-15ef-08dedc8e0c79
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|11063799006|55112099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: PxlI1wPAmv8Q2SD70AkxJf317ckgXUFdEIsFbikJys3rsPLYtYrlZA0cKw0lbBH/Gx0x7NYQGv8WlvjF6+yatgtAUYe1glsOl4eT7aXWb2sV1K1Yh0iQvvgOmEXyFglgz0pRePyE6FcLcU0Qm1P3hOe30fyNexxq1Tyen/X/0NNuhxRd0NStc/x5Rq4ry79N+XndlskEkU/pSoiMCMArqHHuszmahDt1MtH5Q11DSw9CNyAIZuR3Ydh8RwbtszAKm6n/KcK170Qds3J2XPfpmaLwOezdnnZi7wMQ0rx+QCYuUay/f0fjWdmynE+eZuUL5IESrHYuAFlO+Gpb1yh0o6L2RSww7gdoLBMJv/KPVVRZiw0UyMX8naGikZZuiVzkUXOrxUhqBYYKlr5Br0WP3gGVJZYrlqticV1mI6Vs33+y6tdfTFmVwXJ2VFkvghkGLFcB6J5+aT4SLksA7+39I/zIS/CLzbD8DwVGdGuq3//biQZbzvLayOE50qZ5aQtc8ufWzIbASdXOz6FuDfI5hMFUOflI0yfcPHy6w5XkokpWoVhOjTdsE9xkuIWdr/3rfd0JREMlLIuywWQFTVPqoyR9mo+mtTf98Xxd7JrojBZS7bCkV6sUupUfvC/yoH3ZEFmmgw+qK0aAb+eTuqbqae/YMUsy5QqWWO/Pwi7L7Fk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(11063799006)(55112099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ARJCvxdC2FPcHOGwodOUnZL2k0ic6+tRB5lOH3MvoG83O9Lu86D7mjbevhX?=
 =?us-ascii?Q?8j8cySHmfAhOUimy58/np3SG9ZOkfQ77kI6dVhTCNLwjgNc1R2ftt7ABJ0hg?=
 =?us-ascii?Q?soRNcPVf1ZpjifO3nxDpeBzp8/zjLrl++4c+sNpARzR/jNELlHmNg8LCu9OF?=
 =?us-ascii?Q?d+PHlsJiIPl3UJ9iROjVesThzFOGvki3sbZR7jPD3451XhQdGuoos554d2aO?=
 =?us-ascii?Q?9KS1cAweMLLCJop29W1kXunLTsK1D5ZgqrxiDmoFroQJMFhQ1fRJ0eFjZqzk?=
 =?us-ascii?Q?/9063tYjtxqk4Lg33Ork+wVeoKVhUzpn1j9YXLbLYlZs8REm93UK2xDXyaYS?=
 =?us-ascii?Q?9edK51CqAiPe1ZN+6sEddY89+tN4OG1shPpuC4BKy7Q3xvWtiWkPiulB6NG4?=
 =?us-ascii?Q?YoW+gusdcOdsM15285D6z7K9CKVAWPCVLlYrUcRs4AfsACsqvBankxxyDq5K?=
 =?us-ascii?Q?/oMRsE/csnC7qHmVpFtLkRCcBvBK0IRGjlHwZduAjgZMynURoS8OiCYIjA7U?=
 =?us-ascii?Q?DP2WEPUrW1RG3DgXtP/DbTi+pbfzKbcjdSblX4ry0WoSkh1Im7ug+gXVSL/C?=
 =?us-ascii?Q?buWd+qM74kiPVu9LwoaNomLq7Hspw/T/Ff+1VVRgf2nHAkl6KRK5Rx6w5E09?=
 =?us-ascii?Q?Wfu5o9s50P/cq8xn20CBszAMbwODvuUw5o+FrkGe9GW+RSG16L6spYg75lcV?=
 =?us-ascii?Q?9+urD5Ibt1awviX88SkKD6rWusAmoxte997xyTmREM8M79KDgspYDOzKB7pt?=
 =?us-ascii?Q?EzRSuFJuGyfBh+b1o1YaucXRzrZbuvBUFXc9iaUAMxp+q1snXvKoym2xCvnW?=
 =?us-ascii?Q?c323nm+52SO39IJsoEAsusNCcbZbg9JcXT5DKzmLzaYhD+WdnH7feaZe7IdX?=
 =?us-ascii?Q?mn/bBd5oASncw8xk7AvMGzzwI4jdmHYy6C3oDZzLJfCt1Ub7KNcbzrikG3Hm?=
 =?us-ascii?Q?ogCA6zyMgbUUhy99HRsLYcSN0IrNXIsBbg5D0L3QHRaaFJTVneKVFPjH2blM?=
 =?us-ascii?Q?8A0JYCw6Tth8ae7j41JBHL9FfLQmz/LYT8TM/njhfpP8yuq2HqPUFjI46LXt?=
 =?us-ascii?Q?SoPsKub90vPV1K8WXIELabZpGnbgW8P04LbTablQY0Fylsopmo9SrIYSBPDp?=
 =?us-ascii?Q?CYpprMDXr0KYr5y4LXIMxZZOB68eTTHW0WxC8Ao0nikRtYs6YyHI2d4L9TFW?=
 =?us-ascii?Q?eUxDI/TWtdvmRRRde1AwfqqaKnL81rnR8UE8Mp6KAL21qGOdxADmw1zbfO5c?=
 =?us-ascii?Q?2q0mV41n0H69TtLeszEk8v68H8VdqxeMi1WenQF0SR8q4EwnO4UUZYD6RoB4?=
 =?us-ascii?Q?p8tFeKldyzchHOguUVh4nSk9UPrG37L0NyLBtkFr8F+JymUlMwCK44QuWr/D?=
 =?us-ascii?Q?h4lhA4aX+lY5ozS+VyyZA0xAWhUksTid1bTzOC6/MUqxhlGVeZinqS5nLh57?=
 =?us-ascii?Q?WKAqGpm9ETF6K229+xIXJ7p/VzpcGZzt/ehKHxu6SSIjvdvziFl5P4AgJOm0?=
 =?us-ascii?Q?hvtz/ZiMCVqo580tXxilsuQYEOBHf3E91QxO/cxW/Ju5RAtuHuADJygRFL4u?=
 =?us-ascii?Q?pzdsURpWV4p0uJTMbcXZQubtSIpeqn05z/7GcHayB8vTJ6HvUSTy0J/2S0Qm?=
 =?us-ascii?Q?V6SVWmapr8KFa0LhU0p5I9olSJI1W3neg+Rc28GL+TvY969yePZfUNVyJ1+D?=
 =?us-ascii?Q?uwitQKQIuRl0ACFuaPVIIxHPC6nHXEbJCTZRMVM9Mfc+5A5Vnvc0v0Wr+ZiK?=
 =?us-ascii?Q?h9QegahO66Gg/2p//0Z9IUGxV04gyNg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea164003-348e-4ddc-15ef-08dedc8e0c79
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:12:58.9486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLs2b6ZHxjR2TJTpWy/eO9SD4nAY4EhgPloaJfTnC0PlEmntB5tNFpLFMUEmwTpeNGNGjW7bEN528ZNiorX/xbF33mfgrnXDyuDLlBxm3Vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6473
X-Mailman-Approved-At: Wed, 08 Jul 2026 14:40:34 +0200
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

Add the device tree nodes that the N5X DDR retention restore path depends
on. Reintroduce the fs-loader node and the &sdr DDR calibration backup
properties (firmware-loader, intel,ddrcal-qspi-offset and
intel,ddrcal-ddr-offset) that were dropped during the switch to the
upstream Linux DT config. These describe where the backup calibration
data is stored and the firmware-loader instance used to read it back in
SPL.

Use bootph-all in place of the legacy u-boot,dm-pre-reloc so the nodes
are bound in the pre-relocation SPL phase on the migrated device tree.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
index 1bed87c1231..6f7d6d6b188 100644
--- a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
@@ -8,6 +8,12 @@
 #include "socfpga_n5x-u-boot.dtsi"
 
 /{
+	fs_loader0: fs-loader {
+		bootph-all;
+		compatible = "u-boot,fs-loader";
+		sfconfig = <0 0>;
+	};
+
 	chosen {
 		u-boot,spl-boot-order = &mmc;
 	};
@@ -36,6 +42,13 @@
 	};
 };
 
+&sdr {
+	intel,ddrcal-qspi-offset = "0x7000000";
+	intel,ddrcal-ddr-offset = "0x100000";
+	firmware-loader = <&fs_loader0>;
+	bootph-all;
+};
+
 &flash0 {
 	bootph-all;
 	cdns,page-size = <256>;
-- 
2.43.7

