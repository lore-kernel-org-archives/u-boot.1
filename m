Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F62CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24CC784922;
	Mon,  1 Jun 2026 15:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="dR6gG4Ll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 773CF848F5; Mon,  1 Jun 2026 15:43:19 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5189B848A6
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYizRmPY4eqDrTJG96x8fIsY5h45oD+9XsY0ly+DDBT6z2BD4p0bvFfJanfXt8faLNzjHsFDoKC+LqSl0xTuyBZHbAGJt7gE0QgEw4nb++LZ9nL8hzh8ucMqIe/x4BvzLt6aDZCCpn89lKWp1QG8d2UJyMJAeOUFw7HxjEAtRzNmvwnwic+mEXLXyPigb2xagpoTl7cRxvzMS++2c1C7H62oW3MiksqKxGjGakr8V+k/0WPejLce+vL/TTvtuQZJ5ikYXPyrhWY0Buk9wss6AS4AZqdJGZY1cmUvfMJPpdh+eJnkIsJVRU5LGTyFZ+pOwNcQsqfmQTqVqc256HNwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJvXvkmqGakL5BiGqfihz+6JwIQU0YqQpPpRFR3Zc9A=;
 b=LtiKTL4SZ59d2vESnuwGjEUP//5K3OugrRI8g14uyJmm8lKpWzv22e1prMjODXkLluJ7+0eh7tMDbyT2qccg6dWb2SpPzDPtJQ4YIm0J6lV8Q9xcyazOJYJhia5BzJ7dQcMYJKTqN/GDGHhcRzPGmnF5UEklAMKc1llEtDXSD4bXBe2ifcrUMaN6WcsgJ6qbYSQr4lw+pT544ghW9aVW/50TTd3a/pF2QKOFx9OEG7VSdTD4fH5++dTHE/BBIUbF0xlC0NW8bRvrJWTm1BzCaonEfbOHkS193AzSZY7Ccn3lH/Z5dNUynrc805AYyMo7yPVCPgNKgFe1/nfkEdvjwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJvXvkmqGakL5BiGqfihz+6JwIQU0YqQpPpRFR3Zc9A=;
 b=dR6gG4LlaJzaLUfbE1QzC47+KdbkgDzLzC+mo7daRZCqzt2p3iUedJr0EikhYEmRQ1wPsk9JgNcxwmxK7LRwBeGhYtW8oAntqfKsmTLnmcPq3hlQS7vL8QdEuFLFinJiszQteCwPAt760gjBvT8oALddGv65yKtlIoAdjUb+6OWbW9sCYJcz8CRXe5QPu0NgEmd88thEvJlBfpSmEVzZ9UPcwR8xe6yFroekvhnFh4Q572qlwis2Kzmc8uFFjZWljZSKIaiYyLwhaJfv/yCY0MVII89JyVMDcX7d9iBIzv5N4pi0RG7b7t0X6BeDPZ9nw7oPrTxP6v1rNC7dunnekg==
Received: from PA7P264CA0506.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3da::28)
 by PATP264MB7194.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:58b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 13:43:15 +0000
Received: from PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da:cafe::39) by PA7P264CA0506.outlook.office365.com
 (2603:10a6:102:3da::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 13:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019232.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Mon, 1 Jun 2026 13:43:15 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.66.192])
 by proxy.softathome.com (Postfix) with ESMTPSA id 629D021372;
 Mon,  1 Jun 2026 15:43:15 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v8 03/15] ecdsa: initial support of ecdsa using mbedtls
Date: Mon,  1 Jun 2026 15:42:58 +0200
Message-ID: <20260601134310.2452454-4-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601134310.2452454-1-philippe.reynes@softathome.com>
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019232:EE_|PATP264MB7194:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a6efa70d-e38f-48be-1ca1-08debfe3bb61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: GYEcyTbVsW7M3kA6Oahs8WeUukfrSTE8a52AiEXckdiwHvR/ZFsIDFPGaqloqs/Dky1lmTTcmLJ81rxmtyYS6tslVeu+EuH5SWDC/nQfxRHTRtwL5B81DPh5hfVkXsc6fnrkoAbLREzOughvtdph5cesp27PwX7TjYXd6zGvrf3g18+KfNK76bpRLP2CeJcWTIQfcsuaxWNzbEXulbvmfvWM+OKhC0cJtzlcsxcv05b+TsytSXb2k2bZf7QPPA/SEgkzOK1hnvFUq/9463OQc1ab/hXjyGpIO/BTx4EioNgYIfimTELGhknQmMJBWbqd+3wa7AlNuTHaj40CqkeTD8DGF2aLjAL7QvGpvTRJB8lLqjzsWcY10KOGH4bhV4gTezj61oDOt9BeiVOuANOTtGFtiSf34PWyGkphfKCDWVs9UCLiuUZS4FtiHRFBOZwLXMWdGIzlwxVd3QLXt7bvytx7Nw/1Y9XbaVXUmguqSNOSe2GgMN49ggLG4xd6Cu8lhgVVLsnWxtEBmkKHr5aqgmeZTLrQMASKaNs+RAHfAqYajo4A4iEa9HyM8Ije9FbuuaK88GLGoC0hBqfOZqj4Jk6Lz6aCfPB7v6mQ6a01SKiQPTmJ97sOYaL2Hep9qTYGr+wyQhpe0YBcF3R3fpa4qnEPSq5tQQpEMZIJrAGCCV2oEPYM31hlIJliTQFedhzW7Kei+9afYjEW7ENDMjOIrC8Sad8lrHEsBclFmGO1Huw=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FiDvKdEytmeiEzpF6M/nPfHHt3JVUVxYYLn/sbCuROwN9wl8i+mK3mMu6fNsehumdt30pxYa6mVVAyrtAUBZbVg/DjTvJvpKDgjaBC68cry740u81sovX2XVi3EEhltzOR15nqmrrsDlr3hvcATx1TZx7HfgAJPOGn7k/tYFakcXyyGinv7LXjllDPU3p7oLIvHr/irUUkWGpozd+DupM1XXvmYS8pMkGTFTijh9RkEwjIsVaSuUcNI96UsGbfaHdc1sL0ElU+EHJRLV4XDT7yo0+cezUxJrx1XLvTxeBsHTnL1wBUAXVKhtGzCEKFMx8/i9BSIIoycMzCM3jEH3ErzUBSJGqQRMOumFyuLnfAtOS1M9kCfIZ4cYBFN2SnWcRyAyy/BkVtpmS6Qn8L5FOY8h7nQgcWj6eJZ6CJFS7YJ3g5dRWxboUnmcHYd4VDfG
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:43:15.4897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6efa70d-e38f-48be-1ca1-08debfe3bb61
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB7194
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

Adds an initial support of ecdsa verify using mbedtls.

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- rename sw_ecdsa.c to ecdsa.c
v3:
- rename sw_ecdsa_verify to ecdsa_hash_verify
- stop on first group found
- check signature len
- use debug instead of printf
- check function returns
- fix memleaks in ecdsa_hash_verify
v4:
- move struct ecdsa_public_key from ecdsa-u-class.h to internal/ecdsa.h
- use DIV_ROUND_UP
- some code cleanup
v5:
- add kerneldoc header for ecdsa_hash_verify
- read error when setting Q.Z
v6:
- add ECDSA_VERIFY_MBEDTLS
- fix kerneldoc: doc not add a space before :
v7:
- no change
v8:
- add some useful comments
- avoid using label such as out1, out2, out3 ...
- code cleanup

 configs/sandbox_defconfig       |   1 +
 include/crypto/ecdsa-uclass.h   |  15 +---
 include/crypto/internal/ecdsa.h |  39 ++++++++
 lib/mbedtls/Kconfig             |   7 ++
 lib/mbedtls/Makefile            |   3 +
 lib/mbedtls/ecdsa.c             | 152 ++++++++++++++++++++++++++++++++
 6 files changed, 203 insertions(+), 14 deletions(-)
 create mode 100644 include/crypto/internal/ecdsa.h
 create mode 100644 lib/mbedtls/ecdsa.c

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 03c35429bc6..9ff1afe4e64 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -382,6 +382,7 @@ CONFIG_CMD_DHRYSTONE=y
 CONFIG_MBEDTLS_LIB=y
 CONFIG_HKDF_MBEDTLS=y
 CONFIG_ECDSA_MBEDTLS=y
+CONFIG_ECDSA_VERIFY_MBEDTLS=y
 CONFIG_ECDSA=y
 CONFIG_ECDSA_VERIFY=y
 CONFIG_RSASSA_PSS=y
diff --git a/include/crypto/ecdsa-uclass.h b/include/crypto/ecdsa-uclass.h
index 189843820a0..047a5eda2fc 100644
--- a/include/crypto/ecdsa-uclass.h
+++ b/include/crypto/ecdsa-uclass.h
@@ -4,20 +4,7 @@
  */
 
 #include <dm/device.h>
-
-/**
- * struct ecdsa_public_key - ECDSA public key properties
- *
- * The struct has pointers to the (x, y) curve coordinates to an ECDSA public
- * key, as well as the name of the ECDSA curve. The size of the key is inferred
- * from the 'curve_name'
- */
-struct ecdsa_public_key {
-	const char *curve_name;	/* Name of curve, e.g. "prime256v1" */
-	const void *x;		/* x coordinate of public key */
-	const void *y;		/* y coordinate of public key */
-	unsigned int size_bits;	/* key size in bits, derived from curve name */
-};
+#include <crypto/internal/ecdsa.h>
 
 struct ecdsa_ops {
 	/**
diff --git a/include/crypto/internal/ecdsa.h b/include/crypto/internal/ecdsa.h
new file mode 100644
index 00000000000..244a07d1f1f
--- /dev/null
+++ b/include/crypto/internal/ecdsa.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2026, Philippe Reynes <philippe.reynes@softathome.com>
+ */
+#ifndef _ECDSA_HELPER_
+#define _ECDSA_HELPER_
+
+#include <linux/types.h>
+
+/**
+ * struct ecdsa_public_key - ECDSA public key properties
+ *
+ * The struct has pointers to the (x, y) curve coordinates to an ECDSA public
+ * key, as well as the name of the ECDSA curve. The size of the key is inferred
+ * from the 'curve_name'
+ */
+struct ecdsa_public_key {
+	const char *curve_name;	/* Name of curve, e.g. "prime256v1" */
+	const void *x;		/* x coordinate of public key */
+	const void *y;		/* y coordinate of public key */
+	unsigned int size_bits;	/* key size in bits, derived from curve name */
+};
+
+/**
+ * ecdsa_hash_verify() - Verify the ecdsa signature of a hash
+ *
+ * @pubkey: ecdsa public key
+ * @hash: Hash
+ * @hash_len: Size of the hash
+ * @signature: Signature
+ * @sig_len: Size of the signature
+ *
+ * Return: 0 if all verified ok, <0 on error
+ */
+int ecdsa_hash_verify(const struct ecdsa_public_key *pubkey,
+		      const void *hash, size_t hash_len,
+		      const void *signature, size_t sig_len);
+
+#endif
diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index e019f17d6bd..66bc16db451 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -308,6 +308,13 @@ config ECDSA_MBEDTLS
 	  This option enables support of ECDSA with the MbedTLS certificate
 	  library.
 
+config ECDSA_VERIFY_MBEDTLS
+	bool "Enable ECDSA verify"
+	depends on ECDSA_MBEDTLS && ECDSA_VERIFY
+	help
+	  This option enables support of ECDSA signature check with
+	  MbedTLS certificate library.
+
 endif # MBEDTLS_LIB_X509
 
 config MBEDTLS_LIB_TLS
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index 0c86c90d15a..b96db812afc 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -11,6 +11,9 @@ obj-$(CONFIG_$(PHASE_)SHA1_MBEDTLS) += sha1.o
 obj-$(CONFIG_$(PHASE_)SHA256_MBEDTLS) += sha256.o
 obj-$(CONFIG_$(PHASE_)SHA512_MBEDTLS) += sha512.o
 
+# shim layer for ecdsa verify
+obj-$(CONFIG_$(PHASE_)ECDSA_VERIFY_MBEDTLS) += ecdsa.o
+
 # x509 libraries
 obj-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
 	public_key.o
diff --git a/lib/mbedtls/ecdsa.c b/lib/mbedtls/ecdsa.c
new file mode 100644
index 00000000000..ca4e572e638
--- /dev/null
+++ b/lib/mbedtls/ecdsa.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
+ */
+
+#include <log.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include <crypto/internal/ecdsa.h>
+
+#include "mbedtls_options.h" /* required to access private fields */
+#include <mbedtls/ecdsa.h>
+#include <mbedtls/ecp.h>
+
+static mbedtls_ecp_group_id ecdsa_search_group_id(const char *curve_name)
+{
+	mbedtls_ecp_group_id grp_id = MBEDTLS_ECP_DP_NONE;
+	const mbedtls_ecp_curve_info *info;
+
+	if (!curve_name)
+		return MBEDTLS_ECP_DP_NONE;
+
+	/*
+	 * This curve name is read in the FIT metadata.
+	 * When this FIT metadata are filled by mkimage (or binman),
+	 * the curve name is the alias/name provided by OpenSSL.
+	 * And for secp256r1, OpenSSL uses the alias prime256v1.
+	 * So here, we have to manage this OpenSSL alias.
+	 */
+	if (!strcmp(curve_name, "prime256v1"))
+		return MBEDTLS_ECP_DP_SECP256R1;
+
+	info = mbedtls_ecp_curve_list();
+	while (info && info->name) {
+		if (!strcmp(curve_name, info->name)) {
+			grp_id = info->grp_id;
+			break;
+		}
+		info++;
+	}
+
+	return grp_id;
+}
+
+int ecdsa_hash_verify(const struct ecdsa_public_key *pubkey,
+		      const void *hash, size_t hash_len,
+		      const void *signature, size_t sig_len)
+{
+	mbedtls_ecp_group_id grp_id;
+	mbedtls_ecp_group grp;
+	mbedtls_ecp_point Q;
+	mbedtls_mpi r, s;
+	int key_len;
+	int err;
+
+	key_len = DIV_ROUND_UP(pubkey->size_bits, 8);
+
+	/* check the signature len */
+	if (sig_len != 2 * key_len) {
+		log_debug("sig len should be twice the key len (sig len = %zu, key len = %d)\n",
+			  sig_len, key_len);
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* search the group */
+	grp_id = ecdsa_search_group_id(pubkey->curve_name);
+	if (grp_id == MBEDTLS_ECP_DP_NONE) {
+		log_debug("curve name %s not found\n", pubkey->curve_name);
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* init and load the group */
+	mbedtls_ecp_group_init(&grp);
+	err = mbedtls_ecp_group_load(&grp, grp_id);
+	if (err) {
+		err = -EINVAL;
+		goto free_grp;
+	}
+
+	/* prepare the pubkey */
+	mbedtls_ecp_point_init(&Q);
+	err = mbedtls_mpi_read_binary(&Q.X, pubkey->x, key_len);
+	if (err) {
+		log_debug("could not read value x of the public key (err = %d)\n",
+			  err);
+		err = -EINVAL;
+		goto free_q;
+	}
+	err = mbedtls_mpi_read_binary(&Q.Y, pubkey->y, key_len);
+	if (err) {
+		log_debug("could not read value y of the public key (err = %d)\n",
+			  err);
+		err = -EINVAL;
+		goto free_q;
+	}
+	err = mbedtls_mpi_lset(&Q.Z, 1);
+	if (err) {
+		log_debug("could not set value z of the public key (err = %d)\n",
+			  err);
+		err = -EINVAL;
+		goto free_q;
+	}
+
+	/* check if the pubkey is valid */
+	err = mbedtls_ecp_check_pubkey(&grp, &Q);
+	if (err) {
+		log_debug("public key is invalid (err = %d)\n", err);
+		err = -EKEYREJECTED;
+		goto free_q;
+	}
+
+	/* compute r */
+	mbedtls_mpi_init(&r);
+	err = mbedtls_mpi_read_binary(&r, signature, key_len);
+	if (err) {
+		log_debug("could not read value r of the signature (err = %d)\n",
+			  err);
+		err = -EINVAL;
+		goto free_r;
+	}
+
+	/* compute s */
+	mbedtls_mpi_init(&s);
+	err = mbedtls_mpi_read_binary(&s, signature + key_len, key_len);
+	if (err) {
+		log_debug("could not read value s of the signature (err = %d)\n",
+			  err);
+		err = -EINVAL;
+		goto free_s;
+	}
+
+	/* check the signature */
+	err = mbedtls_ecdsa_verify(&grp, hash, hash_len, &Q, &r, &s);
+	if (err)
+		err = -EINVAL;
+
+ free_s:
+	mbedtls_mpi_free(&s);
+ free_r:
+	mbedtls_mpi_free(&r);
+ free_q:
+	mbedtls_ecp_point_free(&Q);
+ free_grp:
+	mbedtls_ecp_group_free(&grp);
+ out:
+
+	return err;
+}
-- 
2.43.0

