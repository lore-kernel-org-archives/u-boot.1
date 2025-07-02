Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1DCC7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 06:33:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 187F481FEE;
	Wed,  2 Jul 2025 08:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dn0Vu38G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D0F282103; Wed,  2 Jul 2025 08:33:41 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 042D08003E
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 08:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e8600a33792so2903811276.0
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 23:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751438018; x=1752042818; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AuX3kLgP6afD0k1E50wNvD5wX1NHYhBDItNq671t0Nk=;
 b=Dn0Vu38GHteWHys1iIPe7j3ZOm5PDUu7alR2HM79KH/YY9EIkiZX4d9FvXOaYRsNAs
 tgcIV02an9FJsgOVp0IEd2spqPN4eHoJAPgrTR5u+i6vauF+E38GJBcpLIIHtQLPKjqj
 oCewcftq0Hcbc7DqKfoXCC7dFvIiUPGJhEkvNeLmwPk4z3A/2WfczJydaYafIz1CNM5t
 azXD7blE5jvH2j+pL385oBKxZXdrKsE+LNHjECI5TNqFhEuvztsoWzxsPqR3IxBy1asn
 PqJW0FjaNCT33iYiFSSJxps2Lc7dyeWFF3NkehoNLOyDOUTBeVePuBbtG9PA/iUvJujS
 Yorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751438018; x=1752042818;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AuX3kLgP6afD0k1E50wNvD5wX1NHYhBDItNq671t0Nk=;
 b=knXHHPitoz0Gdr8NW6QJ1FKi4RnmMYaLmBUFy3ywmBEhS0oHsJE8jWbghDe3XQI19l
 Jddy6IJUi+T+PbQNJDerChGdg6kRxMDs7Gk13d8P+jGzV/vPjHZ10uXKfNfLccSilidY
 duETruSa8LjyE68SDS/M6Ur5CtjfWXndsS6pXh7E6YnYBcUimJ7g2LCbnCJ6gct1r8/W
 Zy3iRlVrDzvyvxtehXHmRbAZpraHp5BYlOTTsw/hlFewgGgoVyIzziQkoXDNw7NPgy1W
 F9vY5evMP6SvIvjNvFznrhZub1kB8/ILLOe/U9g0wpWqvFaQJzWpdfWHpxEstksme5SL
 /XAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoKQcfPZlK1cpxM40w8usb5OAqDeAe8jPdJcZq0iVdpe6w+LtIs0btcjKNTVzgy6vEvi94hcQ=@lists.denx.de
X-Gm-Message-State: AOJu0YznGUpuqDP1cUd9wQzH6kK/gsvgvYRpLkqt4umKa1+yylOpe5Zk
 NAC06xQ7tm0uNjjJ46tWaQRmNJcSweYLsIjFfJRR7RJ3ClCddAVvWeuRHaczvW9akYqUS9+k5gk
 J/H0HOuRr1oRXValsJ1SGVJjgRV6AWykgJ0DmTCrZGKyQdDER8/npe08=
X-Gm-Gg: ASbGncu7lErx3QB9eYF0IqxFiVGBgP+tUhvcT8newVoT75e139jkVFTJkyA0USxh87h
 xtfHKRWrsSFvx+4ySSmytSSBILqTgW7HJR/UzMRJ5g9wrByYEIUbbGwLXUEmzNr1MFYnR5Y9rZK
 tgewCZXAirPEKt2nauKE2yJ+dYDrVqAw31qk2UN8+Uy3k/
X-Google-Smtp-Source: AGHT+IH3uDhUw3ehcNQVOqAas5oGHXGLxyGegRbRjSlV3JU/iHCY/4g3x1Jx9QHei0Qwirb/S/CJ2t3kjxkMyInA7UE=
X-Received: by 2002:a05:690c:30b:b0:70f:7483:5a34 with SMTP id
 00721157ae682-7164d525fb3mr18871977b3.32.1751438017881; Tue, 01 Jul 2025
 23:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250701-efiloader_fix-v1-0-f3c6e0b0ae43@linaro.org>
 <20250701-efiloader_fix-v1-3-f3c6e0b0ae43@linaro.org>
In-Reply-To: <20250701-efiloader_fix-v1-3-f3c6e0b0ae43@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 2 Jul 2025 09:33:01 +0300
X-Gm-Features: Ac12FXxwxUlOHW28I_EPMmHg5zCLGlVnBMElI6uH2WvIdGJce6CRqWre1js0Vrs
Message-ID: <CAC_iWjL3GgifoovwHyN63O0RKVPRAeZg7Az0jip3F29s4VFDhw@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi_loader: Prevent free of uninitialised pointer
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Tue, 1 Jul 2025 at 16:38, Andrew Goodbody <andrew.goodbody@linaro.org> wrote:
>
> Taking a goto to out_of_resources before receive_lengths is assigned
> will result in an attempt to free an unitialised pointer. Instead
> initialise receive_lengths to NULL on declaration to prevent this from
> occurring.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  lib/efi_loader/efi_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
> index 8e708d8d350..3d092523dd5 100644
> --- a/lib/efi_loader/efi_net.c
> +++ b/lib/efi_loader/efi_net.c
> @@ -1130,7 +1130,7 @@ efi_status_t efi_net_register(struct udevice *dev)
>         struct efi_net_obj *netobj;
>         void *transmit_buffer = NULL;
>         uchar **receive_buffer = NULL;
> -       size_t *receive_lengths;
> +       size_t *receive_lengths = NULL;
>         int i, j;
>
>         if (!dev) {
>
> --
> 2.39.5
>
