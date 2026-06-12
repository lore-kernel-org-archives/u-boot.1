Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C11CCD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 18:23:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 073068484A;
	Fri, 12 Jun 2026 20:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EpOz6WL3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D31D984869; Fri, 12 Jun 2026 20:23:24 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B77968063E
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 20:23:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-68b90fc6a1dso2636306a12.1
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 11:23:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781288602; cv=none;
 d=google.com; s=arc-20240605;
 b=MA+CH0Q9Oj0c8InPhG0KDPtITiejAvkoFpYNTVYXTMcUew20WfFBTUiDT+LDLeZb/W
 j9zP+YrSVBXR8Lf4dfHSUgjxu9CS2hmXox4s8Tz05uE51UhX94ocwrghs1kgzQoyWBCD
 UD3iLh6osRVmFHw4RwQOIE1ms4ViMikgDz4tjO6jFx3KHKoEiNR9vAL2bnbwvIvBFZRc
 9HiJ1vnp9f1vZNxAeFcChu8HdMmjsOB1NiJ3AYstIfzPOI6YjI1PPmB+OoKJkycrrAUC
 zsGztrTHBJvdnfofHtEqm8SJCidVvyNM13za/NnLPS53f2inFjmWkUn3QKmTaaw/I/2m
 WzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IFiuUwLVc1IzLaGkeH3CTMYd67CPU/r5Cd78DgkXnWc=;
 fh=j/C1A8jzz53G3ahuoYI+1UAhz59fct3dfGaHYX+S00U=;
 b=Kc/26ehymuizgdo3ZspJrAXqRc81guD7b2hmHSnXW2eNjZJIe6LVUfOVcjiv+rViFB
 I78TeMvMtM3bklNvo6uuJqbvY1RT4XX6RbcGV17wPCuOx+dMHWG4B42/abxvU4JgQJO5
 mhbbOiZBd+PSfW2Ht8oj5w1hQb/S8Cv65M44badccyMjcV99pI5xXe3VbNC/8Oe/1ALV
 rj05HBOpr3IbLMIo9qIXisU6OLCaveoW++8HOvzL4JnEp17vDBrEwjmP4egDXddmhnYl
 2ziMFOJup2gEPbbJ9JaYCLjiA1nrq4/zM+2FNUm2gUFJ7dNT/h/nDp/l5VgW0HCjiKfh
 0epg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781288602; x=1781893402; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IFiuUwLVc1IzLaGkeH3CTMYd67CPU/r5Cd78DgkXnWc=;
 b=EpOz6WL3uFSI39hR7NxloiTqgirJGUFh1n9zC/pykUKH47xUttcj7ne5zzFXfKZij0
 OBnOgva4Kdp+oU5bijgAAugaZz//HMUiKqjVQVVYv0Jjo7b+ihiL9ErG1IERRH1VrBuE
 TrJmMpvFT83DztUJMnbDKuqbkYY7N2irj4qy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781288602; x=1781893402;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IFiuUwLVc1IzLaGkeH3CTMYd67CPU/r5Cd78DgkXnWc=;
 b=NRCSIVR6GqNH3c3IQYxMuTRd/QVsIS04PfiF3X4yrjUGl3LY46h4um2V/bFow7dtxF
 fwxa/81CWQ4qOK95jdEdCxqwhENw83MrRWzTlhyqBbW0BwKQ2rHT4bLv2PvKNkRkxiWu
 6SNlNjwSugv9BBUlvKsJC63UP6dF5ZMjZ+3nrp9d/IuvFq6JGB3lo6CPs9YqaXRpiPp4
 U5Z6ZgU0GxDBTyrVTsMIVAK5Q/nRo9rSmWs03K2V98FzrACGZLzRPdwHqwXoj+cp3J/n
 F88KCqaTOLXVguqikExXqHTu97POMOJhzxKFNO9nj/UoC8fYFc9ARnsHz5v5DWd40QwJ
 3l7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8KCEPR9SEDbz8B/ztXfnmw+CHn0j6V+nmxzjMykt/3sAXdlakTwyVFUj3kkWGZqmpM5DTo7qE=@lists.denx.de
X-Gm-Message-State: AOJu0YxfvFoBhezTwqQpisPbftokMWyw1XJxCsGpKNDUlPXR7VKCBRaE
 +phYlYV23USpecDh40vK1u/kKW6tz4guV7MHLJSgycU53yii8AYKdfxO3q4Uh+PwBiwvrTwgPSJ
 vYJXxBO2c8J9DKUcAzvi+SGNY8LFpJ7XPHmhcIGGxbpD5yaPxJMQ=
X-Gm-Gg: Acq92OEpIN8KssMSjCCa8Fpx6wrlpzJil8Ibv8cdEsD+oPAr0MMgaLTQfQY6M/0biFu
 wLqOwbYDoNMeJmz52CK621Yl1xnrK8gkG7KL49qW4qupvtbvh+36W9O2c++h2DAvtr8H9yK9D4R
 DG4KbUJq/USzsbZhbhi8zmRc2oTB/xmuP7jWBgPqzZyVfTlKYnQ/KZiDFc6osl0CpErrJ9ouEAn
 cjQNN3+fegg7ZtYZdViGHzDC7d3WfSqCI2Wa+cT3O218gS42o6lDbfZsH+kEwZAtp+qTmXKyrDz
 IG+BWA==
X-Received: by 2002:a05:6402:1c09:b0:68c:3439:945f with SMTP id
 4fb4d7f45d1cf-693695c38d2mr1227761a12.12.1781288602129; Fri, 12 Jun 2026
 11:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
 <20260604160547.GR627328@bill-the-cat>
 <CAKTNdwEt+CpeN8JssJr_JFowXi8yt8QPFg77=OKG0BeOri43MQ@mail.gmail.com>
 <20260604172115.GV627328@bill-the-cat>
 <CAKTNdwFaJODWtr4S15L8JVwzs7XXZ9VPD1D7L5r94o44bnyQXQ@mail.gmail.com>
In-Reply-To: <CAKTNdwFaJODWtr4S15L8JVwzs7XXZ9VPD1D7L5r94o44bnyQXQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 12 Jun 2026 12:23:10 -0600
X-Gm-Features: AVVi8CdbXlh0RQWzJSOlE_oFZv7CxdM8cJlutoCSjqHWlwEOE_WYqHrqOPIRR9g
Message-ID: <CAFLszTj6AdQf=yWj21bt3W=-0WbqiiBgP0iM16C1kV2jMiGHmQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] pxe_utils: small fixups, implement BLS type 1 boot on
 top of them
To: Alexey Charkov <alchark@flipper.net>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Martin Schwan <m.schwan@phytec.de>, Daniel Golle <daniel@makrotopia.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

Hi,

On Thu, 4 Jun 2026 at 11:35, Alexey Charkov <alchark@flipper.net> wrote:
>
> On Thu, Jun 4, 2026 at 9:21=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > On Thu, Jun 04, 2026 at 09:16:58PM +0400, Alexey Charkov wrote:
> > > On Thu, Jun 4, 2026 at 8:05=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> > > >
> > > > On Thu, Jun 04, 2026 at 07:31:05PM +0400, Alexey Charkov wrote:
> > > >
> > > > > Add support for the Boot Loader Specification (BLS) type 1 boot e=
ntries,
> > > > > as generated by default by systemd's kernel-install when loader=
=3Dbls.
> > > > >
> > > > > Given that the format of BLS entries is pretty much the same as P=
XElinux,
> > > > > reuse the existing library for the parsing logic.
> > > > >
> > > > > BLS type 2 entries are out of scope, as they are effectively just=
 EFI
> > > > > applications and should be booted as such.
> > > > >
> > > > > This implementation is also only allowing a single top-sorting en=
try to
> > > > > boot, as the standard boot infrastruture currently doesn't suppor=
t
> > > > > multiple entries per partition-bootmeth tuple. I have a proposed =
extension
> > > > > to enable that and will post it separately as RFC - that enables =
the use
> > > > > of `bootflow menu` to select the kernel to boot without jumping t=
hrough
> > > > > several menus with different behavior as is currently required wi=
th
> > > > > extlinux.conf.
> > > > >
> > > > > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > > >
> > > > This is good to see, thanks for posting it. One concern I have is t=
hat
> > > > out of 1529 platforms, this would be enabled on 1392 of them. And t=
he
> > > > size growth is around 1.5 kilobytes. Is there some smaller percenta=
ge of
> > > > platforms this should be "default y" for ? Or is the expectation th=
at
> > > > something like Debian will be configuring for this moving forward, =
so
> > > > yes even something like PowerPC platforms be using this? Thanks!
> > >
> > > Well this is the config format that systemd's kernel-install produces
> > > out of the box, and it doesn't require EFI support unlike UKI (a.k.a.
> > > BLS type 2). So one could argue that any system shipping with systemd
> > > benefits directly. In my view, that makes it more accessible for end
> > > users than e.g. bootmeth_extlinux, which is also "default y" but I
> > > could only find a suitable config generator for it with device tree
> > > support in Debian (not in Fedora, nor in Gentoo out of my extremely
> > > representative sample of N=3D3 distros).
> > >
> > > Happy to make it conditional on whatever platforms find this helpful
> > > though, or drop "default y" altogether. I personally only care about
> > > ARM, and Rockchip in particular :)
> >
> > Right. What I'm asking is, do you know how many distros are planning to
> > adopt BLS type 1 support by default? And since you're on Rockchip, why
> > not just use BLS type 2?
>
> I've only seen Fedora use it by default, but I'm not that much of a
> distro connoisseur. There might be more, or there might not.
>
> BLS type 2 didn't work for me last time I tried it because it
> seemingly wanted to bake the DTB into the UKI and couldn't handle DT
> overlays, which made booting different boards with the same kernel
> binary a pain. BLS type 1 didn't have those issues, and a concise
> plaintext config has its (subjective) appeal over
> yet-another-packed-binary-format.

BLS type 2 is an EFI app, so a huge amount of extra code and
complexity to do the same thing.

I already have BLS in the Concept tree and would love to see it in
mainline. Relevant to this I have:

- refactoring so that pxe_utils can support parsing without booting
- support in bootstd for multiple bootflows per partition
- a script and test for booting Ubuntu this way (i.e. without EFI)

I'm not entirely sure of how to upstream this, given all the
refactoring that is needed, but I'll take another look.

Regards,
Simon
