Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC49DCA5FEB
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 07:28:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5E7583BFE;
	Mon,  9 Feb 2026 08:28:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KFXB/o2D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90DA180325; Mon,  9 Feb 2026 08:28:40 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DEC7839A5
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 08:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZSiRsI9YHLhpOKR8+RoCovaseBF52jk09AxAKULRGcb+Wk/BNZXqU+TLFyUV0I7HnDVI5O2GDciH5Oqmpe+aJ6LaUzPeWNvVFQMEjbYtr+Wq+d1lHy48c/QT8Bi7YWkjxt4a2/996ghr6LCS6RkT/4jMJEcdajc4VhNP90A41QvQS/lTrndyF1BhimlCW91S4Mj3fRgDoGO054TddQvZX+MvN3efO7bAJMwp9Aw3nPpZnc8Cf2R95fbZCDxismAV35K3KRxCrNfjf7Jhp0+6NNPluB4zd/rXdA2wBaBpmbtBhB4J84gY0l+PIl18oe5ZND5paa72pM1wuBiwmNGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6XcqX6lJdxr2lSzJg+cu0u1tx0/6RtAV/ZaXLPbSao=;
 b=eJKtHH1x4wpjaLDCsGglaO4gfBRNu6ERdaqedRLQKThVjAOkMoMZexrzkX1F6dQJ8SHU6C2IMnYyk6/IQTycArKCgGF22aQW1UTV5wd90QNKSyxvQl3RF+/4gUMNixCqzRaYJf2Qiabi81kczEAwDAIQYhfXKQy9HrOPocFZW15YVGfaktylJOGCAcAzhxp189XCjbDv7xU+nudOBNG+ucoNlzoJYvOcJfyo7GjbYQslypEJHieCo1ncpdeu3zRBJ3RXawfANouuvXu4uZwUlg0G9DNWQRcZBcxQBajoAVMtwl/G75CIa86g8By+aEsLYPdOSVWN3rSO+XbLywPSGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6XcqX6lJdxr2lSzJg+cu0u1tx0/6RtAV/ZaXLPbSao=;
 b=KFXB/o2Dc1pt3tHz7Jd+rASMfA6i+qiJIM6tS/aceDE/rejWjAe6o3vqjuL27IBk26dhFXlKZAdJyxUad4elNPBhWQfRwW2hHBRdwVPYcAP0dKQcxdL8T7vBqUZtrUx5IgY4+Ic25xdz3kwGQesEgE5C4ZfAH6DMTU2V9d3KEXk=
Received: from SJ0PR13CA0198.namprd13.prod.outlook.com (2603:10b6:a03:2c3::23)
 by CY5PR10MB5914.namprd10.prod.outlook.com (2603:10b6:930:2e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 07:28:35 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::29) by SJ0PR13CA0198.outlook.office365.com
 (2603:10b6:a03:2c3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.7 via Frontend Transport; Mon, 9
 Feb 2026 07:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 07:28:34 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 01:28:26 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 01:28:25 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Feb 2026 01:28:25 -0600
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6197SOr11146930;
 Mon, 9 Feb 2026 01:28:25 -0600
From: Paresh Bhagat <p-bhagat@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <c-shilwant@ti.com>, <s-k6@ti.com>, 
 <nm@ti.com>, <afd@ti.com>
Subject: [PATCH 0/2] am62dxx-evm: Add SPI flash support
Date: Mon, 9 Feb 2026 12:58:18 +0530
Message-ID: <20260209072820.2576854-1-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|CY5PR10MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: ab5ffc80-0e6a-46d6-1dfc-08de67acd52a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9vPYIGYoU1ONqBD0bcXNLs33dBJxWaVkscFCjHD38pUoB+KURmUu8i3Oazrl?=
 =?us-ascii?Q?ww+xnbPXJNiEI1cCfvvcDAY+cmsHce17iJSUhs4S6eT2+dsIIPIwsSqmxAve?=
 =?us-ascii?Q?/LXf6fviJ3NnTNmEk6abN1FqT1mbx5qqHrW9WzCKxVilCSnIyVh8y6w8Vx7F?=
 =?us-ascii?Q?DtqhMLXDXxMxb047D0wfadVLZWRoDIxOirmqcFI/6FIUsUpTWQsEKOYifS41?=
 =?us-ascii?Q?fTLu/47ysZnSO2fY/n9jy2xs/71aK1SyJO/XTdXNchmlM3aJGFL+/SW7rmOW?=
 =?us-ascii?Q?epEiZUCum0iMUU/AaCyVQ7Res7TV+y/rAfEc4Na3OrliNGSDhE3wIQ2vCtLQ?=
 =?us-ascii?Q?PDhCSTTquSUXI1X+4ndBgiUQng0HLc6E/ziiwROWXr0uYW7q+aCx/LbWMUaR?=
 =?us-ascii?Q?vlsVJ5CZ4d1+BiTW0vVPiYALVABcWwjd190NOvuqsj1dC9fPFc3XvkF34I/d?=
 =?us-ascii?Q?OfcBQl3qA2VrXZRtYO0z595nX6urn1FoH9IjMt+tzpmyehW8+fkL98un3NJ6?=
 =?us-ascii?Q?aUDlQydh+rTrhRxMQKZ0q0UIJUxLSe+sP6cTMfd/FbQqNg8jE999KYu7KcoQ?=
 =?us-ascii?Q?hfHDkRepuyDIle/1jg20/FNyuOGBkGbc8WvnxOxUaroG0SzvzO8lOQ0GMU6y?=
 =?us-ascii?Q?RX6ORc5go1A19WtgUvm1hjZj9OUSqGEZeJvk1lKACrDgJmo/vuyIj9V8hzca?=
 =?us-ascii?Q?VVJKtRvCCvwf0F0UmcHIRWZPrHFe11aymAJBAnErCVH3kqsQcZ6kXiAPqmzI?=
 =?us-ascii?Q?ePK5HOX9GP0r9NRlF6455PU4yv/+WmPnoTalrfABzBi4xPWVad+AHAUKcOrf?=
 =?us-ascii?Q?rvmLIm8GwWwaFKykPounXa9L9xxzm9mraqhJ+VcwbTlf+CF0GlGAlKcsxybM?=
 =?us-ascii?Q?yNwTjA4E6ZwpAlCdoUb9TEAMGmTR1ps0chob1ibS4zT1pqM5Bay8+siDyR7c?=
 =?us-ascii?Q?+T/W+Iv1OOXHMsSWFMd4vq+mpWQ9pTkBOgIezEuE1wHNuQq/CmvkVD58QhRH?=
 =?us-ascii?Q?qT4nWbuhJZf/67kV0ycfpnELM6szck51MmmWCXMlpMj0tx1kGAnLgG0rL3Zd?=
 =?us-ascii?Q?tZQMQhLSLL+8029b1pSf1+/+eBni3K9W2w+2jd7Ms6eTTiVi84EIokop5UrP?=
 =?us-ascii?Q?PyNJRyZlwEYCqAgPwQqiLbFr7qfdML+kD0Nmq/XXZG84Ndp446iGWJoJN/O/?=
 =?us-ascii?Q?zX4YrPw2h4ZJKElmodkAlAXbKcoRdo56AHg7kLFzFzwgPWIU9u8lkSzmpzcx?=
 =?us-ascii?Q?D3Bv1WsihnBdwPi/iJ+bhTfqBRdrtRgBNR69kPhYoO96bgil72HS+WJiDGot?=
 =?us-ascii?Q?cIUJy0r2gbZ8PP2law7ZFxMFyGHtA7RiWkyvgZrUfVrqG8k38ft0sT1+P5ZJ?=
 =?us-ascii?Q?vaVSeFCVm18Zmfj1/TqMkTj1jBPBUfzu/z6bIcNNKIBsQks0+y8L7NHNYS5d?=
 =?us-ascii?Q?pi40qvy2o8cGAFi+vyCRAJsnGgbkpluEgYtDlFhf2Ta9BW3uM01igm5UGa7l?=
 =?us-ascii?Q?6/6QK6tteOqE+VzmsE20w+fLk2rb2GWFHSaBlK3hvnjHvj7D8dr/f8nH3cnm?=
 =?us-ascii?Q?XUJtuDN4FoaIory35Hq/Qy//FTXAbcUyfgqoijsSxuLXzkFgB+hpW9tiYpTL?=
 =?us-ascii?Q?dw=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JjP7snC1+/KOD9EW+DAWhBQNO2Pr+jm7QnrBavFbgzdZvsfhBkXcXR6sziRE3lJRlRu8s7snUdio7Ut93eTXeC+pBkKk8NhUYWrozsALyHH/mbEYUxCSCeJCoGD41cA4uVrgEvyjuNWta9g5eURSpNOdu8wRId8USXlX1kfH1AXPw29adHcMqVsPl6cEgwH1RV/+vwOHRmb0YxhejQJGp16fU2yMt8ShsUftRXiPaNdGdafoIIXLuIJ9xiCK2WgqqB5/icy4OZAYTtr1ZXX9IAkrWu6qSnHc8JXgSKGaOSH/2n2WW9WTTSC43N86GCzNChnvmmXRy8iHbEADffjWB7nv3q3xfGLjYXf+v3b0vtkLaHZKian32LUgnnu3J37cTLv98t9fZdnAvMqDAuOBC9rN3uP1Uivp+Riozkf2vO9ra1Dl/KHP8jdlbRKwbJ5s
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 07:28:34.0135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5ffc80-0e6a-46d6-1dfc-08de67acd52a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5914
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

This series enables SPI flash support for the AM62DX EVM platform.

The first patch enables the required SPI flash configuration options in
both A53 and R5 defconfigs, including Cadence QSPI driver support, SFDP
support, and Spansion S28HX-T flash compatibility.

The second patch adds the necessary device tree configuration for the R5
SPL to support OSPI flash access during the boot process.

Boot logs
https://gist.github.com/paresh-bhagat12/ca9a05aa443c71e8baf6d8506f6ccc22

Paresh Bhagat (2):
  arm: dts: k3-am62d2-r5: Add DMA and OSPI configuration
  configs: am62dx_evm: Enable SPI flash support

 arch/arm/dts/k3-am62d2-r5.dtsi   | 18 ++++++++++++++++++
 configs/am62dx_evm_a53_defconfig | 11 ++++++++++-
 configs/am62dx_evm_r5_defconfig  |  8 ++++++--
 3 files changed, 34 insertions(+), 3 deletions(-)

-- 
2.34.1

