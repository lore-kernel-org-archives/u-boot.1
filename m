Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95584C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94A9088984;
	Tue, 16 Jul 2024 09:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R6dMVFdO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F06A889D4; Tue, 16 Jul 2024 09:50:20 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1504688907
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-427b9dcbb09so3520495e9.3
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721116217; x=1721721017;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=SujXZ5EarUZpJmwD3RIOjmu+PrxH3D3JPwlW/wSidoI=;
 b=R6dMVFdO03PNq/ht+ZQ6lIVtaUH50NdQKZospvvscyhraE3/BNbLHvyKjeq65kvs8H
 yNurTuQGX+Jr4fvzcGRFSuVfDXSEFaro5SNBTCfcNPWEO7Y5wH1EDgJRhXOn0XUkOK89
 g+TRZNrfqHZbAaOibtpFW3h0TaEtgN5GA1WyRge98PPEcKoxgb6e6odmpL7lsb/uENn5
 IYrwCMwdZ1pabC0bGgGDay/ae5XtNPN6hDyahMOY/EiUlE5ceqRFuZX+2JQcjXyZyyP8
 BKiEm/9MWkxN2bo9DbWxfxK6pDAvnTKSx3FKWLym1M5mRG1QoWHY/VZAMTGGS1ie/I3X
 TjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721116217; x=1721721017;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SujXZ5EarUZpJmwD3RIOjmu+PrxH3D3JPwlW/wSidoI=;
 b=j/HisMISRIM77TPjmEIKXQbPZ8i5Jh/fyavLqngUMR+hWgy6KnLzqSUr/Nyey/xZLS
 IUTQ9FVJdWPmIl1tyVW8gSjf2ZzlApicPPrYP7e4/QTWx/glPDq2eK7hnAwXTKR+/lbQ
 s7dT7Md9yZLuXZRkynsglRnYE+kxvJS/xQCOaSRfSXxGz4hKWXx9wpFggJRQlsnpipw8
 ZiwNRoIQYGFWuGhkdEcg6JqQn7PtWtk/suR574Xb4nR2tgbfekNV4qx3j9sC0+lTidIr
 ydLmAf4fDjdyD2uBqCOsH69OeZcqvDAWz7lMKPTpsxG8ERo0jCu6KolDDjDM6RTn+S0q
 j3NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAw7f/qIkBw4QB3vuns6i5p5qBBO+MB31l9SK5QtlJtpIeouKocIQRFwzmK3fAjn2gPQwIy3Z6c0jofanDgyspDHuaZg==
X-Gm-Message-State: AOJu0YyTSVbKF7jukKkkEQ6/1n1GEsFZHQYqOe8t0be824KgB/iQURNY
 FOLNWTztMUgXh0hHxRzjliuapDilUMDy9FOnw+ZTIxBtm4s/lGj1zl8GiQSS9N4=
X-Google-Smtp-Source: AGHT+IGewj+6BJpJZbhMxZ+nfpWvgqDlAVQwnhR2ys6h/y3R2P6oWy0aR4UFfbBAlU3vZe6Wr3xj2Q==
X-Received: by 2002:a05:600c:3b8a:b0:427:ac40:d4b1 with SMTP id
 5b1f17b1804b1-427ba6fa00amr6181205e9.27.1721116217375; 
 Tue, 16 Jul 2024 00:50:17 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a63449fcsm112504845e9.29.2024.07.16.00.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:50:16 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 12/14] doc: Add a link to VBE from the bootstd docs
In-Reply-To: <20240716070419.1897560-13-sjg@chromium.org>
References: <20240716070419.1897560-1-sjg@chromium.org>
 <20240716070419.1897560-13-sjg@chromium.org>
Date: Tue, 16 Jul 2024 09:50:14 +0200
Message-ID: <87a5ihn5c9.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Thank you for the patch.

On mar., juil. 16, 2024 at 08:04, Simon Glass <sjg@chromium.org> wrote:

> Link to this page to make it easier to find the VBE docs.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> (no changes since v1)
>
>  doc/develop/bootstd/overview.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
> index e4924b55ae7..4a55b7da00a 100644
> --- a/doc/develop/bootstd/overview.rst
> +++ b/doc/develop/bootstd/overview.rst
> @@ -416,7 +416,7 @@ Bootmeth drivers are provided for booting from various media:
>     - :doc:`extlinux / syslinux <extlinux>` boot from a network (PXE)
>     - :doc:`U-Boot scripts <script>` from disk, network or SPI flash
>     - EFI boot using bootefi from disk
> -   - VBE
> +   - :doc:`VBE </develop/vbe>`: Verified Boot for Embedded
>     - :doc:`ChromiumOS <cros>` ChromiumOS boot from a disk
>     - EFI boot using boot manager
>     - :doc:`QFW <qfw>`: QEMU firmware interface
> -- 
> 2.34.1
