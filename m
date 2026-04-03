Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9381D730B7
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 07:55:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4990183DC9;
	Fri,  3 Apr 2026 09:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="ga7kjDXg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F13583CF5; Fri,  3 Apr 2026 09:55:45 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 812A58407E
 for <u-boot+nodisclaimer@lists.denx.de>; Fri,  3 Apr 2026 09:55:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Am+zLpv7NeRT/rM4qyZDBkvt3O0pVs9r46WE9ngdA2g5P4xT4adzvdT81oxe/qHr7xFMXIiHBqc2sk4Z1RKSCIm86v24bDtsQB3L0s773uqsokiVIBozKcgaGAKQ3daocRQLzVWX9eBRcUALOgvXdsxouJTL+K1Up5pYBqf0MvwqxGOEwx2nf/VUGPED1hj1uUkUkOPqof+SeYdnisvJJHsLfhu9Vu3HS8S3BEtSD2j7Si6skNtmImMfc6Fg/Km9hG31BX5gwEL6uhA59wvVC9uo2d6qbeBxlrq+qXg97YHzLzsA2/MJlmu+uDdQeYJvoZiueNHjWzgFrBsnR6lHVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gm2e7s+7T0r/ZWT69ioPQlR+Nwq3/U8b/LtU4t+3lQ0=;
 b=TN/vofDXhKInju+y2F3cgIRuyaMBj+KZX8pUJlZQPyOE8rrav+XwbefYDc0KhsCXq4k2URKmWKSdpYLbLa4GvnB8aZ8y8mrGKTS5VCsFLPMqn/Z0+wbmQLxwKF3ZggfJQ6sNfrpGxg/S3zbq8wvPacjg9IIzPWznkXCE0QNEUaJ1mQA8G/XsspPM2jeSnp63E/d+NNjMRGvbTShoHJZGDe1JM9yQzZOooTod5Prq/35wb1AjqzFJQ5R0MVGt04R54gBe3U6xaJ+CEPv5jLoymboEHgx30lHv5fsdyGIXi4jHfHYeN9wST4IuuYYKap1B4X2C2onChxPrrT89jUHaGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm2e7s+7T0r/ZWT69ioPQlR+Nwq3/U8b/LtU4t+3lQ0=;
 b=ga7kjDXgw/iCK3ozlUF4h+OgzjiU9E8Gw/PBspEWCZpcrwHhg2Pk8oaZdB96aolzvnuOHKT4yBCZLiXIArPQYXSCYFdt9LOQfrg+CmP+7A+LzBlpJoq+JltfLuAjTxTIO5p9gPC0PXvnKjDTjtfwTINd81Sy5KGnZjSSN/43e59M3yqNPQxGtPfbYVsz6mt7yiFshSa32GIHBl9PoM6LLQq6c3Iw03J6o4J+GbDD7NkAjIGYyeNJqDROBT387w9FAeku1JvutHYAJ6I80628JQnXrg4x66KsX32W7iWh/bTUiwgYIq5biBxh5SMnl158edwfTCR4QXUIXsAj6q4efg==
Received: from PA7P264CA0194.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:376::12)
 by MR0P264MB5289.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 07:55:39 +0000
Received: from PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:376:cafe::fd) by PA7P264CA0194.outlook.office365.com
 (2603:10a6:102:376::12) with Microsoft SMTP Server (version=TLS1_3,
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
 PA2PEPF00019231.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 3 Apr 2026 07:55:39 +0000
Received: from sah2lpt245.. (unknown [192.168.72.220])
 by proxy.softathome.com (Postfix) with ESMTPSA id E165220934;
 Fri,  3 Apr 2026 09:55:38 +0200 (CEST)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot+nodisclaimer@lists.denx.de
Cc: sjg+nodisclaimer@chromium.org, trini+nodisclaimer@konsulko.com,
 alpernebiyasak+nodisclaimer@gmail.com,
 philippe.reynes+nodisclaimer@softathome.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v4 2/3] binman: Generate preload header and sign data only once
Date: Fri,  3 Apr 2026 09:55:27 +0200
Message-ID: <20260403075528.1150196-2-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403075528.1150196-1-paul.henrys_ext@softathome.com>
References: <20260403073251.1051533-1-paul.henrys_ext@softathome.com>
 <20260403075528.1150196-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019231:EE_|MR0P264MB5289:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4b8a074b-5253-4e17-dfc6-08de915665be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Se3odE8z+Bul1cfwgeNvneQ3x1J+M0n1O6J3w31bxTIIG3AmDB2Vc1MHt02v+IteVPdav62kZuBlH/erGVpl73Mmlvo5byi84IvS7tNunwgQHGe4mXC2JXAnAh+mnUNzhlAtaXzIQYDGGaFW8p1UMqSH9CVE422N+gNt0GLUP4HN0turvBglrF/9/vWWz88tfXRftvMS8SPlzlhgxK8IUdwExmU3pKhmSExYAa9DWSopKGCRgX9XPdyF9XW1plSlfsh8cewMQ2hGOmEwZDZ3vhqSwZCY4xgpba+qN10e9B29Ecr1i82ob3sTIWwWz3gM+R8kgmnPn6WDoXKqKTjlU1w52FqLqW0PwRupswY+aBNTxi5Xg+vGHTcGMqPXexJW3XSEwwlIIjqnR4GGqvk+k6YdRE2lsKzQfJ1+CTvcfh6LqRS0M9D36iXOmv1Mzs0oxYJyJquDGWkRJphfZwSRSa5eU9FuAry6Neyt7uBdZWxxs9GJpPTW58Q/Ac861VFfHEO2BPTWVnVrcUv3bajdrY6NByp5omOtttKC1ST+PUccNtCaVVXcYC5CsgyOXTk4SL/Oy2Su6DYfDXFYBZDRtdZW4M9d/ACa2SizBxMmErjrpiTBQDE//RmjeIa9pvq3deQboW/v0xYXyMS4Kj35tttxYKN0Op+tIlC2S16LlrP/6H7AB0Y+wfnbboQBp8AS3MBiRlx88KDjKhF8qJU6OZbX2jLFxwtm0DwzmYqP0SO7mY5Rx6SVJMbrDvwXqcgSAtXPUrhmlOdRuM/Xi1Bh9g==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1h6c2Y7S1kbzb5+hDaafgg0M6xM7UGRl3OUWzLT2Tjw7DYSOwqFE7o3vazv3ziH/+hct7AsTVCaObTKtuIwxO1D+ayxAMruaF3UFYWdT5sz9pj+UbCayZod97DomAHeEAWu8MJfDLV7IYAY5ae4XepKC4b8rYMILyX+cJpF76o8Y3uuAgNodt/BS1u9+qkwlf2l/kaJ25Gq1wQlFTMr/BRecvyxhljRZ/FpCAt5McAWUIbOmIsbxmQSkZM57Ii6pw+TdLs5RFcTqvtHnztdo6KlgNrQ3RTA0SuPTyKct9FSk210ZKUjqGU1vUqKqmT4nNBNyrYWEeu9aKwtm71O4gTG3nreZcs7h4S92I0SsrbgLd8vwP9SMKz0QM/DyIsATDN1e8K7mJbKVjUvCY2MUFv48diunefFnJZB2uNCrfW37N/OiZfbsbDgMjycl32XD
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 07:55:39.2941 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8a074b-5253-4e17-dfc6-08de915665be
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB5289
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
Changes for v4:
- No change

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

