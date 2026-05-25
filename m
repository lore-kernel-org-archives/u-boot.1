Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF35ACD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 13:54:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66C388482E;
	Mon, 25 May 2026 15:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="BfjC5cYN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90E2E84851; Mon, 25 May 2026 15:52:55 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36F07847EF
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmOCNwPDwjNd7Rp1vebrvIj/dwkc0Ce/vZf1GgCJCAQGZEeFIPzqMHigL80PxusuWOeC9HujSovV79tlYxmnlsdmJYVUf/s3zwsxs0THHIgFZHZJEH1CSxBFrbMGkiO2KKXrKTNXR2/ic/Xi8eoOuRimQ5VtoVXZg5StBRcEmWPWUapcjctcKcGrbsv8EgmQBjRYxlcyF7qpUx+VgbKA9JFTXbE+lI0iZC/jzFbz95iT6L9b7VUoZe/OokTopeNpGQgJxwaSbuH3wrU6/kP3PHpkwJIzyTCpfSboPAKsMZ3jh7llEo9n2aDt20XM7EP0xFkzwX0BSAtXXPCE9SXZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQd4qUb+EACzdysJ56p1C6xpr/LXz2QSWlfwPx72h24=;
 b=PlhkN2ldPhhRZm7Aha1x+CWObchsMD3WZYNTHFY97MiGOgY8F9drGqiFuJzrb157s4t3vapNerYW+hm1FCCmP0ts2sJsLb6ikYChWSBYKdZ66O0VO4S9axwbECRsVVmglFGc3ZfYzqHvfx6TALuKvM9GThT3Ho4sgPOjWsPMnI9tJaHXV/NYO28zG2G4hrIELVE4y7yC/Pv885LwQEpM0twwgBsZOkL76q/hzfG+ZW9hIpFu3vQ5W3j5PL5kkiWsPtsgmAJuO4PFeI65NQXWbL5GrPdSVF5IMuSgKasNMbf/FpgO2c8UrKMet1WYJvS2Ig2vX2HWbGXEXRKL0inpqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQd4qUb+EACzdysJ56p1C6xpr/LXz2QSWlfwPx72h24=;
 b=BfjC5cYNORLE7HrkcFqXB7QbZJo8RLwV9m5Lw9vgB2xuqlLH0naLJaSpgf7Q1cCzPhKcvD+ZiWYrLGZP2SelZI2s5f/VuaSL2/UANh7SI9tqwQrLrPwXl54LPilL6JPfW45IUh3E76dT/wEBieZdqD0TuX036U5snmxTMvaCmN8jTAiesTnxW1nLxwiGfNE4xY7S1OLfAFgZ3lr59ZLOY7x+MeBv+82wweq5CXxn8+78mV7wVTHsJTTgkJMoZiiyuHghp/KVOuyuMCJolXQn03gHWJdgQ5DBz88n9323yScqA1HY8Il7VDCTjHcxWYULDEWF3oRztyCOAJNwmFfEqw==
Received: from PA7P264CA0011.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2d3::15)
 by PATP264MB4869.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3fd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 13:52:45 +0000
Received: from PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3:cafe::6e) by PA7P264CA0011.outlook.office365.com
 (2603:10a6:102:2d3::15) with Microsoft SMTP Server (version=TLS1_3,
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
 PA3PEPF000089B9.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Mon, 25 May 2026 13:52:45 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id B650120410;
 Mon, 25 May 2026 15:52:45 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 10/15] tools: mkimage: pre-load: add support of ecdsa
Date: Mon, 25 May 2026 15:52:36 +0200
Message-ID: <20260525135241.88348-11-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525135241.88348-1-philippe.reynes@softathome.com>
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B9:EE_|PATP264MB4869:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: db984214-9751-4da3-70ac-08deba64e66e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|6133799003|3023799007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /zE3nA+x7d75mfe7UHY917OOvSdZfb6EhV8yubZDIyM3Ik1/oejABwu3SOLdbcCA04UcRlh5cMayjPdraJ/4IWPDElCTBpa4ui3AYMpHfx85NnBu1C+59CD+rEAvQ36buRs4h8rhHwWMOgRY4mzTAZMj2KQOXCu+fZktQbtuhv6kly42LLUgUYsPAnlcYkNS8NWIPVWlBWBf8uqvgCYIArNAliHRnGWAZV+cUExkfT+4jJapZJir0BAxziDUHWl6ukzejJVAzp7zn7H/25dE+e2GdGfjQSxlpyTo7cX8OccVXWKSV+jXvwWvKtevUq2VPdZYu29qPQnVRDzrF0kQ8i1kF+YpjUh960nZjsxSnjYn+SEhuXRg+1gRADiZi13KBQj8gunE7oj9pVMBuYTip6Cp1/ZIBBpt3CGZfMWCSvfYhcss6SPLhk+zYwaW/DL0c6Kfyhv9uhvKoYb5ZgZ8WjHqEf9rkJMUJsaJMD5KF54drv/fMvcTspHILvhHkc0q+/UWmc5Ix989OiRMQ0+iIG7r89+OfFXrm8eg+DAjsmLeQ2RUxwGJ5KyXbyvqMMRwAVs2iZdZyid4v6X52nIIHkp48xUvsp3jxxWDPSV00V0YPYa6irNyAhgnCaxXPpudFDXZJaLWjT4FsvdnVAEMBMGyNEFnDjgcDXXk2+GKcc4nN6MNpx2hR2K9qspTijpH4GL5MqWQ+aEdsPENUAIdQ+nxcN6hX70Fu69hwgcgrWg=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(3023799007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K5QPsawr+emGs0twvofqDbVNKNv8UengjcZ9bEn2smZSOJJWgkrMHJ17Rh0jVIy3JLIRzQ/zWmZIVsbV5YcC/RTELSFVHPquooAl8hloGm+1vDoO7eC3cHgzRfpl8NbE8F/J5d6ceKm4Y57R38ScrIoQpTn1MQ/hZopMK6a9jRVuzaIb0U+RNc39h66wZjFT2fL+JORF7PmWGMyNhacfshgbtkWojqWZJzJ3RH0D5Ayd34ESS+vpAGHa96LzDhmehp/U6xTghDvL+j1RZugKOaOuesfM5x7dUAyPaW0TW1ALZbgfxVkMjP1Q/1moz+wS9zyxIkQSaa5xPOLBlGhPw1gFNzbEkFN/AUzNrE1bfFJqX4bNweYYV4QSqZg0dNuaF0X5f+f5d0tuM1AbfE3FLBJaQCvVpMtcl11/AHTIoHEX6tQ45Q8FgrfqBIwNMk3r
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:52:45.8609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db984214-9751-4da3-70ac-08deba64e66e
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB4869
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

