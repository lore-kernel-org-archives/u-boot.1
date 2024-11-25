Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C88FD58D40
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 13:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C16A189A4C;
	Mon, 25 Nov 2024 14:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fQQS+iso";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40DCD890CE; Mon, 25 Nov 2024 12:19:45 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3541388815
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso54947645e9.0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 03:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732533582; x=1733138382; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rMZbyQx+PXNn+NYXgRow8BP/QekzXRT5WJBNSBRMiSM=;
 b=fQQS+isoeQApH6iTnWcYCOtT9wSL0FB4EgcEz5uzIq0fXw13VIoGYNmDb+zLVQ3/ap
 7xE9Y7vLMt07RnBzQ6ZcalUab6OxteFaTHqQqBtgx0by7cGVNZMzRHrfQ3yvlsdLD+qB
 hdRaUosKancsPLWmO/uNHokKof+dRM+/2uhaQX6Vfa4/LcA1R+YjKdWIGgI7nYvIN7is
 n+KLWmaolxA6sTs166UewzPT1kbPYknT0aKOIqD4943f9vSHO5TbC861X0n6UkywIH//
 ye76A1ka/bQc7oXagy9U5nIgTeRii8BFKa1750CTogR2xuSXglhuZcVVZcxCgv27VEYp
 0pAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732533582; x=1733138382;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rMZbyQx+PXNn+NYXgRow8BP/QekzXRT5WJBNSBRMiSM=;
 b=PuWUYGLfiMqqOE+f03iqqiMSFlouYp/91Mo55SVyqyYhRPY0N6ddBsc7cLN9GW3fWq
 mrT45y8fnG9ttiBBfU6fm0yXxt5byZofKGcEdM0uazLe7oSsbiiVNACdXTOQgMHx0VAc
 XiqhL0EOkzQz8cY2idzTvp9vHyRsD+w4NSah8Q2dqzG1QY1ZpwFz7hOiF9ItExiluQIQ
 oT/cwRtmchj0OjjIO8eWQmYfskITWT92Az2FMHAKp0CuvbAmy6K05eo/gY02JfpkP838
 y/MiUhZil+lHcJz4vNtx+0h4lmH0am6sGgigADLxynkUUI5Y8TFCX8wMRYsVodairPth
 TBfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWubOCoUHb4PUNXTU3n+p2RnX2Uuc5Mwx9iMc4Xjz6LBheZkexm806V/nzk6L2bJ6NvLi34nKs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0U3+ADP49PtsmkZ6gBehtz49pBm2tUBckfVb72AHHR2ANcjjf
 0k+zY8mpu910Jao0C5c1i4bBa+fYsc0tf8mcBskrhmwdeHgbHhMw
X-Gm-Gg: ASbGncs7WgZP9AVyg+oEwg0eO4nAAa9E1mcWEEIipakRhAZiZSOrc+eeRKZ9xBx6Mib
 M6kjjr27g9szeEnyknitSNXnQ6oCNPFon8XvtEmzHmEqpLEvZHKwY1hQS/Ewoe4MNUTm8FakAwv
 unx7fwkB9owk9VEiF328IWlCevtU/VpUW4LBtnvlhOrJZb7X0mR01LltphG9RxHkIUjSTdn6w1j
 VFmror3GeKY3KZXqSbfsNL9rOQw/Gpi3MPFVypltNgKDoZIpG4CM8d6zXsKYaR8gOeNzlLlZx7G
 n87xd+18+Lmbsy1+ig==
X-Google-Smtp-Source: AGHT+IH2AFYvwP8W3upBc4acGAEm1I7mwe1zIveDGXscAZ53dK2mdX29DvNAonh6zym7DjrQ1MpWPQ==
X-Received: by 2002:a5d:64ad:0:b0:382:4f7a:7a87 with SMTP id
 ffacd0b85a97d-38260bd705bmr11892501f8f.48.1732533581896; 
 Mon, 25 Nov 2024 03:19:41 -0800 (PST)
Received: from ?IPv6:2001:8a0:e622:f700:99c7:849e:ac2b:8adc?
 ([2001:8a0:e622:f700:99c7:849e:ac2b:8adc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc42a2sm10311738f8f.71.2024.11.25.03.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 03:19:41 -0800 (PST)
Message-ID: <ba3564322dee243dcb033eacc48ba5466995d281.camel@gmail.com>
Subject: Re: [PATCH v2] toradex: tdx-cfg-block: rework modules pid4 handling
From: Vitor Soares <ivitro@gmail.com>
To: Francesco Dolcini <francesco@dolcini.it>, festevam@gmail.com
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, Tom Rini
 <trini@konsulko.com>, Vitor Soares <vitor.soares@toradex.com>, 
 u-boot@lists.denx.de, emanuele.ghidoli@toradex.com
Date: Mon, 25 Nov 2024 11:19:40 +0000
In-Reply-To: <Z0RV5sl7uMzFXvW9@gaggiata.pivistrello.it>
References: <20241122182722.457366-1-ivitro@gmail.com>
 <Z0RV5sl7uMzFXvW9@gaggiata.pivistrello.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 25 Nov 2024 14:06:45 +0100
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

On Mon, 2024-11-25 at 11:48 +0100, Francesco Dolcini wrote:
> +Fabio
>=20
> since he is the one normally picking patches from board/toradex/.
>=20
> On Fri, Nov 22, 2024 at 06:27:22PM +0000, Vitor Soares wrote:
> > From: Vitor Soares <vitor.soares@toradex.com>
> >=20
> > The module pid4 currently corresponds to the index of the toradex_modul=
e
> > array. If a new pid4 is introduced that does not follow the sequence of
> > the previous entries, it will create a gap in the array.
> >=20
> > To address this, embed pid4 within the toradex_som structure and
> > implement a function to retrieve the index corresponding to pid4.
> >=20
> > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > ---
> > v1->v2:
> > =C2=A0 - Fix incorrect PID4 print when creating config block in interac=
tive mode.
> >=20
> > =C2=A0board/toradex/common/tdx-cfg-block.c | 207 ++++++++++++++--------=
-----
> > =C2=A0board/toradex/common/tdx-cfg-block.h |=C2=A0=C2=A0 2 +
> > =C2=A0board/toradex/common/tdx-common.c=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 4 +-
> > =C2=A03 files changed, 116 insertions(+), 97 deletions(-)
> >=20
>=20
> ...
>=20
> > diff --git a/board/toradex/common/tdx-common.c b/board/toradex/common/t=
dx-
> > common.c
> > index a6b45cdab810..dd2d4b27cea7 100644
> > --- a/board/toradex/common/tdx-common.c
> > +++ b/board/toradex/common/tdx-common.c
> > @@ -194,10 +194,12 @@ static int tdx_get_str(struct udevice *dev, int i=
d,
> > size_t size, char *val)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0switch (id) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case SYSINFO_ID_BOARD_M=
ODEL:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0int idx =3D get_toradex_modules_idx(tdx_hw_tag.prodid)=
;
> > +
>=20
> this is not something you are generally allowed to do in C, not sure whic=
h C
> variant U-Boot wants, but I would avoid it.

My mistake, I will send a V3 addressing it.


Best regards,
Vitor Soares
