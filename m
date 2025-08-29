Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A993CA0EED
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 03:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA08D83443;
	Fri, 29 Aug 2025 05:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="VYimOdnC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14A6083447; Fri, 29 Aug 2025 05:43:21 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C99E78341A
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 05:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvD6SBGORjbjoY7YnBNNFpTLTm0aMV9CHQPprPx7njfOcwYaakEATY5Gp/T9Wbb1ShOlYHE9V8aRYkNOuRuG745HG3Jq3ascLeUCGNbML+N8G4DhNygqkTtAkkFl3F63/gF9SkAVJh8V3sOUKB5woQMWTEs+M1dVmG74/Zsf+6E1nQtqH8a29oXtiZaE33Z4lQlAQ4O45W9MzNqourV0GAG+JcP9FxlCmSVBCZLDBWT2GVccbkZv1LyXP69v8utInIM5pCHrdAKFWPIEujfjGm8QI2A2isOuV9S7n2ozIEfe7AfjuuP1hGOMOyudL5IbdJH6xqFJTYRoqha/EFRb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPFLRDBbWehZFDdV89+bdysCzSgntdk8HR9gthvn4iE=;
 b=rD+JEM2tLhQ/5SnFM766yZ6SXHgnMAKPGaUIzpUllnkz5jsWpyPrvLhNv79pmABMgpPSMCbLKKF/bwlscM/C8/pW0u40WxBuUrpJTT5eqGzIuRH2DNi5eakwYFdHyfGWoOoMKvJBdo0prtlDib1admzo/rQlQUrCREONVxOHkihPfWvWHCKw1usTlXoxHZD+A5RVgZuxoHs6qJV6y2qbS2TshdVJFENTzKNMuiDXmrKUtwMl1WthVw+Tbt4tY2ldmCiBc7TVexvDUDL7bkQZeoqyz+B1e3htqdaWNt0KKIlLUjHQHdU474NhwwJjVEWU/MJs7vBCSyvYgKukg4dQjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPFLRDBbWehZFDdV89+bdysCzSgntdk8HR9gthvn4iE=;
 b=VYimOdnC8MHXo59j6NUYTW+GKziGbukwkPfg/cI25c2htQ1MEA529o+6fiu2vvefiej4k0aI6n69y7x9j3TxD5yFG2BajOwjcpbNukuMDt2lTOPIFWSdZGmqwbRNa38JN7AJREdgGx7okes36DVYeYDFDLD5HU3ObQ3s3u8qzEl8y75K5CXu3hm7cmnLJkQ0ewqCYeyj53GdqyxJggKIhY8+TePJ0ZztYmY07eKPapx9w6FjObVIxv/0l/oG5hNAHKLBDsHj+mUehK+qcfFqCkuJTkwCq/wX26s05lIxY7Su4zM8HBTdXltmpEPAVK/dzijOmlPjVmgGBpi7kI7iEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ2PR03MB7330.namprd03.prod.outlook.com (2603:10b6:a03:562::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.8; Fri, 29 Aug
 2025 03:43:12 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%6]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 03:43:11 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1] arm: socfpga: Define Use FPGA switch handoff section size
 for Agilex5
Date: Thu, 28 Aug 2025 20:42:59 -0700
Message-Id: <20250829034259.27848-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::11) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ2PR03MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af386c6-33b5-492e-b87f-08dde6ae2d67
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WC406SxM3IVcxAy8L3wq/EM3Imt25kp/gzGMZxwNbOaPf7XWXp+YutwG/HLK?=
 =?us-ascii?Q?B/IWrZ80XQ+FKMk2cJDYRwsLRFy6A/vKUl+iBGqGBD+blrBRxx3WHO5P1xQb?=
 =?us-ascii?Q?rjBO4H3GP+kQs+FvXhDOLAJcIrE2aWjM4BQPPf39xlNvb4fHqI+W38R+5EDK?=
 =?us-ascii?Q?CQmWKqKH/JPxBsESCXirvFp9J26rBu/vlI4qOj/9fltjTaP5yioeAQzO+rmo?=
 =?us-ascii?Q?l0c1kf+8DcoHECacGMKcuO7UgFeoqHtgAwhZ7cyhSzuGvUTUX+lEpRx+QEOM?=
 =?us-ascii?Q?jHDqAmzLWqpwzgboKpmUoTWvgieWO/p+fZJh88ARu5hOOQgZ/T0QKQYUWJT7?=
 =?us-ascii?Q?CwRU/aOc1dnCNc9DRi22VEwaQGd/wFQpO15cPfti7w85C3lvP5LR05cB2sAL?=
 =?us-ascii?Q?ttIgbNW7+AlWsBaCvvS5eC0H3EGbmTirQTMo5yF5y7vtnwirm2V8pahTF0qX?=
 =?us-ascii?Q?RnAI0WsHCGbw598vKyweergo/F115YvpWIp/Qh9k91J5E+g1/T0PdcdD4UqH?=
 =?us-ascii?Q?f31mMfvR1MUkxjKTl1/RiqB7wf8wPFmOQCqx4tiBUKCyAwN2KHgdJ3CQPbmF?=
 =?us-ascii?Q?KlS77L5bj7RPihsP6EpYXK1CaZzpsGdcHJuG7bWaht2Cjy4amAcwW6ZWw4z8?=
 =?us-ascii?Q?aI6pK17PX3LyTrfihnVCe7horacXlsetHwrFZP4MsKzh2XNgDRFKYYdhAqUG?=
 =?us-ascii?Q?ZyrHwkrfmaSClZVAk5BbrZumFeFDgkNohrsyLLiKezEnw8W0vrnXWs/oyhhL?=
 =?us-ascii?Q?hI7W/epTE1YQoFiPIQ/mOJBnibUh9bqUKJvQC7yMibt39WdpkfEzS6k7bioU?=
 =?us-ascii?Q?p2pMIYFY7RqT50uyMXgch6HorxLayAEKBaeMD1qhDqgFjSDqYiYUaBqGm0SI?=
 =?us-ascii?Q?g/a36i/h7zEW20AIgLhk2o/nH2hbFYnNUMCj4iMiAqe99LZxTkUyLNPcnRke?=
 =?us-ascii?Q?cGTLZOc61f5XzaRU+u6dkWPUpGzvvnhx8Edfxh1ioo1EMgQRzU9tLs+UefL3?=
 =?us-ascii?Q?BglKN1nYufHtquSN3qWRxpwJf+lj9Thf/PwpujZfxwa0ujS/5u4DURwoQfgH?=
 =?us-ascii?Q?8yXUZzvSekXAViy/Bl8tjQCspu7KYPT7r2KOk80aFs1dovylR0WkUP0ALM11?=
 =?us-ascii?Q?fYy80GPbivp6FHQRp7HFf89rRQujHVOLyAAVNIaEmmZHYYrboh6YUp+NY9Ma?=
 =?us-ascii?Q?Go23DQK6sDrgiejgMM5tayABztfBXnPKnJ7VKg+S4Xbmr2ZyUlt/zhAFanPT?=
 =?us-ascii?Q?FqVtacoWDU0KMwBjsj4VhOgYenDSYj18YvI8vcJmEdGEJvOJSqN9loXr1dg4?=
 =?us-ascii?Q?E9aN3otaKcphCRyGLUHRxF9lni5/XeoiIJmGYKS4lWJfO9qapikk5vuBPa+7?=
 =?us-ascii?Q?XqdEFBXLUNGaLOuR497tx/Wu4nAFaBJlzuFWxcCGsIwardoR32ZlePyAheZS?=
 =?us-ascii?Q?J+AttFNw3Qw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zt8hNkSCEoO9c78dIo0pEPjrCPDahfLQ5QV4Es3BmPIMVT+x8d0yuV+nSmlu?=
 =?us-ascii?Q?znr5l3+5TFyHPymPjMTFr+/amrUk8qPYba9Sh6ZQTwqYbB3UShRe3meTon1s?=
 =?us-ascii?Q?Hxf+XSZ6QHHO4MdZIHTZtBBQoBzH9922JkTpDR/l3Cyjj9U5tQshQIBek94i?=
 =?us-ascii?Q?LmKpLqlHQQmCji71SSEh58L0M2jXomziiGs4Jl5ex2eXwY6VLaNgDVtQ8a+1?=
 =?us-ascii?Q?16xNA9Hl2N/MOXzrNiCAlRqomuaU/acz1Dcv2HTChiGMMcuHMHegsY7n0aLN?=
 =?us-ascii?Q?xuIl8bndNYN2PAkbglq1ht7MWTPYTZgopSB1Mb2aW6pB0Cpgv3fzhqLLU5+O?=
 =?us-ascii?Q?CrTM9zcpwAfDwoj6fyBWS5D9rQrp7dVVtvovq0LoksYFt+qvZTUH2vM6ScF+?=
 =?us-ascii?Q?RVz34id72a7CQZlZCMo2EIGRTKU5Pvz4rsuhUB8wAYHgmeY/5YYn7LY3VIl1?=
 =?us-ascii?Q?jalrmZKUajBsRt28+pi9p9c6nS3Ej+Z9liTdDKSdcktC02E9Ct650xOr/7wq?=
 =?us-ascii?Q?eMxl6gRRHXFQz9C2NgVyk5Qsjnm0nDN8REz/zUGEzEQXDW7W62q2nl+BOpa2?=
 =?us-ascii?Q?oD5o4gYKPD4+fAOEHbrvN/8SPOoGS6Ecu0P2N9jlG4NbVWSVqzH/lNRLTNJM?=
 =?us-ascii?Q?tEzaqctTdDiofQwowXm/dFq7L1ukGKhcNdEjKzOhka5Xyz19Ujox7+47XFZp?=
 =?us-ascii?Q?nSIyB15ziRERijx4pKSx/OtAElz8WdsnZumGx+fEH//7Cdgxo+H9l8YjrTO7?=
 =?us-ascii?Q?FFyocNipxSaTh5MpAXWKeuQTF+ySYLzkMuodiKhyqEKhojaVE3SRwWx9aFiU?=
 =?us-ascii?Q?TIGEk4Jceh/XlIUs9/zhFBGANQMpIzt6hXFX3nh0DCITgeDr9jCBsIsa5mKq?=
 =?us-ascii?Q?rMVVOkloj9U+4WSBWPHrPGxcTR2+VweG57c6FlheKhRxrlAqRGTk4RAl3Pyv?=
 =?us-ascii?Q?xJulY7cITIiYwC0jGZWAhBd0uBGLu2PEoCjK4117yUrM3uF/etNXmJCxCyhF?=
 =?us-ascii?Q?i/QA0kITNkS1itM0GsjQ3hR2hrc0kvCdGkeqzBqIODg7uJumgYqbIr7+8atE?=
 =?us-ascii?Q?IwQQ/K7yxkVGQKeXOzEigWpi5NbaFmATX07bTR0RLAGG1P6IKLnTdaVR7c+A?=
 =?us-ascii?Q?HZUOoZWSfMMH9IHa6QtDdnSTahamPMMy3YUj77yFJ1bnHfzuX7Agc2YGydD4?=
 =?us-ascii?Q?T4eh7C20Z4TTEJ3gdeBBbUZ1ycQFqnaTz+je/xjZWYmQwSTPYJWhu5FPtPpO?=
 =?us-ascii?Q?fYOt7Hve8LjnJEmc6gyjucCuO1KnGNFq1eHcu+hYob/uzyaAh0l3LpcyrlEq?=
 =?us-ascii?Q?y7QvFklhPOJmSnw1dyjCuhGYkYuA883On0FUPigIX53g1iC0UYyE0ydXHGPi?=
 =?us-ascii?Q?c/TkGxgW35dPdql0amnhOa2EoRZOxK3HXks2gsjHdAU6rsH42uL5LhGaDO5u?=
 =?us-ascii?Q?BgJlu0mxb+cuKZE0OCLut0jbvu7/yYN7DA1SgfT/VjW5L/MYp8vfYXS0MCpg?=
 =?us-ascii?Q?c6JKQf4cWF3GL/29ziLWj4tF1M3G8YjtImDD4pyBttWMXHJ6/1UgcaNbIUF+?=
 =?us-ascii?Q?pedF/MrtyT9fsbcQ+HG9dWn1ooWLHxK0/QTN2sAI4SWNf4QozfrK8XI1uvMH?=
 =?us-ascii?Q?yiljmAGiSNPpqm8/IgA4aKc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af386c6-33b5-492e-b87f-08dde6ae2d67
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 03:43:11.9218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YQYbAJcNYl0e1mwGydfVWymsWuEYLTxVWk8nwyWWqSKX+1tFLngsoYHImLPPqFAGH+kbOsHAJxE4vBFaYUPkgYQRMcuhQjtO8x0R3F/GUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7330
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

Agilex5 FPGA switch section in the handoff data is larger by 32 bytes
than the default value as these extra sections contains I3C0 and I3C1
register offsets and values with 4 bytes each.

This requires 4 more times of reading the FPGA switch section of the
handoff data to fully populate the handoff data table in the memory
during runtime.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/include/mach/handoff_soc64.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
index 9ef82cf46c0..b8f2f73e283 100644
--- a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
@@ -98,6 +98,8 @@
 #define SOC64_HANDOFF_IOCTL_LEN			96
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
 #define SOC64_HANDOFF_FPGA_LEN			42
+#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+#define SOC64_HANDOFF_FPGA_LEN			44
 #else
 #define SOC64_HANDOFF_FPGA_LEN			40
 #endif
-- 
2.35.3

