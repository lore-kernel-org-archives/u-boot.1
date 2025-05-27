Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC10C54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C355E83857;
	Tue, 27 May 2025 15:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="SDe4RAtt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E77A3837F6; Tue, 27 May 2025 15:24:41 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::729])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55EEB83830
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFM1ddnmY1p+D6Bb6eFHZWgiQC9LsIxbppWTBdfTTycpz369nB7lMhSl0u1SyBviyi36TBA193xyEwZ8G/iTqMHT1IXUNPf/3+f84ZouOWCqnydAtmvKbca/ypwTlsun1NkBHVPT9P1i+J0KYhfqtr4eCRm392li+fJSxcCbxZoPSU2y0pxSUDWpEF6I1I10crQ5AXS0CQmRlh/uGAV4EJP5o7mTZrPjCPYSMHQwIzX1XV9Vmc1XakBZZSHYIFQ7/NfsKG1mD9wEwIsNsabaWFPgtcl6DqE+Vje7vWDxuRrexQGu+Fd1LwQ1ZCbpKaQiMSJeRT8pwoMefIWKQZCDtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pr/DUV3hGztgKpuFurSZwJ+j5JqxhbYCnmrA5jhI9ps=;
 b=K2/piNW7En87q5nVDWRGbJBKcIKr2MaAFrOD6LBFwz2WdDgG0iNRS6KoS83tw5IkHCJWVpMGwG0E+TBbsiEVmUr6n/WdKYOCjCRpv2z1R1cENswASxC6MrmNFTvfBfI/7LegkDgSla8R6kh9mxJGOW3At3liiUkSe9L6snrPSQJ2u8Cy87ubMkDRuQ8HQ7pvgiAI6M+cYqZg+fGWWXeXcK/vvsQyy2JWm5a22yxRlrc07tNWBv0QD7gyDE50eKVPSlAQal9uWtdnasGUSBMClgMmDCO8v/n9KS9Uw27wG3BJb54F05SAS/vqPmeqkbdsIcrVtcJ7d271KKOwcQWe9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pr/DUV3hGztgKpuFurSZwJ+j5JqxhbYCnmrA5jhI9ps=;
 b=SDe4RAttydZWbxN4RJ4yw9UYDvj7oQuMajpk4bSxS/jXlKafmXEnHz0aIwLbxDDuIcvElAlztW8G/1YUfsPAPaVFYxjDzuOteOea9avfPzvW4CxJYT8LeCzFAL0FhIAK519eaOaheCIBV3hmU3v44tvR+zHX+0G6uXDZCm3R0hkvomNmNNuTTdGSgcuUvdiab6ntReyNR3Ds/gdo7xIdtw6RSWaDj2unwp9K6+C48sTZDeq7+icWW/DsXKu1Ntjl49SerpAcZqD8upXcSUs3EOB2TWFVpq3UjZTJEETKkMQm2e3tKNDY2rOgM3vy7z6bsKwuFmcS/Aq5BsjfMOL58g==
Received: from PR1P264CA0023.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19f::10)
 by AS4P195MB1888.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:580::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 27 May
 2025 13:24:35 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:102:19f:cafe::37) by PR1P264CA0023.outlook.office365.com
 (2603:10a6:102:19f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.24 via Frontend Transport; Tue,
 27 May 2025 13:24:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 13:24:35 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 15:24:31 +0200
Received: from llp-moog.phytec.de (172.25.32.70) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 15:24:31 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Tue, 27 May 2025 15:24:14 +0200
Subject: [PATCH RFC v2 6/8] tools: binman: add faked optional entry case in
 CheckForProblems
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250527-binman_faked_optional-v2-6-3362ab897581@phytec.de>
References: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
In-Reply-To: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
To: Simon Glass <sjg@chromium.org>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748352270; l=3290;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=MxDDTOj/XQvppEmbBNmBeEHrNFQj43r9eowElM1GJIU=;
 b=rK1BjsT4HTuL4v071LscerEOR5KRa/RYDbniInmqKCxc/96nw/D4WVDiz9I9QIRcHQqusbMw3
 WlkRwNEnxD2BneBVprcUFCB8FNjhU+XkIkPxjwH43mfaDAUKOJPqTbT
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.70]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|AS4P195MB1888:EE_
X-MS-Office365-Filtering-Correlation-Id: aa5e6fa1-dfd3-40fb-e5dd-08dd9d21d2bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHpKVitITkpmcHFWakFhdlFpTlA1ZXlrUUh6TnZQTkdsK2RVcGJJelFIK1c3?=
 =?utf-8?B?VWRHNVdoa0paeFA2a3RnWkRiak9Kbjlrbm5YRDR0ekpOV2ROaU9EWXN1NUZ2?=
 =?utf-8?B?T3owdU53UTEwYTRSM21Bd1NqYllLWnB5L25nUTU0YlFOOVdveWxWQUwwYmVE?=
 =?utf-8?B?WVFGUFZCNkhDZnBrbWU1NHZQVm5vdWZTam4vdlQ3UTNQbS83RmRUNG9xek1k?=
 =?utf-8?B?c2VLeWdQQkc2WnUwRXpWTXhkbTVncHYxdGs5a1BEMXlQU0p3WGU5bTN4anJo?=
 =?utf-8?B?a2FTbmh5UE96R3BNQlJsb1o1VFRMVHRYVkpBVjR1c2lqd0RrM0Zma2FPVFZ0?=
 =?utf-8?B?aGFiREtLSXlZdEs1U1lzWExWSGtWL0lWRjE0RnM3ZVdrVU5GTnFqZ0ZOc0lW?=
 =?utf-8?B?WmpHY2k2TFZNNUZJYWZTK0ZpU0grMFc1UndhSW01T1UxdGpPaG42NWMvdW1x?=
 =?utf-8?B?SXNQY1hSNUhodVZvSldqb1pGZWpRcm5jdHFEb0ozV3cxVlJtWlM5dHNOZEdN?=
 =?utf-8?B?VkkxWEpna1pUL1NpYVRQTEs2ZnlzaW03YnhTQ2JjK3U4SGtsbmE5ODc4S0Ja?=
 =?utf-8?B?eGsvNmFIUkdZZUdTMjVDYnBSdEJSR1NXVFhRdjFyM21EZGtPbDM3SkQ4MU1F?=
 =?utf-8?B?QWlaUWpVYVFOSThnR2pzSmlURDFjWnZoSTVvL3h4SnJuL2w0aEJUbnF2VXp1?=
 =?utf-8?B?SGFlK3ZiOWViNGptUDZuOEwrUm9qQm1MUGNKQ0F5cGtWcDN6VkZzaklJemFZ?=
 =?utf-8?B?bmVDdHNsQUNqUE1DNmdBRUdOTWZ5UmdUS3hWOXlTVHRKem9vSTNsNGk5Zjd2?=
 =?utf-8?B?NUZkRUhObUREZ3VNTFZac252TTZrd3MxVmtpdmthaFpFZWx4Y1p1bjA1cEdQ?=
 =?utf-8?B?ZHZyT0FVUXl2Y0xUQXo4WXBPV2RoY3FxT0c3dWdaOXVTUXFPcUl5eFAxV3pX?=
 =?utf-8?B?SnNEN2FZZ0JBU3BOTVVNTlZNQlhjYWlhVFFDWE1pQmZ0aCtqWmdoRHhJbmtl?=
 =?utf-8?B?NmNVV0VNa1h5ekd5aitBaElGRTBNSzdKNTdjZFBVVFZYemZxOEVaQ0NFcGMv?=
 =?utf-8?B?TUZLQlRtMWlLdlJLU2N0dmhqTHNSQytBZE5ONGN6UkIyNU5EK3NleG51ODdK?=
 =?utf-8?B?SkdhR0RJSWN5NEkvVmxtWjkzQUI1NlZLQkYvT1IrN0paWjZSNkZ1YmxsWHVT?=
 =?utf-8?B?THR5VlZVOGF2TTVGN3RsaU44V1BsU0gzZ2JxWkU4NTBENFBCblVnaS9ZeHBa?=
 =?utf-8?B?bTNzSGFLR0Zyemw2WjR4UnBhZ1ZXTUE1MDEvWVhWajJ6N3VkTi9LMG1SbHow?=
 =?utf-8?B?VE5sdXAxSDBxcFJZdnowbnRHS3dRbldMend3K29xaEVvK3ZDdW9ZL29rRVdl?=
 =?utf-8?B?ZlhHcnN5clcvK3MyUFZ1am95U0lZSUFxa3FHZjZYVFIxKytjZ0VLaU5keEhX?=
 =?utf-8?B?MU9vcHpCNXA2dFJFLzgzODEvRWlPazUyd0c4dDRSakhHRGtOZ2J3K0NhSGky?=
 =?utf-8?B?blN6Rkg3di9zdmk3ZmJwV2JwRkJ3ZkIycUhoRDNxUUphSjc1TWlQSUgrYlpq?=
 =?utf-8?B?TDZ3Ty8zR092ZC8vSlgyQURvTWljR3lEQzF5Z3A0QTVUeFpnT3JEMHVGM0R2?=
 =?utf-8?B?L0xIVUFBSmFOUXA1a2t6Sis0Yzh0QmFwUlNGUThYOU1hQ241c0pERUlqWnlN?=
 =?utf-8?B?Y0lvNnRsaEZFOTN3UkFXSitaN1RnbVVEVkdsOC91SmRNRmFkNnZvYWhoNk5G?=
 =?utf-8?B?aWQ2RTRCWjkvemFzeWo2ZURLV1ltN3BCRithczlaMmhObjBDRTE1bkY1c1hO?=
 =?utf-8?B?TjQ2OEtHb3RqdHQ0cTZKVzJ0QmsvNkhiOFlZekpSSTMyT011UEZxaGRKRzdK?=
 =?utf-8?B?ZjdLZHVCaE5JaTJWVWxCWEhSSzZ3WHUyZE5DOHl2bUZKYnVrM0xPMlZ5NExs?=
 =?utf-8?B?ckJyYUZWZTBKOXpZbmNpY1UxSGYxYjFPb0ZPaWVzcUpMMmx4REJlR3Vua3hS?=
 =?utf-8?B?NVdWZEhSeWhDSy9wWWw5QlZ5RnFMYXVLaHNCMkp2NStXWUdXS0FoSXNsRU5M?=
 =?utf-8?Q?t3aCcM?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 13:24:35.1335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5e6fa1-dfd3-40fb-e5dd-08dd9d21d2bf
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1888
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

When having an entry that is marked as optional and is missing in the
final image, the following output is observed:

  CFGS    spl/u-boot-spl.cfgout
  BINMAN  .binman_stamp
Image 'image' has faked external blobs and is non-functional: tee.bin

Image 'image' is missing optional external blobs but is still functional: tee-os

/binman/section/fit/images/tee/tee-os (tee.bin):
   See the documentation for your board. You may need to build Open Portable
   Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin

Some images are invalid
make: *** [Makefile:1135: .binman_stamp] Error 103

To solve this contradictory messaging, when checking the faked blob
list, remove entries that are allowed to be missing.
This patch does not change the behaviour as blobs remove themselves
before CheckForProblems is called.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 tools/binman/control.py | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index c2a4d3eae9d4e8f4a3c5be1abfb1469ba1c0ed93..baccb647c56f6abf987d787ef4826fbea625bc0f 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -646,12 +646,19 @@ def CheckForProblems(image):
         _ShowHelpForMissingBlobs(tout.ERROR, missing_list)
 
     faked_list = []
+    faked_optional_list = []
+    faked_required_list = []
     image.CheckFakedBlobs(faked_list)
-    if faked_list:
+    for e in faked_list:
+        if e.optional:
+            faked_optional_list.append(e)
+        else:
+            faked_required_list.append(e)
+    if faked_required_list:
         tout.warning(
             "Image '%s' has faked external blobs and is non-functional: %s\n" %
             (image.name, ' '.join([os.path.basename(e.GetDefaultFilename())
-                                   for e in faked_list])))
+                                   for e in faked_required_list])))
 
     optional_list = []
     image.CheckOptional(optional_list)
@@ -661,6 +668,12 @@ def CheckForProblems(image):
             (image.name, ' '.join([e.name for e in optional_list])))
         _ShowHelpForMissingBlobs(tout.WARNING, optional_list)
 
+    if faked_optional_list:
+        tout.warning(
+            "Image '%s' has faked optional external blobs but is still functional: %s\n" %
+            (image.name, ' '.join([os.path.basename(e.GetDefaultFilename())
+                                   for e in faked_optional_list])))
+
     missing_bintool_list = []
     image.check_missing_bintools(missing_bintool_list)
     if missing_bintool_list:
@@ -668,7 +681,7 @@ def CheckForProblems(image):
             "Image '%s' has missing bintools and is non-functional: %s\n" %
             (image.name, ' '.join([os.path.basename(bintool.name)
                                    for bintool in missing_bintool_list])))
-    return any([missing_list, faked_list, missing_bintool_list])
+    return any([missing_list, faked_required_list, missing_bintool_list])
 
 def ProcessImage(image: image.Image, update_fdt, write_map, get_contents=True,
                  allow_resize=True, allow_missing=False,

-- 
2.43.0

