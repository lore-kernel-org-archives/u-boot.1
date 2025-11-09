Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7ABCCF9F8
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 07:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABAF583EDF;
	Sun,  9 Nov 2025 08:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="LxATpp3x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4AC183EC9; Sun,  9 Nov 2025 08:07:24 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B330A83EF8
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 08:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6OuhEHi9/bBFbwIcLi2RRK4sy59yuwblNtJ61A7K4gD7d4gzmxGK9I06VzXTgmuIz83vEae5xDmLIxyl6BL9RAlMjcfdipZJztX+mMfHNl3ezJugIrw7sn52+oqn0STYehluf2Fz4ojJJV23vI1kvlJF1Pv50b5EpGfXisyqg7Lly4kqoWn3tDRRAD3Ys9xOLDUWVemyLyHgwl0vVhFg1+7p6KysYrB/H2ATerGRf8/p2nUV5tZkPO5U7qFcMBaD4WExAn3I8RZPJnvdydAMSnwfj/dYWzHIb8TFy4HsvIeQd6WvaueAEoEUcVP0Vm3DAQ1sUGg6YcluJk8UNSG+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8s86B21p+enrY5Ebf4QSmpry8mGNkEfHZUhk9vT2vk=;
 b=TgGJitGEJFPg8eBJ2lOohRIK5ZHiJZMHJoiWU11tGoKTwurqtD9heKd664gDV3XXZk5dEy+QPNFGEVh0DhTbfrKDcXkNtrVBRbpE5LyR+v6xBPAOs/IZ4Xo7X/fOhBaO4HhCS3nui0jTeMSonj2UfxaIKdRVL+FPrFH6MPYhDtqNstL8dvlR9QRHbqemQH4uP1TKLRLlHQmrwZFppRATHOYqS4h/YQXpJ/+BMaeVCF/VjhF3Wa54KJtxNemaZXrF+pxwupoz7R5Zevxv3VcvW6IvaIpPoXSGVaYgRrsO2BQJs0k05MuZVMm5qShHf4D8uI652TW2VJJSH+p0vIp0Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8s86B21p+enrY5Ebf4QSmpry8mGNkEfHZUhk9vT2vk=;
 b=LxATpp3xmq90dsE3bUzw7e6E/lj7Qi/b0UaaK7EI/H66CeFTutN6thF8BSbif4qwAe3JHvNxRyMb1DjFQARidA2s9d1Q1Cz0nxGS2eeueXQQ1zzz61RflPm78JMqPJN4xFud+dPEusYLTVti6v7ws/5f/GGEQjqfKaT8/liJvvTRZA3ltrd0VT6vLrYvHAEEJyaZdFQTwcvXg3WvCySc03qlOsqCqozaI/wmg+1TIk65/5pfDmuktabPn/8FVZIUgHCHfti2eB12OZ2G3QZQHCiao3q1R9tjDGIZNX/n0704X4X2M8crOvNWHNeC+cAjN86Ips+7PobLVTU0MXJ7oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB5945.eurprd08.prod.outlook.com (2603:10a6:10:1f7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 07:07:21 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9298.015; Sun, 9 Nov 2025
 07:07:21 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v4 11/12] spi: airoha: avoid usage of flash specific parameters
Date: Sun,  9 Nov 2025 10:06:57 +0300
Message-ID: <20251109070659.801344-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109070659.801344-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251109070659.801344-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0053.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: c3bcaf61-3ffc-478e-14e6-08de1f5ea063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7h6/EY39Ldw0ghEMUY7rP2hWlexkEHpOv6mb71TpQe1X5/W49sG/F/fvWAgj?=
 =?us-ascii?Q?Vg59ijb21VHdCR8DRZZalc0SoYdFsgtF/S2QoAZME1Rp/p1TIZO0j9FeP++a?=
 =?us-ascii?Q?EGIV2FmiOfUihlMlPzz5YCKV1QQdnSJDLqHg9zqtAE75cDw/GwP3rIk3BM/M?=
 =?us-ascii?Q?aCNPeY1RGVrqMNxKlr88eSIrNr63YhBOU87j+WZrmFrsP1Rryu1LwZSW0WDG?=
 =?us-ascii?Q?kj6mQJQVVk9eDGSeTdCzY1lkJBvxToRmAAqy4mwGkQUwIao2V3BstlDLzY3B?=
 =?us-ascii?Q?bTVHn95ycB2XfnzxtnIgWSL/nAs6PHpiSXRJc/8dO2LG/OMoWJJTXKkSqn38?=
 =?us-ascii?Q?HFzu536iz4iqQKGXtxaRKczHtUFVk3Lx0rQi1OOhRRlKKJMoB5Jl73qay519?=
 =?us-ascii?Q?zrdQ1bscP9cZ1a0/xcjjuGtBqSv4ru4XvcfHX8IUDfm9sdK8Waob2F+vHeSV?=
 =?us-ascii?Q?c40J6ROAV6oHgMB5Pdl9CIZWA2NCu8/DRi9JoVD8cO7VLVrR6Wih0ST0tkeN?=
 =?us-ascii?Q?cW2JC6yHbgazmlhpTabgzHHpXjMkZq0rnoH2M4AHbROztkwoepXflcbLeS2U?=
 =?us-ascii?Q?NwHkHKs82TAKr7jBJLLRROiaLm8IMTjMoVEeIQZc0YHxX/M39+4fCx+Op6bB?=
 =?us-ascii?Q?WP5nYQ068bp4mo5ciSAXIqORxS/ylQIFMmls1VA/bvvMquFRLY+6eK6eZpg1?=
 =?us-ascii?Q?TjI89id9zd0V1dA5m3IfEiJ2w73XUeHIKM1vdN/84CHbCyu6mvFa0ZNSv/9R?=
 =?us-ascii?Q?MOjpxKM1Ch6jXioksIVWEeC5AueB2MqCY/VOFdsAISzDm8bhEA8u9Je5Y8Sc?=
 =?us-ascii?Q?0goThUXo9XPdMSehScHNZupbGD4jtTdws1AvU72heZZ1plXOfcyioEIIbo9e?=
 =?us-ascii?Q?WO8lilZdQ07ABXZ7TxWEaArqoa5U5OICVfVAnet/tzPtXesroE7sDcGlzx2F?=
 =?us-ascii?Q?5DCFocPldwmz+GC9cX+fDXo521uBTbKWVWiUP7AsXgjycRQpjAiIyTBntL4D?=
 =?us-ascii?Q?VnPqN3/j1cWd9u1ziFmq3oUv6fB56tJtwhBacVLhXlzQjQrLvsZ+JX4S7IQl?=
 =?us-ascii?Q?afUwNpaNYUfIr2ZNLCsCpQ4x9omF9a7FmOXUEhFkuD8ACvu5aBLqpX8D4LOc?=
 =?us-ascii?Q?v1SQI7uc9/KlzsbG05ZS6iy4IWBtZ7CX6as56acLM0cS86fQqyERJVTNCdMr?=
 =?us-ascii?Q?WSIJqcRX78741rwc+JeGWXK7p3+0A4C4HYZsno1SN9hKdWAuxZH33jh1xa+C?=
 =?us-ascii?Q?Ci2z+Zl3c2hgx613+TV3W781B5pJriRWUXYuzyWokbT79jskcwKPeO0Buney?=
 =?us-ascii?Q?/HzS93QRbe2axX8Dq9z89oGe91LBCtQ+TTkbqwgzcdJRIF19Rd8gc1BOVytB?=
 =?us-ascii?Q?ZVJS9nAawHusZ4yLJzFn+cgRQ7rGu7ImDdgOQWm3VRBR/5KxgSNjYUz9OYLE?=
 =?us-ascii?Q?UZYLL47+4yII5Jf3p8G7d0HVBFIoaEaBj7VH2opMEPLJEEwIdC93g/oyftF5?=
 =?us-ascii?Q?BHmpwiQLp5hOMVLQDBXrS81TbQdZQZjqsdxL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yFj/mfq32F4F4jL++xaKr8hQxoSO4Z1qQtHpViDD7Sx20fzi6s3tmcF69dMC?=
 =?us-ascii?Q?uV8HJvhNFvNpRz1lu0wUOxX8CtyZKz+eT5aHDOXZkORX1XFCD7YUpmzg/iZA?=
 =?us-ascii?Q?50Xhkyso+7WG/VpBnjJ7HGV6DFnM8pAzWBhY9HxYIik1JykklVwNP+ioqQ5y?=
 =?us-ascii?Q?wDO5+SGAYvz90yBLuO2jtLAP67ReB1hJQzpEXRVAVmi7HFedIaciVQ7rRq7F?=
 =?us-ascii?Q?4fMBAog56cr3df+qJgYFpHL8r8dsytCEhTsIKe1KZ3+3o/PoaHk3wWkExMv3?=
 =?us-ascii?Q?t3DqBKWNpYSyutooIkANO2Yg7jlx8H3im25wMo9g6YQjsr0pw4Eg/51FO0P/?=
 =?us-ascii?Q?OgdxsqDZ4SmwGCb3JS/igI9yJUAVvaVwDjTJe4l7X6HunqCm/H2SpuFgwGFb?=
 =?us-ascii?Q?Cbd9HRsYo7b5oxQXV0lscCPujYpBIUVSDLkb3CBdrjLrFXYPsEdFhbfDNiRp?=
 =?us-ascii?Q?K2InMBnBx1fWouL34ScEXw0ycFIhucZeiJ8cFR+xEa+cl8g5U+6nKzhDST2j?=
 =?us-ascii?Q?45Zccl6jYu6XZ4uA+Bzk8d9mQC1WuBw3nVbbKMHPirzBdLCmfk35evEO/cR+?=
 =?us-ascii?Q?Pc+0Ecifx3PKUI6HICi37SJOqrEvhwc7SGlZK2mQi46SDqU2azC1pGXJLv6U?=
 =?us-ascii?Q?ATcGutqzR9vK5rvlH5bAqbFEoi7IyJQwXoD7CZd7nX4V+u/kTiu48fhrPhq7?=
 =?us-ascii?Q?Cx2dr5W61Ev/q7CXfbYobGvHBGbld0mTX4meTqpgdCYQdtBO7tM9+OVIZTgA?=
 =?us-ascii?Q?ko5/EQRyx5iwbuI/NzX5gWqyyD++KKCCUDzhk6uDSIL1JxFHiJ4PzS5zInZk?=
 =?us-ascii?Q?QMCQ7O0sbcb4HuTIvAF13wvViMjuSzwlG/fAFElF5ccZQGv1h9sDYSh0S0bI?=
 =?us-ascii?Q?QSwgCF/ZQ/s1hHipf8NipQMbBfIwr+LmOxFd7HVat+GeWO4E0IGt97AZnggL?=
 =?us-ascii?Q?XiHDZqTQNksvdlBBMP1ZBuPVpuYqBqctojohzwBfEQh/Bqq+ZmKiAFScQ6Sv?=
 =?us-ascii?Q?H7+P99u/VXrYJ7byxlNeytxcwoUZSo45ngDuSmxG5NAzd3jSvQj4kmIflU1C?=
 =?us-ascii?Q?u9WjWbuDOg5hXGWDjJO9CleovDKUn7BDKxMAVlXygwLdiQJO48+UTN9UzZRc?=
 =?us-ascii?Q?jzjdRYiqQD5djo7N6x+/JespnbW7h8J+3s4SYUYpsC0vphLAKLyjjhERQqjI?=
 =?us-ascii?Q?scckFwhzElcTbIq+2JxkHjkhepwVSCKep2575c5mqxKTQZJ3wUDP988fgP5N?=
 =?us-ascii?Q?travpFLd0rezNY4ODYVXAdd7in7Lzmb1l5fTnN1w2TXPhN/Q4lROjXpyVjJr?=
 =?us-ascii?Q?mqyYofIcmXhEQf/RzMcb+0Sz/Yt8z6atf55TW5deWXYeZW2WeYH6lRO7i4Ok?=
 =?us-ascii?Q?ZOE8mYF8eEMKto5b/gNFEy1llx3YoGtnZiAAxSTm2rJYu2850RN+3HJburoW?=
 =?us-ascii?Q?9KLHvrQbxfEgV82pDJ0XYIsRDheoXyPNqx+c1zCa6HFxUEVxpHNfrNUU7rok?=
 =?us-ascii?Q?wKtNUVm5nqROfLG57nwI0hu5dx3uzYBX3c31zHI1eUAWyK0WS7FO8cyKzZDn?=
 =?us-ascii?Q?Tz3NLGWRmz36+4XBcSjlzubul4HnHo1G3xlzUEqCfXEAJoYPEVuuKjcnKG08?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bcaf61-3ffc-478e-14e6-08de1f5ea063
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 07:07:21.2964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t07r4GGRuM9apsZEbWs8GUrREEH0Mm+1YB5dShelSV/RI2i0R0hG00k7VMQzi7ikXKX1b1ZRi+Ctv1+FxUE11xJK3IEwHHoRvjF4I8BisnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5945
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

The spinand driver do 3 type of dirmap requests:
 * read/write whole flash page without oob
   (offs = 0, len = page_size)
 * read/write whole flash page including oob
   (offs = 0, len = page_size + oob_size)
 * read/write oob area only
   (offs = page_size, len = oob_size)

The trick is:
 * read/write a single "sector"
 * set a custom sector size equal to offs + len. It's a bit safer to
   round up "sector size" value 64.
 * set the transfer length equal to custom sector size

And it works!

Thus we can find all data directly from dirmap request, so flash specific
parameters is not needed anymore. Also
 * airoha_snand_nfi_config(),
 * airoha_snand_nfi_setup()
functions becomes unnecessary.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 94 ++---------------------------------
 1 file changed, 4 insertions(+), 90 deletions(-)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index f1f1a5b9d8d..7d6af690bfe 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -218,13 +218,6 @@ struct airoha_snand_priv {
 	struct regmap *regmap_nfi;
 	struct clk *spi_clk;
 
-	struct {
-		size_t page_size;
-		size_t sec_size;
-		u8 sec_num;
-		u8 spare_size;
-	} nfi_cfg;
-
 	u8 *txrx_buf;
 };
 
@@ -486,55 +479,6 @@ static int airoha_snand_nfi_init(struct airoha_snand_priv *priv)
 				  SPI_NFI_ALL_IRQ_EN, SPI_NFI_AHB_DONE_EN);
 }
 
-static int airoha_snand_nfi_config(struct airoha_snand_priv *priv)
-{
-	int err;
-	u32 val;
-
-	err = regmap_write(priv->regmap_nfi, REG_SPI_NFI_CON,
-			   SPI_NFI_FIFO_FLUSH | SPI_NFI_RST);
-	if (err)
-		return err;
-
-	/* auto FDM */
-	err = regmap_clear_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
-				SPI_NFI_AUTO_FDM_EN);
-	if (err)
-		return err;
-
-	/* HW ECC */
-	err = regmap_clear_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
-				SPI_NFI_HW_ECC_EN);
-	if (err)
-		return err;
-
-	/* DMA Burst */
-	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_CNFG,
-			      SPI_NFI_DMA_BURST_EN);
-	if (err)
-		return err;
-
-	/* sec num */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, 1);
-	err = regmap_update_bits(priv->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
-	if (err)
-		return err;
-
-	/* enable cust sec size */
-	err = regmap_set_bits(priv->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
-			      SPI_NFI_CUS_SEC_SIZE_EN);
-	if (err)
-		return err;
-
-	/* set cust sec size */
-	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE,
-			 priv->nfi_cfg.sec_size * priv->nfi_cfg.sec_num);
-	return regmap_update_bits(priv->regmap_nfi,
-				  REG_SPI_NFI_SECCUS_SIZE,
-				  SPI_NFI_CUS_SEC_SIZE, val);
-}
-
 static bool airoha_snand_is_page_ops(const struct spi_mem_op *op)
 {
 	if (op->addr.nbytes != 2)
@@ -618,7 +562,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	size_t bytes;
 	int err;
 
-	bytes = priv->nfi_cfg.sec_num * priv->nfi_cfg.sec_size;
+	/* minimum oob size is 64 */
+	bytes = round_up(offs + len, 64);
 
 	/*
 	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
@@ -805,7 +750,8 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	size_t bytes;
 	int err;
 
-	bytes = priv->nfi_cfg.sec_num * priv->nfi_cfg.sec_size;
+	/* minimum oob size is 64 */
+	bytes = round_up(offs + len, 64);
 
 	opcode = desc->info.op_tmpl.cmd.opcode;
 	switch (opcode) {
@@ -1098,37 +1044,6 @@ static int airoha_snand_nfi_set_mode(struct udevice *bus, uint mode)
 	return 0;
 }
 
-static int airoha_snand_nfi_setup(struct spi_slave *slave,
-				  const struct spinand_info *spinand_info)
-{
-	struct udevice *bus = slave->dev->parent;
-	struct airoha_snand_priv *priv;
-	u32 sec_size, sec_num;
-	int pagesize, oobsize;
-
-	priv = dev_get_priv(bus);
-
-	pagesize = spinand_info->memorg.pagesize;
-	oobsize = spinand_info->memorg.oobsize;
-
-	if (pagesize == 2 * 1024)
-		sec_num = 4;
-	else if (pagesize == 4 * 1024)
-		sec_num = 8;
-	else
-		sec_num = 1;
-
-	sec_size = (pagesize + oobsize) / sec_num;
-
-	/* init default value */
-	priv->nfi_cfg.sec_size = sec_size;
-	priv->nfi_cfg.sec_num = sec_num;
-	priv->nfi_cfg.page_size = round_down(sec_size * sec_num, 1024);
-	priv->nfi_cfg.spare_size = 16;
-
-	return airoha_snand_nfi_config(priv);
-}
-
 static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
 	.supports_op = airoha_snand_supports_op,
 	.exec_op = airoha_snand_exec_op,
@@ -1141,7 +1056,6 @@ static const struct dm_spi_ops airoha_snfi_spi_ops = {
 	.mem_ops = &airoha_snand_mem_ops,
 	.set_speed = airoha_snand_nfi_set_speed,
 	.set_mode = airoha_snand_nfi_set_mode,
-	.setup_for_spinand = airoha_snand_nfi_setup,
 };
 
 static const struct udevice_id airoha_snand_ids[] = {
-- 
2.51.0

