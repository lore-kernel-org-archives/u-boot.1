Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09E7C3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 09:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAD0581F7B;
	Mon,  5 May 2025 11:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="NQ4G5ZZB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F7AA81F7E; Mon,  5 May 2025 11:45:14 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F81880F03
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 11:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CiVswL2AY1HVRlhRuRF65oun9yj2JsFpCZnu4vo+X9dMzFiR48nRhz33ZI5idWvfxRlnelJs7dqhD1cZd2lW0Bf6NzeGlSkKg1MU0QKKdFiWzClLuddOP/quQG1MqhfH0uQ/kjQhtuDGQqnFdzAv1YmBTa11y3gLOGCaPfAoYBTG1XGrFOxz2t9YKetddiQ0XOy7nWKDyYloint7i7C5pqxKFGJNXOYg4oL3nyv+/KPpXBxbKmw6YNQ6iw0LCjV4Ukei/UypMCZhbj0odxeQicdaDt38MMVrZGDjKoYVzVuxZKv8IfhCJHqj/Y+mlGTbm4VD982Zx8UI4rvjRiBVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7fWIcOlJwqjPO5v409UGSDLRQk9Fno554Ecfl1Busw=;
 b=MsgYG/baAFGcxfOYgz/OKOomfeom8k5zebTrPn06GI64+6JNEuee3tm5LgqX6LMTppqEfDubO8RY9HP6+cWIiginxyHKGA+jKFeIVzauRWH6CPrinkazTgH6DdIDskHZ7pE0/EFdfpTTZiQJkGlcfDnUWQIIPGnqhiSOXVfTbOo36fDXzfNumpFExpib4DCmdVMuC8h8IUdW6ZK37EyzYP3Q2jKkUQh4SQbY8aZJgvXjkS1zEhQ3BD+S44tIEOGOJwE0SUVXlqIS3gG8+ARrqvHNYPAVL7UrtRbMyqz5Ls1aoTL86OOL7JNBQW4FHHaDWLOFXhmnAXNjxW4tezJt+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7fWIcOlJwqjPO5v409UGSDLRQk9Fno554Ecfl1Busw=;
 b=NQ4G5ZZBvg5MkT8zyQyJeNU+06ILykXN6WmdHAhlPW2ax3le/yHvmKvtNQixHfPuch1lvJzAdvBq2FcjXf1PGmC9pkFw+3RHYySG3Ttfqn/6h5McVWD8bL/PoAjfwgh1iGh/4Y+0nMTlef0pIBcPAGuZ5pNxNWGnI2vFACd6P1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS2PR10MB7178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 09:45:08 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8699.019; Mon, 5 May 2025
 09:45:08 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Tom Rini <trini@konsulko.com>
Cc: Bruno Leite <brunosampaioleite@gmail.com>,  u-boot@lists.denx.de,
 probinson@gmail.com,  Matthias Brugger <mbrugger@suse.com>,
 clast@prevas.dk,  Bruno Leite <brule@prevas.dk>,  Peter Robinson
 <pbrobinson@gmail.com>
Subject: Re: [PATCH 0/2] Add rpi5 specific defconfig
In-Reply-To: <20250502144031.GT1261075@bill-the-cat> (Tom Rini's message of
 "Fri, 2 May 2025 08:40:31 -0600")
References: <20250502113556.134731-1-brunosampaioleite@gmail.com>
 <20250502144031.GT1261075@bill-the-cat>
Date: Mon, 05 May 2025 11:45:05 +0200
Message-ID: <87frhj5r32.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::28) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS2PR10MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9ed7b5-e91b-4bfc-fc92-08dd8bb98552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E/6mwoE6IPGbNbvNXAom6EstnMv3kVp5wcMU30mta4m8vsF2ob49adgLk+AO?=
 =?us-ascii?Q?KtVncX7tZAAPYOdkojatfr2hdvNOlmmnVDX/T8y93WIV+r4S9kYDORmzYGsi?=
 =?us-ascii?Q?6SLIZ0g9hgMkxMUOFlfZnrFVEwaLlUOuGCYzhF7E/rPXZedz6hZN9MIdKpaH?=
 =?us-ascii?Q?hLI/jQkB/siE/9QVcZPnvvRQrbN5hNJbdSTdXecE/Hw+/lhuTMOR3VkHuSXn?=
 =?us-ascii?Q?6tdUOqyqziOtrZhM4zwAZ/4mETAGKFFin4gHii9cumvUbDW4tM04d8B+zf+Z?=
 =?us-ascii?Q?4Gz/XdCrCawv182yn7Z8qXQSbEVjfFMNFqK0WTwZJgVM8Po9ZbO9EaEtPtKZ?=
 =?us-ascii?Q?lMm34DAj92sY5OgVzetWsjSIlOF79BvWm6K73XV+Z5uKRnitBo0NiObft0FO?=
 =?us-ascii?Q?nJC2/sCO1shelE3I4h+XbbaVU6ra2Uw5B0CoNgpUY3TPMsfVu2bstJG6lkYc?=
 =?us-ascii?Q?as6ElYQB1ja8MamTuUowZ4a+tTs+Aaccccs38QigEkjpxh2Tcq0WB5NgLMT3?=
 =?us-ascii?Q?f+JM2HcgBXMwcdEDl6OIvNm3MTUrT5wVEHk98K77zr2e10WGhGUA3cHhCT9/?=
 =?us-ascii?Q?2MEAQuwCpX/RP2/oLbkrzK2rJ/fTBq6ZlG2+AU7DblTS9Z7sGiwOvLwZ+dFK?=
 =?us-ascii?Q?+QWb/nnu+btDIod6rzmrT6/Yq6is4Z4FzuFr2Q2klS/UR7QzjQQ/8JoHWmvO?=
 =?us-ascii?Q?Lz7A3zRZlYgM3xKohnb1KcufY8kpMvhpP6xp5KXrZyUfl3YfYAx4Xqr00lgl?=
 =?us-ascii?Q?w0uAccPs+8iVvJ8a1bnLcfdYbRCJcvkv+9hsbgWavzbUq2iZm3RS0HpBrZCU?=
 =?us-ascii?Q?T7yMAQ5vhsFHy+SC4AyVD/K2RUqbOtIkDxDHDPOianF1xUTZQwoA0ewl+Q1J?=
 =?us-ascii?Q?JdkP0jboebWUqWsogXV7YQPYkRfWpYHCpoITUnox44wWhzh7zOcBQ8jUhjoo?=
 =?us-ascii?Q?mVONJZOufXpCVlXbSwoGG8m06cH+8KTxDhyVV/ayeT0p4qN81/gvkX45UFm1?=
 =?us-ascii?Q?2s78IrfSVG4rBzfzV4IuT7k8+wSmXx/B+0P4xOjBI+ykEUJTm6a+ObnUc1ZM?=
 =?us-ascii?Q?tXI6aD6yVBO2s7RWPG6LmjRimguvYv4CX2fm/sGV3VB2ncSaK3S/G3dlleme?=
 =?us-ascii?Q?nYrCgyQpj/wHSq4OlYttmIVvOONAODpJhyrm5udaowFySI5vV6ceo2Xwkr7u?=
 =?us-ascii?Q?1s169eNJbiLtlahgCgceVRlo0hOYr1B5Dq0DBAN1ZELZUCt/LuAmJm3kchuQ?=
 =?us-ascii?Q?2MclrB9qP+Z1b/w1sWpPfCrob7dJ0eiZSZ7zJZ4INMC/FjJn8a5/LX1WVI0o?=
 =?us-ascii?Q?QJacf3ksEYK0qIl25N0enqMMGZVH1igmYV8KjuYN+zxZLkglnNmiKx7xz9XM?=
 =?us-ascii?Q?LVmo39m3kL8waEtU5MDHvv2Q79YeCJlM+tkku3ZtKql9s92sFulBrGDzGNBX?=
 =?us-ascii?Q?OL8Hw0KHK7kGpMguncrWdXYK0A8d//expoIuEYa6hVdM5f2cmn4b2Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tfPfSZBbu7Zn41ZPdksP9Mgo9AXXrgggpqDYHzeY1bqN7K4DvbcOSLfjy2lq?=
 =?us-ascii?Q?dy2gQiiapwOsulkCkSspSqNdqgLj2MXeQnJfptFHTsbZ11Xo17ebuWpt6zFo?=
 =?us-ascii?Q?5QpXtJS/CT2o2FUw6TfTn/OSuSzVlKpNUzAh0/V45yIU3sYzimWlWTPDoFbW?=
 =?us-ascii?Q?/BMdluHSj2pZ0dDmxnMe/NQIUB/P71usGrxp+KCtb4lphhWwBvm+JHBtT7nM?=
 =?us-ascii?Q?6OWiUfMOUPrZ20M1pgY2p2nFTSqmaQT1wPma+rlIv0wrw/KMAzpciPYx2aBB?=
 =?us-ascii?Q?Vk3DoHAdVMlzgTW/DoS0rLV4U+nDFjsYAUcuGkoWWi2MbOJHF/2SsH6TpN31?=
 =?us-ascii?Q?kbHtTHwAXHJPKl+X6WGNBPuOSxrg7kdWTU+WfO+ON4RnhOiHozAX6ziNGa/t?=
 =?us-ascii?Q?VSZBle/UMkxC6+//XMEjps8vUZCwwxOnTHuq0gb2XW9QkVOCzExdtspxkn4/?=
 =?us-ascii?Q?0OAq53w/BvWjKUE2s9iRl5sgvQ8kg9H/V50KAlkAx+JmagE1145qcmaTaCJa?=
 =?us-ascii?Q?CMjXIookiDccqzBVJe89Ie5QudaqLAFeLIYSEgGkJsDfJS1UlBr19XFWMNat?=
 =?us-ascii?Q?V82b4y+gDTazmz8PZQ0HJRvKmMQEOwx4kL+baX4G+6R1oYjt2GMi5IXsUSoo?=
 =?us-ascii?Q?mDPoeZdLFTnxOVD50Ui/5s0ET+q17AthlXLR5PVDVB/qdJfXogbKtI9/s5fl?=
 =?us-ascii?Q?K3e2c0ABCJnxAWxandrVyJTUhVIdetcSYaUkZlWoyRkdED9ajlFLkQ+B2Jp5?=
 =?us-ascii?Q?XBVSmBArFZ1KIipM8RxSSbsf1T84BvrVSg3OOviboGj5YVcdcJuKe7FwrDMd?=
 =?us-ascii?Q?fZo6NvwmsbJiF+RDMUXhbOS4Uy09BpuaAfcyWFm2KD8DKTAP2YaMyEJkr3eY?=
 =?us-ascii?Q?CEbnZCUoZgEDWVYJXewz1RfUoI5Av0zt3O8120zQ14cO0FQ6ja0WRV5EvzdK?=
 =?us-ascii?Q?p2O86Ev7hTM6cCkfrnECdf9xzdoFc6vIUlMJ756507ThEGy93R+J0a3MJ3x2?=
 =?us-ascii?Q?rCbmQGPbUxR3Add3xZuzqPcn+owap67NNR2z01c/y/ue9pG89O2PdVFPbjU3?=
 =?us-ascii?Q?16MVMwupZZqeiEStGwJkYp6dW8rncNzERuLjjhoIQZ5Fn4G2iclxFXn4RFmC?=
 =?us-ascii?Q?WaWBiGTgX1imo+mFviWNUHMSxA58OstguTafZ1mcfsu4XhbjMd8o/GGxN4DL?=
 =?us-ascii?Q?fEE6PW1cF1tnqzxT/+phT7pHe3JwRXnPOtsyM6+Ki+q6iq+jusdghKY8p3yz?=
 =?us-ascii?Q?fzFNbf7lXhxkBYdtAx0E7l+DNx+4KKkWAjINFeWnPYTURVbD1tUqIc8q0Dt/?=
 =?us-ascii?Q?LGgNn7n+512jc+sEIg7gHyFjByrAMDMQ1ZhKlYkRvX6SlLYtcp260t8UXw3I?=
 =?us-ascii?Q?Y72cLCvQYD4AtAuYNoATKwo7ETYru2fdy6G79KdIKj/HZ2hixElI3jhc9YBG?=
 =?us-ascii?Q?YkZhZZWityrQ6a17xOcplGTulFh71XjT7tXZ2qhebhnJNvJgFylKH1LZ3u1i?=
 =?us-ascii?Q?8Gpb3UJBNtyye5hWrONEBmGfav3vzaIDhGr1kwwm8GRdGkfgAeGqJe1Odb6y?=
 =?us-ascii?Q?tklM5/VB2IsTSbT8laYA+XT2pHTlf/H8K/IHkstFgzzweTtnhCHZm5mg1jbp?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9ed7b5-e91b-4bfc-fc92-08dd8bb98552
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 09:45:07.9978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Thmvy+/pNSEhS1m2d+W8zLNIbhD6lR1ETbRcYG89STYcGV7gYBNj9WPxLErnW8s+5occ3sGH3ZabkguuTtHvJ8jK+IinxTTK2mCcnyMbQco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7178
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

On Fri, May 02 2025, Tom Rini <trini@konsulko.com> wrote:

> On Fri, May 02, 2025 at 01:34:33PM +0200, Bruno Leite wrote:
>
>> From: Bruno Leite <brule@prevas.dk>
>> 
>> 
>> Currently rpi5 uses a generic rpi_arm64_defconfig file that builds rpi4
>> devicetree. Add a defconfig that is specific to the rpi5 building the
>> now available upstream dts for that board. The defconfig makes use of
>> defconfig including that is now available and only changes the DTS
>> related config.
>> 
>> It is also necessary to add a more specific u-boot.dtsi to rpi5, since
>> due to the ARCH_BCM283X config it will try to build the
>> bcm283x-u-boot.dtsi and break.
>
> My question is, can we not adjust rpi_arm64_defconfig to be generic
> enough and not have a problem on Pi 5 due to the default device tree?

Not really.

What we want is to have CONFIG_DEFAULT_DEVICE_TREE to point at the
rpi5's .dts file, because we really want to build that and not some
"random" dts file that doesn't have anything to do with the hardware. I
know that kinda works for the setups where the .dtb built in U-Boot is
not used for anything, but in our case, we really do want to use the
.dtb from the U-Boot build - we inject various U-Boot specific stuff via
the EXTRA_DTSI mechanism, e.g. public key for kernel verification.

And due to CONFIG_SYS_SOC being bcm283x, and bcm283x-u-boot.dtsi
referencing nodes that simply don't exist when building
bcm2712-rpi-5-b.dts, the build breaks.

Perhaps the real problem is CONFIG_SYS_SOC being bcm283x for rpi5? I
don't really know why rpi4 is both bcm2711 and bcm2835 and what the
difference is, but rpi5 only seems to include a bcm2712.dtsi which does
not include further dtsi files.

If rpi5 has nothing to do with bcm283x, then perhaps a better approach
is to ensure that CONFIG_SYS_SOC is bcm2712 when building for
rpi5. Something like adding a CONFIG_TARGET_RPI_5 choice and adding a
'default "bcm2712" if TARGET_RPI_5' ?

Rasmus
