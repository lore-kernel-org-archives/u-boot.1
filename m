Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A2BC43602
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 07:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC177841F2;
	Mon, 29 Jun 2026 09:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="K31svP0W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C71F9843B6; Mon, 29 Jun 2026 09:43:03 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBD3784105
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 09:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFDPTklpDEL2FWGdkUw+TLNl40zRSKO8Wy4lBCqMgDpdM/IBU+WevUHn7eL3u7Yw6MWDw8DE90YGoyoiYRqaH+TkWM4ZXIRi4SJocE+dIF/2FqUosO/TMjEYuLrVrKlagiDBXRdymuU0LKerjJrcVpxJUdUbYc2tCIuX7fI4f4ug8uPk3Rf0aJtf+SdaX7DbadnEAy3ldS7FMMYczKyDu3VVQhOrEFeq7vSaOj378JIAsXmp8um+jpjl3ufKqiNo7csFyJ8zimO3aX1dAkOMvTmh4K+lwlUDmnvI9vLZOs40A7EcEwSKbEKLjaJPj3LyAnX9VcCy6I7er2ltY3ryWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK6WJWQuVPoHqXQiSD/T7ptgksm4WPEBNanwGYVg2Xs=;
 b=cnc3i8VrhjqPhdReXiXESSukuJJ/YTrflNc+57L0bPx6nrAZMbWqvntJEIclQ4wmjXZFNydyknpskL6++3wCHkLS8zp9+ZvF7TUQIsVfSzM1hBVUvt2AB6wAgQCFUHYt9NR7oIDQhaociNCGXRafyEwP3bggy3ACJ0VDQ7DvRMEoweLnuno+A6PuAu3/KXt278ROMIP5V8VBR3OFmzydl+QBE6FQEKT1BeIP4ckZEmtG7hwiF4MJFbpZIGo+SqMJ8P+o8NGk0cUVJTakbJhCy8rAi7wwYJ5OEryKmuP9iv42zkgohyykS0YT2pDFHRz/rll7l3PhTT4EPiZtPR7D3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK6WJWQuVPoHqXQiSD/T7ptgksm4WPEBNanwGYVg2Xs=;
 b=K31svP0WD/xH5P9DySyH0TMCswMX4F68gXHHZ5N6jEjtrM/dbt0Qli6QI98m6mffiSXYgZk/Xzw82lWEqZDqy+Ng1NlXva878EvsTxX9+yjPbE6j3i6Xd7anzszsPcZxLgPLqtblA7NuD438FYS2sxbqzlTZ2IuAwzGoQ4koWiBrrXxKu8VqXJQEIX7Oyi8qVpWwKJMYc4xrPUQoFB4ezfGnnEJFK54NpDN5TY4sNguQ/ZVC1IyXDFj9rdIFii7ecrdacaJ4g+AkF1qCxXEw8yCgx3/gs2pnDqTTaR5R7EaMRSn8w8ZIVE+5QKd14bxQQUG+eM/cc3768N8TvCLo2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by DU4PR10MB8482.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 07:42:58 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 07:42:57 +0000
Message-ID: <dd133025-b660-4b2c-ac40-d00a078b6b7f@siemens.com>
Date: Mon, 29 Jun 2026 09:42:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tpm: allocate tpm event log if missing
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <20260610105243.193355-1-ludwig.nussel@siemens.com>
 <20260610125204.v2.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
 <CAC_iWjKN4URBGikcEeTHp7dQPf7QasESmPOmys9piEnsVt-fWw@mail.gmail.com>
 <c3cbd9b8-56b1-4884-bb8a-8a98498a6c09@siemens.com>
 <CAC_iWjJPY9VK89fB5+isWb0v5+uBZnr05kQoGGOYu_X=7G8Wtw@mail.gmail.com>
 <7a8ab625-448f-4a63-ac2b-7b071a9a9f1e@siemens.com>
 <CAC_iWjL0z2+=94CfjZx1BV6bCSSN2PyVwPSgCJNhs6r3Z4F3BA@mail.gmail.com>
 <CAC_iWjJP3aK5a+QNVuZrLo_jc_zC1mkHJr4JsgRSaD7=wQ5cmA@mail.gmail.com>
 <7aaef892-d1bf-4117-bb9a-ac8163b517da@siemens.com>
 <CAC_iWjL2f6oHSfGYtiDy2rPUzpDKRdwR7RvEJUQaNqxO0rc70Q@mail.gmail.com>
 <35833068-3d06-4661-b98a-1633a6afbbb7@siemens.com>
 <CAC_iWjJ-dMsT3W5fSZ8KUFZeUz8djPw4gs2WHZsfhOjZ6jktGw@mail.gmail.com>
 <6e83756f-5ed4-4f89-85b2-1a65419e9ac4@siemens.com>
 <CAC_iWjL9yrSycty6=+JGqpE1ed7oNb34txDmKsE9sMp4zZCOeg@mail.gmail.com>
 <CAC_iWjLgqpk=mdz76JHD75s5t2F7R2kzAEomd0=E3=x+kcmZrQ@mail.gmail.com>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAC_iWjLgqpk=mdz76JHD75s5t2F7R2kzAEomd0=E3=x+kcmZrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0285.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:373::6) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|DU4PR10MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 9baa635b-9f7c-4f42-90d8-08ded5b20989
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|22082099003|55112099003|11063799006|56012099006|6133799003|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info: sT+jw308GWt0srxKRAVlhjVw34jjoW2zL2rWbYyXXu+wbfrR3wzoNcXmhIc1uIv1M98uE/mZuNyK+YspZ1jpR9bK7fi1IsDCuvuTgJ7WlgG9PMuhcAr9g/jHsUBkMdgtRK3Xe0d0tQKBslqyNrlvD3mr4CI6p/Td3hTvN3/jdvvY6ct5v91oDkiPmtOgqGyDfkeZsHvCITE2gUnBoqUA8I+8Zmj+1uiK7ZrNLVF7hGbBDr/0XP/bgFgMjjNF7FkuADwJ3wq59DlQN1NFOnl32JLC+sGo21lh1qWD2B6gJq8vHamS6J5XB8dfQ5q2WUzV52LkQtR7kwiiMVxGt/qO4ZGplWvrQR2fE6omTUZ78usf2PjD8kYlxa+x29E9kjIhN1SOteW8X78LTNMHRPA3yyGeOZeDLSOtqnp4kkBPp7m/0x0x5JMeSHP33oJHu+MKuN8ttiz79KOHhdskTC3U1Dco8HsitkY5q16sZk8M9lNHSmtHgi1hbrq2xBBaaAYVG95dmUyOXSiiaQ+w9EG2c0PeQkZT1x5ktqO2shVUB9acdrH5gVKKlGKVLyI14ARzHv4B183HOS3Fe3oEIh/EGsDoRy3z2+6Y0hQu1dQZ3OU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(55112099003)(11063799006)(56012099006)(6133799003)(3023799007)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkNrZm05bFZIcmhLeS9QQnNIY1hFcm5PM1JqRmZ1TVBFU1daOFlSRGxOZkVX?=
 =?utf-8?B?cmdPeVZPWkh0VGJ1dkIxcHhzczd0YUN5dVRxMXZubE9sWTVudWQ4cDA3TlZT?=
 =?utf-8?B?alBSMUcxNjVVU3lCMWtJenRwalY4NzlORTN2QWw3L29UQVlUQ3pyWndzSHdj?=
 =?utf-8?B?cnhHTktPMVRXMUlvbTZkVHl1NEdTVHRTWFZTWGxlNEdqSS91RURuTGhIcXhr?=
 =?utf-8?B?QytJYUV0MzBEL1FGUzR6OFovNGYzN1hXSWNIOUNqNUNFRGFxS2l6dE95MDVE?=
 =?utf-8?B?SDE0TysyTkJHcS9JcUdXRXphaXEyVXFhSC9ZK0d1bG5wUk9qcWFQdERNUzg4?=
 =?utf-8?B?YktrR2FHa2VNQXExZEFKeXNkbDFLeVlDM25CU0F3RnpWaG5oYXVQQmM0UDd5?=
 =?utf-8?B?amFnbzFESGhlVVB0Wi9ibnhpZnZScmdnZkY1NktYVXV5WjAvSDE2eFZUSFEz?=
 =?utf-8?B?SlRMV1dqbnBjcVNVU1ZjZm4xYjY3VEZFNHhnSzdUbUcycC82OStGaXVZTTIr?=
 =?utf-8?B?Sm5uSFQ4eFkrWXRTeGhPWFlBZnlucHg0N0d4dUlzZ2VKZHNPV01YS0FVK3BO?=
 =?utf-8?B?QjExUjBKRGZlbGFFNGVROHpYbFQ4VkhGRUp4YkQ2eEYyaGtVUGN6cVZLbW1K?=
 =?utf-8?B?bTNyNE0zV0ZUaVVCVTd5dng2Y0tkYVZOL2daa3JMbjZqZUF1aGhpMHF6U2k2?=
 =?utf-8?B?REQvSHdmL3JrRzNhTWdpWjkvSVVxdmZrS1ZyMm9LNWxZamMyeVFMWnpodUtx?=
 =?utf-8?B?ZXl1MEdEbVJvVmEvU2QzM250a1VYd2hZSmJUWmlMMGRJTkFLRW93WmdIZXVB?=
 =?utf-8?B?ekozc2xIM0dFRzFHdXBrYVBkQnZjRmhVQ0Ezd1ZkcksvOTcrYWhUanhoYlZj?=
 =?utf-8?B?VjNCK2dBYUlNRm02WWdFMTgveXJjZ2ZzZ3FJa2xnTHRoRjk5ZzYwRGdLU0xJ?=
 =?utf-8?B?V1NUZTNnSGFlK0JjUHZDWHc3ZkM5Z3lxSVMvUFIrK1NvN21FaUdNKzRrOEJi?=
 =?utf-8?B?THVZeE85bmN4Qk02cWtDamYrV2xYNjhkWFY2dXd2aWNMdDVWK0czZG9rT09S?=
 =?utf-8?B?OTh6c2FZQlZOWDdDMjBYd3RUK25ick1ZdVNUb0Z3ZUs2ZW5aZVNOQThQZmZi?=
 =?utf-8?B?alpaNFpwdjlQZE5QMmFJWkFZdUx6Zk40Y0tYWDVhaC95SHZZSW9PWlF5MEsy?=
 =?utf-8?B?L3hJc0ZJT05PckJlVWQwUittU0VtVWZvQzNVTHVYNnQzNjNmWnkvcmc3ZlY1?=
 =?utf-8?B?U1NyOW5HYzVEdDdUVjhUUVZKMWN1M3RXVGJwVk1FS2xBUXl2dzlpR1JmVTgy?=
 =?utf-8?B?NzNJU3lRK3F0YVFWNmczQW9VTkpOZkFhNG1yZGxXMVAyT29naFBTdWMyckNx?=
 =?utf-8?B?U2RKNlVicGRuS0FMcnpXcWxUYXRoWWFTT3B3UjRIbkNwY2h6WThUczkxNVJ0?=
 =?utf-8?B?VGdQVVlqK0ErdmtXcHpKTW1GY25INHVtSDlaKzF4SVRLMTY3cm5EaTNjdlBW?=
 =?utf-8?B?UUNWdUM5KzVrbHJJREJSWktIQWVEcDRucU9pQUJaRm5ZSG1NVnNzeFVsQ21Y?=
 =?utf-8?B?MGxUcXVPMXF1VWdRQWp4TXdPRVNPWFVFZGNnVTY0VmtTL2huanltQ2hoRFdK?=
 =?utf-8?B?ZC83U2t5eXhpL2hLZXBnbG0yYkZrNFNLTFVnMTB0MTBlTUR2aVI4Q1ppbmdG?=
 =?utf-8?B?SlZMWTdnU3ZGR3cybERKdUhyTVVBOXJITTNyZERwdjEzTDh3YXFDNzF6OENk?=
 =?utf-8?B?SHl5K3h6MzcwTTJxeUl0TE1TSGFXNnVTbHdwSFlhMFFVY05aVklQK1ZZeG1T?=
 =?utf-8?B?WVJ2TnBLY2JkUythbEZud3JmVVlFdVd3bThCMDVnTmtYbFBxN2tPbUZ4Vlh4?=
 =?utf-8?B?ZjRLVVdnbHI4ZEpGRjNQVDh0R3NlaGxKdVZjZ3RheS83ai9aTFVTTGNyN1NI?=
 =?utf-8?B?cWtqK1hxNHRLL1UrbWtBdnVRbW5OVW1sOWdIdTloMFpkclhNZWZOOCs0TGUw?=
 =?utf-8?B?Z29kenpieWp1MHd4eUVHcUtXM1JvTEFKb1ErMWtUa09qckNLbjZ2UG1QUXUy?=
 =?utf-8?B?YXpsSVZPZjJKcDdZUHkyS1hEb3AvblZwKytjTlM3UktQcEZTQXRpbzdBZEhk?=
 =?utf-8?B?aTBPK3AycktDSjBzQ1hIYU5qamZGSDBHdVlCRDVjMXhJSDNURHlVY0NwSmQ0?=
 =?utf-8?B?QzZsdHBuaXd6NjhCd2dXVnNWMjBQanRlN2lvU2hkdW93M1RvQ2dQNEsvT085?=
 =?utf-8?B?Q0hqVmRqZFZaV3VnTjVSclhuU1BRVXlwTjNnaUJ2WTZmTTQ2eUhWelNKWUNP?=
 =?utf-8?B?SGFLdEltd3VHQXh2NmJFZHdNVjZIRElhdmZ4bjRqQWphZHg5K3RWckxjRlVz?=
 =?utf-8?Q?XgBBs5ZE1w5rqEcM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9baa635b-9f7c-4f42-90d8-08ded5b20989
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 07:42:57.6062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ny31+CVMc+DR8CHrDMwa04Z4a0FmqLgexmRU/ysqaC+skAJxUVqg2OtKrOiwEuDv9Ia6zhI7aKGEFyaVlYCQmvBQauEyQ0Zr+Juc5B6I3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8482
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

On 6/23/26 10:50, Ilias Apalodimas wrote:
> On Tue, 23 Jun 2026 at 11:38, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>> On Thu, 18 Jun 2026 at 12:16, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>>>
>>> On 6/16/26 13:46, Ilias Apalodimas wrote:
>>>>> [...]
>>>>> Anyway, do you want me to submit your two patches as part of the series
>>>>> or you want to follow up yourself?
>>>>
>>>> Carry them over imho, they were rotting in my branches for 1+ years,
>>>> but I never had the chance to send them. Your patches were a good
>>>> reason to rebase and revive them and they fit right in as can only
>>>> rely on tcg2_measurement_init now.  I'll test/check the v4. I haven't
>>>> gone through your changes in depth but they seemed reasonable, so I
>>>> think this is fairly close on getting in
>>>
>>> With the patches on top the testsuite weirdly fails in platforms
>>> xilinx_versal_virt:
>>> [...]
>>> I can't figure out why though. While investigating I noticed that I need
>>> to re-introduce the elog parameter to the measurement functions so the
>>> integration actually has a chance for now, short of using dev->priv->log
>>> always.
>>
>> Ok i'll have a look and see if I can figure out why
> 
> Ok I had a quick look. The reason is that
> if (tcg2_platform_get_tpm2(&dev)) {
> log_warning("Missing TPMv2 device for EFI_TCG_PROTOCOL\n");
> return EFI_SUCCESS;
> }
> 
> Has been removed from the EFI init of the subsystem, but the tests run
> without a TPM. The init now fails and the entire EFI subsystem fails
> to initalize.

Ah, stupid mistake on my part. I've fixed it, the tests are passing now. 
Will resubmit. Thanks!

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
