Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F06C3600B
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 15:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 537F281CAF;
	Mon, 24 Mar 2025 16:09:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="OfRtLCoL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0523981FAA; Mon, 24 Mar 2025 09:40:19 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3A1A801CF
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 09:40:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPXd3J0LHKSJrr7c3iUfeC2SyO/84GoaBi2SqwooCA75WjV8sBanNhYTNGM4mVvXeFQHDpIP5muP1D+bymsC2VroCQ7eWWo956RQhbTOvDQKKckGOa+u5JtKiZjDgTjvbdvTgdeW/vMs/auDvAzGWmnPYLu3iPjq6kt9Ckd51Eatqm76yaK70N/pK1S1NrlN6ZZMYTxJG6iN/d1enmrbgo3L3FwKL15Wa4a5g1G4Nj8hZZW1zSAqHgxWwL/sMzRuOiKkRFDsXdviUJKbf6zl6tckUVAJFsP0cGrCDbznJFWRgoZ8SZZY+/KS/49xQBGZzDJL1kWt+wMeKWS9VACzQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+Sg4GIqRmFx9wnHkL6jQ50hsczoPUsj8eqK+k9DX1g=;
 b=tcwbEBIrbCp5N+FQEYsLSWyxH/ronu6D33OXrUXCk1oWFI2k7FRTvcrORAK2VfBc+4LvbQUxIwfMAR7usCmMQODRY5gCDlBjP2/HoGr6sk/g5FUx/QdzqsG3+wHaNhXZawDHwgQfyLQ7ZVQ5H0e95BNeMNKGcnJSlXspgiruFAuVHhijpn/UR3lUL81S9/ydVSLUEwP/nzbr1TPJBhydxmG4+qeSGn+YG1U/Lqrlf1JmjQnFibMQfCI0THOjKs4uwN1eAGcPNrcxJJYPE4+DrkfChNN7jPtpjuNSLyNpWN9Ksw3gXHwJx+WCeWdPtH8RtRNuOzTsTMlVarxCsvUwwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+Sg4GIqRmFx9wnHkL6jQ50hsczoPUsj8eqK+k9DX1g=;
 b=OfRtLCoLqOrEig0KVCbo1GBB/kcz+tC/TeKPHCDIZYQitPYYRbrZzgA+mCHSmvAp87QUn5yJAszK638GLNrzrJ+enXSLMoFqMbvUvn1oxCIzGovCJNtrFOyeJ04AW/uq7L1DlRpa7xYpRtJgKX5AGYtG7r7ULLcIb3pBnnlHKaSIOO3BJj2aXUQmcYgsISp//d/yvFnu85MB3F+H594AwxqReNZ+K/9f6hRJu6620CdDYwI/lcIc/L9P/qC8coYgJyh31d7OTgTCC7hzT/nDkRQ2FEMLbIaIyhco8u1kQaL+SY4ZpPfoJy2a0R460XQQ/ZzAOzhlve9Ch/+DyzIjkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by MW5PR03MB6958.namprd03.prod.outlook.com (2603:10b6:303:1a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:40:13 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:40:13 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
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
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v3 03/12] drivers: i3c: Add i3c uclass driver.
Date: Mon, 24 Mar 2025 16:36:55 +0800
Message-Id: <20250324083704.26259-4-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250324083704.26259-1-dinesh.maniyam@altera.com>
References: <20250324083704.26259-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::47) To SA1PR03MB6370.namprd03.prod.outlook.com
 (2603:10b6:806:1b5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6370:EE_|MW5PR03MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 959b44a3-66bc-4269-2a34-08dd6aaf7ec2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OvqPFn1xuXY3b/ddpQ6WKMxk3mOYYIHPFUo4onyR9TgrcU5a1P358Yec0Z+Q?=
 =?us-ascii?Q?2h/UrBZqzTk56rSsPyFpS23eLS0zWhTfwMiZAlMJv8z5GGIvfPhyV/EdFfKJ?=
 =?us-ascii?Q?EXG5xpKTEepu3s0HjUFKHL7dVZ4eevDDaG3WSVb9KHtI32X7H/VkuvyzXeyl?=
 =?us-ascii?Q?R+2dMrExYiED5sDH9jMgihVfae/cVO+6x5vz4fS1NYhsSXTE3zxnv0in0+Lr?=
 =?us-ascii?Q?ca3X1JY3pqsP0H1qRZZrOmP/oRuM6CYUuev9zxeP2Mc6Fl68wb+hs6+33c0M?=
 =?us-ascii?Q?Yg3dgluyqzjZIG+Q+7RzliNXlIyNdxzLILoCLg6FHt6e4Lnu55tfU8dWDJMN?=
 =?us-ascii?Q?jDZz9yElffV6p4ywox2L9fnQhIFC+obTj1GJsCQ/B4yDt01GD5BR9sgJaTWH?=
 =?us-ascii?Q?0MDhmo70baqG7iUYaaAGJMCpIW3zl6kwLa1c/ifLIf9KkF5tjNkGV6nQm4An?=
 =?us-ascii?Q?ts1zo9ddiY66E7I5BBHo/PDqroEEzJ6Mf4VjuEmD981tx+esv+2hRdGkq3Yx?=
 =?us-ascii?Q?u1sq0OtIvf5R5JjsEd2HtqxHuQr0xby8ccBa4HGY/PdAaVx3FoH8OPFPj3RD?=
 =?us-ascii?Q?EAD1gVxa647+/PM4d920pAFtkMKdIJhVgU2lHoW/2Gra8sGmEN5FnZ2ero7l?=
 =?us-ascii?Q?j8CTHGkPUJNMve8SVJ/+ZPn5o+t3plFSh9KUkl3coHLi4SHvtpzrWEhp4IPl?=
 =?us-ascii?Q?97J19zjjjhZTCYNGyxaoIZ/t+EDxrhs9oC8o3jUmmJwf9Q0fFizSYsef6+0H?=
 =?us-ascii?Q?BmMtHriKXcKVjzL75T3Twk20jeBWGhueV0HFdCa/JxTjIzLFL+957268Q9ZZ?=
 =?us-ascii?Q?52CKc6xnYRdMX9fHyGERZTbL1ys7YMUwLsgJR3OsGhLxBZgSKT5R81+pxK9G?=
 =?us-ascii?Q?XYgK6qw+DmySPlRJdmPl6WQRnw7PvcceWYbZcBl6LubfddVHDjO7fEYLBk+7?=
 =?us-ascii?Q?lW8T7RrCbIbR/YMK2m1aX0kM8+OMDJAX4kxR7czw1w+uX6kyw3/ifWGz0fD5?=
 =?us-ascii?Q?tWdZUHURcP8eG702SbC/yK0o7F2SfGYsVhePnHa3IN7anm+4eEOauefRkkaf?=
 =?us-ascii?Q?3P/x+Q779kCovRzR66PWK0yBzOsqgi8a2TDvPhEECo/nULnUe/UjuK0pAbmc?=
 =?us-ascii?Q?nTDsx44rdOW1cX84URF+W/b0oGhu/UIbCKtzBQ/JFapWcW20gpQrVTezCiOP?=
 =?us-ascii?Q?TbEp5D+YuFxbEqqrcoA0tQQWNn+ATvaeOIsHqgNcBCwq1D+8MklywIeW57GA?=
 =?us-ascii?Q?Fqw1dA8tuih49rBQkhc1s6WhDFHRM1HhLeFJFmpPziAiI2/0/z75WZcRpjXX?=
 =?us-ascii?Q?s/11Hum7EgFXVx2cUtZlvTH3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OsL8iU40FzbwTdFjMazZSDMhRE9/kTVCRVqRjRkL2qni8LEYQXAGjyGBMSA1?=
 =?us-ascii?Q?BpQruS5kxdk5GTpRoVNCcMIsUL2oM4HxnaUb5QF31B07AQL8aLjMCy/o1H4O?=
 =?us-ascii?Q?0RKGnsH1tw9rVSm6bZCQXYGBWLgvAEF3hSLmmgbFkH+lUZ9itjP80lI0KP6y?=
 =?us-ascii?Q?8jBpQpauMSfcnJdFoyEOlW9DZJ4Kuu0iJP9zzxqho/kKbWKWEmx041SxR6V7?=
 =?us-ascii?Q?BW9v1frQXK4IH4isxAAiw+V1oYeDSaP5TcsWobRIx4iyLQWz+n83CJ9FS3AD?=
 =?us-ascii?Q?EgWYlX3vTlH01+CLDJM2mdDo/EK50DinqvHyixJxtKFeEwwdVJgCzcL0v78V?=
 =?us-ascii?Q?e5TGR/VS5+mKwixF359QADhKEtJbpAFyUN4Iq7KXU7m16EfB3zTLsL1/sX5J?=
 =?us-ascii?Q?9+jd+6dfqS2ag6YXJPAd0/bdr+Z2a4MlP2P+CvN93WgqcYM3yf33dI94MZVe?=
 =?us-ascii?Q?4cQXRaA5xK2icKyErZmSBZDhDO6PnhdbNztyanLujUwXbUa/wmBTiM7pSvn0?=
 =?us-ascii?Q?6/75mizp13MDn8eepqQps70FPhKy74p3oFXPx/juisZ5XYzDeNRpk0k/5YQp?=
 =?us-ascii?Q?l53I/pj8RHf+zIVHg3jtJKzrMAaKwmQZRO7rDa82+nWQ2KjV7h0FVOwwCDSL?=
 =?us-ascii?Q?qI0Tq+FVl6/RiQ0oIMqoc7UvD9dmhmC38zCYVyyWb1eP4J1pmnk07G0F2lLK?=
 =?us-ascii?Q?ug/NOe5qHKcc9sl7/KvOOxzHio4kt+1PkFTy+1lJKcp6Vs0wF6qrMOeFYEQe?=
 =?us-ascii?Q?09OnYABHunBC5JzXlyNXoJk5l4t8RymGafxD8iSFAqflVEOOIC7mcRw6gajA?=
 =?us-ascii?Q?2CQKF/tA8FMKYiItQGgA4FxnA9VfqhQZGCqsu6eCnhgP4TZv9RMBcxWozGf1?=
 =?us-ascii?Q?AA/SAPlkp6AcN6QZPkTbSoyx8ZGN/JMhfeppqXqq/Z4vtAzA5nDcGTl/3UqG?=
 =?us-ascii?Q?qsBh0Ee7c2td8BMK4o3PMrmbxy+Ii9NWxFZZoRrOaz4BvrNIK9ZgpbZORqLr?=
 =?us-ascii?Q?fzyekUtKYoCUuCaryh81wn08tGBmKPlowdjSTKDAp5PiEqadpvP0ZB7ftI13?=
 =?us-ascii?Q?gjkAMUevn1BkX0612ifiudfzkf+JDEKaxg60TyE3UaNDRir00OvVb4ocFMix?=
 =?us-ascii?Q?3KdlGsOjq0NMopGqLic23G5ZsfcLH0RtYWQ8snSfZ2rUeRjJEXNvpDn56Avu?=
 =?us-ascii?Q?aiLMwuNPJCZBfB133FxuLU9z37xKA43e23Seo25CUvDOv6aitxHuMyPhAQq8?=
 =?us-ascii?Q?jW5fb9Pox9O2UJFPH5LV5+p4/TNbyKUbrEywIa+D5w6Gbs9PB1/PNguVgDkX?=
 =?us-ascii?Q?npbepL5mfN+sL46cp8lCM/2gxYq0fE2umon7uXYhzmkQc27p0p7yPonxN0OL?=
 =?us-ascii?Q?txvVpIqPtwqrmN+zFEmLDTvsKQDwMhBnWuZ3MiJ2fLexzEV593cbKgwl0wBV?=
 =?us-ascii?Q?0eKoX5NVJ0SDPAL7TAb9nEc+zgz42bAgFgoU1FWDYZ/WZtSj/aoI+BB7Kjec?=
 =?us-ascii?Q?0CcNAB4OgTN5ub+fE4GQrHWCcdCzwQEoueOdZnll9ETnc6HuCi3IiVOAT1cj?=
 =?us-ascii?Q?z6YzoyO55AwFoJO2vJ3rTqrgeay+sAh4RgoebhHknbRLKMzxwGtlB+kDdiRw?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 959b44a3-66bc-4269-2a34-08dd6aaf7ec2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:40:13.7703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXLZiRrc5e+cAbdMc6FDLBD/1mLH94041M5vDXf5MXmraa/NVKOKWPnDUjMS447YFQ8MVYI2nDB24aM5D0Mmy2shDGXOJOQ2QU9wm0379/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6958
X-Mailman-Approved-At: Mon, 24 Mar 2025 16:09:48 +0100
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

Enable i3c general uclass driver. This uclass driver will have
genaral read and write api to call the specific i3c driver.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/i3c/i3c-uclass.c | 38 ++++++++++++++++++++++++
 include/dw-i3c.h         |  1 +
 include/i3c.h            | 63 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 drivers/i3c/i3c-uclass.c
 create mode 100644 include/i3c.h

diff --git a/drivers/i3c/i3c-uclass.c b/drivers/i3c/i3c-uclass.c
new file mode 100644
index 00000000000..644f5788898
--- /dev/null
+++ b/drivers/i3c/i3c-uclass.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <dm.h>
+#include <i3c.h>
+#include <errno.h>
+#include <log.h>
+#include <dm/device-internal.h>
+#include <linux/ctype.h>
+
+int dm_i3c_read(struct udevice *dev, u8 dev_number,
+		u8 *buf, int num_bytes)
+{
+	struct dm_i3c_ops *ops = i3c_get_ops(dev);
+
+	if (!ops->read)
+		return -ENOSYS;
+
+	return ops->read(dev, dev_number, buf, num_bytes);
+}
+
+int dm_i3c_write(struct udevice *dev, u8 dev_number,
+		 u8 *buf, int num_bytes)
+{
+	struct dm_i3c_ops *ops = i3c_get_ops(dev);
+
+	if (!ops->write)
+		return -ENOSYS;
+
+	return ops->write(dev, dev_number, buf, num_bytes);
+}
+
+UCLASS_DRIVER(i3c) = {
+	.id		= UCLASS_I3C,
+	.name		= "i3c",
+};
diff --git a/include/dw-i3c.h b/include/dw-i3c.h
index e37fd4dc325..920f18bccb4 100644
--- a/include/dw-i3c.h
+++ b/include/dw-i3c.h
@@ -7,6 +7,7 @@
 #define _DW_I3C_H_
 
 #include <clk.h>
+#include <i3c.h>
 #include <reset.h>
 #include <dm/device.h>
 #include <linux/bitops.h>
diff --git a/include/i3c.h b/include/i3c.h
new file mode 100644
index 00000000000..6ef4982dcf6
--- /dev/null
+++ b/include/i3c.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <linux/i3c/master.h>
+
+/**
+ * struct dm_i3c_ops - driver operations for i3c uclass
+ *
+ * Drivers should support these operations unless otherwise noted. These
+ * operations are intended to be used by uclass code, not directly from
+ * other code.
+ */
+struct dm_i3c_ops {
+	/**
+	 * Transfer messages in I3C mode.
+	 *
+	 * @see i3c_transfer
+	 *
+	 * @param dev Pointer to controller device driver instance.
+	 * @param target Pointer to target device descriptor.
+	 * @param msg Pointer to I3C messages.
+	 * @param num_msgs Number of messages to transfer.
+	 *
+	 * @return @see i3c_transfer
+	 */
+	int (*i3c_xfers)(struct i3c_dev_desc *dev,
+			 struct i3c_priv_xfer *i3c_xfers,
+			 int i3c_nxfers);
+};
+
+#define i3c_get_ops(dev)	((struct dm_i3c_ops *)(dev)->driver->ops)
+
+/**
+ * @brief Do i3c write
+ *
+ * Uclass general function to start write to i3c target
+ *
+ * @udevice pointer to i3c controller.
+ * @dev_number target device number.
+ * @buf target Buffer to write.
+ * @num_bytes length of bytes to write.
+ *
+ * @return 0 for success
+ */
+int dm_i3c_write(struct udevice *dev, u8 dev_number,
+		 u8 *buf, int num_bytes);
+
+/**
+ * @brief Do i3c read
+ *
+ * Uclass general function to start read from i3c target
+ *
+ * @udevice pointer to i3c controller.
+ * @dev_number target device number.
+ * @buf target Buffer to read.
+ * @num_bytes length of bytes to read.
+ *
+ * @return 0 for success
+ */
+int dm_i3c_read(struct udevice *dev, u8 dev_number,
+		u8 *buf, int num_bytes);
-- 
2.26.2

