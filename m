Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3CE10F6FDB
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 22:48:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABB6884011;
	Thu,  2 Apr 2026 00:48:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ayDp50+/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 768D684056; Thu,  2 Apr 2026 00:48:13 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C25083CF5
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 00:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-661b16ac011so498519a12.2
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 15:48:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775083691; cv=none;
 d=google.com; s=arc-20240605;
 b=kpzAu/xWwpQcQmhSAmmda5SeJyA5955Ij1L/l5G3q+ywlSVkWFV4Put8f+5e/9GWNd
 JJ1BEKo+0/8FjMm4HTiK5ZMShPkmzU7tdeNDVE2iJC1sx/JaeRh4bfLaMNjgT2yclyvo
 cAycW7jnO9XABEfVGFZRUhvvdsJUv78pSbR1Mx+XPfp+ok+E75ALLs/zZOlHXpuqrN7A
 f9f3lvO7UCN6Y3z4hMRsKCNa3JPGbuiEUEUsDVTZ1n+aZQPpUgFQXQ0hT7CG/Ug7dP7v
 aP5Lj2k0PW9/70n3DYhhoRtEzqJj2AcEdRzEl3MSAB9wF344U6hSiTG2Zaqq17ZZhBb7
 tElg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iDUAW1cGucX4C78uaq1o2hWA6NsGf/y9YYd6ByvFTTg=;
 fh=ZuNLB9bOHjzoAXeveGcaqsDQIpibu1NOZuvbRVR+bDY=;
 b=Z8blN4IzRYcaKI2GT6D3ypnxvp5gl1yiQ9kXw+gceWWNx1kuXTLBWekg2eN1pDOVPQ
 gqaDrDRKn/QDpZ2L1/sdnZN3BR8kv8kovSyONjIa6cUrDAEgivXfmI5SCFIJ1bTikmzW
 Hww3xuc+oIGzayA0wnmv5pZCLy9T2adxg55PA/78pqj4eyO49okaH3eLcmqrQsh2kQGm
 QrDSgm89CkDb9yeuJbFtl3bXGtY9+ba/qMAsBtR/l2i+pWT/Z6Mv38Nhxxhsq0wafEyb
 WHC0aAT4i7q2uw4wdZcpqv5KcfyHfRzsEARqIpyg3byQwA0+u0jDEEZ0vkXbd1q9dEmn
 InGw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775083691; x=1775688491; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iDUAW1cGucX4C78uaq1o2hWA6NsGf/y9YYd6ByvFTTg=;
 b=ayDp50+/NK3ae9+IMngSurJFwg/pPWYDo6D6CV4V+j3p7GX3Mjm18YG9pxQT9nPH+x
 Xf6/D1nv1qPOtci4dnbHU4v/YDwcLZIlbTUm9bMoBqRlj4WqjO1syEd3HL3o+1nsSs1X
 5Vqd9PLvDHWixYpEi6uF3sF1vwiJBttqsWOzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775083691; x=1775688491;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iDUAW1cGucX4C78uaq1o2hWA6NsGf/y9YYd6ByvFTTg=;
 b=mnUUOAuY0Hv1nqF6LSYumjSYt/7187BCqt93fssZRCfRzWkZfRFlO33x4T7YPaRx/q
 SKR6eDUhnkEDzku0k/Kuv0yhngP1ZMM49L6EDJbHdfE2P6q2cPwS/+ebRwCQcP/wM4T2
 dPKHtOM/SKhQF0ovpVfld/0yxs8WQAlIH8Q9c2bHPzvJ8PI6dI35OivjfjjTkaitSc2m
 w23BGXQPBklWtkh3DNqJPxbF/CJk/50GGFrmt6KaQ3rFy1uTVieEHDcmRLa0xACQ/PF3
 PAJ0hRUb9VYYhkZstueuZz0T0xNM3ZfQ6tBT041TRgIhxaWRHnkHnMvX8AY+tGvxWY7j
 AYnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpEpA/Q0W522bc3z9tznTXh6QB7Nk5/9i9b9h2OiVvCK4SdwLNk4mK/TsbpHYQC8uVp9qwVLI=@lists.denx.de
X-Gm-Message-State: AOJu0YwXPv/PoWLgG2KPQhMjp+Sqa0Wgs9H1s2zEKKkIOJTvfYWFIf1S
 nNguCCtGF0uFue2AkUGyLhr/8W7geROxJaQ4D1IuSV+LU95/q8iPqXQQw/OsaTK7A1OUDPaRE8x
 JjW/8cJx4imn2RW9MxHdwA9EPYLe6DpGJH4NusSCj
X-Gm-Gg: ATEYQzxER7ucEA/bMdwWw8GF53uYKmmOUyHDjITWyAkVIU515/uJ3U4iM/UzSMdr2f7
 9LIBRBEGpEWsDS5xNkmTCjeBFDtNGbErbawhnx89FdF7f0VDZ+ylkiUCJGharjXiWMf/0RXNFrp
 lnW/9AWgbgUIrDs18dDmmHweFuCnnBZvrm5FuFhU2wqBiglaCy7pyH+tChTr6g1SYYeH+FoRHhd
 3mOe2KdhgDTVZYLRr8xe6kWoyxRtNDmZoQ0Vy7VADatYkL+oYVIn4JZ5QfrPoNorYO0kC1NA5cc
 aFRkVg==
X-Received: by 2002:a17:906:ad7:b0:b98:4d8f:d968 with SMTP id
 a640c23a62f3a-b9c138c10ffmr282274966b.12.1775083690627; Wed, 01 Apr 2026
 15:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
 <20260331100047.34618-14-philippe.reynes@softathome.com>
In-Reply-To: <20260331100047.34618-14-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 18:47:55 -0400
X-Gm-Features: AQROBzA6qVDHjWUBsCuh04VEfVZPGzbM9lMfhvyVJsJioXcT7fJwrNvk5qbp4KQ
Message-ID: <CAFLszThyctzvSL-qzPPuRJ4x-_jM22AxgcAeQa1A-ORQ0jB6vw@mail.gmail.com>
Subject: Re: [v3,13/15] tools: preload_check_sign: add support of ecdsa
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

On 2026-03-31T10:00:34, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> diff --git a/tools/preload_check_sign.c b/tools/preload_check_sign.c
> @@ -144,6 +147,27 @@ int main(int argc, char **argv)
> +     /* For ecdsa key, we have to update some values */
> +     if (EVP_PKEY_id(pkey) == EVP_PKEY_EC) {
> +             EC_KEY *ecdsa_key;
> +             const EC_GROUP *group;
> +
> +             ecdsa_key = EVP_PKEY_get1_EC_KEY(pkey);
> +             if (!ecdsa_key) {
> +                     fprintf(stderr, "Can not extract ECDSA key\n");
> +                     goto out;
> +             }

EVP_PKEY_get1_EC_KEY() increments the reference count on the returned
EC_KEY, so you need to call EC_KEY_free(ecdsa_key) when done with it
(see lib/ecdsa/ecdsa-libcrypto.c for the pattern). Otherwise this
leaks memory.

> diff --git a/tools/preload_check_sign.c b/tools/preload_check_sign.c
> @@ -144,6 +147,27 @@ int main(int argc, char **argv)
> +             ecdsa_key = EVP_PKEY_get1_EC_KEY(pkey);
> +             if (!ecdsa_key) {
> +                     fprintf(stderr, "Can not extract ECDSA key\n");
> +                     goto out;
> +             }
> +
> +             group = EC_KEY_get0_group(ecdsa_key);
> +             if (!group) {
> +                     fprintf(stderr, "Can not extract ECDSA group\n");
> +                     goto out;
> +             }

Both error paths are missing setting ret to EXIT_FAILURE before the
goto. Without this, the tool exits with success even when these
extractions fail.

Regards,
Simon
