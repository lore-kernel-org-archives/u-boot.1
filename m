Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B829DC27C55
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 15:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1896C881DB;
	Thu,  6 Jun 2024 17:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lSiieIil";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CC3E88216; Thu,  6 Jun 2024 17:04:21 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4806287F64
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 17:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6af6c2bee7bso8356316d6.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 08:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717686258; x=1718291058; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VbHIIevA1hXa/wi2wVJ+pV8Hgh+Xg/FsUFKuoQsxJ3w=;
 b=lSiieIilaEvPc8fjr8RmoIR+05rXc2kVs8Jp7F+lIAbDYHsBI1iZyfF4+G5tI2C5nu
 htemIIbete5B1EKwuExi84izB8epLIwvFGPEBAtuLhD6ktZfR3OGxmG+9xKfptA9b1wP
 wy18/iRJpRYE64BEzLk01aDmQQ7SwI09VSL4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717686258; x=1718291058;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VbHIIevA1hXa/wi2wVJ+pV8Hgh+Xg/FsUFKuoQsxJ3w=;
 b=uj/w7dRU3yxUrAf1jsBoWKH+HGF0MMy5amr/jEh9YsmmmiLUbiM0H+NcNxWo8cWwcS
 nwdvxxWu4qVeJsLtVXmQ/T2sCzBS3Tgxs9itsT72rk2lkR+BzFa7LPLoKd096QaJd7ji
 /5WtxZMq5Jd7qKrxi6sg41s80d94pwXR3v0Buc/FTDQvOJY6wBS92SM2+o6HCgL1A+vd
 Hd3TGihMrnyi3tVUhc3/QNX9k045TXRK+/1kHiJhoQEHbAYXbS2WZhmm+F4Qs+lVBOYE
 8Swc3eunkTd22VE5zvQnmEZ2ZQyNvLLTiIsmbcRmGEyLisGAQsiB2Mw/LCI47Dp8gOZQ
 956g==
X-Gm-Message-State: AOJu0YxKhkQ6LUXHpSfevGPTQrSfdI5A0USMWQykxJ0DSsKy5LvKnTJf
 ZgfMa1/XjUkTkrvvK30AbDo+TglPp2t/HOCxs9VhQ7207o51RzbV6+dwlMx2KLwB3kkEBRjVwy5
 ey6jE0P5Q7ZtvNir/9G+V21EeIUq4Hdbo6ivG
X-Google-Smtp-Source: AGHT+IE7ITxG7x8Yp7WeDN3C67KIDR/sjpVZFieuXErHL9bjYf27zRkdRWLbrNBNIHw2ev1VOn+RmQ7CXH7RKWN9H90=
X-Received: by 2002:a05:6214:5a07:b0:6ad:74b9:c2e with SMTP id
 6a1803df08f44-6b04c08ed6cmr47914176d6.29.1717686257536; Thu, 06 Jun 2024
 08:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-8-sjg@chromium.org>
 <d87e132b-f31c-4b3b-a055-9625fb3fbb49@kwiboo.se>
In-Reply-To: <d87e132b-f31c-4b3b-a055-9625fb3fbb49@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Jun 2024 09:04:06 -0600
Message-ID: <CAFLszTjStfEOJY63CxsgT=+Q+GosQEBVK0ypX0cWmheNhXsKFw@mail.gmail.com>
Subject: Re: [PATCH 7/9] rockchip: bob: kevin: Disable dcache in SPL
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
 Dragan Simic <dsimic@manjaro.org>, Jeffy Chen <jeffy.chen@rock-chips.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
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

Hi Jonas,

On Wed, 5 Jun 2024 at 05:07, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2024-06-05 05:25, Simon Glass wrote:
> > This causes a hang, so disable it.
>
> When I initially tested this on multiple boards there was some boards
> that also hanged, that turned out to be an issue in one of the drivers.
>
> If I remember correctly such hang was related to a null pointer
> dereference or unaligned access in one of the drivers.
>
> Could there be a similar underlying issue for these boards?

Yes it could be. I will take a look.

But given the release date I would like to get this patch in first.

Regards,
Simon
