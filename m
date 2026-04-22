Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BBAF94CB8
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 00:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 941A58352B;
	Wed, 22 Apr 2026 02:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eBbwXLXL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBBE583FED; Wed, 22 Apr 2026 02:11:50 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E74B8805D7
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 02:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b941762394aso656192866b.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:11:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776816708; cv=none;
 d=google.com; s=arc-20240605;
 b=Be7+lB7MIpwyOiZWhsJXKYUla/lfkil2z0VjbMvflraMI/X8ZjV91tzB6ZhmIVuY2d
 Rh9v5W6IQBehz+ZFXctbX+I5SQeXxC+v+sUzU0dttnOg0HzaENP5lCkLBF66YagacLdZ
 pf815E1GrS0VbQI3S1PFitglva3RhrxoDBV9j/NLpIjmsuPTWts34OK0Z6utlCdP3AWW
 r/TI2Ir+Q9b1/VxvlJgUAIepOxfuJj5PodWB5Emam6oXT5OqworsHU0k+7f1ltqlE0ja
 PgrE5cW5DnIwvo+id+UHe+YMNUePTA3e5qnH2htofF6KsW9FqpOkXz8EZK3u+MNX79D7
 Zsvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zMs6tE5Ku7EXsW7OLVjhnDZ+bImTXzFfZGCYcDIY4Jk=;
 fh=9XxNUAKVix7ocSgu3e3z0JJsLpFZ825JPRgEBQGYIIs=;
 b=hbn5EELZETPUBWLQVjaAAQ5LIOspbhwqj4eYRhzoXiHvei0ipbvscfwiVzw+3sraNr
 Up48J6ace7lgo4EEsGBtvbcCRtxMPotmcKMY5H3U+iaf3UrRio1ZjMcPBlsT6/7xwz/B
 iIcgsHVBj3ff3B4XZPGuWIGCUe+Qz6DXg/PH/Yagl2DYxYCN+hI+cRDOOlOIcz8ae7Ey
 nr9Q/Q1cU8PS92HxmqUuZswNdY9p5eGgsdG2wVK8rCgmyfqzT6fQ04daumdStHas0LGi
 BQT3MLWLbJo/UqAAaNOxmXhWLbQPRMdkESqNxpVDfgu199EzbWMuXS1ioWwRDb7yRwwj
 ctbw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776816708; x=1777421508; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zMs6tE5Ku7EXsW7OLVjhnDZ+bImTXzFfZGCYcDIY4Jk=;
 b=eBbwXLXL/TtcBcTVg/2we85trzVHGY6Nos9lX324CmNeNKpsrUOEY+FtnipmaqEQhU
 jRzwnFufiAEsMcAI79feP1N5G7zKvQ1uqZaoyjxIVjqcHp32ul6dFZrzk1uq1R+pguLD
 /cpQAIAiG9CUDAM79lzN5wgBxeW9uKoNdirQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776816708; x=1777421508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zMs6tE5Ku7EXsW7OLVjhnDZ+bImTXzFfZGCYcDIY4Jk=;
 b=mJbY5oxAYe6uvGLpn+Iq2PmhbWY8/VQK86aXGeqfGYqXEYuhImAXExQVzIRxdFZRYG
 MoIqpNJ9ZE5adHxxfiTA0gaNOXYmf46SH2qohrz2Vntg5H0Rs2KpeW4pKdMxHtkLJuEq
 seHd3Xm277ha75VoU6ccy2NVzxIvXeFjmAGk6A/qGks6WoWAqqqvSc068osLM7JZa2wQ
 56zF5aCKfuGO06bmTxHIKcBdiGsLJATiyZvUW/RaJSlj2IXF9dfMLlisPKS6Y4zXDXli
 NgOwrHpsXyuJ/yFH1v3awE1x3hb9pS2egHsDOczd5gkkNRKQyD8JE/NN8dT0tQPNhvVv
 A4dg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/uxemp7C5RAYvAEdCiNdbuU2JOk+2g83eLEBQujuyZUBnPLI1lZIQLGQq72ZD7C7E3Psd3k+w=@lists.denx.de
X-Gm-Message-State: AOJu0YwqV6+EjztyIDkIQ3HbRCB8URrHr+NCfk95ngzosJ2L7ryaMO/+
 tDd6ICLiuK2t7VXA2pJWlVg6B+AERqyG+Lfovpr7J+O4FwSRBQVagBAfKwqnUhCyMCHGBLimLn3
 XMpWRLZH7UdE6oiXOXy/HBRQ4ggHspciTZf1SFjE1
X-Gm-Gg: AeBDieukiwNgYhism5hPTA71vCJrOSaV4Yk+IP9z2Ml60Zjz3qnpSw9UoRjZm57vlV0
 tHDyC0O8PNWZuuN5auPa5xGgQpkC0Rik/1iLXChoSPItDP5rcYsL9rHy8r+/GwqWFLrdSBLcckh
 //IJm+eLrxOqmoBLpRkkO1kH+2t/9c+vwiwGM66qe9gCWMKo14nzMGVLE7/Fssn5UAB1rNpouUV
 OYZBMhOMjG3V2QPdFmJPeHsEViQgk3W7M+FKM/QX1O7e4idwX8PGlYwIlLvGVNB/mtf1CuphEP1
 04z9vqYWu2GcHH/ZBf5r
X-Received: by 2002:a17:907:9413:b0:b97:a1ca:e100 with SMTP id
 a640c23a62f3a-ba41ac02533mr971950666b.32.1776816708311; Tue, 21 Apr 2026
 17:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
 <20260421210954.1170437-2-philippe.reynes@softathome.com>
In-Reply-To: <20260421210954.1170437-2-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 12:11:36 +1200
X-Gm-Features: AQROBzAUyk7Eq2EQ8eK_yKiRgcgR3wsLZkKTthSP0kc206Ps9CWXYDmjGWYfroM
Message-ID: <CAFLszTi9GiwQqs_tApGE2yAqEfgwS6SMsAVef76n6NuNSN4hug@mail.gmail.com>
Subject: Re: [PATCH v5 01/15] ecdsa: fix support of secp521r1
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On 2026-04-21T21:09:51, Philippe Reynes <philippe.reynes@softathome.com> wr=
ote:
> ecdsa: fix support of secp521r1
>
> Current implementation of ecdsa only supports key len aligned on
> 8 bits. But the curve secp521r1 uses a key of 521 bits which is not
> aligned on 8 bits. In this commit, we update the keys management
> for ecdsa to support keys that are not aligned on 8 bits.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> lib/ecdsa/ecdsa-libcrypto.c | 63 +++++++++++++++++++++++++++++++++++--
>  lib/ecdsa/ecdsa-verify.c    | 75 +++++++++++++++++++++++++++++++++++++++=
+-----
>  lib/fdt-libcrypto.c         |  2 +-
>  tools/image-sig-host.c      |  7 +++++
>  4 files changed, 137 insertions(+), 10 deletions(-)

> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> @@ -26,6 +26,8 @@
> +#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))

DIV_ROUND_UP is already defined in include/linux/kernel.h. Please can
you include that header instead.

> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> @@ -41,10 +43,26 @@ struct ecdsa_public_key {
> +static char *memdup(char *buf, size_t size)
> +{
> +     char *dup;
> +
> +     dup =3D malloc(size);
> +     if (dup)
> +             memcpy(dup, buf, size);
> +
> +     return dup;
> +}

A global memdup() exists in lib/string.c (declared in
include/linux/string.h). Please can you use that instead to avoid
conflicts.

> diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
> @@ -73,11 +111,16 @@ static int ecdsa_verify_hash(struct udevice *dev,
>       if (info->required_keynode > 0) {
>               ret =3D fdt_get_key(&key, info->fdt_blob, info->required_ke=
ynode);
> -             if (ret < 0)
> +             if (ret < 0) {
> +                     fdt_free_key(&key);
>                       return ret;
> +             }

Calling fdt_free_key() after fdt_get_key() fails is unnecessary. When
fdt_get_key() returns early, key->x and key->y may be uninitialised.
Please can you remove the fdt_free_key() call in this error path.

> diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
> @@ -87,15 +130,21 @@ static int ecdsa_verify_hash(struct udevice *dev,
>       fdt_for_each_subnode(key_node, info->fdt_blob, sig_node) {
>               ret =3D fdt_get_key(&key, info->fdt_blob, key_node);
> -             if (ret < 0)
> +             if (ret < 0) {
> +                     fdt_free_key(&key);
>                       continue;
> +             }

Same issue here.

> diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
> @@ -135,6 +184,18 @@ U_BOOT_CRYPTO_ALGO(ecdsa384) =3D {
> +U_BOOT_CRYPTO_ALGO(secp521r1) =3D {
> +     .name =3D 'secp521r1',
> +     .key_len =3D ECDSA521_BYTES,
> +     .verify =3D ecdsa_verify,
> +};

Just to check =E2=80=94 why add secp521r1 as an alias for ecdsa521 but not
secp256r1/secp384r1 for the other curves?

Regards,
Simon
