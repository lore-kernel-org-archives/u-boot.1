Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9A6606A329
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KqTbbiUF;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wkau+jnc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D61C811D9;
	Thu, 26 Nov 2026 17:21:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6kLI4P5o41g1; Thu, 26 Nov 2026 17:21:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 67180811D0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795713675;
	b=CMgPJoMvR2jD8ZZgzuvv0UKK1nR6KkLEzgUOPo0Zz8trPN8+SUL3C4y/Aoo03VlAXMMF
	 5Ff2N4NZTEpOpSr4j8mYMXT1UPZNE4GsVU3pITmVL2OXDZRS1X0kEAyAMTi+lARI1vYRF
	 oPd4aPbLMZlZgm4V7+NXdtveCNPUb+9AYhbpMK1319vCGVflU93LAPZr23xeDtfvQN1fE
	 UjQ3UHkXemuqcG5mJ90iCsHjHuJx7JYEDNsjltTSIR9h43m/0WSM/RTHqncbbQjUVqBax
	 vMA2aCSqBD9VtbZZGlFEvXVEVSGDBBuFH7PGY71bE9rPEkUWuozLjLLAhM/qWAtCz4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795713675;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=37Rmk50cXjsCvCxhfiNxhnUS+EgRYZkvxJ8dxJLiAmc=;
	b=OOURyvfSBeCz8hEEPCbyfHFQ54EbgeAgXfvHklUFgbvW0M9XKXlRZywbdBR4KYg67OrF
	 WmIOb2nXlRgb1f3aNakb1JMq4KTOnhxsP3C5FMU6eiB3xNwWejO8PAbNLmyd8LXoQPcj2
	 tQOWqlWAI3PJk7j2KynXjdgrdTJLWi9nJ7JlGMky3ELrMU7t3hGRy6lsOX3xLvUkD7LTq
	 2iBoa8rEWRxECZI9uvO0wmssaqTzX3JGF4JY0GXC898ezrbRu+rv8oVQPyUIFbHHRG0IM
	 fl0m1g7/jY1zEkojt9ZxbcyjDUy/k8tnh6SdzmQPcNh4mSL15u8qESp+SoBIbvVtBdQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795713675;
	bh=37Rmk50cXjsCvCxhfiNxhnUS+EgRYZkvxJ8dxJLiAmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KqTbbiUF2KgpOxBYfYO5nbUps1jVHJmevqxqH08z0+D+vyR+7vsGesBPB2nvH00Qm
	 Eo+XF7swbIs6bTf4oUBf+OorFtfpUznowCsQvyXbbG/ugWM1cL6a0AgUM5ew7edNaA
	 aqpZ/maF97+/Me9KFqjJW+FsqXa2XKgpghBuSutbl3/U49KpZXwHiOtXEk34vIeZwy
	 gl2GzeauvtMEXaMrhUInF8ShHvfb4C3PC8O595PU3/dApNtcfTUaCXMRLcHXSWDgqX
	 B/+9w+c52rmsBFD21m/+BnAJoXqtIKzbK80A7ps5saGa48DgUQEQpuYSlcLCYnWXsk
	 nOCAnIcYHxRPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67180811D0;
	Thu, 26 Nov 2026 17:21:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 62AD110B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 17:21:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4810F60A9F
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 17:21:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3QhRt0uRJkRO for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 17:21:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0424A60A8F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=marouene.boubakri@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=wkau+jnc
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0424A60A8F
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 17:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37Rmk50cXjsCvCxhfiNxhnUS+EgRYZkvxJ8dxJLiAmc=;
 b=wkau+jnc87o7+dN3qV9PKvObK3LA1aWYeRsB094oebQTf1+2UO5ThcbPTdrixMhhuyokMO3nCCpLGKj0InqmuCHtF0A0RsnHC94IOrEKeuA4CJulCYRjwIwIG1uyaJEPWWKIrthJGiQggWNoYU8tWashqKL3Vo6Foiw6i9YKOFnrvd0HddrJfX6cCpmy/S4lZBiMClat+jyD8jB2FIHV5qRLmm12hw4HswlJAvFInG937jV7cbZ/PuaLWJJ/0efSVjQT2SaFELskND8ln4/x1o80DHG+CoxGBDnYDDumfXEXQP2H/hWCKBVHDIvPzAaMtjVY37BqLqxQpYbgs+Jzpw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13) by DU4PR04MB10959.eurprd04.prod.outlook.com
 (2603:10a6:10:586::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 17:21:06 +0000
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930]) by PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930%3]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 17:21:06 +0000
From: marouene.boubakri@oss.nxp.com
To: u-boot@lists.u-boot-project.org, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <me@ziyao.cc>,
	Marouene Boubakri <marouene.boubakri@oss.nxp.com>
Subject: [PATCH v2 2/2] doc: board: add OpenHW Group CVA6 APU on Digilent
 Genesys 2
Date: Thu, 26 Nov 2026 18:34:54 +0100
Message-Id: <20261126173454.978816-3-marouene.boubakri@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261126173454.978816-1-marouene.boubakri@oss.nxp.com>
References: <20261126173454.978816-1-marouene.boubakri@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPCP307CA0007.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::7)
 To PA3PR04MB11203.eurprd04.prod.outlook.com (2603:10a6:102:4ab::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11203:EE_|DU4PR04MB10959:EE_
X-MS-Office365-Filtering-Correlation-Id: d546f441-b44b-4851-2575-08df4be1a7b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|19092799006|376014|366016|6133799003|18002099003|261009223027099003|22082099003|261102123227099003|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261022115727099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|261028144727099003|261102130727099003;
X-Microsoft-Antispam-Message-Info: M2MFT0pcDyRd8otPre9lQyCRKorKp0kJXgWw9tzYXGCGoxuoKuX9FsFZcpovdaFIZQ7MPmZfzBXAj/dZJ7898erA2NhazM5MaSm0kleNmfhwocaCeqjlAjDWeGYLsBGQcciWb6MfOZKkYc5KhXED56AZOxmI5XjqVmxbKWFisVAJ8kOqvlFxasZ+OxUviTJTdC7tFvUMyISUqAAD7DNqgxz3L2x3UcQnns4dnr2HrQHSDrHPROIDDTZsa2qSNyWaqaVmWovqo3RhtmQtk+fyWfSO/Y7kTsU3qqy2VZeSoZ20kDO1KTJDzoHVknrjlvBhZK1uS+1aYKysZFQWcY/CUs3QU12qOVExs/1Zt+nCovoqjREdJol9+mRgpzATRsH4B41Kdm8TooBWIRoj/fveqwxwP7eo1lVaTNyD14ZWje92JlL4wmM5XFvt2zveS2b4kPrhMnrccXnNd5EKDTqLPYsckLcTq/zcsqh+qvrJasahby5UGADVz47VPfOrHV4arAYtzHr5GRRRMo0IHtPFG6tQgRiGfUxl/uDU6nHX1UJP0I7Rz9+pejnH51vZitQZfP96PCNdnpXk6rCw7iURbqYlwbfS6LMKo9eKyIBLf0oOusaLnyyKFLHN2/zrKLhIJ8HtPQ9tuZ9rQwU3suQOKtB2fVolaP+5ByhNDBrrBak=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11203.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(19092799006)(376014)(366016)(6133799003)(18002099003)(261009223027099003)(22082099003)(261102123227099003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261022115727099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261102130727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jrbjFUbOENgZAXo1xISwT8cw78pjYyB2HX2oLxOCFcibCoTRZmIi2jUDNlNv?=
 =?us-ascii?Q?YhYLy34/muy1u/ZNL3/VHWO6TQc13go2YMlcyPRFGri90S83dPtPdRg/H9pv?=
 =?us-ascii?Q?xRCPLEivHlAGTpoXp/qL+6TUhR45Y2vZAyovj98rCAbuYSeJ9Xvm4ZHd9OPR?=
 =?us-ascii?Q?mIOVT4GO7Xjb1eNri3ESka6uRwSs0VR99CfSnW+noicsw7LCr8gpPnxci168?=
 =?us-ascii?Q?qNuoA8W3F4gFE0NYVYpCk4HBn+hrg9AzBo7b2txIYyfsNVtNop6tZ43EJTVv?=
 =?us-ascii?Q?mpMDtz+WRC5aPQkjL7b9nrSi+fVAw1WLTXO0Me8PgmIDiGMz6+fuofZ5yS/M?=
 =?us-ascii?Q?wuCMDpb9qXawa1fPEWYbrq4E45AkhHPmeucLxXCsnOi/W1aELCxtyI09Ya4/?=
 =?us-ascii?Q?xs3pcrGZeitPO4uNBL/aVtSP0gWEnaudweVn4D457mnbXQWPX2rrhoigL0LX?=
 =?us-ascii?Q?0/rgnlZmmlPmhXmefdphpoAIJFdR/D7xVBgjBI++sbCPemR9SbE9mGOlPhsW?=
 =?us-ascii?Q?agtuemswgaljhvLSmUM8aw+tUgi6viXqrne2LLtbnfvYBCSHK1x1AQuxPzKh?=
 =?us-ascii?Q?1TaiQX4Zc9dsQKwl3s32t958hURLIT2d72Am4b+lSUpWcsTKxkHtIkGANPmJ?=
 =?us-ascii?Q?okIz9xAjtgmkKLoEa/M0yzHh+m5WNvjwHLkbqcve3Z4miJkGOC7rgiuJCuzT?=
 =?us-ascii?Q?kpdW1s2Fe87omI3pwAQ4fKgaXKUQAVcf1ZnRrTDZvwYgcEVC0qgMSqDrkSGp?=
 =?us-ascii?Q?n51i10yG4brve2eHTaWBRnkGsJ4AiugiIzVQiK1Ti6lMwLSzd0VoeG8Kv+cX?=
 =?us-ascii?Q?gKtZmDSavusgVQr3aQn2od2N8D7xRGOn+KQUWyobdOvuooqNw6yFKKNziF/2?=
 =?us-ascii?Q?NHvE56Fbyb4ekviksOxeHiagiUrGLV5wGuyQUW0ZCNzlg3RqWWbSUT/3KxAB?=
 =?us-ascii?Q?IT3nzUhIRBQAXhOonDxYRDPJH8dsALGURXtaoMjkbX34QTL3l+xgI+dXgKdW?=
 =?us-ascii?Q?fQgPrLCEJZiPW32uw/Lh8fA4DXeO5VWCnl3UiRfSeao4ZtCh0Si3Rr/9kRbu?=
 =?us-ascii?Q?5A8ahP+Wd14Z7pCzsmvOlo/ZsQO0Qv84dLEZkkN3chbL7GmF+snQK/ns18f9?=
 =?us-ascii?Q?ex0YA2dULUX2aIXBnROIRZGfkvhoOObBRFl6kisQCa3Zwkag1rXffw43KbnR?=
 =?us-ascii?Q?voNl6Oc8vCbP44FzJ+gJG/BvZ113ORD+bdtAI/zvBoX0iQX1Iy7QF8iAxOZ+?=
 =?us-ascii?Q?192b0L4X2gABTHQdUOY2MaqmdLPaV1TsbyMFBLG3NB9yoEhIs6OSj8QQcf3o?=
 =?us-ascii?Q?agGXkNYVJdanjs2ERnM93R/wqAZsNkdln5BDWbAGm1FZwWNKs2j9NisSPWbt?=
 =?us-ascii?Q?4XvJchkDmDbH1HLJAnqpOB+77A8nA+xs2WY+ToXKremhnhI0gF6ZHK0W3vXz?=
 =?us-ascii?Q?bnFwZHRg+74cpYVbGg4AeP58PKUjlKueLjGoUh/l9b8kjrP+qcVK/94iVLpa?=
 =?us-ascii?Q?w2Oz4yrQzw6wWH9FSgfA9mxu4cIqzlLT2f41m2cP+AYpmHMkWngZpWIid1DE?=
 =?us-ascii?Q?6jjREyu4WEf2OUWRfDRoS3usV5tGrcbyiscFKjln6A4P+QZvnOPn2VSGS8TE?=
 =?us-ascii?Q?iAmLUPzXLrZSHaoPfGEmVBxf6h/9/+F8Kc+91aM5VrE3zTd5gUm8VSi0LYR+?=
 =?us-ascii?Q?TffRn7db39X33Popmj3z8vAo5uyEIxOr0C5+UXM0nli46nk9S0v0oq7a5v5z?=
 =?us-ascii?Q?A9O4nA4Ft1bJHkJ/AeQdsCyVANdBt2U83Ko0jxY010h7dvpFtBW87o07RPvi?=
X-MS-Exchange-AntiSpam-MessageData-1: py3m3lyoqtwj+A==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d546f441-b44b-4851-2575-08df4be1a7b2
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11203.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 17:21:06.6070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xD7h199UUkChm2Hd3I//97UXF7JvxVp3+8lg0vTd+SXxq7fjfPf4yES+mZCAWhX+KKO69qZSTGwZcuU9Pd6a2pX2acrbx1JEiTuVsWFf5BOAADKP1UeTDl2x7fYiAq2GP+RDIvQYSX5fT9zGDYyG2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10959
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marouene Boubakri <marouene.boubakri@oss.nxp.com>

Describe the two boot flows, the memory layout, how to build U-Boot for
the cv64a6 and cv32a6 configurations and how to prepare the SD card.

Signed-off-by: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
---
Changes in v2:
- None

 doc/board/index.rst                     |   1 +
 doc/board/openhwgroup/cva6_genesys2.rst | 157 ++++++++++++++++++++++++
 doc/board/openhwgroup/index.rst         |   9 ++
 3 files changed, 167 insertions(+)
 create mode 100644 doc/board/openhwgroup/cva6_genesys2.rst
 create mode 100644 doc/board/openhwgroup/index.rst

diff --git a/doc/board/index.rst b/doc/board/index.rst
index cc1d181a8e1..e307ce53a64 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -45,6 +45,7 @@ Board-specific doc
    motorola/index
    nvidia/index
    nxp/index
+   openhwgroup/index
    openpiton/index
    ouya/index
    pegatron/index
diff --git a/doc/board/openhwgroup/cva6_genesys2.rst b/doc/board/openhwgroup/cva6_genesys2.rst
new file mode 100644
index 00000000000..6709c368e82
--- /dev/null
+++ b/doc/board/openhwgroup/cva6_genesys2.rst
@@ -0,0 +1,157 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+CVA6 APU on Digilent Genesys 2
+==============================
+
+CVA6 is an application class RISC-V core maintained by the OpenHW Group. The
+CVA6 APU is the FPGA SoC built around it in the CVA6 repository
+(https://github.com/openhwgroup/cva6, ``corev_apu/fpga``). It targets the
+Digilent Genesys 2 board and provides a CLINT, a PLIC, a 16550 UART, a Xilinx
+SPI controller connected to the SD card slot, a Xilinx GPIO block driving the
+LEDs and a lowRISC Ethernet controller.
+
+Two configurations of the core are supported:
+
+* ``cv64a6``: 64-bit core, ``rv64imafdc``, Sv39 MMU, 1 GiB of DDR3
+* ``cv32a6``: 32-bit core, ``rv32ima``, Sv32 MMU, 128 MiB of DDR3
+
+Boot flow
+---------
+
+The boot ROM of the CVA6 APU parses the GPT of the SD card, copies the first
+partition to DRAM at 0x80000000 and jumps to it. Two boot flows are
+supported from there, selected by the defconfig.
+
+With the ``*_spl_defconfig`` variants, the first partition holds the U-Boot
+SPL::
+
+    Boot ROM -> U-Boot SPL (M-mode) -> OpenSBI (fw_dynamic) -> U-Boot (S-mode) -> Linux
+
+The SPL loads ``u-boot.itb`` from the FAT file system on the second partition
+of the SD card. This FIT image is generated by binman and contains OpenSBI
+``fw_dynamic``, U-Boot proper and the device tree. The SPL runs OpenSBI,
+which in turn starts U-Boot proper in S-mode with the device tree taken
+from the FIT.
+
+Memory layout::
+
+    0x80000000  U-Boot SPL
+    0x80100000  OpenSBI fw_dynamic
+    0x80400000  U-Boot proper
+    0x81000000  SPL BSS and malloc pool
+
+With the plain ``*_defconfig`` variants, the first partition holds OpenSBI
+``fw_payload`` with U-Boot proper embedded as its payload::
+
+    Boot ROM -> OpenSBI (fw_payload) -> U-Boot (S-mode) -> Linux
+
+U-Boot is then entered at 0x80200000 (cv64a6) or 0x80400000 (cv32a6) and
+uses the device tree handed over by OpenSBI, which is the one the boot ROM
+provides.
+
+Building
+--------
+
+SPL variant
+~~~~~~~~~~~
+
+Build OpenSBI for the generic platform first and point ``OPENSBI`` at the
+resulting ``fw_dynamic.bin``:
+
+.. code-block:: bash
+
+    cd <opensbi>
+    make CROSS_COMPILE=riscv64-linux-gnu- PLATFORM=generic
+    export OPENSBI=<opensbi>/build/platform/generic/firmware/fw_dynamic.bin
+
+Then build U-Boot for the 64-bit core:
+
+.. code-block:: bash
+
+    make openhwgroup_cv64a6_genesys2_spl_defconfig
+    make CROSS_COMPILE=riscv64-linux-gnu-
+
+or for the 32-bit core, with a 32-bit OpenSBI build:
+
+.. code-block:: bash
+
+    make openhwgroup_cv32a6_genesys2_spl_defconfig
+    make CROSS_COMPILE=riscv32-linux-gnu-
+
+This produces ``spl/u-boot-spl.bin`` and ``u-boot.itb``.
+
+OpenSBI payload variant
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Build U-Boot proper alone:
+
+.. code-block:: bash
+
+    make openhwgroup_cv64a6_genesys2_defconfig
+    make CROSS_COMPILE=riscv64-linux-gnu-
+
+or ``openhwgroup_cv32a6_genesys2_defconfig`` with a 32-bit toolchain. Then
+build OpenSBI ``fw_payload`` with ``u-boot.bin`` as the payload:
+
+.. code-block:: bash
+
+    cd <opensbi>
+    make CROSS_COMPILE=riscv64-linux-gnu- PLATFORM=generic \
+        FW_PAYLOAD_PATH=<u-boot>/u-boot.bin
+
+The default payload offsets (0x200000 for RV64, 0x400000 for RV32) match
+``CONFIG_TEXT_BASE`` of the two defconfigs. The resulting
+``fw_payload.bin`` is written to the first partition instead of the SPL.
+
+Flashing
+--------
+
+Create a GPT partition table on the SD card with:
+
+1. a raw partition starting at 1 MiB holding ``spl/u-boot-spl.bin``, or
+   OpenSBI ``fw_payload.bin`` with the U-Boot payload
+2. a FAT partition holding ``u-boot.itb`` (SPL variant only), the kernel
+   image, the device tree and an ``extlinux/extlinux.conf`` for the standard
+   boot flow
+3. the root file system
+
+For example:
+
+.. code-block:: bash
+
+    sgdisk --clear \
+        --new=1:2048:4095 --change-name=1:spl \
+        --new=2:4096:69631 --typecode=2:0700 --change-name=2:boot \
+        --new=3:69632:0 --typecode=3:8300 --change-name=3:rootfs \
+        /dev/sdX
+    dd if=spl/u-boot-spl.bin of=/dev/sdX1
+    mkfs.vfat /dev/sdX2
+    mount /dev/sdX2 /mnt
+    cp u-boot.itb Image cv64a6-genesys2.dtb /mnt
+    mkdir -p /mnt/extlinux
+
+With the following ``/mnt/extlinux/extlinux.conf``::
+
+    label linux
+        kernel /Image
+        fdt /cv64a6-genesys2.dtb
+        append root=/dev/mmcblk0p3 rootwait console=ttyS0,115200
+
+Booting
+-------
+
+Connect to the Genesys 2 UART at 115200 baud and power on the board. The SPL
+banner is followed by the OpenSBI banner and the U-Boot prompt::
+
+    U-Boot SPL 2026.10 (Nov 01 2026 - 12:00:00 +0000)
+    Trying to boot from MMC1
+
+    OpenSBI v1.9
+    ...
+    U-Boot 2026.10 (Nov 01 2026 - 12:00:00 +0000)
+
+    CPU:   rv64imafdc_zicsr_zifencei
+    Model: OpenHW Group CVA6 cv64a6 on Digilent Genesys 2
+    DRAM:  1 GiB
+    ...
+    =>
diff --git a/doc/board/openhwgroup/index.rst b/doc/board/openhwgroup/index.rst
new file mode 100644
index 00000000000..fe70360e1df
--- /dev/null
+++ b/doc/board/openhwgroup/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+OpenHW Group
+============
+
+.. toctree::
+   :maxdepth: 2
+
+   cva6_genesys2
-- 
2.43.0

