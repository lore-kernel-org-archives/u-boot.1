Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FBFFEFB47
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 13:20:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83B7183BB1;
	Fri, 27 Feb 2026 14:19:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=maquefel.me header.i=@maquefel.me header.b="s9JVwKkx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB86083BB1; Fri, 27 Feb 2026 08:27:32 +0100 (CET)
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net
 [178.154.239.209])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E552383642
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 08:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nikita.shubin@maquefel.me
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:eaca:0:640:4fc0:0])
 by forward501d.mail.yandex.net (Yandex) with ESMTPS id 51E6081EF8;
 Fri, 27 Feb 2026 10:27:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id PRdVq09G3eA0-VTR9iYrm; 
 Fri, 27 Feb 2026 10:27:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1772177247; bh=KlPDpV1EAbtNtUh3P1jNGMPjINa9CUT553byNR3Mtrg=;
 h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=s9JVwKkx8K5RPkmMtOUYH7aWEYVL8kQTxmktfh88da+m2UMbdhy1u4E6ow2qmfBI9
 PZ0BgPr4a3/2GdVcnc6zvGgJYzJP7qi6iozWuXpzWtLM/5inp8+uxkOcg5tuh+6XYO
 j2teHjeI8/QBMuuvvC/Hx3EnhXGL3b5wiS6ukBPQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
Message-ID: <93160127b13e492a6d7392b75ccc4a9867c58d2c.camel@maquefel.me>
Subject: Re: [PATCH RFC] binman: Make FDT size hint configurable
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>,  Tom Rini <trini@konsulko.com>, Bryan Brattlof
 <bb@ti.com>, Yannic Moog <y.moog@phytec.de>, Neha Malcom Francis
 <n-francis@ti.com>, Chukun Pan <amadeus@jmu.edu.cn>, Moteen Shah
 <m-shah@ti.com>
Date: Fri, 27 Feb 2026 10:27:27 +0300
In-Reply-To: <8fd72f0c-51ed-4721-a39f-1e41aa6665a0@cherry.de>
References: <20260226-fdt_size_hint-v1-1-5a731a5f8d6d@maquefel.me>
 <8fd72f0c-51ed-4721-a39f-1e41aa6665a0@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Feb 2026 14:19:56 +0100
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

Hi Quentin,

On Thu, 2026-02-26 at 17:21 +0100, Quentin Schulz wrote:
> Hi Nikita,
>=20
> On 2/26/26 2:52 PM, Nikita Shubin wrote:
> > [You don't often get email from nikita.shubin@maquefel.me. Learn
> > why this is important at
> > https://aka.ms/LearnAboutSenderIdentification=C2=A0]
> >=20
> > The hardcoded 64KB FDT increment size causes excessive
> > reallocations
> > when building FIT images with large artifacts (e.g., 250+ MB
> > rootfs):
> >=20
> > ```
> > =C2=A0=C2=A0=C2=A0 ncalls=C2=A0 tottime=C2=A0 percall=C2=A0 cumtime=C2=
=A0 percall
> > filename:lineno(function)
> > =C2=A0=C2=A0=C2=A0=C2=A0 16118=C2=A0 297.130=C2=A0=C2=A0=C2=A0 0.018=C2=
=A0 305.189=C2=A0=C2=A0=C2=A0 0.019
> > libfdt.py:947(resize)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 870=C2=A0=C2=A0=C2=A0 9.876=C2=A0=
=C2=A0=C2=A0 0.011=C2=A0=C2=A0 15.211=C2=A0=C2=A0=C2=A0 0.017
> > fdt.py:56(BytesToValue)
> > =C2=A0=C2=A0=C2=A0=C2=A0 16118=C2=A0=C2=A0=C2=A0 8.024=C2=A0=C2=A0=C2=
=A0 0.000=C2=A0=C2=A0=C2=A0 8.024=C2=A0=C2=A0=C2=A0 0.000 {built-in method
> > _libfdt.fdt_resize}
> > ```
> >=20
> > Add support for configurable increment size via --fdt-inc-size
> > option,
> > with recommended value at least equal to total binary artifacts
> > size
> > to minimize resize operations and reduce build time.
> >=20
>=20
> Does it *need* to be configurable though?
>=20
> After all, we kinda know what we're going to put into the device tree
> right before inserting it no?

Well we do, kind of...

>=20
> I'm wondering if we cannot simply set the INC_SIZE based on the size

I think we can.

> of=20
> the data we're going to include (+ size for the property name and
> some=20
> overhead I guess). I'm assuming changing it before using
> fsw.property()=20
> and reverting it to the default value after the method is called? I'm
> assuming we may want to cap this such that we don't need to worry
> about=20
> OOM with very big artifacts.

AFAIK it won't save us from OOM, cause it's not a limiter of some kind,
but a hint used for resize increment:

```
if check_err(val, QUIET_NOSPACE) < 0:
            self.resize(len(self._fdt) + self.INC_SIZE)
            return True
```

So we simply increase it chunk by chunk with limited size of INC_SIZE
until we hit required size. That's why we end up iterating so much,
i.e.:

```
$ time venv/bin/binman -T 32 build [...]

real    5m2.764s
user    0m55.798s
sys     4m5.155s

$ time venv/bin/binman -T 32 build -s 268435456 [...]

real    0m24.858s
user    0m9.166s
sys     0m3.509
```

So setting size_hint drastically reduces build time.


>=20
> I"m also wondering... is this code path also used when you put the
> data=20
> external to the FIT? fit,external-offset (can be 0, the case for most
> platforms except NXP). Maybe this is what you want? I'm not too verse
> into fit generation and quickly reading tools/fit_image.c, it seems
> like=20
> it expects an FDT with data properties and then relocate them outside
> the FDT and set a data-offset property in lieu of the data
> properties...=20
> That seems pretty inefficient to me, why insert the data inside the
> FDT=20
> in the first place?

Can't tell precisely - i should study it. May be you are right.

>=20
> The next question is how exactly you're planning to set this size.=20
> Because as I see it now, this is only configurable when calling
> binman=20
> manually and passing it an argument. Which means, this won't be used
> by=20
> default when building U-Boot with make.

Well, i use "binman" as a last stage, not as a part of U-Boot build,
something like this:

```
$ python -m venv venv
$ pip install tools/binman tools/patman # (along with other deps)
$ venv/bin/binman -T 32 build -s 268435456 -d u-boot.dtb -O build-fit -
I bsp -a of-list=3Dmy-board -a opensbi-path=3Dfw_dynamic.bin" -a default-
dt=3D"" -a spl-bss-pad=3D1 -a tpl-bss-pad=3D1 -a spl-dtb=3Dy
```

And i think binman should be "U-Boot agnostic" just like mkimage.

As well as i am using external DTB not part of U-Boot or Linux,
complied separately.

But you right about "building U-Boot with make" - I missed this moment
entirely.

>=20
> This also will trip the coverage test though I'm not sure how we want
> to=20
> test this feature to be honest.
>=20
> Cheers,
> Quentin
