Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA5ACD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 07:19:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2C1B84255;
	Wed, 13 May 2026 09:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="X+7TWtUH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 966978056B; Wed, 13 May 2026 09:19:22 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2975483EEF
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 09:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VR+5lczCBhLgJqk5Ip+Wkz4JFPZ/muX8XcStxKl4Lf02llhRvZCZvsMKq2mwDcJFlPlYUmVmxEiPMTw9MHQXfhZmCkhkqV/TQt2u8F1nCT4F/PNGhbZev+t1WVkciabGN8T6E5Hg4PgxThofe/CFVPSmceN9RkOTE6FhtG7INGEw/OchFJC4KCsnb+XJdMhUa1QrVFeT9xvjXYy7BER3mGK3+0oqaxeMfyPvf0DcuD8eo58AihFwuPNg2uPqWZaTIn2mmgHOPA7dMwLNkl5iqR5cf2d74nXa+y4vTiFTQLx+7xzVshnVFODnX5kDuMU7+V839zQDhbSn/6fthMjqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hC1mSJ+PkW0p3FPWROPLZpr6TVc7iBOHWt/w81lC0vI=;
 b=SoGfWejTUOsgOueyDzxbCcUwlmXHTc8VG+jQ0Zg1p45I2/a8nsKES40SyOKBSv1FuEL2faFi2RgkkSnWBF49koLemuBP7mO9YSkkNemxl3PINQCmpat8I9O40BjX3NxrABTRAY1ZDyeEUfodkl7z77gyagwIV4b5q9iKg54Z09eVT0DL0lj2bUx1Q3NwSntQGOTJauPOCJzZ+Ps1nA9aObbjVq7KbOC4YuLLywBfOwE2hqaEb5WUlakY6f4nZKprTxkYEdxLUkNrfY2SdNwwvIR+aMsrvLevh11uckTkvGa6m/AgX1wKkoTUst9J7oyAzB7A7A/qXYqQtdyfsrVWrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hC1mSJ+PkW0p3FPWROPLZpr6TVc7iBOHWt/w81lC0vI=;
 b=X+7TWtUHZu6sF2dtacONzM3d2lBVyjLP8vSkD6oETu/rUTAKJGduSbeGHfYBj9GSBjsXNtP6ksyFE4ksYppJq3UpvsEiAeeM9jY+i40JB+ngLehrBsxwm9Sa6TWRYHNUUjB6TbLu+RKbP8AFL2MnM6iD5HTJ9iBX4cZIEV/LPmx4aEfoqHCLK1gJGGCyLbeFDxZpgTqSdUKyzO4W58iGTZayBnlEmOza78Dz64McTFXr7CVNO4Qf/2hayvwm6+rgudIlya9UJ3SapCtBDjooYCzdEZxNglpPDJnNbcudmVd880dzgkwnYfrYIP+jXnsAh/BsMUl7RdQhYBVwwNt6sw==
Received: from AS4P189CA0064.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::24)
 by DBAP195MB1097.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 07:19:15 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:659:cafe::2c) by AS4P189CA0064.outlook.office365.com
 (2603:10a6:20b:659::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 07:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 07:19:15 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 09:19:13 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <d.haller@phytec.de>, <peng.fan@nxp.com>,
 <jh80.chung@samsung.com>, <m.schwan@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 3/7] board: phytec: phycore_am68x: Update rm-cfg
Date: Wed, 13 May 2026 09:19:01 +0200
Message-ID: <20260513071905.83522-4-w.egorov@phytec.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513071905.83522-1-w.egorov@phytec.de>
References: <20260513071905.83522-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|DBAP195MB1097:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a742d5-33f1-45b0-f086-08deb0bff094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|13003099007|56012099003|11063799003|18002099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info: iio9H0FA+S21SUC5ry2x2gelYC3zicC5FB03f753X5J/847JPzgH8+ZpDKoKq3/LEbCv1jJXbQGk+W9ZN6AyjzbSJpy+EKJpZOFXbIn/0qp2D0RP+muPcDJFdntSynRV2gQN8E8HOn2QL0YnXRdmwRKvS07dCUlc6ctE27Z0S6j3uTnvqBXpu9zmeQgzYkJ8OwoPa9cx5L0vSEch31S7EgRZdESLYFAh/j+GbfMO04+3NgsCnNvhR1IM5ZXvuBUeRA/dY0zzUK2RjHloYyP0N8CnU871wHPlH/Q+ALX/3L1OnvtYkff8kfjotqQAqQD6jpCOC+o2zV0Y0n7mv15ZUAV3UhnvmQbjJFQFoySCX/SzlT04BzOjYvwkO5n7Af4NGefJHGOk8bzrExYtd6I0t4XI70RUk4RXrX6zWct/rFGtMLB2QhFodinx3ORXx+PTIWtgO4lSeSu+GHjID2x6YbXKNUTZ5TFb2M5Jst9clO0nXUtYYowGZ4XNSXSHrTXWLHHsIT32akA+LTSec/uHuKananj2n1mMn1kD6VQL7IKoK5CLfrLfJnT0eRmV6peIMYTxzJu2p8qDjPsU+shyon9SrF0UP0GJ3+rmSr/Mlx8XPpVoGD/yuG5ZxTeldbT8J610A+Z221bvDadCBogpqgHsY9m99IThYphA9+Wlfm7ptdYxw8kclAuVpp5EvldC
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(13003099007)(56012099003)(11063799003)(18002099003)(22082099003)(3023799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Bb887uCQFaLJMn5ijNtyHsjG4wC3N1wu7kn/XCCHUEJYEFNRAxMhrIKs4ZhlFa8/Ri9MevfVyts9xQQ/gATbnfeo64Pm0c4xQIgbWoiEOgkSOtg7FV6XmMPnR03B1aOHwadsU6A2RxqjrUaUvF7/lK37N0bwO45EC+JIjbu/pHTT/qLhxpkohtZVredw8YIIZ0cZjA5IW63UfeAJBeyWx9nXj9reEA9I89RwbUfq+k/C0iJrI519Mn8xQn9fC5WoYalvY6Ytm6ajidoI9RR75udBD3tKYJq4gHeN1itktR/1G9jMsOMnKPmYgDGRyykpx/0krK3559c/GZKBat9SLSbKjaUERTUpC6kmsEZ2jrN2tgaRNy5DOEkraTPbP/GmfaY4BZ0/P+zfQcwpFeN9tef+guz4m9Zu4dkdzkhUSTEszB8Z3xSsKnVSF5wUc0ns
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 07:19:15.4239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a742d5-33f1-45b0-f086-08deb0bff094
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB1097
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

Mirror the j721s2 changes from commit c4fcf9b806ae ("board: ti: j7*:
Update rm-cfg and tifs-rm-cfg") to repurpose allocated resources with
version V11.02.07 of k3-resource-partition.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am68x/rm-cfg.yaml | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/board/phytec/phycore_am68x/rm-cfg.yaml b/board/phytec/phycore_am68x/rm-cfg.yaml
index 8796463129d..728bfe241a4 100644
--- a/board/phytec/phycore_am68x/rm-cfg.yaml
+++ b/board/phytec/phycore_am68x/rm-cfg.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
-# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.ti.com/
 #
 # Resource management configuration for J721S2
 #
@@ -429,24 +429,24 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 10
-            num_resource: 100
+            num_resource: 98
             type: 14528
             host_id: 12
             reserved: 0
         -
-            start_resource: 110
+            start_resource: 108
             num_resource: 32
             type: 14528
             host_id: 13
             reserved: 0
         -
-            start_resource: 142
+            start_resource: 140
             num_resource: 21
             type: 14528
             host_id: 21
             reserved: 0
         -
-            start_resource: 163
+            start_resource: 161
             num_resource: 21
             type: 14528
             host_id: 23
@@ -1431,7 +1431,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 236
-            num_resource: 20
+            num_resource: 18
             type: 16970
             host_id: 128
             reserved: 0
@@ -1497,7 +1497,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 3426
-            num_resource: 1182
+            num_resource: 1180
             type: 16973
             host_id: 128
             reserved: 0
-- 
2.48.1

