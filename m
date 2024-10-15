Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77386D216A2
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 13:12:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05010880F4;
	Tue, 15 Oct 2024 15:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dfIDaOyq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39F2D88113; Tue, 15 Oct 2024 15:12:36 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B67A788009
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cbceb48613so33966276d6.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728997952; x=1729602752; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7UaatiupRmIAytCpvYm7FHoSq0pysXv1deyFWkGXtF8=;
 b=dfIDaOyqPvuPvObdPaGAgY44jQb6H1c3mu7Qgx85TprA3GjsNb6JuZOa1EZVa9Dop4
 iMQCnI8jf1GGdZ4Xqvt3o4J/hsaSfx+8fMEA4YRupTi/OcHPFOPVUs7Nx8+smmAfEw5I
 bw/8Z+g0PF++psaMrR7vrwJC7DXBk0A/CkMPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728997952; x=1729602752;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7UaatiupRmIAytCpvYm7FHoSq0pysXv1deyFWkGXtF8=;
 b=Idzeql9IJO7rU9ygJs20iwMRuUYyY/+jPAaG7PTz+EA9P0V5zBgYphmBg8JniPwVga
 o5+rzpy0WfK8XUeTjHp8qs7Ymv7UZEBRjLFIKZVr+b2AvfLFFR5V+6ixt3at0NFTXNIz
 Ihn5XZFySv4VCuSzwj8QjD4ErTResCk/ZGQdfDvLbhTofq+V+Xh9ur+DnwM9src9TQPv
 Cpjo+olw4/w4y7vo/3YW3Bp9JaQv72YrRFwvQmV83In4f27eCxcSuW5j/PUDAjZK0p4K
 CdxPUXjQhtb0Mn5DYFdc+I2Ku9N3Ve1Su3Xxjah7jT//63GGGR1qhE02CEFQk92Y8gtv
 j3GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/P1zAR7LJXZPDD9JcQK/aR3jp1WpZ5SuFTiL2rN8iynTiAAJI8T/Yq0PLey/SWmgPZauSU2w=@lists.denx.de
X-Gm-Message-State: AOJu0YzNBpJBrl5lrTvDZV5qTphOdhZUdPINbF2MBWYtk7v+JhlnnhCL
 Ljaq8cWXbtBPsOwxCnjQEM98XCtXii2i3rTtOBZLMYAYsjqfaWp9qMBE2cd36SwBlKQyvAHoA+Q
 1m4itdT0sigSkV5JnEvobuEXl2HbneHzdkD8oEr4DgwjCekQ=
X-Google-Smtp-Source: AGHT+IFxjlTwNdo9zdNwqQ7hOiLjeVQ55VEbpnICZHWR4V7pjadmqEl940YGVcny71UXO18t67tD0WWta2VrakvDmTc=
X-Received: by 2002:a05:6214:3198:b0:6cb:3b34:55d3 with SMTP id
 6a1803df08f44-6cbf00890f6mr221299506d6.29.1728997952526; Tue, 15 Oct 2024
 06:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241011212126.747741-1-sjg@chromium.org>
 <20241011212126.747741-5-sjg@chromium.org>
 <71ECC011-77EC-4308-AFE5-0E301BC27F84@gmx.de>
 <20241012012716.GE14210@bill-the-cat>
 <CAC_iWjL_YQ24ZecbN7oC-37PRR6iuUiiui-a0VPqSSVRunepdQ@mail.gmail.com>
 <CAFLszTjzHBtR8vzk0wT-nNiwbsotqskVhVEX0ibh-Uea1+Da6Q@mail.gmail.com>
 <20241014214236.GB53053@bill-the-cat>
 <CAFLszTi8iJRMBVd79JLumPVz3VB0A8w1v_ZM2pP9D_cp_nx3yg@mail.gmail.com>
 <20241014215454.GF53053@bill-the-cat>
In-Reply-To: <20241014215454.GF53053@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 15 Oct 2024 07:12:21 -0600
Message-ID: <CAFLszTiaO0NqK+-qqnEB28+iqH0jh7bW_uFWW-eNG8vBWG15Xg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] efi: Reserve some memory for initial use
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>
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

On Mon, 14 Oct 2024 at 15:55, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 14, 2024 at 03:50:51PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 14 Oct 2024 at 15:42, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 14, 2024 at 02:19:56PM -0600, Simon Glass wrote:
> > > > Hi,
> > > >
> > > > On Fri, 11 Oct 2024 at 23:47, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi Tom
> > > > >
> > > > > On Sat, 12 Oct 2024 at 04:27, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sat, Oct 12, 2024 at 12:01:54AM +0200, Heinrich Schuchardt wrote:
> > > > > > >
> > > > > > >
> > > > > > > Am 11. Oktober 2024 23:21:25 MESZ schrieb Simon Glass <sjg@chromium.org>:
> > > > > > > >The 'point of cooperation' is where U-Boot starts allowing EFI to use
> > > > > > > >memory outside of the U-Boot region. Until that point, it is desirable
> > > > > > > >to keep more below U-Boot free for loading images.
> > > > > > > >
> > > > > > > >Reserve a small region for this purpose.
> > > > > > >
> > > > > > > Your commit message provides no clue why this should be needed.
> > > >
> > > > Yes, I hadn't realised that people didn't understand what I was
> > > > getting at. Tom asked the same question on irc.
> > > >
> > > > It allows us to separate the lmb allocations from the EFI allocations,
> > > > so we don't need to have them both in sync. We use lmb for loading
> > > > images, then EFI takes over and does what it likes, respecting the
> > > > existing lmb reservations.
> > >
> > > But, again, LMB is not for loading of images. It's for dealing with
> > > memory reservations of various types.
> >
> > Up until recently, I believe, my statement was true, but in any case,
> > this isn't gemaine to the issue here.
> >
> > The point is, this is a useful distinction, allowing us to avoid the
> > complexity of keeping them in sync, and avoid putting this pain on
> > people who are not using EFI. We are either in U-Boot code, in which
> > case lmb rules, or we are going into an app, in which case EFI rules
> > (but must read in the lmb info).
> >
> > We are going to end up with people turning off EFI_LOADER because it
> > behaves so badly.
>
> Frankly, in hind sight I should not have agreed to split the LMB rework
> between "everything else" and "EFI" in hopes that we would then be able
> to get the "EFI" part of this agreed upon. It's "behaving badly" right
> now because we merged half of the changes in the hopes that we could get
> your agreement on the rest of them fairly quickly. This is not
> happening, however.

Well, another option would be to revert the problem patch (or two) and
do this work with careful consideration of the impacts, taking account
of my architectural objections. My main concern is using U-Boot's
memory like a stack. Suddenly this is 'OK' and we apparently want to
update U-Boot's docs to say so. It is just not a good idea!

A good part of the reason that U-Boot solves the problems it does is
that it mostly has a good design. The EFI_LOADER can be improved and
it does not need to implement things in a particular way...it just
needs to follow the spec. We are being far too rigid in saying that
every memory allocation at every stage has to be handled the same way,
etc.

That said, I did not expect the first series to cause problems. If my
EFI-test series had landed then we could perhaps have added a test for
this case of the app requesting a chunk of memory. My hope is for that
test to grow and cover some of these areas, I hope this lmb/efi thing
doesn't cause further problems and I will be looking to ensure that
this code does not affect non-EFI booting negatively.

My series to solve this same problem (EFI's use of memory) have never
been more than a few small patches. Please take a look at the current
series[1], particularly patch 5.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=427729
