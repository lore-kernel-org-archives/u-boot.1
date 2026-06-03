Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF81CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 17:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 817AA844CF;
	Wed,  3 Jun 2026 19:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lne3GUM3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21F378489D; Wed,  3 Jun 2026 19:10:22 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10CE483FF5
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 19:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-68d2342c5e6so6159666a12.3
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 10:10:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780506619; cv=none;
 d=google.com; s=arc-20240605;
 b=G9E2LgwsC+dBtmSgyg70ev/kDH7KM4OI+OBYBso61EV12BaBfgAK8UgWjuZnHs9Z0O
 6TsarFcSDnj6/BJAzyxtlT9PxRp1K+zpN1nbjH7jAO6YzSpp2KrzpOpj78gkpn6pEYYA
 oucKFGR9PQuOWv0Vb3PUklOY5qBI8aiFKoWAJaFi+VxnkF/sspk0IvJFRM1DouxrjuID
 ODGI9IzNTQMqRseS2MBsUa1RZbEm1NqdYjr6nt85i7sA/d9O8HpXTpl5UZZZ+TCTCLwK
 Ex0hoC1SUqNxbtU5QEWAzxi70hP/KPalyMq612YUwB+D2C7m3kgIEJYx36ENolCxyxxn
 sXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4h/Azqtra0DyuCTrNV23pjGEz8AMkKd73jSFFldJ4Wk=;
 fh=EBZLrMUT0zzbhfp6aETt40yArpIOKAbpF3eiYI3LWPU=;
 b=iRjT0E/9rjiKaRh12KIbTkKq9xoTIJLIDHfOqaveli3YQpfk6oLw7mlR2gmDKmgXiC
 bdBDS9KCw5ImKk6kiNDsJyN8xZcXLdU4BfuN1Wcm5C5gvdln7j+fJ+wrAfjIEHmeDILz
 FBAALDEMToz6zAIyA31DVQkDmgg0VJyDhhTu1GYg38vMS26Gjke992X8MXV6HaqN4B/B
 7ujFjV2mCX8uzTIOO2KGLcHSGZpXgnuAc85c52qIWcuWyCOvPUHdomJ8IzTLsPBJJTgc
 poyCtXtnLRzXtiJx0Z+ZOnQ5x29sxTK4oZoxUNK0oUkh1tvjShtQ6hUmVy1BS4lcAd87
 i/Pg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780506619; x=1781111419; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4h/Azqtra0DyuCTrNV23pjGEz8AMkKd73jSFFldJ4Wk=;
 b=lne3GUM3n52BpYlDtIqEpcqwWruRINdzL+u2lnghz1/vJvdOWYaoK1VvFm89FFk0mI
 RVJiftL1ZINalbBucVtWNY0uHdlJniZxYn+GWxJPjU9X+Kc8bQpKIGkkA5sA/+WjFIFE
 fHs/Akm9M1fysl7mFxgIWKmcjlfeAHKCUda5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780506619; x=1781111419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4h/Azqtra0DyuCTrNV23pjGEz8AMkKd73jSFFldJ4Wk=;
 b=lrWhmxDcWl9ZVQiYiuEOFdiJz/uikesJCXZreh47En23DDnzdihj/NkjnMSY9qy7KB
 OmqnsCQUQMIIXG1DQqETBkpC7qUPwMQDggd1UWqc1NfNsA7kRcWj9c/FygbimA+xJOgx
 HETIWuzWC3zzRL3Brcjtigwf08f1Fxc1N/FkZY/mPX0vCQPjUXnzBqfoV0yNNLibFEMD
 Xm8AQYzfMZXhIqxG+rZNplv9iWnFJFniuVsZRxDtD4N16C4Bx7oXWAm1tD2w7yrc59XK
 IKG+GKjLcC4nTxtTjMnfb6wk1fVxV4xfr7MOXwWBhwbkQypyv92zNmAlwFOgk2kgSfV/
 9Lgw==
X-Forwarded-Encrypted: i=1;
 AFNElJ995MPqMA9I6XxoAtUwvKGNL7frlJX+mzS7sfTWTF4o7yMt7Nlm4l/VvAcUqUG8vz8Awv6r1uo=@lists.denx.de
X-Gm-Message-State: AOJu0YxarVu9PPMVaVBomj2mkMB0q1KPubTybD48eHs2D9CuOnUr03W2
 Am6aZtFK+CprQOnwWTlx9UrelVPygQ8siIulZXKSU6sSvw+pgrFHgA0G5KAEFksLU+Kqa+KbXts
 eHcSRN0nmm/27vvKxTzzzXAFVLZP298LgarPLRbI3
X-Gm-Gg: Acq92OHK4GGvU7p0FrHsHQRoFys4VlaGP3tnutoWEZ6oC7ZDJ4MToHa62vfjIdJCEG2
 EjvMxpSarVjT00GRqiQ11Rpo7awGZMdsM75TnYrpvVzwMXcfbvHy/qObh/ntwOY9s8GifbPvkDd
 bKJyWh49R5OAclBR8R7qf/lobbaeDjtXB+wGKGhHLw7Q+i+ev37L8M0cV9okrl97NZ7B9cmu1o3
 L8aJnyy+E/ZGB6f9X96P9XPjbXr4BLWHpnMv4RragOxnxyQaATsJ1nN6VVFCouoF17JyA1RnCay
 G9CtVNFAsg67lBXe
X-Received: by 2002:a17:907:cd07:b0:bec:8f9f:c964 with SMTP id
 a640c23a62f3a-bf0aee0b569mr246980466b.39.1780506619452; Wed, 03 Jun 2026
 10:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260602115755.371164-1-Alexander.Feilke@ew.tq-group.com>
 <20260602115755.371164-3-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260602115755.371164-3-Alexander.Feilke@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jun 2026 11:10:07 -0600
X-Gm-Features: AVHnY4I26hAunwFvIBQPDmiiYOwiVp8cjvGp6jfKXSXLANVuqxCDWEYbGKd3PDA
Message-ID: <CAFLszTh2nGbpnaLbogfwgrbVBCMUhRnozXf3f62d-vi0VCySpQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] sysinfo: add sysinfo_get_and_detect() helper
To: Alexander.Feilke@ew.tq-group.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Simon Glass <sjg@chromium.org>
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

On 2026-06-02T11:57:48, Alexander Feilke
<Alexander.Feilke@ew.tq-group.com> wrote:
> sysinfo: add sysinfo_get_and_detect() helper
>
> sysinfo_detect() is commonly called after sysinfo_get(). Make the API a
> bit more convenient to use by introducing a helper.
>
> Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
> drivers/sysinfo/sysinfo-uclass.c | 10 ++++++++++
>  include/sysinfo.h                | 17 +++++++++++++++++
>  test/dm/sysinfo.c                | 16 ++++++++++++++++
>  3 files changed, 43 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
