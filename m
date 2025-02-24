Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91173C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 21:21:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76AEC80F88;
	Mon, 24 Feb 2025 22:21:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="plq/hqH5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2300F80F12; Mon, 24 Feb 2025 22:21:19 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1957580FD6
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 22:21:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbaT9oLIZc05GCj5Fu2vFhqz1pEEZLb6rmUs567a0uMjffXFlq36NrAPmH+koXwK94tVhU+SdGAKwzm+/7skLnxvn7bhxkt11ElMSYKs4tBXrSvwZgzsd3WzJNM9/34K+PD23WDWtB4IcIs9APO7jJ4Xw3ZKVXie/eNZwmfDxGGGXuNVGUZRKBqM/gOrV+o4ulzHDBfu6orc7X4G9jmb72XyLwvcDQuAMqslMGplhSpm79PeQ/HetVk/9aCZAKZePTF9NVWZ8OHci3i+OAOLMcPzJyJjDGmzmSvxi0S6thZG1cpFiSLiIX+bDKWScAQHE4If6DN4zUIkkpTdNnv3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUZYD/4qRSJs2iOs8iJ4DMe/Vmj7gfptMBoktTyP2+w=;
 b=quYF1socOZBNmcFIY1SBZeDVE8Gm49SCRXctCtvbPTl2yIS+fBp4j6hi6orhORqRdiryIa1Pbg30j5eRmQJIcdCWfYcr/MSW8HLVk/FaYftrlwC2eGDrlogqsMajZtAuBXKJ9K+0vWBVsMtKBsk4zwNemrd7mTdzeTt19CxeKHBNNivskYOCJjf4FOvaoknLCXmzeZTsLfQ59D+WOkf8p6ucArZOpNTZaV34cO5QUempcn9kxnadBx0TAsq05jYa+3Dmrwurym/9tBlKPOr8ErA3skIwIvTySS5yqDZ8VKbZQ3i8mXP7J2m8gv0T7F2OpZqLH5z7xZm0ipi7AT+Fcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUZYD/4qRSJs2iOs8iJ4DMe/Vmj7gfptMBoktTyP2+w=;
 b=plq/hqH5wXQ3QKqsnR9ZKbwWjcP7K2wOEOTbgHdSCugO/Ne32PxIa0QvMwhwQQhrIY0sOzXNai6X5YnEW8AVclVaIjXJBV8Rr290EQfWtSV797f+u9wsA4UElF4ykD1VMY2G0U/A/vXCYz/SleqVOU1fjxIJ+8yOzJuhX9O6uOub4SiSxNceTOCAJrumGJzCZGVHM8BaWFsMafENOS3ooME3GNSlch3gQfnLkFFBUb7xxvAKWSTe3CB4TPzTfKmsl5zv8AtA75Z3Qfs9OCPlemCGe0XS0cwPGc32/nfn4AJfMpegI4ZwwclgJLLGBhffZw1M6BmbZvGLyP9VlUxR8g==
Received: from AS4P195CA0017.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::8)
 by MR1PPF593E814BF.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::644) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 21:21:12 +0000
Received: from PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6:cafe::4e) by AS4P195CA0017.outlook.office365.com
 (2603:10a6:20b:5d6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Mon,
 24 Feb 2025 21:21:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019232.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16
 via Frontend Transport; Mon, 24 Feb 2025 21:21:12 +0000
Received: from sah2lpt245.. (unknown [192.168.72.99])
 by proxy.softathome.com (Postfix) with ESMTPSA id 74C2D209B3;
 Mon, 24 Feb 2025 22:21:11 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, paul.henrysd+nodisclaimer@gmail.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v2 6/6] binman: Authenticate the image when testing the
 preload signature
Date: Mon, 24 Feb 2025 22:20:55 +0100
Message-ID: <20250224212055.2992852-6-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224212055.2992852-1-paul.henrys_ext@softathome.com>
References: <20250224212055.2992852-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019232:EE_|MR1PPF593E814BF:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 560bbf60-4ce3-41ac-72ad-08dd55192a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QKBImfBEs0QX7ZFbttraxmJYTiKclsgCdm7BzhbfoAl6sulTUnslg4GI6KpM?=
 =?us-ascii?Q?UeiAwSjeQg7DVq67hn+fksBcFmwuZ+84SRrM4kjq13Covi0KuRBA1JNZvrp8?=
 =?us-ascii?Q?XOUZOrZNL+d1JcYD0qvBC1OM5epwNdQTHfcqeKoc0vPakJwMdnTGlAuAnRDP?=
 =?us-ascii?Q?J5xDVZTEmBg2sYX/r4Bqobo9Ha79d77dbIQutk2rzgPUjo0CYoywyFVYkg+w?=
 =?us-ascii?Q?ZCxpKWpJv1TqD9f0qO6Xry4sFfhSIFrMLS11ugXDnxXBnLiQRTa77muZSXAC?=
 =?us-ascii?Q?WlHE419r8QAGO4wL/lfXH0ayhyQKd6kwekEi4XCG+uPdxpuGIrd9gPNGotsr?=
 =?us-ascii?Q?80U67fAG3PRVujPcvopLqZmQ+J53e07ilzfvELWZXUij+i4xnhlGkXIey9A6?=
 =?us-ascii?Q?Mc4KDtykfrBI0QOeE6tpniWnIdCvnp5sQ+48WuzqtK5R/oQ+C2nizXYx7fke?=
 =?us-ascii?Q?B0vVwaYNBGoObXre3nk7Q9keOobCM/vdvc7AlKRCMvsQZ3SW+1lcwGQO/OAf?=
 =?us-ascii?Q?ojMqw8wVI8phlKftYSmuiPF7BGr7veEOoz1ORZ9fnWVGbVioCKThC0XjVRO7?=
 =?us-ascii?Q?OPm9ZFqIExCcNG/4qRgcpXTORozIvPVjRCUG8Qj3vWpTZ91KQ1zXYbm7WfUA?=
 =?us-ascii?Q?cmTsdlw5Ytnu/GbrgdiY6hsWbIKIBF9IawD/eIefouQRw9mnDFv371+MGP/p?=
 =?us-ascii?Q?Hmj7DzE1yId1O/JCoV4tFSM2dxcc41VIvHiPCcgr8E7FUVLnTn/LRgUhtqQG?=
 =?us-ascii?Q?5ZoRntWoLBNnCaEZyYDhyVaezu2fEcUXEIaZ64kj+WEKiwxGxCD4adpkUaZS?=
 =?us-ascii?Q?YGJoCsV+KlNxtbv5O5Yad5w6Nf4k12ZXdkd60JWRJbncc2FSwXsjsDZ1P0Ml?=
 =?us-ascii?Q?EAm8KzCyStWO+X0oLccUaHrFBi0e4ncFmTqp76rwKj1i9GsQB8nmyypO+A43?=
 =?us-ascii?Q?LxikecJrMfX4QaP7JkkCXhAQm0G+DcLpUH1fAd6fE+UekYBC4xIFhLjrvY4p?=
 =?us-ascii?Q?1e9JkcmM+z6f2h04fLzAGbmAbVn2hssMe0gqR3RVgKE9a2bly4JwQVDXmnrx?=
 =?us-ascii?Q?mpgtz4rjQwVwkrDxRBE8ScqfSNuiKvGDywPLz97QfGU1RwGi6StroPgCTMCO?=
 =?us-ascii?Q?Crgl7ggy8jXE590+YdJHPnntBDvRrYy+iv7zYvTup1PAlIZQsOuj7mC5s9Z7?=
 =?us-ascii?Q?PacYjuBRF+zHXpJkOpwFVyFz7Vkx3b6xVkzcE40vHpmBGNOok8KJcq7mkQT6?=
 =?us-ascii?Q?mOLHSZdu8dFLohk/1Vso8xiqAiOobt6mKRW/pH0fZr+h4Pbb5OhfHeE/4rpI?=
 =?us-ascii?Q?6clAc6nhGGIcM0yds8Kf7wwcXlaUx9BdHYQ9mqLl7hWYk9TmIzenVToUQAHr?=
 =?us-ascii?Q?tuTkJVF+DGnPUKUkx5Q/MVps/o7G5a0aEZmNuXtAPYosR1UpkyJKN2aNjWZJ?=
 =?us-ascii?Q?c9gJQVRno+OwWYnosIR1O518NNa+zrualvr95X5Muf/Oy5UtI7x86A=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 21:21:12.6240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 560bbf60-4ce3-41ac-72ad-08dd55192a2e
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPF593E814BF
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

Use preload_check_sign to authenticate the generated image when testing the
preload signature in testPreLoad().

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 tools/binman/ftest.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a553ca9e564..8cf867fd3fe 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -762,6 +762,16 @@ class TestFunctional(unittest.TestCase):
             return False
         return True
 
+    def _CheckPreload(self, image, key, algo="sha256,rsa2048",
+                      padding="pkcs-1.5"):
+        try:
+            tools.run('preload_check_sign', '-k', key, '-a', algo, '-p',
+                      padding, '-f', image)
+        except:
+            self.fail('Expected image signed with a pre-load')
+            return False
+        return True
+
     def testRun(self):
         """Test a basic run with valid args"""
         result = self._RunBinman('-h')
@@ -5781,9 +5791,14 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         data = self._DoReadFileDtb(
             '230_pre_load.dts', entry_args=entry_args,
             extra_indirs=[os.path.join(self._binman_dir, 'test')])[0]
+
+        image_fname = tools.get_output_filename('image.bin')
+        is_signed = self._CheckPreload(image_fname, self.TestFile("dev.key"))
+
         self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
         self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSION)])
         self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_SIZE)])
+        self.assertEqual(is_signed, True)
 
     def testPreLoadNoKey(self):
         """Test an image with a pre-load heade0r with missing key"""
-- 
2.43.0

