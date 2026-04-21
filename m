Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC44F327BE
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 07:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 741E48439F;
	Tue, 21 Apr 2026 09:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="DpjizCWn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFB7B84376; Tue, 21 Apr 2026 09:55:12 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 273638435C
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 09:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7xtF1O+AUXy0FePRbiWq1Q4nlEqw6E/+VInihNXopwboMdwsRb/T3icc3ca9J05ipdnn/IfNM4nXgaJBiUlHnW3Ofbl5xxRwmJsMHr3UuikqEITFABj120HCCXxMdqjJceDEmfTLiH9H+zqQvCzKDq3KWkdJYsa7cLn4NkRRPtwWd4ZXo0UJ4AGv6BqiK3mLd9gbhfnbm/J6COteb2Q/bCyMbt49naeJIvxPb9oypOJd85SLU+AADLct+n3qgfeXFB57meN9vWV6ZhRxdSsSMvzISHd6KXERyWpEinhY1LqDbnmBuNr8IOXKsbuDOE1l1L+DVIqq5CA0IIp5A0kdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aqzUMss3HigyAp4pp8Dsp0yQ5opqbLCAGcj+BzAXJk=;
 b=Y4sSj/fO5r0TsA64gLDLfvBzOJQTGgdJ/7G6GzlCXCkslsoeOsRJpQg9LtMRBBuRmOXQRo7uN0Lt1VL521sAjYiD4pEsugxhjGMlMx5fGqJ92D40Kt4n78IFO02mJj2O2y308baWf5fMSegE0dx0WwqmEusbMDw+zf0Eh/uyr6X71kyugF66AH5sx0gv+3Ud459PmbZX2qkHz8EMsNUOPlNNPhDIMSo4Q2yvajTiPNERHXF98fdZpMfZVOOLbUGcSyUq4bQTAMTbjb0+IJkvXzBQ7uRQpYWR4ZXa3lclbWGV/7flvI+xvCAUF0aoukpcbZkb8m+6po2TTMn0VEn/ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aqzUMss3HigyAp4pp8Dsp0yQ5opqbLCAGcj+BzAXJk=;
 b=DpjizCWn7Tg/3wdb49xhrNYtOPjMLXK3IpabnCpBN151IMeQ8YspsmaV2OYUqxldnmgtQfjL5n00UJUPcxMZJfsy8WztVK+ivn/9XsEqUyqpAUrdRDV1kUO/EfV035szVt0LcV2nkPUTYkyx5SfP/5CNYlqWD55p3bEfjoosRYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB5995.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 07:55:02 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:55:01 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 8/9] drivers/core: use memdup() instead of malloc()+memcpy()
Date: Tue, 21 Apr 2026 09:54:38 +0200
Message-ID: <20260421075439.16696-9-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421075439.16696-1-ravi@prevas.dk>
References: <20260421075439.16696-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0011.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:1::6)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b57b99-819a-47f9-9202-08de9f7b4ac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: RHJfyW/pk+BxrvAbguuGqtoqRXfzGcMtETOp+JCiiBZtqD54LCpniY7aTVYkZBkrOx4Lk4L2Fh3N47J3IW7mL9tWLnA5WRlpKpMYNhlBUr/yo0sCzyLR/SBlBN/j+TOwhtVPgO90LgiOWoN2wfJ/GYhEDlxLltlczg6qvUm+AOuBCmrgW4Hh0OBGFnOy1rodWrVUI9EWOA1YyPnMlRc2kgJC9KrQei0iMKg9iAnkLtgg/PB17fVng8XJzaseqIbHDeznSeTiAhDB550Y7U0dzkpvCoRBGntbpCIW4LgHWMVZq95/E1SuQKKkYAevhcz4A6CvK/oGqtidXjoqtYL/2qzSaBuZeMyBg4STgvkn8Wd/4Bk59z5UilyW0CyLQOTp6SrufDR0qPAAVkYC8BrMzD9CwDrOFRGP/DtproLQGuO5+FI1QGRCdlvUCOkiXCZ+GQbOA6c4qxkUIC1OXM5rZIRELNEd4kfNQIZfIqC4/2fThKWefyDdw9TVSb0WZNOwb6PTzERqFHmC534ge4wAKlxgmGtJUoasZ+FQ8nD5Ugfwa1vWXoy0/4PYe1BH/tdEuW7TGhgOS8JFODUtQUiNRQxjVp+R+9GIBLSM10yCsnFATXn+b2ibiIZGf7bcyi9h+u1HB2WRVCqikxK1edLLki674+9LFWfxeagpOpGKpb9c5f7sP1/ByZ/htjOLSyA7g3L5bRi6yVcH0UDKDxegUnDpjuf6KYNTNORDbgPJ/19E0mZ6/xCyKIg+N7OGcKvxkwXUpK0Qd+wvbCq07vbDRjH/L+2hb6kYxGUNZvAFyGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jr8sj5FDKAbt1qWrqwPWGj1NoJa7iblAHTXKQE8qDhF2qbO9z8+uuEsnGEB1?=
 =?us-ascii?Q?Ow+1iQQV5D1kDRu0S+ZSnFA/Mb4UEqYdqDO/oOVyGUs9YZT/nWkkWSWCLd5o?=
 =?us-ascii?Q?IfoA9xuqiMY4Qx60z6QZo17VWf8JFIstdzo/PWoiJgkS2n7FknuAT5Gf1uiy?=
 =?us-ascii?Q?6kf4ydlH+7esiZ8hfaNVBaOFY8hVtzHONyASoqD+GHEW1usR6cuXpbha/AhO?=
 =?us-ascii?Q?3JV2NqsvutAB8LBufNRSXFsTLL/Iy8iorenqLoNG1c9B99HpeJiWZz0K+bSr?=
 =?us-ascii?Q?WYZyi16TCMTQVOhzWc2X+lb9k4nKOEXq/w5LJ2zA6rHBgXzc7knkNh7fdjA8?=
 =?us-ascii?Q?5br8cmzpSVJJSFX0KWb3utkzGoRscz1h4k6x/kZo760jm98ARvacAiR9L6yJ?=
 =?us-ascii?Q?vXfuN6znwXToyjmfZBmDMP7tdx832yDOa+W33+3A8gpSpLmks5F5IZoa9FOW?=
 =?us-ascii?Q?skvXzcwTkIdcS914l8dLo75NufmT09fP8wejfRyMWHAQeu9ZU2mM+pOCR5zp?=
 =?us-ascii?Q?IN2qhRUsZMA7jPFUPF7lYol5k3Z1+0a+pAOYGPT2Klxmt55qX8iT+0VYBA0p?=
 =?us-ascii?Q?tcqksLzo21LStZ2tfjoTFl0e7he+EOm8k/1LwMopC8bsB3NLkGlCqENRfqj/?=
 =?us-ascii?Q?CiY+l+KxuWjMRHtZ715TTiaVjH1u9H2GfnbEX+9+WBYjoKOqnuVprp2etLFg?=
 =?us-ascii?Q?EgAScaAvXKgwpf+Xt5231mingIZsl6QU9yp/QW/FS+/Rh6k7Qot3E8jeSBRz?=
 =?us-ascii?Q?JMC6Kcnt3IJMuqHqSjovVQvo2q7Kz5s4cutwKzz2OiRF2ODYdFyqJOATtv8D?=
 =?us-ascii?Q?0JIur7+R5sKe2bDy3kMwOg7QoalAFPrmqlV/Gx8pk3I20bbIgoJRIXhKbvfC?=
 =?us-ascii?Q?MFOhmrwhNXc7H6XMBWHYL6iTrF48Pb4h70jsWU00ay1zA0iuzk/6uo2i5OyW?=
 =?us-ascii?Q?O/5Il17Ezd5cnfn6BhQS9UEmGHPgJWHTFjuMLVqUMTm8Nda0ku6Tb+es5NWR?=
 =?us-ascii?Q?+Vz2liN+gfHZwXtypnm0JgWXo6ULBv2pbwb5MEGRu3wvTut2RNtq9fQbvHcT?=
 =?us-ascii?Q?C5+zySHMWL7RIg8TsyJjg458YuL0yydtLkHqMjGjRc+YJIO6vQN2nyLLYAMd?=
 =?us-ascii?Q?5bWAOvXR6yu0bhPP5oSFL4W3w24bJfq4z6m4hxG/aiFe/4pVZCKh9uWjSVUj?=
 =?us-ascii?Q?ygwHBLXnlPk7I4NXf+V9lJjEdYBLAhQ9OAidtxzrknANB6cUPwPLHIPmTrd/?=
 =?us-ascii?Q?8ASxS1L+N+r5nBXwthFZuhIIthKkSUGkllU6n3PfD1PlddsY0tdbwQzg8Iu0?=
 =?us-ascii?Q?9DZRbgqbIa9pwMW+9VTWBWJ/zcMQBUqGgvA5T+38wDj5HB5j+39gAyG/t9Mm?=
 =?us-ascii?Q?+cuWjFKz2T4Yc2Qbngip4eCcG55iTc26dvS2U+hbRORanO9q6MxQK/BMW9ln?=
 =?us-ascii?Q?tdI2Cj9O1hL8uJTxPcKLu+x93vWOCqJ1CQING30ZIcTePA37+NO9uZdOcskg?=
 =?us-ascii?Q?eUw9RbdkIIHsuzbKamYtcuNAYw9JXYhRyro3s/0BobVUWws/og/mA5gMv2ft?=
 =?us-ascii?Q?9gEUUiBqsyotSi59HKAVZY+pAFoOI6eHIGi0wqvQEI2eSfaUAQPl2JHXutIR?=
 =?us-ascii?Q?tk+kb1m4DCILBBBzyThTLzDl5tg1DykvjDAK3Qnh7UjQSOh9hRaQ9fzlnwjb?=
 =?us-ascii?Q?Py1IxBhnXpSmopKBxqL2ypY8v0Xfus9YRfNMylNn7Pkdgc2g6OTwlf66wBnT?=
 =?us-ascii?Q?cnZsM7OFe1uzNPU1HQuA+1aem8dg0X4=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b57b99-819a-47f9-9202-08de9f7b4ac1
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:55:01.8866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnzrpJMr6RcWsgSDnFMiWzw2dcW+S9tg3gh9hKMQtYkd4nhjYzJ6nF8mS++3jPZZGRYGN2iKXOjGs23uiUfNdmLL5RODx+o9AUbm4LkMijw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5995
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

Reviewed-by: Simon Glass <sjg@chromium.org>
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

