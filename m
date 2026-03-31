Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BAA10F92E0
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 16:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6274383E7A;
	Tue, 31 Mar 2026 18:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KsEn4rCy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B028A83E7A; Tue, 31 Mar 2026 18:45:40 +0200 (CEST)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C7C483DA6
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 18:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-953c5738c03so1373960241.2
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 09:45:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774975537; cv=none;
 d=google.com; s=arc-20240605;
 b=aUDLtS4pfapjTsP2xIVL/yfXf//JQQzTa25LfQrb3P84LIf9op+Xpmkga4uFuNgmtM
 rla2MAXQTwVzJVNdfUySjT2gFyvAAyAwGgQNKWVyvXOEkB9nEhZtvj3BReucD7K9hKcP
 p8cI7k1dGo0ReO/iPM8AOOBDvmsoVTdXkkXAZrApQLcRuWwZDDlHPS2i7OQVdKvpjL8C
 bKC3XGthFGz5xFSI8JNEsE0LVV8lOGd+g1yQehoZycTJENO+/v6FMxfRcmDBpbiRvT60
 twXmECmtmI/WFwRjvMvRPvi8kSRHwEadgIGwYTpeMTlIt0uLgnzqcqiZuglDuBA96VNP
 jEEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8oDJJGd+EoXRUfdIFL99xRa+1MWmXwThkznuico9lgo=;
 fh=rX4Q8nZsCak7//IQOQI8SG2sbcirjMsLxVtHhO3aLSQ=;
 b=NBxx/awaJTkjopXkznHuz/T1heIe1eX/M97hvS+DZqcjssj/nOBjwsun2bByIwMpuM
 UnczzoTKDOQ4Wr4Lqdnof+T3MkyyxCA+cSnvNIekBmPjMzHIaGmM+cDQQRJIHSyesksp
 DkQp5bkhRPETIjIWxDbU05926GHScHWJsLRT/WBk28T2hgwtPsjkEs6kR+IwfbPl/iEb
 0GY4HaXyJx0daJcWzeUqjjmOOKytwbTSCB2tnVkQMCSqCCEw4Qa/I501kc2x8tw/7Hlw
 a8pCQu6iVSxWRuFBoXOlW2wNVU1q/QjRJdsCjFFOqxL/1NtHtjaELO/LELVTNNIJWMVD
 Iafw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774975537; x=1775580337; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8oDJJGd+EoXRUfdIFL99xRa+1MWmXwThkznuico9lgo=;
 b=KsEn4rCyo+3NxgmES/OeeKAWlRvLT9qzqg0TtKvciDIMoxQ6hA9n1+Uq4tOshuxFR4
 I8MLo2PJZIUjJrs7712sp3i+pI1ZEs7d2yy19tH5KvBfcrYALMWH3OJcAmZ1ND3UZpQN
 Gz634DQEoRTSRTZILUpeY3NJPqXUs1Lo46zovoK5BIWVK4LcROL8niwlBdpKiuwjkvkE
 xLeHvHsQe/NMATCxG1If483xUOq/GQFq1fKc+QRlkQqQZv6871faL5z8A1Z9cM/hGjpY
 T0S+ZZ9oVAMtse2RrdAiLzpl8X+WHaz9fqmhk6NYv+JRZuo1x7LisI8FLm8ezTWBp0xP
 q6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774975537; x=1775580337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8oDJJGd+EoXRUfdIFL99xRa+1MWmXwThkznuico9lgo=;
 b=LqxNKAoB2zhajK0BEm2OKkd9FMnO06wBzrSoeSj7nsxB8K4a1gPhtHZqzF1vUHE8w8
 +E8mlURHgPpnUYScVeiz8mtSg1Cu1buQUvRL/0h8+OD/hT9Thn37i+C3kKjsQqNK7ad9
 1vyYLxdavwuULz5A8jBPX2IKMCNeffFivBdySD9/XaALy3FeTXR8xqDnKJISzUl2r3Cv
 rkrl53JtRal0mrihmTGPXCz8csL/33HUsT4EimCaj0W3nvmCOiEV5zS0XPrCtjPJgU8d
 8ev+Bv4AV2cjawC1AwjOh/pcvQSNgD1phdmT0h9lI8ObWI8XiYxriwBju+7O2IPeOUPd
 ktjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp7Bu7X4Jq316LETtJdOHqNgBCZxbLupfKFuP32+NnUZhjNZ3/8uvKwmksJileXcFBE77YQag=@lists.denx.de
X-Gm-Message-State: AOJu0Ywqw1KLSwekCR9J4csM4Wql33PI2Cnvhlsqq9g1qE3UvXPb0JTf
 EUR4ItE74iHyc93kekxdDwcbq8RQpO7rCQ2CFal6kyxedW+W9kk8Z/ZsSwqREwCQ+wt/Y1csdE0
 qjAXrqtqvuhKaY/IF7YEQ3NvQPmMrr98=
X-Gm-Gg: ATEYQzx+8HBUbzXz4INU4nRgIm15YRi/LIU5WANv9iDK8C11owAGXJBHVCtx1a8L2MQ
 S+86kC6SJMjFbOGRvLfjYit220jpyD+6awzGeGprzEMO1xbs1OWOEzW48cnvtLdqctAffmIOlfU
 ZFbOr3Qzktql02GtfpuV+03vPBlnYP1ttqpbnM65Dcb5fkkhM/m8RzzPDd9WbquZLFHtR8pYeO/
 pR9+gE2cGUai7jo85Z1666jC+xjqqSijflrKV9JcHgS0O7t7xAcZu2dRxuQqdaQUfl7Tc1Fs35W
 7RHnuwdr
X-Received: by 2002:a05:6102:6c8:b0:602:86a6:9863 with SMTP id
 ada2fe7eead31-604f9098b61mr7310287137.1.1774975536219; Tue, 31 Mar 2026
 09:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
 <20260331100047.34618-4-philippe.reynes@softathome.com>
In-Reply-To: <20260331100047.34618-4-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Tue, 31 Mar 2026 12:45:24 -0400
X-Gm-Features: AQROBzBman3MSAstvbeZ1JXoCytPL3S9thNGN4NoWa-lKkGJE_oRyGp5ow5R0nA
Message-ID: <CAMDkj5y8KOued8ZiDMAh6O_H82hYowz043eY3DWCQgKfph22dA@mail.gmail.com>
Subject: Re: [PATCH v3 03/15] test: lib: ecdsa: add initial test
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
> Adds tests to check that the function ecdsa_hash_verify
> using mbedtls is valid.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - little change to only use test with sha enabled
> v3:
> - remove useless field *k in struct ecdsa_test_vector_s
> - change expected value on error (don't use mbedtls error)
> - manage function returns
> - update third parameter of sha*_csum_wd
>
>  test/lib/Makefile |   1 +
>  test/lib/ecdsa.c  | 447 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 448 insertions(+)
>  create mode 100644 test/lib/ecdsa.c
>
> diff --git a/test/lib/Makefile b/test/lib/Makefile
> index f25383a40e5..2ac80afefdb 100644
> --- a/test/lib/Makefile
> +++ b/test/lib/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_$(PHASE_)UT_COMPRESSION) +=3D compression.o
>  ifeq ($(CONFIG_XPL_BUILD),)
>  obj-y +=3D abuf.o
>  obj-y +=3D alist.o
> +obj-$(CONFIG_ECDSA_MBEDTLS) +=3D ecdsa.o
>  obj-$(CONFIG_EFI_LOADER) +=3D efi_device_path.o efi_memory.o
>  obj-$(CONFIG_EFI_SECURE_BOOT) +=3D efi_image_region.o
>  ifdef CONFIG_RISCV
> diff --git a/test/lib/ecdsa.c b/test/lib/ecdsa.c
> new file mode 100644
> index 00000000000..95bb84200a6
> --- /dev/null
> +++ b/test/lib/ecdsa.c
> @@ -0,0 +1,447 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 Philippe Reynes <philippe.reynes@softathome.com>
> + */
> +
> +#include <command.h>
> +#include <image.h>
> +#include <test/lib.h>
> +#include <test/test.h>
> +#include <test/ut.h>
> +#include <crypto/ecdsa-uclass.h>
> +#include <crypto/internal/ecdsa.h>
> +
> +#include <mbedtls/ecp.h>
> +
> +struct ecdsa_test_vector_s {
> +       const char *test_name;

Currently the test_name is useless in the code, can we log it for all
tests or at least each failed test?

> +       const char *curve_name;
> +       unsigned char *x;
> +       unsigned char *y;

const char *x;
const char *y;

> +       int size_bits;
> +       unsigned char *hash_type;
> +       unsigned char *hash_message;
> +       unsigned char *r;
> +       unsigned char *s;

const char *hash_type;
const char *hash_message;
const char *r;
const char *s;

> +       int expected;
> +};
> +
> +/*
> + * Those data come from RFC6979
> + */
> +
> +struct ecdsa_test_vector_s ecdsa_test_vector[] =3D {

static const struct

> +       /*
> +        * secp192r1
> +        */
> +       {
> +       .test_name =3D "secp192r1 sha1",
> +       .curve_name =3D "secp192r1",
> +       .x =3D "AC2C77F529F91689FEA0EA5EFEC7F210D8EEA0B9E047ED56",
> +       .y =3D "3BC723E57670BD4887EBC732C523063D0A7C957BC97C1C43",
> +       .size_bits =3D 192,
> +       .hash_type =3D "sha-1",
> +       .hash_message =3D "sample",
> +       .r =3D "98C6BD12B23EAF5E2A2045132086BE3EB8EBD62ABF6698FF",
> +       .s =3D "57A22B07DEA9530F8DE9471B1DC6624472E8E2844BC25B64",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp192r1 sha256",
> +       .curve_name =3D "secp192r1",
> +       .x =3D "AC2C77F529F91689FEA0EA5EFEC7F210D8EEA0B9E047ED56",
> +       .y =3D "3BC723E57670BD4887EBC732C523063D0A7C957BC97C1C43",
> +       .size_bits =3D 192,
> +       .hash_type =3D "sha-256",
> +       .hash_message =3D "sample",
> +       .r =3D "4B0B8CE98A92866A2820E20AA6B75B56382E0F9BFD5ECB55",
> +       .s =3D "CCDB006926EA9565CBADC840829D8C384E06DE1F1E381B85",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp192r1 sha384",
> +       .curve_name =3D "secp192r1",
> +       .x =3D "AC2C77F529F91689FEA0EA5EFEC7F210D8EEA0B9E047ED56",
> +       .y =3D "3BC723E57670BD4887EBC732C523063D0A7C957BC97C1C43",
> +       .size_bits =3D 192,
> +       .hash_type =3D "sha-384",
> +       .hash_message =3D "sample",
> +       .r =3D "DA63BF0B9ABCF948FBB1E9167F136145F7A20426DCC287D5",
> +       .s =3D "C3AA2C960972BD7A2003A57E1C4C77F0578F8AE95E31EC5E",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp192r1 sha512",
> +       .curve_name =3D "secp192r1",
> +       .x =3D "AC2C77F529F91689FEA0EA5EFEC7F210D8EEA0B9E047ED56",
> +       .y =3D "3BC723E57670BD4887EBC732C523063D0A7C957BC97C1C43",
> +       .size_bits =3D 192,
> +       .hash_type =3D "sha-512",
> +       .hash_message =3D "sample",
> +       .r =3D "4D60C5AB1996BD848343B31C00850205E2EA6922DAC2E4B8",
> +       .s =3D "3F6E837448F027A1BF4B34E796E32A811CBB4050908D8F67",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp192r1 sha512 error",
> +       .curve_name =3D "secp192r1",
> +       .x =3D "AC2C77F529F91689FEA0EA5EFEC7F210D8EEA0B9E047ED56",
> +       .y =3D "3BC723E57670BD4887EBC732C523063D0A7C957BC97C1C43",
> +       .size_bits =3D 192,
> +       .hash_type =3D "sha-512",
> +       .hash_message =3D "sample",
> +       .r =3D "4D60C5AB1996BD848343B31C00850205E2EA6922DAC2E4B8",
> +       .s =3D "0F6E837448F027A1BF4B34E796E32A811CBB4050908D8F67",
> +       .expected =3D -EINVAL,
> +       },
> +       /*
> +        * secp224r1
> +        */
> +       {
> +       .test_name =3D "secp224r1 sha1",
> +       .curve_name =3D "secp224r1",
> +       .x =3D "00CF08DA5AD719E42707FA431292DEA11244D64FC51610D94B130D6C"=
,
> +       .y =3D "EEAB6F3DEBE455E3DBF85416F7030CBD94F34F2D6F232C69F3C1385A"=
,
> +       .size_bits =3D 224,
> +       .hash_type =3D "sha-1",
> +       .hash_message =3D "sample",
> +       .r =3D "22226F9D40A96E19C4A301CE5B74B115303C0F3A4FD30FC257FB57AC"=
,
> +       .s =3D "66D1CDD83E3AF75605DD6E2FEFF196D30AA7ED7A2EDF7AF475403D69"=
,
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp224r1 sha256",
> +       .curve_name =3D "secp224r1",
> +       .x =3D "00CF08DA5AD719E42707FA431292DEA11244D64FC51610D94B130D6C"=
,
> +       .y =3D "EEAB6F3DEBE455E3DBF85416F7030CBD94F34F2D6F232C69F3C1385A"=
,
> +       .size_bits =3D 224,
> +       .hash_type =3D "sha-256",
> +       .hash_message =3D "sample",
> +       .r =3D "61AA3DA010E8E8406C656BC477A7A7189895E7E840CDFE8FF42307BA"=
,
> +       .s =3D "BC814050DAB5D23770879494F9E0A680DC1AF7161991BDE692B10101"=
,
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp224r1 sha384",
> +       .curve_name =3D "secp224r1",
> +       .x =3D "00CF08DA5AD719E42707FA431292DEA11244D64FC51610D94B130D6C"=
,
> +       .y =3D "EEAB6F3DEBE455E3DBF85416F7030CBD94F34F2D6F232C69F3C1385A"=
,
> +       .size_bits =3D 224,
> +       .hash_type =3D "sha-384",
> +       .hash_message =3D "sample",
> +       .r =3D "0B115E5E36F0F9EC81F1325A5952878D745E19D7BB3EABFABA77E953"=
,
> +       .s =3D "830F34CCDFE826CCFDC81EB4129772E20E122348A2BBD889A1B1AF1D"=
,
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp224r1 sha512",
> +       .curve_name =3D "secp224r1",
> +       .x =3D "00CF08DA5AD719E42707FA431292DEA11244D64FC51610D94B130D6C"=
,
> +       .y =3D "EEAB6F3DEBE455E3DBF85416F7030CBD94F34F2D6F232C69F3C1385A"=
,
> +       .size_bits =3D 224,
> +       .hash_type =3D "sha-512",
> +       .hash_message =3D "sample",
> +       .r =3D "074BD1D979D5F32BF958DDC61E4FB4872ADCAFEB2256497CDAC30397"=
,
> +       .s =3D "A4CECA196C3D5A1FF31027B33185DC8EE43F288B21AB342E5D8EB084"=
,
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp224r1 sha512 error",
> +       .curve_name =3D "secp224r1",
> +       .x =3D "00CF08DA5AD719E42707FA431292DEA11244D64FC51610D94B130D6C"=
,
> +       .y =3D "EEAB6F3DEBE455E3DBF85416F7030CBD94F34F2D6F232C69F3C1385A"=
,
> +       .size_bits =3D 224,
> +       .hash_type =3D "sha-512",
> +       .hash_message =3D "sample",
> +       .r =3D "074BD1D979D5F32BF958DDC61E4FB4872ADCAFEB2256497CDAC30397"=
,
> +       .s =3D "04CECA196C3D5A1FF31027B33185DC8EE43F288B21AB342E5D8EB084"=
,
> +       .expected =3D -EINVAL,
> +       },
> +       /*
> +        * secp256r1
> +        */
> +       {
> +       .test_name =3D "secp256r1 sha1",
> +       .curve_name =3D "secp256r1",
> +       .x =3D "60FED4BA255A9D31C961EB74C6356D68C049B8923B61FA6CE669622E6=
0F29FB6",
> +       .y =3D "7903FE1008B8BC99A41AE9E95628BC64F2F1B20C2D7E9F5177A3C294D=
4462299",
> +       .size_bits =3D 256,
> +       .hash_type =3D "sha-1",
> +       .hash_message =3D "sample",
> +       .r =3D "61340C88C3AAEBEB4F6D667F672CA9759A6CCAA9FA8811313039EE4A3=
5471D32",
> +       .s =3D "6D7F147DAC089441BB2E2FE8F7A3FA264B9C475098FDCF6E00D7C996E=
1B8B7EB",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp256r1 sha256",
> +       .curve_name =3D "secp256r1",
> +       .x =3D "60FED4BA255A9D31C961EB74C6356D68C049B8923B61FA6CE669622E6=
0F29FB6",
> +       .y =3D "7903FE1008B8BC99A41AE9E95628BC64F2F1B20C2D7E9F5177A3C294D=
4462299",
> +       .size_bits =3D 256,
> +       .hash_type =3D "sha-256",
> +       .hash_message =3D "sample",
> +       .r =3D "EFD48B2AACB6A8FD1140DD9CD45E81D69D2C877B56AAF991C34D0EA84=
EAF3716",
> +       .s =3D "F7CB1C942D657C41D436C7A1B6E29F65F3E900DBB9AFF4064DC4AB2F8=
43ACDA8",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp256r1 sha384",
> +       .curve_name =3D "secp256r1",
> +       .x =3D "60FED4BA255A9D31C961EB74C6356D68C049B8923B61FA6CE669622E6=
0F29FB6",
> +       .y =3D "7903FE1008B8BC99A41AE9E95628BC64F2F1B20C2D7E9F5177A3C294D=
4462299",
> +       .size_bits =3D 256,
> +       .hash_type =3D "sha-384",
> +       .hash_message =3D "sample",
> +       .r =3D "0EAFEA039B20E9B42309FB1D89E213057CBF973DC0CFC8F129EDDDC80=
0EF7719",
> +       .s =3D "4861F0491E6998B9455193E34E7B0D284DDD7149A74B95B9261F13ABD=
E940954",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp256r1 sha512",
> +       .curve_name =3D "secp256r1",
> +       .x =3D "60FED4BA255A9D31C961EB74C6356D68C049B8923B61FA6CE669622E6=
0F29FB6",
> +       .y =3D "7903FE1008B8BC99A41AE9E95628BC64F2F1B20C2D7E9F5177A3C294D=
4462299",
> +       .size_bits =3D 256,
> +       .hash_type =3D "sha-512",
> +       .hash_message =3D "sample",
> +       .r =3D "8496A60B5E9B47C825488827E0495B0E3FA109EC4568FD3F8D1097678=
EB97F00",
> +       .s =3D "2362AB1ADBE2B8ADF9CB9EDAB740EA6049C028114F2460F96554F61FA=
E3302FE",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp256r1 sha512 error",
> +       .curve_name =3D "secp256r1",
> +       .x =3D "60FED4BA255A9D31C961EB74C6356D68C049B8923B61FA6CE669622E6=
0F29FB6",
> +       .y =3D "7903FE1008B8BC99A41AE9E95628BC64F2F1B20C2D7E9F5177A3C294D=
4462299",
> +       .size_bits =3D 256,
> +       .hash_type =3D "sha-512",
> +       .hash_message =3D "sample",
> +       .r =3D "8496A60B5E9B47C825488827E0495B0E3FA109EC4568FD3F8D1097678=
EB97F00",
> +       .s =3D "0362AB1ADBE2B8ADF9CB9EDAB740EA6049C028114F2460F96554F61FA=
E3302FE",
> +       .expected =3D -EINVAL,
> +       },
> +       /*
> +        * secp384r1
> +        */
> +       {
> +       .test_name =3D "secp384r1 sha1",
> +       .curve_name =3D "secp384r1",
> +       .x =3D "EC3A4E415B4E19A4568618029F427FA5DA9A8BC4AE92E02E06AAE5286=
B300C64DEF8F0EA9055866064A254515480BC13",
> +       .y =3D "8015D9B72D7D57244EA8EF9AC0C621896708A59367F9DFB9F54CA84B3=
F1C9DB1288B231C3AE0D4FE7344FD2533264720",
> +       .size_bits =3D 384,
> +       .hash_type =3D "sha-1",
> +       .hash_message =3D "sample",
> +       .r =3D "EC748D839243D6FBEF4FC5C4859A7DFFD7F3ABDDF72014540C16D7330=
9834FA37B9BA002899F6FDA3A4A9386790D4EB2",
> +       .s =3D "A3BCFA947BEEF4732BF247AC17F71676CB31A847B9FF0CBC9C9ED4C1A=
5B3FACF26F49CA031D4857570CCB5CA4424A443",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp384r1 sha256",
> +       .curve_name =3D "secp384r1",
> +       .x =3D "EC3A4E415B4E19A4568618029F427FA5DA9A8BC4AE92E02E06AAE5286=
B300C64DEF8F0EA9055866064A254515480BC13",
> +       .y =3D "8015D9B72D7D57244EA8EF9AC0C621896708A59367F9DFB9F54CA84B3=
F1C9DB1288B231C3AE0D4FE7344FD2533264720",
> +       .size_bits =3D 384,
> +       .hash_type =3D "sha-256",
> +       .hash_message =3D "sample",
> +       .r =3D "21B13D1E013C7FA1392D03C5F99AF8B30C570C6F98D4EA8E354B63A21=
D3DAA33BDE1E888E63355D92FA2B3C36D8FB2CD",
> +       .s =3D "F3AA443FB107745BF4BD77CB3891674632068A10CA67E3D45DB2266FA=
7D1FEEBEFDC63ECCD1AC42EC0CB8668A4FA0AB0",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp384r1 sha384",
> +       .curve_name =3D "secp384r1",
> +       .x =3D "EC3A4E415B4E19A4568618029F427FA5DA9A8BC4AE92E02E06AAE5286=
B300C64DEF8F0EA9055866064A254515480BC13",
> +       .y =3D "8015D9B72D7D57244EA8EF9AC0C621896708A59367F9DFB9F54CA84B3=
F1C9DB1288B231C3AE0D4FE7344FD2533264720",
> +       .size_bits =3D 384,
> +       .hash_type =3D "sha-384",
> +       .hash_message =3D "sample",
> +       .r =3D "94EDBB92A5ECB8AAD4736E56C691916B3F88140666CE9FA73D64C4EA9=
5AD133C81A648152E44ACF96E36DD1E80FABE46",
> +       .s =3D "99EF4AEB15F178CEA1FE40DB2603138F130E740A19624526203B6351D=
0A3A94FA329C145786E679E7B82C71A38628AC8",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp384r1 sha512",
> +       .curve_name =3D "secp384r1",
> +       .x =3D "EC3A4E415B4E19A4568618029F427FA5DA9A8BC4AE92E02E06AAE5286=
B300C64DEF8F0EA9055866064A254515480BC13",
> +       .y =3D "8015D9B72D7D57244EA8EF9AC0C621896708A59367F9DFB9F54CA84B3=
F1C9DB1288B231C3AE0D4FE7344FD2533264720",
> +       .size_bits =3D 384,
> +       .hash_type =3D "sha-512",
> +       .hash_message =3D "sample",
> +       .r =3D "ED0959D5880AB2D869AE7F6C2915C6D60F96507F9CB3E047C0046861D=
A4A799CFE30F35CC900056D7C99CD7882433709",
> +       .s =3D "512C8CCEEE3890A84058CE1E22DBC2198F42323CE8ACA9135329F03C0=
68E5112DC7CC3EF3446DEFCEB01A45C2667FDD5",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp384r1 sha512 error",
> +       .curve_name =3D "secp384r1",
> +       .x =3D "EC3A4E415B4E19A4568618029F427FA5DA9A8BC4AE92E02E06AAE5286=
B300C64DEF8F0EA9055866064A254515480BC13",
> +       .y =3D "8015D9B72D7D57244EA8EF9AC0C621896708A59367F9DFB9F54CA84B3=
F1C9DB1288B231C3AE0D4FE7344FD2533264720",
> +       .size_bits =3D 384,
> +       .hash_type =3D "sha-512",
> +       .hash_message =3D "sample",
> +       .r =3D "ED0959D5880AB2D869AE7F6C2915C6D60F96507F9CB3E047C0046861D=
A4A799CFE30F35CC900056D7C99CD7882433709",
> +       .s =3D "012C8CCEEE3890A84058CE1E22DBC2198F42323CE8ACA9135329F03C0=
68E5112DC7CC3EF3446DEFCEB01A45C2667FDD5",
> +       .expected =3D -EINVAL,
> +       },
> +       /*
> +        * secp521r1
> +        */
> +       {
> +       .test_name =3D "secp521r1 sha1",
> +       .curve_name =3D "secp521r1",
> +       .x =3D "01894550D0785932E00EAA23B694F213F8C3121F86DC97A04E5A7167D=
B4E5BCD371123D46E45DB6B5D5370A7F20FB633155D38FFA16D2BD761DCAC474B9A2F5023A4=
",
> +       .y =3D "00493101C962CD4D2FDDF782285E64584139C2F91B47F87FF82354D66=
30F746A28A0DB25741B5B34A828008B22ACC23F924FAAFBD4D33F81EA66956DFEAA2BFDFCF5=
",
> +       .size_bits =3D 521,
> +       .hash_type =3D "sha-1",
> +       .hash_message =3D "sample",
> +       .r =3D "00343B6EC45728975EA5CBA6659BBB6062A5FF89EEA58BE3C80B619F3=
22C87910FE092F7D45BB0F8EEE01ED3F20BABEC079D202AE677B243AB40B5431D497C55D75D=
",
> +       .s =3D "00E7B0E675A9B24413D448B8CC119D2BF7B2D2DF032741C096634D6D6=
5D0DBE3D5694625FB9E8104D3B842C1B0E2D0B98BEA19341E8676AEF66AE4EBA3D5475D5D16=
",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp521r1 sha256",
> +       .curve_name =3D "secp521r1",
> +       .x =3D "01894550D0785932E00EAA23B694F213F8C3121F86DC97A04E5A7167D=
B4E5BCD371123D46E45DB6B5D5370A7F20FB633155D38FFA16D2BD761DCAC474B9A2F5023A4=
",
> +       .y =3D "00493101C962CD4D2FDDF782285E64584139C2F91B47F87FF82354D66=
30F746A28A0DB25741B5B34A828008B22ACC23F924FAAFBD4D33F81EA66956DFEAA2BFDFCF5=
",
> +       .size_bits =3D 521,
> +       .hash_type =3D "sha-256",
> +       .hash_message =3D "sample",
> +       .r =3D "01511BB4D675114FE266FC4372B87682BAECC01D3CC62CF2303C92B35=
26012659D16876E25C7C1E57648F23B73564D67F61C6F14D527D54972810421E7D87589E1A7=
",
> +       .s =3D "004A171143A83163D6DF460AAF61522695F207A58B95C0644D87E52AA=
1A347916E4F7A72930B1BC06DBE22CE3F58264AFD23704CBB63B29B931F7DE6C9D949A7ECFC=
",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp521r1 sha384",
> +       .curve_name =3D "secp521r1",
> +       .x =3D "01894550D0785932E00EAA23B694F213F8C3121F86DC97A04E5A7167D=
B4E5BCD371123D46E45DB6B5D5370A7F20FB633155D38FFA16D2BD761DCAC474B9A2F5023A4=
",
> +       .y =3D "00493101C962CD4D2FDDF782285E64584139C2F91B47F87FF82354D66=
30F746A28A0DB25741B5B34A828008B22ACC23F924FAAFBD4D33F81EA66956DFEAA2BFDFCF5=
",
> +       .size_bits =3D 521,
> +       .hash_type =3D "sha-384",
> +       .hash_message =3D "sample",
> +       .r =3D "01EA842A0E17D2DE4F92C15315C63DDF72685C18195C2BB95E572B9C5=
136CA4B4B576AD712A52BE9730627D16054BA40CC0B8D3FF035B12AE75168397F5D50C67451=
",
> +       .s =3D "01F21A3CEE066E1961025FB048BD5FE2B7924D0CD797BABE0A83B66F1=
E35EEAF5FDE143FA85DC394A7DEE766523393784484BDF3E00114A1C857CDE1AA203DB65D61=
",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp521r1 sha512",
> +       .curve_name =3D "secp521r1",
> +       .x =3D "01894550D0785932E00EAA23B694F213F8C3121F86DC97A04E5A7167D=
B4E5BCD371123D46E45DB6B5D5370A7F20FB633155D38FFA16D2BD761DCAC474B9A2F5023A4=
",
> +       .y =3D "00493101C962CD4D2FDDF782285E64584139C2F91B47F87FF82354D66=
30F746A28A0DB25741B5B34A828008B22ACC23F924FAAFBD4D33F81EA66956DFEAA2BFDFCF5=
",
> +       .size_bits =3D 521,
> +       .hash_type =3D "sha-512",
> +       .hash_message =3D "sample",
> +       .r =3D "00C328FAFCBD79DD77850370C46325D987CB525569FB63C5D3BC53950=
E6D4C5F174E25A1EE9017B5D450606ADD152B534931D7D4E8455CC91F9B15BF05EC36E377FA=
",
> +       .s =3D "00617CCE7CF5064806C467F678D3B4080D6F1CC50AF26CA2094173082=
81B68AF282623EAA63E5B5C0723D8B8C37FF0777B1A20F8CCB1DCCC43997F1EE0E44DA4A67A=
",
> +       .expected =3D 0,
> +       },
> +       {
> +       .test_name =3D "secp521r1 sha512 error",
> +       .curve_name =3D "secp521r1",
> +       .x =3D "01894550D0785932E00EAA23B694F213F8C3121F86DC97A04E5A7167D=
B4E5BCD371123D46E45DB6B5D5370A7F20FB633155D38FFA16D2BD761DCAC474B9A2F5023A4=
",
> +       .y =3D "00493101C962CD4D2FDDF782285E64584139C2F91B47F87FF82354D66=
30F746A28A0DB25741B5B34A828008B22ACC23F924FAAFBD4D33F81EA66956DFEAA2BFDFCF5=
",
> +       .size_bits =3D 521,
> +       .hash_type =3D "sha-512",
> +       .hash_message =3D "sample",
> +       .r =3D "00C328FAFCBD79DD77850370C46325D987CB525569FB63C5D3BC53950=
E6D4C5F174E25A1EE9017B5D450606ADD152B534931D7D4E8455CC91F9B15BF05EC36E377FA=
",
> +       .s =3D "00017CCE7CF5064806C467F678D3B4080D6F1CC50AF26CA2094173082=
81B68AF282623EAA63E5B5C0723D8B8C37FF0777B1A20F8CCB1DCCC43997F1EE0E44DA4A67A=
",
> +       .expected =3D -EINVAL,
> +       },
> +};
> +
> +static int ecdsa_test(struct unit_test_state *uts,
> +                     struct ecdsa_test_vector_s *tv)

const struct ecdsa_test_vector *tv

> +{
> +       struct ecdsa_public_key pubkey;
> +       unsigned char x[528 / 8];
> +       unsigned char y[528 / 8];
> +       unsigned char hash[512 / 8];
> +       unsigned int hash_len;

size_t hash_len;

> +       unsigned char signature[528 / 8 * 2];
> +       unsigned int sig_len;

size_t sig_len;

> +       int ret;
> +
> +       if (!(tv->size_bits % 8))
> +               sig_len =3D tv->size_bits / 8;
> +       else
> +               sig_len =3D tv->size_bits / 8 + 1;

DIV_ROUND_UP(tv->size_bits, 8)

> +
> +       pubkey.curve_name =3D tv->curve_name;
> +       ret =3D hex2bin(x, tv->x, strlen(tv->x) / 2);
> +       ut_asserteq(0, ret);
> +       pubkey.x          =3D x;
> +       ret =3D hex2bin(y, tv->y, strlen(tv->y) / 2);
> +       ut_asserteq(0, ret);
> +       pubkey.y          =3D y;
> +       pubkey.size_bits  =3D tv->size_bits;
> +
> +       if (!strcmp(tv->hash_type, "sha-1")) {
> +#if CONFIG_IS_ENABLED(SHA1)
> +               hash_len =3D SHA1_SUM_LEN;
> +               sha1_csum_wd(tv->hash_message, strlen(tv->hash_message),
> +                            hash, SHA1_DEF_CHUNK_SZ);
> +#else
> +               /* sha1 is not supported so we skip this test */

All skipped tests should be logged with 'tv->test_name'.
Ditto.

> +               goto out;
> +#endif
> +       } else if (!strcmp(tv->hash_type, "sha-256")) {
> +#if CONFIG_IS_ENABLED(SHA256)
> +               hash_len =3D SHA256_SUM_LEN;
> +               sha256_csum_wd(tv->hash_message, strlen(tv->hash_message)=
,
> +                              hash, 0x10000);

Suggest to define a SHA256_DEF_CHUNK_SZ in the header then use it.

> +#else
> +               /* sha256 is not supported so we skip this test */
> +               goto out;
> +#endif
> +       } else if (!strcmp(tv->hash_type, "sha-384")) {
> +#if CONFIG_IS_ENABLED(SHA384)
> +               hash_len =3D SHA384_SUM_LEN;

Suggest to define a SHA384_DEF_CHUNK_SZ in the header then use it.

> +               sha384_csum_wd(tv->hash_message, strlen(tv->hash_message)=
,
> +                              hash, 0x10000);
> +#else
> +               /* sha384 is not supported so we skip this test */
> +               goto out;
> +#endif
> +       } else if (!strcmp(tv->hash_type, "sha-512")) {
> +#if CONFIG_IS_ENABLED(SHA512)
> +               hash_len =3D SHA512_SUM_LEN;
> +               sha512_csum_wd(tv->hash_message, strlen(tv->hash_message)=
,
> +                              hash, 0x10000);

Suggest to define a SHA512_DEF_CHUNK_SZ in the header then use it.

> +#else
> +               /* sha512 is not supported so we skip this test */
> +               goto out;
> +#endif
> +       } else {
> +               ut_reportf("Unknown hash type (%s)", tv->hash_type);
> +               goto out;

Should not return 0 silently, instead:
ut_failf("Unknown hash type (%s)", tv->hash_type);
return -EINVAL;

> +       }
> +
> +       memset(signature, 0, sizeof(signature));

Shall we memset x, y and hash?

> +       ret =3D hex2bin(signature, tv->r, sig_len);
> +       ut_asserteq(0, ret);
> +       ret =3D hex2bin(signature + sig_len, tv->s, sig_len);
> +       ut_asserteq(0, ret);
> +       sig_len =3D sig_len * 2;
> +
> +       ret =3D ecdsa_hash_verify(&pubkey,
> +                               hash, hash_len,
> +                               signature, sig_len);
> +       ut_asserteq(tv->expected, ret);
> +
> + out:
> +       return 0;
> +}
> +
> +static int lib_ecdsa(struct unit_test_state *uts)
> +{
> +       int i, ret, num_test =3D ARRAY_SIZE(ecdsa_test_vector);

size_t num_test =3D ARRAY_SIZE(ecdsa_test_vector);

Regards,
Raymond

> +
> +       for (i =3D 0; i < num_test; i++) {
> +               ret =3D ecdsa_test(uts, &ecdsa_test_vector[i]);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +LIB_TEST(lib_ecdsa, 0);
> --
> 2.43.0
>
