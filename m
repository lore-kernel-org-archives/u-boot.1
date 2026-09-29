Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92187CA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 13:27:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BFB740733;
	Tue, 29 Sep 2026 13:27:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IUfNglFWZZsu; Tue, 29 Sep 2026 13:27:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 377584072E
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790688427;
	b=MJkg4L0icyUbBouCDkv7LRIlrZD6zbe6cF1i8KG0vk+udEpD4u2ZLimx+mWtywhGsGQD
	 7ZeTnpzGlGoZGBGoPo8ShjiUrpMYVVk52inMGP604sBwnsFutM8bX+UGUT2AddUpSd0mk
	 DiyY25FKJs4STQ/AXQ7X1AroAn0fJjEtmGenzgqoPh+ACZAFcW+vk03yeZS3AliZHncAb
	 ax2fX2HYjThHkP+jo/3kOUe6a0uioqqT8jma4gb5/cIkrsd1kA+CeFDT4tH3M1d7BSl6N
	 uN+D6kvgvfqdbtVNhl4+IL0aE4f2ZThkV0oJVf5U+gsLipUy/5OxhRbeTnIBfo2gXcA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790688427;
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
	bh=6S35NNQBfD5oA/cbF0I4DZfMrUz8oBneiEtPp5U4bgM=;
	b=HGu0W5gUCbgDVbbFJWTuEc/Gq0LX4OrXfzGstYP2DhQ/WZUX21OsZrzXJkMiQfQEj+4f
	 BG6gmBpeO1iRfZO7U/H9YEjef7aYsdMU4MY25070wQy8QsScgZF6fk8lG6MlM+ICXQZu6
	 6ll2g39X4rToENvEcS/8AfwfungDGNu8ximZ5ZJoRNsC5k8ENAHQQGgA0W8aAoftfnSzk
	 g5/j8TGM8RGjuDxd243febo4xL2hGXFsVhn+Q8mr6bCoOHLWeKEgHEHlgL+gJIMP3nKAh
	 4wLVHCJdri0prkUO9KQ7P4wJhWyaCp3cEdZYWGdiy7Qbdm5FrPIMLHrzkiBNsy4opMA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=dicXEeke;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790688427;
	bh=6S35NNQBfD5oA/cbF0I4DZfMrUz8oBneiEtPp5U4bgM=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yUd0qcLEZMLYWgofDvRT9rovL4/c2UGltGyVucvvsnLB3tjAFXucMSjGN3y72R1YM
	 cRzPC3lPD50ArMXC29By/rz43eC0N4JOdCCSSL3Y8flYi+gbCa2qzsehWEEXdvVOOe
	 JffUYpR6ImwN89OnFF5DOq1ZOrcUJ14ogEbL1265gjsVmBXDfutHWW+B890IbR55uE
	 mjwRoAc+sTWclb2+TaGNaGh+LBYgOMseVgVwqbWd8xsM5g4UoT7fEW1eIyN210sFPf
	 nPi4Kw3K8Bga2GHat/u5O1N5qVLxie496hu7dWFXDbaAa4zNxyp81yMRmKc7Wc6Yh4
	 7WQHKTjrktSAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 377584072E;
	Tue, 29 Sep 2026 13:27:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3019B335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 13:27:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 214C14072E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 13:27:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jw3kyjsLpIRI for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 13:27:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A840E40352
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790688425;
 b=EBMtb9rMU7jLm0E4N1Zj+JS6Pm7d31OFsndfcUJu82lN4vBxDrr6jslsPZWmgSicmDd8
 IGtJTL9QvLZ75pJQRBBWqthH3HlC4yO4+6sJzDtbLNDOTw8IdI3VjFQhxOUUsXPC8+tnx
 En4juO/zNIA5j0YjCSh4djT7K0tDWYgvS5RlkHeqos9XXGbG+fdnnlwJDJ6lMNAlhOP37
 H2FPA0wreaYSzB5NGrEtzzWZWKjVHasjUQbSbLa7wXX8LYsw8aONm5/Db8Lh+gKhAGOLF
 u6IudG6+SMivC6ZOlig1Zk6e3rNFHIMEQSBPgn0vIrRrnQlkkMbjtssmR8AmO1SJjIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790688425;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:References:Content-Language:Cc:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=6S35NNQBfD5oA/cbF0I4DZfMrUz8oBneiEtPp5U4bgM=;
 b=BDlQ7Lk7+bMhCXXY7UYnFlqBF1SrtWNbSo1A5xmYKeXA5eq3R2PeqmNAVXpoZxM0LfCs
 GAhpwktbl/N98+4qyS1bhdiydnidHDrvZOD7PbrNQdvkgaxkdRlm/PQYRoL0uaRzaO4Qa
 BYDiyKL+WFxvkgvVt/BbS5zHRf+ol1KMisY1kwHyDwYtQT9aziw7XTkW3BMsqp4L72I2A
 af4y5+wz3BoEncTNgfQLhrzuoIrIg22XH0lCrIMmEMKo55pQRmpbDAJdZ+E/HkEFtL0yo
 ZGYxMbbtfVVgVHmm8aaLXfAfYO2GZ4BfNqAsOk7esMz5S/jeseoy1MqUhIJq8y/wiUg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=dicXEeke; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=dicXEeke
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A840E40352
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 13:27:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/n506ByI17wrxk0c9iiScbtAvbk2+8zMd12F3ZC6yIKRa7c9q4kRJISeE+ffo8JB1E/bNWy091aJ7d7JB9VUrDNEAmTQaZ5Zmal4vFWZg2NbKxdglzhqG/8ANxYrBZngAj6g6cQSkOS9JLqjxRSPjsPPSGpVPj3J0fzPuSV8sw22k68GNDeK66aVIJKVH+7LWEt/eNBwL5qRLp95vDSavjtwtRa7QM+RM9IflImHsLchZ1ggWgLrswoWKxGLXJ/8uc8cKfS3SLyLeLwChVN5I21OfgvJPv1xWF0vmWoUUi+JwnDYZ0ajQ9Pcc9V8YxAc/q6yAL+PK628qxSdPL1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S35NNQBfD5oA/cbF0I4DZfMrUz8oBneiEtPp5U4bgM=;
 b=HLNqfddTX9JdHsNAnPqkNbt/5NhjA32qyp7LVDWRtkgrZI+fScjp2l9hiIQOBU5sSEbEjsT8+cJv5UbqqPkkQZ4CsyvrVHw2IvmBZ6b+BQERAhs3iqHJUkD5467bcNNYj4rrZJBIQ9iZdE1yGqFZP2nOrpoCwYhTQspLLV53CN9GGEfNVhZFsMXSRr6pGLdx89UkBZjKEOL3DiPyhBqrMJFGvSdXwvniONoEC6mGky71ezH026vZUEJXV/dIOVtF/+S84ZvIQ+lTFT4sajTwxaruaeBc3v+LdcHsDPbVhOSmpDSnaj4/D1EdSstNP9/Ma6LbC+eiw4zDnxLRddB5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S35NNQBfD5oA/cbF0I4DZfMrUz8oBneiEtPp5U4bgM=;
 b=dicXEekeoTrc+86KGmostKgRRgqyaBdDostYhxGm819+oSPCs0NpdOuAolGYikN3bbah8qniut9J/+TNIx7rDbdb+IEUK2vOYQUeTJtwGmSt0s1DBfR/OssrjZnFfRlx7GkO3VWHsLadgGM6c/Jqjyxk/EWavjbJT9LMxbZMxvU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI0PR04MB11615.eurprd04.prod.outlook.com (2603:10a6:800:2fa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 13:26:57 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 13:26:57 +0000
Message-ID: <c2ec2a88-04f7-40bf-96ad-901b1ee7e675@cherry.de>
Date: Tue, 29 Sep 2026 15:26:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: pcie_dw_rockchip: add PCIe reset configuration delay
To: =?UTF-8?B?0J7Qu9C10LMg0JrQvtC80LHQsNGA0L7Qsg==?= <ok563595@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260814-pci-rockchip-perst-delay-v1-1-dde1904d9b87@gmail.com>
 <54b4beb9-2410-4107-a087-eb75bb82c219@cherry.de>
 <CAOm9pzAx0ApYVeCASjKAsP2iFZywkaxKTpFTJekQaUi-ubDy-w@mail.gmail.com>
Content-Language: en-US
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>, Peng Fan <peng.fan@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAOm9pzAx0ApYVeCASjKAsP2iFZywkaxKTpFTJekQaUi-ubDy-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::14) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI0PR04MB11615:EE_
X-MS-Office365-Filtering-Correlation-Id: d97c0a8e-007a-4e46-2cae-08df1e2d5597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|10070799003|1800799024|6133799003|22082099003|18002099003|4143699003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: U+xzSdgrZ0/4bPLYSq1Zq3gHQ0ooZO414lP0u2EeNijVAp3djggXjmC0gD0V2K7kymtBVbh0OoS8ndXjUtDwqpt+JvtKbPF7VMhRZygihJBqoMMW5GVDad31QxS3A3yyVegiXtV3PsfRMtsCMjT0C/ah/h17Mpq6Nl6CViDTvlPyeNzfbbNgSqJPKeNHNKmHG7a6r1tzFcQVn2G2ogMWGF/VvE9rJwnta9+zB2lvnKyoVCVqYwJVirexCi4XVUzYovinbppm+nO0arjB6qvB3XzFqIr0Uq3w324/Txqs8c7ufC6Rry99I4G7aEPqJ6m64A7v19IqqhLDQii+3JsqShdaWWIDU0/2KJkEOQ4m9QEknGdw7kaCTwXroQUNm3PncMyYQZkQ7loXg3/De5G/xbmQfQF9yRyayN9VgDlkhj3Kfmzbr9aBEtIp7giX8Hsx7sALzixgLXOupKld8EDAGgI7YUEWAfqzcj4/EOSsSkZM69h1A1bUYxGJ4geyJQAanFdJcuW+hJcZA/ykMzjRD4vCJtHnI5qfBAdxDRlY3RykC3aWl19Lgu6op2tIXxyaEuCltTdnCH0bgwfMrzzlHhGYz+6IopITco6GNqsENLI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(10070799003)(1800799024)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajB6TFk4TGpRQzUxdWNmeGFTT2lmVE1zcmtwZ3pDYUIwUlJpS2EyS2FETStV?=
 =?utf-8?B?N3J5OEUvUGUzaS90M21jaUs0R1M1ZXNtdVNxdUxnMThMN3VhMkV1bHBGZzFo?=
 =?utf-8?B?cytJcm5jbWhWa2pJeXJHeTk5STlYYk54VE54NVhYM3RnMlRBV0YxMjJqQ1k4?=
 =?utf-8?B?eWVCSkZqNFR6UUJmeHJLSkx1RWQxSW53aDJlMVpkN2c4Uk82b2ttZVQ4dUQz?=
 =?utf-8?B?SHlPd2RvOEFjelk2aW1qM2lQVmViRWdJZlM2ZkxiVk1kRktqQ3dpeTR4N3V0?=
 =?utf-8?B?Q2NjdFltL0ljK203Wk1YMVl2SUIxZEozWGttQXlWSFhoMWNaY3ROTTVLSzRR?=
 =?utf-8?B?cjNmQm1yQWRnR1p6TTZ2OGUvK0FJV08yQzI1QWNXUGJvL0xkNTRCbSs4dUxk?=
 =?utf-8?B?QUQ4akNwUHdOM3pBVEJxakIwMzYrN2VKb1dScGhwNVFJL0ovU1lodHpKeEpm?=
 =?utf-8?B?VXhuMVpoOW8vUFN6d1hNbGd3QVNoV2l1SGtoa3BPQ21LVHpYclVmeDJHU0lS?=
 =?utf-8?B?ZjFvajh2MmdIdE11Snh5THdHbEplZ1lkd2NMMlJWTWxsUjZOeHljOVVaZTdE?=
 =?utf-8?B?RWZYVUtwOGVhWUdFUFVyTEdNaDMzZWxYMHBibUxOb0hncGxlK0s2WE9zdUo4?=
 =?utf-8?B?RUhRNFBVNzRuaHVFZmhDS0ErZmlyWElxZ2M4RUlTd2ZSenJJNmtrU2JBZXBQ?=
 =?utf-8?B?S0tLdzhkSHYvWVJkc1pVNmxCR2RVQXZ5THM2WVlKdUlZTC94M1hWYzF0MURv?=
 =?utf-8?B?QWZzdGN6dFBVSjhzZmdwbEVLY0F6WEI0cEVoSTZ3OVVRYVlnV0l0SUZiOUNG?=
 =?utf-8?B?djAxQjl2UEljelBZcitPb3QrTFJzenMrZkMzcUU5YWRMNnhIWHhCS29JY25P?=
 =?utf-8?B?MDZZNmlMdWp2STBsZHVCb3ZXaE44SDgwdmJIZ2lZZDVQWk5YUVFxallNQzZu?=
 =?utf-8?B?Ny9jSVhaampKVjRkeHFkUyt6VzFqWGVPTzFQWGZoS2hnSDN6WVo5MVZBeGJZ?=
 =?utf-8?B?R2YxSCtNT1R2ekhiWC8wamYwaFZ6a2JEcENkWWprc3c5VmJiWlZnUVhRUVBj?=
 =?utf-8?B?UmUwWjFwYk9lV0lhK1pEYkFVMVNUTWlRZWNWanBaYUtpbk00M09lVmxXM0tZ?=
 =?utf-8?B?bkNLa3RwTjBjenNPL3Y0VSt4cHpyLzdiZmpzT2tuYjlRV3k5QWFFelNYdC9z?=
 =?utf-8?B?YnladjBXd0NYSlh2ZEM5cENBZVlXM0wyLzN3YUg1bS9xNGpQQXBHeHpWMklx?=
 =?utf-8?B?Qk5seEJrZWt3VlpET2NKcXloZC8wRFF1Rlg1UTBqR1Zocm1udmhKY0dYY2k5?=
 =?utf-8?B?dTA4VSsvS2xHOGdWamNxMGdYQWVJNDk5d3d6eUZXTS80eWIwa2c4OTdlYUJz?=
 =?utf-8?B?SXZKMHNEUXcwNmRicVVLblluNTdXeklSVDREV21xZU1BNDRLMHQ0NEhvcGU0?=
 =?utf-8?B?akhlQnJrWEt4Ui9vVUREUFUwS00wMGhlUkFjZXUycFVZWkl3Q0JzT0NmNDlN?=
 =?utf-8?B?VnhVVmh3a0VENzlPUnlXbzQxVkdCUGlRQTRQZHM2My9oL2FTak1oZko0Vy9P?=
 =?utf-8?B?MFRPajR4UUlkMXRHb1UreUR1RERwUVROcEJRQTJPbmk5WUxHYThIbVZvV0pL?=
 =?utf-8?B?RjV2eEZFbW42UFBjYTdFeExnOE9CQnhrQTJTNTNGSHdvQU5wRHE5dGdLNXQ3?=
 =?utf-8?B?cHY1aGkzVEVPRmliRGp2SkpwUm1GbGJRcjN0ajhrSW1ETzdnbzU2ZzNjam5P?=
 =?utf-8?B?KzhOSlNyb3hjWWdpSzNqWHFjYVdqd3dtTmtTek1ybC8wNk5SNmE0RGhKbjQ4?=
 =?utf-8?B?b2l5NTBRcFBqZUUxZmRnWEZ6TTRydWdTN3J5ekZkSDBjc2tJNTJMZGY2aEJ1?=
 =?utf-8?B?WEJLandZSVFmM1RwREw0bytDSjVoZDJMS2lvYTZnOG5Lc3d0eEc5S2hodWZ3?=
 =?utf-8?B?RjdnWHd6clpRSWg4MlRyaGdVQlRMNDJmdDFkemJkUGZmUlhPaFdmcW4veGZx?=
 =?utf-8?B?MTlnV2lwdkNoU0ZvZ3paZ3VCbUo1bWNkOXdORU1HYzljWDNKSjBUc0hQeThh?=
 =?utf-8?B?MmtMMlIwN1dnVVRVa1g3dVBDYnRLZXQyODdQejVQQU1JbjYrUGNXZ2lGbitD?=
 =?utf-8?B?R0lhZ0FGRVhKOStyT0cvT0djMzllb3VqVVIxNzVFRkxJTVQzc3U2VmpYRzV2?=
 =?utf-8?B?T1VyWm1uVG44Ky80Sk1la3NmQUtNQW1mSzM5N0RlWDVUbUhBQjlFWjJyK0x2?=
 =?utf-8?B?M2pSL2RndzI1Q0pleGtITUdCK2xycVd3Umk4RktuR3ZLdlZvbnpQVWIrVFpt?=
 =?utf-8?B?WDY0NnJOM3ptM3FqNXZRQkcvWVpIZXlHVzFscENJL2YyU2U1MVIvN0tUMGFV?=
 =?utf-8?Q?JCAXD/VHeH2buSPTag/CwnRgokFDgCkzFHwSetiTuwA/E?=
X-MS-Exchange-AntiSpam-MessageData-1: MilVD2WWhlsuCzB5jH/KG3covuDJ6fbs4+4=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d97c0a8e-007a-4e46-2cae-08df1e2d5597
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 13:26:57.0018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWx1K3o2SB6ySwi1HAhYa7y8SWpXQ6urxue0k9LZxxV2odebQzAiG79x6FudDNaoaaZ9KFLZFUBlowuy1wAUqZZik9by2Yruhm8piqA1P8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11615
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

Hi Oleg,

Please always use the "Reply all" button when answering to review on the 
mailing list so that everybody gets the information.

Please answer inline and do not top post, c.f. 
https://en.wikipedia.org/wiki/Posting_style#Interleaved_style, 
https://en.wikipedia.org/wiki/Posting_style#Top-posting and 
https://docs.kernel.org/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions

I don't see Neil in the Cc list even though he's the PCI maintainer, so 
adding him to the list.

On 8/29/26 1:16 PM, Олег Комбаров wrote:
> Hi Quentin,
> 
> The distinction comes from PCIe Base Specification r6.0, sec. 6.6.1.
> 
> It defines two different reference points for the 100 ms delay before the
> first Configuration Request:
> 
>     -
> 
>     for a Downstream Port that does not support Link speeds greater than 5.0
>     GT/s, the 100 ms delay starts after exit from Conventional Reset;
>     -
> 
>     for a Downstream Port that supports Link speeds greater than 5.0 GT/s,
>     the 100 ms delay starts after Link Training completes.
> 
> The corresponding requirements are quoted in the Linux PCI core here (lines
> 49-61):
> https://github.com/torvalds/linux/blob/master/drivers/pci/pci.h#L49-L61
> 
> For the >5.0 GT/s case, Linux also provides
> pci_host_common_link_train_delay(). Its documentation states that it must
> be called after Link Training completes and before the first Configuration
> Request, and the helper performs the 100 ms delay when max_link_speed > 2
> (lines 59-70):
> https://github.com/torvalds/linux/blob/master/drivers/pci/controller/pci-host-common.h#L59-L70
> 

Maybe it would be a good idea to do the same in U-Boot? Have a function 
in the core, that is then available to all drivers (even though we would 
only have one user right now).

> The DesignWare PCIe core uses this helper from dw_pcie_wait_for_link()
> after the link has successfully come up:
> https://github.com/torvalds/linux/blob/master/drivers/pci/controller/dwc/pcie-designware.c#L766-L817
> 
> I split the delays in the Rockchip driver so that each case follows the
> timing point specified in sec. 6.6.1 directly. An unconditional 100 ms
> delay after successful Link Training would also satisfy the timing
> requirement, but it would add an unnecessary delay for ports limited to 5.0
> GT/s or below.
> 

What does the kernel do? My rough understanding of the only other place 
where PCIE_RESET_CONFIG_WAIT_MS is used 
(https://elixir.bootlin.com/linux/v7.2.8/source/drivers/pci/controller/pcie-rockchip-host.c#L320) 
that is relevant to Rockchip, doesn't actually check on the supported 
link speed and does the sleep regardless. I understand it may add an 
unnecessary 100ms but I'd rather be in sync with the kernel rather than 
doing our own thing. But maybe it's something one can fix in upstream 
kernel as well if that really not matching the spec? or maybe I 
misunderstood the code, in which case, please correct me :)

Cheers,
Quentin
