Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EFDC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 09:23:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8194801BE;
	Fri, 11 Jul 2025 11:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="j0YIAJ1u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71A1F803DF; Fri, 11 Jul 2025 11:23:47 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2071e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::71e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB3F9800D7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 11:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJnMCSSLlvcoVZOE9EtEs9EptynqITTqd4ktz3NrYTEWCHWn/LLDxv4PiyNgBVTo1aOKeW72XDl+Sqg8i/5R5jqU59MHfoH85h4tpbAohBX6UniTojLixmbQeR+/+h2DFuxZZv7wwT+0EYc2keWeAI1jO8doguCdEXCbMYbPb1eisYDDk6pAFFiWjTl1LQI0ayFmwejskRIHFajdtd0lmchUehVUyn6d4sjsCvrczOrFreuJ+lSRgHVcdH+7JQpI8xmZNUydXcuTpr/vDrbdZqYwrZvVTm5csvJg/HXOYYL3o1L8DSfKBaeaqGMj0Badt8cDvAPRTvKmVZelY4ISfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuEUKiKA7vHxjZzZfPE8k5AgAQrAZfyP0iVan+6De6M=;
 b=BmurMhTOETHWnyqcfw2tZT+gPXvC1a4lsj9ANG68mDSbjkUUAoLYESYCGe0e2Lz8fqpG7vOIwvI8MgGFTJlktxke9VdzUWtCFfrtoSYv0WrdF2yRdQz2AUXcqblut+3pu/nj3g7ns6ORwYmqyt08N26rztZVQHegz8AeMUZPLSeMUWHMimg6dhl3hnE+Z64soS0RGHs0gVUD2596lBEaHN9M2sIQAszlDjlkeZs+LOWmandamthHh3WYL65eKcBZ4YT2RDR6t3B/i+x2RMLmM1TgfOGz/VaHmIdfnC4J6tof7RM9AsNVUhgzEXcmfwNvF/R7KnxaySzk3SKDiC436w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EuEUKiKA7vHxjZzZfPE8k5AgAQrAZfyP0iVan+6De6M=;
 b=j0YIAJ1umkV6taQx7RPErjMM0EQ8eXVuTeY91/Nn3i5S5AFlqFqQC2qowEQpaDQDDiZvMQPj6YJ+2SUqdZ2vhQAzXxBQNFNk9Wz/BYUq56dMpdkdBZCWG77oXn1ed5Gn89YmDWEU1YYs05ECIOpXO6zBzGFVMsXYHtfYjfqHu2Gqm0yMiVsbTcLQkFXwBNH2GPoCTWZ9WjWhlbxKo6UJrDKSQ3ABaPYTnckWhqQmem7/gdz8YuEf17F1ht8fpfQp6WcPLL5J3+zsfqtV/CZEdvlnu3Lo7fFdmLZjrW1QAtV3Cv0KNIAgN0BA3fooaJZygZMKj9e6RUNW4IdIymNYyA==
Received: from DUZPR01CA0131.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::16) by GVX0PF8B9EE53B9.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:158:401::7d7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Fri, 11 Jul
 2025 09:23:38 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:4bc:cafe::68) by DUZPR01CA0131.outlook.office365.com
 (2603:10a6:10:4bc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 09:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 09:23:38 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 11 Jul
 2025 11:23:37 +0200
Received: from llp-moog.phytec.de (172.25.32.60) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 11 Jul
 2025 11:23:37 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Fri, 11 Jul 2025 11:23:27 +0200
Subject: [PATCH] binman: Fix typing for python >= 3.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250711-binman-typing-fix-v1-1-66ab075015ac@phytec.de>
X-B4-Tracking: v=1; b=H4sIAA7YcGgC/x2MQQqAIBAAvxJ7bkGlDPpKdNDabA9toRGF9Pek4
 wzMZEgUmRL0VYZIFyfepYCuK5hWJ4GQ58JglGlVpxV6ls0Jns/BEnDhG51RnafZNtp6KN0Rqej
 /OYzv+wGhuqtAYwAAAA==
X-Change-ID: 20250710-binman-typing-fix-a207bed6416b
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Yannic Moog
 <y.moog@phytec.de>, Bryan Brattlof <bb@ti.com>
CC: <u-boot@lists.denx.de>, Tim Harvey <tharvey@gateworks.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752225817; l=3369;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=dnzB6cWxC/wn/tL4OfVosT+4DwR+Vws88sVzTKQp5gE=;
 b=umIB8rCAHJrffWLpHNUKm+4gZ8xAM5IAgQvoCXcyS6Afm11LLNciGTbatAGI2oA99oXMGJAHl
 cbxcFIgo75wBg1p40zB4C1ToPaWNMHDG5CD0GzmN2iS94/Esrg93jnH
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.60]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009528:EE_|GVX0PF8B9EE53B9:EE_
X-MS-Office365-Filtering-Correlation-Id: e66beefc-e00c-4a52-b451-08ddc05c9e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEJBbTdYMHArN1VDczVWemphUkVhNkIwdnlSYzlzYTdPdktVSjdLeWFOaHd2?=
 =?utf-8?B?ZjVjYkVERk15MVR3MEt1MDMzblpGSDMrOHZPTERhRCsrSWZmUUtUNGYwcE14?=
 =?utf-8?B?NkFJNHpLeTlGUDdHOU9ITkNuTDFrREVpb0pPbzFUQ3RkY2ZJYWFpdGhHL2c2?=
 =?utf-8?B?cnNxTGNQSnJGWjl5OEVqcjlnWW9QbXJ0VjZjdXZCT25GVUhqM2hZY3F4RHpI?=
 =?utf-8?B?OGthSDhZSzVBeXA5ZHZROTIzaEFQVUkzYzBRUHZPK2tselRjWmFpaDUvSkNy?=
 =?utf-8?B?cktUNUxTQ1dBN3B2c1ZQQnpBYWtnNXFOZTRhVHFHcU1uTXltU29IWE9WS3J4?=
 =?utf-8?B?ck9jY3B6WFgvMEhaOGFCdnlkYm1rOEdoWGRIdXNKWUxuOWUvRElQVjVUNHdl?=
 =?utf-8?B?WWFYSjBFYk8rZ09GZ04rRHF5WTdIMUlOelJSY3U3SFZDUUFTNGpCWUdKN3dl?=
 =?utf-8?B?ZnJWaVI1em1BdGQwWW1zNzJrOWFRY3NrcEliaURNcUZDcmU0M3ZrVEE2K2JC?=
 =?utf-8?B?cXFpRGJvNm5qVTJOUHEwVUx4TXhxZEcwWFo1MzNSWHNiRm90Slc4K2FQL0xi?=
 =?utf-8?B?QkJCUDhTRDNKdDlGeGxCVVIvdzFkeVJhN3lsMG1XNU14dktCTnZnNExGLzgv?=
 =?utf-8?B?eWRod3dhcGZuZmFpcU4yWnIyWjNaMHhGRy9pYnJvV0NCZm1vV2psRW1Wd004?=
 =?utf-8?B?dUhLa0lmN2RibTVDa01GYlMxRER1RnJ4ZHlJSkFwdWUrMWFGQjYxZkNuditj?=
 =?utf-8?B?TVRtaWlORjNLdTFqZ3NnQlhyV2ZrczdqK0kvZ3JkY0kzQkF3UStQcXBqaHVU?=
 =?utf-8?B?OVpTVFMwcmNwUlh4akUxUnI2OHo2V2M4c0R3TWMzRVJsUHN5bEV1WGpCek5B?=
 =?utf-8?B?OWNnT3R4NzVQeURGMnJrdk1nempsR0V6UnpGOCs3eUpJekRWYVNpUUNvcDdE?=
 =?utf-8?B?aXYvamZ3ZEhVQm40SjFQZnEzRllyQmtoeFFjbnYxNmpNS3VRTStLYTYwamdV?=
 =?utf-8?B?RUJ6UmNMNUFOTWtWUmNhZDkyRnR4K05EcHgyVG5IYk1qekV0WjZoS0t3ODY1?=
 =?utf-8?B?TU9LQ0traXJ6YkZ4S0JldVJjWkFtU0ZUdzBEVStXVCthbk15cWRvNFhkQkFt?=
 =?utf-8?B?b3RrazByN3dQTWk2TTlxMWdDNHROWEFqSjRhcGMyVC9USlJBemVyUjViQ0hX?=
 =?utf-8?B?T0VzSmtrK0ptSDFYNDZpbGJtWVZtSVlPTkZSSVUzcEpxYzRyQ3NNcllMKzVX?=
 =?utf-8?B?RmFuT0NjaktpL1hOSnBlRFVzT2orNFdIQjQySHFJcDd2b1pGcG40aVF1MDlQ?=
 =?utf-8?B?MmcrNUFmQ0tuZWExUDMyaG1ack1rMWMwY3NvTWVrbnMweVFIRlFJRkNZcHZh?=
 =?utf-8?B?MW5pZ3ZMUEtRQk1BTXZrYVMzbXBKOEhnSi9SNlBJdGRxekVqY2RhY1g1QnhB?=
 =?utf-8?B?Z1lTSktITHV1czBvb3hOQ1BEZzQySjNObVI2UU1QdDNsL3g3K1Y2ZTJicnhz?=
 =?utf-8?B?THpSSStxZXNuTGRwQ0RnUytuZmROSlAwNktGYTNsNm4wMTB6ODZ4UEM0d0hG?=
 =?utf-8?B?S1hsQVhDbnFmeFdKcG5RVEwrQ1ZZMWl3VnF1d0djUDV5cFAxVlBmeFc1R3U0?=
 =?utf-8?B?OWpJeW5nNmpOa2FwNjRSR2w0cytmWXgxcWpKOGs2UmRpbWhqQ3dPdHFUeHNE?=
 =?utf-8?B?blFRYWZjQVRjSHVWWi9nNDVaUDJGeXpZb0g0Tk4zOW5JK3pQY2cweHFIUFAx?=
 =?utf-8?B?RVNPMWwzdjk5VGVQdmMxalp3NUtOMDBER1RmMzE2dVIyVFpIbnQzMzF1bkJO?=
 =?utf-8?B?YjYzVGpTRlNNbWlZNUFXQTAzRFNrSko1Ri9BMURMOVFqTWUzMzRtSUNOa0s3?=
 =?utf-8?B?a3AzSm9VZG9oaVZYbTE5NG51QjVVNGFNNXphQjJZQnBBV0prVlc1Ym1aSHRu?=
 =?utf-8?B?QzRLME80UTlWZTVjbU9mYlQvNENQQjJaN0FJWlJOWk1zem80aVdWai9rNGRq?=
 =?utf-8?B?NFE3dnBCYkNtZmY0bndmSW9HbTlwWWkxdXg4RFlxVXYwZjNocGhjMlV1L3Uw?=
 =?utf-8?Q?BIxYd8?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:23:38.1271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e66beefc-e00c-4a52-b451-08ddc05c9e4e
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVX0PF8B9EE53B9
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

To make it work with python 3.5 and 3.6, need type hints from the
typing module.

Reported-by: Tim Harvey <tharvey@gateworks.com>
Fixes: 21bc3433a43d ("binman: rework dropping absent entries from packaged image")
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 tools/binman/etype/cbfs.py    | 3 ++-
 tools/binman/etype/mkimage.py | 4 +++-
 tools/binman/etype/section.py | 4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/binman/etype/cbfs.py b/tools/binman/etype/cbfs.py
index 5879f377231bf94697bea97c3cfc3a2515665b8f..c5e77f3a0df22ff768aa7254e4dd9ecbe6f81684 100644
--- a/tools/binman/etype/cbfs.py
+++ b/tools/binman/etype/cbfs.py
@@ -6,6 +6,7 @@
 #
 
 from collections import OrderedDict
+from typing import Dict
 
 from binman import cbfs_util
 from binman.cbfs_util import CbfsWriter
@@ -276,7 +277,7 @@ class Entry_cbfs(Entry):
         for entry in self._entries.values():
             entry.ListEntries(entries, indent + 1)
 
-    def GetEntries(self) -> dict[str, Entry]:
+    def GetEntries(self) -> Dict[str, Entry]:
         """Returns the entries (tree children) of this section"""
         return self._entries
 
diff --git a/tools/binman/etype/mkimage.py b/tools/binman/etype/mkimage.py
index 75e59c3d3a3104da7559982f64968fdd99b7bd5f..d324229a825d67991bc7c23329c6e377f15d0397 100644
--- a/tools/binman/etype/mkimage.py
+++ b/tools/binman/etype/mkimage.py
@@ -6,12 +6,14 @@
 #
 
 from collections import OrderedDict
+from typing import Dict
 
 from binman.entry import Entry
 from binman.etype.section import Entry_section
 from dtoc import fdt_util
 from u_boot_pylib import tools
 
+
 class Entry_mkimage(Entry_section):
     """Binary produced by mkimage
 
@@ -205,7 +207,7 @@ class Entry_mkimage(Entry_section):
             self.record_missing_bintool(self.mkimage)
             return data
 
-    def GetEntries(self) -> dict[str, Entry]:
+    def GetEntries(self) -> Dict[str, Entry]:
         # Make a copy so we don't change the original
         entries = OrderedDict(self._entries)
         if self._imagename:
diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
index 03c4f7c6ec74c6fa75c9362e2fecdb0e6ab568cb..1e31dcb1f1c7defd176fd1a7560d9efc38141d3d 100644
--- a/tools/binman/etype/section.py
+++ b/tools/binman/etype/section.py
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier:      GPL-2.0+
 # Copyright (c) 2018 Google, Inc
 # Written by Simon Glass <sjg@chromium.org>
-
 """Entry-type module for sections (groups of entries)
 
 Sections are entries which can contain other entries. This allows hierarchical
@@ -12,6 +11,7 @@ from collections import OrderedDict
 import concurrent.futures
 import re
 import sys
+from typing import Dict
 
 from binman.entry import Entry
 from binman import state
@@ -537,7 +537,7 @@ class Entry_section(Entry):
         for entry in self._entries.values():
             entry.WriteMap(fd, indent + 1)
 
-    def GetEntries(self) -> dict[str, Entry]:
+    def GetEntries(self) -> Dict[str, Entry]:
         return self._entries
 
     def GetContentsByPhandle(self, phandle, source_entry, required):

---
base-commit: 6bb0679377abb01a82db1ce69b5bf1d40aa02ace
change-id: 20250710-binman-typing-fix-a207bed6416b

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

