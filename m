Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4EEC25B78
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 08:47:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60140880AE;
	Tue, 21 May 2024 10:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="b9yYqOlP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDBAC880AD; Tue, 21 May 2024 10:47:12 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7AFE880AE
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 10:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGypHAYT1kJH4Qv/hrX15OKmmJbpQyYluWxCY4zmgqNBpiDENEIqKoV/c+VXin8qyE72oxucUWWL1hSUyltFSBBGCrzdyPFwc5VaM3hWqrbThT2uieO42iJmvoOoe670dL+OiMuAy2dQMmpnYhGb20A2SCYmphQk8Z9TsXfgDd4gj2IFkaWcWqfxiw8h1dtLd+QMvDVLqYUZLU49csGPOJdkszjGDIL4xFV6HjUsq+8K3NcMjQ7igKKNXoMxZl/pu+dameZ2SkE47gp/po9arBwcc1LXbInd2xDd1bUSZm8+hM7o2p8cNfjQ7q8uKCtTxz50weGznF8RPE9XHigooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8Ho54t1NYrivQQdHSCIjPJ6sgPJW+rfNBLqf8IZyPQ=;
 b=NP+78zJd87CiaYWkG+q2w4Hox3r7DHSWHHi2YLaBJGY8R/84bTS74CuyArSlkwK9skvUUxZVhJqvHbdfoQgLS6ibg3mqScfdu/KOgkjvYi7zYB/Lq/4wSP7qkdNu7aR2QnWlANZMEmz+f7MkUNKFdt91ambiTN6eocmb36QLMMbJYcWWorKNlQvV+CqR4J2zvrYhfzD83JnJz5xUEbQsitUQLsTCYvs6IhOZd0IAXqjgq3USKBGMuKOldut2F5FvA3+c0uNZxAE3Ino+efou6tlsNzoIFdy/GeCwSpo2U6mTZo3XITRYFGI2CXg2N5JCHOlewLg1NrAr3dk+d1C0uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8Ho54t1NYrivQQdHSCIjPJ6sgPJW+rfNBLqf8IZyPQ=;
 b=b9yYqOlPa1Uv1TmWuXrFWC6nA7nio3k2mKCTIrk04W/ijoYUqm/jUvL/U1sGhiAcFwUiGZkC1aUS09qAm3KN+devx1T9MWUdajQ1uGU71DgfGdQ5y189XXg6uKtCxjgXNqdKXmDZRQ0knF1HmXIRXih9C411oTQaAb7BeLth/6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU4PR10MB8709.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 08:47:07 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 08:47:07 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v4 1/3] cyclic: stop strdup'ing name in cyclic_register()
Date: Tue, 21 May 2024 10:46:50 +0200
Message-Id: <20240521084652.1726460-2-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240521084652.1726460-1-rasmus.villemoes@prevas.dk>
References: <20240521084652.1726460-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0056.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::29) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU4PR10MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: 17fb19ff-9aa4-4b14-6b9b-08dc797298c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|1800799015|52116005|376005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r576zJdb0OyiC4846qAX5nbYnrcOLidFYS/1nhuCywSdRskTwJYuwI7qLQdH?=
 =?us-ascii?Q?g/dxl1OEhkGwhY+KGbOfWVMKz7sO9yv8kxYwUwXVdGcnoRwUKem4FMDzwkbb?=
 =?us-ascii?Q?L9SBRMQBRc/re5oeiyzP/yXilKLYUJ0HQ125+pqVzGN8fzjTKqaUBsO0oYBM?=
 =?us-ascii?Q?mtbqpoQuR1LRSLqf+jzWksqSr7SY89YZZgCrda1AWNpv3sBmTF+rWS1fi8q9?=
 =?us-ascii?Q?Rpb9UZEo/oSijY40jLT5yOLS6hQakI0AdwSi7qD9Pkv5s36l2zRLLKqsfV5y?=
 =?us-ascii?Q?P9pDDa3l5wQqATd7yha1kzYulhBUKfkqADvRowhomFIZBH07NBkTwa014wJg?=
 =?us-ascii?Q?QQdNwenThFJGduxFX48kwFsbePYsl29GFijYlJNlNIZPJoYUMp1iWylIbZ8p?=
 =?us-ascii?Q?vks3jxWLof6RpzWhpURlu8ZeOAN4S5qq7AnyuYPVLOLq2bbIoqj+3ypkkssz?=
 =?us-ascii?Q?JZ96ER03eTtnkw0jzMkR72an1CBnUWqJLnNksQ6vnHfCP+voTePoiZS+Wj8m?=
 =?us-ascii?Q?39lHvGymYPD43GfWZiR6UiwzKKE2bAnDEORQ7VNvRsMfxiXJSIA5l+R6xH2e?=
 =?us-ascii?Q?c6Mv9A6G2i0eAVBUMRsnLswilkC8JA1GfdL8YujK4oP1hzhp9ZxAo5jtdG0t?=
 =?us-ascii?Q?0STz8eqqnO3wn/nFWjj+U5F6DLRTo8RPHw6bcq3ZD24bHupFUKGTljof8RMB?=
 =?us-ascii?Q?vD3zc2wtDmGcOaB+uAgbKHoXGYPGXYjIcv6TEwRXgyErIu4UTH74FmChPxHq?=
 =?us-ascii?Q?dDym+0rkGPDOAdLl7rH9aPSA5xG68mme+p2dJlys/W65zpppQiXXPvjCiOLB?=
 =?us-ascii?Q?fCWVDwG5wbnfvVHFUg9UJb9E03gnKLWYoH0Go4CYdlCEbC2d/j9xqFdvVXQ3?=
 =?us-ascii?Q?5bNESfgbYK8rGKGw8hLZodRzy9uQmcBn9b9xmr457a+0j+8t1bbEgR2YXozJ?=
 =?us-ascii?Q?DEFWAn4ft46KSE5wk3dnSfyeTRSqVhuJj/hFrNPjVD6VXL0S5QZwdJfjkExY?=
 =?us-ascii?Q?hynSfX1Zl5JY/hSWK9G6xXjPvhriBqjMwae7Rw0EXHhUtp/R+IKQA3KqMjnU?=
 =?us-ascii?Q?LrQz7yPzFDL5yl/nkKVXKzHHN/Y+YbAgTSaC2fhv6MVM+9D88xjek3dW7A1K?=
 =?us-ascii?Q?r/umShDirgGrW0x3RGL4pIIrKuzHyGHypcg1zvcho+1FMNYFfWCZZdifwYw9?=
 =?us-ascii?Q?mR+klk7auzKlRY5+dq6BgUUCOX9LxlvsLSPGZw8GHGpCXAoTZRaNo5TTdVvb?=
 =?us-ascii?Q?s0w7dJIx57mvXq3+BLKCACoeiHxfPVZakyNEhcAlJ6Q0ruAZ1hicsmiLKhGS?=
 =?us-ascii?Q?Kkqoo6olzszV9oBg6ZtfYPf1JlWTFYQv0s+cCbLdkr8UQg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pT6Sqq8olYonldhkdwGz+UroKI0L0tInbHbnO9PIMLRH3c0FANRDOZ4n0t0Z?=
 =?us-ascii?Q?NFptFmpcUMpDkfb07nfHIeZI5wSnDT3UiTold03CzbthLEChDSUNoOeudQBE?=
 =?us-ascii?Q?2syPzYT5VPEHQK9IX7on2RxXnsl6dKZ/xjMCDBzt7C/lnS6FobTCcrA05Ymv?=
 =?us-ascii?Q?4EhYzkOZUTR+6lyX9f7CpExuRQbOcHmK++RPO7ND6OtI1LdZX7uC3GAwHuS7?=
 =?us-ascii?Q?zWQS/Od6efdNis5cyR1KyVZOj9l65pvnaaZ+m/ZazirDCcKk0nkjEt373ki4?=
 =?us-ascii?Q?35SVoXaNwCQfcyDkdxDTkX6xcsYMoC08P83SYRlEFckDjv6f0uy7CyOGJU2n?=
 =?us-ascii?Q?WhgSCbdWmQGP7BM4czX3+Yn82Tyhg5Fm3pAwU6ROuQqFoSxjKOqUE2CRrWL9?=
 =?us-ascii?Q?zK0Tkxmkcbi+9ROEoyPaSxwwhSSgvPrUinHO+jtswBouqaoVeCVxi1v38cyb?=
 =?us-ascii?Q?TmJTTTzoy68NxcQh9/rGD8MLJQNGAHBfNKYGfBpTCqnZE+WJorJS+Cfd2Qf1?=
 =?us-ascii?Q?U4Pd44VmCjplg+ApLSWHXJ38Gt0aPFTpBERmukjmnnXNqALtv0zm8z0rDxcn?=
 =?us-ascii?Q?UqfHPQPbt+EzlEoOo4oqYf7M5/5UZISZO/qoTpI5S/bDLDDj8GRwegx/PGrE?=
 =?us-ascii?Q?rbBb5Sy2tdTjPQjqV4tWqqcHpQPMnI1OrOZAb43PTAJ9WiiN5lhVH0RRdkWP?=
 =?us-ascii?Q?rIhRfY8hZVc8AeADPL4C/ilFwo8QXdYn+dEL8Dz+Dp88OxCx9sXiG6atsuKw?=
 =?us-ascii?Q?7r9tsXkKmDXP4N72s/4mAjbvTOUZqqLkNuRO+qQhv5Mexi/MBfygFWn56n20?=
 =?us-ascii?Q?93A8MoNbec589TeSGucnghb/T871nZLbbkihGXnTTesTwxlksaT8yINq70MG?=
 =?us-ascii?Q?45rb6x9+3GpPhawLCEns0I6DcL9bOckdRy6dY+4sytfCyTrTyGMcyc7G9ps3?=
 =?us-ascii?Q?SOyr2G0DKOdBnhcP5lnl+96LY4Nw47+TmNGdC6Smir+ZXMrEfK3Dq/TapNHU?=
 =?us-ascii?Q?vnkxNN4vO3qk6bwy5EtuSleRw1e9nqp6YNBEhmpZqwJRLx6lsAseToBohTOj?=
 =?us-ascii?Q?XLwdRAgpUiwA0qGxQM3VDfhmC//SjpeqYAQMmnQmAKUtnd3Rt7eX2EwcnLHM?=
 =?us-ascii?Q?A+krgwKHvXNG63QbBZvDPrdnFNToXWvQo6JfCcIqBvg2uuu1KVzZToqJpHkL?=
 =?us-ascii?Q?tx3Axcto4agUZv/4f7mFQMbzsC+GWQHqTEXXMydz+szm2L6hGbYoNNMX5WR4?=
 =?us-ascii?Q?TLumJhCJmxe3Gof7XDV/3nMXJAL2rtWsFGcoMMz+cuoLzRA+ZJMcevHuk4In?=
 =?us-ascii?Q?fdDmn6bAf8NgIe5tdOvbrrrTbFIEhG00fAP1rUn7KublC5FTzuVto6dkI0Cj?=
 =?us-ascii?Q?KKLpJ2htCtkTrzeTnidaZEewnfXmJH53Hc0opuw3HAeO6GmF/OXlSfHASqY7?=
 =?us-ascii?Q?Wuxt8aArrymG4yGt+RF0pI+9lYiQEsvPQDyrGXVd057Sy2H+KzzLtD0frK2w?=
 =?us-ascii?Q?cB8wL/eX1Tfbh80LrQ2EkG2AsIyE6do9RBCqlnDKoIhqZO4Qw79XE+8m/Esw?=
 =?us-ascii?Q?IJ437HHh7EWnEkl3nDST/WzsChQbkb4PmgUimRLYwOmbKRXKfX2En3hUd/da?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fb19ff-9aa4-4b14-6b9b-08dc797298c8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 08:47:07.7873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2s5trrngH2cxgGmI/wPeQdCqyaRtVUTmGK2jyRaf7FdXapXjKyShJ0OTGjguohTEDtk+0LOgMJam7fWsFzlIrc7CR9rnUy7LbqRSlxjFjSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8709
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

We are not checking the return value of strdup(), nor
freeing the string in cyclic_unregister().

However, all current users either pass a string literal or the
dev->name of the client device. So in all cases the name string will
live at least as long as the cyclic_info is registered, so just make
that a requirement.

Reviewed-by: Stefan Roese <sr@denx.de>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 common/cyclic.c  | 2 +-
 include/cyclic.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/cyclic.c b/common/cyclic.c
index a49bfc88f5c..c62e7fa7d19 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -40,7 +40,7 @@ struct cyclic_info *cyclic_register(cyclic_func_t func, uint64_t delay_us,
 	/* Store values in struct */
 	cyclic->func = func;
 	cyclic->ctx = ctx;
-	cyclic->name = strdup(name);
+	cyclic->name = name;
 	cyclic->delay_us = delay_us;
 	cyclic->start_time_us = timer_get_us();
 	hlist_add_head(&cyclic->list, cyclic_get_list());
diff --git a/include/cyclic.h b/include/cyclic.h
index 44ad3cb6b80..38946216fb8 100644
--- a/include/cyclic.h
+++ b/include/cyclic.h
@@ -31,7 +31,7 @@
 struct cyclic_info {
 	void (*func)(void *ctx);
 	void *ctx;
-	char *name;
+	const char *name;
 	uint64_t delay_us;
 	uint64_t start_time_us;
 	uint64_t cpu_time_us;
-- 
2.40.1.1.g1c60b9335d

