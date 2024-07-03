Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F75AC31D97
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 09:34:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BAAF887CA;
	Wed,  3 Jul 2024 11:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wUx3Bxuy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9FA08840E; Wed,  3 Jul 2024 11:34:14 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B32F887D5
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 11:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fab50496f0so31167515ad.2
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 02:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719999249; x=1720604049; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S4S6ZAoxWgWggDy2T3xtk2KVb/Dlj/bVC7CMysjGQvs=;
 b=wUx3Bxuyl0ua8mPkjTCxR+o2SpSXXSj0t0psP0hGgS6wpCuo61dtjX2xrFundN1lgk
 JccrFEu1QYgu6gc/ItdZXjDGtOw/OmW6HXBHTVpfQDGe+NeHpbqWH+E8cCcuoWUNEKPo
 tfSSJS7423q6k4xxar+mfH0PMhqmnNH7EMG+QL4+Ibkl8zT7uSre5LgSagh85g4USH0j
 dlERtBdLo6RCsy03mtQ420MBaK5kj4x8CdsTIopW6lH3khB4ZmrXVurfgHTQaCHMl8vM
 Qf+UhYxMif09OruAhfck2gV5CTjxlOWeDOw06BePb5f7abVI+GMMTNIiZEYaKIvuQX+W
 shrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719999249; x=1720604049;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S4S6ZAoxWgWggDy2T3xtk2KVb/Dlj/bVC7CMysjGQvs=;
 b=CBVT4VDOVb/dnBT6rcuxkxCxGpYaT7aY2RX0jcR1yXxozG05fr4TxlsscB6p5l/sDp
 E+UQYw9js8cqUt/2gzIxo1dyZiA5gx/wapjPsfOBwCk9ACLTQVN/dz8FG6ibTtvW83Pq
 aI2/gcFn0FyyiLGPefaZT8NM2xuzMoMk4yfmy0WUQ88Ju5Z7Yfr6DCI46I1Q5E3lt465
 JkD1wPhT4eFQ6zgZv1P0OYn8k+cJF7Y03w2xXwJOtvnfzWypRLOdJB9qqLNJRJdz2Cuk
 TXZ6gZz9P+Kj+8B4XK1GK+CnJd72idDEIu386HQexA49yA9fmJx7zhQ1D0pIIIrRm2vx
 7ULw==
X-Gm-Message-State: AOJu0YzN2mBsTqPE5lF5huBLNxiTC5PhJZwTFqtNtRas9GmWihGWvodQ
 u2EmhKlEoEVQ/b8aJNa6Oho5pKZ5PRn27CCBk0BKE3JISOZPqjVWTOcfEiVQXeYQnw2v3anq9Wb
 NgIrdmqcQz3QMJfzuwea7tSPvJpRh2ZvtrISeaw==
X-Google-Smtp-Source: AGHT+IG0IX1jQcVYWQRB/ryQi2ePvgUYqb7nEJUMP8C61yvOf5+bZNTfSZpFdHWkUziKNxTVH0uII6xzmC1m6inKWFw=
X-Received: by 2002:a17:90a:b013:b0:2c8:85c:750b with SMTP id
 98e67ed59e1d1-2c93d79aba2mr8497268a91.34.1719999248576; Wed, 03 Jul 2024
 02:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-17-raymond.mao@linaro.org>
In-Reply-To: <20240702182325.2904421-17-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 3 Jul 2024 12:33:32 +0300
Message-ID: <CAC_iWj+tSeHVwmFtKvfyJjG0uvOjH0-G9MJtovBTA-nePw5VSQ@mail.gmail.com>
Subject: Re: [PATCH v4 16/29] pkcs7: move common functions to PKCS7 helper
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
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

Hi Raymond

On Tue, 2 Jul 2024 at 21:30, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Move pkcs7_get_content_data as a helper function that can be
> shared by legacy crypto lib and MbedTLS implementation.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v4
> - Initial patch.
>
>  lib/crypto/Makefile       |  1 +
>  lib/crypto/pkcs7_helper.c | 40 +++++++++++++++++++++++++++++++++++++++
>  lib/crypto/pkcs7_parser.c | 28 ---------------------------
>  3 files changed, 41 insertions(+), 28 deletions(-)
>  create mode 100644 lib/crypto/pkcs7_helper.c
>
> diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
> index 946cc3a7b59..16059088f26 100644
> --- a/lib/crypto/Makefile
> +++ b/lib/crypto/Makefile
> @@ -53,6 +53,7 @@ $(obj)/x509_akid.asn1.o: $(obj)/x509_akid.asn1.c $(obj)/x509_akid.asn1.h
>  obj-$(CONFIG_$(SPL_)PKCS7_MESSAGE_PARSER) += pkcs7_message.o
>  pkcs7_message-y := \
>         pkcs7.asn1.o \
> +       pkcs7_helper.o \
>         pkcs7_parser.o
>  obj-$(CONFIG_$(SPL_)PKCS7_VERIFY) += pkcs7_verify.o
>
> diff --git a/lib/crypto/pkcs7_helper.c b/lib/crypto/pkcs7_helper.c
> new file mode 100644
> index 00000000000..6c8dcd1a935
> --- /dev/null
> +++ b/lib/crypto/pkcs7_helper.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * PKCS7 helper functions
> + *
> + * Copyright (c) 2012 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + *
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>

Copyright and authorship is added if you add a significant portion of
the file. You are moving a function around here, so just keep the
original author & copyright

> + */
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <crypto/pkcs7_parser.h>
> +
> +/**
> + * pkcs7_get_content_data - Get access to the PKCS#7 content
> + * @pkcs7: The preparsed PKCS#7 message to access
> + * @_data: Place to return a pointer to the data
> + * @_data_len: Place to return the data length
> + * @_headerlen: Size of ASN.1 header not included in _data
> + *
> + * Get access to the data content of the PKCS#7 message.  The size of the
> + * header of the ASN.1 object that contains it is also provided and can be used
> + * to adjust *_data and *_data_len to get the entire object.
> + *
> + * Returns -ENODATA if the data object was missing from the message.
> + */
> +int pkcs7_get_content_data(const struct pkcs7_message *pkcs7,
> +                          const void **_data, size_t *_data_len,
> +                          size_t *_headerlen)
> +{
> +       if (!pkcs7->data)
> +               return -ENODATA;
> +
> +       *_data = pkcs7->data;
> +       *_data_len = pkcs7->data_len;
> +       if (_headerlen)
> +               *_headerlen = pkcs7->data_hdrlen;
> +       return 0;
> +}
> diff --git a/lib/crypto/pkcs7_parser.c b/lib/crypto/pkcs7_parser.c
> index d5efa828d6a..c849dc0d92d 100644
> --- a/lib/crypto/pkcs7_parser.c
> +++ b/lib/crypto/pkcs7_parser.c
> @@ -182,34 +182,6 @@ out_no_ctx:
>  }
>  EXPORT_SYMBOL_GPL(pkcs7_parse_message);
>
> -/**
> - * pkcs7_get_content_data - Get access to the PKCS#7 content
> - * @pkcs7: The preparsed PKCS#7 message to access
> - * @_data: Place to return a pointer to the data
> - * @_data_len: Place to return the data length
> - * @_headerlen: Size of ASN.1 header not included in _data
> - *
> - * Get access to the data content of the PKCS#7 message.  The size of the
> - * header of the ASN.1 object that contains it is also provided and can be used
> - * to adjust *_data and *_data_len to get the entire object.
> - *
> - * Returns -ENODATA if the data object was missing from the message.
> - */
> -int pkcs7_get_content_data(const struct pkcs7_message *pkcs7,
> -                          const void **_data, size_t *_data_len,
> -                          size_t *_headerlen)
> -{
> -       if (!pkcs7->data)
> -               return -ENODATA;
> -
> -       *_data = pkcs7->data;
> -       *_data_len = pkcs7->data_len;
> -       if (_headerlen)
> -               *_headerlen = pkcs7->data_hdrlen;
> -       return 0;
> -}
> -EXPORT_SYMBOL_GPL(pkcs7_get_content_data);
> -
>  /*
>   * Note an OID when we find one for later processing when we know how
>   * to interpret it.
> --
> 2.25.1
>

with the above fixed
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
