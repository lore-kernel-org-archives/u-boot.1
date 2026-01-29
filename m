Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43655D3566B
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 05:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4294183C14;
	Thu, 29 Jan 2026 06:31:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="CcAwtypr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E5B683C51; Thu, 29 Jan 2026 06:05:56 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 394C883BF4
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 06:05:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IoxlIKyuoMq8fW8XOUQyvmZd6hvK4IAiIyyoNfbFYbppm5ikHDXQXDF4uuH5lZ1v0LbfB8TnyH/GdbBatyCe9CHAvEnpVXw6Wfdr/uj+SSQRC1b6Lsg9wgJCbUmknWBnLSqkOZomkZEijbvnoi4metuQldA0b9/klIuimSf03p8JSMu+JfB3Hvs8kVFBDBl7zfwVcRNvalX48p95PKJI6bDBs3+aAUwdOGEQL1+pfPtw168AJckhz9fXCJxrm4dxqHEMlpmSPwjubL+6e5D+ceZhWzFP1/NuVCN8v5ez08Cj9di5ef1o40hDPCM9vnxN4pyNe1wWADz3sIQ7xvZPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RI4zevinbXkVmDWWbL/PscJtNi1IJ4jD7rDqVKsKung=;
 b=RSz6skkWllhG8Q5F6k7wUJVh3pviGZv0uu1XBhp1uEwDGpuZpqwbRGgkxjIA5d68zhA6ms5NaVFyLkY6LHW2FHFWDcuXRrFIUNF/KwHjvzsdzhcTNOEifCpkVK0VDWjho/pRIR9+L9G1yG4fVHTFQgqAZR1wwTqaOTcNJWG4cpw3Bj67cw+SprJcUvetlaXw2bFX1ZrPK4m7syVRVsp5CwEcUsm5G4Z//DbHRVHL+WMlCH36vacpGIiCiighxqiIz/yuw3VV1muJrwLl7mj3/vWVUb2N4WC9V1EyjGk7Afas1KZnA1HtQGAnDypa7NNZjqZHQHx0rNBtXOqPqGZJXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI4zevinbXkVmDWWbL/PscJtNi1IJ4jD7rDqVKsKung=;
 b=CcAwtypr96vwBco9tt2qp9UORaaITKTiRBKoO6QgEluLs83UE8N/y55/4ZrzfjQfMRS1hZYML1OBnzXciEfl/eLcfFj0W2WF+kJ0AZMdtZjhlGjB6x1XfLxtTdJ4WcTPvWpUFDSgScStGVVfEDdjdjuV0UlKtEn4QxSVPkOKmUQp7lMagT7DtE3RdqY6Bqzy1xpKoKGlFjyTo8riCtd2Q7hIYIJSq9aOhej6U5opWX7cAZDHe/vmeN5vtn2rlUmV5rs3iKxXrBKkO+KeJerL8b6YzFyAk53h8Z8ajqr2/KE0v7eBLx+COShX/U1rJ9NOgJ0BThk9XE6QoBTqfTr7Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DS7PR03MB8219.namprd03.prod.outlook.com (2603:10b6:8:267::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 05:05:52 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%7]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 05:05:52 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH 2/5] mtd: nand: add generic SPL NAND MTD loader
Date: Thu, 29 Jan 2026 13:04:43 +0800
Message-ID: <20260129050446.8858-3-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260129050446.8858-1-dinesh.maniyam@altera.com>
References: <20260129050446.8858-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::13) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DS7PR03MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 4733fa0b-f6c3-4d39-0d84-08de5ef41312
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?82wIe7CXNOpP95dRvilmuGZdahUrnMDm76uPc5jWXeMk4onAFK31iJKpLXbF?=
 =?us-ascii?Q?xFgsHT/kt8sUrqy0cSz78uotkPxDdLwpZ4DRGbWeQiuna4ClOmHSsmnFXf/t?=
 =?us-ascii?Q?Eu28ZM9Txysp/1NxlX/WXxe7SfBG58DU3Pb6SQTI/O5Y7K25zFDyjv/s6mYQ?=
 =?us-ascii?Q?GNSWNKCleqcB2B2OZl6Bf25idy85hn/+E2dqIuapegda88K4Msgfm7k5ateH?=
 =?us-ascii?Q?T8d4nQBsK+JI5nbVwgfFMuCKi5edn93Gpk5r9fyTcNeU9uvSB2blNjZmA1KU?=
 =?us-ascii?Q?AYMHEK3pAXIf1cTlpziwcKCkphZMDmH0pZYRupqQ89yIB6gu5oyLHJAyHeFL?=
 =?us-ascii?Q?Ec85FnQAboylsJOX6zeRPjdgNvX9se3XbS7Sj/yvky8VDaJ0Vs+yJClL/dbQ?=
 =?us-ascii?Q?9l6m2/9BwbGDbpF/ApdYINDKWWXAEj8ZcGdth8+qSv+5QZevk0/PIOHhVBQ7?=
 =?us-ascii?Q?LpIBB3/zhpaMkgDI0hTyTJmVGPh5FtSj2rT8Fo1J8q3pq3pd/XA4J2DPYzfl?=
 =?us-ascii?Q?Vf/AoC6D8lbOLiClui+wXuHQKwM1MPMg0KHe4gxednuhisj/bf9ctxe5OR65?=
 =?us-ascii?Q?hsvuUPK1UP4NlKKexpxwIDnyAya3Ww3SrJMner51G/FXCcCOijRWrtbJuyBG?=
 =?us-ascii?Q?Qcvk+U8p24vavuWW6EgTAtSJgmB0a91LxWWU/GFdbx2NoAVqRZ8qzb1/HY6r?=
 =?us-ascii?Q?IoT6hSmWzs8D8a1aJFsCrki4PKyq2YXr5ouE+hVCk0wdHTIadArv+XxSM4Kr?=
 =?us-ascii?Q?y5PIMiOOqGgnO6/r3O22POEvj9IvSLRKbQ0L58spSVW8BEBhTr0nGZgLU132?=
 =?us-ascii?Q?eJnHYmEuQLltyQdCc1UgPDlVbK1LKDPn+Oq7t8F5MmYHSfla3pDDdckJWtFL?=
 =?us-ascii?Q?fHzJTiO42ahpdTaLoxz9wBkKIaJyUga6ivXIjfJxsOQPKkjc0xVvJ3Uzmv2v?=
 =?us-ascii?Q?+U7Yzi9f27B8o4G0Q12yPgHVgdytHfmvGB2BKXCqdkoS+wDsN643fVHTwnve?=
 =?us-ascii?Q?NtRREh03JUx4yiJCXil/kww4P+wuMR2mt+CABJWKu9Y4xRoqVGHbGAh6ttQN?=
 =?us-ascii?Q?LXToLHGX0831n7MCmn3jXeRB9jbXZF+BX+iaqPOSNM7q8I6hBqdWpOvIWYbN?=
 =?us-ascii?Q?oK1hUMRiFm/sTS6UE1PtSQCAsbqk21XkskWNtrLdOXyXJExJROX3hUBzYEvQ?=
 =?us-ascii?Q?nWbg5yoU3Ua6CLJ66SfccHXzaHw7Pqu9Il/hKaBDybXhOaPpjHbB2KO5FrfO?=
 =?us-ascii?Q?uOLdJZEgn8lTLQbbtfVRsiV5mh700qYYjeKnnjWXqrCHYyVmgvZsXOt45ZDe?=
 =?us-ascii?Q?20mO1OERmWMGFcl5j+zobVUCdWcRo9eUZ+la3TI1MlUkDyxJleJCYO7pKV2G?=
 =?us-ascii?Q?nJcpotwQ20zGlJeZIPThZJCmyv2euVo/tmlfff0GRzIKpmnmBBP9IzVR9WXH?=
 =?us-ascii?Q?BtRrL19v1CpR3R1agDxVZzNkK+vMEB9tnJnyMPo+GLLFp9+r11mbTGTf3paR?=
 =?us-ascii?Q?5qY3mXpFSzqULIXCs40Huu0Vs5RwsXNj5PE5m/ULKIXX8GF4rLnh3Fr/72NT?=
 =?us-ascii?Q?x+cB+kL0Ldm0I/V4rsA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K0VIpHKqS6l9uKUg72bJdV8cZGnLVLrcS9T8L4QbxnG2v+TMdpqtBarQNzIl?=
 =?us-ascii?Q?MsIhfyshvehV8NdGA+G/GiooD3Zu8LxYzlZ1KnJaToNBvOAcJfNgHqVRSTZl?=
 =?us-ascii?Q?vEE6Kv6VB6eUm6mbPyrQihCmXnqYXYsXtlW3+xE2SAU2KCNdFCODf1d40a+k?=
 =?us-ascii?Q?jjlBk5jBmWTjssnYDNkZyPvFzoNxjZLQ8x6Vi1US0NoSIUB0lOAJjBdKD/Bl?=
 =?us-ascii?Q?U9YzXoxXy4YBqek5jDRDjyV7z3flIPV1STc/Y9kvYYgthwPP3keU4bw7y+2x?=
 =?us-ascii?Q?VWZ1pjIbDBC9olNfFuviEc6rSJFfkTQRIfzrkbYtvCQtqQ+kutWhUB0aV2n4?=
 =?us-ascii?Q?J/88glHGCvQXuqPWgxi5/1U2ttYGN5tUL0hs6ViRbV0cQ/wg0evF7++2JAcA?=
 =?us-ascii?Q?fXkhyV6N4oTaE7XzpDddrzoeNeKSiJTqp9wDvgiHcrHIHRs/oywG7JhucvGg?=
 =?us-ascii?Q?hCQuzcrlFu4hHGgr0f17dvvG7wjWYz6SpT+Nj+8oo/+aFY3aPWGn8LCroCEU?=
 =?us-ascii?Q?/XlOy19JXTdsR+Frl/BYyx4KI8O1vlOud2ItAqku9I46koQipQe1hGv9M9/D?=
 =?us-ascii?Q?06RWzpo5Q6K/l7BQiFgx55CFi8WR0Y5T2LZ6E3+a/EjH/tAWxNE2uUn6+W19?=
 =?us-ascii?Q?goV4M/D3clUW7PWUiixFdShY0/x8YZEO1rRR7Oz9ShBCqUXC5jW67Rxl0zYq?=
 =?us-ascii?Q?VtYQ1w/w6u7O/nWerqr5xlgPhOrOVVRMvc5PN6BA78piBnX57HjZVhgY93GR?=
 =?us-ascii?Q?gdZ+kAvwsjooUjHwuzu2Rkq2JCp/wCcuPVVO3ktEPX2fXzVP/R4OvKwJk4Gw?=
 =?us-ascii?Q?LCpWVQTlDZ3pVo+kxrvsgpDU0o/e9EDOq8C4hbPIHoH2BwqmqbjNrr5BrFAW?=
 =?us-ascii?Q?4nRzPaj8x7oQW8585xa8Z+yoYHH5kFA0ygOXsLRT+1nwshOoUI0agJvuBe1I?=
 =?us-ascii?Q?a4vQM/1YKR9FXrIDh1fjNDRoilsZEMhpLQKzpXtmFrAntiq0D1Ey2VRTin1B?=
 =?us-ascii?Q?rzrnqjtRdF2gVxi86VVEQD1jeLwscsWJVJmYF6+f1ss4TX2uKeuO+J/VaYbE?=
 =?us-ascii?Q?BPyb5uyaNpAaJfisF/7L5YvhnMSDhYy/oSsbIOYBLXl/wChSjS0T3TLzqq/1?=
 =?us-ascii?Q?7LQHEz9AB0FolQlaJ7mVawFsqh2Yw4W2NhlAgReJVtSNou0ppvLDnxGVl3uG?=
 =?us-ascii?Q?/bsklnxsc5O7RepfjI5SaLSIW0SF2CTRQl8SbBnrherz5qVUN1vDmrQYF1au?=
 =?us-ascii?Q?fZiYrTFCnemZc3NSDVDXLwmzgS9DYXOYTfQtwZqiMxEA6iKUStsdm8X3jWIg?=
 =?us-ascii?Q?FNflzGrvdrnumhOZ0H2OYcLKdEtkZD6iCH/YPK9Ftrq6DesNCRQ2Oz2OW1GB?=
 =?us-ascii?Q?7sdHnmKu4nP5CWyj9Sj6ghMeZoxu3koJVCN/lMsrkAWFSBai0TnasfPx7i2W?=
 =?us-ascii?Q?FUhP8oWtyzuWQOafvAXPnAVcuriWpTq3yt0gSSsPXlwU0aO0ikeQNls9lsew?=
 =?us-ascii?Q?YhV8nJAztDkCuN7xafVx7/Q2i51/Fx8rnzU7rdBDNFtHzL3QpA6jB86Uj6mZ?=
 =?us-ascii?Q?JYLDnXq/QPStyYjx3nIpA/R2S2CD+Cdcw9gkRbrtixMCurFm/k5SXRxJZD+M?=
 =?us-ascii?Q?fmwgvkBtqQrnvu74K5yAHQFbwzUvYKauvX380PMIzMrtcVWXK55JaPZuN0pM?=
 =?us-ascii?Q?oWrpMFHVVBt5rXpCVCAD7Ume4NxZ+v5EdO2u1n6Uw3Da2DIQvDm/7uIil2Gj?=
 =?us-ascii?Q?887n1UfiPAh6p72UHG5d7xVGJK5LalI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4733fa0b-f6c3-4d39-0d84-08de5ef41312
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 05:05:52.2961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDrT46BGxpIFD79/duIZaoybXs7Nb5PlGbkSgFFhW4xZXonpY7PaZ2ZqI7ExI7v5ym2YFU85R4ewYufa2oXoDIhcQBh5KqO6hMLQtVAHGQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8219
X-Mailman-Approved-At: Thu, 29 Jan 2026 06:31:37 +0100
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

Add a generic SPL NAND MTD loader providing nand_get_mtd() and
nand_spl_load_image() helpers.

This allows SPL NAND MTD loading logic to be shared across NAND
controllers instead of being embedded in individual drivers.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/mtd/nand/raw/spl_nand_mtd.c | 76 +++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 drivers/mtd/nand/raw/spl_nand_mtd.c

diff --git a/drivers/mtd/nand/raw/spl_nand_mtd.c b/drivers/mtd/nand/raw/spl_nand_mtd.c
new file mode 100644
index 00000000000..06bd0b6ec88
--- /dev/null
+++ b/drivers/mtd/nand/raw/spl_nand_mtd.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright Altera Corporation (C) 2026. All rights reserved.
+ */
+
+#include <dm.h>
+#include <hang.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <nand.h>
+
+struct mtd_info *nand_get_mtd(void)
+{
+	struct mtd_info *mtd;
+
+	mtd = get_nand_dev_by_index(nand_curr_device);
+	if (!mtd)
+		hang();
+
+	return mtd;
+}
+
+int nand_spl_load_image(u32 offset, u32 len, void *dst)
+{
+	size_t count = len, actual = 0, page_align_overhead = 0;
+	u32 page_align_offset = 0;
+	u8 *page_buffer = NULL;
+	int err = 0;
+	struct mtd_info *mtd;
+
+	if (!len || !dst)
+		return -EINVAL;
+
+	mtd = nand_get_mtd();
+
+	if (offset & (mtd->writesize - 1)) {
+		page_buffer = malloc_cache_aligned(mtd->writesize);
+		if (!page_buffer) {
+			debug("Error: allocating buffer\n");
+			return -ENOMEM;
+		}
+
+		page_align_overhead = offset % mtd->writesize;
+		page_align_offset = offset - page_align_overhead;
+		count = mtd->writesize;
+
+		err = nand_read_skip_bad(mtd, page_align_offset, &count,
+					 &actual, mtd->size, page_buffer);
+		if (err)
+			goto out;
+
+		count -= page_align_overhead;
+		count = min((size_t)len, count);
+
+		memcpy(dst, page_buffer + page_align_overhead, count);
+
+		len -= count;
+		if (!len)
+			goto out;
+
+		offset += count;
+		dst += count;
+		count = len;
+	}
+
+	err = nand_read_skip_bad(mtd, offset, &count,
+				 &actual, mtd->size, dst);
+
+out:
+	if (page_buffer)
+		free(page_buffer);
+
+	return err;
+}
+
+void nand_deselect(void) {}
-- 
2.43.7

