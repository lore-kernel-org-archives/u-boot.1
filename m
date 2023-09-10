Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606DFC71153
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 22:37:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BCC686CEB;
	Mon, 11 Sep 2023 00:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="DFx4zygz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4873686CC0; Mon, 11 Sep 2023 00:37:06 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF49186CC0
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 00:37:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52c9f1bd05dso4983251a12.3
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 15:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1694385422; x=1694990222; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DpAY7TBeidgDdf6WBGV0I2F8+pC7om9wQu22KAQvKxw=;
 b=DFx4zygzrDCAgu1cJIxKmem0dHuWlIycoBHYwuHghhlbF5aCTrfPRWA9+HvkmwlA36
 6RZHFW/XBlF/AT8iqzdRGYSByls9Y7FuGOdBw3O2bA9OsS02iwzZNONK9CpPQ3vVTOjM
 cr1YLBQXvFC5f2YlsdU154AE0ZeLS9zzg2f8bYdL5QUg301Ff1ly9oLNnUKF56T/NTtu
 SVAqgNMJg6zSjjDZLxLW55cIH6n0QMOdQxgWNOYC2zi3GDE19uydAYs1Xa8loPusWteq
 x1dUkvx/KvYg7XSqDGOenRp+05j+C95x97zbOOdhRWgi7oBBpC19ARWPaQuBQSFi9apm
 wgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694385422; x=1694990222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DpAY7TBeidgDdf6WBGV0I2F8+pC7om9wQu22KAQvKxw=;
 b=npg6Xt/T9p8olSqK77mkg/QbnNBufjxDB1OQvLkkA0Ujs/E6745j+Ks1vSUpYE3v/x
 8eIvay/T76R51Qj2OV8KbugY6ei2Qln76qgAptNYeLkve8yBSmh7wF/pLHRdISp2D7wC
 2mjq62NTMCs2sZqRErPKwlR4EsoAuyHXdSxUhYz3U6J5R4IyGY/YMdHqyPXf/TkoBkKs
 VUwICWfqU5jbCsz1zCYZuVGN35dbQMcs8f+0vDyzLmxBnOcenNeV5g4gtYtO0ki/h8Ft
 c/M/+wnupakYYpaIUaUKkqFHo7lbryh12r/jCnQxGRqvTwapO+ptOB+FpN1xxjUyLJxR
 btxg==
X-Gm-Message-State: AOJu0Yw38KE32q9bDWbjnBoJwtRUGqdnOQW7KdDDvnZ7npgjcjXh1SOa
 3OdktxvnbaFud6YRiIncYttGuAc85gjnY8fRrO35CQ==
X-Google-Smtp-Source: AGHT+IF701vfxOYSlv+ykQjhq+X2CsOjI83MebsyRXQFch6jtbkVBrOh6ZZghtn5sU4IHqN/GC9+PKqJFakGJG6uw1g=
X-Received: by 2002:aa7:d0cf:0:b0:52e:585a:e95 with SMTP id
 u15-20020aa7d0cf000000b0052e585a0e95mr5697280edo.2.1694385422344; Sun, 10 Sep
 2023 15:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230906-apple_t6022_m2_ultra-v1-1-7d28623285bc@jannau.net>
In-Reply-To: <20230906-apple_t6022_m2_ultra-v1-1-7d28623285bc@jannau.net>
From: Simon Glass <sjg@google.com>
Date: Sun, 10 Sep 2023 16:36:48 -0600
Message-ID: <CAPnjgZ0aDxNsqKzWcTDOq++4vC4j_VRQNqC0=LiL3As0d0H7Bg@mail.gmail.com>
Subject: Re: [PATCH] arm: apple: Add initial Apple M2 Ultra support
To: j@jannau.net
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
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

Hi,

On Wed, 6 Sept 2023 at 15:50, Janne Grunau <j@jannau.net> wrote:
>
> Apple's M2 Ultra SoC are somewhat similar to the M1 Ultra but needs
> a tweaked memory map as the M2 Pro/Max SoCs.  USB, NVMe, UART, WDT
> and PCIe are working with the existing drivers.
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  arch/arm/mach-apple/board.c | 183 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 183 insertions(+)
>
> diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> index d50194811843..47393babbc62 100644
> --- a/arch/arm/mach-apple/board.c
> +++ b/arch/arm/mach-apple/board.c
> @@ -444,6 +444,187 @@ static struct mm_region t6020_mem_map[] = {
>         }
>  };
>
> +/* Apple M2 Ultra */
> +
> +static struct mm_region t6022_mem_map[] = {
> +       {
> +               /* I/O */
> +               .virt = 0x280000000,
> +               .phys = 0x280000000,
> +               .size = SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {

Is there no devicetree binding for this information?

[..]

Regards,
Simon
