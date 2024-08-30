Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33440CA0FE4
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 12:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B1AF88B55;
	Fri, 30 Aug 2024 14:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b/mBzy0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7877188BB2; Fri, 30 Aug 2024 14:17:21 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ED5088B16
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 14:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2f50ca18a13so20802291fa.1
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 05:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725020239; x=1725625039; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GWfALl4DNngAWpCEbv/fVyRd1UgHryXLE6vFJXJjbBA=;
 b=b/mBzy0h2R7Mi5W4RnBbArinWhHBN1iY/nOxR32PwwzJBdLMZcLtdDlsIC/OfFCw03
 ek/PGorog5rER6v9qgax02YMA3YV+NfwnJviWKMyT5Bz7z591rZlEKqqURksEm0Zln8P
 qMYdmez6EB6DZu201CjXKbfGJRSiHpKLauNcvLdNcqQYiWGzuKz3DN7IztVHW8B897qZ
 Rv2BNh2tDunzybvUMy6+tw8RP3U5UfT43sCWiE8QYhlADTl59fHkReKJ8MovHvZioz/m
 nOouZo9utpA6ZSJhZAtFHllTYkD4/nE2rvcidyslaTPBppqEmxJ62hL/FQGdeas/IIp6
 rjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725020239; x=1725625039;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GWfALl4DNngAWpCEbv/fVyRd1UgHryXLE6vFJXJjbBA=;
 b=mW2+F1Q+FdS9zDwYC0XfYb+KsyS3tJlY34IRE5GNtlUA/kTIqUeAVsr9KDSLgOk55E
 4Z2+xsySWg8fLI5g33uXIBJ0hRPFJBZpePPS0UyuUYhno7XHxNCNTgz0nsf6iePK+U44
 ybuoBfiFJnihlWMxMf0sXdXc7c/cxFmG4oijweTn9iIZG3xOHzu4Gnws8ckJzP2aSNmV
 0yJF9vKYRs/KPeoQfsYQ9Qw7jkOw3RSLEGhpYatlnPakhLIWTJN2XK4ZkDUhp+FsKpCf
 JpzygFEPC6FFpXAy8KXPlmbC/U/Wozkm0I68P2Oj3ihTbPpx7MQywG67V7ef7SZSg73w
 aC1A==
X-Gm-Message-State: AOJu0YwaoeDcpwmU7OEkB4lyVgI/keL0RtfnW1pzTgvJaj50aenk3c6q
 wJzUXqDOxxnKNhEC7DxJqocVlGMI52pqF313Gv/Hi2ql3WUbqJ+qmkUdIZlDgnuw/ZO8wbqMShw
 hRymImB+2a7ddExBHHmYyYZ2HCHY=
X-Google-Smtp-Source: AGHT+IGg2RZfarTsLJrkoQgT1NvP/dENJj5d0tT5ppsijVbM+VOW15v6K3mdPeLwcheDZbuMotzZfFDXo1gr/upOL90=
X-Received: by 2002:a2e:742:0:b0:2ef:2b6e:f8c8 with SMTP id
 38308e7fff4ca-2f61054a624mr35870681fa.42.1725020237997; Fri, 30 Aug 2024
 05:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240829145802.1827952-1-sjg@chromium.org>
 <20240829145802.1827952-20-sjg@chromium.org>
In-Reply-To: <20240829145802.1827952-20-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 30 Aug 2024 13:17:06 +0100
Message-ID: <CALeDE9OE1n-9uATQrUi-qxsa_-cvBbfvj-_WaWF16PShNZ9Rgw@mail.gmail.com>
Subject: Re: [PATCH 19/19] hash: Plumb crc8 into the hash functions
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
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

On Thu, 29 Aug 2024 at 16:02, Simon Glass <sjg@chromium.org> wrote:
>
> Add an entry for crc8, with watchdog handling.

What's the watchdog handling do? What's this used for?

Looking at the use of crc8 it's minimally used.

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  common/hash.c        | 8 ++++++++
>  include/u-boot/crc.h | 3 +++
>  lib/crc8.c           | 6 ++++++
>  3 files changed, 17 insertions(+)
>
> diff --git a/common/hash.c b/common/hash.c
> index ac63803fed9..43c4e185750 100644
> --- a/common/hash.c
> +++ b/common/hash.c
> @@ -304,6 +304,14 @@ static struct hash_algo hash_algo[] = {
>                 .hash_update    = hash_update_crc16_ccitt,
>                 .hash_finish    = hash_finish_crc16_ccitt,
>         },
> +#if CONFIG_IS_ENABLED(CRC8)
> +       {
> +               .name           = "crc8",
> +               .digest_size    = 1,
> +               .chunk_size     = CHUNKSZ_CRC32,
> +               .hash_func_ws   = crc8_wd_buf,
> +       },
> +#endif
>  #if CONFIG_IS_ENABLED(CRC32)
>         {
>                 .name           = "crc32",
> diff --git a/include/u-boot/crc.h b/include/u-boot/crc.h
> index 5174bd7ac41..b2badaf6a97 100644
> --- a/include/u-boot/crc.h
> +++ b/include/u-boot/crc.h
> @@ -25,6 +25,9 @@
>   */
>  unsigned int crc8(unsigned int crc_start, const unsigned char *vptr, int len);
>
> +void crc8_wd_buf(const unsigned char *input, unsigned int len,
> +                unsigned char output[1], unsigned int chunk_sz);
> +
>  /* lib/crc16.c - 16 bit CRC with polynomial x^16 + x^15 + x^2 + 1 */
>  uint16_t crc16(uint16_t crc, const unsigned char *buffer, size_t len);
>
> diff --git a/lib/crc8.c b/lib/crc8.c
> index 20d46d16147..811e19917b4 100644
> --- a/lib/crc8.c
> +++ b/lib/crc8.c
> @@ -32,3 +32,9 @@ unsigned int crc8(unsigned int crc, const unsigned char *vptr, int len)
>
>         return crc;
>  }
> +
> +void crc8_wd_buf(const unsigned char *input, unsigned int len,
> +                unsigned char output[1], unsigned int chunk_sz)
> +{
> +       *output = crc8(0, input, len);
> +}
> --
> 2.34.1
>
