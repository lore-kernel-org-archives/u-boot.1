Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708B8CD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 21:54:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDDFB846DE;
	Fri, 15 May 2026 23:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NF6s9IFV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BE4D84875; Fri, 15 May 2026 23:54:43 +0200 (CEST)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com
 [IPv6:2607:f8b0:4864:20::1331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DBBF846DB
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 23:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-2ef2a1cc06dso1511187eec.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 14:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778882079; cv=none;
 d=google.com; s=arc-20240605;
 b=L/UsT00m8wu2rQPt0eO1L/Cvc9uT+6KOY9jRbroirnUpcmxPRnYShuufjtH5yBCK0l
 IlSul8ipp74fvI4+vn2Cy0a7i3rau8ltuxkWw0ubOYCIWMncIyl6Xz+RX6VKl+tNiS1/
 gOEDEXHOM0D2qRx3IQghXTE4YIM03OTJkJbfoyKgkCqW15ZiZ7iZXbrLeySd2ICl+dc7
 FEC84nWfKwm0uonROB05eHCPkT+0JuZ/NkCwf9AiOJLO6/nMS2JIWCbPqk46vHHaIA0U
 5sP3OklbYX8Yqu2kwZ+L0jjHFIXVfEX8SNewPk+H+t+BhfK6EbXVBuj3hkWC/ZJlH7pO
 AYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=opktGtsLMksMe+jtuD7NL1ZdZ73zwPVnvS6IiRN3PR8=;
 fh=50Ge1u9w97r4fqa0Aoff/yuk/aYP2M/P6IYryZhGDGE=;
 b=bkK1Na84/sQT6g35CHHSVqxng1JKWdlM0SZfCRlD1x98r7GlpTRohs1oueITFqKa2J
 jZWoGwP/k+uN+5iypPLqi07HS/WENvrP0P/mtK69nUcWoOhLI9yTDXhg6cLHPL7O54FL
 gcz4+I0U34lFtV/IwfZmq249zLcjt8rsLdR6XgitvG3H/65UuJil8L+GJP3Y8GBmMgyN
 TPqUmiPQepsYXU7IPg/Pjk4WqZNAiip8HbbubOZP4mOrUMnyGj+4A0zjjoNDSyIT0x/r
 T9T0JKTZUBZ0GHA2nhwyj1Cr+gTK/srPCh92Ta3rtuVHyPrfVOhDe4+VEMIbBZDcaDv4
 comw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778882079; x=1779486879; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=opktGtsLMksMe+jtuD7NL1ZdZ73zwPVnvS6IiRN3PR8=;
 b=NF6s9IFVPNzKfpLdxhtzJpyiCtToOQ2PBQ1a7JgiUq7AUmtZAg9BRgm0KWiVhugIXR
 pciSZQZZQ4r6ub1MT5H3DPnH6663DpUjVT78AosFnWtw1NKA1Y7REi4GHb6V4uAntoYG
 WZxv3XRnBjfUW71vR6wRoBKV76PjLCVqLWpE6qTU3yZ+suupp8lkIIvZOLo1cwq5lGeU
 A5RD7HdNjwaJX0F3FCMzlYN6Y2VtwwMTivAAQVWyd4fqXAURdZKvwSP7y9v6QMeHYofi
 gkIlpE2kELJ127BZE8/1YAiW8kGOxeSJLUhgGEikEya408VMgAi8rFIdIGKqRBfaC3XQ
 2kLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778882079; x=1779486879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=opktGtsLMksMe+jtuD7NL1ZdZ73zwPVnvS6IiRN3PR8=;
 b=B5YS5VwQkKhzD8TcHzTW6bUzWJGu3H9u97FtN8IPCVBp1guwC1tpMnZR2l9ysI8hYh
 4dGzpsINmDdl+B185lppgH/ZbcWiHiFaNhVZ5IUoAw+IxTaNZjA1m4tBUm93V2tPculI
 74JHjnxx/w9T3RYcFqaS85BK1G158qx383urNfW+zyUVn9T2LGzd6tjoqdN9ufqdgkQw
 GtUM+3kOyMkyFNKbf6I/mose33f3L6rpxOAVHfhN+vLe2Z3IDGGOg2GPRsvn9SYjHK1s
 UacNs/1KaLZE/nmGLhwlw3CAqVOglWcWPXJn5iXKtjjZ6BymWWT+KrWzPr0p/Z8Mt9y2
 e5dg==
X-Gm-Message-State: AOJu0YwXV41djWym97SqLWRvXSDohnghXoNUZVccC+esTIL7HoKMCojo
 FekeQtw+zoSxUWsuYfzrW4S2FJTbZUuEn3ffYII3/OrUsplQuXkaM7+wQrDnKcQ1Neh7rDbNRLq
 YIAV90iyKVWwKjc1FG4EUAKPJTssZPg==
X-Gm-Gg: Acq92OGQ4CQKbo2z7Mymm1s8XMICGfPiOS3f4Wiun3fzo5T6upw01cBhxkngwQzfu4X
 rGbWmefghDQtOygE8Kau/qeO7go6hB9UgO+E4U6xN6C2gVolyy6fDSXiKCnTwGqOWI7Cx/u8Kd3
 df2mQRU22fTodH2DrHIj2S1Md/QNu4W4X3lHcpNy5ilyhzd+fWlz4tK6Px8BuHwqRfBibjO9jxC
 UgXQHIA4uZo+kpIg237WwLu/EfzCoofeZzljdlEVwUQ7zhw8pBUGmzOG4OC2cWlZsJ2QS5BiCpi
 uZpES7RqY+ZyLUiS4M24toDVowl7SIGXaUEM284=
X-Received: by 2002:a05:7301:2c8a:b0:2f2:32bc:787d with SMTP id
 5a478bee46e88-30398637044mr2571446eec.23.1778882079337; Fri, 15 May 2026
 14:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTjeQ2mvnkPeVPsWwK7ay4Ac-+h=3pApff6CUxaaHq45JA@mail.gmail.com>
 <CAFLszTgbu6Q3r5D4-ijH5Vqhwp6p1j3PMLZhi0QnYxyuUzcRmQ@mail.gmail.com>
In-Reply-To: <CAFLszTgbu6Q3r5D4-ijH5Vqhwp6p1j3PMLZhi0QnYxyuUzcRmQ@mail.gmail.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Fri, 15 May 2026 17:54:27 -0400
X-Gm-Features: AVHnY4ISH8QYB9p0yxwrTGdHtU7Uq1g4Lqtdzpm72oieW_fUOJF229RzayqPctY
Message-ID: <CABdDSeVq_R9KSFf2dydzNmCgrsCQfEneDCAgR-h=ieAx3vWQLQ@mail.gmail.com>
Subject: Re: In-tree Python tools (patman, buildman, binman, etc.)
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
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

Hi Simon,

On Fri, May 15, 2026 at 4:58=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi,
>
> On Mon, 4 May 2026 at 06:16, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi,
> >
> > As you know, I maintain several tools which are part of the U-Boot tree=
.
> >
> > Tom has previously suggested that it would be better to move patman
> > out of the U-Boot tree, e.g. to its own Github project. It is a
> > general tool which can be used with Linux and other
> > mailing-list/patchwork-based projects. I have never been keen on
> > taking on the extra effort required, but I've recently added more
> > features and am wondering whether now might be a good time to do this.
> >
> > Buildman is quite obviously designed specifically for U-Boot. I have
> > made some improvements recently (a large code refactor and distributed
> > builds). I would like to push those changes to mainline. Do people
> > think it should be in a separate tree somewhere?
> >
> > Binman was written with U-Boot in mind but supports other projects
> > (such as Zephyr). It is generic enough that it could be separated. The
> > impact would be harder code review.

I'm not sure if this is the place for this discussion, but I don't
really understand the placement of binman. It seems like a meta build
tool that combines multiple build artifacts into one, but integrating
it as a build step in uboot is strange, since we might rely on TFA or
even a kernel image that is built externally (which is what we tried
to do originally for the ADI SoCs when we thought binman was a
necessary part of getting the boards into mainline).

My ideal usage would be something like: in my yocto recipes I maintain
configuration settings that are passed to uboot for any hardcoded
addresses or offset, and I also fill in an image layout dts with those
details (both happen programmatically from the single config), then I
use binman instead of wic to create an image for my entire boot
device, or just a FIT image for kernel+initramfs, and ideally I can
integrate code signing or dm-verity immediately at this point, rather
than some of the hacks I've had for it in the past. We tried to link
some of the offsets and image details to Kconfigs at first to
propagate from a single point of configuration, but binman is not
selectable as part of a defconfig normally (I think?), so having
dependencies and configuring the details in a normal way didn't really
work and our result was pretty messy (and is being removed for that
reason).

If my understanding is correct then it is a kind of competitor for the
wic tool we use in our yocto builds. To be frank I don't like the wic
input format and a device tree-based solution, especially with more
options, would be a great alternative, but I think binman would need
to be outside the tree for this to be the most useful. I don't know
what buildroot uses by default but surely it could benefit from this
kind of a tool for image assembly as well, especially if it emerges
with the most robust set of capabilities.

> >
> > We also have smaller things like qconfig (which I have substantially
> > rewritten to make it fast) and dtoc, which is very tailored to U-Boot.
> >
> > What do people think? Of all of these, patman would be the easiest to
> > move, with the least impact on existing workflows.
>
> Are there any actualy patman users on the list who have an opinion? So
> far the replies are from people who don't actually use it :-)

I've been using patman to submit all of the ADI patches I've sent and
the results have mostly looked good, and I have encouraged the team at
Analog to do the same, although I know they are using/have tried to
use b4 (with some misfires we've been working on along the way). b4
seems to be a bit more complicated to configure properly in exchange
for more powerful features for subsystem maintainers especially, but I
have not tried it so I cannot speak to a real comparison.

Patman being present in the tree has made it very easy to use, but I
see the value of maintaining it separately, as it doesn't really
affect any part of the uboot source itself. However, newcomers who do
not yet use b4 may find it simpler to work with, so in my opinion it
is desirable to keep it accessible in some way. I'm very unfamiliar
with the python ecosystem, but is there a way to provide some kind of
reference list where I might be able to clone the uboot repository and
then with one command install suggested python tools that live
externally, perhaps under the tools directory still? If it is too far
removed or requires too many commands to make available, nobody will
use it.

Thanks,
Greg
