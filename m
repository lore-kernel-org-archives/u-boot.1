Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACDAC61D97
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 22:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1CB987563;
	Tue, 21 Nov 2023 23:11:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M09gzfBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56F5B875F4; Tue, 21 Nov 2023 23:11:02 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9965F8760E
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 23:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a02d12a2444so131754966b.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700604659; x=1701209459; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PgriTN/aJC6pBrIzZPRoL8V97aG5NtB6BIuX1T3kwW8=;
 b=M09gzfBnNp2/O6f/O2mem8o14U7wXCsxz8HFeHLFnyjKUuKHntdmCrYzntG7ZTb6dC
 YzvYTn4IHs4Ch+WuzroESz/MdyMFmqdW3LdbxckXW/Hchu4F5k3hvDqfJS1IdfwlBh3O
 oVkLgRbj14N9d2negrLrc4pBeKYmbKf1GeRx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700604659; x=1701209459;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PgriTN/aJC6pBrIzZPRoL8V97aG5NtB6BIuX1T3kwW8=;
 b=YEAN38Gye/3NEaD8sEQ6Et/UbykOxtLsmy4ivKfhcPuZt1VlvsuCV1PhnIqU+l1+4D
 xRycq4WDu80+L4vEBaEPWTTpZ1UrJ6Mf1GQdbP3135nzP3mJEyaSQHf6eidRdZ61A1Za
 pEYLefsf/3gzUXfLi4+Q8nBMikT64WDt9vljVSxk7Z5e/hEMVXp35Y8ajlWNG79kMYwk
 ZmUydBLTsYJpveVSfwgY4Uql0Ldr3X/f0Zo1Fw7aTpmxljdF/UCsegKuBbpNmK0F3uFj
 HJ6iVHVb5Tr16P81h+NFjqPEz3dlpvvBkUB5RGgloSvPaH2TA5ymoKA98xcj1GPYd72W
 QywQ==
X-Gm-Message-State: AOJu0YxXdH7dum0+xYMskGgBht3dXKl7Ez6em6xfHTxvS2yRDmuFj1pV
 mponScBmR4EOzN4xoI4E88Kx6jdItc9cEqYpD7PlEw==
X-Google-Smtp-Source: AGHT+IG4Or490W1snnZTmJOHbijn4Uu36wCIB695m7kAbYC6nw9OK6mv3m2bAxnsZgVii21batyzZPepZ79geoJMtOY=
X-Received: by 2002:a17:907:a0d6:b0:9bf:6200:fe33 with SMTP id
 hw22-20020a170907a0d600b009bf6200fe33mr234861ejc.16.1700604659097; Tue, 21
 Nov 2023 14:10:59 -0800 (PST)
MIME-Version: 1.0
References: <20231107190601.17151-1-semen.protsenko@linaro.org>
 <20231107190601.17151-3-semen.protsenko@linaro.org>
 <CAPnjgZ2ae9UPanroXZLeNaB6bGN9hBczZcZSEEv=5t6Uz9WWQw@mail.gmail.com>
 <CAPLW+4mtbbEZmQtik_qEtmo0Ehr7R=-yZOO8xVL2Dp0rCCHZ4Q@mail.gmail.com>
 <CAPnjgZ2JCa0qB539w0WZ9Ur1mMuYON1_vk+kwSEraBLK8dpkaQ@mail.gmail.com>
 <CAPLW+4nNpsVX3crBb7aYbLFdY-rigagCZgFX5Tft0KA7yVFhYg@mail.gmail.com>
In-Reply-To: <CAPLW+4nNpsVX3crBb7aYbLFdY-rigagCZgFX5Tft0KA7yVFhYg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Nov 2023 15:10:47 -0700
Message-ID: <CAPnjgZ1Tb4kJJxzBqgVceX4R4r_CF2SGXAEYf3SPFe_QqbUEBg@mail.gmail.com>
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

On Tue, 21 Nov 2023 at 10:32, Sam Protsenko <semen.protsenko@linaro.org> wr=
ote:
>
> On Mon, Nov 13, 2023 at 12:01=E2=80=AFPM Simon Glass <sjg@chromium.org> w=
rote:
> > >
> > > The 'port_id' seems to be needed for ARCH_EXYNOS4 boards. Because
> > > Exynos4 doesn't have proper DM clocks, it uses 'id' property to get
> > > corresponding UART clock frequency from its mach code.
> > >
> > > Here is what's happening in the serial driver in case of Exynos4:
> > >
> > >   1. get_uart_clk(port_id) is called
> > >   2. which in turn calls exynos4_get_uart_clk(port_id)
> > >   3. which uses "port_id" value to read corresponding bits of of
> > > CLK_SRC_PERIL0 register
> > >   4. those bits are used to get corresponding PLL clock's frequency
> > >   5. which is in turn used to calculate UART clock rate
> > >   6. calculated rate is returned by get_uart_clk() to serial driver
> > >
> > > So I don't see any *easy* way we can get rid of that id property.
> > >
> > > The proper way of doing that would require converting Exynos4 clock
> > > code to CCF (enabling CONFIG_CLK_EXYNOS). Which of course also means
> > > implementing clocks in dts, akin to kernel's exynos4.dtsi. Then it'll
> > > be possible to get rid of 'id' property.
> >
> > That sounds good!
> >
> > >
> > > Maybe I'm missing something, please let me know.
> >
> > An easy way in the meantime would be to look at the compatible / reg
> > property, e.g. here is a sketch:
> >
> > static int get_id(ofnode node)
> > {
> > ulong addr =3D (ulong)plat->reg;
> > if (ofnode_device_is_compatible(node, "samsung,exynos4210-uart")) {
> >     return (addr >> 16) & 0xf;
> > ...
> >
> > reg =3D <0x13800000 0x3c>;
> > id =3D <0>;
> > };
> >
> > serail_1: serial@13810000 {
> > compatible =3D "samsung,exynos4210-uart";
> > reg =3D <0x13810000 0x3c>;
> > id =3D <1>;
> > };
> >
> > serial_2: serial@13820000 {
> > compatible =3D "samsung,exynos4210-uart";
> > reg =3D <0x13820000 0x3c>;
> > id =3D <2>;
> > };
> >
> > serial_3: serial@13830000 {
> > compatible =3D "samsung,exynos4210-uart";
> > reg =3D <0x13830000 0x3c>;
> > id =3D <3>;
> > };
> >
> > serial_4: serial@13840000 {
> > compatible =3D "samsung,exynos4210-uart";
> > reg =3D <0x13840000 0x3c>;
> > id =3D <4>;
> >
>
> To be honest, I'm a bit of busy right now working on U-Boot port for a
> new Exynos dev board, which I want to finalize and upstream ASAP. Do
> you think it's possible to take this one as is for now? At least it
> fixes one issue (fdtdec API and global data pointer).
>
> Thanks!

Yes, OK with me.

Reviewed-by: Simon Glass <sjg@chromium.org>
