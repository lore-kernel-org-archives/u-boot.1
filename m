Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5ECDCAC583
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 05:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFC3F832F0;
	Thu, 11 Sep 2025 07:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="lxiCxdr9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E1EF83287; Thu, 11 Sep 2025 07:21:23 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7677683287
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 07:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfZXezOfEjyk9ZseTx/rAUVX4N9912hdLk7j1x0RE5hH8Aslpg0y2rv4sXp29l4Ff+jw1lSL4jgkQtnUhoCem/JHzlss2xTgUU6us6hp8GQ8zQPsVMzrvq6Ko7NzJd71rAueKXy2DqycJI4rAavnEswfkCYZ1h1xlStWOLsDWvsEbVZ2mwd8cfuGp5MAVZioxOj6SL8xcTsWF8m2rm7cvm4OGC3Pouj6QWIwUp0evhEsh1HwgbRD7lYwfmTWS/OBiGn0ZiyJQtN3XkT9RbVA/ykMVAUrJW9BQkvPtzQWLr8OnJ16WfJpy1f/QIkKt6BJj7rVBSSj85C/W38sCJ6sfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nCro1u6M52KwdiBvLFcx1kWvOw4i0/TvV01h1t/R2s=;
 b=Xn0Scy2Pa0vkLCZ4xfqjBQHrm+jhOsuzFM570XbTHOJILf2CXOVcuy1P9pvdP6sf0hL1ZLZZ9xHdkNMqQAsKCTGUITkLThd1fd0rdvyfyT4+M3Sgk7Ax9g4ut2S+GI5MLwZaaEM2ql4SY8lMQRK9dj8/hSAK+6YqX4wl6K4kHIK31tEEYu/WDTA3/JJAK3cs7ALrfoLkO9M0TmfpeWnqpJr7mesjjBwkhc32o0fEwGHUNA581p0RSVaDeNi+sU4V9ZlI4QFG973SBld6v+HYJvbIF4BFDDI9w4e7JSmPRyiAg3eFJ8t10iyLcGeM8n+aug5vPZhLEM3NjvOGDxq85Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nCro1u6M52KwdiBvLFcx1kWvOw4i0/TvV01h1t/R2s=;
 b=lxiCxdr9pDUsupMLPVf9mfklY4N4inqRSLfsYwopiZx0amgFhyCB/qL14NG0o+9Ab6CnaB486zosv0sL/p69upRn97MzVe09NKFWusOOavPWXs/QRwEJ+wH7CLf9/ZP3XL1AtXGS9xX75yUy/ZzIcHtNuhbxNe8MumkGdhp5Bq8fgXw79fkHGM1pd6PU/cfLtCRKZ60Cti/65v3vbbLB2zRbzjoxK0kLMVYtCeQdEU9ZfvbVP14qORUtSc+MbYhjSuT6HAk8csbCqArqaKbrkDhDBy8qvzaxGdKQDl+GX+neyM/iMrwNRCKRANwZZDHz9WO4xfHCfdlBIJql7yqZxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by DM6PR03MB5050.namprd03.prod.outlook.com (2603:10b6:5:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Thu, 11 Sep
 2025 05:21:18 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13%4]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 05:21:18 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v3 2/2] drivers: clk: agilex: Use FIELD_GET during EMAC clock
 selection
Date: Wed, 10 Sep 2025 22:21:12 -0700
Message-Id: <20250911052112.15383-3-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250911052112.15383-1-nareshkumar.ravulapalli@altera.com>
References: <20250911052112.15383-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::35) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|DM6PR03MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f464a65-47af-4bf2-07b1-08ddf0f3095a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?obqRxLxX4UBSDg7VdhxieZ1CFTjDU3PdKclzv4xkMU65ZhFdwGIBA8rp/5Yt?=
 =?us-ascii?Q?bgF5sYbP7lLunST2tlbH5Vt8OE4RRLq2aJ5SIKJZExa3linODRSLIX47QH5o?=
 =?us-ascii?Q?cpA1k9dT346BrRjCOv4dZmpMFTQoCMXlu8/n+VzxGxdqToUctJy4wY6RqCIe?=
 =?us-ascii?Q?sZNJPGWVY8olURVbtUfeKrob7IS3+1zCrUZherjDpWJfBIi57EmE1KzhoWTh?=
 =?us-ascii?Q?w4low4EYEvicqKOgRicMnnBLyzY5B9I6HUSp2+pkqezH+hPL3f/x2mdZK50o?=
 =?us-ascii?Q?6daf+qAWmWvtWdiS+wT34YOjkL27GzwxwNGQNSzm2NWhIMFCJteWtDZ6GQQu?=
 =?us-ascii?Q?nd+swVv/NA9gOD1m9QzpyuJGh00BOctUHC+7QwBtSKURTxuCsVKVU9sIGFHl?=
 =?us-ascii?Q?IBoi4HkciBZXDjxaiTUz0k5dSu3BYmrGJWqhhO9K9XEvLeCo2d6Jt4hOMYz+?=
 =?us-ascii?Q?I5I0dq/w/YRteGfFZIidSL6qt4B/9JLkPbBq8V1QIW46/Q4nAyTpUwpL5e39?=
 =?us-ascii?Q?7ffj5EOGtX9SblpysOQ5nK88k3tXDGYoO8X+frv9KqCwUsWsX0PO58FG0P4d?=
 =?us-ascii?Q?RrKenkCCrdXydvJPWcfW91yd22xFJ44m9ze/Ood41yXah8ckQ3RAjTq4rHAm?=
 =?us-ascii?Q?Z6KXY2YienaZAGLM7HcY+OjdZKz6uRqTP0IHMIt/7XH1HHFwKIWmAR4vbK+9?=
 =?us-ascii?Q?wXdH19gnKvqqkpZ7bzFZq5j3RLuoBN8AzSTfNspNL07OgjIqSeWscd47RGLP?=
 =?us-ascii?Q?ECCUspIA5/uqf0UTcbwUR17VQ01dZQN368Lm2hW04XV3UgHCOpzhB9RoBKhK?=
 =?us-ascii?Q?r24IqZtQSlJMVGkfxsm84c31BbSlQ23cOaBnLDmWzKyf927qLf8L1X6H8hns?=
 =?us-ascii?Q?ibh0bSIU3x84+OWnCIiQ0drCgDQAUX5w8AlbjX+Tdj65YKj8aC/vArojhY9S?=
 =?us-ascii?Q?V4J4FRDFj+1lGjBF+Q2kO63oiHhvOQVDEZUv2c3969HgwUy/lCSkwX7nIDLd?=
 =?us-ascii?Q?Lt9PXGNegIa4AjzZSVm2IlBzQrfg0M8989iCnXspYwTE+qDF/bk8xnBs5VLI?=
 =?us-ascii?Q?gLcOXCtTQWGmuLR/nywLPMCx6hPOk9WCN4Hc1puNkesndqKEVWPKc+5CnOKT?=
 =?us-ascii?Q?EJUkKfgmxPd+aU2UJU7eKJfgZtppM7pdsZYv/tLyFI/JLe3ttgFRLk78CFzP?=
 =?us-ascii?Q?W7KWGJ3tPBQb7WuF1Ab389XbBCienjKmO29zFWUJgRyNULQDIxJuKKJD4EWb?=
 =?us-ascii?Q?pPpTkU9VqBxclloOFiQv8stAVw49tVrZ8vRQyJYWRKtPovw6Ld3Vzz1Z78Z5?=
 =?us-ascii?Q?GR+IK2kMBKj6K+jogmS2BgTv+xymRIQAPs2ywImhZAmH24cVMLEIDJ2vRBCQ?=
 =?us-ascii?Q?aU6LAI3YOjf50UgawxKnsH3dQ1U3tSVj62nMy9zRcXKFd6qoiqli78nuW2ci?=
 =?us-ascii?Q?t+/Jz290yM0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VeG7iDlxAE0stxWObDDopMR8uzx3Wvis23rhlxt4/2zMeATCyaKFXhRgApYM?=
 =?us-ascii?Q?zqtg5MqrUUV85lpKX/kQI0Fgaji6RqDDLZ7miG+5QXcMDMa/OjYdP0zn3jlj?=
 =?us-ascii?Q?/IP861iCeIDKg8N0QpMZXW4+QOHl5Qap/PTorw2swHetgVC8uqRHacoJylTw?=
 =?us-ascii?Q?tIByEfEy4o/3vTgkUGuvmI/IR+R+3dyGk2SlqoPdLyZlzn20hVI5yu1GYiYN?=
 =?us-ascii?Q?allj6lMJXVt1znXS4Ncafukr0BdndKVm08lLh6HTkt7P3Tr1nwb6+CZyIzRw?=
 =?us-ascii?Q?mGhXFTvRSp2Pk7qhbhooOCWZfP3iHgm7yfCs1uFXsOIc94qzIQ3ce6QDQSJL?=
 =?us-ascii?Q?Qnf1U+nGkrEmfgSRN2HPuzvOFDwqPNC4WN9VVMjaeBRFRCureiXU8ezgaAEn?=
 =?us-ascii?Q?oSKWPE6VlIUQTKi7AA8bRO9O4kW4lH23efmz87hK9OxlVc8STPiLMoLxlm74?=
 =?us-ascii?Q?+V0dlLO/bk9/gYLPzMVUXquXZ2+slS3JbmAzK/MFD0Xm56/Gf9wjpfZF3DWX?=
 =?us-ascii?Q?aTh0A7EAAw8Sqg1iHJ29Mmzadyhjk7S7p9XgtoD8DK6QliNvlm5xgRnTQtwE?=
 =?us-ascii?Q?iE+8e2UhyT1VFnnS+l5uSMB6OWI5SP0sS5HnZVsyIWjwA9GoxswaAULPzLan?=
 =?us-ascii?Q?x+qNT2SfZRp45Eyb2bpCVf+SGPFTdoijkRLOaKenMjIW/aK3HguXY/DKl1Wb?=
 =?us-ascii?Q?HM8TDi3pTiXHxenjp2CjOYWdtjB13PppI4t4pYzDDI7ZDhgW7EaCt/Nzg19N?=
 =?us-ascii?Q?WAfTtoqFVMzyDywGd+rQ0Rin2oRwCVVcZmDCWUAYPyCklSzv/pFx3Q+GAVCu?=
 =?us-ascii?Q?o3O4fwEqG3lpeOrWugDS0WK7ImxeJ4Vg/3Dt35uU6QvFmNfCv2tHR2HZeJnC?=
 =?us-ascii?Q?j6TUtoQLhWrBEBFy2lA9PPvlCQhm/jtekz6SPvhs6nxWwV7fE9fcgr5ia9jw?=
 =?us-ascii?Q?nAu6hEfWYmCXWlyqdK0Fmkb5lkZB7Ab6seRSNJ23UXnINXOccoDPvMIbOCGd?=
 =?us-ascii?Q?iWlEf6Tz0jR2bT0XO+aSCT4mima3PCErJxhwVj5aesSmuKY8VUip0pRCaE79?=
 =?us-ascii?Q?Fp1zLFafzBLZmLjYiCOiiT+7wFjoCrQuLh3nIhj1r6iBxcJVL2HGQ65dC7nU?=
 =?us-ascii?Q?It6PO2SPrDT3IJ7Dzk+B6sM8kwSYNpjfrNd79hUmdYED+Lyf5rQTWnmHDSu/?=
 =?us-ascii?Q?PeYd5oP7jeVQECdzT9dOEwayD2nSHduDSEgFT6u5bOFMECKz3UTf5Aoap8hu?=
 =?us-ascii?Q?SLm9nWHMw/guc3bA77y6F08Sx5UEZWA3p1qrAWrXwMyRNEKjEWz6rOGgUJoN?=
 =?us-ascii?Q?4LBAAB/YqgltnHjKjF8G3iG/JIxxNgL3L5J0NCY5f8t6UIAC+QuKQTq1uwLH?=
 =?us-ascii?Q?4edfdjelGRtsmp65lpZ3nmXGc1LF43rwvHIECDyknmhFghCa7psJ9AOJPUrW?=
 =?us-ascii?Q?yggXCnOnSnsDtHEqxg5mAmI/ynjDu5jsVJp8zPBXcSRqj+7evIOC9NORSbJr?=
 =?us-ascii?Q?UfO0AZiD6L3dpuQRLAzQxj0KmtuJcuqoM7TR1jlp8cZ6O6HFPveJVjgaCsMx?=
 =?us-ascii?Q?Ykqqxedp7AQPxv6D8nOknTp7U3l9Z4V35wT8KEuKt+wSKNzC9i+kuN4nPKv7?=
 =?us-ascii?Q?/fICfV36zO78K3LkioIHQzM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f464a65-47af-4bf2-07b1-08ddf0f3095a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 05:21:18.2640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +crsYOAdCciD/uBahzKQJbDoftMHBjOm4reolo+82wfMBkH6mbpNc/YcZDvK/JvkEOFf0yZ9Q66XcrJE+iPotHyGsiYd3/TXKy3pcNYs27Gnh4eExwLybROc9JfoweXa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
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

FIELD_GET() macro is used during EMAC clock source selection
for better code readability and maintainability.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/clk/altera/clk-agilex.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agilex.c
index 16a37b962cd..6dff4cd9c74 100644
--- a/drivers/clk/altera/clk-agilex.c
+++ b/drivers/clk/altera/clk-agilex.c
@@ -14,6 +14,7 @@
 #include <dm/lists.h>
 #include <dm/util.h>
 #include <dt-bindings/clock/agilex-clock.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 
 #include <asm/arch/clock_manager.h>
@@ -544,14 +545,11 @@ static u32 clk_get_emac_clk_hz(struct socfpga_clk_plat *plat, u32 emac_id)
 	/* Get EMAC clock source */
 	ctl = CM_REG_READL(plat, CLKMGR_PERPLL_EMACCTL);
 	if (emac_id == AGILEX_EMAC0_CLK)
-		ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK) >>
-			CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET;
+		ctl = FIELD_GET(CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK, ctl);
 	else if (emac_id == AGILEX_EMAC1_CLK)
-		ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK) >>
-			CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET;
+		ctl = FIELD_GET(CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_MASK, ctl);
 	else if (emac_id == AGILEX_EMAC2_CLK)
-		ctl = (ctl & CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK) >>
-			CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_OFFSET;
+		ctl = FIELD_GET(CLKMGR_PERPLLGRP_EMACCTL_EMAC2SELB_MASK, ctl);
 	else
 		return 0;
 
-- 
2.35.3

