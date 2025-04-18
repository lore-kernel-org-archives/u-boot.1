Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9366C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 11:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D7FE83208;
	Fri, 18 Apr 2025 13:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NH18LcVs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F6A5831E0; Fri, 18 Apr 2025 13:39:52 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 958298319A
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 13:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac41514a734so269462166b.2
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 04:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744976390; x=1745581190; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eymgvuTbQoYViYVHXxaQ1NVj/iHjyxUSdal0OspqerM=;
 b=NH18LcVsh1l4mc8ZaKGQ+5Y80NSNLHmPxLEpyx3GhizldUzjX6WnV75AmUmiLSRHjf
 C7rVtZZZ0TQxsZ3D/ZFcyA9EZD1O1+1/Osckvf7t8751c6sbODfzsEj9AbReMmtJhFVO
 7ZGF/0PBhrRLjxzVKggCa65aduZQHF36Gz0f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744976390; x=1745581190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eymgvuTbQoYViYVHXxaQ1NVj/iHjyxUSdal0OspqerM=;
 b=S28PemaFBk5dmu8vIBjfEZ8DcZvqPIor8NluJVY6J74q7GWK8WEKXJZy2AfW50zaqN
 a2MEiyD6r2hy896+y+r7QkcQBENDqxKPAzwU3/EYHNr+bIc+nzEqmBlZ5CUH6a99NYHM
 I2WPsQpAuxnZ2+qt/m8QU5UHqo0+b4tsbZy3u/ydArQ9lbUOkllBB3JEBy+ncLqSKh+w
 RUVCNzf2RDALOdhcN7Ymu2/JhpdD6t664vQWySotITY2dARzfRJPp+strdo0mSk1QPSF
 qLa3ZzGTElQnkNNNTvn8+fDhWw4QKhYugBhX/erLOHgjht9G/PBJTwvF/vB7yHZhPaA3
 cgaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlgw4JCUMQxlrOJFhmtESmwjEu2e9E8txWHOdN8+yQp8Iz6OH27Xnj7SJF4puaqDD0bcoY3Vo=@lists.denx.de
X-Gm-Message-State: AOJu0YxOFqGk9EMgUkykYs3yDgXgMGWrucrVDuAyIO84WSOM39NPi6zl
 U3YuVObM8oJAkSp2GxttwNCPgaoOnaeGPYo/uPSwLNuJ9wYI+nMF5SBeTVGRCdOfNfEcRfrti8I
 b34j2JEPDXAL1sZXp1sw9mGw5xzT61fXFYrFp
X-Gm-Gg: ASbGnctZ4ibHXDHQXJhCWTQenu+IPKNhT2JNbPhm5dtFCgVM2yfZ+nmoBM0u6K75ml8
 /4Uq+mCSGTTKS76Rm00un8o9+VW9ZBN8WpbKa7OJDKrMeRFHnqj+wbMmMLz4JcpS9xWdMIqw9Ed
 IDWb8tI2qlcUfJKZ1wBC5VcvLKiE6M6lgOUw==
X-Google-Smtp-Source: AGHT+IH3WJAthL5z+Wzi6ruhJgRYbxczWS4HZMBvQjHvAhXFJNmrvAeVdxNm2/wUrePNfaD8nX2r8wersxIFs7t7ymM=
X-Received: by 2002:a17:907:1c0c:b0:aca:d52d:b59b with SMTP id
 a640c23a62f3a-acb74db7215mr201840366b.47.1744976390008; Fri, 18 Apr 2025
 04:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250418043137.537340-1-heinrich.schuchardt@canonical.com>
 <20250418043137.537340-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250418043137.537340-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Apr 2025 05:39:35 -0600
X-Gm-Features: ATxdqUGMklfuwHPmHIfuCorxhZKET2YcYsrEeD9iVT_zvpPYYaU97oEtJlTYpTU
Message-ID: <CAFLszTipYhqefYsjhn8y_nqU4312VkPf1bpgWkPPAJPOHd69iA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] buildman: allow specifying configuration fragments
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
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

On Thu, 17 Apr 2025 at 22:31, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Currently we are no able to build with configuration fragments in our CI.
> With this patch buildman gets a new argument --fragments for passing a
> comma separated list of configuration fragments to add to the board
> defconfigs, e.g.
>
>     tools/buildman/buildman \
>     -o build \
>     -k qemu-riscv64_smode \
>     --fragments acpi.config
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v4:
>         no change
> v3:
>         Add missing argument descriptions
>         Always pass fragments argument where used
>         Avoid long lines
> v2:
>         no change
> ---
>  tools/buildman/builder.py       |  5 ++++-
>  tools/buildman/builderthread.py | 18 +++++++++++-------
>  tools/buildman/cmdline.py       |  2 ++
>  tools/buildman/control.py       |  3 ++-
>  tools/buildman/test.py          |  2 +-
>  5 files changed, 20 insertions(+), 10 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
