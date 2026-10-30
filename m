Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286D3606A326
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RnF2rLuy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3B1181663;
	Fri, 30 Oct 2026 16:08:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cHYrLVHi8vvw; Fri, 30 Oct 2026 16:08:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3A73681674
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793376525;
	b=aWBRDwHblyl2eCw3BWILeVikof25/VYm/d6HhgILu4Kn4MCepqccwEJtxiw7o3g2f0T0
	 MjqF1e4/KPF0O8Jd2INcxP912WxPSJ1p1N+B23GRkuPzzB0UGirEiZI9X3hpTR/SFBUOy
	 XPjQ0WDYm86Ti+GA5JeTZkiEl5MlvmZdS7IKXf4r0XcDQyE4C3VwMNSdiGuxxidvIW2MX
	 8bhyvQjN4O9ZwdOScacm9o1dMuGgSN5lwLu7wVDiGc6BIpIvXPxcPXOBn2ulEcJPbGfbM
	 XQFt6/CPwG0o5tGaUeso+QDAYcUo10hqW3j/JLIT1WVJAWNOk1CHNERWX521hfg6pHg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793376525;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Message-ID:Date:User-Agent:Cc:Subject:To:References:
	 Content-Language:From:Organization:In-Reply-To:Content-Type:
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
	bh=fOv31sjVqpmYa53862069hZvoKW6lq32LoPJHxT+VoY=;
	b=QEAmQUDk0At5UblyCYLn9/RADUAT4MzbX22kCjc73Hs6wYmEojVa/JDatCVAuQ2pBtvk
	 Sp0+2r/gwQS84QqiZ9EWr2GUAYlCnx7U5pMJF7V7/911of2HkGB9EPn8ESRqBXu/Zpc7N
	 ZoE3MkyTvS6gPoe/7xvV1BKe3GtRqZgn+qlVPPgt58J2OApMCIRITrfI2zfjxvExWx8xN
	 8swKLgJ7IEzSXZxMZw9YrnwdW0icNh5ECWZh6UTjPCOJuc7rW5RQavomqG+p0qjBZu8W8
	 xvXFA5Jw+ZMFtGh3oFhnTQ+DDf/+OKoUIZFyPm1G/UfhJ9LtbJlLxq9w6jve/9pkuFw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=none header.from=linumiz.com;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793376525;
	bh=fOv31sjVqpmYa53862069hZvoKW6lq32LoPJHxT+VoY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RnF2rLuyRP7umYiIhW3duBwuGYOO7UrPMldok9QQflKm8RKnSFo+3qGQ0e96CXO/w
	 MKL2fs1nSZzdtejPLjD6Mb7EXiAWHTjJgvoNe8CdNcfTSxhRLfpBFUX8ZKhaoXAvOh
	 z/nJ2kzI8GTmgnzkIcYQQQSVx9gk3pGVXXsPmy051avTFczEtTpqRdSQrCHbsOp1I+
	 P2KjLrpqAuhr/Qq95Msu5bqUYrIFhIrpRE2GZxZJM0xbbMwdzK3GDNBZOVpDkKGtN8
	 MAMdj/PBjhKBAfbQSlgRHwqFrFjc8Qw6nHcY3H51ktisuYdhFpfW/aD7Y2Gk6gppUJ
	 sPaVgRIEoi8WQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A73681674;
	Fri, 30 Oct 2026 16:08:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BCE5D38
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:08:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 512FB81656
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:08:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ss1_Y3Z6sQla for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 16:08:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8E2E6815D5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c405::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793376523;
 b=At4/tjNSg7fV7n5h5kP4zvi1yvJvSlqJ0Kt6/JBI8p+Bf2ZRscF+Deo7WK2MCd8B0ddj
 U7tEnNmrbwXA7i2WPlqP1M9ek4x0JGGQvwRcbgBaEoeE4NMCaJFaWoCyUAzmZ8VYd+trH
 tBxBb2YFZgjpOuttemB3ZdvINYpnaWcuMzB4D+0fzH+RHXIBzykm+1mEeXEmQ28YcVFEf
 +8O4SM+vzq7oKEYqCnnYNHDE9a6f/r5LbokoM2af+Z2DNbDL7ymWtQY1aIriAoK/XmbBE
 u5lIuvRewRCF5Qoo7yegLk6V4jJUvJBl6CqxrRuoK74Iv3Nf6vYPsccMmuvT9k/LAuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793376523;
 h=Received-SPF:Received:Received:Message-ID:Date:User-Agent:Cc:Subject:
 To:References:Content-Language:From:Organization:In-Reply-To:
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
 bh=fOv31sjVqpmYa53862069hZvoKW6lq32LoPJHxT+VoY=;
 b=jsR94EqA9ku+vc+rrtSOFmJaB1k8WdYZgiqZYjBpmq2P9gJR80Wgn0i8sjR5aLR7iCEf
 lHDfeQi5Zeu4XXyLkeE2N3WZKFaoDLY5oSSNLsXHVwvBXqgNlNxKI9EajC07XHdFK3Vf5
 blWijqgVTP4Viu7DziyWXNNiBHLn2RzEQwiyJ9YyMaI0d6jVHomTPu91/v3tUG0X4VqEf
 qKkhEG5iIHnqsln+58TpXU8c0/MK3Rdw5UyuFQov9xPB9p6M9QbVcwn4Yww7PHH8/ZgqO
 KZXlAKLP38FYrSrtJf0lg8aaZkBApv2oBCpk156yfHMKtPgkTyhzbzVSikWSEJOFl4A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=none header.from=linumiz.com;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c405::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c405::7;
 helo=tydpr03cu002.outbound.protection.outlook.com;
 envelope-from=parthiban@linumiz.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=linumiz.com
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E2E6815D5
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:08:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7zYsbe5n+XPqhHzHFhku8drvc13C+7TQUGDDK7n8Qn7NDFZhzjZr/iNV8MksEFIDezvsFemTfjxZtHndOv+wZM34PAIDx1sC/zgQaCg82ZQhXZIFXopUnq/hNhH4DCfQ+ET9qXuvttz+rlaPV9heTHhVF8Gh5e+sTVjO4xA2CczXc/RXg8rEz4ARPlwfZCst5iehDVV315djFTfMWSb6BCLd7Z3D7PkbepfBbtr8X4jvQKRIcIxFNsEoUornfF+24hVzc3ggxl1hDWmqSUhmJuZLVA1yLBFKjCVALc7A6BGUUoOJ0RSQ6T0JJEsTSchAhZvSWkkIxoUPj71fPnPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOv31sjVqpmYa53862069hZvoKW6lq32LoPJHxT+VoY=;
 b=wrHDDwoNICF/vSyXc05WPuhvDs1jtUPdgjqUsryUFbCaapfZ5cobXY2WaJylJmPOaqMXp/Y8dd/jN8p+J5Ku872lKPVuDpohRJxMFq88aVbwADkijJPCFML4C/YDsI//aBXJuefl0+YKd8yN/ya+FgLY0GYGrQBxFV4qDtBnBGBZt3XxV6gSiMJ9HCEMmMVZuC3DBwAIP5bzqI22cn9AG9ukY5etnpthgPS5eek9l6APSB9gwgk171H5RweuQDlfJ8384JNw3tnHifXtrdNZLV2Wn6stbrRGOOeAoDBhKhb/rR9QakCKIqdhnuD+Pn4g7Uf4qUMc9HG7X9q1BZfEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by TYZPR06MB6894.apcprd06.prod.outlook.com (2603:1096:405:20::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.4; Fri, 30 Oct
 2026 16:08:35 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%4]) with mapi id 15.21.0592.003; Fri, 30 Oct 2026
 16:08:35 +0000
Message-ID: <8033d7f4-86df-411a-be71-9be936675f69@linumiz.com>
Date: Fri, 30 Oct 2026 17:08:32 +0100
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, linux-sunxi@lists.linux.dev,
 Paul Kocialkowski <paulk@sys-base.io>,
 Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: Re: [PATCH] sunxi: a133: adjust TF-A load address
To: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.u-boot-project.org
References: <20261029233720.8411-1-andre.przywara@arm.com>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <20261029233720.8411-1-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0120.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::6) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|TYZPR06MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c142c7d-f454-4d9d-3863-08df36a00ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|261009223027099003|261026140227099003|261026121527099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: EYYOOQeSoeKdTmO73eMLvHD82X0/d25ssbTBaa0ali866ovbfYsDeGBY/COecmX14BADvF1iJW6qZQcNB1zgRM4x40rFI5AOgl3oDbyPwK3zwaWCdQKmnR8T1sZePfIG2WANfIy5lfYGW/WDDBzKYzOhY6DpkFcbQePRm3OZJ+hhkiYgbll+TtyLp0Y19GwuhcgjdbURdyAwimb17nlnwG3kCXFoxqT6HXl8k17uzh+MHGqk09ddLJaGa7UkPARjTDFj4ZcEkIXWQMXToiBtfmukrtrh07Rm8bT8lAGD5o1RUozM4HVXc1KZPuHytLGVCxeylKVK5jjdYQeN3UXVcNSHisoRMOlkGPoJi7UmNal3bx5AvmxwRYgHPNdJvS8wXbeFPYo2Rx8GkqIc/KJ2CpLvUusW22qc+muVnEBi0QPhx6O7kIgmBCm7c9hupC4eCu1L0+nmN8IahfpgcfqiITcgOn+q0m3jQim0ZsbbhsnSpEUouvRlhUl1W0pLWk7RM5RPlQ3qfwFYJrh6002DysEEtqsNfznbyWk82/qr4Prhu6h/2of2rkcLQsBhpwB2acGRO6Fvlwi1yuQqivcTG3YrVqcT7e4wAejyINwqlhd1kd2ShKXR0dAO+fohN2hgi7x90MTiz7PVmqUCKFS30SlJvTYa5BMBXRgY07rgD8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnRNVXBjOHUyTFRGUUowQkUwQWZTdkw2dUNDR2NhYVRFT29vMVZRQmgzRVJu?=
 =?utf-8?B?L0lnSGhEN3VIbm1NYksyUnFKUnBGMCs1VDluSzAyVU85N1lCdXNlRHhyMHg5?=
 =?utf-8?B?YTNvQ3VwU0hNeXdyMzFsK3RNdmY5WEs2SVpoc3I5STF2QVZiWEorMGdjZFpD?=
 =?utf-8?B?TEtYM2FoUUVHZDBVTnpHQjNiMzlIYjRvOHRBL2l3RkwwUUg4MVh4M1RkaytG?=
 =?utf-8?B?VkhIS0FGNnUwVjFtUU1qVk84eUkvTGRlR0djNjh4Yy8xczVGMEFLT0xqdllK?=
 =?utf-8?B?ajcxV2Z3Smk3SHMveVRVODVXZzVNdS9aOWlScWJoTytQaHRnT2swczhsM0p1?=
 =?utf-8?B?TExGYVUwZ044SW5OUkFSN0Fhem1kY0h0WElsTWtSUjV6TkZackprSUNqRVJs?=
 =?utf-8?B?MkZtVk15WTVDZE9GMFN0K1UxTkNWTFJIMHdYeXV6bGdpeHFIOEg1c29Weld6?=
 =?utf-8?B?bEM4TlBPWmpnaWxWVlV5ZnBhdEdFSHBrMDh5c2puaEJvNVZ2Wkp0dGJ1aFg1?=
 =?utf-8?B?VysvWXJVU3hkMjBlSWdZYWcyT2JwRDB5S2h4TDBXeUVvMy9RbmxBS0YyMW1t?=
 =?utf-8?B?RHhJMFpzUFJZUENTc0JFQWltc3JGZjU0NUZGZllCelJDelJCVEE0aVdhTmZI?=
 =?utf-8?B?T25md1V0a3d2R0JyQStGZWtjeUJKTzZBVm96MnQwY3d0Zy9IdERXNWFOc1Fk?=
 =?utf-8?B?NW9wRUEyTFRDQ0NLODVEaFFwNkNFQ0F5NDNwSWtPUjZESXgzaWtyZlNaQzVT?=
 =?utf-8?B?N0JyRDRZdmgxRmIxYU03dzBpTFlKMmk3SzA2SENVM3RtWnFScmFPNFpxY3pL?=
 =?utf-8?B?MmtJai9zRUZDUTNOMUdwSkU4NnRaZytQYnR6b01OSFArK2lSUVNPSTNBcDFF?=
 =?utf-8?B?em1MeUhyL04zQVdhNEpENEdoaFUvQTd0UHVYakZMM1llOG5ycFdOSEpaUzFL?=
 =?utf-8?B?dnVUNmJ4dGdJSWhFUlNmZ2lKMWZmZWg5VzBnejJlUk40cWlMcllEcUdBWUsy?=
 =?utf-8?B?QWM5bzEreU13QkpHc28zcWh6ODVUenI1Sk1BMXNBUVhoMmVsL2ZxbjMrK1Jp?=
 =?utf-8?B?UjNOamlTa01JMUYxajRtcnY0UG0vSEY3NmM3aTZIMHJTSVZseGNIa1BWMWtt?=
 =?utf-8?B?Y05hTTg4L0JOcHIxWlhWMmhZQzBQRXplb2VNVk13bE5Db3pSYmt5Mkp2RDdn?=
 =?utf-8?B?WGlrNUJCYVRwb3FJSm1FbjZPSERVdWxIKzhtN21Mb0FFa1pZVzVNUTVrOGpn?=
 =?utf-8?B?Sk8vK3NBVkhnamxIQ0h4aEs1aTBRWGczb2ZNcmpDVHlTa3hBNzlWYWZ3NUpK?=
 =?utf-8?B?dmdKeXZ3RFRTZmdlZWdQYWRoUTY2SjlXTktWY3hqcXhFbU9NYnFlbHI1dEZZ?=
 =?utf-8?B?UjhLeUs0NTU1bkZmZ0tLVVZUa20zbFlORERnNGhpbkIweWF2M2g2eFlWL2xQ?=
 =?utf-8?B?WnNFbVF0c0E5amF5c0FoTTdxNXFLQkM0cXB3Z0p0cG9wZDlkbFVNOC9jRHZw?=
 =?utf-8?B?M0FFVDExUEo5bkhtS2NFYlgzK2s1ak1VQ0dKa2JBUU8vYm5xNFdweVFXdERH?=
 =?utf-8?B?OExRTng2VEl6dVZVaUREYjVkWnoxVFZDN0p6QmQ3MWVNK3gzT0piQTJ1U1Z4?=
 =?utf-8?B?SG1DS1FrUjFjYS9hcVdlWEdPNTljK09tNG1JMkozdGlIdXVkU1ppbDZrWExK?=
 =?utf-8?B?WE4xbnlBSDJ1a1Q5RWJpb3pMSzVFZy8xL2xMWlhVZlc2QWZOVTVIa3NpU1Fo?=
 =?utf-8?B?L1Y3Nm5yR3hwU2NvRFpXamx4OTVtSll2WXpzTDNzYWF4UjJkYnc0aGl4Yno2?=
 =?utf-8?B?YUYzS1VMQlJCbFNrRmpsUk0rNWozYnNkeFRZY3I5Vm1KUHZ6ekk1cmRUWWh2?=
 =?utf-8?B?Yi8xTzd3c3RiNlFhWXB2QVhWeFMxZWEwNlZnMnI0L3hDbkcwMkd0elpmcmJz?=
 =?utf-8?B?UjhLMk5RUGNiSndRbDB0ZXllRGtkUnNncXJoUHRMaTJTSnNXQTVNTXltTTFv?=
 =?utf-8?B?UCtqNGZvSUNSRFFlOGU1eUJQOGp6SnhUVUx5cHdPQ0xMN1dHWEdWS3p4Vldv?=
 =?utf-8?B?cnI0b1FHOHZvT1BhckFTOXZQQVpMQ3ZQeUtiMnJHTlp2dHM3dklha01IUC9y?=
 =?utf-8?B?dWFRZjVCU0U5ei9OTktvUmxMWXRGcWJlaGgyNHNMdVJiTU4rK0hqN0FKZElz?=
 =?utf-8?B?Z2VsNklIUjlMSXQxNGY0WTVqcVJTZTVGOUhNT2VRNDI5M25PY2o2OWVNV3I3?=
 =?utf-8?B?MHcxYWFYdkFRUUtBYVQwZCtmVkFyeWpXQS9DbWlBcnZvYVQ3aC9UeDBMSzVn?=
 =?utf-8?B?cTdobzRuY1dWUXY1NllwVU5KaHRHT3hEZHdxWVFnbzVoWEhLUklEUT09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c142c7d-f454-4d9d-3863-08df36a00ce1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 16:08:35.0360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0BeWD46GkcrNLWRcOlKogHilIT61GIzUldCh0vmm42hHFr44FOawiXYvbjopYRYtvHnhpGuXnCAtsCe9qNHRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6894
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 12:37 AM, Andre Przywara wrote:
> When development of the Allwinner A133 TF-A port started, BL31 was put
> in SRAM, like on the similar H6 SoC. Consequently we used the same SRAM
> address as the H6 in the Kconfig stanza of the A133 U-Boot port.
> 
> Later we realised that the SRAM space will become too tight, in fact it
> was already spilling over into SRAM C, which we cannot use any more at
> runtime, once the display engine is used. So the mainline TF-A port
> eventually put BL31 in DRAM, which of course requires a different load
> address.
> 
> Adjust the BL31 load address to use the same DRAM location as the (almost
> SRAM-less) H616, by just adjusting the match pattern, to not let the A133
> fall through to the SUN50I_GEN_H6 symbol.
> This allows U-Boot to use the now merged mainline TF-A port for the A133.
> 
> This is unfortunately a breaking change, but there is not much we can do
> about it, and since U-Boot packages TF-A in our booting scheme, we have
> that under control.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/mach-sunxi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index b0c5d3cd903..b7ee14c6678 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -267,7 +267,7 @@ config SUNXI_RVBAR_ALTERNATIVE
>  config SUNXI_BL31_BASE
>  	hex
>  	default 0x00044000 if MACH_SUN50I || MACH_SUN50I_H5
> -	default 0x40000000 if MACH_SUN50I_H616
> +	default 0x40000000 if MACH_SUN50I_H616 || MACH_SUN50I_A133
Thanks for the changes.

Reviewed-by: Parthiban Nallathambi <parthiban@linumiz.com>

Thanks,
Parthiban

>  	default 0x00104000 if SUN50I_GEN_H6
>  	default 0x00054000 if MACH_SUN55I_A523
>  	default 0x0

