Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034B7E94601
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 20:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D608805D7;
	Mon,  9 Feb 2026 21:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KoyJohdZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0347D8388D; Mon,  9 Feb 2026 21:17:44 +0100 (CET)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com
 [IPv6:2607:f8b0:4864:20::1329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9E3F80325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 21:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-2b86ce04c5cso1304774eec.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 12:17:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770668260; cv=none;
 d=google.com; s=arc-20240605;
 b=ItilnQQAFe4nkwHfHyn6ZuowZKrQbKKOrTJ76PPVpNeZbZ/B7jupcfuyQs5S+f6rOW
 qCqu8p0/T1VF7pCN/biaViK1QqkLoMIebKoBhEguelp/KS/eGTn4de8O7vbnhm0hdYKo
 JoUVCtLjA3TO8TKZB62d0VOBRb1Nf4RXXplcw4mZl3736d/VRrHxSrlfD1Wmv2iQE2kA
 4YvKGTb9nwUzzHVtRCn04Mh8qv4gMaLYYI6i9kffbYTlu2UHwpIgId41oAzJ+iq5XRCy
 RI/eux8I5/TDi75BgXQH5eo7fpUHMINX4Kba8X+Q7G8+Svhm5ReCw7BKfDa+TN2ioVB6
 rKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qUgXVm+67ZxTbEWGvRhj7THzg70gjlTpJD2uic5nJ4g=;
 fh=Lyn+5luPfgwp/dZiIieD8D8l8PqH+FKNGMTO4t9k7hM=;
 b=dJRrmYcWhZdIvJa7bdfE2m5XDs8MpwG0bNkTOnznkD7sjSxsQAV8uCHurYt7K4spNC
 tqApPTaGeVhKx1ukigFQj+uMXULTvbFhv5w3JIDLra7ugrj/uGthfWfCA/7h+tGxHAPR
 RvFYFdWRETVI5/fSKmKzGzVz/v4EHWl2SMyNIcs4/VAmr08NWolNj0Lg5q/2O4gBnhjv
 WTN5GD1YcI5cCTWGfQFqZjMIk9wVU/NMW0DT4Snwm3LzKayV0AKpOxHDXF+F8ZXa5yqC
 Vc/GrQrfN1s2TjFKi+fETPg8ojV8ZTIjtajxbIjzDmhGWb4yOG8BLZPadCl0PWlucT0T
 SRiA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1770668260; x=1771273060;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qUgXVm+67ZxTbEWGvRhj7THzg70gjlTpJD2uic5nJ4g=;
 b=KoyJohdZU7jRQjKU4/D/dsQpNzo2Dx+DOEcnuz/b+hI7bshO3Hzs1kdX25HX5lL9X4
 5A3TEMpyTcLCrvaKb6pDB6AuskTKhoOC1Xdd6QKTg37q+aCJjibnTZiGr38ntXNJ8aZw
 4SmKtFrvNeWCM2NeICTuzPOEnredzYXHKl4/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770668260; x=1771273060;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qUgXVm+67ZxTbEWGvRhj7THzg70gjlTpJD2uic5nJ4g=;
 b=MTFH94TtaMvS3JzW3/T+i7i9GWBOJ8dJpwogpx9yh9rG4AaqU9mCqA2ie7a6VKCjPF
 nkm/Itml+7uv681HNRiDRwBrcQveV6LPj/tkyTdxN+uSbCv52I5WRSTqmCdPiQRC/FkS
 ZaFj5TrpeE2alYG7Xxcom+HoIeNvk2at7uyji7jvr33JQMbodZhO9e/ghPwcD6iSqwWH
 KT23b9BN8kGbQYi7TIWVIvcbqMVVLGUMXaXhgt4LZ+3o534J5PwlZzbcaFDQFLxDk5bk
 rDVad2fvDmIf3acy3xU7oJHoJ5aPN3kSqFXCUdTxskx2pOJOP3AdBdquCkbknq3NOp/b
 Marw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/PGotf5p1Vz1oSAeypsbtOWtA3DMYRdIxhhYLXtqb1YGa6FX8zTcjvhwKyNfgqnbS9BV2aFo=@lists.denx.de
X-Gm-Message-State: AOJu0YytQH4bI0MqMm5B12T6iWVLXirpDx5RH9du8opawqQUwjKYs1aL
 saTcxm9IYHNNUV0kJ5RdQfurTjViyyBAw4WEErDRyazmLuFGgfqvHMIjGv7pXi59KgF1kfLvvnX
 SyWZB/uqJ07tOGcBe7uVeqwNLBkKCZ6eJkBYxPWkZXw==
X-Gm-Gg: AZuq6aL0z0L4Kx8bAEouVADNBt54oOPvoECepo2oW+nc3InK1+ge2grRpciVkqDevu5
 aLmU1qIFgvrAHUVj8GLBO/mX9XqG4OLszoQDDrAASPxr+NS59VrX4cfZIGGqpEc3mMFC3zWVkHS
 JbT7FUjfXDDRsKtlOOJXbVjzRYpoYGEHrx4NFCBphJfNpBvE64R17pytYMgYW8uCAyM/D23hiAr
 TRmqglI5jX0zSRKJurBzSbTYTRB/p7Zf3ALXmBd0m4qq7t4wRgfm4QfMs1u+blZtKcYv7qx/UWl
 uR2tDmyJbYlIFkBNXYCY+XF1AqI=
X-Received: by 2002:a05:7300:6c21:b0:2ba:659f:2002 with SMTP id
 5a478bee46e88-2ba659f21a3mr2277490eec.15.1770668259893; Mon, 09 Feb 2026
 12:17:39 -0800 (PST)
MIME-Version: 1.0
References: <20260203074721.25520-1-dinesh.maniyam@altera.com>
 <20260203074721.25520-3-dinesh.maniyam@altera.com>
 <20260203145750.GI2603314@bill-the-cat>
In-Reply-To: <20260203145750.GI2603314@bill-the-cat>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 9 Feb 2026 21:17:28 +0100
X-Gm-Features: AZwV_Qj8Z19ESp_yyz3S2a4wi2WY-O789KWv1o7oY9Cmhn7fnq_vZI9NjVcO4iM
Message-ID: <CAOf5uwktpTzTqASRGXs+vsgfR=3TXUvZTX0pFDMW=AuZ9vgCZQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mtd: nand: add generic SPL NAND MTD loader
To: Tom Rini <trini@konsulko.com>
Cc: dinesh.maniyam@altera.com, u-boot@lists.denx.de, 
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Tien Fong <tien.fong.chee@altera.com>, 
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>, 
 Alif <alif.zakuan.yuslaimi@altera.com>
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

On Tue, Feb 3, 2026 at 3:57=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 03, 2026 at 03:47:18PM +0800, dinesh.maniyam@altera.com wrote=
:
>
> > From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> >
> > Add a generic SPL NAND MTD loader providing nand_get_mtd() and
> > nand_spl_load_image() helpers.
> >
> > This allows SPL NAND MTD loading logic to be shared across NAND
> > controllers instead of being embedded in individual drivers.
> >
> > Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> > ---
> >  drivers/mtd/nand/raw/spl_nand_mtd.c | 76 +++++++++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >  create mode 100644 drivers/mtd/nand/raw/spl_nand_mtd.c
>

Reviewed-By: Michael Trimarchi <michael@amarulasolutions.com>

> This is a good idea, and I'd like to see a follow-up RFC that switches
> at least one other platform over showing that this really is generic
> enough.
>
> --
> Tom



--=20
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
