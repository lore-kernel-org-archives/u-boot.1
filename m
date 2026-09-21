Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38E9C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 11:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84A0F6071E;
	Mon, 21 Sep 2026 11:26:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nQPLDXkd-YTS; Mon, 21 Sep 2026 11:26:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org ABDCD606FA
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789989997;
	b=NvBM/oUF/sm3gvqrcu3iOLmjLi8wzk3FDUTYHyu/q16w2RaScS3w2OJPurQQA19uLOqP
	 05TQ4OwCxSs9minVp9MU6Z3GdEj1Yh2BfhVUWqSiJJkZJfb90WJf64IwWNwiNG6u5c1wj
	 at6Fgb/PhLstvbLIShqHSkPRUXRog4IudlA7OaAtSCNe+Jul1ZybcYNWEYljmzy/uUPrm
	 610nEw0/0EDhN8ObQumbCBBBXBUKJh5sFfg/tIoxyhSuh/CFRImbqYVXZgwzD1xuNemVN
	 rL9Mcc0xJ0SNWI2L0HxfPkM/V0oiYXnuDrVYCJZWSbmlGTWr3expDwlhBjFWQK1ctQA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789989997;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LM93AqoXI5d6z4PcEEEAQgUy/09/qTKB4cXDtycihtM=;
	b=GXDZXtfYHujk7euLpxBXzxE86UWxCculeyyZBGG4Ceg7bJwSeqAbYNNF17U6Xw6lCWBV
	 Ns184rwxZzh2DuLbWc93z3CsrnCYMnm60SJB5TQlo2IFWvKXGD/lbPigOVMnmlxU2d6Px
	 To8vEy7qR1+qt20wJE+gHbzJGaiwtNv/9bMXUBT3YQ+KUQm+D+Y45Hz783lfc2SpANa5S
	 k/6Q4nCBCoPBx5RK8d6JwpRHlYeNw4JHOGKETOLY4tJkWcDPKOQDWxHRUrJ8kghb15R1a
	 WuiwiIwdQNqRGadi19Cn7RpVQoV8o4MOPIF9pwCQMiG3YOjljCysIrEcayv32sfw2YA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789989997;
	bh=LM93AqoXI5d6z4PcEEEAQgUy/09/qTKB4cXDtycihtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R87vwqCtMr9Q/3tYZApOzzJMSKjysyxlYJPccPJVc5TkQ4TxqDVTZ0X5IMf2IwhD0
	 B33IurOK8vWRwhzjBH/3m45WeYBjjIrWpyErvR+IaeyoV6j3VpeLjf/r6NEFQtn1W6
	 dkf1mpZ+R3tT0fSmFTAyNNLWQcszs4iL331Ukx3xNJVd1f+kxmmdyNdksXuR2452eV
	 lJM2wgTuXeaVVqgmmd2rmZv0bsHHMYlGBDf7oP0klF4zMqAul6BjnupeqvoMYbOCaC
	 IcqqLwjKl6jPBGb6uVlGaBJu3kjfmGRH/VBPXlgWOaacLO6NYm+0TYhTRpL08tR3Fc
	 yiA3hikt2ptlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABDCD606FA;
	Mon, 21 Sep 2026 11:26:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B2E4392
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 11:26:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E598E40111
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 11:26:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pHVwFX4lvHjk for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 11:26:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 285D540129
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789989990;
 b=iUWEb6jSxNVigymbwSANAuLZd9DWVFBzvBVR+t41AIN73TVyD3ioWgYdMY+AUWdNqias
 f0WmVPyIkRrJ5O7eU3g+mM1UAahsh4Kn208H7ab8sG9Rd0R5GaaEBmEhkIi1Sp5ynFhAC
 wz+e3PiKs+6VUcf86RYNIT58JaqZXNWT6eGBSi6rJ79eY+XzNHYjpWHJIQ81FZxsn1p2X
 LwjawY3uCYmRUnG88ZceKpReLRJbbyKtO7kYudg758fLvMfWe9DySES10yHMivBYw0gBi
 iZ8FjvkFet6cKZ6zj4DLsoQYqwkR/Gv+9Q8AcSDz0UCcMie3+XtAov3nuXT979s/wmA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789989990;
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
 bh=LM93AqoXI5d6z4PcEEEAQgUy/09/qTKB4cXDtycihtM=;
 b=F4oqC4SYjmTHHgaCmNUC93iKj4/rs0hhLwauROyeRk/O+3nmOHls1HwDDJIOEuKl6npL
 EOrA+LArUT/Ryx0SsDO7Wsrb2UvQ6BbcmHOcw7g1fZV6OmidzBk3/A61mSid2crSfAHpv
 /UYWlA1tUEg+mHTyexuQf6bpAsT8qAIf6XILWyNEgMxfWzZQDpWlV/8uHuWfKH1/H+luS
 aHpFjLyNh8sqPgiOnAhoxQb/O0yc2A23nxoIi9/O+gpuvfW2d48zMH/3bf9ub4sGCe/NX
 EGCobsJrqneYbrECwSdCyyJgqbe1lJAv1hJqmKc5FMntDWuY2OYUN8z5xaCrwG9o+Dw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=prevas.dk; 
 dkim=pass header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=BfLcB1bA; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=BfLcB1bA
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 285D540129
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 11:26:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acH0Uv99YiyeNIwMJcZJWSZ0EXl/UIVTj5wzOYgCeVOU6E8H3hlqqQ5HtmgJyfzBnVzBlC7YRXhMNTmM3PtNNFkf6LyIgfWLPUeehl/KD1nelbzHwDIZkotMmOYjT415TygEf6EHEXOlTGJ9rAKs/93J1ZVWuWHtqnJKtOlx9bB+9+amr8lzNnJDoHLHSjrmmcMQ+SUcnJZMPBh03O2rA4a/A2b54GT4JaQyUD7UjfXYzruInrQcPKV3XK2Y/NxWolGBbga3HCPb7V3dOE8jQNZ89l3go/QecFbj98w27lRncm5KbMjbyUqxnCEOIf8w61ND0K0Hqefm7fVIzRJkEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LM93AqoXI5d6z4PcEEEAQgUy/09/qTKB4cXDtycihtM=;
 b=wqjFZAVZopBanTNyPmqU2vNbpMzn6B0O70HBInyMtgvc1nOlZ1OxRQfOAMaPXkNrkEfLtjBHRG1vE1vlOiXNtQXJTFhyOVEqBnKtmkpd7IRg6/Eqw96B1kg7KEf0/JYpmVHK/34eJh1HuTlMwV3KaTdqWjpNeds+XDGHfDUP6DzLW/yaVajYCrVg43zdeK2nhWpypZUraQtmPc6BTEuG5pCVuHmySOOCwCS9OEjoiLq9tCO9ivpa7R9awz3shNNjk+bqQV4nwUaMjOz84JJx/C0v48evxk4t+RMAkPxMwDi/e9naOtmn5dUM3WTHIHJDhfU3/pmHYXcUzD1YRCEnaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LM93AqoXI5d6z4PcEEEAQgUy/09/qTKB4cXDtycihtM=;
 b=BfLcB1bAoSoiVgQgUQfcIy5ZLA9xW7ArM2XUUfCc1yRvdHzwRw3OVaayBlpFj6li4WvJrLDe2FUmpntQkbbjLMK+tEL+8uJtVo9mIpvuGb7h06CMBq/xK1h9ZlBXkrTwYqLzv/8vdM0GKycqskws96RkEGr1IeGm0ebALVuXEfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAVPR10MB6863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:323::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:26:18 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:26:18 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3 3/5] tee: sandbox: support new
 TA_AVB_CMD_READ_PERSIST_VALUE2
Date: Mon, 21 Sep 2026 13:26:05 +0200
Message-ID: <20260921112607.1562189-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921112607.1562189-1-ravi@prevas.dk>
References: <20260921112607.1562189-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0013.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:2::17) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAVPR10MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f14ad3-a9fb-4aba-9a1a-08df17d325eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|56012099006|5023799004|11063799006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: NgstY+GTQ7chS5T5dHyUHbHWVbYXqiKVU/plEh/m7ZaZvqf99ef50K2ivDrjm6QwjmRBCTamYD+lp/oxX33Vw3bEf8TmzJ/rNDRIvSjkTMZyqEp1vui5MJf4NMrDVD2WcPzOV6JcL50NyoffnsrrXy/VDCwooVzNkOkfLFGtOePLNvIbpK/jpkzRKxBhZ1tYOOcUkWfgu440ifz67iQ9hc6PS4xLHXDkRFUVRC7OZ8MS2BwtZB182FOlW9jDFmRlQgxf62XrtIpS9NEc8NBYFFcJ6uS4finuRuYw4Rju98Es5WQXWO1WXxOizQBiFXSY+AdeX+TNXbyKOW4Rplh9CCzBuP4CWo73c9JsHxE8hOQi7g58I3VMDp0LTB+hmHDoZ3zkJ6z+JpThApb1bm9E4blBvLXr/8EO00TiL3sLJBRVIqXvOi8rjg4BaSbfgo2Mz3Hn2CYKkFzz3wfVXvziGEQwHipOH7XP1ERPgsZnK5qD2WLbDfm/EBIW3vWxeBewv5Xerq8R9IpZDczFXJn32wGs1PZDcWsI3iI9KDEsSTMCWlqOGifbFqhEZDmjy5hatepXZCJUI1dEwULsNj+RJaInVni1j4s1SQprsYXpISTGrGPPrwUB9PUv+UyPQfOeH87r8Ji3Nylk7I9V+uIHyWZ6i8SZPM5VKWEDMJZnxuk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OwSS7+21Xb3/2w1DQ7jg/Ur89MEKCnBqRC+uEKIIOplSVNUviwZbHbfO/1D5?=
 =?us-ascii?Q?iDtVMtURZtfHgKcSLgA+SeypXdseJN75HUGDCUdXEtZrP00pL4C6gu5aTpKf?=
 =?us-ascii?Q?3rzcBbHvErQtIcrNqnQX8TtVpOw1Jsuyww3SjlSJcUwd3tP5QvR7GkzUcdMS?=
 =?us-ascii?Q?C4x5PpWR/To5Bef5ual6ko6z4qroGh1lg6ie4K+Y1LXa7BGkgx9xmCpDb98/?=
 =?us-ascii?Q?xk99I76Gv1z1i7u5aILqnqG8lMB5EuQcXhl18V7+wM0eOCkwWKjV4kX55I3F?=
 =?us-ascii?Q?7tz/SWQP1nJRt+IscVVKnA2YZuM3A+4cxa81RVHalpHNyizB4ktUPcyrzSp2?=
 =?us-ascii?Q?nG7/K1P0yCe2JmgTqa6dk6j1/4rFBdMzZi+u6GoPy53sGdlVKkqnk32bQ5Fu?=
 =?us-ascii?Q?SaNbFLkGNMWdJsZZjDZaOx6VvBAcksHYE4R4Dj52y+LX3oNecYV1ZeSYldCY?=
 =?us-ascii?Q?cDkKUNv40jTaqi1K16NJ3SsFOpaedwJzP0JwIXDgIVGQh2Txu0N6ZfV7VQfK?=
 =?us-ascii?Q?LrMVZQcm/A6dUchcPLrJqPlunezsDMbgaGYkBBlm9QLBPn7ALVnJy1fH3cdt?=
 =?us-ascii?Q?gydP6SldAYUs5R/NF86gjP6uEUKCNiGxNMzo2Pq7u71gI9JMObe3znNF5P0A?=
 =?us-ascii?Q?wYx51b6gQpZK9/vNibXkdNmsKaiCmDitMaWQd+j16zR+RueJ5SLQXXiEMeGy?=
 =?us-ascii?Q?D84fIw1k5ZloAWTqjS8G3lbvxA1kwTnSgfCmK6UgDpO4RfnfCcRU2r+kBwJP?=
 =?us-ascii?Q?l/frdm9NkbEnkPgwrvxcr68q0wEdf7WDmeztP2WtHiy4rwe0DLQ54dgLU4EA?=
 =?us-ascii?Q?aspIBwCS9eBBXFIuv7rsw1f+Ga+0M6tyR1g8ab+MrRnwyctNbDw9HB5/4Mar?=
 =?us-ascii?Q?IsxOJkFYoJpShixfjiQhif2D33qPHDUKA9Ry+G+OHlHIB0cUc8exSOtGtKn0?=
 =?us-ascii?Q?cEgwUfpOCpsN6ANlplDsxu23Oih/mTL/lYXFY9V7oM0bj+fKqapmzFpFm43w?=
 =?us-ascii?Q?FDoUUvEFpIzVe9Xppfvg5VO0ph/h9k+ECkq7xkhh//tD6MoI+lsgCsWVdShZ?=
 =?us-ascii?Q?OQefAZWf8WudfONIOvyex0zF9roKOl+sg+uJfH6ugU8G+nLZEgOsgrdRzpTu?=
 =?us-ascii?Q?uJ3Sez//gEyOm5ZhgulEmZ4AOvnFyX7156avfKdO0QD+kf6biVIhqxE4IYks?=
 =?us-ascii?Q?6arBXywwq/0WQx9Vq0CpQ8rzvmlzv1qZDu8paHXbyFM/HdcIUfmoVlc9LYZF?=
 =?us-ascii?Q?4n3yIF74RFYS0FWZbaFEvdp0RLpAHeWQRTTMG4tigmbveUVyluBcPS3uS40O?=
 =?us-ascii?Q?5BP79U1dt2t8C1Vk+JMDGuiVFtFnDsSyOhbvmjralEpWC0cH0PnUQRPFqBJY?=
 =?us-ascii?Q?CiwPfxAGIPU1gxjPf4x5SaWCWluXY392fCbSjDifRzXTzFEMBNV4e3fMb8LO?=
 =?us-ascii?Q?L5CVEDPhUAFDEWHjkRW82XqW1k8pij1vtQC4Q/Ugz2ihnApPVdWkBlCBGg/Y?=
 =?us-ascii?Q?AImYSP0PAVqKNGi4RaVL5m5Hy/kN8HO3nK64k03s/HdIV1VKxq41p73PKNay?=
 =?us-ascii?Q?c/6+qhUQjOS5gqy3RFajBUNto+Ikd8xOK9t2387zuSQgyZ2sTcy7fYT3Rbvs?=
 =?us-ascii?Q?knURHDqn1BWsUfeHLO0zlGggLoMqD7a7jPlBzbCc8zsBTujQ6LaI8wNdggkG?=
 =?us-ascii?Q?fUHZ7wwqsY5Lmybhw79ZA19myV+kmpltMfNpybNCbNiIzCd3VfT1zICsm7T8?=
 =?us-ascii?Q?ZoyNrhs/x99NPhCu03D5ZEtEebTVoug=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f14ad3-a9fb-4aba-9a1a-08df17d325eb
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:26:15.3181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTGG4jpNuTMG55sE9dz2GjnRk7XjKYqWSZdy6oH6FwhgzTknBbL+svTic1BIMgAiUQ7PmJY3PR78FwXfRJrEsw/myryIqJPetvuPzWJwmLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6863
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

Upstream optee-os has recently added a new
TA_AVB_CMD_READ_PERSIST_VALUE2 method, which fixes a problem with the
ABI of the old TA_AVB_CMD_READ_PERSIST_VALUE method: Callers could not
know whether the buffer they supplied was big enough, or whether the
output was silently truncated. With the new method,
TEE_ERROR_SHORT_BUFFER is returned, but with the output size parameter
updated to what would be the correct buffer size.

A new method was added instead of modifying the ABI of the existing
method, as there might be callers that work with a truncated return
value, but which would not be able to cope with an unexpected error
return.

Commit 8800cbe9b83 ("tee: sandbox: check for buffer size") partially
updated the sandbox version of optee-os to have the semantics that the
new method in upstream optee-os now has. It added logic to also return
the actual value size, but only in the success case -
params[1].u.memref.size was left untouched in the "return
TEE_ERROR_SHORT_BUFFER" case.

Align the sandbox implementation with optee-os: Silently return a
truncated value for the old method, but do return
TEE_ERROR_SHORT_BUFFER for the new method while also updating the
output size parameter.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/tee/sandbox.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/sandbox.c b/drivers/tee/sandbox.c
index 86b16a3bb8d..16e5d95616c 100644
--- a/drivers/tee/sandbox.c
+++ b/drivers/tee/sandbox.c
@@ -248,6 +248,7 @@ static u32 ta_avb_invoke_func(struct udevice *dev, u32 func, uint num_params,
 
 		return TEE_SUCCESS;
 	case TA_AVB_CMD_READ_PERSIST_VALUE:
+	case TA_AVB_CMD_READ_PERSIST_VALUE2:
 		res = check_params(TEE_PARAM_ATTR_TYPE_MEMREF_INPUT,
 				   TEE_PARAM_ATTR_TYPE_MEMREF_INOUT,
 				   TEE_PARAM_ATTR_TYPE_NONE,
@@ -268,8 +269,23 @@ static u32 ta_avb_invoke_func(struct udevice *dev, u32 func, uint num_params,
 			return TEE_ERROR_ITEM_NOT_FOUND;
 
 		tmp_sz = strlen(ep->data) + 1;
-		if (value_sz < tmp_sz)
-			return TEE_ERROR_SHORT_BUFFER;
+		if (value_sz < tmp_sz) {
+			/*
+			 * For TA_AVB_CMD_READ_PERSIST_VALUE2, reject
+			 * a too short output buffer, but do inform
+			 * the caller of what would be the correct
+			 * size.
+			 */
+			if (func == TA_AVB_CMD_READ_PERSIST_VALUE2) {
+				params[1].u.memref.size = tmp_sz;
+				return TEE_ERROR_SHORT_BUFFER;
+			}
+			/*
+			 * For TA_AVB_CMD_READ_PERSIST_VALUE, truncate
+			 * the value to the given size.
+			 */
+			tmp_sz = value_sz;
+		}
 
 		memcpy(value, ep->data, tmp_sz);
 		params[1].u.memref.size = tmp_sz;
-- 
2.55.0

