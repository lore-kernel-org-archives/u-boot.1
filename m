Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD92E732D8
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 14:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA7ED86E52;
	Thu, 28 Sep 2023 16:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ln6mKc0T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29E5F86E55; Thu, 28 Sep 2023 16:20:08 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31C8086504
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 16:20:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-532c81b9adbso16390470a12.1
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 07:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695910806; x=1696515606; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjzfE8cXBAi5sTJNjwiJYkhs9/kk1LJW8/2vRsyoKjI=;
 b=Ln6mKc0TsLmPC5QryDdoWKkdhlEI4mGrvQpX5P3dlQ+2Sm8sKYuiYL5T/FTvYIOSsT
 1hZ7+RflkBdGWo5MiwGhDZfRzZwM/uYrDPDjqSVaktWs6vnkNJfrzsIOUetA5+zxtzXr
 +JFx7NifT9tlmLZdjSdIY7t43Rc86uRxZP0G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695910806; x=1696515606;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cjzfE8cXBAi5sTJNjwiJYkhs9/kk1LJW8/2vRsyoKjI=;
 b=VQeeA8HYj1RgVyyk/8qETgaXBCIj7N+o7+vY1sHbizoMWMFKbwiK3qiR1fxszO1CCU
 i10NHtkGGyaNPZZHZ9B0HPHe3GizlCd0LKB6OM/I5Oqaf9DIL5aLKh3ActMpUiWHEMAp
 zphGrhFfiDcOlw0zeaQ8IP/S2V4p70Le5qiaSirGVaQ/yQGjzZjdnIcuwWJwlRRBkSEh
 LjYmF4yiBtV1ke8yqpOmaduU7hxXhQT45DAuJ15AL1Adz456KEznXi+Q4941WkuuNVJJ
 xYIqt9yWoI9PInQDKgpb9C9rar83eBHCJq/b6tVZ121+Z/CyLSFfrQoEnESGji6fTAci
 gf4g==
X-Gm-Message-State: AOJu0YzvXbaTsiZPwoJvy1xSKes+WiA00QolIDJq0tgklBRRZjfTfl/+
 0WMrb2TCv5KaeIAfMoAfaDMD+r2KJYnEBL8bKq7wjg==
X-Google-Smtp-Source: AGHT+IF3WsC6P0I5gZY4cymYMplSU+aVP5KIGqXm8D66xFofbVxXmhY4A7pl16Wyrrnq9e8Qw11Iz3X9IVHKTy3eD04=
X-Received: by 2002:aa7:ca41:0:b0:534:78a6:36cb with SMTP id
 j1-20020aa7ca41000000b0053478a636cbmr1087107edt.39.1695910805380; Thu, 28 Sep
 2023 07:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ0vKO0YYpQyr_C35bY41un59AdZcY45OT3+ydxkCr7BOA@mail.gmail.com>
 <CAEUhbmU0t0LE2M+9L-heY3UZBgNsgDuPN-JheFsUwMfBndE+Dw@mail.gmail.com>
In-Reply-To: <CAEUhbmU0t0LE2M+9L-heY3UZBgNsgDuPN-JheFsUwMfBndE+Dw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Sep 2023 08:19:54 -0600
Message-ID: <CAPnjgZ3JnvcoQ1Vi-AXnW6-wC0H_FNqoQJp31Kdyp+TBOL6Dnw@mail.gmail.com>
Subject: Re: SSE instructions
To: Bin Meng <bmeng.cn@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Bin,

On Thu, 28 Sept 2023 at 08:15, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Simon,
>
> On Thu, Sep 28, 2023 at 10:41=E2=80=AFAM Simon Glass <sjg@chromium.org> w=
rote:
> >
> > Hi Bin,
> >
> > U-Boot 64-bit on x86 disables sse, but when enabling Truetype I get a
> > compiler error:
> >
> > drivers/video/console_truetype.c: In function 'frac':
> > drivers/video/console_truetype.c:30:15: error: SSE register return
> > with SSE disabled
> > 30 | static double frac(double val)
> >
> > Do you know how to enable SSE for 64-bit?
> >
>
> The following patch could enable SSE for 64-bit:
>
> diff --git a/arch/x86/config.mk b/arch/x86/config.mk
> index 26ec1af2f0..250d7c9948 100644
> --- a/arch/x86/config.mk
> +++ b/arch/x86/config.mk
> @@ -27,7 +27,7 @@ ifeq ($(IS_32BIT),y)
>  PLATFORM_CPPFLAGS +=3D -march=3Di386 -m32
>  else
>  PLATFORM_CPPFLAGS +=3D $(if $(CONFIG_SPL_BUILD),,-fpic) -fno-common
> -march=3Dcore2 -m64
> -PLATFORM_CPPFLAGS +=3D -mno-mmx -mno-sse
> +PLATFORM_CPPFLAGS +=3D -mno-mmx
>  endif
>
> However as Heinrich mentioned, U-Boot codes should be written in a
> "floating point free" way.
>
> The fix should really be updating console_truetype.c to use integers
> instead of using float/double.

Yes, I can do that, but it hangs going into 64-bit mode, which is
presumably why the flag was added. In fact it was your commit!

Is there some missing init somewhere?

Regards,
Simon
