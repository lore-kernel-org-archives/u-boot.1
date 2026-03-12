Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043B1105A583
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 11:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66FC484181;
	Thu, 12 Mar 2026 12:59:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HjnkJwn+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 091FD8418C; Thu, 12 Mar 2026 12:59:34 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E870E84167
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 12:59:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-661568ce781so1225256a12.0
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 04:59:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773316771; cv=none;
 d=google.com; s=arc-20240605;
 b=erB3BXutMn8Pze13xxTCnOtlJivChe30x3qehUwxl64vKUfJjYTP5F/XvyXlhrz4ga
 rd1tJ9Z/GMZIFpG22sfj6vzTkOg9X38bYMpudgXxP9Zu7S/G/e29QHG49NMI8tJovWWG
 HNyC65iDh+FpzdSXUOWXXuHOP8CSmE1saHKsI4Wj4MwLrPl87wAuN2bZ9ZOYo0x1p7X2
 XCJQeIknMyjsxhosbY31yp4eL/nNp5W4ZVoh/ARomtmlE0f5Lnc9S3xcz6VClQlGTEsr
 CAuwxQmCOy3dPpU+cB6gGgtPI7tJpKAVflM5wbqoxCcXmPntf3HIbknQOaTtX7sAvfsH
 XjsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VxZLx/wxYOrOyyjRnZZ99A+gN8EeSIhBWnj/izchBVI=;
 fh=G2KK68ynvVGi6EZghyFZfcuHAii3a69ZpTr1p70pjGc=;
 b=JTi9wzJ1EHU7SoAe56igo4iETOaaBkzTGbjKhxT5mSMFhp7MuceAVX7WlmCyjVpBZG
 NQ2eOWQni+LAHgswviOP+5ZLNnbQ4BCvDs7+cFnVxpYqtkOfAv6romZxf4XKhhfLulR0
 CciM3boIrXid212Tb9UOqQZ8auKrYwfp6zFEVK9SjfHizvXDiiKQ3jxPixuEDfO5GbPl
 AIBvkQqGCZPzp08lISCsx12J0ysyQGIwVTTiuEsQP7doWWjG/aCHZFhWtW9XLsJxZIi/
 5vng5LIyyKqjsLBUZP0zVwaofpaMPfEls9KtuGCeEwxeMTzLVPXql7P5jZMBwmtbir8i
 LXRA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773316771; x=1773921571; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VxZLx/wxYOrOyyjRnZZ99A+gN8EeSIhBWnj/izchBVI=;
 b=HjnkJwn+vYUyAYzJo8BGxSy4nCqKrswY7ssJna6PJ1WzBEUIHCEbq+/PTFriH1NvQP
 fKTUxGcWQee0F7HV/sqqgXU3vpaMxTx+nODxNosJvsnj4BitJlQ9Axg+2GGNtv3H1NM0
 Ken5vcxS/8J/nZ+CYJhs5yo67ffT9neUw34FweAeKRQDzxNKT+Xr8lsOgnJyNsxEZCWW
 DbZv1+eApUXr28sLnYchBeAFg8yzazjvLdT78065YbECBqeQ1ELX+t9QTIk1SnjjyfMy
 bkeA7vjS7ncHhFf3sAKq/mjH+qC/FurtMrNuPoFnlfyngUMFnEND6I72nFu8keSa3I41
 QKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773316771; x=1773921571;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VxZLx/wxYOrOyyjRnZZ99A+gN8EeSIhBWnj/izchBVI=;
 b=sf8EMy2OMRJYJ1GdnEeSSqaVqWZTZ1yF+wGPzgqegkkEWu8YqH88auPCsXsJzBn86x
 a1rT3y8UkcgGV/JMVJ6Y2Rismdga4TZhNuFH6JTgq6BgVd49NPeOC/ulaC+UOc0MA4+9
 qlyZqgnYM6dEAsTZcWcMrTNKxVhd2/tC7h5dvJqSyXENAyBwZFn0jBz6krjyFF/Hvhvs
 bH/Q6mMFvLCveoVVnR5z+DkOgnmfAZ/g1sah42Bj0gpaa16cN8yj4aYZEU1i5zhDTypd
 RJD8RUkaw3VB+oPiz5WBEfVYGdjbmY5Q7AMMVKgOS5d+e5MHDWWVaMvu8id9HU+9+lyo
 L+Ow==
X-Gm-Message-State: AOJu0Yz8q1+TKPilXSginzuTFJhCVuzPASCRnYdyYpgM/8iO6EaprXUd
 HHX9a5uVVjnkre+tEcjP7ekKERTUZ+AYyAC8snHh7K5B5x2J6I9Ooi5vu/Bg1PyarN4xvggi8Ml
 ejLHn0FFje3ol1aGzj/SI4STUXfU7PJ6T7EbY
X-Gm-Gg: ATEYQzzHrCBNnS9cxr9UBsnSRn5cgCtjgm4wqsm0fBxUGBbnIgLmXM2sJu9aSfG2+Zl
 yqemevhbZ9JZZFlcWRf9Rt/dG1pzbG4OebFpTGTXPizFW6s57r8+XMMjX7iMQCs92HGik7/iHMw
 +gL75s3ckxxpIqxXcBe/zux1ziELPRhzDgvlDGD8Eu63f0fNRfqxgOfAmm2Gj6d79Y6dpen7zlE
 7vmcAkLTbacK/nW6sNq/sE02tWtiFPOPb6YrVFvRCeZhVzSlfqC/G6RxGn3P0CmOEseUnynFvn3
 owyBtwk5iVeTKtzyiaNPv0r8A/Q320pH19/ZjZDqfmIqZkargFbNo1xIGkB3WWf7zD2wi++vQ4p
 f8Kcv1GMLuYpGL/y48v6N47t7GIpZXxxUrKaxQo52LxDWAg8AWaCW2/I5G82WNNszCv05/elWCG
 a4
X-Received: by 2002:a05:6402:530e:b0:663:46e0:9a91 with SMTP id
 4fb4d7f45d1cf-66346e09d2dmr1712084a12.20.1773316771018; Thu, 12 Mar 2026
 04:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260206104701.34358-1-cibil.pankiras@egym.com>
In-Reply-To: <20260206104701.34358-1-cibil.pankiras@egym.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 12 Mar 2026 11:59:19 +0000
X-Gm-Features: AaiRm52_C7JFWV3Mi6UwuA2JX0vQLGY_Dfg8-27ad9pi5zo59Dg47bZ_dDn6qEI
Message-ID: <CALeDE9MJZrX4Uj7Tc+GjUyJ6yEkA5Qb=SVar4Ers8oNt33ET8g@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: bcm283x: Fix GPIO pull state register values
 for BCM2711
To: Cibil Pankiras <cibil.pankiras@egym.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>
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

On Fri, 6 Feb 2026 at 10:47, Cibil Pankiras <cibil.pankiras@egym.com> wrote=
:
>
> BCM2711 has different pull-up/down register values compared to BCM2835
>
> - BCM2835: NONE=3D0, DOWN=3D1, UP=3D2
> - BCM2711: NONE=3D0, UP=3D1, DOWN=3D2
>
> This patch fixes the pull state register values for BCM2711.
>
> Fixes: 2c39d975f87c ("pinctrl: bcm283x: Add GPIO pull-up/down control for=
 BCM2835 and BCM2711")
> Signed-off-by: Cibil Pankiras <cibil.pankiras@egym.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>

Apologies, I did review but forgot to reply, will pull shortly.
> ---
> Changes in v2:
> - Moved pull value swap logic to bcm2711_gpio_set_pull()
> - Updated the function header comment for bcm2711_gpio_set_pull()
> ---
>  drivers/pinctrl/broadcom/pinctrl-bcm283x.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c b/drivers/pinctrl=
/broadcom/pinctrl-bcm283x.c
> index 4ecc8bac645a..90eee88eb137 100644
> --- a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> +++ b/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> @@ -30,6 +30,11 @@ struct bcm283x_pinctrl_priv {
>
>  #define MAX_PINS_PER_BANK 16
>
> +/* pull states for BCM2711 */
> +#define BCM2711_PULL_NONE 0
> +#define BCM2711_PULL_UP   1
> +#define BCM2711_PULL_DOWN 2
> +
>  static void bcm2835_gpio_set_func_id(struct udevice *dev, unsigned int g=
pio,
>                                      int func)
>  {
> @@ -93,6 +98,17 @@ static void bcm2711_gpio_set_pull(struct udevice *dev,=
 unsigned int gpio, int pu
>         u32 bit_shift;
>         u32 pull_bits;
>
> +       if (!device_is_compatible(dev, "brcm,bcm2711-gpio"))
> +               return;
> +
> +       /* BCM2711's pull values differ from BCM2835 */
> +       if (pull =3D=3D BCM2835_PUD_UP)
> +               pull =3D BCM2711_PULL_UP;
> +       else if (pull =3D=3D BCM2835_PUD_DOWN)
> +               pull =3D BCM2711_PULL_DOWN;
> +       else
> +               pull =3D BCM2711_PULL_NONE;
> +
>         /* Findout which GPIO_PUP_PDN_CNTRL register to use */
>         reg_offset =3D BCM2711_GPPUD_CNTRL_REG0 + BCM2711_PUD_REG_OFFSET(=
gpio);
>
> --
> 2.43.0
>
>
> --
> EGYM SE, Einsteinstra=C3=9Fe 172, 81677 M=C3=BCnchen
> Gesch=C3=A4ftsf=C3=BChrende Direktoren:
> Patrick Meininger, Philipp Roesch-Schlanderer, Florian Sauter
> Gerichtsstand
> M=C3=BCnchen | Amtsgericht M=C3=BCnchen HRB 303509 | USt.-Id. DE275313632
