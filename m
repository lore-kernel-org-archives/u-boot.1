Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF78EE64002
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 09:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEFD280433;
	Sun,  5 Apr 2026 11:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="q7Ml7tJ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6854E807C0; Sun,  5 Apr 2026 11:07:02 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ACF580325
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 11:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-79a2ee65171so43729517b3.2
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 02:07:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775380019; cv=none;
 d=google.com; s=arc-20240605;
 b=NHgNlFwjb8WcF7g0qWe+m5RE0SnMM59FVpVk8+Zu5kYlxJcFQUddiw5MIVrpq26DEF
 sNQSKYWajqOWD5Trp76ER7gMWoLF0W3y/R0SoSGHvS+9gLJg0svFMmg1yLL5zVa5S6gq
 //nJwZ2zyn1mYx3YbyxI54aChmlQ8ThhGenvSCNcz1hVqiU4h00HOd0gp5Q2sv0mSCaF
 9+8VLJXPjDxMY38+E/1ORnuWPdybxZSFWy9OQ03q6iVV8YYA3Oymp439RHAQtj67aE3d
 sVL3fBTGkQItaJeAauIwbKa3Lq+1rskllYEAn0sEky0YpM08F5F/CIqgfo5awut+DZt7
 2Evw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/iIi54Bt3Akd2VHSaXq/vxlwECxljWq+cTgwH/2D3Rg=;
 fh=BnpnyMJV8JwsLeyI2TPSjexZl4eVT43xfeL1DZOEHq4=;
 b=LFA7UxfUR0xpL2TKeNsP9wP0CuPBaedJe6tagwomdtgKHYGAkmQ+i9iigrpyCATQwv
 rS2ArnzgM2jgbMGvvp0hzr3yjz7OY7a8Az9HYOtGvrA+Lu7KNCu0s6AI2O/xvD77erBV
 PM0x6Swf4fLU1ZXKO/1q0ArHfcc1Jpavn/NDKhaBrwnzb//lqaUAGf5UVT3P6ZLFQ4HL
 0hjxieXOaL0TlKf9zr6FDZUk3oluYm7tHEASbBNWfMxqsn/8WtcCVStUnqLrOKvnc4wf
 kWiLPrVow9zWmTujxz9aLx1kCFotR9ujAWWTBuPUuWi+n5WtBi7okEmP94lyCn0WNePd
 UBVA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1775380019; x=1775984819;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/iIi54Bt3Akd2VHSaXq/vxlwECxljWq+cTgwH/2D3Rg=;
 b=q7Ml7tJ0LhI5CNk4r+oE/utHh88gfyiKhFatRlxstivOU3NRBrt3zd5TyX9NAM5jnu
 G+buoSZVDF/9BSj6WhSMiDXQq9goY852OuB5lBOIcghi3sQRD3kjWPqZ0xuxsGFTo+cU
 16V4G2x0448XBapoCjp1wlQPIWCT1e0mRGFzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775380019; x=1775984819;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/iIi54Bt3Akd2VHSaXq/vxlwECxljWq+cTgwH/2D3Rg=;
 b=QePeWRYBNNJxvCPZ98RrZj8f2Np/6ooMyrl4/+6wZC9ZPXoCZVBDeAkyv8VNTsakT3
 SgnSX1T43Sk72FhOPpDhW0VRModO51zxgZGpTYjZUTke9MGulWP2OOprV7pgsr8+yfWt
 oKQWVp5tKMJrWaYpHn4t1+6BkaTtT+4DS1GIwCJ1LM2IlEVu6ctEHVCtNbKDTfmdH0YI
 aDMRpJASjvBAVv1zlGvMZ1xgDGx+C+kqzvSiSSJ+jJ+eCsfVWFxWm5CfX4HrB0xNzlBS
 XUJ5yox3vgAbHRiwggCi6TIfNDgDIGbABQxIr1nbxYNVAHAKGw2WjY2oNGfizTM+4gn/
 yPyQ==
X-Gm-Message-State: AOJu0YzbNd7kTygFFMUNMlSl05zBxaNy/bbzWqyfpaFz1KUXT3z1BSGw
 nSJgO5iH1JIHJMfescfvpfGQnK+H6180fg5ldsFGW1b2Pm8lO4xEZWFjQvno233eQs43jVfRRYn
 2Yhr8HPCGap9ZQFVhg4R5LObfWamprL0CcXWdk0VCbZ7l2sBWIbkW
X-Gm-Gg: AeBDievn+jEIk4FzGuIFda+wbFzooxmubobSP2Q7cLc1xbCzEpqpmWcJhewteBL2Stg
 gdYyeQsEV2dxsRUyymuaOkQQiZ/vG0+pRSxuaoz47gWrucSi4GVs9UGx7xvrnzAI2YRk5KW6M12
 F8V811Bf0GXYAgva5uE2D8eeqcE5GAhSuh4vs+bP/SB45jWm5YE+QjWDpmz0dLO0ao7oNUX7CR1
 MsFVr5jmYy/nLcYaSuginYVmGxCm42e5iUAEbqjtc+cEdN/v1RW7jZKQhJghURRkJjsJy7iLrLj
 b26EZZYpRbLquyfEahlqVwT+039vYCV+Lwyp
X-Received: by 2002:a05:690e:d44:b0:64c:a0c6:da93 with SMTP id
 956f58d0204a3-65048751e2emr7395707d50.28.1775380018924; Sun, 05 Apr 2026
 02:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260403-winbond-ma35d1-v1-0-e2b08c4c5e35@bootlin.com>
 <20260403-winbond-ma35d1-v1-1-e2b08c4c5e35@bootlin.com>
In-Reply-To: <20260403-winbond-ma35d1-v1-1-e2b08c4c5e35@bootlin.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 5 Apr 2026 11:06:46 +0200
X-Gm-Features: AQROBzClL3_Qq5NWwiXaHS2wQOd8zVQV5CqeVZTG_9qWHg6NAzx_8H2MArwhK7w
Message-ID: <CAOf5uwn4bCjoCTQpirRfsWRyFn_y6=vPO3-SCzpOQ2t29RkCcg@mail.gmail.com>
Subject: Re: [PATCH 1/3] cmd: mtd: Prevent out-of-bound check
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
> The while() loops searching for the next "good" block is unbounded,
> which means in some cases when looking close to the end of the
> device (or during development purposes) this check may lead to
> unexpected behaviours.
>
> For instance, I observed the SPI NAND core complaining because there was
> a single "target" (as in "die"), but the core was selecting the second
> one, which is simply impossible as it does not exist.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  cmd/mtd.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/cmd/mtd.c b/cmd/mtd.c
> index 7f25144098bb..d3289ab5edbf 100644
> --- a/cmd/mtd.c
> +++ b/cmd/mtd.c
> @@ -559,8 +559,13 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag=
, int argc,
>
>         /* Search for the first good block after the given offset */
>         off =3D start_off;
> -       while (mtd_block_isbad(mtd, off))
> +       while (mtd_block_isbad(mtd, off)) {
>                 off +=3D mtd->erasesize;
> +               if (off >=3D mtd->size) {
> +                       ret =3D CMD_RET_FAILURE;
> +                       goto out_put_mtd;
> +               }
> +       }
>
>         led_activity_blink();
>
> @@ -573,6 +578,11 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag=
, int argc,
>                 if (mtd_is_aligned_with_block_size(mtd, off) &&
>                     mtd_block_isbad(mtd, off)) {
>                         off +=3D mtd->erasesize;
> +                       if (off >=3D mtd->size) {
> +                               ret =3D CMD_RET_FAILURE;
> +                               goto out_put_mtd;
> +                       }
> +

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

>                         continue;
>                 }
>
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
