Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85133FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 06:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C565484683;
	Tue,  5 May 2026 08:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M28ti7ay";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BFFA84687; Tue,  5 May 2026 08:29:39 +0200 (CEST)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E67F8467E
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 08:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6587cee8b57so5304769d50.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 23:29:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777962575; cv=none;
 d=google.com; s=arc-20240605;
 b=bVKzC+FfizUV58QYK+xPeJ6rsRXn3JhH/cqfrn0kiyIpzrA7ClZ8ohe3GgnihjnUwf
 Ba4mfQ/HK+NO5zHbQIlsWrO1VQEOanuoOkdwo4CL9qopIQfYbNdcb742XA2M4x0zbKBj
 Qegan3P+dUHeEjl3CegTQk9OdCHStWvziHpNICoruFmAqmyKZNSAc2gtUeIHJRrycC8/
 qUjhQOFz+6mbnhyf6MZEROmqVo4dyQfsfxv9O/8F754stEp5d2V5XHt2Si0K79yCnp+W
 SzF2yUMzcJC/vJhpd9Cho9TA1WO5lPzB9sltbyhQKOkMtHUANkaNFQ6ix53wmMrIOujI
 vG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Q+RwWTiXTPpegsi24k/1D0ZezCBwQxGPgT22hOVPVr0=;
 fh=4OUB9wDcqy9KqRDXB+bTp0TTfz6LHJD4qhdKww9bEBc=;
 b=T7J949HnPT0t4Jb46KyF7OrO0VO6WLXok0GgwKnJM8W/b6qO28tvHHyrUq7TJYhh+G
 UYoNUQes/HV09lxoqy1F/rvyWWYpNBNJTosAq4SIlyY/bdqEjK0jMyXPD3+Jj7YA275L
 575rL319O6TcOZHqmGiCVP6t6M+fY7ZBRPs9fZSvUXLHqP2+NNFZkgpk1heyBR6UE3h4
 9n91zWOoqUVTZlkAsT8ju9tXS87hk4OI0Sbm8lxTWY9x33vxH/L2ac71G2AykTAaHfw6
 7mIH6B8JT/4Xq0lXtBKODkZp8HHdBRnnPc7BTRpxgySIBGtvzCP0gF0rJMgGLdfgBwNj
 SXlw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777962575; x=1778567375; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q+RwWTiXTPpegsi24k/1D0ZezCBwQxGPgT22hOVPVr0=;
 b=M28ti7ayJHy8z2KDPg26IbdNxoWMrblQCYn7aeM1qCYy+MX4llN5yd+Lqqlp+GcHaS
 fdBuAofuVoBPsyJ4gxtuSii9XIJh5r4hvYXdlO+GbeuURJMEAHoMjqrpRa4GO+ZmVMMF
 ULlsMC3T9yw9iQmlSt2FwGjOsEPOIAAhr7qVSyMCuIwzIDXPJGtN5DFDUActwMFUWvbV
 vq2nj6EfgECGW3b7QRTLOQCWNbi5Mi/wQguHlDI/9NATUId7j4o9eHigCmEfdSKwVAWY
 PqM2b+9jPAM47PPRH2lvdyQKqOFE7IFc7w1sQRJhZmHzpGbbTvy0Xj9pN8HQnbWEoXwo
 u7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777962575; x=1778567375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q+RwWTiXTPpegsi24k/1D0ZezCBwQxGPgT22hOVPVr0=;
 b=LshRIb6A23IfH8yByVvZ/qlBi3S3TmyHMW7wpuCFKKGfFo6S8HBgiD8u5cHjibIt2B
 cJ5iu/TeMM3cagIipfjGv6a029jlBkXwd9nlx12DenAeCgvzZHl92/S9SZHiOg9tWyLL
 YTJsKYZpG6l+z4JQFeH3zCEloUzWZKgViI7BB2tzyahJStONo+bd2O9Pw18xbsNMNVOO
 PIzl0NuZruI1cbQ/5JS+k2uoWEW0bWRd4qgiwVHQhgH/cz6LEF9hkEoCK7POa/Fq3m4D
 pcPFbd23UBiNJzKfQmGk/QTQw/HQ9ycUkcEapKNjz0cSY4o5cTexq6ioBn5No8eKuUkq
 cNBw==
X-Gm-Message-State: AOJu0YwH9Ykyj8qJ6EMRF9krgmJAypZ+tMnXYCcIC7FA51M7NVijXBSr
 VlKymKzOdlrseN/pF8izKiMO7lxuW1RbZ/ovGdKXnvAj20cwdewxSCbJ+Whny9/+HjeXktftQCA
 P4IkL+9jmToaL2yzatUiv9SRA3wFFmiJjPuBbXapP1Rxq6XkRRv0Ubfc=
X-Gm-Gg: AeBDieuS+RP0h2mIva8zwBO/FaGJSUAgVALhH2c2FuFcuV88gIQsgazL2ay1UvPRoC9
 oDFKsdxxYG/yuj9Q3Zlf7igwGBznZzcNb4nsOdxFBu4tbUnbYXP8WowB0/eeKzLLkuJ3aMrjOUA
 pTsRdXtdJIlgD5nYCiJaV4PZQevDNCD/zZ4GG/nU3je5tDYptk2YFcn0V/UCdEwSH9PReaYWxm0
 dK7SQqcV0EtOzM3gH26GmTprMynQGPpXCjZtc7BrnL/61FWx+jpH2kcJjBAXYuTD9jJjLFTWvkm
 WUPuPFmMbIqv/2a8IeInFPXTJciihgu7N7bBA2N1mGbJYJqpHef8LjA7FJiXMe4MxV8xnAckYGD
 rk3AXquSL+z2NyRPJBFbuc7cx8JVZl7bK4ypSsLG5S5qqJd5ki9jq7zgRpM2hxDQWwugktSkpm2
 qDkE29/VphC/VpOZOpDNSHZ6QTY9eXk3KrDg1hllQd2/96Qvztu0y7w4S5bzKIV40CLZidZtGWV
 NR4fxJrPtEFa4lOx6D1Z9TA1tdOzhrBWansegQ5qDia6dpdG13IPj9+H3BuYIOQCvRxVKECRBB1
 /7xzXN33PiUonllZDfQC7MJbkbzFz1m8Lr+nQcDGqQZXlCRDCLZGJ4ztpxLULXPu2Jt6MKO+tb5
 6Tvik3sw0HdcVEudY
X-Received: by 2002:a05:690e:38a:b0:65c:5bfd:b205 with SMTP id
 956f58d0204a3-65c69f751d8mr1499429d50.62.1777962575198; Mon, 04 May 2026
 23:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260430113937.1274693-1-sjg@chromium.org>
 <20260430113937.1274693-2-sjg@chromium.org>
In-Reply-To: <20260430113937.1274693-2-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 May 2026 09:28:57 +0300
X-Gm-Features: AVHnY4J5Fchptx2aUw4l3uHgayp4o9HiWyaZTxzOxAmL4X72nRc3TG9UAo5IkI4
Message-ID: <CAC_iWjJfh3CnYwinvicDi_-SO_XntcxS1HE=p_cUzXfdAqqC1g@mail.gmail.com>
Subject: Re: [PATCH 1/2] bitops: Guard GENMASK and GENMASK_ULL against prior
 defines
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
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

On Thu, 30 Apr 2026 at 14:39, Simon Glass <sjg@chromium.org> wrote:
>
> Some headers - notably the ec_commands.h synced from upstream
> Chrome OS EC - define GENMASK and GENMASK_ULL themselves before
> linux/bitops.h is pulled in. The unguarded definitions here then trigger
> a 'redefined' warning at the second site, even though both spellings
> produce the same mask.
>
> Wrap the two macros in '#ifndef' guards so a pre-existing definition
> wins. The U-Boot expressions are unchanged.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
>  include/linux/bitops.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 29e0da48de8..8b381c916cf 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -26,6 +26,7 @@
>   * position @h. For example
>   * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
>   */
> +#ifndef GENMASK
>  #ifdef CONFIG_SANDBOX
>  #define GENMASK(h, l) \
>         (((~0UL) << (l)) & (~0UL >> (CONFIG_SANDBOX_BITS_PER_LONG - 1 - (h))))
> @@ -33,9 +34,12 @@
>  #define GENMASK(h, l) \
>         (((~0UL) << (l)) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
>  #endif
> +#endif
>
> +#ifndef GENMASK_ULL
>  #define GENMASK_ULL(h, l) \
>         (((~0ULL) << (l)) & (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
> +#endif
>
>  /*
>   * ffs: find first bit set. This is defined the same way as
> --
> 2.43.0
>
