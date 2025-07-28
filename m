Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86314C83F26
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 08:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DC608313B;
	Mon, 28 Jul 2025 10:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ECl4zEKA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2773E830B4; Mon, 28 Jul 2025 08:56:52 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0087E82F8E
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 08:56:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJevoXnC2RcrgKAFeurh3PGXMxBk02IZfWrpCSy8i9C+pFgJDSFs8zvjo5JfIDbmkjnI1C4I8aKY8AZKD92vGinFlBv9MlkpYwgmNdCH0P4S4t/MQXeEyJ+ugpI+gi0eHlHWBJktC2BJHpiCJ8TXA3v1fG/10LlEuvZwgKWmxOfwKSdcn0cOMvbrxeQws3BJazJ3pM3pD8rRj5JzAWkBOJN7Fde5Pr4v+Idi1wSjBBKzD0kqujrjwBSgRBCdsvAF7mGuxQpJuBR88m00HDQ5FGPSz5O8Rmef9z6aqjwlDXFdBbAOEJvCyf2Utv1rIGp1DbA8G7HoBIh2shAzdoQz6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdQtMV6emyyzYUrYkU1OHIp2EgOxdFaZZfmna0FijXE=;
 b=U2EUlZEapQaQhta6UPmrs1m0qBIqaz2u48yBDf06ANiSwxHz0LXJPhbcWNwJ9PGIl2L8uBqCiJEYcQ32WUWCl4C/EUIazvqqeHsf/+nmfh+1Ogd+pmFVv/yviEv4r3t7vZRO2rt8jJFt6Ky6cTXiswCzvqZVpraxZWPWVcICRlSWuZXNpmYfdZe8H3nJ17im7r1iP20Hs9tZpw9Sj+DsSGskRKnguTqR5OG3S3OQBytRWXgRkTWoVNXjLEc9rhbL+0hkkyTZzEkgM53nKRmDgZvd71c6B7gXSuCOdvtefhjYk0O211+yRNF5CVWkK4BzuR3fORpy2jRu5UCDOjPMtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdQtMV6emyyzYUrYkU1OHIp2EgOxdFaZZfmna0FijXE=;
 b=ECl4zEKASOr6zMORDcZjiN6dwsT3gEB7CtSbMaFoW1kocGdbZJArhU6U/uo+40Y5acjowO6BsP/ox12ojsOiYGVXMhJrPzEoozrblft0FXXUrjrw9r4ldLYqajh6bcuYuqZIGkw9facb1VM7Kj4ONIG9km82oQEKQpprvUXfMTs6e8KhtWtJJUW2kdtTqKletKj7LtWvGDV6xznXV+bSk1wFq2dAI7IGXLwMLJLUo3a9WNF4SSkBe86Eml6U2GZQ6W735xmKnes8WKfCrExlxqubFHnotqmFYo/vpNa7FPrt6xVH0GeD7e72IbNk7T2gEBcOd1Bplg4/OMryY2ZDvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DM4PR03MB6128.namprd03.prod.outlook.com (2603:10b6:5:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:56:47 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 06:56:47 +0000
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
Subject: [PATCH v7 03/12] drivers: i3c: Add i3c uclass driver.
Date: Mon, 28 Jul 2025 14:56:03 +0800
Message-Id: <20250728065612.6039-4-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250728065612.6039-1-dinesh.maniyam@altera.com>
References: <20250728065612.6039-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DM4PR03MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: d292bcd6-802f-4920-3abf-08ddcda3ebb4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3hsDzcQJqQJJggulrG4UOLUGwQR9jxTEYhiodw35NyZ8GQGp+3ZPKSNztLFn?=
 =?us-ascii?Q?2uR937SE1gXAFrtU9183eff4ZIbnJVVA2EIkYq+h7SnUyacZYxNsQYw8aMTQ?=
 =?us-ascii?Q?MN+00spXlMl1cA1gVxyDgnv4nGZZDZwMsUqTWyiXOEuVdn6XacZN+I4wlzT9?=
 =?us-ascii?Q?mspQUovpvLSikIy1hmLKqVDSHDB1DBrWpIERRjkYf2XPZgwZSfNLU5do6EUd?=
 =?us-ascii?Q?/PpTm8uEXsUZB0vBrS9F45ySe9vNQbT6h8+x3i14ITlMm7BV6ZqpO4Pli2ch?=
 =?us-ascii?Q?DjwRaOkjGg6DPmTpjuBZwUGGeQDaoeJQXNbOJg1OyRR11S/VJxpc3HJ2UXAF?=
 =?us-ascii?Q?Hf+H7lISf6wMrJCorlE3y8P4aIEJdHDpOsuSZoGQX8js7tKlbpzVOTff6oB9?=
 =?us-ascii?Q?glZitzo7leiQn3bF7VBNZqoh9d0381q+ejX8edWGTKDDYJ/AKLuxe7zvldf3?=
 =?us-ascii?Q?OZV0+8YCR7rwHBzcqV2a2qcvCQf+wV8Lah3joAXAlPXgBisdSyoHBnlMD+Z0?=
 =?us-ascii?Q?x9xLDj20f1eQG4soaQDip04vjgqbA9LfFMhgYy+DFRqr+gy/Zm8OJtIhqJ4t?=
 =?us-ascii?Q?TT7dJEF11PiMVEXBv8P3C9jsW0C/1V3AkxeGjPw4eod5b/a33jk+YniLaaQb?=
 =?us-ascii?Q?dIakWhzIterLcHNkq81yfhyLKpUFm7lYSps+lNSFONYqtUF6Wwm7Iky7pj9H?=
 =?us-ascii?Q?oSALu+2Jx65XCdlWYPEHy6VAvqOyrdyUEBL3sq/NF1GLk3X5N+So6OGVJpwN?=
 =?us-ascii?Q?X3coP37e6CSa/kSQwTofhqDbDHMzGQ1d0cWgWxsSI3EYLIVRcIi24gOUB5jB?=
 =?us-ascii?Q?PMKQzMZUX9Hznx4gIvlcfz80YqoERSvFOxfliH5xAOWoBHP5ar74zRrpWHdu?=
 =?us-ascii?Q?PoDri8AS48iMYAqsqhbS/SSudg1K5KPRJAybcozCigDpdvUK2Bp58OYJySmb?=
 =?us-ascii?Q?qJVUX7UG//FdTYCmcZFXMxF/0og0i0rJfm28UBhLYdtZHL1AnDlvKdKmE1Js?=
 =?us-ascii?Q?Tra7pnFR2b6o7mCI8GGa1HutAZwsPnvEUthSLgvr6lG2hsFAo+04esHIP+lC?=
 =?us-ascii?Q?zmzh4RRHvXucbWdQTHAMVdkLrurfgb1Mf/eDDo6epoDHW1v7yktaLNa2NIEs?=
 =?us-ascii?Q?QxNmJcbdhJFsNXol3Vz9MR1PIPLaZy5HG7i4HxC82D18TGeca09BQI0MCbxD?=
 =?us-ascii?Q?qFzXXOnFwXwM+Fo85sgUmqB7VbGWQFY3oLfqz5VLiV34ohkcCIF6Sk1Mer3Y?=
 =?us-ascii?Q?qd5qKycTrzMjkOIxNhdYuTuXIdjGmhMnq7SzawUwwrOvakdH2WmkveZE6Wal?=
 =?us-ascii?Q?KqUJZfQ7Pf2fETdBOu5WFr2GXv9M4tBb14aQUMeCSeUmmnwDVgeFRiQLL8nQ?=
 =?us-ascii?Q?sP3DFkQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dgws0hYswxXYreusaFwCaUKKCvY2Wqdor5RJX+rl4I4QeyKghUQczS29DioT?=
 =?us-ascii?Q?7MXLvUAtz5EGkP2RAaEA87pn+LSoT2FkprKjim73BqxGiOqSo1mNF40hSYbG?=
 =?us-ascii?Q?hnO2rQmsgqbfTQhVUR+NNG9CYTNgh82DcGNfR78/0nBH+YTpqRocbWq/6sUy?=
 =?us-ascii?Q?H/Xxr8ePBctSRFAyVNDBG9AUqBw6NdyiesvoCdej8dSfMe8bj3jc+L9hNo/H?=
 =?us-ascii?Q?6t2HNSPCA/9TQWPI/hG9T9Bs20puIlroRn4SIt8UIGoQktXQe3kUIYLXj/xX?=
 =?us-ascii?Q?H3YI6GFKEhN4wugH8B81ETaypl9k6/0yaamribejxJg1lLhtQoH81k1cY0q0?=
 =?us-ascii?Q?e1xVtsS5TBn0ql8cnqkJTgVQmTsyWvG6dR3//uNbcWW3tXDfs9cNANid7/UY?=
 =?us-ascii?Q?k23l8AVe/+As8kYpbYc0KFUXJeNcqIhACE4dzyhlyLWILmGCCRSd/JJmnoiM?=
 =?us-ascii?Q?muI5K79KZB6gTsH3AZ3x3FRrYsXYDYPs1oKnpNREEW0P+0lxnKV2UXlNDcCl?=
 =?us-ascii?Q?GiKkE1r6KDRFFAkkGF1BO6smmlfnq+b+VXZlVxkxhg74vlJhfy9iFHR/cTuq?=
 =?us-ascii?Q?f+UCybEAPhfgW8Fj9BqXqY+GreEgP+wusJXwC442r3nYc7t2S2kTSlqQiyAW?=
 =?us-ascii?Q?FNCrD4L0QQgDHBFuvZUoP5F7VOvdnTnIqP0pbz79xv9KVXYB16Do9VlhxK2y?=
 =?us-ascii?Q?sHwGmY6OXgdxOdVhbYAjK2CpJEht/6PruuObxQb1mSFmvRkohlbFd+TCNAR4?=
 =?us-ascii?Q?9NuxwTfCaJ97Z0xuTfmJkP69Yu8Wv+KAsJCznoBrVJdzz1KUruTXuJkWFMZ3?=
 =?us-ascii?Q?qZK74P3GsoYSAOwxQLyRqv5nLY8m6/6GvalxuzedYtXOULfVAne7nLH3UaAH?=
 =?us-ascii?Q?L2sPHmPpwCklFX3IJyC6S36VnL8TqPynjSk9WcdaOcJmCPd/qtRu7e4Vhf9t?=
 =?us-ascii?Q?DR201OW1AfzGiBxLNhE/QQz2q9YQli5jroEzC/52h+b/1DAOq9UB444HxGu3?=
 =?us-ascii?Q?TIr2UdvH/II15zWG5pDvGztE0AQPARDH3a342l44Xg8U8ShPyB4shfKljKg4?=
 =?us-ascii?Q?/PIXf1JBA3DjPjsY98aDcXVi8Fihe0mAScpMRY7eshF0IiPB2QfahYj5NlzE?=
 =?us-ascii?Q?AB3CipcWw2kaGKSmLskneYfnZYYWcvy6MmMqxudGIMjiEI7DQ3MVW9IXQ7d+?=
 =?us-ascii?Q?3dPvYoPMvjUSniviOPK+cyTKngbKcoQ2mBJcYauCWPLGj+3WMMRjgSKMKCjr?=
 =?us-ascii?Q?CkX6YIKSw4Tub7yvMIWQj3snk6f4kz3S7adzGailNhUlfZPViQDKUHBE7DOB?=
 =?us-ascii?Q?wloVfc5dibas7vuHSH3+tKJ+JeNup1kIrO79/H5mWrwAIK7ccy+oVQxOuZAf?=
 =?us-ascii?Q?foJPnCW68vAvQt0u8hrOA01fb2QM2Um/jh8nrOfTWraKnEenmHBY3DeZTMNt?=
 =?us-ascii?Q?hYMLfx+50kpAVpPjzj22MvooTe3Fd2Nv+jOPwLkSdih8fd/K65czBFEIb9J9?=
 =?us-ascii?Q?d65mOL+5PVjHUdDqoRJJx6tybF6rNqa31CF9MBllDMUJdb9AtxEKzATqH2UA?=
 =?us-ascii?Q?rA3K+CEZJ91ssEkqPLg/cCmReHkBENzKOp9XcF970ztoGW9Q4N6ieFpJYwq8?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d292bcd6-802f-4920-3abf-08ddcda3ebb4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:56:47.7743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3TgIVqhHhHa6flcK+FaXWlz+3Wr3PmctpPAyoSBL/eqyF9r4DABYYoPPCy2KEhtyjaCztGumhPXF/2a/NrAHN9Q/3YP5WASMfpYy/iqXWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6128
X-Mailman-Approved-At: Mon, 28 Jul 2025 10:46:50 +0200
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

