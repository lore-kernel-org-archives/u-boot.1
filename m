Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C61560A3823
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nih7agbA;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=XyMNd0Kc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C620608FF;
	Tue, 10 Nov 2026 14:41:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kpai71xCyCTp; Tue, 10 Nov 2026 14:41:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E1C89608DD
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794321717;
	b=nfemjqAD26Kqwl4sQ6MPq18uFZI6vVQJfsZNuIibKlC+l1gAvncHU4faiyTsdyn52oQ7
	 k4lwzAxLp7zCrTBbndyfNMSBwDQtEitoGppA+L3tbuoQv3LyDx2Eopa/QWjSyiRBk9vWI
	 f/Ht92Rc0qwLXRXP/MYa2/f2VpRMBZ3UTmqCwJjUc1WHIEQgr3ilRbYpfA5KppDh8UsXM
	 ck8hcl5svsNWhXoHk7+ioxxFlO4h6nlUIzfHmDmbi7jbR0qW8UwvT4GIUpPZHTjnRLQn7
	 +/m6ne7nS4Ge3TgodtPJGdGJbEr480yrMj4xb6Eg111HFMp0qpOnbPf9IwBLfBUefiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794321717;
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
	bh=1aaCPUiFmQ3G58EH5F9yarGFrLNKd0F++vOsN9XC31I=;
	b=M0NH6LtXMY99bHjJFCjlgTI8luwQalq2joG7wfDnePcpUuyleUViwFtmFo7GKWuivqWV
	 9MTW7nA0KIU9GAt94F2Rk/2gVNS0ECnm7jZ6g0tNkS6O+gD6c8XqLIXtnEh0O8yxAQXt6
	 7b4tmotnQcawvGprBuu4G+ZTNsz7Mtbw7U7ur1THO26Kri2x7R3SdQBLP8Skro1zdc0uP
	 AxP9aDkAAIcXnycIcilOjWm2/hSrXpC0MFxaP/1DpHbxTklXiqg2Q8RsmNRxnP0ditdcH
	 gFaCST5v6QFjueSytk5x0K1FExbFLq3o47O6hqVLM1tk0kKTSWvZ6fN+OYu4CtFR1TQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794321717;
	bh=1aaCPUiFmQ3G58EH5F9yarGFrLNKd0F++vOsN9XC31I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nih7agbAuxOsPr9/dVTMmebrlJu24Y6T+qLa0FOxdFJd+T6hqsJYKtAqwYOytllXL
	 8E9J6QkgZzrlKh9yLyg96xi87jpR0EpZ/GPrw39eXLt52/MF/xVd+w/P7S4HPYxcoE
	 pFchrl7C1rCt4QJnVA4CdBfklDTQqF4KMfdvP/9x81RhP2dB2xcMxMe7W+aHK8+V0D
	 BqU4VVCkVIS2zlFkytY+X6TgJf4lMB7Q0gveRTpE2X8+IPwTP98YAlrB4m6kxEpCCi
	 xagMjkJ3S22liYC4OhD3GmVFyL/BL+YMOAEx4Zqg4NT4V7Ys98te1YSOpamOft2Ww2
	 5P7imOF+AAF3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1C89608DD;
	Tue, 10 Nov 2026 14:41:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E6E8E1A6
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:41:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D821D81290
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:41:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bh2xgnU211kl for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 14:41:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 93F1880F92
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=XyMNd0Kc
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 93F1880F92
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aaCPUiFmQ3G58EH5F9yarGFrLNKd0F++vOsN9XC31I=;
 b=XyMNd0Kc42ygF1p0VQhMp8ud3tsM19KBrrWG4WEJRPcKe8AEKI2YlFa1lUOtwPPhxFaWnMtNME9Se0SutVtUmoVB67oBYQT7j2OK9ScgnlModorIcosbwW4FedzE8ARdv3tYwEDcRGfWMfR8sDzQKm23Fmb2TwJn35vpvGFoBWY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by BR0PR04MB432630.eurprd04.prod.outlook.com (2603:10a6:2c8:5e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 14:41:48 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 14:41:48 +0000
Message-ID: <6f2681a2-1488-42ef-9909-169b47ba311d@cherry.de>
Date: Tue, 10 Nov 2026 15:41:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] binman: bintool: Do not add empty argument
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 u-boot@lists.u-boot-project.org, Kory Maincent <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini
 <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>, Francesco Valla <francesco@valla.it>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
 <20261110-qcheck_fix-v2-7-1c76e0b68f29@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261110-qcheck_fix-v2-7-1c76e0b68f29@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0115.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::44) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|BR0PR04MB432630:EE_
X-MS-Office365-Filtering-Correlation-Id: 0623d659-4f46-417a-ad25-08df3f38bfca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|22082099003|18002099003|6133799003|3023799007|5023799004|4143699003|11063799006|56012099006|10067099003|261028144727099003|261021121427099003|261102123227099003|261022105027099003|261026140227099003|261022075727099003|261026121527099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: yovtz23f2rY/fh1Z3CKYc0InlQ91wJmMUSqJg/3w6z2b0PSUavGLacO7JCivFgXYKZssymcjEdjfyZsUGyZvz7j5wfrvEvX4xFXp01NuNrG/OgMg0ebHHQJnGC2SVXxi752eOEWROiifmhmwsf7SQWglMzHucGCd1npHpiZltzd4qInTShp47HSj3IqlAjGQ0Si88iYLxqnUcaZ+fgrdOsD3aE6mT0bSNhO9uACnUpcpZGIPia6LqjtpjVDnixRKiAuMF7mHF8Sh11Jd3SGWYwiMwAESSjPbO9IHVo8Tx4vNNLydgAu8oXc8/yPTkqu8vNBj0H09IZdd+3iy3s2GXUqpRdrcR8RfXpKBRmTDFVUTsrqU3iMlRcXqwXWuRKKsoBEWuhxY46Ft1S7UgJ+V2nKtf7FoFVyoSmL1SIVVVIMx9dyQpVdGhpFVxbaw7G7q9xCYhcZJIPH96RW5ZfLxVqQt4iFv5Dp8ErPv3YpL+QSZHopegdPHOY4GFcL8zWwFNZVUq/+SFwVQI81MSwccRtSYBWSc1Eej9CM8RacXpZXUjjfirns/ycEmeea/6SyiCMKpd5PnQxVObaQKI26Jml87f9aEk+VDdpipnu06wfVasxjKZLbSNOy+NB/72nNhNlyRysrUt6vret20Hhp1+mBZ+NHf0nhInxEd0HfnCvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(6133799003)(3023799007)(5023799004)(4143699003)(11063799006)(56012099006)(10067099003)(261028144727099003)(261021121427099003)(261102123227099003)(261022105027099003)(261026140227099003)(261022075727099003)(261026121527099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NitaZjU1N3F2Uk5QbVVLcGF0eEVzYUZaNjVEaTdjdkFDck0wdlNsS1pORUF1?=
 =?utf-8?B?MTZBVDJvZ283czRlbUNYQ2hULzRNMWt6dkM1SGc0dDFRWmZZUndSQWtUZlY3?=
 =?utf-8?B?SS9OLzl2YWtSamZQQkt0OGV5SWZibXIrZHMyNXhINnhhVU5FUFlmN1RZcyty?=
 =?utf-8?B?bVpxYno1aGZuU2JOeUZ6K01IMHZiWE1USXJVY1RYNU9UNnFFUWpidC95V1Bo?=
 =?utf-8?B?TmI5MlRldjJPNjlycHQxR3EzcTZZUkk1VVhXdGF0cW1BUThobzRiNmNmRHBH?=
 =?utf-8?B?OGZaSm5ETklmdXBKQllpNTVBVXNaUlVKRnFuNTJ5Yk4rZUVoUmJlT3BmNzZJ?=
 =?utf-8?B?Z0hGaXpGQmRsa0o0NDM1TnN3d1k5SjRBS3RIaHdkemdIU1pkQ0VPU243RmJz?=
 =?utf-8?B?eU9YVEtaOS9JdldzZ01rSjBIWXFJeVd6TXNDMUVWTjZ1cTRZS1FDODhYd1JK?=
 =?utf-8?B?ajY5dzJrZFhGY3BMc2xZTUZGbVRBVEJBVzdvaXFvVThQaSt5aGpGb1ZLak5z?=
 =?utf-8?B?ZzFZVzZqQjMxayttaXlwZy8zdktKZTdVbitCdDVlaEZzTk9QUi9rQnQwUVVU?=
 =?utf-8?B?cGxEaTlyaWxjblRGcHdOZW9NZjd1UWJ5dXpVOWFmSFM4YTdVVmpKcHpEQXov?=
 =?utf-8?B?djh2MDJmcllpbDIyekxkMUgyK0JsYnljaDR4OVRnb01leXk4OWlUTlR1MGo5?=
 =?utf-8?B?ajNzUkRoa1MwaGJBamF5U3JJUmJCVkIyRVZ4cHk2UzdTMGJFSUJ2a1VqRTBT?=
 =?utf-8?B?TktnVk9XMU55U2hWU29mQ1Z4cmtLa2ZqZXBUVW0wZVVqU09Kc1JKclZjekxH?=
 =?utf-8?B?cVFyVUk3aXVMOXhteFhCQ1k3RnlBS1RkdHhEOUdKalJwRytkenQzSVM5QXNx?=
 =?utf-8?B?ZXAyYTBESE9wUUhaY2RqNjk5SEIxdDQ0cldxaVMxdjVaR295R2FQRDRHV28r?=
 =?utf-8?B?eTNuWUhyNlRZMjhGeCs0NnlLaEowT3lGb3dycnNRQkpXLzBic1RqRWR1K215?=
 =?utf-8?B?QjQ5bmNHcnhsZHh4Ykthd2JNeklJMjV3eGt6MERycENRaG82Qyt1dGNSUlhL?=
 =?utf-8?B?dFZkb1lCWllMRnV4aXQ5UDRkb200RWdVdW5DbUxYVkQrU1NraitMd2laNWdi?=
 =?utf-8?B?M0g5RDE2N0orOU5TMC9Zd0hnSG9YN1ZyYXBVL1p5ZnFYeERTRytqb0huNWl4?=
 =?utf-8?B?WkxDcEwvVXZXOGlTQmlKalFpVlB4MFF3emR0REFDa28xS0xQZDErU2FzamY0?=
 =?utf-8?B?RkwycXdHM3NCWGM2QkR6Z0g5bTV2VUgzQU16d2dsVDkyZHJLdlN0YWd3KzN5?=
 =?utf-8?B?YVFDR2RsemRLU1R6REY4SzVGcnY1dFp5RFVHcE8vMjVUb2dvVURVWml5ZXBG?=
 =?utf-8?B?aHlBTjAzMW9oYlRYcnVUc284UVYyaXlKYTkya09VdWt2VXR2UFk4ZWIrOU5E?=
 =?utf-8?B?c2pFbXRzT1RidFZTYjFGeEFBSWxnMkdFb1JQZ0RnVndQYnZrdXp3amV3Y2x0?=
 =?utf-8?B?Q1Vpb3N0b1pNbFg5VEZ3aXJPL1ZWUmdyUmkvN3dNY0UySEdyUW1uTEEyeTN3?=
 =?utf-8?B?RHpBc0ROeUhXS0hkNHJxZWpRSm43SWlYeHVyL1V6SUtuMC9kYmJ5cDZBRzY3?=
 =?utf-8?B?aWhQZmNxNzdEZ1RNVG1wL2NGY1Z1cGh2VldLMzFqdjZSbWl5OHdYWTBvV1o2?=
 =?utf-8?B?N245bXN0cnR5Nk9JTXdjcVZGbDJ3SjE1aVZ5bEpvTDJpOGVOZ09adWlPYmZQ?=
 =?utf-8?B?L2pZUTVrNC95NExPa2NWdllVbnJadTF3TzE4Z2ZRN3NNalUxaG94RjEyMWVL?=
 =?utf-8?B?UDc0akNqYUFIUG5nQVRZcUtSZFp5ZHRrWHp6bVR2Nyt2VVN6VDhESHpIUmFa?=
 =?utf-8?B?UDQ0YUVneWtkKytGZUJrNzg0aXNicTVSTjNLRkJvTFYzMkIwRG9GaWRsSjU2?=
 =?utf-8?B?ZURKS0d4Qm82ODV4Q0h5c1pTTk9oMXVseXZFdGFkd080TlMxNGtBS1YyTm5y?=
 =?utf-8?B?Z2JnK0JuaDJMOE9odG5kQ3JVbVNFenMrSVZEMXVCaXMrMG1PTXplMFBna0tY?=
 =?utf-8?B?NHJGZTFiR2ZPTzd6SkJiSTZkdVMwTGlZUUZUd2ZBdkdUSjJ0d083UE1uNUdV?=
 =?utf-8?B?RWZ2V2VobzRWcUpScUpqZTNaaGlpVXJsU3R1bml6UEYycGN1bytBK3VYbGdn?=
 =?utf-8?B?bVhwc2xxUzdPWFFNUld1bE01U1RNbGloUVFHcXNhRm81QnErb3JWWWJCSU1J?=
 =?utf-8?B?dEJ5RHhEZ1d5Y295aGpTNmZmQWwySmJJaFhNN2M3Y0VXY01BSDVkTkd6Um83?=
 =?utf-8?B?WnhhbVRzM3g3VUQ1MEUvL0ZxMVUzWWVEcnVHRzM2K3d3ZlhLcnBWdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0623d659-4f46-417a-ad25-08df3f38bfca
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:41:47.9733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Du8b75gmpkPHlbVd4xboeB7I+TfmHDiEgAMy6OPuzihi8YkjooY5a47z5Zq6Vgd2kmgw7mpFZZMN1Ly6pm8kvTaQjghYGZM2SfE8oYG2Y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB432630
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,

On 11/10/26 1:24 PM, Andrew Goodbody wrote:
> If lzma_alone is invoked with an empty argument it will emit a message
> to stderr. When 'combined' is used to examine the output of this command
> the content is not deterministic in that stdout and stderr may appear
> out of order on occasions. To prevent this situation do not add an
> argument list to the command when it is empty. In this situation no
> error message is emitted only the usage and this is always sent to only
> stdout or only to stderr depending on the version of lzma_alone.
> 

Then this patch should be before patch 2 otherwise we use broken code.

> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   tools/binman/bintool.py | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
> index 4cf8d5b165b..15e2df2fd80 100644
> --- a/tools/binman/bintool.py
> +++ b/tools/binman/bintool.py
> @@ -290,7 +290,10 @@ class Bintool:
>           if self.name in self.missing_list:
>               return None
>           name = os.path.expanduser(self.name)  # Expand paths containing ~
> -        all_args = (name,) + args
> +        if args[0] == '':

question: is this really correct?

What if we really want an empty argument?

Say

echo '' 'test'

for a simple example, or even

echo ''

which will print a newline.

I'm wondering if you cannot simply remove the '' argument in the caller 
of run_cmd_result?

That is:

out = self.run_cmd_result(raise_on_error=False).combined.strip()

in tools/binman/btool/lzma_alone.py?

Cheers,
Quentin
