Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D458C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1152D88AEE;
	Tue,  6 Aug 2024 23:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mmBGwp9P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71B5A88AE4; Tue,  6 Aug 2024 23:51:06 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BE3888AF2
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6bb96ef0e8eso6059816d6.2
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981051; x=1723585851; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C+PJNatz7KD6dRVKZ8UGaj+r6432ValLYqxd+tY04f4=;
 b=mmBGwp9PB8dY6gTPHhhmzSyT83UBD8sXkpk9wuoadRwQhvfKwwd8JehcIS4EkGGMaH
 fe9nCZZHrrw+Ju3qrFd/M83HKjC2O9NDGICKQltH56QXaM0DrsvjaCfBJJPcz3V7g+1v
 saDHwaY4pKRSJURHZYQwYFx2t8w9r4SXmaFcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981051; x=1723585851;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C+PJNatz7KD6dRVKZ8UGaj+r6432ValLYqxd+tY04f4=;
 b=A9lHYCOqqM2XO4iJoQQepdrksXi4eD3oIKuiDhBLBqDpYGs+pQ10ZF6KOEcq/bUUQM
 r5oL5iEg9TmrijEuJCx1VtNYP8f0ZpzWhseMhpyiRzSO48QQ6TrPo6qgVHKP9CWAPGsS
 63yXPxj5D8uVMY/ow69wqjjYnwJkjTbETogg5ntk6C93vJv7GET4eoX2ilR7hka91aC0
 STuNKpGmPueekYIq6cgDit7kyWXYMvZZiRVQeR9ajv7N6wELefzKJ9tIaeKhUhwxOM95
 OuOfaTZX8yB9+ZTOShZEIGvUVBzalJsDXvgNus6TqpXxQAGvxx2TCnRLmC7MoycEeRIF
 /Ixg==
X-Gm-Message-State: AOJu0Yxn5VwnT+jBRj1KQai9jJ1i72KlEh0Z7jWWjF9qpiGvv1CDXxOn
 ujj0Vlg83ELUGjoNpSqFK1SSX3+nqrgLCdKXS3QnJsaFyF4u6GziDidF+YiwOqelNawKh1+Zjpk
 rD7sqABgEhb0C9Ds0sc7CEmFbYCsmHkZvg0p/
X-Google-Smtp-Source: AGHT+IGs2He9t3KgAFxTwTDhGJEkhmCuvH1cVSWGUZDRSYGDD8XvSJ41GIEYQNxVwXNN4ZhdrTg06mUTnSi9HR2TuFM=
X-Received: by 2002:a05:6214:3385:b0:6b7:b08e:e7a1 with SMTP id
 6a1803df08f44-6bb983f94d2mr170703576d6.30.1722981051055; Tue, 06 Aug 2024
 14:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240802100846.16619-1-richard@nod.at>
In-Reply-To: <20240802100846.16619-1-richard@nod.at>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:50:39 -0600
Message-ID: <CAFLszThAeNEnCv5kCVvNMUuUEn-p5ip4znsPj_RDUZskrUSVeA@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86: Fix ptrdiff_t for x86_64
To: Richard Weinberger <richard@nod.at>
Cc: u-boot@lists.denx.de, upstream+uboot@sigma-star.at, 
 marek.vasut+renesas@mailbox.org, eugeneuriev@gmail.com, trini@konsulko.com, 
 bmeng.cn@gmail.com
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

On Fri, 2 Aug 2024 at 04:08, Richard Weinberger <richard@nod.at> wrote:
>
> sbrk() assumes ptrdiff_t is large enough to enlarge/shrink the heap
> by LONG_MIN/LONG_MAX.
> So, use the long type, also to match the rest of the Linux ecosystem.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  arch/x86/include/asm/posix_types.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/arch/x86/include/asm/posix_types.h b/arch/x86/include/asm/posix_types.h
> index dbcea7f47f..e1ed9bcabc 100644
> --- a/arch/x86/include/asm/posix_types.h
> +++ b/arch/x86/include/asm/posix_types.h
> @@ -20,11 +20,12 @@ typedef unsigned short      __kernel_gid_t;
>  #if defined(__x86_64__)
>  typedef unsigned long  __kernel_size_t;
>  typedef long           __kernel_ssize_t;
> +typedef long           __kernel_ptrdiff_t;
>  #else
>  typedef unsigned int   __kernel_size_t;
>  typedef int            __kernel_ssize_t;
> -#endif
>  typedef int            __kernel_ptrdiff_t;
> +#endif
>  typedef long           __kernel_time_t;
>  typedef long           __kernel_suseconds_t;
>  typedef long           __kernel_clock_t;
> --
> 2.35.3
>
