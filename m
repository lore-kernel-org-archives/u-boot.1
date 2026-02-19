Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9B5E9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAE5E83D77;
	Thu, 19 Feb 2026 14:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="itqNaO07";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02A3483DEA; Thu, 19 Feb 2026 14:26:19 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DD1983E13
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2ivFO87MAjN31wTR+wTuTdKX60qcPJyYt4+gWm0X2Z+mzj5zR2/8StbuRnbYHfpaFq55DeloTIB5z1i0n3Owpf3eB8ARInQsubYtUcVdOwVjkWTJqLkLmvEZTNPLOYCtEfDTtUja2Y3IAQek9VBip5x4LXW2lsebN1Xk261m9X6wyX9rLWCm6QeVylSWvL9imHDNaQZAX8BT/Y0O50AjaxbLuDQ2QW+ikx88S0zb9mtFReR80wFYkDU3E7pxXy6Y6lE/zKwb6L90c5oyhvFx3EaHH3nlOrmeYjQjRi23kbRzmsf05bELy8OIxXbvXIzgg85JZBBj8ofyyHkcnDxkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/EEO1obV9ybkajF8thngPSVoC7K7xrt0ADu/A8qLFo=;
 b=siQyAjy/A/FTEnnhVCDCD4mS3aZDvpw+vKRd6g8h+mHpacPBGDSZDrEMtWCC3A9hD7/EwkpXddboiRodxyuTRNTyeYPO8P0c4yB8U9abU9vwVixCZfjAfWHtWFYBKPp4x7HncG5HLStVA9AtCJzA+yWbNULvm7r8Ju0XjY+bDsRqqOhe5bVvVvzIaBkkbFfiqLw9dIUibmC7+bf5mzHc9M+XeTvJp9v+Cj5wfk0BzfPMi1IlnotmcQvDAaZL+Xh6aM90MnvmOxm9jM2of6r3UotFmrJrFkrkmGJSYqbJss1I3hwPcHuPRmiQG1Si5/4CG8Dh3k70YkAr2Y5lIaTB2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=gmail.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/EEO1obV9ybkajF8thngPSVoC7K7xrt0ADu/A8qLFo=;
 b=itqNaO07k3Gap9HlG+A5R8tDJA4RZF5uKRpHxqXi/KcYPGE03NOBWO+5XxCuRZYL0JR+ZuA2N5lVo2DYi4PrqRyXb+EJoTiSWo5W14cIuXoP3TumLtk/GRAnmc/01cY7YJ8yfd4/9PQ+Tx2QLLQhVwN1+F6Q6qYravZ2YhEgpTX8AI+CGuNpnhNuutO0sg3tbX8WuyfTFTl/14qhLNqmn3VrYx/yw9L2+2JAu9nSvD6iZ3vtUcTg2SvjbAE0kmL1SpxReSMOZEkWxxJDohZjYXwS3be+b7166vjJIw1FHWR6o6Pq8k/F6bAyNYef8kT7SJoa7104geuDcYq1arZiXg==
Received: from PAZP264CA0197.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:237::18)
 by MR1PPFECD1EEFF4.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::6a1)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 13:26:10 +0000
Received: from PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:237:cafe::69) by PAZP264CA0197.outlook.office365.com
 (2603:10a6:102:237::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 13:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3F9.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 19 Feb 2026 13:26:09 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id B34482018F;
 Thu, 19 Feb 2026 14:26:09 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [RFC PATCH v2 2/9] ecdsa: initial support of ecdsa using mbedtls
Date: Thu, 19 Feb 2026 14:25:45 +0100
Message-ID: <20260219132552.1499698-3-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219132552.1499698-1-philippe.reynes@softathome.com>
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3F9:EE_|MR1PPFECD1EEFF4:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 66074266-3fc3-43c3-bef7-08de6fba71eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|7142099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VRrEDVeTkdK2CaGTwY+A1lTXTMiPUpE1t9/2mkSslXy8pniqxYPrDsCW/TyR?=
 =?us-ascii?Q?0Zl39yibCngI/NAv/C+dEVrSkLAq70t2ma9ATh9tuOknANfoQd28FgbrmDFs?=
 =?us-ascii?Q?eAq2wFCY5eBlx3XLBJU3yZ+oAeSiGAW1Ht7nyiAlDvBxrMWkxQ3glLYHwUXw?=
 =?us-ascii?Q?hLoXNf8G14Ls3nKDCfHM15NbXw+NA2XMlb2MUePHzE7Ah8OgzUUPxHKH/ayC?=
 =?us-ascii?Q?UwNrZrVNGXJ75lU8/RBK8+k+0vFpxcY1cjlkDjEXwE5R/q1UgRxybVAZXHGH?=
 =?us-ascii?Q?9ShQWJ92gkQjzEB7xFCOG2SEjN4QabT1Ot+iuimxtCCuMNO4JQpVd0WUBEQq?=
 =?us-ascii?Q?wTd0qFD0APOxPJfeMoakvoh3Ats2i/K3geiaY+gTlpKFb9Y3KnO4R7npfldW?=
 =?us-ascii?Q?c6u4if4/kYLgym8feR/253ETXAycGtYLtqSInDq6ecA+ulwtG/9yyAUBRQmB?=
 =?us-ascii?Q?ElPxPJh2U4+RVe3MJYbl5JuL5FGe3FqLC363hQqYoGv10W4qIMeIeEYAXzy+?=
 =?us-ascii?Q?nEcidH4j3DEIbTyj9/3AoPLB1shFqzYW3UFr1fGVQ7j0xvLdSk46BgEcKNSs?=
 =?us-ascii?Q?RKxoytXzeUnsPgwj9Iegt9juMy+G+s9VxoZ3eSLGRZCMWwGZgE4dsUs23oup?=
 =?us-ascii?Q?sy5b6MELLbeLtrS3jWRzpQ1JqRNTJ1Fl0hoA2ej5dj2HbqazIdyH4EsYwItG?=
 =?us-ascii?Q?ZAxD2X6K6DJ/6YGiBmV/yTDJ2St9tJGed7uMLisgq7Pd1F0mFXdgJ4HsaPyS?=
 =?us-ascii?Q?jqXSWGnl0u217+NSj/XIx71NTGLDv9OEdRuNqbSCKCD6z1kPdzPKHs7k40G8?=
 =?us-ascii?Q?cjQN8Ajd4zZlL8IhNRe5p8KL9N1gwZ0nycIYiPIPWz7JqQHVTvhffNS7dq5p?=
 =?us-ascii?Q?5VfLf9H3HgTpcd+R1djfPDnvKugrdPW3adQfR7q51whiDMs6VkhO9LFVRaUb?=
 =?us-ascii?Q?E5PUjP16yQkgEt63LYvYt9eyRIC7DR1blTA0GaiEvJJUyPNGpISH75+nxV8w?=
 =?us-ascii?Q?zsVOaxN1B3s8/zH806Af5MTDYz9xFw3p77feGOug+2C3qu6AFF/9OM82VlXA?=
 =?us-ascii?Q?CHN079xVFMUv05q/hW2QKAHphZE0O3kMfoXe46h508feXMBrO1bN3ypQePxT?=
 =?us-ascii?Q?xJoHFZf3W9tCzo4vPlOZFWKU3yOtzw6psT0UHCBOkE7s+rUFHdqQtBN8y/3x?=
 =?us-ascii?Q?q5okb6UMSatUmv74Qlj2CPXmMhiDsCEGdk9CpOlDVWm+rAipgLup+qXxhNxJ?=
 =?us-ascii?Q?4KG3p+XNRup1a9osVJn2ySd28yzYYyiDS6IvCXyPzY+x2FLm+UaDTX/4Rmu8?=
 =?us-ascii?Q?gemr0oQWE9v8Dc/2JSlVq/1DGIRZ+LN7eFMafpA6MhgLXdFMbxXAHjomBO83?=
 =?us-ascii?Q?U/heTfWqRxxVJVdpgYo2fNUxj20bh8FJaafKJz0uginLkvp8YfPIcUvZg9CK?=
 =?us-ascii?Q?D4IdGbBzwhd/5OWtPivTxAehv7JbEGjTkiYvDZ91wWlmjvKAH5S0KTa0ZBay?=
 =?us-ascii?Q?95XTse992SGxgsx+AKArpICkT5xxN/od+SB6ig89eXeK6f491zcaWYBkGs0Y?=
 =?us-ascii?Q?fCHQxlDTbEeAArr0noitRQsjt/efAr9V56YOcfjCrXn/55TZw1slmAR9n62C?=
 =?us-ascii?Q?VdUoWCtuHH4wDj3VYG2in+6Co7AKf/UvbG4afDzb2seT0oKNtALy+uP3IlCX?=
 =?us-ascii?Q?/3ZqSQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XPEeq99PdLbEuMQLtIqUshnP4rNjVnJAKzl+Qsfj707hVzxa5EyCTnWOlpUFLs8iureD4slnBh+pOzJoHVcJFcFOWdzejv5mM8YpYLPj69hAgvUgUwYJ+QbVtNhT9FMuQnHi/G1j46K5D4q5eNMFny8CL952oru3W2cBNqC1bNgpKo2dG49y9wUfNOvsnFXhqbOmvi8454T8nHZyDejZjdg5qGaizgYcKFlh+AqAXBquWBTJyDWHlHeDx81Ap/XMWezUsfuvrfNXvOHb8IBovDrrjEiuHZ3cS1J3sBDsnH3U9hq23IIHuKh4X/vXnf5ZuOsgrbBqcPDBP4552wYaMrm1bUX1j0gBfPsm0wO6B9fVrUio+WrVxo1bH8ll3PJZV7oBuM6f9obhUSoIBr9o7hv/xEoa2eDDCPrAHdkGM5KAGMtMegPHK1ousN6kpK1e
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 13:26:09.8593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66074266-3fc3-43c3-bef7-08de6fba71eb
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPFECD1EEFF4
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

 include/crypto/internal/sw_ecdsa.h | 14 +++++
 lib/mbedtls/Makefile               |  3 +
 lib/mbedtls/ecdsa.c                | 94 ++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)
 create mode 100644 include/crypto/internal/sw_ecdsa.h
 create mode 100644 lib/mbedtls/ecdsa.c

diff --git a/include/crypto/internal/sw_ecdsa.h b/include/crypto/internal/sw_ecdsa.h
new file mode 100644
index 00000000000..b1ca31da0f8
--- /dev/null
+++ b/include/crypto/internal/sw_ecdsa.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2026, Philippe Reynes <philippe.reynes@softathome.com>
+ */
+#ifndef _SW_ECDSA
+#define _SW_ECDSA
+
+struct ecdsa_public_key;
+
+int sw_ecdsa_verify(const struct ecdsa_public_key *pubkey,
+		    const void *hash, size_t hash_len,
+		    const void *signature, size_t sig_len);
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
index 00000000000..0ed95f4407f
--- /dev/null
+++ b/lib/mbedtls/ecdsa.c
@@ -0,0 +1,94 @@
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
+static mbedtls_ecp_group_id sw_ecdsa_search_group_id(const char *curve_name)
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
+		if (!strcmp(curve_name, info->name))
+			grp_id = info->grp_id;
+		info++;
+	}
+
+ out:
+	return grp_id;
+}
+
+int sw_ecdsa_verify(const struct ecdsa_public_key *pubkey,
+		    const void *hash, size_t hash_len,
+		    const void *signature, size_t sig_len)
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
+	/* search the group */
+	grp_id = sw_ecdsa_search_group_id(pubkey->curve_name);
+	if (grp_id == MBEDTLS_ECP_DP_NONE) {
+		printf("%s: curve name %s not found\n",
+		       __func__, pubkey->curve_name);
+		goto out;
+	}
+
+	/* init and load the group */
+	mbedtls_ecp_group_init(&grp);
+	err = mbedtls_ecp_group_load(&grp, grp_id);
+	if (err < 0)
+		goto out;
+
+	/* prepare the pubkey */
+	mbedtls_ecp_point_init(&Q);
+	mbedtls_mpi_init(&Q.X);
+	mbedtls_mpi_init(&Q.Y);
+	mbedtls_mpi_init(&Q.Z);
+	mbedtls_mpi_read_binary(&Q.X, pubkey->x, key_len);
+	mbedtls_mpi_read_binary(&Q.Y, pubkey->y, key_len);
+	mbedtls_mpi_lset(&Q.Z, 1);
+
+	/* check if the pubkey is valid */
+	err = mbedtls_ecp_check_pubkey(&grp, &Q);
+	if (err < 0) {
+		printf("%s: public key is invalid (err = %d)\n", __func__, err);
+		goto out;
+	}
+
+	/* compute r */
+	mbedtls_mpi_init(&r);
+	mbedtls_mpi_read_binary(&r, signature, key_len);
+
+	/* compute s */
+	mbedtls_mpi_init(&s);
+	mbedtls_mpi_read_binary(&s, signature + key_len, key_len);
+
+	/* check the signature */
+	err = mbedtls_ecdsa_verify(&grp, buf, blen, &Q, &r, &s);
+
+ out:
+	return err;
+}
-- 
2.43.0

