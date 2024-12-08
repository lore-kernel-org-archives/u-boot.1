Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED697E7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 13:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A23A895B9;
	Sun,  8 Dec 2024 14:25:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4746D8952E; Sun,  8 Dec 2024 10:21:21 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20706.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::706])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4BA689516
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 10:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCHfNIt2Hri5dZnt+UMr8xGEXONac4KnOFebsU7RNOXuZptSVYAsWOb8XyduzMimNtdxQf63vGD7cNOmXGOBUgVfWtMr3lQOYu22xuuvaH73A9ps16anvjGxdHsiosAErYbXZgcRJR7z7WtaV0Rdl8WhONo+onS7jVPYDS02OB1zjmsbh//fmUuN5cZni0BCimFNv173zkgh+RGhz+mTg8PoZCJC3VDbLvK4XOlU4wyInnY85nkv46poVCBw6bZewqbLIsQM5kRpu2lusFiX77keyhnZfcpLTxdwSy4ZmFZBozgT7RlAgvVsoqmFbsiJ0fS5uKN72Y9fKhi7SUEJLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PhfK1Aez38T8B8hwbTPB1trx4DL2yc9VSWaZWnMtEc=;
 b=AOqIaSlGMZhf/y3z2QdYBo/7f6X0FSNPIySGzGygXGApjB5HbiSk3UDODMMK6lMaK7mmef42E/TMvbKKfiNzGew3Ev0uzxzMagU4knL+TGa0N8ZMU/YQ9vs4aAEaUQkNA6CGtykYUA6LJ5M28aG/pz7zYJjI2gSzlJi2RGGUSAg5UHGkChuDv4r1dZIERERbYO3NRSpzjxUoigs+HrtHhCk9xChc2+0GULwzaolX7tkvcwkm7FoP3t/6RplPFyo6UtQ7eI1B01UV55uIS+k0Z7RKdCCTKaG1GBZHrddq9ix++SmER6Uir9xuE7gaPUJI/67nikyzyeMlHuf9DmLiHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1226.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.6; Sun, 8 Dec
 2024 09:21:36 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8230.000; Sun, 8 Dec 2024
 09:21:36 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v8 03/12] mmc: dw_mmc: Add "starfive,
 jh7110-mmc" compatible to match upstream DT
Date: Sun,  8 Dec 2024 17:19:33 +0800
Message-ID: <20241208091942.47298-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241208091942.47298-1-hal.feng@starfivetech.com>
References: <20241208091942.47298-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0031.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::14) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1226:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e82ab4-5666-4a68-8346-08dd1769b6b2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|41320700013|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: b9XavESy4E0Lb+m3uRFt2dtqpt469xVRy2lNkUsgZggxPnJGRD/YV6r2YxkP8nsdMTNj6eUf6gK3+faaqKZDvoeVgLPEyUis4mHc7UvscQS1MjiTIpeVPSFJmX1G0M3piq8yIk72VoVcT8PCaGqqdYuqmptY8GzMIPPtqShHSt6p6u4BoYNvW0h54GoeRqKJGP9mc/neXSRgFv+20YVASakuH5L8koxSGEQ6hMWp3A7stkx4tMNInwSMuZc0NxmFcLf84C9Rszq7oyh+fxsrXV12nGObQ1yPmMb/gVgbrOJypA+ALT9r0xuJe5e3ALvfU5elvs/YhJnkiW91C0hwaMqbX8IWklKKFNlfQy10/kvlquJWYfDoNF70rpkMIcnsrr/hCtk2pmunDeGVBSHbMGxr1ImOBIX6dIpCs0QlMhQmZsQzTrNvT931V1h2o455eM74G4xnHUkGAmenGe2rL2M2Ym7/JFlA4TMANTNnITrTTeh+Ecd/XYo4JJgjLPmwoGJCEKB88kA86ZPT4ESGmK5zZiY8kPmFGZSULRG871haQvsmfvQPeVFTZXyQ2fjlnwKxbC/7K7VPtmmgWFPXfOgqXgdBfeGwB++nL0UQkPhVKYY7qNRDwLvUdWyoujrFHSgG/R6QtjPOuqT8AedESw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(41320700013)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MU93m1+PfUJs0Yol/LnmoZB3m++y7ErxhckB/Y+K8HWXLcuSIyDXRvy8a56r?=
 =?us-ascii?Q?7/FSjS7s9nzZCh5PgVEsXfJFjFz/Z2aE7jyagtESbXYLv8pPSCbyB6cRXMaa?=
 =?us-ascii?Q?tIK20s9zUkhiwWPMdJrC/PtSKoRnwPOK9dWNK694uk0Zi/SOMu//3SeQAFVI?=
 =?us-ascii?Q?ofEbHMjOnt65xwDL8moTJmgMepAm0kafBzt4z3PzWdUIQENMFwcD9lZrsdZg?=
 =?us-ascii?Q?4pb9HH2pRXErZEw6e8AYp9kqamWhhTa9oA/EqS+OPUYny/13qZuoXuerixbz?=
 =?us-ascii?Q?8Ferq08NN63KhYmCtmCr0no6bfzcATETlxP3qkrRvMo2mgzM86Cm64YWA/7I?=
 =?us-ascii?Q?p9TMl7yVahzd7DFJ7D4toU4ACDsbyHl1rsc7NyNOQ92/Kxd2n3PGWpi8/eVE?=
 =?us-ascii?Q?39kr1SN0lJMUt4NMeDzpf43pU31w7j9TlveJTAurtjMAhD1wbsMA6lc8pAD+?=
 =?us-ascii?Q?AhvdrMPXmDIsr4UQcrcQ1tRG58IP3KFjdNgy99JrNpvw7JMGLLV+6Qvhixp8?=
 =?us-ascii?Q?D/E20YUy3R98R/b2132rPzfrBYCOiqPRuBugDnoXOH47qQFYzHVqXmT9bVYK?=
 =?us-ascii?Q?rM6AEEcx+VPscmsIVmW1LC0RTw2NrEcCOij1zMi5F4IvsF6UmgamoOXMq6Vh?=
 =?us-ascii?Q?0mFdo4dOE1V4BUNbxXyzh/dWjCGkLFIhnnptX/gzcoRcfdcNFWzv+EYI4zM5?=
 =?us-ascii?Q?F7X0Y5NCj24ThPPgWX1bY5pbXqh/VcQYqfqTbmC5ty/d+lJvbHlVMkqaHdqR?=
 =?us-ascii?Q?hq4v/FsoqgQ1r4eNbh9L6ditE5ZCEJfCf2JG6nyDjUf0jLoiBf73CpUaI7Bt?=
 =?us-ascii?Q?QEEgFketH3lYc7YNJpthS7gbtOm1thhimKEk4a+5JRe6g996nd+BaXopnAnL?=
 =?us-ascii?Q?j5yW7EAQaFz7++9gJVinQuQ7GS0RY6dHpyZtoHzYz0j0hg2M+mqNF6cPMSeO?=
 =?us-ascii?Q?EjZZBra8Mn/n9tSJ22RWI2Fd97hxXGrb9rXuhitldFv5q/cUIrBrv2YFPiXK?=
 =?us-ascii?Q?XEHL5ckCb5/FQwOdPIBPYTwOPT2cSeKA3oCkKdBj///GWiYPTNRfGI5l6foS?=
 =?us-ascii?Q?XerLRBaER7hvbYfIzSxBEkmaThvHWd/breFzjF91NZkf/ae5nFacWoEkULhu?=
 =?us-ascii?Q?ppIkTNibZXIetmpKCnHRx7X5cVp0IpQ8S3e6BqJVXP/dVkUSwCGwyC98J3rI?=
 =?us-ascii?Q?Cd8PrI7tBmGSsqHznX/9NEYAztVr+VI/lzvHiq0m0v1VvcSUwwI7AXT2+7mp?=
 =?us-ascii?Q?f2fKVaH8UUbDeWf3xELVCq+2rTzVdF/h2o7cyFHc4JBhIao2mEJW+Ys+za3l?=
 =?us-ascii?Q?NplPpse8UI27jRlMVffvqg6U00bOAuQfMF+VolrAOUSYwiCq7xTIYSp0uXBR?=
 =?us-ascii?Q?bL7zdbJt3eAIE4VRVcQe7PNxLJsKNOe3SuYiJztXDOwNe/G6Lk6tiUvJaGia?=
 =?us-ascii?Q?5I55zzqnsUfUG8E/jX+tQFHwYqunEFNSo8/llmDeXuydoQ56R6WjfKJZKnO5?=
 =?us-ascii?Q?/9u5rF7JP1DgutjSYQOoQtQK4g3GrS1nR9bzU0Ft7F8AGLQjYawJQWtPCxbI?=
 =?us-ascii?Q?XQC76O+KXiKr3JOyh59bQ4hbX3p+VOqzkKN1NS+7tYIN896wVYuhLC2rF/gQ?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e82ab4-5666-4a68-8346-08dd1769b6b2
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 09:21:36.2129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12Q7y9mt5CHL0tAmOVDd8bpgOSULeIvnf3eL7MKVr3lzdK1RvuhIfKnc6HKyA3VYtdlARYI/sJXtFH7XMTl3gGVg5lz75UFwpi5HCUFis+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1226
X-Mailman-Approved-At: Sun, 08 Dec 2024 14:25:45 +0100
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

Make the U-Boot JH7110 MMC driver compatible with upstream DT.

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/mmc/snps_dw_mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/snps_dw_mmc.c b/drivers/mmc/snps_dw_mmc.c
index 47ab5654bd..92880e0ed8 100644
--- a/drivers/mmc/snps_dw_mmc.c
+++ b/drivers/mmc/snps_dw_mmc.c
@@ -186,6 +186,7 @@ static int snps_dwmmc_bind(struct udevice *dev)
 
 static const struct udevice_id snps_dwmmc_ids[] = {
 	{ .compatible = "snps,dw-mshc" },
+	{ .compatible = "starfive,jh7110-mmc" },
 	{ }
 };
 
-- 
2.43.2

