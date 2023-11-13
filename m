Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4D8C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 18:01:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42D348714E;
	Mon, 13 Nov 2023 19:01:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OYKbWVxT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81C4E86940; Mon, 13 Nov 2023 19:01:46 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AA87864F3
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 19:01:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5bf58914bacso51686277b3.3
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 10:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699898503; x=1700503303; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kd713YPOcGiL3SsyYHBrE04SBPrHy+vBTj8mLlSVB/I=;
 b=OYKbWVxT0XUHj5SSnAxqJCASxWGUMSh0i/W2170nMC6jiC3Bo1JbJeiP3jQEmDfjId
 NMuuMtcC0WrtGapiLu5yHiXwrKwS7I3CnoFs4qL3n/zQeKA6OjGt85MdLcbJOL7rgOmK
 b1SafCgIalguLJaU2WOb10DjjmMGtT+78oOr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699898503; x=1700503303;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kd713YPOcGiL3SsyYHBrE04SBPrHy+vBTj8mLlSVB/I=;
 b=g/Wr5W7PgTFf26YxAMNy+fd5A7pKfTUzaYG/RPeWXMWwpt/R9fc8Jea6KRme3wTH52
 ith1P6nzL+ZssYIoIGwiJL0Xut5yc01rG2wJ4feZ6UE3vFKAfJQClYyvVYW0Kd8gtb60
 2ZBHigWWXOpKHuKKU3uZ1uEnYRjAc1gazmfmqk+hGIFN+EZklnT+kMKnNL47PgZXl706
 gdDYTln/yoO47knfJOEdygzAxCV7BZyAptLpg/4f4H1raM+Vn8IMHHHka7+1hxWT5Cqe
 ZRrN9680M0vgMXrLhqq12BfzPj8TBco94mYOdgx7DoUy9UYAKZYm0dTdEv0aW9n1rWPY
 MK9A==
X-Gm-Message-State: AOJu0Yyql/1L0v3ZWWsMDk1YFU+KofEs7YeRloEp1fRtuxLFegXByEKw
 RVi4QT35fwPp96id7+4uEYn+QiNeMwf/l1mYroKGjQ==
X-Google-Smtp-Source: AGHT+IHBjbnsSxOGqiwACFTtuNko3BojMojTX0DaEH7Uc1DpjLzBfIAEkaZ7qFfthueqJgJPBEM8dBUpa1036bkZWFs=
X-Received: by 2002:a05:690c:2a89:b0:5c1:c4b:208 with SMTP id
 ek9-20020a05690c2a8900b005c10c4b0208mr6485283ywb.24.1699898502725; Mon, 13
 Nov 2023 10:01:42 -0800 (PST)
MIME-Version: 1.0
References: <20231107190601.17151-1-semen.protsenko@linaro.org>
 <20231107190601.17151-3-semen.protsenko@linaro.org>
 <CAPnjgZ2ae9UPanroXZLeNaB6bGN9hBczZcZSEEv=5t6Uz9WWQw@mail.gmail.com>
 <CAPLW+4mtbbEZmQtik_qEtmo0Ehr7R=-yZOO8xVL2Dp0rCCHZ4Q@mail.gmail.com>
In-Reply-To: <CAPLW+4mtbbEZmQtik_qEtmo0Ehr7R=-yZOO8xVL2Dp0rCCHZ4Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Nov 2023 11:01:21 -0700
Message-ID: <CAPnjgZ2JCa0qB539w0WZ9Ur1mMuYON1_vk+kwSEraBLK8dpkaQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] serial: s5p: Use livetree API to get "id" property
To: Sam Protsenko <semen.protsenko@linaro.org>
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

Hi Sam,

On Fri, 10 Nov 2023 at 11:29, Sam Protsenko <semen.protsenko@linaro.org> wr=
ote:
>
> Hi Simon,
>
> On Tue, Nov 7, 2023 at 10:26=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Sam,
> >
> > On Tue, 7 Nov 2023 at 12:06, Sam Protsenko <semen.protsenko@linaro.org>=
 wrote:
> > >
> > > Use dev_read_u8_default() instead of fdtdec_get_int() to read the "id=
"
> > > property from device tree, as suggested in [1]. dev_* API is already
> > > used in this driver, so there is no reason to stick to fdtdec_* API.
> > > This also fixes checkpatch warning:
> > >
> > >     WARNING: Use the livetree API (dev_read_...)
> > >
> > > [1] doc/develop/driver-model/livetree.rst
> > >
> > > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > > ---
> > >  drivers/serial/serial_s5p.c | 5 +----
> > >  1 file changed, 1 insertion(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/serial/serial_s5p.c b/drivers/serial/serial_s5p.=
c
> > > index 177215535676..c57bdd059ea6 100644
> > > --- a/drivers/serial/serial_s5p.c
> > > +++ b/drivers/serial/serial_s5p.c
> > > @@ -20,8 +20,6 @@
> > >  #include <serial.h>
> > >  #include <clk.h>
> > >
> > > -DECLARE_GLOBAL_DATA_PTR;
> > > -
> > >  enum {
> > >         PORT_S5P =3D 0,
> > >         PORT_S5L
> > > @@ -220,8 +218,7 @@ static int s5p_serial_of_to_plat(struct udevice *=
dev)
> > >
> > >         plat->reg =3D (struct s5p_uart *)addr;
> > >         plat->reg_width =3D dev_read_u32_default(dev, "reg-io-width",=
 1);
> > > -       plat->port_id =3D fdtdec_get_int(gd->fdt_blob, dev_of_offset(=
dev),
> > > -                                       "id", dev_seq(dev));
> > > +       plat->port_id =3D dev_read_u8_default(dev, "id", dev_seq(dev)=
);
> > >
> > >         if (port_type =3D=3D PORT_S5L) {
> > >                 plat->rx_fifo_count_shift =3D S5L_RX_FIFO_COUNT_SHIFT=
;
> > > --
> > > 2.39.2
> > >
> >
> > Really this property should not be needed anymore. Can you figure out
> > how to drop it?
> >
>
> The 'port_id' seems to be needed for ARCH_EXYNOS4 boards. Because
> Exynos4 doesn't have proper DM clocks, it uses 'id' property to get
> corresponding UART clock frequency from its mach code.
>
> Here is what's happening in the serial driver in case of Exynos4:
>
>   1. get_uart_clk(port_id) is called
>   2. which in turn calls exynos4_get_uart_clk(port_id)
>   3. which uses "port_id" value to read corresponding bits of of
> CLK_SRC_PERIL0 register
>   4. those bits are used to get corresponding PLL clock's frequency
>   5. which is in turn used to calculate UART clock rate
>   6. calculated rate is returned by get_uart_clk() to serial driver
>
> So I don't see any *easy* way we can get rid of that id property.
>
> The proper way of doing that would require converting Exynos4 clock
> code to CCF (enabling CONFIG_CLK_EXYNOS). Which of course also means
> implementing clocks in dts, akin to kernel's exynos4.dtsi. Then it'll
> be possible to get rid of 'id' property.

That sounds good!

>
> Maybe I'm missing something, please let me know.

An easy way in the meantime would be to look at the compatible / reg
property, e.g. here is a sketch:

static int get_id(ofnode node)
{
ulong addr =3D (ulong)plat->reg;
if (ofnode_device_is_compatible(node, "samsung,exynos4210-uart")) {
    return (addr >> 16) & 0xf;
...

reg =3D <0x13800000 0x3c>;
id =3D <0>;
};

serail_1: serial@13810000 {
compatible =3D "samsung,exynos4210-uart";
reg =3D <0x13810000 0x3c>;
id =3D <1>;
};

serial_2: serial@13820000 {
compatible =3D "samsung,exynos4210-uart";
reg =3D <0x13820000 0x3c>;
id =3D <2>;
};

serial_3: serial@13830000 {
compatible =3D "samsung,exynos4210-uart";
reg =3D <0x13830000 0x3c>;
id =3D <3>;
};

serial_4: serial@13840000 {
compatible =3D "samsung,exynos4210-uart";
reg =3D <0x13840000 0x3c>;
id =3D <4>;

Regards,
Simon
