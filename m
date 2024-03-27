Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D236C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 16:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDDD088035;
	Wed, 27 Mar 2024 17:39:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="D3RKfin8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01EE7880A3; Wed, 27 Mar 2024 14:32:15 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazolkn190140001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d107::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 841D487971
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 14:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IX5zLGLvlz9YKmq4FzvyVM8Kg3CwNlly1LSgc6cZRhWi6v0+3f0mr3H2/YHvxnf6MUsfL46Iklh6dr0JYLmKYocrqmCOQ9r7gvjxe4rtSV3t/DBb1wKqYkDIQxVueeF0KIXvBqps1McTBmHvrQJxFTHMgNex4g/T+Og72QtngKz7axmPJDl6x2F224yGMODL/UH0a9UBaQUKqTIvgRoOxLpyIAwAdSHkxgh9X/SCXMgGkn1SnUvHOfHbltUwSbF4471rvTCznsKHHRD9uVXfUft9fdGFh9G8c/Zwwku66Y1EkiwDUJo64CiEeLx9DsSlw8I6jjuFtHM17DJUgWhanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJMkOUVlOvtTP0QqQZEp/RIHAguFxd9mnhntYxR1Q0M=;
 b=BkPPLfJNoj/HzVt3OttAkrxioO3icCRh+i1fw57wJbNELfcGlba8YLY9mD2gVL+r7usYNIKDdgfpn8zEOAwrr2IVul02KVwQUEzxzpoxUsC3GuVef6mLkoYwiIcaZ3816ofMYTglP6LGRXkxucu+BSXaBbtGE8tNoGHm/5BKjASfRnbT93sCVjTIh5RZt99+B4O3IeIB/5ehrrRS5++dDNa24vkGcR4z0ynHYMeGjcWC9tbukOC/KdIR3HakVPWFQ94qwfRI14u1VlIR9gbYgy26KoUVnD/+KFGVVOCnSUbG02DhaSlpNaC45A2d4yXiOH+dih+IT+J2IHzXpyfmmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJMkOUVlOvtTP0QqQZEp/RIHAguFxd9mnhntYxR1Q0M=;
 b=D3RKfin8qm/NFG+3Du2GpHhjfXxeloaxKssYZ0Voi5L97WMFbRXXPOc1YCtGlghM8J0Jy76Bk6ZIzSkmJsAGx8piVdPKzDWNYnFhZKPSpIFstgtJcw7Jx5CJFJZsF6QJaRYy7MOti+GVAKqlPVzWS5llYVtJETHMEBmrWzFCka5n6R18/RDtJcmTWgNv12DTUhp+T95DCzCNqpmQogjxVHv9SXo+XXAG+/Cm3Izd24bZ0HLvkMbpHESSm3LTn/nbcR2A2Wmi+ksOepizPDGIAsLdJKGg6yBQtWMxOtAjLJhKwkLFa4KVx9aztogrDXpzRVK/L5Ktm/D5vAZgVGTllQ==
Received: from DM4PR05MB9229.namprd05.prod.outlook.com (2603:10b6:8:88::20) by
 BY3PR05MB8545.namprd05.prod.outlook.com (2603:10b6:a03:3cc::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Wed, 27 Mar 2024 13:32:09 +0000
Received: from DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::148f:6016:501b:93f4]) by DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::148f:6016:501b:93f4%3]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 13:32:08 +0000
Date: Wed, 27 Mar 2024 08:32:04 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 xypron.glpk@gmx.de, cym@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, trini@konsulko.com, eugen.hristev@collabora.com,
 jonas@kwiboo.se
Subject: Re: [PATCH 1/2] rockchip: rk3588: Add support for ATAG parsing
Message-ID: <DM4PR05MB9229EA8B503F50C94DDA5212A5342@DM4PR05MB9229.namprd05.prod.outlook.com>
References: <20240326204944.1572667-1-macroalpha82@gmail.com>
 <20240326204944.1572667-2-macroalpha82@gmail.com>
 <fe9eef97-5814-4d25-8357-60873d565aff@rock-chips.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe9eef97-5814-4d25-8357-60873d565aff@rock-chips.com>
X-TMN: [UFnzNQLtFP3hCCK1EyHbgmuNLYNO/cCT]
X-ClientProxiedBy: SN7PR04CA0211.namprd04.prod.outlook.com
 (2603:10b6:806:127::6) To DM4PR05MB9229.namprd05.prod.outlook.com
 (2603:10b6:8:88::20)
X-Microsoft-Original-Message-ID: <ZgQf1EeO1OflJGzk@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR05MB9229:EE_|BY3PR05MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: d26195c2-9a06-44cb-66b8-08dc4e624ce0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Py1GznsxVAa1Ddsay3X5NntGuM3ax2hqg9MidXMI16ywIg3mjajr/fE3fzR9rC+vrDyr07jpS+e7VI4UCPyzY5zBf83tPI6shyAHqhvVhFET+4kolw/+b8ru3FexO4tAA8lFwgkyMLD2rx+BIsya/Lcfy3sW3tt1IXLtI5yeGL6IdM4wdfQDv4R4VCxP28v3HIFCqCbZsm/kwNfg7rc8DNtjdJopaSz2nRgluwiN5PZs6bKJvcU5HTmsg9Hrdg7ilyuAEEXL0dNRY9edqRZn1rMBoakUGWEP+NuTepvugdl5gQFfR3W0Nhk085dF7tb33Vw/wgHJPtlkqRWWppHlXE+9IeevvrUUbSkJc4oBFArcUCfyLTlM4vVcIamKgBpTkY8dI/KOtbuC5KgfJ2IKsHX5+l5aDCt1fBeNmuPwv1rPiOtZaiS+IBDKwIHDMMnJnKtWuqZmReV8PE3M2v9YUFWB/THQAFVe736eIsDpeAqR1lBip2vaarwvqde9mKkS4DPnrn+ynCj2K9lP3O5pCVBh/ADNp6+U6pwxJ9+eszwrjaJvcQpDL11HSHa6roR
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?byACiIr+iAxvWUOq1gRmfXRFhvtfGMXfLGwlllEbUtM0NK8Wk76FNK6sXC?=
 =?iso-8859-1?Q?7WJT6M63mvie8JYNbpSwMoEX/bGG7EP78RE1nz8BZt+5fKAB5crr4vLnxV?=
 =?iso-8859-1?Q?JMArQ4mMDk7MQcDMGltMra9YRdoIXyRY2JIfHPWfICuqkL6wd/0y8FVF5n?=
 =?iso-8859-1?Q?R2D85BaAaJKrMIA3fwK2rlfuIuJB4rD2+uLXfXNfcyGezHtGAp/tGim95z?=
 =?iso-8859-1?Q?Ss+BoCFMRyntGjOy5BqWapkS6YDMxflBItsEyoxELJeGKpIr6596g3phID?=
 =?iso-8859-1?Q?Z2QApJSrB1RDYlWEvjsrKSafSzYmOFFDSPdbDebtbaAye/796G0/0ld14T?=
 =?iso-8859-1?Q?FqSg8/Xtm9G+5QygG9LzIGusGPbl4sbLj0PmnxewZKZHnTTFrT3OUZT4PH?=
 =?iso-8859-1?Q?NrQcaIDQEDCQemSZ5LP4pn795toJnnwQiHgYxcNFPln+EBDtiE7nHqqlwv?=
 =?iso-8859-1?Q?N2s632q+lldcqi7upVOgQsg7MbSA9tK0EbC24fOGA2h4Ox034ROWlVzb82?=
 =?iso-8859-1?Q?VK665mQqJkLleHpKdK2PBSY1fzH85n3EAJHTTKwxdy4Xlp7ywRDXDwXq4v?=
 =?iso-8859-1?Q?8MfMYLZ0uNhkLmnMTbfTJPEJ/u2CyGVkBKWh7Vh/Plc0+e62XbiFK1CsD8?=
 =?iso-8859-1?Q?jjN9IfByC5MGI6TB/9RB+2Hgy9WKAoE++2YrvyYOxpVve9rw9gEJWRQ7NJ?=
 =?iso-8859-1?Q?HKMv+WJHInUjlNMC52oyH5576/YLJJsjVkkW90iP7rrrPiqWJWbIMLrWTv?=
 =?iso-8859-1?Q?ApgWSC6fGi74bl4jvMIt/f9oOH+3jD7ylO1DlDfxoQIGtz4ZMIEtOpZL4t?=
 =?iso-8859-1?Q?slDNhNgYXCmPYfvhxjlLjdH8HG9z0r6IMOh1GKyKpDofdmmq7bSQbtKn4H?=
 =?iso-8859-1?Q?HyyQefqGLXziAkqM2qKu/SZwM0x2O1Jkjef1hdZ3cNOXi/gW3QYmFGIC5R?=
 =?iso-8859-1?Q?anmXfzTTaWmJCutz98AOYVsg2itildTNiUoIjwYUfn+qikFLxtR4t3ICM9?=
 =?iso-8859-1?Q?Ir4Xd+vfawajhlaImwir9Su8I9700sXTCJxyVL3/d7yc9cEeO2oHc6ynpd?=
 =?iso-8859-1?Q?tEZWqhQovDqCWfHOXYhxV/HhXy3xdLe02iiA+y/hetm54eRoPzgHDQ/TJK?=
 =?iso-8859-1?Q?RvfzIRaiULYS/IvSpWwmnJNITxJPyXWkt9PymrmBde4bfP68Ov0nhKJDvE?=
 =?iso-8859-1?Q?8QLJIWq8sylQe/bRUf0a+ynj2jBOrHOAbFrYuWE4CIEfhIyP/S4jn5y6uf?=
 =?iso-8859-1?Q?DHL4E+pZIzfz4u96DEUmkKqmyeT25RRz4/PCGwTWw=3D?=
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d26195c2-9a06-44cb-66b8-08dc4e624ce0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR05MB9229.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 13:32:08.7433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8545
X-Mailman-Approved-At: Wed, 27 Mar 2024 17:39:52 +0100
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

On Wed, Mar 27, 2024 at 06:32:06PM +0800, Kever Yang wrote:
> Hi Chris,
> 
>     The ATAGS is used for passing parameter from bootloader to kernel at
> first, which has been replaced by DTB now for ARM platform.
> 
>     And Rockchip using ATAGs for passing parameter like dram memory
> size/board uart in different boot process like DRAM init binary/ TPL/SPL to
> U-Boot since 2018.
> 
>     And almost at the same time, Simon add bloblist for mainline U-Boot
> which for similar purpose.
> 
>     So I'm not sure if this ATAGS should be accept in mainline U-Boot or
> not, even for rockchip platform only seems some kind of regression for this
> feature support.
> 
> 
> Hi Simon and Tom,
> 
>      Could you help to give some suggestion for this?
> 

I really meant to do this as an "RFC", so I apologize in advance for
possibly causing more work in treating this as a full-fledged patch.

The problem I'm trying to solve is that I've got 2 boards, a Rock 5B
as well as an Indiedroid Nova both with 16GB of RAM. I noticed that
without the memory holes the Rock 5B defined in my Indiedroid it would
also fail to boot. I've got 2 other boards as well with less than 16GB
of RAM which seem to work fine without any holes (a 4GB Indiedroid Nova
prototype and a GameForce Ace with 12GB of RAM).

The "RFC" part for which I'm really requesting guidance/comments is
a question of "is it appropriate to use ATAGS" to get the RAM banks
on this SoC, or is there a different way we should be doing it? If
we can/should use the ATAGS, then I guess this can be pared down and
refactored to just be RK3588 specific. If so, we can possibly add
something like this to the RK3588 SoC specific code, guard it with
an #ifdef ROCKCHIP_TPL to only call it when using the Rockchip
specific RAM init (in the hopes that maybe one day we get our own
RAM init), and then replace existing code for boards like the Rock 5B
so that it no longer reserves these memory banks.

Thank you,
Chris.

> 
> Thanks,
> - Kever
> On 2024/3/27 04:49, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add support for parsing the ATAGs created by the Rockchip binary
> > RAM init. This ATAG parsing code was taken from the Rockchip BSP
> > U-Boot source and tested only on parsing the RAM specific ATAGs
> > for the RK3588.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >   arch/arm/include/asm/arch-rockchip/atags.h | 222 +++++++++++++++++++++
> >   arch/arm/mach-rockchip/Makefile            |   1 +
> >   arch/arm/mach-rockchip/atags.c             |  99 +++++++++
> >   3 files changed, 322 insertions(+)
> >   create mode 100644 arch/arm/include/asm/arch-rockchip/atags.h
> >   create mode 100644 arch/arm/mach-rockchip/atags.c
> > 
> > diff --git a/arch/arm/include/asm/arch-rockchip/atags.h b/arch/arm/include/asm/arch-rockchip/atags.h
> > new file mode 100644
> > index 0000000000..9bae66d7f8
> > --- /dev/null
> > +++ b/arch/arm/include/asm/arch-rockchip/atags.h
> > @@ -0,0 +1,222 @@
> > +/* SPDX-License-Identifier:     GPL-2.0+ */
> > +/*
> > + * (C) Copyright 2018 Rockchip Electronics Co., Ltd
> > + *
> > + */
> > +
> > +#ifndef __RK_ATAGS_H_
> > +#define __RK_ATAGS_H_
> > +
> > +/* Tag magic */
> > +#define ATAG_CORE		0x54410001
> > +#define ATAG_NONE		0x00000000
> > +
> > +#define ATAG_SERIAL		0x54410050
> > +#define ATAG_BOOTDEV		0x54410051
> > +#define ATAG_DDR_MEM		0x54410052
> > +#define ATAG_TOS_MEM		0x54410053
> > +#define ATAG_RAM_PARTITION	0x54410054
> > +#define ATAG_ATF_MEM		0x54410055
> > +#define ATAG_PUB_KEY		0x54410056
> > +#define ATAG_SOC_INFO		0x54410057
> > +#define ATAG_BOOT1_PARAM	0x54410058
> > +#define ATAG_PSTORE		0x54410059
> > +#define ATAG_FWVER		0x5441005a
> > +#define ATAG_MAX		0x544100ff
> > +
> > +/* Tag size and offset */
> > +#define ATAGS_SIZE		(0x2000)	/* 8K */
> > +#define ATAGS_OFFSET		(0x200000 - ATAGS_SIZE)/* [2M-8K, 2M] */
> > +#define ATAGS_PHYS_BASE		(CFG_SYS_SDRAM_BASE + ATAGS_OFFSET)
> > +
> > +/* tag_fwver.ver[fwid][] */
> > +#define FWVER_LEN		36
> > +
> > +enum fwid {
> > +	FW_DDR,
> > +	FW_SPL,
> > +	FW_ATF,
> > +	FW_TEE,
> > +	FW_MAX,
> > +};
> > +
> > +struct tag_serial {
> > +	u32 version;
> > +	u32 enable;
> > +	u64 addr;
> > +	u32 baudrate;
> > +	u32 m_mode;
> > +	u32 id;
> > +	u32 reserved[2];
> > +	u32 hash;
> > +} __packed;
> > +
> > +struct tag_bootdev {
> > +	u32 version;
> > +	u32 devtype;
> > +	u32 devnum;
> > +	u32 mode;
> > +	u32 sdupdate;
> > +	u32 reserved[6];
> > +	u32 hash;
> > +} __packed;
> > +
> > +struct tag_ddr_mem {
> > +	u32 count;
> > +	u32 version;
> > +	u64 bank[20];
> > +	u32 flags;
> > +	u32 data[2];
> > +	u32 hash;
> > +} __packed;
> > +
> > +struct tag_tos_mem {
> > +	u32 version;
> > +	struct {
> > +		char name[8];
> > +		u64 phy_addr;
> > +		u32 size;
> > +		u32 flags;
> > +	} tee_mem;
> > +
> > +	struct {
> > +		char name[8];
> > +		u64 phy_addr;
> > +		u32 size;
> > +		u32 flags;
> > +	} drm_mem;
> > +
> > +	u64 reserved[7];
> > +	u32 reserved1;
> > +	u32 hash;
> > +} __packed;
> > +
> > +struct tag_atf_mem {
> > +	u32 version;
> > +	u64 phy_addr;
> > +	u32 size;
> > +	u32 flags;
> > +	u32 reserved[2];
> > +	u32 hash;
> > +} __packed;
> > +
> > +struct tag_pub_key {
> > +	u32 version;
> > +	u32 len;
> > +	u8  data[768];	/* u32 rsa_n[64], rsa_e[64], rsa_c[64] */
> > +	u32 flag;
> > +	u32 reserved[5];
> > +	u32 hash;
> > +} __packed;
> > +
> > +struct tag_ram_partition {
> > +	u32 version;
> > +	u32 count;
> > +	u32 reserved[4];
> > +
> > +	struct {
> > +		char name[16];
> > +		u64 start;
> > +		u64 size;
> > +	} part[6];
> > +
> > +	u32 reserved1[3];
> > +	u32 hash;
> > +} __packed;
> > +
> > +struct tag_soc_info {
> > +	u32 version;
> > +	u32 name;	/* Hex: 0x3288, 0x3399... */
> > +	u32 flags;
> > +	u32 reserved[6];
> > +	u32 hash;
> > +} __packed;
> > +
> > +struct tag_boot1p {
> > +	u32 version;
> > +	u32 param[8];
> > +	u32 reserved[4];
> > +	u32 hash;
> > +} __packed;
> > +
> > +struct tag_pstore {
> > +	u32 version;
> > +	struct {
> > +		u32 addr;
> > +		u32 size;
> > +	} buf[16];
> > +	u32 hash;
> > +} __packed;
> > +
> > +struct tag_fwver {
> > +	u32 version;
> > +	char ver[8][FWVER_LEN];
> > +	u32 hash;
> > +} __packed;
> > +
> > +struct tag_core {
> > +	u32 flags;
> > +	u32 pagesize;
> > +	u32 rootdev;
> > +} __packed;
> > +
> > +struct tag_header {
> > +	u32 size;	/* bytes = size * 4 */
> > +	u32 magic;
> > +} __packed;
> > +
> > +/* Must be 4 bytes align */
> > +struct tag {
> > +	struct tag_header hdr;
> > +	union {
> > +		struct tag_core		core;
> > +		struct tag_serial	serial;
> > +		struct tag_bootdev	bootdev;
> > +		struct tag_ddr_mem	ddr_mem;
> > +		struct tag_tos_mem	tos_mem;
> > +		struct tag_ram_partition ram_part;
> > +		struct tag_atf_mem	atf_mem;
> > +		struct tag_pub_key	pub_key;
> > +		struct tag_soc_info	soc;
> > +		struct tag_boot1p	boot1p;
> > +		struct tag_pstore	pstore;
> > +		struct tag_fwver	fwver;
> > +	} u;
> > +} __aligned(4);
> > +
> > +#define tag_next(t)	((struct tag *)((u32 *)(t) + (t)->hdr.size))
> > +#define tag_size(type)	((sizeof(struct tag_header) + sizeof(struct type)) >> 2)
> > +#define for_each_tag(t, base)		\
> > +	for (t = base; t->hdr.size; t = tag_next(t))
> > +
> > +/*
> > + * atags_get_tag - get tag by tag magic
> > + *
> > + * @magic: tag magic, i.e. ATAG_SERIAL, ATAG_BOOTDEV, ...
> > + *
> > + * return: NULL on failed, otherwise return the tag that we want.
> > + */
> > +struct tag *atags_get_tag(u32 magic);
> > +
> > +/*
> > + * atags_is_available - check if atags is available, used for second or
> > + *			later pre-loaders.
> > + *
> > + * return: 0 is not available, otherwise available.
> > + */
> > +int atags_is_available(void);
> > +
> > +/*
> > + * atags_overflow - check if atags is overflow
> > + *
> > + * return: 0 if not overflow, otherwise overflow.
> > + */
> > +int atags_overflow(struct tag *t);
> > +
> > +/*
> > + * atags_bad_magic - check if atags magic is invalid.
> > + *
> > + * return: 1 if invalid, otherwise valid.
> > + */
> > +int atags_bad_magic(u32 magic);
> > +#endif
> > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> > index 1dc92066bb..4165cbe99f 100644
> > --- a/arch/arm/mach-rockchip/Makefile
> > +++ b/arch/arm/mach-rockchip/Makefile
> > @@ -28,6 +28,7 @@ endif
> >   ifeq ($(CONFIG_TPL_BUILD),)
> >   obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
> > +obj-$(CONFIG_ROCKCHIP_RK3588) += atags.o
> >   endif
> >   obj-$(CONFIG_$(SPL_TPL_)RAM) += sdram.o
> > diff --git a/arch/arm/mach-rockchip/atags.c b/arch/arm/mach-rockchip/atags.c
> > new file mode 100644
> > index 0000000000..9daa2f2fc0
> > --- /dev/null
> > +++ b/arch/arm/mach-rockchip/atags.c
> > @@ -0,0 +1,99 @@
> > +// SPDX-License-Identifier:     GPL-2.0+
> > +/*
> > + * (C) Copyright 2018 Rockchip Electronics Co., Ltd.
> > + *
> > + */
> > +
> > +#include <config.h>
> > +#include <asm/io.h>
> > +#include <asm/arch-rockchip/atags.h>
> > +
> > +#define HASH_LEN	sizeof(u32)
> > +
> > +static u32 js_hash(void *buf, u32 len)
> > +{
> > +	u32 i, hash = 0x47C6A7E6;
> > +	char *data = buf;
> > +
> > +	if (!buf || !len)
> > +		return hash;
> > +
> > +	for (i = 0; i < len; i++)
> > +		hash ^= ((hash << 5) + data[i] + (hash >> 2));
> > +
> > +	return hash;
> > +}
> > +
> > +int atags_bad_magic(u32 magic)
> > +{
> > +	bool bad;
> > +
> > +	bad = ((magic != ATAG_CORE) &&
> > +	       (magic != ATAG_NONE) &&
> > +	       (magic < ATAG_SERIAL || magic > ATAG_MAX));
> > +	if (bad)
> > +		printf("Magic(%x) is not support\n", magic);
> > +
> > +	return bad;
> > +}
> > +
> > +static int atags_size_overflow(struct tag *t, u32 tag_size)
> > +{
> > +	return (unsigned long)t + (tag_size << 2) - ATAGS_PHYS_BASE > ATAGS_SIZE;
> > +}
> > +
> > +int atags_overflow(struct tag *t)
> > +{
> > +	bool overflow;
> > +
> > +	overflow = atags_size_overflow(t, 0) ||
> > +		   atags_size_overflow(t, t->hdr.size);
> > +	if (overflow)
> > +		printf("Tag is overflow\n");
> > +
> > +	return overflow;
> > +}
> > +
> > +int atags_is_available(void)
> > +{
> > +	struct tag *t = (struct tag *)ATAGS_PHYS_BASE;
> > +
> > +	return (t->hdr.magic == ATAG_CORE);
> > +}
> > +
> > +struct tag *atags_get_tag(u32 magic)
> > +{
> > +	u32 *hash, calc_hash, size;
> > +	struct tag *t;
> > +
> > +	if (!atags_is_available())
> > +		return NULL;
> > +
> > +	for_each_tag(t, (struct tag *)ATAGS_PHYS_BASE) {
> > +		if (atags_overflow(t))
> > +			return NULL;
> > +
> > +		if (atags_bad_magic(t->hdr.magic))
> > +			return NULL;
> > +
> > +		if (t->hdr.magic != magic)
> > +			continue;
> > +
> > +		size = t->hdr.size;
> > +		hash = (u32 *)((ulong)t + (size << 2) - HASH_LEN);
> > +		if (!*hash) {
> > +			debug("No hash, magic(%x)\n", magic);
> > +			return t;
> > +		}
> > +		calc_hash = js_hash(t, (size << 2) - HASH_LEN);
> > +		if (calc_hash == *hash) {
> > +			debug("Hash okay, magic(%x)\n", magic);
> > +			return t;
> > +		}
> > +		debug("Hash bad, magic(%x), orgHash=%x, nowHash=%x\n",
> > +		      magic, *hash, calc_hash);
> > +		return NULL;
> > +	}
> > +
> > +	return NULL;
> > +}
