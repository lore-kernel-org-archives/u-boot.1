Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD379E9A04A
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 14:31:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3419683A47;
	Thu, 19 Feb 2026 15:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JLFoUH1j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DED8383CF2; Thu, 19 Feb 2026 15:31:23 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9420783936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 15:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-65a40f3f048so1764482a12.3
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 06:31:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771511481; cv=none;
 d=google.com; s=arc-20240605;
 b=J7yOVkmTMS2jxwzkze2MkH2txAZUxpF5YC8qfy48cZ/FROpEFQvUSpYLSy+zZiP2w/
 oGiCxgnwKxRUUlllE7LP7iebJX6XdXtQnRYIhkxpH+q1Io/O8sOxWiy42nZtYOs4hWfw
 IhYAJ9MjXEgCJPFJa+R7EZhkPhzYy3cJlEs24Yjn1pZcdIZhVQ9UklfBTbkLdP10bQu8
 a31wqCfM9Tvp5pFjmYbAmwDXyo5EjTAjqPBmWkwqqNVhPqiYTqanyaSbNdb5H2yqGmAM
 yZDRSAulBXVlcXWtpwyEJoeowdOvazgE+QzLIKGK1LbwVrmsTQz87ykmhZuoYhqxqiQo
 8bVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=P5D8XDea8G2TlULo9UgFYT7r+xDMwBAxOSOHW+sp1hU=;
 fh=89JGekwhSyYOPQOy2uyR8LelJwXS2WWWd2nllJCIfB4=;
 b=lhsJG9rvjRrEfO7tm9g0uMAqVgNoer+G5hTm+LQiDPOePiRqR/yi91wvyOcpk1RuT+
 lDXoue9TAOEm+7I1qvpmTnoAA1lGuwznD2aB1mzvA5jRFfcCMYk1OaIrS1tpZbTh4BTF
 BZjSFy9IrQA690XA5RZj1Z7EMLVywhUxARRz843VvfOIocqCVRz34FcyqDseZLToMca5
 VWy+X3pgT+3gRU0PRpdOoZslMAajzKQKTX2mL6PZetAsBkzCMIDOOy7+XYSUe/WCvPI2
 1uXD7/EiAUBoij6rI5gShNV3zGNNG8ic1ZFdAO2QEn/45ALWqZx7ssbvuWAvCCp7rXBZ
 dDqQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771511481; x=1772116281; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P5D8XDea8G2TlULo9UgFYT7r+xDMwBAxOSOHW+sp1hU=;
 b=JLFoUH1jsA6CrMJb7fJIsOej93XjEQRaeZO1h0jifYmhPpzuNbjv9t1+gm08vSZg1E
 BoA6MxEr3g2FP8JU/dyaEvG3M/nmreePsrhl5ZWDtnFHB9KTn+akhb4Q6PA+iC+R5W+4
 tv9J4eFJhzaHxRfh4xlf6jfGcOQwntY2R76tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771511481; x=1772116281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P5D8XDea8G2TlULo9UgFYT7r+xDMwBAxOSOHW+sp1hU=;
 b=K8mLRhQzUH6kCNT3FZJYruUyVWNQuG3dGIxf7Scww7+S742yIqtBRMTA1JaTTqp668
 WxCwLhIUXZanK7grsKyua5F56lR58Uph8l7t9+4NWz3ZOc+8LT/MKDbV8RJ167dAWO86
 RqLlHtR4DP//v5bGRAEMoHAJljYqYRgub9hwGRo0RyMg1RRXJbDt9zLD5UXEKpEEQBLY
 VtimTeFv1+UFY6WTt9tryoNLanXcEQEBT7RfYgHRRIVk5zC71u3+jaL2sfbxAk3v+kSn
 /iT0MoZf0bnhu9Yh7nzzlDzXU11NefV21xIZkpA5QwXbaU6zUQuWCUshUYm9euP6kcdv
 lEJQ==
X-Gm-Message-State: AOJu0Yw2zQ7LojdPkarXKYgk2XuBg/wCvKjUqQ26O3qQ4+cjLaZaSoqj
 hsaPmp/hONKjHZ9A7V9FzCBEE5oViD5uPefLnN+kkMzNQAXp1E6Ouw0Z8iptzpTZNf+WLmcwe68
 /2rqt7iHSxLl8sqXbSi0xV+7pUL/UL8KN6xc4vZWc
X-Gm-Gg: AZuq6aK9PouSIGyUyhYzAQs6wub9Tk94GibfF+IyHwIVC+NTn5jUs/Yv7a2YQFJVXDr
 vDiaf2fXExOoX2+R/V2gasrrRYD1MSy1ZcJpvC0NtFi6yiv2VqUMrdr1nV06ghQRRujHRYbLjeI
 12giZkG0M49R2DIjPd2NL5gFeRI3t0R+PBCuX0tUhtEo+50Vgya6U5YcsNxDDUZz2oZHgvnodSw
 JcEHRvsHCcpYPQjojlFIcAAftfnjuXZNqxQHZ6c0He6Hw3JK+SnaWpB0cHadr52bsm28YvgaUMV
 OINM/w==
X-Received: by 2002:a05:6402:f07:b0:659:4d41:9f70 with SMTP id
 4fb4d7f45d1cf-65dbd3a1dfdmr1353518a12.30.1771511480855; Thu, 19 Feb 2026
 06:31:20 -0800 (PST)
MIME-Version: 1.0
References: <20260217115333.503359-1-Wojciech.Dubowik@mt.com>
 <20260217115333.503359-5-Wojciech.Dubowik@mt.com>
In-Reply-To: <20260217115333.503359-5-Wojciech.Dubowik@mt.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Feb 2026 07:31:08 -0700
X-Gm-Features: AaiRm52bGDVU3SAp4WAQCfrGy6w_1v2zOEXL_KcAqh_o_GPEgxvWFLtfJo5T8mw
Message-ID: <CAFLszThD4sb6dDOq_8-XJ-QapoxbuHOZJt0rRJBeydpr6fhFJw@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] binman: Add dump signature option to mkeficapsule
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, trini@konsulko.com, 
 simon.glass@canonical.com, quentin.schulz@cherry.de
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

Hi Wojciech,

On Tue, 17 Feb 2026 at 04:54, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
>
> It will be used to capsule signature verification.
>
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> ---
>  tools/binman/btool/mkeficapsule.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/binman/btool/mkeficapsule.py b/tools/binman/btool/mkeficapsule.py
> index f2ac654db81e..7638c941a8ee 100644
> --- a/tools/binman/btool/mkeficapsule.py
> +++ b/tools/binman/btool/mkeficapsule.py
> @@ -38,7 +38,8 @@ class Bintoolmkeficapsule(bintool.Bintool):
>
>      def generate_capsule(self, image_index, image_guid, hardware_instance,
>                           payload, output_fname, priv_key, pub_key,
> -                         monotonic_count=0, version=0, oemflags=0):
> +                         monotonic_count=0, version=0, oemflags=0,
> +                         dump_sig=False):
>          """Generate a capsule through commandline-provided parameters
>
>          Args:
> @@ -53,6 +54,7 @@ class Bintoolmkeficapsule(bintool.Bintool):
>              monotonic_count (int): Count used when signing an image
>              version (int): Image version (Optional)
>              oemflags (int): Optional 16 bit OEM flags
> +            dump_sig (bool): Dump signature to a file (Optional). Default no.
>
>          Returns:
>              str: Tool output
> @@ -73,6 +75,8 @@ class Bintoolmkeficapsule(bintool.Bintool):
>                  f'--private-key={priv_key}',
>                  f'--certificate={pub_key}'
>              ]
> +        if dump_sig:
> +            args += [f'--dump-sig']
>
>          args += [
>              payload,
> --
> 2.47.3
>

It looks like there are still two problems with test coverage:

tools/binman/etype/efi_capsule.py                          65      2    97%
tools/binman/etype/fit.py                                 358      1    99%

Regards,
Simon
