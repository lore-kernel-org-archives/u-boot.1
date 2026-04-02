Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87EFD6AAFF
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 19:25:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FFC68408D;
	Thu,  2 Apr 2026 21:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="lS2R8rU7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CD2583D8A; Thu,  2 Apr 2026 21:24:50 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24E6384020
 for <u-boot+nodisclaimer@lists.denx.de>; Thu,  2 Apr 2026 21:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yan.wang@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgCdyW5Q4ib/haaRLJo2l91lfvixDKXp1XuGcMSA7n/YNwpjHAyupnoCtu8HYIhPYzzVI9dQDNy+u8qaA2bKHoxbz9PKP2HC/7OFOFHYZs6HHNc5r6kbwIxH9L1p81+EFDg/36q3onrB/sEyVc+9Z+SVA9JnQfXpxakuxvtXlZF8bQ4F4tUNV1js8WLlYvDYYaJHIRozOZq3u5zj7v1mkZlZA81inaOX04Qrxp+XU/JheHe4wDMXJwL2wHJ6DV6I1rYRehcIswFJ5sJ4/JvLHrWdRAdKLS1I9HJ+W+3u2aTWuK51svyPas9IefhX7hFt+2qspc+umbTiaP9YqHuvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPxhknjoqBwlqf8uI/DNF3B3r6XYteHjlDFhDnAdX2Q=;
 b=uLHAUuB5OYRQzNf9RNMHdnz6vQYiO2i3KQ3lGtePzu/MJ0ipsjfuZA2S8hoUJ0jM/R4eZPO38m2rGTtySnvbHvW6qvuw7wIZM5MG+qP6b6c+kfxdS+K95ricAMzdBAsk/x004RVITM+XBDDg6gk0z8yGcHGZ0gtS3jcsCDzinGa2IK8HVISq/Q2sBuSOQ9Y90uAGDzVC93PUpxn6dV9P4qsTJbwNUUPuzzgTk9EqVlFdj8y5Nvf9Vj2Gc/Xe4//cSUrbgOwd0YScAVsuW3hr/kUMCcREHu6IXtp+vRivH6vOu2eYTAYg1AW8Fvcb0OioxcoYfzAmOjgfYamhD3C4uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPxhknjoqBwlqf8uI/DNF3B3r6XYteHjlDFhDnAdX2Q=;
 b=lS2R8rU7nBQ4+1wLHnEwkLHTfH0i2Q0IDcqINspcOrAXXHgkRLDe8Nuvt9g75zL9u8REYjg9UcWONQf3KvTJ6ckdXdouCFkol2qf5B9W7eSg72A+tDlih6WuIklhvxU0JP62gJ9BK/NQ2AZBrSL+7gqHU543V4kJGBTWTz0x5rulhtr51ah66Bvc3G8iy1TZdbHs/C+qp6rk75AXZ2TaJgkH24d7qrk9XgHYZNPgHHj/8FLGBnSWS1nGIzEj0m0uuMiEG+fHChe7j8vLhJXCHpuknQRc1l6b9S48Sxk3zT6G9kBJY3+Zkg760/0TrUXFDL9pBUo//L2I1yZkNvVvTg==
Received: from PAZP264CA0045.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fc::14)
 by PR0P264MB1627.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 19:24:45 +0000
Received: from PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fc:cafe::2b) by PAZP264CA0045.outlook.office365.com
 (2603:10a6:102:1fc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Thu,
 2 Apr 2026 19:24:45 +0000
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
 via Frontend Transport; Thu, 2 Apr 2026 19:24:45 +0000
Received: from sah1lpt719.softathome.com (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id 42AAE20043;
 Thu,  2 Apr 2026 21:24:45 +0200 (CEST)
From: yan wang <yan.wang@softathome.com>
To: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org,
 alpernebiyasak+nodisclaimer@gmail.com
Cc: philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 u-boot+nodisclaimer@lists.denx.de, yan wang <yan.wang@softathome.com>
Subject: [PATCH v2 3/3] binman: collection: Set build_done on referenced
 entries
Date: Thu,  2 Apr 2026 21:24:31 +0200
Message-Id: <20260402192431.2421155-3-yan.wang@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260402192431.2421155-1-yan.wang@softathome.com>
References: <20260402192431.2421155-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BB:EE_|PR0P264MB1627:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: de242f5d-0037-4fac-3114-08de90ed7f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: win0dKiKdy2iAs0C/AYZ0QPIUCmLuJAja9JX4rS9uKH6Dvr1Um4/1jad1gbkFWTjeFkO0e4JM4nK/eDZzbRXPA8Ey4rcNxkmOU2b/dwIpunHyHu+1r4kSX1hcaqpBsBP8nSFt0mcAGwnakwr3zn8TAJrOagJZeFq/z3WyT1JHdIVxg0qf8YJW1jiVARuTyaG3OkkWAKQrCcqr4PdjtZq8uhG5zOeJmKP3+LYGmEx9h1W/BT2cMghIQ7BfZzhqr/tulc6xeMDGoh1Lh4szz01sSk3n+li39TgLVJbCIuL7c81bx+P5ZLIRqSlwp0PY6pRieYJM5GUEjL7HL8VX85lWhuVJDX+gpipVh4u9cD9hexBQKaYo8xoQ1BiunVstcrq6XdYyIe181o1TLAC1wUur28csvgo225Molk1lA887NH4Uc7TKLvjXf5TwQbiU96lqP1BBXLwjZFHApDWcLEw+OKQ394m3R0vbgNDlb2O5mgEaJ99qzqppBRlo8YRSMoKKLRMEV9c/exCZlgI59Ak1voRXkxxd2QjBoMIn85KGzTeYF3+AjyS0IO8RYjXWVV1iSy58JcHRjumydAE4Dmd1caazTU90h1GrpXL+fYKG74SIVEuRj8ljbmqjp+0B9+qMwKAzmWInQEvZ0hFEzJkCSW23/eLpqm2l+yQUf0rU026Xs1FLbewuesBvwDAUHfSJQBmuV19OOx10cNzlO+ZpcJhcVJsAkOK4MCDD96OHUKo/H+VGAo8EJdkGNaz2mQhFweG3cawRb0zYOKVvedgmA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Oa6SORC8RGUP5WGmCMVYs4wfvIwZ97a4rtmzLeL7JTCG0z1zu8Ns51Pgi7sf6UUdh/iL+cXhpYTGApW4+DDwVu/QaGC6h7EsfSyXYKfTmq+xw10ECgZv1WkZR5Dn1pFcWJkrC9KfVSiPkovqRyawpTBPgB6oyv4BymCvrtuOSIaS3yK9rYouAbnGPsHW34iQdXqNqmSE1JXHSvUcm8NiyGBTMFTpfx0ydxIYobX3OidbSGv4JLpHc0+pYMRcxolvz9RM1zdorxHPcV0N6Ws7LbphaBI62Q9H0jC9j0FF6c0tiWzBkiJgIIraxoiotR3+q+HOLT0Uat0QEIjpTsInOkZqwIoglZBhRIn6aekVTvUZ094MVfboY2OvxtZOW/+Jwb+9skW1IiMiBObFFUQaHEFGKRXuKxb5GqX6iDwyKV2GtMghxCel6Sn1/ulu8CmQ
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 19:24:45.3815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de242f5d-0037-4fac-3114-08de90ed7f85
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1627
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

The collection etype uses phandles in the 'content' property to
reference other entries. Mark each referenced entry with build_done
to avoid rebuilding the same entry data multiple times.

This is important for cases where rebuilding may change the data
content, e.g. due to timestamps or random IVs in encryption.

Refactor GetContentsByPhandle() to return both the entry object and
its data.

Signed-off-by: yan wang <yan.wang@softathome.com>
---
Changes for v2:
- Refactor GetContentsByPhandle() to return both the entry object and
  its data

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

