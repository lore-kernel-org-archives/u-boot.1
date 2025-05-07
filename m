Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5C3C3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 10:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 324F3828B3;
	Wed,  7 May 2025 12:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="fJUx3znY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF6AB8212F; Wed,  7 May 2025 12:58:59 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E69D78215B
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 12:58:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPxysCMi/h3kUT8otul30OobHsZslI7oVEiJNNiMFoh5Ttv7bmJAXa+KLjaCpa3ZIQxIWPz7AqKkYQOydlYgF3CWS7ytD/tQMBUV6dQBGCpZoi+GCYA8prx473/qU5AoWAj99+D8Lr27suanc/vHbVuUJJ4G7+ig/7EkHpUyKCtYsC8j/nW4DdYQErgAq0k9538KONJwTxhNJ3Etq+ZvUFGGw3sfc4oyAyeub26xWQRcNU9VKLgbiSmm0v7BHv63vsSz6al03FUzI8kZ8RtOU/sUQGABKC4BAZ47X5mDrGXzgxNXI77fwFpDFU/8pyMTJaHQJ1gSgi4XWjnbTf44yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GrIwjacfIP/kHc2va0LJcz6W9HZHlJFOXU4cj0Ykso=;
 b=bYfxpCz1z4Q7ykMs9ZiM0mh4TjjxaCJWH/Hy3RQAqgIG4P/v2IVIeqFQaKT49fysTIMj/me9kIZP9+p7QJMJhK7pzm7avXmXey65G8ucfOB9jlxzAoiJNjviCCk5OtZ3xJC2baBLysyPADIR48fSgSonrLkjJBHJruMRbanoz72Ya+i/1c1MwYKNlSs836OJLKI8MRhP28Q5RU8mNgfLrDnMf2p8PJGFV0q2orUhzt8qVrYqgXLWkCZHK5nhP6AqUEM3uBNiukdRaSbalaU8FnvbVfb9G1V6TBrZRhltg73b08OCLAT+W3v2HV6b/IkDQKujRYrWIvUeAiQM0KxT3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GrIwjacfIP/kHc2va0LJcz6W9HZHlJFOXU4cj0Ykso=;
 b=fJUx3znY2yDcTiDkMbZ+AxWGBNdpdmF5wwlbLU1c4JdoTrT0AxRuD7yNgndTMOUREvhv4dgBMRB3x4ZIEBny99L9wX4C4XHwz17Wk093UY+A8tnwznoZSB1f41TwGhS/XHnlEnK2RRZc6KSKqpGf6GFdbbNRA4fo9uZaJSz2hzw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV1PR10MB8807.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 10:58:49 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 10:58:49 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 1/3] cyclic: make cyclic_unregister() idempotent
Date: Wed,  7 May 2025 12:58:19 +0200
Message-ID: <20250507105821.484442-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507105821.484442-1-ravi@prevas.dk>
References: <20250507105821.484442-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0084.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::17) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV1PR10MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e675ab-5802-449e-e23a-08dd8d5625ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bZZx+tFmr7TzYQcGFkHnLLhH61KVj5/JlJIINNySNTW6iBadiirZ9mCyF/Lw?=
 =?us-ascii?Q?FIqQKfcs9LbA2ji7KoXNrZxFyKg66+KfPOpjNWpq81JzPGmTJaS7KYgFmVMd?=
 =?us-ascii?Q?YNfthcACPgmdDgFRiuObDSZs7shRzF0ZfCHUEFbk1oil26oFCKtxxZcgJxk/?=
 =?us-ascii?Q?2H5f/v5fuKbbDsMnj5ojEt/C7hL3Bcy+luEudDxvdHpOOMhQRuIcvSlFUOSd?=
 =?us-ascii?Q?++lN8TMXXYxjS+ABBvfeWlnpIqe9SuUj62xHD4u6CtbVdnzJEiaZaMNgVWaf?=
 =?us-ascii?Q?tWZmyhP5FHSswOjj+lafBtcyNZhiJ+RoAoWLTPoEW+GsarK60d5PYQWq6aKO?=
 =?us-ascii?Q?1VAF9xhg77sbS1+tIgMNcY2YaK+Z0MQIPKIFCr4dNtLojldzF6pWTs3CrOs7?=
 =?us-ascii?Q?QqHFjYbybPSUYOoGiJZ9PForNGeqgqM/dqeysN1iQOANMqSwJTX0wZEehPG8?=
 =?us-ascii?Q?93rjePp60Fvdg9e+jUPV3NI5V/RtLu8C76DYZVyF3V2AwWHArVcEw4uNYCdM?=
 =?us-ascii?Q?EQPdSUHiSodsbGzIsOH9pyMCpwJvucjeAPk5iD/tPLrbqf6WZ1P51GzPulUj?=
 =?us-ascii?Q?Hng5N68nniymFSRaUvApBlOjk6LlV29Qr9GBrF65nZ49IVoFTno66zJdG6Bi?=
 =?us-ascii?Q?QRWxjYs9lzdnInGZkt8SKKJKpxbJUEeX36cr3Y7+FL5sX2d6dmwynf5tSmYc?=
 =?us-ascii?Q?i8wAqdp3FlUnjnWBABTH7fUKVBIbEmn6DscIDehL5S5/mukhRY4B0/JjziP2?=
 =?us-ascii?Q?6GxwCSnNKvnSCcU7nu+ArSlArQa2heAjbqrYRmHZw8dR0pFgQWUafPgz7C7G?=
 =?us-ascii?Q?tfCLbo7MmNYHwtBxpNOlNjex3uAziCzeM7GGANppuk3jrfDEUg0mmckVSp1B?=
 =?us-ascii?Q?Y0VA8mnLkJk6NtsP8eRT+Loqi0WvrjcwbO5xjtVTiPYRcEaa9FQ+ZLfm5pUK?=
 =?us-ascii?Q?RPtDtXwIRQp2jOaFOsmLF2jB7AFDyMz69xDCc3csfYyes9t66Z+3HK7QgwD5?=
 =?us-ascii?Q?oBxcB5Z+ACJtRlWZxXYPzRuoKljgtnG0ZJSgd5cYRbhzkaTFhrVDrBpp4mtM?=
 =?us-ascii?Q?vHgGKQl1x8xSU3YUPGKfFG84ybZXc3RQ6tYL5HraM8qERhCHn2j47ssRydHY?=
 =?us-ascii?Q?3OJgXQOthDQNp2cT9h+P/aFVftpKPP3szKjw/YOToceEIwAD/5jO9wJYszw/?=
 =?us-ascii?Q?FLqrjfZGsjor0JZIXi8r9EekbXhBnVrcMF2etaCzHNnYm8pVDtPofbfvVPbw?=
 =?us-ascii?Q?ucp6/3N9fDCsqlohtjMFn9DDrdZTSyF/DnIiRD2/twxgx/w1mGuJ7vKwi0B+?=
 =?us-ascii?Q?thFZRlCh1DlEh+xHI1HEgDkAAuWA0ISZrjtFvpcF878LvXVFuBIfq0SWas+d?=
 =?us-ascii?Q?+VNJoFcp5VhYLNVjE7Br+R46HVrBHFzPsjnFoR7QkrGYb/Ihj/jXE/ca43e9?=
 =?us-ascii?Q?Nyt/FxYTdjy7EqBrDC2E3kOBy4773es/B9HLOI9uRPSeqBk7FA+llA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?79CsHx551OOQSSrT40vXgRqT+RszsAvWlBBdViBOBD2h+3WDITst8KUk388D?=
 =?us-ascii?Q?2ajW8rUtwDhQuFpj0EpzmU/qMWITi/hyTtsacsT543CO7GG6xbQ+xarVo4Hn?=
 =?us-ascii?Q?aRiMaggJVwfE+KlnGzDraT9FoIuffUwaEpbRTxOSHmXkIy49SnoWHr1HEWcF?=
 =?us-ascii?Q?J4FIkuDd0NzZfu60Zfaa3cUz9VguWVQiUa1yvEZEWyGYJ71DzbL84CcE2F3T?=
 =?us-ascii?Q?yuju1tpQ+sXXhf4rGtq9E+mT4GakvXQGyPGnp5SZ/6VzX5IVPbYcBB/DtwQA?=
 =?us-ascii?Q?0ojvuO8qlnbyOOKrrPXYG2APpHPwn65lN1uop1415nk6rM5sZDZJLEGDjeFe?=
 =?us-ascii?Q?bdwJDYmfa4/1w5HtfdXzM6vRPXVe/NrlZYtgIiQezaeBP9P2N90NEOwxkkiN?=
 =?us-ascii?Q?Eg186zOzkGMjFhp0LZm+9WiNVYESjDLkUpSsiqkESp0tgJurOtZpzG/if51B?=
 =?us-ascii?Q?ATBCnt5frN7/7sVGPEOHlpNX3aat+7HPzKeHJoagBLriTr1HD4vw2tr6k+CN?=
 =?us-ascii?Q?VJPWEAuw9M+G22OeDBDRZA2LhZL2xZDIhTo6RgINzJ8ICawH/DcNnOP0tY0i?=
 =?us-ascii?Q?dlJ/P1w9OqD6N6sJgghqSa0/0m8S2NMyz2ywAl8H1+wbtlZQcDm9XxmAYbCD?=
 =?us-ascii?Q?flhND2uE+EUIcjAQQx97CX0o83kXJXrrloFcZN5ANLT+WZ1GyOaDuIfVzldi?=
 =?us-ascii?Q?YnMs6MrVFbt0tCVMF3b560DsGE3u9ctRduSDJUq3zyz2sGvJ+M8UAVFJmViw?=
 =?us-ascii?Q?EoBXi9+oubxMIQXUNoVnFGBHY/dLsoNcY+cQc5uqfVz6moTH2725Poux+5z9?=
 =?us-ascii?Q?tls42rXzx4VIHcxTy7EEK+hLumrY/JLdCrc2wk/DA/CMS0crYhsQTBHCFdaM?=
 =?us-ascii?Q?hhhAC3/G95i/dSFW77wyHc/NeOTHnboBkeCnr2/uxeLlNG+ZDKXJ6bas54bL?=
 =?us-ascii?Q?WYp2PiOGpqX60J78whkSsnBKT64aepzZs+gNAlA/SfBLrv/PbTVu2yl9vXeY?=
 =?us-ascii?Q?3zq3VJQ8qFq7gv7W9NGRbzjisY9JPY3TZojhZZtc/up4o7PabYKnKCzBzp6j?=
 =?us-ascii?Q?m/U+SymFffbZyPK9/5xEhdFwqsnXt3gL6e8zd34W5TN02Z1/V1hplBaYWGXU?=
 =?us-ascii?Q?McBGVWvpPd5/7IXaw6IXOdpfDw2PMFXWxOc6tARl3Sg26DsOfNL6//dvuJO5?=
 =?us-ascii?Q?g2Qz0D4lZMJf8kUDJYG+MlW2Xt4XTzPo5qrntVMYAsEe5I90CDHYA1ZHt1Y/?=
 =?us-ascii?Q?7r5Y47g1MBh4YGJ56LhTuiOaDRy88d1ZFzsxClQK4+w/c85A3UTR0QWGhprT?=
 =?us-ascii?Q?1p/y0DeELH1ZGhN+/7LeeV8i5nDEONdsbyTOiYLZc8DmJADIAs7y9cYxduTF?=
 =?us-ascii?Q?pVBJlQzyPjC7IUEgaDtoUlkIH0B8/VtF+yqKUqyoNo4YBfTG8koJGyicnAN/?=
 =?us-ascii?Q?YCE+cI9sGuY4ImXuNa3/LAduAtoj55PVebnZyAinv843ohRBgbVtgNu96st4?=
 =?us-ascii?Q?+SBaRNoeMdMRbX9p0byyJpDvQpcsy6uf9VXWJIyb2qBdkBSyJwPVk2BFn3jb?=
 =?us-ascii?Q?aTbbvKHPtKPQ35y1khl2g2m+xrurqWy006Mj2iPINMdPhKY7j9SoVtZ8WDQG?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e675ab-5802-449e-e23a-08dd8d5625ab
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 10:58:49.6298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAOyrS3liHiW7YI0Hb1VwaJeomR9zQNQ+GHdj3nLZoy91GUtFQ+eH1qL1hErS2a+JPJOU4oSrapU0yYXE3Vdr6F2B3p/zpcQvFXF++DE+9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8807
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

Make cyclic_unregister() safe to call with an already unregistered, or
possibly never registered, struct cyclic_info. This is similar to how
the various timer APIs in the linux kernel work (they all allow
calling delete/cancel/... on an inactive timer object).

This means callers don't have to separately keep track of whether
their cyclic callback is registered or not, and avoids them trying to
peek into the struct cyclic_info for that information - which leads to
somewhat ugly code as it would have to be guarded by ifdef
CONFIG_CYCLIC.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 common/cyclic.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/common/cyclic.c b/common/cyclic.c
index b695f092f52..75662d9f613 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -28,6 +28,18 @@ struct hlist_head *cyclic_get_list(void)
 	return (struct hlist_head *)&gd->cyclic_list;
 }
 
+static bool cyclic_is_registered(const struct cyclic_info *cyclic)
+{
+	const struct cyclic_info *c;
+
+	hlist_for_each_entry(c, cyclic_get_list(), list) {
+		if (c == cyclic)
+			return true;
+	}
+
+	return false;
+}
+
 void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
 		     uint64_t delay_us, const char *name)
 {
@@ -43,6 +55,9 @@ void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
 
 void cyclic_unregister(struct cyclic_info *cyclic)
 {
+	if (!cyclic_is_registered(cyclic))
+		return;
+
 	hlist_del(&cyclic->list);
 }
 
-- 
2.49.0

