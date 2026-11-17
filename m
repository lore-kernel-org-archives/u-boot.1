Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82603606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 01:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RpTKo2NC;
	dkim=pass (2048-bit key, unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=1e9TfY+N
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57CEF810AC;
	Wed, 18 Nov 2026 01:25:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qD-HSeHvmATs; Wed, 18 Nov 2026 01:25:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EA1D8810A2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794965154;
	b=NdaKdMfj3njpXzhm4n3s8HUfpNsvqZn/yY2H9qj34EK5Chmu7isfJsXEpdQmmv4ThAjc
	 IKJDI+Mo9FRE9lBtRC9YgbH2ypwrsNHcRaStZz28O8WuyIhdk1H+DDZ6ZYZ6L6IT8SWH8
	 L+Yiw31DajS8tOQzPYfIlhMxOx4VEkmo3EaRnZa367d30eadc1C9gT9jnvcx/sh4hJ0ED
	 sdBIIUzsgcZH5TMatXy0RWjwExE1bM4AQQwuukqXzalIw6Riqvr4tiwwAC/sknrzF83El
	 NB1AINax6ONhWUC1mdNfvq7P0yiW/oSNdBKFkj8u+yhBtvEEpPETVPygsgYj2EJfI1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794965154;
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
	bh=keI2UOskcz+T54Lq2AlxnYBl3aqyurxu6+gElXr26oU=;
	b=kxyf+NT0NGqfLQgwPbYWNozt6sEXodYswmPbYe8kJjpS+ETA5tgRIDVozezj88oX656z
	 IVU1EGpzfQCDFNsjcl4MROzxQqYZ8H7tVv4tVqc8pDE7D2iAQ0l9MMg8qpS2xJ+emASIA
	 3BRpE6xIgFSNDSbErhtdadoxxjR8AJvmlqPW4KNGibOXSBh0B0KXT1plPkTSbX6n9NaBL
	 78RX/YUznhxoTOq3c/xCfCz2awZRgC302UDjS3gj8I6mDeL6n4RMusIBzOsFkv7ph0Hje
	 N0WVTB/wOWsVYUpHZazAdDTcBzGT5AcX2wk669Cl6u25+USmQJXqxzb92zTcO2s5bnQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=iopsys.eu;
	dkim=pass header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=1e9TfY+N;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794965154;
	bh=keI2UOskcz+T54Lq2AlxnYBl3aqyurxu6+gElXr26oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RpTKo2NCQkY6Gm4HWGP56xvnX6jaupsrHRLsT8+HGyEFGCG7p2nRzkbTA/9c3nNq3
	 9oWGOr/eO8FA5+Sa+qSxgQEtUCJUm7memA2Cvz4XiyJ64KcsMydaIjajJjTvfpPOOA
	 UOCbDyWN1LMkzhVQ4D4LrRNK4khkANKWusG8U82TKvoKNjJn/WZJ5uhP8KzbTSmE01
	 ShD4tlqJZ6xSWhcOs5ieBgB+m+nwpFp+XSYRKxe3TL+kR+hYZS6+Ci6LO8MXLKvchM
	 Dg0EPzU6/ZS6hLDrx6DG/2myk+S8QQZguFeouhTAZF7EsILA4YTLPC34NQHQ0FcCCA
	 C0HvKui24+Ahw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA1D8810A2;
	Wed, 18 Nov 2026 01:25:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 162BC105
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F115580EF4
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:05:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VVKJuUKGeOBu for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 22:05:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E416480F5C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=1e9TfY+N
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E416480F5C
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keI2UOskcz+T54Lq2AlxnYBl3aqyurxu6+gElXr26oU=;
 b=1e9TfY+N4o8pffWCxjvovuKRrBMAXvHvT5MdKeNCddHTErvpM9dRvWtuD0CbM9P9FXqlRN+j58xLH7OHC5PILGVADpEa0JvxDQaHl+DSROyuRFGZ9FRg1tQDFTRPFX3/+3A1qpq9Q2ZHzXfEWB2NcZ10WsTQFyh3e6rnVmryrzA9c8nubKjnC9aFTwJM8PU0eMFqJrrniX0zqJ1IIZl7rR4EoI8OND1gZTTQLyaJq5DyKfWsqqexst1MhWjMQMdAWrlVhhGThbhlPb1nX65FifbEbAtGZQQZ3m93oTYRgCJNuUHZJLWlABUNTThZQYM679g7sQWQzElJ7IK27Dyutg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB8750.eurprd08.prod.outlook.com (2603:10a6:150:c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 22:05:09 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:05:09 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Daniel Golle <daniel@makrotopia.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Aleksei Sviridkin <f@lex.la>,
 Zunyi Hu <roberhu001@163.com>, Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Mark Brown <broonie@kernel.org>,
 Yuho Choi <oss.patchbox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Peng Fan <peng.fan@nxp.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Akshay Belsare <akshay.belsare@amd.com>,
 Cooper Huang <cooper_huang@aspeedtech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Cole Munz <Munzzyy1@proton.me>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 2/6] spi: spi-mem: Transform the read operation template
Date: Wed, 18 Nov 2026 01:04:45 +0300
Message-ID: <20261117220449.3134408-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117220449.3134408-1-mikhail.kshevetskiy@iopsys.eu>
References: <20261117220449.3134408-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: 091e9a10-224b-4d3c-9c2a-08df44f6d84e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|23010399003|38350700014|921020|11063799006|56012099006|261021130227099003|261028144727099003|261022113327099003|261022075727099003|261026130827099003|261022115727099003|261026135527099003|261021133027099003|261021123027099003|261022105027099003|261021121427099003|261102123227099003|261026140227099003|10067099003|261026121527099003|261102130727099003|261021135927099003|261009223027099003|261009221227099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 80XCMpKfdf5J6fM9+GlKaDlHz4dscCCQAeUrQ+WrISvvec7V/bL0O7wryJfoPSekMD8XE8iRKisH7WYXfKO2UGZWV3jxGvkIYHrzum1DfFs1RyZr92D9kYam06hcd3EtYUWz7W2v70emUsfj+PUGa/oSp8ky2kGDlt+pEcnd5Q/SPflZsjtWz0ejkaDkGsoJp8r17xcqlVrW3kQ8qkeHOhL23qdCLddrvRRCCSAeoFXeBTTOjkANPgOB800Oo5NqMC++9QKYCcZ7H8JTzX10saWeilcqleQOwrRzbYv4FyS4DjdzxxPmEjvfYrixcAM2HeNH+uBANIITfigKkHLrTVhu3gzphGyLCfob9LefyFJhtctVPyWSQJpbHMi4UoQLxX5n/KfzCUi/J0cQm0Ee+cTOWAQ+JuFc6Z6JCQwH7gTxKWI07i+YKjGGkBanbHLTSGfURnj8FSY1hZpv5ZnTLG3/eZzJLfHXdK7y+hws5UTMICyoau4rf+CJkwQ2ePFaYbixKARjW8zGLdvQlseEP1TpoBINdiWKco3hM+Io92gh2yZxI0+5fOp0lsjlXnisnxQEi8IZ12q1s28iiLYxtWnpPKLd4+Tgnw9XGtcnPhej+sZtFavgmKi/pwVpMBpkSflvn7v83Pw4h6Yv3Ba3oUAmMqU5eyISRFpZNHrq8iAN7ASSGnvYAUIOxVFIlZcXoZPFEhuJ6/MzekTxZukxsB3f+iDFlYfOJfmdgoC8M2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(23010399003)(38350700014)(921020)(11063799006)(56012099006)(261021130227099003)(261028144727099003)(261022113327099003)(261022075727099003)(261026130827099003)(261022115727099003)(261026135527099003)(261021133027099003)(261021123027099003)(261022105027099003)(261021121427099003)(261102123227099003)(261026140227099003)(10067099003)(261026121527099003)(261102130727099003)(261021135927099003)(261009223027099003)(261009221227099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LOCw1JR7HVUasbmH9P00WFhz2uN5c7TaNw877MJGkdWLLXN0dPA9K1gniWW4?=
 =?us-ascii?Q?m1wFP6pmjR9p6HoAEQD34Gm0u8SSzNWtXRMvgY41mHeliTS5PRhXndWu3RKZ?=
 =?us-ascii?Q?FFAfsZ+11pNlZC92SBFUXL8ntceYE2Q2dw2Nm4o77/LZF5lK0PMTZsvglP7J?=
 =?us-ascii?Q?zMCXMOMael00WDCGkt+2vzF+KcK3c6era9xmVZLMI6oSFsva9g/pNjhRnakW?=
 =?us-ascii?Q?5L7B1pnFtD8huqUsQxrVHbC7JdXbNNcj+GGyBX7s0+YM8774CWgAEKtK+nR2?=
 =?us-ascii?Q?J7yHeYQgQbyjY1mQOhNhZQ9yf3MDWch56bPBImGAJ7CNmNqkmo1CUYA9qkOH?=
 =?us-ascii?Q?H6tch1pYZ+Nfwe2VMPCXJt33gdiq8XTbeP/jJXrU72HGYEFH4IBEwBrCrWPw?=
 =?us-ascii?Q?TenKGo1pkJI1dRD+4FXZ/LHesMZslIpKNklJhFoZzgVv9SwB6Kk48yivbG47?=
 =?us-ascii?Q?kf2uHkE+zjaNooy/39ReKIx9oVlYpz+rAzbaONL51FIdiJJFnArwbnRW3cvm?=
 =?us-ascii?Q?HjUvpQxJAdh5YW2N5wKgc6PKa5U4uN2/Los5+YOjlNNvmhJOpYg1bkmTxWai?=
 =?us-ascii?Q?1aFbcdrDXWIaZPbUrBpzi+iiEI4i+H8F6VfrefkTBv5J0cUFEcjdx7mAMfhC?=
 =?us-ascii?Q?jKvnUGPoWCqvE31KGhigs7NvDqczfkNpqsacTD6XpBkdIjOOvG1pglFopcLE?=
 =?us-ascii?Q?vGNvysFBtr98MO6pfaH9GBL7rGjQ5FxCtv3/cuumYQHVqMANvmW8kMLRfP7R?=
 =?us-ascii?Q?LwK8q0DzW8H4f25jUFBtCCQYRlROIZ1coajiudAXZwfPYw9PQOHK1pKVhJrY?=
 =?us-ascii?Q?BmpYHgopdMTFttq8l6NrADBaacOzi/SoRGinMBdu+KdKhvuypXyDvLLFP9Pm?=
 =?us-ascii?Q?AksbCdBX20M5Lc8M308aj5tjmIa4ACDIhtGFJxwKt6sjiv7i+AqQ7GCn51If?=
 =?us-ascii?Q?JGIcEbe0XUa3sLc/k7Tc7K/zdDbbNgG9CKe40sExssE4m1iafFGcpsSggDaO?=
 =?us-ascii?Q?4ZK3ZPjrT3SPvLerfUEY5OXA6DOzTVrBhxaEOhbA9GBmJsLRWVgC1eBcv9mZ?=
 =?us-ascii?Q?UBUKjKDev9Y4G3lhVTlMZJO3pH+OnrvsPEz5Ug1Vq9q79E6xklpZ3ZohzlfU?=
 =?us-ascii?Q?GIaDDmUCE/+n5D5EKSNN/0YBWhYoXlU8LDfQ27o/W4vtgzoLOjz817oMBAk7?=
 =?us-ascii?Q?MHmIsrrrkuvDsWmkcXBPyFd05NwUdWrOVMdqBWyz8Rk6SXEGlnu80otBmDHH?=
 =?us-ascii?Q?xSnpL4J8w+D+2/e7isiP5Lq52IoslF+m6sfD0KPbjWEUoWFX7bLsW5gQ6k2y?=
 =?us-ascii?Q?T4eCuTR3lI60gAQtvEal5Q6s20dBE8uzeCMQVSbQYPo5mAyha9DWB85Z3cAy?=
 =?us-ascii?Q?tF6vBMGk4CSZYWvd4LWRaQ+LpxC0yIlQ5b7kjKvj8jv26yDH/7GiqcV8hSMD?=
 =?us-ascii?Q?YJyAk8LMzYBZCYEL+mfJCQQZdj569gtRWmO4NvKXe3g5688Fb8fjKGMxzFrw?=
 =?us-ascii?Q?AxfLU7VG6Tg3M36wCXurUO6JNzf6qjcNQoa1WqmelLqfwWN2Myv9pDj09zNk?=
 =?us-ascii?Q?nHeSkJh6Z7btTYlLFGhrvPFDtIWyxd36jU9ILO+UFg2R/Fjv/4KxXVgB4wsB?=
 =?us-ascii?Q?oMAa7OZWc4yM2oXw+bwDYiBtHtpu5Tof79Jf7wqYfJCTQfSVlz7ko/R6Z9S6?=
 =?us-ascii?Q?S1kVqmXMCVmvjqZP7jpA7pZvu0AH3WBQ6oGkJPYKhCQ0l2xzlptrSheSyl1e?=
 =?us-ascii?Q?6sHAGZgte06RgOnHrp0WfcuSxcvasFs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 091e9a10-224b-4d3c-9c2a-08df44f6d84e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:05:09.4611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWslPB+Nh95r4pbdRlI+qXaV+2SR4QkYgsCx0yuePCJzo5GXU159IebUe8vX7ksabXYBHhb37FxZ3tOi6Nab+NDjC9KG2w9DZFzvGbaplnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8750
X-Mailman-Approved-At: Wed, 18 Nov 2026 01:25:48 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Miquel Raynal <miquel.raynal@bootlin.com>

As of now, we only use a single operation template when creating SPI
memory direct mappings. With the idea to extend this possibility to 2,
rename the template to reflect that we are currently setting the
"primary" operation, and create a pointer in the same structure to point
to it.

From a user point of view, the op_tmpl name remains but becomes a
pointer, leading to minor changes in both the SPI NAND and SPI NOR
cores.

There is no functional change.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
[Linux commit: 39d0ea33123ffe0214217b529830ad91574c8757]
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c    |  4 ++--
 drivers/mtd/spi/sf_probe.c     | 22 ++++++++++++----------
 drivers/mtd/spi/spi-nor-core.c | 20 ++++++++++++--------
 drivers/spi/airoha_snfi_spi.c  | 10 +++++-----
 drivers/spi/spi-aspeed-smc.c   |  8 ++++----
 drivers/spi/spi-mem.c          | 15 ++++++++-------
 include/spi-mem.h              |  3 ++-
 7 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index fb8ca0a787d..14a8703d34f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1174,14 +1174,14 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	info.offset = plane << fls(nand->memorg.pagesize);
 
 	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
-	info.op_tmpl = *spinand->op_templates.update_cache;
+	info.primary_op_tmpl = *spinand->op_templates.update_cache;
 	desc = spi_mem_dirmap_create(spinand->slave, &info);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
 	spinand->dirmaps[plane].wdesc = desc;
 
-	info.op_tmpl = *spinand->op_templates.read_cache;
+	info.primary_op_tmpl = *spinand->op_templates.read_cache;
 	desc = spinand_create_rdesc(spinand, &info);
 	if (IS_ERR(desc)) {
 		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc);
diff --git a/drivers/mtd/spi/sf_probe.c b/drivers/mtd/spi/sf_probe.c
index dee03662d45..0d01753b884 100644
--- a/drivers/mtd/spi/sf_probe.c
+++ b/drivers/mtd/spi/sf_probe.c
@@ -21,14 +21,15 @@
 static int spi_nor_create_read_dirmap(struct spi_nor *nor)
 {
 	struct spi_mem_dirmap_info info = {
-		.op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
-				      SPI_MEM_OP_ADDR(nor->addr_width, 0, 0),
-				      SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
-				      SPI_MEM_OP_DATA_IN(0, NULL, 0)),
+		.op_tmpl = &info.primary_op_tmpl,
+		.primary_op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
+					      SPI_MEM_OP_ADDR(nor->addr_width, 0, 0),
+					      SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
+					      SPI_MEM_OP_DATA_IN(0, NULL, 0)),
 		.offset = 0,
 		.length = nor->mtd.size,
 	};
-	struct spi_mem_op *op = &info.op_tmpl;
+	struct spi_mem_op *op = info.op_tmpl;
 
 	/* get transfer protocols. */
 	spi_nor_setup_op(nor, op, nor->read_proto);
@@ -49,14 +50,15 @@ static int spi_nor_create_read_dirmap(struct spi_nor *nor)
 static int spi_nor_create_write_dirmap(struct spi_nor *nor)
 {
 	struct spi_mem_dirmap_info info = {
-		.op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->program_opcode, 0),
-				      SPI_MEM_OP_ADDR(nor->addr_width, 0, 0),
-				      SPI_MEM_OP_NO_DUMMY,
-				      SPI_MEM_OP_DATA_OUT(0, NULL, 0)),
+		.op_tmpl = &info.primary_op_tmpl,
+		.primary_op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->program_opcode, 0),
+					      SPI_MEM_OP_ADDR(nor->addr_width, 0, 0),
+					      SPI_MEM_OP_NO_DUMMY,
+					      SPI_MEM_OP_DATA_OUT(0, NULL, 0)),
 		.offset = 0,
 		.length = nor->mtd.size,
 	};
-	struct spi_mem_op *op = &info.op_tmpl;
+	struct spi_mem_op *op = info.op_tmpl;
 
 	/* get transfer protocols. */
 	spi_nor_setup_op(nor, op, nor->write_proto);
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 7bc889c9629..d568b19058f 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -401,15 +401,15 @@ static ssize_t spi_nor_read_data(struct spi_nor *nor, loff_t from, size_t len,
 		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
 
 		if (CONFIG_IS_ENABLED(SPI_DIRMAP) && nor->dirmap.rdesc) {
-			/*
-			 * Record current operation information which may be used
-			 * when the address or data length exceeds address mapping.
-			 */
-			memcpy(&nor->dirmap.rdesc->info.op_tmpl, &op,
-			       sizeof(struct spi_mem_op));
+			struct spi_mem_op *tmp;
+
+			/* temporary use another dirmap template */
+			tmp = nor->dirmap.rdesc->info.op_tmpl;
+			nor->dirmap.rdesc->info.op_tmpl = &op;
 			ret = spi_mem_dirmap_read(nor->dirmap.rdesc,
 						  op.addr.val, op.data.nbytes,
 						  op.data.buf.in);
+			nor->dirmap.rdesc->info.op_tmpl = tmp;
 			if (ret < 0)
 				return ret;
 			op.data.nbytes = ret;
@@ -447,10 +447,14 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
 	spi_nor_setup_op(nor, &op, nor->write_proto);
 
 	if (CONFIG_IS_ENABLED(SPI_DIRMAP) && nor->dirmap.wdesc) {
-		memcpy(&nor->dirmap.wdesc->info.op_tmpl, &op,
-		       sizeof(struct spi_mem_op));
+		struct spi_mem_op *tmp;
+
+		/* temporary use another dirmap template */
+		tmp = nor->dirmap.wdesc->info.op_tmpl;
+		nor->dirmap.wdesc->info.op_tmpl = &op;
 		op.data.nbytes = spi_mem_dirmap_write(nor->dirmap.wdesc, op.addr.val,
 						      op.data.nbytes, op.data.buf.out);
+		nor->dirmap.wdesc->info.op_tmpl = tmp;
 	} else {
 		ret = spi_mem_adjust_op_size(nor->spi, &op);
 		if (ret)
diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 769ec956793..30feaca25e6 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -545,7 +545,7 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (desc->info.length > SPI_NAND_CACHE_SIZE)
 		return -E2BIG;
 
-	if (!airoha_snand_supports_op(desc->slave, &desc->info.op_tmpl))
+	if (!airoha_snand_supports_op(desc->slave, desc->info.op_tmpl))
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -565,7 +565,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	if (!priv->dma) {
 		/* simplified version of spi_mem_no_dirmap_read() */
-		struct spi_mem_op op = desc->info.op_tmpl;
+		struct spi_mem_op op = *desc->info.op_tmpl;
 
 		op.addr.val = desc->info.offset + offs;
 		op.data.buf.in = buf;
@@ -584,7 +584,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
 	 * replace them with supported opcodes.
 	 */
-	opcode = desc->info.op_tmpl.cmd.opcode;
+	opcode = desc->info.op_tmpl->cmd.opcode;
 	switch (opcode) {
 	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE:
 	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST:
@@ -767,7 +767,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 
 	if (!priv->dma) {
 		/* simplified version of spi_mem_no_dirmap_write() */
-		struct spi_mem_op op = desc->info.op_tmpl;
+		struct spi_mem_op op = *desc->info.op_tmpl;
 
 		op.addr.val = desc->info.offset + offs;
 		op.data.buf.out = buf;
@@ -782,7 +782,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	/* minimum oob size is 64 */
 	bytes = round_up(offs + len, 64);
 
-	opcode = desc->info.op_tmpl.cmd.opcode;
+	opcode = desc->info.op_tmpl->cmd.opcode;
 	switch (opcode) {
 	case SPI_NAND_OP_PROGRAM_LOAD_SINGLE:
 	case SPI_NAND_OP_PROGRAM_LOAD_RAMDOM_SINGLE:
diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index fb773c44fec..b6f3bd0685b 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -982,13 +982,13 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	struct aspeed_spi_priv *priv = dev_get_priv(bus);
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
 	const struct aspeed_spi_info *info = priv->info;
-	struct spi_mem_op op_tmpl = desc->info.op_tmpl;
+	struct spi_mem_op op_tmpl = *desc->info.op_tmpl;
 	u32 i;
 	u32 cs = slave_plat->cs[0];
 	u32 cmd_io_conf;
 	uintptr_t ce_ctrl_reg;
 
-	if (desc->info.op_tmpl.data.dir == SPI_MEM_DATA_OUT) {
+	if (desc->info.op_tmpl->data.dir == SPI_MEM_DATA_OUT) {
 		/*
 		 * dirmap_write is not supported currently due to a HW
 		 * limitation for command write mode: The written data
@@ -1058,12 +1058,12 @@ static ssize_t aspeed_spi_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	int ret;
 
 	dev_dbg(dev, "read op:0x%x, addr:0x%llx, len:0x%zx\n",
-		desc->info.op_tmpl.cmd.opcode, offs, len);
+		desc->info.op_tmpl->cmd.opcode, offs, len);
 
 	if (priv->flashes[cs].ahb_decoded_sz < offs + len ||
 	    (offs % 4) != 0) {
 		ret = aspeed_spi_exec_op_user_mode(desc->slave,
-						   &desc->info.op_tmpl);
+						   desc->info.op_tmpl);
 		if (ret != 0)
 			return 0;
 	} else {
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 1c23f3d8843..351ca725524 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -572,7 +572,7 @@ EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
 static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offs, size_t len, void *buf)
 {
-	struct spi_mem_op op = desc->info.op_tmpl;
+	struct spi_mem_op op = *desc->info.op_tmpl;
 	int ret;
 
 	op.addr.val = desc->info.offset + offs;
@@ -592,7 +592,7 @@ static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 static ssize_t spi_mem_no_dirmap_write(struct spi_mem_dirmap_desc *desc,
 				       u64 offs, size_t len, const void *buf)
 {
-	struct spi_mem_op op = desc->info.op_tmpl;
+	struct spi_mem_op op = *desc->info.op_tmpl;
 	int ret;
 
 	op.addr.val = desc->info.offset + offs;
@@ -632,11 +632,11 @@ spi_mem_dirmap_create(struct spi_slave *slave,
 	int ret = -EOPNOTSUPP;
 
 	/* Make sure the number of address cycles is between 1 and 8 bytes. */
-	if (!info->op_tmpl.addr.nbytes || info->op_tmpl.addr.nbytes > 8)
+	if (!info->primary_op_tmpl.addr.nbytes || info->primary_op_tmpl.addr.nbytes > 8)
 		return ERR_PTR(-EINVAL);
 
 	/* data.dir should either be SPI_MEM_DATA_IN or SPI_MEM_DATA_OUT. */
-	if (info->op_tmpl.data.dir == SPI_MEM_NO_DATA)
+	if (info->primary_op_tmpl.data.dir == SPI_MEM_NO_DATA)
 		return ERR_PTR(-EINVAL);
 
 	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
@@ -645,12 +645,13 @@ spi_mem_dirmap_create(struct spi_slave *slave,
 
 	desc->slave = slave;
 	desc->info = *info;
+	desc->info.op_tmpl = &desc->info.primary_op_tmpl;
 	if (ops->mem_ops && ops->mem_ops->dirmap_create)
 		ret = ops->mem_ops->dirmap_create(desc);
 
 	if (ret) {
 		desc->nodirmap = true;
-		if (!spi_mem_supports_op(desc->slave, &desc->info.op_tmpl))
+		if (!spi_mem_supports_op(desc->slave, &desc->info.primary_op_tmpl))
 			ret = -EOPNOTSUPP;
 		else
 			ret = 0;
@@ -778,7 +779,7 @@ ssize_t spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	struct dm_spi_ops *ops = spi_get_ops(bus);
 	ssize_t ret;
 
-	if (desc->info.op_tmpl.data.dir != SPI_MEM_DATA_IN)
+	if (desc->info.op_tmpl->data.dir != SPI_MEM_DATA_IN)
 		return -EINVAL;
 
 	if (!len)
@@ -818,7 +819,7 @@ ssize_t spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	struct dm_spi_ops *ops = spi_get_ops(bus);
 	ssize_t ret;
 
-	if (desc->info.op_tmpl.data.dir != SPI_MEM_DATA_OUT)
+	if (desc->info.op_tmpl->data.dir != SPI_MEM_DATA_OUT)
 		return -EINVAL;
 
 	if (!len)
diff --git a/include/spi-mem.h b/include/spi-mem.h
index 8c20feebfca..81166492da2 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -211,7 +211,8 @@ struct spi_mem_op {
  * direction is directly encoded in the ->op_tmpl.data.dir field.
  */
 struct spi_mem_dirmap_info {
-	struct spi_mem_op op_tmpl;
+	struct spi_mem_op *op_tmpl;
+	struct spi_mem_op primary_op_tmpl;
 	u64 offset;
 	u64 length;
 };
-- 
2.53.0

