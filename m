Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F121EC54E66
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 16:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EE3087E91;
	Wed, 13 Mar 2024 17:25:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DSpyluLu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CFBD87EB7; Wed, 13 Mar 2024 17:25:29 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DA0487DE3
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:25:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dcab44747bso46560875ad.1
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 09:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710347126; x=1710951926; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Mupo+7+j3MKfwlqt5TaHwmzacr+V/SzitYvkii+w1lw=;
 b=DSpyluLuQABatj09b9foBmMcf199hVnqIonYulHK7O6mklZDuqQcdW3HUrOthxy64k
 90uvSJdK9w2qf/jaA1HtiJ2BnVqahupN0PlnylGK/PrDkjAqEPwNs/8baX96pZ4M8ZOP
 ckT9ZNhxFTfvn7h4xrh15CfEtQkOFG8ZaKayGbwOTzMAec4q78xX/h9YbT/QxyNdysZ6
 GxkXc8T6oDlXDhaANS8/a5LFIQU56xLdxdMyoVQsd0A3DpFTxzX0uYdL/B5GoOCKVubc
 VAeZKvufwjTyo2UtVuwTuovFFXxIYFVovwwUqQecNK/6lcMKfC8+LvSwToGndrOrtC2t
 3lZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710347126; x=1710951926;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mupo+7+j3MKfwlqt5TaHwmzacr+V/SzitYvkii+w1lw=;
 b=oh0E/hc5KlqWgS4c3Zy51uul9/rCqAc1u5xAyVZ7WKA6dNv6XtaLn2Iv+ZrYT0rfyw
 hLQq1qHfmkfDMqIuDdHYZ+70z4C+1d54bnXa3y6vQfwq4FQHkkpThMNAMd2c9hlFo1ZT
 0xauFTskUvbS6eVpG5rCJGNPixFgEItNLNiYch/eSgL5VSyYoS99bZedrUkOf92Ywg+9
 Y3KwzU9+pap0yuRLy0OskoDkIcSc1FkAgMXGqLeSTGcG9V43mt+mU6w9IJp7uggLmQue
 A+H4tT1UNwS7cKYpiDbqjZtDsPCkJnNvyIUanO2bRNMHJoZ6YI/Cp6SlDcEU5e5tDXAy
 ybWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4OjEijY6GJfb1hHMURRkRa3LU+5lUT+YBWUXNidX54fTC0X5LpUUE4i5G4dqQ4522ZzJ9t2hkIdWmAoMoynQbAN1mXg==
X-Gm-Message-State: AOJu0YwY7j7Eq39dP99EyRS9SkQ5IkgQdv028CtWT9dpimN0j1ecrcaW
 I1VLTFz5wkkbBcFT+r+RnO3cWS+RAOfrAwsqPA/+EZGJBEUiViMMdn15vY39HfU=
X-Google-Smtp-Source: AGHT+IGwWT2D9KXzs+c0BBxWmhapVf4ePjA2DIiq7Gwpas1TzPLo+i5f0kDRHSDdGSwzxiVM8Ik1qQ==
X-Received: by 2002:a17:902:da92:b0:1dd:cef5:2b10 with SMTP id
 j18-20020a170902da9200b001ddcef52b10mr2456227plx.3.1710347125549; 
 Wed, 13 Mar 2024 09:25:25 -0700 (PDT)
Received: from frhdebian ([201.82.41.210]) by smtp.gmail.com with ESMTPSA id
 a7-20020a170902ecc700b001dd0d090954sm7281535plh.269.2024.03.13.09.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 09:25:25 -0700 (PDT)
Date: Wed, 13 Mar 2024 13:25:21 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Peng Fan <peng.fan@nxp.com>,
 =?utf-8?Q?Jo=C3=A3o_Paulo_Silva_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Hiago De Franco <hiago.franco@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] colibri-imx8x: Fix sc_misc_otp_fuse_read() error check
Message-ID: <20240313162521.ogtxjtamvbe2gzzo@frhdebian>
References: <20240313003641.2650648-1-festevam@gmail.com>
 <22748b1c9a5c563be179342562ec3650760552f2.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22748b1c9a5c563be179342562ec3650760552f2.camel@toradex.com>
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

On 13.03.2024 08:09, Marcel Ziswiler wrote:
> Hi Fabio
> 
> Thanks!
> 
> On Tue, 2024-03-12 at 21:36 -0300, Fabio Estevam wrote:
> > Commit aa6e698a7acd ("imx: toradex/colibri-imx8x: correct SCU API usage")
> > made an incorrect logic change in the error code check of
> > sc_misc_otp_fuse_read():
> > 
> > -       if (sc_err == SC_ERR_NONE) {
> > +       if (sc_err) {
> >                 /* DX has two A35 cores disabled */
> >                 return (val & 0xf) != 0x0;
> >         }
> > 
> > The other changes in this commit are correct.
> > 
> > sc_misc_otp_fuse_read() returns 0 on a successful fuse read.
> > 
> > This inversion causes board_mem_get_layout() to report incorrect RAM size.
> > 
> > Go back the original error check logic to fix the problem.
> > 
> > Fixes: aa6e698a7acd ("imx: toradex/colibri-imx8x: correct SCU API usage")
> > Reported-by: Hiago De Franco <hiago.franco@toradex.com>
> > Signed-off-by: Fabio Estevam <festevam@gmail.com>
> 
> Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 

Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Toradex Colibri iMX8X 1GB

> > diff --git a/board/toradex/colibri-imx8x/colibri-imx8x.c b/board/toradex/colibri-imx8x/colibri-imx8x.c
> > index 2c673a4a6b06..6fc8076163c6 100644
> > --- a/board/toradex/colibri-imx8x/colibri-imx8x.c
> > +++ b/board/toradex/colibri-imx8x/colibri-imx8x.c
> > @@ -46,7 +46,7 @@ static int is_imx8dx(void)
> >  	u32 val = 0;
> >  	int sc_err = sc_misc_otp_fuse_read(-1, 6, &val);
> >  
> > -	if (sc_err) {
> > +	if (!sc_err) {
> >  		/* DX has two A35 cores disabled */
> >  		return (val & 0xf) != 0x0;
> >  	}
> 
> Cheers
> 
> Marcel
