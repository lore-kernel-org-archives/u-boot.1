Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8C2C07CA9
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 10:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E15086FBE;
	Tue, 28 Nov 2023 11:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="vdgFf/y5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9707086FBE; Tue, 28 Nov 2023 11:19:37 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 528FB86F09
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 11:19:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-285c3512f37so2101432a91.3
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 02:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1701166773; x=1701771573; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVW2BtiPyvda9rhxy+uGnA3op7/Q5OcfQGaI/t2MYP4=;
 b=vdgFf/y5LrYx2yIVgdg0tle2WUU34bqbGrPX+fopoShDLrjdflqs93KODUyqpNyLXz
 g4awO6EgNLT3JGVM5JwFxYziERHclXmKlsld+AAE0gt5jN61TFFyMlU1T7CmE5NtBWng
 2PmYZ63Xe2ujH4ixSCKU5kWxncPkWnWou6mphJaS0gVzy5PK8mX1ow7cg8NH7igMrAMQ
 5cjXK8zz6jJm53oZZDAUr3QAb2UWdqqoHHOO9phndW85pX8vtjAzhEbSghMOZVHEQ1v0
 As7BlfSFr3Qf5bj73lFYxVhcAJRHEI0dzSu0fY+Rpy5OGTwoom5mgXvfTu1+lA4kbXpn
 FrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701166773; x=1701771573;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NVW2BtiPyvda9rhxy+uGnA3op7/Q5OcfQGaI/t2MYP4=;
 b=U0ZgMkZyrJQeUyF5b5ipmTzZTJxU/2RVlHU/NPsm9nA2VrSmx0LRHmyNa0We609PyS
 eVmsG3U3eoZ9ziafYNCbY23XvkWZRbcJk2LrMMWcwsSom2E/dMFPFXkQU7LI3BCGI468
 UTpCc8fc/6/8zDUHhX3NirFuZIqJZaKnAzN3dNYujFUUCvBLg+vKDuO0LQclhwyZhn2U
 c9w9dRmfp3hqkEeVnLhpgI5jDiTkaTHQ30IHWXORhF/kGURBAbwCocbED1zD5rM9MdjZ
 MIJ6+S1tB54jSl/juMvAFjJJPov3zh7Y7Esl3UwAk7Dr9FMEc20+J5MUH2bd+opYEoKJ
 TgTg==
X-Gm-Message-State: AOJu0YzH3lf3qixNH5ffR6xA2Yh2vO3rW572s/s5S5WZCFrD3LXXXQmo
 /TG7aHJlPuJ4oNxLoZzFzVVXuPaD0vVJK3+E9pVfCh0jB/hS4NIp
X-Google-Smtp-Source: AGHT+IGuG9rtwdmnnKjEHTwjgI1NsLATIp/T6hP8CrVYr2tNO3EgMMX55dndWmq4Oew21ufx8bihG9e+4ZiHizIAU1g=
X-Received: by 2002:a17:90b:3e86:b0:285:93f0:b2a4 with SMTP id
 rj6-20020a17090b3e8600b0028593f0b2a4mr14967607pjb.7.1701166773657; Tue, 28
 Nov 2023 02:19:33 -0800 (PST)
MIME-Version: 1.0
References: <20231020102117.1583572-1-robert.marko@sartura.hr>
In-Reply-To: <20231020102117.1583572-1-robert.marko@sartura.hr>
From: Robert Marko <robert.marko@sartura.hr>
Date: Tue, 28 Nov 2023 11:19:22 +0100
Message-ID: <CA+HBbNHa_a2hnU9HgxsYjAaUijsgmb0ndDMOVaBz7GLP4JOVUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm: mvebu: Espressobin: move FDT fixup into a
 separate function
To: sr@denx.de, u-boot@lists.denx.de
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

On Fri, Oct 20, 2023 at 12:21=E2=80=AFPM Robert Marko <robert.marko@sartura=
.hr> wrote:
>
> Currently, Esspresobin FDT is being fixed up directly in ft_board_setup()
> which makes it hard to add support for any other board to be fixed up.
>
> So, lets just move the FDT fixup code to a separate function and call it
> if compatible matches, there should be no functional change.
>
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Reviewed-by: Stefan Roese <sr@denx.de>

Hi Stefan,

Is there anything I can do to get this series merged?

Regards,
Robert

> ---
>  board/Marvell/mvebu_armada-37xx/board.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mveb=
u_armada-37xx/board.c
> index 04124d8014..1471caa9a6 100644
> --- a/board/Marvell/mvebu_armada-37xx/board.c
> +++ b/board/Marvell/mvebu_armada-37xx/board.c
> @@ -363,18 +363,14 @@ EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_in=
it);
>  #endif
>
>  #ifdef CONFIG_OF_BOARD_SETUP
> -int ft_board_setup(void *blob, struct bd_info *bd)
> +static int espressobin_fdt_setup(void *blob)
>  {
> -#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
>         int ret;
>         int spi_off;
>         int parts_off;
>         int part_off;
>
>         /* Fill SPI MTD partitions for Linux kernel on Espressobin */
> -       if (!of_machine_is_compatible("globalscale,espressobin"))
> -               return 0;
> -
>         spi_off =3D fdt_node_offset_by_compatible(blob, -1, "jedec,spi-no=
r");
>         if (spi_off < 0)
>                 return 0;
> @@ -459,6 +455,14 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>                 return 0;
>         }
>
> +       return 0;
> +}
> +
> +int ft_board_setup(void *blob, struct bd_info *bd)
> +{
> +#ifdef CONFIG_ENV_IS_IN_SPI_FLASH
> +       if (of_machine_is_compatible("globalscale,espressobin"))
> +               return espressobin_fdt_setup(blob);
>  #endif
>         return 0;
>  }
> --
> 2.41.0
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
