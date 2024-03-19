Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD09C6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 18:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ADDD88059;
	Tue, 19 Mar 2024 19:22:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="RXWRIIVN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7242B8806E; Tue, 19 Mar 2024 19:22:20 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44C4D87F77
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 19:22:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=barnas@google.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-29fb11f4b34so122936a91.0
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 11:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1710872537; x=1711477337; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pLK9nPlzml3dpmYlx1/pQVnORWzPW1Z3ArvrblRTfnc=;
 b=RXWRIIVNmvdGdzo6BxuCv7dez+9ZXKFbAzRxbnXsgxLWVbw/ZVeUZfJkY41scgBt+9
 rh+giGSFDvgtmG8vKkF0gaP+wGJzKWU8kk/JNYvXxWgNyfO2iEoJAC9ieYWUo2M/7dZa
 V0eJDN729m8gl/xsGBGOyydWqNRwpWfEJFAl51ctLZtslLgQT/wAXdmihW5hZeesYsO/
 9fZISHtTIq5ifu4QmSXTZpDfjxPlRx4F5xUELXxDCI4wqgSdjfOf3NlIjq2UbvdQXR3L
 NqDmRucy7wcocx+UREduWF8ill++rgSzjuxaSnr0WP5oWVL7SbM7KjX9n21JBzTsrRsk
 IzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710872537; x=1711477337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pLK9nPlzml3dpmYlx1/pQVnORWzPW1Z3ArvrblRTfnc=;
 b=uOsizBgF0s4z+oeM9WDvVtn1PfVgXhw1FLl3VBYEti83pmDrdi0x/S2HpMI62ps7Kp
 4gZZenClAX5xEJ5ULN3Wlc8+BI8B2vz8A9rnk7hAsVYcRft/OeeV7ombJ5laNtz4mSAX
 44qRT9G/b+h5nj6Gax9XZPGqYfysR3Ihoy7g9isfNinwkiakQFYwpxMwfvITegQ16SXc
 fH6AFwTWESDR6y8hxDtiPItx5qtGENq1quB1bmOBIJsKtvUdBSqao/2N5FDcCGiYYtJa
 Rv9J9N8mu8EX4KiybvPHKNOGVPcSiYIPGKwHoCH4SPPG/ompVLdrVPbZa3O3bOxvyHpZ
 0Bqw==
X-Gm-Message-State: AOJu0YztLg9jze7SsDUcnxPyn8TIv0foDjydELQE02HOUe08W5eTfbmY
 KAtkpaz8AVd1gWD+ojB6exsfu7NRsZ/yXDoaeZWlQpGwkbujhWlPAfXAvFjTAFrS1Ut02Kc0Xh/
 rqI0fP4FyWH0I/b2owNGYytZ5x3GtnTJJLyti
X-Google-Smtp-Source: AGHT+IHYDcMH/wyKu6DhNthc6laoILf+6/GqsyPOojKHoJuBkh9VUdg1ht5uo9PqrLZl9hQ1hprLQvBOqmRmyWzcrcI=
X-Received: by 2002:a17:90b:1988:b0:29f:e0c1:6e5b with SMTP id
 mv8-20020a17090b198800b0029fe0c16e5bmr2742026pjb.23.1710872536433; Tue, 19
 Mar 2024 11:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <6a69588a-7c50-425a-af7f-96caff727113@kernel.org>
 <20240308171251.106144-1-barnas@google.com>
 <20240308171251.106144-2-barnas@google.com>
 <c0cbfa06-9206-4ca6-ad51-ad7b0e54cf1c@denx.de>
In-Reply-To: <c0cbfa06-9206-4ca6-ad51-ad7b0e54cf1c@denx.de>
From: =?UTF-8?B?TWljaGHFgiBCYXJuYcWb?= <barnas@google.com>
Date: Tue, 19 Mar 2024 19:22:05 +0100
Message-ID: <CAO4U=ytZNcxhHt+J1OhzEGG=c0_r+sfPQzPbjyY=zxtX1icCSA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm: socfpga: arria10: add option to reprogram the
 FPGA every reboot
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Dinh Nguyen <dinguyen@kernel.org>, 
 Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@intel.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 19 Mar 2024 19:22:38 +0100
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

On Fri, Mar 8, 2024 at 8:01=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 3/8/24 6:12 PM, Micha=C5=82 Barna=C5=9B wrote:
> > Add Kconfig that enables FPGA reprogramming with warm boot on Arria 10.
> > This option allows to change the bitstream on the filesystem and apply
> > changes with warm reboot without the need for a power cycle.
> >
> > Signed-off-by: Micha=C5=82 Barna=C5=9B <barnas@google.com>
> > ---
> >
> > Changes in v2:
> > - Rebase on current master branch
> >
> >   arch/arm/mach-socfpga/Kconfig   | 8 ++++++++
> >   arch/arm/mach-socfpga/spl_a10.c | 8 ++++++++
> >   2 files changed, 16 insertions(+)
> >
> > diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kcon=
fig
> > index 114d243812..89303f1f16 100644
> > --- a/arch/arm/mach-socfpga/Kconfig
> > +++ b/arch/arm/mach-socfpga/Kconfig
> > @@ -80,6 +80,14 @@ config TARGET_SOCFPGA_ARRIA10
> >       imply FPGA_SOCFPGA
> >       imply SPL_USE_TINY_PRINTF
> >
> > +config TARGET_SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
>
> This is not TARGET (as in SoC), but a regular config option, so please
> drop the TARGET_ prefix .
>
> > +     bool "Always reprogram Arria 10 FPGA"
> > +     depends on TARGET_SOCFPGA_ARRIA10
> > +     help
> > +       Arria 10 FPGA is only programmed during the cold boot.
> > +       This option forces the FPGA to be reprogrammed every reboot,
> > +       allowing to change the bitstream and apply it with warm reboot.
> > +
> >   config TARGET_SOCFPGA_CYCLONE5
> >       bool
> >       select TARGET_SOCFPGA_GEN5
> > diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/sp=
l_a10.c
> > index 9edbbf4a29..d5d3327a42 100644
> > --- a/arch/arm/mach-socfpga/spl_a10.c
> > +++ b/arch/arm/mach-socfpga/spl_a10.c
> > @@ -122,7 +122,11 @@ void spl_board_init(void)
> >       arch_early_init_r();
> >
> >       /* If the full FPGA is already loaded, ie.from EPCQ, config fpga =
pins */
> > +#ifdef CONFIG_TARGET_SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
> > +     if (is_regular_boot_valid()) {
> > +#else
> >       if (is_fpgamgr_user_mode()) {
> > +#endif
>
> Use CONFIG_IS_ENABLED() or IS_ENABLED() macro please .

I used the ifdefs because I thought that it would be more readable,
but changed as you requested.
Thank you for your response.
