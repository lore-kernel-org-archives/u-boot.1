Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81424D730B7
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 07:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF1AD840B0;
	Fri,  3 Apr 2026 09:55:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="F0cSytFk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F47C83CF5; Fri,  3 Apr 2026 09:55:47 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69A32840B0
 for <u-boot+nodisclaimer@lists.denx.de>; Fri,  3 Apr 2026 09:55:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0lJ7OQJj/U2NFKmAmQYG99W/fDfkVv7i6F56WZBJFyYsbd/Lb9orXHi+u3naFpsNwMlpAAyoWK/w81mRKCnIsiK81fyyGeV7SjGGmKwmnAoxhvqTLIF9fyrI0ve6mVnT11Pr6ugRkiMWRTNHwqprGHiHGYtMWlIGmQfG/YDoYCynDTklyQEhneVYDYlMCWMajvtcwhNnaNYSHMyWf+b3UNZsSVDRc82ozB9va5SKrgNVxtIXZ6h6Gu3s+9Ab6jNXm6ef2Ni4EMH9oUaF/crym/LKt2KuTRksplUMxNjfADM/fzfa4aoUrH0bme8BrxAzfF1j17Y8Pamy6WSW22Jmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKgPU6n/UxPHSJjzUN3LIsTRfDctnao4Wg/3hXqjM00=;
 b=Gv2nuZaF89TS7XYuGDybBmQZTn/SsrDGMNevWH5YNOWYn1CzOCOP/eVg+rk3auwGbkeRIZ9stA+oMLZXnLot5piH8sGAda6UBDUJ5vrKviJFbLyBlLGhQRn847195GwE8zOlkC2Ib0kY0E1lsXH24dug+CY8SjLe2MVhnUtHWkfWpIPTnNXeD9zYBxPX1S+3tihdVQhuUq4NOFzAPnMh1lzgBhDjNNf3bCedgavLfmblGnQDeAQoG+x2R36/SU4SlsoriVzuB7Sk2J5oWf4s2P0za3Vm5w3upPJPPWgYMgu9+J7DbT65pxCLY0FioDiK8PJo/0+C2ZbABDE1HqeoPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKgPU6n/UxPHSJjzUN3LIsTRfDctnao4Wg/3hXqjM00=;
 b=F0cSytFk4qwkwDkm5Kv9U7ux6vYuImhG+LLdIsU00LxIthSBw725x4ZZLdvgJivda1/8T7d+GHQ4mDqQlLqojA5u1F4lDDk89XNGK3S+O6PIYj0ZcqJ+aNuk8Ej4BgwLz1qL/XML/8slkji/VVjRLuQnBGLRM8u2xjhCRJJv7s6yiBph39lZdViHrbcRVAV1yoIbvHJIqx9RNqWSSYt2XkfPLjRbeAUvgfMt9KTx2jfUrSAoybTtKKFe7aT+aM4AcylQ/ahXprpQbWXGmCJLDbEoCAjcBm7I2x5FsiFlwttIoSw507SEMNFH5sGwJSluQR6cTgKQQZjQi+Hdb3ctQg==
Received: from MR1P264CA0152.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:54::14)
 by PR1P264MB3296.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Fri, 3 Apr
 2026 07:55:40 +0000
Received: from MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54:cafe::ef) by MR1P264CA0152.outlook.office365.com
 (2603:10a6:501:54::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.21 via Frontend Transport; Fri,
 3 Apr 2026 07:55:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D57.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 3 Apr 2026 07:55:39 +0000
Received: from sah2lpt245.. (unknown [192.168.72.220])
 by proxy.softathome.com (Postfix) with ESMTPSA id 4D75D20988;
 Fri,  3 Apr 2026 09:55:39 +0200 (CEST)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot+nodisclaimer@lists.denx.de
Cc: sjg+nodisclaimer@chromium.org, trini+nodisclaimer@konsulko.com,
 alpernebiyasak+nodisclaimer@gmail.com,
 philippe.reynes+nodisclaimer@softathome.com,
 yan wang <yan.wang@softathome.com>
Subject: [PATCH v4 3/3] binman: collection: Set build_done on referenced
 entries
Date: Fri,  3 Apr 2026 09:55:28 +0200
Message-ID: <20260403075528.1150196-3-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403075528.1150196-1-paul.henrys_ext@softathome.com>
References: <20260403073251.1051533-1-paul.henrys_ext@softathome.com>
 <20260403075528.1150196-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D57:EE_|PR1P264MB3296:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 308de5ac-7512-441f-4fac-08de9156660e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PwxSmHmAA2r90wlmOIt2l2okyiA2z2SMMTEvNRQyYdKE0sOVNzvoVHbR/SWO1g7rfdn5WaL+FR8yqTkKl0D9lmlHTL24BDkpADjEx5hanEaxcjpuLpAAWW+nFJW091BqzWiNagh3iBSsrqdYTq0voRUP614/RVQ4e0yGSgSkb1f2MtmuTh9PvDHV6Ot78bDNlNr+Vnx6VtwUMQJnql6mIjMSWgx6dQ5MZRzXsee4YEeDUsZGtEbWpmnI3gdqRz0vY4+3X9iBhvlH9Uya/nzxYqJBFihhv5T4lbJzXfbru52EHDqO0yzMyKPfVS82Us5lZ8SWTxhV92HaTZw5yuk1HatoheMMJww9iKdMXHFFsW8WYYG3IQ3wAtiQuLPQlKW1+kpS8usOd7FHOmeUUof0EoC7En4N9PafGzxaXjoxerCsexqEkcTUOh+/9TJhfhTYjC0pBF74MxBcMiQjz5+ag7ikDocb0cYyzBuFZK/sBDgu0HWwLW+Aun/8LBM+VP2Z39BZVOJQ9O1/I7Iap35sX0rxqNC8+uwq8PmC1P4MC8lrCwwK/PSi4IzWfoT2vT8M6mJ5WRdlwMwXOq2aL7OmC8nbs+PhMgbx9Dr3u8Ujz5K1b67HlLuNn5IQzxt2T0LFNRIcoBywqLEko15rHMtobNC198I30v8QBkosKwkpMIPMDrL8hCMSQK8kzL6UO8Z4pPk+QQR4R3dRCFIcpacduKnbGpcJ0GfSLnamlTd18Y25zXSFSKw0WRAv4Z9ohA5J0l1q7zXcTeY5HMjUeUy0tA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5gE6dHleRKiExFpZo1/rpBh6PBv9wc9wcJ2Vy1pIDcpM1dlbTQn5r5UdwRio/quaLIm2fQM+511qGXRYYSZes9hehK9409UzQslpn0GEP8fXKWwFU4X0hUPjDMZhCtK6t4XYCK6BQv8opw6gd28XFu1zEE/6T958ZYf9+w/RA7MV/d1FIacxKiU/Zmdz/fh3z/VwpkUpwZlhSA0z6LOid50pnK+QvbgYpQw40Iwqokurxoh869GYA/OMmZo6QiCtWJso5i0kIPgn3lXfJVmcS1mzQ66hQxe9Kxr3QzeVQqPHNlBitYaCVgRHM8mtdbqSBkYKZSwSpATxxpWO+uSue/QNbJOSgiE7PYgy8PMYhegjrhs1p5Yc6dBAjzxMyPnbvaBhdkA9rZnJRV4VG/JY/HV1zy2m0uoGNz/LYBWihCa7q1iOPS4ASlavff9Qre05
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 07:55:39.7851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 308de5ac-7512-441f-4fac-08de9156660e
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3296
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
Changes for v4:
- No change

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

