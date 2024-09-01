Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10962C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:13:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E54588B2D;
	Sun,  1 Sep 2024 22:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EOT5f0rI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6368F88A7F; Sun,  1 Sep 2024 22:10:21 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C63688B2D
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2053a0bd0a6so15326305ad.3
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221418; x=1725826218; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4tj0tH9xkHR1D9QnkRSVeqhBH+SEUQeHcIZZiCKlB30=;
 b=EOT5f0rIHSgdmgCGoH/yK3NTFyHRqo54P6OtswUsUovjIeWN7RovhM9OJPwDADqaKZ
 zNdcvO2OEu+7MKOCXPhHslftK4ZItBhe6sa5QRd808SjUw+WjONfQgpKljYd6ptwM/n6
 FmIdnfcWgoc15luapDJxPFDE9OSoRgxlcnSXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221418; x=1725826218;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4tj0tH9xkHR1D9QnkRSVeqhBH+SEUQeHcIZZiCKlB30=;
 b=ocBUypqNERZ6VP4o8IR1OKeTF1jn9uNFRimeGZN6qLXMHNr9HwPN8VoSVjjNxSyjQW
 MteWHRQ4myD46R9psdqIVZKZM5fH0eHFGVsmRxXhCUmXcqtKriRXf5nZ0FAoUotirkSW
 aX+O9qiIDodZdI88a0EbOGnPUtaKYA5IrihVT2cxBpI9yBUfir6fsD1HlpBFm6BpYW5L
 fJuAs9rFqeGaKGOCRhWYcRDfZDrY++3llbO1JUTADHo+kFN6BpOYnWCakVTYZCl1o1cd
 tM1CJT3/wH6GmHc/16UferhK6X2jfISQF5TClZbS5D30JsU23GYsEr67DCJUAzd4jiBA
 gQUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeKWurB45SqE3PC+PUfbMwx8hB4O5CsZLxtRbSDPaC8fX6ajNVHciz1ptradv+6KDpafm441s=@lists.denx.de
X-Gm-Message-State: AOJu0YxcweP5m8pfn4eo10XoLR2pr2TJjoFiBxheqtZmTHiFbPoIL9Ru
 fvlPVsjxgroSo46OqXARwluu6axEn4ttE/3TFY+2TPfrB3ltITkaqmtv7Hf1WHEu9QGJZg465xM
 /dR6voa9adnBsOaSgdsNHZIHENxYM17vbqzpl
X-Google-Smtp-Source: AGHT+IHIGIz0fleNJuXCBG6xiOS2FDdzHcJUMet+d1k7RySdHUfoIgqxq/difHtelCn2gIu5wU/RqdDEeKKk2HK4y+8=
X-Received: by 2002:a17:902:e54a:b0:202:2cd5:2095 with SMTP id
 d9443c01a7336-2050c237c31mr129098095ad.18.1725221417774; Sun, 01 Sep 2024
 13:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240812205759.1732217-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20240812205759.1732217-1-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:10:04 -0600
Message-ID: <CAFLszTjKaSvki9tkgH+T2HxUghWMXbrm8=w=9rd14jNJLn-j0w@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: fix memory freeing in efi_get_dp_from_boot()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, u-boot@lists.denx.de
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

On Mon, 12 Aug 2024 at 14:58, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> efi_get_var() allocates memory which must be freed after the variable is
> used. Since the device path is duplicated after we deserialize the load
> options free the memory used for the variable payload
>
> Fixes: db61e70e0d2a efi_loader: efi_dp_from_lo() should skip VenMedia node
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  lib/efi_loader/efi_helper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
