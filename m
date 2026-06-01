Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C98ECD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56096848F3;
	Mon,  1 Jun 2026 15:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="oVe9F6bn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B9B1848B4; Mon,  1 Jun 2026 15:43:22 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F5A18490A
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8JnK53UdMJvPyD76NPlI91EjEOD6z+fV4HbnqK8IJrOA3FCu/3Ig7seghEr9t8BXiPyT7z73jsAt6mieaWJjdLh19cJ7ZzMqmLEQXA/GHwW1XOF+IYMrzYDwU1Cb0GbtgZYd5Cl8iXTisBr3V5dC+ganbWCxBo+O6WppuTfr0pRmyhqq5vxIHzN3WfvFfzPRNmHH23xwam7aAf5ngq4kVU3Exw0oKVMTkeFT+ikDUAYr6YWRQnzbEkszomwyO6QIw0lByO4M/LOx2IaIoIdzV0gecFhq+7WrTYj52hvXRcPaTOV5k+ElzVlyanruZdZZsGbvvykm/AeuMP4U6G5BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7fwH7vagLsOAFvTxx9yIfh8x1BAO8mTc7FKX2wecgg=;
 b=Yr8Nnf7OQT41z+vPisViseXkI0ht4GTCxQGpEXvCNC5qBpA6Q3A9Ben+ENyYaEsS/lKNEab0QWvDOsztf9lRGwrcR4rBl0ijeWNHmGVPcTjztjuFekCZZn9tTBSEUEnDCQuu7GI3KYmzUaAGihKuep66HUH2uhWMA+l76guzEOC9pl+ltDb74AhXx2FY4uyQxXmruGVhHW5PnbDtV2205gOthbvkMssMm4yfXdXeenXdxcjEkdesXVNGjLPiXsq151fMaJHvp3RfaqaX+eGh0ZkPP8lQKbjrGsRwHVMHBnxZpiJG1VM4FaW66awEVRyEynNg3wmJKvADIMc/Xo4jRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7fwH7vagLsOAFvTxx9yIfh8x1BAO8mTc7FKX2wecgg=;
 b=oVe9F6bnDsCnBtyT9intYuJ/pxSTDoZGvDPtf+HMbUwVBMtpI/RdpDXNONMW/UCm8afKOBMyWrRwApXIidjZtEOxzGoYJfhfO3HAKBaNgKL7SXv43fgrJhF5bIhJwexzq+ZYg9Mp7GMFXYYQShyJSQAAcgp/b1PHr0IY94PlxHsG299gpjRmustri0odWs/OiB7YS4qeYDWHxjrokNudAtAAzgFLqufBwogVkhL2EzN+N/jtbkBcUOWZzVCVLomEhp1TR/dWCw66H0qz+o/p+49eRqQ69OzjS4DEM/p/n47cqZ8wG9NYISlVkLuvd5YcQ9g/lj3Rgq/6OcZuD7TYhQ==
Received: from PA7P264CA0073.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2de::10)
 by PR0P264MB2950.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 13:43:16 +0000
Received: from PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2de:cafe::76) by PA7P264CA0073.outlook.office365.com
 (2603:10a6:102:2de::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 13:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019233.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Mon, 1 Jun 2026 13:43:16 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.66.192])
 by proxy.softathome.com (Postfix) with ESMTPSA id 954B121462;
 Mon,  1 Jun 2026 15:43:15 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v8 12/15] boot: pre-load: add support of ecdsa
Date: Mon,  1 Jun 2026 15:43:07 +0200
Message-ID: <20260601134310.2452454-13-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601134310.2452454-1-philippe.reynes@softathome.com>
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019233:EE_|PR0P264MB2950:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3d53358c-7147-4402-64ab-08debfe3bbeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: TswlrlAPGnnY/90/Y7sKyQF8moVCjneuX/zg7s8APVBq9a9mG1bS92Ci4PdQPU2QdX5/FCAgUoDNy2CaMLfqjvScO8wgMntWYemLvpoMvmWM2oIrmVDnU0toNoWRQqs7gAyq11zJ0FpAh0Iml5oclvYknahXqMY3xbC3XYYBDq1h+jMhlpJcO2CbddAOnKU/Gknwxh+QQ9nZoZcwOXYwRznU5d5SAekNoFUjoLGT0doBJZoyf8FZ9ZqxEym1O5GGzBrJZFpBQR32nL4dZUIaAeNlGaTN9gZpAtaVUlqYt925KoWn5LzD/ChsQN0R2yM8X+n4zfWwAnlAH/KOwQ47VNjmGadE11hrGN2tj4y8M35NQAZ1oRGueGJI0itQs1FM224IUIJx62nyEOW7WtuMUsw0YSYE8ls6UbjGJii+/vejUFChHYwP7Fi0e6ULU/e7zQn0hL0qTTtS7V6eJ/ol6C3KttFNMivCgEmIAzPUmLLxLpucDptJarGNKBWnZODhINDgl+Dvroyw4FGEHkL6ENaFK5wYaAUngvYIgZkhRR7VJCO+RCRkU3cmLp1jeOcMCEQo1hp96deqKLaePEmpqZPAhl68XD+oSuniKOzBzKTcKNdLcyAWL1np2qzsuIKk3Hkn//l7uOz6pXx0s2YuxgPkdRmqn9L/vJ143xWhp7taF6kbUHnc3jdPCQX0S4pckbwuoUqhg1cn0R6wSregoXZQy8HRyipELHqrGZ9nUcs=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ul2DsOuMM50b+rroBdUj1xsPDmUKQYhfTLh5jLPj73aNrSXKq5NCoam9Afzr5r0HRlb4Xxz6oJ2BiL7pCktBck/4Vpo5MCNXVcnggJTOUGORxXVSfXuF0J8wKRz4MOHLH9oyw5y5JnX+X+t/Dp6j5i4Q3jMA63EZMNQdwDby9wyZFsIK+XYDBNV3bjjV7wChL+ngoancD9ynzZ8PxfmN1aK8qJFaFEHlN5gJ3/ANx8ZaiRc7CR9oxlmIrNES8P511p/4uEZBRe1d1geGtav9CJwR8wsGF0Wb7MRTXpKABpKtjFfjGU4K6NT0uASKuMuT0P6EmqHrYTxetiHLt2NJJcvoE/rKVusUDpUIwi4TU4w3tVpfdNLuYBKnAVOMp60BfWnYwZcesYodzqwHwjG9N4JOdeDM9yVxKl+TFqAZ6bifUKLYQL/iVMdf8zUKTT2Y
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:43:16.3961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d53358c-7147-4402-64ab-08debfe3bbeb
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2950
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

Right now, u-boot can only boot image with a
pre-load header with rsa. We add the support
of ecdsa.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- avoid calling image_get_crypto_algo several times
v5:
- simplify the function is_ecdsa
- re-use already computed crypto in function image_pre_load_sig_setup
v6:
- no change
v7:
- no change
v8:
- no change

 boot/image-pre-load.c | 53 +++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/boot/image-pre-load.c b/boot/image-pre-load.c
index 2f851ebb28c..af72ea6d547 100644
--- a/boot/image-pre-load.c
+++ b/boot/image-pre-load.c
@@ -70,6 +70,12 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 	return 0;
 }
 #else
+
+static int is_ecdsa(struct crypto_algo *crypto)
+{
+	return crypto && !strncmp(crypto->name, "ecdsa", 5);
+}
+
 /*
  * This function gathers information about the signature check
  * that could be done before launching the image.
@@ -86,6 +92,7 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 	int key_len;
 	int node, ret = 0;
 	char *sig_info_path = NULL;
+	struct crypto_algo *crypto;
 
 	if (!info) {
 		log_err("ERROR: info is NULL for image pre-load sig check\n");
@@ -114,11 +121,24 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 		goto out;
 	}
 
-	padding_name = fdt_getprop(gd_fdt_blob(), node,
-				   IMAGE_PRE_LOAD_PROP_PADDING_NAME, NULL);
-	if (!padding_name) {
-		log_info("INFO: no padding_name provided, so using pkcs-1.5\n");
-		padding_name = "pkcs-1.5";
+	crypto = image_get_crypto_algo(algo_name);
+	if (!crypto) {
+		printf("ERROR: can't find a valid crypto algo from %s\n",
+		       (char *)algo_name);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (is_ecdsa(crypto)) {
+		padding_name = NULL;
+	} else {
+		padding_name = fdt_getprop(gd_fdt_blob(), node,
+					   IMAGE_PRE_LOAD_PROP_PADDING_NAME,
+					   NULL);
+		if (!padding_name) {
+			log_info("INFO: no padding_name provided, so using pkcs-1.5\n");
+			padding_name = "pkcs-1.5";
+		}
 	}
 
 	sig_size = fdt_getprop(gd_fdt_blob(), node,
@@ -129,12 +149,17 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 		goto out;
 	}
 
-	key = fdt_getprop(gd_fdt_blob(), node,
-			  IMAGE_PRE_LOAD_PROP_PUBLIC_KEY, &key_len);
-	if (!key) {
-		log_err("ERROR: no key for image pre-load sig check\n");
-		ret = -EINVAL;
-		goto out;
+	if (is_ecdsa(crypto)) {
+		key = NULL;
+		key_len = 0;
+	} else {
+		key = fdt_getprop(gd_fdt_blob(), node,
+				  IMAGE_PRE_LOAD_PROP_PUBLIC_KEY, &key_len);
+		if (!key) {
+			log_err("ERROR: no key for image pre-load sig check\n");
+			ret = -EINVAL;
+			goto out;
+		}
 	}
 
 	info->algo_name		= (char *)algo_name;
@@ -152,9 +177,13 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 	info->sig_info.name     = info->algo_name;
 	info->sig_info.padding  = image_get_padding_algo(info->padding_name);
 	info->sig_info.checksum = image_get_checksum_algo(info->sig_info.name);
-	info->sig_info.crypto   = image_get_crypto_algo(info->sig_info.name);
+	info->sig_info.crypto   = crypto;
 	info->sig_info.key      = info->key;
 	info->sig_info.keylen   = info->key_len;
+	if (is_ecdsa(crypto)) {
+		info->sig_info.required_keynode = node;
+		info->sig_info.fdt_blob = gd_fdt_blob();
+	}
 
  out:
 	return ret;
-- 
2.43.0

