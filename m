Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04C4CCD19A
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 08:31:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4081383D8B;
	Tue, 18 Nov 2025 09:30:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OURXRwyz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E16D83B99; Tue, 18 Nov 2025 06:11:56 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D53183B8B
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 06:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0koXPsHn0lLB2TAbq7GIdQ/6oaM+/O2KrAySiLB4ISDeZ4bryr/b0RlnWiGcKyXFxsPwXZEfSp5Ud0vZSMjleBUq8b/IP1ZUPRvuBrQ++AI9ez26H3kaCPLXapGX42f6VQU6kPZwiSHp1z4nUqh22SFO6exjuJqln3vNgABNNaQSz+fbj9F4zUi1eVQ0SiU7qS+/rgztIvc+MPR2Vw8fkLkfzTxwHGUY5vFPyMR0NgsCrLClGkEs6suyBmJt9QsUTsWd4a0QBIvPS2cJuJV0CfdddWzU4iM4wngSy4EoP7ZY3KNZzfhdn1P8OVPgMYpPNl4GE4It60M4EHqTs8xqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSH5J8CQWAxaXqLZUruVlcAvROcT/im8tU9I3K+R58o=;
 b=oaUcf5Ytrl4Sy+ecFeRvg5gJUWAmNXFBXi9dLD2TXMGy+dYa9jtDssITybZd/q2Qu4HrKwY5HkQ3nyS77pBZeHplW3ed8LEFpOeGz3f9/nNbRILPzTpqD88HiOvaJgZImVvzXwM/o8Q9ljbNWW6knSekAqt52rty4UGQ9/SCHXwUy0fpCFQX8716xuH40KdEylGT6Cvdib4KneyYFU6ANtJskjIn05oEnhWf3ReGPXGXhwSKKucVIDjiz7Kv0XRGYFd21uxYoiK8WarxGWSxlPzu6sHpuBkhwfiB1IolvxH23UyF76M9Xx+Ppqx5UzkT1D2isjzINfRpOmhleAxtsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSH5J8CQWAxaXqLZUruVlcAvROcT/im8tU9I3K+R58o=;
 b=OURXRwyzuQFDjmtmUwSfcz0a8MKSbdWSv4LvgpSKKATb5OX1+WqjG+nFAdDqg+LlgC+rD20u+oTqrQnZJEy0vobUoyZekzfRO3ADwTjbhH/2Kh4rSa1TXGyfw5KYh7txwsunuOMiZX6XsBcakTg/2OmrSnaNX2b1UnK6jG5txwvn12mCK1XUtjb8BAswt9Y29NkaGMtuYuAInJa71xsz1n6d0yHNv3OG2Q/N8VeNFhK0PWJXQDXQqq5tDgp38H10J9MTkZE64ekyWEjNnYx9lPI7IePmDtpC9USCl04tg/KNnBSDiKaljGWqG5JsJddpM0PjPfTTBw1zoouarBOs1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10081.eurprd04.prod.outlook.com (2603:10a6:150:1b0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 05:11:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9320.013; Tue, 18 Nov 2025
 05:11:50 +0000
Date: Tue, 18 Nov 2025 14:24:43 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 balsundar.ponnusamy@altera.com
Subject: Re: [PATCH 8/8] mmc: sdhci-cadence6: Add DLL master control and
 improve tuning reliability
Message-ID: <aRwRKx7CILf0y1qr@nxa18884-linux>
References: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
 <20251110173737.24545-9-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110173737.24545-9-tanmay.kathpalia@altera.com>
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10081:EE_
X-MS-Office365-Filtering-Correlation-Id: 9baf40f9-2ab6-4a5b-6be3-08de2660faec
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ggqcy5iiWxwUFjtg18KkYqlLDj8uAEVyETOVX3n7dKSHig0jmobqe5L0oist?=
 =?us-ascii?Q?TBKL8iriTtXWi4UP5HTWJWlez31joyJSgzdN5bRFyZd6fzmjHwwDMiDG0lD6?=
 =?us-ascii?Q?5gmFBfoppUiUe2IOGKEOgtb26UvawN1J39JRH3dtk3VXyuAe3MmGUplfefXc?=
 =?us-ascii?Q?FMXhMAZlVYUdVokFAlknrFVdGugKzTK6e28ISfXQq1MqjlERGYoz4b27iu+2?=
 =?us-ascii?Q?c5ydHYkccAzncexFEOjnB/oPFUsyuFeTk9+tPs5Y8UCzri1F9nw6CSBnY+yS?=
 =?us-ascii?Q?iZDmtVMf9+OBhCz1bYpumoLMTTMO3g8k19VaveVBW81zB36LF16beFx0NTYO?=
 =?us-ascii?Q?pctacc7LqMSZGbW3DiOCzo3ACB8Ds33119KqdUb6yIeh6H9ghd0VP1yxdHZk?=
 =?us-ascii?Q?w4vczrr1b6ZiOF1tL29C4Ww7jZrJ5UvvoY1matV7SB4Dw8JWIKOnYquOTjzE?=
 =?us-ascii?Q?cD+J4dhhlXr1qviHgt42Sncs/NO+Ax/vQDpTdmNktVcZheIAyFsqULG2czqw?=
 =?us-ascii?Q?g96nmuu4Soo/wK+/nyxVhBp4gJtEf48hG0XAc2DfCnv/8lWdmg7CR7X6Qb7v?=
 =?us-ascii?Q?DYWAJJJRXVvLvSEVXeuASMZboUvVpwQKo8GIBDHAtVmT/vp2TqPwF0/ELuzH?=
 =?us-ascii?Q?aHmInm94hHBmxXBVMBvicnL4riHrwr0MEmmFXa3nm7tq47gW1xCbElD7FdCd?=
 =?us-ascii?Q?w/GBV3/XR7xfftitjTncZyOA9pP2Ow60pQ+Yyg0/bTr6Mvg8FmNfBhegZ53T?=
 =?us-ascii?Q?qn17WE9E3W8vER2yGyBhaPBGH5IC2CvcpgBNeaZdhIZa4XMSJ6hdMDhuhXuN?=
 =?us-ascii?Q?81UTYyTIYpwT3CHUnAF7jEUlHbi4KuyRLrXirUX/zc2Fi6QjEQ9TZzqOzYx3?=
 =?us-ascii?Q?Z2bJN9nxAPcHuOp9VkNjrTSnLsXgPJxrdiFzuUeUvWUxVGWMrCGuv0z3RN9A?=
 =?us-ascii?Q?iH413TqEL2132U5eoTMrRTPVgSij0fe1gNKgBlkylzaH1IcfuT8cCVnZqVt1?=
 =?us-ascii?Q?2HjJFo7haQgBEx44Wx8+/Fjok4zdO7Z7r8kuyWTb8lNtpFoPkvqXdSD4oJ90?=
 =?us-ascii?Q?LvStRugg46lt6e+Z5OaHhOCJeQu1PbdmbCfhA9z3wFAB3x6OGUdzq+pZDdEl?=
 =?us-ascii?Q?We0pgFNePzTULRgD2bVbg12oN8/vFenXNmbTXK+SMXtDMazSN/5PQRRyjHMz?=
 =?us-ascii?Q?hYLcfCdyfua2r8SI2HKHLBqbRoXb8iBDZV6ktWj3TtVg12B1L7VPO9D2WxJy?=
 =?us-ascii?Q?wZJqVTkYSaBJ2q8bjUdSc/EfTtB7KG1PudQ1mZAxS2XdVpILecI4njKgRhXt?=
 =?us-ascii?Q?IDbIcUsgsnFrdW9Ll9uRYhDapaolqJ6xxfWaLVmfRk5260chxeSbKxwHm4dA?=
 =?us-ascii?Q?WwrhnRgyp5nXuCXQke8iJ9ZGodej80SyzSKf65aWjzEH9rypVHUWg5pGQqg1?=
 =?us-ascii?Q?FxgQfucn+u36AQma8D3d3TXrK5D0GGs8KbPZq/iH7gB610H8w0gWPDNqiPjl?=
 =?us-ascii?Q?L+/6jC7hgR+Zj1dWUTG3pmSFmIHyGkLDa3Bw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VljuFndQRlcJKHbOYs5O9f3+U4gucjsCp5eHbaESeprF0K9FB1XWvF+v/xd9?=
 =?us-ascii?Q?Qt3eFPFjbLJfJ64c6HxpdmIG2tvJIQthrkpbmf49mCSWhgfvlYmU3Mi6v0F+?=
 =?us-ascii?Q?q7XtIfgvTwVe6PBs6cSCmD8B7zVGTav7FC+eltqC6eb+0AfosTMirAFA3rj7?=
 =?us-ascii?Q?DGlFP0PBn50r/TB4/MadBa839xvpCGBccdwIed1dDdkkSb9HnWYLoctX8+jG?=
 =?us-ascii?Q?WlJP26mCalp+X4FaKTBAE6HxuwG8e1Mc/ZaVVDKYLVOhEt61XaISoxPMjM9J?=
 =?us-ascii?Q?1MzDdE93LCPavWi2d1Nnfc7ZwDPKYNAg/Fj4KhAk1jTsAuc9Mk5tSqvU4um2?=
 =?us-ascii?Q?mzk5RVvaQoHe+oIEqXZnAens3C6SZkaaTOeeqQw3cWoRD+qfACYObdC8XgJh?=
 =?us-ascii?Q?6HoqPRxUxEw9BZiA1oAir0QpAMk8a2E8/3rbv39mW+kYWs/LD4lPB43tT0w8?=
 =?us-ascii?Q?LdBRxb6uwFhExOG48Etj6D/p9ZKovuyVvaWb82+c0PbEiAZQmDnjYdPQKVeA?=
 =?us-ascii?Q?Q3MjwvLz8eLR3Laocsf2oSupIeXrGD5UEED3axIjed3+CsoCLBkBrhZzqLie?=
 =?us-ascii?Q?yfZ+NeB3jhVrOH71v9GKIUid/3W8DTV8gXS5jnRGjinw6bwFVLpH8j2aHmb7?=
 =?us-ascii?Q?4QzYs04ywwmciYF0GfRRl6XIIje969u08C4ZtVgx5HGrgpC4otDaT+Uq8F3Q?=
 =?us-ascii?Q?fXXaokc/NJ+5rlX0XS5L0gd56yV0Hs8jqyqmJAVCJkwdp3OeCP0U3b6vHdif?=
 =?us-ascii?Q?vd0BYNyP82fOjEPYdI7l07w687hUcZQGKIC7aebHq6li8p88xkc/00KpLUB2?=
 =?us-ascii?Q?9lrlHdefG/oY8x+5gb8IAiRNcPQCkbyxmJiTAnroeMgg0mc4akTPX4nSFUWk?=
 =?us-ascii?Q?SPWec8GYzbplwlit30Pv5LAQWhZ07i4zy+hnYKC7zNo7u+ig7u0kzA9+wZFD?=
 =?us-ascii?Q?tGm49z4iv91b6Tfz14El6j8DiRbs+AChx7tHW3F3FiNGTyZeYBejiQWREfpe?=
 =?us-ascii?Q?mCqBZPVA8DZ6YDEVlbdl9u6/3YW7qIdhEgXa4oD2uHhAONwxgnux4jZS1XMN?=
 =?us-ascii?Q?qH8/tDzLGPNL3HHON+wxpZfAxRdBne4d+W5BdqdrOeTavGywZPz+ze4Lcgyc?=
 =?us-ascii?Q?cKGDLoY7qj5fa7jBh3EbxFuOy9yO932nwA/0RPAKap0r+G7fQW3RCK5fY7Fp?=
 =?us-ascii?Q?6KhDToKT9D8tRj5oU20fDtCJa5LmVBllf7xEFZaK0f+zuZOZLB0edD3gtg2G?=
 =?us-ascii?Q?QMMd6r0Zg3HH3+kdYp1LFHRU0o8+J5XvN/vxl9/mHRFDsr/AQnQwCSe4LvEb?=
 =?us-ascii?Q?SQPDte71YMy0THeh/saL8CACF2bCedbkbAFUbjuZVcIw7KNUsic2L7+Fk4xh?=
 =?us-ascii?Q?cBJMr34trFJ7L1F2CvkROW+lO8IfR+lbqdUKJ30HxSpslgj9NgvbxwGcLH34?=
 =?us-ascii?Q?LzW8OYTQy8kQi5wytfqz3bGE70V9h/PinmIunLzgc/ok+wemJ/cVxBqq0eto?=
 =?us-ascii?Q?79objqe3NyQ6vmR+C1H2z+Qei3abdnft6BBdiMG0Hsx/I3j1+T6/R4UPdwgu?=
 =?us-ascii?Q?/nePd9lV/trWKnfrQhfSLpehmOFxkyo+pVwkcuLp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9baf40f9-2ab6-4a5b-6be3-08de2660faec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 05:11:50.2958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mgQfbkd9tXQdbhhInUoWvEGLcyxUaKCCohjPYi933dMBMmWHoHbgq1lsI8HXeujpiGvxandJdaASbDvm3nz3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10081
X-Mailman-Approved-At: Tue, 18 Nov 2025 09:30:32 +0100
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

On Mon, Nov 10, 2025 at 09:37:37AM -0800, Tanmay Kathpalia wrote:
>- Add support for configuring the PHY DLL master control register for all
>  SD/eMMC timing modes (DS, HS, SDR, DDR, HS200, HS400) by extending the
>  PHY configuration arrays and writing the value during PHY adjustment.
>- Fix tuning reliability by toggling the DLL reset before and after
>  updating the PHY_DLL_SLAVE_CTRL_REG_ADDR register.
>
>Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
>---
> drivers/mmc/sdhci-cadence6.c | 21 ++++++++++++++++++++-
> 1 file changed, 20 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
>index d9467293807..91a245aa490 100644
>--- a/drivers/mmc/sdhci-cadence6.c
>+++ b/drivers/mmc/sdhci-cadence6.c
>@@ -58,7 +58,7 @@
> #define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY	GENMASK(31, 24)
> #define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY		GENMASK(7, 0)
> 
>-#define SDHCI_CDNS6_PHY_CFG_NUM		4
>+#define SDHCI_CDNS6_PHY_CFG_NUM		5
> #define SDHCI_CDNS6_CTRL_CFG_NUM	4
> 
> struct sdhci_cdns6_phy_cfg {
>@@ -76,6 +76,7 @@ static struct sdhci_cdns6_phy_cfg sd_ds_phy_cfgs[] = {
> 	{ "cdns,phy-gate-lpbk-ctrl-delay-sd-ds", 0x01A00040, },
> 	{ "cdns,phy-dll-slave-ctrl-sd-ds", 0x00000000, },
> 	{ "cdns,phy-dq-timing-delay-sd-ds", 0x00000001, },
>+	{ "cdns,phy-dll-master-ctrl-sd-ds", 0x00800004, },
> };
> 
> static struct sdhci_cdns6_phy_cfg sd_hs_phy_cfgs[] = {
>@@ -83,6 +84,7 @@ static struct sdhci_cdns6_phy_cfg sd_hs_phy_cfgs[] = {
> 	{ "cdns,phy-gate-lpbk-ctrl-delay-sd-hs", 0x01A00040, },
> 	{ "cdns,phy-dll-slave-ctrl-sd-hs", 0x00000000, },
> 	{ "cdns,phy-dq-timing-delay-sd-hs", 0x00000001, },
>+	{ "cdns,phy-dll-master-ctrl-sd-hs", 0x00800004, },
> };
> 
> static struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] = {
>@@ -90,6 +92,7 @@ static struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] = {
> 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr", 0x01A00040, },
> 	{ "cdns,phy-dll-slave-ctrl-emmc-sdr", 0x00000000, },
> 	{ "cdns,phy-dq-timing-delay-emmc-sdr", 0x00000001, },
>+	{ "cdns,phy-dll-master-ctrl-emmc-sdr", 0x00800004, },
> };
> 
> static struct sdhci_cdns6_phy_cfg emmc_ddr_phy_cfgs[] = {
>@@ -97,6 +100,7 @@ static struct sdhci_cdns6_phy_cfg emmc_ddr_phy_cfgs[] = {
> 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-ddr", 0x01A00040, },
> 	{ "cdns,phy-dll-slave-ctrl-emmc-ddr", 0x00000000, },
> 	{ "cdns,phy-dq-timing-delay-emmc-ddr", 0x10000001, },
>+	{ "cdns,phy-dll-master-ctrl-emmc-ddr", 0x00800004, },
> };
> 
> static struct sdhci_cdns6_phy_cfg emmc_hs200_phy_cfgs[] = {
>@@ -104,6 +108,7 @@ static struct sdhci_cdns6_phy_cfg emmc_hs200_phy_cfgs[] = {
> 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200", 0x01A00040, },
> 	{ "cdns,phy-dll-slave-ctrl-emmc-hs200", 0x00DADA00, },
> 	{ "cdns,phy-dq-timing-delay-emmc-hs200", 0x00000001, },
>+	{ "cdns,phy-dll-master-ctrl-emmc-hs200", 0x00000004, },
> };
> 
> static struct sdhci_cdns6_phy_cfg emmc_hs400_phy_cfgs[] = {
>@@ -111,6 +116,7 @@ static struct sdhci_cdns6_phy_cfg emmc_hs400_phy_cfgs[] = {
> 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-hs400", 0x01A00040, },
> 	{ "cdns,phy-dll-slave-ctrl-emmc-hs400", 0x00DAD800, },
> 	{ "cdns,phy-dq-timing-delay-emmc-hs400", 0x00000001, },
>+	{ "cdns,phy-dll-master-ctrl-emmc-hs400", 0x00000004, },
> };
> 
> static struct sdhci_cdns6_ctrl_cfg sd_ds_ctrl_cfgs[] = {
>@@ -252,6 +258,7 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
> 
> 	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR, sdhci_cdns6_phy_cfgs[0].val);
> 	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[1].val);
>+	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_MASTER_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[4].val);
> 	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[2].val);
> 
> 	/* Switch Off the DLL Reset */
>@@ -296,6 +303,7 @@ int sdhci_cdns6_phy_init(struct udevice *dev, struct sdhci_cdns_plat *plat)
> int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val)
> {
> 	u32 tmp, tuneval;
>+	int ret;
> 
> 	tuneval = (val * 256) / SDHCI_CDNS_MAX_TUNING_LOOP;
> 
>@@ -304,7 +312,18 @@ int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val)
> 		 PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY);
> 	tmp |= FIELD_PREP(PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY, tuneval) |
> 		FIELD_PREP(PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY, tuneval);
>+
>+	/* Switch On the DLL Reset */
>+	sdhci_cdns6_reset_phy_dll(plat, true);

There is no err return check, but

>+
> 	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, tmp);
> 
>+	/* Switch Off the DLL Reset */
>+	ret = sdhci_cdns6_reset_phy_dll(plat, false);

there is err check here. Should these be aligned or the usage is intentional?

Regards
Peng

>+	if (ret) {
>+		printf("sdhci_cdns6_reset_phy is not completed\n");
>+		return ret;
>+	}
>+
> 	return 0;
> }
>-- 
>2.43.7
>
>
