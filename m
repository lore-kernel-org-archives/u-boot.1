Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9EAC27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 15:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6D79888A9;
	Thu, 13 Jun 2024 17:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QgW4aLq+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D281C888BF; Thu, 13 Jun 2024 17:22:32 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ABC5888A9
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 17:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b064841f81so9180136d6.1
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 08:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718292149; x=1718896949; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FeyVyFXAOSoqVri6m/j+e0m92uENKcpIYxRL9UOkxqE=;
 b=QgW4aLq+YHCSVPXXmelo0XioairPr4QHdxxllujwcAnKOLwPGpckVe7UP2nLEFZP+r
 MRpjweNaWpFj/ljtLv1UVRKbS4izIoO4aC6SkDhtV6DBDhfPMiqAINRJzQ2YV9jBu3Wk
 exic3jOij2achLB6EErJYMsPNGSOcirKNoA1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718292149; x=1718896949;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FeyVyFXAOSoqVri6m/j+e0m92uENKcpIYxRL9UOkxqE=;
 b=MCnar4WvHExC213AYlCqlOjn5+OtOA8J8ddCwvba1VXsW8LTxZhW5S8yOE4jQutnsA
 PmkkXB6klp1FSQr5Uro9UEGCjR4sTXRMIYqklVOVND2FWxMvgJ6pyrcS1AZ8GE9jB9R8
 Kk1qInsuzqI+T4sSo5/glecNB2Hp9G6h5if4CHsSFYbgG3HOLya4xPduI/RGgbb/mdf0
 N0406WpHOsYIbzNzfYQppCSKuDp5n/vIMhNascflYuGqPj7ybKbh0MZysX04cgydmUai
 8rmwsCeF5pLd13kngPfr51YVCy3637/8dxb7H34GKTOdUA3w4+4thje1YXGpnBKNZVM1
 6niw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1M2GydHkdtQsA25eGcGrEb0QRs4YJna6UJC8mG1IbTvAi3lqglT/Wtw/JLbWqc3M3KqURXdLmB33wSinmk4Rc2r6i2g==
X-Gm-Message-State: AOJu0YxGKEPohtZXMAbhQr0ap3Uw2ZMVo8lhIxsqQ6sRGQwPWKqU+BRQ
 Qdfg0mNCN+8H77+xI/FGaiNk2bwwk+RboCOp1uCGmtY0vJOrlCSpVeS8DgaYHKwPmTLO6U19FBO
 7qiK7r5zsxtLlMrDU0NCHqy/BNr3BZLIszDM9
X-Google-Smtp-Source: AGHT+IGyoaFmdwCnG+NPpIMO1B0UTjMLmtIRjStt4YspJ+uQknZuLxRt81SHseUhIvESmfWoefFXDMxfEdw3+6wieY0=
X-Received: by 2002:a05:6214:4882:b0:6b0:89ac:ad3a with SMTP id
 6a1803df08f44-6b1a731b91dmr64332466d6.59.1718292149055; Thu, 13 Jun 2024
 08:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
 <20240613-bootmeth-android-v2-1-397f6e66eb29@baylibre.com>
In-Reply-To: <20240613-bootmeth-android-v2-1-397f6e66eb29@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Jun 2024 09:22:18 -0600
Message-ID: <CAFLszTgKMx-Jo-4-QPD3r9sjFDanLm54-6gf_B-edVPLPfsEXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] boot: android: Provide vendor_bootimg_addr in
 boot_get_fdt()
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
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

On Thu, 13 Jun 2024 at 04:13, Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> When calling android_image_get_dtb_by_index() using boot image v3+,
> we should also pass the vendor_boot ramdisk address.
>
> Use get_avendor_bootimg_addr() to do so.
>
> Notes: on boot image v2, this is harmless since get_avendor_bootimg_addr()
>        returns -1.
>        for legacy implementations that don't have CMD_ABOOTIMG, add a weak
>        implementation to avoid linking errors.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  boot/image-android.c | 5 +++++
>  boot/image-fdt.c     | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
