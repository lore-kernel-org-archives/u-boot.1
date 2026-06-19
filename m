Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B73FCD98F0
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 03:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FE4384874;
	Fri, 19 Jun 2026 05:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="k5W2/DLP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 095C78499C; Fri, 19 Jun 2026 03:49:36 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 854D2847C3
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 03:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0C91E3F5D0
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 01:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1781833773;
 bh=r5nufZtAX3yj+YgI6yypYcDMs+uhMFMGWsq8g2CluTQ=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=k5W2/DLPm7w/mrOXfbTXx8xJtFVa1T4CrGQ62nkiOs+ImvwifD92SJj1bQ/2LxscX
 Q2n2MNBRFLPcarVSaq6OkBwpq3kMya7+E7yPdz14zjPGhDd41tiBnDzn9TD4wEEWCI
 5t00jfV+j56tjQe/52Np00lGOCet6fRfRVfuS9UIBrjtLfyll8E1/Hi88FScA+yoyc
 Jh9l4UYQz6MAj2o1w+d+gkIJkYHDwTA7ayKHd5cQShrrlhGzJIZaEQWZj1HcqtXGRI
 LVT2rJr31Qa5eUY6atIAmPz2eWjiT3ICWlIi4mmBdD6obd1FrO8NGRHFR3tOhBJC0P
 xr2He8uBKW4v0EQTcluZcGTRF/NO4uC0ug598VXiW+4TqutA4baMS4waatBBxzXshm
 a4ZYB3sqSumIhMU3cnj/Wk0FAR8L/PIv4xJbgNRdcYzGk5gmZC2AUWO+UQOpMNwiZe
 VFlL9hdl1BoQN03W1TAmIdnWOA6ubVOvHGhKHIhawAfPiJrhujW3keCHWy1/uSdT1F
 xymwiWPg6nk03xShN1BBdXrbcP6QVlHGo6uQGX3HO6E2oZnFl8haKM99JP+DSF9e9X
 2a5rzyZNCX8i/afNlMXZRqN8IQfPf+gHc0x0rjxnCXo1kNdR/iBtJlh2XduvxMIEEM
 eIcAI67i2tvA/2981cvP/TbM=
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6954c28316cso1249173a12.1
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 18:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781833772; cv=none;
 d=google.com; s=arc-20240605;
 b=S1oJMtrf4BWwHSmWR8AnonnbbXKeejkoOMAh+ZKKScMFV26rmOsJN6HZ360afsh5br
 ahzePYgYn2Q2SyBK7GjIB09TGLcqS16eWGmg8UK8jXAxcddQtviz3KAXjXU5nklkqDh9
 mopHs/vf/MMvxQnyJbaV2U05SYB7R0VMNxXVSmEZdaJdPSi4d/4kYnYEQZtW2spzryk2
 OAcUGb5Gr0VoGF6CsNqTpv26o4db4PHutQPVgqaKSuQYsFPloeLQAynS5ICetg9vM35g
 J3U7fIsOyAV39iWlyg9dcxoG3W4Nslozyq2r8bU8BP4z2TpdMfW5t5ANnSb1g+hOmerk
 5JGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=r5nufZtAX3yj+YgI6yypYcDMs+uhMFMGWsq8g2CluTQ=;
 fh=10QzhohGSOy7HoLOFoKbMs02HANOUw65j+xbl1OQEDg=;
 b=hMpun5SpMRw9D/QjHGJa0c8JH4kUtaPi8XjtoHHSwCVqMRWHmY3Z2tmkw/y29mZ46o
 j5f6fh4UxFKISLryQa0sbkPPwCOuNob5b1StQEvecwvI6IIsUWSCOL8b1BYeb+HrMDp4
 O0Di7FutY2m5ZV/pmmALGkiRNw3Oymg1KYK4tpCK3j1DrZu8jd8bA4+c54HYRjGoKu7D
 2cf9nibmQD+C8i+WurMn8o0ziIAGKZEJBaADt0Zz019x8gKB9frsvrMDtu9BxZbfkALf
 k5nM6idPREjYn55r4h3mDIkpoEOJRzjbGf3bI+HSH/LBdZAOHjkr0kGaAJMl2AVjRNys
 1fTA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781833772; x=1782438572;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r5nufZtAX3yj+YgI6yypYcDMs+uhMFMGWsq8g2CluTQ=;
 b=YMXgBa0DoyYEBQm7YZLzPi2dMp1wGetaHvMiOyBjD47817o2EjxxWMJ1/FNRAeeDkv
 5J1cibnoNd63+249FdSbT/CSMJNNHup3nl1e1SskRKICASapjF6ckCedd5mi2HegPJkK
 +i7NkF5O1szK7vOXOWEpoOdmW+zXFG81MlHhbmijAkecw+vsTkWOHddgzav8Kev9CqhB
 FIBe90k/aZp+V9dNsx803QhIqpCM5tpA7SgS5epnwj8nILj3srcR03M4m/vUbEsA9R9X
 BVA0ipfAIpwOI8VR2bgbscESvwnQve7XncbBVFyCXW3wB7gk2DNwJbk7ClhtYkElm6jz
 LaBg==
X-Gm-Message-State: AOJu0Yy03PG1ulCsHnOMHqdVklOaw1ZWs+X7jE2pRPYxODefeFlrEG4M
 jyEqxBZszWM7NLuxShjYh7q1RtNMNzEHIrzcpOUVXOz+KSJQFM7vUmepda4dFvyTEwTDtCQfZK6
 6SlR8/WrrEfM6WjTKMiJgbTvlPANY/kmJxG9jJ1CgILeeyoqsTsd9yl2os/ZDgjCKf/hKU/M35h
 t6ACXhN1awTVMWhOMDbSZJKHbR0MTzrGW9sJlSJkSmd9UyLg==
X-Gm-Gg: AfdE7cnDvv5ql0BSAWHpybZRdMzSHh5yZpmMwaHR2YmzAONBeuEgc4dlv9htx2Qevvg
 sJ8VG1HJqC52A6Y4KxZhnymKcklxrUF/lH4/ufCAnlGMPEjFPcropgXSZXuMGesGEghxSwSiiU/
 tRNW3g7k2g4owTIdBfn3ns5CfBAvlwMIs0t43SMg0bjq+eERbJAQb130Z5hXh0bFxsgTw=
X-Received: by 2002:a05:6402:1f90:b0:691:7054:8c6b with SMTP id
 4fb4d7f45d1cf-6975688dcb6mr88474a12.19.1781833772602; 
 Thu, 18 Jun 2026 18:49:32 -0700 (PDT)
X-Received: by 2002:a05:6402:1f90:b0:691:7054:8c6b with SMTP id
 4fb4d7f45d1cf-6975688dcb6mr88459a12.19.1781833772183; Thu, 18 Jun 2026
 18:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260524151431.72296-1-aristo.chen@canonical.com>
 <CAFLszTitaXsCZn1e45m+Wn0v0=mD5LVdpb3vtZJZgcvGr8yqGw@mail.gmail.com>
 <CAA=k7=k5NjdPEV6jVtxWBhVuL602J7eFP7TLM6aQtL+mKyVT9A@mail.gmail.com>
 <CAFLszTiBWAwqGnBnGFZdBqcLbYs+=yiQws4dFw3HPBGEYQGSeg@mail.gmail.com>
In-Reply-To: <CAFLszTiBWAwqGnBnGFZdBqcLbYs+=yiQws4dFw3HPBGEYQGSeg@mail.gmail.com>
From: Aristo Chen <aristo.chen@canonical.com>
Date: Fri, 19 Jun 2026 09:49:21 +0800
X-Gm-Features: AVVi8CcMSo2OovbaOEEvXIqh3uP5QLAX3yvGrKHFa-t5uSbX2hkOyvUff2p4h-w
Message-ID: <CAA=k7==Ze=_xBrX-Z0vBt5GG6P=Ha6hJhaeedFgsOsrE-bfVnA@mail.gmail.com>
Subject: Re: [PATCH v1] bootm: bound-check OS index in bootm_os_get_boot_func()
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 19 Jun 2026 05:07:13 +0200
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

Hi Simon,

On Thu, Jun 18, 2026 at 9:25=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Aristo,
>
> On Tue, 16 Jun 2026 at 11:02, Aristo Chen <aristo.chen@canonical.com> wro=
te:
> >
> > Hi Simon,
> >
> > On Sat, Jun 13, 2026 at 2:22=E2=80=AFAM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Aristo,
> > >
> > > On Sun, 24 May 2026 at 17:11, Aristo Chen <aristo.chen@canonical.com>=
 wrote:
> > > >
> > > > The boot_os[] table in bootm_os.c is a sparse array whose compile-t=
ime
> > > > size is set by its largest designated initializer (IH_OS_ELF), givi=
ng
> > > > it IH_OS_ELF + 1 entries. The accessor bootm_os_get_boot_func() ret=
urns
> > > > boot_os[os] without any bound check, even though the caller in
> > > > bootm_run_states() passes images->os.os straight through. That fiel=
d is
> > > > populated by image_get_os() from the raw 8-bit ih_os byte of a lega=
cy
> > > > uImage, and by fit_image_get_os() for a FIT, neither of which clamp=
s
> > > > the value against the table size.
> > > >
> > > > An attacker-supplied image whose OS field falls outside the populat=
ed
> > > > range therefore drives an out-of-bounds read of boot_os[]. The call=
er
> > > > only rejects a NULL return, so a non-NULL adjacent global is accept=
ed
> > > > as a valid handler and invoked through the indirect call in
> > > > boot_selected_os(), turning an unsigned image with a malformed head=
er
> > > > into a jump through an attacker-influenced function pointer. FIT
> > > > signature verification covers the os property and mitigates this pa=
th
> > > > for signed images, but legacy bootm and unsigned FIT do not.
> > > >
> > > > Reject out-of-range indices in bootm_os_get_boot_func() so the exis=
ting
> > > > NULL handling in bootm_run_states() reports an unsupported OS and
> > > > declines to boot the image.
> > > >
> > > > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> > > > ---
> > > >  boot/bootm_os.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > >
> > > I would rather put this check earlier and only for legacy images, to
> > > reduce code size. For FIT I believe this cannot happen, right?
> >
> > Yes, you're right, FIT can't reach this. boot_get_kernel() loads the
> > kernel via fit_image_load() with IH_TYPE_KERNEL, and the os_ok check
> > there already rejects any image whose os isn't a known type before
> > bootm_find_os() reads it, so images.os.os is always in range. Only the
> > legacy path takes the raw ih_os byte unchecked.
> >
> > I'd lean toward keeping the test in bootm_os_get_boot_func() since it
> > sits right at the boot_os[] dereference that every caller goes
> > through, and the cost is just a couple of instructions in
> > CONFIG_CMD_BOOTM code (not SPL). But if you'd prefer it scoped to the
> > legacy path, I'm happy to send a follow-up moving it there.
>
> Actually I do think putting it there is better, since adding a check
> for the FIT case is actually confusing - the check can never fail! So
> let's deal with this problem in the legacy code, so as to avoid it
> bleeding into the FIT code.

Sure, I will send a follow up patch for this.

>
> >
> > >
> > > >
> > > > diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> > > > index ae20b555f5c..69aa577a2fc 100644
> > > > --- a/boot/bootm_os.c
> > > > +++ b/boot/bootm_os.c
> > > > @@ -599,5 +599,7 @@ int boot_selected_os(int state, struct bootm_in=
fo *bmi, boot_os_fn *boot_fn)
> > > >
> > > >  boot_os_fn *bootm_os_get_boot_func(int os)
> > > >  {
> > > > +       if (os < 0 || os >=3D ARRAY_SIZE(boot_os))
> > > > +               return NULL;
> > > >         return boot_os[os];
> > > >  }
> > > > --
> > > > 2.43.0
> > > >
>
> Regards,
> Simon

Best regards,
Aristo
