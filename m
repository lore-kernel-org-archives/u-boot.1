Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CF3CF64BB
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 06:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2559084042;
	Thu, 20 Nov 2025 07:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OTVUZSE1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 843388404D; Thu, 20 Nov 2025 07:10:49 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23CF483E0E
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 07:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-7895017c722so4999157b3.2
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 22:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763619046; x=1764223846; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IRPw7p5K47ZhAuLQMhYZKJATwYf08rLUHp+EmzbDQBw=;
 b=OTVUZSE1VVOQHwtfJqfqhPQC1e+nvsJjUyQ3cuF4n+3ZY8oTPIuATnSL/l14YxsnbY
 WxF57Ctedt+oXJBUrtAPU3ZU02gdXZOBm89SKyVWg77WlxhesI2YLU15p/e5d1j0QatZ
 TJhWwoPdu7r0bPWjGbwzUCLeZ8XHNGW/6arXXE/vskPWx5TBexNHDXo7Kh4pZfcVPbvn
 K78WYVgNcox4+Zm64T6OWyR/jdaT36Z1vz/1yt7FBkwMDn3GkeMYQYB8gWq0jVWN3G6G
 0MNXcbqPq3wpMZJ+3aUIrynXGT9EnZFNxgExauKGpJ3D9v2hPwj1r7zf/ROS6lrtHX3H
 /00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763619046; x=1764223846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRPw7p5K47ZhAuLQMhYZKJATwYf08rLUHp+EmzbDQBw=;
 b=fijrN5IwzeP49zCyIf4yrDd/9zpEra5XSvj/pOjm5vjNNPv09QdIrXUOJoyB+CW0sA
 /7iiEyZ5L/GL4SgQT1y+McxpIo3rqCrUa9n557n8E9ePLraMd204O52g5JfiD/4lkjbJ
 Nvh/gOBKZ+EheS7TMhCoUD954jV+5P+L39h2N1S38HNztHvCn71D11FFILrKMkZZSRU/
 HxsGFhTfYnaA5d9nn4JVWmU1ZDN5cPe6RrjZhK/zrviYKHvOczjvwhRo5DPV7BzrCke/
 mT+gzJiAUcqntdDOjG6aZdAHRTzMFfhy72VoFmmO+j/9dWDnlqNTbo+OlkU5g3BGNmv3
 w3DQ==
X-Gm-Message-State: AOJu0Yz08NJU/qqSYZgD9IqztId/2mml4v+RDtSF1y31kGmmo5lUHvPe
 hOx4QfJK/U8kpARNGV0ygw87+5WrgURwuwuJ/qHSHNsGdLStxt05Y4QZQT4i5WUVjosHwk2Dn0m
 wu+f9s/Ae504opkQ+mlv599P2jJ7nmE0kdgAl/snZQQ==
X-Gm-Gg: ASbGncsNNyBD3A2kXqkNl0UoN+oMqUjCmjiavyETRQhnVhb/UpmNhlv3nBv8IuWEIrn
 dvvlQ3ZfSrm5iKdiS2T2bmpYSTdC4PAU2HbFIW/D5S309hL3arcXbRt5rcxzU6IMEAayMulaR5r
 m5JKOMYIMVGA3pODm/Wv5PCECY193s7Wb3sibyd+/sOLj857OuzJ4czt6NFPFzNVYLhp0db3UAM
 OO84Fe8nu/Ls8qF1Hhj3uqNZVwMBz/1r3Rwh3YWFwHGWypHXtFCaVB7L1h3+N5/F/yjJoLSoyxG
 5cBYcU51QInrHFyOIlhkzv8zYjwZ17h7ZwP89JFHOWWIJ+pLLw==
X-Google-Smtp-Source: AGHT+IE2r836ANf7zfQw+1dnXwlkq1BXkDtyN1aYcUBmlMUka9OZbkJEoW+GDKJX83Oqam2Ms4Xc5Rb++nuSj3BGuYo=
X-Received: by 2002:a53:d058:0:20b0:640:b8ef:b777 with SMTP id
 956f58d0204a3-642f7a38c1cmr1202266d50.69.1763619045930; Wed, 19 Nov 2025
 22:10:45 -0800 (PST)
MIME-Version: 1.0
References: <20251113115558.947903-1-marek.vasut+renesas@mailbox.org>
 <CAC_iWjJE1meO7UonS2-hUSkkcnxQWCerqdN4mb_wcR7rpVXy+g@mail.gmail.com>
 <20a873e8-d17c-43af-88af-ca14219859c3@mailbox.org>
 <CAC_iWjKWr-J3pxmwT5mCDXaAiRxYFiX=hfHGdp2x81-0WzbEpQ@mail.gmail.com>
 <7a84357d-c4c6-45f1-a0bf-d21ee7a19a19@mailbox.org>
In-Reply-To: <7a84357d-c4c6-45f1-a0bf-d21ee7a19a19@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Nov 2025 08:10:10 +0200
X-Gm-Features: AWmQ_bmzlRwtfEpoxGXz7ENKFltrV7XEC8DSfSLNlLF2P1S1H7U3Y9slgZpAfc0
Message-ID: <CAC_iWj+tKuw-cByFDQMceb6w97KZ=0CzK3CWyA4ceC=eQ3L_CA@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Assure fitImage from capsule is used from
 8-byte aligned address
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Wadim Egorov <w.egorov@phytec.de>
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

On Wed, 19 Nov 2025 at 19:34, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 11/18/25 2:56 PM, Ilias Apalodimas wrote:
>
> Hello Ilias,
>
> sorry for my slow response, I am buried under emails.

No worries

>
> >>>> +               img = memalign(8, image_size);
> >>>> +               if (!img)
> >>>> +                       return EFI_EXIT(EFI_BAD_BUFFER_SIZE);
> >>>> +               memcpy(img, image, image_size);
> >>>> +       } else {
> >>>> +               img = (void *)image;
> >>>> +       }
> >>>> +
> >>>> +       ret = fit_update(img);
> >>>> +
> >>>> +       if ((uintptr_t)image & 7)
> >>>> +               free(img);
> >>>
> >>> Initialize img to NULL and make the check a bit simpler to read (or
> >>> get rid of it overall)
> >> This part ^ I do not understand. The img variable is used by
> >> fit_update(img) , where should it be initialized to NULL ?
> >
> > The patch might be misleading since it doesn't show the entire
> > function. But from what I saw 'img' is only initialized when
> > 'if ((uintptr_t)image & 7)' is true. you can initialize img to NULL on
> > the declaration and just check for that.
>
> The 'img' is always initialized, see this:
>
> "
> +       if ((uintptr_t)image & 7) {
> +               img = memalign(8, image_size);
>                  ^^^ ----------------------- Here it is initialized
> +               if (!img)
> +                       return EFI_EXIT(EFI_BAD_BUFFER_SIZE);
> +               memcpy(img, image, image_size);
> +       } else {
> +               img = (void *)image;
>                  ^^^ ----------------------- Here it is initialized too
> +       }
> "

Which I somehow missed reading the patch...

Thanks
/Ilias
