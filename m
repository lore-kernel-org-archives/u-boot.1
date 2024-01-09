Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF9EC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 13:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EF538785D;
	Tue,  9 Jan 2024 14:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="b6GmRX2w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 883D0878D7; Tue,  9 Jan 2024 14:17:14 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 517C4877F4
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 14:17:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5cdfed46372so2163003a12.3
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 05:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1704806230; x=1705411030; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGogBy+hvjYTRWlfhEbBAJ6tjOgcZeQduX7SPInnJ3k=;
 b=b6GmRX2wxg7lBchrgxZKKccImhKjyy4BfSJjY4DJUDS/WFUqLjfOgUl7Vly+L7bmMk
 sDBG951wC3mf6OlS2IubMDikWHGbhJG446tyYzAshS0GulO2G11V+Whd5trepAOKBk2d
 Lq0X3UbA+07tYOKCmL47grSjCjzfKeAgA0EdGp9kS6Q2Y+YRVEOs45MXlFSXFLXfSO3U
 FKsEl183U6xTYHlfgg189+eGyILni5dHrffVYyRLoWK/ri9I6cXkOlQ6WgkwGP21LI6x
 zycJyv/g455ir0dZR62+b1gcbwM4256bsAYtG8Jxt12JkWHcxpfCqfvMnhf+f0CjgaRj
 H5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704806230; x=1705411030;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PGogBy+hvjYTRWlfhEbBAJ6tjOgcZeQduX7SPInnJ3k=;
 b=LHUewRLSGDaiotZ+w19GgBfoyE/vCwZe9no85vaqovHVxDT2R9sHbYBVYaOGznYE2u
 jm38G2+6gf2hKTbAdAsC/izG1z++ZvWyKQg9NnVXZk89f+6ved0dEeSwfyTTOJiUax7O
 tnnvniP+bdsashwJDR7v88mRpN1wTUj5MNBh4nMwT/SeJ1LlJBzoWLnmFDBrzt96tOHR
 75mkqGdGoBstO54U15CQzxQX207qPq5fNUsJF9TN22jI7GnNf5cojqEzONLvOzHzo+Oy
 +RhPJBxPsQ9W6RJNpxRYNLookRfAn2OC4w4asrMkq8Bj+6n06d1AcNv9qyNJK77pH37T
 mqYg==
X-Gm-Message-State: AOJu0YwxxJk5Pb1qL9NNoMr+djdziWdpFzYimq1yQhaYtIBhXJtGLPAa
 KmRQna9bP8bNg5BZC6CvvqTPpNGOUiUeLvnZfXz0bsicmJgZbg==
X-Google-Smtp-Source: AGHT+IHa18lEryav7pTJ4JJwSCvJlNVlcdbwvePEvKbcC6VkYWKWcqyWJ904sQerMomsmWGdengDIywXhIwRtgkXoW8=
X-Received: by 2002:a17:90a:7f89:b0:28c:27e6:c4b7 with SMTP id
 m9-20020a17090a7f8900b0028c27e6c4b7mr3292502pjl.78.1704806230653; Tue, 09 Jan
 2024 05:17:10 -0800 (PST)
MIME-Version: 1.0
References: <20231129101117.60177-1-robert.marko@sartura.hr>
In-Reply-To: <20231129101117.60177-1-robert.marko@sartura.hr>
From: Robert Marko <robert.marko@sartura.hr>
Date: Tue, 9 Jan 2024 14:16:59 +0100
Message-ID: <CA+HBbNFbLjSwY9QRP09SXVDMm=TJ1q4isgkce6p-H7LAnwZZ2g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] arm: mvebu: Espressobin: move FDT fixup into a
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

On Wed, Nov 29, 2023 at 11:11=E2=80=AFAM Robert Marko <robert.marko@sartura=
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
Since 2024.01 was released, can this series be pulled in now?

Regards,
Robert

>
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
> 2.43.0
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
