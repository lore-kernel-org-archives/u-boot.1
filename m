Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95B6606A320
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1Olnc4oK;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=EnpeIZEL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E009408BE;
	Wed, 11 Nov 2026 07:59:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vl6rL4K7ANuk; Wed, 11 Nov 2026 07:59:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BB4DF408F9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794383946;
	b=KvLHSZKh9GZLjk+xZyq/zCqK39d/7AoW80kz/Bq//w5u9781Js114yxNiY9r+ieocUPm
	 ZzZ/3tFCpwjYoURwFu5GyS4JWXrO4IOoGIwcLH24EDx+4Xsb0NbqtJp0xNjQhNR+CIIoq
	 +nt9fIjeMXRUtxKTcBx2mQdsaRAZoVKxXxuQA4/ekHwqzXGfsT75bb3ZmDvuqebhFyIlY
	 c3I3BFQcGy5+ElUlHbQ99MAW6br/czhHX7BriaPeW3oUwnP5wlt/wk8S7XITjJs+tnex6
	 O+UCQAZBBYL2Xr+dUbRzlvdx6BNgYFgDtggaQKzlbhFbMCIKRXvo2napH3TUe0llK4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794383946;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 From:Subject:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=QUTLaaQFKdf06lgkTalK/IgH35bZDfZ+R1Ht9ZvnWwk=;
	b=sso9ko8fhYLMgqnLbdKq4YbAjsDeN3VL/5L8cMGRkg3Fhxkl2xyNTza63WXL19FDLy88
	 m3URUyBQZMELvArN785QzB6X6s7bhUXtBJrXLidMxZxPmicXf7ndpR8YBXNTM/exFhG1Q
	 FxZ6X0khjacV83gxpNHrPOyfwXeuXu6c1f9i9xRWUMM2CnvB3YNMhVidUwPpIskv+e4w0
	 F/zKPG/AEV4oUDsOJrLcpSjVLvg8ZPc2O4qiE3FvrJnI4+38Qyz1sun43Lo7xeePG5HKG
	 60UmsZXYIBECtHve6FyTLNP7zWS/0DTBhZgFCQ+exGno290RWHUUQjw0mEfQtyKzkBA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=altera.com;
	spf=fail smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=EnpeIZEL;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794383946;
	bh=QUTLaaQFKdf06lgkTalK/IgH35bZDfZ+R1Ht9ZvnWwk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1Olnc4oKr0pAU6puPAyxDdqrFn/mffLWozCjk7z+QMZKFkHAjbFk0pCxlyD9Zsq3I
	 A2c7DSYEvCE48ytzNH2NXck2YG1kTRpnh9Q6+6xMVaXLobgbyxhaDDwtY8PtSGu+QQ
	 bd+5PgtylJPnUQw2UIr/4EeARIfTuO76o7FyATjNEAHSj8t1uUBB6m/F4kFR9QAUWh
	 rUmhlB4l6Ei5hDlwIgs9CH9JmCKWgw8UX1qQjeEch1ZJADdrU0uNhnYY5cI7773FmL
	 U36/BgLAA8HN4g7Pi/+GGS4YIBPoR6nJhi5xu1VmQDv9nRVCSb8KcPE5ncjvj/ySWe
	 D0H2xZJ2JFvnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB4DF408F9;
	Wed, 11 Nov 2026 07:59:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 73DD517CC
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 07:59:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 71203408F9
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 07:59:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tazf7eaU0EiB for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 07:59:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E579D408BE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=tien.fong.chee@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=EnpeIZEL
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E579D408BE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 07:59:01 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA8BF84A29; Wed, 11 Nov 2026 08:58:57 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 947EA84808
 for <u-boot@lists.denx.de>; Wed, 11 Nov 2026 08:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUTLaaQFKdf06lgkTalK/IgH35bZDfZ+R1Ht9ZvnWwk=;
 b=EnpeIZELlbjhUFnn7spunG/4hJUUKGUcVUkHEU6yrTpJGQyr9mjt27QGbZhf0QF5xAbV0I9o0kGapUyimIHNr548CQqkCXkDSWfaZIVvqkI5RJerNsl5jbpsCuvw59mktRRs+xZU8YkomdFkYudvph4ltfbb+3VwsDmvfuEQtHsDcan0J0c6Cjh9tzvubYlTt+LPCm+BNh2CxVAtpIES8gA8MQdz+NTdxDrFh1z/8lq3u10JlvdqGg5IwhhMQGfORfHM14WoocxF97nSupjwFvoDgXW+8ui9BQk4sJVJMZuRaf2YAjUnM00qZPdxxaGvkn0q/d0nRXZ0sGAMuubiNQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14) by CH2PR03MB5173.namprd03.prod.outlook.com
 (2603:10b6:610:9a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 07:58:44 +0000
Received: from CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d]) by CHBPR03MB959535.namprd03.prod.outlook.com
 ([fe80::26cf:5066:9d0f:c79d%4]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 07:58:44 +0000
Message-ID: <50fcc808-5845-41f7-a1a1-c22306a47c7c@altera.com>
Date: Wed, 11 Nov 2026 15:58:31 +0800
User-Agent: Mozilla Thunderbird
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Subject: Re: [PATCH v2] arm: dts: socfpga: Add Terasic DE-25 Standard Board
 Support
To: "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Markus Schneider-Pargmann <msp@baylibre.com>,
 Bitao Dai <btdai@terasic.com.cn>
References: <20261028013257.8553-1-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
In-Reply-To: <20261028013257.8553-1-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::14) To CHBPR03MB959535.namprd03.prod.outlook.com
 (2603:10b6:610:40d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR03MB959535:EE_|CH2PR03MB5173:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b14e693-1fa4-40b4-394d-08df3fc99b95
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|56012099006|261022113327099003|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: K7zhuryaZr0jKGHfAAm+4ZCC10R3A6wvvEdok6pd0a49p5rCIW39ca4pO0J51iYY7BpALiR+d/TH40Nv70hkq9U1sxfdpVHekOSCrbt7dNO7GZZE7Sk7pt/ivBe5QOphlsWNejnYjsgk0TN1Mu3SBfJxkr1eIeMl0t3N0iyArQk0q7W9Qs9M1a2o1mWNqvujhWDu6Elon+Cr6r8Iy40jpYou/H0LXmnbuCX3Jjc2sAI+gzGAsr9LykepCykYKoZ7O+dMmP9aEQ1XR3atBwU4fnXHci7ogLYVm+rkSeebuSAhSKiAcYTcoWOoQh04OJu9OJOLfBJINbCX5NvyJn/slV1ziYpcnCgr2q1gtEhQ8QUVQSaPidCvpHdfN0Tvw6r8gmSIRBAf9T0Y64UJwvAFUlybZw0O4Xb45lNnDW0HcqH1L63qrX/C001QJmSTrBT/26g1lWyj0NCsO3jVcqxq6BTdnNm+Hsc7Yfd3feloofOdk5RxbuuQaG34jc3ss6WKBXN6rkworjdItavqZa5gQ5SEF+3rosQwhEYlkgXOqG/NoUEpR1bH0UB2rUb1fKI51aoLwps8aytEnJ6fklBI7eSAS2EjIDoqIWMc8e3mje8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHBPR03MB959535.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(261022113327099003)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y01TdEJMWDdtNU80SjNZU0t3dFFLUUp0cnI1SWthbU5QNmp3U2dkVVFiY3Jv?=
 =?utf-8?B?a1VBZ3NtblpyeGJoK3hHZ3dNazV1TTNpVTR1aW9GMWtBYWJoME5iOThIbmZG?=
 =?utf-8?B?Vkx5cWtlRzZTcnpHN2RxT0h3VGxCMmpPeUdCYTRLbWRxc25YS1BqalhGUjQ3?=
 =?utf-8?B?UU8xRlJJb2E4Tnh2bGxPbkdJWE9tcWhQTXJGemFiWkZRdk1JY2lycnN1LytQ?=
 =?utf-8?B?Qno0TkJ2WFR3QzYyZk94b0YyNnJaS2l3aUJuQ0FOZ29PbVFxdkk4WmVmZ2pv?=
 =?utf-8?B?RlVQS1Zyb2R2dFA2TUl0MUJaQTBTcjFXRFVZTVo1aHhBMzNVV2Z5WWNXWUxi?=
 =?utf-8?B?cWhtVnphOWNvbTE3cm1WWjl5amNPSjRtSVhTclI2b2pOaWE0c2UzTVBKMHVB?=
 =?utf-8?B?V2trbndoZzBBbGxCK2NqeWFuNk83TGhPV3JWTkpMMVNaMFJOREhVV201KzFt?=
 =?utf-8?B?VlcxTk9DZGJmUG5zMXNmQ3B6eXZ1TTJrSGJtTXB3M21GcVdFMmwvVWNuN3Fp?=
 =?utf-8?B?WFIrSmM1dDNCRW9oZk9pUHF1N3puWFlibHBHVjhnbHFJZTIrS3oyQXVPNnd6?=
 =?utf-8?B?U0dRM0NnUWk4UHJDK2VzZElMYmd5cFdsTmx4K2FyQzVkM3NOejdHTnJJUlor?=
 =?utf-8?B?TUpqYjFHcms4WjYrYXROSDYrMExwemUwcG16bklxaEhDQmRCL0NQRkpUQTMx?=
 =?utf-8?B?RFhXS0MyUjZzRytDY3JzRjFNOGRtQTVYUUxLcXo4NVR6Y09pa3Y0aEN1WXpV?=
 =?utf-8?B?eU12eE9QK0hObjJNbDVMdjlUa28xK0cyNGRmcFBHTy9oMUNzdzN1OS9uaHJo?=
 =?utf-8?B?SUNMa1RUa3QvMWRKV3lCalAzb00yVHNnY2NmMjNMS1cvV20yeERCaWhKTzg1?=
 =?utf-8?B?SjdwVTRaTXRmNDFmTVpSWG9ubHFLekpWdDhrZHBNK1dDMEFLSWJmcWRMOG1U?=
 =?utf-8?B?K05RRk9lRFgrbXFpNFlKeG1tMTdLZ1MvTFYzcTdoVzM4R05UeVNFT3owVjA4?=
 =?utf-8?B?cTY2Um9pWm1ORC8yb254NTNpNjdMMTZSY3N3TXBlVVFpUkRiV2JwcURGZlFB?=
 =?utf-8?B?dTRzNzYrYTlPejZrUXNFMWV6MWdiQVZyRjlZWDBDMUVmZTdjeFNBNkxPZGVQ?=
 =?utf-8?B?VkozZmM1cENHZXBEZlQ4bTRyd28yV2FHSWFTditONnF6ZWJ3Y0w0MU5qSVkv?=
 =?utf-8?B?UFlPc250cE4wdkZlNUhhWW5odTVBVnZkbFdRMFBOYXRDbXlNVHdvaE53eWVJ?=
 =?utf-8?B?QUJpZnJlR3hkZ3lPa1RrOTFFYXN4dE11cnRQSVcwNDBZNk9zOG0vTVNDU0ZT?=
 =?utf-8?B?WHliVEFYeEUxeitrNVJ2L3ZHaVlhRmRrZzVZcFB2Wld2b0paSk5RZ1ZzR2VN?=
 =?utf-8?B?TDV5SDFuMEd5Y1p4YUxxOUJObDJpUFVJaGtVZDVDd0ZoUHF6azZmVzVRS2ZB?=
 =?utf-8?B?aU5NQzdqZzhGYW94MGZPZ1FWYWtlR3g3N01ndVFTaEpnZWV5OExXbWpBMDdj?=
 =?utf-8?B?WWlxMENhMnZBMis3WW00TWFHcjFDVng5RTRGNDI2Ui9ScGhMNG45V3grdWZP?=
 =?utf-8?B?b2Jlc216bVY4YUZaRTRKQmJZSGNFWk45cExjdEdrY0l3NEMxTmpYazFnV0tN?=
 =?utf-8?B?QWM1UHZvcmNzeW93elcyQ1YvY2ZSeDZMVFh3TzdTSXRZZkpNS1JkSWo0UG1s?=
 =?utf-8?B?ZVVPVGRIb1M5WlprSXh6M3d2d3JQbzRzbEgwakF1Y1lQM3hwNkR4VHZXYTN2?=
 =?utf-8?B?d0dlRzh4cytVUGdrMHBCa2kyd05uWFZTdjdSUFZUckl1cW8zWitRUEE3TEpy?=
 =?utf-8?B?MjUyZnNaVEYrSXpBQkJFTmhWRWFrdVhoeW1HT0pOSWRYWURPUzRPUlU0WWRk?=
 =?utf-8?B?TDA2WFNuVGIvcTBWL1RaZHJ3MWV6eFVkU2VqOHNBa1QzTEsvM0JYUUdBanpr?=
 =?utf-8?B?RzR1MUYwUW02M0t1clY5cFlCeVN6cWV1VmNmaEZhZzdsM1Y3bm5SbVVxVzFj?=
 =?utf-8?B?bU0wNC9KeFJKVTVScERFMUEwdDYyaGhQSytJVGxQRWR4a0d1UklOdDNvSkFL?=
 =?utf-8?B?clhPQ1gzdkpqM3o1N09sNHRVUzZqV2E3dlJiLyt1YkV4c2ZWekJqYmppNmZQ?=
 =?utf-8?B?dDhndUVCdFhtZXhHZDMvaERXZkc0SWxoNlNzcHBVLzdlajYyM0pwUEd2cHEy?=
 =?utf-8?B?RUhLRmhBU0JTSnE1WEYwQWxvRXYxNFBSc2hVQzZvdmVSdFBRR2FsRVFSTWVr?=
 =?utf-8?B?Sk1mS0czNGI5RmFNZ2NDYURORERWbnJsbDlMdzc0dFdWeUFZV0FlL1NBZlhz?=
 =?utf-8?B?bHgyT0RCWDBsM0JnLzhzSWlYdk5BdWRLOGFIWlJTMUN2RllkNC81eEk1K0Y1?=
 =?utf-8?Q?lZ0ayGsNx/6yCeSg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b14e693-1fa4-40b4-394d-08df3fc99b95
X-MS-Exchange-CrossTenant-AuthSource: CHBPR03MB959535.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:58:44.2495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fz7kNLGnbCcdeaxKejWOS4GaLy3wS3HAFw8OPI25xmvtTpS9+z7ROtuzeU/P7m704DZ1W5HgzVQmYExMdjyjVn6alzo6333mK+80FjFO5K8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5173
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi YUSLAIMI,

On Wed, 28 Oct 2026 09:32:57 +0800, Alif Zakuan Yuslaimi 
<alif.zakuan.yuslaimi@altera.com> wrote:

> diff --git a/arch/arm/dts/socfpga_agilex5_de25s-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_de25s-u-boot.dtsi
> @@ -0,0 +67,5 @@
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +		u-boot,spl-boot-order = &mmc,&flash0,&nand,"/memory";

The new U-Boot DT places flash0 in u-boot,spl-boot-order, but then 
disables its parent qspi node — spl_node_to_boot_device() only maps the 
flash node after uclass_get_device_by_of_offset(UCLASS_SPI_FLASH, ...) 
succeeds; with qspi disabled, that entry is skipped.

Please either enable qspi for a functional QSPI fallback, or remove 
&flash0 from u-boot,spl-boot-order and document that the board is 
intentionally SD/MMC-only

> +	};
> +};

[...]

> diff --git a/arch/arm/dts/socfpga_agilex5_de25s.dts b/arch/arm/dts/socfpga_agilex5_de25s.dts
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier:     GPL-2.0
> +/*
> + * Copyright (C) 2026 Altera Corporation <www.altera.com>

checkpatch reports that MAINTAINERS coverage may need updating for the 
new board support files — this is a repository-ownership/process 
warning, not a functional defect

Please add the appropriate DE25 board path and maintainer entry if the 
board has a distinct maintainer; otherwise acknowledge the warning in 
the series review

[...]

One functional boot-order contradiction requires correction; checkpatch 
also reports a MAINTAINERS coverage warning.

Best regards,
Tien Fong
