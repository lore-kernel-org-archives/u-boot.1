Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91DAC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A46F84B92;
	Wed,  1 Jul 2026 13:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="it0obklP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09E4F84BF2; Wed,  1 Jul 2026 13:59:04 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7ACA84B62
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-695f6438518so918143a12.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 04:59:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782907141; cv=none;
 d=google.com; s=arc-20260327;
 b=QtUAfSw8L1Zo1ku/bfijE363XaSTe6geGqkbwl0sFQDc8QCOJADq1RUphpkjipMEcd
 jUKP+6l94YjBUgTx6xe6MF9TgR3K5/Q9iCchO2SUtsoimG3m779JkiBDF4mDyYeOEzs2
 4OQ4vYp2w/OGiB7yjMgST0gbW25FfwOeYa1cNVPNKXJGVsUbkOvEr6UtIaEbOR34faKN
 0pOoYA2v4Ia6KpscE9K6jJ2CWDDgOdzgeqVzdmdqvCX64Et1taXP7bc//EEiJEJV44pX
 thoZF6gMFSOHHw5Hvnqv+bHb1TiQhiKdpXg6DNml3SJodQj/HXemLcmLJDIlR3zvc6ww
 GK6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Q3reds05/cAJvgu1s6OylZeuPrT1tPShxwSEyuzfTwI=;
 fh=VcekEN5WipyPSAK4oUwFdy83aQPoP6dluuIUK9WhiCY=;
 b=JKxhRdgGJ5wRq8E9Px4kWCwePPTYECbBsj/amUlcNqRUggWKZaCuC7h82I9x5Ph/ht
 BuehTF1oxlOsvXbxycWzEvfnitpStqvbReMepN8NcrPVNd/r4RlnfuSMeQwDI0TLpLVK
 k5LMopnaZTuJ8N9HRa6jTZswimC/CSc/Myo5Pxm4vsKobhBvOc7fA9rxw9OfajWJWHUy
 +nS/+0bmfhxUeTUYgpluS5UYI5Tb5ocW4SBIIx8TNbbYZ0DpmGKfHK5uOh18MAxUuUfZ
 1BNgg1vgimFZQTj+lG36lZeqmdTzYjUN7ZcCZ4O6yYgEp7r35+PVUMhDDB4YZvqgd8UH
 E43g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782907141; x=1783511941; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3reds05/cAJvgu1s6OylZeuPrT1tPShxwSEyuzfTwI=;
 b=it0obklPiUNg2B71BFESWxM2LoJZCCGeGnijw6O8ps4YTVsOSWr2IE0Q/r81vPYh0d
 Heo+VIGd5DGav6AP3fgH45l4t/V2weVi4Ko6m58jCYVz6h4EcbY8H2kLP7c4cdcT8Rsj
 UeCgtjY4ZN/HTxI0tRWkcRB6Ercif03UUaPhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782907141; x=1783511941;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3reds05/cAJvgu1s6OylZeuPrT1tPShxwSEyuzfTwI=;
 b=SgP9/UBiPP5U3mDikY24tLgI/QV3dT+7zPVpntGrkLXJ9AfCnjzIyeiabkkdkCbBIQ
 xxc1QfV2BaP8Ko5aG9F3wOCb0bdsOd5zytY28jxSWjp/uLW5uZr7Y/7ucYvFpYSf8HCY
 PhQoumVgpUoWXNOYvtTUttA0hCjao+Poqz6nShbvaqr5GhykcE85M3jSuYc7+4M3Rngo
 zx1SYno5DMtyreVcgNMju+Ed+QcAGXkk2u1gl6hdfAQnML1Qyi79QfrCLfy96t57/z+y
 hkzec0DEswKTqTRsB7DwXZm7/6L/QBEXAAPpTNT7nuXxtq+RnEyWI/2RWWF3LJzYa7DA
 XAhQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnMUoQcnhft5wAaKElDF+pDNYO6TZseIqkfnzlnFBEFate9ZfkD3riXmQGdOvxqzcnxqU174c=@lists.denx.de
X-Gm-Message-State: AOJu0YxF4n9Bz0pBibDapagjUTRDob9enAmr6Y3xCg1CJJhzx1jwoODK
 YyObEVC9QpG8VQ+Hl6u4o7VPe39aIb8b2XqyZVnOAMjouecr0hVUFMGVv6BkJ9P9Qdu1TsbfZWW
 ep/zxZVrGyZqdxur+rv/MZZ3HS5oLgNiAYEfQSk1G
X-Gm-Gg: AfdE7ckBe89TTyGD5XCf7jLthi1C1MBfH8XYsBW5PBeSBvcmnvOiGfvtuIqDSJ00p9g
 a5xu9dMxBPkkjpkH3BOXfJk1WHs+XEbyWzrtJHgHwkOybLhyQDACR8VNoYp966hWPjBHqK/fUrW
 z5gPO8sTOek1e27h0OGF4njS2KuYVR52RGviYH+jthi0Uhb2gG80KzHu3Fk03PUq41JbtnOnVTa
 oRrva6iFQTeSMKw6WTEjLHX+yxYvn8Fedqvbrz/UzYKo8Vjrt0MqDDE0/ed+um4tuT2CIK/1Q==
X-Received: by 2002:a05:6402:2483:b0:687:7fa4:faa0 with SMTP id
 4fb4d7f45d1cf-698a2cd157cmr137228a12.23.1782907141309; Wed, 01 Jul 2026
 04:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
 <20260628082810.175862-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260628082810.175862-5-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Jul 2026 12:58:49 +0100
X-Gm-Features: AVVi8CdcmCIQoBVgFwYNJr2P3wneos7QOzPhxI3H28zLmqcWgTlbelBgu-Fc0_0
Message-ID: <CAFLszTiGeP1LVJMWpz3KSGS7jHM48qUVuuRyD-ym1sMONmT-5Q@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] efi_loader: fix void* check in open_file_system()
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

On 2026-06-28T08:27:58, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> efi_loader: fix void* check in open_file_system()
>
> The UEFI specification requires FreePool() to return EFI_INVALID_PARAMETER
> when the passed buffer is invalid. But it does not well define what
> checks are required. Therefore we try to avoid passing NULL to
> FreePool() in open_file_system() used by dtbdump.c and smbiosdump.c.
> But we check the wrong variable.
>
> Check the pointer to the handle buffer, not the handle.
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> lib/efi_loader/dtbdump.c    | 2 +-
>  lib/efi_loader/smbiosdump.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
