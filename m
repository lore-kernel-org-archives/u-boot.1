Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936C9C02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 15:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03642800B3;
	Tue,  4 Feb 2025 16:57:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u/8opFwO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7701D801DE; Tue,  4 Feb 2025 16:57:50 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A93580040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 16:57:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e5addc7b249so3628297276.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 07:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738684667; x=1739289467; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0nZtiBGwQfypFM7n14K61PDcaCPozmiukh6mVhjDfUg=;
 b=u/8opFwOUyme9fYDfeIHHPOGQvxpJswzZ/T46HiLibYJQYt/IeTwJKotjAUtdtNwuj
 30w15beAhA/yjY1UFr5nvhrNuWE/vBN0AAAc3UpwS0vodbiIhYCw9g/UMwTOUqPhW6R8
 hFRzitsxug5Fxe/4iuKldwYHQ6QVxW6QA79IqHgFox6USUX8rO/cGTUCe+Xc1fQpW9DX
 x759tyw90uiX7wid0pG0RIdES4+5IHpZ1V1kFYn0kJeiEyCzR4j5QDzh+0CKJB9UjsTh
 x194rPW/PKMEapqVPzODrfWSOlUI5YBD3G+eiqpwoNKeywDhjiF0tF9D56sFbEqNAlC9
 QxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738684667; x=1739289467;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0nZtiBGwQfypFM7n14K61PDcaCPozmiukh6mVhjDfUg=;
 b=ZpANeCh1UOwraamoFEQB0n4iuhfV0HzF6IQwNO+r/MynfjcnLA2ScWTz8PXZjZTiG8
 CWo+Y/oT99TXC7h/9eSoA8F6rfcC0zI0R17u5dgncbaLz66qTLf26C4xysLEtgY165NK
 d0rxsLaiu7s+H2YoKmUNqtOIgtCJjtKSlrlH/KVWYGhGt/t97MScdUM/flx0r/QQnAxY
 ep2f/8po8knPGyZkx6a/Ebwji5HJt6tFLgfh38BOJCjwYGvNrm8ajw2IfBB/iqTVFCic
 btn9UOf28Ya5VHLEtmM5a4lWJVDMXnrWTmJeRtalb8cAX5c80w6I1QP3GJtwmVmNp44y
 S/MQ==
X-Gm-Message-State: AOJu0YzT4AetsOucKfIxyYl1oMqzfo6PIhS46aqErvO6e0z4KAfC/lsv
 Z6fjiZ1DHQ0Pe/JanQNvnNbNt5mRgKR2eIT4+cz+aIHz6wBjNg2rAMoyqIEPFtw5/fveEKyUZsm
 SRKv0k0P7zs14gvfMzUFge/q8lYtHX9oo/miWpw==
X-Gm-Gg: ASbGncswBy9YMSwelvEqwYK+3VO3cQeBdeuwEktEH6NtYv5olxGaNph3prWHXACWvzQ
 1DrXpAH1DoPSC4GQ0Ax92VcsSI7C+UDU0rNplxrruFzvdnwUASg0Z6U2OwEjUGm7Nqy1JLTqm
X-Google-Smtp-Source: AGHT+IG3RwTl0zVYEVGv5ywySznUdGpqDCgUixVWcl+8E92GVjqUwefjJLgjhMlpBFfpwi9hZtmmVCVzogu3ki1/LM8=
X-Received: by 2002:a05:6902:1610:b0:e5b:2363:f8b7 with SMTP id
 3f1490d57ef6-e5b2363f95fmr141751276.16.1738684665517; Tue, 04 Feb 2025
 07:57:45 -0800 (PST)
MIME-Version: 1.0
References: <20250204154707.3054802-1-jerome.forissier@linaro.org>
In-Reply-To: <20250204154707.3054802-1-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 4 Feb 2025 17:57:09 +0200
X-Gm-Features: AWEUYZlodVN3g5qgAm7DseRFKPUNPXgpgCuo0Quyz33ydm8RL-sC2azsg_n0F4M
Message-ID: <CAC_iWjKy54+pbqrU2+7P=ULQ8C+c63mtZe4-S9CJ8u6T+jpzWw@mail.gmail.com>
Subject: Re: [PATCH] net: Kconfig: depend on DM_RNG for WGET_HTTPS
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>, 
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Adriano Cordova <adrianox@gmail.com>
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

Hi Jerome,

Thanks for taking care of this

On Tue, 4 Feb 2025 at 17:48, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> net/lwip/wget.c/mbedtls_hardware_poll() is calling dm_rng_read() but
> dependency is not recorded anywhere that's why depend on DM_RNG
> when WGET_HTTPS is used.
>
> Suggested-by: Michal Simek <michal.simek@amd.com>
> Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  cmd/Kconfig     |  1 +
>  net/lwip/wget.c | 10 +++++++---
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index e62817bd977..e3fbb7538ee 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2154,6 +2154,7 @@ config WGET_HTTPS
>         depends on CMD_WGET
>         depends on PROT_TCP_LWIP
>         depends on MBEDTLS_LIB
> +       depends on DM_RNG
>         select SHA256
>         select RSA
>         select ASYMMETRIC_KEY_TYPE
> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
> index b76f6c0f1d9..d9b639ce60e 100644
> --- a/net/lwip/wget.c
> +++ b/net/lwip/wget.c
> @@ -433,10 +433,14 @@ bool wget_validate_uri(char *uri)
>
>         if (!strncmp(uri, "http://", strlen("http://"))) {
>                 prefix_len = strlen("http://");
> -       } else if (!strncmp(uri, "https://", strlen("https://"))) {
> -               prefix_len = strlen("https://");
> +       } else if (CONFIG_IS_ENABLED(WGET_HTTPS)) {
> +               if (!strncmp(uri, "https://", strlen("https://"))) {
> +                       prefix_len = strlen("https://");
> +               } else {
> +                       log_err("only http(s):// is supported\n");

return false; here as well

> +               }
>         } else {
> -               log_err("only http(s):// is supported\n");
> +               log_err("only http:// is supported\n");
>                 return false;
>         }
>
> --
> 2.43.0
>
Other than that, this is exactly what I had in mind
Thanks
/Ilias
