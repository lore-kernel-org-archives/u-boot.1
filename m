Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19876C5AD05
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 16:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A41F483CF5;
	Fri, 20 Feb 2026 17:49:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PMmfJhyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8509983D0F; Fri, 20 Feb 2026 17:49:29 +0100 (CET)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5596B83A41
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 17:49:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-566390e7db3so2156389e0c.1
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 08:49:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771606165; cv=none;
 d=google.com; s=arc-20240605;
 b=XmUQkCY879TKZ+Hddn6nPJ678ehXUdXWlMVTsAJPGTGUfl11zaUk63Vg4m9ncihMNg
 i6Sx/CWs5sXyq4AvrbSUg1r5PO3llwaGw2UaxxA6CK9DW4etDeClQvv3mGpU01+BntGh
 ogOKndjFVaC7kYi+nVQpiIqyXRCrxiQ0DnBf2JQLa4ina7CboCsUIecRapNdeNUN1kyq
 ic3kcN0iGaz+n6d8iiC4qZvLRXvixEf5EPIIkdFDA2MpJ59B52TT3WwinwGxH+Q4wqVB
 rrjjlaCQMFiSy+4GrBBSn3t1wDhorysWK0LswYZMF9CXaKU7s05AmUXl+xE7MSDD6Qi1
 Oi0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yyZHVLnBrK/WVrkCkkjfybOUG4QXDpdEOXCnFjtcORk=;
 fh=9uZZCA4FnQ4cG9bY9TPKEsQpuxhK8MvXJKr0M04nGaU=;
 b=Sq12TW8zNsPApzxTV+r9SjT+KJiAK2dkuN97lMMWexaRBxgeMauUB0RTHtx9qDNKUs
 ZIz2ppR4u4IkgzpYX/05QkT4vqynkSAKNFIggiKeZU1xt+eZdL7pMLDeDkpY3LOnz5yr
 qJuOr8aKx7wveK2EQT0iW+Jz8cY1c6oSLJOndvYxFTYqbukqSr1fLWu772vVmCaQ8IH4
 z3cJEEJEshdgqg/Kjm1jpoOc1a9ol9fOk2jjSk+MVbrhT8X8YhbR7FJuHqRz9cDh/B1p
 AmaRiaE3cnh0cKcCNSQ1fDQN9whx1cErPQMSUNSiQ2m5cRUR7Duj8PA2ejWRBh/GLE43
 E+1w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771606165; x=1772210965; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yyZHVLnBrK/WVrkCkkjfybOUG4QXDpdEOXCnFjtcORk=;
 b=PMmfJhyVi6XGFmT2PeoJwtY5X4Qqw/ZgZFtR4aOHBL5CP34n1xwJ6Y8bS/i2QRGd58
 4G/O9kwJH7qc00/lW6SpncO+4C6auzYYj/8cJlAnjQImVOkbmU5sQqiyoGbITue1UPdG
 7P9K5XyVgNmKWEPCCUMXVlffzd6gpFiuAl0aLUTFVDAVlvQWvGCHrDl+/n51451v23hZ
 jsatbb0RN0X6256vbjlSa8JE6a1Dnv9lDC79lzRaGGFvHJ1WmNARef/fRI/PO7TsmYl+
 sjB6e0veICOBTr3TkzpKJhmWIApAvaP+yBZ+1lgE+2YSNKMIi7prkzs6xSzXGMKAuQMB
 COfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771606165; x=1772210965;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yyZHVLnBrK/WVrkCkkjfybOUG4QXDpdEOXCnFjtcORk=;
 b=tSz2Cvr+ecaRNAfXYtB4m2xQtVVg7tM29C/faF71NkobAFAwyV1s7Cy6Svu4gzVSX1
 Lrb6Me2pdYohIFszCYhcpPxCfOwOOaVDTEuUvx8LgAagkeouUru0x8o6SOMejln8bwCH
 S+YTHv20zFhWf459ziz3rMmbA++sNNtwRAzeR+vKBJv/ysW4X8+VamdZSBKh/Ltx7fk9
 b2Yk/K1sXUo8WEvflbuHPEAmaBu0uAvztXV3CLNlnjoMT7qcEJzznEtBt/K4JhLFbdWC
 13d1wWond9nI4Vcf57H/tg9ZPPWkujrm5QEdBvZ0axzf9VeaBRWWWZgLmEKFyBTtVFbD
 040w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVyrj+m/uFiSD6aRtQDu2swZU+EbAsEDzlZeQ2oSdZdKi/p4CFAiCACEso/40XindImv0LzNA=@lists.denx.de
X-Gm-Message-State: AOJu0YyYLgzYLCoqRejiGyCn9Aw4ufLvY9m7IYynZnG9aAfoLLoumCQ3
 CsSBb9FxdaaNNA98fPE+GuZfZIywOBmv+5bD2mWzUw5fZRBfXsqsG9po41zc6KBc6tdr9S/eBsx
 WakECHDtBysP50Z/DFd1OkLtOqbEQvGg=
X-Gm-Gg: AZuq6aKNw89erOPqcZnv4/QJOibToufwEnFDCj7KIRblEVIJmm3alAaGN53zVRNwsaf
 juPj5b+Afmd6h59e9iYhyb2F6/29+yB8kx9x1OCjsSV5iuxqF/AQsitNG/wY4sSWLQLUw4Io/7Z
 6ogAcSEVAZWtrut1Mjb+QK62FTzocZvGaYI1YpvbmhMwJ/stS1oHWn1htiEZSPpJTD9k6d7aQtF
 uEZbHJlDUKwZ12RlIDttRk96rSA3CaJDa/kwEJGTm38bfgIP975sf1+Ac85kDs3vVyK/hZ7clOb
 0d3SBL9q
X-Received: by 2002:a05:6102:3e91:b0:5ee:a03c:8782 with SMTP id
 ada2fe7eead31-5feb3071bb5mr302932137.21.1771606165372; Fri, 20 Feb 2026
 08:49:25 -0800 (PST)
MIME-Version: 1.0
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
 <20260219132552.1499698-6-philippe.reynes@softathome.com>
In-Reply-To: <20260219132552.1499698-6-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Fri, 20 Feb 2026 11:49:12 -0500
X-Gm-Features: AaiRm537xwlRVXx0wwy5YaBrZ1koyEaIRuxFfqajyBQKAuodriu1cRVwIeHP0dY
Message-ID: <CAMDkj5wOXiUnRqV2QK-NgMkNgiDzejDkMiOinP8gShsFXRTjmg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/9] ecdsa: fix support of secp521r1
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 u-boot@lists.denx.de
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

On Thu, Feb 19, 2026 at 8:26=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Current implementation of ecdsa only supports key len aligned on
> 8 bits. But the curve secp521r1 use a key of 521 bits which is not
> aligned on 8 bits. In this commit, we update the key management
> for ecdsa to support key of any lenght.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - intitial version
>
>  lib/ecdsa/ecdsa-libcrypto.c | 21 +++++++++++++++++++--
>  lib/ecdsa/ecdsa-verify.c    | 24 ++++++++++++++++++++++--
>  lib/fdt-libcrypto.c         |  2 +-
>  tools/image-sig-host.c      |  2 +-
>  4 files changed, 43 insertions(+), 6 deletions(-)
>
> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> index c4bfb2cec61..6f25ccc783d 100644
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
> +        * the public key is stored as an array of u32, so if the key siz=
e if


s/if/is/


> +        * not a multiple of 32 (for example 521), we may have extra byte=
s.
> +        * To avoid any issue later, we shift the x and y pointer to the =
first
> +        * useful byte.
> +        */
> +       expected_len =3D (key->size_bits + 7) / 8;
> +       if (x_len > expected_len)
> +               key->x +=3D x_len - expected_len;
> +       if (y_len > expected_len)
> +               key->y +=3D y_len - expected_len;
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
> index 629b662cf6c..d87d95a5002 100644
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
> +        * the public key is stored as an array of u32, so if the key siz=
e if


s/if/is/

Regards,
Raymond


> +        * not a multiple of 32 (for example 521), we may have extra byte=
s.
> +        * To avoid any issue later, we shift the x and y pointer to the =
first
> +        * useful byte.
> +        */
> +       expected_len =3D (key->size_bits + 7) / 8;
> +       if (x_len > expected_len)
> +               key->x +=3D x_len - expected_len;
> +       if (y_len > expected_len)
> +               key->y +=3D y_len - expected_len;
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
>                 .key_len =3D ECDSA521_BYTES,
>                 .sign =3D ecdsa_sign,
>                 .add_verify_data =3D ecdsa_add_verify_data,
> --
> 2.43.0
>
