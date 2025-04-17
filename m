Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5854C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 04:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A23BF82FB9;
	Thu, 17 Apr 2025 06:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="khL2a9HH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33A1A82DB4; Thu, 17 Apr 2025 04:19:57 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22FC882F75
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 04:19:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iS46OLtLLxkPR9/9G4Xv1sEfSUjSSENFIdyn5YDmRZKkRYHJAxSl3sJlpZIGjENtlDqIFdANGBHTeM1qMV5znIXPd6ougsOcMoIyHNOS8T9ToaWCZp3ORL4r8xGXw5iUE12m6LzXxJvPeH9IGUv/rET7J4Zyp1ezGZjxjcKAO/o52Z3DL35mQBGVBDXd1o+Zote69Y2bLrBsWweobYNe/mB9UELKbaTU0HxKwOO4gJ29bQP0k2xcBx3mfkSVNl+sWxb4u/l8g6xnbaDXIgXoTAZ0yzxQvQ4SdBFt5Cj8rt5rmgh41r2M/zOFLx4Twh6mG8UzUG0AKtPbBU64MlqUcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWqacqKoANrLV7nVA9RVVj5qZ/KZrmHlCn1OQNBKdgg=;
 b=UKKTLp/oGYO/BUl5Vr9iZCgMZb8A4cCyxQ1nEwsIj1F6vjwtOzG72uDNACfGlRajQY9niCQ0EFTk7BcrDSgyqPNXGkaPB3suRkNKGLgJWq0FTqHI+6OQTrNmmFgBoE3NVJCUljFRtJULOdjAdBlf5rAtXf3gepZN9iANdWI+YRTp541Li+ppaDkRfr7ePblfoj0xJffR+RFViRDl577hlrPCeD8HunaoS5kgaYgIpy9zCcgosYPVh/uo8TxP81IqU2Kh/zfC8Q6nsxUS/rO3Ok51O5p8Co98uN+VPUT8qItHCpJ7r/ADcfxkS0mZmHKz3fkLJRLjDX5rkD41yEe4eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWqacqKoANrLV7nVA9RVVj5qZ/KZrmHlCn1OQNBKdgg=;
 b=khL2a9HHqmKpWZY+5ok/Jis9PSI8UjVOTBx2MyL7ZkrSYDjRmHJh0tAsoHxWniR+admcRpSZhRSBL7DnSfFV9gNp1D2FE2E6LfjEJL6oIfmvcACV2Uoq3XZc6Ary9TChea0AJ6svF8xaWm+NdreL7S/WowDYd5zRh9HO7ROYMySLsvK+WDAB51Zaxct9+V4K0Ecw3XPfRAycsppb2/+0zTjEtLNYVLZlVNo+oRMY4tabK6uY4zMty++5c2Y68KOWQZl1ZvhkvBHxPbKcI+pMJNvEeIKVNX/H+lHL5KLF/ScQTWSMutaQH3EBZPYNz0pZLsfkYaux/1nZ50zs+SCcoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by PH8PR03MB7197.namprd03.prod.outlook.com (2603:10b6:510:25d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 02:19:51 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 02:19:51 +0000
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
Subject: [resend v4 03/12] drivers: i3c: Add i3c uclass driver.
Date: Thu, 17 Apr 2025 10:18:31 +0800
Message-Id: <20250417021840.6212-4-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250417021840.6212-1-dinesh.maniyam@altera.com>
References: <20250417021840.6212-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To SA1PR03MB6370.namprd03.prod.outlook.com
 (2603:10b6:806:1b5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6370:EE_|PH8PR03MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 084443c7-a89d-4431-da5c-08dd7d56559d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tEL4lkzEM6Mu77ea0Tbnxqv2HscJFtsFJ+6bJiYl1ZuckCZFJm+Q3TT4cFrC?=
 =?us-ascii?Q?5FE5AbqK9ezq7/ciges6ISTTnY6TdJsfcBIBDwMHLpqDrxNv6YzDJgn9Yjby?=
 =?us-ascii?Q?gCEgOQchQvvwdFmQDg2Wv+zN0NCZnXQOj7P/IHLyxMYS7P44cHX65t0y8KGS?=
 =?us-ascii?Q?KQDWXJeiicMKAtnWvDCqAO73JZtW8HfhREzIReU15fX7IyHVW3T7i0fMxZgD?=
 =?us-ascii?Q?Lg8XVaq+AIsxtGv2aA74AyAdu2BsNudgJnHaGw1jxPdbl0xxjqe1DCztm4eX?=
 =?us-ascii?Q?YOdd/PG6HIh/8xSPaCSLmp9/Vr37XPO17xr0GMpdzFf3enCu5n0gB9jyx8VV?=
 =?us-ascii?Q?+z4bfAS3NJHfKC3NpVsSbUO/V2QcOysZjOXyizFxl1dXMlUMhjadUb2rO+O9?=
 =?us-ascii?Q?Vg4o8jySNUtAaIAXJimEg+S+okgwO3tl55UuuwBdVNSh0WBZfCJDs110cIzf?=
 =?us-ascii?Q?kVC6nBfHiHPy43RiZgK/ffUEVOOudGu78tyP/wUt+WX2sBxah4+cgesc4rAQ?=
 =?us-ascii?Q?ZcDZKURyaIMYKKQub04Yj3Usr/JMCqksORXgC9GJTvig+0V6v7WCEKFAHeBR?=
 =?us-ascii?Q?hxHiPxENyDy7sr+ZzLDHp9uq3npRZ6WXSmnTdm2OxjSZBJU6GqfXFBVcyCVb?=
 =?us-ascii?Q?mvWlhs4IHx/Ipx+zRPT7z9HqEnygXb224o8HPrA1+A0RJfSyTU5QQcjcV62K?=
 =?us-ascii?Q?6gYkYjm8saeFVajblSUQSdFJ+2H+/++p992mC/rJrbOsImOu1q7Y28bymhms?=
 =?us-ascii?Q?FV80H9EVGrw0xshy5Btu+fQYtCD0rrPC6wrVgsmeNhmzKMdr8mb97Ht9Ikzw?=
 =?us-ascii?Q?0PkyLqdWCqMsZt70K/b07NTWm5d7ByQWLzK6HEH+Wh+rX5XEcRL0jE3ZtV3g?=
 =?us-ascii?Q?yGdXgmfnoxFNEt29WnrOZlXTLD6L1KpKU/AAEGjnJ8H+PoxPeFfwss3z/HcG?=
 =?us-ascii?Q?CXiMZhLTc+PLJF/XGdjgN+tLwRDNJ85mq8wnMJxvAt5baChglY9uuvA9oZwm?=
 =?us-ascii?Q?JWKdgWLBSCTPUK4AhoCbTtG3PY3FIWHdXJ29A4183B2wy+17rHS0dYWfsrOL?=
 =?us-ascii?Q?SAvN7DPRj7UdLsaJW5jY/QWJHPYSpkkLqR2O43nNrEds9jhPBWBVDa27LOys?=
 =?us-ascii?Q?hBQxKB0tteAOqV5O5NK8+TTISKKUYlywyDa49pD8J7ocoAAcwpZJ1cuagIHO?=
 =?us-ascii?Q?m3PEFOXkEdEgZqmV8ofqaOVr5Sq21I5gonHp/H/snHO8B56JiKJFktT6Ggn2?=
 =?us-ascii?Q?opPoNSthFpx9BcSabEBqczeemYuEmatNcEsYAUoP+/BLIILJQ6os3igok5Ih?=
 =?us-ascii?Q?lPnNrWR/noXBf3LFgpAK5Kyc6d7Giq5Do5uC0Xs5c8LotXwk8U/zKzx6VPnK?=
 =?us-ascii?Q?VJVMxOc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xgIQqmNQ8pu69cV4fBEj8rT8qeRdXPrSxiLuBWjlSyPiu/DV0/yH9kRM/tbN?=
 =?us-ascii?Q?ooM3OETMDA62TDNKADwSknxYRQDIqjBXGtsXk8KvUT+mr5rOFwioL6qzfBzh?=
 =?us-ascii?Q?Rp7YrTDQmVY30fZaaxmpJrCAUR9NSCzqf1IomeMUme/2x55xoxgHHPvHQnXY?=
 =?us-ascii?Q?m7ueijE6RKXgNCwH19CTQLMzWNbdAIQ+2x3w4hsPke8xfMHc5qNP7DyvVL7Q?=
 =?us-ascii?Q?T8r7jtHObHm7zGoU2NuzaBV+0+84OmoPsHfL2ewBjdyrQpWC1w8UTcJj3GaS?=
 =?us-ascii?Q?1evFwTg9Kf2pD9WAZKuBp7Z/Uea6NdydIhgKU9sMWYgPv07eRpNkwzVGcKBI?=
 =?us-ascii?Q?8n3cX2ttUAqeXgRJB+qMqt9Ake8dcqr6QBt7Ne2QnKDAxqRz/h/VGofsrdbG?=
 =?us-ascii?Q?CSwYD1mrSMXuH5IW3AGUwD4/QO3q+cDiboIT9pLnsdAUjvjVcxjoFKx5BBOn?=
 =?us-ascii?Q?B3dwsqVms9DECPveR9czg4NEADbcgi9Sp9YVPVF07J8vhDcJxn0md+JHFziX?=
 =?us-ascii?Q?Gy8Dj7S9Vhv2yKSfSFIdPvFPlGZ8tFUxdgkoJmjNPepnO2sHNKdqyPMUW85G?=
 =?us-ascii?Q?FY29/ERGCKaOnFyi9bz8/gJEgvhAOgZX7++1IU1bmpCUHbXhE8PQQGXnGiSi?=
 =?us-ascii?Q?iRuy+HDKXJQJ1Ftr5ICOfGxY9n1iJo4ls1g1SgrvXoizccKqZx4EIqp6VNg6?=
 =?us-ascii?Q?Z+ZqOi0xLq44pb1RrtqEyAOHu8/z2bS/qGm/zIsw5QAT8Sxp90r/Il0/8A6u?=
 =?us-ascii?Q?tIFpEN/AmP9XN38iAdhNM5v1MwzKFZYDVDaqNLE848Bv2fdvV4muZwMHu24E?=
 =?us-ascii?Q?Ax4evOYtqfQ9t1RxmUXaxb1OMiYYv5xpUGsMiKFJxkFmnq9Ojy+3zKa6gj2I?=
 =?us-ascii?Q?O4RzCuooCDYdFTgXFKt84P28uOk5iaEgzWzHJQTpfDWXjch6J9vL7lG8XnsC?=
 =?us-ascii?Q?KnFOE7leptjOdcMIJ79+HvwLey7btwQydDbnFIwL1k4Jqw/rLTqw5hjzoDFo?=
 =?us-ascii?Q?DkA8RXy4pAQg28pURC7wQhAjjUNW2jkcc0lswrtL7/I/TItCQA7dskigceZr?=
 =?us-ascii?Q?fEIP8Wyis/z7dZFNx+Zj5oh4awnfkmrA5XOGOrj4/EA6SZ0NNKSP1HCGBRQq?=
 =?us-ascii?Q?CQwSyQktPzDbWUcKZV7OiIGjzY/HbOEdsG0BQ5ZSbUpS/qh4y7ZvPpIj3EBj?=
 =?us-ascii?Q?VOF12jaUFNQgr9QKAzRN4MeWs+GeGxEmBWg+gXLPs52gMwOhmlHsEm6Qe5p4?=
 =?us-ascii?Q?GAbnGz8Wjc7Vh+a0WG770WKNbpYS9aZNBV4Pw+QSK5pcwDBLAhIWh6Ztjbiv?=
 =?us-ascii?Q?85bgPs8HnXdOIklQLFweroiN1TkMqUXVDTxIzwnCyQi7D7howr6QcxUbsThi?=
 =?us-ascii?Q?QMVfiaXUfft98Ben0PcTtq7xikd+F73gHyYl7APD+vJ0r4GsgsJsgAGBvpgk?=
 =?us-ascii?Q?e6Fh21+5Cu4V9sgo8oyJziGStBNp+8aTSd03B9k6+5QsTpl2yRRbDKs4jKMc?=
 =?us-ascii?Q?zdEKknC5lmEIhK6nwBFHmFIbPUOsJfGU0fjLjmoWkNWWbQ77T06I2Ijt52rB?=
 =?us-ascii?Q?olLLgew+KPnP1YLEraKEL0BRA0yYMdjXZ1ynhwgV0fKVxRZQPkWFb8gC4+u+?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084443c7-a89d-4431-da5c-08dd7d56559d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 02:19:51.6496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRJ40W0NMHHHTn8E/PEbeWjW49/DfQKkhNZiZxcwMRK6ilfHm+/DtoBfTe2z1ETMQ/BrX82KidcFHTk2RUpcs6NUv710JeShzRSe/D6OLqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB7197
X-Mailman-Approved-At: Thu, 17 Apr 2025 06:57:49 +0200
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
2.35.3

