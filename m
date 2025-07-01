Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F92C8302F
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 05:46:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C134781FEE;
	Tue,  1 Jul 2025 07:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ZSQeo6f+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E56C382ADA; Tue,  1 Jul 2025 07:46:04 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20704.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::704])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B2E18006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 07:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZbWSxw3vMVmOaWlPmE3pUpiRLqWFgdnxT1LY6omIMOLlq6pU4T30s+8r5U/NV2XtAtMxkCVBl9nDn7tThHb2abBGNPQ5kpykc1myVuvDOT68zWh4upfD+WhJkTlD9BlQ+bTpI4fjRoaLJpsXirsoDQrqdB0FMygUwDH1P1NweCLukIFkr/VB4yP++12stjWjUGtczNUwRilaOwQxE3R95uwXxDirW0MT5AT/BTilqs6MEy1txI96LMy5T/m3g0K7j2f3Yo07K/uVTLcQTctqK2YPJz1MlB4bghOjttV/oBMCqBYuHnE+KI4VqPZ+leyH/86zx8HLq0XfYzYMWVZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DN/MYXDkKPDZcTwLiRrCLkx2vIcV7PK+2Qlxsz2lvpI=;
 b=xpHOsgzeXfaWzrxx/z7RGyogRrGFTqiTsBMjnH+28jejFV7ZLnhWCaizf4IL32noeX+yj3Q9mKOZc8u/Njr3u8DaSYSSNAPVGfEBMaZWop/XPgQPJRos+iu+4UnPqvYGBy+Y30SkYgB8AjAvF4d5OIOS+VufIgLR07PrgsHF/ByUVyR5oPMXoudQ/BZJ65G0kwVHYNvTaBUkHN2SifPJisArw4C1hUwf5uBU5xTMtZ5LAVC2ux2AEMQ1EH7Cz7yNtwqF5ylo5nFr4ogPJYU/wB2lctbymeDoCUefY0MvFPErQDrbXZTKgZd3qZH76DgC5fTEcyhlG5lPvFAEo4Fqew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DN/MYXDkKPDZcTwLiRrCLkx2vIcV7PK+2Qlxsz2lvpI=;
 b=ZSQeo6f+hfHpwTS1S/chEZu7MbDXmiNjNuBXHDLm90DMxirvJi81n4gnB7z9UJrrcbeTwjl1xhxA5hnKIKz/DQ+h/b9Mrl5AJNSff2vqX1QSmYn/OHJI3z8g1+K008eByFM8Ze4Vw0fi2bqNA8wI85znBLdvBlkuw4VF8VbKSKMcEuyAYyVkU6tqxyE0EPo0qgF7qVWzlxqtKhyfMsKUXlTk+MZYjfe/TVEAwfIdZ3jONwwHex47wBPM7Lst7QDiwXyNcShW2RbOyiucn6G1fAthJd6EaqXqAdpTovESliGmDeqj91ocdWiB+TIKfgUGgn2y2LEg3tSqw0zQ1C921A==
Received: from AM0PR10CA0032.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::12)
 by DBAP195MB0937.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Tue, 1 Jul
 2025 05:45:51 +0000
Received: from AM3PEPF0000A791.eurprd04.prod.outlook.com
 (2603:10a6:20b:150:cafe::2a) by AM0PR10CA0032.outlook.office365.com
 (2603:10a6:20b:150::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.29 via Frontend Transport; Tue,
 1 Jul 2025 05:45:51 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF0000A791.mail.protection.outlook.com (10.167.16.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 05:45:51 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 1 Jul
 2025 07:45:50 +0200
Received: from llp-moog.phytec.de (172.25.32.39) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 1 Jul
 2025 07:45:50 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Tue, 1 Jul 2025 07:45:37 +0200
Subject: [PATCH v3] binman: migrate from pkg_resources to importlib
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250701-pkg_resoures-removal-v3-1-270188b335ae@phytec.de>
X-B4-Tracking: v=1; b=H4sIAAB2Y2gC/4XNwQ6CMAwG4FchPTvDCtvEk+9hjAFWYFEZ2XCRE
 N7dwYmL8dLkb/5+ncGTM+ThnMzgKBhvbB9Ddkig7sq+JWZ0zIApilTylA2P9u7I23cczNHLhvL
 JuGoKRI0kcw3xdHDUmM/GXm8xd8aP1k3bl8DX7R8wcMZZoUqURZ5LnYnL0E0j1UdNsIIBdwiqH
 whG5CQrVKqKRYF7ZFmWL/5nmsP9AAAA
X-Change-ID: 20250610-pkg_resoures-removal-17f922d2e64d
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: Jan Kiszka <jan.kiszka@siemens.com>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Bryan Brattlof <bb@ti.com>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751348750; l=3095;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=b70NaOZSAkW8mrBn8aEJdqSkBRD78/TveKy9balVNhc=;
 b=Oh1e2ln4wCHWOXXu1O6rPtBUIdz+q/2ntr/xs+IPecVRauBLrMFumYDxZ5TrHDGuXXQRcYzyS
 WwKEO2SRxmnB19hKajuR1PxATwPcFvJKOGd17rlz1b9lVIIR8us6NNy
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.39]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A791:EE_|DBAP195MB0937:EE_
X-MS-Office365-Filtering-Correlation-Id: a009e5b4-96ab-4d16-d00b-08ddb8628997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFZ2ZEhOcUJWWXF3djRYRnlxZlM5cXBtTjYzRTVKcGNsZ2h0MThVYjRDSFZl?=
 =?utf-8?B?TmJZTlhtbnkwS0QwWFd3bHBoT1prZnpkbVlsVitDUURxYmlEU2tlVW85aHR0?=
 =?utf-8?B?WG5iTE1MbTV4TnpqL3F5RzZtdDVPR3JiWHdmVC8ybTlzaUk4dHdKOXluZkd3?=
 =?utf-8?B?MzZybWdwV1pBTVA0bmhuTkVMMlh6aXIxa1VqMWZTc2V2WmRFUVRudFNFL1Fj?=
 =?utf-8?B?eGlnSjZZMHY5TVVZS1BwOU41TFg3a3ZjNnQ5TDJpZ2VjRE5SMTZsNnI4UElt?=
 =?utf-8?B?STB4SVBpY2VuSHZLeWhZOEdpZlZVOXFWSWNoR29sZk5YZXY2V0VUK3FTODBP?=
 =?utf-8?B?aU1DUng2QnlES0ZtWUVlczBWSmd0c2pQdHJybGRMYytWUkJYZUlDdDI4MGl1?=
 =?utf-8?B?SjJVbzJkN0dFRUhlcDJrVmJ6ZlFRVW5WSGdCbE02N2dlVHhHajBYNUEwTStM?=
 =?utf-8?B?VDFyelFaL0VjS09YajIyUTlzUGRsaGFKYUVVcmpxeEYrWTNwNGhleHJCS0RY?=
 =?utf-8?B?TlNuUVVwL3JFUVBseTFjWXVLQitxMWdQNzVhSFRNd2pJQ3dTQjBSdzNtWThI?=
 =?utf-8?B?RWcxOEIvQ3E0dzlURHhEWG9QTjVWMTUwOG9sWWZnL0xNRGIwa2hKNjlJcnF5?=
 =?utf-8?B?MldyWlJ1blMzQTFISmNXWFZDNzJzV1ZqZW5MZnVHWXF4NmVueDZoWXZxRGlW?=
 =?utf-8?B?SWp1MWo3allVZUlKTlR1Mk1lZHY1YlY3R0prQXAxbFgyam94a2NaVytjaVlq?=
 =?utf-8?B?aXRKZDhqd3VoT1d0bjU1SmxtRWFRME5JWW5INlZDdXNjV3QrNXl0OFNGeXIv?=
 =?utf-8?B?Nkl6cWNBemp3TUllTUFEekU0Wkd5RDQ3N1c4MkROZjZVVjZuMWJ0TUtVbHpH?=
 =?utf-8?B?ZkRwYzU2dEhxM0t0b0tRNTFDVDlUb2grMjlyNDFpNFlRVWhSUjNTdS9PSXJW?=
 =?utf-8?B?UHlCTDhBQ0xIYlAxalErSU5xWnE1UFAzOVNaM3ZyN1BQLzFGSXVNVk1mNDJa?=
 =?utf-8?B?V1lMTXZ1N2dud2gxMHNHQlBsVkYzUHlVZndlREgwY2IwNUhPR3JWRWFFS2lo?=
 =?utf-8?B?eVFGREljVHlKa1lycVJCVys1VnMwK09sQTRONlF1WWhodWdLZDdkZzFvZ2s0?=
 =?utf-8?B?RHBqZUFWbEZVL2kxcTZsTnUyUEFWNlR4R3dRalRzNExwR2pqcmZOUng3aCti?=
 =?utf-8?B?K0srNXNDdVNzUTRiTG9XVTZlOGZENHdDUUFPU2ViNjBIYlIyclUxdGhZTS9Z?=
 =?utf-8?B?K2NrNURoNkpHMDVadVJqU0YyeCt6WWlsUjVNSWg4WmhzVW9UaUJGMWRBNmo1?=
 =?utf-8?B?cW9IOC9SN1NRZjRHb3NyL0dxT2orTFhIOFcvSFBwNWVjR0g2U1IwS0o1MXdH?=
 =?utf-8?B?alhvdU0ySWtNU1R6bXlnK2loUXB4dzNKbkoySXlweUlzakhKd2k1bXp6cmN4?=
 =?utf-8?B?RUQ1OEl3SUlCK2x1NnovSTJOYUV1cUMrSGdjRkk3SlNPbjg2VWxBdHRKbzNW?=
 =?utf-8?B?U0Z6SkthU1N2REVtaEJMblQ2aGNvTkR0ZDZzbm52enZJeXZGMkE4TFdVNFM5?=
 =?utf-8?B?RXV6SE02dlRKc3czWjI5ZXF2TStvLzNveVFUUU5ndS95NXBscDgzSU00aEpY?=
 =?utf-8?B?L2VMYm9sOTVSV3U3RVRLL3FiL0QvYTgvOGRQZm1vV05IVUVXQUx3MjY1Wm1q?=
 =?utf-8?B?ZDNtek5kVDZPMkVmeGpvVDNPRCtPc0FKZkx4T2xyM0Y1VHpzQTFFeFFXbEFa?=
 =?utf-8?B?RFBIb0xzcVF1elVVd2MzZkVBOGtaR3Q0VnBUS3NpMFVpMjFoc3dPdGRQdU1P?=
 =?utf-8?B?L1ZiYkVGQ3VaczV0eEdMVUZXMEJsSnpIbEt4KzNmQU1VaEJoS0JLOUlUSEN6?=
 =?utf-8?B?Wk9yQ2p3VHlqMlJoVU1oeFBxb1Q2ZUh1Y0xNbkVGL2NEWlRrTC9VTWVmK0hm?=
 =?utf-8?B?QXNuaGZMYmhUSmpPN1laNS9xMU9HdFpDc1kvWWhYalU4OUN1azZtUDQ1Tmg1?=
 =?utf-8?B?dGRVcCtJVlJRPT0=?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 05:45:51.0722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a009e5b4-96ab-4d16-d00b-08ddb8628997
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB0937
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

pkg_resources is deprecated, use migration guide in [1] to migrate to
importlib.resources.
Keep the Python 3.6 backwards compatibility.
This also fixes the binman version test which failed for setuptools
versions that print the deprecation warning.
Change from __name__ to __package__ as with the transition from
pkg_resources to importlib_resources using __name__ results in
TypeErrors [2].

[1] https://importlib-resources.readthedocs.io/en/latest/migration.html
[2] https://github.com/python/importlib_resources/issues/60

Reviewed-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
Changes in v3:
- replace __name__ with __package__ when trying to get package resources
- Link to v2: https://lore.kernel.org/r/20250627-pkg_resoures-removal-v2-1-86b277b02552@phytec.de

Changes in v2:
- rebase on to next
- Link to v1: https://lore.kernel.org/r/20250610-pkg_resoures-removal-v1-1-97a269446d35@phytec.de
---
 tools/binman/control.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index af447d792a7f0e87bccb8e78b2df6fa093d320e6..1307222591de1688f8c7c2a3802833d13bf1e795 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -8,12 +8,11 @@
 from collections import OrderedDict
 import glob
 try:
-    import importlib.resources
+    import importlib.resources as importlib_resources
 except ImportError:  # pragma: no cover
     # for Python 3.6
     import importlib_resources
 import os
-import pkg_resources
 import re
 
 import sys
@@ -96,7 +95,7 @@ def _ReadMissingBlobHelp():
             msg = ''
         return tag, msg
 
-    my_data = pkg_resources.resource_string(__name__, 'missing-blob-help')
+    my_data = importlib_resources.files(__package__).joinpath('missing-blob-help').read_bytes()
     re_tag = re.compile(r"^([-\.a-z0-9]+):$")
     result = {}
     tag = None
@@ -151,8 +150,9 @@ def GetEntryModules(include_testing=True):
     Returns:
         Set of paths to entry class filenames
     """
-    glob_list = pkg_resources.resource_listdir(__name__, 'etype')
-    glob_list = [fname for fname in glob_list if fname.endswith('.py')]
+    entries = importlib_resources.files(__package__).joinpath('etype')
+    glob_list = [entry.name for entry in entries.iterdir()
+                 if entry.name.endswith('.py') and entry.is_file()]
     return set([os.path.splitext(os.path.basename(item))[0]
                 for item in glob_list
                 if include_testing or '_testing' not in item])
@@ -831,7 +831,7 @@ def Binman(args):
     global state
 
     if args.full_help:
-        with importlib.resources.path('binman', 'README.rst') as readme:
+        with importlib_resources.path('binman', 'README.rst') as readme:
             tools.print_full_help(str(readme))
         return 0
 

---
base-commit: 490ae8ceae2d5999c9de863e014e463f5c1495a6
change-id: 20250610-pkg_resoures-removal-17f922d2e64d

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

