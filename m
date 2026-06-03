Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C78CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 16:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F035E84874;
	Wed,  3 Jun 2026 18:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fWcSczEx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7C858488F; Wed,  3 Jun 2026 18:52:25 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A25358341A
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 18:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-84229481d44so1844706b3a.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 09:52:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780505542; cv=none;
 d=google.com; s=arc-20240605;
 b=U7wfeCbSn/jSSLhlh2efStPYdw0HWu1X06+xQB1OhTa608Rl19WR8ngTT/tXcnEuJP
 n5BqX9dO9Vgllv913c7wyVspIVSmDuMonYZXygf8EVxMu/Z8w9JvQ8BRw5PhjFhBqvAp
 LV8lUy+a1SOZR4GEOjZXmkcZfTzRJwC43nUlGiJzUgrid5MqrXqfzd5Z7pDwYcLznbJ2
 VuD+1udC/gW6eEvxrf1nwfSgw+ZWLaZ2NKu29DuKI0oGcp+CTI2k/5tn6ssvjwMauOv2
 mIVNNd5vszbHhvqweaGM7tYNC22kyvuM/SFwuzT8Ffm0ouEExuarbULYUITh4ZgwBCxu
 URew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MuMsUNxDK2nuHfr6OuqeVhTQioL2+/Xw3HSVjIltUFw=;
 fh=gE6Yt7gElLCbh8ryhtP+HD2nmjSP4RFADqefourqOuY=;
 b=lC4ZRyZ+s51anduvln01trTJcXVb8iqJrpcMZ2KjPOvVy5O2k+7j219JeMjXzEjARe
 hIhaYmqNzR9mpJl1sLm05x72n6jHVw0cY7Ot49SBiYnh5hB1x128cNi9YK8WZWOXmjLn
 eq7KGFPNjMXLDsau19n1vbw5j9WpN5BOCSYYF96zYS7/k/yLIzfTnO5UJzCDBz5631ia
 Ek3G4Oi7MRZDLKBeOfqCGVAwd75x80H2Scn8sPl3RBZsTPm25iPYVIGSOrUmXGIhZOwJ
 eq3mDcsICDbX9KPCK176wYgiFDIdDIOL8ikWtbPzJrv/SYSJwgf7kZdknMjNxf4bzHSa
 dUKw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780505542; x=1781110342; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MuMsUNxDK2nuHfr6OuqeVhTQioL2+/Xw3HSVjIltUFw=;
 b=fWcSczExcL6svU9n/zrucsmzZzk4i83QuZPr92eJFYwMNE0iFn9DUgTgX9UvCqVdnd
 Vf3jy0Aof/7UkEYzM5whbYIMUNzxrtJfAGz4wQzkN2kGTpxqwcYpXr2bR6Hp4Vm5YZwB
 sfCDj7KkBUyIbKzYOy+KT1urFUe0OXYVu6dfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780505542; x=1781110342;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MuMsUNxDK2nuHfr6OuqeVhTQioL2+/Xw3HSVjIltUFw=;
 b=SDDE1mfh+euwcB+C/VjysKJXz+Vx/1rpy+Kzii+A9WG29FuVL9NGYYW6+bVmtOlACL
 d0WuysiwNBBCUdR6nNdhFDlCFEtZWFvqIPnxVlj7IJejyJb63AdMgggO7B8BijYXf5wX
 h6vBzrgloTXFAZKRjDJwUV/5EwqTKYnfy6H5TRX4MjNMpejArUsMQbXuvZxcRmd4NISH
 eSZn0hqjJYBFieFRsvF+1qDWETycLWKQjslOJkdayIzAeTRv5LihnoW4GjSFJlW+tD/o
 UPMRAL8y+R4zAYAQvZQ5/b8MfGclQ0eMg8UZzZlYFjRFY/T0HeflWdyZ1HL26eUNR7mx
 THFQ==
X-Gm-Message-State: AOJu0Yw74YmKEcfxth9psFAkFzDLW9gmXq8ma/KWE37Hy6jK/p0cHNIl
 ovFYMPTQ4gkhe6n+Ak7GHQMjP7WqBnQU7HY63TBxlGQbyJzNRgRB6+PWPEO/mcjq15sydwVjTC9
 X8EdyK5siQSp4CgnoRMDGy/aawy+UGBLrwHmlLyE4
X-Gm-Gg: Acq92OF5VSAs73q47EvHmwTrdjvbCZF5IAB5W8kWPXAPnzvRO568XCbBtiyUH7s2joR
 3LkPvyJaRJpIZUDKTQMvjRvQ8M7Db6TURH3l5cMixP5jxiBFfqb6AwMHmIPKX5d09GBm3NU/IU6
 WHh1riCh1hDG18ksdKkFT9b7u1HN18zq0ZSahVgojC6FbqqgUxZg+Cw2SrDSRArJ3A9sc5IVaVK
 riIX7ohUOQzFpB4nNSBvXiuTr/0EXtnVG9rBoaqs78FTPFrpVLOHhGF+pC5BMJD4FM8VSEOLAiJ
 sM8VBEl4qMnuCHWD
X-Received: by 2002:a05:6a00:14cf:b0:842:4327:6cfd with SMTP id
 d2e1a72fcca58-8428501684emr4369848b3a.49.1780505542108; Wed, 03 Jun 2026
 09:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260520044554.15373-1-aristo.chen@canonical.com>
 <20260527150637.2850104-1-aristo.chen@canonical.com>
 <20260527150637.2850104-3-aristo.chen@canonical.com>
In-Reply-To: <20260527150637.2850104-3-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jun 2026 10:52:05 -0600
X-Gm-Features: AVHnY4LusF4ziPo4Qk2vYbkUlkT0G6fQnEkDGyy4SW9Ku-yqQm_iuYSLU_fZkaw
Message-ID: <CAFLszTjP-BkQwa5REs61eac3A_0WKJ3fnMPWW72kJ17UcN42Uw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] test/py: test kernel_noload decompression buffer
 overflow
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
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

Hi Aristo,

On 2026-05-27T15:04:32, Aristo Chen <aristo.chen@canonical.com> wrote:
> test/py: test kernel_noload decompression buffer overflow
>
> Add sandbox tests that exercise the per-image decompression buffer that
> bootm_load_os() allocates for a compressed kernel_noload image
> (ALIGN(image_len * 4, SZ_1M)).
>
> The overflow test builds a FIT whose decompressed size far exceeds the
> per-image buffer and asserts that 'bootm loados' rejects it with a
> decompression error rather than overflowing.
>
> The boundary test builds a FIT whose decompressed size equals the
> per-image buffer exactly and asserts that 'bootm loados' succeeds,
> guarding against an off-by-one rejection at the buffer limit.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> test/py/tests/test_fit.py | 126 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 126 insertions(+)

You didn't pick up my review tag so I hope you don't mind a few more nits

> diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
> @@ -426,3 +456,99 @@ class TestFitImage:
> +        ubman.run_command('bootm loados', wait_for_prompt=False)
> +        matched = ubman.p.expect(['Image too large', ubman.prompt_compiled])

Please use ubman.expect() rather than reaching into ubman.p directly

> diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
> @@ -117,6 +117,36 @@ host save hostfs 0 %(loadables1_addr)x %(loadables1_out)s %(loadables1_size)x
> +# A minimal ITS for a compressed 'kernel_noload' kernel. bootm allocates a
> +# per-image decompression buffer for this image type, sized as a multiple of
> +# the compressed length; see the test_fit_kernel_noload_decomp_* tests.
> +NOLOAD_ITS = '''

The test could use a buildconfigspec('gzip')

Regards,
Simon
