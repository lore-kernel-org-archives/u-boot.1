Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDCEE77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 19:31:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BD878043F;
	Sat,  4 Jan 2025 20:31:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gcfng7sE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C2C58056E; Sat,  4 Jan 2025 20:31:02 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F919803DC
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 20:31:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d3bdccba49so24185096a12.1
 for <u-boot@lists.denx.de>; Sat, 04 Jan 2025 11:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736019059; x=1736623859; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=otIfT4YW5jNThsKFq1bQR4qWKJLmRkrk4IRwvXcfey4=;
 b=gcfng7sEfUjMwNFfbU+0hCbwONnBnVIa1cmaemDyyXZDVRPXwKxJt53wWnmYK1deP9
 noWDI4HpHDRd+IWd8sXY7rcAMMR12YWhripL3X5CTDsqguK/KZkxcSJAIDGwZuQONOZr
 a6mbPBoWvzYZnH3+M+lwlCtoO0nJjQHQ8dAAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736019059; x=1736623859;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=otIfT4YW5jNThsKFq1bQR4qWKJLmRkrk4IRwvXcfey4=;
 b=wh8Hm2pXHJH6L0y5HP6c8iWe60fwDqE/O1FJJndOfmnd2HXHgzi7OeD0xfJ7JEK3XD
 AEkoPwlbnxK/Z6mATbyIiXz20283gvYReDtkmjM9KoKIhabxVnxOHFdli3jY1FFHq+is
 RRNpCH+J/JmMF0QouWJIRTf8BQ+G4MBWmWL1VNnlsPaQOWkCZ19pFp0z8Zq38le7wBvh
 09HIRI1LfA5GaLaXXXKI+T4/+7QwjOpY+qsK6T0nGt94eGUbFDWDznrECcriYNHNg7nT
 oc8LGIh499zDB+VhBjDzrs1hQ6WHZUg84MopFcoT2z9LqYycFD2MM9xPPbQr/u1HcC5t
 w1tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ3JC87Vx5zwiVZ//kDVNp7ljx4nTy4H23BMOJEPnyY7/8NqVebTkW4ViB+BqDLU6IxN1qgCI=@lists.denx.de
X-Gm-Message-State: AOJu0YxXDgz2AnQaVSXpJWcLkKEWuhm1mawPZOy7PuIp8EeT4h2MNL/M
 6zWXQ4Y0vBntIEl94FTNKvq1Ho0E5gX3wY0yeNf9xzOW7eVgXqvfMAOspzGaL2JfXP2qBup+s+X
 zfMyyxGjv81kYpBEtiXc6LpAzQGamiRw0gse8qZR7/R0/2to=
X-Gm-Gg: ASbGncsSCehybKk+JV9bygZNjE6gQkAr5UKoNn4RyahTJaRuVPvG7TMqEeXlsqfkquR
 VUYYhtfsnQUMsZsCfWXk1PHpL1hTM2dD2RJUIS6QV
X-Google-Smtp-Source: AGHT+IE1dBxFDcw1dKrvuf3br6jFt3HQCowNiKFjJeQ42RRaY83ryUnl1veFPFQpUwb6lfXw8e6PNGNzGPndKgP2Mis=
X-Received: by 2002:a17:907:980e:b0:aaf:3013:7f8f with SMTP id
 a640c23a62f3a-aaf301382aamr2235381066b.20.1736019059270; Sat, 04 Jan 2025
 11:30:59 -0800 (PST)
MIME-Version: 1.0
References: <20250101221003.1944600-1-sjg@chromium.org>
 <20250101221003.1944600-9-sjg@chromium.org>
 <923dbaf9-47e0-4e48-a0ce-f0afbe32d1b7@gmx.de>
In-Reply-To: <923dbaf9-47e0-4e48-a0ce-f0afbe32d1b7@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 5 Jan 2025 08:30:49 +1300
Message-ID: <CAFLszTjRfB8dL3G0AcEx0=PknLFozDaU9c2EqiVfP3U2e+2xjA@mail.gmail.com>
Subject: Re: [PATCH 08/67] x86: Emable meminfo command
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Sat, 4 Jan 2025 at 03:51, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Nits:
> %s/Emable/Enable/
>
> On 01.01.25 23:08, Simon Glass wrote:
> > Enable this command for x86 boards as it is quite useful for seeing
> > where memory is.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Enabling the option by default for the sandbox in cmd/Kconfig and for
> x86 in arch/Kconfig is confusing. Please, use the same approach for all
> concerned architectures.

OK.

>
> Why do we need symbol CMD_MEMINFO_MAP? The meminfo command is worthless
> without it. Both the greeting header and bdinfo already show the memory
> size. Can we remove that over-engineering?

I have no objection to that, but please check with Tom and Ilias[1] [2]

>
> Sending standalone patches separately from a bulky patch series would
> avoid hesitation to review and merge (see Tom's mail).

Well, thank you for reviewing. I'm going to figure out some tooling to
help, when I get a chance. Then I hope to be able to keep track of
lots of independent patches. Tom has suggested that I just send less,
as well. Another solution might be for me to adopt several aliases so
I am three different people?

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20241011214032.760072-7-sjg@chromium.org/
[2] https://patchwork.ozlabs.org/project/uboot/patch/20241009015020.25817-7-sjg@chromium.org/
