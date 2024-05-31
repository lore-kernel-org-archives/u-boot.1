Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEEDC25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 09:30:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DD20883FA;
	Fri, 31 May 2024 11:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nu5AM9J3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8C4C8856E; Fri, 31 May 2024 11:30:44 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3122F883A0
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 11:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c034676e02so1334226a91.1
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 02:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717147840; x=1717752640; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mdLJlzQaPeiNh0sM3/+kvNBJnozajqkGyT/tU1JJBOM=;
 b=nu5AM9J3dXLB2A2Bo3bOZdgCIGXqN40ESj1J9GSKffiUxbuHbyhfbsGCkvtawFGdPi
 s+ci52hZt/RzePJ0V+NCRuJpdJzbBIEmqM6tL/nFnPBYj4Lf9bOR48FgxyViG9/KHK/y
 NRpHbsv564Dyg6PiS7zBXfFZZe4TjDwjCufbfoJPrGJJj3A9o7e/E8SkESmR4e01eA7R
 8EePSkJAI0Ds0epVu1bioOrzCdUOsITuyQ/VlOPIR9QtausxjqSK+XutP257BDgfct/+
 nH0EczNbPhqPabAgTHL5EXs5CsI7xLyPobEtiABupiocCIb5NDcvoEgm6O9tRZviaXne
 CpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717147840; x=1717752640;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mdLJlzQaPeiNh0sM3/+kvNBJnozajqkGyT/tU1JJBOM=;
 b=Y/XJl2yh9AXiDn6i+BneCspnonIGj6QyWvhvfpFuUqgfa6qEVifC6XztOwFehVq6h9
 amMQGAC7PBO4GlXcRMRHPciRTTQF+yInamYY2UQIj2FMHAR/ostRkxtdDUvArmb54Y+f
 0O3jpKxrtjK+OTPeHOiSLXFmsplrZFf94Kk9ji90Nk8XimeALvXXovhjquScLwX5mmIQ
 k/nGlveT5yU9+ZIqt92e7d3mO3m2MhtNHwG4JJ0lJBZsVaCeHCdKuQmX0ZZYTz1rH5Zg
 9FJYty9QZQCHJ9Fby+hROZC0LvG+8K8Q3zu1yLL9gnQSTjEQifmPAbba9SAyoDv/GzAT
 tsdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDX0wmcy7aJputUDXRCb3QiGPVD//L/KlQIor5KWdNEG344mawAZ8afmu8+b2lWxCtpsGTQfY1lPI6szECX+14BH61vg==
X-Gm-Message-State: AOJu0YwvyK25QbzsWzF0r4rjW3+uqmCuKPGZF59PL8TY3t3cTXkGCVhl
 HttIGVwx6sry/wj89m7niZZo99kQg6VRgZv6G1D43hMnJQk60n32x9XZhqOfIrMPRoyEUjQHOG8
 RYmStdOK+3ZAbxo5aUSgPzwJrNgbhtNaHQ8w97g==
X-Google-Smtp-Source: AGHT+IFbG0DMuClaJl5MUDozIaQMTC07N23G7MVv8ZHCkUA5S3t7xelX88TZcfVvbMHEYX0oCxO8Qiv2rgu2ijb/07U=
X-Received: by 2002:a17:90a:f6d7:b0:2b3:d512:d487 with SMTP id
 98e67ed59e1d1-2c1dc5ccd70mr1224045a91.39.1717147840533; Fri, 31 May 2024
 02:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240509164123.1753050-1-j-humphreys@ti.com>
 <20240509164123.1753050-16-j-humphreys@ti.com>
 <Zk--WFQJC-wi5zE5@hera> <86bk4vcjab.fsf@udb0321960.dhcp.ti.com>
 <CAC_iWjLMERkDYF_-Eu5mg13q_PjjfjcwgsTGxJ_SB6h6PdzXEA@mail.gmail.com>
 <86ikyufwq3.fsf@udb0321960.dhcp.ti.com>
In-Reply-To: <86ikyufwq3.fsf@udb0321960.dhcp.ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 31 May 2024 12:30:03 +0300
Message-ID: <CAC_iWjKRezCL1cXfB5Zy233XvP59js_MxcogaqcBCUV5gpQcvQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/19] board: am62px: Define capsule update firmware
 info
To: Jon Humphreys <j-humphreys@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Simon Glass <sjg@chromium.org>, Nikhil M Jain <n-jain1@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 31 May 2024 at 07:10, Jon Humphreys <j-humphreys@ti.com> wrote:
>
> Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:
>
> > Hi Jon,
> >
> > On Fri, 24 May 2024 at 18:38, Jon Humphreys <j-humphreys@ti.com> wrote:
> >>
> >> Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:
> >>
> >> > Hi Jonathan
> >> >
> >> > Thanks for working on this
> >> >
> >> > On Thu, May 09, 2024 at 11:41:19AM -0500, Jonathan Humphreys wrote:
> >> >> Define the firmware components updatable via EFI capsule update, including
> >> >> defining capsule GUIDs for the various firmware components for the AM62px
> >> >> SK.
> >> >>
> >> >> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> >> >> ---
> >> >>  board/ti/am62px/evm.c        | 32 ++++++++++++++++++++++++++++++++
> >> >>  include/configs/am62px_evm.h | 24 ++++++++++++++++++++++++
> >> >>  2 files changed, 56 insertions(+)
> >> >>
> >> >> diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
> >> >> index 97a95ce8cc2..6d0f66e5dc0 100644
> >> >> --- a/board/ti/am62px/evm.c
> >> >> +++ b/board/ti/am62px/evm.c
> >> >> @@ -6,6 +6,7 @@
> >> >>   *
> >> >>   */
> >> >>
> >> >> +#include <efi_loader.h>
> >> >>  #include <asm/arch/hardware.h>
> >> >>  #include <asm/io.h>
> >> >>  #include <dm/uclass.h>
> >> >> @@ -13,6 +14,37 @@
> >> >>  #include <fdt_support.h>
> >> >>  #include <spl.h>
> >> >>
> >> >> +struct efi_fw_image fw_images[] = {
> >> >
> >> > It's better if we add an
> >> > #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
> >> > for both of the structs that follow (and it applies to all your patches)
> >> >
> >>
> >> Ilias, thanks for the reviews.
> >>
> >> I had this protected in #if's in an earlier patch set, as you suggest here.
> >> However, in those reviews, Roger recommended that we don't do that and put
> >> conditions around the use of it in set_dfu_alt_info().
> >>
> >
> > Hmm but the function prototype itself is on an ifdef. If you want to
> > remove the ifdef you got to do it everywhere
> >
>
> Are you referring to set_dfu_alt_info() which is guarded by
> CONFIG_SET_DFU_ALT_INFO?

Yes

>
> If so, that is separate but I can add a CONFIG_SET_DFU_ALT_INFO guard
> around the definition, for now. But IMO it is a bit of a mess because it's
> use and board specific defs are guarded by CONFIG_SET_DFU_ALT_INFO but the
> weak/default definition is guarded by CONFIG_EFI_CAPSULE_FIRMWARE, which
> causes problems because the configs are not always the same for all builds.

Indeed

> I was wanting to fix that too so I might do that as a separate patch and
> make that patch a prerequisite for this series, which then allows me to
> remove the definitions of set_dfu_alt_info() in this series.
>

We can clean it up later sure, but for now put it under an IS_ENABLED
so we have the same mess everywhere :)

Thanks
/Ilias
> Jon
>
> > Thanks
> > /Ilias
> >
> >> https://lore.kernel.org/all/b19f02e0-a80a-46d6-8296-5d516577766a@kernel.org/
> >>
> >> I assume the reasoning is to reduce #if's in the code and rely on the
> >> compiler to be smart enough to remove dead data. (Roger, speak up if I
> >> misrepresent you.)
> >>
> >> I'm ok to do either way.  What is the preferred way in U-Boot?
> >>
> >> Thanks
> >> Jon
> >>
> >> >> +    {
> >> >> +            .image_type_id = AM62PX_SK_TIBOOT3_IMAGE_GUID,
> >> >> +            .fw_name = u"AM62PX_SK_TIBOOT3",
> >> >> +            .image_index = 1,
> >> >> +    },
> >> >> +    {
> >> >> +            .image_type_id = AM62PX_SK_SPL_IMAGE_GUID,
> >> >> +            .fw_name = u"AM62PX_SK_SPL",
> >> >> +            .image_index = 2,
> >> >> +    },
> >> >> +    {
> >> >> +            .image_type_id = AM62PX_SK_UBOOT_IMAGE_GUID,
> >> >> +            .fw_name = u"AM62PX_SK_UBOOT",
> >> >> +            .image_index = 3,
> >> >> +    }
> >> >> +};
> >> >> +
> >> >> +struct efi_capsule_update_info update_info = {
> >> >> +    .dfu_string = "sf 0:0=tiboot3.bin raw 0 80000;"
> >> >> +    "tispl.bin raw 80000 200000;u-boot.img raw 280000 400000",
> >> >> +    .num_images = ARRAY_SIZE(fw_images),
> >> >> +    .images = fw_images,
> >> >> +};
> >> >
> >> > I haven't worked on any TI platforms lately so I cant say much about the
> >> > naming and the flash regions. The definition seems correct
> >> >
> >> >
> >> >> +
> >> >> +void set_dfu_alt_info(char *interface, char *devstr)
> >> >> +{
> >> >> +    if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> >> >> +            env_set("dfu_alt_info", update_info.dfu_string);
> >> >> +}
> >> >
> >> > There's a CONFIG_SET_DFU_ALT_INFO symbol. This better if we add a check here
> >> > as well
> >> >
> >> >> +
> >> >>  int board_init(void)
> >> >>  {
> >> >>      return 0;
> >> >> diff --git a/include/configs/am62px_evm.h b/include/configs/am62px_evm.h
> >> >> index 06b12860e21..57a1ba9dc3c 100644
> >> >> --- a/include/configs/am62px_evm.h
> >> >> +++ b/include/configs/am62px_evm.h
> >> >> @@ -8,6 +8,30 @@
> >> >>  #ifndef __CONFIG_AM62PX_EVM_H
> >> >>  #define __CONFIG_AM62PX_EVM_H
> >> >>
> >> > [...]
> >> >
> >> > Regards
> >> > /Ilias
