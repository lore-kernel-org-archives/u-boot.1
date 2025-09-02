Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0915ACA1007
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 04:58:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 608EC83443;
	Tue,  2 Sep 2025 06:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="keF+ivWo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 215FF83965; Tue,  2 Sep 2025 06:58:01 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFE3782AE1
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 06:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-71d6051afbfso41310377b3.2
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 21:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756789077; x=1757393877; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zvHo94BQ9Kw2yCqBHxTXWH15DkfSR3lsnYq7dIVx/fo=;
 b=keF+ivWoqTtq1mydKYk+TJ/rlF95QfQqJFMc4dPF+8xiFrxrKTtllVw4y0LzthVCP4
 Hpl7eGYo01Cx67HLa8nc9Ah2wyceRFdITz+DFm7TvXN4tSk0kN31vu1GqVgdhF1nW1vx
 2CCrygVphvl6EiBnVW8zYznulJUyt+xcGTIqOBaXMdA9evUAnM9n7J8NpiF9NR505caD
 YS8GYS8BMGEwZn7VWch/DZQlQszp/vcR7LRAiPaXV5Td9eHiaglKBO20PuF/P4YBfbZ6
 EDldfUoYZE0uZvWx7/PlszIDcyP5ek0NSRkHw7hsGGxmbsKQSF25p7kwigJrqjwcdE7k
 u3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756789077; x=1757393877;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zvHo94BQ9Kw2yCqBHxTXWH15DkfSR3lsnYq7dIVx/fo=;
 b=Arm8RbyYsBTNKfeIkZZhfQiaQ46+b/muchx+QUtA0X6WZzujsFakKgHE2JDkEcSa+d
 StTtuTAZvuP1ArqzZfCJuBtd1lrW7Hv0mEB6uSxXkv3Od44LpEj23BfCeqBe1sBUgQQ4
 OPybNKxpkmlbgTsQXPsDdwQONQcPUk5Kc4fQngpkjIDYtommP10Yivp/FVnxRpHPyieX
 mpo4Qrb+67O78HXtrFGGSka24gGBNLf9gXIGKezdwDtxegpOEjEtEOULzsUkrKuwKt3e
 wste8+KBuFuoRxm8jJjWYh1ykZKG+QLl3VZridhTvjZSI9yzaE1+8GFWCpl1srg6bXut
 ZfoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBQNPMsnL1oE40HaBY7UZV1gDhl6aZK9Mhr5ICbTZ+hqDWJxU3wJj24HbJC1pJ1JCR8ciyDno=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8P9KGWLuRakPyWl8blorJbTSl6tYVxqA0bMtRbYmn8sZrtNUt
 b38D/GiNiVqWv3EmbTaDU93jzpMTiAsUBbb/7EQ7HjupFIfaiyYHo/qJgRF6QPUpBoTbpS3gMH4
 hPlh7EEQFlyuVDFDTVPiFC2Nd/hr1Cvp2aaxxCPABCw==
X-Gm-Gg: ASbGncsQKlp/1OdH5CK35gFWEmm7LdcKdsIIQ40nOE0WJzOs3+WzR/kYlmvQR6PSODK
 sO6Kb1FWeVaO+p7JGG/n8iSmzd16lnEfJDIr5KANth1MQQIwkRmUUhvXd2/1ot3E6MXAmoDlru1
 QCJTvSsM9qlqpIlXVEHhyr1wGS3lIr0ktgCF/aRflsb6Zd4VjeqJjDRm6lzjKWa5OtRbqhxZJH1
 hdjcD3nakQeQSxPrgAHCK7N9a6P2fxLqzeQKQ/OnH0wdlqcz9q85CqtTWlnCZZ87RuIMDdqIIyC
 xoaNt8EEG7iE3vHSNWK8ngJf2yowKOVj2w4BTwhrtxgOTwRV7hwNqyJbdY0MrXrCSVEyTjT9KEC
 lxZxxXS8=
X-Google-Smtp-Source: AGHT+IHY6r3+HnbSaaASaE0tAE5tDjPqDo/q0XaVAC3B3iEtlITrZDHzng4b4V2EnrmtYwoZ4Ts7BLICLiwbU4PFwF0=
X-Received: by 2002:a05:690c:368e:b0:71f:f359:6ca2 with SMTP id
 00721157ae682-72276580a11mr114975677b3.52.1756789077408; Mon, 01 Sep 2025
 21:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250901151635.654928-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250901151635.654928-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 2 Sep 2025 07:57:21 +0300
X-Gm-Features: Ac12FXyLOr70iwzsE-Z42Ld7MpXwE7iDeiZ4VlQ6BG7CaqvI6V-PFFGY2xPA6Lg
Message-ID: <CAC_iWjLkdcFomO8iETm0dkjAcvYe9aOmxC_24BFT4SSOQneAcA@mail.gmail.com>
Subject: Re: [PATCH 1/1] bloblist: use correct types for physical addresses
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Simon Glass <sjg@chromium.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Harrison Mutai <harrison.mutai@arm.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de
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

On Mon, 1 Sept 2025 at 18:17, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> It is expected that bloblists are stored in high memory beyond 2 GiB.
> We must not use int as data type for these addresses but phys_addr_t.
>
> Fixes: f9ef9fb033d5 ("bloblist: Handle alignment with a void entry")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  common/bloblist.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 6e4f020d7c4..d5fa62249a9 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -149,7 +149,8 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
>  {
>         struct bloblist_hdr *hdr = gd->bloblist;
>         struct bloblist_rec *rec;
> -       int data_start, aligned_start, new_alloced;
> +       phys_addr_t data_start, aligned_start;
> +       phys_size_t new_alloced;
>
>         if (!align_log2)
>                 align_log2 = BLOBLIST_BLOB_ALIGN_LOG2;
> --
> 2.50.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
