Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864B7D4979A
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 09:37:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF1D689628;
	Tue,  3 Dec 2024 10:37:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="uPxdy3/r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B02DC8962E; Tue,  3 Dec 2024 10:37:47 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2072d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::72d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BFA08963B
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 10:37:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Bas@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yi7WesajrC6q9J//P8A//gKQZA+p3EYruCXMGl+Czl62WwSgcUMS0O29O6VcGQjnS3hJrqvgU/Jqc0+e7FI1uWak274+dHHWG7gzUbEU7pUFCCNMiuFZXu57lQfSO9s5fM3DvQdeSxvA1L60LLNkbtJtj4WPTZIk9vc6oR6ZyL3/GAPBUCPo23rlx458I600h4+LgkShnNhv4TnrzgdxTf0CtKg8bNLemOmEu1hDZqPpqtYSmxxSHmuwT16ycEDFRTg3LJuZJODwPshR/laKL6S4e8iriq4gyebYgFKlQgvLEE+mhuC0XxGc0//zHrjAXZ9sxtjkssXd0bRI5zIpaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhjG1OM/Hnow+/0W3C7oEckcpj11E/rRT4VF/uKmfxw=;
 b=UZ9YGMtf+fs4VLTiEl+I5aYHuzq1JaMfbQjoaO1NTFroih71fo5vomKze1nsBPK+QwnmDBPqVJ8VkkZWVdlx/uU8wSaxkX94tFf/4Onpu7o5hH722DFeda5AtXc68Abo6Fk6rJYzC6ys5CxLKy4KOmlxwgs0V05ZzI0b3DVaI7cIIkJvRnXlG9QTquUd31cySnf26W6OD1QQACGDdN/6cKq9zg0UOMCAPsQedDCqM73mS/3/slYvRmh+tsI0g4qxHnwR1vOlRm7DdUw2IDlUE1PbTO/lEuySAZTeqRnDZDVZWduE97snyynli3Mzju4ofFjBO4+q4p5DL2BfC1MzaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhjG1OM/Hnow+/0W3C7oEckcpj11E/rRT4VF/uKmfxw=;
 b=uPxdy3/rzzJwW7gyRV77i4hhyUkft9qUgM/YjIx0lNVqWo/LKYdzuc0T5i3OqcH/xNWYJVB6Q0muYNecz+MchoSDNtfnNb0+MNcq1robTauW9ZsX00IGKjgNyMGef476TUhckW5AXD1XAizt7N8mjpMuDfU/sbbppjo2WmMNqIg=
Received: from DUZPR01CA0220.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::8) by DB8P195MB0645.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:158::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 09:37:43 +0000
Received: from DU2PEPF0001E9C4.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::54) by DUZPR01CA0220.outlook.office365.com
 (2603:10a6:10:4b4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 09:37:43 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF0001E9C4.mail.protection.outlook.com (10.167.8.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 09:37:42 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 3 Dec 2024
 10:37:41 +0100
Received: from Florix.phytec.de (172.25.0.13) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 3 Dec 2024
 10:37:41 +0100
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.13) with Microsoft SMTP Server id 15.1.2507.6 via Frontend
 Transport; Tue, 3 Dec 2024 10:37:41 +0100
Received: from augenblix2.phytec.de ([172.25.0.51])
 by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
 with ESMTP id 2024120310374044-265 ; Tue, 3 Dec 2024 10:37:40 +0100 
From: Yunus Bas <y.bas@phytec.de>
To: <u-boot@lists.denx.de>, <t.remmet@phytec.de>
CC: <Y.Moog@phytec.de>, <B.Hahn@phytec.de>
Subject: [PATCH v2 3/3] board: phytec: phycore_imx8mm: Add RAUC boot logic to
 environment
Date: Tue, 3 Dec 2024 10:37:40 +0100
Message-ID: <20241203093740.693628-3-y.bas@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241203093740.693628-1-y.bas@phytec.de>
References: <20241203093740.693628-1-y.bas@phytec.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August
 17, 2016) at 03.12.2024 10:37:40,
 Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 03.12.2024 10:37:40
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C4:EE_|DB8P195MB0645:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f17263-5494-4617-1d31-08dd137e22ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xs6Qa9Ihke+H7/sAiD7rj6C0ogJiJB+CPXBEK75mL5vVAOyOHZkVOQv/IYy8?=
 =?us-ascii?Q?b0TsSyV7t4kAfHQIgM6nPLDvz4ySJWwdzl85E4ra7WlvMMEGElkSBKNaeIvW?=
 =?us-ascii?Q?vTWbuwuT8QDJQiturHKuclaW1hR/z4v5/4gaPYWFpJ52ocx+eVPoc8AD9x0D?=
 =?us-ascii?Q?aErRV3B/d6fCk9X6VY+7el6VdQH9YKOXIuUQzgzruy6n3zv3tadv0USiIXw9?=
 =?us-ascii?Q?Hfhuru5P/OpRJS/IyBvsSCjby/FQXP93E/klg0aSNoJYoqqlwazedCWJ4KtR?=
 =?us-ascii?Q?+vel/T/J+S9DskurfjhB2HryVhltTKEt2UNv9BQYO2TEbbNpBzSjX+BP9zHh?=
 =?us-ascii?Q?9O4aQn06Lte7fI5h2/aV21BGkz4zFBm9d/60utsdycMlKwHlHpS2d45B+YIY?=
 =?us-ascii?Q?Ho2iIRacmF5DpoKY7K63L/R0dGpVWzVJvMJ6rMMwqYIhPd22gXVbsV3ONHWM?=
 =?us-ascii?Q?okH+aJySUlLnTxK6nNwCOAxbCgDQQtdnusUIe9YrsaQcyyhQF1sFWUfMmYmt?=
 =?us-ascii?Q?U46TnH1Fq30LpwyKbW+awWvoNAzaXGxt1UtFP4SZKUmt+D1afsqLYYcWrR1x?=
 =?us-ascii?Q?ZBCWsDZTdJrCRo4MqUzRg4zZuSTCjcNffbF3Mxzcz4w2F/lX26YC+QUW29HC?=
 =?us-ascii?Q?MGk5cSJEiEpMHUq7Ndcza6LvrLvgZ5gAIFdv+ZYNna5s+XTqktKtR4MG+iBW?=
 =?us-ascii?Q?RNCBqPhJeRkpYO31LaP6WrOyiceL30j695yh1PO8sKELGJrv/4vR1r2AMsJz?=
 =?us-ascii?Q?ULBGPs5cnnRkAffIPlOe2Bwe1hsjSyuIjj3PxzHGPAiBaC+bFJ7+NJHtyd1H?=
 =?us-ascii?Q?CvrlLZeljK9JvTeb7bfz1Wuus/SXHrhyqzAaTqOh5SiTR97wJqs3HWU7tIxd?=
 =?us-ascii?Q?qp2HeJJh+v9shPLyCzYNPsbkDZSsRfhiHBWJuvXeMpiCdaemLFC9UAxTooOn?=
 =?us-ascii?Q?vyZAVsDjDt86TAd7KIjvi89R/iDL1bs44WCgcE2cgVE+cCfWcEA8jgfIh65f?=
 =?us-ascii?Q?uAL+72fYcM9pvypOwUMaxgF3SjC4jV2JUmC1ZrLfsGrQhMx6QuqlLtns/Frf?=
 =?us-ascii?Q?mjxTa4BwRMiuob1ucGfDUxoQ0lJqGNGK0vU8263Cag1J2TOfjP9zDc192EBI?=
 =?us-ascii?Q?KdhAHpIvLnjlAr2WK8cXg+Q77sfA7wTExnHhJnKkB0rk0AY9KR0wMgIDGrTm?=
 =?us-ascii?Q?oUzx6uyfPhFTgENO65nNCrA3Y2UR2tlSXbXgPiWI3Vxtb7GsmC17iQ1Y+/7Q?=
 =?us-ascii?Q?iPGvG/9QyEd2BwL6ezQx4rBvAbglMdwasuh5eZucYLijLPHsvR/v7uFHuCqM?=
 =?us-ascii?Q?sSwj9DunsIxPQ4wEvAKEUqPNfOdHdJS/2Zmhtq+tBCCZBS5MlZU5/kY8Ifqp?=
 =?us-ascii?Q?8kwS63DvUiKfyl5emvfeLC06gvh/Pb+tQdwY/pyO4HJK4G+kFIHYUwxzJBdD?=
 =?us-ascii?Q?PFVkzQyl4mKwMqVmtL/V8QJofLPdX+wv?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 09:37:42.9805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f17263-5494-4617-1d31-08dd137e22ff
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0645
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

Add RAUC boot logic to the environment.

Signed-off-by: Yunus Bas <y.bas@phytec.de>
---
 board/phytec/phycore=5Fimx8mm/phycore=5Fimx8mm.env | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/board/phytec/phycore=5Fimx8mm/phycore=5Fimx8mm.env b/board/phy=
tec/phycore=5Fimx8mm/phycore=5Fimx8mm.env
index 44fa3731b8a..a7d14e774a0 100644
--- a/board/phytec/phycore=5Fimx8mm/phycore=5Fimx8mm.env
+++ b/board/phytec/phycore=5Fimx8mm/phycore=5Fimx8mm.env
@@ -1,6 +1,11 @@
+#include <env/phytec/rauc.env>
+
 bootcmd=3D
 	mmc dev ${mmcdev};
 	if mmc rescan; then
+		if test ${doraucboot} =3D 1; then
+			run raucinit;
+		fi;
 		if run loadimage; then
 			run mmcboot;
 		else
@@ -17,7 +22,7 @@ loadimage=3Dfatload mmc ${mmcdev}:${mmcpart} ${loadaddr} =
${image}
 loadfdt=3Dfatload mmc ${mmcdev}:${mmcpart} ${fdt=5Faddr=5Fr} ${fdtfile}
 mmcargs=3D
 	setenv bootargs console=3D${console}
-	root=3D/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw
+	root=3D/dev/mmcblk${mmcdev}p${mmcroot} ${raucargs} rootwait rw
 mmcautodetect=3Dyes
 mmcboot=3D
 	echo Booting from mmc ...;
--=20
2.25.1

