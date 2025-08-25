Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99773C8303F
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 19:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC9B182DA1;
	Mon, 25 Aug 2025 21:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R5P/JiCk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 302CF83020; Mon, 25 Aug 2025 21:32:30 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 451BA82C84
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 21:32:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-61c74fc408bso1927014a12.3
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 12:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756150348; x=1756755148; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Fzz9ohBd2yg3rJ/NTT4wnIT/lXTTNDdstY1yLa0BE0=;
 b=R5P/JiCkQeoZLOogTRYRlsNe/XkR1Dc4n416zYzchgOWMUODmA4lusdV00f660FZb1
 fovCMPg83APw1EEtrJ3dQsBTH1GuS4yqQasBZV/xNNWHEeYIWJ/hoGYiwFD+D6sOTUnE
 oN6bX5wRQwvowzfV87m2PjuC3Figu4BEbLtIanNJAu6dIcsHjQDHQMHNat/U0bXD5YQL
 J79E1FnybLKO1L/t+KeagpD8FsbvYaJNeBk95KCWsRgDLHYdK4kCukwaeZrGd0yzgDmy
 4QEsD++Ur8eIiNVyOjv8tydGAu+QDg5fDDezJd1mPYGZXQ4vzpxhUMFLJp2kdGXG8l8X
 tPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756150348; x=1756755148;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Fzz9ohBd2yg3rJ/NTT4wnIT/lXTTNDdstY1yLa0BE0=;
 b=B2bT6E/0buyIiBa0F7dmNTUzp3/95xCcylz5rJSssH/klXMUz5Egu4sWHOXn86+2Vf
 IBMsz+TuDPuxtQuSJO4o1NK78+sz8ljLZE6mHIXoMjSO9olTYguWEI3oSNxMVMFduHPZ
 KO5NBXbQsA9gXnSqBn7/Q2TY9mqeYS+Pd2OlsjIdGDtcNCq16sQ0CXEYXxepdFj8OEm6
 SwerSsatDBP6fEpTdVaTXHMUozbNufUWDEUfp5EEmhq56+3kaCrqoLNeyJGrlR66FNDP
 fKnqwNsAeXCVM+hwnjWTbLVor1vBOji9eKG6Hkl7c1G3hzLw/WiKT9sLYZ1H/W0LL4oL
 wLZg==
X-Gm-Message-State: AOJu0YyWI4nYt6/MuEv7qAmNreH+KlYzBGQuZnvPEyV2xgnS6U3phh6B
 /acFwjae/RmvM7h8mmce6lzC1VnGFMUbDKFfa8Ui0bdHFh9hl2IDIpZz6Q51UKr6U/72r2HGn9Y
 SmgGQy5VnmymjYFg1fOASmzZEjhR0KU045Onm
X-Gm-Gg: ASbGncssxyrXJfAk8vWuUM5FJ6l245twrF+h0UVQf0vRtZZZkdwEB7lB/emQGydI+UH
 4pH7R2QolN3yZCwGrH1Y8ktk78f9i8Q1dGosRbbyh1tism40uGudyM/j1uPmkQINou/woCl5kmt
 +qsVsMits35QaQO2qxUtXANh4k+c/DD+em1WyfEZ4kc3vWoYi3qVm13Dl9gTT2wZutzhMz2/8V4
 V+vILyA
X-Google-Smtp-Source: AGHT+IEvPCOsRUcWXEwV9kKI1TPEMEQwETFnr+qnG8oNnb38gU2C8R9gxbdBki4/8WqyGdXh8ANiXH3YFSSBNJBHAAY=
X-Received: by 2002:a05:6402:23c7:b0:618:3521:6866 with SMTP id
 4fb4d7f45d1cf-61c1b49df8emr11618455a12.15.1756150347498; Mon, 25 Aug 2025
 12:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaLiFwxjWPg+SQ4VVO7Oay4OX-WcCTmNa7FPHCYW6JLQmd9Uw@mail.gmail.com>
 <20250825190224.GU124814@bill-the-cat>
In-Reply-To: <20250825190224.GU124814@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 25 Aug 2025 12:32:14 -0700
X-Gm-Features: Ac12FXxrLjW-kvPGcM0gby7F_5GXqG51wMnIRQ0QMQSl-xEzsUNWMGr3pLXBbLg
Message-ID: <CAJaLiFwO-d7ejv3POg6d+kxqwbZxcrHVfRRbtBg-=63mQjPdfg@mail.gmail.com>
Subject: Re: tools: patman cannot find aiohttp module
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Mon, Aug 25, 2025 at 12:02=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Mon, Aug 25, 2025 at 11:49:35AM -0700, Tony Dinh wrote:
>
> > Hi Tom,
> >
> > I've just done a git pull on the master branch. And then ran patman
> > and got this error.
> >
> > ./tools/patman/patman  -c1 -s2 send -n
> > Traceback (most recent call last):
> >   File "/usr/src/u-boot-marvell/./tools/patman/patman", line 21, in <mo=
dule>
> >     from patman import control
> >   File "/usr/src/u-boot-marvell/tools/patman/../patman/control.py",
> > line 24, in <module>
> >     from patman import cseries
> >   File "/usr/src/u-boot-marvell/tools/patman/../patman/cseries.py",
> > line 19, in <module>
> >     from patman import cser_helper
> >   File "/usr/src/u-boot-marvell/tools/patman/../patman/cser_helper.py",
> > line 18, in <module>
> >     import aiohttp
> > ModuleNotFoundError: No module named 'aiohttp'
> >
> > I'm on Debian 12.11 and have Python 3.11.2. Is there something I might
> > be missing?
>
> Ideally you should be using a virtualenv or whatever is recommended on
> Debian 12 and then pip (or pipx?) install -r
> tools/patman/requirements.txt

Strange! I did not have to do anything extra like that before. I
always thought u-boot did that automatically. Also, I've just tested
it on u-boot-2025.07-rc5 on another u-boot git clone (on the same
system), and patman ran without this problem.

I'll dig some more, but if you have any idea please let me know.

Thanks,
Tony

>
> --
> Tom
