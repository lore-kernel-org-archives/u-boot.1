Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F706E8FDCC
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 13:46:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D750C83BB1;
	Sat, 27 Dec 2025 14:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IOoPSI6T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E87983BC7; Sat, 27 Dec 2025 14:46:39 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40CD783B9D
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 14:46:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-34c1d84781bso9023683a91.2
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 05:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766843196; x=1767447996; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=evKjL943kXgdWaXi4GDAedH+lnr7pMc1vx/ruHui2Ns=;
 b=IOoPSI6T3TsCq23Inp3WIMZTAPO5Xi82swHqI3+pHs6ncfXkjGJEcW5L366NKqZQCL
 XVgU3t0Qz1XL8GwrToi4THLAT5RY18JmvEk+lcrdax5MzVtZdpqAAw03HYHgyx2Re6F1
 ojK7uvGzgifToRqSV5DOKZWHlCGPnqeQ9kkUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766843196; x=1767447996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=evKjL943kXgdWaXi4GDAedH+lnr7pMc1vx/ruHui2Ns=;
 b=iRqVlPKhTa0CZeopm6obXkYhKjztrJ65fGR1HbWRJ5JnRgw8q1ZtBFAF9pZEZjcD9X
 0GC2o7CbZclgNbdd5aHksz/5fyQP6EWghUusPT+vBkl4X467iKnJAMdAop+FHYQPNPq1
 oswndVcfcnL+cukEjFUGwZp9s/W9X7pKyvbzT5UMtJUhqfm27Yw4DcLLcsPW9qRbNdXN
 YstgN/B/nZbczHUE0RiJiPWDOrcNKYPb5fZeRf0GD+kjasXYcpbpO7FU5AP4IrwgymS2
 za4Vf3OV3apTMXk69/3KXVghwVK0FXT3KbiCn4lQuZwHDC7pylYakva5iX2o0wozhnR6
 bGDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2KKM5n1clS+6hQ1CteRD2rGazZkENtkmbu1hFMqnVhnpUvL6d70/fWqFFCFRQNo7/SZJTyJM=@lists.denx.de
X-Gm-Message-State: AOJu0YyL4m5mQqyRWKS+9ywq5rXB47vrLFoh8JMHqcrUMJbkKHsH2Z7R
 9NPqGEv21Fck2txGh5Qpw9GD+dWhSmKRFGYaYCcuSD9uz8g/o1k4jyBzm5AE+5+YdLq50wdrSzH
 +e7rQw7OQP3dXyx0V7DkUssZVAMqwCA4COxfxxlBT
X-Gm-Gg: AY/fxX4/kV2n5Rv8WsFE+JefYVuUgvEEpmqUtd3MWtMXIm+OhHrLcpekk7GpdZwXymr
 KpFcqRxA7aX21NUxctR10BaYY3AK+5YXMMBzEkYnvP7f50EywH1q/g13fbCwcsHa0hL8V2KRzVS
 Mb5PF6wdMxFi9qa2dY7B4TuJ7mipNPBPy6Zj7upqmnB+tykWmzRgJCsA5FYTm7pAkN9K93zqOkt
 LT2Z2VFhDdRVojqRNwMO+ycNHX02kf72aL4jh0LRrLVTFA22mTSagwORT4S0Cj4wvWRnw==
X-Google-Smtp-Source: AGHT+IFfwzUX+hPGalEVtIv1BWuhvI9JbF0IqlRDaHE8w6pKMs3UKCu+4pc7Pjw35Pu3Z4BjzU8icHoZscOqfB3jPqE=
X-Received: by 2002:a17:90b:568c:b0:34a:b4a2:f0bf with SMTP id
 98e67ed59e1d1-34e92142b2fmr26241559a91.16.1766843195186; Sat, 27 Dec 2025
 05:46:35 -0800 (PST)
MIME-Version: 1.0
References: <20251221015859.738112-1-heinrich.schuchardt@canonical.com>
 <20251221015859.738112-8-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251221015859.738112-8-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 27 Dec 2025 06:45:10 -0700
X-Gm-Features: AQt7F2o0-ObaH8f4IZoNzt3GTSjNmP4cOELYGnTuYiDIiGT9JmHBjn8RUngm_Hw
Message-ID: <CAFLszTj+NXRZ=Q0D5-rD03NkSbfhwUMs4WL2pPDDHEE0gLtWEQ@mail.gmail.com>
Subject: Re: [RFC 7/8] test: initf_malloc is only traced with EARLY_TRACE
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

On Sat, 20 Dec 2025 at 18:59, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Only if early tracing is enable the function initf_malloc can be traced.
>
> Add a configuration check.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/py/tests/test_trace.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <simon.glass@canonical.com>



>
> diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
> index 7f897e4c366..bbe6dd7de41 100644
> --- a/test/py/tests/test_trace.py
> +++ b/test/py/tests/test_trace.py
> @@ -159,7 +159,8 @@ def check_function(ubman, fname, proftool, map_fname, trace_dat):
>              base = timestamp
>
>      # Check for some expected functions
> -    assert 'initf_malloc' in vals.keys()
> +    if ubman.config.buildconfig.get('config_trace_early'):
> +        assert 'initf_malloc' in vals.keys()
>      assert 'initr_watchdog' in vals.keys()
>      assert 'initr_dm' in vals.keys()
>
> --
> 2.51.0
>
