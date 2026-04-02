Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09EACC6B33
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 08:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5229839DF;
	Thu,  2 Apr 2026 10:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hWBae0T6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A257883CF5; Thu,  2 Apr 2026 10:38:53 +0200 (CEST)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4477780212
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 10:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64eb84d1e37so470187d50.2
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 01:38:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775119129; cv=none;
 d=google.com; s=arc-20240605;
 b=Rljam8Q6tt7fAcG2WX7NlDYz5+eWuii7OTLkMEHNQVsQRvYp0+svGdcap5KIawVrt2
 VMjshdRYv9sFnAwgNpKzjNlPkjcvd4eGhjLPlUbmEAfV3YpLbKUVynIq0uq5MFka6dEV
 ugGCPr0z09XFQ6QTYrrM5xnIPUreMbv5uKhAOZuODgwJ6k0RZrASTMza+SUzHlif+FlL
 dSFeDmM+Y54PUudaybR3hJWpzN2C9APewJOlNBWJwWRadTiPo07eoSqU9a8qXb/Hfvaz
 Wfu0uEI3kG9ncPXdzU8iPdnx7lGNz8Go50W5enQlaL0jnfFQ99lwlvHwy5Ahqfxfa0jW
 XkyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QXjYE15G67HUWRDylibfRXTN5ohY2vP4wDogCfDGsoQ=;
 fh=NlrFX6yt5HNDJhusTK15Yp9ahUaE3Ul9gOFLdN8Vv1U=;
 b=CGm49o9NGUQ1igURF/E41LEAGqGtJVusZCeF3w4iVsPabbrcUez/j95v78T6XndHIG
 Sm0nmYJuo4cbdKcA3ZQP2BcKDu1yIjwglVLrMAf5n1dja+5Ig75DjJpI6WpfnJXIfeuf
 LweHj6SpOIKvHhrfOD2BBQwrt3GSwYfGw5ai3riW1DKqEg7Seq9ZDpGv5+OTmxKh3MTV
 Pjvh4fq+ZL3XTzGaMCJH/appxqnifYXYIX12wxIBUgtheVJGJS2TauBYyD7Bogrvcu/7
 fJXf+ZW6Sb2m/zSHwAXyiVekS0fA+6THV3wXym4WqK7CnJA6CfFqCM8C4+J4AvUEHISM
 E5vg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775119129; x=1775723929; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QXjYE15G67HUWRDylibfRXTN5ohY2vP4wDogCfDGsoQ=;
 b=hWBae0T6KKQZcFdHfgGMWxWtO/WEmhLU3FHnvN38aU2jRRMrD8T/x1GP+x5hWyIxKX
 LZYzRLiaBJfzHyhnle0iKmxKmE5rKrI5MAnaJzyTseHcJDwBQRKcp+WQ5GzR2qubmamK
 YwgiVkffHG73CWS+zroeCq6fseIj084SAkKXIdWg83uEcyDqFnvs5EJWy87fNyTyffPH
 KaeT2DVuu6XxQegbl0tEnjuNfxAc19I9O9vraOvaCioUuqpRktFhR7IbO43KWIlcYb6U
 lRBS9NAAMi5IHexSWeF/QA7puXP08u8fdZ07P8crGopmaaaqcgCitYELs8h5jAQ4WML8
 1K4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775119129; x=1775723929;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QXjYE15G67HUWRDylibfRXTN5ohY2vP4wDogCfDGsoQ=;
 b=JbochPtmt6r+gM++NQNGwA9891BknyIl9LVf/AABoBGay2/h/ccRHrNFJ9fMhP+OOk
 40T9gZIudMKqfUL4xJ2ZGW+I/WJ5DI9Bo8LFQRHjC+7KaQTf7M0PHTvHAI8BXR3dWfoA
 Ger8alaGFKbodGNoHMohQ3fAVB7AhMn9DzQik9HrdYIJq8k3i10rGqldv6mPsadjxT6n
 LI95wEQY9Cb+36BRGN3aRMSiuXrFQNs6sp945ZxFwwLsWq0ETs0Qx0PA+R17ZpUdqfS/
 R8J6vvpgrAIbYkeuZCOGj8QbCjvbLLXu87lRauQi03FeavpbS/k1i1iKP2dQoNNIAvCW
 dS/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAIPByNM/PD2EuhrPgMcB/Zdvw1Pk9PbUOUlCCiUCQh63vTTLQwxwM+nfkpZJyPeLs4QVi6aM=@lists.denx.de
X-Gm-Message-State: AOJu0YyTig11TsABC2SrxaohvLiW5yctgNr37TWFB7ZSvBfsRDb7trE1
 z78okY2iS1zBktawbRIU+X7sEO+w7SkE71J3dGE+xS0Ml6+sDGARA6lCB1ZzHCWj6thMxT2DKWR
 S/QvfLuDNGIRRitAaGdn4YXFk+LvPrigEYuCFUHjT9g==
X-Gm-Gg: AeBDieudMU/rHHJnIplHr4szefPrGRe9uCsz0/U5jHzWrhtTfwcJzyRwuFfSv4xD4Md
 8WJKrtDm58NwTTQFHLryxCzgLCG476Z87tR8jXcB2tJM1BYLDOIeuehPXyN53o/Qm5XMjZQ/AF9
 iHSNc5bMdZSJIC6Q1gA8fOfKr8Ymb/9m/R1FOvRk+U+mFMHfdGxsg7NBzsv0q09Ie5dBVzhmZZK
 QVEk1DXkwQYxB1emCULziKUIxUEOd9e9cTYPX6wGIZQiu22JoCvea1RVuUurKvW/dnlk9m8unWY
 evVsdrB++BM9wwESA4KkWe4zhUDQMGTIqZrXkUsRYuOTO4/dX/QFWfKwslEo6f0g6NNLtbmqi7y
 Uih4vdQbzWRm8bD74sw8SWhbNiYw7H/gyqHYWLZBv+zGisv3i6wgl1Oc665xyhP2LywzrWs37o4
 KM4kluZB4YUCA9sm9J4Qv7whwH0Dj+S8SnH0Q6XpJJWM+uAsbGO/SRHYom/O5ozUSLdd7qHT60+
 aacr6l1/mzwAN4Gc0F/l1zs8pbxhPb2swowIB1dFNsqQ0a/9nYfQGJNED3ojUWQjqPy9brmvNb/
 NomAVxbjdqXk1U0HllTBheoZAqYvtf2y+gglIJYeSM7t
X-Received: by 2002:a05:690e:4842:b0:650:fae:9bce with SMTP id
 956f58d0204a3-6503bc5f804mr1373746d50.69.1775119128925; Thu, 02 Apr 2026
 01:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260402001410.3736815-1-rs@ti.com>
 <20260402001410.3736815-3-rs@ti.com>
In-Reply-To: <20260402001410.3736815-3-rs@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 2 Apr 2026 11:38:13 +0300
X-Gm-Features: AQROBzBcZtXtL1UpPYfaOgVwzjvd3tjbT8UVAPnp3DeBK249p05c0SxA1OmtkuY
Message-ID: <CAC_iWjLUcPAVCATHDxJ+FCJ7TzRKf7wq-92w2U+8otxufxvePQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] efi_dt_fixup: use fdtdec_get_bool
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, u-boot@lists.denx.de
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

On Thu, 2 Apr 2026 at 03:14, <rs@ti.com> wrote:
>
> From: Randolph Sapp <rs@ti.com>
>
> Use the more straightforward fdtdec_get_bool instead of fdt_getprop and
> a return code check.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_loader/efi_dt_fixup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
> index 544e1aa9808..333711b9957 100644
> --- a/lib/efi_loader/efi_dt_fixup.c
> +++ b/lib/efi_loader/efi_dt_fixup.c
> @@ -123,8 +123,7 @@ void efi_carve_out_dt_rsv(void *fdt)
>                             fdtdec_get_is_enabled(fdt, subnode)) {
>                                 bool nomap;
>
> -                               nomap = !!fdt_getprop(fdt, subnode, "no-map",
> -                                                     NULL);
> +                               nomap = fdtdec_get_bool(fdt, subnode, "no-map");
>                                 efi_reserve_memory(fdt_addr, fdt_size, nomap);
>                         }
>                         subnode = fdt_next_subnode(fdt, subnode);
> --
> 2.53.0
>
