Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B18606A32F
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 17:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SssN6Xjv;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=iFWgKo2r
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B882E40D5C;
	Thu, 19 Nov 2026 17:24:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cwE61974HoRn; Thu, 19 Nov 2026 17:24:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 23C1640D11
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795109099;
	b=LDMPt6SUgqC/lZYidp7juw0ZnVq41KtkdNVE1xZOcP4fz+BEeOmLtqWHwJC20Hbfo9aS
	 XgdJPzknayD3s4n26fUYloWcMaMoU1VGQRI1EP1UCts+5K+TqyOreCRFr9usyOvhbgQGV
	 JxFTcuvg9ZYSB37Y8YdKKaRJJ9nPr1210HULL+kiA1ALXhIZ8McibP2wcNyvM4OoigFAq
	 bC+07IhALw9fie4uH6WXJPsOwvmgvyl/F0PUOiQat9M4iAAmdPsbEHp2HVtxAtvBaN8Ur
	 s0xuxlYwFjOIaHGxd2UxoOsU0HbHjSdp2Tf6BYCsMZ/Iuc75xG5mmlhrSOxjGu9ej0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795109099;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EmiLEcGyL82424qeLD7NUYh+FdJCB/UR4b31ZhmvicM=;
	b=BMTNHw8o+WJIacgTaV3yOz/W3W7E4OGThT1nMx6RWB/HrPm9xxKUvigR51NjVVRFg6BA
	 UG8vow4OnFD49/xxOORQBixWiIFkOEfClhdXne1tT952h0447ZrHmbTOfCCRBbCnRIrvf
	 G8jpMTPf2IpwIgWaOb9bBM31nWFyvxk6bJBCnOJA3HDiSdIqEamJHkvo7xBWM0Og5YKfM
	 Fp1OmtdTnFYQLWVpQ8MXMe46x0InLgbJvSm23m2BzAdoiF24kjf24KbfNBFBFnhw9+/+S
	 WpynU5IyRNhwkMHieDJK0tuTNofVsJcNu6zFEHeOixSs4TuomqtYndw79PEyVwpYK2w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795109099;
	bh=EmiLEcGyL82424qeLD7NUYh+FdJCB/UR4b31ZhmvicM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SssN6XjvozB7iW4EwvZxLEyz86xGo2fTB6Fl8203ieOomIqfDcwU4nGc6f7cdBpeo
	 lSrd9ScPbedZe5EpWeeK0yYDKtUNXtJZ0VnnHbOltn/q8NxEqwiYRk04kEC09JmXFJ
	 TKeL0+Xl26OtBqMBL/JDwW9BYs1lPA885CJqhv2sIIX24Zs1HbN0WlrGJ4/g1d0pN6
	 r1GLW7iDzyrUx05UGDk6TRB3QYjFWZNNf4cn13kEt8FaTvWncGMPKwNIqFAK5WuMks
	 Fq1I7j3Pzc38QEJnbWXfL6iBKyrcTIsP6X49BmCHAVfofnrINBvea8tnAv0447J1qa
	 0WoNcY47JIGpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23C1640D11;
	Thu, 19 Nov 2026 17:24:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C2ED2F1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2974D60D98
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:24:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 15F278PEZDG8 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 17:24:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 53FEE60D5C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=iFWgKo2r
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 53FEE60D5C
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 17:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmiLEcGyL82424qeLD7NUYh+FdJCB/UR4b31ZhmvicM=;
 b=iFWgKo2rqQ0o40X0SH05qAjPNOVdJJRUuUtWSlaXJLCYHhs2MJ8pmt4QhhTfWENyVG3kRr3bxQ3FZGcHeaQLfoWn/54oIiUAWJHfidGxIr/1KRTBLMtOAYlmozSc9T9y4iHX0m4qqW7riXAYrncQ+of8AskY0DPKRN1biDrArWw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB7751.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 17:24:53 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 17:24:52 +0000
Message-ID: <1f3647e7-fb53-4580-b3e1-c13c2a7d5e3c@cherry.de>
Date: Thu, 19 Nov 2026 18:24:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/15] test: Fix test_basic file system tests
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 u-boot@lists.u-boot-project.org, Kory Maincent <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@nabladev.com>
References: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
 <20261116-qcheck_fix-v3-14-b6cf7e96944b@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261116-qcheck_fix-v3-14-b6cf7e96944b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI6PEPF0000020D.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8cb) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6338f3-8cd1-4719-0d49-08df46620581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|10070799003|1800799024|18002099003|22082099003|4143699003|56012099006|11063799006|261026121527099003|10067099003|261102123227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: iQX4V0fBGKmj/9/1nJ+C6l0Grp/dgsMpXLInBiiB2VEwW6Jhx6OyPMdH2viQdqb2MS5fdHsDinkJPiC3GiSrkGiy49XoLxt/RPd9o3fqOT8gFWryLJmeWNxz5/gQaZ75FHQ/kJISEN+6CZnmEKiSisfSI2UaggNPtUWh+s/BiXXe8KsxUJYTF1beeXNBKEFplj2vksDCF0ffgJLYkxgbhOibrjJtJqrAaPXiQ+8L6TKzGD0L+ew9G0lr6fkyE4W5cQYgbzZwkNa6TsNGm4uSKodSO7y/aeRPt78f/bTpIHd8flLdUNXpDfjpXHduDKDAi5ushtS5EUjhsWO7OGSNu3NCXGLmaLaWLLe9N/mCTv8zhHaf42sZfDtipeFqys8n0Q+rL4NVYVr6fKLl2M7L4igxxgq8zs1cAZonX+mnChBgk3pVrks0VlfPxbYxs++tbvTX91YnD0w6Tuyids7wwi1y3Fe9UgPQju09qELKITdrhxMrRVBVqgwF9YYqJwsaCQ8E0rf9pQ5gklwF5TJMm5BI5fFYAlf1HSy2bJpVKm+52ECc1/RkwkfKOyFbRz4V6g6bOKyF0ig+wVLs2EvOlI/GUfRfk1WbH0eL5s2R7iPHdhneWC8u+B8yRU7NPwOW2gnbpIKdkYeh27gmn+LKtpucwywoL8dC7X22qkFgurk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(10070799003)(1800799024)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(10067099003)(261102123227099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmpSRWoxNnhNbGZObTRPTGQyaE9malJ3M1lWOXVLUmhPQnRTT0Y2cHRDU1E2?=
 =?utf-8?B?RTIyVnFOUWlJRnBCaE9DTlBTMnd0TCs3MU4xZkVjb09lbXM1YVZKYTRQaUgr?=
 =?utf-8?B?cDhxQUc1cFRCbHc3SDlWbW43RzVydUc4UGMyb2pJbXhhR2g3dDY5cXZDR1B3?=
 =?utf-8?B?ZEZqZFNwYmxab2VPTjViV2NiSWpwVkhHWVk5cGNzUWhuL29GQTU1aThiVnNa?=
 =?utf-8?B?S21GYThTQy9tVXg2dEk1VGRWeGN6TkxxZUQ0RWZMNzAvaDBpTUx1NU1jV0xB?=
 =?utf-8?B?WDArYUh1NXkrb01Nc2Q5NlpDNUUzSkpJQzh3VEV3UndoTmQ0eW9nQWZCUXpD?=
 =?utf-8?B?SysrTm10N1dyZ1JTdXZ6VDB4VzNxUitRaFUyWmpHR3JLSGNqdzZxRlpTUjdj?=
 =?utf-8?B?S1g3MkpPZ2xKMHB1ajgvMTY1U29xUTRWcFVPZVh5a040elZNMXdqMDVmZ2My?=
 =?utf-8?B?ajNyNXU4SXc2K24rL1lZS3VJUG9zVml4NEs4MnVtaHlyQ3FtSGEvZ0tpVkFu?=
 =?utf-8?B?Vy9BeXgzVEFuUG5TUEZvOGR4aDUxSnhoSFgrSGJ3cnFvMFdUR0NkVU1SRmZs?=
 =?utf-8?B?ZnBseWU3YlhvbEhEWkg2bDdlVklhWFRqRHQ4ajFLTFpaZDNxVXN3YUN4Vjhv?=
 =?utf-8?B?bE9BcDJWeVBkcUdkWEU2ZXUzeFA3V2dKdys2NXNGNGd5Z0ROdUIwMXY3c1Rp?=
 =?utf-8?B?b2EyMm9KNCs1NDBka0RnTG5oaVVCTEV6SG81ditVdk9CekxwenZzdkQrcm91?=
 =?utf-8?B?MjZ3V2ZOSnFyYkdXNWRsSHI3L1dSTm1TcFM1bHYxRzFPTk1qV0VUSnFVTUpC?=
 =?utf-8?B?OTg2RzhYbmRWTnluckRiUmNsc0x1anZwK1A1V0pWc28zRldLb1MvMmY4aWVL?=
 =?utf-8?B?VFRKWjJKUGdJRDllUjBSclNUTFJQK0N3T0xsVmxHZ1pnc2JnODFHbFNZNUg3?=
 =?utf-8?B?VDlCcUZCYm9FUGJHTUp0OE51WkE5UnVOUFhObmtBYzBzRnpLN2QwbkFZNDla?=
 =?utf-8?B?OE9ZendMNjFlMVNHR2QzSm5ZVHcvS3hNM2lUY2RjNVJpR2cxNVIvYzVTMG5x?=
 =?utf-8?B?TEYwRkcwbkt1bEJWSUs5ODdkT0djeXdJK1hCYXRENXdwcnl1Z2lWcDJwZGE5?=
 =?utf-8?B?RjRrWDVpUURWTjF2T2VIT3JxTEkwZ09vTlVqUFFLSnlzOXcwT3NiekorOXM4?=
 =?utf-8?B?QVowOHFrK2VqRVloRHVTWUhrVHpvekFWNXRlQ1o0VlhmZXc0NUFKd3FrNDRk?=
 =?utf-8?B?MW5CYW1zQ3N3VmVvdHcyVzVCWGJyVmZxdnVDdW1tRjBDVHBEMFQ1TGpnNm9X?=
 =?utf-8?B?a1EvU2xjOS9lM3l0NHdEYW9ldlNNWThlbTZUdjU5S2VUdDUvOFNtVGEyYkZx?=
 =?utf-8?B?TDVBN25Zaldydkl4Q0hUa1J3WU9CZDVudjIyaUVLeURuTTZNOVBaNmtqZ1ZT?=
 =?utf-8?B?b0NFS0JTWlRRdldZUDA4Y3cxV3AySFVZUGUvUlNxUmtBendOcnBVZnVvMnEw?=
 =?utf-8?B?SkpCK3IzT2Z0RUVKeXlVcFdNRnU3N3A3OTRBcm1YOWg3SU1CNVBRNFUvaS8x?=
 =?utf-8?B?bnRsZjZPeTRsb0RQalVBcGgrVEZ5TEpMMXZvT05naU40NWhiekErL3V4b2Ey?=
 =?utf-8?B?OXlzM1NvQUEvKzFKYWJJMzVyVGh0MVhPOVFwcHZ6TXFTNitNTzVucTRUVEdj?=
 =?utf-8?B?OFcxWjZPRDkvbzZGMjdKYnpDaDQ2SWhvalFMbHR1NW5xNktXenR5SjJKbWRH?=
 =?utf-8?B?WU1Id0Z0SGllbFdVR1o4bE9oQng2S0EzQzJIcktYUnhPbFpBemswOGoycEU2?=
 =?utf-8?B?NmU5Y1RHQWRPbXlBTnI4TXhKak8ya1prY0xobXE4N2xuR293TkNaWUMraXZD?=
 =?utf-8?B?WEpGK0FyTlo5alo1dmt2ckZlNkc2cjNXSVhEMjBXU1RDVWplUllTcWNQa29Y?=
 =?utf-8?B?TTBKV1pJVVh6UDlwZFJwK3JqTW5FU3NPUy9iek1DTzY1TlFuMkk1ZkNMODJq?=
 =?utf-8?B?WnpMVFJiaW9qMFhoclo1RXJldE5SaS9BNGRqQjZJSkpJQWNMczd4N0NzcVhX?=
 =?utf-8?B?V2E0L21hMzFscTlSOE44Q0tuZktBeUU5VTJ2RDE0eG5BL0VJSjNFbWdzejVZ?=
 =?utf-8?B?VitaMnNWeVpIRXBsODVEdEdFVEhuemlUTnFYcEFlQjMzVElIcGNKb3FuL3Ni?=
 =?utf-8?B?OXZWN0hvYWl3VVRqQnJyWEwrYzd6WTNsemMzQzNtK0tETFRxcHdDVjJwNlV0?=
 =?utf-8?B?ZWpyMUsvUmllUEk5aWd4ZDU3ZXRzWVJ1UENLSlNSd3d1d2JteU56WHhLbVJO?=
 =?utf-8?B?UTNVSTE0MWM4TGpHcGdjVFlRcGVnZHdBRFowaGY0SWI2M3NTamVrbS9kc0Zo?=
 =?utf-8?Q?Ler8SKw9gYZcX3Ih94gAJmAwIs7DkhpvC7borMtrKXdbf?=
X-MS-Exchange-AntiSpam-MessageData-1: CWEzc2k0+I+SLZlXI9gWrNiVjTbXxoO1T44=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6338f3-8cd1-4719-0d49-08df46620581
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:24:52.5114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCITRhAalrVKB/Ffr/sNefJAYaEMo7jDtrkx6wuDzgJjQYyB68MjANTW+usOBgzKdrovFMR75sfehQYKfVv13CLeVobQrfk4B76Vq4lFpk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7751
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

Hi Andrew,

On 11/16/26 11:59 AM, Andrew Goodbody wrote:
> Ensure that /sbin is on the path so that distributions that do not have
> it will still be able to successfully run these tests that need fsck.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
