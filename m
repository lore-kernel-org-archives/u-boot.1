Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73E410F994B
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 15:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0839084132;
	Wed,  8 Apr 2026 17:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="Ar+AFdWO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB83184105; Wed,  8 Apr 2026 17:02:20 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E02E3838BB
 for <u-boot+nodisclaimer@lists.denx.de>; Wed,  8 Apr 2026 17:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+me/9/t3j+NJtkCLACcG8XHwYJxtxFT2EQujOBAMc4LinTx57V8pptNAhnG7j0wUoYA0kIPpvCmHiktU8ox5/paFa4uqSh3XlYHlI9GlNp3j0bFdJBBakVWdvZYQLoXXVV3EtGwJhe3C7mqTHb0Bx0mRaUHBqdW39Rq5a+hj2BOn1DgCLwYlMFc15HMaQFJ3p4K3Bz0jCi52ihdu/e0N8K9fs2yoLUlpVq2k5xL+BwuHW6u4ekaYXAhTqr/hAqSiVr6+ep0odyFeef/5r1xHj15z/SCPN9DFBWYUe+adUi90oHn9RbUDeJKzGbkdbG9PmboVUVOr4RUnjopPXz+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQ2Vr/KirKE3RyizwcPezfEYEjd4igtwnXkDmcahszA=;
 b=I2tSis1ytuuwNpq64Vz0QbQWd1P0FL47mnlkX8CGS68p0GpjjcvJT37Fsi+0Nq687PKPjkWmBDvuC/awA8KDon+Q4IrFpHN6h4eoVRHzxluWnGrsa3g/Wz1VR5zJZNmFtLlepL6nMe+GI0v9H8TWFeJZ+rtJd7Ugc9hsvhxM9YDqC+jDgc2ZmhBcM6BvyTy044ouQqI7GYjZ0wQWOf0lp1XnKp8iiatf5YyDKvtdnWjKQO/YVj6DoecsbElEac8THURvVUk68aBMnQTkg/jFFBTuKCLlgl5BxGzj8Rvz2oadwDVEKQZPmiBH91ato4ACnynRisu78PzVxdh6luSGuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQ2Vr/KirKE3RyizwcPezfEYEjd4igtwnXkDmcahszA=;
 b=Ar+AFdWOzwpktkm4OittznKzEimh4nUAPutXTSFSR7wyP72cDeK2VkHa5TNvhiSAre9hunSxzSXCh+cuxbLxTa5BnxQkEn+i/aguj9hDDgoxFsG28lR4WFoQ+dU0ftggvyIQMnkBkvnAEc1mim6LCdX0NKuizEVU+73Jg4vO6COvT4bNKviqHBjF0ANAEl7YoedcKB33piNrRTDcgLuyvqpOt3NjgAfKENLhSCeAIBiGAAEcswM8n89/tfkRdgfJjsxKotvfmgLEekIjk8rj3QnXWo++B6vnagmwrPdI/mpG+AoAUJvvEISIa/EQC5FdpFlo9lp5wcQ0Y8IlwQcckQ==
Received: from MR1P264CA0203.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:57::18)
 by MRZP264MB3132.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Wed, 8 Apr
 2026 15:02:14 +0000
Received: from MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57:cafe::1c) by MR1P264CA0203.outlook.office365.com
 (2603:10a6:501:57::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Wed,
 8 Apr 2026 15:02:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D59.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Wed, 8 Apr 2026 15:02:13 +0000
Received: from sah2lpt245.. (unknown [192.168.72.183])
 by proxy.softathome.com (Postfix) with ESMTPSA id 1A4322018F;
 Wed,  8 Apr 2026 17:02:09 +0200 (CEST)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot+nodisclaimer@lists.denx.de
Cc: sjg+nodisclaimer@chromium.org, trini+nodisclaimer@konsulko.com,
 alpernebiyasak+nodisclaimer@gmail.com,
 philippe.reynes+nodisclaimer@softathome.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v5 1/3] binman: Generate preload header and sign data only once
Date: Wed,  8 Apr 2026 17:01:59 +0200
Message-ID: <20260408150201.217942-2-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408150201.217942-1-paul.henrys_ext@softathome.com>
References: <20260403075528.1150196-3-paul.henrys_ext@softathome.com>
 <20260408150201.217942-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D59:EE_|MRZP264MB3132:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8534f785-7ddc-41d9-db16-08de957fd167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: eJCfKfRVgvW6ivRGjPO3I+3zKNslDfMAINvZ2+ZscPi6jHMzC50c7l5vrrAb1gKhSdF79kh7AP8etqD2FsEMNNhxA0WilnQYLIUwZyMG4q9I9dcSD1mzAx/jbUMsSp3rXAq6/Tyar1PDCY07Y/ovyIkTEJtMaectjZvPkrrUxepW9+v34erCVJhDO37GJV5YHdADFlT4gmVKUPZW8xQjaH69HZ6w6NEtolh0t2xLiK8zrhJqi9jvvTfKiiYpM/Z/98XdmlyPrJTQ5ze0eNU9cZEVNL+2yHphh2raG/wUEXHRu89nFF3KNLnCKW4nwm+HRLsMA7kTmEGodasLg9QBR/gm326GYDmDf/FoFkn+Dg0OeGLdM1ifxB65pBAxQsOk+NYzSjZYCCNZastIxqQjWr6qhmzpVxIgx0nSvZL7Qb9D+GBIopgWgAlkU9vTH+UP0KEZ8u4ddgrLr9XUJi32CqQRMRxeWwNc0/SwCvuj0AYqWoTN6UPCFblqqyKWOP1rMiy2OzEVlMdbISdW/dTW/l29it3dsH3Ffq+EgSyMGRDQDP+WKvPe1vaZP8VH5E5+u6hCNUdtWQPyLKSmm/lkUc+C6u8J9e3NFVy6tiDunWmA8fzHukrx3Xdg2DOJap+/JDVn+4ar6haxTMdjPQugX4Tpe3ZfEuOqNinTuUXXi440kKZUnXDUfo8wt+4+2gQ1f/PV7mN5GYTF93WCYSc4pA+gFcRKLI1aB7mIQ9uLheF/YSkLa3qEF2Bjv+ihxjkjtejXfBbVaBpgFuLIAgZ+Zw==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VFQ2jJBq8RuZBRY4YS+5kTfe9UjvskH+06wIzzfcx+1QARuEkR+T0akp4zo8vP9L/+h/aCpNXlAt50m1A5qixp2YUGHsLh6byjozDcxg4KhscIv2Vvgionuzdb5SDrSj6BCG/r5tOlaZnzTkm2Ydacc31PgDUzr+UIBrqBW/QPtaI+mYZYA3zTYRrHvLCVp8aI9SAMdAAh0ePpvj67Kfo3QiHlZgwlM8O7soVf5r3wE8i7y15f7NXTIDDc0FHzEMck2Gkz5P/ySfT03fKST85qNFyksYfRAdOcm+pCoOsKQYoaYopFm7TN6Gcz34v/NNApU7Cg+n6utjCIj3ROrefohhonaPRMTsXVcE8Y6hmb/+fe3zteDzYN+9eR56b5tNFA19VcuSYzSlqFVLMPuj7B1FzTUIU3aUgn+s6DuYc49TDJ3KR21Dii+c8uJKw/IQ
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 15:02:13.7018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8534f785-7ddc-41d9-db16-08de957fd167
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3132
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

To optimize preload generation, generate the header and signatures only
after all data has been collected in ProcessContentsUpdate(). This
avoids signing the data multiple times.

Since header_size is known upfront (from __init__), create a placeholder
in `ObtainContents()` to avoid an extra packing pass when
ProcessContentsUpdate() detects a size change.

This reduces unnecessary repacking and signing operations.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---

Changes in v5:
- Generate a placeholder in ObtainContents() to avoid unnecessary repack

 tools/binman/etype/pre_load.py | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index 00f1a896767..0d953cb258e 100644
--- a/tools/binman/etype/pre_load.py
+++ b/tools/binman/etype/pre_load.py
@@ -152,14 +152,11 @@ class Entry_pre_load(Entry_collection):
         return data + pad
 
     def ObtainContents(self):
-        """Obtain a placeholder for the header contents"""
-        # wait that the image is available
-        self.image = self.GetContents(False)
-        if self.image is None:
-            return False
-        self.SetContents(self._CreateHeader())
+        """Create a placeholder for the header"""
+        self.SetContents(tools.get_bytes(0, self.header_size))
         return True
 
     def ProcessContents(self):
+        self.image = self.GetContents(True)
         data = self._CreateHeader()
         return self.ProcessContentsUpdate(data)
-- 
2.43.0

