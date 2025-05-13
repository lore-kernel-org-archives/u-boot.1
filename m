Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D99C3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 12:29:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2F3382A7B;
	Tue, 13 May 2025 14:28:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="muTZ7BHd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F6CF81FAB; Tue, 13 May 2025 12:20:22 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EACD48091A
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 12:20:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqZa/a+yKyL2WntCTOvwA3K6vWIdM1o4Qnnu0+AOtFZdEB4UMFAQZzO9hVFOfbjEXwblsgWncbxdYQeTtpC1ue2rmnR4r2X3FiFl5d99PJXAFJssuXRrXH7Rnq4pUio8RJsaNcwoABcNBfzcw1loeEpTk+SG4VE4HNpi7ZDugsvmeYwpNVn6OcK9xNkldEI6g0aY+4pqtHmnEmGplDZULivL77C+2mvanHJU727Z9Vk9jhqT+rPDr3Gm6wWHtpfpcMgrLKC8ENNRXRVtMr4/OeJH5HRleo8rPfkgEolsf3s8VrcZ9mBDro4dw7bkVg5G3PBqlDS3x+ZEAyy3AbgtWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cF8eyHGjwBpx3teyPcD+F4/Z1o+rwh2yohKOpRKkPmI=;
 b=tyRjnOYSsBpHUNV4EWpL0Fb5FCo8PmZ4P4MVvzFkLmTG/Vo6i1a5w0VSmd/lKEgYnDWjHVcOyGDD04BpWnS9/HZiKoeGgZrJnGSYcwhzbSZ2viSP2f0wlm5I2Uxs9aAy2p/GF9cBx1ccd63pXbsB45KwUNcP//DpNBhmFfclLfx1UJjWcQgfXtWDdZmhPopbUyAGn5Hl8HXmWcDG7doJa5G/AX4BmAZ/p7uC5kJLnSr2vT1XmtAY6b3iPihje/EgCl6ZFjhM/0H4HL8AfQjRsMCkESVh8/LIMHw12ZWhwPGsDbeHcd/7o16UlLYshzap/7mKSVDYrvBMvD8osS4mEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF8eyHGjwBpx3teyPcD+F4/Z1o+rwh2yohKOpRKkPmI=;
 b=muTZ7BHdS/WYpavWCzniUyOIE9siJo7E7GAd5yu7ax5h7GcratPfv2SGuOJWAvvK4sMSvGEFMkN+cgT7bHItRWwEMrvqo50LHLnWiiiFb/OdPfeaT8xVFuznpGp36cTi6bgzRxbCYLFMXKIcFclQpw0uKsJXtaKlkop6KErrJEnOMrnyJYMzzC/ywuq1E1wx/CpeOG3W0YypyjD8C8Zoae1buIbRWhl3FIMUcZhcVFJ4x6T88IZNKesVh/4bdJDYixsulQpymLbYbvabGP8VaKmKCSPrdNhMfr+tvWEoAFRJXY0ly3YisiFXIrfAjCia4fuYnLxWdI1sXo+0U0+BHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN7PR03MB3410.namprd03.prod.outlook.com (2603:10b6:406:bd::11)
 by BN8PR03MB4979.namprd03.prod.outlook.com (2603:10b6:408:db::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 10:20:17 +0000
Received: from BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c]) by BN7PR03MB3410.namprd03.prod.outlook.com
 ([fe80::bf20:122e:c7a8:10c%5]) with mapi id 15.20.8722.020; Tue, 13 May 2025
 10:20:17 +0000
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
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v5 03/12] drivers: i3c: Add i3c uclass driver.
Date: Tue, 13 May 2025 18:19:04 +0800
Message-Id: <20250513101913.30880-4-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250513101913.30880-1-dinesh.maniyam@altera.com>
References: <20250513101913.30880-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::14) To BN7PR03MB3410.namprd03.prod.outlook.com
 (2603:10b6:406:bd::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR03MB3410:EE_|BN8PR03MB4979:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd5e43d-cb74-46cd-d390-08dd9207c212
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QWemL9gpXmkufHu5lq36a97Nhh9eDQeAo/VxAbKY4Gi+mbJxu0euSG7PV657?=
 =?us-ascii?Q?9+/ZD4a30ckt+IqijTAjNhjbNoWJcTy221QpHeU2vRD2jUweo+BTCbyBCOgz?=
 =?us-ascii?Q?2GsNBydEmg1BPBF0Oj0YeT/CZSzOp8/qAfvfWaHPODmB8JLYGZit4ZTYTv0m?=
 =?us-ascii?Q?so5bVJMTvc4N8sw4k0Mxok5B8maw9uO+qwhpBgkM2Kb4sJtqcSWGrgWkbZon?=
 =?us-ascii?Q?m2AfSLzPC4ThxxiPQ6Vk5FSO2zXO00/FP2GNmMgW09fC4F/UIiyjvWFU9RgJ?=
 =?us-ascii?Q?B4rqQIwFD3KtYqnirRDgPTty8zrQU6WvqEUhYGhRmxxIkSntCcoPmU1AkLyq?=
 =?us-ascii?Q?i217zw6btM9oi7w30ixANmsRQfpGsL76NEz32zvBYN+oCEvsQA8a18ZYZESP?=
 =?us-ascii?Q?UFr8UwTbLNjVmAnucXIo2YYhEVVcaZINCfHckcefscxDSMIVT8nasJO/8vrS?=
 =?us-ascii?Q?RkVyRfm/kIxYeCYvCSYYtV2gGP6ZutT/C/mMmUZxISo2+CAnqwLtGUBbMb+7?=
 =?us-ascii?Q?C0n9/UaMJxBsFB6jyXAvpG5GxX4eYuI6ELI+NY1dagg94d2DVFYyldxTXFPC?=
 =?us-ascii?Q?zu8TM/NbMAK3I0kdAHHIHXkezcCTrhNri5UcvNy3RxvghIfpFUds+uPLJKE6?=
 =?us-ascii?Q?/tgPq/06txJtMH9ywaJgye8tktUR8/gd2xZGLrE/NoaDqOdHksCG1bgIfOTk?=
 =?us-ascii?Q?5/yZdZC4wrQD4ltZES86lZnEDM3ctFOJlrC0bPCaGIW4L33PbduusD5ft83P?=
 =?us-ascii?Q?nMaHv+TzVWKKpy9xq5PCJU0c4lBnqaC5/bK/azqWMOc1rA77Fec/CYcAvO6p?=
 =?us-ascii?Q?YVz4S7IATXM3PJfDEka8iMvCBm6EXi9tb3L61pYnW9I3wpXe0FgAL9kE5Lo8?=
 =?us-ascii?Q?AqRR3N+GAp8z9tMZUGZl8/l5sFBR5TIZYoGKwKB0E11IEIKLMg4XKf4rgcOx?=
 =?us-ascii?Q?OU9UmhQY0fTHTkc/kq29tOyT/enM9qwZdhMDPzFk9Zi6FhMpr6PqlyzbWBiI?=
 =?us-ascii?Q?6sqwoltef/tzUvjOePu8DRqe3quveZ2hbgcTlihI8SDg0+B022turHpuFVf2?=
 =?us-ascii?Q?c94hOxUPycreYYeKUdhoPRu+TZyESGIzKfGOSTNInm3pk/iv8yg6zhw/wsvx?=
 =?us-ascii?Q?VzIcYugWKDpU8fUnZcqS2TcCsaa5s93MF3PZDry/vgjSKqrKZwBMk7XQ09i0?=
 =?us-ascii?Q?bExYfoLTzkxXkk1lvjqnle3yiPvuQ8BhYkICqg4O/pFRm25G6FKXWBUeMxX3?=
 =?us-ascii?Q?BoGw+pnuH2HAFH1a/ISvmEsjlGe5qgZjRrkV2FZQiw21InGrfFrxd4yHLhcW?=
 =?us-ascii?Q?8imtBqiusq9tCfeX8cJCKw0X0DMQiZ6vU1lGobNx93JPjDOfpfCM9owVU8NM?=
 =?us-ascii?Q?sa8bvSE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB3410.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xwC+kE+tpUADZ3tKaur5hI7nlZNWNcV4lQoa5eWgJw3NAcwXE52FzQaGiUoK?=
 =?us-ascii?Q?keDdYwmVVL7oxX7CmLFxfYt31Zu2owVXbvfK0izlyl0KEs0TlVZ8FGopKW0n?=
 =?us-ascii?Q?TSblSjEXPBnoRy2vBVNum6MEEimxfXIwbJRl4crhNqmDyr+SIqvBJuf1vY7W?=
 =?us-ascii?Q?m205G1oGdC/bJZWUw7nGmbJK2k+UXPet+wNTB3HIeCnjrwWwZ/qB6QVayNTR?=
 =?us-ascii?Q?VFyxJDW9KZzp8t7mhkwt8OrIWlyN2ACqm3PyGj0/WkZDDrUqQJg5QWMVnQ9V?=
 =?us-ascii?Q?WQOW1Dfrau9efeqCNKXyWLKYgEOT7G5Jpm7Y+e5m9CVZGybeDT9nf1FC3j6d?=
 =?us-ascii?Q?GGZPBSxHzCyL4b9VrbQ0se/ZOdPBMAkDcgBYSGoaHTuUQ/mV7japf/ByHyMI?=
 =?us-ascii?Q?GMnHCli9RFTFaKswx4aT9MBVRze4mZNziB0prQsY2Hic1v9+NHsTkaP3nK5h?=
 =?us-ascii?Q?f/X8R4vXHOVOQbPtEm0/mY851GV+WRkXl6mGTrGFOtUCZZCs5BYL9iUVY2GJ?=
 =?us-ascii?Q?VOWxxO5XQGKIrH/CWHebqGOsO7Xtu+1ta1fKXY1lPdTTolOFhV5RjH5UIN2K?=
 =?us-ascii?Q?WAm7Ajtq+tjHvHk8LY9oT4fzf9+jthTMpeDzl6XCFxbxZD8bytO/zc12Dm4S?=
 =?us-ascii?Q?0tV6FajTGu5qTB+rFyjngtlFWLpHs1/oh0YDWk7EybGfz/x5H1WAtXS1nOxt?=
 =?us-ascii?Q?x5gMnLMXR0hXohJUH5smPJPrqVTdw6Ju0G/66ETKvl9AQ+YW07+maBHtKlLv?=
 =?us-ascii?Q?fbHtRWoasX76ObMdlDdXkumZuT6ETKDzFBWW/baKgmmDqFMF4xAas+8ZjjXm?=
 =?us-ascii?Q?Oys0bvqzISJZecFYt3q5wS4ZDmLQaTHD6nSE16HIRYhLvMSX/7Sivy0CtUOo?=
 =?us-ascii?Q?sHsdO1rk2tN1a3wZ1Uq/8p6Rlrq54Ll/YPpXBiGUvkF0W+t9WRTGZeMtcNgq?=
 =?us-ascii?Q?YBBIYQ2nz3eJghYrRRMiEAzkZYPNz7mSOn5r5E5SYdNO0v7CRVenvbNGT09G?=
 =?us-ascii?Q?KzK1CrW7uiuMTWbLePYcU7UNKmzmXcZznH6ravnraAG3dIOGAMGGW73w93fr?=
 =?us-ascii?Q?DeGcivIB09QeMfj6Kdl8Ht9VOMZU92sX/5xw8ivywvvKW9+aaiQbCvjfqeIc?=
 =?us-ascii?Q?U1F6QXJ8uJGr/Ygf5RinAd5nHKQ2Shjlm9mnc88HxuX4YNDBg3avpSyMrCwm?=
 =?us-ascii?Q?flH55qD4z4s6OmX9FXwHO7//7CC2nQSXkRMc+pTA8MpSPgJnAG2IAMFCJDLp?=
 =?us-ascii?Q?VTJYkVa3S/RVxXodOMy77M5H6cDpkZ0tvALRKGSonhPS1A+PvS4q5M5Gr0Kx?=
 =?us-ascii?Q?T0Xv/sF3pXWmjRJFkAt9iqabtLNZEw4mLHw6oU+9AaedSgrkITeLVXFP8KNi?=
 =?us-ascii?Q?U34aDi1p9mon/Pb2FCRIGihUfAVZo4bguxoVpob4GpKjsmlsmqVpZvyz7sN9?=
 =?us-ascii?Q?upAldgV/1o0BNyxefNiQolDYecVdSNY9x25sqR7tsphPHCMPe6TykG5XI/j5?=
 =?us-ascii?Q?hAdOJws9XV8RnEkyuRgr4Shzy+rR+R9Qt/QRvRNWlIvZvl3Zb8chB/fpcg0h?=
 =?us-ascii?Q?JlKagrQ4W0zTXWdb756LHeJh1jDyKMiXdwGXac8vo9pRMsIVtoSoWn6tBJy7?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd5e43d-cb74-46cd-d390-08dd9207c212
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB3410.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 10:20:17.7868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBXTFUEf7RJxgozv5UZ3Kr3BnvRs96Ek1LhPvO1nSx0eBL/QYrNHsOky6V0RRn9ocEHDMe61MmtIQCw8FC1290Q1yND000xrNOD/rnO4xWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4979
X-Mailman-Approved-At: Tue, 13 May 2025 14:28:49 +0200
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
2.26.2

