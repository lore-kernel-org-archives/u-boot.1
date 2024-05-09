Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC0EC25B74
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 08:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E3DA88470;
	Thu,  9 May 2024 10:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Se32P+SE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7C648847B; Thu,  9 May 2024 10:26:04 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92A4F8844F
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 10:26:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a5a1054cf61so137456966b.1
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 01:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715243162; x=1715847962; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r9FAhQxltsaDpwGLmzx53npDLTZUJDesjPtSEOwxgKI=;
 b=Se32P+SEryQtUmM7YryiptsjxT+KkXJindTKMWOF2VZlyYj/SBQqeZaBrJfU6VUqHt
 ndc4YR5Wbg8c6198j7VVKYFD/6m3IkwZCKFZeQ+ANuHfMbD9f4KVqCi/7Gvju+d436NU
 5sQpVQ4uixdJj/GNCHMyBh3m1budVPibHUOLcUqKLEfgQSIxDlS0lAV2Pp7bgx6lj5Ev
 N3lT496RFzpz9sCyhsCWMq9mRI9whPwm3TmERO3kO1tu3y9GrmQNVAVPjzC5Z5VQFI+s
 JK0EZZuepVD62fPkwbct7XbVfNRGAGV5oTnCvz3J0Oyt0CRhEOQ6PHF/OyG4Kd0F90DK
 GY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715243162; x=1715847962;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r9FAhQxltsaDpwGLmzx53npDLTZUJDesjPtSEOwxgKI=;
 b=SXo58U2KxNIEO2n51xbSPfDaNhYAQp8ONnWblxSTe7P84wJPVmjEE505zQOb1voYge
 2vdOp3pspxXKuwl70RyNSV/0dIUUEKq90QF0cnnwO1XBpqcKVsxvOCIXXK1evAe62mPu
 mAq+RY3Om4rsEWO29GS8YEwSVc97lFuONQgabYToptGSgtu6J+qDBQwERWCxRshfmPik
 9OKl2QtZl/X8Hwef602auljGGcgCQUqm+SlLWa3q/Dh08kQBOvTCXzhvPX79SWFGWd9H
 txhRZ5RGC87qvj8CgR6IlbASaQCVzddhiSosrrUY2tku1QqfC13JUvakiFKikUPK3wB5
 kC7A==
X-Gm-Message-State: AOJu0Yzrlp+bg2p/UPP0PMIGZp/OEaGGjZDw0h3nCrWGw4M07Yq88f42
 eaQ/De4sZoBW2oQQ50zF7zxevqTlPId86GjTfXkVg8DmL1xjlWzGs8aPV5IY0tanwWW85zZsrAC
 t2HfsWtUkDZ8jgibaKk2CgOaO9vB0lmpT/8GAwj4kEnSDN/IRmbkr9A==
X-Google-Smtp-Source: AGHT+IGgoNt2EJltdq85emRI8MTN5ZIRBbpcIy1UPkgTHLLYGmzeSEC3It1oUZL+e4ATNCHIFJIQSiweHJFuJhWxxhA=
X-Received: by 2002:a17:906:114b:b0:a59:d527:4339 with SMTP id
 a640c23a62f3a-a59fb6dd241mr427069066b.0.1715243161998; Thu, 09 May 2024
 01:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-24-raymond.mao@linaro.org>
In-Reply-To: <20240507175132.1456512-24-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 9 May 2024 11:25:25 +0300
Message-ID: <CAC_iWjK4Z9D9gpnFJ=iX0YAw4tittwbeqTo=SLhcA4Jwztr_XQ@mail.gmail.com>
Subject: Re: [PATCH v2 23/28] lib/crypto: Adapt mscode_parser to MbedTLS
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Andrew Davis <afd@ti.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Sergei Antonov <saproj@gmail.com>, 
 Ilya Lukin <4.shket@gmail.com>, Bin Meng <bmeng@tinylab.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Alexander Gendin <agendin@matrox.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Eddie James <eajames@linux.ibm.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Tue, 7 May 2024 at 21:01, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Adapt mscode_parser to build with MbedTLS

Try to be precise in the description e.g

"Previous patches enable alternative SSL libraries and use mbedTLS
directly. Adjust the header and makefiles accordingly"

Thanks
/Ilias
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Move the porting layer to MbedTLS dir.
>
>  include/crypto/mscode.h | 4 ++++
>  lib/crypto/Makefile     | 2 ++
>  2 files changed, 6 insertions(+)
>
> diff --git a/include/crypto/mscode.h b/include/crypto/mscode.h
> index 551058b96e6..c214fc87e40 100644
> --- a/include/crypto/mscode.h
> +++ b/include/crypto/mscode.h
> @@ -9,6 +9,10 @@
>  #ifndef __UBOOT__
>  #include <crypto/hash_info.h>
>  #endif
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
> +#include <external/mbedtls/include/mbedtls/asn1.h>
> +#include <external/mbedtls/include/mbedtls/oid.h>
> +#endif
>
>  struct pefile_context {
>  #ifndef __UBOOT__
> diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
> index c3fe9c9d2c0..e3232019df2 100644
> --- a/lib/crypto/Makefile
> +++ b/lib/crypto/Makefile
> @@ -62,6 +62,7 @@ $(obj)/pkcs7.asn1.o: $(obj)/pkcs7.asn1.c $(obj)/pkcs7.asn1.h
>  endif
>  obj-$(CONFIG_$(SPL_)PKCS7_VERIFY) += pkcs7_verify.o
>
> +ifneq ($(CONFIG_MBEDTLS_LIB_X509), y)
>  #
>  # Signed PE binary-wrapped key handling
>  #
> @@ -73,3 +74,4 @@ mscode-y := \
>
>  $(obj)/mscode_parser.o: $(obj)/mscode.asn1.h $(obj)/mscode.asn1.h
>  $(obj)/mscode.asn1.o: $(obj)/mscode.asn1.c $(obj)/mscode.asn1.h
> +endif
> --
> 2.25.1
>

With the above fixed
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
