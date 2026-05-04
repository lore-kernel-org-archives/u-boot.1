Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B35CFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:38:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2CA684706;
	Mon,  4 May 2026 22:38:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PLXnr4nF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3F6B847AF; Mon,  4 May 2026 22:38:29 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E05DD846DB
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-67c9616b4feso1741376a12.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777927107; cv=none;
 d=google.com; s=arc-20240605;
 b=kgbYfSgma9gWAvKk3ytOKT0sPb34jtsWWxG5xnpdCf5jN/h+EV3kn2j5O8RxgBVi+R
 g/323JOtvZVVQEJKxNan/Zno4oJ0sLoD9lAFxBDVYdznYIYCnozRGcnOK6c6QP5PHrEO
 wPK4GEmQanH8nPnFj1BJub2m7uZRBjsK0J1znImZygOhEl/oiOV7kraf8ou0/+iIWx51
 ojzkCh8GaCgI/IqFAsiLysp7IIjqTeGJf7Gm1sCii5zKLmOrHkL9jsWiYAgvdtn8cwq3
 o49KC5MKUGfvIKCm/i5KBZncpJuKMmnQ7Br1qg+GJDQB+EG22ghD1vlavj1U3u49ZXFp
 h5XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=T7oWrfQVRl7ATp4JCkSIEsDYFacTIgVXJyIoPTxAvR0=;
 fh=JDmMtl5m1ONTYAIDZy3RW95Kei7pwM4OcFAim19m6HQ=;
 b=aoLsWYTTOFXAQMIJRaf6m+GO+gQXfnxl3/5hKZOgWah7yil6gO+wvEAYeDQumkAc9E
 lH7T8ImJNkLQedoK9RYxcIHggRzKzmAPtSNEuVpfR3PKoHOwmEjSx5jkHffAfHdLjnF6
 cIW77iTMBuPnRInRFM2ZDtCe+iYqMdle4Vsd0vHa7qZPJ8RofTZzNFo6Na6pD44DLN8f
 IrUJFpwIsLTO2GoZkfFDB03kz3jsdk1Bo0CeLXQirU7FIqNpPDwVzBcZP7QznWsCoEK0
 CjUlSgTz34NiTxLXTwX8hQh2DGtA9Rx5RToxQBceH21vyo6Lelw/tjK789yeol0E43qU
 iukQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777927107; x=1778531907; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T7oWrfQVRl7ATp4JCkSIEsDYFacTIgVXJyIoPTxAvR0=;
 b=PLXnr4nFG+FeXQVYOAIvP7jNf/H3hiGb7Mxp2AStoLFkNVFqqkFcArozcEeuJfedYN
 gTXfbKlm8RHCD3K+3aoNbSuI2Nl9y51RiTBKoyffknJ7WVN+XuubUPwRNOMbejlDQc++
 52qHpdtvjQKin9v7W+LBgOXgfbp37tBYLVVjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777927107; x=1778531907;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T7oWrfQVRl7ATp4JCkSIEsDYFacTIgVXJyIoPTxAvR0=;
 b=c41IxpyZXfCM7WXrUQeTiLuQcOUrck2ND+HnVe1y6qFr8zLgpOss9cPZyRQi8VDWYw
 EvtodJmpUuveUZjU+ZKfGocJrvr58cOMUky4+V9Br6whNdm7Ly7Nv47wAEVZi0YJvH8a
 NTKveM+nlhF4QaTfgoCtNBj/+VFzJ8dO7dnBhE//b4E/xnTjlcWvpDYyRZg657zmJiLH
 +elAThDlil5NloTlSRCpb4Ajzr+PqGWRuxRo3m+WM9etFbtElWpMrjhCATB2maFjQIWX
 RC825a8jMkpI38oHd46lw2o5GKOM8Rm5+sbSbtxe5HjcC7NWrBxacp8XZR3QyJDEDI/r
 xtqg==
X-Gm-Message-State: AOJu0YwZcMIUATIkSFXK2GqJgCv9rkyRt9GnwOCCTJqqJZQBlPLUjYFo
 h/BVQzY+tSea9/l9jvL/0dseeTg3d7PBs7GWtCdzCEGCW4vcMhnr8GZRoNHBYcAiUYpUrtXFlQv
 fm8htGKw7Y/jueJacKwbnFH6IIyrQHrKpTlzfKjbo
X-Gm-Gg: AeBDieth6gWFsfHvW2B1Dbcv3UoKUCKebIvjsnzXE6ZvviPsHrB/Ck+8rp0a5RUnfOh
 i/y8GFJUDWkDtgWUfRgFKW6ghAGnD+m1qDjQdEYj2hPJoWA5Amv/LiQM5DZFx9xnw9N160MAajY
 YQkCvmwJ3+sxj8OCzV/kNR9UP3sPldA4hvoAa6QI5cXUr+p0tikprAnGSAhjjDsuMCRm3OqyXyZ
 UC4qrpWYjnPW5pabq9JFRyW8X6EH+IFisiWZwS0NWPFbDfs5qKU5F//OH4LjjqvVDOKgUSXcCe/
 Im+3PHE4QKHdBNZr
X-Received: by 2002:a17:906:2083:b0:ba9:559:10c8 with SMTP id
 a640c23a62f3a-bbffbf85acdmr418649466b.41.1777927107273; Mon, 04 May 2026
 13:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-15-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-15-b19301d1948a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 14:38:14 -0600
X-Gm-Features: AVHnY4KW-eBxBOuwJhtF3RbUW1YN9BF29-2S1ssdJDVfL6E_WNvOGxm4mxwo43c
Message-ID: <CAFLszTiX7VJzT_mYS071Vb5jOBR4pqtpuM9LoqR=6m+qMNLsyw@mail.gmail.com>
Subject: Re: [PATCH RFC next 15/18] kbuild: enable -Werror for hostprogs
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Quentin,

On 2026-05-04T13:20:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
> kbuild: enable -Werror for hostprogs
>
> [ Upstream commit 27758d8c2583d10472b745a43ff86fef96c11ef7 ]
>
> Original commit log:
>
>   The hostprog compilers and linkers do not share the regular compiler flags,
>   so they are not affected by CONFIG_WERROR or W=e. As hostprogs are used
>   during the bootstrap of the build, they can't depend on kconfig options.
>
>   Enable -Werror unconditionally.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> scripts/Makefile.extrawarn | 5 +++++
>  1 file changed, 5 insertions(+)

> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> @@ -109,3 +109,8 @@ KBUILD_LDFLAGS            += --fatal-warnings
>  KBUILD_RUSTFLAGS     += -Dwarnings
>
>  endif
> +
> +# Hostprog flags are used during build bootstrapping and can not rely on CONFIG_ symbols.
> +KBUILD_HOSTCFLAGS    += -Werror
> +KBUILD_HOSTLDFLAGS   += -Wl,--fatal-warnings
> +KBUILD_HOSTRUSTFLAGS += -Dwarnings

Just to check, is there a reason to keep this and patch 16 separate?
The next patch immediately undoes the 'unconditionally' claim made
here. Anyone bisecting through this point gets host tools failing on
any new compiler warning, with no way to opt out short of
HOSTCFLAGS=-Wno-error - squashing would also let you drop the comment
that patch 16 then has to rewrite.

If you'd rather keep them split to preserve upstream history, you
could mention in the commit message that the next patch makes it
conditional.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
