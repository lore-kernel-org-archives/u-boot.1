Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A342606A33B
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZI0IWKSM;
	dkim=pass (2048-bit key, unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=fVFSn7wS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 347266072F;
	Mon, 23 Nov 2026 13:37:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iTAlAomkdXAl; Mon, 23 Nov 2026 13:37:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 13A5F6076C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795441041;
	b=Dd77yYTy/eE8PxP4Gqe81LnWweObU1b+NJ61Ez6Q9K9CxEgXyvsgK4JcEzDEhvfKxS7S
	 oTyf3YMUXTfMAqGF2o5FsfKl7k8WMmp3ZZ0JcNyuWOYJglCepZjpUf3sQPP5IlFPA5iJS
	 ZEvZFeG/OgAgMNP9GMwrB7tPDVfG/nE1lIX7mFZ+iovDBPIB0Av0ymwDQ16amyg+46Mq2
	 VE5S+sU6ysQUvXzcpLt2Hu4Dva4gxQR+mVuAg8PhjRcQ2Act178R+Qk2aybOpqzE7qhxF
	 sJXKdrH3F5bTLfeqZWQbrrX3SO7ncK8SNxgIzRAixg45MjiQMaIH2GknZ96B6W4fzHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795441041;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jVMYzVj0/Sz98UWpe6ajVQ+qBOxm8GXGJNo+y14DCaE=;
	b=k2z7yWlcnhLpdMDsidws4DOQ9Uw+nKpRURwN/3UoC0Er8HAdg1FLNF35vZrJJYvIfmos
	 k4vldJcnt4Zc8BPzzRA1cChwJcOzBwFFcCGIdvxAwP+/gwYX0zb7g88Hf8HQEwAakNjmK
	 PvY1XZe/pFQ+IGgEGOacvwOZqEPighgTuwZUlFlQmx5SzAqlV26nC3Z2y5RruwiI0l/Ar
	 TwI3RqgedbrXD92eb5/gDmJXlAohwBZbcIlVu93HPInTABqSOJWSjewXiCdIT8MUi/34K
	 Hq1pzRQmlcH0iz8i1eBgB3Cx9bYUZaLCs4WyNycHXceyPAVDJEMDGX3P6qHPkc2qMmg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=none header.from=softathome.com;
	dkim=pass header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=fVFSn7wS;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795441041;
	bh=jVMYzVj0/Sz98UWpe6ajVQ+qBOxm8GXGJNo+y14DCaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZI0IWKSMGae/ldTl1mFFuUeTew4oAjMDw64xKAGAY4iIvIZNL8MbXOKQsNzV8wOdW
	 sIA2+IaThAWdIU1i9byXnWd0k1+ExO8J/Q7U/9w0iRnQOnIVZHUsBC5bT+SXPHdHXj
	 GoglN9+AYsku93YE3GRrEs0WziAlONFwtBWr0EOCoHUbJjs8G7cSgoUCtjKA+kC3Qw
	 AhLoV8UbaANWzWG6Uhk87vyxd2ljhJSbNASVjsmknvc9IRIVO9RslN1fsr+do0hfSP
	 W++GNoVafzjk7l3VTIk79JfwLt/o+3SqOTZU2EHg6QtdhvqqF1bPactTLW2yk6BeJ2
	 Wi0Arad26lePA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13A5F6076C;
	Mon, 23 Nov 2026 13:37:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C8912371
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AF54E6073E
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:35:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uN428DkuCRTy for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 11:35:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5BDA56073D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::1;
 helo=mrzp264cu002.outbound.protection.outlook.com;
 envelope-from=paul.henrys_ext@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=fVFSn7wS
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5BDA56073D
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVMYzVj0/Sz98UWpe6ajVQ+qBOxm8GXGJNo+y14DCaE=;
 b=fVFSn7wSB551QPsp6DTdVmQn+wombOqZqqH57E0A38IfiaakdQq+QctKhTsqEN9KZK8gYBT+kHhDTkiHWjuKf9ePDQB9AIZS/4taWBN2vvpnLO6DdPZNgPv8aCQaOVjMoe/ksX+DZ8R9UZ5UvolZuvDbe3aFpsNTTiykfB112cXuuA+wrfxhT8cjNolO4sUqu4qy8AJa7kMPWGtWyfOQSAwQS0xa0DpDbLL2ToZ9HUlreqYq7SSKEz8NIyWvwjDb7O0b4aSAI+tPn33aFD2TgvTeq3Wg83FhV+EbYsJeuHb2Oa9va9XI1iHmlO6GzjbqdvAeX38CLZv4J1kQqR/3yg==
Received: from PA7P264CA0206.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36d::12)
 by PR0P264MB3095.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 11:35:12 +0000
Received: from PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d:cafe::27) by PA7P264CA0206.outlook.office365.com
 (2603:10a6:102:36d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 11:35:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not
 signed) header.d=none;dmarc=bestguesspass action=none
 header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019232.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Mon, 23 Nov 2026 11:35:12 +0000
Received: from sah2lpt245.softathome.com (unknown [192.168.72.240])
 by proxy.softathome.com (Postfix) with ESMTPSA id 90D18202A1;
 Mon, 23 Nov 2026 12:35:11 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.u-boot-project.org,
	trini@konsulko.com
Cc: alpernebiyasak@gmail.com, paul.henrys_ext@softathome.com,
 philippe.reynes@softathome.com
Subject: [PATCH v2 1/1] binman: pre_load: add sign-size parameter for partial
 image signing
Date: Mon, 23 Nov 2026 12:35:02 +0100
Message-ID: <20261123113502.1241900-1-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120162440.GF3176972@bill-the-cat>
References: <20261120162440.GF3176972@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019232:EE_|PR0P264MB3095:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5267c901-6aeb-4710-3adb-08df4955d5f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|261102123227099003|261028144727099003|261021123027099003|261021121427099003|261022115727099003|261022075727099003|261022105027099003|261026121527099003|261026140227099003|56012099006|10067099003|22082099003|18002099003|6133799003|261009223027099003|3023799007;
X-Microsoft-Antispam-Message-Info: Qqv43+OZ6I3xZaozfHMV90Za8+DwFT+k/VtmWTiTyzJfnFdxaqRAcTpN8DIszpnWfM4FISaNYNfX6L7rIBJ2xbDnujv1lbgwFzgqAJVZigCE+nMYe1td6UTWAQqfW5Lq6wsUbJtZ9LFm6hmTsVAozZ8ctuYLniWnHa3dEMg1EnSBckM0cnN7tuWpnchUncwbt28XuYCJDylZBuL/p48xCrZdVSCi3s4LmGe6AT/YFswrogqMPnhMdvG27y/ZohARKJQK6GUHAWB26tnTQqqfbl8ASyI7g44evt4jzdLwxI2jpj/wnOgvey5yLDr6/hu6wZ7rJpH4kYw/7fv06GSKWC45Xm0CwWMqlWJGYwm63unzzAFTTN3NYJEVriew4wpnMNmT/M8hSePAFIJL4CzpvSf6dlVcwKc/Is+uXaCAIjC7Z96FNnLlWaJBDZZNd6bcfZAE5OW3AfyEw9kru6MStyeR0B7GaVLZMbWmSDtEZsKOfAwOWtoTWO1tTAK7vh/NiR9Cfs60k+K+J4AND/8RUNQjndsdV12A0g52WIJCVLv0jC2ahICazgsm3UfV1laofALcA3lKV7an1HPHroePF06Fl8eq1UGbzTPWxO3/ZsUm+PzOvem/Nc2YN4DxHkwPAEyFjCt24YpZKj9Uf1x1+Gzpr28c8gQ5ALQRTa7o9CIDS2Evxog14bk7PZD6sGqNpu3q8+q3R8SvGyyHuob5eA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(261102123227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022115727099003)(261022075727099003)(261022105027099003)(261026121527099003)(261026140227099003)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gMOw1+bVlkR4Vc1axDEiWV1x1AegPXi2ekVEzQvvBeyCovOWRM4BakFRzV/6qh43dDYn1xXGwxBVsMkbABcsqBT1GOZrWlRuUkq74slAAkwR8iCAsssVBhYsDqoyWhUj0MiK8YOIJbMotblIdKkQ77mFd6ApWHWZV+GE/vpGrBLBV/PTUdoccuPIJrJbHGOMYzq3hhWTByMXQTVnk1yQzisTBKgNp8Bv7+X9Lxn4nFWR8UYDuncJVoNAf9y07z0P3Dz+a5o21OmKAKmS+zqxKLrBnFpTXq3f2g5q9Pm5W453820KxT9G9DO9zls1npTPzXo6rnsqcwkv4/IsjXJvSUDWWn2QlICdiWBAxrdHMW8HTEvIXPEuUBnwmKauRroviM0RvBhMrGuIALfy3rDCx+KyFwpeU5Ar+BQ3EE+kfuSerCi6/8PlCfsB8AZNVzXu
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 11:35:12.0087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5267c901-6aeb-4710-3adb-08df4955d5f5
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3095
X-Mailman-Approved-At: Mon, 23 Nov 2026 13:37:16 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an optional sign-size property to the pre-load entry type, allowing
users to sign only a leading portion of the image rather than the whole
thing. When set, only the first sign-size bytes are hashed and the
image_size field in the pre-load header is set accordingly.

This modification is particularly useful when signing FIT images whose
data are stored externally to the FIT and hashes are already
calculated and stored in the FIT header.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
Changes for v2:
- Refactore the code and only use self.sign_size
- Rewrite lengthy AI comments

 tools/binman/etype/pre_load.py                | 20 ++++++---
 tools/binman/ftest.py                         | 41 +++++++++++++++++++
 .../pre_load_ecdsa_sign_size_too_large.dts    | 23 +++++++++++
 .../pre_load_rsa_sign_size_too_large.dts      | 23 +++++++++++
 .../test/security/pre_load_sign_size.dts      | 23 +++++++++++
 5 files changed, 124 insertions(+), 6 deletions(-)
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_sign_size_too_large.dts
 create mode 100644 tools/binman/test/security/pre_load_rsa_sign_size_too_large.dts
 create mode 100644 tools/binman/test/security/pre_load_sign_size.dts

diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index 7890c1c62a8..8d4442a38f5 100644
--- a/tools/binman/etype/pre_load.py
+++ b/tools/binman/etype/pre_load.py
@@ -53,6 +53,7 @@ class Entry_pre_load(Entry_collection):
         - key-name: Filename of the private key to sign
         - header-size: Total size of the header
         - version: Version of the header
+        - sign-size: Number of bytes of the image to sign (optional).
 
     This entry creates a pre-load header that contains a global
     image signature.
@@ -86,6 +87,7 @@ class Entry_pre_load(Entry_collection):
         self.key_name = fdt_util.GetString(self._node, 'key-name')
         self.header_size = fdt_util.GetInt(self._node, 'header-size')
         self.version = fdt_util.GetInt(self._node, 'version')
+        self.sign_size = fdt_util.GetInt(self._node, 'sign-size', 0)
 
     def ReadNode(self):
         super().ReadNode()
@@ -106,9 +108,12 @@ class Entry_pre_load(Entry_collection):
         if key.size_in_bytes() != RSAS[sign_name]:
             self.Raise("The key " + self.key_name + " doesn't have the expected size")
 
-        # Compute the hash
+        # Compute the hash (over the full image or only the first sign_size bytes)
+        self.sign_size = self.sign_size if self.sign_size else len(self.image)
+        if self.sign_size < 0 or self.sign_size > len(self.image):
+            self.Raise(f"sign-size {self.sign_size} is invalid: must be between 0 and {len(self.image)}")
         hash_image = SHAS[hash_name].new()
-        hash_image.update(self.image)
+        hash_image.update(self.image[:self.sign_size])
 
         # Compute the signature
         if padding_name is None:
@@ -132,7 +137,7 @@ class Entry_pre_load(Entry_collection):
 
         version = self.version
         header_size = self.header_size
-        image_size = len(self.image)
+        image_size = self.sign_size
         ofs_img_sig = 64 + len(sig)
         flags = 0
         reserved0 = 0
@@ -164,9 +169,12 @@ class Entry_pre_load(Entry_collection):
         if key.pointQ.size_in_bytes() * 2 != ECDSAS[sign_name]:
             self.Raise("The key " + self.key_name + " doesn't have the expected size")
 
-        # Compute the hash
+        # Compute the hash (over the full image or only the first sign_size bytes)
+        self.sign_size = self.sign_size if self.sign_size else len(self.image)
+        if self.sign_size < 0 or self.sign_size > len(self.image):
+            self.Raise(f"sign-size {self.sign_size} is invalid: must be between 1 and {len(self.image)}")
         hash_image = SHAS[hash_name].new()
-        hash_image.update(self.image)
+        hash_image.update(self.image[:self.sign_size])
 
         # Compute the signature
         signer = DSS.new(key, 'fips-186-3')
@@ -177,7 +185,7 @@ class Entry_pre_load(Entry_collection):
 
         version = self.version
         header_size = self.header_size
-        image_size = len(self.image)
+        image_size = self.sign_size
         ofs_img_sig = 64 + len(sig)
         flags = 0
         reserved0 = 0
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 567ffa96b2b..90d0178ac9a 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5850,6 +5850,36 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_SIZE)])
         self.assertEqual(is_signed, True)
 
+    def testPreLoadSignSize(self):
+        """Test a pre-load header that signs only part of the image"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        data = self._DoReadFileDtb(
+            'security/pre_load_sign_size.dts', entry_args=entry_args,
+            extra_indirs=[os.path.join(self._binman_dir, 'test')])[0]
+
+        image_fname = tools.get_output_filename('image.bin')
+        is_signed = self._CheckPreload(image_fname, self.TestFile("dev.key"))
+
+        self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
+        self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSION)])
+        self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_SIZE)])
+        # image_size in the header must reflect sign-size=4, not full image size
+        self.assertEqual((4).to_bytes(4, 'big'), data[12:16])
+        self.assertEqual(is_signed, True)
+
+    def testPreLoadSignSizeTooLarge(self):
+        """Test a pre-load header with sign-size larger than the image"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFileDtb('security/pre_load_rsa_sign_size_too_large.dts',
+                                entry_args=entry_args)
+        self.assertIn('sign-size', str(exc.exception))
+        self.assertIn('invalid', str(exc.exception))
+
     def testPreLoadNoKey(self):
         """Test an image with a pre-load heade0r with missing key"""
         with self.assertRaises(FileNotFoundError) as exc:
@@ -5982,6 +6012,17 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertIn("Node '/binman/pre-load': The key ecdsa521.pem doesn't have the expected size",
                       str(exc.exception))
 
+    def testPreLoadEcdsaSignSizeTooLarge(self):
+        """Test a pre-load ecdsa header with sign-size larger than the image"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFileDtb('security/pre_load_ecdsa_sign_size_too_large.dts',
+                                entry_args=entry_args)
+        self.assertIn('sign-size', str(exc.exception))
+        self.assertIn('invalid', str(exc.exception))
+
     def _CheckSafeUniqueNames(self, *images):
         """Check all entries of given images for unsafe unique names"""
         for image in images:
diff --git a/tools/binman/test/security/pre_load_ecdsa_sign_size_too_large.dts b/tools/binman/test/security/pre_load_ecdsa_sign_size_too_large.dts
new file mode 100644
index 00000000000..aefcf287104
--- /dev/null
+++ b/tools/binman/test/security/pre_load_ecdsa_sign_size_too_large.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,ecdsa521";
+			key-name = "ecdsa521.pem";
+			header-size = <4096>;
+			version = <0x11223344>;
+			sign-size = <8>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_rsa_sign_size_too_large.dts b/tools/binman/test/security/pre_load_rsa_sign_size_too_large.dts
new file mode 100644
index 00000000000..5b547c09aa6
--- /dev/null
+++ b/tools/binman/test/security/pre_load_rsa_sign_size_too_large.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			 algo-name = "sha256,rsa2048";
+			 key-name = "dev.key";
+			 header-size = <4096>;
+			 version = <0x11223344>;
+			 sign-size = <8>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
diff --git a/tools/binman/test/security/pre_load_sign_size.dts b/tools/binman/test/security/pre_load_sign_size.dts
new file mode 100644
index 00000000000..fb99349323a
--- /dev/null
+++ b/tools/binman/test/security/pre_load_sign_size.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			 algo-name = "sha256,rsa2048";
+			 key-name = "dev.key";
+			 header-size = <4096>;
+			 version = <0x11223344>;
+			 sign-size = <4>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
-- 
2.43.0

