Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DFBC10F09
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 07:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1611487073;
	Mon, 11 Dec 2023 08:49:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yZS18Zb6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C55558753A; Mon, 11 Dec 2023 08:49:53 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A366686E88
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 08:49:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ca2573d132so51263121fa.0
 for <u-boot@lists.denx.de>; Sun, 10 Dec 2023 23:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702280991; x=1702885791; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tKLMkEq5Wv23an9Jg/27NWEFBf+tp3LJM8uSw6iVOiY=;
 b=yZS18Zb636b8k10as8MORflwSn/DBS1cGeSEdqmuWUXjbyF0w/Zvxf7oENVl+jnVKj
 pQtrSneGwk0uZOa2FqCABFKSfPtNMxiv8toxskPbx9CE8X+89MR3CumbCrCd4hA4VXbx
 2KrPIlsRCx6U58c3H3Ctp9ttTTnhUsKcHmyQl4KdY3PQ43xZkQhds4sp0WSDTxUIueGP
 wlDyGDwgcrNJv3AkhIDs7GBKjm1PxwY8K/gHFLlUdeTkU50AlCtdNqFFdyInyReSiYFZ
 GQqNaek1NTf9G9gw74Z0SmLuaMls355po9IvQCpZTCm5Z49UNDjy6dcip/aIS538K4BA
 5Vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702280991; x=1702885791;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tKLMkEq5Wv23an9Jg/27NWEFBf+tp3LJM8uSw6iVOiY=;
 b=SH9MVFudKDFHMugIumTAbAlCqOt7uO26d1ggJmhgxRgX4qOS2I0/YDTyFjIyZTSlC/
 yE35aN5Yf3HxHXbEbBQ3+8US8Tn6a1m8egWhSyNGxZVjA8wwj7/3MbBQ0zz3+oKa8P2x
 yangvjYh+1bI2T/FZIbt46iiIUPiBP23SeJyTW5cGLo28H1ictOioK+sLoAG+XJVyX6P
 9eUV+OzhpaKjkGfJdUrYKq0YhmmI0nHvtKHiDcbCRyTHvGreIg+1ilMc+asztowL17+l
 DozK4r9gVf4YxN/0+Nyg117+TdDBHjx8C1qavrMUHHNXSBeGX0fVKDF4qeNRv6NK9Xsv
 VZXA==
X-Gm-Message-State: AOJu0Yy3HCRInC7i94OUN+c3bs2FmQfew0bUzjxLz7ySlnpYrLM62kor
 DWCRjtkVkJLPEAQ34P/LPl5n8zSIK0QysdyO7ZMnCw==
X-Google-Smtp-Source: AGHT+IEXJQfUwmr9+2CgDGlxK/GnH9PZzOyC6wRooRnKawEDfyTsi7gSSeSy4E/2GIvAJEw9fzGfbfg7oZFR/zFyayQ=
X-Received: by 2002:a2e:a274:0:b0:2cc:1d2e:9916 with SMTP id
 k20-20020a2ea274000000b002cc1d2e9916mr871389ljm.62.1702280990904; Sun, 10 Dec
 2023 23:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2PtQQ81x-SqMs6NKSjMKFGShT65Rrtfc-CDOsdBxgJDQ@mail.gmail.com>
 <CAC_iWjJ52eK-v30T6XC1jHDDLvcuOX0p43PW8UCfakRPxMkQCw@mail.gmail.com>
 <CAPnjgZ2Ubr6kNfn+7bg+F_CV4H_wZMKaPq8F8njSfQNUF02+iA@mail.gmail.com>
 <CAC_iWj+X9Kw=1YOX0bny01JwkzCSyeZ6PB2-r_V-2TisgVG7WQ@mail.gmail.com>
 <20231209184915.GY2513409@bill-the-cat>
In-Reply-To: <20231209184915.GY2513409@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Dec 2023 09:49:15 +0200
Message-ID: <CAC_iWjKKG50d5QhUZFLUgxqO+VhgE7bC9Tk_SmCR0x4f3zD74g@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] smbios: Fallback to the default DT if sysinfo
 nodes are missing
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, sean.anderson@seco.com,
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

Hi Tom,

On Sat, 9 Dec 2023 at 20:49, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Dec 06, 2023 at 06:03:14PM +0200, Ilias Apalodimas wrote:
> > Hi Simon,
> >
> > On Sat, 2 Dec 2023 at 20:28, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Wed, 29 Nov 2023 at 23:50, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > [...]
> > > >
> > > >> > Changes since v1:
> > > >> > - Tokenize the DT node entry and use the appropriate value instead of
> > > >> >   the entire string
> > > >> > - Removed Peters tested/reviewed-by tags due to the above
> > > >> >  lib/smbios.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++---
> > > >> >  1 file changed, 90 insertions(+), 4 deletions(-)
> > > >> >
> > > >>
> > > >> Can this be put behind a Kconfig? It adds quite a bit of code which
> > > >> punishes those boards which do the right thing.
> > > >
> > > >
> > > > Sure but OTOH the code increase should be really minimal. But I don't mind I can add a Kconfig
> > > >
> > > >>
> > > >> > +
> > > >> > +       dt_str = ofnode_read_string(ofnode_root(), nprop->dt_str);
> > > >>
> > > >> Could this use ofnode_read_string_index() ?
> > > >
> > > >
> > > > Maybe, I'll have a look and change it if that works
> >
> > Unless I am missing something this doesn't work.
> > This is designed to return a string index from a DT property that's defined as
> > foo_property = "value1", "value2" isn't it?
> >
> > The code above is trying to read an existing property (e.g compatible)
> > and get the string after the comma delimiter.
> > Perhaps I should add this in drivers/core/ofnode.c instead?
> >
> > > >
> > > > [...]
> > > >
> > > >>
> > > >> Any chance of a test for this code?
> > > >
> > > >
> > > > Sure, but any suggestions on where to add the test?
> > > > SMBIOS tables are populated on OS booting, do we have a test somewhere that boots an OS?
> > >
> > > They are written on startup, right? They should certainly be in place
> > > before U-Boot enters the command line.
> >
> > Not always.  I am not sure if x86 does that, but on the rest of the
> > architectures, they are only initialized when the efi smbios code
> > runs. Wasn't this something you were trying to change?
>
> One of those things I keep repeating is that we don't know for sure what
> the right values here are until we load the DT the OS _will_ use. It's
> quite valid to start U-Boot and pass it a generic "good enough" DT at
> run time until U-Boot can see (GPIOs, EEPROM, whatever) what it's on and
> what the real DT to load before passing to the OS is. Since U-Boot
> doesn't need SMBIOS tables itself, we should make these "late" not
> "early".

Fair enough, we can defer the init and testing of those late, just
before we are about to boot. But this is irrelevant to what this patch
does, can we get the fallback mechanism in first, assuming everyone is
ok with the patch now?

Thanks
/Ilias
>
> --
> Tom
