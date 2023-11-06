Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D438DC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 17:25:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9114287137;
	Mon,  6 Nov 2023 18:25:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bGTxTfSy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8403D86F8A; Mon,  6 Nov 2023 18:25:33 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B8CB8701D
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 18:25:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-540c54944c4so9451685a12.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 09:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699291520; x=1699896320; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5fd1yfg5WmTz7kPqjJM3xRkFXB3rzw+hTdAF+a7jVu0=;
 b=bGTxTfSyrGowGJUpyg26V2iG8cLm3eHapqbzSMN05dF5L1kOnkIq0rNf0QXBkHpOyH
 g8L04766ys09SkAcsUEt6UiJ4/ioEClvEI7VHjMm7jm18VlaUgDG2vhQNbv1U+iceq/J
 wkWV5jQuT/gCbqq39/kArzr+me6+AXz9vSb2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699291520; x=1699896320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5fd1yfg5WmTz7kPqjJM3xRkFXB3rzw+hTdAF+a7jVu0=;
 b=O/q16/PZZy4E4PaJb+U/3V2/hlTpod/4OxyeUC/f+R143/OCz0pPXdyhGydlmGaExG
 jpQN16IJXxNAGWbSi4jq0RviyUOKJKVow9EF9hInqIHLAvClbRvbmOHC0LB8KWWHAunX
 SKhfVToOXPyFIy8zH4a4sjPKQDHwioXYJAewC9hz8+vxyDaeDeSM0E39IcecVlOWzy8O
 UHIFeTRe3vAZIW0K3ri4d6V+J3lFhlxVcbNTHFEye0ZJfcOdgYBvWXQisYNJv/w24+Ye
 WYXIfFhIwBVAzfG3Do0ejdqDHmfyooH8c9377EbXm1EphNt3V5GXyO3FFvt5MbYqejMW
 /XGg==
X-Gm-Message-State: AOJu0YyD9EixST/L5Ziy14t/JKUkkKSRIPiIptvHJG2oVWjDQyni+a/f
 +0QLztSuQcSyYxiZresGq1eps2GkY2afV94sXl59Xw==
X-Google-Smtp-Source: AGHT+IEeoJMfARkesrRRymCCkFOUPsKGHk4xuE69pQx+AnBd8z59zGNmFxC+S35XkAYcNk/sB8lkIW9zPe5HSzP+0OY=
X-Received: by 2002:aa7:d449:0:b0:541:342b:2469 with SMTP id
 q9-20020aa7d449000000b00541342b2469mr163609edr.1.1699291520104; Mon, 06 Nov
 2023 09:25:20 -0800 (PST)
MIME-Version: 1.0
References: <20231105200453.1887418-1-sjg@chromium.org>
 <20231105130351.2.Ie34b75c75347a1c04bffa780220afe9011b0e2bb@changeid>
 <20231105212014.GF496310@bill-the-cat>
In-Reply-To: <20231105212014.GF496310@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Nov 2023 10:25:02 -0700
Message-ID: <CAPnjgZ0m3Mvg4ME=VG8gt5X_8KFq-JtSPNyxp5sMXkwx8yFGyQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] bootm: Move arm64-image processing later
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>, 
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
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

Hi Tom,

On Sun, 5 Nov 2023 at 14:20, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Nov 05, 2023 at 01:03:52PM -0700, Simon Glass wrote:
>
> > If the image is compressed, then the existing check fails, since the
> > header is wrong.
> >
> > Move the check later in the boot process, after the kernel is
> > decompressed. This allows use of bootm with compressed kernels, while
> > still permitting an uncompressed kernel to be used.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> How are we getting in to this case exactly?

By using a compressed ARM64 image, e.g. Image.gz

Regards,
Simon
