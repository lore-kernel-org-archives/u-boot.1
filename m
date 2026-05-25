Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B348CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 13:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A53B68486A;
	Mon, 25 May 2026 15:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="UQM83PzP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B572B84851; Mon, 25 May 2026 15:52:55 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BB18847C4
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqf0fz5ZWHqP56Mk0ya1htdlUauzb0X45AgIyhXfrpcuA0US/yGRpVrh9+FEd1N2QqmD2VwvnCHELB47ZwQFZ4ZZLWxQo3hcll4QOZFAra+ucC30SZqoXXUkpBjEGRAvc6qYgIYZ+8OztdLGqhFSk0luoXFef4+YVIZOGDHu2niL+ra3VZ19cDMc6ewEROxiXeiOX6kOkoMvPaVLo6EqAIuGTAjDKvqW/i5BLDTjUKzHPuAiv+7DVhKzGtKGnxpoS4s5O0YI1kI61qWVBQvP8grftnXGvBnDleUj/EgahKFgQ7INhGLzqt+DONNDfMO8RD+uVqclfogPJv6SmN94rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6pyrmps59hrNobA2k3bSbpXNeEsDf32LywBkDQkF6k=;
 b=azyx78CLHKwRryLtURRubQ3a2DbUlLoIiuOe4nd3NGNnuNNObj0d1RTKkMtacJfGaEsDwi8FZvpc3tN76qzAmXL7hdwXIH90G0AktQb7rPgqfmrNe2dDIY7WPEiftTssJhzXonykROYOxzJAC2+jrFmsWb6cRqulV7/FOb2AouaYs8TEmaPnLjr6vNz2QEyCFJrFWOQ4lXJf4rtcDOlKmLXVQHDNGushOOeF3YNCAf3ragJhsMLm1Fo+K6DSqRXwCPDEE0USy1gtXoUEPxalOVYODWMtDVIiXBW6voamZjxfn1b+k0FRzI6NejlVAYRDpmsnGX+eZ3gUyqlhHKCnVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6pyrmps59hrNobA2k3bSbpXNeEsDf32LywBkDQkF6k=;
 b=UQM83PzPyuq08K+J+6i9sA7RnG26uI37cqOsnLrJWt5oArhKB8so274Kyx9QV81PBzWtGu+1rSIbvQvg4c7st0M4b6Hnrt4/u0F0z0ln+dAg2NiaVWajFjB82p5ad3JbmoZ2/vTIGMV/yk7onok8yFYxh+HwwUoUM47PO6nRrxTorVMSOfomODLvYFP2nQAfBEJ14UNU2Qxba+CZZbr0IK9XHn7ae/enJDlm97fCwNbKmAEeWP2ktaZyZZWXdfNonjRyR3PKx+I5mJbjKuMbNDWEyovIu9efCBMScRN41SYf2maXD5iEeKC4SVjYYuoC3bOSx/Io0eHaui39g70NMg==
Received: from MR1P264CA0197.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:57::12)
 by PR0P264MB3338.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:147::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 13:52:45 +0000
Received: from MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57:cafe::65) by MR1P264CA0197.outlook.office365.com
 (2603:10a6:501:57::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 13:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D57.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Mon, 25 May 2026 13:52:45 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 1540320433;
 Mon, 25 May 2026 15:52:45 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v6 03/15] ecdsa: initial support of ecdsa using mbedtls
Date: Mon, 25 May 2026 15:52:29 +0200
Message-ID: <20260525135241.88348-4-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525135241.88348-1-philippe.reynes@softathome.com>
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D57:EE_|PR0P264MB3338:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e45bbec2-9857-4ab2-9c14-08deba64e629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gh467lS9suvHZpdXn2xUvcJWktkgaZrWk4ne8PUn8fjiuxf71KQuJxuriqtZfMidbL7itTChtH2roYDcdwbhX9KgQMz22I+cMsGsG7MpVRAd7DFSy74ZAk+qR0a3EvUvMsJyou/Go4haCb7cwQnZCcz2RawfGmuH90KswwSw2HypRAwJlNyaWnpiKLfo83g3uWgkd30sPcCRN89h7GmbHJ5accc3vEyKFFUGRgLpm1o4emRONnqFuKzcIMZvMVK/8KukYDpC+pQjEfid5vm+DNeKCKxXhH7VTDnNAsIgwGr6+pwrFVxiw6PBY4UhLXmTh79HijNt5COfZ5L3nYAJ9nEdAioBqvLIOIEXAyQTzVlz1SunKWWrrLhNhZNUaF/G/BHNqCKV39VA3eWcU9U0J/lQnW7tlBgTFXaNCxnH4BTHfs76cJRJamgazFJJJVFvtSUIaeWDv28JE5F871S7p8elDpuMUSiBpcL6qAiJCq2gr9vXjbTK9hl6LRWZj5vT1R2rhVDw0rPZ2EV3LTXaOtOLMRR93XRzcpIzIFH1xJEB48rN03R1pr50pLTLOmLE1kHw6H8XI/pRrGSAbVXlIw4on/AntCJFeZsWu4vOWfdXsJJ3ss2wJhuQNBFlg72x4QYMdkAZBR8JHFnYZw0MBhvQtebgs8CuBzWetb00gJN32u8mXWn46Ps1rYVtAEpS7M8FSdpcUexJ3IvPaSBmdZS8N0YGGxBGs8gD4cJapt0=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4WVQbCd8OZ2cS2TU+2hyLD5PhtcSyUj+wkQcWMwfg2sxIR0tc+DJcQAZTNFLod5wCfKogWjls7/jRWduQ0E8RS+RuoBLdDuxMwE2dUN1vklbHk4xVBYzB0joiJFkiPE4xEICvsHjfgEzF31Altf62MNegrDMpuB1+hkT6sHlVdwcKa/EYGZSuUeeRKtg7GRc3OqKifE9FANEOkBqQi8Q4c7SvkgsOoP/Kiq6dLWNtpxz/UI56WJOGzcsz0qh942hMCadxQvQCzK46lcmg8Lle8VHcmuGRc9Y+XZfErHRoSZDnX/5SyhCHRa+wC/LcdlTxZUDS0ibSU2ypyxp6bMTqoD4ciowB5mEF26uNzXY0KGP9hkc4j8iNQz9Jy3hRfmfoWLY7wMtjqbiiN3a1GKerda9dVlw/JBtjmidqKWsq+bIe6fwOF73b/3/u4NfCXth
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:52:45.3496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e45bbec2-9857-4ab2-9c14-08deba64e629
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3338
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

 configs/sandbox_defconfig       |   1 +
 include/crypto/ecdsa-uclass.h   |  15 +---
 include/crypto/internal/ecdsa.h |  39 +++++++++
 lib/mbedtls/Kconfig             |   7 ++
 lib/mbedtls/Makefile            |   3 +
 lib/mbedtls/ecdsa.c             | 146 ++++++++++++++++++++++++++++++++
 6 files changed, 197 insertions(+), 14 deletions(-)
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
index 00000000000..117e4995513
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
+ * @pubkey: ecdsa public key
+ * @hash: Hash
+ * @hash_len: Size of the hash
+ * @signature: Signature
+ * @sig_len: Size of the signature
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

