Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174C7C87FCF
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 08:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2072B83278;
	Mon, 28 Jul 2025 10:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="cz+hTBIH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E816882F00; Mon, 28 Jul 2025 08:57:31 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB96B82F14
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 08:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4FFfOfpiGeiu45dOkwvuPNaH0HchiyZC6NrmA9fPgtI96VXc4h6GCcYeVuIv56G8PcRnYEhzuICePu7FM3GNLFTBMkpiVFjR5QafvrutTnubIiPfH3PKtwzVNzvHs2644i9rvB+T5EFepDNvmc/+59o47uWDEdtMXIG4MzmxTDn13IwWsHcOgGKjz6ggFEpM/6wgcSQJQL1COeMLlo14gQ1eRjs3Lkxesgu1JXDDRmp5K3L+iWlpHDrFJ6JrWhGQr16N2qe+d51L82OQlM8AzabN5/5K0oW5yO7cvtxlkOe/YegrVjzIsP/6Hcm7isTCEmkRsN1h+hRAgF9VknG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/ZGBzeVLv8oV5RJ+KThpxa60OO7rZqHqQf2ov7QSyk=;
 b=dvSdIE9xTIAvhAl8b1d6ZUbqTs/kfp5wS6AlzYswnkx6O4L88MktVTfzn8+vVW/KU01l9KPwD4FExqOy1435TRs1QILgZ69fduTfapwrZfrVwnZBwofboz3oZg7PF/qx340dqXdv3yalQfVZfQJBNwurFOBB5Xi9JSvhjFUqJZsnbwY/U7Hz3A67EZ63g+pjTGQOsUwM7Hh5IHw+mbkht3S3IfIYBYfu+rtmLIn54JzMgZ6TCcuqAdE8/oXEWixpQsIO42KrqFhiGQ/rM5FVWmYT0bwx77W1/zBNkrvFJHLBIiXl5pKGgkZBRSk7P6tf6UO+/bON/bq+tXms3g4JXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/ZGBzeVLv8oV5RJ+KThpxa60OO7rZqHqQf2ov7QSyk=;
 b=cz+hTBIH9Kuek3cLPNtpJH06YwTbN+sC9yU91pXcL4rsdAdF9tXZNgCRoONv2Bdy3jfc8k1SF4n3YEe7elrhv3hmbZzvXr8/V+Hh8RK+XTxq4CCbZ8rnXQd6rxLTAGmwdTkSA+Ph33Jb3wlj9s8Pm3r+7zO/2E4VfzGrqhuwLo7NdcjcIInVJpY5n++abE5eIS2rj0RG7TywKHC1W3CFwYIHHTQBpY5Tw0HV6bMFznDGzHQbx9tLlRYQEx0ZeoljReoWtCufp5Av0zQOttBZ62Snb8vHNKuOeXIKzswaBBI8ivxxk9gyqzehI+HlVxCDpJxtkrQiu4J7h6gaKBKiHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DM4PR03MB6128.namprd03.prod.outlook.com (2603:10b6:5:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:57:28 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 06:57:27 +0000
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
Subject: [PATCH v7 10/12] test: cmd: Add simple test for i3c
Date: Mon, 28 Jul 2025 14:56:10 +0800
Message-Id: <20250728065612.6039-11-dinesh.maniyam@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 91272904-31fc-40be-d3f0-08ddcda403a7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FxdvEP8XcfSIcB29G8xZfLKomDl+yzTiQFGUnDoOvffP31zcfl8fsBC/3JR4?=
 =?us-ascii?Q?Vi5lF5QB8JWp/7SyVUKGe+1jklJGBmuX1RtujSdgptZimkOdShC3BmdmFHN4?=
 =?us-ascii?Q?spT2V88lBhP+K9V9HnrFeZ4KZFbMRYnpCT4tzMI1DLIowPOKZnZbTUQLuAYq?=
 =?us-ascii?Q?4llBOIty1ngsLU7LXnUajCQizr0EsZXtlsYlzQbA/7uBwj40phdg8h1GYivN?=
 =?us-ascii?Q?UY71i+A8uE5/Nz+MjjSLV+iM3Tv03GmVGJBbLUfQrHKt6bpvnttpyo+uQb7H?=
 =?us-ascii?Q?chKNH1g9M02eZWNHLJ9SewYPO7XHhs0/V53616uX5rI1oenSxcsxhH9GBzsb?=
 =?us-ascii?Q?PzVO50DwbKEokIfzsKCBTS2i+6bYrybmk69T6J51f5qVkV0d5METjYz8+rNK?=
 =?us-ascii?Q?hGLnHVAukMJYOMlYut/2u35E0H5gJtBf9B6QD/e8GVYdgNvw/a+iB1GuFphH?=
 =?us-ascii?Q?1Huc9e+NRkABCZtfgktireWb7M4AINOFyU/bNzXwYRJd/+XvYTesBMe2EZ9y?=
 =?us-ascii?Q?lN6AAIpgEQ8Jd+eHHlxpvc1Q4DLhcmD7ap4hADbgukA7aihSRuy4ZWBzlBXC?=
 =?us-ascii?Q?yaIP+pXF76QyNhNSd3/edqjroTzL422CxEgrAjmJCEQfJc2uj6/ZrN//bCsv?=
 =?us-ascii?Q?2w5bdxBQ+Eptn1o6hM6hxxEcun5M/ZR8x0rZgaRZGnNY5NCk2/6CkPyaPjNo?=
 =?us-ascii?Q?r2d6WIRXZF6oVaL9oc0C0sCyhG6Q8yL6mDhCxnBteI8f22Ltn3HUsN/5Egxi?=
 =?us-ascii?Q?UJZOAdFqNR4/cJirK1y1354rt1UforK2vTCF28QRObQS2M+phAVWh7GcZpfy?=
 =?us-ascii?Q?2RLpbAK4YUncEdqL45tvaSij/y5ibizdrJFhvgZ1SPfwCnt5nhvPJ4tlqUp6?=
 =?us-ascii?Q?TxIHwSie1tDh2kjmgLLK/ISKlOTsh0Nf0883cL8ZqvKjTTmpSpUp8qd6aMqx?=
 =?us-ascii?Q?9ucfBje/HYhhCxFSTTR1RmqdHZ0GCV0jx7Av2rdRRHi+OmGdwRfdy2MrGy68?=
 =?us-ascii?Q?80uWTOVOIL9Xvb6Sf/26e/5wTpy6nAyuDbnfTKAKYovVYytWFVoiiYgA44kw?=
 =?us-ascii?Q?U/TlxJUozjzdhxeGPmUteuQxv2688dk9MDMmgtF38RTqEyhK4aYBCpxxG48H?=
 =?us-ascii?Q?flbFaA9xUL58fKf7AcVfRO4ERv9C4I2+rp537b37XQ4I0Tq4Udy9GuFK41rD?=
 =?us-ascii?Q?7GgqMUjhrRY9Y0HdEPOf0DypcoM8ZG3A3h2o6v5Abcew7KPr2+mIirmdP0Gp?=
 =?us-ascii?Q?+C5wj2e/QUesUb3PBZ7cS/l1Ivt/HhUIGcEB1niY5sbl8TrnuXTA6lUb/2YD?=
 =?us-ascii?Q?RNHrrVsL0RUfeWdoWmlczhNyAtVGJiHeO4ausrSObnbQw59LCAZHz80mscyx?=
 =?us-ascii?Q?YvlWZlU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8KGTxHwtnhD166wFBS+D9CD8ehetEg3p3QFfYp21ON1jsO4LqbbJZIhaEdSK?=
 =?us-ascii?Q?WpJRQGAzPnyznEoRI2/RvaeGYdm5iISRgK1FZxrg/QORgKNINCLOx/rscUY5?=
 =?us-ascii?Q?0JVG7LOAw9yriJK64gFmAgccNpR/Phsmela1W2Zu1v3XWbaeHMehyrXFOJVt?=
 =?us-ascii?Q?WRH/Hzw6xA1/3BwDrKB6hh3ninQs1k3uiENHM6cxXQ+5u0W0VsKPyHgVvEMj?=
 =?us-ascii?Q?ExIbdsqT60GY1hARILrjuACSRY6MVNmpSUIlH5hqxd51N6z7BqEGRlq7/Whx?=
 =?us-ascii?Q?O9yIORizqfFTRm+6817DaS4xDrjvIRdq8+CkzhPeKiKFHHKACFeotGg99rJ0?=
 =?us-ascii?Q?axXFmyW24VIKwLqefnN6/RQqyyGrYlL4uWY+BgoBIGybz2CtsWOLZ5qajWNb?=
 =?us-ascii?Q?+yipu2KXxu5hCCpe4dooksKqkzXlT0HJWkfEYxtYBZYruu6AMGrTs6Fc6ZfB?=
 =?us-ascii?Q?4yXLqxdzRMTOQSXLwKcC9JKE72h3NQFCEBcomhYM4/G4idOcifIrhRvkAfcF?=
 =?us-ascii?Q?/iF5ZUxPLfHeq3NZ+/0PaUo0aW9nR4W+KB+DkFakJs55BefLP26PykzWimyn?=
 =?us-ascii?Q?degNyLKZuJHPyLqoeSQHqWrB0B1th0IPPnAxNBauhUvhniZ+cNvdEEIaWLCj?=
 =?us-ascii?Q?KF2+t5K7RxhaGYqgUVbEaNi7TBXfOGJn3nqatlImx8zROB8t3n8TwD0lIZxi?=
 =?us-ascii?Q?O9FEPo9zvWTCNpsMCyC+N4+ZnYKVBOF1GhqKBVyk2bh0/nCodYjvhcqzC1cz?=
 =?us-ascii?Q?yaMu7KBSlkpui0EINoBsuHJowrBISIHTlnyHsNvEgC8uh6YUdlZaE7bLC8W7?=
 =?us-ascii?Q?72wEC5qzPScheONWHJ8EL5IHlUP/68cwXigaNIZu5xLsi77caKD1akm8r9Ai?=
 =?us-ascii?Q?CsF1LsYT9HfWz7pYVJZ3jm7Y78cg+mwp6xJGjEsi4ZGXZ/2EmzLc3zToAnBT?=
 =?us-ascii?Q?nM/9aFK5ZCPuC6/21tDWHZtBu2z6n95gApteN5ExjldMKrhERVSAFFNXBULq?=
 =?us-ascii?Q?p+jx9WJyBC+VUHdOMk76RkRVEmX9hLUdSNLDi2pYw1rcAziFDXxM47qwXcug?=
 =?us-ascii?Q?E/OO/EyJflq66lKqr1RFaG37lNT+4qFuaCTSEyThUjJACcs95eYtZdt9IVM4?=
 =?us-ascii?Q?nmUOtYjR4Fh74jvfKbHb4dSnGZoNWPmSNCP5JvWsNX/FXsI7ax47xPvwTBR+?=
 =?us-ascii?Q?n1DoHysu3Wqp/vO29Q6Si2w7vqiE9olIW8d5oMforPFv87YPLKannzFo+F6k?=
 =?us-ascii?Q?7NDjxSOtOkeNKvHKUKN7kfgtujsIYVvGdItwxswCeRc+c8hQWh6eZTdFaPbw?=
 =?us-ascii?Q?3nKFgv/1u5j8oKo0yuriq6FiMJPyeYd2GBL0yGlNHKmSjBtNbCO64Q5Y+8V6?=
 =?us-ascii?Q?reg8jKqFex5ER5Xj/nvo9Xx4pTkTWeeNcNVXldqkmxjEUGyc5eOGDR9w7QzA?=
 =?us-ascii?Q?3O/4YENajG3GgFhN0Q90P1bJrCCfWuBq7uw4E5ocQ5iaal56fnrwNpMYrgxW?=
 =?us-ascii?Q?WG6InOHH1C/HxiMT9IB4+q9eTjdCuZ5s70hKs0PGQnG151fRRwNtJpB0ex7u?=
 =?us-ascii?Q?K+oMf/seN1gwUDVJO1vIx8sLH+vHSPi9upFze0p/rR+5tE1Sz9CQod/O7N1N?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91272904-31fc-40be-d3f0-08ddcda403a7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:57:27.9076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKzsK7eDMaGiIovyzK/1BRZIR1SY1k2yFv0X4b9wUUH0gYcEunCj2szQbfvgtSRk0e4NEu8vlGOU5CD30Gr6YqxIsU/Nuzlv2JEmwWUB4b8=
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

Add simple test to check i3c controller defined in sandbox test DT.
Basically, this test case will check validity of the i3c controller
by probing it and perform basic commands of cmd/i3c.c

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 test/cmd/Makefile |  1 +
 test/cmd/i3c.c    | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 test/cmd/i3c.c

diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index d8a5e77402d..d1c49e2c97a 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_CMD_PWM) += pwm.o
 obj-$(CONFIG_CMD_READ) += rw.o
 obj-$(CONFIG_CMD_SETEXPR) += setexpr.o
 obj-$(CONFIG_CMD_TEMPERATURE) += temperature.o
+obj-$(CONFIG_CMD_I3C) += i3c.o
 ifdef CONFIG_NET
 obj-$(CONFIG_CMD_WGET) += wget.o
 endif
diff --git a/test/cmd/i3c.c b/test/cmd/i3c.c
new file mode 100644
index 00000000000..04baad2a4b2
--- /dev/null
+++ b/test/cmd/i3c.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <dm.h>
+#include <dm/test.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+/* Basic test for probing i3c controller with invalid name */
+static int dm_test_i3c_cmd_probe_invalid_master(struct unit_test_state *uts)
+{
+	ut_asserteq(1, run_command("i3c any", 0));
+	ut_assert_nextline("i3c0 (i3c_sandbox)");
+	ut_assert_nextline("i3c1 (i3c_sandbox)");
+	ut_assert_nextline("i3c: Host controller not initialized: any");
+	ut_assert_console_end();
+
+	return 0;
+}
+DM_TEST(dm_test_i3c_cmd_probe_invalid_master, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_DM);
+
+/* Basic test of the i3c controller for valid name as per test DT */
+static int dm_test_i3c_cmd_probe_valid_master(struct unit_test_state *uts)
+{
+	ut_asserteq(0, run_command("i3c i3c0", 0));
+	ut_assert_nextline("i3c: Current controller: i3c0");
+	ut_assert_console_end();
+
+	ut_asserteq(0, run_command("i3c current", 0));
+	ut_assert_nextline("i3c: Current controller: i3c0");
+	ut_assert_console_end();
+
+	ut_asserteq(0, run_command("i3c i3c1", 0));
+	ut_assert_nextline("i3c: Current controller: i3c1");
+	ut_assert_console_end();
+
+	ut_asserteq(0, run_command("i3c current", 0));
+	ut_assert_nextline("i3c: Current controller: i3c1");
+	ut_assert_console_end();
+
+	ut_asserteq(0, run_command("i3c list", 0));
+	ut_assert_nextline("i3c0 (i3c_sandbox)");
+	ut_assert_nextline("i3c1 (i3c_sandbox)");
+	ut_assert_console_end();
+
+	return 0;
+}
+DM_TEST(dm_test_i3c_cmd_probe_valid_master, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_DM);
\ No newline at end of file
-- 
2.35.3

