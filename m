Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B055EDEC03
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 04:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F62083FDB;
	Wed,  4 Mar 2026 05:22:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="aUVibwxe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B24B83F61; Wed,  4 Mar 2026 04:46:43 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 445BF83E7F
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 04:46:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIc1TZRwh9V/4IA9Ok++Zx87oY5D3bgvc2gW5TT8K2jojad41X3qI3gFEnlnbLqXTmiCzf38eurq4zPGB372pLtVWG/5fBuQcIsWuxAWiStHT3tz0fvQHNVH0pDV/BA3/YG31c4tJLfug8pGbgQE0q/dzX/CgYkMigbyhk/xM/Qqhgz2O1y4sKrNZZVtCMzUsRhU3u9BqHA6IImYQZ+fh8ldmpvnfq3PQ9fm4jEQ2yBamath+7769U8ADDdt6Sv3b8N5pvD+tGtgTG64AVotiYXyd7qUoYaul3Xd8cJPdMKpA2Q/gO2rAw/0vhdUpC3Z+rveOro+B9RFNfjMkFZGxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SM9/ESF8nvyTKoZIxB1pQm3E01P/n0NOWlhx85HiM4E=;
 b=XUYroPfO5EB2ZtdcOGiTVPwrsRzCapZtm0uoMmbYf+mOQyudB2WT7750AWdKLQv4mT6DyjqO96U2njI0rKdQ/J4j4qVb1Qm3qtbbxXwx/MqxNeh0H3LwaxNDxkRr/MJ3l8kNFjgj1PFAIPwYybq6lC8jZCHUYh9pUpnJlOp3IHnysnzW/X34soccjsrvsy7zjGuU3RtwOjhN2/IyodPLMUrZgCEUBAPjGrUlFDlKMNGP3dXQJ2oELzi4u7ph1Mpem4KD3pw1VWOdyHXZ/INmfcfoBmmZWq2MxgaE2yByib3gQ3kbG6aYvMv7TGKwX7+E5TCyZ6NrAny3Y1N2zEKo5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM9/ESF8nvyTKoZIxB1pQm3E01P/n0NOWlhx85HiM4E=;
 b=aUVibwxePeA8M1uTKXfgT97QbDf+lWxpIm1D0xifcwnlhz/1yMwuZp0Ml/0V9gmEnfrFNKWNpMPf9YF8Nb/YXmYQpU+X5FHZ/Sd2ia3S8qQ/Y4sO+YPV+OYKUzQQv/QY3YE4CUu+W1lLph0te8HK/aLh9aOQJmLh8aYWR+Eicn1LTVVyJdAdoWbfXRo4xuuu6Q6gxzZL6VpSLZeipXIhHyP1MM2PW8Cf+quCkaAp5tJIuSPvni6SZZXkHI6gKAVKGkV6wZ8k1c8tLRjDuZruFNVISZ2IbTSZ3GY4iOEeqC0GVKJ3WVEWPaesh/FaG1vKBXTEcRJdXTZEqCLUV47fgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by DS7PR03MB8072.namprd03.prod.outlook.com (2603:10b6:8:252::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Wed, 4 Mar
 2026 03:46:35 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 03:46:35 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1] arm: dts: agilex5: Set DTB filename and kernel node
 removal for non-secure boot
Date: Wed,  4 Mar 2026 11:46:23 +0800
Message-ID: <20260304034623.13323-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0390.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::35) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|DS7PR03MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 52892fb4-c11c-480b-db49-08de79a0a1dd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: ZE03m5qK34FprC+Dj38UUya0SQhQ63gzpytxtDeRJj9wsnbbO0Bwccdshg8QAeLbk5T64WM6IKyOkYIgkFW2Njd8urhsn4x1ylolYXtMsFMi5TlYpgOsDSR0By6fcD+TbtX6mb4ypZutMTLImd7HOYLvkpEQpKspjoE2m7aiZ4dRcod+XKvpefHoS2Y0SUTkTIixzNpJuER4K6sQ/RFjfANd6Nw+MOtXIOtTknKHPJZJjRbm6Y1HaQGCmMu4487xc4lsSrqffj/Nwb8iZsoxQu72et6URK+tiF9BeZiCzN8vSdYH2Bp/vnvz6wf9td2pxMY2tNdXgo51AxyYX/kBPIe4najp7GcdmOklUyTGDX98yVJdivfWAjP6R+VQGYjo+6IimSS9yXFqe3sxhxSfWPyHaIp5Ce5it7xiQbnITUfR6Wo8zP7V6yzvEkGhGKBZqcZku3cwoDUQs5XgjBNCnmeN3JFTeHKDzzRfUw1EQbFHhNsYdwrf/qla7L/bkOBcLorbcnYJnKPfdwf6mXewIQqWpwp0bx3mKzwMdUwjsF8Zg/JxdcRyZAAanCGrgQj9tiljcGNWuxMY/8vVRsMI2aexEfahYiIlRGRXp5fratak5zNPHrt+ulOMq4DCC/f8etaOMkrvf4Yg+EtPkuUsb4yFtWA8JHu+P1Z1tdVp+5rZCHu0w3hS+eM4/zA3xlN/rc4eNLJfJfHkpDEHwbY9elL+a1TdtdhYR6of9qHThNs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1d38h5j2FACPcVZohEqCBmXFSkGzZnb8VFoWcfOVcDioKBjLh0ASk8M+LK/D?=
 =?us-ascii?Q?afmSxf8MbrI7XIJ7KyfpkErLZTMXkaNx317roK4G9LEQDhHgg7BOC+KTvyMS?=
 =?us-ascii?Q?XKABzaksg1Tbka98eyUnq9SzDYsBJtkkXI6ACKJbHfeU7NpVfg8T0UhqsOBT?=
 =?us-ascii?Q?pVKiJ78IPMdd+KL5DR4AZwB3k1Sq/D7XB37L4HWm948Q3tfK2anRWjEa1IW6?=
 =?us-ascii?Q?UfrgkinlZdaEA1QZPYePgHeGAIWIgDKrybvZzuZvNyzZAgWBqlKCJJsIvE3T?=
 =?us-ascii?Q?ip7m05bpAFn5mReOOqoE4yjelxvLLWFDRllQHWOBPmbr/vMm7+RzDLxJuzh9?=
 =?us-ascii?Q?GdSR/mYQd4iK7fBrk3co0WVz3MFND7u7C6qTShem7uqXOTS4xt3l6FZ0RK2l?=
 =?us-ascii?Q?V6h28/gGINSyrwlY6rLu7nXmZRZcYtb9X6EHgEoRFy3VCi8Hqf4shNpYI95p?=
 =?us-ascii?Q?6tBw+Lr5k4LvFui8rm688Dj8WHWM2IvDnGtEUrm4hRNQ74+lGTVMzAsysp/7?=
 =?us-ascii?Q?9qCoNo+HUJLZif///fCoO5TNJtpTbkic6vRs4S52Nt7BT2S3hH7iRlPdscSG?=
 =?us-ascii?Q?NcUNtMpUCVwuLe68kHd0sZmM+oNmHl+P7MCECnJQv17dKpmPu9Bm9C3TNMTN?=
 =?us-ascii?Q?AX4v9JcJXZoA+aVsbT9dQx4zpXz4+pgWrelR1441sblO0Q/clHmUe/KFPdUr?=
 =?us-ascii?Q?FyQHMtPLsNE/VLggkbw/oIXDMdSrt7vGd37t8qLegyT5lvTYMGJcPOxumibf?=
 =?us-ascii?Q?cy5zgfRAEDG6ZHZlTdA72ljMeO5vlgSEhM8bkCT0szavjBAxyNk7qVMnLrec?=
 =?us-ascii?Q?ImViTkmtekxyYp3AYP4aTAJz46mK28DfHoaK3hMFROdXjGrk1n5Lf1sxnlj9?=
 =?us-ascii?Q?eyzwWc88AG6HyzxlcDNfpewAEPU5/wNuTP2CIoROwHENhY6Tr/z8+Mx6j2a2?=
 =?us-ascii?Q?rmeIEge9ycOmtcLp0/ERf4qI9Kj5HnjgJpxSLyHeMaVw602xOcZOR9Q7dkwJ?=
 =?us-ascii?Q?29jM4S8zPBqsBZG6MbGjBvenCuQ9fEk+BNIUqXpV9XY27mRDpCbBFwWmvYjQ?=
 =?us-ascii?Q?WYLGPZEVbhPAbETd0p/L7sNXkrsSq3SlSVJsM3HKduZXWpz58wmqNWVBAdjR?=
 =?us-ascii?Q?8UCLm2AeD9jUUJ/VZbUrA/A0kRAyBSip4cY7EPfg9NMvcBghzzv3fbjuLNd/?=
 =?us-ascii?Q?t45m7MLQSGrYAQOb5a98x57h9mQcBWyTVEtJe3keOVBpwGS08T5+Wq644c+m?=
 =?us-ascii?Q?nug/rY9YTfIxk1mT8BudhfMWVtapWOQlZ6NpF+c13jRnWpFhwo/XEboo1PxQ?=
 =?us-ascii?Q?zGY0sHimiUFL7w3sDJd/33DPll3PVMKJ2rioI/eDGoC+Y4CQ9mdH79/cA1tB?=
 =?us-ascii?Q?ysjcwQf4vBywGg6SBwVJsfM0cTzL2xChalfHgk47BmPyQrj9gApiChN3t7ba?=
 =?us-ascii?Q?0OlXqqtD1tzWmFhhGT5nXflQxHt5Db37gIsHLEhAsBUcfc+hKfTSbNTVMwXw?=
 =?us-ascii?Q?2UqUJk5MgX0PHhIXx2B2+58T8TGboOYr78fL08kGF67Mk4k3P4aB0sWkCOjj?=
 =?us-ascii?Q?/TJZvqjP44Iee46/QvkPMLnoPnSAtZZXmrnxkxcDqretIFnzDxHycSQaPPIf?=
 =?us-ascii?Q?yOxlHgDlEB40ZGmRp4Dq/S1X69HQvGfVORCSFK9Hk/iZhLyZExR6K9hYprGq?=
 =?us-ascii?Q?sOhzsT2Xx7CyKwJJ3vBJK0XLazMYXiNhRXY5I5q8SEfi1V+OaowL7xNk95pv?=
 =?us-ascii?Q?6fijkQqvOA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52892fb4-c11c-480b-db49-08de79a0a1dd
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 03:46:35.3756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRh3ZJklN4nI8KK/wN7WSAXKr3RH/sNyP3GLK6Z6ri+A9YoFgt+yDug6/Ddh5QD9Adc/xYOzoANuygzjgBjDjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8072
X-Mailman-Approved-At: Wed, 04 Mar 2026 05:22:07 +0100
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Set the DTB filename in fdt_0_blob node and remove kernel node from binman
node for non-secure boot scenarios.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
index c03f78b2fdf..b4b8f54b969 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
@@ -217,3 +217,13 @@
 		};
 	};
 };
+
+#if !defined(CONFIG_SOCFPGA_SECURE_VAB_AUTH)
+&fdt_0_blob {
+	filename = "arch/arm/dts/socfpga_agilex5_socdk.dtb";
+};
+
+&binman {
+	/delete-node/ kernel;
+};
+#endif
-- 
2.43.7

