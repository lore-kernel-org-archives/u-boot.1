Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80641CA5FE2
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17E0081230;
	Fri,  2 Oct 2026 14:33:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SS5bJisU3s6F; Fri,  2 Oct 2026 14:33:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3303F8101D
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790951588;
	b=RS1Ovvh6eJ9a/eqQf8mcTo620I+YU9L8x3s4wrVoxH/uJ1CgYH6kaxufwwby6EiNiwOL
	 CsWsPYNXyjkaAz1eVVxUBvre+FODsmZDkungbRWwd20M9Sqb4ggKmLM3Y42xQp1Dbfm2a
	 ltIb+kIr0U409EZDEkW2geamnt3VRWaGlTjhf5MwaNJchJiUYdg6Ot8YxahZKvLPhiQVZ
	 EL4RQdc21hzGdiOLmiNb+C7cvl927Bzn4zPKkGUOqJTEamMNq0yrsGM64FSfQoJP+IDiu
	 kOhLoa39o6GHwQCU1iJnSWYZx403W5R1XExVsIrrpYD39ZLPxUtTEtRcvfwD9Wyeayw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790951588;
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
	bh=EN+k9l5yCuXXrLVVKqnaD1JHzfV78fs+QrzND3GH8R4=;
	b=HIHkUzbjJbVef1YgnP15sBrsn0LtszCttm2hRsNztfQ5mGSq+nHBfDUN8TozntlkS55C
	 3Ki5DmCL6SWvuUgEl1i6OUDF1OofgaU0LIENbP1nzTWBAlLCCm8a2PK/wQnvI1FCDnt2r
	 nzCY1hYi25itBxANk/Mxs8dTX4GT/0v7zqdj5f+X0Ol/2eDx3Djak3sv2rnB63VYcbbJ9
	 bHkmNrxvosb2MVW7eqA6rLolgd4LxZVtevVlzSK5USIVRmzJpAXLQAY/pFJm0zoBbzQZT
	 3SzNhKTVXT1x0kfU62Hkyx05hTk1pvQxcOvTGl1sQ5ZA26HrGl0E1Van/1UG/54+SJA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790951588;
	bh=EN+k9l5yCuXXrLVVKqnaD1JHzfV78fs+QrzND3GH8R4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tQD2ogQANpkXJ6GdF8xJVRv8aJdX42oXBQJHeAR1Y/z0nAEKrZk75IL0ouVJw143R
	 nnjrNv2G6elH4nxs9zzLmc6drMjDX2M4zq6mvvbVaBdO7ORRskv854+ifT0aKabivj
	 rZbJ6itLqibqp0B6pIOwmSw55CuyVL6DxF6ATIH0sf+SYuLIbdRwXc/kihqhA6xnaa
	 jeKKbt4dCN8ysyy6p5JDxWDs44I2MBmDnzslLVSMgYsn3CgZHsLxF1TJak7h+kGEW+
	 5XuasYFbjQdgtXL4wmPTcOpuNzxOCUNp/5sWUKUf9FEmfYGX3bTgPf7CmWCXsunogZ
	 OPNelJMrHbzdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3303F8101D;
	Fri,  2 Oct 2026 14:33:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 02ACE282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:33:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E8178400D1
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:33:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JgieoQjrpLkn for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:33:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7B3AB4004A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790951585;
 b=UOAHJrKUc/4WxMHPKb4o5WzE1YBWtINTQbSYETe+SC1CLIcCL4BXNQC3jdmtINZ9cKQo
 XrY5bWNDpip4T7cN7CFxUOAMD9E1+SD6o442sE6/31VhrriQXmDxSdFCy8K0v2d9/ENvT
 nWYWy3OXUlSohhh2PJ2Mus8mqNKM01zwq6l5U+Ai/q+MeSl6UWkSM+gsdao+DtvUTxR+R
 jo/rFsfsJubw5hqsAKTNCPyiGF+8l9cilfyet4rkhNXjBKgcEvdbApFDXVaKmQLKRz4N3
 Oc6clmXfeZup9cRK7NmzN2CCsLYAe/28dsy+OB7cxhOkXl2uNIB3Rd/XWSIrd/dI4Cw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790951585;
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
 bh=EN+k9l5yCuXXrLVVKqnaD1JHzfV78fs+QrzND3GH8R4=;
 b=FMcT8LY77632bD3oMCGjDwC7hekn8O0IWGdRxEQvAZk5qxdVctiQfTgS1+gSS5ag/wBG
 ttBLXpsMgRguxEqVVEcuAQgN3X2nk2fjTd8nQgPxBmtMn/pgVMUv/h4UCVQcX2Y5c0lz5
 9Sgt0f7RcsobJDtGcvD9UP7X6eEebvxn9z9R+Dk44UA2/V1d1sDAOC6rGmZ/sD7661lUD
 rgxlVLrAnVWo4oYlS595e9X9DDSgD0D9JGuSTMv5aJZCKwvEP9XVnlOa5ahErU4pCxmIn
 Fw61xh7tEb2VrZf/SA8HfnjMPZXW/5rO0lljHFfJ+4b11FrFwJ2soOtq5LaYGpjvSiQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Up3YrqRQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Up3YrqRQ
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B3AB4004A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:33:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujhqLrqiTHHFo5FHxWqLkEw6+48R5+XAQhUbH5EnFmYmZsgR/byc3ZjrxY+b+babxSLyHHfcPg94O2e8EeabneFnjPiicZFnaZvTYdXv417js3m0FJpfogJ/Nc4kjoE034hBStCn+U0Wdxfn8OhGkbTq0MEZVZ+1HQ05Kn25x43DU64S7SQC7BcjWy2CYaOxG5pHVzHDV6dJAesYlL2atUZTwachp/yIdU+OfIXrq3nb4EvLbV08lXX9CwJ3kBal2RC7cMDkuIajREnFBgIOe+9gDfquGQsg38U57gfLi+EPL6axZUWHkrmALXN6kt7cSL9a0LI+7o8QgHo7eS0ZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EN+k9l5yCuXXrLVVKqnaD1JHzfV78fs+QrzND3GH8R4=;
 b=qLttosZhlqLXl7qpOmjBCdDLf2Lq28CnjRbvGXeobNRDztHP+DEk879wWIpBEDCUMTEEa9yMSXUz5w6/RLcdfWUupzA1TvIgL7eYqU5guO8VEz5Y65kOtMDfu2mxS90IN4xA8Nue/Em5dQi1SdJ4U2LEplMFj5bEBHD9eTzRTfVfs4Xg6+m5trg7NGAlJg+uXBrtSURe3rG5hnHXu1W1EHpSbIJaB2fdZzrhIb9j+Gpy/D7LNDFokBtIrvhfWTcocwHmvQAxV71QvQNBPIxUiCKkPSXHV8t9oRDQ1vV85ba84YCX8gACfbg8ddjFq8GHWM3djMC+zS4hix9Rv+b0hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EN+k9l5yCuXXrLVVKqnaD1JHzfV78fs+QrzND3GH8R4=;
 b=Up3YrqRQt4egQXqq06aisk50GlDlNoNggPO6GUp05yUA3xZPC5sPn4T+wSEE0nj3CrtlEe4kefljqaVnPQ75tyCgrqz1YGApox/gIk8wPphgnNTIlxhK/tpI35M5HD6ESivm4GHXsY5apJL35TPunoaBPJ4HRa9i4Y/O/4fb1H0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB7784.eurprd04.prod.outlook.com (2603:10a6:20b:2ae::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 14:32:59 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0451.022; Fri, 2 Oct 2026
 14:32:59 +0000
Message-ID: <2a3cc3b6-9bce-483b-827f-44cc3b58c7e0@cherry.de>
Date: Fri, 2 Oct 2026 16:32:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: rockchip: Add Orange Pi 5 Pro board
 support
To: Dennis Gilmore <dennis@ausil.us>, u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Alexey Charkov <alchark@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20261002031334.3285687-1-dennis@ausil.us>
 <20261002031334.3285687-5-dennis@ausil.us>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261002031334.3285687-5-dennis@ausil.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::34) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d04ddb-26c0-4b6d-e07d-08df20920ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|4133799003|11063799006|4143699003|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZoHpIKJqG2RHWuTXjjXLJTNrQa/dxkkGGolyutApcm6YJMpjfuMxw/RT7kRQOOoCDnIQshBvmMT3SEBJrbnHGBRQA9WWfHj/9FO5YsmoZC94gNmE3/QwQ2jgirvSoVW+8IKLUjZPHODYaOJ+RLmb7j9oSwgq/MUbX08rOKKAoZ9iC8K7re/9IlDwe34GPtMdDyLAqJcU3z2KPPKFsuzzB3NM7AxmIaOTznmwlZWRvN7SE9gqSqt0b+KrpsOUr532I7gcPm8l5u2utPNFX1jFFID51r6RjNcboWOEUfo/I+olBvBav/iJVsoCW2wq8GW6bmQ9GlQwukvs+RcPt67qwifRwGn0J+O3myVcCYfk287gSZB7wQOlHArJW39Z5KYemMw4RcDKum6fI9mtpf2KjEOmJqHdsZ18BjgeQ+biKFvqKwjC1SfeUgDAJs120HExsJ07JJ7mN/r45bFhYVHYbni4yVwC33KBuTv3ealor4MAMi/Xyr4PfaqNw2P2DYm3iFIzbuLdTdoDEtm22UOH1a6CquM/B9hdKOjW25lGZms1Bz+1OxGPqYd1DVSCn/PH9cO/v/eqgrlDyq+mt9h1p+2T5xVDQjpvRrqJ26bOLpA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(4133799003)(11063799006)(4143699003)(3023799007)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWZLR3dUUGtYQXptbGxPc1EwM0ZiS25GQmNSZWJoUGdSeVdMZVJCUXRHUGI0?=
 =?utf-8?B?allveWJ3L29VWEpkWHJCaXNEUUdRbnNRN2xZdWpOM2piMUs1Vm1OTHpkUDBx?=
 =?utf-8?B?Y1gvVHgwMWg1MUpia1gzSE1HRjByMVBibDVTaHRxckZGb0JMdys3TTIxMXBO?=
 =?utf-8?B?d0NUSlpBM1Ryc0tJblFuM1hYZTBHZmRHeThBcXJ3bnlxajNCMjFlSlhRZFRu?=
 =?utf-8?B?dmJ0ZFhGSWVVZkJ3alQzVGkwTVE1SHFnVFk3NU5pY0xFRzd2V3dFNmphUVp5?=
 =?utf-8?B?SytGYnB6WDJ3MXY5K3Q5aTdzZm13ckRkbGFiVzhEVlhIM292amRTRXg3TzRD?=
 =?utf-8?B?R21adGxWZXlQbGIwc2dZV003MTVaWkdhUGM4ZWhvTS8zZW5pbHI1clNPckN4?=
 =?utf-8?B?bXg0cDl1Szd3SktlZVYwVzJValQvUUlWbkN5ZkFQcWd1SlVnWmY0WEd1U3hI?=
 =?utf-8?B?dFhEZXo1SXRXZmYwclY0Umc0N04xN28zOFMxM01vaWhqbkx6YnQvWitTKzJH?=
 =?utf-8?B?QWpMeDlibnc2aE91WmRjQjZHMDF6dzU4LzdQTFpKbk10aXpQcnpXUUIyVjgx?=
 =?utf-8?B?dTFJMDMxSlNvS0lSU1JmZzdUd0lsK21HMGRwV1ZSNzJ3ZzN3cTJuR3Y3Mlpi?=
 =?utf-8?B?djdOaE9QWDR1SVMzZUhubFF4ZW00WjRTdnJ1dXdqUEw4VjRjTWM0NG93QWxQ?=
 =?utf-8?B?aHZBb1F2bEhLcEtjRTYrdU56bXdYUy9lR1FiaSsydk1hMzVmV1Fvb2QvSEx3?=
 =?utf-8?B?QXZIRWgyNjd2N2RldDdQb2xEUTlGdVJrdUVTRmJ1Tll3K2ZLL01URllxc1VG?=
 =?utf-8?B?YnhOWnQxUmNvaHdtbWcvbjgzamh4MUt3dzhMMEFKTENGcFRTL3BmU2NVQVhE?=
 =?utf-8?B?VS95QTBUZFdQdXBOVnJnVXZ5M280aWVmZ21abHFnWERKTWpVNmRmODV4QUpn?=
 =?utf-8?B?SXVPNlpTcTR2cVBaSGdscStKZDlYK0dsclpZdXlWVmJUT3F3WVppNlM4ZHFt?=
 =?utf-8?B?UVVKdnVRM1lnMC9uQVVjZUJiazNvSHZNcW9BWHg2U09zL2pXT2huRmh2SVQx?=
 =?utf-8?B?Rm8vdUQvWisxUnI1a3doZ3pCVFozQkoweHlnMnBKZ0hWMUtRMFpIYVhTZTRX?=
 =?utf-8?B?dVVITTVEUk9ZOXAzZVc4VEIzZW9UbXQzTHlZYStsZUl1T09ZVDJTZmRldjJO?=
 =?utf-8?B?YnJrQjNYZG1WZnUxSzNyZlJhSG9KOVBia3N0QXR1Vy9PM08yYm9hTkUyU3N4?=
 =?utf-8?B?dkZhNFJ0L0tqYy9TNDRyeGNTOVk5SlhodVd5bGlrUlB6TnJCUDlVdWdTQjlQ?=
 =?utf-8?B?b3NZWHlLYW9HZjhFR3BYN091OFBYTzIzWEt5WjZtNWRvTEpjRTdEbk1YMUdT?=
 =?utf-8?B?bFNBV3BrUnFkcFRCMDVuZlR4dndPNGRpdXhrbmtFWm5jNFNGdnhDTk8waWlL?=
 =?utf-8?B?SWVvWDBDWEtIR2FiV0JrbjI1ZVZFWi92VlBVL0xSbUU1R3JNUHhVRTFCZVZJ?=
 =?utf-8?B?M0JzTXJLampJYWtTNzA1bStvc0V0QkNsVGNlaHhaV1pkTjJ1UldnWFhvcVp6?=
 =?utf-8?B?Nmk1ODRhQW5raUZ1ZUtDQmVKa2l1ZHRQM3dIQTVWZWlrY1E0aFphNTAwOVE0?=
 =?utf-8?B?S00yVlBuWGo5bHNydVJ4d1V1cjJuVGRxb1ZSZ3VwVzJ0N0hraFgvZkRQWmdx?=
 =?utf-8?B?S1dSM2FNb2dveElzY1crcmxUOXlkdEdhcjBXMmhWRlkvTDVxa0FHcGU3VEVP?=
 =?utf-8?B?RGNzQzBlZ2lwNVBZQ3FTQ3BibXlPZ3ZIZkZEQ3p2OGFRZlBObTNXNGZCSWRs?=
 =?utf-8?B?Ymx3dUZwQzRXZU9DYmFaY0FobUo2RUtxMnRuS2hUYnBCckQ3UlZ0TUtGMzZn?=
 =?utf-8?B?K1BIZGtVK0VGem5sN1dFQ29xTkR2c0hvOWhFNHdISXVTRzY0U0JZWVFGU0Jo?=
 =?utf-8?B?QkRvMGtKQjBpWUQxdStsaG9ZMk5NNStGR09ERWFuQ2pISzl2allQbkhqUjBo?=
 =?utf-8?B?dm5CbjUrR3JpM2QvMzdTNDR6Vlg3U1pQcC8ra1pCTmN6NXhWUFdidW14Wi96?=
 =?utf-8?B?WkI0WDg2YlpnS08wY1orTml4cG4xWUR5ZkhlN2pZMkZ6RVN3QUNscnVhZGdT?=
 =?utf-8?B?TXNQNFVqMHJCRTVMaW1tcXZCdTBNTmFkVzRLL2Y0UGJNNXM2czBtc2dMN2Iw?=
 =?utf-8?B?RkdaWlNZL0RhVDRzb0lSSzJVZTY1UnZMRGZLZnFpY3JUc3hrVUYyNmEzckdP?=
 =?utf-8?B?WTdTVjViTTVsN0o5S08xTmRidU15Y0RLMGRpemtsV00vU1dudjgxeEliR1BD?=
 =?utf-8?B?UmV6aERGTVJ5Uy93elRyeE84RFM3VTUzV0E2WUZGeDlSMTZuN1dzdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d04ddb-26c0-4b6d-e07d-08df20920ea1
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 14:32:59.3927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOnGWTh+A30LDwaE7vBKElJ3dcThOQLDXa+3zUMr00VX5uSK1JgwUA6J7PUTv8Y6KUZ6UGI/6Jc7h9DdAyoCHFLpC7OgMtpdK25v+g+rdCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7784
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

Hi Dennis,

On 10/2/26 5:13 AM, Dennis Gilmore wrote:
> Add device tree for the Xunlong Orange Pi 5 Pro (RK3588S).
> 
> - eMMC module, you can optionally solder a SPI NOR in place and turn
>   off the eMMC
> - PCIe-attached NIC (pcie2x1l2)
> - PCIe NVMe slot (pcie2x1l1)
> - AP6256 WiFi (BCM43456) via SDIO with mmc-pwrseq
> - BCM4345C5 Bluetooth
> - es8388 audio
> - USB 2.0 and USB 3.0
> - HDMI output is enabled
> - the second HDMI port connected to the DP bridge is left out for a
>    followup set
> 
> Vendors schematics are available at:
> https://drive.google.com/file/d/1qs1DratHuh7C6J6MEtQIwUsiSrg8qgTi/view
> 
> Signed-off-by: Dennis Gilmore <dennis@ausil.us>
> Reviewed-by: Alexey Charkov <alchark@gmail.com>
> Link: https://patch.msgid.link/20260511025352.106126-5-dennis@ausil.us
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> [ upstream commit: f47af8ebbe5381e761a8019f29f3016ea9faee5b ]
> 
> (cherry picked from commit e533117c341594763d507ad8182d127845e038fa)

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
