Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D66DCD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 16:10:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1757A84D5B;
	Fri,  8 May 2026 18:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Slndjt8B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C39BD84D5B; Fri,  8 May 2026 18:10:06 +0200 (CEST)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7445384D17
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 18:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-47cacb4ed99so1367446b6e.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778256600; x=1778861400; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xJ/CfJ3yENduICr1IBNd6gcggUFcrxZ8xIsVWrAyI4o=;
 b=Slndjt8BHdsbGnaGVvYYJpzlRKFjbCTYJ68HGHlXfq52D0XyEQubEspSIz2V8Y+et0
 SRJu8BI8+WuEfya4l2v6zrnaohlC2E3UBoCZeflqpyZMdFXYvHq7aauhiY3XaT+4vpyS
 7t+p70PJ1a2/Pgp6h6iOqlM8uqAekzg8QmT2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778256600; x=1778861400;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xJ/CfJ3yENduICr1IBNd6gcggUFcrxZ8xIsVWrAyI4o=;
 b=Pbl0/ZE/1UgWui6M9Wfeqe4k0jxqZxrqIO3gq+GuRUXFTRHqXqf+XZaHpFccOzq2Qg
 ORmTWydkvP3pUZ4LiqB4WbYBhrTa6Ct/RwALiXmu8UUY5CwMdtCbIqns9IMB4k/nTsbH
 0ht8UIDiEw1ZYX8AyRXnRD5CDUcC3BAY547oL/UGdqOjtBvfcE2eLw9MTdjCR0B3YIt8
 pY5w2ZAcAssTc5EARPYtpILg6lFq8/7JUGnClYB28MZVa0gDadepQkfEJOQQt2/F6Aml
 clpaK2z5JYbqftgwEKt0/ThusRN0lg13pBaQuWRV8EUdekCuv2TQ1PYrfhuIVKgqR0Es
 ENyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/URVN0kSrqq6/Bh0AoQGapCcDtgVBLnPaK0RCG4p+3cAMuWNsxXocYOKlqPJRt8nyKK/Iu2n4=@lists.denx.de
X-Gm-Message-State: AOJu0YxUPL6MXyyRHvWju1vG+l4bwWnRdI4xsCN+mSlOL2bphQcxarTN
 cCY+zpUUiyxMacoPdJjW+gh+GxykyrLPQLE7L6B3zwhlNvmJmb4o82JRwqp/Q1+Zutk=
X-Gm-Gg: AeBDieswpjTX/pYCKrLQsdPi70sbGshcPgvn/pyfOYlkPE1sG1NmjVLdKOoXFupOqZe
 CD7DRyrc/d+nWxhKJ6DT+YtE3YSI0FUjv3x2UMseHE0KkrkRNjMUZepdFrt82eXjQRofMROWcuM
 AwcSLC6a9pRTpHN1ZNE1MZWjkPpefo8+mTzZ975bEij9jtIXFpWHQpjFekUFHH32cHunTDRiqKx
 GPs3ODoP18a5IN/AV1zmrS1xa3vb3YPvOCd9FIyB1BjadeLO8eniHsc8zOoLKr7BMJ2kcMKtbyN
 eQ9xOpbCfW1MTsl53hIcc5A2i+2wAUBX+K/fjGAbBjB3YCdcW3AconjMR70qXlRd4g54OHXHoFQ
 NGUS+aHzZP+PQqoz9QpfQ5pcjY5WrvOK7NUTCLP7jItEdmGWrhS12G6WEX8k8UM8RWqF3bnLzgU
 FVKIP1L3tjrPuYHwXOwmWy9rq1nBrjxeoi9UK5CKWihd1Hwsv4AuTTNFjRGlkNcO3ysTbxXzGdi
 M/hqWl2YQxU+vKHfk/vQnBU6ZTxxERgkl+pbJ17guSw/5bV1K4=
X-Received: by 2002:a05:6808:2211:b0:460:fce5:2fbd with SMTP id
 5614622812f47-480424942a5mr7785748b6e.23.1778256599935; 
 Fri, 08 May 2026 09:09:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367be2238sm1398730a34.6.2026.05.08.09.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 09:09:59 -0700 (PDT)
Date: Fri, 8 May 2026 10:09:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: Couple of clang warnings for Rockchip boards
Message-ID: <20260508160956.GX1614990@bill-the-cat>
References: <175e1198-2ac4-48de-b68a-c29f786832cc@cherry.de>
 <CAFLszThQ+kyCkojFm2=VNtLTtLDYT4iVmpqnto8awiMVqsct0Q@mail.gmail.com>
 <20260427144630.GG41863@bill-the-cat>
 <CAFLszTgga6eFp2aPF-MzJEqeqcEV-bMJhb4_ph_bE-1Dv4e_Cg@mail.gmail.com>
 <20260429142547.GT41863@bill-the-cat>
 <eab00828-0e87-4761-afc8-1a3295d18a26@cherry.de>
 <CAFLszTgKRS7xebQ0Y7+fOsTM7aUwnEH55L_H_NbaN_p=70THDg@mail.gmail.com>
 <20260504173544.GI1614990@bill-the-cat>
 <CAFLszTjESKRGDD3wi4ftxRdXR1X2JZcqybOMHdUYboZ7xjN3Qg@mail.gmail.com>
 <4ac27732-3697-43be-9585-35be67752938@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SMZqScFe7fcSCaao"
Content-Disposition: inline
In-Reply-To: <4ac27732-3697-43be-9585-35be67752938@cherry.de>
X-Clacks-Overhead: GNU Terry Pratchett
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


--SMZqScFe7fcSCaao
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2026 at 11:33:11AM +0200, Quentin Schulz wrote:
> Hi Simon,
>=20
> On 5/4/26 10:40 PM, Simon Glass wrote:
> > On Mon, 4 May 2026 at 11:35, Tom Rini <trini@konsulko.com> wrote:
> > >=20
> > > On Mon, May 04, 2026 at 05:14:13AM -0600, Simon Glass wrote:
> > > > Hi Quentin,
> > > >=20
> > > > On Wed, 29 Apr 2026 at 10:32, Quentin Schulz <quentin.schulz@cherry=
=2Ede> wrote:
> > > > >=20
> > > > > On 4/29/26 4:25 PM, Tom Rini wrote:
> > > > > > On Wed, Apr 29, 2026 at 08:18:14AM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >=20
> > > > > > > On Mon, 27 Apr 2026 at 08:46, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >=20
> > > > > > > > On Mon, Apr 27, 2026 at 11:54:09PM +1200, Simon Glass wrote:
> > > > > > > > > Hi Quentin,
> > > > > > > > >=20
> > > > > > > > > On Thu, 23 Apr 2026 at 22:24, Quentin Schulz <quentin.sch=
ulz@cherry.de> wrote:
> > > > > > > > > >=20
> > > > > > > > > > Hi Simon,
> > > > > > > > > >=20
> > > > > > > > > > On 4/22/26 11:57 PM, Simon Glass wrote:
> > > > > > > > > > > Hi Quentin,
> > > > > > > > > > >=20
> > > > > > > > > > > On Thu, 23 Apr 2026 at 01:26, Quentin Schulz <quentin=
=2Eschulz@cherry.de> wrote:
> > > > > > > > > > > >=20
> > > > > > > > > > > > Hi all,
> > > > > > > > > > > >=20
> > > > > > > > > > > > I'm looking into force-enabling CONFIG_WERROR for a=
ll Rockchip SoCs.
> > > > > > > > > > > > First, let me know if this is a bad idea :)
> > > > > > > > > > >=20
> > > > > > > > > > > I don't like it, as it makes development slower. I li=
ke to see all the
> > > > > > > > > > > warnings created by a change and tend to fix them ite=
ratively. We
> > > > > > > > > > > already have a warning check in CI. A better approach=
 is to
> > > > > > > > > > >=20
> > > > > > > > > > > Can you use: KCFLAGS=3D-Werror
> > > > > > > > > > >=20
> > > > > > > > > > > either in your environment or on the 'make' cmdline?
> > > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > Well, if it's during development, you can always disabl=
e WERROR? The
> > > > > > > > > > fact that I've never actually enabled -Werror locally i=
n about a decade
> > > > > > > > > > in U-Boot probably isn't a good sign. One of the things=
 that make me
> > > > > > > > > > wary though is compiler updates with new warnings. I've=
 tested with
> > > > > > > > > > clang 22, don't know when clang 23 is planned to be rel=
eased. GCC 16 is
> > > > > > > > > > about to be released as well.
> > > > > > > > > >=20
> > > > > > > > > > By having the check in CI, we have a longer-than-necess=
ary feedback loop
> > > > > > > > > > for contributors. Has this been an issue in the past? /=
me shrugs
> > > > > > > > >=20
> > > > > > > > > This is strange though, because people should see the war=
nings during
> > > > > > > > > development. I wonder if it is scrolling off the screen.
> > > > > > > > >=20
> > > > > > > > > One my bugbears is non-actionable output. When the build =
succeeds
> > > > > > > > > (with no warnings) I see no output, using 'buildman -I --=
board xxx -w
> > > > > > > > > -o /tmp/b/xxx' or in fact these days 'um build xxx'. This=
 uses 'make
> > > > > > > > > -s' under the hood, so that it doesn't print a huge list =
of filenames,
> > > > > > > > > etc. I also sometimes do a 'fresh' build with 'um build -=
F xxx' to
> > > > > > > > > check everything is clean ('buildman -m' does something s=
imilar).
> > > > > > > > >=20
> > > > > > > > > Note that buildman returns exit code 101 if there are any=
 warnings, so
> > > > > > > > > the build basically fails.
> > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > No defconfig seems to be setting this option, not sure =
exactly why that is.
> > > > > > > > >=20
> > > > > > > > > To me this is a difference between 'functionality' option=
s and
> > > > > > > > > development options. Putting development options in Kconf=
ig makes it
> > > > > > > > > harder to turn them on and off, since you must either edi=
t the
> > > > > > > > > defconfig or edit the .config file. It is easier to just =
pass an
> > > > > > > > > environment variable.
> > > > > > > >=20
> > > > > > > > The point of a configuration is that it configures the buil=
d. Stuff in
> > > > > > > > environment (directly or make FOO=3Dbar) is a workaround an=
d anti-pattern.
> > > > > > > > Having to run one of the config front-end to change the con=
fig is a
> > > > > > > > feature, and good thing.
> > > > > > >=20
> > > > > > > To give an example, we have boards which enable LTO, but it is
> > > > > > > sometimes useful to disable it during development - it used t=
o be a
> > > > > > > huge time sync but something seems to have changed recently, =
as I
> > > > > > > don't see much of a performance gap now. We don't want people
> > > > > > > disabling LTO in the defconfig, though. The same applies for =
things
> > > > > > > like V=3D1
> > > > > > >=20
> > > > > > > So I think there are build features which are of no use to en=
d-users,
> > > > > > > but are helpful for development. That is the distinction we h=
ave had
> > > > > > > for a while and it would be a shame to lose it.
> > > > > >=20
> > > > > > Yes, the LTO thing is a good example of something we shouldn't =
have done
> > > > > > really. Outside of sandbox you cannot just disable it.
> > > >=20
> > > > Are you sure about that?
> > >=20
> > > Yes. Outside of sandbox LTO is enabled because the platform binaries
> > > will exceed their non-optional size constraints.
> >=20
> > That is certainly true for some boards, but I'm not sure it is very man=
y.
> >=20
> > >=20
> > > > I seldom build with LTO, except for CI. For
> > > > an incremental build the non-LTO is often twice as fast. Most of the
> > > > time when developing new features I am just trying to make things
> > > > work, so it is big time-saver in the IDE. To some extent this is
> > > > changing, though (LSPs and AI tools). The main impact for me is with
> > > > sandbox incremental builds.
> > >=20
> > > We could maybe just drop LTO from sandbox, now that it's enabled more
> > > widely on hardware.
> >=20
> > The nice thing about LTO for sandbox is that it tests a different
> > build path. We could perhaps disable it for just the 'sandbox' board?
> >=20
> > >=20
> > > > > >=20
> > > > >=20
> > > > > FYI, the Linux kernel defaults to CONFIG_WERROR=3Dy. See commit
> > > > > 3fe617ccafd6 ("Enable '-Werror' by default for all kernel builds")
> > > > > (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it/commit/?id=3D3fe617ccafd6f5bb33c2391d6f4eeb41c1fd0151).
> > > >=20
> > > > Do we suffer from this same problem?
> > > >=20
> > > > >=20
> > > > > I wouldn't necessarily recommend to switch it on right now, but I=
 think
> > > > > it could be a good idea in the mid-term. We're also very far behi=
nd in
> > > > > terms of warn flags compared to the kernel. Syncing will take som=
e time
> > > > > though. For now I'm looking into enabling -Werror for host tools =
and
> > > > > this resulted in (so far) 21 patches.
> > > >=20
> > > > I must be misunderstanding what you are referring to here. I don't =
see
> > > > any warnings when building tools-only - certainly I would not put up
> > > > with that. Do you mean that you are enabling additional warnings?
> > > >=20
> > > > We already have CI checking (which fails on the first warning) and =
we
> > > > already show the warnings for normal builds. Importantly, without
> > > > -Werror, we show *all* the warnings rather than just stopping at the
> > > > first one depending on -j, etc.
> > > >=20
> > > > So forcing this option seems to be a tax on people who fix warnings,
> > > > imposed by those who don't. It really should be the other way around
> > > > :-)
> > > >=20
> > > > BTW we do have KCFLAGS which can be used to set Werror (and also
> > > > perhaps other things).
> > >=20
> > > I'll note that I just had to request changes on another patch because
> > > they didn't realize warnings had to be fixed. It's quite likely that
> > > making CONFIG_WERROR=3Dy will save more people more time (maybe docum=
ent
> > > make -k? I don't know what people don't know about these days, but I =
do
> > > "make -kj" a lot when doing the randconfig stuff for example) than wh=
at
> > > we do today.
> >=20
> > Yes, could be, particular if people are not using -s with make. I
> > really dislike warnings quite a lot. I'd be happy enough with
> > CONFIG_WERROR if we have an env var to disable -Werror like we have
> > for LTO.
> >=20
>=20
> I'll let Tom speak his mind whether that's a good idea.
>=20
> I really don't want to be touching scripts/Makefile.extrawarn once sync'ed
> with the one in Linux kernel's, so adding some logic in there is a no-no =
in
> my book. So it means we can only change the CONFIG_WERROR symbol. But we
> kinda don't want to rename it as it'll likely be used throughout the sour=
ce
> code (hopefully spreading more and more over time) since we also want to
> sync as much as possible kbuild/makefiles from the Linux kernel. So what I
> thought could be a way to make this more palatable to you would be to
> introduce an invisible symbol which depends on an env variable.
>=20
> Something like
>=20
> config DISABLE_WERROR_FROM_ENV
>   def_bool $(success, test "$(DISABLE_WERROR)" !=3D "1" )
>   help
>     Allow to override CONFIG_WERROR from .config via the DISABLE_WERROR
> environment variable.
>=20
> config WERROR
>   depends on !DISABLE_WERROR_FROM_ENV
>=20
> for example (untested).

Yes, I thought I was clear enough earlier in the thread. Changing this
behavior from the environment isn't something we should do and is bad
design. We're stuck with the LTO one for the moment and should not add
more.

--=20
Tom

--SMZqScFe7fcSCaao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaf4K1AAKCRAr4qD1Cr/k
CqP5AP4+Pkk2ubUXcMNABY9lPYuQmt5G670SSIswdEtogCcX6AD+J1AGgqq6UIjA
uBaynurRoX/b9e5LGfcUZ3Ib85XQDQ0=
=2keC
-----END PGP SIGNATURE-----

--SMZqScFe7fcSCaao--
