Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A434EA71B3
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:12:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A861D8425F;
	Mon, 20 Apr 2026 04:12:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g1zRRAkz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B655184181; Mon, 20 Apr 2026 04:11:59 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7AA982BF2
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so464914066b.0
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:11:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776651117; cv=none;
 d=google.com; s=arc-20240605;
 b=OYAFm6px6BypIVmqMI6qsx+CTP5NjwIL0rvvflXT0nvaaWmz3r0bMPEdk/uixPjPuP
 5GP9OwJ67ptNI7gh+ssGnHGgHXP0BYzWNxOJ1Utf9FzqldBVJqx6CZeQfukPiI2jetQL
 jVrt2RItCwnohAORQSpCDZDCrRmTG/rnv4tY8EAmOuG/xjsf1IW+A3EBMoEmjpShvhBK
 ytbIQhC+OdJArMJ3gge0YBVQSP94PYyaXWybXGLjtFKnTPN2xtWxCIa/vGmjbSuoTlKJ
 FK8R+igweEj4MLydyU/hyBDWkgIJrVLPipxC/TGj388jpD8LSK0SKjOfLh31pPjlLHly
 avMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rVaKExI84GM/txYKnit3r+WY2vZGsjxrb5nbcti3tVs=;
 fh=P8BakoZEtxSaV7Px0invJW+WKuenx0/FsDVFsdlITls=;
 b=jXVrWo3QzA/P+v92QB1NITb5NC2rNGmMetIStXSoO23e7u1hfsy3pFy7TwiFUzBrf8
 C2ZYrUQD6D7GO3mCRvuV9d65deDN6PD9IX3Q68DwprWCrldDu0tBK6qGYqR2awABJlMY
 RMXqzH1gevehS+fttclzCw31UFR0qnp9jGlXE6LvWUCml3SMGS0HwLrIgUnTifMd781w
 1eM2cahXYh/7dNqrDfR1p0ewRDBjiaMcxFqD/xdPtNykB7taO3XzrcZ1qjCp/+PurfRw
 uO9PiYtHRyyL/HguhnoH3ytHSB3BWJ8AehqP86IBEkJkAjXUadszi6jCdPwuAjK7SxB7
 o0yw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776651117; x=1777255917; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rVaKExI84GM/txYKnit3r+WY2vZGsjxrb5nbcti3tVs=;
 b=g1zRRAkz1tcx/lIVzhRlVzCKO+xOwE2R8DdyTeAAwP/VqjQpjBolpfaGqBSpZO/Mve
 UeDRURUu4Urw4uwJAYkx9RhLZwG5QC3vga6isdqVdbh+Vz9OXvtxFHQiQxvX6e0oSYly
 aGyOVE+GvGOQy5ltoC+rVYdtD3Unca1DsxhD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776651117; x=1777255917;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVaKExI84GM/txYKnit3r+WY2vZGsjxrb5nbcti3tVs=;
 b=ppdWZ1kUPifHm0txnGj7aApwPFdG+CB0/bJxvMISXB0YYXUDz5WIHPZl05S1DPnG3W
 RfXjh33lXkcfQpW1/u7zFiv5XiTWg1GNSbr1ArKOGm5Nt8t/uQ2q4j52i/7SoYlkxesJ
 ArJkaJYBdsQ4618QfwW+VGvzTbcOtfc6n7vtZBpwHuJisCXJvjAkl27NB4FX6EMccTDj
 9OR6M8nvktXAFoPxkKHYHMN2DjnknrXeXFS/H2eoOkz+FIGYD+zLDLhkB5mS+j7/dY+6
 IYf9o8znZnarpYIFx5rJK768RB2ElQoA3NpjganatQ2A8LG9/e4yw2WYeHlucFQQTjNA
 kfFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+PonqeB9UxXpkzWVE2Hu+gjoHq27k7aNduNfDz+AUgyK3GTM1yv3UJ+j1roy6UK4qA7tzxYbk=@lists.denx.de
X-Gm-Message-State: AOJu0YxrgAIxQaPq7RwI3ibJc04DvMrxSC9g9xpMLAz0xDkSekXosNBN
 OQPca2KfVS8WpN+r4/7sUYo1hHZkHYgqHZ29gQPPN0RYT+tXccNaNOwrMemqSTf+9MZZJ+TPw5c
 /IGRyDp/+HLDhpGg3juEqME4ZkEnMU8IUGvA0H9rQ
X-Gm-Gg: AeBDiet7e8kr6haDU/SuoySxYBc0Gc8iJ2vQUDzIa5dZbqw+ZCN8ZadPCaSRdc+kzov
 03TqelL9F6n3csrRviDwuiu4Tv0cq5uhPdy84xZTQ1QaVEib13vx1x7GmvbQsEls+d6peOIIdCj
 DLI1yNut+TJarx89QbdxyfYyjv53/WantpkFnqgegtTP8U7gulckYu2M2RqRffpKB9dpOSAvB/+
 jgCBIne6iUrUsaUyDGn9AtYDZHEFh2Atqf+yvx1oSpKBHG79jSwYkBpIHqB1Y/kXmOm99WHRazD
 PWscpOmHQuiTUgus+l2p
X-Received: by 2002:a17:907:3f8d:b0:ba7:3d21:c137 with SMTP id
 a640c23a62f3a-ba73d31091dmr143419366b.17.1776651117199; Sun, 19 Apr 2026
 19:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
 <20260417130204.49896-4-philippe.reynes@softathome.com>
In-Reply-To: <20260417130204.49896-4-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:11:29 +1200
X-Gm-Features: AQROBzDMGmbTqfDpWfYgnd-6RfMMCeaLrN1T07CXcN2oBWW9b7FGNkBSbmPb770
Message-ID: <CAFLszThUZYSAJmw1kux22Xbs5Uyhf=27vKfbR21bPw24RqdLLw@mail.gmail.com>
Subject: Re: [PATCH v4 03/14] test: lib: ecdsa: add initial test
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
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

Hi Philippe,

On 2026-04-17T13:02:04, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> test: lib: ecdsa: add initial test
>
> Adds tests to check that the function ecdsa_hash_verify
> using mbedtls is valid.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> include/u-boot/sha256.h |   2 +
>  include/u-boot/sha512.h |   3 +
>  test/lib/Makefile       |   1 +
>  test/lib/ecdsa.c        | 453 ++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 459 insertions(+)

> diff --git a/test/lib/ecdsa.c b/test/lib/ecdsa.c
> @@ -0,0 +1,453 @@
> +     } else {
> +             ut_failf(uts, __FILE__, __LINE__, __func__, "Unknown hash type (%s)", tv->hash_type);
> +             return -EINVAL;
> +     }

Can you use ut_reportf() here?

> diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
> @@ -15,6 +15,8 @@
> +#define SHA256_DEF_CHUNK_SZ 0x10000

I suspect you could use the existing CHUNKSZ_SHA256 (64 * 1024)
instead. The same applies to SHA384_DEF_CHUNK_SZ and
SHA512_DEF_CHUNK_SZ

> diff --git a/test/lib/ecdsa.c b/test/lib/ecdsa.c
> @@ -0,0 +1,453 @@
> +static int ecdsa_test(struct unit_test_state *uts,
> +                   const struct ecdsa_test_vector_s *tv)
> +{
> +     struct ecdsa_public_key pubkey;
> +     unsigned char x[528 / 8];
> +     unsigned char y[528 / 8];
> +     unsigned char hash[512 / 8];
> +     size_t hash_len;
> +     unsigned char signature[528 / 8 * 2];
> +     size_t sig_len;
> +     int ret;

The magic number 528 is confusing since secp521r1 uses 521 bits.
Please can you add a comment or define a constant like
DIV_ROUND_UP(521, 8) ?

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
