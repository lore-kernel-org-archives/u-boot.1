Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392E1C001CC
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 09:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FBF787FC8;
	Wed, 17 Apr 2024 11:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="XVnyNokQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01FCF88453; Wed, 17 Apr 2024 11:27:43 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 685AB87ED0
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 11:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a5269c3f9c7so394902966b.2
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 02:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1713346060; x=1713950860;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UwEz/VDIHZ3+0uWAAIAU6VQ7uW6To/vNT+czRyzmLCA=;
 b=XVnyNokQtzQfeTBxfbMrfVgXIeft1yVwQUfa70e51o3YYH6uBXMsF4uEQGyL4XHBil
 BUB1UazFNXhZYy58rkwOn7ydOfe+tu+PzcTeJHSVw9sH44JIf37KqDvQQc9H07Rjee4/
 DVl8K2yqsQwvynBxB9eWYA50y3GDLx/g3fetzi1qaP4qSFoBVE9lkMRFTKHh9e5Mz/Ml
 bs3rMDCe0JZpCTzmDzqviXZ6RGqV3G0T9KIxgWcACwNoDGB0nHFPfX4nar8HOX+Pdv6g
 IhD58FCA6tHG+BhW/2mYmp/EdPL/eQY1GaGo8/a1iR2lndYb/1jyujoMZ2fpooGfQlG7
 rwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713346060; x=1713950860;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UwEz/VDIHZ3+0uWAAIAU6VQ7uW6To/vNT+czRyzmLCA=;
 b=wPdYzJrtiW+q+4yzuIt4emxf3wyVpkFpSY7MgDe2oJhz00dXab7DqTolJjxaByRlN/
 ce7YUQuutobFNtUPrSrW8pJBRdiOeRR3qjLkITOnSfTZSDrSzTALMxyXS3kiZ2CQdnR9
 fI4jy0Y1Q4dXEoS8kBlUP66I0MZun2ywLscBBzjsk5YWbvk5TMMJYqUxwq/qr8XfE5mQ
 7yzcXOVWaTx5B6OriMy1CHD9i0pKS4bU3TD58l5CVBxpL/3YWJXxzKaK19nI6cwjQjKa
 +3MlI8qIgWqTZBPHpotgCZvJ3wl7DN8muzeX1j4b/KyRdpQ2Kt8Msiaef7zd0aGe0stB
 ZOzw==
X-Gm-Message-State: AOJu0YwwSZy9N7BxIhCnpCQJGGnSm41hjgQRWixWtlEmWTBWI/Rgu/e6
 Nq2zsFneAP39Pe0wqXBV+/YZkvzj+at9kH+1y7DpVlriOACWXRkvRk89bh3P2jKXYllMojn0IDr
 LdOItJGlvsouswxwXLjrj10o5N+sC3SY4JiAWC2UhXWGv4PnncPgA/w==
X-Google-Smtp-Source: AGHT+IGZ2sd/JsfN9ItFAMrhn/F3sqf3pPr3Hk/MhRCe9P9HtadxyOpV2c9zUvz0qQHijSO0WK+j+Gd77z9BQjEOB2M=
X-Received: by 2002:a17:907:7b9f:b0:a52:2242:3039 with SMTP id
 ne31-20020a1709077b9f00b00a5222423039mr13070582ejc.50.1713346059840; Wed, 17
 Apr 2024 02:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240416124701.157545-1-lukasz.czechowski@thaumatec.com>
 <ee8b9906-0e32-4c89-ae3d-5dead6f4ca77@theobroma-systems.com>
In-Reply-To: <ee8b9906-0e32-4c89-ae3d-5dead6f4ca77@theobroma-systems.com>
From: =?UTF-8?Q?=C5=81ukasz_Czechowski?= <lukasz.czechowski@thaumatec.com>
Date: Wed, 17 Apr 2024 11:27:28 +0200
Message-ID: <CABd623u4Yda_k3Zp3-m8Rmt0UuisatDrEfERmZpSFDyBs3JhwQ@mail.gmail.com>
Subject: Re: [PATCH] rockchip: px30-board-tpl: Use CONFIG_TPL_BANNER_PRINT flag
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, philipp.tomsich@vrull.eu, 
 Kever Yang <kever.yang@rock-chips.com>
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

Hi Quentin,

Thanks for the hints. Matching the parent ifdef with non-PX30 TPL
implementation is indeed a good idea. I'll send the updated version of
the patch.

Best regards,
Lukasz

wt., 16 kwi 2024 o 15:22 Quentin Schulz
<quentin.schulz@theobroma-systems.com> napisa=C5=82(a):
>
> Hi Lukasz,
>
> Please use scripts/get_maintainer.pl to set the Cc and To recipients of
> your mail to make sure it reaches the appropriate people explicitly.
>
> $ scripts/get_maintainer.pl arch/arm/mach-rockchip/px30-board-tpl.c
> Tom Rini <trini@konsulko.com> (maintainer:ARM)
> Simon Glass <sjg@chromium.org> (maintainer:ARM ROCKCHIP)
> Philipp Tomsich <philipp.tomsich@vrull.eu> (maintainer:ARM ROCKCHIP)
> Kever Yang <kever.yang@rock-chips.com> (maintainer:ARM ROCKCHIP)
> u-boot@lists.denx.de (open list)
>
> (one can use scripts/get_maintainer.pl on patches instead of files, and
> it'll return whatever is needed).
>
> Plugging `b4` here as well, because it's a pretty nice tool to use:
> https://git.kernel.org/pub/scm/utils/b4/b4.git/ One can install it with
> pip. I use it for Linux kernel and U-Boot contributions for a couple of
> years now and I'm not going back to manual workflow :)
>
> b4 prep --auto-to-cc would set everything up properly for you.
>
> On 4/16/24 14:47, Lukasz Czechowski wrote:
> > Display TPL init information message only when TPL_BANNER_PRINT
> > configuration entry is set. This allows to disable information
> > message in case logs on UART are unwanted.
> >
> > Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
>
> This matches Rockchip's non-PX30 TPL, so:
>
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> > ---
> >   arch/arm/mach-rockchip/px30-board-tpl.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm/mach-rockchip/px30-board-tpl.c b/arch/arm/mach-ro=
ckchip/px30-board-tpl.c
> > index 637a5e1b18..a660816db0 100644
> > --- a/arch/arm/mach-rockchip/px30-board-tpl.c
> > +++ b/arch/arm/mach-rockchip/px30-board-tpl.c
> > @@ -46,7 +46,9 @@ void board_init_f(ulong dummy)
> >        * printhex8(0x1234);
> >        * printascii("string");
> >        */
> > +#if CONFIG_TPL_BANNER_PRINT
> >       printascii("U-Boot TPL board init\n");
> > +#endif
>
> I'm wondering if we shouldn't have the parent ifdef also match the logic
> of the non-PX30 TPL?
>
> #if defined(CONFIG_DEBUG_UART) && defined(CONFIG_TPL_SERIAL)
>
> instead of
>
> #if defined(CONFIG_DEBUG_UART)
>
> ?
>
> Thanks,
> Quentin
