Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C46AC5ACB3
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 11:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19D9D874DA;
	Fri, 17 Nov 2023 12:38:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="QglaFfWG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAB4086FEF; Fri, 17 Nov 2023 12:38:42 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::724])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 798C7874A1
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 12:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ina49ezH+GBwSQ2lPBcurHcmG46B7AUAN/d1oq4t/rPNcGuNnMy8iVmH1grXuG4If0MSvozp91YN6MZNN5DjjXCjTrHDiyh/BLMZhR/mW8UL5D7jeL0wTWP5Huu8ebpQwYW8NtplQVGZyfRyjY8xQX1mqK6wHx89vnK1Haa7dq9HAO2OdFSLp2FQons4elp7nh0uUwz40xrecuZ8H7NOqvIy0TEmQCKGVFKliV1y3LcX8O/s/xmCKJBtJqQQBYqi//0nm15ExRYBx09ifsHXj1gnXlXuCIu6ZhfzuLa4Img7gEeufAIgKcmtOZz6+QJLhPWxs/1DGXTgymzfuIfS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOpKsrW+ICNeNcBe54IP0ktuQesHn6Px/9wxnX42YAc=;
 b=cohm79wzCGOCFNipS6ac0196l3YCxz7FiiHme8poMPtlNqEyKZyTAWJzCjSmmFifLxoYUxo/asAthAJCj16rTPsbKFHDsXT/M+qF/gWrQj2lNH3XrKRgo4KeX4+T2aOFceAU4naNBtiAWxLcs0Ez5foKenCn7bw2Tmfktda42KezVBpEsspU20Yj3ZIc9A3oe2MuHreQjJXu1c88oxCybLoEYHHP0EozZ32QiXptMEtuejsrh5fAAGmcJJugnjIbvBOE2eFt2une9gKRZ9e2WSeOC70V7LM1r02HaaFWt2NQwTrlHZxHNOx9cwSORM57odPyHYg7S/+mhzTv/jiHXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOpKsrW+ICNeNcBe54IP0ktuQesHn6Px/9wxnX42YAc=;
 b=QglaFfWG009/F8ZJVNZ8YeSJhFkAuEOZKa58H/2dY7W4+hzWirVnUNV6h5C0/ESuVRkLk4f9uuyJESDBaSA/bhzL7+ewuePuZXHWsK5PYQYZ/uqUnrKcFVeiJaVx52bOgLfRAdFLiCA1ewhRIrsPPJjfEDqztAvQNOJ6033hMWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI1PR10MB3664.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 11:38:24 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15%5]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 11:38:24 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 4/6] led: led_gpio: use led_bind_generic() helper
Date: Fri, 17 Nov 2023 12:38:09 +0100
Message-Id: <20231117113811.149329-5-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20231117113811.149329-1-rasmus.villemoes@prevas.dk>
References: <20231117113811.149329-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0000FA93.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:4:0:16) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VI1PR10MB3664:EE_
X-MS-Office365-Filtering-Correlation-Id: be91a5ed-7f4a-475d-d081-08dbe761b4ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZUehenPnHTVNHEV/VJfE8qRqDZ88eTRmwL/OacWYkOLf591VrRogPhfiibuxz3+hPUVf6XStZGyyL0hloC41f2Y5XO1fIQBb5HRAgXBmSRHnTKsh0gzWcyGCPDFUZjApjP34S/x58AVuXAy0/MBaGdqEmnoGs0EMj4lPIEd2LlWGHudtYe0LIga6MsnGx0K0uwpIqQlZXed4gCCQKfdDXmKLOzuJ/RIpu7mYBZOlVMsU73ehjcyUa3zL/PyK5yn5HDVOQTX+yvmpAlZew2BMO9QWvKwXKZZwHXWy4qYSXSahS9IVp583YJtZ8uIdqajVYfwqf5WT0AAeTFe+yWxIK+J568JpfGoHzXuqkxo1x+OHNVTSLXug1bmvHkF+9Y+YMuK3O1FaOwutKDALWEy6QTIsBfGgHZxEPLNIVKihVkE4qC+6FhB3+Wi0DDAw5neNUCkLBKpBqfgJw8cbmWxBv+kmM8m7KMzNJmOtXZx09H4XnHV3xDjXpDhpG+LtIzO4AIYxfUTYg0SeVUkq56bE752d72mrR1V1WTN+9tu8UQWeqv7SeQylDkdILISoaXtc9oNG4qflDE1yxD+lT0rqSqAmFFU6/vi15HphqXJbdyrZnSrtvWHUp+EV5naDDOZkK81BR//c4JqE9346ImF+CA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(39840400004)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38350700005)(52116002)(6506007)(6512007)(36756003)(6486002)(41300700001)(8976002)(8936002)(4744005)(6666004)(107886003)(5660300002)(86362001)(1076003)(8676002)(4326008)(38100700002)(26005)(2906002)(44832011)(83380400001)(66476007)(66556008)(54906003)(66946007)(478600001)(6916009)(316002)(2616005)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MP4LEZK1sZAU6w3Uk7eMe0G5f+w9Px38GLfgeHlfL3Q5cG+A435qDlI48e9S?=
 =?us-ascii?Q?sJFPN6tQ0BKUZi2y3AxT5Mihz8Ol77sLML0xlRbNCpsVBfwGlmAj42QyJPvA?=
 =?us-ascii?Q?pF3oXgYIy4EaMdxpTPNr9wNY5SyGhoEdnXVioYs5YEtuwZK9DgFr3LjM9h+N?=
 =?us-ascii?Q?RUiQeEIjb+4J/KXf9vDScol5mkHArNkyA0KaEgRW8fByz0qRdhvVQqkMV0Ga?=
 =?us-ascii?Q?O4ox5uQy09ablfAOCQykLm0buZcdH2Leyy98MYPqoiV0u7aeSXk1egSgVfzV?=
 =?us-ascii?Q?oyBBpTKEo8y5jl6JBnT4v5Jos6RFvQF9s1XgHX8mTu7WE9KDBsOWPekv4iRO?=
 =?us-ascii?Q?1KEvdHlPxLuhVFKmeEvFTGm0ntfswuQz0U3LKajiCGg/uoZevuJ5mBaiRf+1?=
 =?us-ascii?Q?n3Qh0hG2dvoYIEBXzNl5TuqdfifJGn3HVOI4ZbMDt6MofJF86Rprq7ZYDejm?=
 =?us-ascii?Q?A6XJZV5BNqOjkoKxlw3NP1UwZkGnbGbK+E7pYU2ea1z+1Y32oxNcJ9LLaFQF?=
 =?us-ascii?Q?XfqgIJlk+WtlgPtlIhcrEFbIiZGpDgEv3xxXNCJaOdzE+adblWCJUnixkvWx?=
 =?us-ascii?Q?iJsVAV/X+XxO5JqOHMotC4jUanVo6Cbe1oAdBkTtJbLKeZsIiE7XwXQirqjy?=
 =?us-ascii?Q?JjfH4oiyNfKmYWUVGBiQK6byn03MSq6eSZH4HTonxr4tF8O2ekHbnzky4uL/?=
 =?us-ascii?Q?oWO1US+DEBXyWf9eRAIv3KJn6qJPMQ78Er1b8HgLWebVU5ZtlPEtgmAdAkIF?=
 =?us-ascii?Q?2Mb0/04NJKxeeLEmFxNhxNadJWiU09uUyI2bBmnmWjygc+slzW5oLlIhm3Ax?=
 =?us-ascii?Q?6xayKH0JbNZdIkNKiyBHKRl8yzWO5L13i2MbFeX6ZhgmTAVVOX4dCUuh4/Yo?=
 =?us-ascii?Q?zEbWzPRRMCNa75M4/ox67npZMoaSgoa4oJ1C6n0kKaKHiWGNwQ80pzZlq+fy?=
 =?us-ascii?Q?0z6qoq0CgSWcMkgE5uxjNys7qLoQvHGef3C8NMKOL86m6jt5bBPo1POu/Y6A?=
 =?us-ascii?Q?Bned8dyh3H1V7bfHyomR6ihBeS0FZ68NYii63SUfagLvyqiAfmpz/BcMTAqG?=
 =?us-ascii?Q?b5+kIiYHZQyTvXHKwdd/IOlVo9xOrEhdUd8i1hN0JWjIl3ys0qi1UNf+H7Vf?=
 =?us-ascii?Q?Z+HtebueotrV8TXoZhd3iBsS1NTH6D5aNIdEGd8sl8LUYxQqxuCun9PEM/w0?=
 =?us-ascii?Q?lQm4/+bxZJnvJOZMMVMaqECOEVQFZYJpcbSfnbBJ87WygZ3aNmqn3URblVZB?=
 =?us-ascii?Q?J31zpyD74MPVug9w/W+AEe7ZV5ACiLufXnBeLTT6qYgKM1QRnkeh+b4MMvub?=
 =?us-ascii?Q?3/vm35f608vsx2K5hhzMlDG8kKeAHn4/LweJl4F8y/VXU4jo9RC1nEykm0VC?=
 =?us-ascii?Q?XhjT6fBD+Or4yGw1JI008ka/LthEBRGkp/x8eOMIvscg08luPejM7si+F7Mg?=
 =?us-ascii?Q?dic3YxOH2vMvf9B+B+zc1kWxhBRhpjsb6HikilWi9SjpmlmZtDETRh7lzhMY?=
 =?us-ascii?Q?5cVsAMOest3EFZpmjPlMJFxnVyld34XMW/pzHaCG6MjPe8m+cVxN/Y06BlG/?=
 =?us-ascii?Q?bMaoOJq8jL4S667e8y2dT4m15czXAQ33IStbHukTzEln6Owf8w9B/F3kJzO/?=
 =?us-ascii?Q?aQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: be91a5ed-7f4a-475d-d081-08dbe761b4ff
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 11:38:24.5249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oc/v06O0E9TFX+FrPGv2Flao1IMX+szQ1gMY10SjbpY2lxgCHP4SJbOEmN+8CmlYHI6GjV+HVjzgwLRs+f8Tz1qRvd1+ZRYN2+iwFJWUVbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3664
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

Use the helper led_bind_generic() to reduce code duplication.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/led/led_gpio.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/led/led_gpio.c b/drivers/led/led_gpio.c
index fbed151b5d9..71421de628c 100644
--- a/drivers/led/led_gpio.c
+++ b/drivers/led/led_gpio.c
@@ -11,7 +11,6 @@
 #include <log.h>
 #include <malloc.h>
 #include <asm/gpio.h>
-#include <dm/lists.h>
 
 struct led_gpio_priv {
 	struct gpio_desc gpio;
@@ -80,19 +79,7 @@ static int led_gpio_remove(struct udevice *dev)
 
 static int led_gpio_bind(struct udevice *parent)
 {
-	struct udevice *dev;
-	ofnode node;
-	int ret;
-
-	dev_for_each_subnode(node, parent) {
-		ret = device_bind_driver_to_node(parent, "gpio_led",
-						 ofnode_get_name(node),
-						 node, &dev);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
+	return led_bind_generic(parent, "gpio_led");
 }
 
 static const struct led_ops gpio_led_ops = {
-- 
2.40.1.1.g1c60b9335d

