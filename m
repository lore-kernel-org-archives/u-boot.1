Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174D1FF886C
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 08:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90E63845D8;
	Tue, 28 Apr 2026 10:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="DklHkO8B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58BF08460B; Tue, 28 Apr 2026 10:51:10 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 672FA8432A
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSGeevsjjQniA8/pKIGAfD5UU6lGSv9KpytM/04XMadBiqlKLZIyYEjuwXEkDhBbMcDi5CsKVRaClv6fwqS0Gy8h+1Ap1YT2+NiX7eqx+2vxsXwm8J0yn1kBii1TGosGI9gS67sn3XDUDu+A72XjbkVNrL1DSneq5kGBUc9zjB9KtQ6EArNMZ6MZQTrytYjP4MFGYh0BcfRIGmRuu6PyIVleadmbg51jl2kOhVZoB0MRimDnlcjMM0zBng8Tsf08m/nA3ILov0D4x2mleQAqY3eNmXjMPBjkbf5Ehe/SUtyBqnHOm/ff58re2bWx29sSh7Ogp2ezEPoLLWZWyVB1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKm3cR9HfQjPO4YpAHiE5mJzd2ZhxzP9ChUmZIJfUEU=;
 b=ZUuRAGqrkrJp6NAk7FKmt5TFx5zP0WTccoJnftgsW4qoHsaTYSDQcz8xSLNikIhkstF1Plkxz6uadclsHBhoDEsysgzCXzSb+tbbe91zRWJVC/Sij7p7ehyNDDQIQvRmJT4ihwPk/trz0icr0zN/cCUxCcj1CxMQjTY9v0K9Rrezoshgw/xWdtEckPSwTn2ulEeynZcUAuSKF30DlajLkrU41s3YXlqKYde8Ri3URpWV9aOdbtKESi6PMpoIhuwE4f0A2Qbp1FOGavHtzFBGdy6SN1Yr+9/Gm4axRRi1jVZh+AKekUJJyzydMSZHyK4tTTDYPI1sqj6p4vnm0eSnxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKm3cR9HfQjPO4YpAHiE5mJzd2ZhxzP9ChUmZIJfUEU=;
 b=DklHkO8BCWf6Gp2TM1kQMmmOaNLo8/U92hEfCBmonE3BqntldCux2kAdGW8CM+pyPFcDMeUE43eMqxIPvoC8yQLWSnjhuUvNiV89D7IW05BzcyjEOuQ37WQvMGxS+rMfN9MHkZRtAHHRh+6SI6fUwGnGzxcelRwiDbU62G55SQ1IlHO3AzIHEncIrOWGY9ylLNN0fUO2X28ydxzpQ2L6/ndsabJum6xCYPaEALVvJAPbdon8BBSmEAxVn8aHPejagdZqYdkRdjFTypC+4YotHeZa96UOWY+H51xPhjpf70ZbIbmooBrB3/Q/fyVIKaD0c6vMAmYDZbyeD/ML28dZEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) by VI0PR04MB11048.eurprd04.prod.outlook.com
 (2603:10a6:800:25d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 08:51:06 +0000
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029]) by AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029%6]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 08:51:06 +0000
From: Ye Li <ye.li@nxp.com>
To: hs@nabladev.com, festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com
Cc: uboot-imx@nxp.com
Subject: [PATCH] i2c: imx_lpi2c: Fix MSR status check issue in STOP
Date: Tue, 28 Apr 2026 16:53:12 +0800
Message-Id: <20260428085312.1808358-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0220.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::16) To AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB12051:EE_|VI0PR04MB11048:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf20f8b-06fa-4daf-1184-08dea50348eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|42112799006|19092799006|376014|52116014|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: ClV07P+VHhrNlLTAhjFYoTGdGN9lF9OOm2+NRpHXUXoOCxWZQ3JwE3vLn3TUJHKvZFLPKhqcTrPKCSjG8va3OHc7OrZ3LTq57oknVnuhGBYrl2fd191fYGrT1sQXLdha8tJJgo3eh1bcOTJ2qYJnhjsFJ2cl4BAjCa8DXv6hlQCw77HeBw9RUzakBOv8YdhzMvLIcKoEqG789dJognlVfvi1obc1zb1GQxuTiCxPLvwMcvm1He+dz/DmZ2aXoiRwuc5or4rOMsp9dykqXARKdhOVh4euagAXt9shZCuK7mwMVuLcBs/AlZ7Di2EY9/jWk5HZH42Cwk2DPxTfeufJprJGMzYV3nni5lAcxEkP81IfDXXXNTQlC/e2nKD0SVyYHUY4GsZvWgvHY5QDowZ+97U61pxj5BLYErpyzyKx9J7CGSjk9o0Ckvh218ruXxr7Qu1t3cETFeOuevs2GIKVsvjbAYhqGnO9M8aM+z/6apEmZm2CO984GUILBIKxNHvcvWsBw3RwlTyorl6P4q0stYdGkMPO0fpp4TOafgnKiqUiS/Xps/+FlTXclBVsfS3PMSIFVecE5YNu1MZg3b0Oeda/4in8s+4sldxz7s4ON17+Ui9nIakTHhf3HRjFpWPkCbR3ye/Tzk9nFwmTEe1KZP07kK6RGLgRLisE4Qz3gKbt1C0LZQxaixs1wtOY5wRsEm76l3QYi2amhDLf4jkeTNNnZr39/hSULhePtH7nEWKdxl2vGXcCoogspCiTDHz1c8N1E9Usg/ChtblmrEp3wCnV0pg1cGZSyL40Wo+jjOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB12051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(19092799006)(376014)(52116014)(56012099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2j1XXQphD94QZSwwBu9NtPHzqleUBYFmpJtowR8Mlwz4Bq4tVqzcoRzA6ZBr?=
 =?us-ascii?Q?b/fvE/Ay0isOAJa2Qol2oo0+ivIDZb/v0oTb0BEuKuZ/bY6CW6dmtH05GByM?=
 =?us-ascii?Q?ZImyUMtYxbAzpZshKBz+bxBtm+TFzfD4rFcEgJYbZSZQuPHD+ME7KLcj4a96?=
 =?us-ascii?Q?pJyPqTAiHWYodZ1FetnEXfxZKNl1pi8cB97AEcHuIZhFMNuoljw4qeC81mea?=
 =?us-ascii?Q?O5SHlajb76nlGc5S20b1tYeNwXNtzVvE76gH3SjDswV+eCBHT04TODIFjHvc?=
 =?us-ascii?Q?+WX2OA2l9SggmoLerIGL5rbFVwmwzKByk6Oyee6YQK02pFK10dYiIhfQT64c?=
 =?us-ascii?Q?8KAEwh2TznndZiu+RhTGwSB7UsnJskRD4sYgRTgyya/s/7tZvzNE9jXbp3RA?=
 =?us-ascii?Q?26L68hBMMRig4vRC+05NJlDCXigjNfJooybS5HG3+0TBZaaswS847CG/18qj?=
 =?us-ascii?Q?VOyUChDUldTRtmAYS/LYPeb6PNIg/QjHDGKr1sJyPSYpMHaf+sG9tfqiwOGT?=
 =?us-ascii?Q?BwsdFpNY4HxhcLGOuEREHYNcvHqvEP/xC74/QWKRKHyNL8RUg80jst9LUIBU?=
 =?us-ascii?Q?/dCPZ4kkkXWOJuKXugCWrN+K8Nvsr8GKIHTKbtxIHos5frbxs+4AfF5vOX+E?=
 =?us-ascii?Q?GW0c3lOqko1PhuUXNZqvv9lIUdC/Xqmq0qw9eL7IrniU2Jh6rS5+2Cr3bxwx?=
 =?us-ascii?Q?Nn4OH+IGfnvMaAu4+MTm/vkuG1b394elDD6jVDDqL66WwBtS7BFhZIbB5/2+?=
 =?us-ascii?Q?BJ8MbUL3mhFMw7wAD8WPG6QKKSu3w/mKp8Yv0ododJ28wmx947JHmsIjk2pH?=
 =?us-ascii?Q?huvi9JbPAdAoH/8hFGe6ztMARgVM1zIDtGgJj5lP1g0Azg4VueYWwyfNg8zA?=
 =?us-ascii?Q?RKAczGZlRnFN5ZBt4E2cuNUA0IAclVfq4rP0csilYYiO1Me8JpVNQAaYz4ri?=
 =?us-ascii?Q?vuaub6WLbaZWHka4t6phqULoeaj8ehl73vY+TxqBqR6R4lwYQYXVvfAUuqd3?=
 =?us-ascii?Q?XNiKdxBi6GugZvkek5c8+jlin06HhdGJR8tZcml0fA2Pm/c+SuOVjXpXybyH?=
 =?us-ascii?Q?NQCEszX03nbC0YkNOinfFveuHVKg8VTexMRscGdy0ptm+63lJsiiill+E8zT?=
 =?us-ascii?Q?tKRZrqp+9GY7Ti0fP1JNoF28pTYUjnxWudUVkE3lmejbMw3fIAVW/6XXnh+Z?=
 =?us-ascii?Q?0jIi5HIgyBlVoJ3BTabY4EoWqnWyu8aNyOxI4L9FbpypSVNm5fotx+J9iM2K?=
 =?us-ascii?Q?8aiwPLSFx2f2kMcaHouEpL5wiNQuFnQtvxLqqjPg3I2kGViglOp4H1ioeQij?=
 =?us-ascii?Q?LaMgTVYfAuch6HVzwqPN9qR5koBnaOe5QjDUDLvRjVzR2CuBX7YBvCOPMpqx?=
 =?us-ascii?Q?DroVQyFl1RU3lWnmHS9Qlr1p88nhKdyC+h9N0UhE7nr3op1MEs23kkn4JBwZ?=
 =?us-ascii?Q?bBi3XxypZ88xPOsyUrSuY0jfHMsYcgZ0Z0xZTN8g0FrU1pyHuawyeibPbhjs?=
 =?us-ascii?Q?hyhx9Kehhiz502VF9phKZF1q40NAyjXMzXhzNjZhc6DEZVkwY72KAziJ3ZCf?=
 =?us-ascii?Q?dlkjFeUavl3/bEwGtJJ1IrUB7feDxZY4ADpZltWf0Fv1g23City5LBUqB7y8?=
 =?us-ascii?Q?Vwfgvr87yt2SNEL8l6sNpJO+iZAtB24Ljg7cePxsH9JM6EEuZ4YZQczYddvp?=
 =?us-ascii?Q?YgmL+9V6lBlVKAjzX30do7MCeZIV3soy0Sl+qBguk+UdQzEp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf20f8b-06fa-4daf-1184-08dea50348eb
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB12051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:51:06.1733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOZ686lhc71DmYn3qunPA2l+rQ2djUKR5i2Y/FVaaPoPoOklrJj8y7ikss8gSaS+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11048
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

In bus_i2c_stop, the MSR SDF is checked in a loop after stop command
is sent. Meanwhile, some error status in MSR is also checked by
imx_lpci2c_check_clear_error. But the imx_lpci2c_check_clear_error
will clear the MSR.

It causes problem in below situation:
In current loop, SDF does not set, but error status is found by
imx_lpci2c_check_clear_error (for example, NDF), then NDF will be cleared
and result has NDF error. However, because SDF does not set in this loop,
it goes not next loop. When SDF is set in next loop,
imx_lpci2c_check_clear_error is re-executed, but as the MSR is cleared,
the result is 0. Then the stop return 0. But it should return NDF error.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/i2c/imx_lpi2c.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/imx_lpi2c.c b/drivers/i2c/imx_lpi2c.c
index a309fd6f07c..e2b4fd334ec 100644
--- a/drivers/i2c/imx_lpi2c.c
+++ b/drivers/i2c/imx_lpi2c.c
@@ -239,7 +239,6 @@ static int bus_i2c_stop(struct udevice *bus)
 	start_time = get_timer(0);
 	while (1) {
 		status = readl(&regs->msr);
-		result = imx_lpci2c_check_clear_error(regs);
 		/* stop detect flag */
 		if (status & LPI2C_MSR_SDF_MASK) {
 			/* clear stop flag */
@@ -250,10 +249,13 @@ static int bus_i2c_stop(struct udevice *bus)
 
 		if (get_timer(start_time) > LPI2C_NACK_TOUT_MS) {
 			debug("stop timeout\n");
+			result = imx_lpci2c_check_clear_error(regs);
 			return -ETIMEDOUT;
 		}
 	}
 
+	result = imx_lpci2c_check_clear_error(regs);
+
 	return result;
 }
 
-- 
2.37.1

