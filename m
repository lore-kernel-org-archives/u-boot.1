Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE441CDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 15:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 399A6849E5;
	Tue, 23 Jun 2026 17:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0oRD1v03";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40159849EA; Tue, 23 Jun 2026 17:10:06 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E7A2849D2
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 17:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djNJmsUxLUwv5DxaN77LDmYhwTyiPWUSBZ4EZ2n/s1sZ0wvXNd3SxpSBdF2Xbz9+34fUfiByRaR23KCAZIDEQd4isKjQRezmv/Jh7l6qgm3wZwpUy7EhU/QwUGDNrAMKQZTJwM1r8QGay5w0kcV2j6G8V1cy6wHk5dZAi2H+lZKU9RMzkC1rq9gDWEsQkKb0qlm5UBmyOkLq5+wY8bYjLWLdRXxpYr/G8/mxeHpftRqyahTGWAVpiz+1A4A3gYIhVRn/mDHIW4WM4yyWnWT6fvcM9LwzVn50ryFaYAfsls5ELSwJcahARK6uBIvH09AHjgTJnNPVl2AV/zdtgYVGCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJSpVhAtLkrlfp/f1jQdDydJiWMqle/ME1dyT5s3v5A=;
 b=Wju9Kspgoa+d/GePACYG1Abg8wgG/BhT1wHy53h59/Z+HeoTZ72Zqrr+6AozejacXX+tK8+3TDzzx82LM2vek4+O7+gZWWTjhEOWf1gMKbsYMrMwNdVh+n1gC7wHQylFDUIqcCMhASVRcMtFw3/y2rusepN3Lby/5H8pdnDymE0Vn1tNYuYG4xV2GcR5YPK4elLtsh7UucdZQ3sGCSUvGhP6Q/5piqL+yHy6XxdwLUdyLvIDeN9BZznMShLY++WGfKIQeCpnrNafvzdw8Bdfup3a886QbmLOm6nvBFZK99JjN3QljW+TpvwRkN0s5SIWgkTratruUS9wQYyXTwbg8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJSpVhAtLkrlfp/f1jQdDydJiWMqle/ME1dyT5s3v5A=;
 b=0oRD1v03IefGURkHKLRRHP5mGvWJ+IEkEv4Bk76Kp7wu0DQWAurjKgrhQo3nFBdoO82J19jU8pdpuLsxSzbElHANXfvnQG7uAhhyEi1LvPJ2BmwG8CK2peUe4cDNvJBBWsl7rwpyvotQf7XtTgy11KAJVjfDWUBBJ36laoFOguo=
Received: from DS7P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25b::17) by
 IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 15:09:57 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:8:25b:cafe::12) by DS7P221CA0007.outlook.office365.com
 (2603:10b6:8:25b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 15:09:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 15:09:53 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 10:09:51 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 10:09:50 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] soc: xilinx: zynqmp: Add TCG variant detection for ZU3TCG
Date: Tue, 23 Jun 2026 20:38:22 +0530
Message-ID: <20260623150943.2662500-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 367db43e-dc92-489e-3fb2-08ded1397a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: B7GH2HLISiCleMT6WPEU9/2uoVjND862hkaJPSUpNGQKe9Ow9mwAiXCKt+pcMxa1FSLTY+ZF8kwkNTvbG4Qq4G2SpBYs4mbVhfM3ilTBqXMg8Qob6ycV2o2oSfV1idmbgYsjsBonY8Bmyb6oz5enUBzkQPxjQ9Up+W4aAJyPS4Vok7oKoxnTBD6tC4C2Dd+YrAD+Q4kiigrRPvAla5WIFVUBOT2jKkSZ7UASFPDyytvY+atxyJsxMlI4EUFx298aXHVbjPaqWstPDUDaDUAh+KuJQ4ETTon9KGOWELyXDOCf74e0TX97iptzdolEmU5UP1M9g6ASgmzxyNVZSvRZN4XRjHfD8QWOrlSMeIN8xXrOfnIMFgji2lPHYEn1rsirZJwc1GoZW4y3ZLLtRaMYEXBLZEQBNoR3PIHqd6Hlr8gvv6NyFcfXVsrEeh8xeBprmB3oSQ+wuyh5RfatVh40EfkBGLmr6YjSRuKp/NFndeFClK1QxZzpJUdOyhV5AoNhE1CgOQg3Jm1G1N2u6nXxJ6oHvJz98CeU4BXsQI3AucykupQcc+9Cev9yc77fYdP8gtjRskxdcNZg8/EJb2m0F3JZ1t4ffkCbJrw+oZHjwPMzZluGNLP2Jzs5YP+mEPjjk3WYx/L2IQbrWz2W2jWkIrOB0tbO5G0IZLtHrL3wDIFQfZhg6LyO0blNyuJXZF8NVDjqgLn3YRKnq5nk8RzLKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vc8eg+IG1UVjQBs9wDrGPGxaljIn7szIjxATEgWOa+rLxyjTCDgeb/HRx7eRs7YIZ3CaHdscY5AU3fGYXsqGJrJVLnYUZ3FFWzFZy7yWND/f62wOu7udVH3HipAbwqzHyFTsU9UqhhvPNsMd6DERH9+iMWggCeUzJKwaP2ZOpZ3XB+pK6nz4q5tDSEwPIr1uUoCCro0Uv5tTPPL5d5APsKI9zClITuhRr/WtbnulGAp4pVVKrd9anAi3VY5bpWV1j8gXIn+39Yn3+xy87vmnv/BLbFXdcZzmve1WcCScJSKcJRowhOBgdQdadywAG/ujIrzR+NVQsOnKOfW9iBFX6FaC0tqk/1WmokzPNNdRU/Ym+pxoXqZ83lCMFeS+NqaB7YnbvEiaxJgclbD0wbCEWYWp95tw2fFhGyu8IUlKZuEx+k/5AVyEvIxDwIDzIi9g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 15:09:53.0891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 367db43e-dc92-489e-3fb2-08ded1397a7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662
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

The XCZU3TCG device shares IDCODE 0x04718093 with XCZU3TEG but has
the GPU disable eFuse bit set (Consumer Grade, no GPU). Previously,
the TEG detection branch appended "teg" unconditionally, causing
U-Boot to report the device as zu3teg and failing bitstream ID
checks for xczu3tcg bitstreams.

Check EFUSE_GPU_DIS_MASK in the TEG branch to distinguish the two
sub-variants, mirroring the existing EG/CG detection logic:
- GPU disabled -> TCG family -> "zu3tcg"
- GPU enabled  -> TEG family -> "zu3teg"

Fixes: fa2f0c97af96 ("soc: zynqmp: Add the IDcode for TEG variant")
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/soc/soc_xilinx_zynqmp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/soc_xilinx_zynqmp.c b/drivers/soc/soc_xilinx_zynqmp.c
index 4abc73013eb..0e13e230914 100644
--- a/drivers/soc/soc_xilinx_zynqmp.c
+++ b/drivers/soc/soc_xilinx_zynqmp.c
@@ -358,7 +358,9 @@ static int soc_xilinx_zynqmp_detect_machine(struct udevice *dev, u32 idcode,
 	} else if (device->variants & ZYNQMP_VARIANT_DR_SE) {
 		strlcat(priv->machine, "dr_SE", sizeof(priv->machine));
 	} else if (device->variants & ZYNQMP_VARIANT_TEG) {
-		strlcat(priv->machine, "teg", sizeof(priv->machine));
+		/* Devices with TEG variant might be TEG or TCG family */
+		strlcat(priv->machine, (idcode2 & EFUSE_GPU_DIS_MASK) ?
+			"tcg" : "teg", sizeof(priv->machine));
 	}
 
 	return 0;
-- 
2.34.1

