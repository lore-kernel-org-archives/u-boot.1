Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F0BCD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EA7B84879;
	Mon, 25 May 2026 17:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nebdeW/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27C398489D; Mon, 25 May 2026 17:10:12 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3364784862
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:10:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-67389cf78b0so3709421a12.2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:10:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779721810; cv=none;
 d=google.com; s=arc-20240605;
 b=M1Rtb4vOzGfjt8cd1+QgOsZ0xGoOtfttrBCxGsF+hoz3ZAux2AB47DEU4lDlIv6Opp
 lFTS+LBm3yJCVGSGLMpxGlDWxrogcEEQLitp3MibTLFsx9plYDP3EyXEjlMjvgfXUlzk
 layopECgdY6fDrBAeLuEjfsCWXeF38u50eDL7X8FamEjVYvq4POOOxnnSMA/2UV62nmw
 SivFE10WFM6rsQLfFZGRxGojvc+pkBaOe3CiPL28plWASurIcBLTHt25YJusE803uUNg
 etPuuLDGIiDpsy2auACK72UEd9GnMPbnrRToNOqvuwblyHjqhvR6qzbem3uXpHaP2Tok
 IWng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TRRtYGoc+sw8TDU7MdRK3vup71G+zpfWxsqlp4oP9bY=;
 fh=E8i5n10XNmew4pFsbezk1l8PWdZuCHzZSzlRhvS0fOM=;
 b=URm7G/YEBDblOpBn5prOl2aLxUCySkODEi3hyNmFNGvsU2hx2W8RpS9KZGai4i45tV
 LMGI+XzFSD881yX072rMdulgv1PSe6lWa7JBOXKxDKOKbjxaJnh9WytF3nLimSmY/j93
 P4GKv3z4XJx1msk3befFEXeeylW5oyKse67joszn9I0ewIl207NX1G8JPniF/gd7qvHJ
 JLu/20eY22BNbfGhF1BYc9c5hJ8Qz6d9XbLQkQraDgMgEaLcfyZLDnDvfeJ2RTn7T+c9
 kmr8iMqxkatNMgd5hfwdoRHuzJ+epcN2YuZNBDa9qDlgLhbfazrSpF5xWGdcVUVw4yv4
 yE5g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779721810; x=1780326610; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TRRtYGoc+sw8TDU7MdRK3vup71G+zpfWxsqlp4oP9bY=;
 b=nebdeW/it89Sdqsj3ScBP4QgUyjk0/h8KL12LfsOdIypG2npYAK8gD+Cw3xRM7J0S6
 ZSp82quIrUqMDNxYXe31e87s1pqsTLeUoocEbs8Wpm4xMI00jfwys+2LjoSm/9jFCHfi
 t9FFIi/FvLFFlNCKB+C581iZOKzDOvxQXTm5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779721810; x=1780326610;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TRRtYGoc+sw8TDU7MdRK3vup71G+zpfWxsqlp4oP9bY=;
 b=o2Ocy24Q8e7tlzuPcNXdB6O+8aQpQs02wjx8XL1KOgGb4W7xR9eDV+Vd+WrzYWPcB4
 qNi6XcLFI1gUq8L6iagR+1+gScERU+KoyRmrLs9Goi69nezmj1dF3aDP77d5Zw5PkQTP
 rfisODHuhcOsijsTZPK+3X+ozsr9XESxjQnAUg1wU9ana9cZTymGTVHqEmecSaRNJFlj
 15DPlXAVyCgYTW1HytwAL7FI4ujmqWmZNRFLCA6pCBuWqopEz1UqtNRSxJK5phICyDEZ
 o99rDj3WQ8NZRp7/Omapay7Xfe7MPFczfG2znZ2SSZXatZIRUiW16DqnkbvIU/Xk9FBi
 2aQw==
X-Gm-Message-State: AOJu0YyNe+TjWmSGuQs2qX6hpAwX44Q9tLqO1EU/AlswEMqsW4sWDJ+A
 deFwHx/WuMdQiH9J6t7xTD7kX+rE/0N/5PHwXPB5z3yJwT/Mjvzv0laWEWwTvUnAX436OJFW8oz
 d6imMQ/5LKil7XWCdXuaMewiXZxuB9bDOwwtYpv+m
X-Gm-Gg: Acq92OHbsBwFp+0esp3wnThJ49X3XJ1ozEgCUOtN3Hq6c5kqUE7Z4Heuo89x8n8VSyz
 gxNFTuoJmQ57HEu0RG+mZRDWImFd4p9YkcntlbQi/7kxvrEXYUtXjWC2dBcVCO9Zy+m2MCJS3Nr
 +cER5uqXe12ouHGjGoro++q4ZOcPLaweWoDWuAOXxssF2ZKkKTSkbI7yraa9+Jg+TZnO0atHDMd
 l9E7mr1W8jki+c6kEFlp90PMvanQ2cp3rfOYqwkTZLprZs90pMPGipEwOKqJdxUP+Hb9PY4CjLO
 x7on4w==
X-Received: by 2002:a17:906:8a4a:b0:bd7:f75a:817c with SMTP id
 a640c23a62f3a-bdd25af031fmr605351466b.17.1779721809648; Mon, 25 May 2026
 08:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260521191401.29310-1-ant.v.moryakov@gmail.com>
 <20260521191401.29310-3-ant.v.moryakov@gmail.com>
In-Reply-To: <20260521191401.29310-3-ant.v.moryakov@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:09:56 -0600
X-Gm-Features: AVHnY4JoblJsd5o0g09i19NWGgM6it5Fr50Dp75gGYlLPOwuxl1JViARyf9pq24
Message-ID: <CAFLszTjZd446WY9FWgeZh3s5OAaz5nY2HKZDTb9Ce6AMTAbGWg@mail.gmail.com>
Subject: Re: [PATCH] tools: image-host: fix memory leak of info.name in
 signature functions
To: ant.v.moryakov@gmail.com
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

Hi Anton,

On 2026-05-21T19:14:00, Anton Moryakov <ant.v.moryakov@gmail.com> wrote:
> tools: image-host: fix memory leak of info.name in signature functions
>
> Static analysis reported that info.name (allocated via strdup() in
> fit_image_setup_sig()) is not freed in two functions:
>
> 1. fit_image_process_sig(): info.name leaked on error path and success path
> 2. fit_config_process_sig(): info.name leaked on error path and success path
>
> Fix: add free(info.name) in both error paths (after fit_image_setup_sig()
> failure) and at the end of successful execution paths.
>
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
>
> tools/image-host.c | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -245,6 +245,7 @@ static int fit_image_process_sig(const char *keydir, const char *keyfile,
>       if (fit_image_setup_sig(&info, keydir, keyfile, fit, image_name,
>                               noffset, require_keys ? 'image' : NULL,
>                               engine_id, algo_name))
> +             free(info.name);
>               return -1;

The 'if' has no braces, so return -1 is now unconditional - the
function always returns -1, even on success. Same in
fit_config_process_sig()

Even with braces, fit_image_setup_sig() can return -1 at line 185 (the
fit_image_hash_get_algo() failure) before the memset(.) at line 191,
so info.name is an uninitialised stack value and free(info.name) is
undefined behaviour.

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -272,6 +273,7 @@ static int fit_image_process_sig(const char *keydir, const char *keyfile,
>               return -1;
>       }
>       free(value);
> +     free(info.name);
>
>       /* Get keyname again, as FDT has changed and invalidated our pointer */
>       info.keyname = fdt_getprop(fit, noffset, FIT_KEY_HINT, NULL);

Freeing info.name mid-function is fragile - info is still used below
by info.crypto->add_verify_data(). Several other exit paths still
leak: the ret == -ENOENT return 0, the return -1 after sign failure,
the -ENOSPC return, and the add_verify_data() error return. Please use
a single cleanup label with goto, freeing info.name once at the end,
rather than sprinkling free() at only some return points. Same for
fit_config_process_sig().

BTW please run the FIT signing tests (test/py and binman tests that
exercise fit_image_process_sig) before resending - they would have
caught the missing-braces bug.

Regards,
Simon
