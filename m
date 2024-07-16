Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F7BC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 15:06:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E26B889EC;
	Tue, 16 Jul 2024 17:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="LYxBZKf2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FF70889DB; Tue, 16 Jul 2024 17:06:28 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D891889EC
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 17:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JM+2Mk52LPT+8SgTJiBoYM3MAzLlFChp5nmH0lu06Bm99kZ31dg2+khhYoCZUbdHYy+NcjlY54TIbJ0hk3SF1y0A85JDN2zMsKwj6QArPbd18XIPsOnUcLTMTRn0IL7JVCyv6/asr88r0RPkCgD6vqLLwHzl7EA3qd4kPJUdzHV3At86z/VXepFQXCtxPU1syk/b3JndIos5pnMSVGKx0WFlgCWzRZYws9S3+YsuPyjVlfyDVuT8BC8/rmlLNPMTbLHOzQM+tiiWTyBQgfQIJK3FuhxS+i0sn9VzRzoF7SN7DH/g6P4NzfiWirkcZISymaXR0uvsHexe9VAoVk/KCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WV+ewgSTbB6KKl62EH4u3Fo4QU9Zk6mEYJOyKnNJDdU=;
 b=nIebNJrriO222atZLFurisKE+AyaxT2QVRAv7bJAxgEyA4IazG8mzolIaT6+wUgtJLyiuqC1Dj8s+izAaS+LoOmNOGEymIj3j+IFjOMrPmWcpGjOGlHVAX5bog1TwWr9tzRts6aoK/9YOIv6gQ44tO4w7HMMtTjxPV0CyHHWCnPlG2hqJSfHJSaGQMMavh3mMG3qasZfUkCBi+Yzob0gzKWna/2X8+UtNBjg4Cta+a+WqfLXh74AYDQMJU6ccLYApYHjlVOXteUs/uPnMzMyuvtRpUJbAycDqzw10/4jzqcOX9A7yA0ARz0DSLsRaSI5Juhl4nPkBD0t0gsFgYHt1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=arm.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV+ewgSTbB6KKl62EH4u3Fo4QU9Zk6mEYJOyKnNJDdU=;
 b=LYxBZKf2+V9dXBApt+kN5Sa1gm0EMsgl88sa692KTKqo3Y25Qa+tt6ZZizFu89jpl2z01V3PDdAAtBrqqlfliqWmeBVzLs0QtzNHVVACIrofVj7fgcRNzuaW92GfSbBM0DP3r1OF8s7zeUUKGpltBukdcmtQJMaJdNmgFzV6ggLYVMteb4rWVUobpJIuXDadbmWqX0DEfgwIRJ+XzfE2pkTPcwKmmBoBZ420ivbT7NF+taS1vxakXydqWW285m4hPjSi1Rji6UbFFgR5VSnM2yQXBMISr5Z5SXkpijgl9P21wAB+sV50t87uE6yb/bW6qlNhRQvw69vbIk9YZ7fWdQ==
Received: from MR1P264CA0033.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2f::20)
 by PASP264MB4803.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:431::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 15:06:24 +0000
Received: from MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f:cafe::b0) by MR1P264CA0033.outlook.office365.com
 (2603:10a6:501:2f::20) with Microsoft SMTP Server (version=TLS1_2,
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
 MR1PEPF00000D57.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7784.11
 via Frontend Transport; Tue, 16 Jul 2024 15:06:24 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 12CEF201A6;
 Tue, 16 Jul 2024 17:06:24 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: trini@konsulko.com,
	sjg@chromium.org,
	abdellatif.elkhlifi@arm.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH 3/4] lib: sha256: add support of key derivation
Date: Tue, 16 Jul 2024 17:06:15 +0200
Message-Id: <20240716150616.349466-3-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240716150616.349466-1-philippe.reynes@softathome.com>
References: <20240716150616.349466-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D57:EE_|PASP264MB4803:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1435b4f4-023e-4f38-e2cd-08dca5a8dc19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GG47/c07PQpZEC58zdOi54e9eb2KpTL9SMHdBE6D1ZrSxd5ZLNJ8yokjjPu4?=
 =?us-ascii?Q?JKP36QssrFcqOevsvFOGYGERHSa7OW8b9p6DSPoPHnR6fuhnvXFHqCr4B/Nx?=
 =?us-ascii?Q?6QCupQUf9ng0be/6JObVXA1gZVWn7clF6jXMcpDrJC1YNrmRaE9ZzNpIQwfm?=
 =?us-ascii?Q?K+Z99y1S7KaRY9Xzhc8WJaR5tdQMG5Pi658qIGM/G90u1W8K16Fy3//1bh1O?=
 =?us-ascii?Q?pT0e8Or+Dlq1hPGFAmIK4DmK1KdSvwFqyGW447hOgE/iJXjEovWZZzGgq2yI?=
 =?us-ascii?Q?tXIsRC8AjmZXw1CeyGhPu/AkTmE+/QU8TiNxBog9cH+A1gTmrYIkni3LCbMe?=
 =?us-ascii?Q?PkW2Pfwk+sI0yN+rXBikP5lE0nKCwyRZEf4x6AAALtisofTmtVBABCNb7ZBO?=
 =?us-ascii?Q?HJpzRuel0qwOX7f8BXyyfBduST7pW/HHHINIAe4JD6ZppwAsJ9UdCYhr2qna?=
 =?us-ascii?Q?SUa3bFGhqm2MIeFPkMzU0heR+jdYcaVDO9ZcWf6Sn0Ugo4w4VAqw8bqCPttX?=
 =?us-ascii?Q?ryswYUAGmstvDAHj6GuKi4V8+mcEf82T64/rVu7TY7BhlwmQzdGmLOb6SkIb?=
 =?us-ascii?Q?BsqMzBMgOZelk/sK8R9v4kpN10xlx3t5HfgwGaUmgDLKi6wp+Q3En/ms2Tpp?=
 =?us-ascii?Q?CxAXgDKzWWmficCWBBFSRH5LumTSIDT0U94jxo3H7eUBLDYoIM7q7pW7F6E+?=
 =?us-ascii?Q?HXkGayfe9gIGGb5Sv2Nsu+WkY9jq/Pqr2Vt1e1mdGggD1Rxr7xkCxKTkzS3E?=
 =?us-ascii?Q?r/cwTX/CTfw6ao6iIt1hO/QHfO7LrB3mE2arbHPAkw0Y3zF3hK2hPeYz+LO/?=
 =?us-ascii?Q?9O+ic4VLttsH2Xia70NJXB31VfAt3argnJrBm9XoNR1tBTPWmvde3RDWuf5v?=
 =?us-ascii?Q?gKO6mV1IVtm/5OtgKMYZCZf2yCZQj3tVUNFvuS+8vumLVBpdb7Jb7tNup3cE?=
 =?us-ascii?Q?nD3Q3lN0N5pNpakdS4pZ0Tx2uJjjqEdTCrnzON3HR5cghMKv+XjTXANpLLeP?=
 =?us-ascii?Q?mU53Le4UlttDDLGCFwG0oBeCuzL+qZ8XMIPzcy2zBGJ4T1FYk1vLLNe5xCZr?=
 =?us-ascii?Q?5t73PNqFkWYMUtYJPrTY5Qg4cw6B4g9n1lfJ1eRzb0c28JJ4vJkmtCUs0LyG?=
 =?us-ascii?Q?8MNvgyqG32d7KQGjr3ThF8yUH9O9YTE5B/IP3w9LQ7JY6KiGuinHbLmEVnPz?=
 =?us-ascii?Q?rMoPjwKB/uOKbHJXDfjJ4nPE1AZBnYSDtgx3/FaULuRTZBpEGaZVhUXu89nn?=
 =?us-ascii?Q?Iq3BqVCbMranP+RnJXtd3ZVz0GrtTR0D+HCJxMhxzt+ndizaORIyOQDtu/up?=
 =?us-ascii?Q?ep+dwkKZDQ371Iz29wXwZ5G77XOiXtUWrf5WGijAkFdnRlmrx+N5IzjzjeQW?=
 =?us-ascii?Q?5++856TebKhW7QBQBn/8Xoi9LdFG3n6UJJJ4fJZod3dBrDkyFUteP6/z2ZrO?=
 =?us-ascii?Q?ike/ky5Q7SWcbO3S+wb97EbVkwf6aVml?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 15:06:24.4134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1435b4f4-023e-4f38-e2cd-08dca5a8dc19
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB4803
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
 include/u-boot/sha256.h |  8 ++++++++
 lib/sha256.c            | 42 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
index 7aa4c54d0d4..46d20bf9b79 100644
--- a/include/u-boot/sha256.h
+++ b/include/u-boot/sha256.h
@@ -6,6 +6,9 @@
 #define SHA256_SUM_LEN	32
 #define SHA256_DER_LEN	19
 
+#define SHA256_HKDF_MAX_INFO_LEN 256
+#define SHA256_HKDF_MAX_DATA_LEN (SHA256_HKDF_MAX_INFO_LEN + SHA256_SUM_LEN + 1)
+
 extern const uint8_t sha256_der_prefix[];
 
 /* Reset watchdog each time we process this many bytes */
@@ -28,4 +31,9 @@ void sha256_hmac(const unsigned char *key, int keylen,
 		 const unsigned char *input, unsigned int ilen,
 		 unsigned char *output);
 
+void sha256_hkdf(const unsigned char *salt, int saltlen,
+		 const unsigned char *ikm, int ikmlen,
+		 const unsigned char *info, int infolen,
+		 unsigned char *output, int outputlen);
+
 #endif /* _SHA256_H */
diff --git a/lib/sha256.c b/lib/sha256.c
index 64f6b48974b..9a4fd452cd8 100644
--- a/lib/sha256.c
+++ b/lib/sha256.c
@@ -338,3 +338,45 @@ void sha256_hmac(const unsigned char *key, int keylen,
 	memset(tmpbuf, 0, 32);
 	memset(&ctx, 0, sizeof(sha256_context));
 }
+
+static void sha256_hkdf_expand(const unsigned char *prk, int prklen,
+			       const unsigned char *info, int infolen,
+			       unsigned char *okm, int okmlen)
+{
+	unsigned char t[SHA256_SUM_LEN];
+	unsigned char data[SHA256_HKDF_MAX_DATA_LEN];
+	int i, l = (okmlen + SHA256_SUM_LEN - 1) / SHA256_SUM_LEN;
+	int tlen, datalen, len, offset = 0;
+
+	for (i = 1; i <= l; i++) {
+		tlen = (i == 1) ? 0 : SHA256_SUM_LEN;
+		memcpy(&data[0], &t[0], tlen);
+		datalen = tlen;
+		memcpy(&data[datalen], info, infolen);
+		datalen += infolen;
+		data[datalen] = i;
+		datalen++;
+
+		sha256_hmac(prk, prklen, data, datalen, t);
+
+		len = (okmlen > SHA256_SUM_LEN) ? SHA256_SUM_LEN : okmlen;
+		memcpy(&okm[offset], t, len);
+		offset += len;
+		okmlen -= len;
+	}
+}
+
+void sha256_hkdf(const unsigned char *salt, int saltlen,
+		 const unsigned char *ikm, int ikmlen,
+		 const unsigned char *info, int infolen,
+		 unsigned char *output, int outputlen)
+{
+	unsigned char prk[SHA256_SUM_LEN];
+
+	/* Step 1: Extract */
+	sha256_hmac(salt, saltlen, ikm, ikmlen, prk);
+
+	/* Step 2: Expand */
+	sha256_hkdf_expand(prk, SHA256_SUM_LEN, info, infolen,
+			   output, outputlen);
+}
-- 
2.25.1

