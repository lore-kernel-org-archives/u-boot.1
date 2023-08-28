Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5F6C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 16:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C862C86430;
	Mon, 28 Aug 2023 18:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kfSiXTo7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A3FB846D2; Mon, 28 Aug 2023 18:20:12 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40ACB86456
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 18:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5009969be25so5404531e87.3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 09:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693239608; x=1693844408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ymoVp+A7tQRp2jnCknEWvlE5rwxwiA0wTPaSFjEAKaI=;
 b=kfSiXTo7bQ3Ywz5a/5Gk6Knen4f6zyCogm9PyH0Z7GqO57D2lZOaAbE7lSpaQ1smr5
 TW53/HWCIaBS3dgstgJbc0VlIDgSI82l5HY0artX50f6QtVdS/yuLI1oQzRomUY4007I
 LJ7ggVc5PYMgNHzf/ySt98EYvH86AOK9jf9r8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693239608; x=1693844408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ymoVp+A7tQRp2jnCknEWvlE5rwxwiA0wTPaSFjEAKaI=;
 b=bkzjJ1UTSloVHwD3N1XcjKZEuUcjlG+gKFHpZJK005Fn6Qc54Xe2NEh2aXWVh6ndWN
 h+YDUy5gBQCkD0nC5ayf6Bd+SjWZZ/S2ItTCie+8ihUEs+a07hicPTOaga9NpJtTwpaU
 wHFPZ2WnjhT1JvM+8mcfG2r1n4i5kYmAeTyulDb/2j3E3jdGOefHzz9EO52i2hGSXlft
 l7JMEKg72w+zdNaWr8b8XNZn9+Alu1aULzDtAmfDEjXRq+VTEYGTW43wO8hqkMOUp9UV
 Wqr5acrUGSo2vNZ/JIZqA2syL4MtUxCfBAJ234gCtLsCe4wFYBUKLcZKfqKs3SUBU5Td
 93mQ==
X-Gm-Message-State: AOJu0YwZjGDV+/609W/I+d3U0vQbUfhHeaeBCGe/vNjlYj94FKIwFHOo
 hF+GubIeOi09Fo4nRgf2mwn7fUz7TDrwDBeRlw/4wA==
X-Google-Smtp-Source: AGHT+IFgnJQm7DrY/KlPgRGFdMRHmYBafsr5u2ipuuukEr2zh2ruNjbJWlHRTiHIETSCXKRjy9guSWt8nUD6Xkv7080=
X-Received: by 2002:a05:6512:2252:b0:500:8ffe:7486 with SMTP id
 i18-20020a056512225200b005008ffe7486mr13488236lfu.4.1693239607523; Mon, 28
 Aug 2023 09:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
In-Reply-To: <20230826090633.239342-1-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Aug 2023 10:19:55 -0600
Message-ID: <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi,

On Sat, 26 Aug 2023 at 03:07, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
>
> Provide a way for removing certain devicetree nodes and/or properties
> from the devicetree. This is needed to purge certain nodes and
> properties which may be relevant only in U-Boot. Such nodes and
> properties are then removed from the devicetree before it is passed to
> the kernel. This ensures that the devicetree passed to the OS does not
> contain any non-compliant nodes and properties.
>
> The removal of the nodes and properties is being done through an
> EVT_FT_FIXUP handler. I am not sure if the removal code needs to be
> behind any Kconfig symbol.
>
> I have only build tested this on sandbox, and tested on qemu arm64
> virt platform. This being a RFC, I have not put this through a CI run.
>
> Sughosh Ganu (5):
>   dt: Provide a way to remove non-compliant nodes and properties
>   fwu: Add the fwu-mdata node for removal from devicetree
>   capsule: Add the capsule-key property for removal from devicetree
>   bootefi: Call the EVT_FT_FIXUP event handler
>   doc: Add a document for non-compliant DT node/property removal
>
>  cmd/bootefi.c                                 | 18 +++++
>  .../devicetree/dt_non_compliant_purge.rst     | 64 ++++++++++++++++
>  drivers/fwu-mdata/fwu-mdata-uclass.c          |  5 ++
>  include/dt-structs.h                          | 11 +++
>  lib/Makefile                                  |  1 +
>  lib/dt_purge.c                                | 73 +++++++++++++++++++
>  lib/efi_loader/efi_capsule.c                  |  7 ++
>  7 files changed, 179 insertions(+)
>  create mode 100644 doc/develop/devicetree/dt_non_compliant_purge.rst
>  create mode 100644 lib/dt_purge.c

What is the point of removing them? Instead, we should make sure that
we upstream the bindings and encourage SoC vendors to sync them. If we
remove them, no one will bother and U-Boot just becomes a dumping
ground.

Instead of this, how about working on bringing the DT validation into
U-Boot so we can see what state things are in?

Please send the bindings for Linaro's recent series (which I suspect
are motivating this series) so we can start the process.

Regards,
Simon
