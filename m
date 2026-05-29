Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C77CD4F54
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 15:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B954846A3;
	Fri, 29 May 2026 17:53:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lGTTG4Tn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFB20846F4; Fri, 29 May 2026 17:53:11 +0200 (CEST)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6716F84671
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 17:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-6c449ac3588so172133137.3
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 08:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780069987; cv=none;
 d=google.com; s=arc-20240605;
 b=EjNBogzYNipWmi9aWM1IkBYXSs0Wf5IoqQX0bQsAXGG2vwSHBwm68BJmPZwt5GSQk7
 AgUPV0ywM4EHJITQVQg58MU4eb0qtTi6JHfx1n6eEUD3uRrzr/Qc9msJt+MOWJdVGWhA
 EpMfPF4HN24IfODCxaO/qfC8YkOqwWRjlurde76VzC/sZsIvY3k3dPYILD6rqu5AVHdB
 EYmYXfkqAfqODmkc3f+1w31jDav+dNtnSPHtQNEZ+AHqjpc2SYQ8WBmJZRmp4FcXGzrs
 pQFrFAD2lTu3yEkeoTjvVvEX5J/rMjdw8qXM0xPzfBt2ZpQwrN2yTpV5Z/ePjJfjqBlS
 7oaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Nl927E4kzU7hWS1g5TId6UC5nsMittfnPvDkXx0OV5Q=;
 fh=su6kSFX1WkXBISbKi66tQAEtCcYI1Zw27Yx7dbUOdSI=;
 b=MkFLY+MAyS9VNDNWdOD3cBmONQbjXdVQ6vqIyx9n16e4/XwqIjNvnBdGGT4q6Yh77Y
 3uozNRPSJ/7pdSVlc1UltR6pWP49we9JNHiLaS9ncv+JPhlOqnWlRCFUWOwKxmDIXM6y
 6f90mweGfH/6bF/Y1D5Xxm2LvYikzPqFhTtEdw+7HcOtCMcKf1H8G7AuAbCyHYLpvhAv
 pGZLsI0XVzukHO5DctgUXhBXJJp/LCxF9iRyT1zo0EIByB0xTIWwG0i4a7jmQHKENrJl
 +goJ76YMLHWLQtRY26/JEauyofLFoKBIW5Yj8zWxWXGHdKjeOb3hBPJZXg127EjgTH1V
 y0Kg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780069987; x=1780674787; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nl927E4kzU7hWS1g5TId6UC5nsMittfnPvDkXx0OV5Q=;
 b=lGTTG4Tnt86vJp9XMTDzfLclsf3S2B6OKnzSkG9TNuYYGZdNW4UaTpM0zhWaHXZCtC
 TsBThr4Kj+6e9pWlSeTle5D4BmM059bmHDagI0vjdsVZMVHQdL3//AREyPjSJZGzLlZ4
 ht0hBgkQPbz/5xHWEDGyTuHxJIRWWvHP6lfvjMelxvdr+54aVv59NYP3G9m1RWInjjKW
 0cWHu9UdphFJ5+wyrog2eLEe27PE9zWP5sQE2mmAgpP0/vqL8K7H3WxOtjm8tBGgw8iW
 O7cGiHASUY6lmkL/PCn8r3p7Ign4KnMd/SwMH71Q0UhN3kHKlByr/pjk2+XHEfB4Ynte
 jOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780069987; x=1780674787;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nl927E4kzU7hWS1g5TId6UC5nsMittfnPvDkXx0OV5Q=;
 b=mMDKARcGrkAx/CqJGMfoX2W9VH8KafXR0aaxVIqPskGtiUVceSCGbxSbjSYY3977F/
 VyopNzAykkVXVU5pxdRrAfo44jDXgbl2RjxdhPCwf6ydmJrACr+wT4TlI5L3mwrqbY9i
 OWtXBp8DPFvvlN5Dung9hwOqZxFQAn8D+eLaH6Ni0NVx3v99eIAi6CmlQLPOCwPJfseP
 xayeD4QfUPjrXTr5pSx4AbviAYLbI6RI6ltLKuN27e2e4PHzoJRddTiEltx3kybqY0PH
 B9Oq2KLazz+dUxHkaEkSSc2Mj/SyaiKyatl5JZdz+wZwYnhdHHBR1T16S2P5lyVWXEuJ
 ALbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1C4/CeVx+nYfVVTtGwOoceYve7/nG8P9RcFo6Xq5j4SgmvHS1FXFenITfzm5PbRcFKb9eR5Q=@lists.denx.de
X-Gm-Message-State: AOJu0YxWhLmsIdomJH61O42u1TsVXgomLiMXJlpFaDCAmXS04Yt6FDJv
 FFlMnO+Cm62eijQp/LcQ2HrOtGCaRFAYTxFfLN01IA1OqoZ3o1FKxxwn5RncQrEyPtKZ2svO85T
 ktJdmMcyVG28cL6stWcHZJLCOGBjfoM8=
X-Gm-Gg: Acq92OGcx+rpkU4vhvZ7g+8+EoJfcXzxkZhki0LH6OwAOSndZMCyudUWND1LLA8TruI
 rFRJD3wbX3CUeedD/QflbQJtBO0KfkIxYdGgkQ0ZrFVyWPhgG11SOgsC+Bi5puT69KKREqU8JVf
 vBOfolM0sTTnm8qs+qI7n26hTK4h8ArCWIz5VICcdSavpXEHenyQ+nCv2+jUtUOs0F0XPZIOQSt
 Gydu0++w5WNafkLqprWbC2KfFFW/2YMJnC1jiLhe197QrQC8FziJChAl0/hCyNOeAgeIx8syZVr
 e6JKSdIfqC7D+UGTIjzVcOAx/vUC
X-Received: by 2002:a05:6102:534e:b0:631:8665:350f with SMTP id
 ada2fe7eead31-6bf32f55badmr1771311137.13.1780069987322; Fri, 29 May 2026
 08:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260528081916.11355-1-philippe.reynes@softathome.com>
 <20260528081916.11355-7-philippe.reynes@softathome.com>
In-Reply-To: <20260528081916.11355-7-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Fri, 29 May 2026 11:52:56 -0400
X-Gm-Features: AVHnY4Kk9oW5wdx-WKwgt_6XlT8ytsN04okyAIBxYOJDinx_HWR_4QDyCFynyL4
Message-ID: <CAMDkj5wgn_0cO54fBfFhEjOYKXezoTFcNJgHhBoF-JOGeVFhXg@mail.gmail.com>
Subject: Re: [PATCH v7 06/15] test: dm: ecdsa.c: clean this test as software
 ecdsa is now implemented
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

On Thu, May 28, 2026 at 4:19=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> The test ecdsa was done when ecdsa was only supported by hardware.
> So it wasn't possible to test ecdsa on sandbox, and there is a test
> to check that ecdsa is not supported on sandbox.
> Now, there is a software implementation of ecdsa. So we add a test
> to verify that ecdsa_verify may be used on sandbox.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - initial version
> v3:
> - no change
> v4:
> - add a test that use ecdsa_verify
> v5:
> - change secp256r1 to ecdsa256
> - check that checksum and crypto are not null
> v6:
> - update commit message
> - remove fdt_strerror in macro CHECK
> - return ENOMEM when malloc fails
> - add a define FDT_MAX_SIZE to avoid hardcoded value
> v7:
> - change uint8_t to u8
> - set required_keynode to -1
>
>  test/dm/ecdsa.c | 109 +++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 99 insertions(+), 10 deletions(-)
>

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>

Thanks and regards,
Raymond


> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
> index d7eac7115f7..df41a4f7c9f 100644
> --- a/test/dm/ecdsa.c
> +++ b/test/dm/ecdsa.c
> @@ -3,36 +3,125 @@
>  #include <crypto/ecdsa-uclass.h>
>  #include <dm.h>
>  #include <dm/test.h>
> +#include <malloc.h>
>  #include <test/ut.h>
>  #include <u-boot/ecdsa.h>
>
> +#define FDT_MAX_SIZE           512
> +
> +#define CHECK(op) ({                                                    =
       \
> +               int err =3D op;                                          =
         \
> +               if (err < 0) {                                           =
       \
> +                       printf("%s: function %s returns an error (%d)\n",=
       \
> +                              __func__, #op, err);                      =
       \
> +                       return err;                                      =
       \
> +               }                                                        =
       \
> +                                                                        =
       \
> +               err;                                                     =
       \
> +       })
> +
> +static int set_fdt_ecdsa_point(char *fdt, char *name, const char *data, =
size_t len)
> +{
> +       char *value =3D NULL;
> +       int ret =3D 0;
> +
> +       if (!fdt || !name || !data) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       value =3D malloc(len / 2);
> +       if (!value) {
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       ret =3D hex2bin(value, data, len / 2);
> +       if (ret)
> +               goto out;
> +
> +       ret =3D fdt_property(fdt, name, value, len / 2);
> +       if (ret)
> +               goto out;
> +
> + out:
> +       free(value);
> +       return ret;
> +}
> +
> +static int create_fdt_with_ecdsa_key(char *fdt, size_t size,
> +                                    const char *name, const char *curve,
> +                                    const char *x, const char *y)
> +{
> +       CHECK(fdt_create(fdt, size));
> +       CHECK(fdt_finish_reservemap(fdt));
> +       CHECK(fdt_begin_node(fdt, ""));
> +       CHECK(fdt_begin_node(fdt, "signature"));
> +       CHECK(fdt_begin_node(fdt, name));
> +       CHECK(fdt_property_string(fdt, "algo", "sha256,ecdsa256"));
> +       CHECK(set_fdt_ecdsa_point(fdt, "ecdsa,y-point", y, strlen(y)));
> +       CHECK(set_fdt_ecdsa_point(fdt, "ecdsa,x-point", x, strlen(x)));
> +       CHECK(fdt_property_string(fdt, "ecdsa,curve", curve));
> +       CHECK(fdt_property_string(fdt, "key-name-hint", name));
> +       CHECK(fdt_end_node(fdt)); /* name */
> +       CHECK(fdt_end_node(fdt)); /* "signature" */
> +       CHECK(fdt_end_node(fdt)); /* "" */
> +       CHECK(fdt_finish(fdt));
> +       CHECK(fdt_pack(fdt));
> +
> +       return 0;
> +}
> +
>  /*
>   * Basic test of the ECDSA uclass and ecdsa_verify()
>   *
> - * ECDSA implementations in u-boot are hardware-dependent. Until we have=
 a
> - * software implementation that can be compiled into the sandbox, all we=
 can
> - * test is the uclass support.
> + * ECDSA software implementation is tested in another test,
> + * so we only check that the class UCLASS_ECDSA may be used.
>   *
> - * The uclass_get() test is redundant since ecdsa_verify() would also fa=
il. We
> - * run both functions in order to isolate the cause more clearly. i.e. i=
s
> - * ecdsa_verify() failing because the UCLASS is absent/broken?
> + * The data used in this test come from RFC6979
>   */
>  static int dm_test_ecdsa_verify(struct unit_test_state *uts)
>  {
>         struct uclass *ucp;
> +       const char *full_name =3D "sha256,ecdsa256";
> +       const char *name =3D "key-ecdsa-256";
> +       const char *curve =3D "prime256v1";
> +       const char *x =3D "60FED4BA255A9D31C961EB74C6356D68C049B8923B61FA=
6CE669622E60F29FB6";
> +       const char *y =3D "7903FE1008B8BC99A41AE9E95628BC64F2F1B20C2D7E9F=
5177A3C294D4462299";
> +       const char *r =3D "EFD48B2AACB6A8FD1140DD9CD45E81D69D2C877B56AAF9=
91C34D0EA84EAF3716";
> +       const char *s =3D "F7CB1C942D657C41D436C7A1B6E29F65F3E900DBB9AFF4=
064DC4AB2F843ACDA8";
> +       u8 sig[64];
> +       char fdt[FDT_MAX_SIZE];
>
> -       struct checksum_algo algo =3D {
> -               .checksum_len =3D 256,
> +       struct image_region region[] =3D {
> +               {
> +                       .data =3D "sample",
> +                       .size =3D strlen("sample"),
> +               },
>         };
>
>         struct image_sign_info info =3D {
> -               .checksum =3D &algo,
> +               .checksum =3D image_get_checksum_algo(full_name),
> +               .crypto =3D image_get_crypto_algo(full_name),
> +               .required_keynode =3D -1,
> +               .fdt_blob =3D fdt,
>         };
>
> +       ut_assertnonnull(info.checksum);
> +       ut_assertnonnull(info.crypto);
> +
> +       /* create a fdt with the public key */
> +       ut_asserteq(0, create_fdt_with_ecdsa_key(fdt, sizeof(fdt), name, =
curve, x, y));
> +
> +       /* prepare the signature */
> +       ut_asserteq(0, hex2bin(sig +  0, r, strlen(r) / 2));
> +       ut_asserteq(0, hex2bin(sig + 32, s, strlen(s) / 2));
> +
>         ut_assertok(uclass_get(UCLASS_ECDSA, &ucp));
>         ut_assertnonnull(ucp);
> -       ut_asserteq(-ENODEV, ecdsa_verify(&info, NULL, 0, NULL, 0));
> +       ut_asserteq(0, ecdsa_verify(&info, region, 1, sig, sizeof(sig)));
>
>         return 0;
>  }
> +
>  DM_TEST(dm_test_ecdsa_verify, UTF_SCAN_PDATA | UTF_SCAN_FDT);
> --
> 2.43.0
>
