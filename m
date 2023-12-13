Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2B3C4167D
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 08:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 016A687463;
	Wed, 13 Dec 2023 09:28:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mu1ZR1cm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59C3A874D9; Wed, 13 Dec 2023 09:28:31 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D60F871D7
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 09:28:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b9b6ba42a4so3038759b6e.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 00:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702456107; x=1703060907; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CfA3GmZAIjxdzpQcDQw84ZSpmc1GeKgE3BSkLN7k5oM=;
 b=Mu1ZR1cmkhikguZGKSPwFKEv6ml2E1HpUiBRfe3LkIG0GTsDAKO+pc8Yda7ADuzuWS
 2BNvo9V3UDk15kyzophREQKRJJsDqU5f9K8zk7DF5jeOkOBxZ81H2AfG2wIOYdmY5fJL
 mIpWxors1UXFUxlPet+wNu5b4jLCEedQdnWSVQVUDIW02FGeZQ0dSIVBhdNu2RFFK8cO
 v9mryk7GvAkdGKZIUfgpCPOlDAE8GcdgxwT4czAkMnuezpsgTNrm5bSePzuD5ort8nmA
 aRngr9bDkY5KJ0ujqTl5AqkXidlNYiGFnwAP1CZl4GS2OTKJgyp4jWV18DIh5yKY2vM+
 w3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702456107; x=1703060907;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CfA3GmZAIjxdzpQcDQw84ZSpmc1GeKgE3BSkLN7k5oM=;
 b=efSdqjl7w/6ofR99U4NRT/WZN/q6OAvUgHrg+6umQq02d+zSIMY4xXLtXiHF4vsDSg
 d5yDk6WFMXm30lZSA1AW3an9Rv8X8NjxX5SCIexk0M5e1O7CLGpMjrJ0BNsngHRn0anT
 78GCWn2aBVUXidJZRVix0kswA7RzHNov4hndfJqgaym58ZVK2g1tHoQeYBP1y8vN4h9B
 Q6v/+Od7+SofUsfie1JEhH0olcDanAQgIGf3306A7loh1JdqjtJ6gim5J5Id4B7O0Dn9
 lQoS8dXwT1N3FGkh3FBE3Mc7lFLFa13ypaShE3mjiGpG0AZeJGMeUemfkWzqjIzS5ntD
 S2hg==
X-Gm-Message-State: AOJu0YywyWg75t8Xc8HudSnbda8LrLvRLaiEDxi5fSHwgyklTrvVfSKV
 iyFaq4iuYzs3A4VTkyR9G+6W40rh5t69qMb20yM=
X-Google-Smtp-Source: AGHT+IGlga1HgcRM4gwUuDp8Nn5LM8PWlL8+2ANQPxYWvuBDJc1mQDroyY7UpNECiGuE5fHrfb5dfLxuh8yAJgWNv54=
X-Received: by 2002:a05:6808:1b20:b0:3b9:e765:6990 with SMTP id
 bx32-20020a0568081b2000b003b9e7656990mr3990769oib.28.1702456107468; Wed, 13
 Dec 2023 00:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20231130201352.6379-1-semen.protsenko@linaro.org>
In-Reply-To: <20231130201352.6379-1-semen.protsenko@linaro.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Wed, 13 Dec 2023 17:28:16 +0900
Message-ID: <CALrBrZ1oqd93DWGTX5G8ibsjsBQma-VUBtsZGzN=WfJkTesDew@mail.gmail.com>
Subject: Re: [PATCH 0/7] pinctrl: exynos: Prepare for other SoCs support
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi,

2023=EB=85=84 12=EC=9B=94 1=EC=9D=BC (=EA=B8=88) 05:13, Sam Protsenko <seme=
n.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Some Exynos SoCs (not supported by pinctrl-exynos driver yet) have
> different offsets and widths of pin bank registers (i.e. PIN_CON,
> PIN_PUD and PIN_DRV registers). Rework pinctrl-exynos driver so it
> allows for different offsets and widths of those registers by adding
> the corresponding API. That makes it possible to add the support for
> new Exynos SoCs in pinctrl-exynos driver.
>
> The main patch in this series is:
>
>   pinctrl: exynos: Support different register types in pin banks
>
> Other patches are just related cleanups and refactoring commits,
> required for the clean implementation of the main patch.
>
> Sam Protsenko (7):
>   pinctrl: exynos: Improve coding style
>   pinctrl: exynos: Extract pin parsing code into a separate function
>   pinctrl: exynos: Rework pin_to_bank_base() to obtain data by name
>   pinctrl: exynos: Support different register types in pin banks
>   pinctrl: exynos: Refactor handling the pin related dt properties
>   pinctrl: exynos: Reduce variables scope
>   pinctrl: exynos: Convert to use livetree API for fdt access
>
>  drivers/pinctrl/exynos/pinctrl-exynos.c     | 125 ++++++++++++--------
>  drivers/pinctrl/exynos/pinctrl-exynos.h     |  36 +++++-
>  drivers/pinctrl/exynos/pinctrl-exynos7420.c |   2 +
>  3 files changed, 108 insertions(+), 55 deletions(-)
>
> --
> 2.39.2
>

applied to u-boot-samsung.

Thanks,
Minkyu Kang.
