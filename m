Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2B1CEDD90
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 13:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 709DE89208;
	Wed,  9 Oct 2024 15:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CWU88qqn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D94488FAF; Wed,  9 Oct 2024 11:19:55 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E232789184
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 11:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20b7259be6fso73043905ad.0
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 02:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728465590; x=1729070390; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A3l2fCGqfxiPd4jMbPenhN4M3S/ot+HcA6XUmwmz4PU=;
 b=CWU88qqneGTDpnjgscCsi7mjCnfsBvdflUz6SI8N7rDxf0dXQPYbOxrePI0xcGjB5z
 tFU4e5dKlwdKbETewbWIVast2nPgayE69vKhPx80oYVZJ9hktpUM6+4Q3h4mnSRXiPAO
 a4JsFXMx9KdxQ1uPCjmxRVXO0HEFLMNjZ6nSTJUkpUdaOb/tO+qZ6Ab6N4tuyJCssjJE
 CLlmMwOiKkATX12ZTC+ZfJILi/Rr7P7XcwuOaV6V/IG37qwTV7QZhYvdjJfOEYKTWo32
 GctlPQhR9B1iE6RyucIBSpR9g66xbWYtUkO6jEZZK3e3rQDcIAjP0Cy450fVAq95U20N
 oXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728465590; x=1729070390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A3l2fCGqfxiPd4jMbPenhN4M3S/ot+HcA6XUmwmz4PU=;
 b=uH2lXLy7ut9i//DF5NfycIDh+itPk+At8dPMJzfmx9gv/bMJnAPNIEuQWwQwlW07zA
 NhKdC1q9pRfN1Zj0bCE7tsUjYTllRIOQ8BRx1dLtFW8u4BOXeXPnuVJbEPyw7zQIXk8W
 WnJRiUn2DBZUM0+S4KRYSzJAqX1RK/no9K3uHgNT4kSmSqk0JBTgf4bc0e4BwF8yMrHj
 yHlrAFGud9XIy3Le7wyYSGOZzRzw1F2jrj+9QJmt42DTiqeh3L14eACuCL0jFw2TdOnX
 KqmgaEeYO419uANvq3BzMDiAO2rbzk7vH+7JpYJrKVo1d4BzWA2BVeAhEBYd8fNQASX+
 /cFw==
X-Gm-Message-State: AOJu0YyQGSl5lBLsRRjOgZjOJiceAeLA9nnUgDLr0mLHf7IUPjNf7r2Q
 DNqD6xMOWi+1NpGzZkTLtgwcxcW7rodKhyhk3ABfKQAQQuv2p+Rtj+hKdBb/RF2capjPgjCeyto
 GBvSWlDq48yNFJZXjvY5ngimxb+xtHeCJd0DbdA==
X-Google-Smtp-Source: AGHT+IF/dTlJBm2+8S8t/wulrcsxjwdvuBVNxYQaerlDsajpl6Gpxtwt2ASBb3eHbo5Yu9xiYPjcOXBRdt9shwJ2n1g=
X-Received: by 2002:a17:902:fc44:b0:205:68a4:b2d8 with SMTP id
 d9443c01a7336-20c636d7991mr27545745ad.11.1728465590418; Wed, 09 Oct 2024
 02:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
 <20241003215112.3103601-17-raymond.mao@linaro.org>
In-Reply-To: <20241003215112.3103601-17-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 9 Oct 2024 12:19:14 +0300
Message-ID: <CAC_iWj+vGgqQUStEScuXp4Fs1pqGtHjkYXC49h9wK4aRKfxjng@mail.gmail.com>
Subject: Re: [PATCH v8 16/27] lib/crypto: Adapt public_key header with MbedTLS
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Sean Anderson <seanga2@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Marek Vasut <marex@denx.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Kongyang Liu <seashell11234455@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 09 Oct 2024 15:13:35 +0200
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

On Fri, 4 Oct 2024 at 00:59, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Previous patch has introduced MbedTLS porting layer for public key,
> here to adjust the header and makefiles accordingly.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes in v2
> - Move the porting layer to MbedTLS dir.
> Changes in v3
> - Update commit message.
> Changes in v4
> - Control building legacy library via '_LEGACY' Kconfig.
> Changes in v5
> - Correct header file include directories.
> - Kconfig rename.
> Changes in v6
> - None.
> Changes in v7
> - None.
> Changes in v8
> - None
>
>  include/crypto/public_key.h  | 6 ++++++
>  lib/crypto/Makefile          | 5 ++---
>  lib/crypto/asymmetric_type.c | 2 +-
>  3 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
> index 3ba90fcc348..25cfb68adce 100644
> --- a/include/crypto/public_key.h
> +++ b/include/crypto/public_key.h
> @@ -12,6 +12,12 @@
>
>  #ifdef __UBOOT__
>  #include <linux/types.h>
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
> +#include <library/common.h>
> +#include <mbedtls/pk.h>
> +#include <mbedtls/x509_crt.h>
> +#include <mbedtls/md.h>
> +#endif
>  #else
>  #include <linux/keyctl.h>
>  #endif
> diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
> index 16059088f26..7e877214aa8 100644
> --- a/lib/crypto/Makefile
> +++ b/lib/crypto/Makefile
> @@ -7,9 +7,8 @@ obj-$(CONFIG_$(SPL_)ASYMMETRIC_KEY_TYPE) += asymmetric_keys.o
>
>  asymmetric_keys-y := asymmetric_type.o
>
> -obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += \
> -       public_key_helper.o \
> -       public_key.o
> +obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key_helper.o
> +obj-$(CONFIG_$(SPL_)ASYMMETRIC_PUBLIC_KEY_LEGACY) += public_key.o
>
>  #
>  # RSA public key parser
> diff --git a/lib/crypto/asymmetric_type.c b/lib/crypto/asymmetric_type.c
> index 24c2d15ef97..95b82cd8e84 100644
> --- a/lib/crypto/asymmetric_type.c
> +++ b/lib/crypto/asymmetric_type.c
> @@ -12,7 +12,6 @@
>  #include <keys/asymmetric-subtype.h>
>  #include <keys/asymmetric-parser.h>
>  #endif
> -#include <crypto/public_key.h>
>  #ifdef __UBOOT__
>  #include <linux/bug.h>
>  #include <linux/compat.h>
> @@ -26,6 +25,7 @@
>  #include <linux/slab.h>
>  #include <linux/ctype.h>
>  #endif
> +#include <crypto/public_key.h>
>  #ifdef __UBOOT__
>  #include <keys/asymmetric-type.h>
>  #else
> --
> 2.25.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
