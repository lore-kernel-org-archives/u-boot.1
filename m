Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499E8E8FDD8
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 13:45:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE3E883B86;
	Sat, 27 Dec 2025 14:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Uwy60Ah0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A37BA83B72; Sat, 27 Dec 2025 14:45:29 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9427A83B85
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 14:45:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so1749048066b.2
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 05:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766843127; x=1767447927; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vk8VPjiw5yGt49IENtPApCGQ4ifHxd4Sj1Y9H3DVUwA=;
 b=Uwy60Ah0tTpUxyW/DPtb+9IYUlXCExuGN3XW+iSrPd9fkzDyHijqsk2vAdjURT9PKS
 EILSp3Qtg6d8AuYeMWo6XMOanVrDkXWY4H30LOV+FsOiIZhh318fWXodFUplPfm7hluN
 wckHPuQFrsXRasTJtws/bPs+GZz++MEgq5Kng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766843127; x=1767447927;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vk8VPjiw5yGt49IENtPApCGQ4ifHxd4Sj1Y9H3DVUwA=;
 b=wLpGjOKBKB4YWA0A05tjSffWlockdntNkNf83MOZvKpnNNjM3BS6lO+hCDP6iA4auP
 WlhgCXjURPpEHwvbQzVuHYyzoXt+13rLUsOlqqFjdpy6FqktbnrVsdH/4jY+Btz5LJ6F
 aZnZeJni5DdA0C+tjbeY2h+VUZ3TkLtZEMGiaeu1RBRJIYHYg/riBv+I3+PjV27UELkT
 TZw7vHz3vxc0DbryPEgFgpoXrigPUwyTGGVn0494CuRM9eL8oDV/XLpxh9bjtjRHd59H
 REo3cO6CUssNWNfHVCgUkxWORrLwZXXt6uLshATsUJ9QJKJlShSE8cflzMgw//P+GX8G
 oyMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtNu0R9YTFe5B8QHDpnsTGQAahc/4p9Pb8mU+LBD+fB+SsHzMnYN2eomUaBNSZJGuF/dSV0wc=@lists.denx.de
X-Gm-Message-State: AOJu0YxG4BuKDjzZgVHca5mgLI+eTJ6Y0LVBHQKeHHlqjy1C8Q7kn4zT
 sJWsMPFFr/0teFSKPhFkGHpwXxNGohEfiJdQXl/HguFc2XLVaOLwSknLCaN43MfuuggqZ//PRxU
 HN7ObibZhimEZKf6mdEECCIo2EkRIL0e8tXf8OwzK/KuiA8yDHcY=
X-Gm-Gg: AY/fxX5rRxGjbgl9C5+GR5EXYlUxyDkvTSPN8PR2nNg2/GZxOHAljskhip7OwepaAXj
 cdKWRedlVL8VPIdkzmPZlUz9E6Igkp7ZTD4YEUrNwEhn6fdVN8uKkHwdsdqfF/WUxQ4UIhhiLQq
 RcS8wdEOm+68En+s/I6FmxpUh86jaFfCUbsP3tsMMS6F5Op4sJOS+uGviMBMuyOQ91pdR6DfgxV
 dsxSeQ8RPFN+j3Sl3SfNIedFsjx3dWHTmMSZBALRbHWnfh0fq7vbr2G327s4A5mhlWogQ==
X-Google-Smtp-Source: AGHT+IGOlhp18ydyr2qqdwKsGmcZ7joqCedhDQ7zBWcTHg3GzZM3+LnEIJiED2fAJntl+y8DZLq7guLZa8HQXcLuo8o=
X-Received: by 2002:a17:906:ee8e:b0:b83:2c51:bc36 with SMTP id
 a640c23a62f3a-b832c520299mr696232066b.3.1766843127077; Sat, 27 Dec 2025
 05:45:27 -0800 (PST)
MIME-Version: 1.0
References: <20251221015859.738112-1-heinrich.schuchardt@canonical.com>
 <20251221015859.738112-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251221015859.738112-5-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 27 Dec 2025 06:45:07 -0700
X-Gm-Features: AQt7F2q8WIcaYrWAOO_pfc6WSQI3pzBvUcovOuMbXJQLIxMWPVfijMYKXdKHm88
Message-ID: <CAFLszThtgJNbX5JHRDNvani4-nU_H5iOJYhC_JLbhLktBgkdnA@mail.gmail.com>
Subject: Re: [RFC 4/8] trace: increase TRACE_CALL_DEPTH_LIMIT
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Yao Zi <me@ziyao.cc>, 
 Raymond Mao <raymondmaoca@gmail.com>, Sean Edmond <seanedmond@microsoft.com>, 
 Heiko Schocher <hs@nabladev.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sat, 20 Dec 2025 at 18:59, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> test/py/tests/test_trace.py expects a recorded call depth in excess of 30.
> bootefi hello has a call depth of 42.
> efi_selftest_block_device.c reaches 56.
>
> Let's increase the default for TRACE_CALL_DEPTH_LIMIT to 100.

We can do this, but it will explode the size of the trace buffer. Do
you know what the function call stack looks like in this case?

>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/Kconfig                 | 2 +-
>  test/py/tests/test_trace.py | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index fe0b878a206..3f175fde7b1 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -415,7 +415,7 @@ config TRACE_BUFFER_SIZE
>  config TRACE_CALL_DEPTH_LIMIT
>         int "Trace call depth limit"
>         depends on TRACE
> -       default 15
> +       default 100
>         help
>           Sets the maximum call depth up to which function calls are recorded.
>
> diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
> index 52d6ec6e5d2..7f897e4c366 100644
> --- a/test/py/tests/test_trace.py
> +++ b/test/py/tests/test_trace.py
> @@ -49,7 +49,7 @@ def collect_trace(ubman):
>      assert int(vals['maximum observed call depth']) > 30
>      assert (vals['call depth limit'] ==
>              ubman.config.buildconfig.get('config_trace_call_depth_limit'))
> -    assert int(vals['calls not traced due to depth']) > 100000
> +    # 'calls not traced due to depth' depends on configuration. Don't check it.
>
>      out = ubman.run_command('bootstage report')
>      # Accumulated time:
> --
> 2.51.0
>

Regards,
Simon
