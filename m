Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12558C83F0F
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 11:19:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BFDC83280;
	Tue,  8 Jul 2025 13:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ae7i8J6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93A0C83285; Tue,  8 Jul 2025 13:19:00 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B3E3830B4
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 13:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e8275f110c6so2917592276.2
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 04:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751973537; x=1752578337; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hQ+bMzAtpU3KAhDzFRe6T1oCI63OMK549JF30XTHZuo=;
 b=ae7i8J6eNAwWgF8B4O+Ddtu/Gf8jRfe6ixEGlIAdIXyT0X8/cdUeKH8G5OGkWuFc8n
 bT1Kmgw55Emae0sZfCOfopIZE6h0wZWq20KXh10AyLtrjBbMgp+8cuGJEZ5yyvzyWEcC
 7h0Wu31KyLaVeEctf7tOCClh5y13Pwb/e0uoWv+GQcD5gnrM+N0ZeWUX2hgRYSIZV0AS
 fMJrba7FyMobxrg7acSPu/fhe/QpDMnXCmhOaVVvyYDc2+5gWEvWuC+mRDyRYE4xVpQR
 pstjOEboBGdBXEzIxVkLKk2ez2au98RfqgpRRoHNzMi3pOhanp3wn2dKSEHvpnTnUZUh
 rhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751973537; x=1752578337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hQ+bMzAtpU3KAhDzFRe6T1oCI63OMK549JF30XTHZuo=;
 b=Pe6LD02fnmMZ2Gm5ZS5xxHH7aYqD9OLFsO0n4j+envDIBRkHh2yS2N4d5K3N8TN5Qn
 eU5Og1hVwqIpQz6qSitMlj4muWEzaimocWpUh3NXibrG+qMLY8zSbPw3P/FRbNHxfM/Q
 6pTUvSiOYiMqnxfyGZ8t7ys9n1MBu21cBdIGIKgPqEZi1b5pett3SD9Y6dj2uh+I+lXf
 bbIgsUyjFSjKi+mq283+KsTWc1HQRZXVjkhCxnEU+7k+jxYvDinEWJJ/JlLr+7Om4oiF
 dZUts4s4gXqYY1VhXDaet2aZLBFdajqgPr2CwTEAl/8QG7GABaBRoDRj3zY+GwTGi1Ph
 /sXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL0O/UHNCRJMhDwT9oS6itWVZEXIUYgoXN+Ig3T0RY9uv1UyXArWZ/2HPRXnuD6b3m3FhxTb8=@lists.denx.de
X-Gm-Message-State: AOJu0Ywo+3lwJsq1O0kzkkQbejz7hir+mFzGGoI9ObYhCCHMcY/rn8Vz
 4pLrTh2wZTS5SEMVO/ew5NL3bgSF4wWgR8qeRB7wpW/bAz1EZGHd4XTfsWujxvNpW1dmOSI4z6M
 K5ygLDicSxHvGDWOGMODL4hNgZJKyAklE2e5GO3ogZQ==
X-Gm-Gg: ASbGnctUKmwFuUOvOq79fnGRES4bZjNc8QiqyCBQLF9xco5Ly+x7OBHxNGtkcX2+ZLl
 s42tK+SkPdZtyb1C41ZWdb1gXJl2aAJXDEkhW3odLFVnenFAEc2cWOfjLC1P5Anuay0XL2CEixD
 z/nkpVxSKIVJn26n6Xy5As5hzvnie4AJ86j+sRmeX+NFCT+FuHWR8TDA==
X-Google-Smtp-Source: AGHT+IFfsF0R/QoKgCd7qog88is0qL+LjglhvMBhTbm7L2pKddAyj1OX4ST2YXuPxGwINtq3gIRO+KKhGHirErMUJKs=
X-Received: by 2002:a05:690c:6c86:b0:70f:83af:7dab with SMTP id
 00721157ae682-71668c0ed43mr220804307b3.4.1751973537327; Tue, 08 Jul 2025
 04:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250708111435.40515-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250708111435.40515-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 8 Jul 2025 14:18:21 +0300
X-Gm-Features: Ac12FXyszmOWL3UgtfVCEtcdcQ1NydRx_6ZcYBTGLafG58Cwj_RnElDbVKTldS0
Message-ID: <CAC_iWjJp+=j+MKycp=FhCXMMoGW3QduAjR9pBQBnh15JG0UgNQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: correct EFI_DEBUG_TABLE_ENTRY_SIZE
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ying-Chun Liu <paul.liu@linaro.org>, u-boot@lists.denx.de
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

Thanks Heinrich

On Tue, 8 Jul 2025 at 14:14, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> With the current code we allocate to little memory when adding entries to
> the EFI_DEBUG_INFO_TABLE and we fail to correctly move entries when an
> entry is removed.
>
> EFI_DEBUG_TABLE_ENTRY_SIZE must be the size of an entry in the
> EFI_DEBUG_INFO_TABLE, not the size of a pointer.
>
> Fixes: 146546138af5 ("efi: add EFI_DEBUG_IMAGE_INFO for debug")
> Addresses-Coverity-ID: CID 569498: Code maintainability issues (SIZEOF_MISMATCH)
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_loader/efi_debug_support.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_debug_support.c b/lib/efi_loader/efi_debug_support.c
> index 186bdbce750..490b0bb7088 100644
> --- a/lib/efi_loader/efi_debug_support.c
> +++ b/lib/efi_loader/efi_debug_support.c
> @@ -22,7 +22,7 @@ struct efi_debug_image_info_table_header efi_m_debug_info_table_header = {
>   */
>  static u32 efi_m_max_table_entries;
>
> -#define EFI_DEBUG_TABLE_ENTRY_SIZE  (sizeof(union efi_debug_image_info *))
> +#define EFI_DEBUG_TABLE_ENTRY_SIZE  (sizeof(union efi_debug_image_info))
>
>  /**
>   * efi_initialize_system_table_pointer() - Initialize system table pointer
> --
> 2.48.1
>
