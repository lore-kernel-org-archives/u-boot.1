Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C47C0219D
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 13:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACB23803CC;
	Tue, 11 Feb 2025 14:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dkM6tzOY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2CC88043C; Tue, 11 Feb 2025 14:41:26 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57EB380077
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 14:41:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e5b32f64ffeso4582946276.3
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 05:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739281283; x=1739886083; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eqd44396MKpahMDlfpnyun/oIEwCMcAKXTdcBVvLDEw=;
 b=dkM6tzOYPLoPEbkQZVhTYijULUOqgXU2uEUMgS6Qc5o1ZUlRoVTvm58TuGdTRRANp9
 Ux8S/7dPGBaceRyymU0L4/V/zLyd396h1HJVm9zYdC2qWBTTW00DVPjJR8mTnOobrQsf
 cvIYUdjkH4+YThxaVSVlrblWWmRgMfBroJ4P6QWPlBVesCJd0XnuzRHcobGjX+Ll8i30
 PzmjFDOUfw3XAGQIfOxAuJqguTSOe1kGl9TOyLWFXgEk2lWGHo4YASGkT0S4jR1+/+X9
 iltexbemgKH4St8Cf9TdgYwrMV11MoT2thau6rmIQL1SA/1wSMeIl1DMWX5qrbeLoxMH
 IoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739281283; x=1739886083;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eqd44396MKpahMDlfpnyun/oIEwCMcAKXTdcBVvLDEw=;
 b=IUM2Jr2laoyentOn5+XiwrIKMXdtqJNeVRMUracDRx161Kxhza45zJfPne/oqgcB/K
 xFAkbROE6cuvRzpEmxKLG3VIAzw1697bhynNBlbO3BADVAiseljMv7M2ywdailzfZDdG
 G5UXmLSrcpWKxfBsUflozZ/57lbu5/n3M5tryCKKjd03oVk09/3Jvgik+fWtuKVCd148
 G947fFVs7Xg7cu+mH4S1IEdZfR/YDz5ixz4/NRFV3VSCwUVT2agDIPFOPCojOP9BQtPd
 43G5Ol8SEvlmvccO+/pGU93/GAllVChcQJyyBedUjc/phCrJ51obE+pMH95QcQ6esLND
 /pYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX3j//1YfwHk1qvFDyIjQMvoy9GNQDwwRbF/3o0CF1IWXRypLcVyJoUqp0/ejbzr6VZIWN/6c=@lists.denx.de
X-Gm-Message-State: AOJu0YymvsQ4qBOyseapIRVj8fO9nLAxnGvoOqfdP+vH7AdnS5ObyYP2
 AffT16OibplwzgXRJ9gJcdjYIngjutQRuRyn/a0zmC7BOXwI6Kskl4YNu5Vro9w4LHxhwu4M5PC
 ZmZtSMd3qcKRDOEUy1nV/kftThYK3PnSsnzUu+w==
X-Gm-Gg: ASbGncsCYuw0GMhgF1W7YNyxyqgdpxDD/G4AM2D9+horRS8+PC+vBkOcqBXcCWektw2
 4mDCC6ZSEosCucnipPoTsJW8fiBQ5Sqrbs3apWanhOfohp0Eg2+fdkfI6ZUenV6S3XCRSoSAN9m
 E=
X-Google-Smtp-Source: AGHT+IEAF2noq6dlaSd0bLlrERsz8sW0NRUR8nA6mBgULtidPwdD65Jqe30OiiVZR8x9SX+Bcb0MJQHbC+PTsVafkVI=
X-Received: by 2002:a05:6902:2185:b0:e5b:3e10:14f2 with SMTP id
 3f1490d57ef6-e5b46283135mr13972094276.43.1739281283077; Tue, 11 Feb 2025
 05:41:23 -0800 (PST)
MIME-Version: 1.0
References: <20250211094942.36162-1-ilias.apalodimas@linaro.org>
 <87tt90ss3v.fsf@bloch.sibelius.xs4all.nl>
 <CAC_iWjKK5qBz8-jZ6QOOYfoGJf1DM4P_1VqmWRD0k91UJx8JZQ@mail.gmail.com>
 <87seoksq2z.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87seoksq2z.fsf@bloch.sibelius.xs4all.nl>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Feb 2025 13:40:47 +0000
X-Gm-Features: AWEUYZkXSN0coYv15IgGOXErUDn3Oh4dkV0n4_CpWkESa1Renrr-uyVGJn4s1UE
Message-ID: <CAC_iWjLEFBFunYNYyzbvGso81=VnTJqGY=M895Pjzdvi--GBGw@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: remove comparisons to string literals from
 runtime
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: heinrich.schuchardt@canonical.com, xypron.glpk@gmx.de, trini@konsulko.com, 
 u-boot@lists.denx.de
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

On Tue, 11 Feb 2025 at 11:01, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Date: Tue, 11 Feb 2025 10:50:01 +0000
> >
> > Hi Mark,
> >
> > On Tue, 11 Feb 2025 at 10:17, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> > >
> > > > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > >
> > > > On EFI runtime services, we manage to preserve string literals
> > > > by placing the .efi_runtime section just before .data and preserving
> > > > it when fixing up the runtime memory by marking surrounding boottime
> > > > code as runtime. This is ok for now but will break if we update any
> > > > linker scripts and decouple .text and .runtime sections.
> > > >
> > > > So let's define the strings we used to compare in the stack for
> > > > runtime services
> > >
> > > I don't see how this helps you.  Those string literals still need to
> > > be copied into the stack variable from somewhere and I don't think
> > > that with this changes where that source string literal lives...
> > >
> > > I think you need toput the string in a global variable with an
> > > appropriate __attribute__ that puts it into .runtime.
> >
> > The asm I am seeing is setting this up on the stack
> >
> >   c29c0:       d2800ac1        mov     x1, #0x56                       // #86
> > {
> >    c29c4:       a9ba7bfd        stp     x29, x30, [sp, #-96]!
> >         const u16 t[] = u"VarToFile";
> >    c29c8:       f2a00c21        movk    x1, #0x61, lsl #16
> >    c29cc:       f2c00e41        movk    x1, #0x72, lsl #32
> > {
> >    c29d0:       910003fd        mov     x29, sp
> >         const u16 t[] = u"VarToFile";
> >    c29d4:       f2e00a81        movk    x1, #0x54, lsl #48
> >    c29d8:       f90027e1        str     x1, [sp, #72]
> >    c29dc:       d2800de1        mov     x1, #0x6f                       // #111
> > {
> >    c29e0:       a90153f3        stp     x19, x20, [sp, #16]
> >         const u16 t[] = u"VarToFile";
> >    c29e4:       f2a008c1        movk    x1, #0x46, lsl #16
> >    c29e8:       f2c00d21        movk    x1, #0x69, lsl #32
> > {
> >    c29ec:       a9025bf5        stp     x21, x22, [sp, #32]
> >         const u16 t[] = u"VarToFile";
> >    c29f0:       f2e00d81        movk    x1, #0x6c, lsl #48
> > {
> >    c29f4:       f9001bf7        str     x23, [sp, #48]
> >         const u16 t[] = u"VarToFile";
> >    c29f8:       f9002be1        str     x1, [sp, #80]
> >    c29fc:       52800ca1        mov     w1, #0x65                       // #101
> >    c2a00:       b9005be1        str     w1, [sp, #88]
> >         if (!variable_name || !vendor || !data_size)
> >
>
> Oh clever!  It basically uses a bunch of mov instructions to create
> the string on the stack.

Yep, but this is just me saying "I tested it before posting it!".
We do need to make this arch agnostic.

> > While the older code is doing
> >
> >   if (!u16_strcmp(variable_name, u"VarToFile"))
> >      a88:       90000001        adrp    x1, 0 <__image_copy_start>
> >
> >
> > But I think that's very arm and compiler-specific, so I'll change it
> > to what you and Heinrich suggested
>
> Possibly even depends on the optimization options you use.

PIE perhaps?

Anyway. I'll wait a day or two in case anyone else has comments and send a v2

Thanks for taking a look
/Ilias
>  And it
> would almost certainly not do this if the string was longer.  So yes,
> Heinrich's suggestion is probably the way to go.
>
> >
> > Thanks
> > /Ilias
> > >
> > > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > ---
> > > >  lib/efi_loader/efi_var_mem.c      | 3 ++-
> > > >  lib/efi_loader/efi_variable_tee.c | 3 ++-
> > > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
> > > > index b265d95dd6ba..985e0baa128d 100644
> > > > --- a/lib/efi_loader/efi_var_mem.c
> > > > +++ b/lib/efi_loader/efi_var_mem.c
> > > > @@ -310,6 +310,7 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
> > > >  {
> > > >       efi_uintn_t old_size;
> > > >       struct efi_var_entry *var;
> > > > +     u16 vtf[] = u"VarToFile";
> > > >       u16 *pdata;
> > > >
> > > >       if (!variable_name || !vendor || !data_size)
> > > > @@ -331,7 +332,7 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
> > > >       if (timep)
> > > >               *timep = var->time;
> > > >
> > > > -     if (!u16_strcmp(variable_name, u"VarToFile"))
> > > > +     if (!u16_strcmp(variable_name, vtf))
> > > >               return efi_var_collect_mem(data, data_size, EFI_VARIABLE_NON_VOLATILE);
> > > >
> > > >       old_size = *data_size;
> > > > diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> > > > index 0d090d051dd4..8d173e58d2f7 100644
> > > > --- a/lib/efi_loader/efi_variable_tee.c
> > > > +++ b/lib/efi_loader/efi_variable_tee.c
> > > > @@ -780,6 +780,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
> > > >       efi_uintn_t payload_size;
> > > >       efi_uintn_t name_size;
> > > >       u8 *comm_buf = NULL;
> > > > +     u16 pk[] = u"PK";
> > > >       bool ro;
> > > >
> > > >       if (!variable_name || variable_name[0] == 0 || !vendor) {
> > > > @@ -858,7 +859,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
> > > >       if (alt_ret != EFI_SUCCESS)
> > > >               goto out;
> > > >
> > > > -     if (!u16_strcmp(variable_name, u"PK"))
> > > > +     if (!u16_strcmp(variable_name, pk))
> > > >               alt_ret = efi_init_secure_state();
> > > >  out:
> > > >       free(comm_buf);
> > > > --
> > > > 2.43.0
> > > >
> > > >
> >
