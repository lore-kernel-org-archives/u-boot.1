Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD02C43327
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2940E84BC1;
	Wed,  1 Jul 2026 13:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E+19SmQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84F1084BED; Wed,  1 Jul 2026 13:59:52 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B186841F2
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c1268f71572so235386166b.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 04:59:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782907190; cv=none;
 d=google.com; s=arc-20260327;
 b=DlHJ+R9cxxyRnG++bR8TQUwFkjAVb1TWAxKzH3vwxrBouZhpfY3m9FMtnhaZZk+JuY
 qnnAOIMeaNN16itkF+Y74JIDrU92h8C2ddmduTNIryud8EcdiMg7TQr2N9ubpd9wPZtc
 QqB3h/uUNCzokxLnen+7d1xcl0P4P79wyfGPbSkQ7bnf833JEA7e8ib/5lN6CBmJk0s6
 HQPLbFgqUmOYofwuLzC67IRrX2B+HlH7o23CxryuEnIjKpltaKdEHoEivJo9lDxSJE/x
 HoOZnpwCILuxaXf2+9Li1JE+bJ35ZJgfcBMMrJES1d6ATc6x1Xt0XzhHwbjnx8HuNVhq
 y/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5zKBi5hPjDZUWWJBKXD2+rJ2k87M2Dd1RbheBHuW5UM=;
 fh=4o/sjNsMS2231QpXbZGbAxA2QULENnKU2WMW02OUdEk=;
 b=CJcZ+aLfpUHyArOuJEsrLmJbsqbzyBA/yOF/zxX3UfljmcKJRTx0TlVx7pjOA7WY7W
 vHbloH3ZaijF0JIQdj23XRMmNA8qGlRnIuZxbvUTVwUwukdqzL7RFVFC8IKAwEyZAA1v
 EQBOXwTCNX0dtj4lN2xt4jhsrEG1XQV9V7p93pIILun19ElR46HHc3e+JXvFxaLNLj3w
 g16BKNIcmZkzfoe7JkoA2/R/zV6kMmG1OKq1hPYO90Cr2mt28mGsODOOx2rUVl2Ea23F
 +/iS4XGdcCTvZ8MuTm6k1gN9d1V2/9FarvxsQi+bLkEt58N0rmEx3BF+bp1ZziwXdqSp
 xlrg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782907190; x=1783511990; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5zKBi5hPjDZUWWJBKXD2+rJ2k87M2Dd1RbheBHuW5UM=;
 b=E+19SmQcrZQgZlCGjB1aj2qivlYFRPYM9RqvCD5GfZH6EHtT+0ZCxDfZ3I5wVj0dSh
 68LmcNZgUnTeKtMpAjsGf5Jq3U6tiEWHtYZNm1NUmRYvoywjSHBrC85mLNCSym2u34L6
 ueAzG4gzOamR6kgGPRdCHzXz2thrxxFs+hNJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782907190; x=1783511990;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5zKBi5hPjDZUWWJBKXD2+rJ2k87M2Dd1RbheBHuW5UM=;
 b=kMlcBaXcdU9e6S4sz8oltef9fcrX1U7/8m/6Ge54WreqjICgd3l9TX506mGf1XLQTo
 Eao2Vb0gTUNTScvgPvTD7vMJNimemYiE6hpKQEB2cTss6YbuqhqK4BQdHAyzmg04SToG
 3zXNd4J1t4SLX4DCS5mN6Y+mhIcOE0KougNZJ+yb3zmhmJ/QiJ0mHo0pqi9y0w1BGtv/
 B0zRotpsj4uv1B7grV683KSs/02wa5Uva8Og0PzCj6lED20qBMblNOOSdmJkVqJ6+lOK
 ZB8MLltfOiVnjHPmseIj/98b1cw52WrTjqdJ5dftLEuMfBY0XYVcUPYSe/qOIKhm2V8H
 ocZg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrFajJGSGPZLBwSCuEcvbAfUELvPTExc6QdwG44noTvVzZmZODG7lBqL5r9ycllpOmSFvJsnho=@lists.denx.de
X-Gm-Message-State: AOJu0YwZcRQ4MrFXsgbu6JeXg86cH8c/FC6L/toI1DoTxvnZeEttLU0Z
 mHcUyKJVYi0hgWXzrlZ1d5M4Dexsk53iYG/Yr8M5/69u49G5IOiVp2PJHOdpGVl+7TgKZ5JMYSq
 e7AZjAQhebjFOkKufymATawcgu+zHJpZiFC18O0N1
X-Gm-Gg: AfdE7ckCvM7xkBRAMaIHskCUeZ2WAVUseM5oHJ1HKGn5+8TnXDNwr5p2vu0fsI+zbP9
 YpQftWI4nTDQdWs6WC3XqRMot1gdDDjQ0kf6w1LfC3icB1MvoY+9h1XKLGCShMmaCyCXZjRUu+b
 2FHy8Ea/S1Q9jSj1hPuHAkBYMUZ9fwT4WQsXRT1Ee0c8ZDlxbp8LYDBa7KGS8Dte1vApXP34inJ
 nuQCH+0q0t/GSwEXso/aqdj3dG/Y3Pd7AADO0jcG01hNGhpy6+mCPp2lrjEpqmFAl3C+qOJlQ==
X-Received: by 2002:a17:907:c786:b0:c12:a4b0:3c6b with SMTP id
 a640c23a62f3a-c12a4b04f0emr67237466b.16.1782907190014; Wed, 01 Jul 2026
 04:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
 <20260628082810.175862-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260628082810.175862-6-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Jul 2026 12:59:38 +0100
X-Gm-Features: AVVi8CdhTB_P0sEBhH7E4lYJOa7zZ1vy6k_sO9ZGZwzaTyXIQPi_769_eP0njMk
Message-ID: <CAFLszTgp2UBFdhGu8Gn8n_F0us_7FCSM-xzcTLebn8Hvo_WLxQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] efi_loader: add efi_app_common skeleton
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 u-boot@lists.denx.de
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

On 2026-06-28T08:27:58, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> efi_loader: add efi_app_common skeleton
>
> The EFI dump applications (acpidump, dbginfodump, dtbdump, initrddump,
> smbiosdump) each contain duplicate copies of the same output and
> input helpers, and each has its own command loop. This patch series
> deduplicates that code by introducing a shared module.
>
> Create lib/efi_loader/efi_app_common.c and efi_app_common.h to hold
> utilities shared across the EFI dump applications.
>
> This first patch adds the module skeleton:
>
> * State variables (app_handle, cout, bs, nocolor, systable) owned by
>   the common module. (Removing bs, handle, systable duplication in
>   the apps is left to a later patch.)
> * efi_app_init() to initialize them from sys_table and image_handle,
>   including detecting the 'nocolor' load option via get_load_options()
>   and starts_with().
> * Output helpers: print(), printx(), color(), cls(), error().
> * starts_with() - test whether a UTF-16 string begins with a keyword.
> [...]
>
> lib/efi_loader/Makefile         |  13 +++-
>  lib/efi_loader/dbginfodump.c    |  43 +------------
>  lib/efi_loader/dtbdump.c        | 133 ++--------------------------------------
>  lib/efi_loader/efi_app_common.c | 106 ++++++++++++++++++++++++++++++++
>  lib/efi_loader/efi_app_common.h |  67 ++++++++++++++++++++
>  lib/efi_loader/initrddump.c     | 126 +------------------------------------
>  lib/efi_loader/smbiosdump.c     | 100 +-----------------------------
>  7 files changed, 196 insertions(+), 392 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
