Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22EC60A261E
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=w3JW6rHi;
	dkim=pass (2048-bit key, unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=wWAm1ukS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C39640ABB;
	Fri, 20 Nov 2026 18:44:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MzEyixXa8zQG; Fri, 20 Nov 2026 18:44:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 30C9340869
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795200289;
	b=PXdpA3GLI3b3Mrxp/r4alqxK6eM56o2PSFmjh4rIbn9y8dYj6Yv3dt/28/X7hHWnWLYG
	 kcprUewGEUlIcx3uz3u0e+NEDxWo6Fnk5H1Nlrj0qOoEG7T/mHnbfpHWgePOebLSioClS
	 sZe6p6GYDM0gs0b24rq9MLJMJ2KE8gv9gsFiag8yeP73EavGyP14V7hZusI6MdXB0R24i
	 2gogyXGo2HEv59VOs88miYsfUbRk9auCioRk5r2dy+X2F84sOsIk/IVcQI04luTnbBKR+
	 5Zzicq6+nLsp77SUXfBh+rauCJsZ+VJljtoajNu5on5e0Jn5lM6xgg1oUlU3IkUDb9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795200289;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:Content-Type:
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
	bh=YBSXrEluN8YrLD19cSVd6fX1llacu80hYieSJKbnlEE=;
	b=Kh9opv1MLiNJ6Hr2laptRZaGzK4kpcPcPwbsOwqmd4GTFUl7G00eVAeYNSNbLK3DAZ7A
	 /41WR9ZCqNe2BVQKhM2LeIM+IvG0p4b/Fze8tbh4SQNLd5+dsUPE0m2BOlFH0fhUENJ9b
	 NbBJVyVmKIxVJg/1+LyALK6qg6nK39X53rE7u4qaaFZOP6oUbVmR7xLXkFjIu4BheFUp/
	 O+Ewcu5DGbbeF8jTTBLUrE00p1N3axYdVIhhdde9i34NMXu+D3Gss+WbhSlN82zAy2EUl
	 kt1ejV0hGAAJoelFVryHjfnG7VNeNsHaC0lj5/6bXtBy4v1/NbcEN6eL2DCVeN1TVzg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795200289;
	bh=YBSXrEluN8YrLD19cSVd6fX1llacu80hYieSJKbnlEE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=w3JW6rHiK5aowpqKDQRfZNdaxhlSNqCVP/9nIkmwtRiAgOjiELF6o6YgVkv7OIQ42
	 sVejCelVyLM0+wgTkOVJPr3UPQHOdeq8cLNALHQBBbnEdpriwQflw8apYPPJ1KeY66
	 Y5RKaO8k/ek9uYpL3kt2OvVZXGoaN5nmeg9wZdHWOCOKdtyMvHYE3nDtejnTOo4p4X
	 gWxFY/n/3Z+NplSPygFZV40I8XCD9T3Ln2ClEQgxUJTRijjBGZqjHXhI5+Pu2RqSLp
	 lUzK1NiAack+35Zo8zmFEyba5eGOiyTe5yLdCA9prQY8WEybfxv5rL8WemB1oQGbhN
	 E0Udwu9Il0y3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30C9340869;
	Fri, 20 Nov 2026 18:44:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F3BCE22
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:36:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4141D40098
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:36:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4bp9wbXX3C6U for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 15:36:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C9E1240050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::1;
 helo=pa5p264cu001.outbound.protection.outlook.com;
 envelope-from=paul.henrys_ext@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=wWAm1ukS
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C9E1240050
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBSXrEluN8YrLD19cSVd6fX1llacu80hYieSJKbnlEE=;
 b=wWAm1ukSgoC08AaT7KD6zsdD/O+iHjjKnON0PM7dAsiha5/03jjifqtKnCkH584uWqCztcjPz6iKLvUvnVNUj8Ns09H+LZqc4cNJYf2Yy4GBGjvrl6Ixcfz1e+aRudeokOwRQG74kbFxbbSFTC2CK9NZ8XgLunCXNp9Zoj9e9O+n8Ipc4nShR+IBr6i5uGTjq3idPbTJevN9OEXrEZuUeVR0BmNDOIDmK1sXk1ZeuQ+3fdjRBsyWaudB2FwJbXbtDqI5g0b/eJ/WQ8aTKxmNxZzAN1aN3qJhktcFU5mrEDUqxUSlcAT9qBMy6vF7dAE4vnClNd6TL7PjPnF7IhWl8Q==
Received: from MR1P264CA0005.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2e::10)
 by PATP264MB4792.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:428::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 15:36:33 +0000
Received: from MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e:cafe::91) by MR1P264CA0005.outlook.office365.com
 (2603:10a6:501:2e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 15:36:32 +0000
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
 MR1PEPF00000D58.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Fri, 20 Nov 2026 15:36:32 +0000
Received: from sah2lpt245.softathome.com (unknown [192.168.72.196])
 by proxy.softathome.com (Postfix) with ESMTPSA id C3CE720004;
 Fri, 20 Nov 2026 16:36:31 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.u-boot-project.org
Cc: alpernebiyasak@gmail.com, trini@konsulko.com,
 philippe.reynes@softathome.com, paul.henrys_ext@softathome.com
Subject: [PATCH] binman: pre_load: add sign-size parameter for partial image
 signing
Date: Fri, 20 Nov 2026 16:36:26 +0100
Message-ID: <20261120153626.51467-1-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D58:EE_|PATP264MB4792:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e1235aac-0c22-4fcf-da89-08df471c0db4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|10067099003|56012099006|261022105027099003|261021121427099003|261022075727099003|261021123027099003|261009223027099003|261022115727099003|261026121527099003|261102123227099003|261028144727099003|261026140227099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: T+ZNWW1fIcZj0SLbcpy65NBkDbDN/SkWd6K0PTlM+4MSqvR1TbBqVqU1AdydPGlyqPFtP2mhCdYWWNDe3CHf8apaoYtTsi5j2LlSoYip4jp1BD+ex6d2UC8fU8EU/oYPMQmVYfCcclH41pfqcTEnTU5+RxMQqCq5XqV3ZBvQALrPqa6r/MWOOZ2LedwGcFh+RGhHJlwmvL61j5CSXsG52FdThk8Dgm5e8Pu9JPrFg7O5JUN/TEFudEvVogrcNRWvcqPnnKKHNBdMFLSmI9f9KcTLBjkXBZFio7l0JEUJqjcYbmaMo4O5wVltCAzF0exbRS9vPv8J2aMObr5zqZ+U6UBZ24lVbxVPwNXmFPlJW9xP6Tyti3CCKTxvFW3+f2om73DLZR37O4VeS1JXtQ6b5BZARhxqk9JXk5lTTP3Qwr35DlJEBCssNx7VDhXVFq6h2CEVMdIP5g6yHlBQx2lecT0hRj4ibma/g55zPFaZ2QD13isAAQcgl4xq+DAmoOMZsTArUDiPwLQAdR8x8E21kJSFJyzRvL9gfBjxrHm4f7rTfodunVIScNH+647Y3gA/excOR+hkvDlK5qS8HOd8sET9dI/G6RLsHCJCt+nnPJnDnNK2PmJKYsjK7y428ua9gOSSkSlgXH8ZhAoVXXviFKIKT3QiPm0MXXt6mTBeUsOVxNJ/8agxbK5DbEUtswDYXApVG9kFonHhVz6+pXRPPQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(10067099003)(56012099006)(261022105027099003)(261021121427099003)(261022075727099003)(261021123027099003)(261009223027099003)(261022115727099003)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: awQOxsTZj12enEVzgwQOVW36sI9kAy+lbSJ09SRocN9AdlhIn7jj9KUK2v/+0QrxBk3e4lD0iZG6vWLXkISrZOxjoXABA4iWQNfYY+veazJXJuOcAmMZ6z1f9cED4ZWI8UQw8acDNITc0YCdxs4yQMExOLF9vz+sQzRm2U7C2Z8WiYtT4U+kMFyF9QTtMxIPyss8JtfLrDIV9LvBVVuYEUqp4aYJ/VIMwT4idPAGmz5kegrLU7zO6sCWYl8ER6as35CxVxczN9I9xNh7RXMmm+JlWhPSYQwI55FDFS3B4f69sQtm1wYfpNnJSjGtsh4iDunInpkYLpqPCtiKU0uqLBZNXS8P/PMVizX9x1GmdMSDK9XzMyKLkQHZrJLN6m/sOzmWNHyBNvtV74xBzY+nKbyOVHSdLpbvI2TF4QCE5cjeDPeEirIEzr6mLpRWrs7C
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 15:36:32.3700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1235aac-0c22-4fcf-da89-08df471c0db4
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB4792
X-Mailman-Approved-At: Fri, 20 Nov 2026 18:44:47 +0000
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

Assisted-by: Claude Sonnet 4.6
Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 tools/binman/etype/pre_load.py                | 46 ++++++++++++++++---
 tools/binman/ftest.py                         | 41 +++++++++++++++++
 .../pre_load_ecdsa_sign_size_too_large.dts    | 23 ++++++++++
 .../pre_load_rsa_sign_size_too_large.dts      | 23 ++++++++++
 .../test/security/pre_load_sign_size.dts      | 23 ++++++++++
 5 files changed, 150 insertions(+), 6 deletions(-)
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_sign_size_too_large.dts
 create mode 100644 tools/binman/test/security/pre_load_rsa_sign_size_too_large.dts
 create mode 100644 tools/binman/test/security/pre_load_sign_size.dts

diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index 7890c1c62a8..3612307d4ab 100644
--- a/tools/binman/etype/pre_load.py
+++ b/tools/binman/etype/pre_load.py
@@ -53,6 +53,11 @@ class Entry_pre_load(Entry_collection):
         - key-name: Filename of the private key to sign
         - header-size: Total size of the header
         - version: Version of the header
+        - sign-size: Number of bytes of the image to sign (default: sign the
+          entire image). When set, only the first sign-size bytes are hashed
+          and the header image_size field is set to this value. This allows
+          the runtime verifier to authenticate a leading portion of the image
+          while ignoring any trailing data.
 
     This entry creates a pre-load header that contains a global
     image signature.
@@ -72,6 +77,28 @@ class Entry_pre_load(Entry_collection):
                     version = <1>;
                 };
 
+                image: blob-ext {
+                    filename = "sandbox.itb";
+                };
+            };
+        };
+
+    To sign only the first 65536 bytes of the image::
+
+        binman {
+            image2 {
+                filename = "sandbox.bin";
+
+                pre-load {
+                    content = <&image>;
+                    algo-name = "sha256,rsa2048";
+                    padding-name = "pss";
+                    key-name = "private.pem";
+                    header-size = <4096>;
+                    version = <1>;
+                    sign-size = <65536>;
+                };
+
                 image: blob-ext {
                     filename = "sandbox.itb";
                 };
@@ -86,6 +113,7 @@ class Entry_pre_load(Entry_collection):
         self.key_name = fdt_util.GetString(self._node, 'key-name')
         self.header_size = fdt_util.GetInt(self._node, 'header-size')
         self.version = fdt_util.GetInt(self._node, 'version')
+        self.sign_size = fdt_util.GetInt(self._node, 'sign-size', 0)
 
     def ReadNode(self):
         super().ReadNode()
@@ -106,9 +134,12 @@ class Entry_pre_load(Entry_collection):
         if key.size_in_bytes() != RSAS[sign_name]:
             self.Raise("The key " + self.key_name + " doesn't have the expected size")
 
-        # Compute the hash
+        # Compute the hash (over the full image or only the first sign_size bytes)
+        sign_size = self.sign_size if self.sign_size else len(self.image)
+        if sign_size <= 0 or sign_size > len(self.image):
+            self.Raise(f"sign-size {self.sign_size} is invalid: must be between 1 and {len(self.image)}")
         hash_image = SHAS[hash_name].new()
-        hash_image.update(self.image)
+        hash_image.update(self.image[:sign_size])
 
         # Compute the signature
         if padding_name is None:
@@ -132,7 +163,7 @@ class Entry_pre_load(Entry_collection):
 
         version = self.version
         header_size = self.header_size
-        image_size = len(self.image)
+        image_size = sign_size
         ofs_img_sig = 64 + len(sig)
         flags = 0
         reserved0 = 0
@@ -164,9 +195,12 @@ class Entry_pre_load(Entry_collection):
         if key.pointQ.size_in_bytes() * 2 != ECDSAS[sign_name]:
             self.Raise("The key " + self.key_name + " doesn't have the expected size")
 
-        # Compute the hash
+        # Compute the hash (over the full image or only the first sign_size bytes)
+        sign_size = self.sign_size if self.sign_size else len(self.image)
+        if sign_size <= 0 or sign_size > len(self.image):
+            self.Raise(f"sign-size {self.sign_size} is invalid: must be between 1 and {len(self.image)}")
         hash_image = SHAS[hash_name].new()
-        hash_image.update(self.image)
+        hash_image.update(self.image[:sign_size])
 
         # Compute the signature
         signer = DSS.new(key, 'fips-186-3')
@@ -177,7 +211,7 @@ class Entry_pre_load(Entry_collection):
 
         version = self.version
         header_size = self.header_size
-        image_size = len(self.image)
+        image_size = sign_size
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

