Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1598FD0EE18
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 22:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A4AF84142;
	Tue, 25 Nov 2025 23:15:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hPMhgIt5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7390A84144; Tue, 25 Nov 2025 23:15:15 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76322840E6
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 23:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b736cd741c1so1062913466b.0
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 14:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1764108913; x=1764713713; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qxJGch4t6af1d3EvcbUy9PECy9xeNOtFzfDjq603c48=;
 b=hPMhgIt5b0nNerActSdnl3YQw8TSRhB61BvbTH2os/BQFZuOpxhebJBRP5FChRknsQ
 QHYfDEjgCeTNInHA1vqcZS8B/gPrNLPlmIQWRWF1fQku8UkgoEQ3CFogjpMv6LB2bJqF
 hL7wp7MyX2t1rQUYKBCWY1LiU5kLwkqEo1Gh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764108913; x=1764713713;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qxJGch4t6af1d3EvcbUy9PECy9xeNOtFzfDjq603c48=;
 b=KC7AqBIjzGLTai9Wa8nGcONvoPx5T+SkSUsuMTWNhDDt/FaBJv/Im/p2QZiDi41EoQ
 k4bseWqrKBV7mcC0TyTR0AMVy3XQ1CS7ypfAqDRjoFZ0DxauNyltmPwHvgXDFfQlk9U+
 SedILcvWx7NcxVZHsN9tZ5lLWrQp6iqCSBziYEidIn8BOkMCfmSNtRoVCKhRY9OXRV8A
 5M0vMXdEV8573WRkNscJm65rExMwDU7bEjyFhX+eKMlorQbMkXN7J0bPyP+G0YjvUFN9
 o9O7lbfUeJ5zzRD6uW1xp5qaRtgfcv/vSNaKS/nQNh1kCjfL9J8PAT7Wp7cvIZxpoFF5
 AwiQ==
X-Gm-Message-State: AOJu0YzS0vjkTvGZKqhtSKiDgIiIaYr0qI/MqAy/4Si4rkl2iGjiKeaJ
 X16LpOLWu7Uj+eCurGPk9weMpiw/pXFGfLLnN655yVfvUZvPNAX8LnjAzZSIGn8s2zFeuO+1pgS
 unLuudZXkyubcKbktzY26UBtFOhhCLKEHRKLqTlvs
X-Gm-Gg: ASbGncuXSToh+lL+wWbDZl36m9PehqHGzlIqaqnLVEf1UWxk07oUvHSJ2N8EOnLVIYC
 utrQhp6U2SJ7qGyT/JS8oqEX+F3aow46qZyRJhO/Qzbk0jFO7gJQHbmDhlWvHFFw7CETYwk8j7V
 KicC5mYGwLx08b4C74EoqRhFKNulh3lMhKYlIWuccLfGvCuO7ngPCw8LBXeXNgqHZbmGRDqj37/
 hzgfKtUC8mkwQksIdc/ZrR8A8pFvOJZ2tVKYliY/xfd57xLM3Gl0jKt5OBJYvxMNC83Mw==
X-Google-Smtp-Source: AGHT+IGVnk3IiEl4io0naacJ37dkk3dRRyevVELVmyRrNgGYGQGyw8gsEj+ICtdwlxtV87kOMw7NW5WKlT33Q1l8hF8=
X-Received: by 2002:a17:906:1345:b0:b76:3c91:68d with SMTP id
 a640c23a62f3a-b7671695533mr1218236266b.33.1764108912840; Tue, 25 Nov 2025
 14:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20251121-a-few-test-py-improvements-v1-0-bacb4148fb0d@baylibre.com>
 <20251121-a-few-test-py-improvements-v1-2-bacb4148fb0d@baylibre.com>
In-Reply-To: <20251121-a-few-test-py-improvements-v1-2-bacb4148fb0d@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Nov 2025 15:14:57 -0700
X-Gm-Features: AWmQ_blMJooHyB_lwMSqPzhQLwkWkfSr84KcTDsd_JFdXS5F22vd_1cQ6-cXvNk
Message-ID: <CAFLszTjm94_iH5srp44mTMDJ-vJSAJMtgisBs+E=fNWk++KP6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] test.py: check ubconfig exists before using it
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Fri, 21 Nov 2025 at 07:36, David Lechner <dlechner@baylibre.com> wrote:
>
> Add a check in the show_timings() function of test/py/test.py to ensure
> that the global `ubconfig` variable was actually created before trying
> use it.
>
> If tests fail early, e.g. because --build failed, ubconfig may not have
> been created yet and results in an exception in an atexit handler.
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
>  test/py/conftest.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test/py/conftest.py b/test/py/conftest.py
> index 8ce680a92a0c37f36489b0782921d6cf4078850d..f889e3d3ae26db3ae19f79e236a281471d4b6de9 100644
> --- a/test/py/conftest.py
> +++ b/test/py/conftest.py
> @@ -613,7 +613,7 @@ def show_timings():
>          if too_long:
>              show_bar(f'>{get_time_delta(max_dur)}', too_long_msecs, too_long)
>          log.info(buf.getvalue())
> -    if ubconfig.timing:
> +    if "ubconfig" in globals() and ubconfig.timing:
>          print(buf.getvalue(), end='')

Please put 'ubconfig = None' at the top of the file, then this can be:

     if ubconfig.timing:

Regards,
Simon
