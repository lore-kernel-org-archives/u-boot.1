Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD86606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WUOkMdFO;
	dkim=pass (1024-bit key, unprotected) header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256 header.s=toradex-com header.b=Z4Whm6kB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 910DB80D63;
	Tue, 17 Nov 2026 11:28:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QGxusULW4W7t; Tue, 17 Nov 2026 11:28:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3140480CDE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794914899;
	b=biNDuprKm84nLZvgAdlzKITYWEEHiiVq777vYQavm+81KM2SFYmKvVJbj0YGO2zLQL9b
	 n+dt3Fo6dp/lvlaGArgECaC2eTmT7e3198iwZrm4lrNKmwuP3OU70KPZgVPhAX/e2rMBf
	 t0cJAYpQd5TupdhSkSFnsq4RXp2/cvydXyWHkDHgBYuxGMrVDF/njnHKNZDkKDazLKIxk
	 3cBDW7lvjz9IKiSfD0Pu6NZd0PGnD/toIglfejPxPNiDtyGuwl4wsFVFtfzOujmIdAn5T
	 cW6QGac5SzfbSejTJdpzBLjIvXdM+zHjmPsvNRxN0OczQdOay1jWGPTXqd/EV76G7PQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794914899;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=drA2jGWvTqAU7JrkY0ZVrtYcadpb8BRbSy9rlSW2Zp8=;
	b=AYdFdtxW5LMaiOyQjqmVUb7WFpTRpBxgl5BQS7x612hvPVJCMKyWhII4t8rtd6k5ufai
	 cSdhJjHxeC0uOT2TTLts+pcGTNA0q13EvWD+7dC9qhoTC1QXnx78lmpbLOYiXqGzyBjSf
	 aO97/l+yFBrzTRCRUmBRj0H4Cd8R9I3q5wQvuY+H2GCw5UmEoD9ehdekGV7IbS79zb49U
	 mKAemhRj6bBG++JEG/nAG5KFHtR5SNF7HylTZyAhfJJ1qnfAd0Nf26wvO83f+Uv4DjbmN
	 5d7+XStRTVYHtSaeeqBffawsGqXWjJmULM5JHKO8vvakrheblo34Z+zLBSd9aFaonfA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794914899;
	bh=drA2jGWvTqAU7JrkY0ZVrtYcadpb8BRbSy9rlSW2Zp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WUOkMdFO0B6kQI2MaoFRh5FDzOq6PLVEeRSUDZV00qORRYq1QwuJ+8/wa3S2MJ7f2
	 WsoY4Ma9ZpU4Ze51N9Nt4A3xktDwBhYwfiUeYkLhc8KBvjnYFC5xszXs5wKUZyKvxr
	 yyfVrNpp9LZ7ZJyGa2TXjgoGRHG+fIIm0BZ8k7nnmBgsC8fYI3IEUigRfGuLDQNvCk
	 5UBTfyifZzdJbvy23mbevOphDu14sU4Jrv3ek816bEjPjrYTlLzMEGnk/IYff9KLj5
	 dXqdbppzDlKM1AfXAdxjEoIelxtcYH3U0YXR/5A2yyC6dCvxOLS7UIYMJ5c5qnsARf
	 4k3Ctu4xXW4fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3140480CDE;
	Tue, 17 Nov 2026 11:28:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 91A6770B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:28:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A05A40737
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:28:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Subn_7J0xm3M for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 11:28:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2675C40547
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=194.104.111.113
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=194.104.111.113;
 helo=de-smtp-delivery-113.mimecast.com;
 envelope-from=francesco.dolcini@toradex.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256
 header.s=toradex-com header.b=Z4Whm6kB
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2675C40547
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1794914893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=drA2jGWvTqAU7JrkY0ZVrtYcadpb8BRbSy9rlSW2Zp8=;
 b=Z4Whm6kB6JpKg2gIXF7UTvdxO9q5dh+tN5/yKHoSjHlSDjLZr6JIzistbPuODftaHwnnD7
 YoVFnFFjVcCUkmeVRzCZ6LLKzVqS+wE2E3jSyIWDFInG5/IXb2XuoZODW7tWGkudnJJVdA
 KuYd62Hrk036GcTGp0Y/0ba4ek/gnrc=
Received: from ZRZP278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazon11021119.outbound.protection.outlook.com
 [40.107.167.119]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-68-sAH-Ug5yOA-fzBmwYwAYGQ-3; Tue, 17 Nov 2026 11:28:10 +0000
X-MC-Unique: sAH-Ug5yOA-fzBmwYwAYGQ-3
X-Mimecast-MFC-AGG-ID: sAH-Ug5yOA-fzBmwYwAYGQ_1794914890
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GV0P278MB1877.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:6d::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Tue, 17 Nov 2026 11:28:04 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 11:28:04 +0000
Date: Tue, 17 Nov 2026 12:28:01 +0100
From: Francesco Dolcini <francesco.dolcini@toradex.com>
To: Sergio Prado <sergio.prado@e-labworks.com>
Cc: u-boot@lists.u-boot-project.org, festevam@gmail.com,
 sbabic@nabladev.com, uboot-imx@nxp.com, trini@konsulko.com,
 marex@nabladev.com, o.mandel@menlosystems.com
Subject: Re: [PATCH] board: toradex: verdin-imx8mm: adjust U-Boot proper
 offset for eMMC fastboot
Message-ID: <avw6QW3OO4Lw0631@francesco-nb>
References: <20261117101519.3952636-1-sergio.prado@e-labworks.com>
In-Reply-To: <20261117101519.3952636-1-sergio.prado@e-labworks.com>
X-ClientProxiedBy: ZR2P278CA0068.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::11) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0495:EE_|GV0P278MB1877:EE_
X-MS-Office365-Filtering-Correlation-Id: c45bd816-3d45-449c-6aaa-08df449dd868
X-LD-Processed: d9995866-0d9b-4251-8315-093f062abab4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|41320700013|1800799024|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022115727099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003|3023799007
X-Microsoft-Antispam-Message-Info: JQinnTyT1OXppvsRLlypeTuzwjyM+5sPcWrjjlO4CmkO9QKS/9ZPEQwnAWqlUwYpKLcl7e18+bmzsGXPGyzfsVQC2wLbrXGYveTNxaPWxmIWFQdd4bl4R8z/clGdfAWTFdnBmn6NY9Ydrd9sN+BOUVCiOt2yWzVC7ZiMVdMkMU8CfkTxxXfcphzDZZQJqF/lzTP1K4sl5iunylu8ELPgFdXZfiGWWuA0G+hIZ5uqKtFqKMz/7majjn6QZSM8tTv7V0MVhAfT1ilNvmowkJqMuegtZfJ9MMjYFlswy7+UZJx26Yn+RaccqKP+fecuJkeUkWDNPDS7JL1Upd/n6/dfTel2ul0SQE94M7MA4j02b9QW9lTeSUydM9tZA9p+z/ajU/i1HpA0PJN/RzrSQ1gO9OYUOH5c59E5NitvG63tfGfFcCejah3Bk6XMgcbUovF8wYMI9PUyO2j4nuTlm8bGewXzkW46aYuXL018p0KeCNJGTS6fAaG3CGreEvEBp1mBbeAochT+B1axrltXWbuFvwdzbUHYm0V7IOZH0UTyKtkVDCZQTVJLYRxk73gNglmEk9Ncn6+e+HH4/L85r5AWmFQXCcq/yNnxBQpmdjnfBEN7+KHymI+sQZAi7Jdff0wS/LsVQmdCB5tO5+MdZ7Zhud7IWXrBs/CxGaVqinVGEZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(41320700013)(1800799024)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022115727099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ldTqMSQw69vZpx8uUudnOEe3XiZ8ofcZTw6CoyLNz0JUs8IArrYgBxg8v8hH?=
 =?us-ascii?Q?OhMDGtXJmPpYyfwhYviIOnzLtdh1iu0A//5mO2IeCe3KOE0eFSyfNPAZujRX?=
 =?us-ascii?Q?OmAatoXiwxWJto9w30DRWw9ZiExDzpuYXhf2g9vVPwgclWRlzwbkeo9VFCFU?=
 =?us-ascii?Q?BPNOYLkmNCi/5+gtx8I0SbHX9H1FB5+WOLFVP/orXF7B4jrz1cNMkj8ORnhF?=
 =?us-ascii?Q?e7u8mebSJ+/NA+MMyuIyNqCXr3FLm4+BE4c6N87M25r+v0QWNhYkxZJQ875w?=
 =?us-ascii?Q?0X8Gf4hz9C2EFFd7g0yMRZsqS8XAsUOIfYgBdAARC4Q4SU4thV3rjM47MuoT?=
 =?us-ascii?Q?VXTkgnPqjHKeHmfNmJBS4bSDMy9M1KT4FvCF09TbEtHWmJ57nGJaNCfxTz52?=
 =?us-ascii?Q?p+8vQ8pM/WlFNZRop+sZvWyqTQGJ4cXqshr+eO1bC27GzDAroJYGEkuc+LZr?=
 =?us-ascii?Q?H7eyp3WQMNTVOkW9A10LNUGoNoViTEnH2y8gzEr9RVtNFczuf3vdpUOk7cFH?=
 =?us-ascii?Q?GcbKlJedXq5WnwfRBwU1HHgzV15hn9gnRt1HWEVe5Set6iQntzCz+Kxz426W?=
 =?us-ascii?Q?mgtMdgYVrSSvpkLeSo47MfYnwif9wNkhSI/1HcFuMhZM35lje64eMF4cqreG?=
 =?us-ascii?Q?nlMe3M0ectZttQLqF8UDwxCAQrAa9y3i6pn2NtlN9+DjUIp09mTn1FiEQdUw?=
 =?us-ascii?Q?zyfrmIjIrdXzIOuAQdPkbgZmt5K5qL1/8o2J95BCtnhVU+p05I2KR1ubSUML?=
 =?us-ascii?Q?Vth/KUiYWph0hqqmKuw8Sn3Q3/2WvNRrZt1/yHZ9vhiSvKdF1Z4C4UUZG4TZ?=
 =?us-ascii?Q?RPDtxO4lLvu6dvo/Hg+CzNB0MEwqPWio9MXPIqehNB5dEnxDCNtsQuue+Bi3?=
 =?us-ascii?Q?sX1k/+vrkT4v/C6l5EVyUos8V2xqJBaqdgYGsNyzng5csWGn0Hnfrux37mQb?=
 =?us-ascii?Q?ClS1lNPxkGdINMa0lFp2LptLofIbWpVD5SH0280512bjbvdBK9JDfQGhNmM3?=
 =?us-ascii?Q?5Pimhs6NjFvsHsFVL281L9m18t421FRf7BKHv2Gqwb2voPoqSlwB8bb03j7+?=
 =?us-ascii?Q?v6aHcEnRezUvIpZKb+79/vtyEw8rRAEerrV5LhOrO+bFsbC9Lyb2uGdfcE++?=
 =?us-ascii?Q?DjgqyjmBKEV40v8zsS6uFFeCrVlBMGcyc6mx07W43uIcrjyYTa1wuKWZuIfa?=
 =?us-ascii?Q?Vi5+FE+7HeJmLNrSuGzFQjqMGq3mfatn1Nyqx1k5opDR3ghVhc5K9thTXRqY?=
 =?us-ascii?Q?xay1HnVpBcrZ313uPMKaXZhJa71eN32kD56kWTSfodPqi8SZkuoSXBJxGPIE?=
 =?us-ascii?Q?gCaQ2rUgO6+Sn0lA5SMh/kxTWhCqZGEpMk+kV2+P0DeFpLkqRPabExiwNa6N?=
 =?us-ascii?Q?2oYAevjdlOj/o5jmgI8SzsspUxNmpMd3b4torN1SdOuV5SKgCpYvUG8BbDNz?=
 =?us-ascii?Q?VuTLQIWrsp8l+yLknQT7aK4IZQUWkwh8zmAMVMHxlLi0uie+5AZhQ7kpULy0?=
 =?us-ascii?Q?pFqWK6vwdCeCG7Cbw+q9JbnVEwa/tQbcq4CCR2w23+Szb92KFQ0y0cJTVdSv?=
 =?us-ascii?Q?PkF9pPgdlaJhEktqs1PjrtAea/cDCrVIfBMTxh0Hc189EV26ZfDvSlP54/qQ?=
 =?us-ascii?Q?htF+peett+Nlc7uXIv2vswxmpvmp4ZWFYi4YSf0U4jFWH/x60xvaDDFri7J8?=
 =?us-ascii?Q?PctgK+Llu4tPMlBNvLMjYUXLVyxbDPLCleyHtwn+EnfquM2O+wWAVMIzpdq6?=
 =?us-ascii?Q?OnzDzE+7JOrSyt+NuAsLRt6e0QQ6SsU=3D?=
X-Exchange-RoutingPolicyChecked: ksjwGMHqCtYm9I7DBDU8V95dLsFdr/BFjdhukFNVEX5SRjnvBB8gRdqfuxi2p/jRNI/Q1ufBzCxw/v/klffwCTkEjbJ9u6GiALyZeNHWUB3GlseDsZcm5SO3LbtsMSL2nIV4BPTeciYYOz4iI2UhfTrUUVR/5P65e7e86ajHayFOJrLbdY92JD3ZjCkyDntE1DMComl66hc8V6BvWavcxdTqglOxcuqrvubX0AuXNKkm5AA/VnYA5MVNrTvNq4i+MJ16To2C7qPePHcXyTUE1X7Ib9OTtbgSkspIC0Ltz3MpKhXd+2tsKenwpXcQCQQzuzvTFt+pC/iBFzRJBvhuHg==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c45bd816-3d45-449c-6aaa-08df449dd868
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:28:04.2335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4S9R8FQDJta3IAvyJDszhr+IfQ1m2Pq5ngcGvtauhRsd0u20W0xRDWERmPuvkdLAAoGQnk28/FY5ph0Gq5WPkvMVoLld2XBrkqeTUyajW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1877
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jPb2jJf9ld3l8j3aOdMjK3S0gqKvBTqQrXhX_puC3wI_1794914890
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Sergio,
thanks for the patch.

On Tue, Nov 17, 2026 at 07:15:19AM -0300, Sergio Prado wrote:
> The Verdin iMX8MM boots from the eMMC boot partitions with the eMMC
> fast boot fuse enabled, so the boot ROM loads flash.bin from offset
> 1 KiB instead of the usual 33 KiB. The SPL loads U-Boot proper from the
> fixed sector CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR, so the board
> device tree moved the FIT in flash.bin to 0x5fc00 to compensate.
>=20
> That override only works while the fit node is placed directly in the
> binman section. With CONFIG_IMX_HAB, imx8mm-u-boot.dtsi wraps the FIT
> in an nxp-imx8mcst node with its own offset of 0x57c00, which takes
> precedence, so a signed flash.bin has the FIT at 0x57c00. When booting
> from eMMC, the SPL does not find the FIT at the expected sector, treats
> the data there as a raw U-Boot image and fails to authenticate it:
>=20
>   Authenticate image from DDR location 0x40200000...
>   bad magic magic=3D0x75 length=3D0x206d version=3D0x63
>   bad length magic=3D0x75 length=3D0x206d version=3D0x63
>   bad version magic=3D0x75 length=3D0x206d version=3D0x63
>   Error: Invalid IVT structure
>=20
> Adjust the sector in the SPL instead, as the Kontron SL i.MX8MM does,
> by checking the fast boot fuse and the boot partition, and drop the
> FIT offset override. The FIT is then at the default 0x57c00 for every
> boot medium, with or without HAB. This also applies to the MX8Menlo,
> which reuses the Verdin SPL code and U-Boot device tree.
>=20
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>

...

> +unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc, unsign=
ed long raw_sect)
> +{
> +=09/*
> +=09 * The image offset on SD/MMC devices is 33 KiB, except for eMMC boot=
 if
> +=09 * fastboot is enabled. In this case it is 1 KiB. In order to make th=
e
> +=09 * bootloader universal, check the fastboot OTP boot fuse and adjust
> +=09 * the offset.
> +=09 */
> +=09if (!IS_SD(mmc) && (readl(OCOTP_BASE_ADDR + 0x470) & 0x80)) {
> +=09=09switch (EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config)) {
> +=09=09case EMMC_BOOT_PART_BOOT1:
> +=09=09case EMMC_BOOT_PART_BOOT2:
> +=09=09=09raw_sect -=3D 32 * 2;
> +=09=09=09break;
> +=09=09}
> +=09}

Why do we need the runtime check on the fuses? verdin imx8mm can boot
only from eMMC and with fastboot enabled, so this runtime check is
redundant, everything is known at build-time.

Francesco

