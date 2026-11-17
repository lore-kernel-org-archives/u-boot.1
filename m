Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38931606A323
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YKj0TLsY;
	dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=bNuvtz7C
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08C8E810D1;
	Tue, 17 Nov 2026 09:54:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7X-SDTIclXqV; Tue, 17 Nov 2026 09:54:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D677A80DAF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794909243;
	b=FipSf4FDXw8/SNVUFRv9t3Mj4uDwCYeDVUgEkOfoFJZSHzhrUefl5OKK0otCFQP+Q2u5
	 BkCxqHTAQNumYsjwKVBIICgk6VAJhMSfxOv4ygzlhu8DunCk/LKimXkupkuJEVbJNw6ZV
	 azLgWYD+tzPa/Rgf3vobJirKQ88objoWEH+8Cr7rp5e9XMsf+oFaht7P6IOepBPlM2MFR
	 SJG+cvjq+2pHWlpwKb9kYTs5E+Vg7AYHgnuGTepwsjZ6ZMIkn7p2Zl4fTfHpEJKxaqEB3
	 7HWhdpAu/dUI/HiJWbLcnKZyxkwTTmYslet+9zEAI2K4AGqw7cVJucHgEberejUE0ag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794909243;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ymlp3uL+6cTcIY8YSGiAggCpVRa2gW89+9+Mg7mvrds=;
	b=OjOwQMVDFl/ZqJUhFPTl3OC/Igeze+MqBybuKwstaf1at/L/HgZ+rz/+ElTpcqd691pw
	 Wqy/9fOV7AqG+FnBJNvKcJHZg+evzAAx31rXHBK3xmm/HQbRMcy9W4Gdd/TBGDU8gb5H/
	 eLOh5v610oHa4qSvOcQb8l2xWql5l+p76az432sdFzNx+amt8eEEBuhmLum6ipFbsXkeF
	 h6nfSkPEavvq7JfCeQIOolj2UIEnd2f/0fMo/jcr2/bNnfz2tMnNk1hsw51a8NWXj2zGw
	 APEU2wuJd3kc5f99KAVtdpsCinicwW7vLMCs42cB1152arDY8lVe1v5bwkRXeYiA9DQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794909243;
	bh=Ymlp3uL+6cTcIY8YSGiAggCpVRa2gW89+9+Mg7mvrds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YKj0TLsYElwH+RsgDWX8wLAPD3q4WSJU1vtDmEnWuYddY4/qQUpjIcNocQbascHpq
	 i6xyxc2G7VRDtVCLqScBRfmXO/ce0owgymQn1zEPJI0fJWYxq1ea6D8fPn4/+EVght
	 ZYVt4LQYRozeTlPWgKNfxu5DVhoS5TKW7xwtO0KvAJ1LIEfR/a1GY9/dwnKVP1qBSP
	 b37KCAF2Og/vAdjDuHpEaW7LsrVlETw3e42xvOz6AeExrIMWODvETCnYcFS178m5tg
	 mL1RWVxwr/BqI1DmEwWm37G6ULiidObcOtmWcuHYlDO1247QGu5SFvHGpsmYBExgjy
	 G738UXuPWPZOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D677A80DAF;
	Tue, 17 Nov 2026 09:54:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 380051E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E878406B9
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:53:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0q6phoz1uZ3T for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 09:53:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 02FAF406AE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::2;
 helo=paup264cu001.outbound.protection.outlook.com;
 envelope-from=yan.wang@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=bNuvtz7C
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 02FAF406AE
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ymlp3uL+6cTcIY8YSGiAggCpVRa2gW89+9+Mg7mvrds=;
 b=bNuvtz7Cd6aLXV5ROlp9nRWoUOwjfTd2Gu2msFw5nGq311yJjLi2izAtiwU8taxKfivwS7puy+wPmxrStEmGhX5bbZooyawlH7F8VrLhRdyK3FiXXiaMPYxuUj0dE5Tse9qEa7SFD5M9rHwpCiZVkAxBNaZ23Iv+WFbSSjFpFReU7E1C89RbVEF6rx7iWmQ9+cN8uDG06GKwDMCE1uvp7WH04PKgPTVVBiYl6yhV6XsikmLHmDp1TQ3O78jIuLxRQ7qxehtGtVZhrGclrHVJ5qZOKqlC4kw02IdtemdEDXCA3NgC8VhW9A6cyZI5cOPAPWNfAEYGQrgIaAjWYK5u6A==
Received: from PAZP264CA0095.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fb::19)
 by PARP264MB4733.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:42e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 09:53:50 +0000
Received: from PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fb:cafe::55) by PAZP264CA0095.outlook.office365.com
 (2603:10a6:102:1fb::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 09:53:50 +0000
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
 PA1PEPF000CC3F9.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Tue, 17 Nov 2026 09:53:50 +0000
Received: from localhost.localdomain (unknown [192.168.72.185])
 by proxy.softathome.com (Postfix) with ESMTPSA id 4DA6B20079;
 Tue, 17 Nov 2026 10:53:50 +0100 (CET)
From: yan wang <yan.wang@softathome.com>
To: sjg@chromium.org, alpernebiyasak@gmail.com, trini@konsulko.com,
 alchark@flipper.net, paul.henrys_ext@softathome.com,
 philippe.reynes@softathome.com, marex@nabladev.com, raymondmaoca@gmail.com
Cc: u-boot@lists.u-boot-project.org,
	yan wang <yan.wang@softathome.com>
Subject: [PATCH v3 3/4 RESEND] binman: pre_load: Require key-name for
 file-based signing and fix integer division
Date: Tue, 17 Nov 2026 10:53:20 +0100
Message-ID: <20261117095322.16813-4-yan.wang@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117095322.16813-1-yan.wang@softathome.com>
References: <20261117095322.16813-1-yan.wang@softathome.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3F9:EE_|PARP264MB4733:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4ad57c05-e1d3-42bf-8a28-08df4490ae98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|261022105027099003|261021121427099003|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261022115727099003|261102123227099003|261021123027099003|261009223027099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: wa83IqvtfF6WFgdRSRmGIlvt63ZPulkCCAy9gpP+YILF4p0kRYvlO2se+srq5gjpNI5z9lOyUJH2uD7qNRJBrDjwY87BRM+uwZX2bW8yaRjzrIc45LXMbtYyq2KZ2l8PrWQFk1WKhhvaWOPkaMuVIdE8O4kEljKeB6955dryVw4m/nJkV8rO180pkZEHU2yTF3Ns5Ks9IgqvEHBxpNd9QMkOUMV4gzCzJYgcX3HUxyeIb/XzVUCLtfHMZQWC/RpsqnxnM4Di4QM5EwhSbTzy7ksiS60TXppUNL8lOy3PR6+UgjzTiU9I5bRjlENIIAIQBFL9TZ3eLDFAUFjDy5ERPP++ekU+Ha0aOyUz2gXfyPAOf5TPLEBeh6HFXF5fr7rsmoft93Q5HnzI/8pfxreJBvuDD2OIYsWbkNGACJq8IQwmr3b61Kwi44iRWV3PnJrRbaRPUZl1PbAVrBkgvXUG55nBnXVhYrMUrhjFQ6x3S9rW8y3tBEB6U1UoGlLND0GbfJ+IyjaVyHU5vFnQSaet5LGRutvyKJERowj9VI+HW8kybdnTyAkcAAx2goUs8sd6zMM6jq1F/9e+vigCGDscZwOVlY5kMb2LiPOj8pLgE26FIaGvtcgwuz3yLYzzzhZKdi8gbETmec9hHSoJkOlqNvFVlyETaMiN2NOIM5kDcvl2Ko7Nptf7EDv99MSxxSxTVkCIXeX/HACpvI4Vnkp/bw==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261022115727099003)(261102123227099003)(261021123027099003)(261009223027099003)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1VKAqid5X7EZmAVMUOFQfg5Yk/IZG5vWEz8pSoDLNUC4wN6OLGC3CMwE/vK3xwxZcShsC6UtgjRhT4AhCygMrqn+Ixy+nDrVUU9UL+Fb6js8kCMOyWB//IGTCEheiFWbnR7ufkTygHGiUjfJnWLUH3GVnyrcmt5L62vL1Ux65TJGClJlyR93LyVc57nWM6eeXtNtpbM1CYL0/JGe/0IzTH5sJOK+3uMELf2qpbwToltFVRBZpJm2uuI/vK/djyPrnAanx5Fa6Rlbmfz3YLcsNmAAIK7WZAxV3CNlXNq7QwbjVPisaX7UudmovdEkpY8uWofKKbAyJMkjBk7rrScEpb43RVBUwIw7L41a1ApKMQstnhHUfymH2U0r557Mr2SEKmuviO5xVyu3c0l9lBa3Dmc/QnIDEBRGwRYgrmc4iAoata4QBde3XlUvtof17kKf
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 09:53:50.4583 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad57c05-e1d3-42bf-8a28-08df4490ae98
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB4733
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Without a key-name property, os.path.join() is called with None and
binman fails with a TypeError traceback rather than a useful message.
Report a clear error instead when file-based signing is used without
key-name.

Use integer division for the RSA and ECDSA signature sizes. Using //
gives an int result as semantically expected for byte-count tables.

Signed-off-by: yan wang <yan.wang@softathome.com>
---
Changes in v3:
- Move to position 3/4 (was 2/4 in v2), after the HSM signing patch
- Place the key-name check in the else branch of 'if self.hsm_key_uri:'
  in ReadNode() instead of at the top of _CreateHeader(). This is both
  earlier (validation happens at node-read time, before any signing) and
  clearer: the else branch makes explicit that the check only applies to
  the file-based path

 tools/binman/etype/pre_load.py                | 15 ++++++++------
 tools/binman/ftest.py                         | 11 ++++++++++
 .../security/pre_load_missing_key_name.dts    | 20 +++++++++++++++++++
 3 files changed, 40 insertions(+), 6 deletions(-)
 create mode 100644 tools/binman/test/security/pre_load_missing_key_name.dts

diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index f264146d62f..32aa10bc057 100644
--- a/tools/binman/etype/pre_load.py
+++ b/tools/binman/etype/pre_load.py
@@ -54,15 +54,15 @@ def _parse_pkcs11_uri(uri):
 PRE_LOAD_MAGIC = b'UBSH'
 
 RSAS = {
-    'rsa1024': 1024 / 8,
-    'rsa2048': 2048 / 8,
-    'rsa4096': 4096 / 8
+    'rsa1024': 1024 // 8,
+    'rsa2048': 2048 // 8,
+    'rsa4096': 4096 // 8
 }
 
 ECDSAS = {
-    'ecdsa256': 256 / 8 * 2,
-    'ecdsa384': 384 / 8 * 2,
-    'ecdsa521': (521 + 7) / 8 * 2
+    'ecdsa256': 256 // 8 * 2,
+    'ecdsa384': 384 // 8 * 2,
+    'ecdsa521': (521 + 7) // 8 * 2
 }
 
 SHAS = {
@@ -239,6 +239,9 @@ class Entry_pre_load(Entry_collection):
             self.hsm_hash_name = hash_name
             self.hsm_sign_name = sign_name
             self.hsm_padding = padding
+        else:
+            if not self.key_name:
+                self.Raise('key-name is required for file-based signing')
 
     def AddBintools(self, btools):
         """Register pkcs11-tool if HSM signing is requested"""
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 8caf275d466..d4522e905e0 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5981,6 +5981,17 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertIn("Node '/binman/pre-load': The key ecdsa521.pem doesn't have the expected size",
                       str(exc.exception))
 
+    def testPreLoadMissingKeyName(self):
+        """Test file-based signing with missing key-name property"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        with self.assertRaises(ValueError) as exc:
+            self._DoReadFileDtb('security/pre_load_missing_key_name.dts',
+                                entry_args=entry_args)
+        self.assertIn('key-name is required for file-based signing',
+                      str(exc.exception))
+
     def _CheckSafeUniqueNames(self, *images):
         """Check all entries of given images for unsafe unique names"""
         for image in images:
diff --git a/tools/binman/test/security/pre_load_missing_key_name.dts b/tools/binman/test/security/pre_load_missing_key_name.dts
new file mode 100644
index 00000000000..262219fb6ab
--- /dev/null
+++ b/tools/binman/test/security/pre_load_missing_key_name.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			header-size = <4096>;
+			version = <0x11223344>;
+		};
+
+		image: blob-ext {
+			filename = "refcode.bin";
+		};
+	};
+};
-- 
2.43.0

