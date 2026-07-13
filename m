Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085E1C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 14:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9178F84C59;
	Mon, 13 Jul 2026 16:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X3KgMZq/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83AC584C5A; Mon, 13 Jul 2026 16:30:45 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CEB284C55
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-69a5ecbbfb2so4886520a12.2
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 07:30:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783953043; cv=none;
 d=google.com; s=arc-20260327;
 b=OYBMa6fQW3SU+sSffneXKyC9lG7PCvnXYBrJTIFGzUtkZTLNHG+p23AgzyCkYPDya4
 HPKV/LN3z5m+vV2TBtbuAnxqVrMlGgep1v47ZzWoa4AMJVYSrUdRE6uI0GVFqAc0TQiQ
 rzzFDY3AP5HjHHTjUYEAWCP1wxwN24lW2oPmmx4vFyHuYfhrl/0YmR3dYLjSx5EyEW1L
 X8ESLvx22c4jdfw3ZfjM5GsNBTFXWZLoQ2+I+pIIZ99l/K7L/gcE6bMg4nRviHe4ydkO
 TQPK+0gKJERUGMwfvlq98d9iqMgyFKTCOjzbm8isi7bJF8d0jcOafOLMK9gXwl1rdzJB
 ipkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zCKEceIZG5gmscJRcRTsyKBrF7JmxGNVmFCPWd0aDwg=;
 fh=rzP7mr+0EjoRg0xiX0EhCi57TMw21tZVLXvNWCTwFDw=;
 b=F4q20IkivQZmu56L9VGCSojok5vcveO56N3q/7vhP6shr3nRMdy9CEOc3fLpTZtM9G
 ph4T8uzkzdI1vLt8pIhLQQQRtZUkLiNy6Se1HB58RJhmCBgBx8NerkAVYF24fhEPabBV
 q5uB+zhhzfpaDywn+iPlvhs22LzTyN/cVNqYy5zohhSZGeaURrQB87B6GBJ9fM5ytdyY
 QIDOADhJVrHf2rrSODBDKEySTMjUMxfbMjg+m5Wm6bZANDQCEv5fLe8MEKKF57dg/0U+
 kCGBwSBxChPuoIDA1EotpMjNm6JGABHoggXbUvMqZ6fag5aHwbmMktxulOLX95ceMyAw
 HDCQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783953043; x=1784557843; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zCKEceIZG5gmscJRcRTsyKBrF7JmxGNVmFCPWd0aDwg=;
 b=X3KgMZq/0NEyv1hePA3A4LEfPfYIjF3McWNS9GWAL7zflen28YfFbVJ92c+t4UjRPP
 zR66brBrE5h7pISf45bZuudbXjVSQIXWEeNTjHqCxp+NMPLNiguvxDP9TjjF6j2/zPI2
 +0mxpu0IavmuPjP4Mg/hH5WuHU9Xh4xc0qvdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783953043; x=1784557843;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zCKEceIZG5gmscJRcRTsyKBrF7JmxGNVmFCPWd0aDwg=;
 b=cCeA6PwnAkB5HgNjoX0tE+pWomzoF7rC4Jcxyz/6dqOfn8EdXHcpKBFxIzBAmfzUiO
 WZ+An4xpFXv/gARIhhckS/IRZ87TcCuLd65JbXbykUfId8TgGrxUHmBu18unQVXMsanp
 Lw+/YVAsJ1RlbTbaeqo8I7Ry3MKnRSxvFCKDZTaZqVkG7ChwxKXa2tlnuqbFjhNp9FzC
 Fn4jvRCOjxt6SJN0Nvyb8A8gEa6rQCH70kwDbXuZNvh+PKMKGhPQkSHYeaZshiWgwQwK
 Cx4kCWi68sAY+6ukbqT7+gJVugzkFZxVEgdoEFn/Ql7xqQUPxGZcxpV5JVBnHZsjzs07
 vbZg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBTALCTKAzsKbQagM1802+/U7vAGlZZsMK6RSgFJN2nP6WctaxMq1Qdx9t+A4CYhRQd8zpNkc=@lists.denx.de
X-Gm-Message-State: AOJu0YyXMaFfVBPEPu2YukzN2Vty8S0+SZbN1/FETAvy1dBdPo6OO6jK
 EGpFPgFMaONVekMMzdfiF4ZAQOLbqMUKgEbiowmFw0QCLU9rHR+pgntLsw34LephGpwScqV6NUR
 Sd1Ms0xcPy121klHRHbUTnHN1DWr6mCUVd5pD4IEH
X-Gm-Gg: AfdE7cnps2YMuR37yc71P927/XyfLF8sqZiOlbTkJS4/HMYi4NEl2aLFgblrF0YAQEX
 QMvSO7rxsNZVTI947ur+29fcKBkXOP2lGxt1vDavL+shKqYzuY/n0kyLFWKXB3sH7KgI1tHNx3N
 2Hk6wNeo6uvgLhZ4f5v/YnIpl+/056vr6qrpuoM3Tg9Xn8siRUNy1bYvJSB8tLPpmYFfwPVdFb6
 h6vQMDAAKPWE0hDue4N8hH+COxS0HGH9lzbG7xdU6aqsg4Dd9uhC/eH0mAYPnPglJvWCu2mX7kF
 /xp03A==
X-Received: by 2002:a05:6402:d08:b0:69a:9355:ec36 with SMTP id
 4fb4d7f45d1cf-69c5f38af61mr3822057a12.42.1783953042970; Mon, 13 Jul 2026
 07:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-10-jonas@kwiboo.se>
In-Reply-To: <20260708220540.3368825-10-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 08:30:30 -0600
X-Gm-Features: AUfX_myRzFaz4kp1HiZgQTiPPrSLmsrs0kekaPRCJdRVwiIXACrh1O3aGZoCo6o
Message-ID: <CAFLszTgPO+zQybrxDMwDgmY6XJWryVCJnGBQNRy0JephytBhZg@mail.gmail.com>
Subject: Re: [PATCH 09/11] Kconfig: serial: Depend on correct xPL symbol
To: jonas@kwiboo.se
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Jonas,

On 2026-07-08T22:05:26, Jonas Karlman <jonas@kwiboo.se> wrote:
> Kconfig: serial: Depend on correct xPL symbol
>
> Change xPL_SERIAL_PRESENT symbols to depend on the xPL_DM_SERIAL symbol
> intended for the related xPL phase instead of the DM_SERIAL symbol
> used for U-Boot proper to make CONFIG_IS_ENABLED(SERIAL_PRESENT) guards
> work as intended.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
> drivers/serial/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> @@ -81,7 +81,7 @@ config SPL_SERIAL_PRESENT
>  config TPL_SERIAL_PRESENT
>       bool "Provide a serial driver in TPL"
> -     depends on DM_SERIAL && TPL
> +     depends on TPL_DM_SERIAL

BTW this makes the workaround in ns16550.c redundant:

    /* TODO(sjg@chromium.org): Integrate this into a macro like
CONFIG_IS_ENABLED */
    #if !defined(CONFIG_TPL_BUILD) || defined(CONFIG_TPL_DM_SERIAL)

That guard sits inside CONFIG_IS_ENABLED(SERIAL_PRESENT), which with
this change already implies TPL_DM_SERIAL in a TPL build. Please can
you add a patch to drop it? I'd be happy to see that hack go :-)

> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> @@ -91,7 +91,7 @@ config TPL_SERIAL_PRESENT
>  config VPL_SERIAL_PRESENT
>       bool "Provide a serial driver in VPL"
> -     depends on DM_SERIAL && VPL
> +     depends on VPL_DM_SERIAL

Just below this, the help text says 'This option enables the full UART
in TPL' where it should say VPL - it would be nice to fix it here or
in a follow-up.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
