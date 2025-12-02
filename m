Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D891FD116F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 12:42:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FFC283E4C;
	Tue,  2 Dec 2025 13:42:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l8FDEk0z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B03583E61; Tue,  2 Dec 2025 13:42:50 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2D7E83CAA
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 13:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-78a7af9fe4fso48454287b3.2
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 04:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764679367; x=1765284167; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OPD9TIanlIHWvF7x3PCMt3AbcdGQMhgCVcC565JC5yA=;
 b=l8FDEk0zaMNaEUHQtdoGBiJ8cGO5PaumMGExTYW2YuIH+CGAVX+MKkz5RU4YkKKiZb
 XFFe9nbQplxN/rTqXQ81UhLEfSBRBAeOajfU4dRJmA11ZSV0JJEJ274e3liWp5gtRrDZ
 E7T4NiU++UyZ0gSuTRovNHq63DzoX2V6JxeGDdyGKXSM96vdbS6eAqrAVMI6pzjfx5wA
 MCtE08okJTsTYqq30sOoAyqCU+qRKNJbK0lUTjoCeT1FK+TPdo7xFjTvlrw6W433pcs0
 lMRgkjpJUOciP8omAR+D1fXFyDfnogs0yY1AqP8qI1BWwXUMYBsNdSBYnPrycy+nuIY/
 Actg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764679367; x=1765284167;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OPD9TIanlIHWvF7x3PCMt3AbcdGQMhgCVcC565JC5yA=;
 b=ihOHmsnzqlEDh+XNRoBE5qzxNGoSkP8iWBM964bgrBXonXNnv9sYeyDI7avwSpeseF
 clJX6eRh3RqB2fPx83iQ3997pNZzLg3wg7avvyZP8scPSZxaEDfnv/5shrqPNNn+X/5x
 5vXgpxn7nT5+To7B+Tuy1T4yBfe1ZbN9zrnQY9GfIhV8WNt6cORbdBdSrPfAMPNHB/Ep
 AJPshLXmiuobMmbO99xaqXwVeXFZHuhiomrKL0L5gXfXT4irhfvRJuXZZ6GB/HUqZPlo
 hA8ajqln3OcZTEizJWIg/hn4hazkJNBPf4DsSiZkuqn4wgGYeTI5uJQYjfn4toEVdzBy
 zLkg==
X-Gm-Message-State: AOJu0YylWri72uUhCOvIkFknxD5TlCjwyp3DJiDOA8zBPydgOquPZOs6
 RCmlbZVnDHtMAm3YXqGA2Xxvrtx6bPis4oicA9YXVPNzZ0rS7iOvRmpqSqW+qlI4mzzKZs/XaBN
 vhWoEQJdm24zVs6lVG4jAMA+EFm0TwDlo1/z4//n7JQ==
X-Gm-Gg: ASbGncsodc5BqGHefbivqCE1i3AdnICHwFNrhCqzWGZaeYfRTAafbc3QqfnH5lF+EBu
 DTwjrc/LARlk18C7a/iWE9EhHskKRDX5gUj5VpBkMaBOR18yYKYruU5yVu+rPuKhVXAT+ZChpnk
 erRSJ+yaLV99fwWbtcw/waKKOgyF0keFr/uSSxwAKh/0b8caOueAlhPHWzsbu+yIUjLoJAmu/PT
 NLaRNYurBy1uEhFoIpy+j9EKVpyHiZTgzTyGkfLZgMraFry8l/WxbdEk9hob4vSIQ70wdo2oUPd
 qyyM2ilZVHZiEaskg9ZLpzwTNRc24zBjkhAOJtP6b334yykLmobE68z/iR6jVhb/GXEVh/n7WUh
 zwz3IeIM=
X-Google-Smtp-Source: AGHT+IGOWWTBe01KIGAbKNvErm9TKhF1AJlWguD68Gpml54Bd2hHIGgUVCZyCOzIRk1/7E7QvFYSLpw4zGDXWfmNnY4=
X-Received: by 2002:a05:690c:48c4:b0:784:f14d:6946 with SMTP id
 00721157ae682-78a8b558e24mr365291127b3.55.1764679366605; Tue, 02 Dec 2025
 04:42:46 -0800 (PST)
MIME-Version: 1.0
References: <20251114093246.56422-1-heinrich.schuchardt@canonical.com>
 <20251114093246.56422-7-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251114093246.56422-7-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 2 Dec 2025 14:42:09 +0200
X-Gm-Features: AWmQ_bm1MzQiVaDahwG4UxFPnlsPA_4rKyvXnSiGHM8GWWITZeL9ph_Ql6lU2c4
Message-ID: <CAC_iWjK2e1y8zOnBvNuY82_VA-sCqCm-uCYbKs7+wOp1-isCuA@mail.gmail.com>
Subject: Re: [PATCH 6/7] efi_selftest: simplify efi_selftest_variables
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Fri, 14 Nov 2025 at 11:33, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Use global st_boottime and st_runtime.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  lib/efi_selftest/efi_selftest_variables.c | 118 +++++++++-------------
>  1 file changed, 50 insertions(+), 68 deletions(-)
>
> diff --git a/lib/efi_selftest/efi_selftest_variables.c b/lib/efi_selftest/efi_selftest_variables.c
> index b92c3276b61..976eee8dcef 100644
> --- a/lib/efi_selftest/efi_selftest_variables.c
> +++ b/lib/efi_selftest/efi_selftest_variables.c
> @@ -13,8 +13,6 @@
>  #define EFI_ST_MAX_DATA_SIZE 16
>  #define EFI_ST_MAX_VARNAME_SIZE 80
>
> -static struct efi_boot_services *boottime;
> -static struct efi_runtime_services *runtime;
>  static const efi_guid_t guid_vendor0 =
>         EFI_GUID(0x67029eb5, 0x0af2, 0xf6b1,
>                  0xda, 0x53, 0xfc, 0xb5, 0x66, 0xdd, 0x1c, 0xe6);
> @@ -22,21 +20,6 @@ static const efi_guid_t guid_vendor1 =
>         EFI_GUID(0xff629290, 0x1fc1, 0xd73f,
>                  0x8f, 0xb1, 0x32, 0xf9, 0x0c, 0xa0, 0x42, 0xea);
>
> -/*
> - * Setup unit test.
> - *
> - * @handle     handle of the loaded image
> - * @systable   system table
> - */
> -static int setup(const efi_handle_t img_handle,
> -                const struct efi_system_table *systable)
> -{
> -       boottime = systable->boottime;
> -       runtime = systable->runtime;
> -
> -       return EFI_ST_SUCCESS;
> -}
> -
>  /*
>   * Execute unit test.
>   */
> @@ -59,17 +42,17 @@ static int execute(void)
>                 return EFI_ST_FAILURE;
>         }
>         /* Set variable 0 */
> -       ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> -                                   EFI_VARIABLE_BOOTSERVICE_ACCESS,
> -                                   3, v + 4);
> +       ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> +                                      EFI_VARIABLE_BOOTSERVICE_ACCESS, 3,
> +                                      v + 4);
>         if (ret != EFI_SUCCESS) {
>                 efi_st_error("SetVariable failed\n");
>                 return EFI_ST_FAILURE;
>         }
>         data[3] = 0xff;
>         len = 3;
> -       ret = runtime->get_variable(u"efi_st_var0", &guid_vendor0,
> -                                   &attr, &len, data);
> +       ret = st_runtime->get_variable(u"efi_st_var0", &guid_vendor0, &attr,
> +                                      &len, data);
>         if (ret != EFI_SUCCESS) {
>                 efi_st_error("GetVariable failed\n");
>                 return EFI_ST_FAILURE;
> @@ -83,16 +66,15 @@ static int execute(void)
>                 return EFI_ST_FAILURE;
>         }
>         /* Set variable 1 */
> -       ret = runtime->set_variable(u"efi_st_var1", &guid_vendor1,
> -                                   EFI_VARIABLE_BOOTSERVICE_ACCESS,
> -                                   8, v);
> +       ret = st_runtime->set_variable(u"efi_st_var1", &guid_vendor1,
> +                                      EFI_VARIABLE_BOOTSERVICE_ACCESS, 8, v);
>         if (ret != EFI_SUCCESS) {
>                 efi_st_error("SetVariable failed\n");
>                 return EFI_ST_FAILURE;
>         }
>         len = EFI_ST_MAX_DATA_SIZE;
> -       ret = runtime->get_variable(u"efi_st_var1", &guid_vendor1,
> -                                   &attr, &len, data);
> +       ret = st_runtime->get_variable(u"efi_st_var1", &guid_vendor1, &attr,
> +                                      &len, data);
>         if (ret != EFI_SUCCESS) {
>                 efi_st_error("GetVariable failed\n");
>                 return EFI_ST_FAILURE;
> @@ -107,17 +89,17 @@ static int execute(void)
>                 return EFI_ST_FAILURE;
>         }
>         /* Append variable 1 */
> -       ret = runtime->set_variable(u"efi_st_var1", &guid_vendor1,
> -                                   EFI_VARIABLE_BOOTSERVICE_ACCESS |
> -                                   EFI_VARIABLE_APPEND_WRITE,
> -                                   7, v + 8);
> +       ret = st_runtime->set_variable(u"efi_st_var1", &guid_vendor1,
> +                                      EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +                                              EFI_VARIABLE_APPEND_WRITE,
> +                                      7, v + 8);
>         if (ret != EFI_SUCCESS) {
>                 efi_st_error("SetVariable(APPEND_WRITE) failed\n");
>                 return EFI_ST_FAILURE;
>         }
>         len = EFI_ST_MAX_DATA_SIZE;
> -       ret = runtime->get_variable(u"efi_st_var1", &guid_vendor1,
> -                                   &attr, &len, data);
> +       ret = st_runtime->get_variable(u"efi_st_var1", &guid_vendor1, &attr,
> +                                      &len, data);
>         if (ret != EFI_SUCCESS) {
>                 efi_st_error("GetVariable failed\n");
>                 return EFI_ST_FAILURE;
> @@ -129,34 +111,35 @@ static int execute(void)
>                 efi_st_todo("GetVariable returned wrong value\n");
>
>         /* Append variable 2, write to non-existent variable with datasize=0 */
> -       ret = runtime->set_variable(u"efi_none", &guid_vendor1,
> -                                   EFI_VARIABLE_BOOTSERVICE_ACCESS |
> -                                   EFI_VARIABLE_APPEND_WRITE,
> -                                   0, v);
> +       ret = st_runtime->set_variable(u"efi_none", &guid_vendor1,
> +                                      EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +                                              EFI_VARIABLE_APPEND_WRITE,
> +                                      0, v);
>         if (ret != EFI_SUCCESS) {
>                 efi_st_error(
>                         "SetVariable(APPEND_WRITE) with size 0 to non-existent variable returns wrong code\n");
>                 return EFI_ST_FAILURE;
>         }
>         len = EFI_ST_MAX_DATA_SIZE;
> -       ret = runtime->get_variable(u"efi_none", &guid_vendor1,
> -                                   &attr, &len, data);
> +       ret = st_runtime->get_variable(u"efi_none", &guid_vendor1, &attr, &len,
> +                                      data);
>         if (ret != EFI_NOT_FOUND) {
>                 efi_st_error("Variable must not be created\n");
>                 return EFI_ST_FAILURE;
>         }
>         /* Append variable 2, write to non-existent variable with valid data size*/
> -       ret = runtime->set_variable(u"efi_none", &guid_vendor1,
> -                                   EFI_VARIABLE_BOOTSERVICE_ACCESS |
> -                                   EFI_VARIABLE_APPEND_WRITE,
> -                                   15, v);
> +       ret = st_runtime->set_variable(u"efi_none", &guid_vendor1,
> +                                      EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +                                              EFI_VARIABLE_APPEND_WRITE,
> +                                      15, v);
>         if (ret != EFI_SUCCESS) {
> -               efi_st_error("SetVariable(APPEND_WRITE) with valid size and data to non-existent variable must be succcessful\n");
> +               efi_st_error(
> +                       "SetVariable(APPEND_WRITE) with valid size and data to non-existent variable must be succcessful\n");
>                 return EFI_ST_FAILURE;
>         }
>         len = EFI_ST_MAX_DATA_SIZE;
> -       ret = runtime->get_variable(u"efi_none", &guid_vendor1,
> -                                   &attr, &len, data);
> +       ret = st_runtime->get_variable(u"efi_none", &guid_vendor1, &attr, &len,
> +                                      data);
>         if (ret != EFI_SUCCESS) {
>                 efi_st_error("GetVariable failed\n");
>                 return EFI_ST_FAILURE;
> @@ -167,61 +150,60 @@ static int execute(void)
>         if (memcmp(data, v, len))
>                 efi_st_todo("GetVariable returned wrong value\n");
>         /* Delete variable efi_none */
> -       ret = runtime->set_variable(u"efi_none", &guid_vendor1,
> -                                   0, 0, NULL);
> +       ret = st_runtime->set_variable(u"efi_none", &guid_vendor1, 0, 0, NULL);
>         if (ret != EFI_SUCCESS) {
>                 efi_st_error("SetVariable failed\n");
>                 return EFI_ST_FAILURE;
>         }
>         len = EFI_ST_MAX_DATA_SIZE;
> -       ret = runtime->get_variable(u"efi_none", &guid_vendor1,
> -                                   &attr, &len, data);
> +       ret = st_runtime->get_variable(u"efi_none", &guid_vendor1, &attr, &len,
> +                                      data);
>         if (ret != EFI_NOT_FOUND) {
>                 efi_st_error("Variable was not deleted\n");
>                 return EFI_ST_FAILURE;
>         }
>         /* Enumerate variables */
>
> -       ret = runtime->get_next_variable_name(NULL, u"efi_st_var1", &guid);
> +       ret = st_runtime->get_next_variable_name(NULL, u"efi_st_var1", &guid);
>         if (ret != EFI_INVALID_PARAMETER) {
>                 efi_st_error("GetNextVariableName missing parameter check\n");
>                 return EFI_ST_FAILURE;
>         }
>
>         len = 24;
> -       ret = runtime->get_next_variable_name(&len, NULL, &guid);
> +       ret = st_runtime->get_next_variable_name(&len, NULL, &guid);
>         if (ret != EFI_INVALID_PARAMETER) {
>                 efi_st_error("GetNextVariableName missing parameter check\n");
>                 return EFI_ST_FAILURE;
>         }
>
>         len = 24;
> -       ret = runtime->get_next_variable_name(&len, u"efi_st_var1", NULL);
> +       ret = st_runtime->get_next_variable_name(&len, u"efi_st_var1", NULL);
>         if (ret != EFI_INVALID_PARAMETER) {
>                 efi_st_error("GetNextVariableName missing parameter check\n");
>                 return EFI_ST_FAILURE;
>         }
>
>         len = 1;
> -       ret = runtime->get_next_variable_name(&len, u"", &guid);
> +       ret = st_runtime->get_next_variable_name(&len, u"", &guid);
>         if (ret != EFI_INVALID_PARAMETER) {
>                 efi_st_error("GetNextVariableName missing parameter check\n");
>                 return EFI_ST_FAILURE;
>         }
>
>         len = 16;
> -       ret = runtime->get_next_variable_name(&len, u"efi_st_var1", &guid);
> +       ret = st_runtime->get_next_variable_name(&len, u"efi_st_var1", &guid);
>         if (ret != EFI_INVALID_PARAMETER) {
>                 efi_st_error("GetNextVariableName missing parameter check\n");
>                 return EFI_ST_FAILURE;
>         }
>
> -       boottime->set_mem(&guid, 16, 0);
> +       st_boottime->set_mem(&guid, 16, 0);
>         *varname = 0;
>         flag = 0;
>         for (;;) {
>                 len = EFI_ST_MAX_VARNAME_SIZE;
> -               ret = runtime->get_next_variable_name(&len, varname, &guid);
> +               ret = st_runtime->get_next_variable_name(&len, varname, &guid);
>                 if (ret == EFI_NOT_FOUND)
>                         break;
>                 if (ret != EFI_SUCCESS) {
> @@ -233,8 +215,9 @@ static int execute(void)
>                     !efi_st_strcmp_16_8(varname, "efi_st_var0")) {
>                         flag |= 1;
>                         if (len != 24) {
> -                               efi_st_error("GetNextVariableName report wrong length %u, expected 24\n",
> -                                            (unsigned int)len);
> +                               efi_st_error(
> +                                       "GetNextVariableName report wrong length %u, expected 24\n",
> +                                       (unsigned int)len);
>                                 return EFI_ST_FAILURE;
>                         }
>                 }
> @@ -248,29 +231,29 @@ static int execute(void)
>                 return EFI_ST_FAILURE;
>         }
>         /* Delete variable 1 */
> -       ret = runtime->set_variable(u"efi_st_var1", &guid_vendor1,
> -                                   0, 0, NULL);
> +       ret = st_runtime->set_variable(u"efi_st_var1", &guid_vendor1, 0, 0,
> +                                      NULL);
>         if (ret != EFI_SUCCESS) {
>                 efi_st_error("SetVariable failed\n");
>                 return EFI_ST_FAILURE;
>         }
>         len = EFI_ST_MAX_DATA_SIZE;
> -       ret = runtime->get_variable(u"efi_st_var1", &guid_vendor1,
> -                                   &attr, &len, data);
> +       ret = st_runtime->get_variable(u"efi_st_var1", &guid_vendor1, &attr,
> +                                      &len, data);
>         if (ret != EFI_NOT_FOUND) {
>                 efi_st_error("Variable was not deleted\n");
>                 return EFI_ST_FAILURE;
>         }
>         /* Delete variable 0 */
> -       ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
> -                                   0, 0, NULL);
> +       ret = st_runtime->set_variable(u"efi_st_var0", &guid_vendor0, 0, 0,
> +                                      NULL);
>         if (ret != EFI_SUCCESS) {
>                 efi_st_error("SetVariable failed\n");
>                 return EFI_ST_FAILURE;
>         }
>         len = EFI_ST_MAX_DATA_SIZE;
> -       ret = runtime->get_variable(u"efi_st_var0", &guid_vendor0,
> -                                   &attr, &len, data);
> +       ret = st_runtime->get_variable(u"efi_st_var0", &guid_vendor0, &attr,
> +                                      &len, data);
>         if (ret != EFI_NOT_FOUND) {
>                 efi_st_error("Variable was not deleted\n");
>                 return EFI_ST_FAILURE;
> @@ -282,6 +265,5 @@ static int execute(void)
>  EFI_UNIT_TEST(variables) = {
>         .name = "variables",
>         .phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
> -       .setup = setup,
>         .execute = execute,
>  };
> --
> 2.51.0
>
