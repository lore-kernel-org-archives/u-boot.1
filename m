Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95868C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 06:21:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A4D782CA4;
	Tue, 15 Jul 2025 08:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="W40Kx6XJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EF2F82F8E; Tue, 15 Jul 2025 08:21:41 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::72d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3403B8277D
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 08:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1OHjFJMRdhSHBzIxfRjrIcjzOF4khjjbYeF5ADE33tQy6ruTM2LR8r2h4zKPj3LJeo5iGdkBIj6rEmCaDdyIp2RoPbD/IrahTosKFZDaJLl744mM3sJ8zFh722dV+fQgpkD7bDgdf/qTmOLKPspET2SGO/JETCea39Znr9d8qVZMSIuARselFVJkl3X4KPtJobp4CRYPRCH4+us+ZigDlVNhvV9wLi1IloV7JitVDbdbgBorzDhg4JHKPx2ZluTU9gZSrOmCQYVqNr1KsrlWQgecZDbg0R8OEj0pisI2YsfDeJXNnd4jAJEjrMIUyppTmyekymXDqwDugygAGAeHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhopDaPUT504USk0dQeXdzPq81V+jaGwYHFC7vczPrA=;
 b=llRhVK1x4TZfMiSHO1ErvNw7PDJpKGJIu4o10tkqVw4EysVTtBidKWCarU3cXybOxNTMAO0UTWzJEeNH3KzF/vP6wq7kKGwQfybWB4KfbiT8mPX2FkkZGys7YSLJpE8IlkQ/yOk0bnBraoJaN9wheXqEgz1bYutQI2mfuGi7hMPKAfpL2kP2m1jKu03LzMH4Lm+F08GjM26Bw5NGwfJUnln+oQpFIOOMmc1GrFCk8DOYFPnck7XiCyYk2t11H51djw5RgOzJ2ca0VUpVibbCKXhgg/zLU2r6ZY/kro0NSO+Vhn0+ZN21nx0U4HHraxayDqXPsaSRss41+2hj2cNxDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhopDaPUT504USk0dQeXdzPq81V+jaGwYHFC7vczPrA=;
 b=W40Kx6XJjzq7UkA1gSNSKsf0pQCUExXfNzUYJWiCkYLqT/TxgD9vtJr7Ww4SAEKMnZBZrPu1bo9lT7OnUd43CjLX9DD43Gx078bykY7K8+UaZC1CmIOo6QsnfQt8fWFnRbdk2ETFaVTAQwsDQOfMJZtnY6D7QNLewKCIYQHJeNkeLHjtNn3/Rtyn/rXWWUWFQ4+I/CX+I0jUwtHm0yceV7fO0Y8hNpLBh6/slE33roQwguPe0UpvZS4kIf2ZFz02U26x/SJ8JCzeI1i30ZB9oOP35nrVKC7gz5P0384eNdcHQCmUnlDo2TpNIG3HB7qh4aJa5VsZ//Ol/PFfm7m1Xw==
Received: from AS9PR06CA0526.eurprd06.prod.outlook.com (2603:10a6:20b:49d::29)
 by PAXP195MB1464.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:280::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 06:21:37 +0000
Received: from AM4PEPF00025F96.EURPRD83.prod.outlook.com
 (2603:10a6:20b:49d:cafe::3b) by AS9PR06CA0526.outlook.office365.com
 (2603:10a6:20b:49d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 06:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM4PEPF00025F96.mail.protection.outlook.com (10.167.16.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.1 via Frontend Transport; Tue, 15 Jul 2025 06:21:36 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 15 Jul
 2025 08:21:36 +0200
Received: from llp-moog.phytec.de (172.25.32.60) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 15 Jul
 2025 08:21:36 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Tue, 15 Jul 2025 08:21:24 +0200
Subject: [PATCH v3] binman: Fix typing for python >= 3.7
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250715-binman-typing-fix-v3-1-86739854cf4f@phytec.de>
X-B4-Tracking: v=1; b=H4sIAGPzdWgC/23NTQqDMBCG4atI1k3JRBNpV71H6SI/U51FoyQSK
 uLdG4WCC5fvB/PMwhJGwsTu1cIiZko0hBL1pWKuN6FDTr40k0Iq0YLglsLHBD7NI4WOv+nLjRS
 tRa8b0JaVuzFimXfz+SrdU5qGOO8vMmzrX4MTLQMHrrWxolUClHGPsZ8ndFePbNOyPArNmSCL4
 C1qBTfX1EYchXVdfxI0MVr0AAAA
X-Change-ID: 20250710-binman-typing-fix-a207bed6416b
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Yannic Moog
 <y.moog@phytec.de>, Bryan Brattlof <bb@ti.com>
CC: <u-boot@lists.denx.de>, Tim Harvey <tharvey@gateworks.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752560496; l=2402;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=JO4S6jitjgeKK2XdguDD2gN4cSsmT7Eo26DIYsn+M9w=;
 b=iHDrYiGozzrDKHS5yvtCPqRlsBRj7bCgDmSwBc7bFIQ0xVFxGjzji8knxSBsREmQNtaud1Gms
 PyAEGM0g077ABraKR2ycALB6g29Mb+JNsQaWjjGSg3u70aJh60JuRgu
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.60]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F96:EE_|PAXP195MB1464:EE_
X-MS-Office365-Filtering-Correlation-Id: b043f568-288b-4faa-d2c1-08ddc367da50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmhHQjE2TnM4aFRnSHFpd01mTUZoTytBekhlM3BTV1RsT2t3bGNJSkVZcVVJ?=
 =?utf-8?B?WkZZL0pQa1BiN2VjSGprZDh5b1V5K3hCMnBLb0FlNFBJdW1qMlhVV3E3RVJs?=
 =?utf-8?B?SlhvL1RZTjFSbGZycE8rY21GMFErSUhuYk9UNERMakozMlBkc3pEdzlwZlBG?=
 =?utf-8?B?a0c3MnJJLzJMSzBBdk01OVNZNWpMWEpNeXZQa0ZUa0V1dUNYNjVaRWlMZlVC?=
 =?utf-8?B?V1RvL1VMNTd4UUIvTjN4R3o2Y1R4a2RmS1NidEE2dXZZMko0MGdhTzF1cDlz?=
 =?utf-8?B?MWR2TWlXY3JMSFZaUmJJWDlTTEhvRmRBRVNBcEhBcnZuVm01S1VvV1c4NFd3?=
 =?utf-8?B?NmxLa054ZU9pcUp5eVBZc0hSd0x1TmJJdGpGTGp0cVdKR1FITzBFMGtzYlZJ?=
 =?utf-8?B?blRhbUd1OExrS0NQL3hteTRuekY3SHpLZXRRRENHMTNrVFRLc0RqbElPcTNt?=
 =?utf-8?B?c2FKcU9nWjREUXlxT1dIYmw1ODBnNjFhOFRYNXk2SnZnakd5N08rSWthdHRI?=
 =?utf-8?B?OW9pYVFqV1dRRHFFcE9yWlRkOUprVWJqZWF5OE9UYzBBTzNaUFREb2FmNlZW?=
 =?utf-8?B?Z3JTZjRLWUFZNnQ3QmFTQzVvUEQ4eWZhY0dCUTFaOWZJYmVFTlMrY201MFpK?=
 =?utf-8?B?SklraWNWWFN1RnhsUHl1aktFQ3BvcFZ2bjVXa21JNmcxZHZpbkRWUWFRZVBJ?=
 =?utf-8?B?cWlzMXhGN2thYndWbDIyc2JqMGI1L0NIZFpuNXhSaThhV3VqMnV6NHZ2NlBD?=
 =?utf-8?B?WjQ2WVVIY3pyOEkvMDFwMXRHS0VMMWZWd0kyWHdGcGpKMmtUYTJTNEF4dS9S?=
 =?utf-8?B?dFpMeUZDdGZRS0cxTzhHdzlRdXVWMVRKeXdueGJjZkxtYytvSXN3ODRYQURF?=
 =?utf-8?B?dFk2M2IxTm9NL0labFF1N0FBbXZYVlMxbFZSWjJOdDRmSTlpK082RGZTMWZv?=
 =?utf-8?B?MW54SVNLaWxpTUJyODhtcHlRMHBaME8yUDdGNHByWVBaWkx1MzFsT0hQM0Fr?=
 =?utf-8?B?QVdQNFpSWk9iMEgwYllIUFNCY2NPNU9oV09XZ3lidEJMeHZkWFJiZmpQVmFU?=
 =?utf-8?B?TTNhMlA5RnVoYlArQzh4ZlJkaER0bUdKYmR2QjcwK2p0eXJET2NGQWl4SFlC?=
 =?utf-8?B?WVpZWDYwdjZraEJ5N1JZdFBwMmRmalpycU0zbG9YU1B6RkpnV3RsMFFyUVBD?=
 =?utf-8?B?MFExNHNSVm1QTDQ2NGRQVG9weXU3RDV0OXVjaXcyeThKK0JBYmNCclFYb2R6?=
 =?utf-8?B?VW00VVZYNEo1d0JYcnh5OVE4YlFlTzFCZWI2aUs3ejhSK0sxM0hnVG9BS3pa?=
 =?utf-8?B?Um5vZy81SFRHTVJ5blhab2hXR253a3drWFcwcTRvSFFLMjBNMnlXQ0d6TUdo?=
 =?utf-8?B?VVI2UExueWdOTkhGaTRXb0dvYUZCODdUbEUxMzBhRUVGOW5XS0FuT24rYnlL?=
 =?utf-8?B?cGVQeDc5L1NVbFY3OFJsbWNyUXpQNlV3eDhraEdtc2JibUowWGJHNTI0a1Mz?=
 =?utf-8?B?OFNkT1lOTGJJNDJ2R24xbFdPdnJuVVlWL0tvcEpuL3F1YTE2aDVFcUpFTURi?=
 =?utf-8?B?QmFSN1NJbHIwRW5tYXgyTVQ4ekxEU3hNMnovbUxDeGttVW52aHRzMS8zd3A2?=
 =?utf-8?B?NXUzem5DNkdlQU1uc2thd2hmd3JsY0duVENTWVhVMG9vd3p1dk5hWGgyeTI5?=
 =?utf-8?B?ZFVkOGQ1OVNZdEhzeFprMXJCNk9NTitpbEZtMzMzQy81TG1QSUNlTncxakhV?=
 =?utf-8?B?Rk1mTjNXbmxiaVpuQTYrcVdveERYOWhFUGl3NHpSU2J4aFBmVnh0RGdWME9M?=
 =?utf-8?B?dGJ2cFVOd1NvYVZXZ3kyNmJ4aUFUU01RQnhoMHFYc25NcHJYM2FHTnhtUXFz?=
 =?utf-8?B?b2tBY0JhVVAzeEkyL3lSS3AvTkNqa1FtQ0ErSXowNytBUENKWnI1OWlORjI5?=
 =?utf-8?B?bnpzaWIrQWNyQkRSZTkrNGN2RWdlM1pFVW1Wb0tOSzd3QmlOdjJUaG4zVUI2?=
 =?utf-8?Q?vQCZQ6TThQQ/iES1u4L7LJQLsJpUK0=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:21:36.7823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b043f568-288b-4faa-d2c1-08ddc367da50
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1464
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

To get the [] annotation working with python 3.7 and 3.8, import
annotations.

Reported-by: Tim Harvey <tharvey@gateworks.com>
Fixes: 21bc3433a43d ("binman: rework dropping absent entries from packaged image")
Reviewed-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
Changes in v3:
- drop the deprecated and soon-to-be-removed typing package needed for
  python 3.6 and 3.5 support. Instead use __future__ which is supported
  by python >= 3.7
- Link to v2: https://lore.kernel.org/r/20250714-binman-typing-fix-v2-1-dbe6519c43a0@phytec.de

Changes in v2:
- drop newline changes
- Link to v1: https://lore.kernel.org/r/20250711-binman-typing-fix-v1-1-66ab075015ac@phytec.de
---
 tools/binman/etype/cbfs.py    | 1 +
 tools/binman/etype/mkimage.py | 1 +
 tools/binman/etype/section.py | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/binman/etype/cbfs.py b/tools/binman/etype/cbfs.py
index 5879f377231bf94697bea97c3cfc3a2515665b8f..9cc4b756b3f735b51d66f790cc61d77e50f18eea 100644
--- a/tools/binman/etype/cbfs.py
+++ b/tools/binman/etype/cbfs.py
@@ -5,6 +5,7 @@
 # Entry-type module for a Coreboot Filesystem (CBFS)
 #
 
+from __future__ import annotations
 from collections import OrderedDict
 
 from binman import cbfs_util
diff --git a/tools/binman/etype/mkimage.py b/tools/binman/etype/mkimage.py
index 75e59c3d3a3104da7559982f64968fdd99b7bd5f..9fba902bdadfbde3b9c50ba983a475b30aca305f 100644
--- a/tools/binman/etype/mkimage.py
+++ b/tools/binman/etype/mkimage.py
@@ -5,6 +5,7 @@
 # Entry-type module for producing an image using mkimage
 #
 
+from __future__ import annotations
 from collections import OrderedDict
 
 from binman.entry import Entry
diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
index 03c4f7c6ec74c6fa75c9362e2fecdb0e6ab568cb..6a26d687056bbb4eaece869916ea1a796ec1bd95 100644
--- a/tools/binman/etype/section.py
+++ b/tools/binman/etype/section.py
@@ -8,6 +8,7 @@ Sections are entries which can contain other entries. This allows hierarchical
 images to be created.
 """
 
+from __future__ import annotations
 from collections import OrderedDict
 import concurrent.futures
 import re

---
base-commit: 6bb0679377abb01a82db1ce69b5bf1d40aa02ace
change-id: 20250710-binman-typing-fix-a207bed6416b

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

