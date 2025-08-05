Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D77C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 02:57:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A0EB840AB;
	Tue,  5 Aug 2025 04:57:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QTZ3mszC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7C66840B1; Tue,  5 Aug 2025 04:57:06 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8BAF83AEE
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 04:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYpu8WQchQzfs+yFl0zEdLf4cmuA6mdzNCogjGW8YK4nQdRTsYeDCOosXuT85Mwj+o21r7YTnKcsXDugo2St/aQwOP9BnJfwzaUmn0fyuhhdOzZDt7i7zhJ0aiqJjIKYYJppN/CID/X3vv82xnHTb/VKYTspIxOqUO+eEoSoWvLiI8+P6wY/aym+lAF1Z/nMSMqPZEEw5Xxv4RshYDN0mmnjIMBkQjgQ9vi2r+7L7uB0fWXvpBdb9AuOnvA29JELu/g3XzAr65XD5mddd0afry0NmrfL6PiL/po5VkXE7dnXdnzQphQPgl0DJw+ESdaaqv8eSUVG+pzdNTAl8uRvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9I+5iJ7if6B+BqmdNCXHbsZOmcDgz9oIY6ftcRCquik=;
 b=p5jzsj/ZUGpWUfRCcFkunGtQpeeTLoW4DR07yIgkTob11bRwSTIpNoaBUmAKDXujAYySZB06txf3RifM4Uwr6huh1dXMLLpoIj99e8fDDIbGSqAnCIcNPB4gc5CvXqNgw++vJpQC2w98ZsYJcs9YGvz/K93/JxDF6mGuLjeJ1uyZc1SJaNWWngOMpaWcNoIdbKaVagVpptWk3EZZXYASrGJJnNcGxLk4aYeawGMaWxIYhN7sBYEV4mmJSLf93XF/Pmb/U1UU0tQUjgZBUUtrwj+nbZ4Wy94AXrqs+Ig7Zle43rWeFJk5YGboNGCucaSz0FMQBUH2VMuv7WC9I7pnzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I+5iJ7if6B+BqmdNCXHbsZOmcDgz9oIY6ftcRCquik=;
 b=QTZ3mszCIQHYcHx3yg5N1s+sn7WmrTsvpxivMEQuepjDue9wF3kYg+1vzPt3gxweF3h04jqV4Pfmzry7tDbtjmAQvk3+c+9ZXv6XhZvJGq0sM3qi/O3vMxpYa52pMfxNl8C0I6Kl2QM9mh4e2dFXdfUogKpVAXoskYTTxy/idhX8x0hvUma9Gtb3e1aleVtFp08G5XzqNOvPaGySqdiu1JHXjZzXoTBgiz3lJ0GmJ5WenbT0/96uQFY0EuMe6ju/rBbJKCSEvd1zwi7y0YMoRQ+mzWGL3RIc9NyQ6dROmsydo3OOTBy9lEOS7PYowh3BAWa+lMTJbw6fA5xNJjRGVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA2PR04MB10185.eurprd04.prod.outlook.com (2603:10a6:102:401::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Tue, 5 Aug
 2025 02:57:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 02:57:03 +0000
Date: Tue, 5 Aug 2025 12:07:50 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alif.zakuan.yuslaimi@altera.com
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Subject: Re: [PATCH v1] mmc: socfpga_dw_mmc: Retrieve clock manager address
 via clocks phandle
Message-ID: <20250805040750.GF29103@nxa18884-linux.ap.freescale.net>
References: <20250804004710.10222-1-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804004710.10222-1-alif.zakuan.yuslaimi@altera.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA2PR04MB10185:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b63d825-17e6-4dba-e55e-08ddd3cbc120
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|19092799006|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4uCb7/LFIbt3LuQ3zekBQ/KQfiS21o/HHMm64OODkR3bgzpkQFi7oyeNlUf8?=
 =?us-ascii?Q?OpGkYvaXuwAvOcvcFousByVg7ZlozO1hj5MEk+JYzKqPltbZBmDLOWr1wwW8?=
 =?us-ascii?Q?qIc9BJbiNL2H5FEDZ+zCS+ndy/sWMUv2Dj+wWmDx4zxHfIGVIZS3c2klFsy0?=
 =?us-ascii?Q?mCDrA4bZYRVlhXJSVIa+1VJIodJNOybpcnYU796AOUxRnw41Ft2tWAYbTvMD?=
 =?us-ascii?Q?kMYuo0Cf0RxZD+XmStE7u8B9MC2eJpjNWtE7WyXnwxL3VzgO2Oh/AiN92BGO?=
 =?us-ascii?Q?iLe8SNXReVgIe4D+4IsRKgViGv/kE5vlzyGWtCP5adDhsS4jNkYWB8mnmQDM?=
 =?us-ascii?Q?l3ZKsX4VCwdHCjV8vznYi56ORcgKYq/QoeBUwYmwiEYAF5OL4tcgx6xsUU/S?=
 =?us-ascii?Q?o0ybeXMJ8mGIr92hUBCSfe1hoHac05APjGrnBYvN0tK5DbJQkuc/UyRVBaxN?=
 =?us-ascii?Q?vuA6wkpO+aN3b9FWw8whxV6hCDyTPlZuwS01XfBxOGsK7RKWB+SpsfiGCcbW?=
 =?us-ascii?Q?D9zd4eKGY49uPB8a1Jw09IwJidQKlVHmAGuNsfTlS9JmF95L48f6x0AdDiTD?=
 =?us-ascii?Q?qlX+kZgoIyERuiQrPoHcvYdAu/1raLTGP7U04jpsIoObNRVedgp4r1ztqPOX?=
 =?us-ascii?Q?jd+LU9hxgf6xG62LhSoFIavmk3/XJ5nUt6hZB3zcqhQCOq2R0Yo+HS3r2Pvc?=
 =?us-ascii?Q?C+5DRADC/dJWMQPEx3ei+vMIlc69VaI7MfBz3EoDxHlwAk7i/19BQDmCFkYQ?=
 =?us-ascii?Q?L6Y+TDwLE+anduVaPOSE6WtoTf51M57mXqieP3Ii7v8WjD912T8um2JtQ/lA?=
 =?us-ascii?Q?Ee0hh/BpYNxnCvf9VFdbiLgQe6l8rTeq8GtmG0FbI2HmnJ7Im+nlNIlWmTrx?=
 =?us-ascii?Q?Nz7PsslJPsnXNPB1YObkttUmlWi5UolzSctJNJHsdVbnCCxsbslifkI3foR0?=
 =?us-ascii?Q?d5Em2h+2K/sr/3dGWZSh/yB7Sz+OXNr5myxH+VBqqHBkPmm2rJz5Oug+ocUN?=
 =?us-ascii?Q?wNsHXKVbL8eqTn9Fw6RMNk8H61/sxeVsj9SsXtKKEcsc8IQ92frM+1Ydfb5f?=
 =?us-ascii?Q?5fsu0PTF+qz5b55oloc3ulT2GM0geDmmx2GQRw+DY3ESDDdjnTt/iIHGOYik?=
 =?us-ascii?Q?aTUm3Wb8iH1mllCf5MFt+z1xD41txwtur5ulpJgcEvFI34WhuLroS7TVp/YG?=
 =?us-ascii?Q?yj5qGG15jTeYcta3t+PKnnCiflNUkmDRrvFQwmMiv+ai/k82whcoWuyHbFdd?=
 =?us-ascii?Q?eJjjUXMXOhuWSOXfxDoNglNaiQpZhkLt3Vd29Zxlo8nlylvfeLAS6dk07x6v?=
 =?us-ascii?Q?FpIfwnNWOJaryxjM1qUveQuIaC7kaCkAFsH6YREYrBO2MIoQvtjLhVBpd6Jp?=
 =?us-ascii?Q?s2naPXVcl4M9lv+YKqNFyxeZ1Cf44AfIRq71ugPJvTY4mhInm4p7gNRJDPu7?=
 =?us-ascii?Q?XpD9emLyFiiSsWUeKyv//vmdeCtp4Grli1TtRAuDXtQhCHAVd8nNzw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(19092799006)(376014)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xSISH2TmvUjUPPfb50IeImsVYgMcb0TPGc7QSZ8H8NS53UD+L7DN2hjE2KCi?=
 =?us-ascii?Q?epVpsFmlwt1SWkmsLoSYk9RP2BkL/N5QCGeA0c8L6oq1Djw43Kw4mckka2jx?=
 =?us-ascii?Q?JsFh6csiH8EpR4fKklR4hgKii37ZvThYRhYxQFHB/p/Y/shr5E1vERQYfz/S?=
 =?us-ascii?Q?4gKZHiefQ92FFqI9ftqajEMQuV+XLR1w2yOCqwNtTGpVp4dlCv6xNFcC+uxn?=
 =?us-ascii?Q?qmSU8K5MlX1WJF0vIIrczEcFuZ1ylGSquhuwigkgDuayP61/QfGDOMsVZ+Ov?=
 =?us-ascii?Q?14AkeCN9uttmz/TEDvMcRpryOnturfm4bHYt+MmABbHQ+L5JWHgh6CA1bcf6?=
 =?us-ascii?Q?FZWIkyD6FFtKc4uPlI1ZJGn08CKsS/pqlKP7AOeEusMfPsgPbGMWihXT40lh?=
 =?us-ascii?Q?xdB4f8H8iqlXiwRSExp2rbSzwUtLkZ76IZj9YsR14cnsIxnsZ5h8xzRKYtrU?=
 =?us-ascii?Q?EHtFMxX2bhbCv2GV+dxguNII5/EssGUndkof6T5zlfGZ5Mi/rRw13EwrJmE+?=
 =?us-ascii?Q?RDRynEN5WxtkJIuySpzEsVLhD7gQH9wDoLoHYt6B/kPruJqslBNp0rSdypec?=
 =?us-ascii?Q?BrFpvX+VfZcH2Tcl6haMS5fzKQHxiOXQrG+iqqrTOxFAJEqfRnJgPOX/jklS?=
 =?us-ascii?Q?eP/tgZrPEQl42edhBPu0lRliDvWVTBaxC0S7pQCBjS3ES4/NI3ZqwiuUKMIT?=
 =?us-ascii?Q?G+vcik9Hhc3muhGZNGu+IrvWv9nWgx3c2O1QdRBwkCd8rd0vPDBiHSZnAHUc?=
 =?us-ascii?Q?vlSqXsbTYFyuH2O1oWMQ32ehQQWOoOmrzOrf5Wd+1yKfZauobnzRuCChrj1p?=
 =?us-ascii?Q?LB1mxo3vwZW7Q7rFwXLZbayZ2P9ScF6EnMPiiIu9IyH/f7BRA9ZxfRv2DSzq?=
 =?us-ascii?Q?3qO2ze7mT+yxbB8Nu1Bo7ABm/rvTIB+IT1E/hwLazO2hYlPj4L0UpPvwGGYV?=
 =?us-ascii?Q?N8X8R8G1q7IDTsy8X97J/3jsigTpWCkdDS0t7MqtG2torMdntBwwhL8acdmx?=
 =?us-ascii?Q?KZ+jhtRlhLJ5VAVFUfrMChR0M7sniA0aIsajAkPY78GHRRyWG+2ZRV8lm5SJ?=
 =?us-ascii?Q?tqYvu+Sx4BCaMAhGlRGqof8Sg4BgEpu8VpE2Jj3VKj2SQ3sKpDm+qaqA6kXq?=
 =?us-ascii?Q?tw9xlOlwYWmaPyT8y5aaXQRdkBKcjh1n9V1C1ewn5VwwsebW/cXlVSFbcSu1?=
 =?us-ascii?Q?hT5zRO/fjLEsqDuMTFm5fYTIj32vlKLADv0aGiFnsmN1UGjbOjYyBjk6KOtw?=
 =?us-ascii?Q?PhnS3xo6EAQ5eViDiAVMLi8AK5qVHQxtIpBXVxfHQdJfkAgbp3BlGabTMOdB?=
 =?us-ascii?Q?lGA7MAkMERwN9lSpCC9p4NIlu8djLSe/xTPaDLWUw1ck/TG7/veFpAKejNS5?=
 =?us-ascii?Q?JIRhW0RvLrjRm/o1Bbvsv49zwura8bikhaynZ3/OEUs2z11sSXy+mq0oNmuz?=
 =?us-ascii?Q?eBbN/fFvddVy5sBAhHJ+4eUKUNqUPTsZANZsRYqiGYKD5RMB2WsLliXhx5uP?=
 =?us-ascii?Q?eSQP/+xxv2Uc/fog+Vvu2XxFR48mq2+rE/RNItiyrVJvQIdY/enasJNbfE2U?=
 =?us-ascii?Q?Z+X/WhuRfMRb8qGyXPJQMPde/57fttZXUZ8ST6CY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b63d825-17e6-4dba-e55e-08ddd3cbc120
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 02:57:03.0553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvuNqsyv6eUNjpeck4baHJymFxZuqIaoviY8XlTQ4H74MrmqEXBWXymd45sWRYfbz+j1OuHkGv6ipYk+3drPkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10185
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

On Sun, Aug 03, 2025 at 05:47:10PM -0700, alif.zakuan.yuslaimi@altera.com wrote:
>From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
>Improve the current clock manager base address retrieval by probing the
>clocks phandle under the mmc node in the device tree instead of probing
>the clock manager node name in the device tree.
>
>This will help to make the driver more scalable for more families as we
>no longer need to rely on the exact node name in the device tree to probe
>the clock manager driver for its base address.
>
>Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>---
> drivers/mmc/socfpga_dw_mmc.c | 19 +++++++++++++++----
> 1 file changed, 15 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/mmc/socfpga_dw_mmc.c b/drivers/mmc/socfpga_dw_mmc.c
>index 3b86bc9b18c..ff1dd0055f8 100644
>--- a/drivers/mmc/socfpga_dw_mmc.c
>+++ b/drivers/mmc/socfpga_dw_mmc.c
>@@ -54,17 +54,28 @@ static int socfpga_dwmci_clksel(struct dwmci_host *host)
> 	u32 sdmmc_mask = ((priv->smplsel & 0x7) << SYSMGR_SDMMC_SMPLSEL_SHIFT) |
> 			 ((priv->drvsel & 0x7) << SYSMGR_SDMMC_DRVSEL_SHIFT);
> 
>-	/* Get clock manager base address */
>+	struct udevice *mmc_dev = host->mmc->dev;
>+	struct ofnode_phandle_args clkmgr_args;
> 	struct udevice *clkmgr_dev;
>-	int ret = uclass_get_device_by_name(UCLASS_CLK, "clock-controller@ffd10000", &clkmgr_dev);
>+	fdt_addr_t clkmgr_base;
>+	int ret;
> 
>+	/*
>+	 * Get the clkmgr device from the first phandle in the "clocks" property.
>+	 */
>+	ret = dev_read_phandle_with_args(mmc_dev, "clocks", "#clock-cells", 0, 0, &clkmgr_args);
> 	if (ret) {
>-		printf("Failed to get clkmgr device: %d\n", ret);
>+		printf("Failed to parse clocks property: %d\n", ret);
> 		return ret;
> 	}
> 
>-	fdt_addr_t clkmgr_base = dev_read_addr(clkmgr_dev);
>+	ret = uclass_get_device_by_ofnode(UCLASS_CLK, clkmgr_args.node, &clkmgr_dev);
>+	if (ret) {
>+		printf("Failed to get clkmgr device: %d\n", ret);
>+		return ret;
>+	}
> 
>+	clkmgr_base = dev_read_addr(clkmgr_dev);

I see this driver use clk api, so why still directly map the clk manager
base and configure it. Shouldn't clk api be used or assigned-clock-parents
be used?

Thanks,
Peng

> 	if (clkmgr_base == FDT_ADDR_T_NONE) {
> 		printf("Failed to read base address from clkmgr DT node\n");
> 		return -EINVAL;
>-- 
>2.35.3
>
