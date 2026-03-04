Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785D4EDEC04
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 04:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF9B283F9B;
	Wed,  4 Mar 2026 05:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="CVDXjxE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD8F283F61; Wed,  4 Mar 2026 04:25:38 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B03D883E7F
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 04:25:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vB2T0P+zatT4pAt6hsheiKPBz+4VRFqE0qLsKx+vclNKSXomRQuH8M3pfHhjCiIzd4WZhI7e3BkTJhHbEQDGiLnVsZdANzu9AH5tVw0gg08meAoAJQFluOazXHJ03vrvlZ05SJvrZipugxdZy/RFqXez6lYA/D06tXorN7HgV/Dluds537IV2iRKbIGA2fj8zQDT1VOaAPztCsI3uLUmL22SJ15GlRLJqa6WV8mCU7ad8RuVc5CB7mEkeVkjy5EZYBCH8Ce86QeUnyp5qkOPtoCB6x//+5W9QJNTftnO3Y3eHZQf3n2e+Z9nN/kU1aPA6ttIVG8xLvBZrt8oBdP5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTeWMTROdZN6x8NI/gPDM5KwBmG7QniG+T4GyJQwfIk=;
 b=oa8MDMNhuuSlK4OmVgwm41FpWVMfLnZBwpoJYvufF81bPj/K8wRE7n+0VtREY8ekTbW15jYGqHzAhWFckjMiAXQvw5IuM7M5ryy/7UsDv4Nx80KweZYciiG59evEGEImvPtIWnNkzM8Ck2TgozqxLNELqBKN+OcTXHCxDbTRzH24NCfw4JLscevHY4SW6sRaEvLa0r3fYnubkRNb+btLR8oEQONSC9nqOCXOQVH2F1lu4lcVVb9ATQVX55HkHgKvwhhaV3HR6KqWXow8efDWadLxdQBqYx/e6rxLnajTbP2OAFcTFVqwPL2AhrZMtP80ChfOvdGXWb7Eb1onXZq9lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTeWMTROdZN6x8NI/gPDM5KwBmG7QniG+T4GyJQwfIk=;
 b=CVDXjxE5mxsNCvKepRN5NR1EeW4doYjlzGomDcX14VctXKWkHx9z2xtpCvA+5z8Wpl4aOKGOAXYLPhCXDTnqRBE0Zyolcrrw4Wp2uaCURRhkr7z+2lsPMpkjSrl6DLZFl4WQkAaYd9RVNNIesRdJYWXom4MvkGaYOqbERGnAa9Z3Prvg+8cf7VRV033PYuni3Ognyl800fT3O3ES1c0M+oBxQp3XcZr5wzQqyfhSuBb4UZUhZd3yxubry2PG1IReYSfzAntboeMOHl3EjrvdYgagZ43LLSPqqbs0nSGFZg6oTkCv3dBxQCdQcXNn11x52hvPZsORpMy5yHc2h+EmGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH0PR03MB6605.namprd03.prod.outlook.com (2603:10b6:510:b2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 03:25:33 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 03:25:30 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH 2/2] mtd: nand: raw: use raw NAND MTD header
Date: Wed,  4 Mar 2026 11:24:41 +0800
Message-ID: <20260304032441.31558-3-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260304032441.31558-1-dinesh.maniyam@altera.com>
References: <20260304032441.31558-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0127.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::12) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH0PR03MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f14e75a-e952-49de-e53c-08de799dafb6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 65NUlt1ptZ23H/Yrz8BYlUWr++OKq6yfw46J2ZUZgzDx1kU9lyxu8PoMOJB24bNNztcoBCG+siScERTzbGgub8p6HTIRWMB6JrE+70JZ9WA7XlXhAEFSaoT30yEyoAGuddZPGFneY/gZ7HKY+l3wso8VsA/po/Jn0vinA+FNnaD4gymJLAKc0UdFeKw7yj0fu2HXjlbA93qd3xWaeRcbKwFWZtfOsohoX+KQYKy7r6xdJnXvTPMTHEHcQlfHYLs+qwPFR5vQmXfkjXzIkAd0JiuZN0SETblRvdEMfAqzyL9QQAJeczJxpwz4OrR+rIpn5Tr7bjSPnF+ep2V+RpQr+GZ7E7ioW6LaatQetwWzVrY0tVd/42HOF5Je256rmcloEdUhbn+flv8aDEoZ+Yw8JG0l9VhxbYT2EEyjFvAWfwNUZ5e7CloCNvj+l7G1agjvY5jTCyLbeUjNlf6oOhvCyBPYoyV0cO9TWy+GAopVEk6qBIEN8G9Fm3wB7noSbm8NRUVoxqVLYzxa+JGPKZ6o3tslSGDvjmDb7DAeyAb9O1vMHo2NPZzIonVEWkMLxeDXXUmwDB8UhDxAg7swNLCncQDXu43Uh8avjjASNjA90lY+spSczcT2OVgj5D2TRHukvqJxYpam7+uXUYrUtuSV77psfrt7sGYXYu7p2Fmm7cCV6Taqhu7ealuSh78MTGv7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lp1zDxBkTTw5/SG9UAuuMo9CPblMtiCOlHQ8SoHE+Dazm4Vsg6ZVcILLoezV?=
 =?us-ascii?Q?uJnUKt4KEcvdw2NXo06GNreJuLuIoCjFvUuNFB9EbQJ1DiRK2L+z5Zd1gtDv?=
 =?us-ascii?Q?C1j1wYHOkoWfgsLh9z0d6ITh2YaeOhsKkMm3t0J5ySfE10sRybz3G/cQtAuD?=
 =?us-ascii?Q?l9mSEka40h8Q/u8bmWsy6wj1LgjmjvokxRAvpLx5E17WbDSS+93bgZYsMsiu?=
 =?us-ascii?Q?a/QjmqiMqwQ1QMq4wr5lb27mBShaC1OBL4k7apu/nv/Y2v3l/JbQD6EZZPij?=
 =?us-ascii?Q?Qw8ufE+2V9MTTWbP7lEfhhRN1j9Pf6xgsIkD02dehbgUu1KDElDFe8PQ+zvw?=
 =?us-ascii?Q?dtx9Acgst9Nm9sc9e1da/wcbUUsFkFoNK4vs85xSNAnhIGlDnWYwDgm+TxZ5?=
 =?us-ascii?Q?aiTpOlsdsOAyc0BVbbbgZ4wp7Q5CxR6wZ9rSeqiY0suUfpcvmQfxc9diOgyg?=
 =?us-ascii?Q?Tu2hYAfmiVRlpfR7BKxcJjoxztSmxTZWwqa8dk77wBKxxmKakuaRm2Sv28ix?=
 =?us-ascii?Q?IjuZeBWCZmT1/ZwCWoiX67jWlVAcOUffr9lrYoHi1k11pWulo8rmnV+TBjBh?=
 =?us-ascii?Q?brcmNOGaoGLyOj6xKcpdSK04UkXCMpC2XRqOB2DUC+/EZOcI0vEjylWGTCuY?=
 =?us-ascii?Q?GQC8nj/aUoz+gtlZMhtBSAVLP8q8n7VTnRGsDbi2KdVlb3+yDFs5YAOUsZfP?=
 =?us-ascii?Q?h6xx1bdx74snzZn1+rCh1pFB9CFq2zVYJEgSuFHcfLYSVOapL2fnnfpC9O2a?=
 =?us-ascii?Q?sUDdeYOPWwopriQmPY+yW42YiHAEGAL1kqd2zbU01hmoTH3+N6wZMpFgwhkR?=
 =?us-ascii?Q?LWEbrRL+r9d7ctUVjG64h625vG7LINUerA+o7kaoATgQrtEGSFG0AiAXoOTe?=
 =?us-ascii?Q?s+HbzXUcpypVTEp40p3GZlLc6BNaYJKMF3906Fh+Lcs3oW4oQxrjD8anN8NI?=
 =?us-ascii?Q?iuw8zMvRVRKER8WYAlEHZXhP9HxVQrn8vClVgpNjcKDhIDkQ9xXMJg/E6gEq?=
 =?us-ascii?Q?x7b4FIpjOsbCu5aAs0gdQJefSP2+l55nbN01ZqdvT32TKoX7zp/sT2R5WW3p?=
 =?us-ascii?Q?pjhL/5avKvLgUw8uwRAGAh1JhtJGtpOu39U3iiu/+Satj8M4jDZ8d+wj2v5h?=
 =?us-ascii?Q?pk5I2DmtZELs/mBFFfyP4sZ2w5TVzWVbqpZxpehiUAIA1MA8pDIOQUE4x69I?=
 =?us-ascii?Q?oAWT//3m3U80OwoKMl7T0Z/QDUyAFYRBTZTcgtTm0i3+6lWrGqX9h4opBGAH?=
 =?us-ascii?Q?kC3TZb4ZBxlvzcbn72iXtSMMFeGtpAJ7hkSMN4EQHl+2eDwB0jfkDSMtsJYP?=
 =?us-ascii?Q?FX4SmgpI11/ypYm6tefMwDNea0JLzkDEeg53aqw1ySsKhrTP0WmFe0Or9Tcn?=
 =?us-ascii?Q?bYIdXhJ8JmV06Y9j2eUk+8i9qL1rKRRpB3nhanhWFYEt9IC5xOMgfzPq3vMo?=
 =?us-ascii?Q?rM8FRyeKaYPzHb1fnjfKCOjduhca6TC8PUCOBFmGAoL/u9DoCB59FQRYRu5R?=
 =?us-ascii?Q?0TshRQA8gZmowXHmxtcEYTQAStYlCst6JQYPCpFCo3kvfi5NCnY5DGUUx85c?=
 =?us-ascii?Q?Do8ongf7qKZ8m5ZOFSm9CL6oFk1LvH8gQiUAOCN3xjeLREXBMLxMKUFQ1vKS?=
 =?us-ascii?Q?f3KRY8o0RENS0385jayNm9R1TZYbDDzH4Z5iHXpszTNz5x4V5rZ0xWGXd6S4?=
 =?us-ascii?Q?hjQWD/6UgR6C6jhMP3uhe3vxXTPsDLInbYJHKb2SvGfq90Yofvx67GvtWoYq?=
 =?us-ascii?Q?ZSvzBgOiLINsEPjwgOmfG3BF1gt4aW0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f14e75a-e952-49de-e53c-08de799dafb6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 03:25:30.2276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AW2RKhgde36X/zA3BnJR4nF0JNlJVMS7AVMsgC6zJDgIa+COI996jw26ZWeH155bzI3U0S2pze1xLLSPVf6lBwtJDC6eB233d3A8AWKlD3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6605
X-Mailman-Approved-At: Wed, 04 Mar 2026 05:22:07 +0100
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

Switch Cadence NAND code to include <linux/mtd/rawnand.h> instead of the
legacy cadence-nand.h header, aligning the driver with the raw NAND MTD
API.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/mtd/nand/raw/cadence_spl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence_spl.c b/drivers/mtd/nand/raw/cadence_spl.c
index 17058e49faa..145ddbcc4ae 100644
--- a/drivers/mtd/nand/raw/cadence_spl.c
+++ b/drivers/mtd/nand/raw/cadence_spl.c
@@ -2,12 +2,11 @@
 /*
  * Copyright (C) 2024 Intel Corporation <www.intel.com>
  */
-
-#include <cadence-nand.h>
 #include <dm.h>
 #include <hang.h>
 #include <nand.h>
 #include <system-constants.h>
+#include <linux/mtd/rawnand.h>
 
 /* Unselect after operation */
 void nand_deselect(void)
-- 
2.19.0

