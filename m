Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3790CD98E4
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 16:43:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 147C484869;
	Tue, 16 Jun 2026 18:43:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="j5sCo+fR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07327848A2; Tue, 16 Jun 2026 18:43:37 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA7B88484C
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 18:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5QmmKd5CaMKAHOtTHo+OELyrePzY0NDhOaey8WsL1AE2zJnqeM1ZEcqHpMjkZIR/06BMy9mrrNPSnTNsc4jUPZUBuuU14oxotv7so6+Dkp3t9fXHGTm1kXaef83bf26U/AQdo47sU+u0DBf9JfZ0h7NgiXKh/x5e+OS/xXLIwkPbph+b4tFV570jR5/tQyd+6//5xMDRh7taCD4mJyvg8Mhqx57UytlVmg5X7wUTKM4Ln1aB8pZHIgyzVhgj04YWKi9i1XbRpw7xLKavR4wjpdzbtyrVycda+8fXt7hiuV5RqA45nBxnCaSOe6pgtVgHtWB57u5gJRFmfR3XRuFUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TG25y5gK3cFDep2V4rfD8dM8aFNMpcU/HljIH7NfPpM=;
 b=ASiwWYLZs8MkIQqAM+NTWF5N59KnVse2vw/0qCJmh/qwCnreQxvHI2XQU19u50Up8OqkGFfhvjxo8YQIYOeqpUJrU6MBswJ4B2tKxfhiHfcgpSutP1WumXA6JxOQ+ACPZpApkUnVNiuVyUOllXbS4VuFv9Z2RddxM0pICDX1S9Hj8q/CcuDukZbM2iCoNxR4grks2CAXE5je5qzwXEdbVGY9aK3XS58uWm38TTg7YBLGR4G+cMHaxix68Hzosc31x0vlUm9q4ZgdPUgNOeZk6nZj1v78H7oy71DbXw6IWwu2bGdEWGguHwavkNaFRhdM0nGXT/3R09VJQUoZDAXAPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TG25y5gK3cFDep2V4rfD8dM8aFNMpcU/HljIH7NfPpM=;
 b=j5sCo+fRrgAQfVQ0pHj9y8A8fn8161mAyKaFRkQVkd70Bn4V0LDzr4W0gDYJlJ/EuFe2npsKea1av6LJXdkdn5tAgsZ9S6QpckQ6GxUN1jEJEVirejILW8YjeSHQqrhVWV2rCnME2TGGQgp0SoWPuB+jNI71PntrjsGmah1qESc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by PAXPR04MB9302.eurprd04.prod.outlook.com (2603:10a6:102:2b8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 16:43:31 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0071.010; Tue, 16 Jun 2026
 16:43:31 +0000
Message-ID: <eca33072-97bf-49fc-890a-a51b7fdc4d62@cherry.de>
Date: Tue, 16 Jun 2026 18:43:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Add support for OpenSSL Provider API
To: Enric Balletbo i Serra <eballetb@redhat.com>
Cc: Eddie Kovsky <ekovsky@redhat.com>, Tom Rini <trini@konsulko.com>,
 Tobias Olausson <tobias@eub.se>, Paul HENRYS
 <paul.henrys_ext@softathome.com>, Simon Glass <sjg@chromium.org>,
 Jan Stancek <jstancek@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.denx.de
References: <20260429180247.83091-1-ekovsky@redhat.com>
 <482dbc09-e78e-42e7-9915-bdc105652494@cherry.de> <ag-EpjuQlre9QmYN@daedalus>
 <8d7ff3b6-abb9-4441-8491-99c538ea5f2d@cherry.de>
 <CALE0LRtVVwJpmaLn6=95BihVZA3pWPAwM1t7zENSsKdaxzWk8g@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CALE0LRtVVwJpmaLn6=95BihVZA3pWPAwM1t7zENSsKdaxzWk8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0012.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::9) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|PAXPR04MB9302:EE_
X-MS-Office365-Filtering-Correlation-Id: da53dd89-92f0-48d4-a15c-08decbc665ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|22082099003|18002099003|4143699003|3023799007|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 3TDk+ffGorjlJabcSHPVfIPvJhrz4UCztpENTR8eKDX4o94bKhjPxocJ0XR9Z+tVKcz6/87a27b7/IVZLyDu0bm0/JSnJBSiB6xMrPYeldPykEkknvEpHROA5kdoGVmqNjDOGhO09BvpHKz6IJxleHDd7rcnRnkH2r3wTh6kYb/SqkMdnGmXFkh4nzAgYnGEG3knCRU6NaFr6XVG3ThxUp12dYbpO9yAqLd+S2eVngCaxDr5ZSInbDowC81mMB59AbB32Qvv8w0Mzt8y6VPfOxXDhhIxRsk93KWAMHP54jkcWhUq65Ihda/jxfitk9eWW9va5g65c4xyPkB742Huu4JQTeiDCz3GxNXkdpsR+xv+XorvryA67yT0hnA2r032JkD7GEEppBJKM8LgegJHmmxym4CBYgvQS7H8tKqy+ct2Xb8Iz4bEpolIOSI/lha01T1muzuOtXGSVOdtoJTCzqKeAu5/6o8YFKxo3v21Tz/YKW/aU8cWfvm0aJ7lgYHh5jMt/ivH0jkkbANvQ5qTlg3d5s+sxvjycZbP8CR4mlm5owh9HJKyXLTrOeq2drWqK+drMwdB8xIi87Umm7t+DjrNkqHZNcRtlbe4aPkv5Va1Aj5JaltTaqtESxyvnQdsnzioUYDAhMGNUN/LWSjBozqXqV6ssqcNvnUG271QaIwdBsCE4wE2xxH/YT9ZS8te
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(3023799007)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0FCWGxYVFRyVmIzMDNHdjZmdmpydno0Q3hpcnp4Q1IyK3VlYmw0bC9NY0tj?=
 =?utf-8?B?Z29DMUxVTzA2QTlPNWNWYm1zblhPcHEvTkNlQnJ1am4yek9MbmxHTDM0WWFV?=
 =?utf-8?B?Nk9GL3JjNmsvKzhtUGFHU1g1Vllna0Nmd3BKMGFQUTJldHl5eE9QRWhTcmRv?=
 =?utf-8?B?V0IxS1lDRjVnY2pkcC9aaE5HSVp5cTFWMFFnYUFrVWRRa3k3MHRManYwVnRs?=
 =?utf-8?B?NXlOWEV0OS9pZ2V4QVZ4YVcxeGY0UWhJRUhYUjlFRzdMUStCdlVqYVhobmxI?=
 =?utf-8?B?ejFQUXZHVnc1TnVSNXAxTzF5eDVIQm5ZRmJPNjJWY3dLOTBuOTl4U01oZXNH?=
 =?utf-8?B?V3pHMDI5L0UyU3NlNXVDaU5Ic0wxVXYzMXY5cG5peFhtdzNRYitkQk1zdDM5?=
 =?utf-8?B?aTlDdVJ1UVdLZC9mYzl5aHNFWFBiRXhnTy9JK2dRanpsQ1Awa3hIZ1p2bnlV?=
 =?utf-8?B?VEZ1US8yRU90ZWM0TGFyMUQvYXk5WC9zMVl0ejFrYjd4TjNTbnlNUjQxVlcz?=
 =?utf-8?B?VzFlOU1LR1FCTW5yQkxEbmJUU2Y5WW9DbDBrSXgzaXV3RmlLVW1Id1NBeUFh?=
 =?utf-8?B?ZmxTU2dRU2crQWJ4Zzhhd21IZ1JZSlZEYTB6SWI3R3BtYnBEREtybzYwcTBP?=
 =?utf-8?B?Z1BZQjVUKzhWQmdpUDhXNDFlZzBhbWxYSlhpSzlYbml0K3RaVTBOaEh1WEo5?=
 =?utf-8?B?TmFxVWRHdGNOOGdXaXpDa1VDWUR2NEh1NWlBdGdtanZIMTlpZmZWS3kybm0v?=
 =?utf-8?B?MXFqU2NYUDlPRGFGTHFEQ29RUXpNNmorVVZvYXIrTnMyeE1SN3FBYTNHNTZB?=
 =?utf-8?B?RExFSGgzWENWVjBXRWNtVHdvVStxTExHOU1tUDNibS9abDFvTWNLRTNXKzFW?=
 =?utf-8?B?ZG5GdVpGRmltK2Z3eFRWalY0WWhNbXBkS3lMZlluR2xhTU5pTytJT3o4ekVm?=
 =?utf-8?B?NVpIZTk4WlFRcU9FelVUeVZ1VjdGdEFydEhIWGdPeXFIWmMrYUxuRFVWZy9H?=
 =?utf-8?B?VmxIR3JzdTA5WTM3N0wxV2dMOTBCRFVoNitKSkp2cVVES2FubEExc01wdXVT?=
 =?utf-8?B?dmxnZldTRmF5R3dtYWl4YWdIQ1hHMng1RGMvenh1Y21TS1k2dnBKUUVud2g5?=
 =?utf-8?B?OW5jU2VlcTh1NEw0OUZNcDY3NXFCTzNRK3BwWTg0TDQ5WGRvZCtHNThlVnQ3?=
 =?utf-8?B?U1pwVVNMei84a2Y0QzNldFhVSVQ5VVJUV3JVM1EyV2srTUI4NDF5R2pDRjlL?=
 =?utf-8?B?SmZpMnBYK1poY3hpamE0ZjBuT3oyVm95S2lLVHdpQ0JES2psUXljOFR5NDhs?=
 =?utf-8?B?dTVJOWY3UUU2OVY0WERySmUrVi9vNW84VWJRYzhrdEFiTVV0dlhxSUxrR20w?=
 =?utf-8?B?MUFleTNsVHlHNnVZaFdXanZSYlI4N1E5dXJHQktVWkpHeXYwVlRpTWljTmJR?=
 =?utf-8?B?elFSWG1Hd1JJS3FtTVRCRHM4Wlh1cVRJbXRYMndiYmswUzh3cDVkbDZocXlL?=
 =?utf-8?B?TlczemlGRU4xUEJKSUhZYXV4OFRPd0VSTXNodnRmc2tIVWtGakQyWTY4WXhD?=
 =?utf-8?B?eThkdEFyMW9NOVFoZndObVpoaVptVmZpczF2ekFaY1BkWlpQaTR1QW5vWGRW?=
 =?utf-8?B?V0JBVllVSjdmUHZNQWNocHZ2QTdPUHI0YnNmK0R6NGVpOG1CNmorUXg4ZC9v?=
 =?utf-8?B?WjRicVZvL3Q0MWREbWJGSU5DaFRUWWludFE3YVRZMHJBc2ZFOHJkWDI5bzZO?=
 =?utf-8?B?WDZMSWN0RTN4SC9ycDVaWU5XemFBcnNvaWxnRUJ6cDNUdTFGWm9rN3dRSzRO?=
 =?utf-8?B?U0wvWnQvaGY5cWE3L2ZsSGlVY05yZllDSWNjRFU0ZlB1MUFKTzVpL1o2cjBu?=
 =?utf-8?B?eFBMMWh3N01UWUd0WUVFc0c4K3pJZ1lWeHYxZ2FYblpBeTV2UHpSc3dPWkFN?=
 =?utf-8?B?RDZ5Wk9pSjlBUEM0R0ZKcXFrU0Vnc0YrQ3FtbXpmSWNoblgzSXFpdkFxcnp4?=
 =?utf-8?B?a2NQK3dUSUJKdzlZVkkxRll3SVdpQlpwUDhtVmxDVkJJNDkxclU1UFRIZEdL?=
 =?utf-8?B?bTA2cDRZeTFGR1haaXd0dnNxTzhRZ2FQRnNpNEt6UlVQeWRQaTBOeWplWUNE?=
 =?utf-8?B?MzBtOGZjdW02MS9EZ1ZKSVJzVUJrTWk1UjZ6UEM2SmFxRE9XQzh5dlFGemw5?=
 =?utf-8?B?cWRVb24wNlloSEFMV3E2aEk0Syt1cDBFVUlxZk91NEtUQ0FOMncrSXR2WmRI?=
 =?utf-8?B?QSt0T0VqMGhwNXVIUWFlenRHTXFBcHBIbXg3M3BHNGtuZUVJS2REVE9VTzlY?=
 =?utf-8?B?aVVaM2NvVG5WYUM1VzFGRnRvbUdRNk1EaFAwNEROK3dQT2V3L1o2Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: da53dd89-92f0-48d4-a15c-08decbc665ae
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 16:43:31.3034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnKK1RVPelUNhVGjH5GbaBMc9ZQUSqds/koJLX2ocDAc7SwlEsdkN6KbPNxZlxygn1XAF/M8z/2G8kbyMqCn8PTq3UefmbWsxDHq62SqcqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9302
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

Hi Enric,

Thanks for chiming in.

On 6/4/26 8:22 AM, Enric Balletbo i Serra wrote:
> Hi Quentin and Eddie,
> 
> On Fri, May 22, 2026 at 4:38 PM Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Eddie,
>>
>> On 5/22/26 12:29 AM, Eddie Kovsky wrote:
>>> On 05/12/26, Quentin Schulz wrote:
>>>> Hi Eddie,
>>>>
>>>> On 4/29/26 8:02 PM, Eddie Kovsky wrote:
[...]
> My understanding is that to fix the Fedora build issues without
> breaking existing workflows, Eddie just needs to adjust the control
> flow for v4 like you suggested:
> 
> If the user explicitly commands an engine via -N, prioritize the
> legacy engine path—guarding the engine headers and blocks with #ifndef
> OPENSSL_NO_ENGINE instead of a blanket OpenSSL version check.
> 
> If no engine flag is passed, route seamlessly into the new Provider API backend.

Fix the build issue by checking whether OpenSSL engines are supported 
(and no, a version check is not enough for OpenSSL 3.x (it is for 
OpenSSL 4.x though)). If they are, keep the same logic as today. If they 
aren't, fail hard when an engine is requested, otherwise keep the same 
logic as today. Make use of #ifdef to guard code that cannot compile 
when engine support is disabled and you should be good to go. This will 
still fail unit tests because we are testing and building a dummy engine 
regardless of support. But last time I checked (years ago), many 
unrelated unit tests are also failing on Fedora, so it wouldn't be a 
deal breaker for me (and I have some "interesting" ideas on how to 
handle this in a later commit).

Also, please do not use USE_PKCS11_PROVIDER when it has nothing to do 
with PKCS11 provider. I understand this was imported from the kernel, 
but they do only support PKCS11 as far as I could tell, so it makes 
sense for them.

I honestly don't want to see the Provider/Store API being used only for 
loading simple keys. It already works without the provider API and isn't 
deprecated as far as I know? Let someone who's interested (my employer 
is, therefore I have to be :) ) in supporting OpenSSL providers do the 
work of implementing support for OpenSSL providers, with unit tests, 
backward compatibility with engines through the OpenSSL provider API, etc...

For PKCS11, we have some interesting logic for the OpenSSL engine, and I 
think we may want something similar for the OpenSSL provider.

Note that OpenSSL 1.x is still used in some distros (Bullseye, Slackware 
15, AlmaLinux/RockyLinux 8 according to pkgs.org) so I think it's still 
premature to entirely remove OpenSSL engine support (and OpenSSL 1.x 
doesn't have the provider API).

> 
> This fixes the compilation bottleneck on some distros, completely
> preserves legacy engine setups, and allows real providers URI
> string-mangling issue to be handled as clean, independent follow-up
> patches.
> 

We need proper unit tests for supporting OpenSSL providers (and not only 
a local key using the Provider/Store API). I'll repeat it once more, I 
have local WIP (but tested) patches for OpenSSL provider support, so I 
don't think it makes sense for someone to redo the work. The fact this 
was started back in November 2025 and it hasn't been really pushed hard 
since kinda hinted at this not being a big issue for RH (or they keep 
their stuff downstream and upstream can take the time it'll take), hence 
why I was waiting for Eddie to answer/send a new version (I've also been 
swamped at work for a few weeks, which should end soon hopefully, so it 
also worked out for me to wait on Eddie).

> Does it makes sense?
> 

Somewhat. I still don't understand the obsession with the Provider API 
when the issue (as I understand it) is "I cannot compile OpenSSL engine 
support and I don't need it".

Cheers,
Quentin
