Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D7AEE208C
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 11:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2837E83B85;
	Fri,  6 Feb 2026 12:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Pn5bD3br";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01D8683AA7; Fri,  6 Feb 2026 12:05:24 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9201F83AA7
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 12:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=t-pratham@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaF5AWFaCaUrMlNYwb3gJ4Pe8iWc7DLghhcSwhQw637ojSX5/fk1gVx6LTSEIzSSP9K5aFaJBQFTn33j81CL5XAI0BVO7bh/jqJwu4+TJVCMSMvL85rTXe+oGsJxSkcsTnfEuCXfxrpK6hxiO8La0c6hj4shnlmK81/RNBg2rdrjjACp4jTUjHBiqgdDwKgaGFx9PCvVcvSNBo8znhUg1U1+pk2RqDLXg/N+llcFMY2snvvh/ridMiU8fu9x63fxqfk3j5WaezJ7kkAc/xFsYFki7kGwbQmFvFYWQNezoDBb9L74VlQLwCgaVrfLZ7EvqJGuT+Yta8bbk1wRphhBRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgP3k+AsHz4H+Lkpk2AHhsVUVhRMEjGfVNoBFR7GNCI=;
 b=VsUVSqnDSsgORwT8qkEy2UcpOC0QQZNSw8pZaxSrrPsLwNX+5eJ9xmUMuOR9eQhulT5vjyS1qSIQlpMwjLz6H730A14mGLj4+BxdxRRewXb8yNYFdWaHnos8/22jKUFjQgFfcIRnSxJT5E2p1bT+/22Sk5MdFXkAm12eX3eT9sgRcdokMUMOhn6eiqjF6xH5b8Vw9p/TPyT0AAX7MgCfjwi06UlbFXJWwct9uKrBzNva5Ten+x5VOOi1Yew7Q2FwhmnXnKkx9tpyeZhCR8aX5pfstbzcjyowCHATQhjKCxr7IEW6FAkbGL3Rp3autazroRQwzMLqCReW/lOMJLtv1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgP3k+AsHz4H+Lkpk2AHhsVUVhRMEjGfVNoBFR7GNCI=;
 b=Pn5bD3brVfwzWlyAQMs5R7OcDs9LzDVxWiyutmhuE6rsz68GByFjCTAtj5Ua497IoYwWtpih453lTNxsopJiRdgwuTy5RC6iaX2wm9OTaotp3PXc1FWB/TLbGgtA1cG88vBBWh0mM5skaq1wWtjY8RISWESjaD8ifNcIBC9rHpM=
Received: from MN0P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::10)
 by IA1PR10MB6758.namprd10.prod.outlook.com (2603:10b6:208:42e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 11:05:19 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:531:cafe::f4) by MN0P222CA0009.outlook.office365.com
 (2603:10b6:208:531::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 11:05:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 11:05:18 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 05:05:18 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 05:05:18 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Feb 2026 05:05:18 -0600
Received: from pratham-Workstation-PC (pratham-workstation-pc.dhcp.ti.com
 [10.24.69.191])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 616B5Guq686839;
 Fri, 6 Feb 2026 05:05:17 -0600
From: T Pratham <t-pratham@ti.com>
To: <u-boot@lists.denx.de>
CC: T Pratham <t-pratham@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>, "Vishal
 Mahaveer" <vishalm@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Andrew Davis
 <afd@ti.com>, Ryan Eatmon <reatmon@ti.com>, Neha Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH 1/2] binman: introduce signing-key-path etype
Date: Fri, 6 Feb 2026 16:34:38 +0530
Message-ID: <20260206110439.1236201-2-t-pratham@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260206110439.1236201-1-t-pratham@ti.com>
References: <20260206110439.1236201-1-t-pratham@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|IA1PR10MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb0b69d-71b3-4788-e6d6-08de656f9d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2mNdLWTMun6E80hY/7MQ0t2SkUa3CvgKJHYsNKb3q/c4YPtew3fDG2fx5Oxh?=
 =?us-ascii?Q?grPiukjqu5Hsz+Cj5bOxzpIIUthVwlLyUwEsu8Ywkx2muj72jwq4pKgkszGX?=
 =?us-ascii?Q?H1PUlDdwCqGUZFEX8ASkQM9Oi8Jzxb9rciwIwHCkH32poe/5kYvxEvJ37f53?=
 =?us-ascii?Q?rtJH8KwCfUa1xHUoMhiuJgh88mrlevYk5UqhdSqUIINsJypagEfTMQ4rSFMe?=
 =?us-ascii?Q?f64ImdMBb4RV7pnHwCWTfIQUf2wikzOw2i074i0fqrYng6kGo8TL8y+QEEhj?=
 =?us-ascii?Q?OMD2pwtCoJMD6EyN7K28DM9oERohC+D5VIiyf14io8VET5id55ON+O5jmErB?=
 =?us-ascii?Q?NOQADlZBYBu92cv9zUlaRIdsSYfAbABVzmOVJ6A3myDcJVC010E5lclpp9G4?=
 =?us-ascii?Q?+gDczsZ6sKN3rFmDEBEqWWRoMo/VLhQfoRjNsOHp90dvGAvszrm/XYIyGNd1?=
 =?us-ascii?Q?UVwggvDZlXm8AwWyD1ACSmQqr+Ab3U5xzRC7n0kBRdiEeDl+DLtjK2NtqGpa?=
 =?us-ascii?Q?SSS3kUGxWNdLsN/GI8VzqvwaXKs4SpasQJ/8/E9iqLPN2IBwDtFyYles1OfY?=
 =?us-ascii?Q?kQx0QCzK1rTfemyYO2Y3IBIHXVs20WPRzG/U3Pt7mNj9zFwTHnmSe+xZyamu?=
 =?us-ascii?Q?jrOlqYZJWzmqaV82U9yQO017mZM7xRo1QTN25HRw3rSGzIv24i6TGjlXkmv4?=
 =?us-ascii?Q?eJSxFw5Ue8gEbkDyrLon38P/3G7ly/pTn3Q6DSYdpuc2TmRuyYOhJaAkQh1N?=
 =?us-ascii?Q?fe+LfPii80xnLsJKaNaqxatx8gYG1yp+v21gBq4bcQ4hWqQ54HFf9RMVcCpK?=
 =?us-ascii?Q?XjRu6evxCDpGmJTQWgo4g1HutomMyZ/RPTswbilEPtkiG7covTM9Dzn8ZRmN?=
 =?us-ascii?Q?KNj5Tu6pqAK8Ip5atoejQkeX3pUtojrO7W64ztN944L/QmUBrM+1OgqMpXsd?=
 =?us-ascii?Q?+Ke+/A7pgQCDTUPZn+ttvxSquw0Dl09SBp3zSWpmf2LmwyxLZm5f57EnzPIB?=
 =?us-ascii?Q?RaJr6lkp/Lude94CSnTmSMQ+avapp9bPO0/tvTKj9uVUirM+YEY2F9GWULyE?=
 =?us-ascii?Q?RkWdVHq3s7+2MkqZN2Uo9Tu+OnwweP7iwsLdRDNPM91Wl9uOnmsOQZLPq0bf?=
 =?us-ascii?Q?WimfLSG5kz3qYmzZR6li+thfX3278VYOVdKGa26pvwo8vSmsRLIvJZF5kt/0?=
 =?us-ascii?Q?/e6K4EpsBGc2c7WNZ0VFtg9SbIBkFn+GqtYtxWc5NFnJvr0lC6CAbdQlV33E?=
 =?us-ascii?Q?zWRGgK56LWb6huRPWgKLvOukCMVDR5eASfzKnKbq0PogrCMYCLqYMsms8N3L?=
 =?us-ascii?Q?Of3qzIfz58nbitn6lKyYL1IjURN5fztA5++7laVwpdZZ2k2pwpZwjMA2EPZv?=
 =?us-ascii?Q?6x6yfnH06xJZPBF5e62FhDhInCNyI51Cy8SXKhjcH/YTYZ6h9+0FsQq8KPUi?=
 =?us-ascii?Q?u8lmSbaAtGGN/VhVAYDbmxHuGgq4HAplwKsq4wHI+iMKE2p8iXVMvC187fLd?=
 =?us-ascii?Q?w4oRzWQ4OzSNupcUARhvakDeopoEVs/b4uI+cHsRsSi8jU5hF1HV1S+bOAgC?=
 =?us-ascii?Q?TMpMToa/XBVXpMgIjjp7KREX1iouSUnnRIS2xUlO443PhsmhCupwj8QiM7io?=
 =?us-ascii?Q?SA=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G7ptRrIZdCssl/NOWtTg2729dTZuFHzkh5UG0gw2eSe30h2agWvM8fToLFcZYManJvZnW8MmN8TjlEsGzcNKbM+gtq2IHbWNs0+zmSW+NCTA433RhP7cyi3ySHQBuwbShf+YpFPw+aFb73qkIqh1FbLpB/34ZkGCe2b8iSZkF5jDtnV6gWr70C/sBdvQe0OjmbVWkDY59mtMcdn/ULWlVcZc1rNu9JBunW8yERKwfdkBfrgO+BVwRCtqaBCsraIT18EWiEpJCe/lqCl/xHo0lMBpjqZFLC3j+EWNNjJFLvhSTQvyzh/T2mCiMPKkiji6SNWjR/1JM2meGuSukoFCdg8M/E6f2LYBVxcUeQsCSNRlSlIHQaKRGY0V5ZaGdE8TNL30XndOHxUeQQuHPlm7eZFZd7BfiF5RdxtGk4L1gshbXrYhGQPpFK7PrQS/ZS2P
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 11:05:18.9338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb0b69d-71b3-4788-e6d6-08de656f9d72
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6758
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

The image binaries generated by build are signed using a key file.
Currently, for k3 SoCs by default the example key stored in
arch/arm/mach-k3/keys/custMpk.pem is used for this. Changing the key for
any purpose (testing, production environment, etc.) requires swapping
the key here.

This patch adds a signing-key-path etype to binman along with a Makefile
variable SIGNING_KEY which can be used to provide a key file directly
with build commands.

Signed-off-by: T Pratham <t-pratham@ti.com>
---
 Makefile                               |  1 +
 tools/binman/entries.rst               | 23 ++++++++++++++++++++
 tools/binman/etype/signing_key_path.py | 30 ++++++++++++++++++++++++++
 tools/binman/ftest.py                  |  7 ++++++
 tools/binman/test/351_signing_key.dts  | 12 +++++++++++
 5 files changed, 73 insertions(+)
 create mode 100644 tools/binman/etype/signing_key_path.py
 create mode 100644 tools/binman/test/351_signing_key.dts

diff --git a/Makefile b/Makefile
index 435a4bf372d..2c7994b8c41 100644
--- a/Makefile
+++ b/Makefile
@@ -1697,6 +1697,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		-a vpl-dtb=$(CONFIG_VPL_OF_REAL) \
 		-a pre-load-key-path=${PRE_LOAD_KEY_PATH} \
 		-a of-spl-remove-props=$(CONFIG_OF_SPL_REMOVE_PROPS) \
+		-a signing-key-path=${SIGNING_KEY} \
 		$(BINMAN_$(@F))
 
 OBJCOPYFLAGS_u-boot.ldr.hex := -I binary -O ihex
diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index a81fcbd3891..0f2e0719221 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1986,6 +1986,29 @@ available. This is set by the `SetAllowMissing()` method, if
 
 
 
+.. _etype_signing_key_path:
+
+Entry: signing-key-path: Entry containing a signing key blob
+---------------------------------------------------------------
+
+Properties / Entry arguments:
+    - signing-key-path: Filename of file to read into entry. This typically
+        is <file_name>.pem or <file_name>.key
+
+This entry holds the private key file used for signing images.
+
+Typical usage of this is to provide the full path to the key file in 
+SIGNING_KEY make argument during build. If this is not provided, the entry will
+fallback to using the key file specified in the binman node filename property::
+
+    binman {
+        signing-key-path {
+                filename = "default_key.pem";
+        };
+    };
+
+
+
 .. _etype_tee_os:
 
 Entry: tee-os: Entry containing an OP-TEE Trusted OS (TEE) blob
diff --git a/tools/binman/etype/signing_key_path.py b/tools/binman/etype/signing_key_path.py
new file mode 100644
index 00000000000..a68b854b7e4
--- /dev/null
+++ b/tools/binman/etype/signing_key_path.py
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2026 Texas Instruments Incorporated - https://www.ti.com/
+# Written by T Pratham <t-pratham@ti.com>
+#
+# Entry-type module for private key file for signing images
+#
+
+from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg
+
+class Entry_signing_key_path(Entry_blob_named_by_arg):
+	"""Private key file path for signing images
+
+	Properties / Entry arguments:
+		- signing-key-path: Path to the private key file
+
+	This entry holds the private key file used for signing images.
+
+	Typical usage of this is to provide the full path to the key file in
+	SIGNING_KEY make argument during build. If this is not provided, the entry will
+	fallback to using the key file specified in the binman node filename property::
+
+		binman {
+			signing-key-path {
+					filename = "default_key.pem";
+			};
+		};
+	"""
+	def __init__(self, section, etype, node):
+		super().__init__(section, etype, node, 'signing-key')
+		self.external = True
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a53e37f31b3..8383db567de 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -109,6 +109,7 @@ TI_BOARD_CONFIG_DATA  = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x
 TI_UNSECURE_DATA      = b'unsecuredata'
 IMX_LPDDR_IMEM_DATA   = b'qwertyuiop1234567890'
 IMX_LPDDR_DMEM_DATA   = b'asdfghjklzxcvbnm'
+SIGNING_KEY_DATA      = b'signingkey'
 
 # Subdirectory of the input dir to use to put test FDTs
 TEST_FDT_SUBDIR       = 'fdts'
@@ -238,6 +239,7 @@ class TestFunctional(unittest.TestCase):
         TestFunctional._MakeInputFile('rockchip-tpl.bin', ROCKCHIP_TPL_DATA)
         TestFunctional._MakeInputFile('ti_unsecure.bin', TI_UNSECURE_DATA)
         TestFunctional._MakeInputFile('capsule_input.bin', EFI_CAPSULE_DATA)
+        TestFunctional._MakeInputFile('signing_key.pem', SIGNING_KEY_DATA)
 
         # Add a few .dtb files for testing
         TestFunctional._MakeInputFile('%s/test-fdt1.dtb' % TEST_FDT_SUBDIR,
@@ -8334,5 +8336,10 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertEqual(len(subnode4.props), 0,
                         "subnode shouldn't have any properties")
 
+    def testSigningKey(self):
+        """Test that signing key is correctly passed using signing-key property"""
+        data = self._DoReadFile('351_signing_key.dts')
+        self.assertEqual(SIGNING_KEY_DATA, data)
+
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/351_signing_key.dts b/tools/binman/test/351_signing_key.dts
new file mode 100644
index 00000000000..e035f61a242
--- /dev/null
+++ b/tools/binman/test/351_signing_key.dts
@@ -0,0 +1,12 @@
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		signing-key-path {
+			filename = "signing_key.pem";
+		};
+	};
+};
-- 
2.34.1

