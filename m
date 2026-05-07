Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48E5CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 13:19:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3133884A75;
	Thu,  7 May 2026 15:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Wyx+fcuN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E518584A7D; Thu,  7 May 2026 15:19:20 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8D3684A6D
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 15:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNVE8sX9oB51RnUPxe9KIWLgeC67jUn5eOQOzW5Yf2jJQ6w3tFEEvIStVU3ScjH0ap9eampqAsMf8wzpUv3hdlQEYuXGG/llgqBpVrnqlS+ZmTuTcUnRbB3NpyGNRPBFxaBg9wEGxVQy7l2F/dAqZkMyEJ0bNd4qGo5L/x6IjE7BizOECC01ZrA0Gdc8WvTXv8M7ZYCeR7LIMqQD9fbc7NDSBPqZnMmC+XRGqudxZmNDoRJea7HcVYCeWakgu0RALhcK9mN2NpV6GWGWaZ+E0q7hTphTegHlXMR6hOtXeLkqwWxj1Yz9I9T4OzbNUU+5eZTmQGEvkkM+nzTQRkGcBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyBBZG0X8QCHRLj+VXl0bUEW/V5MGj+F0y8sVPvf6Zc=;
 b=R1tHxJTbTMjzJof6t5jiis6zOlGxDjeHUwQFoLfaxdT6dEYRRHNUMYSqAzph+sERIjFDf48lXTYya0apfr1gLFNAthUQN0xHPoXhKLxblnwHX1x1O8/WkpQ1Nx1xogPeErTb6crKlvSAtKx5MGYRwYttxgKZ9LzkxUi7/4GSWYbvN6xiu+cx2ocAq5FfYLHeQxkenrVMqNR4SI48Srnwx3kvx4y/DFAW4R78ni7pexdyncUSjl5x6AbdM+gIIsR6ULRXFl6pF9kRic5EylImxM24aUqJe5uK0LL1eiF12kei5Elqj9hBPRraRXltE1+9vA0njDHwQr07Xs3Q0jRW8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyBBZG0X8QCHRLj+VXl0bUEW/V5MGj+F0y8sVPvf6Zc=;
 b=Wyx+fcuNCFuJqVFMP5S2Y5rAWHg2N73q3op8iAXGnOfrgrDo+brHFjepuw+g7jVoFXian239Qih3mx5QxsHnhbgqD9wVP5/PirfsM5rjPama3zHqDUgc7ONn6qZSoRI/9UBNxEeS6zZV7VVRWZDbQKcABielurZP9GcWbztAwAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB8296.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Thu, 7 May
 2026 13:19:15 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 13:19:15 +0000
Message-ID: <610b19bb-3282-4062-a3f5-3071c69dbedb@cherry.de>
Date: Thu, 7 May 2026 15:19:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] binman: bintool: add extra_env parameter to run_cmd
To: Simon Glass <sjg@chromium.org>
Cc: Sergio Prado <sergio.prado@e-labworks.com>, u-boot@lists.denx.de,
 trini@konsulko.com, alpernebiyasak@gmail.com, ilias.apalodimas@linaro.org,
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com,
 wolfgang.wallner@at.abb.com, bb@ti.com, y.moog@phytec.de,
 xypron.glpk@gmx.de, jerome.forissier@arm.com, afd@ti.com,
 Wojciech.Dubowik@mt.com
References: <20260423154536.768603-1-sergio.prado@e-labworks.com>
 <20260423154536.768603-2-sergio.prado@e-labworks.com>
 <491f7007-0574-4fa5-897c-59002c7dcaf6@cherry.de>
 <CAFLszThW0u0SrntCfXFi083petNmszVmSjNgXFc87a38tHyx1Q@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszThW0u0SrntCfXFi083petNmszVmSjNgXFc87a38tHyx1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0055.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::32) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0f8af1-17ec-4fd0-7b32-08deac3b3cb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: jDir1zORRicG/9JnnWkxHiOW+Y4pT/8zOnHgspeW76t1X3itusgMN+1lcbaQOdawUfAJirlOpXGsFgzdVti1wVdjZCAc9IFcqr1W3goWbI11OWA8zh717JYJnRSvz17VWRi+sb9nm3FAZ5qfUsV3O9bnPEDaqLMFE35z/I6cxeP7BvfKzXp0JDvnnTnK7evCDdDaZ7gdLu0l4Ix/KojKeuv+pSU5uiFIsaqEadEhRHeyT2Z+dhIrPBO01DzHJ7RM+M1qe7bt424NEOiUICLd9wyj4ppetfmkO0cWoeR1IxEBK5XWOWTNE8hOByYj0lf/D8G6JE6EVoitwNy6fzk2UjdeBxvtO9sRVv01z3of9uEXiPhkXg0OEaqeOlvw9u9v0KzPdgVYSG/SFZsxmlks6an6X/nq67LHmOd1hjt2ExRIVQk2NaxtVVBXhIZGCmlf+zY1CkvSoRFWElgDsmlPh3Zpc1jvxK0+5pgDbiarnabacIWttalRE9E0SBJ+3HdJAUg4y0oZY0Yrx/N5JyY79CosVQbAh1ra7ZhUcgPo6kqxITIYBSw1MUxBVgbBG/gXyFClAceMJzb1FlRYbnGv7fVKfeFPSypjj7lmAUljjfRJ2WxeugY3DF0hVIhXSwrl4YG6kCUOgO/IPZ7z6TPmVW1dW23gp9I6YPmHjCJ+IIKSDfILsJpZUpjXeWhDbk2w
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzV4Y1RlK21vb3BXWGliTXFQOFluWjh0Q25HSkQyZGU5a2JpVU9PYUgzOHVw?=
 =?utf-8?B?c1RxVlhoaVcyZ1RJRTA4M3dZa1FxVzEyZVNDTE1hM0lubzI4RndCMmFkUS85?=
 =?utf-8?B?ODE2eW11THozYVM5amdvTnFPNnZ4MFQ5YjBaUVJORDdQVE5ndzViU21RSmV0?=
 =?utf-8?B?RnhmM3QzVGl3Nk9ZWUY5U0RiWEN2K0JNbmZaYStuRU9lRjRKZzljZlVvaWRB?=
 =?utf-8?B?WUJObkthODI0WlhYYXRHNVg0NnZzczNuME10S2NQbXFFUVc2cTRrVzJ6Vkxh?=
 =?utf-8?B?cVZ2cUpEZG01L241Tk1FdEl6NnZSejJ3ZFFhQzRRMURVOFJmNFRxQUdXRWVw?=
 =?utf-8?B?elVCOFAvVURMdHN1dmZqOFk4VGVZVzhBSmxBKzc0eGYzakpreHdlS3BzaG4v?=
 =?utf-8?B?UVVGVGcwRGpIM05XT09MdUxJMUhRVkgvWlhrUU5uNnpzZ2pLR2lhY1hMTEZq?=
 =?utf-8?B?cUd2dkhCVDJ1aHZsSE9aTTRFTEdUVVZEam84c0M3YmJjRTdWL0xxZG5JWFZV?=
 =?utf-8?B?Z25DQWNIM0dDQzZ3NXRmQXY0T3o4NW9odld5SGtpU1d3RElhemV0TDMyVkFy?=
 =?utf-8?B?UmpwVGtLam9hUWoyQnUvRk4vejg1alVBWU1CSkJTWW95Y3VlbXRvNzRjNy9I?=
 =?utf-8?B?dkQzbk9CSWFPWnZHaTZNYkpLTWJlN1RvWFM2NEZqdjU1bDJ3VGNiRmJZUDBx?=
 =?utf-8?B?OTY0SWFRSHlPUXdJODZnZUxLckVBMy9oRzNwdE9oM2RHWEo1dXdzU2w0SElt?=
 =?utf-8?B?TWN5OEdHUkJSalFQcHd6RzVyUHI0dkRCWWdWR2p1MWt3NjRyZzZ4ZXpXTXhv?=
 =?utf-8?B?azVxUGtGV25oSzNXeWU2VWxrMEpBNUk5L0JLcjNPU05ubGhZK21sbEFMK2k3?=
 =?utf-8?B?QWsraGU4NW0rWFBSRzdNSnlZaG5BVURHMkZkTHoxa29vR2ptdUpYVC8ya2d1?=
 =?utf-8?B?TUkzKzVoL0RhVFJkM0NVRno2aDRmT2FKa1BMM054RW1oNEE3WUErb1FnWjdP?=
 =?utf-8?B?cnNVOTRuMitqK085Sm4wSHF0UTZycTdIRkErZHNveWxYMUdyMGJTQVAyYWsv?=
 =?utf-8?B?WDVKdmJpOUk2OURqS2FoRHVqWVFWNDA4dlBQRVRBR1dvY0lIZE1UQTU3cllE?=
 =?utf-8?B?dHYwKzJPOW92d1dFY2VkZThvd0RmRkZzTTBnTm0zNXkxalE5MGIyYWdTbEtl?=
 =?utf-8?B?VkY5WEpPWklRK093d1lZY3gwKzFXUFNrMzg1TUl0cVlpUU5RSjlzV2V1OGE2?=
 =?utf-8?B?a2pCdnZyOVFRbnFyYXl5MkdCQ3c4TUhlTS9kd2VVem1XdnFkbUZIQWprS0Zz?=
 =?utf-8?B?LzFKbmxGSGpsZTdYdExZSlhSZlJzZXFYeUh4bGdJcnB0c1N6RFdEUTlpOG1Q?=
 =?utf-8?B?NitieUc2V0ErelhlS3RCazRwdnVIREhTbkVNZE9YVmY0Y3dBNEkwWHV2Uno2?=
 =?utf-8?B?c3g4N3RKOTVPWXpXYTRFSjhySTJMY0Y0OTQ3TEZoQXdlV2lTU3ZWV0VubkNX?=
 =?utf-8?B?bHJGVHJraXhPRVZuMFhBZHBHL21CSUdpdFZ3aXNrRnk4aWtDYkFwcUNtMldO?=
 =?utf-8?B?czhLQklBYytpMnlBS3lrMlN1aGFPa2JnUVlRbEVjbFpYOFBIcjY0SE82YWd4?=
 =?utf-8?B?b1hnRExZejJaQmJ4d2tUZitHOGUrZlM0bTNram5EUmZYL1Y3Y1JyY0xuVHBQ?=
 =?utf-8?B?aXBwd29VTk4zU1huR2xpNVN6R1hHMXcwU1pZd0pKQU9yenEydlQvVHdQYllT?=
 =?utf-8?B?S1NiSUs1VFJGeTlLZ3BwaFVBZm5pRExQbzJ0cmx4MXFLME1MdzFTOVNDVk41?=
 =?utf-8?B?b0xHVlBiaHl2NStHSENiQmthUUdCTkRmaWlySldYTE5lSDhCTFdhdTBtcVNx?=
 =?utf-8?B?KzJTbGhSSUlrREtlTEVPeWlnKyttYzBQSXBSanJIVG85aFlZZk5uNUhZQU1M?=
 =?utf-8?B?WnAyVnhZMGhReGZzeGpMVnpFeWxRelRUV3VaL21JT28xalRYb1duT1RFcWxW?=
 =?utf-8?B?dnl5eDZVM25qd0tMd285TWt2dUk3blBjN2pZOTBBTGl6bzVhTDhZa1BQYVlP?=
 =?utf-8?B?cFAvT0Z3MU5PelNMbEtYWk05ckVEVDVNeldTQVdXVFlOOHNVa2o0Q1JjN1Iv?=
 =?utf-8?B?emgzVGRxNVBwTWpoY3M3TnhXRitIVUtiRWI3WUtqOS9waENEazZDUUtMcmFI?=
 =?utf-8?B?VGRoMTlzcVZwRkVlWXN1QzFuckc4ZDVFeFdYN0w3dTZCTGZHYURGRWlkU00v?=
 =?utf-8?B?eWVFdU9HcUxSVFpVTEZrSlZqQS9vLzIzbFRDek9XNkNFNkw3N3FkSC84RlJq?=
 =?utf-8?B?eTVJc0VMR1l1ZDlLcnk2ODNIUzBqOXJZSXBHeFdpUDF0cDlDYmlSdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0f8af1-17ec-4fd0-7b32-08deac3b3cb9
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 13:19:15.6062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOxsaBm3jf7ZS1bOWRG8kKZB5MMO1T8URInEVCCJVfSbMP4rAlz1FR9KA7MtcxKufkqujPYZub9+eRj9S0KZAmH3dm/vtFzj5BtEVLhdZmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8296
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

Hi Simon,

On 5/1/26 4:10 AM, Simon Glass wrote:
> Hi Quentin,
> 
> On Mon, 27 Apr 2026 at 03:48, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Sergio,
>>
>> On 4/23/26 5:45 PM, Sergio Prado wrote:
>>> [You don't often get email from sergio.prado@e-labworks.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> Add an optional extra_env dict parameter to run_cmd() and
>>> run_cmd_result(). When provided, the key/value pairs are merged into
>>> the subprocess environment for that invocation only, leaving the parent
>>> process environment unchanged.
>>>
>>> This might be needed by bintools that must inject environment variables
>>> into specific tool calls without polluting the global environment.
>>>
>>
>> Yeah, I'm not convinced this is useful.
>>
>> We would need to propagate this new variable to whatever calls those
>> methods as well. And it quickly balloons.
>>
>> Just mock the environment with
>>
>> with unittest.mock.patch.dict('os.environ', {'MYVAR': 'myval'}): like in
>> testFitSignPKCS11Object for example?
> 
> While we can mock the environment, it becomes confusing as the mocks
> pile up. The code path in the test effectively differs from the actual
> code path, since the mock is overriding something that it assumes the
> underlying code does, so any changes can cause strange errors.
> 

Sorry, I don't understand what you meant here, can you rephrase?

> The normal approach with binman tests is to pass through the settings
> they want. See for example _DoTestFile()
> 
> If you look through the tests, there is almost no mocking despite the
> large amount of functionality provided by Binman.
> 

How many of those features are actually dependent on environment variables?

Here, configuring OpenSSL, SOFTHSM2, and OpenSSL providers, we clearly 
are in the same scenario as when doing FIT signing with OpenSSL engines.

>>
>> I'm also very skeptical of the need for binman to *set* environment
>> variables to setup openssl.
>>
>> Look at what's been done for testFitSignPKCS11Object, we externally
>> configure openssl and softhsm so that binman doesn't have to know about
>> it. This avoids having to play smart and adding a bunch of new
>> variables. Is it possible to implement something like that for the x509
>> certificates? For FIT, we do use fit,engine,
>> fit,engine-keydir/key-name-hint with mkimage to (possibly) use pkcs11,
>> custom openssl engines, etc..
>>
>> Also, I don't think we should decide for the user whether they are
>> forced to use a provider or an engine based on the presence of the
>> provider? just let them configure openssl to use the one they want
>> externally?
> 
> Fair enough. I wonder how the tests deal with something which is
> externally configured, though?
> 

You set the OPENSSL_CONF, OPENSSL_ENGINES and SOFTHSM2_CONF environment 
variables to point at files that are generated for the tests. See the 
various unittest.mock.patch.dict('os.environ',) in tools/binman/ftest.py 
and tools/binman/test/fit/openssl.conf as well as 
tools/binman/test/fit/softhsm2.conf.

Cheers,
Quentin
