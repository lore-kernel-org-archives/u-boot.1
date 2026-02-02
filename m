Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7F5E7DF0A
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 17:05:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C186A83F2E;
	Mon,  2 Feb 2026 18:05:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="hUd8Q1lr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C223983F3F; Mon,  2 Feb 2026 18:05:38 +0100 (CET)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2C3E83F2D
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 18:05:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5hfEhABLTGS/fq/jVqSbaAQcyXcUyZ98hsa9xzPXvA40P0d5aeiLrV1W8rYmtWkAwIR96fJTW0JyK4g3iEanN0oU1gFYYMpIgHH5VkO3KNSWI9K5iRrrYBxRM8gxqw1pcGLmdf9vw77rBrB164dwPn1GN6a325YhW1Y39zZsgBFIVzpiuAqzWaI1kn8TPpOgS7tkmq6zyrb12hjEmy2M9b2+KERHJBPlei7WVTGRdK9HA5+AtgsvpFKlJfula7bs8aKf6Yb5ttQCSAftENQ7Nm4cwgNg+v3WhnlUDq0ZqNXk1Eh/C7ohbuay7Q5dcpzTJAFgZYKov10YAuXHyF+Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I932a/ZgK6VB3UWZU47ehQPvk/IUqowO3O+NgmIjfBc=;
 b=MYPLgMbAa52K6l80Qkb5NSLf2OmEpZ5WGdBrHXyZjQiS8zzZB+gMYx6IxQiWCM3rHX5XHtL4dRmL4arWjBTmx+DAUvf7N43d0NKrowsuqaJmufFbmEEm7IxJH/CH90FLlJm9ubTnbUeKEFJ7S0EH3qaursSpMr7KDyarOJJw03o/HC4xelcm7zQ6YfONGbCU1ifVBLonivP+xV0+Xgveg6tvSCQj5fS78brJWEkMmMyBV+eRZnUmV2e+DJFEM0hhTqFQwbhXoQdqlrJQqZgIYi8g86czvIMrA/zx8PBY7mM2JFwir5lcZj7LyOpl/LwTBmTbJfk5mwJNIBnVTJFHbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=gmail.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I932a/ZgK6VB3UWZU47ehQPvk/IUqowO3O+NgmIjfBc=;
 b=hUd8Q1lrTp/OAsrjQ97k36iHLtwrw7YkhCQlD68EP0FLwaIPETMxD3m8nHTC4Dj8MRFza306OOzuyeXDod9vraN65jgei4L6g3ImKAeeg1znQL8OA9uRhSOhGetZtMBsp6uGcBRODD65ZBXgSS0vkBht2Ilc3TkljSXeeQkff2J5BdAjncY8W6GktkofH4/TR2BVoNiPEOZ1zjMmx0ccVwkRZi7UwbijHVzUmRrZct2DrMgRVAO/EgiYK2j1NBct3ORM+fCIbK/nshpf7XKXLjrjHmm/Sa+ngg+KxpumfSBI/Q41ASIgtq6EzJwpSCyr+n03ua6aICbMpF2nHW8KmQ==
Received: from PAZP264CA0132.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f8::21)
 by PR0P264MB2886.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:05:30 +0000
Received: from PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f8:cafe::87) by PAZP264CA0132.outlook.office365.com
 (2603:10a6:102:1f8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 17:05:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BB.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Mon, 2 Feb 2026 17:05:30 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.66.192])
 by proxy.softathome.com (Postfix) with ESMTPSA id A484920933;
 Mon,  2 Feb 2026 18:05:30 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi,
	jonny.green@keytechinc.com,
	raymondmaoca@gmail.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [RFC PATCH 2/4] ecdsa: initial support of ecdsa using mbedtls
Date: Mon,  2 Feb 2026 18:03:05 +0100
Message-ID: <20260202170307.217200-3-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202170307.217200-1-philippe.reynes@softathome.com>
References: <20260202170307.217200-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BB:EE_|PR0P264MB2886:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8eef6e39-bb03-43e4-4564-08de627d4568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|7142099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sodOVGWR52QJRlWA4fEpiGm5P5Hv39WVDWIIJLzBKnI9ld3AgOfNpCWvj++C?=
 =?us-ascii?Q?OZ27UeHi4jHemRb2fADR95h0mGJMpxe21oRvVgD8KiZSht698EBjVuJLm0y1?=
 =?us-ascii?Q?dQcb9WUR1YlT5+UP5mn0gsYR8gX8IDl0mCiRwn6Dvkl2qBo8Aaq7Z1orQmwb?=
 =?us-ascii?Q?UAP7XeqM4VEk5mqY/PK+BJWExhkT0EF66gQvZ3JgwNHy6XqDbzvvlXKYAfGF?=
 =?us-ascii?Q?Mry5ft3afhGJ1xrKZc+SKoj4niQEGUhO8YtxDTKEvVAtPuu1gaRd4a2Zj6Il?=
 =?us-ascii?Q?Ksx0910UlYCgwWiyHbrA2cFYB0U8oXGG1rjMiRG1liLzRnVY+8H2O/3+WAfI?=
 =?us-ascii?Q?fs4IBAQDUnkYWqAWkZCyjiNL/h/a7aU1TUZtEPAcn9BYcL5IHUVQKrTOEUw5?=
 =?us-ascii?Q?TInn6HKO1KuA6XksXmsySz+yxnDX57ieGRAAuX80u2EYBXDuVnYOQI7cR8BV?=
 =?us-ascii?Q?A7pLaTjaZtwQ8200sHaoYxyxLpNOS8Zq5NhZHnadvQyFRkGiagofhSQwD80P?=
 =?us-ascii?Q?zynHsIDNrdv/A6OFydsNMN1uCrcIw8fdUnUD4cPcC9/f2ZY/5wAf58ZMTohy?=
 =?us-ascii?Q?P0KVIUeZJFcXLigGNJ8nTkghfOKbTmF4WpJa93D5N60Urd/55QK+5aKExwYR?=
 =?us-ascii?Q?0oLCMyVEvU5xyFzIhNTRRSsn6dbW0/QHkgKL0Tfo2tTaM8cugfTeMCGI02i9?=
 =?us-ascii?Q?54eUtu6pN/IMlrPLcuIktiSpgQEIOjxqdsKWAlISDyeu+W/Q1n3p51wVANAU?=
 =?us-ascii?Q?os/l/mNL8OAHu7Ft+/f+k8US+U8E6rIl7veNH9O1jsrO1VNdedsKlXwNZFZL?=
 =?us-ascii?Q?jWU0sBKfZGfOG15AOcL+77TLYhTP8zh1t0wMwTNz+ugZHfkHDE2M6LxZoZRO?=
 =?us-ascii?Q?npYfZ2DBcDTs7dHhvUI5RISMLU6I6iffr51t/NBp+rrA/hoo0ZKB1yHIZuUo?=
 =?us-ascii?Q?FL6WAJGBDJ7IQhk4AsPQlq23qxW74fhfXTKHU3ZCAXSG/b9fCSR8FRBqcKTa?=
 =?us-ascii?Q?On4jyS60az+WRJbJnHjyQTuP0OTy/GoQVvKv1Lf1IvzE/NKJEnS35hdV4K3M?=
 =?us-ascii?Q?FITF81A8a/T7t1zWkRTgucp+gYWN8AJ5MryvgtnUODPPUURtFLzFBEc72t5N?=
 =?us-ascii?Q?EHLeVHqL/i/nn/oRrzVKT0HMV/CNUVbr8Rg7wHQAU2lOqmFPWBZl7GR2kxvw?=
 =?us-ascii?Q?P+ud8la4atnfq87zHjqog8BnPqcdfuW1/qPGVoYm45UWZFC2tEC8gPJfPc/a?=
 =?us-ascii?Q?2593lX9cphBIMoo8QnBphjYexhOcYWJFpN2ZotIUQ1jEYMEycfYG5NK5+lni?=
 =?us-ascii?Q?3c5EsNLg9Zu81n4xDZelPSY0ShzJ9ng7R8i9Ds2W0taVGML+khot3XND2nBx?=
 =?us-ascii?Q?Z13djEAYZPTASa7sqt47QL6jbZHodT/ZxBpVRsaqynWnamCvAJqxpFK/cu8/?=
 =?us-ascii?Q?0/uV0y14L9YxA8zarOwcOZzZx4/R5pM2ar/iNiqTX9+V+YQvWwLdB4TZ5wr4?=
 =?us-ascii?Q?7pbAH6iPmtYODeWMTYdXa6s25TJ46kRXKXCv/fqkA1UL5kDjpZHSK9VaQcI/?=
 =?us-ascii?Q?UyNv56U3URK0hcFYWV6Uk9ViPhQK0/KLYNl7/6HFB9t6AxobzDVMxU+lJzDk?=
 =?us-ascii?Q?nuhUqe8FJ2H79X88/g5uuUlYVCy3raf1N9fKw2UuPYUMYVokxo9h0HH88Obu?=
 =?us-ascii?Q?b0WD+w=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LGEEzfFuvUEqJ7qnRoUWyANf9uV5+NFNG2u4D9EsnvkB8BcgAf1jvtSi2fqO8lhZLV1jwsA7rM2ilssRnfxAkTjkEPoqxY/OsuRpYHv3L1DpzzZexcHxZgVl3sxaOOe6d+9FTNw/FNx+FIz9QloJ2C5RBxVKC5Mbb5iKgqhwVopbQpmhfv03INgSi2Xj8khdxCmwzWJ4gDMzhTv0UFlGPIBZlxe1T8wcNFRYA8d0zdUIJTJgBY9I1MevFsPzNxvbbnuOoSZrk+oMrOqV06BtYp5zQo7kTImOo79UOipOJaTJLX4FCq9MPxUJGfRuAKhG6zhK9RFLvz9M3V1Jn4Hoxm/ohv5q1jfQeijddYROMjAQ+IdKQhS7yA5WNXPY0A9C+FYjwsOnWi2vj72JTTRMOGqBaJaIeV2z8ES6eT0s/I4dWRVhQE9EfbEUlCqnJ3mb
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:05:30.7629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eef6e39-bb03-43e4-4564-08de627d4568
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2886
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
 include/crypto/internal/sw_ecdsa.h | 14 +++++
 lib/mbedtls/Makefile               |  3 +
 lib/mbedtls/sw_ecdsa.c             | 94 ++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)
 create mode 100644 include/crypto/internal/sw_ecdsa.h
 create mode 100644 lib/mbedtls/sw_ecdsa.c

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
index 54a893609cf..a5331313a60 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -11,6 +11,9 @@ obj-$(CONFIG_$(PHASE_)SHA1_MBEDTLS) += sha1.o
 obj-$(CONFIG_$(PHASE_)SHA256_MBEDTLS) += sha256.o
 obj-$(CONFIG_$(PHASE_)SHA512_MBEDTLS) += sha512.o
 
+# shim layer for crypto
+obj-$(CONFIG_$(PHASE_)ECDSA_MBEDTLS) += sw_ecdsa.o
+
 # x509 libraries
 obj-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
 	public_key.o
diff --git a/lib/mbedtls/sw_ecdsa.c b/lib/mbedtls/sw_ecdsa.c
new file mode 100644
index 00000000000..0ed95f4407f
--- /dev/null
+++ b/lib/mbedtls/sw_ecdsa.c
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

