Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59972C25B74
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 08:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9008888685;
	Sat, 18 May 2024 10:08:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KO95miV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12C9B88687; Sat, 18 May 2024 10:08:47 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3A2088662
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 10:08:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1716019720; x=1716624520; i=xypron.glpk@gmx.de;
 bh=TCxklBO+BYizM/ZZoSZqF3yVoShzVR9QvPNaWp+TSJg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=KO95miV4BcFF003q+m8W6qEF9Cx5ylXDRrQXgVJ3DHdjY0NAA5Rx1nX2teDZtij/
 W8DwuBYSJDEfEENoyxgK35O8D76OdA7RC/TzIYUhVq3MWjLqnfClL49sqXNJP9Nsl
 AwSnafr2NCZ+utAJCbPG4TqdqjrYB7iodlfiQ7ZkfqXBotsUfKp/2XWOkITyJKeuV
 DzDx9vOGj8WFertrbP1rh72cofBqTx/5ar2PE+yoRCsT8t5tCjB50fCLlyF6eWItx
 rXxFjX7okL9YLfCNDu6XYsxqDelGMnctTIFyJQpbYtylikFvaJ7XGiaC08Wd4K78o
 JwB1Ufl+nwLrnbptYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MacSe-1sfw2c3XL8-00c8MK; Sat, 18
 May 2024 10:08:40 +0200
Message-ID: <a4d513ec-2f6e-464b-8167-462e05615571@gmx.de>
Date: Sat, 18 May 2024 10:08:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] doc: Document address spaces used by U-Boot
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20240517-address-spaces-v1-1-93e14c260b73@flygoat.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240517-address-spaces-v1-1-93e14c260b73@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ktpv4iLr1bDVr96Q7U09xVe+oQccR8+Y5frRk5aW84q2HQeAmZ/
 bimCf7M5v5Kio9KcJp8C+u+vDJe+Sp10897D8i3bu0gUairhBHvwxZrI4fr9R+KCR2Sp6PR
 XbQrZ0cHfY+TdoT6JjrAeSSgyZlZhdOgEmBsu8LNTj8hMRYf8R2b5akwWn3k6gUW3TnXT8C
 UTN4DycoPnelUvOwFWcdA==
UI-OutboundReport: notjunk:1;M01:P0:jj6vMqEn0DA=;VOrplm8PGf5JOIgfBA4ujJblc0v
 IgSN+7gMum+1pT8rPRgpj2mKxZWY7MD23JU7CYBSqLMT6Pyf3VXmDktKfjPRJHTjrMiXv9HuV
 QiedhDWbl8vahaUuoXsx7bgzMeKvrLqpv0HKysW8zqaojvqJIK3lqxfYIDRIOB4an3sFGVAki
 Trzamc4nlq0u16XZ62epocbtSKqrCRLnD65Gk0UADB2/WbeYeajOdjArELg6j33BbdxF6teEq
 CWLy6tvp3+uw/iuOabtk8uwogcbqwA8siX+orGGsZGbLWJcbKTF7oeZf4sCohDoCV67eiVjRP
 Ou1Zqkd8yBWwFEO65OhgrfvDx1rraJAIaNgRVtFllC2J6Dg+56MOHeI02Uz3T0FFJpaTZh5uU
 3CbUor1UjkLEvM1tyjouTyJ99uWE/gZ/kEp6vQAoRLnRu0PHHQu8nfmCsp8mzdEx+WrUEDCGs
 f1FwhDHcghA/WS5CvDi4Eql5GVsLgbpxbdLBe/ouHVT0yaq31NDsalGyMLXAqhUIwr6NppSGB
 20niY7aNcVKjDf+VGVSXMJvDKkyr9Hl/97gd2rMks9dRjxqaEdzpTsM7pn7cm/Mwbmw/KMmXI
 K5FasX7oHz2ETGszB8CSoeSFpdBmR81Z3zfNdAWLaXqOsCwn2vo9Mpe/1VLac6WVPYx/7q9AH
 YMryUsCVsM85zZcqG3KyhFGXlPnZKR+QqObV3XQxA8U3ZJv1LxagwKAVoWXCCP0Oi5GSQnnXW
 zesMrorxCwBTrDEIWRHrn3LCQIX/9j08y5g77WCP70kHQFKEjJIAtqMICyR9hf/2uX6cKEUgV
 skMFkng4FY8/KZetkmZTQGOGQfof6R3sA+b9EP6e4TVoo=
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

On 5/17/24 13:45, Jiaxun Yang wrote:
> This serves as a reference for developers on how to handle
> all those address spaces for U-Boot.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Hi all,
>
> I was trying to clear up long standing myth of virtual
> address vs physical adddress mapping on MIPS by having
> a clear division betweem virt and phys adddress everywhere.
>
> In this process I would like to confirm my understanding
> by writing a document and requesting comments from the
> community.
>
> Note that there are some sysmem APIs mentioned in the document
> are not in U-Boot tree, namely ``sysmem_addr_t`` and sysmem_to_phys
> co. I think they can help with annotating address spaces.
>
> Please kindly comment on the design.
>
> Thanks!

Thanks for looking into this.

> ---
>   doc/develop/address_spaces.rst | 73 ++++++++++++++++++++++++++++++++++=
++++++++
>   doc/develop/index.rst          |  1 +
>   2 files changed, 74 insertions(+)
>
> diff --git a/doc/develop/address_spaces.rst b/doc/develop/address_spaces=
.rst
> new file mode 100644
> index 000000000000..05c4a1575f27
> --- /dev/null
> +++ b/doc/develop/address_spaces.rst
> @@ -0,0 +1,73 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. Copyright (c) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
> +
> +Address Spaces
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Introduction
> +------------
> +
> +In U-Boot, we have three address spaces that are used to describe a mem=
ory
> +address:
> +
> +    - ``virt``: virtual address space
> +    - ``phys``: physical address space
> +    - ``sysmem``: system memory address space
> +
> +On most architectures, we maintain a 1:1:1 mapping between all three ad=
dress,
> +with the exception of MIPS and sandbox.
> +
> +There are many API misused in existing code base, this document is to c=
larify
> +the usage of these address spaces and APIs. Hopefully it will help to r=
educe
> +the confusion and porting effort.
> +
> +``virt``
> +--------
> +
> +This is the address space that is directly used by U-Boot to access mem=
ory.
> +Every pointer in U-Boot must in ``virt`` address space. to get a valid =
``virt``

%s/must in/must be in/

%s/to get/To get/

> +address from any other address space, you must use relavant mapping fun=
ctions

%s/relavant/relevant/

> +to ensure it's being tracked. It is recomanded to use ``ulong`` or poin=
ter types
> +to store ``virt`` address.
> +
> +``phys``
> +--------
> +
> +This is the address space that is used to describe the physical memory =
address.
> +It's used to describe the physical memory address of a device, or the p=
hysical
> +memory address of a memory region. Usual places you would see ``phys`` =
address
> +are addresses comes from Device Tree and some memory related APIs. It i=
s
> +recommended to use ``fdt_addr_t`` or ``phys_addr_t`` to store ``phys`` =
address.
> +
> +Following APIs are availble to handle ``phys`` address:

%s/availble/available/

> +
> +    - ``map_physmem()``: Create mapping from physical address to virtua=
l address
> +    - ``unmap_physmem()``: Remove mapping created by ``map_physmem()``
> +    - ``virt_to_phys()``: Find physical address mapping for a virtual a=
ddress
> +    - ``ioremap()``: Create mapping for I/O memory region
> +    - ``iounmap()``: Remove mapping created by ``ioremap()``


These functions do not reprogram the MMU. In fact these functions are
only used to translate between the sandbox' virtual address space and
the host's virtual address space.

Looking at the sandbox code

static inline void *map_sysmem(phys_addr_t paddr, unsigned long len)
{
         return map_physmem(paddr, len, MAP_WRBACK);
}

there seems to be no difference between sysmem and physmem on the sandbox.

> +
> +``sysmem``
> +----------
> +
> +This is the address space that is used by U-Boot internally to describe=
 RAM
> +address. It helps to abstract some architecture differences and provide=
 a

I would say: It is the address space used in the command line interface
and in environment variables.

It should not be used elsewhere. Specifically these sandbox virtual
addresses must not be used in structures that are passed to external
programs like the kernel or EFI binaries.

> +consistent way to managed RAM. Usual places you would see ``sysmem`` ad=
dress

The CLI addresses are used for memory mapped devices, too. So 'managed
RAM' is a bit confusing here.

> +are addresses comes from ``gd->bd->bi_dram[]``, addresses comes from ``=
LMB``
> +addresses being used as memory related config optinos, and addresses be=
ing

%s/optinos/options/

Relating to gd->bd->bi_dram[] or LMB just adds a layer of confusion to
the reader. I would not refer to specific internal structures in this
document.

> +used as arguments to load commands. It is recommended to use ``sysmem_a=
ddr_t``
> +to store ``sysmem`` address.

In most places long is used.

> +
> +It is further used by sandbox to simulate memory, and by MIPS to handle
> +differences between ``virt`` and ``phys`` address spaces.

You have been submitting patches to implement EFI for MIPS.

The EFI specification explicitly requires a 1:1 mapping in the MMU
between. virtual and physical addresses.

In what respect does MIPS not comply to this?

In how far do MIPS addresses shown in the CLI differ from the physical
addresses (i.e. addresses on the electrical address lines)?

CONFIG_ARCH_MAP_SYSMEM seems only to be set on the sandbox and not on
MIPS. We should try to keep it that way.

> +
> +Following APIs are availble to handle ``sysmem`` address:

%s/availble/available/




To summarize. If I have not mistaken anything about MIPS:

All physical devices are identity mapped.

The sandbox uses a virtual address space incorrectly called 'physical'
which is mapped to the virtual address space of the host. This sandbox
virtual address space is used in

* the command line interface
* in the sandbox device-tree
* in environment variable

This allows using the same address values in sandbox tests irrespective
of what part of the host RAM was mapped via mmap().

Best regards

Heinrich

> +
> +    - ``map_sysmem()``: Create mapping from system memory address to vi=
rtual address
> +    - ``unmap_sysmem()``: Remove mapping created by ``map_sysmem()``
> +    - ``map_to_sysmem()``: Find system memory address mapping for a vir=
tual address
> +    - ``sysmem_to_phys()``: Find physical address mapping for a system =
memory address
> +    - ``phys_to_sysmem()``: Find system memory address mapping for a ph=
ysical address
> +    - ``nomap_sysmem()``: Pass through an address unchanged (For sandbo=
x tracking)
> +    - ``nomap_to_sysmem()``: Pass through an address unchanged
> +
> diff --git a/doc/develop/index.rst b/doc/develop/index.rst
> index f82e148b101c..1b8e11cd2f24 100644
> --- a/doc/develop/index.rst
> +++ b/doc/develop/index.rst
> @@ -27,6 +27,7 @@ Implementation
>   .. toctree::
>      :maxdepth: 1
>
> +   address_spaces
>      directories
>      bloblist
>      bootstd
>
> ---
> base-commit: ad7dce5abd49ef3b5c93da5303e15449c8c162b4
> change-id: 20240517-address-spaces-1c3b9c379b13
>
> Best regards,

