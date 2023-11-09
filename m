Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E65C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 01:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5CEA870A4;
	Thu,  9 Nov 2023 02:15:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YjtFi4C3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 957B487033; Thu,  9 Nov 2023 02:15:29 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1112E870A8
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 02:15:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53e2308198eso425997a12.1
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 17:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699492523; x=1700097323; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/Y7VAakIhpjGFR4Vqp3myIw7VIPEq92qSFBMKBtqZ74=;
 b=YjtFi4C3mfSn+xWsDUiIcChMeo441ot+3yo42lLRFF1kiKSr9KUxUNDFTvskvDjXwP
 AN4kqPKeaoNB1e+KkHF8TDOWA0jDtj2EtjVz2zhDMor0+FkvZts8moLOfAVLtUxEcdUz
 3bc5fyIeQ5EgPJ48w5P99x6g412bAzxXDZQwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699492523; x=1700097323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Y7VAakIhpjGFR4Vqp3myIw7VIPEq92qSFBMKBtqZ74=;
 b=h0d30y8dHZryk4VCJVjAeD2ATAlbepjyDU458wHtlwm+gc4+oZqbi7KBTHtYvnck1k
 WOVin4gmT5AZsdL87vF01653979c0xOvN78w4uHAlRF5BSiQ2AYjJpoYNG8RhsEdebDW
 /s7xkVM4/kaC5c7tgZ4WOH8QnrhMAoSVUhBl1pys1IUA13r7wtn2YP+/A49Juj57liMP
 RRVkhMYeHtlK42sELwbXhWVBNZi2sw2Z18PHdDn2ZsZ5W6q56/iyvjf32syAeJW1QNCw
 UcLUNnQncEdFna7PZt7KLh/m2LBwERqpTYQrEBPKmTouEUpqbCtNdbBp84N7fxYuEMbJ
 bWJw==
X-Gm-Message-State: AOJu0Yzv8rQkHPgAEgxLndLXFJUmHmWNHnHFGd+hMysXQHk87S95JKu2
 +bFgfY/Ww/p1/tYmIKvWHO8tcKUWRcoCfryecMmWCeFSy1oRdSjFckRwdA==
X-Google-Smtp-Source: AGHT+IEGIt/r3oU5lTZ6ai7lzjYMzWVo4jvilaEu3qB7pRhM21Uc0NLD8bAf8GkpCkvsVkv7hkMpUPOXyRvBXUtnjTI=
X-Received: by 2002:a50:c351:0:b0:543:4ff0:4fd5 with SMTP id
 q17-20020a50c351000000b005434ff04fd5mr2576892edb.39.1699492523347; Wed, 08
 Nov 2023 17:15:23 -0800 (PST)
MIME-Version: 1.0
References: <20231109001225.2357160-1-trini@konsulko.com>
In-Reply-To: <20231109001225.2357160-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Nov 2023 18:15:11 -0700
Message-ID: <CAPnjgZ26m0H=+40Gcx21KgkZe-gKx42mS5QbJMd4oHT4Q_HUTg@mail.gmail.com>
Subject: Re: [PATCH] net: Make NET imply NETDEVICES
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Wed, 8 Nov 2023 at 17:12, Tom Rini <trini@konsulko.com> wrote:
>
> Normally, when NET is enabled, CMD_NET will then be enabled and in turn
> NETDEVICES will (likely) be enabled via imply. However, if we disable
> CMDLINE in a defconfig we now no longer get CMD_NET enabling NETDEVICES
> for us. This suggestion (as an imply is) really isn't about the network
> commands but network itself and is a legacy of how intertwined
> NET/CMD_NET were historically. Move this over to the NET entry instead
> where it is a more logical fit.
>
> Reported-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> This could also be dropping the imply from cmd/Kconfig and instead
> making drivers/net/Kconfig::NETDEVICES be default y, which is what it
> practically is today. This would require a more lengthy check however to
> be sure there's no functional change and I'm not sure it's any better or
> worse than this approach.
> ---
>  cmd/Kconfig | 1 -
>  net/Kconfig | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org>

Thanks!
