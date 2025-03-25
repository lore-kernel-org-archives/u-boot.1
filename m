Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A81C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 03:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDE7981026;
	Tue, 25 Mar 2025 04:58:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="LB61WX5B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8478819FC; Tue, 25 Mar 2025 04:58:40 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::72a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F58981A0C
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 04:58:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9yLG90YTXK1e/wiLDeHe0TmpfP5VS72TfAon7OlNBP0XeqBM/MDfsk6siA7i6plzq0hgxkS6YgiZON8kx5BGrjU4uomT96kAtv05unvD+5w6PL6meZUnFLxJuHdzoJ0rz6lM/v3m/aLzcEs7IE3AOcQuee6gtl7+9Mr6TJ3LY9/YbBzpJ/r8e6IVQouhcN0YT2UFXCxRLL3jj+8C1RKzW4sBgdivQlUxN75DIRW9ZYzcCjQeDiNPU+1GPds0+tNyGcq7FVXVEUmTMnnY76lCfil8wLpPzfEGARTBiigwlUgVjc9aI/b8TPKkovxtUKxNaC8IVYBTa3zhDZ6dZkpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pm+r8xKvwf0kec/tXoaDLyDD5Y6FZw2zSZRDh/RKzR0=;
 b=rLSIJeItwr4zNssCCBNBfSgGCNxoxUpFDLgMfQ70tb/6fZ8hYv486UuzRxR6EDc2XK+ITQsdeWjbSH30ibRgZQV9K1SH4owd+/IrYUsti+0YWklg93HvEMfG/LrLYldop+Ie9h3kOTFFxNoyXinNGfMD4Me5G4oYzGlBGdym4iEjQ0jKJzATf4Re19/IIsVVUCQ/n63/ODARH1XP+tyb/Q6q9CFA0cOwAF0T07lPwGYEinuhpzHiRmC9R9dA23+X7Fg+lKjdjspv76mMoawuHszuydYRgQAFDaK4jOfYE4Izf42qALpJ7ZQLoGd9DvxY77/McpA557Smu4FWWawKfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pm+r8xKvwf0kec/tXoaDLyDD5Y6FZw2zSZRDh/RKzR0=;
 b=LB61WX5BhylblDQm12hoJX93TY0XeNNqEKjvnJUzfSRWM5eo3cdW9STdaoF0Pjk+xrZit87kPOZXaflz0OwVdcWsChg2nZzCxuXdWiZvZQSFFw1UEv/aMJeHAnhSsKeuJ/2oBJVofgqLLtRxUs3ir3I2TriP3j6pkzFDC9vYKXUeYFh+trBKfs65ajf4DPe4lHfo0RuULEa/BvCcA9LrYg+URL5wyKtBWtVAAiu5ew5zdgeT8XscKe1ScgYWrbPLmqUZlAaXrQzU7Md6NHwdWvrkZ1sp4XR5S8VGzvaFWwCoJ2YnU1uenCiH6EzvW2jt1AuDVJBDv+7hdP6PUr66nA==
Received: from DU6P191CA0024.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::14)
 by PR3P195MB0814.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 03:58:34 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::51) by DU6P191CA0024.outlook.office365.com
 (2603:10a6:10:540::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 03:58:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 03:58:34 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Mar
 2025 04:58:32 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Mar
 2025 04:58:32 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <afd@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, <vigneshr@ti.com>, 
 <s-k6@ti.com>, <dannenberg@ti.com>, <bb@ti.com>
Subject: [PATCH 4/8] arch: arm: dts: k3-am62a7-phyboard-lyra-rdk-u-boot:
 Disable Ethernet2
Date: Tue, 25 Mar 2025 04:58:20 +0100
Message-ID: <20250325035824.2304200-5-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250325035824.2304200-1-w.egorov@phytec.de>
References: <20250325035824.2304200-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|PR3P195MB0814:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e8b16a-79e3-4a6f-857c-08dd6b5150c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RDLNusFEytImi3/DYJ+uu5e1M2eTR3ECPpLiVdbms9Lk3mCo4ISBMHVu1Jha?=
 =?us-ascii?Q?HdeP+RxwlGgjToEoSFlUj2ad9wa+e7R7iPI2KQr2pOVFmANRkQZQRt5dzsDF?=
 =?us-ascii?Q?u/XCEhwB9+NF+Whj+pu8/fPcFLQn2zvYKkYDu+VYSgYdKFslp4y2Ea7sXZ93?=
 =?us-ascii?Q?o6TwubIZgtWECsS+tJSGWKqwRW39EEzeCYreazpkGJWS9FFznZvy13vDgtuU?=
 =?us-ascii?Q?EfDpB1WekRQU/bsTM8A3uyuQZhuFWSoQdbm6WTpNOWIhm+XYaWIR9U52xTid?=
 =?us-ascii?Q?HDIeyrea8+yu14yK6NbPREQT+d4CWP32HZRhhozA7wjyKlAhonWq/rd1EaV0?=
 =?us-ascii?Q?wb+kupwNCXeLZOSrUCyIW84A6PwIlMsGcM8ZRsGPNpV6yCIyrcswB4tfSFHr?=
 =?us-ascii?Q?tgs02+oIe/muvv2wBgm9eL4n8yllsbRSEa48tGUGnth4N2pN5HoddeQzjGDK?=
 =?us-ascii?Q?KGBnZb8+tkC1gol2Ra14pU2ZmZEkHYSHRWjP/eO4gHXBRipKqNXYsHkCw+jf?=
 =?us-ascii?Q?RLMHzxropZivqPqMz3Ir5wE72HKdDpY+e+jeu1M1NtpGSFOJAnv0kEr5hny7?=
 =?us-ascii?Q?ER/jDbRevvCVS0gphhdNttulNLjzvzEYE1ducnk1/nSQieIqNiNMwM5AnQOt?=
 =?us-ascii?Q?xb436JTam6lTEe5nE4k1+2t9vN7op9pWuWNzxKPz1nT0vC4+LWdsvUAdjK3V?=
 =?us-ascii?Q?QQH6C5odtfYShMfkGWEGOSWU2OZ+71/2a102SF2wq+jlFWnVFYzho8rdWDX4?=
 =?us-ascii?Q?ViIB3xt3H5o4Ai233JuDphpE+9zKoLdW/528BwdlrhqR9R4DTUZ/zD5G/ThI?=
 =?us-ascii?Q?JkRj4zFn5eFWqi4EdcXFwoCgEm9yup9x4qKB51tslhl+NlMthnW/D5FMtyHm?=
 =?us-ascii?Q?PwLzGZRJ/kE61CFUuiPhkLUgf5Li+eMLb5Brg2nddoKg7TkoR3fSC70u0Kei?=
 =?us-ascii?Q?565Y1I2J7Oipwe7uyG7hoGbyl6CUa4i6NeHDeibCZ2j+GHh3Iur00IWIQo10?=
 =?us-ascii?Q?ubkppqN44GU4LdtxxWxW+SzLtED/uW61JozGYcOuiXrS6FZKWl/eaFaYDh+G?=
 =?us-ascii?Q?Nl/Ab9KNRU4ybrSTFbkxLww9Cx733MnvZzpbIuqMgBrkunLMpnfTbd/Pd/w0?=
 =?us-ascii?Q?PZS4BvxZ/x7ZefG13IEsW8jjT8JEQu2vhhi1nzRaOAxqqyi69juSQY19fKEN?=
 =?us-ascii?Q?XYVn4Y10yeXd2++XUxeh5ewuiQdsX0H4EsLuAnVdAP8c0txT/UmvrFKv+d8d?=
 =?us-ascii?Q?MqkPEnjDC/JzW2pVRrBPITTJ6dhp9oDcptg/DD37Xu2jxYpQUj63tkyY+LvU?=
 =?us-ascii?Q?J3WVkimfYPzMVSAUFGpaGPELmqFcXFkMI5rwK6xueBxpoYpW7TisxVeIORQf?=
 =?us-ascii?Q?xTnEvChwDwm9iGXXVsZrG8E+BUT5P6VZ2Zt535aecqmU2lrRKI5iCFjhXHTt?=
 =?us-ascii?Q?AGPoM7NXIrxSksAneKg1pc9wULU2iVB54U90efGDs3C41jWADYugG8CfQ5/7?=
 =?us-ascii?Q?KVY3Rl11wWTV9Kg=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 03:58:34.7145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e8b16a-79e3-4a6f-857c-08dd6b5150c2
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0814
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

From: Daniel Schultz <d.schultz@phytec.de>

Don't initialize Ethernet2 in SPL. We cannot boot from that source anyways
and it throws an error during boot.

This will remove following error message during network boot:

Error: ethernet@8000000port@2 No valid MAC address found.ethernet@8000000port@1
Waiting for PHY auto negotiation to complete....... done

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
index 41692c8f670..e2a086e6b90 100644
--- a/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
@@ -66,7 +66,7 @@
 };
 
 &cpsw_port2 {
-	bootph-all;
+	status = "disabled";
 };
 
 &dmsc {
-- 
2.34.1

