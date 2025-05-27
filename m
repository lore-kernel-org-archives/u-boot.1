Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB507C54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83942837FC;
	Tue, 27 May 2025 15:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ot9Ptvsa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F048C83837; Tue, 27 May 2025 15:24:38 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20723.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::723])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA0918301F
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9WlYd/zQaQ2KY5R1Wz5X7ofhLAo/M5P9Td2T0c1D0LYTZ/fLLwvw9JhfHoX9Qqisbhnkq3xaYHWQk18BExPt5F0WWCvcyRcFbpLzrK9n66E8os9n2J0lDDafUUEnyviQ7xEPYvq16LUOBJRe4+8H/IMAbU07Qha3HUekvK05IWwxyjgw3n5s+Dy6AzkebVDMEzfNzlBWfO0HL7oVeYo3f/nSqvcc4NwnEW8k4JGMrQzo36zr8C23vMpFBgUyKvfQRBIGE8FUlBV5icrVJxRPldohKbvhCwNZXXI7AzVZhEMXd5HFQrfgBwKJryK8kFJ6GpQSY2h6iJsoEMQKERvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28AnoNJykMM8HsEiiGPoSyWYLsHauB+uMDyfkU8rj4Y=;
 b=wr5fwH2kHdmxufZdUz7ID/6S3qp7o/zDukd2jjip/H+4GPWRheGy4SZTaiuq6a61gsb3LeXB9LRC1LpNqQ02coZ++7ZcHnTgAL+n5sZnYlsmrK6jSdZGkBQhrZw1J+lohD87Q3kland6x29olIQuf9v3QQ3EI3TtIletHE8SXrgpeulzH+e/rhPYZdHx/fbD5msd4iM7c/buh+ZqNkmnzkjidRjw9ClTCzregPgLB08Jz4HjHwSVGYUSFP9Ew7sM7TrDN1JVv9u9Vh9hs2h1624cB20b4k9/gjAwWLULuNOUE78p0pSTHDE8zByL12RQUsI8bMi3Sp9eObBnSaSOpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28AnoNJykMM8HsEiiGPoSyWYLsHauB+uMDyfkU8rj4Y=;
 b=ot9Ptvsa9VfKnX7O/NXXOT/vThEbrB+qD7q2E44h/1UYLN1jM9MXwgazzrcUSALtzCFI8C2+DlNiLfnq0DmbU3Bker0o5yyMNahstXHMcLkG3gum/tKs7JMw60kbEuhCJwOwL6NQY2mlF8dFg7/Hbvbe3kc0CP2y/P844sPMo6G7aXg2BbyaBLRal2DNbhTgLIYPDVU7NpCqzAA8qK6RvWf3AFCjKvTtDN4iVk7R1NpzPXzDMlLGAVgaHA1xEx7xyF+mNK+cOL9vf/YUUaI6BLgai9cTh+I1FAKJuPaZYTchKZAq1V8xkyOtFGWyvQpNicPe6+xuo3h2TCuZCmfaSg==
Received: from PR1P264CA0026.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19f::13)
 by PAWP195MB2203.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:338::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 27 May
 2025 13:24:34 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:102:19f:cafe::34) by PR1P264CA0026.outlook.office365.com
 (2603:10a6:102:19f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.24 via Frontend Transport; Tue,
 27 May 2025 13:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 27 May 2025 13:24:34 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 15:24:31 +0200
Received: from llp-moog.phytec.de (172.25.32.70) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 27 May
 2025 15:24:31 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Tue, 27 May 2025 15:24:13 +0200
Subject: [PATCH RFC v2 5/8] binman: rework dropping absent entries from
 packaged image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250527-binman_faked_optional-v2-5-3362ab897581@phytec.de>
References: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
In-Reply-To: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
To: Simon Glass <sjg@chromium.org>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748352270; l=7785;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=qZk6ARDBPBYzYeTpwesfFExxgt9gAaQZ5sc37MdyG5s=;
 b=PtCjAB1RSTCBGxRcVW0U6Vxqr80nC7KV/SuekTAQwEzBgMhddlMeCjFh6Dfm1DZ7/049inU47
 AXfwrTJgR9ZB/FDUWP8YeJtFQCibi6Fogwy3JhMCbxYgk/zPOb3/Hu8
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.70]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|PAWP195MB2203:EE_
X-MS-Office365-Filtering-Correlation-Id: b7392593-ac9b-4a18-5675-08dd9d21d28b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cU0vR1RCWERlT3h6UlNVQUt0dTBJNFErKzM5Z0E1UUZ3QmJLZEVyK2NqUXFo?=
 =?utf-8?B?RjV2M0dZa0FQU3JNSWpraitQbEVSR0RYRXdlQk1rU1BFUEFqanFIN0hpci9Y?=
 =?utf-8?B?Z2xFWE5waVRqWFJ1L0o0T0l2aXFtaUdDRGtuNDBkK3JOOGl1SDNBTGg1Wnps?=
 =?utf-8?B?SXZHK25Jd05ydEI1Q3RaSnhCZVVqZnBORjFxTXRac3VpcndTNU9CY1k1T3Zv?=
 =?utf-8?B?bVhPLzJSTTl5TDg3cjhBVUdPUHcwOXQzOWpEQWdhTHRZUjNTWGlpVDhIdlZQ?=
 =?utf-8?B?OEFOR0JiVnFaZW1rUTFwYTBXSGFGd1RWdjZCZ3VRL1VpQWhnV083MDlubm94?=
 =?utf-8?B?algvc2lmVkxTVWZMdmFnY2U3aXBkMjIycHc5RnBIbVorL0dncTF0eEZiSFdU?=
 =?utf-8?B?WEZSRjdkNHNRTFovYVZsK0JqeDdOMnFONHRXSGJCV0h2bzAvU05NOVNLMGJJ?=
 =?utf-8?B?WFh2NVdwazVGNEFzWjFZZDFjbG1yTVdVYUttTXFpM2FZblN6bDRIMHdadHZL?=
 =?utf-8?B?NE92VHZWVlB2aFhIdjNjZFlzL2tFZEhPSjRZeG1KNHNNTFB6TEFSaXhCdHFZ?=
 =?utf-8?B?TWNlcEd4ZmppWGJoblRJV0NWZlEwRTg0YUttM1U4UDc1UVRpeGpmemFUSUtl?=
 =?utf-8?B?T2M0REN1RDl6MzQ4Wk5aT0ZRd292cU91UmZWM2FOZUc1VHdNWnZPdmJvTjBJ?=
 =?utf-8?B?ZXdkU1lxVHF4RWpIVEpsbXV3aklGNDdndmhiZHQvb0dSSFZsQnZDT2pDMmE1?=
 =?utf-8?B?QW4yV0YrTVFKSXlIa3IyRkR5VjVCbS9rMVhaWExabXZTN25mLy9IVE9GL2FG?=
 =?utf-8?B?N3I1MGkrUkpSRUhtWUI3OFhPN281dkorOHZ1d25TbmhBYlVpR3JYNDhWV0lD?=
 =?utf-8?B?RkFxbzVVN1RWMDJ0ZHd1L2FCdmNNMDN2clR0RVpYamE5M3FBYzVWamRVSGRs?=
 =?utf-8?B?L0lnOXRGY2JyRjdTRFM5eDB4MVc2UXBTckVneGRFMm5DUU1JQnQ4U3BoOUFR?=
 =?utf-8?B?ZUR2WVZ3d1g3Z2xkZmEwY3VMTXJMYytRK1FnOU9CdXVoKzJvM3FZeW5YQWJT?=
 =?utf-8?B?WEszQ0VSUVAzR1E3OG5wbm5kYlpxRTZlc2dhaGkybjdXcEdnOS9KWFpWTkJk?=
 =?utf-8?B?NVJFQWIxUUExUFJ4SW1kYkJqNzRmVVJDN2p5eFp1ZXREc1pnN0hhQXZFMFBH?=
 =?utf-8?B?bHNNTnR5QTFGR0pXV0V6N0Qzc1NVeEJuY2xCelRFbVU1TklDOW1OMG9McTF1?=
 =?utf-8?B?cWhMSzVCOEhZK2VnUk8zZkVKREJHQWwrNCtESmtIdHBhVDVaMFVqOWlBK3M0?=
 =?utf-8?B?RXFSblQ2SmVXN3dGT00xNk4zVWdNTTMyTHZyY0Z2cnl4L1M2QU5wbEk1Uysz?=
 =?utf-8?B?Wk1kS2t2aEpyWFVYeGlhRUxMYUZxYThxVExCTHdzV3FjYktPTmt0Z3ZFdE4r?=
 =?utf-8?B?OXY2elJFZWFIeWM1Sm82WHNuTExzaEFJV0JrZmFYUzVROFlQaGpXZS96V2M1?=
 =?utf-8?B?NUFRYzJ6aE5NOTRYcHRWZU02RTVKcGxyQWRjSnd6MFo4Z0s4L0VLTU41bTNp?=
 =?utf-8?B?V3pnTHNBTFJqWGhzZlNRZGNodmRqQjdZcll5R3pPRXliVlF3RDFzdklVMFps?=
 =?utf-8?B?SFRCbXV4WjNmK3c2aDhMTVEwUXZ5OEVKZXZJMHdCM2syaGFwc0YxeXdKTUx6?=
 =?utf-8?B?N0F6ejcya1ozekZ3aHRoWDRKMnF4L1l0ZngzbjJuMkQvNnZHTTFka0xoVnVJ?=
 =?utf-8?B?WVNLUlpRSlRBallvTjJkY2RFOUZZVmtPQk8xVVZRdWNVc0t0SGVGaDBVcW14?=
 =?utf-8?B?OXZsSG1xNjlpZUgxUWF3WDhYaXprWkFPaG9oWXIyQlZCZnBlMlFaZTNZYUNr?=
 =?utf-8?B?amN1WWxzRzRSanV6Vndmd0s1SEZVZ3A5TzZaUFcrQTdQM0xTYlRnczdYdGk4?=
 =?utf-8?B?dWcwQzI1Zk42SEk1ejhHUjNabDg1S2JsS2E2RUNwWDhNdE9yQUFRajdwWVVN?=
 =?utf-8?B?VEZ1WVNWRFVCaERsbHN0UU94QXl5VXk2a3pDNHRCQTFVOEQ1amhxUnUwbGZX?=
 =?utf-8?Q?CeItRo?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 13:24:34.7897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7392593-ac9b-4a18-5675-08dd9d21d28b
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWP195MB2203
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

When blobs are absent and are marked as optional, they can be safely
dropped from the binman tree. Use the drop_absent function for that.
Rename drop_absent to drop_absent_optional as we do not want to drop any
entries that are absent; they should be reported by binman as errors
when they are missing.
We also reorder the processing of the image the following:
- We call the CheckForProblems function before the image is built.
- We drop entries after we checked for problems with the image.
This is okay because CheckForProblems does not look at the file we have
written but rather queries the data structure (image) built with binman.
This also allows us to get all error and warning messages that we want
to report while avoiding putting missing optional entries in the final
image.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 tools/binman/control.py       |  8 ++++----
 tools/binman/entry.py         |  6 +++++-
 tools/binman/etype/cbfs.py    |  3 ++-
 tools/binman/etype/mkimage.py |  2 +-
 tools/binman/etype/section.py | 18 +++++++++++++-----
 tools/binman/image.py         |  4 +++-
 6 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index 81f61e3e152a9eab558cfc9667131a38082b61a1..c2a4d3eae9d4e8f4a3c5be1abfb1469ba1c0ed93 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -18,6 +18,7 @@ import re
 
 import sys
 
+import image
 from binman import bintool
 from binman import cbfs_util
 from binman import elf
@@ -669,7 +670,7 @@ def CheckForProblems(image):
                                    for bintool in missing_bintool_list])))
     return any([missing_list, faked_list, missing_bintool_list])
 
-def ProcessImage(image, update_fdt, write_map, get_contents=True,
+def ProcessImage(image: image.Image, update_fdt, write_map, get_contents=True,
                  allow_resize=True, allow_missing=False,
                  allow_fake_blobs=False):
     """Perform all steps for this image, including checking and # writing it.
@@ -697,7 +698,6 @@ def ProcessImage(image, update_fdt, write_map, get_contents=True,
         image.SetAllowMissing(allow_missing)
         image.SetAllowFakeBlob(allow_fake_blobs)
         image.GetEntryContents()
-        image.drop_absent()
     image.GetEntryOffsets()
 
     # We need to pack the entries to figure out where everything
@@ -736,12 +736,12 @@ def ProcessImage(image, update_fdt, write_map, get_contents=True,
         image.Raise('Entries changed size after packing (tried %s passes)' %
                     passes)
 
+    has_problems = CheckForProblems(image)
+
     image.BuildImage()
     if write_map:
         image.WriteMap()
 
-    has_problems = CheckForProblems(image)
-
     image.WriteAlternates()
 
     return has_problems
diff --git a/tools/binman/entry.py b/tools/binman/entry.py
index 6390917e5083e40a4e3294e5d36ec300d2057fe9..ce7ef28e94b17e349544776070c457d5882661b1 100644
--- a/tools/binman/entry.py
+++ b/tools/binman/entry.py
@@ -760,7 +760,7 @@ class Entry(object):
                           self.image_pos)
 
     # pylint: disable=assignment-from-none
-    def GetEntries(self):
+    def GetEntries(self) -> None:
         """Return a list of entries contained by this entry
 
         Returns:
@@ -1351,6 +1351,10 @@ features to produce new behaviours.
             os.mkdir(cls.fake_dir)
         tout.notice(f"Fake-blob dir is '{cls.fake_dir}'")
 
+    def drop_absent_optional(self) -> None:
+        """Entries don't have any entries, do nothing"""
+        pass
+
     def ensure_props(self):
         """Raise an exception if properties are missing
 
diff --git a/tools/binman/etype/cbfs.py b/tools/binman/etype/cbfs.py
index 886e34ef8221ad50e9f881e8abad16015c9790b5..bb97b227ef78356b08b5cc31b04d98c6fa0633ef 100644
--- a/tools/binman/etype/cbfs.py
+++ b/tools/binman/etype/cbfs.py
@@ -276,7 +276,8 @@ class Entry_cbfs(Entry):
         for entry in self.GetEntries().values():
             entry.ListEntries(entries, indent + 1)
 
-    def GetEntries(self):
+    def GetEntries(self) -> dict[str, Entry]:
+        """Returns the entries (tree children) of this section"""
         return self._entries
 
     def ReadData(self, decomp=True, alt_format=None):
diff --git a/tools/binman/etype/mkimage.py b/tools/binman/etype/mkimage.py
index 19ee30a13ca75a5d05a17d4c26424e84934b6ea2..c9362c6bbf740da946abe2fadefe35ebfc89fced 100644
--- a/tools/binman/etype/mkimage.py
+++ b/tools/binman/etype/mkimage.py
@@ -205,7 +205,7 @@ class Entry_mkimage(Entry_section):
             self.record_missing_bintool(self.mkimage)
             return data
 
-    def GetEntries(self):
+    def GetEntries(self) -> dict[str, Entry]:
         # Make a copy so we don't change the original
         entries = OrderedDict(self._entries)
         if self._imagename:
diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
index 44b1b85e93496d0ca114907f42a98da1f0af09b9..8e5c20e3017c9b320ebfdfd3bf82489ed6161c98 100644
--- a/tools/binman/etype/section.py
+++ b/tools/binman/etype/section.py
@@ -450,7 +450,7 @@ class Entry_section(Entry):
     def _PackEntries(self):
         """Pack all entries into the section"""
         offset = self._skip_at_start
-        for entry in self._entries.values():
+        for entry in self.GetEntries().values():
             offset = entry.Pack(offset)
         return offset
 
@@ -533,7 +533,7 @@ class Entry_section(Entry):
         for entry in self.GetEntries().values():
             entry.WriteMap(fd, indent + 1)
 
-    def GetEntries(self):
+    def GetEntries(self) -> dict[str, Entry]:
         return self._entries
 
     def GetContentsByPhandle(self, phandle, source_entry, required):
@@ -768,9 +768,17 @@ class Entry_section(Entry):
                        todo)
         return True
 
-    def drop_absent(self):
-        """Drop entries which are absent"""
-        self._entries = {n: e for n, e in self._entries.items() if not e.absent}
+    def drop_absent_optional(self) -> None:
+        """Drop entries which are absent.
+        Call for all nodes in the tree. Leaf nodes will do nothing per
+        definition. Sections however have _entries and should drop all children
+        which are absent.
+        """
+        self._entries = {n: e for n, e in self._entries.items() if not (e.absent and e.optional)}
+        # Drop nodes first before traversing children to avoid superfluous calls
+        # to children of absent nodes.
+        for e in self.GetEntries().values():
+            e.drop_absent_optional()
 
     def _SetEntryOffsetSize(self, name, offset, size):
         """Set the offset and size of an entry
diff --git a/tools/binman/image.py b/tools/binman/image.py
index 24ce0af7c72b5256a9a71963a6d94c080ed8bdd4..86543ad8db36b38afc1957fde7e20152067b79aa 100644
--- a/tools/binman/image.py
+++ b/tools/binman/image.py
@@ -15,7 +15,7 @@ import sys
 from binman.entry import Entry
 from binman.etype import fdtmap
 from binman.etype import image_header
-from binman.etype import section
+from etype import section
 from dtoc import fdt
 from dtoc import fdt_util
 from u_boot_pylib import tools
@@ -183,6 +183,8 @@ class Image(section.Entry_section):
         fname = tools.get_output_filename(self._filename)
         tout.info("Writing image to '%s'" % fname)
         with open(fname, 'wb') as fd:
+            # For final image, don't write absent blobs to file
+            self.drop_absent_optional()
             data = self.GetPaddedData()
             fd.write(data)
         tout.info("Wrote %#x bytes" % len(data))

-- 
2.43.0

