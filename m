Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88B1C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 20:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30AD8807B1;
	Mon, 24 Feb 2025 21:07:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="mOAdeyon";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E278080977; Mon, 24 Feb 2025 21:07:34 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 805FA805C3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 21:07:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLmfE4Mq4VoI0vYJz7B612zTFnxJUcF8jNxzs9qfGCFXNtfjieXdmgv+2U+etLltjn4pCuny1k+f5LeDTfQAhKx0EAWIT084WNvg+YgirRNl0Z2thIegTr/CXj8Vf8HaowGcmv5B1rkzMC9IrtPWO+rip93AjVwKnSnYq4rlVuwA1TTTP+hOuN6v5GLmGqWGQmCy9Hb59BZ+8CFu2v1vVim3HRM62sU88o36Tt4fN44urbnQsZUudqvNRc/EhlhvUpZ5DhaoJyhiE2RDH6jXo/shXQAJDW2nBXK+71loVsD5n0EQ/JdgdpjVCSbUh9bUSC2r8ZaRCffN3PJvM5JRGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clBLgtG0FtXIvoToQkDDowaOcIHyjFKwZc7YdtF/nMQ=;
 b=LQtDUoQGwOkiKJSaDhh3CsVmQ1E//lpvoRhKvDDJ5+X/zx7S0zair/Lww8Wd3IdaJEufJgl1Y6Cw+LjL43OSN25X83/BaWQ52eVa3lrLk63w0zcsXvIm77xkpbnfvQUHgYmzaSVdhan4q7g2TY10jMwTSp9NRdyO5tdJ6DKCX1aKTaqUiMj+bqegH6zfvAque+BiTXkcA21FYRFslFenpjyzmXCtoh26til1wS3nLqwNvCf3T9z9GOzD/h2JgHvQhLJLvL8Wvd8crPIyWItLBEgkgZ1BhRl/RJkj9cFyuqVh5WzAcnklXdyDw24Y0ZkBfmYCuIhzoe6RnXZXqtvhKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clBLgtG0FtXIvoToQkDDowaOcIHyjFKwZc7YdtF/nMQ=;
 b=mOAdeyon8KvOoUN5g9FOjt0dPSGrKLMgvYsuvy7vF+CWtEh5Eps6H77QjcqrrTMVC+1k7KFspX3+SNvdEHQXF47ZR/RpL7pLsrtpVJRhYJgowLUfR0vaL1pMGuPBFiSp08miGvPjpm9gFZj0WHftPy/ZH+tyes0nZUiqHXQvmDfpE7Bhti22ylHX0HfzU7KRH2kll2OnCwaGodreNW66/p0A12qnF7sicrAiOzRJjBLi5ZL0qjGPW3aVhHx87FMvsdgSaYceMfaTArAlUFtKHtb7qyYFzUy4qtoZxZPKgR7w5GbbSnx5gc6lYKVjeLtQ6MfpziSnGOC9lw5EFHvcZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from MRZP264MB3114.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1b::16)
 by PARP264MB5165.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 20:07:30 +0000
Received: from MRZP264MB3114.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9439:f4c7:f69c:c2e]) by MRZP264MB3114.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9439:f4c7:f69c:c2e%5]) with mapi id 15.20.8466.020; Mon, 24 Feb 2025
 20:07:30 +0000
Message-ID: <7bbb19ec-edeb-4159-858e-d5738b563565@softathome.com>
Date: Mon, 24 Feb 2025 21:07:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Add preload_check_sign tool
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org
References: <20250212093126.3722186-1-paul.henrys_ext@softathome.com>
 <174015949809.3526942.13114735137909191703.b4-ty@konsulko.com>
 <20250224163147.GA2318847@bill-the-cat>
Content-Language: en-US
From: Paul HENRYS <paul.henrys_ext@softathome.com>
Autocrypt: addr=paul.henrys_ext@softathome.com; keydata=
 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
In-Reply-To: <20250224163147.GA2318847@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA3P292CA0008.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::8) To MRZP264MB3114.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRZP264MB3114:EE_|PARP264MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: f906cb61-242c-4e9f-c9ed-08dd550ede53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVRhamVITFM3aHhRN3dNV3RlZ1lweVhFRjJyZGp0U2UzdTY1SktZU0h2c0NF?=
 =?utf-8?B?N1ZnTnYrMUs3QXczaDMzWEtBRGxJNFpnUE1xbUF4Qkp3dVZja0N5RVFvaG00?=
 =?utf-8?B?S0tNUkNDanpGWnYraVpvakhhTXNnT3VyN1BoanRIUjR6Mkc3SWpqc2tnSjVJ?=
 =?utf-8?B?ZXlBNjBCM2Q1dUFPd0FRZTBPM0ZYWGY4YUZvUkJOaHJIRUs4amtDd0t2cnIv?=
 =?utf-8?B?enZydkM4VFVzNExoR0pkTUxCS0Mwdk9ocEcwMFRNblBJZ0MyRGd0OXRXa2I0?=
 =?utf-8?B?YlFYdURxbEo2ZVdsQWg3dEdTUitvNm4vMThXMEpxZkE4Mm9kK0Y4eitZRGdr?=
 =?utf-8?B?UEZrTlVSQlFYeGpCNi81NjZKeEViWHhTU2l1N1JWN2p5aTNubmY2SHdyaDRt?=
 =?utf-8?B?cXZUaVNhV1pmSnlacVlaSUtWNXh6S2RGRW9rdFMza2dCR3UyVFJVZ0VZVGdU?=
 =?utf-8?B?cUE1TXhKblA0cGtYek9sNlpRa2VPQUtTZk0ySUQwTHRJQ1ZpclNMc0RJUm12?=
 =?utf-8?B?WUJZd3hMTnUweUN2NHNGenFPaEFzUnlEa1dvNTlsdzNzbk9NR2I1VVdqYXZT?=
 =?utf-8?B?N2dCWkFzNmF5SWZGMEIrYkEwVGpmamFBU1FrSGcxWTAycFhrVzMzZERmZk1t?=
 =?utf-8?B?NHNiU0NhTzZGWDVyQU95Z09wMWtJYUZ5TzFGZDBUUjE5VHZxaExqdXNVMjB1?=
 =?utf-8?B?OXBsd2llWHNwVEMra3lvejB1cDM2ay9zcjkxSkxhamFabEU0dkhucW11c3RK?=
 =?utf-8?B?VUZibGVFQkRQYU95bEtESFdmK1pXRkxRNWZiWG9RV2h4UHZZZ0tudTVnVGtY?=
 =?utf-8?B?RGZoL08yY0w4ejFENmRuaGkvSkttNHRCeUF5STBzRkhhQ1BiNzNoMmEvR1Zy?=
 =?utf-8?B?amdIUTkxckJaLzFVSFlmdWsvdk9GUFpwdHhIYmRsK0poU3BOYi9BckQyeGJM?=
 =?utf-8?B?TSt1OG5DdXpmaXVHN3FkVFRwUklKc2pjbS8zaDlnQmtMdGdJcUxuYzJxQlNs?=
 =?utf-8?B?TlBtdW00ZG5ZTUhMQjd0aTI5TmJleGNQOUZQOHIrL2RqOFFNWngrT21SaytP?=
 =?utf-8?B?NDJYYjJrMTBQRW9KY2N3VjZ6bmdDeFgrSnJXN2tkVVBPV1l6TENubnJVSlJD?=
 =?utf-8?B?S3FWU0tHdEw4MTlvTHMrWlVuRXA0bkIvY2lGSVpWVUVSQlZjZ0tST3BzSHBo?=
 =?utf-8?B?KytBNHF0OGRUQ0VOT3RmWnB4aUlkU3RsSVpTeHgrdWQxbVZGVS9hdjJKbnNL?=
 =?utf-8?B?QkQxSkhtTkZVMHNwb1M0NWpJaXBTd3Fnek5Ya1RrNkRLUTdOSjZYRzMvYWdK?=
 =?utf-8?B?VmM4K200alNFMXgzVDdHQVB2RHlycldQYTJnT0JFVXJNZ29hbXNqREE2Y1Zy?=
 =?utf-8?B?U25BUGtCbHk3Tm8raGdpZUZMZUJGVHNMVkJpdmRlbkY5UUFGM1dkaGpHL1R3?=
 =?utf-8?B?aEtTSmpsQ1dUU0lmM1B0bytQN1pxN2RKSU1kMUdud3FoeTkyQzU5NENhZFZ4?=
 =?utf-8?B?b0NvWkh3bFlpOW5lUDhabW1mRTgvNnJjaStiWFB3ZkNnUTQzNGZiNllBWkFx?=
 =?utf-8?B?TEZ0R3NxdnhCVGx6RDMrcklrNkp5aXJPS0tMU1J4ZFBRWVQvREFWeDVJcTFT?=
 =?utf-8?B?bm81eU9OemM0N3M5ckZRRUlOVDQrbWJDNTJTSjdiVlZZU3RHdDROS0RSVkVi?=
 =?utf-8?B?NmFnMXlOV0J0eDk3blV6Z3RGMHRKOTRKak5rWGZuODIwbTZuS3N2YlRidE04?=
 =?utf-8?B?RWlXV2sxelV1LytZYmNUbjlVY09wZW1Oa2xpaHlIMmpHMHFJWVZaL3NjT3N3?=
 =?utf-8?B?UU1Ta3IwVyt5ZjVadWo3MTFCN0dERW55UVZOSlAvVm1BQ2xwNXIvZm9UVXoy?=
 =?utf-8?Q?kKspb1cK19FjS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRZP264MB3114.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkRKRUpaWXh0TDVQRTBXQURwTzBFT1BpdW9od2VYbllWbUJ4dW9EWjhRQThr?=
 =?utf-8?B?TXJvVGZoMWplUDNWcnBiV0owK0Z5alRkMGV0c1QxYjlWcFFlbWZYY1NNQUF3?=
 =?utf-8?B?cHNJT0lvRERUQWdiT0taOXRIVS9jZC9iZjFtTFV1RE5YSHJxd2l0NnNIQmxi?=
 =?utf-8?B?N01rcE15QlpBcDlpckxHdyt5d2trUTlneTFpMnhJeXFYNGZJK05uSmZydXRB?=
 =?utf-8?B?YXNJUWM5dEhMRms3VExoUTVlTmhyWFJXdTZxZmNXYmMvTmVVckRjQllyY1pG?=
 =?utf-8?B?K0RuTkg4djB2YzB1MXdKSjA2Z3pSWVpodE1NYXNodkpjNzlXVWY3cnNEYXZY?=
 =?utf-8?B?RVVOSzcxcnVJTVBuRFpMWi9qTlJJYmRjWHhTcDRpSXlOK0tQZHJocEI1Zkhw?=
 =?utf-8?B?ZXBDdEJhUlVqWkhzSi9PKy8vc3hTWWYvMVhUdE1PU2tlMDZ6b1lVVkZSODFI?=
 =?utf-8?B?Um5PV0t5dnhJcWVtNXFPdWRwVnBwYTU2bjJiYlgwRGlBcU5UWHUrNlZJU1kz?=
 =?utf-8?B?dEdqWlAvM1RFeWVyQ09DVVpjVUEzQUd4RDY4K3haREhuUHNqelJZakI1U0o5?=
 =?utf-8?B?Ri9nZG9GcUxhcGs3QW5nd2lDR3ZlS3ZWck9qUmVRRUtYcE5tVjd3WUVTM1I2?=
 =?utf-8?B?NFdXT242ZVN5NHliS00yWU4xNHF3aXZVcUU5Q2lydk01emt5V29PVjNiKzZT?=
 =?utf-8?B?bUtTMEh4MmVQVEQ3MEN6YUw0Z1piWnRIT29HMVpEdmdKWGwzdXJackRLaUhv?=
 =?utf-8?B?QUI0RGttUzRnYVZKTGM2YWVLdzhJVEVOV2ZoVGdGejFuMGpUNG1ZUUo3dk85?=
 =?utf-8?B?ZGRSUFp5MU5HYzcrazVvQ21iL3dyUXdJbGtYc0ZvSHhTTGFRa0ZFcUtZRkxC?=
 =?utf-8?B?YmFVajk0SnBoRXNqQjB3aHl1OGtlc2JWU2dmUG4wZGVxNjExeUJEamlBdmRX?=
 =?utf-8?B?ZnNZOE9XdHNIQ1NZVzFrcGNiN0RSREFJcjlIZEFLWGh2cWo2NndSSW84MzhT?=
 =?utf-8?B?c05LZXRvYzE4Sm43ejNxK296WWI4UnhsUHJ6VSszUzlyWmFnTmhpZEJUcldE?=
 =?utf-8?B?WEc0QjFuNnh4RDRSdW1XL3NjYWpyS1dvaE4zRWYzdUxZaTBSYXZIL1NNazlj?=
 =?utf-8?B?TGFSM3ZpbkN3SFU1U04rOWg0R2l1SkpycGZhdEtldDFZK3cwVE12V0E2bmkz?=
 =?utf-8?B?Y01vWURrK0h0UmRrR3NLV0k4eURaWkcvM2lYUUo2Uko3dGRRS1d5UDdUZFMy?=
 =?utf-8?B?anhtTDhqSTd1ODh5MFZGTG5ZSmx6YmV5SlU5OWtma0J0dm12T3N1Y24zUzB2?=
 =?utf-8?B?eDdtRmJpemE1NUcxK0k1TGpyUXJQLzQ3YVYrU2hCQTU2Q0tGWFBGOU8zbUFj?=
 =?utf-8?B?ZDViUklJT05NVFBkdFZCa1F4cVpMZlFHZnA0YVFrZVByTWlqUC9ZVWJGNzIy?=
 =?utf-8?B?TE4vcjZLT25OVHhBc2hTbnpzaXo0VWRVenlnTVNtM2JMYTlLeUF3Z0l1ZHhS?=
 =?utf-8?B?TE9vYVZMZjVKUUo2eVUySGVML1cyR3pSVUcyUVdQb1FKVi9jUTBGdG5zczVX?=
 =?utf-8?B?Q2FtNjRGQ3ZIQ2UzNUdvS3hsRWVBN2xhcW1UVEFyYVNuSjV0Q3MxU09Rb2cw?=
 =?utf-8?B?cVBmRE5pdVU3MTBrZkR3T1NoQytEU2J2L2FUSGFOZU43NFNpaVpqbzR4ajdo?=
 =?utf-8?B?Q0Z1UDhZNzU3ZTA0VmJuTDU5cEQ1ZXFEaWUxZEVvL3BDdmlwanVzWnp1TUNn?=
 =?utf-8?B?M1cvRytXcUU2NmRDRWFyVkdtV3hXVXhESXdaTWxocWdMVkFINllxc29WcHNT?=
 =?utf-8?B?ZVovemFRRndDTEo3UWZtdHR5UytvWlFtSmt4U0JialFTUCtYcS90bWcwQVRn?=
 =?utf-8?B?a2NKU2JhdjBMZ3FnU1dhMzVzZWZCWE8zT3dVZE1objJ3MUtGbzNncmd2enFD?=
 =?utf-8?B?ZXRhdTBvL0NJWjMvK3FMMVpJajBNR0dmcGFyTW56OVV1VmtPR2p4UnF3UWhv?=
 =?utf-8?B?Yk5JUmx2U0xGOWxHbThDSFJGMGltTjhJbjJ6MWY3QTBZV3c5REFTNkpDMWRX?=
 =?utf-8?B?UXlhNllsdUJ3UU9UbHo2ME4zN0VCRUMrY2VWV09iRGY2cGJTREVqVm10VW9l?=
 =?utf-8?B?K0ovTzRjZmU4aUZDN0lxYVkvd2ZwallYTWxKNlBNZFdvWThqd2tIVU5EWVln?=
 =?utf-8?Q?HkxXT4mmq3OIbcD0LIoUIpc=3D?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f906cb61-242c-4e9f-c9ed-08dd550ede53
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB3114.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 20:07:30.5930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDDy8gQ/B0bSDpLxWiOocdzf2z2AyWLNDXiG+H62WWIsikfukzYJycxAhqwsiU2XK4Lg3Elc8Uo1LzDVGBnFKMvaGOhqbl1GBcukR3FKL5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB5165
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

Hi Tom,

On 24/02/2025 17:31, Tom Rini wrote:
> On Fri, Feb 21, 2025 at 11:38:18AM -0600, Tom Rini wrote:
>
>> On Wed, 12 Feb 2025 10:31:20 +0100, Paul HENRYS wrote:
>>
>>> This serie of patches adds a new tool to authenticate files signed
>>> with a preload header.
>>> This tool is also used in the tests to actually verify the
>>> authenticity of the file signed with such a preload header.
>>>
>>> Paul HENRYS (6):
>>>    rsa: Add rsa_verify_openssl() to use openssl for host builds
>>>    image: Add an inline declaration of unmap_sysmem()
>>>    boot: Add support of the pre-load signature for host tools
>>>    tools: Add preload_check_sign to authenticate images with a pre-load
>>>    configs: Enable the pre-load signature in tools-only_defconfig
>>>    binman: Authenticate the image when testing the preload signature
>>>
>>> [...]
>> Applied to u-boot/next, thanks!
> Unfortunately this breaks macOS building:
> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=10614&view=logs&j=35eccd4a-c7e0-5052-1111-1aa0b6b36326&t=e725091b-e4d8-5b5a-ef22-f51d8214ad12
>
> And so I need to revert this from -next, sorry.
>
In the pipeline, I see you seem to be building against openssl 1.1:

/usr/local/opt/*openssl@1.1*/include/openssl/x509.h:962:17: note: 
'EVP_PKEY_get_attr' declared here
X509_ATTRIBUTE *EVP_PKEY_get_attr(const EVP_PKEY *key, int loc);


OpenSSL 1.1 is deprecated and I based the implementation on OpenSSL 3 
APIs. Should I update the implementation to also support OpenSSL 1.1 APIs?

Best regards,
Paul

