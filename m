Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AECC83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 05:45:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4622382F14;
	Mon, 14 Jul 2025 07:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="fRukpxuZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D73A82B07; Mon, 14 Jul 2025 07:45:02 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20725.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::725])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E3F382B07
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 07:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwfJOxcEv7nBCBpj/GqIOD4N166/N6ETbouJ53D9BKCXmoEajCGRQ2ejXjbM1WVpXb2JZan5+CPV9F07HBYdvSFMOwxrY/91b3kfxDAwp++IE6FOGl7enlD2fToPvHevTNF5QqQyoOlTztHZa/mNMGnpKvewOCmzJt2v7HwvCFd/Ln4uT3mjxBQ7FO+t2hpjyJWMV//EKmw0vq85Anq2gpfLva5elT6qWimGylwBnug8UxeR1OheJjK09wczFz4AYIKzvbxEw3ly/PvxStpVsUXPdsBl4/a/37GFl1WhcmlHludLEKK0mgS/2Z0bfy7hf+5L+AQFJfmJfU0kSnOzTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nuV7mRTjGG+EH2Hnx55SO90Wx5sG4JdiD7DJPd0Upc=;
 b=jziJTbLuqLdD3/pf0OZ91jbASxs4RYSdw3C/rQ7PPMDPAFUSOoCh8Ffb8dG+aE39wtKEOCYjBk+hNxQ0jXU3eP1BkJ9F/2tO379Pps3s9QtfQqoCmljl6q+7oYwLM9fpaUg5RbHLMiFFBV7Xtz0/XxfhljMxgCYCB5uP7lBGVFqGezvPJF7XpPZ39NXmwbRzc/t8jC+wN7/0i1OuRr5znS1V9y+StS8PGoJr0lYuZ1Est2f9i7b3rKeurJsn5TZso4o47xSPR7zFItywFi7QUG1bf4qzA0WhJ0Bolc6qLAMfS6Q3m4eijGMWwViWk+M05/7evQc9lOE4MDhWbaPhmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nuV7mRTjGG+EH2Hnx55SO90Wx5sG4JdiD7DJPd0Upc=;
 b=fRukpxuZ6RBuOOtkAyMsHn6YKu6mL98g5jSUK8y0/6bIg8u4t4RfXWGDzTJwBrAvkjUAx/TG2LXIzqqyQ60cYMAA4iYxKz5CmiT61p+aHDNBBRDtI9safW/LH+SZo1jfG7o19bxfdehvR77aZvzQTbE2wIUL1STTdicRTy4dgxD0yoMioC8lgaIgKB+di5sFByL9k+5GFOfL2ZCoKK/zOO0g0rKrJeL+TJtRRTQ3/GJbbQZklhjnSRLCtqifUq9utZu5CCrVDbRYCDSNh8Cg00mSeBJRMLzvx7T6cstsQcagXpDs3At/gAF2432L9u/TZvdjbK7LkolxKN63gBz/HQ==
Received: from DU2P251CA0029.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::31)
 by AS8P195MB1349.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 05:44:43 +0000
Received: from DU2PEPF00028CFD.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::57) by DU2P251CA0029.outlook.office365.com
 (2603:10a6:10:230::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 05:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028CFD.mail.protection.outlook.com (10.167.242.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 05:44:42 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 14 Jul
 2025 07:44:42 +0200
Received: from llp-moog.phytec.de (172.25.32.60) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 14 Jul
 2025 07:44:41 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Mon, 14 Jul 2025 07:44:32 +0200
Subject: [PATCH v2] binman: Fix typing for python >= 3.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250714-binman-typing-fix-v2-1-dbe6519c43a0@phytec.de>
X-B4-Tracking: v=1; b=H4sIAD+ZdGgC/22NQQqDMBBFryKz7pRMqBG66j2KiyROdRaNkoSgi
 HdvKnTX5Xvw398hcRROcG92iFwkyRwq6EsDfrJhZJShMmilW9WRQifhbQPmbZEw4ktWtFp1jgd
 zI+Og7pbIVZ/NZ195kpTnuJ0Xhb72V6M/tUJIaIx1qmsVtdY/lmnL7K8DQ38cxwcGyUgesgAAA
 A==
X-Change-ID: 20250710-binman-typing-fix-a207bed6416b
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Yannic Moog
 <y.moog@phytec.de>, Bryan Brattlof <bb@ti.com>
CC: <u-boot@lists.denx.de>, Tim Harvey <tharvey@gateworks.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752471881; l=3078;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=hVPYp1Jidh4irx8FK6BjBGpBk+fMD/WHLWdUwMmwLLM=;
 b=dItUWD8b1giM606r6MLqpTZEVPVNG5HuOske1xG5hySaLWufw0A2r7K77R2ySz6T4HKCbdMCr
 C8NhCUl/ZZcDZVeXnya7tZZoYzmoD3tH0leaZDDPTHFmHkNRy37qnpx
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.60]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFD:EE_|AS8P195MB1349:EE_
X-MS-Office365-Filtering-Correlation-Id: c224a759-556a-4406-0a26-08ddc299883a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDFob3Urd09RTWt6cTdjNk9oSmlyZTZta0NZR0lFMTVHWDAwejJESFUyM2ZZ?=
 =?utf-8?B?b0k0KzA3ZlJBTi9UYzFvbjBxVGQrRDhMSWJGR0d2V08vRkQ0K012NnFMSVhs?=
 =?utf-8?B?WEJJcFBZOXRmdExJZm9JeFpJQmFoVk1pem4vZ3BmM05Bekd4UFFUZURJOG5V?=
 =?utf-8?B?TkVuRXhDWDFucmxxNGwxQTZJNTFFRFhtTHFmcGdPZHhtb3ZQMlZlVlR6NmpM?=
 =?utf-8?B?eGgxcUxqeTlYR3NqTzFscWlmcnJRaitLS2p1MVM3SGpiZyt5T3lIY3VURVlU?=
 =?utf-8?B?ZjB2UmNlc3ZWYmFyeHlGL3RXZ1V3Y045cnp0dkg5SU9QRlBRamYvUGJNZytH?=
 =?utf-8?B?cWlhMU4zS0VRNVBJaEZMM1FaS1lXbFloYlRHVlV6STM3NHgvd0Q1WDJ3d0F4?=
 =?utf-8?B?czdHaVd1RDlGRzZRcEZMQ3loaUhEMEJIdmtLMEp4MUw3L3h2M2ZrMkZrenhx?=
 =?utf-8?B?a1R0QjJuZEFMYnBGcGpHZTYzRlpRMUNYV0tNZUdjYmQzRWIzcXVYYnNsaCt3?=
 =?utf-8?B?MkcrbXNZNXZteG0rOW15N2MyVUdBYW1kR24rZjJUOEpQUnF1NXBLZnlCWFdC?=
 =?utf-8?B?d0VnUVJYVWJrZDRKT3ZPdEMyV2sxK2R0YnJvbFdHZnZuMGV4Yk9rbDNZc2Mr?=
 =?utf-8?B?ZnFIbm9qVGNsZnkvdElGUVRVMTkzQ05RR2RtQzM0WDVhdGxmZFJsd21IWmph?=
 =?utf-8?B?Mm5WcmlwMUZjVVQzamRKcXdIK0RpWnYvdFdOQUdBUlFBd0xpY0ZSRTkrd1FP?=
 =?utf-8?B?aXJ0aTJnQWpqWk1DbHVMbURGcDdyWk5Id0h4QS9PaTJOMkkzTTJIRDFWTzJP?=
 =?utf-8?B?ZDB0ajBmbXlxNGd2Z3BVKzNSVDh4N282RW9aMlQzYUgyK2NMUGFDYXFQUVh5?=
 =?utf-8?B?eGxUNTNCdkY3THZHeEJiaEw2ZVVTa2dTZERMYU1hbzVGQWVaWmVMQUp0TEk1?=
 =?utf-8?B?QVZLZTNUWTNzRGFtYW5rcWt3TWFSMlU1dlBZNjl6Mk56Y1JGODBhM3pKUHhr?=
 =?utf-8?B?N2FUQ3VYanU3RU4xV2JmQjRjbjRyRmU5cWxSZWdmMjJ2ZVNLMmhCckJIVkN3?=
 =?utf-8?B?bzhmbndLenR2UGlKdm5MRDBaY1pnN0haTzkzb2NaQWNlb1NLOXJMZXBaQThu?=
 =?utf-8?B?ZDlYZXBFb0xuWlE2LzJEN0FyN2YvUllnTjdsVFNxMDZPL3JnZ0EzeTROUi9V?=
 =?utf-8?B?VDBZSGJGOHRaNncwZWJNOXNOaGJHL0s0OEVHcVBtdWlYUVVWYmxOdm9vcWk2?=
 =?utf-8?B?NTVaTVZTaGsrL0hWWjQrUlIrYWFIclllQXFjTzVFNldZUnZjaGxiR0tDRS9m?=
 =?utf-8?B?eFQvTFlKZzgzV3pkbUkxaWc1WDZjcFA0YnkvUDBtRHBLcDdHR2xta0lYTDA1?=
 =?utf-8?B?UDVVandvNSsyeFloYURxbkhNcXV5M1RxZzh5QUFFZlJVWFpMVk1WdFBXUlZ4?=
 =?utf-8?B?K3hiNExtZFd5M3NjK2p3Z3BIeWxjNURuL0pMTFV1akpLUjJXb3JINmVMUTJo?=
 =?utf-8?B?bnRScEgxdVRLVmRCWnhreUtmUk5iMHpQcklYQldlREZtaThPcmUrRytuOUc4?=
 =?utf-8?B?WUFraWlQb281dXBHQjdoRFhYaG0vbGhZYnU1YzlOUGFoUzBiaGVuK2hVd3pq?=
 =?utf-8?B?MHY1aGFuM0xxRVhjeEVMczNxRjVSbkQ5bGg1YW9HcE5BSWMzUlJpRE8rN3k5?=
 =?utf-8?B?WEdUeHBCV0xRNWxiR2pqcTB1RzkvYTBoUlZZMHRtRFRIRmQyVFc3YjFyT1BP?=
 =?utf-8?B?QW4rZUtLdjNQMGw1cTlKUkJuK2lpaDZQTGprUDJPbFFNK2N2WC9NQ0ZKb3Vl?=
 =?utf-8?B?WjcrUWhhMlM4T1kzbGh2T2pLU1hOZlNCNm41VDFjS1ZCVGZtRml4VlN6V2J6?=
 =?utf-8?B?UXhPSElpdVZ2UWlNSlZ0Mm1SS2J1a0F6UUcxWVZuWDAwM1BHYk1RZ3pXSzIx?=
 =?utf-8?B?K1N2Vkh1emdkUjBGcEZOL3JrWUYzOFllMmMyT1FDd3dHM295RzNGY054dTNE?=
 =?utf-8?B?endhRmtlcDFQRURDTWZzVTFPTlliOXF6OGpEQUx0aGtQbjFmVVVSa1NhUzd1?=
 =?utf-8?B?OFhGTWlZUmdkVGN5SldZcDB4Vk4xMnFmem1zdz09?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 05:44:42.7046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c224a759-556a-4406-0a26-08ddc299883a
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1349
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
Changes in v2:
- drop newline changes
- Link to v1: https://lore.kernel.org/r/20250711-binman-typing-fix-v1-1-66ab075015ac@phytec.de
---
 tools/binman/etype/cbfs.py    | 3 ++-
 tools/binman/etype/mkimage.py | 3 ++-
 tools/binman/etype/section.py | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

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
index 75e59c3d3a3104da7559982f64968fdd99b7bd5f..9f68f3386bd4d6615a9c917de6b783c2d20b31ee 100644
--- a/tools/binman/etype/mkimage.py
+++ b/tools/binman/etype/mkimage.py
@@ -6,6 +6,7 @@
 #
 
 from collections import OrderedDict
+from typing import Dict
 
 from binman.entry import Entry
 from binman.etype.section import Entry_section
@@ -205,7 +206,7 @@ class Entry_mkimage(Entry_section):
             self.record_missing_bintool(self.mkimage)
             return data
 
-    def GetEntries(self) -> dict[str, Entry]:
+    def GetEntries(self) -> Dict[str, Entry]:
         # Make a copy so we don't change the original
         entries = OrderedDict(self._entries)
         if self._imagename:
diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
index 03c4f7c6ec74c6fa75c9362e2fecdb0e6ab568cb..471c6fa55879c3d568ea642750348df216fa1e18 100644
--- a/tools/binman/etype/section.py
+++ b/tools/binman/etype/section.py
@@ -12,6 +12,7 @@ from collections import OrderedDict
 import concurrent.futures
 import re
 import sys
+from typing import Dict
 
 from binman.entry import Entry
 from binman import state
@@ -537,7 +538,7 @@ class Entry_section(Entry):
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

