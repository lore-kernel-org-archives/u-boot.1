Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A92606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RoTQoDBm;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=oXL1DFEY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E94BE40AC8;
	Wed, 11 Nov 2026 13:14:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T4et0qU-ZB6J; Wed, 11 Nov 2026 13:14:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1395340AAC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794402855;
	b=h4FgGUT0RXp8lo7OQqX2XGb/cJEc0In5b6vGStsEtcoJ0FIqXjt+OuQw5jmrNBnLqoki
	 EOLlF6EiO3OKH+yjSvsfsekLy0gThRpq/8hMznPsC78Fd5hwANOVFy6DMw7iog7dc+1kY
	 0EdeyIBNttvrmsl9ndjb5zxgxz8Dje6TvamHr5iyBwKlrRXv201GoDyvzxyYjh+noWcnW
	 JLG3DstCjxUcrYLFGcEnYGZC+kBGrnzXFbBoUZDUvtD+xhPhA/uYvpEb4QDBX2XT7rwFL
	 PGWTVnR/NqqLpvnDtNZLWZ/ePrd0jrv/9lbkVkuio+pTqMZNoJB7AzLoHoRKVK5J16A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794402855;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RugHn2EVRgIVBB91GIrBN6hGaQhBbD1K3/i77G1mjgg=;
	b=cOyuKFtlTKBzAtx6m/jONFmIVS7zc5XPH66RpZU/xn4g/iqq5AtYGuUX+0CN4JW0oQE5
	 FooezUPxJNDFzQtb3hz/3UwaaAmDUqyZ16IKWfiBZdNdwI7z9C0WbL6wveqoANX4Salzy
	 1+M6rFz30zuDGBn2QgzLDC+BrP76vsDszfhUH+Fro1Fh/oLud6Qk3dbiEGT+u4z7ksWd8
	 D/xTHtFaap0dneIT+ebbXWT1ibGT9IN5r2gzxfJ0mifabUKLjyFPizJwatFzSQO9afTWK
	 aW0RnmK5Ye1h9L2DiQDfH5BOwNWeLWMHnokszYgyUg4JicyQwkOeIG/2pooLhydYeIg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794402855;
	bh=RugHn2EVRgIVBB91GIrBN6hGaQhBbD1K3/i77G1mjgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RoTQoDBm5is3WN3sIeWenCJ9L4KyXvGvEi7W/HVp7LFYy7ee/qnywgdlrqZUHYsrY
	 2/LPrryNphgx7xoGtXB0nubHivuAnmDx+usPghLljxK5CCWf0ayU4MfqrsaiYYxSRC
	 r0cWa0b0uLsdLOfIq97V907j9Q25ixZlKrYHxTPiPk07QoBh+jcq808Du22qURrHGd
	 2jyk+an9m+5/qH+hAWe6x3w/6+WQgP2FjUKOPpRsVlmUTa7QS1jXTCtqX2Ke7q3RMz
	 SgcHmAdnaMy+RKnLYM1XSAEVAs1hTKlIYPMxRSJsyljr6rPlSwU5DdLGD+JVk/SBUc
	 BowJB096yApXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1395340AAC;
	Wed, 11 Nov 2026 13:14:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2166C28C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 047F340070
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:51:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ifbwKRjiqghX for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 08:51:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 29E1F40318
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::9;
 helo=ph7pr06cu001.outbound.protection.outlook.com;
 envelope-from=tze.yee.ng@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=oXL1DFEY
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 29E1F40318
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 08:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RugHn2EVRgIVBB91GIrBN6hGaQhBbD1K3/i77G1mjgg=;
 b=oXL1DFEYynCube9Wq0rp+fpl9kdQTyfdXlp0nHkRCwTTENd3exmVYbVW7/ePRGR6d5pz9CuEvy71afkB/1aDsnbivSABbiaEgiXvKNTJw+kS6/hejeRyCojIOrbhh+v9Wc9KBJBkcY7RO7mmG0fhR6tc4CwjXuio9M162E11E8NoWGbj4seJ7nSC+F63K7/zAq8cRAOFgr8O5ul14MobRo0A9Ow1LbvArzgRLFbv0ID2gxj5cLTGyBJYkZ6xizS+/BwkrWPmgrf8F3a8DT9Z8bDhzkLEcF6Rrei0CgU2ANUT2OOQTtQ51km7oFxwy1nsW8FeXSUSFFJlRcjozL3wMw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by BY1PR03MB7851.namprd03.prod.outlook.com (2603:10b6:a03:5b2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 08:51:09 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 08:51:09 +0000
From: tze.yee.ng@altera.com
To: u-boot@lists.denx.de
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 u-boot@lists.u-boot-project.org, chen.huei.lok@altera.com,
 alif.zakuan.yuslaimi@altera.com, boon.khai.ng@altera.com,
 kok.kiang.hea@altera.com
Subject: [PATCH v2 2/4] mmc: sdhci-cadence6: name PHY and controller config
 table slots
Date: Wed, 11 Nov 2026 16:50:54 +0800
Message-Id: <20261111085056.15418-3-tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20261111085056.15418-1-tze.yee.ng@altera.com>
References: <20261111085056.15418-1-tze.yee.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0080.namprd05.prod.outlook.com
 (2603:10b6:a03:332::25) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|BY1PR03MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: 24548f7d-ea5c-4173-c6c3-08df3fd0ee31
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|261009223027099003|11063799006|261021123027099003|261021121427099003|56012099006|261022075727099003|261102123227099003|261026121527099003|55112099003|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 5oEoTF0YTdyMaAdjB+48vtGsSVt4RMiSGQAcNEQCVdzkrh4gOZjUcCX4eayGWs4ftmHyvPnZ6Fu/8aZ9mK/3dL1ADtHdhQOvt+oiSF32BIUW2zCgroIGUYOyv4ID0qDBtSOSzRdCUgiwrp9HkUNCT4pZbl3hisP2zcJXFrVd+sP68MlHjSXovvtf6eUu8uLHbebIQZzfTCcwt1CyNRdyqPhozTDbY/T54JmJteTtCawOplcOkIfVlJwo6o/LFRaSvvYGzTyibThB1OWJIXwKp+cSKoEym/WWb+ArHcgvnmwM0cQbvq3wyuc2qnvuA2649wwKSYbNho894295RrdDGqN9KoJeoTof5YByKxyk/DYDVZJilTYiQMJJsxFZGS5+4KnvzZYr2p4G+gyCPlv9rSM+gNeX6q5bsS1Jcdh6xzYzEzzwIT5BpzYly5zfqgsydxK1quj6Ca4UNn29L5+mvd+tS/8TlYkRL6B3bTuB1dmtw6qYaQgp4FFpG1M8YsmnyuTVgYFCOHkVI8xhAeLHM4f++XedqyfRZPwz5qgkSeqhrYXkpxN2OL+pRmNZoUoZVea8YzxBpF4JxUF/lvstJcLjs9y6cWzIQU5L0InqL08T5eh5MMrAwyxJxp/92ZDTLqVq/DHdrRr5b/9lv9eQwYp3iLOYE8HW/7CEE+Sw/Do=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261009223027099003)(11063799006)(261021123027099003)(261021121427099003)(56012099006)(261022075727099003)(261102123227099003)(261026121527099003)(55112099003)(18002099003)(22082099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kTEvYPVQUohYo9BKr7Kn4fgRPuaD+5i5wegrjJXTqcMndklO9hB/tBjgxcT2?=
 =?us-ascii?Q?FkmAcTcwpQQMhdtCtUwlaphq1jF9XalZURhZ5NRTqyvfvpD/56tHtOUQDpKH?=
 =?us-ascii?Q?tgnmA8eR8tYIKh7Yo3tRc6TnXTxdChbXAGQxdiWKde06y/CrFLIvM0U/EBmL?=
 =?us-ascii?Q?b/Syqkz5HijmecStHxZvjU5VSgoREBZevm34Zp2lBNxdRxLEx5NAmNnqDNA7?=
 =?us-ascii?Q?Bc7nSR4hA62TB3+u6SDhdmZ2d5ARqYmpIx0q4PMveLmUXXEFIl+WrEBhPDWx?=
 =?us-ascii?Q?Aud4K3k1Nd7jI3iZCV7Z89X97Tf5p/Jf6+SABLqUCuLXGtxYrv6ykdPSVU4l?=
 =?us-ascii?Q?XmOdhl+jilr2mwE/K0/DZ6+KOS6MltrsqkOBW1qbpLUyt0M79x3ncWOnJg83?=
 =?us-ascii?Q?rAwLDt/mLYFjw0zlVm6eC9xlUsB4erx2Ow1vNNBpqmP7JONA7Z8m3d/Pm0yl?=
 =?us-ascii?Q?V0kCy4tBIUGpWgdgmRBCbahtiek96dxWy1rBaafakuRy6cVN0l2UOEFiUkuB?=
 =?us-ascii?Q?4UgExgX/DRY1GlNea6DeK0/uov2hapBj8IOG6Fvo17neJmCUnY9lxNo4KcIM?=
 =?us-ascii?Q?tN+NO6KYz2kNqDifrZcC5q7A5NvkfsDjR4XjfWMyygJjt3mxy5lRr/k53FQt?=
 =?us-ascii?Q?wvRH8KChdS/1ZTQzgE3593Ys8U3J9YYJw7sGJonwwqEqejc30zJp7/XvGv/J?=
 =?us-ascii?Q?7HqdhfMuOi2JFGZeXX9P4m+Gqq9jpUZIyUVCV30Bmx6Uo2wAOQOlgHfwJZ3b?=
 =?us-ascii?Q?g87Rpywl2CviNreyRBh0zn2zEUOw99gvHDGhP9vUvg3FxmKmg+GQN9tOYkr4?=
 =?us-ascii?Q?h+Omq6YPTY/C8qfJ9BSY3Ws5fdhoXr+cjqq++I/qlOFwn6arKRVHMy5+mrNv?=
 =?us-ascii?Q?D6zoRcbZkbHYRQWnKcXuUOtl9oUlRmOBceGt0gu+7dY7mMXX6SJQyzbXviNX?=
 =?us-ascii?Q?EQc8xoCdVFbf8PICzXP01JGMoBo5mSWvMOhRhViEoX936X2Pnot8wKuLHyDp?=
 =?us-ascii?Q?C3jz48+1stpApB4JRM5XD4G0lZ9cWhlenTGdqnDB2rBzl1Dyo5beAGeQ9tb1?=
 =?us-ascii?Q?RRcB4N/ivvnRFe2TgFhSAqM7QUzzPh9xU3rRHxBql8b7Pn27Nh7C0mvsY2Np?=
 =?us-ascii?Q?pkggIBKIST0wWrsBGU5jssE0SE9Qtx+Ti06Yw78NXGw1usZg4K/cMl4jxKat?=
 =?us-ascii?Q?eFNDDbkaMYTyiVqevGqyKW6DATyBpl2cQt9MknC2XBB9/6cbb2hBUMyq22VD?=
 =?us-ascii?Q?PwdyCm2yv27c0hZ1fufbqQnWWqBQ/TMxbERwkTjeru6CQJtjGpAsXaWPpzFm?=
 =?us-ascii?Q?kL+bvCZ8ORNSwJT0QRrg0DJ+zg+F6N6/lbnHCXdIlG7AKIz2btsJQlix5iTm?=
 =?us-ascii?Q?JHIwVfKgo/6iCSSixCcQwPlAnHqvaLK6pqB+ZeMW80V9WRpIgMftKRO4iMeN?=
 =?us-ascii?Q?+uIXLV69m3IgUkAinvOT+1KK7elmNvrpbKYXKIeqr5DI2WCx3971XQawaX3Z?=
 =?us-ascii?Q?IHwNjELeCqOg4ICI9W5Bm683p9Ei6eKr9V17stoQ4BMwpc1QnGM4B+caW/ZJ?=
 =?us-ascii?Q?hSgH0XPOh+Qhmk0woBj1WvvVJ+njGmSPt3guDjFMCZhMTWJdL2GrIZy6fv2j?=
 =?us-ascii?Q?rcp2kdCRpV6ibYzNx06itOSVgRcnEfJF+QycJIOGsg8BUsB9E7d3jZYOSaID?=
 =?us-ascii?Q?mITXFucbNS7eByke9ZD7Le94eHLz/22eUWaQ8ph5i9ireJ9sten6nKf/um2z?=
 =?us-ascii?Q?aiNDgg9s0A=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24548f7d-ea5c-4173-c6c3-08df3fd0ee31
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:51:09.4616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3TLzCm/e+kfWEi4klditqUVO13H+CiDpsRC10PDU0NvOKxRWtIRlWpypbHwv+vV9K1K/m3UjleLKyOXuJqgkDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7851
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:14:06 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tze Yee Ng <tze.yee.ng@altera.com>

sdhci_cdns6_phy_adj() programs the PHY and HRS controller registers by
indexing the *_phy_cfgs[] and *_ctrl_cfgs[] tables with bare positional
constants. This is fragile: reordering or inserting a table entry
silently changes which register each slot programs.

Introduce enums that name every PHY and controller configuration slot,
whose terminators double as the table sizes (SDHCI_CDNS6_PHY_CFG_NUM and
SDHCI_CDNS6_CTRL_CFG_NUM), and use those names when programming the
registers. No functional change.

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Changes in v2:
- No change since v1.
---
 drivers/mmc/sdhci-cadence6.c | 54 ++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
index 513101f165a..8f9d9ceca3d 100644
--- a/drivers/mmc/sdhci-cadence6.c
+++ b/drivers/mmc/sdhci-cadence6.c
@@ -58,8 +58,6 @@
 #define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY	GENMASK(31, 24)
 #define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY		GENMASK(7, 0)
 
-#define SDHCI_CDNS6_PHY_CFG_NUM		5
-#define SDHCI_CDNS6_CTRL_CFG_NUM	4
 
 struct sdhci_cdns6_phy_cfg {
 	const char *property;
@@ -71,6 +69,33 @@ struct sdhci_cdns6_ctrl_cfg {
 	u32 val;
 };
 
+/*
+ * PHY configuration slots. The enumeration order must match the entry
+ * order in every *_phy_cfgs[] table; SDHCI_CDNS6_PHY_CFG_NUM tracks the
+ * table size so the two never drift out of sync.
+ */
+enum {
+	SDHCI_CDNS6_PHY_CFG_DQS_TIMING,
+	SDHCI_CDNS6_PHY_CFG_GATE_LPBK_CTRL,
+	SDHCI_CDNS6_PHY_CFG_DLL_SLAVE_CTRL,
+	SDHCI_CDNS6_PHY_CFG_DQ_TIMING,
+	SDHCI_CDNS6_PHY_CFG_DLL_MASTER_CTRL,
+	SDHCI_CDNS6_PHY_CFG_NUM,
+};
+
+/*
+ * Controller (HRS) configuration slots. The enumeration order must match
+ * the entry order in every *_ctrl_cfgs[] table; SDHCI_CDNS6_CTRL_CFG_NUM
+ * tracks the table size so the two never drift out of sync.
+ */
+enum {
+	SDHCI_CDNS6_CTRL_CFG_HRS09,
+	SDHCI_CDNS6_CTRL_CFG_HRS10,
+	SDHCI_CDNS6_CTRL_CFG_HRS16,
+	SDHCI_CDNS6_CTRL_CFG_HRS07,
+	SDHCI_CDNS6_CTRL_CFG_NUM,
+};
+
 static const struct sdhci_cdns6_phy_cfg sd_ds_phy_cfgs[] = {
 	{ "cdns,phy-dqs-timing-delay-sd-ds", 0x00380004, },
 	{ "cdns,phy-gate-lpbk-ctrl-delay-sd-ds", 0x01A00040, },
@@ -266,10 +291,14 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 	/* Switch On the DLL Reset */
 	sdhci_cdns6_reset_phy_dll(plat, true);
 
-	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR, phy_cfgs[0].val);
-	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR, phy_cfgs[1].val);
-	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_MASTER_CTRL_REG_ADDR, phy_cfgs[4].val);
-	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, phy_cfgs[2].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR,
+				  phy_cfgs[SDHCI_CDNS6_PHY_CFG_DQS_TIMING].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR,
+				  phy_cfgs[SDHCI_CDNS6_PHY_CFG_GATE_LPBK_CTRL].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_MASTER_CTRL_REG_ADDR,
+				  phy_cfgs[SDHCI_CDNS6_PHY_CFG_DLL_MASTER_CTRL].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR,
+				  phy_cfgs[SDHCI_CDNS6_PHY_CFG_DLL_SLAVE_CTRL].val);
 
 	/* Switch Off the DLL Reset */
 	ret = sdhci_cdns6_reset_phy_dll(plat, false);
@@ -279,7 +308,8 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 	}
 
 	/* Set PHY DQ TIMING control register */
-	sdhci_cdns6_write_phy_reg(plat, PHY_DQ_TIMING_REG_ADDR, phy_cfgs[3].val);
+	sdhci_cdns6_write_phy_reg(plat, PHY_DQ_TIMING_REG_ADDR,
+				  phy_cfgs[SDHCI_CDNS6_PHY_CFG_DQ_TIMING].val);
 
 	/* Set HRS09 register */
 	tmp = readl(plat->hrs_addr + SDHCI_CDNS_HRS09);
@@ -287,20 +317,22 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 		 SDHCI_CDNS_HRS09_EXTENDED_RD_MODE |
 		 SDHCI_CDNS_HRS09_RDDATA_EN |
 		 SDHCI_CDNS_HRS09_RDCMD_EN);
-	tmp |= ctrl_cfgs[0].val;
+	tmp |= ctrl_cfgs[SDHCI_CDNS6_CTRL_CFG_HRS09].val;
 	writel(tmp, plat->hrs_addr + SDHCI_CDNS_HRS09);
 
 	/* Set HRS10 register */
 	tmp = readl(plat->hrs_addr + SDHCI_CDNS_HRS10);
 	tmp &= ~SDHCI_CDNS_HRS10_HCSDCLKADJ;
-	tmp |= ctrl_cfgs[1].val;
+	tmp |= ctrl_cfgs[SDHCI_CDNS6_CTRL_CFG_HRS10].val;
 	writel(tmp, plat->hrs_addr + SDHCI_CDNS_HRS10);
 
 	/* Set HRS16 register */
-	writel(ctrl_cfgs[2].val, plat->hrs_addr + SDHCI_CDNS_HRS16);
+	writel(ctrl_cfgs[SDHCI_CDNS6_CTRL_CFG_HRS16].val,
+	       plat->hrs_addr + SDHCI_CDNS_HRS16);
 
 	/* Set HRS07 register */
-	writel(ctrl_cfgs[3].val, plat->hrs_addr + SDHCI_CDNS_HRS07);
+	writel(ctrl_cfgs[SDHCI_CDNS6_CTRL_CFG_HRS07].val,
+	       plat->hrs_addr + SDHCI_CDNS_HRS07);
 
 	return 0;
 }
-- 
2.43.7

