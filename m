Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A28CD4F25
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 14:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29225846B5;
	Fri, 15 May 2026 16:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rwNsGyvo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F77E846D1; Fri, 15 May 2026 16:08:55 +0200 (CEST)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AB91846A5
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 16:08:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-6313c800372so5626379137.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 07:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778854132; cv=none;
 d=google.com; s=arc-20240605;
 b=d5li78ttfDJd9qIUe8Pod8zC6OissVxs5cMl67jY6NKMdT6rx61rDauzqwNuLpHXNs
 QwPvRgZNaozgoNpToSfQUYaEvnjSLYzitO9Sj7nmXgXw0Z/+ckY/YxgYbQW1L8YPOQDO
 3CzZNSE8eCrJ8uvxh7L+bboHjJjO9jhCmjNXCZiqQXxWOUkCsL178dFy/qHYA706+Doy
 4oJ1PJjfL4iDJVh3Vo1SoqrO+LgoGpA3RRu8j8ypKzr0nc6eTQszzwPIXvDh803HxpPy
 VoispP7WktqiblT9hWmWH2wyyb3WFN93JROgqlJ3oyuDEXLqwq8mdreAIUlJ37rk5VQg
 Umdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vJwtm9aQr22PvE9agvvtBmOdMDopIfhxdO7kugkazGk=;
 fh=3cGkqt4Xgv2w9dTeeIJFEJ5AO4AvGobPArcY4WlS1wc=;
 b=kqmZ4tSzCnt/lHg5xgYb8n/42jzujW3lQ7JdFmOqBehKFBjv97FaCKbvoPuBRQ7nEp
 n+why7ckm38KbkL747Id2Z2il6eXUVUVdyK4VVjUODCEfIjAFhqIocKBQ0CdduklxCzM
 Hg4yUie2iQYKa7ImGwKxYx9WWU1TnQIKqwvoHnat3kb1zIJruEweUiNENQq1VQ62ypXc
 UeUyGdDoIRhNE4MAZHWTAVroZ7wP5pWyYTa6VZHTEK7m+xrvb3R8SAYBLIpPlwV+Uh6T
 rAg+3SCsR0UwWYIuH+sff9PeB2pVkPrtTHJ0xFpZXUsLCgEG732BJr7fOJdH7G3VvMnH
 zrEQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778854132; x=1779458932; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vJwtm9aQr22PvE9agvvtBmOdMDopIfhxdO7kugkazGk=;
 b=rwNsGyvo2JCvm7d+SRwypX3Lm8jRpRufRgOEoNL8ZjEgHf5P/IalNKbjsfZZpOt2B/
 gjkpvsmGKnSLLJz05ipuwt4hE0KK5o7RA5kbCpWDi2gozu0BMVSYZhpfUj3qVdEAv/u9
 DMNMrNj+9Y7r+EbfKnODpFWoOtF2EI4BhYM5m4Am4yonihh3JQ7Ii7BsBsL4C5XCKhb2
 zoqTQSi05KPuLf/2RfejzjgFs4qnpeFlBW/O4OtbtRixhPF1vIqQT87Clz+n7poYaw79
 SuaLlkfyX0L65hnL9HBevkQheFzaeibBcCododIHqgzDhqdYco1hHuGklK0cfI7DwPLJ
 ZDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854132; x=1779458932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vJwtm9aQr22PvE9agvvtBmOdMDopIfhxdO7kugkazGk=;
 b=CU8Xwnx67bfhOP/JCd2uUAd4VEmrfXT02BtEKvk22kWUbihCF8lzeDyZ1JV1j1C4PL
 CKSnW+JGxzM8CMUVIsrN0D373NM9v2FYM3xSU1mWAvxcPmcZ4lm2sxqKiDEswCA+nD6a
 LkqWVnDS8L2pZiuYf46ohkOGv1XDqmLT9vqh08/0bYV+eqXltKu/2HtQ58SFQJSQ7467
 GcyctLmOCM7BbcFWl5jFoZQ61b/KzP3hqExnClU+dWf4ij08EjhoNIlVQ/xq27tLF0BQ
 RegABmc+2KpHqXcPp6JipgqpHUbr2K1/5R4KPX5IDlnrZWgpWZboWvLnnp6I2AliClJL
 yaSA==
X-Gm-Message-State: AOJu0YxGQXhI2DVVyKJjKauG4QRER0xMxpMK2QhzZl+VX0w+acGF5QvQ
 mwkRsJ7LAXDNCFu6weqd+TtoTWcVis3IGBIpK04qZPBaH4QLQL5j7GT2aEJFxeqxm6wKQg4FQ8y
 gNLNsnnPY624w48bR1WkqL/3lbUMkDpJoPA==
X-Gm-Gg: Acq92OFEWLPDRt5DTYE8essc9T00i98kD/p3bQriXgSfL31fOd8SeIZMHPmkOlXWOym
 i9ceItOfYfDnT/6KQexH94q5KPBQKbjmPlfBSq2xzP5oUrwVeg6lbtk70U+QQbV6vnC/LprVs4r
 YH1QCttUMbMbeDxLEFTGNGAc+c7FrRZSEcGMeUEiXJfcsVLDi15ZF5InET1Kd1n6TTBMGmkWCGo
 sp1DSsIDQWfWgQYfhk+L5BO/5djY8L8k9l7pypw4l1x07m2m+7VZzmOFzVTnyKmemNUuvUn6xxr
 YYMqs0XoEijaXRZq2Kk=
X-Received: by 2002:a05:6102:6e85:b0:606:49d:1861 with SMTP id
 ada2fe7eead31-63a3fb9d96cmr2058634137.27.1778854131594; Fri, 15 May 2026
 07:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260514175457.4047707-1-trini@konsulko.com>
 <20260514175457.4047707-2-trini@konsulko.com>
In-Reply-To: <20260514175457.4047707-2-trini@konsulko.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Fri, 15 May 2026 10:08:39 -0400
X-Gm-Features: AVHnY4K2LQwVtFv5MrIS5A0PTpxeilY7fLeL1lJsPyVfLIgMPVssQ6B940rxo2U
Message-ID: <CAMDkj5xKePrX+Q7qhUq1KQpuGr6poyDFcdXxKnwhzQL8K9AJOQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] bloblist / handoff: Make this depend on BLOBLIST_FIXED
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Thu, May 14, 2026 at 2:02=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> Currently, the only way we support passing a bloblist from one stage to
> the next is via the BLOBLIST_FIXED mechanism. Update the Kconfig logic
> to express this constraint.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  common/spl/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 5fa94098e498..cc819344cad2 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -220,7 +220,7 @@ source "common/spl/Kconfig.nxp"
>
>  config HANDOFF
>         bool "Pass hand-off information from SPL to U-Boot proper"
> -       depends on BLOBLIST
> +       depends on BLOBLIST_FIXED

I am wondering if SPL can use the same way as we did for Arm Firmware
Handoff - the address is not defined by Kconfig but via register
conventions?

Regards,
Raymond

>         help
>           It is useful to be able to pass information from SPL to U-Boot
>           proper to preserve state that is known in SPL and is needed in =
U-Boot.
> --
> 2.43.0
>
