Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61431F4369A
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 13:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4763843C3;
	Fri, 17 Apr 2026 15:02:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="Oe5vKxHw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F8C384320; Fri, 17 Apr 2026 15:02:21 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DF2684326
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 15:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNqXOan3JCFcxAuoqb/oUd6GC1+2/A7a2GSjVonCbrdDlemxXDnauEVrJkBUSNVWxGD11XvoahP46iUEI0zrAr73a7dddRDUG5YJde/6u7/TdLQEgJsW0xilaaNK5X1qZzIB/fIqSiS51cTuy5MkvRnDDB1AkLbodFOo5LJL+enbOoobWw0qZlUu2mwob9Kt4xXjO+Fm95dCmJDx6IophcKtQOCwLPdBzsfcwpQaJ6ZjUcW4/S2LEQkxkxcw0x6qDnUYxy3z6rP+XXxaF3lPx5k0oE8/nGby9WrB5WQdEt9ByGAvY5H6wvaub+5luBfEeoEoUjuj6LeNGn79LXYsjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ri0B6qHd1MC0/vpR1HnihbjRsZs9sZYbjoAhZ9itX0o=;
 b=P1hRbPkn78t3AdH0gtrr4kULnyVpCR9jpJFA70+qXvW0KsFUT1+7i5MVbEQcalyes+k9p3zTG3HxjnruxSS1iCrNsFZI4AT4HldqZaYa8sX1pI++QSVsCGXeBY4YYyP8NvVh/XiSKCE3Dp3t6fNfwWn+hvc3x/NkLoiTZ1uP17Q9K1zcK10aAiYESmfQOrqxZT6s9v5Q7ZsTBbh1QzIEM7ue2t05lAbyGrP9HSmhb8bAGwVoz5SKj/gXuezsGnZLODTo+CYxruURi0nYidZAKHz/RvgT6mEXgrag0vlry/8dX2i65YPAS2R+SiRwxdZzSTt6CHDl/pHPAnf7kTGsQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ri0B6qHd1MC0/vpR1HnihbjRsZs9sZYbjoAhZ9itX0o=;
 b=Oe5vKxHwE2nLpAOfxjb99gHLUwElyoZCoHT3khwAfXhbPFyGj7HoA/iqKK+cRBAyvUHXlRqcfFnmfe9hHX/GEotqmLTf9wb5k7ZJAk7MANMtzVBJyp7LrrJzd/+ljlEdUkXWdvziHQ2XAgxcg5kMOQDXrnR/rqVRFAE326JXsyzLplTWIngnUPDLakK7TIGs7W2aM5AKdk7Fwm9ZUBxdzxGUaSNGUUN5cZ/+NBcJ+9KnWfOLcQVmjy87lyxiehdFBcOJkM6lGgRgQZqB6l6ZmMdZNRiKs+tSIMLLaAIgRpZR7D78lMYBEbkZzpASgczaXSaepwAwPhryzuEQTPGxKA==
Received: from PR1P264CA0180.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:344::9)
 by MR1PPF5FEA73388.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::64b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Fri, 17 Apr
 2026 13:02:10 +0000
Received: from PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:344:cafe::a7) by PR1P264CA0180.outlook.office365.com
 (2603:10a6:102:344::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 13:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019231.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 17 Apr 2026 13:02:09 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id AD52720C30;
 Fri, 17 Apr 2026 15:02:09 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v4 02/14] ecdsa: initial support of ecdsa using mbedtls
Date: Fri, 17 Apr 2026 15:01:52 +0200
Message-ID: <20260417130204.49896-3-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417130204.49896-1-philippe.reynes@softathome.com>
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019231:EE_|MR1PPF5FEA73388:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e0d456a0-d948-4818-fd29-08de9c81891e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: qC63BeXUKPI4UtJJVbdo1EkkAbNRNEyxirm6ehra+088ErcOA8wGlBmvlpeQ63zS2Ab9EokQYdV/VLeNZdD7kMFdse7KnAPDc60Fq2vIJuAQGz7Vktd0KCue/h/00MKz1aVCTa/PiOyfZCkYslfPwgGgWlGH6ZnsNsE2r+kQc1qj3auBfaPfo3oxbduB8a6IRawoLnMc+GZUbWGgj3OhWqCrm7ubT2MSlSIcH3AeUWydn1LaI+8HyQJVo3AdjBaCL/M0Ims+VLWqxaVZOa44WnWBD0uuS+CjUZACtcE4Mm8XPxuuGAjB7/mXq/yx7kkCOZgQS1+AVmBZ+00kKTb8dLa/Ub7iC7FrWszu+YW1RAn6Oe5QJDYTTEUy8Rga7sASXWozzbKxFTFi+d24B/u2dVTbXwCp7rRmJGx+2+KCoUiCXRvAVEFIymzAJCBnmTQ/ZbtIjcGg7pwRi8Dlh35TabCDeJh2kKoNj5+iNUqlGPMOCu4OydCvXbXea2HvXAGGn8ucM0GSCDDdbJTCAHDRhGqTPlsYbST6vEmoDV+M+2Nl6ARrKZGpU5jwYCbBRH1lJaH4Ou2oEV96XDzV0kg0Qs6/yeEW2n5HD6fno5zQMhD3Q2zwpQM3V/3okeXHl9c0tDlPl6RYaSh+ObWB74oZpro7QRtMKJ1EJmEzQmVC/lK8r5YNVhsf5LpKHf0NpCcmrcgmllIVZ6GEkzMBgY0QO6Hd+N1LJ0vWfkY+MYbHY3W2Sfaf8xrRZ6wgFhMFD9Wwcykm/FkovVIefCAO1UVo5g==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x4B/HbeeXtpw8zpicH6tlTcNkBchJvxsil44s5Xj6fuusmgk0YE5R7Q++I7qECxVVBj/I/t6ZiA7E375dYYbR/7NZOXlmiT2rn/wsqkQUZMcEavPNA0qtu4kUW5c0MPndn5dZPa9KoaXAAba+bhWoXVYmBh00BXbDxJ9giSi+DXCkNDewXIktO+TZoyYz4b7s9e0g51j47/Vkp6iEhghV8zC3S0whW4qyqdSAAQLgDY8I/UF9DSiNOElSipS/dKkrv5jRE4YWsOi5I1VE2en4pcJ1tz2z6bAMf+mBIOPKY99PnCcZkvTOLwb5sz+IZu2wyq99WtaqeDySHcFErkkvGgfuzPymXCXRhaYW+Ys4+BiMdcWhnJnmOCuFBdkExfaOZBdpifHfs+xkInchSqjHPboDZ0nqYqnz29/+g+4Vtfeb6p8Aj5x/zyFYmRWpH7n
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 13:02:09.8324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d456a0-d948-4818-fd29-08de9c81891e
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPF5FEA73388
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

 include/crypto/ecdsa-uclass.h   |  15 +---
 include/crypto/internal/ecdsa.h |  28 ++++++
 lib/mbedtls/Makefile            |   3 +
 lib/mbedtls/ecdsa.c             | 146 ++++++++++++++++++++++++++++++++
 4 files changed, 178 insertions(+), 14 deletions(-)
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
index 00000000000..bfdc137091e
--- /dev/null
+++ b/include/crypto/internal/ecdsa.h
@@ -0,0 +1,28 @@
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
+int ecdsa_hash_verify(const struct ecdsa_public_key *pubkey,
+		      const void *hash, size_t hash_len,
+		      const void *signature, size_t sig_len);
+
+#endif
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index aa1ca6d196b..d872c0eb788 100644
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
index 00000000000..a87b0d0e17f
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
+	mbedtls_mpi_lset(&Q.Z, 1);
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

