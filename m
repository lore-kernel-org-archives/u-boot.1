Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EF1C28B30
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 05:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5C3381BC0;
	Fri, 14 Mar 2025 06:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="mcg9QcDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DDCF80F9C; Fri, 14 Mar 2025 05:09:57 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 086E6808A2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 05:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQv8gvIRJboeKOLr8C/hRJ5YbYNUtwit41ivbXS2An0DVJaf/w1ueP/ngB17RXUBfxAUoc9hb/BLIQyGMB+c0AcyUcRemBNz1hs6IXcLwxexTtwa7ft6gD1BjzaCgSiZUMmOb7MJESzKUMA8SumSGWXAJjw7pa9VTO2NPicyoVYDjo5QmLLaSfOoMDYuNluDwwcrUUaT6dOOK+uYi6RC3E+1BYFo+ihXOHO3zXyRN6Yni/iZsdQK6QDPIhmSOyDKdP95nt4+rbASo9pJCQY4KOK9Wqdo2Qffj10baFuj2PSEbSYoSaBezSJpDLgxxRWmbk3QNQ/RTzG8YjyaT7Vt+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTbGCRuyKeqTnQRpVhf8NZWyqPZj7aF9fV6bcAobgeQ=;
 b=DgAhqkDqYzcjH352Cdmj0skn0EXWGMvdRnuhujT373DACR8T4hNMjpn5ZOk75i7Ny26JbEJdN+qEYPfXtH9egjn0xp4194xuOxBYNZmoju8pUV3sXul5yIVnM5DuTMC+0eSAqdNlGGpFLNKLP7AvPohpu/vYrl7lvb0TGbw6Iq8OQtNTUwgVqAkoLh0ewuHyj00DHq1a5BBn7RFDzjrbYDmEIrxisaU9661AKhJ8NSSWhLxi5CbGAQqmQZxOQ8txtX2eYml8C3f2mfPRQz/2edE0QqQjjb8+XOFvsdgB2QhDumcgdtdYyAFZ+13hTFsqS96P0I2NAI2ntJlI5ozj+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTbGCRuyKeqTnQRpVhf8NZWyqPZj7aF9fV6bcAobgeQ=;
 b=mcg9QcDJ+PEEtx6yNKYSrhuPiqOD3ycpo1MGOYw5jbFJ94Bl9IADpcVmCOmxgGyHMfPovKa9LRcWLryWf7x4Hr9Fy9iIkai2bzJTFMzHi6mydLoCgpOz7YZ9RLj1tyF9wlnMrQ8K+PGcpgSGd7VEqEMBj+CWln1igjOkLHT20uSvNQ+Qce00Ifd35elPB2UiGI9xNnapQ1cNVc+3haBlPoDD0/YCna5cbIGJHz8TZL7twwBBb/ADMadsA7nagT0qPh1O0xdiqhr2qjBBBzX9z+pgifMzHf3nb7hwWGHmSUhL1ppwQlEhO6i4ScjmdS0XOqM6qLY63SfGbYcZ3p1VJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB4387.namprd03.prod.outlook.com (2603:10b6:408:3b::30)
 by SJ0PR03MB5757.namprd03.prod.outlook.com (2603:10b6:a03:2d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 04:09:51 +0000
Received: from BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874]) by BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 04:09:51 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
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
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v2 04/13] drivers: Enabled Kconfig and Makefile for i3c
 support
Date: Fri, 14 Mar 2025 12:08:53 +0800
Message-Id: <20250314040902.43621-5-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250314040902.43621-1-dinesh.maniyam@altera.com>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::9) To BN7PR03MB4387.namprd03.prod.outlook.com
 (2603:10b6:408:3b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB4387:EE_|SJ0PR03MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c131688-7d71-413b-d6fb-08dd62ae1186
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8j6p+xd1oP5gqR+68ELsf73WOhjSK+U8Anl/TG0RYO7+bf4pdxXJDNW9agyF?=
 =?us-ascii?Q?NXG7hzXz7z2Gf3pOWygrnJT1INudmrnrATibBNVQwhnJEtGQoJmqKM6OaR2B?=
 =?us-ascii?Q?wzzMaHCDjBRj5ebxMHKX+nOQhTnXYXq3SLvkbdeuarN7HG6xv6evqRZ5onI8?=
 =?us-ascii?Q?3llTAWuQ3IcmXMwKqjGwnY88Uds/nqDsLlbyhex2+gUdTaTM7kk7Qh5UOwr3?=
 =?us-ascii?Q?DpDleRoGZoVg8TUMWP/9JnDwh8VdkLe97KgUuki+QRY8xpsRZg4NEMYSd/dI?=
 =?us-ascii?Q?Lu69DQMPYNcYKHeoesietrq668qS/rKLyEhPqGeOflmw5HKKYZ86zuKHFlfN?=
 =?us-ascii?Q?YG5UHRjWWHplduJ+ZQxrC189ehOtN8hkCqyiKBdposW/hIDIDCgHbXHPAwIv?=
 =?us-ascii?Q?WMAywdfVjOBkKC/tg1uOQcXVAw+o30jJ+4/UqxAQY7nwd7Ws8cmutD2gjgts?=
 =?us-ascii?Q?jyci6NUnsPgbRqfK8wc0QszILPzvwqqJnr1rGHlNKlOQ6R9tLpaglGsfHw9P?=
 =?us-ascii?Q?zX82pWFui/DWHiNcqNscjEu0HFrxcgszG1925s+T9nLtEDmj8hINOgubrzEB?=
 =?us-ascii?Q?99Aen9fEFWCO1+u95Ecv7ky5XWZj0UEK9JhFElJxu1Scup4uXX/PKYXrlbG2?=
 =?us-ascii?Q?c9Z8MSCAsdJ1vJ8Qg/HbWlW/FAbAx259wE8Ne7Eiw8ulX64ClXBW7pdN6TY8?=
 =?us-ascii?Q?bLVFAFTkbGwOKRQgzaM54KRonsFsqUSsuK+oeJhgfLl4S+Q1vm/klp3vZmED?=
 =?us-ascii?Q?4i1/qRyV972WbsD/TeFuO5wlDbyQClbcjo6T2RVs0IK4dLAZMTrHyH5zmKGH?=
 =?us-ascii?Q?odWRptv71PQ9on2M/p9aaitK3MNn2X3e6wZ0pFTiwylk6MCS5zrZpPLluU37?=
 =?us-ascii?Q?vMGgnxklX4LeXdpHh1/rR5iD5GsK2gdrLSmRuAx9q9FzGnFLGQzmuDLr+Tex?=
 =?us-ascii?Q?CMrDlgd7uALrMNChe49cr6ITgM62pDg9WdmbvFE9ocj91dVcVL/m3J/J5xgI?=
 =?us-ascii?Q?KubHOPpNPecfgMlX0zBMCMWWTMJLzDh02pea5lxOXtG3oTu3oynbtSiv4zfg?=
 =?us-ascii?Q?ezCZFiyqsVYNqpTLulBgjVBGr8IQuq4/6hatRg0pFc+P5x4B00kXSkJXe+8E?=
 =?us-ascii?Q?wF4Fj3/MWCl1Ab/UNFDKWhKHk8GrWiBkH34b/hnj+u3IRrigpQe4cMAG0iP5?=
 =?us-ascii?Q?9xvViwqqKeVz4N8uwUOBlx6YDIMH5LncUD3vCvbe/4+16HqjPDX9N8VC7C4c?=
 =?us-ascii?Q?zirltDXPHKctsb6y9ih6vqsHkYgp2NzeObcjd4oQEgGmx4P88IPM3DB5nhD/?=
 =?us-ascii?Q?CTRd76CXEp2S8IdTdW5EJLISeU2dgQetnNTb5G2THdGw2Q7Ro+uXzllurARP?=
 =?us-ascii?Q?lPOVwKVLT+KUnR2cWYHyxyDcK2uS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB4387.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0iXdRZK4YjlhkKekFGdA3MpqHOZShTwVXALCvQZpEB1O2BvWDjY2KJVWRLgF?=
 =?us-ascii?Q?WcbBCA83RYGuoE9l7xsGPlL21qZluJEJglB5CapoV84GwXyddlDZVurHr5Q8?=
 =?us-ascii?Q?Thql854w2VYeTFMI2EDekJprbaZdm2sBO8ng2RCQgbmz7n3cisuTi4hh/3yq?=
 =?us-ascii?Q?LbmYC0zktAY4BSjfV67TrhYLzEkC/+hd93bAg9Oq9BcExfS+TQ0LOTe7ov2y?=
 =?us-ascii?Q?j2hz6XdTIblQwkxV3/qvuNisVlDA+dQlaPCaw0SC0HLfHbl85GeJkEXhDb4q?=
 =?us-ascii?Q?bGw6vdtCB1RV5OX0wFA6qpE02mv6B9HIW6Ef0PsC9eDZMPx9dgE9O12me3gM?=
 =?us-ascii?Q?jLpmGHqXjrQiytS+dmrzwzb3yAJ65qIVwA7gCw9Q/JYx2SEWd4VBh3++QZmW?=
 =?us-ascii?Q?O/2rSUBlMnf3ZSKBmhnOL+TZCvtV3CorgsqUgTPk+7zqKFejvOhY2204l8vq?=
 =?us-ascii?Q?iNWMyVo461X4LdexZE1DBMkXAmHpxjrnLvLXpapjMRbI54INW2dQfUfNYXXE?=
 =?us-ascii?Q?k/mlPX3ll079UPMBgh/w/PjgkBzEEg878DVw5psrpx5KaYAzHESbXY/9nnfl?=
 =?us-ascii?Q?WMAPkLBvTXz0oyWr8gK7o9HVoUi4KX1Kq6cMtSha4IVD0amcNuuAocZbwShW?=
 =?us-ascii?Q?o724TRHvNW1iI3THigQLJK8mHNsFyD/nLNEaqaUvVTrbVxKIau9s7cndigmY?=
 =?us-ascii?Q?DYPOO9hAQzR/Q1ms5JCWkYeQyRPfmtCqdfnsdLoZfSTFm8Mmtq3sfYXS6DeT?=
 =?us-ascii?Q?RkTXyhtCooFsrZVtbl5fVy4HfoGbo5rVFTjJSgr5FSU69aqhiLuV2KxW6IZY?=
 =?us-ascii?Q?vusqStF7Bxsg0HkmLnwWHUt1hkUDQzx48dngEuFLGX6bXXSVqU+lC/2poOTM?=
 =?us-ascii?Q?BTdmiJKpc/6Q/3o/Y5GpBxtApiu33/L21Lpevzb3Vd3qxdjyyZmFUMLkMCGi?=
 =?us-ascii?Q?27TKd/QHqPxzKH0i8LVP94GXKgx5H8QHY2Gkkp+J2VjbKAYn3HikENq37r74?=
 =?us-ascii?Q?ZoZ6pqYCxTZ2dFftah3ASSJUSER2WxJFjsUUVCuIb2WttUZE/XBDTJlynGVd?=
 =?us-ascii?Q?heXeVuYPOcNH08C06KkRdNImcTm61UgouQiBzzNsAsyEnYmkP/Cr+yzJ0+uV?=
 =?us-ascii?Q?pkhrb15kFVbwVa3iRJXSX+q0w/G8URfAvxQ93t0icfHui7xMdR15MTX9S3zT?=
 =?us-ascii?Q?B3doTLuLfGp3PXPsC9JF0d5LxU73cikhm8XO3tLPS9xJNZBjLUrdfZ7qlluc?=
 =?us-ascii?Q?vp7/uo6imgU5crTTplqP3L9NDdSRV3hNiYBC6OeS+35yTU0pcBaN5uV4eaCW?=
 =?us-ascii?Q?0ePB7Y7o0mb1CodGHiRabhZZ/pYlePLDnTqYqt6/r0uDbcrUdpN9jAwDqczh?=
 =?us-ascii?Q?WqTuQ2moIezm+9e1E21I7S5cX8SBdpcbS7VvFrnalTOvL/VtDVx8TYpxeNCS?=
 =?us-ascii?Q?2WTwZcWFR1/zQ/Wf2mQFjDzXeoi/JBACeHwxR+oNukPSa+oOj5CYLmiDGQ8e?=
 =?us-ascii?Q?PtrdJO1zF133ZSBH5m5+4OypBP6Z/s56VbuL/gbKXQfOxVDyhlmIsI7DmH2I?=
 =?us-ascii?Q?7KPgCjlkWbkqAgMLC2MxfEM4+QCHC4csrT20S17j3O0HC6F82Aasm81f5lXH?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c131688-7d71-413b-d6fb-08dd62ae1186
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4387.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 04:09:51.7172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8ZkE+koIcyxdZdn5h8a6XfFAxhHEdRy9kFS0gTJltzuMaXtOWru/Q1x9HLjh+sfyeYWsYH9ljzTf9lKcg4nBLWlfmN4SCoaz9U5fgKyVzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5757
X-Mailman-Approved-At: Fri, 14 Mar 2025 06:36:33 +0100
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

Add new i3c driver to U-Boot drivers.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/Kconfig      |  2 ++
 drivers/Makefile     |  1 +
 drivers/i3c/Kconfig  | 16 ++++++++++++++++
 drivers/i3c/Makefile |  3 +++
 4 files changed, 22 insertions(+)
 create mode 100755 drivers/i3c/Kconfig
 create mode 100755 drivers/i3c/Makefile

diff --git a/drivers/Kconfig b/drivers/Kconfig
index a073230c26d..0b0c610e629 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -56,6 +56,8 @@ source "drivers/hwspinlock/Kconfig"
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/i3c/Kconfig"
+
 source "drivers/input/Kconfig"
 
 source "drivers/iommu/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 0e1f58c515b..fd155835ab6 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_$(PHASE_)DRIVERS_MISC) += misc/
 obj-$(CONFIG_$(PHASE_)SYSRESET) += sysreset/
 obj-$(CONFIG_$(PHASE_)FIRMWARE) +=firmware/
 obj-$(CONFIG_$(PHASE_)I2C) += i2c/
+obj-$(CONFIG_$(PHASE_)I3C) += i3c/
 obj-$(CONFIG_$(PHASE_)INPUT) += input/
 obj-$(CONFIG_$(PHASE_)LED) += led/
 obj-$(CONFIG_$(PHASE_)MMC) += mmc/
diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
new file mode 100755
index 00000000000..fa68612787b
--- /dev/null
+++ b/drivers/i3c/Kconfig
@@ -0,0 +1,16 @@
+menuconfig I3C
+	tristate "I3C support"
+	select I2C
+	help
+	  I3C is a serial protocol standardized by the MIPI alliance.
+
+	  It's supposed to be backward compatible with I2C while providing
+	  support for high speed transfers and native interrupt support
+	  without the need for extra pins.
+
+	  The I3C protocol also standardizes the slave device types and is
+	  mainly designed to communicate with sensors.
+
+	  If you want I3C support, you should say Y here and also to the
+	  specific driver for your bus adapter(s) below.
+
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
new file mode 100755
index 00000000000..5bb44a8d64f
--- /dev/null
+++ b/drivers/i3c/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y				:= i3c-uclass.o device.o master.o
-- 
2.26.2

