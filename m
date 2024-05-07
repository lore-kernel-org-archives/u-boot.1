Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8785EC25B4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 14:03:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA7D488742;
	Tue,  7 May 2024 16:02:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TE5kSGFQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8444688743; Tue,  7 May 2024 16:02:58 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5326388719
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 16:02:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-78f05e56cb3so235093085a.1
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715090575; x=1715695375; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fFjAida9kmWpTDPtLXm06WN2aJDK9pDDO07PMGoUYbU=;
 b=TE5kSGFQEc51QkRnnoRfdEI1tBKT2W/RvRD0wyW078GF2IXN4PUFfF2chAp8C+xAg4
 lV+hVe/tX1yKtE28x9efyqZ0TXSO+kVAPYuzRXCUm8HfvUZUwDFweWbiia17OP4mv/6E
 VHdVs1LLbE5+eRhGJjyB7bdhAP3lJNTpPiFt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715090575; x=1715695375;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fFjAida9kmWpTDPtLXm06WN2aJDK9pDDO07PMGoUYbU=;
 b=BqrToKvjMpbZpi7VkyImlPMNP3iYP0rN4OgH1Xl1nhBk9pr/pyaq91Vme0KVfs91Dz
 8PiG2MOtA+Zg2voltV3WPWcEZfC3waRi9DPuFI+OrIHNfhyk3M9ZTMtTH4mZQge7olY9
 ncXAK/Mq1mePwpFOjPwgBznl5kV/O3dQwSP9yEcTkKnm29UKgZstyvhEmivoJzWqqJIt
 QntTsDfzWHSJweCickdQAu3OKfKM6HME5jj0mjXWhGSpzcNXPwXepS7FHDWRGgCXLIqx
 xrQpPr6q2hetfTKiwnvaa/GyRkdaxcW9hQUJLzdOp0ojpvd4T3ejGcY3+mYIrFNATWUC
 iZHQ==
X-Gm-Message-State: AOJu0YyfXW1Sh4+CS+cnRJgL4wTgbHR8EmfnGM1x4dI11xzjf1SeHRyB
 6XaBJ14f6RiO1EYqx1kImOxQclh5cxdURaFP94PCmvYZIEMl2fD3xoGAyYh04ZaqT3A9iCbKWqO
 pPUg=
X-Google-Smtp-Source: AGHT+IFYICn5dCsKY6kBCmmvsmbhpSW6rXIC7DvQlOVcWY9F6R3TKmeVCUmPy03kzaKiPmogGUqbXA==
X-Received: by 2002:a05:622a:316:b0:43a:e9a6:47f0 with SMTP id
 q22-20020a05622a031600b0043ae9a647f0mr17212633qtw.33.1715090575053; 
 Tue, 07 May 2024 07:02:55 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 ge16-20020a05622a5c9000b00437543e5307sm6460400qtb.40.2024.05.07.07.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:02:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240427141106.3406000-1-trini@konsulko.com>
References: <20240427141106.3406000-1-trini@konsulko.com>
Subject: Re: [PATCH 00/18] Remove <common.h> from a number of places
Message-Id: <171509057423.3014396.4861316399292942473.b4-ty@konsulko.com>
Date: Tue, 07 May 2024 08:02:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sat, 27 Apr 2024 08:10:48 -0600, Tom Rini wrote:

> Hey all,
> 
> This series is the next step in winding down usage of <common.h> in
> order to be able to then remove it. This covers not quite 25% of the
> remaining users of the file. Of what is left, it's either arch/arm/,
> board/ or drivers/ code. I am likely to start tackling arch/arm/ next,
> and depending on how exactly I break that down I may try and cover some
> board/ code as well (for example, tackle arch/arm/mach-omap/ and
> arch/arm/mach-k3 and board/ti/ (and then the other vendors too..) in one
> commit.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


