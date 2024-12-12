Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7702AE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 079728022F;
	Thu, 12 Dec 2024 14:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="SagGbgEg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A41ED80224; Thu, 12 Dec 2024 14:37:17 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B32A801D7
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 12 Dec 2024 14:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+m7qe5GCddJAypj+tDUg+QmgREIdulTizvULgCVgoHTUruoKyYfs8SZ+go6MrNN4Y3rNhTsGN/2zvYRem75wJMvtUJp/mPaa6c7GcorVpeerWdEwV8JEyZceqN5uT7HxkkyOEMYeNEvgJliNqyisQ2/W0kLw5mfoVnpNBGmBbi8ZCIHWw3DLQi5VSJuNmd/FmEiVz04RVsmn6bGj91ixwj6fu6sQBi8gs/MPelFOChgNUjTPqUbaKweHRzwESoLTKbKl0iRvnlxLSAPDhRUOAEGvL0S4ez+Z4RTIiMAp3LJcZITFJ4HZ3rc9MdvRB/YjDsl8MeRLNzG1+TBJaN8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9zxPABgNtn8TEy3f7ndOaLMehngj+o79iSXDAkmbYA=;
 b=eiJ0VDnZfDHX7FmajI95kCuzet+vt8i9wUikV/0IlAFyr9lyVeOWJ+DBucbAzPZtG2ht4QcQI995FYL0eYDBDEAJlHt8rk+1HxwHr6/LrMot56BkyIDinpi87Xvc0XIongeQG2GGahDh5SRxUVKV5wxnblVRVuSM8vzpewhmVxg9M5jePbF7Rw75n/kXQf7o5MLnt7NwT7jdD8ubbIQolgbO8YufM8E/e7uLEkMtMdpOf3C03AEVnPfYRpP0kkgwTq2tm+Xn8eoRrUP4+ShjzT2hRMGlwRek3UbXkE2Rawohx4oMJ0WASit8T3DLx+PL9Xr9/QAUMKKxXq8G+V1e3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9zxPABgNtn8TEy3f7ndOaLMehngj+o79iSXDAkmbYA=;
 b=SagGbgEg3nKefknwfMweeW2Uv3raSVGIBmI1H8fmWR1PS+zE/g0eK/UK5vfzIpb8Ziu0h0jNvO9KMay2u0btu6JZLGzUSXiN/nb+8nWYDh+i/xPufebh5rTEZKMz2HqyfC/C6pkmUDC/aoU1IFgxj52q9IU4zxAMXa9ERh/zTBu1gNFuFqH+1OiVvVAGkrAvJEOsTzxwdIS03zKmyIxA5ui+Ma7SDsB0LZIDctRNQdrE2jhYWo0mnhy7xQ5lFbOuiawVLZtjWIwaa7n0lsENzIUHlFG9yIjTaQUHdaYmKM6/bamWw3YpfBlHgSM2weV/uwT8R3KAdmbLaPzaz0YkPA==
Received: from GV0P278CA0004.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:26::14)
 by PASP264MB5108.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:439::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 13:37:13 +0000
Received: from PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:710:26:cafe::59) by GV0P278CA0004.outlook.office365.com
 (2603:10a6:710:26::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 13:37:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B9.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Thu, 12 Dec 2024 13:37:13 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 2E9EB20213;
 Thu, 12 Dec 2024 14:37:13 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v4 2/8] tools: renesas_spkgimage.h: use
 linux/compiler_attributes.h
Date: Thu, 12 Dec 2024 14:37:04 +0100
Message-Id: <20241212133710.172404-3-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241212133710.172404-1-philippe.reynes@softathome.com>
References: <20241212133710.172404-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B9:EE_|PASP264MB5108:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b64f7f36-2c30-426f-fa42-08dd1ab21616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H0B31sw6m52XPOJJWSN2wIxwL5n6KTVPUwUJvR9tUGi0Eva7m4c+oSv5xTfv?=
 =?us-ascii?Q?TkVVlG/n0H78Fktg0f7dP9XJJGS0iguJPm5GeVKbiTdQEaHJQrECgS/v82VD?=
 =?us-ascii?Q?J19NpzuSKJDxnqUCOBcMwcM0DwBWx+LVYhzWErEfRsaGBmGjphEBKVLTbhls?=
 =?us-ascii?Q?bgslOYmVG6w2ngHkmrQ3VgLW7THzSEOWIKWfUApSfgph8jcm0YBW1ObYs0gB?=
 =?us-ascii?Q?khZHZ3lobc5r1/JGSO5S9Wp/unjKnq4bwibSs8tXwoUl+giKDSwCPPNY0Lvu?=
 =?us-ascii?Q?TQCXlYG2Ai8S9xi6cbZ/g9/ohAElhNmiSbH0BWKVpLIFE8bGMxmHp7adbwMe?=
 =?us-ascii?Q?sUB5NZvs+PJOKDpRCBkbH51K07Q/GKk3UhULuwYybU8ilnU5Rl2bJmu0xMia?=
 =?us-ascii?Q?rqL7d/O44vVzFH8uUQVPGnmMDqiN0bOZT3TGqs9hoLsoEqx6xGPHLVoSuc/6?=
 =?us-ascii?Q?friO9a2QBhhX7MF8fWgj953eN56OESw67K79v2jmupptgz8M0SuGOdOhr3gu?=
 =?us-ascii?Q?SjLcnb8B99LHOeiIYRPvNk2aHGrjSyy6g3We8hATzKeIZrHJsMFEWQgZEVaR?=
 =?us-ascii?Q?1ejZYRk6qMZpJE9p3FcisBC3FL5330lsvzHJlns9WsJRxsBzFwzhqTeuQ7ma?=
 =?us-ascii?Q?qTbzVS2WHy+1HrYxSO/28kisRy4b/KoVAZILxsYFiAlf5l+bAWrW8XaxT0Z+?=
 =?us-ascii?Q?0LcOLs9ItmY9tgnj4h4VWIDoEPG9he9OK2k7Cs5xx1qyGetcLjSeLodys/H6?=
 =?us-ascii?Q?QDrZP7zXSHNKSC6w+D/crDN5JFR/Nh7+ofych7sEH72dVTP68b/aHhlwnnGg?=
 =?us-ascii?Q?DkzbUG+RC4sCUldOj4BvU6+qTpt7RFkVyeYVvWQamjEC6JifVYgCYyeI+5bm?=
 =?us-ascii?Q?c3PZ/xrRDgTqUCMOUnG96znyKRBbjcf2wu50ZQxFDQNrEcn2gzzAlOpkWovw?=
 =?us-ascii?Q?uxEiKC+1N9aj9zwlzMz9KJSfJC+zZ6VItjHEWXzR4hJOleQ+cUAN3cMHco0K?=
 =?us-ascii?Q?odvhLf7Hbj46Y+HFtop6KHbkKK7+IK1b+qtxofHkpauQuekblMCLmd6jsk8d?=
 =?us-ascii?Q?wV2mmBWwwLeKQYL7UKwTNphIRNm96bmKBzKYyhAAo9azait6uxNZFoipQ/bN?=
 =?us-ascii?Q?+3VdAbFHrzQBtzkI3UcO4wtB515B1Kl7juyCaqma1NKuY1ubaPuWMO0/b1Bu?=
 =?us-ascii?Q?OheSqdJD2/3B84OOPPSKPiSJoKqxy/j7GDe6QSdJtF1vqSUZpzt2+ObzvqiV?=
 =?us-ascii?Q?u9BcWXWbInOQ0m0mTd9W/9T5/SPREJ7HbjFLnWDjGShR2vyfdXRcfYxPUK72?=
 =?us-ascii?Q?rDoPF91hcHSKYrvEScRuEm6DfAPeFxayP9aabhw6kPe4MaDcr88a3ZXUcFRU?=
 =?us-ascii?Q?MTCdpXyY8YTtrPYgFCOaNXj3y8mUoMxuwExTfCqslfn8RAwKTpNnuyfhNIXd?=
 =?us-ascii?Q?7b1ZAfzr64WeNtjGCA2SE/zD4Ah0kUdi?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 13:37:13.3115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b64f7f36-2c30-426f-fa42-08dd1ab21616
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5108
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

The attribute __packed was defined in the file
tools/renesas_spkgimage.h but this attribute is
already defined in linux/compiler_attributes.h.
So we include <linux/compiler_attributes.h.h>
and do not define __packed.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 tools/renesas_spkgimage.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/renesas_spkgimage.h b/tools/renesas_spkgimage.h
index 367e113de9d..83ec567b0d4 100644
--- a/tools/renesas_spkgimage.h
+++ b/tools/renesas_spkgimage.h
@@ -11,11 +11,7 @@
 #ifndef _SPKGIMAGE_H_
 #define _SPKGIMAGE_H_
 
-#ifdef __GNUC__
-#define __packed __attribute((packed))
-#else
-#define __packed
-#endif
+#include <linux/compiler_attributes.h>
 
 #define SPKG_HEADER_MARKER	{'R', 'Z', 'N', '1'}
 #define SPKG_HEADER_SIZE	24
-- 
2.25.1

