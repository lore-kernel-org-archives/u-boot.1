Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0016C36011
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 21:23:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41883806FC;
	Thu, 27 Mar 2025 22:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QHERZRZE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA8D08070C; Thu, 27 Mar 2025 22:23:38 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35141805C8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 22:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e6582542952so1115554276.3
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 14:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743110615; x=1743715415; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CT30prIL23JvwhfsO/85j3F6HB0ei7Mr5vJoJ+6TiRI=;
 b=QHERZRZELwwN+GPW4oNpVfFPwmouJtaDHt+EaowQOuAtGfFsmKhA+NmV0tUze5p2A0
 iSd6uShbw8CDi1QfG1Uk0zNt4H3G4a/un2WxWf0hc1DZwWegAyoyVHhD+GoikKfpkzKW
 2jj3FXpP/zjZC+GfqeJt9cSVa9WuLKbrZhaMRGfOm1tQuCloJNWEt0M4sVVgtWLaEryZ
 ovmuVOFo8j56wQmiKpNo7ZxpaghSvffSrFzm1IztRgjyWE7Q6w096dldUdK8ebMqlIrg
 CnEJrY2KzFOSq4UgDqDk7MG/RL0WYUOqpPXRNgufLyZpf1FV9punBeNEnW1aeKcejWXZ
 SjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743110615; x=1743715415;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CT30prIL23JvwhfsO/85j3F6HB0ei7Mr5vJoJ+6TiRI=;
 b=kPqRzw3UAn9m/rGk5IxYQ8ccgJfZo6Ri1HSIGtQlh7ljiDXHHY7nH5aS2Qcn0h7Eis
 FoI2ppgQzb7cdXNqHnay7bf+bKloAZrMpiRLcOakPZ6tNqCIoNJwYsew8Hm1EKTyMgkA
 gCMRxbto1LR95/pQ8oHWSQCq4hdEttBhg7rIef4bk1zqv4IP1RqZUzIVkq2q/f0ilWLu
 ORvJWpitJ6up47p9mHIi60A/LTg3Sin8b4rL8zM7oaOG1TlzGb3W5vLy0j2GMlzSVxXb
 CUq9IBQUrqjmS5po586vjRUaNxaVZ+LNTR2xY+2svXqC5fbO+2cw9N31afVFJcs3KQrz
 pqbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1kF3FZ9hUlA68iesyLs2IpxbrDfVjewM4+kWOeF+NnlYfX00V+lgygfcEIvbnlshCCOQODnY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1CdFxlUJ+bFz4mcKMbuZu348Oc/6r161jNLaEDQmk6xNdxTsq
 1GrXThJl24TowNQ5DF6WD/3ZsMrdc/k97AJudQYDcxxCF0oJaBen8HCHTbH2u7b49q36ZlDV47q
 PiZLpCoQTG96eECfob7l6vbBy0YSbHX9HUwrGYg==
X-Gm-Gg: ASbGncsxJO6rdjzZ0I3EymHbfEaDu+Hn2Bo4Ktay62dvH0rrHj6ePZIJvsdzxR7CkVA
 lIzG+61RsMa4wJ4A3uDH6H0CxflPS9DwXSQHYKPWbLJAf1jcPZjnzdsT8sYCSyKr/dfJbgPPt50
 PDdEgQVYpvO+J9Xq6AqIuAbQGW
X-Google-Smtp-Source: AGHT+IEauLiwZ98xJLOd1tHbme8LrV0MrWrxiVNOdXEUukzFRNr4z6LbCz3J7Jvzpfl4PvwFFbCG8pOO7651U0XgH68=
X-Received: by 2002:a05:6902:2806:b0:e61:146f:9408 with SMTP id
 3f1490d57ef6-e69437a605amr6145794276.42.1743110614887; Thu, 27 Mar 2025
 14:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250326054653.273906-1-quic_varada@quicinc.com>
 <CAC_iWj+MPcOcuhM1vcHyXYUF7O7U_y8+KKMZJszTK2aqfgfHZg@mail.gmail.com>
 <Z+TsLpAGAIezgPZS@hu-varada-blr.qualcomm.com>
In-Reply-To: <Z+TsLpAGAIezgPZS@hu-varada-blr.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 27 Mar 2025 23:22:58 +0200
X-Gm-Features: AQ5f1JoruL44JCMGlPXJ-oYWOjTN4bBCNefaKg1hSE-b4O9YC9Z3X-XemKJrTwg
Message-ID: <CAC_iWjKyyOHCU2xv-x9BW9w7GtY8ohupxNKTTJC0V91dfPwy8Q@mail.gmail.com>
Subject: Re: [PATCH v1] efi_loader: Handle GD_FLG_SKIP_RELOC
To: Varadarajan Narayanan <quic_varada@quicinc.com>
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

On Thu, 27 Mar 2025 at 08:12, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> On Wed, Mar 26, 2025 at 09:28:04AM +0200, Ilias Apalodimas wrote:
> > Hi Varadarajan
> >
> > On Wed, 26 Mar 2025 at 07:47, Varadarajan Narayanan
> > <quic_varada@quicinc.com> wrote:
> > >
> > > If the EFI runtime services pointers are relocated even though
> > > relocation is skipped, it corrupts some other data resulting in some
> > > unexpected behaviour.
> > >
> > > In this specific case, it overwrote some page table entries resulting in
> > > the device memory address range's mappings getting removed. Eventually,
> > > after the completion of efi_runtime_relocate(), when a driver tries to
> > > access its device's registers it crashes since the mappings are absent.
> >
> > How were those page table entries added?
>
> initr_caches ->
>         enable_caches ->
>                 setup_pgtables (arch/arm/mach-snapdragon/board.c)
>
> > The runtime service relocation might have overwritten those now, but
> > since they are not in protected memory this can happen arbitrarily.
>
> To avoid relocating U-Boot, I had OR'ed GD_FLG_SKIP_RELOC to gd->flags
> in init_sequence_f -> mach_cpu_init(). Hope that is the right place and
> way to do it.

I'll have a look at the relocation stuff, but off the top of my head,
I don't remember.

>
> > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > ---
> > >  common/board_r.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/common/board_r.c b/common/board_r.c
> > > index 179259b00de..1dd3b96c2de 100644
> > > --- a/common/board_r.c
> > > +++ b/common/board_r.c
> > > @@ -169,7 +169,8 @@ static int initr_reloc_global_data(void)
> > >          */
> > >         efi_save_gd();
> > >
> > > -       efi_runtime_relocate(gd->relocaddr, NULL);
> > > +       if (!(gd->flags & GD_FLG_SKIP_RELOC))
> > > +               efi_runtime_relocate(gd->relocaddr, NULL);
> >
> > Have you tested booting with EFI with this change?
>
> Yes, tested this with both GD_FLG_SKIP_RELOC set and not set.
>
> Used the command 'bootefi bootmgr' and Linux is able to boot.

Have you tried to call any runtime services -- e.g efival -l will dump
all the EFI variables

Thanks
/Ilias
>
> Thanks
> Varada
