Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE155C5AD49
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 21:39:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2E5482AFC;
	Thu, 29 May 2025 23:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="FpLoo0/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6846582ED0; Thu, 29 May 2025 23:39:50 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A287282AC4
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 23:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-70e6bddc30aso14528517b3.0
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 14:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1748554786; x=1749159586; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5qXDqzn0mqDFIHQDHwNd6ew1F9FV0GA35OW5v6V278=;
 b=FpLoo0/FDXFzYFE96X0YXX5AP+44Q56bqkL6PY4QW86kvXg/NXqy1zJ1TpTzSW7dJP
 ltHwlw/de5j4rNeZsyJ2AMgVQ5BMjnkVKWDHwdQhhygmxdBT/qOVTE+LI5hzqMff0mDy
 exmaYc35ocnOZacadYRSuJmsYueuCksVDkM3RiXGLZwZwBjHQRdlMtqW0cTsIvUXKhyo
 5RR8xP5oVIKQ25tPiRugXdupqw607BnErHYr+rYGjZdfFBMFV2RzZ/PkzuYLg4BKzvsR
 9iVDlNC1s7+eRhBOEVfItlCjM/0gUqy9NeuLLTvd3S882uKPr3wf7BCmAfDaQEp96vk5
 ad4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748554786; x=1749159586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i5qXDqzn0mqDFIHQDHwNd6ew1F9FV0GA35OW5v6V278=;
 b=Okd7LqRH1DO9LYoxnaUn08HJBAjSR/QNg13f6tmdarHZekRGCDDCChk+WOFCduM5OI
 m0rjv8TyrOC7ft6jCn/gakx0X3pLnncpYm+4U5/iu7BbcYorxxc8/pW/7BNQvi2XDRCG
 ETiVe53TYyoDUp2SzaL4MqsgXFMNwMyxRWw6FCvrSw/K1A1+4aDpPsMVWv9NgkySvFN5
 M88ASRDVYN9KjLiWzJbqu5U7NsYYHG9ig56V/tptAHUgw7ny6JQCxKtqudpy0cu5v5UN
 DrqZKjvA+89a9qn+WT//y8YUjRJdtB+9J5iF1YXtKP0iGVIq/2cVN9wkXx+TsNkluNhx
 2EJw==
X-Gm-Message-State: AOJu0YwPxJseggP7rS01fPpA6n5NOXFbSiP+hrHKJNW6y3bxWOJepgK7
 l9wJO6GtmBWcbb21LuRKo37jRelNo3BUwa6PMNJfPyn0kESj5b+oFLVKnHJUAOrVMJbLVRyMClI
 bP9/Alw+71p4XWIUqdF0/xz6U9T9wGBdggY7WWL4A22PvzT7cyz17p+Y=
X-Gm-Gg: ASbGncvI79/zodHQ+TqY+kDkuqZczjfuXyVpV7slyz2hSgxjBA13KKFF5BQ5gJAjLct
 x/adPabikj5H/dcRFmQFhDQjFS8cTocyVdsIN8LUh9NXg8FuasORmKbMo8hKrpIEZBmkS6m3Drk
 f9qwJCF8x5Oi/zrQkRoUGy8oeW2qoqL4ah
X-Google-Smtp-Source: AGHT+IGOPk8vwcyE4T7oeU17IvtFJ+F/0YLVUKF3vLDlJvGPX/C22glajCZFh3Hp0Is/Z83/9NEc2AlXzqTcGpsVMVQ=
X-Received: by 2002:a05:690c:6e02:b0:70d:ffaf:48df with SMTP id
 00721157ae682-70f97e1ce40mr17605067b3.3.1748554786315; Thu, 29 May 2025
 14:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250520084120.4175862-1-olaf.baehring@draeger.com>
In-Reply-To: <20250520084120.4175862-1-olaf.baehring@draeger.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 29 May 2025 14:39:35 -0700
X-Gm-Features: AX0GCFtxJjPzK7nxNYtFOObPmMSTZo-HExUHFtVP7GrMhMz_l2ZQHhKlKoekcSs
Message-ID: <CAJ+vNU1Ge_s4mEFYCn0TPhuKW5X1J-jcV3GyZqc_70GjgsqRtA@mail.gmail.com>
Subject: Re: [PATCH v2] caam: bugfix CAAM error on startup
To: Olaf Baehring <olaf.baehring@draeger.com>
Cc: u-boot@lists.denx.de, Gaurav Jain <gaurav.jain@nxp.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
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

On Tue, May 20, 2025 at 5:29=E2=80=AFAM Olaf Baehring <olaf.baehring@draege=
r.com> wrote:
>
> In rare cases U-Boot returns an error message when intantiating the RNG
> of the CAAM device:
> =E2=80=9CSEC0:  RNG4 SH0 instantiation failed with error 0xffffffff=E2=80=
=9D
> This  means, that even when the CAAM device reports a finished
> descriptor, none is found in the output ring.
> This might be caused by a missing cache invalidation before
> reading the memory of the output ring
> This patch moves the cache invalidation of the output ring from start of
> the job to immediately after the notification from hardware where the
> output ring will be read.
>
> Signed-off-by: Olaf Baehring <olaf.baehring@draeger.com>
> ---
>
> (no changes since v1)
>
>  drivers/crypto/fsl/jr.c | 30 +++++++++++++++++-------------
>  drivers/crypto/fsl/jr.h |  4 ----
>  2 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/crypto/fsl/jr.c b/drivers/crypto/fsl/jr.c
> index 8f7a821ebf3..edf678d363e 100644
> --- a/drivers/crypto/fsl/jr.c
> +++ b/drivers/crypto/fsl/jr.c
> @@ -217,13 +217,6 @@ static int jr_enqueue(uint32_t *desc_addr,
>
>         jr->head =3D (head + 1) & (jr->size - 1);
>
> -       /* Invalidate output ring */
> -       start =3D (unsigned long)jr->output_ring &
> -                                       ~(ARCH_DMA_MINALIGN - 1);
> -       end =3D ALIGN((unsigned long)jr->output_ring + jr->op_size,
> -                   ARCH_DMA_MINALIGN);
> -       invalidate_dcache_range(start, end);
> -
>         sec_out32(&regs->irja, 1);
>
>         return 0;
> @@ -243,6 +236,7 @@ static int jr_dequeue(int sec_idx, struct caam_regs *=
caam)
>  #else
>         uint32_t *addr;
>  #endif
> +       unsigned long start, end;
>
>         while (sec_in32(&regs->orsf) && CIRC_CNT(jr->head, jr->tail,
>                                                  jr->size)) {
> @@ -250,6 +244,14 @@ static int jr_dequeue(int sec_idx, struct caam_regs =
*caam)
>                 found =3D 0;
>
>                 caam_dma_addr_t op_desc;
> +
> +               /* Invalidate output ring */
> +               start =3D (unsigned long)jr->output_ring &
> +                                               ~(ARCH_DMA_MINALIGN - 1);
> +               end =3D ALIGN((unsigned long)jr->output_ring
> +                                       + jr->op_size, ARCH_DMA_MINALIGN)=
;
> +               invalidate_dcache_range(start, end);
> +
>         #ifdef CONFIG_CAAM_64BIT
>                 /* Read the 64 bit Descriptor address from Output Ring.
>                  * The 32 bit hign and low part of the address will
> @@ -283,28 +285,31 @@ static int jr_dequeue(int sec_idx, struct caam_regs=
 *caam)
>                 }
>
>                 /* Error condition if match not found */
> -               if (!found)
> +               if (!found) {
> +                       int slots_full =3D sec_in32(&regs->orsf);
> +
> +                       jr->tail =3D (jr->tail + slots_full) & (jr->size =
- 1);
> +                       sec_out32(&regs->orjr, slots_full);
>                         return -1;
> +               }
>

Hi Olaf,

I could not find v3 of your patch in my mailbox, which I think was the
version that was accepted by Fabio,

I've found that this patch causes a regression on an imx8mm board
(imx8mm_venice_defconfig) where the first call to caam_rng_read fails
here in jr_dequeue but if you call it again it works. With some
debugging added:
SEC0:  RNG instantiated
...
Hit any key to stop autoboot:  0
u-boot=3D> rng list
RNG #0 - caam-rng
u-boot=3D> rng 0 10
caam_rng_read caam-rng len=3D16
run_descriptor_jr_idx idx=3D0
Error in SEC deq: -1
caam_rng_read_one run_descriptor_jr failed: -1
caam_rng_read caam-rng caam_rng_read_one failed: -5
Reading RNG failed
u-boot=3D> rng 0 10
caam_rng_read caam-rng len=3D16
run_descriptor_jr_idx idx=3D0
00000000: ad 2e ad c0 2a 12 27 c4 65 82 66 19 be ef f6 07  ....*.'.e.f.....

If I revert your patch caam_rng_read works initially and on subsequent call=
s.

Thoughts?

Best Regards,

Tim
