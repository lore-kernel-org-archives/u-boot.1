Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3FECA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:55:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A20E38309D;
	Tue, 26 Aug 2025 00:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nvr5f7Ye";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48888830A0; Tue, 26 Aug 2025 00:55:46 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CBFE80819
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:55:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-61c3b84df28so3614737a12.1
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756162543; x=1756767343; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i4CxrxMRH+PmvihjqL3er405DvcKfyl3N2ttClEkW/g=;
 b=Nvr5f7YexWV4lZRl6dD3VvHV8LsWYhBRcdQKF5WMGgBcl88DEQtw78th3FFHXL0CTL
 G3wK96egpL99feFU8GyXcg7wQpRBcAasllk3Vk0vW7G3LR37t+1Jl4THcEXVmY8/vvY3
 ooynQ9V1w0FubA+I65YshuW9Q5WY93txexpY36DaueoaSxZEsRSgnpzLTBeiQwUqUBMY
 IBLnbp++w6QqX5OBArAO2cYteekOwR2Y8y8vqvBRUmdKO2NjG8x0vOSMJIo2YXQvCSdV
 d6KaE9T9nhXIdWCK7Y/XUZPGto6uovhBD7aThyhRBbI2PpdcvJKKIf/b2+SwFJ66T487
 UNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756162543; x=1756767343;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i4CxrxMRH+PmvihjqL3er405DvcKfyl3N2ttClEkW/g=;
 b=be7FxNR72sfPGKWRvNFNW+4H80TqpV8KG9JQywb9cRGtP5ALJQwA9xxv7JurlEreju
 cT23UEVUCaoPr9X+DcaAlhUhYDZWcDXXjZoP6/DS2NQ3tACQtwLCxyoutTsorCQPzvt4
 jqtHp41cT1SitmArkA+Bp1vdhD13FQ2/ycySEqwYpNvmJleebU6FHU4naINX4zYtyvnA
 KzpGjtUl8X4gBXjhU43jzCdJXEkglSANmKK0fCNkaBq4UIl99IQNG20DAQr9wh1JaeyN
 r0gzjHEnN/j5vpYFEb593nfV0BBvyAu7dIheTP93FSY5kzkoMoxT5a7UnvzT5T/DUiBH
 PuJg==
X-Gm-Message-State: AOJu0YwyN/amr2uiu5e/BOfUj7NQXF86v2ds3AxyBQUBWELVRxXn3btt
 ampdIpU/PCzl3GSk5pBKL33jn2wj/VK76vGfZSeY6rn7ItATynkKLkQTtLK/LYo5aqNiwzyi2mh
 3smsJAvNm213X6ELgpk4ryz/cG4RAJrc6q8+qUmDC9g==
X-Gm-Gg: ASbGnctG0fdBQLU1AJgMaKI+/K+yQ9f5VLRfkRJJSSrQRRp7VfRicD+tX2D2SgE/Xq7
 7pV2Xup3ohBjQBCLnGmvdHu6KET7P98yd30HQMyhefoZaGjWWVAQnCsUt2RlsJrOADVHYCQigyB
 ErYN0hQCfcHTmOwLpm6Di8pQyUG6OmGSegsjnjQmPp8Gr3348anxZGJ6kNwh/y4Ant/mlRuGoB4
 CvfCEIUKPwCSNlcn2IMdIkpMW2Aq4v2XCWH/Q==
X-Google-Smtp-Source: AGHT+IHA0aXXIvd3uOJwJ/8Arqqii5pXv+avmkPWR2wBhdWrRQXeZMvgJ8o4lVdWDsv1O0LRuy40UA1Xaw5lIKDeNhA=
X-Received: by 2002:a05:6402:270e:b0:61c:24bb:968f with SMTP id
 4fb4d7f45d1cf-61c24bb9897mr10660407a12.19.1756162543568; Mon, 25 Aug 2025
 15:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
 <20250825224459.682403-5-adrianocarvalho.pt@gmail.com>
In-Reply-To: <20250825224459.682403-5-adrianocarvalho.pt@gmail.com>
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Date: Mon, 25 Aug 2025 23:55:32 +0100
X-Gm-Features: Ac12FXzWAu-Tm4RxQPXN3eHa00oxnM4hVVM3ljWWDLP3NHhw1RIdJMVRv_BEP6s
Message-ID: <CACAHuLCxewbD=Q37DMxOm-Kan+J9BLvAqyOgpzuKw8eTTSB5qg@mail.gmail.com>
Subject: Re: [PATCH 4/7] doc: make pdfdocs: Ensure SVG files are converted to
 PDF before the compilation of *.tex files
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
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

On Mon, 25 Aug 2025 at 23:46, Adriano Carvalho
<adrianocarvalho.pt@gmail.com> wrote:
> [...]
> +              'sphinx_reredirects', 'sphinx.ext.autodoc',
> +              'sphinx_reredirects', 'sphinx.ext.autodoc',
> [...]

Even though it does no harm, this is a bug. I'll fix that in the next
revision. Sorry about that.
