Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3382FECD9B5
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 00:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0372831AC;
	Fri,  6 Feb 2026 01:45:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xkP8tjRR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9823B836D3; Fri,  6 Feb 2026 01:45:09 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD12D83015
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 01:45:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTvIWxS80joHIp/f7b0TT5edXQyFRVIkdOqPGDROb1uYvUue7xd8WAnrXSxzPpeiLGYzbTcT/yPQOfcFaHaJymERmYuBfCIPc1c3bN5mOtAlZooMGxEpPxgVlVvM74PyXiuNu+W9LHCT4mc+DK7sW0uACzAVg1eYxjjy58lBH0vbSMyfEEqcVJBeX6bDMJ+xEZTu4NJr/ITyFZZ8XyD0vQCBKWBaCSQemLSflpQ63IFfZhtmZIuO43VS32N8dIZC4ZtmZOhOKen8QZxmT4UX4AqotSpHd711rFlIezMMoRFbQdKiHYXZ4pfpXSDgCHtA4nGauFh1AiHKkbNCXYndPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHsW+Ia0G5lwaBaY9mccGKMHkyrvXJnb7Lttm0gPWqI=;
 b=uINQmw97zgt1LEdExP3UkT3wHncvu4jNpks/fLLo8hiTw0Pf69EbhKaS5afurVe/Lk66LJAu/+YK3tbeN8Ej2eMRJAZ08wH4I4wV3F2I6SFaBlicDJhY3rMx62Izi/3V0p/xI6TngUQrQGQL2zMuOnXberFHcQqh3KcZ8w8psbFRx+UvqzDHlHBHi64jA0Eud93kvax1gb9rrwMh4MGzL0NpLCJNYGKCuyrFtrb0ooxw1pB3wnIf8lyJ+A9dER9eaMF1ZGSTibFaf4Qy3sQzvQ8ZugoKG76+wsnJF+E7mwoB7EujVKGPnY5sWwqvbw39ABAiWYRDWIF/rcqfvdypvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHsW+Ia0G5lwaBaY9mccGKMHkyrvXJnb7Lttm0gPWqI=;
 b=xkP8tjRRJ3JrWsy4ZkiAGmdgS11LRjhejoHEiP1KtjfYqikVR/CnuXgm9mDdmU3Y84B4TR1iJhe44P9mTZUYlrx4WjeaLZcfG8bsed9151nF03gmWsjUEsJhiRCpfsUuTbbyAY29uejatP2fUgdt2w+O/CvJwe7+2R3MWrJ25XZBUa6O3hvlLcqGXLhfKWvLmeGoyxA5NR3HpbEfZlxHi/ge4iaLYV0q3rdirZjSXg8gatI+/oJ8UegemVtoChMf2cEn7ff2AXVJ0c5fxafN1PbocyIQq28N5s4gs2iAjmm95p6wdgauQLHWOCYYlUQ1UHnicbTXPmshDOtXT5SwpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB11598.eurprd04.prod.outlook.com (2603:10a6:10:60f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 00:45:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 00:45:05 +0000
Date: Fri, 6 Feb 2026 08:46:41 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jindong Yue <jindong.yue@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
 Ji Luo <ji.luo@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 09/12] cpu: imx952: Add i.MX952 support
Message-ID: <aYU58RJUASA3dBRW@shlinux89>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
 <20260205-imx952-v1-9-2103d0222a0b@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205-imx952-v1-9-2103d0222a0b@nxp.com>
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB11598:EE_
X-MS-Office365-Filtering-Correlation-Id: 698ef811-3a62-460f-e743-08de6518f838
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DflY9LRA8I0z4FCY1PKRtI68YbrqL0HxJXCVhYj5Kid5iCCvL4PDSargQZKV?=
 =?us-ascii?Q?vr07G0VVqDHCnfGY1XMpz7JNmP9IVnHpliDwjf2TOa2Vveij6x4GlnBWVYtt?=
 =?us-ascii?Q?hsQvJaoGWv+Cv9A5fL+AuRhAXTbFduUJWgLxJhFuxkGv7bsJyAlVypnjJ8tN?=
 =?us-ascii?Q?x46XwkryMqQmCM/cf8phlZNgGu4Ebig9kEoFc7l3vU5Y+H2OR2515viJ/c+N?=
 =?us-ascii?Q?X14cn79VjHdFttMCkW0PaWtpwp1pdCVYbATXfr5/6H6Zg1tgNOWRNj8XZ5Cu?=
 =?us-ascii?Q?fORPUtH4sZaWy5/IZpePuyayYYob1J/UaL75zYjNUPwsYbpTWDCQ8G4WQfhr?=
 =?us-ascii?Q?rsmlH6eHhr32DJFjWOjpBvFXym5RGdXLPWdhGB8L6rOZL/C47GlZL7eJ+GuA?=
 =?us-ascii?Q?ycGP4Qb/eHPQayP1ezSYk9hXrwVIHZN9YfMiV9p1EInQFrzVvrO/KA2Eqq/Q?=
 =?us-ascii?Q?k6OiLKKJqxFfZflaJD9WsQ9mBbdEbdhUnq16qSvgoa5LbBidUH24EWVXMOoH?=
 =?us-ascii?Q?pZQ1WeCaJHUwCDWcYckoMW1HzChvicey2R0ukRP/GShLnsgqU9clW0dWSIW9?=
 =?us-ascii?Q?d/UGLaXpp157PlpJahfxdJX1RhLjn/Y4Khh5sRmD8EQJ6rdbYSLLXPKUD5qG?=
 =?us-ascii?Q?78wCG7iBR9JH2Gv3wyvbdrP/jReKUIfqmZ5fQmcyl9LiI18ujPZR5VhXXGMN?=
 =?us-ascii?Q?fJYUdccBy3pDzdoPAhLQxeWbLXPyQHibCWGEXdRaQo3NnW1k59KHPB6WcOWe?=
 =?us-ascii?Q?H/VUv/oVsZAGfJRoutiI1kvf63HQvf2r0FJcpHJ3UE0/YvsXAyZAdQ1Fdrql?=
 =?us-ascii?Q?F7u9lERb0GljLQMCal55Rr03sFwBCJZ/s6nblkZsm764t+X3q2ZNqGqArWP+?=
 =?us-ascii?Q?mdyzCBFRJ4LBQXjVkJbmBbiITxVBDfyDNh5VyWx1e/5rrGo8a5zcSeLBA6iP?=
 =?us-ascii?Q?1cmJqJXhXmAx8Du6Xc2UPf8avdbD1o39EU47e8tvoAMGDg5BB8lINTGjNwT3?=
 =?us-ascii?Q?XMLPCNHgdaUV0jMB6qlhXSWIxz+ML7HG2MQ51nikY2gdKt/2LvlEcoCnWqO/?=
 =?us-ascii?Q?8V6mW0tRLyXWHf8KY/+p2xwuQ9KpvD+/FHRqqXAfU9xDkfwZsqCasN/t9wuo?=
 =?us-ascii?Q?YtRu/vFVq4NlrzE8rDeVf3tccoCxmSMhxRpDnDxmd1rVRC392eR0ZyMF67RM?=
 =?us-ascii?Q?IJ3M8kvHFVmNQUm+CzzUtvkGaOgaZqohp85D9icuwVlagVziKhj28x3/htws?=
 =?us-ascii?Q?ufcbFBiFdu0pW+jo5muLG29NDqNVYNf34JMjqSUmIq5Bsnob3kSOuF72mZ6o?=
 =?us-ascii?Q?yLxPoFMpoQkxR+8v65sr+kaluOgFr+aUrACisDNjK8z0SqrwsEdvVWm6i57o?=
 =?us-ascii?Q?Sm0c+xUt97zI+ylv42/NEC9YI1TpPDDxOphxnTCGn8Zj7X3MMGnLggiW5zW8?=
 =?us-ascii?Q?VdWZiozJXy0i8nEFBDjyb2FmmMU387vU/uPQcWawhAiqdOVEcV+8rJAqFLr6?=
 =?us-ascii?Q?tyADs4KoqfNG8p++6+C7jkTN/AmbWFIOZm2do2jVWWOYbk1tJFcSx44AciyG?=
 =?us-ascii?Q?VZOuTICvJXj3ygLdRRUzTTNTy+VI1bF2q6Wux8OR8tskliv/qVLCuPvcHNz7?=
 =?us-ascii?Q?q8STOHExfOfqlKVr2injBfc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Io4Ab7vdOKHd9VUu3fmojNWyJT86gEhwp8LJIzB21Cleb0kYDb2XX21joF4Z?=
 =?us-ascii?Q?dGpSbCULMlF4dDi631AocfURYppwotto7TBBM9fc2sMeylDU8btWft1kZ0Kc?=
 =?us-ascii?Q?nShErO/IFr22SswNiZrf45g/z8QQb35zzBpP6nQwU41bigMFT9jlboTDAidc?=
 =?us-ascii?Q?k/eWY58n02kP4NQDvzqCUF/I8zAPBZ8uO2t9cY9oGBNXX+hZ0i1DAzMN12kX?=
 =?us-ascii?Q?fzGw1ZS4iqaIdQ2lM02lLa3iqr8jHuko1WVwpj70MniUy57caHsae6TKVPyE?=
 =?us-ascii?Q?gZ7aesQSpVNt3Wv9Npxhj/tIY4uFSaT3rcPdZ/ADin+Bnd1e4D33xO46naFv?=
 =?us-ascii?Q?2DTQBhko9RyxPvV4y6HHQxp9XmPtJ9XJNKTsu8DrM2tIX0Md0Lv3+yKeZmvS?=
 =?us-ascii?Q?/KjETGDtsfmSWWno9Nb36694JRd0DvIZg5svTzxJAPpXqdNqDBuqrHfWENdH?=
 =?us-ascii?Q?nwWwYwNo34jKJqqnoSI394mOxvF8BVi/lPkJCKlj9niKx9O4sizsacGCTlRa?=
 =?us-ascii?Q?oypEs9Liv4JprKp48ZONnfFDzQ/YLR9+2tuCazvGtI7bHhP95vesslVrBCI/?=
 =?us-ascii?Q?AXz9sdCviEEuclXU2cOAxOBBn10loOf3WsdwnX9bWqQctJDDG/aQazk+Iw1r?=
 =?us-ascii?Q?mrP7TetQpDxhAqpqVPonyfTg/EtkWpI+Sgobu1yw+N1MRSJgsCX34J/wIIgK?=
 =?us-ascii?Q?ebmE82HiInZuZgUUacUlxsS3J3Nj/6NnYmewsvRuBnao9MAWqEt3OzfTA5Xy?=
 =?us-ascii?Q?6FdMEpZ+Hu+IomFBIVHj0tOae4ESgy4+Yz9W/fdll14wUOjXL31vtvquc9ik?=
 =?us-ascii?Q?eC+9gWFV25Mo5wNmHCJz0Nxwm2nlpuyVVKfN4HguiQj5a70Yj30wksrUFuK4?=
 =?us-ascii?Q?eW/uEsszdYnoFuYZp5vaTnJX4cfx2AC1ryvltdDdwUtPrOwaYMqqQZMi5WUj?=
 =?us-ascii?Q?NRcvsjRwvDjDMXDgHUYhvyEhL7Aw0EXjwSSNVEmeuHH9cNcSkF8BZq8Z2138?=
 =?us-ascii?Q?q/0nbBk+wcWU00pa1SZqmMC9NToUeoxNhOxARPigN4j/wNCZax0BNA5n9THx?=
 =?us-ascii?Q?SsQ3I2SFwf6AKfpNg/AHifti23xkkaqnGv+DOCrcRFC6Jsya/ys9Tapjiptc?=
 =?us-ascii?Q?YrseEVhix5gdLaV9pniS80ErTLkaBi8/C75k26ACxO5DjK4UvcOOduNcRfnp?=
 =?us-ascii?Q?2YKbgUcWzTddOJkGnuuHzsuqIkAj2cxtevWef1VQM3CeCnB7r/2RUbFRLN7K?=
 =?us-ascii?Q?NmCuK7lCPhcvAMmHLaug4X0XOvtlA9xsS7A0xWWEm6CWAjIlMZiA3ko21ugs?=
 =?us-ascii?Q?g2wVGRwlKz50dhW8xV1SD8jLnnWB6Tf7xB5d5ZhJRE6VdBKaePnWWSTXCJTw?=
 =?us-ascii?Q?VgPOmsqI9qoOiDDA51H2Sp9FHX7Oc7ogp1MpiSnckZaDie5ZzTneBd1yXKGV?=
 =?us-ascii?Q?jDjzWWtXNVwkUp72OxFWHkDLZKVUBRA+S+927Kd/yfAiTl1m8C8twUhbHdsI?=
 =?us-ascii?Q?m3RzbcVh6wx3bhw2/I2RqCWi9v07aW27CQUZBB0YtVZ5IAMehA1V7uvn3PAJ?=
 =?us-ascii?Q?r7Oq2hFLZmLljSvTRgOhT35Yfgn/I551ZnmwXMReP91JBBOFyJ1/KtXom4el?=
 =?us-ascii?Q?LvtRdAKo5VgX1KqdBKIHUh4IjnLo81LK4pJiG2N/nrqR8SCzioutIRy1r3KC?=
 =?us-ascii?Q?Rev6FEyOLh2nshvbaBm9Pv2+bFSqFkseA04yL40T6avjWBswhHL/42kgyxwu?=
 =?us-ascii?Q?0xdoRRyjjw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698ef811-3a62-460f-e743-08de6518f838
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 00:45:05.4386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3mxLlOxtmaW7hJ0/XJXico+6Baa4Eah/mLKd2lBHGgNrw86CCxDK+dhGKsdh9l4Oipfc5IrnjK/WYdnEjZdXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11598
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

On Thu, Feb 05, 2026 at 09:55:15PM +0800, alice.guo@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>This patch is used to add the imx type string of i.MX952 ao that the

ao->so

>i.MX952 CPU info can be printed.
>
Regards,
Peng
