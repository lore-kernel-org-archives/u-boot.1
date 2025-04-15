Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B09C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 19:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0411B82A27;
	Tue, 15 Apr 2025 21:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G1ayeOYY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43ECC82A8B; Tue, 15 Apr 2025 21:58:25 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B0EA8214B
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 21:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e6405b5cd9bso20823276.1
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 12:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744747102; x=1745351902; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zy7QjacZJk4OLrqSTxNbchhhKZ2dKHqYNLFjBJIbanA=;
 b=G1ayeOYYJqH40x1fjEVFBJGXeJPxnAYHJ/yjyECdU3zCWOVsZmby3lgrBTSMpAR3KB
 dfxjx7ms7zp+8LMLq9+75Go20Bp67haVWSfxz8/A4JlBbQNkjOiu9B341aAzlJAbIsTm
 lDNvENSna2EYDqXy+bwUgELPNy2y9xzIMkGFDJgTwQJJz2HIuulGz07trQ4y4fVJ33Kw
 xfRrEGHMPXN7d0n4VFeFfASraRTOMRsRx8RRuGcxiTlwAzj8HOgIZKwiqMo4NUmdVo9p
 +1yfvLV/ElXmUwMn774LXfhGkX5Ev3O61cbG/MEWETrr2o86IfN6ANuSniT2suEYAALu
 k0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744747102; x=1745351902;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zy7QjacZJk4OLrqSTxNbchhhKZ2dKHqYNLFjBJIbanA=;
 b=uIYuIe5zv7k2CScjl3HiLuR4/vlYAxnnPb500Yqtb6sp8KDWSnzHWrHwmI2dQkxGVu
 iZPSZ/8xTPFnZEqhWmug6tDXGw+75SBDcotCrbrBpl4ZexHjW9Xh+j3LN4n0p8q8c0Rw
 IvQ0nbnigOTmmF2cdBedPvW/OJu6Qp0Vg+n0dfwmKU8HEDmuKd9r75VCFM3fIBkMIR+Y
 izj6JlYanAuE8Ft2HfLw48811mQaApD1GG3l/G9zUwi4o+QvxGfV5L1nW8QhbwLzIlks
 nR39Fp95dzMMzGg3wc4D1TU5Q96V6+RGUA7XCj34RwVkWvNS9HtXy+Vzr9Br8wqKDuqf
 brDg==
X-Gm-Message-State: AOJu0YxSDPzhUDu7d7nDtcEW+NwFNJra28TgFD+XGJN93gHY/9t0jau0
 bMSug0HSj6Ldf8HPzgD7QmwFJJiYoWo1OYcW41Y+6KmQkcCj3AHmiH9ZnoFEdQoVirCD2saQje8
 AAJbAco0mfly1g/xeXgOhExIDZ3eejFyvbevdyw==
X-Gm-Gg: ASbGnctdt7If7jfD5sXdNHQkjThdyI5DJtVGgtYWet+PfkUFujgvpLmU7qakllEv2tB
 rrVm+jfr6rBye5sxiZQR3l3WvygObS2I7QtC9MSxR6ZNLI9czUIwR7ae7UgcqIhJZli0gtBQn7p
 p5H7LCcSGnksd6PNb7ZaQBSknF3bpWkgaNiw==
X-Google-Smtp-Source: AGHT+IEm5QdcN7wZNa+TPYuKNUm2l8OAy7znafwEpPKejGsQ4S5ItcoP4Uol7hfjRWaIT92OdUCaea88Zr3ou+kH9F4=
X-Received: by 2002:a05:6902:724:b0:e5d:f98f:6f33 with SMTP id
 3f1490d57ef6-e70a600deccmr7129464276.10.1744747101866; Tue, 15 Apr 2025
 12:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250415125345.427420-1-jerome.forissier@linaro.org>
 <20250415125345.427420-3-jerome.forissier@linaro.org>
In-Reply-To: <20250415125345.427420-3-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 15 Apr 2025 22:57:44 +0300
X-Gm-Features: ATxdqUFhVPp8O09Sivv6VAYolRxDvSPBihV_nEWJJ3p4ERtQmSW9_wwlNWL84K0
Message-ID: <CAC_iWjL8ccKiAKC9eHCQGmPaWXJG+9wT7AG-4i-Q5vVv5zhj9A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] qemu-arm64: enable UNIT_TEST
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
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

Thanks Jerome,

On Tue, 15 Apr 2025 at 15:54, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Enable CONFIG_UNIT_TEST in configs/qemu_arm64_defconfig so that the unit
> tests are run in CI.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>
>  configs/qemu_arm64_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> index 6c9d2505a69..cd9a4f2ae26 100644
> --- a/configs/qemu_arm64_defconfig
> +++ b/configs/qemu_arm64_defconfig
> @@ -75,3 +75,4 @@ CONFIG_MBEDTLS_LIB=y
>  CONFIG_TPM=y
>  CONFIG_TPM_PCR_ALLOCATE=y
>  CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE=y
> +CONFIG_UNIT_TEST=y
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
