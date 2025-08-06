Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172A1C87FD1
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 05:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C32F8425A;
	Wed,  6 Aug 2025 07:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="HXnLmynN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F6C7839B5; Wed,  6 Aug 2025 06:33:42 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D11A7841CF
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 06:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKTuv9TMSdjrv56137jQRHGvjG1efS1iCtVUSObjcRk6PMTFeyiF2nc9VCCAw1g5z26poTVfMoF7n6o0IMuV2597PTUqkwuNETwYleqPcnD/J8fA5lC/rkSHzxgufJT+jxSLGnOwLmX7wmwh7QMLQoa2fPHb6aiCR7xHx7NaJAMLVZECvmaL3cvKRsTMtlJpP+IKPOU0Fca0WA6fS7Aaw2Gx7Nr7SBnfoWIeJaCC1kI9CM9cy2TqOGBLvwuVyJrt6EGuYJGxwMnUeqXJLewPru/1MotqeDvGhnzjdCxGxX5DonDjVPiEqPaJhv8yh5/NErwEwd2rFM123SzEnEYpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdQtMV6emyyzYUrYkU1OHIp2EgOxdFaZZfmna0FijXE=;
 b=aer7lRN3DyM0GK3tcAkdOk/cljZix986DdQCzzrbG9IVe2VUVMIK+rxXbzm5ijTEAnSwM4xqlpR7mAX9npAeH4lorx36xOJW/NgPrI2+PiLICapbQiwnOLZhjevrqjE6+1No7ijk231jbf7ASVWKi9XNA11UiaBWJKPV28eLQ3JD/myAHML+MlbCM57PzNm+Zc40xqnTSo0p1RbK41pSjW4pby4kxjIqBe6CyWHb4ZX5oVxq4BmeRLIUlT5GN3Nl1AqEL/fN3cN7ev8T1NF2mGaQHVjXW3Tq6sVsV1aiM3r9Keg4yxPttf2Ono9WM1X4rTXmr/zeKfFcBmKxr/E3QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdQtMV6emyyzYUrYkU1OHIp2EgOxdFaZZfmna0FijXE=;
 b=HXnLmynNrNUsD0zd4ObJ2xi+45IrTMseWUxx2QMXyBbuaQpXIz/8OlSjiWmFrW3z9KlsjHV/iiS1gS90fpAGVfcw4/IF3itM7U5cUfRIdYA0ruQtYSKW2A1GFVBr1e+qSs1pYIhe5AkE0SrRFXVFdW6u8vhPBeDJVk+Pm5mjjNocjVz107dpEuqwEtqP9rwrlFZ5+i3KpUwhKUM/IkofAmxJFEwlv3gDU/mA6CMVC9ssZfzCxoQlUyWoLLXEW6kilsv46TwF05Pa6k1QPvbq58I2/Sz4zqj44dpDTv8WwyGNAaD6sLqqG1DMJbiXGlauTIVbfzRDdW7KqIDsEPYHcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY5PR03MB5202.namprd03.prod.outlook.com (2603:10b6:a03:220::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 04:33:24 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 04:33:24 +0000
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
Subject: [PATCH v8 03/12] drivers: i3c: Add i3c uclass driver.
Date: Wed,  6 Aug 2025 12:32:26 +0800
Message-Id: <20250806043235.2260-5-dinesh.maniyam@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 39566882-b895-46ac-7d46-08ddd4a261ad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c2/K/pPjiedzs4ParJuR7KSjEMa+SUzt2BsYMb7aY0/amTPkcSh8e1GQxK8Q?=
 =?us-ascii?Q?pshFEUuKeRREpEumeAQ389GiGEQcUhnAukdyDd0pgyYKLtDkLnp5sS/ZMOxv?=
 =?us-ascii?Q?RCkAkdDqCLhffFQBWPUSBkZH09t/+js/rubawaGWZm1+By6DGM5UqeWtaKt/?=
 =?us-ascii?Q?AuJkx0U0zcIC77eah9NLBuzJk5nNOZUsi2uvuRUi9I6c76GrhS3g9yn0xEA2?=
 =?us-ascii?Q?sTNJP/IGMFSjlrRtLlTrrVtGT2h8hQM4mL3SAHH+0PMm2SUCW8A6q1t/MwVs?=
 =?us-ascii?Q?qpRy9bhtED6yLL6+sDDQbQ7wzbBF8cMf9py/i+kIIepBgtJNjKM9jxfF43Co?=
 =?us-ascii?Q?61HTlhv+OAp2UpPDA+eslXbznL/h+vH08jY1NqAbo4nDlMxkLNQB0TVhjCWz?=
 =?us-ascii?Q?tof2tYlZd6ZA5wH0OkXRuzaYcfTN4BkuogE50Y3bU6nHWSlESgFeLLP1PQlg?=
 =?us-ascii?Q?u+zfPDba76rCRtbFlVF4vb1QWJCtvuNo09CMlorIXA2CfKQvuDIEcAHTjZYA?=
 =?us-ascii?Q?diSh/vyKU6LhMAmfpX99StpSfmubHPsnuccaPBhFMyoQH3Peup1MxDxTDMCs?=
 =?us-ascii?Q?XHkAhee+qBty4g/Wq8KN0sMHvYs9faYXZbPAuTjlABvqcNidOgHNvjdJ0nur?=
 =?us-ascii?Q?18A//tW0XmZufNXs+pZ8Ldp32dTjfV8WPlAGKKHBSjZEomW9fgYnBgUs8KEW?=
 =?us-ascii?Q?6AxJWcLYWecLUVxtrK4n25g3Iut1LdRia1Empz98QRbd+zuGXMtI8Up2kjX+?=
 =?us-ascii?Q?wu6KxbWc+bYwIvE+6mcVHkQFaWmNPKqIi2Q7G6kdeXdikLTjik4FEhORBmeh?=
 =?us-ascii?Q?dq1IC5z3hdDdJ99DrUofFix47F2ab2CTiadZ28DtIQao1ivdnIaPfOhTIAmY?=
 =?us-ascii?Q?/GDw2aOKCwXMrqYGXY2rlzAnWxS+ucJJzT/KqUk5Z4SR3jOGI0c1UPGs2xIh?=
 =?us-ascii?Q?oGeKGrgqVVc9Hw3iiTT0t62ZpsQSqW94o0Rk7GPeo2hN/+bTS/6/bN135g5n?=
 =?us-ascii?Q?yxe/lG92ZxZlfZ5kw7vI08h1ezkIHK7zSFSXtWd24aOiNiuSDqJb4kAdC89I?=
 =?us-ascii?Q?rdFd2ZfRta6GSQtqjD2Li9EPgT7ziEhk3RiCqq/FwDR3j8wM5BeHCKh0WdOv?=
 =?us-ascii?Q?l47wMS/nlV+dTshy0LaJGUpemYS6JiMHOYm6TlOalIMTF1PqUE2EvOUt3ofM?=
 =?us-ascii?Q?BJvDAzV+nDXWD/jMz21fstxvXr7u2yqPIDqxF9L0C2xP4IeLQWdhgfO3MYwT?=
 =?us-ascii?Q?eptyv+m3UVgGNKf9B4qe3kX3wtnFCuWnRhmU5PSPXcHiJfkU9/V/SD4rX8Jx?=
 =?us-ascii?Q?8S+1FqeJ3xQzLGKw6qhujZnQcSIxaGCHlEmNGf2IOwWuy6Fc3gIkye/3bG6w?=
 =?us-ascii?Q?IGrhbGCz2ThOy+GfJk5Bu8PTxXJZpLAIP7MoVEC718IZQ75gFLlIzpFEj7X6?=
 =?us-ascii?Q?M8OmnRRC+FM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Cp/cxe7bMHVHqMZvAbtmYe3L2VPTiUcatqXc3n4U3mc3zRnW6v9s2Ghdimc?=
 =?us-ascii?Q?uOMUuQhTvXEHY2vJspyWHo5iWe5seh+buq6NZfATef8KViWrEA7a9zza/vL3?=
 =?us-ascii?Q?Svflyahd8MBgy4tJYkoDhp35h2p09pUqBJTa6s+3o/ZBGEmHGWENUAC1nkLS?=
 =?us-ascii?Q?ePTu/LHtHaFKT32oYstAddfr+wzRHB6XAWx809jdfTQbRqo1nXOralopqnbB?=
 =?us-ascii?Q?2gmpAoXQlUmQOpa17nl1D+/jStDErkEqC/6L7HHC7DLFNwmieqNgpBPhrocx?=
 =?us-ascii?Q?YTMatZvgdzy1sYUqvmJSdMOhcsvrJLzff/IEU/WHpWXo0I0oJCRp4l9ed0aj?=
 =?us-ascii?Q?OMXsotcLcou11OKX2eLvTQ2uuhbMneea+noXzImdJ9+wB25BP+BDRJea2aID?=
 =?us-ascii?Q?ko1EFwdcRTaNgDJV8TeKmIwphDGPv+E1wsf0bp3b3VC5jZQWXHxziKJXQG0Y?=
 =?us-ascii?Q?pjrWgd6rKXIqSM2TttZeVLOTDQt2wNKcis9NTLV3QBFLdqoO4jPfk51Q7vpc?=
 =?us-ascii?Q?SpsK1WMyvpRGXvUKRYHKluwKsvlwr4LS1s3/pmFTrPRUqKqBX7keHSP0QQ/A?=
 =?us-ascii?Q?sBjHqRbXHNcLSae7+zmN9DocLdkWUkvailGXgVhiMTuSnL/iLUk/Rw9lTzuw?=
 =?us-ascii?Q?0XVio+nddG44wF/H7QND8vQ6ZVnUqWTdSi1AZqqMw1i9iXeVdVfTqyOCE6st?=
 =?us-ascii?Q?nDG9pl2qcPHS1KMal63IUMU1kx2tdL3587hH7eA6n/jQoGKRhCl3dF8qb/20?=
 =?us-ascii?Q?liftxHnUg96bJgWZN9eiuxSf1eGxx22p5rLoyQ6ZX30Z/ZTuj3NXVxg/odG1?=
 =?us-ascii?Q?GdnFQvAQe/jt/0QrAMY9oPPBtTvr8p9A+RoBp1HN0fXh5BgBgLKJIssBotAN?=
 =?us-ascii?Q?Tc7PoLMn+9fQnTOc1ytdV6BFCpotgPcjBxugaTpdrjP6Hi2Y3dr8/OMIEDkA?=
 =?us-ascii?Q?sPEQIupcNGOD+KkOI6rPkN66z6W4VIPn1y6YVgxvccawy3iERcBHXQ5IPl9h?=
 =?us-ascii?Q?z/YxxPgwyv/U8kdzs7/Sq/VZNXKBfKqqkZaoVYMDzch6kCy+t+cnntH5DyGK?=
 =?us-ascii?Q?WtpLn9a0B78WC7/BmCOC5TjjqOJE26QRujByEv2HEn6hrD1FnzMeSQwQaSiY?=
 =?us-ascii?Q?1zjwCpZWhKYOP1ACdg2pM8OHegqFao/RP02nFOnkSzMu8OfMOIhnSXIjV80E?=
 =?us-ascii?Q?tlml/uMTK6Yv5CqTKmONy/6Ex0kpYxnQ92RlP/iGameCo9R/UPuqK7wpTZCG?=
 =?us-ascii?Q?PiEJyj7kg2R1N/Fkg7157CF0YFLRuNFGM+tANvdLFPv1kpxYatywDh0Xfl+9?=
 =?us-ascii?Q?JyHOWMZHoqGCD/GWNhbh/PitMzh1Z0zNObMLBBCWwCvKHu8nBd6d/W1T8CUe?=
 =?us-ascii?Q?WycCMNnClxU0kElAnLnFq2DCfK7qoQfZSOVtPAl5Nnuy/7Rc8WYELNpxJGaE?=
 =?us-ascii?Q?CmrupNf7d8w2yiSPbLZjANXftbJhY3sGLEuBmnjmS5PBH1m7I9uJdy51tXL6?=
 =?us-ascii?Q?RBgH/0OVG1+uwCwcBISY1bg+VVJL0pN9jNSMTJ7zEO46mthDlIgdAxUgWCgK?=
 =?us-ascii?Q?U7gtXOz+inT+PnBTrVciKm8wmKhZOTHFTfaO8JDS1U7fhnIJMVDktTnFQ3/J?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39566882-b895-46ac-7d46-08ddd4a261ad
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 04:33:24.8416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: doQqDy92nqpon9VkhdXSnApzIuhCHfQEZmgvc9VnNkluWyqxYUeFUBnOn8Irl+ko/psjFeiCBj0UeSOcJrlwxvqBzpiVi+IeDJaZ17QVv0I=
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

