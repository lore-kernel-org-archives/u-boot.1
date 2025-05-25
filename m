Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36A8C54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 08:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B80D181E06;
	Sun, 25 May 2025 10:43:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h8PUr6JU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1342082BAF; Sun, 25 May 2025 10:43:29 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 180598144A
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 10:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-60462000956so508098a12.0
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 01:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748162605; x=1748767405; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=k5z0MEQkvXSoF8EYWrc6W13fp6egEud7np3+MJnCQ1c=;
 b=h8PUr6JUW00WCD3lacwi/7JJouFttonhfgSTg4XEjuBuNTcghImwD7BrWMR7McyuxE
 sVxjyN7uuXWfly+0qepuutEFU8jQeZjDDwROElhOIFKSBtlA1g+MwuQ2Zt9Hxk+p/S0U
 s8zBLRnd1ssC+UmO0guCV/kNrf9DtSv0EW9Z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748162605; x=1748767405;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k5z0MEQkvXSoF8EYWrc6W13fp6egEud7np3+MJnCQ1c=;
 b=LfBPCu4LEOk8kjpuIlTKsX4hhHSV9IIAK9ghkV+7aIvgXnFcuovr9IAAakMWkXTcAl
 lXxCWrfqMr5TF72CfEn/wC/+8fymI8YEwYtePwYagqN/3Su0SKDN9jhonLyw1VQD5xY9
 g785r4zGpnpw2dQJb4ZLxO7r+IGsSQZCYjvQGNALxn13E1kaRaM7sxxR23jqKJCSnY5e
 CBkbOepNm7elea2CfIb5YXQc10vEg0Y0zOjP8uOWqtCq4lbHckuqstxi9IwUr367FAP+
 52he/US+m11nBaZYytgzy/x8Uvb63GUCtxb5tADNijSLkZ7+rSS3qCvEfQXfSIJ/Cg14
 0i8A==
X-Gm-Message-State: AOJu0YzIysZ9SRXcff1B4+VDTC//WAGSYjjmB8TNaWn9gJvhCJKMTwg8
 Avh7Lw0ecFKyiZpUDeFldYvaecSYjd6NZ9GgOFF61ICbqPjTufv6DfxJCmnDLdud1PajYN00bnG
 4dGlZPAsx4B1N9m43plsLwGC27g38oeqQsQ16gevsDcUobpSsfz4GzTnK
X-Gm-Gg: ASbGncvi0t7HSLjWG8W5jBi4oKnv09cPQh6LJlskup4VkuZVNX1vfUv/1dF4TRI/Nuw
 F783JRqS3AlqbMzTB0vvTPx9sdcjcdABC1M8lbEDFsWwjnPaBFyfuy3ovVFYr+rD4n6K60U407a
 JzfE380ymjdrGmrX4BNb3dFj9i2I49mEA=
X-Google-Smtp-Source: AGHT+IGvkHrECZ3ledWxF8MTB+CShELEAEK1zwcSPezVXiuPMuZytDesECJgskrFzXFiO/fzVDNJUprzlyAH/JOPjx0=
X-Received: by 2002:a05:6402:5c9:b0:5f8:d490:33c5 with SMTP id
 4fb4d7f45d1cf-602da5f8cf9mr4016194a12.33.1748162605493; Sun, 25 May 2025
 01:43:25 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Sun, 25 May 2025 09:43:14 +0100
X-Gm-Features: AX0GCFuOQDGd5Lox_CsWnIYS34s3mY6YlT131ZqQU57OsuRAsXj6JaExD2_vNh4
Message-ID: <CAFLszThhKENznk_+7TpxjtSdcsHB=mosyS=ftqFMUbZAY7xuxQ@mail.gmail.com>
Subject: Bloblist request
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Tom,

Bloblist is IMO a bit of a mess, with 2-3 maintainers who don't agree
on the direction.

You have requested that I:
- implement a handoff protocol for x86 in the spec
- do the same in the code
- convert x86 boards to use OF_BLOBLIST
- remove BLOBLIST_FIXED

I also want to enable VBE, which would require further work. I'm
sending a v4 today.

I am willing to do the above, but to do so, I want to make bloblist a
first-class citizen, available on any arch, built into global_data,
with no reliance on weak functions.

Please can you allow me to maintain bloblist?

Thanks,
Simon
