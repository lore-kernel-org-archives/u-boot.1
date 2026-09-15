Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1673C88E53
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 09:24:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EAA660740;
	Tue, 15 Sep 2026 09:24:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VSdciYZo_7jU; Tue, 15 Sep 2026 09:24:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B48186072D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789464270;
	b=mKEieobQX6MI3+8vchhlN12UMpiOxK7S4WY5YpA/vPzwkH5m5ghqXVf3nK+TJKeg1Qnf
	 91VibAN04ddWJc5u5EFlcwIphwVrq7naXAp27A5Vdo8qNapM0TuJRcwp9cQofzJ7/YMD+
	 cVzMwkVOpG6TGQZUdsNsX6ALT3RvXaaFmt/T4fqIPtTU/8Rl1pPEsqs/8Qxm85VrpoGxq
	 f1su9h5k/zzqmP3aEOo/UEWRWyIwMPUgK8k8HWdVvca1hGzTlaEKjUqeQN861d5UIYU2r
	 mmcUi83f/+r4CrJgAnk5VFTQUIRorkLupb9syV/djGQD2+GH+aTJ1vXioZVedMnQvpA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789464270;
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
	bh=Z7mf+nUyXAKprtAsjjEqJjt1bqkaKMdGo17OiQTn9a0=;
	b=f6WmcGxJAhj2fITcDCFar/TI9voUB4X9W5jHgCKbmiE9vTgcUjaC5G3lzSUu8oyrl6Cl
	 3OlHzuPRjQm5cwR2qITLHZCMP/tAd+Q3UXpu1TaxaUuL23Tj/2Ek9DupyjXANdAcmSYZu
	 rujWkc3izuz7rXzt6/xfgweLSNY3hY3ZD806iq/FIp/R8MpqTRx8WwGerPFtqG5JU6s/P
	 yhNYzpWxtfBeQILD3q/o0BQOkYhhxXxXdms7SKDSBVdY5TECBBkbLh8x03JFhHVlDseqX
	 Hjt9dgt2xiqhYNpBD0s4NyCvAzDGVyoNyJriaVr3PRKSYfhY3ctFLS00/t0Gz6b7KrQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789464270;
	bh=Z7mf+nUyXAKprtAsjjEqJjt1bqkaKMdGo17OiQTn9a0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EMD3y/hXMEOPlH4zhdsXb/29s01CbvsSOWal2RRe7RNwMT9P6usYh2M4/RXd+I1vT
	 W9boIYJ74bnb4wER47QOwsoAVt+EsQxuGdMRmXquT0ZX4LctmobhQ8LNKO3lDnYPVC
	 EsNCtbiRjsjyvY1V7A9+/TeoDELnSNlg8GpZt2aPQZ2TTGNka3bZkZ8df8+Z3h4yUq
	 uxwY2Dw+mk7FSa9HJEF34l6i/r/TLe0X9s1u2l3HXMmnw2PAkj2m35jFU0hXlBloHL
	 hPZP+U+TEsmuInp5A3BDxmjnyowkmr1yuUDhFC9d5bvayvxMWMPSXJvsbgyJY5GMFD
	 /lnuaLH5hKJCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B48186072D;
	Tue, 15 Sep 2026 09:24:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 14D6B493
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 09:24:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1284040568
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 09:24:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vSuwmSQBvwSE for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 09:24:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B819C40560
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789464269;
 b=An+Z81t2n5Qts0Me3vOAASQHOdNVojNXYU0dV81HOA4kNmCVv8lUV9jNWdyCfCUYPIhk
 WCw3QT1zZ6yXNbB/rboPgfGCa4PQ5xCvb4REXCXI1V9fJkyT9C8Uv8nNA5/kNQJ72xUI6
 3s7uG6fdGJQV3OwZe1KYsu0Ik+oD2h2WV/khEvFT2UWob21QMyQAWIRM22m3vNkSvJkV4
 zV0c09e2YQV5uEqjoy1t/YfAQmie96CVb3dwX+rPCfV6Po99iCI2jMMuVnR1wy5RR8OKk
 N/adS+lCZPHwjq7iv/Ynop61aC7eJAe2wbZbDwqa7JBlqKdCiLgW7QrGAKx1Ar2P97w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789464269;
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
 bh=Z7mf+nUyXAKprtAsjjEqJjt1bqkaKMdGo17OiQTn9a0=;
 b=U15Wucd+1iXmrj31Scwv/tkTH1Xq68NmVKhF773RRcH0egsLP04ohMzbV5jVJQm3FT6K
 JQT/2pI97dh5gMaBm4EHL4NLu2pE3N8KcHL/lhPcIEMTCm0YAN89W5ZeWR8Q6XPDC+a+P
 kWbz060PyDsBvOgDg5iRSgVudSlzGBshS3JTLnx2VEMXHGEauQxTbF1ZuDPCfrR9+TI6s
 8Oy2/VM27y37cT2v+8o0UybsdbPVqdVu8NjclfC4flx9o7TJnlp1efFitq8zv39hGvY/v
 FzJUg2J+WkOS2Gw4z0jXiZxvFZfJHkU4R0+2HLAWtIsyCDXqgtk6Hb4G0oj3SqixoAg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=hFeFi0Cs; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=hFeFi0Cs
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B819C40560
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 09:24:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9mHeOlhyFgMIQqyNApBPnYQVNtrYJHmT6NSp4+oTmW12JvVUH8mpt5fboDx0dMfM/Bd2+br63QrBXxfVblcpr17dOCjuSWGlxFu9hJqGU/9OYdKZpJWvXbGgJ8czYDIrP53SPoDwXnI7gcf8NoUX3Tm8hGy7UevVulzMQm0SIuBv38OJGw8hFmN7TaaEHVtO7BlBRwLnGM/XMSsbLZZ+UdTQyx1LsSvOrPSWzq4AefYkXOMpIw47/OzxQt1YdC2IFRMIJuY/k1vqJZK06m4GMMsjqFK4oKY73A7uFHoB9UpwYVnePWcqscn/++ykRPRopK2WBs4SEeJq+PKd+cQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7mf+nUyXAKprtAsjjEqJjt1bqkaKMdGo17OiQTn9a0=;
 b=Y+84pnfgUVJrhpXIBGypjRVAMTfk8eZieqRMnlf/Lq8bvyc+odC76kBMatiYd/s71XXdvS2Hkr7TSPzjhAFaJNWVTGTyaytVPIQuDu1uKSBRPa4KyC56l4BjaJ2nS4uwTlBbvn4O8O40/ab/+UFuViVu4ui8Wbu9b228mLFJxGxWBAi4bZ8YUiLaed/QbS/2d4ry8+R/KA8QsjsG0swsgCWnGjriETBPq5I2VdBR22cb0W1A/X0lnd/lFai8+LtMI19SJ915imdgyHFY0enD16DWCGIDQXDeaOdtAkHz1sxfdSh/MJEmc4kRTKbbI7+pSWn3psDelpeGnHf+3GZ9sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7mf+nUyXAKprtAsjjEqJjt1bqkaKMdGo17OiQTn9a0=;
 b=hFeFi0CsU7jhZRWtSjzytYyBxK3XMaYQGtMwf08G3Jrz0fkSVvjSeUOdNaWVFX48VxrYZ2efBbHomzQWXIDlBQehk2kJoPpN97vYjLiL77OiFTgY5c+OkAxJyI6+Q0My3tkX+o7De/vvwa6ozrU+7eoeYjwvMRjLcU9d0Qr7kDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by BESPR04MB12611.eurprd04.prod.outlook.com (2603:10a6:b10:100::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 09:24:25 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0406.012; Tue, 15 Sep 2026
 09:24:25 +0000
Message-ID: <9b9355ba-21df-4b4c-9103-6e1ca9fd1dd2@cherry.de>
Date: Tue, 15 Sep 2026 11:24:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drivers: Skip needless CONFIG_TPL_BUILD check
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, =?UTF-8?Q?J=C3=B6rg_Sommer?=
 <joerg@jo-so.de>, Carlo Caione <ccaione@baylibre.com>,
 Alexey Charkov <alchark@gmail.com>
References: <20260908-xpl-v1-0-58e9e5248c29@gmail.com>
 <20260908-xpl-v1-2-58e9e5248c29@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260908-xpl-v1-2-58e9e5248c29@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0059.eurprd02.prod.outlook.com
 (2603:10a6:802:14::30) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|BESPR04MB12611:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ddd3e7-4f01-4187-c8fe-08df130b221d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: b8RMk4ayIRtNwRG2HdjaNPOitnZzu+5HrEBWZCJNKpo8kCanMAua6ahRsQ+ShdaGXOvK4gCljsEZQ/gBfVWEzYTa3tIc10qUF6vQjomHfvhDgBBDQ8I42bJ2MaF6lDYXaxfueOJJKsV6mOh7cveTvKIJNmOQMn4AnFgtvNfwBxnbQtcG0TW5Nx5c5ayVR5IfTvq8zTcJUlp7pmrxtHZuW+5e/Jn73Uyj8rhPvq7IFb8XFn75RpJDcs+IDapJi7EK0XDNAdK++191aoEsIxmhrTD1q8tcyOgzCbn1Re+7esPyjP0ezD2U7cvXa83KO6FBovWYe0IGWyywGnmM+GLwgRyjGdg6rlZ8Z88w9ZMZOPDimzzjDKaG6qcx4C8CSGwxoFjC9uZj2Qiazb3N9maxlZtKQvQlYNIp8R5wgF7g+PiuTNKLPbvTbVafLECSWYNdUs+Y9btkmpwd2SUpi7av38u5oVealt1L0LSvkyKIEifs/9Uw+w1G6hrC6KVrBWxee4i90oh/OxKHW1DajhxeHs03Y/l5ZhbiyLYhUQy3CkavQhKxdTuocozezSZ+39qX0CxFdTPDKXZnUgyW/gemKio2tu0jj3uxIfOm4IEbO60H8zhfG1s+rapd67dwhXCHrA70N4CqF0oWEbWP+QKU79CWu3QGelEltU1ARjVy96g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWhBWFRCTFBhYnVDc1hEa2t1MGRqNmdjMXEwRmwwTlFSZTRPakRqd1RmM09R?=
 =?utf-8?B?ekNqbjVPKzYzeWRCVUMyVnhJTkpJMldoN2VhSWpkNEJRb3prOUgxNU43ME5E?=
 =?utf-8?B?ZHZjOElDU2pXT1FxT05ldXFqZ3Z5d2VwVGhoTUhCc3ZpaWI0Mks0YWp3a2dY?=
 =?utf-8?B?QjZIZGVZRkhYbXg0ZmpSWFd5dHErcnVGbkNhbzRFbE5lWlpqcVdmME5QdjAy?=
 =?utf-8?B?a2NQVE9ESkRRSzc2dFlYRnk2dE1tVi8yMjljUEJxSmw0Y1VEQkZCenJ3Sngw?=
 =?utf-8?B?SzdiVDlYM1Z6WlZwaSs0bUF2U1FYQmx1RUoreHAxOE5lczBSMnhQeHRLL0h0?=
 =?utf-8?B?Y3dGREh2WGtpclVsVG12OTQzVWxBcVViQno2TDdtU3drSmdqbDUyRUhYSTRJ?=
 =?utf-8?B?SzhKMVFLd0Y2d1piRWdKMTV0S05IT0NEMzhuZnlrejVkR2dJVi9LWGxOQmlw?=
 =?utf-8?B?UFdJVERtRGxDbWFBSkRYbG43RzdmZCtobFFnNFM0dmZXR3RTbEJxU01uc2xm?=
 =?utf-8?B?RDB5YUhYUVc1OVdaUTJGZ01KUDgrVmZtRjkrWExwaTlzSm9JZUpiY3pJbHRB?=
 =?utf-8?B?ZjJ3aGVVYmV3R2R0TmZQaEg2MkZwQVo4TG5udGs4N2g3N3dKRGMzSDRqdTVj?=
 =?utf-8?B?RGNETldQTnJmT0VWZW01bjd2TWxpR3V2WjAzTmRjVWJvR2s4V3RJeFpwRGNN?=
 =?utf-8?B?ck1LakJlQnUxOHoyRWFyUXA3K0JVREpiaktMYXVXV2hDbkMrR3o2MW01OWlY?=
 =?utf-8?B?K0Q3RVlTMHB6L3A0YVJkV3NKbWd0ZmdHUEJvaGdFR2RiV2czSVZCcnQ2NWxp?=
 =?utf-8?B?bGdkVXBoald6c2o2c285OUhCblRwWGNjbisyT09ENVlZdXJNUklrTzNVRGl1?=
 =?utf-8?B?a01ieGdZdkxDMTNmbXFWa3RjT2dmb29Va0FuWC9mSjBXUVMrZDZnOU1IWUE0?=
 =?utf-8?B?V29FZElFTFZuKytUMS9UUE80RnY3WVRLZmFRL3Y5Wmk3Kzh3aitZOUIwVFQx?=
 =?utf-8?B?VmpmMGwrbmZtejgrcU9zQ3dMUTFEUjY3azRRcFR6ZHVRM0FyZGxGSjEycDM4?=
 =?utf-8?B?c29tY3U5bGtCMzRUWTZPR3RvVFRtZ3ZEb3NTTzJCNytwOFVqZnpEek1SZU1z?=
 =?utf-8?B?bUJNNEx6SUhvR2szaHNBeXZXN0hRdzBqSFdnV0ltNnF5R0tid2FaVENBZjlI?=
 =?utf-8?B?R1lpd1Vxd0NKbGVycWw5OEFKdzVCRWJOMU85c29tSXI4ZnJXWnRKeWtsbUd0?=
 =?utf-8?B?cXlnTlZYTExJYWw5a3dDVkJ0ZUFXRGsxY2RiRGorMTdENFFMOGh3OFNkdjBH?=
 =?utf-8?B?RFZVRVNtQnpuaTJUeDNxdkd3b203Qjl3akg5eTNaUEFxdkwzVTZEcXVMc3JN?=
 =?utf-8?B?Q1RpeEx4NWd0KzJSRGZTWS8zVzExMnNESkloSTl0L0lOVkZGV3lWeHQrZFM0?=
 =?utf-8?B?Y0ttLyt0NXpkenlISDl3RSsvSmhmUndlUjNQZ1Nqb0l3U2hFT1ZFNXhRRi96?=
 =?utf-8?B?T2M0TnM2dndMM2U5SXltSzBKOXorL09CTkVSd0JhaFliS1RZUXlDKzUyZDNr?=
 =?utf-8?B?bStZazN1YnJVQzhIUi82WmNzTmU0MitWOGRabnpqdjhJVVRwMEVZdXVyaWc4?=
 =?utf-8?B?bjR1L3BMNlEzWWY1S3BiMEt5cFpSRS9NN1FKUnpTT1lCRllaampnUFMwcXZZ?=
 =?utf-8?B?R2trUGdxOUk0aGd4SkNtT0lLbGpGYW80OGlaa1cxdWxXWno2YWdvaWg1VmEw?=
 =?utf-8?B?WTRvR3VlTllPWmZLcEd0a20xbHBMOEZhdWdtdS9pZlpCbkVvb3Y2MHprdUho?=
 =?utf-8?B?UnFRTjE3ai9ueGlubWdtVUF5RmgxdVFTRkNBVzU1b1dQNFpUOWdQYjFKL2tw?=
 =?utf-8?B?SWk5VTZCM0xqUThud0cwUXdtdUk3YWhHdTZPT1RwVExhckxpbVhzL2xGakp5?=
 =?utf-8?B?eWpSUW14U05Ua09xK0lyWkhCb0daMTFkdlJiSmRVaXBqLzBMTThPdkh0U2F0?=
 =?utf-8?B?N1dFV0h6SnY1MnRwZjhZK1RjY2ZmVWRFVVl3NVkwQ1dEL1dLd05ZTk1Rc0Rl?=
 =?utf-8?B?NUhtS3ptTDh0ZnFURjdzbUwwNVJKQVBzN3EzY3JTeTFFUFlIMXlmMlFBYTRI?=
 =?utf-8?B?SDBsVWdXRk9xZEh5aXJLT3M5MFB1V1lTSHpkRmltUVhPcVVxYjB5dWZJVzlw?=
 =?utf-8?B?MHJxNWxWZ3Njb3hsVytGTkEyV2U2SFZCd29wUlNsTW9FM2J3Zkt2Qm1VRng2?=
 =?utf-8?B?M3FDSUR4amVnQTNsZjFQbzFPZjNEeVk2MHo5VVhVWGRUeWlWWXFCT3RGMmpT?=
 =?utf-8?B?cG1WeTRLbENmWE55ekYxZlR1RCs2bTk3OFcvZXhncHZ1RVNQYmJpQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ddd3e7-4f01-4187-c8fe-08df130b221d
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 09:24:24.9862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcAgJHs8VSE5LbBc8JpMmKpKX8q60nCJTTho8uFm+Oz0+byOWcppTSbxxF3XNNBTgk+efIO6M7YP1PONcfT3skx225AmoztYlixz7IHcGGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR04MB12611
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

On 9/8/26 7:05 PM, Massimo Pegorer wrote:
> Just check that CONFIG_XPL_BUILD is not set to select files for U-Boot
> proper build. Indeed, CONFIG_TPL_BUILD being set implies by design that
> CONFIG_XPL_BUILD is set too, therefore CONFIG_XPL_BUILD not set implies
> that CONFIG_TPL_BUILD is not set either, making its check needless.
> 

Haha, didn't read this patch before sending my mail for patch 1. You 
caught some similar issues in other places :)

> Fixes: 371dc068bbf5 ("drivers: Use CONFIG_XPL_BUILD instead of CONFIG_SPL_BUILD")
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks for the cleanup!
Quentin
