Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36A7C83F1B
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 07:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72CD6831C5;
	Wed, 16 Jul 2025 09:19:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tdiAX6hA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A859A8319C; Wed, 16 Jul 2025 09:08:53 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D5E183192
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 09:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uD4qnT5h77Ec1d+K/Q9IlljKSa53AAjTfOCKB/cGhS7q8BOODUsXCNlO2tp+B+zBFM/7N8jyV5pT4UhLZqb5zSf+ZZJQl9e32oAyML9Wmn2dsp0kjzdTDo+QAeV3Q+tYNxqaKqVEaHDL7LnS9CcprE/UWECXPfam5+2ES5/56ZVhwZRxC7pjFjk9FkPEwtV4b+SOn2YMWG59/HTDfrB8EWJvnGZ85RLKTcd/KdCpGgpT3AMIduMvZQ2/ZBM7bOlJ+2fUdFVc3JajZor9Uc/CBQywSqtMxoiwDCJKB/MrM2dvR3t17RxQdOT7VIxx0D/q6aM3HoiD/cCOnf56NodMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdQtMV6emyyzYUrYkU1OHIp2EgOxdFaZZfmna0FijXE=;
 b=f2zFdFpZey+6K72vRV4pDaeDGbiWoA/VGDvPrVXNOHRYr8FhVeT/1UVfOc7Z/uJE7e4+3TKUKqqUpTkZvU/GkHkLxPFEWK+T+yl41Io6KLIkHB0sVZyOt+NKOOcfTe21F6l/0Kk2YBr87/zkyIGPieLviGpxNpYlFHzhTn80PSYXzPBA9uItPyhZVTPoM3hwA8+Ci2vpdsDoG+e05oibYxIrV7gV712P25il4m7ex/tHiTn5YOR8Dz7coZyjxLj9QtFLJYU43DyEpT0PE7CGu6uVUojJhmlC0Lzoea5sqJpmhYBun0yxJrt1KhdbIQ8dEcojXTtttWxZxcUXFO7d4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdQtMV6emyyzYUrYkU1OHIp2EgOxdFaZZfmna0FijXE=;
 b=tdiAX6hAUXLuLfhnsu6XC0lIhteXKYa78Ot1E6QMYZjIhu4EdfJLDE+meWdmJE4GaGn3ytEcdx5wtgJQTZGQJvlcxZP4/kDFurd5uJ88RxZzGPje8RB+4KYYIWuRvaGr6x5i5WZzhI01zruPEtZWi8XWebnN8M1fdpjcMfBvOpnO949Mb3UD0RVl/mEKbInrP33ZM0jlIhcLgb03dVWVd42mwToSleuIJDjYJMGZ/S9q/B9S8i0CW8U62WsPPsvxqmoawKslE4Wuy4Ze3eC2hVH9UpCrL75uhgdfd+pysFlP3RlRoUvDktDwPRs317cPenzeUqJpJhu3lgwtliBInw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH7PR03MB7170.namprd03.prod.outlook.com (2603:10b6:510:241::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 07:08:47 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:08:47 +0000
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
Subject: [PATCH v6 03/12] drivers: i3c: Add i3c uclass driver.
Date: Wed, 16 Jul 2025 15:08:01 +0800
Message-Id: <20250716070810.8030-4-dinesh.maniyam@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7e180552-79fb-4218-6e5d-08ddc4379bd4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TTGeDdw9TKe9iJkml1OR94svBwUqm9BrsXqmEiygZXAgVFG5z2hu2errXTsE?=
 =?us-ascii?Q?wAbnMK/hpgz67aN2u9fERez4LoIwpPCpm0NiPFw7k0dS95bm7J3eF4UEH3Px?=
 =?us-ascii?Q?MEDhcSWv5ZwNRU8acCLQtCdf9zMkvdAFidRIkuhAgM6A6DjB2Jm/9m1i4Ua0?=
 =?us-ascii?Q?NCCjByKURvbXj1yieOfqnZ4ngATwWH01C50U5wtyvQ/7ZI56WPQTSk87C2/G?=
 =?us-ascii?Q?5gg/RZAipxU6E+C/K08Rn8lG04jNlYvxcI1ldE9IqqXTS2DX81iDLWR35Miq?=
 =?us-ascii?Q?XDcSEKyn8lt1xuBogvCqMq6jqq3Mv4Ua0uxUUIu+Gnwmas7Yg0NgN1vvGAI7?=
 =?us-ascii?Q?FPA9LQPbd0KVRE6r24lyz5KV2W6k2H0/Uy/yINDUra2eW0hMNggllwJ6dEIV?=
 =?us-ascii?Q?UQzwaa2RnGShuLbuS/xqvyzNt6qGGaBL9eel8MmapT/yryNbOw7jgn0tDm7W?=
 =?us-ascii?Q?gYWXui2Xk+grwvxX163RkSOsfpibPITJYZZUOx4uBbBhD1DexrM26tXmXr1v?=
 =?us-ascii?Q?Dxy+NyQ2CkZQMyimArdTHWQBOAy3N6p007Ex+B3+IG5u29jz9H1THnoOOnQq?=
 =?us-ascii?Q?0aVdWf5IjZm3b6XQw2azaDPls6mbUfVhqBjpKKll/tSTnGFKzNOW/Mool+xe?=
 =?us-ascii?Q?3zl/1QPk0sIHPpbzrA6Xv0c2i3n4/yxZ0o6XMiiFE7YBO0v/L69V4nPy6Qie?=
 =?us-ascii?Q?E/n4q7SgXfp5GNKR/AM2pXWAG/FC0ly2HmTbc3un+OIW3Itv3BBHZKpZ/RpI?=
 =?us-ascii?Q?YjRTrF+9HVhpcBhK2lzbaOsdH9m1kqM6iD2D/HB9DddoLNaw+bdSlm7NuttX?=
 =?us-ascii?Q?a1WyRCuW0knTqqXCCaEZ2csR9d2STFfCki2y5vvL5zUKO4iO7nNkfbWqlB7u?=
 =?us-ascii?Q?t6cCKS3l3kjqs2lifdMA+PKY4WEzbumKMllYUduOxc6ynQvGZpset7iqMYhu?=
 =?us-ascii?Q?oP7LtrSktnLDAgYvPtlcBsbItQsgCJg+n4w2qoarNeaJeo7ycPGqL1hiERub?=
 =?us-ascii?Q?/k0qyewozqXngTFZ5/txbvdsjN9Ph7Qg/FEm2z39r6q4iHfC81CBB7B9QuZe?=
 =?us-ascii?Q?LR9YimEoLXyu62vSbSIv+OMhnarODPCEnRD5ii23J11dTEvC2zOwSB7tmDYk?=
 =?us-ascii?Q?KUssYrJUWn8EkqhaN2eEJpsv7iLTWLf8QAwGdEmqScgnki59wyLR/cPEPbi2?=
 =?us-ascii?Q?1s+3g5uuy5SSBZ9lvzqWF7JEADx40s83kdrqAv+FkyvHEeupu2QwahqkWxXT?=
 =?us-ascii?Q?68nAsS07v9eaYQO1dMpmmHlo3LdE+JOhLa4JJ/8hejTbOnNC7bKs3hv+bMt/?=
 =?us-ascii?Q?5ER9Lt3XMZIFkN7X7+t9c770j2/elE+7x08PgcPhlo7FKhmV0vMzSGyhvS7c?=
 =?us-ascii?Q?UP6XZKU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7IA/qgTbmVb7ejYflZOa4eykG3yMyOkOOJ/ozTd0unSPh/95ayxdiALaGDrh?=
 =?us-ascii?Q?E6Db6BN0N20xncevranjmX5xhfO4a+AW7eNFI3UIf5TPe+aelZSm6naj6WsR?=
 =?us-ascii?Q?YwRjLHDCsZGfbAPgTU9DL7Do0nGv6sTwD6MSBT7WVjkwMxpmoujUcwhdzvL9?=
 =?us-ascii?Q?pstV5ZwtTzvAiklQWeWACM6xNeJ8jLLyCBbgNveK5lS8XvzY8rho2lZaC09m?=
 =?us-ascii?Q?kQuuAAtpWSvReewG0QMKk6GvJsqO2IDfPIw5fcAlcgEubiWPhPiXOG16824b?=
 =?us-ascii?Q?wEQURBxtBvZi3AKemfpOnERBsaioEh7ZCFBVeUzh13ia90ctXNaL5Drgp/zH?=
 =?us-ascii?Q?NmfJNd6MCqf2IlAhOJUoq5pmg9aJIVqTCHrDDkVDDPXncRX/+2uFgNIiVn0B?=
 =?us-ascii?Q?iC24vcaPEuppNQSaokGVoqZC1BnDMx35B3wvdtNUMfQ6Qas5OvfSkkg+IOmm?=
 =?us-ascii?Q?+2Sju22Q3rJAAkizP6U2ruo0mNlqMq2tyZvcmwFUsOewbRvTQjbpZmNDDUvf?=
 =?us-ascii?Q?kjI3MXdA9nYFmsMMD88ewDAOwPXSfskBq1WzLRAYHwmza0RdR8kb1+rAZ0fs?=
 =?us-ascii?Q?yHectL6bAKFpkzUdsFmFKOxpJiQa8K71igKpK8XkV/NQ88LwlZC+vaP2yIK3?=
 =?us-ascii?Q?gAOEam8oyAEgFvUQEgMH0Iej7w9aEENpyFmzfN+33J1zBLwZCw5Vv4JblOoY?=
 =?us-ascii?Q?39hOIF1k2r9zzxvZGxZCJwjGc1WhgLCZDDNBzlGR7RraVBG/BmrALnHtfbzU?=
 =?us-ascii?Q?LtPbef6KDdyVeF+G9Sn0RLhYxM7dG4m+6b2CD9n6iUGJotEuVF3TPIVC9ytG?=
 =?us-ascii?Q?QgRnckv8jFmBJwbRqi3jc9AjDS1oU7F1HncZKJJtIiQ5wQGcH0v9PBGc2RAL?=
 =?us-ascii?Q?Iwziw1Z7LFqrKgCNIj25gUqS3yXhvcCT7vMHeJjP3c3WDiweGdJZK5KWBTgq?=
 =?us-ascii?Q?bm56vJ4rEcZWsUG4oGd8QY9jmP5ZZX+WDSndJoujwaiT9qDutL7Cv5AT8Ky7?=
 =?us-ascii?Q?0qT9WbwHdRtoMYDi40yYy1gOzTBlIj1dKajYXHabbFtVGjwtRnf86qmbLbpN?=
 =?us-ascii?Q?UMtcTUhggwLHz1XoDMtfyp+1aq17NykbDhp8ON3kQf9+N1Ps/cItJTimX6SI?=
 =?us-ascii?Q?jG7c870u+is5IVrBe4Y/NZ5ZiaH0OSlSI8aYCp0SB8ildVcDoqZr2/twlMpK?=
 =?us-ascii?Q?aDNMDQL9wFHewxPUvKJxiuLXwxlQkO2Mp8cyxMmAL8X6Nx9d/v0BlDsPnUyb?=
 =?us-ascii?Q?PkIhS2tZNHzOEoUln+/X51q5XbqbWBdzU3C2pnFmb1Kr49HHZXio2MvCzZ9y?=
 =?us-ascii?Q?TkBPKRePkIlSgXWiOSo5hdw14s0UDb5LNW/awXT+ejC8eLA+CeBY9Ln4/cqZ?=
 =?us-ascii?Q?CIhOoIAhT/KfpUXWAGE+Vf5GYWuIKsytrmMQEykizFZn/kUMmUuBg8Z/dBtN?=
 =?us-ascii?Q?J7U06nvs1VmA0da24XCEZaNletOmq0d2kIljVSvFVPsEctr1N4b16Zuev2Q2?=
 =?us-ascii?Q?sE0V013Nr5Dr1pM3Lr279pMTdubU/cy0xEcRCmJ5Rj+Slw7V3iu1oT7D66D/?=
 =?us-ascii?Q?NFnw+XH37V3wkp2VKewB2pYF9bnfphEZLBHhDB7kI7+A5Bk6nnxJzH+j0X3s?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e180552-79fb-4218-6e5d-08ddc4379bd4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:08:47.6512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfo3RE6jJvfgzSpDTJuIWT4UsPIL/PWVa7PCeUvPRDbNvaSLuqkBRVSs52ygTUCu2Ng1M4+V7m015m3o/m0bukjv2Mvm3nUXKNG89aLCmIM=
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

Enable i3c general uclass driver. This uclass driver will have
genaral read and write api to call the specific i3c driver.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 doc/api/i3c.rst          |  8 +++++
 doc/api/index.rst        |  1 +
 drivers/i3c/i3c-uclass.c | 38 +++++++++++++++++++++++
 include/dw-i3c.h         |  1 +
 include/i3c.h            | 67 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 115 insertions(+)
 create mode 100644 doc/api/i3c.rst
 create mode 100644 drivers/i3c/i3c-uclass.c
 create mode 100644 include/i3c.h

diff --git a/doc/api/i3c.rst b/doc/api/i3c.rst
new file mode 100644
index 00000000000..7906face080
--- /dev/null
+++ b/doc/api/i3c.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2025 Altera Corporation <www.altera.com>
+
+I3C Subsystem
+===============
+
+.. kernel-doc:: include/i3c.h
+   :internal:
diff --git a/doc/api/index.rst b/doc/api/index.rst
index a108718ea99..f3b6aefd854 100644
--- a/doc/api/index.rst
+++ b/doc/api/index.rst
@@ -15,6 +15,7 @@ U-Boot API documentation
    fs
    getopt
    interrupt
+   i3c
    led
    linker_lists
    lmb
diff --git a/drivers/i3c/i3c-uclass.c b/drivers/i3c/i3c-uclass.c
new file mode 100644
index 00000000000..72944424c1d
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
+int dm_i3c_read(struct udevice *dev, u32 dev_number,
+		u8 *buf, u32 num_bytes)
+{
+	struct dm_i3c_ops *ops = i3c_get_ops(dev);
+
+	if (!ops->read)
+		return -ENOSYS;
+
+	return ops->read(dev, dev_number, buf, num_bytes);
+}
+
+int dm_i3c_write(struct udevice *dev, u32 dev_number,
+		 u8 *buf, u32 num_bytes)
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
index 00000000000..59c787c21db
--- /dev/null
+++ b/include/i3c.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <linux/i3c/master.h>
+
+/**
+ * struct dm_i3c_ops - Driver operations for the I3C uclass
+ *
+ * This structure defines the set of operations that a driver must implement
+ * for interacting with an I3C controller in U-Boot.
+ *
+ */
+struct dm_i3c_ops {
+/**
+ * @i3c_xfers: Transfer messages in I3C
+ *
+ * @dev: I3C controller device instance.
+ * @xfers: List of I3C private SDR transfer messages.
+ * @nxfers: The number of messages to transfer.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+	int (*i3c_xfers)(struct i3c_dev_desc *dev,
+			 struct i3c_priv_xfer *xfers,
+			 u32 nxfers);
+};
+
+/**
+ * i3c_get_ops - Retrieve the I3C operation functions for a device
+ * @dev: The I3C controller device.
+ *
+ * This macro returns the set of operation functions (`dm_i3c_ops`) implemented
+ * by the driver associated with the specified device. These operations define
+ * how the driver performs I3C communication tasks such as reading, writing,
+ * and message transfers.
+ *
+ * Return: The I3C operation structure for the device.
+ */
+#define i3c_get_ops(dev)	((struct dm_i3c_ops *)(dev)->driver->ops)
+
+/**
+ * dm_i3c_write - Perform I3C write transaction
+ *
+ * @dev: Chip to write to
+ * @dev_number: The target device number from the driver model.
+ * @buf: Buffer containing data to write
+ * @num_bytes: Number of bytes to write.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int dm_i3c_write(struct udevice *dev, u32 dev_number,
+		 u8 *buf, u32 num_bytes);
+
+/**
+ * dm_i3c_read - Perform I3C read transaction
+ *
+ * @dev: Chip to read from
+ * @dev_number: The target device number from the driver model.
+ * @buf: Place to put data
+ * @num_bytes: Number of bytes to read.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int dm_i3c_read(struct udevice *dev, u32 dev_number,
+		u8 *buf, u32 num_bytes);
\ No newline at end of file
-- 
2.35.3

