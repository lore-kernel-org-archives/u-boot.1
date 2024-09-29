Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCFACF6498
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 02:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5731288D9C;
	Mon, 30 Sep 2024 04:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dwFBpL8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6109A88D5B; Sun, 29 Sep 2024 21:20:18 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D96C88D4F
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 21:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6dc7879ae5aso2548437b3.1
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 12:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727637615; x=1728242415; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=546DoZCUcQw4akTRD+4rc8njlbVOtzI8kB6eEMwJN7A=;
 b=dwFBpL8bwSPhnzHRVhlfok/DEpxX6UtGfb7IVQgoLFhPZJtnoHlWJ+187fJRjDkmcx
 9WnEZEnh7KxaKtSQvNvwNaCDSN5eZmmjQHQv7/SmK+9E/451Qrf/dW2cw61YvZdE0ryy
 I+vvYa3jHfUOxIkT8Wy/aR5NR1Tbap0OzqgbJf45+ter2atLnQ/jk6YAKga1SY5qlQF4
 wGTiouHh4WvcskQxmTwoP1pWnzfyPHe4ItR4usJVZD3FuDVrtOU4DYAq7wddo1TZySek
 tRt63f9rgmPt27S9a4voUnRVMd146NbAbsTph7+e9YOPlQPZZv607CHGr5jV5HULRUtY
 +eKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727637615; x=1728242415;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=546DoZCUcQw4akTRD+4rc8njlbVOtzI8kB6eEMwJN7A=;
 b=vBdTY8U9E40FR0TKb3wWib2QW0CbkEUweHwLf5KpZbXCqu1UAbSe40qm/LIVEjW7wo
 ACtbQ5xtCYOZqGfipEDeaSsuSdEsyu7qp5ptqVLFCxqUbHOn6z2NA+3Sy2trSzGei6bs
 PGe/I0yrI46KNKppk73cFp3/gXizehW7Gu4m3h0nmfzESEzr9m2SlUIxSuLAyTDyQMZk
 ucYqNjFFVDAuBvCg0QdCS5A98ZwTQALI4ORPphsuLksajH62qnHvP0lJiVQhR5y3rG1k
 h7B/wDuhnQxve2ST//dnhG/2E93i2Z/Y5swpu7THzwoeK8X6t5JYid909Qm8W6h50e5D
 FEKQ==
X-Gm-Message-State: AOJu0YwvNwOf8e4ZjW5YXV0CfXSVTzxZEiAzkoQ2t+7Zzg5JaZgB+ClQ
 lNJZK71PnhpPGwnVw1zKNhqqO1NF2D7LTWIghZEYyg8Lnlk/sK5hmAgMRf4daHxjniENXwpmib0
 cmpQ+UUVexRakQrX+WokJEHrFfZ4ccvLX
X-Google-Smtp-Source: AGHT+IHFAIVIHAKn/6tBuuwl63jzerHckF2DsOXiU9o3BuPYeyZxNUXRKHwuLbhNDEyziRtbY3gNKllAdAH0qFqIxNo=
X-Received: by 2002:a05:690c:b:b0:6dd:ca99:6a8e with SMTP id
 00721157ae682-6e258e1a699mr17333887b3.5.1727637614761; Sun, 29 Sep 2024
 12:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240912060649.190-1-l.rubusch@gmail.com>
 <20240912060649.190-3-l.rubusch@gmail.com>
 <bf99c2bd-f43c-4041-907f-f60b42163cce@denx.de>
 <CAFXKEHbOpv4g5LZ4dkUpwo1OBrRQ7YKZf10=S-2HqMtSK_OE9g@mail.gmail.com>
 <e294ce74-9b77-4de0-b7fc-0d8db9f1226f@denx.de>
 <CAFXKEHZVJiLO_qsy8wtRS9BAs4SG8crTXjoJxwgN45a8GP+JKg@mail.gmail.com>
 <57a00da7-ec38-4c3a-8e5a-b44929358337@denx.de>
 <CAFXKEHYvNC5WKphy2LZ=w5tSv_0W3DM4BjSgT821RY5wsYB1jQ@mail.gmail.com>
 <ac106ee6-d8b8-45d5-a344-85aede3e7c1c@denx.de>
In-Reply-To: <ac106ee6-d8b8-45d5-a344-85aede3e7c1c@denx.de>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sun, 29 Sep 2024 21:19:38 +0200
Message-ID: <CAFXKEHZCtXeJupi1H+V8pgumBe8m1Vgdg5-OrQ870H-_nSbJhA@mail.gmail.com>
Subject: Re: [PATCH 2/9] ARM: dts: socfpga: add Enclustra Intel AA1
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 30 Sep 2024 04:11:30 +0200
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

On Sun, Sep 29, 2024 at 6:55=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 9/28/24 12:47 AM, Lothar Rubusch wrote:
>
> [...]
>
> >>> Ideally I like to setup some Kconfig choice for base board selection
> >>> and one for boot-mode.
> >>
> >>> 1.) In the documentation control.rst I read that the u-boot.dts is
> >>> combined of several elements. Is there a way to take this base .dts,
> >>> then add a base board .dtsi by Kconfig option, and similar a
> >>> boot-mode?
> >>
> >> The -u-boot.dtsi is preprocessed by C preprocessor, just like all the
> >> other DTs, so you can have a -u-boot.dtsi file which contains C
> >> preprocessor conditional statements in it to conditionally include oth=
er
> >> .dtsi files:
> >>
> >> #if IS_ENABLED(...)
> >> #include ...
> >> #else ...
> >> ...
> >> #endif
> >
> > Going through the include list setup by the Makefile made me find my
> > mistake. Currently I may use u-boot specific stuff in arch/arm/dts and
> > include generic .dtsi fragments from dts/upstream. Note: I'm not
> > setting CONFIG_OF_UPSTREAM since I'm using the regular include list
> > which already contains dts/upstream/src/arm/intel. Is this ok? Or,
> > shall I try a different approach, which involves having
> > CONFIG_OF_UPSTREAM explicitely set in the defconfig?
>
> I'm not quite sure I understand the question. Once this platform DTs
> land in mainline and the DTs get synchronized into U-Boot, you should
> then set CONFIG_OF_UPSTREAM. Until then, you could patch the DTs into
> dts/upstream/ to test the result with OF_UPSTREAM enabled .
>

Ah, sorry. I did not explain well. Currently I patch the DTs which
should go to kernel/mainline into my local u-boot:
dts/upstream/src/arm/intel/socfpga/ as a preparation for my test
builds.

For U-boot I will need to build a devicetree file from archarm/dts. I
cannot rely just on the upstream fragments for u-boot. Imagine
settings like initial fpga bitstream loading, handoff file setup for
initialization, etc. In parts I may use .dtsi files from dts/upstream,
though, but most of the u-boot particular devicetree setup will reside
in arch/arm/dts, I guess (you may see later in the patches).

I noticed when setting the option CONFIG_OF_UPSTREAM in `make
menuconfig`, it prepends `dts/upstream/` to the included paths of the
devicetree files. The resulting path for the .dts was then
dts/upstream/arch/arm/dts/ and could not be found anymore. When I
don't activate CONFIG_OF_UPSTREAM, dts/upstream is in the Makefile's
include list anyway so that I easily can include from both locations.

In conclusion, currently I'm calling a .dts for building the u-boot DT
from arch/arm/dts. The file includes upstream stuff as .dtsi fragment
from dts/upstream and handoff from local. CONFIG_OF_UPSTREAM does not
seem to be necessary in this case.

This approach currently works for me. If you strongly disagree, I may
invest more time to find a way (or why there is currently no way) with
CONFIG_OF_UPSTREAM.

This was my question about. Anyway you may wait on v3 to understand
better in source what I'm doing, or if I'm just messing around.

> >>> 3.) What would be the best possibility to have a u-boot.dts with
> >>> handoff setup in arch/arm/dts and append .dtsi files from the general
> >>> dts/upstream - in case are there other boards are doing something
> >>> similar?
> >>
> >> See above, maybe some of it helps.
> >
> > Yes. This helped. I can set base-board and boot mode now by Kconfig
> > option with a generic .dts file. Note, it may still take some time,
> > since I'd like to test the stuff still a bit on hardware before
> > submitting something to the list.
>
> Sure

I still found some bugs. When it's working (again), I'll let you guys know.=
.
