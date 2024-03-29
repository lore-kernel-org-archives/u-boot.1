Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29890CD1284
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 00:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FB46880E8;
	Fri, 29 Mar 2024 01:46:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="dIdHTvlr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 526AA88150; Fri, 29 Mar 2024 01:46:53 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6983187ECD
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 01:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-60a434ea806so17123587b3.3
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 17:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1711673209; x=1712278009;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dev+6bwEAhNHZU3TM4aVRaTR5zYwVMTAOyBFowUzSWQ=;
 b=dIdHTvlrbaHEQdzLYHXhwlgIrLu8QOzqWWCvARjPTmTlmt3R3g3erOyWrRfeXRxLTs
 mmmkfDlHSI/AW2C0CPOeV39WVBbZqxbpndB+syaOsqlh+hJXsI0mI8cshrOhknMPfIGt
 W4nFQbQmiA5rsu7oDo1EsN/5YYCcNsIzUk71zg6o734e6nkVBL0T71e6ffDUPaAkiCTP
 ZRRz1iXIIs3pQowtmyDof0AGsKLpB6xNkA/1bbY/XG5grBJrXAA7nBeH9gWyqhr9FJya
 70NK7vW9ZMBiKH6dt2ie3HnmjEx1WgENeWRKgKlbDnTGTSYNSMNjAnp9tL3k7LQhzJD7
 tjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711673209; x=1712278009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dev+6bwEAhNHZU3TM4aVRaTR5zYwVMTAOyBFowUzSWQ=;
 b=NODsallA2wCe8ifIoRQZ5RhQO9sfiyaByGVYuz3BbXPA2+YQkeQ/WBrFBsuoL+puHx
 z0+xQ+Yf8GXD9ntsGjXmMeOwjphS8yqvTVYmw9Oi3nd9ASwNlR4m7xHQVl/MUAjXFWry
 lN8yLa7iVNAxjul6kChwydc3onrtpRDvqRehwCTb2ZieKtY/iIhHBYY39na7OCHxvTKi
 9uYyPCtuQp0Peph4gHuq32xyryz5X2vwXKOJ89vlnP1N9LvAfLp7pblCkgFluuqvklQW
 e2zDhyTdEb1pjs7mDp2j339Zs7DHGE51FOpN6reP04jtEjDX5Qb1TW11cKTmqUjlzJz7
 AnkA==
X-Gm-Message-State: AOJu0YxFPFHT0dLv5UszG4zENlCgiHRwc0drP5UKy/o+quBBSQSvBdnS
 vEfC8GbmTsDMRhhDq4sYQFDZK6VjcFDv0El8i1v52F+L5QtGrXgJDAXWeqNzG0d9SxURvpTDQux
 wKcNa6bvnxI0sgMcEYXpSYY6ffAve5d4l+y4sY3AvxZ7mCfEbbQ==
X-Google-Smtp-Source: AGHT+IE0wpJs3Wj2b/BXy7PNcorQS/qi0J282RBLPE2zdkMpvY6+16UbGfN8Q0BcZx1S1cac9vkcmXzyf5+UVp+N/iQ=
X-Received: by 2002:a81:6d8a:0:b0:60a:1065:2384 with SMTP id
 i132-20020a816d8a000000b0060a10652384mr1163960ywc.22.1711673209036; Thu, 28
 Mar 2024 17:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240328153727.2939697-1-tejas.arvind.bhumkar@amd.com>
In-Reply-To: <20240328153727.2939697-1-tejas.arvind.bhumkar@amd.com>
From: Greg Malysa <greg.malysa@timesys.com>
Date: Thu, 28 Mar 2024 20:44:37 -0400
Message-ID: <CAAjXUapPXFRhz0sbrMm_mrF-iaSbXa9ihv0xZ45W2AcA_3eziA@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: Add support to exit 4-byte mode
To: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Cc: u-boot@lists.denx.de, jagan@amarulasolutions.com, vigneshr@ti.com, 
 michal.simek@amd.com, venkatesh.abbarapu@amd.com, git@amd.com, 
 Ian Roberts <ian.roberts@timesys.com>
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

Hi Tejas,

+ Ian Roberts, my coworker has the following comments:

I do not think it is appropriate to put what appears to be use-case
specific logic into the core functionality.

Your problem statement sounds like the chip is stuck in a stateful
mode after a reset. As alternatives, I would suggest:
1) Toggle the hardware reset line for the chip.
2) If one does not exist, use SPI_FLASH_SOFT_RESET_ON_BOOT
3) Alter your recovery application set the chip back to 3B mode on exit.

As is, I also think this would cause problems for chips with existing
support. set_4byte() sends commands to the chip, which may be
unrecognized or overlap with a manufacturer's custom command and cause
unintended side effects.

On Thu, Mar 28, 2024 at 11:37=E2=80=AFAM Tejas Bhumkar
<tejas.arvind.bhumkar@amd.com> wrote:
>
> The Kria board features a recovery application that activates
> when the FW_EN button is pressed.
> Upon power-up flash operates in 3B mode, However, the recovery
> application changes it back to 4B mode.
> Following a reset, u-boot activates the CONFIG_SPI_FLASH_BAR
> and expects the flash to be in 3B mode. However, there's no
> code to handle this configuration. to address this issue, changes
> were made to disable the 4B mode when the CONFIG_SPI_FLASH_BAR
> is enabled.
>
> Additionally, spi_nor_wait_till_ready() was included because there is
> operation that places the device in a busy state before performing
> a nor read.
>
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> ---
>  drivers/mtd/spi/spi-nor-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-cor=
e.c
> index f86003ca8c..47f65a4f5e 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -1464,6 +1464,9 @@ static int spi_nor_read(struct mtd_info *mtd, loff_=
t from, size_t len,
>                 else
>                         read_len =3D remain_len;
>  #endif
> +               ret =3D spi_nor_wait_till_ready(nor);
> +               if (ret)
> +                       goto read_err;

Can you elaborate on the purpose of this wait_till_ready?

>
>                 ret =3D nor->read(nor, addr, read_len, buf);
>                 if (ret =3D=3D 0) {
> @@ -4161,6 +4164,7 @@ int spi_nor_scan(struct spi_nor *nor)
>  #else
>         /* Configure the BAR - discover bank cmds and read current bank *=
/
>         nor->addr_width =3D 3;
> +       set_4byte(nor, info, 0);
>         ret =3D read_bar(nor, info);
>         if (ret < 0)
>                 return ret;
> --
> 2.37.6
>

Thanks,
Greg

--=20
Greg Malysa
Timesys Corporation
