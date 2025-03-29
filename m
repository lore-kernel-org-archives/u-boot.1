Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CCCC36008
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 08:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 615918059D;
	Sat, 29 Mar 2025 09:30:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UfLrmIyD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D390805C8; Sat, 29 Mar 2025 09:30:25 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D5C0800C1
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 09:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e637edaa652so2213886276.1
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 01:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743237021; x=1743841821; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dGuz4h2j8kr7BrHQCjiBpABZzOHbaNn771jc8ZFO/uc=;
 b=UfLrmIyDQS+6C9j//laI5k8FKveV0l7eskDUJoKHpRgak++hZqWJV3YS2yWQ0OXjdw
 cloqL76hzJ+8SY9cUrfqKvfnKPCt0FMddhZG0Q/UsOC1y88OTX4PjEhVB2GO9wS4VICH
 Yffhun4I2qxytDXcqDCB90nJWw4l021tPGzW4gudiju5/htgXsYdm26RzIS3+vGGZ/ZJ
 nZ5z0Zhu3KW92UNMmlVesnFin7WW8ILtjJuX/t2u+fYcFu3tgOC2jtoF+0NIYaV7JnUk
 0ypSbHtOwodbQYultesbMwZRCg4bcXG4qhxuIFOFUiCNk5WqhUFhgHvS1z8xI0oNSflY
 0LkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743237021; x=1743841821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dGuz4h2j8kr7BrHQCjiBpABZzOHbaNn771jc8ZFO/uc=;
 b=u9QAJyayI7/Mjmp7Zmd7mifB7fibMjYNIdRc0jZoMUip087f4uz1t/4YXiFp5VkYYP
 YgQFGgV6r4mHK0RDfUEhcYGgnNIEHBxXSZjjdn/rUEe9P7VKUpZLYqT57nu2uVG0CnSm
 zNMyX+4nSw9Jrruww6dFWHKMr7M5iL52Uu/ZDKVKPFXk/mZlJ7uDDqVHdEV/9X3rKQfy
 1QR0bEjBU6CTGL4ywjsuPUZ2CcFkyrRHFNrX5uCoKV5QgqZgsLobr4SEJ+s0Uxg3cXYd
 gV0oBksxfRUBXRy43m14sI5obJekEW7pmHkoh0GTMeLJ9BkT75SyDIgH3XoMF/bc2IJQ
 qDrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvOswiQMf66MLE2vMYZ93WPEhEBthm8oMZds6I4N/XBX8nYkpDS4uit4faW/5WbfR6qeui5vg=@lists.denx.de
X-Gm-Message-State: AOJu0YxaWbgw+gr0CDp33eUZ6MTPuytkjsgVfCcV/r+AU4CUMMqLpL8u
 A08yRB1+4Js3Y2NjNY0u2fZwJknNSpyJPCu3FqCIS3n0HkQ6k89BbW0xwFgbXNtfLuoBXmCM2W2
 HZbTXTJuafod7s07SLcTyyIoi6FlCE8b3xTqfmQ==
X-Gm-Gg: ASbGnctXTwVywsBOZ3f7uIaf3dKfTWsG6Nk0fWUJVK11xlzUVwZscbQ4pDSHycxPUPG
 NNkQVVTViGID7GThvaHJaHZaSa6pMK+3xJSeBYrhlJisbmuqEinsc7A3CRtPARUM7w55NItct4L
 JHvi/C6Ds85Y3nk121Zf1x9CkM3w==
X-Google-Smtp-Source: AGHT+IEGiwiJbXfOFDkl+ifw97W/7dh3uy0kK/ZflKo8pb1YXO5IVx5G0V0C6KaKD+5HhJToO/9GquJ8/QROcBIfhu0=
X-Received: by 2002:a05:6902:490e:b0:e5a:b05e:4da8 with SMTP id
 3f1490d57ef6-e6b83ad324cmr2756915276.42.1743237021034; Sat, 29 Mar 2025
 01:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250326054653.273906-1-quic_varada@quicinc.com>
 <CAC_iWj+MPcOcuhM1vcHyXYUF7O7U_y8+KKMZJszTK2aqfgfHZg@mail.gmail.com>
 <Z+TsLpAGAIezgPZS@hu-varada-blr.qualcomm.com>
 <CAC_iWjKyyOHCU2xv-x9BW9w7GtY8ohupxNKTTJC0V91dfPwy8Q@mail.gmail.com>
In-Reply-To: <CAC_iWjKyyOHCU2xv-x9BW9w7GtY8ohupxNKTTJC0V91dfPwy8Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 29 Mar 2025 10:29:45 +0200
X-Gm-Features: AQ5f1JoKxrTq2k-lj3eaNsx_IiLb0nCdlcUXUcwQ6ofhKvShXgQjRoYdQ5oHoL8
Message-ID: <CAC_iWjK9oO8NDuWP5O6a+Y4by4KcOBC+z50P_1rTQRLJR8JJ+Q@mail.gmail.com>
Subject: Re: [PATCH v1] efi_loader: Handle GD_FLG_SKIP_RELOC
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: trini@konsulko.com, sjg@chromium.org, EABachinin@salutedevices.com, 
 jerome.forissier@linaro.org, rasmus.villemoes@prevas.dk, ansuelsmth@gmail.com, 
 sughosh.ganu@linaro.org, michal.simek@amd.com, u-boot@lists.denx.de
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

+CC Heinrich who has looked the relocation stuff a bit more

On Thu, 27 Mar 2025 at 23:22, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 27 Mar 2025 at 08:12, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > On Wed, Mar 26, 2025 at 09:28:04AM +0200, Ilias Apalodimas wrote:
> > > Hi Varadarajan
> > >
> > > On Wed, 26 Mar 2025 at 07:47, Varadarajan Narayanan
> > > <quic_varada@quicinc.com> wrote:
> > > >
> > > > If the EFI runtime services pointers are relocated even though
> > > > relocation is skipped, it corrupts some other data resulting in some
> > > > unexpected behaviour.
> > > >
> > > > In this specific case, it overwrote some page table entries resulting in
> > > > the device memory address range's mappings getting removed. Eventually,
> > > > after the completion of efi_runtime_relocate(), when a driver tries to
> > > > access its device's registers it crashes since the mappings are absent.
> > >
> > > How were those page table entries added?
> >
> > initr_caches ->
> >         enable_caches ->
> >                 setup_pgtables (arch/arm/mach-snapdragon/board.c)
> >
> > > The runtime service relocation might have overwritten those now, but
> > > since they are not in protected memory this can happen arbitrarily.
> >
> > To avoid relocating U-Boot, I had OR'ed GD_FLG_SKIP_RELOC to gd->flags
> > in init_sequence_f -> mach_cpu_init(). Hope that is the right place and
> > way to do it.

Looking at it a bit more, doing it there seems correct.  This will
skip relocation in board_f functions

>
> I'll have a look at the relocation stuff, but off the top of my head,
> I don't remember.
>
> >
> > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > ---
> > > >  common/board_r.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/common/board_r.c b/common/board_r.c
> > > > index 179259b00de..1dd3b96c2de 100644
> > > > --- a/common/board_r.c
> > > > +++ b/common/board_r.c
> > > > @@ -169,7 +169,8 @@ static int initr_reloc_global_data(void)
> > > >          */
> > > >         efi_save_gd();
> > > >
> > > > -       efi_runtime_relocate(gd->relocaddr, NULL);
> > > > +       if (!(gd->flags & GD_FLG_SKIP_RELOC))
> > > > +               efi_runtime_relocate(gd->relocaddr, NULL);
> > >
> > > Have you tested booting with EFI with this change?
> >
> > Yes, tested this with both GD_FLG_SKIP_RELOC set and not set.
> >
> > Used the command 'bootefi bootmgr' and Linux is able to boot.
>
> Have you tried to call any runtime services -- e.g efival -l will dump
> all the EFI variables

The efi runtime relocation data are not in rela.dyn, that data is in
.efi_runtime_rel. I don't know why we relocate runtime services later
than the initial relocation code, but skipping them here seems
correct.

Heinrich?

Thanks
/Ilias

>
> Thanks
> /Ilias
> >
> > Thanks
> > Varada
