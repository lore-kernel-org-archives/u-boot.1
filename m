Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C24105F7A6
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 12:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9107284242;
	Fri, 13 Mar 2026 13:54:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hS1RZWOt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CC3084286; Fri, 13 Mar 2026 13:54:57 +0100 (CET)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 791928423D
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 13:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64ca4dfdd88so2332536d50.0
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 05:54:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773406492; cv=none;
 d=google.com; s=arc-20240605;
 b=TrXNUrodmVWLqOlha59sePjhc2mD5E1Hay/J24PECeGaLMkuLYgJ/cmcKt3mda9+MY
 Hpduas54KeR8VAsEiUFyO27F2ft3t2WvL/r6OtcNY1B3LiQ1p5fM8K1VNC+B56u9OaQh
 edgvOIBVSh+Y/ONJxfAy8zhX8BT6C1r6nKYoEDI66te/3xFt4GCT+lotmTWd6WEVwi3/
 e+eBL5VGeTGRBfe5kZgZHaAV5dor7vt4t6K0/G2hn+sh+pOVEWzW5Niel7Nor8tQyT89
 K9DJS6RtYdMP6Gwf+o/npLpKC1NW7FvWBrISaJzINrCuCkqCDJWZmDL4Motx0hrRODoc
 O4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DwvhqbD+7A4UiBWjVnaBhDwiYUMrb1ffxg1m0JrKNaQ=;
 fh=uYCiHNwrvUUPzN6PXsFyP4jwfIjaRQ7r1lBPN3AWgnE=;
 b=RyPRV+COx+lYKlIJMV3ISXhPGfOsJT6lQSf4gQZ4RSSP5OgNb7lMf8JKFMmTqL/1yT
 f2O8HO9dPJTi6gs6SD0BPXYblZsEQWj/ZIZ3xIRzqLL+Mu6K0rcFUYZGdNviwnYXe5Uh
 wuhpoBvCNHh9KDkzAyuKfh3KEgXSyQ0Mpf7haC8mspDIkIhYBnz18x5WlNNxs8xmYWnE
 YXkPe8EJF067H4OL1p9It4mismHgOpBsGEBRdnbLEOGNaoHEOeX5CvRZ2GYGuZJnT8I9
 dUQj3e8hcC9EEY/dJwJ2SbTndf3Vtw2ASsgk7+UeHPl6qImSK3LSLDh6BAiF2BUxPzgr
 ybBg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773406492; x=1774011292; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DwvhqbD+7A4UiBWjVnaBhDwiYUMrb1ffxg1m0JrKNaQ=;
 b=hS1RZWOtIUcsl1WndXRpRq+ghrRuXJnQWmB5DfzjJNHq1Bnll/Ww5lyAjmZp8BM4i3
 JhIIm2w/etyOjdtHU4n+KEAF7v7BeY4CVEHyxbjFFb7tj4cXKDQOBMkpb1SwZpxknTeN
 8yiLQdBOaRz5ZL8Y60FYrY3W/eA9Iejd0HgRrv6lC1lPN0STpbvUv/B5NLBx7SYiaILq
 y3scvaRZ4u0qiJ4g83WLE2IWkOQ5Cn3l8qhmdWegYshBF7BUn+xzMP3uibYqzf7tby1d
 bKBC1wX95XBhSL3Ao8311240AuRFZgiTCDBd/XpHzSM7s9hmnVxd2xPedJppIYQbS9T2
 Hn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773406492; x=1774011292;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DwvhqbD+7A4UiBWjVnaBhDwiYUMrb1ffxg1m0JrKNaQ=;
 b=CWiHDqdBBpHDdO1L84HXN+/2m2y8ZianhrlE2QuEeDUVtOqkgViYtW6UklgdsxxYkM
 8Za6GQXBkpaC3hJCR5+Abze1/SAoEoBZ/L82w8gKFITt3Xmv6s9SJfT8ywTVX0d6CLWC
 1XOnKfZRk1EOUMNQ1z9xS3cfXC9SlALqMr3W9b6qe6JNSmK7w1bZTv2RmhsU1zFYjBI7
 MpY6UG9+l9ngsQix2K63C1z/uHJsKFz5m7a0swIcc2k5HBntCsk1KCba4R3aiThfqa3N
 K1Rl3iU70MdkN6OUTtVu8yWhxsFP8Y1cqy4h91qQ7MoTAHbdupQTRyrtFWUXWxivLry6
 hC2w==
X-Gm-Message-State: AOJu0Yx9QMNPw/f6lcN3L6UggHScs9rYyWP4og35KIjyUQbQK32EjJHi
 WbOY1btw0hD+jWoIfOl++xGoac43qx0G2v9+MewfYEupbhuGvKgxKmHQtepD1micSeZU25ATQyx
 +09EPJ0lMqT3e83/rzI8SWNT23x4vc56DkabFxTcsHQ==
X-Gm-Gg: ATEYQzwquig+qpLC2Ypk4qSMC7Vs1903droJASIKDwH/hoL5lVsktghQd35YHz/ublR
 xKSbfKJjDVzSzEr1VojzDza+NOrMpdlUYYn1PWUsxBWaOW7XsW15IilpTsKgMS4AYjHanWy+Cqq
 YU6JzBN3hdYTgFOjKnnH/YsQe/e/K907r87CVrXLZ6yt7o/XYuEz2TaBRaTT56whRS9eKarzq8Q
 QztFVozKQ6seu8Fs9pJ2mtDK7GLgZn8cou3NZ2SR0qKn834PYmf/qRvm4cFXDL1N1YIgUp9ZVZn
 sVMFOqY6xapO4RihxpQVoyxDo3sQ5j9O52p2gs2tBXQdp7GAoaDUGq3wBuFcy+kamkzXiTFMNK6
 IhUHB16j6JAyrCcvkcHdTClbLH396ZrZLm20tyUXkdZjWMdJLpNUNyw8hcj4Cw+dQbNafixlTWF
 nJ9V7G7HAWAV6pe50lf7U4fHyZOFsmqsPNRMr3Ibpxb/o0jU6rimtnlecyP5ka5O17Ci59LYJX4
 +QqhKkouln+TjI42BFSY94RU4tIFEGzZCbiyZSP3hjtYdFl7sL06B7yaFy0TaJ6KVgPAIbr716x
 oRrkb3vVHIfkfNQOJal24MNnG4BtdoGz3P3vURoJds4h
X-Received: by 2002:a05:690e:2444:b0:64d:5742:5ab0 with SMTP id
 956f58d0204a3-64e6308dbd8mr2436694d50.43.1773406492242; Fri, 13 Mar 2026
 05:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <e5387628c1d64caf7bcabb5d99d2987bd5bff617.1773150603.git.michal.simek@amd.com>
In-Reply-To: <e5387628c1d64caf7bcabb5d99d2987bd5bff617.1773150603.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Mar 2026 14:54:14 +0200
X-Gm-Features: AaiRm51UyehKkkvvoSYx3Ff-i2aWffDsZLpErBQRCK1pemkhDJHcyeMBxkamzBM
Message-ID: <CAC_iWjJLfVJb5zy_Jb=-h0d0U7-ui4yz8ihb9=g9f1nKVDRA-A@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Allow disabling ANSI console queries via env
 variable
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, 
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

Hi Michal

On Tue, 10 Mar 2026 at 15:50, Michal Simek <michal.simek@amd.com> wrote:
>
> Commit 4cb724364030 ("efi_loader: Disable ANSI output for tests")
> introduced efi_console_set_ansi() to suppress ANSI escape sequences
> during unit tests. Extend this mechanism to be runtime-configurable via
> the 'no_ansi' U-Boot environment variable.
>
> When 'no_ansi' is set to 'yes', efi_console_set_ansi(false) is called
> at the start of efi_setup_console_size(). This prevents
> query_console_serial() from sending ANSI escape sequences to the
> terminal, using default 25x80 dimensions instead. This is useful for
> platforms where the serial console cannot handle ANSI queries.

I am fine with the patch, but the no_ansi is a bit misleading reading the code.
It really means don't use ANSI queries to detect the console.  So
before creating an ABI to the cmd line should we really call it
"no_ansi" or perhaps "no_detect" and in the future clean up the
variable names as well?



Thanks
/Ilias
>
> The variable is read using env_get_yesno() which accepts standard
> boolean values (yes/y/1/true/t).
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  lib/efi_loader/efi_console.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> index 068d1a0a7b74..737c2331b56c 100644
> --- a/lib/efi_loader/efi_console.c
> +++ b/lib/efi_loader/efi_console.c
> @@ -365,6 +365,9 @@ void efi_setup_console_size(void)
>         int rows = 25, cols = 80;
>         int ret = -ENODEV;
>
> +       if (env_get_yesno("no_ansi") == 1)
> +               efi_console_set_ansi(false);
> +
>         if (IS_ENABLED(CONFIG_VIDEO))
>                 ret = query_vidconsole(&rows, &cols);
>         if (ret) {
> --
> 2.43.0
>
> base-commit: f74b8c2aeaf8d14565abff8f6a59625c543169ee
> branch: debian-sent3
