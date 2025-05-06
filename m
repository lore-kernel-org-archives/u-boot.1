Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24ACC3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 032B782A55;
	Tue,  6 May 2025 16:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="NIdBi9dF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AF00800C1; Tue,  6 May 2025 16:15:20 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::613])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 829EF829C7
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbkfVVtUY0ng7ugjc07hbBCBTa1VKEbecP4cFzmfn6o4tIw3pBLV4Ja/B5Y8EP/hGT+xFJqx4cAa3kXpUfTTE6g+7C85CIWUVVLR/8vaCuW3HHHO09r/VuXwyoIk3CjHgy7OaKdijlVGp43rGGN2SqEzysmC91lxpg/Tpj6zw6apUeXIYE40Efwp5Hrxc5MnNv9tNWOjPZeJVelXdgu6+4xdoYBkV0ZJnOp5jr1gWZDnaOV0zdN0gFZTsPvfxTVmh/EYBJmJT6qUxDJzuDB0vIHhyWFxYT1KmJFrXqdCoiBzGPxW2oekmwlcIAB/nlKcHl4H0ba+mXam7Dl8CbA9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jb5x2KeZ4SVR7LuEvO7LLpJ9qWHuqW4UcRO+aFew9eE=;
 b=JKHePSp/aD9POCSLDQREVjfQmtog7yPRqvwzkZDB+cEVrH7JK4+82VQSl3jbMF6Xuo+47gfmC+F3hNTRabkUY1v0f55rO/0CPZDQaSrjXipFFZVSdDeFZdB0Z1uSZCm7dFK1b8OJMJoN4OdFm6YQySXg7AjbT1+fprzpNRDj6Kx0dUu5y4X7vBywbd6xSgQObRFYa7qiWcqhkezLyY/3ncJ3dNEOousX8jzVWuruTp8oRfp7vSBGUWOuyf0colOz2Z7H66mBJNaYaUohZ+sqDMm0qPgQInKcqUZhP20g/szNct0XB+qqH+k6b5FxFfoyNFJ6wKnLSqPlU0Tg5scNJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb5x2KeZ4SVR7LuEvO7LLpJ9qWHuqW4UcRO+aFew9eE=;
 b=NIdBi9dFeDAyVao4G1j+My1HG9WAMzahILPBsqntMjRP7ZYjhASQ/BFDXE+WqX/m/QQJ6huG/VAClqwI4WwSnIfz/ZOyq+lMBBPLYkR8jeKV9DbZQjJYuOCuXpMw37e7ixH3j34c6dFfQ9y8vZh2XndHujS7bS7YM0lUmXeK+Ek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ca::21)
 by DU0PR10MB7237.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 14:15:13 +0000
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769]) by DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769%4]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 14:15:13 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 01/11] cmd: test: add support for =~ operator
Date: Tue,  6 May 2025 16:10:25 +0200
Message-ID: <20250506141035.385756-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506141035.385756-1-ravi@prevas.dk>
References: <20250506141035.385756-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0119.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::15) To DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8248:EE_|DU0PR10MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: b26b8466-4701-49a0-6eed-08dd8ca86b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c5hDfCSissFiKOLYZ9ohR2zM3Usl0VaG/fGOwtYp6zwSSe3aZsbLiemsTz48?=
 =?us-ascii?Q?dPJZWawtCSWd22rhKfzE1YlYIKXwig9EIcKCOop8994C6Bv0zp5afq18HPwO?=
 =?us-ascii?Q?Os8MxKb1NSodqWFhUPfq1HrU1kY6mZZaRtQIWF0Vc79PzLP6ReyrKnZq1LQb?=
 =?us-ascii?Q?Vl4CYakMhFdONuMk480POSzlqZcheFXhyMxyAGFOm7xccMXsfx1NFD9lpCM1?=
 =?us-ascii?Q?ClDAuAdAE/Mziz9fF88Vu1L28hCZFs2BZ3bez9EMM81zI+VBcwkn/MdocZTM?=
 =?us-ascii?Q?Vn5C/bbuigSJUYTSedMmAETJUvF6Q62og01eaIaZaWi32ZRwmSSJZ/7xb68K?=
 =?us-ascii?Q?jdzeXwv7MQ1xA6fjBromNe1SgdPIMwHPtgwNu3DhikiB4WYl3Hk6krZe0AuC?=
 =?us-ascii?Q?xs2s74/dwmqjOyuA2XhSiR95cUD1dft5l/EMPTovhsn5jZY73NgqtVtGNOl8?=
 =?us-ascii?Q?qnF9tnD5zw51fBkEkJ3erpLWAJRhlojBYmpGOziA+AtjYRRDB37YmVXmtAAF?=
 =?us-ascii?Q?k0RjrB+DsWDuXwWp2Jp8HAIHixYeKUgWnpqrxTjKzm2g4VEP2307pM552vZ+?=
 =?us-ascii?Q?5g33wLb61m3U6dZefxSdMIuNndtJexstjSBVQMqiQ9SevvPIxUnNMVOhXYiR?=
 =?us-ascii?Q?UVzyEjRY9QXHU+SRX+OFa9wjC9CQo+0k0JG1ci7/vy9rCxI1O8q3LmjxPZrI?=
 =?us-ascii?Q?1PfIJY4EGBESCNVYEzbZ1BTpU+853BQoqWlmneIe3NAusjkDIlWruSQOLO6Q?=
 =?us-ascii?Q?u+GmtZjmTi+WggzD9XeXXxWMOYVivCRF3gynbrOGTBFXSF1nt1Pg9B8w7wpW?=
 =?us-ascii?Q?lrw00NAhPPiJjBwz618yrYRRX2VtDOiCm8GJiL4DSS7D/9X9ZggXiRtbm5qK?=
 =?us-ascii?Q?zPvqGgBZlTOISuF9thzVjyOisIxp0Gza6NN4qR+N0GWQaJZ570ooiBn+634i?=
 =?us-ascii?Q?aWdkiCt0R77svjqAj97JDNLHXAgUoiM5iaY3vDerwb2ESn7XyCx0BTvqQ+nh?=
 =?us-ascii?Q?GK3VoVRKjctPbljMvtghCq9XGDKxk1thQBjGd+9OyNHg16f0Ex7Qf721kr5j?=
 =?us-ascii?Q?hDP2n+4k3Ghypw+aNI+Wh5nhwi90tAR6DXjAseq+qpOeC1ScPNkdUrpKZPEu?=
 =?us-ascii?Q?p8ZjnWH8AEIgXNG1vuW4y9dtt5VHQYCVysnIPsvLqcr3YIigo16XDLlf2sfB?=
 =?us-ascii?Q?wc9nw1NTzhvdR2y653gaSu0b8DB1fCIn440Yy2eDMwmZxd/AL9qcMZsiHSmW?=
 =?us-ascii?Q?1tVGdGZ11dIcO3/g3/8drL3bPNFfCeIVdokgBzCoYakHv7q0ykMwf3M8PQmq?=
 =?us-ascii?Q?D+nppTG5aSxSOTqSsbeGxMGmizQkpeTguqkuk2U5DEfqbF/MIwS3HI8B8xlA?=
 =?us-ascii?Q?59s17v8hNtusdcmTR4taSnZEp7CMhcwqR4GPhcYHIlb3/pUJf2AK6oM9tkYm?=
 =?us-ascii?Q?IHS9fcljNCey5xUGr/T+bHZrf6B62pzuQ5EWGmCK220E4t5CBoBbtw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?14buIUFXGO4ckxLnKUm0b28daSr2AYA/FqOPagAlYAOcHUj8A0NJzWENBIwS?=
 =?us-ascii?Q?v554PlDwFCwSynVveLyqfRcjIBy/xEqmdKJNQEsf2RDPtutPiXvIEzSZVUhR?=
 =?us-ascii?Q?BwuH/sF0EyJWhztnn55nUeFg/n0BFzPPiQzy/xlU3uNfRGlMUMVdvUtVmYig?=
 =?us-ascii?Q?l7XRVtSeWETwNknvtHOxhBupC47vH79NcxcO/dri5uNpTeKi8bZzn2me4lxK?=
 =?us-ascii?Q?W1+ZnhCqZ3S6+7T33Z7DMl+eNbKuClxE/P9IRSL6CnOh8BdYTLwtb+XP0Xt1?=
 =?us-ascii?Q?QkWc/TcFTk04NZm09WmytUFn0NZkGHtV0uYUB1V9oJBlPVVhpnaoR0TyQgIV?=
 =?us-ascii?Q?nsprUPYpWw26p6vH4rBQdQVWuB8QLIOCReIrLymuPz4RcSXnepFyBM3PqWdM?=
 =?us-ascii?Q?vVyE3HsT2+/XCqsOt57Gg2n/iaoRWN1X1N9DnzEYoyIqyxmc+X73Q3qfNpUp?=
 =?us-ascii?Q?wmtUOw7irPhr4vTjszbkqrmvf/6YFF1pEVPYbn3IgJ0vmI5CxiQqrDSL+qtz?=
 =?us-ascii?Q?g4FpOaTGyiWpx9L4iM1h/wy9g6/U0GmohD6t9XemvHQQ4cTDTdkNRQwoOD2+?=
 =?us-ascii?Q?KBxfc5m3AjIIAgyMsZst6p1ne5KvasdRb6+j2J4V/08qnhoyr/DgV0nymY2M?=
 =?us-ascii?Q?oWYaxNLQcwGbqBycvWjPHZe/0OAJ9b4G00fKfq4Npfav4lmKiuSDsRcSJI68?=
 =?us-ascii?Q?0OnFdr9KXOPeqtYtTfdl//NAKiBeAIyqnB1iqdExAlUtbJtY/PiBrV9/EZq8?=
 =?us-ascii?Q?XktBewq3GEU6QiwTGm8GAB9P/QQ1yEjDm7uX0vabs9OtiDii1j1aOgZ85Cnh?=
 =?us-ascii?Q?mjBFZnx0WmQlZ4J3qC6GjDw+GuBmfrdJFi5RlmBU/uFj+hRgnhR+PpuLqCyi?=
 =?us-ascii?Q?6SVLL8G80AaMq1Bte/A18D+z8ghR3tbdn28ogqK1doqgfI0QLf6a5XFZnP+v?=
 =?us-ascii?Q?pb9KzDLWnZByvaD70Pcz7b4m5dpFIFq8nUGyOUqzNlGcCJhmB2gpwaUXuIfz?=
 =?us-ascii?Q?aJRUWGO7w0zwdgeaOff0XajMAvHfOM/tZaBbAzfjQ3tJDQbfbKTE/2FOVUHR?=
 =?us-ascii?Q?7PAr/rnzMKv/izvF2lb8QaYlAuys7Fo+KCGgp4K3fiLBlLlXjnk/AGXb0s0L?=
 =?us-ascii?Q?n+aab1wDEvEGQfOvgVtV/eB27h1F9OgajhQ8HLI2H4J/SpTGLD2xx2uwpYSx?=
 =?us-ascii?Q?23TgLodqZrf8VfKGdk5s4R846dyLuwLhM8JZYsSv76s+5tkVXqYZaZotRqgx?=
 =?us-ascii?Q?rzvm1aDZv8ADs0eQmss59OY/B44clSwAsuyW9b6q4wG6LnycZifW+HbrpNm+?=
 =?us-ascii?Q?AphXoU1XXFx1c4AexeRpFsGRl9BrLLTMLZbuhlINvc5OQXeRdWYK2jGHFCUo?=
 =?us-ascii?Q?b29feeUxzBjm2p5yUC3kwY5V/N3lLyZoHMTMSrD8vYFk/AmjrKhtkC0p+ILP?=
 =?us-ascii?Q?PjLut6Q2UZpLbhWgqjIpK9dDiITdx5NLS6Jaicq4xm6TbMgs+tMLriTXbDJ+?=
 =?us-ascii?Q?NMrzScEy7Iptr2XVZPhBNT9tpAlJfpXzLoBXiG8URup7YSBll7hD1yS7h745?=
 =?us-ascii?Q?aMqW/2uw2P7WXZKfe3exK77eaP3cI4iXR0xFEV5NQdg4N2GqiyxoCqEFRTWN?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b26b8466-4701-49a0-6eed-08dd8ca86b2b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:15:13.8254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHY1u2d9tVsWYgW7uXg4aFkMFBcEw//FX0Dacy8Tn0VoUKNsOqVK14jXOvMWiMWVU6/ezH2aQ9GOupDYqCSTNchhJ/UmPMofj3CXDaGR3P8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7237
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

Currently, the only way to make use of regex matching in the shell is
by using "setexpr [g]sub" command. That's rather awkward for asking
whether a string matches a regex. At the very least, it requires
providing setexpr with a dummy target variable, but also, the return
value of setexpr doesn't say whether any substitutions were done, so
one would have to do some roundabout thing like

  env set dummy "${string_to_test}"
  setexpr sub dummy '<some regex>' ''
  if test "${dummy}" != "${string_to_test}" ; then ...

When CONFIG_REGEX is set, teach the test command a new operator, =~,
which will allow one to more naturally write

  if test "${string_to_test}" =~ '<some regex>' ; then ...

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 cmd/test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/cmd/test.c b/cmd/test.c
index b4c3eabf9f6..a42a523d33d 100644
--- a/cmd/test.c
+++ b/cmd/test.c
@@ -7,6 +7,7 @@
 #include <command.h>
 #include <fs.h>
 #include <log.h>
+#include <slre.h>
 #include <vsprintf.h>
 
 #define OP_INVALID	0
@@ -26,6 +27,7 @@
 #define OP_INT_GT	14
 #define OP_INT_GE	15
 #define OP_FILE_EXISTS	16
+#define OP_REGEX	17
 
 const struct {
 	int arg;
@@ -49,6 +51,9 @@ const struct {
 	{0, "-z", OP_STR_EMPTY, 2},
 	{0, "-n", OP_STR_NEMPTY, 2},
 	{0, "-e", OP_FILE_EXISTS, 4},
+#ifdef CONFIG_REGEX
+	{1, "=~", OP_REGEX, 3},
+#endif
 };
 
 static int do_test(struct cmd_tbl *cmdtp, int flag, int argc,
@@ -141,6 +146,20 @@ static int do_test(struct cmd_tbl *cmdtp, int flag, int argc,
 		case OP_FILE_EXISTS:
 			expr = file_exists(ap[1], ap[2], ap[3], FS_TYPE_ANY);
 			break;
+#ifdef CONFIG_REGEX
+		case OP_REGEX: {
+			struct slre slre;
+
+			if (slre_compile(&slre, ap[2]) == 0) {
+				printf("Error compiling regex: %s\n", slre.err_str);
+				expr = 0;
+				break;
+			}
+
+			expr = slre_match(&slre, ap[0], strlen(ap[0]), NULL);
+			break;
+		}
+#endif
 		}
 
 		switch (op) {
-- 
2.49.0

