Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07409CE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 13:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A29186C67;
	Mon, 25 Sep 2023 15:11:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dD/+P9T4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD95A86BFF; Mon, 25 Sep 2023 15:11:15 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F99386C2C
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 15:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-533d6a8d6b6so3796911a12.2
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 06:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695647472; x=1696252272; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UxZKip8iqjyw1D7OOTPa0UZt8jJu6ZEDKxOWJ3T73fQ=;
 b=dD/+P9T4kWETmHkzAmFMaNthXMwnX4h0DmU+rSb2PnhajiWnQpZ6csjZUZVvvJ42+W
 nLoC6ITv8SCA0p+LEnidbF2w2BNZmZ1L8m/P4tbqk0Jqjw5y0JjTcAhemBCXIK/NjfIE
 YSK5rHjtYicRcQEbxLeXHAUVOEkLMJWCED4AE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695647472; x=1696252272;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UxZKip8iqjyw1D7OOTPa0UZt8jJu6ZEDKxOWJ3T73fQ=;
 b=hibdIasWhkvhX8Wi4TfdDV24CTbkv3icuSwEUEsrkmoa3gUNgt97Tadae5Vwr385Qw
 ZoTZocyn7AcnnbV0m+4GpFBlvots5mCZiuZqmHhWyfClGtSF5zdQ5Shd7mGk6UX+9chq
 eX5qLIjHSYozeQuUIZtnPE8/43Txbqo2OFSTLItu90mMMrNuQqN3If4ka80dD3MxzFb5
 mTEhv94OLwHSS42i2xJyNQWZAQJaMHgiGVh3meS7iBTXufOS1z9YcxaXr7dqTYYhRExT
 dbAoGsroNK0HJrLS+9BcUWO8fxBe2aIisL3FYjIDtLdQDW4tbrjTWwG0/EJpNwvmSqQO
 LkoA==
X-Gm-Message-State: AOJu0YyhARhab/36HbUVJOH/YunjQ3/pOXfrtZU8xzlO0GIium6YHGoP
 Sx0gQNjANUtUtL4Pc4IA+kWBPhGPCaGbqe1zIlJ2cA==
X-Google-Smtp-Source: AGHT+IHP+Z7R+KM8Ok6YZbVdD4HZBt8Hr5jk6KbEhn0sUcJC3VPTiQi4aCAC6SME7F7TMvzXi/PmcOhy0KeN4b9LuTM=
X-Received: by 2002:aa7:d78f:0:b0:530:74ed:fc8a with SMTP id
 s15-20020aa7d78f000000b0053074edfc8amr5115314edq.41.1695647471342; Mon, 25
 Sep 2023 06:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230925080909.365098-1-rasmus.villemoes@prevas.dk>
 <20230925080909.365098-6-rasmus.villemoes@prevas.dk>
In-Reply-To: <20230925080909.365098-6-rasmus.villemoes@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 Sep 2023 07:10:35 -0600
Message-ID: <CAPnjgZ3En_6KqZS-ZpG4HY7pxOqnSbPn-awVcPRUZPSJEiTxvA@mail.gmail.com>
Subject: Re: [PATCH 5/5] doc: use .dtso as extension for device tree overlay
 sources
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, uboot-imx@nxp.com, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jan Kiszka <jan.kiszka@siemens.com>, Tom Rini <trini@konsulko.com>
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

On Mon, 25 Sept 2023 at 02:10, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> Moving towards using .dtso for overlay sources, update the
> documentation examples to follow that pattern.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  doc/develop/uefi/uefi.rst  | 4 ++--
>  doc/usage/fdt_overlays.rst | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
