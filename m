Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E345C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 09:15:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2EA1886F0;
	Tue, 23 Jul 2024 11:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="USOUR+O7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC3AF88754; Tue, 23 Jul 2024 11:14:59 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B559488602
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 11:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7a03ada9660so1461468a12.3
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 02:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721726094; x=1722330894; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pycp6JZZiW2csXk5EJS+EtA/fdlzVKQ+ncYa1J9QJaU=;
 b=USOUR+O7sm02RyV2B/czWx1tLDup9AjgxXbL0RzaETX6OIpN3+1aBpAGzJ/LpVeNYs
 j/CirxB2VsGfZZRz0sJct0g69OY+7wUWoda0PXOvp57Bl4yBAMzL1vYm5Tv+UCrCnU+O
 0290QYZ+JPaVy5fJI/3PK0SlULJ3RbUl2Mf3jrHe001sxm39y8YB/DJL9vGtJb8VIySQ
 2I+0BaEKTuEsusHv2hMsMw2UrArvuM6q1YWwIYXGQ1nj2rKdpXo961Gqov6k+vdNZAfN
 BHsu0zFoia8vu5eMVc4lXkLjGH5FRmEXhv/P6mdqvYiRGYlMYFNDw9SvcI/YOp3rIQML
 iJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721726094; x=1722330894;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pycp6JZZiW2csXk5EJS+EtA/fdlzVKQ+ncYa1J9QJaU=;
 b=G9GI/Z3Rh+jz6dGyqrOZBC8xO73FD0N8khhRugdApo6zUhAOpB6tIaMe3By4rbBdq5
 wTDNGozeqLoMkFwhEAky7rkdlJ0tJbvi/amOVeFmB1Vyir/i2IvFJtJhKl57nZc8Wdn+
 P7GqhyQtEvRj1ljPPGMZ58trQR2zYxFOfSwlMOHGXy/UEpjrRbi1Fi9eTJhwVUwevn5D
 ViL2gl6/FsxcolmLj2faTwkJv/zMj6ktniLlLn7PP4I1xSevxZiJrYmODMHI/RC+WxpJ
 qW37hkl6NIiOmxl/TOaj9BR+VEhWqYQlvLGbQ9LxvjJYvHG76UV+jj/3P4+7p2xR5xcM
 dxSA==
X-Gm-Message-State: AOJu0YzXRCKuvUD/dpSkXyHxKSBaRBbjCwQ00RrXHLVGHivfSpE6sVY8
 A37uVn98AE9ADm8p3ALn6DKM0s0zDDQqAjFZOGhFvZLLNOf1bWz/fuLRlt9KmyhmJU9tw/VgNEm
 TXGcm0pnpYu0486B0kj0GFTUzmVK+9DsNu4nWWQ==
X-Google-Smtp-Source: AGHT+IHExYlfDQIbmw8epwBEAI4gJEt4qneh/pT3pR3EtVF1doPSnhgsNOvv1s8PJBOGjrsFkeXAw0Rro1mlGmQPJx0=
X-Received: by 2002:a17:90b:3b87:b0:2c9:99e4:51bd with SMTP id
 98e67ed59e1d1-2cd274f02b2mr5174057a91.29.1721726094047; Tue, 23 Jul 2024
 02:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-27-raymond.mao@linaro.org>
In-Reply-To: <20240702182325.2904421-27-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 23 Jul 2024 12:14:17 +0300
Message-ID: <CAC_iWjKS=d7ghOTPrSmKyxgVhv9KyW=_N6uiiLvFym_0FzMWiQ@mail.gmail.com>
Subject: Re: [PATCH v4 26/29] lib/rypto: Adapt rsa_helper to MbedTLS
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Ilya Lukin <4.shket@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Sergei Antonov <saproj@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Alexander Gendin <agendin@matrox.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

On Tue, 2 Jul 2024 at 21:34, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Previous patch has introduced MbedTLS porting layer for RSA helper,
> here to adjust the makefile accordingly.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Initial patch.
> Changes in v3
> - Update commit message.
> Changes in v4
> - Control building legacy library via '_LEGACY' Kconfig.
>
>  lib/crypto/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
> index 9bbd8b48d77..281e507743a 100644
> --- a/lib/crypto/Makefile
> +++ b/lib/crypto/Makefile
> @@ -13,7 +13,7 @@ obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE_LEGACY) += public_key.o
>  #
>  # RSA public key parser
>  #
> -obj-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER) += rsa_public_key.o
> +obj-$(CONFIG_$(SPL_)RSA_PUBLIC_KEY_PARSER_LEGACY) += rsa_public_key.o
>  rsa_public_key-y := \
>         rsapubkey.asn1.o \
>         rsa_helper.o
> --
> 2.25.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
