Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B704DCD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:06:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35E838464D;
	Fri, 15 May 2026 15:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HXI5VLaC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AE208468A; Fri, 15 May 2026 15:06:22 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33F5E84099
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bcc2b199c17so906090966b.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778850380; cv=none;
 d=google.com; s=arc-20240605;
 b=VLxWAVaNxWEMQenBdojkBgbaschBfptQOR7JqTYRMe5V4gNWP8Cv0QeMeSAD0+Q6iL
 oOQLkRrXSWYEz6cpEgu5br3u3FF6ROcw8XtncdsyTj6LzWHJ1+nMMBWW5HsI3jv2IDmA
 r/dyuyRQigwhD45HAy0KSaDiQbfwZ/wTnmOc44ksXePBxBfsGLHxvz2VWLr7RyiUgfUu
 Hf1REKZBbi2jhhdmuudbDrN6Cb97VeMXuTPhcJqIAVc9DFQwKGwYN2tUxRWpFE1EQdN7
 GWGBz56sDdISpQJriTd/yyLSzCd60FFw9aFjVlmJjEqELlcFgqLs72xxvJ6r7Gn3sZ/p
 RUcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Glvp3BbaZ7mGy6DQt0q/Op5nu0A+lk932eq2j5ZiDJE=;
 fh=uHnctjfjo81NP+4b9H5aVwcI8F1nm2RvYATNLKEK624=;
 b=Etui3mHTBPJyEdSQ6NOCsvyLas74vA2aTbSZXfwaN1DpXK412UNlbzIVBUIg+9vSS6
 QTa7DhmmZL58i+LSIzz/fJoqeIALFuguLbMKYAmB5Fg1xZbxoX0eA+GjuX3VpPdQpUxp
 nI5z+t4t8pi1zxjSHZ3ISqz68z5lpN1bzdrkk8UYmsZ3MjYTY/ncM9oXnTgPy3KZXLuI
 ln725HeaNxuSkIjIXD5XRF9MXoqGxoGM5SCArb0IeLEDrEmo3ACQFsJwgepz6wP5s6Y+
 kfgIY8s4XklCKVYZ81t9w0NSuGyYCugBl9Baz0UBei4fMbGV7Aj3TLcO+MSEQ79Z39aq
 oSVQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778850380; x=1779455180; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Glvp3BbaZ7mGy6DQt0q/Op5nu0A+lk932eq2j5ZiDJE=;
 b=HXI5VLaCde9SEo9XniNoXIy9J1aYqZsdQPDczf8pSyHNbTc3TdhQwME9lv35fdi4al
 I9Lah7/iC+GOmamKqx2R27kkn9vECEK3TxKLzL33ie7a0iFW7dA51AR9y8rYc6VHzpn5
 Bz8nBfZSq7NhHTD2HSV7DQROZm5W4ap7ozbP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778850380; x=1779455180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Glvp3BbaZ7mGy6DQt0q/Op5nu0A+lk932eq2j5ZiDJE=;
 b=Epdm1jD9RrZ7hERAm7UHD3v5hNC6KmxYh1Vvh0ow/BNXKTsSnUQkZDoLRR7bHwkTJF
 OD5Lw7OeS8TPO91nDSRrmlEPjQm2Tp2zraJYM6/KyzWaPWxRmOhfQD3QjVKOkfZpoVvu
 DpsHOAZ6aDJ2sShOQIAExzCJlphUqs9V+qo1nQ0U/AYBvxou4if7sfyWNXvZ6mifVM8R
 ibE2djWyEBgLMvGK/9ykQJ2/GZVrFxPrLXcB3UL92Mr3g5SxPW6wZ5tPKFYvuv0SbDNb
 Qnd7tAsv+LNdbJBb4h7EyT6g3Mhm2wsjwI8HIAXG3gpXnuiDrudd8byd+bLpcDNoynU0
 sJMQ==
X-Gm-Message-State: AOJu0YxSV2MZ/CoR0kmczbz5EfgMnpadZ9XYWDYwO7jOcuXMD3JqXzaK
 xMpHf+taW+AybLF+dJF7Tl8Qxk53X1gsp/Rnxc487RRvql9U/7RpSmRvdsjl0wajfTeh8HK7W6c
 BoR+4YTttwgCIE1ylqw2TG6fBc2waaBvLWCwdQfNr
X-Gm-Gg: Acq92OGL70aLbJuwDY7Q6CthIuuDYUuG5vAoLQuGXQdT6yS1m1A+5WYpXFlqjzyepEO
 ZvEtIoBLLh+Tyu3lh/l1q5qDCw9YG1w3kz0KAJHSjWEmpcSWTFB/QyUMgLy0CfQb9AAUo05SV02
 JpSCh+EWBL0y/UujMY+OzLwKZx3OP11ntEWrROVT47qwBcTjmWc+JKyjIh1WFUb0j54STCg3YNx
 9/8zQrtkOG+4FRH+1shSDhKfFvmm7cDJuKhsnd0CoFmnBw0FrXFGRo5BLDeqr7Wg0csjDijL6ir
 Dguofg==
X-Received: by 2002:a17:906:730b:b0:bd5:7c3:ac9e with SMTP id
 a640c23a62f3a-bd517aa8105mr214547766b.46.1778850379549; Fri, 15 May 2026
 06:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260512161631.284143-1-ravi@prevas.dk>
 <20260512161631.284143-2-ravi@prevas.dk>
In-Reply-To: <20260512161631.284143-2-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 07:06:07 -0600
X-Gm-Features: AVHnY4IguAzm4Of9zAdfMETbtwC-I9hD4BmSvyVrpqjXGjefhkM6Hlubi9vBC6s
Message-ID: <CAFLszThVY6D15HF2vy-xDQ-t=oROkG8j32DrtqzW=bpr3q6WOw@mail.gmail.com>
Subject: Re: [PATCH 1/2] image-board.c: exempt gd->fdt_blob from
 fit_check_format() check
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Rasmus,

On 2026-05-12T16:16:29, Rasmus Villemoes <ravi@prevas.dk> wrote:
> image-board.c: exempt gd->fdt_blob from fit_check_format() check
>
> Having scripts embedded one way or the other in the U-Boot binary
> means they are automatically verified/trusted by whatever mechanism
> verifies U-Boot.
>
> Writing those scripts in the built-in environment leads to
> backslatitis and missing or wrong quoting and is generally not very
> readable or maintainable.
>
> Maintaining scripts in external files allows one
> to have both syntax highlighting and to some extent apply shellcheck
> on it (though U-Boot's shell is of course not quite POSIX sh, so some
> '#shellcheck disable' directives are needed). Getting those into the
> U-Boot binary is then a matter of having a suitable .dtsi file such as
>
> / {
>         images {
>                 default = 'boot';
>                 boot {
> [...]
>
> boot/image-board.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Makes sense, and a nice feature.

> diff --git a/boot/image-board.c b/boot/image-board.c
> @@ -1037,7 +1037,7 @@ int image_locate_script(void *buf, int size, const char *fit_uname,
>                       goto exit_image_format;
>               } else {
>                       fit_hdr = buf;
> -                     if (fit_check_format(fit_hdr, IMAGE_SIZE_INVAL)) {
> +                     if (fit_hdr != gd->fdt_blob && fit_check_format(fit_hdr, IMAGE_SIZE_INVAL)) {
>                               puts("Bad FIT image format\n");
>                               return 1;
>                       }

Please add a code comment explaining why the control DTB is exempt - a
future reader running git blame will be puzzled by the pointer
comparison. Something like 'gd->fdt_blob has already been validated by
the bootloader and is by definition trusted, so we skip the strict FIT
format checks (no description/timestamp, presence of unit-addresses,
...) for that buffer'.

This also skips fdt_check_header() and fdt_check_full(). Fine for the
control DTB, but please note in the commit message that more than the
no-@ check is bypassed - the message currently singles out no-@ as
'not possible to get around', implying description/timestamp could be
worked around in the .dtsi, when in fact those are skipped too.

> Except of course that the control DTB is in fact not quite a FIT
> image. The lack of timestamp and description properties could
> potentially be worked around, but the no-@ check is not possible to
> get around. But since the control dtb is by definition trusted, we can
> just excempt that particular address from the strict check.

Typo: excempt -> exempt

> diff --git a/boot/image-board.c b/boot/image-board.c
> @@ -1037,7 +1037,7 @@ int image_locate_script(void *buf, int size, const char *fit_uname,
> +                     if (fit_hdr != gd->fdt_blob && fit_check_format(fit_hdr, IMAGE_SIZE_INVAL)) {

Would it be cleaner to push the trusted-FIT notion into
fit_check_format() itself (e.g. a sibling fit_check_format_trusted()
that skips the strict-format / no-@ pieces)? The pointer-equality test
works but feels out of place in image_locate_script(), and the same
need will likely show up the next time someone wants to
source-from-DTB elsewhere, such as an FPGA image. What do you think?

Regards,
Simon
