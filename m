Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF37C7EE31
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 07:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B1AD82E27;
	Fri, 27 Jun 2025 09:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="aXHMB5GF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3435182E52; Fri, 27 Jun 2025 09:07:54 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::724])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FDCD82B6B
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 09:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiNkXCwFOwRgyzev6Lg2Z3O5Ca6zujwmS70Nv8kmgwsBjSkSekyJT2bEhdHc0Jt2w7mDMCyUP9EfO96qbBDxWKjKq7NIX/z9ZoHqwlmLPsuuoOmGcAx8ieGd9Ia2R3DmyNUYFRWeFtzsug5iuhm+KGPJYfcPCCMYPMMiWNzK9hP6m9I+zK1zQ2eM/f2IUey/JlP/SW8np26luZDW8mboqHdn/LNRC97RRg60bWC4+yRVE8Fhnarge/DeG7B6pgNunsR6PKzd2EjwJttLhpQCrE/h6+fzMQMq9ZG5hCi90pyMrFCkTYKBApl1r4CBL8GfdwzUNr608aShCK+7L1V2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=su1FTpQVXI6zh4jTdKl42s4dYq3a77A1LOAGKFnrAjQ=;
 b=Kr8hvsdIrr9HDGASYN6LEFpv4xFmSHTAPFC2Qd9NmR6AMcw7gj6hrlsHF86IvZrV9N15rkGQYnwZBtYZAITXcwy0JWHb6MZ0vlvM7Ozcy3KOtjSwzDcr8R00pbqlDFHtzAqwrZTquB89/2mQR6IA4pJmnEpuRakhmyc0iCat5JNNt+BULTnNj9bhqmPzaJGXs2w5H/7ORzOdh89JLDALu467tiWe4ehMMsZAdQO1cmphG9PIEsqzmKEW02mV0Fy/Qm7LSC36b9AT5fnlFBWKDGoQwJd3nfGt9WTDxLXj6b8KdYrvLk6/26YYxv4LHmd7TQ01taaFJZ3dXxQnLj31pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=su1FTpQVXI6zh4jTdKl42s4dYq3a77A1LOAGKFnrAjQ=;
 b=aXHMB5GFs4JA/++JrGTbZW5yxqTRUCuKpcjSyxgWpRIaCAG600x6ChRcdUjGHoZ+zUsNXd5L5Q9ypm0SikCk206M79AY0Xq+oYDe2kyaSVCURP+MSMHTAFlC+5V3gHmcCfriGZvYmhM+3ReyFp+oP4N6UXTO2wZKXrgJ3/lr0ig4CyC2LM2PswWUPIU/P5a7YYzxVuYf2C39O3KHTrUPzmKo5DKKlIBlOrzTXneIf9dyM65gw7aKLwiLGOocgpHWa4ibNgLejONb+x5xkwBOPbvVgR6kLgfswJ2MakUUlyyTyVw/goxZ5vjn3oegsya/W+GdrmK3ehHODKaIf5rzWQ==
Received: from DUZPR01CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::16) by AM9P195MB1377.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:38a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Fri, 27 Jun
 2025 07:07:42 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::50) by DUZPR01CA0020.outlook.office365.com
 (2603:10a6:10:46b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.23 via Frontend Transport; Fri,
 27 Jun 2025 07:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 07:07:41 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 27 Jun
 2025 09:07:41 +0200
Received: from llp-moog.phytec.de (172.25.32.39) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 27 Jun
 2025 09:07:41 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Fri, 27 Jun 2025 09:07:36 +0200
Subject: [PATCH v2] binman: migrate from pkg_resources to importlib
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250627-pkg_resoures-removal-v2-1-86b277b02552@phytec.de>
X-B4-Tracking: v=1; b=H4sIADdDXmgC/4WNQQqDMBREryJ/3ZTkN0bsynsUKcF8TWhrJLGhI
 rl7Uy/QzcAbmDc7RAqOIlyrHQIlF52fC+CpgsHqeSLmTGFAjjVXgrPlMd0DRf8uwQK9fNJPJpq
 xRTRIShoo0yXQ6D6H9tYXti6uPmzHSxK/9o8wCSZY22hUrZTKXOpusdtKw9kQ9DnnL+0JRkq4A
 AAA
X-Change-ID: 20250610-pkg_resoures-removal-17f922d2e64d
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: Jan Kiszka <jan.kiszka@siemens.com>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Bryan Brattlof <bb@ti.com>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751008061; l=2691;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=MGVbByPeBtc9BjCP3I/KOtTGE5qdNpbk1JQRaGxn1NY=;
 b=9K4/vAeRwZ7pvoHjVQCs45KLU+AL4sjwLBAFZ6EwKvW+p2Ey862TUUiE0NRo/mzxrzrb5I30b
 Wf4kjcQxckkCusoSrDnnNXcQAvGZWTjT9jxxD3KJXuC2YLFLWL+/wGe
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.39]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DF:EE_|AM9P195MB1377:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3cfa14-8729-4a6a-9d34-08ddb5494eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RE1DTFlaZXFFZk9BNjk4ZmFFeC9tNmpMMWNqU3BnOVUwV1J4a3o1eVdJOE84?=
 =?utf-8?B?NUVjZVUxcDNjMzZmUDdTanRIZDZ6V3drZ2piSWt0bHQyQitKNU05dWtDWTBS?=
 =?utf-8?B?cUEycEhrMitvYXRreUFYR0RyRCtoR0QyOTVFWXczY0Qyc2JNQkhDMFZkUUs2?=
 =?utf-8?B?Mk1GTjZyQkhkckFMcGQxd1dxMG01bVV2S1V3WS9hS3UzVGhFaFo0dnExbzBk?=
 =?utf-8?B?RUNMcmgyTnBpaVpSMUtvNlUzZ2tJRW5EOVNtZzFIRVRUNkc3R1YwMzJZaEdY?=
 =?utf-8?B?bVhxa0dXcDg5dWNFTlRrdHgzem1xT2J0Wjc0R1FKWExrQWk5dTNXMDR2Q1hM?=
 =?utf-8?B?cEpZcTlIWEh4alVaaWs3Qlk2SmVXSXZGK3Z3NnpWa3ZLZmdFUUhxM01RRXYx?=
 =?utf-8?B?VzNuR01TUHV0cDVoZDdGalRPa1dBeEJnZFVjS1Nvbk50UldJbGZjTEtaQ1Q2?=
 =?utf-8?B?NTZ5UkN0d2tNZVo1RDU4bHJ4Y2JWUGxJa1hmazJ6Ymkvb0tPby8xTzBrU0dV?=
 =?utf-8?B?WVh6T0ExcU1TYWN2R0dZU1RQQ1ZBU2NvdjgwQzhicUg0L3Mwbm1nSk1xNmpH?=
 =?utf-8?B?dlZac2xERGNpdGJYRHBJUVVJNzJZb3JmTzBJWFhhcmlzRE93ZjVBdDR3NGtj?=
 =?utf-8?B?MWtBdWZyaHYxditwNythdkJ2bWlmOWxoSEZMYUpzMjNZR2ljY25TRmU2ZWVn?=
 =?utf-8?B?YnFpcS9YZ0xEcGE4MUdaQ3FNT1FRRU9tR3lXeXFmUzQrd2ZMQVhSSzBDNCtu?=
 =?utf-8?B?cnYvRExmM3pSVVVNK0hNeHAxdlJSdTBhcVdnNmVhSkJGajQ2bGh2WEhzUm43?=
 =?utf-8?B?WVZVbVFTYnhGY2k5Rk0xcVprdWkwai93UzNDbDEyVHlCYjc0VDlsR0FXVjlj?=
 =?utf-8?B?Rk5WT1dya3NDQ1dwU1BGSFROWmFIUTEvQmJDd1YxeVlENFhZNVZscG1BWllU?=
 =?utf-8?B?N1NzbU9aaGk2SVBpOTI2a3ZyYlRINWZoTXJQalpGS3hZUzRVSzlJNkkzVGYv?=
 =?utf-8?B?S3VaS0xYRmZCK2JjemlRTkh5Ry9jMHlINVRsTjVxUmRENlQzQkhQdnBhbGRB?=
 =?utf-8?B?UHhaMHJIT1RZUjAxU09HbEpkSzV0bjUvQmd3SmtPOHA0c2IvWWs1eTh2Sm9p?=
 =?utf-8?B?c1M0cDc4R2Q0SGNxdnpDK3VVb25XajN6TERHT1A4b0RrNis5MmkvZDBEMmxr?=
 =?utf-8?B?VXpOczRZRGZhWWszOWxoRFVKdm5oc0FRS0NVdncvZGp3MEd2V3YybW1NQTZo?=
 =?utf-8?B?UzVJV3MvUDAwTGF5OThJMEZoaTNZbzNXZWVrcE1YUmVJTHlQdllIVmpmaFBR?=
 =?utf-8?B?Y3dTZ3ZYcmFVRkZjRVhFUlRDNEw3QmMrZkJkQ2xWb0NmRERpTjJKeTN6TG40?=
 =?utf-8?B?Ym5nWThuZzNCN0JubXhyVUtGUEQ3Q2VZakIwekVQZ3NZSGY2dHBYdDlQZEha?=
 =?utf-8?B?d1hWUmozak5lYUNXejk2eExvODRGc1IzcFNja2xRMmEvMzh3M1FoYmxVMUxh?=
 =?utf-8?B?ZmQ4a1AxYzh2ajE2elF4dnRQUExVVTNuL0xLZGZZa1JackRNd0xFNWE5bFJB?=
 =?utf-8?B?WGdoWC9DKzRSeFNTOUNJYkQzUnFzOG4yNEFRcjdiRFNVS0lsRFd0WnpBRTFH?=
 =?utf-8?B?MmdKbWo4VVZZdjQyM2FmREpLQ05QTnNNelRpWDJ3bXdZcHRka28wQmdraDRx?=
 =?utf-8?B?K3NwaVM4UXRUditmTmVPQ2Rhb2MwR21YMGZ4SW9pZ0E2Y3FBMHRYbm5NTUZv?=
 =?utf-8?B?cEdQOWdOT01kV0ROaThsNHhmd2ljaDFQaTArcFkzWVJWb0ZSaGNtUGttcEgr?=
 =?utf-8?B?Z0dDN3pCSEVPeUQyUnIvMzczN0tXd0hLcEZCSmowaFNkM003eU53cG1NZXBX?=
 =?utf-8?B?MmNHL1FwL2lNL3hKek5HalU4WlFERE1aVHlDQUpwTHN5cjBHM0ExRlc0ZzIx?=
 =?utf-8?B?RW9GRE9xTWZyVVA1YjhFN1dGRHFvRXE2RUltWlhocWJNSHZqRmY1aVpwZ0Jw?=
 =?utf-8?B?a1FYaFlVdHZRPT0=?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 07:07:41.8399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3cfa14-8729-4a6a-9d34-08ddb5494eff
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1377
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

[1] https://importlib-resources.readthedocs.io/en/latest/migration.html

Reviewed-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
Changes in v2:
- rebase on to next
- Link to v1: https://lore.kernel.org/r/20250610-pkg_resoures-removal-v1-1-97a269446d35@phytec.de
---
 tools/binman/control.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index af447d792a7f0e87bccb8e78b2df6fa093d320e6..c93752d6dfb1ebfddd43b9f46f160c71231d47ec 100644
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
+    my_data = importlib_resources.files(__name__).joinpath('missing-blob-help').read_bytes()
     re_tag = re.compile(r"^([-\.a-z0-9]+):$")
     result = {}
     tag = None
@@ -151,8 +150,9 @@ def GetEntryModules(include_testing=True):
     Returns:
         Set of paths to entry class filenames
     """
-    glob_list = pkg_resources.resource_listdir(__name__, 'etype')
-    glob_list = [fname for fname in glob_list if fname.endswith('.py')]
+    entries = importlib_resources.files(__name__).joinpath('etype')
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
base-commit: f2220962f9cb1366bfc003ec2cc5650499c68895
change-id: 20250610-pkg_resoures-removal-17f922d2e64d

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

