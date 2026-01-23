Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019A1D6CFAA
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 00:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3D228397D;
	Fri, 23 Jan 2026 01:52:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IMX0FjuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 675A2839DF; Fri, 23 Jan 2026 01:52:54 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 679EA838FA
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 01:52:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-59b7be7496dso1733294e87.0
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 16:52:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769129572; cv=none;
 d=google.com; s=arc-20240605;
 b=ZM1saJ/ehC92sEgVebUC0gmwBVouR2me3Q5KkYRHBF+J+CgmM1+eH2QcmnhQcBRM/g
 C7GDBXkl6ThHsL+kqsH7kPvXZCG1GCLGlQr6jxidgzPXflJOva7WM8PemDuborS//EzV
 PaI7WY7shT0Dcwi1FaNHgfQ5KEG/456qqYGXOBVssh2F10cFzOrcw/Kz5jBROaVVO6B2
 Hu5162HChWTERJDkn7Wr2iKf+QQj1CNB2njE+x7fbEX/tafVdq8wnKewOsNXrBXVQWsN
 jRECv2UKCLHSfVhRsYQDtvMPSyM6vvCjCz6iF5hP6hQfvPCsoHantLB85tlp+KtTyJ2H
 P/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7X0gRuDjCUFj+HurSgCgCnh4/fVWiqeXXI2orEIll6s=;
 fh=ZDo4EdcjLkjF4B4lXq7BaaWCJQNVpL81Rb+8oudZUIg=;
 b=KeODwY4dsFSvvJkuZMTTCM4U8LQQSENVjAIIHMB2bvEOa1O1Ae25uPpJVkixYb9E33
 vENfHu0Kjb7emtzs6rzcVDYAHoz6shYwHiVL2faW9GSu3zfZfroZ9jUhrNwDGan53wIF
 AwolGtozMsq3tYGw7iE85EfxEj0ebjlCMY2R7Pbn76yEImgczf6mQLrrHNHZSYoDt307
 WzrldBp6vDna562n4VC36VlWCRyPY+iS7+8puO4wkd6jvezWSfEaWxemHnRArBGeYFWd
 TPTmYhZ0sN04RlSTCmf+FJbhgVbr8l38bv+BNJfSikCts4rob2SmV2VnziUusfWBPKHG
 IMzw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769129572; x=1769734372; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7X0gRuDjCUFj+HurSgCgCnh4/fVWiqeXXI2orEIll6s=;
 b=IMX0FjuXWG8YtBkEfgy5BbSaGz20u6r8Qqvknp3M0tIPLzDAEC4Y8PvWojtMgCpx2V
 km+Hzd9Pz/dKI5DANOpouaFJRg2erxpWkbqP1ID1nrgWJiEyWpQ3oBhK46PGdYXPROsk
 pD82c3IClNvG6XK3bYFffBb5+0WGmK0eT1wD3hDvJLth/2m4SWYJnsQ0Tdu7bhU+gtfs
 fvS6EENXDD0zBVNJcT8Z8dbSUSPoLU5RfyfTYVv3HhWRMbi+lVWocVqaqtW6fRNsVrLE
 svUBEdIjIltd7I/s0eNhy3IYuFPXPQDdqa+ZxRwgO9KBRDTyXaVaBht0d1YTFLMSrox0
 kU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769129572; x=1769734372;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7X0gRuDjCUFj+HurSgCgCnh4/fVWiqeXXI2orEIll6s=;
 b=tbk3VWKhT+BDsQ7zU3FyRHl7ZdYC/FJyinI+Uokd4NJlCk2dQtoCeWOLiMilPIP21b
 RwPWWSlMZulfn6VFyuSDgyDldhLRlGtCp2KYJDRVPaTTEWe8y3HSmnDRNiR9eoCrikA/
 pOzrdC6ctv0pQxXD1eYc7EAdZCV8ULRw+ilMlhTZvEAMZR/YbVGCEoKfS+W3MlO6xMaK
 F6S8ARc7voYfpG0x2Nx4UHpOfCqinFq71Qs0IwbPBeuP4zVpX1sq9erTwFH/9Nxl4CEz
 Kb7JdaeMDZwoGXRpf56+DNBbP/rUY0mLktDziwHaYUjJmmEK8EBZInGm5YQqtO9DvkE2
 0pZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdH8fusS2vPN7072QQR3zg0ubfD+7hqbXyoMYb3c1U0Mqb3hLUrFOfUZ7OMlNCExoDCcFEmuA=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7sBXU7fmBu+IAnvrQBBis/4kG5u/Y05xE1FVAXNqiXqC5K+X2
 AmdZS2MQ74RiuFXbHjfzq3eLkIryBiOd6kJebt9fCsCqCXo35G+yfxPPXpUy1fHMfBO8yBB5OOy
 Gm+m/AyZ1QoDxc1B/k/8QXorG9UKFghc=
X-Gm-Gg: AZuq6aL1RAfbLLXsJ3lxp8ZtZuklQlNT1ocNWleQjX21n5yAg3u9vTPnVvKVzmiFlYW
 Tm9nT4bBFc8z1h7mPMecZ9fA+CrOVTcdtn6zejF2zy/y8PNiY3fl0xRlCBr3ObvNC/RFWNjqHJY
 mBC/KGngYzBl+QI6YPrwIA6zrFZPpoDNw+kDqfGa3JG80CtsWISRfLc3OAnxhc4WkF2CslLiYFY
 riaID4nPxhcJuFUUFBYhAMDA+2VdrTb21wOaMSQyWmugO+8HzUF49ulqpCS2mWKDZB7f0NN5Q/z
 jZJDdtvg7nXpb4IRoJhppZXFkvU=
X-Received: by 2002:a05:6512:3504:b0:594:2e7b:6f9 with SMTP id
 2adb3069b0e04-59de4a242f6mr291229e87.27.1769129570991; Thu, 22 Jan 2026
 16:52:50 -0800 (PST)
MIME-Version: 1.0
References: <20260115222828.3931345-3-trini@konsulko.com>
 <CAOMZO5DZNJ+=AP1spWCv7Ar6etf03H=DFVU=mXZcC7QFTGoh_Q@mail.gmail.com>
 <CAOMZO5COTa3ykhF8XZyzmJ0QZNotK4USo0LrH0XBJLogatfXFQ@mail.gmail.com>
 <040e129c-44ca-4a59-828f-d37c6e41d3b2@mailbox.org>
 <20260122142323.GX3416603@bill-the-cat>
 <CAOMZO5AZiBajXK1b6Mse9LPwHEzhJSM_-OcQs4BsnbXP3WzuxA@mail.gmail.com>
 <20260122191042.GD3416603@bill-the-cat>
 <CAOMZO5CJ4BAi95gjV8a=_W-Wu=zr1dMOoDOCB4yUVAzY2ARBUA@mail.gmail.com>
 <20260122194239.GF3416603@bill-the-cat>
 <CAOMZO5BiQcp2HYJgrYnPQLn8Q52Z05FKjbqVKPXxKa8D3Cny5Q@mail.gmail.com>
 <20260122232407.GG3416603@bill-the-cat>
 <CAOMZO5ADFCbzyv3whDo_w=hEwe9i1hhMZ-X+UEu8132pkFnqJg@mail.gmail.com>
In-Reply-To: <CAOMZO5ADFCbzyv3whDo_w=hEwe9i1hhMZ-X+UEu8132pkFnqJg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 22 Jan 2026 21:52:39 -0300
X-Gm-Features: AZwV_Qi_D1Pel5M2xlPKMUDnC7lDS6f7PumpvfKWn_sLA_poYg_2p1Fv-k5qWMo
Message-ID: <CAOMZO5CLQZ3i+Eit5csv6E+az-_g2eOHfCr-whQTPeg06WtqEg@mail.gmail.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Kever Yang <kever.yang@rock-chips.com>, 
 u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Beleswar Padhi <b-padhi@ti.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Joel Stanley <joel@jms.id.au>, Michal Simek <michal.simek@amd.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
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

On Thu, Jan 22, 2026 at 9:25=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> The commit in the Subject is what appends 4 bytes, and the binary is
> now shifted, causing the boot failure:
>
> hexdump -Cv spl/u-boot-spl.bin | grep 'd0 0d fe ed'
> 00015f10  00 00 00 00 d0 0d fe ed  00 00 0a 43 00 00 00 38  |...........C=
...8|

To make things simple, let's use a supported board in mainline.

Please follow these steps to reproduce the bug:

U-Boot top-of-tree:

make mrproper
make sonoff-ihost-rv1126_defconfig
cat spl/u-boot-spl.map | grep __bss_end
                0x000000000000b468                __bss_end =3D .
                0x0000000000000054                __bss_size =3D
(__bss_end - __bss_start)

hexdump -Cv spl/u-boot-spl.bin | grep 'd0 0d fe ed'
000016d0  a9 98 00 00 15 15 00 00  d0 0d fe ed 48 99 00 00  |............H.=
..|
00001d20  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo...pG....=
..|
0000b460  00 00 00 00 00 00 00 00  00 00 00 00 d0 0d fe ed  |..............=
..|

b468 contains 00 00 00 00 instead of FDT_MAGIC. FDT_MAGIC appears at b468 +=
 4.

After reverting 8b0ebe054bb3334c6ca9bed018360b08d4ddc7a4:

cat spl/u-boot-spl.map | grep __bss_end
                0x000000000000b468                __bss_end =3D .
                0x0000000000000054                __bss_size =3D
(__bss_end - __bss_start)
hexdump -Cv spl/u-boot-spl.bin | grep 'd0 0d fe ed'
000016d0  a9 98 00 00 15 15 00 00  d0 0d fe ed 48 99 00 00  |............H.=
..|
00001d20  08 00 70 47 6f f0 12 00  70 47 00 bf d0 0d fe ed  |..pGo...pG....=
..|
0000b460  00 00 00 00 00 00 00 00  d0 0d fe ed 00 00 0d 95  |..............=
..|

b468 contains FDT_MAGIC as expected.
