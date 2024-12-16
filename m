Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB7EE7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 09:51:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E30818005B;
	Mon, 16 Dec 2024 10:51:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZfJ7wD8S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D4CC80104; Mon, 16 Dec 2024 10:51:53 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::613])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1D248003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 10:51:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFjLeeIlo9jbUyAaMrTloG6+6x0HWIW3FicGuKucwR+RMBn7l2IdxZ66uFgY24ya6L2XVflUbAgC7ZH645evFJxutcg1qYIJx+BI+vwnntIKoRhh71r19ZDaHOF1WYkmplrWDgHKo9cDI5cyinjFbZthoqzSha0m5gYJbv+3cMmZBehUgaMu95uZVy8u3M0Rq5Os8Wz4NcWX1uMDg3hWmjk4BlPzZqcNT+DU1LS+YX1zd0tfTtMiZhWUdX1Ls+4/FyCJkCIJU8fNF7aQHuZgbCqtL0k7fgAqf8rfOgHktb6FRN69iA5vrTuyqBmTPP38WWkQHnrrAqRxw4HWWwK46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntTx0R84cH13RhPSA2K3QXyQc/psxnPFqcYgi6VSdO0=;
 b=wJtgC+T4pXgDcp8yO+EnDx8yDTQSRjPQlluwsyBDbPvyjfWH9J6o5gapCoTWByPxtu94vHMeUqcGhzOTsrCelWrIM698LlzRHCYx0rlWlfnu3MU+EZ4g4RYiLK9PEvHulPyE1xrMGZ/1IJIpbOS8Yz7q09NSY1X1ET0ZokncbnZ6SZSpH6poDkJ+QEiHNyenxoHpv9kKmhQ/VyqjeRew0efLPi7H1nVo4sQX2VkSKyULESPb8xofH8gCQ/D1XpvOo2Z2L6H1OK7quO1WCjTZGfWgJbwsl3Y2a94EwpFG/FVLFoYXb8hTEf4FqPNi1eo6pMCkWukKCBFKhHsbMscFbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntTx0R84cH13RhPSA2K3QXyQc/psxnPFqcYgi6VSdO0=;
 b=ZfJ7wD8SdKxcZkQG8XnDnuTXBV5NGCF+MRtETolVcjSHxp3eaKBYf5bd+PA0cDd1t1UUQgKPPdcGA2/hSl6hXuGHeOGnQ4EU5vEJmVO6my0RCXqArZOZ0lp9OjQoxIMwo+chhBrrM3W1ven06IGor9+nGwoLzVKJvCYfTeReZlU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 09:51:47 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 09:51:46 +0000
Message-ID: <7a2f0d20-66a3-4845-85c7-6e0194342659@amd.com>
Date: Mon, 16 Dec 2024 10:51:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cmd: Add support for optee commands
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 jerome.forissier@linaro.org, mkorpershoek@baylibre.com,
 akashi.tkhro@gmail.com, francis.laniel@amarulasolutions.com,
 ddrokosov@salutedevices.com, git@amd.com
References: <20241216092958.1230455-1-venkatesh.abbarapu@amd.com>
 <20241216092958.1230455-2-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241216092958.1230455-2-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::6) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 8879cb8f-d78a-4cc5-db2e-08dd1db740d6
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RW1EMThKTDhQcnlJTTFweFBYY0Z2aktlS3RTTTZ4SE9YaGVxa2lzQmdkemMw?=
 =?utf-8?B?bSt4dXhkQ0tUZUxQVVZmRm9OZnVUd1c5YW1JSFBBOGwzQmxyZFpqaU05Qjgw?=
 =?utf-8?B?d01YMWdhWDUwVEthQlBuMmFuZDVDQ1lCYk1hRVlGbUVPUVhxWDhEQ0F3SmxN?=
 =?utf-8?B?QkFXVTFHT0hKK2Q2ZG55cUFMaUViRkpsaFh0Nit3STVjdTVOUUFlN0UzbTVs?=
 =?utf-8?B?YnlJUnVEVkdlbGJwalBHNDJWZ2R5M2JHbks2Q000UmRlYm9nbVorNUFKVDlB?=
 =?utf-8?B?cFVoSWJYL0dkeXFJTmthNmlJV1pJd21VSkpnajJkblZibTZCL08zaUdnc0dN?=
 =?utf-8?B?Qkc4VnpTNXRScGdsZFlPVGs4cWx4bkpPdFJqTEh2SG5ZS2Jaam14eFYvVXNv?=
 =?utf-8?B?d1lVOXM0S0JmbmNHbmR2WjdUZ0dwQkVuRDF2T3ZkdGprOFFwQUtHYTAzaFBZ?=
 =?utf-8?B?Z1J4VmdZNDNMaUdGMzg2QTJrZURLRlJFTHpSTTF1OHFvUDdENHNkNDE5ZzVM?=
 =?utf-8?B?M3hPL1BKd0lWZ0dyY0hHL2I1QkpGcFdMTGo3cDhnRkdzTmNBaDUzUmhnY29w?=
 =?utf-8?B?bXYrOURXVXRqNytIbXV0ZVY2RkQ3OFZIVno5RGxIQzQvb2ZUVHU4bTFVclFG?=
 =?utf-8?B?RHJISFN2N2lrT3YxUjlOYU9wV3BKejd0aUlGSUx0ZHVJeWM4TkRQRkFoNDl0?=
 =?utf-8?B?WHF1dHUzMTdWY3E2aCtLNkJ2UjZ4TUJYUHNEb2dKZmxTSUZrdFlnUVlSb0ZI?=
 =?utf-8?B?Qk1sb0tJUG9yLzVaVnpJdytUSDBtWEEvdFMvaExDdERnSStxakd1ZU95WkYz?=
 =?utf-8?B?VlZubFJGYitWb1p0ZEs0OEc0U2JKMUVtVS83aUJ1NlJZanE5ZU9BT1RPYlp3?=
 =?utf-8?B?NS96WUo1ckJpVEZoZFRjTlRHbGdNazZ5b283NnZzMDk2cWJDbDJNa3pWN3gz?=
 =?utf-8?B?QVZsTUtvK2ViYWNtaUttbFh3K2FlQTE4NDhXTWpXQm5mODdBV2JMN3hid0Zz?=
 =?utf-8?B?VTN2K3M1Q09aMjltWmFmeDR2aW1MTlN2bk1NdFAzVzcrSVBuSXB1dC80OE5C?=
 =?utf-8?B?LzgzWUJKSnpaMmR4OHFhM0ZqN3F3S2h0b3JoUGlwTmNOaG1CM1o5NS9SdHN2?=
 =?utf-8?B?VzhqUmhFeTRINExOYU4zTmlGQUhGTGlVbk5JT25oVXVjUHdZbHBqY1FraFUr?=
 =?utf-8?B?aUZWSzJabGwvY2dYYmlZYWJKckloUmlRQUJKSDJiYVpYZHpHZWxIYVUvZDJZ?=
 =?utf-8?B?MXNSTU90TEpXaVgwZGcxMlpBaitEdzE0V05UYnNiRnV6bmJBaDVyckNrUG9h?=
 =?utf-8?B?TmtoQTN1cXV1MDV1dldyVnViZFNIUGF2K1p2V3NmbWNWUDlxMVBadnQ0azhK?=
 =?utf-8?B?b2VrbEJwQzlGUDNJdk5NSUZwdnNDK1V3N205WGpmWWN1MzdWaDlNS2RtS2Ew?=
 =?utf-8?B?OEtZakdEdWxwbmViV25tZHRhNGdMdGNEQmlNWGVJZmNialNxbHg0QkFKdHIr?=
 =?utf-8?B?eDJEb0lLWjBQYWJVOXlWTW1Sdkw3SnY0eFJoRFBpcGg3WWNHOXFxcGZmdTlV?=
 =?utf-8?B?czFJSHRmSFV5alNjZEpWQm82RnRQbEhpdWRPdWYvak1PcEN2bkZTekhTNHZI?=
 =?utf-8?B?TUx5TUdHZ0IrRzdQd2RQNTdqVlNrcno0Nk9RQlBtcTJjRHpua0YvVzgrNXM1?=
 =?utf-8?B?bW5ONmFuVkJRODV1OUtLQnhCMC90L1VSNjM4dVR4MmpDbWRBQis0a1piaGpk?=
 =?utf-8?B?L1J1ZUNYL3lBbWVSMnNzUDVMSURDYjlLdDNyZFUwSWh6dno5SEU0ejZYc2xY?=
 =?utf-8?B?VnlGRFJ6N3NIL2RaQWRoZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnEzYS91Z2FERUtiSVBGbm1ScERYYU9UYUpDeHpoeFE3UDVxWFdBUzRzM21E?=
 =?utf-8?B?QzJFYm92aXl6L3JZWjZ1ejRTVU43bkFNcHh0SXUzalVGRmptZk5xQkhZdzYw?=
 =?utf-8?B?cE1UV0Q3WmZLTWEvV2ZaNC93OWRQRnJzOERycW5mM3hsK2lVSHV2SHppa1d0?=
 =?utf-8?B?VHVSSVdWVmxtL1ZlaXhKdzNZZWJpM1BuRzhiQkhzQnNrQUFjOGsvWmk0OHB0?=
 =?utf-8?B?VHV1azdRMUJxWXo2c1V5QWR6d1hRaUtUakJmNERLRzFLWE4vSGNzMFQwbExm?=
 =?utf-8?B?WThNcHdNNzg0cnJFSWE1TmFkQmJWNTdia1NrV2F2Z2FGWWpNYmRTSjdoRU9q?=
 =?utf-8?B?b0FYUUczNERUSmxaQmtIT2JUdUhUejN4dFNMa1ZUMXhaODQxaU1lL1NrQ29i?=
 =?utf-8?B?bnFSTys2NGRVTE4wUjd3dDkwZGIvTEFWR0NPMytvY3M5QlpnMS9hUkJQa1VO?=
 =?utf-8?B?L0RaZ09uZU9WYitxb0JPN1FjbGgvK0ordkF5VmFnTktKQkFHOFBtZnEyRzBx?=
 =?utf-8?B?UGVWVlAzRWo2MVhxcGs0SnNiMlJJNm53a3MyUXlMVVcrbCtXZFQvZDJDUnI1?=
 =?utf-8?B?ZlJZeEloa3BCOGR0NFV6REgveitEWlNqRmY4Y0I0QkU4RzRqR1lLYjNFVFNv?=
 =?utf-8?B?U2liWDZXd3l6UHU1VEZOUXdJbTlBd2xkVzdDYktTYUpZd1NuQnhoVkVqVnVV?=
 =?utf-8?B?K1RyT1BYbzFINGNiYUJMK05aYkF1Y0NuNVJ6RkZKUnpvS2h0UUZ1RjdVbnpn?=
 =?utf-8?B?dVNCNFdtdnFlV0hwU2dVRkEyZEZQWGg3dEtCeDJxbEkvdHppZDBXNXhQRkFy?=
 =?utf-8?B?VCs4akhhNWVUd3RHM1BsSThZZ3VJZ1VSTFV3T2Y3NkcrazRNcUtHY3N3R05x?=
 =?utf-8?B?S1FyNmhiWkkvSWlPbzF3a2tDWXNGYnFwenZTeE1YNGRtRmo5TUpYN0hmcVU2?=
 =?utf-8?B?dE9ZTHdXWlJoM2tJdHhDWkNMQXQ1Y0ZOVkxYUU00WGQ1UkNSODkveGE1VmNW?=
 =?utf-8?B?QTl1dlZzY2xQaHQ0SzhhQ21MMkhKdWx1YjdRMlE2REZyYzVVQ3Z0eUx5WVBz?=
 =?utf-8?B?aUQvbG9IN3BuZXRzSVhYSVF1cWtrWnYzT2NOZ2t2M2xHTDMvY20wL0hENnpp?=
 =?utf-8?B?UkdQemdoR0YyeTBYNXZmeDBlNmNqdkQ5UTYzd0I1QVRvZ05IYm1neXJEOVZQ?=
 =?utf-8?B?SjlKcHFIQjhPZnpMYjNVRHA3QzRUZVJsbjRGSXNqTzVON2NOTGJ2MTUwdFNu?=
 =?utf-8?B?bmZJc3liWmVTTFVyYVNXdTVPdGI1eDFGZXQvbERpZUpEZzRsc0NSNGsrdjJh?=
 =?utf-8?B?T0pVdXZSdVM5UzQxcG1sSVdncWxRMnNPK0JFc2hXMURiWFIrNnc2V21rZzdJ?=
 =?utf-8?B?aC9RODg1L2ROYWlGTlp0L0F1ME1wYks0U25PaUk4L2luTTJBejdPOU9wa1gw?=
 =?utf-8?B?ZHJ3K2ZNV005ZlBlZWY3WXV2ZHBPRWdPa3QxT0NiUDZZQUlhdE1YbHdQMHo2?=
 =?utf-8?B?aGY5N0RZMllwbWtSbTJlc0VCVXFDN3JoQWJRcCtreEkrQkMvcWZaRk94Y2VF?=
 =?utf-8?B?Z2d2L0pjTHpwS1RtT2s5cWhFMDdrc2tmay9jSDJmbjBvMTRmQUJpbGU2T1dG?=
 =?utf-8?B?U2hvQzM3eVMvOTN6dTYvTzhpdDlCT2hSMHFiRGNhdnY1TGxwRzROaENqc01T?=
 =?utf-8?B?UmVabCtjQXdQTzVkUTBYdU1LMElEMmFPUCtsZWE3ZVN3RVY2Sm9kMGlGR1ly?=
 =?utf-8?B?SnFET0lJVGZEYU9QSGJqYTNoc1JYZEhiajZTSmFJTFBUeEtBdmg0U1FFaU4v?=
 =?utf-8?B?TGxsWS9MOUwwNktUTnp0aEppOHRDY1FWOFFrdmdyVllYeDkyS01kQ2htT25o?=
 =?utf-8?B?eld5VldzMEtnQnhtV3hHK3R1c3dGdWxOc1piSlJOUVVpc3RudVZNUkFSdkJi?=
 =?utf-8?B?SUU0WEU5MHZIUlN5YUhhRHVoK2VpYyszT3orK3crOTVGb2x3bFBxS2VjdFNK?=
 =?utf-8?B?dHByZFBoUjFSVVFteTdpcGVDc2F2UE14ZzAxTXMvYU1OTTV1ZDA4UEF5WGJB?=
 =?utf-8?B?b2JZcXQyYjFEbW1ZdmRaOVZ3OXFaR2ZUdmVJZisyU1NFTmFpRDJ5cjRkbm1m?=
 =?utf-8?Q?ScI39TSmZZ2pQvtDC13T8yBVu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8879cb8f-d78a-4cc5-db2e-08dd1db740d6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:51:46.3161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Nzt3JXcr16rUfYBNjDj6KPDG1Bf2cplOXmXpg72fLBky8DD1zhyTYL6yOxqdagN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
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



On 12/16/24 10:29, Venkatesh Yadav Abbarapu wrote:
> Add the basic 'hello world ta' command which increment
> of the value passed. This provides easy test for
> establishing a session with OP-TEE TA and verify.
> 
> It includes following "hello world ta" subcommands:
> optee hello; default value '0' is passed and gets incremented.
> optee hello <value>; value to increment via OP-TEE HELLO
> WORLD TA.
> 
> To enable the OP-TEE side HELLO WORLD example please refer
> https://optee.readthedocs.io/en/latest/building/gits/optee_examples/optee_examples.html
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   cmd/Kconfig  |  6 ++++
>   cmd/Makefile |  1 +
>   cmd/optee.c  | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 100 insertions(+)
>   create mode 100644 cmd/optee.c
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 1d7ddb4ed36..4b33468891e 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1446,6 +1446,12 @@ config CMD_OPTEE_RPMB
>   	  in the Replay Protection Memory Block partition in eMMC by
>   	  using Persistent Objects in OPTEE
>   
> +config CMD_OPTEE
> +	bool "Enable OP-TEE commands"
> +	depends on OPTEE
> +	help
> +	 OP-TEE commands support.
> +
>   config CMD_MTD
>   	bool "mtd"
>   	depends on MTD
> diff --git a/cmd/Makefile b/cmd/Makefile
> index d1f369deec0..533d0f6a1be 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -118,6 +118,7 @@ obj-$(CONFIG_CMD_PAUSE) += pause.o
>   obj-$(CONFIG_CMD_SLEEP) += sleep.o
>   obj-$(CONFIG_CMD_MMC) += mmc.o
>   obj-$(CONFIG_CMD_OPTEE_RPMB) += optee_rpmb.o
> +obj-$(CONFIG_CMD_OPTEE) += optee.o
>   obj-$(CONFIG_CMD_MP) += mp.o
>   obj-$(CONFIG_CMD_MTD) += mtd.o
>   obj-$(CONFIG_CMD_MTDPARTS) += mtdparts.o
> diff --git a/cmd/optee.c b/cmd/optee.c
> new file mode 100644
> index 00000000000..618a2f8490e
> --- /dev/null
> +++ b/cmd/optee.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * (C) Copyright 2024, Advanced Micro Devices, Inc.
> + */
> +#include <command.h>
> +#include <errno.h>
> +#include <tee.h>
> +#include <vsprintf.h>
> +
> +static struct udevice *tee;
> +static u32 session;

Can you please also get rid of these? Just pass them via parameters.

> +
> +#define TA_HELLO_WORLD_CMD_INC_VALUE 0
> +/* This needs to match the UUID of the Hello World TA. */
> +#define TA_HELLO_WORLD_UUID \
> +	{ 0x8aaaf200, 0x2450, 0x11e4, \
> +	{ 0xab, 0xe2, 0x00, 0x02, 0xa5, 0xd5, 0xc5, 0x1b} }
> +
> +static int hello_world_ta_open_session(void)
> +{
> +	const struct tee_optee_ta_uuid uuid = TA_HELLO_WORLD_UUID;
> +	struct tee_open_session_arg arg;
> +	int rc;
> +
> +	tee = tee_find_device(tee, NULL, NULL, NULL);
> +	if (!tee)
> +		return -ENODEV;
> +
> +	memset(&arg, 0, sizeof(arg));
> +	tee_optee_ta_uuid_to_octets(arg.uuid, &uuid);
> +	rc = tee_open_session(tee, &arg, 0, NULL);
> +	if (rc != 0)
> +		session = arg.session;
> +
> +	return rc;
> +}

Maybe I would even consider to move content of this function directly to code 
below. It will make example more compact and you don't need to use that static 
variables.

M

> +
> +static int hello_world_ta(unsigned int value)
> +{
> +	struct tee_param param[2];
> +	struct tee_invoke_arg arg;
> +	int status = -EACCES;
> +
> +	printf("The Hello World TA is going to be called\n");
> +
> +	status = hello_world_ta_open_session();
> +	if (status) {
> +		printf("hello_world_ta_open_session failed(%d)", status);
> +		return status;
> +	}
> +
> +	arg.func = TA_HELLO_WORLD_CMD_INC_VALUE;
> +	arg.session = session;
> +
> +	param[0].attr = TEE_PARAM_ATTR_TYPE_VALUE_INOUT;
> +	param[0].u.value.a = value;
> +
> +	printf("TA value: 0x%x\n", (int)param[0].u.value.a);

Don't you want to remove this line completely.

> +
> +	tee_invoke_func(tee, &arg, 1, param);
> +
> +	printf("TA value: 0x%x\n", (int)param[0].u.value.a);

And here just print directly origin "value" and then new one via one print.

> +
> +	return tee_close_session(tee, session);
> +}
> +
> +static int do_optee_hello_world_ta(struct cmd_tbl *cmdtp, int flag, int argc,
> +				   char * const argv[])
> +{
> +	int ret;
> +	int value = 0;

swap these two or put them on the same line.

> +
> +	if (strcmp(argv[1], NULL))
> +		value = hextoul(argv[1], NULL);
> +
> +	ret = hello_world_ta(value);
> +	if (ret)
> +		return CMD_RET_FAILURE;
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
> +U_BOOT_LONGHELP(optee,
> +		"- commands can be verified on OP-TEE\n\n"
> +		"optee hello\n"
> +		"optee hello <value>\n"
> +		"\n"
> +		"With:\n"
> +		"\t<value>: integer value\n"
> +		);
> +
> +U_BOOT_CMD_WITH_SUBCMDS(optee, "OP-TEE commands", optee_help_text,
> +			U_BOOT_SUBCMD_MKENT(hello, 2, 1, do_optee_hello_world_ta));

M

