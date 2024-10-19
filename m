Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2383FD3C90B
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 11:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB2BD88B23;
	Sat, 19 Oct 2024 13:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FqX3p4mc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 307BF88EFD; Sat, 19 Oct 2024 13:49:57 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 048D687D1A
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 13:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b14554468fso229613985a.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 04:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729338594; x=1729943394; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=izGyyucTgWtMZPZAThPkt33xH34lCf2K+d0lgYFYwfo=;
 b=FqX3p4mcGKPsz37eZdLLsjZFlQS+dp0CoISbMd99r2D8xAZOXRi9WEtkfQZND5cNxA
 rSMA8eX6mbiKSQ0UhC+8H+jIvjBHR0lcJ4g9Tr76JSioKARJvc7DCjjd+VIuIQV+T6gQ
 euktlEgvBH9lckesjLBDYtbYcSJd+AGhHNw10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729338594; x=1729943394;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=izGyyucTgWtMZPZAThPkt33xH34lCf2K+d0lgYFYwfo=;
 b=cKkOkAypXMWYPJiqnjGOFeU0ns/FtLjHe+SSLSs6Q2L4G5xURvgFFfCh0HCpUXuNLZ
 dmssWbC8evgbxVnza2b020m2VKZ37ql+G7d/oHsLsTCCPtfrEsFJyS7OseWbEjcxSFMf
 OWlUG7tILoeUTotbdlR8u4HM8NDhNEHykcScpr2oXaUsey+jEdpuAtG9nGEszodcSAW1
 S676LUJyYgPk/DAA8yaYy0TI1P/Rr8zmRk9v2aXw5Ltdj2aX6SiPge8aw5l06fCwPYmu
 5mmeu2bL+7SKemZ3zZFoxO0zIU9uUY4k68UbNj0hVQppb/3SznArA1uVEHOYbdbAIx23
 GwlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmqbUGTpVhg0VKIo5Wq95wYjM5xsBHL3n05SZGMxoXFaBrG/0R6oXfQsWuvQJbIaYN1IFn2Lo=@lists.denx.de
X-Gm-Message-State: AOJu0Yyt5SdTyIlvNpEIPX1Bt7rzNN/8166FXNJcHhQkxCjLCsgzkgHc
 g4x4UV+PCziCGgu+TmhwA8GrMJT1ytffO9d6ZcRadpAAysOgkmnvjK1NcZA4h8YZk+VonUEwDVV
 tmbwRnDmxuOfeilSHVFaWFFAEyPuz3xD/4P/5MD+BH53H2rM=
X-Google-Smtp-Source: AGHT+IEPvTLPjsP5DFCn8iPXDrIzColbv3asnIq8WgJBsdCNbQq8QVV1m9yMu97S7Uj6dkPxLtDUNM1kikNy3oIyqmw=
X-Received: by 2002:a05:620a:2492:b0:7af:cdd7:d6e5 with SMTP id
 af79cd13be357-7b157b43481mr734974385a.5.1729338593908; Sat, 19 Oct 2024
 04:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241019090356.25288-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241019090356.25288-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 19 Oct 2024 05:49:43 -0600
Message-ID: <CAFLszTgG8eDTXSu9XA8hWMw_tw=mECC=fudbr1xgXQiW3QRM5g@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_selftest: make HII test data static
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Sat, 19 Oct 2024 at 03:04, Heinrich Schuchardt
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

Reviewed-by: Simon Glass <sjg@chromium.org>


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
