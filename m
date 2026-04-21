Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F857F94CA7
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 21:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8567784372;
	Tue, 21 Apr 2026 23:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="G4srwqH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C510842BF; Tue, 21 Apr 2026 23:10:21 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BB5F84312
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 23:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGHe3TNhf2WLbKervcEzkzhaVgQtNrdEr5AnX+XpnZ3TW1zDNdRH12Kd+3dqh4WBqUZHf4telI2s+2m+wdGfNWrS5R3Dgcg7LYlXfkujc8bDyX8oZEy9UX4lZAy6EQbSRrl0k8u55rYAtAG6gKcrc+IDZqBuwEzDn3IM4PXKUeCQVBC8aVOKLo1c+p97vvCNk8hlehKu3i1PV0algf7Tm81j4MzfQ8xRGjYAj+4ZlZVgucM3yYOPTYRJh+yzTPM/zvWAtCVg88vPBepiytRKLX/GjS1SjfHX8W42bSww5Xv9TveKOup4Uu6tyZfdxqqsKTbBFrmQ3YQH9cmEWFGkXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dr/RJDlIwOgbzo2FuG2y32m9/VNZMixg3oZwyteZxBI=;
 b=ntERADwf5OMUlFfP4J8VhxChdfcghPXuWouMBfNru+l9l14lU8Dnl6d6q6GRSfRNWy7soBtlj96NzY9GKFpOEnfkgsYwA3Gt9aCekD4Fxu4c6AuxNL6nAt+9y3ihZbz0wXvmKB6GFybIU3FCgdGsakbgzrZfWYdwcB8OS1OAWHsY7JLOeAtYNpim7EwKVtuFmbP/JRMauUaYNB6MzEdIcOcDUcEMEbJaNtpsk17O+WfY1IbDz2vjYj5T7+B+REz1Tpr1gQT3Nf8GYX5VPjFaho4DIGPt9kn5zeVKTIOwtY1ntCaVeMezVT73bgHQ1121WPpFzA06hF/dfU9L/AeQKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr/RJDlIwOgbzo2FuG2y32m9/VNZMixg3oZwyteZxBI=;
 b=G4srwqH2mwq/LMdfejGbAcQi+9adu9+bBZTunANg1fTsEYBDWQ/Ngpi7buYTpKyePgBrze6Y2KKGKrHFs3Oxt277hyKYR9LcEUkskIBNu3GZXII/Yhy9G0YE8nTqiVcY8lT28snEXiOvyVjoy9m8O700LY8LYibK4hqQTmfZu+01e0Sb3h8VWr4ffLuQfpH2ej9EvOmMeM8stu523rTuWEnOTStt8EtQBsC3KTSsRwuf4n96rY2RR6xBB8lrgHGJ31kMaK07fivsxwtIVu8I2cD3tYvdCnDEJctWnOh/1xqxw1CmPsGqHXVqLiXxNNMTyE7DAsNDMBv471Oez6AAHQ==
Received: from PA7P264CA0025.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2df::12)
 by PAZP264MB2880.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 21:09:58 +0000
Received: from PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df:cafe::2b) by PA7P264CA0025.outlook.office365.com
 (2603:10a6:102:2df::12) with Microsoft SMTP Server (version=TLS1_3,
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
 PA1PEPF000CC3F9.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Tue, 21 Apr 2026 21:09:58 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 17ABF20EC2;
 Tue, 21 Apr 2026 23:09:58 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 13/15] tools: preload_check_sign: add support of ecdsa
Date: Tue, 21 Apr 2026 23:09:52 +0200
Message-ID: <20260421210954.1170437-14-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421210954.1170437-1-philippe.reynes@softathome.com>
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3F9:EE_|PAZP264MB2880:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d0bb8d74-fea4-4c69-d665-08de9fea581f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: kCVGRW9l/bYpEqM+DCw1DaW2CHVmgaH9Ob9YnLbqGRhrAsdUcNhgiNfv+Q8YpBNY8Ok34C3pJjTbtrW643VrHkM9+ZGGKIqL+8wy7BOAJMgS9c2Fqlo+6zalopgvmvk8V6jlUloGYOIoprMVKnphJtowg7zj4/ncWBnX1ta3qN0XeX276lVBsIOIBjGHTSGsoYnQYVsc3IHQ7p4x0DLVwrr476XnrdwqARbshZ1y5CZlTHiMctPm+nSJhQ+aciOPu5hCP4sRg+ZbGWoMQmD/5dg9ZlpXwYLEshTZWIx4AJEtwobap32dbAI5rO+cKZLMuLtpzFGUetT3nEXfNLj8Abrlwww1EqJuxHX61JcWq5C0Uh7+39OGF23qWwF+ZnRrIV9S7/6fszLNbkm/QSjTOv6m0AfTPQv+5E1j8JQxG6s5t1MC96IXP7YsIk9cd+1lXWzxi5E0GtWpnAS6b7hDPvksYs41NZa4GxCBdkRcVCPD16nZooS/5dNrVFRsxFBWnssyLqPQnrjPAfrqyq6WvuqbaJndEXCKrQWDGHePfwWmCiIshm12m5ynDnyH9Iyvi2U8JIYNTAjRH6ofoVeBMitWuUkFs/bTrhKnWHaBay1RKf4bsSJEIS7i6Ibl9oXvnLie0h6c5lw78ym44MNDOw/U9ey/r5WoAtg1awXPHj7rChEEP2/RQGTJ4FVfH5/EmJNVDkJIrY1QHxV/3pmPJBkuXwQcR+gOExttbhoz+RzECvFKRUezHmQoxzTz2ug4dTUGhPHE+0/oOBX2FMEu6w==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 67keCjyUF4mL7zJk17zC5yh4qPISHwsAejtKCRsta83HJqiaRklkY6HpznHuWQSaY8GT9D5VdR9gcfDBcu67zu2wn+PGJgq9lfNtgEZedeH3brXAJEQYwGK9zf7d5DziO3maohkM1Ym6BmbMCYVV7BQUMPz9ps8Pk+Tig7NoFkBTjNOjZgAlftMHbtfYcPbCeDBfQmPLstC50TK2oPYtze9jntXnqB8qzDowzgfoKh+e4jFUHmtsOIh7Np/1Dc8cZLhsj2uYHJVeswqFDV+wJIl86eZ22i/bNkfm+uvyfA3NMbL2os71xgqELKbuKq5bXIWASS2Cg7DNjmVpd1lz/jXPWo6nyf8Yh0szD+vHzxsyF9yZICqEe6moIHFOXBMzczw3+jNSP+TVFfcJc+RkLykV6unRWhmCZr4d5NBTcTyKC3HcI8BZqUopGRyclIhN
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 21:09:58.2372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0bb8d74-fea4-4c69-d665-08de9fea581f
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2880
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

right now, the tool preload_check_sign may only
checks an image with a pre-load header with rsa.
We add the support of pre-load header with ecdsa.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- free key to avoid mem leak
- fix error management (set ret before goto out)
v5:
- add include ec.h, evp.h, err.h and image.h

 tools/preload_check_sign.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/preload_check_sign.c b/tools/preload_check_sign.c
index ebead459273..d94f0509e74 100644
--- a/tools/preload_check_sign.c
+++ b/tools/preload_check_sign.c
@@ -8,9 +8,13 @@
  * complete file. The tool preload_check_sign allows to verify and authenticate
  * a file starting with a preload header.
  */
+
+#define OPENSSL_API_COMPAT 0x10101000L
+
 #include <stdio.h>
 #include <unistd.h>
 #include <openssl/pem.h>
+#include <openssl/ec.h>
 #include <openssl/evp.h>
 #include <openssl/err.h>
 #include <image.h>
@@ -144,6 +148,32 @@ int main(int argc, char **argv)
 	info.sig_info.key      = info.key;
 	info.sig_info.keylen   = info.key_len;
 
+	/* For ecdsa key, we have to update some values */
+	if (EVP_PKEY_id(pkey) == EVP_PKEY_EC) {
+		EC_KEY *ecdsa_key;
+		const EC_GROUP *group;
+
+		ecdsa_key = EVP_PKEY_get1_EC_KEY(pkey);
+		if (!ecdsa_key) {
+			fprintf(stderr, "Can not extract ECDSA key\n");
+			ret = EXIT_FAILURE;
+			goto out;
+		}
+
+		group = EC_KEY_get0_group(ecdsa_key);
+		if (!group) {
+			fprintf(stderr, "Can not extract ECDSA group\n");
+			EC_KEY_free(ecdsa_key);
+			ret = EXIT_FAILURE;
+			goto out;
+		}
+
+		info.sig_info.keyfile  = keyfile;
+		info.sig_size          = (EC_GROUP_order_bits(group) + 7) / 8 * 2;
+
+		EC_KEY_free(ecdsa_key);
+	}
+
 	/* Check the signature */
 	image_pre_load_sig_set_info(&info);
 	ret = image_pre_load_sig((ulong)buffer);
-- 
2.43.0

