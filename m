Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43568C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 11:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 137C788422;
	Tue, 28 May 2024 13:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="bj8SXqdS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 249B3884A6; Tue, 28 May 2024 13:13:48 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10653884B0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 13:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAstItF5oFrWvxSi3zpw8xFSDqRYsAYwBtKv08BPJNwlBmgjBQRBbvvSwon0NOne4tsvJZWwlK9Soye095R3rmw/Zk5VzoT9WiuQvwsNhVjktQFfKeRzG8u7D2fkonn2KaIZPBYgm6iOFXvf7Xviic//bknBhcKBuXrj7WcJ8ywWKLxIMAbORqIAo/pAlNyEHWk/a4ikxsUYRM1d5VSy+R1YZm9VZVOaNwU8YrvX6YAVGxl5MUk045GVPrvz2PXRQhLEQJrShmqH6GsaYyd5iu+q8rgfGTnwNP79I+h/4tRjbCxU+nfUP+NhO8EPtYTpVY4pqYEAPmJVggLw7LV1zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sl4Om/d9Pk8FAZqpm8tqeXWMrgXp8SXwwbRrfZRSLaw=;
 b=XLU8GrhpETz5UYWmTY+jDH42mYyWjvglOBS7bJBX34/wfS/U1cjD7A6K/m66RixGNaBxc3oGlUX6G+tcl7ms/0J6hiqJRSOkKvSnkPul9U1Y2Lvidvzt8cYnUm8nyFZmzJrrpGgMgJI3xKjaTPPnJhCAje3cndJIVLj3DUPUr8V4cLLUUrDYg9vZn5e69evoL96W9JR6D/YEqfDm1r4zZNj6Vfb8+Ljj/7O2R1wO6PRya45zk/SmOE1vOE/RnsWXarL7AMpF3pEPH+JJeqWu2bMUX/rnb5Peu+jYTgXJXp4Wc3Mjkh8Ngme999qZ1PPJ/6pbAf+fK7GRGdpadiLmyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sl4Om/d9Pk8FAZqpm8tqeXWMrgXp8SXwwbRrfZRSLaw=;
 b=bj8SXqdScZdGxnbJYgMEthlqYSwIren0lS5x3Sw7DB0ax+RKlJw/IMndJgxNRIe799ib/4ELvjgFqQY+ur25BXG438BlGz5PsmcyvIAEb7q96jVyW2hA5PDyXWSLMuTc+9NVVvQDEIM9kwKY+y/46QvKeoVeRwHQx8PqF/pyv/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV2PR10MB7079.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:df::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 28 May
 2024 11:13:38 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 11:13:38 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH 4/7] sh4: move reset_cpu() from watchdog.c to cpu.c
Date: Tue, 28 May 2024 13:13:22 +0200
Message-Id: <20240528111325.2163560-5-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240528111325.2163560-1-rasmus.villemoes@prevas.dk>
References: <20240528111325.2163560-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0066.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::9)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV2PR10MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: c4dceeb5-244b-43d8-3cce-08dc7f07392f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|366007|52116005|376005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2KMqVOcluKXJ7FC5UsdpahT3NK6EfSa4pFw8tiQcoIR5OJY9b40T8jXSk5nt?=
 =?us-ascii?Q?/DByTYjMO2Ekx+SUN39lHT7uqwybcRLqMN2pMJzjfod7N26MhBocXJxma/Dw?=
 =?us-ascii?Q?75B3p2rXJOy0BALE+MkvXWi/jKOHMb6r/+ZHQ+yFYDrDWSrU8a7pWvY7BTy3?=
 =?us-ascii?Q?/vQyZCBDh/lcKFhcEh8kn6qn73JXOZAC/KPmkt96uUllmzIMK71/64VzIj7F?=
 =?us-ascii?Q?BMQ4AAvh/7FWG5qmImt9QAfpepRBkaQtXsJNzb4Hm42t5v+DlitUvC79W491?=
 =?us-ascii?Q?7grZOZsJKl1+udYV3EpwtfEjXSUh7IJfpq9AZ2wjvH39IfUKwHJj09znWhaq?=
 =?us-ascii?Q?I7KkV1bketpHx8y5Ki+Z/oAWNpsLvI70CKzTbKdrx73WVRc4DS+e/62FppX3?=
 =?us-ascii?Q?rCqn/6rzhfi+MQUdukMk2T6GTB9BsSRRRUnqwSw9b7cGgCSBBxNEkejB9caR?=
 =?us-ascii?Q?ZhkoAPlLAIkzQPb8DumyH2vTXIs2+7DB4WeqYUZgTvkSHK6XlHKNECU0mAou?=
 =?us-ascii?Q?H+vY751lgBatAJ39YD8aPcBEE7WU7gaF2hffy36WDwubrft0z1/GHkonfHiM?=
 =?us-ascii?Q?bLmsnnLaMg2sWo4QW90NBVkgausEEC6vuzcYWNAsj69J9Yq+H2JUcjzVAR34?=
 =?us-ascii?Q?0LSUg/2Ojg11k7rcVPJskGdnf5XDqY72IWdwYP7+BnLfUDlhjQ0lV8VojETT?=
 =?us-ascii?Q?X4xM7GopEa+yVyHaNMHO0FZvsq/7v1lCZK4Hb0kM25lmH/c8p29yIyG0pkFm?=
 =?us-ascii?Q?p9+Jsf/7Y3+dNSXIRSQJQlPV9fdsTyVpCjYMUZVuotpe6i/Qy1x34qgmePOP?=
 =?us-ascii?Q?acZ9qyakxoavLpgaXQCTzDP3qjFAxD1a4Z21qFxFnFvc7AOX7eJ3Zcr9n4hs?=
 =?us-ascii?Q?f9/k+NJQYTd9c7k+lIx4B1vnfmGpNn2GqPUqWwglMV0yLuqiJqGBbKDwFcnN?=
 =?us-ascii?Q?9PV6cn0ypFGZcu+eBu2AoQeCoc/2+QWMusLW2MzBeu+cgIDpwk4BX5ViJHBS?=
 =?us-ascii?Q?ppCt/cMM92oOOVwSveAC4KTmD/IRkS0qwnFsD1rsHBTYxhuptezrP6yNjfoZ?=
 =?us-ascii?Q?tHeVddydipu9T0xVat6RvS7nd9+0EpYNePwcVRfo+Ww6feepPpMt1vZ3ESpb?=
 =?us-ascii?Q?uBk2mFwic+tRvvD2rJJk4UoGjBOcqvTRueymjMoYZpVcNsPfUovj2pWpDTZE?=
 =?us-ascii?Q?q5uWMbBFgclNnIApF3CAAi5uMqi77aGetkQjo//qXuMqNx1FNMt5op1S1l0Y?=
 =?us-ascii?Q?349t2P8QUWhWSY5bk8j9oZE4qgV6evmeibS8QjaNniHUk7GY+aiVDIgK8hs8?=
 =?us-ascii?Q?M3vms412hJnk2m3BV0RCvzkPTjpzIa0aUNjBPE9V7FaXcg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7BJzddsHcCU99/WNuARlFD0GKm8O1HJ/ICnum7RxVyIBoQYzjPBhsHFJnp/m?=
 =?us-ascii?Q?WuNl9FPYTmu3lob8HxapDRhZyEt6T0PlcIk2MtYQ/uRLKW10eIL1y4VPQNuB?=
 =?us-ascii?Q?1z+8kiZSTxmU40bxq87/nqDl8cYtWWvXKWZ7WhVWPVwkRSSdcV/B6JkYVyvj?=
 =?us-ascii?Q?mK9Wy9QqS8cV7GBsbWCVTEWxCOY7LiHjoy3OLpBruAYZ9zzIffZlZbDkDqm5?=
 =?us-ascii?Q?xcNokyjp72y/2vlQqlHEcSA3wIXja8CYYrynOwmJhjHCmiotY1Ex1HCl+mt8?=
 =?us-ascii?Q?t1eBF7Dut4FSH9zZ4fYmzYAOa3YexG4vqZi9Fjbhk1OOGUis9hIS6iEcn960?=
 =?us-ascii?Q?2sbRfh+cIJ510nPWP6A03lQfZp33zHBCygySOL+RfsfEWhopwv6gBd04XZlR?=
 =?us-ascii?Q?4JGgP3pB/cZgBqSpo1rmYU7mvobjesoy3lAVG0J3TJvmNbxuk+FtbnI71WAx?=
 =?us-ascii?Q?zjOob/Mx/Q0yCtHAwHCV5OdeCJlx+YYdQGfMbkUFeuWcRX/xnY3W9uHlL9cL?=
 =?us-ascii?Q?V8BkfiUg9b2a5fsLZ7XW4EbwlHTI53Hkrydqq1WxsiE/DjVLONS0o8xXgrwF?=
 =?us-ascii?Q?DWyKAzDEpbBVmGFP0IJnMYiqL3ukbZ41mqYmS4Z0GSXMkmwoz+r3KrDVf3pS?=
 =?us-ascii?Q?0WQW2S9j2QrGd6nx5Ehq8D4F/5ZPtVjnHBlztuYP+uF1sHZc+kl7jGhoFDGT?=
 =?us-ascii?Q?TX50et2GgpAFaKXuUX8UcXboggIwP36WvZB2+Mf8xK1tDVZvkc3NTcMlpFQX?=
 =?us-ascii?Q?9BMWWErk5yBv9XMI5KDhLjJUspv8aie9vkTefyCcQ8B4Qxf70ctuTJ459lvu?=
 =?us-ascii?Q?mg9ODQDRGtEkWhHGEFzTTpa+TEZ+GUiZiK+BEYbYSliMN76liQ7XFWWEhsDf?=
 =?us-ascii?Q?xbnv+ElLRHyaj9p17VMWFZzUYIRIixb2q7T36KKL4gIn1MNHiZ1HMAuZSMYo?=
 =?us-ascii?Q?zfX0/7kBFUpRZIapHoqUrgpBE26vuo71/q98scLdkCx4O/GGvAp8nBZgA01r?=
 =?us-ascii?Q?dl7WzdZUOYP0ejY76ZVpn6LgA9+X02vHYabDomGj596ILLK74zaigHiJPhtO?=
 =?us-ascii?Q?TyTpmexdomw3jo/JPv//VGIx8AVjuCd99PfCoKXDX9sOaGWUZ1kOqh6/b229?=
 =?us-ascii?Q?4oxASsylEL6z8tSSGiOWGSLuPPRtk25Tc8+G/wTsjxCIZEXfdWqQz0yaywXu?=
 =?us-ascii?Q?qQKGNpNY+VlsIAK4TksY3DVL6LLxOBFIsMEK4PlwzQTHJKDZJJF4+XK56enJ?=
 =?us-ascii?Q?h0aXR6DITniYxlidgmqRlfA4ltMG6ZwPeUo08JWVm/5YUvNrw5ARLyYL4EBQ?=
 =?us-ascii?Q?yX+Jt+izyLHqvSrUeB+0/xjvIlgPzFmWyaJguEPgerHWO3hu61ImLdbrW0fp?=
 =?us-ascii?Q?6xdIsQ73zAZ4hv3kfLy4/KZnVA6eFsx1I6J8aq5t9anTQ0UytciJxi3Lq0FN?=
 =?us-ascii?Q?od3CGx/Mtwz1nLVu64wv7SBOJq5BTnzy3GdwrQ0FVxPg0waoRnDlqegH8TTp?=
 =?us-ascii?Q?5kh1SmNDmVuVwjTLV3Yb+uVL7XimhPtjDEOt8vhQajMzBtFWccjMgEaR6fT/?=
 =?us-ascii?Q?V0ZdLP1K7qbnOYjm/s5hJ7CUws/tdoQDXR/6OL+sBhBZxAvdYc3uYejZhBe7?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c4dceeb5-244b-43d8-3cce-08dc7f07392f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 11:13:38.2214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kC3I8gGM9dnWVdD/63fyY6wT32YeyFZJEixTLNrrxiD+k+BAca8MbySJotteGrBeFkQb8dmYiI1RlNYlhb35w+2QjjRo+oR1F4UGIv14d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7079
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

The next patch will remove all the other code from watchdog.c, which
would leave just this function in there. It seems just as natural for
this function to be defined in cpu.c, allowing us to delete watchdog.c
completely.

Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 arch/sh/cpu/sh4/cpu.c      | 10 ++++++++++
 arch/sh/cpu/sh4/watchdog.c |  9 ---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/sh/cpu/sh4/cpu.c b/arch/sh/cpu/sh4/cpu.c
index 1b2f50dbe6e..6b52737028d 100644
--- a/arch/sh/cpu/sh4/cpu.c
+++ b/arch/sh/cpu/sh4/cpu.c
@@ -11,6 +11,16 @@
 #include <net.h>
 #include <netdev.h>
 #include <asm/processor.h>
+#include <asm/system.h>
+
+void reset_cpu(void)
+{
+	/* Address error with SR.BL=1 first. */
+	trigger_address_error();
+
+	while (1)
+		;
+}
 
 int checkcpu(void)
 {
diff --git a/arch/sh/cpu/sh4/watchdog.c b/arch/sh/cpu/sh4/watchdog.c
index bf403d3c520..a891333392f 100644
--- a/arch/sh/cpu/sh4/watchdog.c
+++ b/arch/sh/cpu/sh4/watchdog.c
@@ -50,12 +50,3 @@ int watchdog_disable(void)
 	return 0;
 }
 #endif
-
-void reset_cpu(void)
-{
-	/* Address error with SR.BL=1 first. */
-	trigger_address_error();
-
-	while (1)
-		;
-}
-- 
2.40.1.1.g1c60b9335d

