Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C2CCA0ECA
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 03:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C1B486D23;
	Tue, 12 Sep 2023 05:59:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="REnVE3oP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2DAB86D23; Tue, 12 Sep 2023 05:59:28 +0200 (CEST)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (mail-os0jpn01olkn2081b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:700c::81b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1987886CDA
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 05:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wiagn233@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8YYQfHUWGWyAx8QeJatOfV9aNXfzKL1+qFUSRaGA7kllBMXxyYcyd0OsvljHqyDlZ+F7R/wFobWj0yAum9IoFLL08AB2SkHs8Y/TR4qY8ijehZRXCCDQZNbFrZsuaSrV3iUw47nBmq7dxNuSRT9VCJAwnw4Y2W3DHtnZbjlXEP63kviVmLi9ge8co9TBsNtsccHqjvl2jDuKE+a7RoSiBJAz8/QXBGg6Z6CnsOzGdxPFr4jo18MOG5UUkQ0H4QKN8qO2HZ09rjMBJ1DUps1Kexx+YZImyOvO0NCQf/6ts7rsMjsd2dWEVPJLS1DVunW20ECpi+LBYSXvk80KOuDyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrg2RSWVPr2w7DLUJpJcs4Y7G16lWynm+LsMGGPDRlY=;
 b=IVDo+U+UKtOPLa5BDzvpwsIK5z5RG/E9MEOhqBIAC1J7qiMwJ9NnsOpH0Fgx60n3+mh1ffoApleK578EgrIhD1TY3/lcAK9qILtzexrR+p0xTePAlqoDBy/w5M0W5Vk5hmmIE52F5hT+s8KTR+ay8tQTPvFD9I7/GpCbVKez3vB0e+ql5furZZ7n04QqO0KyMchuI+2mm8YSZXeL3guZsgvvgGHdjRgFpqq5zA7udsJ5YiCyE9xGHyxtc/yTEiwla4rRzQRqUtOGZhTJh3YS5Gh0r0YsOmI/7CdtQLmumEAyjY12kVPCSqxLEpC+9R1CYMnnJgOPIXEbHLG5rOuPpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrg2RSWVPr2w7DLUJpJcs4Y7G16lWynm+LsMGGPDRlY=;
 b=REnVE3oPHf8ZCnD4oaPSVgIESlRGX2XYTX07z3z6NuuteL2GknefdX+VmhRafbdcYWWCMgDBi0KjIq0Zj8T+sG7Qic0SkqYmsr7p+slJCikWgBFSRYUg6Dvn4VcvHvx5d2G//iAX1//rSXTW9cRPbb70RHdkPrz+SzC3wYjchPBIC1I0V7+vPY4ozMlPrWdrnE52KRmgRtVTzpqU4/OHe2NR1XGmfoOhDj+hjA2Vim2IAvKD1/+pcak3CTt8IVkARI4uZwbskuqAwZH+R7QLSIY+RRdT/VkDQKMh3YT9VI966e+uNHZi8CeBf4Q2MRwPHJofTex+Iugeagjb7nOzqA==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYCP286MB2100.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.16; Tue, 12 Sep
 2023 03:59:18 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b%7]) with mapi id 15.20.6792.016; Tue, 12 Sep 2023
 03:59:18 +0000
Date: Tue, 12 Sep 2023 11:59:12 +0800
From: Shengyu Qu <wiagn233@outlook.com>
To: Jami Kettunen <jamipkettunen@gmail.com>, u-boot@lists.denx.de
CC: Mason Huo <mason.huo@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Jami Kettunen <jami.kettunen@protonmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RFC_0/2=5D_board=3A_visionfiv?=
 =?US-ASCII?Q?e2=3A_Select_fdtfile_based_on_revision?=
In-Reply-To: <20230911153253.20701-1-jamipkettunen@gmail.com>
References: <20230911153253.20701-1-jamipkettunen@gmail.com>
Message-ID: <TY3P286MB26116A5FFDE768C2E65128B898F1A@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TMN: [EgPAbvGWrjCBKB3g719++nnKVuF7L/4BPJp1ZEEnZOAXk/K4ytgvWfOkxjDoo08Qnd1MU0Q6Je0=]
X-ClientProxiedBy: TYBP286CA0046.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::34) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <A54FCC77-BDBC-43BA-B15F-57EA4A73860F@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB2100:EE_
X-MS-Office365-Filtering-Correlation-Id: d63c1fe2-ca09-41f4-c9dc-08dbb344a340
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KID52xuhJN0wsj+eoq0yUHB+HQf+HXqMqRiLzFztPEBurxyyW6TEnQHRhTmqKOk+WqmIYfCCDLInuaZAs8r4PjpbogrYhnlb53G32N1CX2bocIDJUuITCy0QG1/C9O9B5RFIlr45ycHHOAq69mvuPWYrQsuLcddzeAcL2n06ImJDqTI4uApSlsrUR4LWRU1edP3k4dMqDwrYOqS1OvgXsxoCwFYjQ6qLMXkDzVTxhCSmqubI39FbTdb0OZ890MLbaaexrX4inNIbk792FFI4RgAxuEZaljUF5IxWcTtr9WMTlyFhi5D1BQnVIXG/uc5LqPuHUWL8ZqESmzTcL3i4z8Y95mtp/PeH1zJyeXUBh12rMHnItDyi9KDh62Np4sDGZLVuUV1vuT2XUNuEuHZQCe/dUn54wWl9/xPqgGcYZnZduqgCmQ7wBZbojsBwthz8EObTvn611D7TQEm07d6xPyMf5fR8/+fzdsRPAyhAZStJnglgzz+li13vuw4eitvNh8HVHJsV6HCfPVxxT8HLytBQJmchz8qu+VMG8g75W4XShz8azVNklPLaq7M+vnldTvPovwDKTMGKGtJhFcqIxX+1/ituPG2H2hCLiD7+a3k=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3laY1NvUTA0ODRWMDV3aUxCb1BPVE1jZy83eldIZ3QwVzRHcW51VlVCTGh2?=
 =?utf-8?B?S0FUQ01BclZFWW0xMUNXdVBZRURHVXpsNjFSMHhKcDlsemNCT2JvT1llYlBO?=
 =?utf-8?B?SXVmVVBNWDNIYUV2eVF5SWR2ZHBMS05OMWxabm5wT3hjNDNwU3VJU3RuUnJ0?=
 =?utf-8?B?NlRWeEt5YUhPTDdic2t3MTBhbm9yUEJodTIrWGFVcTRkaHNQQUt6bURkOGdo?=
 =?utf-8?B?TWdsQ2xZWllYWWdtWEpFMUh2alE0ajZiek1ESW92MmdLbnh2aXlYalpOK2Js?=
 =?utf-8?B?NVoyMTlZWVFMZWRsc2U2NVlmUS9Nd3RyTS9kdFdFQm5hV28wVzh0QXJWMVdZ?=
 =?utf-8?B?eHUxQlBYamJ1MFd3cVR5ZFBpV1k1SSt6THd0NmxWZ0NMT1BhbGFuS1UySVp0?=
 =?utf-8?B?TW0wQnI0L3JqS0dMZWZFcjEvSEExQ0FycGJ6bGVXUm0zeGZaemZwSm13ZGZ4?=
 =?utf-8?B?eTROM0NMYWVTMm5qeUk2NitZellyczAwMlQvR08xZWVRay90d1lPT1psdmIx?=
 =?utf-8?B?MndsTmdSMmpZdTZwVkpSbHZzMXFxNlo0RUIwNFFVUjhSWGJYY1hsNmtMaVQ4?=
 =?utf-8?B?NHZZT1lFQmpQZzdDaFFIK1JmaS9sdWdwTGlLMHdhRmZoWmZIUE1hblpzZFVz?=
 =?utf-8?B?d21HNWtWTFhJKzR1NVpHbWRkY2pQQTA2ZnJMSlNDekxMV3d6U0NZS2M3enBm?=
 =?utf-8?B?eDR5WEc3NHgxWUwydGVkOTlNOTlMMlRSWUJFWTVrd2ZDemVEdU1ucVNDRDc0?=
 =?utf-8?B?WHQreXhZMEtrcDBqRUphdWFrYjZ3YytMcVZXSmRTZUJCR292cnJ3MHNRWm9Y?=
 =?utf-8?B?M09XVVJxMnhpTHJ3ZEhuOFAva0VJenl2aUV6a01MaWR3OGZYbkJjbDJQaTJ0?=
 =?utf-8?B?ako5elg0M3diSTlKRjI1OTdYTi9tOXVIQ3BEcVRZc25BNkV0OWFuYXFOZkQ2?=
 =?utf-8?B?Q1p4L2ZvN3ZHSk5aMDBzanBNSS9RZEphUmV0YUQ3WGpwankrQ2hVeGNmaTB2?=
 =?utf-8?B?alVuSmJ6dTNpblg1bXNaWHZwMFlWRTdLL09Xd3VVZm50WnhyQUZ3WncwOXAv?=
 =?utf-8?B?N0doUW15QjRhbEl3MzkxK3F2NjlpRDdYWENMRWg4clBnaisyQlRWaTZUMUV1?=
 =?utf-8?B?RDhvZTFzZVBzd01UNFl4UVpkMWM5QlR1UnplaGVIazFzeWxBZXlyZXNOdFRU?=
 =?utf-8?B?NFYrNDRETkY2YmtxSEwyTWpzdlZTUDBLRUljNE13TWRETVFFY2VoWjF6cnBt?=
 =?utf-8?B?UEJTbDJ0cHhWcjZwYnliSWcra2J1V1NrKzZGM2VqVi92SkhSaS9ZVzR4SlFr?=
 =?utf-8?B?YkpmejdUbWNCbTRQZ3pkdDAvU0VJR2hMQ3FJS3cvdmw3VGo0RENMTWpsTDBp?=
 =?utf-8?B?d1NYWDQ5SDhCYitqSG50a0ZPbHRBYVRWMFJpYWErNHRUbmVwRnhSUEFFZVk3?=
 =?utf-8?B?RXdpTzFLNjZoVEh5aUFmbkdpRUFZTXEzOGpkdkdOek9IYlpGTGtMaGF4aEUy?=
 =?utf-8?B?VFAxZnVjVHFnRjZCYUxLd09YZGYxU2tORURwTHY1SzJrZmprVzRZYjJPV1I4?=
 =?utf-8?B?VWRvcXR0T0VuU00yNjFqSVdsZEZVczE0R3Z3RGh6NXlkWW1YbTFHejBCWS9J?=
 =?utf-8?B?T3ZnRGxWSjhVVUg2S2JpNm50NnBzV3FBNCtSK2Z4ZW94NU5ESGM3L3I1YkYy?=
 =?utf-8?B?N3hhaTEyQXdrakpGb3N5Zks3UGdmQnRLMzd4REZhQXdUY2J4ZEVuYVFDMjFD?=
 =?utf-8?Q?Z/vDeuLgBUxtO2ATLU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d63c1fe2-ca09-41f4-c9dc-08dbb344a340
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 03:59:18.4042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2100
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

Hello Jami,
For DDR size problem, I think we could enable CONFIG_OF_BOARD_SETUP, then u=
se ft_board_setup() to apply fdt_fixup_memory()? Just like what they did in=
 spl.c: https://patchwork.ozlabs.org/project/uboot/patch/20230615093652.231=
61-12-yanhong.wang@starfivetech.com/
Best regards,
Shengyu
(This mail is sent twice because the first one didn't use reply all)

>From: Jami Kettunen <jami.kettunen@protonmail.com>
>
>Currently booting a mainline Linux kernel via extlinux with fdtdir set
>doesn't load a proper DTB but passes on the U-Boot one to the kernel
>which as far as I know is very incorrect and prevents user (normally
>distro) provided DTB usage in a sensible/generic way.
>
>A uEnv.txt or similar manual environment changes were not used and
>should not be required to boot the board as per:
>https://u-boot.readthedocs.io/en/latest/develop/distro.html
>
>This also currently needs a kernel patch[1] for my board to have the
>full 8GB of memory available to Linux instead of just 4GB it shows with
>these patches alone.
>
>[1] https://gitlab.alpinelinux.org/nmeum/alpine-visionfive/-/blob/main/sta=
rfive/linux-starfive/set-8GB-RAM.patch
>
>Jami Kettunen (2):
>  board: visionfive2: Select fdtfile based on revision
>  configs: visionfive2: Enable MISC_INIT_R
>
> .../visionfive2/starfive_visionfive2.c        | 25 +++++++++++++++++++
> configs/starfive_visionfive2_defconfig        |  1 +
> 2 files changed, 26 insertions(+)
>
