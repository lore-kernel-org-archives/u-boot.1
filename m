Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7863AC0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 11:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B08DD800B3;
	Tue, 11 Feb 2025 12:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NMeRxHaD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DC71800CF; Tue, 11 Feb 2025 12:11:23 +0100 (CET)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E0C380079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 12:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-867082baa8eso996641241.1
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 03:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739272280; x=1739877080; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nmS15N+oNzjssSiqAoA1M//DVMzzwG/CJ5E1ftRkq6A=;
 b=NMeRxHaD4ZB/sqxt6OwP+IrIyDoKUYu37lElDAc53Xaulh/1u43+MYjP1M4r+wbt1B
 kfU/cyA7DRlkDt/yslnTtzcKOjUiEYbtOUW+QedqJLiaO213n6OXJu/dEP8To+N8v+Ww
 xO3/oLxxuFY8ZfhvBdP4HMPaEX13TsBG3HqhozSs/3CqTpVpO1Z1nyY2mN5v0Ch4bTAo
 382mSQQuGe75OH744CAuGhW8kAetZMDzDr/5Z/EM0EyMMNxgiVdkpF1ezpXG1ff5NQt9
 G3+et0Mtwk81GA77wFhzV89U4PCuwFsPZeCxABh91HdeVxxxfQ8NDmMY++Bl9Ao3xsB3
 btpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739272280; x=1739877080;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nmS15N+oNzjssSiqAoA1M//DVMzzwG/CJ5E1ftRkq6A=;
 b=ThJlPzy3wnIDBiwUddx9cONJS8GnwTWOcOr9tid7ReP61/Da6wCiNq3EExkz8bFMYM
 z1nmupSVXh3FE9oit/qk6e1Z41L08GadGQZ0WxbSWHGlVH31ow3LAddYWt4yd8WqJeBx
 hSFtCySumZi3TLO+EAfLxxRYegA1qWp5HM/ws1q75hLv+SA18Pi9KFq5+cVmyN1GehOK
 V3mpYweEjhuMwZKocMqTD9QGmqVvMCFKiodE+5WcsgBaLt/uvZvop0rUuanC+iGDi6oi
 vj+4a3/3XB3UpSK0prkJyaH2oLniF3JeNqEx02WrCwc4xULJgNKkNm8RFghXLoOlaP4i
 tdzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFETqqaw2VLxniUyoXJQpC46dMESWnHMy3gyPdpZugiRjcdBm8wjiPg82eHqk7PwRLdgaEy/o=@lists.denx.de
X-Gm-Message-State: AOJu0YyzVo5jaeeuMG19Em6ao4/RDCHaA/3SiyIOyGty9DRfJ/DNuXV4
 BsNt4l9TIeQHNvQbzy0z8RRTAk7lzpqsvTg7HmVtavMW7Iytu5/6xFrK+spytQt2/Xdvdjaha7k
 vhwcc2dv7LgqhAZm8oJygWm9bPZUTVUhioJRYKw==
X-Gm-Gg: ASbGnctCTjdmqNAfACeOhxdzY1PDtYVDXuctd2GYz3vkKHn3lw0pNIdzr1NgQqpi03t
 nTqojBJB/4ijT/Y3b6I2qKv8j8HNOClnQq+hHVLqgBFRWovWRyZ7TkKvwkvs/D+LbZuU6S2ombQ
 ==
X-Google-Smtp-Source: AGHT+IGPYkd3phFZTz4437PT+n54MUMYSDV1ASX6wUab3tAJsx9pOn+Vy0LHD0dPwusxeRhZ8Y5ils8MDIWCR8qVNtQ=
X-Received: by 2002:a05:6102:3581:b0:4bb:9b46:3f88 with SMTP id
 ada2fe7eead31-4bb9b467aacmr6544899137.11.1739272280011; Tue, 11 Feb 2025
 03:11:20 -0800 (PST)
MIME-Version: 1.0
References: <20241015153717.401371-1-sughosh.ganu@linaro.org>
 <20241015153717.401371-6-sughosh.ganu@linaro.org>
 <20250117-molecular-quicksand-e80bf947313e@thorsis.com>
 <CADg8p97Q70PnsXd=GtTLncg8B8LMTN7bda4YXxb+VDnCU4HL4Q@mail.gmail.com>
 <20250120-shine-extended-134d3ccac85f@thorsis.com>
 <CADg8p96wCZppfKBrVok6nU1eyx=dHcAH9iZaiHa_jMkYd1LHUg@mail.gmail.com>
 <20250211-distract-whooping-739989988035@thorsis.com>
In-Reply-To: <20250211-distract-whooping-739989988035@thorsis.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 11 Feb 2025 16:41:09 +0530
X-Gm-Features: AWEUYZk-KwYQaWHFDevp-9ME82MJ8bkE4TjuMeOuiQ6_yI0NCLpl8ekYhALniV4
Message-ID: <CADg8p94iMJv5ph51ng8r=HaiMSdSMj08Lj03=Amt+2JzyFySYw@mail.gmail.com>
Subject: Re: [PATCH v4 05/15] lmb: notify of any changes to the LMB memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mark Kettenis <kettenis@openbsd.org>
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

On Tue, 11 Feb 2025 at 16:34, Alexander Dahl <ada@thorsis.com> wrote:
>
> Hello,
>
> Am Tue, Feb 11, 2025 at 04:23:13PM +0530 schrieb Sughosh Ganu:
> > On Mon, 20 Jan 2025 at 15:43, Alexander Dahl <ada@thorsis.com> wrote:
> > >
> > > Hello,
> > >
> > > Am Mon, Jan 20, 2025 at 02:40:38PM +0530 schrieb Sughosh Ganu:
> > > > On Fri, 17 Jan 2025 at 16:40, Alexander Dahl <ada@thorsis.com> wrot=
e:
> > >
> > > [=E2=80=A6]
> > >
> > > > > This changeset breaks build with CONFIG_CC_OPTIMIZE_FOR_DEBUG=3Dy=
 for
> > > > > me.  In a usual non-debug build, everything is fine.  However in =
a
> > > > > debug build now I get this error:
> > > > >
> > > > >       UPD     include/generated/timestamp_autogenerated.h
> > > > >       GEN     Makefile
> > > > >       Using /mnt/data/adahl/src/u-boot as source for U-Boot
> > > > >       CC      common/version.o
> > > > >       AR      common/built-in.o
> > > > >       LD      u-boot
> > > > >     arm-v5te-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_ma=
p_update_notify':
> > > > >     /mnt/data/adahl/src/u-boot/lib/lmb.c:458: undefined reference=
 to `efi_add_memory_map_pg'
> > > >
> > > > Can you share the details of the toolchain that you are using, wher=
e
> > > > can I download it from. And the target that you build which shows t=
his
> > > > up. Thanks.
> > >
> > > Although I'm actually building with ptxdist and
> > > OSELAS.Toolchain-2023.07.1/arm-v5te-linux-gnueabi for a custom board,
> > > you should be able to reproduce the behaviour easily with buildman on
> > > master when building for boards sam9x60ek or sam9x60_curiosity like
> > > this:
> > >
> > >     buildman -o ~/build/u-boot/buildman -e -a CC_OPTIMIZE_FOR_DEBUG s=
am9x60
> > >
> > > My output when running the above is this:
> >
> > Sorry, I haven't spent time debugging this issue, although this is on
> > my todo list. Btw, since you already have a working setup, can you
> > please reset your tree to the following commit and then check if that
> > fixes your issue.
> >
> > 92e75ee47f1 ("board_r: Remove duplicate headers")
>
> Does not change anything.
>
> Note: my tree is not special in any way, it's a clean mainline u-boot
> checkout and I'm building for a board with an in tree config.
> Everyone should be able to reproduce this by using
> configs/sam9x60_curiosity_mmc_defconfig, enabling
> CC_OPTIMIZE_FOR_DEBUG and building with the default toolchain
> downloaded by buildman, which is also mainline u-boot tooling.
>
> My assumption is: some efi code is pulled in unconditionally here,
> but efi is not enabled on armv5 and it can not be enabled,  efi is not
> needed on this target anyways.  Furthermore: I assume the code is
> optimized out when doing a normal build without CC_OPTIMIZE_FOR_DEBUG,
> which is basically building without optimizations and keeping debug
> symbols.

Okay. Please give me some time. I will try to spend some time on the
issue this week. Thanks for your quick response.

-sughosh

>
> Greets
> Alex
>
> >
> > -sughosh
> >
> > >
> > >     % buildman -o ~/build/u-boot/buildman -e -a CC_OPTIMIZE_FOR_DEBUG=
 sam9x60
> > >     Building current source for 5 boards (5 threads, 4 jobs per threa=
d)
> > >            arm:  +   sam9x60_curiosity_mmc1
> > >     +arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update=
_notify':
> > >     +lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'
> > >     +make[1]: *** [Makefile:1824: u-boot] Fehler 1
> > >     +make: *** [Makefile:177: sub-make] Error 2
> > >            arm:  +   sam9x60_curiosity_mmc
> > >     +arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update=
_notify':
> > >     +lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'
> > >     +make[1]: *** [Makefile:1824: u-boot] Fehler 1
> > >     +make: *** [Makefile:177: sub-make] Error 2
> > >            arm:  +   sam9x60ek_mmc
> > >     +arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update=
_notify':
> > >     +lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'
> > >     +make[1]: *** [Makefile:1824: u-boot] Fehler 1
> > >     +make: *** [Makefile:177: sub-make] Error 2
> > >            arm:  +   sam9x60ek_qspiflash
> > >     +arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update=
_notify':
> > >     +lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'
> > >     +make[1]: *** [Makefile:1824: u-boot] Fehler 1
> > >     +make: *** [Makefile:177: sub-make] Error 2
> > >            arm:  +   sam9x60ek_nandflash
> > >     +arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update=
_notify':
> > >     +lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'
> > >     +make[1]: *** [Makefile:1824: u-boot] Fehler 1
> > >     +make: *** [Makefile:177: sub-make] Error 2
> > >         0    0    5 /5              0:00:40  : sam9x60ek_nandflash
> > >     Completed: 5 total built, 5 newly), duration 0:00:22, rate 0.23
> > >
> > > Greets
> > > Alex
> > >
