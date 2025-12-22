Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42159E6748D
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 08:17:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A45CD83DEB;
	Mon, 22 Dec 2025 09:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H2+5J63S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F6A83E16; Mon, 22 Dec 2025 09:17:44 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35D3E83D3C
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 09:17:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-78fcb465733so10500247b3.3
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 00:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766391461; x=1766996261; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QwFED7VD/x+wl9/3h5w6o84CWUVdyXTzgFNhn6+auAo=;
 b=H2+5J63Sp3oDNxSf7Z8Cw10eGNrksMVHSXSxLDBFgyLZyRcr1q381TzvLxu+T2oknP
 60uFRZpOo8ThKCLfLC8nDDQQj1zT9YmrsmWnPXiU9sLQ5jpG69TSrer9pIR6iFT4/fsM
 9U+36qygW1haU8NuqHUpGrj7GmGkKHX2fA9ZISdhfkiBn8dV08mR9bvUEaycHZJDnRcw
 OnViTlrjHZikR/FID24eDSYj+DSZ2oh+WphPJdtcVREe5smuJe2JKde1NOkm8I+pEx61
 rD1setEsiXLm6Nzd4n+BPbf9RopkbzU4rNQoZm6pE7ivgTVXosLpeU9LkLK8G7Ssk/IV
 r/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766391461; x=1766996261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QwFED7VD/x+wl9/3h5w6o84CWUVdyXTzgFNhn6+auAo=;
 b=rYZQ82YcQBfNUlOqPRtNgxj8AH3WjEjVERWqF5tWK6rqPkPxfJ0CBM/Y0OdRJR6zXQ
 Ti0M17+kgYQ92I0kkG1Nq1nE6SHj/5JbkCVMbchTa/pOXXsw/62k2pru3TV6D+yVQh/V
 Rg0SyXS+kCPr7B/hU+e8goa/n/wlaneovl6ISq0VJzL3hVAoRgx3F+nRA/kQQXjWjmB/
 /otP8wfWBPRi+s+ImnmmN48a+QcYSeHVohUkJlp2Fn/WJwLtaGEzmEWWL3sGzzppgY+P
 MDpOj7LUWrTUVXpuHfleKj59jYciN88EBFes7DRvRpwKNkSWiV24h7HwHqGno0HEINse
 uHOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIeChQR/rcnRFqV3tOYPYE9VGjxsQZ/cFT+rMVRbsn5O8K+BpohLUPJ+jaOgyNWh9fcWXEKgA=@lists.denx.de
X-Gm-Message-State: AOJu0YwatFC61od1vhTosotbfc9MrVlpT/tkfhxvjQRO83T4bfa0x6KO
 uNngl4lB/YLrZ6uyWblLiifnnDwH1OrmsWjDu1KkBwCMmklcFmBou0o20QTlS82zh6xufItC5tn
 KetlmqQfK5wjG7Q/JG6O0NxK7aTEQBZ3NjpkR3k2phw==
X-Gm-Gg: AY/fxX7mDEwTFs3syjBgL+n0HcKkZOGY25baxd5TSKr8YUcJkb4iecYE2coSBLDFCwU
 7Vu/KomB7QsVMcfWL3NWlqfDIVkwTP0oRUsHc0Ewe/3VET43ar2MpK9yjvCNY+eTRZTlTb3E7/G
 W6LG7WtIwSZ2GAdpo7Gw5sZVtlZ4mAv95wPj77dHgRwDZ0ITA4KTjC+GzQ++YsIlpf3pm0GcOwl
 2FGitdve7YuNf3X0wWHlBfPQ8ns5YQ74y3sz8W2klwMec9As/WrGNF5td+6p5r26HNFk8jIrw3Y
 jLkV66eWZL+4M9/VUxpoEGz6aDd539AT5rQWEqQLU6fA+AWZFBv+Umz17oLQz7XMhpmrPrq/T0n
 XDft33jvrOiyQ5z0+guIsgrnk/dGQluZ77HxqwsemGtvPJStmRAXCjVxm5bB6VhUE8+/Wf/e6+o
 x4R2kp2j2UpqVqumxUbg1zxPgFi65PbCYFnq1V11hUjryZojlGM+08YxSWDwHbeX99aaLU952xL
 v8U2e/97257kWMD+J1TY0UZyB111X6RPQfVi8VXl4RGKh7E/Wf/bUvO5RqkFLuiG/m+QB9qkGzy
 qpXjnfS+MOBKpogrwLHK8lGTnC6jpTRw
X-Google-Smtp-Source: AGHT+IFdHxVZJK/OO9exH1uzmQ3uR9cUnBkan5BzsJ82GV3mvX03HN0LZ/7YTyD+9ZJzHgiNz2kgTG6tuZ/Gkjlhl+k=
X-Received: by 2002:a05:690c:3392:b0:785:fe77:ccce with SMTP id
 00721157ae682-78fb4144843mr90342577b3.44.1766391460928; Mon, 22 Dec 2025
 00:17:40 -0800 (PST)
MIME-Version: 1.0
References: <20251219224326.195190-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251219224326.195190-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 22 Dec 2025 10:17:04 +0200
X-Gm-Features: AQt7F2qisrPvn5UW6mUzY0QAsE1DqBu_WlisI2SiNnhB9TaNhfGVlp-CUbED5YU
Message-ID: <CAC_iWjL94aX+9dGfYsG6ut0MSXB97Ta_C20nkj1SEeQGiErSiQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] test: The LMB test depends on CONFIG_LMB
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Sat, 20 Dec 2025 at 00:43, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> We cannot build the LMB test without the LMB library.
>

This was always building LMB. do we need to adjust any Kconfigs with this
change?

Thanks
/Ilias

>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/lib/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test/lib/Makefile b/test/lib/Makefile
> index 7c9dc180c8d..f25383a40e5 100644
> --- a/test/lib/Makefile
> +++ b/test/lib/Makefile
> @@ -16,7 +16,7 @@ obj-$(CONFIG_USE_PRIVATE_LIBGCC) += test_ctz.o
>  endif
>  obj-y += hexdump.o
>  obj-$(CONFIG_SANDBOX) += kconfig.o
> -obj-y += lmb.o
> +obj-$(CONFIG_LMB) += lmb.o
>  obj-$(CONFIG_HAVE_SETJMP) += longjmp.o
>  obj-$(CONFIG_SANDBOX) += membuf.o
>  obj-$(CONFIG_HAVE_INITJMP) += initjmp.o
> --
> 2.51.0
>
>
