Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AFEE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECDD380241;
	Tue, 17 Dec 2024 09:32:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="Q3pfCmxe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC13E8022F; Tue, 17 Dec 2024 09:32:23 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F1A18022E
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 09:32:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ew2Myu71JuD51Azsqv0dji4RIngjGcEOwtQ3D4XQaeYAh/7bfe/67dy2gTkNhbAUYj2YScVH8dTqle9q9IEsJdK3JztbE2Cr81+CXrZgjxecKXKZTgtUutkK3ihYSLm5hEq2V+I1nc9M5y73sWpCX+N8eD2r2rzqHZBbG6QFrthqJgzISdpdczV22j5b5k7vgjnN71cLEcEwLHfSEdeNVOgaTQ6NFBhu1vYc3g0ORAPAqCpwg4hqJc5vHdwFslE/mOr6M16PzyIS0+leTOdrg1ZyRzKdspPmJnnG9MxYE2106FucWt8pdeNGarSo0wTzSoIdltNYAR0udfKZxcO9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jbeU9WTiJb77hR8Uk+j2vL6UZ2Y+UCfGiyJVizyYIw=;
 b=UG/Mox0ThzUnwdV3oFIgIlJgbzbkzlxw/+zlohO2XBr0l0cTbpwF3LSLso0PV4fxdfy7rF9kDusZsWgv70kj9X+kZAVfDXF1TYSCevVJcKsaz7kKLSYrbOHNiq6arNuVjx6K7+vyiEQQmqRcIgo4qGbz2Bmr3NLKkDeM6NEMH2qOV67kkZhS160U46kPc02CwqXvXdPBxZMWZIFgTLeUFGLKJUAkQIuE3LdmwgbjHf7fEokpEzh4xzcqe9xe+M3urVMDqWXJJQ2eENqMhaH/ndRujo2RRM1RS0OFa692+BOS9iRn6/PBM8Wx+2vc+CJgrqUsUs4LOOBJjIyfXDGtsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jbeU9WTiJb77hR8Uk+j2vL6UZ2Y+UCfGiyJVizyYIw=;
 b=Q3pfCmxe3u6iykmSCl4A3Rh2vO+SJa7EfJvCH7JdPIIUx+ZPuGv429JDLmZ6McmWTY7j3DFAcQBHCGT+8w9zkAUk7D37uVEqDaNehiXQeLhcZcaW2tVZXzWfP2rxhPBfZ6hqkqLQjJKkkyApjnRu9W/lmPY5JPmPA2KnIssX7D8Hy3PjuITaqs4xbvv3pA6JNpyljbDl150vv4wqYarPcDYTf9MW5oNLNZ9+WF124tIxRNi+4T5zFqllOoRnG/rTNVGGX036yXm0vxvxPD1n0ToH85LiYnFCosSk2Z3XRZ0/ML0q1LdfID91aGUilP8dPz5oZn8zoRFdtrTGLE1J5A==
Received: from MRXP264CA0031.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:14::19)
 by MR1P264MB2740.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:39::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.12; Tue, 17 Dec
 2024 08:32:17 +0000
Received: from MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14:cafe::f8) by MRXP264CA0031.outlook.office365.com
 (2603:10a6:500:14::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Tue,
 17 Dec 2024 08:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D5A.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Tue, 17 Dec 2024 08:32:17 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 17E782037A;
 Tue, 17 Dec 2024 09:32:17 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v5 5/9] lib: sha256: add feature sha256_hmac
Date: Tue, 17 Dec 2024 09:32:08 +0100
Message-Id: <20241217083212.70330-6-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241217083212.70330-1-philippe.reynes@softathome.com>
References: <20241217083212.70330-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D5A:EE_|MR1P264MB2740:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5cd26394-6bbd-424d-7b35-08dd1e7550ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EtNEStHFcBDygRyk3y52eWcQV7vtdcOZSthU7zVFej2d2qdbJvq168pnxj+1?=
 =?us-ascii?Q?F1A4B57xgCvvFcwjhOvnhBhrgoN3QwTIZHhojrMsOVVJpsjv3Hrj1vtb11et?=
 =?us-ascii?Q?5O/fAialAVt58SIQSPBlqVjNO/rK/Af7VDANXiDuNhRUA6KabcDr2X/B7b2F?=
 =?us-ascii?Q?RFwtGdoKF4OGOXMvVwiOtzdKFwnW8kmapu6MAmeNn0nzb8/R2ioBmdZhOu7e?=
 =?us-ascii?Q?iz08tTYE2iKq518fhKT3ZUvylPwbOqqR+To0dG7LTy/b1l/J6bovO4rbhOYn?=
 =?us-ascii?Q?22QOhLLrrMKc3wtproq3ghxLb++nnTV9rQT5x5aUpoLhf8Pn7u9dYhGCJbTM?=
 =?us-ascii?Q?7LMuEk0EhF/8/1waFDDVcJw/UoE/XIInB/zS8NcN3HOvnW81bYn2juPuVukM?=
 =?us-ascii?Q?+CE/WmhhCWllGnmZcWk81yTLXy2iw2+cWC7jk5SA0FCgGCCzqFZYr59Ws/g7?=
 =?us-ascii?Q?mPrZI85HtHSqq55M1s+o5qarLgJ9BNBC9vPNg1Adv4oY1Xt3DSQ7xv5lxHeD?=
 =?us-ascii?Q?wMPdMdodwK1Ja8YhwtypOWAs4BmRekZnFvmcfGO0NIT9VAzSTa0u/3COSVaZ?=
 =?us-ascii?Q?BTkynD06ElEgcDlMzQ2KkamOCJMR+OJ4ILtXnq32gAjXU5bQy6ybjT3Rco1w?=
 =?us-ascii?Q?cehbjQvfYFrt8umZuEwG4jVGLsSMGciJBR99CybQ7D+7LAmoVn6si281Aj99?=
 =?us-ascii?Q?3wS6xa2NRVcShLHInfNbuVQkw26xmwoJdN2E3ubQamuLHnPWwq6umZC2pvT8?=
 =?us-ascii?Q?b8gWNL5tm6scYx9es2bGDtfhv1bQoa93gcJwKApPmttIrReqooIzSC4jF4xV?=
 =?us-ascii?Q?GgUuKKkJhS4u630wcWe5+wW1BiWyE0RbCOIajz8G3j+05fvNUzDMvayWEykr?=
 =?us-ascii?Q?INtjtUPdnmtwJXQfL1lfcvRr48ziN34/lz7PynFEFBSWNId3D/uIow4quLDN?=
 =?us-ascii?Q?xULCrp4kbL1IRouAVwM26g6al3oUueR+OGLk+r1rInRf8xGL0S+qnG0p717E?=
 =?us-ascii?Q?ouXaCKuggtN8eGIW+YJSyJN9FyexJgGAdVwAEEtSywPegHydU9JKeW04zPJF?=
 =?us-ascii?Q?1UpYAYLLuxDy6fJEOJ/9edxOEZ8DGG6QqCwRpnh7StwiCZT2IwgTcwbFmdap?=
 =?us-ascii?Q?RsMFYbW/drMzxcLbO/25M7s1NrF+v1LWnT/4UFXg9+3HEmc1jx8gNUTJgG1k?=
 =?us-ascii?Q?Xw40HnE1QJw3Z9Gx8TAng8t3UX7Q2b9s73RF3nPBYO8ntL420kxzFFjpZBae?=
 =?us-ascii?Q?lBCt1rLyim+GyzjEwtLSyxjs5pyrnv2FA/igZu5S0c3OMlxryfxYP5h6EX3r?=
 =?us-ascii?Q?8mDjR1MrN9UVIoSjW51tcLrWzON46jPwox9UZLAaNoGamxg4OcUNasg5n/u1?=
 =?us-ascii?Q?jOaTIDbbpOJXbIa4+ZrEinE3iAK3P9UxboqwlTh5dLC5DsTclKNU9LnEWK2W?=
 =?us-ascii?Q?6hau6+gwWN5XpqcieyXaI4vL31thYD1M9FeR1M01c0Erm6jpG5YmahEHoUKF?=
 =?us-ascii?Q?71LK/y6P2swQhNw=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 08:32:17.4624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd26394-6bbd-424d-7b35-08dd1e7550ff
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2740
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
 lib/mbedtls/sha256.c    | 15 +++++++++++++
 lib/sha256.c            | 50 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

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
index 827bd9a872b..a18aec3928b 100644
--- a/lib/sha256.c
+++ b/lib/sha256.c
@@ -264,3 +264,53 @@ void sha256_finish(sha256_context * ctx, uint8_t digest[32])
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

