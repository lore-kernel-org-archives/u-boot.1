Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05BCF94CB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AE798419C;
	Wed, 22 Apr 2026 00:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UP1Hjlxs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B20BF841F2; Wed, 22 Apr 2026 00:50:15 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA84183AC5
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b941762394aso649946066b.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:50:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811813; cv=none;
 d=google.com; s=arc-20240605;
 b=Qp+cS+dynf5/YQaE6ZXTiHM4eYPOgBP+M0H2RetjQlrQa6lKJkOOLkbMmTGoMt1gem
 lou3XhMdP+RnJkFMeVxpN0wPy0UXOtCVF7e9dri+x+QN3MfkLZy3d9jcEFbpYmfixf3U
 6+zIpJ7+nvjp/aKXbFJQcu88vLdMuf9vqgOXkC50+RfUS+NsDxoQ/WjEU7TlS4wvszUK
 ivx9IFt0KxH//wr77cdUhzmPudz/bGUebaeIepZUGnh9DG4Pb7FHqK8uPRz1cLF44xyb
 tTBf4XjeheYnDpbNonEHTtY7y041NgvQgic3/rZ5Y1K3U6tA26pdjU8h70TvrScEKRJf
 In/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4laSJWwq5j9mgWzrTu0vaaBVsCZIZdBeYfVdcXMApys=;
 fh=KO8QE6rRQVYIJkxoHmLSBiK0P81qKBABPT4f61JE6nY=;
 b=Zoc9GzeJq3E4KrV2HsHpLLPh/Uvh3WP6mBZv+5r2JuwLjJ/KPMz2xbduNEHRTJ0QMm
 1GOVhkzE+MpADqbHKcXafd8mjdKpur2xSCKBkgqZRoGT9Jf0vlaEGcnXvPmPTQjtm3pO
 JGNDXJNr/HrgPW6jg4Ajp/vWrjDtEUGRRXDNzM/0SAtkeCVwIm2bO8Sdg2hUpYQrL0UL
 ia4oyXiqJ3Zj6s9JHyvttbbsvvD3NrGT4oUwQmJ92Y+UyDeCblw5weRLRp8HFnFBcd8L
 E0gWXMqRZE9oV7Yni4tz0FxBtYAu/LnN8O3qROXB91bvrrOgPuHiPl30vFqupVH41u1E
 JnZQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811813; x=1777416613; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4laSJWwq5j9mgWzrTu0vaaBVsCZIZdBeYfVdcXMApys=;
 b=UP1Hjlxsxg31124vXgdS6WI4t1QL/b/E1no46zoLjp6r9i6OmwiE20BpGd3h46M0tu
 feuRsWHOMiEx7l0Ivi+dFj319VEPuvED6A52PdBRIegZEtuS3Y684A4g/p83HsZnqWnq
 blcdZN6I0sKruG5iGyROz7vDGixJdDz/pYLrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811813; x=1777416613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4laSJWwq5j9mgWzrTu0vaaBVsCZIZdBeYfVdcXMApys=;
 b=kHRQnIudEI2rTjPU7J2dE1B46mSBimr3ztN5dGln0wgjHWnfxPGQOKU/1FBjDXqSE8
 H7O3q2YvxCc4Xphbb2ty8eFoR1dcLlLlvaZ8qdmCDALpe50Tuy+AslXpsSl9qQ0jgjJ2
 +JqEVKSAKUsOvBjyz5RMAdMXKlLJrH/s2KkLIpmY6EGQvrLbfUrlQogf4zi9SmC1kH7g
 WCeC859qdziLQX1qxpr2sWLjybJr85J3/rmrSCpOX1Ci0wy4B2QCU3Z0UfSKSn6B5VX+
 IvDsW9stjzTc6fe8joFXwPOinizO82dzmwEfBHOZ67lNhDNr2mHcnVZ/17PMwoLnbuU0
 nBUQ==
X-Gm-Message-State: AOJu0YztOYfZiTOk7IV06tmP8D76J5X+wBNxBy8DkXVPWoTyHcFgNh58
 9aqrF7KnsTi+DZQ/Ka+jjPvsTcKJo9HLkHZhYZZtCUd3yyJh5ZJv7dLC0YBIpVhBJABFUhps1lt
 xslSW5hCGFNKfoDK9aFLHImgGU+5q2u6z4CRQCtuO
X-Gm-Gg: AeBDiesYewTLFM+9rjJDCtHcThISEknUn0rlsH9c82rq99mCnIfg0JUA2iAXtwflrgV
 wdHPTWbrshDZxWnLQcFeOenYO+CvyOOp8m/kwA3zQ6sqcaH5GPwyL6qNYHbnYv4CRgTsE5TVVgU
 V9O6CWBAl4om/AOOCV/8HbBQJgkPURzQI6U2ySwDxF6/eRERCoPsSD2IA10mvR6dsVlhrjVUr6b
 C2H2APrdXd16N0drMfofeQjlSbEMYgWOJLeOexaOgCY4oHICqGz5phJZv+z78SliRAaHdBYgE/X
 y1RgCoXa3SjiguzpEjyI
X-Received: by 2002:a17:907:1b09:b0:b9d:e69b:58f7 with SMTP id
 a640c23a62f3a-ba41945c089mr983522966b.21.1776811813209; Tue, 21 Apr 2026
 15:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260421080847.235789-1-happycpu@gmail.com>
In-Reply-To: <20260421080847.235789-1-happycpu@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:50:01 +1200
X-Gm-Features: AQROBzCjTPuaPluwuLXNi6HipTSCrpTKxJYbB0M6c-dAaEPEbYGT8Am_wafiyBA
Message-ID: <CAFLszTiX=fOV8t1v3UsveV6sbnvcs20hDxOdorEXRzS1JiBT3Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: 74x164: use dev_read_* APIs for live-tree
 compatibility
To: happycpu@gmail.com
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 peng.fan@nxp.com
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

Hi Chanhong,

On 2026-04-21T08:08:47, Chanhong Jung <happycpu@gmail.com> wrote:
> gpio: 74x164: use dev_read_* APIs for live-tree compatibility
>
> With CONFIG_OF_LIVE=y, dev_of_offset(dev) does not return a valid
> flat-FDT offset, so fdtdec_get_int(gd->fdt_blob, offset, ...) inside
> gen_74x164_probe() fails to locate the 'registers-number' property and
> always falls back to the default value of 1. This results in a 4-chip
> 74HC595 daisy chain being exposed as only 8 GPIOs instead of 32, and
> any consumer referencing offsets >= 8 fails to bind with -ENOENT
> ("GPIO ... not found" / Error -22).
>
> The 'registers-default' property is ignored for the same reason, so
> any configured power-on output pattern is silently discarded.
>
> Replace the flat-FDT helpers with dev_read_u32_default() and
> dev_read_u8_array_ptr(), which correctly walk both live and flat
> trees. This matches how other DM GPIO drivers (e.g. pca953x_gpio.c)
> read their per-device properties.
>
> Tested on stm32mp153d-ssonic (CONFIG_OF_LIVE=y) with a 4-chip 74HC595
> chain: all 32 GPIOs are now exposed, and 16 consumer LED nodes at
> [...]
>
> drivers/gpio/74x164_gpio.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

> diff --git a/drivers/gpio/74x164_gpio.c b/drivers/gpio/74x164_gpio.c
> @@ -10,7 +10,6 @@
> -#include <fdtdec.h>

It looks like gd->fdt_blob is no longer used, so please can you also
remove DECLARE_GLOBAL_DATA_PTR and the <asm/global_data.h> include?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
