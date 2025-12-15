Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C36AD5B170
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 10:46:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A27A80050;
	Mon, 15 Dec 2025 11:46:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="agvXYViz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95D6580077; Mon, 15 Dec 2025 11:46:28 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD9748003E
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 11:46:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-78c33d0df85so45664857b3.0
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 02:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765795585; x=1766400385; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HzZGDQYVpUZ2TqMfaUsfCMOc6pgqEE6RIMKayNoJvUU=;
 b=agvXYVizQYKkrWFDgn/as3azkMGouA2Nw5HTh3GbjNiTi2iXTrOBJIhYTrrI+vBSxh
 +wzf4YOhITnfMFUVoNWOOfoa0eN7XrkiTGZEyTvERJmwnefAo1lr2C4rtJuE4EyMez+q
 a7ZlQIzrfKjrd7yl5q+Tj1hHXA6o39HYUBcBqKjwGcj31AFymRf2tShW9M9Bh+9JGMiP
 qkk3e1TNfyfOph4m07g4Jll11JcGzvollaMU4gKmQwz1CCwMFCI+ou1JYZSAphTv+kBg
 Uh3GZgCCgG9N/3rcV4PdO633FzihoITnoBpDu3Q5zysRX2CS8yFibAbAwpri9vD0Ah4U
 nzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765795585; x=1766400385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HzZGDQYVpUZ2TqMfaUsfCMOc6pgqEE6RIMKayNoJvUU=;
 b=oK1q2KQQshd9TI7OyNpS2O+835WFRiMEZ8mwKf1U42LO7qj6vGWcyhN3+yCXhMhkqz
 E65pccNnR5UkgBiLX1QfTp38GpJukydVhbljVrPyeKKvdzqxuz8eYl5cagQpcez5b8QO
 K77+ZQ6kZZPvTavqAj9AFisk+/NGbHnZELGy9g48jjpZw2a9WfWk9yTWCKouCAKhxpJS
 oTa/IJn9xAbnxVsyFaQdKoM4XUMkPQD9+nEA6ctI7qrHcgmIwbuq5y7JJJtOcaC7SceI
 oV8Gzprr4C7htwhQwccSIrtuIsoWDmf6O0mG800RgOAEeBI0ie8krrNHu1YLp5TAvfk2
 u3xQ==
X-Gm-Message-State: AOJu0YzeVfIEGjVEbdAiN8gJvKKH4czIIZ8Di/VI7Aoz9mo72ivTydk8
 7GriyDKFKwrzeW7g7rJ1h6JY0LzAjL4RNjC0lPbOyiYI0/OW9gjEUIxqoDzERt2fhG3Z8dG7uRy
 lT/B62a0zDk0cg1PtceBVEPuWaPlvVa5eldynTll9YqQGLzByi+uLaeuw+Q==
X-Gm-Gg: AY/fxX5BBdMu4XHfnJuRaxrTT/UGgfpJ6x0BXwZkjRDoRt+71XM4fz8PKfym/crl9cK
 LW5PYi/p10vYroDtbicQxTs7Z9Ch0qEkf+xN/hVgSpLZbq5F7n/wDWd+uoVeOMy96W82H7V6hrz
 PHq8+3SyyzWI8PlqnhJ5umvvlyEnNrlVqRKgfPybz3dLTO/gCnDbLlkUim8j1yVxJL5d8Q21CSS
 M6lFf/QrwcMEpE92u0HS5+DfPI9+8Cv7f+8MHngI6rrhb8uafmj2mIygzQX0Uu8XeBzuLFUyKH5
 LMxOHytBCSALHl7vDSSroCAZ1vmmVMelPPcNu0cteAy7KsIea46S8QZifhA8ffGIDBRPIlHQm50
 95VAz0VV4AmNr/IhDdAaM0XuEaMeSf8KCunWpFCobRqq7iWxe23cIyuHA7+B1tOTc/cU6etcz3Z
 7eUzlF5cXxZDoPtGKfhTmg4kzLbZqHNC5rd78GFy/sMqVqG3gblYBbtcTJPngpwSZW9qn4gPd8n
 IwKO5bGnIlPcn9U6/dzwbPQXZ/GpeJRDHS/iDvRfhu2r06+g+We21fG16/VOfOCP9700mYpqIB3
 ZfZVfdOybk+BGyEPTlVlCcuQhiiSasfmcn9Yk8PQEKM=
X-Google-Smtp-Source: AGHT+IFdJXwSkho147fKFiaQ6SBDWVsVpt/tVWigWMRHYqgwJyD286P981TbiRnEQlMUqPSeOdpNPR9eyMZ51RC/AkU=
X-Received: by 2002:a05:690c:d95:b0:78d:6c06:4a18 with SMTP id
 00721157ae682-78e66e5894amr78642067b3.37.1765795584668; Mon, 15 Dec 2025
 02:46:24 -0800 (PST)
MIME-Version: 1.0
References: <20251214110937.136425-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251214110937.136425-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 15 Dec 2025 12:45:48 +0200
X-Gm-Features: AQt7F2oQ2hLwagoHslCp9rru177-PabtpsHfQ2yKBzXEhF450LJdyA_os6LGPrw
Message-ID: <CAC_iWj+dMSBLJF7prZkKmcXYXiXeajRGrQ8a_3SubbH-c7O=Mg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_selftest: enhance LoadImage test
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

On Sun, 14 Dec 2025 at 13:09, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Check that only a file-system installed on a handle for thethe

Typo here, please fix it on merge. Also can you expand the commit
message a bit, explaining that load_image will eventually call
efi_dp_find_obj() catching errors in that?

> device-patch node immediately preceding the file path node is
> used for LoadImage().
>
> The test can be run with
>
>     setenv efi_selftest load image from file
>     bootefi selftest
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> The addtional test succeeds with current U-Boot but fails
> after applying
>
> [PATCH v2] efi_loader: Trigger capsule updates with automatically generated boot options
> https://lore.kernel.org/u-boot/20251208151503.1681988-1-ilias.apalodimas@linaro.org/
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_selftest/efi_selftest_loadimage.c | 45 +++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/lib/efi_selftest/efi_selftest_loadimage.c b/lib/efi_selftest/efi_selftest_loadimage.c
> index 24548f1ae63..967eaa58c69 100644
> --- a/lib/efi_selftest/efi_selftest_loadimage.c
> +++ b/lib/efi_selftest/efi_selftest_loadimage.c
> @@ -125,6 +125,44 @@ static struct {
>         }
>  };
>
> +/* Incorrect file device path */
> +static struct {
> +       struct efi_device_path_vendor vendor;
> +       struct efi_device_path_controller ctrl;
> +       struct efi_device_path path;
> +       u16 file[sizeof(FILE_NAME)];
> +       struct efi_device_path end;
> +} __packed dp_file2 = {
> +       .vendor = {
> +               .dp = {
> +                       .type = DEVICE_PATH_TYPE_HARDWARE_DEVICE,
> +                       .sub_type = DEVICE_PATH_SUB_TYPE_VENDOR,
> +                       .length = sizeof(struct efi_device_path_vendor),
> +               },
> +               .guid = EFI_GUID(0x4f9a0ebf, 0xa179, 0x88a6, 0x25, 0x68,
> +                                0x10, 0x72, 0xb1, 0x93, 0x51, 0x71),
> +       },
> +       .ctrl = {
> +               .dp = {
> +                       .type = DEVICE_PATH_TYPE_HARDWARE_DEVICE,
> +                       .sub_type = DEVICE_PATH_SUB_TYPE_CONTROLLER,
> +                       .length = sizeof(struct efi_device_path_controller),
> +               },
> +               .controller_number = 1,
> +       },
> +       .path = {
> +               .type = DEVICE_PATH_TYPE_MEDIA_DEVICE,
> +               .sub_type = DEVICE_PATH_SUB_TYPE_FILE_PATH,
> +               .length = sizeof(struct efi_device_path) + sizeof(dp_file.file),
> +       },
> +       .file = FILE_NAME,
> +       .end = {
> +               .type = DEVICE_PATH_TYPE_END,
> +               .sub_type = DEVICE_PATH_SUB_TYPE_END,
> +               .length = sizeof(struct efi_device_path),
> +       }
> +};
> +
>  /* File system info */
>  static struct file_system_info priv_file_system_info = {
>         {
> @@ -517,6 +555,13 @@ static int execute(void)
>                 return EFI_ST_FAILURE;
>         }
>
> +       ret = boottime->load_image(false, handle_image, &dp_file2.vendor.dp,
> +                                  NULL, 0, &handle);
> +       if (ret == EFI_SUCCESS) {
> +               efi_st_error("Invalid file path accepted\n");
> +               return EFI_ST_FAILURE;
> +       }
> +
>         return EFI_ST_SUCCESS;
>  }
>
> --
> 2.51.0
>
