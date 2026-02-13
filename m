Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266AFEDF17E
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 17:18:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1EBF83CF2;
	Fri, 13 Feb 2026 18:18:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="NSIf1ZS8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03D6783D5D; Fri, 13 Feb 2026 18:18:06 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9469783015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 18:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCYI5HW+IZB3HxibT883ruzdfdPoGtQU78Zu8Q9bwALWPGnUmjpORnUrTv91+UYrOL0iWdXkVMmBhwPsrVZz4EiugHTcEsnxWtF3LyqUyDXfB7HH5XgBT93VcoRrgQvZNELzWRAOnamV1nODyFwVze+rgfHJ/cWm1gG0DD54Q4nC6EeqguIErnBB78hY6cp9GhSWb+Zb94LaIDRIofXLCS90K0VHApsxEvkFi4M1y4pmt21mWQKuBr3LueQeEt9M9wdC0/0PWkmmp5EzCKLI1rjWqtdKNew8GK6M2PwrZzb+B7sCjFmh/Rtj0GGdURi52OiGMEMGoBQTX8sB2cd9+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bjh32Le56NufEqHndi3C8FTxRaoRrLtmccbt9yv/g1E=;
 b=TOX6Bjk/mzpP3Qz379v9n0X3SznRTVVJkwdhiEyG7IxEdAe3pVfgE2f7zwMv1VfL/QhkAsUpmv3DIA1wx/XHiPGaeGNioiehGOtCAsE7OMh6W797aVEVtn48/it2Z5Ytm6J5cJqwZTA7A3uc47wtzfwzCI9i48iP6VyKMt5vfpmNMdAu4l8T0jkhfGRPbaxRCA0fRo/D6q5RfP61G4ENlnfhS54b0ChxOn5jm8YLLvfl26sE9c8r9AkhfdmC5SwSzzXhZBPMDJmgA2E/aHv8MCr3XOM2+Ml/+EzkO+mShbEKNQQDQaEMKFUCeQh25CxTLNyBuy2bvp9fud1og1lV+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bjh32Le56NufEqHndi3C8FTxRaoRrLtmccbt9yv/g1E=;
 b=NSIf1ZS8pz7OHt0VTp4CJQWwfbcNrBnTM3MzwlPQrfSB00OUy5/yvGJm3qZAMyDzrEe3/pWOe7smMzsVgTlUkF3RHjl/6JdNeRETydyt0NuVszXEn1L5vnkSBim9WediETsWIsk3lbWfrkCjsYtXOQNt4gdmVgBwMsCejY/11e4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU4PR04MB10792.eurprd04.prod.outlook.com (2603:10a6:10:58e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 17:18:01 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 17:18:01 +0000
Message-ID: <0406debc-6a4b-4b8c-9f47-167376144743@cherry.de>
Date: Fri, 13 Feb 2026 18:17:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3588-rock-5b: Remove USB-C controller from
 u-boot.dtsi
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, u-boot@lists.denx.de
References: <20260126215601.837587-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260126215601.837587-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0299.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::10) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU4PR04MB10792:EE_
X-MS-Office365-Filtering-Correlation-Id: dd2c0c7a-7a29-4f38-b54b-08de6b23d714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amd0YUllRWFzZkNrUmFaNFNIZEk2ZGRQcmdSOFlMUFFWQUZDVkhXWWVtdmlW?=
 =?utf-8?B?NTYvdCtHTmFmVk9LeE03YzN3ZkJWNlptc285czV1NWV2dDhyRkV6eTdrUW1Z?=
 =?utf-8?B?VXFPVm1kWmNCNzZjWEl4M0JpR1B1dXNEMnlUNUJvUXpGWitWSTlvbHRlZWtD?=
 =?utf-8?B?RU9UQmZMZFpjUy82U2Z6bFlZREg3RExWV3RGY1hBY09yRWZtSlZqeC9WUTlx?=
 =?utf-8?B?WitsbWlhOHFsaHlIQlF0Njd4SmtmMXR6MlVnaGxyL3lZMzhHRzhWZVZQZTJ6?=
 =?utf-8?B?Qk8yZXBkekdRUnNBRDB3Vit6Wi90K0NRTDFITkVDMlZOandidWI1NlNRb3Br?=
 =?utf-8?B?amg4V3p5MjEvdXYveFpMRC9JNkNiVXZIRnp0aVY2WkswL3htbkJFL1YxMFJE?=
 =?utf-8?B?S05VcFV3NTIxTGwyajRzUFQ3U2E2Nzh2NllLZ2hXTGk1QWxnUjkzRU11OFEw?=
 =?utf-8?B?am9mYWE3bm8wd2M0Q0ZhNDJXUXk3UkFJZ3U0a2Q3SnZzNVhMQ0xaMGxDeXJ5?=
 =?utf-8?B?YkxHOVFvcStwblFYNDFORXhnR2daQ3pQMVlnMEFpQjdTSVk2YkRkQVJFK3hn?=
 =?utf-8?B?enE2d0tNb0VtT2FaRkpVQ3JsQlA3dDFVeVVlVUNyNlhNQ1BXN1Nza1Frb2hp?=
 =?utf-8?B?ajdoa210allIZXBRb0FJajE3RDJWRnFLYjkxMldsdjFoVm52NzBDaXA1YURX?=
 =?utf-8?B?V0xOQ25jaS9xL0hTdkRua0FOdG1icnBoeHBrdmpTQURqNWg0UzJRUmh4Nnpk?=
 =?utf-8?B?bWNaMVVKRk0vWVFxMWdMekNLb01Tc1NPTnhsV2xBOU81N2UyZlJRdElqNk5I?=
 =?utf-8?B?dGpQeHhwY3hpMVVzUGdBODd2My9IQlJTM0oxandVc1hGVWEvRzg4SGtEdER3?=
 =?utf-8?B?cVRJd2xXUkRGV01kbll0QWtEWkE5dVJmajBzczU3bHlCNlpQUmhSUU03cDZF?=
 =?utf-8?B?TDFQK2kxQ0xOcjVyQWVVYlFscVBmL08vSnAvbjAwNkpoNCt5Y2xjR1piRDRT?=
 =?utf-8?B?M0IyV1VlaGErVE5zTWpEOFBla1pIbkQ0N05LWW1wQW5waUE5RkE2QXo0c3ph?=
 =?utf-8?B?Y2I4MmhEYlRPUjc4WFBsdXB1TVJpZ2pHQmVuMi9KOWpETi93VDUwVERTVlhk?=
 =?utf-8?B?a0hRVVZjZkVvQmRGWjQ3aUhyNWxObVVrRFJsREZJYkUrMGkzQTBraGFKRDNa?=
 =?utf-8?B?YjMxZUQ5dlZkOFhXdEdMU2NZc25ETWVNUWhPUHVHNFJQaHltZnc5Ukt2cmZH?=
 =?utf-8?B?SDZpckdtMEZXc0NKSHhSVS9vb1FuSk55T0ZHWGFtMndOVTR4dWFaR0JBa1h5?=
 =?utf-8?B?RjIwUFBoT0ErclhaMlRoQXlqZ0NjcEJoQlZqSERORFBualNIRGE2SGNWbGZQ?=
 =?utf-8?B?MkVOMWlPZXpNN1o3STcvY2liNm4zdzNzUW9PNDg1T3lKeW5Ick5ZVE5jTDNt?=
 =?utf-8?B?TWZKakt3K3RTU213REVVK3c3QTVEVnZEd1FtK25rOUR0VjNBVE01cU9YeGt2?=
 =?utf-8?B?U2ZyWUVudytqWXhjWG5mSGhqN1JRQXRJZEo2MlZQWGdvaS8zaWVFVUtZT2V5?=
 =?utf-8?B?Zi84amo5Zm8rU1ZnQ1RFbzhHcjNvUmNlL3NHa3Q2eGxJcGdvblhVK09mOXRR?=
 =?utf-8?B?TVZOWVNHcGlkeDBLMVZLRG1yUDBYTkxnTUNxMXRucms3SzZHdWExeHRqN3hW?=
 =?utf-8?B?cGgxMEMyZFhvQU5TQlJxZDU3cmh0SnNWQlA3S1c4UmFVbXo1cW1odm5tM0hp?=
 =?utf-8?B?NmlrTmh3bEo5UjBGZG04bThKRS91bC9WSGpIbitha1dLNVl6dXRCeGIzMDJK?=
 =?utf-8?B?TWtBcExEUWQwRldocEVLZTJWcVNSSXl5MU0yYVBKZVArdExSa2s1R0NIQnpm?=
 =?utf-8?B?aGJWaE1ITlhIOWVlMGZML2VOYUdYNHdHYlpweFkxVDVNUGJBeG1VTnFMclJn?=
 =?utf-8?B?bFFkMXZNcUhSaXcxVjZKTmUwNmJEZHNWcXhieG9ldzk5b1hDQmJPb1NUTTIz?=
 =?utf-8?B?ZzZya0pvTWVsaFJ1eHF4VWRkSGJHTEM1dk10RkJCK3gvZWh0QzdGc2RITER1?=
 =?utf-8?B?bG5kd2xXdlZyRW44aG0rR0g0RWY2T3h2Y1RpK25PZkFuYk9WR1JmQTlvL2V1?=
 =?utf-8?Q?+sPQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUpKakkvR2UxZEFIMUpMSDVWYm1qc1hEeEJZRWpjQ09jV0hhQ20rWFk2L0g0?=
 =?utf-8?B?d284amwwT0dBbUJBSHBEU090T2tjcE5FRk1lSFNJU29hSGNyZkMyZ21JbTlE?=
 =?utf-8?B?YUp0YkFmeXR1aVVLdXAwWFBpZUUvWEw1Z1BjS1ZNWVo5ZmZYZlpDMjE5amZX?=
 =?utf-8?B?MVJjdHJqb3JkZE16WVUwWGx6bUpSSVJGOERTMHl0bm1pa1RTUnRLZGxLa3hh?=
 =?utf-8?B?eVlmSXV5UzNTRzF0U1ltZUVSMkw0bGliZXBKVXFQMUxQMVVGTjIrMEhYQWdP?=
 =?utf-8?B?UCtrNSt0bGJTc29leFhWSXZRS29ZUlYvNkFxTmJaK2tNQmluTUhFSktIYmRo?=
 =?utf-8?B?OExLYzN2UFBCSXBYV0RPbjdrdnBDcDhXTC9UU2hFVmphb3lvUW5TYjNvdjEz?=
 =?utf-8?B?OUQrTzlHV2VudnU5VFRpZjRLOGt4VThTbUlRdGJSMHpqY0ZidjU1WWE2Rkxk?=
 =?utf-8?B?Z2FxQVlCeFExVDVSUGdueXRCWmZQM0RZWDNHYWJYRXpYVTlmTEFHb2gyLzFD?=
 =?utf-8?B?VzRyVkJDM1IxMTVRZFUvcUpiS2lOcndpbFhrYm5WVy93ODB2YnUxTXliMW82?=
 =?utf-8?B?Zjl5MkI0NGlnZTQ4aHNzNC9LR0xnRGI5TGFWU1UzR3BzUmwyRkxleHpHdkpw?=
 =?utf-8?B?SDM4MFJQNTMwSGJVRzJqUDRqaGt4R0dKUDRXTEw2NGNZc3FiZ2RSbm5yaEEx?=
 =?utf-8?B?dVpUTFJDWFZ1M2NvRks0VFJaV2wvRGFFd3hEazVQdVdOU1dHSWZlRkZhOWow?=
 =?utf-8?B?WDVHQjhqRUhYVE8xUjhXZno1L0hEVktqWGF4ZENhNEJLOUdEclEyQjRoNnND?=
 =?utf-8?B?aFYvSFZTYW8zZlNJYXUxY0p3NjVKR2x1MW9tNEdYbHc1S3lPWUw2THdrRGov?=
 =?utf-8?B?Ync2Sk01REN4UExBYXZTVnFGVHY4aGYzcSs3RmJMUWJIZ2dNbjNhbksxM1Vj?=
 =?utf-8?B?aHZNWWYwTFVlVW5oQTQ3V3NDN0U1cW1IWjBYS3Y2bWRGZXNKVlRvUFdKb1hP?=
 =?utf-8?B?VGlhL3ppUExBejJwVmU2YXdLQnd3b3N4NkZkL1pCckY5ditvK3V4amo1b2hR?=
 =?utf-8?B?MmJJWTV0NGZ6VW56MFp0dHRYNUxYWVVHL0c5T3cyUy85a0FkSW5OdGFPMkRl?=
 =?utf-8?B?cVE2RmpBdE95UFZES3ZQVURaVmJnR0YvSkx5WkhVN1k0WEpkWUNwQXEyWWFD?=
 =?utf-8?B?QklYQUN0TkpSMU9hMmNiNWlRRzlhcUdpRkJkRjlKZU5ydTV0aHZaZk9wUXBq?=
 =?utf-8?B?OTIwVnkwQXlGZWNMcm8vSW14dVJ3TXlXVkkwbHNUVktzNnVvMGEycVZjRG43?=
 =?utf-8?B?S0NrTzBJOHNTU3QxZWFvdDBYRlhYS0U0TlpNYStXWWp0ZHJ4VjlSVlc3cG84?=
 =?utf-8?B?QnVyMG1HdmNmRUdHL1BIbENDUzV2RVQ2WkxUeFVEZTVxU0VoNW1wU0ZOVGtF?=
 =?utf-8?B?VjRtR3ZpZkVpL1ZJTHh4WlRoMEhMWTJPZno3OWlDNjhkVkVxWTZ5Y1BWODh6?=
 =?utf-8?B?YjMyZW1kRzRLSTBzcHNWTy9vNHprTGgvWmlLN2k3ZzlkUWdoTmVaYVRrUFE3?=
 =?utf-8?B?d1JNQ2xQQWp0Sm56YzRCSjYraVdSQVRucmVnM0N6akJubTRrV2dzeGlTcnNC?=
 =?utf-8?B?TlVCN3B2SVFFTGdycG96ayt3MGs3QjBLcDdUd3dRUUc4c2dkWWJaeEFlbHpi?=
 =?utf-8?B?OEMxcmxmcUJHcXY1dFhNdURDOWJySEhDTjJ5NjFtK2FNZGkzSkpHZkhtTzJV?=
 =?utf-8?B?aDdrVC9yd2MrNXVlVEVSOUlmUllDYzVYcWt5elozeW5TQjg4cFZPRThxdldK?=
 =?utf-8?B?WTFadXNxbm1vSXJDclZEWHlGVjBEYkRIVU1HR0RheVBFazIrZUMyditDWjNV?=
 =?utf-8?B?cTQ5M244bjlkR1VETW1hRnpkNEhWYmlXeUVTZFZwVHZ6bzRYSHd2WUpiYjlQ?=
 =?utf-8?B?ZkRsZ0VrVWwyMWZvYWxiV1NaZ25QeXg3OGdGSXh1RWg4UWI5NXlFdTk3aG42?=
 =?utf-8?B?cnNOeTJjdVBYMFFZQkhjZnlNaTF6eFV6ZzZ6SXIralROeldqYlcxSFAyL3pR?=
 =?utf-8?B?UTVLQ0duK3RZM0VFdlNSQTRUK0s1Qmw4NHBBSFRnRnZmbUFLQXQvNHdpLzUv?=
 =?utf-8?B?NzlkZDM1UW9vbFhWRm5tRFZUdlNFS0Y2eUdRNTlLaEoxOWw5S2MwR2MrKzNk?=
 =?utf-8?B?RzVoQytkaGhvNzd6YjEza3ZuZk42NFk2d0FmeUZtb3dOVFpVTVF6TFY3R1BG?=
 =?utf-8?B?WkxBM1RHMUxVL1YxaFV0clhsYmFIQXN4UmkyWjZCMXpqZEt0eVhBcW1NcDg2?=
 =?utf-8?B?c0tTRTFvQnhBOW5qQXErakdGMWVPMkl0eUE0M2NoOEI1b09VdWlwUFVIUUhJ?=
 =?utf-8?Q?ULRCV+07h4gzcUJ+o6cW22CJW99QekVQdL91Y?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2c0c7a-7a29-4f38-b54b-08de6b23d714
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 17:18:01.1210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfdvLYgNHqKgnXqkEJ1t+p579JzDiXUmZFyPHdcS2TPp82lI60Iu4vgr9lk61nw6G7NTk3vVycTM55feKVGZbVYi0t2g0azZchfrGQG0PRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10792
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

Hi Jonas,

On 1/26/26 10:55 PM, Jonas Karlman wrote:

[...]

> -&usb_host0_xhci {
> -	dr_mode = "peripheral";
> -	maximum-speed = "high-speed";

This is not set anymore after this patch is applied (dr_mode = otg and 
no maximum-speed). Please keep this part as is and if actually fine to 
remove, have a separate commit motivating the removal.

Cheers,
Quentin
