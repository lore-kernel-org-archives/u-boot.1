Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C73CC54E65
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 09:09:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97D9C82D59;
	Wed, 21 May 2025 11:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NzMa1HBY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2833382D6C; Wed, 21 May 2025 11:08:58 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14B8982D2B
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 11:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-70df2e31510so4502317b3.1
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 02:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747818535; x=1748423335; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4Da0BxBaHsX0KixEsNmkjCPuxSEHcSw+Nh8+zpLMfHI=;
 b=NzMa1HBYwVo7Eci+XJNB0rVLvr4Bh/8JiOUIZfbhnWW8yMURjPCvxrOjkQAJnLGn56
 U8WGN8XosOgp2uoE/dOHNSSTDkj8MUK9DLp0wE93HVtEMamQ4s8ElbLNnGqtQg9qPIDL
 zzLW7RXzJ7rfAqkD/QESpfNTq4LNHYr2JBOVVmPTW3cPEzEoLp7qxRWKRwgXwRPBhInw
 kCM62GETu9l8or4LmUGxNW9QU4nHTOcCgvUW92VtIIXsUDMk/wpV4GdRuB/y3Jt3c2KX
 f++zSsfyOYrZijwcorIasLWJqoNq5XnK5MAWzsVXtc6EPMsiP7MF4q7yk6i6Fn1BEkD1
 Bk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747818535; x=1748423335;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Da0BxBaHsX0KixEsNmkjCPuxSEHcSw+Nh8+zpLMfHI=;
 b=e+qZbCOH4lw5DfNahmZWxz2LHAWfY2zwfHJeepCLk6FP6eY3KQNozGDdKUPBCVJ89z
 XTBRWN7NXeFxrcmGvTumAAeZYpD9DGSJ4UKX1PQ3ZySp8mgMbaRiSaz3CFIG0TmQQhfH
 vkmO7RrfBk/kSSGUAxpWkHjC7N8raOo8/p0k1CEY5yTgX7BrgypcUs/EjfHeauK4DRj7
 W3nPIYnf/r7fpkl1sd5gZB7xUTys9pHa5chUX9+dPv9SikYfxZoQ/QeaYD0uepNj7oiV
 SnBoVURKeMINFkLNcBesJZds4whLgLzrfBj5dskMQ5lmzLFzZzkTUsWWQl6TX85xdEJm
 kGTQ==
X-Gm-Message-State: AOJu0YxQK0RIWZU8Zx69Ha7aZcb3GTLHD6/aoRrNnKH5YbxR7ESsLOui
 5AbFwOWIqBzPXNXxu4LRbhxkJvpUS3y4MZGH1BsvkaGS7zFO7fXGlWykXWeUp4UvPy2VuE4mN6V
 Cr0ZceP8bOvdgLNvmXF2uUd5hfYBuTNUJqL3fwF+2L7+KQvdf8DVy
X-Gm-Gg: ASbGncvSYvGEb+Khq5SHV/1D6cyH0CoYJn+3kVfi71C1lCAlrmbI5e3iuK4KIERpw6w
 hdztu8z43uAZsEPXKmhM5vIqwHLb5I5oXUaLrz1pHVVYWaSIERe4FyvUOSewnex3n1AyDR0bW99
 zn5R+n+Kap5Tw1AupZze6Hrb1VRkm1be0clI6NAp/4xMLt
X-Google-Smtp-Source: AGHT+IE9vA4DoQ3ZxiOFJTn0YgKUplp0f/NVXN3+Ii/JrfdQ3lj3YiUTuk/M5hplDvyRZNJNNCLQOngYtTs+kqX0VyM=
X-Received: by 2002:a05:690c:3708:b0:70d:cfa6:3a78 with SMTP id
 00721157ae682-70dcfa63c61mr138474687b3.14.1747818534945; Wed, 21 May 2025
 02:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAC_iWjJirOoP49HAzMSmnK0B5fZji9+-GAg7Vku3DWOZ6DQOhw@mail.gmail.com>
In-Reply-To: <CAC_iWjJirOoP49HAzMSmnK0B5fZji9+-GAg7Vku3DWOZ6DQOhw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 21 May 2025 12:08:19 +0300
X-Gm-Features: AX0GCFvweQlbJlZqboZT2uryj5uU9lu9YyZ6EwsdcHwm8W0-MxvQdgrvgchqtHY
Message-ID: <CAC_iWjK4U9KEdYkkkKb2TB4p+VJFU3DVFLK8fUg0druZpiZ4tQ@mail.gmail.com>
Subject: Re: QEMU & KVM broken for arm64
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andre Przywara <andre.przywara@arm.com>, 
 Mark Kettenis <kettenis@openbsd.org>, Mikko Rapeli <mikko.rapeli@linaro.org>
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

++CC Mikko who stumbled upon it

On Wed, 21 May 2025 at 12:07, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi all,
>
> Starting from commit 53d5a221632e  ("emulation: Use bloblist to hold
> tables") I can't boot U-Boot with QEMU (version 8.2.2) & KVM anymore.
> The command line to reproduce it is:
> qemu-system-aarch64 -smp 2 -nographic -cpu host -m 4096 -accel kvm
> -bios u-boot.bin -machine virt,secure=off
>
> commit 24768a23a9b3 ("emulation: fdt: Relax condition for
> OF_HAS_PRIOR_STAGE") boots fine.
>
> Simon do you have an arm64 host to reproduce this?
>
> Thanks
> /Ilias
