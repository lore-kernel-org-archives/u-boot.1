Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767FAC3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 15:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D727889F8;
	Tue, 16 Jul 2024 17:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="PQw+Ldxi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 531B6889F4; Tue, 16 Jul 2024 17:06:30 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43D6B889ED
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 17:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJT4RnIdYxRxCjIRJarFdJ9cAzievHS7PSIfug5Yfd8WOT/YyvFoGFuIO6m6fTknIwN/tuJm18ipWHSvATBHNL0M6z8ZunVs05aNWEKBtgGdUjwd8hqj33C0xskzkc/KKZN/8LZ5r1hLVeCYH9raNsDoKizQ7vFgeHsrBAS1txMJz1HqmmtLYtF/JxFtgzo9EpJ9JIzC2Z/+DBU15RPHMx434bLQj1tqXS/ZpPM5y2oKW0rKEKc6RKH5KlLmJXYYN+/DhcfSyNgg45REcPx93/lKv+oheyBEjm82FPbrJvLR895sYD3sfnOCr2sqMlqV9nlBbafUwHZ8xqQS9oG/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoiOZMNKW2fWnY7XuCEeszhXbXbbm6O7L0L6ekcA3uQ=;
 b=JhMO7mqFnLD8RdMXFkcOfaxJjosMKANbmRHUJfUPdtTOeh5tyHrubckTJPeL2Kk8R7LhexczXNMIGETlWH4GNTqF7vFg5qTl9foTWJmc0sfGiDOoByi5Cu4Of3FNkPMLllQfyl1HYPJAeeZEUNUyErLc/hPJJLtihgoila3cBKPFjXaaPEojLYwhMIP7P2/P94ircZ0/st4FdbQIZhXklcRY/Bb1+QMUhi9FP7B8NQrUt+0aJC3q+HHD1YGnkjvYBoa+bn3Bu10JDpLtdLevCCcTWeE9Jw2DCmwGVAktFe6y705XJhtA/NAlLbOUkkBy0sbBT69i9dZJjIGR/4hcCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=arm.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoiOZMNKW2fWnY7XuCEeszhXbXbbm6O7L0L6ekcA3uQ=;
 b=PQw+LdxisIB9s4t0ChqBzaf0Q1FFalZgueRol+D5mDErFZVkta212JT5ykTN7YOTrM0Nkty4F8hxqO0nBSdEQuh1vuD5Wvb7SI+nuJ3dlfdusMhtiuILIeOgG8eA0APoJySgL4AyeFsw0NwDvMnlPl0TMZbhyVwg6PIlixQJA5PLpIep0QInIkTOAL2AT/aYbioIY0GzJI+3dDIsxpsfjN97Q8mYY7XS37lBvoylsW23GuT4pMcb8gjO7Q31dvCV1sUtJJOM0cyf5QRiNiK4S+o0y7cW8L4ARq44nJURlXF1jPhwA9JZmdU8wJXLeMOEjaWs4pjqA42Y2G5MhgzvLQ==
Received: from PR3P189CA0085.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::30)
 by PR0P264MB2244.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:166::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 15:06:24 +0000
Received: from PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:b4:cafe::17) by PR3P189CA0085.outlook.office365.com
 (2603:10a6:102:b4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Tue, 16 Jul 2024 15:06:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3F9.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7784.11
 via Frontend Transport; Tue, 16 Jul 2024 15:06:24 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id DEA792019C;
 Tue, 16 Jul 2024 17:06:23 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: trini@konsulko.com,
	sjg@chromium.org,
	abdellatif.elkhlifi@arm.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH 1/4] lib: sha256: add feature sha256_hmac
Date: Tue, 16 Jul 2024 17:06:13 +0200
Message-Id: <20240716150616.349466-1-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3F9:EE_|PR0P264MB2244:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7f42a9c9-41de-43a6-f691-08dca5a8dbef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZrK3+ff2xKHy8jMkzTKZ0YyG/TkaaXU6G7hs9RHdHFDkSYgLgm+t6bAi7J1V?=
 =?us-ascii?Q?2wUygam15RIQ4JWbKhb4dZnfZLpqj5xsaZfDRK6fzj0FrYSzRH3APBprPKpS?=
 =?us-ascii?Q?BU1XOsTh3zCq3xRkk86rFeeXTZ6om45swFnqM9ls9zw1Obz2smbLWvwsJq9y?=
 =?us-ascii?Q?XOEZMI2jyQY7EEKTp5mIhQl+AbQVo1p4CpL4o5hDNjXGnmQ89SiW1m5KQcRw?=
 =?us-ascii?Q?zqRBmt2/RzM9vs/npc8OCV2wYpQtMckbWeiexiBpblpgMCgRS7mu0Jd2aCl0?=
 =?us-ascii?Q?YayYBOTj5c/f3p+oOhazJJ45Ad2+CXRxXVTqqihgMqSRC7GFhr661w8ULK43?=
 =?us-ascii?Q?gxLusrsn9bw794OgWzibJAda8sc4Fkb8UbSwMqWZhAMhrltYsRDnkg8VNtHb?=
 =?us-ascii?Q?bxwcvzzpaDsBdNBmfB8yJlp7kaMo2g8C7FRlCXWLoimcABqJRnoWcWbbd4UC?=
 =?us-ascii?Q?Z9wmb2bdocQJjehOzEHIQcxJvseOSjrIMaJ7WG9NV2JTFzzLRSbv2LAQfFpc?=
 =?us-ascii?Q?iroHxQYuTnbZ4hF5VIisHMrl4gibkx5dex3sqvvN44jio76Hwpowau7x3Hsw?=
 =?us-ascii?Q?/v0lQUEICxkZBYGNal2EzLOlr1BcS9yAu7h1dfmteLCv8pibhtAdfmcIiFLX?=
 =?us-ascii?Q?Rvuzzv5N6Adp31EE80YhSKsL9jJCmbi7gJhBMUd2Pv4bIny6gXBr02AECb1o?=
 =?us-ascii?Q?VAgpyPiyuNtvZ5dKqVOS+3DdJFUYpF/T4V1aDIk4TdPlSMw0NzprIyyWtTIQ?=
 =?us-ascii?Q?GU1nMPI9bPYeWmI/pqqm230wXXWNTWrdJW6QoPk/Q18LH2uhz8z44aqrGuyj?=
 =?us-ascii?Q?soWAbx1shAOVrIjcG7o0WYW4ra2mgScg+sq5sl9FP8qCBEmRrpTAURqXVqZ3?=
 =?us-ascii?Q?hVO52hyThHKiPNwbs2bD1t3HiGlpHlQOKJ3sXpklg3G8Thpdt9E/HSyVb41b?=
 =?us-ascii?Q?I/+Ixn+0j/3ojEG1LgtmAs6C2oT9jn5Nynd9pLXpThmn4NZgLJI4p6VJomrG?=
 =?us-ascii?Q?ZSEGDIaqU7EyrE9vBncVmLiIV4n6YQ/K0BrEZAujTvkFuFD3lBvugAlSuajL?=
 =?us-ascii?Q?d4fYAksXjHDA6C0TypJ2UwxLBvofzJO2ebEGjLmHLXA2CGoMtXHbC3qsKBgp?=
 =?us-ascii?Q?Ega0gNA3tXoJPK2shbAA+0h+CPW38KeFddwnkAxRpTRXWn7zU16fQAanvKHt?=
 =?us-ascii?Q?kWS5ywhW4oVoAwUYYhxDTtBYfCMeqbxylzmMjqRWXiLiQ6tBwLo7gz6jK1uc?=
 =?us-ascii?Q?OPfuKHlUSPq3DSW0zXbivXdianv5hBO8XAnYGn2zrCLIJM1WQc037lARkhAI?=
 =?us-ascii?Q?WvWE6sTLYXvdYdbe2XTCDq0jjPS2FaR2ruF81PTo8LmBHhplZ+kt+1/51uDi?=
 =?us-ascii?Q?prKn6ZHy5jY2p6IBc3i9yMhRQFbDdKESO5odhvikJWD5BvUyW/ajkGoPbMIR?=
 =?us-ascii?Q?FPijsJw9UeYUqVn9v7aB07G7P/z+rPM2?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 15:06:24.2011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f42a9c9-41de-43a6-f691-08dca5a8dbef
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2244
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

Adds the support of the hmac based on sha256.
This implementation is based on rfc2104.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 include/u-boot/sha256.h |  4 ++++
 lib/sha256.c            | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
index a4fe176c0b4..7aa4c54d0d4 100644
--- a/include/u-boot/sha256.h
+++ b/include/u-boot/sha256.h
@@ -24,4 +24,8 @@ void sha256_finish(sha256_context * ctx, uint8_t digest[SHA256_SUM_LEN]);
 void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
 		unsigned char *output, unsigned int chunk_sz);
 
+void sha256_hmac(const unsigned char *key, int keylen,
+		 const unsigned char *input, unsigned int ilen,
+		 unsigned char *output);
+
 #endif /* _SHA256_H */
diff --git a/lib/sha256.c b/lib/sha256.c
index 665ba6f152e..64f6b48974b 100644
--- a/lib/sha256.c
+++ b/lib/sha256.c
@@ -298,3 +298,43 @@ void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
 
 	sha256_finish(&ctx, output);
 }
+
+/*
+ * Output = HMAC-SHA-256( input buffer, hmac key )
+ */
+void sha256_hmac(const unsigned char *key, int keylen,
+		 const unsigned char *input, unsigned int ilen,
+		 unsigned char *output)
+{
+	int i;
+	sha256_context ctx;
+	unsigned char k_ipad[64];
+	unsigned char k_opad[64];
+	unsigned char tmpbuf[32];
+
+	memset(k_ipad, 0x36, 64);
+	memset(k_opad, 0x5C, 64);
+
+	for (i = 0; i < keylen; i++) {
+		if (i >= 64)
+			break;
+
+		k_ipad[i] ^= key[i];
+		k_opad[i] ^= key[i];
+	}
+
+	sha256_starts(&ctx);
+	sha256_update(&ctx, k_ipad, 64);
+	sha256_update(&ctx, input, ilen);
+	sha256_finish(&ctx, tmpbuf);
+
+	sha256_starts(&ctx);
+	sha256_update(&ctx, k_opad, 64);
+	sha256_update(&ctx, tmpbuf, 32);
+	sha256_finish(&ctx, output);
+
+	memset(k_ipad, 0, 64);
+	memset(k_opad, 0, 64);
+	memset(tmpbuf, 0, 32);
+	memset(&ctx, 0, sizeof(sha256_context));
+}
-- 
2.25.1

