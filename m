Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCA0C3DA41
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 16:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50A0F88657;
	Wed, 10 Jul 2024 18:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iV2tE+6w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D12988665; Wed, 10 Jul 2024 18:46:22 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8763D8657F
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 18:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2c2c6b27428so4021495a91.3
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 09:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720629978; x=1721234778; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cpcN/trQ9U4pDkUBs2rLwi0O49gny7D2CUrFWhWMaYo=;
 b=iV2tE+6w9u/XJZdskgVKDbdEkQPgEyz4KNg719pXTZtTGTQpApdtZHAZP4EOnQzvgs
 t4wI6RAPpdwu/H/83/2FsIiZ8rHc1RbsqZfFM8TRGA0irHZSA2dp9qTriIYVTnAHS2cF
 xn1fjfOm2amp3guwcYgqDoM8L24k/HjePbMxU7nA8I8UuoWD8Tr7f79RghsMpa7gHd8+
 XAj7+aGVUguAfh+p9EUh4G8R3ipSnOhGh/c6N0xhXL+2Qcz5Xv6swex8S6Rc/f5AwN4s
 fh/fHoJFBK03VViKlGFyQRXZYSHhCIxtIeUdhnmifaMcvzEkK3Drhw/1Rpl7m/v4+ta+
 ItlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720629978; x=1721234778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cpcN/trQ9U4pDkUBs2rLwi0O49gny7D2CUrFWhWMaYo=;
 b=gjLXFIcLgMjC/dACTHirEn9ijZkL1pTBY0wzbq5q0UaE4NYVB/1EBZywozjN+RB9tA
 WBzQskXF7BWqB7qRQ+45F6EpjlBW0Kj8Qbg/CHKw5pcyvzPR3p9D4dwmfoq20GwHfvDc
 zySkOHrt0aiJ9Mjt1WsOYYtsQMGgudMx7eTwMvrOKGxLhS1XtfzspwsuOauz5qCFfv/V
 Z+QCcB1OSL7SPk/Rtvak5W+lbabTJIPyx2zTrcU8qWd/4JAX+Y7RSmGXjTcz3F6Gv8NX
 9xg67L+a/p0pM4MA7jkZvrO7R3svv/1vN4lPqu6Uv+9Rnz/XCu20eP5nYDgImIzGGP9K
 IC1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN+Jv0ah1fFR7t1BjMbk0H9yq3LXSH25Zx5l19jA4Q/IsfNFonq3h5tKr7hG9cJ8rbPEaHCb/BWVUJVkCnmDMvGrCp6Q==
X-Gm-Message-State: AOJu0YzY3QRamMfxEGjkLV+3euLYWM8rJGXFuGS6ebIFQvnm6Lo4yNuq
 cRK0osMf8DtyM3TPxQo7PuMD99kb3tvpnTR8Hr+RZ2a+BwhpBUiONerVx1KPmBLDW0LXVcvhHB9
 X0Nh3M5B/czf9XE1STWcZjvp7Q4Gmns7vmxfG9g==
X-Google-Smtp-Source: AGHT+IF0pidIcvkV+mCm2Tntr6TGazSZoer3VSj5BmWQCYRLmOGbeWL7y7s84zUcAAu+OfZijfn4BUXFO/RA+wwMuh4=
X-Received: by 2002:a17:90a:c7c9:b0:2c9:718c:73e with SMTP id
 98e67ed59e1d1-2ca35c79e3emr4920584a91.29.1720629977721; Wed, 10 Jul 2024
 09:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240710135320.2697805-1-yeoreum.yun@arm.com>
In-Reply-To: <20240710135320.2697805-1-yeoreum.yun@arm.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 10 Jul 2024 12:46:05 -0400
Message-ID: <CAEfUkUJ0XVAQZ0pqQeOVEcHH_QZg+Dk5B0aMOVK6p+U4noU1pA@mail.gmail.com>
Subject: Re: [PATCH v4] bloblist: fix bloblist convention check.
To: Levi Yun <yeoreum.yun@arm.com>
Cc: trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org, 
 bmeng.cn@gmail.com, nd@arm.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Levi,

On Wed, 10 Jul 2024 at 09:53, Levi Yun <yeoreum.yun@arm.com> wrote:

> According to recently firmware handsoff spec [1]'s "Register usage at
> handoff
> boundary", Transfer List's signature value was changed from 0x40_b10b
> (3 bytes) to 4a0f_b10b (4 bytes).
>
> As updating of TL's signature, register value of x1/r1 should be:
>
> In aarch32's r1 value should be
>     R1[23:0]: set to the TL signature (4a0f_b10b -> masked range value:
> 0f_b10b)
>     R1[31:24]: version of the register convention ==  1
>
> and
>
> In aarch64's x1 value should be
>     X1[31:0]: set to the TL signature (4a0f_b10b)
>     X1[39:32]: version of the register convention ==  1
>     X1[63:40]: MBZ
> (See the [2] and [3]).
>
> This patch fix problems:
>    1. breaking X1 value with updated specification in aarch64
>         - change of length of signature field.
>
>    2. previous error value set in R1 in arm32.
>         - length of signature should be 24, but it uses 32bit signature.
>
> This patch is a breaking change. It works only TF-A is updated.
>
> Link: https://github.com/FirmwareHandoff/firmware_handoff [1]
> Link: https://github.com/FirmwareHandoff/firmware_handoff/issues/32 [2]
> Link:
> https://github.com/FirmwareHandoff/firmware_handoff/commit/5aa7aa1d3a1db75213e458d392b751f0707de027
> [3]
> Signed-off-by: Levi Yun <yeoreum.yun@arm.com>
> ---
> v4:
>   - Remove FIXME tags on xfterlist.h
>   - Modify commit message
>
> v3:
>   - Restore arch/arm/lib/xferlist.c
>
> v2:
>   - Modify commit message
>   - Remove wrong swaping check in xferlist_from_boot_arg()
>
>  common/bloblist.c  | 11 ++++++++++-
>  include/bloblist.h | 10 ++++------
>  2 files changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 11d6422b69..2008ab4d25 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -576,7 +576,16 @@ int bloblist_maybe_init(void)
>
>  int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig)
>  {
> -       if (rzero || rsig != (BLOBLIST_MAGIC | BLOBLIST_REGCONV_VER) ||
> +       ulong version = BLOBLIST_REGCONV_VER;
> +       ulong sigval;
> +
> +       sigval = (IS_ENABLED(CONFIG_64BIT)) ?
> +                       ((BLOBLIST_MAGIC & ((1UL <<
> BLOBLIST_REGCONV_SHIFT_64) - 1)) |
> +                        ((version  & BLOBLIST_REGCONV_MASK) <<
> BLOBLIST_REGCONV_SHIFT_64)) :
> +                       ((BLOBLIST_MAGIC & ((1UL <<
> BLOBLIST_REGCONV_SHIFT_32) - 1)) |
> +                        ((version  & BLOBLIST_REGCONV_MASK) <<
> BLOBLIST_REGCONV_SHIFT_32));
> +
> +       if (rzero || rsig != sigval ||
>             rfdt != (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0)) {
>                 gd->bloblist = NULL;  /* Reset the gd bloblist pointer */
>                 return -EIO;
> diff --git a/include/bloblist.h b/include/bloblist.h
> index 7fbdd622bc..b0706b5637 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -78,12 +78,10 @@ enum {
>         BLOBLIST_VERSION        = 1,
>         BLOBLIST_MAGIC          = 0x4a0fb10b,
>
> -       /*
> -        * FIXME:
> -        * Register convention version should be placed into a higher byte
> -        * https://github.com/FirmwareHandoff/firmware_handoff/issues/32
> -        */
> -       BLOBLIST_REGCONV_VER    = 1 << 24,
> +       BLOBLIST_REGCONV_SHIFT_64 = 32,
> +       BLOBLIST_REGCONV_SHIFT_32 = 24,
> +       BLOBLIST_REGCONV_MASK = 0xff,
> +       BLOBLIST_REGCONV_VER = 1,
>
>         BLOBLIST_BLOB_ALIGN_LOG2 = 3,
>         BLOBLIST_BLOB_ALIGN      = 1 << BLOBLIST_BLOB_ALIGN_LOG2,
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>
> Feel free to add tag:
Reviewed-by: Raymond Mao <raymond.mao@linaro.org>

Regards,
Raymond
