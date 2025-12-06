Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C169D339BC
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 16:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A46883A64;
	Sat,  6 Dec 2025 17:12:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HTcjmOW7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E20183A3B; Sat,  6 Dec 2025 17:12:30 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDE3B83A24
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 17:12:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c75fd8067fso2301094a34.2
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 08:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765037547; x=1765642347; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pUddFR5Ywn4wvv1I9vXMT/44kt9SmCzcptv71K6BWRQ=;
 b=HTcjmOW7AGRFnxZvB3ZyW6E25Lq7Ghc2cB4WL4UkaGhZo/9Po2SS+z36cs46TyAK/U
 eOzT3WE8B8ViGL3HhWl+rN73haM8F+O67IVBTAsQV39O4r/2ORIpCPoY4UTS9SahyTi9
 NPVzKuIUT368nE1pOGg0vV7vdARooFZ7ZZhGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765037547; x=1765642347;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pUddFR5Ywn4wvv1I9vXMT/44kt9SmCzcptv71K6BWRQ=;
 b=SWKuhka8vFoxuKvX9J5UwBlf9Rb/IbXmf3b6LFaGCZHDuAdnUYr1wdIHwR7Ul5081f
 mMd3wlF9hE7sqTukY7yZ/fl93ccVVZQJhhtwqQVO5Sz6dzbTrFaJA+AiekhxrvFkbYwF
 TykU9+TEoC/TO8XXp/3n7EHZeQ7/vMS9eCbEYSVSU8H6uupJREx6X9FgfDIRumZJ7o41
 KLHNhoYfNmmcslAa5egLk1gDo/uP8cRhNX+Ud9WxttNgGLFW7pLQc4ovfOCgTuRIxtCp
 EP76/U1SW1vw+Ix8UjOSesU77L/riP4Lb95dC9YSJ023tUTMnnNT18gV4y7eIjRKOzb+
 0fxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1H7IHXbhwaYOc2eehU2DiXzN1neiWT8pX/JHB/2yhv8dbVztBHyq7rS34wkAqrkRinr8YJdc=@lists.denx.de
X-Gm-Message-State: AOJu0Yxgbd9CDD6fR9ReMXBi5tiVsV1F9NDpuBA6EBxcAgWOkHHoQmcS
 0dDWgbLH/rg2s66lFydFvCEMTUDXyeggSv0Lns1Pye6bZIBxX7L6qXqGW+evc0yTA26nh7EEZgf
 mMljtvGs=
X-Gm-Gg: ASbGnctbegxBfTmLwW1B1/f7+sGj3uQup6SwqYp45vrHBdB+kFf3AJtDx/z58D2cWz3
 CC7icMKs7U29IBuMuvevxw3a5Lumd4yVFcMdqLUOMCpFzdDpW0Uc8qQEQ53G7MnqRVaUIkvXrmr
 KGHcUw/tufDw6TLMXscHQYIuLGZ6DMq94H30DMGRi0IMTaEEJFidrjtSPV0TPslldWQkpsa/axt
 sAVUlxsgBhpC0eXXVYJlu6TUUgsa3GKQ22dlS8qFFTx9zv5LQSj7ANeb7YOJ0u/64ia+H7dpKRV
 O6QtP/YRdTSBBTLaBgEs/J7AtYri2apFrpjca2CDnW6Bp+iBuSkbYC63jwAVIznLRknoTSItB87
 9q1dxGvNnw38FHeCk/O8vWmfa5kxslMpP8pAnom/Dn7jLThTVPIaAnL7PYtelpvWdKmQaY0vfPr
 YpsSV9Mcrhr0ehjepHAsBPhtHwqIYluNjncLCup2H+PrORdVO7gDXVhR4Oi3k=
X-Google-Smtp-Source: AGHT+IFofaeUaHE6BOYW3GwNPvxKTAVHer0trBJVsFozxDZay/QGIgdcmeB4mXN0KVyyXzR/qjLvug==
X-Received: by 2002:a05:6830:3150:b0:7c7:c71:849b with SMTP id
 46e09a7af769-7c9707790c8mr1432560a34.14.1765037546734; 
 Sat, 06 Dec 2025 08:12:26 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a8fa21asm6946180a34.1.2025.12.06.08.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 08:12:26 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Chee Tien Fong <tienfong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 u-boot@lists.denx.de, Brian Sune <briansune@gmail.com>
In-Reply-To: <20251202041029.186-1-briansune@gmail.com>
References: <20251202041029.186-1-briansune@gmail.com>
Subject: Re: [PATCH v1] update GCC version check after Kbuild bump
Message-Id: <176503754606.2614327.5448152259713464900.b4-ty@konsulko.com>
Date: Sat, 06 Dec 2025 10:12:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 02 Dec 2025 12:10:29 +0800, Brian Sune wrote:

> ARM GCC tool check is not up to date,
> while issues are reported such as file truncated linker errors.
> Using ARM official cross tools shows that 10.0.1 is a safe
> version to support latest kbuild bump properly.
> 
> 

Applied to u-boot/master, thanks!

[1/1] update GCC version check after Kbuild bump
      commit: bb1c2b463265175f05a1e5de7b39de815db1a03a
-- 
Tom


