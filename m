Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5059CC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 09:47:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBF9D88202;
	Tue, 21 May 2024 11:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="dSLFJ4en";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EEE088703; Tue, 21 May 2024 11:47:50 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21B9088131
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 11:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5yPCUQ7AtHusrdmVyclQi4j1IG56QocDmvCajo+92O6gIFlhGaYD3nMoP+X+Sa52MfrzQKQyI2ons5F/qa+v5iZVTlTHFbfIeGkvqVkVxvyMoiYk29WPKk093OMulw5hlDJmqeEHWPiimcKLG671BC0WJJCavQ9jq+gQKUFVifVv9vsTEMp7vKDdVIWrpTDf3ZWTEFSvPGAzyhUF7QOG4q0sAm/VmkZ5qtD/AFAltjm7n/biym4L8dsiKG8VPjGJ800mcJX3+BOrSAk63X3aoEvgyoCdkJKsNzuTXk89IENFRv0qRbsawtAOgrKbRErxH7DXCcZF+viUd5WQUAVsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yY4LsoaOkABGbPw5XNDsWB2GPoz1Y8ABX4GxW+x8t/0=;
 b=KkE/naIvKJtxo/8SDAboTYWtmrFsYEX5I8A6lySTYFnb3NuxwKVLX/qfkiFr3k2dFOuvUA1Gqs0+uiKhPyLHrgSoyfeFi1ArGn2ERnRBZPsWXEBN8SOvyzgzmEnxNcAXvTk136IOGopik3gsFXW9WY4YxbCOwS554eQCHnsfSj1U6kuidwLzCiEcgWuHnrkRbaycYYAqKODBCwNnokLObwcb4SuDs67eGrajUmMPd9OubBmwIwRNuYb/3Xck5m6JaLQxnqxyawuUkNg3ezDiJYtsxaayVO78RAGUb9aSu46AJyxx6fxQd0KG6UAdAZiRA8FbPNyAAl1WpwctF4Jgpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yY4LsoaOkABGbPw5XNDsWB2GPoz1Y8ABX4GxW+x8t/0=;
 b=dSLFJ4enJVehTBoADJSmu5IBQDYBaE2ZgD3MQ23DYPLnvjzA1qyuqMSakqFCpPBTQUBET1eAydkBV/2dEKRKLHyGqeBsGbREjyxoXXh9zDk7yb6N4tCkoWQpUMNPyIrchqSRGWlIxZqJolil0YrtOaNvkfaRB0aWFXengmrcB5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI1PR10MB8229.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1dd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 09:47:41 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 09:47:41 +0000
Message-ID: <ce12ad50-bd54-499e-965c-5693355a4e84@prevas.dk>
Date: Tue, 21 May 2024 11:47:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] cyclic/watchdog patches
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240521084652.1726460-1-rasmus.villemoes@prevas.dk>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20240521084652.1726460-1-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0002.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::27) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VI1PR10MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: e8749529-8701-4b8b-d848-08dc797b0ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bk5VSlVXNm5HcUJpNlBuS0dBT0orSG9ic3cwdDNXQ1FpVXhrYzhwN09VdVlq?=
 =?utf-8?B?Mk1mWGNpSUNvT1c1T1BnUG8rVmtVdUZjVCtDU0hJcXpUUXpVL0dvamE2Q0hx?=
 =?utf-8?B?K3cvREg3U2ZzMXpPbFFOb0pQNXMvdUZ6eVpacmFuK3FvUms2SUszOExZSitR?=
 =?utf-8?B?MHVMMEUwL3BPUGpteWpSOEozbXNoc2NaYTBzVjV1Wi8zcWhhQXhlcDg5WTNC?=
 =?utf-8?B?STk3RGo3MXlXUUNMeEtsR2FmcTM2b1ZVL3RibWJWOEhORXQyanVuRFpvQ21n?=
 =?utf-8?B?Q3BGczBjUkROMlEvZEw2UHBQZzJJVzBoelpEUGZFV0phM25GRTd2eTdDTTRk?=
 =?utf-8?B?MGlrWEVrdmZKams1VmhGTTVtVTdCUkRaUjMxUGt6YlJJSks3alhSTmdSaTEr?=
 =?utf-8?B?dnBEQWl4aklOYlBQS0dhWTF6Q3prQUd6MnNZS2drOFhnKzVNcDNldEl1Z1B3?=
 =?utf-8?B?OG54ZVZzUWMyWXFOKytQQlh0QzJUOFFqOWRhY3QydmpxVjlkYTFXZzVMVCtZ?=
 =?utf-8?B?a1J3N0FYNjFmWjBYdnB5S3B1K1dZUnJKZGFBc3lZR3d2U1hTL1lqYjFvMFdX?=
 =?utf-8?B?OXc4ZldQZnhJRnBjckQ3WjZxV3FpNmlJNnNsQkxVT2piT1NEbm1IbmtRdU10?=
 =?utf-8?B?cjBwd2VyQ054MU50OTZRWWVTczRqc01aREhsUy9pdVVmMWhjOHlhM0VuRGF3?=
 =?utf-8?B?VWY3cjd0L2haWTFIaW1iQkkwU2ZZcXV5ZlVoVnJQeXlJNXE3ZkhUbzdsSVha?=
 =?utf-8?B?ZmhuN2VLenZ1M0tqNmwxMDFDV3RwTzJUV0hDQTY3eGhJRXhBaGh6ZVpXalMv?=
 =?utf-8?B?d0RGbFF1b3pIVW5NVjhmekEwN0lRclNzek1uNE5CQUljbGZGMExPeEkzQVpE?=
 =?utf-8?B?VE1WMDUzN2xJWFMxRDFDUFY4dkpLS21sVmdwU1RLQkdtWXFrd2U4Z2o0SXFj?=
 =?utf-8?B?Nk5mTjNwNzlxYzVkN1lNallsakttcHpxOEtFcUZCUFdqTlBWa0NEVWZFMWdm?=
 =?utf-8?B?OUxtQkMwTW5EOUNCVkN2ckJNUnJmSllQVEltcVdSKzFDc0lLbjJZY0ZueEN3?=
 =?utf-8?B?cWZENUltQWlOSDBHUXZsT2JBOWZjeGlLNkhScWwrZWVHUURkeHplNlI4NlBL?=
 =?utf-8?B?NWF3V2RMa01sSExmSTVtc0w3RWdRS3JpVUR1VjJsTVlrRGYrclMwYnpJelIx?=
 =?utf-8?B?ckJMb2ZKSEo2aXdJc3hBL3RUNjhURk9BQ3NrNGtCZW1rRmtwUGFENzFsVkY3?=
 =?utf-8?B?NUpwamRvbGFTREhkZEJxcFhxeWpYNlhMcE9WQVEzTnAyU25SbWluazVjeDlD?=
 =?utf-8?B?Si9BWC9NeVBQVnU1U1FMT3N6NTV1MWx5ejBTb21VaDJYUmZvVktGMi9TZ3lF?=
 =?utf-8?B?djFSTWJFYkIrZjJHaHhHNFhpbmhrTFB6V0tFcUw4OGhuN0JOV0VkNVRKS013?=
 =?utf-8?B?RjkzTVpmVW1VYnpNZXdGM3VKVStORlpUTFJ0MTFqVzZqbFYvY1VMY0VyU2Vq?=
 =?utf-8?B?Qm1RY2FPWEovS0FUdnZoek9vYXIzdm0xQWVrdmJhdWNIc0h4STNzVW1OWjNT?=
 =?utf-8?B?RzcwZ1NtSjRpYmkxamh1b0ZPbkVxL1c2MFNlUG9UR21sS1dtZmQ3Z05wcFcw?=
 =?utf-8?Q?Taycezcsh12SMvtwIBHfuz7NnJh8D9gVmxjA7BGpZmJ0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkE0UDlKUEFlelZOTE5xT0ZDb3VqZDdBU1BFcDhwMDRJaWp2cmdiVCtyVk9u?=
 =?utf-8?B?RnV3VS9xMVlTekVFWHd5VFREUndhOVdkL25SR0swNkJXS3g1WkdzNWd2Qk5Z?=
 =?utf-8?B?OHRvQXE3NHh2b1lJV3ZsNFNvL0Y5SU8zMlMybjBTQlZpSVpTUHAzMDhsMWxj?=
 =?utf-8?B?S1dROXpRTjhJaDhESmlWSGRlTTM2ME1xVWtuTFMwZWJOcmhVTkF1YnYyTWNM?=
 =?utf-8?B?d0lkVUJ1amRDa0hZOWYwVjFqZWZPSk9NY0VVSTh3T0ljVXVldHlxU3orNHl6?=
 =?utf-8?B?KzZFU0M4QzdnOHJkYmpnNGpKTlVJV1FSN3l1Q2pwN3BGTUhJbWxUc0NzRlc0?=
 =?utf-8?B?eEZqbkNvZllTZ2sxRHpZeDcrc2w2RjVBNStGU1JhR3g4WTBFUXBzYTd3SzM4?=
 =?utf-8?B?Qlh1K2NZaTFjS2FSMExVRnU1amxRUlZoYUl2UFRjbS9tcStwbUdpUEo1TTZY?=
 =?utf-8?B?WTJwNnJkb2FKVjY4RUY1aktQOElabGNwWk5nQjJPQ3J1dUVDK0pEY2loV1A2?=
 =?utf-8?B?andCOXdDcnZLZVFKa1RSTkt6cDl2OHRBY2lYSitTMStkUTVQTHdQNnkwdFlJ?=
 =?utf-8?B?blBFd3pPUjVuVGp6MU52WDVKWldNUkFCYnpSNENidG5nUWR0bk03STcvc2M5?=
 =?utf-8?B?VDMwT090YW1ZNisvMytSR2JTdmt6T25ZTkw3aldyRjlaS21QU2dPQ0Qxem54?=
 =?utf-8?B?OUhFNi9rdkJqazF4SGlDd2YvU1BlVCtOOXJMeUZNV0FKK3BUbjZMT3U3c0ph?=
 =?utf-8?B?cEV2bVJXczFmTVhoYzVpdVZGbHlnemlaOWtqNWhwUmgreGk4WktnSGk0d0wr?=
 =?utf-8?B?cUorN0ZEZFV2SjhKSUJ6OGp5ZmRtN3NPUzRWM1E5U1UzUVluc3AyeUxHT1BK?=
 =?utf-8?B?WkhtNThlL1ZWcXhGc3pyWUx0RUczVFBLVUxOZVlrTTlVUkhPeUZYQ0RMSWtG?=
 =?utf-8?B?WFg0ZnZzVnEzNDNaZDhtQXo2VitVVnJmRklEeWZzSThEWTczRWVGbkpWNUlJ?=
 =?utf-8?B?ZWkxUUVYUFhIb0pVaUxQVURyZUFWeGt6dVVha3JjTXNZdGdWSlZjRy9oeTZ2?=
 =?utf-8?B?Z1hsZkJ0cFBaSDlMRUVRZ3pFOFNlYWJTRUpuZU1KYUhWa1NGcU1RbEF6aHlZ?=
 =?utf-8?B?Ykc4VGFMT3B5QkNlRHh5RWFFeEQ1YnVwbjZFTytSNTltQVlUN0lUS2UxVlJL?=
 =?utf-8?B?WkFoQmQxa2xUdEM2OU5HUjl1WGlRVWFwYkhPdmhIMmpRRXFTYk9uNVByQzF5?=
 =?utf-8?B?Nk9Ua29NSkp3VFU4V3BaNGVWMmliV255dkhITHkrZzZ2d3ZzYmdLR2JuOGxI?=
 =?utf-8?B?eUJoRzJrcG9qa2lqMDVJTTR3ZW1pRk1DRXBXcm5ZUHVON3N3akNoREpPUlkv?=
 =?utf-8?B?dE5IeE8yTXh0bjRobUV5SlpBTWpVUDNGZTkyOUFEM3U4c0FPdVBYeUZKdFQz?=
 =?utf-8?B?RzBabVltVzhhOFkxWUMwd3Ywc01vNEpENVAvVGE1K0pmckEwRUxWOVlvZmM5?=
 =?utf-8?B?ZXprS2M5N3h2cm5BWXV6QWVVSjVwSlVlTFh3Uk5XbjlkdC9wU3pnS3ZDajlh?=
 =?utf-8?B?WElTemtFa3A2OUdxYXdSL1UzNmJPVnFvN1M0UWNxdldCekZHWnRmck50UFdQ?=
 =?utf-8?B?ZDJsNmdXMnJoSkhEbGJnU2RiUFFWeEdxN0h4b25Edngzbk5nYVF3WHJidHpz?=
 =?utf-8?B?eEE3RytCMThpckVLc1hpZHdQL09TWDNja0dHalVpckpwa0J6ZXJKVTZsV2Nm?=
 =?utf-8?B?WFY0VGpON2Nxc3R5N1crbHIwbWN6Qloyeno3SHRVejk2Y1lOWHNLSEhtRk1u?=
 =?utf-8?B?OERRNnlrOHN1NmpMYzJ3K1hhK2xBTmI3OHVuOFpIM1RsT3VpWnNqNWMvdWFh?=
 =?utf-8?B?MHd5TVNha2lSNThCYnRtSStyNXBNWTlwSjNwYmtuQ2oyY1ZVUXNVK2dicW9U?=
 =?utf-8?B?TkRSbWQvUU9pMXJKVHcwaHZFeGM1SG5LcHhqcW43TVpjUzlVRG1vNU10MFpq?=
 =?utf-8?B?SG43cHArRmJpUUdYMnpVcmZlRXhMWStmNTFDdmZtVVRPdFYvR3ZDWVE0ZWNt?=
 =?utf-8?B?eVl6WWU3MGIvVlVhU0Y5Mmtyblo5KzlPRnI5SHBrclVrZk1ubC9VdHVmSjJC?=
 =?utf-8?B?RGhOT0pHd2JUeGJkNW5ORmF1bGt4dWhtamRGbWJqQUFCY25IaUF4czl6TlNj?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e8749529-8701-4b8b-d848-08dc797b0ecb
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 09:47:41.7127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zclOQIsN1ezj2LAx+PxmqAwyugvBkNuvKFbXXtqnhzpFyXifS9+CSu7iYfjx650A5iX1eh1Yh8585w4OYlK2+Nlj2fxMUeeX8X7tDbH1fSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8229
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

On 21/05/2024 10.46, Rasmus Villemoes wrote:
> A bit of a mixed bag. I've been wanting to submit something like 3/3
> for a while. So when I stumbled on Marek's patch
> https://lore.kernel.org/u-boot/20240316201416.211480-1-marek.vasut+renesas@mailbox.org/
> , I got reminded of that plan, and I think that patch could be more
> readable if we adopt this model.
> 
> While actually doing those mostly mechanical changes, I stumbled on
> two separate issues that probably want fixing regardless of the fate
> of 3/3.
> 
> Mostly just compile-tested, and now also checked that at least the
> sandbox test runs succesfully, and that it builds both with and
> without CONFIG_CYCLIC.

So I managed to trigger an azure test by pushing to github and creating
a dummy PR: https://github.com/u-boot/u-boot/pull/542

That fails, and while it involves the cyclic framework, I'm pretty sure
these patches are not to blame, since the same error also exists in
other pipelines. It's an "expect" failure, because some watchdog
callback apparently sometimes takes more than 1ms, so the default 1000us
threshold is exceeded, and that prints a warning which breaks the "expect".

An example is

https://dev.azure.com/u-boot/u-boot/_build/results?buildId=8459&view=logs&j=a1270dec-081b-5c65-5cd5-5e915a842596&t=69f6cf72-86f3-551a-807d-f28f62a1426f&l=1055
.

I don't know why it only/mostly seems to happen in clang builds, but I
think the fact that these happen quite frequently warrants either
bumping the threshold used in the CI builds quite a lot, or adding a
config option to suppress that warning/limit altogether for CI builds.

Rasmus

