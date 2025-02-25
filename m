Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF1DC021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 22:28:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D5DC807EE;
	Tue, 25 Feb 2025 23:28:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H+hjqq7S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA136801CF; Tue, 25 Feb 2025 22:49:27 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79E8C80FD8
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 22:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4720cfc35e9so103106631cf.2
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 13:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740520163; x=1741124963; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:user-agent:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to; bh=sgPUkn76kKTzCbrwx7DbL9C2i/N9HeorGoN6xpU5LK0=;
 b=H+hjqq7SSW8pocwkmDtwVbEcQcgh2c2MC8ogJLFEqMhvwdJz85IAdakG8ZnABrdTnj
 /EWSLkYNCGunI2oKfrY22UeQmdGgmh8dm7OI0y6wruGhA9DwvO78hgiRsezuQCN36WyM
 FUw/Enl9bre643ZpZh9d+nUHyg3Z/AWZgK1Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740520163; x=1741124963;
 h=cc:to:subject:message-id:date:user-agent:from:references
 :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgPUkn76kKTzCbrwx7DbL9C2i/N9HeorGoN6xpU5LK0=;
 b=tKwUREGO5NMCup4qxZriq3VIdQ2u1luJaj0QxXlboWGQLYh7fGp/cFKGosoW7Q63bi
 tjunuk8c8b3JXeo/Px5g3WOmv10XbbfVbk4zdm82XZERKq0VHm5XMZTjKRJdqUFSirjQ
 fzo2QlRucil02exFetG9Bx+ky0U6rQJti91o73BWolPRpShog/Z/JOb4vZp5fYnl5Gh3
 abTcUnMz49ITuubb6ovmtAguSgrsSI3iHrjxAk+NRa0bB7pKOIEasQC/kZOVgnGeQ/v1
 QhenJRun83t1S9Iq/Y/fSEVoe3Om7yiLA/jmizOTLWhxG4h/KLTapCtQFqAF83dDQlFF
 4C7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrDDABKp/geH/KdKSquZ+1t/7AGX5FWTlvzjp9IFf3NbsuZfpHbzyjremHTMlQwcr7eX1Sc6s=@lists.denx.de
X-Gm-Message-State: AOJu0YywpRbUvk4AI3JEjBK8NU3FYK4d16O8OpGFWWFYjqI9htVO6CAL
 q9TvMf5x7zuH6LtcH0Toht/8M5bls2ZZIFZnbFiHaWp3VZHpnllQIFtTthaLLyStP3Zh0KbmsCD
 hEti6q1CE0mAwX5lRWVwaoDC9Jp91eyzAB4xm
X-Gm-Gg: ASbGncucF8nriQ+FAZ6NKgzkuwMQmASpcBw8wKTW37xNztH6E3Trq1oSXhQcsiatw1g
 fjmBrD2EH+cupPj1T5zKudR4kYhCzQ37RCaxDP8E9h9hBfCvf2GVl2aYct+DgOgSmHGE/mhpli3
 J3sQS1uT1NQXS23rH4uTQmwmomf4VjCkLU9VI=
X-Google-Smtp-Source: AGHT+IFu+mXGuvvGkp8QrV0cHNinScwk1IZ20aMZUfNfoLeq5N40rK+Ou8XCNy2UiSnwv1D755MNvb0/EHD2KfBtRIY=
X-Received: by 2002:a05:622a:1a91:b0:472:ecc:c2a1 with SMTP id
 d75a77b69052e-47377116e8fmr74875111cf.2.1740520163404; Tue, 25 Feb 2025
 13:49:23 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Feb 2025 13:49:22 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Feb 2025 13:49:22 -0800
MIME-Version: 1.0
In-Reply-To: <c39b654f-c93d-42d9-aedd-ca06f1d9169c@linaro.org>
References: <20250220205900.3127680-1-swboyd@chromium.org>
 <af7c7c35-04e0-4374-b99b-addeec485619@linaro.org>
 <CAE-0n502oMFrpxpu1bdh2zGj4--SybHbAPE1ndXr1f90vTme1Q@mail.gmail.com>
 <c39b654f-c93d-42d9-aedd-ca06f1d9169c@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Tue, 25 Feb 2025 13:49:22 -0800
X-Gm-Features: AWEUYZlGp1LkbEt48p_3XSEUBkmr7j2krscfUKNxwG_58EE1e7d3ewM4j5YAgjA
Message-ID: <CAE-0n50U4c+9Y7uOBT2Go5yobBZwXmK63XhiUze6XoOid83ggw@mail.gmail.com>
Subject: Re: [PATCH 00/12] Support to run U-Boot on sc7180 Trogdor Chromebooks
To: Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 25 Feb 2025 23:28:06 +0100
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

Quoting Caleb Connolly (2025-02-24 06:30:43)
> >
> >>
> >> you might have some luck booting pmOS, we build depthcharge compatible
> >> images for trogdor
> >>
> >> https://images.postmarketos.org/bpo/edge/google-trogdor/
> >>
> >> There's also a generic ARM64 EFI image that should work. You may need to
> >> edit the image and remove efi/systemd/drivers/dtbloader.efi from the ESP:
> >>
> >> https://images.postmarketos.org/bpo/edge/postmarketos-trailblazer/
> >>
> >
> > Cool thanks for the pointers. I'm loading u-boot as a payload from
> > depthcharge so that I don't have to remove the write protect on the
> > flash. It's the altfw boot method.
> >
> > I tried to boot the Debian ISO from a USB stick but it looks like the
> > FDT memory node isn't modified when I use u-boot to load the DTB from
> > the one flashed to the eMMC for the ChromeOS installation. Does the
> > efi_dt_fixup_protocol run in that case? I've never tried any of this
> > stuff before so I'm learning while I go.
>
> The /memory node isn't used when booting with EFI, some EFI table is
> used instead. I also don't think we use the DT fixup protocol in
> mach-snapdragon so that should be a no-op.

Oh right, thanks. It's been almost a decade since I booted anything from
EFI :)

>
> >
> > I've been using this sort of flow to read the DTB from the FIT image
> > that chromeos has:
> >
> >   bootflow scan -l
> >   bootflow select 2 # Select the MMC partition for cros bootmethod
> >   bootflow read
> >   bootflow info
> >   fit=$hex_address_for_FDT_from_info_above
> >   imxtract ${fit} fdt-22 ${fdt_addr_r} # fdt-22 matches my board variant
> >   fdt addr ${fdt_addr_r}
> >   load usb 0:2 ${kernel_add_r} /EFI/BOOT/BOOTAA64.EFI
> >   bootefi ${kernel_addr_r} ${fdt_addr_r}
> >
> > This seems to work to get me to the installation menu but then when I
> > run installation the kernel doesn't boot and it looks like memory hasn't
> > been updated per the earlycon info that I see. I'll continue
>
> That's weird indeed.
>
> I think once the FDT is loaded you can just run "bootefi" with no
> arguments and it should pick up the USB drive automatically.
>
> If you have some logs I'd be happy to take a look? You can find me
> @calebccff in #u-boot-qcom on libera.chat

I figured it out. There were 2 problems with Debian. First, Debian uses
the coreboot framebuffer driver and it is missing commit ecea08916418
("firmware: coreboot: framebuffer: Avoid invalid zero physical
address"). This causes the system to crash pretty early because it tries
to create a framebuffer when coreboot doesn't provide one. The second
problem is that the kernel is so old on the netinst ISO I was using that
it doesn't enable any drivers for SC7180. I can block the coreboot
framebuffer driver from loading on the kernel commandline but then the
problem is that the mmc can't be mounted and the serial console doesn't
work because things like the clk driver and pinctrl driver never probe.

I tried flashing Fedora 41 Workstation to a USB stick and it "just
works" after loading the DTB from the FIT image stored on eMMC. How is
this supposed to work in general? Should I be storing the DTB on disk so
that U-Boot can pick it up somehow? I don't really want to write the
kernel's DTB to the flash, but I suppose I could do that if necessary.
Eventually I'll need to parse a FIT image looking for the right DTB that
matches the SKU and board ID that coreboot tells me U-Boot is running
on so that the proper display bridge is used. Right now I'm just
hard-coding this all.

>
> Ahh that's annoying, Coreboot doesn't just give you a framebuffer you
> can write to?
>

Yeah, on ARM64 coreboot leaves that up to the payload. Once the DSI and
DSI-to-eDP bridge code is ported over to U-Boot I should be able to get
a console on the display instead of over serial. I'll work on that next.
