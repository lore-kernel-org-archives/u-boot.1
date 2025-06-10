Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B485C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 12:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D772880E9A;
	Tue, 10 Jun 2025 14:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="EcYlCo9J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 795C182AC4; Tue, 10 Jun 2025 14:26:28 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20710.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::710])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AE4E8070C
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 14:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAmPHwByvPdjsbFFhKASStGjo4VMFLi2A3lIlj5ZMLSyZaxskPtLNC2b4+0HSk2zu1YcKVXiANrNGVIwvWs+he9+O+7lIXv4klrCSvrg0NdJ2aj6EzylrGJJJDoFanEhWrW3EW9emVtUQMG3Nyyf5P/b4EfWOWrzJQWxTOXjgZSK7wBaZxIhby06oP3iMBeX5w7T5yKBiLSvxDITphRI6zL3GKgpbTX6CKrFKKSMIIuUsg6Boyl05L80htWzGfZwmSvcs1+THIVOo2QfXyeALTkNhWN93Yq56BV7SvBqEg+gQUoBCefVip/EzugMCxS5Tj+oUuL8KAYeOF5xSl+g2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2xZVfLqg2fdhR0CiTtqP1CV0mXGlOjgAhL33Z7VVtI=;
 b=EfXu0cuybZE3BwPbvMdscMUiipBZgmCeXsiIXD4vYzI5kbm1kc6VdW0aHogJ0sGCiK/pWvXcPTW8zcl08RTHTNVsNQwkd1DD1BSAw9hI1NrO0IMiXFh3JFZbyRUnu6JwpQjI0b4SeJpv5oSapD/SqN12cyUgz4pr5+B93LR0xMEe6gsBqn21JEhcgkqV9onq4aVG/d8RhdynD+2UJCMCB9SPhFx1Q+tIkVLpk9FT+NCIvoOCuT4VEmsBFwGBTeBynPZB83TG29rA2oMgp4rpoVvSLVS+RZ7P14XBwq0VDzYnzZaCJh1/9fT8FPW9NuaY84jLm0hdZh1TIzKXIDgFcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=siemens.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2xZVfLqg2fdhR0CiTtqP1CV0mXGlOjgAhL33Z7VVtI=;
 b=EcYlCo9JHSH37MXzmhw9MTfEpzPgwX+Z/z+SYLj5dUw/b+N0dcTlA7x5Uaq0P7/ihVHg4ZTgqzT48A5DREZb8t9AsDWlBx77FhJh3Z60V0KyCj/mn3QW1KaOA2iISDq3XOcPVBhF4Rwjin0FzlNqnFkmsQ3Mo2Aqh9NFtvpKsrWJbtZXxWsAzuzSX6dAhJ/D1OaEJAjIROwJ2VWK6tcWMz2/D7547f8rcueDe/QrbMbrG0J1oQuLBgMPJYwRqeC4xczJCz61Y4stle7QojREcDsJEzMU1ZjwKkKroonjbNV28dV2+ZpkFMz7w0yLuVsFLRcAt6EwWjocnlJVUi5oAg==
Received: from DUZPR01CA0053.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::11) by DB5P195MB2425.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:48f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Tue, 10 Jun
 2025 12:26:22 +0000
Received: from DU6PEPF00009525.eurprd02.prod.outlook.com
 (2603:10a6:10:469:cafe::c0) by DUZPR01CA0053.outlook.office365.com
 (2603:10a6:10:469::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Tue,
 10 Jun 2025 12:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF00009525.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 12:26:22 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 10 Jun
 2025 14:26:21 +0200
Received: from llp-moog.phytec.de (172.25.32.81) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 10 Jun
 2025 14:26:21 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Tue, 10 Jun 2025 14:26:12 +0200
Subject: [PATCH] binman: migrate from pkg_resources to importlib
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250610-pkg_resoures-removal-v1-1-97a269446d35@phytec.de>
X-B4-Tracking: v=1; b=H4sIAGMkSGgC/x2MSQqAMAwAvyI5W2iDVvQrIiI21eBSSVEE8e8WL
 wNzmHkgkjBFaLIHhC6OHPYkJs9gnId9IsUuOaDGUluj1bFMvVAMZ4IS2sI1rMpUvkZ0SLZwkNJ
 DyPP9b9vufT+Ytg4zZgAAAA==
X-Change-ID: 20250610-pkg_resoures-removal-17f922d2e64d
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: Jan Kiszka <jan.kiszka@siemens.com>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749558381; l=2506;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=FUtqLgAp0ymwM2FzvFWW0JPq00vm3Hm6hTwth72lGSs=;
 b=KBtNZykc2VmuIHhnX3ksrBvmN5EWQNZzz6BP1D3bjvxexERALVwYlCZTQuRJlsGKNVZ4tb4Q6
 gYhX1xygRJgA5zUzuV/u/b47XQkmPTqHU9qB7fCOPkTFMdCN8yYDbid
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.81]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009525:EE_|DB5P195MB2425:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f623f4-f538-49b1-b606-08dda81a0294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDY2bVZxZmEzZERtcjkxOVc0ZkY0YXJ6RTVZeGdCdC9OalNmTDNKRkg5dFMv?=
 =?utf-8?B?QmNlWnRaNXM2WVBQUDVNZFBlMFcvNm5yUmFMZ01CYURocUl0ZUF5WjQzTFF4?=
 =?utf-8?B?MHRqYWZDSENJSElVL3A0NlN6OEluTFd6UWpBbnJtOFpVcEJycExPTzZBL1Js?=
 =?utf-8?B?ZW0veTNSL2czZWpaMHhlVFlYM3V6N3dFY0pzUlZ6RmxTUFA1K215WTBvc1F2?=
 =?utf-8?B?K2pTa09KclJpT2k5TFNkNjRNZUp5NUdtaVh5Y0lEQTU2c1VEVHp1bll1N1FO?=
 =?utf-8?B?QWR5REZzSElRUHVBTUNnWEQ5M0daU3hSMmU3Q0UzZDdzZ1dPa21heEhlS2pS?=
 =?utf-8?B?WHlST3J0eHo5WkpCNXJ4OS94ampFcityUEZXWHdESEZPZU5GbU9ReDNPR0o5?=
 =?utf-8?B?ajI0dlc1cFpuR3RwSnkzYWZ5UjNrWTB3VEV5K2lsMW1CdmFqVkRlT1pmbVJy?=
 =?utf-8?B?b1JKZnl1YWZIVkRrakltbFJIRE05Y1NsaGVGNHowOER2WmcxWEkxdDl6YzZh?=
 =?utf-8?B?Q1ZYYktUa3BQSGFXZTBPL2g3OFFkM3Z4WmZEKzhSWDFseWREbUYveG5IM21s?=
 =?utf-8?B?Mk1Uemp5aTd4K21JMFZ0N1JLV0xOR2MyUmU1d2lVRlpOVWlxbTdkYUN5LzQx?=
 =?utf-8?B?bUZqM2E2ZzJ6MWQrS3FvbHpVdGRXWVJSYUI0YkRWMFF6VFFPVStRNm5IUUdZ?=
 =?utf-8?B?b1lRSU1GUDRGWDZzTW5pQkd2WVlib2pnaWtET2N2VE8vcjFHOGNhVzBTUng2?=
 =?utf-8?B?SUFrNXpWK013U1piY3BwdkVsWGt3ZWNhSlpPOGdnNmlpYURBQWhJSmxQckxM?=
 =?utf-8?B?ZWExanpxOXRCaGJZZkNwcm5Iazljc3U2U1V1STlQbktPYTdsZjJzNFExVFRQ?=
 =?utf-8?B?R1NsSHhSVHZGMDkyMENraGRpaXRWQlFPQWVwVHowKzJhQnFQMUV6NDZEWlhG?=
 =?utf-8?B?WXpxQzhWN2Y2ZTI4VW1OUHpPM0hnSDlMUTJCWllRMTFaNloyTzB6bmhseGMz?=
 =?utf-8?B?Um1yS09JenFmWEl6bTZWNkwxRW51TjMyTnJZRzAremVTOGZxSWM0b2Z0Q3lv?=
 =?utf-8?B?eDZDYTRYdzQxZzhnOStMbDdscG52NCtxdm1GVzhFZ1g5Z1dITzljWTB1QU5j?=
 =?utf-8?B?aDN4anpBTG5kRC9HQ1loeXVEcDF6K2llenp2aDduNEZNMzU0eU8xbmRMZUNp?=
 =?utf-8?B?QmM4b0FWYnNkamNOUmhNZXN4VG11WVBJZnh3NS9MR2RLd1BLVDQrSEVpS0Zm?=
 =?utf-8?B?cnU4eHM2RjFZOFRiUDRmUFBHQzJpMUdnajBvZVYvOTFBeHdvbFF1Q0lNa1Mz?=
 =?utf-8?B?TlFrS1FDNllIL2tORzlyTGl5aW1la3ZDTEhnenJ6enE2bXJBNWhZd2cvbGpP?=
 =?utf-8?B?NVdGK0liTDZIQWpadDBOME9qdWRleGFUb2V3bjdRRVZYQ2Y3dUJKK2U5d0dO?=
 =?utf-8?B?ejJLUmU4WmhDQlpIQ01zVHBRdE0xUmlKL2dQSWp0WlQ3bmZrQU51Q20yTGZL?=
 =?utf-8?B?dTMweTJFdlZNQmt0Y3czZm5MYWFqTGN3cGhBd0xvN3h3dGhaaW4xbHhaWVNu?=
 =?utf-8?B?NWkyOWY1M2ZVVmFZNEN2WXptbW5qNTVkN3I3NmhJWmFJQ1ZRUCtZbDBObEhP?=
 =?utf-8?B?RlBoelkzdS8yNUVheithNWVFMS9zWFExYlBCUnhZcFBwMUcxamVBL2VMRDJj?=
 =?utf-8?B?SUx3czBvQVJFZytIbXY4NkRXaTg4cCtRVzJpVWpac1RhdzdNTlorWmdsUldn?=
 =?utf-8?B?dFE3Sm5ob2lzaS9iSmdhRTJJR0RTbVR4NExFYnNtZEgrMkVCYVUvcm1kOU9N?=
 =?utf-8?B?WjBKTVRMb2Npc1ZvVzNnY3FrdWh1eWZuOHMvMmFqSXlCZ3ovVlZFWTRrK2lO?=
 =?utf-8?B?NFMzMmZYRGtaNzZnZVpuNHFRWlB0NXRFakVMVHRxUXJyT01kc1NHNEdFUkdw?=
 =?utf-8?B?TnlTY0RCZ09lVUlFKzBCb3BiNndLWTBoTnVocUpJZzRqem43ck1DVlJ6ckQv?=
 =?utf-8?B?ZmZkeXUxcWRRPT0=?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:26:22.1703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f623f4-f538-49b1-b606-08dda81a0294
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5P195MB2425
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

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 tools/binman/control.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index 81f61e3e152a9eab558cfc9667131a38082b61a1..e36238c473c564de2e4e48d08229eab5f5e542fb 100644
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
     re_tag = re.compile('^([-a-z0-9]+):$')
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
@@ -759,7 +759,7 @@ def Binman(args):
     global state
 
     if args.full_help:
-        with importlib.resources.path('binman', 'README.rst') as readme:
+        with importlib_resources.path('binman', 'README.rst') as readme:
             tools.print_full_help(str(readme))
         return 0
 

---
base-commit: d7c449c3d83a986d61e38d1762433c0607caf5c5
change-id: 20250610-pkg_resoures-removal-17f922d2e64d

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

