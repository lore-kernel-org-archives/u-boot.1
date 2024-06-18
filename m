Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C027C2BA15
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 09:17:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A579588431;
	Tue, 18 Jun 2024 11:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jiGsoR/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51BA288468; Tue, 18 Jun 2024 11:17:40 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C6FD881DB
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 11:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-6e7b121be30so3665827a12.1
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718702256; x=1719307056; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tYgg2gyjmCgxFUyWs9ZU7oU42rAGD1+d4fgdnRXL81g=;
 b=jiGsoR/WUQNw5bsZ4F959WGq2lhKwVLit1KGsqniBkm6vgW6ZZjKbBgPQSJdCnWFtJ
 tXGOQB+TGlVHOmvS6EozYb0yFkpGRApVkT+V7DC+DoK8P4EYHSY6N3n5U7lRI9oBDXtH
 6rGgORyfLQOsOAuDiyJ3j2/cnCMmJa+GW2kwL30DOA2tAzvlcDEJ1UT5WSVGkO5R0hvo
 +cXdA5gK0grUL9gb68QLjP6C911tGkdbGq14HuYzPimvGddSRBDia0Gu0cYp56ZghZMi
 vK+bjvN96Tj4uBC2BP5YnNdWN065oRHvELOJZLGXC4o8G573+tHDkSZ6JevXItc4CeVp
 j8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718702256; x=1719307056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tYgg2gyjmCgxFUyWs9ZU7oU42rAGD1+d4fgdnRXL81g=;
 b=gqn1b3T9VXs18yUhVvZQOKp/1xuga5feIOydmc6weAvlCyrILffJwdHMP9kYSXLfxd
 x/VH280106syP9aS2lidDuz9hfKTfSynuYwigSS7Nw65lUQclgnuqESlp56GJDjQppPj
 2KFskQMk4m75Fe7sI+MeM7SVIyOvbXyj/3Ag7fBgR+jlNVRDEH0AcgiCRNhvBitIM+pU
 IAlShiWprm/S+OGw3fQrjGH3EHtitMq0hzQ7JCEUhuIL2VIjiC1m4TAo8ZyzYgj9yfUp
 Ep7DIB2J0aIdQZxCd5pn99FT3OuTyTapnag+ux/MmWfCPrBEmkPkM0CFCP+hmDO08glv
 2c0Q==
X-Gm-Message-State: AOJu0Yz0HAaNYD/Jc0LNoRo4Gh+neYpOBOYElCfq/ZepSReB01sTmScP
 fVlZo1g3HwJ+G9I2ZZBso/ZW5JGZq+i6y6yek17+Kru19RYiNasD5LANcnyj6Fz3tz3GJaoR4V+
 lSq0NnbWKAGkggVfVl2qk5WGsFB+TQh9E+MyDSiUb3D4sY8yLDA1fDQ==
X-Google-Smtp-Source: AGHT+IF/yEWyhYLIZ2nC7PqfY0TSrF/yJxflj2fPKWC8vGwVo3fmzUQhdNltzAIOLIhNJ+dgKd8UoaSS/5H/McPAIfM=
X-Received: by 2002:a17:90a:3008:b0:2c4:ec56:35e9 with SMTP id
 98e67ed59e1d1-2c4ec563bb6mr8642927a91.2.1718702256495; Tue, 18 Jun 2024
 02:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240618061644.11677-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240618061644.11677-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 18 Jun 2024 12:16:59 +0300
Message-ID: <CAC_iWjJyCEJ8yWJOC-_Gc6n7SDJbNNQ3RyEeh8TpvPGvHCDBGA@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: FIT links in develop/uefi/uefi.rst
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

On Tue, 18 Jun 2024 at 09:16, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Correct the links to the FIT documentation.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/develop/uefi/uefi.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index 0389b269c01..ea70dcbda86 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -72,7 +72,7 @@ bootm command. This feature is available if U-Boot is configured with::
>
>      CONFIG_BOOTM_EFI=y
>
> -A sample configuration is provided as file doc/uImage.FIT/uefi.its.
> +A sample configuration is provided in :doc:`../../usage/fit/uefi`.
>
>  Below you find the output of an example session starting GRUB::
>
> @@ -96,7 +96,7 @@ Below you find the output of an example session starting GRUB::
>      ## Transferring control to EFI (at address 404000d0) ...
>      Welcome to GRUB!
>
> -See doc/uImage.FIT/howto.txt for an introduction to FIT images.
> +See :doc:`../../usage/fit/howto` for an introduction to FIT images.
>
>  Configuring UEFI secure boot
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
