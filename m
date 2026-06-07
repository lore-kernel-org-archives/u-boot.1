Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A36CD8C8C
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 18:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC1F983314;
	Sun,  7 Jun 2026 20:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MyMz2vVg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC2DD847B0; Sun,  7 Jun 2026 20:20:13 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A68AC801A9
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 20:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-36b903567fdso3590366a91.1
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 11:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780856409; cv=none;
 d=google.com; s=arc-20240605;
 b=UyrNXsySrtEliLCBEeS9/V6mzXPyY0m5y4DT9l2pnA4k6RV8qu1wc5tDJzV3Y5rFn8
 U4S5sfNmv87OLhSdt1sKp2z63iVwIRe0orx+egBEcxJFwv7NpXxBwU6Dz2CMesU324EW
 dNX1SHEBfCFy3wPoTep/dew7VCCs2OB1T5hhK9HnFLD/xGZds2167aUFotskiRjrZdyN
 NgfJLy5vso751yQVy/PzDF7dmsFoPvRaOYt7w5UERpQSqhW9j0iNAsxmdiNqxstflEgy
 7FsrLknYLWHWZ2akQpyhA7zGgcVhIwn6LpDdv5mE7YM1keXfCYlnA8l0TcLl/K46C/Go
 Cs5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=O4+juHhFymozekNorMotC0cHAva0LFcqKk02/u85OXQ=;
 fh=k/laPVipeHznJvUUt0As2jql9gMDgBmYjTRuEIFyQF8=;
 b=AKCdJqWRmxqI38eBwri+FYPfrQIEas5PIIGSFaVnT/7cu6QlB0hgvJugEyzlQYeGik
 /Cqi4ueReHDBtHczYqL322ERZ85qxUmvVnnRx6uqASK5jY6q0o48XLVWwKkUxckJC8K4
 BIVFKyS5/SEWGaJMjixTjNuaNvlD1BoHPJ8sxNgKisPIcWPMgVa3qIkwOWotxy2aYItE
 B4OVe9jNHE6SdTmN13AJlWzARkz9Rq79TYLrOMuoeSyn3rJt/+V+RImj4f5KcGmF6zk+
 A4XyA2adRZ3r4176SH9w9zlufNdjTepEH8OzcJU2YIk08pBfOOsQUAgajU33gGKO+v/s
 8JCw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780856409; x=1781461209; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O4+juHhFymozekNorMotC0cHAva0LFcqKk02/u85OXQ=;
 b=MyMz2vVgx+cUGM/5K/pNEXU/3kmQNas2yLUekwvG2OLY7lJVHXE+RuD3AtPKgdcXQL
 wC+ctDkwNXsnpvSVPpaMSIp/tlFqILjbup3A33oIYwd6iUtFlvCAiZGI4F+SDOKi4sQg
 z6uYowy2aaDTAsJQHGXKIz6TkwzY8w7mcQO3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780856409; x=1781461209;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O4+juHhFymozekNorMotC0cHAva0LFcqKk02/u85OXQ=;
 b=ZvKcDPXKcAdWYTJ7cuC5oocY6CGbvA0aIW5R9OAf/ZNi+/o35+qaC/F0NFTgoOwvtu
 vCF7mKSH7+lIgBX6BNxTrYmb9emw4WjPHDnVQDU4uIcHS/1TWJuAI8/wMAdKTGTj4Kp9
 Ny3fuNTtBbm3EmlvGKQcnU7XKadewJzms+8Uf/XQb6oRcBbnkidj3bGPunGPjVT2KLfa
 rTb2c05B/5t+4HH0WIiv8Fv++jx+kJWRTR6zU8L0K383vuSagy6/hF4ynna8Ny9f1VnE
 F4KZGBVWLeX9wbie9kufM0FAY2ipBOpeMXf7QebPCjlcpOqWsQvuXxhLeK7HnnRfQWr3
 tEzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1bGnxlgxE2hkqMshQOEheW5HMszinImWrBmjgNpkQNQn8uNNw1EsGZzmM/gTZxYSjehKOcDs=@lists.denx.de
X-Gm-Message-State: AOJu0YwWFkT9/hhoHWVKx5S1JJ/b9iDu+dGwen9gjxDdMe1dYdE72wlF
 OjVqU077Y57kyjzAEdNqY7jwJ3zmKjGrxYrLO603jo+K/FmAayM/rBGtmQEyj2hx9vx/5OykmE6
 /Lza4goF4k9G7CCXvBo/49bXFMptlvdVWN2YV/0ffO31vq/5N+q8=
X-Gm-Gg: Acq92OETCO19UqqA2IjVy9RUnGpJ2sIUQpZ2I88V8ZfD5oMsbWJwSpU2zoJIFTE6jcF
 4m5gQnd6QMzV3n+B0S9d/N0LSqLXPW9NwK2XawKx5c/KmZSTWAxY6b+B0W5JomOCYnI9+2T0ZEm
 duerY2fkHTP7bQSaQZf5QeCrvB524cRbrnwaMAAPWwcalXX0JbDRDn66gnNOu5CcBW8U4vKXRz5
 ornHx6vEWizSSq70KKmGcmuR3DnTGnqACyPZNEYUPfpnnNeO9URPROB6CNNP8FVGDylaPJqfN44
 49pBEPYfcmlCqRK6
X-Received: by 2002:a17:90b:1ccd:b0:368:a297:bd38 with SMTP id
 98e67ed59e1d1-370eedfff8dmr13363068a91.7.1780856409570; Sun, 07 Jun 2026
 11:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
 <20260604073719.48723-8-ilias.apalodimas@linaro.org>
In-Reply-To: <20260604073719.48723-8-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 7 Jun 2026 12:19:21 -0600
X-Gm-Features: AVVi8CdCfUpgZDfQbfidoHi-UXKhjlfJcRu2O8FUNIpaM3ESdtSUcQV8D-uaN54
Message-ID: <CAFLszTj9K9AkH4HtEDHvoeH=YFQeTo0xJHG-pDNWx2FMQJ5YmA@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] doc: Add a warning about using RELOC_ADDR_TOP
To: ilias.apalodimas@linaro.org
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, sjg@chromium.org, u-boot@lists.denx.de
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

Hi Ilias,

On 2026-06-04T07:37:05, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> doc: Add a warning about using RELOC_ADDR_TOP
>
> Since devices that can't DMA above 4GiB will misbehave with this option
> enabled add a warning on the documentation.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> doc/develop/memory.rst | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

nits/suggestions below

> diff --git a/doc/develop/memory.rst b/doc/develop/memory.rst
> @@ -110,6 +110,12 @@ U-Boot Proper Flow
>
>        This follows the same as in SPL flow. In board_init_f(), a part of memory
>        is reserved at the end of RAM (see reserve_* functions in init_sequence_f)
> +   #. Relocation address
> +      By default U-Boot will try to relocate below the 4GiB boundary. If
> +      RELOC_ADDR_TOP is enabled U-Boot will look into the dram bank config of
> +      gd->dram[] and try to relocate to the highest available bank. Use this
> +      with caution as devices that can only DMA below 4GiB will misbehave
> +      since their buffers may be allocated above the 32-bit boundary.

Can you check the rendering here? It seems that the title will run on
to the text?

Also text only covers the default and RELOC_ADDR_TOP, but does not
mention that boards can still override via board_get_usable_ram_top().
Worth a sentence, since that is the other half of the new behaviour
from patch 5.

Regards,
Simon
