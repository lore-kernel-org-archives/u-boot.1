Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3106EC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 15:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71010810FE;
	Mon, 24 Mar 2025 16:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="FfQLG3z2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6D8881F28; Mon, 24 Mar 2025 09:41:05 +0100 (CET)
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80FA0801CF
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 09:41:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFI0xb2BBf8Rzjr6rhkeKs+x355WaAxAW56vCkvE5RmdjWYy6q8F+yz4lDl59bD+h+kqYdx2e7ARzR4XvaxjvbnFNk0sepGWe1ClrVvDnUI36JarZf5/3EGBdsLITkD/pQDdnz6JI4LqG5UcdCCOD7NMJBu1KqQ5Khmf11yQ6xOqwwsrP5WfaLXXBFtihzY5qsDKbpzyFn52SSG7oINlVuIMtu3S/2v9cj6BP14INiU9yUoGcuJzNrY8wmDPU23xK1D+YUF+BHiwSOUw/sNZ9hgLYFnCyv5acQew2kHn8KEyu4b//l0Tec/NUqMuksFBaQLCl7iG8eZaF3VPYYdxBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7k520nz6mXwxLViR1V8qrEEET3FvkJcY54ccZZmWWlM=;
 b=VmGrRdFjh1IBNpjw2enKAyTVJ1+Z7+NNAhhoLa1FpCQEVfXEsM6CKkwuysOl65gg808y3moLwnRehgSNw6BQo6MDWBwQxBCGrZiL6PF7aBviFMkfOkzsmwhFMVqpA9psusznr/DtFQAg0MBlLQxfo49kHgii0zF3HAI8iNCOynkrNp5awiwTN9d8gKpgCTcJcD4u5U3dKjsynZK9VOTHf/WLep4F3fn3/XtUelQQBJvHG431H+3RDditb0PPyuS35U5xCeOMKhs+tNV2N7dqAB9BzKsS+3n2dQtRpN9xPdWQZp7ACOAk8JeqCgjwH5rF8obghhvD+fYCVdE2oHPpdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7k520nz6mXwxLViR1V8qrEEET3FvkJcY54ccZZmWWlM=;
 b=FfQLG3z2MK65xx9a9q/N1d0V42G3jPOsS2BGmaO3wNdJjlApgCyNCgXG0etMLit1wMilSJUPl90XL7TR7QhipJCpVVIq7PRh7M/zvXm3Py3eboyZLFL9pd6Kn627hXUA1lJzu8CyDzJMRJZGvQ8/J+6kNv0dYj5OcMDgc6xE9V+6vM67Bhs7u9e33zljzT0hovT0N4a7gMLMAiNLuP2PvZ/0Es/RFvIELUGH4HIlJuga9Yxni6owu61JfCbfKJOmgmAX+yUO4BOsz/sVLBNhrN1JvI2L9VY3NNjryBVA+UGS3bpSpS1LeBz3ls3KueJWXl+OR2zIWD9mVVzMiWGk9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by MW5PR03MB6958.namprd03.prod.outlook.com (2603:10b6:303:1a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:41:00 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:41:00 +0000
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
Subject: [resend v3 10/12] test: cmd: Add simple test for i3c
Date: Mon, 24 Mar 2025 16:37:02 +0800
Message-Id: <20250324083704.26259-11-dinesh.maniyam@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 92d8e30e-85c8-4b1f-ee3b-08dd6aaf9aca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3lZx9K1NERY1bALneDNilc0EWBoTnuVqWPCC0I3gbzMoxfx5ae33EQs+IOjQ?=
 =?us-ascii?Q?ZrLXcB2d9WgaIYBoqpRw2I4E+XU4FZiVhzeI1qFwVAPqB3zboUwCG/NV/9Zi?=
 =?us-ascii?Q?UIhDFitQ31unU079TNOoti+epFNqGyEMd6JWbqMfK/hLWIvvR4cvgOURzLR+?=
 =?us-ascii?Q?81Al0AMuXxc6I9oMQGABJGXxYbb3oCUnhr7jO6UlgcH+gIYb293RDP0Kei9H?=
 =?us-ascii?Q?nT8dCP5kKkCj8CsZPihDioSKKwTJhi1Mj3pbT+O0RaOcH/9F8iid7UvRpbXt?=
 =?us-ascii?Q?OyPGUM9f1gbCAYBsg2qMmYtD6ygBhzQIHnrZP7KFbttKkZ3awcGcIeRpaiKR?=
 =?us-ascii?Q?zRVScXpbY5X5zn3uQmYZO4y48gPF0OaDlxdqqD1Ir4PCPYcgYxdootC3oLVP?=
 =?us-ascii?Q?weNxvl2eYfGJi09ZKaX537pNr2hjbOkMqsVxYTFIFw87h1RX+n9rEIQxL1rb?=
 =?us-ascii?Q?+cE85tbvJs/iwOF8CZdJX305GDCpqxgV0UE+2qt8lZNiH066fzkGcJW6Y8B3?=
 =?us-ascii?Q?kTGRjuMMT7rsHs97ugZPQ6k9F8JjAVuHz4fSwqgj4UyYpHiK18b5FBhIYzCp?=
 =?us-ascii?Q?k2bXG3vpjXpMYCoY5xtSs53i0BVD9H9rQx7JbWWv9eKuGj3HmeeK2OoaHUFW?=
 =?us-ascii?Q?Nj6nGLmcylE8ZTV5Tja5Jg9pZuSmbYHPu4euS3j3LdfyGOvIqO8B7ZP0ZIF1?=
 =?us-ascii?Q?YSRpskH+dFcf91TFZ4t7syERWh7xAMq7Dl90dGAHX6Z0HBi+C8d0TbTnqJKv?=
 =?us-ascii?Q?y4o1eKJzOqAqljgXXHgh2/5Kl8R2CN5nlu+clsk1gFqOE8ug66FZZf7BtVjd?=
 =?us-ascii?Q?VM03PI7KD2aW82O1jBl9x7TVFENoWre+t9jEdpKNtccj+ZlI8J5Z9BGsdTeC?=
 =?us-ascii?Q?bZEMu8p6vIFsYOLnEFm7j+HDfLUfQ/P4+kcDjJbyU9x4RdGl7U9YeBHA+h65?=
 =?us-ascii?Q?/R9f591vTeSbAq6GEBEHKfLoVoy+uceDOcFaN/Wbq3v1YzkHVpfcju27eK3m?=
 =?us-ascii?Q?/t6yzNFDlfGBiUl20o/bMGDN+hJspq2/7u7MSEr5uLY3B4WglpO9w7tpoIxl?=
 =?us-ascii?Q?DhZnb2f5o5pisHiBhEyUoWH3o6Gs4lDxi5+R196F6XvEubisp/79OCBsJEmq?=
 =?us-ascii?Q?NSBA+FQ/QjlA1tHDA/1hgK7+QNQhwAnShgFLx+7lEOMfaeoRcfeVYiNgE8SX?=
 =?us-ascii?Q?5V8CYOJ15w4YMp+cSKOu1Y3a6YWgSwVm0JgNS9Bt6N3/V0Dx72V97a3OB85K?=
 =?us-ascii?Q?t+3AvBXxx+REEbx3iAKCwIEmP4vMir1DAV7SDB8surumQdEfh4IhW6v2DY9w?=
 =?us-ascii?Q?cHDTpUtnoH8VZQ+gDA1PZqFN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NCrEF6ANzXvOvZYPeHHrZ2nVz3WJkuxizf6wr9b6iNrKqbSIVB0wM+C0q8P2?=
 =?us-ascii?Q?8NHd19Xts7g3b3NVsuYhsUMiJlWL+Nqr3jd/5CEhjgFgrsM67s9xXaF0srb5?=
 =?us-ascii?Q?aUTvZSinks6kMfc08KhQqQnTMe6G4kHrxM66Y5gkyCOEC3aS7Aum+/qoB9zM?=
 =?us-ascii?Q?NonsjTP/ixz8+WTbcymPGYQgKJ7FDPVhAeBcFT2SoOQLhTnPnPLNj4G6eQkh?=
 =?us-ascii?Q?xidKfxPd7nPVCxc2i7+lMx1dVOrbFpcxN2QFgrRVPs07F+9vn5ULjKPbDj+A?=
 =?us-ascii?Q?5L8lRtxK8QKUbLCyZbApS8fopL+4XRonljkncY51PkU0vhHOup5NZe4uDvM1?=
 =?us-ascii?Q?CwbQ1LQaDoLRWW8sbcIlDfcfCqxn4xkb7n/LIWG2N79iNH+tU9GG1B3LMG+a?=
 =?us-ascii?Q?5fhoAFYkB75JLb85Zqp0NzPRASa16TEKRKTxTh5je+yoTBXRZWYs0JaQHvkk?=
 =?us-ascii?Q?G1mKo1xs0+1LFuUDUkLIqBUdVVI8IjgkMGBK23+6O8iPDzM+KpoEsgrw8leS?=
 =?us-ascii?Q?Yql3Ldp1DulutmEMxJEhwcoxf/4uQK02SVOGkSRfTiEcnOasMaYV4HPGhWoX?=
 =?us-ascii?Q?Z91Cj/2mWBiQ8bhDPUgVoguUnzRIprsnqvlNsxYJG3w6a5IdVz13woFkt8ZK?=
 =?us-ascii?Q?8EamLvwb9pbTE3WlJUr5Hd/IAIn2wwLnhQDt+6pD0+c2v2kFhPiyymNpipfX?=
 =?us-ascii?Q?X3gaTn0aVFKLou4LZqJBisRdXWmDGNKVttAlS7vGgr02629GA2wT9e3uLyX4?=
 =?us-ascii?Q?oaIbfRIBAYH4cnd2WHeW1oFSJ6KSXxbt68YfGY28uvQxj140NvrSgDJcE1GL?=
 =?us-ascii?Q?VTYRyCgQBv9syS3oKLeMywLTkR1UgCcEVx2+51P0VweLtkwS7KDO/+Yi/ggl?=
 =?us-ascii?Q?5wnukw7PVKU4BMvN59r89Mj9Tw1ICNzXiCBUtUIIplKgrean7+VRsUqP8A2D?=
 =?us-ascii?Q?LqmDLjV+ENnEeB2IQZbST1vyL21wQW4B3wuAa0U2RZeP6UUUziQs1NK42NPD?=
 =?us-ascii?Q?hbTtRCfM/oZfauJcWo+Ea62lu2d/+3YGJVDtoSdPAo2nlpHsdV/347Bjlviz?=
 =?us-ascii?Q?by52Twz62mX6ROrBP0ubzYfn2iG+YzqpaIh2LUjr68f7rbnwcBFfiCDpkVqt?=
 =?us-ascii?Q?fo3O6psDNo3/trDGSGDvrkOgmyXg+ZSqnTGTDh19ENDkFSITc00KL3verLEZ?=
 =?us-ascii?Q?pvduC0c2GT40H+tZOieCQraxZqCovyzG0xIYXt54BWlj2VXhw7+zyFZslv7k?=
 =?us-ascii?Q?wa6Px+JEENzu6r7WUT3BpqgfmdEad7uRl+Rlw+6ljlthGbaoWXvHI3M2Hxkl?=
 =?us-ascii?Q?BA5QkVU6u+ET4hbxnn34acL3y/68F8DwdfcNCajKAR74K71Dhzcmb009an+V?=
 =?us-ascii?Q?c+yI6AzlQFycMAf4yKQ7E2dJWKgeUcSTnOKCQcCp8/xoUYOYbPF9TLUqn63l?=
 =?us-ascii?Q?yyhMxlE17rrHIeNOiK4JizAyRgX5gGLdeOWFWqqxFVdcIur24nl7KV+Q9xM9?=
 =?us-ascii?Q?rKahw8Oag49p2jOVOg341zusMRfi5Q3uwUVgDiCRA5GSSZLuGE7/fYtJmsIQ?=
 =?us-ascii?Q?kaeZkrX83KndSGyPwdqXdN76ctgE8BNmprwteR0b7TlyMJ3ij+AxDTGWATH3?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d8e30e-85c8-4b1f-ee3b-08dd6aaf9aca
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:41:00.7985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdhQhqnyd8OqsublEIkfs4hc8u4ZZPU2zx3WHUzEwicjSxmnACdDqc81nbWnunGhsfCrgEDl6bhUT3UhZjV3i2N7Si9mMOBb9g/k6Q1Qemc=
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

Add simple test to check i3c controller defined in sandbox test DT.
Basically, this test case will check validity of the i3c controller
by probing it and perform basic commands of cmd/i3c.c

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 test/cmd/Makefile |  1 +
 test/cmd/i3c.c    | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
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
index 00000000000..471dfacd5c7
--- /dev/null
+++ b/test/cmd/i3c.c
@@ -0,0 +1,52 @@
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
+DECLARE_GLOBAL_DATA_PTR;
+
+/* Basic test for probing i3c controller with invalid name */
+static int dm_test_i3c_cmd_probe_invalid_master(struct unit_test_state *uts)
+{
+	ut_asserteq(1, run_command("i3c any", 0));
+	ut_assert_nextline("i3c0 (i3c_sandbox)");
+	ut_assert_nextline("i3c1 (i3c_sandbox)");
+	ut_assert_nextline("i3c master controller is not initialized: any");
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
+	ut_assert_nextline("current dev: i3c0");
+	ut_assert_console_end();
+
+	ut_asserteq(0, run_command("i3c current", 0));
+	ut_assert_nextline("current dev: i3c0");
+	ut_assert_console_end();
+
+	ut_asserteq(0, run_command("i3c i3c1", 0));
+	ut_assert_nextline("current dev: i3c1");
+	ut_assert_console_end();
+
+	ut_asserteq(0, run_command("i3c current", 0));
+	ut_assert_nextline("current dev: i3c1");
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
-- 
2.26.2

