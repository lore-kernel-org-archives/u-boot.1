Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6739D36107
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 19:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D05188D47;
	Tue,  5 Nov 2024 20:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="1RNfd0OP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D177488D47; Tue,  5 Nov 2024 20:01:29 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2070e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::70e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A876D87F7D
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 20:01:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9BxOQu+gP6jWWEEvybu1iWCQJA2OXLICzk9r9Q2nDvjpu2iUkfi9JMC5aZ+k7SdId2/0DEoKwUUSM72Dz5vjfh+nwNUX9Uto4CiYVBUfKTvNC77T7VELwepsRFr94IC8DcIROegLmBgLQY8VZ+uDSg1oqrJUT7nz5d0SReMzhQlrt94onXdBU17wNw8brh0I4PwyVRIJxmMz3eyk7nhLdOXeEJhAQBtLPcYrMFRJUSgeig+Q77JxA6nXW+LBLLsYBXFMr5++vml3udZvY1FVjWRU/5jM96ElbT2vKb+xeRgR9Y7GMsJ/nqoP1maA4kNJWkPQ19kerxPk5dRziyutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/z67aQPB7tAGWxjnRj7GxjsuVhXrMCfO+rCinf+W1w=;
 b=zSGydsQIIE/fSmU3r8TE1iliZ+KH1sZR3zXr54Z68vbWa+2eFPo+w1hCUvnyD25Ex0bFtRihm3Dtm51dM+04KVLaaKIacckSuR6KCs6RWFebrc7doUWg+LMpBluZVJbXyQQDwkB3v1h7CGSmq69mv9ic2+CmMhHNWroKFYQAo6rmsl0Dx7rluPhKnadXXSVRn+vuNn5lTdudQI0nY0L2LmShP64X3SsLin/UR4AJZdH5cmpUrtdeCwxdv9y05sP5B/i/hZnyoCq0B5kyFMCEpNW0HjabW0c2lLsjgP1uauWBbj3LQHFvRy1ZyEcraHNzjFBgFI7XdtXh1UxSf6wGOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/z67aQPB7tAGWxjnRj7GxjsuVhXrMCfO+rCinf+W1w=;
 b=1RNfd0OPSS2C652zOd5mi7j3ZT7WLnKMnxpr0GA9q2OL94EC1APZCTA+CV6uLPYgofiUWYcqJFfokaLJikIV3r6TicEqj4tLL/iAQKE1k7njv5/XUiPNk7F1wZeIIZIgEGma04XiATmChgoOIRBPEiJv54Rc1bj9gTiWR2zzR0dWOuWofSKWPnRc/iCYcEZI3POYfakWeG6O1sUfcuLhxBZCaEVgYEFeNcU8bEv+uYo6a0yF7a2z0+VpHX539vCkP0b7V25NP94bw2cgLEXB+MjQQRwyo5nE0Q4st7/GFrTuWgqfMhU07FlhN8Wsfgqn3MbICfQvuRdFX3EI09ucMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7589.eurprd08.prod.outlook.com (2603:10a6:10:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Tue, 5 Nov
 2024 19:01:24 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 19:01:24 +0000
Message-ID: <c8ad5da6-ba6b-4465-b00a-c7539c6f6bb1@iopsys.eu>
Date: Tue, 5 Nov 2024 21:59:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/13] net: tcp: improve tcp support in legacy stack
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
References: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
 <20241104233227.GA3600562@bill-the-cat>
 <CAFLszThXiK=EzrUStsOBiSQ_pe1-Vdwtg-238BjQd91SMBym7A@mail.gmail.com>
 <CALeDE9M1PDFmm-oZvSEGwBaN_J77CSKUa8kbkEPQf9XATv8STg@mail.gmail.com>
 <CAFLszTjs-7uWNWdaZjhQe-rA5z0qSZxiFeX+WgFofYemW6qiwg@mail.gmail.com>
 <20241105154741.GI3600562@bill-the-cat>
 <CAFLszTjntxJShjnWK++NkonNrPdL0S-=zWf-N_AWUaZmfmArtg@mail.gmail.com>
 <20241105182619.GL3600562@bill-the-cat>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20241105182619.GL3600562@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF00014AF1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::305) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: 392aaf85-c217-4574-1779-08dcfdcc3e63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUI2aWp1MTBNWUNxbVFQWjBuMTJPb2d0WVN5YldlVXdnZml0M3JxQWErTzF6?=
 =?utf-8?B?dmNZckYvVUdobU5JbFM2U01aR2huMGdhY00rYUxQY2p3a1FhV2hNRUREWGZH?=
 =?utf-8?B?NDRSSlNHQ1dlWUdCTUJsNjUxL0ZxNkV4bTlTOFU2dUxTbVU1YnhjRzdxTk9B?=
 =?utf-8?B?d2NqaEFaY29ZZHlwV28wdDVpbkNnaU9mK1VLVEdSaFB0OTB3MVV6STIybVpB?=
 =?utf-8?B?KzRUNmlsanozWXpDd3NFQ0xIUUlCUGFhalljNC9tY1FhVWdNSGdPNXVjbCtJ?=
 =?utf-8?B?b1dnU096RzFRc1A2T29rbzh4N0EweVoxQUV2eEQ3SzNXUXZOell4Wm1OTVV0?=
 =?utf-8?B?NkE5eHIyZndLT09SREtJb243Lzd3aTE0Q2JZU0pUd0FDbXMzei9Oc05GVkY0?=
 =?utf-8?B?UmttYkhteVZNODk5WWZqOGhpNCt0MEtzMWVpcXk3VUkwcmc3TEFubGY1ZFNK?=
 =?utf-8?B?dHppNEFWL2pGd2dqeld3Vk80VmtodEQvaU01TTRqdHBtdCtTWjVXSThUMnEv?=
 =?utf-8?B?RklNTjFuN0hWVkRjaG52YWR3TWpwNHgzeWFtWDRmN2tUSGxzNjBGSXZXcVM1?=
 =?utf-8?B?amg1aTdlZUZmNjZzTS9CdEFuVlpqWk9PczE1R2FCMC82aUNMdGRDUjBheWNI?=
 =?utf-8?B?T3lDbTNITGF5YkFzTW81RHF1aUVSSG9IbUs0TklvMXVYLzVoRFlUeXNlcmxN?=
 =?utf-8?B?UXRvaVpIQkE0UjlJWXZqNnRMNk5IcFAwQTZWbmVla3Z6K3A5aTJGUDZSeGRv?=
 =?utf-8?B?RTk5emM0S01zNldhM1E1QlVNcXo3VDREbTBZb2lTd0x0cXZ5anJ5STZjRytL?=
 =?utf-8?B?aktHbDFKNjJLUXpSUjg2WDFpcklienFLMlVkeTVxVXJ3eTk4NzR5ZkNpYWcz?=
 =?utf-8?B?Nk5LVld2Tk9PYjUvcmJPK3M3MWhuVUNTdExSRjlLbDVTZE0vZDU5OXMyTHJH?=
 =?utf-8?B?SFFRTTJJRTVmdUdVcFBBSndNMm40UE1mblVUdTA1blNhZS9WandiczRDTGJo?=
 =?utf-8?B?Sml6cDVmam82WmszUzdvS2Y5SWJIYTF4Znh1eVU2clRKMUsrNWpab1YyVmdp?=
 =?utf-8?B?djN1ZWlaMktBU0hBajB5Z2RGb05iTDQrQ1lOMXlkM2R0TlBuczd3cDZxSkE5?=
 =?utf-8?B?ci9oTnN6NDF2WjNveU1zUnRraEpJOHF3VlF6NDRINnVHVHlVZFhrQW5IUVNl?=
 =?utf-8?B?b2hQRkpPdE1LdEszbG1JRmZjY1QybFUzNEtKQXUwMGRUYnhZL2d2S0hBZWh3?=
 =?utf-8?B?S3YrVnU2amVIWXpBUHZhd3M0UWNPN242eDNTUVA3ODN4c2lTZ0p6VXhKMkxw?=
 =?utf-8?B?SU51b2JOb3h0VHVaNy8xcWtpR3RVTGowRlFjYW1nSWk1QkVXZkJ1U0JoMHBM?=
 =?utf-8?B?YTF0b2RqeG5UaFNPMUduaTlGOXpBV3RoemhWa3JjS0dibWo0a1ZlNFVyRTNy?=
 =?utf-8?B?ZUpEOTJuN1c0QmVZM1EwMldNeldGUlhyTU5WdlhpT0tvd0x3Y1BTME1mcmJL?=
 =?utf-8?B?S1BuOTJNOUFHZGlVU2JxRWRnek1ncUQxTnp6Y2d6cm5DeUcxV2FuYkNQV1J0?=
 =?utf-8?B?MENldDE1dDE5dGRRL0FBV2JWcnJOSXVQZ2JaMk9QNnF5SWk0OG9uN0hWSHVx?=
 =?utf-8?B?SHJNVXBpZmZONEJkamhBMnZqaXZpaU8yc3l6TTZmUVJmWE9ZemhCVzFaMVpE?=
 =?utf-8?B?Z1RPTHI3Ny9UdXJ1b1BSMnJBSkt2em51bU5LK1FrcnlYVDYweFRIcFdqN3Vr?=
 =?utf-8?Q?aXk0eT1AkBaMmJmLkjrCy0BALCUZp5+/5DWta5G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVdINlZBSWt5U0w1L2VpNjlnMkVUUkdrRUozZUtQL3lQSm9jdG9HM2w2T01i?=
 =?utf-8?B?cDkxQTNHMUZGNDc3SVNWd3d0Wm92eXZtcEJmRHRTaHFnSEpYQnNnK3JHZ0Nz?=
 =?utf-8?B?Z1c3ZEpYdmJqaXdMY1pnZStFUlh2UDNpU2NKZmM5aGx3TE93cTdUZzBiWHNB?=
 =?utf-8?B?MWE5TkprYlRMM2Nzc0RheXhUSFZHWldiMXhiVERLc2cxeENWam5hRStBVFZo?=
 =?utf-8?B?aGszb2JFUnZyQTQxTDZJSWJpdGxwMXR4cTU0cDRRblVNL0JuTnVEcklScSt0?=
 =?utf-8?B?ZVM2WXBCSURrTk9ienpDYXppYTNQN2tXQVZ3YTJQNW5kTjErWHRBNjVuNHZq?=
 =?utf-8?B?OFlNY2c3QjN1TkVVWW1jbzgxVllDS01pK2lmYmNIRlBMRk1kT3hVMVAyTDdi?=
 =?utf-8?B?UUM2RzkxSFVVby9sWGxtWlhNY0VOSUJmempabk9zT3BUYnBFYXp0MDYrYWhZ?=
 =?utf-8?B?SjhjTThCZkhURCt1d3JNQmdZQWdyemVjTGxVWFRBMXNHbnYxcmxLQVRhcFZn?=
 =?utf-8?B?bEFzV3VuNVFRR2VXQit3dkNTMDNsdjMxNkNiblpNN1NhamhYQ2kvWlN3azc4?=
 =?utf-8?B?bklVMENxdkhhNWY2ejNpdmNMQnhWMnpNV01kcHM3NFVKdi9YY3Fwb3ZyVXVa?=
 =?utf-8?B?bCtZeDNSYmtzR2drMXRNdGFLVloxUnBTaHNXems1SU1XN3EzOFhaaVoxOWpT?=
 =?utf-8?B?VHVEWVB1SGRFMkkzNFBTcjRZUW1ueFdlUERxNmF6N1FjekRLVmpDd2d2VW9h?=
 =?utf-8?B?SWNNTDZhNFhadEJ4cFYxUjVzWk5veHJiK3cza3h4SXg4L05iUkdhOGFSWnN6?=
 =?utf-8?B?UGlSSWNXT3JFVVNBMzQyaHNhT1cya1F2bFZtT0hhelBDbU1vN0p0NWt4bUlz?=
 =?utf-8?B?dTdhUXpQOVlWaFNBK3RlcTNUUFZwY1dVR3NyeXFGK0pxaXg3dmwybzBuWWVx?=
 =?utf-8?B?VUhoeHhmTVZFNUdSRmYyQXZzbXlrcUtHRGIvOStibEZCVjU5V1p6a1pyZ0xW?=
 =?utf-8?B?OVBnbnBUVWxZbkxhczVYZ0RXUUNtSENMRU5nbm5ScytmLzRZazZ3SkNKdDJT?=
 =?utf-8?B?WjUvM2RySGFLQjIxUk9sbWQ3OUNaZnVpWGFLZE0rUUZwUVNJRldXdDFYeE9N?=
 =?utf-8?B?S2d3bnB4aVlGK2pJYjVqQWQ5ZFRjRHJuRzVNcEJvdmlhbXljVi9ab3NrL0tH?=
 =?utf-8?B?WDMwMHc3NVJ1aXExTzdvbUpSdTJUWU1GT0RuTldNcFBYRzB0d3VodDFYRkpp?=
 =?utf-8?B?KysvUGxuOHRDRmpNRERPQ3cwcWp0SWxOeDMrbXhmVGtLdVVjTkRhdkRNViti?=
 =?utf-8?B?VmYzd0orZ09YSVhPV2RjNFI3aFJicldsaHFCdnlVdnAzZEhuY3ppVldHRTc4?=
 =?utf-8?B?TEhjNVFCTm0rWTh4SWlqRktNZVJJQWdLR3c2YjZlYlVZR2FuZEFxY1pXSSt2?=
 =?utf-8?B?QjkyYzdocC94cGVtZ3F2b1AwbnNKaXdXcE1tTk9LN3RHdXVockhKWG1CT2lD?=
 =?utf-8?B?TGVtL3pLVUpSOWRvb0Jmb3Eyd01jQWtiS0IwcEpmSjlqczhTNm1jNDAzOXgz?=
 =?utf-8?B?dWV2TjVGc2xZQndNaEI1SFhnMGdBVVpwTS9ScEx3YUV3bHdvU1I3SUJabWFs?=
 =?utf-8?B?cnd0WTdmSFBEZlR6UEdhbE1SSDU0WGpWdU5XMFJxRkdUS0xtcG5ZdXJYWlR0?=
 =?utf-8?B?ZGRUYXRtZXdXZ2hYTXRRSU13VCtpSUQ2WjRScUMyWG5tcFZydUJ3SVorTVI4?=
 =?utf-8?B?TWN0cnlpNkVQTklEUDFmbFJTb3VuSXJwYTFoUm9GRkcwT3hUd2IvRXVncEJ0?=
 =?utf-8?B?REZOLzJud1RTTXZPaVN2U2hmV0JOcXpuL0pqTml5RnJpd2srZHk2N1RnRTBJ?=
 =?utf-8?B?djVvNHU1Yjg5bFY2NENYKzlkOFVJeW16ckZWb1ZqMGEvWWVia3lWSDk4dVJi?=
 =?utf-8?B?em94eUg1RXR5NVNIU3ZwajVmT0dvVHJLSGc1Qnk1RkJEeDNEbFhva2RaVytQ?=
 =?utf-8?B?Y1EwZi9MUmxIOG9qVjR0RmJQRGs0RldkK1FsSFR5UzBlSnN5UHJPWkJJMyt6?=
 =?utf-8?B?dlRHWjlkSTdwVkJGcFVBQUJIYm5WOU52dzVoN21KMGhmOHhqTGVqL2hpSnFX?=
 =?utf-8?B?Y1pTUFRZbFVOUmRTRXhvWG1Cc250akNwUi95S0Nac1pOMUM2RVBwZDdLenNN?=
 =?utf-8?B?dHc9PQ==?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 392aaf85-c217-4574-1779-08dcfdcc3e63
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 19:01:24.3152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 886wI+FrGet3DPyBN6mp9f8y6xvyhNoV5hFs5JauS1NEfGsP5Jb4juera1e77ili6zj7loOa+CSqX2+moIQDptr9O/Gg80j9W3bBmog+mG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7589
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


On 05.11.2024 21:26, Tom Rini wrote:
> On Tue, Nov 05, 2024 at 09:07:17AM -0700, Simon Glass wrote:
>> Hi Tom,
>>
>> On Tue, 5 Nov 2024 at 08:47, Tom Rini <trini@konsulko.com> wrote:
>>> On Tue, Nov 05, 2024 at 08:15:25AM -0700, Simon Glass wrote:
>>>> Hi Peter,
>>>>
>>>> On Tue, 5 Nov 2024 at 06:10, Peter Robinson <pbrobinson@gmail.com> wrote:
>>>>> On Tue, 5 Nov 2024 at 13:03, Simon Glass <sjg@chromium.org> wrote:
>>>>>> Hi Tom,
>>>>>>
>>>>>> On Mon, 4 Nov 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
>>>>>>> On Mon, Oct 28, 2024 at 05:31:30PM +0300, Mikhail Kshevetskiy wrote:
>>>>>>>
>>>>>>>> Legacy TCP stack is bad. Here are some of the known issues:
>>>>>>>>  * tcp packet from other connection can break a current one
>>>>>>>>  * tcp send sequence always starts from zero
>>>>>>>>  * bad tcp options processing
>>>>>>>>  * strange assumptions on packet size for selective acknowledge
>>>>>>>>  * tcp interface assumes one of the two scenarios:
>>>>>>>>      - data downloading from remote host to a board
>>>>>>>>      - request-response exchange with a small packets
>>>>>>>>    so it's not possible to upload large amount of data from the
>>>>>>>>    board to remote host.
>>>>>>>>  * wget test generate bad tcp stream, test should fail but it passes instead
>>>>>>>>
>>>>>>>> This series of patches fixes all of the above issues.
>>>>>>> I know Peter asked on the last one, but I want to ask as well. With lwIP
>>>>>>> merged, why do we want to add features to the old stack? I can see
>>>>>>> fixing issues, but not adding new functionality as well. Thanks.
>>>>>>>
>>>>>> Let's apply this. It has tests and the old stack is still used by a
>>>>>> lot of boards. At present lwip is only used on one. There is more work
>>>>>> to do on the new stack, including finishing off the sandbox
>>>>>> implementation.
>>>>> I agree with applying the fixes pieces, I do not agree with apply the
>>>>> HTTP server pieces. This series should actually be split into 3
>>>> But what is your objection?
>>>>
>>>> I would much rather just apply it ASAP. It has already gone through 12
>>>> versions, during which lwip has been prepared and applied.
>>> Yes, and to be blunt, the first bit of feedback I provided was "can you
>>> please look at the lwIP series instead?".
>>>
>>>> The HTTP server is a useful feature and we should be able to use it to
>>>> test networking in U-Boot in a more self-contained and performant
>>>> manner.
>>> I very much do not want to add more features to the legacy TCP stack.
>>> We're likely, long term, to still need some cut-back version of the old
>>> stack for the limited SPL cases.
>> This series has been in progress for a long time and it seems unfair
>> to just drop it, with one one board on the new stack.
> Well, I continue to not say that we should drop the series, but that we
> should take the fixes and not the new features. Because as far as I can
> tell, the current TCP stack is in such a shape that it's not
> production-usable anywhere and so the number of users argument is
> irrelevant.
>
I expected something like this when lwip was finally merged.
I was a bit surprised when Simon decide to merge this patch series.

At the moment we have no plans to update u-boot or backport lwip patches
to u-boot-2023.10.
So we will use our solution based on a legacy stack. I understand that
we should switch to lwip somewhere in the future. Unfortunately it's 
not a fast and easy process (update u-boot, rewrite http based firmware
upgrade, test new u-boot for several hardware configurations, test
customer devices migrations and so on).

Also we are limited in resources, so I am able to put my hands on u-boot
only from time to time.
So this is a long story.

Tom, Simon, Peter: what patches do you want to accept?

Mikhail Kshevetskiy
