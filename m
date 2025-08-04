Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1706EC87FCA
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B850F83DF3;
	Mon,  4 Aug 2025 03:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="MYUSkKYe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6699983E16; Mon,  4 Aug 2025 03:25:26 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 670A783DA8
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btmmQ9lF9AL7dv9J7ljZ8WXhGoSZPGSN4H6oPGWfMoSy4CDamHrAknn0swjkt62CBZJHtU719/0v0Jr1lEmUT0O1j2XQwK+sv3LC1tq4yS6hnTW9TG1ZSNOQq7Cf2NwTAVa4ZzSXSZJJhF30pAFJ39j29dTKPlFnndDzHgvkJ/DZxhPL+qgJZK7litOGpkokxfzTeG3O1itLhc/JTNJZdYIOdB4SdnYfN/ZAa/veBKDM7mGY1gKLSNCA9/kG+SFAzuE/cgrB2k7Qx2dhqhArpJJijq5DJ7htO6wlwddzu/kn/nHGI/mYqLPeifckWrZDzJvWbMsyDPEHomoe/hKQAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4ZemIa63gYtrnS4SVlPs5bgMt4mM5rpc+aZ3UjLuSI=;
 b=l1Qg7iqJ7EJ/0v1xTV9JD2K6jKehWSyGaopVTw5tvm2Eq4f0kgXaLG1Z75vM2pdCE0OcwDpQsGfh/tne7Kecwx+N9Tug19tJUZ7XrJWr0IfIUbmYtKJnfI+bzyZlMlOGBYxz7a4lZWuRAdEo6jT8cn+9rP97ntbm9oD/Kvvkq76O7MZ3Jd1jwtBtBD7hFJcbwvAEACFQcoPUAm7yyKKKD3QdHMb7S5eXXByOjYUZ17DUoMPC3khoq9oLwA4BKIyv86m3xjb/R6pFAwq7XrNIWMOIDlyQRw9gJW36wYCxnPlccgxzqbYDkFJByoiZ8IBNAym9xw1GdqlP45Jsw2aEGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4ZemIa63gYtrnS4SVlPs5bgMt4mM5rpc+aZ3UjLuSI=;
 b=MYUSkKYe5YSNB2+fjldMIxYIysI3P6TLvtJsDPWQnVjO7h0slOjLnBdFxuILOzEdFxWrD1c4tar/TxnqqJml3Dgu3Ld0YioN9bThrkDG8JqXSe3dAESnc8uQAqI9zEt7dLUDWHfZ9AkZK+ipBcmy2pSvgNl2rYuA9ZRKv4lIH3N5dz/34CfJmkmuQ/wXTkzZzYFX4aXAbxknIrOw+KqOf0q5qlw5bAuPWwAdPViZfreMfX3CTQtX8ZN0+Dou3Dj8e3naHjOa8udPgmmKVej012oSqo6LQq0QzTk/bzMjHUGgPxDHQVScYPMTeovFE6xrW8DCv0kyx7vtDO/kYyM5Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA6PR03MB7973.namprd03.prod.outlook.com (2603:10b6:806:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 01:25:23 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:23 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 12/34] ddr: altera: agilex: Remove code redundancy
Date: Sun,  3 Aug 2025 18:24:39 -0700
Message-Id: <20250804012501.21811-13-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA6PR03MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c50a3e-c02e-4685-bb0a-08ddd2f5c882
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gAXx1D7pqUISceqfBbiKy1Ld1xAGtz1nV6BXSPnmNUM4P1jAt/iVLSQqj3nf?=
 =?us-ascii?Q?EtZ7C/EgkHA6LdAip8OEGsK8cifChRzvDZWveUheaA6v6w3bFCZiPo7iSr1C?=
 =?us-ascii?Q?vgZ+JvWrO0dtpYAzJkga4zgW5i9BYoLTakNt4KLbAMumZY+tTyAi76J6b0DK?=
 =?us-ascii?Q?P+JycGBV4bjJXNA8xPqbO27noZn4U8T0gaMIuiVpFa3mm92yXpQcwzDyldX/?=
 =?us-ascii?Q?6FS0Vl0nB4dYhy5Oxgqn17lHaCSkQvWNiojZRdtYjvP+upGnTnMbhEzSqrru?=
 =?us-ascii?Q?iJ4Z+M87cmeJvnhuOHR3og6Bne7plqeE7/J2dWgQMUqrsxAAvsO7yg6svNcR?=
 =?us-ascii?Q?DW9Op/F+b2rcaa0YqgHQOf6qZRNlZKYe4/wdZnejawJip0lEb19SYH9ZvzgM?=
 =?us-ascii?Q?iuVV/kCtOR45SjpsuZghBhQpSwbKTYXSdtCYc6H56EOOXkFwo21/uqwx47tk?=
 =?us-ascii?Q?sCz8asWOXfbLf9sFNXNrh29KOEc4uoPWZye+MdGNGE88S0K4zeHVSGd0cBgO?=
 =?us-ascii?Q?63pY9x6gu68pSMrsNsYcKDqDv5CccchBpSIC5gUj0egAIfRmIYfRR9Vf4Crj?=
 =?us-ascii?Q?kx13jj6hUoSbDSVK5ZWHb+cpKsJg8TQh/JFgXCL695bBna8mDTGDjFvM6iR/?=
 =?us-ascii?Q?ChDzADEpRuiYHprcypYnKLm+sA0F8gnHhVqsiABDKjWHUqHWBRKtxHdKoWzg?=
 =?us-ascii?Q?uWT8CdHsy6kS37q/XjxZwpyy2OTltRJmfxz6md4/HAv8kaLEslgXJv5OznmO?=
 =?us-ascii?Q?BH6r4NutBwGDgV7p0PW8AE1ozFc5twvByAnm7gW5tBSmSqR+S9c47c58y89/?=
 =?us-ascii?Q?Ny9kFQOSPZ5KdLOW0h3XKAXLw8R/Dl3tVh8DiGQCCsHKBul/Es8eVAMj2oPW?=
 =?us-ascii?Q?N39x4PRgWV1b0zEUpqfkE9Ab6NYKwqAnwDxXatJ7EH9jT+Aew05jc5EwIs+7?=
 =?us-ascii?Q?7YDTiBWM/wa3YF9xR9SuhaF67fdrPgXn6btM6JsmnjAgnsLf6xRGllROh/2m?=
 =?us-ascii?Q?msQD61PGLZeejiM+PE5IrbrjMrMr1vcrmOXBni8ihl+JCDDnkrZgHWARTlyh?=
 =?us-ascii?Q?KrJ5/+gW8FXR6wi74CSbdS8qXGfxc4inbQCqLYPZt2D7EwlC1rVGYoQml9qe?=
 =?us-ascii?Q?OgEoXmv8aY1pvFRHTWdTHYBI5FG39WVmJmEzuvIv+OMqnR6TObw+fk6qXSe3?=
 =?us-ascii?Q?cbOd2gEcxCJw+Lltj4aFfmAHthsc5i+V6HM8xESbh0LsIRgUx8M7uJZKql5n?=
 =?us-ascii?Q?8UaKC1eW/fZIzjOo7Czx5PxsF7zdrttgVIsWG33D+4HzJF7bUaMYRVLzxaA0?=
 =?us-ascii?Q?XGzOS/ebpMOcItu0u+5r4QG4FDwF4W9QrXAOiDJq4GQBETYgL7jgQD/bpyr8?=
 =?us-ascii?Q?r6t+g9DYc0te7zt5+nPdT+YJtx85AcdIthxQeCzi1VkAHXw8aG/r1+C7dRix?=
 =?us-ascii?Q?7K3aetvyxOw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OqUN7zSqnvbj4yEhJDzKxV6SII9C/TBY+nTIzn47Sf3fSL4SsdyEQG5oJXLQ?=
 =?us-ascii?Q?2IrM7NDAeZcUAei0/FEZtAWUQD6NiNMNr39ZhDD3sMKcOjN/gxTMgpZqKWWp?=
 =?us-ascii?Q?93UpyNzrB0uSPy2ydqD+dWh1WRNUuHRtvoPtTw2x95zmiSTTkrdn8CO/QYcl?=
 =?us-ascii?Q?YJtqETKTmnkz8xtVtezp5352Fa5q4uPyJDxBCFF9IpfO1avtJAwko7bhHKGr?=
 =?us-ascii?Q?AkLDn7u8xxuaqJvnV7aDX6+SrOkEx2dNc3TFHO6UP6AYXIYmIkty3zrhYYhT?=
 =?us-ascii?Q?FuHVdP0aiWT9vOFn0fltnMxbmE8IOtc03jeG8IVS7DftE5D9PSqju6jeqE8v?=
 =?us-ascii?Q?aI6UUwssJNs0hl/7CsVRWOf5GNws/eP2o3v/fgVc2KD4NbJdW04jd/2QBCKH?=
 =?us-ascii?Q?F9a7CJUlhwvwbZMye+7A5vm8nzO4HwdiR+3diVVdmOs7r/PZBPWvkBphKUI9?=
 =?us-ascii?Q?+3FNdIOTcUKNrYNSID9mLwYi9Mf173xd9lxNSj+W/kstsXjICAsT/Y18eR3S?=
 =?us-ascii?Q?wB164axPVpdfAmyh6hdPPFiTRUueFyZvsmxDu64AQA0VE/xkGUWP0qC/02ZQ?=
 =?us-ascii?Q?BEY5x6slRIPmcDEadwkyr+xVHhD6pLGm+9LLcMcycu5hIT19tcUijxdZI6oc?=
 =?us-ascii?Q?eY8gc0VzX+5RayUUf1ivpVwMrzB68KP64GZNxEkSZuyFob0Wwes3RN5YQ9ry?=
 =?us-ascii?Q?ryHydBN/kUm9Z5dTT7L5MJLWMzwaZz2t98QKvShLAsvMBHI5mXgVVwvb1dWG?=
 =?us-ascii?Q?Uk+0b8qJZZXeEjnY6lpp0O6p4JdxEN9dFD7rYeCMkg+Spk2OjBZ8gdUTjed8?=
 =?us-ascii?Q?1YacOnD7D5ohl4nQZoI7E+LwZOodToBvoC8/rE8dj7LAivwIY02gQoJ/oDou?=
 =?us-ascii?Q?5TUkCU/ltJduW6vyeUP3dOgjIOup619YU/GGVO2Shi92sPz6grIOOWu8XYcy?=
 =?us-ascii?Q?/8uNYCl+R0WkHVQnZFiMwRo3VzKl5TMP/7WngLigFfLu/Wk/x7UE5F99VZp/?=
 =?us-ascii?Q?MZkIkgKPriTP1tGTS1adaYCX3K5JRKPFi9t42rgr+H42L5yHbKcvIE/XsjMi?=
 =?us-ascii?Q?0z47H8pM27N6ROrCyvBzEusNXsNyZPDuw8Vgn0zSnJhTFY6Ppy4ezne0RhBy?=
 =?us-ascii?Q?IY8PO+Ija0bPh9fPVP9TI8hu2gzJMZGRogDXoSKNCfr84jfbnOvuTOlu41gC?=
 =?us-ascii?Q?suzrprranFoy8K/etWKGhBKDcyYmKQXRu0q1XIh2y9uYkNqTUhW9pkKstOLg?=
 =?us-ascii?Q?ekHXshjbN///oeRvtS4rROgJlF4QyvrrL8Z1nwp3It4ulGZsN6iiF+7hE9iX?=
 =?us-ascii?Q?91Ke5JtthLSDDViE0x1/17YGm6J1TgOEyeA03nY/U0iS7AD8T+1xs0ne6vmb?=
 =?us-ascii?Q?FkXd4KciUru5d9KEIr6HK1rNZwvVJqcQoStwIiPNAv/4dpn5Hh8QL/KI+hTd?=
 =?us-ascii?Q?EbVf45lLftwC09mnUMQMC2EDaPMZvI8BZyX//CvvJxeUlEsaJ2v20fvdtyr+?=
 =?us-ascii?Q?t6VbEteo61h/Eh9jQbsYL4eJhrxOdM44ziM759suhpNwt6MRxT/HW6jp80kU?=
 =?us-ascii?Q?txz0i4tRHb2TzAxzt4OmKYVr4Yn/d0zX0jY9a7axs9qY5P8GpS4WkwLYEKC0?=
 =?us-ascii?Q?aW2wbIhlPTirzeGDWuo35jM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c50a3e-c02e-4685-bb0a-08ddd2f5c882
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:23.0784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mge6NesjCOkCTNBMOVqfkOa25tGA01uyt8DeXGKJGtA4gI3q3Cpx0rXZeKznclG4aPvJFD4TscyJzZoK0HghMXUAoi4Shiic3k+IWcytsbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7973
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

Remove redundant code for MPFE CSR firewall disabled as this was
already set in DTreg dts.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/ddr/altera/sdram_agilex.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ddr/altera/sdram_agilex.c b/drivers/ddr/altera/sdram_agilex.c
index 8aeb4320702..e4655877a78 100644
--- a/drivers/ddr/altera/sdram_agilex.c
+++ b/drivers/ddr/altera/sdram_agilex.c
@@ -144,9 +144,6 @@ int sdram_mmr_init_full(struct udevice *dev)
 			      DDR_HMC_ECCCTL2_AWB_EN_SET_MSK));
 	}
 
-	/* Enable non-secure reads/writes to HMC Adapter for SDRAM ECC */
-	writel(FW_HMC_ADAPTOR_MPU_MASK, FW_HMC_ADAPTOR_REG_ADDR);
-
 	sdram_size_check(&bd);
 
 	sdram_set_firewall(&bd);
-- 
2.35.3

