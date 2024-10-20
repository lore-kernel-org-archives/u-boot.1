Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4977CD3C927
	for <u-boot@archiver.kernel.org>; Sun, 20 Oct 2024 04:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFBFE88EB7;
	Sun, 20 Oct 2024 06:33:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I0L2wB+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45EFF8901A; Sun, 20 Oct 2024 06:33:16 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 075DB88DD1
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 06:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e4e481692so2886960b3a.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 21:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729398792; x=1730003592; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XLcC3Y3EK2wyMiF/S7+wXiLUWO1CIYkP5drVvTqFQgE=;
 b=I0L2wB+Rxzw8Z/rQVQiEDEEXMrnK3t26OR5nsfQKVz14m2mt5yDaD8quTXx8GTTAXT
 uNRNqopQ8EAllJNTDs9FeZ8xyqMnllpuh33KxhIh1VO9xDPc/hFhfBP2YfFWO34m/qSa
 76mxbBDoDd29Zgi3iot/5Rp59JS+sfKSN036HHRcKB1arEcR0IrMFEYHLxFdNd7KGmHu
 kgntpLPk9a5XbFbR6PQFttwBID7hnPqoedkIz9v72uxU+hXyZSaR16qTQk1lhWmCtQG4
 5VT0z4KE9thzHhUcF3js/3liy1diaMWuFMRiFCh/ikzbRV2KC90LIY87AxQUADMObqKH
 jtfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729398792; x=1730003592;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XLcC3Y3EK2wyMiF/S7+wXiLUWO1CIYkP5drVvTqFQgE=;
 b=wWiZI8EX/L5Y4ObKbgDBR+omYYIzFX3L53oYNaDwON7XWbaHlFMifctca3ZZ45LV4P
 tHY+6P4L4x93B0iweNezMkf0ilqu4ratT05NM5NmYbE7P8X1+p0GpnKZ34VaIm8Ms9B9
 PGbtZh1Ut8N6MRiEoPe79CBnw7pQDiamRKhYMMWehKvY+BqAVr0eFfanFYA8rMLAKH4t
 qNmEXey9IkM4HtN+lCAS2waCimKdlyQAAGL6dyUdyRfOX2zU4EahpjwDG9hrs7xhFUnX
 5xixuFwxDrYXbFFnLI0qjcghLbrI0+C1M0VTyP2qvVskXxYzYMUsjnAQ5RBuFVkD3zsD
 EJgg==
X-Gm-Message-State: AOJu0YyyB7jhDcWdCGwy8hQIE8j5xCf6/UUUA1x6jnT8SxQin8hDBPos
 7Yj7+uU0Cy2OlIneVLd7bDCi/PZ0FT8KEh3f81CKwRMGKziiX5kG/G6LSC0wOPEH18UWa1JkHhg
 n75rZ/JYb1KWfj3uzV/jdaJRfRpI+UAkUMN7HN8zL6Rs2XlTL/LU=
X-Google-Smtp-Source: AGHT+IGRkehU/yfazTZIiBj3U5Sgr2ZchK/82vc1MeqAoKBmHTpVRKKSX5K3Yek4pO3PDm0sCAdcCqaZR5Ls71OR2bU=
X-Received: by 2002:a05:6a21:70cb:b0:1d9:275b:4eed with SMTP id
 adf61e73a8af0-1d92c5b249amr9758142637.42.1729398792522; Sat, 19 Oct 2024
 21:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241019090356.25288-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241019090356.25288-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 20 Oct 2024 07:32:36 +0300
Message-ID: <CAC_iWjJo8A6J4nedS9wrm3q5CA4tUuda9RzFF7cv6b4XWyCY0A@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_selftest: make HII test data static
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

On Sat, 19 Oct 2024 at 12:04, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Variables that are only used locally in a module should not be exported.
>
> * Make the HII test data variables static.
> * Remove unused GUIDs.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_selftest/efi_selftest_hii_data.c | 28 ++++--------------------
>  1 file changed, 4 insertions(+), 24 deletions(-)
>
> diff --git a/lib/efi_selftest/efi_selftest_hii_data.c b/lib/efi_selftest/efi_selftest_hii_data.c
> index d19f0682afd..5fc890112b4 100644
> --- a/lib/efi_selftest/efi_selftest_hii_data.c
> +++ b/lib/efi_selftest/efi_selftest_hii_data.c
> @@ -39,7 +39,7 @@
>  /* HII keyboard layout */
>  #define EFI_NULL_MODIFIER              0x0000
>
> -u8 packagelist1[] = {
> +static u8 packagelist1[] = {
>         // EFI_HII_PACKAGE_LIST_HEADER, length = 20
>         // SimpleFont, Font, GUID, Form, String, Image, DevicePath,
>         // (74)        (110) 20    (8)   78      (67)   (8)
> @@ -262,7 +262,7 @@ u8 packagelist1[] = {
>         EFI_HII_PACKAGE_END
>  };
>
> -u8 packagelist2[] = {
> +static u8 packagelist2[] = {
>         // EFI_HII_PACKAGE_LIST_HEADER, length = 20
>         // SimpleFont, Font, GUID, KeyboardLayout, Form, End
>         // (74)        (122) 20    192             (8)   4
> @@ -424,30 +424,10 @@ u8 packagelist2[] = {
>         EFI_HII_PACKAGE_END                     // 1
>  };
>
> -efi_guid_t packagelist_guid1 =
> -       EFI_GUID(0x03abcd89, 0x03f4, 0x7044,
> -                0x81, 0xde, 0x99, 0xb1, 0x81, 0x20, 0xf7, 0x68);
> -
> -efi_guid_t packagelist_guid2 =
> -       EFI_GUID(0x8685ded3, 0x1bce, 0x43f3,
> -                0xa2, 0x0c, 0xa3, 0x06, 0xec, 0x69, 0x72, 0xdd);
> -
> -efi_guid_t kb_layout_guid11 =
> +static efi_guid_t kb_layout_guid11 =
>         EFI_GUID(0x8d40e495, 0xe2aa, 0x4c6f,
>                  0x89, 0x70, 0x68, 0x85, 0x09, 0xee, 0xc7, 0xd2);
>
> -efi_guid_t kb_layout_guid12 =
> -       EFI_GUID(0x2ae60b3e, 0xb9d6, 0x49d8,
> -                0x9a, 0x16, 0xc2, 0x48, 0xf1, 0xeb, 0xa8, 0xdb);
> -
> -efi_guid_t kb_layout_guid21 =
> -       EFI_GUID(0xe0f56a1f, 0xdf6b, 0x4a7e,
> -                0xa3, 0x9a, 0xe7, 0xa5, 0x19, 0x15, 0x45, 0xd6);
> -
> -efi_guid_t kb_layout_guid22 =
> -       EFI_GUID(0x47be6ac9, 0x54cc, 0x46f9,
> -                0xa2, 0x62, 0xd5, 0x3b, 0x25, 0x6a, 0x0c, 0x34);
> -
> -efi_guid_t package_guid =
> +static efi_guid_t package_guid =
>         EFI_GUID(0x0387c95a, 0xd703, 0x2346,
>                  0xb2, 0xab, 0xd0, 0xc7, 0xdd, 0x90, 0x44, 0xf8);
> --
> 2.45.2
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
