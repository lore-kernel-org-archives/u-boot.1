Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1FAC52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 14:39:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6AEF8896F;
	Thu,  8 Aug 2024 16:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="eZx3vvfB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2E63888D7; Thu,  8 Aug 2024 16:39:20 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C80688B79
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 16:39:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=moritzf@google.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fed726aefcso160475ad.1
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 07:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723127952; x=1723732752; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dcB49ZTamQQji9Qj4WBkPcFktW5dKQyTa9RA+V4eIqw=;
 b=eZx3vvfBtR04Pr8qGZiWMlvIQwtsUxy0gf67aKuqHEBwmR45+6AJQ6ikIkO/NAlohh
 TQiNlLtLLgC3WEYXA1v9IDxP+ECLMzfC7EXAJnquPkPdUIyF1gtPrL749t/WG9GX3ilV
 IEvJJNxeDbRwfI7nl5oeHL/Ob3eownCYlFKItFb+qmNK7/ZMyvcdRr5Sqo6L7x7iyL8S
 25tqwqCuwERDUXkKTxI9J8jp64844HA/4B/dEwPAcMGRK4seAqos0Zw60byffqBuNrQP
 bkx3Z1Zauie08NrAvv5lQ5/XfDY5VK4ePVjfivfK46lHWpYSRnmTW8HvrfYVmD/kha41
 X/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723127952; x=1723732752;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dcB49ZTamQQji9Qj4WBkPcFktW5dKQyTa9RA+V4eIqw=;
 b=KCTjz2YFL7BtDWj1aSYmliSn4beZ7EAedqnfM8Y7iTmD1S2yIzcAUnHMYsSYAtWMjj
 yFMIxl/uumjAQeGRLWdPaUVY1mfI7L67wZ8sSrv0v15Ddb43kX3832ModobFhK+HB+jS
 ZjL8lR2/SYbSGwPlMvv32O5hO9myE3CmcJYZ2XioJ6qRARKfkCOiGiFuhFP1iSix9Har
 ps4JpFLKmhK6cm7+KqxKauJ+gDmu0Vwms06Vd0/OJYvgR+sJ+26+JX7/FvEBdAjp56PJ
 m6JcILaica1HbthhMYhuJQvW1Pc3b9+Z2e0BM3PnNWPCeoT1cpoO1i17TujN8HjUpOrT
 pVwA==
X-Gm-Message-State: AOJu0YzTVV79PiuGYx7O2efALMjjn9gt2KC+/BVC4oXpKXQNjt6JKBa6
 hURLDVAvJ8rCmNOPvNthMUPqXe3LQOFBNbz/LGM+C/SyEbG/JGyUnMrvyQsvuH3llYpgSBqF4x3
 GdQfFG+jAMf3X9rVXwoxKwna8arYn4/2F7qL3
X-Google-Smtp-Source: AGHT+IGrR8m5DsKFaD6+OKF0sZ0IyFsSpwgmDaOotQhczbvWPNnOKF8LQkSanVRSgwB5y5VJWiPXDp9UM93Gi7fzKZY=
X-Received: by 2002:a17:902:db10:b0:200:8e1e:9940 with SMTP id
 d9443c01a7336-2009489a386mr2768545ad.23.1723127951045; Thu, 08 Aug 2024
 07:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
 <20240727071742.1735703-6-patrick.rudolph@9elements.com>
In-Reply-To: <20240727071742.1735703-6-patrick.rudolph@9elements.com>
From: Moritz Fischer <moritzf@google.com>
Date: Thu, 8 Aug 2024 07:38:59 -0700
Message-ID: <CAFyOScr7AgmOMCq2rGjiRM3sRCDZ8UZbfNG5Sq9JGoYy8aPtjw@mail.gmail.com>
Subject: Re: [PATCH 05/17] serial: serial_pl01x: Implement .getinfo() for PL01
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, mbrugger@suse.com, 
 pbrobinson@gmail.com, trini@konsulko.com, bmeng.cn@gmail.com, 
 Maximilian Brune <maximilian.brune@9elements.com>
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

On Sat, Jul 27, 2024 at 12:21=E2=80=AFAM Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> From: Maximilian Brune <maximilian.brune@9elements.com>
>
> When ACPI is enabled on arm it will use the getinfo function to fill
> the SPCR ACPI table.
>
> Signed-off-by: Maximilian Brune <maximilian.brune@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>

Reviewed-by: Moritz Fischer <moritzf@google.com>
> ---
>  boot/bootflow.c               |  8 ++++++--
>  drivers/serial/serial_pl01x.c | 24 ++++++++++++++++++++++++
>  include/serial.h              |  1 +
>  3 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/boot/bootflow.c b/boot/bootflow.c
> index 59d77d2385..d8807eb109 100644
> --- a/boot/bootflow.c
> +++ b/boot/bootflow.c
> @@ -936,11 +936,15 @@ int bootflow_cmdline_auto(struct bootflow *bflow, c=
onst char *arg)
>                 return ret;
>
>         *buf =3D '\0';
> -       if (!strcmp("earlycon", arg)) {
> +       if (!strcmp("earlycon", arg) && info.type =3D=3D SERIAL_CHIP_1655=
0_COMPATIBLE) {
>                 snprintf(buf, sizeof(buf),
>                          "uart8250,mmio32,%#lx,%dn8", info.addr,
>                          info.baudrate);
> -       } else if (!strcmp("console", arg)) {
> +       } else if (!strcmp("earlycon", arg) && info.type =3D=3D SERIAL_CH=
IP_PL01X) {
> +               snprintf(buf, sizeof(buf),
> +                        "pl011,mmio32,%#lx,%dn8", info.addr,
> +                        info.baudrate);
> +       } else if (!strcmp("console", arg) && info.type =3D=3D SERIAL_CHI=
P_16550_COMPATIBLE) {
>                 snprintf(buf, sizeof(buf),
>                          "ttyS0,%dn8", info.baudrate);
>         }
> diff --git a/drivers/serial/serial_pl01x.c b/drivers/serial/serial_pl01x.=
c
> index 80c35963b8..ab67922d18 100644
> --- a/drivers/serial/serial_pl01x.c
> +++ b/drivers/serial/serial_pl01x.c
> @@ -19,6 +19,7 @@
>  #include <watchdog.h>
>  #include <asm/io.h>
>  #include <serial.h>
> +#include <spl.h>
>  #include <dm/device_compat.h>
>  #include <dm/platform_data/serial_pl01x.h>
>  #include <linux/compiler.h>
> @@ -272,6 +273,28 @@ __weak struct serial_device *default_serial_console(=
void)
>         return &pl01x_serial_drv;
>  }
>  #else
> +
> +static int pl01x_serial_getinfo(struct udevice *dev,
> +                               struct serial_device_info *info)
> +{
> +       struct pl01x_serial_plat *plat =3D dev_get_plat(dev);
> +
> +       /* save code size */
> +       if (!spl_in_proper())
> +               return -ENOSYS;
> +
> +       info->type =3D SERIAL_CHIP_PL01X;
> +       info->addr_space =3D SERIAL_ADDRESS_SPACE_MEMORY;
> +       info->addr =3D plat->base;
> +       info->size =3D 0x1000;
> +       info->reg_width =3D 4;
> +       info->reg_shift =3D 2;
> +       info->reg_offset =3D 0;
> +       info->clock =3D plat->clock;
> +
> +       return 0;
> +}
> +
>  int pl01x_serial_setbrg(struct udevice *dev, int baudrate)
>  {
>         struct pl01x_serial_plat *plat =3D dev_get_plat(dev);
> @@ -341,6 +364,7 @@ static const struct dm_serial_ops pl01x_serial_ops =
=3D {
>         .pending =3D pl01x_serial_pending,
>         .getc =3D pl01x_serial_getc,
>         .setbrg =3D pl01x_serial_setbrg,
> +       .getinfo =3D pl01x_serial_getinfo,
>  };
>
>  #if CONFIG_IS_ENABLED(OF_REAL)
> diff --git a/include/serial.h b/include/serial.h
> index d129dc3253..d7a9a8cfb8 100644
> --- a/include/serial.h
> +++ b/include/serial.h
> @@ -124,6 +124,7 @@ enum serial_stop {
>  enum serial_chip_type {
>         SERIAL_CHIP_UNKNOWN =3D -1,
>         SERIAL_CHIP_16550_COMPATIBLE,
> +       SERIAL_CHIP_PL01X,
>  };
>
>  enum adr_space_type {
> --
> 2.45.2
>
