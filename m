Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F88CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 21:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60B2284C00;
	Thu,  7 May 2026 23:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jWd6sEZT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B47E484B9D; Thu,  7 May 2026 23:12:18 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDFC084C0B
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 23:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9d9971d059so206844166b.2
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 14:12:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778188336; cv=none;
 d=google.com; s=arc-20240605;
 b=gE52zRxnkigDXo/b73+jTSlmoGtK4D4i+EgXPgit6wk18hoHhhmRc3usH8O90DmG6R
 /5GBvmNrac6YvYHQEzTa5//BImKZehXoGMOUsQxvA+a+nHCDUjIDpH1lPN9GM+r25Rjz
 wjtuvi5k/80NMCOAg4UKV9Yy9Tt4J8QtWL7AbH7yt98F6CSDVM5VdmKqJ8j2fY+L9sAn
 shXQhN674A9j0OvH3mEHoBdt/gFbM+utcNbk42xmb9wJA328Rscve7D0nzT9XL0UJiu4
 55/kRbAxhUmKceci/ljzxAWUhIWWqtqTugLuTMpgGv2RDx/RSLf32jYv7N1hGki5ofVI
 f37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E0Md/f5qJRx5FgIsN/qo8DQLZpal18EZEZyDN1R19hs=;
 fh=XXcfzCiAuQMJyMuyiaSz7X2bqP/dLoxll3XeZkNPATA=;
 b=VU+bL46rpv0w52cLTiMlDofTxpgFoajiYL/ttTbuwCufKga3OtKENgJrdYi7it93aL
 YtfeId8K03KUHIhM/2xOFAx48f8y6kkSFLrwM/uXn9mf/5jnpRASG95uvy2nZ4mLlFTt
 rlRvXxICR9qQRjrlXDuc5YdYUZ09b/1DBiHsxEkZhybq8r1gkIE9oHjkImVA7KRlBcWS
 +Fwawfrf5CA52DaMD0z5MIm32b4CBpMZWfu/vW4ZDxgCIGgVKH/LKH3MmFYL0pc84BJ9
 PdNjoXbpWewv6Fe8B9TWVY1EQCGVEugzF42Cn4O15hBG0OHrHzQzPg8609g49Ez44ZHq
 Kwtg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778188336; x=1778793136; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E0Md/f5qJRx5FgIsN/qo8DQLZpal18EZEZyDN1R19hs=;
 b=jWd6sEZT5bfOU6eC7H+FV6jeRyDRxi/P1Rz+ovVkElNnRcjJNbofu8Rg83dt1KQEQ1
 vte8yJH+KhqrPjtZqgelHBmfEXHr7Rp65H1H5cMgIIWx94FfiRFn8kwHPxMIPqh8YIRL
 1NwOd4QrZDk392rJ8fJUwwnvLnJ1VH0TL5Lns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778188336; x=1778793136;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E0Md/f5qJRx5FgIsN/qo8DQLZpal18EZEZyDN1R19hs=;
 b=kj4hXFN4w+5b8hxptI9ep6neOJpqiZk14uLPZ6sOAP0ZrLb2tMXTaooxBw0UrYYggG
 Cx/oMbNLI3KFHLMSlCdCw/oYLGXu4T/TVTmjW57iIgsz2FLeiJEKuf+9r9sdjskQ1mw8
 2GIn6jhDxJc3q5LWHvJKyPwpCPmX3DRjIElf390ObmuJUQHk0edQc8Lv2SKYF1r60OOq
 mkWmuOo6iWLI5oEZS3J6xKas8AMKEx0MDENMJMrR05/8KjPG2nW+Iugz0+6BXxbip+0V
 pBDICAioJA2cEcxSCTHPo+U8NLB7AfL5lQhsGgvwiqJYV8HN4iWmA5kyDEh81XEcBmgy
 64OA==
X-Gm-Message-State: AOJu0YxBC7ItSdduMDjfYszDkyHLIRO5fT3DVzKTfzq5y8HCIDapMW8G
 OMUvXEYloSaMo937zz1Y8QVSSSs20QCxcWppy4eGRC69wmMNxh502Qn6X7COxw2jBavTfYpZvLE
 XyiEzwVYuVX1uNcoyM1KDfzkaQf5LCcvtsDKO03mR
X-Gm-Gg: AeBDieuKmc+BcTD7d3/W7yEMcNHabHW0A1sMICDkj8ubT3W20UjBn7rM7ShvThsgtNr
 BCg2gflYd1P9/WdSW4U45kgtA/cScGKvFanTHErow7foW1aijefEZcR8wFfXRNUKz0at0VqA2Y+
 hRWUoC7XO/L0QBgQQd99GHXLJE8Ploa1J62UYFriKiGWGMAy/8vonEn2XiJL6XQHpP7qdkGqKha
 ocNF8CtDS8vQIjjJOVpfjQGGDPgvBTPXJ630BG5ijxFVZ1Za6OqPK6M+LbEFUihsIkDu3nqhZg8
 cOI3xw==
X-Received: by 2002:a17:907:cb27:b0:bc2:e449:3665 with SMTP id
 a640c23a62f3a-bc56cd3a9bbmr385624766b.27.1778188336146; Thu, 07 May 2026
 14:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260507120735.310325-1-ludwig.nussel@siemens.com>
 <20260507140624.v3.2.2405ba52fddd2e9ff1bbc24585e1e3140f660637@changeid>
In-Reply-To: <20260507140624.v3.2.2405ba52fddd2e9ff1bbc24585e1e3140f660637@changeid>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 15:12:03 -0600
X-Gm-Features: AVHnY4IbtwakucH5Wl6t_OS7_Z-ZRWH6NyzVMYS9Z8mirn1AwoWT1W7BHyQ7m3c
Message-ID: <CAFLszTgcLUAYSUzUQfdzHRnBsFuwDGD3LYf3-qHU8bp-BbWUQQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mkimage: define log_err and log_info
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
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

Hi Ludwig,

On 2026-05-07T12:06:22, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> mkimage: define log_err and log_info
>
> Define log_err and log_info centrally in mkimage.h so any file used in
> this context benefits from it.
>
> This patch is in preparation for a change in image-fit-sig.c in the
> next patch.
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> boot/image-pre-load.c | 3 ---
>  tools/mkimage.h       | 5 +++++
>  2 files changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/tools/mkimage.h b/tools/mkimage.h
> @@ -31,6 +31,11 @@
>  #endif /* MKIMAGE_DEBUG */
>
>  #define log_debug(fmt, args...)      debug(fmt, ##args)
> +#define log_info(fmt, args...)       printf(fmt, ##args)
> +/* can't use stderr here as that's unbuffered and would produce
> + * output different from u-boot's console
> + */
> +#define log_err(fmt, args...)        printf(fmt, ##args)

The comment is a bit off. These macros are only active under
USE_HOSTCC, where there is no console, so the real concern is that
stderr would interleave out of order with stdout. Something like:

   /*
    * Use stdout rather than stderr so error messages stay
    * interleaved with normal output in the order produced.
    */

Also kernel comment style puts the opening /* on its own line.

Regards,
Simon
