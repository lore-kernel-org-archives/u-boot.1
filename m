Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566A0E77183
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 16:28:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FAFF80369;
	Wed, 11 Dec 2024 17:27:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T+xT6EPJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6A0680377; Wed, 11 Dec 2024 17:27:57 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E351D80323
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 17:27:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5cf6f804233so8817118a12.2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 08:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733934475; x=1734539275; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J7gzOt7YQvSVi65nfVvWSOWhbm0NljyQzKJ5ZudAGC0=;
 b=T+xT6EPJfQKkJT5iZE40iSSH2fMftmMaVWgDgkbUhkCZKMyubMKS8HQpFQEb/WlB2D
 IyzGW+wJy0E4c9b2RyhAs63xJrEf6bj0l8Jo5jSZA+yqOe++sCdpCOkqRUzIZ9LzGNzJ
 3+/CXoMw373eFs8RG/V28rHOwNqsDHa+hATqHJfa/Xk0WNLeBk3pFXPmcje9zWXHpsD5
 Ureddlc9hMT7IfRGopNph438PMqpcNyh870wEWGCi9ro6xXd2cxrr3+soFZksLItNnAJ
 UePKAKtF4WwkWMlL2kd5qxNGv0tl5AQPCtwJgoHs/NIiRVq+RZuzK3HqXDKYp3ouU3po
 aSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934475; x=1734539275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J7gzOt7YQvSVi65nfVvWSOWhbm0NljyQzKJ5ZudAGC0=;
 b=ghinRolrwlobfDsgYqsUXmsTe0+gt4fqX964XQuEwoJon5mVcY+qaW6hpqCtxSS9YJ
 aghfQeAXvZ/Cotbrj0/kLFqZ/ru1JzCmtVXCZWnWaidAk2Dbb2C0dlepMSBBX9l199mK
 JRrMnv2C7WzYNLhY7DAlwEIcnLPc3Xa9t7skFvfxd+J0TKWJvQRkpc9oPVBZ71BuOH7O
 Vj/XHMoe2qwMXOVo63R1D75vJcEQRx4qIw+ElP4ndHkUdh4fI59SYxiSg5GVbyzt8CoY
 pvSbHQQAbIoxGHnJw9i/RDFBvX4hUCvfwsy6Mj1fF4GrytF5/eBCg3FJdwmCLA4IH8kJ
 MCyQ==
X-Gm-Message-State: AOJu0Yz7b0P4gVBR8qrkYtNxFSlbNen5SXN2j18n8+2VKqiMnVDFTq/7
 B7iFzhy8VyYeRIPvutB8H5DR+r+xgsP1ZFnR49UMQn3xf7qsWFbk3LWKE1mZvk47hci1AKGQpIF
 Ncw0SXLETSjbsMV4j9I+CinMe3RU=
X-Gm-Gg: ASbGncsERQrmnDC6OwphBPtPUFuTALCbQFfE/00LLC92vEwkoA8HE4yF7eCNMlOupJI
 wy2QYFOBoyQUImNfodIdg+scQ2oHA0wn03ks=
X-Google-Smtp-Source: AGHT+IEUjSVxietPMUxkIX9N2sq2LuDTCnCP9uO1LRDazDseSDf6/G8PandMHxo7ZWnsj4LxYjM7gXNQjdWwX+HuJwc=
X-Received: by 2002:a50:9eaf:0:b0:5d0:88da:c235 with SMTP id
 4fb4d7f45d1cf-5d4355ee396mr2489757a12.31.1733934473744; Wed, 11 Dec 2024
 08:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20241209195528.730260-1-sjg@chromium.org>
 <20241209195528.730260-3-sjg@chromium.org>
In-Reply-To: <20241209195528.730260-3-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 11 Dec 2024 16:27:42 +0000
Message-ID: <CALeDE9P3GJitSOCA3w2RfZc-nJp3zdYQgz2rpg_CzCbhep84Ew@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] rpi: Set bootm_size to 512MB
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>,
 Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Mon, 9 Dec 2024 at 19:55, Simon Glass <sjg@chromium.org> wrote:

> Set this option so that all boot images stay within the bottom 512MB of
> memory. This should allow us to drop the fdt_high and initrd_high
> options.
>

How does this work for a device with < 256Mb of RAM? There's a number of
the original RPi series that have 256Mb of RAM and that equates to less
than that due to reservations for the vendor firmware.


> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Suggested-by: Tom Rini <trini@konsulko.com>
> ---
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
> + * Limit bootm_size to 512MB so that all boot images stay within the
> bottom
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
>
