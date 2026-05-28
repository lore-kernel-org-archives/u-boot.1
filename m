Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5702CD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 08:20:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFCD184837;
	Thu, 28 May 2026 10:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="Oco4fO8s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A77A984862; Thu, 28 May 2026 10:19:28 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 973E4846B4
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+k3l3D4Vy74v38h2hCzDcA2PMIECGO9eXqOiFQ1V1/DDWIxVFo8k7iW5ZPNg0M2xDVcm0PL/HAWusdmwTWmwf5JrNRaVOIKAipczlGfk0zSjK9cQr+ZD6PV/6I95+Nza7BV6EYMs4YHT3gbcQutD68WGwq9VlnLfRk/pYnmw+Hrq9ELSH0IG0qmv/N5KcxCxIviMWy8fPvs4yj+ArsQpwCFM4tf7+DvH+XaPEf6QrpltQVTnenhoqCNlMp/AIfDxaT58wGZ+7xRJMPfi/GsQn7aB7IsXf+/syg70u/DK9nfnAhov7XJKcSn/OadNPd8T9jQqodLgqKEqQSrZzD5Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KL9RPOtcjglLuu/WlZ01AcfpmbX9yTjMLIwihfqSQKM=;
 b=SYswthY4jusyKgrUpPC3Zsr21Tz6l2uvrC/b9YSRwkM+wdUaXEM3+ubR1ZF+eeStB1HCXgfGflbCPPfZJGJn/Xl1AbIoXrOXZHtvoFjmD0L7uyS/Dxv9MdEJ/6uPy2gJO3VfbIdwyAr7xK3K9GCbXMS9+KmMKdWKJimWEK/5eUf76OOraamX8qY+VCkndGpD6JTgZCK/hSJvrXKnk2MalesULzlfwYV8amjdzTPdG0K2uZpRkwcKDgtwRP8QamaejBBi55VDQzZlODy7l3d4jyhkSC8Bo08fdA2tmjKiK1Uno+uk52ZLhtSicd5NhrIISbtQbPPqDcBW6+nj8a/6+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KL9RPOtcjglLuu/WlZ01AcfpmbX9yTjMLIwihfqSQKM=;
 b=Oco4fO8sZFdpKvhxxwJFkU5HQHXu9KO0PrL0GVz0GW4NG9mdhExU2vy/x7iVwMLwFjQKUzJW7OleUv+HgnP3gAeHztlgOnEk3dQ8MzYcOWCxP6WucC9s/CHadhMrxeNjXRNrk4RCjPVZAYlMIByeyzkj//SC0VsvmItXGPaJd2xj842Uexfc908F+rLN23xW5X0/y3SG+/0Tb3woyXN4YtZUapd/xb5Wrc2Bj4iCpgyhHpWcpXWchazw/3HSWEn/sMECMsmEB0sA7FTe+63PfurFSlSwbB6fHxYvzoA6wqKkOJx5zgO3OaI62SC1uTOK/b/CN6h8o1ICz1MiDg+fVA==
Received: from PA7P264CA0372.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:37c::29)
 by PARP264MB5881.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:4bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 08:19:20 +0000
Received: from PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37c:cafe::a6) by PA7P264CA0372.outlook.office365.com
 (2603:10a6:102:37c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Thu, 28
 May 2026 08:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BA.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 08:19:19 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 9D5C020933;
 Thu, 28 May 2026 10:19:19 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 12/15] boot: pre-load: add support of ecdsa
Date: Thu, 28 May 2026 10:19:13 +0200
Message-ID: <20260528081916.11355-13-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528081916.11355-1-philippe.reynes@softathome.com>
References: <20260528081916.11355-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BA:EE_|PARP264MB5881:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 60a9f444-0bb4-44c2-3bd6-08debc91d122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: b9kPXTPahZa4E6Jnzmu9fxK2x1ury9QE763ILv68OKzv06H7Ubct7M3hHmZvqRRtfMBVP76AuNlQ/QQwngzm6w5ugSKSwccDcoqwdiiFuKvWi+mc72LvhXjyV8K0wcy8rtj03JNGo+L1X3QZ9XvCIIVMjL1y92ozSux1N9qWLu2q0TtkliyADURrkRzYcVa+Dw8XKJaKK9ygBgjBXdXzDdQkyp4tCwvKTVu2DHJd8FKItSmZMc1Ug/JbNcdq8NFQ0FvAnJ82dffCwiO4ZNRmKxlRNxSWaBwQvWIwRbxwCm3hUJyyS9o5unq2D7AYm2/esx24kd2uYgV9as0uYvdOtPBMzSfxXy1Uqu6awsXgd46eUf6SF21W2rQQC2u8RML0RtP8qKShhj93x2vQnAZ5gzLB3GxoMmryc4HCJI2+tRATnZsuUTUKHVW6GG9Uf5Af2CDYQb52k0guc8nD3pG/VjXlRgYdFFwX1CGMXFvcYhkvypYXTxQf4A1N5Xo9rpJr6t+XVWuMofda7EhR4DCpm9IUz+DttvLB7Lsms8KZpafg3eWga79cg062p22eFRQ/v/POF1OGviPJkWvJDf8F8gqYjegcsCqSvzkqgjF6iSdrwfB1pP3oH9yxrI7XA31NgjOXO+b6yi7JAyHEcvLc5uLu9KA88sJqvkcaY0r9k/StwPUqk6bou3FFHrw+n4c+KEKWefpELXPcCwqHqUzFWSCwYZKz5ZFGqQNDXd0fwNY=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3Huc+WlT34zaH9CM4ut9QAzRCe0ToXXC5bYgZ7INkrHqhmykc9jhFHS15CAQ/PkQR6hogCfC5ftPv89oZY/KLt/A4YgjnnQeBfOe/OAW7gr8nfmVzcONgD6CA7iKcv/wjZgvsF3CuCOsNjXuFR4yht4wLjoHf0nLawcovHMQDxBtOHUKOVZWQxAcwgOXXHN2a3kyi6Dd9HUk3prDsBnEmW24ypLyTHdDD6e3tKuyNEgpMjoG0dmvMX1Vx6LAY64C7QyBUd7vVpPGjM/HsTQUVkVOjS4oWYu3GAsq1x7rJH3zf6HpViD2hci5shBcy711xeJIiLwYzh8kmLOnBkvrYXMDfI61qO1DEP818K384+lPMPBXZPafc4Q2g0j76DvjyrthEe73/UCLcp8rnqRsID9izdzq252KZhx6uGAElUG+rOKX8OWYpK5pMWENovey
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:19:19.7684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a9f444-0bb4-44c2-3bd6-08debc91d122
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB5881
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

