Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBD2D41C17
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC32F83D77;
	Thu, 11 Dec 2025 11:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MJM6N1dn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9E2383C9F; Thu, 11 Dec 2025 09:37:56 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1750583C7B
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frCqhftkPaE++qCSGnquCvXISJQpnR+TOWEAYv8xDdNr/h4m9HMSQMNJkXyLDg1ipz1bbEk5kOUFvFdzFpFQEPXsYWpJ3PtU2pN0+hL1t3j7TaeAN8czyl+Jo9BGZhFfDNO+HD1SuudgTIEpXG9qm9QZHq4YsDdesOfGoFVvoYx2W3YeHkb7g04zsanj56VuEyxkKtFGKo6/YdJNfJiIHx1zARMhSlh1fjThaG/7LRnTm4adyuHxJp0itY3WQlHfVpUd1hd4TJ6GzFDGjmjjeyCxGnPHwKLM/aETrOMLxyU15KJEJhv+4Y7OXFq0DEyHSunesBk4tTZjpRdwvGH52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBV37BG9i7/PHIqvoS3AdzvutfK9fA3wLF0YM1S+xrI=;
 b=tVvBnhCCdAVl9o2HkxF/7V271bX7GwCztNgP48qV1vvR3Tk4BYMGQQ8h0FHT35CjGPk4cRvSU6TWIN5Tr3kV/K4yHp2UFjgNXh30df1V+8shMUvbfExlI0XaNN8x8PDeKEPDYzF1bZjMsjamsz948CqXCQzGcY/LriWBxC2LF7Z6yQ26St1aqQxugr3Vr426h/c66ViRGOn8Oxpzo743FtKikvkWJEjZ8WW+PzNOFEcF2PGYXJw5fZDZ0ig9zQa6BMiEs5MPDHbGUGJb8i7E2kDkIo3/urQfMwwsikTl1BMqnud1UlTikrqrEJfwi+SK+4bqm53shS3c8FzaXcWEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBV37BG9i7/PHIqvoS3AdzvutfK9fA3wLF0YM1S+xrI=;
 b=MJM6N1dnGArCWFxBCY9ujhx7bm9+XUy2GcVRP9RUahvJCg1puWp+5hd9xgUlNpobHExxaVTdgl/UPZjEVqgtPJ5uaaxYJ/Gm49X2lW7TqwcLgFnpnCS2QRYNYHx8wbNj3YUEIH2GwRi7pKL6bmS1NNgkH04iHNGZFh5eIQH2uLKlSqeQ7PAzyFrdyDORiNGLhxr1K5nR/KGe9EItmA5vFnNEAbonqk9vgiHQAKpCGV9EMv+ZbRYgCdzDy1a9P64Hje9/iSvQDe5X42XFsOzm/8yeZgIKtCI7OUhZjHOvOTOmq3vQvdHAjfhTlD1XZ7JkcOq1csUH8j8gdMrffV27Xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8744.eurprd04.prod.outlook.com (2603:10a6:10:2e2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 08:37:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Thu, 11 Dec 2025
 08:37:53 +0000
Date: Thu, 11 Dec 2025 16:39:04 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Ye Li <ye.li@nxp.com>, Dragan Simic <dsimic@manjaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Subject: Re: [PATCH 0/3] Fix compilation issue on regulator_common file
Message-ID: <aTqDKJajdSbhChr8@shlinux89>
References: <20251210-power-regulator-fix-compilation-v1-0-c58f01e0a5c3@baylibre.com>
 <20251210213826.GK303283@bill-the-cat>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210213826.GK303283@bill-the-cat>
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 028c312e-c70b-46db-9efa-08de3890933f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zXjmNACNWgXKq0pSEz4HeTEPX0RDuArNjBDaMEVGfbAdKBiduVHALpijyinG?=
 =?us-ascii?Q?2iDWt6iKb/dSxXbqL1nx/XiIM4AuUeExVhPl61HVR1Ha9RYIbzH4SNtBZpA0?=
 =?us-ascii?Q?RW3Ba4fkqpo1VHQKQbGQ425oouZUP0wcXbd5mFsvYg9z4wp0EttSZF0amuiy?=
 =?us-ascii?Q?6I+JaEEZFJzUjmJUbXzdgFlr634ng9IyiSTt1fm8lPT3C56MTQb4dGsE6fMm?=
 =?us-ascii?Q?XMjtDh5f2hLfWJDbVepiGdhin54VhapqcmxzejREkOlnOyxbcFMviSawgI2m?=
 =?us-ascii?Q?rPdOOil3HvO5FyDc+QWQcfFPDhIv/kiurRw4BH3BAutOmXpMPPfc0Hn4ZhR6?=
 =?us-ascii?Q?bXUAwCGG7FfMG/6ob6I6glYDDr7WscZirEsYuL0wj2hDBQp4yM5Mia34tRfM?=
 =?us-ascii?Q?jBDzkOo+WsloL4n9iGFv3I3jFwctA5TfhX8+Qx4B5DlATq3hVf2TNNfHNT7N?=
 =?us-ascii?Q?qjRr5RmDPgtNcK+IevhjttIOJA7LnfDw+eAnVkfXj4wzuqc89D5xdoRkfodW?=
 =?us-ascii?Q?RYTUxvHpa40OJm4XJ4xwENteJ7ZcBRWo8eo0BDG+VILgZhB3+dC8qtWwUVL5?=
 =?us-ascii?Q?CzKS7FUwY1N8WtupzCAQXzIG1TMrsY6fkxLct8Sf2nNBXm24Y3jGlx8Pr9VR?=
 =?us-ascii?Q?x8FJujW3QPIywnbbNBtj/KKGxneRFvY9y3AYnz1wAha02UPvo6RPbLrziQ4P?=
 =?us-ascii?Q?6J7y1yb0SE1TW7Ye5laRlMwCBEPXIEzmRicO1kCvdGEX/HJ+N+8EfJ5KiQYV?=
 =?us-ascii?Q?BLafPL4e14sRCFFa9unYllOva/I44OPAq4r9N7fdHMEk+3FDACsXVP4k2KUb?=
 =?us-ascii?Q?zoopYmg8GWEW580x5Hu3HAJVBIUBv32IAUnJ+hsQUn5iM8nbPYSP7pqG5LZI?=
 =?us-ascii?Q?GQqCVN52O7B8xV/ZBtdNbOtkZzGtFaqbDawokpynyV25RZ/x/j2vfgk7YT8Z?=
 =?us-ascii?Q?x88iMJwhUUJuyclgEj5YRKsx2A1f3VnhQcCy3jWBxuJ9yWJo0vL5jUb/NQEw?=
 =?us-ascii?Q?hhTrsOX5oUbLUYs0jZx/o4QERBNG10saXaQmHHjN2qfQGY1ypMKW1MOMFSyN?=
 =?us-ascii?Q?kb+W/64mj7kK4A5Ra2mMJJ1YcoKH5/CXxPE51cJ8ww261jug1AWygRaO1D6z?=
 =?us-ascii?Q?hAy2db8dndiJ2PlsbQ/3wDYxOMT9wycMITj+6OgrolH/9uHde+DDjL5TDYk0?=
 =?us-ascii?Q?ivVUteibmujRfdtj+uCBAmp83p5iuuEqLLILMFCu+1/5MhG7zZwIKuWbwK/w?=
 =?us-ascii?Q?Q7aHf0u/bwjeaNlce0XAkPLyycBmN7o5PAfjQMXGesN2Ky1h9LwtYoS6cpSO?=
 =?us-ascii?Q?5ySdBPSs1Zas1X77rlA6TfFMGvHanJRB2K/o6r2P+2hCyd8FVTeAklxjp8td?=
 =?us-ascii?Q?IXLRliQxuc+dRxdnx4GYu63okJBO7Ta+nvZEx+RdzPw3Buhugj44vCGOLSqk?=
 =?us-ascii?Q?fjSWD70izxIL0tJ4xVAPTu3dDV/IBCi/ZFB5ZNvIw9I5NIm+yX6YoWWKqC8d?=
 =?us-ascii?Q?zQ7NMvbbLUQrphii07SivnZvP+Uc090n9vRq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YE3MVxJTnxJYK574aeXu6dhDkwwdpgMq2why75GK1Jud0FquubPeeExhxYkw?=
 =?us-ascii?Q?x9f+nruC0ZyR/p6TjFVv/995qS9sY8+4YhFXa0nHK8431MKvVI6cs15kTrji?=
 =?us-ascii?Q?RjVYkphS3rJ57PddMkgL0wgGchZF/TgISYsrJquCQNBhlzqVX1OTXFDKI0zq?=
 =?us-ascii?Q?I+PUVsWNawGFipv0juB0QYcbfiIVRon1UtnNWnNHTcTACYrmtn13oGeVRsqo?=
 =?us-ascii?Q?bVjGpFxX/6L7G87V9d2+e0QXalK1HY0X5QKTeYaU9fjaDxHR9vCeXld3+Gik?=
 =?us-ascii?Q?UroRzf3gEw/B5WXGS7QzO/xhhak7fieH82o4CqtkL5WKbyo4nvOXw6Axnr9c?=
 =?us-ascii?Q?vrphW82lAoXOu66cf+8HcZCouK3hQ8XEn4+Cmx7AhcGBATOu6cy4Zvrzr0Tl?=
 =?us-ascii?Q?OyJmWTFDi3xs+aaiFKBcg1MShgWKz+OWF/FEXtYKQhum0p2pd4nEtvNwtLe2?=
 =?us-ascii?Q?3IVpY2UauB74Z09Rx53J+TLl4l2tFU7Lhoh/DUVME8v0u6FKBsFT1QkkHDfx?=
 =?us-ascii?Q?lyjc7DCADyxuE2fbfybzrDL0O+7c9bRloAqEi3RvqZZPiZ516DsalFeh0a5q?=
 =?us-ascii?Q?e7xc+Ji6v/UIghj9KjwoR6cZjVM5Pcrf1pEIqPcLcd1NdTk497e/7mNTt1Oc?=
 =?us-ascii?Q?Bew9QQ/pWzGojQJcz+Hj9BeSBJz38nfaMnJ9cC6WwvbexBMnyCUAkWNIXMAf?=
 =?us-ascii?Q?fydnNOclXcjKKAgSXU/HfciDFlKUNHH4ZvyMX0pDvpUZif9Bun1R/y2TN9wq?=
 =?us-ascii?Q?sgwQQ/I7JTdxc9r7naOi1vfNQ7OyHA0pH10U28kF/ft8jVvKyjsIsNBdkQyY?=
 =?us-ascii?Q?DkBkZG0Uy67+cXvxqi0Wb03Ka8+H8Qg9ILQLRczRkzcR0auKTOsDg81u3hk2?=
 =?us-ascii?Q?GFOjtXVdJLF1DVzlb4atUKGtem31/XiNuyAWIYKBRzTSgSTaz7uXBVj06O4M?=
 =?us-ascii?Q?gCEu8BS8w27MSfGAs3EiA2u723u+prMAPWfbwbfAPS8QaZGfGuUj2ipdbL1Z?=
 =?us-ascii?Q?cNZuAj+g4Ealx99WZqoKU6e64iHagrwWrQYRvFQYFGWv/DfkZ866wCe2mb53?=
 =?us-ascii?Q?FmJbp9pSu5ijWA9ekPlexjyzCck1QUXu8Wm/699sP/6eV0pIhAaUuO52iYQU?=
 =?us-ascii?Q?FNNvDImZgPUeVEraGsHoNWnG3mojKSrCa67O7lTTCBfuI/zT1tfkIuX7o2Ob?=
 =?us-ascii?Q?qQHO00LpXfSaHtbQsZZV9Os8Q5T6S1q2EWHIUyEQxw7eUVGIMvGzOzGbUiAk?=
 =?us-ascii?Q?sfFABqQ1oxx7ZTnDuKb37VIzPOcQomc3LzeaQ0axVwy1wFr8S/iZZ4NHGRwp?=
 =?us-ascii?Q?AkAC7fYx2QkAQY4g9M9CGeorLtclMXXV41MPV8Zjqsv0ShWyYaySTZTPRs4I?=
 =?us-ascii?Q?oqAJolhMfU3Sy6Pl6QA06NzCoKGxxVcbn2H/fcbqRA6b6mDoGpGx4nLTOPdu?=
 =?us-ascii?Q?SfIa6Hy/eCOSh28GOihD/DX5Zwv8ui8qZ3U6kNYyh/e1L9M+TNaPnaa9jWuU?=
 =?us-ascii?Q?nU4A89F74YU1UEvGnZy1bnP8Zj7pFHn71IYoCWGMOn8gV0uuJ1Byk88rWPGm?=
 =?us-ascii?Q?fEEU5kbSa3O7YuaBKbqzk1/d2nmpFd3TKftITS+M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028c312e-c70b-46db-9efa-08de3890933f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 08:37:53.1393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5nzx32JGaIxuhXuBUDx7k9WKQlrYeLiKgptWXerE7M6ryeF2dzr7Ddl3Jp4rTfOcQulnMg05NYvaQe+9PtJKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8744
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

Hi Tom,

On Wed, Dec 10, 2025 at 03:38:26PM -0600, Tom Rini wrote:
>On Wed, Dec 10, 2025 at 10:24:21PM +0100, Julien Stephan wrote:
>
>> Hello,
>> 
>> If CONFIG_DM_GPIO is not enabled, compilation of
>> drivers/power/regulator/regulator_common.c  fails with the following
>> errors:
>
>How did you get this condition exactly? I'm inclined to say DM_REGULATOR
>&& !DM_GPIO shouldn't be allowed today, and I see what looks like a

DM_GPIO is not a must for DM_REGULATOR. Only DM_REGULATOR_GPIO needs DM_GPIO.

>Kconfig bug where SPL_DM_REGULATOR depends on SPL_GPIO and not
>SPL_DM_GPIO.

I think you are saying SPL_DM_REGULATOR_GPIO, not SPL_DM_REGULATOR.

Regards
Peng

>
>-- 
>Tom


