Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23354606A6B7
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JnhaBj7W;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=C7OqJIDZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E678B60726;
	Mon, 23 Nov 2026 10:42:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M5jDNPsNVTyf; Mon, 23 Nov 2026 10:42:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E7A3E606E9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795430549;
	b=UoygaN/IMPVXbO8w/PYDhf2rFK5A1nTAG+zA6FUAuBZGjwAJCh1BhmPe2fgFD4/hbqVA
	 CZIPdlyB1f9qNK3Rh3Wu7JmohNtxQVOIMe+a9EcEmkKAjGCgU7/lTIqAv/5dAQFUIW2Cd
	 /V2Lg3n/Zv2h5YAsSpOfvFYr0Fi2ZJYEmk2tiSrcQANQ077gxm7AZRIYbuJBKt0MAEi60
	 w7e6zymoUkY2R+Lros2pPDHEpjNrmJHVJncKIlvqOqsEDekAtdFxaKu23w7OiWoumWToU
	 gDjtiB6HTOgu1uJIyo+o4jlHW+yGkEepegAiSjs34zhuaT8HIi4LCo5SwQXTTSuDjYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795430549;
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
	bh=0IHy1In0PRbvZVIm+tPSvv7N69wrfpZsqp3Z102f76A=;
	b=P0RQ1FtRV6ykrayTpNz0D/6oaMiUC71JnBhN///uPMCocFU5fAO9ry9Dzl0x9nSCxGi8
	 2kIQbZ9NvIs/RHU6HPQFwGLH+QoBOdPXROgYmKn8w49f6uf6ZUdwDX/CbPzifgr++Mpk0
	 QrYYv8qsf2nXzVg20+ZdLWH5ITzn6N9MjYY9fDfsAAFvB8v5eS93k47btGdI8s78ADkXO
	 oCLa4WRS0IZEhmagoVGMXdHyplyvtBrbxyi6fOvE2/HCYZEqNfIRC9x76B/VPklFhk+mN
	 UUgi1E+UhHlqMm1uFnI0mWD/RDZblK2pp6Vk5Wv/Sz2TjSaWLQdA69MFKv689d0keBw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=C7OqJIDZ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795430549;
	bh=0IHy1In0PRbvZVIm+tPSvv7N69wrfpZsqp3Z102f76A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JnhaBj7WGWz6gZtkmA0ry8CnaxDdQhzZ6mSR41zv9tFB3Bd8L8Ewrqg+9Y+8bzih+
	 nN/rGk+ISxV3T1CP/KtxHjztRQ5VtwW9EuVFhsD4bhzYMOX7R8CECpWPeKuhpc/6Ga
	 Hda1NJ1dk2H8n+ONoMP5fbgcUe7ZctXDl79owNwxm/zgdxfCJn38sekXfmobKsjL2d
	 mXXvKyC9Zbf/j9zfvGVHiCVBH/wVjnrQrwiPWLv43uvadZ27tmGAHm/TpVj+HzFssS
	 mCrTZDFHrZMhsD6QGq+L4m6ecHhvWeJvho8TqMtzSsGF1VjVQ+9MAUlW43zYW3UNHX
	 vanoko44RbaLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7A3E606E9;
	Mon, 23 Nov 2026 10:42:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B6CEB260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:42:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B3BE4606E9
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:42:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6pGEHRcOPUL5 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 10:42:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 13C77606D5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=C7OqJIDZ
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 13C77606D5
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 10:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IHy1In0PRbvZVIm+tPSvv7N69wrfpZsqp3Z102f76A=;
 b=C7OqJIDZQqzVvBf9S8Y5SwTocCGYSxsav8LnnfijwmfcsL0rv1dfGflY12TCi25Q/4nZsYzqXbJnT5ySk3gHywBZv22WgQ7P56HSFa5XLIELeZiFoo7abvJm7zLvG24kXxUsfeSzoiLNL1TK0QuEXZ74ovNLerXrGGlS3Gigbvk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI0PR04MB11482.eurprd04.prod.outlook.com (2603:10a6:800:2c9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 10:42:20 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 10:42:19 +0000
Message-ID: <91d37791-d14c-454e-9354-1fc6bd2326bc@cherry.de>
Date: Mon, 23 Nov 2026 11:42:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: Add section about mail providers which modify
 Message-ID
To: Vencislav Atanasov <user890104@freemyipod.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20261118-doc-msgid-v1-1-1088bf601fb7@freemyipod.org>
 <e03a2d6d-0d62-4690-acde-ac4da73c2b13@cherry.de>
 <010701a205034107-1fc5e0d5-2075-4e92-b339-d45cab7197b6-000000@eu-central-1.amazonses.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <010701a205034107-1fc5e0d5-2075-4e92-b339-d45cab7197b6-000000@eu-central-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0114.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:358::7) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI0PR04MB11482:EE_
X-MS-Office365-Filtering-Correlation-Id: 0615e342-3872-4154-165a-08df494e730e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|4143699003|261022113327099003|261022115727099003|261026121527099003|261026140227099003|261028144727099003|261026130827099003|261026135527099003|261022105027099003|261022075727099003|261021133027099003|261021123027099003|261021135927099003|261021121427099003|261021130227099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|3023799007|4133799003;
X-Microsoft-Antispam-Message-Info: 3eJFkkbzX1yhDLfzPfNsEPKmvR52lgQjAN+1PG49/Y/PVzB2yxcUaba9LtJBtEtEmpL1xTekkxcD3OQ9++PAn1UzGUsPc51bqXyhQXyq+vT5CBBy8JUODZw6FCypesMe89SIgM/3uN35XyUVKhsaz7YWeoJ7yRQhEpLIrfjStZcnVzEHcQtOLc1/X6d33cjD9Q+XBAwlhceBmk44P75+pLTa9jGc+LPjz/1cjPj/lkFECAWmfwKBzNyF4qxVrDN14fjz+H56xhLnufopR1u9SY2vRM5DjEX7ybd9iYHqNgsAU7Zdb2EYl+O+tN3QtynJl/vHZKPo+IQ7hWZL/FMH12h5ZXR5GtZW+AzGGyaLX31cX3/pb3pjU/e4S/l3+Mg2HbAFdhYYCnxtXD1MUqnEj8KWpSOeDglrcs7p9Itm4/f8M//hp9fjLh5AmW4AdVvOcDQbWd9wdKXh38U00tw/2RAZQpetcjxQDUCHy/Wud0U5g9dwrZe2sVLgHkaLte0O570nPZrnEhd7QBj6Gia6Iq4LZtbMfGws+1a1aRmZhsNjchjAEsgVvXmc4WJeWBnb9Zw3erQNAvhoQbnqhSZ9y0j1RRec3TPLHMLv/oIVfWx9TkBPBTgGiv7gpEcWunGK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(261022113327099003)(261022115727099003)(261026121527099003)(261026140227099003)(261028144727099003)(261026130827099003)(261026135527099003)(261022105027099003)(261022075727099003)(261021133027099003)(261021123027099003)(261021135927099003)(261021121427099003)(261021130227099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007)(4133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amk1Z0RlWlpGcWlWK3lBTXhGNm1uMW93YSt5SmFrQTNjaUhoUElGeG1WbUpG?=
 =?utf-8?B?VWJLckd6MktvMjBwUm9FTXEyZWpxOVU1SVp0K3pHeEZ4eGRUMGtlcWZaMDNB?=
 =?utf-8?B?UFFkNDN2TGR2NlV6NFBaY3lLRTJJcGxhOHFVZnJuQWJpa2QzS3NtU3lpbzFJ?=
 =?utf-8?B?SFdVV3hPV3ZMbE5Nc25TMTFUMVFUMHAremVjelNFY04xU3hmTGg0MUhFNHBz?=
 =?utf-8?B?MlcwZ1VsRTlORDVINmZNSmpTT0d4RkZzOEVNK2R1RzAwR0crQWo0V2t6TEo5?=
 =?utf-8?B?cVhHdXAyZVVYVkNvR2lhRWFaMi8xRWVEOVN0Mi9BVFY5Zm9ScjVUdmVtRm5r?=
 =?utf-8?B?T2oyRFM0cTVxeUt1SkFKbWdEMS9ZRStxMnprdHJTdXZNUVR1WmpsU01xVE5V?=
 =?utf-8?B?dmpYbHJsNk8yTHhhdVBnR2JLVnZmMW81TnY0c3U4cjdhR0d2cFE5QWhRYm1C?=
 =?utf-8?B?azJEckN2b1A3NnhjNWRzZHduMVBaaFNyaTZQTDhYTzhHdmV1Z28rL1VCVG9D?=
 =?utf-8?B?dG1Eeis5c21QeS9KU25NK1ZCRGxNbHN5cmIyd3htaHU5VTNrKzJiNnN5TEZp?=
 =?utf-8?B?SS94OHVkUm9ZcklsRWl6T3ZybkZlbTQ0aUhSUU5LdzNQNVJoUERpdlZ4YnEx?=
 =?utf-8?B?Rm5oY2R5eTZ3emRVUndYSnVPU291ZHg2TWFQOXZIREs0RVR1MnVMUGd3cXdB?=
 =?utf-8?B?OGQ0RkdPUjRpeS9DS1hNNmdnakpFcEVVZkY5NFNnWEgwS24zRzMvRm9USU5w?=
 =?utf-8?B?MXpwZk9meHdYVmlEdUErc21mNmdjLzZYUVFQMXpNTDc0ckhBY0FlcStjSmtx?=
 =?utf-8?B?QVhiWGQvRlF0UTRienIyTXpOajhIVFNjQUFRc0h2T05OU0czcFVDM3NpcXE4?=
 =?utf-8?B?MC9yOHEyK2dFcCswVTNQdld2RmROaHgzM0ZBNVE5dU5iQ3lRM0ZLd0JiMVBt?=
 =?utf-8?B?MEZ1ZThyZ1RBTDd1bjhlblM0WkxPMllmZGhWK3RJcEwrb2hSeEtsa2tVSFF3?=
 =?utf-8?B?WC95SFVTRkZaeFlEeFdzcWVMVDF6Wkp0NFBLYitOOU81NWpmNTkwZEM5aDRl?=
 =?utf-8?B?Zko4ek1YUWdUVGJYMktJa1ZKWlc5bFNRaWp2UTUvSEFyTktFRnNPbUFZZXVD?=
 =?utf-8?B?YW5udGJWUWRFY2RKcUxFMW1vM2NGVDQ4TG43UnhNWWhQL0JkRWZPL2liamwz?=
 =?utf-8?B?UWJDT3BNbkNvZEJWRW14TmVSUFUrUHpLT0lFUEZjZUYzVFBSaGJNaXpOQVN4?=
 =?utf-8?B?RUJ6dm1nKyt1NitxWjh3MTlUOEdKbDJkb0pzLzhYQWMyclBrbDY1cis1RTM3?=
 =?utf-8?B?ZUsyem92OERXSUl6dWtnQmVzc3pSdEV4cSt1ZnR6ZFFTQ1NmWFYvS3k4UEtE?=
 =?utf-8?B?cjR3V3VTOXM3RmtvVkdMbCsraHBzd0lESzU3R0VtNXJxU21TYkpMKy90Lys5?=
 =?utf-8?B?SzBsLzFVZ2w5SUhEQ3Bpb1FRa1NKR2FINTN1cWNkNHh0UndJQVJWaVlQVjBP?=
 =?utf-8?B?aHNXMmI1bU4yK1djV0dZbDFpNmcxbHlmbXBlV2Ird1V4WWN5cS9GSkU2cGp1?=
 =?utf-8?B?TmZxRDR3TStpVTYrOUdQcnJDTXl5Nk9xVmNRVGtaeE41TUt3Z1BXODVJOXZP?=
 =?utf-8?B?K29Yb0Z3Z3RDbVFJU3lCYVB4ZTczUndFdXVMYXIyc3BKK240TFBEQ3YwODND?=
 =?utf-8?B?dEc4ei9BbGtZbldiRlZnd1JEQzczMFVNN2d4NlBJQnVOTGFsTlAwK1ZYSzJp?=
 =?utf-8?B?SjIxbFp4bEJrZjJiWUFvVkp5TEZxek4rd0c0eTcvVXh2V0hLL256YzNpRzY3?=
 =?utf-8?B?MU5HV3g4Vjcrb2wzSllkaGEvRWtrdTJIZ25Od1djcjd1aXhFZzMzL0pyeGY3?=
 =?utf-8?B?Q0I3Zkk3OXhKeWpieGZuVjFjSUZIQjJmek1YclYrYTBFWTNudXpyN1REWk1C?=
 =?utf-8?B?SmZFMk9YWWxYTjlMZVZCYzNJZUR6ZzlPVmhUQlFNZDR3emdjWm4rYUtUTVZa?=
 =?utf-8?B?NE1yMjBKa1dyTEZJNEVHWWJqZmpjanR1T0N5T1JPMzlrY0E4eHNZbFUxcFRt?=
 =?utf-8?B?d2x6RGVrVjVuSEdmVXR3Zi9QY0luTEJhSEcwL1h0SERVZDk2UWFnaWpTd1F1?=
 =?utf-8?B?T3d3OU5kM2NVajlLUlk2QUxWTVpCUWl0bjA2NEZKS240RjlMaXovTld1emN3?=
 =?utf-8?B?Y0NNSTRPYTB0bzZlVGJLN2R5Um5MUjlhVHVoWmd2VHR1UnNyWVZQbnU3U0Js?=
 =?utf-8?B?N2Z0Rkh0aTQxdmFRcjNhaVNGL3I5WXNsYVJkZkJJYjhzM0VaZjJ5aExEMmhj?=
 =?utf-8?B?YkpaQkxXcGFjQVl3ckxPSmg4UE40L1gyaG1haDZVdWwrNW1qK05nUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0615e342-3872-4154-165a-08df494e730e
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 10:42:19.8772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 243Hm0rQwROkVut9OQlAqLzmYGxBMe6KPiONT6+rk+RnwiIOvxtKOfoML8OmatAIddcgMQo1FuxhqgEAJdwCmC8OdpJS1C11V+zI9BTYI80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11482
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/22/26 9:47 PM, Vencislav Atanasov wrote:
> Hi Quentin,
> 
>> On 18 Nov 2026, at 18:05, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Vencislav,
>>
>> suggestion: reword so it's not that specific
>>
>> I've met people who struggle to use GMail, Proton or their corporate mail server, to contribute to mailing list-based projects. I think something more generic would maybe help them understand the web endpoint is the solution to their problems and that's accessible regardless of your mail server. I also don't think it matters much *how* it's broken (though indeed people may still be using AWS SES with broken cover letters unknowingly). I can suggest:
>>
>> """
>> * If sending patches through your mail server is broken, doesn't work at all or is not possible, consider using b4's web endpoint[1]. It will allow you to send patches without using your mail server. GMail, Proton Mail, Amazon Web Services Simple E-mail Service (AWS SES)[2] and various corporate servers are known to be particularly broken.
>> """
>>
>> What do you think?
>>
> 
> I've tested sending an email with a specific Message-ID using GMail's SMTP service using cURL, and the Message ID was unchanged, unlike AWS SES. I also signed up for Proton Mail, but SMTP is a paid feature so I was unable to test it. If you have a complaint from someone who is using Proton Mail and their Message ID header gets replaced, please share a link to the message. Thanks.
> 

I didn't say it was Message-ID related :)

For GMail, there are plenty of issues, not necessarily related to 
sending. 
https://b4.docs.kernel.org/en/latest/config.html#term-b4.attestation-check-dkim 
for the attestation part. See korgalore 
https://people.kernel.org/monsieuricon/tracking-kernel-development-with-korgalore 
for how things are messed up. See 
https://social.kernel.org/search?query=gmail for some examples of 
Konstantin cursing GMail.

For ProtonMail, it's related to the SMTP service only being available to 
paid tier users, c.f. 
https://lore.kernel.org/u-boot/wZ90PLwVcDDHWjgk7robBmaw1YmdSxF2l4qP0CirT50SG0pcnFMha3Ahz00Hzo_ZyZd5DGXiVDruI_ic8UhKYUIlRcDyCCy8LrH0ZtulEnY=@proton.me/

> 
>> question: is the attestation necessary for sending over the web endpoint?
>>
>> If so, then we should point at https://b4.docs.kernel.org/en/latest/contributor/send.html#authenticating-with-the-web-submission-endpoint instead I think?
> 
> I've already done the attestation because the b4 setup instructions that I was following when I submitted my patches over SMTP already included patatt key generation. Later I found out that it wasn't required when submitting patches over SMTP. So I can't really tell, since I already validated my e-mail address at the b4 relay. The link you shared appears to imply that attestation is required for the web endpoint, so I'll include it instead.
> 

I don't have it set up (though I don't use the web endpoint), and need 
to call b4 send --no-sign for it to work without an attestation. Was 
wondering if it was an option for submission via the endpoint (I'm 
suspecting, it's a requirement to have it considering Konstantin really 
want people to use it).

Cheers,
Quentin
