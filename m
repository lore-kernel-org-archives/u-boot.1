Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F19E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 19:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0375800D7;
	Mon, 16 Dec 2024 20:32:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xuzj1Egv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC14080104; Mon, 16 Dec 2024 20:32:24 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADB64800D2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 20:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa5f1909d6fso762377466b.3
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 11:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734377542; x=1734982342; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2Hyw+WKt9fDTg1PN8hvV74MpO+d8yzNMoayaz+uORg=;
 b=xuzj1EgvqWWqiUjt0RUNxY5lMIzJf8Q+pb5nbUQn+Q9GvtqB6m6GC/9GJjxDFYN8C6
 SjaT0ERoxdwRyMbSaE492vTQKD1X6+HyhrgHLad+bJUSLJQLFW0ASh1+i7qCpdN5jtqx
 XnSrFjs1klc7hjS5b4fPgIWxD/ykwO0Og76A1Lt9NfbBPm0jvBmjs/Ad43rizHiYPOO1
 qyoowoa4KPOCKbF+PuzGuOab9W1cWComo48ALh59Y7/GAFBz+MKP3bVmFVti07RPVsqH
 5WYlqPbreRi1cO549XV5GHi/8ssKElNCzDuVyi35BeXBzBA3yjwe62X2vxESax2/bH/f
 e7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734377542; x=1734982342;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A2Hyw+WKt9fDTg1PN8hvV74MpO+d8yzNMoayaz+uORg=;
 b=Atp6N+C2pwK+f0lbc3FCrrTQC01izxPLeYWN/6feijqAscSkfaZjAyQyiGZv45AghQ
 ZPypN9hkwuFtxzert6WlfH+Rtx47z1rxSncElPGC+/FTYyzXeOACAmurxWKcIPyAJRd3
 2R6Ut5wqQidFbteiDdSEmRWMWjUk6HoT64fjjHPG8fvpoOfGQjiPweym+0TBNL0cx9pP
 CzM8gKXjP+wigOoXZ/Fg0rLby3QjdYN50aLrz9hhVDAhU+CI2S0tbxECP5NAFEFx6rFe
 dnILofKXdDBx+0rDWOoZlSn3O+5Mp4HTRtLSflgp7yBB+YKAk1ZPYNb8UvVCAHDkiSYU
 zVFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS86c+Gd4OjBiR280siavdrm7HvGY7TJMuzyfOBZ2iwgawKX13gV8EqjOzZAEhZa8dUQxeaO0=@lists.denx.de
X-Gm-Message-State: AOJu0YyL8dM/PjpyDVVqD49jOOisWQmCExN3Am9Cs2Je3OZK2ks+zzJC
 r2d405FRe2mlMGRd3f6bkBjhfXEqz8XSd0FiRRJ10uT0hPQ/bWTODR5suRAaj4d4NDxCQbrJD29
 5IznnCe4Vms/8PQt2gCjvaW8AlfkkDhPw9HptrA==
X-Gm-Gg: ASbGncsVYPJ2hYFuLCVgIaXy3pEmscc+Uf33ztko+uwW/HmSPrfXHSP3p8mQdtod2Le
 BUrkK0gvPqZROvVuR8kmY2CkQWyaYn851dKQAqbc=
X-Google-Smtp-Source: AGHT+IGqOs1LX/HS7uaVqwIdo/QbOyYAKW3I49GKnuf1Bezjq8juwl4ujjwxKHMIRlmT6jRSOjhYITBlX5risXEFvp4=
X-Received: by 2002:a17:906:c14d:b0:aab:7588:f40b with SMTP id
 a640c23a62f3a-aab7797b793mr1288083866b.21.1734377542208; Mon, 16 Dec 2024
 11:32:22 -0800 (PST)
MIME-Version: 1.0
References: <20241216114231.qpfwug3zfqkxn3d5@joaog-nb.corp.toradex.com>
 <CADg8p95K5sgLbqutnGWwcggU+o94GFrS5w3=GQecuO_NT5y6PQ@mail.gmail.com>
 <20241216142842.p5j4otcinwpszt5l@joaog-nb.corp.toradex.com>
 <20241216190255.GA55577@francesco-nb>
 <CADg8p96Aiy-DBNc8piA5gN01E+iWHZJ4OGhY5qjOK1wCUS-O7Q@mail.gmail.com>
 <Z2B_sqO2XcAMIF3H@gaggiata.pivistrello.it>
In-Reply-To: <Z2B_sqO2XcAMIF3H@gaggiata.pivistrello.it>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 17 Dec 2024 01:02:10 +0530
Message-ID: <CADg8p94S5kzr_yDhs0m8M_J8U_jKLCkdQ+RXiQAbmL+uF+F4+w@mail.gmail.com>
Subject: Re: [REGRESSION] Out of memory error: unable to boot on imx8mp/imx8mm
To: Francesco Dolcini <francesco@dolcini.it>
Cc: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
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

On Tue, 17 Dec 2024 at 00:59, Francesco Dolcini <francesco@dolcini.it> wrot=
e:
>
> On Tue, Dec 17, 2024 at 12:37:38AM +0530, Sughosh Ganu wrote:
> > On Tue, 17 Dec 2024 at 00:33, Francesco Dolcini <francesco@dolcini.it> =
wrote:
> > >
> > > Hello,
> > >
> > > On Mon, Dec 16, 2024 at 11:28:42AM -0300, Jo=C3=A3o Paulo Gon=C3=A7al=
ves wrote:
> > > > Hi Sughosh,
> > > >
> > > > > Can you show the output of bdinfo. And also print the value of ra=
m_top
> > > > > while booting the board.
> > > > >
> > > >
> > > > Below are ram_top and bdinfo:
> > >
> > > We briefly discussed this off list, what is likely happen is that our
> > > heap is after 0xFFFFFFFF, or said in a simpler way in the 64-bit addr=
ess
> > > space, while ram top is at the 4GB boundary.
> > >
> > > The solution seems to either move the heap down or move ram top up.
> >
> > I am not sure I understand. Isn't the heap memory part of the U-Boot
> > image, meaning it will always be below the ram_top? How do you have
> > this configuration where the heap is above ram_top? Can you point me
> > to the code where the heap is getting set above ram_top.
>
> I just guessed this, I might be plain wrong. I assume some malloc is fail=
ing,
> maybe Joao can confirm.

Ah okay. If it is some efi allocation that is failing, then the
allocation is not being done from heap. One thing that can be tried is
to have ram_top at 0x1_0000_0000 instead of 0xFFFF_FFFF.

-sughosh

>
> Francesco
>
