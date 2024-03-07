Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F29AC48BF6
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 10:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD41987E11;
	Thu,  7 Mar 2024 11:02:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ojcdWs1i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94E1787E49; Thu,  7 Mar 2024 11:02:50 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 613A3871C7
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 11:02:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-563c595f968so901153a12.0
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 02:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1709805767; x=1710410567;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=080Vp6b4rDjZRGOxHAmoaCkfZSw2GCkz/HXIK+MSKM0=;
 b=ojcdWs1iMJUyVZIlf9/6z4Ui3ZoKkCiVTZF+Y83EpBntUI/P6DD4ILIXaO0T88bN2B
 67hURVSMNjxM8yLhM+XmNwNfA7x5L5CBF/b/yMX6p2wYqq7ATJwdTa0J1pfiSiIyVI4W
 d+oE03yOdfbchoJ6iwv1jbfyqG5MzG5P89tiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709805767; x=1710410567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=080Vp6b4rDjZRGOxHAmoaCkfZSw2GCkz/HXIK+MSKM0=;
 b=NBNrqB9VOhV9LzOppkxT+eiHkeFA5NVBM3eYFmoBFSbCOHIDbGPc/PzWJNNttqc7bO
 vF2LkGizpYdkwUlRC7GMBhcQ4bZwHHEOiCk4szVSDj+6dpO1FbLoNMbvNf+8HyUtfifV
 MNa1K3wdTu/kBknrvJNCRIXoHhllSFJL6mgdQbcx/4a9ykF3ZvNhn0hSMn1fC5Y2c8Tl
 zXJ5GrkUVoHeVkNs7zDwAL/8xCf3vBpLMeqVBr53avc5GLXIQRx493hHcg8XBjk+IR1x
 dfgn019puNZJKUq7DT/h0QdwFXLnWeCCSvwZfzqT2At6SRPYhtjhpOmFAzk8jZL01Djv
 fIyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJqp+O582KXpDvpwxXuOsmn38eZfMkAvHv905QQznEvl3wzSzgUxFmi34qgYM4jZSLQd7HXcV5gGNVZQyBG+mNFfzW9w==
X-Gm-Message-State: AOJu0YxOnmEhLGGbrl2vZh2H4Kr5eYqjdG3aYwEiR28VrhONaf8DNwoG
 9ImSTR0eA4Y46agXlLlhCFSdV7MIIYCgtJJoMkFgaWniIIBgF+kyeQobiXbvOgekXDHlOSsYwlC
 S245jWseIp3ECPrMCneICTYhBGoeoKDiqbX+6lA==
X-Google-Smtp-Source: AGHT+IHx+VaV/oSQywOncDqda7HYGZaGREdyRBSAZ6F5b8UcJj3fB777TbYx2WfLdeuN6bm3g/V16QOO8M0b9LwC+E0=
X-Received: by 2002:a17:907:bb8d:b0:a45:b614:8640 with SMTP id
 xo13-20020a170907bb8d00b00a45b6148640mr3363995ejc.8.1709805766781; Thu, 07
 Mar 2024 02:02:46 -0800 (PST)
MIME-Version: 1.0
References: <20240307091014.39796-1-ada@thorsis.com>
 <20240307091014.39796-3-ada@thorsis.com>
In-Reply-To: <20240307091014.39796-3-ada@thorsis.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 7 Mar 2024 11:02:36 +0100
Message-ID: <CAOf5uwmjQgKjGYi2D8LRrLsXLDO0TkMJzBDrOJF942g=QOrSBQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] mtd: nand: raw: Port another option flag from Linux
To: Alexander Dahl <ada@thorsis.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>, u-boot@lists.denx.de
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

Hi

On Thu, Mar 7, 2024 at 10:10=E2=80=AFAM Alexander Dahl <ada@thorsis.com> wr=
ote:
>
> Introduced in upstream Linux with commit 7a08dbaedd365 for release v5.0.
>
> When the new atmel nand driver was backported to U-Boot with commit
> 6a8dfd57220d ("nand: atmel: Add DM based NAND driver") that definition
> was added to the driver instead of the header file.  Move it over to the
> other definitions with the same help text it has in Linux.
>
> Code actually using this has not been ported over to raw nand base yet.
>
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 2 --
>  include/linux/mtd/rawnand.h                  | 7 +++++++
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/n=
and/raw/atmel/nand-controller.c
> index 0e0441472b8..e06523f3298 100644
> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> @@ -1429,8 +1429,6 @@ static int atmel_nand_setup_data_interface(struct m=
td_info *mtd, int csline,
>         return nc->caps->ops->setup_data_interface(nand, csline, conf);
>  }
>
> -#define NAND_KEEP_TIMINGS       0x00800000
> -
>  static void atmel_nand_init(struct atmel_nand_controller *nc,
>                             struct atmel_nand *nand)
>  {
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index fb002ae6411..4abaf4734cf 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -249,6 +249,13 @@ enum nand_ecc_algo {
>   */
>  #define NAND_USE_BOUNCE_BUFFER 0x00100000
>
> +/*
> + * Do not try to tweak the timings at runtime. This is needed when the
> + * controller initializes the timings on itself or when it relies on
> + * configuration done by the bootloader.
> + */
> +#define NAND_KEEP_TIMINGS      0x00800000
> +
>  /* Options set by nand scan */
>  /* bbt has already been read */
>  #define NAND_BBT_SCANNED       0x40000000

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

> --
> 2.39.2
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
