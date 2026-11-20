Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FBE606A33E
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DmPbRcJU;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=VRM4EbfF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68AD360E42;
	Fri, 20 Nov 2026 10:24:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0guYHFYp-UHq; Fri, 20 Nov 2026 10:24:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5F05B60616
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795170272;
	b=G03bDfNBzuh6ZUs5vSnvLv51C4Fdz+tbb50VPEGsxFdLFf+t7kOE9kK01tJw4FAkj+OW
	 q1NyBI+ml6YHfiDmamePxiumw1UZKfFczgr5kaDYMSMEi4v2WWjpbFgBOFvX42IpyKJW4
	 G2rapSw8jKFrmm3+lbqzdePVSs3lx52zyxdUVFZPQwTlL46SEFI9VsngvO/ZdX0ndus0J
	 WkO2PHk0vfq6XYMj6z7Tm/w8rI/zSCyPdOuz/y2Ja2w75pf3GMRFZfHd/3RlWVOkYGooh
	 0Q8Zf1I+DuD/QUvhGOjQ4WPma8nhfppliPRysAy6Xft5d9r2I8aPrEjabjDoAwReaQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795170272;
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
	bh=gqSIUnAulP2q66X63XrDet4eVg/jron0AEottI0nqA4=;
	b=PVXSrIkRACe1h25GuvSHbZduIgn5pFrlYggD7cPLcRFatbR1td4hdXTCWJ1GwMXyeOEd
	 X0iOhRgsQWDInmPNn3Srbf4tekXLK+6DA0Ts4yAhX37BbGJ2wuSGqHfMerE4MIIjddsxo
	 K3cxRx01m6nZkV/nzmfX1H1UubW7iBbmZ2d4VtDjGTQcDPZuK1NU/zjzLU/QDVYCRal0o
	 sS1T/9E/wvia3ki6Z2WkTR0puslkv0xMGTR3QZ3R4VgSEYVYNmWU6i1cPt3MPeOWOYIby
	 2k1HpF2v7wsUlopAf0eVXY4/1ZQrk5JCwUHI/aHHHNtLGEQR5Y1lL5MY+EDhTTni/ig==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795170272;
	bh=gqSIUnAulP2q66X63XrDet4eVg/jron0AEottI0nqA4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DmPbRcJUayQCDReScx0sjGw3ptaDkIElFNhMTnjjqB9yK/8PwTi+74nXldL88D4zf
	 E+9TdbKAkjUNq77t4m5Na/4usg63gdQ3OzOUq1/vVDZBt7Zc+gbmExzxlIaHAmG+QL
	 O+ZqVt9GERPP43elzG//YSjMuE82wBV9FEWBiTqbzS/GkKnci92ljfeR0MPZuYZKy/
	 nkhOYR/CGncXrMUpx+pwg183Jk8EWy7LUXWr4M0tV0k05JSE0RJ6V5QvIsyrkFa0oc
	 HFr27bpbQhRBDkhf5t/He9ZrksANQu4I2HfFZVMPAD8S4QJB/fSovjAFsOTjtPsrPd
	 yYjWNvEtrPa+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F05B60616;
	Fri, 20 Nov 2026 10:24:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CDCD1C9
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 10:24:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5ED3D8136B
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 10:24:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0EPc1HccQ5td for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 10:24:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E32BF81310
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=VRM4EbfF
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E32BF81310
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 10:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqSIUnAulP2q66X63XrDet4eVg/jron0AEottI0nqA4=;
 b=VRM4EbfFHM+T/t8SOmm2v0MpyekWMRhncjsUqZzGjXBz2j3Yxym7TynFP30lPxlEiqwf8MlfAS8omcUg3/H29O4+O9zHmz7EIUcBB5rDsXiqqbqZSvzn92ccg1Ya3M/mF3M7Y+4jqAnujCwLeuqWeZIaHyAOhHp9mC2YDN0WK6M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI0PR04MB11671.eurprd04.prod.outlook.com (2603:10a6:800:302::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 10:24:23 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 10:24:23 +0000
Message-ID: <37ebed3f-9b4c-4881-861c-add50c13dcad@cherry.de>
Date: Fri, 20 Nov 2026 11:24:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] binman: support running multiple tests
To: me@samcday.com,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Cc: Tom Rini <trini@konsulko.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Yannic Moog <y.moog@phytec.de>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Javier Tia <floss@jetm.me>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>, yan wang <yan.wang@softathome.com>,
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>
References: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
 <20260610-android-binman-v3-1-710298a38fcc@samcday.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260610-android-binman-v3-1-710298a38fcc@samcday.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0031.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::20) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI0PR04MB11671:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e89c7d5-a13e-4fb1-0b5c-08df46f071ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|6133799003|22082099003|261009223027099003|3023799007|260925021311599003|260925022911599003|260925021911599003|56012099006|4143699003|261022115727099003|261102123227099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261021123027099003|261028144727099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: GTc+yfCPy+r8MyZCWp3a/Y6kGP5/Kf447Eh+6019tFWst0HzUaXb2de4hyIsvDOHMEsafzDSf+2PlDmOeK67jFWufgf6CWg3eWB5Lw/7VmLWqE5bXZWnqHt5r/2Acf+HnxJrNnmg3suW8yiw/mysUAd2OBNJQK7bnIiNWJzvfzLxmE4PI5iCqskgcpPl/JuC/brur0Z50MQzuOcCXWxm0yRxu7+DR7pSNGHfNjDu5L2B864A/21zW9CsH79iINSYtD/kvQtVwPoJS47y9JWuxT3PCocUwcHIzrXQdeVSFBUC9svfIILU8VSewAbo9x/++V8+7FoCqub3mSIqLIneE9vLD3FOv9Wgmz5YXE4Aq2cdyxJqwKt0dZjMz/ZVFDlkvDbN0dxP+PHlOMxjp/6IejjMODkNjA6L5y6kYxDKddRTEG+AJRLbkbPv48Gkx/UlBkTHzYyOrY5BhQloDSrSG/qFFMu+gEsA3QotwaZ/uUZqcH5A6uhrrefk3MNJ0t7X2jOVja7L4W2bRMwxa2Qcveu/eZmigslOu9F0/KL3NwhrHjtQm+gDERYTDzlYcJttNOx7j3yuOI4hLmA2YEUyyPfRqh0t3QOM6f8tmeJHltKvx7+37BS+6tkV1t6E3oE0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(6133799003)(22082099003)(261009223027099003)(3023799007)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006)(4143699003)(261022115727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(261028144727099003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE9ib1VZaTRHY1RDUEpwakZlVXJ0aG9ZMXJTaUdBSUZURmNHbENSeWhPbjhR?=
 =?utf-8?B?ZVNSZ01lVkRjWmpzdllVZ3A1WlJZVmNlb3RyRTF2eS96YzRBM1F4YjE5VlQz?=
 =?utf-8?B?SktoTDd5c01LZkdzSDIrL2swdTA2Qis0ZkVaVGJZd00rdUlDYmdFcDhIS21R?=
 =?utf-8?B?cDgranRWSC9rRG5XUTc1cjVncGdoQTRKU212dlhqT0VjSnMxRkc3c3B5eDlU?=
 =?utf-8?B?c2NGbktZZ3l3ZzN6V1BUOFJlVU1jTnpMTkw1UEtTVkZFbEFXK0dmL05XejJy?=
 =?utf-8?B?YmlJRzhVdXEwTG5haEgrUGJ2Z0h6cFhSR0JhWHcvOXZVckhMSFV1OUhYaUdq?=
 =?utf-8?B?ekNvSEQvWVcrWGpWL1hQYzRvemxneEtObWQ4cGQxOFIzOGROaHdxQnFiOEQv?=
 =?utf-8?B?MTN4VjVJN1RaWlJDS3JsKzFiV0RlaTBxQWNXbnZyaWJMbi94ZzBITlpIMGRX?=
 =?utf-8?B?SVBxYWNsU3RBU0pveTd2bEVWa21tVUd4OGJPczROMDhWSXI3cUwvNHFHNmdi?=
 =?utf-8?B?ak43TVZSSitCVmkwTldiaktUTHpLeEtDK1JjL2JRUGtiMDVNVkVFREJEL28r?=
 =?utf-8?B?NzQvcjZDZkx6emh6L0xPKzhoYlJSOVdrT21kR2FFVWJJN1IrN0JjMjZrdU5T?=
 =?utf-8?B?YlMrV2FER0lmTVg5MU01NFh4K0FlK0tqU0p5SVFmQXhMUXo0QTlmZE10cXhC?=
 =?utf-8?B?dEJ6OUxyb2FDbEtkbzlJbHJSbUtpZXFkZVNsSHFRSDc5YnRxQXpkRm9VUy9W?=
 =?utf-8?B?cmd5bWhhVVVVS0VmbElkdWxTK1FWais3V3FibnhITC9BOFBScUxiNGpwMzEv?=
 =?utf-8?B?ZTd0eXlKcloxQXZxRTJJdmdqOEZiOVkrdHBqZm9Ua1kzN042OThLU284SjNV?=
 =?utf-8?B?OHNyTCttWTRCWk5WMEE4RDNJeDMrOFdvOFlnNUFpOEhjSlIwcUxzbVZIYnBZ?=
 =?utf-8?B?OTdRSlZsdHNUbklGYXd1ZEJxeWdOYWF2alVGUFNYbjBJTUlGKzdTUm0rK0VL?=
 =?utf-8?B?NXhKRTNJNFlvems3d053OURKUlFad1ZvYkZTTFd4eTVaajc3Y2tqa2tjU2FZ?=
 =?utf-8?B?UlNEV21zdmNKUjBkTjFqK2JibzNVWUhjekdkVm03TmJtcHA1MkwvSnZHaUhD?=
 =?utf-8?B?MEFzUGhDOWNBaFFiMXhMeHhKd2ltNFg1RFdHSWVvUUpWWDhoMXdNQjhaaWlW?=
 =?utf-8?B?MkpxTG5NSXNpQVlsNEZIdGhzYnpiMlY0Mzg0MGRhNUNxN2hNYWlKbjdIUXA2?=
 =?utf-8?B?aUpwNk1QTVgxb29aTGFIck44UXdtYUxPSWh5RC9JNjltajJHaUlyRS9BaXl4?=
 =?utf-8?B?SG1NUGgvWjdZV3Z1T3l5Wkg3b2xUYzdzZXRyZ3ZRVHlOcVhYcVhEekk3a2d2?=
 =?utf-8?B?TVFFR2QzdW1uejVMMXVtTEt4aXF3YnpJVWRkaXh1aU9rMHhsbWFYQUpJeitn?=
 =?utf-8?B?SEFibElPQTlnWWltZDk1cEsxTENDcURqbTgvWk5ZbkNpQSt4VytmUzF5bUp0?=
 =?utf-8?B?cEs4d25pbG1MVkhnL05xSmZuWGw2K0dWM3lHQ05QUWpISXNBakRJSVlzenJR?=
 =?utf-8?B?cTVLalV3azdoejVIa1NRYVk1YWwzVG1ReTNsOHAwUjZHelVSUGFkVFJ6L2k3?=
 =?utf-8?B?M2JjdEI3SlhnRm9yekh1eHNDaDJkTGZFemhJck1hOTNuVjZtQzNpTGI0S0E2?=
 =?utf-8?B?U1VRZExaRUkwUml3OEJubXp6clc1TFYxc1V1VEU4SmFKUmNmdnFoSDNkQ0F6?=
 =?utf-8?B?dDZ1djRwMldhUXRJZ0JCc3ZNUC9HNzVwNk8vMGg3OGZCd0UzTERLRTZhaXJ5?=
 =?utf-8?B?K1BEYi9mcjh4cXM0UFZxSjVoRStobnNpckk1dXpITExlQnBLYXpnbTZ3YmVi?=
 =?utf-8?B?clV5TEEyc00wc1lWd2JBU3JVclFFczhWdVZMTUIrT0FWRkxURmtLWC9UOVpk?=
 =?utf-8?B?cHd6djBXZmpidmxmaEVIWmxFRXhRKzNtN2ZEWHU4QW5hazNwWmQ4RlhHZGxj?=
 =?utf-8?B?V0g2M3dpdllkODJjM3ZRYWNiQ1NjSzJrM2lIS2VXbTRVL2hWMk5XWFlvRXB5?=
 =?utf-8?B?UkFrVU5CdUpxbDJhRTRZNTJSNmJUcHUrNnJxSndjUEovSy85bVRhM0RGeUc3?=
 =?utf-8?B?NjdQeUtyTDNNenZZYzFJYlFmMWZUdUlxNGNEUGt1KzhEV0ZWQ1FHTGhFbXpk?=
 =?utf-8?B?YnVpNmN3NG0xLzRkaDluZGlnTkpsZy9sbU55NVExT2sxWTJqZ08zVTNDY0Rh?=
 =?utf-8?B?V1ZHMEhJOXAyYUhjODI2aFpRQ1g2SmZUZmFqM2NjZndOUGN0R2ZEbG5NRXRp?=
 =?utf-8?B?akF0VTFGcTRwRVNxTHBjREs3cThZNWgyaEhCYUEzZGw1T3p3L3JTUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e89c7d5-a13e-4fb1-0b5c-08df46f071ed
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 10:24:22.8854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBEKeWu1yag3PzClGrxRU7v2lVW2jYIQ8bxmZPaD7zgado1P9Sx8/78i1MLIYS/HVFVehbU5boF1WHkxVfvgs9/HYtxIWcKpv95DDhOxou4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11671
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Sam,

On 6/10/26 3:27 AM, Sam Day via B4 Relay wrote:
> From: Sam Day <me@samcday.com>
> 
> The helptext for `binman test` suggests that this was already supported,
> but it wasn't properly wired up.

Thank you! I was bothered by it too many times but didn't bother looking 
into it too much.

We do need your Signed-off-by here though, see 
https://docs.u-boot-project.org/en/latest/develop/process.html#review-process-git-tags

> ---
>   tools/binman/main.py            |  8 ++++----
>   tools/u_boot_pylib/test_util.py | 23 ++++++++++++++++-------
>   2 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/binman/main.py b/tools/binman/main.py
> index a0c775fd629..5473789361d 100755
> --- a/tools/binman/main.py
> +++ b/tools/binman/main.py
> @@ -58,8 +58,8 @@ def RunTests(debug, verbosity, processes, test_preserve_dirs, args, toolpath):
>               the output directory for this test. Both directories are displayed
>               on the command line.
>           processes: Number of processes to use to run tests (None=same as #CPUs)
> -        args: List of positional args provided to binman. This can hold a test
> -            name to execute (as in 'binman test testSections', for example)
> +        args: List of positional args provided to binman. This can hold test
> +            names to execute (as in 'binman test testSections', for example)

issue: this is (already currently) misleading documentation

It's passed as is to run_test_suites() as test_name argument, so it's 
really only (a list of) tests we can pass. Can you please have a 
separate commit which updates this to reflect the actual intended usage 
of that parameter? Then base your other patches on top.

>           toolpath: List of paths to use for tools
>       """
>       from binman import bintool_test
> @@ -72,13 +72,13 @@ def RunTests(debug, verbosity, processes, test_preserve_dirs, args, toolpath):
>       from binman import image_test
>       import doctest
>   
> -    test_name = args and args[0] or None
> +    test_names = args or None
>   
>       # Run the entry tests first ,since these need to be the first to import the
>       # 'entry' module.
>       result = test_util.run_test_suites(
>           'binman', debug, verbosity, False, test_preserve_dirs, processes,
> -        test_name, toolpath,
> +        test_names, toolpath,
>           [bintool_test.TestBintool, entry_test.TestEntry, ftest.TestFunctional,
>            fdt_test.TestFdt, elf_test.TestElf, image_test.TestImage,
>            cbfs_util_test.TestCbfs, fip_util_test.TestFip])
> diff --git a/tools/u_boot_pylib/test_util.py b/tools/u_boot_pylib/test_util.py
> index 364596d7a0c..ff275a7b7c0 100644
> --- a/tools/u_boot_pylib/test_util.py
> +++ b/tools/u_boot_pylib/test_util.py
> @@ -157,7 +157,7 @@ def run_test_suites(toolname, debug, verbosity, no_capture, test_preserve_dirs,
>               the output directory for this test. Both directories are displayed
>               on the command line.
>           processes: Number of processes to use to run tests (None=same as #CPUs)
> -        test_name: Name of test to run, or None for all
> +        test_name: Name of test, or list of test names, to run; None for all

question: what happens if we have an empty list?

I'm assuming we want the same as if we were to pass None?

>           toolpath: List of paths to use for tools
>           class_and_module_list: List of test classes (type class) and module
>              names (type str) to run
> @@ -182,12 +182,19 @@ def run_test_suites(toolname, debug, verbosity, no_capture, test_preserve_dirs,
>           resultclass=FullTextTestResult,
>       )
>   
> -    if use_concurrent and processes != 1 and not test_name:
> +    if isinstance(test_name, str):
> +        test_names = [test_name]
> +    else:
> +        test_names = list(test_name or [])

issue: no magic stuff based on the type of the argument

Please only support a list of test names. We need to update all callers 
of run_test_suites but then you'll quickly realize they all share the 
same pattern as binman, the caller expects multiple test names, but only 
passes the first one.

Cheers,
Quentin
