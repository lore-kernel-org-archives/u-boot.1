Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BECCD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 13:24:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CADD484873;
	Tue, 26 May 2026 15:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="sKP6ZRzs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9559684874; Tue, 26 May 2026 15:24:33 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01F358486D
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 15:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-65dd9b25829so8255426d50.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 06:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779801870; cv=none;
 d=google.com; s=arc-20240605;
 b=D5DQd+xr3nvvqA6bIvHR3ClX6rU3sfXIOPjQpKLrV65d5L98AZKb4naQlDrEzVNHgD
 snkuXr9LbGUA8T/C45Se7FEw8B5kTvBU+rnWVSB3JJZP1YI9JhoR1yde66p9p3A2Zsez
 jjkplJ+24AKnPXWGgpbFe6Q2MJdXGQP8oflxE2X92vw854q4+kLms5KekWLmR8tXeNe7
 tvUDVfLNkKsC6hcoWnERkI2BqxbXsLcMTQVKzq3H6D2ptmF+7PTpB6EtprD0xu7ZoZHi
 tsO2Ftj/eU/2zvp3PmVlC+H9Uskv7HJNO98olmwoKk4i+zcRHdFvrfZ5gEMIOGhc60g0
 FRuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OnwSgGcMGHisN3Yotf0SlOFmE2QYYQ6Q8T/msr+BIL8=;
 fh=QGDz4bcnAs99RSz2sJkmmJbBMGzaiMk9wVwjyaT0mUs=;
 b=EnOTBIeanMuubzw+dFac4Y2p6GtPCztXIZhZxrb8RZ6NH8z5MKwchmI3mxRy2Unf73
 X3Cl8/f97c7QlqydUXTAIEE9Dq48PfAKNmx+TjLFMX7Gh0NQaYDo5n9dIDNNw7VXkA8u
 z9uaOtQ4+0bhuUXm7oQgdgglHB6qFIuA8rldg/kKF+2opMGuLObMoIKHIPIbk7WF8otX
 JsJmoeVzeNrERTCpQUpSPYjuAtn6jbLrkLeOPCeZLLITSfmuYyy5UsG6/0gplVDOWHyk
 k+m1kDRFABg9bKDoYsjkAfB1SYU/KqAl/EW/61UXKNc8/kqhOXACBBtCgELZfQ3JYc7A
 Vcaw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779801870; x=1780406670;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OnwSgGcMGHisN3Yotf0SlOFmE2QYYQ6Q8T/msr+BIL8=;
 b=sKP6ZRzscIBxGdtEgKaAfmlwG7vxcG4tuJQf53PPEgOHDVEFYgY3MmjdBAIM7snioJ
 IEdVE9yEdiy3i/NsRgZBV/7fWl1ltaOIZjrZKR/JZi8eD1pOfb6BNaj/xrXJDnUGVeYq
 QXaXXcMpNaOLqHfportBq7aMU6BxyJ4pe2dqGbzFSTIJjaA6grmgUDeJojDSdYvLnKmF
 X7CL3U4hx7vkbNICR6hqXRpc5wJQKz5Vry1IKN/Tzy4NINzXuTM0iVvNEYyo8WK+9mvR
 VLEZY6J7TysODJCqasXtIAxb514tK/D8Qs3v9OI9VRRPHicv5T6obF0uMMAWHasuTXTm
 uNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779801870; x=1780406670;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OnwSgGcMGHisN3Yotf0SlOFmE2QYYQ6Q8T/msr+BIL8=;
 b=mWCtLvtiK+P6dDvlhoZbYgZYV0G108SG9PZ3VG3D8rJeq4bpRlJooz2eBA2tr5gGzt
 kT1whPb3Tvb8MtsGbT4ZxDl5T5xnUQwY7g1Sr5TuiATMzYYywMQkPqV26kBUDmpsLSoy
 HfKk9iyIoE/tnMt0EsaLLbZyLiKdD7gL+QtldVUTFB0WjaYkAE/tDtXN4wlgrmEy8jP7
 c2MMnw7JcmSTr+qYlIiXmY2ynXTdRNWrWedWh/Kp2spzEwKNjBlSSH59XPjcnt8vjqAO
 9phqzpISFHHJvFq/oho8jFoP+Ep4ts8lFTcZ/Y0PHAp4Tl1WSE9Rw5HillXoTEYQO4y1
 wqdw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qidb64dx1FMkw3E/sMFxmiu5Dz0hdbOgINrsz8YNlTDZHLCfoELROrdDHGbLveEq7X8q9Wc0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7YHYHCLZ6nYtYwpombSaWNqnhpFNIG14MDGt/mF/POsoDabOv
 7ICXMUu7BLxRFVdXzwk/AS2gtO8MgqlLat6mTWT2oChHIL8VshzBw7/XbaR8eBOo7SVMG8Qveo8
 7LZmWL9z7DaF/PoG84dcZuW5BaciX1l6MI/b0cYtLBg==
X-Gm-Gg: Acq92OFWERamspLAaoz32sGMCFoZYXXSv31P/HoyGUarTvz9M4q+4k3I3FmH1ESuYAF
 bB6ArNYuCeWdqxfxqyDsm52KDpGzovgy6L+JNhquEXAym9emDSENSa3E4Jthd4NLEH3htFXhXcg
 Czwv0fAHxRlADeCJXgIXHGAGsO9QBLllO0mJZuSE8/Z5oD3TIgCymCrUpnto19HsRKjOf9fKHyR
 4+c/1NW0C9sTTqFkJjR5SSPzhq2akWslmcCtO8D5nns26IGqDOnPknKXxwQzhnZVuditbO0pk6Z
 HqmyxcPjkbB5zNK0pD+KJdW8BoBLrROHme+IAkwuK/lDie3/RBKDicKDav1wPIYa3i8=
X-Received: by 2002:a05:690e:4293:10b0:65e:c81:3a6c with SMTP id
 956f58d0204a3-65ec9643f70mr13597869d50.15.1779801869763; Tue, 26 May 2026
 06:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260520-b4-k1-spl-pinctrl-spinor-v2-0-8d25db98ac8e@riscstar.com>
 <20260520-b4-k1-spl-pinctrl-spinor-v2-6-8d25db98ac8e@riscstar.com>
 <ahNs0lme0ya2zolV@aurel32.net>
In-Reply-To: <ahNs0lme0ya2zolV@aurel32.net>
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 26 May 2026 21:24:18 +0800
X-Gm-Features: AVHnY4KUvNVxFqE2xQjpjNX22CHqs5UzjjLC4cxCPcnfSFP-oaA3MrwH5NkU3sc
Message-ID: <CAH1PCMaX8rnqD1pb7n6aCK_13JY4412tf0AWDiOJ=bQvhZNYgg@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] spacemit: k1: Add multiple device tree support
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>, u-boot@lists.denx.de, 
 u-boot-spacemit@groups.io, Vignesh R <vigneshr@ti.com>,
 Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, Yao Zi <me@ziyao.cc>, 
 Anis Chali <chalianis1@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
 Sean Anderson <sean.anderson@linux.dev>, Heiko Schocher <hs@nabladev.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Philip Molloy <philip.molloy@analog.com>, 
 Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Eoin Dickson <eoin.dickson@microchip.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Guodong Xu <docularxu@outlook.com>
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

Hi, Aurelien

Thanks for the review.

On Mon, May 25, 2026 at 5:26=E2=80=AFAM Aurelien Jarno <aurelien@aurel32.ne=
t> wrote:
>
> Hi,
>
> On 2026-05-20 06:45, Guodong Xu wrote:
> > Enable multiple DTB support in the FIT image for the Spacemit K1 SoC,
> > allowing a single U-Boot binary to support different board variants.
> >
> > @@ -363,3 +360,32 @@ u32 spl_boot_device(void)
> >  void spl_board_init(void)
> >  {
> >  }
> > +
> > +int board_fit_config_name_match(const char *name)
> > +{
> > +     char fdt_name[I2C_BUF_SIZE];
> > +     int i;
> > +
> > +     memset(fdt_name, 0, I2C_BUF_SIZE);
> > +     if (!strncmp(product_name, "k1-x_", 5)) {
> > +             snprintf(fdt_name, I2C_BUF_SIZE, "%s-%s", "k1",
> > +                      &product_name[5]);
> > +     }
>
> I wonder if any normalisation would be better in board_init_f() as
> board_fit_config_name_match() is basically called for each possible
> board. Same for the tolower() loop below.

Agree, will move both into board_init_f() in v3.

>
> > +     if (fdt_name[0] =3D=3D '\0') {
> > +             /* set default board name */
> > +             sprintf(fdt_name, "k1-musepi-pro");
> > +     }
>
> I am not sure k1-musepi-pro is a good default. The experience is that
> the Banana-Pi F3 (known as k1-x_deb1 in the vendor code) doesn't  have a
> product name defined in the TLV EEPROM and thus should probably be the
> default.

Thank you for this observation. Agree.

Will change the default to spacemit/k1-bananapi-f3 in v3 so a
BPI-F3 with no TLV product name falls through to the correct DTB.

>
> > +     for (i =3D 0; i < I2C_BUF_SIZE; i++) {
> > +             if (fdt_name[i] =3D=3D '\0')
> > +                     break;
> > +             fdt_name[i] =3D tolower(fdt_name[i]);
> > +     }
> > +     if (!strcmp(name, fdt_name))
> > +             return 0;
>
> I am not sure that all the vendor product names will match the linux dtb
> names, so maybe just using a table to do the mapping would be better.
> Anyway, as long as the musepi-pro is the only one supported that should
> be fine.

Agree. A table will be more flexible and easy-to-expand. In v3 I will use
an explicit per-board mapping:
  k1-x_MUSE-Pi-Pro -> spacemit/k1-musepi-pro
  k1-x_deb1 -> spacemit/k1-bananapi-f3
  k1-x_milkv-jupiter -> spacemit/k1-milkv-jupiter

, falling back to spacemit/k1-bananapi-f3 by default.

With these, tolower() will not be necessary.

BR,
Guodong / docularxu

> Regards
> Aurelien
>
> --
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                     http://aurel32.net
