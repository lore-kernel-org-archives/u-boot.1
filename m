Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FE6C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 16:28:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 863EA80312;
	Thu, 16 Jan 2025 17:28:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uHaepCKP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 741298033D; Thu, 16 Jan 2025 17:28:24 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3654380214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 17:28:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e455bf1f4d3so1614272276.2
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 08:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737044901; x=1737649701; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8wEMO2ZKEezVjs+v0Upz6USyDZ1J0DGEmkIUYvQ2wTw=;
 b=uHaepCKPCwTJT+nbhcDIIG6+dmphnvSpHENOjkLH7C6Lkjnu5ubbfSBRqvhdPp3WZ0
 aMy8xM+hAZoJlEjXBY4NHtlg9vUeU6iwRoOiIbh73alP1YHZYOVg26e1mQjytMZAovzw
 wV73/KjY0AQEsrrQ9HTrjdlwZB+NGT8Ad7rPFRM+ZL+rts8hQvciLWyuMdCHeCQbHJ73
 A8hwFP9cB3TJ4gisYNQwDI7uZ8zJX+ppSkAY6Yoh2mZrYJh6LfG0OCmKSbxWjGzz9pYQ
 v3lBy1EavB4kdEVdv6AzP4OLB3Z//lbvV8yu3dCLD258K+wZ7QZOgCbuLQ+cFV58DVV+
 RxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737044901; x=1737649701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8wEMO2ZKEezVjs+v0Upz6USyDZ1J0DGEmkIUYvQ2wTw=;
 b=qy+d61eCMkeUDJukOQRZEVmtIsB8xhTprvCiAfZEDQS0eg9hQ0P2E2ik1utqDFn66P
 0Y1oePwQgJsCc/S8KhBYUedt5I3rSSpHt1FoBAz2wFXcMtzhGH7RYxlfDnz5L+7gUnhl
 G3qQZrfoU/4KN9MnO7Egn5HtQqUsGOpytG8V3RIwKwV8UiSwG1BH+2X22SlL7x8XUjqv
 eQfJRrEG/wMP+A3EfAcG89fQDjDqyZrJ1qEbvCHS2NlqJhMeD9n1PMLLxBocluoOXChn
 7xdugfz1Ca6+S5RlvDKSnqkZah0fTGV6UUru7DjCqCdCtWSYSPoARse1SxoqA10BNgW4
 JF3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn5S5L5x6kVEDzzWxTuHKrnlDZLskLyI7hCohJYZrwu9FmV/oDtQFCDDzJnU/dQEAb85iFqfM=@lists.denx.de
X-Gm-Message-State: AOJu0YxF6fd5C3pKV6NGh/lrOWhnFrFIzt+sDnZPv+QhUPf2VSdbKcyC
 0a0vwKOHaBJsWLEaH+eqHqyvKbRfajpwMFjJfYlB0UdUW3k3CfiUgyeTmDDSPa6Cx6NhGeaNEoc
 GFTnXTq1MTS6+S9zjj65CM7EHP2lASUQGha/MrQ==
X-Gm-Gg: ASbGncuVhvKGYituk5nDWC1MaMj/MFU3ZnvIRw6In8zOf7G4Y0OCdKqTJXHMjotzRIo
 wdco+eSWBw2/TGXBmyWQ8pMa219piL7gxaSGGGA==
X-Google-Smtp-Source: AGHT+IGGqeF+/t4NZ8jqAoo8lvcbqJA4WoJjG9ttfwSexyAH25gjaqvbuvrANZ4rdxfrNsF0vLgR1D5X3sdYDHTIjzA=
X-Received: by 2002:a05:690c:6b03:b0:6f6:cd43:5468 with SMTP id
 00721157ae682-6f6cd43561dmr62431147b3.33.1737044901094; Thu, 16 Jan 2025
 08:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20250116140617.248830-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250116140617.248830-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 16 Jan 2025 18:27:45 +0200
X-Gm-Features: AbW1kvYS3lzFoiT2z9JKA9m9SHU6z-Cbn1sJaj1avKzeC1XH3EuAjC6MkYhC3Z4
Message-ID: <CAC_iWjKfvdBnWJuCwam7eERVwGXP=hZzCZ5WAp-bvQGe=BE7dA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Makefile: let clean remove
 capsule_in.capsule*.efi-capsule
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
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

On Thu, 16 Jan 2025 at 16:06, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Update the CLEAN_FILES list to remove capsule*.*.efi-capsule.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 0500eb6e0a7..70d74e2e9a2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2218,7 +2218,7 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
>                itb.fit.fit itb.fit.itb itb.map spl.map mkimage-out.rom.mkimage \
>                mkimage.rom.mkimage mkimage-in-simple-bin* rom.map simple-bin* \
>                idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
> -              Test* capsule.*.efi-capsule capsule*.map
> +              Test* capsule*.*.efi-capsule capsule*.map
>
>  # Directories & files removed with 'make mrproper'
>  MRPROPER_DIRS  += include/config include/generated spl tpl vpl \
> --
> 2.47.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
