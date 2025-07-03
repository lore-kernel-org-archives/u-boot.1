Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A4EC83030
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 12:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEDBE82A76;
	Thu,  3 Jul 2025 14:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="AVOwD6Lv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E3DF8091A; Thu,  3 Jul 2025 14:55:09 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0EDA8206E
 for <u-boot+nodisclaimer@lists.denx.de>; Thu,  3 Jul 2025 14:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yan.wang@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dI9uFB7EChtaOf6pkRi84R1It+DxfQYARoCWIhbmwTxz3L6ly6aLfQGvZf12ooGEJlo4qIgTYuUtwGMuPoQaVC3E0+LnylkzcRq78cTQuE5x2FQncRQrGqWjAcTd9Qt0cGmBQNdZ3FE4E7Lx6OTHCuHJy17G31uD+v0zXdhtikcmPtHSrB9pHmak8b5xPTtXSwpeJuai026zRVZ3BbWeEVzBazbihiYuMr6MD13inLzlvG9IgA8Ukhv1kxx1rCPPf4it2qV9ko6dHJXh9MljLYJi9gmwj41eFYsDUvKqGzpODL7Rg6vyPwoI8xstpVkX8PT0QZ6I/j4jvONlcQ/+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iU/Unu3grGwwRHDAUK4aJzT9sN2bD3HLPrgTgokx0I8=;
 b=sID/J1dA/j8NJ1k4VNTu3IoKDksuqIsO/DVpt3BQ/aONQ1M3+iJ8ZKfr5hydK52ujhqef8LyPcn5lHk6L3IbG+S2hEkQrof2NH7OvBLK3CozuZAdz+nUpQdAbQhJrQwC6tpSmPOb//Abowjjh3kH82Bj0ecpR7qJiSsuQoMW7Zjr3ZE+prIkeWTQv/M5rKebHiFhPQ74pDhYLMCTPl1Wf0IxYZPYC8NWDUDtCyoBXPibNoeSHXtiU5o1WXhfYEksDuMkmsB+JXxc63UDjbgpp/SZoxSLqPoDxSbNDDSYluk/sVBVgGGq83CSQe54xKuZuPlqJfmazTuFyobMn8HI8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iU/Unu3grGwwRHDAUK4aJzT9sN2bD3HLPrgTgokx0I8=;
 b=AVOwD6LviLVVxqLOkO2SyXATrmE4pcvJNmLHctOyqG7WYtAi1vuQn9FPPeCmqulbr963+l/jAJZi/sjWi+Y1U9ulcTvcleKgHXuCN1FWJRIoAJbYdPD/7QD9CcC1PF2EXTBn6TSCEw5/4CS3Yr7yFtDBb3CfMUkw1RHvi9cOBbrTLAzZvIk84jD1sjMoS7b8oAfnOWALVBioNIoHcN/j7taO7hndBf5lEillnOoyklU6E5zFMfXnOCowNu5y9xz26hQKqu6MvuHTcoO/uIkNi2wDkxokRYkQFoGcKX/HTSc9ZvOCp49iR4YSIqMI1Q1mCEeBj33U8Ih9pdkCYxZDXQ==
Received: from GV0P278CA0006.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:26::16)
 by MR1PPF23691F3FF.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::28f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Thu, 3 Jul
 2025 12:55:02 +0000
Received: from PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:710:26:cafe::73) by GV0P278CA0006.outlook.office365.com
 (2603:10a6:710:26::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Thu,
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
 by proxy.softathome.com (Postfix) with ESMTPSA id 18A2C1FE2D;
 Thu,  3 Jul 2025 14:55:02 +0200 (CEST)
From: yan wang <yan.wang@softathome.com>
To: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org,
 alpernebiyasak+nodisclaimer@gmail.com
Cc: philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 u-boot+nodisclaimer@lists.denx.de,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 1/3] binman: Generate the preload header and sign the data
 only once
Date: Thu,  3 Jul 2025 14:54:52 +0200
Message-Id: <20250703125454.61174-2-yan.wang@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250703125454.61174-1-yan.wang@softathome.com>
References: <20250703125454.61174-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FB:EE_|MR1PPF23691F3FF:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 58eff97d-97cf-489d-c1b2-08ddba30d349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mR62eNwUOKBUwGZd/SJN2gg6XqA3MA94AkdBOG++wkbK31UWH5PRV3zTnPYF?=
 =?us-ascii?Q?Tu2j50ijM/IZpQ4KSw79OMZHoy0Kf5+Rl6yA/62m35VXbyfDxTB9WVzqHppU?=
 =?us-ascii?Q?Bmr5WHZMuwJdtFlLVshaVNiwAY3NjkDBRQyzuI38bGF5szOPRqtsautIueUd?=
 =?us-ascii?Q?daVioPeJfxjezx/wYOzibDMyUXWie5RCJ1fuNEzAfec5FdPv6hVoJC88BtXe?=
 =?us-ascii?Q?fat8HVqWhjCAu3xpuwjNVbaQnH73SvZ3KSIM7iltIUAJET4B1ztvhEPSwg/2?=
 =?us-ascii?Q?N9BuPyCrdsk7aM+3KzChB256rLmN0OHWwyuDTtzEc5O5DHXjsmjrGJtkhwSA?=
 =?us-ascii?Q?24WgQ9q7GGrHh05cgiBFYWNJpULGgVLXMHOszRfHc1fkn91fLENT/5dknJu/?=
 =?us-ascii?Q?kFtBfCM2as/cp8tn5+w+TFecyfKWS7aVn9jSNB7nbNLdfPpOrzdgmjbOaxCo?=
 =?us-ascii?Q?1LEwj75BnpNilflCgnNL9ovgf/ndpODJ+i0tNRuYWSy8sNJ3719XWZS//kNX?=
 =?us-ascii?Q?SEXUL/Uu3TamHEKhXGaMYkkc0EFnAL83pIu8FpG9uJBwxbsUbtz2nVZQZ28e?=
 =?us-ascii?Q?NBh4YGDWDWxU4DZ9YwzUg+Xjz0xIf3hhRy/5ipSpWbyrRsTEHUXsQ/I22dCJ?=
 =?us-ascii?Q?XzOI1fMFR3dAulceELnJ/OSjfF/0CMg1B38bJok915V+rX1gGwNs2Lo8fa/y?=
 =?us-ascii?Q?q+pcSvyQQU76MWp46dTIba1yHaQALdWzDom2YmEAbYxY+LG4eWV6XEjOlEBJ?=
 =?us-ascii?Q?AWtS/xxlJdNX0wfJWnceBUs5FOE4Fi36hYrg6bZAWmgnF3x6qNTLrbEFJUnh?=
 =?us-ascii?Q?rSK95GiaSrMFwfGf+mbKHOCsC4pLpepLcpHsCw4YYyhttktjmUmcdCoYEgzv?=
 =?us-ascii?Q?Cq3Fny9L3s1YCQ528SPHh/6iN9LpcKEahK6yLvngY9fYzfncG674n2TBsFRE?=
 =?us-ascii?Q?iwIdncfX6vyTaV0MpHwqpX6SGUtZUnIHzkgZp23sOh3p7VDLZ/3FvveAexkL?=
 =?us-ascii?Q?tf0tJCaSli0xIHC91d03/EDVHESXkdWDwl3XEu9aNc60X8rYTIZ8GRsQM8Wm?=
 =?us-ascii?Q?nEKoc12pMFIfgfT7AT+ZlcJiWriwP4OlmIObwG70DbM82cqvOaRkjuFmWUsV?=
 =?us-ascii?Q?JgbDj0kQeIanIEx1JRedOJbkyolCYMwEYOLhmu00t1hppF1VuiMpCo+Y4cWc?=
 =?us-ascii?Q?F8a2fVJsLWMFHn7y2ffL6ccdFAFOH20vsu/ZELL0yfyxT0qsWOZlq0MQKgPx?=
 =?us-ascii?Q?zWDUACN3GDTglZo9ZKL8EG/bdIK+xG1wtwn/UqZBsk/VI+4izoEU9sFYg2nA?=
 =?us-ascii?Q?UzvZQKS1QLdGsenvwka1rhYl1iSmg6cme8Eqx4HmxMK3eL0c+VqvfL6GJHCB?=
 =?us-ascii?Q?UyATH/zpysg4NdXFdYb20BVLHlVaD9Rq5nsFq3wDUxKQPW8J0pIjjLp/eHQX?=
 =?us-ascii?Q?wW2G8B1xO+m6V1EPgaO9nbzFj9Il/oXerA3LL+g/lM3YPPkoTOr8xoWOlqJS?=
 =?us-ascii?Q?RDUlSpIa++QWWG/rO4iKVn81lHvI+b3vQ9Rs?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 12:55:02.2044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58eff97d-97cf-489d-c1b2-08ddba30d349
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPF23691F3FF
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

From: Paul HENRYS <paul.henrys_ext@softathome.com>

To optimize the preload generation, the header and signatures are only generated
once all data have been collected. This avoids to sign multiple times.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 tools/binman/etype/pre_load.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index 00f1a896767..1c9cfdad38a 100644
--- a/tools/binman/etype/pre_load.py
+++ b/tools/binman/etype/pre_load.py
@@ -152,14 +152,14 @@ class Entry_pre_load(Entry_collection):
         return data + pad
 
     def ObtainContents(self):
-        """Obtain a placeholder for the header contents"""
-        # wait that the image is available
-        self.image = self.GetContents(False)
-        if self.image is None:
-            return False
-        self.SetContents(self._CreateHeader())
+        """Do nothing here.
+        The data will be obtained and handled in ProcessContents
+        """
         return True
 
     def ProcessContents(self):
+        self.image = self.GetContents(True)
+        if self.image is None:
+            return False
         data = self._CreateHeader()
         return self.ProcessContentsUpdate(data)
-- 
2.25.1

