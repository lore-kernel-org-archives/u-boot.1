Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508F6D5B16F
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 08:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD96688EF5;
	Tue, 29 Oct 2024 09:49:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VoKaHkuq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4305489070; Tue, 29 Oct 2024 09:49:12 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00D0088BB7
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 09:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7ea6a4f287bso3289855a12.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 01:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730191748; x=1730796548; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NMUUqN/x7P2uN2ULMTJJp7PZMiznkY1FrpaFz4UOQuI=;
 b=VoKaHkuqM58XEwxVwb2LSPe76ES+ft4RKwUNOFPZuDCAl3YYdvm1Xl2YToB1uvC2sf
 n0FPtPqwCJFZf91+/9LWbXGRWf493gbJ6A295oyHZu3YzyDlV65lJS3JpadGerJyPwVw
 jDgJtg7hU8iluk/2gf+C1IybXrv+W4itWf/lRo6Fnwg0WZj5nJhNTZzKRmrmoo5p4Gk3
 w4iefkkQfVj/pvFqh0VVSevJI6PR5wysgoROhbU2KekC60XFcVCjSmKrOJz82ZLdYsrN
 oiF+8g82cwlqfdv623SMiiOA1KJ6uANcKv3DM7HzmAaLAXjcSl6si59J1XU1MLaCxRgV
 Q2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730191748; x=1730796548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NMUUqN/x7P2uN2ULMTJJp7PZMiznkY1FrpaFz4UOQuI=;
 b=l4Y0NIA341FTFGpW3PzVbj1C/HhibmqHSmBrhwUjgHpD2esDKBftd/FGcXAjVBNfXS
 Jt3QK9/dBMUW0krdqGMbiFaZbuC0TRHntFOiNTHqw2LFSBNQuTLxqyKz/pMKpmpGpxbq
 wrS6gvSeQZ4PDJtkt3q/h8JO9GGPxi4xvJ4hBe6wcH1SaZkOM38WEdCK8VnOCt2tQo03
 kus1JsDULHSSHnPMyAwdtngD4epgHae+cS9jnq5Q+VtD9xlNCn9l9C1iJWrFXOzkMSh0
 w21GOE3j0xUmixe0YgCtJYZqd6ssw6XLDAh7qQ94G/NNImC/dPMD4QW/K9jWvP9VFP+I
 toRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCTHEyU6DbNaJgqofh9R/U3Fy+shwZ2TKN+UzRq2xwDtpHh2riPEx/RCRnseWPjtJew40f1kw=@lists.denx.de
X-Gm-Message-State: AOJu0YzV3R5dfAbkLrkqprTEF+ojSALUYNQryjeF8bSYqiizeRRtUFcb
 39dl7vMlpDy43VFXQDabJSQ+jrJBxmyztazUVayzVJgBURtdX7HgwTjpLaWyFsuWk8BpU0zmp9Z
 RNHGBD240XYSa8PtF101ULM6bJmWnVthnXOXBuA==
X-Google-Smtp-Source: AGHT+IHb0mlq3VjMXNh5qcM+v1v0ZaFiHNTaGHFevyNeGGH6qnVyOhnZwVXEY1M8XZnemxCDX5y3AEMk15q/amzfbUM=
X-Received: by 2002:a05:6a20:d528:b0:1d9:f95:9f97 with SMTP id
 adf61e73a8af0-1d9a83c22b1mr13265327637.16.1730191748530; Tue, 29 Oct 2024
 01:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20241024104625.1340355-1-ilias.apalodimas@linaro.org>
 <06be7096-2e06-44d6-ba00-55ea578121d8@gmx.de>
 <CAC_iWjJdsJLT6arwynmVx5_fTeOr6rZkp8+AdA1rx_zG6Jandw@mail.gmail.com>
In-Reply-To: <CAC_iWjJdsJLT6arwynmVx5_fTeOr6rZkp8+AdA1rx_zG6Jandw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 29 Oct 2024 10:48:32 +0200
Message-ID: <CAC_iWjLctP3DuuB8brYUMuhDBwuzpMw6CZ-dhbuaRrSk3O5BYg@mail.gmail.com>
Subject: Re: [PATCH] lmb: Correctly unmap memory after notifications
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

Hi Heinrich

On Tue, 29 Oct 2024 at 10:00, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Heinrich
>
> On Mon, 28 Oct 2024 at 08:37, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 10/24/24 12:46, Ilias Apalodimas wrote:
> > > We never unmap the memory used to update the EFI memory map after
> > > notifications
> > >
> > > Fixes: commit 2f6191526a13 ("lmb: notify of any changes to the LMB memory map")
> > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > ---
> > >   lib/lmb.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > >
> > > diff --git a/lib/lmb.c b/lib/lmb.c
> > > index 890e2cbfdf6b..38c6e1d5ba8d 100644
> > > --- a/lib/lmb.c
> > > +++ b/lib/lmb.c
> > > @@ -65,6 +65,7 @@ static int __maybe_unused lmb_map_update_notify(phys_addr_t addr,
> > >                       status & ~EFI_ERROR_MASK);
> > >               return -1;
> > >       }
> > > +     unmap_sysmem((void *)(uintptr_t)efi_addr);
> >
> > If PCI memory was ever mapped via pci_map_physmem(), I don't think that
> > we want to unmap it here.
>
> Ok, so looking at it again, not calling unmap_sysmem() here won't
> break anything, so I guess we can drop this patch.

Looking at it again, for special sandbox tags, we need to correctly
decrease the refcnt. So why do you think this isnt needed here?

Thanks
/Ilias
>
> >
> > Why do we map the memory in this notification function first hand?
>
> Because the memory was added as such in efi_allocate_pages(). So for
> sandbox we need to find the correct virtual memory that was added.
>
> > Can't
> > we use len = 0 when calling map_sysmem()?
>
> We are using len = 0. But I am not following up on how could this
> help. All you will get is a warning for sanbox if a pci device mapped
> more that 0.
>
> Thanks
> /Ilias
>
> >
> > I guess we have to critically review all map_sysmem() calls.
> >
> > Best regards
> >
> > Heinrich
> >
> > >
> > >       return 0;
> > >   }
> >
