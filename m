Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDB3606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 20:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pg5JKAlX;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=D3QxXPHo
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09E3480D47;
	Tue, 24 Nov 2026 20:06:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YSy1rRK-CjPv; Tue, 24 Nov 2026 20:06:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2E76E80CBF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795550775;
	b=mKp9m0LZZf2LZZgSDNv+4gmalG3C81hEjRQ8La201cHGe+NwREkXbw/mS0izoGIOc8Tw
	 KwGwky6aJqGTR7CAftUAZisw4irjQeWiXcqNztx63PADg8JRkmhus/HGeYGTNfU7Jerb8
	 Aey1JVm3ZuA/eF5iDMTCVBqaQ2nlpuzmAwm5vQ8FGcOTaUp6mB9+R1jqXpnpOeqCqNNWI
	 JZ9XkZ+fHI/y7WABDGw6gjMYfD5dDm9iV76GeGjR3qMkwmLnxE+cQxQNlsC9kKMgDhu4u
	 TcX684wutBhQ6TiNvKx46ze9AKSV0B8ri7lZGvtiVKiChdhNOjKJO7hQ6VcM+aKSdqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795550775;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=srzkxw6ok4v1ziDwFPJyvLgqZQTthefvJ4WpiMdQS9Y=;
	b=NRvWrnX5jvBJfmK1/WOD7ICrpR0b83Bi5XO4bXJH69rn8Sr922p2H8Sidf3MM9iaLwAq
	 P6QmD+EDdCHWGJrMKaO4FSVZ1zYku8bRh28Xd7c1K8PXX6dsOUuKBw3iKGK6s1/eQ7yRx
	 3GvfgqJOaWGIddpQ8FevjNUBJT2UFhJdkK5Mb7Kkhvvgm0Lj7jajMQ+O8+FsGgeXJdg5k
	 t1NVY+3vhz/GbtJCkcQQpn9kZ7YHeo3/ddSTZbWR6W9NqZ2MICXa8Q6GHU+vp3dBW5S2F
	 FXpJGbC1mt1IA8NYEydUTk7aA0xY6s/BKcVzMHBMsSJc8e06ZDFmJsVU8VhWb8jWkXA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795550775;
	bh=srzkxw6ok4v1ziDwFPJyvLgqZQTthefvJ4WpiMdQS9Y=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pg5JKAlXte8dsNQtrUgivDogwiI6dvCUyjggcLqjDOdhUqnpY+GmHqEP2n5H+prJ3
	 JiXYqmaIm0aVV10rlnHCq0xI7OQBhD7cv2VHfDgrHoYJs/rW0s2Mjd9GbUyWYMxHIy
	 pE2tFSnpephdQ67XCg3sRnam3DJ0clIlYjjfe3urWTeksOB9rHYRSb8JEJYwtmfXDE
	 Lobe2fPA+FeydCzQsmx6g3e0Qm3sHGKsTIN3wUjxgGYeNVq1sr5R2XL9topKAjqFd1
	 BWXahRHfXNuskoi8pfj5CbwKoH+9+WFKe9zwlB660HafI1vquYVRE1laP+sB/WhkaP
	 RnRbx8GlsIbAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E76E80CBF;
	Tue, 24 Nov 2026 20:06:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B0BD910B
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:04:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 968274053E
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:04:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sy2ng9UvPnLC for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 19:04:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0F7D34052C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c100::f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=anthony.pighin@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=D3QxXPHo
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F7D34052C
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 19:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srzkxw6ok4v1ziDwFPJyvLgqZQTthefvJ4WpiMdQS9Y=;
 b=D3QxXPHoHwhQIRTSiDJfkC4bHI2p9Sxq5H0gwoa668f9myIe8N3ZC7SKDQTmxfidHZeaLYEkWoD57njxTRnXJCC+QnyHuCrULeb0YSHabo5NaGQbZ9s1CrIw27iu1bU/6i+xwVn51PapkWmuiryK6uFnDiFN1iPhao25swSbj51p1R9qEBflNHg+KUNwxS+yscO7dFLKNo1yu07/Q8dlz+uRBNPmeq1oZ8n7FP/8BmYXJwYtV2aUu7ACNvvlflD3aGwRR2pJcSys5+xhlulAO02MdR24hCOD/d/Szv03/W0MkpY6lyN5rHhhdzeKYapjWJE1AvLRkor6LIse7uAI1A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by DSAPR08MB846671.namprd08.prod.outlook.com (2603:10b6:8:51a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 19:04:39 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 19:04:39 +0000
From: Anthony Pighin <anthony.pighin@nokia.com>
To: u-boot@lists.u-boot-project.org
Cc: Gaurav Jain <gaurav.jain@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Olaf Baehring <olaf.baehring@draeger.com>
Subject: [PATCH 0/2] crypto: fsl: fix missed dequeues and stale job results
Date: Tue, 24 Nov 2026 14:04:34 -0500
Message-ID: <20261124190436.560138-1-anthony.pighin@nokia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0194.namprd03.prod.outlook.com
 (2603:10b6:610:e4::19) To BN0PR08MB6951.namprd08.prod.outlook.com
 (2603:10b6:408:128::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR08MB6951:EE_|DSAPR08MB846671:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb07647-70f4-4c59-4106-08df4a5dca19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|261009223027099003|3023799007|261021121427099003|261022105027099003|261026140227099003|261102123227099003|261026121527099003|261028144727099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 0mZ4iYDt8yJHk+6wamO4kbmZZBSrBX7zpQ2jAdYn9BQhnHqLC78d9zFkr9Ko4Im+nmCfCDLyoJv2pIQp8qZIy2yblm+66EXn5S0jBjk+uSLQqUr6hX5lwqdORqHVfMJCTBSBkJFKeJ2rwmN4e+XXNomch0F2ympBeCFxI7IJKzzsLnjOGIhaeHSLFP5/1/mnWQUWtD42L9CWwYLiUoEnAi80uK19LKK1v35ochdEgJt++vMOHkfC3PbT+KGM9qVp3wz3owBpX8rCLzL6/0KuA13vaSbHIIOhn3KeXMmq1cuEg9YQJcrUpQ1WkhhJGG3Ypenxyz5MUgh4/pCxL/Ip4k+KKY30IC9abLKpAIonOXHVnx6FtlXvGKTLGFqWcklHGf8Nx5hUvT+/9CwclssQ9W2+Km+RvBr2z5+Px+hoql9E9kgwvVp1/YtUyfEbKqrOUGIduUFhAdNOhlBWVUfJPFkBUA1BGsbjmPB2CNuFoAbo1b+qdEzL4Z4b5wQIprC0KJDskzf/KnYK0KhNa2ShR1O5aAISyS8LI4+06ouAn2WTFSzoQbYxCFr/Jr83lv9IYzZB3Ev9gVUZ769eKggBtxcDNsG9BZLrbOZH+BDD9w0M1MY7zeKU+Np9L6r9Sr4D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR08MB6951.namprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(261009223027099003)(3023799007)(261021121427099003)(261022105027099003)(261026140227099003)(261102123227099003)(261026121527099003)(261028144727099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oQSj9mFyBNYyh+uehsVbTkcWZi5siDanV3n15GJcajFPQmHTLvX7ebBGP0bv?=
 =?us-ascii?Q?B6tH2oaUigryK7owvwHzioaycsDKddlG4ZWOQgMQLDCGLRPwxll/VE9nQLQo?=
 =?us-ascii?Q?87nd08KCAaDaWjktyGgpB6FYHwncbRz69bPTXjiGvj3XA4IxBnMWjAYSGW4K?=
 =?us-ascii?Q?mOJKuyw9aRW2t1K/l1OHzit/RfSDYbzCDbvVZ2qiHy1dP+4XBe2/8xD/VwL2?=
 =?us-ascii?Q?knXqSBVSWuCG+JctAKcXeGTFOdSd/0cgeSCB7+aH/YVf5jZhF6NUt9mAkdyU?=
 =?us-ascii?Q?bmdHlWpxTRjmq87Qiop3qbaqxwDXD/E3MHcgeo57VGEdfEI84eYs+pdiehSe?=
 =?us-ascii?Q?XGj6AZ3gr1R4B8P7lTH2c0bwBERhcH/CxCTaFlQ6xlMDOtTdmCF7mOUpewQC?=
 =?us-ascii?Q?fbWO6e5K+uqd4UEG6tFjZlaMdNUpYQEbROmuSsRHQnmo97UraxRwZkzyMBRS?=
 =?us-ascii?Q?JFlExFe8l7zmmPqEKo31l6O/Rmlgi2u4lcCwq0/tZQTz1EfPXuSALVqq2IeQ?=
 =?us-ascii?Q?yzVN976v0W9KiT0X75bTTQrbMmctBL3y83m78/FYzsHqvtNRJOLGdsV5k1M3?=
 =?us-ascii?Q?7Va1PNKIk9NjZG4OoMPBnUecNZQWUltEwErOcW/bFmY4dEdMY/PO3UrxIhMb?=
 =?us-ascii?Q?V1W1BboI22opfaf9AAPO5qIFQ4dPPqXjRxvNp5+qGCtA8SL4/Bg0yZuJFgg3?=
 =?us-ascii?Q?DnE1wht1ZW9QSjLo0hxnS+hqf2BB/vJbpFy7Tr4IiSBOQjjDg7el8o8l64+Q?=
 =?us-ascii?Q?gT7BmyHzFvbc0I/J7N54xaOpEAucIBUmDcT87QlZ3ZbYyVaIpSyPz5PYwU3B?=
 =?us-ascii?Q?oasx7tmWmbwgZMtvs4gicO3ioNm6dAEDJUgzQbiY7+brfB/FkwwGyp6BcRY4?=
 =?us-ascii?Q?rhImmCeJ0WQHDkBuiNnnHjgZVjPuSSRm5GGaNmUMBj5GIRMKNCD4+t/qVKjQ?=
 =?us-ascii?Q?LWjxZ8ACWN9O+PZujC2d29d172jMKxbjbUmmnnr9TFNqlkPhJ9kdi/rzoepO?=
 =?us-ascii?Q?vcGDKdoItAWiDdOdlDT0n/SfiLKmvwOvxyYfKf2uvWYZ/rdaBMbQXwtJSXaX?=
 =?us-ascii?Q?iGEoS2fzZ+4L9OL0mh0VUuNNfHsEZppUSwtQBKNTbCbnxFE/04hxrmQNl8Lg?=
 =?us-ascii?Q?USsZ/S9chmZvL1eGxtB+js0jnYglMI38P8+u8C3Pj3pnOcTTxnFzvyEXJY6l?=
 =?us-ascii?Q?PmZoTCgfu3oFmH/p3qCsOhCrybxG3EFVzAN9jGCmrouqwpXOPGY2heKlrgpS?=
 =?us-ascii?Q?GOC6JAxvx04TiwkWbROrDINgGbU+yn9cx40/0249jbCgeytkLhYLDu90nb2W?=
 =?us-ascii?Q?YwEHfDMyKLYvKGx8XRswuVsLeiVstsao2tOCl5/g3Z87dX4UjAZDQe/OOriJ?=
 =?us-ascii?Q?IIQfnrnuqDiyTQDVCa/pOkqDfu6qbcOmVdcUIT6gVupAuuMAzHYx+OpxCMwa?=
 =?us-ascii?Q?KFWnEIr5vDSmHKuvMEEQ/4sndtuGPJ7dmx1Vc48Cx7rcSfSjZg4ToXDfYwov?=
 =?us-ascii?Q?zDQmZq2Gsm7+q7k0eoFCxBw4+THiegRGdMcvHLeWNywRUkvoS7b+RshsxBDS?=
 =?us-ascii?Q?ezc6HxSoj1vmpOK8pdPYu9/A2TLkZsXgXhAobRPg0sOY+B1ojcCT5GzHiFB7?=
 =?us-ascii?Q?wxO+898fc2XrJAhWQPRqpRLEOGazFM+aC5tZTHXjEl9En62V8uE/+r+hYWMC?=
 =?us-ascii?Q?eBDYPxyDo6AuwtkfOJBAHhHfKgabtkEnUE7wvPsTmHn0eo+F+pCYjNPg0dHL?=
 =?us-ascii?Q?4CF4bfxEYQdwBrdX1TZSNFQwdoBvorE=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb07647-70f4-4c59-4106-08df4a5dca19
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 19:04:39.4435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2ZoaaC8ROy4WB54Hv6WfIFzu+rWpqp0E1SqKYHdFJ3DoV+wLclLWlJXLejNJHWrU6GHR4q3U7/Z4xQCYfO3jI+SU57JJO+f1iFo8Plfvjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSAPR08MB846671
X-Mailman-Approved-At: Tue, 24 Nov 2026 20:06:14 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The CAAM job ring dequeue can miss a completed job when the CPU holds a
stale cache line of the output ring. The job then stays queued with a
pointer to its submitter's stack, and completes into that dead frame on
a later dequeue. This has been seen on LX2160A, where it crashed U-Boot
while the Linux EFI stub was calling EFI_RNG_PROTOCOL.

Patch 1 invalidates the output ring before each read. It takes only that
change from commit 159b6f0e1199 ("caam: Fix CAAM error on startup"),
which was reverted after an i.MX8MM regression, and keeps the
invalidation in jr_enqueue() that the commit removed.

Patch 2 makes the dequeue error and timeout paths safe. A job whose
submitter stopped waiting no longer writes into the submitter's stack
when it completes.

Link: https://lore.kernel.org/u-boot/CAJ+vNU1Ge_s4mEFYCn0TPhuKW5X1J-jcV3GyZqc_70GjgsqRtA@mail.gmail.com/

Anthony Pighin (2):
  crypto: fsl: invalidate the output ring before each read
  crypto: fsl: drop the results of abandoned jobs

 drivers/crypto/fsl/jr.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

-- 
2.43.0

