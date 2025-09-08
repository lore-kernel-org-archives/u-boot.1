Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55EDCA1016
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 06:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC86C8303B;
	Mon,  8 Sep 2025 08:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="lERy0A/I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7753882C84; Mon,  8 Sep 2025 08:34:23 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::72f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EB1C82A9E
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 08:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pC9FqGvwyWWEtzZ6ol07U2SyfJdz9WOPUPUHTkIFSYTMd4oz6buouDBDs8DcLI/4BP5EkTcE8YrtdgLNq49i5PUzxsdgJK9CKGg+uuFQpLwM2hJr42bhRKgN2+O40gu7t+Ag6/T++DC/XieTWk3AZmTw1AvjO5DE4FmNB6Fxl1e651BlsG3U4bp1+STFsg5hoeuqF06FwUyQXiRVSZaFUrL8Kyth8O1RQ2Du1DoqEon4jNJjY5SDWVLd6AWRFQLYi8t7pzZCJOBm3MVZ1opILslVMoMhb5IpRhZB7zOOw3f2cThm1Su3t/QsX/IMF/HDbLsEmdT9KkyDBPyLxiGi6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wI9Mp3GOUHvQ2RZSDZO3EVNPXqamq4PUJXTBNUfQVQ=;
 b=W3bfKQK+HXpeWVa3ObWM0QxHSlk3xFdQpoEVSwEwU38qelZ7WwO0QIHyS5lqphshocrHsONumN1MdwMFJlKfxmKtrxRFMhRxJFYPUBCxAR+2PtBPnqj6RFhdVIgw8NTcIvu8W+RLmtHGvVXiWUTJlr4bPqjmGvFQ7ut/XRMhcDLfb5X7QzDI3KjTloMhS50cSxd8GSlq1D/XjJnrWjgjlkSIQk2wQzW2eWEucqjkF/tBZcFsurqbdz0Ytz1eUG1v8CEOFk0T+QSWGN/b3fKpzssuWzF4eULnRcJ44/+yZo0BXO2kl+9Tny0tgxd5CIp/g5BitggFmayarrgnyzfi0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gmail.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wI9Mp3GOUHvQ2RZSDZO3EVNPXqamq4PUJXTBNUfQVQ=;
 b=lERy0A/IHYPb5kkDmzDUSoSnp9hJ17rASTjE1T7YFflKUnZqF381VE24n5+idvDdDufK2XuCbnwsmsVf9XEHINJF6yHKob/dfa5PGJNOwF7ET9jLeQSQAxJlC8wkeO02FGTNh5vb2PjNlSNGVjKXoCRpFuu4FIZruY2z0Vq4IgkBzwINd1d7iu39EdAgS8tQ0R75dejMhwnS8D5HhkP2XK5JKI0pRHJwGo9bG0Z0ko495fPCUfhAJIoOQKoPkKJrADcHugf2QC++Vwg4DBWPy7aE+wzqHRnhKTQEVS2N/03SJOFYU2m2o0GHFuZHdIirJ7R2EXRHwcVtD+sOFp4Cpw==
Received: from DU2PR04CA0201.eurprd04.prod.outlook.com (2603:10a6:10:28d::26)
 by PA1PPFDD06E87E6.EURP195.PROD.OUTLOOK.COM (2603:10a6:108:1::1e6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 06:34:17 +0000
Received: from DB1PEPF000509F2.eurprd02.prod.outlook.com
 (2603:10a6:10:28d:cafe::ce) by DU2PR04CA0201.outlook.office365.com
 (2603:10a6:10:28d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 06:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509F2.mail.protection.outlook.com (10.167.242.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 06:34:16 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Mon, 8 Sep
 2025 08:34:16 +0200
Received: from llp-moog.phytec.de (172.25.32.60) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Mon, 8 Sep
 2025 08:34:16 +0200
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v3 0/3] PHYTEC imx8m boards: enable OP-TEE as default
Date: Mon, 8 Sep 2025 08:33:57 +0200
Message-ID: <20250908-imx8m-optee-enable-v3-0-14bfe249b3c6@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANV4vmgC/23Nyw6DIBCF4VdpWJeGixTsqu/RdCEy1EnqJWCIx
 vjuRbtx4fI/yXyzkAgBIZLHZSEBEkbsuxzyeiF1U3UfoOhyE8GEYloyiu1kWtoPIwCFrrJfoM4
 JYyVT/K6B5MMhgMdpR1/v3A3GsQ/z/iPxbf1zhsszLnHKqLXeC+lZoUE9h2Yeob45IBuXxJEoT
 gmRibowpdOlqoDpI7Gu6w9KMdN39wAAAA==
X-Change-ID: 20250730-imx8m-optee-enable-dd28b305167e
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, "Teresa
 Remmet" <t.remmet@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
 <j.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757313256; l=1886;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=KddcdnkHjtGAyqoj3o0yuRzgIhRIGSSaYDccc5VE8b4=;
 b=VGNFWiZiWKbR7RdilZ2inuvzJL87CU3QZ6yqVFIayTjl5dXM+4H7w+VMjY9kFtcEOBK8eFD5H
 UJi33zQkVnNCBUi8aT0PuN4IMMv8WcM/6e8fs1JKNI8xZMIlqZTd6wk
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.60]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F2:EE_|PA1PPFDD06E87E6:EE_
X-MS-Office365-Filtering-Correlation-Id: e9de482e-3d48-4acd-447e-08ddeea1bc15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1JyQVl6OXVla1hKZk00ZFYyUnVpQ0tGK2lYYmF0MW01QnpvcGEvVzhjVHll?=
 =?utf-8?B?ek1uTVdKUmpYVzJPR3F0enU1WmM2S2NmUU0wOHQ3dVpPcGVzSER4Q3MvelZy?=
 =?utf-8?B?S2h3UGxOdUJhZ1JDVTRwMS9vVDdVNTk3MVEvUm9XU2dZb2kyTG1mUStQTjZV?=
 =?utf-8?B?VkVtYlJGV1VyUTkxRytvREhSN08zbUlDUGJzTGhwMGw0bU5MYUJ4ZUQrbE90?=
 =?utf-8?B?SHRHSUVwcHI4S1BmQVZuUUYreEZpWEY3WVpSTVlDZkFIaXFJcnZVVHdZWkla?=
 =?utf-8?B?V1VvM3FQLy9NODVibS81TWlZQ3ZFMVVhMXZMZktVZWRrOGdIT1IxKzJlZjFC?=
 =?utf-8?B?MVA0TnJQUVlESzIxZGo1V0lFN2ZBUzg4enRzWUtEQ1FGanFJdEcyRmxPaG9i?=
 =?utf-8?B?K040YUxGYVphY0hhSHpBS0tXdnRCaTFDUnNBMzNOWG81RjFiL1MrWC9yUEJu?=
 =?utf-8?B?VkdLaUw2aHVxcndXaXFGZFBqcnFaYTAwTWVzQ1loTVRrSXd1S25kTUp1UklH?=
 =?utf-8?B?WGUxQWZSQzVmbkY4L0FKREI1YnJpcndNOUZIM3FBazRoeFplV04rUWlqa2Uy?=
 =?utf-8?B?SzlMRnQ1RDNCS2JxUTJmcXlWdjdwa1FpZXRxRm90SkxhR2NXNHY0VTFaTDlJ?=
 =?utf-8?B?ZEthSnFKbC9KZTFYY1lOd2pyZGZEZ21zWXNPaEtCWStKQTJvYnZGZmt6bVls?=
 =?utf-8?B?a2dXSjc1Z3dBVHJEUnlHaU5weU5SaU1ldDBSMUwyZGx0aG1kQ3EzZTc0ZWNq?=
 =?utf-8?B?UlFTU29oVzVzZnUvTTZvdlg4Q0ZxRVlrSEhYREM2QnJheG9vcUI4eDd1b2xz?=
 =?utf-8?B?QXNQSVZTS3h5RjJaS2gvZldUdEdLMXhQQXF5clhtTGZMc0RhOHNFL0NGbFdo?=
 =?utf-8?B?dHY1TytBYnVEcVVMciswUUZMZDYrMlZEK0YxcGNzK0NEelFNOTF3amtlaWZl?=
 =?utf-8?B?WmVhSzVKOXZpVjhvYnJ1MUdyek1KditYNG1zODBLSk5rUlQ3ZjhhcUR5VElp?=
 =?utf-8?B?Tis5WFU4VjZTRVFsVmNOZGd6REI5Zk5ta1ZLMTZBTmdNNFg0cTZadHowSWZ3?=
 =?utf-8?B?MnVQY1htVUFwRHlONE01eTdyK3RQeFRzVzB5N0tuTUx3M1MwUXloV2pUMG8r?=
 =?utf-8?B?amlZWHV4MTRtbXhyRnBrUHhxNWt2Z004bWt2Y0pCZWFxN0ZzWTNNOVZ0bGxY?=
 =?utf-8?B?YzF2VU9Fa29QT2JYZytCQWJFUW1XRDVvbVhva09FeFZaYTJoTEoxb0JieWRN?=
 =?utf-8?B?Mm5Hb01sOEdoU3BOdjZzRjcyMm04Tk5kMlZxUTN5NFRGZ0xRVnF6NEdPSEl5?=
 =?utf-8?B?Yjd5dkxTMVdRc2R6QnRUb2dHU2daT0xheEgrTnBmM3hzUDh6KzJiNnlNWFht?=
 =?utf-8?B?K0lJSTk1bkNlYnpyQUJ2NWVlWXJ5a0pZUk84emJHUHI4RS92RUd4VGVBU3o3?=
 =?utf-8?B?bGtYcklWaU1NSGY1ZnBSWlZBVTJUWkZEcFVEZGJrbk9uK3FaUHNCemxMcG9j?=
 =?utf-8?B?UXlSOVRBWnlDd0Q1T0VscVZ4U1VSMjJnazBEeWV4R0cwZlJZM1A3WE9UZnl4?=
 =?utf-8?B?UnR5MENvSDdjVDJlNnZVMkkvZWJzelV4T1R3dy83b0NCaDh5TmZMQWNBVFll?=
 =?utf-8?B?Y3VReHhycFJ3L1hhTDRqR01ZNXhlMzJ3WEVJS3hpNWZxbFJjSjlLSElSK0pw?=
 =?utf-8?B?SGp0L2lTYlhta1VCa0xZZlJTMXB3MDdUVXBLTEQra2kxYVNOYmJVRUpOSU9x?=
 =?utf-8?B?ZVNnYlJPTmtyNnBhWmJwZjNlWHRXNko2N2NZdEEzNjFSbG9FVVp2ai9HamZp?=
 =?utf-8?B?UHY4TElrTXNrR2FLWE9NQzJhZnU2ZXFaa1lvUFNxSnhhbXR4b1puT0FCMGRv?=
 =?utf-8?B?a3FtdFg3eWJCRTUwS24zdlZaK1JLbHkzUStkUkZiSDhhajZvaWJDMGowNHgz?=
 =?utf-8?B?MzcxSGI1RFNldEtubkRnVVdUQXFWR3NRU2Y3VFFvK0J3SmVnbUdsS1FwNGpo?=
 =?utf-8?B?akNaTjdaYSthZHhNQ0J0RUQwdVNxL09SaDF3U0FNSnJXUy9iODUyQ21LaTlJ?=
 =?utf-8?B?ajFzZlJzT2Z0UllvVkxaSEFCL0h4eWRucjdhUT09?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 06:34:16.8448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9de482e-3d48-4acd-447e-08ddeea1bc15
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PPFDD06E87E6
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

OPTEE config was unset by default and the doc for the boards was not
quite accurate as TEE configs must be enabled first in order to be able
to build with OP-TEE support.
This series enables the config by default, i.e. when wanting to build
without OP-TEE now, configs need to be modified.
Update and clean up the documentation:
Change instructions on how to build bootable image with the new OP-TEE
related changes.

---
Changes in v3:
- extract doc style changes into separate commit
- fix commit message -> phycore-imx8mm sets OP-TEE at end of 1GiB ram
- Link to v2: https://lore.kernel.org/r/20250814-imx8m-optee-enable-v2-0-c489d795ae07@phytec.de

Changes in v2:
- Use proper board PLATFORM for OP-TEE since boards have been merged to
  master on optee_os (https://github.com/OP-TEE/optee_os/pull/7487)
- add -j $(nproc) to make commands
- Link to v1: https://lore.kernel.org/r/20250813-imx8m-optee-enable-v1-0-bbff23f047e5@phytec.de

---
Yannic Moog (3):
      phytec-imx8m boards: enable OP-TEE for KASLR
      doc: phytec: update imx8m docs for optee builds
      doc: phytec: imx8m: Style and firmware update

 board/phytec/phycore_imx8mm/MAINTAINERS     |  1 -
 configs/imx8mm-phygate-tauri-l_defconfig    |  5 +++-
 configs/phycore-imx8mm_defconfig            |  5 +++-
 configs/phycore-imx8mp_defconfig            |  4 +++
 doc/board/phytec/imx8mm-optee-build.rsti    | 14 ---------
 doc/board/phytec/imx8mm-phygate-tauri-l.rst | 42 ++++++++++++++++++---------
 doc/board/phytec/phycore-imx8mm.rst         | 43 ++++++++++++++++++---------
 doc/board/phytec/phycore-imx8mp.rst         | 45 +++++++++++++++--------------
 8 files changed, 93 insertions(+), 66 deletions(-)
---
base-commit: b6e2cfca1a6fd10c8f12016a40d690d2ec61796c
change-id: 20250730-imx8m-optee-enable-dd28b305167e

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

