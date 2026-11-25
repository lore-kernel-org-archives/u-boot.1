Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD9F606A323
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=g7POKBMK;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=FBFwH0dM
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC9BA80C10;
	Wed, 25 Nov 2026 21:35:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e3_Q6VSpEhEY; Wed, 25 Nov 2026 21:35:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4119080DF9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795642532;
	b=UXyGBP4Zd6aqPBT63qAudAABEdtoZf8idB5wynWxk5BxbC5+Uym37K4Z26hKlMVYGV92
	 Om8gSpxN/joh/KjaFsEowzgGZnCQAb0WMhzd/Nfaw0ueg+RbgTNPuk9j3KEnR7sjFcNfd
	 bRG4kJH2xXsCgtJnvVbn/3UgI6y3qShUJ0+oyaZhDnJd8JnxpU4Y22hob2BB2IFDTacv0
	 Q1EzKyH7rzi9jfBwpsKzDaIvw/0SkBVq1eGaSdYoN/WODQrRhIGorb+1PlOP+njA/e/fV
	 iM1pUXGjnaP3Jab/iAbj88GoQLemBOfbvJr59BvM6o+p06X7nAIrwiBvc/er0ZgFl5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795642532;
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
	bh=QZhNvqcXzXhaXthYYuzyW2KSn6o4HLO05lIFXjV99Pc=;
	b=WMBczpVd9xpsbFXjkEJG2X1rXIXlQh9u9vPnrAp8eTWEuvSJygF5BaDwS4HsG5cLxZ1k
	 gxIuo1xYP1i6wlhym2B6Blp0FQjNkL2MJbf+x+WIwg6rZWiDQ4i8JYCAEiWN0+nMMJdlN
	 hPcP94ucoJyDvVPFeL9TyRp5oEAdSHDN570IHpnVdmAPT3pDodVisdl5AAAnSZb6eSshf
	 95BmeLhzcLic2WV3lfKdhSXDtd1orao5ez+zqgT3z6suYU+LHJE+gXpPUraydFAxzFk0f
	 xwQqUSWqxunF/f6a/VTlV6vaLXbHLMsnLRrgC0Xp8ypKvCbiqB2jRBquyZ+EvdppAjg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=FBFwH0dM;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795642532;
	bh=QZhNvqcXzXhaXthYYuzyW2KSn6o4HLO05lIFXjV99Pc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g7POKBMKZQfNr3DC87G+YSaEFEgvhUnDdcX6opL70xcO9/FpdJaiXSB2MYRXQwSVT
	 qJJ7AXEmUumCk7RkJR8SF1Rfu70DOQBB8b9r6BfvWdVBsfgnNkbMInS3htXOC/085W
	 ZPX3s1yBAcRl7v41cmzDN/jNWFSGnMW5jPNYwl1fDLuFMBbUC1G4XxTBxGk1ZNNpu2
	 0ifZzNt/9p4+/50+kScNUO06cmSp3SHX/8hKfKn2mrDBIyIhPEsb+I4+IU0TFYvtSr
	 NTUjxFfAWHDpFpE2BumW2O+h9Z2obd97QNUTRk2CS3giMN9JjOBpbzb8Rw9d5hTVCZ
	 lfh8q1VwFUq/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4119080DF9;
	Wed, 25 Nov 2026 21:35:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B75A1C9
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 18:31:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F18CA80DF9
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 18:31:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZiilFVp6Xw3w for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 18:31:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C4C5580DA4
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
 header.s=selector1 header.b=FBFwH0dM
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C4C5580DA4
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 18:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZhNvqcXzXhaXthYYuzyW2KSn6o4HLO05lIFXjV99Pc=;
 b=FBFwH0dMZjtHsBIptgmkAprhDEKXIeLtnUwF5kG0//IKHbwr4iNrhHvVP+w2YXUichRLxImbJGbsVjMFFU0mZAnI4BMVwe43DPsAQjudltewM7GHma+1mi623cFS0Vawmr3JxPdMUNO3Uo3Hplm1QGhMIaNbWb99ZD4PUvQtc6Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM9PR04MB8177.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 18:31:23 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 18:31:22 +0000
Message-ID: <078c6f74-f5d1-4d22-93d7-88e16dc388d3@cherry.de>
Date: Wed, 25 Nov 2026 19:31:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/23] lib: Track whether a phase has a decompressor
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
 <20261020-spl-fit-compression-v3-6-6647aa23ade5@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261020-spl-fit-compression-v3-6-6647aa23ade5@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0025.eurprd08.prod.outlook.com
 (2603:10a6:803:104::18) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM9PR04MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a33af13-1959-4a15-4651-08df4b224e42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|5023799004|11063799006|10067099003|56012099006|261026121527099003|261026140227099003|261022105027099003|261022115727099003|261022075727099003|261021121427099003|261102123227099003|261028144727099003|261009223027099003|22082099003|18002099003|4143699003|41080700001;
X-Microsoft-Antispam-Message-Info: 9JmWVq71CMXRe6i+Xksaif/nnjmbgty9QiRg5fyQ4Eeeqp2MFHA7DSLj7NHHHRTARMFhUIZPAtrrGU0tEmWkgHPGh0TpFveWE4b0ZkhpvRskPvDLmxN/nVaMY0DzxYTkZdUSZ3mMGKnpxyFVp5gqRad+lVHNlnVYB4ic1z+Oj+czpFK5EsZH6BTkPiqCjlAY6UYlQhr0zrh7rS70j5xeVPZlNofR7pP4SydUqbzzZnYBZYEU7mjcECKjN59p/G1J1ll2fl0VJtQPMRBUJEe2LtIqdY2ZnWrr+1N6FGA9N+4Dppm7+TvQAEkPEF3GLIePKjUB4R+d1J+gRmS6azjnrIFKA6pBOxAWV/xnpkXvY07wxLUPWNqDasH6JW1lJ0OisseYcU7s9AMct8t69anGbRmEhb0O8MZRpLi319Yvk/0RiRXjxKtHBA68QSZWwI+yvlMLgf187DhGo9ARWBuOrh546nsPtv637/Uf+oXusnkS157wLPhDztXpK/sLgDJ5r3M85pEAx45Fm44V8QG1CdBg1ibH6Rxlxa5XXZoRWmwYfGemGkaLXW+EtHQmZrsmUZdqTZPmhmLmDptBMheUZzElUkmJN/wuAR8WpzdM+YWzkIzaXY0qZCkF6sFL7MgJUMSOeX7vYZSLyc26yjoZJoKigV9+NTHSi8V6QS53CJ59P/8+AL9wCfiJAxvgSoSHix8ccgJfdBNlBK4iTHjMUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(5023799004)(11063799006)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261022105027099003)(261022115727099003)(261022075727099003)(261021121427099003)(261102123227099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003)(4143699003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVlCc1orODU2Nnd1VHkxRFNvOTA4WXNlOUFwSFlNak1IYXhZSVAzdjUvU2pO?=
 =?utf-8?B?K1BIc1B2YWtWK1lYRXJoa0V3NGNoUjFpQzB1cFNZaHVTN1E0OE51S3pPSUk0?=
 =?utf-8?B?cDFnNFMzbzkvTzZhZ3oybmI4NVRQdi91N3FJZHdmTHhybXVNQ1FJTHpnQXRJ?=
 =?utf-8?B?RGg1ak5QUUtOMDFRc2orV3hwZm1Mb2RLYW1vWG8wMkxrVFlsMGwrVjY4YUdy?=
 =?utf-8?B?Z2NUNzdIcGl3NjdqM1lUbUJiL2ova3FDdzN3V0R1RDVwMzRCUUNwSFpjZEJo?=
 =?utf-8?B?NXJCKzNSRzF5NlV6OTZmVFpqTFNLVml1bXk0eHpSVnhvc0pDdFJMVElrblRK?=
 =?utf-8?B?UG92QVBCQks5UldjNFlJYWtjYkY4U3BTQUVJNmRJU2xiUS8xRnBodUJVUGJx?=
 =?utf-8?B?enRUMHg0bFIxZnhCZmozOTNUN2R6NFFlWDhMM3ZmNCtOUUNDdTlxOFdqZGJQ?=
 =?utf-8?B?dEhubTVnUzYzeUYrNGNxZVlrYTdIY2wwaVlLdUMrVFF0cm5SS3dvQTRVV0NI?=
 =?utf-8?B?cjExNy9lMXI4NkxBUlBpSTJNZmFzcTlrdi91ZVp3MjQ0M21TWDl3Uis5UXBH?=
 =?utf-8?B?RmtwSDlXWHZlc0tkdW0wbjZBRzhXcWtNaUdwOU05UWY3OGNYNUFFKy9YbHRl?=
 =?utf-8?B?Yk45WEVtTmZseXBzaHZPUmllVlZqbTd4VXIzWTBkdnJKbm5vb3hUWUNuTzJH?=
 =?utf-8?B?bVZHd2hOVkRJVElkNjJsNzFFUkVsbktrRXVaaEdoYjdHVm9pc0N4SjlERERs?=
 =?utf-8?B?MUlZZGF1WU9UZHhhRXpsTVVpN2FMWGNCUmNXV00xYzR6WXlhNGNFenpGWXBW?=
 =?utf-8?B?eGJYMTB1S1NjQ2orQS9PNFdRemNVemQ1bjdTTnRQWGZaSmdkUSsvby91QW8r?=
 =?utf-8?B?U1gvZW1BS256dERzcTUwTUZNWjE2b0xtZGprU3ArSjlqQlp6aW4yeWl1azdv?=
 =?utf-8?B?dGpBYVFocEtqcHlZRU9SeEVEa2R6SnlWNk5Eb2JTcU9jWHFTN1ExQ1NGRjZo?=
 =?utf-8?B?TTFMaGdVUzhaYXZxd1N1L01qYTFhZEI0eTczWFAxKzZlendWMm9GSUpkeXB2?=
 =?utf-8?B?elhMek9FTlp4NGluakFwMStTUWh0dWQwOUNKNHhHZ2p3WWpMWFFZNS9zK2ZV?=
 =?utf-8?B?MnFzWFpidzltTlJLOGJPRHVxRkFxSE5JRHNOa2hHQkg3bG1pWjhuUnVhc0NX?=
 =?utf-8?B?SGFHa1JYeUxZbVB6S1k5b1A3anZjdGNxSW1tTVlOZ3orL0IrOVVqVUovT01S?=
 =?utf-8?B?NDhtT1Q2OHhUMm9WdEpQYnRhcWp3ZUkwbE1wY1FlY0VKSDRNZHBERDd3ME9G?=
 =?utf-8?B?ZC9oRGxEd3BPMVRlcnpRcU1ISjBHdHhIK3BTNktNY3JxVTFxcjFqSHRVd09t?=
 =?utf-8?B?aDRTZkdTbEtnREpGQTdKT0RDZ2wwUkRVSGQvUVAvZ1ZuTlh5RDdVTFVEalpi?=
 =?utf-8?B?Y1NLZEdYekNuUys0T2NUSEZUSFJrUThwbEVoSkoxQjVhUys0M1ZtN2gxYTli?=
 =?utf-8?B?SWhGMmw4TlRBVkEvaHRhc2tJaUNhRk9uWVR4Y0x1WkJRc1RTaldaNWJIRkJp?=
 =?utf-8?B?ZWlvay9ybFo5ZER2R3h1d0NKU2t3Qm5rcHF1bSszM0pvcGVVYzk1bm1tTERK?=
 =?utf-8?B?eUNrYlY3UC9QRko5aU90cnFaRTRZcUFVV0hIbHh3MHo1QTlWNkNKenlrQTVO?=
 =?utf-8?B?dVRtN3hNM3U5TXUyV3FQUG5pNlhtUFk3Nis3ODhBMldwQXNneDlhbWNUMEhs?=
 =?utf-8?B?SFZwUHBFMXdrK0YyRURZUnp2VTQwZ0ZjY3JHUkhWaDNyMEw1ZXFWUzZnOWxn?=
 =?utf-8?B?aG9tZkdMYnF6aDVXb2IrT3k4Z0F5RkpoY2FUOTZrZ2o2MVdGU2ZwU0lwLzdk?=
 =?utf-8?B?bEFRSmp3UHVMdTc5d3BpeTU1NDdlSUZIMWdqSFVBY3dScHJnY1hCTlJaMnEx?=
 =?utf-8?B?MmhmeGpwQnpBYnZqZndzRlUxU2FBRFJQUnVZc2hNcjc5UFlPWWVvVktzZENZ?=
 =?utf-8?B?aTJBVU9tWkZXZ3B1bWRiV2RlWDhESHNxNlI4MjhLY3BOeG1DV0xqR0tyd2Vh?=
 =?utf-8?B?THJaSzBERGh1WlZMeVRVc0lacWY0ck8wcmlQeXUrU2Y4U0dFcDExb3VLdk4w?=
 =?utf-8?B?eVBnTEFqVVhzaCsyZjQ5QjhXUnpXdW16UkNKWjd1VmpLVFo2QnV6MkJ3N0Vz?=
 =?utf-8?B?N21nUTZXYklLU3ZqYzVPODhzM2hLeEl4Q1BQSzVwMWdYN3FOaFZCejVLeFo1?=
 =?utf-8?B?QmJHSXlTbCtBQWxOVXpEaGpSaGRRMFRraDU4WFMrUklMcEIzTi9aSVkwbTZ5?=
 =?utf-8?B?eFRpaDh0TlpQZ0hLcHRxWit3RmRGeEN0cUVibTZxWUE5M2E1Y2Z0UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a33af13-1959-4a15-4651-08df4b224e42
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 18:31:22.7631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLhtIh2R3U7IjmyLfku1BVfrpUw0eOcqlUkjNVLYMCCJUx2B+JarlDLSpiFoA7VEKwdqEt4QYdYaRq4NDJ5uRW1IqMWPlstvsOJROnm074M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8177
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexey,

On 10/20/26 6:40 PM, Alexey Charkov wrote:
> spl_decompression_enabled() names the two algorithms SPL happened to
> support, so every algorithm added to image_decomp() requires editing the
> header. It also asks about CONFIG_SPL_* from a header included in every
> phase, so a VPL build with VPL_LZMA reads SPL_LZMA and answers about the
> wrong phase.
> 
> Add a hidden per-phase symbol selected by any of the compression
> algorithms and ask about that instead, which also matches how
> image_decomp() gates its own cases.
> 
> SPL_BZIP2 is out of scope: lib/bzip2 has no phase-aware build rule.
> 

issue: simply remove SPL_BZIP2 instead or adapt the code so it does 
something

The symbols is simply unused today as it stands, so I would recommend to 
simply remove SPL_BZIP2 to avoid misleading users into thinking we 
support it in SPL, we don't. Then you don't need to justify why you 
don't edit SPL_BZIP2. In a separate patch please (prior to this one).

[...]

> diff --git a/lib/Kconfig b/lib/Kconfig
> index 5f4698f0795c..365776e05d80 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
[...]
> @@ -1087,10 +1096,35 @@ config TPL_ZLIB
>   	help
>   	  This enables compression lib for TPL
>   
> +config SPL_DECOMPRESSION

question: should we add a depends on SPL?

Just to be extra sure a non-SPL stage cannot enable it by mistake? (same 
question for other xPL_DECOMPRESSION symbols)

> +	bool
> +	help
> +	  Selected by every decompression algorithm available to SPL except
> +	  SPL_BZIP2, whose library has no phase-aware build rule. Code which
> +	  hands a buffer to image_decomp() without caring which algorithm
> +	  produced it should depend on this, rather than list each algorithm
> +	  in turn.
> +

question: is this sentence really relevant?

This is what we currently do with your patch, but there's virtually no 
limit in scope for this variable. It just tells you whether at least one 
compression algorithm is supported, what we do with this information 
depends on the context.

> +	  Only the xPL phases have this symbol, so it is meant for xPL code:
> +	  CONFIG_IS_ENABLED(DECOMPRESSION) is always false in U-Boot proper.
> +

nitpick: unnecessary info

This is a symbol for SPL, we don't care about U-Boot proper in there, 
just remove the sentence. I understand why you wanted to mention it, but 
its place is rather in the commit log where you'd explain that we don't 
have a CONFIG_DECOMPRESSION symbol (for what reason(s)? maybe it costs 
less to simply have it and have the decompressors in proper also select 
it such that CONFIG_IS_ENABLED(DECOMPRESSION) is reporting properly in 
every phase?)

Cheers,
Quentin
