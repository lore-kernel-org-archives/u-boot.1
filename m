Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E57C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 10:30:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11A7F81EC9;
	Wed, 29 Jan 2025 11:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="gGMQ/jyR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3D0181101; Wed, 29 Jan 2025 11:30:19 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20702.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::702])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A02F81E8C
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 11:30:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fm3qu2zeUqHIIJ0HDU1FWrH9SLkXa3e8t04GS63WOjQWvWCiPPfFqb5vNNiUnojhHQ0EAglAm1o5lwmAJyHjR3D9dMbHdac4N+g1AjKPV8jnaUgi1X3TrYSLKGA0B3qhE5id4pTIA3wGsdJvFKLbe7AVRGqa0/TWS1UnMlDzE8r0ByBzzLR4BDQ1kNHZu2vSbJUoPjDNUOS7yfChop0YFworiwivP2y+ItNznvz1TleCVdk5fEUtHuK63tXJ8irPaMBP7PHWMrCH9dP+MVP1zwT7GH4Y+XT6zf2XwYb3uscHJ2waFUpjqpJiTOX0lpCCMLjuivmb0zZPmOvre2X4mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXsmTGmY0TlDWQwP8Gh8sTMy99CNytpStmigIBj1Fr4=;
 b=ofaaX4TfvjcFJ5pxBFTNBcEVoFb4ixPyQwFBT5LHick6eNZTwnoEYdGJAQBFa4Ww81Un/iTxrtwEDqILvFCYgB1c2yWw8lMwqH0SU2Y3gjLDbEb73jF/XRuqd6ow81/XXmGNL0IOkL01UJsopz9ylYWf/6sTRhqtZRAJqbkt88dvUboeF5h7IDl0DRFmkOtc11a3yuLIBBDZyhPoGOLYIFrZ4q1Tv8du9qxyqcVVfwvja2cYLQ45c46yUoRAE51s+1vN3P8eh+XL+uZh28Jy9uPMF5lHmxLrz7dMyzATaLMVCe+88qAIIeF9SypIkU76e4dQui67RkGlgJMDi/epjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=chromium.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXsmTGmY0TlDWQwP8Gh8sTMy99CNytpStmigIBj1Fr4=;
 b=gGMQ/jyR+c2KbvX6MOmRnRvnOWqghhWJ8mqP3CK//ASzoko9eZGxHSwwvpdMtLeQ+p5tPahzCrCp0DPK/vE128nvp4iKlQGF0DZPcOZ7Jo1n9gEwfZ/esZBHYjipBXKM15ovVE289FdGjPHI2mTtdtmyxb0urQuhnaZiuyFf0T57wQKgN/9LVfUlb3CnHV2TvbSrRil3et0TcopKOUYEHJO5KP6fCNMvMBv/TTd6jZsI0+VbvIhAY6Ge02kSl+nH5qO3ayB6KfBL1U/6YwBqDVvleZ7asXeD8i2GDH6sAp8wfot/ZTPH2PU+POZ4ph9rAMWXZIIkNjAXPi1ciTm2bA==
Received: from AS9PR06CA0162.eurprd06.prod.outlook.com (2603:10a6:20b:45c::31)
 by PR3P195MB0925.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:a2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 10:30:13 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:45c:cafe::5b) by AS9PR06CA0162.outlook.office365.com
 (2603:10a6:20b:45c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Wed,
 29 Jan 2025 10:30:13 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 10:30:13 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 29 Jan
 2025 11:30:10 +0100
Received: from lws-moog.phytec.de (172.25.32.60) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 29 Jan
 2025 11:30:10 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 29 Jan 2025 11:29:49 +0100
Subject: [PATCH RFC 4/6] binman: fix faked optional entry handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250129-binman_faked_optional-v1-4-a4534bc67cbb@phytec.de>
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
In-Reply-To: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <upstream@lists.phytec.de>,
 <u-boot@lists.denx.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.60]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|PR3P195MB0925:EE_
X-MS-Office365-Filtering-Correlation-Id: 89a333de-4d56-4eba-ab0a-08dd404fea5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWNIRmtjbExVV2o5K3F4ais1OHJTVzNDQm5aVGFhQm1vb3kreTFzSURWTEtB?=
 =?utf-8?B?TFl1ZjhJSkZCRUZiOXVkWDhEbSticVR2SVNUQTdMRi8zdUszQ0llYU1PbHJP?=
 =?utf-8?B?UlZacE54ZUpMOUdCKzdmT2lRZVZpbFpHaHpwNnF6bkhlU29scVdHRmJOMGpR?=
 =?utf-8?B?VVNQZE5QbmVWYnhPNmF3cFE5ZWkzVFhwMHpiTXVMeGc4cjVmQ3loNUNYWXlI?=
 =?utf-8?B?bVV5TjNDRzYyOW9xUGtkV0xKS2ZkWW1xejhwVTBsbkZMNGxPZTYrK3d0OWk3?=
 =?utf-8?B?S2lFVExvL1RGS2hsQU11UGhoOWljNTgrTWNGVDBra2MwQnF4Y3ljZjN3UFp4?=
 =?utf-8?B?QmFwSUR6bHNSU1lkaWNQYWtta1J5TGh3WTBiY1NVZFVkb09IcXlrNnBYbXZX?=
 =?utf-8?B?UmRVNThLaDZJYnp3SkhBU25DRkU3U0tOdDdDTGpOd01HUDl6VWhtdjdxbW5D?=
 =?utf-8?B?UzdJaUJVV1ZwTDFqN2xZWUR2SE9BQ0x2aEFnMkw0dHJpMllxWDJ1ajYyZ25V?=
 =?utf-8?B?eXIwTHhEN0tyd2V2Wm9mbHpmWndwcWNCZlljQnZKNy9IeDVleXBUQU1hTitw?=
 =?utf-8?B?Yk9URWRDb2R3T0d1ei82eFBXQkZ4ZkEyaXJpdVJWNGNzYUZadi9CdGlXUXU2?=
 =?utf-8?B?S01RenB3RXc3MjdrcldXYm8rSTlTNktLUUZVTFpIMTdzT0JSd1hxS21pWDkz?=
 =?utf-8?B?TzA1Q3JwK25TU0ZWU3d1c044bG45emx3STczMWRLL2sybVdtMmFua3RTK1V4?=
 =?utf-8?B?WXlDQzdRaFRTQzFFTFlEelplVCtQTmttcWI5Tjk3MWtQbDl1ak5pelNRWmQy?=
 =?utf-8?B?R1pheGEvRW8wdnY0dGZjT0ZnSXZrdHZ5cUl5Wi9yOVdxL3JBUHhYNExhNnJD?=
 =?utf-8?B?WHZDNWlrbUVPWnJTbFpBeHFKY1k3ajZrdDczTk5oaEpVWW9Yd2RCMVk0RDJQ?=
 =?utf-8?B?S1UwMnZsWUMxVmRzSzdvd1I5d3FDMkVXb1huSlpFQmE4a0V1NVRFWEdiUnlU?=
 =?utf-8?B?VjZQcEY5cEh5TjBudXRsRHBvblBISXFqR2d3em9yRklYT095QTR4d29heVJB?=
 =?utf-8?B?OXhVQ1oyM2JnODExbnNreENPWmM5eEVIUmRjS2JXVFZGVlhGUGZYQ1dqRzN5?=
 =?utf-8?B?SFdDeDd0d0UxWWx2UERiV2VWV1NrSENIcUd2d2oyVkEwdW51Mkl1alM5SFIr?=
 =?utf-8?B?UFE1UDR2dnlUZGs0dE9kaENZNE9iUE1vbnlNbWZwc3pDalFoTWVncjA2N1h5?=
 =?utf-8?B?TGdZOXNzdXdQVGRCZnEzZ2R0WHJxRXZuUVBKZjVaN1ZtbXlJb1hvV3dKSXRh?=
 =?utf-8?B?c2tiRTZZTkYxK0hoTnVNNzI5MHlocEU0bmtCQ3k5WjVJeEJ1L1dZRnh3cllE?=
 =?utf-8?B?SHJBTFZrajJDR296eFpwQ2VSTDZSZnErdTdTZ1d3U21UYSs3VUFRT0dETW5h?=
 =?utf-8?B?cnZVZkZ4d2QvSllJOGdrVXFZUnQ0Z1NjVjhKZTlEc2Z2eW95cUJ1b0t3WlQw?=
 =?utf-8?B?dWcvTElaTnJ6VWhMbWlsNkxZTSs3RzJKUk5Ob1IzekJrWUo1dDI3dmFrUEl3?=
 =?utf-8?B?N1I1YitDWjVqSzNQY1psakhNSTI5MUFQblVNbGNIZEVPaUUyRFZqSFRmSG5N?=
 =?utf-8?B?WlcxY21vQXl4OCtUVjQ2Qmhnb2FPSTFYclNobVlPclVLZ01zbmU3L1pVWUFS?=
 =?utf-8?B?MG94YnBFYW8vRmZBOWFtNVhpeEFqN05MNFIwaWN0Mk9kRzNUc1RRZlVDYk04?=
 =?utf-8?B?OC9NeUduaUszZWRKNDVFRXRONGVhaHJOWnBqdUhncXpVdy9SRHNVNTRPdmU1?=
 =?utf-8?B?V1dpbWZlVFBWUjVJRExYVXhPVnYyMHI4WUlPUm1XejVuMmhxVEYxeVVOTjVy?=
 =?utf-8?B?V1ByK0daK1FHc1VqWkFEdXhPSDZPL0xIdHdGeE52UGo1RlBXdm9TemJTNjVC?=
 =?utf-8?B?MHRQcEdYRkNsamV6RitKUjRQdWpNelZMVC9SYjNFdnBXNkg1SWh2Rk43QW9I?=
 =?utf-8?Q?+zy7wsHbT24uTL2iAEJp/K3cQYKKIU=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 10:30:13.4414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a333de-4d56-4eba-ab0a-08dd404fea5a
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0925
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

When having an entry that is marked as optional and is missing, the
following output is observed:

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

This also fixes the testFitFirmwareLoadables binman test:

FAIL: testFitFirmwareLoadables (binman.ftest.TestFunctional.testFitFirmwareLoadables)
Test an image with an FIT that use fit,firmware
----------------------------------------------------------------------
AssertionError: 0 != 103

This test failed due to the exposed bug when testing with faked external
blobs.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 tools/binman/control.py | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index e73c598298c..defab760ec0 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -641,12 +641,19 @@ def CheckForProblems(image):
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
@@ -656,6 +663,12 @@ def CheckForProblems(image):
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
@@ -663,7 +676,7 @@ def CheckForProblems(image):
             "Image '%s' has missing bintools and is non-functional: %s\n" %
             (image.name, ' '.join([os.path.basename(bintool.name)
                                    for bintool in missing_bintool_list])))
-    return any([missing_list, faked_list, missing_bintool_list])
+    return any([missing_list, faked_required_list, missing_bintool_list])
 
 def ProcessImage(image, update_fdt, write_map, get_contents=True,
                  allow_resize=True, allow_missing=False,

-- 
2.43.0

