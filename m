Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE8FE8536B
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 13:26:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03F39840AB;
	Fri,  3 Apr 2026 15:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="A5MR1BfB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40917840B0; Fri,  3 Apr 2026 15:26:05 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 660CA83642
 for <u-boot+nodisclaimer@lists.denx.de>; Fri,  3 Apr 2026 15:26:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InFUNVBTg1Va+zSumHlYZUMXxCDCvLwiycUTRDRInaQDFCzAfiJWsKUEFk/0WmnkZEDoJ+HWMezi7irZCveM1m+IxQ87l0MoIAFcUd+1TJMjR1xG31RLR/NudLHaw6dHeAHOuugtkgBccfwB3pPmG8X52Ln3yeyFtygS0u7VDSG3BMgk51aFUyBj8vt+Hq4yoAb5SzrU89Strs2unOYs3iAXVWzy5RniQ95HDKvGqZMbJWyQsbGdCZB4/1jmGaB3uVyYRCzRvOTyUGz7OQiAY/fuBB9+KHhjh01qIOrUaDbMfp7yGu7O0OlyWoMPVYDYgyvfBzu3p/CZM45+0rXUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZIMnpR4UivV2jYgAUZUzAFE2LQht5rnLqFTEKqRtNk=;
 b=wUxvtEv8QZTAlZAx7wEnf+i3mNkQLEdI3KSm67tr2F2iugLB3xSgRqFZWhPWNrMpU6/5rI245ZK8sT91z0/4qqnLqcb0qFDPY2GOuMhil6tpEEVecmjF+lvZBmO+MZpFPQDbJdvDa5zKzemwb0nG6Rwj+M7m8sKYZYx1yuQnhppXxoOL7T7Bs1idQM/vvtHetW+LO/o5b+Uwx2Ne4ntBfimGgS6DpOcWfXAxac58D3rDk/fhu9aUeWzsCK20KhncxiJK0+yoaLWkLGaWUqtAgRWdTe5KO6NWzG0V4Jyd+RlhXyaQuqkXS3/rpWhIjWdYa5xnpmI9R/FA0g/UGks/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZIMnpR4UivV2jYgAUZUzAFE2LQht5rnLqFTEKqRtNk=;
 b=A5MR1BfB6sv5JAJLwIcNHhP+16tujY4G5ByNEpb7Zpbp5SxwQNooCN4Ad/LOz4PU8deDE44CWhy0kHXiWLHqJNGxX3wqllyHkp9c4HEHryEQCkheGaJDLMVf0V8cxnfJF7FpOF5rRaNNyGZRG/PJXrVFX0SWhOLjYoiXjzcK5U/Mt9VbwrSyYLo6d7d7rjjT6+4tfBPQvb7HfMpeCwsYghM0tQy4jZE3kU8wpgX49FCF9QGVLP9o79yza/S9pxjH1txmJ5HJB093/B0cyIGGNfxHVwS96xROgkXO910jXsQdWZH30RfKPjgetiTOFz7mWztwk5OWu9kz/M/KRxpS6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::23)
 by PASP264MB5090.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:43c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 13:26:00 +0000
Received: from PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
 ([fe80::5c56:6063:a2be:2a32]) by PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
 ([fe80::5c56:6063:a2be:2a32%4]) with mapi id 15.20.9769.018; Fri, 3 Apr 2026
 13:26:00 +0000
Message-ID: <5b2347e9-1168-468a-a762-ebbf80251df6@softathome.com>
Date: Fri, 3 Apr 2026 15:25:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] u_boot_pylib: disable standalone module detection
To: sjg+nodisclaimer@chromium.org, u-boot+nodisclaimer@lists.denx.de
References: <20260330141852.984717-1-paul.henrys_ext@softathome.com>
 <CAFLszTgfN-+Y7K1ZkQS947BdMBFtPqOLof8tsU7b4JzCKJbBJQ@mail.gmail.com>
Content-Language: en-US
From: Paul HENRYS <paul.henrys_ext@softathome.com>
Autocrypt: addr=paul.henrys_ext@softathome.com; keydata=
 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
In-Reply-To: <CAFLszTgfN-+Y7K1ZkQS947BdMBFtPqOLof8tsU7b4JzCKJbBJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: PAZP264CA0039.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fc::21) To PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f2::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAZP264MB3119:EE_|PASP264MB5090:EE_
X-MS-Office365-Filtering-Correlation-Id: 02789b05-dac9-41ba-d9ff-08de91848bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: ejvujG4boCDgl1TlZXD0srsJtuhMB7+pEaonjyugsyo/Vlr/TTAMEcrLQLpDLGU4uAj8/u3w8VGCt2IVnRR5nvVm2rB5J+Vro0Hy93Axy8J/lR/AX0+R4KO0Sa7YG97B29sebc+7ZD3CI/xbntgmdMkC30OwkjxkURu/FFuKAQL2u0RGIyaWZKDO0IeaYHxBcy8ODbM1cGkMlOyvVj5lFKSPzITuskCz0grZ5ZHhykwbGVD1rDpZb1DR5Ea6tF2WwH3DSDJ3xdQ1KJsrGniJGyu03slOh0BwEzNMQlRPlWsTzHf4XQK93ysNaIJZGBsa+GLe1d3/ztSbPi2vg4oRexhNzqxNwpWgxs5sLxcCuYuIlFUjH3R7AtrYvidpPj6F+/AsL2WTFft0q2UmTHJUCyXZGOgrVqAxSPWWVqFZTiX7YtUuIqzKufEbw9LQlsZWIGmH1vJHfoi8i+J5vvoPwGDi7fxq1tYSMiwMOtOOnE9F5sGm1vs9o70zXqTNcyqdAHJoKmkIodzqhnMQrDa1K5WCKLp9si2zv5l4EzTWKLOKDSZJRtOi40D2eQVM1dDwW6lLwwXDKJHEFhmubc/Cz1ozeuB07lWLjr+AOjB/3wfDJ/zzuPxHbuHEe7w0h/9tdOmumbblLCYEWlbAP8E++au0HKUqU8sMoGw/E0/9YHA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGtGWDNXbjBTcDBpaGdkc25rSWpWZXlaSTV1QVJBdUQ4dnZDd0JtLzlpSUhN?=
 =?utf-8?B?QkJ4WDNKRThIRVZiY0c2eVpHRy80WTVKUjJlY2g1M1poenlCNTF1d2hSSGh3?=
 =?utf-8?B?QWdJL05yTGdrZDJuSjB5eDZRNEtMaldVUUIzT2tjdlc1b0pVQjl0bEhwMWxP?=
 =?utf-8?B?WTlCUzZsdXhYRFhSa1Q1Wk1HR1N6alFxVnlldGZxeE9KYm5WMGJFZHQzVWt6?=
 =?utf-8?B?cXZEcEZhQWlHSi9zalVYekdRRGdhRGpQSVNXK0gxdnp0NndFemcxdnpHSTlN?=
 =?utf-8?B?M0ZWWDQ1aC9BUmVzSnFpeDM4TndHcmpMN211VTN1RnRuYVZhNlBQbndIaElX?=
 =?utf-8?B?cWxQamVUZkxQc255cWR1eEQzczVZa1RKczVqeGlVSDNpWVdQQU5QdzJrUVhw?=
 =?utf-8?B?NWFZZXVMbHgvQXFCbnFSamY0RDFjQ0wzSUkvWXlRRDkrQkJ3YURENllnRTlL?=
 =?utf-8?B?NEk5VDVDT3Y5NU9MMkR1ZnJLekd1VmkrcTI0SEJDR2paVWtJekk0S21KUnZH?=
 =?utf-8?B?UWU3OEhOSFhkRmI4eGFGUnhKNWRsN3ZxeTA0dTNnbURiQTF2WTQyUmJlYzVT?=
 =?utf-8?B?WmM2d0JxVTJSZzZ3WUEzUEJSTUthMlNHNEVNbVYwcExnOEx1bFJOaEZNZHJF?=
 =?utf-8?B?MVV3SnNkMTFxamlGaGpUbWNReHBpck5YazdOZXRoZUtCYUc5OUlLZTEzc3Z5?=
 =?utf-8?B?YXlnY1NVcUtNMTk3RHp5MU1Hci9mcjREYUVjdTI5a1c1bjRGay90bFdOc3NV?=
 =?utf-8?B?My9ERnVlUnNjNHAwUHdSMWM0SXRjZUdkbG5oMU9NbTVkV04zUjJDbGRMY1R5?=
 =?utf-8?B?b0l1SDhkYTBhd0x1VnZKODVHRUZDYmUyVGtsU1JHckg2ODlNalhRVFRVRlpv?=
 =?utf-8?B?V1VsY2FaSWdFUCtseCsvZnNyTTU0cHdiT3dYZkpSOVk1RDBVTWV2cHFSL21J?=
 =?utf-8?B?ODdsTktkWFhhcy85THU3eHJiNmtIaDFiSVpyTlhza2t6c0RPMWoxWnZGenRN?=
 =?utf-8?B?cWU2VnF1VXRkTUVtLzdXWUhXb3c0WVNsenJsRzZhR29qZWw4UjBUQXRMNElu?=
 =?utf-8?B?L1FPQVEzbzJ4UzN6UkVVVTVObmFtNXF2WTIrMU9kcTROdmJKeEgxaTcySUZO?=
 =?utf-8?B?YXRDeWNRTzZYZnExRWVZTm1hL28vaVBkRHE2MEVSQS91a0czU1RiR2NBSmFu?=
 =?utf-8?B?YUdpL29mWmhHaWRBcHVmREEzR3ZrS2RkdnNlRlBBM2k4SzBWT3VhZlRNRW1O?=
 =?utf-8?B?OUNwV2tmcFRjY0tQM1NaQzF2MEJ3OWNlejN4dnB0SmVnMFlNV2xyNWY5Q0w5?=
 =?utf-8?B?eWlPQlRRcWZwME1KZWhpRitGOHM4K3k0SW0rSlBkNEtEVjBIN29GYyt3U1oz?=
 =?utf-8?B?Wi8zYi9CUEFkS29PWFFaRG5VTWU2QWhlbHBuWVRPajBBZWkxMFFaWlB0MkZv?=
 =?utf-8?B?OWF1ajdGUTZZWVJlTUU2SW9YRUp1T01tVE1lSTRqU2NGdkVwZkV0bTREUGFG?=
 =?utf-8?B?dXFQRzdDT05SWmVkWFE3YjRaQWVud1c2eFIxU2NMUjh4enczQ0pGbmN5YUdH?=
 =?utf-8?B?ZkhyRmZRR1BadjhhM3JZRHNMQno1OXJiT0V4WXdERXlPRzNSZ1pvbUlKZzBT?=
 =?utf-8?B?ZlU5UzNyR2ZhRUorMnFkOGh4LzNlMFBNL1JJU2huYVpCT1lyVStkb1FjTHEw?=
 =?utf-8?B?L0VxVkk5R2tWMzNCYWxqUVBIVHVCK2l0RUszS1ZValNOTGVQN3FYRzNoQVVO?=
 =?utf-8?B?MFpkVEFiVU92dm9Ia1kyNmhUM1V3VkJyVlRrZ1d6dmJ5ejEya0RHZHF6SXBX?=
 =?utf-8?B?N29pbnZKZG53K3k0UVRWa3pHeVhvbXcrOEhkOFhFOTB5cExkdDFRNEJzeHQv?=
 =?utf-8?B?NnFKYno4NHRvd0tnTW9tZWNNeml2V215VE1LdEVvRFdBZzFiTDNYTHgxUzZy?=
 =?utf-8?B?UTRodElCcVFUUXNKc2R3R2h2VjFad1pkL3dGbWdzT2RpaWV0VDlOYWdFOHY0?=
 =?utf-8?B?dHV3VXpVN0E0UHZQZ3JqRnkxYzM3dkE4RW55eTJqTC91N2JFOW51ZEw5Y3ly?=
 =?utf-8?B?NW9uZzNkY2FuR1N0c1lWVHZZaWNEL2p0Y3U2dngwQkkxQnc5akd6SWF5WWtj?=
 =?utf-8?B?UHc3cEpOc2JjdHJOS29mUDBzTGJuK0hUd3ZTVEVqSlJXQVpJbnRNbFlqT0xo?=
 =?utf-8?B?Y0tqMnN3bE9wTmMweHExUDUvV0l1TFVsVnRxY1ZPdzBEZzNBbTlicnlFTTho?=
 =?utf-8?B?SG51VDZNWHpaenA2Y0xpcDlKam9OTTRLTkdHUjY4TjNURUFCeThIQmtYalRt?=
 =?utf-8?B?K2V3MC9ta0ZuUGsxc0l2dmVndk9jZmUrMVFYdUNUZHUwRVV2QVMrYXFvTC84?=
 =?utf-8?Q?s1dYT8H+Nbly7ddE=3D?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02789b05-dac9-41ba-d9ff-08de91848bdb
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB3119.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 13:26:00.2986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiQIgRxdk9vTRIBL2dH7WGSHeUqNBcFfdSDEPnhv3XQG/aU1ZNC6YdISqB9NOpeRXc2eCo8rqR9K0/8PLsDDppExYrwBpnhFfOVsudNUDro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5090
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

My apologies. I actually sent the wrong patch and in principle it was 
also sent to the mailing list but this first version should be discarded 
and the second version reviewed. Unfortunately, when I sent the patch 
version 2, I forgot to add the reference of the first patch series...
The second version of this patch series is 
https://patchwork.ozlabs.org/project/uboot/patch/20260331080636.380507-2-paul.henrys_ext@softathome.com/.
Sorry again for the mess...

Kind regards,
Paul

On 03/04/2026 15:18, Simon Glass wrote:
> Hi Paul,
>
> Can you please send this to the mailing list too?
>
> Regards,
> Simon
>
> On Mon, 30 Mar 2026 at 08:19, Paul HENRYS
> <paul.henrys_ext@softathome.com> wrote:
>> Do not try to detect standalone python modules at the top level, so setuptools
>> stops searching for: command, terminal, ... as independent modules and instead
>> relies on package discovery.
>>
>> Steps to reproduce the issue without the patch:
>>
>> git clone https://source.denx.de/u-boot/u-boot.git
>> cd u-boot
>> python3 -m venv myenv
>> source myenv/bin/activate
>> pip3 install tools/u_boot_pylib/
>> ...
>> error: Multiple top-level modules discovered in a flat-layout: ['command', 'terminal', 'test_util', 'tout', 'cros_subprocess', 'tools', 'gitutil'].
>>
>> Paul HENRYS:
>>    tools: u_boot_pylib: disable standalone module detection
>>
>>   tools/u_boot_pylib/pyproject.toml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> --
>> 2.43.0
>>
