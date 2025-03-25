Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D574C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 07:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D02FD80F70;
	Tue, 25 Mar 2025 08:15:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FBMaNq3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2AA0810E8; Tue, 25 Mar 2025 08:15:03 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B066A80EEF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 08:15:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so3058015f8f.3
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 00:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742886901; x=1743491701; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dtPD6MTAijpKf3O8Rnumcs1Z/MMDRD7EwY7XXQym3VM=;
 b=FBMaNq3lzJtrWKKEhtOVHc+/cD4Rjb5WQGGB8X+DlwXtqYH+3iMe87L0rmbSFQzjrQ
 mdu4uOShqbWpr8AwlTCr1KYtWREmjkqpt9UvDZ/CGFHanpZES30VmYXS0WrfOQoRn+kh
 /f87KSdntDBrgjib4cH+yBJDUa3uijcDYjAhxKztcbipgMKsmAQmsc+PIP557a9TKWky
 jzzNehEH7sbp0Z3lR64V9Wfln+m3PNPg02ywZycYOqEtSIW4PjdP+ZAhd6XOS7z/8TWd
 kVhLoMR6yxa3Jr6c7hl5AaQ4TiCk050OIhxPaeMs+QYjDnP3Dcd56pudXDKz2G8OP9RS
 hIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742886901; x=1743491701;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dtPD6MTAijpKf3O8Rnumcs1Z/MMDRD7EwY7XXQym3VM=;
 b=tio4kkATWeLkSa3nNgETdaAUOKDIQNkEYG7FaXR03zI/v/iMg+/85NaykC1DwOt+55
 L8p2SjHgBbXF+3hX2EQLRDnygBQqE/DpHih17sNQ6Pef4mki3w7r8dHKhoeVCsk40uop
 ThO/Jd3HER4MvXEuE2j3d78/QrW6wRAzHbdAFGfp/B3uFKmNmATRliPXZip7wUi9z9pm
 Vm0vGQDZ25/jS/IAIhBhmSpHbc+V3wPi2vI8LQpgbR41lg3nkoSa3v0BLohKM+PeJxyh
 zKmRAcCud/H87j3IyMg7CN2woMtKkkYIs6KzKr5FSxdpGBJrJxyB+JNd/gHuk3S1aKj8
 5eRw==
X-Gm-Message-State: AOJu0YxXpMBt9vCPNQceJ2U+l8GgFJMNWxzZhkAXpJO32RlJrG97wp02
 dE8wLS+w7k+2LxELB1QnaQuaLRo/La8SFBy4LwJNmB5qnXkth/zuzisporvMjc+gBGRd9uNW4Ki
 aVdJ/+A6YE2wsBeMYyPiX9ybMe4Y=
X-Gm-Gg: ASbGncuFjzk08HCP7DBdJQ9/dbNpM9NIl27zWfhTmtrDFgu7FrTRt9t6w6+uxdl6VLT
 s4gGxNmjjqBN0uXw/q/KYujQ7q9CdLHDSL6SM5lDJvXffx7VJgHtcOh+1T8t7TCm9xrTFvt7oZ7
 2kTXVdX7j7iSmafxb1aactHoqh7I4=
X-Google-Smtp-Source: AGHT+IE6moSmp0ikeseasvYQz6VDhC5lVA2qJC+QxewIhVC/UcNSxKIOU4CckDxIZhbsl8lq0yL6I7esh3NcMrXfIP0=
X-Received: by 2002:a05:6000:4021:b0:390:f2f1:2a17 with SMTP id
 ffacd0b85a97d-3997f93c5b2mr13517431f8f.53.1742886900777; Tue, 25 Mar 2025
 00:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250318083103.63250-1-arturkow2000@gmail.com>
 <CAPVz0n3JF78RQYbckMcwN6JZC+adUG+oHNzof7Wkxd+EqeBkJA@mail.gmail.com>
 <af1c79f6-cfd1-45d2-8382-f68ad84276ea@gmail.com>
In-Reply-To: <af1c79f6-cfd1-45d2-8382-f68ad84276ea@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 25 Mar 2025 09:14:49 +0200
X-Gm-Features: AQ5f1JowD9FjbsbES5T9X2muBl8hceDRvws1HUGcnIh2PEDdEftdRmVMHCV6Wrc
Message-ID: <CAPVz0n3zveefuPCY8nvcqyeQ_NqZ=woq0ZqLja2AtfBLTVC-3w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Support UART over MicroSD slot on Transformer T20
To: Artur Kowalski <arturkow2000@gmail.com>
Cc: u-boot@lists.denx.de, Francesco Dolcini <francesco.dolcini@toradex.com>, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Stephen Warren <swarren@nvidia.com>, 
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Tom Warren <twarren@nvidia.com>
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

=D0=BF=D0=BD, 24 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 22:01 Artu=
r Kowalski <arturkow2000@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hello
>
> Thanks for quick response. I know UARTD is the dedicated UART for
> debugging on TF101, but exposing UART over microSD
> is a handy trick useful for development. As I'm doing development on

It is a handy trick indeed, but it is still just a trick and not smth
that fits mainline. Maximum I can propose is picking funcmux change
along with uart over sd section in transformer t20 documentation.

> this tablet (bringing U-Boot's UEFI support and latest
> Linux), and also still using the device on old OS I'd like to avoid
> disassembling and reassembling it over and over again.

I am not sure what are you doing but TF101 has full support of U-Boot
as primary bootloader along with full mainline support till 6.14
including. It uses extlinux boot method and needs no intermediates or
chainloading.

If you wish to use U-Boot for tethered booting that is perfectly fine as we=
ll.

> Others too may find the feature useful e. g. to avoid having to solder
> which requires specialized equipment, skills and
> is potentially dangerous for the board. Also, there already seems to be
> support for that on Sunxi platforms through
> CONFIG_UART0_PORT_F.
>
> Apart from pinmux changes, would it be acceptable to include an option
> to allow switching UARTA mux to
> SDB/SDD (currently this has to be selected from board's Kconfig file).
> Doing so would allow to enable UART
> over microSD without patching U-Boot's source without changing any
> existing configuration. Then I would
> keep DTS overlays and config changes local.
>

I am fine with any changes which may simplify debugging for you as
long as they do not invade into completed device configuration without
a valid reason. Device must expose a dedicated UART for debug, not a
mux which breaks some device features just because you do not want to
contain them locally.

For example, patches which add UART-E support along with funcmux
change which exposes uart-e over usd were accepted, but patch similar
to yours which would reconfigure usd to uart for surface rt or p880
would be rejected.

> Also, today, after running U-Boot with debug enabled, I discovered some
> failed assertions in pinmux code probably
> caused by my changes, I will get that fixed before sending v2.
>
> Best regards
> Artur Kowalski
>
> W dniu 18.03.2025 o 09:54, Svyatoslav Ryhel pisze:
> > =D0=B2=D1=82, 18 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 10:31 =
Artur Kowalski <arturkow2000@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> The first patch in the series brings general pinmux support for exposi=
ng
> >> UART over SDB/SDD pins on T20. The following patches bring support
> >> Transformer T20 allowing to enable UART over uSD by setting
> >>
> >> CONFIG_TEGRA_ENABLE_UARTA=3Dy
> >> CONFIG_DEVICE_TREE_INCLUDES=3D"tegra20-asus-transformer-uart-usd.dtsi"
> >>
> >> Similarily, support for UART over uSD could be brought to Ventana whic=
h
> >> has uSD on the same pins as TF101, and other Ventana-based boards.
> >>
> > Hey there, thank you for looking into U-Boot for Tegra. If something I
> > will say hurts or offends you, I am sorry it was not intentional.
> >
> > Anyway, apart funcmux changes, all other changes you propose are
> > redundant. Asus dedicated uart for logging and console is UARTD any
> > other uart configuration must not be added since it will disrupt
> > existing configuration. If you need uart and cannot resolve an issue
> > without it you can always solder to uart-d or locally mux sd to uart
> > console fix your issue and remove it. Uart is not intended way to
> > interact with Asus TF101 and doesn't need to be exposed, panel and
> > fastboot console are and can be used to resolve most of issues.
> >
> > Best regards,
> > Svyatoslav R.
> >
> >> Artur Kowalski (4):
> >>    tegra: add funcmux for exposing UART over uSD slot on Tegra 20
> >>    tegra: respect CONFIG_TEGRA_ENABLE_UART* options on Transformer T20
> >>    ARM: tegra: expose UART-A over uSD on Transformer T20
> >>    board: asus: transformer: add DTSI file for enabling UART over uSD
> >>      slot
> >>
> >>   .../tegra20-asus-transformer-uart-usd.dtsi    | 31 +++++++++++++++++=
++
> >>   arch/arm/include/asm/arch-tegra20/funcmux.h   |  1 +
> >>   arch/arm/mach-tegra/board.c                   |  4 ++-
> >>   arch/arm/mach-tegra/tegra20/Kconfig           |  4 +++
> >>   drivers/pinctrl/tegra/funcmux-tegra20.c       |  9 +++++-
> >>   include/configs/transformer-t20.h             | 10 ++++++
> >>   6 files changed, 57 insertions(+), 2 deletions(-)
> >>   create mode 100644 arch/arm/dts/tegra20-asus-transformer-uart-usd.dt=
si
> >>
> >> --
> >> 2.48.1
> >>
