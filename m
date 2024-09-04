Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D79CA0ED3
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 08:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9DEF88CA8;
	Wed,  4 Sep 2024 10:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="NROEP66q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C531588CB6; Wed,  4 Sep 2024 10:24:19 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B444288B23
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 10:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3ZE8Ukf6rm+Wbq5UH/dVw7fYc8634mQBHIPXdJNkuJlweGV4OMKUI8RCR+nSjzkoxOfSXnFFMP8gvMymtbISPMELJJ1np5ax5yD6LBPcuhjTEqRcBXEBjNmkVQrGXM1RakAtxTE2LlLUwSXge/YEmyuLcf2NV97/9CGCsP00ScN0bpYsVksobLdWAYI5PMwgxXnpDE9pyADeEt9mhYzAt8ZmvKUVc0Up8GdQt8Ru8vAJi9I6uF8x4ZbZVkYcgwnkowok4p2e9EFDXQNfFn1/txsps4krYsk4kzZFApqVzFugI+QZIxC5bvHiPAK5ILjbCar0k53Zxg6yDFYVxVdYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eJ3w6YJ3n7PDHW97CdeKZWA2PHfybcOjG1/L1JpHlw=;
 b=B6swpgaGzYlACg89uLwQIyBUO2L8vCT0ElioJYtdx5xAeaCtJ3gkeZ4E5XuU8paD6gwNlrBw1r9hN9Oogp22Ck97afZI5+jw+wnlaF3j385Sg9u90nhb2ZXe6ZqUto/RWG3GlqOomflQjxbsDtz8qmt2W6YbjRgfDGACYdJFf2dWCvaWGZb7anKysxwujaKvIblSfOpL8r3ggDQ7uz121Qscm36UX9pg3JdcYVBaqsh0tJKwtim++H2WjFecFMmlX8nefPO/0HFhNIv/95xziLS5OFEL1VHobJHeJ+z8fWamJUDPniORnhU/j5EQG8NLMEf70jLLBdqpneftQEs8+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eJ3w6YJ3n7PDHW97CdeKZWA2PHfybcOjG1/L1JpHlw=;
 b=NROEP66qfx3UiDNhGZrXpj+acroCAqcm3UIbMf+ea/rUcF3+Ir0Gbga3FMYC9taAJD/uec5zMpNDC83TRxdsygWK0kcTnIoCP5FtIkkJxFZc0AZYPfvS8iF5PdoHjLn+tQA7Nc143+7IVOwC1FwzK7aExg7cGBh61UkWapeDQVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GVXPR10MB9183.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1dc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 08:24:13 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 08:24:13 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] treewide: drop redundant "type string" for SYS_SOC and
 friends
In-Reply-To: <20240904081840.2206980-1-rasmus.villemoes@prevas.dk> (Rasmus
 Villemoes's message of "Wed, 4 Sep 2024 10:18:40 +0200")
References: <20240904081840.2206980-1-rasmus.villemoes@prevas.dk>
Date: Wed, 04 Sep 2024 10:24:15 +0200
Message-ID: <875xrbkes0.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::7) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GVXPR10MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: 740e35b2-8fa5-4c34-c65b-08dcccbaf5ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yOlgtCMaK0YH0RvNBNr2YhPR/4rk8yESQSrAtNEtEdDhPYfT34Jhcrd3sIfW?=
 =?us-ascii?Q?OB5ApWIdSkSiZYGCRRL29FNS4D0foFMsqLd/HykUoYBwVXaQ/YsKiX2Xnz2z?=
 =?us-ascii?Q?zobd7DqXzDrnFT/SjeceOyM4ZTLXwT3o6eoHqtyXEQy1XB0djSDmSx0mAkGc?=
 =?us-ascii?Q?HQuyG7l2dspEr8Ddq8Np4NQrnj/nIN7ZRC2xEPuaKxGd7SjED6JmRlfJpOlF?=
 =?us-ascii?Q?F3/8UrVTcdqRZlRnVxg0ZwQHbGZEraAeHF1UE9RVfCzey2nWyKBU+GBrnPOc?=
 =?us-ascii?Q?P5C0LtFTjc+tHSM9S9wQOY8rsvH6QrtxWhuQZe5YRlW8tPUq9ysQo0IHEzMH?=
 =?us-ascii?Q?2sEinzumS7cU9UrnvC3oqup5uZbiryO88eYog8iV9y3E2Ro92arj3z+T09e/?=
 =?us-ascii?Q?WldnzG/6SrQrXeKdnzGA9lqNuJ+M2n/wWEUMS2pUa4nSDqvN7zi1jlwYTANx?=
 =?us-ascii?Q?AFmcK/tSCsaD5PSZofXtFu9sddLJ1Hi7mQe+ZK0oigwdFhnBdnhHNYwZhQok?=
 =?us-ascii?Q?7lKwsUu8ojU60j9QdCsu9z8Yq1TlpzIeg3DQOodwNlrdk6z9W3rdTdhJpwfX?=
 =?us-ascii?Q?7t6liD+euB+Qj/+z8lNdbnmUSfxgDlTuEgZ4TdbM0qwR6HqBvUcWYepFANzV?=
 =?us-ascii?Q?nV/lYM80/LHbpp6bQICKP5s4dgXNU8nS0VkJxzHL4iGgIcGYtcBhzNcEd6m9?=
 =?us-ascii?Q?qxYyHb1mocTpnyxRSGoRo3eaTfgtnmV7QiE9H72OaGgQowOezIrg5dM9XMXb?=
 =?us-ascii?Q?BOsg1nEdKn/ynM5Sv7Vm/FlCHTpFMF0mg7l48cixPZeWo9DaApWKpLbNq7gK?=
 =?us-ascii?Q?qnCdUBGW191dC7/V46oDdiuzFg6NgMTZ37h/3xE6Aoqm98lLURPkoUbKKJMR?=
 =?us-ascii?Q?KAuYBixi/u+ejeffVEI+HozRUHMlxKsD0LoJpINZSJTNwVuCxX2LKg5bdtVS?=
 =?us-ascii?Q?cb8iEHx0rpf8w5xjFy5snEuSRxOyHLuo5PM+sKn1fsA7HL5hrlGWPFUAZZXT?=
 =?us-ascii?Q?8nEzWgjHnMDRWymKsuirx067bN996fkiNfNlbe2HssquM6wOvvGUejgkez/r?=
 =?us-ascii?Q?WjjKHmUGdF3plPkXANc2DirByDXqrV37qRBFbdqFuCfaeIo+g7IF7TZISXk7?=
 =?us-ascii?Q?IdI+YLweLSbcB7rXIBtn1CgFh3v9y2+/dOJ1M7I9mZzIM57zF6dZSKxuvcpq?=
 =?us-ascii?Q?r1RJLZHca4iSdgJ27vhz1gKMGkPSVGTcANBCVx09T2/g1YBwpiD4FyNrarH7?=
 =?us-ascii?Q?L+qLcmix809lBsoye7UubN+5FO0Jwko1scCXHDjxhI47WE96hzmYhT/Z2xwF?=
 =?us-ascii?Q?0S3PNzkYZ3VhtINUJWW7IPrTp3rULp3a6GTIP1t1Xx2/ryCXxk5FZ3fpa/g+?=
 =?us-ascii?Q?Jgg2qChxOlBjDoRBeQGdVeBJuiiFQP6z4N7cDZYvqXdCMQpxgQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xs5QD+hyQo1GRE75n4glU0VdTZ25oX0hDtWC/SVyEUuvyd1Hj25l4kSUOfDv?=
 =?us-ascii?Q?K1tZu6De356uIH/psAy7EQAlb/U7g993iHicNLrURVV+0A2iVD+nhP2I/oAs?=
 =?us-ascii?Q?gTWKu/WbMi8alWm56B6aqWPz2Zdr7tQ6EJ0JbIZ46GTZYTMBr3WAABsangVc?=
 =?us-ascii?Q?gs38MSIgptG4QCGqRNM2NMMyJrgyUreXC7hSW2OZaFQ+6l/v9dvF6nzLsyAI?=
 =?us-ascii?Q?9CDXrde3Fm2tLdf2kn0nTLUVVN5+rUbKfZ/XBSkfF2hwJ+Aj8p1dEzrvVuHH?=
 =?us-ascii?Q?1HrAmFjANuLlM1G8p35BJ4NbwtguABDj0VrSrnyRt1qx724vrBJp8YUkr5j5?=
 =?us-ascii?Q?lBxTrv6YD7vuxclREA5/erCifBHdnQac0dRsSuGmi1CBToggEozZorROGlDf?=
 =?us-ascii?Q?sEkiddOm+3s1PZmwvb45EtT3Z3FcjeKyBiW0+hjL5uMSXrQUCv/nb7YcI7vz?=
 =?us-ascii?Q?sPoTqlT/IcA8n1nNCPkyoVHstiY3T1uxwz4ewvp1h7ZCqmHeNpOIflLU+35U?=
 =?us-ascii?Q?hFYoN7LW1QbSZa1+qJoSHpmIqdWq/52gataWBgw5h6zrEXkqma0HqgEsIMFv?=
 =?us-ascii?Q?KG/JsBCtXEkDIiqmgNPgjN7me7nanNHWOkf5A722d3wP5VBs9dKsXEcghtWA?=
 =?us-ascii?Q?0onC6D7gOGlC6HX+7gV26/eyJbpjA8a8MBznqk6yw64sc7w91QP7arorwdg7?=
 =?us-ascii?Q?eGIAeDhKVPINLuHbTh2EA2sUcYHDKuxOlKakJPMny+Xcz869w7PxvT5N1yCJ?=
 =?us-ascii?Q?NUytarm3afMfkvm1fmNR1v4ROKWRhsG10uCNVqoRTZbfqZ/4Hu8wsbGyt/65?=
 =?us-ascii?Q?wZbV4+Kw1jnu4RoOLspgsbMgEYqXOZlnd/CneBwktaCcHFfN3+dcV07IfzvC?=
 =?us-ascii?Q?VMYoLKiDBpbVIpOJTNViVARrbLab1n3HdWcx9WUKbokwbT72rxxrZZfbW+kn?=
 =?us-ascii?Q?OYRaMW8Gij/F6qXRYPyrOoKpiyuvQXgDAV8ex9YbECCbwo2hQkuXDPfZdG0r?=
 =?us-ascii?Q?nF8xC/dItfmhcvktvpB+Lfxf/1vIo9Rcu+YT0qxXT0Dy2bvLVhGin4yePXU4?=
 =?us-ascii?Q?1KPxhlog2ofBLYiM4J8HrTQVdBlZecZgqCeQDH5QTHVnMFRJuhuuxx3SwJku?=
 =?us-ascii?Q?U9TwoFFls1eBJZVPCSikmaDej6H5v7naoq9MQ1VGs6AiaTZ1Liovnp5//Qk2?=
 =?us-ascii?Q?2johZS19Juea5ShZoHYQPm1ImtNheAR3DlH0hjo1yJOBk/K2jsDRyfjp0MVU?=
 =?us-ascii?Q?/sbOCwzxt7tcwUABDRpukYePN2td4tp0MGNDUl3vwSZqHcFJ6Dq24kXYTej0?=
 =?us-ascii?Q?uu7kjmBBmzR1WtAI4591Jj4rk7TBO2sf4ZgZqn8Cv1XF4zB4FB/phZVQNRDh?=
 =?us-ascii?Q?Lnzxz6BSbdG5Sbz1lGpe/7Y2LSaBWOfeH7QVPb1TVViO/bNbXANHQZUyHClD?=
 =?us-ascii?Q?Pniz9CYO7uKpZFdXsFJvQ7mhA6Eq+MpV0DQ2Ll0QiXXjEfXDOLXj2rkvbH1p?=
 =?us-ascii?Q?KUfHObiKsEAh9++n7S+e9OhEB20R3m1oJQoV4nyjMscq4S11XtHl+pXI1C8t?=
 =?us-ascii?Q?SzJlIaHT3ji48qwtHpoJBKoe61UjR7BcQzMQo4LkCsYtIn50dioO2z2wg8Ga?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 740e35b2-8fa5-4c34-c65b-08dcccbaf5ad
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 08:24:13.8367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +faXtQtKC9a/mZ1kU1WvbtDIclq1zxFHiITmqzfYX2oL9ATDaSW7JX2tlYoMym3R8ltWsHXSCSkbsBD8L1p4JNh21IQqsAPLIB5TWfrpdtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9183
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

Rasmus Villemoes <rasmus.villemoes@prevas.dk> writes:

So the moment I sent this I noticed that my $subject is a bit odd, in
that there's no "type string" anywhere, with or without the quotes. A
better $subject would have been

  treewide: drop redundant type annotations for SYS_SOC and friends

Rasmus
