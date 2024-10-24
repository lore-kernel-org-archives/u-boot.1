Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B738BCE8E70
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 13:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AF2888E90;
	Thu, 24 Oct 2024 15:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mpH/Z/f0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01A3788BB7; Thu, 24 Oct 2024 15:36:00 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B4E388F58
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 15:35:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e2e88cb0bbso721495a91.3
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 06:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729776947; x=1730381747; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/kR4hnrpo+tvCobcZpwwNStutoBL39aC2ZIeT/qfW9A=;
 b=mpH/Z/f0jDRErxo7lAx5SendSrjLBjGft1zwGc3YlzBLPhwmdZtpRZ2mHvb/3DN5zz
 JdLvyjZhR22YIl/Tr55urCAC4140ynYFTJpIOVumcMRb9SohWENUKU3k78qZ11InaDwX
 qElXlS1nvHJ/mdXysipZ/baUsLaVJcutowY1AuXNz2WJJiWDUiqnqBqX1UMlBq887sbJ
 p0fcOUk3Ncplc/BzNWawCK9mI+S2rRyETeGYC/njhk7Rd0+ETIc0jmwF1I6IQdqYLy3D
 /CC1PZuAMyqxqk030eZjxFUhat7JyhtzzoMV2EDizW6XPXxQpqM82brX8nOeZmZINL2a
 w/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729776947; x=1730381747;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/kR4hnrpo+tvCobcZpwwNStutoBL39aC2ZIeT/qfW9A=;
 b=mrTJEVY/Wu4MbuuDDmC+0OKSVRIBi7OpUlZ/FX/y94ghPqobaI8OFPR7E7iqAzzxQ9
 t8JobRh7us+WyKQv6Plt9QpkJ1Fg/q0gOF1mVZqb+NzkmB00Pb2jcbi5bvhyCLHPoJ6w
 7CrQAwgJ36MdA0kdpXymkL6tSUw2qBYBkQLlwqUSYreBvhX+ogUUmynnBWJ4sv73d3Oq
 UUs79KwbCGWzy/ebebmeit0Qq2ZkDxb41Loi8Ji7+EpzDzn9cYfpJYPh6FSnn5rvrEe6
 kwsRnfwZpwbxdcC13LoT/4rq9DyTnVbxoo0EHjQ6vjyemkcuAotkWM+rVUgC4TI1Xe3u
 FW+w==
X-Gm-Message-State: AOJu0Yyr+T/NmiNduwtFcecPiz3lj7hiHaLXIMYkxuWwGDtopaMVx9z+
 uUHmzDubsbk6/x+dhNJhOOAsmgLw8T8BaEzgRg40/3K8Z6Sg2aH9kCznc8VcvLTfEeNmFc9E0VE
 1DE81ezpFcLYQ5rgNKoV5p8Sm432sz9L5t2/N6w==
X-Google-Smtp-Source: AGHT+IHOmN3BqVENPuPwCb4PlDeyq4r7MoPOZznY4ojTgG1xZX+NLhqCvZB9SsGRZkmJCDoUoTEtd8gK6ZnH0w11UhM=
X-Received: by 2002:a17:90a:fa8f:b0:2d8:82a2:b093 with SMTP id
 98e67ed59e1d1-2e77f47f07emr2179075a91.13.1729776947259; Thu, 24 Oct 2024
 06:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20241022200543.116343-1-raymond.mao@linaro.org>
 <20241024002255.GP4959@bill-the-cat>
In-Reply-To: <20241024002255.GP4959@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 24 Oct 2024 09:35:36 -0400
Message-ID: <CAEfUkUJYcBSET22QJAKzCd+q4GYXe6H9Xshpm_RiET57uzsE3Q@mail.gmail.com>
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

On Wed, 23 Oct 2024 at 20:23, Tom Rini <trini@konsulko.com> wrote:

> On Tue, Oct 22, 2024 at 01:05:21PM -0700, Raymond Mao wrote:
>
> > Motivations for changes:
> > Current SMBIOS library and command-line tool is not fully matching with
> > the requirements:
> > 1. Missing support for other mandatory types (#7, #9, #16, #17, #19).
> > 2. Only a few platforms support SMBIOS node from the device tree.
> > 3. Values of some fields are hardcoded in the library other than fetching
> >    from the device hardware.
> > 4. Embedded data with dynamic length is not supported (E.g. Contained
> >    Object Handles in Type #2 and Contained Elements in Type #3)
> >
> > Changes:
> > 1. Refactor the SMBIOS library and command-line tool to better align with
> >    the SMBIOS spec.
> > 2. Create an arch-specific driver for all aarch64-based platforms to
> fetch
> >    SMBIOS private data from the device hardware (processor and cache).
> > 3. Create a sysinfo driver to poppulate platform SMBIOS private data.
> > 4. Add generic SMBIOS DTS file for arm64 platforms for those common
> strings
> >    and values which cannot be retrieved from the system registers.
> >    Vendors can create their own SMBIOS node using this as an example.
> >    For those boards without SMBIOS nodes, this DTS file can be included
> to
> >    have a generic SMBIOS information of the system.
> > 5. Add support for Type #7 (Cache Information) and link its handles to
> >    Type #4.
> >
> > Once this patch is acceptted, subsequent patch sets will add other
> missing
> > types (#9, #16, #17, #19).
> >
> > Tests:
> > To test this with QEMU arm64, please follow the guide on dt_qemu.rst to
> > get a merged DT to run with.
> > ```
> > qemu-system-arm -machine virt -machine dumpdtb=qemu.dtb
> > cat  <(dtc -I dtb qemu.dtb) <(dtc -I dtb ./dts/dt.dtb | grep -v
> /dts-v1/) \
> >   | dtc - -o merged.dtb
> > qemu-system-arm -machine virt -nographic -bios u-boot.bin -dtb merged.dtb
> > ```
> >
> > Known issues:
> > It hits the image size limitation on R-CAR board(rcar3_salvator-x).
> > ```
> > u-boot.img exceeds file size limit:
> >   limit:  0x100000 bytes
> >   actual: 0x10049d bytes
> >   excess: 0x49d bytes
> > ```
> > This board needs a clean-up to reserve spaces for the changes as SMBIOS
> > is a fundamental feature.
> >
> > Below is the breakdown of the size-growth of the related functions:
> >   function                                   old     new   delta
> >     static.smbios_write_type4                  252    1052    +800
> >     static.smbios_write_type7                    -     764    +764
> >     static.smbios_write_type3                  188     488    +300
> >     smbios_get_val_si                            -     128    +128
> >     static.smbios_write_type2                  316     376     +60
> >     sysinfo_get_data                             -      56     +56
> >     static.smbios_write_type1                  380     396     +16
> >     smbios_write_funcs                         112     128     +16
> >     ofnode_read_u32                              -      12     +12
> >     sysinfo_rcar_ops                            40      48      +8
> >     install_smbios_table                       468     472      +4
>
> Right, so here's the problem I see right now. About 70% of all U-Boot
> platforms enable GENERATE_SMBIOS_TABLE and so "smbios: Refactor smbios
> library" causes a growth of around 1.5 kilobytes. That's a problem.
> There is a place where we're going to generate as full and complete a
> table as we can, and a place where we just want maybe the basics. We
> need to re-factor things first so that the platforms which aren't doing
> detailed tables do not grow and perhaps even shrink because we can pull
> existing code out.
>
> Do you have a list of those platforms which don't need detailed tables?
I can add a new kconfig for this in the next version.

Regards,
Raymond
