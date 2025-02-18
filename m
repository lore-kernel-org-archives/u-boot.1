Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92684C021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 00:40:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A61F80BAE;
	Tue, 18 Feb 2025 01:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nM4CuAwt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B4ED80843; Tue, 18 Feb 2025 01:40:35 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68444807F1
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 01:40:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2fc20e0f0ceso6115504a91.3
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 16:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739839230; x=1740444030; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WbMIybiJ5JaQ2uCyKVINsUHVeGd+ha4sPG5+Ml+0K7I=;
 b=nM4CuAwtuDJw3hQJE/6289+gG4aTDm2+TXTaSN90zSs0HmAjXFqOQ1sen8hdSQBXfq
 XWbOYGQjWeHMSFBFA9IOGfPJR88ey9bbyuv4fbbAz2P0w+rgcIs61lOptJJm7ClhTLrz
 gLoQG23LUVsLolo5RVnlf/1q70L0ZeejaHO/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739839230; x=1740444030;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WbMIybiJ5JaQ2uCyKVINsUHVeGd+ha4sPG5+Ml+0K7I=;
 b=V7Ab8eCAtotzojor8eowpbVlw4P6IIeQ53EliCA+D6XTjiz2KNHCPI4OZI24b1kDI+
 JuvQ2nhjwNdQ67TSToPWICoDdQa0iUv9FJCQbKduTP0CDnKUMSBVWvjs8RWpVgGj0xJi
 Z6VauEZpfDhekL4P4se8GNcFzbOHj+kxiBN/ZPNy1fnsSS85cBUyeGLpWiDfSuvnVttm
 RvjUd7zMTWjrbPT6dsGxwcGPu4trVtfZH80CDUnRzTV5viD1Pvm/wN1DZL0p5wSv07ko
 uR4RE0q9+dYohwTf4BpsgNWURQAPr8mcVRwo686AnAYmFO7K2vSmJ90iUBO1Te5UGAA0
 713w==
X-Gm-Message-State: AOJu0YyP1NObpp9C6DN2HJ5OvPwrzQ7ilj6kT2aYj3gBZImMewfaYmW8
 DJhhphsueWSZ3Kae8rxDqy1UWYAmWpw5Y+HoJFsG514qL7Ub/S3xpQSRQyo0G1A=
X-Gm-Gg: ASbGncuqRn/CmGpNrQKKI8N5xjmFPUqY2NunLxy8S9ZJfy/msQZb5FnCdIstLjq4SvN
 u9saP/KcRieGCDNI3QeIwRMfwQ/u5hiOQmUW3y1DmI3GkAso7CkkStX4E0tDE+0eAzsAImCzZYf
 h4qyN/i+ZKyscDWteK+E543QzlbTcsg8/mvRGfxP9SO8VG3z9wTP9C2ORPwOTJataforVq7O1kY
 u/ocnmwwY9Uo05wmTsBcjkViPiv+Yp353vjehchYBqVknoLzfmUnlnhoWI5uxiy5ZU6tTJqoAaz
 YyVTugRvCyLuQw==
X-Google-Smtp-Source: AGHT+IEoGwVc2C5ZMAAThFb53G6M2nHl0FqDvAkjY9dWUaz83AEzWQJpGgF4s260qDK4oRVKMRM9vw==
X-Received: by 2002:a17:90b:2d07:b0:2ee:c2b5:97a0 with SMTP id
 98e67ed59e1d1-2fc41045e7emr17462321a91.25.1739839229504; 
 Mon, 17 Feb 2025 16:40:29 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2faa5d27514sm5113495a91.1.2025.02.17.16.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 16:40:28 -0800 (PST)
Date: Mon, 17 Feb 2025 18:40:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: xPL Proposal
Message-ID: <20250218004025.GA1233568@bill-the-cat>
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
 <20250211212222.GH1233568@bill-the-cat>
 <20250217185035.GT1233568@bill-the-cat>
 <CAFLszTjeiX+40we55cH+0nmzpLvDZ5j=JQU21hZ1VQ85Arb0hQ@mail.gmail.com>
 <20250217192156.GV1233568@bill-the-cat>
 <CAFLszThTF+VQ2LduU6Ji_a-W8hYt+i38j-C7ccNZwJb+XkfwRQ@mail.gmail.com>
 <20250217194732.GY1233568@bill-the-cat>
 <20250217201751.GZ1233568@bill-the-cat>
 <CAFLszTjvoo=z8DDJjmL0_H2qKHX8vKTCVXBG+pth009HekdUOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XMqCeU/n5i9rHZdX"
Content-Disposition: inline
In-Reply-To: <CAFLszTjvoo=z8DDJjmL0_H2qKHX8vKTCVXBG+pth009HekdUOQ@mail.gmail.com>
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


--XMqCeU/n5i9rHZdX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 01:39:37PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 17 Feb 2025 at 13:17, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Feb 17, 2025 at 01:47:32PM -0600, Tom Rini wrote:
> > > On Mon, Feb 17, 2025 at 12:34:01PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 17 Feb 2025 at 12:22, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Feb 17, 2025 at 12:11:12PM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 17 Feb 2025 at 11:50, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Tue, Feb 11, 2025 at 03:22:22PM -0600, Tom Rini wrote:
> > > > > > > > On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon Glass wrote:
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > I just wanted to send a note to (re-)introduce my ideas[1=
] for the
> > > > > > > > > next iteration of xPL.
> > > > > > > > >
> > > > > > > > > A recent series introduced 'xPL' as the name for the vari=
ous
> > > > > > > > > pre-U-Boot phases, so now CONFIG_XPL_BUILD means that thi=
s is any xPL
> > > > > > > > > phase and CONFIG_SPL means this really is the SPL phase, =
not TPL. We
> > > > > > > > > still use filenames and function naming which uses 'spl',=
 but could
> > > > > > > > > potentially adjust that.
> > > > > > > > >
> > > > > > > > > The major remaining problem IMO is that it is quite trick=
y and
> > > > > > > > > expensive (in terms of time) to add a new phase. We also =
have some
> > > > > > > > > medium-sized problems:
> > > > > > > > >
> > > > > > > > > a. The $(PHASE_), $(SPL_) rules in the Makefile are visua=
lly ugly and
> > > > > > > > > can be confusing, particularly when combined with ifdef a=
nd ifneq
> > > > > > > > >
> > > > > > > > > b. We have both CONFIG_IS_ENABLED() and IS_ENABLED() and =
they mean
> > > > > > > > > different things. For any given option, some code uses on=
e and some
> > > > > > > > > the other, depending on what problems people have met alo=
ng the way.
> > > > > > > > >
> > > > > > > > > c. An option like CONFIG_FOO is ambiguous, in that it cou=
ld mean that
> > > > > > > > > the option is enabled in one or more xPL phases, or just =
in U-Boot
> > > > > > > > > proper. The only way to know is to look for $(PHASE_) etc=
=2E in the
> > > > > > > > > Makefiles and CONFIG_IS_ENABLED() in the code. This is ve=
ry confusing
> > > > > > > > > and has not scaled well.
> > > > > > > > >
> > > > > > > > > d. We need to retain an important feature: options from d=
ifferent
> > > > > > > > > phases can depend on each other. As an example, we might =
want to
> > > > > > > > > enable MMC in SPL by default, if MMC is enabled in U-Boot=
 proper. We
> > > > > > > > > may also want to share values between phases, such as TEX=
T_BASE. We
> > > > > > > > > can do this easily today, just by adding Kconfig rules.
> > > > > > > >
> > > > > > > > I agree with a through c and for d there are likely some ca=
ses even if
> > > > > > > > I'm not sure TEXT_BASE is a good example. But I'm not sure =
it's as
> > > > > > > > important as the other ones.
> > > > > > > >
> > > > > > > > > Proposal
> > > > > > > > >
> > > > > > > > > 1. Adjust kconf to generate separate autoconf.h files for=
 each phase.
> > > > > > > > > These contain the values for each Kconfig option for that=
 phase. For
> > > > > > > > > example CONFIG_TEXT_BASE in autoconf_spl.h is SPL's text =
base.
> > > > > > > > >
> > > > > > > > > 2. Add a file to resolve the ambiguity in (c) above, list=
ing the
> > > > > > > > > Kconfig options which should not be enabled/valid in any =
xPL build.
> > > > > > > > > There are around 200 of these.
> > > > > > > > >
> > > > > > > > > 3. Introduce CONFIG_PPL as a new prefix, meaning U-Boot p=
roper (only),
> > > > > > > > > useful in rare cases. This indicates that the option appl=
ies only to
> > > > > > > > > U-Boot proper and is not defined in any xPL build. It is =
analogous to
> > > > > > > > > CONFIG_TPL_xxx meaning 'enabled in TPL'. Only a dozen of =
these are
> > > > > > > > > needed at present, basically to allow access to the value=
 for another
> > > > > > > > > phase, e.g. SPL wanting to find CONFIG_PPL_TEXT_BASE so t=
hat it knows
> > > > > > > > > the address to which U-Boot should be loaded.
> > > > > > > > >
> > > > > > > > > 4. There is no change to the existing defconfig files, or=
 'make
> > > > > > > > > menuconfig', which works just as today, including depende=
ncies between
> > > > > > > > > options across all phases.
> > > > > > > > >
> > > > > > > > > 5. (next) Expand the Kconfig language[2] to support decla=
ring phases
> > > > > > > > > (SPL, TPL, etc.) and remove the need for duplicating opti=
ons (DM_MMC,
> > > > > > > > > SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allowing an optio=
n to be
> > > > > > > > > declared once for any/all phases. We can then drop the fi=
le in 2
> > > > > > > > > above.
> > > > > > > > >
> > > > > > > > > With this, maintaining Kconfig options, Makefiles and add=
ing a new
> > > > > > > > > phase should be considerably easier.
> > > > > > > >
> > > > > > > > I think this will not make our life easier, it will make th=
ings harder.
> > > > > > > >
> > > > > > > > I think what we've reached now shows that Yamada-san was co=
rrect at the
> > > > > > > > time in saying that we were going down the wrong path with =
how we
> > > > > > > > handled SPL/TPL.
> > > > > > > >
> > > > > > > > My request instead is:
> > > > > > > > - Largely drop SPL/TPL/VPL (so no DM_MMC and SPL_DM_MMC and=
 so on, just
> > > > > > > >   DM_MMC) as a prefix.
> > > > > > > > - Likely need to introduce a PPL symbol as you suggest.
> > > > > > > > - Make PPL/SPL/TPL/VPL be a choice statement when building =
a defconfig.
> > > > > > > > - Split something like rockpro64-rk3399_defconfig in to
> > > > > > > >   rockpro64-rk3399_ppl_defconfig
> > > > > > > >   rockpro64-rk3399_spl_defconfig rockpro64-rk3399_tpl_defco=
nfig
> > > > > > > >   and add Makefile logic such that for X_defconfig as a bui=
ld target but
> > > > > > > >   not configs/X_defconfig not existing, we see if any of
> > > > > > > >   configs/X_{ppl,spl,tpl,vpl}_defconfig exist and we run a =
builds in
> > > > > > > >   subdirectories of our object directory, and then using bi=
nman combine
> > > > > > > >   as needed.
> > > > > > > >   - Maybe instead the Makefile logic above we would parse X=
_defconfig
> > > > > > > >     and see if it's a different format of say PHASE:file to=
 make it
> > > > > > > >     easier to say share a single TPL config with all rk3399=
, have a few
> > > > > > > >     common SPL configs and then just a board specific PPL.
> > > > > > > >
> > > > > > > > This solves (a) by removing them entirely. This solves (b) =
by removing
> > > > > > > > the ambiguity entirely (it will be enabled or not). As a bo=
nus for (b)
> > > > > > > > we can switch everyone to IS_ENABLED(CONFIG_FOO) and match =
up with the
> > > > > > > > Linux Kernel again. This solves (c) again by removing it en=
tirely.
> > > > > > >
> > > > > > > Lets come back up here, to my proposal, since parts of it see=
m to have
> > > > > > > not been clear enough. While what I'm proposing should work f=
or any
> > > > > > > platform and xPL -> xPL -> ... -> PPL, for this example let u=
s assume
> > > > > > > rockpro64-rk3399 supports the flow of TPL -> SPL -> PPL. Also=
, to
> > > > > > > compare with today, it will be helpful to run "make
> > > > > > > O=3D/tmp/rockpro64-rk3399_current rockpro64-rk3399_config" an=
d have the
> > > > > > > resulting .config file available.
> > > > > > >
> > > > > > > There shall be configs/rockpro64-rk3399_tpl_defconfig. This w=
ill contain
> > > > > > > lines such as:
> > > > > > > CONFIG_ARM=3Dy
> > > > > > > CONFIG_ARCH_ROCKCHIP=3Dy
> > > > > > > CONFIG_ROCKCHIP_RK3399=3Dy
> > > > > > > CONFIG_TPL=3Dy
> > > > > > >
> > > > > > > When you run "make O=3D/tmp/rockpro64-rk3399_tpl rockpro64-rk=
3399_tpl_defconfig"
> > > > > > > the resulting .config file will contain lines such as:
> > > > > > > # CONFIG_ROCKCHIP_EXTERNAL_TPL is not set
> > > > > > > as this only makes sense in the context of building something=
 that will
> > > > > > > be TPL.
> > > > > > >
> > > > > > > A more complex example is that it will also contain:
> > > > > > > CONFIG_TPL_ROCKCHIP_COMMON_BOARD=3Dy
> > > > > > >
> > > > > > > Because looking at arch/arm/mach-rockchip/Makefile a bunch of=
 that will
> > > > > > > be able to be simplified (and spl_common.c should be renamed =
to
> > > > > > > xpl_common.c) to:
> > > > > > > obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-o=
rder.o xpl_common.o
> > > > > > > obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o xpl_common=
=2Eo
> > > > > > >
> > > > > > > The .config file here will also contain:
> > > > > > > CONFIG_DM_SERIAL=3Dy
> > > > > > >
> > > > > > > What it will not contain is:
> > > > > > > CONFIG_TPL_DM_SERIAL=3Dy
> > > > > > >
> > > > > > > This is because there is no 'config TPL_DM_SERIAL' option in
> > > > > > > drivers/serial/Kconfig anymore.
> > > > > > >
> > > > > > > When you next run "make O=3D/tmp/rockpro64-rk3399_tpl all" th=
e results in
> > > > > > > /tmp/rockpro64-rk3399_tpl would be similar to the results as =
under
> > > > > > > "/tmp/rockpro64-rk3399/tpl/" when building today.
> > > > > > >
> > > > > > > The contents of configs/rockpro64-rk3399_spl_defconfig would =
be similar
> > > > > > > to the tpl one, except with SPL-only-ever-valid options such =
as
> > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD=3Dy but otherwise have CONFI=
G_DM_SERIAL=3Dy
> > > > > > > and no CONFIG_SPL_DM_SERIAL=3Dy, and when building the "all" =
target, you
> > > > > > > would only get similar results to what is under the spl/ dire=
ctory
> > > > > > > today.
> > > > > > >
> > > > > > > Next we have configs/rockpro64-rk3399_ppl_defconfig.  When yo=
u run "make
> > > > > > > O=3D/tmp/rockpro64-rk3399_ppl rockpro64-rk3399_ppl_defconfig"=
 the
> > > > > > > important difference is what you do not have. You do not have:
> > > > > > > CONFIG_SPL=3Dy
> > > > > > > CONFIG_TPL=3Dy
> > > > > > >
> > > > > > > Because we are not building SPL nor TPL. We're just making fu=
ll U-Boot
> > > > > > > itself. This is where in more full examples and with addition=
al
> > > > > > > restructure a "generic-arm64_ppl_defconfig" makes sense and b=
e used
> > > > > > > instead.
> > > > > > >
> > > > > > > This brings up what to do with "ockpro64-rk3399_defconfig". A=
nd I'm a
> > > > > > > little unsure which of the things I mentioned above is best. =
It's
> > > > > > > either:
> > > > > > > a) Does not exist, top-level Makefile says roughly:
> > > > > > > %_defconfig: %_tpl_defconfig %_spl_defconfig %_ppl_defconfig
> > > > > > >   make O=3D$(objdir)/tpl %_tpl_defconfig all
> > > > > > >   make O=3D$(objdir)/spl %_spl_defconfig all
> > > > > > >   make O=3D$(objdir)/ppl %_ppl_defconfig all
> > > > > > >
> > > > > > > But this might be too rigid.
> > > > > > > b) It contains:
> > > > > > > PHASE:VPL:rockpro64-rk3399_vpl_defconfig
> > > > > > > PHASE:TPL:rockpro64-rk3399_tpl_defconfig
> > > > > > > PHASE:SPL:rockpro64-rk3399_spl_defconfig
> > > > > > > PHASE:PPL:rockpro64-rk3399_ppl_defconfig
> > > > > > > And the top-level Makefile looks like:
> > > > > > > %_defconfig:
> > > > > > >   grep -q ^PHASE $@ || fatal "Invalid defconfig file, please =
see..."
> > > > > > >   foreach line in $@
> > > > > > >     make O=3D$(objdir)/$PHASE $CONFIGFILE all
> > > > > > >
> > > > > > > It could also be some other suggestion.
> > > > > >
> > > > > > Thanks for writing that up. It is somewhat clearer.
> > > > > >
> > > > > > What happens to the Makefiles? Do they still have $(PHASE_) in =
them?
> > > > >
> > > > > No. Because CONFIG_SPL_FIT would never exist, $(CONFIG_$(PHASE_)F=
IT)
> > > > > would be meaningless. Only rockpro64-rk3399_spl_defconfig would s=
ay
> > > > > CONFIG_FIT=3Dy (or more likely, only the resulting .config would =
say
> > > > > CONFIG_FIT=3Dy just like how configs/rockpro64-rk3399_defconfig d=
oesn't
> > > > > say CONFIG_FIT=3Dy nor CONFIG_SPL_FIT=3Dy).
> > > >
> > > > But just above you said:
> > > >
> > > > > I believe this proposal will lead to the code and Makefiles being=
 less
> > > > > clear than they are today. The line:
> > > > > drivers/Makefile:obj-$(CONFIG_$(PHASE_)BLK) +=3D block/
> > > > > will become:
> > > > > drivers/Makefile:obj-$(CONFIG_BLK) +=3D block/
> > > > > without being clear that it could reference either full U-Boot (P=
PL) or
> > > > > some xPL phase. While the same Makefile will continue to have (co=
mments
> > > > > my own):
> > > > > obj-y +=3D mtd/ # Subdirectory Makefiles control build contents
> > > > > obj-$(CONFIG_MULTIPLEXER) +=3D mux/ # Only valid for PPL.
> > > > >
> > > > > And so the situation for humans will be worse off than today beca=
use
> > > > > while $(PHASE_) and $(XPL_) are confusing at times, they make it =
clear
> > > > > what can and cannot be enabled in PPL vs xPL.
> > > > >
> > > > > Doing "something" is not better than doing nothing in this case.
> > > >
> > > > So why is OK for your proposal to drop the $(PHASE_) stuff, but not=
 mine?
> > >
> > > Because your proposal keeps CONFIG_SPL_BLK (and config SPL_BLK) and h=
as
> > > a .config file which says "CONFIG_SPL_BLK=3Dy" but mine doesn't.
> > >
>=20
> > With my
> > proposal "I have a problem, and I want to see what my SPL build has with
> > CONFIG_BLK=3Dy. I can see hits in the source tree for CONFIG_BLK, the
> > symbol I set, I can solve my problem."
>=20
> There will be at least some matches, e.g. CONFIG_SPL_BLK in the
> defconfig files and 'config SPL_BLK' in the source tree.

Yes, and that's confusing. I am arguing that your statement is more
confusing than $(PHASE_)BLK is.

> > > Or to try and explain differently, with your proposal "I have a probl=
em,
> > > and I want to see what builds with CONFIG_SPL_BLK=3Dy. Why is there no
> > > match in the source tree for CONFIG_SPL_BLK or even SPL_BLK". With my
> > > proposal "I have a problem, and I want to see what my SPL build has w=
ith
> > > CONFIG_BLK=3Dy. I can see hits in the source tree for CONFIG_BLK, the
> > > symbol I set, I can solve my problem."
>=20
> Well, CONFIG_BLK will be in the source tree; it just means different
> things for different phases.

And it will be, with your proposal, controlled by BLK or SPL_BLK or
TPL_BLK or VPL_BLK in the .config file but only CONFIG_BLK in Makefile
and code.

> It sounds like you want to get rid of the xPL prefixes for Kconfig
> options, and that overrides all other considerations?

It's one of the big problems we have today, and splc-working shows how
much further the duplication must go. It's why I suggested the language
modification before.

> > My other try here was a bit unclear actually because of the confusion
> > state your proposal gives us. Try try again directly, the problem is
> > that CONFIG_SPL_BLK will be set (or unset) but not referenced in code.
> > This will be true for many but not all SPL symbols as
> > CONFIG_SPL_ROCKCHIP_COMMON_BOARD for example will still exist and need
> > to be referenced. This is a more confusing state than $(PHASE_). $(XPL_)
> > I think can just be replaced with $(PHASE_) but I haven't confirmed (I
> > think it does show that the old way was confusing however).
>=20
> OK, I think I see. You don't want people to have to 'know' that
> CONFIG_xPL_xxx is used to control feature xxx in each xPL build?

I'm saying they have to know that, and also know which symbols that's
not true for. And that is more confusing than today. I'm saying that
compared with today's arch/arm/mach-rockchip/Makefile the following is
worse:
diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makef=
ile
index 5e7edc99cdc4..3b176966f75b 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -29,7 +29,7 @@ ifeq ($(CONFIG_TPL_BUILD),)
 obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
 endif
=20
-obj-$(CONFIG_$(PHASE_)RAM) +=3D sdram.o
+obj-$(CONFIG_RAM) +=3D sdram.o
=20
 obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
 obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/

(And CONFIG_TPL_RAM and CONFIG_SPL_RAM still exist).

And this is better:

diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makef=
ile
index 5e7edc99cdc4..23c30f68f878 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -7,15 +7,13 @@
 # this may have entered from ATF with the stack-pointer pointing to
 # inaccessible/protected memory (and the bootrom-helper assumes that
 # the stack-pointer is valid before switching to the U-Boot stack).
-obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
-obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-order.o sp=
l_common.o
-obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
-obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_common.o
-obj-tpl-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
+obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
+obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) +=3D spl.o spl-boot-order.o spl_co=
mmon.o
+obj-$(CONFIG_ROCKCHIP_BROM_HELPER) +=3D bootrom.o
+obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) +=3D tpl.o spl_common.o
+obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30-board-tpl.o
=20
-obj-spl-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl.o
-
-ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
+obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036-board-spl.o
=20
 # Always include boot_mode.o, as we bypass it (i.e. turn it off)
 # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This way,
@@ -23,14 +21,13 @@ ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
 # meaning "turn it off".
 obj-y +=3D boot_mode.o
 obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) +=3D board.o
-endif
=20
-ifeq ($(CONFIG_TPL_BUILD),)
 obj-$(CONFIG_DISPLAY_CPUINFO) +=3D cpu-info.o
-endif
=20
-obj-$(CONFIG_$(PHASE_)RAM) +=3D sdram.o
+obj-$(CONFIG_RAM) +=3D sdram.o
=20
+ifdef CONFIG_PPL
+# TODO: Audit these Makefiles see if they really must be PPL only
 obj-$(CONFIG_ROCKCHIP_PX30) +=3D px30/
 obj-$(CONFIG_ROCKCHIP_RK3036) +=3D rk3036/
 obj-$(CONFIG_ROCKCHIP_RK3066) +=3D rk3066/
@@ -46,10 +43,4 @@ obj-$(CONFIG_ROCKCHIP_RK3568) +=3D rk3568/
 obj-$(CONFIG_ROCKCHIP_RK3588) +=3D rk3588/
 obj-$(CONFIG_ROCKCHIP_RV1108) +=3D rv1108/
 obj-$(CONFIG_ROCKCHIP_RV1126) +=3D rv1126/
-
-# Clear out SPL objects, in case this is a TPL build
-obj-spl-$(CONFIG_TPL_BUILD) =3D
-
-# Now add SPL/TPL objects back into the main build
-obj-$(CONFIG_XPL_BUILD) +=3D $(obj-spl-y)
-obj-$(CONFIG_TPL_BUILD) +=3D $(obj-tpl-y)
+endif
(CONFIG_SPL_RAM and CONFIG_TPL_RAM no longer exist as options).

--=20
Tom

--XMqCeU/n5i9rHZdX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmez1vIACgkQFHw5/5Y0
tyyNQQv+JeKIHERQA3yYL8MDQLzOTXNt3V/LY4sJCvwI3+Q3eIK093z3C8JewksG
glMPD1Y3wSfr7+KbGxHddteI3Dynobd6Imp8AHbk53P/5l3t0HjNs1Y2HxzmS3rF
AKi93OosKC0GHiJzdlrRUaw3iwoaVZZTliyd8ydIsa/dBp1lXN+j5KWMxEIBKi2M
Xamo/fdA8SWcJAUIqjdtP9XkMdwt6XUpgs+Hl8IU0TlnIBsRHcG4byO+ddXxHi8y
iQ5NHCiQfQJc1AiRWzu8jy9QI7gHkI2JPuaLmjC174x6CLiw9bV47kIKIkTfOcg9
bJW9q42b2rfajXbTV8YQJjku0WLLsLCmuqNGjm/7KqGQvRZ/zfN2EhmeRKHbXrwM
OvDrP+ntFKiWGyDBA8R+xDwiUtTkU+J6gzmDgzlK3AQtJu26UfpWefZDtf2kMyCF
lUojoLOEiIPH5hYUf6vx6tP9HznWeLp+wgrVm/37QLEaIFslIuji9iqTAN3SJQ06
izX7GGq6
=oO7/
-----END PGP SIGNATURE-----

--XMqCeU/n5i9rHZdX--
