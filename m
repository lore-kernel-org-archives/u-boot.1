Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E272E937FD
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 20:01:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAE0984214;
	Sun, 12 Apr 2026 22:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="h2reCL1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FF1C841A2; Sun, 12 Apr 2026 22:00:08 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0280E839D5
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 22:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAwjVDFy9PDBxmXpe0OjR2Ng2vQbLz2zwmPu4PRv9qeSBpvf1ssI+3LTwJCkjrdDaA75K296T/AlnzxgjwpJhvTBbxnD5oidp0Y7DwXz7gHysPWN9/0yEnyBvU/PYocRfkYRZixXF/eNu8QjgXhz3P/5QIMwR6jqLrBeMBfjHZsEhoukBTQvPvqk+tQ5SvQMaQdRj7YoRW9ZFVsAbLmS6IK0sxdi+E706KFWdJw1ObF3dvcK6D/Ut6joigk+wO+xAaMzNMgVUeS2e76ifWP4/1/fN5j5i5dZ0YyZr/Ht/vy7Mj591a5wPhUeg82rabWTfbPA93ZjpL+Y2gmz0eFLrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jULvsvXDnO6LZuUUTO4Kv2szZFU7msyKQpbEMlXdqFM=;
 b=Qp/79Lkx5H+LM2gxkVejHzdIPpsNGdTXOcni/cfvG46ZGk46RIw+YvR+venRmkaoaECrE+ioXS+ZTkAnBYYqSt/+yi/l7d7OL87aLHMH5BDdFHBMFKLJi7hGFEkP4U4XA1Cul8VeNTZ8Dr0hHMnumHdtRNe5mSO1VE/tka5pQLmfIxz+CbmiEyWjDW37v1NjBY+rytFQih/wJ+htb/XBGISIekUkK8WYTf3J7tDFhHXkY/45RHf4IlADW+D3dHL07WSWSnSSNeODIHikDGlbsdzAoROOkqzMIyIou5o0CXK6eJ9EBdl71c7gzIKsOMZYWFwaVwNQUNxBhy2cMTui4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jULvsvXDnO6LZuUUTO4Kv2szZFU7msyKQpbEMlXdqFM=;
 b=h2reCL1miSCnXn32x1lp/j68EgkTrTBdk+aEIvYlNfyxJ5bnJ9VnRaaJnDJYdVAbAXy8qucrRlIyewzlQFjvbWO9E5WoR8qpwbyBJzjIrMRkfYIfAkyYJj9HcI4WzgA9vZtvN87w+7x0Y/w/eDZQRQp6Xjq5huqjR20BMpnn0e4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB9930.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:341::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Sun, 12 Apr
 2026 20:00:03 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9769.046; Sun, 12 Apr 2026
 20:00:03 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 8/8] drivers/core: use memdup() instead of malloc()+memcpy()
Date: Sun, 12 Apr 2026 21:59:47 +0200
Message-ID: <20260412195947.1982729-9-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412195947.1982729-1-ravi@prevas.dk>
References: <20260412195947.1982729-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPCP307CA0003.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::12)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV2PR10MB9930:EE_
X-MS-Office365-Filtering-Correlation-Id: 21893862-bd71-4d28-3b4e-08de98ce1630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: EbMfs2PzDfiX+jGOrzzLoKvvqjaVpawQCwXOWEF9DJWYAaQCiiT+3KyK4FnysHRBjmSSDbDD1K9PLtwO9QILo6y7cOBabdC+apkn3a2GsgIZsDaasKone3UEO4peFWOxjx5tdFeu3pxWhOeWsXnKG6at0PDyodJ2gk7JHgTE+pKzAGvle3Nn/GO23Na8lB0dBmMjkalnFY6lDJq30PQiElLeQwi6HA4YRk+dE3lz4mFWIcFQMU8iY1ksoe+WJuNcPh4RQ+MsGnBer+7HzfLDSaY3A2azhHn9KUex5jy41fS2aqBd3LS8VfW3Hn/ZlFncK7/wCyGNQmS5QyhpWxk9iggk+IXBUnTv51/A7UUa6lN2+WRJXsuWB3ohFya/rS5stKk8JQ6i0ylmR/L/wp44Z44c3+dxbm6LBI9izdzcha7q+1Ur3kv7FO9c4iTCihgEIR+257uvmpuvBhBbfZX82t+XFZQUQDfQGzWomTqTlcue2CJ4KhV8XDJCGywFyIiCOsuR7WDZt3UJ6sXco+ZknJ79M+ikosYUyYhBiNqdjCDlv6pY4Hefq7g7BgjX40y93iL41/Ms+IE4wfuLMtXlfJmYYB6KfbIsrrlKI8rRpp08pZ4Z6cUnQ27J0Q6PVXu4YwcnkkSAxjovI1dTSZZoqY+M1Lk18tIQTzYDCqCekFr5NeODsyRf3a+N3HNSiAxzN1PHnhslDI8IA5TbhNa0PnnOtEDoqQ9cVj5/v7R2iFsTTixrQ/ktNJTlV82W78vP4AI7uvSQh46H2vwKpyJ0QyshCrqnoRpQPK0oGOSMslA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fRfhhitgM+oRoXKwKWmua5COolUCfocIUfHdAuXw7CA498d+6wGNPbG9KDDL?=
 =?us-ascii?Q?+mgbFyJfkQMHtsZ/F/1oiqWjSLze5U6kaeVsnJJVz1EHnvxxj/9Hypm2npjK?=
 =?us-ascii?Q?/BnwBa/Bbc9u8xS9Xub/nSXL+DIf6+p406MGSEZPSWY1nMCNoA0Fvcj547qp?=
 =?us-ascii?Q?sk4FrCGSIJbVghK0i5z2SKIoX0QtB4RP0O1zERbH4nXiumsvWM7CzsZTpfLm?=
 =?us-ascii?Q?rcu46FN3JqVxOtxDlomkO+Fux3t25rtb5TiykGHS5grk2zOrmgpr0+AaJNoH?=
 =?us-ascii?Q?TM4tnOUuipwyC06BS+kV0ho4wL2VDPOOSyTPGezxGsV3VLY9XbZP7gyC57YZ?=
 =?us-ascii?Q?q+F0XgvMIFaDfXGTgekYaaS+Ib+HihOokp8RK2fMXhKie9lt8NVqrqqvnzMa?=
 =?us-ascii?Q?4h+uQE8JQgjww4obl/SV8ie28ZGyZrqQloG9OWYluLt8MWyEVkdgiiPrmT6T?=
 =?us-ascii?Q?jGyQ1hnWrlXQFjDADpYGpBzegxmhNVQieTAqb9Wcg1y5I/QZA16bhitBDJSK?=
 =?us-ascii?Q?Oq7AEJ0JeI78zn3CIR6wZRkv+smRji1SAFbc6wUbB6XwkmWKvY6ToWpFP9Ca?=
 =?us-ascii?Q?ERd5AvlkKNz5xQWz9d1AvOYXGwlJMEjd56bz3ZYHsjpg7KM0/F7yHGvn8Uva?=
 =?us-ascii?Q?BvET0iXYdU7fXf+OPtW3OOjpGr8pl+WuFrPVVR98z82genaYO89yCyrQ4WGz?=
 =?us-ascii?Q?4yJC68p4NkKdHLElGqojUEnnFIZHWZggkXBr7XWz1giYqxKknjJSWe2BN5g9?=
 =?us-ascii?Q?uXZFmd2bH4wPmzuZLhPIwoOlDedp5Wpuz0+/d+bde2t7LiLW4mCoP881kxO6?=
 =?us-ascii?Q?zmLcqtjMfPCsyxRdkIpcDQ2yo98RT7KilqB02eUi5sJgyPNcwEUzPCKyobZF?=
 =?us-ascii?Q?OXKpUxJRkC/KlZW5Mk1nELccrtWybW2nTxCOghroKKKPhrFN7006+RQCFbRx?=
 =?us-ascii?Q?/U+92B7FDDl4VVq4G6quB4nxjn3QdsWtMNEFXShEe3ztmhoz0ZSCK3drrNp2?=
 =?us-ascii?Q?aEQtPID8tAkdaZxBFlXTYM6Og5FvCQ8Nf6AR+lk8T5VSZxkWtYw19t5PlJQi?=
 =?us-ascii?Q?JX6l+/6w/ZDkLAUROyk1xp1cO+DupLascws++shlwutnA5VS43ISti13Lqzw?=
 =?us-ascii?Q?W5KufqHUFmmY4a99nzbTgJJy/SKHB4wWzY3+ZqhWRxMQ4YeS5q3nvKYw9lTO?=
 =?us-ascii?Q?H0ZUuN49t99bAqiBVhsONzMbi6xg1IJoD/seuKoMAS9gXWrsRDz8OqpK0SxX?=
 =?us-ascii?Q?SobOSM8GdanBh/di5WIs7AzpsxC3kF7oO7SPfhTdGrOtK5/DKJIIbtYzrwo8?=
 =?us-ascii?Q?qYJ89lh7IkVjTdIODD9brmsA/LERbbLeRgt3SwitffDbYupDLQnu0ZMV7Xow?=
 =?us-ascii?Q?ctqYi9mj03SRCOVvkRhcGLzI9+UAaEp27r7WVn/ourvPi6nGFkfJ6uJ9uMRn?=
 =?us-ascii?Q?jTh0xC7lBz8s7dr0sYgyF9mN6anHfHyOrbQ72rAArmzxNVwPrhLibPGEGtxB?=
 =?us-ascii?Q?BnNn6ln98AkQEedsHgoXOU0C86xjHttzO8Q3XteutHEzL1d7dUTaMCHnUbxH?=
 =?us-ascii?Q?uj86s9HN/eGeoIkJFnfwd1XtQ7fxofp3TLEiICteFexm5uImjGWklNk0ZnR1?=
 =?us-ascii?Q?ucgl/TVS+TfDBSPtDIT2Mr9wdn4MJMKwjkUtpRbXqEn38BGNkSVN+wUTgR9C?=
 =?us-ascii?Q?uqXBJAsMXlnKQLlc6TprMf883Vew1LUhhW0T8V7C9oORDrbhbg0iFH4erbVe?=
 =?us-ascii?Q?x6HNp8yNpovvMQw9SA3P67la3Sqnr9A=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 21893862-bd71-4d28-3b4e-08de98ce1630
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 20:00:03.6825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +60P9rfvwSKOBrthuQazDmt/BrDwWYLLaIrntXkxFBF3uLrVckl6uan48gjyl5zV7dbvvgaQixpUn0b3tre84drDsRuD7JyjKs/TGd81uoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9930
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

Use memdup() instead of open-coding it.

In the dm_setup_inst() case, there was never any reason to use
calloc(), as the whole allocation is definitely initialized via the
immediately following memcpy().

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/core/acpi.c   | 3 +--
 drivers/core/ofnode.c | 3 +--
 drivers/core/root.c   | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/core/acpi.c b/drivers/core/acpi.c
index 4763963914b..6a431171c8d 100644
--- a/drivers/core/acpi.c
+++ b/drivers/core/acpi.c
@@ -154,10 +154,9 @@ static int add_item(struct acpi_ctx *ctx, struct udevice *dev,
 	if (!item->size)
 		return 0;
 	if (type != TYPE_OTHER) {
-		item->buf = malloc(item->size);
+		item->buf = memdup(start, item->size);
 		if (!item->buf)
 			return log_msg_ret("mem", -ENOMEM);
-		memcpy(item->buf, start, item->size);
 	}
 	item_count++;
 	log_debug("* %s: Added type %d, %p, size %x\n",
diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 3a36b6fdd03..12511f10aa9 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1750,10 +1750,9 @@ int ofnode_write_prop(ofnode node, const char *propname, const void *value,
 		void *newval;
 
 		if (copy) {
-			newval = malloc(len);
+			newval = memdup(value, len);
 			if (!newval)
 				return log_ret(-ENOMEM);
-			memcpy(newval, value, len);
 			value = newval;
 		}
 		ret = of_write_prop(ofnode_to_np(node), propname, len, value);
diff --git a/drivers/core/root.c b/drivers/core/root.c
index d43645f34dd..1f32f33b295 100644
--- a/drivers/core/root.c
+++ b/drivers/core/root.c
@@ -81,10 +81,9 @@ static int dm_setup_inst(void)
 		/* Now allocate space for the priv/plat data, and copy it in */
 		size = __priv_data_end - __priv_data_start;
 
-		base = calloc(1, size);
+		base = memdup(__priv_data_start, size);
 		if (!base)
 			return log_msg_ret("priv", -ENOMEM);
-		memcpy(base, __priv_data_start, size);
 		gd_set_dm_priv_base(base);
 	}
 
-- 
2.53.0

