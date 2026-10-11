Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61396CA9EBD
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 14:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0ED3480D91;
	Sun, 11 Oct 2026 14:39:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vR8W5I5z6pgm; Sun, 11 Oct 2026 14:39:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 228F980D77
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791729568;
	b=asS2qkMHIooLdeaGP12XyhIQlT8+2IRqI9JpOAc49AIiPf0D2JLmRY9NqRX9iELVXWAq
	 +OwasJ7JZEYBaXKRywSx0IM6Xf6cj+KVzYCsXtbixnHfsLERhGWJWLubPa7F7OWM/RIlw
	 1i9OjgwRC7+rfMj7yFDP9GDSrKe0tFwqxjkPvjJPXQshBkyW9fqu0px8SYM66tSoWLB0u
	 oMjVO8nWkTnaiYUSNpMKDVVr3B6Q4XGSfOYG9bLhXb0U7e+SiKQYgEShFLIrI7d74VriO
	 dUeBFaIydqObzlXHv2sbe8d/b+sUQ3XLB6pRO2TJFSGrJXY0SnNNXRvB+QNwmG6KQFA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791729568;
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
	bh=BX3AC3eEZtQUMLiPTb3xdwjKvpTOlpV8A5d254bqSbo=;
	b=DIvDO07tDfpzZ0pqKBJ0DLRRXRQjnWUoTbi+RO3zdjRByBcWehd7WfEN2v3GVPJtzFZG
	 0HN3aqLcb4BDsgnOe6c6FNm8gmczdAThSfZhF/jVGqoYBjz62qlZfsE+8jXmlpKvEihB6
	 4moFfdIQRpXJ52TUDuM3l1V8OaKKsTSiMGJ7NGoApG6BoLFDDANzy5N6tBY7yHYEMVNOM
	 uxwEZT7bus7Ls0YuenaZy4O4FHPHu+XDxVI3WcZ1ALsIFk1RKF9a/RPRfrAZgEgQScyXa
	 Ja6jSEeU0OM2bO3chFxEcFvRJISk5c5Xb3l7PRU1OIbXIBW5MKSgccGACyOkP/dGOTA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=processmission.com;
	dkim=pass header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=qi3RoH1Q;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791729568;
	bh=BX3AC3eEZtQUMLiPTb3xdwjKvpTOlpV8A5d254bqSbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DF6WHhS4CGY6XBCEWiRJU0gGekwTe3+dYdWgeXmLmuKuxoyTrCjjUTOUjSxEOYi+Y
	 VK9m7xfDkn+OITzwqtqiPqpRebLH2NbYKHON6lSUI4410pxmx47B1p7/fPPL0YWxyF
	 I9WGp7gOCrN1UPUVYeF49RCQyLNyOx0oIolZ1c2DrIQd3BsFl34Nrx4cDaW2I7Ohtu
	 wJS3+OKEXHltvgrcMj7IgbckHvvXytZOPoZiYx6vD20FZXmLzhB3ikx8bU2O7hG67l
	 /A92FU9U2vvfKx/R6mNxFAexrRGH3yYhkat46o16s9gdrRLNbhnjKUTuOg43kE+fP2
	 DrQ/KZUwS89Kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 228F980D77;
	Sun, 11 Oct 2026 14:39:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3DEEA22B
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 07:06:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B0308109C
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 07:06:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vXTGKqLYI1iQ for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 07:06:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A2CF381025
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c405::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791702386;
 b=lXVJdtcc/f9/rOaEcFtl09ssyql/cGGdrZ9/Nz59AYLXLaqLe0rmY4QT2PMIys3mH258
 87r9EgeJ3++18TKJhKD8fDlKNQgIDL3IrOouTRLG8kFHNvtOUdGJ6s1TugunEhvaVjX3O
 QW/J8Urh9noAm1gFVABaMMjNu2YmK4kCezlzO7BGS3urvU+UdVPzzuQ1xIu5VIN+m3KkZ
 tMlIVw74Ou0CI5yD6khTK5sFEkLdUOZSlJnwtUehdu5SgkbVIWJ9Dq6zeV2f+GqS5eqiN
 4cZ/H99WHFa9/8srd0i/aWVFczRUajS5JWx4YFaH9zchRpw9lkSv4bJr+O1AbF7VuHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791702386;
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
 bh=BX3AC3eEZtQUMLiPTb3xdwjKvpTOlpV8A5d254bqSbo=;
 b=pCtTIGsJgdW/0eYca4pphGS/XjUoFhQZbcfN0zHO1JlJb9hWuEqJifF391T6iktdk2hH
 F9b9iy3NfuWOfK1nHikbncM37EjciJJhQfD+gcnfvFOf15kSJhJT4MRbdhfoRYJBNlrZG
 oSSRsgNo01RywfNHOgqXYWMYNxWqhGmEOwBx2JoLem14BDzjQfCeh4HEFfERIZHKOlfck
 uveji5/DRx452+W+tZ3UE/kWVcnRK287rW++kX6aZg72FFwDW7jH10TGFNtq+Dfwx+zd+
 8R+EX3f8CBr+LPVmo9SPdYWQNMlVziWwkG9ZqCzxvsySADlwq/WYb/LhuKNFaYc3RcA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=processmission.com;
 dkim=pass header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=qi3RoH1Q; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c405::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c405::5;
 helo=typpr03cu001.outbound.protection.outlook.com;
 envelope-from=bin.meng@processmission.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=processmission.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=qi3RoH1Q
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A2CF381025
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 07:06:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mC0ORoaSfT+aomoj7azSElXyh5lC3/VIGTPMe77DbTz+rLJZUF8pQ7kAlVUv4BRzht7508t9aU17fIH7WU3/2Kf+9w3tJJfkfjjjGqhug5/L6akUwD5zeKGulPMXjkPleBkXGnGC7mRWb/34j5XyHcnZL4MQrYhpZBt2FD1dnBStZYjQ6m95jLbFWLmP1LSIH+pF+LxBiIbCXhj8OB4V1qZfxjPVp41fq7q4IeNfR4u/zhhlF6RCIAAqWpYeVM2qzs3hcWisuYG5hsEHHPby6uiuHCAnQ8buSBiEWPzsJuI8lHpkSrB3F32YdRxHaCmixZ9cgnVKIuWRnYSdi/Gy/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX3AC3eEZtQUMLiPTb3xdwjKvpTOlpV8A5d254bqSbo=;
 b=jdJw3ZmWY+fw/+fdunVSYh++stVFlPGBK6TuLTkrkE6WR7aso2jV2tofwbjee5Ck36Ay9QpK7caeRTAw198oBOa7d0ctkJnbKPvUQ5qYsYJsMuorxycXpp4HgyugGAHQOPdgIxxEWqBWJ1fy6Gk9myoLdfAquSpYez0MMrxLGf4FncKi1xQESMsD2FxOiut3nPMpXiVGzQFJ1IrmkkPH5H6kcFpD8wZybhL7wss4+/3hhLqvJ7lTRlf/yECmkizT9tcXrq4t0CV3GZGPBUVRGODK+G+GwXxzoCszgaicDJNnZ6l0a/Qpq02ppLbnIOyVcFMJgNgzQBZDestwzzDHQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX3AC3eEZtQUMLiPTb3xdwjKvpTOlpV8A5d254bqSbo=;
 b=qi3RoH1QmAJLopT7HiKJguZnHFJBPiAKetji1XxiMToMdvfmIisNuzq1iheiDdsKMsynBDc1ROxxRqgDnY7C4XM+ldr69hFfFqDdrLVKSeM5UwzWK40akVl4StSD+W609LMMsJHy+3MQgwIgH/hXWpyLriDkJeUu4YJ/HbVvwgI4y6KEwpIndNxVH6EbOn6+kLBVq1fYdt8UlI+b2jmrDVZvgWwgK7NBVS6qEAzkzArwqy0QpqfumurCk3aS+xE8Jaz4MR4qIk99BHo1SPrwLMdQKQp1DdLAZMIOt1/U+mSsc+RpT4J/BKVdsVcBSA853GEQHZRluymqraSSLXF9zA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by TY0PR02MB6983.apcprd02.prod.outlook.com (2603:1096:405:b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 07:06:20 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 07:06:18 +0000
From: Bin Meng <bin.meng@processmission.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] x86: cpu: Implement cpuid() through cpuid_ext()
Date: Sun, 11 Oct 2026 15:05:59 +0800
Message-ID: <20261011070600.2788775-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011070600.2788775-1-bin.meng@processmission.com>
References: <20261011070600.2788775-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0076.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::10) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|TY0PR02MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: db5770c7-8ee6-433d-29c1-08df276625b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|3023799007|261009223027099003|5023799004|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: YYvwRvkI3xg8qECRr97vpbwPxxa6JxXG3MUgT5jlQtZ+TBiOzSWFc8yEzNBVbIidiol8lfIqcFcaHRmE3NO2CHOhIhc9YXxj3hRLly938PyHK/JGZfEZUd6+D2Rj1vFZEDY7/GNycY65odN/XfpSEk6XbfbI7nfsQlEIpm4ig2dfdW2dmcRfAjirtZMSSkkE+lkFO6XcxRy3c1kfljOzklGpRH9oqKh84SQNelbPw720B6iTYYpJT3TJAnLvT9Vqw/s2WtRrQoc5KHEq+qGdsOfvbtVZRxqsmYJSrOwTbSyH6JgO7hTV86hvWaj9PiwMMA2SqT0FttvJVepHy6Y0RUi1tr9/vDM95P6sAbGhWOIZiZxyxap1Qx6iiGnQCo1DeOfhvIjJFZm1UuIZGJ1DQUmA5S1xS9S2FpTLfDQ1cr6LhZLpV+ekhY/IIMsVGV4sI3K35n7+vA6oFiEqdWpC13a+LuG024P0D6J0SCbL5Z8blL2LYOsq8bRxO2iTfB6mfm/+Jz1xs3HZ1g6kjZ0qsC42vk91tkyH0sXm8ifHj4XvA9v1IBw/LdwCUKyMJ5icYjuwepl7S4lqAMDb1WSsT3l0i+97ZoqQ9R0d6qQYLQtxzZttmxJ7rH3s6wDTI70oTAEEsPYT8sFkf2oAhpKIYl8f9OGxTKUN8Bsi4z29ABI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(3023799007)(261009223027099003)(5023799004)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k1nUalT/PCrOf5uQ9e5pM2u4KLYW8juR9nPxxCogo54F/9h5Ohk285Maly7k?=
 =?us-ascii?Q?TsN7ozj/5XYDt+eHd/P0HnE+yEOfabzQ9Of8xwiey8/Q2P1n6t865jy/4Aes?=
 =?us-ascii?Q?XD83a8o/OsjVoYqr2qgLiWrIZ0vR1+IUfpb/JmMMJ/xI2HTo8n55JMmv5Dc3?=
 =?us-ascii?Q?M6PNQHOw9fioX3plL2QhhKUPzYyeAFZnl2/vMIdzEL40Z2fILaSEFeuFAlV1?=
 =?us-ascii?Q?Nun2t1CzHaFTTGnT1VZY8pv1YUt22HbFf5of2nJwNc+mCK/WxhBKjv26KPoG?=
 =?us-ascii?Q?cLBlibkpfwzJ5Dm6wGfMFbxV1M3U/n3Jn3k1D2VilIGgeiJpHSA08Wc5JwgP?=
 =?us-ascii?Q?+ZPUH7Xt+aK9q68+pNMJsZnHjUlkcJ6FvlKoWe4OcFM8eLkzFqmsyhyddBwI?=
 =?us-ascii?Q?E1tbl+e8PNmu542KEwGDRH8SRxwNDz0yDUTOSGptES7mf+A8DR0TIQyWoJVh?=
 =?us-ascii?Q?9/2Kk6Clpx3Ax8Jqla3BLyKzGZeVlgFM3UsepHY07eMWKEzNiUHAFgis/ymC?=
 =?us-ascii?Q?dH+xi+sX7v6YKZgF7FQyc2F7vMAUGkbZz2005okr+T+Uc43f4JwfI1Rv6vpK?=
 =?us-ascii?Q?j6H93y+HebMmrU8x0TZML4ceWHbbJGWwLbElS0acynmtrHKAymt6jzXFeVpd?=
 =?us-ascii?Q?rw4fvgDP5PSUSxeVtmN35nXyj6dL2wG2bGoO0Ahvhb9S01fHE7zB5DZ08kP+?=
 =?us-ascii?Q?+szO5RflxDALx5xhavxCw3D7gbX2AxlS1qoK3UwJjcgzLhIdaMWkIqU4odgF?=
 =?us-ascii?Q?TlmTrytxQtj2lgk9otaKv3mMWZ8liynCEj7fUCIiaMtsWKFDRKhS1/eMr+k0?=
 =?us-ascii?Q?XbBJ50OZGwjPKV21fj4yFZ9oit/DtoX/cqWPJBX+5HcHZ3H/4Izq0JtsErB7?=
 =?us-ascii?Q?/F5jdcyOvRZ+DGNKCqZio//jwShMsd4xNtSdffeCqOvP2eD5NSJoJuI5CbMx?=
 =?us-ascii?Q?6lOGxj0dDDdSzz6fLFAbsoDVtaGlElM9Phugza7rhy8lhz3V98XjvEf/Mb5c?=
 =?us-ascii?Q?m5amfKdVVKYQJ1QWLd0u9gUgWoKG465m8DazWZ1MDY+XdSSGjYhPJ2c/VeLj?=
 =?us-ascii?Q?BjfWWb8L2fitnGhFGfhlqTv0hIaUdy6RUJAEQxGY8PcLGHrtVAZBzx/sH8Eo?=
 =?us-ascii?Q?o3s2sjhKgF+nha04sjTo3yqiKRc+IUD9FVi0VLTqg9H6ZZilyzfVXjRM6Phk?=
 =?us-ascii?Q?rRAUUyDMGUb6w7eIU0l/psBO+0oMDugXHaoG1aYnHxtNwsVp5NrGV0EeiBm/?=
 =?us-ascii?Q?fPUksRBwOTWOpDGFoHfn36W2ejDdGPPLMP0w1h+v65CXwja/KuFRhhnbpLtO?=
 =?us-ascii?Q?WDXVKfYSzUDthsjThnIuQcoMcT1p0EhgSsW9HRJBi8AGj8f94Gfoju7dSAyN?=
 =?us-ascii?Q?Z5mQb4QmUKvwV2WAEAJV6pLoiJNnZ4use58XN62Dhp6Q+uOrW/AmRzb9+Lnl?=
 =?us-ascii?Q?1umdo1/RK/hQNL9bdQvjzonakCGmr+5PLZuL4/B91g54QATIQwSxSw7Fh8tn?=
 =?us-ascii?Q?jCl+woNPp54+IlmXnKIYpk4pHb1e+46lxxGf39RAzBxG2nmzk7Hjx6cGOsT7?=
 =?us-ascii?Q?/+MwdTsZdrd9XFx3pz456iLpCHjAkpwzzumN0jO8RVdHc8QIOC6MHxE8V+aa?=
 =?us-ascii?Q?0enMDYMIJWGpDmZjpDT/+VmS5LjrJeDtV9PgsJJgaok3tkhoLETpHSp8syDl?=
 =?us-ascii?Q?4YQO+0vDXaEiu+7Nj2oo/50Ts0LYdmlB2MiKsILeVCw4l2irOyurk1AQgh5+?=
 =?us-ascii?Q?dIolRmBtdSfDQJrRaofOxFsMbo4TSjg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5770c7-8ee6-433d-29c1-08df276625b8
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 07:06:18.4151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWeVgGAaa7F+PIcj1tAQeqi87nwYd9vQJ2zXCvEimQnF9mE3XM92mRs8rbC3bA9/v3v+ygdbL6m9qeqC18AA10+lvG1eW2/K1AwROSz53RE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB6983
X-Mailman-Approved-At: Sun, 11 Oct 2026 14:39:24 +0000
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

cpuid() duplicates the old EBX save and restore sequence and leaves
the ECX input unspecified. This is unsafe in long mode and makes
queries of indexed CPUID leaves depend on the incoming ECX value.

Call cpuid_ext() with subleaf zero to reuse native_cpuid() and provide
a deterministic default for indexed leaves. Keep the existing interface
so callers do not need to manage individual register outputs.

Signed-off-by: Bin Meng <bin.meng@processmission.com>

---

 arch/x86/include/asm/cpu.h | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index a28bc75def6..9c39ffee062 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -69,26 +69,6 @@ struct cpuid_result {
 	uint32_t edx;
 };
 
-/*
- * Generic CPUID function
- */
-static inline struct cpuid_result cpuid(int op)
-{
-	struct cpuid_result result;
-	asm volatile(
-		"mov %%ebx, %%edi;"
-		"cpuid;"
-		"mov %%ebx, %%esi;"
-		"mov %%edi, %%ebx;"
-		: "=a" (result.eax),
-		  "=S" (result.ebx),
-		  "=c" (result.ecx),
-		  "=d" (result.edx)
-		: "0" (op)
-		: "edi");
-	return result;
-}
-
 static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
 				unsigned int *ecx, unsigned int *edx)
 {
@@ -117,6 +97,14 @@ static inline struct cpuid_result cpuid_ext(int op, unsigned int ecx)
 	return result;
 }
 
+/*
+ * Generic CPUID function with subleaf zero
+ */
+static inline struct cpuid_result cpuid(int op)
+{
+	return cpuid_ext(op, 0);
+}
+
 #define native_cpuid_reg(reg)					\
 static inline unsigned int cpuid_##reg(unsigned int op)	\
 {								\
---
base-commit: 5e3b01c8466dbe45cd6a06299f8f4c7e8c1c2363
branch: cpuid

-- 
2.53.0

