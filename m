Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD82D15DAD
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 18:18:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1E3C83AB7;
	Wed,  3 Dec 2025 19:18:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a692Gx7a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B293C83B2C; Wed,  3 Dec 2025 19:17:59 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35BD883A71
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 19:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c75b829eb6so38617a34.1
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 10:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764785876; x=1765390676; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4UbRRQsSxsclMFsohojBWUJUCx3H5BMJm6zMt9cVHWA=;
 b=a692Gx7a1RfMCDfEPROnY6pV8mH1na95+m//UwOcgOEbAOMlsFu867/r7GhE4apwAY
 l/pCjFMD8R4IOFTTMryJSKOcdSIKAQOvDolNPuSjtt3FCbfGcfGcSg9cSNEYMfnXa9H8
 eBAQHG3gdIY7HECAe4kOCJQVIoK6J8Un68gNpi2UeSEu9fB4jM1YH0Pbr7hQGPZQSYIK
 7/Km6szwPj0STzITuFiVTMD43a9A/x0plLkpAJTAzvOE5sLYe5fTZ/StMowEIhG+svNt
 7UnD7o0wcw+TD+ddF9sX4zCiRYo861WxWPgjxnW3VNk886F462GS3lAx9M5KIX/CfQcc
 Zgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764785876; x=1765390676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4UbRRQsSxsclMFsohojBWUJUCx3H5BMJm6zMt9cVHWA=;
 b=IwSon+jOpRuvUpGo0JjMlT+aajEZD4BcCEy8oSqrQVgESn8Tt5G67IWWb/2Ab1aeL/
 7p5sgOeaRAeRo6VG28e9FIYAZhhIFT3zDBFMP51tGe2C1e9s5hnoLsEdtSKBYV3Djpvi
 O2Tv2tPm4QgjLt1BqOeWl2or/Lzhn2Ih1uoX3reb2xr3zwY0pR9ZzaxlfYkgDJizOsg0
 q9yLXPDjBXG+aVx12q8qp4BHa79kO0ublgMx2HfFHatFtoW2bOS/Eelo4cxQXZbGWZ7h
 1psPdVh5h67Za3HrAzwmIzMEiQ6Jdnv2erT+bPQ027PsQwmbzfPuhbKM3nZwlQlOG3om
 UZ9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaERmORxIUrQh+QvYBzsOX+7xX8E0g9AOEWfBPpRIpP5znsmnO9FlFeDGdjdpUAM33tV2Ae3w=@lists.denx.de
X-Gm-Message-State: AOJu0Yzv2I/QC7VfjwuhtlpO3I430QDXnvbyGZyge9dVE1t5cown7kKG
 iT6rTqhodRa7l0CGD7r49dVihCeTZsr/4ZANd42BRVH8AJJPLawdZjTv3IxnK0GqBJ6fOIMV5KA
 S1Nj5btKqQYWK7/zrQdAQUNMGkaijxuA=
X-Gm-Gg: ASbGnctE2MrzmjhoPKaqrMTT4Q5SQ+4NS0jqI3wY96tNuoKUmVligJxtkqkJHVqJIkr
 +VA3VI2xCJosQ4Z/Te5AoZYXxKOxpMwBc/AT+F26y19mp1IhCWgtuiH29UyBVxHkfTUNPVpeY/f
 m7iN3lPjdXmwaKzeVzJOuqJ8xbQIDrck1Cpn7MtL5BYueB3Rv0OAseI7r+2IAa9E1wPYBOAUUAd
 /MXoSxNQatPxledJisEOkj4gH5mpeXBqmH6sPApxLdlnqH9H6bgcPzM+IqJFq0zeaW/uFM=
X-Google-Smtp-Source: AGHT+IGDwGS07ga1hWZbnZNUTe4cp2bHb1oEZ6w3qo6tWhGE2km7J4br/QIDDWW+uMUJHvsIji87o/o3gSTOcMGgAZU=
X-Received: by 2002:a05:6830:3495:b0:7c7:a4c:64fe with SMTP id
 46e09a7af769-7c94da0edc6mr2413411a34.8.1764785875846; Wed, 03 Dec 2025
 10:17:55 -0800 (PST)
MIME-Version: 1.0
References: <20251125212953.1733-1-briansune@gmail.com>
 <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
 <d024aad3-6ad5-471e-8290-e802bdbf7ead@cherry.de>
 <CAN7C2SDdTsJADMWDZgugMnoTO-sqGUt1wQPsKyRwP=gHNdmQ2A@mail.gmail.com>
 <CAN7C2SBPC=u7QJD7T=3NUUOjPqXo1UWqHb_QRzsOR_wtvZrk7Q@mail.gmail.com>
 <85af1053-f8c6-4983-adba-7a1e845651e4@altera.com>
 <CAN7C2SA78DM+XaXMJNA26o0EzxFkdwL26BfcH91boepT0bDPKQ@mail.gmail.com>
 <CANp-EDaU0Vw0dqWOfAXKub6Qq8FN5LvNJyttB6-EA4imAK8mvw@mail.gmail.com>
In-Reply-To: <CANp-EDaU0Vw0dqWOfAXKub6Qq8FN5LvNJyttB6-EA4imAK8mvw@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 4 Dec 2025 02:17:47 +0800
X-Gm-Features: AWmQ_bnKxCtGkxR6w9pepEF_JU1fo-fjdp_c6OLoRFOpd0PUWRW4CI5lHd0Hvkk
Message-ID: <CAN7C2SBSYkFrkaTDg7kuE2NsqUsjshZVepCdad+5buMSpBEmDw@mail.gmail.com>
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Ralph Siemsen <ralph.siemsen@linaro.org> =E6=96=BC 2025=E5=B9=B412=E6=9C=88=
4=E6=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=882:01=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hi Brian,
>
> On Mon, Dec 1, 2025 at 8:24=E2=80=AFAM Sune Brian <briansune@gmail.com> w=
rote:
> > I am enclosing a bit log here.
> > I had diff both sequencer on mainstream and altera trunk.
> > No diff.
> >
> > As for the sdram_gen5.c there are diff but no major point
> > before calibration fail is trigger. ECC is not use or setup.
> >
> > Setup:
> > No CYCLIC no WDT all off on dts and .config.
> > No modification on code.
>
> I had similar problem on a custom board with cyclone V. I tried
> disabling the watchdog but this didn't make any difference.

Hi Ralph,

But did you disable also all "CYCLIC" as well?

>
> After bisecting, I traced it to commit 3b8dfc42a23 which changed
> CONFIG_SYS_TIMER_COUNTS_DOWN into a real Kconfig symbol. Although this

1) If my memory recall correctly just after this week bundle merge of GEN5.
The issue cont'd exist after disable all WDT CYCLIC etc.

2) This is still a bit contradict what T.F. mentioned.
If anything that is related to the time or counter then the original
susception holds.

3) I use socfpga_cyclone5_defconfig and only change minimum settings
that I needs.
From this issue mentioned to current day.

> was updated in socfpga_cyclone5_defconfig, I had to make the same
> change in my defconfig.
>
> Not sure if this is your problem too, but worth checking, particularly
> if you're using a custom defconfig.
>
> Regards,
> Ralph

Still thank you and I will check.

Brian
