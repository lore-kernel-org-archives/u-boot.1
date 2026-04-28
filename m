Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B12CFF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E03B384686;
	Tue, 28 Apr 2026 09:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="L/MY9R/4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 911258416F; Tue, 28 Apr 2026 08:50:35 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D86C83BC4
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 08:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QndVfXtTSxTKnQhrUmjzyFkHk0Z/Nm3hBNSVgtm1bloPvGHrUHc4Vb4ZzxQbEj9VkRDIl/Dframk7J1c6xI+K3y9dxyxzIEVrNVhpGYRyBdmFTciIbmxPYd4zWeuoJfFOE/ys3hpy2ehSP0gAQrvb219L2YLmNob0TpfisLS1ehJ4YK/lnOVZ0R+4DXlL9DlqKJabiSdA2II1X3DN6IYl7Al0PTW2Sb3umy7JQegyh2n4IbfmAGz3hwKbZbS7Yxt5Pqb/3sFqu7NTFjDuNlou8yBAOrnytmxxHoIFVaj+Wa3g+C+TMxQMRjr0dv2Vn4ODLfzJr//f6E343qbvto7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ej17bh3UtQ+A9Pc79SOohWRNv9uBxh8hpS/wFeUcr8U=;
 b=rRVsGrjYbo3TsKylcifGQqSdgEvc9DutejNcbfSPsp15r6LUOnFbT7QUgxppw7X0U3Z6Ol+IPMSoS1KUB889lmdMTl66J+femNqCSbwzXRT0oDzOkUBZjikLkoBwwg7ApbPcZh9yids0MN9sQ7dxQuRHxLGy/9qDi8BYuaeyNvh2h0quBQ+09nFCkLlwjVKYMQTc1voS3JXkmJShurvQ43hFnb9pw9lGxpndlRmha41XZ7nNQvLPHzJY7Gm3gC+zzbOydlrSUQKlGlRuZEqBrboi1353OQsPYwiB2hti7PiyzHQyiu4J+VhEwGJholOwCa94YdBKaT3PYN9JRsn4qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ej17bh3UtQ+A9Pc79SOohWRNv9uBxh8hpS/wFeUcr8U=;
 b=L/MY9R/4QBsGSwNC9na4svS7k9ogfgxhT/DvlQhWFKbczDVTJaoEMSoSu8Dflc1varmiK08FS/NO710NXZlZgkJSGvw70UIKsA9Aeo1xBolLdPFmA4l1HeCFLTH3PgDKBf0Q9CSXZKenkFQZ/Fj3FOTWz7GqgiGn+6fRV92YL1v7JaOD0kzzG50WTNnHIUmqj6ah8k7vhbbn9gxHaJbVugqpw32VZ3/nwWCeXQyMSLjwmFp6AFVSHmxIbZiK4bysWts+J7K9Rcy27JcqcL3hugnhMbOI7enYwyUuTRlC2OXvLLV4xNlk4v4O7Kt/6725Lc0kufJfv9mJQ0Kb8ctwUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by BL4PR03MB8038.namprd03.prod.outlook.com (2603:10b6:208:58d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 06:50:30 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 06:50:30 +0000
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
Subject: [PATCH v2 6/8] arm: socfpga: n5x: switch firewall setup to driver
 model
Date: Tue, 28 Apr 2026 14:49:50 +0800
Message-ID: <20260428064952.3965-7-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428064952.3965-1-chen.huei.lok@altera.com>
References: <20260428064952.3965-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::23) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|BL4PR03MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: fb0b71eb-d040-47f1-361e-08dea4f2700f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: byVUk17lis1hxQ5Sh6cN9sOaOvYS0y0gTNONYTNZ+RssQ00zj9Y7xDo6B/mx0cT4aXsDs+gD3Wv6//0msAQAe32EMRrV+nk5+bJ07YH39sFfrvJdFMkru7SXv/DYe63JiBYCnKnIxctTmABjpUgLSQDlO2useYXn+JVkAhpZwjfobUiyBytjUOz0v3wwriHfzjkUjU3JAjvj5+lA5Kz9FgNxJHtRnw/cIcbmCVhuhFbab/Bd2xy22JFJW3AaM+iuumN5KimIxmDMBTcaU3orAwCnyeiO3BbS3P72JwF729rCmJmIv708EGw2TkISjrOgU9MTgsuKFfUDDQ40EBoafoNYhFBySBPON7jngIVWLG67efuOVPaslSQeifK/mFgRxDzg+K8bM5GgIUM46U80XopZLn/xRl9KsAMXJGuh2bBvro1FQZNdPrIAK6tPTKvHACJicDXxAI12Af2utD17UDgxJr9q4yIKa3H5n5TxukVKreBQ0kvoR4aYFi5oEbZwj2KD7g4AOagF96NJwEbMRusfS0yrn9efPc2i7Gukoeel346n1AE7GRMWWjxkj6UI8ow58SPVuLDA+FOhCl3g4Y40hGFifKYLt2vHz9+fT1BdyDT33ilNsaKCQ7RBif+jtY023xNETwLmwm5NGPJJLD+tbQ1LYnutdFXePejxvfe61PtBd4lzzE1dlKpDrOFU1hcQv4JnhrHSPk0h8ouq8LYoBNmDbdug+sBBxgWHFAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cyjvDolY+y5YhKpVyyqmU1/ke8bPS8OmT4TTRp0ERJNQbpybxGpst6biJrxy?=
 =?us-ascii?Q?7dzTjY78dEaEdOQEw/kPXwePuSmFbtpnpzTH9SbXSlEd9QO4jvUDfJAHgQHZ?=
 =?us-ascii?Q?0d/Ume5aBmHq6NzeHPPtIDJDcx88sfsIHVvtyGuyvWjCw6rVU2wLWLGmF9Q4?=
 =?us-ascii?Q?+MHlHovP2aQXeFoO0g2lPWiu7xM56BLorP1swDPWnQha+i9P9dMpCVCRLMPx?=
 =?us-ascii?Q?ohxSbS/2VxBOblk4bnnLMcSarseCwaJ54msgH8zRQqMg4LDyatX+uXNIuFim?=
 =?us-ascii?Q?lM2W2l9HRonzkN7/34389GuY9Sz3CJsXrjJ0mz150KpfyoidG8E7rqQBzbJC?=
 =?us-ascii?Q?/VH2FG1svLzsweyOQmqxWgNKNOujT+bPvh1lCGxDKnpUVAUGKt+xhHv2Nj1T?=
 =?us-ascii?Q?f+ELQ8csXFLpCWzKVXKj/UbehrRzAGK/yI02pswauTBISmAuSCqjRFmZbdbr?=
 =?us-ascii?Q?8+nKeAHwhVF01DGFhRdolqTLp8+5Dgm4TCU2dnZZoXTsa1TPvFKeNixupxJn?=
 =?us-ascii?Q?BxhYGdTFUe5oJTMHLZiZsvcrW6MI48xSWZI4P3AvVqn+pfLLmiD5hjoR769S?=
 =?us-ascii?Q?fy1syWHkmI0VSzpZ1CgcvNoCSa/69/h6pi7fZvDbl1ovbItmlYSc49NPteZ1?=
 =?us-ascii?Q?n1+q742wDbaYm6o2kIitKko2OdXsGutRCNZno+Vsns1SaBUYHfUZyVPWBfex?=
 =?us-ascii?Q?Wn9pFFFv8r59ngrcBRD1wqMdx5aoiUXaklt33QPQpGG95Df2EcolvUXTCFMl?=
 =?us-ascii?Q?TR2MH8bAf26Z2URQGeZCpuLPiosEwGgcilBa9L4j6MKW0af1h0Ce0zIH0Bir?=
 =?us-ascii?Q?PihWaYrlYduCLC+W49w3CKtXLfwe0HsLFbNxnXrrDns3KoD54fi5rFt9axS6?=
 =?us-ascii?Q?KFngi2IeLLC8Pg33eXkjtGkD3B2KGG3AiuzQHbNU9PF8jUXSNsS3vLtFnO4t?=
 =?us-ascii?Q?OQodY41a8UpvfrjuKf29j3/DVXE+VGSvAeCmw1xvsP8CMkXJLpxqnZoD/TEX?=
 =?us-ascii?Q?bT2mN3COcUTbgQTiaYIwG7/OX9JQ7u5mDd6E8JbuiJbEYfDDhX84t3TwJXB/?=
 =?us-ascii?Q?zSenNHkr56sUxDuOaeW389UgrHagPODkjVfB+jzzA5SsBq9vwNN3ldtRtJM7?=
 =?us-ascii?Q?6nRGzq0RTIy4Ygc0TMe9Yp8usQC9IvInhNXi83zbbSvXjG3LeOP8Qgq5BxD7?=
 =?us-ascii?Q?P2flE/RzGhlYpsK31ZmH0NlKCTB/w0/l6zZ5omyUJZUCK1GFP/ILAJFJXeuE?=
 =?us-ascii?Q?7X7GZPwNwgJk5m3w5485uyfyWxc/hStSmvjWpx6AUUGOTg/SSvI8n1/sLZ5Q?=
 =?us-ascii?Q?B7hHSe9BVCdn1Ts1ZQ4gwAHCSlLXwSXpojJwKh9RbXg1S8QfXP5PyulbK4GP?=
 =?us-ascii?Q?w+8iq2tXJHO3onSw7eLO2JISPZfske01y61qzRUV+XlY37ogQTy3u4d/OeaR?=
 =?us-ascii?Q?rpRU3f3k2ExTKDk3iAhRCjuUqdZQ32gE9fm8YzpMxQiZKaTQ9GYP0xbUv5JI?=
 =?us-ascii?Q?55vxqjGq7MPGCnH3P05Um+4K+JS77PBPSpltRV0q6Wk0Gri3O8JW4mZooifX?=
 =?us-ascii?Q?PGHbc+U2GSpePl3U0aNwLqOPIEy81PRxW7l7OvyPSRuhocN6KyApieDDe8s+?=
 =?us-ascii?Q?nMRd/wC+HDRaHzwE5bNGnklxn2sgsMGBZoytdXZVgSv/iCjzic2NJqHcorVy?=
 =?us-ascii?Q?5iXpvl7NsXVEfYRT+UEO9MMdFkeZ96nScXXRW07tQNIngRmtE/CDDfWsPjIp?=
 =?us-ascii?Q?WV2nn+POT4s1WOfDUHs5EqHOlbB0UUQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0b71eb-d040-47f1-361e-08dea4f2700f
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 06:50:30.6537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AACPfIEjEwGYlKbGrJV1A0GSUhisQdj4PZ8k3MHT10oOwSvdCjORApN3JpVtSp4SzlDQ4N7HSd4mwpMFyeu1+9WnHePonH8JOLw2DnaogMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR03MB8038
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:38:07 +0200
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

Move the system manager and L3 interconnect firewall configuration
from a dedicated firewall_setup() function to using the driver model
(uclass_get_device_by_name()). This removes the hardcoded firewall
setup in SPL and relies on the driver model, making the code more
maintainable and aligned with upstream practices.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 arch/arm/mach-socfpga/spl_n5x.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
index a49be837921..f776d0c0327 100644
--- a/arch/arm/mach-socfpga/spl_n5x.c
+++ b/arch/arm/mach-socfpga/spl_n5x.c
@@ -69,7 +69,17 @@ void board_init_f(ulong dummy)
 	print_reset_info();
 	cm_print_clock_quick_summary();
 
-	firewall_setup();
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-system-mgr-firewall", &dev);
+	if (ret) {
+		printf("System manager firewall configuration failed: %d\n", ret);
+		hang();
+	}
+
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-l3interconnect-firewall", &dev);
+	if (ret) {
+		printf("L3 interconnect firewall configuration failed: %d\n", ret);
+		hang();
+	}
 
 	ret = uclass_get_device(UCLASS_CACHE, 0, &dev);
 	if (ret) {
-- 
2.43.7

