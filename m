Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F7AD58D75
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 18:04:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F01A890AD;
	Mon, 25 Nov 2024 19:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vwj39t4f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 023A689A3E; Mon, 25 Nov 2024 19:04:09 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3790688D13
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 19:04:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxdkL42fiqdrpEoMOFI5BwOzBKeTLgE16eaetQLUvdZV2MOxUp7Suft3oGhWcqMD1OYP/r84LaI1L4ONjiiMm88kRA091j1q1BaHheC0SuwGLZHUJVMCCrEIOGI9nzFOBSyAgXcNGdLyrHzJqGCmAT1mCJbeagU5wEwY/utLheOdH6Vr/hs3Tt+9NuXBb6x4Q4F1wuKYx1kE6FrLIHRZ0W2dhugHxwhzV7wJOmBsaDflT7hFG0CuCM1OOZvk3s9dBXZ/xJBmyVN6q/EpuuAGDMq9kgJryTchkisu3gGB0ctHL8TExV3OU28LszbCSy4c1eN9jQCEgCoW6D+mWrrJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxSXRfzAvd8FbhfoW7lN+R5acuikVR6RILGisHcNVV8=;
 b=BCvkDmHsCt0fjF9PYryPGBdL9Sw60IQX+wcItq+Pplb6/xIpe1+r2mBZFhWlRqCEZY5daKbw/XPZCONabcFcTysN1ufYVVvc8lwtW3/jVlgyaLWNm5EDyFvHMrZYAFfE7cEtEAc/NYFch1lfUnR8i8ctcexXogkRlL5+kRab7HOxjtpKgjAseeZZQKZxt0nXVhiItmcWzqx9jWL/QMWTLIF3pPdKUzLUuCac1CqgeBqaLGYrPdMzkUwVv2IbOOC7n7BUDd7lZgO5KGn9ubW+cdyt55/9j1sgMD3YJM65lGSnfaX30+nYn703cCaLMK2aE0mUI71WjlocbC3e7r4lmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxSXRfzAvd8FbhfoW7lN+R5acuikVR6RILGisHcNVV8=;
 b=Vwj39t4faTDUNFt4gGJ2y1f7X4Op6UgLemUXtpRCtmeqouhEYSfihqGZYOuRDk2i6F35GLXZZckV4agd+dmbCdD5Pi5P72lmBpcS4IKH9JSuO+3aiqY+lK4vXRIzY0QROf5qLS0JO7V+tEpA9Xwt/++L5vpUK6KiRYVGef1O6EU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA0PR12MB8228.namprd12.prod.outlook.com (2603:10b6:208:402::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 18:04:00 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 18:03:56 +0000
Message-ID: <30c3072c-8446-412d-a534-61d9c8e0b03e@amd.com>
Date: Mon, 25 Nov 2024 19:03:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] configs: xilinx_versal_virt: disable USB_DWC3
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-4-heinrich.schuchardt@canonical.com>
 <8941f3cb-2993-4cbf-a24e-a7a77898d634@amd.com>
 <72bb7c7e-1103-4ffe-af26-fb70136d11fe@canonical.com>
 <e91068f5-e9b7-44ca-a09f-32fab22dc3b0@amd.com>
 <9a90a05e-1e93-49c7-a72a-523ef345e7fc@canonical.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <9a90a05e-1e93-49c7-a72a-523ef345e7fc@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:408:fb::30) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA0PR12MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: 669794f8-d171-4dce-061e-08dd0d7b86ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFlHem1taWVjUFMzYkhmdGFmaHMrU0ZnRVlmRGRrQ1Nzc3N5MDVxOHVIUHRN?=
 =?utf-8?B?S0RyZnFnUEhST1F4UkVYMzI1QW9HN2dBQzhBcVlkSTU0UjMxbW1KbmowdUhG?=
 =?utf-8?B?WkJaanNQa095OUYvNWwxaTNFVDRTQ1FVYUhGRVdzWkZETSs0bTFpSk1HU3U0?=
 =?utf-8?B?RStic2Z1WUJySVlSMStWMkh0U0NYbkRBeGYzdzAreWxJNk5yUjRGWVc4UDlj?=
 =?utf-8?B?NVlaNWVSRzQweFBwZWpSdHlJWUU1aHRZaXJTYVNoUHJQMW1BcmpOSy9mN1p0?=
 =?utf-8?B?cXlmSEtGN1dpbWNJN0tZZWEyNmhacGVlYVFaczYxRnVkSW52ekkzTE9wanNt?=
 =?utf-8?B?MFVxRi9lT1VtNGFJcTlaQnNYbHptdHBSK3R0Zm1IQ3VkL2pyTTVIZ3NBWmRn?=
 =?utf-8?B?NXVabzZta0RqQXU4NHhnUGFsNmo0cXZvenZwSXZKL1hOajZvN2Q3cWVXd0FW?=
 =?utf-8?B?dDFPSnNjamtBUjI5Um41V1FxY0xDdmpzODYwVEtjWDkzTGI5VnFtYldIekJS?=
 =?utf-8?B?MzIzM2lkcXJPWDl1ZGxMZDFtcUgrZEJHMkVlQmJmVEtEQWVITHkxckp0UDgy?=
 =?utf-8?B?ZXJacy9pTERkbGlmL1p2WEw5TGE3YVRFNmdhdS9LdGNQOEVxK3pRLy93QUFV?=
 =?utf-8?B?YnBWUkVUNWxOR2FQTzhRaWpWajRHQVFQSTJKbVBLcDNDZGt0amRYdUlPQWNt?=
 =?utf-8?B?b3NheCtud3pRbTQ3eVFGVU9JcTNjWWR1RlhWMnhFUnlmR1BuZlB5U2FhMkdn?=
 =?utf-8?B?TkNYSnpRS2pmRWxqMTRIeSt5NzBPRThpSVY3aHYrVEFGVUVNd3hPd3ZEM3J4?=
 =?utf-8?B?czF3MnhhOERlNHZoY2xYMnFJeFc0M0piYWIyK1VtckYybXBEdlRZVWlpSS9n?=
 =?utf-8?B?V3dFNE5rczhVYVYxc05SbjhXTG55TUhVSWtmcjViZjZGNnNVa3FtZFFScmNB?=
 =?utf-8?B?S0NOVDhFWFp2NEpNNTBBbWdKLzhabGlpNmRLanFVVTdPRVp3Q3J4djFEdllq?=
 =?utf-8?B?Y1AzdlVkL21zb0YybWxRTEtGSXpuYTkrdzErSGlzQ0tONHRhdWhkMUhJaHA2?=
 =?utf-8?B?S3g0ZXVSSUk5Z1U0UElTaStiUXVkcEVHNURuRVFnS0FTUkluU2tiZFRhS0FO?=
 =?utf-8?B?NjdTRkQ1Vmpnc1lGajlmaWtqYTh5NVVPdjBSQkJacHdoZFl3czBWZmRwWFB6?=
 =?utf-8?B?NUREc0ZCU1V6RStZQm83MUNiZS9SMFAvNnEzMDdkd09hN0lIdThiM0NNZUF3?=
 =?utf-8?B?TUc3WkpzcytYLzVkVWpvRURIaVE2VHN4ZWpUK3o4ZW53alNCM2ZqLzg1SC9X?=
 =?utf-8?B?SFlqS1V3ZWx3M294NlZPM3JGNW9zSk9YOU1vMG9uNDBHNUFYTnFpYk83ODVO?=
 =?utf-8?B?VHp5UXV3TVdCYlRhczFwUDFVMVF0WVgvZHZ2MFlwN1JteUxibmNtVkVlUDVi?=
 =?utf-8?B?dlVoL2tVeU1NaVdScnludmFpc1FLbFlrTEhQNGFSSnAwSVphcjZHRjhrV3lS?=
 =?utf-8?B?UUs2cHMxcDMwYkxIYUprN2I1WjdXQ3NXalNwU2FMUlJIUTFmcWRnelUwTEJH?=
 =?utf-8?B?aUhQRlh5SWJHU0l1cUtlSVRvbXpSWUdOOStBRlZOS3ZrZ1p0TkgySjNVelZq?=
 =?utf-8?B?RDJRRGoweitmd1huRGN5cUJ4SGJScUppaWI0bkRVZkpiU2NaWTlLejhDYXdB?=
 =?utf-8?B?SVFxWjB4WGZwcFpockMwcGsrT0lTUURoRnE2Z29aMEplWmFmNkNwRkFEa2FE?=
 =?utf-8?B?bytVa0hhNUJPTEI4eElzclZmSGNpNVVNeUJMU2s3aG9XQTRCRTAxQkRtZWxu?=
 =?utf-8?B?Skt6WkhTaTIzajJSWHh0UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L09TemxLamVQWkNZUE1nWldBOFpjMk5NbFRoS3lpKzF0ZFlkZ1hiNDhoanJa?=
 =?utf-8?B?WEVTTXlnUVVBWHJvdXpzcFF5NW5qWWM2UTVRWTlJdjM2SjZ3ZlRkREVSNElQ?=
 =?utf-8?B?QUtOeXlFMmdtRlMyU2lyZnNIZGhRczZ3Y1cvcmFac0FxcW02ZU55WXpxVkQ1?=
 =?utf-8?B?SzllU0VETXBwTXRwVXpFLy9OZmcxMmhGcmpzd1QzeWxDSFFpZ051RSt0SENY?=
 =?utf-8?B?YW13MmJrWkZBNTBaY0xUYllZeUNHc2RPYStlUWluM0VGcjRCcTA3VzFCOFFF?=
 =?utf-8?B?ek5HVjVLcFoxYzJmazMxOFVJR0NoTVh3aUpWNHJsazBsZ0t5UkpobUFrMmlB?=
 =?utf-8?B?QzR6QUtMK2g5UGh1VFFnRkdON0tWY2phM0J6VGg5L3RoTzFnQjVoSmozeUM5?=
 =?utf-8?B?QnBQbkZ6UFk0Y2FrYm1KWFlJR3UyNjduQnpsVVcweGt0enZnYnpIaE1lU25B?=
 =?utf-8?B?VE1EMzQyWHRpenJxNjJaQVFUbDdQV0hwU3pJaDRzK21pTTh0a2VucFZrOTdt?=
 =?utf-8?B?L3QwTzF6Wk1jS1VuQ3Y4M092bkE3REJkVklUMEFsZkw2eDg5VkdTOERnRW5m?=
 =?utf-8?B?R1JVbVNYMWZTNjVWVktUMXBqY1NIQzg4Z2ZHRGhhOFQyYVFWYUE1N2o5TWNM?=
 =?utf-8?B?c0dOTzBNczNrNG5JMnAxaGwrVFNybmRIaGcxbEZjbm4xZGVVeFFtdjlUYWJ4?=
 =?utf-8?B?QjExZHI3TUVPRTl1NUgxMEV6N01QZmE4WTNmYnBObElMekNzRHJVSmluaTdQ?=
 =?utf-8?B?V255bWNpaGVoN1hGUDlUYklxMFFSUnp5aVFQTWpPZ3ZQS0tKakgvTmhvUXd5?=
 =?utf-8?B?cTdnWUgvZnU1WC93MFpLM2VTcDJzdWF4L1IvOFI5WXhiUVhjZWZqQnNUemp5?=
 =?utf-8?B?R0tySkFJR2ZqVm94N2JtSmRTb1YrQnNQVW9NSy9GRkxMU1lXRXZtWlA3eWRX?=
 =?utf-8?B?Y2MxYUp0MWxPYmJIaDFuMWRNcXVvZEwza0ZORmJsWU5mekQwT0g4MGhnU2l2?=
 =?utf-8?B?eTBUV0ZUWUlnN0Ivd0Y2RzBWY3pydWxJcUJnbjBta0xPek5KWVExMFN3Zlkv?=
 =?utf-8?B?SFROY2ozcmtzNjc1bU5YZFhMOFJsU1VOQk5ZUWZUaWxLTXJoNUJVZmxvSEZl?=
 =?utf-8?B?bHN3YjF3YmZjUDdVUDlCeWdORWNVQzBNY080Yk93TFluQXNkNmYzTTlOR0Jy?=
 =?utf-8?B?WUZnelN6VFBJMm55blljMnJMbU9kQW1mTXdGbk9Xb3ZCU0VmZmJwUTFXTWZ0?=
 =?utf-8?B?SnNlUDJYaHltd1h4UlFqNmlkN1VXclV0aXBtN1ZOSHlFVU02RHBidmJlTUgr?=
 =?utf-8?B?STVVMFBCeTJ3VHM0SUh3KzVqOWpaZmRqTVZpTGFTWjF6U2V0c2xFdGpETDd5?=
 =?utf-8?B?VWQ1dHBsOEQySFJ6VzVHak10aDczVTkyakowK1JYOWhqVnNING02UmNMemRP?=
 =?utf-8?B?ZzJXb3VYYTJoZEZNMXFTa0k3NkFidU81bGEvU1VsTGIyUlJCTldZZjVteTJn?=
 =?utf-8?B?dThCbG84U0crdzJNdTd2R21Nd1RWdjcyanBjNTBpN2JyT2hJN245N3BPT1R6?=
 =?utf-8?B?RWdLdG42ZW5IYzgvL3UyblZaMVNuWEllTlBJdHpHUGJxdUQ0SVBrZEFPN0F2?=
 =?utf-8?B?dnpnbzBVcGkzaTlHSzlGWEVGdEp0MmFlSDZ6T21RdGxIOHRwQ293NUI5ZXhR?=
 =?utf-8?B?dXZSMnJIaFg4UmtGNTZseTUvT0d4Tmo1N0lWVGJTOFIvSTJKeWpoZVFOdjdB?=
 =?utf-8?B?ZTRtTEh6a09oUUhVSzVwU2dnSDE5RGpRNXlQckluZGJ1ZWFmZ2hjWkI0Unpl?=
 =?utf-8?B?QVdrd25TcEx6NW14SjlIWS9aUXBBbzVKY29BZFBCZWtONkp6by9VUkdZeHph?=
 =?utf-8?B?NFNCV1BYRlp1VC9FSkp5WjNlTG95OGRaWmhFS1Y4MHpLaUFnVnFVVlh0S0c4?=
 =?utf-8?B?VUcyUmVacXE1aVhkK28xWE5ZbUJaUWJER0luaWg2TjZzZkdGUlg1OEwyWmU1?=
 =?utf-8?B?R052Y1RBSC8rVzA3M004Z0kydFBHSmJXQmxyTlBLcVBvT3h5VHZJUjZZU2kz?=
 =?utf-8?B?L0cxbXdabjlMVkNhRFhRNkpwOGRCR1dWRStCWEpmLzU0SnNCZlhZNStlc3V4?=
 =?utf-8?Q?ay4EdbML+OEDVZ4VhfqysHmeu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669794f8-d171-4dce-061e-08dd0d7b86ef
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 18:03:56.1330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoH+/a3l43jSyouskFjjHBs3cdChyzUzKw2WFoTvhWtetU/4qghW0tA0WBVShawg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8228
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



On 11/25/24 11:35, Heinrich Schuchardt wrote:
> On 25.11.24 11:02, Michal Simek wrote:
>>
>>
>> On 11/25/24 10:21, Heinrich Schuchardt wrote:
>>> On 11/25/24 09:32, Michal Simek wrote:
>>>>
>>>>
>>>> On 11/23/24 22:45, Heinrich Schuchardt wrote:
>>>>> The CI uses the following command to launch xilinx_versal_virt_defconfig:
>>>>>
>>>>>      qemu-system-aarch64 -M xlnx-versal-virt \
>>>>>      -display none -m 4G -serial mon:stdio \
>>>>>      -device loader,file=u-boot,cpu-num=0
>>>>>
>>>>> 'usb start' or invoking eth_bootdev_hunt leads to a crash when function
>>>>> dwc3_core_init() tries to access a register at offset 0xc704 (DWC3_DCTL)
>>>>> relative to the register start address 0xfe20c100.
>>>>>
>>>>> Disable CONFIG_USB_DWC3 until the driver problem is fixed.
>>>>>
>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>> ---
>>>>> v2:
>>>>>     new patch
>>>>> ---
>>>>>   configs/xilinx_versal_virt_defconfig | 2 --
>>>>>   1 file changed, 2 deletions(-)
>>>>>
>>>>> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/ 
>>>>> xilinx_versal_virt_defconfig
>>>>> index c8f166c1221..06a240173ba 100644
>>>>> --- a/configs/xilinx_versal_virt_defconfig
>>>>> +++ b/configs/xilinx_versal_virt_defconfig
>>>>> @@ -153,8 +153,6 @@ CONFIG_USB=y
>>>>>   CONFIG_DM_USB_GADGET=y
>>>>>   CONFIG_USB_XHCI_HCD=y
>>>>>   CONFIG_USB_XHCI_DWC3=y
>>>>> -CONFIG_USB_DWC3=y
>>>>> -CONFIG_USB_DWC3_GENERIC=y
>>>>>   CONFIG_USB_ULPI_VIEWPORT=y
>>>>>   CONFIG_USB_ULPI=y
>>>>>   CONFIG_USB_GADGET=y
>>>>
>>>> NACK. That's not the way to go. If one test is failing in CI disable that 
>>>> test not really support which is for HW too.
>>>>
>>>> Thanks,
>>>> Michal
>>>
>>> Hello Michal,
>>>
>>> It is not that a single test fails. USB is completely unusable on the board. 
>>> 'usb start' leads to an immediate crash.
>>
>> I am not applying any patches on SOM with HEAD and usb is partially working.
> 
> Don't you see a crash when executing 'usb start'?
> What QEMU are you using?
> 
>> I can agree that it is not super stable with upstream only patches but that's 
>> different story.
>>
>>>
>>> The problem already existed in v2021.01.
>>
>> Any log?
> 
> $ git reset --hard origin/master
> $ make xilinx_versal_virt_defconfig
> $ CROSS_COMPILE=aarch64-linux-gnu- make -j$(nproc)
> $ qemu-system-riscv64 --version
> QEMU emulator version 9.0.2 (Debian 1:9.0.2+ds-4ubuntu7)
> $ qemu-system-aarch64 -M xlnx-versal-virt \
>  > -display none -m 4G -serial mon:stdio \
>  > -device loader,file=u-boot,cpu-num=0
> 
> 
> U-Boot 2025.01-rc2-00172-g880fcc49eb40 (Nov 25 2024 - 11:18:35 +0100)
> 
> CPU:   UNKNOWN
> Model: Xilinx Versal Virtual development board
> DRAM:  2 GiB (effective 4 GiB)
> EL Level:       EL3
> Core:  32 devices, 13 uclasses, devicetree: board
> Warning: Device tree includes old 'u-boot,dm-' tags: please fix by 2023.07!
> MMC:   sdhci@f1040000: 0, sdhci@f1050000: 1
> Loading Environment from nowhere... OK
> In:    uart@ff000000
> Out:   uart@ff000000
> Err:   uart@ff000000
> Bootmode: JTAG_MODE
> Net:
> ZYNQ GEM: ff0c0000, mdio bus ff0c0000, phyaddr 0, interface rgmii-id
> 
> Warning: ethernet@ff0c0000 (eth0) using random MAC address - 5e:f6:37:a3:68:24
> eth0: ethernet@ff0c0000
> ZYNQ GEM: ff0d0000, mdio bus ff0d0000, phyaddr 0, interface rgmii-id
> 
> Warning: ethernet@ff0d0000 (eth1) using random MAC address - 5e:8a:ec:a9:d7:e8
> , eth1: ethernet@ff0d0000
> MMC: no card present
> MMC: no card present
> Cannot persist EFI variables without system partition
> Missing TPMv2 device for EFI_TCG_PROTOCOL
> Missing RNG device for EFI_RNG_PROTOCOL
> Hit any key to stop autoboot:  0
> Versal> usb start
> starting USB...
> Bus dwc3@fe200000: "Synchronous Abort" handler, esr 0x96000050
> elr: 0000000008068fd8 lr : 0000000008069940 (reloc)
> elr: 000000007ff17fd8 lr : 000000007ff18940
> x0 : 00000000fe20c100 x1 : 0000000040000000
> x2 : 0000000033310000 x3 : 000000000000003f
> x4 : 000000007ffa74b0 x5 : 000000007c112880
> x6 : 000000007ffa74c0 x7 : 000000007c300000
> x8 : 0000000000000684 x9 : 000000007bda668c
> x10: 0000000000000003 x11: 0000000000000188
> x12: 0000000000000000 x13: 000000007bda6be0
> x14: 0000000000000000 x15: 000000007bda6224
> x16: 000000007fee9244 x17: 0000000000000000
> x18: 000000007bea6be0 x19: 000000007c111b48
> x20: 000000007c111240 x21: 0000000047822004
> x22: 000000007ff998b2 x23: 000000007ff998e8
> x24: 000000007ffd4514 x25: 0000000000000000
> x26: 0000000000000000 x27: 000000007c111130
> x28: 000000007c1110d0 x29: 000000007bda67b0
> 
> Code: b9030660 f9416e60 d5033fbf 52a80001 (b9060401)
> Resetting CPU ...
> 
> resetting ...
> 
> $ cat u-boot.map
>   .text.dwc3_core_init
>                  0x0000000008068f24      0x6a0 drivers/usb/dwc3/core.o
>   .text.dwc3_of_parse
>                  0x00000000080695c4      0x310 drivers/usb/dwc3/core.o
>                  0x00000000080695c4                dwc3_of_parse
> 
>>
>>> Do you know of any QEMU/U-Boot combination where USB ever worked on the board?
>>
>> Why was this visible in CI in past and why this pops up now?
>> What has changed? I don't think there was any change in QEMu regarding USB but 
>> I can double check.
> 
> We never started USB in the CI.
> With patch 6/6 of the series usb_bootdev_hunter() is invoked which starts USB.

Did you push this to gitlab CI? Which test/py is failing there?

M

