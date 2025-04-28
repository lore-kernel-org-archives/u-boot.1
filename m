Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32334C369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 14:49:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EA5482A5E;
	Mon, 28 Apr 2025 16:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="I0VEE5wt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 172E982A53; Mon, 28 Apr 2025 16:49:27 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2071d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::71d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E94D48293C
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 16:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/jPX3qGGqefKYHwShYMLlRhyOrai8JZ8sJ/IXwLb9d4wOPAok+AucyOgaRdyGdlMBcSFZAwPcwKCbc38pmPn/RHaX8KC62ZCfONZ0ey6xm8uXDdujoYki0oXTz1h7lTgtkP1UrL9YglS6TF7gkM3eIxH1SlNFuDcnphDD0uQ0MfKwjOIwPt0l2FlFTx0APGF/qf0+M7d4g36wSu6UjaoRe2rSy3nbpIEt/RNbW14cG0gSpKRs+dNBZPCsfseoKHtVp/GU4VFoyA+sahETInfmRpSK76xhdAxKLaN7ObrstwldbVIHmBe3NU2iUEBP7E672dC+zuli0QqZulamxbVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPXLkkyppOD0e05jS2VmsvrPhdfUF33MVzliCJn2U6U=;
 b=ZoL32ZOTyf9uERgY91ft0h4Y42Lo28l/8cVMHs3M1y8JzL5UqydmCPgZPKQAtgcEqOvkt61LWoP6h4rzKkgOzNK3GQwa6o8s2yfapfUlz4caI7CUsYMKaIgrycpv82EKaiJka6XC/6Ql2o0d2BrmqHyLWffYaafWc/DqPFh/7y1GfmnznHzFXsj22dW50ohkOLxSKuVDtFOxv+ozX7Rq6bcg5pYO1EOL5KKXL0luFwl/ls7wySD9/RFq1utuybY0utTSBcRwXcFgnelaDgnMwvobyU+ZTZtkjC3H2Dqgh/dn2an99oNgpkju63I4nrLy2LnPcZ558JpEOBAwmEPCCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=phytec.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPXLkkyppOD0e05jS2VmsvrPhdfUF33MVzliCJn2U6U=;
 b=I0VEE5wtDDLmoO68TpOSY6mNDmMfKt1tW1zmlOY6iDxuyaPPHGbqoNAs6QIGml9vSSy82NG0Vy34bSprjD0coGVJQNx5pSW0EKYfhtqRrOoahSM4W64K4hMDGMLrk/2C7GkjfALYqTo/Dy9yYj1DuKLUNt2KKDgPF1sVGI3KJYrQmaZcgXIzwghMIOwdD0sg0CowG4mzM5AngsQWHKJVleTrYSq2aVZq26OYj054/sCEr0PhHzm2AsCm66/DLe04O90cQ7lZGaORrEnCvapme1D/oYZpM1OmPewBDS5vP9V/7bjq/XmcfNHigT5BRXkEGHWgpC6+cOZNj6HBD6NhLQ==
Received: from DB9PR06CA0002.eurprd06.prod.outlook.com (2603:10a6:10:1db::7)
 by VI1P195MB0496.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:15e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 14:49:20 +0000
Received: from DB1PEPF000509E7.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::cd) by DB9PR06CA0002.outlook.office365.com
 (2603:10a6:10:1db::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Mon,
 28 Apr 2025 14:49:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509E7.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 14:49:19 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 28 Apr
 2025 16:49:19 +0200
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 28 Apr
 2025 16:49:17 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <ggiordano@phytec.com>, <w.egorov@phytec.de>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <joe.hershberger@ni.com>
CC: <d.schultz@phytec.de>, <bb@ti.com>, <nmorrisson@phytec.com>,
 <upstream@lists.phytec.de>
Subject: [PATCH 1/3] include: env: phytec: k3_net: Remove net_apply_extensions
Date: Mon, 28 Apr 2025 07:49:02 -0700
Message-ID: <20250428144904.1058574-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E7:EE_|VI1P195MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d363318-222d-411e-649f-08dd8663db6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kA6CIeQCTrU4/q7s5CuZ0txbSz4zpfV7yGUwk3y4soLauZYV8ucHdflr+cO7?=
 =?us-ascii?Q?pWD6Nx0J/A2T/J+X41VMnXP9oDunweUbwfWHRgDRXgOEhUeSWasRcmT8lkXR?=
 =?us-ascii?Q?tN534Le05AB2GMfRkD1QXmwZ7hl1zx0aBpDV82S1zUlhj8WEgOZZMbob4o7D?=
 =?us-ascii?Q?+by4ZTKe5tPO4x1BY4IBEbckMFAIXV02u4i3P8NCQtgaINxNcbSHTcxBmXyF?=
 =?us-ascii?Q?cySd7CgHnz9Xe0yNh/haMhPNrNN+jggSUhxcgHvLBtawctNH1BxkfAW1rEct?=
 =?us-ascii?Q?HdFAljV2FhJe5O27kcHYBtCSVzxbhOn5Kc30miCz2iOJg0B1aj0RJwPVV2PO?=
 =?us-ascii?Q?CKPSff73pW2Ja31tuHNCSApUEx23IgvPQooIoRQ1ZoTxxVOUryCd7sXKvvjw?=
 =?us-ascii?Q?BcCPzLbbD9IjsvQGLmcdHnLOUuz7QLwtYLPw3DxTVANwFsLvArkXQt8H6fKy?=
 =?us-ascii?Q?GFfHHbzMetu782mWn2Ovx73WQJiDpDzokHhrnSeiNf8u0ezYg6vvZA13cp4t?=
 =?us-ascii?Q?jznbyRCxAeQnKTwa+Py4jyLWwnXZVC+wBOB1budgMScjEH/+4TQtRrnIVGy1?=
 =?us-ascii?Q?8nUvGlttMUZd1ToFAu6EjIWi/DPqNPYUWkdNd0QPV/UQbq8wxVR5vgwJPirj?=
 =?us-ascii?Q?+qonAn4dJoMWxyHuf+mPMiJfsIzwZI0MJggwqyT/v6qk7fDd0kNccpCjCTor?=
 =?us-ascii?Q?nTcSfSAaNfsthBHu12PVX12sXl6/NGB6rIs6nIk856MOaII7JvbiCH5mq41N?=
 =?us-ascii?Q?lMlZB932crlJdSYVal1c7hyYwoCp9alut3daoCS7GHwkK4dJkkEWpLeVGRDp?=
 =?us-ascii?Q?o34rI0WkuL/3GTlCaN+pfmgqib7GQmk/lMuOvw7u1aftIVjqttjl3JKQsaTn?=
 =?us-ascii?Q?NBBwfCzdXSzP6y/XIvevXqGBgQ/moAtcuT7vxNY4/cDqwCAfMilMEXqmoKWq?=
 =?us-ascii?Q?G8p8eWwC2x3jZSK/IxmnAMIhP7VvI7SJA0jflWJbYuPJgUzj2HNa1azUH7hN?=
 =?us-ascii?Q?LoUOxZ6f/7pB8MPNeftxWDLrjc+QcMiu1k0tp3TGg2AYIXjPiiYjcOg3WXtb?=
 =?us-ascii?Q?0SXDMqkRqqEtoBSydyyCSz7BpwT/JfKwx83m3Fxx6nWyXVMUEhvzVbYIxpch?=
 =?us-ascii?Q?ZSbJmdTPBPWEr7BSxMFvCDclQ1YWdKy8Nozk8qQCBP+sI1nafHU/kV2QvZob?=
 =?us-ascii?Q?KYxwLV7WDug/3VWaHZlr7AVoGmgo32wUD8FeJ/1ONCzt+SL//FS0uKvnWOml?=
 =?us-ascii?Q?dETA1saRhscuqhzk+ugcJb4yog/3U5a3+BV2ono6E6hTj7Bnbt12CGjQrMJP?=
 =?us-ascii?Q?p7C68vm4kMuVoQmdDEnR3FuZkSgmDvQqQBDeKc7si5n0y6O1BEnUirM6lqTQ?=
 =?us-ascii?Q?wywAhtMuuv5EPDNpjq9HRtzx5esdX9odLMitfCJO77SKniSPjhGMf460eR7f?=
 =?us-ascii?Q?NEvFrbNDcZwA55y3NiyLhrc5OZcUrOba42fyZo7k4odC6WryQnojiD5lpwPg?=
 =?us-ascii?Q?n0IBkkAnkhn5B67snb8K+yuLTfGngOOioTnH?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 14:49:19.7181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d363318-222d-411e-649f-08dd8663db6f
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0496
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

Extensions are now handled by the board-code. Remove this non-existing
function to proper boot from network.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 include/env/phytec/k3_net.env | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/env/phytec/k3_net.env b/include/env/phytec/k3_net.env
index 8ad1cb7b0c2..2ccdc9eaa59 100644
--- a/include/env/phytec/k3_net.env
+++ b/include/env/phytec/k3_net.env
@@ -18,5 +18,4 @@ netboot=run netargs;
 	run netloadimage;
 	run netloadfdt;
 	run net_apply_overlays;
-	run net_apply_extensions;
 	booti ${kernel_addr_r} - ${fdt_addr_r}
-- 
2.25.1

