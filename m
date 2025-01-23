Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB75C02181
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 01:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD572807F1;
	Thu, 23 Jan 2025 02:01:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31A2F807F1; Thu, 23 Jan 2025 02:01:48 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2071b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::71b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 715CA80819
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 02:01:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJAA9ocRe7VuCW0zhWm1UuSRDQMrv0gNFMDoyGHZuORG1EXq7CONGh6sephg5D4EOunySp8jVcL/FkySVkcT6nWpX/oRtqq8hfrRr6U3NblP/KUtQGUE4XyXSecLIMYKrDx6KnfhGRBdGCtQm9zWUW3KYXl3Og4pUBggw1XnO8mpV4QGHv1HhTEUFmlkLtMTG27QhVhU7MXffcdYNQeQSExjE/L/lIxQ339WK9FA9XwIN55nWWkzYYxamz1Wnt0WIB+Uda2/5NFRq28hlrC5KV8k/NHBFBGB7nTtSB6cT8caK05KFOH9YTBL6Q+bOAGFVXENAYNdY3LYLlABEHyY6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBbY04AM2fpxDBKDKIk+bYB3siZwaaUSrfxXQT7cJyQ=;
 b=WFmiVu3dbD+DVxkK8KL1dLtkX0O5UMw8ITbJ2/5sK17nH9gtSj/mv+5UIBH0iXvQmM6IrRinkf5FAlueQJ+kZkhFKR/OFfejLFTYExnnhRBbWRajqzcx5Tyy9lmU2KHpmB8CwFWMFIcj1kUIRWOaH3tlHbbtRtZ8vQXF7OWG5gYeB1jmqWu5bibvXM5ndErSYHIohEcmTG0KuSuTiE2m8W6GECg6MBjF3HxmYRhqqZL5ZsGl9fhhBzeRXVbQ6zRFyppdpOIzoPr4troCats/8rpMPk2azg5JvPcBvOJ14a2z79rlhEnJmOZxhlkeHGGaXUKWhvRN+a1GjnAhftzdXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0813.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.8; Thu, 23 Jan
 2025 01:01:32 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Thu, 23 Jan 2025 01:01:32 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v6 8/8] MAINTAINERS: Update Starfive visionfive2 maintain
 files.
Date: Thu, 23 Jan 2025 09:01:12 +0800
Message-Id: <20250123010112.78924-9-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250123010112.78924-1-minda.chen@starfivetech.com>
References: <20250123010112.78924-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0029.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::10) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0813:EE_
X-MS-Office365-Filtering-Correlation-Id: 26622d41-589e-4dce-f2b6-08dd3b497a29
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: tXGUAORSh80y4854Z3e2IHvFBmRmNV620KJruwukFJ7pRb4pSE5BSBksZZcY0hH9VGYgOS80bEIm9DPHZuO/3QfBZBL5PEmw9t1y05BsiXbuU+nGCjbUOaRAqCUuebm6D7l9HooAuleiLdBOKrffcReOqzyt5ze+ZL8TLy1VGmlwF9LiNhKIoL+p5MHb6GUmxV7YV9Z97SX1oNPLImDtuCpT/Db7/y/iGnbKgIDiG+ctrzWBPcMU1mOYgs0fS9OibIoNAEIv0OH33SrF4wcPd4+Yh6XBn9CHI3MUk5x7YvkS+OohOQEpl1jU787tWGd9bfZv3hLMMAc9qmkDm6DT4ecUixiLQkn840K0SHQ0BRXzxWVdVCNK5Bd1XkK6Y7XLqARVAeIs/jw+ncY9eVwY/ysFmXv2eYMv0tFYWNccoNkEwab83wBcA5hepZ+LQIbGbmrjaHzElaImGPZblFUxQ/rkCzKBw5OsyM1LinJHXDdka2fiKdnFZLrCflf3jCXrKmL40VyOdh4h8xQUAxii7NVNf5lMp2Ci6ZU1TyoVqLTSlXUvzMw4S19+JjxG9oLeEGNngOoBeCOHUueMMQPaStzKty7Omo+hVT4LwSP8SkY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B79V4LOTlrylGytuA6TdWoKcUttMPnuC2XsTdjBgrPSEcx4ReI3j9oft8AXY?=
 =?us-ascii?Q?fvKe6wM1SuXDMUjauyWWC1S3G0cJnU7QESKTqxE7qTHxTkOCc7ghOSaZxNNS?=
 =?us-ascii?Q?x6Gh0O/45rf6pXF8xUf69tqM7PdZx0CAM92lnB1pr2ivQlpE971xpbTVUlGA?=
 =?us-ascii?Q?j68U0mEmwCn5TGHFd3kwgfbmmFBF1ZRAWwu4fZvvlYM53dmSXNC+/t4KEpd+?=
 =?us-ascii?Q?d7bYXQ9iCIAcFT1CEQX8N4bcaWWAkeMQ/8Y21Dh/1KeN7vqFcxDlNETycVFK?=
 =?us-ascii?Q?bglm/ltaY2zozudUcRSx97kg8wlWUOtxvO9wzwuU9V9LMh2qN780e6psu+0o?=
 =?us-ascii?Q?n7pNAhOvQlsYR33Z30LyKgZV15fuChOTCC7xEb8tz5Ob8AnWSSyEQrDZR3AP?=
 =?us-ascii?Q?MHdzKhyBO5QulojqUiMFAjd5VpOyidLH5gRVF28pqcAtm7zjQw2AzxH2TBeZ?=
 =?us-ascii?Q?1yA/R5stiRDRdm/e1RteUczKRogCd3gfk9poBOoKhY86QKOl74BPuJSUtmsy?=
 =?us-ascii?Q?eAIQd6m7O1ObFyI2QUX7dzNqgXMC9ct1OzXanpqjlH58vyZh6OU3ijg9Rzi7?=
 =?us-ascii?Q?43C/GTrB5y2o8NcndHGlaJxqIIKE3QniIKAvvxDjY6YS4DjK7jaExE++zWfK?=
 =?us-ascii?Q?h+jDdJ++shq5tZ7421JJFcgObQ+vumVlMOWPk8ljAlxi4LJa4Nq5TXtBhqwP?=
 =?us-ascii?Q?6IZN6e+bAhzVLNFSnFRm0oJ0CKs7bALw0vpbjg+qgc8dfW5rG5qUpW2ErhQh?=
 =?us-ascii?Q?jqDD6QEXxm48YLNcKhpf6qNo4qbpcqBxnnTu6gUB9tF7pbpytJFp0rKx6pVa?=
 =?us-ascii?Q?PDjqp0Ms6369X0mFwPfrGVMtFbRuPZUnKTAFV/NS83lPomhYWoJZhYpi8Vwu?=
 =?us-ascii?Q?n4/lygTxZmXgbjFDbfNVQKALy8A9Er8TrhlIt4ZkJdszZUyDuZDFbraWgYkg?=
 =?us-ascii?Q?64HtH+10wVQiwq12bkG1eAq8GgGHjdfl07wIBSlUjScJK8wF+ifGUzdT1/nn?=
 =?us-ascii?Q?+RI/7eKT6Iqj7HdrCaSrRh/QKO31z9etfEN6ni2BLt5nfIAtOJBG+iMVx2iC?=
 =?us-ascii?Q?oOXAXiGOuJmYHf+NQcQlauIzoz6hNKwruN66Y7NY7cLlBp9QZtbpjeI+rx0S?=
 =?us-ascii?Q?8kScLS5w6A+TLGYOe0XVrZTcSdnEf5HTkaaK7R27stQTbkkZndNkETEC2MWM?=
 =?us-ascii?Q?mcMaarJg1XKi1w1Y8YWRTlXNCJRX7T28WwH/1cBV03s8MPxeOgUQxBK943a8?=
 =?us-ascii?Q?v49Z4wKYBiTRFYM9AOxiSQuBe6RVnNmZKjLn6Ke2t8b3CSChD9WPnvCYSvSZ?=
 =?us-ascii?Q?5uk+Ob0ORDm00Pp2RT3Q3PohXIcF3gUOpNdZTSbZdkBhnqUixw8asJmPVT9y?=
 =?us-ascii?Q?LbzcpAA88CBdFNvGBOOmybI33/lgG4eUELTVqkE78uZp15hfwPaVWMuv3QUc?=
 =?us-ascii?Q?BCMHnMWiNJCJWPy9Wx1L4+X+RO4dtJwE2tD/5Blxn8sojnxJyzZ5MibNxaP6?=
 =?us-ascii?Q?+RIoy9Wxvo61R2t4OS93g+L4PIb54I6tU+BT2Ao/c3W7PR8tK1P5R2fM0Y2I?=
 =?us-ascii?Q?IoePczvwGU1SsHqSblrZ0jAD5/clkGXiPsxyfYVGuH8/hj/O3VoZTcO171gn?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26622d41-589e-4dce-f2b6-08dd3b497a29
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 01:01:32.6322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/TQYO2wJRuB5auEAU/AxnL/VjXqY5c63wbWvnL1vL7eWFRTP/MQvRf7UxfUv2MO0KI+hL6YKLfcc2QqNi+yl6diJ6j86illd4pB6kIUbko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0813
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

Add USB related files to Starfive visionfive2 MAINTAINERS.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 board/starfive/visionfive2/MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/starfive/visionfive2/MAINTAINERS b/board/starfive/visionfive2/MAINTAINERS
index d7f638f9b41..1faf83f581c 100644
--- a/board/starfive/visionfive2/MAINTAINERS
+++ b/board/starfive/visionfive2/MAINTAINERS
@@ -6,3 +6,5 @@ F:	board/starfive/visionfive2/
 F:	include/configs/starfive-visionfive2.h
 F:	configs/starfive_visionfive2_defconfig
 F:	drivers/pci/pcie_starfive_jh7110.c
+F:	drivers/phy/starfive/
+F:	drivers/usb/cdns3/cdns3-starfive.c
-- 
2.17.1

