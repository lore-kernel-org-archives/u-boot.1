Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0914ACC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 12:46:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1F4F80AC6;
	Tue, 13 Oct 2026 12:46:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HFNoi3sEKQ8O; Tue, 13 Oct 2026 12:46:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BB17880A87
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791895611;
	b=L5RVTSo+DDidHsGlyjMb/MpN/P5gBwkA3NIP8T1lK5GJT/WbphH0g0j7NGBaHhL2XFOS
	 HG+tgJ7Ju4XDFYRaXaIkBOQzB7ryYbPeJ4yLw9t4bBsFSXpC6qebf9/I9lAnbuDgY1bft
	 o7aObqGjHyEPxrw9g+6KwKE9zVfwVG96TheK2akv9cM+e7YxUO6B14AB2C8YqBTpQaULF
	 jmpqIYTFxhHCRKqt9HD1JXW+PE8auqrijyDLF/0Dact2tIws8zs+pJVM0d06MsNubObfl
	 HbgMwuPPVoJPx70lcMNODLphu1nDN7X4n8bZfvWP28G4wyGiI5uQ9saD/UXdLJSRImA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791895611;
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
	bh=IzDpp7Ez/CvaP1RqjzGAN9l7vuDe+s6kjXvhFfVeXjY=;
	b=kRpSdZyeM9qEAELci+nkzbVk8eJ90MF7lc5NdYHg/Y6hfAVEGXcW8zFz07Wr05X85mEU
	 gs2OnjCVez+HM6IwiCzhTxy45ZEGoj1TnX6ZH5gdoXwL0cJ8OiDxHvrQcVW3IRG0aeafp
	 JA7a6rqcYTW0dx6DB3UR/hWmvnmXHCiBdMovzpY8uGOcwVwM+6xvb7fHcw2AjIWGBcfET
	 jidh6LL5jpe3AqMSSIuKXLb+ccSEnHMvnzMqqL/I6/f11lRZtL72PWGvxpLIrjsjyi6Fn
	 I1IxEy07ucfzT7kj0EqerSA2evqQmTt7+6jcYMDo4tRWK3fHV8bcN2GQR6SsdBkWnig==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791895611;
	bh=IzDpp7Ez/CvaP1RqjzGAN9l7vuDe+s6kjXvhFfVeXjY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eaR8JPCHIeD9bmkfs71fuNNQOE+OPNDpDyGjjoG/paUne1DLIxR58yMDYhvlgzLae
	 dZ5QmAtjfVdI6k6VQvxmRs/13WmHurqnRdGL9el/TSMZo8ucEoTkPyMsB+TRHz1F7h
	 pfM7ulcIiiJTod+yKNAY/xj5vifrYeDI7HEo6u/RDa2mUd74tVE9Xfun5KkT0U8+6V
	 3hK2aCkzc2cJVBjh93iPvUhhMWC/SX/724eYrqNrg+TTodQZ2b7hoKL8DB3tCifvkU
	 egefNhtp3+V9Pfx2sz9imIcf0FQES3rTNNjLdmwzSQWukCWP8HcxRPW56kUIAUoW3Y
	 dlduhWxLJlw4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB17880A87;
	Tue, 13 Oct 2026 12:46:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A743DDE0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:46:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8CEF54050C
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:46:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M7GIwxdlu45R for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 12:46:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C27734050A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c007::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791895609;
 b=f/Z4OqyVSOV9hEZr4DMNSxD8GqAOoHyu1ZZxIbvqffNojgeKuiI5R3jDNRRLyV+7mktI
 caDDXvxwlmugTDtBN+v0JfNHfnxIbjV1awoK5Y33loEfVyVOksQfui8ZKJTC+XU5YIeSQ
 1B2KBdpOWAJvCEAtFtcLx8uYtdauyW3N0/pzOLMpgVhtSxMa7nzq19eEfULsdZveuob1L
 cvYLPxqFe5V2KUr/weBDaWCpkTwNzKepjNzOUzFFKpD2YHCbChE4BVNk9zPdzHILsVdst
 fOmJF7POFlOXGOt19gHGvVZRddYxDd12m7Pjbxc4Z/F7rZipxyGLAi7x4vtrYZM/8PA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791895609;
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
 bh=IzDpp7Ez/CvaP1RqjzGAN9l7vuDe+s6kjXvhFfVeXjY=;
 b=VSLhWHV4bG68oO6m3oBRukix8Fp1gKNxg1QZZPQLctYDHE0vXHl2LT2KWc9aUbqW9Lyz
 hHmwy6zpqonFR1G0gPE7efFrY1V6C3mlVRHI7hqd/lwiiatWKlkgRE5uqX1jpbARP6Jnj
 okmZWwpXe5bHinuWpW4BYrxq1lliiUh11btiGgTB+RQfNFnn+N1fmUxT3QNV6GN5oeaXu
 LQUsFvJ/CcWEuhQW6A2t04u1c8UmECMMxdgFbxIs8oQfkN/WdbMFZxX0ZhviXew78VbnF
 UTs+Svb3dgfy22t7ySjJ6sodjBN+7psX1iDtW3kkwliXs08II2wTW0Pj6IiH9pT4BZQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=cGyUZPGi; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c007::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c007::2;
 helo=mw6pr02cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=cGyUZPGi
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C27734050A
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:46:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfwwIPHqcZhK+9+5SH7Y5o3BFaNf7enz5Lmadd5BwBEj+Q1VQl2NCdOMkRbqjPg7LoVXQ4P3GqL3dw6l2f/1O+7MusEGK736S7WpYPwhk0Aic0u6rls/N1sKVdmNIx4iU7C5bzgGYKwXMELNXzxH5uOq+rIXnl9eSeninkYyt9DwvrtBAgzgrIqsb537Aqm61tSp8jYDxJugeE+H7pbsazfrZS4uTnEoMpPeKEfFjfdrwHZz8aePFjQ3hrux7lKjiEvXt4RhzsRbr5ggvHyW1zz97oIIUfT1G5LRRCQ0ZzdwwNjZUB3YD0zBlFO/yqbrRrlBQKImXWSTmU+JJxkWeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzDpp7Ez/CvaP1RqjzGAN9l7vuDe+s6kjXvhFfVeXjY=;
 b=Oa8U26vXSzd0yuPFW3M7USadk7MgcwMhqPCOuS+KcIS9hRV1xYfalghUeQhHeVty2QC4rnhEdEOjrn400+v252MzziPK77UCNU9UVu9H6CTdPGE3g+cvpdzW2wnc450cWRMPVkbY/QUfEA8jdxxVr0X0Sy8qiB4yJNcD91Yqsb8azs8FzHrp9n4AYVa0jdaR9AbU6ZOoqzFdE7u52t25BbAztss9pJzxaW7JspSa2UrP6lVYw2rtwcvtLDyEiHlj0FdhPXPzVhLDwSLTwwTcm4u0TC7chGhtR92jIaBdUqVkVy0iTVJZ/M85YZMtO8vuxjYcGzjYRdvNARY4FxgFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzDpp7Ez/CvaP1RqjzGAN9l7vuDe+s6kjXvhFfVeXjY=;
 b=cGyUZPGiRrkTyy4rTjbaxxw4+ZHn7A/V6hwPMDwxSXxKF5iIq2or6IhrJI+/yyQoJWIhbdpWTCSJ5wi6UxM6Avp4WUnbdfZVTo4rrwM8Bx3+LEkHy3ADdRe0zjkgQuaaIopEZ9dDid65/0Kx8b5lbOTL0xG8MpcWTvQyeMoSMXpsTygdjkR39qMohwLUTI36RtUxBz1ZxcAY52mWd0NiGB5F+iVGgTjiy1R99ukADPf8XSzAGTKNSdCfjMzxizZ+Om5lIbhe9wRz88eXc3qLBsk0s/BeQ8NhFqaWAuHrqWCVLAyjLqFyCv/ZTWnLUCMBfAm86lD+ZYhGo8va/04Bgw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DM4PR03MB6143.namprd03.prod.outlook.com (2603:10b6:5:396::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 12:46:42 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 12:46:42 +0000
Message-ID: <9cbd3af0-1bb5-47fe-bdbb-e61c2f077276@altera.com>
Date: Tue, 13 Oct 2026 18:16:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci: do not time out a command that has
 completed
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>
References: <20261013-upstream-mmc_sdhci_timeout_b4-v2-1-7c6383b789a5@oss.qualcomm.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20261013-upstream-mmc_sdhci_timeout_b4-v2-1-7c6383b789a5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::9) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DM4PR03MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a5fbaf6-ef3b-40cc-87e6-08df29280820
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|5023799004|261009223027099003|10067099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: LsO6qMxYqthWPrR73Eyw5uts3T9Lymic3WgUdI4zfzpDTMG0Edo3iAAn+N5J/LsaVMhNTxyjLx9/xUUuQeXWvd3SOhO0unbxBZWdrT5G3nQtbw+IvjllOnmUZ7WD8P/Ut5J58ArtR/TR56m3TuMtRjSRgTAPPVd0Dh4RSN8q6gjBf6O/7sGMYOve/w7TAFZZmItNypkzDT0zUwgWSX919bCBQHE5a+vsYMjgtLXMGNWbEF55ruZmZoLpNf7djXZbh0VPTSzYWSLVpFYVISqveNOy+kQlISukY3RVUI15N7js28q0r2RJ1P1oWTpz+ofmPzwV28W7u/UE0yeJMvMI30jsX7b2ON7Q+UJzIsRqZhaVaDIHVo4ZgSMcsDNFZrf8bpdR9RX6UjjvgnrJ62HeqVZnmT8c3H5CgRJzeRswH8eLx/EpNDiNbu1KUtk5U5HTuh4d3MmkskLmOuDmT2mchwD7dc6FKvIbEvPrVKYUKU8926JmoI6WBJwRe16No/raWIZlktrpySaL3Ju/QhT7S4VcvBT6dUSYTTXcmY91erNN8RAQPBPwRHPZIYz5tsNPDCxe0a9QooUYUsSrboRduiJ20v7yGW8mOC5B8GpqXadcvygLaJOVHuPo5wDArNYG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3lQeTBoRmI0alNmOEN2Q3lsUlZqTVM5YUgxa29rOWkybXhWVlpEdWIwZlQ3?=
 =?utf-8?B?VzhQekxvN0Z3eFo1Ykx1RXNTNGdwTG4zMThRNFN6UHZibmJmaHlIZTR6eENx?=
 =?utf-8?B?K1ltL0Z3VkpxUlVnaHJoYkpqYUZyYlFhTVB5RmxUTGtQMkRQMjAvOFFFaWgv?=
 =?utf-8?B?RHUrREpHYkcwNEs4MGhVakpEWUE1M0tRNDZqK1JHYjhDRDQrNGtCemZkcE5w?=
 =?utf-8?B?SG9NUVNZZ1lJK2dzNUZiM0dpbVpBODJGVnNqeWFKNGU0a2JiZ0Q2OExKb3lD?=
 =?utf-8?B?bUFWazdsbm8xQkxJZmhncWF5L3YwY1NoQithZG5wQXBxbDFrSW5lYXdXTXNa?=
 =?utf-8?B?NkFyWjYvbEpSc3Q1RzJWKzcvcmExcG9CVWFJV21MWWJSSkRFOHYyRSs4ZDZZ?=
 =?utf-8?B?NXo4Nk9FTW9nTitJZElDYmd4bklQTmJEZjZzTGY5UWFtWFBCZ1hVbE81aTlI?=
 =?utf-8?B?TFg3bm1oZ1hjOS91SndON2g3OHA3b2EwSFdUSnJqUmt1M09XeHRZN1RvWEM2?=
 =?utf-8?B?ZEVnT0pYWXdGNC9Gd0p5Ry9ndTlQQkFBcnJJV1lHZ0ZETGFyTnZQNVdZSVNK?=
 =?utf-8?B?WmpzbWRCYTlaSTUwL1V5YUc5YzJYeWRSQzdUbXh1d01uVk96eGx0YWZrbkRO?=
 =?utf-8?B?TnVXTW03M21mTlA3dURrcXBndWdHMlZONGZHTFZjR01tZk1VeFExWUU4WmJm?=
 =?utf-8?B?cno2UVd5N3QvNnJuTk5mbFhlcjRuNDM0dVlRY1pobkZrYTlyRHdZYUh3Nmhx?=
 =?utf-8?B?S1pzUFFDSklBVG9nVkFBZGFiN0IwUERWeXpIQ3FHT3lINXFsbW9hSDE3VHU2?=
 =?utf-8?B?cEFBeTVnMDBwNGJqY3lyOC9HTEt1MHl0OUFEVW5lSkJrbGN1bWMzM1pkaWZW?=
 =?utf-8?B?T04xb2ZrYjlwcDhrMEdHRlNEanArMEtvdWNlcExxcVhWZGpIeHM0NHlFWkNr?=
 =?utf-8?B?bkhaQjkxRDFGNmVKQi9CZjZIZnNUVi9yV2ZQMjVOOG1NRzFxNUxsN2hSeXJo?=
 =?utf-8?B?K2srVnc5VjlnU01QUG9sRUFkRmxjM0dmeUROTTVKTFdqYlU3Ynh3SUF0Q0JE?=
 =?utf-8?B?UXFuZkRuVUpnakd0ZXkwR09ORW9JSEdXeWZUQ0k0M1JFSk45YVFqOUZFZUxk?=
 =?utf-8?B?TWczNFJDb20yVlpXRG5zMitGTy9rQ2xkMXVFVzBlRnhBbkVqK0x5cWhmWVZJ?=
 =?utf-8?B?aXVEWmJmTEprM3QyQzRrT3diTHJhQVMzUUJXTnN1emdJYjdUQ096bjVXMG03?=
 =?utf-8?B?cjdCdTIvY1djdldoSGpQUUg0djFoTjNZZ1FndzFsb2NzK054eWJkeEFxaTB3?=
 =?utf-8?B?OE1tdjA5Mjh5TFU4bExNeVNWbjRGNkZTSERGYnVHR3BTY2lXRWJCbk5JSW1Z?=
 =?utf-8?B?eFVxUmtHU1FoK0ZzYU5ROHpTUmMwOENlclFFVHBoK0ZkM1hOV3YvOW10Z1V3?=
 =?utf-8?B?Mzd2TngxejZMeFlQZDdCeHRzbGlUcTlKSGtLdkFUVlN5cnFhTVZsckVIanBR?=
 =?utf-8?B?ZXROcUFLbDYxdVJuRGJQU3JoV2duYlljY0NWNkFMdDhYV2d1VXRtWC80a0E3?=
 =?utf-8?B?ZmhMQUU1Yktjc1FsUTNhSGh5U2Y3K2IyNFpHcjJEZzhkLy93dlZ3L1FYT05W?=
 =?utf-8?B?aFVwVzZhazlIbXAxME9BckcwVThhNHRCT3V0VEsyZGltNmR4eXAyaFc0VHBj?=
 =?utf-8?B?T3lPaUR2aFVNTDQ5UktHZnlPTUdtKzkzb0RpbmVTeHc2Z0ROQ1I4TXFsSVdX?=
 =?utf-8?B?R09uZ09rQ1FtT0ltMElGeVMvOU02WFF0TGdlbHN2eVVha01YeTBRZkdKQUU3?=
 =?utf-8?B?WnF6NXhLSno0K0JjcmVzc3BMYkJuL0xxSXJKSjFuK2M5am5La2EyQXg4Qm15?=
 =?utf-8?B?R0RmdU1LbVFwWEJBcU4vQjVvYzNvYVl6ZFUybldYM0swaStPcktxdkNaT2lp?=
 =?utf-8?B?TnNnZ2d0N3A4NmFWQ2FtRGNuc3E0UmxEczRzYjh2Z0U5WmhCcllXN3hSNDls?=
 =?utf-8?B?NGhwcml5Y1FUVjNrNWxJRzJNdWo3UEUrc2JnS3kvakY4eFlRWGlTbHhtUElZ?=
 =?utf-8?B?ZXhPdGpOb0R1L3dSUzhNUXNVYmJQdTRNZkliVEhSVnB2L29lVGZsenVNSnN1?=
 =?utf-8?B?ZzlTbUl6OGdvZVo4RHhIZUkyYzF5QTlHcGt0cUQ0Qk4wNGprK1hDYlZ1M0dO?=
 =?utf-8?B?QXRZelRyeEpUVTdubUp2a0dvenJnNnErNDFuNGlXU1FhZnQ1VDVFNEFyQk5p?=
 =?utf-8?B?czYwUDZBSjlJNklBTUE3U01KbGo4c1hicVFUb21yQ202aWFFNnhxNWtsSDhl?=
 =?utf-8?B?M1RCcGtYTWhTQ2loeGZINFh4MkZOdlVpV2hxVVVwa1I5VU5OS0t3YXN4MU9q?=
 =?utf-8?Q?6zTZ+TJkQmtZJFzw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5fbaf6-ef3b-40cc-87e6-08df29280820
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 12:46:42.4531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcOPaQqodZ+WaZwttsz5ZWbJW3fvv8QOhKVKChaJp1nGuLpCTU377s0Xtp7mBQaskz5aSQP7UDFOmTkUn/w2OgxEjAzVox65qhZ01LJ5z+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6143
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

Hi Opaniuk,

On 13-10-2026 17:44, Igor Opaniuk wrote:
> sdhci_send_command() polls the interrupt status and gives up after
> SDHCI_READ_STATUS_TIMEOUT, but it evaluates the timeout before it looks at
> the status it has just read. When a single status read takes longer than
> the timeout, the command is reported as timed out although the response
> and transfer-complete bits are already set, and the caller aborts an
> otherwise successful transfer.
>
> This happens on QEMU's SDHCI/eMMC model under TCG: a large ADMA transfer
> runs in a timer callback while holding the big QEMU lock, so U-Boot's next
> MMIO read blocks for seconds and the subsequent command appears to have
> timed out ("Timeout for status update: 00000003 00000001").
>
> Check for completion first and only then for the timeout. The check sits
> after the SDHCI_QUIRK_BROKEN_R1B handling so that, for a busy command
> without data on such a controller, the quirk keeps returning as soon as
> the DAT line is idle without reading the response, exactly as before.
>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
> Changes in v2:
> - move the completion check below the SDHCI_QUIRK_BROKEN_R1B block so
>    that the quirk keeps returning as soon as DAT is idle, without reading
>    the response, for a busy command without data (Tanmay Kathpalia)
> - add Peng Fan's Reviewed-by from v1; only the position of the check
>    changed
> - Link to v1: https://patch.msgid.link/20261011-upstream-mmc_sdhci_timeout_b4-v1-1-f33c02445924@oss.qualcomm.com

Thanks for incorporating the feedback.

Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

