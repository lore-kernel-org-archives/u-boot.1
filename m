Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E42D730AF
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 07:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF15583CF5;
	Fri,  3 Apr 2026 09:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="sivDE+VH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BC4C840B0; Fri,  3 Apr 2026 09:33:42 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BF258382A
 for <u-boot+nodisclaimer@lists.denx.de>; Fri,  3 Apr 2026 09:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQ8m3hp8iYYdNSCR25qbQ4CX/iZI4J6UUecj/w2bEhxxHjn/nkbT0NUQhQxHhPNQVMfeAKAsCABtOi9bfzehan6lJq3GfIeBx6z1xmfWS2gH6N11NYf8LNU9KpkFnrjAJQvkj9JNiu6oKm6oYkpMgwMpqlP8jxqCLOA9tlsIznOKOMRZbJUL52BCuP4n6CoTOP3neWAqKiqFY4pB7qyi/PVUnO7goVjX8549Z05bUPzd37+elTULlQJl9xaDgZT9Y2j+B05TAfJeFjvoPyS67LrTi9Y0rhB8/8Y3L2Yd9UyT2gSacgdOYCP9UpbAr5uDTLhoLZSAdvjw0yobfh4Z7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQsJ3nWKLrCCqz6iwkojsPoa2ttMtgdiHVEptLRS1pQ=;
 b=axwsMdc9NjB4FrYsRM48FksRq7wnrjRn5GVbc6iSnJFuXsZ38SeR71Gk0j9yM0B/JyIWJc/goMw+iM2wI8VwQQtK5I1qwejNL3LRtYBBPaz+98CfV2H11iIa8HlN5vkl8AB9nbBOb2RxTwZ0EtBZ3FBXoTcLaLxF9GFKsI6mvuZJpIi2qBEggA6vla/wmVney6qKo+Fkzz1d1mEjuXwIkExhgX2xSI4aKFbgliFsm0A7y6UgmIlCxFfjivHOusKY8ua28WVe0l+/tz7WwRvZgonnuXzOo5y4/nwmHB/xFvq79jEnOMQgwg8GYhQ6HJIfbIBw9ulC42p0G2qNIQaasg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQsJ3nWKLrCCqz6iwkojsPoa2ttMtgdiHVEptLRS1pQ=;
 b=sivDE+VHTidfGaKCFpsLsEjWUd+LiuhBLwTjOqxvW6TEOR3Oji8kPZYxX8TJXVCxh5/zHGJFhfYc5dKKB12mWNeROtz3orKZ4BRhPrPQQ3pCPSTXBd0FFkmQEhmqmZS5yA7IPeh7xcAjfLfwN/7cIZRJTo9SXPYNRuZnX98KTOr1uPahsiFR5nUrXclNHeB/XepS3t0KLQO1Xwm+hzI7FNms+PB0CLlsaUDpcGhB3kb83U9+mB1Nzdzta1X2G3ZEjSys1qB772qNujISeHsQ8TZc8YvZXNBQr47giubwXOUi5hzavmXQbTARwPQC8SXjRhOjcdj/l7bUEOY1VTiuug==
Received: from PA7P264CA0521.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3db::11)
 by PARP264MB5417.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Fri, 3 Apr
 2026 07:33:37 +0000
Received: from PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3db:cafe::fe) by PA7P264CA0521.outlook.office365.com
 (2603:10a6:102:3db::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.21 via Frontend Transport; Fri,
 3 Apr 2026 07:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019230.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 3 Apr 2026 07:33:37 +0000
Received: from sah2lpt245.. (unknown [192.168.72.220])
 by proxy.softathome.com (Postfix) with ESMTPSA id E21542018F;
 Fri,  3 Apr 2026 09:33:36 +0200 (CEST)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot+nodisclaimer@lists.denx.de
Cc: sjg+nodisclaimer@chromium.org, trini+nodisclaimer@konsulko.com,
 alpernebiyasak+nodisclaimer@gmail.com,
 philippe.reynes+nodisclaimer@softathome.com,
 yan wang <yan.wang@softathome.com>
Subject: [PATCH v3 3/3] binman: collection: Set build_done on referenced
 entries
Date: Fri,  3 Apr 2026 09:32:51 +0200
Message-ID: <20260403073251.1051533-3-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403073251.1051533-1-paul.henrys_ext@softathome.com>
References: <20260402192431.2421155-1-yan.wang@softathome.com>
 <20260403073251.1051533-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019230:EE_|PARP264MB5417:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1a8b20ec-7710-410d-2aac-08de915351c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: D31Lrbjj6Yy3yij+qq+vdjaBJwcjUNpzkHugdMBFwPGzsujoQGODAstSrOF7MADB0xaI71f9eYHAcKaYb66VVTOMQ68wFw0hNh671ES09n3NxNB576phqnYO/+PjMSm5h2VrlGc1qGwsoZ5jFFjleZ9QoYfPhSljAXUQxG4hvf/Rr8910Or+kQ62v+qblabY5MXjrptpW37jRlhv2+AZF0n3BDfClb9FdURKWDdPV6vfQ81CZd4XUr8XOFQwvMgXP64/PT4Mw5OeB0nYf04g6l07UZvdffm9dhqVbq+XhTZTClT59LzT5FTJGK3AhFGdeJxLpQqj0B2j9LKeU9J1mL2lAMKPaK6zXaRMUkakD0InKBRQXlqgbKELo5YFGdxZO1gd4+KgpsYNGvjVCrXKqvEm69Us0hltls5m6kNZJBv8KeMWMoWGviKIbzU2jzg4lcHJlcB52ds6AhtN9U33GPaFNP5t++5cQjW0fSb4A6sU37p85WkTJAWehsRpxY+eW6Qge6p5OqiyWrLCC3T6Ly1wBD9S9y4mVKjdSrhcBCcUwvnfjEZ/mtVPGhomHo8LDZaNJ7n5a1lLJ0pP5LwYBP7ICokVHsDudY4XtqDPtEglmEAOHGQ2ldMu0qPCvuA3s3JDagG7t4GwvH0BzH0DbgXQyE27QTJBfPuS+vcpybSkuerjOiteaW25mjWYtLI+hfbLAkSBxjJ34iuAut60wJCErDdPtFaifBs2CcqewugmOCjIH35JBCmkvwohJAoetheZN+qHeQxezVQJg+ADiQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dwGqVyIuO6QYRFPslLQ6u9GIe+6T6RqnZztcrDKK3nqJa9UcObRhm8wkJ3XvaOp+8QnKF163GbHreT77xUuTDpLiE/6PiOJXF9ozfIkoSvUUfMPBNyIBz4YvjQZmBM+cucpPvUiBCbYjXUlsitCn+pDZz6kW9r4J64/Zktj9zwgRXsjqkMQOAL+kt6Fv4uByK1cQQyINhDznStCcNxm8+sqZ2t1vfwHNlDEJ65YdtAAMyrjTywT3rNRnx7uJ55mzRWYG5x6kLTJ4CDR+hpqi57HhTZZ/s9rMWZU+k77ilu1aLoB4HFgobeXmetzAStswU1hcNjwMd8yUxIPEsODKIpcbT1psUrnPewq+TKBRUBtlezR/m+/zo34vhyZmbEH1t7swZCFGPSAo1z8f2jcFGCPQhm7HSATq46UORdsg047LPkusXiYn2J/3piFiu7dx
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 07:33:37.3012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8b20ec-7710-410d-2aac-08de915351c7
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB5417
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
Changes for v3:
- Rebase against 'next' branch

 tools/binman/etype/collection.py | 8 ++++++--
 tools/binman/etype/section.py    | 5 +++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/binman/etype/collection.py b/tools/binman/etype/collection.py
index c532aafe3e7..5ea6344bd25 100644
--- a/tools/binman/etype/collection.py
+++ b/tools/binman/etype/collection.py
@@ -45,12 +45,16 @@ class Entry_collection(Entry):
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
+            entry.build_done = True
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
2.43.0

