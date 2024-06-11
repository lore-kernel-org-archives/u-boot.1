Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FF2C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 18:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C901E88725;
	Tue, 11 Jun 2024 20:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G14dmd9h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9D7D8871C; Tue, 11 Jun 2024 20:52:11 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46BB288723
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 20:52:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6ae259b1c87so1207776d6.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718131928; x=1718736728; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+j9Yk03BYtlxEZsX4xz9SjVcF+NRplTBDhw4IXTwZYw=;
 b=G14dmd9hMshPk4TaOxtCJme2O8wazsQj5db21MZjUlXdlB4scu77X9aapp+3pTar1/
 5AlOmJ9cpUgUcg6fYdbzNr6XB2vn/2tM18/F71TMF5rtM6/umZlk/EJD5lrRM7+MbxDM
 Y+Tt30h82XoSsYPaFpPZCjWrqPCy/4b/luPas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718131928; x=1718736728;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+j9Yk03BYtlxEZsX4xz9SjVcF+NRplTBDhw4IXTwZYw=;
 b=Iu96a972h2TIcFBOlfsauwslcJphZ/3Tvrix9tZcr6mCBW5rwNR8zi5LVgMGPu41FB
 GL/4L+rU2W7AdMmBejuga4MKIms2jE/PiLlxeyOwt+i//VH0PjWEm0N/tOtNx4fyj4ed
 aleVx3fcabPnE2UvNrCubtpmPhte+yRDw/bPg/TCKdhkJzJqpXRz2OwCmNmoS1biJAAT
 FPTIwnh3SAx2sXOcYMfOb9YRxTSKA4fxDvd7jJoLpJZhAR8bfaTDofMi14BhZUFN5oG4
 gOCCmZkhl1GeMpt7/1dl1XrZL3rHZ/L5jqIo2V5HUXukf85FU/IFSpAwo/fRUpKnvfcU
 YWgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhWmZeL8ubo4m6TpM3Kguzik+oeFEJ1CBONIl7KnBeNU+wgnRofJxWjfg+FPenjxABoLwA8PKd3n5U3CZvLhXB7bGskA==
X-Gm-Message-State: AOJu0YyD7hPpHDHvAc4tSEbosNBb2G5woHxMPlpczNpoHjTuAM/S5Cz5
 L0G514k02zIupQY1/CwRc1NdMqScxo758bFuGthQrgII/o2Dhn3isVjzk3EgkT/ZGtwrrgtCnoJ
 M/h7JMbljcdeq5FYRxDIMDJL2Z8G/G6226Es7
X-Google-Smtp-Source: AGHT+IGBxf434I+TOa9lJOH4kW2SGRro7qcxz1msFu5soH7ASwd8CXXRaw9QJZSEuLhPiobC6t9jk32NGX9tx29zdKc=
X-Received: by 2002:a05:6214:3211:b0:6b0:767d:4c25 with SMTP id
 6a1803df08f44-6b089f60464mr71995186d6.22.1718131928156; Tue, 11 Jun 2024
 11:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240611-misc-20240610-v2-0-028e82b0b620@cherry.de>
 <20240611-misc-20240610-v2-1-028e82b0b620@cherry.de>
In-Reply-To: <20240611-misc-20240610-v2-1-028e82b0b620@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 12:51:56 -0600
Message-ID: <CAFLszTicPzDKp3_L0bj0Oqe+ur5j=YODZ_Mwm1DguP-HRSar5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dm: core: fix misleading debug message when
 matching compatible
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Dario Binacchi <dariobin@libero.it>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Tue, 11 Jun 2024 at 07:04, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> A driver can have multiple compatible. When the id->compatible matches
> for that driver, the first compatible supported by the driver is
> currently returned, which gives the following confusing message:
>
>    - found match at 'rk3588_syscon': 'rockchip,rk3588-sys-grf' matches 'rockchip,rk3588-pmugrf'
>
> Considering that the compatible passed in argument is necessarily the
> one that exactly matched to enter this code path, there's no need to do
> some elaborate logic, just print the driver name and the compatible
> passed in argument.
>
> Fixes: d3e773613b6d ("dm: core: Use U-Boot logging instead of pr_debug()")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  drivers/core/lists.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
