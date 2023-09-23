Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57F4CE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 16:50:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06B78868D8;
	Sat, 23 Sep 2023 18:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SWvJlCSh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65C268691E; Sat, 23 Sep 2023 18:50:54 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5088C8641B
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 18:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-532bf1943ebso4687412a12.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1695487852; x=1696092652;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UOcSTJubMuAzL2SMa96kYurGjdVHB7MxGaVI+n7Ve1E=;
 b=SWvJlCSh2U05LlLm49/mdYlWD0N+xsyll0nL5DeK65gS8Vos9msHY5ubZruU6vOUpv
 HVlHESELdB+1Z+hzGjFtjwvgWOMFc4Nj/C2OcXDpS9/BoUuOHqsiKyeXIIWXFHRkc96Z
 02wFpDBYFKWaeNqXdiPNzpo1e60G5a55R/02Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695487852; x=1696092652;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UOcSTJubMuAzL2SMa96kYurGjdVHB7MxGaVI+n7Ve1E=;
 b=NKZth2XK1OLQlwAkfNf3ppK6sdrwEiPmpRKXUCzHtsKEdWsSD8RMhxfFmxWRyI5O4Z
 WTYh2n3yCoVyi+TL6JaGxNqo7V9hpymOU/jwkLI4V0/aZCXC4Nkip6enXQXUiYQ9LoMQ
 cI1ij5IsMHnWj/Bm9btoa/YqObzMRkyKdhwrwLUWOeROWRyU9PS1OlvS2+rLQC4MpDvY
 LAkGPQd0OqhW06XGOWrW8ZR5MkiTxW/tYmGwvFMZDtuYsQGBdReqLlJISc+LEP95He8r
 x87pXEQVMr9r2fUzbHViT5eTTHIfbqSRvFkuNzrb0ytC50NEtVskcw6ddP1vVpxHg3xi
 cUvw==
X-Gm-Message-State: AOJu0YxMDd8rBuSXf6Rhvkz4yEAfMrhul7ECvwO9j7Qaz/fA7zOIu7c3
 1RkSPQ7if5XKMWBojVuIGQx+PeJIwaKWY3CIiMlDYKf8k0tNLh427Gw=
X-Google-Smtp-Source: AGHT+IHF8baZT8Ihv02PO7pkeqJWCGjSIpcTsukk79X2NOu3+EADmTgRrjLTsOkzHun9TqxsAndcxE3xO8V5vM7kNlY=
X-Received: by 2002:aa7:df89:0:b0:52f:c073:9c77 with SMTP id
 b9-20020aa7df89000000b0052fc0739c77mr1912469edy.35.1695487851634; Sat, 23 Sep
 2023 09:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230922090856.920303-1-ada@thorsis.com>
 <20230922090856.920303-2-ada@thorsis.com>
 <b1d83292-c056-8759-aa33-da3e5ddf979b@collabora.com>
In-Reply-To: <b1d83292-c056-8759-aa33-da3e5ddf979b@collabora.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 23 Sep 2023 18:50:40 +0200
Message-ID: <CAOf5uwmTDN4nuNgKkmj_aKWORKAErio3su9cYoA5pH-knNWJYA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mtd: nand: raw: atmel: Add error handling when
 rb-gpios missing
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
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

On Fri, Sep 22, 2023 at 11:40=E2=80=AFAM Eugen Hristev
<eugen.hristev@collabora.com> wrote:
>
> On 9/22/23 12:08, Alexander Dahl wrote:
> > Adapt behaviour to Linux kernel driver.
> >
> > The return value of gpio_request_by_name_nodev() was not checked before=
,
> > and thus in case 'rb-gpios' was missing in DT, rb.type was set to
> > ATMEL_NAND_GPIO_RB nevertheless, leading to output like this for
> > example (on sam9x60-curiosity with the line removed from dts):
> >
> >      NAND:  Could not find valid ONFI parameter page; aborting
> >      device found, Manufacturer ID: 0xc2, Chip ID: 0xdc
> >      Macronix NAND 512MiB 3,3V 8-bit
> >      512 MiB, SLC, erase size: 256 KiB, page size: 4096, OOB size: 64
> >      atmel-nand-controller nand-controller: NAND scan failed: -22
> >      Failed to probe nand driver (err =3D -22)
> >      Failed to initialize NAND controller. (error -22)
> >      0 MiB
> >
> > Note: not having that gpio assigned in dts is possible, the driver does
> > not override nand_chip->dev_ready() then and a generic solution is used=
.
> >
> > Fixes: 6a8dfd57220d ("nand: atmel: Add DM based NAND driver")
> > Signed-off-by: Alexander Dahl <ada@thorsis.com>
> > ---
>
> Reviewed-by: Eugen Hristev <eugen.hristev@collabora.com>
>
> >
> > Notes:
> >      v1 -> v2:
> >
> >      - Only issue error message if error is not ENOENT.  If the node ju=
st is
> >        missing, move on without error message.
> >
> >   drivers/mtd/nand/raw/atmel/nand-controller.c | 11 +++++++----
> >   1 file changed, 7 insertions(+), 4 deletions(-)
> >
>
Acked-by: Michael Trimarchi <michael@amarulasolutions.com>

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
