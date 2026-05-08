Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534B9CD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 16:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9A6384D5B;
	Fri,  8 May 2026 18:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PAPs4j+d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AA6784D8D; Fri,  8 May 2026 18:39:46 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42BC784D42
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 18:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvBsVG56aKwahIgTWEdiNqoEFLbExH5dAkso7PCPLkv9ZMGGEOrfXG4d/ltzccGlI5NixrmSJfkS57boTJ8n1ATtsyP9RC9sjkWBHH4EbZdC0lmnXeDdmohUA+eeoO6tEzQCtfv4XakGwPGlxfS7YTJNyz/hhU3sUVSZ8Oq8A7zkMkPTtWR0UyzqRzjkbpgtgzCjJbBuSkpwbRnf8LvViIjOBpj66JV3kZlEFKT0xweRZ6JC0DvPVr+Mx0ETwq/JDIZdrmTErxlYHpTrL1Nlnu+2WNZwgJ8wPgB1WRLsrJiys8mL1XLu/DezH5ttDxl5RN8BsDQ5M2CWJB4AIGu82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3t/IlyHDAP2QT/5OQQdUMdfMy1aapjQmRT1TZgw11VM=;
 b=Fac82MP5DcfKwbUsXPoMt5eBIToYfE/RZyJDddkaw0hJcex9rJ6ocpmzWctkGVEspeJmJnEW3f8aKDD1ciwSrZPeqoM58DFmtgR7/HRFZavclPMDOAKwo6tCWjwW32lTzrRZiKrcNyxv0wPXKqpC5hi2lyg6Ln71fNb394wNeDUhvj11bdaLva/gEfBlRPKlFh17RJG6MtOvZoySxrimadAXefjKjk7tGk0HxMe6CID2bUFSBm1Ekr3r4QXdLvfhiisVlCzuqW2lwAGk8geQur3C65o/U+PBcIRulVUvMWa7EM9bcYnZBdS4fuectHTZXwsksw/Ok7z039gVXGn0FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3t/IlyHDAP2QT/5OQQdUMdfMy1aapjQmRT1TZgw11VM=;
 b=PAPs4j+d1LnqwK5iRAQVOaYChVYvLgYaAqQUkh8pXE6DYixxw0EfaAqmtpyo1UckvfIm+5vKP4Xw4OxZr4UVS/T/TrRA131XdOZlphXzJ6nPWrzFuYow83X2+9lRLLXihriZLrbjbEwDhhFFzWgufON5p3NRbaXoeHD7BG1xxRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by MRWPR04MB11490.eurprd04.prod.outlook.com (2603:10a6:501:74::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 16:39:40 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 16:39:40 +0000
Message-ID: <a4c03d65-5e9e-457b-873e-fcdd573b5ed7@cherry.de>
Date: Fri, 8 May 2026 18:39:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] binman: bintool: add extra_env parameter to run_cmd
To: Simon Glass <sjg@chromium.org>, Sergio Prado <sergio.prado@e-labworks.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, alpernebiyasak@gmail.com,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com, bb@ti.com,
 y.moog@phytec.de, xypron.glpk@gmx.de, jerome.forissier@arm.com, afd@ti.com,
 Wojciech.Dubowik@mt.com
References: <20260423154536.768603-1-sergio.prado@e-labworks.com>
 <20260423154536.768603-2-sergio.prado@e-labworks.com>
 <491f7007-0574-4fa5-897c-59002c7dcaf6@cherry.de>
 <CAFLszThW0u0SrntCfXFi083petNmszVmSjNgXFc87a38tHyx1Q@mail.gmail.com>
 <610b19bb-3282-4062-a3f5-3071c69dbedb@cherry.de>
 <CAFLszTgjvZnwsLBQicn4=g_wia3JP8EWs1H8o=pUe6L9kcC9JQ@mail.gmail.com>
 <CANu7NGspwLDTC=iVYse_TbEmJ8yLuGtVBnVB5_479d238qFaeg@mail.gmail.com>
 <CAFLszThkOu_LFSxYXjPyqPsyKN54D2stdJcpmKXgq7hn_7+QAQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszThkOu_LFSxYXjPyqPsyKN54D2stdJcpmKXgq7hn_7+QAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::12) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|MRWPR04MB11490:EE_
X-MS-Office365-Filtering-Correlation-Id: a01501f7-3d90-4fc4-ef8f-08dead206655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: aOwhg+Lb021a+C17Z29cr8V/V4pcP8v7q6Y8NNO5xLLF7TsysTI6wcydWxwByncO5QdLPp3Ehfj+uelHfxJTDazJsy+35xn3c8pmX5yiblQO1CY0YDNRqL3b25ablpjDbq7y2bPZnj5tjp1eV4LcoHbGCQCz05JoN5MzgtssNigWbTQvgsJStbQI8K8SrQw2p8QmU4OlR1+Fv0nEbgMAlssaVg86VZoVfQMz8YOV5FLH9iDN/X+qqfKMm5M5qHn/InMAD08odmVLX+H38jvK92t76J02P+YIbLQLUvLBFGd8OKBuaRBU3ZtbZ0xhLOM9psShIHtpEd1oSObVb2Qd2yMbqp9IeZi9ODYerWjgxPlomAVKcB6HzsUJdi45FzUE+liTM6IYSqI7qsdf9/GqEeDxeh/4ReGp+R0WrkPT8sm0YMR4wL4kXEirnLcnIq6XstycTGTFMUScGErh/wyT6meBOd0qLCct1w10RkJg54PS29BavPDzvhNm4Ocl51JFRtCiQYl8DvJvrpsxMXDFRlYctuN33R42nLSxkVDig1oI9/In/UzDr5OlomeFujmtl40JMajnLdRp3wHFkOT9yoNHj2jYY/t7sMJJRdsoaqmc6FbB097TbTC5KoWFBQ8iSSqCJTgc7PJgA3RygkONhnD8jDvIHhB7i9yoTgE0+kVsL2/PtsWbDvGE9c2ns0sQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1paYlg2blFUOXcrdXRwb0FvV3Bka0VlWkV2NDZqS2s2QXI1MDhEVzA2UUpz?=
 =?utf-8?B?eWpFdXltK2FYVGJyTlJMYzd0Z0ZNSGlmelg3SmV6Q3lyWUh1MEpnSFphRm5Y?=
 =?utf-8?B?b0tPNXN1WW15TkFrZG5ZS3gwM3BHZkFSOEhtTkFGdm1odzF6T2VyWlBRR3kx?=
 =?utf-8?B?ZHlRcmdrZm1UOXZ4ckp6ZmxpZXVJZ0paam4wd00rV01sZ2xEbkh3MHdTMjU2?=
 =?utf-8?B?S0hVdW9rOWJOT29ISDEwSnoxYlMvTVdmdGZWQ2ZxK1dJR3NTbDM3dkd3cEFy?=
 =?utf-8?B?ZWVsbjNjSnVUTkY4dkVKVURNMGdGTVZ1VVU1RkdhTmN3STZ6NkI4NTd5U2lU?=
 =?utf-8?B?dGVoWGlxT25aMGRRd1ovTnRkNmRaL2FqQytSWWF6UjRkNStFM1gxdlpnRWY3?=
 =?utf-8?B?K1k1MHRhY29aQS93TlIydlZBdUNDQytsRUozWlFTQ3pleFIvUk5td283Rlll?=
 =?utf-8?B?dEYzYkFLVkJuRm9IUHdUOTBMQlYwVmJTOVBtRnpNbHB2MmwyYUtTZitGZUV5?=
 =?utf-8?B?NEZ6TjFaWG9iaFpDeldFQkpmK1J6VmhieGVKMERsMWhMc2xmTzdOSXRjd3lP?=
 =?utf-8?B?TXlib0hIRzJqdm1MS0Y4OUJGajFEN3o2NG5tK3poUnZ4dUFoUVU5NTAxV3RO?=
 =?utf-8?B?eE9OOUlXSExrRUZVWTF1N0xrYmFrYnVBTGJ4RjcrNGZ2ZDdrYVJWUzZCQU9y?=
 =?utf-8?B?YzN0QjkrMGdhNmh6dWMvYml4M0kzVytQdy9xRGhVWHdvWTZFaElQb0xBRWxS?=
 =?utf-8?B?VElhUmgwd05UNmlxUDRvcVN5V0pqU2krems3NExaT2dGVmVIV0VFRkVuTkVJ?=
 =?utf-8?B?eHVRdmRYZzVjYkl3QmFmcmVobUNTY3RRcEFWVjdwa3FiVGVYcllmRC9Ea2dk?=
 =?utf-8?B?dzJQSUdSK25SUlZlQ09XSFlKaFZZaVNVb29hbHZLVWppdXkwYWQvc2tMZTNs?=
 =?utf-8?B?M1pnN0x5ZkdXcldQVStEa0tqeStKSW43RGswZTVvazBCRjczYjN5M3E4TVhK?=
 =?utf-8?B?M21SREw5elg0bWVqK1hBQkhWcFdMbGJqb0krSzhoL21GTUxPczNkQjBZRG1Z?=
 =?utf-8?B?bzlzQkE0bVRyZlhmaFFSRDBmclQvQ1dzSHN1UXJidDJSdE1vS0x0TGIzcGt2?=
 =?utf-8?B?WUZWUm9jdGZjYmRJQWxmM2ZJbG9zRVZNWENiTTlsOU1pclVqUWdGR1BPL0lB?=
 =?utf-8?B?NDBkU1VROFhWQnJXY2M1SDdJeFo4dktCM0V4M2Y1bjQzWnI0OHBuOWhGNmtN?=
 =?utf-8?B?SGJwNG1NVkVtRkN3QnI3N3dzbkJFNE1NUnd4bEs3cXFRT3Y0U3lBU1NMVmRK?=
 =?utf-8?B?TVZYQSt1NzFYd0JTWmliRkU4di9FTi9xYTh1eURaVXRpVXRWRHZNRExWcGhY?=
 =?utf-8?B?YnNDNlZFdWdSSUtKcEx1R0VGM2wrYVkxNHF0eFEzRE1qY05mSEYyZGlVYXJS?=
 =?utf-8?B?QkEzem5HY1FPbWd6NUJmampTVm0vaUwxNGdVOHMvbHA0blhDczhlTDJzWWJB?=
 =?utf-8?B?MmJwb3ZXaElBU0F5bHRlWU4zQWllYXJJMjZIT2xLeERUeDl4RC9tQVhmWmxV?=
 =?utf-8?B?ajM3V2hzRUtyMHo3RlFnNDVEQ1lwcnRFRVViWlJiTGVvdDZTaUNLblROYmJa?=
 =?utf-8?B?MzhYejJlWFY4V2ErNk92Rjhja3d1a2MvNnR6UHZuVjFMSlRzNXZhQXhsTnVa?=
 =?utf-8?B?NGhoNFNEenVSZk1qM3JCS3R6cmtqWWVHVEVGSk44eC9ZaVFpMnBxVjBka0Qr?=
 =?utf-8?B?TGRYMm16QUpNK1Jia1UzaU9BZGFiVVpNZjlCYzlUcFIxMnJPOUZnMjYvNFox?=
 =?utf-8?B?S1FLbE8rcEhjVnBMZ0VDWlo1cWdtdUlPNjROVVBCai8zUFV3ZUpIM2E2eUlK?=
 =?utf-8?B?Q2NsQllocng0OW0vZDlOWTUzR0NNakR6aktMa2NGWnZZam9FUTRONDFKZ1o5?=
 =?utf-8?B?TFdHRXdVRUpFRldGbDVDS21OLytEdlhXdHNnUyt6QXhPRVZNWUJvRGk1M0FN?=
 =?utf-8?B?R0tldG5pbmlZLzJzSGN6emlkaVNwSkVhUFMrd05mcmdnaG9tMHdwN0FaenpO?=
 =?utf-8?B?cUM5MjBFV3pSaUp5SWxVVnBNbzJJYzZudittUE9uSFhET1lPQ1FtTWppNXVS?=
 =?utf-8?B?WnZvY3oyTzIrenQvYjJiaC9CcWZKaVJtZXhtYmFveSt1QlY2a1ZuREs3ckc1?=
 =?utf-8?B?MUlDS09tTlQyUDZNSWpkL2V2NVBYZExJcC9qczNTa3c3OTNPeHplSVF6cTUr?=
 =?utf-8?B?bm82djc0QnlscVJqeHN3M21sZXlGQjNBTGdPTG5iM0kydnM2S01PR0FJTjJl?=
 =?utf-8?B?RTZITWtaUHhNdWV0Nmx5SkVxQzQvYjkyRlErMjBTeE5HamhBZklsUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a01501f7-3d90-4fc4-ef8f-08dead206655
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 16:39:40.1914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AWlUYCb92Gf7Z2FYlpX/xrUbpn24Lf+2dhDsZSJUMYMv5hTAgLjZ0Npx0YQNdmxRWCUBnPmL67qKgEoqzWkbHhy7ZCPm1wfzUYFRTRaH+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11490
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

On 5/8/26 6:34 PM, Simon Glass wrote:
> Hi Sergio,
> 
> On Thu, 7 May 2026 at 13:03, Sergio Prado <sergio.prado@e-labworks.com> wrote:
>>
>> Hi Simon,
>>
>>> My understanding of the justification for NOT passing the env argument
>>> is that it is annoying to do that plumbing. But I would rather do that
>>> plumbing. Perhaps not stated, but one of Binman's design goals is to
>>> try to have callers pass in their requirements rather than relying on
>>> state or sideways data (although there is plenty of that even so :-)
>>
>> I came up with a solution similar to FIT image signing. It is much simpler and does not require passing additional environment variables to binman (though it still requires defining a few environment variables when invoking make, such as OPENSSL_CONF and SOFTHSM2_CONF, which I assume is what you referred to as “sideways data”).
>>
>> Please let me know if I should submit this new version as v4, or is the approach of passing environment variables to binman still under discussion.
> 
> Let's see what Quentin thinks about this...
> 

Please send the v4 so we can have a look at it but it sounds nice already :)

Cheers,
Quentin

