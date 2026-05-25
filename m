Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C84CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:22:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5E208489C;
	Mon, 25 May 2026 17:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="efwbseQ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47EA9848C0; Mon, 25 May 2026 17:22:43 +0200 (CEST)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18AB084859
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-95f6b47b309so1852132241.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:22:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779722560; cv=none;
 d=google.com; s=arc-20240605;
 b=bFrT8bh/qFMi1NG/AS9ZJJD7ez/5T1cer7DKrTgd868eAmDz6vujPHlo2+Fkaj8zUc
 DQR5E2IaSa8ObvmvRF3jGTCtjrtHYlnYrcfZ3F9SDC5/c2u+zS6oUoLTu34MPFrMVD5i
 Yk0ftWIb/EZ6xvGQEEGEtsBsauV8wiC7IABYnghBTQKRi0EZMDXGVeWukQwH0pR/jcjS
 s3E+LqOPpC6TLO/YOKF5TeEcMLnVBuIwcL3eikX7Ra5NEBCnPRE4V5l205rVfOVNUIZg
 Zaugxo0TyxpKT85RkFXXaE0cBnUHRZxk8AUsQH4VkLPDSTgfK7N9ufgoeUWBZ/HPM8Wa
 ua5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Jmn47q4S9RHTfKQ+zcpcUlTykvs0w9wPsLo86T+eU/8=;
 fh=XO21BaHFDt574bgaei7aSH3XSQFAR3b+vu7J1KHbdcU=;
 b=Pe3z+KI3FsEgNxF6mvzqgGYnM08zDaFfU5F3NAA+0LDeMxNxIW/pcpIa4v871UizF+
 5OBDVVN/dEA+EiE7Oa8dtNqTUi7RlIOH/Cm0myeYoNsbK867/qG8tAWuUY7cg7GLgHLp
 7g0ACz+22djvgUPVPKDbFgnJTe3vc/aSe4Ena4IMGcg2H+Rt4h/3NcS0NqMqDxRYiIk7
 QyqF1yq2rE00VW+uz6Fhr+4mmfEEtMRFmwggnUsLF1lH2NRzRyJp9rFO2uSy1k6w/u5r
 mlQEf3SRlmHg9kIvDAJEKMCJRdtlrHRs2kMqg/b6dVHDJEgVCbcVVdGfnop/4EKwAW2c
 1HzQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779722560; x=1780327360; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jmn47q4S9RHTfKQ+zcpcUlTykvs0w9wPsLo86T+eU/8=;
 b=efwbseQ+ns9epZ1G94TSnLw6OL9AqNqc3kzS0WqCzPRx+JhI03T5iv8MCUUuE9D+Xy
 0sFPQvocHKWAztk26Ug2KngC/mNmmhOyoOcFLWNDFDhOhYQhNG3gp1RHZbqvQcpwsZNq
 y5ijFFvcn7yirR3EwE+6zTYdwAiF4U8JWOn8R+O5ibNEpNAExPJiGxSPcYXVh9XibsQi
 uDrhqkujTaJEl/dKLabKExdhOQytK+/scLbpblQQLtMwfdx0azXeZLQXqa9oVlExrQyV
 gWUYLgJ0l/zJR/X9d3uRRKei3wl77vDrTqci5NJSsAWKbAGEMujfA1IdVD83KWeHNSYu
 QeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722560; x=1780327360;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jmn47q4S9RHTfKQ+zcpcUlTykvs0w9wPsLo86T+eU/8=;
 b=hC7N72ZOR9ft8OenyHwtxVhQCdtg/RPOwvuXfU8P27Orq7OAYFKv9TLA4/+/lnOiQ7
 4kfokCSY54Kan1h231HHHZ9l35LyishAT5bn4FpdiTuf76nYnz8HlWtPMaDLy5KKINiu
 wL9ZICDF6SaBGTaTR3Z8R+g4977RO06wPaUD0gV3l/hc/DV+GDT5UaYgQtb3SR392Cxa
 e5QqsaLTk1eQWkUmMB5hUvH0u+6C8rm7HzLUt2m+vsUSFIXFdDaGC+TYFXO9Yo9ZRo7Z
 8UaC87LT5VLMZv3L4dQT9WYvIfaDR5pE+IS0u3H0mIgpEX+WQhPFJZk0c3KhjgMoNNql
 4d2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+I2KVgg9nqY6VBWImF1xUXP6D76cYwGVmkuKhxDecehix/vN9J9Z5718XWs1Dmy9gCeio/smQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxiGIG9BheB/pBJBc7F/xC6YHHuhk6iaG+DFoAeMdBVgOv5/lZf
 RYp6F8pxu7oL95HOToF/KPXmLUCkcCmyeBpNmNMX5q6p5L8mbJYQYe220y2byzShCMQBW98jiid
 /s/KYRQ4auVCp1fNNNaH9E+UMynRI8Sg=
X-Gm-Gg: Acq92OF2CMMwg6CGf2L0XVbHY4PJQodPHmfKKJquBwgNqO7of4x9liJ6uAJEqqqZxih
 vV9M4aMaevMqd0gVQVqrAtDgGuepkbs4t/qGZGGRppSY1TLSFPSKz+vpOymSG5TabTXb2HU3fGT
 WXGTh3gVB88VsOK+46HGZ2uJxaK/mNZZcDrYT8tU7VXHIYVcrl+m+GxIC6Ns8iCdNPJ152baWA5
 CMavjzZeZSE39bibyyU7DERNZXvHBYUF5NhTmWjJ3qDmiIL9dImRBFvVbJSMkn7ntaQ9jOm3zAc
 wVmQMk5U
X-Received: by 2002:a05:6102:3f87:b0:635:1bc8:3563 with SMTP id
 ada2fe7eead31-67c82ffce43mr6267094137.20.1779722559861; Mon, 25 May 2026
 08:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
 <20260525135241.88348-7-philippe.reynes@softathome.com>
In-Reply-To: <20260525135241.88348-7-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 25 May 2026 11:22:29 -0400
X-Gm-Features: AVHnY4I04WVht6dO40M7PBp9WbV0myZHp0Fslt1F1yUJSOnNT6_A5DZtwGSvISI
Message-ID: <CAMDkj5xxnFoaibQkG5N6EQpvaz4SMcr+LJpb2TJddUcjWEzK_w@mail.gmail.com>
Subject: Re: [PATCH v6 06/15] test: dm: ecdsa.c: clean this test as software
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

On Mon, May 25, 2026 at 9:52=E2=80=AFAM Philippe Reynes
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
>
>  test/dm/ecdsa.c | 108 +++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 98 insertions(+), 10 deletions(-)
>
> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
> index d7eac7115f7..04c0f83e929 100644
> --- a/test/dm/ecdsa.c
> +++ b/test/dm/ecdsa.c
> @@ -3,36 +3,124 @@
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
> +       uint8_t sig[64];

s/uint8_t/u8

Raymond

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
