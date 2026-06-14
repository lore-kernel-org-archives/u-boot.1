Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904DDCD98C5
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 11:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79A1783EEF;
	Sun, 14 Jun 2026 13:47:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Br+fXFvE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04DD183FEE; Sun, 14 Jun 2026 13:47:24 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B34D800AE
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 13:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-68ced97b6eeso3794128a12.0
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 04:47:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781437641; cv=none;
 d=google.com; s=arc-20240605;
 b=jsm+t2TJGsAF8e7rJt3c/InQ9jl24KLA1LXt8UXLko0uORSTD7VuLwGxn9aqFKfSDt
 UilmVh0bX26IHO4FVk82t3MeqpHqeArEBp9a5j5l7jYVMgjAEBZk8K6/v0nuZTgjDP54
 hRQcAuxBfkmDO5JE1ENS3JO24oa8YWnnXZ1bGlX/2n4KYIriDVw7DgPkUSolSalM0KxU
 UH6QrVwDI1X6nXdap/l+75NsJQjQCK1hOKqoHsft23nzEyKRGSksxwIOSQRFebbLeKBe
 kZU1nG2t1sMcaoklGmK7V0HLx1P1H/K+arQ4Uas4FANBBhPwcRzG9QLIkpwllsQNUZoU
 tXBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8Uoz+o6L8etslX8wxpqNtNCihqtq2fytGw3RwcV2W2I=;
 fh=lX+TcTLgC16sv8B/6hXvQPXrrQFcKh/8U3NT+DCAovE=;
 b=GdqIZHEWxjPWeAoE2ZrzF9WJZ2DPmS5fwxHYNhXizvMO+YJ7GrmPGuC0LFVNqu5WuS
 uA2Vc24diCjpWl/kM78OQsv88W9jWMJKCHHDrhE/T4+ObsmYT8zn4UiN6j4KCfa6QoGa
 GaYvFmWAm/U8yHLo6ngaZPQAvKKpszqR4Ehppd0TZ2WKm7CYlIPfDG16QgqP9YbsyArQ
 +q34KntQZI+UR3OiChBbY0BArwiP1OTHUVkSs9MVlmTeKBkqT7KF7B1AJy6x01g9l+mf
 hlMmvgDYHaoIJbpgxaYJO2eivXQhiyWkfV76ADQYyuPpt5B2xMilhHkAAajW4NqhR+W7
 FDUw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781437641; x=1782042441; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8Uoz+o6L8etslX8wxpqNtNCihqtq2fytGw3RwcV2W2I=;
 b=Br+fXFvEniIUFviHbCerIZi61p/NKKJ8fveIX1Rl/wixt7xjcUzFoUuMzynrdG5Nra
 yKMLg0ggYtKDsttGZQMSQ25+xJkEqEVRkuWrT9PoHHimCbEmmJvbQodDccnqsCiFhemE
 fP+qqSJg/vXU7VXeYYfcxMxGu9+8FlvBXurbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781437641; x=1782042441;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Uoz+o6L8etslX8wxpqNtNCihqtq2fytGw3RwcV2W2I=;
 b=UGpm+8kyWWjuBCLwu7z3xyNkp87bwIgXxvBQ9scCvKyqHosT7yhTCSAP0xfj004/Yz
 NQnfxPwwhYNGjq/In7yX/5rGmTVR1EjgVvgN6xSSRTzAbDciMXTrZWljMGAklp1o12fc
 vE6RDdflGZY9q7juiLH7EY0qey/dAZZFgtB3PF3XjvYKPVCqyFdE9L30fDimS9YlCJdB
 b+P5ASXeHDYUcm3TvUD0py/vc+p9GVenaimje0obRNIKtHZu8HzVT6Ac0/TkVTSLTa9k
 nIClmRkvNNanPqERxQ3vuRKpmZwT+NR8iygl/wDzBd0RHgxHtXLUZjndOsPtRHSVZ8RU
 GC3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1VDDyZUCbrnQqbxJ8C6RhALEUU+Ok8U03oV0mP57muB9ex61vpt8NnrCHPAftzos/WE/x0wE=@lists.denx.de
X-Gm-Message-State: AOJu0YzeJG/Ffhezbx2d5tEI2YpChb/D88S+3WErb0QXvW6A7OJtWEkg
 PgBrOCvi9+lh7CPGYBQVCgWB4RUlT7A4uMQq/qN6ydYFz50Y8Iom/cIBXaMjA7SndYzD99zIFVO
 wvs//BVe0bdBOEkcxlCNh4Mhv7OZbk9MKWDdzmUSY
X-Gm-Gg: Acq92OE5q7+ZXCKuDQ3Giwv1mXphfXcdjHfQlmBKMA7Q7sTY0NVuUUOBWmlOlUJsnfj
 rN2uBoQP6U2qQLOucYrxdJlMSTwQApakn8TgFGpk0Lpa8VzY1SjVNSnUkm1vLwJFuULYHd4vxCs
 8i4vvIgqwDUBEfUsw53j7pNu0qVsE7frln0S/yn6K+PmXfKKBqBUTfApJbtAeN4CE/wcyrWegnA
 tIejXIexcvixQlvIi5NUUqYj21c4i7rB87tK+79r/dlv3t/NM/Ao947pBpqXv5q+H8itxxDccf4
 9COF7w==
X-Received: by 2002:a05:6402:40c9:b0:67c:6836:7b0a with SMTP id
 4fb4d7f45d1cf-69378a2f837mr4734406a12.23.1781437640789; Sun, 14 Jun 2026
 04:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260604155038.3182-1-rs@ti.com> <20260604155038.3182-3-rs@ti.com>
In-Reply-To: <20260604155038.3182-3-rs@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 05:47:09 -0600
X-Gm-Features: AVVi8CdX_eDwBFdFB3_8S6uKTKyEbk3VmrSbgpikrtir0dXUA2cVocUDqwuJHEs
Message-ID: <CAFLszTjGGoW9-et6T5gbhiwaZH5dG3fp5ouzOEUkUqdaJCpH6g@mail.gmail.com>
Subject: Re: [PATCHv10 2/4] test_ut: add a ut_ubman fixture to clean up tests
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 u-boot@lists.denx.de
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

On 2026-06-04T15:50:36, Randolph Sapp <rs@ti.com> wrote:
> test_ut: add a ut_ubman fixture to clean up tests
>
> Add a ut_ubman fixture to clean up after certain problematic tests
> without negatively affecting the current assert based testing.
>
> Currently this catches "bootstd bootflow_cmd_boot" and "bootstd
> bootflow_scan_boot" ut_subtests, as these will change the sandbox state
> a little too much to be recoverable from.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
>
> test/py/tests/test_ut.py | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
