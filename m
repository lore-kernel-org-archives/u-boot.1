Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF788E6BF3B
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 22:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA06A8457A;
	Fri, 30 Jan 2026 23:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="zRgpMae/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DF968455B; Fri, 30 Jan 2026 23:06:47 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 666EE84568
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 23:06:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5MrmNUmm+UUcue2fpaLJev2w1jRDNotcJOERK3NI/RSUa+5tWuO0AisuQ/4dJY3u6aKHiuowxu9qHY7w2yk6jKo2epWx2O1yWBLWGmsZH4l4223SGB1HOslObLoodaDUDbo5K9oc/9IQfydzZisjYKC0ai4wQYTlONWEUhXRvWG3yjiOFbdm9QXS/o6e6t+25fq+g2AXrG984i10+go8LX2KYhXbD/RY33jf+q4K27zTn2KF2EUaQgrbLgrf4Pa4EMrOXBC/9SUgawXSVqaG2L4MCMzvOMBYBWvbvWucaQvhRMmRszbmRxC02Wp01wt+sZl6vltNMKF7IVT54ny/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhcLKawIvwAtLXGeiEYVf3nwKNLBmUReBEQo4sKBCHg=;
 b=WV+b31YDg0qlkeiKNfd50hfZqOPtgby6D1wIdQ8G0u28qL53dj7NVjBGxXG8tplanbhPTbrHcFlFKAFJhiHDAahFHNR63netzjyM+/E4oZtH2BPuJFvqvWDsbyipkDUMI5lqZOpFnxvCMWFrFRQpQBJDujzd7P5N/reOix0Lj0hNLsOJTAoV2t3EOhvIsUd/Zu9fNDcf0EIan9eHXTpneFyJu+dYe2Viqan+dCv5Xu77tdaKWxTIzuggnQKAojlan/FV8pQlCETLj9Z4MTfAmSde9pejwMHr+aaxUtKuSdPpsc7V9ZER/1wmuq6RCquOAz9wfiAcrX6Fi8XB2Jb2eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhcLKawIvwAtLXGeiEYVf3nwKNLBmUReBEQo4sKBCHg=;
 b=zRgpMae/VIN1r3HDNQPIOQSfjqKr4yLslJUnyPA7wTAiqF4N37Ha+GpxiF7NizsF0IYwVNMeh2tW5PMq4mWRTjWG6xHnoYTzpUdYNg0GELNIIgw3HbGSWDQyJmGSmcar4bnVezWL3vynxgSApZkp86hru1tm5SkR19N2CGU32szkniodIFLeS1KsyZK/Lq83x6pTu1Yhuc/fY9K0w6QDpZgJLii06TnlcnIseVm+oh0m1Yl8mhASW6rOormCcmIlweGNSGl2K3XOw3hDB4y37k/4kZDTWGESwzizXC11UCmL9FjO9oNh3OPyEdBT+DGK10Gc6aYIYCP3kc+9zKU27A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBBPR08MB10697.eurprd08.prod.outlook.com (2603:10a6:10:52a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 22:06:44 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9520.011; Fri, 30 Jan 2026
 22:06:44 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome@forissier.org>, Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>,
 Robert Marko <robert.marko@sartura.hr>, Greg Malysa <malysagreg@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 1/7] net: airoha_eth: fix mdio binding to switch device
Date: Sat, 31 Jan 2026 01:06:23 +0300
Message-ID: <20260130220629.4040550-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130220629.4040550-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260130220629.4040550-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::7) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBBPR08MB10697:EE_
X-MS-Office365-Filtering-Correlation-Id: f138c22e-2e0a-4f28-c22b-08de604bdaa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?47gDgTf5o18LAhH2heXQw063/ok6s7NVef5B6YC1XiWjaiXYGlDfY+U9XsZj?=
 =?us-ascii?Q?d5UNWXqnVMKC3N9JYITwbUnCNnjT79vPRt/77GBN6L4dXGC5HAuzFfA2l4zF?=
 =?us-ascii?Q?AoEF1H5jRS41RWc2uYHOTlQTbUFR0zFCmU/p9mjkvvKekWS7ifJmA0pHLCUR?=
 =?us-ascii?Q?zU2IjhVztfpKO4pclMQ26GiUc2nkNplco0D/CplozP/y/oFlRY5jFJ+X/h/Y?=
 =?us-ascii?Q?jJYxH0UI7gvLsuLySamAhiLPtxXWnYZcCXoNDGdKCAGNLZtPqSriN7BcU1Ea?=
 =?us-ascii?Q?MGjKwC+h2a7ACq8g0wi3h7bSbzyRVdF+Sjt8roqXsttY39ER7unwlXSOjD9m?=
 =?us-ascii?Q?J9Bl/Xe+YAGVPXwLYTeKAkSKhxrKbKgDHFvFm8aqxqvR3T/ox4B7QRe9oWK6?=
 =?us-ascii?Q?lHmMpEjAGeQnSb9iV4MGUmA/nmHpR1+4TjA/w1EOga3Om0d0pg9l9zOKTcrU?=
 =?us-ascii?Q?zoOpwdNXhTzih2HPmE6KKm+BRJR26tzrR3+eZY/xHSbPgWyCR0ane9mFOwNL?=
 =?us-ascii?Q?HkF1cxrIxuEOSmaGOXsJEPp/s4lBtme2neAIA1tB/0FGgoQbutjpOP3EPvxK?=
 =?us-ascii?Q?BkFBoYmhqwH7tc1sXTilmEHJrDJyX2u00JGxYiTarrZM7SS/t0rjy2iK31V/?=
 =?us-ascii?Q?vsxzyrfzIJIuhO9DEgJ/ycUMDX4fVO+i/iMVP4ZMmQ9C0KbNgJ0M5+JqsYij?=
 =?us-ascii?Q?7THQ5oeuUpsL2xivzB/PpYqOMY+NJsxLRzYj0bCH99Q+/e4HJs4AjolgJnCe?=
 =?us-ascii?Q?TyXIKW8bqvdIqmua3KybsVwt/hW0OX2XOctHk5Tbc4z4MQw9Yaca83Cra2YY?=
 =?us-ascii?Q?+NUCUo8xrnHUdiO4ZuN3teehMwEgfNQ/8UUFbMw6qLldpeHfgS/8aJn9pcW3?=
 =?us-ascii?Q?LseLHz5rPYqXRfO7B8SVh+Lj/7XrP3ogyBFBMOzDA/LZ/aIZ/hb1cOtmwXaX?=
 =?us-ascii?Q?3U88r8wNcc7qNhN/iAbk6wDO8xksJWiHi/yCdw+qyLI+51iqqUxyo4++/38y?=
 =?us-ascii?Q?aXmfb98jJDEKVi8p/FGarABBLivCic2s6r371jqzSj4+0FOt/VkSvlIkTDO1?=
 =?us-ascii?Q?WaWT0tnQ0VWFiNPr18tN9rCbiy5khIlD0VRr6zYmdjRY5NVEu5aXP99Q3x8J?=
 =?us-ascii?Q?gKxphD92C3a8jjbZ7anM5WPkZJdAvuj2YoGll9CmUQYCUdEgZBc0lbohA94f?=
 =?us-ascii?Q?LyZk5mNsA+9Dh+r27QZxOku7qCCkza+pxu9TlG+dvi5Ulj/pWYvgtM+bXDLa?=
 =?us-ascii?Q?9JFCrU/zO5g9o26BkfBHQyKSaAl1yKAigDdJ34tjryJ+cou3Ulc0CzTlOqj9?=
 =?us-ascii?Q?glxDsYahiHZQi23KeJ6NNeoyTzN8x1cuwgWtMmUuJOPFxwO5R4eMy9IzUhF4?=
 =?us-ascii?Q?zBgD7dAHmpaJEP8Mo5TFSCZCjkcAXVybBw8jkrOPDqJ8ZMXQpVvyf4/Fvtws?=
 =?us-ascii?Q?gqWB9dPKv74LZXq2+3UQgUefu+TAjzM8d30cXhVXBhxQobnZJhsjt1mCjyUw?=
 =?us-ascii?Q?L2EFSbUhUyCmG1GrWhMt4gIvZvon3Y0038Pon1LLxVvzqHvaEDHIaZYRSyIv?=
 =?us-ascii?Q?WPVtr0NFTH5GPI29r7P7QuearUfmxd7R+7F8Wd5euUERF4waE+e5z19oc7ze?=
 =?us-ascii?Q?3L6iViFE+YcUP4In+Hp+sQ1hon+ufIht+dDmk4ZWYzlA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lbn6d5VPcMxaVftDvdbVGamYencF0rOb/7p0fjivwK1EQuLk2RDyn85alsff?=
 =?us-ascii?Q?Jumq+eUjQ+O2CWxB7XMR+FjjO34VxBTNQ/1+5vq0K/IQxYi4GY45kH6PvjGw?=
 =?us-ascii?Q?TgTKU750jrM2uMcF7uQTQfqOWOdQcz8iB5yGMrhcmrAXhrnvPsO0fHkiOOgd?=
 =?us-ascii?Q?WanZkpnL2fydL86In4t4qafLSqJASnWkJyD9ip4mSkX97K1qo19k9BtG2Kyj?=
 =?us-ascii?Q?Sj7HsTwNJllbBOw0/Qj/ZKS9aPrvoJF12fsIRG4tuZyjTMJuqzv6lHrTtjxe?=
 =?us-ascii?Q?pXaYadyWeaOCPMyxSJraC88ansp5ZeFiLo5kc/rarNO221De2EbgeUJUx0RX?=
 =?us-ascii?Q?LBkgmNm3RMY4IkB8TJbhaeQFIY8ushZ6D5Ki1QE4P3ERE764oBRPnoMrS92E?=
 =?us-ascii?Q?dCZ6g4+LA0tiu821JjmM47HfO+pJaC4uHhRby0hhDO19VaFpSEwZcnrBwBgv?=
 =?us-ascii?Q?Twwe/WNFV7kH03lAMeW8h/ZA00xf3g5rbEFcBnrg9bKur12WxWNSbhi7OVD8?=
 =?us-ascii?Q?eIYStMxgep35FuXP4yVxI3fNhrH1P8YBdaplOw5rHScY5w1HCaqKKP7rmv/q?=
 =?us-ascii?Q?9SI73rLxq/vh8qvsZH1wnG6jZxhMGFMKnon63yy+j/JXRyyzHqFXDQo7s6kA?=
 =?us-ascii?Q?z9qnakU1zWlnnE4LN/XzA0C8vIbRKbOi+KWXTt89/sb5FIqLn+K3OHl0+fkG?=
 =?us-ascii?Q?OO4Ie8Eh/d40lp9AXe2bRH8rvQtH9++VrFPkhh+/uSvk4aQx7H+xh/uWXtFj?=
 =?us-ascii?Q?rcLiBTeaZI16gCWn8ouH0S85Dhf/CAEnmfR2WgNLk3Ee+pRP6xXFOdnGJatk?=
 =?us-ascii?Q?MyGQMrR7kV4kXAu2UCbNx8VEhN9tvcfMsEAaoLKdVKRGqNyDunCTQme6Tea5?=
 =?us-ascii?Q?vTAN5NCE+c1Ket9SiseSSuxpGzJNuhGQAA4IDzaf9pz2DCsZFX2sRlAJ2s+e?=
 =?us-ascii?Q?b6aVWgc16nmLh/zHvIt7hKQc/y1j+TiktwBLmYQb1nNRO1KeQ17KE4T923zm?=
 =?us-ascii?Q?IndeG30fFG8orYTRFWLucLhIuSeCZaFHmkwyKv6QGKU4xEthE/skizHUqoXV?=
 =?us-ascii?Q?Pfg8t4YrNxDmmrL7F4iH9UOmzRbN8XrrPJQg/KBy1S9cbFK1CoEbU2ZHDCpj?=
 =?us-ascii?Q?Vo8WVP8CjB8F5U3CcRfFmGB1eUoPO7HUFYjY08LpbhzrcxN0Mc5pmkyOYo5d?=
 =?us-ascii?Q?nyQKDvz8KxnXKOpHtIkIjXpx6YqjyeZROFEvKzPUW+YxDemLLU63kjrJUQig?=
 =?us-ascii?Q?dkUx/FLR4X4day+xQnsQgFjiA+1KwSY4YovvfMTg8XBfTuX9Hv4ZU3KO9elN?=
 =?us-ascii?Q?8BrV1CZERbxTEtGzFGoGFxHvcUvcIpf75cMsy+llq3Klx7Uep/ADbNQBOef6?=
 =?us-ascii?Q?zBhOoChXv1Q3CPOHD8eZbzXzx64yTX0oKVF+O8eUn9eePqZWHZkWr1XljCjr?=
 =?us-ascii?Q?rhzGHwyTdfEx4o2Hhpvu4/k2o2bkqYlgzp5SAcVWsAMvda2nqX/qt5T1+BtO?=
 =?us-ascii?Q?BVVyMy87NUrYpwNw8KevM54JCtZ+Lp+/5keYtTyGIGVHM1F1vv4FypI7nNGe?=
 =?us-ascii?Q?HTJVc6yXo8HdZRNv5J/wk/dsL5KbcjwrzNQJMJ8Jw/wN21Kgv5rM/H15CBLf?=
 =?us-ascii?Q?CKkm1C1P8PCgvW8TN4gPh79yM8efV4kGxJLdY9QlUsIlgmG0Yng21UZZsw7/?=
 =?us-ascii?Q?yzMb3jCJmFvazIUjgRu+NbOQLewsSh6+fyO7mmNWDlw2BKvXCUpJen2QXHV7?=
 =?us-ascii?Q?ro4ocbtXns63YZEoQjIxEIW8He32nD8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f138c22e-2e0a-4f28-c22b-08de604bdaa6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 22:06:44.2378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bUv3q43bJTDL56FdkbyJgXBTsALL1OTKwW/yBOB549Alixve/EIkEwCFVSa5KLc9gPfBJDuGRQYUnYSfenK7Lp8VhKKyyt9yi+G6mI176E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10697
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

Commit d2145a89bcf6 ("net: airoha: bind MDIO controller on Ethernet load")
refers to non-present CONFIG_MDIO_MT7531 and non-present "mt7531-mdio"
driver. It should use CONFIG_MDIO_MT7531_MMIO and "mt7531-mdio-mmio"
instead.

Fixes: d2145a89bcf6 ("net: airoha: bind MDIO controller on Ethernet load")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/Kconfig      | 2 +-
 drivers/net/airoha_eth.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 4fda1b0c28c..47e2fa192c2 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -127,7 +127,7 @@ config AIROHA_ETH
 	select PHYLIB
 	select DEVRES
 	select DM_RESET
-	select MDIO_MT7531
+	select MDIO_MT7531_MMIO
 	help
 	  This Driver support Airoha Ethernet QDMA Driver
 	  Say Y to enable support for the Airoha Ethernet QDMA.
diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 046b677d78e..5e393db5ffe 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -989,7 +989,7 @@ static int airoha_eth_bind(struct udevice *dev)
 	struct udevice *mdio_dev;
 	int ret = 0;
 
-	if (!CONFIG_IS_ENABLED(MDIO_MT7531))
+	if (!CONFIG_IS_ENABLED(MDIO_MT7531_MMIO))
 		return 0;
 
 	switch_node = ofnode_by_compatible(ofnode_null(),
@@ -1005,7 +1005,7 @@ static int airoha_eth_bind(struct udevice *dev)
 		return 0;
 	}
 
-	ret = device_bind_driver_to_node(dev, "mt7531-mdio", "mdio",
+	ret = device_bind_driver_to_node(dev, "mt7531-mdio-mmio", "mdio",
 					 mdio_node, &mdio_dev);
 	if (ret)
 		debug("Warning: failed to bind mdio controller\n");
-- 
2.51.0

