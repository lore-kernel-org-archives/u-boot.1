Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C69EF9D0CA
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 13:16:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4EC78423E;
	Tue, 14 Apr 2026 15:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="TgrhYqkx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1A6C8421E; Tue, 14 Apr 2026 15:16:27 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6BBB84206
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 15:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yan.wang@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tchaf+IcdI3I1OsiitaCc8UX+jpMvTbxpbNbLizpN8Dut4ah5iaBEZEtwBErdNrQ/RRo/jD7aJIGPKtBc/exwpeOiR4qvkJxLQnrQRu/LJTU93VL8F4yJjLvFG7oE2uFDhcquKou+jrjHygD+hI9cV/fDO2jOPMQBzfeuLgj0VCnJGoBMCYDfcgVPSWy5yhz4eIZXo0wmX4mbNvPtUKXs7Y7VgsdA7PESXiHwWGe3le7feaiyEJfB90H/pk04gQYklNFj4X4tV6kOLOHBVmULNk0xwH/z+mhWmGe+JZLXhqecm/JEhNBCMyHayaaVPSugvmy/DXV89JRHxSXwEqCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYl4RAHaOA5rAhND/Wffz9SfSa8U9abvtgRogrANwTk=;
 b=Sh5JTMQkxDOa2YZK6IgslpgsrSTbRQ4svSNGeb6J/x5EXsLdZ0VRF/ve84HysKEJFyed9b0eDHT2cxIMm5K7mA/nP+6vzIHnISZkGhUaT22cer2Z0bnULjLhyz5/Vur86XaMcKJLL72p4mRB+tCv4V6UjgDDA717GF9DqnmBmT1Retq2GaBQYtGhkgTvxelbACmJn3/vSxYcJT9Se/MOm07Lmm6s0eyyHzQpDjMxUxhdnJimheI7FYOgIddMgA1FC6/Oci/HP/e2Tpb3MSk2+txN3m6EpFLBRI7EKCesHS4mHm+Mo9GNs1MsG6+st/IxpdxkNUMVGocF7ae8/B0CWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYl4RAHaOA5rAhND/Wffz9SfSa8U9abvtgRogrANwTk=;
 b=TgrhYqkxbgXu+fSz047JRgn098v58oeYSlp2tqMdmCjq3ERe0G6UXB7uGlQSnuWWkIeIWnyO/7AgGo8jGyfW61z6xH0v8xvtP5xN4RxOpHLvnAO+K/e4+YGuZE7aQQOEDJ+1knIj8hyMusee8CVesPVwp1baQE8w7eI0EORbU7fKjnBHRZRfx0HnPsnW20G8c0NGSuGQt+NehfAkJ6dbu65F1sZGKNjR7JmI1X0/EtObfRD345MaG7Dxa37Ya0fAlUSX+OlSEEy9y/5x2cewuaGBIaEw4H/I/YD5cgFswA+kxCsxz/jk3yWcqR+QkH3LL1mQL1hGmpW9g8ubt0Z8xg==
Received: from PA7P264CA0160.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36c::8)
 by MRYP264MB7000.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 13:16:22 +0000
Received: from PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36c:cafe::ce) by PA7P264CA0160.outlook.office365.com
 (2603:10a6:102:36c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 13:16:22 +0000
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
 via Frontend Transport; Tue, 14 Apr 2026 13:16:22 +0000
Received: from sah1lpt719.softathome.com (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id 4350220737;
 Tue, 14 Apr 2026 15:16:22 +0200 (CEST)
From: Yan WANG <yan.wang@softathome.com>
To: trini@konsulko.com,
	sjg@chromium.org,
	alpernebiyasak@gmail.com
Cc: paul.henrys_ext@softathome.com,
	u-boot@lists.denx.de
Subject: [PATCH v6 1/3] binman: Generate preload header and sign data only once
Date: Tue, 14 Apr 2026 15:15:56 +0200
Message-Id: <20260414131558.538656-2-yan.wang@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260414131558.538656-1-yan.wang@softathome.com>
References: <20260408150201.217942-3-paul.henrys_ext@softathome.com>
 <20260414131558.538656-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FA:EE_|MRYP264MB7000:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cccdf9ad-c90b-4d95-e67e-08de9a280628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3IspqO8cArxvev/4WqqI+yCgJM3QZA+tt2M0IIOTqjSJJI8vNl2cPaO7qxjLYjTBQoxkMN5ztH/kwIhj14NBETzDcfGivf+m+cD5zOxeRCb64fAItpLzR9n1+BIPd255X/uNDpvOFs6CQspRyB4fAybH/cGsgPihDB/JcAqmL2JeUr+yj6ndmCd79CY4tXAD8WWb2RGeJhMqn9HY10UeXFNUX0Fl4WJ5X5QI56bDC6SuofDlYtMMSjvHhY0IccSb9l2eN4CpEn718dvkJ7BYm2zAQBLIpaOeHpExCn5ZPAFFbFHGDzgcp+dip8tMGDNiWd9GmhpbsPnHLHDREvTg6VV894t/zxqqrUumIYOi6QtNiz7DdEo0MmaaPyYXNL/Jk3OJYc4Y6EPnVxQctkFX3dP15Glq+28kNdLQxn3rFFCQzxZWWBRefVT2nSN5JOF1udbEvVWL5FBFSBBHACa9eacIrXlj3kacJUDSQqig3pFBPhgiglQeHHrlqinom4Q6+l0r1J9vLZQChoQ4IbIzAIx4SLdn0LlKSOS17/Mp4SjaSs+YsPDZUPF7XUKEBpJ59iBCpq9WWtUNx3yBUQGHoJfglVms24YX+oucx+xUQtgNioWBeQZ+okWINiB/SAvftRXdGKeP4De7bgJvcyoOD7mtaTTanoPWLyVVu4p5Fq/DmjOW0Hums5PYcj4CpHweXIotNkmw8NNy6biZmOG6CVCh1lkhKKwgJeis0SQTs0OF/aZo650UIVTR4C3Ls95z1UcLNMHmOUdVxYCUcF47GA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d4nJC02EAQj0TpEJswqhHAga0dCITvpCptZaaE3F1h9rpWEB02jOA0EPzLB0m789Qr2a2cBGuC+ai2+b7l9lOxjV/t5ATA1TKgU7PANcJjOFRefYgvHilcoJGEF6eTNXLe8/gx5uQm4McTImBtAqxQwAEASUCNrb8tY9F/Q7NNvjodp/uUKrx8iVzjgBqtePASeCdZrT4AtBkg9tBwQP4h7RXGYw3REHPoQBSpdw3Cf/UdcmM8WaKRbMrTk8iP4VsmOGGB0h+k1sLqQbifA093BkPLtkIpQQjUW4bLrOHjiT4FfwyJor8IdgyrXU0sr9lqLY0QBX8P3WxMwHwIg7bkeYDS8NEuZ/PsANa1Gy0yRHr8ILcxf55mF9seJViR7mfPgYj4YSldLZavhgxAg4E1YKDGZET3+oNu2F8VY1K/Mk1yFe/gDwnevjaAcZwkVS
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 13:16:22.5107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cccdf9ad-c90b-4d95-e67e-08de9a280628
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRYP264MB7000
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

Changes in v6:
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

