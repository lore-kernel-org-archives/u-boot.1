Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503A2CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:34:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC81F848FC;
	Mon, 25 May 2026 17:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DIB1mlbX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D43F8490B; Mon, 25 May 2026 17:34:49 +0200 (CEST)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BE7B848BD
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-631333ee9e4so2970945137.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:34:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779723286; cv=none;
 d=google.com; s=arc-20240605;
 b=cOXbkXTZGQkMsM/l+7S0/ZkB3WwVqYE5wCLlEiKgvKyLan51OaB4/OuRjUZ52m6DpR
 8duZ3t1JJZeJRWOPb+CwlvAjds8CySmdTJJnYz1Wco1gwGNcKFR2I4ZfMFdn+Hsg/Rh2
 FlthC9fw/c6WiRJO5b4mXI3bjIP33fylzj8BjS/0Og1T9RFW/r6MbB/NbZ+Kx8OipXUH
 zEoudZP6g51jwyq4n64kfD1QFZBB4TuBwnqXJtuyQ00tfntB/BW3V8SVqH1AmYxiC3uL
 BnU3p0ocAoUSECPSBo6vYLfFgwd3UP11fbPSRAEQDhMVo1fLD+m7wvEhGTylsvdHe9lh
 XrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Rywqlb65iDLb4d2mnINF543KR3wo5MQ2jowQyDMKMLg=;
 fh=XpsOi1/hxDsLEnM/Apzerg7ySfixcFfAZkweatO3nns=;
 b=hwKYjn6PBXEXv9RbKeQ1riHFt0LDIMdiS20ZSFBbTTha9BDplKaqMdiJLDcJon+qHc
 srVdvJEw48ltv9EDlnUE3YAAabBFfrlsULSXJWP3REG8luNAtW/xJUQ9kRYFOlS3UPd7
 YD6xJXjso9VSOb7GXFXKoocW0p8C02lsHHt9/V/yN0MiNePnmNkBxsg+fI3K3y1pm7ze
 VMhjOZjcD913GONvp1irOTHFbUNV8klQzjKjy1rFifgDu1KuKK/V1iBgcSoyEtUnMsIK
 B4yHUCnGtGXJeqSk9UixHNbaQfCn+QnAIwpehIOe1QNJt3TsHLuJtlwPFuam23+Pe/Yh
 SCPA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779723286; x=1780328086; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rywqlb65iDLb4d2mnINF543KR3wo5MQ2jowQyDMKMLg=;
 b=DIB1mlbXkgQtAucTN9IVKpp43Fg3LHld9Bnc2aKRI9Dt3tcOZsuzWmBw5+fZc8BzDH
 ZEObORrtYxRR0VStbDbEvuQzlZn9NZGbuYWw4d/HuIHrCgpZuOGNb52tsSyLcz7ekg+d
 97Q9wkVf5RnGBp4dTopJgZQAGMOfgOx21R9MTTIzCu5hKc4k/XuJFTSOWGimGHvS2Tzy
 t3FALo+FTI8p6GE6qICIQfovHMPBThZ3dOyRGaAISY+jQJ6fqRdPLGq1gd50hXlZSFpW
 8O0Gmv4tuSOLLwUuGl3BkWxY7+9jgWyldNZK3JNWMKHznMr5Ly5pfinxoRKmvroRCyAn
 sLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779723286; x=1780328086;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rywqlb65iDLb4d2mnINF543KR3wo5MQ2jowQyDMKMLg=;
 b=IMW5cNpk19NaTq+opAA7xvSdrfdrGcQ7JnjuN0ErhW+BC7IzpMrqyJ7bch1WnwupxZ
 br82vVi8EohyVjBE8odlMI8llMMCO6KoRK15ikee2nRKjta9fDOte6tcM+Ek+IFjsru5
 evmLcZHjHsFyW+3CA3ZP5p5Or7BOAqXu5cMoPcqt6YAoeBNNs7nTMeQYNunqdmy7dDj2
 yn2drURXjoFnpIVka4zdUfb9ZgzgBN5aHMNAfbP1/pFgYuEqfC5RJovobNQ0d14aIlCq
 IymoeWoItcTDH9F/gqlYMikpPUyksiHQTVfgDr7H/O787XBfpoFTGhzJyZibOvtLD5S2
 9S9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QH9os2mD0rt+8/gx/JAPQ8NPgL78HZSMaNHpMN71SNSgsxJ13avtRtI0grVYnEn1nqqP4Jrw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0beXWo0oYfuZaLxoSYNiiznGD4MZTCHpTOoSvMrJN3pyaInp1
 t2ArHWvTfKtsCBn5hBIfYtFbIjqr9qB2tjwYoWftlseIOUnumU55XrvTuF4WBvgzqiWL8RIQFDh
 yBeiEkFLNYx7Pfbx1KcMAN201q2l5y3u8U30q68w=
X-Gm-Gg: Acq92OEPdWeoADTTbZswQ5EhyZ4dl4yt7YeW5ReL9WGVrsLPU6YRPR2PPwZ0uhkkJaW
 dHh4JZDIIGOeRBpetN9vJHRhW6ilvXWStG3iHmTo7R9kwmZlFh+ODw813lIMsTSbvAxHOcyQInH
 UtLdu9J1pMENZhkNCIwo3R4c4RpzKcLPLFo8mSgtHg0fIREZI+RuIRc8K3WZh2ZvGN85xqN4f4u
 IOcl1Rjw6MpXCWPiC3D2Ga1n+u3YKRf4/4fUTiMWvR2yeR4V61DjGCaeqpCqDy39vyPTGgrjupI
 0NMd4Tx7
X-Received: by 2002:a05:6102:5114:b0:631:23fa:38d7 with SMTP id
 ada2fe7eead31-67c80d66fc5mr6499015137.14.1779723285983; Mon, 25 May 2026
 08:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
 <20260525135241.88348-11-philippe.reynes@softathome.com>
In-Reply-To: <20260525135241.88348-11-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 25 May 2026 11:34:35 -0400
X-Gm-Features: AVHnY4Jq7bBuhLtaE_JKWWWIAQKV122PciL5KJFkmu4sjI6-vX5w7PdN10hSR0s
Message-ID: <CAMDkj5zNunJ=ZXvTRgh3Y-A4cTcO+tkQTaFEp9++L28AsuoncA@mail.gmail.com>
Subject: Re: [PATCH v6 10/15] tools: mkimage: pre-load: add support of ecdsa
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
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

On Mon, May 25, 2026 at 9:52=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Right now, mkimage can only create pre-load header
> using rsa. We add the support of ecdsa.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v3:
> - initial version
> v4:
> - use pre_load_noffset (do not compute it again)
> - release memory allocated with strdup
> - clean code
> v5:
> - check checksum and algo before using them
> v6:
> - no change
>
>  lib/ecdsa/ecdsa-libcrypto.c | 29 +++++++++---
>  tools/image-host.c          | 92 ++++++++++++++++++++++++++++++++-----
>  2 files changed, 103 insertions(+), 18 deletions(-)
>

Looks good to me. Thanks!
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>


> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> index 89c1851b71d..4a1d0caf502 100644
> --- a/lib/ecdsa/ecdsa-libcrypto.c
> +++ b/lib/ecdsa/ecdsa-libcrypto.c
> @@ -507,14 +507,9 @@ int ecdsa_verify(struct image_sign_info *info,
>         return ret;
>  }
>
> -static int do_add(struct signer *ctx, void *fdt, const char *key_node_na=
me,
> -                 struct image_sign_info *info)
> +static int search_key_node(void *fdt, const char *key_node_name)
>  {
> -       int signature_node, key_node, ret, key_bits;
> -       const char *curve_name;
> -       const EC_GROUP *group;
> -       const EC_POINT *point;
> -       BIGNUM *x, *y;
> +       int signature_node, key_node;
>
>         signature_node =3D fdt_subnode_offset(fdt, 0, FIT_SIG_NODENAME);
>         if (signature_node =3D=3D -FDT_ERR_NOTFOUND) {
> @@ -549,6 +544,26 @@ static int do_add(struct signer *ctx, void *fdt, con=
st char *key_node_name,
>                 return key_node;
>         }
>
> +       return key_node;
> +}
> +
> +static int do_add(struct signer *ctx, void *fdt, const char *key_node_na=
me,
> +                 struct image_sign_info *info)
> +{
> +       int key_node, ret, key_bits;
> +       const char *curve_name;
> +       const EC_GROUP *group;
> +       const EC_POINT *point;
> +       BIGNUM *x, *y;
> +
> +       if (info->required_keynode >=3D 0) {
> +               key_node =3D info->required_keynode;
> +       } else {
> +               key_node =3D search_key_node(fdt, key_node_name);
> +               if (key_node < 0)
> +                       return key_node;
> +       }
> +
>         group =3D EC_KEY_get0_group(ctx->ecdsa_key);
>         key_bits =3D EC_GROUP_order_bits(group);
>         curve_name =3D OBJ_nid2sn(EC_GROUP_get_curve_name(group));
> diff --git a/tools/image-host.c b/tools/image-host.c
> index f5681d6c1f9..ae35a75d5a6 100644
> --- a/tools/image-host.c
> +++ b/tools/image-host.c
> @@ -13,6 +13,7 @@
>  #include <fdt_region.h>
>  #include <image.h>
>  #include <version.h>
> +#include <u-boot/ecdsa.h>
>
>  #if CONFIG_IS_ENABLED(FIT_SIGNATURE)
>  #include <openssl/pem.h>
> @@ -1245,13 +1246,74 @@ err_cert:
>         return ret;
>  }
>
> +static int fit_pre_load_data_key_rsa(const char *keydir, void *keydest,
> +                                    int pre_load_noffset, const void *ke=
y_name)
> +{
> +       unsigned char *pubkey =3D NULL;
> +       int ret, pubkey_len;
> +
> +       /* Read public key */
> +       ret =3D read_pub_key(keydir, key_name, &pubkey, &pubkey_len);
> +       if (ret < 0)
> +               goto out;
> +
> +       /* Add the public key to the device tree */
> +       ret =3D fdt_setprop(keydest, pre_load_noffset, "public-key",
> +                         pubkey, pubkey_len);
> +       if (ret)
> +               fprintf(stderr, "Can't set public-key in node %s (ret =3D=
 %d)\n",
> +                       IMAGE_PRE_LOAD_PATH, ret);
> + out:
> +       return ret;
> +}
> +
> +static int fit_pre_load_data_key_ecdsa(const char *keydir, void *keydest=
,
> +                                      int pre_load_noffset, const void *=
key_name,
> +                                      const void *algo_name)
> +{
> +       struct image_sign_info info;
> +       int node, ret =3D 0;
> +
> +       memset(&info, 0, sizeof(info));
> +       info.keydir =3D keydir;
> +       info.keyname =3D strdup(key_name);
> +       info.name =3D strdup(algo_name);
> +       info.checksum =3D image_get_checksum_algo(algo_name);
> +       if (!info.checksum) {
> +               fprintf(stderr, "Can't find valid checksum from %s\n",
> +                       (char *)algo_name);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +       info.crypto =3D image_get_crypto_algo(algo_name);
> +       if (!info.crypto) {
> +               fprintf(stderr, "Can't find valid crypto from %s\n",
> +                       (char *)algo_name);
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +       info.required_keynode =3D pre_load_noffset;
> +
> +       node =3D ecdsa_add_verify_data(&info, keydest);
> +       if (node < 0) {
> +               fprintf(stderr, "Can't add verify data: err =3D %d\n", no=
de);
> +               ret =3D -EIO;
> +       }
> +
> + out:
> +       free((void *)info.keyname);
> +       free((void *)info.name);
> +
> +       return ret;
> +}
> +
>  int fit_pre_load_data(const char *keydir, void *keydest, void *fit)
>  {
>         int pre_load_noffset;
>         const void *algo_name;
>         const void *key_name;
> -       unsigned char *pubkey =3D NULL;
> -       int ret, pubkey_len;
> +       char *name;
> +       int ret;
>
>         if (!keydir || !keydest || !fit)
>                 return 0;
> @@ -1278,17 +1340,25 @@ int fit_pre_load_data(const char *keydir, void *k=
eydest, void *fit)
>                 goto out;
>         }
>
> -       /* Read public key */
> -       ret =3D read_pub_key(keydir, key_name, &pubkey, &pubkey_len);
> -       if (ret < 0)
> +       /* Is it a RSA or an ECDSA key */
> +       name =3D strchr((const char *)algo_name, ',');
> +       if (!name) {
> +               fprintf(stderr, "The name of the algo is invalid: %s\n",
> +                       (char *)algo_name);
> +               ret =3D -EINVAL;
>                 goto out;
> +       }
> +       name +=3D 1;
>
> -       /* Add the public key to the device tree */
> -       ret =3D fdt_setprop(keydest, pre_load_noffset, "public-key",
> -                         pubkey, pubkey_len);
> -       if (ret)
> -               fprintf(stderr, "Can't set public-key in node %s (ret =3D=
 %d)\n",
> -                       IMAGE_PRE_LOAD_PATH, ret);
> +       if (!strncmp(name, "rsa", 3)) {
> +               ret =3D fit_pre_load_data_key_rsa(keydir, keydest, pre_lo=
ad_noffset, key_name);
> +       } else if (!strncmp(name, "ecdsa", 5)) {
> +               ret =3D fit_pre_load_data_key_ecdsa(keydir, keydest, pre_=
load_noffset,
> +                                                 key_name, algo_name);
> +       } else {
> +               fprintf(stderr, "The algo %s is not supported\n", (char *=
)algo_name);
> +               ret =3D -EINVAL;
> +       }
>
>   out:
>         return ret;
> --
> 2.43.0
>
