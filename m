Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EF0E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 19:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94E4B800D7;
	Mon, 16 Dec 2024 20:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FKlbCqTk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13D7D80104; Mon, 16 Dec 2024 20:36:38 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBFF5800D2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 20:36:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6f006748fd1so35311817b3.3
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 11:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734377794; x=1734982594; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F3Z5wK9yGIbKEvYaa+ume8CK3MbjrLhRkZsCPjhLirI=;
 b=FKlbCqTkJfSKYpcrWooO18pdgzfH4oQHoBWG3/1OdxywjmdhWZ65C7RpkfMtQFLmy7
 GHB7KfVWtCFLW1EPLUQze742mtzqH81zcX2ip35JRLMmY2gBeNce98kXEs2z+KqODLV3
 AfqqYZrdsZQJxpNeUwOm/6mKfnVIx9aDf/1sDcfqh99Jk3VhxOMTbU0kA207tAMK7SrC
 d+LV3z7uPdzPIvbObe4XoAyyp76UCtBofF+MRvMgm2euJ921jYjhTXr+GU0r6Z+W6FHr
 LJGKIBOnXLizIvDrM/0jwlHjgUWY2KtaCHjNxQ9LZQHiTe1lc1iF7oSbbbhOv0y1eSZs
 YVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734377794; x=1734982594;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F3Z5wK9yGIbKEvYaa+ume8CK3MbjrLhRkZsCPjhLirI=;
 b=LkRcNMA7+qiDqODtnHNXQUA0pctAbfAc4ut8vPiuOFgEbHfbDZwiybkqAmsWZWnNft
 gDw1uDBV01bdopgm3s4xItc2FhtrDQoX0Az9rJ397IBaSjM/fux8AH+4Bq+Z6os1JFNv
 u5PmsAGluO2I85K7GzUwfIk/WUowM0EgWcjkRoiFK7srhWWiolzmWkbq2cfhlhnoX2ja
 wXfR3iGgeLXWrn5zUQOq9JmEX+qgLD8ktAxHKVyyXYdeGR9N3jYsrq28ykOMrsGcNYW1
 CQj6ua/I2xK3tM9tWbU0bCpG5za9W4f4OTfg18PCre2TAXlNb0JFeDdvVZSd3zWyXh14
 qPPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOA7ckYAtj+bvpOZUXR3reYaTKbx31Ea76mTx2Pg5WtHijJhlSEKYm25KwPVWJF6PaWg2AIBg=@lists.denx.de
X-Gm-Message-State: AOJu0YwWYAU4Hu5sCwEmnmd4MIpfWJVmBK0rF79W19Y9vCoxzZ5Y4HV2
 4rkRU/7RhPDLMFuS/tVIJCKQqU8TiUcEIrx93NZl7ovPebewZcI0KXig0Ww/S0BoSSVPVpUEDTZ
 0Y0KcRu1MevRaN2RYFGqnqRBYQ/Wa8pX2y3MMgg==
X-Gm-Gg: ASbGncvNdRBevKlUxVomgqeO1s8aBib7YK5+H3ps00FCe6HoH379phVDR2Qf3q3DoNr
 EwLxE9x9cJOc6oj/WigZzBU1lnH4Hbi4jJ87CYA==
X-Google-Smtp-Source: AGHT+IE2+s8Le+hOGhcJSbB0f4e+a+KQaSerEcMO9RGJ/Ct5/wxu7hra8Oj+VWoVij8foAEdVpgPAPncs4L5bONx0iA=
X-Received: by 2002:a05:690c:46c8:b0:6ef:8122:282f with SMTP id
 00721157ae682-6f279b1a9a0mr132850667b3.24.1734377794672; Mon, 16 Dec 2024
 11:36:34 -0800 (PST)
MIME-Version: 1.0
References: <20241216114231.qpfwug3zfqkxn3d5@joaog-nb.corp.toradex.com>
 <CADg8p95K5sgLbqutnGWwcggU+o94GFrS5w3=GQecuO_NT5y6PQ@mail.gmail.com>
 <20241216142842.p5j4otcinwpszt5l@joaog-nb.corp.toradex.com>
 <20241216190255.GA55577@francesco-nb>
 <CADg8p96Aiy-DBNc8piA5gN01E+iWHZJ4OGhY5qjOK1wCUS-O7Q@mail.gmail.com>
 <Z2B_sqO2XcAMIF3H@gaggiata.pivistrello.it>
 <CADg8p94S5kzr_yDhs0m8M_J8U_jKLCkdQ+RXiQAbmL+uF+F4+w@mail.gmail.com>
In-Reply-To: <CADg8p94S5kzr_yDhs0m8M_J8U_jKLCkdQ+RXiQAbmL+uF+F4+w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Dec 2024 21:35:58 +0200
Message-ID: <CAC_iWjKV09uXouhvLTKXk3B+Qfw481_unXc1phLq674R0CKyZQ@mail.gmail.com>
Subject: Re: [REGRESSION] Out of memory error: unable to boot on imx8mp/imx8mm
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Tom Rini <trini@konsulko.com>,
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

On Mon, 16 Dec 2024 at 21:32, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Tue, 17 Dec 2024 at 00:59, Francesco Dolcini <francesco@dolcini.it> wr=
ote:
> >
> > On Tue, Dec 17, 2024 at 12:37:38AM +0530, Sughosh Ganu wrote:
> > > On Tue, 17 Dec 2024 at 00:33, Francesco Dolcini <francesco@dolcini.it=
> wrote:
> > > >
> > > > Hello,
> > > >
> > > > On Mon, Dec 16, 2024 at 11:28:42AM -0300, Jo=C3=A3o Paulo Gon=C3=A7=
alves wrote:
> > > > > Hi Sughosh,
> > > > >
> > > > > > Can you show the output of bdinfo. And also print the value of =
ram_top
> > > > > > while booting the board.
> > > > > >
> > > > >
> > > > > Below are ram_top and bdinfo:
> > > >
> > > > We briefly discussed this off list, what is likely happen is that o=
ur
> > > > heap is after 0xFFFFFFFF, or said in a simpler way in the 64-bit ad=
dress
> > > > space, while ram top is at the 4GB boundary.
> > > >
> > > > The solution seems to either move the heap down or move ram top up.
> > >
> > > I am not sure I understand. Isn't the heap memory part of the U-Boot
> > > image, meaning it will always be below the ram_top? How do you have
> > > this configuration where the heap is above ram_top? Can you point me
> > > to the code where the heap is getting set above ram_top.
> >
> > I just guessed this, I might be plain wrong. I assume some malloc is fa=
iling,
> > maybe Joao can confirm.
>
> Ah okay. If it is some efi allocation that is failing, then the
> allocation is not being done from heap. One thing that can be tried is
> to have ram_top at 0x1_0000_0000 instead of 0xFFFF_FFFF.

It was an EFI allocation that was failing by looking at the logs

Cheers
/Ilias
>
> -sughosh
>
> >
> > Francesco
> >
