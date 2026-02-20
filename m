Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE328C5ACD9
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 16:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F96383C39;
	Fri, 20 Feb 2026 17:36:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SgcDseFW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2900183CF5; Fri, 20 Feb 2026 17:36:45 +0100 (CET)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A23283A41
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 17:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-5670ea44187so1712848e0c.0
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 08:36:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771605401; cv=none;
 d=google.com; s=arc-20240605;
 b=WNCEnJvQZHUMcdkrdn/dGsvjffkIGwAT9zghIzRH1R61JaHJtSguR8Hxs0aWc0p5T5
 8XNGK5kOW16bRdTIAz8waLliO0mTdU9NBZtMrcP/BIQr/0pz6HeOD5eykQ4uBRQ2TpXO
 ufJvxbxXH76FXBkEAeOd2h0eXzd6B8mzOJSV3aoaWMjnFIyaY/VKIh6LTwRotUXIGKPb
 WjwSRZJ2xIe1rckwZC1wwFxqZJvZJjtkB3GKRgmQCUZIVg2U7eXrVGtFBUxGEWFOG7ij
 Y9uHoTvvL1nc8pd9afn++IPiYDffA6uFKfjqAP9BcfCPZOA0Ch2gG0z9Owh7voDsvfgd
 pOww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kRQkQ7X6Tgu6KszNAAMOqn7JSiMgTbnTKBapbb2ehyM=;
 fh=p+1aHfklb6lZWhNez1jov7a+LOVV8wufm91BwWPcsAI=;
 b=WD2ft/XUGEnUy0rsKau6s22WvqbEyXoN4En1vhq245UqMB4T4N0YZSmM0G5LP4ZOEv
 By1RSEqp/N956sFCR0NEu+VOzk+acsGp76yvgHiumfspCf9bjz+yQl2n0pNYVSHJFCCN
 +dxQyRxE96eB68+ZgPYCqS/Vk4GbJuDx82iCnLNXWEVn4aFkLZIGXsgDXMFtnLDOu6az
 EytSTQCkwIK+2Uy5cGoNkDJbrJMz1yxjj2uzlHVehIdopMpsZWB9Gtu4uKVLUmoF0aH9
 GAqmeossoQh4kjgcoS5H76HFtAKX8lwxAouJoCUotytvJsSxUvWcUZA+vSnm/Q+1pzyi
 I7AQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771605401; x=1772210201; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kRQkQ7X6Tgu6KszNAAMOqn7JSiMgTbnTKBapbb2ehyM=;
 b=SgcDseFWV51/qBvlHjK9ZrrKqx1Sq1pB09JgrZhJ/TErHQjLSB6KV5sphhDqF/a0I/
 jDLi7deqyD981ZZkivK8q/vR1JxTNj3/W5v8Z5Io896vH9r2tun9IqLo9YW59VJyTNk0
 m67VHFqxtNf9Xe/dZNLc7fuYwq/YmZrIQNd/L4k3tDs3g4zXMiI2tlIdPBiW50Hxce6x
 wABKVva2Foog3rEPTXKmsSJMpAkUsPxqHjP46fhYfR5w0VXFgk1uuWx1KxRKegmwZ3sr
 zqbDtplI6OymjyfkscJgD7p2WWVI+9ny1q9ny3WfGBWCiY7bL7Dz5C8fjAGdgkzkix5o
 MiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771605401; x=1772210201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kRQkQ7X6Tgu6KszNAAMOqn7JSiMgTbnTKBapbb2ehyM=;
 b=FLF5qgx/GHg8Zu5IV9/zwGSlsFaRmlF0W3id+3H3mk/NKhRQhBhoFXoY3uXLD4rHRa
 IHgdxKEilI0Xp5K5bQOVbCeRQQX2TByOk+v9PlF4LSEwoOwuhtTVXStUSDbygtXLpnEI
 8nJOy0GztWZHRqY0czElHSfR4HwESg/CXsPdgPEm8CsJyVRUNF6ptakvZ7yJaU5u/EBC
 AEWkE1fsVLckwj1LQocnhd23UCVFU6q9IOW6ZXZYE4XLI6xNy/aEFTLLbXZ6rQl+5LTM
 cOs/9zxJheAukT3miLIE5swKC1fGGxFy5Ld54vVY5cLz7jVFkiYiWYV6VXvKCrWMLyxx
 gtgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRHQEXspp2FqTpTgarftiQfw/mKbQ6Ok0mmqcb2Dvq8XZlp1k+iEQWTFtT/HCt8EzMrCCUqQA=@lists.denx.de
X-Gm-Message-State: AOJu0YzBnZ0UFhmSsxvzxCtJRjyS58BCf/hdY6w9DOmWTELv4Whv1Sci
 35BbAkkaOtKsLsTTf5+xwLx1XSjCFgSSciB5b7trSpNZlCtmM05v7OyewzlOs8G0pwj0dDLad4R
 r0p6+Qb0QBKGTqWO2OnJM7qCgdkdzL1o=
X-Gm-Gg: AZuq6aKvc6s0YUYglcpf+fqUP/pOZ47e7KeYBkJ3Srunf20sAGMLwNaB626NN4Dtefm
 P83r8hRTyqaFHzNyeIzAoYb3dz5zLR0N4sXOOnUx1DQdygrEz9NvoSxjN8V6HeTIELRIUWnCxo+
 a6cnARfGj3YOxPaLsLV4e06aD1AxCdkQ5DQ5MUKz3m9kOIDJQX8VxZhwFN+buFC550jOsqcWW7U
 c9AzgOyPF3KpgDxtwoFAc6OEQO3zaBUw1/SgAAY1BdcBChCQj2X3gbPRyQoAZXprvO0QE/fX2ot
 Yz8qwDab
X-Received: by 2002:a05:6102:2926:b0:5fc:2b29:b005 with SMTP id
 ada2fe7eead31-5feb3071c05mr257966137.24.1771605401108; Fri, 20 Feb 2026
 08:36:41 -0800 (PST)
MIME-Version: 1.0
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
 <20260219132552.1499698-4-philippe.reynes@softathome.com>
In-Reply-To: <20260219132552.1499698-4-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Fri, 20 Feb 2026 11:36:28 -0500
X-Gm-Features: AaiRm515dphx740BR1eOu2T6S2W84KU3sM4dKb6IOun95B60F7YIjVZnmU8jnf0
Message-ID: <CAMDkj5xYprNzwuEkcM=o_0ctNvoctHOei2cu5dark6SG-5_zTw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/9] test: lib: sw_ecdsa: add initial test
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
> Adds tests to check that the function sw_ecdsa_verify
> using mbedtls is valid.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v2:
> - little change to only use test with sha enabled
>
>  test/lib/Makefile   |   1 +
>  test/lib/sw_ecdsa.c | 465 ++++++++++++++++++++++++++++++++++++++++++++


Please rename the file to 'ecdsa.c'.


>  2 files changed, 466 insertions(+)
>  create mode 100644 test/lib/sw_ecdsa.c
>
> diff --git a/test/lib/Makefile b/test/lib/Makefile
> index f25383a40e5..8837446968b 100644
> --- a/test/lib/Makefile
> +++ b/test/lib/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_$(PHASE_)UT_COMPRESSION) +=3D compression.o
>  ifeq ($(CONFIG_XPL_BUILD),)
>  obj-y +=3D abuf.o
>  obj-y +=3D alist.o
> +obj-$(CONFIG_ECDSA_MBEDTLS) +=3D sw_ecdsa.o
>  obj-$(CONFIG_EFI_LOADER) +=3D efi_device_path.o efi_memory.o
>  obj-$(CONFIG_EFI_SECURE_BOOT) +=3D efi_image_region.o
>  ifdef CONFIG_RISCV
> diff --git a/test/lib/sw_ecdsa.c b/test/lib/sw_ecdsa.c
> new file mode 100644
> index 00000000000..431b44af596
> --- /dev/null
> +++ b/test/lib/sw_ecdsa.c
> @@ -0,0 +1,465 @@
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
> +#include <crypto/internal/sw_ecdsa.h>
> +
> +#include <mbedtls/ecp.h>
> +
> +struct ecdsa_test_vector_s {
> +       char *test_name;
> +       char *curve_name;


'const char *' for both names.


> +       unsigned char *x;
> +       unsigned char *y;
> +       int size_bits;
> +       unsigned char *hash_type;
> +       unsigned char *hash_message;
> +       unsigned char *k;


The 'k' is unused throughout the code, please remove it from the
structure and all the test vectors.


> +       unsigned char *r;
> +       unsigned char *s;
> +       int expected;
> +};
> +
> +/*
> + * Those data come from RFC6979
> + */
> +
> +struct ecdsa_test_vector_s ecdsa_test_vector[] =3D {
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
> +       .k =3D "37D7CA00D2C7B0E5E412AC03BD44BA837FDD5B28CD3B0021",
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
> +       .k =3D "32B1B6D7D42A05CB449065727A84804FB1A3E34D8F261496",
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
> +       .k =3D "4730005C4FCB01834C063A7B6760096DBE284B8252EF4311",
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
> +       .k =3D "A2AC7AB055E4F20692D49209544C203A7D1F2C0BFBC75DB1",
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
> +       .k =3D "A2AC7AB055E4F20692D49209544C203A7D1F2C0BFBC75DB1",
> +       .r =3D "4D60C5AB1996BD848343B31C00850205E2EA6922DAC2E4B8",
> +       .s =3D "0F6E837448F027A1BF4B34E796E32A811CBB4050908D8F67",
> +       .expected =3D MBEDTLS_ERR_ECP_VERIFY_FAILED,
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
> +       .k =3D "7EEFADD91110D8DE6C2C470831387C50D3357F7F4D477054B8B426BC"=
,
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
> +       .k =3D "AD3029E0278F80643DE33917CE6908C70A8FF50A411F06E41DEDFCDC"=
,
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
> +       .k =3D "52B40F5A9D3D13040F494E83D3906C6079F29981035C7BD51E5CAC40"=
,
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
> +       .k =3D "9DB103FFEDEDF9CFDBA05184F925400C1653B8501BAB89CEA0FBEC14"=
,
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
> +       .k =3D "9DB103FFEDEDF9CFDBA05184F925400C1653B8501BAB89CEA0FBEC14"=
,
> +       .r =3D "074BD1D979D5F32BF958DDC61E4FB4872ADCAFEB2256497CDAC30397"=
,
> +       .s =3D "04CECA196C3D5A1FF31027B33185DC8EE43F288B21AB342E5D8EB084"=
,
> +       .expected =3D MBEDTLS_ERR_ECP_VERIFY_FAILED,
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
> +       .k =3D "882905F1227FD620FBF2ABF21244F0BA83D0DC3A9103DBBEE43A1FB85=
8109DB4",
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
> +       .k =3D "A6E3C57DD01ABE90086538398355DD4C3B17AA873382B0F24D6129493=
D8AAD60",
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
> +       .k =3D "09F634B188CEFD98E7EC88B1AA9852D734D0BC272F7D2A47DECC6EBEB=
375AAD4",
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
> +       .k =3D "5FA81C63109BADB88C1F367B47DA606DA28CAD69AA22C4FE6AD7DF73A=
7173AA5",
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
> +       .k =3D "5FA81C63109BADB88C1F367B47DA606DA28CAD69AA22C4FE6AD7DF73A=
7173AA5",
> +       .r =3D "8496A60B5E9B47C825488827E0495B0E3FA109EC4568FD3F8D1097678=
EB97F00",
> +       .s =3D "0362AB1ADBE2B8ADF9CB9EDAB740EA6049C028114F2460F96554F61FA=
E3302FE",
> +       .expected =3D MBEDTLS_ERR_ECP_VERIFY_FAILED,
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
> +       .k =3D "4471EF7518BB2C7C20F62EAE1C387AD0C5E8E470995DB4ACF694466E6=
AB096630F29E5938D25106C3C340045A2DB01A7",
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
> +       .k =3D "180AE9F9AEC5438A44BC159A1FCB277C7BE54FA20E7CF404B490650A8=
ACC414E375572342863C899F9F2EDF9747A9B60",
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
> +       .k =3D "94ED910D1A099DAD3254E9242AE85ABDE4BA15168EAF0CA87A555FD56=
D10FBCA2907E3E83BA95368623B8C4686915CF9",
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
> +       .k =3D "92FC3C7183A883E24216D1141F1A8976C5B0DD797DFA597E3D7B32198=
BD35331A4E966532593A52980D0E3AAA5E10EC3",
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
> +       .k =3D "92FC3C7183A883E24216D1141F1A8976C5B0DD797DFA597E3D7B32198=
BD35331A4E966532593A52980D0E3AAA5E10EC3",
> +       .r =3D "ED0959D5880AB2D869AE7F6C2915C6D60F96507F9CB3E047C0046861D=
A4A799CFE30F35CC900056D7C99CD7882433709",
> +       .s =3D "012C8CCEEE3890A84058CE1E22DBC2198F42323CE8ACA9135329F03C0=
68E5112DC7CC3EF3446DEFCEB01A45C2667FDD5",
> +       .expected =3D MBEDTLS_ERR_ECP_VERIFY_FAILED,
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
> +       .k =3D "0089C071B419E1C2820962321787258469511958E80582E95D8378E0C=
2CCDB3CB42BEDE42F50E3FA3C71F5A76724281D31D9C89F0F91FC1BE4918DB1C03A5838D0F9=
",
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
> +       .k =3D "00EDF38AFCAAECAB4383358B34D67C9F2216C8382AAEA44A3DAD5FDC9=
C32575761793FEF24EB0FC276DFC4F6E3EC476752F043CF01415387470BCBD8678ED2C7E1A0=
",
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
> +       .k =3D "01546A108BC23A15D6F21872F7DED661FA8431DDBD922D0DCDB77CC87=
8C8553FFAD064C95A920A750AC9137E527390D2D92F153E66196966EA554D9ADFCB109C4211=
",
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
> +       .k =3D "01DAE2EA071F8110DC26882D4D5EAE0621A3256FC8847FB9022E2B7D2=
8E6F10198B1574FDD03A9053C08A1854A168AA5A57470EC97DD5CE090124EF52A2F7ECBFFD3=
",
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
> +       .k =3D "01DAE2EA071F8110DC26882D4D5EAE0621A3256FC8847FB9022E2B7D2=
8E6F10198B1574FDD03A9053C08A1854A168AA5A57470EC97DD5CE090124EF52A2F7ECBFFD3=
",
> +       .r =3D "00C328FAFCBD79DD77850370C46325D987CB525569FB63C5D3BC53950=
E6D4C5F174E25A1EE9017B5D450606ADD152B534931D7D4E8455CC91F9B15BF05EC36E377FA=
",
> +       .s =3D "00017CCE7CF5064806C467F678D3B4080D6F1CC50AF26CA2094173082=
81B68AF282623EAA63E5B5C0723D8B8C37FF0777B1A20F8CCB1DCCC43997F1EE0E44DA4A67A=
",
> +       .expected =3D MBEDTLS_ERR_ECP_VERIFY_FAILED,
> +       },
> +};


All '.expected =3D MBEDTLS_ERR_ECP_VERIFY_FAILED' above should be
changed to U-Boot error code, as I commented in your patch [2/9], we
should map all MbedTLS internal error code to U-Boot error code.


> +
> +int ecdsa_test(struct unit_test_state *uts, struct ecdsa_test_vector_s *=
tv)


static int ecdsa_test(struct unit_test_state *uts,
      const struct ecdsa_test_vector_s *tv)


> +{
> +       struct ecdsa_public_key pubkey;
> +       unsigned char x[528 / 8];
> +       unsigned char y[528 / 8];
> +       unsigned char hash[512 / 8];
> +       unsigned int hash_len;
> +       unsigned char signature[528 / 8 * 2];
> +       unsigned int sig_len;
> +       int ret;
> +
> +       if (!(tv->size_bits % 8))
> +               sig_len =3D tv->size_bits / 8;
> +       else
> +               sig_len =3D tv->size_bits / 8 + 1;
> +
> +       pubkey.curve_name =3D tv->curve_name;
> +       hex2bin(x, tv->x, strlen(tv->x) / 2);


Please check the return value of hex2bin(), same for all below.


> +       pubkey.x          =3D x;
> +       hex2bin(y, tv->y, strlen(tv->y) / 2);
> +       pubkey.y          =3D y;
> +       pubkey.size_bits  =3D tv->size_bits;
> +
> +       if (!strcmp(tv->hash_type, "sha-1")) {
> +#if CONFIG_IS_ENABLED(SHA1)
> +               hash_len =3D SHA1_SUM_LEN;
> +               sha1_csum_wd(tv->hash_message, strlen(tv->hash_message),
> +                            hash, hash_len);


The last arg of 'sha*_csum_wd()' is the watchdog chunk size, not the
hash output length.
Passing hash_len here happens to work (small chunk), but it is
semantically wrong.
Please use 0 (no watchdog) or a proper chunk constant.
Same for all 'sha*_csum_wd()' below.


> +#else
> +               /* sha1 is not supported so we skip this test */
> +               goto out;
> +#endif
> +       } else if (!strcmp(tv->hash_type, "sha-256")) {
> +#if CONFIG_IS_ENABLED(SHA256)
> +               hash_len =3D SHA256_SUM_LEN;
> +               sha256_csum_wd(tv->hash_message, strlen(tv->hash_message)=
,
> +                              hash, hash_len);
> +#else
> +               /* sha256 is not supported so we skip this test */
> +               goto out;
> +#endif
> +       } else if (!strcmp(tv->hash_type, "sha-384")) {
> +#if CONFIG_IS_ENABLED(SHA384)
> +               hash_len =3D SHA384_SUM_LEN;
> +               sha384_csum_wd(tv->hash_message, strlen(tv->hash_message)=
,
> +                              hash, hash_len);
> +#else
> +               /* sha384 is not supported so we skip this test */
> +               goto out;
> +#endif
> +       } else if (!strcmp(tv->hash_type, "sha-512")) {
> +#if CONFIG_IS_ENABLED(SHA512)
> +               hash_len =3D SHA512_SUM_LEN;
> +               sha512_csum_wd(tv->hash_message, strlen(tv->hash_message)=
,
> +                              hash, hash_len);
> +#else
> +               /* sha512 is not supported so we skip this test */
> +               goto out;
> +#endif
> +       } else {
> +               ut_reportf("Unknown hash type (%s)", tv->hash_type);
> +               goto out;
> +       }
> +
> +       memset(signature, 0, sizeof(signature));
> +       hex2bin(signature, tv->r, sig_len);
> +       hex2bin(signature + sig_len, tv->s, sig_len);
> +       sig_len =3D sig_len * 2;
> +
> +       ret =3D sw_ecdsa_verify(&pubkey,
> +                             hash, hash_len,
> +                             signature, sig_len);
> +       ut_asserteq(tv->expected, ret);
> +
> + out:
> +       return 0;
> +}
> +
> +static int lib_sw_ecdsa(struct unit_test_state *uts)
> +{
> +       int i, num_test =3D ARRAY_SIZE(ecdsa_test_vector);
> +
> +       for (i =3D 0; i < num_test; i++)
> +               ecdsa_test(uts, &ecdsa_test_vector[i]);


Please check the return code here, or change ecdsa_test to void (Seems
that it always returns 0).

Regards,
Raymond

> +
> +       return 0;
> +}
> +
> +LIB_TEST(lib_sw_ecdsa, 0);
> --
> 2.43.0
>
