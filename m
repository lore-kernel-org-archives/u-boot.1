Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9C3D10F43
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 13:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 787338421A;
	Wed, 26 Nov 2025 14:02:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hx7Fs4zI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80A1F8309A; Wed, 26 Nov 2025 09:48:23 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7132282B20
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 09:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-37b8aa5adf9so49869061fa.1
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 00:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764146901; x=1764751701; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dp7jtoWTl/UEMElY3jGyWgMKoiUv7Kvr0mUigGhIpno=;
 b=Hx7Fs4zIOrZCMAkdARQ5noKk4lSplft083XhRq0RGsf8HD/wzIKxL7okGs/cZcKt9F
 eZ+OJ3ZaDojd/8ikOj2gyST0eTBVfseEo1zudpx0IygLJ2a4NLdmdlNqCI25vXesWrTr
 +pU6OkjRbVglzWhoY9OAATOLTUfw5Wew4lTCJLAxjvpCIP44Ff6+PZqRF6dMJGfnP+kh
 YgYmbwTchv6zg+TcyJr791HxI+Aiv9lQSQnUEOxnnwjcfuZiZsyU0KSkmjjuMr292FAB
 Hl42PzHQJ06foBTFpwNn2jM6tOFrBKfsPRg8BgiFKR5BwvOhBT/IftkB8sKNDGA5I/Nt
 jzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764146901; x=1764751701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dp7jtoWTl/UEMElY3jGyWgMKoiUv7Kvr0mUigGhIpno=;
 b=Z4OetDLF2CDcPVzRnOnaw97B+kcYsKaFinp8NLPGsCO8d1ys40iJEtXwaotcwvkcV4
 7d67CrpXiszEVWI1iLT3iF3FFtCCR7BvfbFHJctKo/fhKrdjEoETiHBpyq+5jIInvv6H
 6IUz4pwBAI0/a7Y4XEys8v2we+FpLxrUJp4JJkHtkFw+aF1D6UZZ5NOcA5omazmwmu7W
 nmOh+4PxJ+LSvyUao4cmbAh3dnZXUn9UQI8XBT0vy7M79YpuA5OIHEPT/iwh6P+iVY5t
 pl7yXaZ13v3alFupNkquqYUc/w/aeUv+EiMZL65Ye+SNALwtdoGpgjoDBIBxUe+fRl1E
 W9xQ==
X-Gm-Message-State: AOJu0YzDmIG3MtMSA0wt2Cdzs2Xw5fiPY9KFFYu4SIUaG9r5BtZ8Z4I5
 XSVamEdaWaX46BqcAKpMSwW8KVBjuhWlnRcTMw+xkUBuZaQg2GAsDOlB0Yafruc03v+AVRfvnFJ
 n1dtWhzbk0uYaDtXoFkm4CDdX7hejL6M=
X-Gm-Gg: ASbGncsU6fJ/E2LlQFBwo+SH0ZTdNUm0PGOidLjXRTwSwZPZRxw/6pr4XLfyLpbIpzV
 WC8qTCsH7e30sL1AirCHPZLZqmg8fL+yIHIiwUrRE02q68HMmLcu/d3vzpd8jXbD/iElP2hgJlh
 +plpVEJ/tJL06Hg1iMYHHscVFIYomvxiFx2Tgw59mQbO812qxMNiXKqqo0rwfU9ygAHZz61agTL
 muIN6efc0/WAm3T1VN8izfaAXbEtJ2jg12sIQCgcj3p+W5FdjIJSnFSN/uWS/xgJYgosZl0RKlD
 xAKD5jACB2+vGTvZ7U4uoMwyHuso
X-Google-Smtp-Source: AGHT+IFLDshetIbnQZtkTQFIybYkh/WjyovnvmLbWWrI9lZ0UtAytAppq9pANReLW9n737wxthKKDEDDWWe4XxNT5vs=
X-Received: by 2002:a05:651c:4353:20b0:37a:3fab:16a3 with SMTP id
 38308e7fff4ca-37d0785765amr15458131fa.20.1764146900425; Wed, 26 Nov 2025
 00:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20251017-serial-s5p-exynos8895-v1-1-b412dd112cfd@disroot.org>
In-Reply-To: <20251017-serial-s5p-exynos8895-v1-1-b412dd112cfd@disroot.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Wed, 26 Nov 2025 17:48:07 +0900
X-Gm-Features: AWmQ_bl_-0tNeW7zRUiUmurCM3VCjZprLW_utG6Cz7cZLSZvnQQFmizzoHY9N2o
Message-ID: <CALrBrZ2AeZf-iRzJ4DWuLj-riBz1mE-ACwZ+5vHcSxv0efHg5Q@mail.gmail.com>
Subject: Re: [PATCH] serial: s5p: add compatible for exynos8895
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
X-Mailman-Approved-At: Wed, 26 Nov 2025 14:01:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,


2025=EB=85=84 10=EC=9B=94 18=EC=9D=BC (=ED=86=A0) 00:47, Kaustabh Chakrabor=
ty <kauschluss@disroot.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Add the compatible for Exynos8895 UART as described in upstream
> devicetree bindings. This enables support for Exynos8895 and other
> similar UART devices, such as Exynos7870. Other than that, the driver
> works as-is.
>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  drivers/serial/serial_s5p.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/serial/serial_s5p.c b/drivers/serial/serial_s5p.c
> index
> 734780a124ad47ed97811784edfdb45a75d37bf7..d46a88610ab88a227aa07b10c62576a=
13168bfbc
> 100644
> --- a/drivers/serial/serial_s5p.c
> +++ b/drivers/serial/serial_s5p.c
> @@ -258,6 +258,7 @@ static const struct dm_serial_ops s5p_serial_ops =3D =
{
>  static const struct udevice_id s5p_serial_ids[] =3D {
>         { .compatible =3D "samsung,exynos4210-uart",      .data =3D PORT_=
S5P },
>         { .compatible =3D "samsung,exynos850-uart",       .data =3D PORT_=
S5P },
> +       { .compatible =3D "samsung,exynos8895-uart",      .data =3D PORT_=
S5P },
>         { .compatible =3D "apple,s5l-uart",               .data =3D PORT_=
S5L },
>         { }
>  };
>
> ---
> base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
> change-id: 20251014-serial-s5p-exynos8895-3303dfe3a99b
>
> Best regards,
> --
> Kaustabh Chakraborty <kauschluss@disroot.org>


applied to u-boot-samsung.

Thanks,
Minkyu Kang.
