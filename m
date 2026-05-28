Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E224ACD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 08:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FE708487F;
	Thu, 28 May 2026 10:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="BmlNfYMZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA7EC84659; Thu, 28 May 2026 10:19:29 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B182846FA
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUBKumm19OVJfT5gVn6Ll+D/1Ti7dLdM1pfWV4u4XkLkfKvLIJaoMDOCa4u8zdckn30vAePdoar1SbWUF+wiZrZeeNjIdsevUwxc5Xdh8AXepu51G5QUGVsRFkr+g5wCv4rdjad1/kPRWYqAUzoWJcP8xyxdR+7XoUCaTUuGrRlfjtvaE/Z/d05JUE6faP2VQSsJOQfab8heRdtT8g1cM2BEoFiRBoXfn1yAmEtdX0GTpPbsHJ2uGTRLpIZsCXzczFqYEXGB8SRG+IcvL2RyDrgbBiA0GD2VjY4CW5uiARHhaVYErjOXmbNkDqrlfVQiFvzmW3s8OUpX0TJdS0Kekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Mw9fqXU4jYzPsMhDA/3iANEEIgLZIpdzEqdcB/xSzk=;
 b=MRlcYtKQzlnm4CmPxerLbMGP8DhYmxOKIHyhVxSGQNMIClAwlEsHHvEGp3Iy0hSj8LR/LgexkxkqMSo18tQvTkaWdwXjviK8fRldJFsjKO6CiB4ym/jg/sMepykbdOnAuJSTnCM6mvt3Hq5eDoGlGvRmEPK4V5bZjqa3zLxvH5tdiYVlOhUimYWC2h8GCSb9GkPOx0hbkfPvevz9i31N57f238R/ua8mvpZr9N/nqj8qDE6wfOpMgWoa9qUB7NJ4TmNr7d0FC8qWtVLBz4Zks+HIhRENDYHY2aAuI5zLts1lCdVyH+HlcBFjDpMF+ibPjZm5G2dqqRktxy/1dhR5hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Mw9fqXU4jYzPsMhDA/3iANEEIgLZIpdzEqdcB/xSzk=;
 b=BmlNfYMZejo22Ruu9vofYKM5hm3iMwf6QVWDIEpbB8DucvCcIsqdnPk7PIVdDVjtfYx32ZchjJWyM9sLVLc6K29e62aF0PufbcpEN/4mh/6z4RBkZ05IzW4WWKZ8KRwxY8wMJEmF0qt/XYvbL001jpGwzK72+u76v7uEfL1MQr15KXGQz+zHbnZrOsWi3oj81vdqG/30O3eusjUnzSo2GszI2khsuPIVMRhmtrkq+M/EXkH+Vm+CTKX+qS834JFnl2iPtdwGEEFIp31Qh6vQs67W01wcPUwBc0v5A1S4533Kqi+KPJ/2fP5CB333GgPRAjaZLC6KmjpTciwDJjI80A==
Received: from PA7P264CA0428.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:37d::28)
 by PR1P264MB1822.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 08:19:20 +0000
Received: from PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37d:cafe::ad) by PA7P264CA0428.outlook.office365.com
 (2603:10a6:102:37d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Thu, 28
 May 2026 08:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B8.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 08:19:19 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 6982520934;
 Thu, 28 May 2026 10:19:19 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 10/15] tools: mkimage: pre-load: add support of ecdsa
Date: Thu, 28 May 2026 10:19:11 +0200
Message-ID: <20260528081916.11355-11-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528081916.11355-1-philippe.reynes@softathome.com>
References: <20260528081916.11355-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B8:EE_|PR1P264MB1822:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 826c3315-b5db-4e35-c254-08debc91d104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|3023799007|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nG37ZXjds2F+AEFoun45SHP5CG46aX70xZUErFT2qg9u/sfSuq5QmaCmgKq5w1eSfuuum7xeY/ZITZ6RH4kqk22UdStDQoUDFBBi2UhQWQQoTp5m9fKSbMD64SDesJlzYeJ3/eQTwqEbl4AQDFaFucS69TvIRUnxVunSunePIR1zwmM0LQ/88+Y2/rj+L1ULt2Qc7eZTq2OBuVEdeGZs7mrP25cwFb9mbxU5bO25fIesIRKFET1BgeOV70avK5bT8q3PrqOGU6FLz4R+KLWXANqtjOo3bNKIjcPeRbcnhszcfk5l0XN/Vpx9ucbLVtDgD0iyipSIEcNA6e7K21l1CAOUwUlgoDG+asCsaCzep98tw3Zd8qUmQu9IFEL/ZSlHHWA5lx0AagX5WYvbeWxbPzphu21VHyl0x6JcS3QezF3jTBJl+nnL5RcCD/UZtwllB/scOyQk+zbSSFFG2Xv6mGiO2P3c7+flNKffSElenlvUJRM+BVjbrV0Vjs14mTEvZU4lBUqWoxmCk3ay1r6LXjAfzLO7VWe51x6PPo27gwUJGFjRuMBsoaC+chZOXXe9MQkSsVykdR2wVEuWMf/fASeiYPXOzh731qHfvb2HQKqeZIypcFUqJGOmf4H3WBRoIlBOLvabTQ25gEpwfqGWaiEaZ0eiaGx4LEnny//ARxPG535rrh/AsXXAZTuHL3H15AF8VTbdK9A9V8F8LbCbg+XvKUhUV61tFjGvu4Iow0E=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(3023799007)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Lg13gnaaUyoK4eAawFdZK+HIiv9XZLU27TM/XuxVAILhkdOzCsnP+EwSHsYSk0UMTCKednOTDmBV2wvLsSrkQ9H8lhkag/0+f31Sy0fVgAC2vU52S96awB5q7N9UbBJmsHKRcvgXd2uiaayEgP+Bbh9OQ5Ii5SCKzDDKS3rYJxb+WAeK9qnfOHKYzfBiaRuqFamJuPGrShhy6pAFk7EzQ12/O9v5RFlE06qQUP3S591pGXUUSMlRwfGw7kjuShm+WgrxZIOk9EjwmmQO1/nsD4NjoDQAkXT7IxiJa4tmGNRw/E30XqnqVeJCwyl+zhQg6wB9yZSwc6zcfybGUKh92BUdBSOVhbff+P0UAcsjZN0HKWCRSDipawwhJNNCbNIuOkR8LWrAwFSZeO1KIH4tc5ZSL0B9oHrqnrXA5EW8AOeedWvNVXMgN7S3aNpbsQBe
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:19:19.5729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 826c3315-b5db-4e35-c254-08debc91d104
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1822
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

Right now, mkimage can only create pre-load header
using rsa. We add the support of ecdsa.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- use pre_load_noffset (do not compute it again)
- release memory allocated with strdup
- clean code
v5:
- check checksum and algo before using them
v6:
- no change
v6:
- no change

 lib/ecdsa/ecdsa-libcrypto.c | 29 +++++++++---
 tools/image-host.c          | 92 ++++++++++++++++++++++++++++++++-----
 2 files changed, 103 insertions(+), 18 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index 89c1851b71d..4a1d0caf502 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -507,14 +507,9 @@ int ecdsa_verify(struct image_sign_info *info,
 	return ret;
 }
 
-static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
-		  struct image_sign_info *info)
+static int search_key_node(void *fdt, const char *key_node_name)
 {
-	int signature_node, key_node, ret, key_bits;
-	const char *curve_name;
-	const EC_GROUP *group;
-	const EC_POINT *point;
-	BIGNUM *x, *y;
+	int signature_node, key_node;
 
 	signature_node = fdt_subnode_offset(fdt, 0, FIT_SIG_NODENAME);
 	if (signature_node == -FDT_ERR_NOTFOUND) {
@@ -549,6 +544,26 @@ static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
 		return key_node;
 	}
 
+	return key_node;
+}
+
+static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
+		  struct image_sign_info *info)
+{
+	int key_node, ret, key_bits;
+	const char *curve_name;
+	const EC_GROUP *group;
+	const EC_POINT *point;
+	BIGNUM *x, *y;
+
+	if (info->required_keynode >= 0) {
+		key_node = info->required_keynode;
+	} else {
+		key_node = search_key_node(fdt, key_node_name);
+		if (key_node < 0)
+			return key_node;
+	}
+
 	group = EC_KEY_get0_group(ctx->ecdsa_key);
 	key_bits = EC_GROUP_order_bits(group);
 	curve_name = OBJ_nid2sn(EC_GROUP_get_curve_name(group));
diff --git a/tools/image-host.c b/tools/image-host.c
index f5681d6c1f9..ae35a75d5a6 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -13,6 +13,7 @@
 #include <fdt_region.h>
 #include <image.h>
 #include <version.h>
+#include <u-boot/ecdsa.h>
 
 #if CONFIG_IS_ENABLED(FIT_SIGNATURE)
 #include <openssl/pem.h>
@@ -1245,13 +1246,74 @@ err_cert:
 	return ret;
 }
 
+static int fit_pre_load_data_key_rsa(const char *keydir, void *keydest,
+				     int pre_load_noffset, const void *key_name)
+{
+	unsigned char *pubkey = NULL;
+	int ret, pubkey_len;
+
+	/* Read public key */
+	ret = read_pub_key(keydir, key_name, &pubkey, &pubkey_len);
+	if (ret < 0)
+		goto out;
+
+	/* Add the public key to the device tree */
+	ret = fdt_setprop(keydest, pre_load_noffset, "public-key",
+			  pubkey, pubkey_len);
+	if (ret)
+		fprintf(stderr, "Can't set public-key in node %s (ret = %d)\n",
+			IMAGE_PRE_LOAD_PATH, ret);
+ out:
+	return ret;
+}
+
+static int fit_pre_load_data_key_ecdsa(const char *keydir, void *keydest,
+				       int pre_load_noffset, const void *key_name,
+				       const void *algo_name)
+{
+	struct image_sign_info info;
+	int node, ret = 0;
+
+	memset(&info, 0, sizeof(info));
+	info.keydir = keydir;
+	info.keyname = strdup(key_name);
+	info.name = strdup(algo_name);
+	info.checksum = image_get_checksum_algo(algo_name);
+	if (!info.checksum) {
+		fprintf(stderr, "Can't find valid checksum from %s\n",
+			(char *)algo_name);
+		ret = -EINVAL;
+		goto out;
+	}
+	info.crypto = image_get_crypto_algo(algo_name);
+	if (!info.crypto) {
+		fprintf(stderr, "Can't find valid crypto from %s\n",
+			(char *)algo_name);
+		ret = -EINVAL;
+		goto out;
+	}
+	info.required_keynode = pre_load_noffset;
+
+	node = ecdsa_add_verify_data(&info, keydest);
+	if (node < 0) {
+		fprintf(stderr, "Can't add verify data: err = %d\n", node);
+		ret = -EIO;
+	}
+
+ out:
+	free((void *)info.keyname);
+	free((void *)info.name);
+
+	return ret;
+}
+
 int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
 {
 	int pre_load_noffset;
 	const void *algo_name;
 	const void *key_name;
-	unsigned char *pubkey = NULL;
-	int ret, pubkey_len;
+	char *name;
+	int ret;
 
 	if (!keydir || !keydest || !fit)
 		return 0;
@@ -1278,17 +1340,25 @@ int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
 		goto out;
 	}
 
-	/* Read public key */
-	ret = read_pub_key(keydir, key_name, &pubkey, &pubkey_len);
-	if (ret < 0)
+	/* Is it a RSA or an ECDSA key */
+	name = strchr((const char *)algo_name, ',');
+	if (!name) {
+		fprintf(stderr, "The name of the algo is invalid: %s\n",
+			(char *)algo_name);
+		ret = -EINVAL;
 		goto out;
+	}
+	name += 1;
 
-	/* Add the public key to the device tree */
-	ret = fdt_setprop(keydest, pre_load_noffset, "public-key",
-			  pubkey, pubkey_len);
-	if (ret)
-		fprintf(stderr, "Can't set public-key in node %s (ret = %d)\n",
-			IMAGE_PRE_LOAD_PATH, ret);
+	if (!strncmp(name, "rsa", 3)) {
+		ret = fit_pre_load_data_key_rsa(keydir, keydest, pre_load_noffset, key_name);
+	} else if (!strncmp(name, "ecdsa", 5)) {
+		ret = fit_pre_load_data_key_ecdsa(keydir, keydest, pre_load_noffset,
+						  key_name, algo_name);
+	} else {
+		fprintf(stderr, "The algo %s is not supported\n", (char *)algo_name);
+		ret = -EINVAL;
+	}
 
  out:
 	return ret;
-- 
2.43.0

