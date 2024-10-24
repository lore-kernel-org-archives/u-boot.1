Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1360CE8E7E
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 14:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 737B688DFE;
	Thu, 24 Oct 2024 16:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VoR75eKk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A90788F71; Thu, 24 Oct 2024 16:20:10 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E1CA88FB7
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 16:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20c693b68f5so9465805ad.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 07:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729779592; x=1730384392; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7eRy4DteqdEjuzdCGIGEzdvwmgmW4MQyUNTFAY6F4Ko=;
 b=VoR75eKkeg7fWkswM3tNdseVanZOm8ywVu1FxJdYE6bZ8+V2BYot9q2llLL7taE+pn
 iwFF0zREid+rFl33zE5QtgVhqxYryHX7HnU+28Si8Gv55BlSBUBY/NgHaihu15eTwjQG
 0M1DczJbaOVysj2nDgIqS4b3Uln+jQUnVUADMwif4X+JPQRv9v+ZhBIT7xxyvpmzEbUe
 h4cLmm8JflHZR8X6bGhEbZUVXjOwCJlS7AwBDTIs6Tb8OiijMpNUe8pmxkXw/A+8k8IN
 JEIrukmUR0tSNA179r//Okqg21I3isUDjUVX3dRcXBlKcoAxWli+hIXdU7IvpDYjfg1Y
 ncTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729779592; x=1730384392;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7eRy4DteqdEjuzdCGIGEzdvwmgmW4MQyUNTFAY6F4Ko=;
 b=ktrwuqkaVc9H+wKR+3Qc6u+H4kBQ9vLEPiF6cixzJZahOTWlIaXTuo/TRXQehEcQIg
 psSiGgumYUeVCs/CEyW8hFSFyCnigc96aZ0bEY9qsq2lswMlIFsvN9lZd5X9hkOrtVWg
 1pYfm3SNrjAVYeg7wVOCP+4RJ4wrCBMLGg917R85dC2H3kxjGOXgcutJvAEi8cduHzze
 T238MxDx7YoBrBa2LnALKAokJ013kIOK51L6QZokgMjauNqXbBj986Y8dFpARaHvyHYI
 1K46UjxuJQdkjyERo8C0H45oU8Kzc1K7dJx5bR4QJyiJvg7L/4sMZbnCyTPx9C5LlWiy
 Nr2w==
X-Gm-Message-State: AOJu0YwEOTduMay23LgLXOQHskbS4L4q3+Icjta12GVYm8vl/iotFaxy
 AtSnrSz5X1mQ6jXIF/Vk5+P3riQZOFAzC6CIbD6gpPsQNKCLszoh0trFcfu14jRYCWMiUh0F+On
 /yoz64rFMJwRWrcNtyAc1+IBISgWE4zHb+4Q3FQ==
X-Google-Smtp-Source: AGHT+IFXCPp2uETYvGGSBgrz57qPlk9DW+kzvtthBjpPUUh5d6JlMuXBHrSK6htRPFZVePN2gUcbLMdHHTcQIgJPP00=
X-Received: by 2002:a17:902:d48f:b0:20c:9821:69af with SMTP id
 d9443c01a7336-20fa9eb9466mr82982955ad.45.1729779592314; Thu, 24 Oct 2024
 07:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20241022200543.116343-1-raymond.mao@linaro.org>
 <20241024002255.GP4959@bill-the-cat>
 <CAEfUkUJYcBSET22QJAKzCd+q4GYXe6H9Xshpm_RiET57uzsE3Q@mail.gmail.com>
 <20241024141010.GQ4959@bill-the-cat>
In-Reply-To: <20241024141010.GQ4959@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 24 Oct 2024 10:19:41 -0400
Message-ID: <CAEfUkU+2yxeH2+27We-_qEb1jY5_59oPsK-6tCcyqMwQV+1-UQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] SMBIOS improvements
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, iwamatsu@nigauri.org, 
 marek.vasut+renesas@mailbox.org, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Wan Yee Lau <wan.yee.lau@intel.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, Jonas Karlman <jonas@kwiboo.se>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,

On Thu, 24 Oct 2024 at 10:10, Tom Rini <trini@konsulko.com> wrote:

> On Thu, Oct 24, 2024 at 09:35:36AM -0400, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Wed, 23 Oct 2024 at 20:23, Tom Rini <trini@konsulko.com> wrote:
> >
> > > On Tue, Oct 22, 2024 at 01:05:21PM -0700, Raymond Mao wrote:
> > >
> > > > Motivations for changes:
> > > > Current SMBIOS library and command-line tool is not fully matching
> with
> > > > the requirements:
> > > > 1. Missing support for other mandatory types (#7, #9, #16, #17, #19).
> > > > 2. Only a few platforms support SMBIOS node from the device tree.
> > > > 3. Values of some fields are hardcoded in the library other than
> fetching
> > > >    from the device hardware.
> > > > 4. Embedded data with dynamic length is not supported (E.g. Contained
> > > >    Object Handles in Type #2 and Contained Elements in Type #3)
> > > >
> > > > Changes:
> > > > 1. Refactor the SMBIOS library and command-line tool to better align
> with
> > > >    the SMBIOS spec.
> > > > 2. Create an arch-specific driver for all aarch64-based platforms to
> > > fetch
> > > >    SMBIOS private data from the device hardware (processor and
> cache).
> > > > 3. Create a sysinfo driver to poppulate platform SMBIOS private data.
> > > > 4. Add generic SMBIOS DTS file for arm64 platforms for those common
> > > strings
> > > >    and values which cannot be retrieved from the system registers.
> > > >    Vendors can create their own SMBIOS node using this as an example.
> > > >    For those boards without SMBIOS nodes, this DTS file can be
> included
> > > to
> > > >    have a generic SMBIOS information of the system.
> > > > 5. Add support for Type #7 (Cache Information) and link its handles
> to
> > > >    Type #4.
> > > >
> > > > Once this patch is acceptted, subsequent patch sets will add other
> > > missing
> > > > types (#9, #16, #17, #19).
> > > >
> > > > Tests:
> > > > To test this with QEMU arm64, please follow the guide on dt_qemu.rst
> to
> > > > get a merged DT to run with.
> > > > ```
> > > > qemu-system-arm -machine virt -machine dumpdtb=qemu.dtb
> > > > cat  <(dtc -I dtb qemu.dtb) <(dtc -I dtb ./dts/dt.dtb | grep -v
> > > /dts-v1/) \
> > > >   | dtc - -o merged.dtb
> > > > qemu-system-arm -machine virt -nographic -bios u-boot.bin -dtb
> merged.dtb
> > > > ```
> > > >
> > > > Known issues:
> > > > It hits the image size limitation on R-CAR board(rcar3_salvator-x).
> > > > ```
> > > > u-boot.img exceeds file size limit:
> > > >   limit:  0x100000 bytes
> > > >   actual: 0x10049d bytes
> > > >   excess: 0x49d bytes
> > > > ```
> > > > This board needs a clean-up to reserve spaces for the changes as
> SMBIOS
> > > > is a fundamental feature.
> > > >
> > > > Below is the breakdown of the size-growth of the related functions:
> > > >   function                                   old     new   delta
> > > >     static.smbios_write_type4                  252    1052    +800
> > > >     static.smbios_write_type7                    -     764    +764
> > > >     static.smbios_write_type3                  188     488    +300
> > > >     smbios_get_val_si                            -     128    +128
> > > >     static.smbios_write_type2                  316     376     +60
> > > >     sysinfo_get_data                             -      56     +56
> > > >     static.smbios_write_type1                  380     396     +16
> > > >     smbios_write_funcs                         112     128     +16
> > > >     ofnode_read_u32                              -      12     +12
> > > >     sysinfo_rcar_ops                            40      48      +8
> > > >     install_smbios_table                       468     472      +4
> > >
> > > Right, so here's the problem I see right now. About 70% of all U-Boot
> > > platforms enable GENERATE_SMBIOS_TABLE and so "smbios: Refactor smbios
> > > library" causes a growth of around 1.5 kilobytes. That's a problem.
> > > There is a place where we're going to generate as full and complete a
> > > table as we can, and a place where we just want maybe the basics. We
> > > need to re-factor things first so that the platforms which aren't doing
> > > detailed tables do not grow and perhaps even shrink because we can pull
> > > existing code out.
> > >
> > Do you have a list of those platforms which don't need detailed tables?
> > I can add a new kconfig for this in the next version.
>
> No, you need to determine this, but it should be something that can be
> determined by existing data. The platforms which grow by only 1.5KiB
> don't. The ones that grow by ~4KiB, maybe? You need to see what they're
> actually doing today to determine that. Growing by ~8KiB? Yes.
>
> You can see my log at:
> https://gist.github.com/trini/8d3d4ab5b53402059a9d178786033c18
>
> And all of that is aside from my original worry about including a large
> number of static strings. I did not look in to if v2 deals with that.
>
> Yes, v2 has moved all the common strings and values to a generic dtsi
so that it can be included if any platforms are interested other than
qemu_arm64.
I will look into the log you provided.

Regards,
Raymond
