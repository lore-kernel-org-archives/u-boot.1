Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702F6E8FDD8
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 14:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2A0D83BC9;
	Sat, 27 Dec 2025 15:52:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QDwSLPH3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ADBE83BF1; Sat, 27 Dec 2025 15:52:47 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A8E383B82
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 15:52:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b728a43e410so1477881766b.1
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 06:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766847164; x=1767451964; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FbemfJLQWFzE+uKlEWHZbWlcpZHgeaORmxrtitndMsM=;
 b=QDwSLPH3Da+MJCHLjM3VSWIxTfH2UmuFoQ8tH36/ETtSOee59gbc22a7WgW82239wp
 9mJ7VPUGVCu7L0+fnzD+ndUHzpZTqbKInaKAT7sxU0ShvwROsHzND4hlt2uI+74QO7wb
 KBSmAeEYTQhXJL6d597Xmf1wjltsBHTY/2Q5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766847164; x=1767451964;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FbemfJLQWFzE+uKlEWHZbWlcpZHgeaORmxrtitndMsM=;
 b=Jv5mEt1pSAKZ970IExF01as8htSZrWPR3w/9vqOUE8Do14YAag7cURbQp+qRp3i1yG
 7eBSsBAQM0zjnKzZkGS9bmWRkGkK2+qC4rb85SVmxmIufBAxT5u+SzxmuKf/0FH2Y8XF
 ZNuoa2BdoAiIM1x/fiFnuFGNxrR8b2EN2Ob4804lWCUc4utQFrjnE4mPSlOlC5jBniYE
 HAK3MYYB4fBQ4XGDs0mqRBEGROkJ2wyWE7q5dXfaEDtrIZBXeLECp2u26oLlVsWMHBG5
 yX5gEPcA10gwSLQUpJEwDNmBDxnbuywUnaAxpJfw7cihoHr6xqtMog4xqGgu8dNEe89/
 eVrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH6aLVchq/cpBPl6mHJxHLGzSq3xfJXMK/Bk4JmEwsGMtrbift0mYhdq9GDDmKWhFw3L2Xdfc=@lists.denx.de
X-Gm-Message-State: AOJu0YzZ4XQZxIURUAA87oVlVutgnVdnM50yeDb1Bxk6pInvFp8dKWmP
 Y7AKP2jcQeywANvob1+LwmlHyjJSNmUhprl7Fo4Ng3qz1MbYIkeQZNmwPKNi4nwumcyioTaoy1M
 2nIVvTUdCOpaBj9EJghQTdHCCVuXqzpp6/WsAT6ij
X-Gm-Gg: AY/fxX7IQTLGL6rWz8SD8oXW66d5MCqaB/4IiblKnVeMIYFpXjy/Jddl4pdd7Ksmwtz
 8sq9sr4y8NyJcFaxEm5ZSUPZsCXDNz2QYM11IQgY3f3zKM1FUrG23MySacPDNQoqcbPOl9OIgT9
 zPLx2z0ir5VnSl9YKYt33Dy6gtYozwF9RPoXV4MlMxJfHMKeGfAcdAoHdi2wCXVt8v+COLz5CxL
 cqLT+qogzxAacH6UjCGrbSJgZwXqKBhVjtahQ9hiDe0oKYKw3+x2cfMQQ8IgnnIoJg+lDor0LR8
 NP62
X-Google-Smtp-Source: AGHT+IEWTvF6DcGYKcYrY9VMcREs2N3vYqvNr70cUdw8NrJxecv1+BFmUKswtGn5UXtjP1kQSD7k8agwzbDz5idFbno=
X-Received: by 2002:a17:907:a09:b0:b83:3294:af62 with SMTP id
 a640c23a62f3a-b8332950f5dmr705401866b.64.1766847164523; Sat, 27 Dec 2025
 06:52:44 -0800 (PST)
MIME-Version: 1.0
References: <20251217-a-few-test-py-improvements-v2-0-e1f91e3bf551@baylibre.com>
 <20251217-a-few-test-py-improvements-v2-1-e1f91e3bf551@baylibre.com>
In-Reply-To: <20251217-a-few-test-py-improvements-v2-1-e1f91e3bf551@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 27 Dec 2025 07:52:31 -0700
X-Gm-Features: AQt7F2qQtXBl9-Z3UDPs0F9CulPBwsg3pPr9MYTrf_5Kg1gCWy1yVTE5EoU1jc0
Message-ID: <CAFLszThobMWaKv5pP=kr_9nzWWKaF2mLjn-swEDQ_0aFDxazGQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] test.py: check ubconfig exists before using it
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
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

Hi David,

On Wed, 17 Dec 2025 at 11:43, David Lechner <dlechner@baylibre.com> wrote:
>
> Set ubconfig to None and add a check in the show_timings() function of
> test/py/test.py to ensure that the global ubconfig variable was actually
> initialized before access attributes.
>
> If tests fail early, e.g. because --build failed, ubconfig may not have
> been initialized yet and results in an exception in an atexit handler.
> Adding this check avoids unnecessary noise in the output.
>
>     Exception ignored in atexit callback: <function cleanup at 0x7de475ea6b60>
>     Traceback (most recent call last):
>     File "u-boot/test/py/conftest.py", line 669, in cleanup
>         show_timings()
>     File "u-boot/test/py/conftest.py", line 616, in show_timings
>         if ubconfig.timing:
>         ^^^^^^^^
>     NameError: name 'ubconfig' is not defined
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> v2 changes:
> - Set to None and check for not None instead of using 'in globals()'
> ---
>  test/py/conftest.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/test/py/conftest.py b/test/py/conftest.py
> index 8ce680a92a0..5689fcd0349 100644
> --- a/test/py/conftest.py
> +++ b/test/py/conftest.py
> @@ -28,9 +28,10 @@ import sys
>  from spawn import BootFail, Timeout, Unexpected, handle_exception
>  import time
>
> -# Globals: The HTML log file, and the top-level fixture
> +# Globals: The HTML log file, the top-level fixture and the config container
>  log = None
>  ubman_fix = None
> +ubconfig = None
>
>  TEST_PY_DIR = os.path.dirname(os.path.abspath(__file__))
>
> @@ -613,7 +614,7 @@ def show_timings():
>          if too_long:
>              show_bar(f'>{get_time_delta(max_dur)}', too_long_msecs, too_long)
>          log.info(buf.getvalue())
> -    if ubconfig.timing:
> +    if ubconfig is not None and ubconfig.timing:

if ubconfig and ubconfig.timing

>          print(buf.getvalue(), end='')
>
>
>
> --
> 2.43.0
>

Regards,
SImon
