Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC92CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 18:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE7A8848C5;
	Mon,  1 Jun 2026 20:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jjm8PZH4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B2BC848D2; Mon,  1 Jun 2026 20:24:50 +0200 (CEST)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCB52848B9
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 20:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-59be89d310aso1818011e0c.0
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 11:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780338286; cv=none;
 d=google.com; s=arc-20240605;
 b=jtEl9BVU+kexNFd6MzAFgNMXCF5Em3RxfuTuv0jeaTVxVCrkdq1xWvGD1CPsSsC+lG
 VHIhnT0qYrbX1G/SVVaQF60Hw1EwyzjRWdYkb5NyUEENNtM+CQvd4QKHrmm3SDn9q2/q
 QtqBGgarAANQmK6H093bTMOtN/8v6spgi6MfwC7lpkLnUHRYgsJbCp5Pp5z/hx7Y/w0+
 3YR+dpgBXzcyuNMLE1hml4A7cXf7qoUjtnltmGDtF6P+6GY/+sDuJM9p8xbAC9/eforp
 Ffg9Q6JXFnSkACJ9PNcEfwMNtIDSUx+NJJkM6O63VPL9/m1rS03CsyC3jEag7JRFq5c0
 Kibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8YNe3KWio4WufE61Zdx7UhFIXxhChcVSwe3ySoWXRWY=;
 fh=b8gpC0yQGfUYa1x43q1gTWjMp4f9fZKEmeANj7YX95E=;
 b=QU15pADklQUYSEcE57ujJiIErxK8bERObW0UtXMv53ApJyYVNZmTrRJc06smwFCqb1
 p5xnYwIJ8YEj1plEkSjf0I89dLXDc4uM5YnaQZuuVd0kgmjwFkOujOluu7ShR/XA3T1i
 STZgY7msq0qyL30ox7YefYa+0VxsgyCzpfSPCVwOstUAOu6LSBbahZ7pPwW6HwmRdj6s
 hH2i63bDI2wdNJeF0bfLFGLB6DiGeobfPXoJGnZx/sESyQ+jfJHeMJ3fRM7COfIeIrdj
 FVYb4nq1R3f4UorHAYP6nmCB/BaaajlEHvTlvZYybQGBgJY+YGEYmVSEoYHzfDbY2LXM
 F2Tw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780338286; x=1780943086; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8YNe3KWio4WufE61Zdx7UhFIXxhChcVSwe3ySoWXRWY=;
 b=jjm8PZH4EMIyMUQHe63zEWB/3HMcy0JnH2IkvV4KC6RmX/NDNSE1qRRlGRamt6N5UU
 MYiLUlnOLkXUwGmKaQsu2b6tbPztuElGWrkgcAqsQXunJnE3KtFe2Vz6pmJI4BOmGlvG
 jDL3COrb+OvDcwSBU93HVdJSrzlwYkX/NVNusREKVOcIVeD3OCSgNhaHNU/Fpng9Z/4C
 ROY+qH160ew6QBxCwejtWrMcFVD03z+N59OjPm7anzdCEi+r8Tt7o6B/8JHtYpulLMUs
 UL3oMHtZc1afC5hyYi6EiJm5YxRPwCM5eN0Xfa34k1YoPONEbLM9zxKUaeA6KOGZCFg+
 wlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780338286; x=1780943086;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8YNe3KWio4WufE61Zdx7UhFIXxhChcVSwe3ySoWXRWY=;
 b=WvMkiFMR+VOmGQRepErWazx+NeolESJdR5nqQL53fSLezdHZ7e/gX/FqjxXSjMBi0b
 altqFQdEppjpwFmeUISi5zatpHvljihF8LC4UxkIxpGChG+X+Z1wcToEsyeccSpcruLb
 QeNxyqP/2hTzUNjcGwkkhCvUkl5h059JW9b9dqHH+2DBFY9ttM+Z1BttFcfGY/VmhQCU
 wECsHA10hrIOLkf0m7F2HCXLKJDq+kDR9BQoiSxRjhY1tyn8s4qnHHbBfOF2Vj7wYSV7
 Gxe62pTdp6mlgmUEJ2gS9skwHwQhBTpfmVq1J8qG6kC2kkzQTvJw5zgnrbpF6FwlWIC2
 VRNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2QKj+vkoJV6uJBcdeUZauioEs/OqpNmncAKplj07Yxll9g3HbS2ivHb+4STittsPrUAjb5M4=@lists.denx.de
X-Gm-Message-State: AOJu0Yyz5NXsqbb5hRtg/pzqc/IzOODYnBqLSBPgw9uvFqMpP3nuKd8I
 gYJH5jEOvvDk61Ua3lWBpd/UnyxFEIVOU17IrUTp1ECQPRApM8cqdNdk3zTb3laK8YHfAEmn/62
 LB+GcXA+3rJVaZ/1hztJ1FgssuS8GdwE=
X-Gm-Gg: Acq92OF5yi2aWPWFs1ln1ADj8udFy6Lm+dcATV5gITgfkFBCkL/hAL71vNujaJjDFvn
 6NbvtjH+ue0f9LWu2IWHorjSUs6/cx9w4jhK3Mn+mPV1k8aSip0EYBu6xJ15ZyHLzJ2YkLZObMK
 lZu3kYAYG06Jv94kYVe6qUufP/cj2woX41eXkKBMrfq6AKc52tgZ54KzXV8qPcsATEcHAGQ03+n
 zGExrVSFit2EY0yB1kpNW60r+9Eo/DcFrm2eHxdqs/pi2lWeMLxV2yR7Yc8gviFiVAh+1yJHuUt
 wGYAyxtzM6sCLAffGVbtV+Q67OzW
X-Received: by 2002:a05:6102:162b:b0:634:92c:bdca with SMTP id
 ada2fe7eead31-6e16ac28f14mr402782137.3.1780338286640; Mon, 01 Jun 2026
 11:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
 <20260601134310.2452454-7-philippe.reynes@softathome.com>
In-Reply-To: <20260601134310.2452454-7-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 1 Jun 2026 14:24:35 -0400
X-Gm-Features: AVHnY4KjmimaYGZ2ozDhtrDmuACZOUqDqPI3d4VVT-zk_ugqYNiTdJzgRTTVXNQ
Message-ID: <CAMDkj5xYrKoTogNH=7GGE+Xe-SH7oUP2EP2evkHzHiWVaxa28w@mail.gmail.com>
Subject: Re: [PATCH v8 06/15] test: dm: ecdsa.c: clean this test as software
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

On Mon, Jun 1, 2026 at 9:43=E2=80=AFAM Philippe Reynes
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
> v8:
> - remove macro CHECK with a goto inside
> - use lowercase for hex data
> - code cleanup
>
>  test/dm/ecdsa.c | 107 +++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 97 insertions(+), 10 deletions(-)
>

Thanks!
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>


> diff --git a/test/dm/ecdsa.c b/test/dm/ecdsa.c
> index d7eac7115f7..261ca3f9f73 100644
> --- a/test/dm/ecdsa.c
> +++ b/test/dm/ecdsa.c
> @@ -3,36 +3,123 @@
>  #include <crypto/ecdsa-uclass.h>
>  #include <dm.h>
>  #include <dm/test.h>
> +#include <malloc.h>
>  #include <test/ut.h>
>  #include <u-boot/ecdsa.h>
>
> +#define FDT_MAX_SIZE           512
> +
> +static int set_fdt_ecdsa_point(char *fdt, const char *name, const char *=
data)
> +{
> +       char *value =3D NULL;
> +       size_t len;
> +       int ret =3D 0;
> +
> +       if (!fdt || !name || !data) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       len =3D strlen(data) / 2;
> +       if (!len) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +
> +       value =3D malloc(len);
> +       if (!value) {
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       ret =3D hex2bin(value, data, len);
> +       if (ret)
> +               goto out;
> +
> +       ret =3D fdt_property(fdt, name, value, len);
> +       if (ret)
> +               goto out;
> +
> +out:
> +       free(value);
> +       return ret;
> +}
> +
> +static int create_fdt_with_ecdsa_key(struct unit_test_state *uts,
> +                                    char *fdt, size_t size,
> +                                    const char *name, const char *curve,
> +                                    const char *x, const char *y)
> +{
> +       ut_assertok(fdt_create(fdt, size));
> +       ut_assertok(fdt_finish_reservemap(fdt));
> +       ut_assertok(fdt_begin_node(fdt, ""));
> +       ut_assertok(fdt_begin_node(fdt, "signature"));
> +       ut_assertok(fdt_begin_node(fdt, name));
> +       ut_assertok(fdt_property_string(fdt, "algo", "sha256,ecdsa256"));
> +       ut_assertok(set_fdt_ecdsa_point(fdt, "ecdsa,y-point", y));
> +       ut_assertok(set_fdt_ecdsa_point(fdt, "ecdsa,x-point", x));
> +       ut_assertok(fdt_property_string(fdt, "ecdsa,curve", curve));
> +       ut_assertok(fdt_property_string(fdt, "key-name-hint", name));
> +       ut_assertok(fdt_end_node(fdt)); /* name */
> +       ut_assertok(fdt_end_node(fdt)); /* "signature" */
> +       ut_assertok(fdt_end_node(fdt)); /* "" */
> +       ut_assertok(fdt_finish(fdt));
> +       ut_assertok(fdt_pack(fdt));
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
> + * so we only check that the UCLASS_ECDSA uclass may be used.
>   *
> - * The uclass_get() test is redundant since ecdsa_verify() would also fa=
il. We
> - * run both functions in order to isolate the cause more clearly. i.e. i=
s
> - * ecdsa_verify() failing because the UCLASS is absent/broken?
> + * The data used in this test come from RFC6979 and use the
> + * sample with curve NIST P-256, hash sha256 and text "sample".
>   */
>  static int dm_test_ecdsa_verify(struct unit_test_state *uts)
>  {
>         struct uclass *ucp;
> +       const char *full_name =3D "sha256,ecdsa256";
> +       const char *name =3D "key-ecdsa-256";
> +       const char *curve =3D "prime256v1";
> +       const char *x =3D "60fed4ba255a9d31c961eb74c6356d68c049b8923b61fa=
6ce669622e60f29fb6";
> +       const char *y =3D "7903fe1008b8bc99a41ae9e95628bc64f2f1b20c2d7e9f=
5177a3c294d4462299";
> +       const char *r =3D "efd48b2aacb6a8fd1140dd9cd45e81d69d2c877b56aaf9=
91c34d0ea84eaf3716";
> +       const char *s =3D "f7cb1c942d657c41d436c7a1b6e29f65f3e900dbb9aff4=
064dc4ab2f843acda8";
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
> +       ut_assertok(create_fdt_with_ecdsa_key(uts, fdt, sizeof(fdt), name=
, curve, x, y));
> +
> +       /* prepare the signature */
> +       ut_assertok(hex2bin(sig + 0, r, strlen(r) / 2));
> +       ut_assertok(hex2bin(sig + 32, s, strlen(s) / 2));
> +
>         ut_assertok(uclass_get(UCLASS_ECDSA, &ucp));
>         ut_assertnonnull(ucp);
> -       ut_asserteq(-ENODEV, ecdsa_verify(&info, NULL, 0, NULL, 0));
> +       ut_assertok(ecdsa_verify(&info, region, 1, sig, sizeof(sig)));
>
>         return 0;
>  }
> +
>  DM_TEST(dm_test_ecdsa_verify, UTF_SCAN_PDATA | UTF_SCAN_FDT);
> --
> 2.43.0
>
