Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49004606A323
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NraG+Vs0;
	dkim=pass (2048-bit key, unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256 header.s=selector1 header.b=l1wKBbsj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2770660A89;
	Thu, 26 Nov 2026 13:34:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BUxoJgSC6Q2G; Thu, 26 Nov 2026 13:34:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9D1D160ACE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700048;
	b=m5RPhjkvzONMBf5alq3yppZC1iZOjluACSG/INP5D2GOsRWVHVYdtYh+0tbi07ZmoKIP
	 kjBuj37GQ0DfmS2PkagIuFyDrZhukvUIw1/yhYJ40uPonchjzgdIRhkwK22lM5/4puG4I
	 FIuOvqU8yyeiG/yTJi7wl1FQ1tkLyiPu9soTOziqxclkntgbaDceCwghmwoak2+9v5onZ
	 o7oYsM0su69uUQPT/0QCLI4B/LLWyFZ4XhaxPsbmviu1sqMRT4jQJgXxkABiO/BnMUqiX
	 3OBYp5yLDhYg0OEF9Z8/+bb9TX1hspLlIdh5Z2VhrbJOOtQL0XJW4rX8lhk7fo8ps+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700048;
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
	bh=78D4bG3J4uA+eOCs22WsWtEgABI+j1aFpNbVMCPia7Q=;
	b=fjZYicoXJraOhDWa+Um0ctiDT58xv6proCF9E7RS8bKFlDmKfOqiJnzYh+NXQ0B1oxpd
	 qSr+JbTHRA/M1pVGRqOjDXDSh7XzG2EQMeSJta0KDHOErQ7lfxwMm8zKEGrVUUc3ur2Be
	 5H7Sr3FpvfzHvAuPgam/JhpkIaSwSj5KQk6tzFJtb8i0InoFiKu6sC+8sDS2G1px9r3EO
	 wx5L+o+4cUQ9MqFl9goEt3ySMn7eaUQnVgy6kgji+Pjdzt8jk6I1J7yQJ8RddVKcWyFsv
	 ovXrVsHVubk+dnBTqeYyTrfEudZ+7kDcyGT0RgWm+WEpEQlgvQoxB+7UPgNySEIt6uA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700048;
	bh=78D4bG3J4uA+eOCs22WsWtEgABI+j1aFpNbVMCPia7Q=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NraG+Vs0kmkJfaHVHRHCcGqs3JdsXsMrR7dwkjPVC14NsSBMku8T+FkyiymFpeMxU
	 6U2C3SPz/AcGCP/J3e05sqZxBQRtdM7qfc/ZDGQ6aHfHwbLaIDdx7AHgyycPBfpq4D
	 ilglQ58cUt//bR+eJyr6OzTtSjcxaZ01XfFEyouE1rXp+fq6922s68m3z4af3pdjsm
	 TnKYKF6HdYubNFDSSDnGsqYFInwLDlQVz3Geze+07rZjKGEdwixsDU3FnEBlq0ibJN
	 xzQiXSNBB6bqH7vCRiswRfnesrfaxewf0a01AMr837XBQH1d3ZVyvpn3si5d4QvhZ3
	 ppoyxetuOVc1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D1D160ACE;
	Thu, 26 Nov 2026 13:34:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C307243
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 08:22:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A88D040490
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 08:22:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sAux_m_GNgBW for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 08:21:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 015424048E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=l1wKBbsj
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 015424048E
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 08:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78D4bG3J4uA+eOCs22WsWtEgABI+j1aFpNbVMCPia7Q=;
 b=l1wKBbsjIZwK/ReF1L5e8VWYZTxevSwftFX0KC62PAT0/+GpQtkWVzO1Z6tfWVmeEBKgoHKvKgBUmP07MyR3HYUx2Ys0YSImjQY197G36OOKbcBj9J7N/epf4eGgmnGKeZOYtJ+vbvMe0Bgc6H3TIk6UHdpqUHMN4vwQwZqtUgzb9d8J6PqH4sR1vwdLntt/+BPSO6uyAYAk9dkbbb19wLHQ4/mSv0y/CPhKdV2+QlqdIfjmmVsB00E1hYGl/JdJWI3eEJNy4mdS2L9/5cWFlSoQpk3b9mOurYMPOwuC+D6GoIJoeKLCWtRzVM/HQ5wkCvHsWVLx4Y10IqewewqPnA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by GV2PR10MB7488.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Thu, 26 Nov
 2026 08:21:44 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.21.0662.001; Thu, 26 Nov 2026
 08:21:44 +0000
Message-ID: <061aa779-0c05-47f5-a799-9b207b8e26e1@kontron.de>
Date: Thu, 26 Nov 2026 09:21:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] mtd: spinand: sync core code with linux-7.3 release
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>
References: <20261117224236.3150882-1-mikhail.kshevetskiy@iopsys.eu>
 <20261117224236.3150882-6-mikhail.kshevetskiy@iopsys.eu>
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
In-Reply-To: <20261117224236.3150882-6-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::18) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|GV2PR10MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f9dbb0e-de3d-437f-9ff9-08df4b964e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|11063799006|4143699003|261009223027099003|18002099003|22082099003|3023799007|10067099003|56012099006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: pRWMfuInBhRbZ9bBPzTj9MQ6KYTiN01OpWzBlhsfwabnqfA0ZWRGZXtH6ErofkL4rNgPgOSHCm6dvMvY8bU+ifVy+LlFSV0MJMN4w1ql8y4vlJFfOeEFiQOquuOJX1TEydajwbx16/8MluliEtwPxEfIM4Kyn9QlsDqFCzIdxywM3BJKCC+sWm4B1Os4XfGqSUAwnDvq4VH8pzZsucfIrBhwge1TKkhRHaSSn0PxWWrNrJkl119ci0nO1UtKpRh1lw6SKYBEWaqwOTD7nKsR1+L387Dw15QSHOAU+JUgvoGHwzAcTzrLu9DITq7AojffpH456jfSBIQWBzYskH+O8tz//QxmFoQI8yeuKuPKhp72h2fZUizZBZN/WOWX8+1bdgfdu3pl5XQ1/w2JZPm2hWaRl8wSQmodcBtHoweNaSJQlKqFddebvzlFJ3/7UPrixV+zysfHNxNYPqKlpGT5uA9zqayhCJt3yRbKeI66QyDYkOXB3cGZjljUr8BiuEmvoqfntls8VoLxTSAc1z/ZZl3qrQwoNyyrsNRv5M4nAginc5aGrnNEugHCR9ERzH4zcDeUQhLqLTH3aBdsra24OZ996XHgYVw2/dEBqZjkkHJ3Gvd4OX7SWGfTyUwqOSCD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(11063799006)(4143699003)(261009223027099003)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2xDbktFaUorb3llRGdMOG1pTlJETjhNMGFJSzZZUGx6YkF2SFJsWjhOemJD?=
 =?utf-8?B?dEZRMDdjOU5CVlBXTklxd0s1Y29hcWtJdFJid1NEQkpoVGgwYk1SRjBTYlNY?=
 =?utf-8?B?SSsvRXBsNWd6a3JMY3FQQUgyMFlKWkRBSS9va2NISGVxRXE0ZjU3VlR4c0M1?=
 =?utf-8?B?RXIxL3FydUdzeUNGT2JzcThqWjJzaXhiR2xTMmd4Y3lWVHM1bmVBcHUxWDBU?=
 =?utf-8?B?UkFadVBnbG1qRnJVK3B2OEpQSmZqTkl4ZW15VnBzSUFJU0htY0lEeVhkMmxx?=
 =?utf-8?B?MlgwQ3ZObHE5SnA0L3ZFQ1Roc0pHVm4vbUJ4MTVzMUZWcGNvWkpiNVBDd1lX?=
 =?utf-8?B?YTdGdmtTYVQxUUdsU1l6N2VtR0lTZDVBRHNDSnhneDh0Tzd6QU1Ra29nKytG?=
 =?utf-8?B?dWQvdHJSVmkva21GSWthWlUvMGpEaWFrN01UT0RtUzFidlAwRGp2cFVXaXdT?=
 =?utf-8?B?UHk1ay8xbGZidGlTMmo2NER1UUZCTFpKVWNnMTZXR0UwU2pkZG9nRng3YndS?=
 =?utf-8?B?VlVBQUxadStKWGlMckVyRzhOUEZWVEJKS3crQjBrSnlrQnRMRlJIUHIxb08x?=
 =?utf-8?B?V1U3aG1mWHJTblBlSHJhQ0MzZWsyMVBGUERONzJhK1pycU00WmhHd2lVNnAy?=
 =?utf-8?B?b1M1cDZQOTlzUnM0eTZ5YVFiZE5qelNJWURyVTFqcnZyRlpkb3ZmNmMyTUZ5?=
 =?utf-8?B?amNKekhENGVBMHVOQUZZUmZQT3MrRXR5d25kRFhpN2N5OFRrMVJ3SVJKdHdV?=
 =?utf-8?B?WVY3a0xaWHlqUXFlejFTb0ZqT1VWUWluNzRYOVF4Y082djVWdTljVkdWVGM4?=
 =?utf-8?B?b3Z2Snk2SGNiWHpjNzdydTZlSVBJYnJ1VGxhQ2NoeFhFMmxkMDZUS1MxKzJp?=
 =?utf-8?B?UDd5QUkzVHJIcmdXK2dZUkxVVGdiL3N2bHR1TjJOanVzL3dHTTNoWE9xYXgz?=
 =?utf-8?B?WXd1NXdxVnM5MEdEQUY3VWxlUnhzc0hSUG9Pd3dRZWlQZHFESm1jS0p2b25W?=
 =?utf-8?B?WUYxZEdrb2NyZmtwcXBRVEZQSmZISExHVTBUb2tEUU8vaG50K1U3Vml4VUJ5?=
 =?utf-8?B?Y2NFbkxrNGl2UkgvUk1sektFelA5d09QeVViQThlZ1NycWhDTkRXakVwVXdF?=
 =?utf-8?B?QUdIdzdINDBqYmNIUExna3pOV2Vha2xkbXB6a2E0aE03cjRWcnJmSm51QzBP?=
 =?utf-8?B?YjZDTTdKSlVITld4YkFPL05IMEsyQVRhMDMxRXhuU0E0SFp3OXVPZDBQM2xa?=
 =?utf-8?B?WSt6V01PTzdUOVoyU1BVU3EyRW9BbFMvOGQya0VvMzZUcmJITm5qRWxndzJJ?=
 =?utf-8?B?amFoK1FUZGNlbGlYd1gyWmxIakJyMEtQay9ha3J4M2Y3ZzMxK3V2di9yWkx0?=
 =?utf-8?B?UTY0b3J0NzcyVWFSNUtVUmVhSU5QSUIzME1oYi8vZ3pzQXc5OE5HYmxLUGZh?=
 =?utf-8?B?QnRmWTdmK1RaMlpmTGt1N0twUjFMdlU2bkQ3STd2SVFRQzczdGNIZlp6RUJH?=
 =?utf-8?B?d3UzV3czeGcrZFhPSVFORVVyOVo1aFJ6Z1ZvWGpKR0V4dkM3a2kvczdYbHdE?=
 =?utf-8?B?OXMralV4Rit6NHE2MG5qRlN6VEhzMHVmZ1FydzJxUEZIOEFnVVZZNjBmMDRv?=
 =?utf-8?B?U0wyZFBnaWo5d2dMNVVsU1UxalUzOFJWMysvWnV4ZXdySUJxc0NwM25TcCtS?=
 =?utf-8?B?QWRNbGFZdWRBbEtDbnFoRzZILzF6Ykt0b0ZTOGw3Vzg1TGZ0N0RkaTR5Z05X?=
 =?utf-8?B?S0VCQVZQbDFQNGhpQWNDdVpjVy9PQnluOE5zaDhCZGVtbHhPMVZHc2lrNSta?=
 =?utf-8?B?ekdxOEVJZmprenRTc0RBQiswZnNaUjZCQnR3dkQwT3dEM0R3U1c3SHV1b0di?=
 =?utf-8?B?ekU5UGhqVEVTcG96Rm9JbkorMVVTeTVPTW9mMExUNkVKRXg3bjBhQXg2T0xo?=
 =?utf-8?B?eTI2M0htbjAwb1EwcW5qM0RZbmdZb09uMWloUUNab1MzSkN2c3k4VTFKazN6?=
 =?utf-8?B?aUJlQTdoUlVmdTluVzJ4Zi8vc2NIR1RDcnk1eHBrSmxoQStOZjdwR2NSeEtZ?=
 =?utf-8?B?bTB4QWZJc2VTZzZnc1FNMUxVSHQzRlNTaks1LzBQbVd0VTZwaUZSc1NZcmdx?=
 =?utf-8?B?ek9qNXJrbDU4MlVUSkVnT3FiVnNTTEx1cjBTM0VqN0ZuSUlLVUEvQ1NxaS8z?=
 =?utf-8?B?SEhzSkY1QUR2Z0dSRDdXL3hwMnJMS0ZqazhGdlVQcmxUVWFXVlozMVhzcWlP?=
 =?utf-8?B?OXlTQjhDYVh5WXgxK2o2c1lrUjBNN2lSQUtiUGNEbEVqN2F5MXVGdThOTGla?=
 =?utf-8?B?QVg5WXlZcm5CRmpKdVJrb01nOThNUHdaaERyNG1tcWxqV2RCVmVrNWhhZkVq?=
 =?utf-8?Q?jYpCvhaDBHmFCZJQ=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9dbb0e-de3d-437f-9ff9-08df4b964e4c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 08:21:44.1523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdcWqpDjPrjYGNOW8LPqv5u/H4j6c7kFdSy7ai6HzDYrit0RKC5c4Hw16yK/yQU9GWHQwBERsX6tzVUvl7fGCtRwv4Xpes6Ib9wgygGMpYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7488
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
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17.11.26 23:42, Mikhail Kshevetskiy wrote:
> Main changes:
>  * add support for spinand operations working in octal DTR mode
>  * randomizer support
>  * continuous mode improvements
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/mtd/nand/spi/core.c       | 504 +++++++++++++++++++++++++-----
>  drivers/mtd/nand/spi/esmt.c       |   4 +-
>  drivers/mtd/nand/spi/gigadevice.c |   8 +-
>  drivers/mtd/nand/spi/macronix.c   |   4 +-
>  drivers/mtd/nand/spi/micron.c     |   8 +-
>  drivers/mtd/nand/spi/toshiba.c    |   3 +-
>  drivers/mtd/nand/spi/winbond.c    |  19 +-
>  include/linux/mtd/spinand.h       | 195 ++++++++++--
>  8 files changed, 636 insertions(+), 109 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 14a8703d34f..6d5f1c4dba3 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -28,6 +28,7 @@
>  #include <ubi_uboot.h>
>  #include <dm/device_compat.h>
>  #include <dm/devres.h>
> +#include <dm/read.h>
>  #include <linux/bitops.h>
>  #include <linux/bug.h>
>  #include <linux/mtd/spinand.h>
> @@ -42,10 +43,111 @@ struct spinand_plat {
>  /* SPI NAND index visible in MTD names */
>  static int spi_nand_idx;
>  
> +static struct spi_mem_op
> +spinand_fill_reset_op(struct spinand_device *spinand)
> +{
> +	return spinand->op_templates->reset;
> +}
> +
> +static struct spi_mem_op
> +spinand_fill_readid_op(struct spinand_device *spinand,
> +		       u8 naddr, u8 ndummy, void *buf, unsigned int len)
> +{
> +	struct spi_mem_op op = spinand->op_templates->readid;
> +
> +	op.addr.nbytes = naddr;
> +	op.dummy.nbytes = ndummy;
> +	op.data.buf.in = buf;
> +	op.data.nbytes = len;
> +
> +	return op;
> +}
> +
> +struct spi_mem_op
> +spinand_fill_wr_en_op(struct spinand_device *spinand)
> +{
> +	return spinand->op_templates->wr_en;
> +}
> +
> +static __maybe_unused struct spi_mem_op
> +spinand_fill_wr_dis_op(struct spinand_device *spinand)
> +{
> +	return spinand->op_templates->wr_dis;
> +}
> +
> +struct spi_mem_op
> +spinand_fill_set_feature_op(struct spinand_device *spinand, u64 reg, const void *valptr)
> +{
> +	struct spi_mem_op op = spinand->op_templates->set_feature;
> +
> +	if (op.cmd.dtr && op.cmd.buswidth == 8)
> +		reg |= reg << 8;
> +
> +	op.addr.val = reg;
> +	op.data.buf.out = valptr;
> +
> +	return op;
> +}
> +
> +struct spi_mem_op
> +spinand_fill_get_feature_op(struct spinand_device *spinand, u64 reg, void *valptr)
> +{
> +	struct spi_mem_op op = spinand->op_templates->get_feature;
> +
> +	if (op.cmd.dtr && op.cmd.buswidth == 8)
> +		reg |= reg << 8;
> +
> +	op.addr.val = reg;
> +	op.data.buf.in = valptr;
> +
> +	return op;
> +}
> +
> +static struct spi_mem_op
> +spinand_fill_blk_erase_op(struct spinand_device *spinand, u64 addr)
> +{
> +	struct spi_mem_op op = spinand->op_templates->blk_erase;
> +
> +	op.addr.val = addr;
> +
> +	return op;
> +}
> +
> +static struct spi_mem_op
> +spinand_fill_page_read_op(struct spinand_device *spinand, u64 addr)
> +{
> +	struct spi_mem_op op = spinand->op_templates->page_read;
> +
> +	op.addr.val = addr;
> +
> +	return op;
> +}
> +
> +static struct spi_mem_op
> +spinand_fill_page_read_packed_op(struct spinand_device *spinand, u64 addr)
> +{
> +	struct spi_mem_op op = spinand->op_templates->page_read;
> +
> +	op.cmd.opcode |= addr >> 16;
> +	op.addr.val = addr & 0xFFFF;
> +
> +	return op;
> +}
> +
> +struct spi_mem_op
> +spinand_fill_prog_exec_op(struct spinand_device *spinand, u64 addr)
> +{
> +	struct spi_mem_op op = spinand->op_templates->prog_exec;
> +
> +	op.addr.val = addr;
> +
> +	return op;
> +}
> +
>  int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
>  {
> -	struct spi_mem_op op = SPINAND_GET_FEATURE_1S_1S_1S_OP(reg,
> -						      spinand->scratchbuf);
> +	struct spi_mem_op op = SPINAND_OP(spinand, get_feature,
> +					  reg, spinand->scratchbuf);
>  	int ret;
>  
>  	ret = spi_mem_exec_op(spinand->slave, &op);
> @@ -58,8 +160,8 @@ int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
>  
>  int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
>  {
> -	struct spi_mem_op op = SPINAND_SET_FEATURE_1S_1S_1S_OP(reg,
> -						      spinand->scratchbuf);
> +	struct spi_mem_op op = SPINAND_OP(spinand, set_feature,
> +					  reg, spinand->scratchbuf);
>  
>  	*spinand->scratchbuf = val;
>  	return spi_mem_exec_op(spinand->slave, &op);
> @@ -199,20 +301,29 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
>  	return 0;
>  }
>  
> -static int spinand_init_quad_enable(struct spinand_device *spinand)
> +static int spinand_init_quad_enable(struct spinand_device *spinand,
> +				    bool enable)
>  {
> -	bool enable = false;
> +	struct nand_device *nand = spinand_to_nand(spinand);
> +	unsigned int target;
> +	int ret;
>  
> -	if (!(spinand->flags & SPINAND_HAS_QE_BIT))
> -		return 0;
> +	/*
> +	 * QE is a per-die setting on some devices. Program each target
> +	 * individually when enabling or disabling quad I/O mode.
> +	 */
> +	for (target = 0; target < nand->memorg.ntargets; target++) {
> +		ret = spinand_select_target(spinand, target);
> +		if (ret)
> +			return ret;
>  
> -	if (spinand->op_templates.read_cache->data.buswidth == 4 ||
> -	    spinand->op_templates.write_cache->data.buswidth == 4 ||
> -	    spinand->op_templates.update_cache->data.buswidth == 4)
> -		enable = true;
> +		ret = spinand_upd_cfg(spinand, CFG_QUAD_ENABLE,
> +				      enable ? CFG_QUAD_ENABLE : 0);
> +		if (ret)
> +			return ret;
> +	}
>  
> -	return spinand_upd_cfg(spinand, CFG_QUAD_ENABLE,
> -			       enable ? CFG_QUAD_ENABLE : 0);
> +	return 0;
>  }
>  
>  static int spinand_ecc_enable(struct spinand_device *spinand,
> @@ -359,7 +470,7 @@ static void spinand_ondie_ecc_save_status(struct nand_device *nand, u8 status)
>  
>  int spinand_write_enable_op(struct spinand_device *spinand)
>  {
> -	struct spi_mem_op op = SPINAND_WR_EN_DIS_1S_0_0_OP(true);
> +	struct spi_mem_op op = SPINAND_OP(spinand, wr_en);
>  
>  	return spi_mem_exec_op(spinand->slave, &op);
>  }
> @@ -369,7 +480,10 @@ static int spinand_load_page_op(struct spinand_device *spinand,
>  {
>  	struct nand_device *nand = spinand_to_nand(spinand);
>  	unsigned int row = nanddev_pos_to_row(nand, &req->pos);
> -	struct spi_mem_op op = SPINAND_PAGE_READ_1S_1S_0_OP(row);
> +	bool packed = spinand->flags & SPINAND_ODTR_PACKED_PAGE_READ;
> +	struct spi_mem_op op = packed ?
> +		SPINAND_OP(spinand, page_read_packed, row) :
> +		SPINAND_OP(spinand, page_read, row);
>  
>  	return spi_mem_exec_op(spinand->slave, &op);
>  }
> @@ -403,10 +517,14 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
>  		}
>  	}
>  
> -	if (req->mode == MTD_OPS_RAW)
> -		rdesc = spinand->dirmaps[req->pos.plane].rdesc;
> +	rdesc = spinand->dirmaps[req->pos.plane].rdesc;
> +
> +	if (spinand->op_templates->cont_read_cache && req->continuous)
> +		rdesc->info.op_tmpl = &rdesc->info.secondary_op_tmpl;
>  	else
> -		rdesc = spinand->dirmaps[req->pos.plane].rdesc_ecc;
> +		rdesc->info.op_tmpl = &rdesc->info.primary_op_tmpl;
> +
> +	rdesc->info.op_tmpl->data.ecc = false;
>  
>  	if (spinand->flags & SPINAND_HAS_READ_PLANE_SELECT_BIT)
>  		column |= req->pos.plane << fls(nanddev_page_size(nand));
> @@ -495,10 +613,8 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
>  			       req->ooblen);
>  	}
>  
> -	if (req->mode == MTD_OPS_RAW)
> -		wdesc = spinand->dirmaps[req->pos.plane].wdesc;
> -	else
> -		wdesc = spinand->dirmaps[req->pos.plane].wdesc_ecc;
> +	wdesc = spinand->dirmaps[req->pos.plane].wdesc;
> +	wdesc->info.op_tmpl->data.ecc = false;
>  
>  	if (spinand->flags & SPINAND_HAS_PROG_PLANE_SELECT_BIT)
>  		column |= req->pos.plane << fls(nanddev_page_size(nand));
> @@ -524,7 +640,7 @@ static int spinand_program_op(struct spinand_device *spinand,
>  {
>  	struct nand_device *nand = spinand_to_nand(spinand);
>  	unsigned int row = nanddev_pos_to_row(nand, &req->pos);
> -	struct spi_mem_op op = SPINAND_PROG_EXEC_1S_1S_0_OP(row);
> +	struct spi_mem_op op = SPINAND_OP(spinand, prog_exec, row);
>  
>  	return spi_mem_exec_op(spinand->slave, &op);
>  }
> @@ -534,7 +650,7 @@ static int spinand_erase_op(struct spinand_device *spinand,
>  {
>  	struct nand_device *nand = spinand_to_nand(spinand);
>  	unsigned int row = nanddev_pos_to_row(nand, pos);
> -	struct spi_mem_op op = SPINAND_BLK_ERASE_1S_1S_0_OP(row);
> +	struct spi_mem_op op = SPINAND_OP(spinand, blk_erase, row);
>  
>  	return spi_mem_exec_op(spinand->slave, &op);
>  }
> @@ -594,8 +710,8 @@ out:
>  static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
>  			      u8 ndummy, u8 *buf)
>  {
> -	struct spi_mem_op op = SPINAND_READID_1S_1S_1S_OP(
> -		naddr, ndummy, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
> +	struct spi_mem_op op = SPINAND_OP(spinand, readid,
> +					  naddr, ndummy, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
>  	int ret;
>  
>  	ret = spi_mem_exec_op(spinand->slave, &op);
> @@ -607,7 +723,7 @@ static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
>  
>  static int spinand_reset_op(struct spinand_device *spinand)
>  {
> -	struct spi_mem_op op = SPINAND_RESET_1S_0_0_OP;
> +	struct spi_mem_op op = SPINAND_OP(spinand, reset);
>  	int ret;
>  
>  	ret = spi_mem_exec_op(spinand->slave, &op);
> @@ -719,7 +835,7 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
>  	bool disable_ecc = false;
>  	bool ecc_failed = false;
>  	unsigned int retry_mode = 0;
> -	int ret;
> +	int ret = 0;
>  
>  	old_stats = mtd->ecc_stats;
>  
> @@ -801,6 +917,12 @@ static int spinand_mtd_continuous_page_read(struct mtd_info *mtd, loff_t from,
>  	 * Each data read must be a multiple of 4-bytes and full pages should be read;
>  	 * otherwise, the data output might get out of sequence from one read command
>  	 * to another.
> +	 *
> +	 * Continuous reads never cross LUN boundaries. Some devices don't
> +	 * support crossing planes boundaries. Some devices don't even support
> +	 * crossing blocks boundaries. The common case being to read through UBI,
> +	 * we will very rarely read two consequent blocks or more, so let's only enable
> +	 * continuous reads when reading within the same erase block.
>  	 */
>  	nanddev_io_for_each_block(nand, NAND_PAGE_READ, from, ops, &iter) {
>  		schedule();
> @@ -858,6 +980,14 @@ static void spinand_cont_read_init(struct spinand_device *spinand)
>  {
>  	/* OOBs cannot be retrieved so external/on-host ECC engine won't work */
>  	if (spinand->set_cont_read) {
> +		/*
> +		 * Ensure continuous read is disabled on probe.
> +		 * Some devices retain this state across soft reset,
> +		 * which leaves the OOB area inaccessible and results
> +		 * in false positive returns from spinand_isbad().
> +		 */
> +		spinand_cont_read_enable(spinand, false);
> +
>  		spinand->cont_read_possible = true;

There is a bug with the cont_read_possible handling and I sent a fix for
Linux that is currently queued for upstream [1]. Can you include it here?

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/mtd/nand/spi?id=09c1dd5c119276c43b381fd9cea36a9fea07da93

[...]

