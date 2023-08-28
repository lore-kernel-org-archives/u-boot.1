Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892F1C83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 22:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 695DB864D7;
	Tue, 29 Aug 2023 00:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eyu5e8zg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E86E886488; Tue, 29 Aug 2023 00:10:10 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30085864E7
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 00:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3a76d882080so2859504b6e.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 15:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693260607; x=1693865407;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o002CAguigUYkPzhp2OXHO3azqG5Qasz3MYi91bK4WQ=;
 b=eyu5e8zgmK/93GK6IIqN5KCHpRpcuMMB9YH2UxLA3XCHtedYZmcZouZeVlRq875pmQ
 j8k0Eu2HHuwHfKQWbvqTsgZ8UAe2jnv0ig9hL6xajXAzBiH8k9/8i+/I7fTM2MkamhAe
 xoifkVZp3VCRx95HpM9PCcvTIZyRSr6EgdvKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693260607; x=1693865407;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o002CAguigUYkPzhp2OXHO3azqG5Qasz3MYi91bK4WQ=;
 b=VHHKZy8lz1U6NR9Hibs02ix9MavYZqsZ4Auebt/kjyIxZu0vF771zG1XdFaTmKUbzD
 uqy7/RhNKzcLPNSetKECrhKayKWsS68q9nkLuSHd7YzpGO/L6YMOHW+ipcJ/5m5cjwr2
 24caTihxM0wwDiO8I+jg6j5CT20FIHVxkkONYOkjnuf6sTVWxHNaUFCqu3/49GLTItuj
 e0yeOnqp32bSvCOA/yrGuPtCBYTnLcYscD+kJCTppNplHlbxsKQd1Q3n9vTXs/oVESQN
 3/kMxQRsFvGMqXdZUO1TmyTlkgfJWJMmQhUDMA8Etz09HiMkHVlmYXQZKiWPJcXs0VxE
 GXgg==
X-Gm-Message-State: AOJu0Yx4d8JlsreWCKEN+97NB6NAt6fkWiY07wXDTvPUXX4cGLHxUMqO
 nMY1ql7WtYs29R3ODfCCRbLtpEg4zz+Tj2PrdWhw7Q==
X-Google-Smtp-Source: AGHT+IGwp408LSjb0mT8ojDI1tqVcDDJ+rsYZyK6G2NSHg+w7oUF1tzUNTU5ZD/ndR9qET3pOFACd/H8zwqVF17DRpQ=
X-Received: by 2002:a05:6358:e498:b0:137:8922:7ebf with SMTP id
 by24-20020a056358e49800b0013789227ebfmr31196579rwb.2.1693260606570; Mon, 28
 Aug 2023 15:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230828184959.75898-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230828184959.75898-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Aug 2023 16:09:26 -0600
Message-ID: <CAPnjgZ3SZxYf-3J-YnGphqhsW9BA+qRO9AnGd4DXvrdBMk1Ccg@mail.gmail.com>
Subject: Re: [PATCH 1/1] bootstd: BOOTDEV_SPI_FLASH requires BOOTSTD
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 u-boot@lists.denx.de
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

On Mon, 28 Aug 2023 at 12:49, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Compiling sandbox_defconfig with CONFIG_BOOTSTD=n fails:
>
>     /usr/bin/ld: drivers/mtd/spi/sf_bootdev.o:
>     in function `sf_get_bootflow':
>     /drivers/mtd/spi/sf_bootdev.c:43:(.text+0x96):
>     undefined reference to `bootmeth_set_bootflow'
>
> Add the missing Kconfig dependency.
>
> Fixes: Fixes: 0c1f4a9fb13a ("bootstd: Add a SPI flash bootdev")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/mtd/spi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
