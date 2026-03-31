Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2CB10F92E6
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 17:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B32683F5B;
	Tue, 31 Mar 2026 19:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dypQ1TJg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66EF084010; Tue, 31 Mar 2026 19:08:05 +0200 (CEST)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C03A83E7A
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 19:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-602903ad849so2088387137.3
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 10:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774976881; cv=none;
 d=google.com; s=arc-20240605;
 b=N/qbgMtD1xD6nTlAUEJRvBB4F9YOCBe1n52vg+DTU4VJcikCxYOulCPPCs5kFaEFBD
 kYwJpnlCD7F6T3qqu5d8n8gMaoAjqIccxWqcDBD8Idvfn460u+JM48JS9yhsx2/XQ9gd
 2jc9GUNgxoZGnx4koDiuf51iw3BYDel76vat6swAqNXNAOALfT6Fv0fibFi5PyPlLXkU
 mV4iJ5Cy6HhXbH4IydxkYtVbJWk9ooonB/3Vez2lWSI+70F1aL5V5drhQD/aj/egklzp
 mejDzjmfY53dOxNby67NJNthe17KBDNXPNjrZq+z3Ze2VgdtZyuFS8elSJRUkOk5C4yc
 FPnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TGvjXS1sPLccDkjeLWZZAlcXDXd4jm2aHfQJcsauSDc=;
 fh=0Gq5ZbDsU8PALbFCwR/FZKcgyKj/v+eLYgYMB8FJQhs=;
 b=lfiYsqcYRRhoSeaYgM4COA9npzKHQjICysw5G20vqkq8NixhIL+Cl+qS3N/lnB4FWo
 yQYcZGvvLpILSk1PW61S+h1jZ8JNWFH7c7ZxsdpW0hsZgh8XJbSOp0kT4KCsqx0KDfhO
 i4R0/qH0Seks+iVsLtAxBNM8tcMKIq8AZEq6INOX7Q0OatbM44JoczbYEYNuUy5XhEIg
 LFoJmtw2B9W5js3P8GG3/CUSn4WxHIohFZb92psAne7zItH7kWYvEZFVEe0MKf0WfH/t
 rjCHRUzxMD9e7JlxyTjRQztY2u7RQmEFVjs/zTVkO34+pgJU+++8g9ZChXhJXmgRey8y
 h4Ig==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774976881; x=1775581681; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGvjXS1sPLccDkjeLWZZAlcXDXd4jm2aHfQJcsauSDc=;
 b=dypQ1TJgurtTI1AI6IlC6HK5NUAGmECq+BkilXn1zwVli5tGAkZ9h4HO9qzQxK+iFu
 /2vBLtjccAdmtOOVbznrZ/2otrxV5R9V4duEr488BJM5uHKiLGCzCuEjF+Kt0Ef1B7jw
 NZ4CU6brj9sgxbQy9iNLHTVHIfpm5ywJkg/2VXM8u2Lp4g/yv6Rl7tmExGNWUxlPF7Db
 mVjuBvSwS3rugiy5HXorwa3HAflD8LmNTS65AhHjlD328NxzqiPs02LTpmzVQGEsiEG+
 YcL0osu1QMTk3ai/FoezAi5KdEHY8ArBG/iunIxEiSwuw9xRjOwZjSSAQ3cNJyXEHFHf
 vwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774976881; x=1775581681;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TGvjXS1sPLccDkjeLWZZAlcXDXd4jm2aHfQJcsauSDc=;
 b=OT/t5mC223gwHfx3pGK0borxwARlBTGwdMT5CFveUrqeF1rT3jXsoF9hAbWXJ+NgnR
 i3oNjhmA9FFxFLLG7YZ0gVC2atJLPkfbS9WWQF34rL3J0bQ4Wo/bAhErVWwmA14o+C1e
 QYnZr/81TTQwR0EjkEEGTIvehFjzAELVA5IA8A24oOrCVGwL+xtb5kVCB8zZhN1aepJT
 0TyUojev++7sFQnuoOiealUP2IYhvfF0bhTk2XzNyALjxblYCeIu5fzIf+LIpkvrwoPy
 QP4h7CHr3KSDwImw6f6KMLtOG6TKivLkvDKatCKzvjgABb3owR0CGH2MmdzxXlwsW7sa
 SmTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBdxJ4IGwllr3I/HgEpRZwn8rHhpU9L1TxWSn36LEk3TrMbU5SNCAIUg9o7x2k/SMPdig1sVU=@lists.denx.de
X-Gm-Message-State: AOJu0YzJyA8FnF7WXqw1Qlwy8MNvfcE+fQ7ORhHMipW9QNuV+gFnAfun
 6Kw18+gXoD0Q4TvdsXH0+sogdwNniLc3G5LsWQZzNFKwxKjdIDuXuStYIMejMvCzU3LrCAzy6zg
 sGS/q6/I1/05kkYzyBmsEnm/vJOX1SdPmwkzs
X-Gm-Gg: ATEYQzwOyKpOygVB0+LjHrtH+6mT8nQT/x0aTBoAKHgL9q+Gz6ijSdp8sA+HmqQWpOx
 AHsyYaK8itMT6nrs1IzdUNEhu76DOEKwzSHNQs6nVm3sbvJYqsEzEazx3V+bt+ek3Gb61qpgwPQ
 Vdzs7aRsUvZUdO8D8pR1IOlSBYIg7YJx//f6fpnWWEqFzyRnpf/Edl/CHpF6Kg11qwe9qX9oQfc
 9xKjiFQtM6iqx45J07rLErIEiedNtUbJFf7mqbOLrm+FpstuYYQDAG7DtxXbdp4/ZWrsoeLDvti
 6XD+ep2R
X-Received: by 2002:a05:6102:512a:b0:602:8ad9:1f6f with SMTP id
 ada2fe7eead31-60567d7d0fbmr44081137.5.1774976880968; Tue, 31 Mar 2026
 10:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
 <20260331100047.34618-6-philippe.reynes@softathome.com>
In-Reply-To: <20260331100047.34618-6-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Tue, 31 Mar 2026 13:07:49 -0400
X-Gm-Features: AQROBzCMhbW5wf_BpYdvTOpYiy1qQzExdhdQPZD3e8KfcDB7U99NQAXcBWVbv-E
Message-ID: <CAMDkj5wkhRJA=+LymhFRw0OwH1A5rvyvZu9ZTpWbY_veLkw7ww@mail.gmail.com>
Subject: Re: [PATCH v3 05/15] ecdsa: fix support of secp521r1
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.denx.de
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

On Tue, Mar 31, 2026 at 6:00=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Current implementation of ecdsa only supports key len aligned on
> 8 bits. But the curve secp521r1 use a key of 521 bits which is not

s/use/uses

> aligned on 8 bits. In this commit, we update the key management
> for ecdsa to support key of any lenght.

s/key/keys
s/lenght/length
'any' is too arbitrary.

>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - intitial version
> v3:
> - fix typo in comments
>
>  lib/ecdsa/ecdsa-libcrypto.c | 21 +++++++++++++++++++--
>  lib/ecdsa/ecdsa-verify.c    | 24 ++++++++++++++++++++++--
>  lib/fdt-libcrypto.c         |  2 +-
>  tools/image-sig-host.c      |  2 +-
>  4 files changed, 43 insertions(+), 6 deletions(-)
>
> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> index c4bfb2cec61..f8ed694595c 100644
> --- a/lib/ecdsa/ecdsa-libcrypto.c
> +++ b/lib/ecdsa/ecdsa-libcrypto.c
> @@ -45,6 +45,7 @@ static int fdt_get_key(struct ecdsa_public_key *key, co=
nst void *fdt, int node)
>  {
>         int x_len;
>         int y_len;
> +       int expected_len;
>
>         key->curve_name =3D fdt_getprop(fdt, node, "ecdsa,curve", NULL);
>         if (!key->curve_name)
> @@ -54,6 +55,8 @@ static int fdt_get_key(struct ecdsa_public_key *key, co=
nst void *fdt, int node)
>                 key->size_bits =3D 256;
>         else if (!strcmp(key->curve_name, "secp384r1"))
>                 key->size_bits =3D 384;
> +       else if (!strcmp(key->curve_name, "secp521r1"))
> +               key->size_bits =3D 521;
>         else
>                 return -EINVAL;
>
> @@ -63,7 +66,19 @@ static int fdt_get_key(struct ecdsa_public_key *key, c=
onst void *fdt, int node)
>         if (!key->x || !key->y)
>                 return -EINVAL;
>
> -       if (x_len !=3D key->size_bits / 8 || y_len !=3D key->size_bits / =
8)
> +       /*
> +        * The public key is stored as an array of u32, so if the key siz=
e is
> +        * not a multiple of 32 (for example 521), we may have extra byte=
s.
> +        * To avoid any issue later, we shift the x and y pointer to the =
first
> +        * useful byte.
> +        */
> +       expected_len =3D (key->size_bits + 7) / 8;

DIV_ROUND_UP(key->size_bits, 8)

> +       if (x_len > expected_len)
> +               key->x +=3D x_len - expected_len;

Please don't move the key->x directly, instead, use local variables to
store adjusted pointers.

> +       if (y_len > expected_len)
> +               key->y +=3D y_len - expected_len;

Ditto.

> +
> +       if (x_len < expected_len || y_len < expected_len)
>                 return -EINVAL;
>
>         return 0;
> @@ -89,6 +104,8 @@ static int read_key_from_fdt(struct signer *ctx, const=
 void *fdt, int node)
>                 nid =3D NID_X9_62_prime256v1;
>         } else if (!strcmp(pubkey.curve_name, "secp384r1")) {
>                 nid =3D NID_secp384r1;
> +       } else if (!strcmp(pubkey.curve_name, "secp521r1")) {
> +               nid =3D NID_secp521r1;
>         } else {
>                 fprintf(stderr, "Unsupported curve name: '%s'\n", pubkey.=
curve_name);
>                 return -EINVAL;
> @@ -111,7 +128,7 @@ static int read_key_from_fdt(struct signer *ctx, cons=
t void *fdt, int node)
>                 return -ENOMEM;
>         }
>
> -       len =3D pubkey.size_bits / 8;
> +       len =3D (pubkey.size_bits + 7) / 8;
>
>         uint8_t buf[1 + len * 2];
>
> diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
> index 629b662cf6c..b90571e9fff 100644
> --- a/lib/ecdsa/ecdsa-verify.c
> +++ b/lib/ecdsa/ecdsa-verify.c
> @@ -24,13 +24,15 @@ static int ecdsa_key_size(const char *curve_name)
>                 return 256;
>         else if (!strcmp(curve_name, "secp384r1"))
>                 return 384;
> +       else if (!strcmp(curve_name, "secp521r1"))
> +               return 521;
>
>         return 0;
>  }
>
>  static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, in=
t node)
>  {
> -       int x_len, y_len;
> +       int expected_len, x_len, y_len;
>
>         key->curve_name =3D fdt_getprop(fdt, node, "ecdsa,curve", NULL);
>         if (!key->curve_name) {
> @@ -50,7 +52,19 @@ static int fdt_get_key(struct ecdsa_public_key *key, c=
onst void *fdt, int node)
>         if (!key->x || !key->y)
>                 return -EINVAL;
>
> -       if (x_len !=3D (key->size_bits / 8) || y_len !=3D (key->size_bits=
 / 8)) {
> +       /*
> +        * The public key is stored as an array of u32, so if the key siz=
e is
> +        * not a multiple of 32 (for example 521), we may have extra byte=
s.
> +        * To avoid any issue later, we shift the x and y pointer to the =
first
> +        * useful byte.
> +        */
> +       expected_len =3D (key->size_bits + 7) / 8;
> +       if (x_len > expected_len)
> +               key->x +=3D x_len - expected_len;

Ditto.

> +       if (y_len > expected_len)
> +               key->y +=3D y_len - expected_len;

Ditto.

> +
> +       if (x_len < expected_len || y_len < expected_len) {
>                 printf("%s: node=3D%d, curve@%p x@%p+%i y@%p+%i\n", __fun=
c__,
>                        node, key->curve_name, key->x, x_len, key->y, y_le=
n);
>                 return -EINVAL;
> @@ -135,6 +149,12 @@ U_BOOT_CRYPTO_ALGO(ecdsa384) =3D {
>         .verify =3D ecdsa_verify,
>  };
>
> +U_BOOT_CRYPTO_ALGO(ecdsa521) =3D {
> +       .name =3D "ecdsa521",
> +       .key_len =3D ECDSA521_BYTES,
> +       .verify =3D ecdsa_verify,
> +};
> +
>  /*
>   * uclass definition for ECDSA API
>   *
> diff --git a/lib/fdt-libcrypto.c b/lib/fdt-libcrypto.c
> index ecb0344c8f6..090246b44e9 100644
> --- a/lib/fdt-libcrypto.c
> +++ b/lib/fdt-libcrypto.c
> @@ -10,7 +10,7 @@
>  int fdt_add_bignum(void *blob, int noffset, const char *prop_name,
>                    BIGNUM *num, int num_bits)
>  {
> -       int nwords =3D num_bits / 32;
> +       int nwords =3D (num_bits + 31) / 32;

DIV_ROUND_UP(num_bits, 32)

>         int size;
>         uint32_t *buf, *ptr;
>         BIGNUM *tmp, *big2, *big32, *big2_32;
> diff --git a/tools/image-sig-host.c b/tools/image-sig-host.c
> index 5285263c616..a2272b196e7 100644
> --- a/tools/image-sig-host.c
> +++ b/tools/image-sig-host.c
> @@ -84,7 +84,7 @@ struct crypto_algo crypto_algos[] =3D {
>                 .verify =3D ecdsa_verify,
>         },
>         {
> -               .name =3D "secp521r1",
> +               .name =3D "ecdsa521",

Does the renaming cause an ABI change and comply with FIT / image
signing naming conventions?

Regards,
Raymond

>                 .key_len =3D ECDSA521_BYTES,
>                 .sign =3D ecdsa_sign,
>                 .add_verify_data =3D ecdsa_add_verify_data,
> --
> 2.43.0
>
