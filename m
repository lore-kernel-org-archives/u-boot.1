Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47A6CD6E45
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 08:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11DE584671;
	Fri, 29 May 2026 10:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SnXt4Xc5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF261846CA; Fri, 29 May 2026 10:42:20 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80DEB844CF
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 10:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bdb3eb93e20so1385020666b.0
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 01:42:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780044138; cv=none;
 d=google.com; s=arc-20240605;
 b=VFR5qDdjCrMEzXtrPmHZpOGch4LZJnmYfApmSPvQTPmmlw1XQ+VTnEEirlHBzhRH/K
 BLz0mldgyle1iaICvGp78MbmBwyUP7mvPFKB3M1pSBg0RYN4IcBUYLkzEf+5cyaDtTG3
 RjEeH2IvepJUbK8t3wUmEK5etI3bMUlgNc1zWk0fRB4A45ZqiBb1sywEgiaTyMwdA8XE
 81Xs0Rn1KXwJuETQhEv7s8jvXST4FDomwRRMeFBvb1/c6CQOSOB3czX5gki4SE13LA+b
 2h0gFOpZJ/BGr41jIv8FZcpGm64BdNgXZhNRwEP5uMu9IAMxL/MLGmNom4q3mvd+YV5D
 DNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jjTrvJEe+UaNhVZiODFH3JmG14rOdfP2ynYL0KMcFlI=;
 fh=mxTABMteFpzDupE/WPT5xL3AwT4HG1VL9vit9IC1vd0=;
 b=k9EkmMpazN9eRETImmK9GtVn4OGymw1S6cyd3uzd0IW4FwKUcpieEdXFxPADW3Ital
 H39rrit2mnzqJPfG6tCuTFGT+ihvMCHiACqhRqZzdqxXhhqbHxRt4eoXJ4GK/DMc1cVy
 zQ8WHl2CG/Fq+AOir0S09Swx+iM7h6rzmqM3gQQN2/fdrJrsqjtYYAxDXniwBE26MHEl
 7JFmO93y9hrtqrgmcsSs2s8RGUXdVziEwZv5eW+hRSplFlF3+a+NxDkF8zyVZebYNDB3
 1pA9nsj8NtSOd3Ojvk2HiIUMkwe/H7wEd9jqay0VpVu6zvI583DLVBjwBBh30QdzRcwJ
 9SQg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780044138; x=1780648938; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jjTrvJEe+UaNhVZiODFH3JmG14rOdfP2ynYL0KMcFlI=;
 b=SnXt4Xc5DoRQ8gdx1LIRBgoIRIM9/BXz3CA0XzIIRJH037w6ExgHy7F/zBOAhEd56O
 rzqYoVUbOIlxUtaoDFOD6PZthIeDIvqyTAuTgKjhJN9VH9gck/E4fRlcNcTFMgyH38SI
 mBORjQ+qdk5xgOnwydDZ8O+NhnHU6Yxd9oB74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780044138; x=1780648938;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jjTrvJEe+UaNhVZiODFH3JmG14rOdfP2ynYL0KMcFlI=;
 b=hX+eHZ4mAJFUFXIjVal6Xxc40mUAHx15I1Fc8gEp3o6yVnikMM4yZZImkczLt1Ix1w
 h4QnBcPRWS4z1orE+SHaSKjXte7Jmb11J3pXHMuPjDDk+x+iJiT1oZ5Kwsyk1Gx/QHqn
 AkXH+NzmhCgUPxjEiaoUAE33sFNBGwKymaqt/+HHt5oGlZrfeZtGoL9awRKAOQ9KgZ0b
 prIHhr1jV2nvLpTp8e4dNIgAKOmjS8koVjCqdXvTmF2P3n4DF26u0VkSs3cDMqNLXhX6
 IW5ldyrqla+edRi67paRG4Zc+ocOp4spsd2b6dJ5MBE8QSa3syDF3oenuZw9gEK8CzFE
 lh4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3ieJdTp7a8xld+YlUyHidcYm3kcxh2/GB5UCgaa62y8Ttrr296NhUUGMNeWpD5X2Yg0WKuyg=@lists.denx.de
X-Gm-Message-State: AOJu0Ywm3gWkpJ1JuwFv24kERS29SoNyDVoo/6JsMKoWFGwLY4XOY99q
 GD9bYm98nS0foQTlrd+MRPC4qJe3qq2uVWCRiaVPVOPs8o5xFN6eWyWC2LBU1/Bl1wIDQA7EYIf
 iPAqO7GGNhH4LNSu2dcZFuSxicUB5555MaytHY/NF
X-Gm-Gg: Acq92OFS4E1lDKrv/Ilr/jQ8zh20YO1uHDVeJTZiRv1UOxwZnZF4dAD85yENrWzZXB6
 UBVeT2gZgrz0vf5mWGHdWY6FY555Ix2VjS1MEQ660Ag66CWGdUlyklBn6PCfSStxV/e/c4KptUq
 7+3eKMifDHyu1dHpfkEKNP5r8h+mnPP4+CRLlyfFQLSISe3JfPYSEqvf2gxRTUxDukDMfyFoYk0
 5/otFalAPEeG4Mklwi+od+hQpykzKNsnIFkXHN1oj4I8z6MqX7KJR/CNbEttG38eWfAk2EJGVKn
 3Pgd968FkHKC0/8KNTM=
X-Received: by 2002:a17:907:288f:b0:bdb:805f:e57f with SMTP id
 a640c23a62f3a-be9c8e62d78mr72692266b.1.1780044137763; Fri, 29 May 2026
 01:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260528081916.11355-1-philippe.reynes@softathome.com>
 <20260528081916.11355-7-philippe.reynes@softathome.com>
In-Reply-To: <20260528081916.11355-7-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 May 2026 03:42:04 -0500
X-Gm-Features: AVHnY4Jgy7UrSiotrXO-HXtD7esMgfln2OWnCUSG2zpkm6ZfF9pZR8IK6Tm5jZ0
Message-ID: <CAFLszThP0w8N2tk-VMRq9mZbUNFKckRkYCtdT5AnCzPU+Bfd-w@mail.gmail.com>
Subject: Re: [PATCH v7 06/15] test: dm: ecdsa.c: clean this test as software
 ecdsa is now implemented
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

On 2026-05-28T08:19:01, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> test: dm: ecdsa.c: clean this test as software ecdsa is now implemented
>
> The test ecdsa was done when ecdsa was only supported by hardware.
> So it wasn't possible to test ecdsa on sandbox, and there is a test
> to check that ecdsa is not supported on sandbox.
> Now, there is a software implementation of ecdsa. So we add a test
> to verify that ecdsa_verify may be used on sandbox.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> test/dm/ecdsa.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 99 insertions(+), 10 deletions(-)

Thanks for the test!

Reviewed-by: Simon Glass <sjg@chromium.org>

nits / thoughts below

> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
> @@ -3,36 +3,125 @@
> +#define CHECK(op) ({                                                         \
> +             int err = op;                                                   \
> +             if (err < 0) {                                                  \
> +                     printf("%s: function %s returns an error (%d)\n",       \
> +                            __func__, #op, err);                             \
> +                     return err;                                             \
> +             }                                                               \
> +                                                                             \
> +             err;                                                            \
> +     })

We normally handle this short of thing just with a ut_assertok() call.
It reports the error number, line number and the code that fails so it
should be good enough.

In other words, instead of:

+       CHECK(fdt_create(fdt, size));

you can do:

   ut_assertok(fdt_create(fdt, size));

Also this:
+       /* create a fdt with the public key */
+       ut_asserteq(0, create_fdt_with_ecdsa_key(fdt, sizeof(fdt),
name, curve, x, y));
+

should really use utt_assertok() - the asserteq is for when we are
checking for a particular integer value. Same with ecdsa_verify()

> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
> @@ -3,36 +3,125 @@
> +static int set_fdt_ecdsa_point(char *fdt, char *name, const char *data, size_t len)
> +{
> +     char *value = NULL;
> +     int ret = 0;
> +
> +     if (!fdt || !name || !data) {
> +             ret = -EINVAL;
> +             goto out;
> +     }

name should be const char * since every caller passes a string
literal. The !fdt / !name / !data check is dead code but OK if you
want to keep it.

> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
> @@ -3,36 +3,125 @@
> +     value = malloc(len / 2);
> +     if (!value) {
> +             ret = -ENOMEM;
> +             goto out;
> +     }
> +
> +     ret = hex2bin(value, data, len / 2);

Passing the hex-string length and dividing by two inside the function
is an odd interface - the binary length is what actually matters. I'd
rather you took the binary length (or just took data and called
strlen() internally) so the /2 doesn't appear three times. What do you
think?

> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
> @@ -3,36 +3,125 @@
> +     if (ret)
> +             goto out;
> +
> + out:
> +     free(value);
> +     return ret;
> +}

Label should sit in column 1, i.e. with no space before

> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
> @@ -3,36 +3,125 @@
> +     const char *r = "EFD48B2AACB6A8FD1140DD9CD45E81D69D2C877B56AAF991C34D0EA84EAF3716";
> +     const char *s = "F7CB1C942D657C41D436C7A1B6E29F65F3E900DBB9AFF4064DC4AB2F843ACDA8";
> +     u8 sig[64];
> +     char fdt[FDT_MAX_SIZE];

You could put those in a shared header? Also please use lower-case hex
if you can.

> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
> @@ -3,36 +3,125 @@
> +     /* prepare the signature */
> +     ut_asserteq(0, hex2bin(sig +  0, r, strlen(r) / 2));
> +     ut_asserteq(0, hex2bin(sig + 32, s, strlen(s) / 2));

Stray double space in sig +  0

> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
> @@ -3,36 +3,125 @@
>  /*
>   * Basic test of the ECDSA uclass and ecdsa_verify()
>   *
> - * ECDSA implementations in u-boot are hardware-dependent. Until we have a
> - * software implementation that can be compiled into the sandbox, all we can
> - * test is the uclass support.
> + * ECDSA software implementation is tested in another test,
> + * so we only check that the class UCLASS_ECDSA may be used.
>   *
> - * The uclass_get() test is redundant since ecdsa_verify() would also fail. We
> - * run both functions in order to isolate the cause more clearly. i.e. is
> - * ecdsa_verify() failing because the UCLASS is absent/broken?
> + * The data used in this test come from RFC6979

Nit: 'the class UCLASS_ECDSA' reads oddly - 'the UCLASS_ECDSA uclass'
is the usual phrasing. Also please mention which curve/vector (P-256,
SHA-256 sample) so a future reader knows where the magic hex came from
without chasing the RFC.

Regards,
Simon
