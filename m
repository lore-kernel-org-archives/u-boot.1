Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC207D13572
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 17:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B5188EE3;
	Sun, 27 Oct 2024 18:16:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I/Tqac4A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1E3688FFC; Sun, 27 Oct 2024 18:16:55 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4231388DCC
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 18:16:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cbb6166c06so2729481a12.0
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 10:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730049407; x=1730654207; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ySOngm+bJvpiKOq/AbRnIZAyZAuF/7DG27XF1DjzrMI=;
 b=I/Tqac4ASDvpSnBQPw/MjRdsR8CkNDV7lbEuLrC6+LTFrsGuNIwZYU7v2uLbg5C5nH
 wh6VY0fv/DPVx+wvKvyllEg3BZW3uTh7jjSCmncU0vNav59JASxl/I11aVsj4jsdo+TU
 Q4L6fj8Vd0T5HYpDen1/rsTD8nC3VovoWp8Os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730049407; x=1730654207;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ySOngm+bJvpiKOq/AbRnIZAyZAuF/7DG27XF1DjzrMI=;
 b=Kci9x/ssGj0wRtbEIyigXvueK7EecaSy0e0aToqZfH3V1jgH7v2VkoN+w2eZIAabgT
 ZOkk5A+pJ4+32iUrrD1NEcSL/4PaozF8xg3qDqh4u9KHZpanUkbA0RFehVUdB4bVFMMM
 No8i2skq8Qi7a9XLnBO1HmnuAVc8zw+FlDzVxz6ZVXllEATMRbi1Tle9BLb7xrkaXixx
 Glvn+x9HyHKFdoHddEQ+1O39zjmDjxxcZs6r5pLnGgJK9U/xNXn3JqZBhkynjYaKrKDj
 ac8N4nC3DFS3j3TRINV3idlx7EkL77bhGzQLuCvqe2laHn4bAFA3mqXCGUqrcYBV+x75
 MwDg==
X-Gm-Message-State: AOJu0YziGKIGkoWDnaiWCe7rTHounkbPHZb/PbqXLImg3wHqjdgXH5/z
 pftteXkJSIAPXZ+eVgBv0SLm1+ShqGtI3ng8rL/Z4KRDdIPhOeOAg+N5MuBKE0SFYXIP3K5Xtiu
 nX2cjn8C1Z/70+3mLf7hK6d3Aow1wJv53T33A
X-Google-Smtp-Source: AGHT+IEXHgzDjZJ4Uha3dRAVaxLZDmv0Za+j9PagVrd4cEbgXpWK9mugDyVhisAylKSPCIMg90p/8Y7Q8AQew5iEg1A=
X-Received: by 2002:a17:906:6a1c:b0:a9a:81a3:59bf with SMTP id
 a640c23a62f3a-a9de5f656e6mr657110766b.35.1730049406570; Sun, 27 Oct 2024
 10:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-6-sjg@chromium.org>
 <CAC_iWjKUjsMdqXa2YZGiu1FSsjx_aH6cDQsi+2Ng5i-+9obQhQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKUjsMdqXa2YZGiu1FSsjx_aH6cDQsi+2Ng5i-+9obQhQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Oct 2024 18:16:32 +0100
Message-ID: <CAFLszTgZPQOeyoKuB85Qgu0cSdQ0Upgpk2Q01mmNY4XFgiW43w@mail.gmail.com>
Subject: Re: [PATCH v8 5/8] sandbox: Report host default-filename in native
 mode
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

Hi Ilias, Heinrich,

On Fri, 25 Oct 2024 at 11:57, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
>
> On Tue, 22 Oct 2024 at 15:00, Simon Glass <sjg@chromium.org> wrote:
> >
> > When the --native flag is given, pretend to be running the host
> > architecture rather than sandbox.
> >
> > Add an 'efidebug filename' command to report it.
>
> Heinrich does this allow you to continue your testing in native archs?

Yes, Heinrich seems OK with it.

Separately from this patch, at present something is broken / missing
on x86_64 (with recent QEMU / Tianocore), so I cannot run the tests
with qemu-x86_64 today. It was apparently running OK before the last
EDK II and QEMU updates.

Also sandbox only works with the EFI Self-Certification Test (SCT)
when natively compiled on aarch64 or riscv64[1][2]. There might be
something missing on sandbox x86_64, which gives a segfault when
running InstallX64.efi

I am running these:
ii  ovmf           2024.02-2    all          UEFI firmware for 64-bit
x86 virtual machines
ii  qemu-system-x86 1:8.2.2+ds-0ubuntu1.2 amd64        QEMU full
system emulation binaries (x86)

So far I have not tried going back to older versions.

>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v8:
> > - Add new patch to report host default-filename in native mode
> >
> >  boot/bootmeth_efi.c | 25 ++------------------
> >  boot/efi_fname.c    | 57 +++++++++++++++++++++++++++++++++------------
> >  cmd/efidebug.c      | 25 ++++++++++++++++++++
> >  include/efi.h       | 25 ++++++++++++++++++++
> >  4 files changed, 94 insertions(+), 38 deletions(-)
> >

[..]

> > diff --git a/include/efi.h b/include/efi.h
> > index 1b8093bd4d3..70bb47e742f 100644
> > --- a/include/efi.h
> > +++ b/include/efi.h
> > @@ -678,4 +678,29 @@ void efi_show_tables(struct efi_system_table *systab);
> >   */
> >  const char *efi_get_basename(void);
> >
> > +#ifdef CONFIG_SANDBOX
> > +#include <asm/state.h>
> > +#endif
> > +
> > +static inline bool efi_use_host_arch(void)
> > +{
> > +#ifdef CONFIG_SANDBOX
>
> #if IS_ENABLED(CONFIG_SANDBOX) is preferred no ?

That is more for use with if(), which I cannot use here.

>
> > +       struct sandbox_state *state = state_get_current();
> > +
> > +       return state->native;
> > +#else
> > +       return false;
> > +#endif
> > +}
> > +
[..]

Regards,
Simon

[1] https://github.com/U-Boot-EFI/u-boot-sct-results
[2] https://github.com/xypron/sct_release_test/tree/main
