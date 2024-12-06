Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCEFE77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 13:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEDBE8960D;
	Fri,  6 Dec 2024 14:12:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="JlxxpZgn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63A27895F2; Fri,  6 Dec 2024 14:12:01 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A955189620
 for <u-boot+nodisclaimer@lists.denx.de>; Fri,  6 Dec 2024 14:11:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvGBi+zGUyHOEDc0OhM00MxiAUPf3bTXya0JXdt7IWbNp08Ni2cB7anG0BSkYw3FA6TBHRaFV/RAtQb1BtXBSkN+RnPWuwblQuz2iBM4Wx1o3x6cUbbximnjXVS1BrgRTAW44EMhX1rmht+zchTJZMuKbUbDBiXx7eySmT1p3Vs1Cz6Zz93aKUKQ4viAIrLHrVvLTSAM/vvD3lRAeaIpU3VCzRn8SDD6q4cFtg1a3Wv68nOaWPfvgY9t40TCvXYWnCn3bxo0OoA5+hG8VvcwUBtlu3r571NUeLk+/dRdpIKH9S1GcCuUqL5pDAFRFTLuY0t70K6xKOEyDfvDPO6kdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuC6UtOjVNxZWCbqIWWrO/pxwIcrrA0rOmsV4mAmE/g=;
 b=y/RwyyFUJiWUVN3p6vWIREy+da1N0JjKjad3b97FyZEliBxZXG3jfqHwRDFTJVfDQ6Jetdq7KVy1CvABhmB+vcoNbGxlQQM45f1W5bOQoKZGy2i6yLdsRAnE/QaFMIs+vfi0Jrw7oz6JTEIKtOUq2TSwYDnBznkUZd8tViMXPDSlDd22L9JYCAKHIxdOVi58wgRgZU5LT0XSmQgOTYP9a1cA4j57K3F1HbJb/pThb9tek/gZTe+jG5qxsgabHkL51M3u8dtageb4VUOFnK4wGMB/XlUbKiFaxo/NZ3TZUm7zjp8mBfwoy4gCjAWt+POSzWg/6HRrTYn5PsgvVCvyBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuC6UtOjVNxZWCbqIWWrO/pxwIcrrA0rOmsV4mAmE/g=;
 b=JlxxpZgnTa24p2UScx06kDDs9EHgNpk1XB1wOnehTu+sxf79D72qCFfxyvsG87i9D5A3FCxPhrdrAOVX5aMq7N77fixZwYUADrc7qASDAAuMGTAGAAMJBp6D6nT0g/7T7pKeQj4YODScQ3vCTfXY0LnTUnA/ukWe/EqNeWy05qFLSJlzFOT6ktxMRYVhkOaJZqLmQlyM5MeYhtFFC0g0AgEUF48C8UPJ1sL6kWjBAoB3l3ItckuyG3jWIXs1g+87eak8DdJ0JHZAOzp1sCm3qHhSpFJ2iAkHfuM1xmzf0HquYtu1AeD2SqRDwji9QOhL1UiJYrg0diUzw7T6lCG/0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by PARP264MB4925.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 13:11:53 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27%6]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 13:11:53 +0000
Message-ID: <e0a7bcbd-7804-4d50-8d04-95f60cee99f7@softathome.com>
Date: Fri, 6 Dec 2024 14:11:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] lib: sha256: add feature sha256_hmac
To: raymond.mao+nodisclaimer@linaro.org
Cc: sjg+nodisclaimer@chromium.org, u-boot+nodisclaimer@lists.denx.de
References: <20241204175437.185449-1-philippe.reynes@softathome.com>
 <20241204175437.185449-3-philippe.reynes@softathome.com>
 <CAEfUkU+peqy0T9mhA++xhrm+6x-_pogkLr_DE2C-yb6QiZkRUw@mail.gmail.com>
Content-Language: en-US
From: Philippe REYNES <philippe.reynes@softathome.com>
In-Reply-To: <CAEfUkU+peqy0T9mhA++xhrm+6x-_pogkLr_DE2C-yb6QiZkRUw@mail.gmail.com>
X-ClientProxiedBy: PR3P192CA0023.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::28) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|PARP264MB4925:EE_
X-MS-Office365-Filtering-Correlation-Id: 483f770d-5e98-46d2-3a75-08dd15f78dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1hndEFtR3hvVUZ6dmMyM3lYUXRWUWg0QjJETitERENmbkE4UGg3MmdGK0NM?=
 =?utf-8?B?cGROSEtUQmgzZ1JGSVVDdmlBYlgrZTltYW90NjBjUHhoSXpjVm1iRTMwVDJV?=
 =?utf-8?B?cUJwVUFWU1JGYklpUEpNS0wwdUt1V1lxSC96ck9GRlRJNHIzTm5FOGpVTmNU?=
 =?utf-8?B?bm8xWGtJQmtaSG5tVENWNHVSU1FvM2djdVAwN1pFaGljKytIM1Q4REhtRGNK?=
 =?utf-8?B?Y0IrSkE4VHdmNGhXd3JYSkdVRHl0TUQxV0Q1ajhrTVFrUDVSWCtqQVlkdERI?=
 =?utf-8?B?aGRpcFl6L3dEdUZJdzA0TStQSVRLdkpHQVlIYlArd2prOGJtSCttY3c3Zk13?=
 =?utf-8?B?UzExYWUzS0oyeFYwVUZ3MmIxUGk1QkNsY0NBdmZLM2tRVlQrakoybG13dlNY?=
 =?utf-8?B?NFNRZHhJOENkcmxJUnl6NFFDUXVUZDZTLzhOK1VBNkV1cWFHSCtsYmtBWndJ?=
 =?utf-8?B?WGJLeU53WTlHaXlRZmtxMVh3UDZUOTk1MDhkdEZHcUQ0bm5kejBBWm44VWVU?=
 =?utf-8?B?aEl6WUNEN1Q5MTBjYUpsMk1vU2d5dUFzU0pQb0RoTzI4bnZ3c28wVkdacG1a?=
 =?utf-8?B?OXdlUDBBS3lBOEswNnF3eFpIbmpUTlBxczNHS0tUTEpKUC9MaGVwcS9vRUdy?=
 =?utf-8?B?M1IzR0JydDhPcnlPM3BRWEhqUVBxSFVzcDBTOEVsUnBzZEJveHVuRnVoaWlv?=
 =?utf-8?B?VGRTUlUvTTlQY2xSanh4Yk1PVHQ3c3VxZlpETHFWTWFGUlF3Nnc1WE42SE0w?=
 =?utf-8?B?bEdSMGZqcDZ6Nyt0RUN0dlZSbDE2c0NTSXNsV1MxdTVsSEowQTgwYUlkVjEv?=
 =?utf-8?B?RGNSK2dTUEJOY0pzaW1COGthY1ZnMmxpSTNKY1NEdEY1eHgwelZ1M2hCVXhW?=
 =?utf-8?B?NGR0b3dBSjAwU3J0eU94UzlVcE5FZlVvbFB5a3dFZ3JnN3E3TjBrY0VSTFBn?=
 =?utf-8?B?ZW1CWFFhRHFuNnJER1pOMU5jRkZWd2p0RUJ6Q1V2VEhzamhBZExOVFVpaEJW?=
 =?utf-8?B?cnM0Q3VEQi9XeFMwQUk1RUZ4bEsvQkVDS3hWWjRBUUJJZkEvSEhCL3FLR015?=
 =?utf-8?B?dnU0WWtiNVJQdjVLbjNBcSszbGp0bkhUcllYeGZ0eGhIUUE3ZXJhVWVBeStu?=
 =?utf-8?B?ZzU3VVlHajBjdUswd1dwN0dNakFPM1hSbHIwR2NPZkRoWnpxbS9aWC9KWFBY?=
 =?utf-8?B?bUgzMnFqZyttSzhPTjZYM3NwOHpoU1BQZkJFQnlHcXVsd2FwUzFTTi9mRXly?=
 =?utf-8?B?NzQ1dVdIQ25Pd2J0dmlqdE5vMEt5bzVCZ3dvaHU2akplQXBHdTVKaTFaWU9E?=
 =?utf-8?B?a1JuYmw4YmtSOHBpMWVDemZod1JrN1JWY3VuQk9UQmtjcVlhVTZoNzgwSHdK?=
 =?utf-8?B?QVNuVks1QWUxbmV6N2tkbWxidW4vKyt1NXZERVZ5eFBrdkIxVHNDWGhJL2NV?=
 =?utf-8?B?MWdXdHBRY0plOFYydDZNU2Nsa05LY0dsWGpValhGMGR6b2hjSXFlRW4xVmhv?=
 =?utf-8?B?WnFlY0Qzd0dXdE9EZzhSSlNrcmxKbmRrYjlzcElzRksxQlU5OStrRHcyWkFm?=
 =?utf-8?B?SjNHc1JzNHVHN2RTcndMTlgrQUJ6Wi9leFd3Ui9Mc0o5eG1XQWlWTUY5SUZP?=
 =?utf-8?B?bTdvcmpwTjlZSk5lMFVCODlyUDFjU1d0R0ovWXZNWTc5ci9CVWFiR3c0ZFRx?=
 =?utf-8?B?RlBIUmhzNTVsRSttMkxaM2F1anpVM201eTR2Nk15RmdXOXlCVU9oUXViT2R5?=
 =?utf-8?B?TExUMzNlK0tsK2hFT1BtMmtOOG5jWFZ4ZXNYLzNOWlJLVFJhc0M2VzIxemsv?=
 =?utf-8?B?Ylo5YjFyREdqSkpFbVpiZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE91Mnh1VVdqNDQ2RmNLYkdwVVh2SFMyWkR6N3pVbVJvMGxkNExQSFVqYnpj?=
 =?utf-8?B?eXFzY1VuTXNPOXI0RnJlOWdwZXZIUlFZV0lMWnlDTm9zM3ZreDBmdWJ3YUpt?=
 =?utf-8?B?R2VyakZOL2QyUDV4bG5tcEdQdzdKc21rUHFwU0p6KzRRMEs0NmlXTkd5WG1j?=
 =?utf-8?B?TDFtdTBXSkpIV1V0OGEyY2xoeEJvZEt4N0N0dUQ0bTJOcUtzY0JIQzBLZ3RB?=
 =?utf-8?B?WnVEbW9RU014SEJlR0dCai9GamQ0RlNQU3VzbHlXaVN5S2FpNHAyLytDbW1P?=
 =?utf-8?B?YmhBNUlCbHcwcHhQbHJuVWYzQW9Fa0p1dXdZU3BnWWZ2QzJGWU9EbFNodWNW?=
 =?utf-8?B?U3k3T0Fra3RZbXA0dSs4QVE4V1huNFpLTzJKKzIzQk5hWTBkOUk2dHJZM2ln?=
 =?utf-8?B?WmU3Z0NHZnNBWXZNNHpiT2JwcTNoeFhXeEVVam5GZ1ZOcTZmV0w4R2hSQ1lJ?=
 =?utf-8?B?T0dTL2ZvQjgzajZMenZTWTR3RGdGeGsxVUJUZzBZb1M4QkJzWDBjOEs4QlhF?=
 =?utf-8?B?aUhDZ1JpMmZic25WV1ZjeU9ZZERwS0V6VmMwcUMzeTFUM2ZJQkgzMjhhbmRo?=
 =?utf-8?B?bG9QRUhDOVI1SVZsNS9ORThickNpcWV4WkdDblV3Mjk4eUN4YjNHNVpENWVF?=
 =?utf-8?B?OU9TcWxteGNPaHNWMHJhVk9EWTB2RFI1VWRkekFGR25Ob3BvUG8yaTdFOFVO?=
 =?utf-8?B?UndEcjhDVi9paDZvb3FPWm9EdnIvOXVtUnNuTmkreVJXOStMSnlObWMwbVdn?=
 =?utf-8?B?Z3V5K1BvQm5XdjUxa3V6SklqNHN2K2ZvTHBDaDJOcy9wTkFYcEdxMXBvRmVT?=
 =?utf-8?B?TUNjcUFvSTU2cGJlVWFobWRsN0t3UWdLeEMxR2tFV1o1QzlZSW9qNkt2V0FT?=
 =?utf-8?B?ODk1QUhFaVZ4bEM1UkZIUjNDZXJXR0NLYVBaR1krZjdWVSs0UVB3YjB2UFpY?=
 =?utf-8?B?THVZN0RQelU0OU5jc3dGYjZXYUpKRWJ5REVLN05wbGREbjNmTlMrSlVhNW4v?=
 =?utf-8?B?T3RkNzFPTytsdTg3UDBjd2hyNGtNeTMrUmNMUlQ3Sll4WEFMZ2w0V3dmaEhM?=
 =?utf-8?B?ZHNqSFZFenFHSERjUWhGTWlMVGI3OFVUMlN6VWNncFNNOVZ6RVNNMktEbTdp?=
 =?utf-8?B?VXZVZ0l4TC81VHBscUs1d09SU2lZbUg3YWhVUGJxd3FYNzRJMFlnMWRyL3pF?=
 =?utf-8?B?U2RKcnI5d09DM1AyV1dkSENvbXA5SWI2LzJGcGpNbFFjWjBXVkEyblVaMDBR?=
 =?utf-8?B?Q3QxODE4NTdrb2ZPcWx3OFRSTHIrb0hYYjF5SzA4NzBiVSthNy9FSGU1c05Z?=
 =?utf-8?B?YWhMUnpFMnpINlZJUFk2Rkw5NmFMcUF1ZHJTbUdWSHdpdXNYZlRJci8wVFpm?=
 =?utf-8?B?bEZPakZYc0dJdXkrejRibFVnV0dFYzVhWHc1ZGl5WkV2bXo4L0FXK3pMODFK?=
 =?utf-8?B?SVRWREppSzdka0JMUWNiK1NHamFaTkVDemJmZkpnZzBtVWNHaUtSV29ybmhl?=
 =?utf-8?B?K0JpMEFJNzJldTBrQjJ4ZzRCU0g1VDlWTlhWcUZZU3hmNmloQm5SMWQ1eWtO?=
 =?utf-8?B?alhkcW1nUy82WDIyNlNyRCtJSWU1Y3B6RE0rbWh1MzZPVk1hTHc4N2N2VDI3?=
 =?utf-8?B?d0FyY0RsNWU0MThmenkxV2V2amRxRFkwOUx6UVNDSndpSTcxbEhTc2JxcEVV?=
 =?utf-8?B?SE4vU0QwbUM5TFB1bEVXMFZneTkrYm5UUlJtREtrMTAxTDVsb3h4My9pTlRq?=
 =?utf-8?B?alY2ME56N3ppR2NNajM4ajFTdi9rdWY0bUJzbTRFNThBdTlLV0ExUlhnTEFL?=
 =?utf-8?B?Z0YvRTNQdkJidm4rcXFkTEdtM1ZQaW51VHZVbFQ0NG1EVDF2dlczUDE0NUQw?=
 =?utf-8?B?aHpVazAwRVB0VVVReHpTdDliRGkvNE8ybU85TnMvRWphcldnN3pEZjBQQjVJ?=
 =?utf-8?B?emx1UlBuZkREeDR1cS9QQVp4cmNBUEV6cXdTVjM2TzVnb2JtWEdRRDZ1U0hk?=
 =?utf-8?B?UVpRSURwWGd4eEFjWEFnRkhBZHVwaEgrWDZlRUZ2WXN0SVBUdysrSCtWbmlq?=
 =?utf-8?B?dk1nbXpPSXdzN2ZOaHJZZXNtTnVoQTVuNGI0dU56dzcveGxiNDhPSUdVUkxh?=
 =?utf-8?B?NTJuTnFVMGRwV2FyRFo2RTBhNGFzT1kzSnExTlVvSUl1QlNCN2M4UFRxbVlP?=
 =?utf-8?B?M3VYV2FxRWhJRWRZSlVTMFZJcTZhWWpub1NkdGxlRGo4dFZxeWZTWkUyYUdm?=
 =?utf-8?B?NFNCU2g5Z0VIQTBhOWJzR2k4ZXBRPT0=?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483f770d-5e98-46d2-3a75-08dd15f78dca
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 13:11:53.8135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1Tn0QxmJ8gccoUbboZ4o/jwQ3VUhoKAXYZMWmzb3QZxj4LFvRbj7QpheDa7Qg881vQ00l6CPBeQ0eB7subEz8z5hdTttg161NOu1GD3Fbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB4925
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Raymond,

Le 05/12/2024 à 18:11, Raymond Mao a écrit :
>
> *This Mail comes from Outside of SoftAtHome: *Do not answer, click 
> links or open attachments unless you recognize the sender and know the 
> content is safe.**
>
> Hi Philippe,
>
> On Wed, 4 Dec 2024 at 12:54, Philippe Reynes 
> <philippe.reynes@softathome.com> wrote:
>
>     Adds the support of the hmac based on sha256.
>     This implementation is based on rfc2104.
>
>     Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>     ---
>      include/u-boot/sha256.h |  4 ++++
>      lib/mbedtls/sha256.c    | 38 ++++++++++++++++++++++++++++++++++++++
>      2 files changed, 42 insertions(+)
>
>     diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
>     index b58d5b58d39..77dbcd4553a 100644
>     --- a/include/u-boot/sha256.h
>     +++ b/include/u-boot/sha256.h
>     @@ -44,4 +44,8 @@ void sha256_finish(sha256_context * ctx, uint8_t
>     digest[SHA256_SUM_LEN]);
>      void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
>                     unsigned char *output, unsigned int chunk_sz);
>
>     +void sha256_hmac(const unsigned char *key, int keylen,
>     +                const unsigned char *input, unsigned int ilen,
>     +                unsigned char *output);
>     +
>
> Shall we have an inline function for the case if mbedtls is not enabled?


you're right, I should manage the case where mbedtls is not enabled.
But with you're feedback below, the function hmac is always defined (with
or without mbedtls).


>      #endif /* _SHA256_H */
>     diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
>     index 24aa58fa674..1b9fc1a8503 100644
>     --- a/lib/mbedtls/sha256.c
>     +++ b/lib/mbedtls/sha256.c
>     @@ -8,6 +8,7 @@
>      #ifndef USE_HOSTCC
>      #include <cyclic.h>
>      #endif /* USE_HOSTCC */
>     +#include <string.h>
>      #include <u-boot/sha256.h>
>
>      const u8 sha256_der_prefix[SHA256_DER_LEN] = {
>     @@ -60,3 +61,40 @@ void sha256_csum_wd(const unsigned char *input,
>     unsigned int ilen,
>
>             sha256_finish(&ctx, output);
>      }
>     +
>     +void sha256_hmac(const unsigned char *key, int keylen,
>     +                const unsigned char *input, unsigned int ilen,
>     +                unsigned char *output)
>     +{
>     +       int i;
>     +       sha256_context ctx;
>     +       unsigned char k_ipad[64];
>     +       unsigned char k_opad[64];
>     +       unsigned char tmpbuf[32];
>     +
>     +       memset(k_ipad, 0x36, 64);
>     +       memset(k_opad, 0x5C, 64);
>     +
>     +       for (i = 0; i < keylen; i++) {
>     +               if (i >= 64)
>     +                       break;
>     +
>     +               k_ipad[i] ^= key[i];
>     +               k_opad[i] ^= key[i];
>     +       }
>     +
>     +       sha256_starts(&ctx);
>     +       sha256_update(&ctx, k_ipad, sizeof(k_ipad));
>     +       sha256_update(&ctx, input, ilen);
>     +       sha256_finish(&ctx, tmpbuf);
>     +
>     +       sha256_starts(&ctx);
>     +       sha256_update(&ctx, k_opad, sizeof(k_opad));
>     +       sha256_update(&ctx, tmpbuf, sizeof(tmpbuf));
>     +       sha256_finish(&ctx, output);
>     +
>     +       memset(k_ipad, 0, sizeof(k_ipad));
>     +       memset(k_opad, 0, sizeof(k_opad));
>     +       memset(tmpbuf, 0, sizeof(tmpbuf));
>     +       memset(&ctx, 0, sizeof(sha256_context));
>     +}
>
>
> This function seems to be generic and should be located in lib instead 
> of lib/mbedtls.


I have looked the function sha256_csum_wd and I have seen that this function
is defined twice, in the file lib/sha256.c and in lib/mbedtls/sha256.c. 
I have done
the same to have the support of sha256_hmac with or without mbedtls.
But I think that we should avoid to duplicate code, and we should clean it.


>
> Regards,
> Raymond


Regards,
Philippe
