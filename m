Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CE4C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 09:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F265684857;
	Thu,  2 Jul 2026 11:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hiOEGr96";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AFFE848BF; Thu,  2 Jul 2026 11:47:09 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D2BB84832
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 11:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6989c0ec3c5so2792381a12.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 02:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782985627; cv=none;
 d=google.com; s=arc-20260327;
 b=lAnlH+PvwtrOMPYALYIU6FRqfJ1+vUNX+K7k28OiIkKQFurufddFcHbWx3rRInvm6H
 F5OjXwRXhddKc9U4EHe4gtZGeEBbdG/Y3rg+6WVHC5ExIpQILwvTYTvuyvHljW0Ma6Pe
 dlj7Jk67C9JbUZ8Bp48yxCybtGDELePQy9hmBPUFfuXO4BzeFCr/z8X++LUB7HMUlOWB
 0YBP6MOeiitB6Zxt/KTUqPm5njXkAgvqhPOwhwA+X+ARS6Ez99To1dlbnONDOrVREqiE
 YUNy3F5BDGHr5y+2QP4qjVBXQY+2kE0tk1xEowEvFdJklHJwDfbBlsPC5nWHDmtLaN07
 PIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KH5XsIW4IeNPYU7XoP7jsTAKN5mDODtsb+DhW4nGhx4=;
 fh=cDKu2ez2z7fTRABcTsmDaBKMQGi24MBV2uigQYvtWvI=;
 b=hqnVdSZMlA9p9yutkqXlEIS832/94SSwwb6Vjp6WjNfp2m2BizBpicXqdNlpLvgcQh
 ndNcsz3l8IWUzG36KZp8f44DbtanBkb7q56UXDflt+t04GvH7ZLe8q3KYMxDP29LTTZK
 GzqhRKe8PIZAkQ3jAblHw+qj+wgAAl4nH+Pegc1B9+lhvoh/KdS+xxQJKj1qY63UwQU6
 sgbo7JytYZSJMdMZmlGTZ3+MGQmv3NnhlDxcAW9zSEfbxeMqVO7lKYeckEb51cOatuBa
 7MdoLqvp3lVPWbOW6FRNTQANvA4RvaFqNR1sEt8s0Po5Ky5DvLzZhSxpN2xoWtm4Q6MR
 FAOw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782985627; x=1783590427; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KH5XsIW4IeNPYU7XoP7jsTAKN5mDODtsb+DhW4nGhx4=;
 b=hiOEGr96mWh/LQQdW9qQsGv9cl05DTVxdQRZ7Hvgh0xpyZ4sYqaB4wg9QXEZzigqKf
 wE+U5rksN9VMznXNgI8Ro7lTVkUxcY2/S4CFnVUeg9ltkubGuoh3TjATUVvWoZ2BHg+j
 AWthr9OSLzaEw6cjgAab+Qu/dk5C8c2E3oJgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782985627; x=1783590427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KH5XsIW4IeNPYU7XoP7jsTAKN5mDODtsb+DhW4nGhx4=;
 b=UdLj4IEWixprENRqk4ImJM0ANGQTT2FhHBM4KfBQcDNLVqT1RqR55g4r4pVd3/4FrS
 XYiQPT2kTHGI08u8Ox0g0ovN5CAETo36ExXoK4W7AH0bKcSHwdBzqYf/9T4j9zNuQZSf
 PUev6IKBuhDaA8b2LNOaBo+I+mSeccYHWKuxwSjJYKiwZSn8HcG1e9CptuVLXxrpx09l
 tvsH379uyjXRFPA75FB4OwYGjNlG0nzFGpkOtguMt7MFCzzEs69hPCaqzeh+1HMpq3Ui
 b527oQm1qpenI93QBQT4B0XCF1CAfdy4qg15EKyzwHj7gpzFSS7AEudH3ycw8qhHLuRf
 nbPg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVqiC5lpjvZmtBRBGya/EwA/grANOT+lF19DU0aQZ74X9rT4yEi9exHAsPItGwEKLWu+i6Mtg=@lists.denx.de
X-Gm-Message-State: AOJu0YzzpfU0dvV9EJ3b6GO7aZxy0ZPkz/u5ii3TW2NMDf06OP0OLslg
 uyvM7O8dkfiRut4dAzprYZa9hQNRFnc9bCboQ6b3iUpMODwESdLvP7cKFV2VfxDe897fKiOfVL7
 ljPOFBFsGcsLl0brp9SmzFN6+1sBOcNqJLrLIRN63
X-Gm-Gg: AfdE7cmTOq7jJF3i/hLvB9jZlU9kjfSFKFweuiiDg6AJY2NGMboYqpkGXNVfdWdu5OO
 5ZWediTu95hVCiSvkTISw4fjsSghpDZTb9klK/ynbXsy0Nzyez1XwOT39DByBj7wRylcTHja62d
 +mhjHBHNehknV9FVTlXAcjJbNQuPNqj0+5pEVRlBCmJPKeENxzvxemFaGDa32XIlID5LJke4TJK
 eCUOabUWn5hio8SKCd+jSNYKjmU9FqYmiQVBaTMMsHJhN+OK+EzCHXxJL+sl5f1WIHBUKNLtA==
X-Received: by 2002:a05:6402:27cf:b0:698:1973:1da9 with SMTP id
 4fb4d7f45d1cf-6989f3413afmr2499731a12.19.1782985626630; Thu, 02 Jul 2026
 02:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-4-me@ziyao.cc>
In-Reply-To: <20260701111808.870705-4-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 10:46:54 +0100
X-Gm-Features: AVVi8Cf6KUbe32Ws4_xcBmdzEWqb_2h25YQpmNSi9EXrIUtPAIoBst4ONOjbKME
Message-ID: <CAFLszTgorR4GtPCYe+XVcQBYJ9eDR0txDswbS=oE69swg8tjQg@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] image: Take entry point as an output of
 setup_booti
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Yao,

On 2026-07-01T11:17:53, Yao Zi <me@ziyao.cc> wrote:
> image: Take entry point as an output of setup_booti

The function is called booti_setup(), not setup_booti - please fix the subject.

>
> For LoongArch the start of the image is not the entry
> point to the image.
>
> We refactor the code base to allow entry point to be
> supplied by setup_booti.

Use imperative mode:

Refactor the code base to allow...

>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
> arch/arm/lib/image.c     | 3 ++-
>  arch/riscv/lib/image.c   | 4 +++-
>  arch/sandbox/lib/bootm.c | 2 +-
>  boot/bootm.c             | 5 +++--
>  cmd/booti.c              | 5 +++--
>  common/spl/spl.c         | 9 +++++----
>  include/image.h          | 3 ++-
>  7 files changed, 19 insertions(+), 12 deletions(-)

> diff --git a/include/image.h b/include/image.h
> @@ -1131,11 +1131,12 @@ int bootz_setup(ulong image, ulong *start, ulong *end);
>   * @image: Address of image
>   * @start: Returns start address of image
>   * @size : Returns size image
> + * @entry: Returns entry point of image
>   * @force_reloc: Ignore image->ep field, always place image to RAM start
>   * Return: 0 if OK, 1 if the image was not recognised
>   */
>  int booti_setup(ulong image, ulong *relocated_addr, ulong *size,
> -             bool force_reloc);
> +             ulong *entry, bool force_reloc);

While you are here, please fix the @start: tag to match the actual
parameter name (relocated_addr), and drop 'aarch64' from the
description above since this now covers arm64, RISC-V and LoongArch.

Regards,
Simon
