Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A819F9D0CE
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 13:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A94184207;
	Tue, 14 Apr 2026 15:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="c+E1ePMM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A44E8421E; Tue, 14 Apr 2026 15:16:27 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60FA284214
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 15:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yan.wang@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQFRGYNChaX3ryJ507+ruWPudboF3SueS6lqCP18IyPTAFCQJ0j1o+RhbgQOGEZRHAdohWFVULmhElZ/n3qH9mBVaWXMnARE2ep5LyxGVFT/UFUPA1QD9Eja2wy3qqW6GE5AsiLQP0SGF0OinxLR0tW52xTpEQ480ih6KCnijFgSxchvyzwD88Zu6aXfNHtn/wjB5kO8z0e00JsAN6nwppoCL0v2pU8qAiCUuLv34BrJ0TfUCqw7KXOVR3QY0kx3xPY95PX5v+Gb4zrgASlNh0C7nTHCvOXKVSf8PC0Qj9eTu8Le67Yc0L1YL5bo6tHJmFduclT/LGsGUDBEroOdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJPGVkwlZgLjr0FSj0SE7Tm82tw+N1uS1zEPPXRHPQw=;
 b=ByVJlGv6f/U5iOLlcvvxEVZ/rkcUMsBKNXCqf1/MO7+IBhHFUil8uvF3zcDjUZVu3/f5rS9+8ASh9n6bR4iMFgdae+xTV2LC/Yb/MdRNBpsqswltpdiQKdrnrsQZlp52LsiRwoZeBOwVh/g0Qxrjd+TqHAI5xnawf6BaRoirX684J9k1Tgo8HLWwj9v7kRtVTj0emf++9EnoZ+88nmtx2uBCwGLSLje6qfnDn2oFoaO/UVtweI32rvGUrfyvx/d118DPdy2r5uoJ1oqbz3qRFvJ8fgr3hCecMgMCM3POgE1OP8wRQDSSPnuKbj9GB9IhkkEsOk+72Z9FINeLffVjnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJPGVkwlZgLjr0FSj0SE7Tm82tw+N1uS1zEPPXRHPQw=;
 b=c+E1ePMMU64D6H7rShHXVVx+DL3HpwxM/IoJaH6g21pDtLP9TG+b9DyeO/0O/TFP4Sr8wo8sN/ckSRwZ51rWTveKVqVR0z90NTXB9BCnF5h104AH0m3R8O1KrBmeqQkI2Yeu13zKkWMS5Xdj5Jd8NeLt9ZlBmWTQmCb9WjtSoZKhh+dfeeia5INSYAynWtf8omeIK+E45FRGsH/kKVqROWyPZjHRZ/sUQohoCJy+0Bv3bxdx/2SRfP36C7S/lp6Ua+GPCiyx2XVL1vhWULdEkBI0c4y+fes4lsxEln4ZqmSFZVZegngOuyE8sDajTbkYpIutFLWK9r1unjmY+0/CIw==
Received: from PA7P264CA0027.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2df::19)
 by PARP264MB6936.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:55c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 13:16:24 +0000
Received: from PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df:cafe::5a) by PA7P264CA0027.outlook.office365.com
 (2603:10a6:102:2df::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 13:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BA.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Tue, 14 Apr 2026 13:16:23 +0000
Received: from sah1lpt719.softathome.com (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id 39D2C20737;
 Tue, 14 Apr 2026 15:16:23 +0200 (CEST)
From: Yan WANG <yan.wang@softathome.com>
To: trini@konsulko.com,
	sjg@chromium.org,
	alpernebiyasak@gmail.com
Cc: paul.henrys_ext@softathome.com, u-boot@lists.denx.de,
 yan wang <yan.wang@softathome.com>
Subject: [PATCH v6 2/3] binman: collection: Set build_done on referenced
 entries
Date: Tue, 14 Apr 2026 15:15:57 +0200
Message-Id: <20260414131558.538656-3-yan.wang@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260414131558.538656-1-yan.wang@softathome.com>
References: <20260408150201.217942-3-paul.henrys_ext@softathome.com>
 <20260414131558.538656-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BA:EE_|PARP264MB6936:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2eea25d5-4e04-4364-a2b8-08de9a2806bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CoOLvkB7SLyIRKufomW6onoInvjVsea+q4byigfmbVsVhrN3viAticyZ+V2JE6Z1e0G8w0jVlT9FquPnTgpTtNHd4ocLT0VbVwvotBL//gm39yFb1ffgq5DTsTJtz8Q05Jn8tDDBxyVXp0WPc8j2ZY1FfEUBMRlLmWVZ9OA4ax2appLB665pMGX/4w6rGZHo2BO9VWBgZPXabjswuqq7v8RXwxx02qnRuqrbA1JO5Ywp2tazhkWGi5ZuY7zuFnJ25BBWt/Fx99yDQ4dW5MA6qfOppg9cLmxgYtwenj60ZFuERhXCucnTi12jX2gyQod3AFexHv7SElyw1Nd5o/sXjVrmFi1WUU5yxf8MfKWAFPUFuKDBhHZvDienhbBCKo3dIqGUW94mDbT6oDEI2t5yPwzVgqDe0gQ1CTMneRftXBNdwtG5L7YE3GeOoEIHiV87bccx2Gii43jcr3pHBXK12aj0cq9Fvb2H1s6ez5SvDGHS6Z7C9vId4s9A1N/PBpEsj3vLJUOaS+tcxeFV0wcCPX+OWTDrzVIp/kPcOi9wJtn5+qHNAqBbxYr3SY2vPt3S8vqw2NmNO6MxjI842kFPGtTryPwnn0y6bC3EEC/IBXchDkMp3aTmMiJvgbkL9KSigbO/shm68nYf3HXFjXoPr4mHzvWaE4Y2NPKv9OwWrKHD3/QRiJOzD4PJTlR80czb7LbhaApIwhmxR7nRk5MEQXMfkW1Zckzknq8L1H8mThx22LDCV/ead+VQRLXQpw6w+pOGR85nrArOvxKyW0morg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dCF6wGQu0yADplJAczJLAR20V3V/Y6CKKthx5/UZp1irSV35qEuQ3F2nfOmXLBgxAXBKyQbT6A6J/VEh5u2nprd6msO/SNgXDlt+I59qTrqKi7I7MpO7NwQ+AdunWOerDADISx/hCApYFyhUNHLX5E073/nIch5V8npye2jTJY+J0sLAYoV6ybqA46lskBIRQbPnPeztWqKvndI+xE+UfAw6Z+B8UVta4vxgUvPh/WI0Vy80Y7s3HnkDYG3AtZg/6UVXxu+W9CV+lT6zdisbV3DnH8gK0i+TixGVmBs+j1u/NB+dptCIVu/p26E04YfwFLnPSXBBuYkhs0mW246rmeXovJwtzGWTQ2JMOdEuOrvWuO6RKUSu3zA5kWvS1xTwSjJsnRDTCvmqxJ9BGmYtkaRBraCYqltBItK5k4n4Q0GrbwG0ebXeQpVs9QLT4S76
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 13:16:23.4752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eea25d5-4e04-4364-a2b8-08de9a2806bb
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB6936
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

Changes in v6:
- set build_done only when required=True, so it happens during
  ProcessContents() rather than ObtainContents()

 tools/binman/etype/collection.py | 9 +++++++--
 tools/binman/etype/section.py    | 5 +++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/binman/etype/collection.py b/tools/binman/etype/collection.py
index c532aafe3e7..c0ada42e3b2 100644
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
+                entry.build_done = True
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

