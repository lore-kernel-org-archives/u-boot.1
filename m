Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8C4FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 960448394E;
	Mon,  4 May 2026 14:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ORfGT7Hb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05EB48394E; Mon,  4 May 2026 14:08:57 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D02E80F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bc23bebd345so141747866b.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:08:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777896534; cv=none;
 d=google.com; s=arc-20240605;
 b=Wz0ywt3O5ZrW2/ol6Rx6+/6wNUWc+Qpo9H18QpPwIjL031gHmEV4QwuEpRWtoogzVk
 fvh47gfigqx3g5J4kXhPZwZl5N3S8KqJ8vda8fbTT7OTP8dHcNuletLbTsOInU/veAjc
 /0xp+kpUQ5IQdHes4bTMjugYEWoXPoHvovGMsqxWI3T7GnH70klNVeKzSM4cGUqRl9ST
 PechgRfLSmBfk2ijwsQAlA3oU+j8NPJrhSxFQh9i7EMa/1nu0bciz7usWDa7lABrtwSz
 rWg759dRDAyThVJkV2g6qDvOzSO4/qY2QvgGz7OZzTLBjYK5C2LEBaWhlTD3qBf6a49F
 gEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=loS/ShygW1TDKs7PArRXmNJmY+gC/O5fryPAy0cdg0U=;
 fh=PvMd4X2mdXT08JWfisjv9stH8Lx5t+gM5zKif/Je664=;
 b=GYCaN4vwe8kBJinwWddC3iHA68upv+DNeaaYguVan8hwtmM0C7Zb8VzBOQd3tnDUcf
 RLrWYuX/hAcC32k0NnC9CLm3uMad75QEwh59bUbrSAX0i04o5FTovR+lMNgBk78GveI9
 cBi9sNscf2NKbvQ1frHGp2rZfQk18HSzQg1Sz3O1KdLEedEp+f3REgPuB8pIfHI5wQW6
 3Zde8A/A0RbF0G0oSBVsEBMCuHZFkDVLqSYq+YNFf4LX+8ZyRv/ujuQL5sZ4/Q5zcYZZ
 js6exky6xguoeKu2n/+jJDY3sJjB+snP/nJDqQCFC+muXHTm9ZHbLomP4u+fVjQKAalc
 Quwg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777896534; x=1778501334; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=loS/ShygW1TDKs7PArRXmNJmY+gC/O5fryPAy0cdg0U=;
 b=ORfGT7HbypVhlpCawsO/uAefew4rlZBCi3M86Cxi1fgSkmx3uhg+qO5O8X6e71ZNXo
 Nnbea4C4y3anxmenWlrBtWyLt/R6OBUbu9bCftPcxj4FQImrdbAUyglbv4Q8ahxliyIC
 8As2ag+DbhD3yZSDNfYNYFarbZ181wC5VH+2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777896534; x=1778501334;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=loS/ShygW1TDKs7PArRXmNJmY+gC/O5fryPAy0cdg0U=;
 b=oHsaefgFDYzco73NM5KavMR9DI9WNxLR41O7pSRHY9EZW0NWyjz0ebmn4j7aMeKq78
 7z6aWJAp1wD2alUOpyX8hiMpnMHQ8iufkRfKUIUnRHBwiIpfMu9sUUiTREjI6b7c9mVe
 U3PGhth5Nos7DbDsBJ/4MdB5UqUNbjd9Q/Q/U/R5DhUOWhqloNBcaYk7jqWotJLPMRBf
 wF0oqr8xWD6RAZw8CSzUIoYUipmOeNtkcWAWvKddHTLUSVacxbHf1YleSkZTX7qzAxkD
 TF9UfBi01K1AE4K6Fiau1edRKfbQcdIMikGPeyMGbCHmpt6ApMU7BT6XyiA422cmXrX9
 ZlTg==
X-Gm-Message-State: AOJu0Yxu4uMD+yn/Cqg2KSLhJNN3ldEMiubB/f+PhL7z6GfeImMjp/ne
 N+6HPuAto3Gomx/WhSW1OP9z42HimQ97Za1v8QUOEf591pvkqQKkb3HyoNBUzmizHJW7K0FGyA5
 /22EpWL/S+FQSlAfpDMbbAINTDE/9rC7MeM5Lphm6
X-Gm-Gg: AeBDieuLKRXI0KP50lZnvBGxe1E2dKcisndQjnA8lXqRdo/XdzhvEULR+4Q3L1W986W
 aFScAntnCQC939EHX55aqrxzApcUe14UDHgW4B1T1hrySBOwiF9RMTdVmxWJWdQXzLe8d3phNJS
 TU9okzqx+sRCV74KOQEuRZcQLJ3L9ChgCdeR47i8Dw10Gbeg8CiRixitBv+zAcD4lTyg1VQtR4Y
 5jzsAwY9zVbxZ9wlpR4Y1wRVxC2K+8KG557uz/kYQhHoiBMiZa7qRFzfnyTQf9DB4GS6yeW5j2r
 Od9MqJW6+FfwrmuRby815lawUbI=
X-Received: by 2002:a17:907:9999:b0:bc3:6b6e:d4ac with SMTP id
 a640c23a62f3a-bc36b6eff2cmr50648366b.20.1777896534461; Mon, 04 May 2026
 05:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260428-spl_fit_full-v1-0-dde63beeaab1@valla.it>
 <20260428-spl_fit_full-v1-2-dde63beeaab1@valla.it>
In-Reply-To: <20260428-spl_fit_full-v1-2-dde63beeaab1@valla.it>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:08:40 -0600
X-Gm-Features: AVHnY4JiVF8ncEbzO7hPjFOfS2UWuAUDzgH1xzc6aWBgIk3odfavTARjm8o72c0
Message-ID: <CAFLszThh9zfED4VdR=vfkTisGMqdmRm26JtrJhh7rjQiLSn1VQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] boot: fit: decompress kernel when in SPL
To: francesco@valla.it
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, 
 Frank Wunderlich <frank-w@public-files.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Anshul Dalal <anshuld@ti.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>,
 Dhruva Gole <d-gole@ti.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Michael Walle <mwalle@kernel.org>, Marek Vasut <marek.vasut@mailbox.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 David Lechner <dlechner@baylibre.com>
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

Hi Francesco,

On 2026-04-28T20:24:41, Francesco Valla <francesco@valla.it> wrote:
> boot: fit: decompress kernel when in SPL
>
> During the esecution of fit_image_load() in full U-Boot, the kernel is
> not decompressed as this step is typically performed by the bootm
> command logic afterward. This is not however true when doing a falcon
> boot from SPL; enable the decompression in this case (i.e., if
> CONFIG_SPL_OS_BOOT is set).
>
> Signed-off-by: Francesco Valla <francesco@valla.it>
>
> boot/image-fit.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -2291,9 +2291,10 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
> +         image_type != IH_TYPE_RAMDISK &&
> +         (CONFIG_IS_ENABLED(OS_BOOT) ||
> +          image_type != IH_TYPE_KERNEL ||
> +          image_type != IH_TYPE_KERNEL_NOLOAD)) {

Since image_type can never be both IH_TYPE_KERNEL and
IH_TYPE_KERNEL_NOLOAD at the same time, (image_type != IH_TYPE_KERNEL
|| image_type != IH_TYPE_KERNEL_NOLOAD) is always true, the kernel is
decompressed unconditionally, including in U-Boot proper, which is
what the original code was trying to avoid.

I think you want:

    (CONFIG_IS_ENABLED(OS_BOOT) ||
     (image_type != IH_TYPE_KERNEL &&
      image_type != IH_TYPE_KERNEL_NOLOAD))

Can you see a way to add a test that exercises this path so the
regression would be caught?

> During the esecution of fit_image_load() in full U-Boot, the kernel is

execution

It is worth mentioning mention in the commit message that you rely on
CONFIG_IS_ENABLED(OS_BOOT) being false in U-Boot proper (since only
CONFIG_SPL_OS_BOOT exists), so existing behaviour is preserved there.

Regards,
Simon
