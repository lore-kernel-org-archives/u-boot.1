Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B50CEF173
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 13:43:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1AB388E9D;
	Tue,  8 Oct 2024 15:43:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nQLngpCc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC8CA88CC1; Mon,  7 Oct 2024 15:59:50 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D4AA88CEA
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 15:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6db4a432658so2754097b3.2
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 06:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728309587; x=1728914387; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y5AoMsJUF/ImkTdCAVkBEPjevhb+VZWVNLTqWJbytRk=;
 b=nQLngpCc55PjJ8rWvXMB8cG82HiUChOywJwS58q8gvnkRHnV5RIdTRw8uG3y3jWPxK
 wp0jdEuOD1xWJQeO5vE+pAWdBcgd4wXiwrUpol1KiKNN+nnugkR+6j3fxsjsobU1whsz
 lincd66tBFObDADEbjhSxjNyW5nuGJepiAg//l+PA4iu6EwuqIq2iaFV6kJ7HZmU6OZV
 //FoCjTapvD6i1H9FZAxmiy7AHy7b46gRXpzyoCMeXKzoQTpJavm3lE9krWoWCpcnlH7
 NwXNucm6jGs4AzryuIuAFVDC1Oz0fBPuoLuCVghRgfAImiSPgc9W5OwgGIGogkL/5jkD
 HgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728309587; x=1728914387;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y5AoMsJUF/ImkTdCAVkBEPjevhb+VZWVNLTqWJbytRk=;
 b=L+pF6l0vqJsO9gBncpp8974Jodoiy9uXrTj4gtSnPavr9yeq8wCxn6PKlz9nNHvdWn
 21MFryLviLLE+bLiw6lSibHAK8GITXM7us8tFIQWh8ivnaDA/6hdqkhCnU2QqMQ/xWwP
 xi4L7PZ1ZJJZZj6ub9J7FSgP3z85N8FlBXmO7RhTlNwBc71BkTiX31AxWEtgslzrJb3v
 U4hHmu3H4JPMzF2LBnsKzoYmBuQSGdo5GKlQbxEcns9g/8x3AxeztWGYWbDyIcNjtnsd
 hQFb681Zm8perVvbGalepiIT2iU89b4SuX0lR6Sw68yiGy3uq1ijzZZu+zmhh3XRD2Oe
 ONGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJyXyAztiboCANLT7YGBBKO7p3R2vdHyKBkv0peQR0TpSELwK051pYiZOisohVuB+TSh6qBEA=@lists.denx.de
X-Gm-Message-State: AOJu0YxWmEaAfm54AaNR1YCqv5Lw5RmpYUYDWExLrl73PCXoHjEvjvwX
 io/XREZ5UXLl4oBeBl1do1y4ofmu5VmiFVb6f++5JWgwcKC4LsztRoK13PfLFkYKHMHselomXdd
 cPp+IylpfG80TpV9r8FwtRyzjTTs=
X-Google-Smtp-Source: AGHT+IEdp06W22xgsXqMzWFnO+5qT5Eu0gibiyX1ofDBrNQgiYvvIVikHDZEkKmtfjvo7nYR/1aqNqq0eF4kH9XB/wE=
X-Received: by 2002:a05:690c:39c:b0:6d3:c7d:5eaa with SMTP id
 00721157ae682-6e2c72dd7d5mr36169217b3.8.1728309587070; Mon, 07 Oct 2024
 06:59:47 -0700 (PDT)
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
 <CAFXKEHZCtXeJupi1H+V8pgumBe8m1Vgdg5-OrQ870H-_nSbJhA@mail.gmail.com>
 <91b1de6d-b686-4f21-86c2-f5a3bef8c56c@denx.de>
 <CAFA6WYOxiQarHHhoJAbbgV9y4OOnWVZFh-aV_wvpNKix0G6_mA@mail.gmail.com>
In-Reply-To: <CAFA6WYOxiQarHHhoJAbbgV9y4OOnWVZFh-aV_wvpNKix0G6_mA@mail.gmail.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 7 Oct 2024 15:59:10 +0200
Message-ID: <CAFXKEHbxUzDGzLdLvUek=_YLj1UOz_P0NwdARC=mPJdLrP-V8g@mail.gmail.com>
Subject: Re: [PATCH 2/9] ARM: dts: socfpga: add Enclustra Intel AA1
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, trini@konsulko.com, 
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 08 Oct 2024 15:43:16 +0200
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

Dear U-boot community!

On Mon, Oct 7, 2024 at 12:21=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Sat, 5 Oct 2024 at 07:14, Marek Vasut <marex@denx.de> wrote:
> >
> > On 9/29/24 9:19 PM, Lothar Rubusch wrote:
> > > On Sun, Sep 29, 2024 at 6:55=E2=80=AFPM Marek Vasut <marex@denx.de> w=
rote:
> > >>
> > >> On 9/28/24 12:47 AM, Lothar Rubusch wrote:
> > >>
> > >>>> [...]
> > > For U-boot I will need to build a devicetree file from archarm/dts. I
> > > cannot rely just on the upstream fragments for u-boot. Imagine
> > > settings like initial fpga bitstream loading, handoff file setup for
> > > initialization, etc. In parts I may use .dtsi files from dts/upstream=
,
> > > though, but most of the u-boot particular devicetree setup will resid=
e
> > > in arch/arm/dts, I guess (you may see later in the patches).
> >
> > You should be able to use dts/upstream/src/arm/intel/socfpga/ with
> > -u-boot.dtsi from arch/arm/dts/ for this purpose, right ?
>
> Yeah that's a possibility. But are there any plans on pushing
> currently U-Boot specific DT bits to upstream DT (Linux kernel
> source)?
>

Hum, I have certain requirements when working with Arria10 Socfpga
SoMs. Here, I need..
- to do the handoff initialization from DTS (only in u-boot)
- to setup a fpga loader for the bitstream in the DTS (only in u-boot/spl)
- to adjust the boot media, needed for u-boot to know from where to
load the fpga.itb
- and to mux the boot-mode in the DT, e.g. QSPI off when booting from
MMC, and vice versa

So, time has passed a bit. I don't need different memory declarations.
I don't need DTBOs, but I'm applying the  #if IS_ENABLED(CONFIG_..)
approach, just great! This reduces complexity by far and I can load
the major part from dts/upstream. For the rest I noticed the Google
Chameleon HW takes a somehow similar approach and I tried to align my
DTS setup to use common base for the handoff and early init approach,
which reduces the need to add additional files.

Nevertheless, I have to not enable CONFIG_OF_UPSTREAM, since I need to
keep the .dts file to reside in arch/arm/dts then taking some of the
.dtsi files from dts/upstream. This works and I'll present my solution
very soon.

> >
> > > I noticed when setting the option CONFIG_OF_UPSTREAM in `make
> > > menuconfig`, it prepends `dts/upstream/` to the included paths of the
> > > devicetree files. The resulting path for the .dts was then
> > > dts/upstream/arch/arm/dts/ and could not be found anymore. When I
> > > don't activate CONFIG_OF_UPSTREAM, dts/upstream is in the Makefile's
> > > include list anyway so that I easily can include from both locations.
> >
> > +CC Sumit
> >
>
> Yeah that's true it's done on purpose to allow reuse of DT sources
> includes (.dtsi or header files) even when CONFIG_OF_UPSTREAM isn't
> enabled.
>

As I said to me this comes in very handy.

So, as an update, I started upstreaming of my DTS parts to the kernel,
at least Marek should be in CC, here.

To the u-boot v3 patch set I prepared further brush ups. I changed
over to  using standard boot env, and currently pretend removing all
of the manually provided env. I tried to get further rid of deprecated
things and after a major rework of the DT approach now I have mainly
one blocking issue.

I'm not sure, perhaps I'll send you the patches together with the
question: The altera_set_storage  command in  the u-boot env was
working with the old GPIO API and without using the DM. So, I defined
a small U_BOOT_DRIVER(). I don't want to have DT binding for that
device, but rather coming up, when I call
uclass_get_device_by_driver(). Nevertheless, this function now does
not give me a valid device back.
IMHO I don't even need an extra bind() or probe(), anyway I tried
with/without explicit bind(), with probe(), I tried even to do a
crafted binding in the DT with the of_match table. But seems I'm
missing something essential. I saw other drivers could use GPIOs
relatively simple. Do you know an example where I could have a look
at?

Then I would use this device and simply implement the
altera_set_storage functionaly by the modern GPIO API on the device.
I'm a bit unsure what I'm doing wrong here. Perhaps I may show the
patches with this issue?

Best regards,
L
