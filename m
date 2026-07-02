Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CC7C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9C4C848D2;
	Thu,  2 Jul 2026 12:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TXjtU3h/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BDC484942; Thu,  2 Jul 2026 12:22:30 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3135383FEE
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c12c22d0f86so35128266b.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 03:22:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782987748; cv=none;
 d=google.com; s=arc-20260327;
 b=AFJYnXT+sr2ht5rSo2yVOnd8NtphTnpiry4S45vNfqK/8uBLHzz/BP76rpQtyNiRB9
 IyXCh1PE5qGJ+c5a9nyaRqqPfTTZww1jF14mOZl79eqAjutq1s6Mbi5QMnQK25ozEX/J
 E1L82gkz+06t0l+Cm7DsWVLLRlAUTQPnGqq8uiFhR1D1A3+kLFfudLNftrXJc7bkmOEC
 nAXjiAbiFJBvVgxiwTInvbTG9wlCjEgFI3qh6PKp6KEHEDTewKAeetqgCMa3crOO468T
 EubLA3bNUqAg9MKOcQbZpbehrX700b4MDXvNHZlvrQ/uar/SzYhPZU+FY27fp15utnTy
 xl+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EuEb0S6ryySn+q5U4TDP7QQKBfZElL621I52H0HyMqE=;
 fh=6NPSEP/ZcVtIT8cNrC+wEkij7IXDFsfkZA+Qdl0X290=;
 b=UQ3fodmGhvpE5fDp9SF7R6/dbqSB5xNIeLGjXbAUyCXvOCA47JJg00wWewADpJvsbe
 vp38xTdzjZNWttzd7QuzK8eItFzTX2JfaKiavehtLFs4W5lMMQY5ArE471geEMT7OuJW
 RKSuo+fZF46lK+q3HKhqX3CMYF3sAiz0La2/yDneQ79dUAvfdA/wUXcPz00sGqxcJhez
 TiQmmMb4n4LCfZ290DSArOhVaYpnqxU2d4BFBPEWEUqIqQWtj3fC14rV8LCwHl7tgGO8
 qHdU8kg1sIq+W4lmOMXaSf7TKuX3WKi1dxO2n5O/2nhwJ79H+61KT9U3fQtGXzWdhTu3
 Mosw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782987748; x=1783592548; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EuEb0S6ryySn+q5U4TDP7QQKBfZElL621I52H0HyMqE=;
 b=TXjtU3h/dec8ijj3InRUJipP6tQV/uLlWwCxDu/e45VgTTmhEgH289Q2mOQFPmOh8Y
 qD8U7rBR3GrTzgTYK4lhjKn5c4DdXhZcS9UdWfB9PwlnP56bB+aq2Akg+g3L7FcZS8YN
 p+BDpDdZYTX/3KMfKQnZixPS4uPyYkgyiuSnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782987748; x=1783592548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EuEb0S6ryySn+q5U4TDP7QQKBfZElL621I52H0HyMqE=;
 b=EOl5w/+YHwK630EsX7/F+4Tnqx3hmnmhkxyJYHw/qPOxUwhiJqBwjGfb28G7jXwk3z
 Twyy3z0j9WsDsti1T7GVq3NupBbRYB4HRNR2mJRHz8ZAquo63NMEQN4yRvjZobLNGp9+
 z0qC8CY6Bc6EdOcvGpgRNH4EMyUVnSehwThyVOPCwOcm4WW3B+4jEbELv7sLKeUMojro
 6ERHudTScgLVgJ4fMVf+IUEoI158wUa5/tJPpNgDpFttNEJq6YMavIdWUM2/G574tbPJ
 h5Be/hevgjMCgjo5ryPGKXSljgyI94DQJ6jiR5oseqbGH+m3ePlhsd01ljFhyFW/40ig
 X6tQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpz+mymn8yq7c9j4XHuvli15U9CgqMXB97OcBGp4TxSrOCmLaS04v+o6eLoCfgt0zc8Kzmc85M=@lists.denx.de
X-Gm-Message-State: AOJu0Ywej1KvYHEJfsB3DmKvYGWoM/51NAbZ+/4NV5DYjBTCql6EGHld
 zYLMqM7V+4uxv4BDV0/zpkOGWY0XElMPhmK+BFb+ZNdSSMqT0KoYScATCA0FzAra6IpJisbX5OP
 +pp6YDOFAbe5/pi3tmE5pgI4/9wKEAdq6AIV6x5h5
X-Gm-Gg: AfdE7clp0pzlj+IHOwV/1p91aQ64fRhvi1If/H513l25B2v9Cs2C56cp+SPqVKBTndF
 SoFSTrz2EZrOFe2m5lfO55oWOhZepJ6aezuS0mAcY9vrd3NzA7bTHl7awXLB9lxV687y7zDWgdM
 uXUcRwTaZOLUcvIMdiBxZuc78M1mitgOqUKR2f4qdVs5YgMK29M5gk8blrLZFWZJK8NQqZ+umlJ
 EcpqWD/wheezkhnpoPevpQo1i6zAyUQwia6AIhbLT6sSkyCeQiFCKaNXAVm26iWV0Otdj/96Q==
X-Received: by 2002:a17:907:a807:b0:c12:5f4e:4b17 with SMTP id
 a640c23a62f3a-c12904182cdmr488388866b.11.1782987747598; Thu, 02 Jul 2026
 03:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-2-me@ziyao.cc>
In-Reply-To: <20260701111808.870705-2-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 11:22:14 +0100
X-Gm-Features: AVVi8CdYfHhO3hR_E9vV0wtRNO_L1xNpaepA66IEym_PVKbKQjMJXZtA6dFYioo
Message-ID: <CAFLszThfvoqgsTwZcmmR7+feYM80wUhH0n6=RdBPW47+Nv=YAw@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] lib: fdtdec: Handle multiple memory nodes
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Jiaxun,

On 2026-07-01T11:17:53, Yao Zi <me@ziyao.cc> wrote:
> lib: fdtdec: Handle multiple memory nodes
>
> Current code only tries to fetch the first memory node found in
> fdt tree and determine memory banks from multiple reg properties.
>
> Specification allows multiple memory nodes in devicetree, rework
> fdtdec_setup_mem_size_base_lowest and fdtdec_setup_memory_banksize
> to iterate over all memory nodes.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
> include/asm-generic/global_data.h |   2 +-
>  lib/fdtdec.c                      | 129 ++++++++++++++++++++++----------------
>  2 files changed, 76 insertions(+), 55 deletions(-)

> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> @@ -1115,90 +1116,110 @@ ofnode fdtdec_get_next_memory_node(ofnode mem)
> +too_may_memory_banks:
> +     log_warning("%s: Too many memory banks\n", __func__);
> +     return -EINVAL;
> +}

Typo - too_may_memory_banks should be too_many_memory_banks. While
you are here, please drop the goto... bank is bounded, so a single
check after the loops (or bank < CONFIG_NR_DRAM_BANKS in the inner
while) gives a single return path.

> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> @@ -1115,90 +1116,110 @@ ofnode fdtdec_get_next_memory_node(ofnode mem)
> +                     log_debug("%s: DRAM Bank #%d %s.%d: start = 0x%llx, size = 0x%llx\n",
> +                               __func__, bank, ofnode_get_name(mem), reg,
> +                              (unsigned long long)gd->dram[bank].start,
> +                              (unsigned long long)gd->dram[bank].size);

The current code uses %pap with &gd->dram[bank].start, which is the
idiomatic way to print phys_addr_t/phys_size_t iand should avoid
needing casts. Can you keep %pap here (and in the message below)?

> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> @@ -1115,90 +1116,110 @@ ofnode fdtdec_get_next_memory_node(ofnode mem)
> +     while (true) {
> +             struct resource res;
> +             phys_size_t base, size;
> +             int reg = 0;

You should really use phys_addr_t for base

Regards,
Simon
