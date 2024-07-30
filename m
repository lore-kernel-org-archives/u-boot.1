Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FC6C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 12:41:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC53088607;
	Tue, 30 Jul 2024 14:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O9brLTxE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07061887E4; Tue, 30 Jul 2024 14:41:20 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAD9787F51
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 14:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fedorross@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-58f9874aeb4so6025958a12.0
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 05:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722343277; x=1722948077; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iPzDj9+UfkAxw2I4Eap1Tey9twKjFMDEmkxJOrCGAHY=;
 b=O9brLTxE8WQfBt1GPp1Kq+D2CzPIYeYITD2a/tdDsbAiTir7o5vEepG3lsPfKHLxJS
 YJ79u3lUIrveNWHIJ6mz2YYRrNPWEHeVoxD3Ozd13U8krfyvvhH2BShAXvyvf2jVOS2I
 deA5mAkkETd5yi1eQcsYG3Ryyf6e3RfqvK3g+IqBRBqpGpIoId3m278QetXCYZjfLsv0
 iOB/lGjcaJQBrTl9UOtb7SFfrdYhs9rJ/xDy/l98KsVS3ZJl+hPufp2052lm+mlhczl7
 RnYqC+BJGazXlDonSZcYt2LwMVhyKle3y3Wko75a/aWV2flFsTXQpe9Z5oNIeJ8hZcMP
 p+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722343277; x=1722948077;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iPzDj9+UfkAxw2I4Eap1Tey9twKjFMDEmkxJOrCGAHY=;
 b=bzPS3kcreixtyNVtV73Q/aPZshkTSoC2qtFxvVtM7rRLOK/Rb3yQsy8ay6t4ctx5Hh
 EfP2ZyGkolegg+p+UF0coOgBTSZjH1llDz1EjMSquRLdA+LrnO2cF9WNC+83TggY8m3K
 /2vsSDk2ppRDndJsviSx/rdRgWktbqZIW8nF7W4Ah7eXdwcr/PPYY6POKkhqO7awG/Rh
 cp8DRvQUrraOxxWs+dKdqjVwH1zVD3hhqK+ZXoxtUZhq/RxOrNYoFuPv0Em8ciCx1Jmu
 I6RFso4TB5f2wXpVWBjDxDPkflCT4bzgTC0clrSZPxIBEaFgHL+f3+4658PtZ7Vx0wY2
 FmVg==
X-Gm-Message-State: AOJu0Yznwkh2ptA1WhE+tnQQoWyPAcc3384XnFrCpKv9iLc+RmQKNAvq
 R6FmVWPM+K77vXyeFmD5KJGIivq6eRP2nmkrYF/g0rzFRgPyxvWqozq2z/yHLRa9fdv7FjKHtIV
 K7XObBevW6wMtDWwGj/fsMmXmh+c=
X-Google-Smtp-Source: AGHT+IGpYlgKWyy16zh8FTIv6RgaAU2p0H5wgXW+u+ueJmfoJ83Ka1Qm5EHGztuU195LW7mlG0xH5KjXDCeEw5dDWeo=
X-Received: by 2002:a17:907:3da2:b0:a7a:84f8:eaef with SMTP id
 a640c23a62f3a-a7d400ae27dmr932372266b.35.1722343277117; Tue, 30 Jul 2024
 05:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240724095943.214967-1-fedor.ross@ifm.com>
 <20240724095943.214967-3-fedor.ross@ifm.com>
 <4c4bbfdc-1a35-4445-8039-8693020b1658@denx.de>
In-Reply-To: <4c4bbfdc-1a35-4445-8039-8693020b1658@denx.de>
From: Fedor Ross <fedorross@gmail.com>
Date: Tue, 30 Jul 2024 14:41:06 +0200
Message-ID: <CAEGWRBCQr0Ky63esy9_Bc2TPhiDfe_ktOmt8GwKmkRbpJHJ-6w@mail.gmail.com>
Subject: Re: [PATCH 3/3] i2c: imx_lpi2c: Support read transfers longer than
 256 bytes
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Fedor Ross <fedor.ross@ifm.com>,
 Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>
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

On Wed, Jul 24, 2024 at 12:57=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:

Hello Marek,

I'll do the changes. Thanks for your input.

Best regards,
Fedor

> On 7/24/24 11:59 AM, fedorross@gmail.com wrote:
> > From: Fedor Ross <fedor.ross@ifm.com>
> >
> > The TXFIFO register of LPI2C only has one byte length, and if the lengt=
h
> > of the data that needs to be read exceeds 256 bytes, it needs to be
> > written to TXFIFO multiple times.
> >
> > Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
>
> Add ---
>
> > Cc: Heiko Schocher <hs@denx.de>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Marek Vasut <marex@denx.de>
> > ---
> >   drivers/i2c/imx_lpi2c.c | 72 +++++++++++++++++++++++++++-------------=
-
> >   1 file changed, 47 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/i2c/imx_lpi2c.c b/drivers/i2c/imx_lpi2c.c
> > index 7b10b2b252d..dd97228ddc7 100644
> > --- a/drivers/i2c/imx_lpi2c.c
> > +++ b/drivers/i2c/imx_lpi2c.c
> > @@ -19,6 +19,8 @@
> >   #define LPI2C_NACK_TOUT_MS 1
> >   #define LPI2C_TIMEOUT_MS 100
> >
> > +#define CHUNK_DATA      256
>
> Use LPI2C_CHUNK_DATA to namespace this macro.
>
> >   static int bus_i2c_init(struct udevice *bus, int speed);
> >
> >   /* Weak linked function for overridden by some SoC power function */
> > @@ -118,8 +120,10 @@ static int bus_i2c_send(struct udevice *bus, u8 *t=
xbuf, int len)
> >
> >   static int bus_i2c_receive(struct udevice *bus, u8 *rxbuf, int len)
> >   {
> > +     struct dm_i2c_bus *i2c =3D dev_get_uclass_priv(bus);
> >       struct imx_lpi2c_bus *i2c_bus =3D dev_get_priv(bus);
> >       struct imx_lpi2c_reg *regs =3D (struct imx_lpi2c_reg *)(i2c_bus->=
base);
> > +     unsigned int chunk_len, rx_remain, timeout;
> >       lpi2c_status_t result =3D LPI2C_SUCESS;
> >       u32 val;
> >       ulong start_time =3D get_timer(0);
> > @@ -128,33 +132,51 @@ static int bus_i2c_receive(struct udevice *bus, u=
8 *rxbuf, int len)
> >       if (!len)
> >               return result;
> >
> > -     result =3D bus_i2c_wait_for_tx_ready(regs);
> > -     if (result) {
> > -             debug("i2c: receive wait for tx ready: %d\n", result);
> > -             return result;
> > -     }
> > +     /*
> > +      * Extend the timeout for a bulk read if needed.
> > +      * The calculated timeout is the result of multiplying the
> > +      * transfer length with 8 bit + ACK + one clock of extra time,
> > +      * considering the I2C bus frequency.
> > +      */
> > +     timeout =3D max(len * 10 * 1000 / i2c->speed_hz, LPI2C_TIMEOUT_MS=
);
> >
> > -     /* clear all status flags */
> > -     writel(0x7f00, &regs->msr);
> > -     /* send receive command */
> > -     val =3D LPI2C_MTDR_CMD(0x1) | LPI2C_MTDR_DATA(len - 1);
> > -     writel(val, &regs->mtdr);
> > +     rx_remain =3D len;
> > +     while (rx_remain > 0) {
> > +             chunk_len =3D clamp(rx_remain, 1, CHUNK_DATA) - 1;
> >
> > -     while (len--) {
> > -             do {
> > -                     result =3D imx_lpci2c_check_clear_error(regs);
> > -                     if (result) {
> > -                             debug("i2c: receive check clear error: %d=
\n",
> > -                                   result);
> > -                             return result;
> > -                     }
> > -                     if (get_timer(start_time) > LPI2C_TIMEOUT_MS) {
> > -                             debug("i2c: receive mrdr: timeout\n");
> > -                             return -1;
> > -                     }
> > -                     val =3D readl(&regs->mrdr);
> > -             } while (val & LPI2C_MRDR_RXEMPTY_MASK);
> > -             *rxbuf++ =3D LPI2C_MRDR_DATA(val);
> > +             result =3D bus_i2c_wait_for_tx_ready(regs);
> > +             if (result) {
> > +                     debug("i2c: receive wait for tx ready: %d\n", res=
ult);
> > +                     return result;
> > +             }
> > +
> > +             /* clear all status flags */
> > +             writel(0x7f00, &regs->msr);
> > +             /* send receive command */
> > +             val =3D LPI2C_MTDR_CMD(0x1) | LPI2C_MTDR_DATA(chunk_len);
> > +             writel(val, &regs->mtdr);
>
> writel(LPI2C_MTDR_CMD(0x1) | LPI2C_MTDR_DATA(chunk_len);, &regs->mtdr);
>
> and drop the val =3D assignment here.
>
> > +             rx_remain =3D rx_remain - (chunk_len & 0xff) - 1;
> > +
> > +             while (len--) {
> > +                     do {
> > +                             result =3D imx_lpci2c_check_clear_error(r=
egs);
> > +                             if (result) {
> > +                                     debug("i2c: receive check clear e=
rror: %d\n",
> > +                                           result);
> > +                                     return result;
> > +                             }
> > +                             if (get_timer(start_time) > timeout) {
> > +                                     debug("i2c: receive mrdr: timeout=
\n");
> > +                                     return -1;
> > +                             }
> > +                             val =3D readl(&regs->mrdr);
> > +                     } while (val & LPI2C_MRDR_RXEMPTY_MASK);
> > +                     *rxbuf++ =3D LPI2C_MRDR_DATA(val);
> > +
> > +                     /* send next receive command before controller NA=
CKs last byte */
> > +                     if ((len - rx_remain) < 2 && rx_remain > 0)
> > +                             break;
> > +             }
> >       }
