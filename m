Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DDCE77170
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 17:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A492F89749;
	Wed,  4 Dec 2024 18:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="ndyWoEtZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0279C896E8; Wed,  4 Dec 2024 18:54:49 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EF4389421
 for <u-boot+nodisclaimer@lists.denx.de>; Wed,  4 Dec 2024 18:54:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+QT5tW5toEEKQoyHXqFkaelcKzZuDE3jPY3YdivYA6qxcR2KxQBwh/t8CmFGS6BjLx2qxVCIDmHc8NJm3EhT3dQzACw6nMBGJ/YaA3qAtZisQBpRcm0X13pn3htBrx/UhYOKrqV8OMADtXjCbc/EOLWKY36r0fbPmUUWfcmjjx3adzVVfo75ZeHfcb1FNAsZx1gMt0JZkRamDNYaxGzRN2Xf6YWFx8nA+mLSQ+I27H186NsNcJM41YBuyu4Ipr4pa1DBqmvENBbLn6cJSKOIdtTx/qq/VWL1auYvK+te2YSaibiN8+AshMK+svTrH71NQvY7NbAhpmZWSAP5JApAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypdSuNJgMqYafeMNwCifl/03cgbpiFrluaz7S0dwoOc=;
 b=PcqXN6XTZ11vcG8xScyE1SIT7W2gySZHZa1qDZaTUrIydwqOxWwtCJ40YstPOD0vz6GhoHUj7fg6bTvL2x3QEUqUIOmsASSltzXSK9tfYOvT5rGoeiGffZg5PjBLJrIuK4txJbLl9SNta6WCQNOEQzGK+kMzlP6T7eY8YkOI1SXPtt0CNNJODbKCNDfJdT9hOZ2c5O8EMTAgqmJlavSlc2Lq/TS16LHCz11TGW5V6TuBEWXR7lvDZO7ilok6JIq/ZNxRuyVCtEIH4sivGsBG66TuZ62PdE3BOq2z5GOvqRX/3KPmVV62zC/EocNX9XKIkxhosjoHX0IAqDG7Dj0lXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypdSuNJgMqYafeMNwCifl/03cgbpiFrluaz7S0dwoOc=;
 b=ndyWoEtZH5iipKFvgXSgK+Yt6sI0jHM4MB9jPd7NAgG18OpS+z6VccgBgzV9IVRjOxh6TWb2bikbKUG+OL4/WzkDW8SlNFRqmTKv9WGFZlPQxVO3xRCc9doccoFRKtThb4G5g0lWgg9lCgfAImRq1NkGbPjCR/qwhh+k6BWZqOIzGL+Cg03ZuS8NCmLLgUtT1HE/A/dwOtu/I8FwE0JC0Fqe7hojujK9sZNIGgNtsTx3CuNAwDsAhiSuSwFH0tHkX+TQqGxY9i/uVzy9nHcoww2hy3zHMTwwS4suk+yVx9X8cMlfbgxG/+0Qz2hwm2kJpfSrUqWpBG/B4oErZSe5lg==
Received: from PA7P264CA0248.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:371::14)
 by PASP264MB4689.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:435::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Wed, 4 Dec
 2024 17:54:40 +0000
Received: from PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:371:cafe::14) by PA7P264CA0248.outlook.office365.com
 (2603:10a6:102:371::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Wed,
 4 Dec 2024 17:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BB.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Wed, 4 Dec 2024 17:54:40 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.75.209])
 by proxy.softathome.com (Postfix) with ESMTPSA id 9623120372;
 Wed,  4 Dec 2024 18:54:40 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v2 4/5] lib: mbedtls: sha256: add support of key derivation
Date: Wed,  4 Dec 2024 18:54:36 +0100
Message-Id: <20241204175437.185449-5-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241204175437.185449-1-philippe.reynes@softathome.com>
References: <20241204175437.185449-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BB:EE_|PASP264MB4689:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c89999f5-f392-4b92-f700-08dd148cba1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bNILpzjlsahRXtSZVJ+m++nKw5Szu1GnMDr5O5j06DZVYmLUVjxfNWjIKEl2?=
 =?us-ascii?Q?Fzlqk9BIjPbFcspCA7hk/JqSBCQCmvgVbCBzG17SUQKbTC4ATrqC8Py/HgpY?=
 =?us-ascii?Q?3pDVleZmOG3aVnn4Rtrl01SCyFStUUa9zjPwW8nOrbD/UBtnrbjZjSIaJOcd?=
 =?us-ascii?Q?vKDr4oLuc6Ng+fsdQPQNM7rjlVn3U2MvnXk+LMVEUo9oxwGK139V6kOHfwR9?=
 =?us-ascii?Q?m3SVJG5iH2Kqs4T/PG4B1leO8mkFjAMuN6wXZ0WTNonCv+sFsm1WMxbzdxGF?=
 =?us-ascii?Q?7fbuhgVCAPeR17+tds3+pw0+fMgKWyymL5EFteUfMinfRayPpYrMShs7EUfW?=
 =?us-ascii?Q?HMwmhQ20v+gga0KzMb+4SOHNP3zTFnz6yRa1yWVi0o/YygLgQAPArmJjtfFA?=
 =?us-ascii?Q?NYkBfaQ4U2tBhPge3t36qdHmT58UgYzSOmCHtesQ6GBUOHZYvdyXTyUc/72T?=
 =?us-ascii?Q?sBPoXeJrUYaJUIss6Kf8XvpNmbmfCjhC97uhfQyPl6X0f6bXqS2dVzVoQ6mV?=
 =?us-ascii?Q?rdF8fTTVVqqC5Eou1dZ/G9g1Ur6CZDCfq/Su2c0JxUYydum8Xh8TVIWfep0j?=
 =?us-ascii?Q?vtVQ5dTTnNirFLw8PY4RTnK/8XOJLjjFTqpodnor8v/utgm8kzy5S8NinwET?=
 =?us-ascii?Q?hkcCWa0o1Pxt6O7vvs6Qk07g/lBNjd132DyZAWn7Ir/bS4S9oLVEjmzqgFV1?=
 =?us-ascii?Q?+VQscfoUYEKBSmGztT8xOzY1oD0vBmR7uUzGPb6OJXu+39zX7jMZsiO3u7Zl?=
 =?us-ascii?Q?KxOcjF5GEM2d0mcWGh/XXMuQuVfbf/WBFMuslJDn5575d/T7RcAn+7yebsRt?=
 =?us-ascii?Q?ygLFLDrl1gx2IuZAkVKCxNSCbEa/43/UqpuCGvC0quFSrLfVWYDrKnT9h3ne?=
 =?us-ascii?Q?hqgQV04RDZ5VcKykEB/OMCp1pDfI+rz+9McT1Me3E0Z0KzUDLiYE/2yubJzo?=
 =?us-ascii?Q?nH4n53OJlpWaSVpIkxSCttsYiVqu5UcE4HC8u7zliAgu/n/0NHjv+8mznPqZ?=
 =?us-ascii?Q?hez9EwMQCVoiKxKNHFVETy3fw8SDYlcO7xhrEZXK35psEsCAX5i2SJUHw9JB?=
 =?us-ascii?Q?qFvw4elnU9tTZgbce6EN4rnWXq/DzAfORr8HslaBXwjT1HqL6YOLQvTiBWIX?=
 =?us-ascii?Q?lVuzxkwvTl140Jx9b/MdbVJPvPa84gpmcBAhg51ngrCAx7FF7gGfmMtMxAd1?=
 =?us-ascii?Q?zMX7OYv4J15feBdBNVrfJiWv8y3a6xqy+B0UMmMEDLnNJuQcjVw6yfMmATFK?=
 =?us-ascii?Q?p5K6a4hTXsd2zApUIiRLG1f2AJE9+MRZdFJ26R5vkpgi8KTT7L0UXtiUZUUf?=
 =?us-ascii?Q?oLR+ehpmueA8qoaDUJubep5Li+I5Qbldb4QAcoY4e6fl1BRMLkuI40YppaFJ?=
 =?us-ascii?Q?8LT422JUUeGSLR1LoDLl0AGzbh02CGqW6rCUsUa48Kl/pR8mTM3UNt6ZxLUF?=
 =?us-ascii?Q?AN+QSax4yy1rtIIzcIV8AW56YN751Lst?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 17:54:40.6890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c89999f5-f392-4b92-f700-08dd148cba1e
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB4689
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

Adds the support of key derivation using the scheme hkdf.
This scheme is defined in rfc5869.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 include/u-boot/sha256.h |  5 +++++
 lib/mbedtls/sha256.c    | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
index 77dbcd4553a..0a6e309e3ab 100644
--- a/include/u-boot/sha256.h
+++ b/include/u-boot/sha256.h
@@ -48,4 +48,9 @@ void sha256_hmac(const unsigned char *key, int keylen,
 		 const unsigned char *input, unsigned int ilen,
 		 unsigned char *output);
 
+int sha256_hkdf(const unsigned char *salt, int saltlen,
+		const unsigned char *ikm, int ikmlen,
+		const unsigned char *info, int infolen,
+		unsigned char *output, int outputlen);
+
 #endif /* _SHA256_H */
diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
index 1b9fc1a8503..c38e3e5818c 100644
--- a/lib/mbedtls/sha256.c
+++ b/lib/mbedtls/sha256.c
@@ -11,6 +11,9 @@
 #include <string.h>
 #include <u-boot/sha256.h>
 
+#include <mbedtls/md.h>
+#include <mbedtls/hkdf.h>
+
 const u8 sha256_der_prefix[SHA256_DER_LEN] = {
 	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
 	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
@@ -98,3 +101,18 @@ void sha256_hmac(const unsigned char *key, int keylen,
 	memset(tmpbuf, 0, sizeof(tmpbuf));
 	memset(&ctx, 0, sizeof(sha256_context));
 }
+
+int sha256_hkdf(const unsigned char *salt, int saltlen,
+		const unsigned char *ikm, int ikmlen,
+		const unsigned char *info, int infolen,
+		unsigned char *output, int outputlen)
+{
+	const mbedtls_md_info_t *md;
+
+	md = mbedtls_md_info_from_type(MBEDTLS_MD_SHA256);
+
+	return mbedtls_hkdf(md, salt, saltlen,
+			    ikm, ikmlen,
+			    info, infolen,
+			    output, outputlen);
+}
-- 
2.25.1

