Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA4DCD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 16:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AA7F84688;
	Wed, 13 May 2026 18:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PIlSrgDQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7B398341A; Wed, 13 May 2026 18:27:16 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D21CF84687
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 18:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-67bc6098640so11256474a12.0
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 09:27:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778689634; cv=none;
 d=google.com; s=arc-20240605;
 b=MkG5wavu0iIjPcUa9osbOWKkEdTNHyRjomzBHsbFtV31DyZacLJV3zcNDsz4a+MFbw
 j6KoCQRKx0EGdEr3A/evmJqGvQ7cEvr2jpFG3zlqwgY97Gqe69JRG0utHJ3U3/BSxjWO
 XH5q6HTb0srCWq/M3sXQFbcPv6Jy4Ro4tIvdKR3m+Qi/u9jJiP77vYxmtr/C7YmaRSb2
 3wTkrF3CqR1CblkcEtbcymaVGsppV+7mYc8JWd9qw8ikpAkwKhmRuxa96In6rik5XIty
 70VDj9wNSJ7KUS6iz4N+A9mEqgHetwqZZ8kIcU6Pz94p1tAow/c1w/fB4r9gybV0N6ED
 1EjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UnnwPGHsVEVabYzQjE874BXVFIsGUpMjquNTmhv/eTY=;
 fh=k94s9/0BAWt0KBpKTCFdUTLOQcMKU2qx2KIXN/ON3L4=;
 b=fWNO9zGnPdd3n23A+4K7RjqEhRB7VpjFmxDy9bPBOeBkPZ4H6XEzKEF3W6gBVFG5pq
 fH9VfLa0RAR/XilUGxd4Wgi3NPbLQhhV8Z6i5k18uFlrcjOg32D/iaaGL0ChPi5SsBAk
 x6eCRrmzptGTObYczRwhuPAdoSoL2OR93croOTeqPwKieWN6NHjrdMRwemaltx/ybtWK
 1Q6RbjQuJSnSgRgyO6NrFrKiq8YoDzQkJwIHRB34bcd2egqTLxDaThqFIqG/ETYT3L1M
 CmrZPCBfRQETq4r1LpC3hP3P0QL2Rc6HkiHj2bkYlRtRQAukTmd4VTKDvGYtkV1t7SMo
 MDCg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778689634; x=1779294434; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UnnwPGHsVEVabYzQjE874BXVFIsGUpMjquNTmhv/eTY=;
 b=PIlSrgDQlTiG9+jSpawysPkWSeg1oV68hJxyT0LLE0jJP8HXfhObNqVdkcv8jewL4n
 XIYR5u0jX/xb8i1M1EpaoJ4uHPTnEvzpnU17iOIy0qpJAyq6s2ijSyu+OXGGTXAFUCez
 b22WC91O+pQA3XseYWTzkmVMPDYIK2BCbQ2C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778689634; x=1779294434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UnnwPGHsVEVabYzQjE874BXVFIsGUpMjquNTmhv/eTY=;
 b=DcMHw6CaT5KYhEQ5IbN+g/jCKvV6ctfHcOJduNU2uyRm/S2auMGV6wIHolWY8WVUuK
 VSn+IpdudW4yoQbIS/WJJPIWICg6kK/z1NTFoi4FwaUaVWIF/Sefjz9rGz8fBfTgrNr0
 eh2cPc0Ybk4Vi0xl3jHROYW7zhdVOzbZNfyW6iGi0b9tMn11CbfapcGKZ5fQmvutQ6XW
 LuJAqYP3MTYEeM8VXpFdiYGXLTbRQZK72s72qtU0+9M9LYN0LRG0x7IpzqFnNuu4/3AU
 t78dq2fB830PtJQ2eVqVGihZJmcnK26ZLSnd3JlqVaADNsoTj9muhwS/xIt8MBogyZm5
 vGvA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Ij2A9NwicUr81nolncnaa05cgxNdzeTQt/2TJVq99iWGigxvZBUPSO6HiqqSj957itCKicFQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyyfpoRxkuU5ExSJbSv8rsw9kSLm1hXEoGX50cCL+/P5XxkVQng
 10FILGMRWMHmXseYRctbLbZYjB5P7RUmLxnIZsmVyqQUKNYQkVy294w87k9/knsRQ29A5Sy95Rh
 URo63RFDMGt1Jrq/4Kl7D+eKa3RgTfLPnwPpx0I2k
X-Gm-Gg: Acq92OEQsnBFuDfR39K3m/EX1AvxBjPkjefje6VPPWr5epcmcxNg6TiwXqhpqJWHsX+
 NQ3CZegO5elU0i5y/TiltdvDrd+n998fvizmX45pjtu29JPROkjWosamKnFD0w2OAuJL1tNUVtn
 VwRuI3Wbe3a5H8Z09GuTez9EMrU3nSnA6mSenkRn+7F2Q1OJTDbh7wY29CAywAxfGWkh7kXz3IV
 +ZYPev17X5PQJ5mXA1OyVmrNJVpTWduKUljSuhc5TbGzdqrkoGs6iB1hkhmROULGHPXrpbetElC
 krmXlA==
X-Received: by 2002:a17:906:4786:b0:bd3:2b8a:2164 with SMTP id
 a640c23a62f3a-bd3bfb9f635mr273375666b.16.1778689634246; Wed, 13 May 2026
 09:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260513015606.591384-1-rs@ti.com>
 <20260513015606.591384-2-rs@ti.com>
In-Reply-To: <20260513015606.591384-2-rs@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 May 2026 10:26:59 -0600
X-Gm-Features: AVHnY4LqnR0k4qk9Wtof-dG1NTp2JvgP1CV7tPYTrqx0KMH-qJ7yeNJ3fkPhQao
Message-ID: <CAFLszTiT_JYZcukxXapYfmzuCnRrgirj-JT6JGqXwUkHuzqcmA@mail.gmail.com>
Subject: Re: [PATCHv7 1/3] boot_fdt_add_mem_rsv_regions: free old dtb
 reservations
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

Hi Randolph,

On 2026-05-13T01:56:06, Randolph Sapp <rs@ti.com> wrote:
> boot_fdt_add_mem_rsv_regions: free old dtb reservations
>
> Add a free flag and an initial call to free allocations covered by the
> global FDT. This assumes that all calls to boot_fdt_add_mem_rsv_regions
> occur before the transition to the new device tree, thus we can access
> the currently active device tree through the global data pointer.
>
> This allows us to clearly indicate to the user when a device tree
> reservation fails. How we handle this can still use some improvement.
> Right now we'll keep the default behavior and try to boot anyway.
>
> This functionality was broken in:
> 5a6aa7d ("boot: fdt: Handle already reserved memory in boot_fdt_reserve_region()")
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> boot/image-fdt.c | 77 +++++++++++++++++++++++++++++++++++++++++---------------
>  include/image.h  |  2 +-
>  2 files changed, 58 insertions(+), 21 deletions(-)

Subject prefix should be something like 'boot: fdt:' rather than the
function name. Please also turn the broken-in reference into a proper
Fixes: tag with a 12-char hash:

    Fixes: 5a6aa7d59133 ("boot: fdt: Handle already reserved memory in
boot_fdt_reserve_region()")

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
