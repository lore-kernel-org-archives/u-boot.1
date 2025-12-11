Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355DDD41C14
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:07:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C03C83D1A;
	Thu, 11 Dec 2025 11:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="f/F5FZtN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E177683CAA; Thu, 11 Dec 2025 09:28:32 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2C5083C7B
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlAgyQ7m6cvagchY23RsFKTemDrNnyaYCq+yfzHL1YqZd72Gz+h5IfMJiGzMR0cvEdkHQMUxtzCs9tiQ2Zq/o4kHk3MzaA6Y2Msi2G1drecNPiUqpUDQ3IBof22pm+AVIBBTRQ0PXILYYSKCRQu/AlayLFis9Ca8iWqkEjZ5sAHAcqoRDQ3F/GbMSybZfND7HOGnJlzwFf5tIVayjaTnvok5WxWREBx5ucCzWDubcXiHNuZ7jt8kioqJT5T4k0ylfDhCmk3b/1RCpxYf0MrdZvzfjcUuBgeEjUH0txkRSIkUdZHF3Sl35gQrYMna1zWKKjQOO2/PphD5P8oehKn6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuMuAGFoK27VUqAgHfQ4gvx3C4xXHSoVNElgAY61zeM=;
 b=zSboppWu+Rquq3bv6VPuYb29KM/MZnzYJ6wygmNvaczBg/WKoDyFXPfhwbS7h6gFS4sveCvlOEswOFq75IMEHfhUdtQ44mIEIgdMvFaLKNBkafs6nPQEO0YtUW8ltuE99K1xAH7iIYKXd4hLw38mowDCDmvQ8qvmJ+sEXFvLNUdHMO5WkOAboqxC9637oyGQNZnmg2J71QERndAxJgXibSTHer/BRC8xc8SCgD0Id4FiOnC4umMgIPzaZWtt/3Nz/KLrESdzqXUOfs1zoxqlu70HKKz9WL+wPtz/0TgFVTZBxvMbIsNU4YITGkxzTjcGNnbqShI2WsLVx2ZcesXkHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuMuAGFoK27VUqAgHfQ4gvx3C4xXHSoVNElgAY61zeM=;
 b=f/F5FZtN00ZQPua/m3c7fdp8UQYSFPKamnWy0mRqrifLDHVseudEQkACCbss8LXr9QRZVtt9GFpJJUGSpEuT52ZPkZ6jQhNwsQo9EoGG06NSgJ8ygZEjpc3h0vivFWAa+LN7tWAXXVBGq/THoy6tPT6LsNVvubhzGqFQjAb+z38bAUk/a0iy3MikZIOejCIyvKNEMPeUtsL9aoFj1cSh+YPsKu14NjDIi1mlc7T4VOzKOzw2sKjAyTDUbUrGpF7AHHQdKO0icuWuEsXU0eGoWgjaJ0a+SimZofiI1tM8YhFR8Xa+ZotKZ1TiyAhQHPdxPXZeUCS6TPwFdlcEQhZsLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8526.eurprd04.prod.outlook.com (2603:10a6:102:211::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Thu, 11 Dec
 2025 08:28:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Thu, 11 Dec 2025
 08:28:28 +0000
Date: Thu, 11 Dec 2025 16:29:37 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Ye Li <ye.li@nxp.com>, Dragan Simic <dsimic@manjaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Subject: Re: [PATCH 2/3] power: regulator: common: use dm_gpio_is_valid helper
Message-ID: <aTqA8ZmeA1FAfkJL@shlinux89>
References: <20251210-power-regulator-fix-compilation-v1-0-c58f01e0a5c3@baylibre.com>
 <20251210-power-regulator-fix-compilation-v1-2-c58f01e0a5c3@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210-power-regulator-fix-compilation-v1-2-c58f01e0a5c3@baylibre.com>
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cbcda67-fbb5-45a3-1fab-08de388f42ae
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NN8EmSiYiilbsOLkcmglnWNVUUFYNU1+60joBhA7gx2VGi+3AjWjkIosOcqT?=
 =?us-ascii?Q?Gntmq8xjQ2t3wK31ywEHZuXh09+MSTJJA9W7l/vrHbxMKDcIZHCd+StINH1c?=
 =?us-ascii?Q?Tdg1wP6nW/5JQI/ypf75E/E17mj1dOssmKRCo0M0w9LHleROOnjrnqu4zo8Y?=
 =?us-ascii?Q?7oWpIrAPqL1h8IySA/fXY/rv8U43ddnrH/6gvXwdrA9jNQ7WDvLa7Kwl55oW?=
 =?us-ascii?Q?B/nWrrHTB5mtXKaM4pHXTbhy+isn8tztfKaqqnrgLuQLs2aqdPlgRzY9u/aJ?=
 =?us-ascii?Q?zt2voo9S2owcGUqueA9pQbplVPozpJzOPB1FgeLEYdMXEoMLn4lSvwFpnxkN?=
 =?us-ascii?Q?VJ1nFP1yNIXvXP43bk2RNAiwev40OAo9SzGzFe+ru0tk167Z9Vh9LknU56f0?=
 =?us-ascii?Q?xXXr9+7EJfnHc0iXO2DguNfY+PA7Ecz95jtef7/fxJrZ+h0F2BOQiIvlTX5c?=
 =?us-ascii?Q?ce/ImSopwepKo630x8WtvwpxJ9EERVUVY1pg+1hBchGWqy/sGrIozMBguQMc?=
 =?us-ascii?Q?CGRmBEi7pDf945W0xhRiZicZz45vvD2wl5m2WpEmGX9xRtd2BoLM0YcfwnLX?=
 =?us-ascii?Q?j7tBMJDsgdTqffH2Etz99v0NCVGAs1paKCDVXPPtpXBtd4GzMQfhDxYwbxI2?=
 =?us-ascii?Q?i/veA3u9PDAa49uuk0Py1OaWbI+vdH+AvoJojzz/SAJOYcQQHrhWrJePv7G2?=
 =?us-ascii?Q?luZs87UXprF3VjUZzNDaCuNVBbzig0lHinscnj+V0YJ96PCpxlnyQI6hJ0zx?=
 =?us-ascii?Q?3crw7cC08qRKP6WYBoaGdcD0ttPjHEJA1iej6X3DWbGB8tUJ2n/sNQqMUWLe?=
 =?us-ascii?Q?sUSv0lNwnE7i2Wz/tL4mtV7je5PBdvvz3lTstfbh5EuQ4SSl0Tvr8GhUHeBy?=
 =?us-ascii?Q?notBd9n0Y1nZ/wAR9TZjm5L83evAwsSPnvqIW2HCZxePQq6yBRxLLA5HUtp+?=
 =?us-ascii?Q?70EPjkz8Dq/gvcMXwJv5FWpX00bDSyZIm6/nesjI5WDFAAE8KDHbznWQGfIg?=
 =?us-ascii?Q?Bsp0tASC2fgNCMkryLH2+TaE5pAslfPXi3B5gKUvlEKI1VintyGy3K/+u8h2?=
 =?us-ascii?Q?9nuiPTOM+8KYhd46flsFeGuThXyrzBjzXUrjKVthsrXKkFJrZQq4eGCwf1I+?=
 =?us-ascii?Q?hccDCKE+05pg6kMp+w1qdpH416C7XBXL6L4Awvp8Ja8UpiBTVJ4M18KbK6ha?=
 =?us-ascii?Q?X/apZf+mPjIfNyaIOKEC8mDZo/wE0BbObtYlPs1qu+EAvtmrg/zHwX1LBi/C?=
 =?us-ascii?Q?UHgjvKQbTMKA8+2eJgeMbFMV9h1ZLZTQviB9ds8I8BLxslPOELzQOzZEoDsI?=
 =?us-ascii?Q?Nw2J2w040Gw86llxsoBtMfVqT931LPJVpFX/2b52A2IyX5iAgeTew0teFo16?=
 =?us-ascii?Q?msoDD1CmV2cbwZmFKCM52Ex+IRt+rTE1d837FHKqWBKNNtM/acpMtWwPpTXu?=
 =?us-ascii?Q?DCa+NctNnCb0lRjqnBjOwhg6Ft1zI7QBy4SdW2CQyFBqox+YVyWdXKSnReIA?=
 =?us-ascii?Q?R6cTXk+zrj7lVi2DjM2ndqhcQlQFTJMsbfJ/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B3/Ltd3wpsuDsEzxFvC+bKtgQw2WW1CdlqzcwjabUhQJO/vU+f18Q7hma5RF?=
 =?us-ascii?Q?/zVHSGdvJWpIArpRlSc5zpKZ2YrrtjktI8Wh+CDU8B0KGmbFEn2GjR1v5Zt3?=
 =?us-ascii?Q?7QfsgFIDhMlHNuMnYjls/7Rd+njlWA84lfoAe3DE1HTZFdwW5NtcRQURcYsF?=
 =?us-ascii?Q?aYsF9PKJYyAqFlEE0JTKLSIVLkwTGp+hFnDrsXMyIAtSKiV4c7iJPVQHXYzl?=
 =?us-ascii?Q?PBJ6Zox6rtLyuar5vy3iRKLDNK6ZdaqOdSEwQ79VcXnMTthWEIJplql1e9g4?=
 =?us-ascii?Q?ptVmWJ79fRYopsFSTieICnT5F8EXlPA98eB8WE/Di6Jr0A5TLxnsYcxjRwhS?=
 =?us-ascii?Q?YclQCdb6YTrn0TDd5d3wRZKVppQzhMqPiKQyIq++K7HAJ3Rpdf/o8wsBeS6x?=
 =?us-ascii?Q?cEMmd9J86J7ZQU9SQwidPCsnlZccsj87up8yfZBSZ/fxHkKppfH3ixCql8rQ?=
 =?us-ascii?Q?o4vQXWCstrTTnzdC3tku9O8P9GnpFr1Uvg4GJoYIt1onAepxqhoMInTPJmp/?=
 =?us-ascii?Q?MVtt9yBtGGjozDy5zloNdqp20GDuzZhoMaF7hPS8+tsYDck5wTmCLMqu9FBm?=
 =?us-ascii?Q?KL607Jz058dysHCl06TjjMwaAWHedHw60DZzmWS38ZSENIgzves/1BrYoivI?=
 =?us-ascii?Q?IH9yruMw5oKbn1bAsvUfxAXvhSQEbwxBidAnmgbKgS8RLYrK6krEMXKXa/te?=
 =?us-ascii?Q?3SnUVta+lt3f7kiVv6XfDvzqQbLClwWWGjxBfRSKAvgOcVWvvmuMFzEpsTgQ?=
 =?us-ascii?Q?8WWPqESCAuBQ3u03DakH0UxWexH4eSCXw6tZSgTEhBS+ILwZbbsciAvNAmbz?=
 =?us-ascii?Q?rMBY3fRcdZpfiw5Oou3kmfa/5FaDjm5H8/SVVuATcta4pKOyN8+o7y3x1uts?=
 =?us-ascii?Q?eUxkqfnewrFPmZBm5wHBOnht3u/UiJ5m0cbM/sVmQuJbidnVCz8pf7lKegBd?=
 =?us-ascii?Q?1vYeJ7tGYjF7CU+8iU0auoeM96305c9wnPtfgnj2bnVaRauxR03a8V0bMwQs?=
 =?us-ascii?Q?efsh1GwMFzu9wpBInhGz/MYKxX9lnMRLRoc6nXGHq8P8DU/g4d/LFwoGtwTm?=
 =?us-ascii?Q?70nlK1OZqMSeaC/OIJwueFPBxEMsUQpcFi6ztYhUAMSOYYl45+jDZHj1WA0E?=
 =?us-ascii?Q?LEXP86YldgYlg2Ter1v5CM6rGqMm+/cWxLCyZXjv3Xkr6gOYyuqx/iBBhyng?=
 =?us-ascii?Q?IgeL0eLk39gy0Brc9vHU1Txkuw3ext9NqY3EhMeUnSp5WTuQysT1hM4J4drO?=
 =?us-ascii?Q?qDB3Ww6iaOAJfN2KmmUoA9uPtkCVM2OMYHFXlwhyZVlRXf+ip01fQFAW3kGd?=
 =?us-ascii?Q?Tt05dWk3Ev/q4tQgnCsIUixAQnZ9YUPaj6ypwTU0HcAMQq4qA8vipLWk4ROS?=
 =?us-ascii?Q?+yk0lxXz9dXqmXs/5tK/Zwh9qglHhJZIm+KXjlveKv5elxZHuMxNfIJKxKgc?=
 =?us-ascii?Q?O5GyzrRvWjRWNpn1rflGJKzRDXqCcVNPIunztYKbS/hxQXxlrQe1E61FQkjv?=
 =?us-ascii?Q?H/EOkRyELD8uQJvZKBgx8LH/QNTnnFUGr49aFiVPwO/7ASMj+AMtkNbrr/yT?=
 =?us-ascii?Q?lfdJD/W5Dbw1hnFBcQZWQ+kHuaHjhJCV/yOh+VEX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbcda67-fbb5-45a3-1fab-08de388f42ae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 08:28:28.4637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hZuJOeAaGdzi3uwCQRCShEFBW0xxEk6v12GTNaYCu/fNjknP5ZC7fX0kBzWZFb49rRRMg6fctMdG4/0G0qpkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8526
X-Mailman-Approved-At: Thu, 11 Dec 2025 11:05:15 +0100
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

On Wed, Dec 10, 2025 at 10:24:23PM +0100, Julien Stephan wrote:
>Use dm_gpio_is_valid() helper function instead of manually checking the
>gpio.
>
>Signed-off-by: Julien Stephan <jstephan@baylibre.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
