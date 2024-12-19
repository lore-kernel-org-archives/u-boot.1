Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A55E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 13:07:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7641580394;
	Thu, 19 Dec 2024 14:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="TIeMYwjG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 666DE80316; Thu, 19 Dec 2024 14:06:04 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEDA480326
 for <u-boot+nodisclaimer@lists.denx.de>; Thu, 19 Dec 2024 14:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O86Kk4uc/HIEueDvwGPZKGlXuj8PL2Yei1Y4SKPG4fah9pbVjDPQqbPOELfTz16X7BQKVH8McutjAzXmXK+0EZ1UPPODzTNUXsMTmyRdq+W3HK8dOEudViEl+hjiKNWWGAyU5+LYXpUBTloLWQqzxQYu5I6mtwwmog9mjP9KXAiHNleL2mfgGgT0q5LlILj5+pQPKzrkrBmd18X4Gw0M0qlBRJ4i+Gjo9GfaMDA6H0WcLD35TIDEhrHFEmNX4VTYQWylLFZRj2KQ6hjAagMbrZJP2eZqlLWAEKEWL/Wi2LUTCs5+scrNcR7LYukKV9a8R+mz1fRURBttk0QO49iD5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWMf7D1NFrLCQ6xFdysx7G4beie8S+vz5tshovka7t8=;
 b=wW8CAiDz5it+Cd8InIoQG/7ygPdmIUOxCYDM1VkacNM9R5eR3nNfK+QfdTWPl3uwbn1Yhj6QyjRqxVav/XhU/XIqGvive+9p0/fIQuzZL6vaj4VSdgUwuABJuAF9V0vPOgSADDzl1kB24eOBc/mlvcOeXHktUMAbB8UKxK1HsSfSfVyWXsshL2+fluD+HeJb8/lwjiKBLm2/AcYcWpBDkMz9oDQbabmDHOFfC8LpLoGJGFaUAnPI3ZmHLf5hI1NmmwyKy4kmJaFQcSjN6hBh/j/Ti2oRHBH2sJOgeOzV8J6AhEZW9F109MeYyxnpy+hhLrE2Th35axql0/G9kj52sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWMf7D1NFrLCQ6xFdysx7G4beie8S+vz5tshovka7t8=;
 b=TIeMYwjGOkOx/aAKhz1WhFAsI7Hz4oujK0UvnyQDr1OkIWlkubRhmIZ7Acvjn4k5ch3wPfR5aM5b7jjzlDRWSdlsFMBNN+6q1uNTtQMFqLEot0A1kymM9LRtVsnwAWEFeM0CylvHAwaZUS2XJT/5djVEPG09ZskfJOJ9HmuTou74sMegjUUDbYQGQ3AmNCB/ukmbDvJ2SMGQhBeIdGmoe5JrjhQ9fHmiCOUi/PdscguU/R0+ujjUYMZCVkyKq8G1M/bl8rhRm5AG6fIjqqf7SzNE1Laly5zW2uq16cxfir0YbWVAc2hxv9mVUWJWSzkD0GpN3zf+pj7cZLWJJaaiWg==
Received: from PA7P264CA0405.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:39b::14)
 by PARP264MB4808.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:430::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Thu, 19 Dec
 2024 13:05:57 +0000
Received: from PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39b:cafe::ae) by PA7P264CA0405.outlook.office365.com
 (2603:10a6:102:39b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.24 via Frontend Transport; Thu,
 19 Dec 2024 13:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019230.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Thu, 19 Dec 2024 13:05:57 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id EBA0120269;
 Thu, 19 Dec 2024 14:05:56 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v7 9/9] configs: sandbox: enable mbedtls
Date: Thu, 19 Dec 2024 14:05:54 +0100
Message-Id: <20241219130554.49825-10-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241219130554.49825-1-philippe.reynes@softathome.com>
References: <20241219130554.49825-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019230:EE_|PARP264MB4808:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b3a69de1-4358-4c44-9626-08dd202de0ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nVGn+Xgi39eXcRaEYK97f2Q/uaelyQ1DJQ3+XRSQIL1e9Qa1XuvS0xbAsUl7?=
 =?us-ascii?Q?Cv/AjYSFY8FpkmHU0XTDZMnqk1VUHhtx+olNObRGReQEKYjWV/j2ghXzBQYG?=
 =?us-ascii?Q?or823oVnN/muNHW0ksKF4/oKA1K0lDQrZdHSpCKB83uGKnccLK301bP5/Lio?=
 =?us-ascii?Q?/DyA0RypT+D9JD46w7dl/9EeqxNKAz+ENzWYRPQ/z/oXxVLFMevCF8p+kbM8?=
 =?us-ascii?Q?D0B4VlotB8RDAUxN/EK7wwshvp01ii8ra4Tp2N3uo49MbOb/fy4cEw1bd/Ph?=
 =?us-ascii?Q?GX1L/DJC3k55YCG3ypHE5khmyS7VP+DcVLOVR5qRNZoeywEe2TGBwU+qRRFu?=
 =?us-ascii?Q?FqtMBaJlK1QSL2q5vO4rnXpR9sHMSHFv8dPQhMDxmFMvxMdCs+khBrgMKhEC?=
 =?us-ascii?Q?dBbwWTAP1Lz2KDyP3hwDobjT8a9gaDKBSmTjaZzdDca4ItMGJYwfWrvsSS2S?=
 =?us-ascii?Q?RX6utluAe9nY2/ypEUyNLxndPGRfANtuozBUx4/mqWUYWL/081cVDf8GG9x1?=
 =?us-ascii?Q?yg5fi3RRnM6UhuGxZxnHk4ruJRANARkDAD6vjpH9LOOURM3vOGRyequF8E8w?=
 =?us-ascii?Q?8xiUC4s2IeDaW34V8+aEIRKJ+DUkS6fRPpZzOx14nY3ANTjiK990Kqt72ZmI?=
 =?us-ascii?Q?U1H35aE57C9whLY/EkY0H7fPsscrVXSSd9aASJA1myzyPo0bYfNIZXDAoC9C?=
 =?us-ascii?Q?Aj3CSt3gexeOhum2Oa0+uJ34LSn0xGIk9Hlpc50Q6ajCx1c5shgcquRSP6CI?=
 =?us-ascii?Q?C6Tv4yVxHTHtXsOeEuf8uMMnV3dw0xxKkPSadXthlY38yImbJzKLSYMz9WQN?=
 =?us-ascii?Q?t2A74xfUbBDZlJ5FuRffiTtBHa9l29aHPjNeFg5wZuQitOcU2i/YpH9FoL85?=
 =?us-ascii?Q?bcfTH/yknSnRY/eBO8P2len+SEwdRhGnsMyWe0f8CsAwPsIWx5aXZm/ThigM?=
 =?us-ascii?Q?KiqrLs3m/OiVoOLjW9Dn/4hfA6rfMd2ufo/ZrzHUnSwFVMQYKEXUFNJMm/oi?=
 =?us-ascii?Q?qA3F1CzmEHhKiV2lNAnCHS4NNMy1k3YfNcEt+secSMjUMdxd4dodjEIH8DCY?=
 =?us-ascii?Q?n7CO2sPoMwjDduTSe72+R7FzkSgct63C8BO061X5zoWcpTXqeiulvNJf+zC1?=
 =?us-ascii?Q?aoyUQr0mI/xMMyfdOoXWNICsc5TMMF7e2XuL5gtlBluJ8wugS6VlkcKdOqG9?=
 =?us-ascii?Q?QB5J1P9lurux2OqABVyy9nUlUrrAKJ/9MVJU1NdTPmcSkQ2pXqFZYdu7Pt1t?=
 =?us-ascii?Q?lpODdtg0WJNQisFmkgdNXOf4OqbYb6g4X8BFElswg6kcTASekXV5ry9Dn7Xm?=
 =?us-ascii?Q?PrS2aP9nRsjfOYzS4xxGjrC9fSV8KnOcxMeHY5qVLUB/CUSW5S2HcGteZoY5?=
 =?us-ascii?Q?jxIFpOkL8b4ZljAs+sqmDAdsUNPSWHBdlImb1Q8kvsQjEIhv8lwnb/7f+zai?=
 =?us-ascii?Q?fzn/l3NPYDzdeqroqPT5wewbr0bit8a7FlD2ERz2vdBELzCissMrUajTnoqc?=
 =?us-ascii?Q?uirzbIGfmGIfCgM=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 13:05:57.1099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a69de1-4358-4c44-9626-08dd202de0ad
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB4808
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

Enable mbedtls to have at least one config with
mbedtls enabled.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 configs/sandbox_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 718e4a8283c..1258044241a 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -352,6 +352,8 @@ CONFIG_FS_CRAMFS=y
 CONFIG_ADDR_MAP=y
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_MBEDTLS_LIB=y
+CONFIG_MBEDTLS_LIB_CRYPTO=y
+CONFIG_HKDF_MBEDTLS=y
 CONFIG_ECDSA=y
 CONFIG_ECDSA_VERIFY=y
 CONFIG_TPM=y
-- 
2.25.1

