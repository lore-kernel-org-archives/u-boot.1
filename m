Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B79BC77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 12:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AA9882F6A;
	Thu,  3 Jul 2025 14:55:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="SJqxdOPw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEF0682F30; Thu,  3 Jul 2025 14:55:10 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1F22822D7
 for <u-boot+nodisclaimer@lists.denx.de>; Thu,  3 Jul 2025 14:55:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yan.wang@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNUFZNUTZfhBzzWuLfvJw4muuJ5/8EMDIu7JmoWIi8LXxEXSmGyptVRWy4Zutc4B6p28ylNl0HZ1HdUJqmuTatO5s2eurZ6vON/bHJBx782mkLKJn83l9NIcHGWQeADP2vAxk/rxldZZuqLIfZUIhUF226sB98AHO62g0D6wKLQzp4U6n5/jmwWQkaNj9cbMSLTAnx1ytxpsqrxxCoGzj7W5qES0qoXcAmJhBP+RqL9tURifkLQk+X5SdFnIkAWNkZT3pmd/P/loyErVtz5AVD1DvAzRORDFvDmkvl6s4JmXoDnbHnw+KdDLLF54cfBZD85CBLNQy9QKQBr/5QOJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTaZAY/9FCMIl4RZs5aRH/aI00dM1Tx0klPwM+Nl2bc=;
 b=MLrNwAu/2FspwJNcdTcKeKNz9K33ctVw1JT1VDj/nwRHCnOPCL37NqL4qe9J0T5a9B+KWnCrpov5BKoR2Z4GnsOx3JiO+SD+7JXn/Jp/gErGlcpuybXR27Osk2FJGK5C4/xZKMUni6BkxfFw2I7OFTonqZZrWkWR1wpceWMBBC2Qfb7BexcDAnxo33QH7aFK+G9u2bT7bAP1o1xUBvAB4anYbLXeI3Lxk29oQGWNiaNHRcXEctPN5CT58QaqUW5k7srA+v3cKfXNsecMqYTD7SUXzLr3JT+NdmPQqBdmikVigZh0uJQhLSC0XCZ3Rb+M1gaxib4Ogdn+AE50T44dnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTaZAY/9FCMIl4RZs5aRH/aI00dM1Tx0klPwM+Nl2bc=;
 b=SJqxdOPw7lHq3jLbuL5NDTGpWla4reUsoviwR7F60l5AHDO91XG2qcjBB9PL2QZccv6MzNBzFs5ioz3Y5bSE+loGmxugz80D65UYX5fKceYyR9X6EGmWU5Y4ql84af8PhtSCxVClnUZO/0nE2Jv85XxhyJlp0uulO7a4bUSpwjwbk0fHFUbhXmPQUHlXZIniWAAW1Na930zZuRgqdVfI20iMIuNt3eZXOzFKtV7/7f8eWtB5FtjlavuFyY72O+cprdwv1n8YEyyLSLihLDAAoOqgFh8Zfb9LR1+NiuybBhcKYMqmp8lZrKEc+AkhHOQEVtP+stZGDVEfxmixw/jb7w==
Received: from GV0P278CA0009.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:26::19)
 by MR1PPFB97302C0F.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::683) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Thu, 3 Jul
 2025 12:55:03 +0000
Received: from PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:710:26:cafe::65) by GV0P278CA0009.outlook.office365.com
 (2603:10a6:710:26::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Thu,
 3 Jul 2025 12:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FB.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Thu, 3 Jul 2025 12:55:02 +0000
Received: from sah1lpt719.softathome.com (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id BE3431FE2D;
 Thu,  3 Jul 2025 14:55:02 +0200 (CEST)
From: yan wang <yan.wang@softathome.com>
To: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org,
 alpernebiyasak+nodisclaimer@gmail.com
Cc: philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 u-boot+nodisclaimer@lists.denx.de, yan wang <yan.wang@softathome.com>
Subject: [PATCH 2/3] binman: Fix signing an encryted FIT with a preload key
Date: Thu,  3 Jul 2025 14:54:53 +0200
Message-Id: <20250703125454.61174-3-yan.wang@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250703125454.61174-1-yan.wang@softathome.com>
References: <20250703125454.61174-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FB:EE_|MR1PPFB97302C0F:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7c526df5-66ca-4af4-dfb7-08ddba30d3b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tqMmUcHjKx95K39ZKBNOgqNVl4CfEnqwAU4Wb5evWdANQtiy+2ffgLZzg7DS?=
 =?us-ascii?Q?i69tPJ9ZpRgCBRzNZGW4HFULjq8tCwXq3BBuwib/ZemNn6/4nc1ZSekW7RHr?=
 =?us-ascii?Q?v6uip7qaXWSWoOvNN7cOy6LMtI0UV5XoI39RZoLXwBW4DRG/kk2E/sixF1d3?=
 =?us-ascii?Q?w7ksgkO+k3Y6ZunAC/WMPngynH8fTobqRslilCePquJKYRtYjHDvALf2XwGt?=
 =?us-ascii?Q?P8Pn3HikzKTedaSg24iXCtKKt1EiLUdG+porCJ6FmW8oSUN/Dn+PCLLCUMLs?=
 =?us-ascii?Q?iyvMsAbIiMMnxvzjI32L/QmTC5zRSpufKihFFl+fkZLjt5Gn2BQDKr50IQr2?=
 =?us-ascii?Q?EmZYX1Qu8sp8Yn4XddKXCFKcyiyOSsJFWvWhEcFnjdziZXoedtOaDXJxvbek?=
 =?us-ascii?Q?KMEOZ1A18OE1GfTe+cYOsonjKYD/zV7P8NsrGJ/ZBRgrTSyhoMyv0KioBb+I?=
 =?us-ascii?Q?ZNUzAVHXL8z650A40pAbRZsuk89KA61Yes5xFnnQiLJh410KXvoZrUqwyawr?=
 =?us-ascii?Q?Flgcp/m3lxNboILECcPAu0L3Al2CilS3n+IwdfEBAGUpVuRSxrD+3QGMXZ6a?=
 =?us-ascii?Q?0I57a1AGHHemL7SRMfObG3FCw8L4n16wXV1kGFqNEQgIAm37DklPmV1ofL3o?=
 =?us-ascii?Q?ZtRBQdNhwMRSulWF+rWmeKfRAGnfsxkit0G0BHmZdiP5ZORe/+hEMxbl2oUa?=
 =?us-ascii?Q?H6F083CBOsNYZWTvEdYLNvoE6Ij38doaHQXwCfu3FEtngJ7fjQBqfIfdYOFr?=
 =?us-ascii?Q?pLp+zhH4nkbAY41hv6LZo+yBBbOyy8mIBn6oiOwLNlCNJOv5NSFDmR94aGST?=
 =?us-ascii?Q?Sn6+ME2nVywIhSNnXxLAyU8VidaUNI2I2byiKCq5DznFaryxI8Mpzn/+v0Kf?=
 =?us-ascii?Q?nwKNEBY9K+gquHfBD7CRgVpos4K2mz9PyOa9qP/QIdniJ7U+gKz6jvrgWFsJ?=
 =?us-ascii?Q?xUHmzYG/wpmMBMv9si2Cnr6N5zdaCaSi/ykSUNhTHpdzgr2M1/wV15L4MhEY?=
 =?us-ascii?Q?3O8mLPUrFYsMkqLcvwf7KyMcDILgrUnLqsYNfTsyL8EyMI3pribSXSgNbCfu?=
 =?us-ascii?Q?qNPbXae2OtlLzzUtPDl3/p6vjXM0TxTGhc2UUC3AcqcQji3yduNdk1/SVnk1?=
 =?us-ascii?Q?m7cIHR5SPj0YecdCYufGpn/MFWKBBRxLohJWQQLwwCOfZsUpSdnNJ/PdMnwz?=
 =?us-ascii?Q?I/Ynph4jgH9YhAyaypdL6uNILyj3FeXcpfiFcJocLBK/cDqdh92AdpBmy9cv?=
 =?us-ascii?Q?gPh4Qhwtj1Y2ukjSb2cQ4QwdaBIvKyK0CIVJhOIAGziNgey4ObXu78I5/u8w?=
 =?us-ascii?Q?MEAwTdRcuecmeXwhFQRQlFAloJRMYrRUzT+Z/UTCgoWQ5UIpJhkKaafZEgtY?=
 =?us-ascii?Q?vjUW0zUGR/FY0FmOLMjRdtXs2J/cwMAXKCEgDelc6ZKLz/2yN7arRyOuZMPn?=
 =?us-ascii?Q?n5RkMXqmuZd+9zXwLp9F5601HpD7hTId25cWptsRuusdeQQ84FKMqc1b5lBI?=
 =?us-ascii?Q?EbFKOJfN3l7vYJQyLboILRWqY1mQhsn7E1l6?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 12:55:02.8794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c526df5-66ca-4af4-dfb7-08ddba30d3b0
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPFB97302C0F
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

At the end of several passes of packing entries, a FIT is already
generated. This is the FIT with which preload header has signed.
Don't rerun the mkimage to generate a new FIT after the preload header
has already signed the FIT. Because when encrypting the image with a
random IV or if the timestamp in the FIT has changed, the signature will
be different.

Signed-off-by: yan wang <yan.wang@softathome.com>
---
 tools/binman/image.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/binman/image.py b/tools/binman/image.py
index 24ce0af7c72..0118834b76a 100644
--- a/tools/binman/image.py
+++ b/tools/binman/image.py
@@ -13,6 +13,7 @@ import re
 import sys
 
 from binman.entry import Entry
+from binman.etype import fit
 from binman.etype import fdtmap
 from binman.etype import image_header
 from binman.etype import section
@@ -178,11 +179,20 @@ class Image(section.Entry_section):
         """Write symbol values into binary files for access at run time"""
         super().WriteSymbols(self)
 
+    def mark_fit_build_done(self):
+        """Mark Entry_fit as already built"""
+        entries = self.GetEntries()
+        if entries:
+            for entry in entries.values():
+                if isinstance(entry, fit.Entry_fit):
+                    entry.mark_build_done()
+
     def BuildImage(self):
         """Write the image to a file"""
         fname = tools.get_output_filename(self._filename)
         tout.info("Writing image to '%s'" % fname)
         with open(fname, 'wb') as fd:
+            self.mark_fit_build_done()
             data = self.GetPaddedData()
             fd.write(data)
         tout.info("Wrote %#x bytes" % len(data))
-- 
2.25.1

