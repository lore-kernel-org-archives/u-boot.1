Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDC2C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 10:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 788FB8842B;
	Wed, 17 Apr 2024 12:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="X1UyVpLA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77C9F8844C; Wed, 17 Apr 2024 12:49:35 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A41188344
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 12:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a524ecaf215so506788366b.2
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 03:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1713350972; x=1713955772;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5lBS861s3Ka1k9peMlLNydK8C5j2r3/Xa4Cm+TTb0S8=;
 b=X1UyVpLAb5IpIKGlxp9zdPWG79mypVI+6Oczcveq0XiZqkWJxcpr977Q49Vu/e6UXP
 a1iq/D9F3eBdyxa4Y/bH9qXZKwwYhTgg0kAz2rv6MgCfWlBwQE3S9Z1JsG2tD+iEVXk/
 i3wA+sSqAp5QGhegzRk5qLQNAAUx5HCw2J+1gqXsX6za7q6gRbEO9GWsrF3pOCLgqmSI
 25mZJwjyXg0/NiafKBHDZrLEZ1yKa4TycFRXYo14LV/I08DJurv3GolBXpFIZ7hoJo8t
 LCW5Jb1+LMIU2L/XbfY/Me8ETxpvQXM/8b3PZa+MziA/lNnIGIzm+RlLoJ8Gk4OY8MEX
 G3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713350972; x=1713955772;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5lBS861s3Ka1k9peMlLNydK8C5j2r3/Xa4Cm+TTb0S8=;
 b=r7bqX3jdnI62sSOKpmyTIGtXjdQw3xZ5DuzuUV70JthuMrLt5CzfY58W+pwr4y/ePS
 /k6n5mkmAjr1lD/+Fap1N5lN6zyGIBhObYrZw9iisrZCCFTX9BHnpI0FwI46v1vJl8+D
 am7R4hXJPCG962k/lo5QB/C+lpX24ikw6SR3wQiePK4QcTJfyGqXihmlVLnLjDdo128G
 6Itil55Sxr6rO+1RhAQYw/kp8NzC2BYmNQyPs442XHYjN+70RlpohRdD9nIOOdANSkP5
 Mrl94/l+63sjuKxf3e63v7PNLr8dUiO/p83lmRsa7RHkgzVHI/Gxk3m0cp/qA156YyFQ
 TAnA==
X-Gm-Message-State: AOJu0Yw406U/2nojodipEGuiRBNz99S91wtnazjeMWFa8osKWhHcBnpD
 juQSnFIAdXKRqk9w1G6lnJVBJ0Lm3NNwdzleW7EQRBbH0tOs05ttddVpVBa4CmrmFp9Rdx3DVdd
 sQqxNcA5pgEaw8i+es2NcwTHzl6/GORK1tbjvsQ==
X-Google-Smtp-Source: AGHT+IFz6b/52O45JrfsZ28rue1u2hfidWwIRs+2tc6uUY/vS5tj5DpyH8d0bU2jPw/pZDB8kxplSmTAUJWp3c8ZGKg=
X-Received: by 2002:a17:906:f148:b0:a52:14b3:480c with SMTP id
 gw8-20020a170906f14800b00a5214b3480cmr10534747ejb.76.1713350972492; Wed, 17
 Apr 2024 03:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240417093542.275150-1-lukasz.czechowski@thaumatec.com>
 <1f99fdde-1d2f-4efa-8a59-8f011d99643e@theobroma-systems.com>
In-Reply-To: <1f99fdde-1d2f-4efa-8a59-8f011d99643e@theobroma-systems.com>
From: =?UTF-8?Q?=C5=81ukasz_Czechowski?= <lukasz.czechowski@thaumatec.com>
Date: Wed, 17 Apr 2024 12:49:21 +0200
Message-ID: <CABd623tB_52rwiQ577FBjhQRW4_BPcgL_3Ewww8tdTU2bUy2ZA@mail.gmail.com>
Subject: Re: [PATCH v2] rockchip: px30-board-tpl: Use CONFIG_TPL_BANNER_PRINT
 flag
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
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

Thanks for your response.
As for the CONFIG_TPL_SERIAL flag, I agree that it should use 'imply'
to be allowed to disable it, to silence the serial in TPL. However,
currently, disabling this flag makes the code unbuildable (which could
be the reason 'select' is used). I'd keep this change out of scope for
this commit.
I'll prepare v3 then, which will contain only updated Cc and commit title.

Best regards,
=C5=81ukasz

=C5=9Br., 17 kwi 2024 o 11:55 Quentin Schulz
<quentin.schulz@theobroma-systems.com> napisa=C5=82(a):
>
> Hi Lukasz,
>
> I would have renamed the commit title to be something like
>
> rockchip: px30-board-tpl: sync ifdef guards with full TPL
>
> because CONFIG_TPL_BANNER_PRINT isn't really a flag but a Kconfig symbol
> and the effect of this patch is to not print the banner when the symbol
> is not selected.
>
> Another option could have been (only for the v1, since you do more now):
>
> rockchip: px30-board-tpl: print banner only if CONFIG_TPL_BANNER_PRINT
>
> On 4/17/24 11:35, lukasz.czechowski@thaumatec.com wrote:
> > From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> >
> > Display TPL init information message only when TPL_BANNER_PRINT
> > configuration entry is set. This allows to disable information
> > message in case logs on UART are unwanted.
> > Update parent ifdef condition to check also CONFIG_TPL_SERIAL
> > to match logic of the non-PX30 TPL implementation.
> >
> > Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> > Cc: Kever Yang <kever.yang@rock-chips.com>
> >
>
> Small nitpick, the Cc would make it to the git history, which isn't
> really necessary. I believe you could have those below the --- and
> git-send-email still find them.
>
> Additionally, git send-email allows you to provide --cc and --to manually=
.
>
> > ---
> > Changes for v2:
> > - Updated parent ifdef condition
> > ---
> >   arch/arm/mach-rockchip/px30-board-tpl.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-rockchip/px30-board-tpl.c b/arch/arm/mach-ro=
ckchip/px30-board-tpl.c
> > index 637a5e1b18..db368a7b8c 100644
> > --- a/arch/arm/mach-rockchip/px30-board-tpl.c
> > +++ b/arch/arm/mach-rockchip/px30-board-tpl.c
> > @@ -36,7 +36,7 @@ void board_init_f(ulong dummy)
> >   {
> >       int ret;
> >
> > -#ifdef CONFIG_DEBUG_UART
> > +#if defined(CONFIG_DEBUG_UART) && defined(CONFIG_TPL_SERIAL)
>
> Quite interestingly, CONFIG_TPL_SERIAL cannot be disabled on PX30, maybe
> we should change arch/arm/mach-rockchip/Kconfig to use an `imply`
> instead of `select`.
>
> Anyway, no change required on my side. Only, if there's a v3 (for the Cc
> and commit title, the Kconfig change would be a separate patch anyway).
>
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> Thanks,
> Quentin
