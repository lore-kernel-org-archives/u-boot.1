Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48508CF9C55
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D63D788675;
	Fri, 20 Sep 2024 18:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l9a/ZGW0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3F9888B49; Fri, 20 Sep 2024 18:02:05 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B405688D75
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:02:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-718e11e4186so2079398b3a.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726848119; x=1727452919; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HL75nOSxgVzeTBAoECKfFyvy3rw851s4mO6VQgG3ssk=;
 b=l9a/ZGW0PuodBU5vm5NHl0LIYEw3RcUnHqduFuJxePsmLn2IAeyBT11U64PGmzAFuo
 tyJMGfn9sy7h38VmW7h9gQgjJc5Jfb+Sva/+BOzNNDJE6x+ERyYFpgRuDp3Ov+1X2Jq4
 j7fHZFzrLbr5ekrWvdkYp8AmrCt+cxg7U9KgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726848119; x=1727452919;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HL75nOSxgVzeTBAoECKfFyvy3rw851s4mO6VQgG3ssk=;
 b=PJMbRiXhPeCy0YF8eCiiADQj4W4GyavRc8GwUTRbLCUWb6enuqvuJzyzsp8GOQYFX3
 rFzchrZmlnCrfAS8qolIg37VK1C68dPHcHbuBfAoSxsYsU2Lzl558j4xIVGYtLFh98E2
 I+kEFhpS6Hu6pZPs4fKYsiO2xl1lNPg/I96vPq/DcDYz+aZXcyjzbzlrDU2DUv4yOR3S
 yYVFd6aBCDT+s2W+PjY4XJ9aOdOUPDvzPc96/WxluohuJ49VeDNFK2hFogohM4QhL+6v
 VbtSR9kx3dBIi+74wiyV05Qa3ldYKRPehysrpeaOdaVuKs7XM+EEFYCG0auWKUYtBLEV
 f1Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE3ZQbN/iGIZSEO4aM3oRl1IdtT0ooYTxHNR2SBOzhioSe4KAs0lLKUAVpYeY4UMmQ+Ete15k=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3XtjQc8EBmSLiMOXP5ma+FjRiCQH4TPJTZt00cHBWQ+0oG0RJ
 baGg1JM1Xli+RrJEdnEDal1bDL4VJVjwwKGrbc480XJnf1MKFpkpn4p5c5/ILR4QHi7SRQ16bKg
 1WkRp9o++AvBK3Cgqs/GYsKGIAn96UMY6d/tP
X-Google-Smtp-Source: AGHT+IE72Z3rrsRb4JywPQtASdbPtJ+63ihpSzOBq11BFhH7hq3Ee/dZ8+Pv16pTWLUbF+YyBp0cDDM52egTMhvowEI=
X-Received: by 2002:a05:6a20:b40b:b0:1cf:5155:cb5c with SMTP id
 adf61e73a8af0-1d30a9be637mr5703937637.34.1726848119143; Fri, 20 Sep 2024
 09:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240716150616.349466-1-philippe.reynes@softathome.com>
 <20240716150616.349466-3-philippe.reynes@softathome.com>
In-Reply-To: <20240716150616.349466-3-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 18:01:35 +0200
Message-ID: <CAFLszTidfrpWuXwtdMuBy+1Y2k4=C=gqKz_YwpL0bvnBACX7PQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] lib: sha256: add support of key derivation
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: trini@konsulko.com, abdellatif.elkhlifi@arm.com, u-boot@lists.denx.de
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

On Tue, 16 Jul 2024 at 17:06, Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> Adds the support of key derivation using the scheme hkdf.
> This scheme is defined in rfc5869.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  include/u-boot/sha256.h |  8 ++++++++
>  lib/sha256.c            | 42 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

>
> diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
> index 7aa4c54d0d4..46d20bf9b79 100644
> --- a/include/u-boot/sha256.h
> +++ b/include/u-boot/sha256.h
> @@ -6,6 +6,9 @@
>  #define SHA256_SUM_LEN 32
>  #define SHA256_DER_LEN 19
>
> +#define SHA256_HKDF_MAX_INFO_LEN 256
> +#define SHA256_HKDF_MAX_DATA_LEN (SHA256_HKDF_MAX_INFO_LEN + SHA256_SUM_LEN + 1)

long line?
[..]
