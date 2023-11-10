Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B0AC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 18:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 124B3877D8;
	Fri, 10 Nov 2023 19:29:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FGdLWzzz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73DB98783F; Fri, 10 Nov 2023 19:29:47 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E9808761C
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 19:29:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5a9bf4fbd3fso1861136a12.1
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 10:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699640981; x=1700245781; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zIQTIIJ9gi/F0OIMrrUllGjupqr83/virVpjzYOlJWE=;
 b=FGdLWzzzTd14F+QG7g1PQUJDJk5UJejTF7WyMOGqRlsbNfVVkTMHzo5GIy75ziidHr
 fMDFubN88GkXgKdxBYmwtfcwidoi6KJ3NPRQVk1tsqMWNF2LzJGzhCX3/Zmyrw6dxZlv
 EclNxLw4DQ5hDbqvHVdFlugiu8bPi+MyNvU2d80fCFpx69cPEUKzWtfXQAJwFq416zcV
 s6UMpmDwo+0Fgo49nsbRHuWJBMVMQwGyFGzwwMezZHmnxXoP85DytSSZkkiIm0M3mXoO
 71bmbFbv2mgyyIAa3fJsp1ezR2FfE0VglU8vggRQctsrvtsBF4eOthcN3RDJswJF6In0
 XHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699640981; x=1700245781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zIQTIIJ9gi/F0OIMrrUllGjupqr83/virVpjzYOlJWE=;
 b=VE1VQ4mNbGFosFY8+JvJJz+QKRGmjMYM5s72kW7iio93rCpdJFSld0G0F7GwTBTf6r
 OG3BOp04v3UJECvdVff+cp3XzY795qnw1gvFGbPCj+kdxRQCk6qldrbeSxjjZTpNRVMK
 i1Tpi2znoQw+td5lAJrw0ZQ//BAWlhuiKJNUuptzsZzyTnVXbKAPt7qjtj20v9N0vjSL
 RYdho4sDb4c90LWIB+93ISWlAzpZiPVy4zmefYJzo/IeSviYehIJHGOhDWBk/KQPhdw3
 PEh9jt5E1yCTrWMfloRuqejFWZ6CZQ74wMAWrl5f+qMfNu5myBCWwBSHmAQ+Gup3y+vO
 T+cw==
X-Gm-Message-State: AOJu0YwBgT/c8QgUHRV3a4odfd1jGwB+JY+Dst8n8iyfYKUoUk8bmQ1N
 JX0i/fi5QPlsBlnyN8TDFdUrYdaYhgVVxPxycAzxgUtGTbKD6VxKVIQ=
X-Google-Smtp-Source: AGHT+IFta0SKPNn/X9AVfzdHYyv/Wpnx7nVuNz7LE6wjBSzGi3X2QJ10RFOiyYVmOZfv3z7XXT42TaHXMd6DRD05sek=
X-Received: by 2002:a17:90a:3181:b0:280:18bd:ffe7 with SMTP id
 j1-20020a17090a318100b0028018bdffe7mr5019662pjb.48.1699640981554; Fri, 10 Nov
 2023 10:29:41 -0800 (PST)
MIME-Version: 1.0
References: <20231107190601.17151-1-semen.protsenko@linaro.org>
 <20231107190601.17151-3-semen.protsenko@linaro.org>
 <CAPnjgZ2ae9UPanroXZLeNaB6bGN9hBczZcZSEEv=5t6Uz9WWQw@mail.gmail.com>
In-Reply-To: <CAPnjgZ2ae9UPanroXZLeNaB6bGN9hBczZcZSEEv=5t6Uz9WWQw@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 10 Nov 2023 12:29:30 -0600
Message-ID: <CAPLW+4mtbbEZmQtik_qEtmo0Ehr7R=-yZOO8xVL2Dp0rCCHZ4Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] serial: s5p: Use livetree API to get "id" property
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>,
 u-boot@lists.denx.de
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

Hi Simon,

On Tue, Nov 7, 2023 at 10:26=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Sam,
>
> On Tue, 7 Nov 2023 at 12:06, Sam Protsenko <semen.protsenko@linaro.org> w=
rote:
> >
> > Use dev_read_u8_default() instead of fdtdec_get_int() to read the "id"
> > property from device tree, as suggested in [1]. dev_* API is already
> > used in this driver, so there is no reason to stick to fdtdec_* API.
> > This also fixes checkpatch warning:
> >
> >     WARNING: Use the livetree API (dev_read_...)
> >
> > [1] doc/develop/driver-model/livetree.rst
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  drivers/serial/serial_s5p.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/drivers/serial/serial_s5p.c b/drivers/serial/serial_s5p.c
> > index 177215535676..c57bdd059ea6 100644
> > --- a/drivers/serial/serial_s5p.c
> > +++ b/drivers/serial/serial_s5p.c
> > @@ -20,8 +20,6 @@
> >  #include <serial.h>
> >  #include <clk.h>
> >
> > -DECLARE_GLOBAL_DATA_PTR;
> > -
> >  enum {
> >         PORT_S5P =3D 0,
> >         PORT_S5L
> > @@ -220,8 +218,7 @@ static int s5p_serial_of_to_plat(struct udevice *de=
v)
> >
> >         plat->reg =3D (struct s5p_uart *)addr;
> >         plat->reg_width =3D dev_read_u32_default(dev, "reg-io-width", 1=
);
> > -       plat->port_id =3D fdtdec_get_int(gd->fdt_blob, dev_of_offset(de=
v),
> > -                                       "id", dev_seq(dev));
> > +       plat->port_id =3D dev_read_u8_default(dev, "id", dev_seq(dev));
> >
> >         if (port_type =3D=3D PORT_S5L) {
> >                 plat->rx_fifo_count_shift =3D S5L_RX_FIFO_COUNT_SHIFT;
> > --
> > 2.39.2
> >
>
> Really this property should not be needed anymore. Can you figure out
> how to drop it?
>

The 'port_id' seems to be needed for ARCH_EXYNOS4 boards. Because
Exynos4 doesn't have proper DM clocks, it uses 'id' property to get
corresponding UART clock frequency from its mach code.

Here is what's happening in the serial driver in case of Exynos4:

  1. get_uart_clk(port_id) is called
  2. which in turn calls exynos4_get_uart_clk(port_id)
  3. which uses "port_id" value to read corresponding bits of of
CLK_SRC_PERIL0 register
  4. those bits are used to get corresponding PLL clock's frequency
  5. which is in turn used to calculate UART clock rate
  6. calculated rate is returned by get_uart_clk() to serial driver

So I don't see any *easy* way we can get rid of that id property.

The proper way of doing that would require converting Exynos4 clock
code to CCF (enabling CONFIG_CLK_EXYNOS). Which of course also means
implementing clocks in dts, akin to kernel's exynos4.dtsi. Then it'll
be possible to get rid of 'id' property.

Maybe I'm missing something, please let me know.

Thanks!

> Regards,
> Simon
