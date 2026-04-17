Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9D6F4369A
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 13:02:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EC9F8431C;
	Fri, 17 Apr 2026 15:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="Gb5VXrkq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18B3884297; Fri, 17 Apr 2026 15:02:17 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A434A8429E
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 15:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGG8g7SGtdxsd8F8ZN3OhRJVkrXvSrJW4qLIoYluOTZY6VhekSTCIN1TrZuwoTFaBk8L3iem5QhnWANsOOSMtREX8Pqvrvt5nkZzOQxvOjp0/V8IFDuQqP0tFyDuZfVbxG01f4sul6unMyUcCBK+LU4h7vP34fIAvkSw2wUS8LUsXIlpCouVqm3RuiT4w46S2fFrXzvF2ufToHiWZwKacTiHtME7a5pbi3CuE5iB+gbQ2RT9sfEU2THzsYwa+Ux9X8i34xNNYU+7JVfJY+bj0hZvONvZo8/nNc64gTIPpv65nA48SpT71pWpTjAZbwcQYZlI4CeiZ2vnOOBnbpI64Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1/7PlbnEMOaHCBUc5ixttVBigiZ7ptmOc0s2cexhJ4=;
 b=wORKL0Z/Io+TV/6pGOjUoHWYiBSlRDDxVRne8HalrWfmgduLrV4+L6xU5g/IdqqdP13jxqkfWGgZ08E0/CW509dRvDDqwNfBbTAILddFbRLEMTkVaIssSyAl7c9KBVUSVoywrqQn03639jZZn/15E72/oNniIep/aGqAKquTTF0EZPt+z29AQ0IRW+HvAgr5xb5xHdwYEiITB5+yENaUrfcm7r7FxHkwm2u/PgLb4EkMIVoRZixVOJJgGdVfH+8qAe5hymQe+mDQmDNV1TC0rRFnUkyux9e9QEnIDKRhZl1e+pW9KNIjKNguwPEvliNuypkP6s0RLk+PJKbPCMViSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1/7PlbnEMOaHCBUc5ixttVBigiZ7ptmOc0s2cexhJ4=;
 b=Gb5VXrkqovplFKpzHXzdzgREkJMywFReuX9efZ7LB8g4zbQG3yAS/qcF5Qyx8JhPUyZCHDC1jJt51GTKDuEgUX5cH10u35kVwsaIeZpPaTfVfE/xWSS1C3mk94eLEMLxuIGDCtU77HnnJwMuvOEaN6C8F6LbDrrBByYbF0z4JlxmFd19XcBXcOWs36iOyxJeWVy9pYSZnxibF43kLi8BX5gdYMdJI5JQrukwKm0LtGcnxgKPqqy/axmhnl5XzbR02wbRN+4ejYo/PvU0sQO+yP65x5RIoE6/zcq3M+p+0LbrXjaNcSiuKu9n+erclyqQ426BqZmXyBa1im/Ypfj+lQ==
Received: from PA7P264CA0087.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:349::12)
 by MRZP264MB2713.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 13:02:10 +0000
Received: from PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:349:cafe::ee) by PA7P264CA0087.outlook.office365.com
 (2603:10a6:102:349::12) with Microsoft SMTP Server (version=TLS1_3,
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
 PA3PEPF000089BB.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 17 Apr 2026 13:02:10 +0000
Received: from sah1lpt726.home (unknown [192.168.72.39])
 by proxy.softathome.com (Postfix) with ESMTPSA id 4DB6820E34;
 Fri, 17 Apr 2026 15:02:10 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v4 09/14] tools: mkimage: pre-load: add support of ecdsa
Date: Fri, 17 Apr 2026 15:01:59 +0200
Message-ID: <20260417130204.49896-10-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417130204.49896-1-philippe.reynes@softathome.com>
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BB:EE_|MRZP264MB2713:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f6783423-5842-427e-286f-08de9c81897f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: KFb7H6bbRlxpRn+kt1OG7AZarXH1xAeoks8v3QcUBV7xq3h2y7xNgx4B79ChpTnYF7rp2LGLqTMZdHFvn0+cqqDHex2xLSyI6MmqDjEi0qNB2Y6T2NenZuKZxl6SADjYyX3+8gnjcWF3oWOEVzV5bjqboFSg4CQxG1IklfDGjEpuBeks1v5TWYE3E6bBcHG28etlIyhzh7V0RFDx81g67xlvLU0T3mRNRr91502H07EHp7WPuTfznk9N/SlbO618kfLBI8DQ2lU1vXHHrcuJnYcSU8QjVAoWmXl6hfICGZgyc2v60RiMHprcvytrOwz50JccXClLD4dQuoMsqUNNtBljPe56gfTedm0T4MLiTf3opp5rCDy9vM1yAF9J5pBPv93NKj9j9iEHEmw/3z+4T9Yd/mZ3iQpsctS1hx9Ao/dUihweQ8OvCB2BWCyeFbTM8DMWX9SzSf7H/r5qpnMeAQfIUIk7c6NMrDKAEx2YC/tegKgXPKHRDoNjH+55RrWrVmQwI4qm0FPgDVvnzYzaeu9dgYqbdLx5vFB8+Ku3KRKNDICJVVwMSNBXbGDnP9NIeoUHWLTQa6Tj5xVxJ1+UtDUPVMJuxqPsfm8NDF3ZvurRaEAi7vEb4TK/EwKfZ3sT1gxm/NNnf0GsdSSMJC6EbqhV4xxyohIZbOCYgM2FX9n+aCmhNlVbnsWpKa5pGdHktiVnohJAPgZYWBIbRu57fGwt1EzfrJECTGrNtFrPfY6jkrguFNzVi34Lpwamrb4eEW8URPl9r1ryyqBPaxCKMw==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rM4Z9fRGDJZdTUk2qjrS9IMWZbUjDg9mLfnnLESo371GRZho+p25M66tYZ8vd1CdZveLL8hosgpESYgYTubkvLMlNZZktqzFb69Dh+vgLvBwaek9Yz+yA9MeADXRlgXY8et+wLNFMQD6F+X19Kjel98r0yRQ6U8C9f6yvmbfknaud78NBS/HA9Blmd/q8eEqWFHKQ+XtoISXjmfe1n0z7IGOfIY40dDziC1ObfSNT5mZkrYZ2k/o9/UMjJRHJ/wmb3UXnru8tusCDO8qWLu0KPx1Fv7WlEe/r0zTNRigaZ9NfWsKK4OfRwyhGuNd6atfJxTcWfFwEB0gM2AoUQGas18r8mqFRAX5h3AV5VaUuejyaIzMtxDK4rBzTIsjPlL3DLJrRPgdT8lRtJ+o7bOABDIa7zM7X1jkpmbLreq+TsIXBHCkalliLvf0rNiyyWT0
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 13:02:10.4250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6783423-5842-427e-286f-08de9c81897f
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2713
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

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- use pre_load_noffset (do not compute it again)
- release memory allocated with strdup
- clean code

 lib/ecdsa/ecdsa-libcrypto.c | 29 ++++++++++----
 tools/image-host.c          | 79 +++++++++++++++++++++++++++++++------
 2 files changed, 90 insertions(+), 18 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index 9218d06bda0..6f347e6751f 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -496,14 +496,9 @@ int ecdsa_verify(struct image_sign_info *info,
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
@@ -538,6 +533,26 @@ static int do_add(struct signer *ctx, void *fdt, const char *key_node_name,
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
+	if (info->required_keynode > 0) {
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
index 8b550af0dc1..5577d25a95e 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -13,6 +13,7 @@
 #include <fdt_region.h>
 #include <image.h>
 #include <version.h>
+#include <u-boot/ecdsa.h>
 
 #if CONFIG_IS_ENABLED(FIT_SIGNATURE)
 #include <openssl/pem.h>
@@ -1244,13 +1245,61 @@ err_cert:
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
+	info.crypto = image_get_crypto_algo(algo_name);
+	info.required_keynode = pre_load_noffset;
+
+	node = ecdsa_add_verify_data(&info, keydest);
+	if (node < 0) {
+		fprintf(stderr, "Can't add verify data: err = %d\n", node);
+		ret = -EIO;
+	}
+
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
@@ -1277,17 +1326,25 @@ int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
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

