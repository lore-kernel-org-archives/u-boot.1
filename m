Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F5FC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 06:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FC288843A;
	Mon, 26 Aug 2024 08:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KT9+nT8n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35B96884AC; Mon, 26 Aug 2024 08:27:13 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11251883C3
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 08:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-533461323cdso4410060e87.2
 for <u-boot@lists.denx.de>; Sun, 25 Aug 2024 23:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1724653630; x=1725258430;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O49GULQ1RBuCV3mQEjbflI9CcaxwJjbcRrrTowCZDqA=;
 b=KT9+nT8nOghlhnzhhRYggc/zUUOgiB/fwCgPPObmSSqDeWVM5Xxq3sjDhhGdDI7HJd
 BCEOYmbxVuF5m1nfaiaCnRWQEEKEHh8KxuLHgsGTIh1YDJrzunaf0/FnBG0eZc4fFBVo
 geJ3p8Njb6z6Ts6an6HW75ipG/u1bB3uP4Rng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724653630; x=1725258430;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O49GULQ1RBuCV3mQEjbflI9CcaxwJjbcRrrTowCZDqA=;
 b=AtZT+exJZvyPXnktf8kB1MWqRCf2SRHG6B8e7qarmNKPis51P0/h5KrzoOnI+0QSSd
 hn9VvCugVh+vnOc2ml/FObosX/5NDyGVQYybF9DE5bhdI/BIS6NdWNG/SBXCA4KLqFwh
 D6hSgH/TOu7JGS8/EmOzvV8xhUTLOojlY2/gKoydpAr6aA+nQ0QwYi+2MBG2J82VhrKx
 lxaI51+18ENdVzI2hrhHlsVDUGyQfUSdyFb+6IoxysHlg0BQbInwhkxaVt2i3kfrq9P7
 /hipbiW6vIdBOoAlJ5nh/abD50PUjb6vC4oRTZDJPxX0NXdwJHtRORp86Ol4spo8ax3+
 oLVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDnfkp24+nTOTlCZlYtcqhL9WvFNWVWmUbIsqZkwnLRL751XcsB12X8K/7CerbeZRH6aZDvAs=@lists.denx.de
X-Gm-Message-State: AOJu0YwF9UAI2QqalQH+bFr4JeFov8LV4HBRoTLgx0FYHqvgCCGSAOUR
 Vw60BthGppFKIMeoJAo0r0iTlLGehBA1Z2c1c473M7dlfefuKsE8W51hoEsw2Wy0SDzmWQqYW9C
 jOZFjrLoFVeIpTayV4HC12IA79iBX1CE3gPrSjg==
X-Google-Smtp-Source: AGHT+IGLZm8cpIXurtfd85+7V/VWH/yGKgxHrxhSBjQ+B0cw3qRJc/GEE2joGgaf9tN7H7F8APZaUm5kWlVaAJMXZtM=
X-Received: by 2002:a05:6512:3351:b0:534:3cdc:dbfe with SMTP id
 2adb3069b0e04-5343cdcddabmr3468345e87.28.1724653629740; Sun, 25 Aug 2024
 23:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240826060411.3532105-1-avkrasnov@salutedevices.com>
 <20240826060411.3532105-2-avkrasnov@salutedevices.com>
In-Reply-To: <20240826060411.3532105-2-avkrasnov@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 26 Aug 2024 08:26:58 +0200
Message-ID: <CAOf5uw=hQv4WUQuFgw7RsZSQYW1Az0_sUvO=_8kqOFdK945pUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mtd: rawnand: nand_base: support for
 'NAND_IS_BOOT_MEDIUM' flag
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, kernel@sberdevices.ru, oxffffaa@gmail.com
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

On Mon, Aug 26, 2024 at 8:17=E2=80=AFAM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> Based on Linux kernel:
> commit f922bd798bb9 ("mtd: rawnand: add an option to specify NAND chip as=
 a boot device")
>
> Allow to define a NAND chip as a boot device. This can be helpful
> for the selection of the ECC algorithm and strength in case the boot
> ROM supports only a subset of controller provided options.
>
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  Changelog:
>  v1 -> v2:
>   * Place 'NAND_IS_BOOT_MEDIUM' according its numerical value.
>
>  drivers/mtd/nand/raw/nand_base.c | 3 +++
>  include/linux/mtd/rawnand.h      | 5 +++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand=
_base.c
> index c40a0f23d7..ed605b4af5 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -4458,6 +4458,9 @@ static int nand_dt_init(struct mtd_info *mtd, struc=
t nand_chip *chip, ofnode nod
>         if (ret =3D=3D 16)
>                 chip->options |=3D NAND_BUSWIDTH_16;
>
> +       if (ofnode_read_bool(node, "nand-is-boot-medium"))
> +               chip->options |=3D NAND_IS_BOOT_MEDIUM;
> +
>         if (ofnode_read_bool(node, "nand-on-flash-bbt"))
>                 chip->bbt_options |=3D NAND_BBT_USE_FLASH;
>
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index fb002ae641..61690e816f 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -248,6 +248,11 @@ enum nand_ecc_algo {
>   * kmap'ed, vmalloc'ed highmem buffers being passed from upper layers
>   */
>  #define NAND_USE_BOUNCE_BUFFER 0x00100000
> +/*
> + * Whether the NAND chip is a boot medium. Drivers might use this inform=
ation
> + * to select ECC algorithms supported by the boot ROM or similar restric=
tions.
> + */
> +#define NAND_IS_BOOT_MEDIUM    0x00400000
>
>  /* Options set by nand scan */
>  /* bbt has already been read */
> --

I will then backport this from linux kernel
dd6ed5c9890b759ba1b56697b9f3f50e71909e43

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

> 2.30.1
>



--
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
