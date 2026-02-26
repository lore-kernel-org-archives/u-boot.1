Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26222FC5915
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 12:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9682083AA9;
	Thu, 26 Feb 2026 13:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kBi72A6r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7275183E61; Thu, 26 Feb 2026 13:08:37 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB53E83642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 13:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2yhfbxXSch1c/GVM9AoYYjmiEYvbvIPKpnkeE5UFQFmhJffaD38Zjtae0kuFYIZUnAjp4BEIuL/m1F27x8j2SSH62aveZBTIxnSAt69aTWCR5EM5l1/9bgiRxUXam48P6f/6H9kUQwoEntkxaRxzVPK55hB26e+nr+WBrS5ndIJ0jCg73rMNBwFORh7qaoj3Xb0sBD2lCxZA0oVgz9RfY5UlDQ+PVErEEVRx1cklKfhQiYLOHuaaRzuyqcRC6bMJCmRTjJwEk0svy2KZiRakptCNmQYP2TuUgl7yfTFfEDUxO8H0bzYoquk1ixBszkv1RO8d0JJcZSuWV4ozPdPSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhkHriDtcPPx9gDs7Cag60ydYoMhvzwH22mbUX3Xmi0=;
 b=ksip9okapqQszhdCyvntdHhYZLHA8HB/RewTbfoIx9D18oZh2hlLQ8M8p+LxqBhhGY1j4Klkf1VXkEfa6B1r9jIBTLVFILaYuwQAY9qVCkuNiX+hkSSbuwDjfV/TBryOleUdhYcJZFm7kcac/DBxlfKc2QpfmYIGi6M/iTlRdOpfj6dahr0pEbkU2I13JVPkhfFrX6qNK55sPBo29pEgLAWlw4lAvgaWuvk/7xM93d6YAvfkeToV8NJ2mdQsUTbR4coghjUMDXNJSLiLEBf0lGW80cFpLlzSDShRy9bfktMjNUjNAHx+4YpDjpXYSHReh/dlA+20O9Bx+6L7uMZaGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhkHriDtcPPx9gDs7Cag60ydYoMhvzwH22mbUX3Xmi0=;
 b=kBi72A6rCSM92Q5Nx9hXs2jb6MTRGdS8e7PasAbWtY7ubhj7nEWwanjIMIpebHSVaz9SbLKwESS0nCkNjqIlxAS5bjUYWnqTe6aWQVAc52YjMNAVA13f9IAXwryD6UaJW2uVOUz9wzRRSwEQETGcfLFvN1UvyYTeabiWvMVwo50=
Received: from CH5P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::23)
 by DM3PPFEABD4EF1B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c53)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 12:08:31 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::ea) by CH5P220CA0024.outlook.office365.com
 (2603:10b6:610:1ef::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 12:08:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 12:08:31 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 06:08:30 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 06:08:30 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Feb 2026 06:08:30 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61QC8RJu2328866;
 Thu, 26 Feb 2026 06:08:28 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <bb@ti.com>, <reatmon@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>, 
 <gehariprasath@ti.com>, <s-k6@ti.com>, <n-francis@ti.com>
Subject: [PATCH 0/2] k3_*: Add config fragments for inline ECC and BIST
Date: Thu, 26 Feb 2026 17:38:25 +0530
Message-ID: <20260226120827.2258728-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|DM3PPFEABD4EF1B:EE_
X-MS-Office365-Filtering-Correlation-Id: b7fb08ca-b282-466b-60d1-08de752fc1fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|34020700016|376014; 
X-Microsoft-Antispam-Message-Info: OwRkr84c/dgZR8a+4e+6a4F3La6D7plV/SdQcypa9eK3/HCXXSzSAA7Y/ZN88sNAdzqPgHWoxzvtoBfQYu6ZSDIYIolE2yA9f7kyY0dz96fl38JeEtYna0fuazIW389xFBA7A81yCEmau9+Cw0Fkeai36Nf9UlUJGrle+uGX/joV65fiJ0YYFc3wd85rE3FD8svWekmPwj/6/6TZyp2a1EniTlG3IPjRVfBSWePqLY1dleGIRM5BNecgc/YL5/yY0KbZPHoND2Tz7klTgGRPSgnfvhi3Hjl8AMY/00NniKDi/odBS0o1zuo2x+vO6jB08XJqXKkY6c2i+6OiQ8/BgAkk6QCdqL+ycJYnsFwtNvTV/ck3QNtjTufdKPr9xeNId9o+yBRY4sZ6YVKc31QJM8Kxtp1c6xM30+euiXBtXUmAYObcyHKl4VSmM+oPWxyEE76Tw1BMdxr+BqNhmUeMon1/Is2kl/LKRp4BD8f/kLG6K5Wvgp0Pxd4uPvOA6uDq/Tp1vY4bzzSDnk5WW2Vv9JS8kOv9iT2TGBVpo+R7DewRTObfw2fdNCFUslNBATwl7BHa/runNYPZoF/g19qKwt3p7Re3qd5zRfN8tGhDWh9OjNlQYln1GaheUhwzCczqn2SdKOTDrkaegAS7PilSv9aO6zpbHUBiwR4JckXFDYJ7exLqtqAuVIdZygB9tJO0bcX+n+gC2dFQmrOwdKc0UmZA+Ha065AQ2DR+60wR8R5BRfoyyeZP62wv9wi7jjaAv0tnbFAMlNEQ7X2azL53tzzK+yh6nCxIKgC16x2Ba3M=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(34020700016)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a5OFyDFDTd77qqiXIu0/V2FadNVx371k2BV+xt2EO1lQ6SCmvSL1uFfDRcImO2h0adOG2fAu2tUxAWTUTrXb0PWN91nm6uQBZv7Tdgdd6gSwb1FuzvfrSD/pUvc52WpjGsdaGL+BVYipICono9fpvlLHZyjbNrIRTBrcoNBBgDgy7V7fvFfTKaztFmnuI/xRT8NmuhoIbXHtnlNyRxIZFEafYqO9Resxtf4YRsUaGJYxMKXJnPfCqaGP+go+9Yw922kAsiohMjYFnMK2gHd3I3z+gxGA8H8yZXs4+O4C8rdyK3+x5AwAPSlBqKXKPtwdBOCmQEhGDpJ1iNTX5XU5/cCJzgUru/+ROykwOqBKVIJNVhTvz1+imNrTSAhbaoJHPydEa5BY8VZlfHswiYk9mLaoCV8ylG/Nc++SmeWigO0lO0aHNsQlLiwyZPA0wgGs
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 12:08:31.0627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fb08ca-b282-466b-60d1-08de752fc1fd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEABD4EF1B
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

Typically we do not enable these configs by default but would still like to have
the option to start building them in our default build flow for testing. Also
there is the added advantage of users being able to see what is needed in case
they choose to enable these features.

Changes since v1:
https://lore.kernel.org/u-boot/20260220091532.3584771-1-n-francis@ti.com/
- move fragments to board/ti/common (Tom)
- add doc patch (Tom)

Neha Malcom Francis (2):
  configs: k3_*: Add config fragments for enabling inline ECC and/or
    BIST
  doc: board: ti: Add support for config fragment builds

 board/ti/common/k3_bist.config       |  1 +
 board/ti/common/k3_inline_ecc.config |  1 +
 doc/board/ti/k3.rst                  | 55 ++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 board/ti/common/k3_bist.config
 create mode 100644 board/ti/common/k3_inline_ecc.config

-- 
2.34.1

