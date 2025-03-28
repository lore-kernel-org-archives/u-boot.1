Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A2FC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 23:39:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE37680ECC;
	Sat, 29 Mar 2025 00:39:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z8APcoSF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9526380F0E; Sat, 29 Mar 2025 00:39:29 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADCE9805C8
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 00:39:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-abf3d64849dso413184866b.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743205166; x=1743809966; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pF5NDvMA355PIQdKfl1zDR8g5TBbBrahxE9uprtvYDk=;
 b=Z8APcoSFbYrdDLJtSEsAjoL86EBaaa8e6tttCEQkDV7+5kzRsed6JGzr0Y+QzpvlKn
 /yPl47RyXHprrp25SN5GQEF5TSOM1PfybwjeH2DEib81OAPK6qhVpEfsL/QKZqFsCjeh
 IwWJDHhSCa4woTVoIXflsaD2wu7M/LwnI7AIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743205166; x=1743809966;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pF5NDvMA355PIQdKfl1zDR8g5TBbBrahxE9uprtvYDk=;
 b=uarBhtAT95Vse9t6HnI5KCCu+mTkkJB+OD8zhFQAq+BHJSXWaT0QnuP/hQNjv5RcpO
 Zvhj7esZL2m3aCik2Hrm8B3Tsag8bKPFQ8n0KvLN//bWMrJTrfs6M82iyuCi984A7o1Z
 I8Zx3EcnSNLp/HJBPo1GUjMVFTkTJ9l/yM7WZzWXDUSLyDVrqRiApTVEX8otpstvmj2V
 kijBoiGf3gUDH1Ufl/yv+jxdTecqcQRdnukJEgMVDa2oT3nRY1EM0NiFav0oOE+9ebMa
 OM+D+MHi9JtLj7AXaurHcPuyCURgfZqUdwk14x6n2m/aKES8lDzC/1jISunk/f3ym03K
 9YgQ==
X-Gm-Message-State: AOJu0Yy/3t1U2H7Yed7ECIKtlhOfa/bQGpG9vGFg9fbBmQdHnbPVaYxA
 fts20IWRA246C3T4IdaQORObsWXr+fJG3OzzbDWLHixPwHhBKHjbnzJhUXX3crUF9ukQ1CbqidT
 yRt3G326RnKiubsQG5g1Wv4j3LEvF35BMpvAo4XIGABFnC8I=
X-Gm-Gg: ASbGncsCVVg71PImvyYK4wO/HdwS2NOp2WYtw71ScJuaF7KHbbOjF6wFh5bAZobKlQS
 ea6vXV+bDLMQVmrVclf5srfL4w3RjOltEx0mjIufDFWZARzweqnYu27LOnR3lYlQ041aeU0Hfq5
 hzTgj8h3Xzk56UaWTmW1OG4bjO4ko=
X-Google-Smtp-Source: AGHT+IGJXM4VZLc0shC0u3IF4IyY+Y73Gqjv/B+Q21pe2zTHR0ACywYPaX2JyTPnub6j5BziWT9QCbwAK2duaXtWTNA=
X-Received: by 2002:a17:907:d90:b0:ac4:169:3664 with SMTP id
 a640c23a62f3a-ac738a5ac83mr71710966b.33.1743205165738; Fri, 28 Mar 2025
 16:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250327231318.2713201-1-raymond.mao@linaro.org>
 <20250327231318.2713201-2-raymond.mao@linaro.org>
 <CAFLszTiATNSdLgJ-PCEFjyTbwsgxTXg06W4Lj3Fv+zYwtKWcEA@mail.gmail.com>
 <CAEfUkULhW6fi9119WwTuUq__77Ga_ORcDpXsDzh+vs73QZmbkQ@mail.gmail.com>
In-Reply-To: <CAEfUkULhW6fi9119WwTuUq__77Ga_ORcDpXsDzh+vs73QZmbkQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 23:39:13 +0000
X-Gm-Features: AQ5f1JoWGNG26BzUn36aI7JNWophcw6-f4Du7jQ0MFN349M25Z6Ht28mDHyyjAw
Message-ID: <CAFLszTiXypPhg1RXng7P6CV9xLAEuSMg4B+gjr0c53a0SvS3sQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] env: point fdt address to the fdt in a bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ravi Minnikanti <rminnikanti@marvell.com>, Matthias Brugger <mbrugger@suse.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Raymond,

On Fri, 28 Mar 2025 at 09:06, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Fri, 28 Mar 2025 at 07:35, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Raymond,
> >
> > On Thu, 27 Mar 2025 at 17:13, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > Point fdt_addr to the fdt embedded in the bloblist since fdt_addr
> > > is a default address for bootefi, bootm and booti to look for the
> > > device tree when launching the kernel.
> >
> > I wonder if we can drop use of that environment variable at some
> > point? It seems strange to set a variable to gd->fdt_addr only to use
> > it later. Why not just use gd->fdt_addr ?
> >
>
> First, the fdtdec happens in an early stage and it is not able to set
> the env variable at that time.

No, I mean actually drop use of the environment var, so we wouldn't
set it at all.

> Secondly, the fdt_addr is commonly used to boot the kernel by booti,
> bootm and bootefi, if it is not pointed to gd->fdt_addr when
> gd->fdt_src is FDTSRC_BLOBLIST, it will need a big refactoring on all
> boot commands to observe where it should get the correct fdt.

Sure, but I already did most of that refactoring. The variable is only
accessed in pxe_utils and efi_helper.

For efi it can just use the control FDT. It uses that as a fallback
anyway in efi_install_fdt(), so just remove the var access.

For pxe_utils I've done most of the work there, but perhaps there are
boards which use one FDT for U-Boot and a different one for booting,
both of which come from a prior stage? I'm not sure.

rpi was using it but I sent a series to fix that about 6 months ago.

>
> I don't agree with the idea that the board or env can override a valid
> fdt handed off from the previous boot stage, it just messes up without
> any benefits.

Fair enough, I agree. But then you probably shouldn't look at the rpi code.

>
> > I hit this in the bootstd conversion but wasn't sure what to do. So
> > much confusion.
> >
> > I see quite a few boards setting this variable in their environment.
> > So this patch would override that setting, wouldn't it? It's just not
> > clear what any of this means.
> >
>
> This will be only active when "gd->fdt_src is FDTSRC_BLOBLIST" - It
> explicitly indicates a previous boot stage is passing a valid fdt.
> What is the purpose of dropping it?

The env var is there for the distro scripts, I believe. If we ever
restart bootstd migrations these will go away. We should not be adding
new code to use this old mechanism.

>
> > So I think at this point we should update the code to use the internal
> > control FDT directly.
> >
> > >
> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > ---
> > >  env/common.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/env/common.c b/env/common.c
> > > index a58955a4f42..a38e5d107a8 100644
> > > --- a/env/common.c
> > > +++ b/env/common.c
> > > @@ -16,6 +16,7 @@
> > >  #include <asm/global_data.h>
> > >  #include <linux/printk.h>
> > >  #include <linux/stddef.h>
> > > +#include <mapmem.h>
> > >  #include <search.h>
> > >  #include <errno.h>
> > >  #include <malloc.h>
> > > @@ -368,6 +369,18 @@ int env_get_default_into(const char *name, char *buf, unsigned int len)
> > >         return env_get_from_linear(default_environment, name, buf, len);
> > >  }
> > >
> > > +static int env_update_fdt_addr_from_bloblist(void)
> > > +{
> > > +       /*
> > > +        * fdt_addr is by default used by booti, bootm and bootefi,
> > > +        * thus set it to point to the fdt embedded in a bloblist if it exists.
> > > +        */
> > > +       if (!CONFIG_IS_ENABLED(BLOBLIST) || gd->fdt_src != FDTSRC_BLOBLIST)
> > > +               return 0;
> >
> > This is just too messy, sorry.
>
> This means we update the variable only when the bloblist is being used
> and a valid fdt is in the bloblist which is already saved in the gd.
> In other cases, the transfer list is not being used and the value from
> the user will not be replaced.
> Not sure why you feel messy.

I understand what the code does, but here you only sometimes set the
env var, which we likely don't need anyway. You are making a
complicated mess worse with this patch, because the poor sod who comes
along after you will have an even harder time figuring out what to do.

I'm not saying you created this mess, far from it, but try to
implement your feature without going near that environment variable,
if you can.

Regards,
Simon
