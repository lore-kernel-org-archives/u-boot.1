Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE75C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 15:03:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7585080FDA;
	Sun, 30 Mar 2025 17:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fXwhfLbT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B74D78144A; Sun, 30 Mar 2025 17:03:48 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB60080050
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 17:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christopher.obbard@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso37276325e9.1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 08:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743347026; x=1743951826; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CiSU8afAg1Zt/e2w0FM8GeCpqI8iOxO+sOkHiNjBzC0=;
 b=fXwhfLbTaBinaPfV4pVlmpmimQ3BCLQagEo49S0gnGe56hx0ucdXQEmx8ULwBos38D
 5saSnPZ9uk9EnwKGeQwgBeXsJxqpnJTMswdHCGS6TLYml1f34kJcMYEf8XFRk4IHvRAs
 /H/l9KIQ9aTxVLYkmFyOxV6hsnY3hDopzj4m9xrZpkrD7KisCruGzMd3WQN+lCrRhAzz
 RZfayMcoNthmPghwvedB9zmhDOmsBGP94AcWazVRHfQg8uvLYuxw++DH66o2xSihv2iL
 ReolltzjCZPFv9GpKWXbTnODp1/KdjImaygE5Mbeh2TULe8P4ymDnfGgKiPZSeBN8thd
 OEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743347026; x=1743951826;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CiSU8afAg1Zt/e2w0FM8GeCpqI8iOxO+sOkHiNjBzC0=;
 b=obmVss9LDXBIv/9pj46TNmSeJBh5jLZlbSo2NR7bX495pyA75HZVRTKq6dbzPG/aN+
 BLPFtjXkVPpTsHiKw12Np1INGbZpnZUrVo19UHnjZKATB/0bjAQ5UqG6Qvu7th4cZc92
 FIVss2ilMhREpuktUzPnqXLmGC4jxz01nwph1TUo+yIArfKhfrbE5t9KmNOX50p+//9K
 cM4bB3yM3hmkRiO0Liy6H8GXwgKCK3A8ajWDajT4LeztnDzx9SrUtWzWngSKurFT8w8Q
 fox2pYGx5MfBR3PF61K/NPU31FvsCCagSt8ztlYzzNeWQ9J8D9XLyhutcRYTcgjWjcMF
 SKcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkPnJK5Gqh+jFdYfmlWIMkaASUvTA57qIw2HvuLwqY6GOCqetTpjtjIVK0tRrT0Rc42vh1r2U=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+4t2RCoGENuSDlSBB19ERqiMCX29caBdtO6R9yAPYcTxJ+ZqB
 IlSFO3NRYqEYTCpB0/7iqPsd22KfxQUBexQT2mMc0icmvQPtx5WF3eyZKA9AxAzwZdZPfTi3dUw
 pRfR1Gg3eVx1UQxRyQ4Jve3sUOyNTiTaisueqJA==
X-Gm-Gg: ASbGncvgNtcHebQ9SnM5y1HD1ckAdS+LvcwP66qRgMGt35yTnSbvbyUy1X5MwXBgZzT
 Ps8JFX/Nn7bz6271bMSDHturzkMhXxvwBbS24WpOLgjmnpzMW0tn4TyHbW5KFo6SCok4lKBpJoR
 j5BUS9wyerEUg6SSBr4yjz0liBG8Rwl4psWqxLpYzivp8vW6z9ViJJAdj6c+U=
X-Google-Smtp-Source: AGHT+IFrkDqGBhyippOVMLtun1whqDIT2SMCtAOQU8bY7PqEgLASpm3jsZBjdNQxTWCe+inVI+/Qoy9n3Rgnb3Ao/Nc=
X-Received: by 2002:a05:6000:2c8:b0:399:795e:d899 with SMTP id
 ffacd0b85a97d-39c120db609mr4393298f8f.14.1743347026098; Sun, 30 Mar 2025
 08:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20241220003447.2913443-1-sjg@chromium.org>
 <CAFLszThUo1u58Vwy77UEQZG79f7-BB2ysB5-oq-DHbP4c_ciRQ@mail.gmail.com>
 <CALeDE9MFGFEUmOHyOFFyLL4TeaZKjDSt+LBEfNEGgHSdtwDetg@mail.gmail.com>
 <CACr-zFCecvu=VGp9ncHSF1QY6U-hu_NgxLoij6O5n8nsjao-Mw@mail.gmail.com>
In-Reply-To: <CACr-zFCecvu=VGp9ncHSF1QY6U-hu_NgxLoij6O5n8nsjao-Mw@mail.gmail.com>
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Sun, 30 Mar 2025 16:03:35 +0100
X-Gm-Features: AQ5f1JraDnreQPgclTWPqb8cX-AOUnK0rPK2o6EyAibXhEFoBoZI9Y7LlCbgAME
Message-ID: <CACr-zFCzVpnstegc6yr-BSJ7SsveOBSqVVHEpWRAA4abEz99=w@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] rpi: Tidy up booting
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>, 
 Matthias Brugger <mbrugger@suse.com>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Ivan T. Ivanov" <iivanov@suse.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
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

Hi Simon,

On Sun, 30 Mar 2025 at 14:29, Christopher Obbard
<christopher.obbard@linaro.org> wrote:
> Side note: It would be quite nice to add kernel_comp_addr_r and
> kernel_comp_size to be able to boot compressed kernels; I will put
> this on my TODO list for some day.

Please disregard this false information. I looked at the diff again;
you already added it in your series. I also tested it; works well!


Thanks!

Chris
