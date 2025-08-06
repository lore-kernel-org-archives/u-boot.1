Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B1AC87FCA
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 05:27:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1D1084260;
	Wed,  6 Aug 2025 07:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="We/IHEfT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 295BA839AF; Wed,  6 Aug 2025 06:33:43 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 983C28399D
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 06:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCap8rZ9nO7SugRJvk6k4C93e4U95NWd+MSUBpFHrwS4IFVz1YGlaLdK5oXb84GpdvAXmBgrZRjx2HtrXfiRo0eLQQ+TffvNd09wkpn2c2jQs0rcmFs4a8KzjSAsoq8TE2Fy1IkTuafd8QLZz5DNljSYeTlKx1c7eyUO0APlzBkiWHA8hCIjceU/OVs3qP0yD78MlFzmULXJVL3Tynbzo8Q7gPU932ipIIBY/9d8oY3rFxrithGYe2i7NZGS7QWZU8hqstWYKQpN4fk1yej6fsnlk8U6uVk841ZbIO04AVT4Nq4VCSUcz25FJkggWkqkcj4S9Fgym5KcK2yfvXCuJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjOOxjc+7TUzg4b36dUwK8Q4E/AyJ0JGDbJiVscLXRg=;
 b=VZD3RE/wQ8ekSvI8vnMooQmJstWdNUGAOF/tEqqniAw8SP10C2RWU/z+8M0NUjlBtj3j6e3JvXWjCcgnahawfVbuns5FJpiYnlDUfNewf949nnIfSNYk/I7Um9R4xd9yMP+WEhfZM1+aGDVp42kSKlmQ3ACS1A3uP3oZZOIgEV33JWzNEYIt3Nj/JPQjq6cgNrJlnGUd6KASFkZCRM7BG62IXZxe0ELy/HpHwR1cPfPFw0ErNRtswfPnkAQBsjRprKUfgR0Stx+IUld3hXFz0lhh+hUd4OWpVExJd3YKvSz8WZXthEAL32l/YBqKJ9MVxhW3a7NfcGfPboqfb8u5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjOOxjc+7TUzg4b36dUwK8Q4E/AyJ0JGDbJiVscLXRg=;
 b=We/IHEfTjssHREtWlUuHOeypRautNVFlgylkE1xKhs720PJ96+75gZMsi4xLy7UW82SOg0q4yukZBvIq0h6WbCwSp0khACAD76ttY/GabPcacvx+Gg+0Flh10IsekwYF7+ElXkih+XdEarVPqa9ToNJPZxN9bHm9tUA219mNPDB3Dm2kQuJYXKF9N9uuTEqu9aWPlt09JmHmylFm6fjK0VyvYC6g/PoRyoyyvS6x0kZDYW4t3j4Z9oaePLh10EX3eydnyLNLfQ7o+yTWG7DJNW/uQOKSX+xi5ArVaK3JD7zMv4mhW8RWXWB6jx4fuB+LsWJnHAmgrjxkkXYgmp20jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY5PR03MB5202.namprd03.prod.outlook.com (2603:10b6:a03:220::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 04:33:19 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 04:33:19 +0000
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
Subject: [PATCH v8 02/12] drivers: i3c: Add driver for MIPI DWI3C
Date: Wed,  6 Aug 2025 12:32:25 +0800
Message-Id: <20250806043235.2260-4-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250806043235.2260-1-dinesh.maniyam@altera.com>
References: <20250806043235.2260-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:40::32) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BY5PR03MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea5b7dd-cb43-4a56-3f7f-08ddd4a25ddc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ika1dUiF/jtSEjBupr/tj8AM9hWwPv1iIDZMYX3hESiHljEPQ6FNtImrcX4+?=
 =?us-ascii?Q?fEt/iA+RHwCa9bWX4kvajX1ff86ug6smuPa7Zy2iL9ziYHxgOTspe8N0S6gr?=
 =?us-ascii?Q?9MpwT7AbIXOQ25dCDWDESCGmh2ZY1e9E5bMYhj0pWGM5PQNNwOMSbpf8mwxg?=
 =?us-ascii?Q?9FPjou4ofSjL0vT2R2f+rR8lU5TXz8UMcYxw7yWGIuBgI9UJycZuBmLLIP2I?=
 =?us-ascii?Q?swJtUjbi7pkhEviP0ffsbL3fcGvn8vFVU9VkZMbaPU9OX6gDlI0M89Wpy3yr?=
 =?us-ascii?Q?6LEY5lT1CMCPNcM3HRwT1/aaWad0JDsW/lfEQLdTzFtRq7ImKwiUfIXR7200?=
 =?us-ascii?Q?TIqA0WgfBqe4xYEsQujpbowTIv8j8+h1gtRkIwme7I6w28DQ48u3oAb1x6Cj?=
 =?us-ascii?Q?PAvfDC1K01MqyOQBmSLYNWvKOGTNAJXdQBa+FG3UrpaDGcbHuXV7rp6CHXcP?=
 =?us-ascii?Q?QfiGKpBdGoyLuR5lXdUIEpVlScI7xPhhtkW65nmj6+vJNLnkjHLz3BCoVktm?=
 =?us-ascii?Q?I6vJyfAXJfCfTEdVEx0TdeSa+AnoQJQ00PW35hasfEP+LiDUgMhaQ/j6vqvK?=
 =?us-ascii?Q?rvjOEp5olA9dWhBYQbS9x/Pw21ZdMLjjf2A3crTsQezfy1Yn0Kx6yjvDllSk?=
 =?us-ascii?Q?ejYKB/4GbKlCl8TOoc80AQ6xLhxwM4xGhy0Tkj+URZv1KIcLGgPcXYWMAgIc?=
 =?us-ascii?Q?VOWKVtQOoxGj3+s0z0GcOGXyhJlk8NmVGhaiJzFxWmowQCCKq+SdUk+ZUOjC?=
 =?us-ascii?Q?ODNmBBdRp14x7HTcIcJyDae8glzZ6YMc+1VUBSs7d5xovyVKNS7qNfRm4xYd?=
 =?us-ascii?Q?VVOBkZyv1UXNehKUc259w2tq+ZL10XUob6bmLY4TIaSimj2AsmltMS/WgZ+f?=
 =?us-ascii?Q?PybdvUPoCbcCu3vcX1/Xq5nXsaGq3pX50fwEpT1OLtXnDfFExqwm2gTPy6r1?=
 =?us-ascii?Q?baCzRlj5Dn0tvfAX24EcATE9gbCgPS9NF2hubfjqqt7h8d1nluvji77NpGeG?=
 =?us-ascii?Q?yk09KRT/WvF8sBZRN/0ljqaxjcasWTi2m3B3hKFSuymmPC2vtegbfItyYymq?=
 =?us-ascii?Q?jMosHnBI2KjfkmExU42vBQiehBe0qXfGKk6k2WHRxewsOWBib9ggE+Ro4lvN?=
 =?us-ascii?Q?HM4fl57xSHZq56j+UluGr73wmNoQNjKGj94I5cOfYvLZmvfQuo5ygTm1LCoD?=
 =?us-ascii?Q?9UcNUKuOzzrNySLkduhDTfNuLDHtP/CFhPadpRdBTw3ekOzBsBFI+OuqOXO8?=
 =?us-ascii?Q?ixBZ5KmuiKT9JAjjnzLCENZyVTymbGus9dTfCAOl9Cp24BE6b5eeMo2Ovids?=
 =?us-ascii?Q?bXWAueIskMeh/IlvRNJuUjBLwcqBSfyPeOkTDlVnzUVRXO69GufGyDjXZI56?=
 =?us-ascii?Q?RgLpRiaBbTc7nD7CxNWSVfhT8jVos2tBZg01qjGk1HCjQCnMHVHD8h70BDet?=
 =?us-ascii?Q?/o/4Nv4kPIY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KKnJADWQMp3bUADRw4sv25Z+Xu+2ZEE2tByhX1NpKfAVjDyz7T7j+j7eoZNx?=
 =?us-ascii?Q?qK4dJYYIZKxYHe0UGOcjCh7n3Q3DyT1OLMIe49ewZUH9Juy09FMJLgtkYeVb?=
 =?us-ascii?Q?7XCt5a92OikZp8aFZ1t5Ez15THDRdxQxmsRltrYcP5XAAcEnN/oQiQpY4tyT?=
 =?us-ascii?Q?PQphu4WKpW3nBAtj8xBLmCeUsZOKawy4xsGDzqpQv5ltebEA1SNAi1QxnB21?=
 =?us-ascii?Q?yIZS4IaJ8r1R5CD3z38F5EqTZm2stYXBUeX7xILXoU4V5U6g5m0K60XnKiLl?=
 =?us-ascii?Q?G9L9ItFESMWPsBxBpTil4JUuAS0NbaQZ3aC5JHIbefGKJ3plQjYZ4b2R7Xa5?=
 =?us-ascii?Q?WrUuOo5f2ECf2Hel1bXYb/pZBll4V+dE/1b8H7y9YVYbtlnriTlEdYX+j1AV?=
 =?us-ascii?Q?KCRFergr7Bux0kyGBW8yKOzkMwjMC3fZtIhCg4o/arSlxUyvTHgIOa/cJwzi?=
 =?us-ascii?Q?Yrrr8uciWuj6Z/YX9XzZ3wrK+9RXG/IoXkLPAd8Bke8kioobM34h5LhaXef9?=
 =?us-ascii?Q?cxm1dpij9igPOwvawzvUe95kG7Ehh3F737wo9KkaijNVXNbSmnRnIMjserhd?=
 =?us-ascii?Q?KBdvlENmcIEs2bY54qTE29ZOTNXMfn5IAnxlbhNpSlxIhDbaYPUeJ38xJAP1?=
 =?us-ascii?Q?A+gyYAFIYk38lJ7f+AAf7W0OSiCn3V0r9AAWJwK8thnc5zaO232fYcotnCLV?=
 =?us-ascii?Q?lnsLo9GMKBC2HjqUp3U1/jRWTPrBPDNJImURTUAgx2m8NePm2JuOl99hS8By?=
 =?us-ascii?Q?YkqowF0LYFatcaxCwSAi7Ow0ligGENWWqnPXXAAOYUalyDrWItHPxyRFRuQ/?=
 =?us-ascii?Q?E3TtNIQxio9Rn2DGSWGhpfnx9fRNoDS3U9YwBndTxxELUMVBHBzDlMavCadz?=
 =?us-ascii?Q?kDxPO+qAhvzZa3j+0TZSGxpJWo2BCm5RlDShHzP21bMbW6/K3dONNqaDhAae?=
 =?us-ascii?Q?HO2XrjKeNULe27gcFzL2uUtDT9FGENW85liB2eZiS/UdLpFyXuJhPIJJrKXP?=
 =?us-ascii?Q?0ljhYwE58L5R2vVBnmPU4xMDHxboI3rJ1cT4hCL5yV5OjGt1C2pBvH91wUvT?=
 =?us-ascii?Q?lTNlIXS80SMvR4m+xT6PRkWxmxxCgNq0BoBjP3LrAz54B94xoXa37g/79fbu?=
 =?us-ascii?Q?+Yyxn0o9CyH7y25DSW3KCT0JyGx656zr8bpT5McZcvh472CKoKG3jlmw+i1S?=
 =?us-ascii?Q?iblZuBqYnrT4k1ZRGSXrQ/keRHhdawmfj35NazomqQJ9yoKOAvc89CUd57Sm?=
 =?us-ascii?Q?oFsYK6n/Wfbom8lvwCv3YYMOcyXSSZk+v7PCi1fAhIfkka6Jw8T9d9OwrITq?=
 =?us-ascii?Q?Y5hZ1zTGxxLB3mldQpKco8YMOA85m7uEMIQsHoQQLdqJ1Bf5QCL21cRQljdI?=
 =?us-ascii?Q?lf/YB6DhldpRmrzKGGEiKC7FUmdfLu3dhS4ZwrGz9gt30YU43/5LrN3PUnw9?=
 =?us-ascii?Q?8UIL8PwrPUBqpWmLLt2EWYnfXIbPAsrr9kGa20t6EzvNcZ+jCkpXKP5HvIsP?=
 =?us-ascii?Q?tWPpScAOJHBMMhQQQMYW2l1m1H6itA5tzPxGy/MN2xN/SjtoqkAdP1ZFLcAp?=
 =?us-ascii?Q?9P9FdXBPaxTadXGtX4uqZCAfPODNn/LVmxQiNdfKrD5jp3e+iyn2GgW7OG0s?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea5b7dd-cb43-4a56-3f7f-08ddd4a25ddc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 04:33:19.0654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dxrqZXVcSjem0pX12u8cYHHrQLgBjxUJJ6x3oD+OZcPxw171jYQIqxJZMrFZnV4cHPNq6Y55Ts0CiHil7q24OdyWXhr/S8ef4ota+I/GUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5202
X-Mailman-Approved-At: Wed, 06 Aug 2025 07:25:39 +0200
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

Enable driver for Synopsis MIPI DWI3C for the family
device agilex5. This driver is migrated from linux version 6.6.37 LTS

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/i3c/device.c               |  262 ++++
 drivers/i3c/internals.h            |   26 +
 drivers/i3c/master.c               | 2060 ++++++++++++++++++++++++++++
 drivers/i3c/master/dw-i3c-master.c | 1006 ++++++++++++++
 include/dw-i3c.h                   |  248 ++++
 include/linux/i3c/ccc.h            |  385 ++++++
 include/linux/i3c/device.h         |  286 ++++
 include/linux/i3c/master.h         |  697 ++++++++++
 8 files changed, 4970 insertions(+)
 create mode 100644 drivers/i3c/device.c
 create mode 100644 drivers/i3c/internals.h
 create mode 100644 drivers/i3c/master.c
 create mode 100644 drivers/i3c/master/dw-i3c-master.c
 create mode 100644 include/dw-i3c.h
 create mode 100644 include/linux/i3c/ccc.h
 create mode 100644 include/linux/i3c/device.h
 create mode 100644 include/linux/i3c/master.h

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
new file mode 100644
index 00000000000..32c57bccc42
--- /dev/null
+++ b/drivers/i3c/device.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <boris.brezillon@bootlin.com>
+ */
+
+#include <linux/bug.h>
+#include <linux/completion.h>
+#include <dm/device.h>
+
+#include "internals.h"
+
+/* i3c */
+
+#define I3C_MATCH_DCR			0x1
+#define I3C_MATCH_MANUF			0x2
+#define I3C_MATCH_PART			0x4
+#define I3C_MATCH_EXTRA_INFO		0x8
+
+struct i3c_device_id {
+	__u8 match_flags;
+	__u8 dcr;
+	__u16 manuf_id;
+	__u16 part_id;
+	__u16 extra_info;
+
+	const void *data;
+};
+
+/**
+ * i3c_device_do_priv_xfers() - do I3C SDR private transfers directed to a
+ *				specific device
+ *
+ * @dev: device with which the transfers should be done
+ * @xfers: array of transfers
+ * @nxfers: number of transfers
+ *
+ * Initiate one or several private SDR transfers with @dev.
+ *
+ * This function can sleep and thus cannot be called in atomic context.
+ *
+ * Return: 0 in case of success, a negative error core otherwise.
+ */
+int i3c_device_do_priv_xfers(struct i3c_device *dev,
+			     struct i3c_priv_xfer *xfers,
+			     int nxfers)
+{
+	int ret, i;
+
+	if (nxfers < 1)
+		return 0;
+
+	for (i = 0; i < nxfers; i++) {
+		if (!xfers[i].len || !xfers[i].data.in)
+			return -EINVAL;
+	}
+
+	i3c_bus_normaluse_lock(dev->bus);
+	ret = i3c_dev_do_priv_xfers_locked(dev->desc, xfers, nxfers);
+	i3c_bus_normaluse_unlock(dev->bus);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_device_do_priv_xfers);
+
+/**
+ * i3c_device_get_info() - get I3C device information
+ *
+ * @dev: device we want information on
+ * @info: the information object to fill in
+ *
+ * Retrieve I3C dev info.
+ */
+void i3c_device_get_info(struct i3c_device *dev,
+			 struct i3c_device_info *info)
+{
+	if (!info)
+		return;
+
+	i3c_bus_normaluse_lock(dev->bus);
+	if (dev->desc)
+		*info = dev->desc->info;
+	i3c_bus_normaluse_unlock(dev->bus);
+}
+EXPORT_SYMBOL_GPL(i3c_device_get_info);
+
+/**
+ * i3c_device_disable_ibi() - Disable IBIs coming from a specific device
+ * @dev: device on which IBIs should be disabled
+ *
+ * This function disable IBIs coming from a specific device and wait for
+ * all pending IBIs to be processed.
+ *
+ * Return: 0 in case of success, a negative error core otherwise.
+ */
+int i3c_device_disable_ibi(struct i3c_device *dev)
+{
+	int ret = -ENOENT;
+
+	i3c_bus_normaluse_lock(dev->bus);
+	if (dev->desc) {
+		mutex_lock(&dev->desc->ibi_lock);
+		ret = i3c_dev_disable_ibi_locked(dev->desc);
+		mutex_unlock(&dev->desc->ibi_lock);
+	}
+	i3c_bus_normaluse_unlock(dev->bus);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_device_disable_ibi);
+
+/**
+ * i3c_device_enable_ibi() - Enable IBIs coming from a specific device
+ * @dev: device on which IBIs should be enabled
+ *
+ * This function enable IBIs coming from a specific device and wait for
+ * all pending IBIs to be processed. This should be called on a device
+ * where i3c_device_request_ibi() has succeeded.
+ *
+ * Note that IBIs from this device might be received before this function
+ * returns to its caller.
+ *
+ * Return: 0 in case of success, a negative error core otherwise.
+ */
+int i3c_device_enable_ibi(struct i3c_device *dev)
+{
+	int ret = -ENOENT;
+
+	i3c_bus_normaluse_lock(dev->bus);
+	if (dev->desc) {
+		mutex_lock(&dev->desc->ibi_lock);
+		ret = i3c_dev_enable_ibi_locked(dev->desc);
+		mutex_unlock(&dev->desc->ibi_lock);
+	}
+	i3c_bus_normaluse_unlock(dev->bus);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_device_enable_ibi);
+
+/**
+ * i3c_device_request_ibi() - Request an IBI
+ * @dev: device for which we should enable IBIs
+ * @req: setup requested for this IBI
+ *
+ * This function is responsible for pre-allocating all resources needed to
+ * process IBIs coming from @dev. When this function returns, the IBI is not
+ * enabled until i3c_device_enable_ibi() is called.
+ *
+ * Return: 0 in case of success, a negative error core otherwise.
+ */
+int i3c_device_request_ibi(struct i3c_device *dev,
+			   const struct i3c_ibi_setup *req)
+{
+	int ret = -ENOENT;
+
+	if (!req->handler || !req->num_slots)
+		return -EINVAL;
+
+	i3c_bus_normaluse_lock(dev->bus);
+	if (dev->desc) {
+		mutex_lock(&dev->desc->ibi_lock);
+		ret = i3c_dev_request_ibi_locked(dev->desc, req);
+		mutex_unlock(&dev->desc->ibi_lock);
+	}
+	i3c_bus_normaluse_unlock(dev->bus);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_device_request_ibi);
+
+/**
+ * i3c_device_free_ibi() - Free all resources needed for IBI handling
+ * @dev: device on which you want to release IBI resources
+ *
+ * This function is responsible for de-allocating resources previously
+ * allocated by i3c_device_request_ibi(). It should be called after disabling
+ * IBIs with i3c_device_disable_ibi().
+ */
+void i3c_device_free_ibi(struct i3c_device *dev)
+{
+	i3c_bus_normaluse_lock(dev->bus);
+	if (dev->desc) {
+		mutex_lock(&dev->desc->ibi_lock);
+		i3c_dev_free_ibi_locked(dev->desc);
+		mutex_unlock(&dev->desc->ibi_lock);
+	}
+	i3c_bus_normaluse_unlock(dev->bus);
+}
+EXPORT_SYMBOL_GPL(i3c_device_free_ibi);
+
+/**
+ * i3cdev_to_dev() - Returns the device embedded in @i3cdev
+ * @i3cdev: I3C device
+ *
+ * Return: a pointer to a device object.
+ */
+struct udevice *i3cdev_to_dev(struct i3c_device *i3cdev)
+{
+	return &i3cdev->dev;
+}
+EXPORT_SYMBOL_GPL(i3cdev_to_dev);
+
+/**
+ * dev_to_i3cdev() - Returns the I3C device containing @dev
+ * @dev: device object
+ *
+ * Return: a pointer to an I3C device object.
+ */
+struct i3c_device *dev_to_i3cdev(struct udevice *dev)
+{
+	return container_of(dev, struct i3c_device, dev);
+}
+EXPORT_SYMBOL_GPL(dev_to_i3cdev);
+
+/**
+ * i3c_device_match_id() - Returns the i3c_device_id entry matching @i3cdev
+ * @i3cdev: I3C device
+ * @id_table: I3C device match table
+ *
+ * Return: a pointer to an i3c_device_id object or NULL if there's no match.
+ */
+const struct i3c_device_id *
+i3c_device_match_id(struct i3c_device *i3cdev,
+		    const struct i3c_device_id *id_table)
+{
+	struct i3c_device_info devinfo;
+	const struct i3c_device_id *id;
+	u16 manuf, part, ext_info;
+	bool rndpid;
+
+	i3c_device_get_info(i3cdev, &devinfo);
+
+	manuf = I3C_PID_MANUF_ID(devinfo.pid);
+	part = I3C_PID_PART_ID(devinfo.pid);
+	ext_info = I3C_PID_EXTRA_INFO(devinfo.pid);
+	rndpid = I3C_PID_RND_LOWER_32BITS(devinfo.pid);
+
+	for (id = id_table; id->match_flags != 0; id++) {
+		if ((id->match_flags & I3C_MATCH_DCR) &&
+		    id->dcr != devinfo.dcr)
+			continue;
+
+		if ((id->match_flags & I3C_MATCH_MANUF) &&
+		    id->manuf_id != manuf)
+			continue;
+
+		if ((id->match_flags & I3C_MATCH_PART) &&
+		    (rndpid || id->part_id != part))
+			continue;
+
+		if ((id->match_flags & I3C_MATCH_EXTRA_INFO) &&
+		    (rndpid || id->extra_info != ext_info))
+			continue;
+
+		return id;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(i3c_device_match_id);
diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
new file mode 100644
index 00000000000..86b7b44cfca
--- /dev/null
+++ b/drivers/i3c/internals.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <boris.brezillon@bootlin.com>
+ */
+
+#ifndef I3C_INTERNALS_H
+#define I3C_INTERNALS_H
+
+#include <linux/i3c/master.h>
+
+extern struct bus_type i3c_bus_type;
+
+void i3c_bus_normaluse_lock(struct i3c_bus *bus);
+void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
+
+int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
+				 struct i3c_priv_xfer *xfers,
+				 int nxfers);
+int i3c_dev_disable_ibi_locked(struct i3c_dev_desc *dev);
+int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev);
+int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
+			       const struct i3c_ibi_setup *req);
+void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev);
+#endif /* I3C_INTERNAL_H */
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
new file mode 100644
index 00000000000..cf659c040a2
--- /dev/null
+++ b/drivers/i3c/master.c
@@ -0,0 +1,2060 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <boris.brezillon@bootlin.com>
+ */
+
+#include <dm.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <dm/of.h>
+#include <dm/of_access.h>
+#include <linux/bitmap.h>
+#include <linux/bug.h>
+#include <linux/compat.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+
+#include "internals.h"
+
+#define MAX_IDR_ID	64
+
+struct idr_layer {
+	int	used;
+	void	*ptr;
+};
+
+struct idr {
+	struct idr_layer id[MAX_IDR_ID];
+	bool updated;
+};
+
+static int idr_alloc(struct idr *idp, void *ptr, int start, int end, gfp_t gfp_mask)
+{
+	struct idr_layer *idl;
+	int i = 0;
+
+	while (i < MAX_IDR_ID) {
+		idl = &idp->id[i];
+		if (idl->used == 0) {
+			idl->used = 1;
+			idl->ptr = ptr;
+			idp->updated = true;
+			return i;
+		}
+		i++;
+	}
+	return -ENOSPC;
+}
+
+/**
+ * i3c_bus_maintenance_lock - Lock the bus for a maintenance operation
+ * @bus: I3C bus to take the lock on
+ *
+ * This function takes the bus lock so that no other operations can occur on
+ * the bus. This is needed for all kind of bus maintenance operation, like
+ * - enabling/disabling slave events
+ * - re-triggering DAA
+ * - changing the dynamic address of a device
+ * - relinquishing mastership
+ * - ...
+ *
+ * The reason for this kind of locking is that we don't want drivers and core
+ * logic to rely on I3C device information that could be changed behind their
+ * back.
+ */
+static void i3c_bus_maintenance_lock(struct i3c_bus *bus)
+{
+	down_write(&bus->lock);
+}
+
+/**
+ * i3c_bus_maintenance_unlock - Release the bus lock after a maintenance
+ *			      operation
+ * @bus: I3C bus to release the lock on
+ *
+ * Should be called when the bus maintenance operation is done. See
+ * i3c_bus_maintenance_lock() for more details on what these maintenance
+ * operations are.
+ */
+static void i3c_bus_maintenance_unlock(struct i3c_bus *bus)
+{
+	up_write(&bus->lock);
+}
+
+/**
+ * i3c_bus_normaluse_lock - Lock the bus for a normal operation
+ * @bus: I3C bus to take the lock on
+ *
+ * This function takes the bus lock for any operation that is not a maintenance
+ * operation (see i3c_bus_maintenance_lock() for a non-exhaustive list of
+ * maintenance operations). Basically all communications with I3C devices are
+ * normal operations (HDR, SDR transfers or CCC commands that do not change bus
+ * state or I3C dynamic address).
+ *
+ * Note that this lock is not guaranteeing serialization of normal operations.
+ * In other words, transfer requests passed to the I3C master can be submitted
+ * in parallel and I3C master drivers have to use their own locking to make
+ * sure two different communications are not inter-mixed, or access to the
+ * output/input queue is not done while the engine is busy.
+ */
+void i3c_bus_normaluse_lock(struct i3c_bus *bus)
+{
+	down_read(&bus->lock);
+}
+
+/**
+ * i3c_bus_normaluse_unlock - Release the bus lock after a normal operation
+ * @bus: I3C bus to release the lock on
+ *
+ * Should be called when a normal operation is done. See
+ * i3c_bus_normaluse_lock() for more details on what these normal operations
+ * are.
+ */
+void i3c_bus_normaluse_unlock(struct i3c_bus *bus)
+{
+	up_read(&bus->lock);
+}
+
+static struct i3c_master_controller *
+i3c_bus_to_i3c_master(struct i3c_bus *i3cbus)
+{
+	return container_of(i3cbus, struct i3c_master_controller, bus);
+}
+
+static int i3c_device_match(struct udevice *dev, struct driver *drv)
+{
+	struct i3c_device *i3cdev;
+	struct i3c_driver *i3cdrv;
+
+	i3cdev = dev_to_i3cdev(dev);
+	i3cdrv = drv_to_i3cdrv(drv);
+	if (i3c_device_match_id(i3cdev, i3cdrv->id_table))
+		return 1;
+
+	return 0;
+}
+
+static int i3c_device_probe(struct udevice *dev)
+{
+	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
+	struct i3c_driver *driver = drv_to_i3cdrv(dev->driver);
+
+	return driver->probe(i3cdev);
+}
+
+static void i3c_device_remove(struct udevice *dev)
+{
+	struct i3c_device *i3cdev = dev_to_i3cdev(dev);
+	struct i3c_driver *driver = drv_to_i3cdrv(dev->driver);
+
+	if (driver->remove)
+		driver->remove(i3cdev);
+}
+
+struct bus_type {
+	const char		*name;
+	int (*match)(struct udevice *dev, struct driver *drv);
+	int (*probe)(struct udevice *dev);
+	void (*remove)(struct udevice *dev);
+};
+
+struct bus_type i3c_bus_type = {
+	.name = "i3c",
+	.match = i3c_device_match,
+	.probe = i3c_device_probe,
+	.remove = i3c_device_remove,
+};
+
+static enum i3c_addr_slot_status
+i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
+{
+	int status, bitpos = addr * 2;
+
+	if (addr > I2C_MAX_ADDR)
+		return I3C_ADDR_SLOT_RSVD;
+
+	status = bus->addrslots[bitpos / BITS_PER_LONG];
+	status >>= bitpos % BITS_PER_LONG;
+
+	return status & I3C_ADDR_SLOT_STATUS_MASK;
+}
+
+static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
+					 enum i3c_addr_slot_status status)
+{
+	int bitpos = addr * 2;
+	unsigned long *ptr;
+
+	if (addr > I2C_MAX_ADDR)
+		return;
+
+	ptr = bus->addrslots + (bitpos / BITS_PER_LONG);
+	*ptr &= ~((unsigned long)I3C_ADDR_SLOT_STATUS_MASK <<
+						(bitpos % BITS_PER_LONG));
+	*ptr |= (unsigned long)status << (bitpos % BITS_PER_LONG);
+}
+
+static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
+{
+	enum i3c_addr_slot_status status;
+
+	status = i3c_bus_get_addr_slot_status(bus, addr);
+
+	return status == I3C_ADDR_SLOT_FREE;
+}
+
+static int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr)
+{
+	enum i3c_addr_slot_status status;
+	u8 addr;
+
+	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
+		status = i3c_bus_get_addr_slot_status(bus, addr);
+		if (status == I3C_ADDR_SLOT_FREE)
+			return addr;
+	}
+
+	return -ENOMEM;
+}
+
+static void i3c_bus_init_addrslots(struct i3c_bus *bus)
+{
+	int i;
+
+	/* Addresses 0 to 7 are reserved. */
+	for (i = 0; i < 8; i++)
+		i3c_bus_set_addr_slot_status(bus, i, I3C_ADDR_SLOT_RSVD);
+
+	/*
+	 * Reserve broadcast address and all addresses that might collide
+	 * with the broadcast address when facing a single bit error.
+	 */
+	i3c_bus_set_addr_slot_status(bus, I3C_BROADCAST_ADDR,
+				     I3C_ADDR_SLOT_RSVD);
+	for (i = 0; i < 7; i++)
+		i3c_bus_set_addr_slot_status(bus, I3C_BROADCAST_ADDR ^ BIT(i),
+					     I3C_ADDR_SLOT_RSVD);
+}
+
+static int i3c_bus_init(struct i3c_bus *i3cbus)
+{
+	int ret;
+	struct idr i3c_bus_idr = {};
+
+	init_rwsem(&i3cbus->lock);
+	INIT_LIST_HEAD(&i3cbus->devs.i2c);
+	INIT_LIST_HEAD(&i3cbus->devs.i3c);
+	i3c_bus_init_addrslots(i3cbus);
+	i3cbus->mode = I3C_BUS_MODE_PURE;
+
+	mutex_lock(&i3c_core_lock);
+	ret = idr_alloc(&i3c_bus_idr, i3cbus, 0, 0, GFP_KERNEL);
+	mutex_unlock(&i3c_core_lock);
+
+	if (ret < 0)
+		return ret;
+
+	i3cbus->id = ret;
+
+	return 0;
+}
+
+static int i3c_bus_set_mode(struct i3c_bus *i3cbus, enum i3c_bus_mode mode,
+			    unsigned long max_i2c_scl_rate)
+{
+	struct i3c_master_controller *master = i3c_bus_to_i3c_master(i3cbus);
+
+	i3cbus->mode = mode;
+
+	switch (i3cbus->mode) {
+	case I3C_BUS_MODE_PURE:
+		if (!i3cbus->scl_rate.i3c)
+			i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
+		break;
+	case I3C_BUS_MODE_MIXED_FAST:
+	case I3C_BUS_MODE_MIXED_LIMITED:
+		if (!i3cbus->scl_rate.i3c)
+			i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
+		if (!i3cbus->scl_rate.i2c)
+			i3cbus->scl_rate.i2c = max_i2c_scl_rate;
+		break;
+	case I3C_BUS_MODE_MIXED_SLOW:
+		if (!i3cbus->scl_rate.i2c)
+			i3cbus->scl_rate.i2c = max_i2c_scl_rate;
+		if (!i3cbus->scl_rate.i3c ||
+		    i3cbus->scl_rate.i3c > i3cbus->scl_rate.i2c)
+			i3cbus->scl_rate.i3c = i3cbus->scl_rate.i2c;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dev_dbg(master->dev, "i2c-scl = %ld Hz i3c-scl = %ld Hz\n",
+		i3cbus->scl_rate.i2c, i3cbus->scl_rate.i3c);
+
+	/*
+	 * I3C/I2C frequency may have been overridden, check that user-provided
+	 * values are not exceeding max possible frequency.
+	 */
+	if (i3cbus->scl_rate.i3c > I3C_BUS_MAX_I3C_SCL_RATE ||
+	    i3cbus->scl_rate.i2c > I3C_BUS_I2C_FM_PLUS_SCL_RATE)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void i3c_master_free_i2c_dev(struct i2c_dev_desc *dev)
+{
+	kfree(dev);
+}
+
+static struct i2c_dev_desc *
+i3c_master_alloc_i2c_dev(struct i3c_master_controller *master,
+			 const struct i2c_dev_boardinfo *boardinfo)
+{
+	struct i2c_dev_desc *dev;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev->common.master = master;
+	dev->boardinfo = boardinfo;
+	dev->addr = boardinfo->base.addr;
+	dev->lvr = boardinfo->lvr;
+
+	return dev;
+}
+
+static void *i3c_ccc_cmd_dest_init(struct i3c_ccc_cmd_dest *dest, u8 addr,
+				   u16 payloadlen)
+{
+	dest->addr = addr;
+	dest->payload.len = payloadlen;
+	if (payloadlen)
+		dest->payload.data = kzalloc(payloadlen, GFP_KERNEL);
+	else
+		dest->payload.data = NULL;
+
+	return dest->payload.data;
+}
+
+static void i3c_ccc_cmd_dest_cleanup(struct i3c_ccc_cmd_dest *dest)
+{
+	kfree(dest->payload.data);
+}
+
+static void i3c_ccc_cmd_init(struct i3c_ccc_cmd *cmd, bool rnw, u8 id,
+			     struct i3c_ccc_cmd_dest *dests,
+			     unsigned int ndests)
+{
+	cmd->rnw = rnw ? 1 : 0;
+	cmd->id = id;
+	cmd->dests = dests;
+	cmd->ndests = ndests;
+	cmd->err = I3C_ERROR_UNKNOWN;
+}
+
+static int i3c_master_send_ccc_cmd_locked(struct i3c_master_controller *master,
+					  struct i3c_ccc_cmd *cmd)
+{
+	int ret;
+
+	if (!cmd || !master)
+		return -EINVAL;
+
+	if (WARN_ON(master->init_done))
+		return -EINVAL;
+
+	if (!master->ops->send_ccc_cmd)
+		return -EOPNOTSUPP;
+
+	if ((cmd->id & I3C_CCC_DIRECT) && (!cmd->dests || !cmd->ndests))
+		return -EINVAL;
+
+	if (master->ops->supports_ccc_cmd &&
+	    !master->ops->supports_ccc_cmd(master, cmd))
+		return -EOPNOTSUPP;
+
+	ret = master->ops->send_ccc_cmd(master, cmd);
+	if (ret) {
+		if (cmd->err != I3C_ERROR_UNKNOWN)
+			return cmd->err;
+
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * i3c_master_get_free_addr() - get a free address on the bus
+ * @master: I3C master object
+ * @start_addr: where to start searching
+ *
+ * This function must be called with the bus lock held in write mode.
+ *
+ * Return: the first free address starting at @start_addr (included) or -ENOMEM
+ * if there's no more address available.
+ */
+int i3c_master_get_free_addr(struct i3c_master_controller *master,
+			     u8 start_addr)
+{
+	return i3c_bus_get_free_addr(&master->bus, start_addr);
+}
+EXPORT_SYMBOL_GPL(i3c_master_get_free_addr);
+
+static void i3c_master_free_i3c_dev(struct i3c_dev_desc *dev)
+{
+	kfree(dev);
+}
+
+static struct i3c_dev_desc *
+i3c_master_alloc_i3c_dev(struct i3c_master_controller *master,
+			 const struct i3c_device_info *info)
+{
+	struct i3c_dev_desc *dev;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev->common.master = master;
+	dev->info = *info;
+
+	return dev;
+}
+
+static int i3c_master_rstdaa_locked(struct i3c_master_controller *master,
+				    u8 addr)
+{
+	enum i3c_addr_slot_status addrstat;
+	struct i3c_ccc_cmd_dest dest;
+	struct i3c_ccc_cmd cmd;
+	int ret;
+
+	if (!master)
+		return -EINVAL;
+
+	addrstat = i3c_bus_get_addr_slot_status(&master->bus, addr);
+	if (addr != I3C_BROADCAST_ADDR && addrstat != I3C_ADDR_SLOT_I3C_DEV)
+		return -EINVAL;
+
+	i3c_ccc_cmd_dest_init(&dest, addr, 0);
+	i3c_ccc_cmd_init(&cmd, false,
+			 I3C_CCC_RSTDAA(addr == I3C_BROADCAST_ADDR),
+			 &dest, 1);
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+
+	i3c_ccc_cmd_dest_cleanup(&dest);
+
+	return ret;
+}
+
+/**
+ * i3c_master_entdaa_locked() - start a DAA (Dynamic Address Assignment)
+ *				procedure
+ * @master: master used to send frames on the bus
+ *
+ * Send a ENTDAA CCC command to start a DAA procedure.
+ *
+ * Note that this function only sends the ENTDAA CCC command, all the logic
+ * behind dynamic address assignment has to be handled in the I3C master
+ * driver.
+ *
+ * This function must be called with the bus lock held in write mode.
+ *
+ * Return: 0 in case of success, a positive I3C error code if the error is
+ * one of the official Mx error codes, and a negative error code otherwise.
+ */
+int i3c_master_entdaa_locked(struct i3c_master_controller *master)
+{
+	struct i3c_ccc_cmd_dest dest;
+	struct i3c_ccc_cmd cmd;
+	int ret;
+
+	i3c_ccc_cmd_dest_init(&dest, I3C_BROADCAST_ADDR, 0);
+	i3c_ccc_cmd_init(&cmd, false, I3C_CCC_ENTDAA, &dest, 1);
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	i3c_ccc_cmd_dest_cleanup(&dest);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_master_entdaa_locked);
+
+static int i3c_master_enec_disec_locked(struct i3c_master_controller *master,
+					u8 addr, bool enable, u8 evts)
+{
+	struct i3c_ccc_events *events;
+	struct i3c_ccc_cmd_dest dest;
+	struct i3c_ccc_cmd cmd;
+	int ret;
+
+	events = i3c_ccc_cmd_dest_init(&dest, addr, sizeof(*events));
+	if (!events)
+		return -ENOMEM;
+
+	events->events = evts;
+	i3c_ccc_cmd_init(&cmd, false,
+			 enable ?
+			 I3C_CCC_ENEC(addr == I3C_BROADCAST_ADDR) :
+			 I3C_CCC_DISEC(addr == I3C_BROADCAST_ADDR),
+			 &dest, 1);
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	i3c_ccc_cmd_dest_cleanup(&dest);
+
+	return ret;
+}
+
+/**
+ * i3c_master_disec_locked() - send a DISEC CCC command
+ * @master: master used to send frames on the bus
+ * @addr: a valid I3C slave address or %I3C_BROADCAST_ADDR
+ * @evts: events to disable
+ *
+ * Send a DISEC CCC command to disable some or all events coming from a
+ * specific slave, or all devices if @addr is %I3C_BROADCAST_ADDR.
+ *
+ * This function must be called with the bus lock held in write mode.
+ *
+ * Return: 0 in case of success, a positive I3C error code if the error is
+ * one of the official Mx error codes, and a negative error code otherwise.
+ */
+int i3c_master_disec_locked(struct i3c_master_controller *master, u8 addr,
+			    u8 evts)
+{
+	return i3c_master_enec_disec_locked(master, addr, false, evts);
+}
+EXPORT_SYMBOL_GPL(i3c_master_disec_locked);
+
+/**
+ * i3c_master_enec_locked() - send an ENEC CCC command
+ * @master: master used to send frames on the bus
+ * @addr: a valid I3C slave address or %I3C_BROADCAST_ADDR
+ * @evts: events to disable
+ *
+ * Sends an ENEC CCC command to enable some or all events coming from a
+ * specific slave, or all devices if @addr is %I3C_BROADCAST_ADDR.
+ *
+ * This function must be called with the bus lock held in write mode.
+ *
+ * Return: 0 in case of success, a positive I3C error code if the error is
+ * one of the official Mx error codes, and a negative error code otherwise.
+ */
+int i3c_master_enec_locked(struct i3c_master_controller *master, u8 addr,
+			   u8 evts)
+{
+	return i3c_master_enec_disec_locked(master, addr, true, evts);
+}
+EXPORT_SYMBOL_GPL(i3c_master_enec_locked);
+
+static int i3c_master_setda_locked(struct i3c_master_controller *master,
+				   u8 oldaddr, u8 newaddr, bool setdasa)
+{
+	struct i3c_ccc_cmd_dest dest;
+	struct i3c_ccc_setda *setda;
+	struct i3c_ccc_cmd cmd;
+	int ret;
+
+	if (!oldaddr || !newaddr)
+		return -EINVAL;
+
+	setda = i3c_ccc_cmd_dest_init(&dest, oldaddr, sizeof(*setda));
+	if (!setda)
+		return -ENOMEM;
+
+	setda->addr = newaddr << 1;
+	i3c_ccc_cmd_init(&cmd, false,
+			 setdasa ? I3C_CCC_SETDASA : I3C_CCC_SETNEWDA,
+			 &dest, 1);
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	i3c_ccc_cmd_dest_cleanup(&dest);
+
+	return ret;
+}
+
+static int i3c_master_setdasa_locked(struct i3c_master_controller *master,
+				     u8 static_addr, u8 dyn_addr)
+{
+	return i3c_master_setda_locked(master, static_addr, dyn_addr, true);
+}
+
+static int i3c_master_setnewda_locked(struct i3c_master_controller *master,
+				      u8 oldaddr, u8 newaddr)
+{
+	return i3c_master_setda_locked(master, oldaddr, newaddr, false);
+}
+
+static int i3c_master_getmrl_locked(struct i3c_master_controller *master,
+				    struct i3c_device_info *info)
+{
+	struct i3c_ccc_cmd_dest dest;
+	struct i3c_ccc_mrl *mrl;
+	struct i3c_ccc_cmd cmd;
+	int ret;
+
+	mrl = i3c_ccc_cmd_dest_init(&dest, info->dyn_addr, sizeof(*mrl));
+	if (!mrl)
+		return -ENOMEM;
+
+	/*
+	 * When the device does not have IBI payload GETMRL only returns 2
+	 * bytes of data.
+	 */
+	if (!(info->bcr & I3C_BCR_IBI_PAYLOAD))
+		dest.payload.len -= 1;
+
+	i3c_ccc_cmd_init(&cmd, true, I3C_CCC_GETMRL, &dest, 1);
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		goto out;
+
+	switch (dest.payload.len) {
+	case 3:
+		info->max_ibi_len = mrl->ibi_len;
+		fallthrough;
+	case 2:
+		info->max_read_len = be16_to_cpu(mrl->read_len);
+		break;
+	default:
+		ret = -EIO;
+		goto out;
+	}
+
+out:
+	i3c_ccc_cmd_dest_cleanup(&dest);
+
+	return ret;
+}
+
+static int i3c_master_getmwl_locked(struct i3c_master_controller *master,
+				    struct i3c_device_info *info)
+{
+	struct i3c_ccc_cmd_dest dest;
+	struct i3c_ccc_mwl *mwl;
+	struct i3c_ccc_cmd cmd;
+	int ret;
+
+	mwl = i3c_ccc_cmd_dest_init(&dest, info->dyn_addr, sizeof(*mwl));
+	if (!mwl)
+		return -ENOMEM;
+
+	i3c_ccc_cmd_init(&cmd, true, I3C_CCC_GETMWL, &dest, 1);
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		goto out;
+
+	if (dest.payload.len != sizeof(*mwl)) {
+		ret = -EIO;
+		goto out;
+	}
+
+	info->max_write_len = be16_to_cpu(mwl->len);
+
+out:
+	i3c_ccc_cmd_dest_cleanup(&dest);
+
+	return ret;
+}
+
+static int i3c_master_getmxds_locked(struct i3c_master_controller *master,
+				     struct i3c_device_info *info)
+{
+	struct i3c_ccc_getmxds *getmaxds;
+	struct i3c_ccc_cmd_dest dest;
+	struct i3c_ccc_cmd cmd;
+	int ret;
+
+	getmaxds = i3c_ccc_cmd_dest_init(&dest, info->dyn_addr,
+					 sizeof(*getmaxds));
+	if (!getmaxds)
+		return -ENOMEM;
+
+	i3c_ccc_cmd_init(&cmd, true, I3C_CCC_GETMXDS, &dest, 1);
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		goto out;
+
+	if (dest.payload.len != 2 && dest.payload.len != 5) {
+		ret = -EIO;
+		goto out;
+	}
+
+	info->max_read_ds = getmaxds->maxrd;
+	info->max_write_ds = getmaxds->maxwr;
+	if (dest.payload.len == 5)
+		info->max_read_turnaround = getmaxds->maxrdturn[0] |
+					    ((u32)getmaxds->maxrdturn[1] << 8) |
+					    ((u32)getmaxds->maxrdturn[2] << 16);
+
+out:
+	i3c_ccc_cmd_dest_cleanup(&dest);
+
+	return ret;
+}
+
+static int i3c_master_gethdrcap_locked(struct i3c_master_controller *master,
+				       struct i3c_device_info *info)
+{
+	struct i3c_ccc_gethdrcap *gethdrcap;
+	struct i3c_ccc_cmd_dest dest;
+	struct i3c_ccc_cmd cmd;
+	int ret;
+
+	gethdrcap = i3c_ccc_cmd_dest_init(&dest, info->dyn_addr,
+					  sizeof(*gethdrcap));
+	if (!gethdrcap)
+		return -ENOMEM;
+
+	i3c_ccc_cmd_init(&cmd, true, I3C_CCC_GETHDRCAP, &dest, 1);
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		goto out;
+
+	if (dest.payload.len != 1) {
+		ret = -EIO;
+		goto out;
+	}
+
+	info->hdr_cap = gethdrcap->modes;
+
+out:
+	i3c_ccc_cmd_dest_cleanup(&dest);
+
+	return ret;
+}
+
+static int i3c_master_getpid_locked(struct i3c_master_controller *master,
+				    struct i3c_device_info *info)
+{
+	struct i3c_ccc_getpid *getpid;
+	struct i3c_ccc_cmd_dest dest;
+	struct i3c_ccc_cmd cmd;
+	int ret, i;
+
+	getpid = i3c_ccc_cmd_dest_init(&dest, info->dyn_addr, sizeof(*getpid));
+	if (!getpid)
+		return -ENOMEM;
+
+	i3c_ccc_cmd_init(&cmd, true, I3C_CCC_GETPID, &dest, 1);
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		goto out;
+
+	info->pid = 0;
+	for (i = 0; i < sizeof(getpid->pid); i++) {
+		int sft = (sizeof(getpid->pid) - i - 1) * 8;
+
+		info->pid |= (u64)getpid->pid[i] << sft;
+	}
+
+out:
+	i3c_ccc_cmd_dest_cleanup(&dest);
+
+	return ret;
+}
+
+static int i3c_master_getbcr_locked(struct i3c_master_controller *master,
+				    struct i3c_device_info *info)
+{
+	struct i3c_ccc_getbcr *getbcr;
+	struct i3c_ccc_cmd_dest dest;
+	struct i3c_ccc_cmd cmd;
+	int ret;
+
+	getbcr = i3c_ccc_cmd_dest_init(&dest, info->dyn_addr, sizeof(*getbcr));
+	if (!getbcr)
+		return -ENOMEM;
+
+	i3c_ccc_cmd_init(&cmd, true, I3C_CCC_GETBCR, &dest, 1);
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		goto out;
+
+	info->bcr = getbcr->bcr;
+
+out:
+	i3c_ccc_cmd_dest_cleanup(&dest);
+
+	return ret;
+}
+
+static int i3c_master_getdcr_locked(struct i3c_master_controller *master,
+				    struct i3c_device_info *info)
+{
+	struct i3c_ccc_getdcr *getdcr;
+	struct i3c_ccc_cmd_dest dest;
+	struct i3c_ccc_cmd cmd;
+	int ret;
+
+	getdcr = i3c_ccc_cmd_dest_init(&dest, info->dyn_addr, sizeof(*getdcr));
+	if (!getdcr)
+		return -ENOMEM;
+
+	i3c_ccc_cmd_init(&cmd, true, I3C_CCC_GETDCR, &dest, 1);
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		goto out;
+
+	info->dcr = getdcr->dcr;
+
+out:
+	i3c_ccc_cmd_dest_cleanup(&dest);
+
+	return ret;
+}
+
+static int i3c_master_retrieve_dev_info(struct i3c_dev_desc *dev)
+{
+	struct i3c_master_controller *master = i3c_dev_get_master(dev);
+	enum i3c_addr_slot_status slot_status;
+	int ret;
+
+	if (!dev->info.dyn_addr)
+		return -EINVAL;
+
+	slot_status = i3c_bus_get_addr_slot_status(&master->bus,
+						   dev->info.dyn_addr);
+	if (slot_status == I3C_ADDR_SLOT_RSVD ||
+	    slot_status == I3C_ADDR_SLOT_I2C_DEV)
+		return -EINVAL;
+
+	ret = i3c_master_getpid_locked(master, &dev->info);
+	if (ret)
+		return ret;
+
+	ret = i3c_master_getbcr_locked(master, &dev->info);
+	if (ret)
+		return ret;
+
+	ret = i3c_master_getdcr_locked(master, &dev->info);
+	if (ret)
+		return ret;
+
+	if (dev->info.bcr & I3C_BCR_MAX_DATA_SPEED_LIM) {
+		ret = i3c_master_getmxds_locked(master, &dev->info);
+		if (ret)
+			return ret;
+	}
+
+	if (dev->info.bcr & I3C_BCR_IBI_PAYLOAD)
+		dev->info.max_ibi_len = 1;
+
+	i3c_master_getmrl_locked(master, &dev->info);
+	i3c_master_getmwl_locked(master, &dev->info);
+
+	if (dev->info.bcr & I3C_BCR_HDR_CAP) {
+		ret = i3c_master_gethdrcap_locked(master, &dev->info);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void i3c_master_put_i3c_addrs(struct i3c_dev_desc *dev)
+{
+	struct i3c_master_controller *master = i3c_dev_get_master(dev);
+
+	if (dev->info.static_addr)
+		i3c_bus_set_addr_slot_status(&master->bus,
+					     dev->info.static_addr,
+					     I3C_ADDR_SLOT_FREE);
+
+	if (dev->info.dyn_addr)
+		i3c_bus_set_addr_slot_status(&master->bus, dev->info.dyn_addr,
+					     I3C_ADDR_SLOT_FREE);
+
+	if (dev->boardinfo && dev->boardinfo->init_dyn_addr)
+		i3c_bus_set_addr_slot_status(&master->bus, dev->info.dyn_addr,
+					     I3C_ADDR_SLOT_FREE);
+}
+
+static int i3c_master_get_i3c_addrs(struct i3c_dev_desc *dev)
+{
+	struct i3c_master_controller *master = i3c_dev_get_master(dev);
+	enum i3c_addr_slot_status status;
+
+	if (!dev->info.static_addr && !dev->info.dyn_addr)
+		return 0;
+
+	if (dev->info.static_addr) {
+		status = i3c_bus_get_addr_slot_status(&master->bus,
+						      dev->info.static_addr);
+		if (status != I3C_ADDR_SLOT_FREE)
+			return -EBUSY;
+
+		i3c_bus_set_addr_slot_status(&master->bus,
+					     dev->info.static_addr,
+					     I3C_ADDR_SLOT_I3C_DEV);
+	}
+
+	/*
+	 * ->init_dyn_addr should have been reserved before that, so, if we're
+	 * trying to apply a pre-reserved dynamic address, we should not try
+	 * to reserve the address slot a second time.
+	 */
+	if (dev->info.dyn_addr &&
+	    (!dev->boardinfo ||
+	     dev->boardinfo->init_dyn_addr != dev->info.dyn_addr)) {
+		status = i3c_bus_get_addr_slot_status(&master->bus,
+						      dev->info.dyn_addr);
+		if (status != I3C_ADDR_SLOT_FREE)
+			goto err_release_static_addr;
+
+		i3c_bus_set_addr_slot_status(&master->bus, dev->info.dyn_addr,
+					     I3C_ADDR_SLOT_I3C_DEV);
+	}
+
+	return 0;
+
+err_release_static_addr:
+	if (dev->info.static_addr)
+		i3c_bus_set_addr_slot_status(&master->bus,
+					     dev->info.static_addr,
+					     I3C_ADDR_SLOT_FREE);
+
+	return -EBUSY;
+}
+
+static int i3c_master_attach_i3c_dev(struct i3c_master_controller *master,
+				     struct i3c_dev_desc *dev)
+{
+	int ret;
+
+	/*
+	 * We don't attach devices to the controller until they are
+	 * addressable on the bus.
+	 */
+	if (!dev->info.static_addr && !dev->info.dyn_addr)
+		return 0;
+
+	ret = i3c_master_get_i3c_addrs(dev);
+	if (ret)
+		return ret;
+
+	/* Do not attach the master device itself. */
+	if (master->this != dev && master->ops->attach_i3c_dev) {
+		ret = master->ops->attach_i3c_dev(dev);
+		if (ret) {
+			i3c_master_put_i3c_addrs(dev);
+			return ret;
+		}
+	}
+
+	list_add_tail(&dev->common.node, &master->bus.devs.i3c);
+
+	return 0;
+}
+
+static int i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
+				       u8 old_dyn_addr)
+{
+	struct i3c_master_controller *master = i3c_dev_get_master(dev);
+	enum i3c_addr_slot_status status;
+	int ret;
+
+	if (dev->info.dyn_addr != old_dyn_addr &&
+	    (!dev->boardinfo ||
+	     dev->info.dyn_addr != dev->boardinfo->init_dyn_addr)) {
+		status = i3c_bus_get_addr_slot_status(&master->bus,
+						      dev->info.dyn_addr);
+		if (status != I3C_ADDR_SLOT_FREE)
+			return -EBUSY;
+		i3c_bus_set_addr_slot_status(&master->bus,
+					     dev->info.dyn_addr,
+					     I3C_ADDR_SLOT_I3C_DEV);
+	}
+
+	if (master->ops->reattach_i3c_dev) {
+		ret = master->ops->reattach_i3c_dev(dev, old_dyn_addr);
+		if (ret) {
+			i3c_master_put_i3c_addrs(dev);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void i3c_master_detach_i3c_dev(struct i3c_dev_desc *dev)
+{
+	struct i3c_master_controller *master = i3c_dev_get_master(dev);
+
+	/* Do not detach the master device itself. */
+	if (master->this != dev && master->ops->detach_i3c_dev)
+		master->ops->detach_i3c_dev(dev);
+
+	i3c_master_put_i3c_addrs(dev);
+	list_del(&dev->common.node);
+}
+
+static int i3c_master_attach_i2c_dev(struct i3c_master_controller *master,
+				     struct i2c_dev_desc *dev)
+{
+	int ret;
+
+	if (master->ops->attach_i2c_dev) {
+		ret = master->ops->attach_i2c_dev(dev);
+		if (ret)
+			return ret;
+	}
+
+	list_add_tail(&dev->common.node, &master->bus.devs.i2c);
+
+	return 0;
+}
+
+static void i3c_master_detach_i2c_dev(struct i2c_dev_desc *dev)
+{
+	struct i3c_master_controller *master = i2c_dev_get_master(dev);
+
+	list_del(&dev->common.node);
+
+	if (master->ops->detach_i2c_dev)
+		master->ops->detach_i2c_dev(dev);
+}
+
+static int i3c_master_early_i3c_dev_add(struct i3c_master_controller *master,
+					struct i3c_dev_boardinfo *boardinfo)
+{
+	struct i3c_device_info info = {
+		.static_addr = boardinfo->static_addr,
+	};
+	struct i3c_dev_desc *i3cdev;
+	int ret;
+
+	i3cdev = i3c_master_alloc_i3c_dev(master, &info);
+	if (IS_ERR(i3cdev))
+		return -ENOMEM;
+
+	i3cdev->boardinfo = boardinfo;
+
+	ret = i3c_master_attach_i3c_dev(master, i3cdev);
+	if (ret)
+		goto err_free_dev;
+
+	ret = i3c_master_setdasa_locked(master, i3cdev->info.static_addr,
+					i3cdev->boardinfo->init_dyn_addr);
+	if (ret)
+		goto err_detach_dev;
+
+	i3cdev->info.dyn_addr = i3cdev->boardinfo->init_dyn_addr;
+	ret = i3c_master_reattach_i3c_dev(i3cdev, 0);
+	if (ret)
+		goto err_rstdaa;
+
+	ret = i3c_master_retrieve_dev_info(i3cdev);
+	if (ret)
+		goto err_rstdaa;
+
+	return 0;
+
+err_rstdaa:
+	i3c_master_rstdaa_locked(master, i3cdev->boardinfo->init_dyn_addr);
+err_detach_dev:
+	i3c_master_detach_i3c_dev(i3cdev);
+err_free_dev:
+	i3c_master_free_i3c_dev(i3cdev);
+
+	return ret;
+}
+
+static void
+i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
+{
+	struct i3c_dev_desc *desc;
+	int ret;
+
+	if (!master->init_done)
+		return;
+
+	i3c_bus_for_each_i3cdev(&master->bus, desc) {
+		if (desc->dev || !desc->info.dyn_addr || desc == master->this)
+			continue;
+
+		desc->dev = kzalloc(sizeof(*desc->dev), GFP_KERNEL);
+		if (!desc->dev)
+			continue;
+
+		desc->dev->bus = &master->bus;
+		desc->dev->desc = desc;
+		desc->dev->dev.parent = master->dev;
+		dev_set_name(&desc->dev->dev, "%d-%llx", master->bus.id,
+			     desc->info.pid);
+
+		ret = device_register(&desc->dev->dev);
+		if (ret)
+			dev_err(master->dev,
+				"Failed to add I3C device (err = %d)\n", ret);
+	}
+}
+
+/**
+ * i3c_master_do_daa() - do a DAA (Dynamic Address Assignment)
+ * @master: master doing the DAA
+ *
+ * This function is instantiating an I3C device object and adding it to the
+ * I3C device list. All device information are automatically retrieved using
+ * standard CCC commands.
+ *
+ * The I3C device object is returned in case the master wants to attach
+ * private data to it using i3c_dev_set_master_data().
+ *
+ * This function must be called with the bus lock held in write mode.
+ *
+ * Return: a 0 in case of success, an negative error code otherwise.
+ */
+int i3c_master_do_daa(struct i3c_master_controller *master)
+{
+	int ret;
+
+	i3c_bus_maintenance_lock(&master->bus);
+	ret = master->ops->do_daa(master);
+	i3c_bus_maintenance_unlock(&master->bus);
+
+	if (ret)
+		return ret;
+
+	i3c_bus_normaluse_lock(&master->bus);
+	i3c_master_register_new_i3c_devs(master);
+	i3c_bus_normaluse_unlock(&master->bus);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(i3c_master_do_daa);
+
+/**
+ * i3c_master_set_info() - set master device information
+ * @master: master used to send frames on the bus
+ * @info: I3C device information
+ *
+ * Set master device info. This should be called from
+ * &i3c_master_controller_ops->bus_init().
+ *
+ * Not all &i3c_device_info fields are meaningful for a master device.
+ * Here is a list of fields that should be properly filled:
+ *
+ * - &i3c_device_info->dyn_addr
+ * - &i3c_device_info->bcr
+ * - &i3c_device_info->dcr
+ * - &i3c_device_info->pid
+ * - &i3c_device_info->hdr_cap if %I3C_BCR_HDR_CAP bit is set in
+ *   &i3c_device_info->bcr
+ *
+ * This function must be called with the bus lock held in maintenance mode.
+ *
+ * Return: 0 if @info contains valid information (not every piece of
+ * information can be checked, but we can at least make sure @info->dyn_addr
+ * and @info->bcr are correct), -EINVAL otherwise.
+ */
+int i3c_master_set_info(struct i3c_master_controller *master,
+			const struct i3c_device_info *info)
+{
+	struct i3c_dev_desc *i3cdev;
+	int ret;
+
+	if (!i3c_bus_dev_addr_is_avail(&master->bus, info->dyn_addr))
+		return -EINVAL;
+
+	if (I3C_BCR_DEVICE_ROLE(info->bcr) == I3C_BCR_I3C_MASTER &&
+	    master->secondary)
+		return -EINVAL;
+
+	if (master->this)
+		return -EINVAL;
+
+	i3cdev = i3c_master_alloc_i3c_dev(master, info);
+	if (IS_ERR(i3cdev))
+		return PTR_ERR(i3cdev);
+
+	master->this = i3cdev;
+	master->bus.cur_master = master->this;
+
+	ret = i3c_master_attach_i3c_dev(master, i3cdev);
+	if (ret)
+		goto err_free_dev;
+
+	return 0;
+
+err_free_dev:
+	i3c_master_free_i3c_dev(i3cdev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_master_set_info);
+
+static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
+{
+	struct i3c_dev_desc *i3cdev, *i3ctmp;
+	struct i2c_dev_desc *i2cdev, *i2ctmp;
+
+	list_for_each_entry_safe(i3cdev, i3ctmp, &master->bus.devs.i3c,
+				 common.node) {
+		i3c_master_detach_i3c_dev(i3cdev);
+
+		if (i3cdev->boardinfo && i3cdev->boardinfo->init_dyn_addr)
+			i3c_bus_set_addr_slot_status(&master->bus,
+						     i3cdev->boardinfo->init_dyn_addr,
+						     I3C_ADDR_SLOT_FREE);
+
+		i3c_master_free_i3c_dev(i3cdev);
+	}
+
+	list_for_each_entry_safe(i2cdev, i2ctmp, &master->bus.devs.i2c,
+				 common.node) {
+		i3c_master_detach_i2c_dev(i2cdev);
+		i3c_bus_set_addr_slot_status(&master->bus,
+					     i2cdev->addr,
+					     I3C_ADDR_SLOT_FREE);
+		i3c_master_free_i2c_dev(i2cdev);
+	}
+}
+
+/**
+ * i3c_master_bus_init() - initialize an I3C bus
+ * @master: main master initializing the bus
+ *
+ * This function is following all initialisation steps described in the I3C
+ * specification:
+ *
+ * 1. Attach I2C devs to the master so that the master can fill its internal
+ *    device table appropriately
+ *
+ * 2. Call &i3c_master_controller_ops->bus_init() method to initialize
+ *    the master controller. That's usually where the bus mode is selected
+ *    (pure bus or mixed fast/slow bus)
+ *
+ * 3. Instruct all devices on the bus to drop their dynamic address. This is
+ *    particularly important when the bus was previously configured by someone
+ *    else (for example the bootloader)
+ *
+ * 4. Disable all slave events.
+ *
+ * 5. Reserve address slots for I3C devices with init_dyn_addr. And if devices
+ *    also have static_addr, try to pre-assign dynamic addresses requested by
+ *    the FW with SETDASA and attach corresponding statically defined I3C
+ *    devices to the master.
+ *
+ * 6. Do a DAA (Dynamic Address Assignment) to assign dynamic addresses to all
+ *    remaining I3C devices
+ *
+ * Once this is done, all I3C and I2C devices should be usable.
+ *
+ * Return: a 0 in case of success, an negative error code otherwise.
+ */
+static int i3c_master_bus_init(struct i3c_master_controller *master)
+{
+	enum i3c_addr_slot_status status;
+	struct i2c_dev_boardinfo *i2cboardinfo;
+	struct i3c_dev_boardinfo *i3cboardinfo;
+	struct i2c_dev_desc *i2cdev;
+	int ret;
+
+	/*
+	 * First attach all devices with static definitions provided by the
+	 * FW.
+	 */
+	list_for_each_entry(i2cboardinfo, &master->boardinfo.i2c, node) {
+		status = i3c_bus_get_addr_slot_status(&master->bus,
+						      i2cboardinfo->base.addr);
+		if (status != I3C_ADDR_SLOT_FREE) {
+			ret = -EBUSY;
+			goto err_detach_devs;
+		}
+
+		i3c_bus_set_addr_slot_status(&master->bus,
+					     i2cboardinfo->base.addr,
+					     I3C_ADDR_SLOT_I2C_DEV);
+
+		i2cdev = i3c_master_alloc_i2c_dev(master, i2cboardinfo);
+		if (IS_ERR(i2cdev)) {
+			ret = PTR_ERR(i2cdev);
+			goto err_detach_devs;
+		}
+
+		ret = i3c_master_attach_i2c_dev(master, i2cdev);
+		if (ret) {
+			i3c_master_free_i2c_dev(i2cdev);
+			goto err_detach_devs;
+		}
+	}
+
+	/*
+	 * Now execute the controller specific ->bus_init() routine, which
+	 * might configure its internal logic to match the bus limitations.
+	 */
+	ret = master->ops->bus_init(master);
+	if (ret)
+		goto err_detach_devs;
+
+	/*
+	 * The master device should have been instantiated in ->bus_init(),
+	 * complain if this was not the case.
+	 */
+	if (!master->this) {
+		dev_err(master->dev,
+			"master_set_info() was not called in ->bus_init()\n");
+		ret = -EINVAL;
+		goto err_bus_cleanup;
+	}
+
+	/*
+	 * Reset all dynamic address that may have been assigned before
+	 * (assigned by the bootloader for example).
+	 */
+	ret = i3c_master_rstdaa_locked(master, I3C_BROADCAST_ADDR);
+	if (ret && ret != I3C_ERROR_M2)
+		goto err_bus_cleanup;
+
+	/* Disable all slave events before starting DAA. */
+	ret = i3c_master_disec_locked(master, I3C_BROADCAST_ADDR,
+				      I3C_CCC_EVENT_SIR | I3C_CCC_EVENT_MR |
+				      I3C_CCC_EVENT_HJ);
+	if (ret && ret != I3C_ERROR_M2)
+		goto err_bus_cleanup;
+
+	/*
+	 * Reserve init_dyn_addr first, and then try to pre-assign dynamic
+	 * address and retrieve device information if needed.
+	 * In case pre-assign dynamic address fails, setting dynamic address to
+	 * the requested init_dyn_addr is retried after DAA is done in
+	 * i3c_master_add_i3c_dev_locked().
+	 */
+	list_for_each_entry(i3cboardinfo, &master->boardinfo.i3c, node) {
+		/*
+		 * We don't reserve a dynamic address for devices that
+		 * don't explicitly request one.
+		 */
+		if (!i3cboardinfo->init_dyn_addr)
+			continue;
+
+		ret = i3c_bus_get_addr_slot_status(&master->bus,
+						   i3cboardinfo->init_dyn_addr);
+		if (ret != I3C_ADDR_SLOT_FREE) {
+			ret = -EBUSY;
+			goto err_rstdaa;
+		}
+
+		i3c_bus_set_addr_slot_status(&master->bus,
+					     i3cboardinfo->init_dyn_addr,
+					     I3C_ADDR_SLOT_I3C_DEV);
+
+		/*
+		 * Only try to create/attach devices that have a static
+		 * address. Other devices will be created/attached when
+		 * DAA happens, and the requested dynamic address will
+		 * be set using SETNEWDA once those devices become
+		 * addressable.
+		 */
+
+		if (i3cboardinfo->static_addr)
+			i3c_master_early_i3c_dev_add(master, i3cboardinfo);
+	}
+
+	ret = i3c_master_do_daa(master);
+	if (ret)
+		goto err_rstdaa;
+
+	return 0;
+
+err_rstdaa:
+	i3c_master_rstdaa_locked(master, I3C_BROADCAST_ADDR);
+
+err_bus_cleanup:
+	if (master->ops->bus_cleanup)
+		master->ops->bus_cleanup(master);
+
+err_detach_devs:
+	i3c_master_detach_free_devs(master);
+
+	return ret;
+}
+
+static void i3c_master_attach_boardinfo(struct i3c_dev_desc *i3cdev)
+{
+	struct i3c_master_controller *master = i3cdev->common.master;
+	struct i3c_dev_boardinfo *i3cboardinfo;
+
+	list_for_each_entry(i3cboardinfo, &master->boardinfo.i3c, node) {
+		if (i3cdev->info.pid != i3cboardinfo->pid)
+			continue;
+
+		i3cdev->boardinfo = i3cboardinfo;
+		i3cdev->info.static_addr = i3cboardinfo->static_addr;
+		return;
+	}
+}
+
+static struct i3c_dev_desc *
+i3c_master_search_i3c_dev_duplicate(struct i3c_dev_desc *refdev)
+{
+	struct i3c_master_controller *master = i3c_dev_get_master(refdev);
+	struct i3c_dev_desc *i3cdev;
+
+	i3c_bus_for_each_i3cdev(&master->bus, i3cdev) {
+		if (i3cdev != refdev && i3cdev->info.pid == refdev->info.pid)
+			return i3cdev;
+	}
+
+	return NULL;
+}
+
+/**
+ * i3c_master_add_i3c_dev_locked() - add an I3C slave to the bus
+ * @master: master used to send frames on the bus
+ * @addr: I3C slave dynamic address assigned to the device
+ *
+ * This function is instantiating an I3C device object and adding it to the
+ * I3C device list. All device information are automatically retrieved using
+ * standard CCC commands.
+ *
+ * The I3C device object is returned in case the master wants to attach
+ * private data to it using i3c_dev_set_master_data().
+ *
+ * This function must be called with the bus lock held in write mode.
+ *
+ * Return: a 0 in case of success, an negative error code otherwise.
+ */
+int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
+				  u8 addr)
+{
+	struct i3c_device_info info = { .dyn_addr = addr };
+	struct i3c_dev_desc *newdev, *olddev;
+	u8 old_dyn_addr = addr, expected_dyn_addr;
+	struct i3c_ibi_setup ibireq = { };
+	bool enable_ibi = false;
+	int ret;
+
+	if (!master)
+		return -EINVAL;
+
+	newdev = i3c_master_alloc_i3c_dev(master, &info);
+	if (IS_ERR(newdev))
+		return PTR_ERR(newdev);
+
+	master->this = newdev;
+	ret = i3c_master_attach_i3c_dev(master, newdev);
+	if (ret)
+		goto err_free_dev;
+
+	ret = i3c_master_retrieve_dev_info(newdev);
+	if (ret)
+		goto err_detach_dev;
+
+	i3c_master_attach_boardinfo(newdev);
+
+	olddev = i3c_master_search_i3c_dev_duplicate(newdev);
+	if (olddev) {
+		newdev->dev = olddev->dev;
+		if (newdev->dev)
+			newdev->dev->desc = newdev;
+
+		/*
+		 * We need to restore the IBI state too, so let's save the
+		 * IBI information and try to restore them after olddev has
+		 * been detached+released and its IBI has been stopped and
+		 * the associated resources have been freed.
+		 */
+		mutex_lock(&olddev->ibi_lock);
+		if (olddev->ibi) {
+			ibireq.handler = olddev->ibi->handler;
+			ibireq.max_payload_len = olddev->ibi->max_payload_len;
+			ibireq.num_slots = olddev->ibi->num_slots;
+
+			if (olddev->ibi->enabled) {
+				enable_ibi = true;
+				i3c_dev_disable_ibi_locked(olddev);
+			}
+
+			i3c_dev_free_ibi_locked(olddev);
+		}
+		mutex_unlock(&olddev->ibi_lock);
+
+		old_dyn_addr = olddev->info.dyn_addr;
+
+		i3c_master_detach_i3c_dev(olddev);
+		i3c_master_free_i3c_dev(olddev);
+	}
+
+	ret = i3c_master_reattach_i3c_dev(newdev, old_dyn_addr);
+	if (ret)
+		goto err_detach_dev;
+
+	/*
+	 * Depending on our previous state, the expected dynamic address might
+	 * differ:
+	 * - if the device already had a dynamic address assigned, let's try to
+	 *   re-apply this one
+	 * - if the device did not have a dynamic address and the firmware
+	 *   requested a specific address, pick this one
+	 * - in any other case, keep the address automatically assigned by the
+	 *   master
+	 */
+	if (old_dyn_addr && old_dyn_addr != newdev->info.dyn_addr)
+		expected_dyn_addr = old_dyn_addr;
+	else if (newdev->boardinfo && newdev->boardinfo->init_dyn_addr)
+		expected_dyn_addr = newdev->boardinfo->init_dyn_addr;
+	else
+		expected_dyn_addr = newdev->info.dyn_addr;
+
+	if (newdev->info.dyn_addr != expected_dyn_addr) {
+		/*
+		 * Try to apply the expected dynamic address. If it fails, keep
+		 * the address assigned by the master.
+		 */
+		ret = i3c_master_setnewda_locked(master,
+						 newdev->info.dyn_addr,
+						 expected_dyn_addr);
+		if (!ret) {
+			old_dyn_addr = newdev->info.dyn_addr;
+			newdev->info.dyn_addr = expected_dyn_addr;
+			i3c_master_reattach_i3c_dev(newdev, old_dyn_addr);
+		} else {
+			dev_err(master->dev,
+				"Failed to assign reserved/old address to device %d%llx",
+				master->bus.id, newdev->info.pid);
+		}
+	}
+
+	/*
+	 * Now is time to try to restore the IBI setup. If we're lucky,
+	 * everything works as before, otherwise, all we can do is complain.
+	 * FIXME: maybe we should add callback to inform the driver that it
+	 * should request the IBI again instead of trying to hide that from
+	 * him.
+	 */
+	if (ibireq.handler) {
+		mutex_lock(&newdev->ibi_lock);
+		ret = i3c_dev_request_ibi_locked(newdev, &ibireq);
+		if (ret) {
+			dev_err(master->dev,
+				"Failed to request IBI on device %d-%llx",
+				master->bus.id, newdev->info.pid);
+		} else if (enable_ibi) {
+			ret = i3c_dev_enable_ibi_locked(newdev);
+			if (ret)
+				dev_err(master->dev,
+					"Failed to re-enable IBI on device %d-%llx",
+					master->bus.id, newdev->info.pid);
+		}
+		mutex_unlock(&newdev->ibi_lock);
+	}
+
+	return 0;
+
+err_detach_dev:
+	if (newdev->dev && newdev->dev->desc)
+		newdev->dev->desc = NULL;
+
+	i3c_master_detach_i3c_dev(newdev);
+
+err_free_dev:
+	i3c_master_free_i3c_dev(newdev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_master_add_i3c_dev_locked);
+
+#define OF_I3C_REG1_IS_I2C_DEV			BIT(31)
+
+static int
+of_i3c_master_add_i3c_boardinfo(struct i3c_master_controller *master,
+				struct device_node *node, u32 *reg)
+{
+	struct i3c_dev_boardinfo *boardinfo;
+	struct udevice *dev = master->dev;
+	enum i3c_addr_slot_status addrstatus;
+	u32 init_dyn_addr = 0;
+
+	boardinfo = devm_kzalloc(dev, sizeof(*boardinfo), GFP_KERNEL);
+	if (!boardinfo)
+		return -ENOMEM;
+
+	if (reg[0]) {
+		if (reg[0] > I3C_MAX_ADDR)
+			return -EINVAL;
+
+		addrstatus = i3c_bus_get_addr_slot_status(&master->bus,
+							  reg[0]);
+		if (addrstatus != I3C_ADDR_SLOT_FREE)
+			return -EINVAL;
+	}
+
+	boardinfo->static_addr = reg[0];
+
+	if (!dev_read_u32(dev, "assigned-address", &init_dyn_addr)) {
+		if (init_dyn_addr > I3C_MAX_ADDR)
+			return -EINVAL;
+
+		addrstatus = i3c_bus_get_addr_slot_status(&master->bus,
+							  init_dyn_addr);
+		if (addrstatus != I3C_ADDR_SLOT_FREE)
+			return -EINVAL;
+	}
+
+	boardinfo->pid = ((u64)reg[1] << 32) | reg[2];
+
+	if ((boardinfo->pid & GENMASK_ULL(63, 48)) ||
+	    I3C_PID_RND_LOWER_32BITS(boardinfo->pid))
+		return -EINVAL;
+
+	boardinfo->init_dyn_addr = init_dyn_addr;
+	boardinfo->of_node = node;
+	list_add_tail(&boardinfo->node, &master->boardinfo.i3c);
+
+	return 0;
+}
+
+static int of_i3c_master_add_dev(struct i3c_master_controller *master,
+				 struct device_node *node)
+{
+	u32 reg[3];
+	int ret;
+
+	if (!master || !node)
+		return -EINVAL;
+
+	ret = dev_read_u32_array(master->dev, "reg", reg, ARRAY_SIZE(reg));
+	if (ret)
+		return ret;
+
+	ret = of_i3c_master_add_i3c_boardinfo(master, node, reg);
+
+	return ret;
+}
+
+static int of_populate_i3c_bus(struct i3c_master_controller *master)
+{
+	struct udevice *dev = master->dev;
+	struct device_node *node = NULL;
+	ofnode child;
+	int ret;
+	u32 val;
+
+	if (ofnode_valid(dev_ofnode(dev)))
+		return 0;
+
+	ofnode_for_each_subnode(child, dev_ofnode(dev)) {
+		ret = of_i3c_master_add_dev(master, node);
+		if (ret) {
+			of_node_put(node);
+			return ret;
+		}
+	}
+
+	/*
+	 * The user might want to limit I2C and I3C speed in case some devices
+	 * on the bus are not supporting typical rates, or if the bus topology
+	 * prevents it from using max possible rate.
+	 */
+	if (!dev_read_u32(dev, "i2c-scl-hz", &val))
+		master->bus.scl_rate.i2c = val;
+
+	if (!dev_read_u32(dev, "i3c-scl-hz", &val))
+		master->bus.scl_rate.i3c = val;
+
+	return 0;
+}
+
+static void i3c_master_handle_ibi(struct work_struct *work)
+{
+	struct i3c_ibi_slot *slot = container_of(work, struct i3c_ibi_slot,
+						 work);
+	struct i3c_dev_desc *dev = slot->dev;
+	struct i3c_master_controller *master = i3c_dev_get_master(dev);
+	struct i3c_ibi_payload payload;
+
+	payload.data = slot->data;
+	payload.len = slot->len;
+
+	if (dev->dev)
+		dev->ibi->handler(dev->dev, &payload);
+
+	master->ops->recycle_ibi_slot(dev, slot);
+}
+
+static void i3c_master_init_ibi_slot(struct i3c_dev_desc *dev,
+				     struct i3c_ibi_slot *slot)
+{
+	slot->dev = dev;
+	i3c_master_handle_ibi(&slot->work);
+}
+
+struct i3c_generic_ibi_slot {
+	struct list_head node;
+	struct i3c_ibi_slot base;
+};
+
+struct i3c_generic_ibi_pool {
+	spinlock_t lock; /* spinlock for ibi pool */
+	unsigned int num_slots;
+	struct i3c_generic_ibi_slot *slots;
+	void *payload_buf;
+	struct list_head free_slots;
+	struct list_head pending;
+};
+
+/**
+ * i3c_generic_ibi_free_pool() - Free a generic IBI pool
+ * @pool: the IBI pool to free
+ *
+ * Free all IBI slots allated by a generic IBI pool.
+ */
+void i3c_generic_ibi_free_pool(struct i3c_generic_ibi_pool *pool)
+{
+	struct i3c_generic_ibi_slot *slot;
+	unsigned int nslots = 0;
+
+	while (!list_empty(&pool->free_slots)) {
+		slot = list_first_entry(&pool->free_slots,
+					struct i3c_generic_ibi_slot, node);
+		list_del(&slot->node);
+		nslots++;
+	}
+
+	/*
+	 * If the number of freed slots is not equal to the number of allocated
+	 * slots we have a leak somewhere.
+	 */
+	WARN_ON(nslots != pool->num_slots);
+
+	kfree(pool->payload_buf);
+	kfree(pool->slots);
+	kfree(pool);
+}
+EXPORT_SYMBOL_GPL(i3c_generic_ibi_free_pool);
+
+/**
+ * i3c_generic_ibi_alloc_pool() - Create a generic IBI pool
+ * @dev: the device this pool will be used for
+ * @req: IBI setup request describing what the device driver expects
+ *
+ * Create a generic IBI pool based on the information provided in @req.
+ *
+ * Return: a valid IBI pool in case of success, an ERR_PTR() otherwise.
+ */
+struct i3c_generic_ibi_pool *
+i3c_generic_ibi_alloc_pool(struct i3c_dev_desc *dev,
+			   const struct i3c_ibi_setup *req)
+{
+	struct i3c_generic_ibi_pool *pool;
+	struct i3c_generic_ibi_slot *slot;
+	unsigned int i;
+	int ret;
+
+	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock_init(&pool->lock);
+	INIT_LIST_HEAD(&pool->free_slots);
+	INIT_LIST_HEAD(&pool->pending);
+
+	pool->slots = kcalloc(req->num_slots, sizeof(*slot), GFP_KERNEL);
+	if (!pool->slots) {
+		ret = -ENOMEM;
+		goto err_free_pool;
+	}
+
+	if (req->max_payload_len) {
+		pool->payload_buf = kcalloc(req->num_slots,
+					    req->max_payload_len, GFP_KERNEL);
+		if (!pool->payload_buf) {
+			ret = -ENOMEM;
+			goto err_free_pool;
+		}
+	}
+
+	for (i = 0; i < req->num_slots; i++) {
+		slot = &pool->slots[i];
+		i3c_master_init_ibi_slot(dev, &slot->base);
+
+		if (req->max_payload_len)
+			slot->base.data = pool->payload_buf +
+					  (i * req->max_payload_len);
+
+		list_add_tail(&slot->node, &pool->free_slots);
+		pool->num_slots++;
+	}
+
+	return pool;
+
+err_free_pool:
+	i3c_generic_ibi_free_pool(pool);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(i3c_generic_ibi_alloc_pool);
+
+/**
+ * i3c_generic_ibi_get_free_slot() - Get a free slot from a generic IBI pool
+ * @pool: the pool to query an IBI slot on
+ *
+ * Search for a free slot in a generic IBI pool.
+ * The slot should be returned to the pool using i3c_generic_ibi_recycle_slot()
+ * when it's no longer needed.
+ *
+ * Return: a pointer to a free slot, or NULL if there's no free slot available.
+ */
+struct i3c_ibi_slot *
+i3c_generic_ibi_get_free_slot(struct i3c_generic_ibi_pool *pool)
+{
+	struct i3c_generic_ibi_slot *slot;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pool->lock, flags);
+	slot = list_first_entry_or_null(&pool->free_slots,
+					struct i3c_generic_ibi_slot, node);
+
+	if (slot)
+		list_del(&slot->node);
+	spin_unlock_irqrestore(&pool->lock, flags);
+
+	return slot ? &slot->base : NULL;
+}
+EXPORT_SYMBOL_GPL(i3c_generic_ibi_get_free_slot);
+
+/**
+ * i3c_generic_ibi_recycle_slot() - Return a slot to a generic IBI pool
+ * @pool: the pool to return the IBI slot to
+ * @s: IBI slot to recycle
+ *
+ * Add an IBI slot back to its generic IBI pool. Should be called from the
+ * master driver struct_master_controller_ops->recycle_ibi() method.
+ */
+void i3c_generic_ibi_recycle_slot(struct i3c_generic_ibi_pool *pool,
+				  struct i3c_ibi_slot *s)
+{
+	struct i3c_generic_ibi_slot *slot;
+	unsigned long flags;
+
+	if (!s)
+		return;
+
+	slot = container_of(s, struct i3c_generic_ibi_slot, base);
+	spin_lock_irqsave(&pool->lock, flags);
+	list_add_tail(&slot->node, &pool->free_slots);
+	spin_unlock_irqrestore(&pool->lock, flags);
+}
+EXPORT_SYMBOL_GPL(i3c_generic_ibi_recycle_slot);
+
+static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
+{
+	if (!ops || !ops->bus_init || !ops->priv_xfers ||
+	    !ops->send_ccc_cmd || !ops->do_daa || !ops->i2c_xfers)
+		return -EINVAL;
+
+	if (ops->request_ibi &&
+	    (!ops->enable_ibi || !ops->disable_ibi || !ops->free_ibi ||
+	     !ops->recycle_ibi_slot))
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * i3c_master_register() - register an I3C master
+ * @master: master used to send frames on the bus
+ * @parent: the parent device (the one that provides this I3C master
+ *	    controller)
+ * @ops: the master controller operations
+ * @secondary: true if you are registering a secondary master. Will return
+ *	       -ENOTSUPP if set to true since secondary masters are not yet
+ *	       supported
+ *
+ * This function takes care of everything for you:
+ *
+ * - creates and initializes the I3C bus
+ * - populates the bus with static I2C devs if @parent->of_node is not
+ *   NULL
+ * - registers all I3C devices added by the controller during bus
+ *   initialization
+ * - registers the I2C adapter and all I2C devices
+ *
+ * Return: 0 in case of success, a negative error code otherwise.
+ */
+int i3c_master_register(struct i3c_master_controller *master,
+			struct udevice *dev,
+			const struct i3c_master_controller_ops *ops,
+			bool secondary)
+{
+	unsigned long i2c_scl_rate = I3C_BUS_I2C_FM_PLUS_SCL_RATE;
+	struct i3c_bus *i3cbus = i3c_master_get_bus(master);
+	enum i3c_bus_mode mode = I3C_BUS_MODE_PURE;
+	struct i2c_dev_boardinfo *i2cbi;
+	int ret;
+
+	/* We do not support secondary masters yet. */
+	if (secondary)
+		return -EOPNOTSUPP;
+
+	ret = i3c_master_check_ops(ops);
+	if (ret)
+		return ret;
+
+	master->dev = dev;
+
+	master->ops = ops;
+	master->secondary = secondary;
+	INIT_LIST_HEAD(&master->boardinfo.i2c);
+	INIT_LIST_HEAD(&master->boardinfo.i3c);
+
+	ret = i3c_bus_init(i3cbus);
+	if (ret)
+		return ret;
+
+	dev_set_name(master->dev, "i3c-%d", i3cbus->id);
+
+	ret = of_populate_i3c_bus(master);
+	if (ret)
+		return ret;
+
+	list_for_each_entry(i2cbi, &master->boardinfo.i2c, node) {
+		switch (i2cbi->lvr & I3C_LVR_I2C_INDEX_MASK) {
+		case I3C_LVR_I2C_INDEX(0):
+			if (mode < I3C_BUS_MODE_MIXED_FAST)
+				mode = I3C_BUS_MODE_MIXED_FAST;
+			break;
+		case I3C_LVR_I2C_INDEX(1):
+			if (mode < I3C_BUS_MODE_MIXED_LIMITED)
+				mode = I3C_BUS_MODE_MIXED_LIMITED;
+			break;
+		case I3C_LVR_I2C_INDEX(2):
+			if (mode < I3C_BUS_MODE_MIXED_SLOW)
+				mode = I3C_BUS_MODE_MIXED_SLOW;
+			break;
+		default:
+			ret = -EINVAL;
+			return ret;
+		}
+
+		if (i2cbi->lvr & I3C_LVR_I2C_FM_MODE)
+			i2c_scl_rate = I3C_BUS_I2C_FM_SCL_RATE;
+	}
+
+	ret = i3c_bus_set_mode(i3cbus, mode, i2c_scl_rate);
+	if (ret)
+		return ret;
+
+	ret = i3c_master_bus_init(master);
+	if (ret)
+		return ret;
+
+	/*
+	 * We're done initializing the bus and the controller, we can now
+	 * register I3C devices discovered during the initial DAA.
+	 */
+	master->init_done = true;
+	i3c_bus_normaluse_lock(&master->bus);
+	i3c_master_register_new_i3c_devs(master);
+	i3c_bus_normaluse_unlock(&master->bus);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_master_register);
+
+int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
+				 struct i3c_priv_xfer *xfers,
+				 int nxfers)
+{
+	struct i3c_master_controller *master;
+
+	if (!dev)
+		return -ENOENT;
+
+	master = i3c_dev_get_master(dev);
+	if (!master || !xfers)
+		return -EINVAL;
+
+	if (!master->ops->priv_xfers)
+		return -EOPNOTSUPP;
+
+	return master->ops->priv_xfers(dev, xfers, nxfers);
+}
+
+int i3c_dev_disable_ibi_locked(struct i3c_dev_desc *dev)
+{
+	struct i3c_master_controller *master;
+	int ret;
+
+	if (!dev->ibi)
+		return -EINVAL;
+
+	master = i3c_dev_get_master(dev);
+	ret = master->ops->disable_ibi(dev);
+	if (ret)
+		return ret;
+
+	dev->ibi->enabled = false;
+
+	return 0;
+}
+
+int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev)
+{
+	struct i3c_master_controller *master = i3c_dev_get_master(dev);
+	int ret;
+
+	if (!dev->ibi)
+		return -EINVAL;
+
+	ret = master->ops->enable_ibi(dev);
+	if (!ret)
+		dev->ibi->enabled = true;
+
+	return ret;
+}
+
+int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
+			       const struct i3c_ibi_setup *req)
+{
+	struct i3c_master_controller *master = i3c_dev_get_master(dev);
+	struct i3c_device_ibi_info *ibi;
+	int ret;
+
+	if (!master->ops->request_ibi)
+		return -EOPNOTSUPP;
+
+	if (dev->ibi)
+		return -EBUSY;
+
+	ibi = kzalloc(sizeof(*ibi), GFP_KERNEL);
+	if (!ibi)
+		return -ENOMEM;
+
+	ibi->handler = req->handler;
+	ibi->max_payload_len = req->max_payload_len;
+	ibi->num_slots = req->num_slots;
+
+	dev->ibi = ibi;
+	ret = master->ops->request_ibi(dev, req);
+	if (ret) {
+		kfree(ibi);
+		dev->ibi = NULL;
+	}
+
+	return ret;
+}
+
+void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev)
+{
+	struct i3c_master_controller *master = i3c_dev_get_master(dev);
+
+	if (!dev->ibi)
+		return;
+
+	if (WARN_ON(dev->ibi->enabled))
+		WARN_ON(i3c_dev_disable_ibi_locked(dev));
+
+	master->ops->free_ibi(dev);
+	kfree(dev->ibi);
+	dev->ibi = NULL;
+}
+
+MODULE_AUTHOR("Boris Brezillon <boris.brezillon@bootlin.com>");
+MODULE_DESCRIPTION("I3C core");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
new file mode 100644
index 00000000000..8b3d5531a7f
--- /dev/null
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -0,0 +1,1006 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
+ *
+ * Author: Vitor Soares <vitor.soares@synopsys.com>
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dw-i3c.h>
+#include <i2c.h>
+#include <log.h>
+#include <malloc.h>
+#include <pci.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <linux/compat.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/iopoll.h>
+#include <linux/i3c/master.h>
+
+#ifdef CONFIG_SANDBOX
+#define cpu_relax() do {} while (0)
+#endif
+
+static u8 even_parity(u8 p)
+{
+	p ^= p >> 4;
+	p &= 0xf;
+
+	return (0x9669 >> p) & 1;
+}
+
+ulong msecs_to_jiffies(ulong msec)
+{
+	ulong hz = CONFIG_SYS_HZ;
+
+	return (msec + (1000 / hz) - 1) / (1000 / hz);
+}
+
+static bool dw_i3c_master_supports_ccc_cmd(struct i3c_master_controller *m,
+					   const struct i3c_ccc_cmd *cmd)
+{
+	if (cmd->ndests > 1)
+		return false;
+
+	switch (cmd->id) {
+	case I3C_CCC_ENEC(true):
+	case I3C_CCC_ENEC(false):
+	case I3C_CCC_DISEC(true):
+	case I3C_CCC_DISEC(false):
+	case I3C_CCC_ENTAS(0, true):
+	case I3C_CCC_ENTAS(0, false):
+	case I3C_CCC_RSTDAA(true):
+	case I3C_CCC_RSTDAA(false):
+	case I3C_CCC_ENTDAA:
+	case I3C_CCC_SETMWL(true):
+	case I3C_CCC_SETMWL(false):
+	case I3C_CCC_SETMRL(true):
+	case I3C_CCC_SETMRL(false):
+	case I3C_CCC_ENTHDR(0):
+	case I3C_CCC_SETDASA:
+	case I3C_CCC_SETNEWDA:
+	case I3C_CCC_GETMWL:
+	case I3C_CCC_GETMRL:
+	case I3C_CCC_GETPID:
+	case I3C_CCC_GETBCR:
+	case I3C_CCC_GETDCR:
+	case I3C_CCC_GETSTATUS:
+	case I3C_CCC_GETMXDS:
+	case I3C_CCC_GETHDRCAP:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static inline struct dw_i3c_master *
+to_dw_i3c_master(struct i3c_master_controller *master)
+{
+	return container_of(master, struct dw_i3c_master, base);
+}
+
+static void dw_i3c_master_disable(struct dw_i3c_master *master)
+{
+	writel(readl(master->regs + DEVICE_CTRL) & ~DEV_CTRL_ENABLE,
+	       master->regs + DEVICE_CTRL);
+}
+
+static void dw_i3c_master_enable(struct dw_i3c_master *master)
+{
+	writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_ENABLE,
+	       master->regs + DEVICE_CTRL);
+}
+
+static int dw_i3c_master_get_addr_pos(struct dw_i3c_master *master, u8 addr)
+{
+	int pos;
+
+	for (pos = 0; pos < master->maxdevs; pos++) {
+		if (addr == master->addrs[pos])
+			return pos;
+	}
+
+	return -EINVAL;
+}
+
+static int dw_i3c_master_get_free_pos(struct dw_i3c_master *master)
+{
+	if (!(master->free_pos & GENMASK(master->maxdevs - 1, 0)))
+		return -ENOSPC;
+
+	return ffs(master->free_pos) - 1;
+}
+
+static void dw_i3c_master_wr_tx_fifo(struct dw_i3c_master *master,
+				     const u8 *bytes, int nbytes)
+{
+	writesl(master->regs + RX_TX_DATA_PORT, bytes, nbytes / 4);
+	if (nbytes & 3) {
+		u32 tmp = 0;
+
+		memcpy(&tmp, bytes + (nbytes & ~3), nbytes & 3);
+		writesl(master->regs + RX_TX_DATA_PORT, &tmp, 1);
+	}
+}
+
+static void dw_i3c_master_read_rx_fifo(struct dw_i3c_master *master,
+				       u8 *bytes, int nbytes)
+{
+	readsl(master->regs + RX_TX_DATA_PORT, bytes, nbytes / 4);
+	if (nbytes & 3) {
+		u32 tmp;
+
+		readsl(master->regs + RX_TX_DATA_PORT, &tmp, 1);
+		memcpy(bytes + (nbytes & ~3), &tmp, nbytes & 3);
+	}
+}
+
+static struct dw_i3c_xfer *
+dw_i3c_master_alloc_xfer(struct dw_i3c_master *master, unsigned int ncmds)
+{
+	struct dw_i3c_xfer *xfer;
+
+	xfer = kzalloc(STRUCT_SZ(struct dw_i3c_xfer, ncmds), GFP_KERNEL);
+	if (!xfer)
+		return NULL;
+
+	INIT_LIST_HEAD(&xfer->node);
+	xfer->ncmds = ncmds;
+	xfer->ret = -ETIMEDOUT;
+
+	return xfer;
+}
+
+static void dw_i3c_master_free_xfer(struct dw_i3c_xfer *xfer)
+{
+	kfree(xfer);
+}
+
+static void dw_i3c_master_start_xfer_locked(struct dw_i3c_master *master)
+{
+	struct dw_i3c_xfer *xfer = master->xferqueue.cur;
+	unsigned int i;
+	u32 thld_ctrl;
+
+	if (!xfer)
+		return;
+
+	for (i = 0; i < xfer->ncmds; i++) {
+		struct dw_i3c_cmd *cmd = &xfer->cmds[i];
+
+		dw_i3c_master_wr_tx_fifo(master, cmd->tx_buf, cmd->tx_len);
+	}
+
+	thld_ctrl = readl(master->regs + QUEUE_THLD_CTRL);
+	thld_ctrl &= ~QUEUE_THLD_CTRL_RESP_BUF_MASK;
+	thld_ctrl |= QUEUE_THLD_CTRL_RESP_BUF(xfer->ncmds);
+	writel(thld_ctrl, master->regs + QUEUE_THLD_CTRL);
+
+	for (i = 0; i < xfer->ncmds; i++) {
+		struct dw_i3c_cmd *cmd = &xfer->cmds[i];
+
+		writel(cmd->cmd_hi, master->regs + COMMAND_QUEUE_PORT);
+		writel(cmd->cmd_lo, master->regs + COMMAND_QUEUE_PORT);
+	}
+}
+
+static void dw_i3c_master_enqueue_xfer(struct dw_i3c_master *master,
+				       struct dw_i3c_xfer *xfer)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&master->xferqueue.lock, flags);
+
+	if (master->xferqueue.cur) {
+		list_add_tail(&xfer->node, &master->xferqueue.list);
+	} else {
+		master->xferqueue.cur = xfer;
+		dw_i3c_master_start_xfer_locked(master);
+	}
+
+	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
+}
+
+static void dw_i3c_master_dequeue_xfer_locked(struct dw_i3c_master *master,
+					      struct dw_i3c_xfer *xfer)
+{
+	if (master->xferqueue.cur == xfer) {
+		u32 status;
+
+		master->xferqueue.cur = NULL;
+
+		writel(RESET_CTRL_RX_FIFO | RESET_CTRL_TX_FIFO |
+		       RESET_CTRL_RESP_QUEUE | RESET_CTRL_CMD_QUEUE,
+		       master->regs + RESET_CTRL);
+
+		readl_poll_timeout_atomic(master->regs + RESET_CTRL, status,
+					  !status, 10, 1000000);
+	} else {
+		list_del_init(&xfer->node);
+	}
+}
+
+static int dw_i3c_status_poll_timeout(struct dw_i3c_master *master)
+{
+	u32 status;
+	unsigned long base, limit;
+
+	base = get_timer(0);
+	limit = CONFIG_SYS_HZ * 5000 / 1000;
+	do {
+		status = readl(master->regs + INTR_STATUS);
+		if (status)
+			return 0;
+
+		cpu_relax();
+	} while (get_timer(base) < limit);
+
+	return -ETIMEDOUT;
+}
+
+static void dw_i3c_master_dequeue_xfer(struct dw_i3c_master *master,
+				       struct dw_i3c_xfer *xfer)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&master->xferqueue.lock, flags);
+	dw_i3c_master_dequeue_xfer_locked(master, xfer);
+	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
+}
+
+static void dw_i3c_master_end_xfer_locked(struct dw_i3c_master *master, u32 isr)
+{
+	struct dw_i3c_xfer *xfer = master->xferqueue.cur;
+	int i, ret = 0;
+	u32 nresp;
+
+	if (!xfer)
+		return;
+
+	nresp = readl(master->regs + QUEUE_STATUS_LEVEL);
+	nresp = QUEUE_STATUS_LEVEL_RESP(nresp);
+
+	for (i = 0; i < nresp; i++) {
+		struct dw_i3c_cmd *cmd;
+		u32 resp;
+
+		resp = readl(master->regs + RESPONSE_QUEUE_PORT);
+
+		cmd = &xfer->cmds[RESPONSE_PORT_TID(resp)];
+		cmd->rx_len = RESPONSE_PORT_DATA_LEN(resp);
+		cmd->error = RESPONSE_PORT_ERR_STATUS(resp);
+		if (cmd->rx_len && !cmd->error)
+			dw_i3c_master_read_rx_fifo(master, cmd->rx_buf,
+						   cmd->rx_len);
+	}
+
+	for (i = 0; i < nresp; i++) {
+		switch (xfer->cmds[i].error) {
+		case RESPONSE_NO_ERROR:
+			break;
+		case RESPONSE_ERROR_PARITY:
+		case RESPONSE_ERROR_IBA_NACK:
+		case RESPONSE_ERROR_TRANSF_ABORT:
+		case RESPONSE_ERROR_CRC:
+		case RESPONSE_ERROR_FRAME:
+			ret = -EIO;
+			break;
+		case RESPONSE_ERROR_OVER_UNDER_FLOW:
+			ret = -ENOSPC;
+			break;
+		case RESPONSE_ERROR_I2C_W_NACK_ERR:
+		case RESPONSE_ERROR_ADDRESS_NACK:
+		default:
+			ret = -EINVAL;
+			break;
+		}
+	}
+
+	xfer->ret = ret;
+
+	if (ret < 0) {
+		dw_i3c_master_dequeue_xfer_locked(master, xfer);
+		writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_RESUME,
+		       master->regs + DEVICE_CTRL);
+	}
+
+	xfer = list_first_entry_or_null(&master->xferqueue.list,
+					struct dw_i3c_xfer,
+					node);
+	if (xfer)
+		list_del_init(&xfer->node);
+
+	master->xferqueue.cur = xfer;
+	dw_i3c_master_start_xfer_locked(master);
+}
+
+static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
+{
+	unsigned long core_rate, core_period;
+	u32 scl_timing;
+	u8 hcnt, lcnt;
+
+	core_rate = clk_get_rate(&master->core_clk);
+	if (!core_rate)
+		return -EINVAL;
+
+	core_period = DIV_ROUND_UP(1000000000, core_rate);
+
+	hcnt = DIV_ROUND_UP(I3C_BUS_THIGH_MAX_NS, core_period) - 1;
+	if (hcnt < SCL_I3C_TIMING_CNT_MIN)
+		hcnt = SCL_I3C_TIMING_CNT_MIN;
+
+	lcnt = DIV_ROUND_UP(core_rate, master->base.bus.scl_rate.i3c) - hcnt;
+	if (lcnt < SCL_I3C_TIMING_CNT_MIN)
+		lcnt = SCL_I3C_TIMING_CNT_MIN;
+
+	scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | SCL_I3C_TIMING_LCNT(lcnt);
+	writel(scl_timing, master->regs + SCL_I3C_PP_TIMING);
+
+	/*
+	 * In pure i3c mode, MST_FREE represents tCAS. In shared mode, this
+	 * will be set up by dw_i2c_clk_cfg as tLOW.
+	 */
+	if (master->base.bus.mode == I3C_BUS_MODE_PURE)
+		writel(BUS_I3C_MST_FREE(lcnt), master->regs + BUS_FREE_TIMING);
+
+	lcnt = max_t(u8,
+		     DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, core_period), lcnt);
+
+	scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | SCL_I3C_TIMING_LCNT(lcnt);
+	writel(scl_timing, master->regs + SCL_I3C_OD_TIMING);
+
+	lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR1_SCL_RATE) - hcnt;
+	scl_timing = SCL_EXT_LCNT_1(lcnt);
+	lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR2_SCL_RATE) - hcnt;
+	scl_timing |= SCL_EXT_LCNT_2(lcnt);
+	lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR3_SCL_RATE) - hcnt;
+	scl_timing |= SCL_EXT_LCNT_3(lcnt);
+	lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR4_SCL_RATE) - hcnt;
+	scl_timing |= SCL_EXT_LCNT_4(lcnt);
+	writel(scl_timing, master->regs + SCL_EXT_LCNT_TIMING);
+
+	return 0;
+}
+
+static int dw_i2c_clk_cfg(struct dw_i3c_master *master)
+{
+	unsigned long core_rate, core_period;
+	u16 hcnt, lcnt;
+	u32 scl_timing;
+
+	core_rate = clk_get_rate(&master->core_clk);
+	if (!core_rate)
+		return -EINVAL;
+
+	core_period = DIV_ROUND_UP(1000000000, core_rate);
+
+	lcnt = DIV_ROUND_UP(I3C_BUS_I2C_FMP_TLOW_MIN_NS, core_period);
+	hcnt = DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_PLUS_SCL_RATE) - lcnt;
+	scl_timing = SCL_I2C_FMP_TIMING_HCNT(hcnt) |
+		     SCL_I2C_FMP_TIMING_LCNT(lcnt);
+	writel(scl_timing, master->regs + SCL_I2C_FMP_TIMING);
+
+	lcnt = DIV_ROUND_UP(I3C_BUS_I2C_FM_TLOW_MIN_NS, core_period);
+	hcnt = DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_SCL_RATE) - lcnt;
+	scl_timing = SCL_I2C_FM_TIMING_HCNT(hcnt) |
+		     SCL_I2C_FM_TIMING_LCNT(lcnt);
+	writel(scl_timing, master->regs + SCL_I2C_FM_TIMING);
+
+	writel(BUS_I3C_MST_FREE(lcnt), master->regs + BUS_FREE_TIMING);
+	writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_I2C_SLAVE_PRESENT,
+	       master->regs + DEVICE_CTRL);
+
+	return 0;
+}
+
+static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
+{
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+	struct i3c_bus *bus = i3c_master_get_bus(m);
+	struct i3c_device_info info = { };
+	u32 thld_ctrl;
+	int ret;
+
+	switch (bus->mode) {
+	case I3C_BUS_MODE_MIXED_FAST:
+	case I3C_BUS_MODE_MIXED_LIMITED:
+		ret = dw_i2c_clk_cfg(master);
+		if (ret)
+			return ret;
+		fallthrough;
+	case I3C_BUS_MODE_PURE:
+		ret = dw_i3c_clk_cfg(master);
+		if (ret)
+			return ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	thld_ctrl = readl(master->regs + QUEUE_THLD_CTRL);
+	thld_ctrl &= ~QUEUE_THLD_CTRL_RESP_BUF_MASK;
+	writel(thld_ctrl, master->regs + QUEUE_THLD_CTRL);
+
+	thld_ctrl = readl(master->regs + DATA_BUFFER_THLD_CTRL);
+	thld_ctrl &= ~DATA_BUFFER_THLD_CTRL_RX_BUF;
+	writel(thld_ctrl, master->regs + DATA_BUFFER_THLD_CTRL);
+
+	writel(INTR_ALL, master->regs + INTR_STATUS);
+	writel(INTR_MASTER_MASK, master->regs + INTR_STATUS_EN);
+	writel(INTR_MASTER_MASK, master->regs + INTR_SIGNAL_EN);
+
+	ret = i3c_master_get_free_addr(m, 0);
+	if (ret < 0)
+		return ret;
+
+	writel(DEV_ADDR_DYNAMIC_ADDR_VALID | DEV_ADDR_DYNAMIC(ret),
+	       master->regs + DEVICE_ADDR);
+
+	memset(&info, 0, sizeof(info));
+	info.dyn_addr = ret;
+
+	ret = i3c_master_set_info(&master->base, &info);
+	if (ret)
+		return ret;
+
+	writel(IBI_REQ_REJECT_ALL, master->regs + IBI_SIR_REQ_REJECT);
+	writel(IBI_REQ_REJECT_ALL, master->regs + IBI_MR_REQ_REJECT);
+
+	/* For now don't support Hot-Join */
+	writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_HOT_JOIN_NACK,
+	       master->regs + DEVICE_CTRL);
+
+	dw_i3c_master_enable(master);
+
+	return 0;
+}
+
+static void dw_i3c_master_bus_cleanup(struct i3c_master_controller *m)
+{
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+
+	dw_i3c_master_disable(master);
+}
+
+static void dw_i3c_master_irq_handler(struct dw_i3c_master *master)
+{
+	u32 status, en;
+
+	status = readl(master->regs + INTR_STATUS);
+	en = readl(master->regs + INTR_STATUS_EN);
+
+	if (!(status & readl(master->regs + INTR_STATUS_EN))) {
+		pr_err("Failed to get completion status, status=%d, status_en=%d\n", status, en);
+		writel(INTR_ALL, master->regs + INTR_STATUS);
+	}
+
+	spin_lock(&master->xferqueue.lock);
+	dw_i3c_master_end_xfer_locked(master, status);
+
+	if (status & INTR_TRANSFER_ERR_STAT)
+		writel(INTR_TRANSFER_ERR_STAT, master->regs + INTR_STATUS);
+
+	spin_unlock(&master->xferqueue.lock);
+}
+
+static int dw_i3c_ccc_set(struct dw_i3c_master *master,
+			  struct i3c_ccc_cmd *ccc)
+{
+	struct dw_i3c_xfer *xfer;
+	struct dw_i3c_cmd *cmd;
+	int ret, pos = 0;
+
+	if (ccc->id & I3C_CCC_DIRECT) {
+		pos = dw_i3c_master_get_addr_pos(master, ccc->dests[0].addr);
+		if (pos < 0)
+			return pos;
+	}
+
+	xfer = dw_i3c_master_alloc_xfer(master, 1);
+	if (!xfer)
+		return -ENOMEM;
+
+	cmd = xfer->cmds;
+	cmd->tx_buf = ccc->dests[0].payload.data;
+	cmd->tx_len = ccc->dests[0].payload.len;
+
+	cmd->cmd_hi = COMMAND_PORT_ARG_DATA_LEN(ccc->dests[0].payload.len) |
+		      COMMAND_PORT_TRANSFER_ARG;
+
+	cmd->cmd_lo = COMMAND_PORT_CP |
+		      COMMAND_PORT_DEV_INDEX(pos) |
+		      COMMAND_PORT_CMD(ccc->id) |
+		      COMMAND_PORT_TOC |
+		      COMMAND_PORT_ROC;
+
+	dw_i3c_master_enqueue_xfer(master, xfer);
+
+	if (dw_i3c_status_poll_timeout(master) > POLL_SUCCESS)
+		dw_i3c_master_dequeue_xfer(master, xfer);
+	else
+		dw_i3c_master_irq_handler(master);
+
+	ret = xfer->ret;
+
+	if (xfer->cmds[0].error == RESPONSE_ERROR_IBA_NACK)
+		ccc->err = I3C_ERROR_M2;
+
+	dw_i3c_master_free_xfer(xfer);
+
+	return ret;
+}
+
+static int dw_i3c_ccc_get(struct dw_i3c_master *master, struct i3c_ccc_cmd *ccc)
+{
+	struct dw_i3c_xfer *xfer;
+	struct dw_i3c_cmd *cmd;
+	int ret, pos;
+
+	pos = dw_i3c_master_get_addr_pos(master, ccc->dests[0].addr);
+	if (pos < 0)
+		return pos;
+
+	xfer = dw_i3c_master_alloc_xfer(master, 1);
+	if (!xfer)
+		return -ENOMEM;
+
+	cmd = xfer->cmds;
+	cmd->rx_buf = ccc->dests[0].payload.data;
+	cmd->rx_len = ccc->dests[0].payload.len;
+
+	cmd->cmd_hi = COMMAND_PORT_ARG_DATA_LEN(ccc->dests[0].payload.len) |
+		      COMMAND_PORT_TRANSFER_ARG;
+
+	cmd->cmd_lo = COMMAND_PORT_READ_TRANSFER |
+		      COMMAND_PORT_CP |
+		      COMMAND_PORT_DEV_INDEX(pos) |
+		      COMMAND_PORT_CMD(ccc->id) |
+		      COMMAND_PORT_TOC |
+		      COMMAND_PORT_ROC;
+
+	dw_i3c_master_enqueue_xfer(master, xfer);
+
+	if (dw_i3c_status_poll_timeout(master) > POLL_SUCCESS)
+		dw_i3c_master_dequeue_xfer(master, xfer);
+	else
+		dw_i3c_master_irq_handler(master);
+
+	ret = xfer->ret;
+
+	if (xfer->cmds[0].error == RESPONSE_ERROR_IBA_NACK)
+		ccc->err = I3C_ERROR_M2;
+	dw_i3c_master_free_xfer(xfer);
+
+	return ret;
+}
+
+static int dw_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
+				      struct i3c_ccc_cmd *ccc)
+{
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+	int ret = 0;
+
+	if (ccc->id == I3C_CCC_ENTDAA)
+		return -EINVAL;
+
+	if (ccc->rnw)
+		ret = dw_i3c_ccc_get(master, ccc);
+	else
+		ret = dw_i3c_ccc_set(master, ccc);
+
+	return ret;
+}
+
+static int dw_i3c_master_daa(struct i3c_master_controller *m)
+{
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+	struct dw_i3c_xfer *xfer;
+	struct dw_i3c_cmd *cmd;
+	u32 olddevs, newdevs;
+	u8 p, last_addr = 0;
+	int ret, pos;
+
+	olddevs = ~(master->free_pos);
+
+	/* Prepare DAT before launching DAA. */
+	for (pos = 0; pos < master->maxdevs; pos++) {
+		if (olddevs & BIT(pos))
+			continue;
+
+		ret = i3c_master_get_free_addr(m, last_addr + 1);
+		if (ret < 0)
+			return -ENOSPC;
+
+		master->addrs[pos] = ret;
+		p = even_parity(ret);
+		last_addr = ret;
+		ret |= (p << 7);
+
+		writel(DEV_ADDR_TABLE_DYNAMIC_ADDR(ret),
+		       master->regs +
+		       DEV_ADDR_TABLE_LOC(master->datstartaddr, pos));
+	}
+
+	xfer = dw_i3c_master_alloc_xfer(master, 1);
+	if (!xfer)
+		return -ENOMEM;
+
+	pos = dw_i3c_master_get_free_pos(master);
+	cmd = &xfer->cmds[0];
+	cmd->cmd_hi = 0x1;
+	cmd->cmd_lo = COMMAND_PORT_DEV_COUNT(master->maxdevs - pos) |
+		      COMMAND_PORT_DEV_INDEX(pos) |
+		      COMMAND_PORT_CMD(I3C_CCC_ENTDAA) |
+		      COMMAND_PORT_ADDR_ASSGN_CMD |
+		      COMMAND_PORT_TOC |
+		      COMMAND_PORT_ROC;
+
+	dw_i3c_master_enqueue_xfer(master, xfer);
+
+	if (dw_i3c_status_poll_timeout(master) > POLL_SUCCESS)
+		dw_i3c_master_dequeue_xfer(master, xfer);
+	else
+		dw_i3c_master_irq_handler(master);
+
+	newdevs = GENMASK(master->maxdevs - cmd->rx_len - 1, 0);
+	newdevs &= ~olddevs;
+
+	for (pos = 0; pos < master->maxdevs; pos++) {
+		if (newdevs & BIT(pos))
+			i3c_master_add_i3c_dev_locked(m, master->addrs[pos]);
+	}
+
+	dw_i3c_master_free_xfer(xfer);
+
+	return 0;
+}
+
+static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
+				    struct i3c_priv_xfer *i3c_xfers,
+				    u32 i3c_nxfers)
+{
+	struct dw_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
+	struct i3c_master_controller *m = i3c_dev_get_master(dev);
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+	unsigned int nrxwords = 0, ntxwords = 0;
+	struct dw_i3c_xfer *xfer;
+	int i, ret = 0;
+
+	if (!i3c_nxfers)
+		return 0;
+
+	if (i3c_nxfers > master->caps.cmdfifodepth)
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < i3c_nxfers; i++) {
+		if (i3c_xfers[i].rnw)
+			nrxwords += DIV_ROUND_UP(i3c_xfers[i].len, 4);
+		else
+			ntxwords += DIV_ROUND_UP(i3c_xfers[i].len, 4);
+	}
+
+	if (ntxwords > master->caps.datafifodepth ||
+	    nrxwords > master->caps.datafifodepth)
+		return -EOPNOTSUPP;
+
+	xfer = dw_i3c_master_alloc_xfer(master, i3c_nxfers);
+	if (!xfer)
+		return -ENOMEM;
+
+	for (i = 0; i < i3c_nxfers; i++) {
+		struct dw_i3c_cmd *cmd = &xfer->cmds[i];
+
+		cmd->cmd_hi = COMMAND_PORT_ARG_DATA_LEN(i3c_xfers[i].len) |
+			COMMAND_PORT_TRANSFER_ARG;
+
+		if (i3c_xfers[i].rnw) {
+			cmd->rx_buf = i3c_xfers[i].data.in;
+			cmd->rx_len = i3c_xfers[i].len;
+			cmd->cmd_lo = COMMAND_PORT_READ_TRANSFER |
+				      COMMAND_PORT_SPEED(dev->info.max_read_ds);
+
+		} else {
+			cmd->tx_buf = i3c_xfers[i].data.out;
+			cmd->tx_len = i3c_xfers[i].len;
+			cmd->cmd_lo =
+				COMMAND_PORT_SPEED(dev->info.max_write_ds);
+		}
+
+		cmd->cmd_lo |= COMMAND_PORT_TID(i) |
+			       COMMAND_PORT_DEV_INDEX(data->index) |
+			       COMMAND_PORT_ROC;
+
+		if (i == (i3c_nxfers - 1))
+			cmd->cmd_lo |= COMMAND_PORT_TOC;
+	}
+
+	dw_i3c_master_enqueue_xfer(master, xfer);
+
+	if (dw_i3c_status_poll_timeout(master) > POLL_SUCCESS)
+		dw_i3c_master_dequeue_xfer(master, xfer);
+	else
+		dw_i3c_master_irq_handler(master);
+
+	ret = xfer->ret;
+
+	dw_i3c_master_free_xfer(xfer);
+
+	return ret;
+}
+
+static int dw_i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
+					  u8 old_dyn_addr)
+{
+	struct dw_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
+	struct i3c_master_controller *m = i3c_dev_get_master(dev);
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+	int pos;
+
+	pos = dw_i3c_master_get_free_pos(master);
+
+	if (data->index > pos && pos > 0) {
+		writel(0,
+		       master->regs +
+		       DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
+
+		master->addrs[data->index] = 0;
+		master->free_pos |= BIT(data->index);
+
+		data->index = pos;
+		master->addrs[pos] = dev->info.dyn_addr;
+		master->free_pos &= ~BIT(pos);
+	}
+
+	writel(DEV_ADDR_TABLE_DYNAMIC_ADDR(dev->info.dyn_addr),
+	       master->regs +
+	       DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
+
+	master->addrs[data->index] = dev->info.dyn_addr;
+
+	return 0;
+}
+
+static int dw_i3c_master_attach_i3c_dev(struct i3c_dev_desc *dev)
+{
+	struct i3c_master_controller *m = i3c_dev_get_master(dev);
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+	struct dw_i3c_i2c_dev_data *data;
+	int pos;
+
+	pos = dw_i3c_master_get_free_pos(master);
+	if (pos < 0)
+		return pos;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->index = pos;
+	master->addrs[pos] = dev->info.dyn_addr ? : dev->info.static_addr;
+	master->free_pos &= ~BIT(pos);
+	i3c_dev_set_master_data(dev, data);
+
+	writel(DEV_ADDR_TABLE_DYNAMIC_ADDR(master->addrs[pos]),
+	       master->regs +
+	       DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
+
+	return 0;
+}
+
+static void dw_i3c_master_detach_i3c_dev(struct i3c_dev_desc *dev)
+{
+	struct dw_i3c_i2c_dev_data *data = i3c_dev_get_master_data(dev);
+	struct i3c_master_controller *m = i3c_dev_get_master(dev);
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+
+	writel(0,
+	       master->regs +
+	       DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
+
+	i3c_dev_set_master_data(dev, NULL);
+	master->addrs[data->index] = 0;
+	master->free_pos |= BIT(data->index);
+	kfree(data);
+}
+
+static int dw_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
+				   const struct i2c_msg *i2c_xfers,
+				   int i2c_nxfers)
+{
+	struct dw_i3c_i2c_dev_data *data = i2c_dev_get_master_data(dev);
+	struct i3c_master_controller *m = i2c_dev_get_master(dev);
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+	unsigned int nrxwords = 0, ntxwords = 0;
+	struct dw_i3c_xfer *xfer;
+	int i, ret = 0;
+
+	if (!i2c_nxfers)
+		return 0;
+
+	if (i2c_nxfers > master->caps.cmdfifodepth)
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < i2c_nxfers; i++) {
+		if (i2c_xfers[i].flags & I2C_M_RD)
+			nrxwords += DIV_ROUND_UP(i2c_xfers[i].len, 4);
+		else
+			ntxwords += DIV_ROUND_UP(i2c_xfers[i].len, 4);
+	}
+
+	if (ntxwords > master->caps.datafifodepth ||
+	    nrxwords > master->caps.datafifodepth)
+		return -EOPNOTSUPP;
+
+	xfer = dw_i3c_master_alloc_xfer(master, i2c_nxfers);
+	if (!xfer)
+		return -ENOMEM;
+
+	for (i = 0; i < i2c_nxfers; i++) {
+		struct dw_i3c_cmd *cmd = &xfer->cmds[i];
+
+		cmd->cmd_hi = COMMAND_PORT_ARG_DATA_LEN(i2c_xfers[i].len) |
+			COMMAND_PORT_TRANSFER_ARG;
+
+		cmd->cmd_lo = COMMAND_PORT_TID(i) |
+			      COMMAND_PORT_DEV_INDEX(data->index) |
+			      COMMAND_PORT_ROC;
+
+		if (i2c_xfers[i].flags & I2C_M_RD) {
+			cmd->cmd_lo |= COMMAND_PORT_READ_TRANSFER;
+			cmd->rx_buf = i2c_xfers[i].buf;
+			cmd->rx_len = i2c_xfers[i].len;
+		} else {
+			cmd->tx_buf = i2c_xfers[i].buf;
+			cmd->tx_len = i2c_xfers[i].len;
+		}
+
+		if (i == (i2c_nxfers - 1))
+			cmd->cmd_lo |= COMMAND_PORT_TOC;
+	}
+
+	dw_i3c_master_enqueue_xfer(master, xfer);
+
+	if (dw_i3c_status_poll_timeout(master) > POLL_SUCCESS)
+		dw_i3c_master_dequeue_xfer(master, xfer);
+	else
+		dw_i3c_master_irq_handler(master);
+
+	ret = xfer->ret;
+	dw_i3c_master_free_xfer(xfer);
+
+	return ret;
+}
+
+static int dw_i3c_master_attach_i2c_dev(struct i2c_dev_desc *dev)
+{
+	struct i3c_master_controller *m = i2c_dev_get_master(dev);
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+	struct dw_i3c_i2c_dev_data *data;
+	int pos;
+
+	pos = dw_i3c_master_get_free_pos(master);
+	if (pos < 0)
+		return pos;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->index = pos;
+	master->addrs[pos] = dev->addr;
+	master->free_pos &= ~BIT(pos);
+	i2c_dev_set_master_data(dev, data);
+
+	writel(DEV_ADDR_TABLE_LEGACY_I2C_DEV |
+	       DEV_ADDR_TABLE_STATIC_ADDR(dev->addr),
+	       master->regs +
+	       DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
+
+	return 0;
+}
+
+static void dw_i3c_master_detach_i2c_dev(struct i2c_dev_desc *dev)
+{
+	struct dw_i3c_i2c_dev_data *data = i2c_dev_get_master_data(dev);
+	struct i3c_master_controller *m = i2c_dev_get_master(dev);
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+
+	writel(0,
+	       master->regs +
+	       DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
+
+	i2c_dev_set_master_data(dev, NULL);
+	master->addrs[data->index] = 0;
+	master->free_pos |= BIT(data->index);
+	kfree(data);
+}
+
+static const struct i3c_master_controller_ops dw_mipi_i3c_ops = {
+	.bus_init = dw_i3c_master_bus_init,
+	.bus_cleanup = dw_i3c_master_bus_cleanup,
+	.attach_i3c_dev = dw_i3c_master_attach_i3c_dev,
+	.reattach_i3c_dev = dw_i3c_master_reattach_i3c_dev,
+	.detach_i3c_dev = dw_i3c_master_detach_i3c_dev,
+	.do_daa = dw_i3c_master_daa,
+	.supports_ccc_cmd = dw_i3c_master_supports_ccc_cmd,
+	.send_ccc_cmd = dw_i3c_master_send_ccc_cmd,
+	.priv_xfers = dw_i3c_master_priv_xfers,
+	.attach_i2c_dev = dw_i3c_master_attach_i2c_dev,
+	.detach_i2c_dev = dw_i3c_master_detach_i2c_dev,
+	.i2c_xfers = dw_i3c_master_i2c_xfers,
+};
+
+static int dw_i3c_probe(struct udevice *dev)
+{
+	struct dw_i3c_master *master = dev_get_priv(dev);
+	int ret;
+
+	if (!master->regs)
+		master->regs = dev_read_addr_ptr(dev);
+
+	ret = clk_get_by_index(dev, 0, &master->core_clk);
+	if (ret) {
+		dev_err(dev, "Can't get clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = reset_get_bulk(dev, &master->resets);
+	if (ret) {
+		dev_err(dev, "Can't get reset: %d\n", ret);
+		return ret;
+	}
+
+	reset_deassert_bulk(&master->resets);
+
+	spin_lock_init(&master->xferqueue.lock);
+	INIT_LIST_HEAD(&master->xferqueue.list);
+
+	writel(INTR_ALL, master->regs + INTR_STATUS);
+
+	/* Information regarding the FIFOs/QUEUEs depth */
+	ret = readl(master->regs + QUEUE_STATUS_LEVEL);
+	master->caps.cmdfifodepth = QUEUE_STATUS_LEVEL_CMD(ret);
+
+	ret = readl(master->regs + DATA_BUFFER_STATUS_LEVEL);
+	master->caps.datafifodepth = DATA_BUFFER_STATUS_LEVEL_TX(ret);
+
+	ret = readl(master->regs + DEVICE_ADDR_TABLE_POINTER);
+	master->datstartaddr = ret;
+	master->maxdevs = ret >> 16;
+	master->free_pos = GENMASK(master->maxdevs - 1, 0);
+
+	ret = i3c_master_register(&master->base, dev,
+				  &dw_mipi_i3c_ops, false);
+	if (ret)
+		goto err_assert_rst;
+
+	return 0;
+
+err_assert_rst:
+	reset_assert_bulk(&master->resets);
+
+	return ret;
+}
+
+static const struct dm_i3c_ops dw_i3c_ops = {
+	.i3c_xfers = dw_i3c_master_priv_xfers,
+};
+
+static const struct udevice_id dw_i3c_ids[] = {
+	{ .compatible = "snps,dw-i3c-master-1.00a" },
+	{ }
+};
+
+U_BOOT_DRIVER(dw_i3c_driver) = {
+	.name = "dw-i3c-master",
+	.id = UCLASS_I3C,
+	.of_match = dw_i3c_ids,
+	.probe = dw_i3c_probe,
+	.priv_auto = sizeof(struct dw_i3c_master),
+	.ops    = &dw_i3c_ops,
+};
diff --git a/include/dw-i3c.h b/include/dw-i3c.h
new file mode 100644
index 00000000000..e37fd4dc325
--- /dev/null
+++ b/include/dw-i3c.h
@@ -0,0 +1,248 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#ifndef _DW_I3C_H_
+#define _DW_I3C_H_
+
+#include <clk.h>
+#include <reset.h>
+#include <dm/device.h>
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
+#include <linker_lists.h>
+#include <linux/i3c/master.h>
+
+#define DEVICE_CTRL			0x0
+#define DEV_CTRL_ENABLE			BIT(31)
+#define DEV_CTRL_RESUME			BIT(30)
+#define DEV_CTRL_HOT_JOIN_NACK		BIT(8)
+#define DEV_CTRL_I2C_SLAVE_PRESENT	BIT(7)
+
+#define DEVICE_ADDR			0x4
+#define DEV_ADDR_DYNAMIC_ADDR_VALID	BIT(31)
+#define DEV_ADDR_DYNAMIC(x)		(((x) << 16) & GENMASK(22, 16))
+
+#define HW_CAPABILITY			0x8
+#define COMMAND_QUEUE_PORT		0xc
+#define COMMAND_PORT_TOC		BIT(30)
+#define COMMAND_PORT_READ_TRANSFER	BIT(28)
+#define COMMAND_PORT_SDAP		BIT(27)
+#define COMMAND_PORT_ROC		BIT(26)
+#define COMMAND_PORT_SPEED(x)		(((x) << 21) & GENMASK(23, 21))
+#define COMMAND_PORT_DEV_INDEX(x)	(((x) << 16) & GENMASK(20, 16))
+#define COMMAND_PORT_CP			BIT(15)
+#define COMMAND_PORT_CMD(x)		(((x) << 7) & GENMASK(14, 7))
+#define COMMAND_PORT_TID(x)		(((x) << 3) & GENMASK(6, 3))
+
+#define COMMAND_PORT_ARG_DATA_LEN(x)	(((x) << 16) & GENMASK(31, 16))
+#define COMMAND_PORT_ARG_DATA_LEN_MAX	65536
+#define COMMAND_PORT_TRANSFER_ARG	0x01
+
+#define COMMAND_PORT_SDA_DATA_BYTE_3(x)	(((x) << 24) & GENMASK(31, 24))
+#define COMMAND_PORT_SDA_DATA_BYTE_2(x)	(((x) << 16) & GENMASK(23, 16))
+#define COMMAND_PORT_SDA_DATA_BYTE_1(x)	(((x) << 8) & GENMASK(15, 8))
+#define COMMAND_PORT_SDA_BYTE_STRB_3	BIT(5)
+#define COMMAND_PORT_SDA_BYTE_STRB_2	BIT(4)
+#define COMMAND_PORT_SDA_BYTE_STRB_1	BIT(3)
+#define COMMAND_PORT_SHORT_DATA_ARG	0x02
+
+#define COMMAND_PORT_DEV_COUNT(x)	(((x) << 21) & GENMASK(25, 21))
+#define COMMAND_PORT_ADDR_ASSGN_CMD	0x03
+
+#define RESPONSE_QUEUE_PORT		0x10
+#define RESPONSE_PORT_ERR_STATUS(x)	(((x) & GENMASK(31, 28)) >> 28)
+#define RESPONSE_NO_ERROR		0
+#define RESPONSE_ERROR_CRC		1
+#define RESPONSE_ERROR_PARITY		2
+#define RESPONSE_ERROR_FRAME		3
+#define RESPONSE_ERROR_IBA_NACK		4
+#define RESPONSE_ERROR_ADDRESS_NACK	5
+#define RESPONSE_ERROR_OVER_UNDER_FLOW	6
+#define RESPONSE_ERROR_TRANSF_ABORT	8
+#define RESPONSE_ERROR_I2C_W_NACK_ERR	9
+#define RESPONSE_PORT_TID(x)		(((x) & GENMASK(27, 24)) >> 24)
+#define RESPONSE_PORT_DATA_LEN(x)	((x) & GENMASK(15, 0))
+
+#define RX_TX_DATA_PORT			0x14
+#define IBI_QUEUE_STATUS		0x18
+#define QUEUE_THLD_CTRL			0x1c
+#define QUEUE_THLD_CTRL_RESP_BUF_MASK	GENMASK(15, 8)
+#define QUEUE_THLD_CTRL_RESP_BUF(x)	(((x) - 1) << 8)
+
+#define DATA_BUFFER_THLD_CTRL		0x20
+#define DATA_BUFFER_THLD_CTRL_RX_BUF	GENMASK(11, 8)
+
+#define IBI_QUEUE_CTRL			0x24
+#define IBI_MR_REQ_REJECT		0x2C
+#define IBI_SIR_REQ_REJECT		0x30
+#define IBI_REQ_REJECT_ALL		GENMASK(31, 0)
+
+#define RESET_CTRL			0x34
+#define RESET_CTRL_IBI_QUEUE		BIT(5)
+#define RESET_CTRL_RX_FIFO		BIT(4)
+#define RESET_CTRL_TX_FIFO		BIT(3)
+#define RESET_CTRL_RESP_QUEUE		BIT(2)
+#define RESET_CTRL_CMD_QUEUE		BIT(1)
+#define RESET_CTRL_SOFT			BIT(0)
+
+#define SLV_EVENT_CTRL			0x38
+#define INTR_STATUS			0x3c
+#define INTR_STATUS_EN			0x40
+#define INTR_SIGNAL_EN			0x44
+#define INTR_FORCE			0x48
+#define INTR_BUSOWNER_UPDATE_STAT	BIT(13)
+#define INTR_IBI_UPDATED_STAT		BIT(12)
+#define INTR_READ_REQ_RECV_STAT		BIT(11)
+#define INTR_DEFSLV_STAT		BIT(10)
+#define INTR_TRANSFER_ERR_STAT		BIT(9)
+#define INTR_DYN_ADDR_ASSGN_STAT	BIT(8)
+#define INTR_CCC_UPDATED_STAT		BIT(6)
+#define INTR_TRANSFER_ABORT_STAT	BIT(5)
+#define INTR_RESP_READY_STAT		BIT(4)
+#define INTR_CMD_QUEUE_READY_STAT	BIT(3)
+#define INTR_IBI_THLD_STAT		BIT(2)
+#define INTR_RX_THLD_STAT		BIT(1)
+#define INTR_TX_THLD_STAT		BIT(0)
+#define INTR_ALL			(INTR_BUSOWNER_UPDATE_STAT |	\
+					INTR_IBI_UPDATED_STAT |		\
+					INTR_READ_REQ_RECV_STAT |	\
+					INTR_DEFSLV_STAT |		\
+					INTR_TRANSFER_ERR_STAT |	\
+					INTR_DYN_ADDR_ASSGN_STAT |	\
+					INTR_CCC_UPDATED_STAT |		\
+					INTR_TRANSFER_ABORT_STAT |	\
+					INTR_RESP_READY_STAT |		\
+					INTR_CMD_QUEUE_READY_STAT |	\
+					INTR_IBI_THLD_STAT |		\
+					INTR_TX_THLD_STAT |		\
+					INTR_RX_THLD_STAT)
+
+#define INTR_MASTER_MASK		(INTR_TRANSFER_ERR_STAT |	\
+					 INTR_RESP_READY_STAT)
+
+#define QUEUE_STATUS_LEVEL		0x4c
+#define QUEUE_STATUS_IBI_STATUS_CNT(x)	(((x) & GENMASK(28, 24)) >> 24)
+#define QUEUE_STATUS_IBI_BUF_BLR(x)	(((x) & GENMASK(23, 16)) >> 16)
+#define QUEUE_STATUS_LEVEL_RESP(x)	(((x) & GENMASK(15, 8)) >> 8)
+#define QUEUE_STATUS_LEVEL_CMD(x)	((x) & GENMASK(7, 0))
+
+#define DATA_BUFFER_STATUS_LEVEL	0x50
+#define DATA_BUFFER_STATUS_LEVEL_TX(x)	((x) & GENMASK(7, 0))
+
+#define PRESENT_STATE			0x54
+#define CCC_DEVICE_STATUS		0x58
+#define DEVICE_ADDR_TABLE_POINTER	0x5c
+#define DEVICE_ADDR_TABLE_DEPTH(x)	(((x) & GENMASK(31, 16)) >> 16)
+#define DEVICE_ADDR_TABLE_ADDR(x)	((x) & GENMASK(7, 0))
+
+#define DEV_CHAR_TABLE_POINTER		0x60
+#define VENDOR_SPECIFIC_REG_POINTER	0x6c
+#define SLV_PID_VALUE			0x74
+#define SLV_CHAR_CTRL			0x78
+#define SLV_MAX_LEN			0x7c
+#define MAX_READ_TURNAROUND		0x80
+#define MAX_DATA_SPEED			0x84
+#define SLV_DEBUG_STATUS		0x88
+#define SLV_INTR_REQ			0x8c
+#define DEVICE_CTRL_EXTENDED		0xb0
+#define SCL_I3C_OD_TIMING		0xb4
+#define SCL_I3C_PP_TIMING		0xb8
+#define SCL_I3C_TIMING_HCNT(x)		(((x) << 16) & GENMASK(23, 16))
+#define SCL_I3C_TIMING_LCNT(x)		((x) & GENMASK(7, 0))
+#define SCL_I3C_TIMING_CNT_MIN		5
+
+#define SCL_I2C_FM_TIMING		0xbc
+#define SCL_I2C_FM_TIMING_HCNT(x)	(((x) << 16) & GENMASK(31, 16))
+#define SCL_I2C_FM_TIMING_LCNT(x)	((x) & GENMASK(15, 0))
+
+#define SCL_I2C_FMP_TIMING		0xc0
+#define SCL_I2C_FMP_TIMING_HCNT(x)	(((x) << 16) & GENMASK(23, 16))
+#define SCL_I2C_FMP_TIMING_LCNT(x)	((x) & GENMASK(15, 0))
+
+#define SCL_EXT_LCNT_TIMING		0xc8
+#define SCL_EXT_LCNT_4(x)		(((x) << 24) & GENMASK(31, 24))
+#define SCL_EXT_LCNT_3(x)		(((x) << 16) & GENMASK(23, 16))
+#define SCL_EXT_LCNT_2(x)		(((x) << 8) & GENMASK(15, 8))
+#define SCL_EXT_LCNT_1(x)		((x) & GENMASK(7, 0))
+
+#define SCL_EXT_TERMN_LCNT_TIMING	0xcc
+#define BUS_FREE_TIMING			0xd4
+#define BUS_I3C_MST_FREE(x)		((x) & GENMASK(15, 0))
+
+#define BUS_IDLE_TIMING			0xd8
+#define I3C_VER_ID			0xe0
+#define I3C_VER_TYPE			0xe4
+#define EXTENDED_CAPABILITY		0xe8
+#define SLAVE_CONFIG			0xec
+
+#define DEV_ADDR_TABLE_LEGACY_I2C_DEV	BIT(31)
+#define DEV_ADDR_TABLE_DYNAMIC_ADDR(x)	(((x) << 16) & GENMASK(23, 16))
+#define DEV_ADDR_TABLE_STATIC_ADDR(x)	((x) & GENMASK(6, 0))
+#define DEV_ADDR_TABLE_LOC(start, idx)	((start) + ((idx) << 2))
+
+#define MAX_DEVS 32
+
+#define I3C_BUS_SDR1_SCL_RATE		8000000
+#define I3C_BUS_SDR2_SCL_RATE		6000000
+#define I3C_BUS_SDR3_SCL_RATE		4000000
+#define I3C_BUS_SDR4_SCL_RATE		2000000
+#define I3C_BUS_I2C_FM_TLOW_MIN_NS	1300
+#define I3C_BUS_I2C_FMP_TLOW_MIN_NS	500
+#define I3C_BUS_THIGH_MAX_NS		41
+
+#define XFER_TIMEOUT (msecs_to_jiffies(1000))
+#define readl_poll_timeout_atomic readl_poll_sleep_timeout
+#define STRUCT_SZ(struct, count)  (sizeof(struct) * (count))
+
+#define I3C_MSG_READ	1
+#define I3C_MSG_WRITE	0
+#define POLL_SUCCESS	0
+
+struct dw_i3c_master_caps {
+	u8 cmdfifodepth;
+	u8 datafifodepth;
+};
+
+struct dw_i3c_cmd {
+	u32 cmd_lo;
+	u32 cmd_hi;
+	u16 tx_len;
+	const void *tx_buf;
+	u16 rx_len;
+	void *rx_buf;
+	u8 error;
+};
+
+struct dw_i3c_xfer {
+	struct list_head node;
+	int ret;
+	unsigned int ncmds;
+	struct dw_i3c_cmd cmds[16];
+};
+
+struct dw_i3c_master {
+	struct i3c_master_controller base;
+	u16 maxdevs;
+	u16 datstartaddr;
+	u32 free_pos;
+	struct {
+		struct list_head list;
+		struct dw_i3c_xfer *cur;
+		spinlock_t lock; /* spinlock for i3c transfer */
+	} xferqueue;
+	struct dw_i3c_master_caps caps;
+	void __iomem *regs;
+	struct reset_ctl_bulk resets;
+	struct clk core_clk;
+	char version[5];
+	char type[5];
+	u8 addrs[MAX_DEVS];
+};
+
+struct dw_i3c_i2c_dev_data {
+	u8 index;
+};
+
+#endif /*_DW_I3C_H_*/
diff --git a/include/linux/i3c/ccc.h b/include/linux/i3c/ccc.h
new file mode 100644
index 00000000000..73b0982cc51
--- /dev/null
+++ b/include/linux/i3c/ccc.h
@@ -0,0 +1,385 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <boris.brezillon@bootlin.com>
+ */
+
+#ifndef I3C_CCC_H
+#define I3C_CCC_H
+
+#include <linux/bitops.h>
+#include <linux/i3c/device.h>
+
+/* I3C CCC (Common Command Codes) related definitions */
+#define I3C_CCC_DIRECT			BIT(7)
+
+#define I3C_CCC_ID(id, broadcast)	\
+	((id) | ((broadcast) ? 0 : I3C_CCC_DIRECT))
+
+/* Commands valid in both broadcast and unicast modes */
+#define I3C_CCC_ENEC(broadcast)		I3C_CCC_ID(0x0, broadcast)
+#define I3C_CCC_DISEC(broadcast)	I3C_CCC_ID(0x1, broadcast)
+#define I3C_CCC_ENTAS(as, broadcast)	I3C_CCC_ID(0x2 + (as), broadcast)
+#define I3C_CCC_RSTDAA(broadcast)	I3C_CCC_ID(0x6, broadcast)
+#define I3C_CCC_SETMWL(broadcast)	I3C_CCC_ID(0x9, broadcast)
+#define I3C_CCC_SETMRL(broadcast)	I3C_CCC_ID(0xa, broadcast)
+#define I3C_CCC_SETXTIME(broadcast)	((broadcast) ? 0x28 : 0x98)
+#define I3C_CCC_VENDOR(id, broadcast)	((id) + ((broadcast) ? 0x61 : 0xe0))
+
+/* Broadcast-only commands */
+#define I3C_CCC_ENTDAA			I3C_CCC_ID(0x7, true)
+#define I3C_CCC_DEFSLVS			I3C_CCC_ID(0x8, true)
+#define I3C_CCC_ENTTM			I3C_CCC_ID(0xb, true)
+#define I3C_CCC_ENTHDR(x)		I3C_CCC_ID(0x20 + (x), true)
+
+/* Unicast-only commands */
+#define I3C_CCC_SETDASA			I3C_CCC_ID(0x7, false)
+#define I3C_CCC_SETNEWDA		I3C_CCC_ID(0x8, false)
+#define I3C_CCC_GETMWL			I3C_CCC_ID(0xb, false)
+#define I3C_CCC_GETMRL			I3C_CCC_ID(0xc, false)
+#define I3C_CCC_GETPID			I3C_CCC_ID(0xd, false)
+#define I3C_CCC_GETBCR			I3C_CCC_ID(0xe, false)
+#define I3C_CCC_GETDCR			I3C_CCC_ID(0xf, false)
+#define I3C_CCC_GETSTATUS		I3C_CCC_ID(0x10, false)
+#define I3C_CCC_GETACCMST		I3C_CCC_ID(0x11, false)
+#define I3C_CCC_SETBRGTGT		I3C_CCC_ID(0x13, false)
+#define I3C_CCC_GETMXDS			I3C_CCC_ID(0x14, false)
+#define I3C_CCC_GETHDRCAP		I3C_CCC_ID(0x15, false)
+#define I3C_CCC_GETXTIME		I3C_CCC_ID(0x19, false)
+
+#define I3C_CCC_EVENT_SIR		BIT(0)
+#define I3C_CCC_EVENT_MR		BIT(1)
+#define I3C_CCC_EVENT_HJ		BIT(3)
+
+/**
+ * struct i3c_ccc_events - payload passed to ENEC/DISEC CCC
+ *
+ * @events: bitmask of I3C_CCC_EVENT_xxx events.
+ *
+ * Depending on the CCC command, the specific events coming from all devices
+ * (broadcast version) or a specific device (unicast version) will be
+ * enabled (ENEC) or disabled (DISEC).
+ */
+struct i3c_ccc_events {
+	u8 events;
+};
+
+/**
+ * struct i3c_ccc_mwl - payload passed to SETMWL/GETMWL CCC
+ *
+ * @len: maximum write length in bytes
+ *
+ * The maximum write length is only applicable to SDR private messages or
+ * extended Write CCCs (like SETXTIME).
+ */
+struct i3c_ccc_mwl {
+	__be16 len;
+};
+
+/**
+ * struct i3c_ccc_mrl - payload passed to SETMRL/GETMRL CCC
+ *
+ * @len: maximum read length in bytes
+ * @ibi_len: maximum IBI payload length
+ *
+ * The maximum read length is only applicable to SDR private messages or
+ * extended Read CCCs (like GETXTIME).
+ * The IBI length is only valid if the I3C slave is IBI capable
+ * (%I3C_BCR_IBI_REQ_CAP is set).
+ */
+struct i3c_ccc_mrl {
+	__be16 read_len;
+	u8 ibi_len;
+} __packed;
+
+/**
+ * struct i3c_ccc_dev_desc - I3C/I2C device descriptor used for DEFSLVS
+ *
+ * @dyn_addr: dynamic address assigned to the I3C slave or 0 if the entry is
+ *	      describing an I2C slave.
+ * @dcr: DCR value (not applicable to entries describing I2C devices)
+ * @lvr: LVR value (not applicable to entries describing I3C devices)
+ * @bcr: BCR value or 0 if this entry is describing an I2C slave
+ * @static_addr: static address or 0 if the device does not have a static
+ *		 address
+ *
+ * The DEFSLVS command should be passed an array of i3c_ccc_dev_desc
+ * descriptors (one entry per I3C/I2C dev controlled by the master).
+ */
+struct i3c_ccc_dev_desc {
+	u8 dyn_addr;
+	union {
+		u8 dcr;
+		u8 lvr;
+	};
+	u8 bcr;
+	u8 static_addr;
+};
+
+/**
+ * struct i3c_ccc_defslvs - payload passed to DEFSLVS CCC
+ *
+ * @count: number of dev descriptors
+ * @master: descriptor describing the current master
+ * @slaves: array of descriptors describing slaves controlled by the
+ *	    current master
+ *
+ * Information passed to the broadcast DEFSLVS to propagate device
+ * information to all masters currently acting as slaves on the bus.
+ * This is only meaningful if you have more than one master.
+ */
+struct i3c_ccc_defslvs {
+	u8 count;
+	struct i3c_ccc_dev_desc master;
+	struct i3c_ccc_dev_desc slaves[0];
+} __packed;
+
+/**
+ * enum i3c_ccc_test_mode - enum listing all available test modes
+ *
+ * @I3C_CCC_EXIT_TEST_MODE: exit test mode
+ * @I3C_CCC_VENDOR_TEST_MODE: enter vendor test mode
+ */
+enum i3c_ccc_test_mode {
+	I3C_CCC_EXIT_TEST_MODE,
+	I3C_CCC_VENDOR_TEST_MODE,
+};
+
+/**
+ * struct i3c_ccc_enttm - payload passed to ENTTM CCC
+ *
+ * @mode: one of the &enum i3c_ccc_test_mode modes
+ *
+ * Information passed to the ENTTM CCC to instruct an I3C device to enter a
+ * specific test mode.
+ */
+struct i3c_ccc_enttm {
+	u8 mode;
+};
+
+/**
+ * struct i3c_ccc_setda - payload passed to SETNEWDA and SETDASA CCCs
+ *
+ * @addr: dynamic address to assign to an I3C device
+ *
+ * Information passed to the SETNEWDA and SETDASA CCCs to assign/change the
+ * dynamic address of an I3C device.
+ */
+struct i3c_ccc_setda {
+	u8 addr;
+};
+
+/**
+ * struct i3c_ccc_getpid - payload passed to GETPID CCC
+ *
+ * @pid: 48 bits PID in big endian
+ */
+struct i3c_ccc_getpid {
+	u8 pid[6];
+};
+
+/**
+ * struct i3c_ccc_getbcr - payload passed to GETBCR CCC
+ *
+ * @bcr: BCR (Bus Characteristic Register) value
+ */
+struct i3c_ccc_getbcr {
+	u8 bcr;
+};
+
+/**
+ * struct i3c_ccc_getdcr - payload passed to GETDCR CCC
+ *
+ * @dcr: DCR (Device Characteristic Register) value
+ */
+struct i3c_ccc_getdcr {
+	u8 dcr;
+};
+
+#define I3C_CCC_STATUS_PENDING_INT(status)	((status) & GENMASK(3, 0))
+#define I3C_CCC_STATUS_PROTOCOL_ERROR		BIT(5)
+#define I3C_CCC_STATUS_ACTIVITY_MODE(status)	\
+	(((status) & GENMASK(7, 6)) >> 6)
+
+/**
+ * struct i3c_ccc_getstatus - payload passed to GETSTATUS CCC
+ *
+ * @status: status of the I3C slave (see I3C_CCC_STATUS_xxx macros for more
+ *	    information).
+ */
+struct i3c_ccc_getstatus {
+	__be16 status;
+};
+
+/**
+ * struct i3c_ccc_getaccmst - payload passed to GETACCMST CCC
+ *
+ * @newmaster: address of the master taking bus ownership
+ */
+struct i3c_ccc_getaccmst {
+	u8 newmaster;
+};
+
+/**
+ * struct i3c_ccc_bridged_slave_desc - bridged slave descriptor
+ *
+ * @addr: dynamic address of the bridged device
+ * @id: ID of the slave device behind the bridge
+ */
+struct i3c_ccc_bridged_slave_desc {
+	u8 addr;
+	__be16 id;
+} __packed;
+
+/**
+ * struct i3c_ccc_setbrgtgt - payload passed to SETBRGTGT CCC
+ *
+ * @count: number of bridged slaves
+ * @bslaves: bridged slave descriptors
+ */
+struct i3c_ccc_setbrgtgt {
+	u8 count;
+	struct i3c_ccc_bridged_slave_desc bslaves[0];
+} __packed;
+
+/**
+ * enum i3c_sdr_max_data_rate - max data rate values for private SDR transfers
+ */
+enum i3c_sdr_max_data_rate {
+	I3C_SDR0_FSCL_MAX,
+	I3C_SDR1_FSCL_8MHZ,
+	I3C_SDR2_FSCL_6MHZ,
+	I3C_SDR3_FSCL_4MHZ,
+	I3C_SDR4_FSCL_2MHZ,
+};
+
+/**
+ * enum i3c_tsco - clock to data turn-around
+ */
+enum i3c_tsco {
+	I3C_TSCO_8NS,
+	I3C_TSCO_9NS,
+	I3C_TSCO_10NS,
+	I3C_TSCO_11NS,
+	I3C_TSCO_12NS,
+};
+
+#define I3C_CCC_MAX_SDR_FSCL_MASK	GENMASK(2, 0)
+#define I3C_CCC_MAX_SDR_FSCL(x)		((x) & I3C_CCC_MAX_SDR_FSCL_MASK)
+
+/**
+ * struct i3c_ccc_getmxds - payload passed to GETMXDS CCC
+ *
+ * @maxwr: write limitations
+ * @maxrd: read limitations
+ * @maxrdturn: maximum read turn-around expressed micro-seconds and
+ *	       little-endian formatted
+ */
+struct i3c_ccc_getmxds {
+	u8 maxwr;
+	u8 maxrd;
+	u8 maxrdturn[3];
+} __packed;
+
+#define I3C_CCC_HDR_MODE(mode)		BIT(mode)
+
+/**
+ * struct i3c_ccc_gethdrcap - payload passed to GETHDRCAP CCC
+ *
+ * @modes: bitmap of supported HDR modes
+ */
+struct i3c_ccc_gethdrcap {
+	u8 modes;
+} __packed;
+
+/**
+ * enum i3c_ccc_setxtime_subcmd - SETXTIME sub-commands
+ */
+enum i3c_ccc_setxtime_subcmd {
+	I3C_CCC_SETXTIME_ST = 0x7f,
+	I3C_CCC_SETXTIME_DT = 0xbf,
+	I3C_CCC_SETXTIME_ENTER_ASYNC_MODE0 = 0xdf,
+	I3C_CCC_SETXTIME_ENTER_ASYNC_MODE1 = 0xef,
+	I3C_CCC_SETXTIME_ENTER_ASYNC_MODE2 = 0xf7,
+	I3C_CCC_SETXTIME_ENTER_ASYNC_MODE3 = 0xfb,
+	I3C_CCC_SETXTIME_ASYNC_TRIGGER = 0xfd,
+	I3C_CCC_SETXTIME_TPH = 0x3f,
+	I3C_CCC_SETXTIME_TU = 0x9f,
+	I3C_CCC_SETXTIME_ODR = 0x8f,
+};
+
+/**
+ * struct i3c_ccc_setxtime - payload passed to SETXTIME CCC
+ *
+ * @subcmd: one of the sub-commands ddefined in &enum i3c_ccc_setxtime_subcmd
+ * @data: sub-command payload. Amount of data is determined by
+ *	  &i3c_ccc_setxtime->subcmd
+ */
+struct i3c_ccc_setxtime {
+	u8 subcmd;
+	u8 data[0];
+} __packed;
+
+#define I3C_CCC_GETXTIME_SYNC_MODE	BIT(0)
+#define I3C_CCC_GETXTIME_ASYNC_MODE(x)	BIT((x) + 1)
+#define I3C_CCC_GETXTIME_OVERFLOW	BIT(7)
+
+/**
+ * struct i3c_ccc_getxtime - payload retrieved from GETXTIME CCC
+ *
+ * @supported_modes: bitmap describing supported XTIME modes
+ * @state: current status (enabled mode and overflow status)
+ * @frequency: slave's internal oscillator frequency in 500KHz steps
+ * @inaccuracy: slave's internal oscillator inaccuracy in 0.1% steps
+ */
+struct i3c_ccc_getxtime {
+	u8 supported_modes;
+	u8 state;
+	u8 frequency;
+	u8 inaccuracy;
+} __packed;
+
+/**
+ * struct i3c_ccc_cmd_payload - CCC payload
+ *
+ * @len: payload length
+ * @data: payload data. This buffer must be DMA-able
+ */
+struct i3c_ccc_cmd_payload {
+	u16 len;
+	void *data;
+};
+
+/**
+ * struct i3c_ccc_cmd_dest - CCC command destination
+ *
+ * @addr: can be an I3C device address or the broadcast address if this is a
+ *	  broadcast CCC
+ * @payload: payload to be sent to this device or broadcasted
+ */
+struct i3c_ccc_cmd_dest {
+	u8 addr;
+	struct i3c_ccc_cmd_payload payload;
+};
+
+/**
+ * struct i3c_ccc_cmd - CCC command
+ *
+ * @rnw: true if the CCC should retrieve data from the device. Only valid for
+ *	 unicast commands
+ * @id: CCC command id
+ * @ndests: number of destinations. Should always be one for broadcast commands
+ * @dests: array of destinations and associated payload for this CCC. Most of
+ *	   the time, only one destination is provided
+ * @err: I3C error code
+ */
+struct i3c_ccc_cmd {
+	u8 rnw;
+	u8 id;
+	unsigned int ndests;
+	struct i3c_ccc_cmd_dest *dests;
+	enum i3c_error_code err;
+};
+
+#endif /* I3C_CCC_H */
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
new file mode 100644
index 00000000000..9d4b472b869
--- /dev/null
+++ b/include/linux/i3c/device.h
@@ -0,0 +1,286 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <boris.brezillon@bootlin.com>
+ */
+
+#ifndef I3C_DEV_H
+#define I3C_DEV_H
+
+#include <dm/device.h>
+#include <i2c.h>
+#include <linux/bitops.h>
+#include <linux/compat.h>
+
+/**
+ * enum i3c_error_code - I3C error codes
+ *
+ * These are the standard error codes as defined by the I3C specification.
+ * When -EIO is returned by the i3c_device_do_priv_xfers() or
+ * i3c_device_send_hdr_cmds() one can check the error code in
+ * &struct_i3c_priv_xfer.err or &struct i3c_hdr_cmd.err to get a better idea of
+ * what went wrong.
+ *
+ * @I3C_ERROR_UNKNOWN: unknown error, usually means the error is not I3C
+ *		       related
+ * @I3C_ERROR_M0: M0 error
+ * @I3C_ERROR_M1: M1 error
+ * @I3C_ERROR_M2: M2 error
+ */
+enum i3c_error_code {
+	I3C_ERROR_UNKNOWN = 0,
+	I3C_ERROR_M0 = 1,
+	I3C_ERROR_M1,
+	I3C_ERROR_M2,
+};
+
+/**
+ * enum i3c_hdr_mode - HDR mode ids
+ * @I3C_HDR_DDR: DDR mode
+ * @I3C_HDR_TSP: TSP mode
+ * @I3C_HDR_TSL: TSL mode
+ */
+enum i3c_hdr_mode {
+	I3C_HDR_DDR,
+	I3C_HDR_TSP,
+	I3C_HDR_TSL,
+};
+
+/**
+ * struct i3c_priv_xfer - I3C SDR private transfer
+ * @rnw: encodes the transfer direction. true for a read, false for a write
+ * @len: transfer length in bytes of the transfer
+ * @data: input/output buffer
+ * @data.in: input buffer. Must point to a DMA-able buffer
+ * @data.out: output buffer. Must point to a DMA-able buffer
+ * @err: I3C error code
+ */
+struct i3c_priv_xfer {
+	u8 rnw;
+	u16 len;
+	union {
+		void *in;
+		const void *out;
+	} data;
+	enum i3c_error_code err;
+};
+
+/**
+ * enum i3c_dcr - I3C DCR values
+ * @I3C_DCR_GENERIC_DEVICE: generic I3C device
+ */
+enum i3c_dcr {
+	I3C_DCR_GENERIC_DEVICE = 0,
+};
+
+#define I3C_PID_MANUF_ID(pid)		(((pid) & GENMASK_ULL(47, 33)) >> 33)
+#define I3C_PID_RND_LOWER_32BITS(pid)	(!!((pid) & BIT_ULL(32)))
+#define I3C_PID_RND_VAL(pid)		((pid) & GENMASK_ULL(31, 0))
+#define I3C_PID_PART_ID(pid)		(((pid) & GENMASK_ULL(31, 16)) >> 16)
+#define I3C_PID_INSTANCE_ID(pid)	(((pid) & GENMASK_ULL(15, 12)) >> 12)
+#define I3C_PID_EXTRA_INFO(pid)		((pid) & GENMASK_ULL(11, 0))
+
+#define I3C_BCR_DEVICE_ROLE(bcr)	((bcr) & GENMASK(7, 6))
+#define I3C_BCR_I3C_SLAVE		(0 << 6)
+#define I3C_BCR_I3C_MASTER		BIT(6)
+#define I3C_BCR_HDR_CAP			BIT(5)
+#define I3C_BCR_BRIDGE			BIT(4)
+#define I3C_BCR_OFFLINE_CAP		BIT(3)
+#define I3C_BCR_IBI_PAYLOAD		BIT(2)
+#define I3C_BCR_IBI_REQ_CAP		BIT(1)
+#define I3C_BCR_MAX_DATA_SPEED_LIM	BIT(0)
+
+/* To determine what functionality is present */
+
+#define I2C_FUNC_I2C			0x00000001
+#define I2C_FUNC_10BIT_ADDR		0x00000002 /* required for I2C_M_TEN */
+#define I2C_FUNC_PROTOCOL_MANGLING	0x00000004 /* required for I2C_M_IGNORE_NAK etc. */
+#define I2C_FUNC_SMBUS_PEC		0x00000008
+#define I2C_FUNC_NOSTART		0x00000010 /* required for I2C_M_NOSTART */
+#define I2C_FUNC_SLAVE			0x00000020
+#define I2C_FUNC_SMBUS_BLOCK_PROC_CALL	0x00008000 /* SMBus 2.0 or later */
+#define I2C_FUNC_SMBUS_QUICK		0x00010000
+#define I2C_FUNC_SMBUS_READ_BYTE	0x00020000
+#define I2C_FUNC_SMBUS_WRITE_BYTE	0x00040000
+#define I2C_FUNC_SMBUS_READ_BYTE_DATA	0x00080000
+#define I2C_FUNC_SMBUS_WRITE_BYTE_DATA	0x00100000
+#define I2C_FUNC_SMBUS_READ_WORD_DATA	0x00200000
+#define I2C_FUNC_SMBUS_WRITE_WORD_DATA	0x00400000
+#define I2C_FUNC_SMBUS_PROC_CALL	0x00800000
+#define I2C_FUNC_SMBUS_READ_BLOCK_DATA	0x01000000 /* required for I2C_M_RECV_LEN */
+#define I2C_FUNC_SMBUS_WRITE_BLOCK_DATA 0x02000000
+#define I2C_FUNC_SMBUS_READ_I2C_BLOCK	0x04000000 /* I2C-like block xfer  */
+#define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK	0x08000000 /* w/ 1-byte reg. addr. */
+#define I2C_FUNC_SMBUS_HOST_NOTIFY	0x10000000 /* SMBus 2.0 or later */
+
+#define I2C_FUNC_SMBUS_BYTE		(I2C_FUNC_SMBUS_READ_BYTE | \
+					 I2C_FUNC_SMBUS_WRITE_BYTE)
+#define I2C_FUNC_SMBUS_BYTE_DATA	(I2C_FUNC_SMBUS_READ_BYTE_DATA | \
+					 I2C_FUNC_SMBUS_WRITE_BYTE_DATA)
+#define I2C_FUNC_SMBUS_WORD_DATA	(I2C_FUNC_SMBUS_READ_WORD_DATA | \
+					 I2C_FUNC_SMBUS_WRITE_WORD_DATA)
+#define I2C_FUNC_SMBUS_BLOCK_DATA	(I2C_FUNC_SMBUS_READ_BLOCK_DATA | \
+					 I2C_FUNC_SMBUS_WRITE_BLOCK_DATA)
+#define I2C_FUNC_SMBUS_I2C_BLOCK	(I2C_FUNC_SMBUS_READ_I2C_BLOCK | \
+					 I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)
+
+#define I2C_FUNC_SMBUS_EMUL		(I2C_FUNC_SMBUS_QUICK | \
+					 I2C_FUNC_SMBUS_BYTE | \
+					 I2C_FUNC_SMBUS_BYTE_DATA | \
+					 I2C_FUNC_SMBUS_WORD_DATA | \
+					 I2C_FUNC_SMBUS_PROC_CALL | \
+					 I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | \
+					 I2C_FUNC_SMBUS_I2C_BLOCK | \
+					 I2C_FUNC_SMBUS_PEC)
+
+/**
+ * struct i3c_device_info - I3C device information
+ * @pid: Provisional ID
+ * @bcr: Bus Characteristic Register
+ * @dcr: Device Characteristic Register
+ * @static_addr: static/I2C address
+ * @dyn_addr: dynamic address
+ * @hdr_cap: supported HDR modes
+ * @max_read_ds: max read speed information
+ * @max_write_ds: max write speed information
+ * @max_ibi_len: max IBI payload length
+ * @max_read_turnaround: max read turn-around time in micro-seconds
+ * @max_read_len: max private SDR read length in bytes
+ * @max_write_len: max private SDR write length in bytes
+ *
+ * These are all basic information that should be advertised by an I3C device.
+ * Some of them are optional depending on the device type and device
+ * capabilities.
+ * For each I3C slave attached to a master with
+ * i3c_master_add_i3c_dev_locked(), the core will send the relevant CCC command
+ * to retrieve these data.
+ */
+struct i3c_device_info {
+	u64 pid;
+	u8 bcr;
+	u8 dcr;
+	u8 static_addr;
+	u8 dyn_addr;
+	u8 hdr_cap;
+	u8 max_read_ds;
+	u8 max_write_ds;
+	u8 max_ibi_len;
+	u32 max_read_turnaround;
+	u16 max_read_len;
+	u16 max_write_len;
+};
+
+/*
+ * I3C device internals are kept hidden from I3C device users. It's just
+ * simpler to refactor things when everything goes through getter/setters, and
+ * I3C device drivers should not have to worry about internal representation
+ * anyway.
+ */
+struct i3c_device;
+
+/* These macros should be used to i3c_device_id entries. */
+#define I3C_MATCH_MANUF_AND_PART (I3C_MATCH_MANUF | I3C_MATCH_PART)
+
+#define I3C_DEVICE(_manufid, _partid, _drvdata)				\
+	{								\
+		.match_flags = I3C_MATCH_MANUF_AND_PART,		\
+		.manuf_id = _manufid,					\
+		.part_id = _partid,					\
+		.data = _drvdata,					\
+	}
+
+#define I3C_DEVICE_EXTRA_INFO(_manufid, _partid, _info, _drvdata)	\
+	{								\
+		.match_flags = I3C_MATCH_MANUF_AND_PART |		\
+			       I3C_MATCH_EXTRA_INFO,			\
+		.manuf_id = _manufid,					\
+		.part_id = _partid,					\
+		.extra_info = _info,					\
+		.data = _drvdata,					\
+	}
+
+#define I3C_CLASS(_dcr, _drvdata)					\
+	{								\
+		.match_flags = I3C_MATCH_DCR,				\
+		.dcr = _dcr,						\
+	}
+
+/**
+ * struct i3c_driver - I3C device driver
+ * @driver: inherit from driver
+ * @probe: I3C device probe method
+ * @remove: I3C device remove method
+ * @id_table: I3C device match table. Will be used by the framework to decide
+ *	      which device to bind to this driver
+ */
+struct i3c_driver {
+	struct driver driver;
+	int (*probe)(struct i3c_device *dev);
+	void (*remove)(struct i3c_device *dev);
+	const struct i3c_device_id *id_table;
+};
+
+static inline struct i3c_driver *drv_to_i3cdrv(const struct driver *drv)
+{
+	return container_of(drv, struct i3c_driver, driver);
+}
+
+struct udevice *i3cdev_to_dev(struct i3c_device *i3cdev);
+struct i3c_device *dev_to_i3cdev(struct udevice *dev);
+
+const struct i3c_device_id *
+i3c_device_match_id(struct i3c_device *i3cdev,
+		    const struct i3c_device_id *id_table);
+
+/**
+ * module_i3c_i2c_driver() - Register a module providing an I3C and an I2C
+ *			     driver
+ * @__i3cdrv: the I3C driver to register
+ * @__i2cdrv: the I3C driver to register
+ *
+ * Provide generic init/exit functions that simply register/unregister an I3C
+ * and an I2C driver.
+ * This macro can be used even if CONFIG_I3C is disabled, in this case, only
+ * the I2C driver will be registered.
+ * Should be used by any driver that does not require extra init/cleanup steps.
+ */
+#define module_i3c_i2c_driver(__i3cdrv, __i2cdrv)	\
+	module_driver(__i3cdrv,				\
+		      i3c_i2c_driver_register,		\
+		      i3c_i2c_driver_unregister)
+
+void i3c_device_get_info(struct i3c_device *dev, struct i3c_device_info *info);
+
+struct i3c_ibi_payload {
+	unsigned int len;
+	const void *data;
+};
+
+/**
+ * struct i3c_ibi_setup - IBI setup object
+ * @max_payload_len: maximum length of the payload associated to an IBI. If one
+ *		     IBI appears to have a payload that is bigger than this
+ *		     number, the IBI will be rejected.
+ * @num_slots: number of pre-allocated IBI slots. This should be chosen so that
+ *	       the system never runs out of IBI slots, otherwise you'll lose
+ *	       IBIs.
+ * @handler: IBI handler, every time an IBI is received. This handler is called
+ *	     in a workqueue context. It is allowed to sleep and send new
+ *	     messages on the bus, though it's recommended to keep the
+ *	     processing done there as fast as possible to avoid delaying
+ *	     processing of other queued on the same workqueue.
+ *
+ * Temporary structure used to pass information to i3c_device_request_ibi().
+ * This object can be allocated on the stack since i3c_device_request_ibi()
+ * copies every bit of information and do not use it after
+ * i3c_device_request_ibi() has returned.
+ */
+struct i3c_ibi_setup {
+	unsigned int max_payload_len;
+	unsigned int num_slots;
+	void (*handler)(struct i3c_device *dev,
+			const struct i3c_ibi_payload *payload);
+};
+
+#endif /* I3C_DEV_H */
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
new file mode 100644
index 00000000000..213de4ca06a
--- /dev/null
+++ b/include/linux/i3c/master.h
@@ -0,0 +1,697 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <boris.brezillon@bootlin.com>
+ */
+
+#ifndef I3C_MASTER_H
+#define I3C_MASTER_H
+
+#include <asm/bitops.h>
+#include <hwspinlock.h>
+#include <i2c.h>
+#include <linux/bitops.h>
+#include <linux/i3c/ccc.h>
+#include <linux/i3c/device.h>
+
+#define I3C_HOT_JOIN_ADDR		0x2
+#define I3C_BROADCAST_ADDR		0x7e
+#define I3C_MAX_ADDR			GENMASK(6, 0)
+
+struct i3c_master_controller;
+struct i3c_bus;
+struct i2c_device;
+struct i3c_device;
+
+/**
+ * struct i3c_i2c_dev_desc - Common part of the I3C/I2C device descriptor
+ * @node: node element used to insert the slot into the I2C or I3C device
+ *	  list
+ * @master: I3C master that instantiated this device. Will be used to do
+ *	    I2C/I3C transfers
+ * @master_priv: master private data assigned to the device. Can be used to
+ *		 add master specific information
+ *
+ * This structure is describing common I3C/I2C dev information.
+ */
+struct i3c_i2c_dev_desc {
+	struct list_head node;
+	struct i3c_master_controller *master;
+	void *master_priv;
+};
+
+#define I3C_LVR_I2C_INDEX_MASK		GENMASK(7, 5)
+#define I3C_LVR_I2C_INDEX(x)		((x) << 5)
+#define I3C_LVR_I2C_FM_MODE		BIT(4)
+
+#define I2C_MAX_ADDR			GENMASK(6, 0)
+#define I2C_NAME_SIZE	20
+#define I2C_MODULE_PREFIX "i2c:"
+#define I2C_CLIENT_TEN		0x10
+
+/**
+ * struct i2c_board_info - template for device creation
+ * @type: chip type, to initialize i2c_client.name
+ * @flags: to initialize i2c_client.flags
+ * @addr: stored in i2c_client.addr
+ * @dev_name: Overrides the default <busnr>-<addr> dev_name if set
+ * @platform_data: stored in i2c_client.dev.platform_data
+ * @of_node: pointer to OpenFirmware device node
+ * @fwnode: device node supplied by the platform firmware
+ * @swnode: software node for the device
+ * @resources: resources associated with the device
+ * @num_resources: number of resources in the @resources array
+ * @irq: stored in i2c_client.irq
+ *
+ * I2C doesn't actually support hardware probing, although controllers and
+ * devices may be able to use I2C_SMBUS_QUICK to tell whether or not there's
+ * a device at a given address.  Drivers commonly need more information than
+ * that, such as chip type, configuration, associated IRQ, and so on.
+ *
+ * i2c_board_info is used to build tables of information listing I2C devices
+ * that are present.  This information is used to grow the driver model tree.
+ * For mainboards this is done statically using i2c_register_board_info();
+ * bus numbers identify adapters that aren't yet available.  For add-on boards,
+ * i2c_new_client_device() does this dynamically with the adapter already known.
+ */
+struct i2c_board_info {
+	char		type[I2C_NAME_SIZE];
+	unsigned short	flags;
+	unsigned short	addr;
+	const char	*dev_name;
+	void		*platform_data;
+	struct device_node *of_node;
+};
+
+/**
+ * struct i2c_dev_boardinfo - I2C device board information
+ * @node: used to insert the boardinfo object in the I2C boardinfo list
+ * @base: regular I2C board information
+ * @lvr: LVR (Legacy Virtual Register) needed by the I3C core to know about
+ *	 the I2C device limitations
+ *
+ * This structure is used to attach board-level information to an I2C device.
+ * Each I2C device connected on the I3C bus should have one.
+ */
+struct i2c_dev_boardinfo {
+	struct list_head node;
+	struct i2c_board_info base;
+	u8 lvr;
+};
+
+/**
+ * struct i2c_dev_desc - I2C device descriptor
+ * @common: common part of the I2C device descriptor
+ * @boardinfo: pointer to the boardinfo attached to this I2C device
+ * @dev: I2C device object registered to the I2C framework
+ * @addr: I2C device address
+ * @lvr: LVR (Legacy Virtual Register) needed by the I3C core to know about
+ *	 the I2C device limitations
+ *
+ * Each I2C device connected on the bus will have an i2c_dev_desc.
+ * This object is created by the core and later attached to the controller
+ * using &struct_i3c_master_controller->ops->attach_i2c_dev().
+ *
+ * &struct_i2c_dev_desc is the internal representation of an I2C device
+ * connected on an I3C bus. This object is also passed to all
+ * &struct_i3c_master_controller_ops hooks.
+ */
+struct i2c_dev_desc {
+	struct i3c_i2c_dev_desc common;
+	const struct i2c_dev_boardinfo *boardinfo;
+	struct i2c_client *dev;
+	u16 addr;
+	u8 lvr;
+};
+
+/**
+ * struct i3c_ibi_slot - I3C IBI (In-Band Interrupt) slot
+ * @work: work associated to this slot. The IBI handler will be called from
+ *	  there
+ * @dev: the I3C device that has generated this IBI
+ * @len: length of the payload associated to this IBI
+ * @data: payload buffer
+ *
+ * An IBI slot is an object pre-allocated by the controller and used when an
+ * IBI comes in.
+ * Every time an IBI comes in, the I3C master driver should find a free IBI
+ * slot in its IBI slot pool, retrieve the IBI payload and queue the IBI using
+ * i3c_master_queue_ibi().
+ *
+ * How IBI slots are allocated is left to the I3C master driver, though, for
+ * simple kmalloc-based allocation, the generic IBI slot pool can be used.
+ */
+struct i3c_ibi_slot {
+	struct work_struct work;
+	struct i3c_dev_desc *dev;
+	unsigned int len;
+	void *data;
+};
+
+/**
+ * struct i3c_device_ibi_info - IBI information attached to a specific device
+ * @all_ibis_handled: used to be informed when no more IBIs are waiting to be
+ *		      processed. Used by i3c_device_disable_ibi() to wait for
+ *		      all IBIs to be dequeued
+ * @pending_ibis: count the number of pending IBIs. Each pending IBI has its
+ *		  work element queued to the controller workqueue
+ * @max_payload_len: maximum payload length for an IBI coming from this device.
+ *		     this value is specified when calling
+ *		     i3c_device_request_ibi() and should not change at run
+ *		     time. All messages IBIs exceeding this limit should be
+ *		     rejected by the master
+ * @num_slots: number of IBI slots reserved for this device
+ * @enabled: reflect the IBI status
+ * @handler: IBI handler specified at i3c_device_request_ibi() call time. This
+ *	     handler will be called from the controller workqueue, and as such
+ *	     is allowed to sleep (though it is recommended to process the IBI
+ *	     as fast as possible to not stall processing of other IBIs queued
+ *	     on the same workqueue).
+ *	     New I3C messages can be sent from the IBI handler
+ *
+ * The &struct_i3c_device_ibi_info object is allocated when
+ * i3c_device_request_ibi() is called and attached to a specific device. This
+ * object is here to manage IBIs coming from a specific I3C device.
+ *
+ * Note that this structure is the generic view of the IBI management
+ * infrastructure. I3C master drivers may have their own internal
+ * representation which they can associate to the device using
+ * controller-private data.
+ */
+struct i3c_device_ibi_info {
+	unsigned int max_payload_len;
+	unsigned int num_slots;
+	unsigned int enabled;
+	void (*handler)(struct i3c_device *dev,
+			const struct i3c_ibi_payload *payload);
+};
+
+/**
+ * struct i3c_dev_boardinfo - I3C device board information
+ * @node: used to insert the boardinfo object in the I3C boardinfo list
+ * @init_dyn_addr: initial dynamic address requested by the FW. We provide no
+ *		   guarantee that the device will end up using this address,
+ *		   but try our best to assign this specific address to the
+ *		   device
+ * @static_addr: static address the I3C device listen on before it's been
+ *		 assigned a dynamic address by the master. Will be used during
+ *		 bus initialization to assign it a specific dynamic address
+ *		 before starting DAA (Dynamic Address Assignment)
+ * @pid: I3C Provisional ID exposed by the device. This is a unique identifier
+ *	 that may be used to attach boardinfo to i3c_dev_desc when the device
+ *	 does not have a static address
+ * @of_node: optional DT node in case the device has been described in the DT
+ *
+ * This structure is used to attach board-level information to an I3C device.
+ * Not all I3C devices connected on the bus will have a boardinfo. It's only
+ * needed if you want to attach extra resources to a device or assign it a
+ * specific dynamic address.
+ */
+struct i3c_dev_boardinfo {
+	struct list_head node;
+	u8 init_dyn_addr;
+	u8 static_addr;
+	u64 pid;
+	struct device_node *of_node;
+};
+
+/**
+ * struct i3c_dev_desc - I3C device descriptor
+ * @common: common part of the I3C device descriptor
+ * @info: I3C device information. Will be automatically filled when you create
+ *	  your device with i3c_master_add_i3c_dev_locked()
+ * @ibi_lock: lock used to protect the &struct_i3c_device->ibi
+ * @ibi: IBI info attached to a device. Should be NULL until
+ *	 i3c_device_request_ibi() is called
+ * @dev: pointer to the I3C device object exposed to I3C device drivers. This
+ *	 should never be accessed from I3C master controller drivers. Only core
+ *	 code should manipulate it in when updating the dev <-> desc link or
+ *	 when propagating IBI events to the driver
+ * @boardinfo: pointer to the boardinfo attached to this I3C device
+ *
+ * Internal representation of an I3C device. This object is only used by the
+ * core and passed to I3C master controller drivers when they're requested to
+ * do some operations on the device.
+ * The core maintains the link between the internal I3C dev descriptor and the
+ * object exposed to the I3C device drivers (&struct_i3c_device).
+ */
+struct i3c_dev_desc {
+	struct i3c_i2c_dev_desc common;
+	struct i3c_device_info info;
+	struct mutex ibi_lock; /* lock used to protect the &struct_i3c_device->ibi */
+	struct i3c_device_ibi_info *ibi;
+	struct i3c_device *dev;
+	const struct i3c_dev_boardinfo *boardinfo;
+};
+
+/**
+ * struct i3c_device - I3C device object
+ * @dev: device object to register the I3C dev to the device model
+ * @desc: pointer to an i3c device descriptor object. This link is updated
+ *	  every time the I3C device is rediscovered with a different dynamic
+ *	  address assigned
+ * @bus: I3C bus this device is attached to
+ *
+ * I3C device object exposed to I3C device drivers. The takes care of linking
+ * this object to the relevant &struct_i3c_dev_desc one.
+ * All I3C devs on the I3C bus are represented, including I3C masters. For each
+ * of them, we have an instance of &struct i3c_device.
+ */
+struct i3c_device {
+	struct udevice dev;
+	struct i3c_dev_desc *desc;
+	struct i3c_bus *bus;
+};
+
+/*
+ * The I3C specification says the maximum number of devices connected on the
+ * bus is 11, but this number depends on external parameters like trace length,
+ * capacitive load per Device, and the types of Devices present on the Bus.
+ * I3C master can also have limitations, so this number is just here as a
+ * reference and should be adjusted on a per-controller/per-board basis.
+ */
+#define I3C_BUS_MAX_DEVS		11
+
+#define I3C_BUS_MAX_I3C_SCL_RATE	12900000
+#define I3C_BUS_TYP_I3C_SCL_RATE	12500000
+#define I3C_BUS_I2C_FM_PLUS_SCL_RATE	1000000
+#define I3C_BUS_I2C_FM_SCL_RATE		400000
+#define I3C_BUS_TLOW_OD_MIN_NS		200
+
+/**
+ * enum i3c_bus_mode - I3C bus mode
+ * @I3C_BUS_MODE_PURE: only I3C devices are connected to the bus. No limitation
+ *		       expected
+ * @I3C_BUS_MODE_MIXED_FAST: I2C devices with 50ns spike filter are present on
+ *			     the bus. The only impact in this mode is that the
+ *			     high SCL pulse has to stay below 50ns to trick I2C
+ *			     devices when transmitting I3C frames
+ * @I3C_BUS_MODE_MIXED_LIMITED: I2C devices without 50ns spike filter are
+ *				present on the bus. However they allow
+ *				compliance up to the maximum SDR SCL clock
+ *				frequency.
+ * @I3C_BUS_MODE_MIXED_SLOW: I2C devices without 50ns spike filter are present
+ *			     on the bus
+ */
+enum i3c_bus_mode {
+	I3C_BUS_MODE_PURE,
+	I3C_BUS_MODE_MIXED_FAST,
+	I3C_BUS_MODE_MIXED_LIMITED,
+	I3C_BUS_MODE_MIXED_SLOW,
+};
+
+/**
+ * enum i3c_addr_slot_status - I3C address slot status
+ * @I3C_ADDR_SLOT_FREE: address is free
+ * @I3C_ADDR_SLOT_RSVD: address is reserved
+ * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
+ * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
+ * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
+ *
+ * On an I3C bus, addresses are assigned dynamically, and we need to know which
+ * addresses are free to use and which ones are already assigned.
+ *
+ * Addresses marked as reserved are those reserved by the I3C protocol
+ * (broadcast address, ...).
+ */
+enum i3c_addr_slot_status {
+	I3C_ADDR_SLOT_FREE,
+	I3C_ADDR_SLOT_RSVD,
+	I3C_ADDR_SLOT_I2C_DEV,
+	I3C_ADDR_SLOT_I3C_DEV,
+	I3C_ADDR_SLOT_STATUS_MASK = 3,
+};
+
+/*
+ * i2c_adapter is the structure used to identify a physical i2c bus along
+ * with the access algorithms necessary to access it.
+ */
+struct i2c_adapter {
+	struct module *owner;
+	unsigned int class;
+	int timeout;			/* in jiffies */
+	int retries;
+	struct udevice dev;
+	int nr;
+	char name[48];
+};
+
+/**
+ * struct i3c_bus - I3C bus object
+ * @cur_master: I3C master currently driving the bus. Since I3C is multi-master
+ *		this can change over the time. Will be used to let a master
+ *		know whether it needs to request bus ownership before sending
+ *		a frame or not
+ * @id: bus ID. Assigned by the framework when register the bus
+ * @addrslots: a bitmap with 2-bits per-slot to encode the address status and
+ *	       ease the DAA (Dynamic Address Assignment) procedure (see
+ *	       &enum i3c_addr_slot_status)
+ * @mode: bus mode (see &enum i3c_bus_mode)
+ * @scl_rate.i3c: maximum rate for the clock signal when doing I3C SDR/priv
+ *		  transfers
+ * @scl_rate.i2c: maximum rate for the clock signal when doing I2C transfers
+ * @scl_rate: SCL signal rate for I3C and I2C mode
+ * @devs.i3c: contains a list of I3C device descriptors representing I3C
+ *	      devices connected on the bus and successfully attached to the
+ *	      I3C master
+ * @devs.i2c: contains a list of I2C device descriptors representing I2C
+ *	      devices connected on the bus and successfully attached to the
+ *	      I3C master
+ * @devs: 2 lists containing all I3C/I2C devices connected to the bus
+ * @lock: read/write lock on the bus. This is needed to protect against
+ *	  operations that have an impact on the whole bus and the devices
+ *	  connected to it. For example, when asking slaves to drop their
+ *	  dynamic address (RSTDAA CCC), we need to make sure no one is trying
+ *	  to send I3C frames to these devices.
+ *	  Note that this lock does not protect against concurrency between
+ *	  devices: several drivers can send different I3C/I2C frames through
+ *	  the same master in parallel. This is the responsibility of the
+ *	  master to guarantee that frames are actually sent sequentially and
+ *	  not interlaced
+ *
+ * The I3C bus is represented with its own object and not implicitly described
+ * by the I3C master to cope with the multi-master functionality, where one bus
+ * can be shared amongst several masters, each of them requesting bus ownership
+ * when they need to.
+ */
+struct i3c_bus {
+	struct i3c_dev_desc *cur_master;
+	int id;
+	unsigned long addrslots[((I2C_MAX_ADDR + 1) * 2) / BITS_PER_LONG];
+	enum i3c_bus_mode mode;
+	struct {
+		unsigned long i3c;
+		unsigned long i2c;
+	} scl_rate;
+	struct {
+		struct list_head i3c;
+		struct list_head i2c;
+	} devs;
+	struct rw_semaphore lock;
+};
+
+/**
+ * struct i3c_master_controller_ops - I3C master methods
+ * @bus_init: hook responsible for the I3C bus initialization. You should at
+ *	      least call master_set_info() from there and set the bus mode.
+ *	      You can also put controller specific initialization in there.
+ *	      This method is mandatory.
+ * @bus_cleanup: cleanup everything done in
+ *		 &i3c_master_controller_ops->bus_init().
+ *		 This method is optional.
+ * @attach_i3c_dev: called every time an I3C device is attached to the bus. It
+ *		    can be after a DAA or when a device is statically declared
+ *		    by the FW, in which case it will only have a static address
+ *		    and the dynamic address will be 0.
+ *		    When this function is called, device information have not
+ *		    been retrieved yet.
+ *		    This is a good place to attach master controller specific
+ *		    data to I3C devices.
+ *		    This method is optional.
+ * @reattach_i3c_dev: called every time an I3C device has its addressed
+ *		      changed. It can be because the device has been powered
+ *		      down and has lost its address, or it can happen when a
+ *		      device had a static address and has been assigned a
+ *		      dynamic address with SETDASA.
+ *		      This method is optional.
+ * @detach_i3c_dev: called when an I3C device is detached from the bus. Usually
+ *		    happens when the master device is unregistered.
+ *		    This method is optional.
+ * @do_daa: do a DAA (Dynamic Address Assignment) procedure. This is procedure
+ *	    should send an ENTDAA CCC command and then add all devices
+ *	    discovered sure the DAA using i3c_master_add_i3c_dev_locked().
+ *	    Add devices added with i3c_master_add_i3c_dev_locked() will then be
+ *	    attached or re-attached to the controller.
+ *	    This method is mandatory.
+ * @supports_ccc_cmd: should return true if the CCC command is supported, false
+ *		      otherwise.
+ *		      This method is optional, if not provided the core assumes
+ *		      all CCC commands are supported.
+ * @send_ccc_cmd: send a CCC command
+ *		  This method is mandatory.
+ * @priv_xfers: do one or several private I3C SDR transfers
+ *		This method is mandatory.
+ * @attach_i2c_dev: called every time an I2C device is attached to the bus.
+ *		    This is a good place to attach master controller specific
+ *		    data to I2C devices.
+ *		    This method is optional.
+ * @detach_i2c_dev: called when an I2C device is detached from the bus. Usually
+ *		    happens when the master device is unregistered.
+ *		    This method is optional.
+ * @i2c_xfers: do one or several I2C transfers. Note that, unlike i3c
+ *	       transfers, the core does not guarantee that buffers attached to
+ *	       the transfers are DMA-safe. If drivers want to have DMA-safe
+ *	       buffers, they should use the i2c_get_dma_safe_msg_buf()
+ *	       and i2c_put_dma_safe_msg_buf() helpers provided by the I2C
+ *	       framework.
+ *	       This method is mandatory.
+ * @request_ibi: attach an IBI handler to an I3C device. This implies defining
+ *		 an IBI handler and the constraints of the IBI (maximum payload
+ *		 length and number of pre-allocated slots).
+ *		 Some controllers support less IBI-capable devices than regular
+ *		 devices, so this method might return -%EBUSY if there's no
+ *		 more space for an extra IBI registration
+ *		 This method is optional.
+ * @free_ibi: free an IBI previously requested with ->request_ibi(). The IBI
+ *	      should have been disabled with ->disable_irq() prior to that
+ *	      This method is mandatory only if ->request_ibi is not NULL.
+ * @enable_ibi: enable the IBI. Only valid if ->request_ibi() has been called
+ *		prior to ->enable_ibi(). The controller should first enable
+ *		the IBI on the controller end (for example, unmask the hardware
+ *		IRQ) and then send the ENEC CCC command (with the IBI flag set)
+ *		to the I3C device.
+ *		This method is mandatory only if ->request_ibi is not NULL.
+ * @disable_ibi: disable an IBI. First send the DISEC CCC command with the IBI
+ *		 flag set and then deactivate the hardware IRQ on the
+ *		 controller end.
+ *		 This method is mandatory only if ->request_ibi is not NULL.
+ * @recycle_ibi_slot: recycle an IBI slot. Called every time an IBI has been
+ *		      processed by its handler. The IBI slot should be put back
+ *		      in the IBI slot pool so that the controller can re-use it
+ *		      for a future IBI
+ *		      This method is mandatory only if ->request_ibi is not
+ *		      NULL.
+ */
+struct i3c_master_controller_ops {
+	int (*bus_init)(struct i3c_master_controller *master);
+	void (*bus_cleanup)(struct i3c_master_controller *master);
+	int (*attach_i3c_dev)(struct i3c_dev_desc *dev);
+	int (*reattach_i3c_dev)(struct i3c_dev_desc *dev, u8 old_dyn_addr);
+	void (*detach_i3c_dev)(struct i3c_dev_desc *dev);
+	int (*do_daa)(struct i3c_master_controller *master);
+	bool (*supports_ccc_cmd)(struct i3c_master_controller *master,
+				 const struct i3c_ccc_cmd *cmd);
+	int (*send_ccc_cmd)(struct i3c_master_controller *master,
+			    struct i3c_ccc_cmd *cmd);
+	int (*priv_xfers)(struct i3c_dev_desc *dev,
+			  struct i3c_priv_xfer *xfers,
+			  u32 nxfers);
+	int (*attach_i2c_dev)(struct i2c_dev_desc *dev);
+	void (*detach_i2c_dev)(struct i2c_dev_desc *dev);
+	int (*i2c_xfers)(struct i2c_dev_desc *dev,
+			 const struct i2c_msg *xfers, int nxfers);
+	int (*request_ibi)(struct i3c_dev_desc *dev,
+			   const struct i3c_ibi_setup *req);
+	void (*free_ibi)(struct i3c_dev_desc *dev);
+	int (*enable_ibi)(struct i3c_dev_desc *dev);
+	int (*disable_ibi)(struct i3c_dev_desc *dev);
+	void (*recycle_ibi_slot)(struct i3c_dev_desc *dev,
+				 struct i3c_ibi_slot *slot);
+};
+
+/**
+ * struct i3c_master_controller - I3C master controller object
+ * @dev: device to be registered to the device-model
+ * @this: an I3C device object representing this master. This device will be
+ *	  added to the list of I3C devs available on the bus
+ * @i2c: I2C adapter used for backward compatibility. This adapter is
+ *	 registered to the I2C subsystem to be as transparent as possible to
+ *	 existing I2C drivers
+ * @ops: master operations. See &struct i3c_master_controller_ops
+ * @secondary: true if the master is a secondary master
+ * @init_done: true when the bus initialization is done
+ * @boardinfo.i3c: list of I3C  boardinfo objects
+ * @boardinfo.i2c: list of I2C boardinfo objects
+ * @boardinfo: board-level information attached to devices connected on the bus
+ * @bus: I3C bus exposed by this master
+ * @wq: workqueue used to execute IBI handlers. Can also be used by master
+ *	drivers if they need to postpone operations that need to take place
+ *	in a thread context. Typical examples are Hot Join processing which
+ *	requires taking the bus lock in maintenance, which in turn, can only
+ *	be done from a sleep-able context
+ *
+ * A &struct i3c_master_controller has to be registered to the I3C subsystem
+ * through i3c_master_register(). None of &struct i3c_master_controller fields
+ * should be set manually, just pass appropriate values to
+ * i3c_master_register().
+ */
+struct i3c_master_controller {
+	struct udevice *dev;
+	struct i3c_dev_desc *this;
+	struct i2c_adapter i2c;
+	const struct i3c_master_controller_ops *ops;
+	unsigned int secondary : 1;
+	unsigned int init_done : 1;
+	struct {
+		struct list_head i3c;
+		struct list_head i2c;
+	} boardinfo;
+	struct i3c_bus bus;
+	struct workqueue_struct *wq;
+};
+
+/**
+ * i3c_bus_for_each_i2cdev() - iterate over all I2C devices present on the bus
+ * @bus: the I3C bus
+ * @dev: an I2C device descriptor pointer updated to point to the current slot
+ *	 at each iteration of the loop
+ *
+ * Iterate over all I2C devs present on the bus.
+ */
+#define i3c_bus_for_each_i2cdev(bus, dev)				\
+	list_for_each_entry(dev, &(bus)->devs.i2c, common.node)
+
+/**
+ * i3c_bus_for_each_i3cdev() - iterate over all I3C devices present on the bus
+ * @bus: the I3C bus
+ * @dev: and I3C device descriptor pointer updated to point to the current slot
+ *	 at each iteration of the loop
+ *
+ * Iterate over all I3C devs present on the bus.
+ */
+#define i3c_bus_for_each_i3cdev(bus, dev)				\
+	list_for_each_entry(dev, &(bus)->devs.i3c, common.node)
+
+int i3c_master_disec_locked(struct i3c_master_controller *master, u8 addr,
+			    u8 evts);
+int i3c_master_enec_locked(struct i3c_master_controller *master, u8 addr,
+			   u8 evts);
+int i3c_master_entdaa_locked(struct i3c_master_controller *master);
+int i3c_master_defslvs_locked(struct i3c_master_controller *master);
+
+int i3c_master_get_free_addr(struct i3c_master_controller *master,
+			     u8 start_addr);
+
+int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
+				  u8 addr);
+int i3c_master_do_daa(struct i3c_master_controller *master);
+
+int i3c_master_set_info(struct i3c_master_controller *master,
+			const struct i3c_device_info *info);
+
+int i3c_master_register(struct i3c_master_controller *master,
+			struct udevice *parent,
+			const struct i3c_master_controller_ops *ops,
+			bool secondary);
+int i3c_master_unregister(struct i3c_master_controller *master);
+
+/**
+ * i3c_dev_get_master_data() - get master private data attached to an I3C
+ *			       device descriptor
+ * @dev: the I3C device descriptor to get private data from
+ *
+ * Return: the private data previously attached with i3c_dev_set_master_data()
+ *	   or NULL if no data has been attached to the device.
+ */
+static inline void *i3c_dev_get_master_data(const struct i3c_dev_desc *dev)
+{
+	return dev->common.master_priv;
+}
+
+/**
+ * i3c_dev_set_master_data() - attach master private data to an I3C device
+ *			       descriptor
+ * @dev: the I3C device descriptor to attach private data to
+ * @data: private data
+ *
+ * This functions allows a master controller to attach per-device private data
+ * which can then be retrieved with i3c_dev_get_master_data().
+ */
+static inline void i3c_dev_set_master_data(struct i3c_dev_desc *dev,
+					   void *data)
+{
+	dev->common.master_priv = data;
+}
+
+/**
+ * i2c_dev_get_master_data() - get master private data attached to an I2C
+ *			       device descriptor
+ * @dev: the I2C device descriptor to get private data from
+ *
+ * Return: the private data previously attached with i2c_dev_set_master_data()
+ *	   or NULL if no data has been attached to the device.
+ */
+static inline void *i2c_dev_get_master_data(const struct i2c_dev_desc *dev)
+{
+	return dev->common.master_priv;
+}
+
+/**
+ * i2c_dev_set_master_data() - attach master private data to an I2C device
+ *			       descriptor
+ * @dev: the I2C device descriptor to attach private data to
+ * @data: private data
+ *
+ * This functions allows a master controller to attach per-device private data
+ * which can then be retrieved with i2c_device_get_master_data().
+ */
+static inline void i2c_dev_set_master_data(struct i2c_dev_desc *dev,
+					   void *data)
+{
+	dev->common.master_priv = data;
+}
+
+/**
+ * i3c_dev_get_master() - get master used to communicate with a device
+ * @dev: I3C dev
+ *
+ * Return: the master controller driving @dev
+ */
+static inline struct i3c_master_controller *
+i3c_dev_get_master(struct i3c_dev_desc *dev)
+{
+	return dev->common.master;
+}
+
+/**
+ * i2c_dev_get_master() - get master used to communicate with a device
+ * @dev: I2C dev
+ *
+ * Return: the master controller driving @dev
+ */
+static inline struct i3c_master_controller *
+i2c_dev_get_master(struct i2c_dev_desc *dev)
+{
+	return dev->common.master;
+}
+
+/**
+ * i3c_master_get_bus() - get the bus attached to a master
+ * @master: master object
+ *
+ * Return: the I3C bus @master is connected to
+ */
+static inline struct i3c_bus *
+i3c_master_get_bus(struct i3c_master_controller *master)
+{
+	return &master->bus;
+}
+
+struct i3c_generic_ibi_pool;
+
+struct i3c_generic_ibi_pool *
+i3c_generic_ibi_alloc_pool(struct i3c_dev_desc *dev,
+			   const struct i3c_ibi_setup *req);
+void i3c_generic_ibi_free_pool(struct i3c_generic_ibi_pool *pool);
+
+struct i3c_ibi_slot *
+i3c_generic_ibi_get_free_slot(struct i3c_generic_ibi_pool *pool);
+void i3c_generic_ibi_recycle_slot(struct i3c_generic_ibi_pool *pool,
+				  struct i3c_ibi_slot *slot);
+
+void i3c_master_queue_ibi(struct i3c_dev_desc *dev, struct i3c_ibi_slot *slot);
+
+struct i3c_ibi_slot *i3c_master_get_free_ibi_slot(struct i3c_dev_desc *dev);
+
+#endif /* I3C_MASTER_H */
-- 
2.35.3

