Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6F5D3A66B
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 15:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DB9C8917E;
	Tue, 29 Oct 2024 16:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QkwpvSHg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97BAC8918A; Tue, 29 Oct 2024 16:46:49 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EE868917E
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 16:46:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9a26a5d6bfso860348566b.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 08:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730216806; x=1730821606; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lLyo3Fe6pIq3F35ZHPEpbBbYw1FUEExN45jNBWALAWE=;
 b=QkwpvSHgqoIF37ACm2b7jq0piaqRtSPhj3XnjQehJkm5NZDSD8FKmxHx73xMdrWtt/
 kYyS1cRCD+nxjhsbry7O+rEIw98j2jxteBJajfZpbaU2gBr72odpMyhhGWt1oJau2aP1
 XQbE1Fz2EBTg1g9spsFz6yH2R+ZLVFP9ETtoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730216806; x=1730821606;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lLyo3Fe6pIq3F35ZHPEpbBbYw1FUEExN45jNBWALAWE=;
 b=UfoXRfKl97OG7kDhI8PYET9Nf64onDgyGORTjJCB8Y9WKE1mBsYKG9+PfYYJ6C1PYA
 aQxszSMSHZ39wuVilRMtfH6l9/3vAAzhac/J8yXUr+WD6lnXcGqSJT5jM4Hc8FyYTRVz
 Buamu5Cpj4PwuLzGOHGm4FK7S7xBzWjV6la6P8G+BqGM0jbukzjHa5L+hAIu0Mj0KDyS
 ABDMDGlAd2IM/FdvSrsqA5SVGc+3YGwklpGd2SLlN+kMBQIv7/O7Dt65q8n572WpEPVi
 zSHA6gNAQQJSzkWHdJ87NlsRZHzpOofHvfhZ8OCF54gYj6ojwBFgtCfxQP3F4nuX+EoT
 KwAA==
X-Gm-Message-State: AOJu0YzgN3J3BtY4VplGRkOZM42DMpuIIzNu4hvs1J13gwatrruqKm+c
 IExwnGcXMHw+HOiY+gc4WthUSR/USfRljS25mAvVXYX6o4PicemoIKgwFWXTlaXMulIFwefOAl4
 anGZ0gYh0Oh82bYaubUKfruMVQ4b0SydIuPpp2b/8RpHh+hktNPwi
X-Google-Smtp-Source: AGHT+IGoi8CLpiOMJ3NbblYdBW7ebv2bF23J8t/hLFT5kDVbSDjAOU7DHaBMhaV43oHTdHW4GKMBYwJzlzLaWRCP1CI=
X-Received: by 2002:a17:907:7ea0:b0:a9a:17fb:4c40 with SMTP id
 a640c23a62f3a-a9de5d6e1e7mr1132763666b.26.1730216805803; Tue, 29 Oct 2024
 08:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241028124815.47262-1-sjg@chromium.org>
 <20241028124815.47262-7-sjg@chromium.org>
 <CAC_iWjKx_r0TjdehHU+y7sJe3J+qGSs8FnXAbqXpCyyXcA0V2w@mail.gmail.com>
In-Reply-To: <CAC_iWjKx_r0TjdehHU+y7sJe3J+qGSs8FnXAbqXpCyyXcA0V2w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 29 Oct 2024 16:46:34 +0100
Message-ID: <CAFLszTgNbLjHSp670ghEExe2DJqYFJsV-AuYWjFZT_9RABN2_g@mail.gmail.com>
Subject: Re: [PATCH 06/15] sandbox: Add a way to show the sandbox
 memory-mapping
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Ilias,

On Tue, 29 Oct 2024 at 10:59, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon
>
> This seems completely unrelated to the series.
>
> Please send it as a separate patch

I've moved the initial patches in this series to my queue in patchwork, for now.

Regards,
Simon


>
> Thanks
> /Ilias
>
> On Mon, 28 Oct 2024 at 14:48, Simon Glass <sjg@chromium.org> wrote:
> >
> > This is mostly hidden in the background, but it is sometimes useful to
> > look at it. Add a function to allow this.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  arch/sandbox/cpu/cpu.c         | 13 +++++++++++++
> >  arch/sandbox/include/asm/cpu.h |  3 +++
> >  cmd/sb.c                       | 11 +++++++++++
> >  doc/usage/cmd/sb.rst           | 25 +++++++++++++++++++++++++
> >  4 files changed, 52 insertions(+)
> >
> > diff --git a/arch/sandbox/cpu/cpu.c b/arch/sandbox/cpu/cpu.c
> > index 06f8c13fab9..d1c4dcf0764 100644
> > --- a/arch/sandbox/cpu/cpu.c
> > +++ b/arch/sandbox/cpu/cpu.c
> > @@ -253,6 +253,19 @@ phys_addr_t map_to_sysmem(const void *ptr)
> >         return mentry->tag;
> >  }
> >
> > +void sandbox_map_list(void)
> > +{
> > +       struct sandbox_mapmem_entry *mentry;
> > +       struct sandbox_state *state = state_get_current();
> > +
> > +       printf("Sandbox memory-mapping\n");
> > +       printf("%8s  %16s  %6s\n", "Addr", "Mapping", "Refcnt");
> > +       list_for_each_entry(mentry, &state->mapmem_head, sibling_node) {
> > +               printf("%8lx  %p  %6d\n", mentry->tag, mentry->ptr,
> > +                      mentry->refcnt);
> > +       }
> > +}
> > +
> >  unsigned long sandbox_read(const void *addr, enum sandboxio_size_t size)
> >  {
> >         struct sandbox_state *state = state_get_current();
> > diff --git a/arch/sandbox/include/asm/cpu.h b/arch/sandbox/include/asm/cpu.h
> > index c97ac7ba95b..682bb3376d1 100644
> > --- a/arch/sandbox/include/asm/cpu.h
> > +++ b/arch/sandbox/include/asm/cpu.h
> > @@ -8,4 +8,7 @@
> >
> >  void cpu_sandbox_set_current(const char *name);
> >
> > +/* show the mapping of sandbox addresses to pointers */
> > +void sandbox_map_list(void);
> > +
> >  #endif /* __SANDBOX_CPU_H */
> > diff --git a/cmd/sb.c b/cmd/sb.c
> > index 9dbb53275b3..9245052492e 100644
> > --- a/cmd/sb.c
> > +++ b/cmd/sb.c
> > @@ -7,6 +7,7 @@
> >  #include <command.h>
> >  #include <dm.h>
> >  #include <spl.h>
> > +#include <asm/cpu.h>
> >  #include <asm/global_data.h>
> >  #include <asm/state.h>
> >
> > @@ -29,6 +30,14 @@ static int do_sb_handoff(struct cmd_tbl *cmdtp, int flag, int argc,
> >  #endif
> >  }
> >
> > +static int do_sb_map(struct cmd_tbl *cmdtp, int flag, int argc,
> > +                    char *const argv[])
> > +{
> > +       sandbox_map_list();
> > +
> > +       return 0;
> > +}
> > +
> >  static int do_sb_state(struct cmd_tbl *cmdtp, int flag, int argc,
> >                        char *const argv[])
> >  {
> > @@ -42,8 +51,10 @@ static int do_sb_state(struct cmd_tbl *cmdtp, int flag, int argc,
> >
> >  U_BOOT_LONGHELP(sb,
> >         "handoff     - Show handoff data received from SPL\n"
> > +       "sb map         - Show mapped memory\n"
> >         "sb state       - Show sandbox state");
> >
> >  U_BOOT_CMD_WITH_SUBCMDS(sb, "Sandbox status commands", sb_help_text,
> >         U_BOOT_SUBCMD_MKENT(handoff, 1, 1, do_sb_handoff),
> > +       U_BOOT_SUBCMD_MKENT(map, 1, 1, do_sb_map),
> >         U_BOOT_SUBCMD_MKENT(state, 1, 1, do_sb_state));
> > diff --git a/doc/usage/cmd/sb.rst b/doc/usage/cmd/sb.rst
> > index 6f54f9d9eb7..37431aff7c8 100644
> > --- a/doc/usage/cmd/sb.rst
> > +++ b/doc/usage/cmd/sb.rst
> > @@ -12,6 +12,7 @@ Synopsis
> >  ::
> >
> >      sb handoff
> > +    sb map
> >      sb state
> >
> >  Description
> > @@ -26,6 +27,24 @@ sb handoff
> >  This shows information about any handoff information received from SPL. If
> >  U-Boot is started from an SPL build, it shows a valid magic number.
> >
> > +sb map
> > +~~~~~~
> > +
> > +This shows any mappings between sandbox's emulated RAM and the underlying host
> > +address-space.
> > +
> > +Fields shown are:
> > +
> > +Addr
> > +    Address in emulated RAM
> > +
> > +Mapping
> > +    Equivalent address in the host address-space. While sandbox requests address
> > +    ``0x10000000`` from the OS, this is not always available.
> > +
> > +Refcnt
> > +    Shows the number of references to this mapping.
> > +
> >  sb state
> >  ~~~~~~~~
> >
> > @@ -42,6 +61,12 @@ as ``sandbox_spl``::
> >      => sb handoff
> >      SPL handoff magic 14f93c7b
> >
> > +This shows output from the *sb map* subcommand, with a single mapping::
> > +
> > +    Sandbox memory-mapping
> > +        Addr           Mapping  Refcnt
> > +    ff000000  000056185b46d6d0       2
> > +
> >  This shows output from the *sb state* subcommand::
> >
> >      => sb state
> > --
> > 2.43.0
> >
