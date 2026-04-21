Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65F2F94CA7
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 21:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A34EB83FFA;
	Tue, 21 Apr 2026 23:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="jWbEVKGW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B558D842FC; Tue, 21 Apr 2026 23:10:10 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C88683FFA
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 23:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8MRsE2KtbTPpnDZ1hg0jpKd7xlKTRIaZBm0JLQEsloA/s6RBe2y5BE89sE+a5GUQcAJKg93WeZwEm5WHZuumK+jVERe3M/cFVp2yoAhxPTUm2bkKEUF7i0+BKCTQYmGhZrSjRhI6Ut3NI9Yr/XqSFx7ACGsQbflW6qgg19R3qamuRC0O/elODlr5K5M39d++d9WJ/jQ8J2xX7nn4OT80bj1V8SlDo5Y/ZEsDNiHFzFbeBJ4UkLIKEVU+lP4Xdv8g5P6ppXRtIJrPGFZ0CTnAYsZ/j7PsbDADdc6tUBS1De+oXVZmvK+lZOa+Xv9ni9P056CaNbLFqO5elwP0ixMPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRysJCb1krZYgkjQxUd3ru6dQkUb9EwAJmtzE/bfLRY=;
 b=ANQvgGOrNCxvRcErjhyT4NF+SMF+iL959iqozRAkOsjebkNTZFiOQyhaNIuY4FBSEgw97wxR1xCGuf+cwPOyrRTEpfSsssr3oBtSO+fMNv/U3jQc9fgDldYYqH5r8Pc0eTL7yBz3DMyxa5z2QiexCS51uCeqgn43sLThnSZP5Vz1yJwA1/x5/tAExsIYQ9ktMaerELeVqXFZY/2xYNxYOvPWl8ebj129LEx8mTRcBLkI35j4W8TAKpaGxAJKpY4iCnEkk1TlDpPLDqBJ9J6o1tvJT+Yq21H0aNWzStMYgKT5uVCw8orPTU9mMoebSbKB5UjvRnFl12DnOcDuVBGPPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRysJCb1krZYgkjQxUd3ru6dQkUb9EwAJmtzE/bfLRY=;
 b=jWbEVKGW7RC+X94MT07ghfWzkCY9+QROtXIfdwqb0SqTcQ22OXIDMSPnzt6WJCsd3RdNKdBDVY0mYQ0iIJOYPPkjjhVCmZBQIxKj1TWd9L5+B5B6WiSR40mZ95ZseGJRGL0miq6rYh+2UxlTrpm98vPj0WaZJ497o4+mmEfWTMQZ9KtaxDSy8SSKb82k2a2+2MSxuKs+cPL/sBuauaGgZXDALg2VFxXLsEdXHQoP07UxODE1ahsiUTMG1x166QkrWdKUd25zEFohf1bdLw44kCwjAclUnTeAoiOztjnjFpQSfXf/Y/f49ohg+9ZPhnYFoC70hAtrnnEVhzuHmZ/4Pg==
Received: from PAYP264CA0024.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::11)
 by MRZP264MB3193.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.17; Tue, 21 Apr
 2026 21:09:57 +0000
Received: from PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11f:cafe::7e) by PAYP264CA0024.outlook.office365.com
 (2603:10a6:102:11f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 21:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B9.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Tue, 21 Apr 2026 21:09:57 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id ED50A20931;
 Tue, 21 Apr 2026 23:09:56 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v5 03/15] ecdsa: initial support of ecdsa using mbedtls
Date: Tue, 21 Apr 2026 23:09:42 +0200
Message-ID: <20260421210954.1170437-4-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421210954.1170437-1-philippe.reynes@softathome.com>
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B9:EE_|MRZP264MB3193:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b3b240fe-c708-4daf-9577-08de9fea5776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oiP136Gw1WUshvDEWfi+P1Hpz3BXfxLXpdmTeaY9+t3UVGX7jDmbfeqhZ4dpecDDAiFHe2vU10war4MvzfFSXLC0aL+I8lTdf5AGVEsKf3nSOlybnTdqSDcbRLQzSyBF/NatdAZmNy9/yfYCcQcQvbV2O33wevt+P992YMn14BJSNbZrPbgzEJqPGKVL2TqSCXpx3lVYqpL7XW3akkJDA1wChf6i4AwpxLtCA+UlmksnETI+aBzUkmGy/m8BK08TmWq7TFLG7ibDxipl7Nhj3upFSKS63ObWLRlZYn5Vf8lCJbt1zrIZql8iggitPYeda8EVvfFYZZpHaCvymju2vQXNKCm0DRyL0coo8mTlnu8re1Hx/BFwgpOSzysZez+2ET2dOLAMYkX1lzZvns5Yzs4zJFCmsGeWoA5C5nT/bfYKXZ44JCVJECPKrzJNeweayAdP+R9g4jp8VNP8BTdz3+tHsx6B9AiQBvZ8Sz9NpEDF2/svkfmBz7Fw+a2xsGgiVSl5zs+vfWc0+vSvvOFb45bz94OwNL2Z3fWwn1Zex9IgWQ1WvUnBEOCHfLT+gWFOkzKxphkkM6GZ15kZ8Uvw/4CPj5N1cuhwZA8YBkbKfiG/CIcrViZX7nxTDJ2KUKx136pBXGFa75vhiwfQa5ry0BwQ8GxhK1asvVikMFlx5LOYjkX4o91vLA4iRXGs+hVEVkhYRkiF623Tz326MVPVP0GgaXeDJTEtQ+DnYnFDRJCUwJPkfHO2a1LZphBGBxwOIKZj2u485SLa8tA6Lp3Pjg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GJ7ovVAGCjwPKAMoZU+3U38Gm0hwrcZXSjN8eK8MOme1UBxxVINBM/W9LVePNFG72SlAyzmTv6cp6ieuYEpyIg84Q8MXzraFamRGiIJT8h342gYCBLnonwWWunbBAJh/rsMI+VUU6fpPgq6EX2NoL8U/4DPvNhGs1jdJhwIZcJD/Va0XnqdKxOVFlbiuVEMyYvQrcusYzI+tG0O1gE6atinHCwQxKh0i3s41AP50REjJSluU9Rfnu3ss+gGvkS9SYt0vTNP7ZvxjZRwcXGamtjzLaBk7lW0NOVyA4e9j6L0BG0g+ddE0Wl9YoupkAerEAlx8pPBB00OeB05O05A2EHTHasOBMpJrb9Z3bvXrQhBh4yK7BflAIGoFUtUv83pQuIVkHPxc9uAaxKl6xuFTUHgh0LtQnVjI0iJOxutiv/RmDuYXCF4uhhCkUwbpa1sL
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 21:09:57.1219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b240fe-c708-4daf-9577-08de9fea5776
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3193
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

 include/crypto/ecdsa-uclass.h   |  15 +---
 include/crypto/internal/ecdsa.h |  39 +++++++++
 lib/mbedtls/Makefile            |   3 +
 lib/mbedtls/ecdsa.c             | 146 ++++++++++++++++++++++++++++++++
 4 files changed, 189 insertions(+), 14 deletions(-)
 create mode 100644 include/crypto/internal/ecdsa.h
 create mode 100644 lib/mbedtls/ecdsa.c

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
index 00000000000..fe00797c5b0
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
+ *
+ * ecdsa_hash_verify() - Verify the ecdsa signature of a hash
+ *
+ * @pubkey : ecdsa public key
+ * @hash : Hash
+ * @hash_len : Size of the hash
+ * @signature : Signature
+ * @sig_len : Size of the signature
+ * Return: 0 if all verified ok, <0 on error
+ */
+int ecdsa_hash_verify(const struct ecdsa_public_key *pubkey,
+		      const void *hash, size_t hash_len,
+		      const void *signature, size_t sig_len);
+
+#endif
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index a24c8389744..33698c92282 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -11,6 +11,9 @@ obj-$(CONFIG_$(PHASE_)SHA1_MBEDTLS) += sha1.o
 obj-$(CONFIG_$(PHASE_)SHA256_MBEDTLS) += sha256.o
 obj-$(CONFIG_$(PHASE_)SHA512_MBEDTLS) += sha512.o
 
+# shim layer for ecdsa
+obj-$(CONFIG_$(PHASE_)ECDSA_MBEDTLS) += ecdsa.o
+
 # x509 libraries
 obj-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
 	public_key.o
diff --git a/lib/mbedtls/ecdsa.c b/lib/mbedtls/ecdsa.c
new file mode 100644
index 00000000000..90c9c37e96e
--- /dev/null
+++ b/lib/mbedtls/ecdsa.c
@@ -0,0 +1,146 @@
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
+		goto out;
+
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
+ out:
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
+	int err = -1;
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
+		goto out1;
+	}
+
+	/* prepare the pubkey */
+	mbedtls_ecp_point_init(&Q);
+	err = mbedtls_mpi_read_binary(&Q.X, pubkey->x, key_len);
+	if (err) {
+		log_debug("could not read value x of the public key (err = %d)\n",
+			  err);
+		err = -EINVAL;
+		goto out2;
+	}
+	err = mbedtls_mpi_read_binary(&Q.Y, pubkey->y, key_len);
+	if (err) {
+		log_debug("could not read value y of the public key (err = %d)\n",
+			  err);
+		err = -EINVAL;
+		goto out2;
+	}
+	err = mbedtls_mpi_lset(&Q.Z, 1);
+	if (err) {
+		log_debug("could not set value z of the public key (err = %d)\n",
+			  err);
+		err = -EINVAL;
+		goto out2;
+	}
+
+	/* check if the pubkey is valid */
+	err = mbedtls_ecp_check_pubkey(&grp, &Q);
+	if (err) {
+		log_debug("public key is invalid (err = %d)\n", err);
+		err = -EKEYREJECTED;
+		goto out2;
+	}
+
+	/* compute r */
+	mbedtls_mpi_init(&r);
+	err = mbedtls_mpi_read_binary(&r, signature, key_len);
+	if (err) {
+		log_debug("could not read value r of the signature (err = %d)\n",
+			  err);
+		err = -EINVAL;
+		goto out3;
+	}
+
+	/* compute s */
+	mbedtls_mpi_init(&s);
+	err = mbedtls_mpi_read_binary(&s, signature + key_len, key_len);
+	if (err) {
+		log_debug("could not read value s of the signature (err = %d)\n",
+			  err);
+		err = -EINVAL;
+		goto out4;
+	}
+
+	/* check the signature */
+	err = mbedtls_ecdsa_verify(&grp, hash, hash_len, &Q, &r, &s);
+	if (err)
+		err = -EINVAL;
+
+ out4:
+	mbedtls_mpi_free(&s);
+ out3:
+	mbedtls_mpi_free(&r);
+ out2:
+	mbedtls_ecp_point_free(&Q);
+ out1:
+	mbedtls_ecp_group_free(&grp);
+ out:
+
+	return err;
+}
-- 
2.43.0

