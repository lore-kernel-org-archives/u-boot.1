Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D19C83F26
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 08:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF18C8329C;
	Mon, 28 Jul 2025 10:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="iQts1PmK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E75CC830B4; Mon, 28 Jul 2025 08:57:43 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1B2182F00
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 08:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yx61FGQvISpF8uCJ61RZYQbIZ3cjq2KHBcmO2eaQqsEJ0mPhPc+t6HIxCXpIsDuzwoZnTxFKY6y+cKlokp2F/bML/rLAg9FBcjMJGPebR1CUUblG69H08fQKa0zyFraEIA18sLyjIszAaGZx0iMr+6FLv0CsVyklru1wTzb+mqxrR5cM3XIqDmE+WG2MA52QshilAJ5MeXKbfMzz+50uK9q7vqx3B2SlSnZMPLBhxRTIia+2Wns26OcycVmJTOT4cWgapSaa0+P73J1hI/IAeINasMPHZi4/i0E0eif+Is760KOxe+cOlwxMKaGJ0CynaoY5xowm1XYOgyNKdfJvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVVSGD1ofmaYVBq6Y0Lx8x2581dT1Wn6SWTLRFi+Er8=;
 b=c966a/KFySeMIsRTpvkW2IqL2CXNzcOqHncXDnAt148PVjGdX6o3bio++sgYgY3DuRqj8orC9oQbWdKW9m17MtWBu4Rl1IHOr/+oMw7RjzObM/stfLj0tj7B4wBO5CIxzYU27s8b3g035VDg++Hg/VoHmr6Jdq/rbp9wTntH+ea+6L6kRWY0PB5yE8f2VihZtSsCQowZQQGfwUBQ/IQ7dQw0LCWvcBWNzVP0nND8+2wlkJvVO3YCfp+IaCt/yv92u8V2RHGcI8oN0TFdtm0OFnH3UVWPnV8w+ZKsVlr21zQlbc7dyK9SYP2vvIqkYMnuvKZCq7dIrJaeGQB/8w9E9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVVSGD1ofmaYVBq6Y0Lx8x2581dT1Wn6SWTLRFi+Er8=;
 b=iQts1PmKBZcxUMrVktFR7xVC7XFKKQlXtdLiGoDadorFosweqfcwufziwSd3SWepXkZvAJVUSCeTUwjaGvunwoJYlGXyqWzHWYxWKDDhT1ta1BUKY+9AobLoF6gFtv8ED2ztmE8TSqsXdgaDGKxp6oO0MVSL/M3wx6xVAeMF0/qxeHlSV+inyu8/vmifyBzBniZJ2YlI1UrC38AeP5D6bcJSm+95cPqJDRqo+8kpPC8AXuZt8bS+NNdPrLp1Ll49G0XY0sxvDkdwaCcXeoK/u/WQtfqEgrUY5fE8Vj8lqnGc31OumzAeSl+MYXKR3NdqWH11UKr9myoueh5H5Swmkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DM4PR03MB6128.namprd03.prod.outlook.com (2603:10b6:5:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:57:39 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 06:57:39 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v7 12/12] configs: agilex5_defconfig: Enable i3c configs for
 agilex5
Date: Mon, 28 Jul 2025 14:56:12 +0800
Message-Id: <20250728065612.6039-13-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250728065612.6039-1-dinesh.maniyam@altera.com>
References: <20250728065612.6039-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DM4PR03MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: 8682b651-5382-4455-46d3-08ddcda40a77
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yH80tb9aRb7JOip76wWZlkiKMy0XtH29Bc59aKGhpaahlxlmqpOvfPe9ltf8?=
 =?us-ascii?Q?2imySVH7o3lNlFAG41DVI/roV6Lo9RsKC58eL4JRIl+VArENgC8HIzG5SRUH?=
 =?us-ascii?Q?woU8z8eJWSjx32+6kUBDSOt+4I5tXpeeaHwKxotenc/9K9aqM5Fmwbr/Rdz5?=
 =?us-ascii?Q?MSZa/0aXk7RlywniySALp2VSDVpg5mP3Pl7YrWH3jSxxOwupkMejdLXA1NTD?=
 =?us-ascii?Q?Y2T46aJgpzFGssbLsnEfUrUXodnNQ+INBjzy/5MfyqfOxNuB7zUkQ22/fjo6?=
 =?us-ascii?Q?6C8oXIs9cD0f40Xrxm3loNZeeP2vn4KUxWiZNW3nEY+0Yt/VC/5cG8hVLXOq?=
 =?us-ascii?Q?mJkA45GR3KFASfs7OgugEA3mnBhs07RdFlCbJ3SeV5MYeNL2ZgcUx3y6T2mX?=
 =?us-ascii?Q?Jhc4JmtgtaMCIODJW2ftZTtm2RD3j7n0CSEPxig9k17e1hpORNRMms6R2Zd7?=
 =?us-ascii?Q?pgaFY3qlQ3c5GIElISoeCwu1ysLEgoq/x0+8cL8YahmBVpA27B2wSGPmUZRO?=
 =?us-ascii?Q?QOmQBotliLDYmL8uxB5BlA9izhZx8Ea6QFyLiT7y/tKRJH4pQBLKFy5u/H2E?=
 =?us-ascii?Q?jrIo49VlFxZ2X6Q3mKCzivrLG1XOGGkou3tj1Yh7DjTHKLtHKiF4JIQVA1qP?=
 =?us-ascii?Q?XDLltkuFfU9cx1wVIeTvCb2lXgxWDmkGEr+KsEBmRH79FVFn3wt3jUzAnRtD?=
 =?us-ascii?Q?KgEcDz71sfFvQvnos21Cz0cW69Q+RvLhntYgZBu2EM5doEerVicwNWrPvZmI?=
 =?us-ascii?Q?lQmzG6mi2kwyJFgOpldsja9f3Q3bM/0rxmb9o4WVJAiHP/FcM9Uncudao9ZL?=
 =?us-ascii?Q?YmoVQx1GUgGN9Bzd8rlqL3amwy1LuAyuA+dHUj28/CXRUtEBYctQpNK/X0AS?=
 =?us-ascii?Q?ubHV/nzxvpiRtiOICvSs/XRF2V1HvXOyrOw1FYNzyjB7EXJnToP5YjQ2D29D?=
 =?us-ascii?Q?4MVzGqD1HbbC3WAEkk0QHalFWnS0dkJLsKkR9r2Xy1UufdEMpo1+KJgGEwkr?=
 =?us-ascii?Q?Jy4Ryk8OuXsinY3wW2wveBpzoJNYSw29tp/HhbkkMygs9z5DqNceWuWeTqqF?=
 =?us-ascii?Q?jgqS4SFMWYBQhQZaeux13sU766kd8jb6dfyg+h0tphBOQtteLVI54dfeeDMV?=
 =?us-ascii?Q?gc+nfBGEqKp/nKAe4U8697sDsd+96vGig7V15Pk9HWh9VztIRUr31uGgY3fA?=
 =?us-ascii?Q?HwSk/krcu4zjTg1D9V8MR1GI79qDsiN1mHdB2bUSfosXeYyJsKcbKk0giQtD?=
 =?us-ascii?Q?Y6jiP5EON82GmjuD/gWTv4j4znH/Hq3GXn61Rq8oRKsLl43cEVilLf4Fsjjb?=
 =?us-ascii?Q?YthHuGIGcltrS4LQRkD3Wq+keojyI6H2tZ2dEnpvdKqZ/FUHm8DVqdIG6qSW?=
 =?us-ascii?Q?gzk0lHGwaZLgJQHf0PJYi6ulY3UUKp6CFboTjb7wRbIy8U9PwkzAhZ6x1ubl?=
 =?us-ascii?Q?Hy5so9xlpvA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ia4naL5AA2+eDiHWCC1Rm2XTJixkzblBE4Dk/3G3IaokH1eaYgE0bYKh5YKK?=
 =?us-ascii?Q?cIXYrQ97TAoMn3dlmG0m3BM46Z6c64alcuX0r7LHsEx2GGFmpnAsFrdBlGOm?=
 =?us-ascii?Q?7Pe0/h+Ln3hRe10+oOfsWm3nTkUwbaAsVTxuu0yJSlJc0Ec+BzPyiLr8t4Wa?=
 =?us-ascii?Q?iwBvNT+nkp/CVHwGv3At0xh9ek2eUoDQ01bqCLKymR97Ziy2BKWBOjVBfWbM?=
 =?us-ascii?Q?tgBLM8NxKzZPD1mVMK7ydyHsAOcWdHkSs7kAqznmKbiLg7veiNDQcMjKBPB8?=
 =?us-ascii?Q?FWSGHt8hnvEz7e2CulVxDVc3C3YxrZ3aMSvFeyzbn6fxSzKoyiwp8rCRi0s4?=
 =?us-ascii?Q?b3Emcxs0sBaTaWrXJpTe1KgDH4rOyLkysoKS4D4jVGK2qIo1dNaIY/v3GRdV?=
 =?us-ascii?Q?c+83sjbwtE8KKRnQTIxiwrosBlAINXa6gUxwuXxOziEByTFYpRXZmmgQSbg/?=
 =?us-ascii?Q?fo38JCtqjntqReiPBonwdqaoMLu7M0Z2NQ3+OBC4A4oRodsoV8qBrcuyxz3x?=
 =?us-ascii?Q?gtvXUsyTfrGjZQxPR+vwWCF4bAeqDkYL0L/uIcHIKhYv8jR+052I9MGPBf32?=
 =?us-ascii?Q?J3mDVWZRz7HDSHDFg5qzj+qa1CaqiM06CXIVT5bVPqATam2aQwxh5lDqtB4c?=
 =?us-ascii?Q?+AXXaq35ZOGS3pNoXjouYpqbZVnylXg8DDq8+xPYPthLt3U5Sphbku+RYSas?=
 =?us-ascii?Q?yJ//FhxnSl8E0Eap2io71fcx84nz4Aj2fD6Tj9KiV9UldGkp2jVmsk9oSOuC?=
 =?us-ascii?Q?J4tJIVMG0Z8L4Skhhc3LbCSV/nXf9V8bUiERTx0jI7443C1U+f3cl1+nGGHm?=
 =?us-ascii?Q?5T3ni9sPVOYYq3eYcjlpcb5FnKbd/8tJb1dYiWMcfe5j5bpkdcQrM4Bsd1v2?=
 =?us-ascii?Q?+ZhXCCn2AlQUFJCtaQw8gv/TpjYXtl1j8v4iof9Deh4wBFwCn1gQ8ohjaNiz?=
 =?us-ascii?Q?/iL9nwb4h04W8rj+5e2SrAjsHfL+oZQWCRZVSDwN/GHLK4m8MqbmLmAdjQij?=
 =?us-ascii?Q?SAq/WUurg3h5yLhHiX/UelnX6eVK1QTPr7pxkgPbzvprJjx+sxC0XIoAXdLn?=
 =?us-ascii?Q?EhLUGIG9+c7mvPYVCSrgQOiR/f/m5KGUPgAmRzqio3KvKOLCgsxuD4u8s/L+?=
 =?us-ascii?Q?7O7eUqRFF1IxlF6V623VWdEDXO1RKLwBMuU1Lc4uLFs0wbOJn15GvYwrlt/Q?=
 =?us-ascii?Q?HxeDfRn0oSTjdpF2AH+prqx4pdmKBHfPd2Y+VhfhDCLUF7mmqCRAsbNjk+4K?=
 =?us-ascii?Q?zY94C0a5Ghb9PlsRtR0/idhAeQyEAZs6ZeBXHqbdh4gF/MbxQZsYgme/858j?=
 =?us-ascii?Q?qLeJwPVP5FJTzWzteUXaZ/SqOJyC4+6fSFXhgHROs9+HB9pnoeHsffwb67Fz?=
 =?us-ascii?Q?uiyLwj7MIVg7TPxWqdFmpu7HVqJ+KHyzrEJ2t9b/CIBYtS8l9Ioz5zEPwZYz?=
 =?us-ascii?Q?We48+xJsbul/J8rAoCpDhnB4axeWEZY6OaE4z6oAwTiyJ84cJb+aKFoqACZO?=
 =?us-ascii?Q?N/uUn+sNr89tqB0fhDTpizBva9Yi8NIXj/Pfqcdc6AHycjVcTR/l2wNr3Dqh?=
 =?us-ascii?Q?rVE1pQqkDEz1R7IUwaBPqQYYLlR2zbvdmt6R2jagU6HEQQGg97xSm7Z5ZMB0?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8682b651-5382-4455-46d3-08ddcda40a77
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:57:39.3506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eT580hGYYD4YcY6OwZz7StE4TwC1mgtQD5dLZA9m9v5Pmy2llPl/VTnqMNpqJSc8HzWPuo1f6CSQMFoMeo72In64ZCcELEGNmcBUdZYB+58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6128
X-Mailman-Approved-At: Mon, 28 Jul 2025 10:46:50 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Enable configs for i3c in agilex5.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 configs/socfpga_agilex5_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 8577ac610c2..87febc9f4ce 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -44,6 +44,7 @@ CONFIG_CMD_NVEDIT_SELECT=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_I3C=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
@@ -66,6 +67,8 @@ CONFIG_SPL_ALTERA_SDRAM=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
+CONFIG_I3C=y
+CONFIG_DW_I3C_MASTER=y
 CONFIG_MISC=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_SPANSION=y
-- 
2.35.3

