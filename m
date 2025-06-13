Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2386C71135
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 12:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5421C82C30;
	Fri, 13 Jun 2025 14:03:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="mgmyI0Tz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D459382CD2; Fri, 13 Jun 2025 14:03:25 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2070e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::70e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4640E82C84
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 14:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ma/tsnZnRHL9PszxnBahVjWcOPLmz8vAgdCOiM5/5wVmF3ClAYMEvyazitAIeqM1ruJnumRge/0JI5hhfjJYmoyRHeQ2tiRb8VwazKa1xloVKDaEuFa94zDDEKqIAPDSqelYq3GNhSsZ7KEkGqVhbrYe/RDIkidGGydpQFV4WGJv0lUPf+uWjL1C2bvg3I8ZiJ4eTSfrcWbQJAYWJ7miVOsu/Wm3ZtF6xyMZbkNC1sXGCLBlbYi+9+BIygqoVNCnstLoo3yqZFndbf2JDtrtfU75pjcoq38Px7TXOXvzZhmX3ZE2jGVJViGjivQKWcGHKNvzNxnduim6Ee36lXGMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vjo1cCO32vzCe8J5YWQ6tkL4NOkgdTYg8B6hijRFYPE=;
 b=zE8vHmBG0fYwuTOHRfww+EJn4AyxjnsDQSVVdPuFNeAIQmc3saVCwXsaLU7uV9ebi1xp8vh42wA2S8ljeWE23pbJclZp4R6JC63NxacLrm/yco0bwxayaiklLj25MmZxu+eaWDC/P2zy1M2kPQ6dIp9/oe5Dgycb9TCwKlBBj62Z2BywWnuXtDqiFys7MUAciO1el7wXk0eYEgHMoJGlT02QU8a7lYUWcbITectnB7t5pfvMKPysvORRVX1gp1ypxGZAUDeXc9N0a9LiQw0PWcvzDWY6meVNy1DqwGkVA6xCyxS5KCoGB3eLuujBjt8Q3MbuPmoG3YJA15HkQViivQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vjo1cCO32vzCe8J5YWQ6tkL4NOkgdTYg8B6hijRFYPE=;
 b=mgmyI0TzN2u1eFJcaAVrwPyHPChfq+zINmmZOcAhtxVoeRzRxqtDKYJQvpb4T71M3EhK+8ubaKAma3oSwF2CU7oPBQxWCmcg4wqE5oUJ1CpLRkkIVbkIcjRLt5ahylzRwZWlS679FXgtVmkh+Gw5wdlwJBvq3IpetkCLtGCxA5x3c1mij6oeLf0UjDfaYAITcbK3R6N5rBlL+NTqpq9OD/3QgFc0A/gco4P1sw80cncGo/7bPHKclQT1y49tu+726RW5YAhsE9Ikk9x6UQDf45GYDZw68SuBmIrFQZeeaKP202ZdRJDAwz3sJIFzXjx0ze2qkbZ9JXu4ps5y+2lyCg==
Received: from AM0PR06CA0119.eurprd06.prod.outlook.com (2603:10a6:208:ab::24)
 by PAXP195MB1462.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:283::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Fri, 13 Jun
 2025 12:03:19 +0000
Received: from AM2PEPF0001C70B.eurprd05.prod.outlook.com
 (2603:10a6:208:ab:cafe::d5) by AM0PR06CA0119.outlook.office365.com
 (2603:10a6:208:ab::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Fri,
 13 Jun 2025 12:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C70B.mail.protection.outlook.com (10.167.16.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 12:03:19 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 13 Jun
 2025 14:03:17 +0200
Received: from llp-moog.phytec.de (172.25.32.81) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 13 Jun
 2025 14:03:17 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Fri, 13 Jun 2025 14:02:43 +0200
Subject: [PATCH v3 4/6] binman: add faked optional entry case in
 CheckForProblems
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250613-binman_faked_optional-v3-4-1e23dd7c41a2@phytec.de>
References: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
In-Reply-To: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749816196; l=3771;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=JvLTz9VtPyozIwSC3e7DwSAaKVOwYxbi48gYHYNF8EM=;
 b=SSKJgVMOJyfdsBvV0IQ6G4/UOvl8XF2hpLVoknxyJjSitGy2T3wmGSMX4LI+GDacB89LrqgWF
 ZIXedORlIgJB8n9Svz7Pjufk/H6uvrm9eJCvXicfTPrffU4+jARfLW/
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.81]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70B:EE_|PAXP195MB1462:EE_
X-MS-Office365-Filtering-Correlation-Id: 211a15a5-e60d-4c56-80ea-08ddaa72497f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1YrZVRDTFNVS2ZPbEMxQkNub2tHS1ZJMHpGU1lRN1UvL1RzemtUSmZJQXJm?=
 =?utf-8?B?YWF6NE9vZnIvSlJKNVRiSTY3a1VPeThFamE0L0ZnTkpQaWhLVFRpVmw1VVBt?=
 =?utf-8?B?OHRLN0ZoT3hGVW51YXNSaGM2TVBEL0x2dFlBaGVIS3lHWm1rMTRHekNIdTRH?=
 =?utf-8?B?WDJFcnBKVkVYQUh6cUhndzBIVkh5N2piRXMvUlRCZlV3UHNWbkpBVEorM1lj?=
 =?utf-8?B?TzB3NVNpOFJURFhhbWhEbENSL3lYbmFEK0tEOXhPNkVMSEMyVUNIUGdVQVNs?=
 =?utf-8?B?R0kvdks5NHBZbFAzWSthTFVXcHcvTnZ2dk5UZzNhMXhBb2tEYmdyYmlncDZ3?=
 =?utf-8?B?aEFqZStwVys3cjZHMkhuZlBLM1pqVDg2MUJrRVYyQlEwbFlic3lCTmJXSnEz?=
 =?utf-8?B?R1dsTXVEb1UvV1NJaE9LVzNFVGJlNytBdjRzN1lrRk1qWnBUN3AwWnpldUxH?=
 =?utf-8?B?cjh2eFhGNURYRTczdmtnelFXWk1RdDVteFcwNmFSckRUNVk4YWRFaVJMdi9K?=
 =?utf-8?B?YThsYTQ3amZzVlFwcysrV1lWYndKc0tDWDdmNjdWZWJJb2ZIWjdJbmpVU2x3?=
 =?utf-8?B?RXZVQW1MeFBxeTE1L1NBaEZXRUJ1RUk5TmN2cEszeHRnVGNhV0VET0srSzZX?=
 =?utf-8?B?VmxSejFsMkduMzhuYXJtaEtscnNmTTJZWVNQZ1Roa0JCZU9FZmtQbFN3RGlx?=
 =?utf-8?B?TVRGMXJRRmJGS0Q4T0FEYXREaVlCU2Frc3hMcWpKQVVhcnpTRmtIclJ3d0Z1?=
 =?utf-8?B?U2dXeVVOU3lNT1EvaE9OU0MwKytnM2tVcndscCtDUWN0bC92L0hXcWQ1U1Qx?=
 =?utf-8?B?WDAzclBWZWozL3ZlaS9BRXJtQkdYellpV3dBNmIvdnVDWUlPR3pKaldhUU8x?=
 =?utf-8?B?d2c2R2NZUCtoSk52bFRKeFRiK04wM0dzT0FTSUZndTFtRXA5bm1iOFdDcEhG?=
 =?utf-8?B?Y1I0aE5xeDdWT09Qcmw1ZzJKUmR1NEl4YzlBYVlVY242QlB6UmFSaFdiemdB?=
 =?utf-8?B?dE9QSlBPa1BtVWJ0eWhHWnlZQ2tqTUVPeG5aemhGV0haRm4zamtudGN6aEpt?=
 =?utf-8?B?SkpydFcxZVNwTjB1OFdXNXpPQnhubmhCN3I2a0RpWFJkNUJwUHJkZ2NPLzBE?=
 =?utf-8?B?L3ZwY2kxZHdtNW0rY3VhcVhCWERCL2c5TXlLeW1peVR1OGQ2bHV3ZGZ3b2xL?=
 =?utf-8?B?MXcvMU9KTDNTYzFzMHZLQlR5cjlVbmRaZ2UyZ0tvRjQ3d0ZhRlhna2pDQWUw?=
 =?utf-8?B?U0t1S1VTNmNvb1Z4VGtxKzZaNzRycWhWMVVZVHcyZHZGa0VtVDBUdnhKeGFT?=
 =?utf-8?B?L1BlMllvaDRsbWFXYnY1czJDRFJGWmg2dm9zSldxRGpsbzFWMzJoUEd6NmZD?=
 =?utf-8?B?QktGMmFTclltT2ViMWF3VWpvZm9EVExHNHduY0svV3A2bVc2UW5jUDNQSWZT?=
 =?utf-8?B?MDBlbnM0L1N5SG9sc01aYmpFNkMycWhXVU94WCtzWWo4RUxra1lkU3czdHEr?=
 =?utf-8?B?RW53N2EwbHNZR2hVUlJUSlMwRDROMzd2TzdmREFnU21SV2NBbVgyKzRlbCs2?=
 =?utf-8?B?NGNEdXVBTFVOcERycXZodkNOZzZJMzFwTHpqSU15RU5Vd3FIcXhsc3RFVDNz?=
 =?utf-8?B?TmE3U0hYVWMvSzRucUVPOWs1QzlYM2R3S2JINWlvd1pEMDYweU1aUGh3ZzlM?=
 =?utf-8?B?WjUzaEJveHJUYnh4bkRtVTIxTSsrcTkxSXhNcVh2OVA5Sm12MlgzcTNtSHc5?=
 =?utf-8?B?V2FXNldubmVtdmZFN200aC91WjF3OGdKWWM0RmNrVHhSUWZQaVlFdjRzTWdR?=
 =?utf-8?B?dk5iTm1qU25JUUtoSFh2QjEvMnBmSlJwTENHaFlHeXlXM2kxSWV1SVk4R2h3?=
 =?utf-8?B?WVBQYi9NcFhEdnJYSHcyWTJRekxuSEhiT0NaY252SWJlQXZ1d3NDZmJibDFP?=
 =?utf-8?B?UEcrSUN5dG0wNllldmtKR3IyYjhFS1M5djhwRkM1Ty9HQnVqbEw1T0dWYnB2?=
 =?utf-8?B?c1N4T2pjMkV0T2VBOVRtTXZxRDFheEJ4MlMzNEdPWWtrd2NmUXhPODBjL0VJ?=
 =?utf-8?Q?nphZar?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 12:03:19.2118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 211a15a5-e60d-4c56-80ea-08ddaa72497f
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1462
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
list, remove entries that are allowed to be missing. Instead add an
info message for faked optional blobs. Also reduce verbosity of the
optional image warning to an info message.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 tools/binman/control.py | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index 5a66c06d346cc74dc3e0e037eb263b6ced64a9b4..df66c527d7b4a3d168fa8ad03ab32b2ba3badf0a 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -645,14 +645,27 @@ def CheckForProblems(image):
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
+    # For optional blobs, we should inform the user when the blob is not present. This will come as
+    # a warning since it may not be immediately apparent that something is missing otherwise.
+    # E.g. user thinks they supplied a blob, but there is no info of the contrary if they made an
+    # error.
+    # Faked optional blobs are not relevant for final images (as they are dropped anyway) so we
+    # will omit the message with default verbosity.
     image.CheckOptional(optional_list)
     if optional_list:
         tout.warning(
@@ -660,6 +673,12 @@ def CheckForProblems(image):
             (image.name, ' '.join([e.name for e in optional_list])))
         _ShowHelpForMissingBlobs(tout.WARNING, optional_list)
 
+    if faked_optional_list:
+        tout.info(
+            "Image '%s' has faked optional external blobs but is still functional: %s\n" %
+            (image.name, ' '.join([os.path.basename(e.GetDefaultFilename())
+                                   for e in faked_optional_list])))
+
     missing_bintool_list = []
     image.check_missing_bintools(missing_bintool_list)
     if missing_bintool_list:
@@ -667,7 +686,7 @@ def CheckForProblems(image):
             "Image '%s' has missing bintools and is non-functional: %s\n" %
             (image.name, ' '.join([os.path.basename(bintool.name)
                                    for bintool in missing_bintool_list])))
-    return any([missing_list, faked_list, missing_bintool_list])
+    return any([missing_list, faked_required_list, missing_bintool_list])
 
 def ProcessImage(image, update_fdt, write_map, get_contents=True,
                  allow_resize=True, allow_missing=False,

-- 
2.43.0

