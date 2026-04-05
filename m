Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22347E64002
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 09:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C82A80433;
	Sun,  5 Apr 2026 11:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BXuEKpMx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6155F83C14; Sun,  5 Apr 2026 11:14:16 +0200 (CEST)
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F34280325
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 11:14:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6501e465a8eso3349142d50.1
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 02:14:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775380453; cv=none;
 d=google.com; s=arc-20240605;
 b=VXT+KG8hBfpS2Lona7tQ702a1CiwCprpIP1lu6tVqr3MOalohRZc544Ujt7ZCTGf7P
 2uSKTIWtJHGdnDp6J0We3kM2CHOZf8O6A/4b4iJrzvntg8NOU43BVNXPjpQL3m87twbh
 6d+zbOwRle2V1fiwvv7sBXx7ig1dAygfLe5h3hDmHwNbx/lehqRqzWsXcMr18f9uP6Mr
 IvNjLpLmu7bF26/BXNK3A7JfXWrfTm1TW+PS/I8tc7DPG5/gZR/ylXxf/pQCAyq2+yjd
 GGswW6UzMuMef4UsuNHbFMVTnOJ2CcEGZf40lyp8M1fJvKIvc/H0c0OqMH1ds3TjhvkP
 rxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WGkDRaOKzqC5piiGkrX/4nUZcpWRZnFtO9KJK5Rs+0g=;
 fh=BnpnyMJV8JwsLeyI2TPSjexZl4eVT43xfeL1DZOEHq4=;
 b=CsBJ41PKmIB1bnQf9awRjXabKH9dC1rxA4Ovt+NHegp/1TCeqBux1v3Fdj7S0h9rBF
 9tpYGf6xfLScHPePKqWIMHq7VwxHMcZpgF6bCzEaQKfzxz5m+nKIx7rRq0vGKiM3Apgg
 jalEpOkjXZWfujsS4rWFEegGiXy/ZOtn368/T8JeYKr0STwEOCyieDura2U37fF4VeNO
 dbBHsrVcRcAkJM3gk+bIifMZwe4Oo+Zd7+Rzkxrn3pzU3rOgDMUtis4yKwmBB/t/qboP
 CHMuVSA7J+0a3GuTvFmwEUYLVupXodpxGyXyKMRCVQd3Wpk4pGG5O1njvuw0vOIKjWBh
 Q6aA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1775380453; x=1775985253;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WGkDRaOKzqC5piiGkrX/4nUZcpWRZnFtO9KJK5Rs+0g=;
 b=BXuEKpMx72G9UuqH7cYlBHtAkM6PRodVDofRh+GnNewcZgnPUeh5TrEZWJhHc1Dv6Y
 OtNoM9ZTWbbfFIjZX+wLj7KDXVZWfXOXjYFVD3tz7F1Qwdnzt+G9Yh8/JqubnRssteC2
 F76MFcpD8Mpkb5ADZEijpSuxd+TMXixpO8gtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775380453; x=1775985253;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WGkDRaOKzqC5piiGkrX/4nUZcpWRZnFtO9KJK5Rs+0g=;
 b=YNgISvzo4/O/5/Q7wCoOfinmsFBSkqoFG302uOu6LLEvx2UQE+6yV0I2Hgmkb7daak
 gpDqSTxCcOZspFvH8ighPkgrnNNZfkcCumieC5TXH2+k9YAMR7hKbLJ2BDsW9RE/y0+J
 CiYiqAdrxihlOGFay3C3kJ9HCJGs0a5CUIlDWe1jxdYke4NYz9DxGoX9CZtLT0Zl/F/O
 Meaq2jqhqrzeHMwA7N0cX1QujEUeWY+RYRunBX/Qz1ylEyv6CqiX0WiiOvlZWrvgBpu5
 6DCT6DSybKrO2Jh8si7UouP7eX4VeP727osd0F0J25sL97LF4tH6cUl5URm5keKfangv
 NbJw==
X-Gm-Message-State: AOJu0YwAvHsTBnS4QCblVfZ8it0jk51FxOhfyJxKa+qSio0O18Z9QRjf
 ZfS5FTzQ+g88BnNbuZ4B/eVmkMXE20m1s4GEOcDXWoBbf7tbvQOVrxgqDJlNh73tL05vTyOs7Yd
 GyR24yd2IURLZ3bZQGMcuDKjw8MYU/OFqgoi7q7OWUQ==
X-Gm-Gg: AeBDiessl4BNaZWym1jCESj85yOTLC8ozjSZFddyVrsZe6Nf1Z37CAcTHDJg2j9X5Fv
 yqj/2w8UUB81rGhvthuMVv/ptty/5slFBT0IGnpSyOkWoIyx9n85Y3xh2I91ZohAIDpmmHsy5Jg
 FrWqDfkRUWFqD3KvRk3qb01bJU1QxncCtpIKJRHvUSF3+/V6ylcldNu9zB/+5YEYAGGzzfjFtnz
 89Rh0MtF4UXXDxqlXKurI+gm/+DEhQCWRHPG0KqTXHpXy4a228NOJIE+0LeZxB3OUENBcNtL882
 eo82AX7AQ5A4Z6U0LQK8cbAzyZgD9FhngilP
X-Received: by 2002:a05:690e:bc6:b0:650:1d03:4126 with SMTP id
 956f58d0204a3-6503d735d1fmr9906195d50.2.1775380453008; Sun, 05 Apr 2026
 02:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260403-winbond-ma35d1-v1-0-e2b08c4c5e35@bootlin.com>
 <20260403-winbond-ma35d1-v1-3-e2b08c4c5e35@bootlin.com>
In-Reply-To: <20260403-winbond-ma35d1-v1-3-e2b08c4c5e35@bootlin.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 5 Apr 2026 11:13:59 +0200
X-Gm-Features: AQROBzBX0y04TOT1c3bvZPxP2SKS8CeFeXUIPi81122PwYWRGTmofHhE4pvNA7Q
Message-ID: <CAOf5uwmq-KodpbD4E4PsZXBAGsxLLPaFgRtr969f03=0_aL0+w@mail.gmail.com>
Subject: Re: [PATCH 3/3] mtd: spinand: winbond: Clarify when to enable the HS
 bit
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: u-boot@lists.denx.de, Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Steam Lin <stlin2@winbond.com>
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

On Fri, Apr 3, 2026 at 6:17=E2=80=AFPM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
> Above 104MHz when in fast dual or quad I/O reads, the delay between
> address and data cycles is too short. It is possible to reach higher
> frequencies, up to 166MHz, by adding a few more dummy cycles through the
> setting of the HS bit. Improve the condition for enabling this bit, and
> also make sure we set it at soon as we go over 104MHz.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> This is a port from Linux.
> ---
>  drivers/mtd/nand/spi/winbond.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbon=
d.c
> index 79c3354efb65..accb46dfeb03 100644
> --- a/drivers/mtd/nand/spi/winbond.c
> +++ b/drivers/mtd/nand/spi/winbond.c
> @@ -261,16 +261,19 @@ static int w25n0xjw_hs_cfg(struct spinand_device *s=
pinand)
>         u8 sr4;
>         int ret;
>
> +       /*
> +        * SDR dual and quad I/O operations over 104MHz require the HS bi=
t to
> +        * enable a few more dummy cycles.
> +        */
>         op =3D spinand->op_templates.read_cache;
>         if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
>                 hs =3D false;
> -       else if (op->cmd.buswidth =3D=3D 1 && op->addr.buswidth =3D=3D 1 =
&&
> -                op->dummy.buswidth =3D=3D 1 && op->data.buswidth =3D=3D =
1)
> +       else if (op->cmd.buswidth !=3D 1 || op->addr.buswidth !=3D 1)
> +               hs =3D false;
> +       else if (op->max_freq && op->max_freq <=3D 104 * HZ_PER_MHZ)
>                 hs =3D false;
> -       else if (!op->max_freq)
> -               hs =3D true;
>         else
> -               hs =3D false;
> +               hs =3D true;
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>


>         ret =3D spinand_read_reg_op(spinand, W25N0XJW_SR4, &sr4);
>         if (ret)
>
> --
> 2.53.0
>


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
