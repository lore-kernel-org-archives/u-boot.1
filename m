Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3B3C282D3
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 05:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C256681436;
	Wed,  5 Mar 2025 05:59:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="P2ruxTXR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87D4181607; Wed,  5 Mar 2025 05:59:03 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2071f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::71f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CD2C812C8
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 05:59:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWxMYpwCUnCGMkZdRZm2o1XW9R05HDOmCQIpSIYJriaKf827XEHxElSaRj9r/nXz1zraZdhG/QyANIEX7sagb7NkpIJPxJOP+qH5cdfXFj7yLPWSaVO9dR/9p2lB74h8mLftfGHcsIbWeq1Db3gODd9LRgWtsfItyrm+3x7ves2ZJe+wuqJAb09kazjQ8Jk9D3zP1qESz4LLe9HZdHKXWGRPN9smu/SH3e2QDkwl6M6FIkHXxIQd90urEWDDONGKlLKL73KV0NZDatmCSu/DIiVnUsMZ3bblD1tYYyscs3HMtwK4VX5jc/3ifz0hVQisuHk+3Ocah7x9DRJB/gsgqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7rdkzahCE/9V+y9M55s99SXMdQXsvDDr1PgaHcYnQA=;
 b=LPFgfRALcpeK+hTwVkc8UzSnHqJmxSIDD9RVaHbitqgYgk6p/Ad9O3S0Hjbm0k46b8CtUjdy2lHG930R1pC98yUTzkHCTwv/cOcIUvBz9STQkTbqsMtsTjE5UKCXsMfYHmeru2744Vcz7x3H9ALs6dCOIq1kQzKi+2fv2HfkQfjsGHGqVG7sm4Ev1lrHtaOS+nAxI0dRZKuFz90pELErk0pTF1qd0gHcVvg3a/QRAJwI8uBOsRPi6XfmESWVTwVVIPiaE6WsnwwteqJ/Ic9z1dQ0S25WmEBPnZtSS7AIAKKMNRGm0vSduwvB0O3xEwj7qyLFEFDVQrPrO3gMJEY75Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7rdkzahCE/9V+y9M55s99SXMdQXsvDDr1PgaHcYnQA=;
 b=P2ruxTXROMeEei87a2e8c9RmQoIg9U7Kc7fq3tL6YOOWcQY3ZzDwKL2Vrrnsb/IYihhHBI0rar1D1sRWQiiLVPmkMLdaRBaK4mGpJSvAIrXS1PAryIFURX7CqWW0BZhFIGwKEfIwmfxOQAt7mnaZ5Kj+y2+LlPJmSOQOEBz58lYxDr0J3Usvy4yZfpqzKKJnz1PHKZkqcuEYAea6XsmtvvUBCUosJRDqM4hGmH3TxN0Bks3dWb+zm9yh8Da4MAq7iAY9VDDxTp3aBG9XS846C6Vdxbfo4+mBqvnFCptViTWR0VW8bs1csBmWRc0XBlGmrpEEBLAcYoOhedhHAioXYA==
Received: from CWLP265CA0287.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::35)
 by DB8P195MB0501.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:154::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 04:59:00 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:401:5c:cafe::6d) by CWLP265CA0287.outlook.office365.com
 (2603:10a6:401:5c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Wed,
 5 Mar 2025 04:59:00 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 04:59:00 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:49 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:49 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <joe.hershberger@ni.com>, <n-francis@ti.com>, <afd@ti.com>,
 <nmorrisson@phytec.com>, <d-gole@ti.com>
Subject: [PATCH 13/13] configs: phycore_am62ax_a53_defconfig: Add SoM overlays
 to OF_OVERLAY_LIST
Date: Wed, 5 Mar 2025 05:58:38 +0100
Message-ID: <20250305045838.3614661-14-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305045838.3614661-1-w.egorov@phytec.de>
References: <20250305045838.3614661-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|DB8P195MB0501:EE_
X-MS-Office365-Filtering-Correlation-Id: e1878c6a-f868-4e42-e849-08dd5ba27153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?REOHHqqtRHbLIrhaMEjU6z+gS3QWd9f40ehLcX86wKgrrPVYCXYiAgiOL1xc?=
 =?us-ascii?Q?KQIM8r1Ucf6xcc+6sWZYgqKxmgoeC+o6dL5fOJG8xwU9vu6t1Wa+bwuQneBs?=
 =?us-ascii?Q?GA+dkc/ibPmG/I08UO9kju+R/k3DNl7/rxAuu5bEdmed6wZyXIJjaMwi5BPf?=
 =?us-ascii?Q?fejo1habt44/zscQoLRVm+A5OeN/4SDNZp/TC3p1DQsmokj34XHiV8D0vPdS?=
 =?us-ascii?Q?nZHI8WO0FJcKu+VTFqtpbIFBVMDDVRhcpm0PSWjRjLXsDboPBgc3mtw4E6RC?=
 =?us-ascii?Q?8trAOUnmk6a4Ndmc9iTHomAWAULLDOA+78bsaOSWgoOfeNiESJioRAOUzHgk?=
 =?us-ascii?Q?zxIzfqyWm3EoYONCRPu46wqqLGj58hMm2eLVxU1uVdMCfkcqjcP5SJbkSZPm?=
 =?us-ascii?Q?Xq/wV7nStUchu7a+iH0Gq+ddNy+FGs9uSgVpvTQK0/cpoNY/80zTFWsagTNK?=
 =?us-ascii?Q?D7GCTLC9Ce31/oX839tu2as2im1WVlswBVHckv81l/Fe43BXpMEdk8PJllrt?=
 =?us-ascii?Q?WfCDzCgjUDwLGkhlVQ1gVCEyRFVCICvfpEHs/AeI9BmYNYaDdF++edtiIjH7?=
 =?us-ascii?Q?sHvJrRuGwYqafwqZS2PL9jeZhQDkMFstzoqevq7DWy7nBHmxMBt+96N4Hksn?=
 =?us-ascii?Q?NlfdDv7XVbqqJ8qRMkWVRKQ9Rf45t8qoTrWLs5/4FBFAvs+VvivpHABz7IZ4?=
 =?us-ascii?Q?PuDdRcpoGgUIp0UKRgrJi/n76n+5GEx4Mzp3aNPG1MBmpt3jNw95THb44juZ?=
 =?us-ascii?Q?iRjtjNl5jjaN8ZB3l8/vSNg79EXid4fBbfCQBFGlZNwrvQpstgU+nifSkONO?=
 =?us-ascii?Q?MPmJz3AK/GhuYD7Vm7xr3Kx0waLq+TgobFmmKz53PkUXLkdidq7ggPhTVhjp?=
 =?us-ascii?Q?nLVTI85AIxwBgnYMaMrcB5rJArj4vTpAQf+8PENM4pcN0R5LqN64ZDPkPBaE?=
 =?us-ascii?Q?5AUW3hjqJbPgYY6d1fu/rwyN708FcI8PrVS+oPghWrIAG67h2mAz48qpk4VX?=
 =?us-ascii?Q?HtsQeoPKkTHtAnmG/pFuwun9+2zsbDb7qHa6PballIZOaLnxppjnTLDxYG75?=
 =?us-ascii?Q?g0WysUFVsJ5b9HJE9y1y/Ln66im9ElbSiSsyktNnd6Om8ZfMf+knf8Qjbgnt?=
 =?us-ascii?Q?ILu/YP/t+8haAaXcgAAaQ0S2WseuU6KQGaygDnEGgjssn/Ly7DdFtMk+HV82?=
 =?us-ascii?Q?KJaWmhqAMLLTTBFYN2YzIXp4iWmkMT6+WDdSbk0ne00nD6616odoAzG7szSU?=
 =?us-ascii?Q?6gXO4Alh5ACsSaJLazq0RmXKY3MSXDrGXAbTLJ5bT/LfCoAaHGn62PNpeSUy?=
 =?us-ascii?Q?4iqcuV+jVTuzpEjFgVey1qhc62cGI2oih01xHvDmfJmJNmdDNbV+g6te/Onz?=
 =?us-ascii?Q?ISOG8ZIinVkxOIwdsAclF4FoJVC01Ks1B+TGlPE+wIL3RxdH4COztp6SEFJM?=
 =?us-ascii?Q?IySmQwadYcmpZpwHdAWXLn7UGXeJdCQRPNTbaaabXCrwQbWYwnyaX/No0iO+?=
 =?us-ascii?Q?JJ9gDxUOwHRUQNA=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 04:59:00.0319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1878c6a-f868-4e42-e849-08dd5ba27153
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0501
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

Include SoM dt-overlays for DT control so we can include them
into our u-boot FIT image.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/phycore_am62ax_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/phycore_am62ax_a53_defconfig b/configs/phycore_am62ax_a53_defconfig
index f8692f0b3b9..b454076bbd8 100644
--- a/configs/phycore_am62ax_a53_defconfig
+++ b/configs/phycore_am62ax_a53_defconfig
@@ -83,6 +83,7 @@ CONFIG_CMD_RTC=y
 CONFIG_CMD_SMC=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_OVERLAY_LIST="ti/k3-am6xx-phycore-disable-spi-nor ti/k3-am6xx-phycore-disable-rtc ti/k3-am6xx-phycore-disable-eth-phy ti/k3-am6xx-phycore-qspi-nor"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
-- 
2.34.1

