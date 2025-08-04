Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A09C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2294A83F20;
	Mon,  4 Aug 2025 03:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="HV2U6ngu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9392583EE7; Mon,  4 Aug 2025 03:25:38 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F4D983E86
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYZylNPuaLJEtqp8IOg3LWlO31gq+H3XdLfqCDY771CvKDhNDgOi3nLol1Trbl1xJG7fAtmsYqX1Knj8sece3poR1fuPnHmqZOLu05z7JifLh8iJCFUFDvNrqXkmrLf1mm4itX4imcjfWRxEPIoJUYFv9VDubtQcDOhTZwV9rnsc5C4CwgVNS2kCdKoHF9oxkzrjjfv1p1icAWoVBk2qeIUG0kz0J1O2rLoQNeVU4dca1vcJ4aEK5CEvMGddGsgNZ7PJqTHB23x/ybTVaSWE1I8ty5W3nKlkTQHx2AkYMRYu0ML38qbfvLGSI/V9+rSEHY+IsoWkeCzNH61uGLocNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82TKr7wg9QrspF2Vt1MUpZzI9nr/goUuDtYm3GsHYCw=;
 b=P5iislst5ZqwSr7UkvTqoKoLc0jHnu3XESIgMTwVjJEClicPRopriIVHHurEbq+G0H+/XZO1yM685o30n6KXIPTjULHOZwhJc/+7FUJLanC/ekWr7T9uuIG/8IDpIPe5OjqVLcKMCD+tXax4PEDgW9hcyTrhPuvzZwPazkYqFNx8PITL2fuhe+vfRh/lIPNzK7miZyS2LE0hMgtpw2NiV3taE3dESVIarmmY/2kejR7Snq+TexPwKOgFjl9l+1FV3LvX5hqSQBSJrSj2ujLw0tX2PoGVZ5t0GqL+7goRQEyBoDbSr+v0V+P5RNno+2c0f3Ek220z6zaFrgjFZyZIig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82TKr7wg9QrspF2Vt1MUpZzI9nr/goUuDtYm3GsHYCw=;
 b=HV2U6nguzrrXnyW4hxD6cNrbzUqJq08xA1zUOPykNhN279/4D4jdCD0lQ+UaHFz0PsRHAytINpZDJn7+Grji+ZKQaljZwiPHWjqMU263DOA5ebnQ0rNmCHIvACJtadRMikpJRL0JEE0TSoUedxUuUpTPWiTf793JwtMtuRA7TiGsjJtt6/OBTlpbXACNai6zQZNT19r7tQC91Pb3blYk7lLO5M1FwBtoshLJDlUJ46LcnLebr2co5anK1g7vEggnFTnWFmzCzSxTnxaIVUdQfrDtqRNX0aYUIGlfXRjXLO/C87xw4DTCy5wA+SOxKGypZLL9Z/yTyk3lu7/7DMuJvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by MW4PR03MB6346.namprd03.prod.outlook.com (2603:10b6:303:11d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Mon, 4 Aug
 2025 01:25:34 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:33 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 28/34] ddr: altera: Add uibssm mailbox support for Agilex7
 M-series with HBM
Date: Sun,  3 Aug 2025 18:24:55 -0700
Message-Id: <20250804012501.21811-29-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|MW4PR03MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de3064b-b391-4ef0-2396-08ddd2f5cee1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sTdM9bVME8oAuq9wpnsxhmE07vid/f1JTQ5ELVxq2+LHnuPyJZY2szqHJAVx?=
 =?us-ascii?Q?USqUhJCn1APLhWo5HDOrcDOo15Q3hooMq1mJKSF8sVyPdyXCw+3OrMEouRkR?=
 =?us-ascii?Q?rdu0hiKRM2UT9PLw9bOAMGvbllCLjvmI5JOHhD2QPeE8u+JsF0H6nz+QBUp3?=
 =?us-ascii?Q?JHrO6F0i65Bss3HRKx4o1d9x1g6GuQ/A6t0wCz63/M3paXJ2LoP5fl+cch+Y?=
 =?us-ascii?Q?lFvIU8V35D04otNUNUENGaUSSNONztkF29EgK5idxdbaNo9qPraNz9o33o76?=
 =?us-ascii?Q?bKrXkOCcG2pLO45CghdhGoT9cU4Wqy6n9hFdzPUrCBw5Krg38wz4eBrzJU2r?=
 =?us-ascii?Q?X01cXb0IRjMNPidPcgdiD5UGW7yVmZV2NczylQewpwP9VSBRDMvxdGR1b7cO?=
 =?us-ascii?Q?lHcHD4wGnEcFxkW51yTuLl+jU/yMsY5+FYufjRdz/VIiJ/gQ9/Hj51pcyHF8?=
 =?us-ascii?Q?HybYqISbFpi6tMTfWNM3sa2Y79IAU6u6rhiTPkzlkrj8zDmV/XIZRzXBrwiQ?=
 =?us-ascii?Q?Lg9EykDRyU4oDeT1PC8gIOytDo+nb8rrRvemuptOReqYOT78H/BYuyiAn5Gx?=
 =?us-ascii?Q?AUXtWgtuWW+JpgtPEF+ZFgE6Zn+e5LWewZYHBUvK6ES7W8cU0mYDRRhxkxWx?=
 =?us-ascii?Q?4kNgvW2EwzdFE6kNjIOuizQVkbT9pPHaCsD98Z46nMrTZS5JvRLJfVUq0UWV?=
 =?us-ascii?Q?5HVsLHSpPLafvWb0s/hc/SEwC+Bntf8K7tGWNki5XkEdpZqituec7WzYOYa6?=
 =?us-ascii?Q?DdgUVgaSm2NzMrTYLbUMGOZ9YyPJCc4PKT83YhLnKSgN9eYM5ruw85swmPWB?=
 =?us-ascii?Q?VXfCThhi8eReSL8oVy4yQUDlJR9opp9m9KNUxueZTPgiQOITt0c4N4wFtayQ?=
 =?us-ascii?Q?kTsHM6QqHaE+BYZvAFXUMh7CHp+s08Y867o5gzaZYmbp4oD8ju7PXqs6Vfid?=
 =?us-ascii?Q?4Q9smo0fimgvoDwkqDEJl6BemKicr5916lJrRFnC5aTC+s7QtSRAjZ9Ov0um?=
 =?us-ascii?Q?OkU6g+uSnvOfMKIzD7HZ8b4bcYUDGuOKwbexDi5rFaokiBjIZ1f0M70p9MMh?=
 =?us-ascii?Q?qN/RL5UfQUdso5q7xs/x94Vx0dY+CCtLe8xMA62IaOvyDoR8lOA5cs0yDz6c?=
 =?us-ascii?Q?mYjab3ktVdzbpSQNDkUJQe9hGhC/9m9eeXZjPKl7ZB/SvgBGIT+Yrd2C5Xfg?=
 =?us-ascii?Q?GQCIBoO7JmYeaMgznH94KnE8rHLgpRqsdOCAmwyYJwUn8vWmH4zNmTfoaX+4?=
 =?us-ascii?Q?MYwbDfBrQO3BqFv0efbGepaTC4wVwhdo6p0eNXUaLZHcaU/p29V1hk/ynhbD?=
 =?us-ascii?Q?1OHzWjKUPVxMtvs9AhXSFMdYDNZ8pdL1G9shP3NHRK6rjgcJpgoiWbglbYzL?=
 =?us-ascii?Q?VnkTmwUjqok9TwqH8Id72kMvo6ZOAYJyb+nKrhFZalEm8wHarizgsKmv/+rk?=
 =?us-ascii?Q?IMAN7isk4sA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hLIhm0GRWS53J+bk2pB+e/iZ5R/S/fF7gAJMaX03OBG33SWDZq5yW6H6EE9v?=
 =?us-ascii?Q?Cp/biBW5fouIZhfAU9Kh7p/kFKNWxdLW/ppUYBQI+zdyRLnJUjNLyUFjFbTa?=
 =?us-ascii?Q?+vfhoasOyBvJWcMT+YTV24Ch23doYeBoeGKIfIG4/lJpJvA0p6iEOPqCToj7?=
 =?us-ascii?Q?oyVpYuPmvZzPj+4WIWhwiYy2PYPuYlAliEgBJmr+VzJLbVrfVinuRnytDf7i?=
 =?us-ascii?Q?tCBJeUzfNRh6bWBv+lliLWwDr+JZR+X3Udt9T5BOezskePbucreTigz0CM8/?=
 =?us-ascii?Q?qD/Kuz8jFq3c4jOojosRY32iVwhplNvNPQoGOIvIRTA+TWn9TRfsm1HLa4hB?=
 =?us-ascii?Q?CHz/Qg4CfmwU26B7GnVFykkR1KuOw59VEWc68H2ai1cJMAUNjVfFIN2aICg8?=
 =?us-ascii?Q?0v68E32v89wDaYL484uyaa4m59biy66AfLsLTDdKxuQ5j32cIY0zGXAPkCAf?=
 =?us-ascii?Q?eJ7yDJaZeE1qxciVwK85IU777dm/HEm+t177ncNoOpVSsjsX0BXgiB8fjUhk?=
 =?us-ascii?Q?lNYXOjNGv/y8v5PjCYsiOUBm+nYDElN0A6246Z5nNra821m+ewAiaUyaFdKe?=
 =?us-ascii?Q?RubbufAVzkbyColn2sK/RHtBye6oFxvRdYLY6mOVdQ0uNw/63wUNxocEdQNE?=
 =?us-ascii?Q?+o7z8btP5sSxHeDjyV0QJFnLCc9dknyKTNwq3kZoYQpuU5G6GlkGB1gtFglk?=
 =?us-ascii?Q?TOnoaytULZXzEM1GDXdom6vk5Id7Vsftws5GA1hMhkfX59qSP6KorqsK7dDn?=
 =?us-ascii?Q?dA+lRgEa3stizmE2qy1lqclb+1BlVt3KVXyUai3EdcPjxDEvVEou8ONgyRKR?=
 =?us-ascii?Q?mgB+AUuAm3+2OqJlbyMyYNTd6+WbfArdtnVDbUgXeuuzO0B+9KBqedjSoaCA?=
 =?us-ascii?Q?fIGGLrBjHIvW0a4Eghmq9GVM6Btd6FIJtjjT5qiB0rrXeXITTkIq0eLNlClf?=
 =?us-ascii?Q?jax/e0LcwsUbrgOs3diJp+OxMKc4GZVNCL97PpMNJYhLvf/BuokWPatNkbW2?=
 =?us-ascii?Q?gbM769qBcq3ABYnPuqcHO4cz2I8bQl+CYSeEB8bX5PXS+o9+cVNxc8l4VFSV?=
 =?us-ascii?Q?RofDBvmhb5dd0NO72T04if70fAdCKUeTHLGhwg48+5nazotYkaXj6Y4JCZh/?=
 =?us-ascii?Q?0yBWpi7plw6OSKChPykSN6PdR9WSL6UDn1Gj2CJsnAbRqQUVOgP/3qtbLxNJ?=
 =?us-ascii?Q?F/+hnKgOM4V2BOU6RbENxLztkzFPP4qyNdG0m4wDjpC1DBatjBrkxBBLawPb?=
 =?us-ascii?Q?+dTUy8D2T2koLfzxDkhxEj7Cyqq7mCOkebcCXLKL19MLQsNMXpCaQHJcWwZ1?=
 =?us-ascii?Q?JvvbzzHiij8pfFBFhNsHZBlUwWlZE5I0t49Rdkm4gxx2g2J/oYme+DP3xo8C?=
 =?us-ascii?Q?SpD+YNTT1nQ+kIDQF4t9kouUorSzs9mPfqDw/XKBjxC4lDLIT5Q9W8nLJkp7?=
 =?us-ascii?Q?t+cl6CW+H6QhVTrexxuQR7NPaf6nt85Jz8C4UoyJk9iVc24QG1WjNjtX95DO?=
 =?us-ascii?Q?D6uisbY1SWzoyqtIIXF13gxc/9j9Rk1/0gmYTeWhdW+ZRGhEBs2iH/JqB0W9?=
 =?us-ascii?Q?SbhxuI0pXxVVN/AMWSIqyNWYGtcIFivtYIF7mEBjIl0STls/Dp2kmo49fkvG?=
 =?us-ascii?Q?/F1BsWWgqOM5Sa0CQISAX9g=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de3064b-b391-4ef0-2396-08ddd2f5cee1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:33.9546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jnbHfv/eZBvf16FMoKMzLP2WKSVlR1uRqUr346lJ8hjJGKa91UTomAVWw3ICrw49cv9CnO7yqmovEm/MOpPAYuqj49Tw04Sv0vv0sr0KC8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6346
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

From: Tingting Meng <tingting.meng@altera.com>

Add uibssm mailbox driver for Agilex7 M-series. HPS will interact with UIB
and HBM subsystem through software defined mailbox interface.
HPS can retrieve HBM memory interface calibration status, UIB
configuration, memory interfae configuration, trigger calibration and etc
with the list of supported mailbox command type and opcode.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/ddr/altera/uibssm_mailbox.c | 321 ++++++++++++++++++++++++++++
 drivers/ddr/altera/uibssm_mailbox.h | 116 ++++++++++
 2 files changed, 437 insertions(+)
 create mode 100644 drivers/ddr/altera/uibssm_mailbox.c
 create mode 100644 drivers/ddr/altera/uibssm_mailbox.h

diff --git a/drivers/ddr/altera/uibssm_mailbox.c b/drivers/ddr/altera/uibssm_mailbox.c
new file mode 100644
index 00000000000..deef61f1178
--- /dev/null
+++ b/drivers/ddr/altera/uibssm_mailbox.c
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <hang.h>
+#include <wait_bit.h>
+#include <asm/io.h>
+#include <linux/bitfield.h>
+#include "uibssm_mailbox.h"
+
+#define MAX_RETRIES 3
+
+int uib_bist_mem_init_start(struct uib_info *uib_ctrl)
+{
+	struct uib_mb_resp usr_resp;
+	bool bist_start, bist_success;
+	u32 start;
+
+	for (int i = 0; i < uib_ctrl->num_instance; i++) {
+		bist_start = false;
+		bist_success = false;
+
+		/*
+		 * Full memory initialization BIST performed on all UIB channels
+		 * start memory initialization BIST on full memory address
+		 */
+		uib_mb_req(uib_ctrl->uib[i].uib_csr_addr,
+			   UIB_CMD_TRIG_CONTROLLER_OP,
+			   UIB_BIST_MEM_INIT_START,
+			   UIB_BIST_FULL_MEM, &usr_resp);
+
+		bist_start = UIBSSM_CMD_RESPONSE_DATA_SHORT(usr_resp.cmd_resp_status) &
+							    UIB_BIST_INITIATE_PASS;
+
+		if (!bist_start) {
+			printf("%s: Failed to initialize memory on UIB instance %d\n",
+			       __func__, i);
+
+			return -EINVAL;
+		}
+
+		/* Polling for the initiated memory initialization BIST status */
+		start = get_timer(0);
+		while (!bist_success) {
+			udelay(1);
+
+			/*
+			 * cmd_param_0 is not used in BIST status request,
+			 * hence set the value to 0
+			 */
+			uib_mb_req(uib_ctrl->uib[i].uib_csr_addr,
+				   UIB_CMD_TRIG_CONTROLLER_OP,
+				   UIB_BIST_MEM_INIT_STATUS,
+				   0, &usr_resp);
+
+			bist_success = UIBSSM_CMD_RESPONSE_DATA_SHORT(usr_resp.cmd_resp_status) &
+								      BIT(0);
+
+			if (!bist_success && (get_timer(start) > TIMEOUT)) {
+				printf("%s: Timeout initializing memory on UIB instance %d\n",
+				       __func__, i);
+
+				return -ETIMEDOUT;
+			}
+		}
+
+		debug("%s: Memory initialized successfully on UIB instance %d\n", __func__, i);
+	}
+
+	return 0;
+}
+
+int uib_cal_status(phys_addr_t addr)
+{
+	int ret = 0;
+	phys_addr_t status_addr = addr + UIB_R_INITSTS_OFFSET;
+
+	/* Ensure calibration completed */
+	ret = wait_for_bit_le32((const void *)status_addr, UIB_R_INITSTS_INITSTS_PASS, true,
+				TIMEOUT, false);
+	if (ret)
+		printf("%s: HBM calibration UIB instance 0x%llx timeout\n", __func__, status_addr);
+
+	return ret;
+}
+
+void uib_init_mem_cal(struct uib_info *uib_ctrl)
+{
+	int i, ret;
+
+	if (!uib_ctrl->num_instance) {
+		uib_ctrl->overall_cal_status = false;
+	} else {
+		uib_ctrl->overall_cal_status = true;
+
+		/* Check initial calibration status for the assigned UIB */
+		for (i = 0; i < uib_ctrl->num_instance; i++) {
+			ret = uib_cal_status(uib_ctrl->uib[i].uib_csr_addr);
+			if (ret) {
+				uib_ctrl->uib[i].cal_status = false;
+				uib_ctrl->overall_cal_status = false;
+
+				printf("%s: Initial HBM calibration UIB_%d failed\n", __func__, i);
+				break;
+			}
+
+			uib_ctrl->uib[i].cal_status = true;
+
+			debug("%s: Initial HBM calibration UIB_%d succeed\n", __func__, i);
+		}
+	}
+}
+
+/* Trying 3 times re-calibration if initial calibration failed */
+void uib_trig_mem_cal(struct uib_info *uib_ctrl)
+{
+	int i, j, cal_stat;
+
+	if (!uib_ctrl->num_instance) {
+		uib_ctrl->overall_cal_status = false;
+	} else {
+		uib_ctrl->overall_cal_status = true;
+
+		for (i = 0; i < uib_ctrl->num_instance; i++) {
+			uib_ctrl->uib[i].cal_status = false;
+
+			/* Initiate Re-calibration */
+			for (j = 0; j < MAX_RETRIES; j++) {
+				clrsetbits_le32(uib_ctrl->uib[i].uib_csr_addr +
+						UIB_R_INITCTL_OFFSET,
+						UIB_R_INITCTL_INITTYPE_MASK |
+						UIB_R_INITCTL_INITREQ_MASK,
+						UIB_R_INITCTL_INITTYPE(UIB_RST_REQUEST_WITH_CAL) |
+						UIB_R_INITCTL_INITREQ(1));
+
+				cal_stat = uib_cal_status(uib_ctrl->uib[i].uib_csr_addr);
+				if (cal_stat)
+					continue;
+
+				debug("%s: HBM re-calibration UIB_%d succeed\n", __func__, i);
+
+				uib_ctrl->uib[i].cal_status = true;
+				break;
+			}
+
+			if (!uib_ctrl->uib[i].cal_status) {
+				uib_ctrl->overall_cal_status = false;
+
+				printf("%s: HBM re-calibration UIB_%d failed\n", __func__, i);
+				break;
+			}
+		}
+	}
+}
+
+static void uib_mailbox_write_request(u32 data, u32 target_write_addr, phys_addr_t csr_addr)
+{
+	int ret;
+
+	/*
+	 * Read from chms0020 MBWRADDR_VALID and ensure its not set or
+	 * wait till it get cleared by controller
+	 */
+	debug("%s: #1 Read MBWRADDR_VALID from UIB_R_MBWRCTL\n", __func__);
+	ret = wait_for_bit_le32((const void *)csr_addr + UIB_R_MBWRCTL,
+				UIB_R_MBWRCTL_MBWRADDR_VALID, false, TIMEOUT, false);
+	if (ret) {
+		printf("%s: TIMEOUT!!! MBWRADDR_VALID is not zero\n", __func__);
+
+		hang();
+	}
+
+	/* Write <target write address> to chms0024 MBWRADDR */
+	debug("%s: #2 Write 0x%x to UIB_R_MBWRADDR\n", __func__, target_write_addr);
+	writel(target_write_addr, csr_addr + UIB_R_MBWRADDR);
+
+	/*
+	 * Write 1 to chms0020 MBWRADDR_VALID to indicate the address is now valid
+	 * for FW to read
+	 */
+	debug("%s: #3 Write 1 to MBWRADDR_VALID for FW to read address\n", __func__);
+	setbits_le32(csr_addr + UIB_R_MBWRCTL, UIB_R_MBWRCTL_MBWRADDR_VALID);
+
+	/*
+	 * Read from chms0020 MBWRDATA_VALID and ensure its not set or
+	 * wait till it get cleared by controller
+	 */
+	debug("%s: #4 Read MBWRDATA_VALID from UIB_R_MBWRCTL\n", __func__);
+	ret = wait_for_bit_le32((const void *)csr_addr + UIB_R_MBWRCTL,
+				UIB_R_MBWRCTL_MBWRDATA_VALID, false, TIMEOUT, false);
+	if (ret) {
+		printf("%s: TIMEOUT!!! MBWRADDR_VALID is not zero\n", __func__);
+
+		hang();
+	}
+
+	/*
+	 * Read from chms0020 MBWRDATA_END and ensure its not set or
+	 * wait till it get cleared by controller
+	 */
+	debug("%s: #5 Read R_MBWRCTL_MBWRDATA_END from UIB_R_MBWRCTL\n", __func__);
+	ret = wait_for_bit_le32((const void *)csr_addr + UIB_R_MBWRCTL,
+				UIB_R_MBWRCTL_MBWRDATA_END, false, TIMEOUT, false);
+	if (ret) {
+		printf("%s: TIMEOUT!!! MBWRDATA_END is not zero\n", __func__);
+
+		hang();
+	}
+
+	/* Write <write data> to chms0028 MMR_MBWRDATA */
+	debug("%s: #6 Write 0x%x to UIB_R_MBWRDATA\n", __func__, data);
+	writel(data, csr_addr + UIB_R_MBWRDATA);
+
+	/*
+	 * Write 1 to chms0020 MBWRDATA_END to indicate if the <write data> is the last burst
+	 * for FW to read for the <target write address>
+	 */
+	debug("%s: #7 Write 1 to MBWRDATA_END to inform FW this is last burst of data to read\n",
+	      __func__);
+	setbits_le32(csr_addr + UIB_R_MBWRCTL, UIB_R_MBWRCTL_MBWRDATA_END);
+
+	/* Write 1 to chms0020 MBWRDATA_VALID to indicate the data is now valid for FW to read */
+	debug("%s: #8 Write 1 to MBWRDATA_VALID for FW to read data\n", __func__);
+	setbits_le32(csr_addr + UIB_R_MBWRCTL, UIB_R_MBWRCTL_MBWRDATA_VALID);
+}
+
+static u32 uib_mailbox_read_request(u32 target_read_addr, phys_addr_t csr_addr)
+{
+	int ret;
+	u32 reg, rd_data = 0;
+
+	/*
+	 * Read from chms0030 MBRDADDR_VALID and ensure its not set or
+	 * wait till it get cleared by controller
+	 */
+	debug("%s: #1 Read MBRDADDR_VALID from UIB_R_MBRDCTL\n", __func__);
+	ret = wait_for_bit_le32((const void *)csr_addr + UIB_R_MBRDCTL,
+				UIB_R_MBRDCTL_MBRDADDR_VALID, false, TIMEOUT, false);
+	if (ret) {
+		printf("%s: TIMEOUT!!! MBRDADDR_VALID is not zero\n", __func__);
+
+		hang();
+	}
+
+	/* Write <target read address> to chms0034 MBRDADDR */
+	debug("%s: #2 Write 0x%x to UIB_R_MBRDADDR\n", __func__, target_read_addr);
+	writel(target_read_addr, csr_addr + UIB_R_MBRDADDR);
+
+	/*
+	 * Write 1 to chms0030 MBRDADDR_VALID to indicate the address is now valid
+	 * for FW to read
+	 */
+	debug("%s: #3 Write 1 to MBRDADDR_VALID for FW to read address\n", __func__);
+	setbits_le32(csr_addr + UIB_R_MBRDCTL, UIB_R_MBRDCTL_MBRDADDR_VALID);
+
+	/*
+	 * Continuously poll the chms0030 MBRDDATA_VALID. If MBRDDATA_VALID are set, read
+	 * chms0038 MBRDDATA and chms0030 MBRDDATA_END to retrieve the <read data> and
+	 * <end of read burst> status accordingly
+	 */
+	debug("%s: #4 Read MBRDDATA_VALID from UIB_R_MBRDCTL\n", __func__);
+	ret = wait_for_bit_le32((const void *)csr_addr + UIB_R_MBRDCTL,
+				UIB_R_MBRDCTL_MBRDDATA_VALID, true, TIMEOUT, false);
+	if (ret) {
+		printf("%s: TIMEOUT!!! MBRDDATA_VALID is zero\n", __func__);
+
+		hang();
+	}
+
+	reg = readl(csr_addr + UIB_R_MBRRDATA);
+	debug("%s: #5 Read data from UIB_R_MBRRDATA = 0x%x\n", __func__, reg);
+	rd_data = reg;
+
+	reg = readl(csr_addr + UIB_R_MBRDCTL);
+	debug("%s: #6 Read end of read burst status from UIB_R_MBRDCTL = 0x%x\n", __func__, reg);
+
+	/*
+	 * Once done retrieving the data, write 1 to chms0030 MBRDDATA_VALID,
+	 * chms0030 MBRDDATA_END to clear the register
+	 */
+	debug("%s: #7 Write 1 to MBRDDATA_VALID for FW to read address\n", __func__);
+	setbits_le32(csr_addr + UIB_R_MBRDCTL, UIB_R_MBRDCTL_MBRDDATA_VALID |
+			UIB_R_MBWRCTL_MBWRDATA_END);
+
+	return rd_data;
+}
+
+int uib_mb_req(phys_addr_t uib_csr_addr, u32 usr_cmd_type, u32 usr_cmd_opcode,
+	       u32 cmd_param_0, struct uib_mb_resp *resp)
+{
+	u32 cmd_req;
+
+	/* Initialized zeros for responses */
+	resp->cmd_resp_status = 0;
+
+	/* Write CMD_REQ (CMD_TYPE and CMD_OPCODE) */
+	cmd_req = FIELD_PREP(CMD_TYPE_MASK, usr_cmd_type) |
+		FIELD_PREP(CMD_OPCODE_MASK, usr_cmd_opcode);
+	uib_mailbox_write_request(cmd_req, 0, uib_csr_addr);
+
+	debug("%s: Write 0x%x to UIBSSM_CMD_REQ_OFFSET 0x%llx\n", __func__, cmd_req, uib_csr_addr);
+
+	/* Write CMD_PARAM_* */
+	if (cmd_param_0)
+		uib_mailbox_write_request(cmd_param_0, 0, uib_csr_addr);
+	else
+		debug("%s: cmd_param_0 is NULL\n", __func__);
+
+	/* read CMD_RESPONSE_STATUS */
+	resp->cmd_resp_status = uib_mailbox_read_request(0, uib_csr_addr);
+
+	debug("%s: CMD_RESPONSE_STATUS 0x%llx: 0x%x\n", __func__,
+	      uib_csr_addr, resp->cmd_resp_status);
+	debug("%s: STATUS_CMD_RESPONSE_ERROR: 0x%lx\n", __func__,
+	      UIBSSM_CMD_RESPONSE_ERROR(resp->cmd_resp_status));
+	debug("%s: STATUS_GENERAL_ERROR: 0x%lx\n", __func__,
+	      UIBSSM_GENERAL_ERROR(resp->cmd_resp_status));
+
+	return 0;
+}
diff --git a/drivers/ddr/altera/uibssm_mailbox.h b/drivers/ddr/altera/uibssm_mailbox.h
new file mode 100644
index 00000000000..771efab191e
--- /dev/null
+++ b/drivers/ddr/altera/uibssm_mailbox.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#define TIMEOUT_120000MS	120000
+#define TIMEOUT			TIMEOUT_120000MS
+
+#define UIBSSM_CMD_RESPONSE_DATA_SHORT_MASK	GENMASK(31, 16)
+#define UIBSSM_CMD_RESPONSE_DATA_SHORT(x)	FIELD_GET(UIBSSM_CMD_RESPONSE_DATA_SHORT_MASK, x)
+#define UIBSSM_CMD_RESPONSE_ERROR_MASK		GENMASK(7, 5)
+#define UIBSSM_CMD_RESPONSE_ERROR(x)		FIELD_GET(UIBSSM_CMD_RESPONSE_ERROR_MASK, x)
+#define UIBSSM_GENERAL_ERROR_MASK		GENMASK(4, 1)
+#define UIBSSM_GENERAL_ERROR(x)			FIELD_GET(UIBSSM_GENERAL_ERROR_MASK, x)
+
+/* UIB Responder Initialization Control Register */
+#define UIB_R_INITCTL_OFFSET			0x10
+#define UIB_R_INITCTL_INITREQ_MASK		BIT(0)
+#define UIB_R_INITCTL_INITTYPE_MASK		GENMASK(11, 8)
+#define UIB_R_INITCTL_INITREQ(x)		FIELD_PREP(UIB_R_INITCTL_INITREQ_MASK, x)
+#define UIB_R_INITCTL_INITTYPE(x)		FIELD_PREP(UIB_R_INITCTL_INITTYPE_MASK, x)
+#define UIB_RST_REQUEST_WITH_CAL		5
+
+/* UIB Initialization control and status registers */
+#define UIB_R_INITSTS_OFFSET		0x14
+#define UIB_R_INITSTS_INITSTS_PASS	BIT(1)
+#define MAX_UIB_SUPPORTED		8
+
+#define UIB_R_MBWRCTL			0x20
+#define UIB_R_MBWRADDR			0x24
+#define UIB_R_MBWRDATA			0x28
+#define UIB_R_MBWRCTL_MBWRADDR_VALID	BIT(0)
+#define UIB_R_MBWRCTL_MBWRDATA_VALID	BIT(4)
+#define UIB_R_MBWRCTL_MBWRDATA_END	BIT(7)
+
+#define UIB_R_MBRDCTL			0x30
+#define UIB_R_MBRDADDR			0x34
+#define UIB_R_MBRRDATA			0x38
+#define UIB_R_MBRDCTL_MBRDADDR_VALID	BIT(0)
+#define UIB_R_MBRDCTL_MBRDDATA_VALID	BIT(4)
+#define UIB_R_MBRDCTL_MBRDDATA_END	BIT(7)
+
+/* Responder Error Mask Register */
+#define UIB_R_ERRMSK_PSEUDO_CH0_OFFSET	0x520
+#define UIB_R_ERRMSK_PSEUDO_CH1_OFFSET	0X820
+#define UIB_DRAM_SBE_MSK		BIT(25)
+#define UIB_INTERNAL_CORR_ERR_MSK	BIT(30)
+#define UIB_DRAM_SBE(x)			FIELD_PREP(UIB_DRAM_SBE_MSK, x)
+#define UIB_INTERNAL_CORR_ERR(x)	FIELD_PREP(UIB_INTERNAL_CORR_ERR_MSK, x)
+
+/* CMD_REQ Register Definition */
+#define CMD_TYPE_MASK			GENMASK(23, 16)
+#define CMD_OPCODE_MASK			GENMASK(15, 0)
+
+/* supported mailbox command type */
+enum uibssm_mailbox_cmd_type  {
+	UIB_CMD_TRIG_CONTROLLER_OP = 0x04
+};
+
+/* supported mailbox command opcode */
+enum uibssm_mailbox_cmd_opcode  {
+	UIB_BIST_MEM_INIT_START = 0x0303,
+	UIB_BIST_MEM_INIT_STATUS
+};
+
+/* CMD_PARAM_0 for opcode UIB_BIST_MEM_INIT_START */
+#define UIB_BIST_FULL_MEM	BIT(6)
+
+/* UIBSSM_CMD_RESPONSE_DATA_SHORT for opcode UIB_BIST_MEM_INIT_START */
+#define UIB_BIST_INITIATE_PASS	BIT(0)
+
+/*
+ * UIBSSM mailbox response outputs
+ *
+ * @cmd_resp_status: Command Interface status
+ */
+struct uib_mb_resp {
+	u32 cmd_resp_status;
+};
+
+/*
+ * UIB instance specific information
+ *
+ * @uib_csr_addr:	UIB instance CSR address
+ * @cal_status:		UIB instance calibration status
+ */
+struct uib_instance {
+	phys_addr_t uib_csr_addr;
+	bool cal_status;
+};
+
+/*
+ * Overall UIB instance(s) information
+ *
+ * @num_instance:	Number of instance(s) assigned to HPS
+ * @overall_cal_status: Overall calibration status for all UIB instance(s)
+ * @ecc_status:		ECC enable status (false = disabled, true = enabled)
+ * @overall_size:	Total HBM memory size
+ * @uib:		UIB instance specific information
+ */
+struct uib_info {
+	u8 num_instance;
+	bool overall_cal_status;
+	bool ecc_status;
+	phys_size_t overall_size;
+	struct uib_instance uib[MAX_UIB_SUPPORTED];
+};
+
+/* Supported UIB function */
+int uib_mb_req(phys_addr_t uib_csr_addr,
+	       u32 usr_cmd_type, u32 usr_cmd_opcode,
+	       u32 cmd_param_0, struct uib_mb_resp *resp);
+int uib_cal_status(phys_addr_t addr);
+void uib_init_mem_cal(struct uib_info *uib_ctrl);
+void uib_trig_mem_cal(struct uib_info *uib_ctrl);
+int uib_bist_mem_init_start(struct uib_info *uib_ctrl);
-- 
2.35.3

