Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B57F8DFE3
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 08:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBDB084262;
	Fri, 17 Apr 2026 10:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="NIsM0Wqw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C21448425F; Fri, 17 Apr 2026 10:31:23 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A86784258
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 10:31:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yan.wang@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUFgSpxORGUAZBKulvDy/ubFGNAhmt58XqOhXIdhRZoOCFiXVksL4AtNKT8XJIQlWSdUTnZY2oBjns9j+VL5fYwFj56djexotOnxZcmJ7j7T+nEqAojPcqSzHz3xWLqa7EqI6d+wKqfftoEuDS6WwRDm2b+yFgEXk6NhHcUMaDdRbwNOyrbs0HfTVhMsPGhMw32K7EkROFU4UA/ZiJ2LT1EZAp5iGApi57tgjPqf1yWwyVAsEpP9rYiRV7gEKXmSfeKt1BdtvqTsfhX4hxXSdbZyA9YSDlt6X3AA3/Ao0dGwah5r9dSA4oArjUbaQYk38J/NaxvmeajnMUFWuLYr/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxzAIUmsZ4DKv2U0wRjqTzlV4Lc257yVt9QtE/sLYI4=;
 b=gETYz8jBXM8Qgx8WTHBjVS8mPz/ylWKe9e3N0NqJQn9lisHpapBQai2FkzDELAD55+SPhIfDkqBj7c4EYlLX+zGq6HQJmUj1PLhPCYhTNjXE3xv2lXJXbxRGw+CI5KlOMpOL2OdpQMjo5dVR+Bv7lk3fzvIAAuvlhHCbxiCZ76qOTMjr6IGObsGi76pQ0RCV27VGLA0QhWkB1dWBA3vLpMSONNbhJJSPXDeSp0H9EyAAyxOGKt2QDy1vfukiE8bZY7r3fc9Zl1dm0YXFcJdtDCvJp93OKXIB5hXlGXFvGa2WprtIirrbaGeMqwjhk9+JNSFy+DCN8jOkCo+N1hSZyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxzAIUmsZ4DKv2U0wRjqTzlV4Lc257yVt9QtE/sLYI4=;
 b=NIsM0WqwPZXOz+cffEWKiBB9FROkP/ZnQj85LlpFIoptw4JLcayFpbMeIC+j7j0sYaOZCiGf3E4JWUNXk335eGp6jnV1huVJ37wojGpNLVlMIURZvPNfERbZKNpLGl5wvFwuxCIEIuETSEou+uGrlTex98XfTb9xj/yXcff+mbt6Ezz74jvgkNZYVOPP5p3RXMFOW1bFSw0SYxtRVM0wg6IOzMRiVZa7NhRPS8zbQLR3uHhImuQXFYB6hIcdiA10wC0mV/14KH7g93V9lUqiwUIEC0UTC36TO7aGtPdmc+PPQFfI9V1/cQCLkJemPGZpGwQ26Xy1Z8cm+WVwdw7EMA==
Received: from PR3P189CA0068.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::13)
 by PATP264MB4833.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:429::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 08:31:16 +0000
Received: from PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:b4:cafe::e0) by PR3P189CA0068.outlook.office365.com
 (2603:10a6:102:b4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 08:31:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FA.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 17 Apr 2026 08:31:16 +0000
Received: from sah1lpt719.softathome.com (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id 41ED61FFF1;
 Fri, 17 Apr 2026 10:31:16 +0200 (CEST)
From: Yan WANG <yan.wang@softathome.com>
To: trini@konsulko.com,
	sjg@chromium.org,
	alpernebiyasak@gmail.com
Cc: paul.henrys_ext@softathome.com, u-boot@lists.denx.de,
 yan wang <yan.wang@softathome.com>
Subject: [PATCH v7 2/3] binman: collection: Set build_done on referenced
 entries
Date: Fri, 17 Apr 2026 10:30:49 +0200
Message-Id: <20260417083050.499955-3-yan.wang@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260417083050.499955-1-yan.wang@softathome.com>
References: <20260414131558.538656-3-yan.wang@softathome.com>
 <20260417083050.499955-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FA:EE_|PATP264MB4833:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 68fcaad1-916e-44e8-a411-08de9c5bb166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: huAlTSBbDdpExLjhQlbEXKRbBbYzq7N9/M6CZK5KWAlf+x7bPxPh2BJrqM1V2rt/xo2Ff4SgZ6P2GA3jAT1jMtoO61J4Os6Fuqq8/mb4PFJA9KD3FIUtEtb+0V1DPud/lxwBHvXkdZtQACHmZksHLtPf4n5//yM3myKf2fAtxKaoXT6gksOzr9/dNoRcABcZ2MdUsp0GclXUBAJ34mg9uOPZ175V5S2exJtYtpPlWVvphQ+cnNmx/muw2gb2dupvNpQrbJZhbnZcWCn2sVvTmvx0r32J+9RMSb/Iej3rPWV+rhohuPBxFx3t+b9i0hVOM6UafY6RoJpuws7pcJFIsvZnee6ClZPEEyxAdH28R/7Ka4QgQYJBpnnGsCzy1AUcCO5gnhgoumE1/ONUgLwk5NHYpHO572sh9+UeoVd4Xthg/nJUHJfcKJZkAGsv9nPlycPHlqafuJcOYe/SmHh/38vQRdRBg51meItTsSBu4MAYGCjWdrACau/bwvCKMc6nyYNxavfg3aMj/EVcdSKGUmL9fTou8rpNugx4QtPJOLp2eziMVkEKh2xULmxs+PiKK0b3Lch9gjYlL3LpRrDitlimrORsjzELPgBboHLuSFk9NbYaIsAZHdskKA8gPFIVBp0o7pEtwFkK4Nm8UrOWqwZm30jiw4mfNR4TLXBsE01Zsf3A5VvOuXKn0ZB/I7z4ho/ieyZ55KMYycPFdpBJKxwAVtCqbuVFRJinRX21g0F1YwQcYa6YfewyKKi9HXpYAH8LjXrmqnAd5EQUqYzZdA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PivUK2NJFVqTV4nxy9B+54rIZ2ErSJwdjM6ppUP2o6b1STcQt+EDabRWwxL0kFCylFfiixB5KzkiloIzVj/5B6TbgKkrPj/VTaYWpqOMwbuEuQo2Yq/AffiyTl9ttaOcvJFDSeif5td0+qehYZbdUEyOgSC9DP8Bf7DaJryHyIKTC5bdAdLIDMecRMHy1mmXacOS6ozHlV7Hu/V7rie+HFTyvNq6sXsFNY6kkzUuvLuKQkF2ytbYZ9Ra2pG6D/ed3tCB9PhlrP8/eUxMLuKJp7VhJBwu2DBQLukuuydtqMl3q0vqBbNPrb7jBkQvGRb3rKeExfsoBVKwSdakl492YFL5B3mhfeBHJ1J8NE4qMVTIwGLbl55CxixCWeJBT6P9p0IUsIQ7tiDk3nSmEF19nsJtdfji+Za5MmFzo/oRhy1z0zX+Q2EHbDN7R4Sb8Obv
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 08:31:16.4709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fcaad1-916e-44e8-a411-08de9c5bb166
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB4833
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

From: yan wang <yan.wang@softathome.com>

The collection etype uses phandles in the 'content' property to
reference other entries. Mark each referenced entry with build_done
to avoid rebuilding the same entry data multiple times.

This is important for cases where rebuilding may change the data
content, e.g. due to timestamps or random IVs in encryption.

Refactor GetContentsByPhandle() to return both the entry object and
its data.

Signed-off-by: yan wang <yan.wang@softathome.com>
---

Changes in v7:
- use mark_build_done() to recursively mark child entries

 tools/binman/etype/collection.py | 9 +++++++--
 tools/binman/etype/section.py    | 5 +++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/binman/etype/collection.py b/tools/binman/etype/collection.py
index c532aafe3e7..866ea8dcc1e 100644
--- a/tools/binman/etype/collection.py
+++ b/tools/binman/etype/collection.py
@@ -45,12 +45,17 @@ class Entry_collection(Entry):
         self.Info('Getting contents, required=%s' % required)
         data = bytearray()
         for entry_phandle in self.content:
-            entry_data = self.section.GetContentsByPhandle(entry_phandle, self,
-                                                           required)
+            entry, entry_data = self.section.GetContentsByPhandle(
+                entry_phandle, self, required)
             if not required and entry_data is None:
                 self.Info('Contents not available yet')
                 # Data not available yet
                 return None
+
+            # Mark referenced entries as build_done to avoid rebuilding
+            if required:
+                entry.mark_build_done()
+
             data += entry_data
 
         self.Info('Returning contents size %x' % len(data))
diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
index 6a26d687056..8530b7ee17f 100644
--- a/tools/binman/etype/section.py
+++ b/tools/binman/etype/section.py
@@ -557,7 +557,8 @@ class Entry_section(Entry):
                 return None
 
         Returns:
-            data from associated entry (as a string), or None if not found
+            tuple: (entry, data) where entry is the Entry object and data is
+                from that entry (as a string), or (entry, None) if data not found
         """
         node = self._node.GetFdt().LookupPhandle(phandle)
         if not node:
@@ -565,7 +566,7 @@ class Entry_section(Entry):
         entry = self.FindEntryByNode(node)
         if not entry:
             source_entry.Raise("Cannot find entry for node '%s'" % node.name)
-        return entry.GetData(required)
+        return entry, entry.GetData(required)
 
     def LookupEntry(self, entries, sym_name, msg):
         """Look up the entry for a binman symbol
-- 
2.25.1

