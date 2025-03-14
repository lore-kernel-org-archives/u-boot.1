Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F137C28B30
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 05:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0C2D819FC;
	Fri, 14 Mar 2025 06:36:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="cIRxD53X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3B20810F4; Fri, 14 Mar 2025 05:09:48 +0100 (CET)
Received: from CY4PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67FDD808A2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 05:09:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yurxGbf4OG39KjQyhsbYSXEl452zHkaHqG8pm2z4is5J3u60i2nm9QfYr27F1SCZPphVA0fgk2khVRLTG1Zg70fciEkPbR0c8bdl9pKnUtt5dTRyGxIYVGM7Zpzdqr//sbWZQyiB0G1juHlOpGGLMFyqSu+CJh8QdBj+rUUU7RoV1YrWXkOco86tsr5JqblwWhk35RbIBXwYMcoZXQbE699PRVbh8sLf5pHj0/0El71MWk42lp6MuOrbLr4OhAv4+UVVSsU3EymeFoYrXE9REw7XAAT4GnGzD8ydVFGvlCnGG1Y8m05K+Rrlg5yV5fq2p3d7DPJ9lk0g7zjoc0ALog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+Sg4GIqRmFx9wnHkL6jQ50hsczoPUsj8eqK+k9DX1g=;
 b=u6xIN2tVbvcC8PK2Y4NCY+XXVhEuuDHA2gKnFtd400tJeeqsUNI5QJGW+JjJW2rQJLHHWMZHn8ucJCsa2uu91fEBvOToIlwMDZ26jKWJHXWyPaJpu8QnMfTvSpzyjzTsBjxIwQxgi2TElrcVX5umjgJ5eiWupsAlVFyugnZPFXweQiaLUjYi9GE/u7SxTIv4lk9nu23iEUa3qklfmhtslrqPampy0JByvLLGMywggzRMr9Kul7Z2pCsiQ3mkwUsTbX8U1mVKZrltrdYDsY7ZP+ag/WPRrXObc8F95e6pOjTqcZ7Wec2TpvrVH8T6h4tkt9qR+pTXiz+2aL/d+cZ4FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+Sg4GIqRmFx9wnHkL6jQ50hsczoPUsj8eqK+k9DX1g=;
 b=cIRxD53XgVRm++Ccvyn63BUsQruF6HhXCSQfdI1kqIPDiwHW0RNnJbDMlfXHQCyZmA8mTzs3A0S+rMcdCwwKcU9pZM6l2avs5p6xkfcxVRmV+CsVJBdS+UKYcRyqyFuSUCOJFMMz4GetqwUofDgqMwrC86/m/fsbdzjrpLoiphtAVjA6gS4PDctIX89w7ou+MBApiXkYec3IWA/q1PwBLJUg8UXKYGfSclKJtrHG9Xi/x2I/VBuba/lP3EVo6WM8hNWHFAWHbD9y+Ot8x8OfJ1Q9Zu1FsCzEs0vde4+Qps8A2uzvmB8K8yHTiQGrkqXfu4Q2Klb+A78p4gDx6DdPXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB4387.namprd03.prod.outlook.com (2603:10b6:408:3b::30)
 by SJ0PR03MB5757.namprd03.prod.outlook.com (2603:10b6:a03:2d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 04:09:43 +0000
Received: from BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874]) by BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 04:09:43 +0000
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
Subject: [resend v2 03/13] drivers: i3c: Add i3c uclass driver.
Date: Fri, 14 Mar 2025 12:08:52 +0800
Message-Id: <20250314040902.43621-4-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250314040902.43621-1-dinesh.maniyam@altera.com>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::9) To BN7PR03MB4387.namprd03.prod.outlook.com
 (2603:10b6:408:3b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB4387:EE_|SJ0PR03MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b55489a-876f-425f-e08d-08dd62ae0cc3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AUPO4+gldE/hXqUZm6ug5qYdq8g+x+M3x5UsWB9HwjAJPx2NWUDIu5s41lfH?=
 =?us-ascii?Q?eL6HmDyFE1R4xns1iWQyzdeYPCgjnsLg4ZOwUXAt+gcADE4frXEOB/M6WkNs?=
 =?us-ascii?Q?c09I0bk1GxparmhqSDqQGl88TbX4L/3bU7HeD7C2Z9C9wPGDLjuhgKtBwhb3?=
 =?us-ascii?Q?XIQ4fkqdNljb5LhZ88j1w0tIRyP6Bmior1PlhH4fXQ+KtWaPfZUfmxk9TUIy?=
 =?us-ascii?Q?lIRjldzUWvnCmv+YbnM3JExSpUJWU0UrFBrK5+nrLUxvbOuhCV/uWbXwFvRK?=
 =?us-ascii?Q?ZOO8acoXhG/it5U9+aq5peSkxaLp6CKZDYImNjgVn2oVkIG19CMV7MJuuJnS?=
 =?us-ascii?Q?qhGhoisgiUeT3Y8NHPNEPF52GsR641YBIjolx+AoJ8H6eKS9DnV/Qs9N0kOi?=
 =?us-ascii?Q?xsgw7E+JIgzJyTgXW4UMdZkdp8WUfwmsfaoj3eeXmJnGhg20seJmj+6ZWfMN?=
 =?us-ascii?Q?TFKu6Te0bEUKyDTPIo3JZjZGprqpnfAzyQlUudgyWXffXl+27oiS2NCW9I+Q?=
 =?us-ascii?Q?ubZEUJFQF1jGRKNmKP9MIrBl67tRvTrevmux4Qdn80D1ekK4kf7O4bqSA+Lw?=
 =?us-ascii?Q?jMfZa26YwJk/jaJU+tQ7ZggtzTT9X86M/JCGeOkxHsViijjyraldMV1KVMZm?=
 =?us-ascii?Q?qHd+2vs65WgwpS4ZQZiUdVpoCTVGt3Dz4TTI5O1a0+0Fy8OOAvq1+vIJDvsp?=
 =?us-ascii?Q?1Zy2Tl2Ml5vicHmWX4Fz/WRI0ikJ3hWNdloTQXo/EhqJiSeMoeC34jR6MeHY?=
 =?us-ascii?Q?YBfLepJImNoDNWf2c61NtrP4muVKXvrELwwYaTYua8nA2x/8EQCbO8J74xLG?=
 =?us-ascii?Q?ceVfk12shjqiRRQqKItiL8meFNb/PeU1gBfD7WZtJ7hwmJEjKmN8odako/aO?=
 =?us-ascii?Q?fhxlh8wj0VeBh5Rgc+Rcrdu2kIkyw8MEEOI5gn48GhfkM/6xrjnA7Gu30aSm?=
 =?us-ascii?Q?ojqZ3hvNE7KlAKjmybFX3Y4ivvAOA38DxARJZI52kSDxKKbnkR2SC5CCpwLA?=
 =?us-ascii?Q?+NutgqCFVQMiK7DrUcpO0Ykqz1hayS6Mb/UYp6ieS+JozOo3HVwO+BwEKhb+?=
 =?us-ascii?Q?Id58x/MRNOct07AjIpDyposzFsw6SQnuxF8V91UkbnrUF2peb4MoVexoVGrQ?=
 =?us-ascii?Q?kY2VFKNwOERa/zY9gVksPs6o7pAf0BIrQJbksuCnu0vCepWG8WYnNJcPHGx1?=
 =?us-ascii?Q?MXuzxGZtSEEbZryOdYmZpELX45d0MJIHqtIXHI5iMn77bIS5VizDk0Gvwyoe?=
 =?us-ascii?Q?jTuxNUmPEP1ALxWgOMUE4el1aQWkiVJgoTlhtC39iWCmMtjEndpWjIGR1Wtp?=
 =?us-ascii?Q?l1xko7YTa/u/jtQ8zsSY9xMM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB4387.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gQvLzO+Ynka24eeRYtbnytdbz6BBSV8boyQIjvB1LoEvWBne0Vo/Wjg+5JV3?=
 =?us-ascii?Q?llDF8CLXY2HVYIZ2KAsf3Z2LnLUIkdNkmxipIgkglxUBHF7CrrMLoPrVG6f0?=
 =?us-ascii?Q?jXROORwX5HMT9TbmxX3qBOP/n49M2TmfgRjseBvwPsUEh5Wv4tw7Rlc0XuwA?=
 =?us-ascii?Q?Ts6EE1y3HYILKli2u/kv00Qn2cXeg6UknLKCTmb24Qb/SuTVXcfk/+v+7oX7?=
 =?us-ascii?Q?C+6bPPiFjjVeI+/hoYT3IXIrmix07+L1z7IGRrZtFHETwjDZ+lrQIhkfbcog?=
 =?us-ascii?Q?QNrvNHu7xA8ctWA9eTqr8hInv00snwX6+8Em+OswgPozUyj1H/inVAIZpkCX?=
 =?us-ascii?Q?QrvIc9o43eBaWTIELLgudGy6W74DDWnZ9qB2wWd2AgwEwrLzdN6Sb1fNJyn7?=
 =?us-ascii?Q?XKtpkBrMHOp9WOAp1tiyZMminVezHu0a250jNT7wxKU+ZXBGGfwDD39aLuGu?=
 =?us-ascii?Q?ry4MHaZ1xwVqsFCnTutLFyN41uWLS6FuHBuEjdwfvqas8RV/ghn0t1QCS7i6?=
 =?us-ascii?Q?c92FlT7YjADTunyg7WKyTkFLQny8Y7VYQnOzWT0T0M2jgq6kNNP1x0TogAhE?=
 =?us-ascii?Q?hC3Pj34p1MgWgMY4qqWaL3fShsZXpvYprQZA3yeKV1RreAwm3u5Q2oXghspy?=
 =?us-ascii?Q?r/YcySK0atlIU4r4BAu1tq9Ma0W4ScsJ8zhCh2rRT00uoIFVUTsA1BWKwCU1?=
 =?us-ascii?Q?/G0orQB7IZAaoO8TMoECufKRtZgrfqdfp268vkLMOL0Vd9689BfJt0Z8RIXM?=
 =?us-ascii?Q?Bt4Ghp0MxPtrjJlgTs3t8D9t6W98JXWqsofiAZ7YnOa9OvKcIKpUupoN/6Fi?=
 =?us-ascii?Q?ky91Kao86Yd38nfl9tau+Oitu1p8krV9tfXqyeub2oEku8Uo9mMhcsKmhU1f?=
 =?us-ascii?Q?y8gPnAJe8VqzfZob22C0lr2Ltwz8a0AK7aomc1msccvrG+5aU76zw6IhUVRt?=
 =?us-ascii?Q?dl615iN2DDAu+dCajRJt11DiVWKk07oOL4Ds65QrZ2c0I4yYL7EFWMMQJR/u?=
 =?us-ascii?Q?TO6hlY4Sd+8oMNcnUA7K+ksKnV7k+hhLDp61JaujkKkMvDoOjZy1VXDeqVDk?=
 =?us-ascii?Q?nRW6c+GEvKSURpYGRvi1PpP1C2clApzO6IYMFsUNx6bpG06rDRe0e6OeDJTM?=
 =?us-ascii?Q?o8dfT7tsQKG4oqhaIvomjGSQOlgt+LxTboqPKBWVO1J3uyfecAkKSK90WEUe?=
 =?us-ascii?Q?Lvhqip8/Ea5/9G4Tt5oxCIC67YZxMhQIYyyD1uaMvD6Wifw0DCR5rNQgEdH/?=
 =?us-ascii?Q?XXYCGqjMFawVTIWOVzqPFCSbsVOk+XeWfFJLRPC2+Se5c237sem+8n/Dj8dB?=
 =?us-ascii?Q?DKcDjlrCtQL1E/GEZHSXfJj+1KgQf+hQJjAtGMZatCMv3d3xXuJnzX3HwXDY?=
 =?us-ascii?Q?VjV2JIZTZq2J5y8ms7tbE6wC+kRYql0p4izmVwHVhguVCBaHwF4zyqHLLP/1?=
 =?us-ascii?Q?zvQqG9RzXTqcilv5h23L2JFQ7rDUlWTQbRBDEGskWyeZI9HcsthdX9qKJfDW?=
 =?us-ascii?Q?QCigjWFRjt4zUeZjSp5Je05TwvRD02Cjy5ugz6mWfsFS0kHu1Mc3I73RcDiy?=
 =?us-ascii?Q?6VLhvztP7DhYU2W2hoPn58kXDg09cJ39Vz1ZPWJ5EjmdjqE0TlCqyH3TdrJZ?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b55489a-876f-425f-e08d-08dd62ae0cc3
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4387.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 04:09:43.7143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9uT5JAMNu3ktV7OXMC/1EV80bZlY1j3beGKbwcehBjRXZeRLIZqcA7LLZZMhEqZYQOLHAy47ffuWeVUN5sqKnYttN4PdVnSQVz+/TTZ4a0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5757
X-Mailman-Approved-At: Fri, 14 Mar 2025 06:36:33 +0100
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

