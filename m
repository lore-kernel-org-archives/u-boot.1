Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E45C61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70BB687545;
	Tue, 21 Nov 2023 18:32:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NXkMG9Zj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81E24875F4; Tue, 21 Nov 2023 18:32:43 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48AE887250
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:32:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2851cc359c1so1642746a91.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700587959; x=1701192759; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jULxanMrniC6VII5HDwFala9W4yJEsWBh65iGBbi8mQ=;
 b=NXkMG9ZjTUYR40DlD+w9jv0LE0Y2AVSAKjn0SiRT8lo5mpAF4nzBZgr1IP6NWqDdKM
 JREaLtrYy5I4m6GbgQ5mwgbb5HpY2XQGA5kGtETyoor2SKcHISEULaKZy4NIv3+o1PUW
 egYDFue8SCFTdJsZlNaC3RNmS5gvrPQBmCcrjuFM/FokUfFyrsXq2225iOnR8VTuF0xj
 9YzCp21rCpXaEQS9OnZndXTZktj2rm07b+/j1pScJe746law/eAXxcyf4SOpl7WL3zfP
 yh+uQdMJz5BGAxdkuOhkxyv9HrzaucO28BBj8xmBCqcwMLremMLJu6TATcngdhH7+lq8
 KE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700587959; x=1701192759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jULxanMrniC6VII5HDwFala9W4yJEsWBh65iGBbi8mQ=;
 b=OLcbU30mtDIQk2WQ497hhzTDUrISRV3J6D/Tu4rtm5xNp30fP4jreO2roocOBRsld6
 LAAOMey6nb0ghlf6NIEcJTXAeZGWHGZ3OHBfzSqxtzPZTcS0+dLKGGkeeTt+8XSPJ2ce
 S1ySEyty11f3wjkrSwWebsg/BM4JjDrh1sjFgIAirVO7JFcL3k+2C8P40e0fmZlr4fhI
 SpDyu2EFPtxDgBI8aWXQqEjLO/vkC4b3HW7g9qJSX8MjIkkPxGf2atmd6tlMXGsOv0Yj
 8e+PMPhAkHJ5Q/fzVNmv75HCEM3oQkoLoldTRYFcLqcP6r7oiOQ5E3glyYaSGg6iBFTk
 97Mw==
X-Gm-Message-State: AOJu0YxraiVtHG5PVlJKeDIpj563iA2+VamW2QnqWeMW/qpF+2grtHmf
 6AOVUGMlDSXG/bgnalHjl3y4+q808f/yRI+DcIu2AA==
X-Google-Smtp-Source: AGHT+IH54DKtE5abtLV0IwLJ7P0ZGZm+MG6RmLKh/Q3xC1pwjvSH9WaOkNnMar+pspAlAI4meq80/yKMyH7cSTf9iCE=
X-Received: by 2002:a17:90b:1b01:b0:280:1fdf:2f3d with SMTP id
 nu1-20020a17090b1b0100b002801fdf2f3dmr9000266pjb.16.1700587959629; Tue, 21
 Nov 2023 09:32:39 -0800 (PST)
MIME-Version: 1.0
References: <20231107190601.17151-1-semen.protsenko@linaro.org>
 <20231107190601.17151-3-semen.protsenko@linaro.org>
 <CAPnjgZ2ae9UPanroXZLeNaB6bGN9hBczZcZSEEv=5t6Uz9WWQw@mail.gmail.com>
 <CAPLW+4mtbbEZmQtik_qEtmo0Ehr7R=-yZOO8xVL2Dp0rCCHZ4Q@mail.gmail.com>
 <CAPnjgZ2JCa0qB539w0WZ9Ur1mMuYON1_vk+kwSEraBLK8dpkaQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ2JCa0qB539w0WZ9Ur1mMuYON1_vk+kwSEraBLK8dpkaQ@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 21 Nov 2023 11:32:28 -0600
Message-ID: <CAPLW+4nNpsVX3crBb7aYbLFdY-rigagCZgFX5Tft0KA7yVFhYg@mail.gmail.com>
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

On Mon, Nov 13, 2023 at 12:01=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > The 'port_id' seems to be needed for ARCH_EXYNOS4 boards. Because
> > Exynos4 doesn't have proper DM clocks, it uses 'id' property to get
> > corresponding UART clock frequency from its mach code.
> >
> > Here is what's happening in the serial driver in case of Exynos4:
> >
> >   1. get_uart_clk(port_id) is called
> >   2. which in turn calls exynos4_get_uart_clk(port_id)
> >   3. which uses "port_id" value to read corresponding bits of of
> > CLK_SRC_PERIL0 register
> >   4. those bits are used to get corresponding PLL clock's frequency
> >   5. which is in turn used to calculate UART clock rate
> >   6. calculated rate is returned by get_uart_clk() to serial driver
> >
> > So I don't see any *easy* way we can get rid of that id property.
> >
> > The proper way of doing that would require converting Exynos4 clock
> > code to CCF (enabling CONFIG_CLK_EXYNOS). Which of course also means
> > implementing clocks in dts, akin to kernel's exynos4.dtsi. Then it'll
> > be possible to get rid of 'id' property.
>
> That sounds good!
>
> >
> > Maybe I'm missing something, please let me know.
>
> An easy way in the meantime would be to look at the compatible / reg
> property, e.g. here is a sketch:
>
> static int get_id(ofnode node)
> {
> ulong addr =3D (ulong)plat->reg;
> if (ofnode_device_is_compatible(node, "samsung,exynos4210-uart")) {
>     return (addr >> 16) & 0xf;
> ...
>
> reg =3D <0x13800000 0x3c>;
> id =3D <0>;
> };
>
> serail_1: serial@13810000 {
> compatible =3D "samsung,exynos4210-uart";
> reg =3D <0x13810000 0x3c>;
> id =3D <1>;
> };
>
> serial_2: serial@13820000 {
> compatible =3D "samsung,exynos4210-uart";
> reg =3D <0x13820000 0x3c>;
> id =3D <2>;
> };
>
> serial_3: serial@13830000 {
> compatible =3D "samsung,exynos4210-uart";
> reg =3D <0x13830000 0x3c>;
> id =3D <3>;
> };
>
> serial_4: serial@13840000 {
> compatible =3D "samsung,exynos4210-uart";
> reg =3D <0x13840000 0x3c>;
> id =3D <4>;
>

To be honest, I'm a bit of busy right now working on U-Boot port for a
new Exynos dev board, which I want to finalize and upstream ASAP. Do
you think it's possible to take this one as is for now? At least it
fixes one issue (fdtdec API and global data pointer).

Thanks!

> Regards,
> Simon
