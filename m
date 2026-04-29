Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12870CCFA13
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 16:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 100C7848C5;
	Wed, 29 Apr 2026 18:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Y3xA9A9v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 450C5848C6; Wed, 29 Apr 2026 18:32:15 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A10DE848C1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 18:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9ExJhfpZK3y69QOmAAqSsKreMIaByh0KRqsuXGbJiBamKe3VAJyUsYKF7MR8/W787Q4SR6zWPTf7HK8Vnd1gDwCSiSz3q7YvYqcWcXlXFXqR+arUWW48FIR0G2NRKyx8uZoLA6expmiRPgAfZJocWcxp4L+145IgvQEfARoz+r3pKP9XGFAA27jazqWVd3VXJhys6zZUFHciWDH18gWmsgxcP9Ss6gBzvGsqlOu4UZTHO1Ij4H6oMX2BgWbBaeegb/CTVzqndGjB1/cga72Hny1OKObvyiGWS7O6z2z0eJ8eKK9fS4URaYc8jfDkiuamZ/TrhKNtrW8FneNKhV6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uP06t4hB+nSrry3LjkezLY7vZ0A7+t9uxM8Qm+WwoE=;
 b=piRXCyLzVpYNxJ4pbTMyE5b8n7x/FLGIThOMYeZ2kW6Dt/x6yvcici8uZgPBKVVU6yjprquaJsLKo4N1UnxyI04u62lRaZaqRR2xQQjkmwqbzTuhARZp+rjcfU4kTBBw/iw8bGckeW6yxj8mGcQF9/NTKi5WOz6Njf1tusoJJCAbflIzJV1nH9DbYS3Yy5sQHsu3/qV5A95AMmpWwDrtsvMo0V9CeCZ9xA6iQG14Kk1ybYIe0wNUU9znXmBB8qNIKlKUjvOfiQKe65GdEkL3SQ7wlxoCVkj7vY8O6YENSvlMTDfiLekHzsner0oxyiDCZ+eS6UTWXhdp7B/oEaNDSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uP06t4hB+nSrry3LjkezLY7vZ0A7+t9uxM8Qm+WwoE=;
 b=Y3xA9A9vA8nWaEZHz8BdfKtnpo4yg2ILAGab4DeJRHLOuokGfXThncZDpmZKAoMSSfhIX5Qww85wpYG0egvH3+w+TZRjcVzvuEoOmZpkyhrMVmQ43dk9+Ar3ss+XUflLBGimVndO/fbXy2/3HpaKv5aRbjd5i4N6swBky1OFZLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 16:32:08 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 16:32:08 +0000
Message-ID: <eab00828-0e87-4761-afc8-1a3295d18a26@cherry.de>
Date: Wed, 29 Apr 2026 18:32:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Couple of clang warnings for Rockchip boards
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <f8f4e639-0e73-4d14-828a-92dbfe5526ba@cherry.de>
 <CAFLszTjWZ9DBKVui_2EE-nSg8K+5eC9V8jvwp638dLeyp_p6vw@mail.gmail.com>
 <175e1198-2ac4-48de-b68a-c29f786832cc@cherry.de>
 <CAFLszThQ+kyCkojFm2=VNtLTtLDYT4iVmpqnto8awiMVqsct0Q@mail.gmail.com>
 <20260427144630.GG41863@bill-the-cat>
 <CAFLszTgga6eFp2aPF-MzJEqeqcEV-bMJhb4_ph_bE-1Dv4e_Cg@mail.gmail.com>
 <20260429142547.GT41863@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260429142547.GT41863@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0109.eurprd04.prod.outlook.com
 (2603:10a6:803:64::44) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|DU0PR04MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9da133-e437-48b0-4672-08dea60cdb6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|7416014|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RzDWmB2h3dkW/IaZex/kD43rI6LYq7p/EUYEAHxvaQLOF6LzQiJDSTrRfi8H6T0n4FBBDrV4/Yq8qWBjmuDK45hfk1rEKb78SnTukMAKWBsIHWwcd1qLbG5G/OMdby3O8wVUQNvFXXtwjZhnnG7ewHwyrO8i0blHDnVR3IyE5a42CgVALbh4I0Yf1z82DGq2KX5YEdMBsm78rBQ6jPOpdURQ0SM2EZn3o3+5XZMKHDgiywE60yUUhSYd3CPUbbUaoQJrG+yyErhU/3theVj4Wrl4tGD+MFZtdV4ImOGFmC3hzHifT8zj+I1c+g9sUuyQFzEmviCiONhgEstepRmpbXTy5SUmeI2vjGuuKNw+rL2BANViy5l+eJEkdyESWDLcuBYKXQ0aZ1uv0YYZl84A4CpAXg3sP4iGJ8SOyRhlRqn42cIdF3GBBJqkbIJzmtNMqfzzd5ShgYt1Qua3tzXzOjSLXHp4FN06wojoftDVCViZtoQ2y1jKO3JrBrG/Ahi5G4U/jJzorc1vBQTrACCUnzqrvCJvv9daVSpbNGQorpyMkNCoJDusDnhEVr4zMOXelCk3TxLGFcOYMe3avrIaJDZs20OtL/Ee/oloUvxCvXSKDHTKOI21DrOspespTjqcJDkpZct5pLh6XxLxvWn4L+KCSjxuJ6T6+U5DmI2vUw4goxJ6QyRqoVbWvhxhRVKABPfRbIGKup/U6uE5QhiBNwT8E/ulkLLmCZAVjY0IctbzDwaUGBX6wwE3H2hiZ9RM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDEzL1dXVlhkYytLV3BMMW5zT1pLb2RYRXR0Rzlsbm85UHJBaGpCWUZPOTRh?=
 =?utf-8?B?NUZjMzdNaGJ3Z3dqejJmM0N4aVl5VDdhL08zV2pDNUVPWWNLdElNY0ZVZUFk?=
 =?utf-8?B?MGJrYVhaTU5IdmFzMEw3dWY1UmU5ZUpMQnBuTVg2cTBBRW9LM2UwYW5ISVUw?=
 =?utf-8?B?ZFFCZk8vb0NlaGRqMVRjQjZmTHJXSEV0LzFLeEE5cldydmFGek9DT3RuQVor?=
 =?utf-8?B?NkZhOFhHQ09WaGUvcnp3MVRLM1F4NndXZldWUkl2cDB0cUdPKzNUSWk3dk5u?=
 =?utf-8?B?VkpPNTI2K0pZdVRYLzhxTGpKOUZ3NlBaMTBlUW5WYU9LR1BITDZtcUJiNWNH?=
 =?utf-8?B?RnF3cTZOUkpHMHFiY1c0Lzd4WnQyZmpUY2tEVjhYUVFTZUkvZi9jYWlLZjJ5?=
 =?utf-8?B?TFdJdFVySlB2ZEFsamFNMWxUV0xVZStINXpzWDc3OGFYYVBrbSs4aVNGRE5i?=
 =?utf-8?B?UkZObDcwanNodko1cmk5ZUZhRlNSOUcvMGVsUm4rODI2OXpIeDRVbUdNOFo0?=
 =?utf-8?B?SWlDMkYxSHpkMElNWVRBc2tacU1SSDNvNU5YVnB1SEdUeHFBMzBQVUdzYk5v?=
 =?utf-8?B?ZjBIdythYU5iZUpBT2RwcHNJdmM4OG5IdGllMjdQTTJhWHhPa05mbFJuYjNH?=
 =?utf-8?B?RnUwa09uV2QvdEQ2dG5QMjJpMzRFMVZSZTJYbUcvV2hySW5ONnFNaFo2Rmc1?=
 =?utf-8?B?dEZnNmk2czBEQjVrcEpkUkswb1BSQ08vZ0tHb0FMcVZ4QzRramNSR0ZNUnJO?=
 =?utf-8?B?WmxtSFFuZ3hjdHJ1K2hPZDNMV0djRXcvT01hM25EaUgrb2lDeklyREQ5WDR0?=
 =?utf-8?B?djVqNk9RVFBLYTRIN0hTbWxYWWRqMW1GWWQxcXB0MHhXa3RFYXBlNGlRSWhM?=
 =?utf-8?B?Y0JpbXlTY1hTRWg4bnJ3WDlpUXo3QjRxbkF0Q0FwVjJFMXJOZGJRVy9nM0JS?=
 =?utf-8?B?cUliMmlkQ2ZITzhuUWI0eFBiRlRJMDZ1MllqMGcvWWxrU2diMnVQT2MzUmM0?=
 =?utf-8?B?MG91NEI4ZnZ6c25LR3lxcGtpME41NWlpRytkZWpiVXN2SnFuR2VYbHdlelBE?=
 =?utf-8?B?S1VObUR1eWRwZkhubldOQ0M3QWRjTDBQbkpPSmJSbVlRRDhaSkZOdEI5czc1?=
 =?utf-8?B?VFRqMjhPcEhsS2RSWjlaU0VLRjJJclVvQ2k2MXViUlhPNnRLRzdaRXNlbDdl?=
 =?utf-8?B?Ukg3a0Z6MkJPMVRJdU1FNTFEZDhBWjZCeFhsZ0I5S3FCRXVVbHJVK3FIYXBZ?=
 =?utf-8?B?RjBRV3hwb1ViMHpmaTF2MU12bytmaFB5RlV0a09hNnk0b0dGSktnbWlHVXU5?=
 =?utf-8?B?RVo4bjhNOG8wdUtxRkxWaEhVQ3BGNzlEOXZGcWxJbG9VcXBaNXJFSTZDZU4y?=
 =?utf-8?B?bmg2VDRRa1A3UnlmSlptK0JCUmJ1VUx5MUJKRGVDQkt6bzFzZVgyZ3FhMjFN?=
 =?utf-8?B?cGxjTnU3ZUZWVHhtM2E3WkY1VWNJSytyTEN0S2NhT1F2Lzk4a0VzTEZZbTJR?=
 =?utf-8?B?UVducUg0amNEbCtyY25KTUNFVHpUaCtFMnE4eWpocHpHS2hscllHMHV5ejRs?=
 =?utf-8?B?YytscnkyMklKVkRtcEpiZURYMDRhMUVQcXdYWVZjUkpmTWhLNFFUQ3lsakNO?=
 =?utf-8?B?N2FiWWtCcXhlSWprNGlWWFZJb25ZMnlWL0o3UHdrOTZwMWZ4WmFsYjVjci9M?=
 =?utf-8?B?ZytxMmVEOGVtQTh2OEpjdWt6TlRTbGFnZlRVdWdXNEczZmRjUi9kR09nR25s?=
 =?utf-8?B?aWlJZjYzMkRMU25JQVZMWi9KdUNUazhFc0hGcS9YRVkyWExUbUJtSnZMTUph?=
 =?utf-8?B?a0FNY1VrVWQyQXYzS2hFbTYxczhwRytNL2JLQ3VQU1lQcWtXRGxrTHMxKzBa?=
 =?utf-8?B?UFpxRHpMMjBGVG5VMENBdHNkTHA5Vm1FOFFOU3pBY3pVNlVBTmRkUWhUeEs2?=
 =?utf-8?B?WlhvU0JER01INmZFL0pteHNtRE9aSmNhNFphWjVKSUNlQ215cklHb2lla0RC?=
 =?utf-8?B?enZPZnhuZllDUGVvc29mNk9aY2NWRGJCNlZpbTBYaGNOdVB1MmZoZzZkSS9j?=
 =?utf-8?B?QTA3NE93VmtDellIMmg4LzIrbExDMHdSdzNXNWY5Y1gyQmpaelJES3I1cFh5?=
 =?utf-8?B?Q1NEc1lFYTZDNDFPYnAwN3FBVkxSUVV3MGM0ajBEcm5zYzNDT0F1a3lYR2Z6?=
 =?utf-8?B?SXo2dVpNRFZSK20rV1VscFR6bzJJSzl3MmkyUE9XNytmanlpS0J6VUVLNXVr?=
 =?utf-8?B?azIwbUpuZnZuRmY3Zm5hQzZmSHZQTFlpZ1M0cExuS0loLyt5M0VQU1hOQTBK?=
 =?utf-8?B?QnVqRnRrUDFYQmE2OXdCcExLVERsNmdSYkdvZXlQbERIYWJrVXk3aEthK1E5?=
 =?utf-8?Q?SbU6Xb2cBASwzD4uJAbZ1SX+kcJOjqphs06jC?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9da133-e437-48b0-4672-08dea60cdb6c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 16:32:08.6260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEXuEJIHvSr/OVf92YasbFvtf0aVNUdSJIj6UJHvMpZE4Skjgul/CxmkbPA5UGLzprALK0+IO2tbRGlL4aqFTsvyNnRpSOF/Yg8c9zvwDXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9417
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

On 4/29/26 4:25 PM, Tom Rini wrote:
> On Wed, Apr 29, 2026 at 08:18:14AM -0600, Simon Glass wrote:
>> Hi Tom,
>>
>> On Mon, 27 Apr 2026 at 08:46, Tom Rini <trini@konsulko.com> wrote:
>>>
>>> On Mon, Apr 27, 2026 at 11:54:09PM +1200, Simon Glass wrote:
>>>> Hi Quentin,
>>>>
>>>> On Thu, 23 Apr 2026 at 22:24, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>>
>>>>> Hi Simon,
>>>>>
>>>>> On 4/22/26 11:57 PM, Simon Glass wrote:
>>>>>> Hi Quentin,
>>>>>>
>>>>>> On Thu, 23 Apr 2026 at 01:26, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>>>>
>>>>>>> Hi all,
>>>>>>>
>>>>>>> I'm looking into force-enabling CONFIG_WERROR for all Rockchip SoCs.
>>>>>>> First, let me know if this is a bad idea :)
>>>>>>
>>>>>> I don't like it, as it makes development slower. I like to see all the
>>>>>> warnings created by a change and tend to fix them iteratively. We
>>>>>> already have a warning check in CI. A better approach is to
>>>>>>
>>>>>> Can you use: KCFLAGS=-Werror
>>>>>>
>>>>>> either in your environment or on the 'make' cmdline?
>>>>>>
>>>>>
>>>>> Well, if it's during development, you can always disable WERROR? The
>>>>> fact that I've never actually enabled -Werror locally in about a decade
>>>>> in U-Boot probably isn't a good sign. One of the things that make me
>>>>> wary though is compiler updates with new warnings. I've tested with
>>>>> clang 22, don't know when clang 23 is planned to be released. GCC 16 is
>>>>> about to be released as well.
>>>>>
>>>>> By having the check in CI, we have a longer-than-necessary feedback loop
>>>>> for contributors. Has this been an issue in the past? /me shrugs
>>>>
>>>> This is strange though, because people should see the warnings during
>>>> development. I wonder if it is scrolling off the screen.
>>>>
>>>> One my bugbears is non-actionable output. When the build succeeds
>>>> (with no warnings) I see no output, using 'buildman -I --board xxx -w
>>>> -o /tmp/b/xxx' or in fact these days 'um build xxx'. This uses 'make
>>>> -s' under the hood, so that it doesn't print a huge list of filenames,
>>>> etc. I also sometimes do a 'fresh' build with 'um build -F xxx' to
>>>> check everything is clean ('buildman -m' does something similar).
>>>>
>>>> Note that buildman returns exit code 101 if there are any warnings, so
>>>> the build basically fails.
>>>>
>>>>>
>>>>> No defconfig seems to be setting this option, not sure exactly why that is.
>>>>
>>>> To me this is a difference between 'functionality' options and
>>>> development options. Putting development options in Kconfig makes it
>>>> harder to turn them on and off, since you must either edit the
>>>> defconfig or edit the .config file. It is easier to just pass an
>>>> environment variable.
>>>
>>> The point of a configuration is that it configures the build. Stuff in
>>> environment (directly or make FOO=bar) is a workaround and anti-pattern.
>>> Having to run one of the config front-end to change the config is a
>>> feature, and good thing.
>>
>> To give an example, we have boards which enable LTO, but it is
>> sometimes useful to disable it during development - it used to be a
>> huge time sync but something seems to have changed recently, as I
>> don't see much of a performance gap now. We don't want people
>> disabling LTO in the defconfig, though. The same applies for things
>> like V=1
>>
>> So I think there are build features which are of no use to end-users,
>> but are helpful for development. That is the distinction we have had
>> for a while and it would be a shame to lose it.
> 
> Yes, the LTO thing is a good example of something we shouldn't have done
> really. Outside of sandbox you cannot just disable it.
> 

FYI, the Linux kernel defaults to CONFIG_WERROR=y. See commit 
3fe617ccafd6 ("Enable '-Werror' by default for all kernel builds") 
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3fe617ccafd6f5bb33c2391d6f4eeb41c1fd0151).

I wouldn't necessarily recommend to switch it on right now, but I think 
it could be a good idea in the mid-term. We're also very far behind in 
terms of warn flags compared to the kernel. Syncing will take some time 
though. For now I'm looking into enabling -Werror for host tools and 
this resulted in (so far) 21 patches.

Cheers,
Quentin
