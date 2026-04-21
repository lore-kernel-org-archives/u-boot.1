Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26093F94CA7
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 21:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0291842E7;
	Tue, 21 Apr 2026 23:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="cr1sIjDm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDB8B84258; Tue, 21 Apr 2026 23:10:04 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EFC6839D5
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 23:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGcFjnzAu2GFGfxJi0WAyEvwkf8eRPqMfKDStMAkuv/yoj8fiLyjFx4fJ4O+2vpdi+HKPnExq19tFbWyTCXWR2+SUTZvsalDcDmxNzNwdIk74Lem5UixxwdSQ9IvK7HKkP79jevCn5aVV9Gl+XoZnEKCZeT4OxQ1EzO1M61jUNkYYqsiotAvYTvtmdBl3yX0Oj9ibizYPUahCZCGC6lktqhaskNv0OJb/XJ0cQYHj/8m9iesipXDrhAnIfDqWlb5cZSMGzs/Aik5ohnHy67ritqDN7GQoILDqiRyfoo3BUBvsGFOAeBox2t/Wc0Iq4T2Wm6LhcuUw2nxomrXU/aUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqRedFsExPMASo87YssmOhkYfTiC+JOWSCRi1s2/ug0=;
 b=fKSWXQvHI01hsXFgMW/l6XDm+cL3ZVF4dqzcDSsiO0Wp+PHkbqOPIJApY1hSBFpIMePrtvKzYaX8NUmI8K7R/TBjkq+XixzFFLmpzpGRSKREocpcudLSQQY/h/Hbck7igXPfNZTUX5xFOdnocDZvhi7YaS9tPOTHYrg+QJB4d838hWypPIzBs81f6/abzKIfCQ4rwEa44z/v0SqChV4TdAvKiE58cw7k63peOsnGwSmpphcw2B4xXWw+2pgr5haxRv6s26MlNYr0TpdoguJkU4LaxtnJarydTeBS7YliuV4FRRJ60EAqvuZbfd11FdFec1ax9HbDPOH0mT4ijVAy9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqRedFsExPMASo87YssmOhkYfTiC+JOWSCRi1s2/ug0=;
 b=cr1sIjDmGmAs++sISHKIJUjuoFaqG0wS0rI649F5IZxWnRA89O1es9pTJsKdwrwVUdFdIazr6vZe14c1GfozVidbQd4oPWVytb4hPARJ6zaSmr4I0a0hszq6FDLuQ7EUo4djDvkSA/Unn6QP+49P/XQLZJR4kpIAo3OB8RcFDZRgCLzf3v9AiatedkFFu2KjEyIwX2qtosccmkx2sOlFFDXWaaA784xDx2epwnfxxOGgEb5I273yggP2SG/3vTYcy1eIIBWkj6uC+4jUMMr5T6GE8fY936ot780upCakJUVq02JjOUgGFU2gL6pmS7c1y7oZLdoUhMMmQxgfmmlqkg==
Received: from PAYP264CA0035.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::22)
 by PARP264MB5881.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:4bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 21:09:58 +0000
Received: from PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11f:cafe::30) by PAYP264CA0035.outlook.office365.com
 (2603:10a6:102:11f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 21:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B9.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Tue, 21 Apr 2026 21:09:58 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id F1CA720933;
 Tue, 21 Apr 2026 23:09:57 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 12/15] boot: pre-load: add support of ecdsa
Date: Tue, 21 Apr 2026 23:09:51 +0200
Message-ID: <20260421210954.1170437-13-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421210954.1170437-1-philippe.reynes@softathome.com>
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B9:EE_|PARP264MB5881:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: dfb80d6a-569d-4327-1c15-08de9fea580f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Xk/v2pPY0IlCoudRc8IQPNaQ/HuKC7IJ+P6cOfSLRCgFv3Z33AHPeN4JDocKbScZIxDTKIkLHZowYEEzv73hvPHkhUobBVg2fMZfVlMGWNKhMDXG2mg5jXeeUf6XeZxCIce9996i0y8vzzXwxLpPi9pzKI1kfHbfAsEc88pGTJzgEV9blLrc7u1gVZtrH0zN1WhgKUiU4WAU0Ewo2VwFSmE56P3GplG270MeOuLSX+f10Vuw/twu3eLaGGOOCfX9tGIoTJ/iLWFPAoaQTsrWRyyyF9fVCghUjMidzWyl9iPVLj3br3kaGsI+ddkjnIzLXSK3L5YHAPsyoS3Zm9+pxqDSe/VNPuLf1jAKf2L3JL04DMuPnxxf+Odqx9u93UuARFKt9JU+CvVNe5HlNiZdZzo62aB0g/10oGiJw8JV3bVgXkpXc0BvGPIe3P7LUb1qkyxZIlBdG0wDa+mQ4KfNR16vNXQgn3tSXDQRi1M3l0A8PfAO3Jr2v+q5l6TZ3+xZG6dhQvVuFxoB88XVYHFtDYGdbc9KSq7eRoLO9zixtk4pX7yTFLrHDF9ZOg+BV/EJbQFKQ7nWheeIKvuK9tKdgok7HnnIDdY5QD7wzxgI6TXqjdgAvGvxXgAFZzN54w3b47OKz6KNQKSZs+1D802sXs+uy5t70tDsQrrkyoC5OHHgMQNAaoJzs23cpcVfEa+qpDClWbHWhIH2I7dpynKMI1GydMQ1qAdCM5I/UYu2LAXHR2RzqyevZYdXICGgreDKdYrkQAH+iKR90b8m9LqKgA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aTtsFCAFSe2PQg2VGWx2mWTDs4q5UWSte3ZuuLq4TbQm+4P7yHe7GAe9ObfzeD8sA/eWW7jXuQe3Jj31CPHgjblCcilQ5NBrK/kDOK8BWW5pqPY8peHD196qCdDNwrstaqqzCZKb4YTs/w6XT0pbV9R85P/rHun2Q2B7a2brGcSMYQoScXqmSANyC2l43E1sI9V07MTaNwFYYHp+h/5uu4/LKhU7DdvrXsNZkyR3+8k+pn1iOTLTk6/HgExNl0MJVqgq0Egj/6cZ3DZpACzHjmd724HLxvFOoNG3L14m/jw5wMXfdvi/BG3iSBktvt7r1rYXeBNx6Mq3zMO65Sf8PeL/q4eZMbpqcxHhdRL/OvkQEi+2u1hYf5gO7GWkWUULEes76a4jFlYsxvOqVma02T3meYSaRyafyeT8AaImK+KJP9FEhIQ7sghUF3cLmvXQ
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 21:09:58.1262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb80d6a-569d-4327-1c15-08de9fea580f
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
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
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- avoid calling image_get_crypto_algo several times
v5:
- simplify the function is_ecdsa
- re-use already computed crypto in function image_pre_load_sig_setup

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

