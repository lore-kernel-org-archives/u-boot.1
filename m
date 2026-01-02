Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926F2FA372A
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 11:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2769E8422D;
	Fri,  2 Jan 2026 12:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zHx4ysLQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC7B48422F; Fri,  2 Jan 2026 12:08:04 +0100 (CET)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0830B84228
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 12:08:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64476c85854so10594071d50.0
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 03:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767352081; x=1767956881; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3qUsxWkMNw9GG9TWAvWP/vmc1RbWcuclPP4YVOM9zlg=;
 b=zHx4ysLQ4SopIaZ4Mia50sxFyFMjGjSg9tfWGI9q6yhRUaKhNleW0DYhzVb3ax5UMy
 HsceBg8yPZ6JUYKVCPdQZc6ZA07E3zThGekUtMXw+MoiJ0FnfyM+OGPKS8qjmN5WyWtW
 /AvsJDD+kDMPuP08UVpdoNrYa/S1+e8AdN27gerGGi5/VBh/TpXsWy2Dyc7CI6tVBGCs
 jjkGcOAXS3HSrPWBKJlVMslybmFITRhBtCGwmE70gZwIsAtrQaZeoaW/XoypxmS1/deu
 gjZmsjpf+AbcMwk9DyY9x+eerkE4uzn8eFM3ELj53ZTU6Au1ImuPp2j6R6LMoACjs8i9
 uNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767352081; x=1767956881;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3qUsxWkMNw9GG9TWAvWP/vmc1RbWcuclPP4YVOM9zlg=;
 b=qSMfVsdzG+bb5wptDxtCmgvOoZcNAvAOswZ6oWHN39i+lyxoY11PkxLgC+HUo+T03Y
 HWonr7gV3theE3F+Vuku7gXpsA8F+OMWWI/GYcIPcUBRNXAYHYg0yyhQoQ6EM0i7UYpP
 un6FAC7w/OzkVvPRdSgA6hp0xsXjLcOgabRqXMy4hHqcWZE9LuvhUGqMzkrBuJgcXMvM
 RUVD5XzJB95AIHwFEwAt+WrJoiPdsTgPnMTzor+vNqQMcjiPKlgFyP07o9kj7mmoftXm
 oHf8OOTZpweWmdCdWu62nD5FCAKwtLCz45yTIOiqCiA5nA/ItTiuvmPGBvPNHdKJcBV3
 GaYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJUXUUvtPuUmZ8LcIfeOUk8pk75KQJKzX2K/s+dSS0cVzaRMyXyhHMZz4W6O4yAwkIrSVhMgc=@lists.denx.de
X-Gm-Message-State: AOJu0YxPwV3kaLgKwVg9co0gr2rM5kvXdXRC8TMQadwKsQ8qBurDIKDe
 msCC169nd8EzSHAbS0t+eeVh3lEjQMZIevB0ov2J0dYWhPR6Fu7ShJSB+1biZdfN47B8wK/Z1L2
 EftBR0e0caj8nhqulSdaL++Z6uj/0H2x7HaG7m4x3Ww==
X-Gm-Gg: AY/fxX57YfVmkz3aTf9/PZjaP9rFT8z7QlKe4NdswWTmn4k8X5VeuxFSvKX5WNn/iRi
 zlxuIthZU1b7uAouo1RgNiX+aauTClfLGb+SWwlvNPTz1n6rogY9t99a06pP7DnAyq7M9aCbTFa
 cUNfGKI4ZtQqoIsfIa5fIRFgJanQ8IO95KDAB5DF2ob0rTKkXYztyZGcQghG5iYeIpt110h3cgH
 eRaJkkzJPTcuuemSIC/eWppGuIF/ALN94gKv0KsNru06wcbJtaD3StsY+i8KeTIERtGCSiGnN1x
 wNuXgx0WzYL/iKPnNcvBBXLzg71jgFBBk7O6mZRDitZzKyqIBpgFLCqIYZQBVB4sa6hrQ16RtLj
 jEo3nLzLcWe8ZCZCSlLs0dDWDvz/k+ccrOHSPEgkSSLtWNAM5+ztaAYYHrfhlJhsI9QmOTSiQsW
 W5X7Kat/rS142z97DMsk5iJreCPwKGXPwrFcHRyqxDA1vgEbnN3uYmW0S2GncFz8dfeClBAtQmu
 32z4L9Cv5QQ6+/vOp3SWY+B6IoWwhyDtyEqLbFKlkyjqxZs9Qk4AabxUbDexB7yksH7XuHJOwC4
 4WHjINbQ8zOEge9f7oK6AbCb/jKpL7t1vQSd36LqNUKNyKMICJlmI5Cy4LYXp2JJx0h/ZDFjzXZ
 5
X-Google-Smtp-Source: AGHT+IHcE8gqyWWynyMUQ3aLlNhFW2ftHsB/8HfWgPgIBOT9w7Sz6ZnOE944JsOK1FYLJT0EpTTRNq9uKLhorZCuiIo=
X-Received: by 2002:a05:690c:fd5:b0:78f:c1ce:edd1 with SMTP id
 00721157ae682-78fc1cf03bemr720544647b3.10.1767352080627; Fri, 02 Jan 2026
 03:08:00 -0800 (PST)
MIME-Version: 1.0
References: <20251221015859.738112-1-heinrich.schuchardt@canonical.com>
 <20251221015859.738112-9-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251221015859.738112-9-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 2 Jan 2026 13:07:24 +0200
X-Gm-Features: AQt7F2qK5vjrPztc5cQouRqqUF91-iznqoxKmJ3MWQF6-D5zjTN238DAXXtIanE
Message-ID: <CAC_iWjKNK3E5eJQxCy2tY45vOkBcPYM=NQe8_gZQ+MYcGTFpmw@mail.gmail.com>
Subject: Re: [RFC 8/8] test: clean up test_trace.py code
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Shiji Yang <yangshiji66@outlook.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>,
 Raymond Mao <raymondmaoca@gmail.com>, 
 Sean Edmond <seanedmond@microsoft.com>, Heiko Schocher <hs@nabladev.com>, 
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

On Sun, 21 Dec 2025 at 03:59, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> * Add module doc string
> * Correct sequence of imports
> * Correct long exceeding 100 characters
> * Remove unused variables
> * Remove module level invocation of check_flamegraph
> * Add encoding to open() calls
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  test/py/tests/test_trace.py | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
> index bbe6dd7de41..fc881a1b7a1 100644
> --- a/test/py/tests/test_trace.py
> +++ b/test/py/tests/test_trace.py
> @@ -2,9 +2,11 @@
>  # Copyright 2022 Google LLC
>  # Written by Simon Glass <sjg@chromium.org>
>
> +"""Tests for the function trace facility"""
> +
>  import os
> -import pytest
>  import re
> +import pytest
>
>  import utils
>
> @@ -183,26 +185,25 @@ def check_funcgraph(ubman, fname, proftool, map_fname, trace_dat):
>      """
>
>      # Generate the funcgraph format
> -    out = utils.run_and_log(
> -        ubman, [proftool, '-t', fname, '-o', trace_dat, '-m', map_fname,
> -               'dump-ftrace', '-f', 'funcgraph'])
> +    utils.run_and_log(ubman, [proftool, '-t', fname, '-o', trace_dat, '-m',
> +                      map_fname, 'dump-ftrace', '-f', 'funcgraph'])
>
>      # Check that the trace has what we expect
>      cmd = f'trace-cmd report -l {trace_dat} |head -n 70'
>      out = utils.run_and_log(ubman, ['sh', '-c', cmd])
>
>      # First look for this:
> -    #  u-boot-1     0.....   282.101360: funcgraph_entry:        0.004 us   |    initf_malloc();
> +    #  u-boot-1     0.....   282.101360: funcgraph_entry:   0.004 us   |    initf_malloc();
>      # ...
> -    #  u-boot-1     0.....   282.101369: funcgraph_entry:                   |    initf_bootstage() {
> -    #  u-boot-1     0.....   282.101369: funcgraph_entry:                   |      bootstage_init() {
> -    #  u-boot-1     0.....   282.101369: funcgraph_entry:                   |        dlmalloc() {
> +    #  u-boot-1     0.....   282.101369: funcgraph_entry:              |    initf_bootstage() {
> +    #  u-boot-1     0.....   282.101369: funcgraph_entry:              |      bootstage_init() {
> +    #  u-boot-1     0.....   282.101369: funcgraph_entry:              |        dlmalloc() {
>      # ...
> -    #  u-boot-1     0.....   282.101375: funcgraph_exit:         0.001 us   |        }
> +    #  u-boot-1     0.....   282.101375: funcgraph_exit:    0.001 us   |        }
>      # Then look for this:
> -    #  u-boot-1     0.....   282.101375: funcgraph_exit:         0.006 us   |      }
> +    #  u-boot-1     0.....   282.101375: funcgraph_exit:    0.006 us   |      }
>      # Then check for this:
> -    #  u-boot-1     0.....   282.101375: funcgraph_entry:        0.000 us   |    event_init();
> +    #  u-boot-1     0.....   282.101375: funcgraph_entry:   0.000 us   |    event_init();
>
>      expected_indent = None
>      found_start = False
> @@ -218,7 +219,7 @@ def check_funcgraph(ubman, fname, proftool, map_fname, trace_dat):
>              if found_end:
>                  upto = func
>                  break
> -            elif func == 'initf_bootstage() ':
> +            if func == 'initf_bootstage() ':
>                  found_start = True
>                  expected_indent = indent + '  '
>              elif found_start and indent == expected_indent and brace == '}':
> @@ -268,9 +269,8 @@ def check_flamegraph(ubman, fname, proftool, map_fname, trace_fg):
>      """
>
>      # Generate the flamegraph format
> -    out = utils.run_and_log(
> -        ubman, [proftool, '-t', fname, '-o', trace_fg, '-m', map_fname,
> -               'dump-flamegraph'])
> +    utils.run_and_log(ubman, [proftool, '-t', fname, '-o', trace_fg, '-m', map_fname,
> +                      'dump-flamegraph'])
>
>      # Generate the timing graph
>      utils.run_and_log(
> @@ -279,16 +279,15 @@ def check_flamegraph(ubman, fname, proftool, map_fname, trace_fg):
>
>      # Add up all the time spend in initf_dm() and its children
>      total = 0
> -    with open(trace_fg, 'r') as fd:
> +    with open(trace_fg, 'r', encoding='utf-8') as fd:
>          for line in fd:
>              line = line.strip()
>              if line.startswith('initf_dm'):
> -                func, val = line.split()
> +                _, val = line.split()
>                  count = int(val)
>                  total += count
>      return total
>
> -check_flamegraph
>  @pytest.mark.slow
>  @pytest.mark.boardspec('sandbox')
>  @pytest.mark.buildconfigspec('trace')
> --
> 2.51.0
>
