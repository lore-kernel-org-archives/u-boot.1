Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4158C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF4B788BC8;
	Fri,  2 Aug 2024 21:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fv61DgcB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B94888BD9; Fri,  2 Aug 2024 21:09:14 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32A4588BC8
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=virag.david003@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5a1337cfbb5so13473878a12.3
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722625751; x=1723230551; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=V5bN+tdWK/wiRNxEeHmWvujl3Bp2Tb55Tre1ZtKmvdY=;
 b=Fv61DgcB11JvBFwsgnHTfQv+TIoo9BV5wMqrWr/fOCljTR1KbDZLTQnkN0vOmvyiIQ
 NVoqtO+ddbnqeHWEO7ztjVJVDDggChywTVmrNM/6LezQpRQI3m4RsBgni6yPp7Z/nTLo
 pc0Yk9DhbQFmZaAMPM87e47u9/zCbpPuW8oafCNnJBsqza421J5vITOZ7/SvYgyY3rI5
 DZOs0QsExdwA0X18hdeFYMvMumrqT77Dv2ag79y6cUK7WT5BBfpNyIdX2q2OyTDAIFL8
 +Ptfby3VVcPUmf2a6g6ubD65CxvLojZw1vDu/4iF9cy1R5BQ7XeBZBJmvBfvG0SKswGH
 fmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722625751; x=1723230551;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V5bN+tdWK/wiRNxEeHmWvujl3Bp2Tb55Tre1ZtKmvdY=;
 b=X5GW6f4jvAnP1Kfy79QT0Yz8pM9rBaUipS0E/i1jSoJIBPr6ztQL+h0ZYXQClx0bLj
 6QCL0c3+Uqzd3RKgnzRcXCgLeyOq7MeVY+DaA1+3SG7zg8lN1wbdpCYDTiZEDe3lk/IJ
 TjUKHxo89VfMioKbJrzMfM2fYvz9yxtEMrT9f1gAvLW9zXqzZ9H+lYd2woc1SRZoQ41N
 rTOdAiXqOA61QDHza3uW4R+UjnJ3VzcW3dgncLAPqqBtqvGpRQtQKVp4mw1gqXp8dqEA
 rqTRQqwGDWv7Rrk/HeVDm2UCsyBwcptM34Ccopl5iz3NHEuhY2Yvuy4UtpsXZaUhz6Ob
 bTSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzZTImoSWTHST4iibShnHoXfLeIjjf1hh8+5T5nE6aC/M9WccW3fNebMkPfTBP8EaCpDJxVcc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8DfF9mjNHFN4NhD24kl5lnESf+r1mfbfk1BhWC64/3Bm6O1E8
 mfNhMvPsrJxJPsTq6p/UgdhZ9NShanpxxV2W6nAKNQniqwK8Q6vG
X-Google-Smtp-Source: AGHT+IFf0VbxOfXmAnnbUKRA7F+2JaW23TGFQXlcfFWCAEeEkZSXDbiFR1SOYhHCv6M3TAYFKpM/7A==
X-Received: by 2002:a50:fc0c:0:b0:5a4:12ea:333f with SMTP id
 4fb4d7f45d1cf-5b7f5dc279amr2811383a12.37.1722625751101; 
 Fri, 02 Aug 2024 12:09:11 -0700 (PDT)
Received: from ?IPv6:2a02:ab88:3711:c80:e7a7:e025:f1a5:ef78?
 ([2a02:ab88:3711:c80:e7a7:e025:f1a5:ef78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b83960f101sm1426738a12.20.2024.08.02.12.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:09:10 -0700 (PDT)
Message-ID: <0452dfa8a4945293869698f825b778e4d86a954a.camel@gmail.com>
Subject: Re: [PATCH 2/2] i2c: samsung: Support platforms other than EXYNOS4
 and EXYNOS5
From: David Virag <virag.david003@gmail.com>
To: Henrik Grimler <henrik@grimler.se>
Cc: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, Paul Barker
 <paul.barker.ct@bp.renesas.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,  Caleb Connolly
 <caleb.connolly@linaro.org>, Minda Chen <minda.chen@starfivetech.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Sam Protsenko
 <semen.protsenko@linaro.org>,  Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Date: Fri, 02 Aug 2024 21:10:14 +0200
In-Reply-To: <20240802173147.GA1684431@l14.localdomain>
References: <20240727174152.306827-1-virag.david003@gmail.com>
 <20240727174152.306827-3-virag.david003@gmail.com>
 <20240802173147.GA1684431@l14.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
MIME-Version: 1.0
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

Hi Henrik,

On Fri, 2024-08-02 at 19:31 +0200, Henrik Grimler wrote:
[snip]

> The exynos_hs_i2c driver no longer compiles for exynos4 or exynos5
> with these changes, I am getting (with for example `make
> odroid-xu3_defconfig; make`):
>=20
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drivers/i2c/exynos_hs_i2c.o
> ../drivers/i2c/exynos_hs_i2c.c: In function 'hsi2c_get_clk_details':
> ../drivers/i2c/exynos_hs_i2c.c:154:17: warning: implicit declaration
> of function 'get_i2c_clk'; did you mean 'get_tbclk'? [-Wimplicit-
> function-declaration]
> =C2=A0 154 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clkin =3D ge=
t_i2c_clk();
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_tbclk
> ../drivers/i2c/exynos_hs_i2c.c: In function 's3c_i2c_of_to_plat':
> ../drivers/i2c/exynos_hs_i2c.c:543:23: warning: implicit declaration
> of function 'pinmux_decode_periph_id' [-Wimplicit-function-
> declaration]
> =C2=A0 543 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i2c_bus->id =
=3D pinmux_decode_periph_id(blob, node);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/i2c/exynos_hs_i2c.c:553:9: warning: implicit declaration
> of function 'exynos_pinmux_config' [-Wimplicit-function-declaration]
> =C2=A0 553 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exynos_pinmu=
x_config(i2c_bus->id,
> PINMUX_FLAG_HS_MODE);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~
> ../drivers/i2c/exynos_hs_i2c.c:553:43: error: 'PINMUX_FLAG_HS_MODE'
> undeclared (first use in this function)
> =C2=A0 553 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exynos_pinmu=
x_config(i2c_bus->id,
> PINMUX_FLAG_HS_MODE);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~=
~~~~~~~~
> ../drivers/i2c/exynos_hs_i2c.c:553:43: note: each undeclared
> identifier is reported only once for each function it appears in
> make[3]: *** [../scripts/Makefile.build:257:
> drivers/i2c/exynos_hs_i2c.o] Error 1
> make[2]: *** [../scripts/Makefile.build:397: drivers/i2c] Error 2
> make[1]: *** [/mnt/linux/Makefile:1895: drivers] Error 2

Woops, stupid mistake, sending v2 soon which does actually compile on
exynos4/5 too.
Should work fine with that, but trying it would be appreciated.

>=20
> Best regards,
> Henrik Grimler
>=20

Best regards,
David
>=20
