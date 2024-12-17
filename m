Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F2DE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 21:36:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F829802F2;
	Tue, 17 Dec 2024 22:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="SmHMs6lj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B0618022F; Tue, 17 Dec 2024 22:36:22 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA0BF80239
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 22:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqjuGWWfQgQ/G3r3IhEHoiQsTbwUrH25e5E9Kby/X31aaz3J8asAp8lBZKyBxmqcFjsG9uYc1O6aIzD64nl068l+qGLmqxIckdA125Ao9I+IfZorZux4rbyBLkAoaSvAFRSU6SWXDBI3BiSLsljFvrA2okv9oNEgp1lXPpT1iYovPSPKXM4dfC6L2y6E39x8L0RUEMC3Am2cMtMAh6KWD8nDccCe4+KyVWDJAJFtURIgDtTjGQlX0SxrKroDU9goy/0KZPuiFk4rCzT/toyI3INgv+k+Agg/1DrdNfnLY55a3ZbXpTEaJINUpgiwb5iXqZSeLFXP6WBN0mOiTt+8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5L4iJf2np20a2cByJImK7Z6rFUF4k1JGOsR2dvb9yNo=;
 b=BzkFIP3SqMrxOs9Al5pLyaOiJX6ayfTmmhwMoDmL3wgHDn8o0BBPB+Z3lO5VMENgoZR08PUipBFGJwo8oFf2R6qOduHjZMK3fkIn+Sbe0aUF1CN4/P6uC6UYtvIWOKpAJgnYV8kKcXRO0PedsoqS3EyKCqoQ0DzanjnHZJ3ooAVdX2YPqqVWwExfgRuSwVPr8QrPPTip78Q5jnRNEkU6ltyIHCPMxoaavd2LzNHYCVQM0OvKFJTNwE6Vr8n6ygOWlNfIdn0ptfaxpfND2YEmfRKiCBvBpbv5KdfCJbmZOShB6vi5xzR3ztrofg4e7oxfUw2xzIx/jVUCaKMS5cb0ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L4iJf2np20a2cByJImK7Z6rFUF4k1JGOsR2dvb9yNo=;
 b=SmHMs6ljvIlUo2edfzrcN587mV7K3UYqwqjOa/rJmQPaw5ST/9sZrYtfVTX4VZFHZn38lfDyEa/nBk9EYkh6hvuMXzgm0+Jkoan9EQMbsI1PfZx20ei/T0B6+EbKqbEf7KF+dMKZ21gaaXvucZZHjnQ+IqD87Yr7+aXG0Qto0mVQBrzY523BgGE7jhEwLO9sIwkq/Lp1HQcLXSH0NBarz78+wk9jZGxpFHhJQq3cKONezmDrVtia/kfi2YMWGDrJMDDY5a1mFnasquHST8axfg4E/3K+wYQuXQKvvapRUj9xwzBwAwtAdOo4M8J0AWrTBwJ5+ANOhJlu6wS9PX1lBw==
Received: from PAYP264CA0002.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11e::7)
 by PARP264MB4974.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Tue, 17 Dec
 2024 21:36:17 +0000
Received: from PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11e:cafe::4) by PAYP264CA0002.outlook.office365.com
 (2603:10a6:102:11e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Tue,
 17 Dec 2024 21:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B8.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Tue, 17 Dec 2024 21:36:16 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 857151FFA8;
 Tue, 17 Dec 2024 22:36:16 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v6 5/9] lib: sha256: add feature sha256_hmac
Date: Tue, 17 Dec 2024 22:36:09 +0100
Message-Id: <20241217213613.286813-6-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241217213613.286813-1-philippe.reynes@softathome.com>
References: <20241217213613.286813-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B8:EE_|PARP264MB4974:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 98f7d654-aec6-486a-730b-08dd1ee2d68b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H2CpyNM/IX4/nGRmAVmTJEuSG7v3eVynGAvu6zxYA5UnAr6RGQU+XnJDR+dI?=
 =?us-ascii?Q?O22peCCIozKUkHHBc0yhg8o55v1DavaGzW1E05U1x33FbadNh0cbIuVI6DDV?=
 =?us-ascii?Q?1xW72+dyRk+2+3nYhQd8tBarT6Pib6rtZBrlZrK7VQu5RY8AvOpSgDYkR5Be?=
 =?us-ascii?Q?xlhGR36josmot7GIfCneuQrusC1QSrQx4ZzMKwn+YnDHeg8Ol0sLFlAa1r5j?=
 =?us-ascii?Q?32QKcetRyUBFL2+m55fZpdaRnMRvvHPxjvu/mpmSCGmfkjcgtgWSin9uP708?=
 =?us-ascii?Q?dZ+TH8/6ZzoRbIk3XMXlVYw8l1UBsXT5I04PobA/IFjv1SeT7FCygG8Zq+y5?=
 =?us-ascii?Q?O2ggZlsi1arx5FEi2OHsLkigcT2DiRm1Hn0ltJcfg8JHHKjuQiGZAXT+fpX0?=
 =?us-ascii?Q?5MUkfUn69CbIhx9dD1lpcCFnYI2ZpgD1LT9qgA+AFitkdwQ71w76dxo07E0f?=
 =?us-ascii?Q?7xOHO59N4CBaYo3wMzDlUty27A9xiFcMrENP9E4uz2AzXHfclVeLUij17kGB?=
 =?us-ascii?Q?bC3lchQI1QG8s4XejfWaZ1V/1IAv1rzWXrpW3LajeXYokIa8R9bEmjEuEW4O?=
 =?us-ascii?Q?Q8t1ehXkReiegmqIXs+ZSB5anwep/Uggk1xx9Ct4z/0LBkwWYPdpuAPz2Zym?=
 =?us-ascii?Q?brOJ7RbfQWq1HfFs+dGNI2EFeMhV2jTKLdPXQDOApmSdp9cO2W/GsUpNXJbE?=
 =?us-ascii?Q?zVXdkPS9YjoBO4jP2XsPOb6GQ1jU5A6E234SVcH2RZbFxkNHwwZ0LYujLT8i?=
 =?us-ascii?Q?u/R2heZ1h2txsx8cJ2vwo0FN4I1RxIk9QHKgz9uxvwI7wVZ0jtZGyTtksPIl?=
 =?us-ascii?Q?aVnKoc7FWG70EduoxsFc71tcoNk2Ln69woaqfrNuX/h0ZAF8ttpBCrH6GBHO?=
 =?us-ascii?Q?rX97Ch5Y/jcgDQGXBKRXjq+YYfympwpq0akZq7KdJERtByiQv4cxluzNroTY?=
 =?us-ascii?Q?50dN0sJIe3Gvu5gvZaqFE4TQ4Q2XK/mySKgLqXY3Blm3nz8HkiAQYxewiqKD?=
 =?us-ascii?Q?ZNekQGl/sYZIALpzldzSZuI1aIV1opD8ngvx9NkbHZe0UVIjMjlKkubnw3ib?=
 =?us-ascii?Q?ypyTy4Mix6VNOwP7crZAf/pdrvZfEKrVieOc0rk7C+M4wChQwsuVtR5G0kPV?=
 =?us-ascii?Q?ZjlUZG3GgG/D65GVLyFIVCraX27dYRQ5SlelGaqaySfYN/b6Ie1pNmT9QTty?=
 =?us-ascii?Q?IMF0ZkNGs9B43A+bm8njn5D/ncadY9BgNZvziIguWeUCHY9ePJIy+DIckmiK?=
 =?us-ascii?Q?+OtUGSProonTgKSI8C2mZSMET+Mh1eXf5JgBTOh9O9BhzqOksG2DUKVZ/pw3?=
 =?us-ascii?Q?ZvDmH92awH3eg+WbU9lv47vT32fpJRURcjOJl9tlTtwdZItjWsIanLs2adDk?=
 =?us-ascii?Q?lvDxDHvgK8av5qr+ovv8KYvueZ9Jsw7mrK9O6BGABGbv4VGv5UnCWA3fmP6F?=
 =?us-ascii?Q?abXqtdVb7ebioNUB57RowujRuW14gURIlW2BgDgOAflnpBXRy95EXgUe3CP6?=
 =?us-ascii?Q?rvQGkykanCWw+bU=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 21:36:16.6915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f7d654-aec6-486a-730b-08dd1ee2d68b
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB4974
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
 lib/mbedtls/sha256.c    | 15 ++++++++++++
 lib/sha256.c            | 51 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
index 44a9b528b48..99cf78e204c 100644
--- a/include/u-boot/sha256.h
+++ b/include/u-boot/sha256.h
@@ -45,4 +45,8 @@ void sha256_finish(sha256_context * ctx, uint8_t digest[SHA256_SUM_LEN]);
 void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
 		unsigned char *output, unsigned int chunk_sz);
 
+int sha256_hmac(const unsigned char *key, int keylen,
+		const unsigned char *input, unsigned int ilen,
+		unsigned char *output);
+
 #endif /* _SHA256_H */
diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
index 2128e598834..7d456a82017 100644
--- a/lib/mbedtls/sha256.c
+++ b/lib/mbedtls/sha256.c
@@ -10,6 +10,8 @@
 #endif /* USE_HOSTCC */
 #include <u-boot/sha256.h>
 
+#include <mbedtls/md.h>
+
 const u8 sha256_der_prefix[SHA256_DER_LEN] = {
 	0x30, 0x31, 0x30, 0x0d, 0x06, 0x09, 0x60, 0x86,
 	0x48, 0x01, 0x65, 0x03, 0x04, 0x02, 0x01, 0x05,
@@ -33,3 +35,16 @@ void sha256_finish(sha256_context *ctx, uint8_t digest[SHA256_SUM_LEN])
 	mbedtls_sha256_finish(ctx, digest);
 	mbedtls_sha256_free(ctx);
 }
+
+int sha256_hmac(const unsigned char *key, int keylen,
+		const unsigned char *input, unsigned int ilen,
+		unsigned char *output)
+{
+	const mbedtls_md_info_t *md;
+
+	md = mbedtls_md_info_from_type(MBEDTLS_MD_SHA256);
+	if (!md)
+		return MBEDTLS_ERR_MD_FEATURE_UNAVAILABLE;
+
+	return mbedtls_md_hmac(md, key, keylen, input, ilen, output);
+}
diff --git a/lib/sha256.c b/lib/sha256.c
index 827bd9a872b..c2e77c854b9 100644
--- a/lib/sha256.c
+++ b/lib/sha256.c
@@ -264,3 +264,54 @@ void sha256_finish(sha256_context * ctx, uint8_t digest[32])
 	PUT_UINT32_BE(ctx->state[6], digest, 24);
 	PUT_UINT32_BE(ctx->state[7], digest, 28);
 }
+
+int sha256_hmac(const unsigned char *key, int keylen,
+		const unsigned char *input, unsigned int ilen,
+		unsigned char *output)
+{
+	int i;
+	sha256_context ctx;
+	unsigned char keybuf[64];
+	unsigned char k_ipad[64];
+	unsigned char k_opad[64];
+	unsigned char tmpbuf[32];
+	int keybuf_len;
+
+	if (keylen > 64) {
+		sha256_starts(&ctx);
+		sha256_update(&ctx, key, keylen);
+		sha256_finish(&ctx, keybuf);
+
+		keybuf_len = 32;
+	} else {
+		memset(keybuf, 0, sizeof(keybuf));
+		memcpy(keybuf, key, keylen);
+		keybuf_len = keylen;
+	}
+
+	memset(k_ipad, 0x36, 64);
+	memset(k_opad, 0x5C, 64);
+
+	for (i = 0; i < keybuf_len; i++) {
+		k_ipad[i] ^= keybuf[i];
+		k_opad[i] ^= keybuf[i];
+	}
+
+	sha256_starts(&ctx);
+	sha256_update(&ctx, k_ipad, sizeof(k_ipad));
+	sha256_update(&ctx, input, ilen);
+	sha256_finish(&ctx, tmpbuf);
+
+	sha256_starts(&ctx);
+	sha256_update(&ctx, k_opad, sizeof(k_opad));
+	sha256_update(&ctx, tmpbuf, sizeof(tmpbuf));
+	sha256_finish(&ctx, output);
+
+	memset(k_ipad, 0, sizeof(k_ipad));
+	memset(k_opad, 0, sizeof(k_opad));
+	memset(tmpbuf, 0, sizeof(tmpbuf));
+	memset(keybuf, 0, sizeof(keybuf));
+	memset(&ctx, 0, sizeof(sha256_context));
+
+	return 0;
+}
-- 
2.25.1

