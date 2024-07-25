Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C90C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 10:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF44A8789F;
	Thu, 25 Jul 2024 12:18:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SMlDS6jc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EF9887903; Thu, 25 Jul 2024 12:18:23 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B9F87876
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 12:18:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7a264a24ea7so481931a12.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 03:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721902699; x=1722507499; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xYTkPUN+ecAuWniIVJFQMKyh/AAbd3cPwNdVeNn6mdE=;
 b=SMlDS6jcKBoOhP2VmCsNooEsCCYsBsV7A+GIfxAjs0FYAi2KiuHE94kpd0InmzWocG
 QZFW6dUKn2il0py/5NzikOXeXPrA0qSTHc3wWYiZxdxZI/sNwxt5+7iNCMed02MCU4E3
 HyXahAOj494jqO4J6LHo9fdoxfAA9lE9jPrJJNBHqyO+RMHV+6B5FTCCw+T58Djgd9yt
 09Yw2rF70B+KjdDAmVFdxTIB1mQZZLSLaQAH8iJqfa8s23VcSTWocBPHdJLpI157uPsr
 w1YXDugRkEAbTb5d7YIk34ETPmtMKlnnhKNpASYmgXH1YI885tbYa8Bq+fY2FGxooVhO
 fzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721902699; x=1722507499;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xYTkPUN+ecAuWniIVJFQMKyh/AAbd3cPwNdVeNn6mdE=;
 b=ILhNN8ekOF3aGl9emZO+fA+rmrQnv/CIQhzwKjbtOlO6srNOK1kbQWzWch9R7ufsy0
 hp6W7bA6/Km7oSAKUqupm+1K/W0Re4kjOfxrNjnwYl2S2sd9nhWp37MY3GjmgygbxV5m
 UV62xl9LXoXJgBpR+K3GB5uu66ZI4diKpN1zepzOtBpxfpBSKB0qnDn9a490oNZiEPU5
 ny6h8zWB8TZuYhLVnLYBFQa/q0N7JTJVwUrzUEqDv1d7OrwetUZU3Ez1LE9Ybeev9G11
 WCUOVHHC6P8UjnzPiHpQL8quyc+3DN8vEiZfV3NeBzbTFnnGehDDFWgeztSXgA5Gf0Un
 kpYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3ms0BAEJ9KBKLpuV27iSeBEhA0sRQciaScYhf+y3UJb+VMAsBkwfYlIYQ3vqzrXMMqi8ERXRSCHEJNi/SZTmbe59AOA==
X-Gm-Message-State: AOJu0Yzab83ADJJ6s8+XjXj2P+CpueEow59gR9gwv6zBPPUorqC3OCpP
 85AOa9/iURRYrYmw/bvNV5UnjDue1lUiHofmpVxqfhQ7s40IRrAYviN84h8e4NYmXBK+eFsKy3M
 x3LxT1hMIvB2GN1cTsihZjAZtj4pEwZhnfJMh9g==
X-Google-Smtp-Source: AGHT+IFg3Sh2mjJTOxKurdCwP5vCU0jrhnAmolMxBoZZ6mvakFB0beDiCxR1AzG9LcGcm0hQPNIY2S3jiuy8YDJiDZ4=
X-Received: by 2002:a17:90b:4c0b:b0:2cb:4bed:ed35 with SMTP id
 98e67ed59e1d1-2cf2ec157c5mr1360549a91.41.1721902699275; Thu, 25 Jul 2024
 03:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
 <20240719-b4-dynamic-uuid-v5-10-8a83de3fe3dc@linaro.org>
In-Reply-To: <20240719-b4-dynamic-uuid-v5-10-8a83de3fe3dc@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 25 Jul 2024 13:17:43 +0300
Message-ID: <CAC_iWjLqNvMmaYCPovbox9UEakQmiEQwyPsNvfrZesjkc_NbFA@mail.gmail.com>
Subject: Re: [PATCH v5 10/11] test: lib/uuid: add unit tests for dynamic UUIDs
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
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

On Fri, 19 Jul 2024 at 15:43, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Add some basic unit tests to validate that the UUID generation behaves
> as expected. This matches the implementation in efi_loader for sandbox
> and a Qualcomm board and should catch any regressions.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  test/lib/uuid.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>
> diff --git a/test/lib/uuid.c b/test/lib/uuid.c
> index 9629d378c329..2c6cfd42ddc3 100644
> --- a/test/lib/uuid.c
> +++ b/test/lib/uuid.c
> @@ -7,15 +7,20 @@
>   * Authors:
>   *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>   */
>
> +#include <charset.h>
>  #include <u-boot/uuid.h>
>  #include <test/lib.h>
>  #include <test/test.h>
>  #include <test/ut.h>
>
> +#include <efi.h>
> +
>  /* test UUID */
>  #define TEST_SVC_UUID  "ed32d533-4209-99e6-2d72-cdd998a79cc0"
> +/* U-Boot default fw image namespace */
> +#define DEFAULT_FW_IMAGE_NAMESPACE "8c9f137e-91dc-427b-b2d6-b420faebaf2a"
>
>  #define UUID_SIZE 16
>
>  /* The UUID binary data (little-endian format) */
> @@ -37,4 +42,81 @@ static int lib_test_uuid_to_le(struct unit_test_state *uts)
>         return 0;
>  }
>
>  LIB_TEST(lib_test_uuid_to_le, 0);
> +
> +struct dynamic_uuid_test_data {
> +       const char *compatible;
> +       const u16 *images[4];
> +       const char *expected_uuids[4];
> +};
> +
> +static int lib_test_dynamic_uuid_case(struct unit_test_state *uts,
> +                                     const struct dynamic_uuid_test_data *data)
> +{
> +       struct uuid namespace;
> +       int j;
> +
> +       ut_assertok(uuid_str_to_bin(DEFAULT_FW_IMAGE_NAMESPACE, (unsigned char *)&namespace,
> +                                   UUID_STR_FORMAT_GUID));
> +
> +       for (j = 0; data->images[j]; j++) {
> +               const char *expected_uuid = data->expected_uuids[j];
> +               const u16 *image = data->images[j];
> +               efi_guid_t uuid;
> +               char uuid_str[37];
> +
> +               gen_v5_guid(&namespace, &uuid,
> +                           data->compatible, strlen(data->compatible),
> +                           image, u16_strlen(image) * sizeof(uint16_t),
> +                           NULL);
> +               uuid_bin_to_str((unsigned char *)&uuid, uuid_str, UUID_STR_FORMAT_GUID);
> +
> +               ut_asserteq_str(expected_uuid, uuid_str);
> +       }
> +
> +       return 0;
> +}
> +
> +static int lib_test_dynamic_uuid(struct unit_test_state *uts)
> +{
> +       int ret, i;
> +       const struct dynamic_uuid_test_data test_data[] = {
> +               {
> +                       .compatible = "sandbox",
> +                       .images = {
> +                               u"SANDBOX-UBOOT",
> +                               u"SANDBOX-UBOOT-ENV",
> +                               u"SANDBOX-FIT",
> +                               NULL,
> +                       },
> +                       .expected_uuids = {
> +                               "985f2937-7c2e-5e9a-8a5e-8e063312964b",
> +                               "9e339473-c2eb-530a-a69b-0cd6bbbed40e",
> +                               "46610520-469e-59dc-a8dd-c11832b877ea",
> +                               NULL,
> +                       }
> +               },
> +               {
> +                       .compatible = "qcom,qrb4210-rb2",
> +                       .images = {
> +                               u"QUALCOMM-UBOOT",
> +                               NULL,
> +                       },
> +                       .expected_uuids = {
> +                               "d5021fac-8dd0-5ed7-90c2-763c304aaf86",
> +                               NULL,
> +                       }
> +               },
> +       };
> +
> +       for (i = 0; i < ARRAY_SIZE(test_data); i++) {
> +               ret = lib_test_dynamic_uuid_case(uts, &test_data[i]);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +LIB_TEST(lib_test_dynamic_uuid, 0);
> +
>
> --
> 2.45.2
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
