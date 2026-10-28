Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0DE606A31E
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ur1G9ePN;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=SUvO45KJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9188880B08;
	Wed, 28 Oct 2026 11:39:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pUI4SlE30z84; Wed, 28 Oct 2026 11:39:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 91D0880BE9
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793187589;
	b=iQ1o/c8KqcqbalxEDpA7um5EMGuZaCH1O/0P6PKhD8ByapUYyezWg5wBvgHEmz6CrxNa
	 CaADLe0r/VnNeIRNznQUViCpLuObAyWzODfw0k4mcbtS4Qgx2SRS4p1r8V6dyJFucAHFW
	 cuYBYAUE9cyzSiKrgB27QHthqphfmQ6OM1OgjcTiGf6Co/w+fBKBKxZDnz8GW1RPlNFAR
	 qbrJFT35hFG6YaYLWvezKT0o71fwxpH3KMTt1jAPDboRRXWoV3lH14nUjT2hT8BydllZ2
	 2Q4ZEeyA89xfxrzekwOIwMUI+20BFayYM1RV55yEvOQa6UAmN+w0H8jqGIPivNnI4NA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793187589;
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
	bh=rD68qEbngRi3vv3mCWVo4SUn66adw1yHPz6LJFZdt98=;
	b=Q/atE4/dLvxqkKZoi1QCPmRWT+47zJXww7siuKBJkwj4Fsq5Hgoqug4/6EAN6YVFqdSI
	 joUFswkTMx3Y3UVsTimnKCyq1+DW21eG2VCUBUF43g6a9pirOeZVKR8qxSzIY5sHL4Vft
	 RD4X7E6mZ4kCYOlKP804PYdLFjc5gjq3afb9vQS/jkxqMEw9scV5S2kwyuVbAm5F+9OP9
	 5MBuMjD7QuJBZaItoi01AIM61skP0LIylhQx++njOkE/y2beH1zmdRZAPfH23ogomCBP6
	 k23i8qOR1oy4VIwALaFHv5ZN/vZVov1Zg1qHfLH6J7CFOP4ALEKfDRAh8DxHGwNRvsQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793187589;
	bh=rD68qEbngRi3vv3mCWVo4SUn66adw1yHPz6LJFZdt98=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ur1G9ePNKL/+K/IoT9iKAQNxeiOPgMKU7Gewt1EzwwGdZTQaGWNiBscuGgvd+nzBU
	 ABV9RIm+HKaUZAstL+h9uslWmTrP3TOzT9ujQzC9r+dxQ0aALEVqZSmnyX1N4ea1kY
	 CwsNfQvg0N2xsIABAeMEVSZg2kUNkjVK7dearLdF1eWc+Ua4S0L7V2QMix++CzLIlB
	 GIodAgFWx6x0BnUu/ETdoknbbgPeU06oc01/+VnKTFDnA4kkayyBePw2xCkLe3q5j3
	 ja6L+HPtZJxGOpXSiprpIfj8KII7n6GtA9jbM26d1UmDS3tU3Ls4l9YV2cHDUfW6vr
	 4bQfIRytGBxeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91D0880BE9;
	Wed, 28 Oct 2026 11:39:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A8381235
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:39:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8DEEB605DF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:39:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w1KIzKbbJTBe for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 11:39:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 794FC605D4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793187587;
 b=fAxHueaqM3PhGbq+IQG2uYc2hwzd2fbhmpEoQ4VQHHZYJOx4DOIZMX8Wz0PWaXiqn8sY
 bK8Q0CxQBwAqFO2pOYtdafXjvVJ5Y3YTJyqIj+xfaSUgqD+UdSxq44FasXDbYU6qX8rTO
 Bal6e1oM7bkLybYPZcomvtn+pEeAw+47k0PkuAMGKdJXxT5Eb9YVej4G87FykhyJ8W9PM
 Cfp7E0/pnWaSniYfSbBbG3iSho1hHd1pW9EBUL5oCwTKorrgVARi5Bge1OR1l6qAVXyQS
 FvA7gH1SWfJDxMBM4EsNiSqRwEMDUwQRUvkpUON0gqcNc8atrUJzEdANbnYNJ8/lC2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793187587;
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
 bh=rD68qEbngRi3vv3mCWVo4SUn66adw1yHPz6LJFZdt98=;
 b=GfH2XzHWbfzjwnBTwoM5oL+qrpZHg+CRPcJ1Ni0wIZNsVxCge5oM/ZShHfvuaoj+5/bc
 eyVNMZIkqSrjcRbVYY66lQ8IFPlF+f8khxeZBi9CzhSF5clu2sr60LhyzYei3Tornh/RY
 z0Bz9gMKWq+FYoy8M0N3kY/Aq7qqFhtYJ98y9av6BWQaFqyrxN69wonzjO1wFOWRxNUKV
 t10n4qJ5li92oPyiUVC9OSBXCcqMQBXwLNsSkmNo1EC4Yr5xN7Huo3Y2h5+j+I0OpSdAW
 /H/mRi9JOm70OFVL26Ec+o1zZe2p77MvwZzcCBA31SgjpIwzG43954swaO8pKN9lpYQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=SUvO45KJ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=SUvO45KJ
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 794FC605D4
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:39:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M735yKlMG6uFDmo6augUV7YmOOJMSSUc+fv/8ETM73P00nh+PLHpDFmwPt+V3QPkoBPvW39fALJbZZR7wF27MW8HzNZvpBAf3zoYzpt8DVk8XPiJ/q9d6fhsXFHF/jp5aVsg+tYFEuCz3Zwgo7XdJ5gqOifbDfvq+7nBaDysq+nKFzL+Gg6cxcTRVrw5aX9w4Y80PRXiPE48yMOcRgs7LHWMTG6idD4X/gPiQY8VfYh9ZjDE+ihwEPWpmZzH+Rc+7uaWLSs25SOvPEbRuJJjkHDR7KY8NaJsptCVMzUXl4tqLls+Iq2tli1akhcgjuORhwmAn0Ij2C1+0n1/xU/dkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rD68qEbngRi3vv3mCWVo4SUn66adw1yHPz6LJFZdt98=;
 b=N6ZwJUe0+dEdVhoiGSWc76/evM5B8Y7xAFivEGkLlyeDmQ5heITjWhnDzgwo4HUbHG4C2lDSROvIz1otWsp1iHcfwVKXslwTk/lU3KC+9vhJR2YaGMPW8F4mkfmH07PGF36Cf7y2o1+1wW1NqUs18vGWDGpom43DJKShbrepOOIKTGt7UJwmvaKq+wrsDNhK2bBbk2x4ADajyluZwGk+61uhDNh/R7kPSf4ZiEGoAFhRh2uQNoD3gv8bzGbNoqbHwzdijLQbOFVXDSxVP4aICdeKvr0uenS+bcJiuoajxxmOe5Juikvh7A4dklF2VNWmU1xYEZkmYQwLGbMjqQ94wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rD68qEbngRi3vv3mCWVo4SUn66adw1yHPz6LJFZdt98=;
 b=SUvO45KJ2R/xt5r4261nQfxLiiOsCjyUH39xBs372WKQ0oJS7kg26dw7nwoqSa1IarG6uOPQNyJ5mf4EpPr6oNUv59RROpxN7KwHCgQqrcbKffx43a9ymlbmBXtp35TbN9XMpwTzAayoFMHLyUjWL6mrWCVIDYToBYIFzZqdsq0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by FRWPR04MB11102.eurprd04.prod.outlook.com (2603:10a6:d10:174::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 11:39:40 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 11:39:40 +0000
Message-ID: <7e71bdce-7244-41a7-9675-f2598e26d3e9@cherry.de>
Date: Wed, 28 Oct 2026 12:39:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: mkimage: Update init code size limit for
 RK3328
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: fen.chen@rock-chips.com, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20261004195853.59863-1-jonas@kwiboo.se>
 <20261004195853.59863-3-jonas@kwiboo.se>
 <dc849a75-9166-41af-9ba5-abe8a63be884@0leil.net>
 <c59af0e7-a265-4521-8258-01296de5fcf1@kwiboo.se>
 <d3ec0007-47bc-4e0b-b652-1bc1ba160003@0leil.net>
 <814b5780-35b7-42eb-b240-134ea9115104@rock-chips.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <814b5780-35b7-42eb-b240-134ea9115104@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0445.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::18) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|FRWPR04MB11102:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df97d98-ad6d-4e7f-b4f3-08df34e826c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|261009223027099003|261022115727099003|261022075727099003|261021121427099003|261022105027099003|10067099003|56012099006|261026140227099003|6133799003|18002099003|22082099003|261026121527099003|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info: epfUp3VgCKslmvyOYFdxYabZlTqCZKDmJenIhNTULAbSdTK4guLJR04dRMliyHQHX6FN/FACH7YBljHSzx96TNDS7P3iy2kkpzNz9Fd1JRRTMn9uZwDs6oDz86xeMD4Ly5P5Fmt/HIhNi2XG3sYKH7UMVQPOyjoqErWh6Ah7RrYSYS+iM5udG+xi1yNReuVZgbwqkYHRszZBNsVix+rWbdHbvzeaGAbTEfBbfaFPnciCX67RWWse3JOCuJ9CIb+XADCtanhk2lBnuesu0yMGxb5DwnJZsYwA0EQzlCulYJlnQBZ04/q/o39ZRQKtiS4z8jApn4oP6k2uo6o/fJFRBttPZmOpImvRzRN2vdwBfHnjuMSZAz3PZnsgc71KOmdpW0yIqv97z2eMv4hdO42wzK+9JgcFJ7L8qra2jCuEMMqmMAVl77jTGWzZA4bX21NauYLiwEffWFNyDVvn5L5Cjvf3/hGcqeEpnQTjeUze/ebrsHqMb+N5Ldcwd4wPgtzxMWaIOHyo7s3BHaHgPAY3sqcnDE07eT/bzL2qZQaIZc19bp+YxU+tcbjfdlRgQj7qnV8IBDgy+Vih8C0xQn8HSFl89qIka7XIcyZJXMCSpxGmZ0G1gd3UsHXo0zhnwjR6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(261009223027099003)(261022115727099003)(261022075727099003)(261021121427099003)(261022105027099003)(10067099003)(56012099006)(261026140227099003)(6133799003)(18002099003)(22082099003)(261026121527099003)(11063799006)(5023799004)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFNHSlU4V0h6b01Gbk9MYTZUZUR5eGQ1dElvdllxUWkxSGpzclpIeEJ2Wjlm?=
 =?utf-8?B?em8vWlVEQXFMZ1l5WDFYTmQ4Qi9BQzBtTGs4ZnZIbGxIODZaYjI1MGp6UzJs?=
 =?utf-8?B?anhPWjJKb2MyY25RZXRsc3dWSUFZTDFRR3pVU1ZQYllFRFdaZ2cvTlVuWTVx?=
 =?utf-8?B?dUlSNlMwOFZxNk5Eai95RzYrK0tHMEZQUnpMOUpPSDBnTGx0SFM5WmxWSXdW?=
 =?utf-8?B?akhmRWY3UWJFSzBIL0RyTEVOMGU1WWZxSW15L054akFmRW9TNk5PMU1XRUY4?=
 =?utf-8?B?ZUFhSk1KSDJNTzdvQUlvb09nMFVvRnJGaG5sUDhnb0VWVVhvOGNiNitLZjkz?=
 =?utf-8?B?SHM5YUJqdTZYcmlhd1ZxZW1UaHVITWR3akg3VWw3dm1hMG94OCtFSnBxWFJI?=
 =?utf-8?B?WCsyM3VMK1U3UkxLcWxmdGg4WkNwTTh6aGR1YkxHOEtMTGNCcXU2ZDRaOFhR?=
 =?utf-8?B?c2p3R3lDbFVBeDRPTGIxTlg2WDM4MXdkQUpuSU5sbU5iUzdieUxlWHdYOWQ5?=
 =?utf-8?B?VnZxSUxjQUhYdnZBVUdTV2N3RXVWUXhCMGNxcTgvTno1YjRDcUJ1VzBzTHV0?=
 =?utf-8?B?czg0dDlJOHdyTHhFcm4vV2x4Z2FJdlRkZGpqd3hNUk9PSU84N0lQRUpxYUxy?=
 =?utf-8?B?aWhuUDJOcXFFbDRQd1M4ckJQekZZMTkxNXhmdDBJN2FKK0krZ2xEa1FEVjg1?=
 =?utf-8?B?Yjh2cXI0aGJjbk1FRmdYZFdKckQ5eWpneDMrVjNtYkszS2tqODdZMVdUaHdG?=
 =?utf-8?B?V2tranNEMHVGT001Q3ZlYlpoUzRXM3ZHM09HL0NhNkI4dmxzSGdMK2hVS3No?=
 =?utf-8?B?c3l0ZkRrK3BlTTJFYU02N3lIWFV3MmpjS0c1TERlRml2UkhsQkVhNXJpVEdP?=
 =?utf-8?B?U2IwbExrR1pUUjB4RjVPUUVGU0NHbXJnOXY1ZzFmQ2xraFRzMUZlSzBKS2hS?=
 =?utf-8?B?K1h1UHJ4U2cvUmhLRHNsd3ZTQ0MwOThPS0ZlVGYray9WbHdHTU52ZHY1ejda?=
 =?utf-8?B?UlVPTUFjTS9KOERTck9GcXN5YlM5bjVUM2tqZDU1d2twdTZFSWpONksrTmVF?=
 =?utf-8?B?bWxjYUVCNElneWtjbExzdDhZeGFKd0ZSckhtNTJVMlBjcnNhMlk1OFhXY0Fx?=
 =?utf-8?B?Y3FlbkFLanhQN0pxbUVhT3hmUktuNUpsdXFFY1hlTE85MzBJOFZreENVMElU?=
 =?utf-8?B?T0wxTnNmWHo4ZmhsWEpmMTY3Wk5PcXhza3JPVGptL0YzZU44U1h0aVQvY3Fh?=
 =?utf-8?B?QjRvTUd6M3hVemxnSWNWVmFjeE1uNnBUQXVvSS9ROGRpWXhGeXdvWGJTdENP?=
 =?utf-8?B?NzJJTnR5c2QyVW1WT2lHTFRJU0xiWlRsVXAyNHJ0VG9pUzJQN1hFNlpXRlJQ?=
 =?utf-8?B?OWhjeEZPYTF1V2E3dkg3WWxPZFNKajRMZkdOL0VjSjBiM2pWYlRIdHd6UkVW?=
 =?utf-8?B?T050Ym5odTJGeXV6U2ZHRU0rVlBzblhFdGovNzQ3c3ZDOHRlaUpRSFY2c2da?=
 =?utf-8?B?b1YrQ1I3NHVNU2JHemxQN0VpOU12YnIzLytrNy8zRlFmeGdxUlhCQkh3TW1N?=
 =?utf-8?B?QkpRYVBSeWhlT1F0WEVwVXVVRnJZZEV2TkJlbTZrUVdEY3lIMk96aHJVQWZo?=
 =?utf-8?B?SnNLTUpTQ2hhRHJZQWVZcGs4SWdWYlJleW5vZUR2TzZzTmxVUEhmSEFaZE5Y?=
 =?utf-8?B?VGJabFRrRkkvekJwY1dEL2llVW94a25lWUhZMGVBZmdxWGtJeE90L09BYlNG?=
 =?utf-8?B?RXlwdnhuUk4zVUF6Y2ZQandGWVlFb2JEN3IyanRQWXNRdEFNU2I1azJIY3lJ?=
 =?utf-8?B?RDAwSU9TM1FnZUpLUnRGZUcyRFpRLzd0a3NOYnJEK0ZmcUViOUV2bTkxOFJQ?=
 =?utf-8?B?OVhyU0JabFZMSGwwL244L2hsNXdldXJYWUNFRFpxK2hGZUE0YzRKcVY1R2xE?=
 =?utf-8?B?TDJKVGhOOVM1K1ZNR3N6VXo3SmlJNXFLQkpyUCticFJRaS9zVWtYaWpjakVk?=
 =?utf-8?B?SUxrUmZUaVpYelJYdTZ1a1hEWElpRkZKZG9EeFdPRXZ1RnlaY0VyemhKSFVC?=
 =?utf-8?B?ck9RYXNVSEJMYWJiRTVHMk9MUzJlRlArMlJYZ0d1RlJ6dEhNUUdIMHdCbTU4?=
 =?utf-8?B?N203cEFqaFEzN0tFOTBoZytYS3hocU9icmlSUC9RVjNTam5RM251dzMrUVcz?=
 =?utf-8?B?YzdjaG5CVmhVRmE1dWQ2eEpsNTZyVklWL1krVUVWV21oZkZiK2ZxZmd2UFJu?=
 =?utf-8?B?WFM0MmdUNDd6WWhZTTlReEZKMzB3MGU0OXpHK1lxaDc5cXc5YXJ0bjYweFRo?=
 =?utf-8?B?Mm9ZekxjQmUvVzd6b2YvK045QU82dTYwUDJWRVRvanI1TWdja1JUZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df97d98-ad6d-4e7f-b4f3-08df34e826c9
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 11:39:39.9399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jf5NZLhOOs9mZEkT2DTyvI0EpbnySYzhSt9nxSoNSpEF4D88FM4YooWr2Q9+HNmD8s9BptHAt3T3CN4V4T7nanPZRZKlZwEg8g2CLAiOcos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11102
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Chaoyi,

On 10/28/26 9:41 AM, Chaoyi Chen wrote:
> Hi Quentin,
> 
> On 10/28/2026 1:42 AM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 10/16/26 11:25 PM, Jonas Karlman wrote:
>>> Hi Quentin,
>>>
>>> On 10/16/2026 12:31 PM, Quentin Schulz wrote:
>>>> Hi Jonas,
>>>>
>>>> On 10/4/26 9:58 PM, Jonas Karlman wrote:
>>>>> The RK3328 has 36 KiB SRAM at [0xff090000, 0xff099000). With 4 KiB of
>>>>> the initial SRAM typically reserved for BootROM during early boot.
>>>>>
>>>>> BootROM will load init code of up to 32 KiB (0x8000 bytes) to address
>>>>> 0xff091000 in SRAM, before jumping to it.
>>>>>
>>>>> BootROM typically jumps to init code with following registers:
>>>>>
>>>>>      x0: 00000000 ff091004
>>>>>      x1: 00000000 32334b52
>>>>>      x2: 00000000 ff520000
>>>>>      x3: 00000000 ff500000
>>>>>
>>>>>      sp: 00000000 ff090f50
>>>>>
>>>>> mkimage is enforcing a 30 KiB init code size limit for RK3328.
>>>>> However, the BootRAM can load up to 32 KiB of init code.
>>>
>>> s/BootRAM/BootROM/
>>>
>>>>>
>>>>> Change the init code size limit to 32 KiB using the <size> - <reserved>
>>>>> pattern to closer match the actual limit of BootROM on RK3328.
>>>>>
>>>>
>>>> Downstream still uses 0x8000 - 0x800 so unless someone from Rockchip
>>>> confirms this is safe, I would rather not modify what we have today.
>>>
>>> Maybe my commit message was unclear, but I have runtime confirmed that
>>> BootROM is capable of loading binary code up to 32 KiB from SD-card and
>>> eMMC and the code was fully functional even when padded so _reset was
>>> placed at the very end of binary, in the last and lost 2 KiB.
>>>
>>> Most likely the mkimage size limit was used to impose limitations for
>>> stack and malloc area, very similar to the issue with PX30/RK3326.
>>>
>>> Runtime test consisted of running a minimal <2 KiB TPL binary that only
>>> initialized DEBUG UART and dumped passed x0-x6/r0-r6 and stack pointer.
>>> The binary used no malloc area, its stack was pointed to PMU SRAM or at
>>> half of BootROM reserved stack area, and the binary was .space padded to
>>> push code to very end of the loaded binary.
>>>
>>
>> How can you be sure that we aren't corrupting the BootROM stack? Between TPL and SPL we actually go back to BootROM so code from there run for sure after TPL has run.
>>
>>> I did similar runtime tests on all rk3288/rk33xx/rk35xx/rv11xx SoCs I
>>> have access to and all current limits in rkcommon.c beside PX30 and
>>> RK3328 matches the runtime limitations.
>>>
>>> On RK3288 (96 KiB SRAM) we can even load a binary up to full 96 KiB,
>>> however from SD-card, only current limit of 32 KiB worked.
>>>
>>> Please reconsider and/or hopefully Kever is able to confirm my findings.
>>>
>>
>> I'm not sure we'll get to see Kever much anymore and I don't know who exactly we should be asking. I've been told Chaoyi Chen might be a good point of contact now, so trying this here.
>>
>> @Chaoyi, can you confirm we can use 32KiB of SRAM on RK3328? See https://lore.kernel.org/u-boot/20261004195853.59863-3-jonas@kwiboo.se/t/#u for the whole context.
>>
> 
> I'm not quite sure whether I caught what you meant. And I guess you
> want to know the stack and data ranges used by the RK3288 Bootrom?
> 
> If that is the case, then the RK3288 BootROM will use the 0–4KB space
> for the stack and data, while the remaining SRAM stores the init code.
> 

With the SRAM being 36KiB according to the RK3328 v1.2 datasheet and 
your comment above, we should be able to use 32KiB for the init code as 
stated by Jonas in this patch.
However, Rockchip's downstream U-Boot limits the size to 30KiB (0x8000 - 
0x800), c.f. 
https://github.com/rockchip-linux/u-boot/blob/1c535d65b8509f388d09e49fb6961f49fda35a1d/tools/rkcommon.c#L143. 
I was thus asking for confirmation because we are about to diverge from 
Rockchip's downstream U-Boot and I don't like to do this, especially for 
things we (non-Rockchip people) cannot know if it's not documented.

My understanding with your answer is that Jonas's patch to increase the 
max init code size from 30KiB to 32KiB is fine, and I will therefore 
merge this patch. Please shout in the next few days if that is 
incorrect, so I don't merge it.

Thanks Chaoyi for the prompt answer, much appreciated!

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Cheers,
Quentin
