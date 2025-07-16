Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E06EC83F27
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 07:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF316831BB;
	Wed, 16 Jul 2025 09:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="OQCokpoA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2391F8319C; Wed, 16 Jul 2025 09:08:41 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::61c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C38D382E37
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 09:08:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnaLiQgxyJ1mfWsxDkzcwJXh4VfClaRslTotvp/lJ++6SofCAIGAKGA/iJP88he6hOOI8zuK5CutwJy5+c/9042QpSIJ74PcENBFbtFRwTbcOXZg2WqCW2e3MtdXpBDLr2dxFmwKwhuKNWuS2c7vK2s6vqqGolE5vj7YbUlN4mG2liD/xV9k9CHz3xIrevRgLxTCBanDxSLG+0vuFLpS/O0LVw1M4lCpyHRUx9Us756vhL+tzGPda6h1aQcxyf7+ThCds6VJJV5xL7wT/ZHvUcKkJ0hGpl7SGbcIg1FNxQjB3sRU1HffF9dDcWlM3IKZ/qV8qCSZ57A6lF2d6QMsHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pycb0149pvnjEeA3lg7JREnRc/Vexp8Sx5jbURhzWsI=;
 b=VU5BX0cV7aG/Wf1ahRiiSbe8a9+0zZujx9fT1Si6W/eVPA2jFOr716IS2wZw7UuBNAOMiMrdPDGp3UBx5WL7DZTABIUqVVlPAAdQFqqQN5tDFa5m4QyH2l1xH/zY2YoOZUd0yI5Vu+DkFJmpZmqeNPe78vk8a2TptnnFyjLPSSt9aHBS+VdbwbHLBNVkQrFJiW/hPdtd1X23UuwPb3+Ws3jS3AZaSgRQZ9ajExXvoSyXjXZ97SPXFPo+++5MaspJEHBMT59HJGevSGmLtTxWbVVJ92wDuivZevxwVTNi5fWViNBizZ9YuSGcG9YH+SyoySdyhxFeXexLR8deRLKywQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pycb0149pvnjEeA3lg7JREnRc/Vexp8Sx5jbURhzWsI=;
 b=OQCokpoAPEstSYCW8Hv6oMooKGR26FCrUOD6SMDavYp7q8tHakwVHUs6ih8B4fKCJsUBwf1RiDWSv/XEMgkioQ4fqecEDxb8/dgCnaGiDVZbYbgkb5fSisvjcaTXiAPax8FdaBMoC0v2Hl7phcAAG2nHTKZFv/3340a/yN1OAX5ckcXiUW1IDgonJyffrYiHdJBw50m+IrkGCDK1MTZj6wGCudiBYj/RLu9ZHlIczwhoxLwHhYByjnqGZ61vMnZXIN7kIWlFN/CNvZXTksujYaJLKWuYdRT1fp0vWoPQ5tpcjyvXS8olIBVUblmNIlHMemeh0lY/xQynrtRlnSTEOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH7PR03MB7170.namprd03.prod.outlook.com (2603:10b6:510:241::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 07:08:36 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:08:36 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v6 01/12] drivers: i3c: Add new i3c uclass id
Date: Wed, 16 Jul 2025 15:07:59 +0800
Message-Id: <20250716070810.8030-2-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250716070810.8030-1-dinesh.maniyam@altera.com>
References: <20250716070810.8030-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH7PR03MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f997da4-7935-4d95-3a79-08ddc43794ba
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gcpsS6bszeaq4Z/lzqicirQ1TB5MxO6tSxHhqynj7RJ2VhFjtlUEQfT59++W?=
 =?us-ascii?Q?ey9PE9Bid/f92iA7bfkCsJKv3DU+uk0QdceOdE/y+e2B/HbBJbPyxfNRkoOK?=
 =?us-ascii?Q?5sMx4nRUmap91TdRkg2M7+5vNzz0SwvWV7yq3bNWZMlKfbAozApgB39k6Yac?=
 =?us-ascii?Q?UbPLT8Dc5ELljK0poZB0vSBz6IE7V7PZq+MtzTwKI//HJEqftcjVksUCgnNb?=
 =?us-ascii?Q?udKzsvdCkxh8DvjrvkXiu8I5QTTTp59oOaJiADLdQqD8JxX6PMsgCn56IxiU?=
 =?us-ascii?Q?uYtJbdR5N82c6I30EzaXqN2+i+oWVNc1OcjXm+n3Y+GJwplZcn91N2j5Y6gy?=
 =?us-ascii?Q?ISntmIptIZxWrti0FFtvTa8SKN6xwW/oT2VrZ+GTdBuhHN0EdiuD7VPbddNs?=
 =?us-ascii?Q?gezPQKqzL45NHQbKKZjL5vwe9yc0nk0xiX6V7/W6+sU8tXflSGDxwlbBiw+/?=
 =?us-ascii?Q?qm8oBsRGXoXmKfwv9J4No3MxXPozbbWPUDPmOQzo66+o57d2ledAqI1OyPnr?=
 =?us-ascii?Q?VVJs8UdkRl5Dj633wd7VV1O4eHo1zWv043isn922K7rEUa5Zzg/M+MZdb1yx?=
 =?us-ascii?Q?K/ZiQcrCLQ0GjoJbBi5mBF3dTk1+UonMwM+hCaI9OzdeqI695WO7cVNHJsoD?=
 =?us-ascii?Q?SFNNd6W0KBvEw4ojjnDZAbueV9BTlnDNqnd1pWxE/NIZmHRXiVNntsTtpHOD?=
 =?us-ascii?Q?qNH3jABDmz/excOKtsIjRQUdPqAn3kMLswcjKPUnEzXHBJTJwjiDqYEAUh/H?=
 =?us-ascii?Q?iJOy3dYnniBsEE4nWI5+NM8liLPCfa5SCjXscW8Il5gYldodk1C37+dtnwgp?=
 =?us-ascii?Q?gWxH+NLq2BhWaaB8BdkpHrGSs9aL/+jBh+hidDf2OC5DWIi0kFFN5YHVDoto?=
 =?us-ascii?Q?o4NOsMtGL52BZjCDu/GPZNcnX07yT1fw0+3OU9Ko4C2SN6F/UzX6p6BnXuZV?=
 =?us-ascii?Q?DdA3UEa6HqCgiFveErQ+H6daa5bSyNACvlfrMGKE/uYcG/lCjGcUbo6Gvwhf?=
 =?us-ascii?Q?/S9mLNE2u/FlyNBGViu0xtsqsbZW9cEZuqzUM8UCoqUxmTYqLQ6I5zfxkO1l?=
 =?us-ascii?Q?J7CfLIwxuRnQ1IrqCGsRTKbqCJVAr0aUVCuEAyfeSD+0I0AxmUJEf5uC2U81?=
 =?us-ascii?Q?Ec/1XyC1N2KXPYToYQuQ0HEXbhESCiTJuDRj5qTarNVdP3mD14hMAykkC/lc?=
 =?us-ascii?Q?j7o0Ag55hROQEMnfIpNbgEHg5KgVQ8HLLUrBiLrtXO6tIZ+Nc/6K+xezx6OW?=
 =?us-ascii?Q?AhRfiy21lmoKrM0ZDOxqSQvsLILdROB7CYxTZok3QBzI7OAylH/3nCyjqNML?=
 =?us-ascii?Q?SXiTYlA6DLY8BZN1UcVD+O8kI5B3keeSFutBIuIS4gs4zxyg3Hz4GK45nX+U?=
 =?us-ascii?Q?T+3D1yAef4OTO4JZKBHYOplOzHzY2RgAIsvSrHmS6pwxYEeIJo62Bep29JOE?=
 =?us-ascii?Q?c91vsj/10n8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P5O97JKHihJHD4PmBFS268awljJbY7UKfeGX9S55vm2pBTiKa+YC0kWXQ1iF?=
 =?us-ascii?Q?f64L8IE8+wiYSfzLQAYw3rsLEKI3+/MjKDNvBaHfGJ2aLPl3nm9lMTYK2156?=
 =?us-ascii?Q?Yq51AAfM+sgChdL0KqpXNv/z+v8osh+XUq0mDOTz+5E0xc2hasrwTpgKk+He?=
 =?us-ascii?Q?z3csf4DpEZVcgb6wmrFW0ax/JAPAeZ5C9ZFeecJ+XBleCHt8pseAF6Zaj19C?=
 =?us-ascii?Q?GNn7uSiiKyXzByirByfaHhmDDTXD7Y85jOXd6J8WYEHQBqt05E9rgSP+1l42?=
 =?us-ascii?Q?bF80UkeVPGkvP/tu9BHOH53y2sbTaUYPthkxbGxIVyPhfeQIXy9PDwE5cqE7?=
 =?us-ascii?Q?QYznbJTrtBXNsqDnJ9pWhg8mMPZxZIR/glu66u9+cr0x5txMXv7LvfzUW2bq?=
 =?us-ascii?Q?yoeDdni5GvI0c7X+IuKBEmBTHPwhKuixZKM3zvAyuZMajuIqEnt+if/PU+uS?=
 =?us-ascii?Q?uA7UJKd11/BFV1mQUYx5ydDZEBLu7ZYf40/V1+zDS7WLdbLZdcHrYC0lcVEf?=
 =?us-ascii?Q?5SM+/2y3g2zvV5/DRusmdB9KFfX4dMtmo2J1AI3AsybDfZbwNha+LKp8VpZM?=
 =?us-ascii?Q?WXiJTn1+RBJF77lCl1Hl8aIV1BwJQHY7cNB8/vntK7wmHsLUpTlyQ02nR9fG?=
 =?us-ascii?Q?kYPR02NoihXzsGCwjODRh5i9kpI0Y9UfC3RJueONNrKeTr/HbXQnZ4lFbM8a?=
 =?us-ascii?Q?h3jlOcDVbZy0WOLHc2Pjvbc7sykg35keb+SD+Lsw+QRuvHjkuAEVExizJRFC?=
 =?us-ascii?Q?aUh1caQuWRBi9c/sq0YLwuY/LWn8PfP/rawHJj1d8qaYaCuawbTeqdDbfqpm?=
 =?us-ascii?Q?L4Lvz+58YttqWLIk06nDz3LM4Mnh3lxhwZmfasG5hWRqMLxZ9hvlL3SDEiTB?=
 =?us-ascii?Q?C/IcQjr2iTCTkt1Rn3VEoJu4FtoOW73Irzte9ygHjw4LPOIKaJHwzx65DYbP?=
 =?us-ascii?Q?RNE83kKm/yNXDx05WZOWK+ALpf61svWNQIFJxuUFpVS9CSKq2bzbCeRxF5W4?=
 =?us-ascii?Q?k2xRQojh1lnQrduRE1nFa38R1C8A4ZzaTFkNqwfyFZm8EKocpaLFf/IIY+tx?=
 =?us-ascii?Q?aZ1BHVOmVHUGeAaRDjfDhGe9MWak+wX8KNhvBhfr/uwgYjKEg1eAg3dwJk+1?=
 =?us-ascii?Q?aH4ufLZgDWxkfssZeRQTO7fz6bixoINAOZyqdT9/fwlpA441xKi7/UiUh7xK?=
 =?us-ascii?Q?rGOl4xvRYfveN3L+7qZYN0CQYzczDm+Jzxjthzyhi00h1VQevcyDFyMckDVf?=
 =?us-ascii?Q?1t4F2mfBJXERceHpLCgpDE2ZEKX5HQxRHT/yQHjrJPng4I09kR0AI3KbC042?=
 =?us-ascii?Q?ZW0eS5yv+9gdNcUIZyUTWnySCsJrvX37zJGgTeC+AxSHzJ+8weo3XN2/v84Q?=
 =?us-ascii?Q?tMGSBcZwMcks9IE2p8vWbzg0g1TiIoxh0JinfrMM+Kz90bTfNxADHlUPfCNA?=
 =?us-ascii?Q?cnywbAl/zQBluKxTmyhZJ/C9+7vcrI4X8m9xjqR6wWIzzOeB5hcS7U4j3PEc?=
 =?us-ascii?Q?VEbGHzWYuNKOp8aABgetkx4SYKGTsh9sad/E4dbGQujtwCw+k8JwFVw1nXNG?=
 =?us-ascii?Q?nzVczr17/+kY1027D2ZlOz7ZxVk0USVyPqzG2MXlV9m7Ki9npz423FNx0fKq?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f997da4-7935-4d95-3a79-08ddc43794ba
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:08:35.7338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3tFXWTpNa6blcOnv9QaLMUSs9ywlaec5PbsxVH5qTa7j6Yi2jzFuYe52+r0n+9jwb5cdKzH991/LWm7CP22kD/WjRS5PGtO5CaxEvVPdEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7170
X-Mailman-Approved-At: Wed, 16 Jul 2025 09:18:59 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add i3c general uclass id.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 include/dm/uclass-id.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 270088ad94f..1d259b439ff 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -78,6 +78,7 @@ enum uclass_id {
 	UCLASS_I2C_GENERIC,	/* Generic I2C device */
 	UCLASS_I2C_MUX,		/* I2C multiplexer */
 	UCLASS_I2S,		/* I2S bus */
+	UCLASS_I3C,		/* I3C bus */
 	UCLASS_IDE,		/* IDE device */
 	UCLASS_IOMMU,		/* IOMMU */
 	UCLASS_IRQ,		/* Interrupt controller */
-- 
2.35.3

