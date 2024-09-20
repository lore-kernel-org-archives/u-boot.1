Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FADCF9C59
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:02:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C03C488C4D;
	Fri, 20 Sep 2024 18:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dHmWRfsg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B13488C86; Fri, 20 Sep 2024 18:01:45 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A13688B49
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6c35334dfb1so13002806d6.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726848101; x=1727452901; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6bXxqOojIghr+rAUGW3N9miQo7B91GmHcOJ09AtR3vU=;
 b=dHmWRfsgaZF1y5UKudS4Qy1Gzllv8C6LnFbrrDKsVX9NLmv+0Hb9huTiDYYwBnqn6U
 ZlKEVkSWUyWhYg+zYaEeuWGRkrA9nBHRVB+0IkbHcJh/8o02oNenp0hlgZU9STDUyGwl
 OgkfHDedqi/5/PC/P4L9h8vDCqaRqgMjoyRjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726848101; x=1727452901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6bXxqOojIghr+rAUGW3N9miQo7B91GmHcOJ09AtR3vU=;
 b=K2O5p/Z5dbz9V0isuOQXgKK2o45OhaSDOrAvIJK56elYvFmkMKUcJPDQsQhAmdJyoi
 afALj1L7z6cEjEgzN7ziIde8CPbFfqdtgaFSuHNLmwRG6c3jZqtcm2wd1Jjjs/YlC74h
 xqT7X8uPW8IDoJ0OsCkE2O1ubfFEZfx7Z4xQmN3ffJBBdoYLEAt5jIMp2I0dYNyQwGks
 ay1jiR9PS/erA5NBE1P6nAHYtn+zssdvbZ+30dO4Aq1YrUsBKwEVMcQC/OZR2rOkll4d
 PHYGREYmjH0jNCX7OOm4gZreaJSJyxvofnu8VorGO64dEg8Nx1rwt60LYCr0sjBsZhGi
 jCiQ==
X-Gm-Message-State: AOJu0YwE0vrmYcJhcZcsJ3wV5HXmuBY336JsYsPHKVgeJ+64gsbdfoH0
 PnX8bKILvIgnTaIBzc5MsWwP6C8hcg4CiAJDP8AO+yPrltSj1xTMpu6/9BNevpsM9VoWgHBvoCt
 UVjISRoDKhyrXs7XRVpo73hJE8Ol6anJ9sFrjkwjP5BjSqQ8UyFFW
X-Google-Smtp-Source: AGHT+IH9cxZBM8XRkg/fKpoIUchO3KWazJ/Cs3R3GwjLkiBzwEf3KtXxK7zcsC2OxfmMCg9NyxuoA2Jw9mbEWtqzFMY=
X-Received: by 2002:a05:6214:3289:b0:6c5:c4db:874b with SMTP id
 6a1803df08f44-6c7bc7125b4mr42626256d6.25.1726848101021; Fri, 20 Sep 2024
 09:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240710071612.1717460-1-rasmus.villemoes@prevas.dk>
 <20240710071612.1717460-6-rasmus.villemoes@prevas.dk>
In-Reply-To: <20240710071612.1717460-6-rasmus.villemoes@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 18:01:30 +0200
Message-ID: <CAFLszTjZecSA_x+wd1GKJ+aDts5L+uYU6K+RHXQfx=cE=Nz0hQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] kbuild: Disallow DTB overlays to built from .dts
 named source files
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>
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

On Wed, 10 Jul 2024 at 09:18, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> [equivalent to linux commit 81d362732bac]
>
> As a follow up to the series allowing DTB overlays to built from .dtso
> files. Now that all overlays have been renamed, remove the ability to
> build from overlays from .dts files to prevent any files with the old
> name from accidental being added.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  scripts/Makefile.lib | 3 ---
>  1 file changed, 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
