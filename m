Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49E4C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 14:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 357108896F;
	Wed, 24 Jul 2024 16:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RQitv+bb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C808E8896A; Wed, 24 Jul 2024 16:37:25 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C18398889B
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 16:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-65f8626780aso68529147b3.3
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 07:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721831842; x=1722436642; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+j5tCy1l51S9k/iKBfsye/ja1w1YxG3HgBOSJ9sLqTU=;
 b=RQitv+bbBEGgzzE9Q1WAfg9N6Zxo/uw2l9/AmawWvqNn7ojz2mT2YUJL7uYWV9h3JQ
 MkAgnqHYdfyxFUKmxaF2X7xmY3mAXWf9y3bWhFC0hz6cKzVoBoK3MVsqzJQx0jhwaZNf
 mr0mIb4kenNdRC59S988vn8bu9s1jwR3wHE5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721831842; x=1722436642;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+j5tCy1l51S9k/iKBfsye/ja1w1YxG3HgBOSJ9sLqTU=;
 b=YZNfqYm6vFdVg5+718kOBOig+n7T9yTpkgYB8GgSlXslxppheFOz2GrBG/nRbhs2St
 ZFi8Ymcrj60HOWF3hDtAq8OWoShle5vAAD9Pl3m8IfQRRmPnqycJsMrCWCEcjp9nvezy
 9K3qnUmt59FjiPnwSmd7LFKlmzAE4iG9h293AQvbLc6Ilw0iiFYMpV7wouzv/AVTXPFy
 QiLUQ1IIyQcuBBZ43VyhbMRdrBllXW/j9nAP2dYGfGqTF+7TdFivrwEdodFsnF+i1XjL
 AFw3yZruqAD4tE6M7/bJxNeJkz4oBETKlYJoiArd/VugEXvYV7OAM9fb+aJe0X5BPlZw
 dudw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeOaaobDZYs6mQ3b5r52KtHHj/LktI3B5hEA3kar/gSIaiQTGugKzUGPz6ymO6mBfOk1TIciDlzc0DqM5oOaEeqS1o4w==
X-Gm-Message-State: AOJu0YwnWRvnI60h9ubXbW9pCTtczWjJKTMYR2xi0Bwm36riv9oruK6v
 lgoyolfUOJsxd2cI1+bIo9iEfSXeKUT+ADYADRjy2eTJ568d9uYFCdOqJYAWfQKfAK+aPfDQd5E
 1vODo3+b5v8DbCu7DTl9cytttzDp+Q/4zH/qWd0Sl5fCOpZQ=
X-Google-Smtp-Source: AGHT+IFN4v5tzHsVATiyIDLm+yc9n4n3qgD15arz7T4iOecDL7V/h+yUS+t/95pwVkCrxl6Np/UQNfB65CM075OCfBc=
X-Received: by 2002:a05:690c:fc9:b0:64a:9832:486 with SMTP id
 00721157ae682-671f07f368fmr41178067b3.1.1721831842594; Wed, 24 Jul 2024
 07:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240724-doc-bootstd-android-v1-1-03a55b7a7c92@baylibre.com>
In-Reply-To: <20240724-doc-bootstd-android-v1-1-03a55b7a7c92@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 24 Jul 2024 08:37:12 -0600
Message-ID: <CAFLszTjcq7OqntyUpPpqAwZjJZTQwch68nDwJG85pM7XUN5Hcw@mail.gmail.com>
Subject: Re: [PATCH] doc: Add a description for bootmeth_android
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Guillaume La Roque <glaroque@baylibre.com>, 
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

On Wed, 24 Jul 2024 at 06:41, Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Add initial documentation for the Android bootmeth.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  MAINTAINERS                      |  1 +
>  doc/develop/bootstd/android.rst  | 39 +++++++++++++++++++++++++++++++++++++++
>  doc/develop/bootstd/index.rst    |  1 +
>  doc/develop/bootstd/overview.rst |  2 +-
>  4 files changed, 42 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
