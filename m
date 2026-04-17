Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1935F8DFE9
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 08:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 006BA8422D;
	Fri, 17 Apr 2026 10:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="uCPuPenV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81BF18425F; Fri, 17 Apr 2026 10:31:21 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D02938422D
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 10:31:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yan.wang@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8KBi7fzSVDGP1vWt9x7t1QqxHVqiat8OLV15b7QGcY49vBSnPB5pqGy8rxsEvqhO/LW30DUhMRHxhWFzjEg+nd0WOlnsXnPjm1ZZYMzWkBFk2ZpHznfWjseP5c/p0Og+tYR2YQlXN5lDvLHGJ42Q/6Yqf2WVoSbxfMNdcObnlYzY/KAfjSZgh6EOpMmfbcfSUpgdtmk08pzmKwFsLyAqMaLtDo/c5hGOxWw9fPNunLZ3ep9MHznA7WYlcbghGRp64kDDLEwgZb3mqAnApaY4CCOENUZnZR9OhCp6ofeb1BD652C3OCiW2Azc8uvKQJ+nttiOHFSqMId+epHrbZb6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewnfzE1vH2rbVZAgcn9LzvUxYs4oqoC/PjjS70o7wUA=;
 b=kabnpm1LsNOiQfGMweRng0f+xiODpVQYZxY2+hkfWNS+DgmXty2tveQL9Dq3LQnSUHKmSDXux5UIHf7S4A4k74cBmmem9tdHGPirgZ17EmC9YMp1j91CfKaKGTMmdwPWQyompIw7ervLrmND7zWry3Trw8aUpr38q2oEj3XS/JIFmYGgsbDUZQi6nLH76Ou3PTpP5BtFoJdyUk9J2JaHPkpL2AJvhZnmrEyfU6CqdcoVg4PcU83V003DthafshhY5J6xCamnbv+L+nTu7Zi/sN+ToP00FKdFgWarpGVBYkKm+5dGEiA6UxP9br6jnrhWhJOo4niTFriZfNA+UjxZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewnfzE1vH2rbVZAgcn9LzvUxYs4oqoC/PjjS70o7wUA=;
 b=uCPuPenVcRVGyt9j0r6tT0hRsUMdi+eCPMO07l58XAfAk8MMskJW4SZZcEUlqyk+yvIfRxP5VNvXoMzRYZ+QDGubjr1FmyGrN1SYrOOu/DjYQmaeLC+EvvzEZ0glDlHwj0DCcMQTE54DrOg90Ium+i2kvl5Hw7bgJfHBv1c4i4Ihrj9CnBhY2NejQI9qU/wpcqoPtEeswsg7sZXlGMfV0MYDx2owoagspJt09uYJnIwxBxR+2TAIJQz/KSRynUj48E5e/2teWhn29goabTXfPeYgByYZhMyh76uIi/UpJFWXNQdQo6bGVe9BKZCJsSz22/WWbAeNTDlS31UChK9mxA==
Received: from PR3P189CA0064.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::9) by
 MR0P264MB5180.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4c::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.25; Fri, 17 Apr 2026 08:31:15 +0000
Received: from PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:b4:cafe::5e) by PR3P189CA0064.outlook.office365.com
 (2603:10a6:102:b4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 08:31:14 +0000
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
 via Frontend Transport; Fri, 17 Apr 2026 08:31:14 +0000
Received: from sah1lpt719.softathome.com (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id B73C41FFF1;
 Fri, 17 Apr 2026 10:31:14 +0200 (CEST)
From: Yan WANG <yan.wang@softathome.com>
To: trini@konsulko.com,
	sjg@chromium.org,
	alpernebiyasak@gmail.com
Cc: paul.henrys_ext@softathome.com,
	u-boot@lists.denx.de
Subject: [PATCH v7 1/3] binman: Generate preload header and sign data only once
Date: Fri, 17 Apr 2026 10:30:48 +0200
Message-Id: <20260417083050.499955-2-yan.wang@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260417083050.499955-1-yan.wang@softathome.com>
References: <20260414131558.538656-3-yan.wang@softathome.com>
 <20260417083050.499955-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FA:EE_|MR0P264MB5180:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1caee079-565c-400a-6124-08de9c5bb06b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rEF4YW7iOpExCe1i4h/zZ3CY9hR/KbPaxgn12G2hfhgW6VOHkN4fMHbRMMNd2W+L6QukUbxXZNYd+A2ilQ383+Rxccn1EfPLounNRsG8aWWmDwF0Zpb+mE1g6UNiXSHTQDsX8fqYSpFn7SJ49k0J2xByj3cMRAH9i5gGki9x29Re+/moY65xM+IQUcyWeEkKKNx/BiFEDP2EbS4hlmLb62PX8s1mdwMykE/Qq2G5qHSpjo++PaRCn1hca+XU6P/F+DRWEtN25uhsz1fLHt36BN+y8W097qnhFGw2CHM6HJLg6pYB8VnD9LWsfvrXJlYinX8cZtr091FozR6L02aFyx0p16xTmkX0pIa5DrIPKn7d9nlxPjpASBJROSe2ujVqJBM14Hi+Z0mQT78+67SxBo4L5qfbxX1KYyQA8tHli5wBDPodcNg+jtv/e5HmgOIWU1ySroWO+FDbnXaw8sIidj2OXSOJqVmUW4HTY1ZnUtmWiflLncx5kmuwgC6jx/l0gj53eamK+CYEtryGxb6MAWBIU5+U2JNWexYmroWzi0o6/JjP/9QN24/+H4nSaCZpw0IEsZ6SzQXc5fXxlvNae42KigbjCmF3/7oqGrylY8+0gWDmHLfS7ktEzaOsayJDmy87PR92+RKD5QOQ8w3T1xMrM/m8bqrypl0pxsd8UcOqYIWBHVWpnzN5/UrrO6OEvSgiO5MVJp3dXCGaSdA1pMPGm46BkR4nqiklKrx7g37LZ1pRIS8i3C8hCcE/N3zEqDB2w1wPeeafBfrLOafsbw==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V/7xZqjE3zxq+3vuPpu6TNuP7zeKQyChtw4da5X4Qs0j/0MucnjAnUeLu4wod+F66FawukKRpyQLpQIGm6X6jitMy4gOYiGnY9x71EAYyOIkzyFjWgHpPF/zJgdttvrP1iQb6KJU4iku4iWfLDfqqMaEY5Om/v2r48jhsveuh+VA5ZXctOZQf1S4JnncuZc8KmC0HolzCB30hd4nsS7vvZ62PKNx9mNZbNLEYXZd9Mf01ccpPpzcOCEytN5p+oGLi0I2VHo0Ty8HTK4Eur3Grk8mQrLGI72mScSzl3m+TUVCkBpwtd56PJYRFmwj3/pvCz322oeZVUM9whYGLUYtFXcGKHoyDHvAgUgPNH9Zo5et3jPPj7/FQVFjy28zAYmpOQc3ydP3OFR8IvX4/F2tx14JECgTUESrv3/WI//6bviEqlTfHLLsaW9qil4qDInz
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 08:31:14.8507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1caee079-565c-400a-6124-08de9c5bb06b
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB5180
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
after all data has been collected in ProcessContentsUpdate(). This
avoids signing the data multiple times.

Since header_size is known upfront (from __init__), create a placeholder
in `ObtainContents()` to avoid an extra packing pass when
ProcessContentsUpdate() detects a size change.

This reduces unnecessary repacking and signing operations.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---

Changes in v7:
- No changes

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
2.25.1

