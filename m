Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5ED606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=REX8bSMm;
	dkim=pass (2048-bit key, unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256 header.s=selector1 header.b=2+8ftafk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4FE580DA2;
	Tue, 17 Nov 2026 07:38:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ojg7seRbp9H2; Tue, 17 Nov 2026 07:38:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 152CC80C35
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794901120;
	b=QTsP31o4HeKRwWA5qx9mZLOIeRBRu/uJyHMNyhd20mKJj8X66E5ucXx0VqUZEPLTgO2s
	 E7YN4G6cO+BvG7o4oatI/dq73plCDSBJ81uKYv4OniUWno2nbT7mv10TztnLlX+d0LT3+
	 P82WQ8UccfQ7nd0tGY4qwJ9L7Wcw2ubt3tBUNvJ3osTsFU0BKSz2yR2/+PCRbB4cCsMhG
	 wbuseBjMVX3yZPN/HAgosVVMb10Omtiher6q6RdS94gYa+NRFvPAxXIGnxfIeu411wU3D
	 3X7XBwmNRwX4t6riF3o8G2LtJ0vCbqOUDCaxDLufGfuAYBP2qENmCCWd0w/C3sz0Qdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794901120;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:From:Content-Language:In-Reply-To:Content-Type:
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
	bh=3g1x9rVsEVBuaGeV1k52CR24eeTqEs0Jhdln4TVRFHI=;
	b=C0j18352GqAC1Q5wIBCqbW5IoDOUQ8QpaEoTZ8AzeWYbUZN/d+qFDvfVtmcR6IV/xUoA
	 U48FylctXGqz2pqdaUGpF6ODXeK9HREikq73a0x3058okrFeBqDR2hGaEylypOlzIf8OA
	 dNvwvZUCX3ez6o2cpMzOgGW+14I+5HD9/594eozD+UqvRtE3fy5IHr8ZHfcP/E0k/NDHt
	 aQvtY1Y0sQkptEGShNrznhjZj8TjzaUvIOxDuSxS5iVzkgWW/Ykx5/fwUyS7Wpwep0SFK
	 e7VG8Y0HlwjvB59ERcLmnY2aMJ8FC7MBXsCJb0P5r1N1bZMp7ZlrDY6DNJl2yLZlobg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794901120;
	bh=3g1x9rVsEVBuaGeV1k52CR24eeTqEs0Jhdln4TVRFHI=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=REX8bSMmN3sWRsOW8NNV9gGedDskTbjvmGVkFmGnNtpY1rKC+FME9PYKdByaFjkN5
	 fZOfLgnP6d6PY1Pr+3h9o15i7MPTbrg5DNVm0fDTGnjQCVhGXMoF60cA5Ch85thUOt
	 X+o+UeqYjpJT+FwbioTzLk6ZXx4C1tqB+jGDurPB+7EOw7zakOcIkmjL+2CxKQ/6Nj
	 GfrhWypWz2Ml2Ds1Kqg0cbQIj/TNuyocHbIifSnPp7XCwjt9BxgjAJEX4/yNi6CA9M
	 GuD/kyBqjxwZWVKE9xTNPz9tqy1sHkYS1SyPj6YB0Y7qGeTTK5QDOxk+6ADgC/pLJk
	 qqaNtWwfWgn2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 152CC80C35;
	Tue, 17 Nov 2026 07:38:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 76676A0E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 07:38:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 53A2B60825
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 07:38:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qU5_rtXlbtWz for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 07:38:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3BA50605F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=2+8ftafk
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3BA50605F7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 07:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3g1x9rVsEVBuaGeV1k52CR24eeTqEs0Jhdln4TVRFHI=;
 b=2+8ftafk8cnZdL0O//lX/QPuEtKL5cZOUrPzsg2zt2NOtOiY9xta0wCSWKIrPgk88V1K7TXMd7tMbfEt3Um1ENUb3XHjFLD4o28eGvX7i4YIzt2hQEDp9Am43aZKorTN8hI3472QY+Hjww+x7IgMdUeaMb4uxS3KKUJk27wTw15SHp9XwFwQnXFTOVf4GOxBg8x7kYYSf9jLmlwiESZQ3/1y7RhgnHwQwyEQPaSTb1FlUkfpy/ox8h9SdpgPmbaIO0Wei770OEBY91mySRPIDfEFVEQHWf93t5paqddlWX7RiB8fvPh+r0IbR66rNiVfUAaM+09BwTdtho1zr3uugQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by VE1PR08MB5792.eurprd08.prod.outlook.com (2603:10a6:800:1a6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 07:38:24 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 07:38:24 +0000
Message-ID: <935542c9-f52b-40c7-bf45-0984dbee09ae@iopsys.eu>
Date: Tue, 17 Nov 2026 10:38:18 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] spi: spi-mem: add spi-mem caps support
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Vignesh R
 <vigneshr@ti.com>, Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Eugen Hristev
 <ehristev@kernel.org>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, u-boot@lists.u-boot-project.org
References: <20260927235716.1872707-1-mikhail.kshevetskiy@iopsys.eu>
 <20260927235716.1872707-2-mikhail.kshevetskiy@iopsys.eu>
 <8ffb90d8-4717-45ff-87d8-145f9271811d@kontron.de>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <8ffb90d8-4717-45ff-87d8-145f9271811d@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MR1P264CA0165.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::13) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|VE1PR08MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: ac681207-2e20-47d7-7515-08df447dc280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|921020|261022105027099003|261021121427099003|4143699003|260925021911599003|11063799006|260925021311599003|260925022911599003|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261102123227099003|261021123027099003|261009221727099003|261009223327099003|261009221227099003|261009223027099003|18002099003|6133799003|22082099003|261009220027099003|3023799007;
X-Microsoft-Antispam-Message-Info: PajlAm5SqSXPbePBOsCtIOIHD6zCFVaKXddr5wu2fJBWn4ylPrW7GTUGNXHt/Qh++BbN7wKSMCsRqDYXcd1ScJ3vMtj+eK9LZq+Q1Bx7L+w9ASk7tk8/KN/uCcthwtkSTuHv6iZXZAsxcbh+ktPWQ7grB4gdMMUliB3JObqFqVFmAZyQEwMao4zC6IuMWjJJJeibkOFXh12weXqTcxTs/230oazWy9MAr22lU1uoMwqSwmZ4tXKhvP8Yr4Hnsd6l8nDbxL5DJrr9LH9kv+aoO9qL7vB40oTH6p5AlSEREhwGA8etWkb7STu35lhIUv/Fc5SA1bmJhBMraN3epDZHk0Cmy45f3B3rAZrNa+t1exGG4iEIupenR5S9q6VtofwUi7ayk/Y9QBaciwNXPzKJXjrsiEQQMFmnIzbl1rc6oxZpiP/dj5frrJBN9Xc9kfeRLTKkpYiv/hcQb/n6VgREo4p19ylBAtbgR3NJuUDVhZFSiat1YlB5t47xNvdupX4pX5w3zqdYq5fr/0Evw6wpaxr17FtGpjSzOh8jxFNuHym1gcD3X3z5bT6Af1ofN+FY+T4AGT9CLqns2Lfx6iGrJJDKSknskZAoJ1qGBL4hcGn3Ee2fQUGY0N8KJJR/TmLmpGtxNilhvJtRpT1mcxlBWAZDX9e9edh7lXDTWmaVsENXkAyrTfeKmzl5+NtQ9CU7wx2CLllJ/Rkp1cXHy4ojfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(921020)(261022105027099003)(261021121427099003)(4143699003)(260925021911599003)(11063799006)(260925021311599003)(260925022911599003)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261102123227099003)(261021123027099003)(261009221727099003)(261009223327099003)(261009221227099003)(261009223027099003)(18002099003)(6133799003)(22082099003)(261009220027099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXpyM3NZa05LQ29Fa2ZhZlBCWlpjRkR0ZXRNa0lLZ2JZRVR0bDB1Q2toTjVa?=
 =?utf-8?B?YXZEOThZK2xEeXRxMGs5Nm92VmF3RzJvblJxZXpmcTZwVnpEWWQ5TzFSMGIr?=
 =?utf-8?B?ak5XWlMvdzU3eTdJNWVsZTFUQzdGQnkwMllTS0VMVFZrOUpuV1hQTTVwUDhH?=
 =?utf-8?B?RUVNLzU0dzBhKytTZkgyKzQxMTF2ajVMalA1YWJiNFIzYUsxbFFzdFZDUmxV?=
 =?utf-8?B?dGZhSXQ2cHl5NzBEUmZmTlF5VWYvZzBaYkVDMFVDZTQvbTJyR0Y2TTVkVkRJ?=
 =?utf-8?B?eUZERkhqcW1abGxGUUNSWXRuVFRNK05lTWJMNldaMWpKa1pRNWFmYmhGMkp2?=
 =?utf-8?B?Q0RtSzlwTDBRNkRuNWpjWHZXeUh1QWNERGZab0hucVRNMEhkSmRLYUs3d0RS?=
 =?utf-8?B?cERmQ01haFZTd2xLSEI4bzEvaVhsdWw1eG9LTkx2cG9sZHpUWjl6WXZVMXJ0?=
 =?utf-8?B?QTRhNzhib0NvRU5kUGc1S2dEb1NCRDZXQTVZMm5NdjJkQ3pDY2hHcGM4UDZ6?=
 =?utf-8?B?SjZaTXJtZHd4SWppRkpOUktjQ2xwaVc3TEFZWkg3aUpsSlRwbm5Wc0NidGxJ?=
 =?utf-8?B?MkthRmdjS0drMzJzaGgrWHdMUnpwUno2dWZReWJJSytaZGVFT0MraENYcVJX?=
 =?utf-8?B?RERMTVVtN2w2R1ViVTFBd0gwOEtRb2tRQ1JjS1psWUpDanhkSWhhVFNZb2ZR?=
 =?utf-8?B?aThXK2Vud2Q3TUdqSHkweWFGdU0zZFVROHJkNGR3WUZKZ0treXY3QWJWbTQ1?=
 =?utf-8?B?R1lGMHZPMXpTZTBpRWJCSi9vSEhmMXJYTXZQSWU1bVRuQ05OWXBUMGZRa3k1?=
 =?utf-8?B?NjJlUzdwd1ZXVmVtbnNnTnVyOVVUcHRCQ0diL0lKMHc2ZGpseGR4WG1VTTNX?=
 =?utf-8?B?VHJXMHZqK2V4ZUVpQTVtUjRiaTNrQ2JxenFZdUd0d3lpVFp1dEhaUVpnWmpy?=
 =?utf-8?B?SWY4SDQ0bFQxbXplaHRKTFBKOXI2N0pWWUUreFlHcFZzZUtkd2s4aEx6dmFI?=
 =?utf-8?B?TjZJK0dUVTZzR1Bkdi9PZFUraytYcWFBdWZVOWFkYWcyM2w2c25TTzl0WDE4?=
 =?utf-8?B?V0loaEJRQ3RGUGw1NUFmaUMxNGc0ay9JSGlVYjI1TzU3b21nOHNKVGI2eHh4?=
 =?utf-8?B?NVRXUnNkL2FqaWlFMGY4OEtqSlVvQ0kra29QMXFLeDFMclg0a2VMcEZZcVFV?=
 =?utf-8?B?Ti9CNkI0U0JLYTBKdFMyMW04Y1h4WE5RaXBoTGRreHlYNlFVbnU1YStmMlRp?=
 =?utf-8?B?KzhDeVFSUVVlaUxaaGlsVlVkRklWNldxS1ljZjZqcSt3S0ozeGxyVkMyWnN4?=
 =?utf-8?B?RzRjZDBXS3VTQ3NGK3pvTy93cE1ycGlmVStoajI3T2IzZ0RwdVBnRmhoNUlr?=
 =?utf-8?B?dWFBY0hmWHZkaWpIeEw4SktndVE3YmNFOGl4QmpRakJzQTVOdFZQYkExdU1Y?=
 =?utf-8?B?eEx1ZFQrUEp1cyttMTVjY0s0T0xkTURQQytEdnYycUQ0L3VWbk5WV3M4cGJW?=
 =?utf-8?B?WkErNmtrYXNjUitZTGZyZ2t5MEhoUXRFaXUyUDdQbHovayswZjZtSSsycVZl?=
 =?utf-8?B?MDU1bnlMWGZNOWFKVkFXQ2J4UG5Dd2lJR0I0MXR2WmxTSGY0aFBwMG9SMlpN?=
 =?utf-8?B?UVdXSnNWTTlSdEl4b2UrWkdHVXJHaGgyUWNwWDZKS012S0FhcExtM2t6SjB1?=
 =?utf-8?B?elh3enkzWEQ3ZnJWNXI3azBOYm5lNkJHclEzUy9Lam5ZVEFwblVvSGVLWjBX?=
 =?utf-8?B?Z20vQWlHUVJjNWVCZ1NLdFU0bFphNU4ydGlpQ05QWHR4SUIvNmRsMHcyRUU5?=
 =?utf-8?B?UkhoUnAxeVdVeWFISmdReHB4NVZvV2xLRjZRNVBPbTNndHU1Y1grdXcrL216?=
 =?utf-8?B?TDN4bExMMnE3MmhNZVNQcDlnMjl5ODlNbExYaThsZWt6Z3ZMdFY1b1pEMWFq?=
 =?utf-8?B?M1I2YWRKK3crVi9mSEEvTDQxdUk5VFc0Q1lWNjdUdHF3SHdHN3lOQkxZL3lL?=
 =?utf-8?B?UzFUcmI1bStubFBwbnBJNlhFVm1tTEtxVm5NcHNMM0g4L0RaVksyVmhjaEhp?=
 =?utf-8?B?engrQ0VKT0E1ZzFoT2ZvNnBFRVpibFNKYkZMbkY3M2l6OE5xeWJwN2pLYmU1?=
 =?utf-8?B?MnVRLzdsRHgrNVZsM3JrOXk2cFY1NUVMSHFBamFSS2VLRWJqRW1FVkgwTUVX?=
 =?utf-8?B?V3NJdE5ZSlNwb3gxMkJiNEZxc21Pa3k3UGUyTDlCZGplS1VyMEh5V3Y1Z04y?=
 =?utf-8?B?MjZiN3krWTk2Y2hjdHhQbkFLK1Z3NmloZm9aVk1oSXdraE1Zb09peU1IMy9V?=
 =?utf-8?B?V0VRMm1MNk1DMGdsakFHQlk3cUQ4NWgxbzh4N01MSXBaVGdqZFA2VVlDVS9W?=
 =?utf-8?Q?vQtoIlhZy27YIe/U=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ac681207-2e20-47d7-7515-08df447dc280
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:38:23.8471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hK++T6kcEKqoAK3DbIW29a1a0hWh7cEZYuHbVpOXCMP1TbugqtbkPL/dzRErd217Hx3W/AR/vWG/vT+e3ATojpdQen+mTmQJ3XBby9Jr9gE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5792
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


On 10/7/26 10:54, Frieder Schrempf wrote:
> On 28.09.26 01:57, Mikhail Kshevetskiy wrote:
>> This makes code more generic. Also it allows check for DTR support
>> and emit DTR operations only if it supported by the spi controller.
>>
>> This is necessary for spinand DTR support.
> Could you mention the corresponding Linux commits here, or if possible
> pick them directly with U-Boot-specific changes included?

It will be quite hard. The following linux commits were involved:
 *4a3cc7fb6e63bcfd  ("spi: spi-mem: Introduce a capability structure")
 * cb7e96ee81edaa48 ("spi: spi-mem: Check the controller extra
capabilities")
 * a9be454927de3b6d ("spi: cadence-quadspi: Provide a capability structure")
 * 9a15efc5d5e6b5be ("spi: spi-mem: Kill the spi_mem_dtr_supports_op()
helper")
 * a433c2cbd75ab76f ("spi: spi-mem: Add an ecc parameter to the
spi_mem_op structure")
 * 030ace430afcf847 ("spi: spi-mem: Allow specifying the byte order in
Octal DTR mode")
 * 8618271887ca10ac ("spi: spi-mem: Limit octal DTR constraints to octal
DTR situations")
 * 29c8c00d9f9db5fb ("spi: add driver for NXP XSPI controller")

and maybe some other.

>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  drivers/spi/atmel-quadspi.c |  5 +++
>>  drivers/spi/cadence_qspi.c  | 10 +++---
>>  drivers/spi/nxp_xspi.c      | 12 +++++---
>>  drivers/spi/spi-mem.c       | 61 ++++++++++++++++++++-----------------
>>  include/spi-mem.h           | 19 ++++++++++--
>>  include/spi.h               |  1 +
>>  6 files changed, 68 insertions(+), 40 deletions(-)
>>
>> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
>> index b2b96e1c4b9..37d97c094f8 100644
>> --- a/drivers/spi/atmel-quadspi.c
>> +++ b/drivers/spi/atmel-quadspi.c
>> @@ -1286,11 +1286,16 @@ static const struct spi_controller_mem_ops atmel_qspi_mem_ops = {
>>  	.exec_op = atmel_qspi_exec_op,
>>  };
>>  
>> +static const struct spi_controller_mem_ops atmel_qspi_mem_caps = {
> This should be struct spi_controller_mem_caps instead of
> spi_controller_mem_ops, I guess.
Thanks for noticing.

>
>> +	.dtr = true,
> Anyway, the Linux driver doesn't set mem_caps and doesn't enable DTR. I
> think it should stay disable here, too.
yeah, I think you are right. I'll remove DTR caps atmel-quadspi in v2.
>
>> +};
>> +
>>  static const struct dm_spi_ops atmel_qspi_ops = {
>>  	.claim_bus = atmel_qspi_claim_bus,
>>  	.release_bus = atmel_qspi_release_bus,
>>  	.xfer = atmel_qspi_xfer,
>>  	.mem_ops = &atmel_qspi_mem_ops,
>> +	.mem_caps = &atmel_qspi_mem_caps,
>>  	.set_speed = atmel_qspi_set_speed,
>>  	.set_mode = atmel_qspi_set_mode,
>>  };
> [...]
>
