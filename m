Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7C410ED67F
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 14:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1BCA83C14;
	Fri, 27 Mar 2026 15:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZKFIibMi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CD4F83FA3; Fri, 27 Mar 2026 15:42:47 +0100 (CET)
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com
 [IPv6:2607:f8b0:4864:20::132b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC9F281E18
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 15:42:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso2056518eec.1
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 07:42:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774622563; cv=none;
 d=google.com; s=arc-20240605;
 b=MilaHu0vZPW9BNsDsiHQQKw8UR+JXOyNs7d1gsGyCfuoIbZ8MRN27rWPoX6PQ8Ob/F
 d/7LZKf6pXoqBdg94mfjR2unMrodFrU44CU+v4xx73fA1IiCgV3wsV7reMxo8kfJ3UQE
 bWVYPShaeg51lEyqMPYhD8MOzZLzUqS/1bLNy3pDGr1SOGpHlzT4q/JG7ZrxekCiW0hQ
 gBWxI/FcsMNv0Cd8qj+np6ofT1Y0j/Uads97Cq3ieJIKIuAk1kJ9LCLLVaENMmn416v5
 X/ymy7TwoOtTjnIY3+1wJYQwIXx4XylHRNb4FizmEQHKNACN/HY0f24m5sRTCK9XGyab
 7R+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=q9ZbE8p0V2KuUQJFstzIZyeYtHzYC7ToXP9cNUmWNR8=;
 fh=5QppDVkVaEE4HpadMM2S6Idz5qL8IUYm9yRuQJdkaUI=;
 b=K2EpNQ9S31vuqcdf1u8XV2V9WDmqn+6QLRXsi0NFcZJYMi9mRZYFAcNYBKam6IilGV
 dKfdXBA4jcSxE8A18N0T9fj0cRupBIwaNToQ0ady25oiSadSNHbFqV+5U154c8jFKTgx
 LUgK+N1UNKA82LTDDIrIdTF3WvaH1gQVwPRPNPS/R/4ZJJaSFDX4+ypaVuwXP30soTJ3
 3y4/rl2Kyio6eDNH8Eog9nv1EuFqzBbCHLVpaQQNxo+njQKrcBnVkfv5r+yz1/yj+mX+
 77assfqe5HrQMMUoDYRr33fxfWxePJo/XKW4NOmgsmfpIXebxOl2kwT9qvsWvTy/nn21
 3o7Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1774622563; x=1775227363;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9ZbE8p0V2KuUQJFstzIZyeYtHzYC7ToXP9cNUmWNR8=;
 b=ZKFIibMip0FEG56iUC7wK9n01a61acxnIej4n14Ar96LmnM3sK60KBZom2lwE68Lyw
 3GQv/pKZWgT+IisIOn7GZgxVRj+fZBb8K16nR8Ev2YDjeMRN2pX210yQPqYLjjx5O1BT
 Sfc9YMNIo53iQ6ZuIGJ7ztaruyNy/uAXKTwQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774622563; x=1775227363;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q9ZbE8p0V2KuUQJFstzIZyeYtHzYC7ToXP9cNUmWNR8=;
 b=E0P40Hz1sNopKdYFGiznnIxRJyPLL8YKpUcwUIvtZ4gp+wyRaXFLJKnsS728w7xnbv
 oJYG+VFvZUy4J0DBGD3MiZaSrrIEaLC4W1hqxQx8VobG4P19VDMrh3vJXiJwEMWoN5fc
 39jmvL73+oF9SiH5bg6cPJfFeT6rzWKMeHX2vFNAzqGMoex1ThYd6f+d92K4+k7mcQO5
 AMiFBzb9zcOgWhMZk/AIzYqC198E6cvbGUQqPqp15JLoXg4lZqwRHa2K8LO53DtRgYcu
 nmUXmMI/3hb4+LPIP4j3OdbGbD1hfrT4jsghrwWDm+3ekb7wkNLNCeuz2r8IZwTLMEAO
 WQiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkrwNu9xu+M2zJr9jim8GW5CUzcQb/yGuOsaZuU/E6B/lzBplyPl4f++wX4ad3T1KSYHetJms=@lists.denx.de
X-Gm-Message-State: AOJu0YxHFezFzDSJEMeWS85cXWPiR5VUuxqYuC3QTbOUZKw5BSm7jUgG
 QjKEpQvQoevD9QXJ3KXhQ/OJ5SdeJN5GBJlf67FpgG7d8FYK5tZg+a7cBWMI6sEIDWl3dCb89DU
 rT/584IDiMQoWJ05paCVo+UJ7TtVifsevhrKiPO6acHtgLKTdVQDIr+IOVA==
X-Gm-Gg: ATEYQzwNCDaxmKFs9By/F49pN5scwrZBH5zS3+thjQSDE1ySsfrbs47+8iIOuX4HDjV
 QhnqNOwd62SlRUVMH6mD0DFPVtCr5nUxoOzhUY0TtngBRWfuOzrr54+//zAqpjxIJnGDq9EYdtO
 YJhkQG7Kn5hj/7LXh/uEC08qd07Pep1qNWp6tblOJjAX+7awMX/UF4WG306K54waEQ+T6s6nLee
 DqV7pW+meX6yO9NC8BDD/QdeRzo3jRp6SNN5EXyFg5qdqFYgrOL3gc/Qr7tiOkjYSxNqCEXANiI
 M2yykVtYcC0wq+to1a1p0Yt1cngJAditJSdpOe1nsJiBo6fjFQ==
X-Received: by 2002:a05:7300:a947:b0:2c1:6eda:476a with SMTP id
 5a478bee46e88-2c185e399ecmr1722527eec.26.1774622563094; Fri, 27 Mar 2026
 07:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260327140508.3680105-1-richard.genoud@bootlin.com>
 <20260327140508.3680105-4-richard.genoud@bootlin.com>
In-Reply-To: <20260327140508.3680105-4-richard.genoud@bootlin.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 27 Mar 2026 15:42:31 +0100
X-Gm-Features: AQROBzDROilwEyxI1cuIFcoaXksGbR1VE5AqjJ0OT1Yvm2nJ9HVCHjNuqzks9KE
Message-ID: <CAOf5uwnYuZi46ZKijOJ-PLt_55Nwg9BQ5w+3Mtu+VxNvrER1Qw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mtd: rawnand: sunxi: clean sunxi_nand_chip_init()
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Boris Brezillon <bbrezillon@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
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

Hi Richard

On Fri, Mar 27, 2026 at 3:05=E2=80=AFPM Richard Genoud
<richard.genoud@bootlin.com> wrote:
>
> In sunxi_nand_chip_init there's quite a lot of kfree/return, it's easy
> to forget a kfree(), so use a goto/kfree instead.
>
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  drivers/mtd/nand/raw/sunxi_nand.c | 41 ++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sun=
xi_nand.c
> index 9fc9bc5e0198..ecab9ebc9576 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -1600,21 +1600,20 @@ static int sunxi_nand_chip_init(struct udevice *d=
ev, struct sunxi_nfc *nfc,
>                 if (ret) {
>                         dev_err(dev, "could not retrieve reg property: %d=
\n",
>                                 ret);
> -                       kfree(chip);
> -                       return ret;
> +                       goto out;
>                 }
>
>                 if (tmp > NFC_MAX_CS) {
>                         dev_err(dev,
>                                 "invalid reg value: %u (max CS =3D 7)\n",=
 tmp);
> -                       kfree(chip);
> -                       return -EINVAL;
> +                       ret =3D -EINVAL;
> +                       goto out;
>                 }
>
>                 if (test_and_set_bit(tmp, &nfc->assigned_cs)) {
>                         dev_err(dev, "CS %d already assigned\n", tmp);
> -                       kfree(chip);
> -                       return -EINVAL;
> +                       ret =3D -EINVAL;
> +                       goto out;
>                 }
>
>                 chip->sels[i].cs =3D tmp;
> @@ -1640,15 +1639,13 @@ static int sunxi_nand_chip_init(struct udevice *d=
ev, struct sunxi_nfc *nfc,
>                 dev_err(dev,
>                         "could not retrieve timings for ONFI mode 0: %d\n=
",
>                         ret);
> -               kfree(chip);
> -               return ret;
> +               goto out;
>         }
>
>         ret =3D sunxi_nand_chip_set_timings(nfc, chip, timings);
>         if (ret) {
>                 dev_err(dev, "could not configure chip timings: %d\n", re=
t);
> -               kfree(chip);
> -               return ret;
> +               goto out;
>         }
>
>         nand =3D &chip->nand;
> @@ -1669,10 +1666,8 @@ static int sunxi_nand_chip_init(struct udevice *de=
v, struct sunxi_nfc *nfc,
>
>         mtd =3D nand_to_mtd(nand);
>         ret =3D nand_scan_ident(mtd, nsels, NULL);
> -       if (ret) {
> -               kfree(chip);
> -               return ret;
> -       }
> +       if (ret)
> +               goto out;
>
>         if (nand->bbt_options & NAND_BBT_USE_FLASH)
>                 nand->bbt_options |=3D NAND_BBT_NO_OOB;
> @@ -1685,34 +1680,34 @@ static int sunxi_nand_chip_init(struct udevice *d=
ev, struct sunxi_nfc *nfc,
>         ret =3D sunxi_nand_chip_init_timings(nfc, chip);
>         if (ret) {
>                 dev_err(dev, "could not configure chip timings: %d\n", re=
t);
> -               kfree(chip);
> -               return ret;
> +               goto out;
>         }
>
>         ret =3D sunxi_nand_ecc_init(mtd, &nand->ecc);
>         if (ret) {
>                 dev_err(dev, "ECC init failed: %d\n", ret);
> -               kfree(chip);
> -               return ret;
> +               goto out;
>         }
>
>         ret =3D nand_scan_tail(mtd);
>         if (ret) {
>                 dev_err(dev, "nand_scan_tail failed: %d\n", ret);
> -               kfree(chip);
> -               return ret;
> +               goto out;
>         }
>
>         ret =3D nand_register(devnum, mtd);
>         if (ret) {
>                 dev_err(dev, "failed to register mtd device: %d\n", ret);
> -               kfree(chip);
> -               return ret;
> +               goto out;
>         }
>
>         list_add_tail(&chip->node, &nfc->chips);
>
> -       return 0;
> +out:
> +       if (ret)
> +               kfree(chip);
> +
> +       return ret;
>  }
>
>  static int sunxi_nand_chips_init(struct udevice *dev, struct sunxi_nfc *=
nfc)

I need to go a bit in the code but seems that out can happen even if
there is no error. It's
not so common to have if (ret) if exit condition in case of errot

Michael
