Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84153CDB482
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:36:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A85986F7C;
	Sun, 15 Oct 2023 08:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gBTn8SlQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B1D186F80; Sun, 15 Oct 2023 08:58:46 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6613386F83
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9a6190af24aso564741266b.0
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697352852; x=1697957652; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ujj42E+wBTP/tQfZFrn37zgQSBpuHq51Adkm/rhkBRo=;
 b=gBTn8SlQ974rK+m5PrphB1BYpbQYCe/xi5TVC4yllmFQCHkA9bmZeeCZ5Bo4BvHGGS
 XjR4I4Yq/AF2KZQInv9tCxUWkwpqagRc4/rv8BuDnuVaS0B/31es3zwNbQiw2th9M+V1
 f87/fSpfYRHS1eLikQ+bQACUEGB192W0DGqsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697352852; x=1697957652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ujj42E+wBTP/tQfZFrn37zgQSBpuHq51Adkm/rhkBRo=;
 b=CZBZ67tmDpwLZWtZmmjCsBBmMH5mPrNChocxGAp+ImCzKNEpKLH0XtUT43bdjEQbED
 O50Yqzb3l7YtHlClENWj5c/nfZI9ZUHz0g1PmCV01/IFgGk7NxtsLJidARCo29COtNyf
 MUqPa2BBlVfIyELZmg3wTVfJAwcs3lrdwOy2+uRrP8+n8n3Z414FWPhyHvacPj+MrvJ+
 hDOKaJbaxQIpeRSXgfQgSxFiVklvc0kApt7R/LUsan98kI94Dvhjk54SjFPTg0FGjqPa
 OKlgb2fRQsX7RSmqPQrgcbikMGkFTbc6qtSrUKiVn02+PVbSWg+P0pQSGuoMpEbWCULC
 Y8tw==
X-Gm-Message-State: AOJu0YxrSUzfj8q4iaMoEiO5KoonYJSsNeXv8hYeL1R13deNn55Yqgyh
 7UBm+tjGzZf3Fbf8hmPAuMC2Wo9vJmoXvKcy1lQyUiF3ltRSOFDGxXo=
X-Google-Smtp-Source: AGHT+IEEpyur93rSS2REuCerQoMOCDnVyOlui6jmfHtaRQ0ayYgqQke0njdu0l/0V7NyARv4STiDc6aJX8Yi97RtVlA=
X-Received: by 2002:a17:907:3e0f:b0:9be:39a4:b440 with SMTP id
 hp15-20020a1709073e0f00b009be39a4b440mr4154716ejc.76.1697319975790; Sat, 14
 Oct 2023 14:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231014204805.439009-1-seanga2@gmail.com>
 <20231014204805.439009-13-seanga2@gmail.com>
In-Reply-To: <20231014204805.439009-13-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 14 Oct 2023 15:45:58 -0600
Message-ID: <CAPnjgZ0f0TkGsZQGZDSO9HM+OaSHJPtcjg1PevCh5QxXg1dKpA@mail.gmail.com>
Subject: Re: [PATCH v2 12/29] fs: Disable sandbox filesystem in SPL
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Harald Seiler <hws@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Sat, 14 Oct 2023 at 14:48, Sean Anderson <seanga2@gmail.com> wrote:
>
> Don't bother compiling the sandbox filesystem in SPL for now, as it is not
> needed.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v2:
> - Disable sandbox filesystem in SPL instead of compiling it in
>
>  fs/fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
