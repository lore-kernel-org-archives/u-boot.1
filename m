Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBB2CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 04:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC3D1839A8;
	Wed, 27 May 2026 06:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LNcR4mrJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 837E583FF5; Wed, 27 May 2026 06:59:41 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DB1980433
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 06:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bdbac72ac1fso1144319066b.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 21:59:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779857979; cv=none;
 d=google.com; s=arc-20240605;
 b=gqar7yzDCja/7Zx9AabLvgGS8ugeBd2PrAThRZ3CfwerqlEC9iV/LqeE4mcVbKiqp0
 GKvXnafh/zSCGRi9qh0HcPcW7hvU37jkWPd3VtBpHW9FLPYqqarwzyEZwBfvWjiqntd5
 hz2VhCRyIDVO1OxQEPgS5QcR1DyagbNnVn1E81OsDtSGVBLCD5qmKRnYChwmAO8pU419
 kTuKNFFeaquJvya0HOs6WH0uDmNbgdW4FHzFyYo9b62fi5pyApB9XnjZQ/9VCjZoLcpu
 uTI+gqEJA3JfGFnZ4/G3TpwFlWLez0S5Zj1HqG5qttVvsAFJ/AqOCucjZf7ZIhayNvZF
 +EQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/V8/PPJ1FsELQoX0vAQH2WSDkDLr5C052tkjmNOOl/k=;
 fh=6w0gPzCwrwHFYHgKMMcY2pyn7gpS8Jn8cHNTnCVVozY=;
 b=NiiVWKsMOkEQ+IxTVk6BCd53IpPA4Qcx4ySzz3qXm9kWkENnJfCyGMsOwb5jDxm4mo
 BVwybP9vmkdnM6Sn7bwl4n+ZFkJZbWorgXksbw7pTeCkwoeAJG4bKoBnNAqRtMvjF/cb
 R2iWZbY7d6mIX2BTcNL7I1eDuZ934ip6zVWHdET0VDl+PuWKk2PYb7einEOwMSFCohoY
 b35n6WZKymY9MSR9ivC+wiYQNW8QQvKMdi9D160twiwjunU7D9CfNEN8749V8bO6pPD3
 cgV3YFC012L/Ai2gjXHPdXFxapAW1QenSMmBsVULnZ4tKS7gljKKT+j8i086ub+q6RTO
 txuQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779857979; x=1780462779; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/V8/PPJ1FsELQoX0vAQH2WSDkDLr5C052tkjmNOOl/k=;
 b=LNcR4mrJ5mdIwbjszEY8VqgTtzjb8Qqg+IJX0eFTDKCBUyRrZi+YDhTzGcdTB3tSfX
 vAik+NwQk223NgXYHFZbBR4r+op8PAE+2XCKmVhwIaFWqQiVThpc2xR348xXV1tKXRyD
 8UvD90rBmqr3EFYKkHpQbAAwdgwY7vFAUXb+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779857979; x=1780462779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/V8/PPJ1FsELQoX0vAQH2WSDkDLr5C052tkjmNOOl/k=;
 b=qpsauUER7hgpRtRGB8BASMsx4OGLJ8Ozds23qDQywBW6PmPVWAEe3MjgIq2ACK3hWI
 m/0tIwPkIQ+FexU8oUi0zirq3T5XE7bxpVr55xxdkbIfqbx+Ma9ZoZ4nxx7gkk+ktyuf
 xtsc14uYMSwglK7oZruCF3OnyJv+kYI8WbAF2bhCAVmZT6p/Wy/JvNOdIsqftmYL5aFu
 BkIp+gkR5p5ncVAeG7TYMulGB9lrRCWy5mY3Frn/4WdML4dZL6EG0nC+yPXMkzJTZ8o/
 WX22ktXOTLX/j/Zz1Jmv+eOeKr9c8HKkeuCwTceTT5ZQbiU/6mARFuOmg1X1OfXASf4D
 Vkxw==
X-Gm-Message-State: AOJu0YwqsU5hAaWlDtzzFDgVwpAC91DTeRPJehWZVsksz67aaLVc97Rl
 69eGoH7PKujyZ8a4gu50mTrFM80FLpJvkITZ/tzqOA1AyoLRh2grEeybJMnQVqc5YSOiWVt1+Yu
 Oz4SGulBkXSX6WHAGwhIM23ca4WhLCV1UDfJhCZND
X-Gm-Gg: Acq92OF/RwBSd1D1lBWmuVD3ccHfwGODhOjbeT4NzlWAFCaq7djrAh2seLrIUExozrb
 6FOWYzdZYEdJY+Jd1NClAzOV3iBxD+7Avkyyfr6hkFVRLJ0WNuiN1PZf6TOVgibwaUSkFpCVGzi
 J3e7mKEdcwDgdaCgvhFuLg84euQQb6zoyBtRZmMcghIoEKId0OX618BOWDcNgG02dNr4PLhSyhE
 EsHTiIcuYni2BAM6N5VbYguXFB8kXWh256TS3jrg9R6vg4BvXeqfaek5RadMN+IV69HkichwKa7
 1Ravp+APfpMAynSpvQ==
X-Received: by 2002:a17:906:6a0b:b0:bd5:2c3c:616a with SMTP id
 a640c23a62f3a-bdd264bf82amr1248496766b.37.1779857978785; Tue, 26 May 2026
 21:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260520044554.15373-1-aristo.chen@canonical.com>
 <20260520044554.15373-2-aristo.chen@canonical.com>
In-Reply-To: <20260520044554.15373-2-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 23:59:26 -0500
X-Gm-Features: AVHnY4IbJnH-f5YEc7xWka2HLDJEBdL81znlXEGglk3QlFWXw_qXKs1hns_O7bc
Message-ID: <CAFLszTi1hPmXbDa+8hBXVU+oLxgwC087Fr2uafdcu6ViFxasYg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] bootm: fix overflow of the noload kernel
 decompression buffer
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Benjamin ROBIN <dev@benjarobin.fr>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>
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

On 2026-05-20T04:45:49, Aristo Chen <aristo.chen@canonical.com> wrote:
> bootm: fix overflow of the noload kernel decompression buffer
>
> For a compressed kernel_noload image, bootm_load_os() allocates a
> decompression buffer sized to ALIGN(image_len * 4, SZ_1M), assuming the
> kernel compresses by no more than a factor of four. It then passes
> CONFIG_SYS_BOOTM_LEN, rather than the size of that buffer, to
> image_decomp() as the output limit. The decompressors honour the limit
> they are given, so a kernel that decompresses to more than four times
> its compressed size is written past the end of the allocated buffer and
> corrupts adjacent memory.
>
> Pass the allocation size to image_decomp() and handle_decomp_error() so
> decompression stops at the buffer boundary and fails cleanly when the
> image is too large, instead of overflowing. The regular non-noload
> paths are unchanged and continue to use CONFIG_SYS_BOOTM_LEN.
>
> Fixes: 69544c4fd8b1 ("bootm: Support kernel_noload with compression")
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> boot/bootm.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

> diff --git a/boot/bootm.c b/boot/bootm.c
> @@ -635,17 +636,17 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
>       load_buf = map_sysmem(load, 0);
>       image_buf = map_sysmem(os.image_start, image_len);
>       err = image_decomp(os.comp, load, os.image_start, os.type,
>                          load_buf, image_buf, image_len,
> -                        CONFIG_SYS_BOOTM_LEN, &load_end);
> +                        decomp_len, &load_end);
>       if (err) {
>               err = handle_decomp_error(os.comp, load_end - load,
> -                                       CONFIG_SYS_BOOTM_LEN, err);
> +                                       decomp_len, err);

handle_decomp_error() prints

    Image too large: increase CONFIG_SYS_BOOTM_LEN

when uncomp_size >= buf_size, which is the path the new test
exercises. In the noload case that advice is misleading - the limit is
the per-image ALIGN(image_len * 4, SZ_1M) buffer, not
CONFIG_SYS_BOOTM_LEN, and bumping CONFIG_SYS_BOOTM_LEN will not help.

Worth either tweaking the message to mention the 4x noload buffer, or
printing a separate note from bootm_load_os() when decomp_len !=
CONFIG_SYS_BOOTM_LEN. What do you think?

> diff --git a/boot/bootm.c b/boot/bootm.c
> @@ -623,11 +624,11 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
>        * Use an alignment of 2MB since this might help arm64
>        */
>       if (os.type == IH_TYPE_KERNEL_NOLOAD && os.comp != IH_COMP_NONE) {
> -             ulong req_size = ALIGN(image_len * 4, SZ_1M);
>               phys_addr_t addr;
>
> +             decomp_len = ALIGN(image_len * 4, SZ_1M);

It might be worth updating image_decomp() to take a ulong size, since
now a read per-image size is flowing through (perhaps a follow-up?).

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
