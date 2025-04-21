Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24941C369C2
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 10:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93F0D817C4;
	Mon, 21 Apr 2025 12:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lnMsgHBK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E490981F0D; Mon, 21 Apr 2025 12:10:01 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7A21810F4
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 12:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9eb1eso3544770a12.0
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 03:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745230199; x=1745834999; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G3b2NyfjciR2FYIyqJR+nAAZCgKCCpol1vOjg2PUeMk=;
 b=lnMsgHBKcoJ9qSNRJJOAZx5XbICCDj6dLpg7owuO4jqDNfGWyI4Z9+0A+S/rzyjgmI
 ZtkfjyzMrsO8ik5HluS+SsNnE/uYd7MwRK4TxAJVtI/5nRWrXjH7uVEINCTyMfbI0tvz
 vENkBbF3vQW2SLQHu1FuL+41P4sHZG1+nu9XGu1B9zPkjZljugvRwU2l4FCh/XLQkpHR
 gaQX5ZhomWWC89z3Em+SIFl/35xfRU7yc9PkXWrk24PYTIdVNskOiRkZd4OmvYBitsBs
 CPtFIcse2eEq9GRisJBPIvS2XBlhalMbXvtFHiWmHFUOzzOhu9HKsGDcckhfFep3R4iq
 oHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745230199; x=1745834999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G3b2NyfjciR2FYIyqJR+nAAZCgKCCpol1vOjg2PUeMk=;
 b=wYrSexKgHQoOd8+wPF8HSlrd6azyltR10TdjHnH3kvA0fOaPkFoCs8g9Bp1WODSAqC
 aGKfJJXY27j5ZuAm63mAQcxCtJKg/8oEbgHUwpZ2sFiv7UdMA3jxJvV2fxfrRkMQ0P1F
 1BIGlMWQ3T0+IL6gxIxwD2LKJWY5fwXAd79yoTcV/Q5f9r/Z0s6x8PlmXlNc178nXNxG
 1Q4dWYFCYyB1bWxKxLmRch/SU+jJiRJWr8aY1b+NAPvtnO0nuRb/eNRrYXLHGbGUNzZ8
 7HELiAfLs8e6hkLx3XIsPCyKZLFXzKrBnQrJl57MN8Fm6iGUCUTpLf8gMkCJy2MB3pBn
 5X7Q==
X-Gm-Message-State: AOJu0YyR4p7KrcRqfhHzdW0EBBSGQ8VpjsXEL8U+Nqd+MryR3xzeMJzV
 LjFsXJqBfhX+YW5uE2+V238E9efX3YPFVGeJiGurZiqD94fat4FLzcA7qzmE/xdvzw/lQh/09SM
 3NkOyVA6LK29dJBZBlgRi6c5Y48s=
X-Gm-Gg: ASbGncvRFrQ89nS7rG4fzNY4DYsVyOb4ji7qmIUmoZ2D+NxJ8jzO/NW+AKxTmFKUqhF
 Q0OtFno3C2QWNYH1X8ll0Axqafv7FiOjCgSrjfQnrmKkxahJcTDXOtOlxJqwxES4KlAAKh4c5Vz
 j096D30/aoBcHvWs0A1APrxBOSmnDx8Hqwwd5JTS719d2Cb7Amog==
X-Google-Smtp-Source: AGHT+IGG0IP67IUII2i9LpjrSsjwEdwrlz4I49VoXfWehj1t1nyF7CuJqggm5eW6x04FGU+6dOXvjnqQgWhWjTddKHw=
X-Received: by 2002:a05:6402:26d2:b0:5f3:4606:14c5 with SMTP id
 4fb4d7f45d1cf-5f628593ab2mr9467409a12.15.1745230198798; Mon, 21 Apr 2025
 03:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20241220003447.2913443-1-sjg@chromium.org>
 <20241220003447.2913443-3-sjg@chromium.org>
In-Reply-To: <20241220003447.2913443-3-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 21 Apr 2025 11:09:47 +0100
X-Gm-Features: ATxdqUEX3xAKGa1i7fEA-Otch7jYjK1y-W9oYwtkOXYGAv5COO1JfM-DvBXtats
Message-ID: <CALeDE9MC24ju4MAZ4bv6WnMHOwywzh=F+j-Ln9j+bfFQMkzFQQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] rpi: Set bootm_size to 512MB
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@wwwdotorg.org>, 
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>
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

Applied

On Fri, 20 Dec 2024 at 00:34, Simon Glass <sjg@chromium.org> wrote:
>
> Set this option so that all boot images stay within the bottom 512MB of
> memory. This should allow us to drop the fdt_high and initrd_high
> options.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Suggested-by: Tom Rini <trini@konsulko.com>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Add to the existing comment block
>
> Changes in v2:
> - Add new patch to set bootm_size
>
>  board/raspberrypi/rpi/rpi.env | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
> index 30228285edd..a327fccc77f 100644
> --- a/board/raspberrypi/rpi/rpi.env
> +++ b/board/raspberrypi/rpi/rpi.env
> @@ -60,7 +60,12 @@ dfu_alt_info+=zImage fat 0 1
>   * Even with the smallest possible CPU-GPU memory split of the CPU getting
>   * only 64M, the remaining 25M starting at 0x02700000 should allow quite
>   * large initrds before they start colliding with U-Boot.
> + *
> + * Limit bootm_size to 512MB so that all boot images stay within the bottom
> + * 512MB of memory
>   */
> +bootm_size=0x20000000
> +
>  #ifdef CONFIG_ARM64
>  fdt_high=ffffffffffffffff
>  initrd_high=ffffffffffffffff
> --
> 2.34.1
>
