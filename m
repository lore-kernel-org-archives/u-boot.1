Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AC6E98DE7
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 06:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE97B83DBF;
	Mon, 23 Feb 2026 07:19:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c/NL4qIp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D123683935; Mon, 23 Feb 2026 07:19:19 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8D4883D17
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 07:19:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWJfDTsuv7qadEfa1eRx3g6q9CIPRrqPogGGjGHWgPSrwYHSuefo12XF3KN1ZB1D3s/TWCiIgLef6iQvtaRglwFc18Ye3kisuuJnIONCToKSIkhUOp5cYF+LU2CXIIKNk3AzpOM5fqFxmv8vQXObgkCkKsbz0luKW5BvLUIVOUcMMGnH6NPKwOx8e5IHpgiAow4BugM9xMOmaj+PDL4LPPYTqngdtbb4mkivfx95YzlZ+5nz1IhE8JlGe/YltbAfgg0cWPNPW5BQI0fcB7FakTyOW+UIbzxUv14Ricf+vn9m22WwW0EHSeDi3HaGzF0mSHFUVGbaXAT1Y9XL8Z+kTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIWYVfer/1H+hDPW6OvNigZFeS9sVomaqG8AtDRo0Po=;
 b=tUE9YH/tTMa88l1RL3CJ3PpCOJDbzmYbzuWuq1qrotEABL5INbEtw3amL091ZQwRNx5HTBmGE+hpw385uHq+ZTRdbTWdNTPrIamNrcQEyAwaRotYCzEJX60EQAi073sr6VxYwGp9iWriZnUFVsxriMTlmXKVczzvuZdJakYx30rT82h8/pSf7j5JXhb0z+uPuYA/eHuPL0rvP9Yn0/T/s+veR/H+rRxPvDIeN5oBenbzdPcR3/Uqc3mfMHjIvR6Qy8dYKEY8UjBOH14BuikCWBKKrKU3VwRG+QV+uNXRkOz+rYKVcPWtTmgVVIaISjkxYYGNgyCJPC/bMV48dydmDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIWYVfer/1H+hDPW6OvNigZFeS9sVomaqG8AtDRo0Po=;
 b=c/NL4qIpfZFPKkYJrcsKaF63vbJH004nfQBmdmsQrnhDso2rZ3OBzEBCd0fab3/FFZoimUwJYS4ti+eBc0NlNmKp/TJStx/6OTS2RAHWlbv6/hPeIYRX8OeaC7LSK99aKYZgWakPVNB9lCenu+h6roi+e4sVDz3iuSsCA7f0UkE=
Received: from SJ0PR05CA0112.namprd05.prod.outlook.com (2603:10b6:a03:334::27)
 by IA1PR10MB8211.namprd10.prod.outlook.com (2603:10b6:208:463::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Mon, 23 Feb
 2026 06:19:16 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::7) by SJ0PR05CA0112.outlook.office365.com
 (2603:10b6:a03:334::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 06:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 06:19:15 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 00:19:14 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 00:19:14 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Feb 2026 00:19:14 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.233.254])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61N6J7Xw3992071;
 Mon, 23 Feb 2026 00:19:12 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, <a-dutta@ti.com>, <s-k6@ti.com>
Subject: [PATCH 2/2] arm: dts: k3-am64-evm: Add "bootph-all"
Date: Mon, 23 Feb 2026 11:49:06 +0530
Message-ID: <20260223061906.1794872-3-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223061906.1794872-1-s-k6@ti.com>
References: <20260223061906.1794872-1-s-k6@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|IA1PR10MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: aea6c26d-ac2b-460e-17a2-08de72a37802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2irio15RbIY1JLWfATJ7eUevbkruAzQBC0i5y0FypW+UdjvtMROaPUW5cY1r?=
 =?us-ascii?Q?C390yr6rWyfJtj/Nndfk5dcI0hcnRKZ5qS34Ye/gxZtL0iDCSHy2PGlVfmQX?=
 =?us-ascii?Q?mI/mkhcir8OrL4SpXy7upTqzzyE/7Bl3h8QC98/hGn/2sJyfYakOUwW5kUrS?=
 =?us-ascii?Q?/roabl7ioHY3ChoUYaRanbF61qrd+HdoaimA2ScM4ufosen47iqYpJ4D3ir4?=
 =?us-ascii?Q?J9He5KGDZa2rqlPJg6cc+W+mg4ItYCQ43XDGnI/fYp0ie67X4AkqLewYDT2N?=
 =?us-ascii?Q?MF6la+wPvkBXizc5n8fd3lLKhPoNYKMC0tscVPFhtNIKUpUX9pg6m3YRkoTe?=
 =?us-ascii?Q?07WW8/BNvRue4E9Wg1XnZPYTTTXLQ0BAIlOT+QnlXqxPHE+ZUEh1kIzxKvse?=
 =?us-ascii?Q?W1NfDFW5jF/8FM055EnlGifK19stMFPSgZ/GKQgWaknyDyq2UXmTa5mvO8zw?=
 =?us-ascii?Q?taj+t6Uw4HcKnMSl5UHBCgofekpNm3jIV08cKIa8wJoIgLvqSO/Ka8FVpGxG?=
 =?us-ascii?Q?BboG5ZgElxRIG7fvHDmS62cByPOqQe9GVbhFAbYGM7U1YbUmN4xHrLfn7CO9?=
 =?us-ascii?Q?NgkCCQgSB7LsxQ+RKfj9VmxSKarDckpmI/C90cDkkXba0dT0kSOH5Mv7195x?=
 =?us-ascii?Q?Pi7M1jcPpoHx45wW75w3t8jVljBOVAliswfqID8AVn0bx4mRQ9CPUxCrIt48?=
 =?us-ascii?Q?51NE8Kzx20U1XjFXRR/aWHm3WTFUWaHhglJf3zlCNxTn+YiXFAv2mFeEX3mA?=
 =?us-ascii?Q?Q3v0gc26QxgJk7xdglI8hknCp++jKQFVVkoqyPdaZriOKgBPKatDdfmHdpro?=
 =?us-ascii?Q?02C5DYUH2J13mGNCORDHqs22RaPLtVsGkAfa5q6dSN19J2VhN9VvXLvVMN22?=
 =?us-ascii?Q?7FfVHiF18oyuFnzAkwGYiFo7Z10AmtV5+582dZ5EKAjumsI8gFLH6BJl643c?=
 =?us-ascii?Q?Gx8YWvUHQ0t4phUg4kd3Zd9Dlb2y7Pp/y1oBZCYDMxYwT0khXtwE19B9WAqI?=
 =?us-ascii?Q?aon0iqQSrExzMzh+69pq7UeNhJlLJLvtINU/Fvcyv+VeyAuBn6EXE61QrKOf?=
 =?us-ascii?Q?q95m+d6I/nDe7pc/F/X953qXAzP7xMht5QKmZ5tctg0uV31grmAETs/oXKeO?=
 =?us-ascii?Q?TlaaZHrM5DTrXmTqI+DsRDOpaoQpbazlA4IL7Su1XO5bfA+pFk4k+jPW11uc?=
 =?us-ascii?Q?0ESvj+hd10aP5BytBLEJ8xM9KX7C9BdtIDNA6QFVKZRiviLb6d5RnhiXu6yH?=
 =?us-ascii?Q?yGShJouStkqc5fvbwUB2B2Q+EmJLXfXq1Z08o5hLSg09mWUePzBz/4gIln5l?=
 =?us-ascii?Q?x2Oyivals3ZdmxBQSfohGrY6xQWQNoA166xwSynIkyKXqH56EoDh1ISOA2NF?=
 =?us-ascii?Q?yliUwx9zde7UGI+FbFrlt1fdyQ+jVgLSDRRwno4DZQiwxL3gidXEHzMMK0ZN?=
 =?us-ascii?Q?ipXayRLcCh07kJ1aWebVuMk57qqaY6GCy9pAaW7GLQIi/BBmEfpA9cGtXGqS?=
 =?us-ascii?Q?0k6wu6LaKqcK5FbBvc+lIFSuzqFAxv4rdcPypvNcTxPP3YMvcQ9yHAitieTV?=
 =?us-ascii?Q?fUXRVkkNR88nLMYLLu5fY8eDMFsyZTPRRJeoP/zo97REKl4I3SuUiJr1uGDV?=
 =?us-ascii?Q?8u3yb9bzJTNUxPqygRDM3GuvlJsH1uSIoJ/OqCVdqvwklLklhg/LFKFXt7pb?=
 =?us-ascii?Q?lXJGJg=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wyY6oschF2Y6rgDQ4eYJNj99+F6D2Ph161arf/ey/i9XLGhLNFVanHGIl53fK4pRFFgyWc1fnqu6E2PA8GJNqGhh/HIikIW0V9DMI0LiHgNlyRe+qmqgWg/YsJh+utlXsO0ZXEvNgmKRLabznGbu+nTm9G5FGLZh6Sq5OVZXKMrLO0Ly1UThloWTVz4gMSaPNtghkBpnS1TobT8gPyrNOyi5lqfXYCApzLkJp425Th9qL2AvVitFtFs6zyUIEB3H7frIzeJbakj0KZnCYW7KGQIqjs1aBhzsHkSrx5Syo5aMkO2upAPS+V1Dwf6eFkdVCxaAa8E5Bfm5k5Vw2Xcxlbpnnuzj5hdjKcsd9h+xtEosE8VFL/fWuCn5bOggYTONX7lQRgPZaF2DwbUIeOsKQMP2bO9YjoGzLoVFl+l6lBlS9VxBAt591WRziLAZW8cC
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 06:19:15.0571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aea6c26d-ac2b-460e-17a2-08de72a37802
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB8211
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

Add 'bootph-all' for 'main-bcdma' node to pass it to the FDT in early
stage to allow the BCDMA channel 0 to be allocated for OSPI NOR reads.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 arch/arm/dts/k3-am642-evm-u-boot.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
index 6469f43fca81..5048432ef8ca 100644
--- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
@@ -42,6 +42,7 @@
 	      <0x00 0x484c2000 0x00 0x2000>;
 	reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt",
 		    "cfg", "tchan", "rchan";
+	bootph-all;
 };
 
 &main_pktdma {
-- 
2.34.1

