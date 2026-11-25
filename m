Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAA0606A327
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TK7W+th9;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=Byoc025u
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAADF608AB;
	Wed, 25 Nov 2026 21:35:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 121HG8zD3YHC; Wed, 25 Nov 2026 21:35:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DC41F60740
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795642535;
	b=nkAYyJ8qBT9L/6896rFPlDr07dxCGGWi62dZ5NVC9clOx5eNdi2NPOzlICkvxPNecCB1
	 MBob1E1sfDqXbLxrKpxigudjF/meJ+aBPmHpICZdV7ojggSb866vb2OF0sUSFZ6lc09t0
	 jU6DaZsO2hheXkdceZ0s1TU0RdeO16YLACxwoVHkRMjHLzbIyAdVy/466rap9HlUF6vuC
	 cEAPVr8YzL2j/nXMZPHiWqVvO0cRCu5vZg1/sXpGP1oOcyb/dBD9F7xl4BgDPdYxAW5jt
	 chZ9BJsuTIcFkdhY7zIJ7jfwZpTpllmmGCq0g/Koc6Kp52YJe4TcHoyILW8CWakekxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795642535;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=y3jJE7kADKTjDQBPrCCUavm7I67gzOdI1r8kxHQINO0=;
	b=thZjREpGjypoCLsbxn31pAxGU5DzfZe1UQn6mvM4w0++mucQ6IzMq6As9oHDKkO2dZAZ
	 IsXdGNltW7dPlS9HhfXslNkoe9Myd91+HJntj54A53PQtt38Z5YVuNm3u/BYM/4jYPoim
	 rWDSMZDObIa0ItpjqeRSq4vLDIRnAM9ZcCEbPznNUIJDVwgZBAgYlzVl1OhWs04V46YfB
	 WJKoP4dsV/TMIs7tzf/NFY+bWY6tT2b3rXZFfZNUUcUhWj2QrP11Xcd2i7Jsl/WVNZAzT
	 jcMZzvb7aXzY2SEvjwzo/f/9dLfwdqQDDbNcQuzKiA0pul7qCAy7rSzCFbF7AJJXLbw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795642535;
	bh=y3jJE7kADKTjDQBPrCCUavm7I67gzOdI1r8kxHQINO0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TK7W+th9xPHZkjBf2NpCNkuwP3Q3AEKLQNIZmdPZXVRxtXtrZBn38/DSc87Qpzem1
	 3oWM+NehYHms5qRfxryNbhs3/0inBOZLsgUGYVwR9qYU3cRcRUH/FjKdwx8mOfoVXW
	 9yDQcKABYgN3NQ+/nQpBRvkW9cNykoeUi+P5OFtc7odeoomgnq6ndwkT7Zk9jxtKt0
	 eO8Wgz15YjnO7JqnpfF14Xav3DuZgUVX6RbyH1FaGTFCBZbnTuyySRYvc08WxLxw9k
	 0+eGrxRW75Yz9P+xNkciOf0F4JO8uK2GfHbn8nrVwKvp8H+dyojXb6oB4a0hUru+M2
	 G1GCoS7sAnHBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC41F60740;
	Wed, 25 Nov 2026 21:35:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 52DD9325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 19:19:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3955B400CB
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 19:19:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FRL0rjBXpRtY for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 19:19:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7B7CA40050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Byoc025u
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B7CA40050
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 19:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3jJE7kADKTjDQBPrCCUavm7I67gzOdI1r8kxHQINO0=;
 b=Byoc025u/ac3sASPFzdEahTJvE7bUMN9ssm7ZiXWlFINEYi7hKVgO1YW2vWzZ5dLaetE6xybH6aON3VTLkZSURzczrnJrwiJ9/+myxqZrFftrb/ThHiP5v9EGIsOfXbldZHkgIMBGTB2TrOgD/Eg15M0yKuLWopjAtQePn4w7EY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DU4PR04MB10647.eurprd04.prod.outlook.com (2603:10a6:10:589::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Wed, 25 Nov
 2026 19:19:03 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 19:19:03 +0000
Message-ID: <743f0f71-899a-4996-b3c7-836de657e397@cherry.de>
Date: Wed, 25 Nov 2026 20:19:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/23] spl: fit: Decompress any supported algorithm
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.u-boot-project.org,
 Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Aristo Chen <aristo.chen@canonical.com>,
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz
 <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Max Merchel <max.merchel@ew.tq-group.com>,
 u-boot@ew.tq-group.com, Petr Hodina <petr.hodina@protonmail.com>,
 Bruno Banelli <bbanelli@gmail.com>, Carlo Caione <ccaione@baylibre.com>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-7-6647aa23ade5@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261020-spl-fit-compression-v3-7-6647aa23ade5@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0051.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:353::12) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DU4PR04MB10647:EE_
X-MS-Office365-Filtering-Correlation-Id: c46ec460-7b73-4974-d480-08df4b28f764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|4143699003|18002099003|261009223027099003|22082099003|3023799007|10067099003|5023799004|56012099006|11063799006|261026140227099003|261102123227099003|261022075727099003|261022115727099003|261022105027099003|261021123027099003|261026121527099003|261028144727099003|261021121427099003|41080700001;
X-Microsoft-Antispam-Message-Info: SR8YKmDhsLzc3qXal5yiljtFbPCNNLmuPaB84Ofd8mLsYh0nkCmR94XOvb0rPXjqnfqqesqh0BWo2aPuy1gD41PjhcpSDdZdLizwCns80ks6ZwZyjtgUluYuA3gdGYLsR0hViVoOe+NpEJeoer0474dc3JamBbtgvm+vWTKMM6cEvRjumX4i1W5d4QXYjYRoN3ys2zmFAJuNPuHXK//UeJrinkIeZWhLwG5GmMW1q7TSGKNkI8rsHpkcQ8oj0ugeMGBE5ucNUEkuUxY0+IxM8bSfEe4F/e6gLb8xDGPe/rka4UhC+/PDuoIgPwiUm75/tQwdAO8yEngxixYth+w69X4BrXbS0ILrV8KBfDIfMnSkwyPyq1jmqvA2iH/FNfdv7Zkq9ufcJ3xsofefhek67k/QP8UFtZtu3KJ8IRZfI6Pini4vadiZrkyq9GOVCNTUpbY26sjVnaBLDIthmQncvoC7tA2j8Pr+/BkqmRr3g10D4pF+yZcBJRa2KAOCvyHTSlcePJozmBtKMx3Xpeem2IjvdinmebfZw6ZgXPQi0n9QFoGfLIQLhJMfmx91g3fOofCMPY2jUM3neZyUCeGGJ0Z0qcg4Qr2s0dHBX/UomGA9q327P1R6UCSIo7UTg5gnYDVqJk19BzoJCKv98TXLfbFHFzb2h6zr/Zd+itWJbZ+RFEk/0oUpjggNkRAAtL789oPSAvvttf299xrVaUbyCQMxEfqsj6UOKuJUXsLijms=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(4143699003)(18002099003)(261009223027099003)(22082099003)(3023799007)(10067099003)(5023799004)(56012099006)(11063799006)(261026140227099003)(261102123227099003)(261022075727099003)(261022115727099003)(261022105027099003)(261021123027099003)(261026121527099003)(261028144727099003)(261021121427099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEpKOVlFS3dacyt0TU9sRXpIL2dCek1pUEtpazhpdHhzd29HNStrTVlmTWhR?=
 =?utf-8?B?ZVNsdjRGb0NqcExxRzdWT1FzRXZRUEVxYVp4WUpjK29PRERlSzNoVFgwRFlT?=
 =?utf-8?B?RnJoa2cxaXRqdDkvK2hjcTFaTVFaZkExMmdrZEZlMlN3NDFFYUtsN21RUndC?=
 =?utf-8?B?NHordWtsa0wyRk50RVlaQ2wyTDdpQUhOVWtKTXB1NEFJcVlCR3dmbHhHOUF1?=
 =?utf-8?B?d0ZwSkhJODEwOTk1MWdRaFBYWnM0bjlXYVM0aDkweHdtWjA4b3dwME5zbm96?=
 =?utf-8?B?MWowZ25hWTd3Z3ZXRnlMMFBEUjRON2U0amdOU0ZEc0J2ajBLSjZUeWxoTjFi?=
 =?utf-8?B?OE0vdFY5Szc5OGVmL1Z3OW01NmhWWGpYSFBWZjRjckpzVzVqT1Q4dlhKVTNW?=
 =?utf-8?B?VFRFS29xMWFaTXhEdWhsYlNCWG9QN1A1ejcvRzhUN3BTVzRZSlpPVTNyRGY2?=
 =?utf-8?B?dmE2SzJncm5xL3d2YTE1NHp1bHZmamRZTCtDeUdaZWk0dmQ1OGVNQXY1OGMw?=
 =?utf-8?B?Y2JjTk1kL3NYaTRIQnpSYk9hbW45RnEyOFMvVHdHbmtUTEkyTEwyb254YlhI?=
 =?utf-8?B?WTA2Y2IvbDJEbWdVdUMvYU9uUTl4Q2xyTU5oeWU3OEhTRjE3cE1sU1dBZVNL?=
 =?utf-8?B?UU90TEtFT3E0VjJhcXJiYnB0amVSZEx3ZXJkbzhlQlVWYzFpTW5tTmprbDdU?=
 =?utf-8?B?dTZVbnRvd29Cd2t1bGNPbXVRbHJPUHhRajBBT2F5cmFmenZpR1RNd1pUVk5m?=
 =?utf-8?B?MHY0UVJ2UnlrekM2UWtZNVlUWFlZYnNYSEVtejV3SUk5Q1FITHlEZi9vUVdH?=
 =?utf-8?B?cjJqb2dESjNXOHpEYzBoYVQzcUM1Qjg1VEFwdmFUbXZIUlVWWlVSb1JsWWpQ?=
 =?utf-8?B?Q3ROT21HQ2R5dHFaWmVIN3ZVaVZPM05CeHNMZ0RGUkp3bFhIdktZVDczdk83?=
 =?utf-8?B?Z3Q2QktEYVJkRmNoS3lNVnptTGU4TkRjQWRnTUQ5ekZ2WXZsOVQrWWNHbTNz?=
 =?utf-8?B?NGJBSCsyREZPanE4T1drcExnSndYZTUvYUtyZEx6N3NOOGRnUkE5WjVPVlJV?=
 =?utf-8?B?THpKaGxzajEvajRXQjVOYTNBZXRQQVo1YjdLa29ITEw0cExVckE4TU5QejRS?=
 =?utf-8?B?NGUzMFJxMi9vNFd2TURxYlJONDhzTEZkN1F0cFdVV3hrN3ozc3RJbnVwZDZF?=
 =?utf-8?B?SGpFVDlFaXNUY1pWVEhoMUhvaHJoTXRKVzFiU3lMUGxCWlgzdzJYbjdrS2NX?=
 =?utf-8?B?aVBVby9lQlRENkpvTjM4aTU5a3BqZWpJWlFpelV6RU9RUkhkZGpsUlBHVHJK?=
 =?utf-8?B?UWpCMkpFNzVyWENZc2FSRHNyc3FZWlJreHcxS3ZaazV0S25tYkVjUWJ5N3dL?=
 =?utf-8?B?R1JITS9FM1drUTJZcUhpaE9zbi9LaldydWFhTHdOTlgvYksxRnFIaWJLd3Ji?=
 =?utf-8?B?R1dKWFVQNTdDbzlKUHdMSFJkSE1HS09XUXVrQmdnUlRrZ1cybEEvNTdZenEz?=
 =?utf-8?B?cFZvUmNGdTMwUWZ3WTJYQis3eTVMcmdZZEtyOTBVaHRwR2dqZUdLaGlGMWw4?=
 =?utf-8?B?Tlp5dTVzenBLUzAvWkdFdHNXdFhtbDVERHNXMDFFMUdaMks4WEdhMFZkUHh3?=
 =?utf-8?B?b0ZwY1Y4T29nUUVKaFp6b2ltcmYrQjlQek8zL0xvNGRheHhPUEVaL2xpdGIz?=
 =?utf-8?B?Tk1aZllSZ2dyc2Q0bVFIWWd0RTkxYVczN0JTY0JDV3lxcDVobC9wWVhmZngy?=
 =?utf-8?B?aXJkV0Z6TmNKdjhsbExXMUZwY1pMbXlpRWxGckQrMFVKQ3kyV3c3aHRCTFJF?=
 =?utf-8?B?c1k0SlA4d1AwWHIrVnF3Yk1DS0RUMUU2bE95eWRmbzJPWGc1YzNNQVEveEFS?=
 =?utf-8?B?cnV3OGJ6bzFROTdBMVA0YWV1b1RXczBpcUw0TmNiN1MwREEvK3BzNklQUThy?=
 =?utf-8?B?Zk53SGlSaG1vUVFKQ0x1ZGplU3Z2Y245NnZuSUdWQk5tem1LNWVia1JUZlFy?=
 =?utf-8?B?aDNLWXQzaWlxbkRXSDR1M2JYbEM3NURtTzFvVEZsZjRUY29VSzNKZUxkN2xv?=
 =?utf-8?B?aG1VTnRZbmUxK3hYNU1LWmdPMitCeVhwY3dtWlBrd1RSUnZsOUVKeDdHZW9s?=
 =?utf-8?B?UkVSL0pvMjVmMk4yVENWYlYrSVFkSEd3YnFTaCt2UFBWalhoaSt4UjFmMGNR?=
 =?utf-8?B?ZnV2UlMxeVIrVldSVExseUVKckoyOUFzNzZ0Q0w4Mkx1VWFNMkZPNk0xdFVy?=
 =?utf-8?B?RThCaTJoNWNUQUJUalNLNElIYTh5cFgrWTFWVWdSOWFUUWF4ZWlCTTF6THIv?=
 =?utf-8?B?QXVoUEl4OHlTT3VINExQL0praGo4bDY3Z0RVczdFT1NIbU5ZQ3FtZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c46ec460-7b73-4974-d480-08df4b28f764
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 19:19:03.3740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/eZmxzwhXdW/ek5Fb5fv2pPZRNUGuHlWQw3qJ+aF6HqQGYEj13xa26cjXsyDRp6nQdr2JMkfHbyuNDO7hFj6GvZPP+1sUd/rkeBQts2PJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10647
X-Mailman-Approved-At: Wed, 25 Nov 2026 21:35:28 +0000
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

Hi Alexey,

On 10/20/26 6:40 PM, Alexey Charkov wrote:
> load_simple_fit() open-codes gzip and lzma in two places, so a FIT built
> with any of the other algorithms image_decomp() implements for SPL (lzo,
> lz4 or zstd) is silently copied to its load address without decompression
> and jumped into, causing a hang with nothing on the console to aid
> debugging.
> 
> Call image_decomp() instead, which can handle all compression algorithms
> enabled in the config, and will abort on an unknown one instead of trying
> to silently jump into it. Bound its output by the max_size the caller
> passes rather than by SYS_BOOTM_LEN, so that a compressed overlay can no
> longer run past the end of its buffer.
> 
> Read the compression regardless of whether the phase has a decompressor,
> so that an unsupported compressed image can fail loudly instead of having
> SPL jump straight into its compressed data and hang. With no decompression
> support enabled for the phase, a short-circuit path is taken to avoid
> linking image_decomp() and the table of algorithms (up to 1.2KB total).
> 

issue: please split into separate commits

I could identify:
- switch to map_sysmem on max_size instead of size for both lzma and gzip,
- change lzma to use load_addr instead of CONFIG_SYS_LOAD_ADDR,
- migrate SPL_GZIP code to use image_decomp() (SPL_GZIP and SPL_LZMA 
blocks calling image_decomp() can then be merged into one block in the 
same or follow-up patch)
- fail hard on unsupported image_comp (by merging with SPL_GZIP/SPL_LZMA 
block for example),
- add support for more compression types (switch to image_comp != 
IH_COMP_NONE checks + spl_fit_decompress() abstraction)

What do you think?

> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>   common/spl/spl_fit.c | 78 ++++++++++++++++++++++++++++++++--------------------
>   1 file changed, 48 insertions(+), 30 deletions(-)
> 
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 8dabd819998b..50c4b269f700 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -6,7 +6,6 @@
>   
>   #include <errno.h>
>   #include <fpga.h>
> -#include <gzip.h>
>   #include <image.h>
>   #include <log.h>
>   #include <memalign.h>
> @@ -235,9 +234,10 @@ static void fit_fill_image_info(const void *fit, int node,
>    * @fit:	FIT to read from
>    * @noffset:	Offset of the image node
>    *
> - * With SPL_FIT_IMAGE_TINY, only tell apart the algorithms this phase can
> - * decompress, as spl_fit_image_get_os() does for OS types. This saves the
> - * table of every algorithm, and the strings which come with it.
> + * With SPL_FIT_IMAGE_TINY, or without any decompressor in the phase, only
> + * tell apart the algorithms this phase can decompress, as
> + * spl_fit_image_get_os() does for OS types. This saves the table of every
> + * algorithm, and the strings which come with it.
>    *
>    * Return: the compression (IH_COMP_...). An image without the property
>    * counts as uncompressed, as it always has in SPL. A name not recognised
> @@ -248,7 +248,8 @@ static u8 spl_fit_image_get_comp(const void *fit, int noffset)
>   	const char *name;
>   	u8 comp;
>   
> -	if (!CONFIG_IS_ENABLED(FIT_IMAGE_TINY)) {
> +	if (CONFIG_IS_ENABLED(DECOMPRESSION) &&
> +	    !CONFIG_IS_ENABLED(FIT_IMAGE_TINY)) {

suggestion (non-blocking): keep same order as in spl_fit_image_get_os()

That is, FIT_IMAGE_TINY check first, then DECOMPRESSION, so it's easier 
to compare (and keep in sync) both.

>   		if (fit_image_get_comp(fit, noffset, &comp))
>   			return IH_COMP_NONE;
>   		return comp;
> @@ -271,6 +272,38 @@ static u8 spl_fit_image_get_comp(const void *fit, int noffset)
>   	return -1;
>   }
>   
> +/**
> + * spl_fit_decompress() - Decompress an image to its load address
> + * @comp:	Compression of the image (IH_COMP_...)
> + * @src:	Compressed data
> + * @length:	Length of the compressed data, updated to that of the output
> + * @load_addr:	Address to decompress to
> + * @max_size:	Most the output may take up
> + *
> + * Return: 0 if OK, -ENOSYS if the phase has no decompressor, or another -ve
> + * error
> + */
> +static int spl_fit_decompress(u8 comp, void *src, size_t *length,
> +			      ulong load_addr, ulong max_size)
> +{
> +	void *load_ptr = map_sysmem(load_addr, max_size);
> +	ulong load_end;
> +
> +	if (!CONFIG_IS_ENABLED(DECOMPRESSION)) {
> +		log_debug("No decompressor for compression %d\n", comp);

suggestion (non-blocking): remove " for compression"

Save a few bytes by using:

No %s decompressor\n, comp

or

Cannot decompress %s\n, comp

> +		return -ENOSYS;
> +	}
> +
> +	if (image_decomp(comp, load_addr, 0, -1, load_ptr, src, *length,
> +			 max_size, &load_end)) {
> +		log_err("Uncompressing error\n");
> +		return -EIO;
> +	}
> +	*length = load_end - load_addr;
> +
> +	return 0;
> +}
> +
>   /**
>    * load_simple_fit(): load the image described in a certain FIT node
>    * @info:	points to information about the device to load data from
> @@ -301,7 +334,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
>   	ulong load_addr;
>   	void *load_ptr;
>   	void *src;
> -	u8 image_comp = -1;
> +	u8 image_comp;
>   	const void *data;
>   	const void *fit = ctx->fit;
>   	bool external_data = false;
> @@ -325,10 +358,8 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
>   		}
>   	}
>   
> -	if (CONFIG_IS_ENABLED(DECOMPRESSION)) {
> -		image_comp = spl_fit_image_get_comp(fit, node);
> -		debug("%s ", genimg_get_comp_name(image_comp));
> -	}
> +	image_comp = spl_fit_image_get_comp(fit, node);
> +	debug("%s ", genimg_get_comp_name(image_comp));
>   

issue: I agree with Simon on returning early

The spl_fit_decompress function is run too late for unsupported 
compression algorithms. There's no need to load an image in memory if we 
already know we cannot do anything with it. The least amount of things 
we do with unsupported images the better we are I believe. Let's just 
exit early (separate patch, justifying why).

>   	if (fit_image_get_load(fit, node, &load_addr)) {
>   		if (!image_info->load_addr) {
> @@ -397,8 +428,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
>   		}
>   		read_offset = fit_offset + aligned_offset;
>   
> -		if (CONFIG_IS_ENABLED(DECOMPRESSION) &&
> -		    (image_comp == IH_COMP_GZIP || image_comp == IH_COMP_LZMA))
> +		if (image_comp != IH_COMP_NONE)

issue: this is a change in behavior

(you can ignore this one with the precedent issue fixed)

Unsupported image_comp (-1) will now enter the first if block instead of 
the second. Whether it matters, I don't know but it should be 
highlighted and justified in the commit log.

>   			src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR, ARCH_DMA_MINALIGN), len);
>   		else
>   			src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), len);[...]

Cheers,
Quentin
