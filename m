Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9FDC41535
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 19:52:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B915E8782C;
	Wed, 13 Dec 2023 20:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aMNuH0ms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFA8F87823; Wed, 13 Dec 2023 20:51:26 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFA0B87807
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 20:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-dbcdde08dc1so420794276.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 11:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702497081; x=1703101881; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UzWsefoOliTfCRfMDUPxs/Yn0fvjr9H5EdJ0PX9QZfc=;
 b=aMNuH0msemXklNxU5Usctxxg9t4zdZKJn5YvOTyvWEbmVpCmmOwALADuoTMdc+WWZd
 +7P1OlvWkTLqgXSHK5jokZT8mAmED17GHMItqoGZlWZdKYx6sFG7k0dVIiE7J50l4oXf
 Dz7b/MbbyPm23DRAI+UzNPcI8HxTp4fWBEbFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702497081; x=1703101881;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UzWsefoOliTfCRfMDUPxs/Yn0fvjr9H5EdJ0PX9QZfc=;
 b=facxubWYIbr5oMj7EA//wsNIlel2yHIYvm6ewjPwvwS+aXWrLM7+yWKQGwdav1ttp/
 ualcGm++U/BO66sSjZHNJQ8HwJQCM9wXI0sD10p3YMl3kEhgsOurffqdCYRyP97VThyg
 8HKfYhanKZpb95AklHD7Rl1Iuz1uXb9ZDgLpJtVsEJk7fzgCC6kjDsRVc9RNTdgfzb4Q
 OqXbEryR4NML+oKVyNekKji3KtnODIX3blKHA78WPLFiLFF7e0QH3k0oOWSoFhf9YVap
 qc+ku05b6A2rqUMZrpXbBKPrbDQKV+rYZm4K8u5yTf4eT/j24bh7F10ZJsrhffleFoPj
 JxVw==
X-Gm-Message-State: AOJu0Yyfq0SHl0h8GfT9ntxccD3wPAnrj4MrC6hWTGPHVqJqJ5jx2pmQ
 6M/uuYOUT59+Di26oMAVPHessRwH+HRTsoFxI4N2XCFmJZPNbhXm/NM=
X-Google-Smtp-Source: AGHT+IEZvG0UqJMZnbQTow7o9PQ3hwf442bxIDDc+w2ONgbG0ZcEKlJa7UQdEhIx3yrcNkWzlv59owizDy7oQX+hs/8=
X-Received: by 2002:a05:6902:e01:b0:db5:3a74:a9ac with SMTP id
 df1-20020a0569020e0100b00db53a74a9acmr6511278ybb.18.1702497081292; Wed, 13
 Dec 2023 11:51:21 -0800 (PST)
MIME-Version: 1.0
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2PtQQ81x-SqMs6NKSjMKFGShT65Rrtfc-CDOsdBxgJDQ@mail.gmail.com>
 <CAC_iWjJ52eK-v30T6XC1jHDDLvcuOX0p43PW8UCfakRPxMkQCw@mail.gmail.com>
 <CAPnjgZ2Ubr6kNfn+7bg+F_CV4H_wZMKaPq8F8njSfQNUF02+iA@mail.gmail.com>
 <CAC_iWj+X9Kw=1YOX0bny01JwkzCSyeZ6PB2-r_V-2TisgVG7WQ@mail.gmail.com>
 <20231209184915.GY2513409@bill-the-cat>
 <CAC_iWjKKG50d5QhUZFLUgxqO+VhgE7bC9Tk_SmCR0x4f3zD74g@mail.gmail.com>
In-Reply-To: <CAC_iWjKKG50d5QhUZFLUgxqO+VhgE7bC9Tk_SmCR0x4f3zD74g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:50:03 -0700
Message-ID: <CAPnjgZ27G=6fDadAiJk_aG9He2ZpyFhhsZDYxUwEp5+0AQatYg@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] smbios: Fallback to the default DT if sysinfo
 nodes are missing
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, sean.anderson@seco.com,
 neil.armstrong@linaro.org, 
 heinrich.schuchardt@canonical.com, mark.kettenis@xs4all.nl, 
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
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

On Mon, 11 Dec 2023 at 00:49, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Tom,
>
> On Sat, 9 Dec 2023 at 20:49, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Dec 06, 2023 at 06:03:14PM +0200, Ilias Apalodimas wrote:
> > > Hi Simon,
> > >
> > > On Sat, 2 Dec 2023 at 20:28, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Wed, 29 Nov 2023 at 23:50, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > [...]
> > > > >
> > > > >> > Changes since v1:
> > > > >> > - Tokenize the DT node entry and use the appropriate value instead of
> > > > >> >   the entire string
> > > > >> > - Removed Peters tested/reviewed-by tags due to the above
> > > > >> >  lib/smbios.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++---
> > > > >> >  1 file changed, 90 insertions(+), 4 deletions(-)
> > > > >> >
> > > > >>
> > > > >> Can this be put behind a Kconfig? It adds quite a bit of code which
> > > > >> punishes those boards which do the right thing.
> > > > >
> > > > >
> > > > > Sure but OTOH the code increase should be really minimal. But I don't mind I can add a Kconfig
> > > > >
> > > > >>
> > > > >> > +
> > > > >> > +       dt_str = ofnode_read_string(ofnode_root(), nprop->dt_str);
> > > > >>
> > > > >> Could this use ofnode_read_string_index() ?
> > > > >
> > > > >
> > > > > Maybe, I'll have a look and change it if that works
> > >
> > > Unless I am missing something this doesn't work.
> > > This is designed to return a string index from a DT property that's defined as
> > > foo_property = "value1", "value2" isn't it?
> > >
> > > The code above is trying to read an existing property (e.g compatible)
> > > and get the string after the comma delimiter.
> > > Perhaps I should add this in drivers/core/ofnode.c instead?
> > >
> > > > >
> > > > > [...]
> > > > >
> > > > >>
> > > > >> Any chance of a test for this code?
> > > > >
> > > > >
> > > > > Sure, but any suggestions on where to add the test?
> > > > > SMBIOS tables are populated on OS booting, do we have a test somewhere that boots an OS?
> > > >
> > > > They are written on startup, right? They should certainly be in place
> > > > before U-Boot enters the command line.
> > >
> > > Not always.  I am not sure if x86 does that, but on the rest of the
> > > architectures, they are only initialized when the efi smbios code
> > > runs. Wasn't this something you were trying to change?
> >
> > One of those things I keep repeating is that we don't know for sure what
> > the right values here are until we load the DT the OS _will_ use. It's
> > quite valid to start U-Boot and pass it a generic "good enough" DT at
> > run time until U-Boot can see (GPIOs, EEPROM, whatever) what it's on and
> > what the real DT to load before passing to the OS is. Since U-Boot
> > doesn't need SMBIOS tables itself, we should make these "late" not
> > "early".
>
> Fair enough, we can defer the init and testing of those late, just
> before we are about to boot. But this is irrelevant to what this patch
> does, can we get the fallback mechanism in first, assuming everyone is
> ok with the patch now?
>

I would like this behind a Kconfig. Making it the default means people
are going to start relying on (in user space) and then discover later
that it is wrong.

Regards,
Simon
