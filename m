Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB33606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ntm6SwEN;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=nuMwznIB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2515740963;
	Thu, 26 Nov 2026 15:32:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xd5K-jmqTLRA; Thu, 26 Nov 2026 15:32:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3615340A17
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795707155;
	b=NHg1M4lwTAyLx9cTiuK2ngVVgaahO1E9zpr7WZHyeuhfR5NQxLFVsNPJj5QkRBq6gIVo
	 r8GdotgaC50AEFY+qgIJX9scGHpHpGUi5GiyvnJphCJ7+7vNeeU5RrvktvC5nsgHOSvAT
	 yPfHvrYUX6yXbar2DxKthxxXNlTRVRwdAbq3p4qrxmr7VzVPL7XOuXkurxOP7dfuGtl1c
	 gjfMkBdUrlOAPPCWycVSqhFuoNvHe7+Sxdmt5evfa6NI7p9zZVXjOTyaybFQoXwwTeqtm
	 6x4xmsQm/4sh04nLY6OiGra/qcTP4kN2o0pF9er9nv43jO2FqYkZJ5HjWwRPjxLucZQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795707155;
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
	bh=rUyKcrPBy8cbcHV/tM1yzI9AK8GMZHKUhtm9XRhsB/g=;
	b=tJMB2Sv/aqFauNpKiqtL3xsciebbPFBkRX3i95WR9qS2fK/xaETWO97VBcHCwuFQ0dzT
	 uuy6y0N4Mn7bBear1i9gjwrAvdQFhk8gF2xzk0l8HwO5/zF2XseyJ555b0ntBAIvbOCea
	 7TAewe8I2z6GbVSsTAgfI1lPzcq0yldU+LIAcYsgMwJNax52T7Udb+1GXssSb2KSSUAMS
	 g3em6ieyj7Xq0DsRG8LT/ofgJVaozW7JpqgIwXro/yb6+OGI3HPz9KimDfesyK9/pmrtf
	 WyL/Duz9n4W4uD7Yl8nrh4MTQ4UUF4YhtyAsxyb2pC/9w/kzD4zXAGVaotSuPY9g5/A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=nuMwznIB;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795707155;
	bh=rUyKcrPBy8cbcHV/tM1yzI9AK8GMZHKUhtm9XRhsB/g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ntm6SwENU9QVPpI4lzmYhEShuUOh08T8MZ4OmtK44ohIwg93ozLs/m74+d569FnOt
	 cawQXHt/Q8nveDB06pevIIC7KW68M3J3sm/W0JO7WEx1ORadaEkb9NwQNqllGDS3Fl
	 QHUTiLJYsk14squYmknb4LrF5I7D4/EwS5h05U+pr+mqqpX6jSZgbvWGbzzVy9iyJo
	 hTnd/ftUZ2fwCIz9zN4VmScZr9ng08292whtTbSv5xyhvX806fZ5S9yn9pIC7dAohZ
	 puT2tanKk89YL/cKHJ8dvzHmDgddYiVD0vksk/u56N41WYy+R2C4GGyLEsYfwMbcw/
	 FVE+i8lVMwTCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3615340A17;
	Thu, 26 Nov 2026 15:32:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 23A1F10B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 09BA5409C8
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:49:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FiXHd6QkG76d for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:49:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 27BA4409C6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=nuMwznIB
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 27BA4409C6
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUyKcrPBy8cbcHV/tM1yzI9AK8GMZHKUhtm9XRhsB/g=;
 b=nuMwznIBICPNYMOB8nnFr2CF3dGpnxXJvH/5tcoCqQwk+dy+xBsOQsNqb99EEqCHdE4xjHFOzSPPSjKgmnH5FJHw1+Y65v7e/dRQhcSH5eHmOEvNPJOhlLzSCygPexVJCFUX7CYLlygUy3CvQeut036OinZUwv6IkqZ3PBhTJ2Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM0PR04MB7058.eurprd04.prod.outlook.com (2603:10a6:208:195::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 14:49:32 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 14:49:32 +0000
Message-ID: <d3ffeb16-4e05-4aaf-9a2e-637c4226d98f@cherry.de>
Date: Thu, 26 Nov 2026 15:49:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/23] rockchip: generic-rk3576: Compress U-Boot proper
 with zstd
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
 <20261020-spl-fit-compression-v3-22-6647aa23ade5@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261020-spl-fit-compression-v3-22-6647aa23ade5@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0387.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::12) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM0PR04MB7058:EE_
X-MS-Office365-Filtering-Correlation-Id: 44231f6b-cd24-4fda-e060-08df4bcc7b69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|4143699003|22082099003|18002099003|11063799006|5023799004|56012099006|261102123227099003|261021121427099003|10067099003|261022115727099003|261022075727099003|41080700001;
X-Microsoft-Antispam-Message-Info: RHTcbLjLSGLZAo2ldTFaXQ+P286fyW+K2GlGLlLHL2EK6j3BcKI5wZc7OiVYNWGoZ/VVjcj+MUrESJ8dZtjgkLe5w7iycZafijQrgOBreoyct1MUV1bbX+khOt3bB3KmlBMxD3qxBVjn9gkOznJvnZHBIXDvRy3FSEgz3zPMt4KXgtl1RsQ/P40n8ZMCUhE7dYDtGyALIn+cLxs0l40pxoVqTM7/mwOnkO18vDZia563UnqNtgL8YHGhPglZ+90HWA01eTuSdC5IJJIzvgZerrm8pH79pMH3ix0UCLQA+h6s1t5/7YuDJLGfyOg71DB2aENqbzjpkoACp+0BXOc1F7dq64PDVevOGviks2rWiZY8Te5Zv6XaOm28l2XF24kiCT/Y//P+G1u/36xrq99IniaV5npzcT0I0HoQTsNTs48+ogyp/fjKcVfi/A7NPVvMysI5it7vG6tI5fOTYjR2VcpHCdFmZcUNy2rduERKc9u6qWZc4OMl+RviVqpjaMqBcCGUU2IhLfYssbbQ0DYZ1iGUPFdX07W0NB1o2w01d9Mg5mnUfsZfaREQaOYd0rxK1ahQGmAGQRM1viFGHk8hRDUr52x92M13c5Xpf2Zs3Za+1oZwcfh09UamPoFwzkLGx0Rs64zm0YgggLQZY/7QFQYkSNV+y3F0m5WBSuGlBM/jGlhrTeeEvKdruGFcUIY1EnvV4Vg41MfjtDultByAzL+9Cpr8dePAcDKOCzh8YG4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(4143699003)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006)(261102123227099003)(261021121427099003)(10067099003)(261022115727099003)(261022075727099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjB0V1RVMEhsZzhyZjhyT3V3SU5SMWhxMmxxbXBWSVlEWGJIL2NoM0lMYmha?=
 =?utf-8?B?OGp3R3V3eldLOXdjemxDYTNaTnFKdUtKdURTTWZCYTFvaTY0ZFJuMXExQSsv?=
 =?utf-8?B?UExIbXIvbkwzaS9uSzlCcTNIVVhXV3pUY2swZWMvRGUyWHAyc0gyNFhCR25s?=
 =?utf-8?B?N1g5d1Jma2p6M3EvOERxdGpwMUN5VVdHQVRqN2FwRXo2QXluT0kxL084Wlgw?=
 =?utf-8?B?SjZpcGxXRlRmNnVYWHBZZXVzTHJtZU9lWjBGaC9UQzZxZmRHVFN1OGJtVVVV?=
 =?utf-8?B?OHZrOEJKVVhKUFZUT1A3bVo5dlE2dzBvRWg1Si9zMW01aUtQT3ZrV2NsaTZx?=
 =?utf-8?B?L09ZNlB6ZDNSMlJuMCtET3FjRE8wS29YN3QyNG1GN0UwWTYrN1Ayd2JEeEMw?=
 =?utf-8?B?MXozc21yODNha0RLbW5jUU1BY1JMbDlQQ2xyRFdqdTBudnVpTklDYzIyelhq?=
 =?utf-8?B?NUo3S1lFVkE2SUFwTDZ0NG5NeGp5OGNseVQ1N3RFVDRDUnFtdlJUd0pLOW13?=
 =?utf-8?B?eVR0emRRYVhNU1p0MVpHWnY5dUVkR1pFSGw0RFloRVBVZExrNGx4TTIrMXRr?=
 =?utf-8?B?dGpzZXRUSWh3OUdRNTZmbERTczdCSEVxNlVONnNYdTkyTVBqbmMxK25QZGxX?=
 =?utf-8?B?N1JnV0hONWZENUhEVTEvQnNYRVVHa3ZPeWpEanlZK1NJZ1NPVU05UnUvMnl6?=
 =?utf-8?B?ejVTTFhHZUJmUzBSVy9hSWptd2FQSnQ0WkRCZHh5WEErWjU0MUNHWVFIbUR5?=
 =?utf-8?B?YzdkTVRyV0ZzL0JEMy9BaWZsNm16MmRZN0NCc2h3bGRhdEtOUm9uVVoxRzhO?=
 =?utf-8?B?Rko5SFMyV3VGc2U4TEhYSmdCR21QbmdUNThRcWhTWUhKSlhPUWtIeklrWjYw?=
 =?utf-8?B?bWk2UDJheUN5d0JhSEtwNTJSZ29iSWcyb1JQaTZocDRzSVAxVmgya2NFYzY2?=
 =?utf-8?B?S0wwMy95U2RkVU9ZckdNVXE4REdSVkVDRVFOVitqd05ETUQ2VVEzeXpYOGtk?=
 =?utf-8?B?WGFpQlVsMWo5N0plNHFQUUlKc3pOeGI3a09tR2hlTUk3WnBtK24zMVJmZ0dV?=
 =?utf-8?B?MWFZMkhIL21RYTgxUGczVFRnZmc2Z3JTaXBlVU1mYlpxb2hhUTJYNlhLbUI4?=
 =?utf-8?B?Zzd2cWJ5SzJTbVl6cm9xR3RGd1h1RHIxMWVrOEcvazFaYkorVTlINm1NSUNQ?=
 =?utf-8?B?ZGxhUnRZd1dVOWJheDk4TDVpVjZhU3BiOGlTU2hzNlZxTHkxZkl1M2xNRUc5?=
 =?utf-8?B?enVpeTI1OVQyNzR1KzBURlRzV053NDJTMVNOL0Q0elRKTDZhYlNjd05aOC9R?=
 =?utf-8?B?RVYrS05MSkRuVTBQaHNRc1dmcGd1TWtNS01HanV3NTR1WTB4Z1RlY2VxZy9q?=
 =?utf-8?B?UytQNjl5dUY5OUFXejV5TmdwcHRMYThPZ3JrOWtqU1pZTGVxamc2TVUvZ3hZ?=
 =?utf-8?B?cUxJMHVscHBjMVpVRWdQM0dHOElnZjQ0SFJxL2RLYTgrNnpZOEt3cFBGaFZz?=
 =?utf-8?B?dmJQdjd4UW9tYmQxMkpwT1EzeGp5Y0NEQU1EZjhDbmJxSmxNMzV4WGYzV3Ar?=
 =?utf-8?B?ZThaNUZLR1Rnd25YbGgxdGVVa0o2OFpUcWVCQWZsZnFleEpQbmRJWTBBOXZi?=
 =?utf-8?B?R0E4dy9NSFBNSWVNSUFIR2dRZXBlN0xSVmFMMy9rSzVzaVovbEpxbE9qR0J0?=
 =?utf-8?B?d3YzWFVEcW1uZ3h5YzRLZU1Yb2s3eDNuMjJYRVoxZlROVTNnWnBXZWJJdW5M?=
 =?utf-8?B?dFJ2dXpXb1lSdGZhY1RUVVZxT2JXeGVOOGkxQS9MYkdLUFRmM3hyR1QyN1Jh?=
 =?utf-8?B?TmZtSVBTekJXRW1RUW9LSlJ2ZStCbzNPRHVoMldscXFpSE9YZWhyaDY4QW9i?=
 =?utf-8?B?Z0pzVUM5Y0o4VVNxNjVmdWFScnMxQVZ6UVF2THBSUXRGb1hMZmNiTXJESDRS?=
 =?utf-8?B?T29USWEvdEZUdVdWWVFVb2pKQ3pHU1FEcFp2UEpXSWVOUjh1em82WWovN2Ji?=
 =?utf-8?B?cXlZSkZ6Ync1L3F5c1NFRnd3bUhZSHVwc1VWOVBaZmVSWGxVVFltMFhIb3BZ?=
 =?utf-8?B?MmdmSExyNDJTVmNhektjcUpTWWxyUDJLMWNPRFNyVG85UFpFTmFsZElEYWZE?=
 =?utf-8?B?TGttZUxzN1BzK3BMaFVzNXJOY0lvVUlpcVdnR25lNlJ0L0N3TFZQRVY1emlX?=
 =?utf-8?B?R3hvbXZ3MFdxRE1tL1A5OFhtTUNJeExMcVpmak16ZXlpcEkxNVRsd3loYVZl?=
 =?utf-8?B?b2xIcEYzVUFlV2R2ZTNNMW43MEVoMFZWT2tZOTV1YzQ1WG5JTkpFM2tkbE5N?=
 =?utf-8?B?T21uNjlZMUZPNUE4K3pibmFMVXoxUzJDdHZjMk5nV1dpUDFUYWx3QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 44231f6b-cd24-4fda-e060-08df4bcc7b69
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 14:49:32.7317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3/7f8/m8wc0VD5x2kAmv1UQqqGtXXnlakEeV+a90wzNcFCkE0TseYuo6ljo7rpNSwoF6D39ZDLlH99NJULK4z+J+4AnP9mB22RVlW3qPt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7058
X-Mailman-Approved-At: Thu, 26 Nov 2026 15:32:26 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexey, Jonas,

On 10/20/26 6:41 PM, Alexey Charkov wrote:
> No in-tree board picks a compression for U-Boot proper, so CI never
> builds the compressed path of the Rockchip FIT, nor links zstd into an
> arm64 SPL.
> 
> Turn it on for the generic RK3576 image, at the highest level, which
> shrinks the payload from 690KB to 296KB. The image is meant to boot from
> whatever medium the board has, so this suits it, and its SPL heap and
> SYS_LOAD_ADDR already leave the decompressor room to work.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Fine with me but I want Jonas's approval for all changes made to 
Rockchip generic defconfigs.

I think it'd make more sense to have a sandbox defconfig that enables 
compression for proper in the FIT and check that way instead. Because 
right now, nothing in our CI actually tests that for Rockchip (hopefully 
in the future it'll be, but that's a mid-term goal for me only), so we 
essentially are only building it, not testing it.

We could even think about testing each compression algorithms with 
different proper images with the same sandbox SPL.

Cheers,
Quentin
