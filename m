Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2696BF94CB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 23:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A72F283BC8;
	Wed, 22 Apr 2026 01:17:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hv2C3tff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74FFA83E76; Wed, 22 Apr 2026 01:17:23 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECDB78352B
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 01:17:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4645dde00a7so4198732b6e.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 16:17:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776813440; cv=none;
 d=google.com; s=arc-20240605;
 b=bDRcud1HWR07sN8egGmex4FrG56euxcdDtmfTPNemjepVIXYmJsaAPeAhmxwwyDF6k
 3dOPtde/Eexhu83bhsud6x+oOzNELbzPCYiKQo2CEr8EXmR/yHbofCmcpVl5CxgME/UJ
 L1+LspF6uYMgZuq/VqZzBV9Ldpz8RH183YDSoqIVOjKgSkrBBB7IHA3Qopt2mzAdn3pO
 q/32xlNc28Von6Vv0zw1NjB8Py/k7F3hTulvFePzjHw/lUnY/cu3py4OTclaMlsmyjgH
 faNOw4Bpmy3/fcru+DCNOWiPOH7UILWmEZIQHhDZRX+a7A6Wvl0j0Exmj7i43bUxSUQh
 gX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GfycQJizhuCHP/MtDNtsawci07Do07r6CE4RXexZIzM=;
 fh=9r7S9p3VRn7IEaRdmSc0Ybs7HmGN7dtMxEobdXEs+bg=;
 b=QFUKsL8odfCaBEQJn+BGK+aHEJ59OBno2oBtm25r5tVZYsKjSuKC8cfp6cSt6WE7rH
 vcsH5TQRP6Xpd2pwrfUQ1ybRvn2Vlyzxpc+8EP9BJyXRvCUfeeXWOJVm4TdH0e5R2kUf
 83YAo9EVo21h3jJTK1pWUSmqbg4U0tdsqXKjD7e1fha65O3leByorpg/hiKkg2p60d4V
 LXTUKJhYYlovgJzESvdcW2+d50+ZxJmBYyZCza+1yyX/Rz0zOO1z0NVB8nujPnIlQ1gC
 IgyfnYfY6w37IvCbI0lULP1TJdT56QSw0m1UZ6jpn9r0bItXzFKnxf688dHwT98AFtOU
 Gxbw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776813440; x=1777418240; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GfycQJizhuCHP/MtDNtsawci07Do07r6CE4RXexZIzM=;
 b=Hv2C3tffZPsrBDmIRyZEdjSL1iPdp6p4bhd5xElEdZ1PfTz1N0RCSk04jEclZQyf2s
 UtDSNdFaU+bjDM3ppQay26gHCwRjdtm7q+w08ShvCfJeZi/4ueQCCS1j7mFzom8zQZ9t
 4t7MaduvCUI6o+bjHpZMFpm8T6d/FGJD+ZIDz9IO1TtbmMlowY/CUqZVx7GXFPHm/ajY
 cGcVo66H6vsA4tVywHYkqFhqwHrAlzfuk+VrEDQJQX6msDD9Ebeblwdxh8BHsaIGwxq2
 I+BL475X91I7ZICCkTuP24fKc7WIMuRODhc9CPqEafMSXP89MZxe4pm6LirQ1oYGcQlP
 +vAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776813440; x=1777418240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GfycQJizhuCHP/MtDNtsawci07Do07r6CE4RXexZIzM=;
 b=tCQfWfraUxANq452vSQ/J5O1oD6+0n7MCqJiMnWop3dAgMphUFzzp/i8+mZKhu2w5H
 KZSaijP65YF0vBmFg6m+vPYh5YsyvJP/HcG1IAAm5SthPUo6YOHonnjj5E7iwoOUH+pS
 uhgrc2M9XuLKTclF9+yqT3b5w6q2c9fOhmV8Y4dhUT5VwTh7FTPhNAdfn+Sonc+ZHpy4
 pxKj35ArdjZ3S2OYVuNx/7VcUnB+Ca2qp5U0G95TU1dzSFwX4Vi0X2i+Vuhmk2n+uxgA
 KEW0byqNzqS8NxIR4Iz78T/mUg0RURaHrncCKQybFhJbJw8fQEKrCB5p6H1hT/kGkUMV
 ptjg==
X-Gm-Message-State: AOJu0YwF+d7pg4amBuTPDiL9MsI7uc6fkdBmQX41GeqwkrbE7QF/cGyx
 d4wtvLZN5bcg2+EDYCq4vsTC26egpl49Tst88BCNLfe5cBELKqlGXySUE6g9TWKmrzuXvrKqC8l
 bSx6ZQvwVFHsolzncgE95Q8SQnEQeZNFEyKu3YgGzOQ==
X-Gm-Gg: AeBDieugq9g2T8rK3H32XqDS8yKdAxcb1w9DqrGydJP6FUhoUXHgP/hpkP1qX8SYlq9
 EL8LBxXIRPBhMYGvL4DP9JOg7JjuoaNHlSwhetTsv/8JfgMTqDXo8sn9KmjNxGXRrtOG5SU44WC
 +tfMgfsrEM/RM+bAUJ1WGvZ+6SKzVbI1VsmjLOpiTf0XH96AzFxusv4oaHdGtEJird5dw1s1nNk
 7hB0oeZ9emCBPG9LYG8+BbEo2XcImOyzI1oCsEKjogInWjHt0iV9RFgnO3E8Jz5JUuv/3oM8a7r
 K5sSGGGKSWZML4y0ZA==
X-Received: by 2002:a05:6808:1449:b0:470:d1f:de69 with SMTP id
 5614622812f47-4799bfdf093mr8808072b6e.26.1776813439621; Tue, 21 Apr 2026
 16:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260420074601.24988-1-briansune@gmail.com>
 <CAFLszThRNhVTMRpVPySFSComEhL_s0a1wY1BVnKKtV+K6OXnEQ@mail.gmail.com>
 <CAN7C2SCpBYi=c1kS7-aXL9Qf7wUq_ipcvQMSUSW9aYrQqUcAAg@mail.gmail.com>
 <CAFLszTiiv-os+sK+g+E7zUHqZVj79Pf9bUx6G2LczmgwUXXozQ@mail.gmail.com>
In-Reply-To: <CAFLszTiiv-os+sK+g+E7zUHqZVj79Pf9bUx6G2LczmgwUXXozQ@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 22 Apr 2026 07:17:08 +0800
X-Gm-Features: AQROBzDLBOfCvCyF3VQjifNWhuHp38sVyvkTqsZbuOytaCsW1OFeH_lA1n734og
Message-ID: <CAN7C2SDXJHo8Qo4VjjqMR-4fjHmpSphPjT=j0FhiSPwcZonoRQ@mail.gmail.com>
Subject: Re: [PATCH v3] Improve handosff prepare on SoCFPGA
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Wed, Apr 22, 2026 at 6:39=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Brian,
>
> On Tue, 21 Apr 2026 at 11:12, Sune Brian <briansune@gmail.com> wrote:
> >
> > On Tue, Apr 21, 2026 at 3:32=E2=80=AFAM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Brian,
> > >
> > > On 2026-04-20T07:46:01, Brian Sune <briansune@gmail.com> wrote:
> > > > Improve handosff prepare on SoCFPGA
> > > >
> > > > There are some cases that the Python scripts
> > > > are run and the qts files are not replaced.
> > > > Make sure qts folder h files are removed before
> > > > handoff script runs.
> > > >
> > > > Signed-off-by: Brian Sune <briansune@gmail.com>
> > > >
> > > > arch/arm/mach-socfpga/config.mk | 29 ++++++++++++++++++++++++++---
> > > >  1 file changed, 26 insertions(+), 3 deletions(-)
> > >
> > > Typo in commit message: "handosff" should be "handoff".
> > >
> > > > diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpg=
a/config.mk
> > > > @@ -8,6 +8,8 @@ else ifeq ($(CONFIG_ARCH_SOCFPGA_ARRIA5),y)
> > > > +HANDOFF_KEEP ?=3D 0
> > >
> > > > diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpg=
a/config.mk
> > > > @@ -43,6 +45,27 @@ socfpga_g5_handoff_prepare:
> > > > +             if [ -n "$$HANDOFF_KEEP" ]; then \
> > >
> > > HANDOFF_KEEP defaults to "0", so -n "0" is always true. I suspect you=
 want:
> > >
> > >     if [ "$$HANDOFF_KEEP" !=3D "0" ]; then \
> >
> > Hi Simon,
> >
> > I think this is a misunderstanding.
> > My original idea is to use the HANDOFF_KEEP=3D(whatever is mistyped)
> > to run the keep branch.
> >
> > While the absence of HANDOFF_KEEP(anything) will not keep.
> > But simply HANDOFF_KEEP will not work and need HANDOFF_KEEP=3Dxxx.
>

Hi Simon,

> I'd suggest either dropping the assignment to '0', since someone
> reading the Makefile will reasonably expect the shell to see it as
> 'off'.
>

Yes indeed so I had pushed patch v4 and fixed what you suggested with
my inheritance idea.

> In any case, how about a comment above to explain what the argument is
> for and what it does?

I guess patch v4 has no issue self explaining the check condition has
undergone those expected logic cases and exists HANDOFF_KEEP.

So v4 simply:
HANDOFF_KEEP=3D <- keep
HANDOFF_KEEP=3D0 <- no keep
HANDOFF_KEEP=3D1 <- keep
HANDOFF_KEEP=3D'0' <- no keep
HANDOFF_KEEP=3D'1' <- keep
etc.

Thanks,
Brian

>
> >
> > Because the command >
> > "make prepare HANDOFF_KEEP=3Dxxx" is very distinctly long
> > HANDOFF_KEEP=3Dxxx so it must keep my thingy.
> > Even if I mistyped =3D0 etc.
> >
> > And during the absence of HANDOFF_KEEP=3Dxxxx
> > "make prepare " immediately, see ok clean so it will not keep good.
> >
> > That's my original thought.
> > I think I should changed to:
> > if [ -n "$${HANDOFF_KEEP+x}" ]; then \
> >
> >
> > Need your comments on this.
> >
> > Thanks,
> > Brian
> >
> > >
> > > Otherwise the 'preserve' path is always taken and the 'clean' path is=
 dead code.
> > >
> > > You could also have an empty variable meaning don't keep.
> > >
> > > > diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpg=
a/config.mk
> > > > @@ -43,6 +45,27 @@ socfpga_g5_handoff_prepare:
> > > > +             trap 'rm -rf "$$TEMP_DIR"' EXIT;
> > >
> > > The trap is set after TEMP_DIR has already been used. If the python
> > > script or mv fails partway through, the temporary directory won't be
> > > cleaned up. You could move the trap to immediately after mktemp
>
> OK I had that wrong. If someone presses Ctrl-C while Python is running
> it would not clean up, but that's a minor issue...
>
> Please note that you should add a change log for version 2, 3, etc. -
> see here for details:
>
> https://docs.u-boot.org/en/latest/develop/sending_patches.html
>
> Regards,
> Simon
