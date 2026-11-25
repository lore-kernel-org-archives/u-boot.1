Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED6A606A321
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ryjai+Mo;
	dkim=pass (2048-bit key, unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=aK3kN3Ds
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4943180C53;
	Wed, 25 Nov 2026 16:49:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QHsSIRaqcFVR; Wed, 25 Nov 2026 16:49:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9944E80C17
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795625347;
	b=PWJ5ooe464pi2yB5yMXuARSil2dbMYnapuuDuNr6bqhEKyuas1aoLUT5m/F7h+FCPQTC
	 vlXcg9Ou1gz3gPf+Ghi8U+IDTwqtIisjWSC5Z+Q4wBbI6i6CfxQXtrgDULmK6/uHEEweW
	 2IZTInAcqJLTo8pEGf3Sj+ovRdZ1jJ/Z/LuSkrwHHHjIpechs/puzqfRtQ44kJ7o5jwii
	 pyNbsf4KvzLMCcyPB+eX0OvvJtefV4D1j2vuGHl7rx3eJ/lUFhnt5q1OEuIgx2zpa0Ez4
	 5qaVKG/3fBC1sGkVhE3kqcUmM2MRE1c21oJF6FbFlfKnfgOOMXSq8JDYSjAHjGRK/Zw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795625347;
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
	bh=LYmSFHAKGKNG50i/L70peWJkZlZYmJsHBMBobSGaVQM=;
	b=IoW6QHsx6aeds8XPOglH+bQCP49K9vpVW7OVHab4tdOcYvEu46V4Z69VblLhj7Fc6AJE
	 O3DtOsHQBNxzF8OFBh5Xg1rzrw6B03MVmegyXsNWySwy3+jd+FgVVtumsKuup8PuvirxC
	 Jng3Pv3j7UMnoHFeGwSSbCspSCdcifaf04whL1GLVVkgSDOD+o6iyEZPEaoZ9xh/nkUqv
	 wyncgUgdfKKFK0BF7QGn3wi56k6VsKKbz26rJ3eccuHI/RAkzSwHYKBVApcDzrmlR/DUT
	 9byXw14nbiiDUeSqfNnp439xOrR9hZ9iD1qs+OJkIp8OyiJImnaqGjXsfcEP5f6R0BQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795625347;
	bh=LYmSFHAKGKNG50i/L70peWJkZlZYmJsHBMBobSGaVQM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ryjai+Moqx9gTnObvmlTaWrRvnIPvEx3INsF1MQnRp2t6lIUDSF7dejthKgRS3mml
	 4tfY4KfB3tlY2ITx5c0EHOk/HoCckkcs3gmEgsPVEc8KqWREQkD7/XdPKgilQhUscC
	 mChWI7KKKtPX+uhbUUtLZDYLUPLjd6bsCJ7biBGEr2dw+dyFKqzbyzTK02yADFrIhC
	 MXkRCmm9xo8CJQW5CtxKTcS0DLsIbEdkJqUmieuNm7hrTvqvjiDmeui/U4k6US89DV
	 QI6JZ6Cj2dLHxhnM+3CN6DEYIXNwBGRydhrdyxMkZ09LInX9jV9uIRN4fZ6moYBEj+
	 saRgTMzoO9vfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9944E80C17;
	Wed, 25 Nov 2026 16:49:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9099F32D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:49:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8295140111
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:49:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ejtc4OmFwOfQ for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 16:49:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8E3EA400CB
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=b.hahn@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=aK3kN3Ds
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E3EA400CB
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYmSFHAKGKNG50i/L70peWJkZlZYmJsHBMBobSGaVQM=;
 b=aK3kN3DsVBSckNyNlRZgV7IClRWAiCoWxiBznSwH0oQsNnmbuQPX3+O1YdSvBAZfAl0MkjJfqlMMcahKvMI7dHww6XznLOzcMYwITrJgmM6WrkIpNJeH7/C6O2FkyjnaVCeRrsFR1+hXCK2zuwAOW8ViQgmVWOTLbJvMLRbod3W2Ymg4NPEp6hkAJ6sbPfRiLz7ur56IwpJjva0I38IeSyrqiWglrRobx9slCnQWCfG4t7SCuyInv6c5RmvrFsXE/ly0+Fc//1KOT6y50M75rROUfDdUTQu5iJgdAvI7KRdXonOyVZyLVzF36v0fEpG9I6BYIPU77Lusfy90jV148w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from VI1P195MB0623.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:159::10)
 by AS8P195MB2096.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:56d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 16:48:59 +0000
Received: from VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
 ([fe80::2f8:67bc:a785:6894]) by VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
 ([fe80::2f8:67bc:a785:6894%7]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 16:48:58 +0000
Message-ID: <ecbfa944-390c-41f0-b3b7-a4a88fd456ff@phytec.de>
Date: Wed, 25 Nov 2026 17:48:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: dts: imx8mm-phyboard-polis-rdk-u-boot: Add usb
 entries for SPL
To: Thorsten Schmelzer <t.schmelzer@phytec.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, upstream@lists.phytec.de,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Peng Fan <peng.fan@nxp.com>, Benedikt Spranger <b.spranger@linutronix.de>,
 INgo Rah <ingo.rah@linutronix.de>
References: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-0-dd6db9e5edfd@phytec.de>
 <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-1-dd6db9e5edfd@phytec.de>
Content-Language: en-US
From: Benjamin Hahn <B.Hahn@phytec.de>
In-Reply-To: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-1-dd6db9e5edfd@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:159::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P195MB0623:EE_|AS8P195MB2096:EE_
X-MS-Office365-Filtering-Correlation-Id: 31295437-bef5-4403-15e9-08df4b140057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|18002099003|22082099003|56012099006|4143699003|11063799006|261009223027099003|261102123227099003|261021121427099003|10067099003|261026140227099003|261022105027099003|261026121527099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: I8S8R7YJVBVGgyC3cXaeACf+8Aj/xtCmYq5e92Estq2S/FYF0lHM1+WAxYTfo+75ICavYByBf/QshJzCexEOAJ3m3UmrvwYpMCuIsTbVzw7KmJbj+rEzWjURAuW7LImPiqgSZ8T1y5S/+n0m0WUek0rlwbG9MefduSOFFJLOpQ7aqEHRl2WpRDMrUPtLPPsY4kCPl77cn6iS70aLS6lk7hFhyUqYUHiZVW/a5TaaSYqIgH1iJ3D0n5CENz9xGYWGmJKp/Ai3Xz+B0VGL/9q+ZRmXm2pON5BlaoG4pxwbNsagK9yqOFnag7+Gv12FgrnXAye2xRO1FhPC0vl1VKSemV8W2dLdGWHgU2L2TWmRaNZ43mWqIqvD+EFdz6bxL2A0Rt9KVD/WCVsPc9cVYgWHn4TYiP9K8AP5kyBTgjPutcH02RIp7pZ0cvNEIxkqsBbg1ikZ0Ngl/QhTNWn7aHJsOlUYsIeu0zybaHiN08JAQxCo6XuwAo4ZDBBSw4TinEcmJzEgXh07nPbV8Sxjj2lWUcvNar5HZQvWh5V2aiSOMqDmw0+y0CXteA04ei3MyxQYVsqJvqj+m2kZqAwPxXeAxiZVJQ2GhISGmPMu3felaNW0RAXWMW/P3VEeD8USxbSYyHPby8VvmV4cFH2xaFnydmofRScRG91Fl15398UJOH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1P195MB0623.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(261009223027099003)(261102123227099003)(261021121427099003)(10067099003)(261026140227099003)(261022105027099003)(261026121527099003)(261028144727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjNaVzFRUC9MdDE0WWFuZGFUMG03Y3NDMUcxVkd4MjFvY2RmOGdydmlOWTJN?=
 =?utf-8?B?MEZ4eEN1TTdpaVVTeitOUi9XYkNVeS91ZnpibE1OaUJ5N1J6YytXZzI4bHIw?=
 =?utf-8?B?NEgwQ2NyNXBhd2J2WVZvL1NXWEE3bFRPdE9CY08rV2FORTBCd3VVd3F3NTBx?=
 =?utf-8?B?R3dmMUwrbDNReU8zOFkvSEVsUXZjS2IydkIwS25ITHhjWmZoMXdUdUlDTHlM?=
 =?utf-8?B?T2dXZlpHUWFqMzFTMVMremQ1N1NUenl2blFQZ0dYZHpyU1JDYXpqWGhpbzdr?=
 =?utf-8?B?cTJDbngwSWlqR0JQbWZrbzZhNnp0OVlrcjRpS09JRHFMRUh6S0NrUmNTa0xr?=
 =?utf-8?B?aUw0T1MvdUllNGQwVmFkRHZDT3pLNndiM1hVVUpUclhLMEFYM05CQmhqY3hn?=
 =?utf-8?B?S3c5b0xFOUZXS2VoakhCMWQ5aFVOdUh1cnJVcHpyMEp2ZmowM1dCOUlSNUQz?=
 =?utf-8?B?Zzg1bWRWY1dXM3U0bFltWWE0T0hXdmR0L29uN3lKckY4N01zSEZ4V0hvelpn?=
 =?utf-8?B?aDZSWkJhejhiMWNabUcxTWp5VjV6TG5Jdm1DZTRaYkJ2V2FvdXM1Z2dRNk8z?=
 =?utf-8?B?ZjFNN1M0anhVNlc0K3NmbGdaWlJTMDlTMnQ5S0hTdFJncDh5dzAwWUJrd0k0?=
 =?utf-8?B?am1GMnA1b3UxMVA4dEFLVjJWYThYQUIrQzlTcTN6enV0U3BZVkkzd1RydTFM?=
 =?utf-8?B?UnRaS2JESmsveUIxZUVqMzBvMEg5bmlnbEtTd3IxcDZVVHJMUEhtVTBaR2xX?=
 =?utf-8?B?dDlRZnVSTHRYeHY2dGFWSVd0S09kVXpiWHJxdFRvOUxsSEpBUzNFS3FaREZ1?=
 =?utf-8?B?WWMvM2E5R0dwVEY4MWE5K0lCSVBMTGEyWHdiVkJZWVc5eWkrVzhjSUhYSlpo?=
 =?utf-8?B?WWZpcEtSVG5sYnNhM1JtekNpS0JJRVFNZ0tkQjNFcFdOdnVEdi9KUGh6MWZz?=
 =?utf-8?B?N2FTTDBDeGZUNGZ1akVDUTlkMmZlSUsxTW5iN1NxeUlVbFNWamZMN1BXSnFt?=
 =?utf-8?B?WTFtSEovZ3lmQWg3TkhnUkJ6RG5tNjRtTW1pYitrdTNzU0FMdHo0SFp1TWVz?=
 =?utf-8?B?L1ZOUDg4eitnTWMxTkZZcVVhZHdxZWUwUG1QSlFyVFpsekxKdlpRbndidGIx?=
 =?utf-8?B?UkFBamJGYXpEdVdIdUZUaWVZK3RUNjRHNkVlLy91Y0FuSHVxbkdsa3BlTTIv?=
 =?utf-8?B?SGRTbDY2RVpYcHVOZzFHM1Zzb2RHdmpEa0ZDOWgyMFpicGVuckFyaVVTZjBy?=
 =?utf-8?B?bDZLVXQ4NlFKajZrWWJpUmZrT0htNWJtZ01JaTRnR2tTYWJNdEtaOVI4SGZ0?=
 =?utf-8?B?dTFQd0FyUWhuUjVFKy9Ic21XMXlSYld5RFZybjI5bW9MSmJCOFFHWGhDaWZq?=
 =?utf-8?B?NyttQnpSM1J4eG5iRUZnZ2FxOG9MRjdmZkhtZmJ6RGZ0RE5FeGRjYXdBZGxq?=
 =?utf-8?B?VG5zb0pMdkJMdERROGQ2Q01xbHJhU3FnZjNybGpRMXArdDZ0MU9kZDU1cG5v?=
 =?utf-8?B?VHgxcU9HYXVYWUlmL3hDV0ZaRnkyOUROS1dEYmw3VmxUY3J5bUl5WjBqdDl6?=
 =?utf-8?B?TkRoOG9zRUlzNmdDeTFReE1Td0VtNU9FSGZpckhHM0w2VTRCemFDajBZM0k3?=
 =?utf-8?B?WnpyakJMNEhZQThUYThXS0FSUG96VUx1bUxVQ0Rad28vWUcrRW95TWgvOGtY?=
 =?utf-8?B?clR1R1VpN3FFYkVRRGJzNGE2TldLTHZJTDBJcDY4YStvRlZIOU5yT3VYSHVz?=
 =?utf-8?B?UnU5amUwSndzYWxuN2IreVdHLzhnL0daa0w3ODZrWk5GNDhTOWorM2xEOGMx?=
 =?utf-8?B?N2dQMDJnVnB3K1d3c1ZKbHNxRXdVSmpnenJaR3U4aDViUUZSYXJiaXhVRFpW?=
 =?utf-8?B?VDZNQkNLeXJxSDB6UFQ0TU9VNkd0bmF1K0JlNnBBV1Z1cGZwRlFTVjRHNnRQ?=
 =?utf-8?B?clUrcSttMmxkRGtTb3hiSWdFaGhkVlpWMHJ0T2NPV1RCaldzcEdhSjRibEVk?=
 =?utf-8?B?cDg0SUdqNVBKRU5xblhJbmlnc3VSSmRQOWhoQTNSOUI1RXFqUDRqSWgvZkFB?=
 =?utf-8?B?aHRYdDE1dzJSK1NPcXgrV0VQaWdiY2l2TU1aa01TZHZlMitjaFN0QUxPdENB?=
 =?utf-8?B?dExIRFVpUm5VQkp1YTNvenZxY01HdXcrbTl3WDNYNW95ejFydzFoTFFDZDhL?=
 =?utf-8?B?djJWMnQ1MzNLOElXaTBJVU8ydXpBZU1od2MzRUhpQnpTbk9zZHAvd2gwQzQ0?=
 =?utf-8?B?R1I4V3VyV3lleVlIV3FQUmZlamV0M0RPYVlUVGdzcXRQT2lqY01MMUNnWVVh?=
 =?utf-8?Q?vCt+MOyaMV0LQ5ys72?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 31295437-bef5-4403-15e9-08df4b140057
X-MS-Exchange-CrossTenant-AuthSource: VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:48:58.8705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1AaTdMK9bkgl3gBCGdYREzyJ3jX2ywuBv9PFQ+5bu0NuJsyxY5yLP/HwVdrezg/m1/ls8dXh5WYY1HMP157mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB2096
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 19.11.26 um 15:12 schrieb Thorsten Schmelzer:
> In order to support the USB serial download mode, SPL needs an activated
> usb controller to chainload u-boot proper. Add the necessary entries.
>
> Signed-off-by: Thorsten Schmelzer <t.schmelzer@phytec.de>
Reviewed-by: Benjamin Hahn <B.Hahn@phytec.de>
> ---
>   arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi b/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
> index 143ce6a6d77c..1d2b456b623c 100644
> --- a/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
> @@ -82,6 +82,14 @@
>   	bootph-pre-ram;
>   };
>   
> +&usbotg1 {
> +	bootph-pre-ram;
> +};
> +
> +&usbphynop1 {
> +	bootph-pre-ram;
> +};
> +
>   &usdhc2 {
>   	bootph-pre-ram;
>   };
>
