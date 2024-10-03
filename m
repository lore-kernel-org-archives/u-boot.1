Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B96CF34C9
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 21:28:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BF7188D47;
	Thu,  3 Oct 2024 23:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="hcWw5odW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E81888D8F; Thu,  3 Oct 2024 23:28:17 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CF9088B2D
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4D0DN051ImCUPe05UDHqHicEV3NygY5k9HUNVgbvT8wVbe8JtpnwyfCFaNVM/yiUvY82CHO9BRaX3oEFiyT9lb/XW8StCJbLwZ3zF1xg2+MmJxocF0vxDGe3+KW9ivPajd1py+pW/ATmMuKXBiI3uC/P66zslYmz4xKLkPizK+HPcJyAXl1KkFj5YJsdW2KoReVbnHEZBi7C4uEfz6ba1+Q53wsNzVAs+ARlqFftmLaCFI8+JS4xZSUwHA48qwFuArlxWJVLUCzxHRQ+6gf/HA25otnv9Atzc0oBBGOBMF0LlrXytZqocbYJwDqSW4FQWc58M/5ZgLmfZlLuKlLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVZVOhuOTlDpm3QwjiSCpmTK23isKmqk3ualVy5lEdM=;
 b=iwin/jvh1vw2VGV4Y9nhoQNeUqAoxS5uIOPAFe19HHzVuPhWGAhBfgGA+Aa1qbz6QAuCxtztlTf6v938vZa56xpQUvOjNlIG5lwDzhd1ZZboy+vRkEQkiEk4DCqpYs8thmWPPCadVvq2M31G0erlDd+gDGqFFZRvLZa3ZXr6tqnJR77mBaXjiBiBBSDDVc8xprI/9asiH+iYTiLkE/rA34xJ1fZY15x9F+8sq+ACJPMHEnXxTHVsKr7keekAELsaDAYggHSeXkItlW505K9DCEx43pDdARMWfcCZUrGZRWJRZTifzRjeMLSNU/esR0c2ciudiLb5DwjzqgZtyCS+JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVZVOhuOTlDpm3QwjiSCpmTK23isKmqk3ualVy5lEdM=;
 b=hcWw5odW5i6v2AQKJmNhVyvkg4ctG6fjbXIL4R5vDqaRrnwYbMGBnAlh/vP2SKrY1Wd+Bm48U1pZZUlpmIC/rJwg09lNCevSWQsIE156+eb90t0lAC9XBbQ8QOC0/xazpdoNOPzuUn3nsQdZm7VSjO2kQnTOw7g21PslMGjJUGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB9PR10MB8118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Thu, 3 Oct
 2024 21:28:13 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.007; Thu, 3 Oct 2024
 21:28:13 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 02/13] cyclic: introduce u-boot/schedule.h
Date: Thu,  3 Oct 2024 23:27:51 +0200
Message-ID: <20241003212802.3810-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003212802.3810-1-ravi@prevas.dk>
References: <20241003212802.3810-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0007.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::22) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB9PR10MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: bd60eedb-7e03-41e1-efc6-08dce3f24948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+G+lJVZrx1kd5/VhgW9VOUamkpjOe6bc4B9J5iBDIhvdsnW6ZXcyOG3t1kls?=
 =?us-ascii?Q?2lLe6YdLdKXztagZ9UH72C9nPR8CNmu+Fh71nqdDj1RmvAIOUebuAGx5fV24?=
 =?us-ascii?Q?sJPlQo3jlDwH34DQjtny6si24cqSt8Wbi86vUn+hphzNxTT5+neAPRzlwefY?=
 =?us-ascii?Q?X/x0Nf5+9t5iYmELhqqAZyrXOpQ30NdvQJmP9UQCVCSxhmuStRGcSDMFpXrw?=
 =?us-ascii?Q?1fpsfHttV9xPDS5SSpS+0MLfuN/02ciRDIv4pDXh37elciNUcie3r+DOIAW0?=
 =?us-ascii?Q?7dmODzFWu4AxUBdzUe5BRuNum5qSJGgq3TCkZTaD14YT7igyfWTWpjfEAMJY?=
 =?us-ascii?Q?lZoBlPouR/FtMP6FGvIwy50mDgVLfGKxPR8msHTlHGADJdImJmgvN8N4yehu?=
 =?us-ascii?Q?iY7/Yd9z8NWU8m6Zh7WarhY+NG5Q2gJI+jTbXYQWYUjd7OkyF1jgPwrNYpR3?=
 =?us-ascii?Q?PXaK36DfQuZEMo2LSiAI0Ic3fdftnO5/vwphrh3XRfI4HUOifB1dEPva/lb1?=
 =?us-ascii?Q?xctvHt5Uz8xL7F2fpg2bjzrLB+VRPulKpdbLJaHtfLqHLPuQEpfJWniPZu7y?=
 =?us-ascii?Q?d4W9K83Go4Q8yzX8Jsrmqtk1gSXCKQtXC9lCGp+ilnSyVvh4azf/rm8aQrn1?=
 =?us-ascii?Q?5vLXwfIoxK70Qp9UEJaFNI+Shp6VoQZQy1XN0cDZWa223xB7NVoHtSIHc/+R?=
 =?us-ascii?Q?tPSp2bv6OvUnBv28abKGMENa/tf5efs6NsRIp5J3P0UTXVX9Ps3phRpWRuL4?=
 =?us-ascii?Q?ypHq4vcPRnzlUnpazE+bYh+9bHw1dYOln2742pMawkZnGt5EvmNk2x+8OC5K?=
 =?us-ascii?Q?eEFkZkQJqqg+YE0Uq6VhcxdfyBxIdj4W0lbJee3IjOj325Lm+HqyADqzuyp0?=
 =?us-ascii?Q?H78TILJViYAzdjaZeK0JQ9E7GZNB5HxP8DwIxr+kIKyIkpveG8KVQkYIgpt1?=
 =?us-ascii?Q?hVW7yaX5H6Ik39HXkIpqsfkpGWW2pU70NPuZDv80R32G+hArn5bwlGOnGMYH?=
 =?us-ascii?Q?4+lupsc0Wj/CxMKamkCbThp5AYMcgRZalE0zjLF705QZ34lBspjHNN/Pp/mV?=
 =?us-ascii?Q?VirCNW9z0pzY82G0g/27v0obX4x/tCJVV8xuv6G0TGlwJUym1Uaq1fEGXk5q?=
 =?us-ascii?Q?qZV6d2Y4W/IxR6wNnwJ5bB2aM5vot6WwJhSpGY5LebMMwquZ8uE9fA3k/WLY?=
 =?us-ascii?Q?tqW+08lNMAYFFRvJhFsVo4KR/+12nTWp2q5bkhAfNM7axlY9ZnqEya+CorUs?=
 =?us-ascii?Q?yUDuNtMcoGYC6ATLKCLZ6ziwRt40PHQVugRh/jHkvE0Irod6Uwmkf+ViKl4X?=
 =?us-ascii?Q?SL2ugmEgqD0ggD55bRRCaWgbrCFRpZU9SYDDQfMENjIcXg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9sQfsC+av/ilLXwfbPVoY2DBG8JuHZUfZA4TgsYaqhUgRNcpRQ09xQTk2eh9?=
 =?us-ascii?Q?QFzkinGvkmRhGPHLX37EfBZE+kk3DwUEGrPaqrgi3IaGPCaav08yoOTJ4tl4?=
 =?us-ascii?Q?cWkLRpY1BoFgQohR579PcuCwiiu06vKRwnCBGDrhlqwxbwqJ0zTk8wbP/HI0?=
 =?us-ascii?Q?wnSv8Wg4NIPbCPo+a6iVYAyXSWON0zo7VO+fqU0x0YswJn+n5pv0MFOp+d8T?=
 =?us-ascii?Q?j5zzSx5Wa/iYr+/3JqOFgIB4NhgYLaoGLL0VRCHwkftRJwvBWhpLDe9dZ4NL?=
 =?us-ascii?Q?N/kqib18DT0Eo/TOyeKQn+n2QiV/PKrPqE2/7TyF5WzNw2nAYsmXkekz8w6D?=
 =?us-ascii?Q?U1wHbG/GS16bWxoYXyEb4KyAfWEL1syHrdtYK8gonuRqv5Ei2leapvBxY0dK?=
 =?us-ascii?Q?b3yhYH94O+IQRv+RYNorKOLbRWOOXbA5VqBK1+r5N62+6xp9+1y0aab0TFWR?=
 =?us-ascii?Q?QkmNpCmOuXTYxznBAdmC2iabSICnxKpmaOrIJi2pw8aikyf0vCPQpxAm/e7q?=
 =?us-ascii?Q?qdiOuYWHWtsaqg79eW+ui0aRIjKFfKCa6I9H5oJ6wL+DC9g2NFwszGnu3zrf?=
 =?us-ascii?Q?B8UhiONFG6OjcrpMHMW37gZdLUN2IUdx/ZBnntEegaCa2ONh5vmxaevZXhBk?=
 =?us-ascii?Q?e7P7yjAPeThGfhGyeDxVsr4OtaoSKb1SD33H7hEU8U1BqQ2Tg+Pkf2QrGCEW?=
 =?us-ascii?Q?qw8MZLq8fiXuXNWGt+7+Hcb9tTOWCRmvL5ZebVcI0HR6BgUKWIjFwv1R0L30?=
 =?us-ascii?Q?Acs4J4ZEpCBlfzxAgvvq5r+HU0G/mMpGdDkqQ9rQec851xv4TPwZrQdtyEbw?=
 =?us-ascii?Q?7jXlr/jFefx8scAWOTX53+y4hkKetUXMC224bwvc+A6p1NldxuJ4O6cp7qL6?=
 =?us-ascii?Q?TSa1cPT/lmNPY1ObKJ6daZaKmOYG64Ue2wgCXztFJBLSFPXpkNwHd2cL/+Q7?=
 =?us-ascii?Q?ZjasCzvhtDQghXfc0mSN5ojiRRRxhrdpNwiEid3H1vaoWe15ZkWbAZk8DGR9?=
 =?us-ascii?Q?ZBmZWKUcwgJCWorLCPK45xYZBAHbIY4SSSO6OrzgNLSCHDiAARJr0Jf4mJ84?=
 =?us-ascii?Q?CCd130PaCi4BY81P0TaNbpagqC9PCQox2IrnfVMad/qnPIh0XfpTum8d7f/J?=
 =?us-ascii?Q?xD9T5b16dnOSfJNssqWGVgVWbTIy5iZ1EzPl5pNMb5VpCB5XSWO9ADp1SRHW?=
 =?us-ascii?Q?YIsoxqkMLSqEQ9iueR7H08iCoYwtH9geqADrWvjeRuh1ibKDh/Co8XW3RnIU?=
 =?us-ascii?Q?2j9EdDGXa1vw+3nhYJAjWR72hqvuoehk5UuEG6kUFw/Z0zaPoN/whQqfMp9S?=
 =?us-ascii?Q?l4IP1yze7gOdeJ8Vpz6klNXNxb5OciJqHNsN6gSCFIc8mhoRfpp0rhT6EQve?=
 =?us-ascii?Q?1JPvDuKsoH9ZTax3uih0W1iREV5Qozi+y1iRGxkSZkbYuZayHFTC/MrDW+0U?=
 =?us-ascii?Q?9VZ2e5AyWbvQe9c6XtojJKPUmr8FM4RMlCCGWkt9uuuNAUAAzX5Ra7fQYYCR?=
 =?us-ascii?Q?XNhmyKxzbrdBX8UmUbBoJSyA66IZZ9PThoqNalQicgQtLuxHVTEU4rbLjUHH?=
 =?us-ascii?Q?XTgWScREo7JZGHd5QZKvF7cjeKGAaBDaxM5FtNhO9tRJTGZKiZBAFlYEXDg7?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: bd60eedb-7e03-41e1-efc6-08dce3f24948
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 21:28:13.1766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qieM6AqLx3cwKQPXsJqQHQOHo/A9VuLiZgChNkN6DYz9OSGJu3isGNLvYQP+16hXUIdj2gzVWvfvSwMRrxd9xL+lBzpcGFsY3GjvOxwxz2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8118
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

I noticed an "unnecessary" include of <cyclic.h> in
global_data.h, in the sense that nothing in cyclic.h is needed in
order to define 'struct global_data'.

Well, it's not unnecessary, as it implicitly ensures that everybody
gets a declaration of schedule(), and schedule() is (obviously) called
all over the tree. Almost none of those places directly include
<cyclic.h>, but for historical reasons, many do include
<watchdog.h> (most schedule() instances are replacements of
WATCHDOG_RESET()).

However, very few TUs actually need the declarations of the
cyclic_register() and struct cyclic_info, and they also don't really
need anything from the watchdog.h header.

So introduce a new header which just contains a declaration of
schedule(), which can then be included from all the places that do
call schedule(). I removed the direct reference to cyclic_run(),
because we shouldn't have two public functions for doing roughly the
same without being very explicit about when one should call one or the
other.

Testing of later patches that explicitly include <schedule.h> when
schedule() is used revealed a problem with host tool build on win32,
which apparently picked up a host <schedule.h>. To avoid that problem,
put the new header in include/u-boot/ and hence make the include
statements say <u-boot/schedule.h>.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 common/cyclic.c           |  1 +
 include/cyclic.h          | 12 +-----------
 include/u-boot/schedule.h | 24 ++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 11 deletions(-)
 create mode 100644 include/u-boot/schedule.h

diff --git a/common/cyclic.c b/common/cyclic.c
index ec38fad6775..38d815bec35 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 #include <linux/list.h>
 #include <asm/global_data.h>
+#include <u-boot/schedule.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/include/cyclic.h b/include/cyclic.h
index cd95b691d48..e8de616dcd5 100644
--- a/include/cyclic.h
+++ b/include/cyclic.h
@@ -13,6 +13,7 @@
 
 #include <linux/list.h>
 #include <asm/types.h>
+#include <u-boot/schedule.h> // to be removed later
 
 /**
  * struct cyclic_info - Information about cyclic execution function
@@ -94,13 +95,6 @@ struct hlist_head *cyclic_get_list(void);
  */
 void cyclic_run(void);
 
-/**
- * schedule() - Schedule all potentially waiting tasks
- *
- * Basically a wrapper for cyclic_run(), pontentially enhanced by some
- * other parts, that need to get handled periodically.
- */
-void schedule(void);
 #else
 
 static inline void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
@@ -116,10 +110,6 @@ static inline void cyclic_run(void)
 {
 }
 
-static inline void schedule(void)
-{
-}
-
 static inline int cyclic_unregister_all(void)
 {
 	return 0;
diff --git a/include/u-boot/schedule.h b/include/u-boot/schedule.h
new file mode 100644
index 00000000000..4fd34c41229
--- /dev/null
+++ b/include/u-boot/schedule.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _U_BOOT_SCHEDULE_H
+#define _U_BOOT_SCHEDULE_H
+
+#if CONFIG_IS_ENABLED(CYCLIC)
+/**
+ * schedule() - Schedule all potentially waiting tasks
+ *
+ * Run all pending tasks registered via the cyclic framework, and
+ * potentially perform other actions that need to be done
+ * periodically.
+ */
+void schedule(void);
+
+#else
+
+static inline void schedule(void)
+{
+}
+
+#endif
+
+#endif
-- 
2.46.2

