Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841A8C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 14:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95CAB8773C;
	Sun, 31 Dec 2023 15:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G0mgbpYy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29057877DA; Sun, 31 Dec 2023 15:01:40 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9649E87687
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 15:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-781048954d9so692951185a.1
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 06:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704031290; x=1704636090; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x8VcJox0oufgSSlCp9ISaIVz+sDgopWONOpFl6KIx7E=;
 b=G0mgbpYys/zO8e5lY4vG/ypGxepBgWGFKztT4BdbV8PbU3cxFRxriMKZ7ELAh+qdHR
 uShk2zJ8q8kiFxuVnlFimpezEtNVqwUVk4AAdYXEexiW9V1r6/1LiFn1QOt8SUo8UfV6
 iJFdO3OfNvFX6NA5G3IfHgycLgg02tGLalmm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704031290; x=1704636090;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8VcJox0oufgSSlCp9ISaIVz+sDgopWONOpFl6KIx7E=;
 b=ZnBFm8PuXT8bOSplGswgwR1M9hxAEiK0c+Dz1QMSODvXnAf5LrWk95mXGYMB7Waum0
 C9rrekgbnQCeoWhAsy2qHVwfcNfmb1vUmL2BWHrc3Q9Ms6eSv27hNiMEFOmXMRRSdGXW
 S7mphEDVe2LeE0PHy0qrtiEV8mup+SW5Gs4gEGuK9vxj56JxpUIpn1pkDV31Bmgc9ZhT
 2sFWjUCtSIq2rJu9hCJZ9cAjQwvXn43iLmNB71rrgce/qS20rJBDzjOscS0Hk+OKZnhw
 pFmvAZIEfTuZNDFgcCQXlhCv2uu3LZbsvtObDZsJskkdC5a5dYzYJSc5Fi7ovY5RWwYX
 q5+Q==
X-Gm-Message-State: AOJu0Yxie/oKytV3l19Wmkv7qL1Y/9OU+g46FqFC7SzlhiNdeaJK80Ji
 rge5M7JZDXjFXM2i18KKbCQCsaTEOkMf2w==
X-Google-Smtp-Source: AGHT+IF4Xw4/R65CGONkbqfYZG81bJ53/Ilc1M7PQPeX7wNnsZgQ7f5nuvqEEPQklJY8PJEuo1iMIQ==
X-Received: by 2002:ae9:c304:0:b0:781:777c:32a1 with SMTP id
 n4-20020ae9c304000000b00781777c32a1mr5151951qkg.89.1704031290175; 
 Sun, 31 Dec 2023 06:01:30 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 b14-20020a05620a0f8e00b00781823ddd45sm2342320qkn.18.2023.12.31.06.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 06:01:29 -0800 (PST)
Date: Sun, 31 Dec 2023 09:01:27 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Andreas =?iso-8859-1?Q?Bie=DFmann?= <andreas@biessmann.org>,
 Michal Simek <michal.simek@amd.com>,
 Michal Simek <monstr@monstr.eu>, Minkyu Kang <mk7.kang@samsung.com>,
 Thomas Chou <thomas@wytron.com.tw>
Subject: Re: [PATCH 0/9] dts: Move to SoC-specific build rules
Message-ID: <20231231140127.GA2652760@bill-the-cat>
References: <20231227082405.2202246-1-sjg@chromium.org>
 <20231227132156.GQ2652760@bill-the-cat>
 <CAFLszThBrAVSH2jYxhxFSETqr4za+BqjZBBjLaDokc1ZdrXXRw@mail.gmail.com>
 <20231228142311.GD2652760@bill-the-cat>
 <CAFLszTghB1ZObpxUe+afAp2zzQOfn2M9198ofsgnyW9cseG2Ew@mail.gmail.com>
 <20231228154019.GH2652760@bill-the-cat>
 <CAFLszTgZfAHATieERE1x8hhoFHpYDK4Vq4=VVmQapKEn63diyA@mail.gmail.com>
 <20231228204425.GQ2652760@bill-the-cat>
 <CALeDE9MfEd=xjwekR+oVPuWNR7TBPCMU6mc+Z7ig7tc1nhKu_Q@mail.gmail.com>
 <CAFLszTj0MQGUBcNqVTLZuOL=1YBD2pqL2+P8oLKqc5PnLq3GdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tseX2AB9SVEfPvgL"
Content-Disposition: inline
In-Reply-To: <CAFLszTj0MQGUBcNqVTLZuOL=1YBD2pqL2+P8oLKqc5PnLq3GdA@mail.gmail.com>
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


--tseX2AB9SVEfPvgL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 31, 2023 at 05:45:00AM -0700, Simon Glass wrote:
> -Scott as it is bouncing
>=20
> Hi,
>=20
> On Fri, Dec 29, 2023 at 9:46=E2=80=AFAM Peter Robinson <pbrobinson@gmail.=
com> wrote:
> >
> > On Fri, Dec 29, 2023 at 12:23=E2=80=AFAM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Thu, Dec 28, 2023 at 07:48:08PM +0000, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, Dec 28, 2023 at 3:40=E2=80=AFPM Tom Rini <trini@konsulko.co=
m> wrote:
> > > > >
> > > > > On Thu, Dec 28, 2023 at 03:09:40PM +0000, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Thu, Dec 28, 2023 at 2:23=E2=80=AFPM Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > >
> > > > > > > On Thu, Dec 28, 2023 at 01:37:07PM +0000, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Wed, Dec 27, 2023 at 1:21=E2=80=AFPM Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Dec 27, 2023 at 08:23:56AM +0000, Simon Glass wro=
te:
> > > > > > > > >
> > > > > > > > > > U-Boot builds devicetree binaries from its source tree.=
 As part of the
> > > > > > > > > > Kconfig conversion, the Makefiles were updated to align=
 with how this
> > > > > > > > > > is done in Linux: a single target for each SoC is used =
to build all the
> > > > > > > > > > .dtb files for that SoC.
> > > > > > > > > >
> > > > > > > > > > Since then, the Makefiles have devolved in some cases, =
resulting in
> > > > > > > > > > lots of target-specific build rules. Also Linux has mov=
ed to using
> > > > > > > > > > subdirectories for each vendor.
> > > > > > > > > >
> > > > > > > > > > Recent work aims to allow U-Boot to directly use device=
tree files from
> > > > > > > > > > Linux. This would be easier if the directory structure =
were the same.
> > > > > > > > > > Another recent discussion involved dropping the build r=
ules altogether.
> > > > > > > > > >
> > > > > > > > > > This series makes a start at cleaning up some of the bu=
ild rules, to
> > > > > > > > > > reduce the amount of code and make it easier to add new=
 boards for the
> > > > > > > > > > same SoC.
> > > > > > > > > >
> > > > > > > > > > One issue is that the ARCH_xxx Kconfig options between =
U-Boot and Linux
> > > > > > > > > > are not always the same. Given the large number of SoCs=
 and boards
> > > > > > > > > > supported by U-Boot, it would be useful to align these =
where possible.
> > > > > > > > >
> > > > > > > > > I don't know why we should start with this now, and furth=
er not being on
> > > > > > > > > top of Sumit's series to remove our duplicate dts files. =
And that's
> > > > > > > > > where we can have the conversation about for which cases =
it even makes
> > > > > > > > > sense to build all of the dts files for a given SoC.
> > > > > > > >
> > > > > > > > This is a completely different series - there are no confli=
cts with
> > > > > > > > Sumit's series so it can be applied before or after it.
> > > > > > > >
> > > > > > > > My goal here is to clean up our build rules, rather than ju=
st throwing
> > > > > > > > them all away, for reasons we have discussed previously. I =
filed [1]
> > > > > > > > to track that.
> > > > > > >
> > > > > > > Yes, I'm saying we shouldn't be doing anything this series do=
es until
> > > > > > > after Sumit's series has landed. Along with the fact that I d=
on't like
> > > > > > > what's going on in this series.
> > > > > >
> > > > > > This seems to again be the disagreement over whether a single DT
> > > > > > should be build for each board, or all the DTs for an SoC?
> > > > >
> > > > > It's about the disagreement on what we should be building, and wh=
at that
> > > > > infrastructure looks like. I do not like adding extra rules for
> > > > > "clarity" because they don't make things clearer, they lead to the
> > > > > unclear mess we have today getting worse. Most instructions are _=
not_
> > > > > "now take this dtb and this binary and .." but just "take this bi=
nary",
> > > > > because we already have the rules and logic to ensure we build the
> > > > > required dtbs. I also don't like the parts of this series that am=
ount
> > > > > to deck shuffling when we should just be taking the chairs away. =
There's
> > > > > just not nor will there be a case for omap3/4/5 platforms of "cha=
nge the
> > > > > dtb", so building more is pointless. For other SoCs, there may be=
 some
> > > > > cases of "this could have been just a DT change", like
> > > > > rock5b-rk3588_defconfig / rock5a-rk3588s_defconfig could share a =
board
> > > > > dir, but the configs are different and the dts are different, so =
I don't
> > > > > know that you could really just swap the dtbs.
> > > >
> > > > It is true that we have a different defconfig for each board, but I=
MO
> > > > that is not good. It is an artifact of the way the build system wor=
ks.
> > > > IMO Kconfig should be used to define sensible defaults so that the
> > > > defconfigs are nearly empty. Perhaps config fragments can be part of
> > > > the mix, if we can agree on [1].
> > > >
> > > > But if we let this genie out of the bottle, it will be impossible to
> > > > put back in. The devicetree should control the hardware in U-Boot a=
nd
> > > > it should be possible to use the same U-Boot proper on all boards
> > > > which use the same SoC.
> > >
> > > We've never been past the point where a few examples of closely relat=
ed
> > > boards can re-use the same U-Boot build and just change the device tr=
ee.
> > >
> > > It's going to be very SoC specific if we can ever do things like that,
> > > and it will also likely in turn become a question of where did the
> > > tricky bits that U-Boot used to do get shoved instead. You're not goi=
ng
> > > to combine board/beagle/beagle/beagle.c and board/ti/omap3evm/evm.c (=
and
> > > ignoring all of the other omap3 boards) and get one binary that works=
 on
> > > both, and just uses DT. Let alone that no one wants to do that work.
> > >
> > > You've mentioned Rockchip before as maybe a better example, but
> > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D383579&stat=
e=3D* was
> > > leading me to think that no, there's too much "this is what THIS
> > > hardware does" that means that no, there's going to be hardware
> > > variation that one must just handle in C. Or get more and new bindings
> > > accepted upstream to try and make that be data driven, and also possi=
bly
> > > have to deal with "that's policy, not hardware" type arguments and so
> > > forth.
>=20
> Oh wow yes that is crazy! But you can always check the compatible
> string if really necessary. It would be nice to use a sysinfo driver
> for this sort of thing. I should just be a full-time code reviewer...
>=20
> >
> > Related I've seen issues with nearly identical rockchips devices that
> > use different memory chips that as a result need different U-Boot
> > builds because the early boot part needs to initialise a completely
> > different set of memory and the two different sets of rules aren't
> > detectable at run-time nor are they even small enough to fit into
> > smem.
>=20
> Some of the differences are real/important, like memory settings, some
> are not. For boards with enough SRAM that SPL can use DM/DT, we can
> deal with these.
>=20
> But even if SPL does need to be custom, that is better than having a
> full, separate U-Boot for every single board.

I'm not sure that's a use case anyone else has or wants, and I disagree
that building a unique SPL and then more generic U-Boot is a win, in
practical and effort terms. The only win I see there is it would be part
of what I've said before about how I do not want the "XPL" series you've
talked about before, but instead think Yamada-san was right in hindsight
and in short we should have "fooboard_defconfig",
"fooboard_spl_defconfig" and "fooboard_tpl_defconfig" and you make each
config and build each config by itself. In that context, yes, you could
have barvend-fooboard_rev1_spl_defconfig,
barvend-fooboard_rev2_spl_defconfig and barvend-fooboard_defconfig to
get a more generic U-Boot build.  But nothing so much like an OS kernel
because we care about binary size and rarely does the OS vendor (but
some production cases in turn do), so outside of SoC-vendor where
showing off features is more important than size, most of the time, will
you see an actual use for SoC-generic U-Boot build.

--=20
Tom

--tseX2AB9SVEfPvgL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWRdDcACgkQFHw5/5Y0
tyx26gwAl93YA/l5dlPtWuOxkFaK3Q6sOFafLSTgW8cGPTMkUwRESyJR024Sljpy
0thedTSZDJNSXuvnYFkgVG0pDrKD//yG2iUB14qNyP3G1LTN44TogPXayV6qRTZm
yQNvZFtlT+hLwhhZXFAQdz36vRQWbRvxeApI+TsXzNfV/8fQHc9J/6j+h4iVP2P7
SHvMM8oDS1Wy0lSsGFAO/nMwLDCEikICBQBkiUFfvIAOvdH46dWIp7xWWw4h0Mw2
aQpqSVE/KUpRitG0xm/+g7FOIhihIdTMZGoPGtzCooQEU1LrkBJE++AaEqEcKt9u
3tLjlYYufowgfZ+v3GCMVJQZGSD5T78s4Xw4RkkF9OlhcOrlmA0rgKI821ednH34
L67aULoFcP2kCIFjCZuCwcApPetyp7JEJYAkAr7V+57nmyeaa26mhy9xeMPF+v+E
Iw6LOTC4yyzhqRp3L6+jz9NfLkYmkPu3ttC8NGM//Gf2wMwRdE67eQiPAsC7ev62
mVb/GWwF
=xmnA
-----END PGP SIGNATURE-----

--tseX2AB9SVEfPvgL--
