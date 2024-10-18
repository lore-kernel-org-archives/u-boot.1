Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4062ED3DEA0
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 17:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45FC388E51;
	Fri, 18 Oct 2024 19:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fr7M+Paz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BE6288EC9; Fri, 18 Oct 2024 19:21:15 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2920388CC1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 19:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cbd005d0f9so15696556d6.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 10:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729272072; x=1729876872; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XCDHmJIZpLs9uGsYImv3ymJTnF9fhN7CqgSs4Hqp0E4=;
 b=fr7M+Paz6k5uQmamqybkyEoNKon5FUxIzEajqZak8IlU69cHv1rvBapnTex06oBHq2
 e/WlFPmga9bxaJECIILG9q/2G88v++scW+/gpRVY/BXWTP6W6zFb6F0KsmJopw3fK+TI
 xm2Ad5ZTAYVIFPKApVi2zWNFzTy9RPdjtENak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729272072; x=1729876872;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XCDHmJIZpLs9uGsYImv3ymJTnF9fhN7CqgSs4Hqp0E4=;
 b=DXkxr3EYaMaPbe7dBONWlyLxcry5PpR6YIMF0ipSltxqpqFLRPk0ral/mxmfUi/FV8
 96A9/V8e9vsEIQr851/C8Vlzu5kRddsn+LLSaN9jnQQUVAVy1TUqtB8IBuIUH62uhvlX
 nLvkMq+xcBi5O1iVYyBI0oCZv9ilojtzb4APlCrUGXJrDHPwXzPkif1T39iudc/+ZGEJ
 IV99lI+LtY8UJ12KrYhalPX/an/qDauBYoSZbjpT82PTVDu7FDWqKDqgJQuf/SM5dh+4
 70VqtsPxAli26s+CSHBXGcagSqLJFFetYrjusqCb/nxO8mdS2pLmOWKVoPHerY81ia1D
 WQKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjEGfxea4kdhsbyyhKjCqjfqqMsDmjn+bdbS6JOOswiXiS3VnrGI/gIqKYrDH6YRkpAORUR/s=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0IX1viaJKV4tq7rX9qjZt1hJ6aFoIdxaM4ynGnSpqdqJ2RZjl
 H4ZHZzAc1KcAEHhigHU7mgdfLRadZWWA6DAdR9IhHSfWBihAUnJqKScAQYwr6se63Y3en8TEGXZ
 JAOCbzabr1rqKtc3vjXAMbpJSa8HMxwfl7mqY
X-Google-Smtp-Source: AGHT+IHzDAAQT8L5+o2rn7rpsjvvJwe+u4pmMv4YZC53q4URoIbBwDGxnBcjOnwG97pFXFiFWZwsUmTJ01dcYCUrT1w=
X-Received: by 2002:a0c:f413:0:b0:6cc:51f:6c41 with SMTP id
 6a1803df08f44-6cde15e9d63mr42327386d6.36.1729272072077; Fri, 18 Oct 2024
 10:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241018011837.126813-1-heinrich.schuchardt@canonical.com>
 <20241018011837.126813-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241018011837.126813-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 11:21:01 -0600
Message-ID: <CAFLszTjjF1r4f6NjrYSFz36DK_X6v6rYMwDCUqiSLOPysGRC7g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sandbox: add bootmethod EFI boot-manager
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Thu, 17 Oct 2024 at 19:18, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The EFI boot-manager is the default method to boot EFI binaries.
> We should be able to use it on the Sandbox.
>
> * Enable EFI boot-manager bootmethod on the sandbox.
> * Adjust unit tests to reflect the additional boot method.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
> v2:
>         no changes
> ---
>  arch/sandbox/dts/test.dts |  4 ++++
>  test/boot/bootmeth.c      | 28 +++++++++++++++++-----------
>  2 files changed, 21 insertions(+), 11 deletions(-)

This is better, but I still see this.

=> bootflow scan
     efi_var_to_file() Cannot persist EFI variables without system partition

Please find a way to get rid of it. I can give some suggestions if you like.

Regards,
Simon
