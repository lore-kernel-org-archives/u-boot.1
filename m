Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4820E606AA2C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yalkkAfR;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=EkhluxRb
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21FEA4094C;
	Tue, 10 Nov 2026 14:53:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jvKYdFwh6mej; Tue, 10 Nov 2026 14:53:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6398B40874
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794322425;
	b=mVnGQ55HDNn6ovXyop/bI9CEGZWvuo/l3kmNRMk8vf4EbIlxyB9ChY5ptd3C/Sk39QXK
	 yO0i7xk5FW7NLEAAg/LmD0ICFpUme/IY4s2Cm5yrZSVhLf+mxl1idKBPzt+kI5PlBoyYX
	 hUZz3MkEKMoJ0rzjIdF4OASoS25ZoiiYa9UXolLmmhy4o2xekEXEW6GC7hdERNQtNiRDK
	 FzqluA0800JfgwtQbqV3NXJoH+/8+vbO60PN/PndjQrPtt80CXRUU7bQgnXbFTy9qwSI7
	 u6jPywK8YGOZ38f2SKtTd2519FT/Q0G21i4Vlx6s+5lHQlAwhnJNlowBv/7U56FSNhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794322425;
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
	bh=UXOEiM/50egL18b1fEfdTLHuvekNYTPqLsOx+pC8HeU=;
	b=pSKSsFe0xqL8SObJu1XhICJ6gMclo5y/iD3D6+7CSp59lYVJt/EUyuYR6yrpXYdYbZh5
	 DzvNi1+feV0PWSco1UAdJnduD45iPTj3ZGHgwHv1Tu8oeSxivA4MUOa7uzyDAie9L+VAW
	 z4xE3UNngoiab9SBDN5+nabeiMfeESNyJdQ4G/BW0VFOs2BP9AxZPraKKi/R3LHgmD3cw
	 osHXZYf8T7D9C1Cvu2G58suwS07nwGMEuj5rfKOf3wUsTQDzJmC1507smonZeP9JgpLvS
	 BbKfPwuvx/Mf0yxKIb6ZO34Wvlzgj7f2sNtQWZP33Vrwe3b3Aq8Q0lM31W2y7x/jR1Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794322425;
	bh=UXOEiM/50egL18b1fEfdTLHuvekNYTPqLsOx+pC8HeU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yalkkAfRe4w5GmDgTIVfiL3CvRXmAdExyMoHGRKssvCb+5rkxXO4im+hwKD2wX3N8
	 ++nPTplTbgY2wKPPihnlln1POC9xjzOMns0B9WhEyzv3Egf3P/WjP91A8hT7XtKrB1
	 aKhihk56lf9eo30Rw5B4ykywDk0K9vPAA4lyifqsoGLKG+s476hHRXemCXfo8ibsUj
	 9NsVHeT75LCP6EPX72NptFdF9zdy78BUu4flbn+t+LG0HsuBBXF4fhP2mfUnRXyW/6
	 VS5g76JasIyBNb/5WwKw1jOt2nwERjeKmP1mSmHLaW/XxspcmWWhpzor2ZYPPMSwQd
	 uexChIN4FD6qA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6398B40874;
	Tue, 10 Nov 2026 14:53:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 190FF9D1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 09E724031C
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:53:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AVoz8aIv_Mp3 for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 14:53:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2AEF24008E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=EkhluxRb
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2AEF24008E
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXOEiM/50egL18b1fEfdTLHuvekNYTPqLsOx+pC8HeU=;
 b=EkhluxRbf07moq4IRlXlbzxUbBtdqxT0T3HMioJRH7z+tFpOocO9ujihiM5HQGidzaUjqJc+0s58BGoe465u8ZmrkZRDsSAYLnckaYOR+VPDf8DBHt//jeAPV4GK5sGu4Wx91UV3YPrmjgXgWdxesrKpJp5QhErQ/SblzFz+Dew=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI0PR04MB12156.eurprd04.prod.outlook.com (2603:10a6:800:317::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 14:53:33 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 14:53:33 +0000
Message-ID: <de19036c-631e-48ad-b2c6-d0782adad6c1@cherry.de>
Date: Tue, 10 Nov 2026 15:53:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] test: Disable running event_dump test for make
 check
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
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
 <20261110-qcheck_fix-v2-6-1c76e0b68f29@linaro.org>
 <66d22487-93ea-4c21-8b7a-399f3b7d4680@cherry.de>
 <eb8c9fd0-4b28-499a-ab4b-f0c989baa2e5@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <eb8c9fd0-4b28-499a-ab4b-f0c989baa2e5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0047.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34b::7) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI0PR04MB12156:EE_
X-MS-Office365-Filtering-Correlation-Id: df239efd-20a0-4b16-bda0-08df3f3a6446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|18002099003|22082099003|6133799003|10067099003|3023799007|4143699003|11063799006|261102123227099003|56012099006|261022075727099003|261022105027099003|261021121427099003|261026140227099003|261026121527099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: tVd1YtRGJqac4HYOlNSYD0BArThNp5rbblqXRbtsEowtH8O/Y+HlC4CKG9Oavrag7JL+AnqPAKgXK01hpyXTKvNr1/37rwuJODjU1UH9IAnzMnKRmJQCN49zAkKiYow04hMjqWEe2Uj+jcbqmrrpUyvQjawTfgimnqLKtc70AcVjpFaUq9acr9UWNkpRZNR3q+I/GPg9jJL0O7FQdKGIkKgKciaFtPYII4598WompIOhTRkQp1vMDLCVeZMqvQfxvEatFRU6/T/A+bmSsGK0wQN0G+gQQlwYqLyhaugcyBfWfkCmgeXPzKUrBEUVOMs4+LIozxcuiZdZoTPj7qq9ZW6MnHsL4wOQkrCBaUdjIhpxsu35ZZHajwZ9H1hMpLad4aTWmtlNxXxZiGU7W9p+VStavF4/h7VhbyqG693NgIi20F5nrQUJXhDxLYYq3dG7W9fTicJPwyn79L0+oIYDRrzpAOy8mg3OyzoAv0A+0PsAaqEgehw++G0nxtB2X59UI70yEVGO0QR2Ar8yW+bcpSDVkKZ8mumvuRhL7YzTTPDJeGuOFl6hUgpkNzcMb93xf5S/6EfNtTkcrGyYfbyarNSvs37TXEPOiI07cXJRbrR0NhNOwChzDDFWs9zGju/SKKsp/JuEJF/kK9Re5CmsPsUleRXeibfKrkFZ0iYS08s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(4143699003)(11063799006)(261102123227099003)(56012099006)(261022075727099003)(261022105027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0N3cFExZ01tUWpxK2Z4L2FQK05OYTZKeUZNZTAyNWhWbTA2cFhnNjQvYU5k?=
 =?utf-8?B?YStMeG82dUJCckdwMEdQT0I5NDNYNE9RcDFkYk8zZE1kN09JQi9mRkh2Z1VQ?=
 =?utf-8?B?UXJqcWtORFlLWXRrdlVLR3BxTk5lVUN3a2ducjFSRklEUVlhdWIxQzN3UUV5?=
 =?utf-8?B?MzlUdFFBTjV4cVVybk5aeE1oQ2dyZmpiUWYyalpHeHdTblBjVm5SUkpKUHls?=
 =?utf-8?B?cWphS1NWaGo0ODFaK0gzQmJXaG83aE5EcEdUR2szTGg2OWlTTDBYZStsZzBw?=
 =?utf-8?B?MlFaYWgrM0hocHBuQkw5NjRJVWRrNXZtclEvMXNXMjlUVkZueGl5eUZjM0ww?=
 =?utf-8?B?V0xFZTF1ekhCZDV4SFFBcUdScjFIQ1psajJOVFllRDc3VlpJSzZpZURXUk44?=
 =?utf-8?B?ZHZuMjMxblZSaytQWVhtOHQwYVlvWCtVSjNhVlBXQmtQZ2QxaWpYdlJFbHFu?=
 =?utf-8?B?SUlBclBKTzhFM3gyZzVJcDNZbmVqcEtHNnNmQTBvTGR2WjMxQWdzM0xvcjda?=
 =?utf-8?B?SnNycVVRaFh5TVBpWStrRE1OaEJyMjl1cm1vVzVXSFZpYkEzYkk0MUx6Zmxq?=
 =?utf-8?B?SEV6VnZPWERaMmZBTWJPY01CNnlUVjVsbjg0N25QdUlNUURDZ0FHcU5xSC9M?=
 =?utf-8?B?WEUzMGVwTjVzLytZU29LQ203TWFhbnZOLzluUGpqWmlTK2JBSEltZzc4dEdE?=
 =?utf-8?B?VzFBN25YcU9Ncjdub0J0RGIrTVVaWEp5dHd0VTNvMnl5NDVwZGpYUmFrVUVZ?=
 =?utf-8?B?WWIwem9HbGxRRjlZOFJHalIxcEUzQktEQUZxeDJUOXV3UWxZUkhiamJ2bnlv?=
 =?utf-8?B?bGh1Y3RiQ2FPZmlKZHJvVTcrNzZ0VW9Od1FIdTI1b3A2WU1ocW9kZDhnUmNp?=
 =?utf-8?B?ODhBMWY1V1MyZGFtcnZpTGlSU1hUem9WSjNabG9IQ2tJMHg5UUVmNUZYNThH?=
 =?utf-8?B?KzNpanJlbTZTSEpHajdVbEphWHg2Z25RT0VyVGpWcDlWdzdtZ0krTURVVUwy?=
 =?utf-8?B?a1M2NStDOUxaNFJNZlVTOVJxM2xUUkwzVE5XL1gzdnQ5aTJmMlJTQTVMalFl?=
 =?utf-8?B?M3lqRWE1Qyt1VExhNHU0ZXZQYlVBMDI4OC9SVXBUVFYrTTBuWW12NWFjSWhD?=
 =?utf-8?B?blJMUFowSjAyd2tlQ3lCMFVHK2xxNHZJdlhyNDIwN3hyc2xFeXlac2RDVEcr?=
 =?utf-8?B?OWZ0YzA4OTNwOXBZSHlZakZmSTYyL1hLMnpwY1pCZGJnbTFjanhxeUl3bnRk?=
 =?utf-8?B?clNXM2VLRUdoQWxtOU4wQXNjamlqZytXYkxuc2RNNVI5NnFsWnZMSzY3bmVo?=
 =?utf-8?B?aVRGN24xcS9tUXBGVFd2eVNkaW8wQWRVWlNaakU0Y3BxcFFvcU1ycGtrWHNo?=
 =?utf-8?B?QVBnWUJWcHhVMzJ4aDhNNHlOVFh1ZG9DbWpJLzQxMzhVREUvUzBsbVJwOFZO?=
 =?utf-8?B?cUJOMXVtenFFUXJHamtIcm9SL25ieElXSXFnWlFoWjlpY2lFYTdNblFQWDJr?=
 =?utf-8?B?YThqVXY2WWs3a0w3eDRBU2xTQnd0R1dia095cHQzOFpmSjdPVm5NN0tkQ0M2?=
 =?utf-8?B?dkdjejNvNUNjRmFpUDgxQlJqZXdheXZmVFN0a2p4RmoreG5uMnkrS291SlJL?=
 =?utf-8?B?czF3a0lsaVJyb0FuV25qNlFPZnNnVC84VC9kUmZUK0wvZVMvVWJFSlVNZGY1?=
 =?utf-8?B?c0llQmxzeERhYzVhZlZ2WGgzYVJ6S2FRdjQ5U20xVlc5TUJBVnA4SHN4S1Vu?=
 =?utf-8?B?UCttbE1GMjhTNWlNelhVU0k5cUFibVRjcWdEUzgxbnBHbU1sVkplR3crWXNU?=
 =?utf-8?B?QU9jYlR0aVF2UkNiU09YekkzUFVPQXF4emt1dTNpVHBIWDNtcG5OaDZRcFJ2?=
 =?utf-8?B?SnhreThpNCtiWU9jRkdXYzFQR094WWJaTERZNWVTajU2c2xGQk9ZT1Y3WS9n?=
 =?utf-8?B?Qlkzc2pJN0ZubDhCRUtTc21vRU5KdityWmlGM1dXS2w2V1lleVFuUTdGQXBI?=
 =?utf-8?B?MjlYT1VIdnJHeDR4c1YrVURWUnFqMHFZR3NxQ0pjN0Z2OXN6aXV3L1l4OWgr?=
 =?utf-8?B?UmZGUkVHc2VqU0hWTUlEZ0JWTGVwdDhqV1U2VndURmgxU2pEbDNjNGp5Y1VT?=
 =?utf-8?B?Uld1TnR4b2IySTEvaXVXU2R5L3FocmxtcXVtTEN5ZGRSZmFlYm9qeU9rZU1u?=
 =?utf-8?B?bXpyTG9Pa3U2TngzejdJSHd1TXdLY01HQ1J1U3hRSEFSNmFOaURlR2pXM0Zq?=
 =?utf-8?B?UVk1aG1MTU9VdjcyYjRPV0l5cldOdlpMQ3ZOZ3JFdDZyOU0zbE8zeE9SUEJk?=
 =?utf-8?B?Z0hyN01jdS93OGswNU9VYndKeHRPaXUxSjZjZUxoaEhieFYyRkkvUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: df239efd-20a0-4b16-bda0-08df3f3a6446
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:53:33.4163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7oaNm/vp3J1rPtN2/666hZ/ah11Cxt+vkzUBbQ5YL+PU1tpFVviUSq5wOvwNx7TL0t8Al33Km6g8tqso7onDsyWkI2bKwpj2fG1JgTwzv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12156
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

On 11/10/26 3:51 PM, Andrew Goodbody wrote:
> On 10/11/2026 14:25, Quentin Schulz wrote:
>> Hi Andrew,
>>
>> On 11/10/26 1:24 PM, Andrew Goodbody wrote:
>>> The event dump script does not work on more recent versions of binutils
>>
>> Please provide the error log or something so that we get a chance to 
>> fix this in the future.
>>
>> Cheers,
>> Quentin
> 
> This is a known issue and was already addressed in CI last year.
> 
> 9420160a0d14 ("CI: Move to Ubuntu 24.04 'Noble' as the base")
> 
> The error is that in recent versions of binutils addr2line cannot get 
> the source reference for static functions. Whether the information is 
> missing from the debug data or is just a failure of addr2line is not known.
> 

Thanks, just have the output below in the commit log + your explanation 
above and we're good :)

Cheers,
Quentin
