Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD61EF48C4
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 09:14:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DFC083AAB;
	Sat, 14 Feb 2026 10:14:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E93A483CF2; Sat, 14 Feb 2026 10:14:39 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20728.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A466083AA7
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 10:14:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3hSR/K/Gg+C2zOm2OC6xj+QjwNuMIwkonheIfq4xbXoScz4/bV/PjhatktThE2Q3kzBi/m4b4dkoyrrS+maBH3fh+quWK1Gwgd7RT5HkS7NeWKkhUEN2MpgAmJtcEt/KwTw6wsQKIssy0LIhyDRwmeNuUPc4EF8CCimC3I6WjlP+mIsduS95Z+eZmqs3737AzxTWC05PVqSPmXkAXaxoNKXsouEsP3u1cbSHYSAKplQIXh1ViXpscP8Y84U5qNytkOfguetByOvPe10WTbswhXrodZJAxCSCHwsiusi1UPRG+Ly5nmAxQIvr1LUgWK1oGPJZ+6lwoS/9lt1GUZJOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0q6OpRmbnJlVUC5MIzCuzypiWKq/cmlvPZrdTZKgWEk=;
 b=m9T6NodlUU8qc7myH6950bt+FEOJShhO7O/ZlrWzK+wAx1Vml6iP6Xf4pqWwJY+CHcwHhcsBibkU/ELzChEFgtyFuIFVYDcz4svU1oQYPd7qFpp4pYn7jVRsiX1avKzZG9t6g4Jzpqra9vA+nSXLFB+qfHwYrzB2lEd6M4qgneRT7+iP7cHj/XbyTJTr44ss90FiGK8H++kHTYA2xQezUBZPaX2fxfJYisMe/NE0MUzFGQf8fKaFXiYb9FOF86kSAeMnLKnfMw5zxeFcg12FebgJja34LKoL03zPPvSsiR2H/tDIPBVrGKtEfOKI/fTvXM+UHmNvy2wS8qxP71CoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1324.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.23; Sat, 14 Feb
 2026 09:14:31 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%5]) with mapi id 15.20.9587.022; Sat, 14 Feb 2026
 09:14:31 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1] configs: visionfive2: Fix the name of VisionFive 2 Lite DT
Date: Sat, 14 Feb 2026 17:14:24 +0800
Message-ID: <20260214091424.28428-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0030.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::15) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1324:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3b5e49-6488-4c94-b833-08de6ba97650
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: B3+U0U3Q8z8Or3L1IGuOOOua6jjF4IgZRi6ynxEVrEe15gskeAKzHHrqOt+/nDkjUm5P/opWGKym3PSexnjxOCrjfbxJCrkwvPJjKm3lRYNuLe7MACrQuh/v8zPYFBwmkJHJ+1Ds5jsB6u+Axn78LnnsAxE5HAJgmwtoyPkcLSdO7RRCFmPB/DlX6o0ZU89JdCMz4Nk5B36k1enzJlcHr+3UxJV1P9rzGj7Gw3ub3TrDpokSEmjF61vxkplZNQMR7glKuQKcb3yQvOzvM8w3lUuHrW9sabMJF4HkDtfU0BwoisPieYwJZGI56m1lcjOPGMPCbEuwNAsz0jG3TpGUzRTw4z6eJqbz/ED+LFvVEYCXFn946RsG/2fif//sb0fZYrB4H1WiwF8V9M0jAJbAn/SY2YnOHstDb3cMko3EsMaJCYH/dKoUF+I5oQB5OPfhl1FU46RUcCPccFGP/AABk410gOcMlyV+gO4tg7t8pqhsxH/GB+IkBfhJe6CLRcJUiEe/svvQKmYr/3rdtoQUCp13vFXZacLAowq5zG/1K/E1s//ppNRBA3ALyEHoGc69/OvwyMonu4NFgVorr+gspA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fg6ivo1JnVQZIZuvUkAe7OhFSATvtpiilGoTnQP3dqrQ0RgRe+Wk4STjTPtI?=
 =?us-ascii?Q?EOr9y398zd1twANa3tfd8K3vKcAlepIrpb6SYiFZQ9eaiSw0p/BELtRB6RC8?=
 =?us-ascii?Q?ElWuHkO0LdT1H0mA6y+ugWby8U1PKDHsaJTs5G0hvJobsBs+YroRjJRGtISQ?=
 =?us-ascii?Q?35RN4TcGaNxDshx4NXaMPF1kXgMr1ZL3ce00yi++5R4TCOkASnrP+2jTEAqo?=
 =?us-ascii?Q?PD9t65qpEG69vOjIxrmwpM/SFpqOQ14JH+Q0E1P58XdOaRH17iXayNSh3oYA?=
 =?us-ascii?Q?Z/vYWB7JozmUtm2jihtwgMR0gcj1GAx05VaFfQpOMuix2tuMsRsYisp3Bb1u?=
 =?us-ascii?Q?Nkv8uNnfMlWl8cRzX0jI4sNC2EYhzvaeRJm3aRW/L0khycRq0c9u04n63v+g?=
 =?us-ascii?Q?weZ/LPj2DfQ/To9w1bYNNiUfXZD6CYEpAYnOJcHx0qJ33NyTAJ92Es5z7CUv?=
 =?us-ascii?Q?utO3H/N80q6mRQtBjws28YGfqgu6EyJtxglT8/7C3gbq7R/D7XOZiOn2fhpQ?=
 =?us-ascii?Q?HWga9Kkke4kNbDjKcNYq/IP+plpTtL3XUfbgx6g67Y+KDF9knXg6P6OgY1xh?=
 =?us-ascii?Q?oXxZSoZ5KmgXL0kCg3wv13O3MCnWdgNHSHVT1o34ueVW/U5pVtxOwYDWTVK6?=
 =?us-ascii?Q?onLJY20u0yb1mcsXyXlD3xSi5z8qpA8GqMi5WrIk1s+psqSSWqfXPkswAwi9?=
 =?us-ascii?Q?+uqGptQMsBSpH3sGRDJOgXtt82rJjmpydcVg9kIlvV8l6YboaAmG12i2V5vI?=
 =?us-ascii?Q?hmHEuyDh1TjNY1nTQeNdNu2O0M0ZpdsS5oN7GVZAyIWIclnAtwHnMxoz/chl?=
 =?us-ascii?Q?Q18d7/3VezzbJt1/xW7OCPVQwfUIQtRwaFRyhlamvbYE25lljsSSSc5W4g7c?=
 =?us-ascii?Q?eaxgTe7CPJgRajuN2lzZZX9PWwBOwblJqFkAQmIq0OXAhujFmu5LY/nY29sO?=
 =?us-ascii?Q?IMn+zTntL/sKfeiOmRZVOCNUCtU5AjfBa2bnyoi59Kroliv22JM5jTkfORoM?=
 =?us-ascii?Q?AcHMpTl1jIcVcU60Vq8Z1M4m5m7KyMGVASSwCTunDv+cjn7xZMgEyXUKHuB8?=
 =?us-ascii?Q?uGSM85P63YVTzWnReL90zX7U8iefplww0g3XLwp1Ru4CHm0NU3oBjfHwMt3Y?=
 =?us-ascii?Q?BjGd76CCDhPuiwVeiWKZqBL0Kzn0D9fv+q/Y9VOpgd2sVopfeF/CrEAb2wVN?=
 =?us-ascii?Q?VDwAc4JoeelFUSp/6sj39kngQvf1ag82BXYs78V9NlpywYdMLUVeuWkbNHVW?=
 =?us-ascii?Q?9oWTydSqrc6AsmdIQH5XCB+kfckUt3ELzfHbEHEuQmdd3tWmkADulX/4Gciz?=
 =?us-ascii?Q?J3Ez/whug0o5rzHOl0dU+eMVe1YzAUPArI+Zh2gWIJ0io3LU2iexwjNuMEJH?=
 =?us-ascii?Q?6foRhEaHENembYiVpMXVkmohAnGEFvVwzSkpejb6NIpVyRTAvvO75SNA5x14?=
 =?us-ascii?Q?CQPI5T6qpRNrulzK++L+P0D8Tfit+BSA949fSvyMHk1g4vm6ZK0HwHTz0seH?=
 =?us-ascii?Q?b9+o0YiHuD3yOFe19I7pjv0yxN9uX/OKbqFR561hYcPijeAnYbCy4aj4VmhE?=
 =?us-ascii?Q?fxBlUzangmt6KYmmXIGC3K6DPW9LMSciNerVZLMCY0i6aylUjSpoU3Nh/La/?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3b5e49-6488-4c94-b833-08de6ba97650
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2026 09:14:31.3015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQSv3C4ARKhOc2HGWJWQFImySL3NC/fMDxaHRcvQmv9P27z6OE3WkQN3v6iXC7/leysQ/vOC6KxHiQ6GphtmuI1gMo6G84eji2MeX6mlPEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1324
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

The name of VisionFive 2 Lite DT was set incorrectly. Fix it.

Fixes: 4ea3acc000a7 ("configs: visionfive2: Add VisionFive 2 Lite DT to OF_LIST")
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 configs/starfive_visionfive2_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index ef4acf7c1db..614a003c971 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -80,7 +80,7 @@ CONFIG_WGET_HTTPS=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
 CONFIG_DEVICE_TREE_INCLUDES="starfive-visionfive2-u-boot.dtsi"
-CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-milkv-marscm-emmc starfive/jh7110-milkv-marscm-lite starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b configs/starfive_visionfive2_defconfig"
+CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-milkv-marscm-emmc starfive/jh7110-milkv-marscm-lite starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-lite starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-- 
2.43.2

