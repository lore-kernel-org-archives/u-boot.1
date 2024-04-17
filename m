Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A85C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 15:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6355882C4;
	Wed, 17 Apr 2024 17:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M1c3gBjV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81874882E2; Wed, 17 Apr 2024 17:08:21 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 684C3881A6
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 17:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d9fe2b37acso69655051fa.2
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 08:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713366498; x=1713971298; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gTHxLa8EnuEEAKphLeALUStAm+i3rZRQZ4vroSUsdhQ=;
 b=M1c3gBjVRA3muX54TWyNG/2m+Vnq/B0aZfoLOVcjL9yneMkLUHv2Qp8KCb90MnXGs2
 Cz2/enUiX94uA1L+jF+hnesAtrIeft20GFqiJEYLzRw+eyZL5hN7llHEay7NlIjLP8vR
 QGktZgNtDFg5tYUnxwE3XOX5vwYY8Uq0c5QRgHfL7Vbf911p8HAG9m3JzlikmTT7WrtG
 KRfpnYmHQIYvHCjpT3K+Gr0OwP5ikPlpJWcQl3dxRuY0gop6BE7/mBHa7ulzJq5NMRc6
 ZhPnkOC8b8Lubu+ehEbKYhbvRG8tzud+rZJJ5WXblVANeN/PKN6/co7fr2/uh1KwV3QC
 AX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713366498; x=1713971298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gTHxLa8EnuEEAKphLeALUStAm+i3rZRQZ4vroSUsdhQ=;
 b=Q1BgxTyS6lSNnt0Dseq1Tt7v8JeWwE0VdX1iBGzDbCWOzJ0Q11C8nGoafOkpRD+c0Q
 FkKjWgmhoH7w1PdtYzuHHMTY98EmEPnQ/oE2i8WYrCJiUkS71zcC1/3I7E5qTb8KZzvW
 kmO/cvg2MPpn0ZUhcbet6LHl/aRpgePQnxgiBGNZLuRbrw7VWLgegeJ+i6uJzFzj3oHg
 mef6BfYN0azv+5F8Db3hqlqUHv1pAMkLk7bbQ/RtY1LVKrXJmMBn6Uy9ESGtTJ3Cbu3a
 J/SevsaXMUx3gQA0+V5v9+zUdgcNtZ8ReUWMUW241Zjl4xuiN8LqwwQjD1BIQqcCN5Ix
 zDhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt6s6jeQ/29BHNa48U6AHEGi/bZELRjh0sTeJRThd9fZzAtoCOQEU3sJw8CIqR/gGSfyoy3i4Dn1W0TahOL9ppdar4bQ==
X-Gm-Message-State: AOJu0YyoYfSA59jfc6Dt15+y5eUX5IAuRp24Hd4oOiXYM08yjwJAsvWP
 rJbwbSS+ZXsAuAGk6cInG5M4HXJEu350pmzydoocE/D29L/cY3q6bfHgkPmPZl684Bx0YbU+mKN
 1RQ+zTkNxgEscQ98/K46jgtYd4ycS7zmkMVDjRg==
X-Google-Smtp-Source: AGHT+IHYWiAonHgqC8/ZRx0yQylfl9kS/TXN9hFCyd8HogFSGRB82Z9b27NS3il/ktmXYqOoPYvHoEyU6u6bLhp+B1o=
X-Received: by 2002:a2e:991a:0:b0:2da:c3a:2546 with SMTP id
 v26-20020a2e991a000000b002da0c3a2546mr10146072lji.21.1713366480558; Wed, 17
 Apr 2024 08:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240327221205.1871317-1-tharvey@gateworks.com>
 <CAC_iWjKFHnnFf1iHdH2xmSDZQi2D6iNxkO6dWWMhf+X1cDd7qQ@mail.gmail.com>
 <20240408092320.086ea1f1@xps-13>
 <CAC_iWj+DwGznVGX9BK0MRfdYaf0-XpqKNOQheJzJ340cV_-jGg@mail.gmail.com>
 <20240417084842.46da2ce6@xps-13>
 <CAC_iWjKnuJoOtC6N1vk91kwRwgA+iEVESdnxfvYRKx7GEPA3uQ@mail.gmail.com>
 <CAJ+vNU3LdoyjA5petfYtXexG=BBAduUcJfLavwgT6QiOtD9O4Q@mail.gmail.com>
In-Reply-To: <CAJ+vNU3LdoyjA5petfYtXexG=BBAduUcJfLavwgT6QiOtD9O4Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 17 Apr 2024 18:07:24 +0300
Message-ID: <CAC_iWjJfdm7kT24fLeSXJtwExHYsL3v4P1tb7eSVTse3M=ONYA@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: display warning if using gpio reset with TPM
To: Tim Harvey <tharvey@gateworks.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de, 
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Adam Ford <aford173@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tim!

> > > > >
> > > > > The current logic expects a reset gpio and bails out if it cannot get
> > > > > it with a (questionable) goto statement.
> > > > >
> > > > > You want to invert that logic, and expect no gpio, but only if there is
> > > > > one you want to warn.
> > > > >
> > > > > This is perfectly fine but the logic here must be clarified. I'd go for:
> > > > >
> > > > > ret = gpio_request()
> > > > > if (ret) {
> > > > >         ret = gpio_request()
> > > > >         if (!ret)
> > > > >                 warn(deprecated)
> > > > > }
> > > > >
> > > > > if (!ret) {
> > > > >         warn(dangerous)
> > > > >         toggle_value()
> > > > > }
> > > > >
> > > > > I would ideally replace the 'if (ret)' clauses with 'if (!reset_gpio)'
> > > > > which would make the checks even clearer.
> > > >
> > > > Fair enough. But the code with the proposed change has no functional
> > > > problems right?
> > >
> > > No, this is functionally right, but the code is not clear like that.
> > >
> > > > If so I'll send a PR to Tom as is and rework it as suggested later
> > >
> > > Well, that's not how contribution work usually. Is there an emergency
> > > in getting this merged?
> >
> > Not really, it's a print message. But I don't currently have time to
> > pick this up.
> > Tim, would you mind reworking it as Miquel suggested?
> >
>
> I'm just catching up after being out of the office for a couple of
> weeks - I'll rework it and submit another revision as soon as I have
> some time.

Thanks!
/Ilias
>
> Best Regards,
>
> Tim
