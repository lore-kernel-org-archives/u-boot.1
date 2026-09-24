Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5593AC9830E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 10:03:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8A0D60B7C;
	Thu, 24 Sep 2026 10:03:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W1KkKSxCJrFd; Thu, 24 Sep 2026 10:03:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 967EA60B4F
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790244200;
	b=PEIt/VAsxNg2YZkTEr6/kvZP2zY831VV7Xn+6szyTjJNxXJkyeiMMJ22w9Y4HQURb/VA
	 weLDgpbyqY7gL/AMx+/O8m97rsWGqERKjiotpBH3stzUcx91DVFzxMH+dlP1Icc40hv0H
	 IjXVycBK/1IWSI0cHnYXJQL1MXgFClqvAxMh58a6MpYnbR+Jx7fhyZk/v5nFh9Xi3SONR
	 AbbuKNYTPzaskVAoRoLAWnQ1O5ZVvxujNHXiIZqibKGHoltKtI0+5tJC7BSFtCdU8G0Nj
	 ts36dCSSexIymS67mCY6uMnggx+PABhPs9gi637T30MjHzeEV6kiclDH/w5iV9mHUFA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790244200;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mLh6QOA2XQ/3XQsDUumwGehpBFVIaFfKYVIAAoFqA4U=;
	b=FCEBtveyMJpk6NbO20s3TaYFgIZK/2NW3OOtyzbEnOPDg8kTR+WEIrQ+JcE1XWAT9OxB
	 jfJ0zHBRwXN8M3F1vNeIvFpIgi4meViw9bIXoSJLJBlnwsyK44jBvvOcWCohx8P9CtBI0
	 J19QtAa9wvfbl7CRY6QBM5LlYl9nUMren4qc7gAsG8e18wC9w3MlTAu+nPS7pc7XAj7zI
	 ecjaUIRcZ5E7aPiK8LpLZQByYX6AViggeMyRJwlU32Di3KZNfCxNxX2ZbNR52YijxJXYZ
	 wnd9W/6GWMYupIyVovGWZKyiocn5b3tgtvRGjBQn96hoeWhvojKBaJVwzQmN9+I+1IA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=L4Gd1RVZ;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790244200;
	bh=mLh6QOA2XQ/3XQsDUumwGehpBFVIaFfKYVIAAoFqA4U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YxTQSnn30xC+5wDbpJbve2WBl2ON73+NEPjC6Ovzu03/L4zQ50PeokHWxH04dKH2c
	 +N5vUlnfqisqhVjlMjjLMJVmxKpM4vgXiXa74tIQO9hHMJeR3ywBOLG+J7TxaX2Zzp
	 9ETxVNbsXJKRvKm1dMDQhteWH+t827nQgT1dKvMCnvKkv7Uk0eyvnJ+QnKDLKD/eBC
	 AWIT/HRRAdVWORdbQc3pTrMuxE6v34YTr1pVXOn915N/LEQTxV5qhcbBjOLbf7NrW5
	 kYqPnsADtrktwNfO23FDQwEDklY4vJb2qKsu3C56ZKigC8OTjU5+lP3mSjMIJfmOYV
	 +RDZCBn9UVW9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 967EA60B4F;
	Thu, 24 Sep 2026 10:03:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1209B1344
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB68960B4F
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:03:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id klwqRHszLUvD for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 10:03:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A23DE60604
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790244197;
 b=Yw/O1KjUUT8ZEvGGQiD4mslME/t4Yiuo5vYdrsf7SBv1MaASWHzqG0lTfYK5kH3VOG5i
 BHuOw2lFk3ICQ3hnMdJFV1ZWrr6LD+S0/ur838pN2xNckZ4cCmSRuhQv5YoaYdquHoHNA
 JU3pbEausj6/oR8FS+2/Z2A8zFHCam8GzrVRwdi9+/FLC1aMf4uamm+vvPsx1RZk5LMtC
 KU7qaCIb5A9lWFj/jIbvmvdAl8VEPfKSKTyh670njQHO77XKIfaR+ek5ucuA1rSXYJFB+
 WM2Lpp0XAn/OlG34+selhO/YIKee+cmZFzSWhBhXVIdyEC76baEVU/pb7vSowK8InfA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790244197;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 bh=mLh6QOA2XQ/3XQsDUumwGehpBFVIaFfKYVIAAoFqA4U=;
 b=obqUa0r0/UbWVjXGtQ+WQ/zt3BUDlMjpH/WINLhbcGlde6L3q/6Ykji9eiHDalojKbnL
 AnKw7bo81QIb6kJTwdiMzmcOQuiFohURXiCfLulWefgpsjS578goR8OzItkOpDhspTp7j
 Pcw/nm7r9YMhU92+aI349gmHXm8l+lJx02FvpIEx0Ox8ZkiWBT+ItRzGSJ33Aa0uMUwuH
 AA4gjhej+3J4fzh9V/XkDW/irbNK7MuWqSnZRlqHM1kXW94udNEzUR0EC7O4rYmIKuonW
 TbzWZdkiGu5/W/Lkl8Dg+MP4q7fAp2Js6n1oB9k/XzExt5/tpe1h+tzgno9EgV7oHwA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=L4Gd1RVZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=L4Gd1RVZ
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A23DE60604
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 10:03:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaIaj70/SQpisdA2l+ckhVzXKYmlKTsTkgjwqU1H6N79mEx4s4OQC9t2M9xdmrj7TpeVSj197b/y6L1R4JPYwwlsM+pWrwI9lbZc/TolvMZduZ2a5W5P33quCg0UpC5MYyTKt5yk/ro5V1sJPtkx5V+UiKtPSgnwUWLNeC5LvBmuq4XXOfWob3BC4HF2r9WJ0huMBum9s76FowWPFfpgDU9TOtTWZWudmm05QQf8fVaWzvVfFjgDHd5vOQpfNGkhC3P7BwU7ryxAAs2TwH3so8SAvvNUBEw6yyIhhmJJ6nbS6tZSw4syQoEJBCGVhQHD+obr3BRDNcR+IkQOV3aW8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLh6QOA2XQ/3XQsDUumwGehpBFVIaFfKYVIAAoFqA4U=;
 b=rHvnYZUo25fnLNoRXbz9QEsijp1RwFuwtZvBPoMbDa2Sc7a5xFMXq7yEK57qbAU8FhxSz8xxzszNnu9tmMHJTc0zuSF5QHdjz2GJF58dBS6h/c3olDZltAh9gkWwqhgb90rKZTtdiqqloeCiqoxqXmlTkW++akciIad26rSiTh9a7Jy4LDiUphUbEbSI5G6gVhNr+eYoQrP/EPXNi7QFoOILlBrn4sZ5nn0k/chRQpffcW+uzkesNgHDcnsgV5n88bwesuuBUl/OJ7GdtSriscaiOUWudmjU9qZT8IZ+VS4GEU3FBhOQ620jxjP+a8cc8QByH7l70HKwedPgAyCQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLh6QOA2XQ/3XQsDUumwGehpBFVIaFfKYVIAAoFqA4U=;
 b=L4Gd1RVZodrzKTMzN6YMMRv3Bi0t3+NWUkD+eBFpmIUT1aO4yXIVKJdPty8cESPUEh/8KNStx/fDQt/0IA8ldSJuquKk0vAolclTBCigwYSJa5BcyPcsnfyORFBl35mjRdg7q6d21sYxOvGNpcV049XjiXSpHhagpO/Rd4JOHS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA1PR04MB10414.eurprd04.prod.outlook.com (2603:10a6:102:44f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 10:03:09 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 10:03:09 +0000
Message-ID: <d96f1848-bc26-454b-8bc1-4cd5f8994e57@cherry.de>
Date: Thu, 24 Sep 2026 12:03:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rockchip: px30: Fix TPL_STACK overflow into BootROM
 reserved region
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org
References: <20260920161930.1880133-1-jonas@kwiboo.se>
 <CAC928Hb3HdGURxLFhxocpQAWGVB2morvpLP=GEsRs_w1iE0oig@mail.gmail.com>
 <ca280adf-19dd-437b-946e-8e5e7f700464@kwiboo.se>
 <CAC928Hb4GK3y4NXt0tEo8U=QF57WeuhCZ=77mvc0t2=6iSpZZg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAC928Hb4GK3y4NXt0tEo8U=QF57WeuhCZ=77mvc0t2=6iSpZZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0228.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::49) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA1PR04MB10414:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e2cdc68-8dbe-4e0b-a633-08df1a23096e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: YZBynMVgUEiyDeZpJij/9l56keckgw2aTQ0lpGRiMPFFIBqmyuANun1MG/zfouZhDaluvZfZ/mOZTH0amcLrnTYnM8X8xXYC2pCi3fxDHvmj8ImeM7ulXVtc5Q+D8qogo1gov7OT7i6LIF5cM0J++ButaxHzyDMfdKaMJ7a1JzvWA5/AlxCuOxuNNaemmnTg45SyVv3Y69KtS/AZZ9JbdOs3XgiuqZGnpxBHZLI/yYNzNsgj9yaQHms+ml8M5HRHm43Xx7t9jyK6VrjQt23Vqmpu8Dgp8HiTh2F1AGBWwNEY0QcwtoHykCJdvjalYALGv7bARBRFVVEtsfWNGFfxpYKfSEXIElfGqtAxtM9NlyQA2RxugFIhw58E5QKCojL4hikJewPO8KLuyAAqnJ2jxAVPw6tOiQ0Q5UCMFpXoSIItUNQ6qFkvSeq744HE2lv/EuOePmeJKlvo8Wwq9VWLizuW9WoBiDA9hrH2KPSHXb46NRxoxBXb9DmLHDUrnlx9dXc/P+xot/KtSFdh1CRFQLGvWk25bzgp7ayLlc2pGQb/JjhlOPqXhAkg8ajw+Y3RUfBdP6wp44jMd3JMgn+EifqXdHCaUeuEOAX5+ToP9cbtj9Io6GLQqtgh77BOJoguI7OaKuVQR5TmELmnAUbDG4Xf2U/NGcfPb7DxOAS0qF0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlNPQU5RK2J2SmFDdmQza04vbUJna00zYVlJRWNvOFVmVXpQY0xZUGNuQVJx?=
 =?utf-8?B?NStvS1ZzZnJiWW5KM3hmQVR5dXlxaWsraUE3Ri9Kd3pzUnYyQ2ZvZStqTWFa?=
 =?utf-8?B?WUF6OXJWNngzT1NPY054YWJIeDRGaDJQSW82d0tOZ2pEK1Y1Qm84OFJ3M3cr?=
 =?utf-8?B?MW14aEk0SkE0SFZHMG4yclFwcnMzMGdQY3lWNng1cTZnQU9LaGFnY24rSGRF?=
 =?utf-8?B?NklOb2RHa295c1pZeGZjR2JpZEJ1anp3MDN1OFMwbVgrRkJoMnlUSGUrdDhi?=
 =?utf-8?B?RWY2ZjRBU09uYWIzeUdSQW1zUjUxOTZ1OGtTb3pGYTVMeVdmRUhTbXZQNkdk?=
 =?utf-8?B?OTJoVHB1TGRsRkovcy8zZ251OVRpRnZVRmd1NU1mYUFObnFmV2RFUTJWVVU1?=
 =?utf-8?B?cGQybmQzRVRWYkl3d0tSelN3UXJnN2JJZE81MU84aEM1bDVKVkxyT3BUdXRO?=
 =?utf-8?B?TDhCSGYzN1BUNXJrZTZFOHV2c1RUUmhZR0RXVlViZm5pYk1PUkJUSTJWOHVL?=
 =?utf-8?B?MlBUb21wZUd2QmNXQ1N4TVNiOGZuaHRJNkxRREwva1l1WkNOeGN2cWFranJY?=
 =?utf-8?B?NW9GWmFtK3BIQS9EeGpqWnJaTEpZTHRZZnNtRDk1czVVWmxsaUlNaitHbThx?=
 =?utf-8?B?eEpuTVRpNTljVFVUazlvZUx4NHA2enZwOGJLclZINFNFNTMzR1loY1Z5WnFO?=
 =?utf-8?B?K2YwaGYwVHptS2s3OEl3ZjRXOXhidHg5aGFpYmdyMDJwN1NPWk5mZE5HcUY0?=
 =?utf-8?B?VjhqQjhINWhBN0JvT2gzS0VSSkFTcGpTVTZkMlI0SVRCaXpKeEhKTHJvM04x?=
 =?utf-8?B?cUlHWE95Zmk0UUZ1dHVGUTEzK2FXYmNaUUNQWmpFdkowUVNmNjZNZ2kxaUdu?=
 =?utf-8?B?djl2NGF3RHRrcWJaNm52VjdONGpaUlAwaWNNUnRUWTEralB1Y2JiTEhEZmFR?=
 =?utf-8?B?cFBidHB0YW1VOUkwZ1ZpUnJmeTRYYVdDSUJBdklpaUFiOGZLU25YQmpzMk0v?=
 =?utf-8?B?dXNRRXk4bDluWFBtOVNUYWNmSjk4WlV5WXBDN2Zmc0gxZ29SWU1XdGxGMUlj?=
 =?utf-8?B?Rktrd1BHc2Y1OGFRbUJqOU92NU5FSkpEY0p1Qy82ZUEzMWxKSEovbGw4OElW?=
 =?utf-8?B?VThKMGdkZDFZbllsM0hzcmNIZVJPQXcyR0ZLSEtmWDdLb1Q1WS8yYXlYYXNa?=
 =?utf-8?B?bHhucDhEZElPZzNaWFk2eTBiZFd3SDFUTE5PYm1lSDk0MnBJZkZnRml6MTVW?=
 =?utf-8?B?MTkyL3VHdWF2RURtN1BMK3BjQTRtYjVScWV4alpTZDMvUGd1V1RGeGxOZG9r?=
 =?utf-8?B?NDNRakpXdU9KbWkxQjRhOUtOTmc0VVQrb3M2b3ZvMGpCZ3IxZ3JLQ0VsK0oy?=
 =?utf-8?B?eWNPbStZRUNqR0s5ZDNjZytUbVdsZGNralROeGdoSEd0cEhoc3ZoM1hlcVNv?=
 =?utf-8?B?UmdlNytibnJKVUxQaFdtRGpTTUU1eVVkR1o2bEcyTlIyckU3WEJsZVBjSUR4?=
 =?utf-8?B?R1NhT05NTVFONGh1TDBMcTNTOXpNRHQ2TXl1OWM5WWRBdXJZaloxMXFKbTRC?=
 =?utf-8?B?UXNUYkZWNS9GVUVMYXA5blI3dmpGbGl0di9YM3lJeTFZSzhDbzhzMmFPa1gy?=
 =?utf-8?B?QzNlNE0zWllpMzRTckdpY0xlSkNkdzFLU29yeEFBZ2pIQUVBa2VRc252T1Vp?=
 =?utf-8?B?c2l2MGgyM2ZSZHR2Z3FyQ3R0SFdTMGVZZStGNHNIR1dTS2luTWJLcUVBc0JE?=
 =?utf-8?B?R051cS9qQ2dmY0NpYzJjYWlEeEkyU2JOM1RmcDM0KzNsdTdIcEhRS1hyZ1Nz?=
 =?utf-8?B?N0pmQXlycnpWSlBBU1Riamxha0hxTEoyclNqaWF2dUJBN0U0aFh0RFBrY1oz?=
 =?utf-8?B?YUludE1BTVhEdkZMMzh3VzQ2ZEFGbDNHZ0c1VmRENGtVdFRJZ0pPbk50TXB2?=
 =?utf-8?B?WlVYYUlwbzJmKzQ1K3YvMWk0eW8wOXFPSGtQMTl2alNqRW5td1YzOUxNNUxF?=
 =?utf-8?B?MDZudDdUQ0J0TjYxLy9xVXFVL3Jwc3BONituazI1NEV4TFJwTXZpMzNwZWJu?=
 =?utf-8?B?TEpsZG4yUGtmWXNZRGVQNVhoWUZRWFFPSEw2V0tGYUQzaEs3Yll6R1RMOHNW?=
 =?utf-8?B?eFNtelFZTThLS0lobTZ2N1JscHcydGVKUktISHhGS2doZjRROXpnUkxLUzRz?=
 =?utf-8?B?OGN5UmJHaWhuejNMNURNVG5IakNPajV0dlhRYU81LzM5cGV3NTdWKzVSOVYx?=
 =?utf-8?B?L0JmcU5FT25tNWFIa0E2QzJGc09uRzhoMFRJSTdGMUpYaUJPdHRLU2dQUU9G?=
 =?utf-8?B?N2VNZlhrcnpwUEEvRUdsYVQxNndNeVFEcHRZdjJMU1pHd2RJdGRkUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2cdc68-8dbe-4e0b-a633-08df1a23096e
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 10:03:09.5886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kc1vma5KMCgOVAZVI0hKUaqxhTS/owV9afuoAjEyV2yfDR3H789AeMWvdHIbJY/mOxg82131rlsO4iy+AWBNuZ8GgLPimJ5Bw5YoIvrgwJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10414
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

Hi Massimo,

On 9/23/26 7:52 PM, Massimo Pegorer wrote:
> Hi Jonas,
> 
> Il giorno mar 22 set 2026 alle ore 15:28 Jonas Karlman ha scritto:
>>
>> Hi Massimo,
>>
>> On 9/22/2026 1:35 PM, Massimo Pegorer wrote:
>>> Hi Jonas,
>>>
>>> Il giorno dom 20 set 2026 alle ore 18:19 Jonas Karlman
>>> <jonas@kwiboo.se> ha scritto:
>>>>
>>>> The PX30/RK3326 has 16 KiB SRAM at [0xff0e0000, 0xff0e4000), with the
>>>> initial 4 KiB at [0xff0e0000, 0xff0e1000) reserved for BootROM at boot.
>>>>
>>>> SRAM addressing only seems to use 14 bits, meaning that reading from
>>>> 0xff0e4000+ wraps around and instead reads back data at 0xff0e0000+.
>>>>
>>>> Using a TPL_STACK at 0xff0e4ff0 (16-bytes aligned) means TPL use BootROM
>>>> reserved region for its global data, malloc area and runtime stack.
>>>>
>>>> TPL on PX30/RK3326 does not have any use for the malloc area, the
>>>> generated GD_SIZE is typically around 304 bytes and BSS around 72 bytes.
>>>>
>>>> Current memory layout possibly looks something like:
>>>>
>>>>    [0xff0e0000, 0xff0e4000)          16 KiB   SRAM
>>>>      [0xff0e0000, 0xff0e1000)         4 KiB   BROM area
>>>>        [..., 0xff0e08c0)                       stack area
>>>>          [0xff0e08c0]                           stack pointer
>>>>        [0xff0e08c0, 0xff0e09f0)     304 bytes  global data (zeroed)
>>>>        [0xff0e09f0, 0xff0e0ff0)    1536 bytes  malloc area (untouched)
>>>>      [0xff0e1000, 0xff0e4000)        12 KiB   TPL area
>>>>        [0xff0e1000, 0xff0e3800)      10 KiB    code
>>>>        [0xff0e3800, 0xff0e3848)      72 bytes  BSS
>>>>
>>>> TPL currently does not touch the malloc area, instead the reserved
>>>> TPL_SYS_MALLOC_F_LEN bytes help push the zeroed global data struct and
>>>> the TPL stack addresses deeper into the BootROM reserved area.
>>>>
>>>> Using current offsets for global data and stack does not seem to cause
>>>> any known issue for BootROM after TPL returns to BootROM to load SPL
>>>> into DRAM, however any change to TPL_STACK, TPL_SYS_MALLOC_F_LEN or code
>>>> could theoretically change this and cause issues for BootROM.
>>>
>>> Here with "any change to [...] code" I suppose you mean any change of global
>>> data and/or BSS sizes, correct?
>>
>> Not only, the change to TPL_STACK, TPL_SYS_MALLOC_F_LEN or 'struct
>> global_data' would affect where the TPL stack ends up. However, and any
>> change to the code may change how the stack is used and thus possible
>> write to more/less/other data inside the BootROM area.
>>
>>> As code size itself is checked against
>>> TPL_MAX_SIZE at build time. Regarding build time checks, I have a couple
>>> of doubts about [1]:
>>> - shouldn't we check for less than or equal against TPL_MAX_SIZE, instead of
>>>    strictly less than?
>>> - shouldn't be more correct to check the TPL "footprint" size against the 10
>>>    (or 11 or 12) KiB limit, instead only the code size?
>>
>> Correct, this was also briefly discussed/mentioned in the v2 thread. However,
>> this patch only tries to address the issue with TPL stack being placed inside
>> BootROM reserved area.
> 
> Indeed. I was just wondering if in a future patch we should avoid TPL_MAX_SIZE
> configuration, and instead have just TPL_MAX_FOOTPRINT configured to 0x3000
> adding GD_SIZE and TPL_SYS_MALLOC_F_LEN in the linker check.
> 

I had never heard of that symbol before and went checking. It has never 
been used (there isn't even a Kconfig symbol for it!) so we would need a 
bit of work to make this work (probably not a crazy amount though :) ).

I'm not sure we still need arch/arm/mach-rockchip/u-boot-tpl-v8.lds 
though. It's only used for evb-px5_defconfig, all PX30, all RK3328, all 
RK3399 and RV1126.
I think it was necessary when added back in 2019 because 
arch/arm/cpu/armv8/u-boot-spl.lds didn't allow yet to remove the SDRAM 
part in it (c.f. 3cbec0ad090f ("rockchip: add u-boot-tpl-v8.lds") which 
claims "we don't have both SRAM and SDRAM in TPL" but we have SRAM 
access in TPL, don't we?), but that has changed since 2024. They are a 
bit different though and I have no experience with linker scripts so no 
clue if it makes sense to merge them (if at all possible). I'm guessing 
the additional asserts would make sense for everybody anyway.

>>
>>>
>>> With the new layout the check should be:
>>> code size + BSS + GD_SIZE + TPL_SYS_MALLOC_F_LEN + <min_stack> <= 12 KiB
>>>
>>> [1] https://github.com/u-boot/u-boot/blob/main/arch/arm/mach-rockchip/u-boot-tpl-v8.lds
>>>
>>>>
>>>> Update TPL_STACK to use the top of SRAM address and reduce MALLOC_F_LEN
>>>> to 0x200 to avoid overflowing global data, malloc area and stack into
>>>> the BootROM reserved region.
>>>
>>> The new layout is certainly safer, but I wonder if we are losing the
>>> opportunity for TPL to have approximately 2 extra KiB as they are not used by
>>> BootROM once TPL returns to it. I mean, it would be useful to know where
>>> initial values of TPL_STACK and TPL_SYS_MALLOC_F_LEN came from, and the
>>> rationales behind them. If Rockchip were to assure that preserving only the
>>> first 2 KiB of SRAM is enough for SPL loading, keeping these 2 extra KiB on
>>> the radar could be useful for future TPL development and/or maintenance.
>>
>> Please look at v1/v2, they safely allowed for up to 11 KiB TPL. However,
>> that change should be handled in a separate patch/series.
> 
> I had looked at them, and I agree on a separate patch/series. But here I mean
> the 2 KiB that (maybe?) can be used in the 4 KiB BROM SRAM area, in addition
> to memory in the 12 KiB TPL SRAM area.
> 

I.. would rather not. While I don't expect Rockchip to change the 
BootROM without changing the SoC official name, it's not impossible. I 
would err on the side of what Rockchip is doing in their fork and trust 
that they get this early init stuff right, hopefully *they* know what's 
happening in the BootROM for their own SoCs :)

>>
>> Some of vendor ddr blobs continue to use the BootROM stack, and others
>> setup a dedicated stack at end of SRAM. Mainline U-Boot use a dedicated
>> stack, and it is placed at end of SRAM for all other Rockchip SoCs.
> 
> I totally agree on following a common approach over more SoCs when possible.
> 
> Not a relevant contribution, anyway that is my:

Review is relevant contribution, so thanks for doing it!

Cheers,
Quentin
