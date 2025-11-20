Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F075BCF9C46
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 16:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DCC7840AB;
	Thu, 20 Nov 2025 17:13:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W8bMPUmM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19DE6840E6; Thu, 20 Nov 2025 17:13:57 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2817E83A6A
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 17:13:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477a219db05so7376505e9.2
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 08:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763655234; x=1764260034; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qkDbSFzG2WPj1Dg3HATukJ6ojLumhKws+3o3xkH8dYY=;
 b=W8bMPUmMrdX/cYc35YYFYUaVikWV54soCSFBOwR7ox8Oi2rCtBG37s/2mGrH1fXKR5
 SCs0RdyrYrunp/MO54QJS4VewEUCQSDk8yAFAku8UaETnT6RMO0kl6wWDSjAtFNBI5ZL
 EJZ0pyRkfEAoOH/zv7tAdNfqU1VzATe56rwPxSqIYdr3/CV+vVtvo8ZGA0csz6NhH3Gi
 RbWnamvef+8k+nUJv7b6sNnsHRSfMNlPd3gq0XUyRiG/0eFKlDoW9tENkGTxJeAQHA4A
 QVZoIbFDicX78XKk6NLWLtnPXXM41jiMZ4k/tj4Z7mKu/EdvD7gZGULRaZzBT2YYY9EN
 NXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763655234; x=1764260034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qkDbSFzG2WPj1Dg3HATukJ6ojLumhKws+3o3xkH8dYY=;
 b=evXtCJNYx9L6UMTL8cFwenQ28BsNOxm4DqMfOH+nkYVVnSv7ZzC02giZyikwPXOYO+
 txM0cXLZtHkW6ZY9GiFnYvEa692rz/STe4F14zxJG5fb+A6ewOZiAfJUbFU80hEPOm2g
 2UonWWwFhMcr7gYDGLs5p8gjkjNaBb0xcA5q9qxWSUNYJV7ZtocxkK1Snsg7CPXE6R1+
 Rs9U/hhub+9CIX9fAnYKjen7Su4WIOGqX7vcU87lxJeYhaf8/jDDEAPFvviF4uYuR/1m
 5nW5cDeGS/qaeKfvnyGM6LjXkdAhNIaqeKsZLDGlCq0A9ijjynGiI94jHzIrF08cfAKK
 /o2w==
X-Gm-Message-State: AOJu0YwGCtfe/4TVr9vRf2GKPMQGPfEag6GKjfTZTSW0LdmVow66J99n
 RQpz7oEqoIXX/Cs8SKkjQOzc/f8jRgbke4I24iT1aXMf9biCGRQ81XhpnXAhkeSUdoFfjkiwbtn
 E1AOlT7Kd4g/BBe98sDldNIqfwCMV5ds=
X-Gm-Gg: ASbGnct0cTw2ZL85CKrdd8TQCj/VLIec3GkboawaUpC0VMILVZsdGEJs07gQ5d2PXam
 oCJ+wOZW73oWq3I7gWADNhKDVzYXSgJN0dov9/3U7vNDU5IKfaPQZt3VfYJQVOai4j2ZHGOfO+Z
 m5Zbwlq7h4mMS+BCHDTATu+nyuDGM7xMBFbRZYcGAAVVEBPOXgG+4yWheNkvsX09WmxV3tLM1Yd
 I0E66133lbGxVzr7YU4CyFJ1i73Umm/dGy/eXdA4cQayLXL2prFUS38cuOzsg+gW+RjjUEH
X-Google-Smtp-Source: AGHT+IFaWorprZZAAB6ibUAidpF6Zxir/NqXLZ3BVUPJ9ra9Ufl88jLE0wKninN67QKf59UvafPYemP9UxjcSbC2nqg=
X-Received: by 2002:a05:600c:4694:b0:477:952d:fc11 with SMTP id
 5b1f17b1804b1-477b8a8eb4bmr46648985e9.16.1763655234275; Thu, 20 Nov 2025
 08:13:54 -0800 (PST)
MIME-Version: 1.0
References: <20251119145540.843448-1-trini@konsulko.com>
In-Reply-To: <20251119145540.843448-1-trini@konsulko.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 20 Nov 2025 18:13:43 +0200
X-Gm-Features: AWmQ_bkUiswYkXReM5FrWkKBU-QNCgqP8DHOvGCwoUO0MjYpcttlIxF6ZgRXnmw
Message-ID: <CAPVz0n1wXCZpy0Ngvr60EdiNLeBP42s8Coyo5ujFO+cwV+ZwUA@mail.gmail.com>
Subject: Re: [PATCH] tegra: Stop disabling device tree relocation
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Thierry Reding <treding@nvidia.com>
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

=D1=81=D1=80, 19 =D0=BB=D0=B8=D1=81=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:5=
5 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from correcting
> problems such as having an unaligned device tree and leads to various
> failure modes in the OS.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> If there is some window of memory that must be used for where the device
> tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
> or bootm_mapsize are the correct way do this. Please see
> doc/usage/environment.rst for more details.
>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> ---
>  include/configs/tegra-common-post.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/include/configs/tegra-common-post.h b/include/configs/tegra-=
common-post.h
> index 2f08dfed020f..a9c0cea4e149 100644
> --- a/include/configs/tegra-common-post.h
> +++ b/include/configs/tegra-common-post.h
> @@ -50,17 +50,14 @@
>  #endif
>
>  #ifdef CONFIG_ARM64
> -#define FDT_HIGH "ffffffffffffffff"
>  #define INITRD_HIGH "ffffffffffffffff"
>  #else
> -#define FDT_HIGH "ffffffff"
>  #define INITRD_HIGH "ffffffff"
>  #endif
>
>  #define CFG_EXTRA_ENV_SETTINGS \
>         TEGRA_DEVICE_SETTINGS \
>         MEM_LAYOUT_ENV_SETTINGS \
> -       "fdt_high=3D" FDT_HIGH "\0" \
>         "initrd_high=3D" INITRD_HIGH "\0" \
>         "boot_targets=3D" BOOT_TARGETS "\0" \
>         BOARD_EXTRA_ENV_SETTINGS
> --
> 2.43.0
>

Thank you! Overall change seems to be valid and should not break
anything. Unfortunately, ATM I have some major technical difficulties
with testing and PC access overall. I try to find an opportunity to
test and verify it ASAP. Would you mind if I include note after ---
into commit message? (no additional actions needed from you).

Best regards,
Svyatoslav R.
