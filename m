Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A38C61DD6
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 15:13:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 806404072F;
	Sat, 29 Aug 2026 15:13:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C3UiTdnW1hvV; Sat, 29 Aug 2026 15:13:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788016424;
	bh=4mCrfb6tHdZvGXQSuo0SFJhy/sy04AKWjQJYvZGCoX4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xVSeJa7A7+G1xe/D7gskqN2u1la5/vATJ/TJBltaOgi0BW2Ucyj754vayXKu2pe2X
	 I6ulCnJKuxk1nmDcZT70z3rC+RWzIFTkoL5zKxGm32aQSeWp0DgZNvX6sWqrZtX32s
	 ibv4YTwaj6J7eMi7HTJMeoL4HjSN2ICJsFBVkuEVF0br+siirJlRD3tupdBp7aa4B6
	 N0uJ7tZrg8xL18ZLhFLXTHD+qz3PRhfNAJNF10+mahY3d8KCaqFaV4t1eswkbQRKFi
	 rGcLLCim/0jvqwD/g1I6aGtxdgsj3OE26tS2Pb7hlB9MWigeAmWS9kkwDbNU7QXbP3
	 4XPx/3jPWDIAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8190A406E2;
	Sat, 29 Aug 2026 15:13:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FA9314F
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 15:13:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4180240068
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 15:13:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nAfkNPVZUHi9 for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 15:13:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com;
 envelope-from=clamor95@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=T31oDnJU
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9EF3D40052
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 15:13:40 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2ce98cb8165so20286115ad.1
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 08:13:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788016420; cv=none;
 d=google.com; s=arc-20260327;
 b=bnkw9FuZtUQxcs7hFWcWppkCwQBrHojLiCQJJQU48FJQtyGGPEDxdtbIYut9SiwhQW
 YfhwIXezNtOtKaJCxJ311UxtkpCrYjFMtN9ig6Vr0WyTmqtu9VQJ/jaaSEIazsZN8Tvs
 L3jDU3+ChVMDVRK+XHSiITcYSfbyqKkCnPuuGRN1cgmdn9W9GzXNG9U41iihg5nviH+a
 1geDeTGFWoYYpHUyHxZYIK5eoDU10WEKDrJk6pVI578+0EgvAHjvGVA5ysbqJnWbII9N
 +euY1LDDfz+a4k+/L6AfXik2E/zmNd/MfsSoGqI0dMI4m8Cd2SKL+BTH9ZehBJQDWtpb
 jJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4mCrfb6tHdZvGXQSuo0SFJhy/sy04AKWjQJYvZGCoX4=;
 fh=LfeEjkq/Yq80tkHkwtAwBiaSjxJjy/fq+BFUyShCiAc=;
 b=nHTA4Ek2QLeNDF1Wn4qaVoM8O+dJfkRIcA/Y9bBYC3askkW2VtVQJTmZsW9XpfTyEg
 VX59tMsVZTV+BBPZwJcO5bPxf2rzmXCTBKkeiy13K3MCJ3ZC8WSK1ifeQ3GRUhSUSvnP
 QUfTpkeovz5Z91znHz+aQgoNHqhCVColEIeqbi3vYSAZK7j/g4LOw3jFD0Z/8MMvgwi6
 S6k7/OXrpatRTxIuUkFpRfFOi8QuHVaLd5tcdear/R22N5wWW1pQSB/SSTtJqD/q9pRe
 e/nuwEaezsOoAzO2WeJ2HJUdmmS8DKNb0U+HqAbUxcN8mPysMH37cdtNYpbdCtYKVm2X
 88tg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788016420; x=1788621220;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4mCrfb6tHdZvGXQSuo0SFJhy/sy04AKWjQJYvZGCoX4=;
 b=T31oDnJUt146tX9Qdy/fExibRm5jrUEsLm+R2zZPYog4/nC8jWuuAPSF6Dlfp+yGXE
 pRz22u93Ieew18jSOdSWtLiRytGl9QB7f+a3aSUOsBRqHB+/QlUyrrQepDkpdn+xckAs
 EofGGVKmFjA6B4SVxI7z3Y+ANZanrG7HOelNOYQScn9ntIb5J7w4L32FrwwZGcXsPLxQ
 hmWVrovEHQcJu3fVAxzAZHToA/3+XPe4CIXwuOs7jwGxlITrdZ+fRF8TwLa7i3rrQsIE
 OkUnlCpWTHMO6RTFSyIt5pHMW2jwja0qrCCS9g/IWsbgy0PXFbiQmGy/KkgrUx143kj1
 0Wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788016420; x=1788621220;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4mCrfb6tHdZvGXQSuo0SFJhy/sy04AKWjQJYvZGCoX4=;
 b=g2DQXtbwsPyTFUvt2xDF4hgGx7NtPyIe7vo/TP6eNhvWws9hQEyBt+LNW3SdR0x60c
 EOWC3Ki24ouX4+qcWUc2l2lNM+e/Mx6pZmPBIPtE0Nfy2O4W4XAG3QKnkQSAKqlcM7Ba
 QO7fz9pG0lth6flxyQ7V6w8fWhPDYgUiz+0VbUSsQkiGrdS/4h+tT4FCDUh13EjccPiI
 in42HtIFCtPmG2Z67dGNG8DKTWqvzFvN9GFf2KEfLsDYi3u6NDbHUhgUGyIPzuGTK8AE
 6mdqYRD+aV6783BbtKAiKhYDlBibFdn5WRbE3VsmEgKAuOf+DOkS7vDhXtPFzoeFGH5V
 4Jkg==
X-Gm-Message-State: AFuF++lDNgDDuyKcFeFo3uiuBNwuP/JF9TwNPcAtUrpm2/c5tPzFI6mC
 mOWI2SzOVxVOjxiyD7gmodeYGoDa0GrKvlUoPfqtJf+EkRByMD6OqbHJ1uKK2njPWrx/rIEigyx
 GBlsoMBPWguwbFzAvRG8Ak0b0nwgOPWY=
X-Gm-Gg: AYBFou3FFZMc132QK1zpY1XPlFLIoMURRn7opWpVJXti0EsPejSTQp+iRnAOz2dl3aQ
 sn1rP574ewYWw/L7tD8IZhRyh4KRf6/lmixb7n0EJeG5BQt5JbCB/i7qC4NSZSOcWw+JRB9CRbE
 6xGE4Rz9rC1bp6Ri3u7zx1X4VN9T4slTtZOoAx1eykU+kpKo1fWoL41ZGS67RNg3o8tzYL07Ggb
 Q5jWvcpiuAU/A66SQ6OR8EGq0I81evKmvkiqo7040Oux5YZWGRFP4YtKlgKUeOq2Mee+M3aFeQO
 u3cfmKJUCFj89bodr4SaYzO0o4V+IGvqdOZ8aYEhiW/yN6cWDoUm+uwW3Q/cP2K3zPYDr/8QRN0
 4xfvjtMzarZL1
X-Received: by 2002:a17:903:40ce:b0:2d2:72b6:556b with SMTP id
 d9443c01a7336-2d7269f5c6cmr250578295ad.13.1788016420066; Sat, 29 Aug 2026
 08:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260829015026.473134-1-trini@konsulko.com>
 <20260829015026.473134-3-trini@konsulko.com>
In-Reply-To: <20260829015026.473134-3-trini@konsulko.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 29 Aug 2026 18:13:27 +0300
X-Gm-Features: AcwNN1VuOMfCf9ApCAR9lgIROvWIMVlRS6u7jbW4vAn6k-yn8GNrIjjp-vW7eRc
Message-ID: <CAPVz0n2EQAiqCGeDGosfrytB6908iPfvAt4JwNHtua6QE_ETOw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] MAINTAINERS: tegra: Update and correct entries
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>, 
 Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hello Tom!

=D1=81=D0=B1, 29 =D1=81=D0=B5=D1=80=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 04:5=
0 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Update the main MAINTAINERS entry for Tegra to make use of the "N:"
> syntax to catch everything with tegra in the filename. This lets us
> remove the incorrect board config header entries for a large number of
> platforms while still having the used header files have a maintainer be
> found. Furthermore, correct some platform MAINTAINERS files that other
> obvious issues (such as .dtb rather than .dts in listings).
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
>
> This is slightly different than Michal's version because it adds the "N"
> entry for Tegra overall and so catches include/configs/tegra.h which all
> of the boards which had their include/configs/ line removed actually
> use.

That is smart. You don't need to replace device specific header with
tegra.h in some files, you can just drop them. Thank you!

> ---
>  MAINTAINERS                                  | 6 +-----
>  board/acer/picasso/MAINTAINERS               | 1 -
>  board/asus/grouper/MAINTAINERS               | 1 -
>  board/asus/transformer-t114/MAINTAINERS      | 1 -
>  board/asus/transformer-t20/MAINTAINERS       | 1 -
>  board/asus/transformer-t30/MAINTAINERS       | 1 -
>  board/avionic-design/medcom-wide/MAINTAINERS | 2 +-
>  board/avionic-design/plutux/MAINTAINERS      | 2 +-
>  board/avionic-design/tec-ng/MAINTAINERS      | 2 +-
>  board/avionic-design/tec/MAINTAINERS         | 2 +-
>  board/cei/cei-tk1-som/MAINTAINERS            | 2 +-
>  board/compal/paz00/MAINTAINERS               | 2 +-
>  board/compulab/trimslice/MAINTAINERS         | 2 +-
>  board/htc/endeavoru/MAINTAINERS              | 2 +-
>  board/lenovo/ideapad-yoga-11/MAINTAINERS     | 2 +-
>  board/lg/x3-t30/MAINTAINERS                  | 2 +-
>  board/microsoft/surface-rt/MAINTAINERS       | 2 +-
>  board/nvidia/beaver/MAINTAINERS              | 1 -
>  board/nvidia/cardhu/MAINTAINERS              | 1 -
>  board/nvidia/dalmore/MAINTAINERS             | 1 -
>  board/nvidia/harmony/MAINTAINERS             | 1 -
>  board/nvidia/jetson-tk1/MAINTAINERS          | 1 -
>  board/nvidia/nyan-big/MAINTAINERS            | 1 -
>  board/nvidia/p2371-0000/MAINTAINERS          | 1 -
>  board/nvidia/p2371-2180/MAINTAINERS          | 1 -
>  board/nvidia/p2571/MAINTAINERS               | 1 -
>  board/nvidia/p2771-0000/MAINTAINERS          | 1 -
>  board/nvidia/p3450-0000/MAINTAINERS          | 1 -
>  board/nvidia/seaboard/MAINTAINERS            | 1 -
>  board/nvidia/tegratab/MAINTAINERS            | 1 -
>  board/nvidia/venice2/MAINTAINERS             | 1 -
>  board/nvidia/ventana/MAINTAINERS             | 1 -
>  board/ouya/ouya/MAINTAINERS                  | 2 +-
>  board/toradex/apalis-tk1/MAINTAINERS         | 2 +-
>  board/toradex/apalis_t30/MAINTAINERS         | 4 ++--
>  board/toradex/colibri_t20/MAINTAINERS        | 4 ++--
>  board/toradex/colibri_t30/MAINTAINERS        | 4 ++--
>  board/wexler/qc750/MAINTAINERS               | 2 +-
>  board/xiaomi/mocha/MAINTAINERS               | 2 +-
>  39 files changed, 22 insertions(+), 46 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f5ec830e4a33..a3d14cd049bc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -701,11 +701,7 @@ M: Thierry Reding <treding@nvidia.com>
>  M:     Svyatoslav Ryhel <clamor95@gmail.com>
>  S:     Maintained
>  T:     git https://git.u-boot-project.org/u-boot/custodians/u-boot-tegra=
.git
> -F:     arch/arm/dts/tegra*
> -F:     arch/arm/include/asm/arch-tegra*/
> -F:     arch/arm/mach-tegra/
> -F:     drivers/*/tegra*
> -F:     drivers/*/tegra*/
> +N:     tegra
>
>  ARM TI
>  M:     Tom Rini <trini@konsulko.com>
> diff --git a/board/acer/picasso/MAINTAINERS b/board/acer/picasso/MAINTAIN=
ERS
> index 99f8c0b6d7fa..ab2fe5ebdf5e 100644
> --- a/board/acer/picasso/MAINTAINERS
> +++ b/board/acer/picasso/MAINTAINERS
> @@ -4,4 +4,3 @@ S:      Maintained
>  F:     board/acer/picasso/
>  F:     configs/picasso_defconfig
>  F:     doc/board/acer/picasso.rst
> -F:     include/configs/picasso.h
> diff --git a/board/asus/grouper/MAINTAINERS b/board/asus/grouper/MAINTAIN=
ERS
> index 3c59632451ff..6a54389c74ec 100644
> --- a/board/asus/grouper/MAINTAINERS
> +++ b/board/asus/grouper/MAINTAINERS
> @@ -4,4 +4,3 @@ S:      Maintained
>  F:     board/asus/grouper/
>  F:     configs/grouper_defconfig
>  F:     doc/board/asus/grouper.rst
> -F:     include/configs/grouper.h
> diff --git a/board/asus/transformer-t114/MAINTAINERS b/board/asus/transfo=
rmer-t114/MAINTAINERS
> index 2e8f01b98df2..01692fd29af7 100644
> --- a/board/asus/transformer-t114/MAINTAINERS
> +++ b/board/asus/transformer-t114/MAINTAINERS
> @@ -5,4 +5,3 @@ F:      arch/arm/dts/tegra114-asus-tf701t.dts
>  F:     board/asus/transformer-t114/
>  F:     configs/tf701t_defconfig
>  F:     doc/board/asus/transformer_t114.rst
> -F:     include/configs/transformer-t114.h
> diff --git a/board/asus/transformer-t20/MAINTAINERS b/board/asus/transfor=
mer-t20/MAINTAINERS
> index 7bf93570985f..28b8f954e7c6 100644
> --- a/board/asus/transformer-t20/MAINTAINERS
> +++ b/board/asus/transformer-t20/MAINTAINERS
> @@ -5,4 +5,3 @@ F:      arch/arm/dts/tegra20-asus-*
>  F:     board/asus/transformer-t20/
>  F:     configs/transformer_t20_defconfig
>  F:     doc/board/asus/transformer_t20.rst
> -F:     include/configs/transformer-t20.h
> diff --git a/board/asus/transformer-t30/MAINTAINERS b/board/asus/transfor=
mer-t30/MAINTAINERS
> index 869cc5aeb910..3fdcdd7c027a 100644
> --- a/board/asus/transformer-t30/MAINTAINERS
> +++ b/board/asus/transformer-t30/MAINTAINERS
> @@ -4,4 +4,3 @@ S:      Maintained
>  F:     board/asus/transformer-t30/
>  F:     configs/transformer_t30_defconfig
>  F:     doc/board/asus/transformer_t30.rst
> -F:     include/configs/transformer-t30.h
> diff --git a/board/avionic-design/medcom-wide/MAINTAINERS b/board/avionic=
-design/medcom-wide/MAINTAINERS
> index 3d2cdeca7259..ff777cae7e1e 100644
> --- a/board/avionic-design/medcom-wide/MAINTAINERS
> +++ b/board/avionic-design/medcom-wide/MAINTAINERS
> @@ -3,5 +3,5 @@ M:      Alban Bedel <alban.bedel@avionic-design.de>
>  S:     Maintained
>  F:     board/avionic-design/medcom-wide/
>  F:     board/avionic-design/common/
> -F:     include/configs/medcom-wide.h
> +F:     include/configs/tegra.h
>  F:     configs/medcom-wide_defconfig
> diff --git a/board/avionic-design/plutux/MAINTAINERS b/board/avionic-desi=
gn/plutux/MAINTAINERS
> index 0275680d21f2..fe10cec8b638 100644
> --- a/board/avionic-design/plutux/MAINTAINERS
> +++ b/board/avionic-design/plutux/MAINTAINERS
> @@ -3,5 +3,5 @@ M:      Alban Bedel <alban.bedel@avionic-design.de>
>  S:     Maintained
>  F:     board/avionic-design/plutux/
>  F:     board/avionic-design/common/
> -F:     include/configs/plutux.h
> +F:     include/configs/tegra.h
>  F:     configs/plutux_defconfig
> diff --git a/board/avionic-design/tec-ng/MAINTAINERS b/board/avionic-desi=
gn/tec-ng/MAINTAINERS
> index 645be8186aa6..1ce903ccc6b3 100644
> --- a/board/avionic-design/tec-ng/MAINTAINERS
> +++ b/board/avionic-design/tec-ng/MAINTAINERS
> @@ -3,5 +3,5 @@ M:      Alban Bedel <alban.bedel@avionic-design.de>
>  S:     Maintained
>  F:     board/avionic-design/tec-ng/
>  F:     board/avionic-design/common/
> -F:     include/configs/tec-ng.h
> +F:     include/configs/tegra.h
>  F:     configs/tec-ng_defconfig
> diff --git a/board/avionic-design/tec/MAINTAINERS b/board/avionic-design/=
tec/MAINTAINERS
> index 36088e7daccf..76d2f9f42504 100644
> --- a/board/avionic-design/tec/MAINTAINERS
> +++ b/board/avionic-design/tec/MAINTAINERS
> @@ -3,5 +3,5 @@ M:      Alban Bedel <alban.bedel@avionic-design.de>
>  S:     Maintained
>  F:     board/avionic-design/tec/
>  F:     board/avionic-design/common/
> -F:     include/configs/tec.h
> +F:     include/configs/tegra.h
>  F:     configs/tec_defconfig
> diff --git a/board/cei/cei-tk1-som/MAINTAINERS b/board/cei/cei-tk1-som/MA=
INTAINERS
> index f1817401a5df..f9ee3d6c8484 100644
> --- a/board/cei/cei-tk1-som/MAINTAINERS
> +++ b/board/cei/cei-tk1-som/MAINTAINERS
> @@ -2,5 +2,5 @@ TK1-SOM BOARD
>  M:     Peter.Chubb@data61.csiro.au
>  S:     Maintained
>  F:     board/cei/cei-tk1-som/
> -F:     include/configs/cei-tk1-som.h
> +F:     include/configs/tegra.h
>  F:     configs/cei-tk1-som_defconfig
> diff --git a/board/compal/paz00/MAINTAINERS b/board/compal/paz00/MAINTAIN=
ERS
> index ba174cd190db..95fd8fba26c1 100644
> --- a/board/compal/paz00/MAINTAINERS
> +++ b/board/compal/paz00/MAINTAINERS
> @@ -2,5 +2,5 @@ PAZ00 BOARD
>  M:     Tom Warren <twarren@nvidia.com>
>  S:     Maintained
>  F:     board/compal/paz00/
> -F:     include/configs/paz00.h
> +F:     include/configs/tegra.h
>  F:     configs/paz00_defconfig
> diff --git a/board/compulab/trimslice/MAINTAINERS b/board/compulab/trimsl=
ice/MAINTAINERS
> index 4eb868c0c838..1567f8691c2d 100644
> --- a/board/compulab/trimslice/MAINTAINERS
> +++ b/board/compulab/trimslice/MAINTAINERS
> @@ -2,5 +2,5 @@ TRIMSLICE BOARD
>  M:     Tom Warren <twarren@nvidia.com>
>  S:     Maintained
>  F:     board/compulab/trimslice/
> -F:     include/configs/trimslice.h
> +F:     include/configs/tegra.h
>  F:     configs/trimslice_defconfig
> diff --git a/board/htc/endeavoru/MAINTAINERS b/board/htc/endeavoru/MAINTA=
INERS
> index 85f439f4672e..ff46e79f8001 100644
> --- a/board/htc/endeavoru/MAINTAINERS
> +++ b/board/htc/endeavoru/MAINTAINERS
> @@ -4,4 +4,4 @@ S:      Maintained
>  F:     board/htc/endeavoru/
>  F:     configs/endeavoru_defconfig
>  F:     doc/board/htc/endeavoru.rst
> -F:     include/configs/endeavoru.h
> +F:     include/configs/tegra.h
> diff --git a/board/lenovo/ideapad-yoga-11/MAINTAINERS b/board/lenovo/idea=
pad-yoga-11/MAINTAINERS
> index 77e82534a95c..7da9ca79ef8c 100644
> --- a/board/lenovo/ideapad-yoga-11/MAINTAINERS
> +++ b/board/lenovo/ideapad-yoga-11/MAINTAINERS
> @@ -4,4 +4,4 @@ S:      Maintained
>  F:     board/lenovo/ideapad-yoga-11/
>  F:     configs/ideapad-yoga-11_defconfig
>  F:     doc/board/lenovo/ideapad-yoga-11.rst
> -F:     include/configs/ideapad-yoga-11.h
> +F:     include/configs/tegra.h
> diff --git a/board/lg/x3-t30/MAINTAINERS b/board/lg/x3-t30/MAINTAINERS
> index 13c8588d0b92..556407a1caa7 100644
> --- a/board/lg/x3-t30/MAINTAINERS
> +++ b/board/lg/x3-t30/MAINTAINERS
> @@ -4,4 +4,4 @@ S:      Maintained
>  F:     board/lg/x3-t30/
>  F:     configs/x3_t30_defconfig
>  F:     doc/board/lg/x3_t30.rst
> -F:     include/configs/x3-t30.h
> +F:     include/configs/tegra.h
> diff --git a/board/microsoft/surface-rt/MAINTAINERS b/board/microsoft/sur=
face-rt/MAINTAINERS
> index 1bbd896de928..78343e92a45a 100644
> --- a/board/microsoft/surface-rt/MAINTAINERS
> +++ b/board/microsoft/surface-rt/MAINTAINERS
> @@ -4,4 +4,4 @@ S:      Maintained
>  F:     board/microsoft/surface-rt/
>  F:     configs/surface-rt_defconfig
>  F:     doc/board/microsoft/surface-rt.rst
> -F:     include/configs/surface-rt.h
> +F:     include/configs/tegra.h
> diff --git a/board/nvidia/beaver/MAINTAINERS b/board/nvidia/beaver/MAINTA=
INERS
> index 20d5836b9ec8..1dd1fad7fbfa 100644
> --- a/board/nvidia/beaver/MAINTAINERS
> +++ b/board/nvidia/beaver/MAINTAINERS
> @@ -2,5 +2,4 @@ BEAVER BOARD
>  M:     Tom Warren <twarren@nvidia.com>
>  S:     Maintained
>  F:     board/nvidia/beaver/
> -F:     include/configs/beaver.h
>  F:     configs/beaver_defconfig
> diff --git a/board/nvidia/cardhu/MAINTAINERS b/board/nvidia/cardhu/MAINTA=
INERS
> index d3c3e368c17b..3984aa8d57b7 100644
> --- a/board/nvidia/cardhu/MAINTAINERS
> +++ b/board/nvidia/cardhu/MAINTAINERS
> @@ -2,5 +2,4 @@ CARDHU BOARD
>  M:     Tom Warren <twarren@nvidia.com>
>  S:     Maintained
>  F:     board/nvidia/cardhu/
> -F:     include/configs/cardhu.h
>  F:     configs/cardhu_defconfig
> diff --git a/board/nvidia/dalmore/MAINTAINERS b/board/nvidia/dalmore/MAIN=
TAINERS
> index fe86375ca9b4..5c8c08a2bdaa 100644
> --- a/board/nvidia/dalmore/MAINTAINERS
> +++ b/board/nvidia/dalmore/MAINTAINERS
> @@ -2,5 +2,4 @@ DALMORE BOARD
>  M:     Tom Warren <twarren@nvidia.com>
>  S:     Maintained
>  F:     board/nvidia/dalmore/
> -F:     include/configs/dalmore.h
>  F:     configs/dalmore_defconfig
> diff --git a/board/nvidia/harmony/MAINTAINERS b/board/nvidia/harmony/MAIN=
TAINERS
> index f3508edc3f56..2c25611dc358 100644
> --- a/board/nvidia/harmony/MAINTAINERS
> +++ b/board/nvidia/harmony/MAINTAINERS
> @@ -2,5 +2,4 @@ HARMONY BOARD
>  M:     Tom Warren <twarren@nvidia.com>
>  S:     Maintained
>  F:     board/nvidia/harmony/
> -F:     include/configs/harmony.h
>  F:     configs/harmony_defconfig
> diff --git a/board/nvidia/jetson-tk1/MAINTAINERS b/board/nvidia/jetson-tk=
1/MAINTAINERS
> index f0d8f5eb8e52..15a7a04de392 100644
> --- a/board/nvidia/jetson-tk1/MAINTAINERS
> +++ b/board/nvidia/jetson-tk1/MAINTAINERS
> @@ -2,5 +2,4 @@ JETSON-TK1 BOARD
>  M:     Tom Warren <twarren@nvidia.com>
>  S:     Maintained
>  F:     board/nvidia/jetson-tk1/
> -F:     include/configs/jetson-tk1.h
>  F:     configs/jetson-tk1_defconfig
> diff --git a/board/nvidia/nyan-big/MAINTAINERS b/board/nvidia/nyan-big/MA=
INTAINERS
> index 779077729c92..91a48bda0a8f 100644
> --- a/board/nvidia/nyan-big/MAINTAINERS
> +++ b/board/nvidia/nyan-big/MAINTAINERS
> @@ -2,5 +2,4 @@ NYAN-BIG BOARD
>  M:     Allen Martin <amartin@nvidia.com>
>  S:     Maintained
>  F:     board/nvidia/nyan-big/
> -F:     include/configs/nyan-big.h
>  F:     configs/nyan-big_defconfig
> diff --git a/board/nvidia/p2371-0000/MAINTAINERS b/board/nvidia/p2371-000=
0/MAINTAINERS
> index e6d04bf7c5e1..d3f6d64731d4 100644
> --- a/board/nvidia/p2371-0000/MAINTAINERS
> +++ b/board/nvidia/p2371-0000/MAINTAINERS
> @@ -2,5 +2,4 @@ P2371-0000 BOARD
>  M:     Tom Warren <twarren@nvidia.com>
>  S:     Maintained
>  F:     board/nvidia/p2371-0000/
> -F:     include/configs/p2371-0000.h
>  F:     configs/p2371-0000_defconfig
> diff --git a/board/nvidia/p2371-2180/MAINTAINERS b/board/nvidia/p2371-218=
0/MAINTAINERS
> index 815377490c7f..49d6062ab6b7 100644
> --- a/board/nvidia/p2371-2180/MAINTAINERS
> +++ b/board/nvidia/p2371-2180/MAINTAINERS
> @@ -2,5 +2,4 @@ P2371-2180 BOARD
>  M:     Tom Warren <twarren@nvidia.com>
>  S:     Maintained
>  F:     board/nvidia/p2371-2180/
> -F:     include/configs/p2371-2180.h
>  F:     configs/p2371-2180_defconfig
> diff --git a/board/nvidia/p2571/MAINTAINERS b/board/nvidia/p2571/MAINTAIN=
ERS
> index c165135a9432..23b9c6e83e3b 100644
> --- a/board/nvidia/p2571/MAINTAINERS
> +++ b/board/nvidia/p2571/MAINTAINERS
> @@ -2,5 +2,4 @@ P2571 BOARD
>  M:     Tom Warren <twarren@nvidia.com>
>  S:     Maintained
>  F:     board/nvidia/p2571/
> -F:     include/configs/p2571.h
>  F:     configs/p2571_defconfig
> diff --git a/board/nvidia/p2771-0000/MAINTAINERS b/board/nvidia/p2771-000=
0/MAINTAINERS
> index 1a49e63231de..7dbdbe0bcea2 100644
> --- a/board/nvidia/p2771-0000/MAINTAINERS
> +++ b/board/nvidia/p2771-0000/MAINTAINERS
> @@ -2,6 +2,5 @@ P2771-0000 BOARD
>  M:     Tom Warren <twarren@nvidia.com>
>  S:     Maintained
>  F:     board/nvidia/p2771-0000/
> -F:     include/configs/p2771-0000.h
>  F:     configs/p2771-0000-000_defconfig
>  F:     configs/p2771-0000-500_defconfig
> diff --git a/board/nvidia/p3450-0000/MAINTAINERS b/board/nvidia/p3450-000=
0/MAINTAINERS
> index 40700066bf39..6b93e40c842d 100644
> --- a/board/nvidia/p3450-0000/MAINTAINERS
> +++ b/board/nvidia/p3450-0000/MAINTAINERS
> @@ -2,5 +2,4 @@ P3450-0000 BOARD
>  M:     Tom Warren <twarren@nvidia.com>
>  S:     Maintained
>  F:     board/nvidia/p3450-0000/
> -F:     include/configs/p3450-0000.h
>  F:     configs/p3450-0000_defconfig
> diff --git a/board/nvidia/seaboard/MAINTAINERS b/board/nvidia/seaboard/MA=
INTAINERS
> index 7926ca19a896..b4759028a778 100644
> --- a/board/nvidia/seaboard/MAINTAINERS
> +++ b/board/nvidia/seaboard/MAINTAINERS
> @@ -2,5 +2,4 @@ SEABOARD BOARD
>  M:     Tom Warren <twarren@nvidia.com>
>  S:     Maintained
>  F:     board/nvidia/seaboard/
> -F:     include/configs/seaboard.h
>  F:     configs/seaboard_defconfig
> diff --git a/board/nvidia/tegratab/MAINTAINERS b/board/nvidia/tegratab/MA=
INTAINERS
> index bfd9eae86581..903279523a3d 100644
> --- a/board/nvidia/tegratab/MAINTAINERS
> +++ b/board/nvidia/tegratab/MAINTAINERS
> @@ -5,4 +5,3 @@ F:      arch/arm/dts/tegra114-nvidia-tegratab.dts
>  F:     board/nvidia/tegratab/
>  F:     configs/tegratab_defconfig
>  F:     doc/board/nvidia/tegratab.rst
> -F:     include/configs/tegratab.h
> diff --git a/board/nvidia/venice2/MAINTAINERS b/board/nvidia/venice2/MAIN=
TAINERS
> index 221df654d741..3ce3c6e1d26e 100644
> --- a/board/nvidia/venice2/MAINTAINERS
> +++ b/board/nvidia/venice2/MAINTAINERS
> @@ -2,5 +2,4 @@ VENICE2 BOARD
>  M:     Tom Warren <twarren@nvidia.com>
>  S:     Maintained
>  F:     board/nvidia/venice2/
> -F:     include/configs/venice2.h
>  F:     configs/venice2_defconfig
> diff --git a/board/nvidia/ventana/MAINTAINERS b/board/nvidia/ventana/MAIN=
TAINERS
> index ba65a2bfc2fb..a83fec521335 100644
> --- a/board/nvidia/ventana/MAINTAINERS
> +++ b/board/nvidia/ventana/MAINTAINERS
> @@ -2,5 +2,4 @@ VENTANA BOARD
>  M:     Tom Warren <twarren@nvidia.com>
>  S:     Maintained
>  F:     board/nvidia/ventana/
> -F:     include/configs/ventana.h
>  F:     configs/ventana_defconfig
> diff --git a/board/ouya/ouya/MAINTAINERS b/board/ouya/ouya/MAINTAINERS
> index 7f664b2e65ff..52f3e6bcf6cc 100644
> --- a/board/ouya/ouya/MAINTAINERS
> +++ b/board/ouya/ouya/MAINTAINERS
> @@ -5,4 +5,4 @@ S:      Maintained
>  F:     board/ouya/ouya/
>  F:     configs/ouya_defconfig
>  F:     doc/board/ouya/ouya.rst
> -F:     include/configs/ouya.h
> +F:     include/configs/tegra.h
> diff --git a/board/toradex/apalis-tk1/MAINTAINERS b/board/toradex/apalis-=
tk1/MAINTAINERS
> index 393c8dcf8016..6ac3df370e7a 100644
> --- a/board/toradex/apalis-tk1/MAINTAINERS
> +++ b/board/toradex/apalis-tk1/MAINTAINERS
> @@ -5,4 +5,4 @@ F:      board/toradex/apalis-tk1/
>  F:     board/toradex/common/
>  F:     include/configs/apalis-tk1.h
>  F:     configs/apalis-tk1_defconfig
> -F:     arch/arm/dts/tegra124-apalis.dtb
> +F:     arch/arm/dts/tegra124-apalis.dts
> diff --git a/board/toradex/apalis_t30/MAINTAINERS b/board/toradex/apalis_=
t30/MAINTAINERS
> index 368decf66744..e36fcd6a81af 100644
> --- a/board/toradex/apalis_t30/MAINTAINERS
> +++ b/board/toradex/apalis_t30/MAINTAINERS
> @@ -3,6 +3,6 @@ M:      Francesco Dolcini <francesco.dolcini@toradex.com>
>  S:     Maintained
>  F:     board/toradex/apalis_t30/
>  F:     board/toradex/common/
> -F:     include/configs/apalis_t30.h
> +F:     include/configs/tegra.h
>  F:     configs/apalis_t30_defconfig
> -F:     arch/arm/dts/tegra30-apalis.dtb
> +F:     arch/arm/dts/tegra30-apalis.dts
> diff --git a/board/toradex/colibri_t20/MAINTAINERS b/board/toradex/colibr=
i_t20/MAINTAINERS
> index 58842434024f..b52135bf5570 100644
> --- a/board/toradex/colibri_t20/MAINTAINERS
> +++ b/board/toradex/colibri_t20/MAINTAINERS
> @@ -3,6 +3,6 @@ M:      Francesco Dolcini <francesco.dolcini@toradex.com>
>  S:     Maintained
>  F:     board/toradex/colibri_t20/
>  F:     board/toradex/common/
> -F:     include/configs/colibri_t20.h
> +F:     include/configs/tegra.h
>  F:     configs/colibri_t20_defconfig
> -F:     arch/arm/dts/tegra20-colibri.dtb
> +F:     arch/arm/dts/tegra20-colibri.dts
> diff --git a/board/toradex/colibri_t30/MAINTAINERS b/board/toradex/colibr=
i_t30/MAINTAINERS
> index 73859fd25c2e..393ef3901f2f 100644
> --- a/board/toradex/colibri_t30/MAINTAINERS
> +++ b/board/toradex/colibri_t30/MAINTAINERS
> @@ -3,6 +3,6 @@ M:      Francesco Dolcini <francesco.dolcini@toradex.com>
>  S:     Maintained
>  F:     board/toradex/colibri_t30/
>  F:     board/toradex/common/
> -F:     include/configs/colibri_t30.h
> +F:     include/configs/tegra.h
>  F:     configs/colibri_t30_defconfig
> -F:     arch/arm/dts/tegra30-colibri.dtb
> +F:     arch/arm/dts/tegra30-colibri.dts
> diff --git a/board/wexler/qc750/MAINTAINERS b/board/wexler/qc750/MAINTAIN=
ERS
> index 017f6f2b707e..9dae5c17a668 100644
> --- a/board/wexler/qc750/MAINTAINERS
> +++ b/board/wexler/qc750/MAINTAINERS
> @@ -4,4 +4,4 @@ S:      Maintained
>  F:     board/wexler/qc750/
>  F:     configs/qc750_defconfig
>  F:     doc/board/wexler/qc750.rst
> -F:     include/configs/qc750.h
> +F:     include/configs/tegra.h
> diff --git a/board/xiaomi/mocha/MAINTAINERS b/board/xiaomi/mocha/MAINTAIN=
ERS
> index c3871a15a35b..42c0013ea651 100644
> --- a/board/xiaomi/mocha/MAINTAINERS
> +++ b/board/xiaomi/mocha/MAINTAINERS
> @@ -5,4 +5,4 @@ F:      arch/arm/dts/tegra124-xiaomi-mocha.dts
>  F:     board/xiaomi/mocha/
>  F:     configs/mocha_defconfig
>  F:     doc/board/xiaomi/mocha.rst
> -F:     include/configs/mocha.h
> +F:     include/configs/tegra.h
> --
> 2.43.0
>
