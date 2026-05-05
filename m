Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27302FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 11:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A37D88489F;
	Tue,  5 May 2026 13:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mWxcuPDK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7EA6848A7; Tue,  5 May 2026 13:29:29 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CADF78488B
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 13:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtAwjma1pOjwbcdQ3wepGHBaORNr7pzj1OxZGnYM/AX6kCYwBqO/PVyC3ahv4DCORhb/8FSgCnHPE3uQht584qhDmKz0uq4s5GKZGw1Zg2agML31OzfhCZVVqgfP+8b6sfZno/YJUkrNomFRHPlUAqbOBAivgl49qfP1QhPIlnfDgTM/dx1L42oAyaRMzRZd833QS1TcLEE3R2atWI6B9ebJuhiTcxpgqw/7nKUcbiKlmRYPGf1Jk3WVpzvsxqisFlAcZMvFtS4zm4R9mwaHZbkcfyUHgSX6lTghqCcgC9Bw9EeeI0ZX/DHo7ElA4TStVDLDZQEhLZ3qCMpRK2vWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/hTLyhkbE56xdl8HcANWFeLPq6o3Y78KDSDbIxEnCQ=;
 b=ZqEQM8evbVVHUtbYmus0SX6J+7pPLZ+5K9482U6oEhVmPDsHvvzzIngyq34rCQSB8at8BVSz7zem75bHZCI9epLVBYLVM8UanVWGyfPBpMNuIod32s1kJSU2GUgpSE+7FqJpuxF4Yk1ZVfG3LYaoGSIicwZ+rHP33vt+IAU8hZrq0a79q6xir2cdTngyxVPRvY8U9M/hIKF2zE+bV0oZhlVgqxMdfJ6ECckaFxyr56gpH89hKk4boCG/J7y49T8f2/xTbZHYocmlfjO+uvP3PJfnpEcdKWI90hhPtTwurfln+xdJSGvLrNFk4yvNVwkABYdAVBLyYF3dpQkyW6C0WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/hTLyhkbE56xdl8HcANWFeLPq6o3Y78KDSDbIxEnCQ=;
 b=mWxcuPDK09saXxNvj/N6+t2esLUIbTPWCzsumv/9tGglLe/NxyIfeMzgtZNVcCsWxKVa+8D/tdq3oV1aF0VHzrDn9/j2/aG60KvIX6WmOcdwKovs69IEkam8keYoL7ubYewspN03MMIaay5DVN/n6IP5rbW5Vw2hfJhkujQOA14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU4PR04MB11315.eurprd04.prod.outlook.com (2603:10a6:10:5d8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 11:29:24 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 11:29:24 +0000
Message-ID: <4746bed3-e157-4c9f-9697-d07bab4a0a7e@cherry.de>
Date: Tue, 5 May 2026 13:29:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC next 18/18] buildman: set W flag to e to be consistent
 with CONFIG_WERROR
To: Simon Glass <sjg@chromium.org>, foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <simon.glass@canonical.com>, Raymond Mao
 <raymondmaoca@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-18-b19301d1948a@cherry.de>
 <CAFLszTjra2Tcsvki4qKz7h6EBshDccUP0M-6QkHpLMKAUYBw+A@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTjra2Tcsvki4qKz7h6EBshDccUP0M-6QkHpLMKAUYBw+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::18) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU4PR04MB11315:EE_
X-MS-Office365-Filtering-Correlation-Id: 107447e1-2296-44e9-8fbb-08deaa998f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Gzn6pSgATzt4/JYY36/CltbBHgDGhOCSsSKpA4INdPNfBNmSw1iH9630PbMp5I4zm4bb7eifIceIOm+dZf1RD7NUIey7lJUNEgGfBu4NjYWZwGwC7YRF6EL02B5tvqnRFatGRyFh8o5UCXGi63OSCqyFcDjDn4OToZh1NPhBZmY88JKGI5jXIPunhLqFG+UZ1Gm14WPNcOK0pUu5OC+cRmDf/VkTE7mwZlaFVAkLlC2qFn+RWJipblZt82KwfrPekvdSbcutAqbaKfiyzJAZQd10QkvzW9LCVg8f2OUbIfiHeuukS9ZSuhp1XWlguurOajy6VYn4JNCY1ujobwCyEVLsHPE7kUcWvNDdas7aRn9xC5miqdsZRV0yPXlZY7xauTOJ2r4GWfw1TlkPwMOS2ZkgLnSDW/vRULm2mOIo6BEg+LicIpaGz4hDeIRjss2wCh2Gg9WFbjjk9FTmklQ16R8Cbeg43Ih0aOP3Eoga5jqcMaFacxFsMz0wRwl/8WWZTIyHoyyZHq7ybpGxka6nhUlQEvver4syQInw57qvU4nkVXPzDBY56nPzTjJgfSKZ+bO98EYga9D0SBTDLtcAykbIxm1jYZ54ctG/j5zhXaphfwttOwyjC6YPjsMyw2nSFsCK+NA4yt1GjBPQBD15ST7Fb5mry/j6d31HPMnpKdy1tzeZEBAxl5Ia5uMh80Rv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d00xS2VrVVB1YXZZQWs3SlVVZDN2bEw1L3FodTVLYUkrT1ZpUTRRQUwwRk0z?=
 =?utf-8?B?bzhWU3FYdXpOZXhoNXQ3ZkR4TTVZU0Y5dkJEOUIvWCtCRTdKRG02cEFIUEVV?=
 =?utf-8?B?YnJjUTdLMm9jdUMwTHk1TDFzTGxqQ2FkcTN1cUFCRmxENGpMTTl5Wlk4R091?=
 =?utf-8?B?bktjV01MK0ZwU1VLb1BxZ1Z5K1A2WFJmb2FOTHlhaVYxSmhHTmtaNC8xb1cy?=
 =?utf-8?B?OUJUbERSUVNldkR6MFdrdWlmYkRsN0lwN2hBWDJtTkN6cEd4bmp2Zk8vc1gv?=
 =?utf-8?B?Y21rZmltTTdYUDhEMmtTZGg4L3pBeHpkN2cvaEE0SFVpaW5Ja25BSUV6dzNy?=
 =?utf-8?B?VXJockxsN0xrZnJTRE04VkV1WGJHNjBEb1UvdU1DbmpIT2tmNk5pY3J4QVlo?=
 =?utf-8?B?TXZ1aGtNYldzeUlNSStpZzJkaFR4RUhMOU8waU1saFNQdG1QWFQ0MG5RSmdj?=
 =?utf-8?B?bndZK2hQc3JBR2lzNjdybE9lRFlHQnhsYVBSdGpUL2lXenczaWlJZlROWEZB?=
 =?utf-8?B?VFMzbnFGUU5mUTh6ME1UalAvU1o3dTBySGV6dGJ5QWpac3pzYkpaeHRnSmkx?=
 =?utf-8?B?bzdRUjI2Qmg1dWF6STJFVHJEekpwc3JzcmFkcUE2OWRrMlM5WG9PZjdRYWh0?=
 =?utf-8?B?aWdzS2tIY3RkSGdXcExydWlaZk1rMlBYNXBnaHRIekE2dkt0QXRtektEdXE0?=
 =?utf-8?B?MldMRXgwMElYeUhKK3JHbnUwYnZOREQ4VHNaY0E2RFBzK2JUTlNMZ29GMzVn?=
 =?utf-8?B?RXJ5ejZRRU5SVE9zYlN2YkNsTU5MNlZ2ZmJmWWcrVHp0NnIxbFpEYllHMEho?=
 =?utf-8?B?bXovNmNSKzY3ejlwWEcxUEV1YncxRDc5R1VGQmdyVDFNa0hnS0VSUlRWd09l?=
 =?utf-8?B?b2FnSE9RdE8zK2ZVcUdFT04zR0hpdmU3Tm91Vk9zK3U3blJFM0prbEJMcm93?=
 =?utf-8?B?eVBPY2Q4MHQzT1lJK2pRSjg0Q3BKWjF4b1ZRdHkyWDFrL2JnTytLWmZmVEFl?=
 =?utf-8?B?MjBCcnY2UlZXb0wvdnJITWJzKy9xd1hHcmdnaStFU1p6YnRCbWFpS2ZwV2ti?=
 =?utf-8?B?QUZuaEx3ZnlOTkxKM0Z5aXRxTWFCZ3lHclRUTEVZbzF6Vi9ZejFTYkEwTFNz?=
 =?utf-8?B?bFVtM0lGdjFXWW81Y3RhbmJLYWJWcFozalJmdVVjS0ZEOUJGU09DK3UyaVYy?=
 =?utf-8?B?cDlXSkVML0tlbXpIZHh1UWVnaXZFVGRmWGMyZVlqVDYzNUlrMklxNGorbXFn?=
 =?utf-8?B?Z2htUWxMRzFiRi9ScFpjeDBkZ2tHV21XS2V1NlU5Ynl6eXc5ZEQ3c2NWTmpt?=
 =?utf-8?B?MGx5U3gvY1JKZ1pVM0JjWktTWTkyNktTMFRHNE1oT2cyNkdiK0hCdU4vWkM4?=
 =?utf-8?B?YXZFUWM3S29sMWh4M0x6R2tKazBYbFdVN0FsR04yWmFLZlNDaFUySEZjeDZk?=
 =?utf-8?B?KzJSSW9xQjgrcnlHNFRQT2k0dlRYS0lxNG9ISy8xK1pYSUdGc0UwYjhkSzVx?=
 =?utf-8?B?aGNWVGs0cHdtZEdTZHFjZXZ1MytUSGwwaEIrZGZrNTNqMFZGZVYzNHZ4OEJz?=
 =?utf-8?B?NTJ4TUdMWjFTWEtneG1ORlMrQ2dJbmtqM3dGenUyTzdPNDJzVzZNSXdPcFp5?=
 =?utf-8?B?VzlHYVF3L3l1d0FzM21OVzBMN1VzVFB1cWNYU01RZzN1ZEo1TjFHWk9GcGVp?=
 =?utf-8?B?eFVPTGlEL1l0REhkaWprcGVXU3h2b3BBeStMMEtldnI2MTBiNU5wdE5yZUpV?=
 =?utf-8?B?RVkxTWRIck14aHkyTVVKRGZMeUYzaGUyZGRJMGN6dlhwUUJBaTM1NEVvS1RM?=
 =?utf-8?B?TG5FdnhBYmNTSTdVRldjNmJqMDYwTGNQQWY2cFM5Y1VXT3lQUVBHOVIvdFZN?=
 =?utf-8?B?UVI4dHhMUTl6dGtISE03UkhycjZBYUZuNlpGSnlsbndBQlFaakxEV3doK1V3?=
 =?utf-8?B?elhjWEVYVFFLZ3RMeDEzTHQ2WVd0dmtGVTRiU3Q1QVZZNXRWcE1PWUlPaWFn?=
 =?utf-8?B?UTkzL0NmSjJOZ0lMWGpKV2dFQ2psQUVzQVJlOE05blE0ZlMzMEVtTTFQRlMr?=
 =?utf-8?B?Y3IrRWZOTUV6UDlGQnBCb2QyZlpZTWpGZUljYUVOdTNPb2JmdWU4NHI5Ulcy?=
 =?utf-8?B?MXoyMEhCVEVVZ3YwanJzeU1hMmpZRm92NXZ5dXkvaGFpUkJlZTVkRHlMN1NK?=
 =?utf-8?B?aEo2WmhmbEkxbmNKRDlJcFJCZHptUURlRnhYQUk5VDRTd0N4K2xyTU5laXZK?=
 =?utf-8?B?WVFXSkVWTXJpSVBvTysyQVQ0NE9UL24yS08rSHFkWlVnR3VTNStOeitmNVhO?=
 =?utf-8?B?UHJMQUZXaUpCWjM2OW9kTkpnS1h5emlzakNKZ3pyK2haRDlkQ0ZYZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 107447e1-2296-44e9-8fbb-08deaa998f34
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 11:29:24.3923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWeFtl5E7hrywMv6JInk2ux1KSC9M+5L7tmJOEFExHOQq/EQEevthlHr8SKQ/XVpSxTN78wugjeQYaXqrptjVQGRXToAGt0T6w1SnHJ1UhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11315
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

Hi Simon,

On 5/4/26 10:38 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On 2026-05-04T13:20:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
>> buildman: set W flag to e to be consistent with CONFIG_WERROR
>>
>> Buildman currently only enables Werror for KBUILD_CFLAGS (via KCFLAGS)
>> and KBUILD_HOSTCFLAGS (via HOSTCFLAGS) but nothing else.
>>
>> scripts/Makefile.extrawarn now supports --fatal-warnings for the linker
>> and assembler, which are enabled whenever CONFIG_WERROR is set.
>>
>> Let's make buildman set this variable to enable even more checks.
>> KBUILD_CFLAGS and KBUILD_HOSTCFLAGS are kept in case buildman is run on
>> a git-range where W=e is not available, it's better than nothing.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> tools/buildman/builderthread.py | 1 +
>>   1 file changed, 1 insertion(+)
> 
>> diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
>> @@ -233,6 +233,7 @@ class BuilderThread(threading.Thread):
>>           if self.builder.warnings_as_errors:
>>               args.append('KCFLAGS=-Werror')
>>               args.append('HOSTCFLAGS=-Werror')
>> +            args.append('W=e')
> 
> Please update test_warnings_as_errors() in tools/buildman/func_test.py
> to assert W=e is present in the make args alongside the existing
> KCFLAGS / HOSTCFLAGS checks. Otherwise the new behaviour is silently
> untested.
> 

This test is only available in your fork of U-Boot. I'll therefore 
ignore this comment.

Cheers,
Quentin
