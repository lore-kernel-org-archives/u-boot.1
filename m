Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DDCFF60EF
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 10:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3654B84090;
	Tue, 31 Mar 2026 12:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="kuejoSJn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12FCA840AA; Tue, 31 Mar 2026 12:00:57 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9A9783DBF
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WI51bgvWz+7JQXb/oMU7olezsp9wugAdM8Gzrve8206a7WR0ZiRw4vO8c218p1k7VweaVV0l3ugGyQJKobFF0FpXJqqA37iHVCdEcuoQXX+5Ta8bCAtDvTaFr0Q2No4R6aHjxzjRBGp+f0Zk+9jJ17HBT4SY129+TDUMw467gPj02v6rcQmqhqRT6NciaJO6rudewFFWesCVNGKLtYLeRkAU6BGRict9ExJ92t1qdWEZGk9H4t3yi9Koe2jjDNdJjcD1f3y1GjSjiQ+R7epbncGLylFOkZa1PtzsyFAot6ryd8tzd721Bzwqm3j94aXQxWBA8jhUWdJNr81F7CiiJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTZWzDGwfK65LxDwOFXdUMbbyHDIvcnuXHYKPVjn/e0=;
 b=ecJ40bo/zCMEN3Vi7NUbZqK9/WhMp4nVmkOQjalXAPQtfafzGKU+STG58rd7SZUuExHpGM7UsApRpLw7ALSTvMcVZBBrWJt5ekLx+XGcWD0xwfEuH4SXULtIfyy9t1O5/vcaZhBaMjEiN6x9wqbG43Ah4L6mmNlfpNlQLZcxeEYbDtcElz14vqTQ9TCOHVYeMOs5c3ptyUKXHr9UyXxuMclcKM3VX+ssQnoEUlk7vF5KX3ps2g12H5bFODyrjmHLlzx7cKvwJNZTym//5s1ogHfEVhlLXIUEtu31xAvpDeJI+n6M6uXEGYQ8j+VhG9fSrPxR/m3VofZTDsjY071d8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTZWzDGwfK65LxDwOFXdUMbbyHDIvcnuXHYKPVjn/e0=;
 b=kuejoSJnPpiJp37sggQ1nxXh59Suy+r+0L4MgBof/NwPecSVg1TPAKilsiz5M2SKXmef+I+j/hi8OWY6sWkiQTvnKLmLGo0ra3kWSgGNFmV0wmeEF+rSUsS+h+X58kEQqtZrzsxlJZczPF3u7pV2dC7YFpeRfNYU5xCEdgTHes/LPO80el2G6C3/UO7Lm0q0eiYvqhIp5Hc5jT3sv1KfkSMkH9nRT+ovckbUUF9D1+oD9PQzqxBDulwfiiBTtl92TNGcgsRuRLaZJSnIgLa70cCLP2IfkjDG35xNvY8uqMfvCX1Hoq9ASfQo6b66NqmXmuoD8v+MKO4oo6noXC3zsA==
Received: from PR3P192CA0029.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::34)
 by PATP264MB6790.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:533::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 10:00:52 +0000
Received: from PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:56:cafe::d5) by PR3P192CA0029.outlook.office365.com
 (2603:10a6:102:56::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 10:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B8.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Tue, 31 Mar 2026 10:00:52 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id 850C420389;
 Tue, 31 Mar 2026 12:00:52 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 02/15] ecdsa: initial support of ecdsa using mbedtls
Date: Tue, 31 Mar 2026 12:00:34 +0200
Message-ID: <20260331100047.34618-3-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331100047.34618-1-philippe.reynes@softathome.com>
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B8:EE_|PATP264MB6790:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4d325948-975d-4bcc-16ee-08de8f0c64d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: qzvs8/gNk3u9oM3lTSisF5n3BHGJU/Jv7Nt8HgQ16KGvyVdGf/jNJaX6xzQbARa0rYpoh02Q1m2FXk+yOwTEL+rpDGMFrQw3pC0nJQCP8dGdh7pbdOoLOXAheoDIywqMnAE82p3gTbnLMMYrxHfdkd5v6HxVA5yw3zktQ5zDAPaLggKJjEox6cU8kcwk9DPvooPnCApS5sqe4nF79GyWbmFeYbHvsHniYnO5V2K1Iq3IDhNb0K1ge46OSqVHXiOZCb3aJ9D5snYKrSm8VkAgpRkCHIXP3k2DuIluic6ZzTqa0IR5+rnD50figq2tQHyo94dOSb52eXIFg6B2b/SmDOFPmtaBLLZ7lxYqzfRdTZk3EegKmMrjWYAUQxKtDyTqx6ZKnx1kVLZhWmc10oCZH1SBS05jQ7tGxq+HjYeZT+0eN1NmJFsD0QilDWs9vSACWbtV9Pv60Od7mcJSW0yNLNkRM0OkfE2x4Rzsb32bYcMa8U7Vfrxx/1R7aLGIMrxjDb00MA0wmJe0tgXN455AGS30X1164PeQdNv9XK9xJBtBlx7Cxfrjt5W6k4c3QI0XkmHiP1lLVSKHGv/2wV6BUlucBxZua7dBc+pltRLvjnHfLlQ70LxfXARt6VVKVXiZSo/YR9shvEVy17ErUym9dEDdNPFk9XrNjGiYjasuHDQl80ULHmSgDc8zIhTmiqnsMpeoMlKS/mhlg1Sf08SRiv82DQpFhkBARptC+Zpo3EQ1f0r+CfjWd912/bVlUqgswrZbxnWv7wLFpA1Pn5lGDQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vqod9rMG/6+NaOxgR9V8Lj7ZAtV6R7ErI+Be0pzq8Jh45O8pUmCpf1HhHNVUIwnPgZtAI8dTuyOLneuYhlVqhh3y3KmxLJdmAbDdKdEEOhOdDL8tHZ2J6O9By8iiIxONJqX2F0tZQDTgWuVgFDaPa8or+v+iyG57a0G+R8axWYh4FnOydKa4TL/193RK6sfDl4GwmUde8LmTwql7TrweI1mgMXU2o9npv9XTI8jyJtMndDmJW66Uvlu5rG1MURSOKK/T+UlVB/ydqRwZMSr3oM31SYuvY3jkj7VJ7DKOlU7NKIzpXLCoK25zbInYO3e/mtc/tyoD2aIaaC5egz48kDLgDZ6M5jy+zPp8UtR/k0W9D1eqSnIC3lJqAon/V4k6+3HZTKzdZiTrg42ruzRkEyYlH7o4R1GVo3V50LoWOl5w3icOTA5Qjg0NsoP+irHa
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 10:00:52.6839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d325948-975d-4bcc-16ee-08de8f0c64d6
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB6790
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

 include/crypto/internal/ecdsa.h |  14 ++++
 lib/mbedtls/Makefile            |   3 +
 lib/mbedtls/ecdsa.c             | 141 ++++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+)
 create mode 100644 include/crypto/internal/ecdsa.h
 create mode 100644 lib/mbedtls/ecdsa.c

diff --git a/include/crypto/internal/ecdsa.h b/include/crypto/internal/ecdsa.h
new file mode 100644
index 00000000000..d2edc006cc2
--- /dev/null
+++ b/include/crypto/internal/ecdsa.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2026, Philippe Reynes <philippe.reynes@softathome.com>
+ */
+#ifndef __ECDSA_HELPER
+#define __ECDSA_HELPER
+
+struct ecdsa_public_key;
+
+int ecdsa_hash_verify(const struct ecdsa_public_key *pubkey,
+		      const void *hash, size_t hash_len,
+		      const void *signature, size_t sig_len);
+
+#endif
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index 5433e17cc64..6db06092cee 100644
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
index 00000000000..c2ba5c3d72b
--- /dev/null
+++ b/lib/mbedtls/ecdsa.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
+ */
+
+#include <crypto/ecdsa-uclass.h>
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
+		grp_id = MBEDTLS_ECP_DP_SECP256R1;
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
+	const unsigned char *buf = hash;
+	size_t blen = hash_len;
+	mbedtls_ecp_point Q;
+	mbedtls_mpi r, s;
+	int key_len;
+	int err = -1;
+
+	if (!(pubkey->size_bits % 8))
+		key_len = pubkey->size_bits / 8;
+	else
+		key_len = pubkey->size_bits / 8 + 1;
+
+	/* check the signature len */
+	if (sig_len != 2 * key_len) {
+		debug("%s: sig len should be twice the key len (sig len = %ld, key len = %d)\n",
+		      __func__, sig_len, key_len);
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* search the group */
+	grp_id = ecdsa_search_group_id(pubkey->curve_name);
+	if (grp_id == MBEDTLS_ECP_DP_NONE) {
+		debug("%s: curve name %s not found\n",
+		      __func__, pubkey->curve_name);
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
+		debug("%s: could not read value x of the public key (err = %d)\n",
+		      __func__, err);
+		err = -EINVAL;
+		goto out2;
+	}
+	err = mbedtls_mpi_read_binary(&Q.Y, pubkey->y, key_len);
+	if (err) {
+		debug("%s: could not read value y of the public key (err = %d)\n",
+		      __func__, err);
+		err = -EINVAL;
+		goto out2;
+	}
+	mbedtls_mpi_lset(&Q.Z, 1);
+
+	/* check if the pubkey is valid */
+	err = mbedtls_ecp_check_pubkey(&grp, &Q);
+	if (err < 0) {
+		debug("%s: public key is invalid (err = %d)\n", __func__, err);
+		err = -EKEYREJECTED;
+		goto out2;
+	}
+
+	/* compute r */
+	mbedtls_mpi_init(&r);
+	err = mbedtls_mpi_read_binary(&r, signature, key_len);
+	if (err) {
+		debug("%s: could not read value r of the signature (err = %d)\n",
+		      __func__, err);
+		err = -EINVAL;
+		goto out3;
+	}
+
+	/* compute s */
+	mbedtls_mpi_init(&s);
+	err = mbedtls_mpi_read_binary(&s, (unsigned char *)signature + key_len,
+				      key_len);
+	if (err) {
+		debug("%s: could not read value s of the signature (err = %d)\n",
+		      __func__, err);
+		err = -EINVAL;
+		goto out4;
+	}
+
+	/* check the signature */
+	err = mbedtls_ecdsa_verify(&grp, buf, blen, &Q, &r, &s);
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

