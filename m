Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45038E8537A
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 17:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7421E83F9D;
	Fri,  3 Apr 2026 19:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ad3cqlTP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 230248407E; Fri,  3 Apr 2026 19:17:12 +0200 (CEST)
Received: from mail-dl1-x122d.google.com (mail-dl1-x122d.google.com
 [IPv6:2607:f8b0:4864:20::122d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCF7883DC9
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 19:17:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-12a80c36350so2438318c88.1
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 10:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775236628; cv=none;
 d=google.com; s=arc-20240605;
 b=DM0VyYoPE2ps27IhsF5ibEX7lTnfEx+LTp5YqkVs6fM88w/i4YqaEqnjN6zjpSF6mc
 m7/QCxo2VQ7BAoAyJwwU6rkhbzJFyD2hZYgOBpdZD1TlgcmhAw4Y9UEgjluvBmW8PI1i
 V3+5u96L68BiqaaEQ80ST+A/pFLWHNlEOLstCPSbFl1wbCSM8Q7Ug6vnvxmo+mjUwg6o
 3w47MhT2OV+xb1paqnAhu/mDpLFtmqR/vcg3lB+KP5xH95MF8CD9kw3u0QBZUjhey5Dk
 XeK0pSoZPHGLPgTB+t0/2ehfS3+Scx336+Nr94ZeqLPg6PuB9NEzaZxejErwKGovxpCk
 rZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KubWgubVU2i3MNxPZ/XgyYvTy+oywhzqdxilSGQFGOM=;
 fh=CieUgEZBut+jJLELXIH43TFd0DuqPf1Adff7Eqvk0+E=;
 b=EsBR2xAwltKurcaRV3t/JGFK/afWC1pP1nt9O1i9o5apoNxGAwlsFtvqn1nRVCcJHI
 ulv14VgHf0KdbcMcze4tKyEpqd01/0qhgwvsK/SUPD27G5vTZeXl17AmlcUjTZWa/duw
 RYfssKF8aNbR0PegUO0W8IEIXptL+XNSIkkZUoe8qJ7a2LMxb+j4RXkZdSxHijBTw99e
 lzojCOY2/l7TN6V6w0fnG86+CN4Fxjib69Me25oNti8ec4M5a5iMXjPfTPdGMHmPk9fV
 YitBbq88stcIBh4TxEPvsVWivTl2Hk40IazRpVpt3VpRCBhZANaYgKE08YQke6uMk2ra
 tVqg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775236628; x=1775841428; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KubWgubVU2i3MNxPZ/XgyYvTy+oywhzqdxilSGQFGOM=;
 b=ad3cqlTPglNODz1/Ykfhf1byvLfJhIgiXBlXeeDY5G4GKXgPhdCcsLAbhz6fWDOee1
 6MuT6jqkCytA6bmpFotPmF0RqVUAlZsYM22hLLD5gT5O/zTo3d51yD+3XdHXmuZRbK1q
 KzgCNS8P9HMF1iJgeVCQxi6r/pWv3yec13/8GB7PyPYVNO9sabi5F+YgVJyjwRDrhP2n
 Ur4k7vXKzjvRawyF4p39L+bVVtxiyN3bQyKWgtV8hcLkUi93+Af3EflSpKfVPQK1BA3K
 Ml2O1rtXMsIQF4z/0eJoZU4L2Rj5VepBA3wYJzIieo4t0aiyYeSHy1obxZBHaET6nJpx
 XiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775236628; x=1775841428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KubWgubVU2i3MNxPZ/XgyYvTy+oywhzqdxilSGQFGOM=;
 b=hPCaoXYygpWqBtg40QeKf0PKdRqDBVZjo0hmAW1h8w98vghiETFsl/I/Q7nf3qSLnw
 Jaao/AzS24TMwZGG5UhfpI+oulEGcdDI86TnV2p82GneL8jVs1mvdMUGwJhSVQGazEoZ
 KCwKJfCikQuhgLllWCc2+vdZnhJ0v/mxLXNIjn2GuoovQQWBz701YhhS8teYQMHFcHVk
 4jr2BXoTAHXBg+BlCjwVA6Mm0ViaJdNGfAX8+Ff+0d+MsEwiDkf7sRaN3vx9oLLaiZHi
 IMlYkyDx4llskWZliCmosnmVB+UsvPiQxgMV7nK3/T6iESyGZjqYiKz0/IeS9CFnxwgs
 QxBg==
X-Gm-Message-State: AOJu0Yy9paiP+24rqo72QyzrhR7H9vw2tBikLLS2M4gkxaUBw+fR4chO
 vL0pxxxxrT9PtHh8ipPZ3ojg5pIm4sxu1uTt9ZSmA9CG8iuPyEu6x6NUyNbqgbJTWqobu/7UBiq
 ZOmeEUNcI3b3jsI45ICtELqz/HO6v2w==
X-Gm-Gg: ATEYQzzzhpDIKIYQDetq+25Vv0bVyrsWA89jG43PL90E1KirWywHB8O+nWTwzWoAzCQ
 6YzP5JU+lRj/71pI22BDqLZ6EldMTs8Rzetu39Lr8PqKv12dKcLl/usVnbggVERSUYW/qGg841v
 vkppaGWIMuYH/IK2ec16ZdUNJbR668My8B7P+pkp4gWZpEpgRjswkz4n1wewKOE6mtzBG7Re+/9
 AOTAf2IoCzbB59UGt17MpO/rNhK+YGYQ+a5ZUcyPRA2OAvGszt28ttB2eZABfhm/bX/sdjvVUd0
 GhdzZ9KdoXivfUi4AizCuKf1uaSnxByEcdUNRnA=
X-Received: by 2002:a05:7022:ec14:b0:128:d4db:447a with SMTP id
 a92af1059eb24-12bfb765dd7mr1685046c88.29.1775236627994; Fri, 03 Apr 2026
 10:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260401093354.3608142-1-philip@philipmolloy.com>
In-Reply-To: <20260401093354.3608142-1-philip@philipmolloy.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Fri, 3 Apr 2026 13:16:20 -0400
X-Gm-Features: AQROBzBFZAtBLqBZt0jKnr5uzeBpc44JO-h8SmwcosStuZ3iRBLPEikx-ZlBJSw
Message-ID: <CABdDSeUpmDz9rxUmKrgwb3GBq+RLBfnJrxq-kWJdqbV4pedC0A@mail.gmail.com>
Subject: Re: [PATCH] board: adi: Fix exception when using standalone SoM
To: Philip Molloy <philip@philipmolloy.com>
Cc: u-boot@lists.denx.de, linux@analog.com, 
 Philip Molloy <philip.molloy@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Tom Rini <trini@konsulko.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
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

Hi Philip,

On Wed, Apr 1, 2026 at 5:32=E2=80=AFAM Philip Molloy <philip@philipmolloy.c=
om> wrote:
>
> From: Philip Molloy <philip.molloy@analog.com>
>
> Although less common, ADSP SoM boards can be operated standalone without
> a carrier board. The SoM can be powered over USB-C by moving the jumper
> on JP1.
>
> The board configuration needs to be heavily refactored to reduce the
> number of defconfigs and leverage the devicetree. The TI DP83867
> support, which is dependent on that configuration, needs to be removed.
> Until then this change allows the same U-Boot binary to work correctly
> both with carrier boards and the standalone SoM.
>
> The carrier board initialization code in somcrr_ezkit.c and
> somcrr_ezlite.c calls gpio_hog_lookup_name() to find ethernet
> control GPIOs, but does not check if the lookup succeeds before
> using the returned pointers.
>
> When running on a standalone SoM without a carrier board, these
> GPIO hogs do not exist in the device tree. The gpio_hog_lookup_name()
> function returns -ENODEV and sets the pointer to NULL, but the code
> continues to call dm_gpio_set_value() with uninitialized pointers,
> causing a synchronous abort exception:
>
>   "Synchronous Abort" handler, esr 0x96000004
>   elr: 00000000960326c4 lr : 0000000096038d5c (reloc)
>
> Signed-off-by: Philip Molloy <philip.molloy@analog.com>
> ---
>
>  board/adi/carriers/somcrr_ezkit.c  | 26 ++++++++++++--------------
>  board/adi/carriers/somcrr_ezlite.c |  8 ++++----
>  2 files changed, 16 insertions(+), 18 deletions(-)
>
> diff --git a/board/adi/carriers/somcrr_ezkit.c b/board/adi/carriers/somcr=
r_ezkit.c
> index 8b4d6a96c18..3cd5a6cd10b 100644
> --- a/board/adi/carriers/somcrr_ezkit.c
> +++ b/board/adi/carriers/somcrr_ezkit.c
> @@ -13,13 +13,12 @@ void adi_somcrr_enable_ethernet(void)
>         struct gpio_desc *eth1_reset;
>         struct gpio_desc *gige_reset;
>
> -       gpio_hog_lookup_name("eth1-en", &eth1);
> -       gpio_hog_lookup_name("eth1-reset", &eth1_reset);
> -       gpio_hog_lookup_name("gige-reset", &gige_reset);
> -
> -       dm_gpio_set_value(eth1, 1);
> -       dm_gpio_set_value(eth1_reset, 0);
> -       dm_gpio_set_value(gige_reset, 0);
> +       if (!gpio_hog_lookup_name("eth1-en", &eth1))
> +               dm_gpio_set_value(eth1, 1);
> +       if (!gpio_hog_lookup_name("eth1-reset", &eth1_reset))
> +               dm_gpio_set_value(eth1_reset, 0);
> +       if (!gpio_hog_lookup_name("gige-reset", &gige_reset))
> +               dm_gpio_set_value(gige_reset, 0);
>  }
>
>  void adi_somcrr_disable_ethernet(void)
> @@ -28,11 +27,10 @@ void adi_somcrr_disable_ethernet(void)
>         struct gpio_desc *eth1_reset;
>         struct gpio_desc *gige_reset;
>
> -       gpio_hog_lookup_name("eth1-en", &eth1);
> -       gpio_hog_lookup_name("eth1-reset", &eth1_reset);
> -       gpio_hog_lookup_name("gige-reset", &gige_reset);
> -
> -       dm_gpio_set_value(eth1, 0);
> -       dm_gpio_set_value(eth1_reset, 1);
> -       dm_gpio_set_value(gige_reset, 1);
> +       if (!gpio_hog_lookup_name("eth1-en", &eth1))
> +               dm_gpio_set_value(eth1, 0);
> +       if (!gpio_hog_lookup_name("eth1-reset", &eth1_reset))
> +               dm_gpio_set_value(eth1_reset, 1);
> +       if (!gpio_hog_lookup_name("gige-reset", &gige_reset))
> +               dm_gpio_set_value(gige_reset, 1);
>  }
> diff --git a/board/adi/carriers/somcrr_ezlite.c b/board/adi/carriers/somc=
rr_ezlite.c
> index c0655574bab..1f1984cf912 100644
> --- a/board/adi/carriers/somcrr_ezlite.c
> +++ b/board/adi/carriers/somcrr_ezlite.c
> @@ -11,14 +11,14 @@ void adi_somcrr_enable_ethernet(void)
>  {
>         struct gpio_desc *gige_reset;
>
> -       gpio_hog_lookup_name("eth0-reset", &gige_reset);
> -       dm_gpio_set_value(gige_reset, 0);
> +       if (!gpio_hog_lookup_name("eth0-reset", &gige_reset))
> +               dm_gpio_set_value(gige_reset, 0);
>  }
>
>  void adi_somcrr_disable_ethernet(void)
>  {
>         struct gpio_desc *gige_reset;
>
> -       gpio_hog_lookup_name("eth0-reset", &gige_reset);
> -       dm_gpio_set_value(gige_reset, 1);
> +       if (!gpio_hog_lookup_name("eth0-reset", &gige_reset))
> +               dm_gpio_set_value(gige_reset, 1);
>  }
> --
> 2.52.0
>
> base-commit: c704af3c8b0f37929bce8c2a4bba27d6e89919c7
> branch: som-eth-abort
>

Reviewed-by: Greg Malysa <malysagreg@gmail.com>

Thanks,
Greg
