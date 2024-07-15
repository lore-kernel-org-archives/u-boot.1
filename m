Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75F0C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 427DD8881F;
	Mon, 15 Jul 2024 15:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rb0qPzTB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3010C88827; Mon, 15 Jul 2024 15:23:59 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC37B87F9F
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6b772455ab4so7706966d6.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721049835; x=1721654635; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1NLI2nrSkGGKkCFHHiBm4hRDAy3hLVr0mtrKhXXcuqU=;
 b=Rb0qPzTBfrxX93ThGZrgju5Lm/pjRGcdWiXxeaksEI7/SatmDZfayazfwvxxT9YEM0
 xIOLwkYOJ/wth1Ji3YZlVdF96wI1Tq5e5S0R8KgKEQNBR/uPJjXMWWn0kjnljtOGP59J
 yVtJn5fGg2sZE4iPy0nZo/mPiWIhRcE5xM9rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721049835; x=1721654635;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1NLI2nrSkGGKkCFHHiBm4hRDAy3hLVr0mtrKhXXcuqU=;
 b=nv3fxlv1v0Vb7e0oyiFwdLfmSS/YVvAxWjnI72vd9B3oBiCv4X20x3U9yCYJpkIpz5
 jTniFGzUm2DAZN1wzN0I/p/S2XnPgf+sY7vr8n19R4t4VoMJ3yKq8dYhGowJDe4rEB8b
 yRXuZeNVzXoQZI1RszoFhAKC8pX4XjdOSYhcx6Rn5WEMytiPKLSYjSwxk+gFSXs3NSNJ
 sBL82JXnvhMsonndXsj6wEIGCG1pEYL0GybfCsEheekbBO68Ug1+cicToi8k4SLFseXW
 9RMBQzslNdJGLo/YMTrw3VKpqQkkdch2gr76+UYdPNQxnEPnDrN3xrj1dtCJghhDkSVF
 oPQQ==
X-Gm-Message-State: AOJu0Yw/tH57MWnkddUulDuN83dgjqmgstkasFw2Hc1/ETwoCpSBsRIg
 qf2ov/hYot93Y2fGlGKU+YsVR8eadZ0Tx8Uq4xtSaDS7qChWCwfdKNWcUrUhYT716MRHsJ4lTHa
 8HCXeTzif7nHDbDong33GeVsLY5u1B3CaDQ1N
X-Google-Smtp-Source: AGHT+IHYPkxuo/oI/YLxqLXTxibnsL6Xqj4eAUI5IvQUZ2WCm3mfxhrPdVGWwBGL6DinZDVrLdDWKwLD1Dj79qfn+fo=
X-Received: by 2002:a05:6214:29e1:b0:6b0:8ac1:26bc with SMTP id
 6a1803df08f44-6b754bc3b2amr228753106d6.14.1721049835592; Mon, 15 Jul 2024
 06:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240702170009.484961-1-andrew.goodbody@linaro.org>
In-Reply-To: <20240702170009.484961-1-andrew.goodbody@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 15 Jul 2024 14:23:44 +0100
Message-ID: <CAFLszThkmy0RG8HBFAsmCVf7h6S1Afa=SmuQ2PvLotxd7C=48Q@mail.gmail.com>
Subject: Re: [PATCH v2] sandbox: Fix LTO to work with STACKPROTECTOR
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Tue, 2 Jul 2024 at 18:00, Andrew Goodbody <andrew.goodbody@linaro.org> wrote:
>
> Add the STACKPROTECTOR symbols to the script that generates the
> symbols that should not be removed by the use of LTO when linking
> a shared object. This prevents a fail to build due to link errors.
>
> https://source.denx.de/u-boot/u-boot/-/issues/35
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>
> Changes in v2:
> - Made the new match more specific and added it to the grep run rather
>   than run grep twice
>
>  scripts/gen_ll_addressable_symbols.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
