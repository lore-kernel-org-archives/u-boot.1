Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A6FD730AF
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 07:34:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19D4983DC9;
	Fri,  3 Apr 2026 09:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="XX3+/7L8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16131840F1; Fri,  3 Apr 2026 09:33:48 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 291648382A
 for <u-boot+nodisclaimer@lists.denx.de>; Fri,  3 Apr 2026 09:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hv5x9ir3tPf/EiW5MWgML/MT/WQ1t6pCZ4jQ5ToZlwMFnffHdkmssXVbdSRcT+LDSrV7pSeAnZnCzJXaKqR/aBBtEgh0lhH/BzB+MIsQ/GfD/vlmV+NY9EZbwX1ECdfVUWqusHygQUf4mT1Ba8H7mtdu652DxDGwNCZzjOEvVPGwNpn84oxtREVmFwLITmtrB5HIzD6sZTCLcaYp1jRYcSkB0P9GMJ6k7a3OaaDod0muER+Ga0vG9+EA8bFtaRT7eSau6XAOGCo5GT+4M1GwUri2KZSxNa/SxABv586oZzLPK3Wtf6KrRGOxbi5yOjFNWk9UqJlC1/dlsmw7JbwUag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XU7MX61vm2OOw8WWJoa7e2PbQ/b8EeakMPe3VZayGSA=;
 b=rV1cdLb+XOUfNaPIZOHariwCTqXBPZjEvC46FQs4PCUc63EvuGAfHYzEL/z23yevEVBeILeJuSIVYUJ64orNAGaP0bvsWrYvJ36NnFUhhoSqvL0EjpkPoCUJQWKTxgsZWAPBWKmkD3Pa2GqieO+C1YS+vRg0ZWfGCDmrtabNxwmPcXuHGZI4+kDCgKFcotoYS5wfhdx4as2/qpmVgg5qTNJ4QySyHug3Eqc1RJoBsY9FwYwhIAcXrURkbphKxsakJbKX78ie52hO+WLepcvNcwalPxyJVLib0fAk2VZUJT3/KACH1ZsCO6Nkm48prZalf7B/QT8YF0J+NGEUGJMc3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XU7MX61vm2OOw8WWJoa7e2PbQ/b8EeakMPe3VZayGSA=;
 b=XX3+/7L8QsZY/Q3Yww/Rywukrl2jvYGIhy0PPVGhgx5A8vDuO+n3JTgy7dtjgYNvLgCHTnlIhluI/lbTQduw4KGsIc5vnNYVNy7OHXTFWB4P+c/xQNUQvNQYbdf0Fy7EZJUJpeut6wWyBn/QhZGZTLny+vM5XPvUwDhejh5EvDDOQXOuZ6FNHEQA8lvU4u9LX9lwXcmXezz1+63J4RTuUph09rTjUApWfUx9EnIjFwcp/un8h0HAnn70OvFI2dig2tF61EU2/K1GbDtfa4CN4B0thh6gZDBBPM4w0RR6MXNnHvHAuROsMrcFmq0Ytd4ePLW89ww1Vx0hfe49w0bU8g==
Received: from PR1P264CA0146.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:346::11)
 by MR1PPFCEF4AF3E0.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::2d2)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Fri, 3 Apr
 2026 07:33:37 +0000
Received: from PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:346:cafe::35) by PR1P264CA0146.outlook.office365.com
 (2603:10a6:102:346::11) with Microsoft SMTP Server (version=TLS1_3,
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
 PA3PEPF000089B9.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 3 Apr 2026 07:33:36 +0000
Received: from sah2lpt245.. (unknown [192.168.72.220])
 by proxy.softathome.com (Postfix) with ESMTPSA id 80CA61FFF4;
 Fri,  3 Apr 2026 09:33:36 +0200 (CEST)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot+nodisclaimer@lists.denx.de
Cc: sjg+nodisclaimer@chromium.org, trini+nodisclaimer@konsulko.com,
 alpernebiyasak+nodisclaimer@gmail.com,
 philippe.reynes+nodisclaimer@softathome.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v3 2/3] binman: Generate preload header and sign data only once
Date: Fri,  3 Apr 2026 09:32:50 +0200
Message-ID: <20260403073251.1051533-2-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403073251.1051533-1-paul.henrys_ext@softathome.com>
References: <20260402192431.2421155-1-yan.wang@softathome.com>
 <20260403073251.1051533-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B9:EE_|MR1PPFCEF4AF3E0:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 08abcf58-1efe-4bed-0d50-08de9153518a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UYIZ7pImr9ZjyMABuLgCwehRBoBp2ajrgrMfxHrlVs1bcYvEfqnK46Ma4HXbEXxJmaw4VNZAtKqoGgVdm6P6zx+EhvQQqPOYaob+7T1qp2rQKvkZfgSTYBgvU1K3P5dLsoaT6Gw44f1hxjPNKJ/XDhg7SLcPjqp2myIsm9NND0Z/RNaTnY9TE4hdj2GD/tbkYf6+p6XhTsnqrd0JdtcmVTdmq/AyRX5LDHP/FMFRkvgEoREhrQchNaZdz0LOayw9jIpT9R7eT1AbQRtW4H/fzRlocXbdgwK4Zrvc8lwxoDafOZPmpIicNpiu+Vl26CsMKMwpZpGaK6+yhiLiiOhHi1lfIYtV4U0QEq0ejBs3EjWVRqWWge+Ag1pte3XVvcv89pDFoW/gHXe89SOxK1qOt4859fXFptezrl4rVB7SU4s9CjFZud8GjSs9qbnyoeEBsU44wyeRrn8lOUdjVTLFZ96lKSBC6FTxYBXSDlp0ZM8M0R8HrNd/tuk6+Qz9gnaT4iosfhMMXzm+m62MvDM5Xt28yhHNDS6R1ro2dcD4OmLxCibg0AVU4uJ0aBG2TPoSZGVkfMFH5t7PUIxHBCpxazYd4taxJ8IkLzyk4I5y9JfDwqMV0R33yLLm3ahEtn3LbCUXBunRB2GyzjbaRKLjmFWfFwVkTn/94y1L8eJ0EabAf5K6Z+2hPY/E5d1zmes3O5c7rMlyTMHuekcbS7hW4Q+MlVWPrI8c0bTEqVjmiJaJKXHmHxKbvljfL7IuXzoF+yV+cEWxiucC+RBbayabXQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0wAKxR4jfqPuu4uO3KMrnm34sOxzjy8j3whcHxKLuByigY/afjWpQlSOQ/pARMV2bKl+IDffcp+4ZOYFiS1z6Av2/6c49yb0DkpxwRiyod2Aqc2EtGapNpp7wsAO8yXNYx3xxzY6I+R0CIsdhLXbhi2jBAdcJOV8BRJjpwKksNqIwWrQzhPqQUcgY1NmGGQpQLZFkCqcs3GvGysWhgHvNKDhSS2Ltfq22eHPfSIPT8fGqwZ8+fUeh11dOdFfbMqjAfP7CFeWlXtH/6YlvMmH2eO6AqDzLMDFtvp7TMSLPscdI4UX2bYNWXAmsb0WuUo7ND36qTcm8+qOqqnMRTuytgq2b/wSun5BtIKZrKO3OO4rK1oSZdzdleTir/EK4CJgTW7gukNoGhlmqaH2SrAB8NYu6mFisqlFHtqwRIuFC2wr1J+DgQu2H6LxLZZ5XNi4
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 07:33:36.8934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08abcf58-1efe-4bed-0d50-08de9153518a
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPFCEF4AF3E0
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
after all data has been collected. This avoids signing the data multiple
times.

Since header_size is known upfront (from __init__), set the preload
header size in `ObtainContents()` to avoid an extra packing pass when
ProcessContentsUpdate() detects the size changed from 0 to header_size.

This reduces unnecessary repacking and signing operations.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
Changes for v3:
- Rebase against 'next' branch

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

