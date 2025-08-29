Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE425CA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 16:30:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E2BE8366F;
	Fri, 29 Aug 2025 18:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bLPQzer+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEC4783675; Fri, 29 Aug 2025 18:30:48 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C92AD83542
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 18:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-61cfabc02b8so2083611a12.2
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 09:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756485046; x=1757089846; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k9YbMBFYidZ4jfTmKPkvw72Yko29N0JQDGax2at6y5E=;
 b=bLPQzer+E9AH0ZN/ai7yTVwZLAzMUe9bR6i2EQvv7I4srIxnMXJl7w7eXAywXOwu+r
 UfdVDlI3+Kuy7O5Id79W93Gw4xJQw+KfeYKQVkbHALCV1VyhhQOIllLOwxYK/xs86qa/
 XlmurQyl0uA8JZoYDoj5D6bFni9ZxMnj3gU9lgV5MlBAsLlhNwWHCKL9Omo63Bj20NXs
 IEls5Fsjst1aZ8fI/AJAoT7ZBc3c0zG19NxWam2I1S1KWKQ6q3mqp4eJysKywePxkmBF
 pmeJnJzyTKV0x9LrLXSxs5ggbDE+xIIMrIlxjaltQtm+TZW5d7MHMev5fPSMLqRayLT4
 RYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756485046; x=1757089846;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k9YbMBFYidZ4jfTmKPkvw72Yko29N0JQDGax2at6y5E=;
 b=AGJ/nawfsP9Mem6Ly5BF/ZOXWbYhRDiLbz9ss8UvFmt7quCUHPDxMxoh8AEYG/bbiW
 3HVFSCOdhWaP5PiRirbpW6wpmrRn+R4ioVroLx+phVU7mWFZwQzwc+ab1hlcKQDsV+VU
 km6qtT9UAnG0YYRSpM0p7GcsNPYRCja82KR2OlVyyCD28Fk6gv5f6bSs3Kej1nm/mY8i
 TtvoPH3y8rCY+39uFBohIXUgu6NRw5x9UrhnvGmBfEChUbZfCuMVt4TDkGgIeFvYQmmC
 EpyGLm+GoyTsuzHfc4hAiIhMTDYBYuNhtzHoXkexdntRqR+FjBXyIJOGy92HPhxstl8m
 CZfg==
X-Gm-Message-State: AOJu0Yz/ua6zN2FD8Rj0xo8qpGKe7rPQVjuz0RGSNNI9znljSYEit0zD
 m1uFNZyD06qF/YSjFxHr21ZGRYVXDKHR2ioe/HZQHPLohCCxGyrLs7Xf8yLj/9kf1f1/dgio8LD
 G19cco7+bRSX9FYmH79y6PJFJySL/qMY=
X-Gm-Gg: ASbGnctatIYl3BHNiFAnKGMPaGF/quoOdq+gqyWX9X4ii8zGwwY8LCZP320krgphHLY
 FA03X3xBGucbQ2FCqEAjmnvZgaM8KOI6oZ5zUpEES9MRXmFo5YNnNAvUfxYVGfHDntaFN93sBU7
 gLoPIR3P2P01GreVGX6ZFjOBT/TBiKeo6MYEPyrW7VwJOJwYB3kmTVDjjiywQoP5iF8AaqbF8hV
 LIC2eYm
X-Google-Smtp-Source: AGHT+IFNBtZFvYgKTbMnZEZWDHa5QtK5jb4/141AZPgFw1/E6LUBVbpLUGyYjhC+yhVLxLdbZ2qTdpvvyQESmxez7fQ=
X-Received: by 2002:a05:6402:d0d:b0:615:5bec:1df with SMTP id
 4fb4d7f45d1cf-61c1b7155bamr22368762a12.25.1756485045867; Fri, 29 Aug 2025
 09:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaLiFwxjWPg+SQ4VVO7Oay4OX-WcCTmNa7FPHCYW6JLQmd9Uw@mail.gmail.com>
 <20250825190224.GU124814@bill-the-cat>
 <CAJaLiFwO-d7ejv3POg6d+kxqwbZxcrHVfRRbtBg-=63mQjPdfg@mail.gmail.com>
In-Reply-To: <CAJaLiFwO-d7ejv3POg6d+kxqwbZxcrHVfRRbtBg-=63mQjPdfg@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 29 Aug 2025 09:30:34 -0700
X-Gm-Features: Ac12FXyqvXd7U6HqVcgtVMpGF5sxe2LcsNB09p_2Rn2OqOCT_Cn15Wa9Dqwd428
Message-ID: <CAJaLiFwE+_FN=okhS4LcRaCeAi=Gz5p_2+M38R4w=+yYDAvmmA@mail.gmail.com>
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

Hi Tom,

On Mon, Aug 25, 2025 at 12:32=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wrot=
e:
>
> On Mon, Aug 25, 2025 at 12:02=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Mon, Aug 25, 2025 at 11:49:35AM -0700, Tony Dinh wrote:
> >
> > > Hi Tom,
> > >
> > > I've just done a git pull on the master branch. And then ran patman
> > > and got this error.
> > >
> > > ./tools/patman/patman  -c1 -s2 send -n
> > > Traceback (most recent call last):
> > >   File "/usr/src/u-boot-marvell/./tools/patman/patman", line 21, in <=
module>
> > >     from patman import control
> > >   File "/usr/src/u-boot-marvell/tools/patman/../patman/control.py",
> > > line 24, in <module>
> > >     from patman import cseries
> > >   File "/usr/src/u-boot-marvell/tools/patman/../patman/cseries.py",
> > > line 19, in <module>
> > >     from patman import cser_helper
> > >   File "/usr/src/u-boot-marvell/tools/patman/../patman/cser_helper.py=
",
> > > line 18, in <module>
> > >     import aiohttp
> > > ModuleNotFoundError: No module named 'aiohttp'
> > >
> > > I'm on Debian 12.11 and have Python 3.11.2. Is there something I migh=
t
> > > be missing?
> >
> > Ideally you should be using a virtualenv or whatever is recommended on
> > Debian 12 and then pip (or pipx?) install -r
> > tools/patman/requirements.txt
>
> Strange! I did not have to do anything extra like that before. I
> always thought u-boot did that automatically. Also, I've just tested
> it on u-boot-2025.07-rc5 on another u-boot git clone (on the same
> system), and patman ran without this problem.
>
> I'll dig some more, but if you have any idea please let me know.
>

Debian 12.11 (bookworm) has quite a bit of version mismatches between
aiohttp, pygit2 and their dependencies in u-boot. It's a struggle, ie.
impossible, to try to resolve. So I had to upgrade to Debian 13.0
(trixie) and used the versions provided by this distro version.

Debian 13.0 (trixie)

ii  libgit2-1.9:armel                       1.9.0+ds-2
         armel        low-level Git library
ii  libgit2-dev:armel                       1.9.0+ds-2
         armel        low-level Git library (development files)
ii  python3-aiohttp                         3.11.16-1
         armel        http client/server for asyncio
ii  python3-pygit2                          1.17.0-2
         armel        Python bindings for libgit2 (Python 3 module)
ii  python3-aiohttp                         3.11.16-1
         armel        http client/server for asyncio

# cat tools/patman/requirements.txt
aiohttp=3D=3D3.11.16
ConfigParser=3D=3D7.1.0
importlib_resources=3D=3D6.5.2
pygit2=3D=3D1.17.0
requests=3D=3D2.32.4
setuptools=3D=3D78.1.1

Hope this helps others looking for it.

All the best,
Tony

> Thanks,
> Tony
>
> >
> > --
> > Tom
