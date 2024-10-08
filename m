Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27B0CEF172
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 14:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21BE888DF4;
	Tue,  8 Oct 2024 16:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FmnJzi2j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F2DA88E2C; Tue,  8 Oct 2024 16:56:37 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1338F88E78
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 16:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2fac9eaeafcso61816081fa.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 07:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728399393; x=1729004193; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PNGfUNAGlzeNOO1MeKlWJPOgcZ5NSk5+nTDTh7f8tU4=;
 b=FmnJzi2jFA1Up+mVn/LaVoZOyD4RzlypCTnhIGQrF+CkqMp4nFPG3Mvr0MjbyhIFNI
 /C+c4uilELcd0Uh9OieVufkjZaljxseOHmFzPSc9GLKrVvuNni8sfIzFKCjxNJCz/Qlh
 pc+h22hGwKd3iyqqjbIzCZ3i4o1pp3PjMOMrvdJyVZ67r8QsMLQXDm01UgSkZUe2Jsxf
 u2XjqL2DXfmFdqBrgIIVf9GQVzBau00a71CBi8e+MwsEUjS/fDR+d3ftB4LFI9jqWGTa
 63vB+pZIXyEmgPmEy5B+QJbL3++GT3WbbF/27pUHqBoaA2mGMPH5jloguJVb8ZmTzYlt
 EsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728399393; x=1729004193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PNGfUNAGlzeNOO1MeKlWJPOgcZ5NSk5+nTDTh7f8tU4=;
 b=RXpIoxkO8QtRr1gXgnKNgaEUxKCm0Vb2JuH/KlkZnQB/7A3IckgW7Untknv/G+xcxc
 Me5kwrFlcv9o6OxJcBFqxXPn5sAsE74Pp52Poqj8938eLeALbJkkQcoH2iTUV1aQsRAh
 AKVcjsRi7vgmznyR9MgjDjN3QffyEvLO9IhqCdLxlWk00GyOFAoE5kRw59smVpeagUVQ
 Izwf9vXYxpjkdFVvn4+KYGvbxLULZ8q4p5Tf19At1WejqUt6AHzCEp9SO65W87tEeL9/
 ptMtPwvB0X0/G4Pkd4V+LE9iyGrtYp1gjk1oAjG75aZSvPSZP4yQNzA/AJLFgMq/Bkmv
 xhwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjNv8iVQ8tobPWNTAusoa/XEPfb80l2p3YMnlLf1oK5E4W4letXt3+GjL3SCvdWNTJqQdIM38=@lists.denx.de
X-Gm-Message-State: AOJu0Yzl9vL83Y2Pp+B0DqXQlU1qx9nlisJ5XjGMbs+97cw7tWrtsB/A
 OQvtYFi+1z8M5taJW50X+HAmVfCe4WsQguBs28I2y2mAn7O1SiaBHUa+UPFGU2ZW9T4+z31jvgp
 C26t58u8ktJ/fjRs6OZPRi2+tXxI=
X-Google-Smtp-Source: AGHT+IEv2r365vv5s0tdwVWZj4NaK4OqQOlgBMjO6XW1Mbds7TQYhgurlKPo18L6sNk+naK4wOYwSdtDZq4WvtHYBGU=
X-Received: by 2002:a2e:4e19:0:b0:2f1:5561:4b66 with SMTP id
 38308e7fff4ca-2faf3d7a84fmr69858151fa.44.1728399392994; Tue, 08 Oct 2024
 07:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241006010522.20841-1-peng.fan@oss.nxp.com>
In-Reply-To: <20241006010522.20841-1-peng.fan@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 8 Oct 2024 11:56:21 -0300
Message-ID: <CAOMZO5BPoiyicMANp5Y7283_FOhgz7SMeQoLFx=xf2XWNm-1Yw@mail.gmail.com>
Subject: Re: [PATCH] imx8: Correct the SCU API return value check
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>
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

On Sat, Oct 5, 2024 at 9:01=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.com=
> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> The SCU API alrdeay has been converted to return Linux error code,
> using SCU error code is not correct here, although SC_ERR_NONE is value
> as 0.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

This causes the following build failure:

aarch64: + colibri-imx8x
304+WARNING 'mx8qx-ahab-container.img' not found, resulting binary is
not-functional
305+arch/arm/mach-imx/imx8/cpu.c: In function 'arch_auxiliary_core_up':
306+arch/arm/mach-imx/imx8/cpu.c:249:9: error: 'ret' undeclared (first
use in this function)
307+ 249 | ret =3D sc_pm_set_resource_power_mode(-1, core_rsrc, SC_PM_PW_MO=
DE_ON);
308+ | ^~~
309+arch/arm/mach-imx/imx8/cpu.c:249:9: note: each undeclared
identifier is reported only once for each function it appears in
310+arch/arm/mach-imx/imx8/cpu.c:262:84: error: expected ';' before 'if'
311+ 262 | ret =3D sc_pm_clock_enable(-1, core_rsrc, SC_PM_CLK_PER, true, f=
alse)
312+ | ^
313+ | ;
314+ 263 | if (ret) {
315+ | ~~
316+arch/arm/mach-imx/imx8/cpu.c:260:37: error: unused variable 'pd'
[-Werror=3Dunused-variable]
317+ 260 | struct power_domain pd;
318+ | ^~
319+cc1: all warnings being treated as errors
320+make[3]: *** [scripts/Makefile.build:257:
arch/arm/mach-imx/imx8/cpu.o] Error 1
321+make[2]: *** [scripts/Makefile.build:398: arch/arm/mach-imx/imx8] Error=
 2
322+make[1]: *** [Makefile:1907: arch/arm/mach-imx] Error 2
323+make: *** [Makefile:177: sub-make] Error 2

Please make sure to run the patches through CI.
