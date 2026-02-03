Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18681E7C70C
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 01:45:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A131683F86;
	Tue,  3 Feb 2026 02:45:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aXygyVzu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B73AC83F9B; Tue,  3 Feb 2026 02:45:55 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9626383B32
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 02:45:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-38305f05717so45836441fa.1
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 17:45:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770083153; cv=none;
 d=google.com; s=arc-20240605;
 b=Sx0MHUOHAt8G6xM41DSYYcCpDbbYDPZQMlQHqcH6YhwHHbGkTHgOyiQBzYaTxojJy2
 89BO8rFuZ1Rt6lt0cv4jVuMdmpkK5bX2VznpWcBAfSsG1agPkdzSuwhZmQw8JmjOBWNw
 T6Z8+E/zezehHA3+DGsAR1mrnCL/Hnom5CKTe5h9l6KuhWdUi4JKf5AkJUcJGPMnfVwt
 lb+WfnAmNUqlj2MLKKEURl7gVsQJCoz0y32c6RJn4rvDoy4xStceV9fKsUswaG03fZEv
 xqDmWhN0csLbsTz5ShmPsSVaPNVCjp2TMT+lMDWnbwE2As+xvwhvakmeCRrYyl7Pdhgw
 ixhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AV+SFoATvdUJ+xoZ/CBZzjy4aby/0qOQlQ5fIhAtYUU=;
 fh=GmZuIPVHuagV77pHnMwubYF7IaXiHKHk5iExLq2rLuY=;
 b=C+awPE4V9kIM+I2PGUmtkrCrHHMNl5ghXV0OpjCJT1POVZ/KYseixwnswq6eLXkrFV
 ciXnp6fzzWUsro1jJk+RTYJ0WCFkZ+HUomvabcIdaRBiag+rGUXVThTbmf+Ch44T0PL1
 AM2v+P84zv09134EohEAZpPJExU1DjkTWQgB20kSuOGvP/VJCXuuFEm8q6sNc3/v6GHb
 y/i22J39dE8jhZrpIek/EacmEICkTFx8l82L3vdhYoIvi2dayNnR4MJrECLMRNWp+uAi
 6eaxRi0oMi4QCLSma3wa/pu3MfRfs27UZExg6QNZ86rD7PK9dNpngLg+UbeiYWQzcpbT
 GcMg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770083153; x=1770687953; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AV+SFoATvdUJ+xoZ/CBZzjy4aby/0qOQlQ5fIhAtYUU=;
 b=aXygyVzu2FW7NfbaSVcm92qgSZKi0m55DBcuGrAO1JYboPYHbv1SzTQH1Zch+IEl7m
 6M1hEOQ8ydDEO4i3lM1grE1BwMZvGZtEIpJKVaPsWwFLTMaqFXg/YBy4TO4rSEiaE1i3
 VdIU94zUbz7kGxwWOYFnQzugCtx/80HWLoJ7fjlUhrf/pLS7PVLhkI9+4L5GII6tW5nh
 Pp37USaG32pdvEbTx7zh178fKv4A94z7C+5E0tuKcw0+iqPTtGjzvBXsbFDe5OGRx1Ik
 bISJMb9jj3Z7wyEzFqf8sf+75pLSD4C9fRw3mTbUHYgYzpH3AYId2qTO88S1ZmGVRidE
 f62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770083153; x=1770687953;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AV+SFoATvdUJ+xoZ/CBZzjy4aby/0qOQlQ5fIhAtYUU=;
 b=btAmsWLYJknn3sPgGKoRQEnAnu26qrPlCKXVJMkMghKAYO8gIv5mJMJe799mK8usNv
 +Zotu1BtU7U02aiQ9Mn/0JnkbLN38Kpflrqt6zp/5agXGZsGIOSIXgnKVVeiqJHVUPuw
 2iVWBm60oO5SmU8mPSQUSeprC2MLfTPwMO/+loVBWE+w3tjzOj23dVpjj2zwqn03M20V
 +PE2XdzXw840uft+ImvfEGF5b8G6OLKP614cHy9okAjEfiEzQQwHIAuaOaV3FSXGBrk6
 95Tb1Tc4A4yE+1NV/KmoT0f9HgbrR+9shOPcEgO8DAb6f8clq64b6mCxYmq/WYOr1g0y
 mLeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt48vuITQuCRgZkFiVeImKSx6HTa/8gx53AWATX+wUPcOviwJtvbhiYZUKh9O71IKTIEdylQc=@lists.denx.de
X-Gm-Message-State: AOJu0YwI0Sezkk1kNBL4aGEA7O0FQ/gaTovTcBcXjj9I7ymkwidf+QnT
 1+vosE/1+ikNKdHZcmkZdE2Ih2i4J+O91b9Lr0bn3tJtImvnk3akMyXLIrq8mf8Y7x8IqmETaiQ
 /UxLcfIpCerPUOwuhW5dGL36Nh9UguPlRuQ==
X-Gm-Gg: AZuq6aJWWnF/1c14s63F9I4WUA/J9pMsYgDG1LxgyKTHYXODMWPYjzZX2XfZYXS0A6P
 CZmFxzX9qA6QXk+Uf0bC6zGWjWlpI6bc1ggXIRFjNkstqXXU8RZYEzJQZ3FMqNgI5JYpf7l4quz
 YTz3GaUt/+sntbEGxOk4LSrWp18P2kzwVspr+lOZ0ZYCa09hZOQyjVnlXHxfM0/9SYj06vTuCij
 cxMnjiUpnLY9/D19ODUaMOo9pDQjb9ZR1UolrCTRQyaah1t8W5JneDf/kcKWhlZwRCQZTxb6wnN
 Ecf2Yja0k/9UpEE=
X-Received: by 2002:a2e:bea9:0:b0:385:dde5:1bf3 with SMTP id
 38308e7fff4ca-38646509ebcmr38939231fa.6.1770083152572; Mon, 02 Feb 2026
 17:45:52 -0800 (PST)
MIME-Version: 1.0
References: <20251001-video_nexell-v1-1-380881a4d30e@linaro.org>
 <f4981d74-0b4d-8add-7804-9c71886af88d@posteo.net>
In-Reply-To: <f4981d74-0b4d-8add-7804-9c71886af88d@posteo.net>
From: Minkyu Kang <promsoft@gmail.com>
Date: Tue, 3 Feb 2026 10:45:40 +0900
X-Gm-Features: AZwV_QizR_CpJeP9H2s9DSYOf11vR9Ey6hXB0GPvjsJIJk-IGbT7BGyetneEkQM
Message-ID: <CALrBrZ2uCEyxFeJ49dWxXOMEiNvuVKi+pSAOefN3J_rin1QiTw@mail.gmail.com>
Subject: Re: [PATCH] video: nexell: unsigned parameter cannot be negative
To: Stefan Bosch <stefan_b@posteo.net>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
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

Dear Andrew Goodbody,


2025=EB=85=84 10=EC=9B=94 2=EC=9D=BC (=EB=AA=A9) 18:47, Stefan Bosch <stefa=
n_b@posteo.net>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Hi Andrew,
>
> On 01.10.25 12:05, Andrew Goodbody wrote:
> > The parameter 'alpha' is declared as an unsigned type so cannot be
> > negative. The code to test it as being less than zero will always fail
> > and so is redundant and should be removed.
> >
> > This issue was found by Smatch.
> >
> > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > ---
> > There is no call to this function currently in the tree so maybe it
> > should just be removed entirely?
> > ---
> >   drivers/video/nexell/soc/s5pxx18_soc_mlc.c | 2 --
> >   1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/video/nexell/soc/s5pxx18_soc_mlc.c
> b/drivers/video/nexell/soc/s5pxx18_soc_mlc.c
> > index
> c8cf833f308836aa9205f4ed2148e41075b83c29..2c8348bf633929272d084b407dd4bc2=
47eff21b4
> 100644
> > --- a/drivers/video/nexell/soc/s5pxx18_soc_mlc.c
> > +++ b/drivers/video/nexell/soc/s5pxx18_soc_mlc.c
> > @@ -1641,8 +1641,6 @@ void nx_mlc_set_layer_alpha256(u32 module_index,
> u32 layer, u32 alpha)
> >       u32 register_data;
> >       register struct nx_mlc_register_set *pregister;
> >
> > -     if (alpha < 0)
> > -             alpha =3D 0;
> >       if (alpha > 255)
> >               alpha =3D 255;
> >
> >
> > ---
> > base-commit: b2d5e46c67002e46ac339ef549ea18cf5adfcd87
> > change-id: 20251001-video_nexell-f93362a0bf72
> >
> > Best regards,
>
> Reviewed-by: Stefan Bosch <stefan_b@posteo.net>
>
> In my opinion, you can remove the entire function if you like.
>
> Thanks a lot,
> Stefan
>

applied to u-boot-samsung.

Thanks,
Minkyu Kang.

>
