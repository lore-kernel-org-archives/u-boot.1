Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5B7FD875A
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 12:29:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 922E7842B6;
	Tue, 17 Mar 2026 13:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gKylqugw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0D5A842AB; Tue, 17 Mar 2026 13:29:20 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEC30842BF
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 13:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b97e5956208so51201866b.2
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 05:29:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773750558; cv=none;
 d=google.com; s=arc-20240605;
 b=cBCxvwgim9y08KYMC0jMY7bxrSBmyTwgz7wS+oQxGSrXDVWhuMQMkq3r4XsKLMw2e1
 Hduko7hZQi44AheEz67Fwbp1HGCdJm0KbM3RM/j6cOlQ2ssN+SQfnl674MpA+nxk/zWM
 Je9av0S+3wYXRLIdr16uKPd5lqQfi7I0B0Wzz5mFG0AYRZw+Fd+iLle6sLwXDJW4qxmf
 UO+/bQrPM5TfGUa1+bIU8tu8970GVwWEr1e78AOlZiKlF5AMVi1QTdQnIwVPuLqkYQ5D
 EDPrnkuC0inN765QUHtLKzxA+8Sd3fx1IrzCAFQuyEvlWNwkH+e5eWJ0S+G+15A3Egws
 Ipng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZQMBmgTKzuOo8ur2pAcQH5wa2LbBW62Hg1lfhJkIV0A=;
 fh=ouzfjbKpnG0Ece5Ipm6O35Zwg/8RWpznJgqNQWh9d8A=;
 b=ksmSCzTcmGBTpSC25MC5QPTfadQrXCJICbtHrMRctg2ceyYm8H7kU1zmZt4ee8Uc9Q
 xKTvqGCjmfcGorox5vhnzmu2wb4Y340LOn/cSHybC/90zzRosE5oWl87QUFdj8AnmDoJ
 6VTCm8/+yK859CTOg0yY4EgCLPpj79Z68QHEpZaQpVJuPSqDQN0x2v44ngtT7yUsE+j4
 WUtr1CGPKxp7VG9rGyj2NFvy3IQIOO6Iva5bLuWkVCOaJw/inTIOIOHlBhEjuCwYCH4E
 +iTNyIuyirJAZVffuahkiBK8uur4e2RiHE7BelHAD8JC5S3krOMZ+snCmrURxSArUwih
 ld2Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773750558; x=1774355358; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZQMBmgTKzuOo8ur2pAcQH5wa2LbBW62Hg1lfhJkIV0A=;
 b=gKylqugwPjn/ImRXwfjmzWk+OSpMOJ1Afckrgr50ELr0klf9U5C/ewp5y8joXAdvg6
 0aKq73L6JntkPD+Rbktp30NNy/8bRxWulgM4L7DYR3KBrNr6zlE495Wjzbw5XqZtpK0+
 omN+ophRf+icv+YaLI/kzvTLY9mo6BwvMZj10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773750558; x=1774355358;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZQMBmgTKzuOo8ur2pAcQH5wa2LbBW62Hg1lfhJkIV0A=;
 b=LOqibSTA3C7GhN8r2IMVuXc1pww2zEeXo+RjGcBrPfEOvnspzfq9fXYwIJBV1Dg6kL
 cYVFKD3BGk6ib3bjlyHGNEnGC6jnv0GzPILydujhDSH08gakEms+uwDznQ1vzKcWDY3S
 PhbRlCCmVg0QTubTPjuzSErVkVLZHNwc3+p9SJUARRf7MQKhSPN8BlOiKFfq+Z/uhMJK
 SlffW/QPPBu93BziiB4i13p/lpoZRWDTt9kmNQnKF01CNPnIpcSDW4CFE4TxyRy50ML2
 Rtahl8loEWwTo3ZfnHsz1Zc33qT3o55FIaI4jOYF53ePzi9Cs4KBAIL47fBnPar9e+LS
 7DxA==
X-Gm-Message-State: AOJu0Ywn3xKeLnXna9K+vZNUmVyvWaxVJlq1Fh4BiHEaIQbZvsWjVRpp
 tIlKGQwRGoH0xp40Myqpphef9ifiXtq57sAjk1MZzcBNGxJENsQXNzItxW18t92taepYWNNAYkf
 QRcnQl/JhrzKaevUJecvjH8a28Zc7uhk85hAghTQU
X-Gm-Gg: ATEYQzwVEmkNca2+/hsz3jbDRP9SytJYiQNr5vTCKA7c+umulxSZMnzlmlD0LL+JVJN
 VcAVIeZuj2KOx4s5GeauX482HIEon9aDYk+A1FEiszc7Ay23Smv0y/JLhAN/sFieBZCre/gjokp
 lL3fm6t0uQ+Ve4V2BYgJob2w/wJGnZLJ+cSaQx6MBQa6vMmL+6J5TOZDGi6Z7MyisJ9LJNFN6Jn
 dLTo23aPyfmA0QPlueHK2RZ2n5DlXtCdwpUr94jaSj4j9N4wDg2q43Hc7q6zMYrQW1Q8g8zzMqs
 mnc+vw==
X-Received: by 2002:a17:906:4fce:b0:b97:d85f:6354 with SMTP id
 a640c23a62f3a-b97d85f6905mr198562566b.10.1773750558113; Tue, 17 Mar 2026
 05:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1773154765.git.michal.simek@amd.com>
 <af02d5e56fa0fe48548da2a52d08710f3d7d5213.1773154765.git.michal.simek@amd.com>
In-Reply-To: <af02d5e56fa0fe48548da2a52d08710f3d7d5213.1773154765.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Mar 2026 06:29:03 -0600
X-Gm-Features: AaiRm52xJKS6uGG3itQqBOh-ZbaeU7iSfEqxy9fexuCliY8z1gLssyzdm0yxwcE
Message-ID: <CAFLszTju9o3O23vYBEx1R529b6iBdJL7PB0okd4p4L8m1pZzVQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] event: Introduce EVT_POST_PREBOOT event
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, xypron.glpk@gmx.de, 
 ilias.apalodimas@linaro.org, Casey Connolly <casey.connolly@linaro.org>, 
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

Hi Michal,

On Tue, 10 Mar 2026 at 08:59, Michal Simek <michal.simek@amd.com> wrote:
>
> Add a new EVT_POST_PREBOOT event type which is fired in main_loop()
> after the preboot command has been executed.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  common/main.c   | 3 +++
>  include/event.h | 9 +++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/common/main.c b/common/main.c
> index b0b6e74f5d3d..e8b23f3ff293 100644
> --- a/common/main.c
> +++ b/common/main.c
> @@ -19,6 +19,7 @@
>  #include <net.h>
>  #include <version_string.h>
>  #include <efi_loader.h>
> +#include <event.h>
>
>  static void run_preboot_environment_command(void)
>  {
> @@ -53,6 +54,8 @@ void main_loop(void)
>         if (IS_ENABLED(CONFIG_USE_PREBOOT))
>                 run_preboot_environment_command();
>
> +       event_notify_null(EVT_POST_PREBOOT);

This needs error checking if you wish to honour your comment below
(which I agree with).

> +
>         if (IS_ENABLED(CONFIG_UPDATE_TFTP))
>                 update_tftp(0UL, NULL, NULL);
>
> diff --git a/include/event.h b/include/event.h
> index 1d267f1d1054..3ce5f992b04e 100644
> --- a/include/event.h
> +++ b/include/event.h
> @@ -153,6 +153,15 @@ enum event_t {
>          */
>         EVT_MAIN_LOOP,
>
> +       /**
> +        * @EVT_POST_PREBOOT:
> +        * This event is triggered in main_loop() after the preboot command
> +        * has run, so that devices initialised by preboot (e.g. USB, UFS)
> +        * are available to event handlers. Its parameter is NULL.
> +        * A non-zero return value causes the boot to fail.
> +        */
> +       EVT_POST_PREBOOT,
> +
>         /**
>          * @EVT_OF_LIVE_BUILT:
>          * This event is triggered immediately after the live device tree has been
> --
> 2.43.0
>

Regards,
SImon
