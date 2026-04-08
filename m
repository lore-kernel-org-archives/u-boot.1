Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38A410F9949
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 15:02:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EAF784106;
	Wed,  8 Apr 2026 17:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="YajqVrTb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 095C084129; Wed,  8 Apr 2026 17:02:20 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D74AF84105
 for <u-boot+nodisclaimer@lists.denx.de>; Wed,  8 Apr 2026 17:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQDkRvv/7Muy/26f/gy3Atp4aeACI3lNUuJwKhI1v/sXaTozjtR/373LY6PmlpVQ3LMIJ9o0dTqGDMlkY4Drh/rS0BvP6YuTdn2M+iQjGvrrL556sViMvMF9UJjtjn5K8xLzw5MECWox66nQ1qsp/84OK3cgWKugPuOnfftV3nVxQTcmDcI2G9tKZZyIbAXQ9O1nzJmc0LdShCJLxb3t4j8SR/oOTgjvJGBNUosfLw2J2ZCbd/o5om88kJ6D2jPm9UmqQyQ2MOF0GpmdLeWPHr/S2T/pgEpCyg5uliFibs4+foabwj9g+D2NII4Z8cJ2HMnbxejn3TMO3zGWU6cajg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEKb7BnmKiIlIZciiAikxaSEwdhV4qMdcvyjUwBLEg8=;
 b=NIZ7+Gn91J0GEVFzKBg0uDgbreD+TwSafXpPRDkni99u579iY4bjWl7d0mZze+YANjre5g+4X0lSDL18zaIDF7lFT9Kp02WqYdNF5ZALKQRz+/29kAIg5wpHK1BsmsECfHjUm5nhcs3iZGm2/GPOaFkVcplJng9arLg+VlTQOzMlaayTxKS7jv/1dEKIHoImlqwujb9Dv+3LixiJqw3pf1Rsk5tSUpeUf/cIRtru2bDICYEtofVQuGE0iiURd21aVzDOEYZIIoqypSiW+yI3VRtxQNr6mluCn/3Qd97keLyfjuATqhVRn+f02Pbg2h+a81bMgLrIKkIJ3kGT8kWMVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEKb7BnmKiIlIZciiAikxaSEwdhV4qMdcvyjUwBLEg8=;
 b=YajqVrTbiwrd2cmfAzcnFWCaItrrQxM7NdzIX/cXQt3sFHMw3PTGtXsY64Sr8j8wC4rkpolc3X4QN0raZBl0NbTjQbCNcLCLahmshHjn7Ln3cGTuxsYAeae5/gBR+oMW7aapEi0wVR4cwBeeavjrUQ06UHhtAg/GErvN9cCrfiEbrc+V/MfjSiO/TaYdykWAvfpVOto8zlvTJLMXHkA0OWTAk842NmH9yJgPie8MBSt50EHrmgXBoglIQhetBXEIskwWToW1Kk4ali/Qav9c/iAoCI0irz8pDw5RDL3Lbgwj7AUgVs+g/E0GaIZSjbLQ1bTzxww0SsbAcJ6HDh4lzg==
Received: from PR3P189CA0083.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::28)
 by MRZP264MB1878.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 15:02:14 +0000
Received: from PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:b4:cafe::41) by PR3P189CA0083.outlook.office365.com
 (2603:10a6:102:b4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.35 via Frontend Transport; Wed,
 8 Apr 2026 15:02:14 +0000
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
 via Frontend Transport; Wed, 8 Apr 2026 15:02:13 +0000
Received: from sah2lpt245.. (unknown [192.168.72.183])
 by proxy.softathome.com (Postfix) with ESMTPSA id 84F29202C3;
 Wed,  8 Apr 2026 17:02:09 +0200 (CEST)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot+nodisclaimer@lists.denx.de
Cc: sjg+nodisclaimer@chromium.org, trini+nodisclaimer@konsulko.com,
 alpernebiyasak+nodisclaimer@gmail.com,
 philippe.reynes+nodisclaimer@softathome.com,
 yan wang <yan.wang@softathome.com>
Subject: [PATCH v5 2/3] binman: collection: Set build_done on referenced
 entries
Date: Wed,  8 Apr 2026 17:02:00 +0200
Message-ID: <20260408150201.217942-3-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408150201.217942-1-paul.henrys_ext@softathome.com>
References: <20260403075528.1150196-3-paul.henrys_ext@softathome.com>
 <20260408150201.217942-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FA:EE_|MRZP264MB1878:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 326be3c4-16bd-42e2-6732-08de957fd15b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OROM8XE+8OR2y5/tLvU+YDktSrxtr6L396jWOWliPMQxqUreHmRQRsBWUjBDdDg1X/AbY9WI0UEkX0P9Uzr3GFWHjbomYQfsBSm7/RQb68NkhLGIMpyhCajlMrlgwOXs8tmwl9d/iPE3UFMS+qrUD6aGg6UBYEs6FQGTOgjPHLk1TZ5TYwdNTKzJLRoysAGJQeANQCw7Lj4YVbyRmqe5ArA62mtUfIM+t16H83PHOAttDFZ2bfZg5Vet+YbK3Ki8+WCOHZ5tjLcALaM/yvYmDgDF48ojSDrJVK61tPRWdsZkFJxRxOJwLyN4tZLYg22WrTIzHsW+dlSaLs0/c2axNnysrgILIl5dpIxxQkVBbW6++msoQpwvaLjmkjO8RHWWfzXMxShwTW3EAqvHCBs2xJTnOcK2vsT2F9R0hXvkcv87hcCRt3N1FV5LzGmcUOQmxMlG1PwwJXBG7F+SkWe6ocnun4yC1kF9nqi+LEXkEi7VyTcWQR8ORITtZkloQjpeAthQij7i0Gk/GYXNx56nd8pEnXnmpVLMDJoHTsa0cNf0iWI6FBQXhVdIYwTfNjC6qtd9i1350CH5C9rEnvCDbYczuh0yNLcuPSvdfHPBfQM4zdvwmfsWiIv4Dw4xoW90GIsPua0Y7ceX4PvKsN2T03wE138QcMd0Df7EzjbzMZpXsEhct4RJNUOkRBgoFq6AoDT1VdYA9rK6NXp6bm8HIc3UuYDRz401NB4p0oSo/wSy44e61zHbkRRKbgTxxkCXAAoclQ4pnwENgXkifla18A==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SLaHUl/80zvJ7TDS19uy1ytIf4QRZlGWN9WXHfWoLtXlDykqEmlR9BX/3OflkJCjw19Uk41Sy+co7GlH4EjGnHaKfic4M6SUNrjEcXYW6/esf8Tu1GsZ67A4NITE7k2NXED0lE3mxOQn7WOAxSRQPYR6N50Y/BnPaGTT2KRhkZIqo2ccUZyB90TInD8R+Ll8w1qjfMQPQgWRMlKhTufP79L5bCZ72fIw0kwgom7/cYoCu/5LC0b9TosSxNAueNr04kOTnXd7Ard3lNQQ0aO3aRwsTZVdRdnBS6PRvKhXmbjMyfGnBZ0+ubH3MULsLyEr5cuhas3FwD1bPn7oF3snvkdSSCFSNjc7akiDRbHnwSGWey6A/AKJojOlbmKcQMmsDMV39PP/oom3Ag0GOhFd6RcnAJgppMP7a8Om2wMmPdAHI3yUrWr7DhTkFBXrMoEm
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 15:02:13.6460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 326be3c4-16bd-42e2-6732-08de957fd15b
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1878
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

Changes in v5:
- No changes

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

