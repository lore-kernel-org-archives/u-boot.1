Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E313FE937E3
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 13:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD9E784246;
	Sun, 12 Apr 2026 15:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yt1QRAt9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 957A883BC4; Sun, 12 Apr 2026 14:04:31 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A56483B99
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 14:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b982b0889d8so471588966b.2
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 05:04:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775995469; cv=none;
 d=google.com; s=arc-20240605;
 b=i6IHPXItGowSk8XtlclCFO7Ivv0ntftY/o5DErqwDJ4lxus+jk0H6AikUmg6RAoedq
 lFbtIQIqcY/vw9/iEp0i8UQoEQdLIEnWBTsbTM1uT9GeTVdCMWfGMOj+ztNw5Hkioru0
 RluDuj2bEa4e/FmysRSh/jUKaMLil2ZkIDcqy6XMKvX2+jCKFjHIAqz118xVclabZPMs
 ZgzYlJF6RQ0RgFqcS2SnH8pxaCJpVOZvMhdUGo0/Yj5fEYw+uSRvVww4FRN8qlZVNtO7
 tCTgapjm0HQPiZwr0m9W+Qg70LqyAW33N8RT+Hn+XjibXsab21V+EjnyJIBBjVAL29ZA
 rYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E2wJJNlGUEbH0znZxjxitP/O2ZUdZlz+ftgpZXwlRO8=;
 fh=YG4Nl3Op10i6Gjk1hpC8Z2cMNOqZ5Lih7c9m9PwYTMQ=;
 b=C8R1EfIa2gaF7qmlpdSz1rC+/Uw07pCXu2d+G19AgtIvdLFUBN/sGWE+fvm+Y0r8JM
 9DkSnVf+LlrAP9qOQJBwRj3Oo1cdkVmvRiqheBY3UYBG+kbMwGr10/Qaczv/rwlV6Kp/
 lQ9c8Lol1i4ZOit9uz+ig9OO9rJegu89ZxdeXBHlclo9LsAn6fraarpKpcRfKtBisa75
 b/3BtQIwMaAoxDqm2pcqMry+E6TyloOU4VoWv4Qt2ng724uOuQczsCRFavwvtIgYtz3H
 OOoyW4PQ7X7ZSVfiTAfC2Hecin5GVUGKJLdV+ARS++5VVFsfkLDFEpoNdhlQTr6pbUOM
 TbZQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775995469; x=1776600269; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E2wJJNlGUEbH0znZxjxitP/O2ZUdZlz+ftgpZXwlRO8=;
 b=Yt1QRAt9o+d57RJN6leWyc4RoXAXVyKjVSqwJ4Li1qkHKakcDA3GdFqoRbk2CoJLjA
 BFPUc+XS40c2iqHYW/RHgMUdrzLwSaNFW9PgUd/jV6SM38lkBWbQN6GJBgAW3ruP7qWi
 +GMj0KEHBFod9OXRK8EHhQrF5J8pGnO9fuQEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775995469; x=1776600269;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2wJJNlGUEbH0znZxjxitP/O2ZUdZlz+ftgpZXwlRO8=;
 b=GwV8Gi8gvDylV9pBc5Dwk9VUTfWDywCSvNp2vSLQRpPwwB8dHE7+u/tH2E9a9iZVEB
 VgVC6+OQwyiH/fAaODmtZcEb8FCYA3PyAj3TEdo6XLYmZLh7URQ0Wt7Cpdh8JWGBkHjd
 XMXYXTArskye+j2w+qm47wyEHJ7XIxxBd9XfjFE+Jr0a57jJm9mLP6UCAt1zCwWNN3Qy
 ZFa2KTtXslKi3vd3UjjklR0LR2Ou3W5wsklKaEHiBrdG0jYc8cmcaAN7Lgwpzl8aKtR0
 RpSSfDn5iFLVq9yotPn0yPal07lPPC+pTBTv3t3oasACRXgXMWWY/RIyDy6arEIyqHhc
 Xf+w==
X-Gm-Message-State: AOJu0YyiUj4ngseIyV2jy3S/lwH0gGciFMtKmbPQu1XWlLjb4Az34xKO
 ZogxEfE+QkPFz7ZdLe+sp4l6daLBjTe5chBdZWB1M/7PZCDIxwMEWTB13y0gt8DbZ0RlgTo3t1y
 jrPWglOyC+X39M821NGBo1D/fIWxrOrmE98aPcWQt
X-Gm-Gg: AeBDieu4w/P/vMXoxRchdFUgzutU8K24fqBiDFROFtONoBqhZXyi5hXmModPT55uwRr
 wHf+1XW5MjQwyV9q/VRZ143dQ4aqiu+Iz4jXIwOt/wJGjXwk2OTbNZ33YPZ6J+w8+ZDF4h7+tfb
 z3aPVw2S/gDQIJgzBjqix3dnUaGPHvNz6cxWCi1TKgafZt3XRxA5BHGO/l05o5OtWt/SwiPMg2N
 d09ZRl7vA7U2lm9bmM6KTqxd0Klpfezq+HgqdR+aEFPHwophs1SujI/ogh64nTjaOLNePy/z2Rz
 wA1YcIqeZB0IeBsB
X-Received: by 2002:a17:907:3d9e:b0:b9d:c374:6e33 with SMTP id
 a640c23a62f3a-b9dc3746fb7mr139534366b.26.1775995468751; Sun, 12 Apr 2026
 05:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
 <20260404-qcom_spl-v1-1-9e6c2ac66587@seznam.cz>
 <CAFLszThhVEp3EH1Rqb6acPzJ6TbPc0p0thCG0+PHHCruKGz=iQ@mail.gmail.com>
 <be4b085e-cafe-4d68-bb80-7c929b0060d5@seznam.cz>
In-Reply-To: <be4b085e-cafe-4d68-bb80-7c929b0060d5@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Apr 2026 06:04:17 -0600
X-Gm-Features: AQROBzCr_HZU0f6EV8fhIHC5tqEMr1hMJcFOupG6yA8vlVKaK3B5vbrX78QbCp0
Message-ID: <CAFLszTi+sn9RZkBFFafKAcY4W4PJWsgdfBbOEv4C9=Fr1EmW=A@mail.gmail.com>
Subject: Re: [PATCH 1/5] Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
To: Michael Srba <Michael.Srba@seznam.cz>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 Yao Zi <me@ziyao.cc>, Peter Korsgaard <peter@korsgaard.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 12 Apr 2026 15:00:19 +0200
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

Hi Michael,

On Mon, 6 Apr 2026 at 16:44, Michael Srba <Michael.Srba@seznam.cz> wrote:
>
> On 4/6/26 17:50, Simon Glass wrote:
> > Hi Michael,
> >
> > On 2026-04-03T23:18:18, Michael Srba <michael.srba@seznam.cz> wrote:
> >> Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
> >>
> >> On some platforms (at least Qualcomm), the bootrom expects an ELF file.
> >> Since the contents of the ELF file are platform specific, add a config
> >> option that allows specifying a linker script to use to produce the
> >> ELF file.
> >>
> >> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> >> diff --git a/Makefile b/Makefile
> >> @@ -2014,6 +2017,26 @@ u-boot-elf.lds: arch/u-boot-elf.lds prepare FORCE
> >> +quiet_cmd_u-boot-spl-elf ?= LD      $@
> >> +     cmd_u-boot-spl-elf ?= $(LD) spl/u-boot-spl-elf.o -o $@ \
> >> +     -T spl/u-boot-spl-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_SPL_TEXT_BASE) \
> >> +     -Ttext=$(CONFIG_SPL_TEXT_BASE) -z max-page-size=0x1000
> > The existing cmd_u-boot-spl-elf includes $(if
> > $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) for endianness. Please can you add
> > the same here for consistency.
> >
> > Since this redefines cmd_u-boot-spl-elf using ?=, the earlier
> > definition takes precedence if both SPL_REMAKE_ELF and
> > SPL_REMAKE_ELF_LDSCRIPT are enabled. This is probably fine since
> > enabling both does not make sense, but maybe add 'depends on
> > !SPL_REMAKE_ELF' or a note in the Kconfig help text.
> Hi,
> slowly going through the reviews, I think when I originally worked on this
> u-boot didn't support remaking SPL into an ELF at all. I completely missed
> this change when rebasing (or didn't miss it, made a mental note, and
> completely forgot... hard to say at this point).
>
> I could certainly just
> add a conditional, though there's probably cleaner ways to do this where
> only the linker script is conditional (not sure what to do about the page
> size, would need to test to double check if it's even actually necessary).
>
> Actually, making the linker script path default to the standard one would be
> the cleanest option by some measures, but since you didn't suggest it
> I assume that's not your preferred solution?

Actually that seems better, something like:

  config SPL_REMAKE_ELF_LDSCRIPT
      string "Linker script for SPL ELF"
      depends on SPL_REMAKE_ELF
      default "arch/$(ARCH)/u-boot-spl-elf.lds"

Then your platform can override it and there is only a single
cmd_u-boot-spl-elf with no problems with ?= !

Regards,
Simon
