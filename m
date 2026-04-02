Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E772D6AAF8
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 19:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C70B183F7D;
	Thu,  2 Apr 2026 21:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="OjVeLOK/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED6D4840BE; Thu,  2 Apr 2026 21:24:49 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E57D83D8A
 for <u-boot+nodisclaimer@lists.denx.de>; Thu,  2 Apr 2026 21:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yan.wang@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwR3SucwsWDKzFlATb4zkzPp5rqjHJt/uyxCUb5FfOJ4GaTur8uKXMrhKpOo/q1pHSDgZgsuJTRoRdIFhzUy7RVzwJbyjMocadLL3YBnFe++0DUEZPyGMa4KzJU1cN4SpPtfPwLBW+95TGzolDdRFKlPqcXikInkQ5BkOpO0TX88KRF6WI3TfpDeQShVdHb+HFTm0jPYweFxaHg3h6g2sbYht+Y6lmXoH8yl5lGpMxfqvBaGHghtcXHOp8D92XTtlgTJmDeO2T09YVgI8ESqqWcEL+K71PR4FL3OQrLK9FRSXlLmPps6C/xwzkeVV4A91Q4J+lh+8LbyTCFJrY/Xxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huhTTF8rRQu8VCRSV63jOCotBETetE9nUvc50ijNBmA=;
 b=OOcWPXIpBlur7I3DOSe+1t8S5ZWX8kFOq/yNngoLmmRo76Qx1HviaeqL0IXZFlmBPC/gbC7CQb7UhB6LawPt2NL5dFwMHRM+hAo1khmkqtHhsU14PAJb+JTCDbRQKYyx8P0Iv3Nt1BkVqxelVKyR4W2o7k3H3IQ7YvVRWEh+/oKayjnLp+usymC4t1yoHC2tA5Kqqok0OkkbYuzmQvZmcBxX4GKNGPyLw2L2JLtzvaYdYX2jt7lkyq7MQpAPLt2FlQA6H9pgwCN7OJnRj+LMc6EtS1AU0Gy5OlRx3NYdSdt/KvjBK8oCt9fiKoriztVOx/X/j7Dkh+AB3LJrOycUZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huhTTF8rRQu8VCRSV63jOCotBETetE9nUvc50ijNBmA=;
 b=OjVeLOK/z7VDY9mE1uSLOyFAFkpelUhpm8g4r+zybM8vmsM6Ag1qvvhPIpf5jMNicROrsT5+hYShE6i/w013C0S+lhvXQ2PBx0ipWRCEbp4lgn9wD3fXQtPszZvdgcrGAgs6R+inrk3J/5rPiNEgWEbwwffTwbsAf9I2ouCYvBJgnvxomlFekxOIa2oiTsa5XHn+KK1b4dql4xsIfsG7vLQdaoNYt13vO3Ch+6/OECMNqoyOPyYsOM/+XFkGZd+RD3cBYiNc/1JE2gS5l6JkutEv0RndVK36SCsxn9S3uBeQco6kAh4nxggkkvu10W9hM89vHF8mORfxy7oL9pxdGQ==
Received: from PAZP264CA0045.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fc::14)
 by PR0P264MB1722.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:167::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 2 Apr
 2026 19:24:44 +0000
Received: from PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fc:cafe::2b) by PAZP264CA0045.outlook.office365.com
 (2603:10a6:102:1fc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Thu,
 2 Apr 2026 19:24:44 +0000
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
 via Frontend Transport; Thu, 2 Apr 2026 19:24:44 +0000
Received: from sah1lpt719.softathome.com (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id 1E154201BB;
 Thu,  2 Apr 2026 21:24:44 +0200 (CEST)
From: yan wang <yan.wang@softathome.com>
To: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org,
 alpernebiyasak+nodisclaimer@gmail.com
Cc: philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 u-boot+nodisclaimer@lists.denx.de,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v2 2/3] binman: Generate preload header and sign data only once
Date: Thu,  2 Apr 2026 21:24:30 +0200
Message-Id: <20260402192431.2421155-2-yan.wang@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260402192431.2421155-1-yan.wang@softathome.com>
References: <20260402192431.2421155-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BB:EE_|PR0P264MB1722:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b110775e-bf04-434c-23d8-08de90ed7ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ctRDYBYbjXjBnVtKwFDCH+iof20AIDUBzTwdhHZe1pEhVXQvi8MNHL/cFNmWLlhK6QTFkc/o8oI5RZDV3ALJwG6jJ52kguOrif4aNcIjDHBdYDofQaROMrtxTkvPTRLF3BVRvbPLVxKQskANX7JVptUGRX3Zp3ZX5Z1w/kNlhYVGuZGcjPdtuixYQwhHbhFiKgNGxaoWHGVgXzXWJ0UzaVohUVe+28Tq1lQe7A8jbenqqkqxQqzNlV6hw5yahx0sxSJedIf8xNHMWYY4i+N/fZdrzzX2LUVSc6v4vSojkHHgzNq6kkj6RjkYQo03xMl9kQTTEPTL/2WVHDBWsk3Fc0fjQExH+InvJouI8lUj29syPw6rFJjdgPzoRDKDbf46lOoN0Y4MIM6N41piLmShdgMm9xJOHMo2U2aea8r8yh430ekuJia1tkYVt87qxA9CTkRG8IEwXaiL2EbIWHglb+4jBujJUYAY+r4MaQUzRI7+KgZEOPJks3xyogatfAvejaCZSiklyHbBivviLYDZLDGNbf+tqezUuRWNEBnYq/VXU+DOzGdC1v1LVhtctJsm4/6hOyPyt6/Owf3M6XsFmxIUIstg9ZOw9NTefjpoz4KMfClrJxc/QHaBVIOS+OqkfGUt3XLEUDrAuD9CiRn6y7KnqQ/kk5dgH3NAnqFFT6e3lkxP6bkXgFP2186LUGQzHVBk9y+BuAlr6mJpsmjudE3pefZp907gBmkhj6BZHL7w5zzS0vNrgpzO8BWqd79gvYCS7UlyBBFospK/7lO/hQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zVjlR0k1eIUkga1jTlihhxbB36fLMgTDXEBpylcoeLwQ9eISptBX5IybskrZJWqL314ZgSEPw4uA1MApsVfpfUX/6eDyKVhBfS/ETw8tlRfK7rMKowWl2BXNlPC0bBV/F64jIJWs+MnjoW0Kxvy6xnYGO0t8cc0yZsOOCXndRLBUhrFjJvppLwVe5KJpz95kCa9PibN4ROH4RfXh2xBclmiaY5EWVhb3bFeKnoTZ/jU3bCoxMNlwOvS0Hez8u03mQvYeJeJtJNQHyR/JAkASr4Fw2HkFzwacSSbatOpkAtgRKwW5c4eqc5APJqihELWQmU8YpvtI0xy5TGZljdauXpqYbFRZ+JO0K+X6tesQUuFOsv9LhcIwgUX2trOiltLPvhwTHcjymAdl7OoUz/8cDTIcEInQJzOrYBSs3yme4n/mv78pDbNvf5p/UTp7gh9s
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 19:24:44.2341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b110775e-bf04-434c-23d8-08de90ed7ed6
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1722
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

From: Paul HENRYS <paul.henrys_ext@softathome.com>

To optimize preload generation, generate the header and signatures only
after all data has been collected. This avoids signing the data multiple
times.

Since header_size is known upfront (from __init__), set the preload
header size in `ObtainContents()` to avoid an extra packing pass when
ProcessContentsUpdate() detects the size changed from 0 to header_size.

This reduces unnecessary repacking and signing operations.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
Changes for v2:
- Set contents_size knowing header_size in ObtainContents()

 tools/binman/etype/pre_load.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index 00f1a896767..34a7bc1b985 100644
--- a/tools/binman/etype/pre_load.py
+++ b/tools/binman/etype/pre_load.py
@@ -152,14 +152,14 @@ class Entry_pre_load(Entry_collection):
         return data + pad
 
     def ObtainContents(self):
-        """Obtain a placeholder for the header contents"""
-        # wait that the image is available
-        self.image = self.GetContents(False)
-        if self.image is None:
-            return False
-        self.SetContents(self._CreateHeader())
+        """Only set the known size of the preload header. The data will be
+        generated later on in ProcessContents() when the data from every entries
+        can be retrieved.
+        """
+        self.contents_size = self.header_size
         return True
 
     def ProcessContents(self):
+        self.image = self.GetContents(True)
         data = self._CreateHeader()
         return self.ProcessContentsUpdate(data)
-- 
2.43.0

