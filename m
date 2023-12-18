Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34894C46CD3
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 15:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 745D387E74;
	Mon, 18 Dec 2023 16:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GNEGvPbG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAC1F87E38; Mon, 18 Dec 2023 16:02:58 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B056587E65
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:02:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-dbcdec51ed9so2258291276.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702911775; x=1703516575; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dFD7ezb3QupTz6ldf28ZQtG3LyxXCNaDHgtiRQjDVVQ=;
 b=GNEGvPbGzu/PLLEzNCeoBOTnFsS8yyZ7uj4hZHtFavB5BYCz6VV60Fb4YZQ8A1Y1Gn
 yoI0oyFlqPpW/sIKDM0wnAchXhwxERrh9VAX9V+hsiL8r45UpEfm2UmsRSS0tqQSv03g
 uJK2494BQe3MMRJW6Niv+gamKgEv2l7lh03do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702911775; x=1703516575;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dFD7ezb3QupTz6ldf28ZQtG3LyxXCNaDHgtiRQjDVVQ=;
 b=ICt6EcEvm5Bgb01uNzgfFWWBlruCrakaKFI6HukFq+axjqZxBa4DAzA6ACeLxPH/xN
 Vz5tqVT82vjxUtipToNASy8/cPYiJ0s8sIrSmOjhph1vJEqfUh+hPz82IhUheMuQ8hE1
 xGivuivamaTH4uIc4KBth+K3Le+YHQJnF5ip7/x7GQ7TkJwiODGdwEZGd51ZhGc0rkpL
 AhqFuekhe6qKCk0C9VwNY2x0LNE1oTTbH/TuuqU8yC8O6NQLsmHbCpT72jZCIN5Mzgv1
 pXNcCHTm68m7da7jPtO7lS8rp+T/B+seF82y7C3k5MULNQ6C+jy9uz2uQ+Hr091dMVfp
 zvag==
X-Gm-Message-State: AOJu0YyC5yJ3K2haXabzUHC1XOCJ3vAqS3FpUN2C37bz6/bpWTQ6OhQy
 cHnOhto7/Bm4itm86d2mcQ40vEtlYw4LU4xtTM1KMQ==
X-Google-Smtp-Source: AGHT+IGPMXHRi5ERCJ+xagSWd5Cq7w/AhGL9hZAdXBQ2PptlgCPhRMLuz8KS1wFFTuGFGjEOKZzbukb73cGrgjoZWpY=
X-Received: by 2002:a5b:b04:0:b0:d9a:5630:5281 with SMTP id
 z4-20020a5b0b04000000b00d9a56305281mr8956611ybp.62.1702911775261; Mon, 18 Dec
 2023 07:02:55 -0800 (PST)
MIME-Version: 1.0
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2PtQQ81x-SqMs6NKSjMKFGShT65Rrtfc-CDOsdBxgJDQ@mail.gmail.com>
 <CAC_iWjJ52eK-v30T6XC1jHDDLvcuOX0p43PW8UCfakRPxMkQCw@mail.gmail.com>
 <CAPnjgZ2Ubr6kNfn+7bg+F_CV4H_wZMKaPq8F8njSfQNUF02+iA@mail.gmail.com>
 <CAC_iWj+X9Kw=1YOX0bny01JwkzCSyeZ6PB2-r_V-2TisgVG7WQ@mail.gmail.com>
 <20231209184915.GY2513409@bill-the-cat>
 <CAC_iWjKKG50d5QhUZFLUgxqO+VhgE7bC9Tk_SmCR0x4f3zD74g@mail.gmail.com>
 <CAPnjgZ27G=6fDadAiJk_aG9He2ZpyFhhsZDYxUwEp5+0AQatYg@mail.gmail.com>
 <20231213201909.GG2513409@bill-the-cat>
 <CAPnjgZ2Ljm2aR0w9zgJZ2O49XU8oNYsDi-EJ-PD=Z5mx2sQHrg@mail.gmail.com>
 <87y1dx6cnd.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87y1dx6cnd.fsf@bloch.sibelius.xs4all.nl>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 18 Dec 2023 08:01:52 -0700
Message-ID: <CAPnjgZ1c5MM-51qpj6tBMV03ofwFyfv2Z230S=5aatLaGN5ziQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] smbios: Fallback to the default DT if sysinfo
 nodes are missing
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, sean.anderson@seco.com, 
 neil.armstrong@linaro.org, heinrich.schuchardt@canonical.com, 
 pbrobinson@gmail.com, u-boot@lists.denx.de
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

Hi Mark,

On Wed, 13 Dec 2023 at 14:00, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Simon Glass <sjg@chromium.org>
> > Date: Wed, 13 Dec 2023 13:41:05 -0700
> >
> > Hi Tom,
> >
> > On Wed, 13 Dec 2023 at 13:19, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 12:50:03PM -0700, Simon Glass wrote:
> > > > Hi Ilias,
> > > >
> > > > On Mon, 11 Dec 2023 at 00:49, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi Tom,
> > > > >
> > > > > On Sat, 9 Dec 2023 at 20:49, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Dec 06, 2023 at 06:03:14PM +0200, Ilias Apalodimas wrote:
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > On Sat, 2 Dec 2023 at 20:28, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > >
> > > > > > > > Hi Ilias,
> > > > > > > >
> > > > > > > > On Wed, 29 Nov 2023 at 23:50, Ilias Apalodimas
> > > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi Simon,
> > > > > > > > >
> > > > > > > > > [...]
> > > > > > > > >
> > > > > > > > >> > Changes since v1:
> > > > > > > > >> > - Tokenize the DT node entry and use the appropriate value instead of
> > > > > > > > >> >   the entire string
> > > > > > > > >> > - Removed Peters tested/reviewed-by tags due to the above
> > > > > > > > >> >  lib/smbios.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++---
> > > > > > > > >> >  1 file changed, 90 insertions(+), 4 deletions(-)
> > > > > > > > >> >
> > > > > > > > >>
> > > > > > > > >> Can this be put behind a Kconfig? It adds quite a bit of code which
> > > > > > > > >> punishes those boards which do the right thing.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Sure but OTOH the code increase should be really minimal. But I don't mind I can add a Kconfig
> > > > > > > > >
> > > > > > > > >>
> > > > > > > > >> > +
> > > > > > > > >> > +       dt_str = ofnode_read_string(ofnode_root(), nprop->dt_str);
> > > > > > > > >>
> > > > > > > > >> Could this use ofnode_read_string_index() ?
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Maybe, I'll have a look and change it if that works
> > > > > > >
> > > > > > > Unless I am missing something this doesn't work.
> > > > > > > This is designed to return a string index from a DT property that's defined as
> > > > > > > foo_property = "value1", "value2" isn't it?
> > > > > > >
> > > > > > > The code above is trying to read an existing property (e.g compatible)
> > > > > > > and get the string after the comma delimiter.
> > > > > > > Perhaps I should add this in drivers/core/ofnode.c instead?
> > > > > > >
> > > > > > > > >
> > > > > > > > > [...]
> > > > > > > > >
> > > > > > > > >>
> > > > > > > > >> Any chance of a test for this code?
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Sure, but any suggestions on where to add the test?
> > > > > > > > > SMBIOS tables are populated on OS booting, do we have a test somewhere that boots an OS?
> > > > > > > >
> > > > > > > > They are written on startup, right? They should certainly be in place
> > > > > > > > before U-Boot enters the command line.
> > > > > > >
> > > > > > > Not always.  I am not sure if x86 does that, but on the rest of the
> > > > > > > architectures, they are only initialized when the efi smbios code
> > > > > > > runs. Wasn't this something you were trying to change?
> > > > > >
> > > > > > One of those things I keep repeating is that we don't know for sure what
> > > > > > the right values here are until we load the DT the OS _will_ use. It's
> > > > > > quite valid to start U-Boot and pass it a generic "good enough" DT at
> > > > > > run time until U-Boot can see (GPIOs, EEPROM, whatever) what it's on and
> > > > > > what the real DT to load before passing to the OS is. Since U-Boot
> > > > > > doesn't need SMBIOS tables itself, we should make these "late" not
> > > > > > "early".
> > > > >
> > > > > Fair enough, we can defer the init and testing of those late, just
> > > > > before we are about to boot. But this is irrelevant to what this patch
> > > > > does, can we get the fallback mechanism in first, assuming everyone is
> > > > > ok with the patch now?
> > > > >
> > > >
> > > > I would like this behind a Kconfig. Making it the default means people
> > > > are going to start relying on (in user space) and then discover later
> > > > that it is wrong.
> > >
> > > What do you mean wrong, exactly?
> >
> > "raspberrypi" instead of "Raspberry Pi", for example, or "friendlyarm"
> > instead of "FriendlyElec"
>
> Heh, well, even in the x86 world vendors can't even spell their own
> name consistently.
>
> > I just wonder what this information is actually used for. If it is
> > just for fun, that is fine, but I believe some tools do use dmidecode,
> > at which point it needs to be accurate and should not change later,
> > e.g. when someone decides to actually add the info.
>
> So the Linux kernel uses this information to apply quirks for specific
> machines.  But I hope that on platforms that have a device tree folks
> will just use the board compatible string for that purpose.

Right.

>
> Otherwise I think this information is mostly used to populate system
> information UIs and asset databases.

So perhaps the devicetree should be used instead? How do these things
work today? And what are they, exactly?

Regards,
Simon
