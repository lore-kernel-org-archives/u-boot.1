Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C15C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 15:05:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5969876F3;
	Thu, 21 Dec 2023 16:05:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S/4OR8fN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2B468787E; Thu, 21 Dec 2023 16:05:54 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BF29876C6
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 16:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-67ee17ab697so4790126d6.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 07:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703171151; x=1703775951; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DsdeaMMkek3YDQZom2lFiDJTS8ZNQgRMmSMctRGQKKU=;
 b=S/4OR8fN1FvSAQMeR3fuB0OatSBgvMgvNpIVov3jNAX6FfTzpM93qQGJjbPOe5evUN
 U9/2FIon6Qi7WuYFI3EbHmfeML4Zie83ZsGn+gCk/aSM1cDIkB6gqCPQcxu/yV7n4RbE
 HhIxsgxxzBWm0It1iIDJeE0vQyCvjDVh6dRXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703171151; x=1703775951;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DsdeaMMkek3YDQZom2lFiDJTS8ZNQgRMmSMctRGQKKU=;
 b=HEbBznop6srBmVjk39rAdWaY8M6UUiQfyYuA7kt6ner8Jem5o/Kp/0ftZMuL6sR5lT
 hJfDm9lrYcK5YY0vt3grrtmn9iYM4eVZTl8HuplC+WnzrSFUirgJIjwSacFF6RYQaeW+
 MWcuTS+TWljJOWf9zZAjfmInNmTtuA0N4I7ZpBanXIs5ZeC45/mI88W0RRhCZyehA7yf
 L7Uzgyn+Qpm7rQmckMeVi6DMOg79DrMFdBKXha3gIiFTQcanbXZEl6ThYxf5ooqSQXXh
 crsVdegmTIMkiK/gaPYWy9Q0Pv/GUMiudON7y27XcDe4pYDeqIGVqET+dokOxCsVvrtc
 c/Vg==
X-Gm-Message-State: AOJu0YyO0e50l6Cmc4xQOXlr5v0pnXC5VjtZ4zKryodS7aztgCVHYNHF
 nQotoAW3txm0M8caKfui5Y4yxKk1HLqQ9+Rm/dDk4A==
X-Google-Smtp-Source: AGHT+IEwaSpthbJd3GaLZwagEEwBX5tSxt+WUybBvriJeHSEmHgv9wh2IAbhzpfLqAEwIbwPDmTb+MqJcKmjieg404Y=
X-Received: by 2002:a05:6214:114f:b0:67a:a721:8321 with SMTP id
 b15-20020a056214114f00b0067aa7218321mr20421891qvt.123.1703171151162; Thu, 21
 Dec 2023 07:05:51 -0800 (PST)
MIME-Version: 1.0
References: <20231127171058.165777-1-ilias.apalodimas@linaro.org>
 <20231127171058.165777-2-ilias.apalodimas@linaro.org>
 <CAPnjgZ2Vo22gasW05um2og==yRoC33YB3eW=xXVt2dE9xqDgVw@mail.gmail.com>
 <CAC_iWjJE=-rOhOLVe4d7sUH8DEJjn5hdHoHpKe70d4gmB7---Q@mail.gmail.com>
 <CAC_iWjLrmk2AwxoO8tDtG8notrLQuSdRtqzLpTzBRuM1QO0wzw@mail.gmail.com>
 <CAPnjgZ3XXtD24cqn1eEtZu0rxuJz4DR8vttu2YDwes3_ToJNkQ@mail.gmail.com>
 <CALeDE9Moypi85cM8H2z+7nxZPVvJzj5DWWej0Qvdebpdp1qR1A@mail.gmail.com>
 <CAPnjgZ0o7QENx3yFEx2SNpm0A7Li_qqvTeUmdDXNaCVuEA++Jg@mail.gmail.com>
 <CALeDE9Pc5Z0x1PED3u+OQ0agNUWE7f=DCa5eoRsgWCVHPLAiYQ@mail.gmail.com>
In-Reply-To: <CALeDE9Pc5Z0x1PED3u+OQ0agNUWE7f=DCa5eoRsgWCVHPLAiYQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 21 Dec 2023 15:05:39 +0000
Message-ID: <CAFLszTh3NdKJ1+6XeFT8EiDkcCOiQ+AWXZ5=og+dF36B2NW+Hw@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] smbios: Simplify reporting of unknown values
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com,
 sean.anderson@seco.com, 
 neil.armstrong@linaro.org, heinrich.schuchardt@canonical.com, 
 mark.kettenis@xs4all.nl, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Peter,

On Thu, Dec 21, 2023 at 9:13=E2=80=AFAM Peter Robinson <pbrobinson@gmail.co=
m> wrote:
>
> Hi Simon,
>
> > > > > > Hmm I don't know, but I wonder why I am not just checking t->bi=
os_ver for Unknown.
> > > > > > I'll have a look and change it
> > > > >
> > > > > Ok, this can't be changed as easily.  smbios_add_prop() will not
> > > > > return NULL in any case. It returns an integer. With the cleanup,=
 it
> > > > > will always writes 'Uknown' and not return 0 anymore.
> > > > > I can add that default value you suggested but the ctx->last_str =
is
> > > > > still used on the next line anyway.
> > > >
> > > > Would you mind if I tried to create a version of the patch which do=
es
> > > > the same thing but with less code, and perhaps a test? It might be
> > > > easier to discuss it then. I can't claim to understand all the
> > > > different code paths at this point.
> > > >
> > > > My main concern is that with so many code paths it will be hard eve=
n
> > > > to refactor the code in the future, since it will become
> > > > 'load-bearing' and anyone might turn up and say it breaks their boa=
rd
> > > > because different information is provided.
> > >
> > > I don't buy this argument at all, sorry.
> >
> > OK.
> >
> > >
> > > > Overall, so long as the information isn't used for anything importa=
nt
> > > > in userspace, and we find a way to report SMBIOS to Linux without E=
FI,
> > >
> > > No, you can't tie random requirements to improving the SMBIOS support=
.
> > > We *already* report SMBIOS to Linux, reporting SMBIOS to Linux withou=
t
> > > EFI is changing things that will need different or extra standards,
> > > that could take years.
> > >
> > > You are arbitrarily adding extra requirements just to suite yourself,
> > > please STOP trying to hold things like this hostage.
> >
> > Isn't that what is happening with Linux and ffi? My understanding is
> > that there is no way to pass SMBIOS to Linux without EFI. Is that
> > correct? I know some people at their wit's end about that.
>
> Maybe the uses that want to go from a minimal firmware straight to a
> minimal kernel don't care about SMBIOS tables for their use cases,
> things don't need to be full parity to move forward the existing well
> defined usecase.

Yes, maybe.

>
> > You may know that I have tried for years to get bindings upstream to
> > Linux....right now there is a reserved-memory binding which has been
> > held up for longer than I can remember, because of EFI. How about a
> > little give and take?
>
> I actually caught up on the reserved-memory binding thread a week or
> so ago and my general thoughts from that thread was that there was a
> lot of outstanding questions being asked of you that you haven't
> clearly articulated or even replied to and the thread ended with you
> asking a number of times "can this be merged now?" and my thought at
> the time was "No, because there's a bunch of outstanding details". May
> I suggest you re-read that thread and take some notes while you do so
> and make sure all the outstanding questions have been answered and
> reply with a single response addressing the remaining details, from
> there we may be able to move on.

Note that I am just the facilitator for the binding. I volunteered to
send it since I have some knowledge and experience with devicetree. I
believe (from reading the thread) that at least Rob understood the use
case, but has no interest in it. At one point he asked for buy-in from
Tianocore/EDK2 people - they were already on cc but then started
trying to answer the questions.

Also note that it has been 3 months since v7 was sent. I have just
gone through the thread again. I don't see a "bunch of outstanding
details". I do see a some EDK2-specific questions, if that is what you
mean, but I don't know enough to answer those. The deep discussion of
EDK2-specific implementation details worries me, actually, since the
whole point of UPL is to be able to swap out the Platform Init and
Payload.

Conceptually the binding is simple...if we need another node with a
phandle we can do that. But why is it getting so stuck in the weeds?

If you think you can help on that thread, please do.

[..]

Regards,
Simon
