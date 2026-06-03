Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25766CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 17:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A76C88486B;
	Wed,  3 Jun 2026 19:05:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZS5IKCq6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 601858486D; Wed,  3 Jun 2026 19:05:52 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A05B83FF5
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 19:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bec429c2bb1so602612266b.1
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 10:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780506350; cv=none;
 d=google.com; s=arc-20240605;
 b=Fozm40frjf7hMVwqKf4kIlwerDRL/u2qTrUYtQbP++wedAvtIG5N+HDiOS/1pms4Bp
 eTL3vNTTO7x2HsgAO+iP1Ji3PGEU6mxJNRy6T8x/Lj/Mx0or3WU0NbSTR5GfGmMIjGUu
 RwxwozMtWsK3yQcZJTNuibwtihUyRrLT9MB2J6pORljRGvqJ4wvB2wwi/on0LqbK71lx
 eCSsMLzOqqCbyJvSUdw7H8WEMk8Mj+UEWs3zKc6T8WZxuXjYx1AZkjXLiCkw9D/zJlZI
 eSfHAu/8FsGhw0puPj+QqzCpsbY7sYvPb/70j1KDFKC8lz6Dir/qBmFnOXSRwDZJAvnI
 Q8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dJTvAdxDVRy+EKgbsjPOA6oKCea4k1/vlmJQk+zNODA=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=S2nEpUme/uWcyjM4nhumoUMrvznHPR0eB52VF61SyYRpkyjgJLRRKBUXM3VzvDtnxL
 7ptce1k3eZ6YesSiLLJWArTbF7XVxt/7GnCq/tzwdJXQbhOMGuRlk+QjvD4pXhO/Zuob
 E6JBGkaVwuv7pbhUGHh98B8R8z9wKH6lTrRYZuWiDULa3tmp2mAGdiKN4pqn0d4AlZX8
 qEBQxGSvEj2uqM7zpLWT20fm3oeMVHRIMpAzBuy1KRHl/bTMQr0BEgizC8tSWhuP9hyg
 uH0AcHROisy383pzntMpeZG+uFITcdotH1rJfeWeMtY2ZeyNgaPaYPBV9qoyum+VVLrG
 eP6A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780506350; x=1781111150; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dJTvAdxDVRy+EKgbsjPOA6oKCea4k1/vlmJQk+zNODA=;
 b=ZS5IKCq6nrDCbWuCguVdSgzqzwfb02u9gmR/oWegv2HnVs42aNGjxy5yXyAFsi6gJg
 eEmiYgn2KAT2GnjJY6L5JUjVo7r0sXDDsEgKBSciTt30cbMx7UrlJessTwlYbXyWzuyj
 xTfwGKDOH/P61CVKCMEOJ3h+Wm1rFBLNNTGuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780506350; x=1781111150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJTvAdxDVRy+EKgbsjPOA6oKCea4k1/vlmJQk+zNODA=;
 b=GTeX/UZH2aR2G4XyQ9vmq50KmZJF72+6vQWzj/8xdC4I5M7Itr7Yw+P0/1S4WIireG
 f9lfj9B07OvI+RtAM6UHEPV9jcuSLXXw7mGSlh+hGZw9n2tR7e0XJqDbUzuu188V2us6
 TDmOQB56N/kXrhZ6C4qh4mBzjXf71ejGZkkzFGzzaziqZ9LWZQIhnuyv12E4WZ6nXECo
 4kRZ/ZvO+WWyjp11Bu0Qvpq1ep0NFupMMU1srP9FcfECaNK7oUfimq41jr84lH/dcFKs
 iWbCvRbA15mtj60XVDrQOTuk4qm6mcWlF1tRLtDTvz6/eJNgaJ/rz2+AzSK44fjFhvX/
 vnIw==
X-Gm-Message-State: AOJu0YwmDuBT83s2mwlmtbRnfh58Dtke4btWnRuTuxVw/8qtH75fhVmB
 rykO5iS8rj9JAdTwQKfVk9WpVNuj66ZNL5/kYMRGZw3RalzNCwPBLTQfMw3FVeCudhZZ+btz1wm
 kt1nmGtWAoH+2WY1/sLKPJ7VCY3kw0emigXgWfuWiNFabr6BG9s8=
X-Gm-Gg: Acq92OEifURUi31rSb2yYiYXfTLTNH1NUk4EXHh30ctkezm7FBICldIsECc+6LdFyJg
 7NnYBebvB7jGL6XbthrESHhWMxxDmodQfcxN8D7xzixY9OyAwOaqEEAv6WtjLDVvKOd0zBUoGJW
 3kHdIvyZVGRGY/XJfDGjZ9oTiQXvgEoYaDZ0LBK7JkXQ+dVHGAe/r4MJQq3GRYxFj06/VtWMl94
 P5/6J6tLdPVNiI1PUDA2DZyB20EEQ7bjtv0EkrzJl8T/GfgIUuDe7+DYufNCKQJibdBlbBWx5oQ
 1b0wC27A4ppd1Uxb
X-Received: by 2002:a17:907:970a:b0:bec:a96b:75b8 with SMTP id
 a640c23a62f3a-bf0ae40053fmr252919966b.32.1780506349949; Wed, 03 Jun 2026
 10:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260603070743.1268544-1-dmukhin@ford.com>
 <20260603070743.1268544-6-dmukhin@ford.com>
In-Reply-To: <20260603070743.1268544-6-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jun 2026 11:04:57 -0600
X-Gm-Features: AVHnY4L9JCwvvkGCa8wDnNm7HfkSiF0sGnNMwDVPachvDdY6fMurrCEIEJ49Gjo
Message-ID: <CAFLszTjzxF5QkN-VSNJJC36=R6O5c+447X0U-D8+snrF0AzExQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] reset: x86: Use cpu_hlt() in efi_reset_system()
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

On 2026-06-03T07:07:36, None <dmukhin@ford.com> wrote:
> reset: x86: Use cpu_hlt() in efi_reset_system()
>
> Use cpu_hlt() in busy loop in efi_reset_system() similarly to
> pch_sysreset_power_off().
>
> Note, this is safe for __efi_runtime-annotated efi_reset_system(),
> because cpu_hlt() expands to a bare 'hlt'.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> drivers/sysreset/sysreset_x86.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
