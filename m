Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D998C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 15:06:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A40182A9E;
	Mon,  2 Jun 2025 17:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="fCDnJv65";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 437A5803DF; Mon,  2 Jun 2025 16:52:43 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E231282103
 for <u-boot+nodisclaimer@lists.denx.de>; Mon,  2 Jun 2025 16:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yan.wang@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTTuApsxQ1rUROk35aJv0yflBkdm/4D4opv5vHss5zVkIKzImtk79Z9oak4anDExEmm1vFHWMyDP9diVh6dcGJ4LKryJ+zpfp/BtPf4x6f/VjuEfuZgyS9IhRNOHysL7z8WsQJzM6Yo8rMbV1jzi/hJgXU+a8PybhdxGUbK0mPMOL2oGsf9DZzkQgLpbZtb3hzz7tz5yD9PSgAa0PkEoTRNuqmRsFM+HHipFFZzNSFHGE1Sf+yotquQYfx+GWCpvdMS41O7DGR+MxVNNl9jlJRX24TzQMqmfeJGWOuHRDh750JVtpykBaioyqnmnPJil1N4NWliEB3zCEwF8bFBu7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTaZAY/9FCMIl4RZs5aRH/aI00dM1Tx0klPwM+Nl2bc=;
 b=aVL5Co8r5Cdcus3+bbWrQan4jQOXEALkO23ct92fXNZw9AAHIvqgzkLK9rO9ijSXgoQnOcVOnRYiHVM9r0MrvfjuLTsujVJDnE6Se9CIicU3N5C/epOcJXx0DbxAqv4t64MMvZVygxde+poNsBnBrvAxtxB2WToGQSKgybOIwCK2iddQZl7IHH96jfj8AkFSE62QQACMUjQwjw59ytInuelOhq3CICQksVeEW7XKvYrvQZHYrGAmaU2tInokwN9ID5JROOyGZRCe8CykSm7cpfnnADxVAs7ilni8/HF/hrj4nOwZmA7Hn9biOMulaDLNUZNG1h+T+vwNuTrH6mB5kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTaZAY/9FCMIl4RZs5aRH/aI00dM1Tx0klPwM+Nl2bc=;
 b=fCDnJv65AxeRI0ZmEheHu1iBXhDyX4+UxsDGcnzPhXU8HKmHO3r/Sbv3LKMOlkd2zSNhyVHkHDTsYtVXlInvltK4cVJCixFZ+ra/e3chd2wRfVZ4WB8OI3Dk24ahXcSb7RF2zakWzh4u6odb4gHlVh4eVwaK5mZEa7PlOKHB97rOrN6t+kgiZFkPDV89Gd6xcIFJACzUknZF9SGnzApn+AI2TUuTuIH2dlb7p+v5cMb0E9Uz052e7v0/ktb33NUcYJp+Ig/8yAfEemN90WjP9foFp15MiIwssrjC0RbU31F/kIwxK1NSxwPod3xfyyIKVUod35T4enpfm0yi26lCew==
Received: from PR3P189CA0049.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:53::24)
 by PAZP264MB2575.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Mon, 2 Jun
 2025 14:52:39 +0000
Received: from PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:53:cafe::8d) by PR3P189CA0049.outlook.office365.com
 (2603:10a6:102:53::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Mon,
 2 Jun 2025 14:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019231.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Mon, 2 Jun 2025 14:52:39 +0000
Received: from sah1lpt719.softathome.com (unknown [192.168.75.47])
 by proxy.softathome.com (Postfix) with ESMTPSA id 1A1B02018D;
 Mon,  2 Jun 2025 16:52:39 +0200 (CEST)
From: yan wang <yan.wang@softathome.com>
To: sjg+nodisclaimer@chromium.org, trini+nodisclaimer@konsulko.com,
 alpernebiyasak+nodisclaimer@gmail.com
Cc: philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 u-boot+nodisclaimer@lists.denx.de, yan wang <yan.wang@softathome.com>
Subject: [PATCH 2/2] binman: Fix signing an encryted FIT with a preload key
Date: Mon,  2 Jun 2025 16:52:28 +0200
Message-Id: <20250602145228.79778-3-yan.wang@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250602145228.79778-1-yan.wang@softathome.com>
References: <20250602145228.79778-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019231:EE_|PAZP264MB2575:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aa0e4c48-01aa-4508-f576-08dda1e51ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5raQEDcQ2/bQ5/pVGpwU8mcPHjBVQIuh6QVYfM4pnAUjPpc0f4ZXBh2+MRa+?=
 =?us-ascii?Q?k8B/sxto95YWNw+nigaNNX+mDPuYGVBD/eh5TnzH+smTN6PLNdHZnsAOG8zC?=
 =?us-ascii?Q?6gdeg6grRraZmksOHtdNsuxaQ3eb+QPu2UtaDG0cFoxH36cP/b4MwFD872NP?=
 =?us-ascii?Q?TeWgzzi2NehRbHLLz7NjuV3ru+w3sDn8T//LMY6R5c7LKtxETMs4vgXw1W1b?=
 =?us-ascii?Q?Glw1b01OfScLmrKR4GqQxH1npaqwSR9peR+aPLcekEaINSZa3a937A9NKOHx?=
 =?us-ascii?Q?lp3bYxi4IuADH1MrUIoOoJ4QS1JY6RRwUv5H4sRAwHmQ/ffkbjPiR9pM5QYh?=
 =?us-ascii?Q?gGNu0uIhrmu1yP7C0jngAevKbM4VUJGWyEox1ydcF69aLkqiVdVgTvzxlqbc?=
 =?us-ascii?Q?aAxEQUH5xCTKQ+SVoxBMczBLZh/UAiOlyl8LqMqM+KKUEN4n/bk5wZg0XVyT?=
 =?us-ascii?Q?INkknU09ffMH90R7QuY2gjIMwrYf6Fc2B43QOul+GSAPk7AH5ku6020Nn9AR?=
 =?us-ascii?Q?jJ5b5VI/dve82ciG5vhCZ/uKdMfko+WCOiu2o3p9Wdy8NqnVU1c02m+zJY+m?=
 =?us-ascii?Q?7smGV9VeEZgP5+X8DuVD2KdM4Q9vhW4Y7LBeuOYqe5AxpKi2VAhIevLuXGRI?=
 =?us-ascii?Q?q8HPAoqFkkmEbvynBXP4s33al7hycrTKmtPSNj1u7LBNBHif5Ni4yUB6Kqi6?=
 =?us-ascii?Q?x/qRcCQsu6FOWca4zVSCvy57mkZQ52/Hp2wKTGvMn8hYgkUh5zboEwvct7Tl?=
 =?us-ascii?Q?GNK6MSxGIiT8VJnU5LwQ1KqRSLegR+LDKPQxX5xEBAWiWbfWXdXRAEXT7saC?=
 =?us-ascii?Q?yNWkjFgzwuBA3l/MlDDBjqov2Y0BR578Je5D9+PIeSPGVbfyMz/xS1gyZZfU?=
 =?us-ascii?Q?VoPU07dbfAXmh1yneJmC3jjcHbH2ZowrqiujHaioyST+5/3qaTzD/zRGy1l6?=
 =?us-ascii?Q?uY7bKdwwJIlW3n7W6bsLRUO2yfhmJ1KRBhlvpZdJOWlJIcSHNlW7HWpnfKMF?=
 =?us-ascii?Q?/UdWZjPOxZ8IM6Bf/zSq5zj/mPOl3PkMyiYCoi5WNsHCu0GDUaQEII8unfeC?=
 =?us-ascii?Q?unpwxqk1SbpMV2ghjEBfnX7OtZdeBavKAEIgSTFi2EY6A9AMQBMTOHK6Eq5O?=
 =?us-ascii?Q?+CuAFPXNeHI1c1C+XwvA1PkiWxWdsHV4taV53jr8VthPXV+46QyiLPrjFQh2?=
 =?us-ascii?Q?XZ/FTd5ccKvOJ16eAN/zfNCLD/6WPuaTFAERbBYhKxfpVe+Xl6s3BVcYsa8e?=
 =?us-ascii?Q?1novqUuXJS6idVXtg/YLMUYox5tPd83ZtiYiWwHNT0aDJA0doxFbeV660lJd?=
 =?us-ascii?Q?YRXMyKng9A/lCP2pB+VkxDJZnTmlgj/6QF7yBt/xIAk8IVA0W3pkRLxQZK+6?=
 =?us-ascii?Q?xVBG5P9tFex8ZJLWhKTcqzM7H3TkjYUrqhZogl0VBdYwesK+/O2tBN0ymQnb?=
 =?us-ascii?Q?1PntnXtX3rl/50JkpfgHwvGTYor8EciLHxXmvyioGy7H+4f2uE1oj3WW9L70?=
 =?us-ascii?Q?BltQA4L1NvpqlmiATMVRpOO85NMVQJReQ+8P?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 14:52:39.2124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0e4c48-01aa-4508-f576-08dda1e51ec9
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2575
X-Mailman-Approved-At: Mon, 02 Jun 2025 17:05:47 +0200
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

