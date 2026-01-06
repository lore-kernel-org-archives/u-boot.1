Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E0ACEFCE2
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 18:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9440883F8F;
	Tue,  6 Jan 2026 19:49:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rRBEomXe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C671D83B9B; Tue,  6 Jan 2026 19:49:16 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A82683C08
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 19:49:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c78d30649aso891755a34.2
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 10:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767725353; x=1768330153; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9DOvAIz+K+a8ICBZeUtOcmsimn12TA6h0OYfPVqx1X8=;
 b=rRBEomXePnDhotUTU2ljusTM+8WGHUgTzEMXnEQEUlgtmkFN1f7F8q+YmSSAaHlIDq
 Hn2YdilwTl5vl3+tRgpzCPkQTVbFH1i9wkCKHMnxEjHF5DKck+S6VlXJlrNQpJGcyBhA
 /QBFgKfmuA1W/7QhhfZwK7MEe/okmt6fFdwWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767725353; x=1768330153;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9DOvAIz+K+a8ICBZeUtOcmsimn12TA6h0OYfPVqx1X8=;
 b=iEkWDKajzcINg0eugFA4BY6eqnPrxnApPK/y346KjCmjG93WsvZiPimdsH3M7kzxl8
 Ab+hEtzVTB+Xr4z3fubdbYIs8joKmMSPL/y8AuFDCmZHcwfpyqi2wO4UMY0eO5INmbfa
 jGghZgm1wHOwM3Ei/nDk4Iu8oFM9ckuBtDnWT/ZGclOdyDWekvwhJM0BPbFKAanW0Ltw
 P6qeN5JzSuLOyvfAaaBc4lwRZVarkchnJFxFvA9TgFBpY4bN+0hveO1mOte4QwlwWRNJ
 a30V2xpZ2STYTBVHML3JRftn4SjVBVL6oYm73BQz0PtSMa2BL93yOWjJ39xQFU7xAMSl
 Cv+g==
X-Gm-Message-State: AOJu0Yy4vqmS7rHBj7xkyLYCFquOQdYsc10vWZnGBMnUjgXImiryqMJ/
 u7Q5KGSFk6WHcNd8O0rv3pdoW0Uqb22/cLdNDg2ar4tO6PURnO3P17wYzPUf4SNXbIqo+rGXcX6
 77TAwNw8=
X-Gm-Gg: AY/fxX7pP60kEtPqCdzB5CuOCa2838hRUi6fvdi/KprVZFqazHxubRAdRSrkI4BU/G3
 wnBGmLPwLtsJg7k5wT4vehc7ksERwOOb+TWMqwe38v1lGd0dHXX/gUyMuBprE7qvG4LfBYrclx/
 KnRf8c2W6g7LozzdnZQZ1Eo7z5iXGKdaGPWEB1vQ7ouJ8yTxLWUOtMhTvLC3sHT68k8QmTWnDiv
 KeZli2Z4nwp2NkKrcFJImKTMidcV8YAfV6Ijd2TOrbo6vZnpBfEOmfctbXEcNHo8U8dB4/aEbil
 gBRwIQDOwFzgnE1B7dUNU+deP85xriJN1n968u3AYGoR1I+KZ7f5npDiQOi8DHyh65rQbtdsYji
 u4aqmbV1Pwkq+SS7m4Un5ZIWvPp57PfaUNJmBdnM9DgrxiMScBii2j6oBlq5aEduaCqFlJRwj6K
 Dpx5ql127bHtHkiIwxVLutjFu3TVC9e1xVzvsQGjHV688SUq+k0so1me8cQovdN06QQs8oS2FZt
 QpVtuAaf7Rr63A0VBJiXOA3ODR3eMfL1wFiPw==
X-Google-Smtp-Source: AGHT+IEzoi1VInXWBQaTlvoPEVNPNf2NYwkyET9GiL3+R8y+PGi92DoAM7/vDIa9knYQq8p7khIdtw==
X-Received: by 2002:a05:6830:83ad:b0:7c6:cedd:8bf8 with SMTP id
 46e09a7af769-7ce50a36ea9mr80600a34.27.1767725353352; 
 Tue, 06 Jan 2026 10:49:13 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478af63bsm1833993a34.16.2026.01.06.10.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 10:49:13 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251231171342.3046889-1-trini@konsulko.com>
References: <20251231171342.3046889-1-trini@konsulko.com>
Subject: Re: [PATCH] CI: Add "allyesconfig" to one of the build jobs
Message-Id: <176772535280.3680613.17549168964530989747.b4-ty@konsulko.com>
Date: Tue, 06 Jan 2026 12:49:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 31 Dec 2025 11:13:41 -0600, Tom Rini wrote:

> Now that we can have "make allyesconfig" build and link, add this type
> of build to the job which builds host tools as well. In GitLab, make
> this job rather than binman testsuite be the job which unblocks the next
> stage of the pipeline. This is because we had been using that job for
> "sandbox builds", and now that we have an explicit test for that, we
> should use it.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] CI: Add "allyesconfig" to one of the build jobs
      commit: 1d59479362c7f6a681a2b3c14e97edff7c0f5a7c
-- 
Tom


