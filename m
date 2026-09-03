Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4DBC61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 22:13:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 347A540B36;
	Thu,  3 Sep 2026 22:13:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jsn9WCi1fBXe; Thu,  3 Sep 2026 22:13:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4DCCF40A85
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788473614;
	b=Wy2bA4egRYs04nv+9GC0n0Wlx8PbiS4iKC61sIKuiET2pehxLmLo8cT3Z5N1LUx/dPU1
	 2zz8kR5EsX0rhrBvxc55jhunh48SXmBW9n4X55k5ryraiwglMtA3Ho9SGt9b9ewZzP+Hr
	 wQehr+DJ+9jgfb2u3Dsulv5U4oJkYq7XpI/oGsjtWStb8Cuj6nlxEluRHST4ZrecCN2j2
	 IPJ8zYICDr18JoE/kzZFs7uN/xPaVi0F+dhPm5QRwypdyFX/fLj1q+vs7wfTnuJeeem8a
	 moPMOsTVuhJd+3sXyMC2l20QpGkfDX374Rl1XIVFgd1Pr5CGmeW9lkaIaf9759LLXNw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788473614;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DYBaXpMYA7FL117f2LN5LRQMuarTJ9bsCmIDnGHF4QY=;
	b=n9lVQz96UyzdFuPrignHJIl3bQ+4SPiGlOtn/JH2pqQYfHM035ziJKObwimcIm3bjs/a
	 bUnkppc4kfEXHjtKFlhQrP8WdVK59SL2V3MlfCQflj1D4OMgVu/q1m4xEa62rldhEmZCp
	 3fArZtFnqOCeTUHy8ScK7i5aquDSbZ6QNrN1tybo4tglar3841cIhgPaDLyTjT6KmYijn
	 KdTevYC1Dnl/wj5Z4rVgYolYFUtCWXJMlRL5LuYictLJvaRg9s7biAMNhUUU7vVLXlkvL
	 jighbHPzGXjQhnjouHRxNiOdUaJclXzakWbsM/uxmYgBaKAAoYpGhZYezjBZHmrfl1w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788473614;
	bh=DYBaXpMYA7FL117f2LN5LRQMuarTJ9bsCmIDnGHF4QY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zft8Ps2UTRRdozxUvpGbiJNnAOY0vtz8HNF8RQKJAh9zeDkNy2GtnKkLpPdIPX1Gl
	 i+PKtR5gPlR/p8IIXuq1uJe56rcI5uukXIPN/nzsSfHMws2ZOqOQ9u2XSUVrKhnRmo
	 X7gbpVBER+YCpcR9Xu0EhhrOGhZB0shIBad04HXQkFyeWyxrS5ckxfs9TqtSkKRQC9
	 5GYVJA/2VZGOqeF878iU71BfeIhAUV97EMP9txW4kIAHqh3kfQpAdtUoErcGB/9I64
	 onsjyKnuNL2JiTdEgMkZeBL/yX4JA8uMdXlPaDjX1bJeuFfT8W2dzw77MMwVulCdF2
	 zbm9qlrTKn+DA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DCCF40A85;
	Thu,  3 Sep 2026 22:13:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F1C9463
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:22:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA1CF40469
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:22:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jWdOdf_cIGmZ for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 21:22:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 908E340029
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788470550;
 b=h0sO6Bzq6a3fbDIi53lebKco8ZV1SLybPUXEBSRh6uZliE/ifdIMlr+V8/lEIgagpl9I
 GBzBNNfGGCXZRIp8FmHtRUkQB4mqVAGT4wD/eLorz65w3/cgK9L60TzE3ZSWC3csW35lC
 99NoFmaihyg34dlt2tHOEs9edx3ILXrDcJxwhJ4j3JCgK/gTiIZjTp50T6CHIzoo+382X
 +JVwYPQlmr84Re3J3V/5MbicgKfkWZa0GXQ4HDVpyuTa3n7ODnz75xos2YP43QHYDVxN8
 i+tF2NES2sDOMeG8bEwKE+Si+ZC2OcxU9hVUJY1FbqZGfJ4Ongkvsatj5kxGOOQ0/ZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788470550;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=DYBaXpMYA7FL117f2LN5LRQMuarTJ9bsCmIDnGHF4QY=;
 b=b7RtxZZ0UAmYqJEEumuR1PH6UUkTsG6Ne5tYjvotiHdHaUZtseH0gEgTnFyiFnIIGDgK
 ZSL+0Zlmn6Qp2ofF4DJRCoKozDhRA0YGquI/g71VZHXk7pWa2MJFnFgte0fSNVkAnhsSU
 NQJ/U8TncRhHRbMTSQN/Qe04TAZdbRI1irxMHIaLL/iumFfM99kX5EuoLCz6j0fg2vi6F
 8QpSMYX3iZGcFnaVyteBE2pZKMcA+03P9kK8Ims3lL5fof1pgBhwEK4B0P+uWtS86ivR9
 aeREDvbzwrF/VfpR4z4r2iQtY+jdIcKoVazB4hFuHvWmdWXRMR2BrI3tB1iQBwkRtdQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=prevas.dk; 
 dkim=pass header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=YNw9+vww; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=YNw9+vww
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 908E340029
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:22:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgE6VlKVOJtHmir8R+sqynzVipsx++YjSSARNcUT/GzzkrW1ObZEZRdzQPVHnqH2tV8riRnOlUCoFmFqjhAUmJZni5WAGppoBDXCY47fDw/vLRsfiZ5Lix7w1u0skzIh6+7b2EuNIEvgO/Z5HX68vTi2FP8K4ofyi+A8uGoQDM7jkB2/bSmcvjB13tRIr5TityIfVFOf1cDFZp19JfvyyjpcRY2y/Kg6zfdPImMI6LBlixQfjx30B5ogqv+TSAmBUjLH09faZQZUgtIAHaKYfT+K20LaO2HwYJMFSPxxzKf1paCbmmA96gOUb8MRlW/7LKfDoImeCCgX8FtEPM99gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYBaXpMYA7FL117f2LN5LRQMuarTJ9bsCmIDnGHF4QY=;
 b=UNqfCec6fwK5BU0uClAjPqdbtZE1pz0ZH9NYok+Mo1B9jhg9NSw37C8ZC0GYFhlOD9b9GDQ3laZR8d247nhB54joYXzPaGtgZ45e2HFEoGin4iTLM4vRUk2J9UWyp/l+TB6lXSHdy8yt8CcIY3HXg34gQNKkZU58wqzTwzg7yiuP0a5CmUYpbEHKIVl3O4KNDN2zKhYFuZ38rVx0XKaXB0fbt3Xt3BCLQuEKJgG/Rre13g7eefljnA/Yem+AmFXZBH6cqhv2LFPeM3N4QaZA7EVfIt9JfoIV5uC49FWUJ45eUSo1OoB4SF1a8H9X1kGIyVyLByY9NReM43BAKzzmWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYBaXpMYA7FL117f2LN5LRQMuarTJ9bsCmIDnGHF4QY=;
 b=YNw9+vwwr3FoFNeoZ8//R+2F5o1Sgt2hwNs+KlfH3DLPtWn5e9jK0km7UHY61RCz2r4VWgdH/lVFmsHPvzP7GF7Xh4tE3kSxM8OmlSNG71BRpgpVsOwDCNRispzBTVADBIN5UCtxh0PIneaxS4cj29BK3j3tVYYqfW9E3TPEVr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU4PR10MB8445.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:560::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 21:22:21 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%3]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 21:22:21 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 4/4] cmd: optee_rpmb: make it usable by scripts
Date: Thu,  3 Sep 2026 23:22:15 +0200
Message-ID: <20260903212215.2331118-5-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903212215.2331118-1-ravi@prevas.dk>
References: <20260903212215.2331118-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPCP307CA0008.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::10)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU4PR10MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: 57803a79-35c8-413a-6ce0-08df0a0170d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|3023799007|10067099003|11063799006|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: 4nsDZXyr6C/Mj6Jg2yAEMaDoRiuqN2gAdNFPiiJl9vY4lqxEQbdWEJ2KTT0O4TCf9Z5wvkzjZxGlstCW6Vm99W3+V0RlIuVOHswjoC/rn+DcDzBFxKFIJgjKZ+N+SZCOhg1LfVd5BKLkO3pNJj68KqFdKDnBvmcYWj0XV2EIj2MG+0KBNu0pFASnhXDwZ/E66yewtOKz/vh7XV5e4ii0qh8/wIbHjXGj8cNNjS/uEfVGd82PvjDsdjjMvrSTX7i9c/uAId258GfQFQ5Jv5lJoCl4+gz5yscyYRePj90X4wXSXGlBRHW0teaepui45RjHQa/mpzGmPyjgMDu2xT2YfIvEikqqteNNDH6gEbW93TMccsvg3CnI2uuDmvokyYYVROFZ84kghuGfnwOUGmy7760VncjWeH7QOIYBs0WGBa3N8kfQfzqIpeI+Wxxp+mq5hzlCt4dwk7rM8ZCBWVolS8qt8A6sfDmu+yVS8jEvcp6UFn1rNMHiiqK9xIj440haqvVHoDsDEeU8B1FBYMbcI6EeR5wnxGsvXJ/G60cnaYbl8WpB2C2Im3xkOBY+AnCP1xlTxKqcppXVnfIquQ8z4awKH/7ZWXBErEyngz2d34ddWzol0D2zdyneLUF3FdNlUMBkLouNHz4q+eBTjNHqfocErn4WYbS8Peaxl1iap0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(3023799007)(10067099003)(11063799006)(18002099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YUyRiCiZhJZhw7TA95DjKC6iXFFeudutM7rfWerUrZn1++SiMmCLS5uErc5y?=
 =?us-ascii?Q?vCEsSJKTr465iEu4pD8RKZtL/uKdcI2aZ7Y/KWF2AaShjQ27eXz0dWjPawsz?=
 =?us-ascii?Q?RPgrwC/FpikjJLUICG3V2eok66ejNoM+4SxsSe4OXsnhTlBgOpjiV4FxbR93?=
 =?us-ascii?Q?X9QhJRA1k3305/TuP4LsICiVvqOVhyUlnC3FJdW5BJGgKHRCdR1YhFmip/dy?=
 =?us-ascii?Q?n4+d+2d8Z048p3EI+Qo/Fcivp06Xgk0iPaGRnhMCNOViyXTrXBHCtDWLP32A?=
 =?us-ascii?Q?OUxzDogz/8f/VDLE8fRo5dCtAP/SWKLmzZu2UKf5wiy9wD0uumWxKGss53iB?=
 =?us-ascii?Q?Nq5htcr8rCjGkspFFd5Mw6Je702Hth+5FoDB7RqWuO9LOu4jqAsb+ErKobXi?=
 =?us-ascii?Q?gmE1c2m+BGBP7e6pJt2CwsRy2AVjowRDdU8Jgn7/RLqWns/0DG+wVkT/nfH4?=
 =?us-ascii?Q?psny9E3jDpG4NHOwQexfg/FTPAyyTwE6ZQ9MvacDEi6hxRtF53jgCjZdHJrw?=
 =?us-ascii?Q?nqvjDBkw+qdxhLbUpkaHciJQD3fwmQQQcmHjxLtRt402GUserWX85EMUSc5O?=
 =?us-ascii?Q?ENI/CiHt6+xMxy5AoJ2UJJNsf3MesswK1V7viGP2WVgSFoUTgInzalbH+Z3U?=
 =?us-ascii?Q?pZGAGMrTbc9oPUkXxhpTut3HEQMHNWDYyynbqTLtwy74CJkdz9G053saj2Uc?=
 =?us-ascii?Q?pWL+jthlmbJGdpZp/PfH7OcCRzR6cxuPLq04tJLWdVz68NGhWN1rACDeUgZw?=
 =?us-ascii?Q?mzvY4BYAFgTNqEMyVEawfeDdB4o7Uv7uSC2PtNzuYtA+4mAis4HE3SoIC7J9?=
 =?us-ascii?Q?8sHAcnUIc/uXHWINqeHqi4jCor8RxsMQGT3YAmI7R2a9gYWptlzLBSujwjW9?=
 =?us-ascii?Q?C/mDnoL93QKEqg/UsxIrWuDpWAHeMbG6V+aSY3PvrClT67jvzBEYNYjKd6G4?=
 =?us-ascii?Q?fvO2MONG4RYikK0+k1gwKw+UQdM6JI+NjWZfFDpqf9qKCw1V/yxz5k7HwBZp?=
 =?us-ascii?Q?yyJMl97bIHQ+BHgjxw6C4Pj45ZON4xhhAuUzu7ji/ua2h4UAEr7tJYBU4t5a?=
 =?us-ascii?Q?Q8CX+Wd3fxBK46esLnDqFfr6BkTPrfPph9vT2lpmfQx3PtAR0+10boY6R16+?=
 =?us-ascii?Q?OLlPAupw9Ypib2ROmXMxHADMAeq1StxcRcPVOjux9JYqK8CnHiGYMZeCGxh6?=
 =?us-ascii?Q?1UjhA2O9YM3PVBByLmEyYjExmRYo3OBNVsB6WDEegNvnlHFXS5bTiwjIhEx/?=
 =?us-ascii?Q?dsmSfQi9qy0LhpoaUGsFPqYz7De6de4Vuk0LeGJZwmw9LYBsqiqOEiY4Umjm?=
 =?us-ascii?Q?8sNeC67gaOZ85PbkWR/UOiUrwR1/9xZeqC1y8vLV1vBhpx+uL6aiCX/FVPMh?=
 =?us-ascii?Q?zYtjBXY++XfQ1wnFJfzqTgOVx8GdTaB1wySXotJ66e/wK6r4AstWn49UPEdW?=
 =?us-ascii?Q?gPNbQfE5mnWPkHyAoe2RKndlIaZXuCzkCo7Ae2ObyNLLS2RUYKI+mZWBiuWW?=
 =?us-ascii?Q?lLNSZyA08DJw91f7yU270hzvgsdOjFFme/n4r+FmfEqOkUuqrj5HmZo1K3Fz?=
 =?us-ascii?Q?oH3avvB+eSfP39eHuvr+Vo9jQGIEBfhZGpK7eVYI7PAzzP3iGtJO5QZjMJ9B?=
 =?us-ascii?Q?SFvrAhtMJ3KNOzswIrykWp0weXrrqeX3eMYetmoe0/bMyd7Vf0OAqXuYce/I?=
 =?us-ascii?Q?V4crL7cqBZ8We1Ecow7cvySm4d4XmqL6vr3EI+yFLfg3L3jSbvN7r9ZBHh1C?=
 =?us-ascii?Q?PpavHWVeCQMxHqWb/S79bfc0ohF5bas=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 57803a79-35c8-413a-6ce0-08df0a0170d3
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 21:22:21.5218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EdL+a7ksDRuKtYMJ8KYe767Y1viBW4QJBhqpdGPyFAvlCIRp91BxBmBQQoqBEq/+bOhZipIty3WIHCYgw/69ry5KX2qBVaofIfed82bSSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8445
X-Mailman-Approved-At: Thu, 03 Sep 2026 22:13:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Currently, there is no way to programmatically fetch a persistent
value and use the result in the boot logic - the read_pvalue
subcommand always just prints the result to the console.

Since the "bytes" argument is now redundant and optional, we can
repurpose it: If given, instead of printing the result, the value is
stored in the U-Boot environment variable by that name. We do continue
to accept a numeric argument (i.e. anything beginning with a digit)
and use that as a size hint, but don't document that.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 cmd/optee_rpmb.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/cmd/optee_rpmb.c b/cmd/optee_rpmb.c
index 6f6c70ac084..06633758673 100644
--- a/cmd/optee_rpmb.c
+++ b/cmd/optee_rpmb.c
@@ -7,6 +7,7 @@
 #include <env.h>
 #include <errno.h>
 #include <image.h>
+#include <linux/ctype.h>
 #include <malloc.h>
 #include <mmc.h>
 #include <tee.h>
@@ -213,22 +214,36 @@ int do_optee_rpmb_read(struct cmd_tbl *cmdtp, int flag, int argc,
 	size_t bytes_read;
 	char *buffer = NULL;
 	size_t bytes = 64; /* Probably enough for most cases to not require two roundtrips. */
+	const char *varname = NULL;
 	char *endp;
 
-	/* Use a third argument merely as a size hint. */
 	if (argc < 2 || argc > 3)
 		return CMD_RET_USAGE;
 
 	name = argv[1];
 	if (argc >= 3) {
-		bytes = dectoul(argv[2], &endp);
-		if (*endp && *endp != '\n')
-			return CMD_RET_USAGE;
+		/*
+		 * For backward compatibility, a numerical third
+		 * argument is accepted, but merely treated as a size
+		 * hint. A non-numerical argument is the name of an
+		 * environment variable to store the value into.
+		 */
+		if (isdigit(argv[2][0])) {
+			bytes = dectoul(argv[2], &endp);
+			if (*endp && *endp != '\n')
+				return CMD_RET_USAGE;
+		} else {
+			varname = argv[2];
+		}
 	}
 
 	if (read_persistent_value(name, bytes, &buffer, &bytes_read) == 0) {
-		printf("Read %zu bytes, value = %s\n", bytes_read,
-		       (char *)buffer);
+		if (varname) {
+			env_set(varname, buffer);
+		} else {
+			printf("Read %zu bytes, value = %s\n", bytes_read,
+			       (char *)buffer);
+		}
 		free(buffer);
 		return CMD_RET_SUCCESS;
 	}
@@ -289,7 +304,7 @@ static int do_optee_rpmb(struct cmd_tbl *cmdtp, int flag, int argc,
 
 U_BOOT_CMD (
 	optee_rpmb, 29, 0, do_optee_rpmb,
-	"Provides commands for testing secure storage on RPMB on OPTEE",
-	"read_pvalue <name> <bytes> - read a persistent value <name>\n"
+	"Provides commands for accessing secure storage on RPMB on OPTEE",
+	"read_pvalue <name> [<varname>] - read a persistent value <name> [store it to env var <varname>]\n"
 	"optee_rpmb write_pvalue <name> <value> - write a persistent value <name>\n"
 	);
-- 
2.55.0

