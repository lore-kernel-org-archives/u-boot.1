Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2EEC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 14:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 571BE80F56;
	Wed, 19 Feb 2025 15:48:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CSRbmrvN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A874E80F53; Wed, 19 Feb 2025 15:48:35 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AACC800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 15:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso1043048566b.1
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 06:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739976511; x=1740581311; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H6pe568PdJSZGMVQsWK2JYbbhnjdv3w8iweA/n1oeq8=;
 b=CSRbmrvNXdcv6vpfO7zfKxgc7Sc2A+VBWyFE4OTLKIB+r/LNXWrg0SoaTH2WZLCxdn
 bvKyFmgNXPH1b52Wy6e2nxngcrXGAMZCQsoKkW2BEfS7yS/T+h32yFucIleMi6QNXiLm
 4TY9LBhfWMim/QWIElP4z4ZGH04gwNvbohRsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739976511; x=1740581311;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H6pe568PdJSZGMVQsWK2JYbbhnjdv3w8iweA/n1oeq8=;
 b=CkBDB9KqLOhz4EQpzMtfMlj6tegAcaEEg8V1zLbOSAOLBRERLwrHgvHLuMUFN6RSk6
 2NVoLQ1X8xFUStVTcW0tOCwgRrHpzi05MEjTVHL8Z4khdNsQGgfzlq2LEhsyRf9gKfWN
 H8HBFKbnI03kTp43NHRS6uQY+v7Uewp/4fOVZ7HU+x+So1Vn1jwVwF3J4CIr0ggGrUmK
 lwYJwP/2k8UTFyvB+e6TfONYpYxqo75WQ+zIwz1Nt7slcUCLGyol7qFGnvUtjiptiD4L
 jT3Id3poe59T//N6RmAuhZeJSL8GPhK19K95ReG8f8+cwXQXuQVvqFl+qDsLf8ZN5k9a
 966A==
X-Gm-Message-State: AOJu0YxAJInT088yWT75E6nd3R8YP/PfryW48VsQnKzlfXILmRwUwTTR
 vhUrTNOFiXuNXzEGOoAqbkjB1LK04a8io6MpAlhz//7Gd5FpzwxtwFbW9I+0rE8WXLz05kQeyoL
 dMKrL19KVs10SdsqvgO34Cv8d5JknLpczYvSW
X-Gm-Gg: ASbGnctauajCCIqvcWuYfivof+M4z3gRzQsG9NIRaRXQnUgQEoSdQ+64HqS6OtvVr8/
 Jkkcj6zFxfgAwymFQtrXpGCQ20QLArfu9F7nM7fVaqPyhSb2Z2e1jBMHqmNVaDGvcZyIcYjCAiA
 ==
X-Google-Smtp-Source: AGHT+IEcsY19JtKONi24LvoK16vjhwVJg7J36LumxIEUaYJKYVtTthPXkY9tAY/tDx25yRwzd7aBZk4M856BN0LOzXQ=
X-Received: by 2002:a17:907:1c16:b0:aba:6378:5ba8 with SMTP id
 a640c23a62f3a-abbcd0d5fa9mr365124066b.55.1739976510462; Wed, 19 Feb 2025
 06:48:30 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTjeiX+40we55cH+0nmzpLvDZ5j=JQU21hZ1VQ85Arb0hQ@mail.gmail.com>
 <20250217192156.GV1233568@bill-the-cat>
 <CAFLszThTF+VQ2LduU6Ji_a-W8hYt+i38j-C7ccNZwJb+XkfwRQ@mail.gmail.com>
 <20250217194732.GY1233568@bill-the-cat>
 <20250217201751.GZ1233568@bill-the-cat>
 <CAFLszTjvoo=z8DDJjmL0_H2qKHX8vKTCVXBG+pth009HekdUOQ@mail.gmail.com>
 <20250218004025.GA1233568@bill-the-cat>
 <CAFLszTh3FD9KEzDcMOuf=otMBhV3BarTGe68Qs_w1fFa1JT2XA@mail.gmail.com>
 <20250218144627.GC1233568@bill-the-cat>
 <CAFLszTjEawR5urHwb0MD70-0y-yyFLPgRwKNv4vxWVj8MzaWLg@mail.gmail.com>
 <20250219010708.GS1233568@bill-the-cat>
In-Reply-To: <20250219010708.GS1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Feb 2025 07:48:17 -0700
X-Gm-Features: AWEUYZmbIxWQAqfLoFKw7-ahCZ78ySf6bm1_-UBS6PvMD43LXiUsOmOkBWuIfPI
Message-ID: <CAFLszTg5Q8eMPajxQ+wFgLgK=JhssN6KY9yg5kd0mW--NVypLg@mail.gmail.com>
Subject: Re: xPL Proposal
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
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

Hi Tom,

On Tue, 18 Feb 2025 at 18:07, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 18, 2025 at 05:03:08PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 18 Feb 2025 at 07:46, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Feb 18, 2025 at 05:08:40AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 17 Feb 2025 at 17:40, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Feb 17, 2025 at 01:39:37PM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 17 Feb 2025 at 13:17, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Mon, Feb 17, 2025 at 01:47:32PM -0600, Tom Rini wrote:
> > > > > > > > On Mon, Feb 17, 2025 at 12:34:01PM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Mon, 17 Feb 2025 at 12:22, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Feb 17, 2025 at 12:11:12PM -0700, Simon Glass wrote:
> > > > > > > > > > > Hi Tom,
> > > > > > > > > > >
> > > > > > > > > > > On Mon, 17 Feb 2025 at 11:50, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Tue, Feb 11, 2025 at 03:22:22PM -0600, Tom Rini wrote:
> > > > > > > > > > > > > On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > Hi,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I just wanted to send a note to (re-)introduce my ideas[1] for the
> > > > > > > > > > > > > > next iteration of xPL.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > A recent series introduced 'xPL' as the name for the various
> > > > > > > > > > > > > > pre-U-Boot phases, so now CONFIG_XPL_BUILD means that this is any xPL
> > > > > > > > > > > > > > phase and CONFIG_SPL means this really is the SPL phase, not TPL. We
> > > > > > > > > > > > > > still use filenames and function naming which uses 'spl', but could
> > > > > > > > > > > > > > potentially adjust that.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > The major remaining problem IMO is that it is quite tricky and
> > > > > > > > > > > > > > expensive (in terms of time) to add a new phase. We also have some
> > > > > > > > > > > > > > medium-sized problems:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > a. The $(PHASE_), $(SPL_) rules in the Makefile are visually ugly and
> > > > > > > > > > > > > > can be confusing, particularly when combined with ifdef and ifneq
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > b. We have both CONFIG_IS_ENABLED() and IS_ENABLED() and they mean
> > > > > > > > > > > > > > different things. For any given option, some code uses one and some
> > > > > > > > > > > > > > the other, depending on what problems people have met along the way.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > c. An option like CONFIG_FOO is ambiguous, in that it could mean that
> > > > > > > > > > > > > > the option is enabled in one or more xPL phases, or just in U-Boot
> > > > > > > > > > > > > > proper. The only way to know is to look for $(PHASE_) etc. in the
> > > > > > > > > > > > > > Makefiles and CONFIG_IS_ENABLED() in the code. This is very confusing
> > > > > > > > > > > > > > and has not scaled well.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > d. We need to retain an important feature: options from different
> > > > > > > > > > > > > > phases can depend on each other. As an example, we might want to
> > > > > > > > > > > > > > enable MMC in SPL by default, if MMC is enabled in U-Boot proper. We
> > > > > > > > > > > > > > may also want to share values between phases, such as TEXT_BASE. We
> > > > > > > > > > > > > > can do this easily today, just by adding Kconfig rules.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I agree with a through c and for d there are likely some cases even if
> > > > > > > > > > > > > I'm not sure TEXT_BASE is a good example. But I'm not sure it's as
> > > > > > > > > > > > > important as the other ones.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > Proposal
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > 1. Adjust kconf to generate separate autoconf.h files for each phase.
> > > > > > > > > > > > > > These contain the values for each Kconfig option for that phase. For
> > > > > > > > > > > > > > example CONFIG_TEXT_BASE in autoconf_spl.h is SPL's text base.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > 2. Add a file to resolve the ambiguity in (c) above, listing the
> > > > > > > > > > > > > > Kconfig options which should not be enabled/valid in any xPL build.
> > > > > > > > > > > > > > There are around 200 of these.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > 3. Introduce CONFIG_PPL as a new prefix, meaning U-Boot proper (only),
> > > > > > > > > > > > > > useful in rare cases. This indicates that the option applies only to
> > > > > > > > > > > > > > U-Boot proper and is not defined in any xPL build. It is analogous to
> > > > > > > > > > > > > > CONFIG_TPL_xxx meaning 'enabled in TPL'. Only a dozen of these are
> > > > > > > > > > > > > > needed at present, basically to allow access to the value for another
> > > > > > > > > > > > > > phase, e.g. SPL wanting to find CONFIG_PPL_TEXT_BASE so that it knows
> > > > > > > > > > > > > > the address to which U-Boot should be loaded.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > 4. There is no change to the existing defconfig files, or 'make
> > > > > > > > > > > > > > menuconfig', which works just as today, including dependencies between
> > > > > > > > > > > > > > options across all phases.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > 5. (next) Expand the Kconfig language[2] to support declaring phases
> > > > > > > > > > > > > > (SPL, TPL, etc.) and remove the need for duplicating options (DM_MMC,
> > > > > > > > > > > > > > SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allowing an option to be
> > > > > > > > > > > > > > declared once for any/all phases. We can then drop the file in 2
> > > > > > > > > > > > > > above.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > With this, maintaining Kconfig options, Makefiles and adding a new
> > > > > > > > > > > > > > phase should be considerably easier.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I think this will not make our life easier, it will make things harder.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I think what we've reached now shows that Yamada-san was correct at the
> > > > > > > > > > > > > time in saying that we were going down the wrong path with how we
> > > > > > > > > > > > > handled SPL/TPL.
> > > > > > > > > > > > >
> > > > > > > > > > > > > My request instead is:
> > > > > > > > > > > > > - Largely drop SPL/TPL/VPL (so no DM_MMC and SPL_DM_MMC and so on, just
> > > > > > > > > > > > >   DM_MMC) as a prefix.
> > > > > > > > > > > > > - Likely need to introduce a PPL symbol as you suggest.
> > > > > > > > > > > > > - Make PPL/SPL/TPL/VPL be a choice statement when building a defconfig.
> > > > > > > > > > > > > - Split something like rockpro64-rk3399_defconfig in to
> > > > > > > > > > > > >   rockpro64-rk3399_ppl_defconfig
> > > > > > > > > > > > >   rockpro64-rk3399_spl_defconfig rockpro64-rk3399_tpl_defconfig
> > > > > > > > > > > > >   and add Makefile logic such that for X_defconfig as a build target but
> > > > > > > > > > > > >   not configs/X_defconfig not existing, we see if any of
> > > > > > > > > > > > >   configs/X_{ppl,spl,tpl,vpl}_defconfig exist and we run a builds in
> > > > > > > > > > > > >   subdirectories of our object directory, and then using binman combine
> > > > > > > > > > > > >   as needed.
> > > > > > > > > > > > >   - Maybe instead the Makefile logic above we would parse X_defconfig
> > > > > > > > > > > > >     and see if it's a different format of say PHASE:file to make it
> > > > > > > > > > > > >     easier to say share a single TPL config with all rk3399, have a few
> > > > > > > > > > > > >     common SPL configs and then just a board specific PPL.
> > > > > > > > > > > > >
> > > > > > > > > > > > > This solves (a) by removing them entirely. This solves (b) by removing
> > > > > > > > > > > > > the ambiguity entirely (it will be enabled or not). As a bonus for (b)
> > > > > > > > > > > > > we can switch everyone to IS_ENABLED(CONFIG_FOO) and match up with the
> > > > > > > > > > > > > Linux Kernel again. This solves (c) again by removing it entirely.
> > > > > > > > > > > >
> > > > > > > > > > > > Lets come back up here, to my proposal, since parts of it seem to have
> > > > > > > > > > > > not been clear enough. While what I'm proposing should work for any
> > > > > > > > > > > > platform and xPL -> xPL -> ... -> PPL, for this example let us assume
> > > > > > > > > > > > rockpro64-rk3399 supports the flow of TPL -> SPL -> PPL. Also, to
> > > > > > > > > > > > compare with today, it will be helpful to run "make
> > > > > > > > > > > > O=/tmp/rockpro64-rk3399_current rockpro64-rk3399_config" and have the
> > > > > > > > > > > > resulting .config file available.
> > > > > > > > > > > >
> > > > > > > > > > > > There shall be configs/rockpro64-rk3399_tpl_defconfig. This will contain
> > > > > > > > > > > > lines such as:
> > > > > > > > > > > > CONFIG_ARM=y
> > > > > > > > > > > > CONFIG_ARCH_ROCKCHIP=y
> > > > > > > > > > > > CONFIG_ROCKCHIP_RK3399=y
> > > > > > > > > > > > CONFIG_TPL=y
> > > > > > > > > > > >
> > > > > > > > > > > > When you run "make O=/tmp/rockpro64-rk3399_tpl rockpro64-rk3399_tpl_defconfig"
> > > > > > > > > > > > the resulting .config file will contain lines such as:
> > > > > > > > > > > > # CONFIG_ROCKCHIP_EXTERNAL_TPL is not set
> > > > > > > > > > > > as this only makes sense in the context of building something that will
> > > > > > > > > > > > be TPL.
> > > > > > > > > > > >
> > > > > > > > > > > > A more complex example is that it will also contain:
> > > > > > > > > > > > CONFIG_TPL_ROCKCHIP_COMMON_BOARD=y
> > > > > > > > > > > >
> > > > > > > > > > > > Because looking at arch/arm/mach-rockchip/Makefile a bunch of that will
> > > > > > > > > > > > be able to be simplified (and spl_common.c should be renamed to
> > > > > > > > > > > > xpl_common.c) to:
> > > > > > > > > > > > obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o xpl_common.o
> > > > > > > > > > > > obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o xpl_common.o
> > > > > > > > > > > >
> > > > > > > > > > > > The .config file here will also contain:
> > > > > > > > > > > > CONFIG_DM_SERIAL=y
> > > > > > > > > > > >
> > > > > > > > > > > > What it will not contain is:
> > > > > > > > > > > > CONFIG_TPL_DM_SERIAL=y
> > > > > > > > > > > >
> > > > > > > > > > > > This is because there is no 'config TPL_DM_SERIAL' option in
> > > > > > > > > > > > drivers/serial/Kconfig anymore.
> > > > > > > > > > > >
> > > > > > > > > > > > When you next run "make O=/tmp/rockpro64-rk3399_tpl all" the results in
> > > > > > > > > > > > /tmp/rockpro64-rk3399_tpl would be similar to the results as under
> > > > > > > > > > > > "/tmp/rockpro64-rk3399/tpl/" when building today.
> > > > > > > > > > > >
> > > > > > > > > > > > The contents of configs/rockpro64-rk3399_spl_defconfig would be similar
> > > > > > > > > > > > to the tpl one, except with SPL-only-ever-valid options such as
> > > > > > > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y but otherwise have CONFIG_DM_SERIAL=y
> > > > > > > > > > > > and no CONFIG_SPL_DM_SERIAL=y, and when building the "all" target, you
> > > > > > > > > > > > would only get similar results to what is under the spl/ directory
> > > > > > > > > > > > today.
> > > > > > > > > > > >
> > > > > > > > > > > > Next we have configs/rockpro64-rk3399_ppl_defconfig.  When you run "make
> > > > > > > > > > > > O=/tmp/rockpro64-rk3399_ppl rockpro64-rk3399_ppl_defconfig" the
> > > > > > > > > > > > important difference is what you do not have. You do not have:
> > > > > > > > > > > > CONFIG_SPL=y
> > > > > > > > > > > > CONFIG_TPL=y
> > > > > > > > > > > >
> > > > > > > > > > > > Because we are not building SPL nor TPL. We're just making full U-Boot
> > > > > > > > > > > > itself. This is where in more full examples and with additional
> > > > > > > > > > > > restructure a "generic-arm64_ppl_defconfig" makes sense and be used
> > > > > > > > > > > > instead.
> > > > > > > > > > > >
> > > > > > > > > > > > This brings up what to do with "ockpro64-rk3399_defconfig". And I'm a
> > > > > > > > > > > > little unsure which of the things I mentioned above is best. It's
> > > > > > > > > > > > either:
> > > > > > > > > > > > a) Does not exist, top-level Makefile says roughly:
> > > > > > > > > > > > %_defconfig: %_tpl_defconfig %_spl_defconfig %_ppl_defconfig
> > > > > > > > > > > >   make O=$(objdir)/tpl %_tpl_defconfig all
> > > > > > > > > > > >   make O=$(objdir)/spl %_spl_defconfig all
> > > > > > > > > > > >   make O=$(objdir)/ppl %_ppl_defconfig all
> > > > > > > > > > > >
> > > > > > > > > > > > But this might be too rigid.
> > > > > > > > > > > > b) It contains:
> > > > > > > > > > > > PHASE:VPL:rockpro64-rk3399_vpl_defconfig
> > > > > > > > > > > > PHASE:TPL:rockpro64-rk3399_tpl_defconfig
> > > > > > > > > > > > PHASE:SPL:rockpro64-rk3399_spl_defconfig
> > > > > > > > > > > > PHASE:PPL:rockpro64-rk3399_ppl_defconfig
> > > > > > > > > > > > And the top-level Makefile looks like:
> > > > > > > > > > > > %_defconfig:
> > > > > > > > > > > >   grep -q ^PHASE $@ || fatal "Invalid defconfig file, please see..."
> > > > > > > > > > > >   foreach line in $@
> > > > > > > > > > > >     make O=$(objdir)/$PHASE $CONFIGFILE all
> > > > > > > > > > > >
> > > > > > > > > > > > It could also be some other suggestion.
> > > > > > > > > > >
> > > > > > > > > > > Thanks for writing that up. It is somewhat clearer.
> > > > > > > > > > >
> > > > > > > > > > > What happens to the Makefiles? Do they still have $(PHASE_) in them?
> > > > > > > > > >
> > > > > > > > > > No. Because CONFIG_SPL_FIT would never exist, $(CONFIG_$(PHASE_)FIT)
> > > > > > > > > > would be meaningless. Only rockpro64-rk3399_spl_defconfig would say
> > > > > > > > > > CONFIG_FIT=y (or more likely, only the resulting .config would say
> > > > > > > > > > CONFIG_FIT=y just like how configs/rockpro64-rk3399_defconfig doesn't
> > > > > > > > > > say CONFIG_FIT=y nor CONFIG_SPL_FIT=y).
> > > > > > > > >
> > > > > > > > > But just above you said:
> > > > > > > > >
> > > > > > > > > > I believe this proposal will lead to the code and Makefiles being less
> > > > > > > > > > clear than they are today. The line:
> > > > > > > > > > drivers/Makefile:obj-$(CONFIG_$(PHASE_)BLK) += block/
> > > > > > > > > > will become:
> > > > > > > > > > drivers/Makefile:obj-$(CONFIG_BLK) += block/
> > > > > > > > > > without being clear that it could reference either full U-Boot (PPL) or
> > > > > > > > > > some xPL phase. While the same Makefile will continue to have (comments
> > > > > > > > > > my own):
> > > > > > > > > > obj-y += mtd/ # Subdirectory Makefiles control build contents
> > > > > > > > > > obj-$(CONFIG_MULTIPLEXER) += mux/ # Only valid for PPL.
> > > > > > > > > >
> > > > > > > > > > And so the situation for humans will be worse off than today because
> > > > > > > > > > while $(PHASE_) and $(XPL_) are confusing at times, they make it clear
> > > > > > > > > > what can and cannot be enabled in PPL vs xPL.
> > > > > > > > > >
> > > > > > > > > > Doing "something" is not better than doing nothing in this case.
> > > > > > > > >
> > > > > > > > > So why is OK for your proposal to drop the $(PHASE_) stuff, but not mine?
> > > > > > > >
> > > > > > > > Because your proposal keeps CONFIG_SPL_BLK (and config SPL_BLK) and has
> > > > > > > > a .config file which says "CONFIG_SPL_BLK=y" but mine doesn't.
> > > > > > > >
> > > > > >
> > > > > > > With my
> > > > > > > proposal "I have a problem, and I want to see what my SPL build has with
> > > > > > > CONFIG_BLK=y. I can see hits in the source tree for CONFIG_BLK, the
> > > > > > > symbol I set, I can solve my problem."
> > > > > >
> > > > > > There will be at least some matches, e.g. CONFIG_SPL_BLK in the
> > > > > > defconfig files and 'config SPL_BLK' in the source tree.
> > > > >
> > > > > Yes, and that's confusing. I am arguing that your statement is more
> > > > > confusing than $(PHASE_)BLK is.
> > > >
> > > > OK
> > > >
> > > > >
> > > > > > > > Or to try and explain differently, with your proposal "I have a problem,
> > > > > > > > and I want to see what builds with CONFIG_SPL_BLK=y. Why is there no
> > > > > > > > match in the source tree for CONFIG_SPL_BLK or even SPL_BLK". With my
> > > > > > > > proposal "I have a problem, and I want to see what my SPL build has with
> > > > > > > > CONFIG_BLK=y. I can see hits in the source tree for CONFIG_BLK, the
> > > > > > > > symbol I set, I can solve my problem."
> > > > > >
> > > > > > Well, CONFIG_BLK will be in the source tree; it just means different
> > > > > > things for different phases.
> > > > >
> > > > > And it will be, with your proposal, controlled by BLK or SPL_BLK or
> > > > > TPL_BLK or VPL_BLK in the .config file but only CONFIG_BLK in Makefile
> > > > > and code.
> > > > >
> > > > > > It sounds like you want to get rid of the xPL prefixes for Kconfig
> > > > > > options, and that overrides all other considerations?
> > > > >
> > > > > It's one of the big problems we have today, and splc-working shows how
> > > > > much further the duplication must go. It's why I suggested the language
> > > > > modification before.
> > > > >
> > > > > > > My other try here was a bit unclear actually because of the confusion
> > > > > > > state your proposal gives us. Try try again directly, the problem is
> > > > > > > that CONFIG_SPL_BLK will be set (or unset) but not referenced in code.
> > > > > > > This will be true for many but not all SPL symbols as
> > > > > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD for example will still exist and need
> > > > > > > to be referenced. This is a more confusing state than $(PHASE_). $(XPL_)
> > > > > > > I think can just be replaced with $(PHASE_) but I haven't confirmed (I
> > > > > > > think it does show that the old way was confusing however).
> > > > > >
> > > > > > OK, I think I see. You don't want people to have to 'know' that
> > > > > > CONFIG_xPL_xxx is used to control feature xxx in each xPL build?
> > > > >
> > > > > I'm saying they have to know that, and also know which symbols that's
> > > > > not true for. And that is more confusing than today. I'm saying that
> > > > > compared with today's arch/arm/mach-rockchip/Makefile the following is
> > > > > worse:
> > > > > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> > > > > index 5e7edc99cdc4..3b176966f75b 100644
> > > > > --- a/arch/arm/mach-rockchip/Makefile
> > > > > +++ b/arch/arm/mach-rockchip/Makefile
> > > > > @@ -29,7 +29,7 @@ ifeq ($(CONFIG_TPL_BUILD),)
> > > > >  obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
> > > > >  endif
> > > > >
> > > > > -obj-$(CONFIG_$(PHASE_)RAM) += sdram.o
> > > > > +obj-$(CONFIG_RAM) += sdram.o
> > > > >
> > > > >  obj-$(CONFIG_ROCKCHIP_PX30) += px30/
> > > > >  obj-$(CONFIG_ROCKCHIP_RK3036) += rk3036/
> > > > >
> > > > > (And CONFIG_TPL_RAM and CONFIG_SPL_RAM still exist).
> > > > >
> > > > > And this is better:
> > > > >
> > > > > diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> > > > > index 5e7edc99cdc4..23c30f68f878 100644
> > > > > --- a/arch/arm/mach-rockchip/Makefile
> > > > > +++ b/arch/arm/mach-rockchip/Makefile
> > > > > @@ -7,15 +7,13 @@
> > > > >  # this may have entered from ATF with the stack-pointer pointing to
> > > > >  # inaccessible/protected memory (and the bootrom-helper assumes that
> > > > >  # the stack-pointer is valid before switching to the U-Boot stack).
> > > > > -obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> > > > > -obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o spl_common.o
> > > > > -obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> > > > > -obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o spl_common.o
> > > > > -obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
> > > > > +obj-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> > > > > +obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o spl_common.o
> > > > > +obj-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
> > > > > +obj-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o spl_common.o
> > > > > +obj-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
> > > > >
> > > > > -obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
> > > > > -
> > > > > -ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > > > +obj-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
> > > > >
> > > > >  # Always include boot_mode.o, as we bypass it (i.e. turn it off)
> > > > >  # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This way,
> > > > > @@ -23,14 +21,13 @@ ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
> > > > >  # meaning "turn it off".
> > > > >  obj-y += boot_mode.o
> > > > >  obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
> > > > > -endif
> > > > >
> > > > > -ifeq ($(CONFIG_TPL_BUILD),)
> > > > >  obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
> > > > > -endif
> > > > >
> > > > > -obj-$(CONFIG_$(PHASE_)RAM) += sdram.o
> > > > > +obj-$(CONFIG_RAM) += sdram.o
> > > > >
> > > > > +ifdef CONFIG_PPL
> > > > > +# TODO: Audit these Makefiles see if they really must be PPL only
> > > > >  obj-$(CONFIG_ROCKCHIP_PX30) += px30/
> > > > >  obj-$(CONFIG_ROCKCHIP_RK3036) += rk3036/
> > > > >  obj-$(CONFIG_ROCKCHIP_RK3066) += rk3066/
> > > > > @@ -46,10 +43,4 @@ obj-$(CONFIG_ROCKCHIP_RK3568) += rk3568/
> > > > >  obj-$(CONFIG_ROCKCHIP_RK3588) += rk3588/
> > > > >  obj-$(CONFIG_ROCKCHIP_RV1108) += rv1108/
> > > > >  obj-$(CONFIG_ROCKCHIP_RV1126) += rv1126/
> > > > > -
> > > > > -# Clear out SPL objects, in case this is a TPL build
> > > > > -obj-spl-$(CONFIG_TPL_BUILD) =
> > > > > -
> > > > > -# Now add SPL/TPL objects back into the main build
> > > > > -obj-$(CONFIG_XPL_BUILD) += $(obj-spl-y)
> > > > > -obj-$(CONFIG_TPL_BUILD) += $(obj-tpl-y)
> > > > > +endif
> > > > > (CONFIG_SPL_RAM and CONFIG_TPL_RAM no longer exist as options).
> > > > >
> > > >
> > > > This Makefile is a very strange example. I've thought about cleaning
> > > > it up a few times, but then I know someone will say it needs to be in
> > > > its own series, etc. so I've never got around to it. Even with the
> > > > current xPL stuff (i.e. making CONFIG_SPL_BUILD mean just SPL) it is
> > > > needlessly complex.
> > >
> > > There's some complexity that can be removed here today, maybe. But not a
> > > lot of it, because it's complex to build three different things when
> > > configuring once.
> > >
> > > > Anyway, with my scheme, you can still use
> > > > CONFIG_SPL_ROCKCHIP_COMMON_BOARD if you want to. It adds SPL_ versions
> > >
> > > No. You have to use it still, with yours. Because
> > > "ROCKCHIP_COMMON_BOARD", "SPL_ROCKCHIP_COMMON_BOARD" and
> > > "TPL_ROCKCHIP_COMMON_BOARD" are the same concept of "use common board
> > > code" but different files at TPL, SPL and PPL. And you still have to
> > > with mine, because for the same reason. With mine, the Kconfig is:
> > > config SPL_ROCKCHIP_COMMON_BOARD
> > >   bool "SPL rockchip common board file"
> > >   depends on SPL
> > >
> > > config TPL_ROCKCHIP_COMMON_BOARD
> > >   bool "TPL rockchip common board file"
> > >   depends on TPL
> > >
> > > And since you are only ever configuring for TPL or SPL or PPL (or VPL or
> > > ...) the resulting config only ever asks for the appropriate one.
> > >
> > > > of symbols to autoconf_spl.h for this reason. There are also places in
> > > > the code where people directly check CONFIG_SPL_xxx and these need to
> > > > work.
> > >
> > > Yes, this is part of the confusion I keep noting with your proposal as
> > > it will be inconsistent for which symbols CONFIG_SPL_xxx is referred to
> > > in code as CONFIG_SPL_xxx or as CONFIG_xxx.
> >
> > If it is confusing, we can change all of them to CONFIG_xxx in a
> > follow-up. There is no need to mention SPL_, it just allows the
> > existing code to work without a wholesale change.
>
> No, that's not correct. Please look again at what I've written
> explaining why.

See below.

>
> > > > This surprised me:
> > > >
> > > > obj-$(CONFIG_RAM) += sdram.o
> > > >
> > > > Are you saying you are OK with this one, instead of, for example:
> > > >
> > > > obj-$(CONFIG_TPL_RAM) += sdram.o
> > > > obj-$(CONFIG_SPL_RAM) += sdram.o
> > > > obj-$(CONFIG_RAM) += sdram.o
> > > >
> > > > If so, why are you OK with that and not the others?
> > >
> > > Because there is no:
> > > config TPL_RAM
> > >   bool "RAM driver in TPL"
> > >
> > > in what I am proposing. That's why. There's one symbol because there's
> > > the same files being built.
> >
> > OK, well that works the same for my scheme too. Either will do.
>
> I don't see how that can work in your scheme.

Here is the full Kconfig for that file, with my scheme:

>>>>
# SPDX-License-Identifier: GPL-2.0+
#
# Copyright (c) 2014 Google, Inc
# Copyright (c) 2019 Rockchip Electronics Co., Ltd.

# We don't want the bootrom-helper present in a full U-Boot build, as
# this may have entered from ATF with the stack-pointer pointing to
# inaccessible/protected memory (and the bootrom-helper assumes that
# the stack-pointer is valid before switching to the U-Boot stack).
obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o
spl_common.o
obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o spl_common.o
obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o

obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o

ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)

# Always include boot_mode.o, as we bypass it (i.e. turn it off)
# inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This way,
# we can have the preprocessor correctly recognise both 0x0 and 0
# meaning "turn it off".
obj-y += boot_mode.o
obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
endif

ifeq ($(CONFIG_TPL_BUILD),)
obj-$(CONFIG_DISPLAY_CPUINFO) += cpu-info.o
endif

obj-$(CONFIG_RAM) += sdram.o

obj-$(CONFIG_ROCKCHIP_PX30) += px30/
obj-$(CONFIG_ROCKCHIP_RK3036) += rk3036/
obj-$(CONFIG_ROCKCHIP_RK3066) += rk3066/
obj-$(CONFIG_ROCKCHIP_RK3128) += rk3128/
obj-$(CONFIG_ROCKCHIP_RK3188) += rk3188/
obj-$(CONFIG_ROCKCHIP_RK322X) += rk322x/
obj-$(CONFIG_ROCKCHIP_RK3288) += rk3288/
obj-$(CONFIG_ROCKCHIP_RK3308) += rk3308/
obj-$(CONFIG_ROCKCHIP_RK3328) += rk3328/
obj-$(CONFIG_ROCKCHIP_RK3368) += rk3368/
obj-$(CONFIG_ROCKCHIP_RK3399) += rk3399/
obj-$(CONFIG_ROCKCHIP_RK3568) += rk3568/
obj-$(CONFIG_ROCKCHIP_RK3588) += rk3588/
obj-$(CONFIG_ROCKCHIP_RV1108) += rv1108/
obj-$(CONFIG_ROCKCHIP_RV1126) += rv1126/

# Clear out SPL objects, in case this is a TPL build
obj-spl-$(CONFIG_TPL_BUILD) =

# Now add SPL/TPL objects back into the main build
obj-$(CONFIG_XPL_BUILD) += $(obj-spl-y)
obj-$(CONFIG_TPL_BUILD) += $(obj-tpl-y)
<<<<

The only change is the line that was:
obj-$(CONFIG_$(PHASE_)RAM) += sdram.o

>
> > > > For this one:
> > > >
> > > > > +obj-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o spl_common.o
> > > >
> > > > I don't understand how it can work with your scheme, since you don't
> > > > want to have any CONFIG_SPL_ things?
> > >
> > > No, that's not what I've been saying and trying to make clear with my
> > > examples. I keep saying that there are explicitly SPL (or TPL or VPL)
> > > only options. And these need to be named as such. And so that's the
> > > confusion your proposal introduces (inconsistency about referring to a
> > > symbol that has been enabled) and mine removes entirely (we only ever
> > > refer to symbols based on their name).
> >
> > Right, but you still have 'config SPL_RAM', right? Would you keep
>
> No, again, I do not. Please re-read my proposal as you seem to keep
> making the same incorrect assumptions about it, and then saying that
> your scheme would also do that. They are very much not at all the same.

Maybe we have reached the limits of email on this one, but I am quite
confused about your scheme. I suggested that you don't have
CONFIG_SPL_ things and you said tht was wrong. Then I asked if you
still have SPL_RAM and you said you don't. Let me try this:

Q: In your scheme, do you have 'config SPL_RAM' and CONFIG_SPL_RAM, or
do you not?

Regards,
Simon
