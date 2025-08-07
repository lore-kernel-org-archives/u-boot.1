Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45BCC87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 13:59:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F10C84543;
	Thu,  7 Aug 2025 15:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="euxWOHWd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28AEA84581; Thu,  7 Aug 2025 15:59:46 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE1A784541
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 15:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7183d264e55so10954107b3.2
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 06:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754575137; x=1755179937; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/tTpS2QnJ7d6JsGx31E/hVDP+aGx5FVo+CQ+vIhYj3E=;
 b=euxWOHWdlyU+7aFKnmz09ffaRz04AhDSGJA9pJFEvc6yfhoTV1EM/Zyq0MwG+Q0FsS
 Oz0riJDpj9VKdBv/UZJR7o+KGgIXADoYfMG4cJ/lHtQCtUAACM6puFhvoD6sOx/BjMhT
 xMN1mVxX58ijwCIh22/T9nk75BDV3lDIh1cC8IGcyDQtjPCEn9f+B/kDIWCD9zTi3zEO
 +FGlvYl3KFKU21ikyLKpaD++NmSg5px7o8RFj8e/cvM7P/Nb+HUyHdk7I10OJ/S96rzC
 QMucgh5Pvg8UAbnfYx0P8ZRxEGqGxsIbLS9u+JSAAQO9shWrmqLkIBGv0KKHh2aBTUT6
 uJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754575137; x=1755179937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/tTpS2QnJ7d6JsGx31E/hVDP+aGx5FVo+CQ+vIhYj3E=;
 b=Ff96hc3tuPk4HFxblQv7dY9R8DHI+AE8g7/kAxJwQFh1x8PjFuXLdzGAT2+fDRb3Pe
 9fC3GiwyTdCB08mn7g3J77J9I7e99tGbcLUwnwUkCmGE9cVTJSfbYvuAFZzT80+ozInw
 jG3d4qsBGHafYAd0LtX15GHRc40TK1Wykor9H/Pg5s0J82LBfMPmOnF7ZN1NJvAIQtCN
 pAVusDTupqzdRHDry2h+jseKRW1hcdmjyGnzr5qoGq/j6egHFGx7tt51VzOtjvZQx48+
 gpwzDzHFgadgZsAUHbCkXgXydutOKGAOB3yI3fRN5PcBYTIlnPMY59oahRfIg787f2xw
 pO2g==
X-Gm-Message-State: AOJu0YwFKKJ96l4DRirtUGC4NLIvREmSYixQeIE7p5bsk/GrU60DD5bt
 LgJLSupJfqWqZejG9byoKWXXX+ZF3P+kHUno9EOnKa9sZeHnf1rbEMC0SI7v/VhlxPyiP8M4r5P
 UAhxqP2b7FWPeUeraljbMs46s5cMe0Dbs7NNcCe4YN2+MV2hsMOEHptUVHQ==
X-Gm-Gg: ASbGnctY9XfZjrxIFBO4D9/5ahnvrgWAKii48j10LT/e8UrufS3xi4Sc4tiC+GgxM2b
 tmR1ZbmoXU81RJMjHiQ3+4ojF5NDrNLCjCjYTvSa22OcB90VGw782MUN7gr0qExJik+TrCdTcr9
 gtn1KG1fo5iaHT+O7mPYx/GlLplPUCOUTlmQ3MRXTureQkZkMBvod7ZOczICDij777sP55IY6Xn
 oni6k9tYTMMcsEO4PNLm8wRezJcthd8X1vX1YoC
X-Google-Smtp-Source: AGHT+IE7/Sz4rpXkfpBOEiimbk56++utjg1ltTR+HXOM2YJQ/d9HZ+gVRknKdbVqyjjWz6nqrFoP2n5nnd6AHbJnfJ8=
X-Received: by 2002:a05:690c:620c:b0:719:edff:65a0 with SMTP id
 00721157ae682-71bc97fa50emr90843667b3.23.1754575136985; Thu, 07 Aug 2025
 06:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250806145519.1664444-1-trini@konsulko.com>
 <20250806145519.1664444-3-trini@konsulko.com>
In-Reply-To: <20250806145519.1664444-3-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 7 Aug 2025 16:58:20 +0300
X-Gm-Features: Ac12FXxc_NonlTio4BpAZ2zgpGRwX7UT_0yi0Me-UoIaHtXQgDLwgSTHUT2eNtY
Message-ID: <CAC_iWjJU9ihEX5nSe1bZHFJKZHSEhnZjK=2PCiH+wcMgw__ySA@mail.gmail.com>
Subject: Re: [PATCH 3/3] tpm: tpm_tis_infineon: Make use of 'z' for printing
 size_t
To: Tom Rini <trini@konsulko.com>
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

On Wed, 6 Aug 2025 at 17:55, Tom Rini <trini@konsulko.com> wrote:
>
> When printing the contents of an size_t variable we need to use z prefix
> to the format character in order to get the correct format type
> depending on 32 or 64bit-ness.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  drivers/tpm/tpm_tis_infineon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tpm/tpm_tis_infineon.c b/drivers/tpm/tpm_tis_infineon.c
> index e2f6238cbc71..de6566fdb9e5 100644
> --- a/drivers/tpm/tpm_tis_infineon.c
> +++ b/drivers/tpm/tpm_tis_infineon.c
> @@ -396,7 +396,7 @@ static int tpm_tis_i2c_recv(struct udevice *dev, u8 *buf, size_t count)
>
>         expected = get_unaligned_be32(buf + TPM_RSP_SIZE_BYTE);
>         if ((size_t)expected > count || (size_t)expected < TPM_HEADER_SIZE) {
> -               debug("Error size=%x, expected=%x, count=%x\n", size, expected,
> +               debug("Error size=%x, expected=%x, count=%zx\n", size, expected,
>                       count);
>                 return -ENOSPC;
>         }
> @@ -429,7 +429,7 @@ static int tpm_tis_i2c_send(struct udevice *dev, const u8 *buf, size_t len)
>         int retry = 0;
>         u8 sts = TPM_STS_GO;
>
> -       debug("%s: len=%d\n", __func__, len);
> +       debug("%s: len=%zd\n", __func__, len);
>         if (len > TPM_DEV_BUFSIZE)
>                 return -E2BIG;  /* Command is too long for our tpm, sorry */
>
> --
> 2.43.0
>
