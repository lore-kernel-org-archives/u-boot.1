Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95ECCF3944
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A2D08923A;
	Thu, 19 Sep 2024 16:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lTbX2NkE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 931D089262; Thu, 19 Sep 2024 16:13:31 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2151F891B3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7db12af2f31so768131a12.1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755207; x=1727360007; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DZocjLEBIGQRxxx8Ez2GyvZCHxR8E5oND9j8Dag6Vjk=;
 b=lTbX2NkEgVxvLgsY/EQ9xJZY4mRl/SK7kiZ4e855J/OB/bPNzD/hp2bjSvQOrVGrjb
 cuQt5j6UJwsERGljuJnV3B8WXVaHnz8h9GG2WvbwtSDgmWKEAJgZSQq1zPoarbvauQ7H
 xhPuue7tgVgjGUu1t5QGNgsSwBWSEoAuNZA94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755207; x=1727360007;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DZocjLEBIGQRxxx8Ez2GyvZCHxR8E5oND9j8Dag6Vjk=;
 b=G8ie/oLHIlgrgsh20Vsl6j3A2QST76PVUO4/pl5Y8nmZO0VcvuhtSD+F/8TOp7XOm+
 fi3luEHQ9e8Ve0T5DwqXN81AMkj/ddHiM1uxfSlmKPwIfENWAiRvKrUMO6UFA9W0S3c5
 yIJCqd7vVF8RR0+whLNgtU94OoX5NX0iAK3VHl1ct4/RsV8WP1/H06cLOtNqye30Ir2S
 X+O76lt4HdodP1dCVJAnYXJ0Irt+Fcm2bOoSSfDvjdjsCH6j0/BmiDFL/28KEj20ylYf
 mIAwAaeqLuGOOYcX54x2z/Kb31FmPijF5yGtYGejqJSAfo4BpPlzBG4FejLi0pbfOmmF
 6iVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzxVU6G+I/47M1bCX9YxBCb30d50ya5xbuMSABLpzXWSuoHDaJok+UQ0eqUcUvk149yCX8XaM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx27qRtwfQJ0Xf3U+MFciqlO/MhwAYZszE7MykJsVCxv3VwJNZY
 OekfpSK16h721Z/4G/tlq7gfHF1KYIqQMRo/M0aFy8Jwl639IFVEMFSrnmuTdKNMZOiW9+2IyF9
 69YSNHzsx46xIE60pqP+LlhmHsDmMs981UMoG
X-Google-Smtp-Source: AGHT+IEldh8RkXjMpycQTKLDsqaTqFMf1FbSuT06wb2wN2AyAtBO4FOeN16D4dFRnorloE1bdtei3bzNFB1uahZ4Iug=
X-Received: by 2002:a05:6a20:d523:b0:1d2:bbf2:4c0e with SMTP id
 adf61e73a8af0-1d2bbf24c8fmr26432959637.43.1726755207700; Thu, 19 Sep 2024
 07:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240912-bootmeth-bootloader-version-v2-1-76d4c0b45024@baylibre.com>
In-Reply-To: <20240912-bootmeth-bootloader-version-v2-1-76d4c0b45024@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:13:05 +0200
Message-ID: <CAFLszTie3Jzkdb4GUUsOmChVjPthKMHivm3M9fkVqzLEwhkKeg@mail.gmail.com>
Subject: Re: [PATCH v2] bootstd: android: Add U-Boot version to cmdline
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Guillaume La Roque <glaroque@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
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

On Thu, 12 Sept 2024 at 16:00, Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> When booting into Android fastbootd (a subset of recovery), the default
> UI shows the bootloader version in the screen [1].
> This is done via the ro.bootloader property which should come from the
> bootloader.
>
> Provide the U-Boot version via a kernel commandline argument so that
> fastbootd can show it properly on the screen.
>
> [1] https://android.googlesource.com/platform/bootable/recovery/+/refs/heads/main/fastboot/fastboot.cpp#42
>
> Reviewed-by: Julien Masson <jmasson@baylibre.com>
> Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
> Changes in v2:
> - Clarify by a comment that we intentionally ignore return (Simon)
> - Link to v1: https://lore.kernel.org/r/20240904-bootmeth-bootloader-version-v1-1-9979a8428566@baylibre.com
> ---
>  boot/bootmeth_android.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
