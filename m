Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824C6D4979A
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 09:42:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0273589647;
	Tue,  3 Dec 2024 10:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="AfCgf6iV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BFD889660; Tue,  3 Dec 2024 10:42:45 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20721.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::721])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 349AA895D0
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 10:42:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Bas@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0sOn6XJmUaPJB6YMVLrqEi0YIvgTdkuCkojCq3zlS7XoxyA/mZCtCmJrmBoc73I/fYVjOjlgZlKBati3PK7IcoFjwPs7fNtj5Qkxy2zdfKXH1L9IWyn7BKbBHQxtZXBm6ZkN4rPaMJ+HSEoyYDmDyaIFaFUQcagF8XUSPt1qpBtT7idsBChCWhmVYLckamEnu9tDu1NePtCoLBI1fbDH6HL79w0mJAoYbL8b9eziGTQIyGzOt/uw4oYH83jijKq75DR4RhLcmCIfKstIKVt+gkR36LqlSTR9vzJSz1tMITexmbtrjIKapwqpm3uapX63p8Vq9EgRrgt4VT64QTw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HcNkm7mS5ct4lORNvbGhVs4T1IVzjFmJYudKOtli9Q=;
 b=QUAv67zm76hde9b14M7vgFSREPszZcSnnVy8fXAIyRqXQo+8Dovh2edIopr3SGgSxCsXfiU2AKPJ+yrQ9tDjXE1VkVbS1aNaum8L3CA9N6cX02AfOw0XTrCJA2smz0dvcaHeXY2K1LOWG3lVMwQOruhJTzePAHpswOnvO0YGjTBHsXIaGTy74OC78EbJmU0va/IirShg1fcTsXHnXyBv2ZdijqAyigS+ZYrEmi3N9pgeYybfMXZHuBDvDZqQ9LXnBPy0iM89XW8paNCpx3Ys1r3Rjd2zqE2RqN3OC4PBx/Aa/PgvyoIm6kB4Rx20htjbZ93GLUwmW+BTG6H37yOoBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HcNkm7mS5ct4lORNvbGhVs4T1IVzjFmJYudKOtli9Q=;
 b=AfCgf6iVT4zlUyGFoGxKbwdUGo3QMgxwqfe5zkoxmSrYCIiVDa7pWKKuke2cM8kdgcjKwvIGlsCOdc4c/8Smve5LGeuj4F6Hi8goCE5z+pUQCCYA3emhjLGM+BnTe+8BFVxg4lhKYk81CMRGvChX8bLXRUSvUwjEmUv0bxfaOVw=
Received: from DUZPR01CA0191.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::20) by DB9P195MB1442.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:324::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 3 Dec
 2024 09:42:38 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:4b6:cafe::5c) by DUZPR01CA0191.outlook.office365.com
 (2603:10a6:10:4b6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 09:42:38 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 09:42:38 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 3 Dec 2024
 10:42:36 +0100
Received: from Florix.phytec.de (172.25.0.13) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 3 Dec 2024
 10:42:36 +0100
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.13) with Microsoft SMTP Server id 15.1.2507.6 via Frontend
 Transport; Tue, 3 Dec 2024 10:42:36 +0100
Received: from augenblix2.phytec.de ([172.25.0.51])
 by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
 with ESMTP id 2024120310423519-268 ; Tue, 3 Dec 2024 10:42:35 +0100 
From: Yunus Bas <y.bas@phytec.de>
To: <u-boot@lists.denx.de>, <t.remmet@phytec.de>
CC: <Y.Moog@phytec.de>, <B.Hahn@phytec.de>
Subject: [PATCH v3 3/3] board: phytec: phycore_imx8mm: Add RAUC boot logic to
 environment
Date: Tue, 3 Dec 2024 10:42:35 +0100
Message-ID: <20241203094235.693693-3-y.bas@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241203094235.693693-1-y.bas@phytec.de>
References: <20241203094235.693693-1-y.bas@phytec.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August
 17, 2016) at 03.12.2024 10:42:35,
 Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 03.12.2024 10:42:35
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009528:EE_|DB9P195MB1442:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ae354f9-79b3-4ae4-2f8c-08dd137ed2df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cUGMvKKrZS7fxVah/T8lq73CAWVudZDTaxeM5NF+dmo9BpUc4FNYuSOy9qSS?=
 =?us-ascii?Q?Sxkr7V9MpLQhyVhB2JVw1TZX7/xLrN0GxSDIV+G1351TuW53DpaTxtnYYm45?=
 =?us-ascii?Q?CjYnXiORr8SemtcZUAamyESd1F9VqP7HJ2T/sdxYgqBt/E3ISzU1j5BBhl1k?=
 =?us-ascii?Q?Nh5aeiBZqE0lhq8K89WV76zQlZvYmmrahRu4GV9/vDCi4hwSChUuYFtfjstX?=
 =?us-ascii?Q?0aujL3o3qnfoYDcQNi9vY4boV90bJZJN0c+7mYpQ6e/UxjSMWJeL6yT+A+Zq?=
 =?us-ascii?Q?pXxWP+5hjOPs1IBzmGEbx9zifwZEKUMVrhv9pDtj1VbxLbifPsjmxhkbHw4L?=
 =?us-ascii?Q?PUg4ldqi0kbXzZwknmwcwD4xsYH5xYkINHMU5z+OmJjgn/KFcnTKh8I0Os6E?=
 =?us-ascii?Q?NWkmNgk3ZQKmV94HUU+N6F33Ers33IeFNJQw3QqpyWHCUdap/WsvgmxeyzFE?=
 =?us-ascii?Q?9EgkWqnhIUVHvK6+Z6bLlIO1v48CfTooGDGgPgMEDJlzs+k7sZVl3KUgVmYC?=
 =?us-ascii?Q?iqupxkA31gqaIUl4O2ertwXX5pmTsX2U7P/w3g+3F++zzTQMzYlatjR1zpyI?=
 =?us-ascii?Q?2J0r+SsPisw8Mb603/hirc4uksuhBrgE74tXRtNTq6/jXUeJvkukzYwpsTCg?=
 =?us-ascii?Q?ngkQ86irkUBkDb2SQIxI+0neQdgg+zrmSVCcM7yJ0RgbeMvpET7a713st/vo?=
 =?us-ascii?Q?OPDNB5Pr4wcZQl7ur8OK/dMJpl0cJcBP/FBJA9xZMy3Rj1yD0RUrUdluZl5m?=
 =?us-ascii?Q?JezPPMXtUEecBWRt2EQwfWRIAwbrTjQeY1tiz7s/2ztQA3mwA+zBx/wEk9Bq?=
 =?us-ascii?Q?L0GHMwKGPB8esiIgZiltKGIiyiGEvuY3v2az7XZF3o3H1wwrB3s7U6cn3/Qi?=
 =?us-ascii?Q?dm/OusYjk7rIBUj1A8IGnGf4CtLx8pA7YiSVZakyDYiBiRwqPev0vYKiTmLd?=
 =?us-ascii?Q?AQyhRS7Y43VkIcR8AzSHwbrSA54BI4Q5fKzyhnQrAOgYAoGUQt+djn4ngemO?=
 =?us-ascii?Q?DVELwTdUdGGZpw2Cts4jTuqOLA0h+4K5LN5Bm02pbFvmCeDpdHIWnAHfFuJy?=
 =?us-ascii?Q?JqHIilrcIevRe2mHYrgJpTvEtle5GhwzwujVnyOdPfXmIaU2MGSCDT/s0wnS?=
 =?us-ascii?Q?1RT/16+9fIQiBIUGYFenpB2nmKZIqgt0OH8SJVyYkoZ4NSkjRUtfi3BW0adH?=
 =?us-ascii?Q?0iInpHLU0GJkWngFBc6gDD1Gl/qWknX+VZzytF1s6hKYTs1oWx9OXEhP/PGw?=
 =?us-ascii?Q?bLLK6sCp5j3/kF2VNy1CyNYNeu5RK36sCozjOlGX8JlnDCPbIitQkrPedkb+?=
 =?us-ascii?Q?3VrUyNr5EZaQeS2ZP+5uMRy3cqMvMu04uE5GC26/XG8sM+HhPx3Vut+xWkMM?=
 =?us-ascii?Q?pmZW3V7Gp7Q45WjXl4V8B7YNyDBWkC83UPd3ln2jcIGTJI0PqY2O7wp8Cstv?=
 =?us-ascii?Q?czu7fvXC/AOYTT+PO0j/O85GOnRxY2qR?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 09:42:38.0502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae354f9-79b3-4ae4-2f8c-08dd137ed2df
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1442
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
Changes in v3:
- Added Maintainers and reviewers
- Added Changes description
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

