Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EEDCC6B34
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:55:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E1A64082E;
	Thu, 15 Oct 2026 13:55:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lP5aZO4QOMef; Thu, 15 Oct 2026 13:55:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 642054089C
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792072518;
	b=sodUd9n4RSaSmi9g6WcI+T3aapP1/Luw7KL5kvp1r/PQkoNjzvGAJWBv3djWOpmHFr5+
	 +sAumS4HMaK9/1WvuBtPhO5twXsoAa59EyN1A6hMRVrLYsD8UdOl9KR36rr9zMJFr/Lxu
	 12CPq2Xo1+97tqksVdI9t9LLivjKUtBqpLNNJbwB2a90/TRDe09/kK18oMWa6VCJ6xl/m
	 g9Uvn8ZiPFH/6pOms9GlfURTZhSiPW3vj00oLYz+h0QrofvhByiwzhUic3rBCPPhVDkPZ
	 zw7UG6Qrhx4B7IXDQEybxj7SBHCR8qCGhqJfFYeJ87ftku5XrMAmeuODjnmA7ziDKog==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792072518;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fFv9W+0xUCGrFDbfK73fxHv3k3XDfhF2NLwDF+SzwFs=;
	b=l3n6PMY4169GX42yo0yzmMcyZzjPquNR5/XX8ZmWi6Kc69FNquaaIwAVpfBOMgU3Iyl6
	 Xt65q+tjJouy1uwq8cAJjVnOhVU494qjJdNwyPh7HEk6Mr1nuQHf2ggFOCverqVg4PfNE
	 ekJKq0qdS+PREmxFJNjQL+QNECSkPesOGbQmIT0UN9BvcyU7aPQ5dIbnYl6rt6Oq/1nKt
	 PLovz269sLo3vyYax4TCGloVAq1sGKUnT4JkSwZYzyHRht9qxuCY12em1CGZkcvEy8p8H
	 FzU66jSUrRcBaTWcg7VnLqXr5UuNGep94i2T8IUt7xL+7jA0oaupPoyI6G/6R4VDzjA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792072518;
	bh=fFv9W+0xUCGrFDbfK73fxHv3k3XDfhF2NLwDF+SzwFs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nSUXzQBvadofw3S3JwnbJzqMslNcbYLvq/f7/QQBkFHfY1EyuKgtmACZBXqHKtbnM
	 bF/bhluhP4DZIcyvhxSAdTGlxvLvbND8ZiT7lJ72rKwwkB1mCuRGxlB/vG5KM0oO0f
	 Zl0suU8lcjg8uRY38+7O4ecCd9D4puRgHP2AijE+sEIb3aVPff+Aqv9Kx3vGC8Oe+u
	 L7Y5Bo9/4rkUI5YmseJ27IM72F6PBho+f4rp8GKeYAgXn353y5Atd7nWJ6vK2IEODl
	 AZZmJBVxeT8E8YoafEs30aQeMJfNe/wtxGzmVgeOr5EZknsL+eXxSzPJ26rCkozWWA
	 zdouRlWFIDkJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 642054089C;
	Thu, 15 Oct 2026 13:55:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 471332E0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D25A608D6
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Fx8Fx99qifu for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 13:55:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3DE98608C0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792072516;
 b=URl7xml8JVlOEQRTMFdVdTPPgpKL5Tax3OdE15aqkizCIqxweUu7TSfwPUZMRACE1EBI
 IYDn9G9ang0mLvv4YCfvLlaKPX4Mtr7J2Xtr/1ucCX3GDogKkSCkFfFjysWdiwAiUs6Bj
 7agQmidx0QElovC5NdiUnN9SWqc7yShf9esIlLjHI/5GmEzVaN/QYN/ibtnWtYVEBcQs3
 W/zJ8P+p39IwO4cPsDWuS/XEBtmnnEziNQyh4AvJ6YkNeILmESSbzpwqbAxP/AUZInTb0
 MFaFPb2qH2s/AIHh+rwdjOQn8A04c81JF/U/KHCu66uugh5A2Y38ZgJAiFC6/+DFo0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792072516;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=fFv9W+0xUCGrFDbfK73fxHv3k3XDfhF2NLwDF+SzwFs=;
 b=kb5MJPfYvKGs23EcbN4yiA/SPXEBE3C842LBa44577CHvv6OE8IHuL+gZOCi0T2GYDJq
 V4tc1blOT1iFBFrM2y1XLkl3xH93PWUINNSI710Ay8ea6qFHYFkXjyGuiaS/80Uwm5E0x
 Nn7/N/GV6PymTDGdPvQIRIT/V6MI1Ykv97FyZ3JKVq1mdwggRm0roiWBzNBASM8TZA54J
 VPg48nh+14tYFmK/gNd0QLTghR/tbONgRtSntB3MSnidmo7JUBzjNmznxar3NngO0JCeC
 l7RZlNNHAHzgrIRJY9Naz3h3ngFhb9K4BGURg/fHAaWNl8BIfMVwc9jdt6wbpdopz8A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b="chR5Bc/y"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=ludwig.nussel@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=chR5Bc/y
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3DE98608C0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yw+eI39JbcUlXzgxXIxEUpzvWeG7vp2zB72hR3cYPiTrz2aRNcwSi6Yqx6/8vMwoDaZ3YsCOue3aPbZh1X8pGL4YNiE6FxHel2ATXtS7i6SyMN5FQUH3utTdzARNwwExOCXjoMX3D71kzbj0qdxtlqJ03e/yBml2tBoJ2oe8A3Fk1Adv6N3bbKV/TkGc7agq1qnB4DC/PXKd3wGn3Wm0S6q+XJ/3I2FDqfkjkHiXcj3zrxL44wjA+UyezhF3TTS27t9JOPgzqTrZ2hvbdUcA6JHBZu6EUQSGhPBAgPPv/NccnzbJJfGYd1/SxrmZAtmvvdfwGvrl11ctEGNCE8gXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFv9W+0xUCGrFDbfK73fxHv3k3XDfhF2NLwDF+SzwFs=;
 b=mLu6uFxE8oxo3l4iTUqPzNda/kTvz/rkhdw4VsPCmAX1NBp9cBk9pKRT75znjIDvo6zaYhfjP6GpOslQtbPxkUs0GvN9VuyglYxZjpLcxYC5PNywbR2BhGbXzpvROu5SzMlckzcJUNf5CagnqXLX+zE0D5R9En0A+Mgrlt9TXHBl6PEKgVxzT4EQER9qW3SPmJWTlZUyjVuJ71VIWeCBBbvVmrQlcblKzjQ2oJrMzZVMCzy7t0xBiyp1EAeQO6jfD1zzPkIiMSLGRxuiXzRTITzgalO1XPM55It2xcqkuE7POYnWJSgAJgP4wE4OaDV5QzkUhAxek6nZi5rUuw6yrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFv9W+0xUCGrFDbfK73fxHv3k3XDfhF2NLwDF+SzwFs=;
 b=chR5Bc/yIaGZwo2quUV+C5rnbPEIEonmQN3hia1RPEjl2lJjwOSDw7At6eiGoPvWqrWSHK4AaLTuGalQY2epdFEL9xCvHCGbCmxVRokoXFAzqLqzEqeh8wOLZIYFMHKWEwqRN+xYTGZOKRCyC4Jt8AK0iOizBRrmgZ6qfVFRkeQz2GiffWTPzYwMBW4MfFXi2H4fvle+MjKatAuCEJszi01FvjBbhCaBFfp7sa5t92qoNgr40RKrO0L/ACSnN8ILvM4ANR/q595M1fd2Rc9IV2iGiJlFevwI6KdMyaCiR0BM3+NztDDOSBF0reb7IN0VH+//+JgKV4WNwGaYmQejPQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by VI0PR10MB9054.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:239::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 13:55:06 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 13:55:06 +0000
Message-ID: <6f29a66d-1425-4229-a762-2dbc02fd0dd1@siemens.com>
Date: Thu, 15 Oct 2026 15:55:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/7] Improve FIT signature handling
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>,
 Aristo Chen <aristo.chen@canonical.com>, Daniel Golle
 <daniel@makrotopia.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>, Johan Jonker
 <jbx6244@gmail.com>, Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
 <CAFLszTiM+-BsYPjaw7aD7xfzU+3kK-BO9mkYKrtXpjPOv4SjcA@mail.gmail.com>
 <11fb0589-8ef2-4870-8490-077389ce9e53@siemens.com>
 <20261012144457.GB3722450@bill-the-cat>
 <44849c78-b187-4a20-bf2c-0eebaf8a2e9b@siemens.com>
 <20261013150127.GA4042005@bill-the-cat>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <20261013150127.GA4042005@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::20) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|VI0PR10MB9054:EE_
X-MS-Office365-Filtering-Correlation-Id: d3ad56f8-7223-4c10-7422-08df2ac3eaf8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|23010399003|56012099006|11063799006|4143699003|10067099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FuJAV9uzIkBJE+F8QV6GHiRX6piHp2m8J+k5e7j3K6ZY+aiK5mDEFS03Aq5pQg+cBZN4IsfFY99giTy0RXDietGhN9okiy6aCqo1+iCxw9pOCdbczBKDygIeapPF1TNIbdYx5O2cD9SJCJUTi3tvUxQVj5iNJR7OMJsiVuDs8EWK4YcAmszv1cpWfVMM4osQv1kngk9dYBFSt0eILNKxYp4SMf+3D9UzRs8+UCRt79pMcFVi+diEWr3CftMFBMjh1ACoVmKW/+8pfj9E2M/XE8MSYIrSGoVHHsUaSQtVgFSJjtq3mlzmy/H5RD2c5eZZi5FzwiqQ20pIIo7YmTueAIEFqzlV7iL5/CebCI+d3o7YV39Z1MAmwAL9qvU3royTDv9XUTyWuLgVWwTbXMrJ3p+TKIYFBQIEWFKhXfW/eZ7qTpJDx2W/5BXMFsijoZoAyWKgdZAC7SPLq5+IO7SBSrk4Cmbnuue+NVFLeyJBZCq3ndd+Iif1JSuSnw5E08Q3ZCXPSMqQk6J8TKRoEhT39Oms28KzHdP2MoUXIWZmmbVgnU0H9kYwYWAj5GV8KXXC5+jbM/YJGS1Dr85FiygsNfu7KZeXzj5wy9PEXS6Ktyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(55112099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2lyMnN0aGZTZEtFeDhKd0Q5UlM2cHhxRXNkK2NyOHpaNXd4OGJ3NDhKYlUv?=
 =?utf-8?B?R3ZXTUZoU1FSaGFIQ0RBd3A4S2VNcmlZWXh1elpsM1lSUVRIRW5PaVkyUzRX?=
 =?utf-8?B?Y0gwbER1enI0K09iZGNUbk9IZDFoQldodVpsQU1BcVZOc0J5dndxbXBIdit6?=
 =?utf-8?B?Y3FNY3ViTFZxdXRXRFludm9sNWFnY1NpRjhsaDIzOUFwb3NSK1FrdEFVRlls?=
 =?utf-8?B?MGNKYVl0azUvZXl4TVNFRkpESm1aOTI5d293YmxJamV3NjBmZjlwMWZMQ0pR?=
 =?utf-8?B?QStCVUpiODBRSU1DcVhCN3krYld6d2RZUmRuMEYxN3JJanMya3RLSGIvcEdw?=
 =?utf-8?B?KytoUzEvZFM0VW03aThoTkpuY2VzWnVydEtOR1ExM1ZiSDFkdVA3bHBnc2xR?=
 =?utf-8?B?ZU5oT08reXFKbmZIekJ2c01mZjFVZkVMZnZTRjhaYWsrNTd2eWlRMW9zbUVm?=
 =?utf-8?B?K2cyKzV2TDlMWUswVEUyS0dIVTdKZXpFQlI2dXhsRWtuUndRUkV5bTlvTzVI?=
 =?utf-8?B?YldHajcxdFg5eDFTOTNLczA2TWVUMnREY1ZGV0E4TWNrMkJVQ2NydGp0ZEo5?=
 =?utf-8?B?Si91VFVxYUxDRjZvYkRBNGp4TURJVW94VUFGZk13UmZPSlpGaTErMnJXU3hu?=
 =?utf-8?B?emUrRnZ5NXp4dGorbVhrakdpTHZLYjdmMmh1ZFFYVFN4WUswbFBHNU1HTnM5?=
 =?utf-8?B?aUpDM2RUOUV6UzB0VlNNNUJFcVhpeXBHa3Fpd01EZ0V6UkRDMjFsanlEZHYw?=
 =?utf-8?B?dktQZml5dEJKT0laR2ViUldNNjVMM1ZzQWlTTzQyZTIwVFlPT25EVWN2SGRo?=
 =?utf-8?B?aCtycURyc0gxT0JNWlpzeGg3NlhwdnNvSWEzZlU4dTczd3R4cmdnbjNrRVBI?=
 =?utf-8?B?MDdmaXluemI4ZmZvZm5hSlQ4TG9DcXNsYmlWNFc5R3RMTWo0S056ZDJyTGlV?=
 =?utf-8?B?MFhKeFpKamFESTVYTE5zRWZ6WmdhOU52VUVQYmg1bkU1WXlKOUNpbmU3Nksw?=
 =?utf-8?B?TUlxQ2M5RlBXZCsrM3ZKbUtvdEV4c01oVG41WUtEZXY3OUpIZTYyazJDeUE5?=
 =?utf-8?B?YW0zZE5DaENGTEJCRWlWOEQ0TW1odzBoL2NWdEx6SWhVam9MSVlybUdQK1Yv?=
 =?utf-8?B?S1V1cHZ2Tmo2WkRoN2pFZ25iZlY1dE1aTjJ4TEdkQ2VyNy9kcG5JeDYra3ND?=
 =?utf-8?B?QjFjWFpDZ0JxeUQxOXlnbXI2MmVIQWlmZThwTzV6KzM2dFlxWFQ3cmY0VUdM?=
 =?utf-8?B?WUt4Qmg4akxaODRWNmxaR0dQSk14QzFISXRtajhtV3gyZnF4TVVwdXNDNTYv?=
 =?utf-8?B?dnFTRTVORHc0SVdsWXJZc0hOMmdSTjUvVENNR0hrc1VpSE9GbjQ5a1YrUjBP?=
 =?utf-8?B?RTBka1dTREwyaXhpY2FYMUdXaytTZ1BuN2R0Mmd0NkNsK29GdjNBNFZWMnBB?=
 =?utf-8?B?aExqdFRFK1lVc2VlUjZXM3l2cHhBQXhRWnFHK2lrNmFFWDFJQWNRUWlsNmE2?=
 =?utf-8?B?bUNEY1NwQUhXQjJUVmI0UmtEYllBZ3ZYd0N3U3M5ZVlVY3FONHQvYmY0ZHha?=
 =?utf-8?B?YW9HRm1XLzAydGozZFBFNEs1ZXVTRDM1emMrMDkzc2ZXYmwyU2o1SkMvQVZD?=
 =?utf-8?B?Ky81ODhFYm9CVW12TUVUeUJOdGdBdlIxSGp1Q1dXbWFOVTVoQ2tpU2R1Zm9V?=
 =?utf-8?B?M0lVcGV3Q0ExMU54eXB4czJ1N3JZK0dhQ1lKcW5mRHQ1M0RGVFltQnNpVDIz?=
 =?utf-8?B?cEhiSzluRWpCOUh1VEI2T1NnRmZOSG50ODUzY0ZnWFl4emhROGdlUmlOaStl?=
 =?utf-8?B?R2VzdmRaRUVybDcvNCs1Nk1YOFN4ZVNjRnJ6MHl0KzMzbHNHY1Q4aHJxc3BY?=
 =?utf-8?B?VWE3aHUvSmgwTzd1OUp1TEI5WHJVc2l3ZG1RbThtOXBQeU43OW8rRFBnelNP?=
 =?utf-8?B?RUNhMGtqVkZVcktJa0d1RHJ3bXZCMXhtVmhyQUZYOFUyVUVyS2szK09obEdN?=
 =?utf-8?B?MktwYmkyUUQ3Wk0rL0NwTjdyYjZEZWdJL3BtTkhxVVdRTWxhOEFmK2FXY1dT?=
 =?utf-8?B?dnlQQ29vb1dVWDlZUTJhQnB4S3lPSTZncmxYRmVKdXREb2dXaXVybWFmMm5t?=
 =?utf-8?B?WDNlYXBvOFJ0bThXZEdVQndIdUpkdk84aTNya2RVWXR3K2s3aUFQemxWVVJ0?=
 =?utf-8?B?QkJsRGxrcmg5TlN6OEJ5aHhRbjhpT2NCclNBNzFnZVpSd2dDVmFDc3VISTl0?=
 =?utf-8?B?VVg1bzEycDFCOGoyUGZJakticFd6UTFHQklrSTl1eDV6c05jTWVyd0VlTHFl?=
 =?utf-8?B?anVFazRhMnVMeXpQNHYweWIyYkhuekxPMHE0dExlajg2bmxFZUE4ZGc4NWto?=
 =?utf-8?Q?FixAtKMA95GoAOW8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ad56f8-7223-4c10-7422-08df2ac3eaf8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 13:55:06.0214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9JTElUkj1aDx3aqw/BF9YB1ANn7kOax2RWc6wZPf+IMxIp53HreOhBbugAlPk1YjUVgla5oEXw7yJbssYg3y+dJXhBpmR+i7v0msT3vsgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9054
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

On 10/13/26 17:01, Tom Rini wrote:
> On Tue, Oct 13, 2026 at 08:47:48AM +0200, Ludwig Nussel wrote:
>> On 10/12/26 16:44, Tom Rini wrote:
>>> On Mon, Oct 12, 2026 at 02:26:55PM +0200, Ludwig Nussel wrote:
>>>> [...]
>>>>
>>>> When I developed the patch OF_OMIT_DTB was "default". 68e65953400 changed it
>>>> to "def_bool". Would something like this make sense as a fix?
>>>>
>>>> --- a/dts/Kconfig
>>>> +++ b/dts/Kconfig
>>>> @@ -213,7 +213,8 @@ config OF_HAS_PRIOR_STAGE
>>>>             disabled in the board's defconfig file.
>>>>
>>>>    config OF_OMIT_DTB
>>>> -       def_bool y if OF_HAS_PRIOR_STAGE && !BINMAN
>>>> +       def_bool y if OF_HAS_PRIOR_STAGE && !BINMAN && !ARCH_QEMU
>>>> +       def_bool n if ARCH_QEMU
>>>>           help
>>>>             As a special case, avoid writing a device tree file u-boot.dtb
>>>> when
>>>>             building. Also don't include that file in u-boot.bin
>>>
>>> No, because commit 68e65953400 was fixing how the symbol had been
>>> misused over time. I need to understand a bit better about what you're
>>> doing here next, so we can see the path forward. In commit 99df7f471551
>>> ("arm: Drop unused dts files") we dropped the empty dts file that was
>>> being used to generate the dtb OF_OMIT_DTB required.
>>
>> Qemu provides it's own dt at a known address. Normally u-boot would just use
>> that. The purpose of the series is to make u-boot check fit config
>> signatures though. In order to check signatures, u-boot needs the trusted
>> public keys in the dt. So in this scenario we need to merge u-boot's dt with
>> qemu's.
>>
>> Maybe a better fix would be to remove OF_HAS_PRIOR_STAGE from ARCH_QEMU?
>> Looks like this atm:
>>
>> config ARCH_QEMU:
>>         ...
>>         imply OF_HAS_PRIOR_STAGE if !TARGET_QEMU_ARM_SBSA
> 
> But then we would need to provide the whole device tree, yes? I think
> this ends up being a tricky case because we're on QEMU for this. We're

I am not deep enough into the topic oversee all consequences. Something 
like this maybe?

      -  imply OF_HAS_PRIOR_STAGE if !TARGET_QEMU_ARM_SBSA 

      +  imply OF_BOARD if !TARGET_QEMU_ARM_SBSA

How does one get u-boot signkeys to work on real hardware that provides 
a device tree? Or is this just not a thing?

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
