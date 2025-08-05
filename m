Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E58CC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 02:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B9A083AEE;
	Tue,  5 Aug 2025 04:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QeaEg9Vw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C3AA83A81; Tue,  5 Aug 2025 04:49:30 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AC8A83A81
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 04:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsm01KCtBFI4zQ8Spwen+q4W/56cq7hHkHoy5TLVnb4xLt/Q4HgI2xcE0NjethCQALkEdHOZz2BpDnWTwYdj9ldSrdonhetfAAVZ8YeeKetOQ24HdJPbNw5w8UcY0wUJKg+RPskeCcez25aGnZudWems2djBhofU2+XUdcIlyXHeVM92UyCB3g3Pya3H+qRVFu9kJnggMesjaJFEyT/0XX8ng+gDhcxJXIAqhAy+mWCxouIDtne/Nsrk4qDV014Iw2IJF/IWwTj1s+RyohtfA2w7CvU8LfW7XWgE9xYnc6rWCK47mbQ2DmWw2orZOWGNlgw5Uo5UwlY/OwrJXXBtkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tibjh5XxU7TQFaktlmguQn4IqMx7m5j3KTDNStGRg2c=;
 b=Tnfhm+l9L1piJCgCKDDhwRwr3kDujq2sKDCDyNn11h6mPsygGwreJQNXa7Q4Rwm+R3qr14pSnyMndlU8TMjBJbY33/e4/m0XJIX/ZjEWiyCa2e9PcFdeQrjnqP4jwc2Hb6X6pAbD5UOXqhIc80Ho7xX5dCMV19SSNpyBgbOEK648dLsQ+ENh3/uvD/mNCh8BKU4gm8rUYG15lP4Ss8BkR2YCViEQSqD3LwBZ3gL3h+kwaDW2qu5ka1ptadwVgV8u3nEnNp/gffWuq1JQX01G8Gw3ZHM4GLNKdLnzTMvQslJroz1xA87fZQ2mRYPAV3v/+f7NLTwvy0/SVyfUhMv5LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tibjh5XxU7TQFaktlmguQn4IqMx7m5j3KTDNStGRg2c=;
 b=QeaEg9VwOZtO2s61KtE/688xX4Z9ExTWc/8anqGd5zk5oP9i9+qYwgDXoC1WOigr7ush8OzVKjGQjF3G8WneE2tOrafxo5efATEsuyxzvaRzGMEUr41ZEw+Bs6szajkYcySVSS73r/vQPku5FRxV/JrWjXR1+Rs6qjjESc01tsFJfaT1aYNpxOC1mOdPLED1/GCD+FQFTYuklRYwIRi4+sbJFnq7uKolWS0+VKN4+KwG4bZk0ZJcFNyGfG/n5lT0x2jGQtYXF8pMRvf6PaKWawNzi1PKX6w7CHEh/oyOlhlG7jitEDpWcFJlUAmGVciiGMSHEDoxj+zv6AYXbf5SfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB9142.eurprd04.prod.outlook.com (2603:10a6:20b:449::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Tue, 5 Aug
 2025 02:49:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 02:49:26 +0000
Date: Tue, 5 Aug 2025 12:00:14 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] mmc: owl_mmc: Do not dereference data before NULL check
Message-ID: <20250805040014.GD29103@nxa18884-linux.ap.freescale.net>
References: <20250731-owl_mmc-v1-1-8493be6755e6@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731-owl_mmc-v1-1-8493be6755e6@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: 4668d002-0bbc-4594-b4ef-08ddd3cab0c1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7MqjWcVuaA+onbM0x/xQ0Mt5at/2OwRoTgU99D4yeeI7JiG6o0RY0oBefoDt?=
 =?us-ascii?Q?UA1z06febCqElOojp1xk9X/6pXOdTFgpuyIrVFXTj3qPtOsgKh9vbVxznVDE?=
 =?us-ascii?Q?+KdEigsYxg7fZk3hLj5QmBy/GRk6UsDI/5icNFhPzR/1FbgMnlhlnndld9pD?=
 =?us-ascii?Q?uHXmY7s4Ms7mpDaVNCXp5IQjgTTbuuyryqp7hWuNzISfleydrZ+0uU8r/MNT?=
 =?us-ascii?Q?WFgT9z3ElFuPv6o6dsu8njJHMIGG6PcfAF+3Sq7V59jqTm+tM5r6MEF5hsei?=
 =?us-ascii?Q?DpF8wmWf1+6XuQNgVFO1bg/voZ4JUxrMDidbGOLeHWnWB4pe9pmeBs1ih7qc?=
 =?us-ascii?Q?C3eXXGURg0tV1rvvJx+bGf+VLkK6UXTqs+lwvgNaJn1zikSLIksyU+FOSsT8?=
 =?us-ascii?Q?/Jl3eqPjY4lSO17HC2HfxMt7xqBvplbPeIPfAjcx9DL5dSM9/Tehi1Xu7bGT?=
 =?us-ascii?Q?IeJNP4Z52NiSFzQNL+JZy7s98KhW4g5Kkg7H1HxSx+XgmIGPudJYS1Ng3nOb?=
 =?us-ascii?Q?Pu5/gm0kISDMeW+G7gnh4wpl85f0Ow+DTPkhNuNQvMItvRhaI+6ubxXDsXYR?=
 =?us-ascii?Q?NeQ4KdVWuQtaaNwMNIOBxBxBMhKxsATW1JdqHtLc5zsbcOL8E3wcip4l73nk?=
 =?us-ascii?Q?5x/7OQHQsW42ZuC75hM4mfUtbOMlSEQz49iwLQ34Z64ufQkd1JwTXahF4U8a?=
 =?us-ascii?Q?Tk2tRT3ChzaPKBLV7ndrF6OlGKyIBiyGeGifRhZW4pR5rpUhEYk3Nw5ANqj2?=
 =?us-ascii?Q?kSSpsJeHKJbJNmYCjIWJtGUv0duMtBOJzRiSbytdTVa8bHlSsYwvXySO9Xe5?=
 =?us-ascii?Q?vhlrbwAebeoCLz8KTKMwQwZygccFpUaK5Jo1oZp+gr5i7DrH3DUCxHYrX48P?=
 =?us-ascii?Q?8gd9zH9lnOmoVgLTat8MC53fyZt6IGwTUGM8XO4+BOyZ7BqUJFVXAzjsE/2f?=
 =?us-ascii?Q?VKWfPygRa3L0ifwfY+8BbidtaKXOky9ZB5NcQP3CAbylkRm+wpDZGyk3TsRJ?=
 =?us-ascii?Q?gMkHfGhLq3SAyVFu86TFUwGJzJ//GBHB0J00YsKbIKTDLugZGxGC+oXa5YJd?=
 =?us-ascii?Q?+Gv+8KfGXCVC2C6Vy/l47HBOPZsh9TZVAK+QWg2UYH08d66WHmBWa02U8AvI?=
 =?us-ascii?Q?ZP2Y+JDVgszh0a3nEw3mwkdo3bQjwSWS01dzkIgt+MeYu5eDN4Blweut8dMI?=
 =?us-ascii?Q?qZMRjJs5N2qYHSQQwpqV76ox9T2Iip4Ym6vCiFAuIBpR2S5/f6oP0zb+T+Ou?=
 =?us-ascii?Q?FPx2Dl3SUZbgZq/A4kxyBhjazge2rdBDm8l7zgpvEc/JyUlZIDJgkVhChAi7?=
 =?us-ascii?Q?Hc6SQNwTdROOFFzNVYxeG7L8GQiOXCeEC/jYMwPLnQSZpN6GvkzDuLUly2I2?=
 =?us-ascii?Q?I9Ytm02280HQw+qdM3pTwYwWW984HaD1SZujiXov9o8Fb/Jyuz9NjphP/fj8?=
 =?us-ascii?Q?Zm6FbWTIkIyR2iSgfCcHXCF2EbUMxBcFHs0g4NXtdLz2/4W6WA/lJA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cCGl4smMX7X36rOq6Kjm5SRgj/5t5vFzAwTeMOrvswDjkLNN+dwrnNno+jMf?=
 =?us-ascii?Q?/505fcWb+jS3sC7dP7cPh7NiII0XhwoIw8JXHlxaAcKyJ0+RpL+5ggUvwu+B?=
 =?us-ascii?Q?4EMQXnkfTu5xudZaFhowC1qBceCBajOc1ZYvg0V7M0f4WjohCZjrE9DQ5JtD?=
 =?us-ascii?Q?Ze7e0al0YbaftI6/T4E6/u4c8Jb/wVpL/yeyxx9NuyVhA3Qs/8cTblgYaXZz?=
 =?us-ascii?Q?ATAEm/vgMdA/PHz+RfEIE6ry64S1QwdYYcjzouaG0rSz5b1X9iXsaI9tAlVB?=
 =?us-ascii?Q?oN5+l1IZtfDLi3Y+uXoO8m1l9oAuQHBUo1y+wMvi9ptJV7DZp20jkSUfDNcK?=
 =?us-ascii?Q?+AOxbDfSy0dJIZz6B6r9WqdD4ZUExF4Q2tOIWhTrSS2+ggaXUQZ3D5zu/vM+?=
 =?us-ascii?Q?UzcktrT/UWq5sPmxHxo1iPo+m0CwXJW7QWxS799Bu9NmAH5lP6mK+KxuU+Gi?=
 =?us-ascii?Q?Cy2MiM8cCKhkXXrlZDRULuR8wjAKXcVYwOoWpWMmdD3OHH2YSXEeXUZHPaHY?=
 =?us-ascii?Q?bKyHfaK6bfrN5vrGxzjv88CTNLqSqulzUapmMeu4OemTRKVppB6jp619Z3yl?=
 =?us-ascii?Q?oXbfDV4SNa57dHMwEqGdRgc1DFMKFsTRd9yeqMvhl+iKmFIvN6EGZSrDH1ZZ?=
 =?us-ascii?Q?3o/L0Fb3Cnyz4bgQZ7UndrXHf8LfygVaBH/88aoRysDLcoQmjdOnNMgvwyuH?=
 =?us-ascii?Q?hOtDbQGSzC5X8QigDqBazBkfpOu4heqq9I+tZZVwDnmsWQDlafLEjiOZnzD1?=
 =?us-ascii?Q?EMrWF7QF8kxX0K4zREAMm4+4aiIuIO/3R7Sb+oBBstav9FEIuxB7N5mrUdZc?=
 =?us-ascii?Q?cG/rilSEqRL6RIrq6FXZGN7Cw9lmwSZht+39sQqj1LvzwAtykf+StsHEUsab?=
 =?us-ascii?Q?EijxxtT2X+GF91dSY1kEpylL80VGHmT23u4nd1oTbKVuSpwTvEALQ35+VC7u?=
 =?us-ascii?Q?OINjzZV9CSMJk8I+JgAvzT/mEZ4av35SnMOwC/aUexogHXesEKJdgzIZyp+i?=
 =?us-ascii?Q?YNvZcsB+YPovfWo0iKllwTtVXpYr0KRSSM8rA8vsG44Zt7bI1X8NRczi/CKR?=
 =?us-ascii?Q?89JfjSk7NX3UaPJl/iyh3c+KF7roFgFE5tUZIJbfT3ffxPjLk1WFlQkJ5dog?=
 =?us-ascii?Q?5yysxRUFPirgx4p4H05ijpEtoc+KsZGb6x88uNAJOFhPCHzsSxesA0aK6y1l?=
 =?us-ascii?Q?HykSdUGoAHz2QDg8a2moLeFgnc41JHth+iylongmX36CkcP8CjMrx3xSypcX?=
 =?us-ascii?Q?mGhRSudX4PYGmf38XMHh+gbZN5Yi50f0gfMSpP4de3JY5yrIqECswEDcAew7?=
 =?us-ascii?Q?MWZk4ainbNbPOmllkKee3FHtwQQuWK9XEdZF8AdsjXyhockq+60BmrS6oCX9?=
 =?us-ascii?Q?RfK7yQwldF57YG6xhcwq8899X2/PZKVOnIvHBQmVhZwCBug1GBSwGofsS7n4?=
 =?us-ascii?Q?XloBnNNh473+S8J5hZmLEbTzVNn5eveSeI37Wyjxo/qVs/8nrcBhfFvCW0AH?=
 =?us-ascii?Q?ChC9Rd1G7IMSOXO1EqaEFv2R/cpVFwjN8gOUgB8t+/DEchxLQv3Og/1Phe7Q?=
 =?us-ascii?Q?ip9t9Dhu9yAKj5e+kTapbOofu3BuuLSet5Lua3RK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4668d002-0bbc-4594-b4ef-08ddd3cab0c1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 02:49:26.0179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOVXLZ8JTks8r/l+Kfoxq8/hI574mk6F3Pu4h9PLFZHyssyGjvWXWU3n7SylCyUbq/6ZHNkAHTB4k/NSJtDhdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9142
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

On Thu, Jul 31, 2025 at 12:11:47PM +0100, Andrew Goodbody wrote:
>In owl_mmc_prepare_data there is a NULL check for the pointer data but
>it happens after data has already been dereferenced. Refactor the code
>so that the NULL check happens before any code dereferences data.
>
>This issue was found by Smatch.
>
>Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>---
> drivers/mmc/owl_mmc.c | 18 +++++++++---------
> 1 file changed, 9 insertions(+), 9 deletions(-)
>
>diff --git a/drivers/mmc/owl_mmc.c b/drivers/mmc/owl_mmc.c
>index bd4906f58e7..c18807b1f49 100644
>--- a/drivers/mmc/owl_mmc.c
>+++ b/drivers/mmc/owl_mmc.c
>@@ -135,19 +135,19 @@ static void owl_mmc_prepare_data(struct owl_mmc_priv *priv,
> 
> 	setbits_le32(priv->reg_base + OWL_REG_SD_EN, OWL_SD_EN_BSEL);
> 
>-	writel(data->blocks, priv->reg_base + OWL_REG_SD_BLK_NUM);
>-	writel(data->blocksize, priv->reg_base + OWL_REG_SD_BLK_SIZE);
>-	total = data->blocksize * data->blocks;
>-
>-	if (total < 512)
>-		writel(total, priv->reg_base + OWL_REG_SD_BUF_SIZE);
>-	else
>-		writel(512, priv->reg_base + OWL_REG_SD_BUF_SIZE);
>-
> 	/* DMA STOP */
> 	writel(0x0, SD_DMA_CHANNEL(priv->dma_channel, 0) + DMA_START);
> 
> 	if (data) {
>+		writel(data->blocks, priv->reg_base + OWL_REG_SD_BLK_NUM);
>+		writel(data->blocksize, priv->reg_base + OWL_REG_SD_BLK_SIZE);
>+		total = data->blocksize * data->blocks;
>+
>+		if (total < 512)
>+			writel(total, priv->reg_base + OWL_REG_SD_BUF_SIZE);
>+		else
>+			writel(512, priv->reg_base + OWL_REG_SD_BUF_SIZE);
>+

This piece code is moved to after 'DMA STOP', so code logic is changed.
This may not be expected.

Thanks,
Peng

> 		if (data->flags == MMC_DATA_READ) {
> 			buf = (ulong) (data->dest);
> 			owl_dma_config(priv, (ulong) priv->reg_base +
>
>---
>base-commit: 79f3e77133bd7248e4579827effc13f97a32a8a8
>change-id: 20250731-owl_mmc-ef16e32b68fd
>
>Best regards,
>-- 
>Andrew Goodbody <andrew.goodbody@linaro.org>
>
