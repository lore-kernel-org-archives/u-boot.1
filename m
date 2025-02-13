Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E618C0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 14:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B33380F42;
	Thu, 13 Feb 2025 15:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I3+d6HTg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F8B780F0A; Thu, 13 Feb 2025 15:33:34 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F9DF80C96
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 15:33:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5de3c29ebaeso1187377a12.3
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 06:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739457212; x=1740062012; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+C0U7bdLwbQc1NuFfY2HhcVIS517T+HQ7sYGc8NkrbY=;
 b=I3+d6HTg/5tWrq9YGh7xoeB4CFLqM/ZO3EWik67jU3rc+WiyWIBcdzoa/NrxazXDS/
 S+MBal+bT34aFHmkpgbUirJ2hyU6YOkyVlWFj48+ro5gAnaeQhYEfVtQA7nMsVlubybq
 T6Xdqpp5B6nEbiNDRMFKR0aXKVirmUlbc/vuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739457212; x=1740062012;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+C0U7bdLwbQc1NuFfY2HhcVIS517T+HQ7sYGc8NkrbY=;
 b=JbJeHWBQuA2MOHqH+DfLg8utdEPT2wyOaNXJ1O77yDMy05aiJwKjJWYtZ5iJ5CDAqn
 J1Tonheh2bjcHmTZRT/Y/hb/k86BE5pBWfm54EuiDEXweLzaXagoneqS02XscgEoWkIv
 aEGsLkbACrTdpfGu1VDateAADnMBl+TgKRlHYpY5UO8mnjZNGo9vMlwzvmaQ5WPvfOTL
 qu5HwfGIuTWb8ogIhBJBme8PK3lBeSaHL48WOj7UQCagjuG9GP5jagbAO+TNoAYwwrkD
 QwU0GjAO8QVaG7MCd1/s0sjacITDsmGXflL/gpXIe6PmVySPc7uh6IX6UImdqoPXF4S2
 PVbA==
X-Gm-Message-State: AOJu0Yyfy35vV8Y+X4Dm0Y0nHPh/esRgNv9LerLnAGy2eaUqlnx0BfzJ
 yBNv5dPc3KyFmsYqgLLQb1bu2AlbDvcPvrbzpOcm6aOmUstIcOBy2NshYqdBQsMW6a3PWhPi0zO
 LtT7DpcDAHA0bKtMDqixcFfiVABBqKKmEYYssAfgiEULkk78=
X-Gm-Gg: ASbGnctZxlTJ6MyzCRabnEjbiNoMClc7nO2YNDHEh/bCGCMGh5WCYZGViRWlI6HjRQE
 QUSkiBA4X3ZmLS9KzZep0JMn1LQcnCpA/UR4nI8lcIR8fh7h3rzUKzsRRlrPWkoxEX3i4HUEa9L
 GYgBPFjgm4VXn4rZfg2Cl7eWLXEXhX
X-Google-Smtp-Source: AGHT+IGMs9WDtB19nXDK2i4QUZyUJo/t4XT/Dn25ZZnvqYjAQzeiUnHxsbMl6vHn1DsegHYVD2G7pcOq3D/litRm9W8=
X-Received: by 2002:a05:6402:5112:b0:5da:105b:86dd with SMTP id
 4fb4d7f45d1cf-5deade00dfbmr6847015a12.29.1739457211880; Thu, 13 Feb 2025
 06:33:31 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
 <20250213141517.GT1233568@bill-the-cat>
In-Reply-To: <20250213141517.GT1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Feb 2025 07:33:20 -0700
X-Gm-Features: AWEUYZnrJVi69oRlfWGN7znEAu-EAyZ6JL2T_brvDxeA4YzNf_ymKNW-Q0R8yEw
Message-ID: <CAFLszTib-ydH-TCE-Oi0SDGu1ASWbCbfWApTqxFFHoU3Di_nvw@mail.gmail.com>
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

On Thu, 13 Feb 2025 at 07:15, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon Glass wrote:
>
> > Hi,
> >
> > I just wanted to send a note to (re-)introduce my ideas[1] for the
> > next iteration of xPL.
> >
> > A recent series introduced 'xPL' as the name for the various
> > pre-U-Boot phases, so now CONFIG_XPL_BUILD means that this is any xPL
> > phase and CONFIG_SPL means this really is the SPL phase, not TPL. We
> > still use filenames and function naming which uses 'spl', but could
> > potentially adjust that.
> >
> > The major remaining problem IMO is that it is quite tricky and
> > expensive (in terms of time) to add a new phase. We also have some
> > medium-sized problems:
> >
> > a. The $(PHASE_), $(SPL_) rules in the Makefile are visually ugly and
> > can be confusing, particularly when combined with ifdef and ifneq
> >
> > b. We have both CONFIG_IS_ENABLED() and IS_ENABLED() and they mean
> > different things. For any given option, some code uses one and some
> > the other, depending on what problems people have met along the way.
> >
> > c. An option like CONFIG_FOO is ambiguous, in that it could mean that
> > the option is enabled in one or more xPL phases, or just in U-Boot
> > proper. The only way to know is to look for $(PHASE_) etc. in the
> > Makefiles and CONFIG_IS_ENABLED() in the code. This is very confusing
> > and has not scaled well.
> >
> > d. We need to retain an important feature: options from different
> > phases can depend on each other. As an example, we might want to
> > enable MMC in SPL by default, if MMC is enabled in U-Boot proper. We
> > may also want to share values between phases, such as TEXT_BASE. We
> > can do this easily today, just by adding Kconfig rules.
> >
> > Proposal
> >
> > 1. Adjust kconf to generate separate autoconf.h files for each phase.
> > These contain the values for each Kconfig option for that phase. For
> > example CONFIG_TEXT_BASE in autoconf_spl.h is SPL's text base.
> >
> > 2. Add a file to resolve the ambiguity in (c) above, listing the
> > Kconfig options which should not be enabled/valid in any xPL build.
> > There are around 200 of these.
> >
> > 3. Introduce CONFIG_PPL as a new prefix, meaning U-Boot proper (only),
> > useful in rare cases. This indicates that the option applies only to
> > U-Boot proper and is not defined in any xPL build. It is analogous to
> > CONFIG_TPL_xxx meaning 'enabled in TPL'. Only a dozen of these are
> > needed at present, basically to allow access to the value for another
> > phase, e.g. SPL wanting to find CONFIG_PPL_TEXT_BASE so that it knows
> > the address to which U-Boot should be loaded.
> >
> > 4. There is no change to the existing defconfig files, or 'make
> > menuconfig', which works just as today, including dependencies between
> > options across all phases.
> >
> > 5. (next) Expand the Kconfig language[2] to support declaring phases
> > (SPL, TPL, etc.) and remove the need for duplicating options (DM_MMC,
> > SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allowing an option to be
> > declared once for any/all phases. We can then drop the file in 2
> > above.
> >
> > With this, maintaining Kconfig options, Makefiles and adding a new
> > phase should be considerably easier.
>
> Here is the big problem I see with your proposal. Today our Kbuild and
> kconfig support is very much out of date. And while my attempts to
> resync them together haven't worked, I believe it comes down to how we
> build *pl targets today, at least in part, because that's just not
> a thing upstream has to do. What you're proposing here will make any
> future resyncs even harder as more of the code will diverge from
> upstream (as seen in your previous RFC series).

Yes, that's true, but mostly in kconfig. I would be willing to resync
kconfig with Linux, if that helps.

For kbuild, my series doesn't do much there. I could perhaps offer a
resync of fixdep.c ?

Did Linaro show any interest in taking on Kbuild? Linux just has a
huge amount of build-code now. What problems do you have with U-Boot's
current Kbuild?

Regards,
Simon
