Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B62E776CB
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 23:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC46F87120;
	Tue,  3 Oct 2023 01:37:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="QlLVoU6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A776286D80; Tue,  3 Oct 2023 01:37:23 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20719.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::719])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10A4586D5A
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 01:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B94LLbzindERiNTTeJNrSbnBk6qXXPM38FwZseqb8ESWkiq1J5h22s69O83+R1zJJHEqayP/xfN2vkTa6l6pdDc5Jv76ceLk8dOQwffQV4XqH2jYNq0kV5Y4KRZjyh4urM6s84UcTihHY31T33JqQwDNcoW2Jjhfz0If50ig5rHG/T8fQPQpJtAVW/ciJAXcZslz2V4TgvC3mU35x3CW932h7tRD/Q62Sq+AMw+9AY4oOZ5GZXToTNqtV4XgCzOON3eTNBh0gmutPIaxaaC9I0rcq6YknmgyoZmiqvycqWI5nGkv8GJkKf60dpexzkfE7QcC5JhSOB4Zhc61dTNTuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAmoqlYxPHOry3nVJML2xdSIE9l68tcsp19vizsktnA=;
 b=ib9qV8DttGKACNk5aVq3t27ZEuWxPB6Q+nW93+D6gFrkcP2sMNfJHn8Nx2RJnafDfCWQXq+4Yri2IaHqE0A1eI0VdizvyX3ON0TDPWLEWRAA10S6fTRfHMQhiOU/5Msfd9gJBFbucIXKEFuLdizqQF6e/FEUcFExE8A+83g/5n7PNof7RiqY1wxU2JEdJZdMnOZt1JNH3uziVmz4zDwTHljUV2XpnVcPvLvcVUOy3bYnOxCr4AVYtBxBv6tAajt9OKxL4PF0DAYvyCjxHJE5yShjwj/CCpKnsuP360li9RxVTAN32uUzP/UWd0m4NxoByf3I3KNITq8SL98KQAz4gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAmoqlYxPHOry3nVJML2xdSIE9l68tcsp19vizsktnA=;
 b=QlLVoU6cdXGtniNgrxmrqwrAFy8NAWzdzatTW72rj6Jbd4QR5jkWZTzvG07mrbNJX26QQZZAzRTuzg1mWmG86VFnGc7l2pIoTMOGuYkbJmYYX5WL4vY1zKoG1TsSxgf+7sT6hpVxHiRTeNe7Pm6c1qfCbe9KBTb4a/4qmdx1PAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB7760.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Mon, 2 Oct
 2023 23:37:18 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6838.033; Mon, 2 Oct 2023
 23:37:17 +0000
Message-ID: <beb3e0aa-a72d-a4dc-4fed-3c2e0453e9f0@prevas.dk>
Date: Tue, 3 Oct 2023 01:37:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/1] input: avoid NULL dereference
Content-Language: en-US, da
To: Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@google.com>, u-boot@lists.denx.de
References: <20231002222725.25125-1-heinrich.schuchardt@canonical.com>
 <20231002224641.GB8465@bill-the-cat>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20231002224641.GB8465@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0025.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::16) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 0470a230-7196-47a0-dbd4-08dbc3a0834c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6+tcv6Okg27hzFsQxH5hnpnoF+eW1ghTDvDY+Hxbuk4STSM2dloSJPQtWoV40aC6kylLywThgYwk3l/Gq/CqFP/SmsQiDp+DRnwnJkmFdoMiuHaK/l0ZOdkozXvAe9xRCT8e4pN+pURtdenBh9xKjpG8akmduxbK7qVxdeb5UG40dq6nA/64a3o1MkIM3vKQPaWNhL7Zc2T5nQmaBsf9vjcO8reKBxBuz8ikLOTC7BGNlH5Zm5E7FRV6xgVthFJ/XxUCIB/Uj9e7eCBllcjn3+0aMYtcbbd1d0w793V8HzBR0ydakEO6kav52jpHzcrcSFMxE7Bja5iHi5ThmTf0BTpFgAVBFgeXBLDRHGXbQXGubsH5HQ00aRkgg6rAWyWM6rNJjq9RiKa4VuF+AQBR7bXflGMYAw/0XRHp4PLC7TjlS2JtsL7bOuHG3lul82Oipkaj7j0BIKNNSPHlvrB2pkW9Dmf5qtIDO2zgoAhazCSOzsOGIJqGDC7piCq1IGXX7NMJdjdj/cAXxaA9VjhTOPCwOlhEolZGdPtoVnJsyeLLXKAm2vErN74NJO8GtRLBGfhkHExfMyGvZx/SDSOBDUvpoMUAbH5pti10fG46TmR+gr0tpj3TyEfilhZNIcu0l81KLsLNRikFSAnd8ghO93fDKgiTNAyl+SqJ19EotulBrFrLsfjPp5jil0qP4tgC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(396003)(366004)(376002)(39850400004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(36756003)(31696002)(86362001)(31686004)(6486002)(6666004)(66476007)(52116002)(4326008)(66946007)(110136005)(6506007)(8976002)(8936002)(478600001)(26005)(316002)(2616005)(5660300002)(41300700001)(8676002)(66556008)(44832011)(2906002)(6512007)(38350700002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTgxUWR0VkliYTRENzJZbjFOQVhlcVE1MUUrYytwUng0WmxscUFLazJxL1pt?=
 =?utf-8?B?NTVxcytjZ0dXcW5sdGpZSG9BcXc1M09xSmx1ODlpcEFaVmQ5bjJsM005emJN?=
 =?utf-8?B?UWZ5ZXZzRzFYN0RWc2JxRE8vQUMvK1FPMnQvaWxhOGE0OGFDcXpLeUhBQkgr?=
 =?utf-8?B?ZkNFMVFQREVlRTgwbFc5bllTZGFteHB4VURIb3E3RHlMeS9oR3ZvSHNIUzZy?=
 =?utf-8?B?UkhKMnFITHJaWUtIdnhEdUpMNkRYQmJxZDJ5TkF5M25PWFFhdWVCRDZVV0NZ?=
 =?utf-8?B?MXVqNlBpTzlFOFg0cE9DaU5peUMwak13YzV3RHNzaGJYZ24zYU5KS1duTnV0?=
 =?utf-8?B?aXJKTTRaSkZpUzdxVG01NTY0aktseFpmTFlPZS9MZkFLcWFJR1RpS2tEZytL?=
 =?utf-8?B?SzcySE5iczY2K2tMcExQRWpjZURxYmlhRHRzSDdxUXdYZHk4UGdINHFrSElu?=
 =?utf-8?B?NUxwTFFwdkZ2a09rS2ZMS3N4QzFNTjRoUzdPNE1KQWJyMmhyeTg4anpLWGFO?=
 =?utf-8?B?dTZJQWtXcXpsUVl5UlREbG5UNDdHditIUDNqY2s4eGtDeVlUSHNVYnp6bVRi?=
 =?utf-8?B?azJDRjAzMnBpNStwL3lTc2FpNlVCTS84TjE1bmg0YXJtM09DNk9DdmcwQzg2?=
 =?utf-8?B?bDFMU0F2Slk4Zk9YUm10Qlc5TjVMR29yUlVUYjVVSUdOYWFJOFYyUmd2RlRE?=
 =?utf-8?B?bjJSN3BPMHd1Q01lVmxTSWc1dHNtVHRKQ1hENlVYSnZVZDVzVWZlYklnVTZu?=
 =?utf-8?B?YldaRWVnUzJ1OHZ5b3J0aERGRWNPUmVqSkVZUU5EMVZRRTRpNExiaVZLT0RV?=
 =?utf-8?B?RzhLL1U2a3VhWnlxNmxzUi9IRkMxa2NhMmJpbFBBOVlkN1J4K3Bob0dsWENX?=
 =?utf-8?B?OGh4dGttaTFMWXpyOVRqTW1rZ0JxNjJkbzJCUFR5cTE2bFhRcDZDYy9Da3lz?=
 =?utf-8?B?Tk85bkdrRVhuVFVlY2pBdXhKVVJML3ZOdTM1UDVoWUtxUk5aVjBnVmVvL1JJ?=
 =?utf-8?B?RlhyZVRidlRSZERVOG1jU3Q4Y3RnMXR4R3VxVWRJVG1Rd0ZGdmsyZk4rcml6?=
 =?utf-8?B?WkdEb1draHY5TDhCeFU0Y0RRcmlJMUxiY3I0YzlpeTNwajNlZjZBMENlZG16?=
 =?utf-8?B?eDRXQnMrZjlpeWRqczZrU3Fvb0tleS9UYkJpdlZUeGlpQ1VlSVRtdmZBVjZL?=
 =?utf-8?B?S2IrbkFodUJxQUJnb0RSTGhnSUgwM1Rmdlg3NW1FQkdscy9QRUJKTDl4UFFF?=
 =?utf-8?B?dzl6TlRidzZRMTVhRjJUcTUwS0tVcEtISEIvN09QRUplTHVQVUEzcWpBMThV?=
 =?utf-8?B?dEs3Ri9tb1Zxb29qb1BLY2pUNU5Rd25iNytPYldmUGdLZXI1VzFBOTR2UTF3?=
 =?utf-8?B?dzg1ZTdMTlFoY2VKWU9xY0Mrb2ZRRytnVEhBTlNmb0Q1dXJXMzE5b2FqM01I?=
 =?utf-8?B?UUQzNkRWcmR0d2RiaVR0Nm9HZjRjRTRzclN2bDFXaGRZK1ZzRERmN1pzTHlX?=
 =?utf-8?B?MCtGT0w1OEMzckNUNGpiS1pqdm84UzZseTI4NmtscW9NbVAxSnJWaGFuMnlZ?=
 =?utf-8?B?K0pLbTdDNW5ROWNVNWVYM0RnZkxFdHpJbnBPMVltckhSWnp3S3VWdFdDUFFa?=
 =?utf-8?B?c2RGVGdkK3I1RUxBcFc1SmdWSVZ5bUREd09sbDlwMTBNY2Y0c1FURnJRaVpN?=
 =?utf-8?B?Z3BaYW5nc3drMExGQ2htcGNjakFDUlUxTzZmelpKQkxja2lFeHRXeTZPM0Fk?=
 =?utf-8?B?SjVlTXBPV0tnWEg4UWR4WFdUbnRLaEh3Z2tZVlFBWEhqSktnSE8yKzV1ZW5l?=
 =?utf-8?B?K2IzOURHajFuZGxwYk1iNGVPd1R2LzRQdHliOVFpeTBqUElpdStJWVFwRllh?=
 =?utf-8?B?b0ZHcW9jSnJFWVFqWDRyc3hvK1JmTWF5bVNFUGhMeld3dzRTb0Y5dVppM1BI?=
 =?utf-8?B?NnNwRHhXVXRUbzJyc1ZWSE5DeTNId2oyMFI5RlZLSzVoMkFvemRaZE8vL244?=
 =?utf-8?B?RCtYV0ZjQzZjcWQxWUdRcHNNOEpkTzlMVUZqYm1YVjNVUnY4QVB4VDBzN3Fy?=
 =?utf-8?B?SjZ6ckpvaVN5WmxKRlVyWmczallaZ0xRVE12Z25ZQ0ZVSCtCQ0M5dncrSlFo?=
 =?utf-8?B?QkZ6NGxSZTdXR1l3cThKempnL1FGUWFGdnM1RDlNLzF6bWgvMlpYYzk2ODlq?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 0470a230-7196-47a0-dbd4-08dbc3a0834c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 23:37:17.1263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLT2CdSByLntyKwqlpPYZ84tR2Fai4WIqJYG24b/S9SdBhaIfCSvhFGSOw4NsvpXeG/Ykpo3gwPS23BrmsdRilXZ/kv++M79SOh6uz9+9G0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7760
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 03/10/2023 00.46, Tom Rini wrote:
> On Tue, Oct 03, 2023 at 12:27:25AM +0200, Heinrich Schuchardt wrote:
>>  
>>  	error = stdio_register(dev);
>> -#if !defined(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(ENV_SUPPORT)
>> -	/* check if this is the standard input device */
>> -	if (!error && strcmp(env_get("stdin"), dev->name) == 0) {
>> -		/* reassign the console */
>> -		if (OVERWRITE_CONSOLE ||
>> -				console_assign(stdin, dev->name))
>> -			return -1;
>> +	if ((IS_ENABLED(SPL_BUILD) || CONFIG_IS_ENABLED(ENV_SUPPORT)) &&
>> +	    !error) {
>> +		const char *cstdin;
>> +
>> +		/* check if this is the standard input device */
>> +		cstdin = env_get("stdin");
>> +		if (cstdin && !strcmp(cstdin, dev->name)) {
>> +			/* reassign the console */
>> +			if (OVERWRITE_CONSOLE ||
>> +			    console_assign(stdin, dev->name))
>> +				return -1;
>> +		}
>>  	}
>> -#else
>> -	error = error;
>> -#endif
>>  
>>  	return 0;
>>  }
> 
> This is an example I think of where #if is more readable.
> 

I kind of agree, but at the same time, this could just be rewritten to
avoid that extra indentation. Turn the condition around and make it an
early return, then the rest of the function need not be indented.

I also think the conversion above is buggy (loses a ! on the SPL part),
but also, the condition is needlessly convoluted to begin with.
!defined(CONFIG_SPL_BUILD) implies ENV_SUPPORT, so the condition is
equivalent to just CONFIG_IS_ENABLED(ENV_SUPPORT). So I'd add a

  if (!CONFIG_IS_ENABLED(ENV_SUPPORT)
    return 0;

Rasmus

