Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C940FF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 14:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CABC8465A;
	Tue, 28 Apr 2026 16:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R+tFHoOa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0CA88460E; Tue, 28 Apr 2026 16:04:45 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D79A6843D4
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 16:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-677f7c29af6so10719915a12.2
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:04:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777385081; cv=none;
 d=google.com; s=arc-20240605;
 b=S1kKezIYrAQqENhCYS6yDl7UnMDTNsF0kPXvRAW8Tj9pp7i7BZD03d64QphgWIArzA
 m1k+MoDojHt/YDG7geGlFGaM15mzLa3FKQbul61kOu5sRyX2aLUxDxdeyntqj+R93XDI
 3LATVjPJkeePTRStKn9SeG5i4+tzyl+nFYvVgH64DLQpPvKhiLfkSWuqyr049i/3gbjf
 HU/xYDz+chShDWBTPPSVOYqNLTjGe0ni/gv+do/cx+BKTFk+qfulgjyHXHxVnC+ekwbm
 HIq8TaqydhvTPUQZWsXsjSO1F7WtnCdFiGd2Dsevx4uBggsw6aMdrXNGyyMLnnWXQFYR
 fzDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FjuYkhITCL/kSoUaSirhGfSup+lkGLOV/vmzQrv/EXE=;
 fh=XP2h25/gQwfMzCrfZPYc73r820MXAKKELZcSVdCmGr8=;
 b=jzMdmARLUS+SLq76D4Kbmg+3wNpAjEmVvIWZaNFgOIggFxZ7FmZpai5Fk5KKCmVyUI
 /zf7SQRM9bViBfZtqqe+Sl9QMJZ/uUmvqpJMtGvvnX7lmSbweMwyeJmUWNtz9VgaXN9O
 pbDYKHXgbXdbmbbA6yDRrtH1YXGlneJXvPrkeBjBKxvLPkaMVp/MXxavXlNuvb043Cpz
 cNy63idZvz4xFJBlwtVlxw8sz5vR08PEpdL912gSqprC8qYzJ9dJnN1p4fqotqYML2gr
 3zhtoqo07GEEvh0f9vfAfTXhB6R8D9gr9/CbG+Xu1w13Y1aiVnfwk3CvvVUZRFguNsec
 aoNQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777385081; x=1777989881; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FjuYkhITCL/kSoUaSirhGfSup+lkGLOV/vmzQrv/EXE=;
 b=R+tFHoOaJ2SCjDl+bT2lrh+/gk8VoK0gFoYDBOtq5cyb0Fde2rP8OQJsK5nxYRrZQO
 VDXdKfBl72HD5Gv3UpfhLv4EsJBSsF244EmNErXSg+dr8Z5VFut3Mz+6NfJqBPGV/bep
 4YlBTvLSy5aUxEFND8sJ/82sVur5hyMNHiQ4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777385081; x=1777989881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FjuYkhITCL/kSoUaSirhGfSup+lkGLOV/vmzQrv/EXE=;
 b=RNz9Tm+27hYZc6bm3lPy94BiRhU9U45GSEdOnCP/xZDdy88omQ/kqrfjNhlRm23tJS
 q1KNAJ+PkrBkRFy2AAx44vA7zn4+RvAC6JLVAyL/diHodD33EMWQGDWZRAJNk3yCCGEG
 t4IGaG7do0pZnY4DKboxBMN7ZPrj6wkV9i3wRFPwVYSqLFpr7s7OBnSWd8VkBfIizCqJ
 WA0yWXNGl31yS49bVzwgIhPQ/FjHaGMvwrDN3qkXXYxdXBddRfzmzAmja4rowwoc3gam
 oMhwg1HRqI+iSzfFb4FeggdxxaKN2l5WqylLa+976k9cgT2zW4eos2iwQ9r0y//vsszU
 BCrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nTY/1AORXDuUoVVUR0eoeik40cisGAS/mRsfd4i3CJOu57PaD5NZ8oXaZwdU7wG0FCBv569k=@lists.denx.de
X-Gm-Message-State: AOJu0Yzs8qI+7F+aym2QtheO228idf14JGVsHNhrnT7q2YZyPkh2ACcy
 LXovvWj7zoMO93FtybN2LJQhJaOZ5u50ek62JKFznCr9no/DHvnYg6hvhYZV5SHOZO9OqfWlXbe
 o5CwZhOtFkZFpnXBzrXof0YimFqTimymsUU5iyHcDVPAMc3xiS1nmsw==
X-Gm-Gg: AeBDiesO99GuFXBGjz7OtInMdpxMJ5ihrBsSLlRoaCZd0ifVqigWVv/01URM6WA70zn
 60k9VOmXD4cRzK2z7u2l3RrMhNRJgREuzfEq+zEU8IBUaFCUrYrqG7xxdUK8JH39rc0pkCc2Xsx
 5bOq4kU00oJVXlsQrurHPZSpzPujt3i883PH0UqT7s1ivGhb5B1FG5J5wDKoccTZ1aw+VA4+u3g
 eUThcYB8ApWT4sv4fC+eW9R5VL7OW4IMggsnH+r3wrLSgdYIcr7RdfJmeSPdM6YVG3+vbKnkFDl
 D0rjhvhfLIBy+K3X
X-Received: by 2002:a17:907:3d89:b0:bb8:a648:f2df with SMTP id
 a640c23a62f3a-bb8a648f5cfmr118894566b.18.1777385081178; Tue, 28 Apr 2026
 07:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260424125514.274350-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260424125514.274350-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 08:04:26 -0600
X-Gm-Features: AVHnY4LGkoltNb6UX61TKsV8_L4CTCAo3TTk946WThZx4vZokGCpBEs9Phkan-M
Message-ID: <CAFLszThw-d0FFnfKYe-nvoBg9Dn0iFbKVBU-7HmQy4_9MkzpJg@mail.gmail.com>
Subject: Re: [PATCH 1/1] .clang-format: add U-Boot specific for each macros
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Javier Tia <floss@jetm.me>,
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

Hi Heinrich,

On 2026-04-24T12:55:14, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> .clang-format: add U-Boot specific for each macros
>
> Formatting via clang-format is controlled by .clang-format.
> For each statements should be formatted with a brace at the line end:
>
>     for_for_each() {
>     }
>
> This requires clang-format to know that the symbol is not a function
> but a for each macro. We use some for each macros which don't exist in
> Linux. Add these to file .clang-format.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> .clang-format | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

See below

> diff --git a/.clang-format b/.clang-format
> @@ -748,6 +748,19 @@ ForEachMacros:
> +  # U-Boot specific
> +  - 'alist_for_each'
> +  - 'alist_for_each_filter'
> +  - 'for_each_bl_params_node'
> +  - 'ofnode_for_each_prop'
> +  - 'ofnode_for_each_subnode'
> +  - 'ofnode_for_each_compatible_node'
> +  - 'dev_for_each_subnode'
> +  - 'dev_for_each_property'
> +  - 'fdt_for_each_node_by_compatible'
> +  - 'for_each_console_dev'
> +  - 'mtd_for_each_device'
> +  - 'for_each_tpm_device'

Please can you sort these alphabetically? The comment at line 67
documents that the upstream list is generated with 'LC_ALL=3DC sort -u',
so following the same convention keeps the file easy to update and
scan.

Also, the list is missing quite a few U-Boot specific macros. Running
the same recipe against U-Boot's tree turns up at least:

    _for_each_zynqmp_part
    for_each_bin_hdr_v0
    for_each_ext_hdr_v0
    for_each_opt_hdr_v1
    for_each_zynqmp_image
    for_each_zynqmp_part
    for_each_zynqmp_part_in_image

=E2=80=A6plus several more under drivers/ - e.g. for_each_w1_device,
for_each_slave, for_each_supported_width...

The recipe at the top of the section already says 'include/ tools/',
so could you widen it to the whole tree and regenerate, or at least
extend the comment to document how the U-Boot list was produced? What
do you think?

Regards,
Simon
