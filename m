Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672CE606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U//wGL3z;
	dkim=pass (2048-bit key, unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256 header.s=selector1 header.b=rWM+h36p
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42414409C4;
	Thu, 26 Nov 2026 13:34:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ppLUiDh_vbx8; Thu, 26 Nov 2026 13:34:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1F0E9409D4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700047;
	b=boFyD5XNlXhB80ejKk3vGnaDfb1QINjoBl3wMgVq3RmiSD0D/MR5i3ubM1so4BGK/K4U
	 KGNLl/VJoPzF5XUCITe5Rqaya++h9X37Wc3JVG5V65dVM/jiyVr/g88hxCfjOaATnGHqO
	 /eFxDXyBA20ftBX1lZqGIJ3kAaKNjwh6xDD0gsCpptLpvjsLlsFNZOshVSV0Ep9FkZ95K
	 IMTwi2vTGpfMSFhfIUobOVu7j9VakjatjXBe91u+JPvm2o2SLdSoni16E6RrJDlQNmojP
	 NvJGqtw4Dssw7YcIyuvnuMxO8Nqzjgwjo5YCRAJund0EFJttEQq+BUnZZb9YUSedozg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700047;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:Content-Language:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sZH4iqKjid+Wr3dOE6a72T1gw0/kYYcq8kkrbnF+mj8=;
	b=F0GWREAdZqiH88IKzySFXtpyix3DaSA3T8XrEjV1/qmx4E4Na7LwGJ14+U3oW4gEqzGk
	 GyUrCkY2Pzk9j5pref5IGPoNPDyXQcELYwodeK0iHlc0bm9yQE+myIy0I4F9vEnW75L8j
	 yUo/SmN4nwaW0UQsRmi4mTVa2FO/NBUEdfMuVojuk1Y49TB3hsOAE+q1Q1QeucAcHdZ/m
	 0ZhBf2HLmQtw7DHnAWXPjoENsJcmHK/qVLjC23zdlZx5TNN59ETI/AGQSoltgBYHBUopV
	 EtwnAnm4bcbT8Vdt11LBMrm4qhJzuiO61OBZDMqCFKLUquI3V6TZZu25LtFVgATaFew==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700047;
	bh=sZH4iqKjid+Wr3dOE6a72T1gw0/kYYcq8kkrbnF+mj8=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U//wGL3zAD3aEipAUHM7RaTGTbdXy2+3dhtqfyfL6zzA6ELFSTQEeNrp9pgvRgZ5T
	 jbhqWvRGAwL7XlXXW7BXeUU91HRVa5JuI+8Je775xuwsTbeFmQc1SuRZBvN4l7a75a
	 uTkrIEfcy2SQXi/ZcqEqy2+qVdQVLfn3GZZMr6wT5Rfzzck9G0O9/8GPm6xzpOmn+3
	 LgfCwlOFQ+fdAofMPzR8fs0euT90vnwlviZrQTs6ZMhEmCm4mjqre5EXDHgRz0GE7o
	 S9HnLiC1vYJu5DgFy2QcpWFXrqUeLvMK+hD4GL91KmsDtlyIsdpjctWCzkvFK6XwmR
	 FhSYws1N7XtHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F0E9409D4;
	Thu, 26 Nov 2026 13:34:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D843432D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 08:16:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BDFCE608BD
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 08:16:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Fec9RXOFuCp for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 08:16:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 03286608BA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=rWM+h36p
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 03286608BA
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 08:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZH4iqKjid+Wr3dOE6a72T1gw0/kYYcq8kkrbnF+mj8=;
 b=rWM+h36pc+MkaqjSwVgVYpTGqYHcw/Fdqzov7emojXrk7sfw2zGR8u0oofrk5M3+v8EG+tbXoHqZELwbXCQQhixhrRGt8krU93NhEQSQ34wupkZoxNeEgDNbpDZn8B1+XTNDZJgXfKB/yHam0L6coI48lzksMS9fBnaG27M2DXeHfvKnJrCZlugNmVh/ReIp0tYtU/kOgHimKlrgzaSOr78DZcWxWTeE2FAVQ/nEgj/ulAGSD+e0/Qf2dqemt4yNdY4J/GH0TbVkJkrZxO9lZsldFfWbqQNpmpsqXcO527BdnWe8mmfw/hHcgWDXwvnthfvTRBVOP+LxqfOofhqf1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by AS2PR10MB7069.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:597::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Thu, 26 Nov
 2026 08:16:16 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.21.0662.001; Thu, 26 Nov 2026
 08:16:16 +0000
Message-ID: <b75c6fcc-5e65-4821-93f6-f15f59d7f315@kontron.de>
Date: Thu, 26 Nov 2026 09:16:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] spi: spi-mem: sync code and behavior with linux
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>
References: <20261117224236.3150882-1-mikhail.kshevetskiy@iopsys.eu>
 <20261117224236.3150882-5-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goat?=
 =?UTF-8?Q?er?= <clg@kaod.org>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
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
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20261117224236.3150882-5-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|AS2PR10MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f476ae5-185f-4d3e-b9e4-08df4b958aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|11063799006|4143699003|18002099003|22082099003|10067099003|56012099006|261028144727099003|261026140227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: Sx4f/dXCxF/t2sFXpFESJW/QRrtx3TKIuDVVLvXUn1zw4OrFmGsSrL7gZVIWPMR4TfCgxuRUJF4t01LMEFdKWpZ+b0eUNNzV/NFPbXCdg3IgTa8uLqZer0tY2J+p6c9xE7zhshfa08FvvqC5Yc+f3M9PKKZVzSMOT82VSs0fBivm3/anK0axueBjQ55nb+URP2dR2LTNHtOvoY4IsX3gaRjEp2ZKxqqxSHAMeM3+groOpPFtL6XHR2jK/KTK/741uFuUD5fmCsiDav4nJ8funWpPhV8jYsCbbR4Wu+lQCWnUqoLtt1w0krWx0QW1GTpiMggTOkH6JZAKHhsFdO/9Mqq/eDH1ehgJR3Gw7eFyHjtaXb30qq7qIKQ/qmiO195s4Tg91QA74V2555pyb4B6AzAf3lBHCQvfsNK+QkwZyCT6/DH863zWBS3txu4q6Pt6lWnrzapdsLcbFByPJeA2Y4uwPVPGSlS2Y+G2VbfqyiQAgZv31B/6NWE3gmNzZtYX9um74SJrDlmO70ywU14bIpkSjJyyvsrx1bUe5BFTIO6VB+HcX0MP/oEO7OtMcPzj4WfcCbVWy4PeMCC2T/vDmcKfzy88nDtZ4QoC3vl01uaU3g0XwIErVYHqpPh6p0/Yu7ohu2FCicnzGBsFgryhbmNnTt6eK8EnMolA+pnXBNw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(11063799006)(4143699003)(18002099003)(22082099003)(10067099003)(56012099006)(261028144727099003)(261026140227099003)(261022105027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVh2TGZnYVpLYkpMYnA4aGZDU0RkcVBGRDViTnQzU3NFd0hzNy9OQ2JQZm1m?=
 =?utf-8?B?T3hOSjk3b3FvUytqUGxWL0hLOXJJSktHeGxDdWt2Y0ZrcHRuVnRJRUx5Ylhw?=
 =?utf-8?B?RGlCcEdFS09HbEc0VmNFNWt0MXczeDBmeXdBUTkrWUpQVE5hOXhhOUJSNkhP?=
 =?utf-8?B?TFh4QUEvWGpOZ1ZYOUFaOVhsUCtEVS8zd2VSdkcyN0pidjRXTlY2QTEvV0Vv?=
 =?utf-8?B?aC9Bdlg4ZGpXRmJDeDZxNUxkUWIydThOaVc3UnIweXdKZ0xWdnZ4ZnBTSW9k?=
 =?utf-8?B?WEo5eEN5VUorVTZMemZEaUo1ZGxHeE1QUisyU21vY283SlJDelV4WHJZZ1B1?=
 =?utf-8?B?ZkI2dG5ZN0xlODZwU3lyaERKYVpoVUFSNHFQUkdHaWpJaHpLMHF0MkxXMk9B?=
 =?utf-8?B?ZXpTSElYSmpIQlhJZWVZSUdTRERGMjdoMmk2L2g4bk5ZYVdFR3JLTkQzN0RB?=
 =?utf-8?B?RW9UWm9FaytrakQzazQxbVZ2WXphNDdVQXd6YTY2bEtudWlrWVlvVThycjlo?=
 =?utf-8?B?K3ZmRUtsRkVnT1RqK0xOTDRBRmgyazFFM2xRR2ZhR1BuUGRIT1NYUHJjam9C?=
 =?utf-8?B?M1V3OXJLbXZzbjZXbUZnYlZuZ0wzM0MvZmFyWkdSYTl2eVp0d2hmYzZnLzly?=
 =?utf-8?B?VGw0MkRJRWlpcEZscEhlREVmdlFnUnJqTVM5eUF4ZEo4NFA0T1R4VUc3Mzgx?=
 =?utf-8?B?Q3cwd0pqQ2RPaHNLaTF3dGxVWW1qOGR4VkIwN0s2dTFnZWpudXd5eDQvZndF?=
 =?utf-8?B?VTR4ZnlUMXJoYTkyMXpiVWRIdlQzakgzZGduZlU3bWZBK3FwaFRvRTRiSmdl?=
 =?utf-8?B?NmJOTC9hZDMyOWgyN1Fsc0ZwQ1JDTm9TYlozVk1OSmN3dmxlcTRCckJGcEVl?=
 =?utf-8?B?bHlmV3RkTkpCOVRxODVONGorT2Q4RzJFb2U2MkNzb3pKM1F5YWpFQm0zWWl2?=
 =?utf-8?B?OWEzSGZtd01oOXc5VTFCYjY4eU0rU2J6dGtvQjNkdVBpcmI5TnJPd3BXREdr?=
 =?utf-8?B?ZVMxMm0zQm0yMEhlRDFwOU9GMzJVSG0xdGFvVjAxYVZMcTRZUVNaUEZ6cW5S?=
 =?utf-8?B?ZGdjNWlpajhySkU5ZmZCQXZCZmsxVGJEcnZQUkpLbzhWdTVLOVoxVkJONWhn?=
 =?utf-8?B?QWNkOWl0bHRSQTZ6MkxSeDJWZUh5TDBweitYMDBOY2IvMVhBN0E1MzJPbjlC?=
 =?utf-8?B?aWx1ZjNDazNmRDhOZEtOWTBaSFJQMzlUOTVPUWpoWHUvQ3AwNS9aYzZTK0lR?=
 =?utf-8?B?VTRvUk00OW1IRFNyYzQ4ekhjQUpKeHA2M0d0c2dYaUFLelNoMzJFbmNqT2pV?=
 =?utf-8?B?cUtvaHQrRVE5TDlCZzVZdHByVnNVRyt3TTIzTytyeGJZK0U4ZHllaEQrMG50?=
 =?utf-8?B?dEVmV3ZpbVdTK0lqc1NIYk1NdHdHVnFVYXpIVVhkbTIzempOdUI1NkJadk9z?=
 =?utf-8?B?T3ZObGJwZmtTMzhBaGQyeVo3SU43SjREekdYSlFUdUlGMTVnaFNrcXRYdHRD?=
 =?utf-8?B?K3VYa3o0QXZGb0V4S1h0aW9URWJBQkxHWGtPb1U4Q3hSTVl5VVA0dzYwbzlI?=
 =?utf-8?B?NmYzaTFJaTNXQUpERVVKWFBvM1ZRN3pxU3NqbjZxek0xakUrdWRWd3AreUlZ?=
 =?utf-8?B?WHdqU2xPakN3cS9ySk1HUG5TbTBBdVNvblBnemhzQTN6UVkzd2ZKcGZ0NU8x?=
 =?utf-8?B?ejc0cXpRd1NOeGtMV1N3TFNsQi9RNUNmRjdGR0JvTlBXQU1DNHdtKzR3NElr?=
 =?utf-8?B?K2ZUdVJ5QjdQOEJPNVhRbWJKT0FkNFFCN0V3VSsyUTVkYlE5T1lGOUpiaWxK?=
 =?utf-8?B?Q1J6VlZOZGY3Ylo0bTRyaHArMUQzbmpQS2lTNFR5Y0wzZVVyS3F1TkpGLzNS?=
 =?utf-8?B?L0FSbTdPNkt0aU5JcktSTDR5WFdVZ0R4OG94UUh0b3kza3hMT1ZlbkQ1SzJR?=
 =?utf-8?B?djlWRGc3YUpneDhyR2dlTHI0NnIrY2ZBcFRBZnJpUWdaTytkYjVNay9TMTN5?=
 =?utf-8?B?REJRTmNlaDY4MUdtYVFITjlGOS9sWnJ5RnNIankxT3FjS2ptU3ZSbXJIL2Iw?=
 =?utf-8?B?STVuRmk1eTB1ZFh3K3pBUS9LOHJsNkpqQ1ZHN0hXczhXSnB4WXpOR2VCTnpu?=
 =?utf-8?B?MGpTRTlaRm41aEQ3TXM3Zjg2M1dCbGZKWlFGRTM0eEdwRjlabHd0M2tlZnZr?=
 =?utf-8?B?VjIydTJHcXEwOGczdWZ0OEdybHd2RHp2V1d2WlluS1RjYktNTHMyd3ZVMElt?=
 =?utf-8?B?bmJKZkZFZUxPbVNzZW11YklQT0hqbTR1NVBwd2FGYWdhcEd2UGphQlh1Q0d1?=
 =?utf-8?B?K3pzeDZ3KzRkL3NMYVg3L01oMTR5cDNqdnVTeDFtTmgyaFVHODhyTTgvL0Vn?=
 =?utf-8?Q?J9H80FiLfVHcE47w=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f476ae5-185f-4d3e-b9e4-08df4b958aba
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 08:16:16.1942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eH14VvenK64v5SMlj8oMsotaAdXIwmI6eVnOMI8ur9JjXEGPaiSwGWcZ086eDX32A6PKK4q4FyCOW754Or+Ms5B7Yr03AodbEriZbxEmkdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7069
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:33:17 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17.11.26 23:42, Mikhail Kshevetskiy wrote:
> Align code and behavior with linux-7.3 release.
> 
> Changes:
>  * add comments
>  * use the same error codes as used in linux
>  * add more checks for spi_mem_op
>  * add macros necessary for spinand dtr support
>  * remove unused macros
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
