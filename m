Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5CBCCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 14:36:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C43483D90;
	Fri,  7 Nov 2025 15:36:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pwE2YHot";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B06983DA9; Fri,  7 Nov 2025 15:36:28 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A5B883D8B
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 15:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-28e7cd6dbc0so9622815ad.0
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 06:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1762526184; x=1763130984;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tk1uvfAdm01uJu/wRMdjx/SiBYidbaKQLyMKiY3Mnj0=;
 b=pwE2YHotzkL7NODOmWal0VyE5EmaIbnjkwu5L++mQ5S1n+xqcHKNvkL1fxubMPHrQh
 Lj/IDQdQ8b2QCq3IhuUYTUle7NUfiYqv6HfqsSenyF8I7zOqe1c6fkfJWv3xCfRnccu/
 pWkcMZivoSBAYvADyZFltwX4GZhaSYsxOZmjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762526184; x=1763130984;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tk1uvfAdm01uJu/wRMdjx/SiBYidbaKQLyMKiY3Mnj0=;
 b=Xnbyw0Qxj6JsVEw5q3me6CiCs6UEQA91kHLmhQTd+hkta2UuHXwn+iJpHJIVIHtaQq
 x00WyE2OUYxATmihI7QFjxNigg/L6b22o/prUQq0AyeQbojo4KIdFcgcog3PBe+9pnsi
 Dud4qJQktmkAefTMTDIXrR1n5hN+QB2Vo/2C+OV672+uBBeYYEbzFGwWBYD7mbp3VyVP
 0SP7bce2ubBLl4Idf2T147/E5e7y7A03iTkJliBS57/GJXaMo7zSPnXrBS+a4Rsyvbl6
 O+ikh9Om9Rj9KmHHgniSRcOTtEg+/jrkKzDzlr4MSH3GEtHroM/7UP17+FZXK5CIhSx2
 huhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkxH1JYZNH4YWkb6EIRLuI3dP348/Fuq+FisuU6nrd65AKmU9ErhTIQXNqk7KWrDaxrdpz58M=@lists.denx.de
X-Gm-Message-State: AOJu0YyJDn7sgHMytjQoCAIRZiw81gcHchzXeTuK34f5HJf6wX/Qg0Hp
 NpdaweFseADJvTMRyqWmWRYz3wMPkiXeBYdq2MEUUVvPSJ00oo0rVe5Ez1bXac0MV15GjhPG86k
 7JmYuzVPh47MUrAfvJip2cDG4qn9XfWvs0JqgzAWHbQ==
X-Gm-Gg: ASbGncvU7juBys6jHdTx8mafxcCJECWNTLiAha25rY6b0gm0qLiFC0KCcjHEeswysVC
 zinapkqer4j23A7xIs1DkEMD18Vh9mitvL9cvvAWBy7HrKHfL7dn2rdTHYTPXM6LJr5idK9wWTG
 Py7M3BkDx4cyBBps/ijz8OrZBmXmHy8RLscsrz3G4VdYVKp3j1wJeIzToPSTCHr5sfGxyDioTCh
 A//z/95gzTvEKzCfJT8EZLSgZPDLltuGW1NHSfJijiJBlLaI+75c0X2U6qLVRHkwTlY8YxbtlZF
 kNjF7I+Pk/IANg==
X-Google-Smtp-Source: AGHT+IGueLhB180glSpLCR+HLG/m1Oy6ukYJo4LA5GoSkD+JDiG3Wcc9VYrbgkA0vMfXYUhYf7UL6W5/IsbVFmvKYHs=
X-Received: by 2002:a17:903:190d:b0:28b:4ca5:d522 with SMTP id
 d9443c01a7336-297c0442c0dmr47607395ad.39.1762526184348; Fri, 07 Nov 2025
 06:36:24 -0800 (PST)
MIME-Version: 1.0
References: <20251106170124.3992080-1-admin@hifiphile.com>
 <1116a46b-6261-487b-8418-1c638df56e15@linaro.org>
 <CAOf5uwnO_VtG5sajp-_fq4KvK+V3O8V-PnZmQz0d0MNDPEnn8A@mail.gmail.com>
 <CA+GyqeY6MEV68yXACCs_8oAbD66TeRN292u2CsFUr_m=kRuYHw@mail.gmail.com>
 <CA+GyqebZz=w1LsB16EWm6A1Z+vS+dKYQmMxBDPVE65fE_womMg@mail.gmail.com>
In-Reply-To: <CA+GyqebZz=w1LsB16EWm6A1Z+vS+dKYQmMxBDPVE65fE_womMg@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 7 Nov 2025 15:36:13 +0100
X-Gm-Features: AWmQ_blmXanjRzIGzzb8Cb_5W7dEOEBqSZd9G2CirOi3EOyKKFxSV5PSf9BtIW8
Message-ID: <CAOf5uw=z7nA8ZKs_dDQN7=Qtfuh=oHMRVZQ_rctwcrGAN9_1gw@mail.gmail.com>
Subject: Re: [RFC PATCH] mtd: nand: raw: Add ONFI NAND unique id read support.
To: Zixun LI <admin@hifiphile.com>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Fri, Nov 7, 2025 at 3:35=E2=80=AFPM Zixun LI <admin@hifiphile.com> wrote=
:
>
> Hi again,
>
> I've managed to put this code inside BSP, this patch is no more needed as
> there is no consumer.
>

Ok, that's better for now

Michael

> Zixun
>
> On Fri, Nov 7, 2025 at 1:35=E2=80=AFPM Zixun LI <admin@hifiphile.com> wro=
te:
> >
> > Hi,
> >
> > The intended use is to allow BSP to have a unique serial number,
> > in our case it's something like this:
> >
> > int ft_board_setup(void *blob, struct bd_info *bd)
> > {
> > char strtemp[34];
> > uint8_t unique_id[16];
> > struct mtd_info *mtd;
> > struct nand_chip *chip;
> >
> > mtd =3D get_nand_dev_by_index(0);
> > if (!mtd)
> > return -EINVAL;
> >
> > chip =3D mtd_to_nand(mtd);
> >
> > if (nand_onfi_read_unique_id(chip, unique_id, sizeof(unique_id)))
> > memset(unique_id, 0, sizeof(unique_id));
> >
> > bin2hex(strtemp, unique_id, sizeof(unique_id));
> > strtemp[sizeof(unique_id) * 2] =3D '\0';
> >
> > fdt_find_and_setprop(blob, "/board", "nand-unique-id",
> >                          strtemp, strlen(strtemp), 1);
> > }
> >
> > Zixun



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
