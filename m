Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEED0D3B7E5
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 11:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03853839A8;
	Sun, 28 Dec 2025 12:04:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="Bx4molOJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24FEF839D5; Sun, 28 Dec 2025 12:04:24 +0100 (CET)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d405::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D929F83956
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 12:04:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwjDgIst5UyZKfyf5Ub9M0zM6YyzJOXoeOLeRZC2k4SuloH8ig+qrAtpoVQ5ec7gYfMa3l7QI3+BEA3zG4hEN9xU3iA8TCirFvxCX1GZSp/B7v3WnzVxp9K0vkJnTHHog8odEMztGHQmpZpVNWedCX/Pck+aWMMAGM7YxHYVQSqHjOMRNcj4W6OnYPNGtqyURDoYNuCJEHFVPSFAU58SeRRy3rzE4V9buiaVFy8KaTLRMiqVV229+SFGRKQETmZtyNF/V+waNXJA4hANAa5B8IpnfhbRKBcN83M3fCnU4ZuezJnK99gg+HvOIaE8YYpFMXhao63XULm1m5MvuS/o/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZVVh37m8MhT43mncJXVwbPDprLgYSO2iFZJzCEFVK0=;
 b=AuU+jS9KL3uXWoSLbi+YxKqeID6Rc5gPW6ZBBQHVH4205cGed2JRaiv0a/4Sn7dYGPyj2EL7VOyn/Z1LemgqQ/KvROwmorLFB81K93pNFLM4kUqU8knXYZfZsmSfcGk9SxcuvVlp11+tg4aGnmInWc1wHEbTOogk24MqzNmDX8EuK4iUrnUHuqvlQP0Jn5KQYOrnP5mWLXyaHd6KlD1iKzxdC3WG0/Vw7dw0HT/QXU5Idg+BKNYQjUk42d6H55QpZiONzjz0bixvHlZYYT/R7E600m7K6Xc51fKiqBIFMloJnG92s0oKqbMYMChfT85uvyzmFzq+mcMOvV/twdWEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZVVh37m8MhT43mncJXVwbPDprLgYSO2iFZJzCEFVK0=;
 b=Bx4molOJBhXbi3Bw7J4ZDgSpQ6i4RRxT7CPd8P4l7l+Ep/jRWpEcA6vCnDtJZYtOXtrKfSLaRHtl1kdRNqnjCZzULG8horcgFHszDMpybG6z0ZRVRQrrnLQMuHJWikc3jQGUf+eB19/AV8k6HCADdAI+LQR/5/D29FKnM/vJmhqx6NQg5Ug3p+B2jfLV1ouH0lCFQg+bM+ebxKaPq77iGF3afRzKjhfTtA2+996R77xBU+mDtt05kd80F7cpUh0NflNubAV8oa2dBoEQlwWhHc7NaSf8Kgy9Yd0Jg5/XjqiC6yEfOOgcW9CcI6dXwPsrDGo6wuWWHtWxPClZ+2WWGg==
Received: from OS7PR01MB13834.jpnprd01.prod.outlook.com
 (2603:1096:604:36a::14) by TY4PR01MB17359.jpnprd01.prod.outlook.com
 (2603:1096:405:358::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 28 Dec
 2025 11:04:17 +0000
Received: from OS7PR01MB13834.jpnprd01.prod.outlook.com
 ([fe80::6e58:e4b5:3405:28d6]) by OS7PR01MB13834.jpnprd01.prod.outlook.com
 ([fe80::6e58:e4b5:3405:28d6%4]) with mapi id 15.20.9478.004; Sun, 28 Dec 2025
 11:04:17 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Anton Moryakov <ant.v.moryakov@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH v2] common: cli_hush: terminate all commands when Ctrl-C is
 pressed
Date: Sun, 28 Dec 2025 19:03:49 +0800
Message-ID: <OS7PR01MB138347050E7E700D57ECA698EBCBEA@OS7PR01MB13834.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To OS7PR01MB13834.jpnprd01.prod.outlook.com
 (2603:1096:604:36a::14)
X-Microsoft-Original-Message-ID: <20251228110350.28007-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS7PR01MB13834:EE_|TY4PR01MB17359:EE_
X-MS-Office365-Filtering-Correlation-Id: 71cce6a0-1aa8-4747-3ab7-08de4600d7fd
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5062599005|19110799012|51005399006|41001999006|23021999003|10092599007|461199028|8060799015|15080799012|5072599009|12121999013|40105399003|440099028|3412199025|12091999003|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k8NlUxZ41pXqMQ7QBcFkkTq9x20XQ3hXTIluHl0TcNdgWqP01e9vnr8zb4ko?=
 =?us-ascii?Q?Ou19ZNF/QP29UFFaoOnu23f7aYhv4GIFwVLBtRf2xzwjM3A3QoxO01P36b9z?=
 =?us-ascii?Q?PM93uTyrcriPFt+Y4PGgPM9hn3p9q70vvYIfGsYb1YbGL8kT4/pIoqYzTTR/?=
 =?us-ascii?Q?FA+QisicaO8+TVN+ZM/VFp+FcO3lNfXRu6hW0Baz3bccJgOzMo8VqjE6lZGm?=
 =?us-ascii?Q?4B2FV0oKRlB7zi19zjUJDRDYTwGR7swXnyweKfgF9WbBxB5Lq+vA+HOeb7Kv?=
 =?us-ascii?Q?uHiOWRkMRkFB3BegOYX/cOx5GzxvhySfSGZzd5MilsK4gmWK6kc+hHc2EVjW?=
 =?us-ascii?Q?fGlFxtHMd7+CYqCAyB32MmFcKbyLtbI1JX+WXL/XwQ6gxRxNMP4p6oO+cvMC?=
 =?us-ascii?Q?9PPCHpdIUa+7fiL4l/BgIO+8YbYjF1z5UQAlpJtlJrmxyMlvOTlGC9rcGQRR?=
 =?us-ascii?Q?ZbnLI3N2WTLYePXYj1H4VLdABLAI1cWHMTQty/7rvR6voBKTmYGD6ALgj53c?=
 =?us-ascii?Q?QYGaHuSZLK04r0ucS4NF4HYNtwqEz49LGhYdEbDuYzM3E7LiPPmSGe8sbg54?=
 =?us-ascii?Q?E7F5YLB06ZEQptMbOpHeBlRZn/TS7qAeHL22ZDG3O9lbiIyg7wgppwFl+ms4?=
 =?us-ascii?Q?KJqKn0RwaqNnzx4+uwZ7iU2y+iueCq8eheoWYfMQY11tgXRe+66CYrzjJWxi?=
 =?us-ascii?Q?HiojOf2Is8FmguGdo5IVC1gAFoqOZUaTgoUTGXy5sX0Q2YyX2l3GpcLT8ehJ?=
 =?us-ascii?Q?XqCMxavDCxAnrzjCiqtfByMx7htHoGcH7nNGuZ+GVMDc4f7WGUKmZRXW87kv?=
 =?us-ascii?Q?THzcV62y2raVLJgRpCwgUcOUvHidyZzqxC74X6ugM3Y0EgAYfO2UW4FynXwB?=
 =?us-ascii?Q?pKbzUXYpM+OKNffN86tV2TM06I0y0+o9SJ0BjTdVF5+bgSZtHcXTOqyQzU8v?=
 =?us-ascii?Q?nxunwepeQ3Y3FwYQF+PcjGrejd6uk4Up5vdd/EeKSnjnr7gXs2WVkovkn7Yj?=
 =?us-ascii?Q?SBcRfz39KHdRTdxuK8/NAxO8mufqi/Ntx+cP44WoAqD78S3KCfWykBzBAden?=
 =?us-ascii?Q?ah4xGYNbpX2g+VV2xV0Ik+LNv8YxufY4S9q5kpZC4nYsa5r1CvjMmK6blC+q?=
 =?us-ascii?Q?7dkzKgpLlHkbKZKYGv+JUO6nJZK9JlfJP3g+9JwnTaERt+p/u9aUjrsPZ/1W?=
 =?us-ascii?Q?uH7BFvD5ia3Kk5M9Ql28i0bt2mQwKxNmkR26RIAdqwLbMylwg4jjUOsGUtJX?=
 =?us-ascii?Q?6bfyAB0/cYfYk51oklzIee9tAHsKNwwUpSRNjuUoYtOUni0YVqWT10GVCMkT?=
 =?us-ascii?Q?5vaODnR0PhcQ1JKbfBNYoyTF9+z1/qKYOsfncWqSSav0adLJB1fisMHq6w94?=
 =?us-ascii?Q?T4sXmHo=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OqvwTJCS3vXEi1EoSQLMXqiwdN9Iv++UVUhfB1310C+12lunP+cOTBT20BYP?=
 =?us-ascii?Q?LB3+f8e7KcqP9FO3lqoVMyEEr2WSoSKJGVd0PtUA4TFQ+IwyCYJoIsH6u2JR?=
 =?us-ascii?Q?rNFDBgKjE8tqOgK9nEGaN2B5Qcca58/i2sJhRywDp+dK54pwTqGWwyRlUieN?=
 =?us-ascii?Q?6PIuG410ZYGPyYb5TRBSKtAv3G33vuup7aBlxlCsOPYKPTtFcknrBPO6RPou?=
 =?us-ascii?Q?vH+NWi+Ekr+tKgWxBSkpcMLJAUzfqXmfA3S06cHgLLW4TZXSlrq79WnxNruJ?=
 =?us-ascii?Q?Ue2dwRAzIXOeFUN3/ewASB1TWtfQ1vMcfxhcbhNXQ7bhlkjqHcbDfF8OF7Fe?=
 =?us-ascii?Q?3F3gsJa5kUJ4gBlOMPjCnYGlD2sXTknPaa4kNZbnUwrI7BCQT3bKjl+kt1uv?=
 =?us-ascii?Q?VF9T7l92XwFdmLfW5JjUd5ZWpDdBlP/DTCs/XFb0T7I0f99eP+ewD428LBta?=
 =?us-ascii?Q?iFRP+efcNZKldLLKG8fnH9u7V15exm0tGGIpuPNTi4bafuhDQnAwRKjVmk6W?=
 =?us-ascii?Q?WsZrRBiX3m7P83+FoEZoohs5tJxK+vbrjN5CTa43rf32l3JgR2baImErv72f?=
 =?us-ascii?Q?yOZKOfSklkcCkTxef3T14IrwPU2TgJFA31CUtT2mILCWGxharpORUaPwAMH2?=
 =?us-ascii?Q?Fem9SpVAi5eFrP9NQatqTsfGX0II/JWduFl2Y608lbbx3q1b1fEpeCnY4lwS?=
 =?us-ascii?Q?LCiyDS4cspPD8PQtUvJcny4rsuCMMh4dKWVcJmpj58IyuSJXv3EeHdEGK7EL?=
 =?us-ascii?Q?CPxNEHg5AdBB/X8gRtmpbJv9oyBn7ZQvljI1XKXV/C8Xetiqz+ZMCE9Dbv8K?=
 =?us-ascii?Q?pqUeE+yYIyi8SbQqIdgwQYSeSxK7uTmBarRT15U8qc1iU5DcoVBlbWJzMGOW?=
 =?us-ascii?Q?BMGR0438acFkNj4OH8lWdKHTWUMW7t8Mp18rmRZDZQywanxEKTxdpalDgjyS?=
 =?us-ascii?Q?WLoz2V7IvSlu0+v2ia3cxBYtsqECKnn5jY0IetEBB9eUoqwF5NF4aNghvpto?=
 =?us-ascii?Q?yyJuPULxaNDhKLYt5UxkRknLjHnxT8xfLPx0XqwKd/imyhIK6m/KCr6eiW23?=
 =?us-ascii?Q?8yADnpzrHg5gObWp9l+I1Hrk1urBU5oevqDqBzlBfzQPmcvVi5ILFaBPZdoE?=
 =?us-ascii?Q?thaaId0OKOXFubhcbFU/tcRdCilX45t7p43hPymU1OYzgXSz9iczu9xhd+vw?=
 =?us-ascii?Q?AyOwF8qloyZ9YEGo4REZmY+b0sNs8NldDM+iNHFjkNfPqMQdcMqNuM6ZdMGi?=
 =?us-ascii?Q?gUOyBN9qVwRHuml0PXjm1lLCvFoQZpoxNcknGiPGw8lW6OZdUB2/gHoZV/Oc?=
 =?us-ascii?Q?2mf2+eSaqyysIQvLDkA4uPDQ5/LluWRz2vsW1zGTkUtP5mEAP5tJZxw7DJ1U?=
 =?us-ascii?Q?xZhckJAF2yb9abHLetrAIfDC9+jE?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71cce6a0-1aa8-4747-3ab7-08de4600d7fd
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13834.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2025 11:04:17.4943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17359
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

Check Ctrl-C status before executing each command in the pipeline so
that the Ctrl-C can skip all subsequent commands. in the meantime, we
need to clear the ctrlc status at the end of a pipeline. This should
be the default behavior of most shell parsers.

Before the change:
```
=> echo start; while true; do echo loop; sleep 1; done; echo int; if true; then echo if; fi; echo stop
start
loop
loop	<-- Input Ctrl-C
int
if
stop
=>
```
After the change:
```
=> echo start; while true; do echo loop; sleep 1; done; echo int; if true; then echo if; fi; echo stop
start
loop
loop	<-- Input Ctrl-C
^C
=>
```

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
v1 --> v2:
 - use puts() instead of printf()
 - only clear Ctrl-C status when one pipe reaches the end

 common/cli_hush.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/common/cli_hush.c b/common/cli_hush.c
index 7bd6943d3ed..3f6adc01934 100644
--- a/common/cli_hush.c
+++ b/common/cli_hush.c
@@ -1792,16 +1792,15 @@ static int run_list_real(struct pipe *pi)
 		}
 	}
 	for (; pi; pi = (flag_restore != 0) ? rpipe : pi->next) {
-		if (pi->r_mode == RES_WHILE || pi->r_mode == RES_UNTIL ||
-			pi->r_mode == RES_FOR) {
 #ifdef __U_BOOT__
-				/* check Ctrl-C */
-				ctrlc();
-				if ((had_ctrlc())) {
-					return 1;
-				}
+		/* check Ctrl-C */
+		ctrlc();
+		if (had_ctrlc())
+			return 1;
 #endif
-				flag_restore = 0;
+		if (pi->r_mode == RES_WHILE || pi->r_mode == RES_UNTIL ||
+		    pi->r_mode == RES_FOR) {
+			flag_restore = 0;
 				if (!rpipe) {
 					flag_rep = 0;
 					rpipe = pi;
@@ -3207,6 +3206,11 @@ static int parse_stream_outer(struct in_str *inp, int flag)
 			run_list(ctx.list_head);
 #else
 			code = run_list(ctx.list_head);
+			/* clear Ctrl-C status when one pipe reaches the end */
+			if (had_ctrlc() && !(flag & FLAG_REPARSING)) {
+				puts("^C\n");
+				clear_ctrlc();
+			}
 			if (code == -2) {	/* exit */
 				b_free(&temp);
 				code = 0;
-- 
2.51.0

