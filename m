Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3444CE7A8B
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 23:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C66886A7D;
	Mon, 25 Sep 2023 01:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N3HvGRSG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EB5086A7D; Mon, 25 Sep 2023 01:38:24 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F03098642A
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 01:38:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-277191ba647so766554a91.1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 16:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695598700; x=1696203500; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OeL4IVmaurnpH7Vxuxn3tiOn/Zw6p3FYUYWVd1lswEQ=;
 b=N3HvGRSGWQbnO7IwF0dB+lseAac7LAs4faIrR4hI3grgTZaWWKa4JU0OykZB3OFAkr
 Sa9ktUMroYOLG9PzD9ncRMGsEhectdZca4g15OZfRyqm4eqz05cMIfiVKFdpzdRWmYQc
 xKXK7f3coLRJjeLVV0NPMwgTR5hhFkDDk0Rl39jdjxTxA10ayAcidhKW1bAfszpst/JC
 JRz5hPWZw0Ci+v+cko4KggzYUu8oSUfPgfHr+UQlOKDzQkrsLrzlS+8G4sphjy63/iWe
 R9AVeyu33k9xEkqL0XWz/sktbDeN8aNqgs3yh7LYB2V9j9skuwtAnoUUkUPhka5E73yk
 aARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695598700; x=1696203500;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OeL4IVmaurnpH7Vxuxn3tiOn/Zw6p3FYUYWVd1lswEQ=;
 b=oz0cEMwoUfzSHHA0bZzmpqrgERLvEjWWdKoLCkrFzH96pAap9wNZql3rChdpXLLrs6
 sxS/YOzDG6nC9QrfdjqwTaYRsrWzwZe7FeSXQ/Y2pOjuNVRUEF2jhK6aAyfnST12hoFk
 GBdgadVets/lAlpospwFqN4fika5chNSjXJzfXzcpNkcV1r3A0HOz8LDqeg2K9L8WWl/
 nPWDj+aApTm4ntffLvHPdv6IwgFCnNwwiX4r3E/Gh5rVDTYbJnSNuKDWksNIotlQ656w
 94531GbXQUMFwXdu1UtpTp9sV/2XsNRtzxGp48Z7WAjFRBzQY9YOePsb9D9eZENa/dNH
 bwyQ==
X-Gm-Message-State: AOJu0YxBEawSM4NOVK4d4ULuOdPcaw+VI6LmITIbSr+a5yTZBBgYi5s0
 NG28JLt8fL0O1hci23kWO5LGO4neqT0b5RvarYPAdv7Lk+M=
X-Google-Smtp-Source: AGHT+IFlgfeC+VIx27gTPT4TFpqZaNe+8yysMHOsM4RKgjvUBllUtj1tmiAhmAyZIQ6CZEMmm7IHFaF0dJzUWNzClTk=
X-Received: by 2002:a17:90a:3d84:b0:26b:27f6:9027 with SMTP id
 i4-20020a17090a3d8400b0026b27f69027mr4616554pjc.1.1695598699786; Sun, 24 Sep
 2023 16:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAOYdKdjW6Ut3QCMWpu8W7TKuuv9OfehC7tdW7-vkdcN8ZbK3Jg@mail.gmail.com>
 <CAOMZO5BtN6xQJ9j35Wz4wH9p5Q=JoC2Ffb1aN-yrTzUeb0AvYQ@mail.gmail.com>
 <CAOYdKdjnVpt=YOrAzjKiaAZomB7=hgAHe1TE+7MM8PK3g+WjRQ@mail.gmail.com>
 <CAOYdKdirq-H+ZaBmy0sT05sL=C=cJWLixgJLsA5ES9PcwZrXyw@mail.gmail.com>
 <CAOMZO5CTG8bqNoP2XO=6VXXquutg-MFqBTbi9Y2q4Dcg0Mfftw@mail.gmail.com>
 <CAOMZO5ArFiQO=BWvDbR91XhADJ0ks4JTe45zOb+z3aaiED2gkg@mail.gmail.com>
 <CAOMZO5CYnkCC5pmG35+8qHqeCaEJwM3Z3eyoJaTrOMMWj5AWWg@mail.gmail.com>
 <CAOYdKdgLaAx8krbBZV=yaUGTwtf6cbgaTU3=+pRKJ4-w_V3_Sg@mail.gmail.com>
 <CAOMZO5DqKS2w1G3iKKGPS_piXx8JcGoWCFOqCQOoB524O9KyOQ@mail.gmail.com>
 <CAOYdKdjPrRT7F_LFf8YeafX1MWep_p91CFdwc-SH8+diCu+2sw@mail.gmail.com>
 <CAOMZO5BzrfvLDrtqBk1dmLqb9-GxzZs8nRVY7GxqCRY34pKg4w@mail.gmail.com>
 <CAOYdKdgyXi5g9zPNOCBtsrA8KV0L1O0Oyh4Ne-Q79Z=EgGs=zw@mail.gmail.com>
 <CAOYdKdhvKEaeyv5zhXiswuF-Kd6ee8FmdN8MoMS9=5VTWVgMXA@mail.gmail.com>
In-Reply-To: <CAOYdKdhvKEaeyv5zhXiswuF-Kd6ee8FmdN8MoMS9=5VTWVgMXA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 24 Sep 2023 20:38:05 -0300
Message-ID: <CAOMZO5DS2VHPKvVioSW=7fWfnrP63A6wdga6pFmFuSK2QF8gSA@mail.gmail.com>
Subject: Re: Trying to boot custom kernel on Wink Hub (i.MX28)
To: Rogan Dawes <rogan@dawes.za.net>
Cc: u-boot@lists.denx.de
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

Hi Rogan,

On Sun, Sep 24, 2023 at 5:16=E2=80=AFPM Rogan Dawes <rogan@dawes.za.net> wr=
ote:
>
> Hi folks,
>
> I eventually decided that I did need to figure out the DRAM timings for t=
he Micron chip on my board, but I found an easier way than actually "unders=
tanding what I'm doing"! :-)
>
> I pulled the vendor U-Boot image off the flash, skipped the appropriate n=
umber of bytes until I was actually dealing with a u-boot.sb formatted imag=
e (looking for the STMP signature I found in the compiled mainline u-boot),=
 then used the Rockbox project's sbtoelf tool to convert the SB back to two=
 ELF files, the SPL.elf and the u-boot.elf. From there I loaded the SPL.elf=
 into ghidra, then went looking for byte sequences found in arch/arm/cpu/ar=
m926ejs/mxs/spl_mem_init.c to see if I could locate them in the vendor blob=
. I did, right at the end of the binary, then converted bytes into uint32 s=
equences so that I could compare with the mxs_dram_vals for CONFIG_MX28.
>
> Did the compare and found a single bit that is different between the two =
sequences of initialisation values. Literally a 1 to a 0, and that is all. =
So I built mainline with that change, and an updated iomux_setup because th=
e Wink Hub v1 uses MX28_PAD_I2C0_SCL__DUART_RX and MX28_PAD_I2C0_SDA__DUART=
_TX for its console pins. i was hoping to see it boot via mxsldr, but unfor=
tunately, I got nothing.

Ideally, you should create a new imx28-wink_defconfig.

For a quick test, besides changing iomux_setup, please make sure that
arch/arm/dts/imx28-evk.dts also has the duart pins changed.

> How can I get the SPL to emit something on the console to confirm it is r=
unning? i.e. before the DRAM initialisation?

SPL runs from the internal RAM, and should print something to the
console prior to the DRAM init.
