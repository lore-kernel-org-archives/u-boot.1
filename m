Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F0DCDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 07:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23AED878B4;
	Mon, 23 Oct 2023 09:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gzh4cUcO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7620587894; Mon, 23 Oct 2023 09:04:34 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 374D4878AE
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so4301369a12.0
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 00:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698044672; x=1698649472; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZeG6MnjWyJOCMygMO3TKQa0y/xIi9k3iIpSkwl8zZII=;
 b=gzh4cUcOOOCvEzCkAdBFu2nPukHeFVOa8WEcRn6QMZVRrHPIEloQ0utSLGHv+MI38R
 DpKz0avGemM9xoyO2B1lowzn9x27rgXcZnBPKIGkz+/Gw3YrqccU+0QWnemNpaIjR2Oy
 d4wuMr+zG3loUWrRluMqKmolnDK2M7uvPlrS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698044672; x=1698649472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZeG6MnjWyJOCMygMO3TKQa0y/xIi9k3iIpSkwl8zZII=;
 b=SYz7kl2IlBWbXmVJD7k9fUHqCwRGkQiHRv/D2LVePAeR4kAZTXtnu370xr+S2ziPc7
 wvGqFCGorkz09MnnEZmYqdhWavyXuVHTIR7V0N2IOs1yqDFWR3HMoMvFo1WUsP1r/rV8
 qOfyt7Rl04w5ELB6zX9EVp6KElKd4cBDVfNLoEE7V75kGbEqzMaU7aGnog/eHH+66gsj
 KfOefgn192CAzLbeI9UKRVy+BBGLH1+Vuof2z7fU0yD74IRkVjG617I24eUKxoCGe039
 GRJDj8sua9Ts67X6ROUoVpV26OUmNGpWHojMqGlYaowfUNotlqkSCgqhqJnzWnmecRWG
 3KFg==
X-Gm-Message-State: AOJu0Yzp6Y7vo9AyJlC2m+0Z3dhZp0DQC7y+uOTSaUka9ajFItypudKU
 2F5p0wv+UQSifr2+QWj9UkNwUDPAVtkU8JLQ/FKIGA==
X-Google-Smtp-Source: AGHT+IHfEIEhs4BhG0ulMTxbRKXEXbdWNnvn5/cmdp3Pf+/h2F54/ugsZH1E7m15Ce8qZuURZipbRK2dFbnIUso+osE=
X-Received: by 2002:a17:906:4fc7:b0:9be:30c2:b8ff with SMTP id
 i7-20020a1709064fc700b009be30c2b8ffmr6442484ejw.61.1698044671460; Mon, 23 Oct
 2023 00:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231021004522.53311-1-sjg@chromium.org>
 <c4212389-6d0e-405d-bbc7-10c8278ba1de@linaro.org>
In-Reply-To: <c4212389-6d0e-405d-bbc7-10c8278ba1de@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Oct 2023 00:04:14 -0700
Message-ID: <CAPnjgZ1Q4y1SvwMa3gRX6Xa=5gP7gTSiQfe83jQ=KQC2K=EG7g@mail.gmail.com>
Subject: Re: [PATCH] smbios: arm64: Allow table to be written at a fixed addr
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Caleb,

On Sat, 21 Oct 2023 at 01:43, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Simon,
>
> On 21/10/2023 01:45, Simon Glass wrote:
> > U-Boot typically sets up its malloc() pool near the top of memory. On
> > ARM64 systems this can result in an SMBIOS table above 4GB which is
> > not supported by SMBIOSv2.
> >
> > Work around this problem by providing a new option to choose an address
> > just below 4GB, if needed.
> I may well be missing something here, but I don't quite understand the
> justification behind the original patch [1] which caused this regression.
>
> I'm currently preparing support for a few different Qualcomm boards
> which have different memory layouts, so far it's been possible to avoid
> having any fixed addresses, so the same u-boot image can be used on all
> of them (with just a different DTB).

What sort of memory layout do you have? I could enhance the patch to
find the top of a memory bank below 4GB, perhaps? E.g. see the
'bdinfo' command.

>
> As I mentioned before, efi_allocate_pages() seems to work fine from
> install_smbios_table(), I haven't delved into the code too much but I
> wonder if this could be an acceptable solution?

Unfortunately that function is EFI-specific. The function can only be
called once EFI is inited. We only want to do that if booting with
EFI.

The tables are written at the start of U-Boot, partly because that is
how it is done on x86 and partly so the 'acpi' command actually works.

The EFI code ended up writing a separate set of tables, which is of
course not correct.

I did look at creating an API in U-Boot to alloc memory below 4GB but
then decided that for just this one use case it might not be worth it.

>
> Barring that, could we use an environment variable to pass this address
> in? Although I think that might not be a very desirable solution.
>
> I appreciate you taking the time to prepare this patch and CC me. If
> nobody else objects to this patch then I'd prefer to avoid blocking it.
> In either case, I'd greatly appreciate any input on the above
> suggestions so that I can implement a solution for my boards.

I would like it to be automatic. I assumed on ARM64 that there is
memory available at 3.99GB if U-Boot has relocated to above 4GB, but
as above I could make this more clever.

Regards,
Simon


>
> Thanks and regards,
>
> [1]:
> https://lore.kernel.org/u-boot/20230920030027.1385833-16-sjg@chromium.org/
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   lib/Kconfig                 | 17 +++++++++++++++++
> >   lib/efi_loader/efi_smbios.c | 12 ++++++++++++
> >   2 files changed, 29 insertions(+)
> >
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index f6ca559897e7..a77f2f3e9089 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -994,6 +994,23 @@ config GENERATE_SMBIOS_TABLE
> >         See also SMBIOS_SYSINFO which allows SMBIOS values to be provided in
> >         the devicetree.
> >
> > +config SMBIOS_TABLE_FIXED
> > +     bool "Place the SMBIOS table at a special address"
> > +     depends on GENERATE_SMBIOS_TABLE && ARM64 && SMBIOS && EFI_LOADER
> > +     default y
> > +     help
> > +       Use this option to place the SMBIOS table at a fixed address.
> > +
> > +       U-Boot typically sets up its malloc() pool near the top of memory. On
> > +       ARM64 systems this can result in an SMBIOS table above 4GB which is
> > +       not supported by SMBIOSv2. This option works around this problem by
> > +       chosing an address just below 4GB, if needed.
> > +
> > +config SMBIOS_TABLE_FIXED_ADDR
> > +     hex "Fixed address for use for SMBIOS table"
> > +     depends on SMBIOS_TABLE_FIXED
> > +     default 0xffff0000
> > +
> >   endmenu
> >
> >   config LIB_RATIONAL
> > diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
> > index 48446f654d9b..84ea027ea48c 100644
> > --- a/lib/efi_loader/efi_smbios.c
> > +++ b/lib/efi_loader/efi_smbios.c
> > @@ -61,6 +61,18 @@ static int install_smbios_table(void)
> >               return log_msg_ret("mem", -ENOMEM);
> >
> >       addr = map_to_sysmem(buf);
> > +
> > +     /*
> > +      * Deal with a fixed address if needed. For simplicity we assume that
> > +      * the SMBIOS-table size is <64KB and that the malloc region does not
> > +      * straddle the 4GB boundary.
> > +      */
> > +     if (IS_ENABLED(CONFIG_SMBIOS_TABLE_FIXED) && addr >= SZ_4G - SZ_64K) {
> > +             addr = IF_ENABLED_INT(CONFIG_SMBIOS_TABLE_FIXED,
> > +                                   CONFIG_SMBIOS_TABLE_FIXED_ADDR);
> > +             log_warning("Forcing SMBIOS table to address %lx\n", addr);
> > +     }
> > +
> >       if (!write_smbios_table(addr)) {
> >               log_err("Failed to write SMBIOS table\n");
> >               return log_msg_ret("smbios", -EINVAL);
>
> --
> // Caleb (they/them)
